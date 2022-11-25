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
-- Gonna put a fourier transform library here. I figure it will help with predicting sinusoidal movements.

-- The almighty Update function!
function Update(I)
    --not gonna implement any of this until i know what i'm doing, but here's the gist of it.
    --Get the current targets of our AI
    --For each one, check if it is already in our target list.
    --If yes, update it.
    --If not, add it to the list.
    --Check what weapons we have on the ship.
    --Calculate the future positions of each target for each weapon's time to hit.
    --Compare the predictions we made X frames ago to where the targets are now.
    --Calculate the expected hit rate of each weapon for each enemy, given our simulated accuracy.
    --Assign weapons to each target based on their characteristics and our expected accuracy.
    --Aim the guns, fire the guns, fire the missiles, aim the missiles.
    --Do prediction / interpolation or something on the targets that we have not seen this frame.
    --Remove the targets that we have not seen for X frames.
end