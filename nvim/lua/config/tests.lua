-- Function to run RSpec for the current file or line
function RunRSpec(current_line)
	local file_path = vim.fn.expand("%") -- Get the current file path
	local command = "bundle exec rspec " .. file_path -- Base command to run RSpec on the file

	-- If current_line is true, append the line number to run a specific test
	if current_line then
		local line_num = vim.fn.line(".") -- Get the current line number
		command = command .. ":" .. line_num
	end

	print("Running command: " .. command)
	-- Run the command in a terminal buffer
	vim.cmd("split term://" .. "sh -c '" .. command .. "'")
end

-- Function to extract the Go module path from go.mod
function ExtractGoModulePath()
	local go_mod_path = vim.fn.findfile("go.mod", vim.fn.expand("%:p:h") .. ";")
	if go_mod_path == "" then
		print("go.mod not found")
		return nil
	end

	for line in io.lines(go_mod_path) do
		if line:match("^module") then
			return line:match("^module%s+(.*)")
		end
	end

	return nil
end

-- Function to run go test with the dynamically determined module path
function RunGoTest(current_function)
	local module_path = ExtractGoModulePath()
	if module_path == nil then
		return
	end

	local relative_path = vim.fn.expand("%:h"):gsub(vim.fn.getcwd(), "")
	local full_path = module_path .. "/" .. relative_path
	local command = "go test -count=1 " .. full_path -- Base command to run go test on the package

	-- If current_function is true, try to find a test function near the current line
	if current_function then
		local line_num = vim.fn.line(".")
		local pattern = "^func (Test[^ (]+)"
		local test_name = nil

		-- Search for a test function name in the current buffer
		for i = line_num, 1, -1 do
			local line = vim.fn.getline(i)
			if line:match(pattern) then
				test_name = line:match(pattern)
				break
			end
		end

		-- If a test function name is found, append it to the command
		if test_name then
			command = command .. " -run '^" .. test_name .. "$'"
		end
	end

	print("Running command: " .. command)
	-- Run the command in a terminal buffer
	vim.cmd("split term://" .. "sh -c'" .. command .. "'")
end

-- Function to run tests based on file type
function RunTests(current_line)
	local file_extension = vim.fn.expand("%:e") -- Get the current file extension

	if file_extension == "rb" then
		-- If the file is a Ruby file, run RSpec
		RunRSpec(current_line)
	elseif file_extension == "go" then
		-- If the file is a Go file, run Go test
		RunGoTest(current_line)
	else
		print("No test runner configured for ." .. file_extension .. " files.")
	end
end
