local f = CreateFrame("FRAME")

local function OnUpdate(self)
	if not self.enableAt then return end
	local t = GetTime()
	if t < self.enableAt then
		TradeFrameTradeButton:Disable()
		TradeFrameTradeButton:SetText(string.format("%.1fs", self.enableAt - t))
		return
	end
	self.enableAt = nil
	TradeFrameTradeButton:Enable()
	TradeFrameTradeButton:SetText("Trade")
	self:SetScript("OnUpdate", nil)
end

f:RegisterEvent("TRADE_TARGET_ITEM_CHANGED")
f:RegisterEvent("TRADE_MONEY_CHANGED")
f:SetScript("OnEvent", function(self)
	TradeFrameTradeButton:Disable()
	self.enableAt = GetTime() + 2
	OnUpdate(self)
	self:SetScript("OnUpdate", OnUpdate)
end)
