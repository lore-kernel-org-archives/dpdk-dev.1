Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE811CD37B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 08:06:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4616402BD;
	Mon, 11 May 2026 10:06:56 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id 883AC402BC
 for <dev@dpdk.org>; Mon, 11 May 2026 10:06:55 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id BBAC3EC00B8;
 Mon, 11 May 2026 04:06:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Mon, 11 May 2026 04:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1778486814;
 x=1778573214; bh=VTGArmfYw8UjJg39WowKFxwI0DIoflLhFZ8zG8ivq+o=; b=
 OG2SfpWlGcEBos8ks9wNVj9lDyZngZeTJwHha498bKx5f79C7Zrl7mpr0A8qYP5r
 A2aJBl1dg4FSBeckkIrTRBLPgldtckOC2Imm0seWpuIfGuyGadIdydmiiLBTgE30
 mAJlaV4MGriHo6EchpntfSuKc4ygZLFwEnKv7Zm0Euu07ElBY+ebqAePFuUbzuub
 hwjqHTIA6ymSClkO1YMxpDmx5YmFpdRZFcpmgB5mAGFJocDCy9oSP/d0mcZVWws9
 YzHVjoRayVCVbhsQrzYdyDZmrpV3zm2PQ+aaXr2T+GdnYidEpm67oLbuha4FkINC
 QcP21RUk4k9YMwR51T+AAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778486814; x=
 1778573214; bh=VTGArmfYw8UjJg39WowKFxwI0DIoflLhFZ8zG8ivq+o=; b=C
 IgNGDsqCZewtlK3lhYzbP7Wk2kgOMbDcq8FzL9oztgDj0t6oIR5PYmwiYj2TXv97
 T5asoDbmFTrAyyDzexm/nF91jnD2idDlkTefqvXVm9V5RAfnB6lGlmXhr8MZFyUD
 qeZX81/2hR03HNwrl0eKwSR7K/kjrdHP+8Cb7gSslAa0Hhq4NxQyWdIe6hOGlOHj
 VC64y3rUl58fnoGhP6beWiNYhaeQ86T/u1aoS6RZyuDbFmaqS+rJWGipwFNDBVR7
 lo1wIUHdBCgzpFgtL9AbK9JW7dTjtzUyiMLYesZ62OPmeIWtH6IDYLLfqwGXz6vG
 nLR52YPnBD/8NKKjnqMKA==
X-ME-Sender: <xms:Ho4BanI_SSWJlQkHeK3TH_Np6rwuMMSWcc_fgj5phDPKXEbcDGOqEw>
 <xme:Ho4BarTw2RLXMVWPSrH2Z7mV4IbrCaadqhNA-Uby-Ez4-nMBoiBOusawMC-Gvm_hK
 d90apg_NYNHgtcJEzMiTPS4tfHEGf-W5M6Efvc8iiX2cjSo7dy3Eg>
X-ME-Received: <xmr:Ho4Bano-0EBl1RQvrHg9K5DD6rfSYKNm96Vc6Ryudvi5_9lRyeHN--2BhPvcrc82w2c41kSdsQ2Q-FcLRDEyL3Xy5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekgeeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehrohhsvghnrdiguhesrghlthgvrhgrrdgtohhmpdhrtghpthhtohepjhhohhhnrd
 hmtghnrghmrghrrgesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:Ho4Baor2cni-j0vzFBfy8HeFRfJTsgFc6yWhwGSOIlLr2sO4Y7JFRQ>
 <xmx:Ho4BapMClfMthmoT2cAq3NplQDkSnP46ZvxtGjtoukcYYIybGFMOPg>
 <xmx:Ho4Bapw4Zkm0zZimBZUTxuoUZtlYk7sAnmgREfokFBY5ZL9I7RRwbQ>
 <xmx:Ho4Bait4czwkR-3v--N83mjggGhUhcOervlIggeC6yfQJGXuD4ifsQ>
 <xmx:Ho4Baol5p8RqDNS1usiBW8DVaAqlSNASxPD7gqSilXdyypJancWkBMqZ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 04:06:53 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 "Xu, Weihua  (Altera Corp)" <rosen.xu@altera.com>,
 "Mcnamara, John" <john.mcnamara@intel.com>
Subject: Re: [PATCH] raw/ifpga: target main tree not next-net-intel
Date: Mon, 11 May 2026 10:06:51 +0200
Message-ID: <pbaaRcGHS4umNjAflBde9w@monjalon.net>
In-Reply-To: <CY5PR11MB63183599D36796F0202F45A2FC2D2@CY5PR11MB6318.namprd11.prod.outlook.com>
References: <20260409140023.462128-1-bruce.richardson@intel.com>
 <CY5PR11MB63183599D36796F0202F45A2FC2D2@CY5PR11MB6318.namprd11.prod.outlook.com>
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

> From: Bruce Richardson <bruce.richardson@intel.com>
> 
> The raw/ifpga driver does not belong in the next-net-intel tree because:
> a) it's not a "net" driver
> b) it's now maintained by Altera
> 
> So remove the line in MAINTAINERS targeting patches for that driver at
> next-net-intel tree.
> 
> Acked-by: John McNamara <john.mcnamara@intel.com>

Applied, thanks.


