Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F24C87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 14:42:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCF7D40DDB;
	Mon, 11 Aug 2025 16:42:41 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 11E1C402AC
 for <dev@dpdk.org>; Mon, 11 Aug 2025 16:42:41 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 758A8EC00A5;
 Mon, 11 Aug 2025 10:42:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 11 Aug 2025 10:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1754923360;
 x=1755009760; bh=njs4oS30dPYy9rN9Xn9ROkaC1g0OiTZqdoVSDyyid8A=; b=
 Cx7EHPJJQvaJXnihEZvgS8YsOmKmc4Bd20vsG+SSps0A7DmBIHPKSNy5OxYqsSDS
 BG0R3i+w8u23eve0+TZEVsqQMp1BQy9GkUJTQxX+W2yXSfwTBuWVTCGzxksQOfvC
 S7POZthKiAtTvpNBzTYyswI0wBC7YHV3zbjRp7IS4pmtqQfBCcoZHZ7Ky3y9WHjZ
 XL4shiPREWiRlLcjQ/7l+BAdBC5HmaoylgPmZ4X1TaK32j1sUqDoAsil1HJ7jOeP
 LUPRe49oro3cWBjMzlUi+t+y/0xPvtybWV/XyOd73n9wX0Y10XP1vf6L6k60wE0+
 i/uPYXn3EokPgASej3Z0lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754923360; x=
 1755009760; bh=njs4oS30dPYy9rN9Xn9ROkaC1g0OiTZqdoVSDyyid8A=; b=D
 qs/jkxW40ID/qHX8TyWGIQBuCnsJs7ZcxEo+3emStaQ82dB7u7uvg3ZYSajDL7Rc
 0Lh3bEl22My62K9aI3ZiPy+GIwNdBuQj1tmGFG0h7Wbtft6YaKNg3vAvoMMs/6qa
 zXpKF1L2/u/sNmOSyRHO7FUgysZqN1S+SF19a0MaU65wnoFyodIyqu2XL0IDq2kg
 Nrk5uDXZAtbZzUfgkgMDqwuzyqe7cK0o38KPcyLU1uUPnkDC0yuJJ5PW0bKpgu5E
 LVJJ6qAHzUjzs7Gfr0gkmEQg1AKeZYjFFP2j4RnM4z0G9/vV3SqlCeYo1EqZpWnV
 QNBiEG8XwGQnqXiEEzplg==
X-ME-Sender: <xms:XwGaaNSt6Zzs9S6vrV5_gSqQuShWWzUcNPuzRRVzojfRAoC_2dmLpg>
 <xme:XwGaaBqF7kZ1pe5Y9EWWeOBB6eJoLj37bzPB6_kqSYJjyX_fl6wREiZ5yKrxKVHFt
 llSDWv3OfZ1qd59Ow>
X-ME-Received: <xmr:XwGaaKrISiIdpJbdpz_SOjzDPmrFg0alr0xF9cJzTldtGj07xOgbn43j6aONrJBkAuXiA3F5fFCmJDNVZDy5ETyp5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvjedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsphhiuggvrhguvghtvggtthhivhgvrd
 hsshesghhmrghilhdrtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhk
 phhluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehmrghrrghtrdhkhhgrlhhilhhisehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:XwGaaDM6wqB7lDYLQJg2TfG2dhYzeNq_YSDT30uRfzWRb3xer8IwBQ>
 <xmx:XwGaaLynIK0bSsWfqEskeGjh14DyhpE1e8qcmwhUlOopmXaWPHvSQA>
 <xmx:XwGaaMuIK2SgktCiZ03NDIrQlgQ3qckVBiCpJo0gLi4qetFX9NK1Ig>
 <xmx:XwGaaE7uKTdRG5NHd0Yhac34psdgT7BTzeFRiQpoyXndB1Pl3vEgZA>
 <xmx:YAGaaKQobemL6BtTqirXlAwBL3O2RgcenBmZkSkCun57M_Xwr6HkdKsY>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 10:42:38 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Su Sai <spiderdetective.ss@gmail.com>
Cc: stephen@networkplumber.org, dev@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>
Subject: Re: [v3] net/cksum: compute raw cksum for several segments
Date: Mon, 11 Aug 2025 16:42:36 +0200
Message-ID: <4313463.1IzOArtZ34@thomas>
In-Reply-To: <20250804035430.4058391-1-spiderdetective.ss@gmail.com>
References: <20250803090837.15589edd@hermes.local>
 <20250804035430.4058391-1-spiderdetective.ss@gmail.com>
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

Hello,

04/08/2025 05:54, Su Sai:
> The rte_raw_cksum_mbuf function is used to compute
> the raw checksum of a packet.
> If the packet payload stored in multi mbuf, the function
> will goto the hard case. In hard case,
> the variable 'tmp' is a type of uint32_t,
> so rte_bswap16 will drop high 16 bit.
> Meanwhile, the variable 'sum' is a type of uint32_t,
> so 'sum += tmp' will drop the carry when overflow.
> Both drop will make cksum incorrect.
> This commit fixes the above bug.

Thank you for the fix and the associated test.

Please could describe the exact condition to get a wrong checksum?
Does it happen with all multiseg packets?
3 segments is a minimum? Any other constraint to reproduce?


