Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EEBCAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 15:01:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 288C240661;
	Wed, 24 Sep 2025 17:01:11 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id A706F4065E
 for <dev@dpdk.org>; Wed, 24 Sep 2025 17:01:09 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id 0C1191D0004E;
 Wed, 24 Sep 2025 11:01:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Wed, 24 Sep 2025 11:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758726068;
 x=1758812468; bh=WEAAH6xeSBlfa3RV1r/eIlbtXBzXreWxrPFvPa6QtxI=; b=
 nC1vQ9ZFpGTO62nU2g2RuWYzgC01vj61wSEHN3OzfwhHAMXZXGANO4sqt0bWOJE0
 VDJ0cNmtpn0eQSpeftUSpO8Xnf80q9k2f+kFZxyvhpRgQnZj2IzByPC044jden4V
 bRAOgLwBkgsCTcloBE/NIvzZd4vWMiuVoVlQMVVWC6wOcdQhzlMUGHxF+1CfOKtM
 TXB57UVeNhNHV3S0QIOM89FzzoPcorLNF51K1Jm/iIAqO+SPq5bkP1HvynxjVI7I
 BIWHwpcyXaQ2jVEk/CfVpRsXMYVxlTDH3Ho6oU4cAT72QryPxhq+xzK1GCNmiOXw
 7OsJrcQ8aRsk0yfvNYsnmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758726068; x=
 1758812468; bh=WEAAH6xeSBlfa3RV1r/eIlbtXBzXreWxrPFvPa6QtxI=; b=a
 Xfq7R/aDh5zhxTZT4b4fFq5Am2FL0D11VN8ThETtrOgyNKqpVOyC3hssUuJXjib1
 P2JNmDIICBUPAJkxOT7/TvgLum639q32HgBP3gEqNVK4m32D1cG7RxtoCx1yPKSc
 SeNsLjo1zDD28K0y+w7NSWHcdDGu+5wAJ/y3ZN5Y3ERp39SAajnfhUtGO3wmkoE4
 p2mS3xkwDV814fKL6JZ2rUQe7Co4h4MDV9c1AG/nCgTNjyfX7wvygcfNw8ObTVH3
 ftqg3GYRUtv2OAcGNVPGj4k7KmkutIrgIAHpbxdIGZRsZrsyqOhX5hd0jINzCfDZ
 ZlBPLrhQc26Pp+blPOKIg==
X-ME-Sender: <xms:tAfUaECrbomyjyUGliNjBXIwXiO4Rmz_MbmpX9JpAZcDekvN644-YQ>
 <xme:tAfUaNgqKbT8Mz7uqMth-HnCjc_YC9YlCRuzfn65FXQL9ZD1Beq-pFFpcniFOXKUy
 482-jx4s0cXx6DM6mw08PwQ9wgqkTzruh0FP2MK0vIVjFuuVYTn>
X-ME-Received: <xmr:tAfUaMlbD-8jCmEvjkJzDGVNmsyPa0ZrMg367uizirBgnBrgt_XK6TUdx5EmwIY8Tjyc_ss4xNBhSm44X7vZfzEOMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeeludcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepgedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htoheprhhorhgvthiilhgrsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghp
 thhtohepmhgrgihimhgvrdgtohhquhgvlhhinhesrhgvughhrghtrdgtohhmpdhrtghpth
 htoheptghhvghnsghogiesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:tAfUaJq4bFqCotDGzzMqEv0_74ckcg6mtmqIkb3553jwPKGw2fWhCQ>
 <xmx:tAfUaFErXpW7bR0L_DL_90RdkhIy2OYbgV12b9HPWsLEnxltu2uSaQ>
 <xmx:tAfUaFyFRa9fOz8TtdgoKLZ08JE8RrSGQCmotIdMeyRugPhMCbQbSA>
 <xmx:tAfUaKqDJVftkrCUATMnSk5yLc1WJaMA_4Emz3BLuXWuxBIY3xK0Vw>
 <xmx:tAfUaJEUEkt4w9icL4e0yQp8BUim1bUtD4aNMbL2M5hGWynXfmxZ2KQ1>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 11:01:07 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>
Subject: Re: [PATCH] lib: fix include guards
Date: Wed, 24 Sep 2025 17:01:06 +0200
Message-ID: <2906565.jZfb76A358@thomas>
In-Reply-To: <20250918121751.1552714-1-thomas@monjalon.net>
References: <20250918121751.1552714-1-thomas@monjalon.net>
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

18/09/2025 14:17, Thomas Monjalon:
> Fix the namespace of include guards by prefixing with "RTE",
> and add a missing include guard in rte_eal_paging.h.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

These are minor changes.

Applied



