Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90296CFD372
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 01:36:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F4C040697;
	Tue, 25 Nov 2025 02:36:44 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 36A31402A1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 02:36:43 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id CA8151400073;
 Mon, 24 Nov 2025 20:36:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 24 Nov 2025 20:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1764034602;
 x=1764121002; bh=FlZ8IkhEgaQzytue7l991H4YQaC+mf1ttC9i6tLpXAE=; b=
 dpo/GaY0gKJmeI0Xzt/56nF+ThYT1NFWCd5sj3SVOOJqigFiAvP6CJ9X+Cjg0T/7
 qCrJmagMThqtLbHUddU2clkLLwDNmsDv2/mSw3YGI6G1PsgluGlSzoDTrLT9iVlk
 XIMeZTg2Y7M2fK2Es7AxrilNsG4VwTFsNKbNZx1rm5fr78JUiW1pqQssBoccFZ+6
 88/OvruJFYf3aWtigSVrk0xJvY/hpiGMXpjy8agLKAXLFQMSG5C1TYg4MkEhZDfw
 aG9U7/9d9PP7I7GTTSXfyY5Z3y3Ia5Z16OeLhy2f4cJ7WMbucGtDyAfFmNakMqYx
 d0xo9DQHJzyNmkLPX4Hpeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764034602; x=
 1764121002; bh=FlZ8IkhEgaQzytue7l991H4YQaC+mf1ttC9i6tLpXAE=; b=R
 tZDhK4bNOg1Nu8K4Wm5kYB+34+5Me7StnJ451uctlhT0djkj+9JMB1mJrIC/djCC
 CUP8o06G3NG6Nc1er1BX6yIqpOpDfBMv4IaPEDBzDiNIqULTBuXxiGYQ/0DNOW/7
 IfFOXo0ozJmMACc2XYzU2n0l2YM6yks7Ip9y8GgBrjttiqd85jCaLraYr+R/PcS4
 gdRF5tElOZm3Pu16pEXAzqNHzZ88JHWY+a57QWRxt5QnwS98cqUm7IhIcZ3z32Cy
 sTYIuubboiC6kOy2npu/4g59W1P8nYukEJEZKQSzuXu/JN9+Yqg8EeYRFIMfv9I+
 RZJs6wvmrRMGSaYChg/AQ==
X-ME-Sender: <xms:KgglaRQh5j3hzo7JlFFpoNAhaAHDV4MBfD2wl65-zUwuRwMbFi-FxA>
 <xme:KgglaXH6zrT51MzNgUrjavnuESUW4tCo2xJND_Zuuqed0b-wyWvrHlXZTM6BJyHDG
 j6vjEQE9oM1kFNG1yrZRgpzrWVmnUOGA_WMMYnQGl2LPZssvK7Gsw>
X-ME-Received: <xmr:KgglaZkxTd79xOj6yyahvuRusiXdRThDAsj07hiFLBoDWVT-fm4_U2YM_38YbmIkg3uI0083PiT8SCr2AYVYZFZDTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedtudekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehrrghslhgrnhgusehnvhhiughirgdrtg
 homhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:Kgglaa0zDUGbVAenr14O40IJZnLjfQHWBjq9XW5wdzC6SSeCTjOCYQ>
 <xmx:KggladRk0WwbwcKNmH_-z6A4kplYdtpWh1d1f_jmnspjapD0D7lBqg>
 <xmx:KgglaUuvCGkyxV4DMjJb5Z5aNoV5d2GAJ0jwGsg3V3e3FbuwANF86g>
 <xmx:KgglaaaCGhNacc4ITh5niPoZW3h_a2a2lewRcPkss1Qor3QUj6DmgQ>
 <xmx:KgglacRSzfACOUY4BmHtwR13fxrWJK49nZOeQHzBtr5NSVXFzUZNznrf>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 20:36:41 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Raslan Darawsheh <rasland@nvidia.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc: add tested platforms with NVIDIA NICs
Date: Tue, 25 Nov 2025 02:36:40 +0100
Message-ID: <2805356.8hzESeGDPO@thomas>
In-Reply-To: <20251120112526.75674-1-rasland@nvidia.com>
References: <20251120112526.75674-1-rasland@nvidia.com>
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

20/11/2025 12:25, Raslan Darawsheh:
> Add tested platforms with NVIDIA NICs to the 25.11 release notes.
> 
> Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>

Applied, thanks.



