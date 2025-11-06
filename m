Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D16BCCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 11:11:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBC3440A84;
	Thu,  6 Nov 2025 12:11:24 +0100 (CET)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 18B514013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 12:11:23 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A470914000D1;
 Thu,  6 Nov 2025 06:11:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 06 Nov 2025 06:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762427482;
 x=1762513882; bh=ql3o0y8RfFJvIHhBlOEUg1Xh8l7lRGOf67qPMnj3A4E=; b=
 k0KcOCSGPpOItWoSOw/sLSwjgs+PNWSurNwFLiCfKE+7RqMse52lG3JZBfi3fyi1
 zXyfBOU81oYM/Nm73LvUXPGOiY4vmUr++bicqf6aRxvY2amwEheMAIo2SljBJ6JG
 P42EPFmPNjBiOuBQvafwze2LbAxfXuKyzs1KQiGYhwsiosv31lEGFlOel4svDO1b
 lE01IqrzC/f/Jl3lk9yA/UOWN25zwuH52fuAEnaH0pSGjxGngTD7f2h0pSP8b9e2
 65mnc93O0tK+XUgBWQGwIlq6/U/uxio6M/TWcS6kSMDMGBvp7EeG87ZVe9HqZdVP
 Tb0W7FbAXTQvsJJrKVlnow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762427482; x=
 1762513882; bh=ql3o0y8RfFJvIHhBlOEUg1Xh8l7lRGOf67qPMnj3A4E=; b=A
 KhG44U3yF6VMmycIwO3RUGk81cj1XNHaGIEQefeic9AheI6BOVRdFMntBcTy1K6E
 PmBUijA950BbTnuulShZd3IJNz0/fBaa8k6ei/Zovl2d0hG/2ip0DYbSZbBLEWsy
 vROfE3NZfdPalEpDlKkguh1PSSUbCn+T+wllKvjR9fYVdXAp45DRPnE7zQ2zuzkK
 204dbPaJjOUrui9vhanobsS7wHFBHLD4Eovo8Oqfn59cq3bD4Y/MSLthNHMxh+9F
 KuXJyHuxb3kyYChbrck0MidvHiuz3fhHJj7iC1UAcIpaWksOYz9/EL413OgoKH/y
 FAWWXI2uJXCeNYclKNaMQ==
X-ME-Sender: <xms:WoIMaWwl6XwpdEDwpMXjiesHMuUWQQly6XibgTqefOHvCPl1HckkZg>
 <xme:WoIMaenjHpD950getZXrD_ivt4GOPQNQA3vErQov-VFktv5aaUte3NKDIby_7PNaj
 i2ZFtrH0oTbSQfbh9AaDU4lnE4JG-uj5p-iqUKA8EWF0p5N2v49iRo>
X-ME-Received: <xmr:WoIMabFptVUqfzcMTLIcc6tg5cStYejiAojDHGdQUyM68h4-rGR207zZOJTuYipT7Xr8GMG5-LvrXOpHlsebQASLiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeiiedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehrrghslhgrnhgusehnvhhiughirgdrtg
 homhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:WoIMaeWl8kBoUZj0exMPallkF8xKwWDOl2sSh9JcV3uqAzu-blbhXA>
 <xmx:WoIMaaxWwWFAY1Nan-wlNEPgY2gn8BIlq_BpQfc4RPrQz98Os6_sqA>
 <xmx:WoIMaUO4mom8seavzLEOcnzyN9KcVPfnrQ3D_aXu1TbaegLrsjqi2A>
 <xmx:WoIMaT4k93kClOcfIM-PNikqFfTorKp-dvgeSMrIoPe0eCMZUJ-XcA>
 <xmx:WoIMaSnjriikK-ZR_0zj6wrDPgkkKxnvgt0jlFwdSvrGCZOD0NU46jYE>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 06:11:21 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Raslan Darawsheh <rasland@nvidia.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] drivers: add ConnectX-9 device ID
Date: Thu, 06 Nov 2025 12:11:20 +0100
Message-ID: <7017699.axxuzLQ8MY@thomas>
In-Reply-To: <20251105154418.99211-1-rasland@nvidia.com>
References: <20251105154418.99211-1-rasland@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

05/11/2025 16:44, Raslan Darawsheh:
> This adds the ConnectX-9 device id to the list of
> supported Nvidia devices that run the MLX5 PMDs.
> The device is still in development stage.
> 
> Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>

Applied with mention of SuperNIC, thanks.



