Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503ADFED9EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 16:39:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87E31402B0;
	Tue, 17 Mar 2026 17:39:08 +0100 (CET)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id 0790340270;
 Tue, 17 Mar 2026 17:39:07 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E4EC77A011C;
 Tue, 17 Mar 2026 12:39:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 17 Mar 2026 12:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773765545;
 x=1773851945; bh=F9MBeOd0ycH2MMg46jsb+4E7LOlC1ZMLn3qY6PlEZOE=; b=
 eE7lC8rHg7NAJeNyh+l7MxR6b2Qrmod1fn8gG23csXF/EX9PoPPYVooaCKJFCfi8
 GK4rs79/oqZDmgpBgl/OCSf5xi4fARzvaRMmWw7EugvQRP0SO7p0pg7f9ZwmiPiD
 XUyZQBdGi2ufsuZgG7M1j1oLj6rLWFf54NzuyUD0xddOBbItuuj5SFiOl+4HBbcH
 lFtikufNKnK33gapk1oacMTlnzTgUh6OXXiVQMId7WkGJKptcMtCigwMwOQrLqjL
 uRoUExsoUXY6JhlrwSvBmQS0SyqpkJWHNkqI8MLwK/3+VusofHNhLoSnn/Jfgd8u
 Mx6ZpOTRjU/a91U/A4cloA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773765545; x=
 1773851945; bh=F9MBeOd0ycH2MMg46jsb+4E7LOlC1ZMLn3qY6PlEZOE=; b=v
 0D1o57jVSFQGs1HSdW7sJ0tKVXjs7ap93m1EVg32QQzz2qC5P5z40qX8NZp/GmLw
 OwhOBc6pqKr4oocG07Mzhj5/whrF7aWx2IN8k7zF6K1FlbNZh5all/Hfu6vTSLlP
 OE69mAVop5jH2aEjE7/Zws/YENPfTJ1fs7i7nQUZ3KbcorYr2wVQaBEbLPZhEANP
 JLnieIrjl1gmyMpXQDXST/2IjGlKuiZ3JEpTvYUOcgNJxxrP/M1anow+GVVIzyuV
 OMgAa0vVolvsPhYlgkI+WIgpfnFBRmErYBxRVtMFxPkL5FkKqE5OzypHBAkgquO1
 SgCs7ZeKADmFvP022J42g==
X-ME-Sender: <xms:qYO5abzYkoXnV1HrBg-CfTuJV2OAFTzBezD12UTarp0UkqocBZusNg>
 <xme:qYO5adWP3PXiqgtOkbyFM5lyEkIz3YY149jZXoHKJ4vBZMqcnBEb8cl7AGtediaEP
 HNF9G-uKkJ-t3nukHVMKX7bvd5dSsYCcGy4PP-5YyPeU9YQHvAb6g>
X-ME-Received: <xmr:qYO5aVP3WJrCflxqet-4WgoEsyhkNI_6wwbs5PcXgvsxvKeUfLeQDV84UvtXeWNllnCPynr6KnjzUP1OlvtZYHGb1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddujeeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehrkhhuughurhhumhgrlhhlrgesmhgrrh
 hvvghllhdrtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhm
 sggvrhdrohhrghdprhgtphhtthhopehprgifvghlfihougesghhmrghilhdrtghomhdprh
 gtphhtthhopehprggslhhordguvgdrlhgrrhgrrdhguhgrrhgthhesihhnthgvlhdrtgho
 mhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehjvghrihhnjh
 esmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehnuggrsghilhhpuhhrrghmsehmrghr
 vhgvlhhlrdgtohhmpdhrtghpthhtohepthgvtghhsghorghrugesughpughkrdhorhhg
X-ME-Proxy: <xmx:qYO5aXDbAi_b6Fqu2iZqNqHNbAL41t1-aEGJNNW0DGxx5z1kV8nwHw>
 <xmx:qYO5aafMKpQ66KDcQh-rg_3s_AhEn794DZCETdAcNnM8Rt5jOKphZA>
 <xmx:qYO5aeNK9HqBZh9bXtCZ2QHN3Z0r3UtH1QlMB7H-rmfyajVIsdTVHg>
 <xmx:qYO5aSJjzuCQy4MrDeIHmW4G9H1bcqQQ_JqhaySAuhdMqB-Wpd4sFw>
 <xmx:qYO5aYx19Fa6AjAHGcgPqF1ITp_mGyuMcJcKnUwrpJk6H-3LMUE-WUPq>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 12:39:04 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Rakesh Kudurumalla <rkudurumalla@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Pawel Wodkowski <pawelwod@gmail.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, techboard@dpdk.org
Subject: Re: [EXTERNAL] Re: [PATCH v6 1/1] examples/l2fwd-jobstats: fix timer
 stats display with lock contention
Date: Tue, 17 Mar 2026 17:39:02 +0100
Message-ID: <1981390.eGJsNajkDb@thomas>
In-Reply-To: <20260316082047.3ac04bc0@phoenix.local>
References: <20240811155957.576645-1-rkudurumalla@marvell.com>
 <DM4PR18MB425513DE057FB7D2B68969F1CF40A@DM4PR18MB4255.namprd18.prod.outlook.com>
 <20260316082047.3ac04bc0@phoenix.local>
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

16/03/2026 16:20, Stephen Hemminger:
> On Mon, 16 Mar 2026 13:36:30 +0000
> Rakesh Kudurumalla <rkudurumalla@marvell.com> wrote:
> 
> > Hi @Stephen Hemminger,
> > 
> > Yes, you're correct that the architecture looks unusual. But since the primary goal here is to stress-test the stats/timer subsystem under contention rather than packet forwarding, I believe the current structure serves its purpose well.
> 
> 
> But it also exposes lots of issues. I would argue that if it is a stress test it should be in tests/
> not examples. Examples are intended as guidance for how users should use the API.
> 
> This is not the example that we should guide users towards.

I agree.
It could be discussed in the techboard.



