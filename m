Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2BEF3381E
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 09:02:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 144FA402D1;
	Tue, 17 Mar 2026 10:02:41 +0100 (CET)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 6A1BA40270;
 Tue, 17 Mar 2026 10:02:39 +0100 (CET)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E87D814001E9;
 Tue, 17 Mar 2026 05:02:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Tue, 17 Mar 2026 05:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773738158;
 x=1773824558; bh=/djoA221ZkIiMl2bZOSXUAnfwDEAGBDeTEC9ACUDscY=; b=
 Dp2UPdAyxmXAw4J6efyhYMupLD2MzDkrb5mwQuDJ2LmgrXYdpGwkHaXJvN6Gnvnt
 gkKHuRJuySUAe6vaAWi8e3UMg+JiHF5NTUgqKEPc3edHtqtkumBiyWhOBXkCbHaG
 TL1ea8WO5EkDi67Mn/+twSUkRRZt7giccKUQ/Y597VXH8LT2CWELXpoQUetIGBqI
 ERnYYOR7ELzmHkDEEO6xC6LoM9Vd1qWz3/92v8mfaeHnDlgp0J576963XBYi31Sf
 fpp5LUE6YPeq3nPxvOoZZTBlWIMCHEIAUsepGevTz4YdA0824xeqiPfP9lT1QLRo
 9V9RJ64ZAXXPeMyvWpb1/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773738158; x=
 1773824558; bh=/djoA221ZkIiMl2bZOSXUAnfwDEAGBDeTEC9ACUDscY=; b=y
 27DkxZbGfVsSQfME/gVfI9ycN+eeqbZxGDqHdonMPuoKgjhqslBiV+nuSnE9gwE+
 ycwA9YmPk7WOxesOsQza5hqC5tQsoV8VVvlgHpp+VvDzg7uTh88MclRUOrvTvVoo
 2ADV/1Duta2Yoe0mSaZAMR03K1lGnseqAjVzTUgJw0g1DrUtpZS1qoaiaUtPIcmX
 KDWZ1ESt3bSLJQKZfS1wzNP7+0vqlHGo0alK2Auv4LWWpYNn6fiG0LQSNvzmpeCP
 PbAcononjqa/MaLfjCcYY3HVcUAMj+okKhh9vLODqET59nxOf4HdFcHLm5d77JJL
 /LrZ7/0O9i7H9rA37HpXg==
X-ME-Sender: <xms:rhi5aepSFBjAS4rzgo4bCzfmeeS45hOPT4kWg-6_GBe8tvPGXajfIQ>
 <xme:rhi5aUTlt1Jr5Jc15rY5eWqH2jGfpEQ7d7Jn6WqI7t82VRm2OMx_tNz38iGyjLawZ
 LGticvCRpUr-CGVhu3c8ABLc6L7eTCn6MfRR-6HI8KVFY3w6HHm3Ow>
X-ME-Received: <xmr:rhi5aQ2xYFF9OjCLO7USgDEbIq5AasBGRTEhM8Skvp-PRqafI0jOwGl0vYUZd0nSbpF165mwTqLVhKNjBT-gGftvlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddtkeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopegthhgrihhtrghnhigrsggrsghugidrthgr
 lhhluhhrihesihhnthgvlhdrtghomhdprhgtphhtthhopehfvghnghgthhgvnhhgfigvnh
 eshhhurgifvghirdgtohhmpdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhrghdp
 rhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopegsrhhutggvrdhrih
 gthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopegrmhgrnhdruggvvghp
 rdhsihhnghhhsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhhrghiqhdrfigrnhhise
 hinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:rhi5aYDOxZZYymbvPz9sA7nHEcyhvQO-yDHvxpeAKSUYi6yA2llN7w>
 <xmx:rhi5aUgKqbyky4qdrEJ4WHg4fA-yWE9JGzr5Lr9GS4-du2MJS4SV6Q>
 <xmx:rhi5aSOf1EVYNyaywmvXdqKW4JNzhg5GVYqcmsv5GkosvnUuqIeG-A>
 <xmx:rhi5ac8xfbG9aGZCKY_3HIMpssYvu-CME5_ZuMN0SXGy9pF9JBV-bw>
 <xmx:rhi5acXCAKE2P6_DyBFOkRK1t25l3Y_l5AznZgRl2qm6xIw-6mLnU2Mr>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 05:02:37 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: stephen@networkplumber.org,
 Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Cc: stable@dpdk.org, dev@dpdk.org, bruce.richardson@intel.com,
 aman.deep.singh@intel.com, shaiq.wani@intel.com
Subject: Re: [PATCH v3] app/testpmd: fix DCB forwarding TC mask and queue guard
Date: Tue, 17 Mar 2026 10:02:36 +0100
Message-ID: <14422376.RDIVbhacDa@thomas>
In-Reply-To: <5157955.0VBMTVartN@thomas>
References: <20260311083751.1107404-1-chaitanyababux.talluri@intel.com>
 <20260316062118.1508009-1-chaitanyababux.talluri@intel.com>
 <5157955.0VBMTVartN@thomas>
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

17/03/2026 09:57, Thomas Monjalon:
> 16/03/2026 07:21, Talluri Chaitanyababu:
> > Update forwarding TC mask based on configured traffic classes to properly
> > handle both 4 TC and 8 TC modes. The bitmask calculation (1u << nb_tcs) - 1
> > correctly creates masks for all available traffic classes (0xF for 4 TCs,
> > 0xFF for 8 TCs).
> 
> I don't know why this patch was merged in next-net without any review.
> It has been pulled in main yesterday, sorry for that.
> You'll need to make another patch to fix after the complete review.
> 
> Stephen, please don't merge too fast if no review.

After another thought, I've dropped it from main,
so you can continue with a v4 as usual.


