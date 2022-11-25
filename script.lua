-- Aerbon Weapons Control Script.
Options = { -- Options here
    TrackingPeriod = 400 -- Amount of frames to keep data for.
}

-- These are libraries that i think will come in handy.
Buffer =
{ -- An array sorta thing usefull for keeping track of data and stuff over time.
    New = function(S) return {cur_pos = 0, size = S} end, --Returns an empty buffer.
    Fill = function(B, V) for i = 0, B.size - 1, 1 do B[i] = V end end, --Fills the provided buffer B with V.
    Push = function(B, V) --Pushes V into buffer B, replacing the oldest previous element.
        B.cur_pos = (B.cur_pos + 1) % B.size
        B[B.cur_pos] = V
    end,
    Get = function(B, I) --Returns element index I of buffer B, where I=0 is the latest element to be added.
        I = Mathf.Clamp(I, 0, B.size - 1)
        I = (B.cur_pos + B.size - I) % B.size
        return B[I]
    end,
    Set = function(B, I, V) --Replaces element index I of buffer B, where I=0 is the latest element to be added.
        I = Mathf.Clamp(I, 0, B.size - 1)
        I = (B.cur_pos + B.size - I) % B.size
        B[I] = V
    end
}
