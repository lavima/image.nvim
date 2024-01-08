local document = require("image/utils/document")
local utils = require("image/utils")

local image_pattern = '^!image='
return document.create_document_integration({
  default_options = {
    clear_in_insert_mode = false,
    download_remote_images = true,
    only_render_image_at_cursor = false,
    filetypes = { "output" },
  },
  query_buffer_images = function(buffer)
    local buf = buffer or vim.api.nvim_get_current_buf()
    local images = {}
		buffer_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
		for i,line in ipairs(buffer_lines) do
			if line.find(line, image_pattern) ~= nil then
				table.insert(images, { range = {start_row=i, start_col=1, end_row=i, end_col=#line}, url=string.sub(line, 8) })
			end
		end
		-- utils.debug("num images returned " .. #images) 
		return images
	end
})
