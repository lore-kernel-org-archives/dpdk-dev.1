Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF25CCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 14:19:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AF984026A;
	Tue, 11 Nov 2025 15:19:10 +0100 (CET)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id 7036C40144;
 Tue, 11 Nov 2025 15:19:08 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 801847A0142;
 Tue, 11 Nov 2025 09:19:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 11 Nov 2025 09:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762870747;
 x=1762957147; bh=fXcG6f14GMXcBrkmCdMw/l6KIGiPgEnXZLjjShHOmao=; b=
 vrknA36SNdyne6DfyT6SnWN54Vm0uJCZo4yg6ldEnz/SpKjsCiYnpJWee5uJzf41
 JjgdGWg0IYDKHjV+MpsU8FLH2pExY/s+aAbPMzA8N0KV7YZjhaGqYxLfaJ+02KBK
 luPEPPqHsLIicWcztiJpA/erUdUJj6Ewv4oUt8vdNdBNTNMBtaHPb/vYTqLXV0Uf
 DroE+j3Qu8nNumZXhmdefZ4tuRY3CuWXqsSyAQHyHzyFpoDDsmQeYD27wIj9N9iu
 IOHwD9vaZ7SyiFwW5d0hQX6fgwr7Hca9hX1oG2N+UaXLsbwsT8EbmIcY0EZApKBM
 6W4vFWMc3YDQJ/Ahe9gWTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762870747; x=
 1762957147; bh=fXcG6f14GMXcBrkmCdMw/l6KIGiPgEnXZLjjShHOmao=; b=C
 FrFEx8iTB/PqnaqzkJQ94DPCDV6D5fH9m5H2CYcwMVs8PHcPTDoZARb6MFjUmh4V
 KQ1uS9TpRVBFTkq681+yS7IjkpD6IftoTUUsL6SAuox7PPWIOiYC/q7FfA1c2BJv
 wbMXc0hfOeVSmR1VflPHR9YEEw2Q2609fg38Z3JD4PoUZ13Ftxv2qssc1EqG58Yy
 uqQoL0+EW2uy2n2JGsq6y2tdILEg6Gst9hlaQg7J7SacUquYw6nDORIfkTUPggUd
 lKNSkjrmEOE1D6QhgMvHpQbHaT2m5jmwRMKEC8ZMIEEy49x/cglkSHxfISQhY9bR
 mLn2Zol0a7+WwCLtcxCZA==
X-ME-Sender: <xms:20UTaQZY5YZ8Qad7Qk1yCCqduoMI-XQrqgUW7bJk3Xmfpdf2sdfTgA>
 <xme:20UTab2U5eeI1s5E1Qxm49ErY7Q8mCks1VDloIDoC1JilagPXZ8-Nw5owETa4yWMu
 RlLC3zLBUlql1oQtk3xMs1CRvWLaeMVMZVOQCY2SX2Yv1nielN0Fg>
X-ME-Received: <xmr:20UTaboepc1CE2B9w4FbJRWSDY0ln5L5VWwTp6e-8EBHlDPkl5gZ8nunur4e1eV_LFVN6ROGRRPdSKxjpnFskDRIyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddugeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedutddp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhjrghrrhihsehrvgguhhgrthdrtg
 homhdprhgtphhtthhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepuggv
 vhesughpughkrdhorhhgpdhrtghpthhtohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgtoh
 hmpdhrtghpthhtohepkhhirhgrnhhkuhhmrghrkhesmhgrrhhvvghllhdrtghomhdprhgt
 phhtthhopehnuggrsghilhhpuhhrrghmsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtoh
 ephigrnhiihhhirhhunhgpudeifeesudeifedrtghomhdprhgtphhtthhopehpsghhrghg
 rghvrghtuhhlrgesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehjvghrihhnjhgrtg
 hosghksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:20UTaSMYLQClFtljd-pDzN9HUzqFWEL_LUKM36O5v-sfWB0GUwpNkQ>
 <xmx:20UTacrxzKQ97ltkgKB-0HuXNFlNagplDu0R8ehQIqj-wjdduiN5kg>
 <xmx:20UTaVtwK48sY2Luij3tcodWIiwz_ZgCtmkxFfFlGVwi5dgAmMVsgQ>
 <xmx:20UTab1wctbNu_Bgfr5s1d1AHgh1gQBxqSdDDPRqyRmBajJ6GtNAKA>
 <xmx:20UTacSXAJBKls6ZPw3CcQpOff2ioc-k-JLpTJxK1yjbVX8spGTj6OXo>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 09:19:05 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Robin Jarry <rjarry@redhat.com>
Cc: stable@dpdk.org, dev@dpdk.org, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>, stable@dpdk.org,
 Jerin Jacob <jerinjacobk@gmail.com>
Subject: Re: [PATCH dpdk] graph: fix use-after-free when updating edges with
 active graphs
Date: Tue, 11 Nov 2025 15:19:04 +0100
Message-ID: <8104155.kIvqiD65kZ@thomas>
In-Reply-To: <CALBAE1Mhz+R=g7WyyNdx5vHugjL7ZFdYMbtrzzYnNXGA7SkigQ@mail.gmail.com>
References: <20251031221304.394997-2-rjarry@redhat.com>
 <CALBAE1Mhz+R=g7WyyNdx5vHugjL7ZFdYMbtrzzYnNXGA7SkigQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

10/11/2025 09:50, Jerin Jacob:
> On Sat, Nov 1, 2025 at 3:43=E2=80=AFAM Robin Jarry <rjarry@redhat.com> wr=
ote:
> >
> > After creating at least one graph and calling rte_node_edge_update to
> > add a new edge on a node which is in use in the graph, the node memory
> > is reallocated but the active graph still has a pointer to the freed
> > memory.
> >
> > When destroying the graph, it causes a use-after-free error detected by
> > libasan:
> >
> > ERROR: AddressSanitizer: heap-use-after-free
> > READ of size 8 at 0x7c4baa5e4da8 thread T0
> >     #0 0x0000005ad224 in graph_node_fini lib/graph/graph.c:256
> >     #1 0x0000005ae657 in rte_graph_destroy lib/graph/graph.c:504
> >     ...
> >
> > freed by thread T0 here:
> >     #0 0x7f1bac4e5e4b in realloc.part.0 (/lib64/libasan.so.8+0xe5e4b)
> >     #1 0x0000005ab6d7 in edge_update lib/graph/node.c:271
> >     #2 0x0000005abb1b in rte_node_edge_update lib/graph/node.c:339
> >     ...
> >
> > previously allocated by thread T0 here:
> >     #0 0x7f1bac4e5e4b in realloc.part.0 (/lib64/libasan.so.8+0xe5e4b)
> >     #1 0x0000005ab6d7 in edge_update lib/graph/node.c:271
> >     #2 0x0000005abb1b in rte_node_edge_update lib/graph/node.c:339
> >     ...
> >
> > Use malloc+memcpy and add an internal function to replace all references
> > to the old node memory before freeing it.
> >
> > Cc: stable@dpdk.org
> > Fixes: c59dac2ca14a ("graph: implement node operations")
> >
> > Signed-off-by: Robin Jarry <rjarry@redhat.com>
>=20
> Acked-by: Jerin Jacob <jerinj@marvell.com>

Applied, thanks.


