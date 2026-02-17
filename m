Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDACCE909D9
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 16:39:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A60DE40261;
	Tue, 17 Feb 2026 17:39:58 +0100 (CET)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id CF13D400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 17:39:56 +0100 (CET)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 3F5C9EC0569;
 Tue, 17 Feb 2026 11:39:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Tue, 17 Feb 2026 11:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1771346396;
 x=1771432796; bh=7fxOkpQlJPQVev+nHjrvsKroCSwD75g1ISQZMoL3xmQ=; b=
 HCOev2ii8f56vnE+kp2U50hWV2yHp/K4Xh+0qJCjhnrJzpre6K3ilTBT2880Wy/m
 x2cdtss94A63EamAr//GM9R19f/mHwfxdiuya3bpVu3FwRLwObgBf0gzEE4DEsvJ
 4sKr/Rb8iCpPLucSN/xDM8RrjGMrFQqWuKJ9iKSVENqrFQ3U2KFq8HQP130PAKOc
 Euxg3LBxDIUy+MflVApQaYyAs8gkZMQMY9DzDco9FSoUGQ8zsE1CG63Mg+z6Djd8
 ADEY/gWkAiJ1KRgNt/GFKiM0yLw2DUGFbUlbCDJAEqkLfyqhQ5FnMCLptsk4yUzH
 AS+EIs9rm91RNs/raFm6Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771346396; x=
 1771432796; bh=7fxOkpQlJPQVev+nHjrvsKroCSwD75g1ISQZMoL3xmQ=; b=j
 54vhRAz5iRnj5YPCPOpHbVsu6hFlNiY/f9Ndxluh551LwV471VdmNQPdPgTqN3lb
 94USpO6JWxPj4Ter4L5iyD2L0JlIG5gLGqjyTbSIEKiZJQDbCYk4d2bLEazHFdQp
 /QviKOXII465HVKv94x6/C6udtGS0OP7WawHX9K43qo95LF1gByZOcxxLxANDSRo
 RaXCvzqa4mCzrTqeKaNqr8JpS25IS8meM7uZ6ZqEIGB6iwDY6ywLIosWSikQUfDJ
 qw4yf7NtLvhyE2EoadGp4iNgc0j7xy3lUphPzJ1XZx6lg2HTwnbWqFy6J8WlW2DY
 YHmIuT3ND56TxFioRzbJg==
X-ME-Sender: <xms:25mUaReSHgyaFrpjakJdvmkxNzGIKT86eC-DBvJOtgEOKghX6pUGTA>
 <xme:25mUabjKIwEKAHNBcoGNrTI3jx6QFGHqcU6WI7dSdM8SZ0rLzhY_wTu7kbjcfoVIY
 EX483tpkme9_wsrcCFXEs2Zn10of_mxj8jRF5puY4A03tyZB727sXg>
X-ME-Received: <xmr:25mUadSp_SRbveu4UuENCSP71q45NwCugazLU2ls1JGHEHi3xpS8Kf3caAxunDWcpDtYQCOHVIxLNsua41nR9svLsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtvdeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:25mUacxmmeZQDC10NrvHjvsno_td9vwn5I_G8rpPOYeZS5POUq9DnQ>
 <xmx:25mUaQcDBeJl__rVqZtApJpoa9afj848wphfE6E0fE8T8bpdjX8HDg>
 <xmx:25mUaQLdKMFUmtyGoG22a-i5k7Uhg_vJYV5J4Beyjy-TSfPgLcbUsw>
 <xmx:25mUaZFjlFjRsu6DH1iqLyrZ45dCwCE2d4x0BTES_kVxtXrsr5zfeA>
 <xmx:3JmUaU-QP3yjWxukj79Cs61KGAEhHpq9xMp7MTHjY8KArCWzLJaU8Odt>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 11:39:55 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v8 0/8] pcapng: fixes and improvements
Date: Tue, 17 Feb 2026 17:39:53 +0100
Message-ID: <25691699.yPRShPnUSN@thomas>
In-Reply-To: <20260216214311.717492-1-stephen@networkplumber.org>
References: <20260126210615.175816-1-stephen@networkplumber.org>
 <20260216214311.717492-1-stephen@networkplumber.org>
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

16/02/2026 22:37, Stephen Hemminger:
> Fix string handling in the pcapng library and improve test coverage.
> 
> The pcapng format uses 16-bit length fields for option data, but the
> library did not validate input lengths and used fixed-size stack
> buffers that could overflow with large strings.
> 
> Patches 1-4 add string validation, dynamic allocation, and return
> value documentation. Existing return value conventions are preserved
> to avoid an ABI break.
> 
> Patch 5 chains an additional mbuf segment when a comment exceeds
> tailroom instead of dropping the packet.
> 
> Patch 6 replaces per-packet timestamp divisions with a precomputed
> reciprocal multiply-shift.
> 
> Patches 7-8 improve test coverage and fix the build dependency on
> the null PMD.

Applied, thanks.



