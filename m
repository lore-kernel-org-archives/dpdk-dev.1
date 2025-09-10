Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1F1CA101F
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 17:21:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3782B402CB;
	Wed, 10 Sep 2025 19:21:42 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 0F59C402C2
 for <dev@dpdk.org>; Wed, 10 Sep 2025 19:21:41 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 37A217A0114;
 Wed, 10 Sep 2025 13:21:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 10 Sep 2025 13:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1757524900;
 x=1757611300; bh=MV2vz0peLDkcWeFkfK6e5hleoQyLoU51UDTw/Axs0DM=; b=
 e+yYnCV9wwhtungE2aoR2L5ojDaZGiZtlawcIkMB59HUd6c3IaBAMwlS1+1REOEh
 RR1lWy66jWVxPpX+1CdIROiOB1wyW1d4VzPHIoSGeSNNiSJAUTRE4KwpLtD3EY6P
 V1xLBh0umg+fXlENoZdlBRBCUHXpItz+Ig3RxzuICNJ9VMoFycxOMggeJ5UszJaa
 rRKf+wL+gIY1gbvSFrLmNIZ0byVAitMSHgESlBT/44qKkS2toC8pPjGE0/FmwwME
 RuRNrIc79sNzzuQOGQlhfap/QEBbeRzDsYS8tzxki1O9XuxdUX/ES3nnnfqUteUX
 7AEoZregSKKiG//cNMBxPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757524900; x=
 1757611300; bh=MV2vz0peLDkcWeFkfK6e5hleoQyLoU51UDTw/Axs0DM=; b=K
 NXkHhcmUEnPha2NVjx3FCI/oiJY8lceG/+SLEPXZvmxhO4LxTCJtsrxJgjoDIxgx
 hnFfm7MauQiJcdfW+Xx0R+05OTd+vt52bixQEBkzUSv/7N7yiE2AXJ4RpVWTUrFr
 fNDLjOicujfGSnlPSJn5k6t7uObfMHzICIws28jFBMH1hu3xfjwXrjswqbOumr9m
 N2TYFLb+ojf3zdkNj3saroQhoEHBGDRkZO/ozD9vVihrRYqiiACdmUmSOeaqgdOD
 fa4ID+l2b7LuXBLEXXRm6NiTL2Hmo2kN/sMsdx4rTxrnKdV5idL2n4HnZvf1DBhu
 Cj9uobUeGpf7CWGL1a/zg==
X-ME-Sender: <xms:orPBaAI78db3UlnMlYniO_nAbW4o2ZwIvsfTxqrykTtc78lWXBuv6Q>
 <xme:orPBaFj_fOnhP2cdF4T3n18utAWbqM8qKUPvovJf2r_WTtQU72pz4mjM9jk3zur9d
 r6AS7pBrQLBv-dlXg>
X-ME-Received: <xmr:orPBaA6v7ocIitNQkkr9B727jpO5WY7hLAgp6g6SjWgECEv-qS1Qah3hrHNzbDpfs-YjcOmWs0K88ieLW8jHVsY_5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeekkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepvdfgvddvudehudefgfetffejledvgfejffefveeiveefffeijeeftdeg
 leekteeunecuffhomhgrihhnpehsuhhgghgvshhtihhonhdrrghpphenucevlhhushhtvg
 hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhj
 rghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprh
 gtphhtthhopehskhhorhhisehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepshhtvghp
 hhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhesug
 hpughkrdhorhhgpdhrtghpthhtoheprghnughrvgifrdhrhigstghhvghnkhhosehokhht
 vghtlhgrsghsrdhruhdprhgtphhtthhopehnuggrsghilhhpuhhrrghmsehmrghrvhgvlh
 hlrdgtohhm
X-ME-Proxy: <xmx:orPBaNav4XkWWHDZhYsfRzAmPeOhM_MER3pIW-wL4v5R3gedWxOdZw>
 <xmx:orPBaF5M-9s6bQOKzXxANIPpZj4bHdUzW9ECLza4SSW2WCGnfF_Lrw>
 <xmx:orPBaAC1WZCJQ8FiLRR0tIQv4cE1h8juR-y6cnhWuuuz9cUleUIM3g>
 <xmx:orPBaLdqzO7XjPybn6wwcKv0DAzJ_O7ogbs2NxOAtzZoFYZan9mjPQ>
 <xmx:pLPBaJtITpMIJDzzLmKr1--1j_-mv4sFteD4mt4fn8mGWCfy79X-38Da>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 13:21:38 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: skori@marvell.com, Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>
Subject: Re: [PATCH v10 1/1] ethdev: add support to provide link type
Date: Wed, 10 Sep 2025 19:21:36 +0200
Message-ID: <5008943.GXAFRqVoOG@thomas>
In-Reply-To: <20250909175007.5a54bcf9@hermes.local>
References: <20250821053425.3227866-1-skori@marvell.com>
 <20250908085256.1866407-1-skori@marvell.com>
 <20250909175007.5a54bcf9@hermes.local>
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

10/09/2025 02:50, Stephen Hemminger:
> On Mon, 8 Sep 2025 14:21:48 +0530
> <skori@marvell.com> wrote:
> 
> > From: Sunil Kumar Kori <skori@marvell.com>
> > 
> > Adding link type parameter to provide the type
> > of port like twisted pair, fibre etc.
> > 
> > Also added an API to convert the RTE_ETH_LINK_CONNECTOR_XXX
> > to a readable string.
> > 
> > Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> > Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
> > ---
> > v9..v10:
> >  - Rebase on top of next-net:main branch.
> > v8..v9:
> >  - Adds 25.11 release notes.
> > v7..v8:
> >  - Add documentation for invalid link type.
> >  - Remove trace point from API.
> >  - Rebase on next-net.
> > v6..v7:
> >  - Replace link_type to link_connector.
> >  - Update comments.
> > v5..v6:
> >  - Fix doxygen error.
> > v4..v5:                                                                                             
> >  - Convert link type to connector.
> >  - Fix build error on Windows.
> >  - Handle comsmetic review comments.
> > v3..v4:
> >  - Convert #define into enum.
> >  - Enhance comments for each port link type.
> >  - Fix test failures.
> > v2..v3
> >  - Extend link type list as per suggestion.
> > 
> >  app/test/test_ethdev_link.c            | 18 +++++----
> >  doc/guides/rel_notes/release_25_11.rst |  9 +++++
> >  lib/ethdev/rte_ethdev.c                | 45 ++++++++++++++++++++-
> >  lib/ethdev/rte_ethdev.h                | 54 ++++++++++++++++++++++++++
> >  4 files changed, 117 insertions(+), 9 deletions(-)
> 
> Queued to next-net.
> Fixed the fuzz (file offset) differences in release note and test

Please no, I did some comments on this v10.
I wait for a reply, and probably a new version.




