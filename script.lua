--- Aerbon Weapons Control Script.
Options = { -- Options here
    TrackingPeriod = 400, -- Amount of frames to keep data for.
    DiscardTimer = 80, -- Amount of frames a target has been missing for at which we forget it.
    CoordinateMode = "World", -- What space to use for the coordinates of our target, one of "World", "Relative" or "Polar".
    AveragingTime = "Auto" -- How far back into the past must we look, in order to determine the future? X frames or "Auto".
}

-- These are libraries that i think will come in handy.
Buffer = { -- An array sorta thing usefull for keeping track of data and stuff over time.
    Fill = function(self, V) for i = 0, self.size - 1, 1 do self[i] = V end end, --Fills buffer self with V.
    Push = function(self, V) --Pushes V into buffer self, replacing the oldest previous element.
        self.cur_pos = (self.cur_pos + 1) % self.size
        self[self.cur_pos] = V
    end,
    Get = function(self, I) --Returns element index I of buffer self, where I=0 is the latest element to be added.
        I = Mathf.Clamp(I, 0, self.size - 1)
        I = (self.cur_pos + self.size - I) % self.size
        return self[I]
    end,
    Set = function(self, I, V) --Replaces element index I of buffer self, where I=0 is the latest element to be added.
        I = Mathf.Clamp(I, 0, self.size - 1)
        I = (self.cur_pos + self.size - I) % self.size
        self[I] = V
    end,
    cur_pos = 0,
    size = 1
}
-- Gonna put a fourier transform library here. I figure it will help with predicting sinusoidal movements.

-- Setup stuff.
TargetInfo = { -- We will store our targeting data here, in TargetInfo[UID].
    list = {}, -- Continuous list of the UIDs of all the targets we have stored, so we can iterate through them.
    size = 0, -- Number of targets in the list.
    Add = function(self, T)
        self.list[self.size] = T.Id
        self.size = self.size + 1
        self[T.Id] = {
            last_update = Time,
            position = Buffer
        }
        self[T.Id].position.size = Options.AveragingTime
        self[T.Id].position:Push(T.Position)
    end,
    Remove = function(self, Id)
        self[Id] = {}
        for i = 0, self.size - 1 do
            if self.list[i] == Id then
                for j = 0, self.size - i - 2, 1 do
                    self.list[i + j] = self.list[i + j + 1]
                end
            end
        end
        self.size = self.size - 1
    end
}

-- The almighty Update function!
function Update(I)
    Time = I:GetTime()
    --not gonna implement most of this until i know what i'm doing, but here's the gist of it.
    --Get the current targets of our AI
    for M = 0, I:GetNumberOfMainframes() - 1 do
        for T = 0, I:GetNumberOfTargets(M) - 1 do
            --For each one, check if it is already in our target list.
            --If yes, update it.
            --If not, add it to the list.
        end
    end
    --Check what weapons we have on the ship.
    --Calculate the future positions of each target for each weapon's time to hit.
    --Compare the predictions we made X frames ago to where the targets are now.
    --Calculate the expected hit rate of each weapon for each enemy, given our simulated accuracy.
    --Assign weapons to each target based on their characteristics and our expected accuracy.
    --Aim the guns, fire the guns, fire the missiles, aim the missiles.
    --Do prediction / interpolation or something on the targets that we have not seen this frame.
    --Remove the targets that we have not seen for X frames.
end