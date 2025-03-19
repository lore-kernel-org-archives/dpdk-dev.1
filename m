Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE925C28B2F
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 03:13:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFE17402C4;
	Wed, 19 Mar 2025 04:13:45 +0100 (CET)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id F3F2C4025A
 for <dev@dpdk.org>; Wed, 19 Mar 2025 04:13:43 +0100 (CET)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 3D0592540273;
 Tue, 18 Mar 2025 23:13:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Tue, 18 Mar 2025 23:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1742354023;
 x=1742440423; bh=wGj0IuRWwISgHNvqQyp1C1Qj62lF9jNdRs9Do5oivKc=; b=
 dZtbD5DdQE6rH9Wehy2OfI7DTQj+ViH0aDsUAOqK9BQLEeBLS6SV50IMdlo4bPdT
 RKsTYTRShtGCkyeotdbtgrA3u4cX4om/Mt36aHhBHtzZ917vkR1S/TgRcN9LKfDY
 F+9fSEFjHylq8ionf71K/yRYb+5h5FjV5u9pMsw+Jv+O76ihJwE2SpFtJ3jYR9wI
 O36ktuSTsCduPlTq1xNufuqAq4dmEEWEcTWH6VHMhZhcZy5hYe8AjaDnPN8zkADi
 lbWZqmUXxGlINW4iP9sze2QyfEOG+96OYMBMEYogaSneAUqHrqvdJauXdI1E7C1y
 FVp02P5VjYtE7upZj2HZsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742354023; x=
 1742440423; bh=wGj0IuRWwISgHNvqQyp1C1Qj62lF9jNdRs9Do5oivKc=; b=K
 Aj645wiQ8Yui9uidYLp1JY8Srvv+vUvG8bCzkJuyKIlpqy7RcZZX/laubD3D9UqX
 NMR/g5UcCNeAquoF9GdXUKdX9m5NEuiNmQMdkkoAXNqLW7YTgKw1rftjDtug+p5o
 bKsN5QOGrysV80P4mI4g8RRjrkgv9rw22k/KwHiydRFyXuqZaEyqYSYYewDyZDFl
 lSVAB3a7nVtDMEOiYbY14MF8eb+rGwsfR4E2daLJrZesYfljVZ7xCAI6u2NR/Ih1
 nMnCZNgLXpIk+NivtdfXItQ5IvLaODs91em2mHYNhZJOCpPyRqGS9/YAJoqKOZp0
 WCiY6HrrP6m/KNmZRfPpg==
X-ME-Sender: <xms:ZjbaZ5d1CLjvf4ho5GpNgxtEQwVO-YdnnTJ8YqM1H2zkvX0UMDv-sQ>
 <xme:ZjbaZ3PXaZaivdF9x1NfbUVeswyrVnpdKkWaKUYtdnYGHS0liJi8fsu35aUIubGJZ
 d9aAghrez2aqbja6g>
X-ME-Received: <xmr:ZjbaZyhmBnKi6t6QkcLcCQRrOtceYHENkVM9h8oMqr9Jcbl6af34c0YvTrBC-FpDIomYHkzBtXJ1l_d6aS7QGCFpbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeegvdefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeekfeehfedtgedtjeehueeutdfg
 leefieevkeeikeelkefflefgtdevieehheffudenucffohhmrghinhepughpughkrdhorh
 hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhh
 ohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpe
 hsmhhtphhouhhtpdhrtghpthhtohepshhhphgvrhgvthiisehnvhhiughirgdrtghomhdp
 rhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehfvghrrhhuhhdrhi
 highhithesrghmugdrtghomhdprhgtphhtthhopehorhhikhgrsehnvhhiughirgdrtgho
 mhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrgh
X-ME-Proxy: <xmx:ZjbaZy_bRG5A1ZL102SlqqqQievtlM7uJ3MqliephfuYAs43zeRYZg>
 <xmx:ZjbaZ1tR1d0Mhw6QSSYsP1wHqcEj9U3w_T_xfQnp4-GCSJvEU9Ub2A>
 <xmx:ZjbaZxECtoXFAw4HVMHVsLTkFelXbooKlKDh_KoskD0wg3JZLJxZfA>
 <xmx:ZjbaZ8O4o4ykXejnwOLbWYEAkmPRvZW6AaHmYv9qPEkgbaWmTb2Ckg>
 <xmx:ZzbaZzWVI0GN312uAYsdt5HeiC2FIfvg-HXNLIT6tS02mHavrmlrYAie>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 23:13:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Shani Peretz <shperetz@nvidia.com>
Cc: dev@dpdk.org, "ferruh.yigit@amd.com" <ferruh.yigit@amd.com>,
 Ori Kam <orika@nvidia.com>, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] examples/flow_filtering: fix destination IP mask
Date: Wed, 19 Mar 2025 04:13:40 +0100
Message-ID: <3464272.K4a6FZZPjd@thomas>
In-Reply-To: <SA1PR12MB9491739955B431A33FB2EFC7BFD62@SA1PR12MB9491.namprd12.prod.outlook.com>
References: <20250112075200.5020-1-shperetz@nvidia.com>
 <24267002.EfDdHjke4D@thomas>
 <SA1PR12MB9491739955B431A33FB2EFC7BFD62@SA1PR12MB9491.namprd12.prod.outlook.com>
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

10/03/2025 07:48, Shani Peretz:
> From: Thomas Monjalon <thomas@monjalon.net>
> > 12/01/2025 08:52, Shani Peretz:
> > > This patch corrects the destination IP address mask to restore the
> > > previous implementation's behavior.
> > >
> > > Also it fixes a misuse of rte_flow_item_tcp struct.
> > > Replace it with the appropriate rte_flow_item_ipv4 struct, as the code
> > > in this context filters ipv4 traffic.
> > >
> > > Fixes: 16158f349000 ("examples/flow_filtering: introduce use cases
> > > snippets")
> > >
> > > Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> > [...]
> > > @@ -77,7 +77,7 @@ snippet_ipv4_flow_create_actions_template(uint16_t
> > port_id, struct rte_flow_erro
> > >       };
> > >
> > >       tactions[0].type = RTE_FLOW_ACTION_TYPE_QUEUE;
> > > -     tactions[0].type = RTE_FLOW_ACTION_TYPE_END;
> > > +     tactions[1].type = RTE_FLOW_ACTION_TYPE_END;
> > 
> > It is a revert of this recent commit:
> > https://git.dpdk.org/dpdk/commit/?id=7d73fa47f4
> > 
> > Do you confirm you want to keep RTE_FLOW_ACTION_TYPE_QUEUE here?
> > 
> 
> Yes to be consistent with the non-template API.

Applied, thanks.


