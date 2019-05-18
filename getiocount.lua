-- Chisel description
description = "counts how many times the specified system call has been called"
short_description = "syscall count"
category = "misc"

-- Chisel argument list
args = 
{
	{
		name = "category", 
		description = "the category of the system call to count", 
		argtype = "string"
	},
}

-- Argument notification callback
function on_set_arg(name, val)
	syscallname = val
	return true
end

-- Initialization callback
function on_init()
	-- Request the fileds that we need
	fcat = chisel.request_field("evt.category")
	fnam = chisel.request_field("fd.name")
	
	-- set the filter
	chisel.set_filter("evt.category=" .. syscallname .. " and fd.name contains /dev/dri/card0")
	
	return true
end

count = 0

-- Event parsing callback
function on_event()
	print(evt.field(fnam))
	count = count + 1
	return true
end

-- End of capture callback
function on_capture_end()
	print(syscallname .. " has been called " .. count .. " times")
	return true
end
