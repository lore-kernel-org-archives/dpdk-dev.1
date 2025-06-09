Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E09C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 16:34:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC1CE40E34;
	Mon,  9 Jun 2025 18:34:08 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id AD94A4064F
 for <dev@dpdk.org>; Mon,  9 Jun 2025 18:34:07 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id A14CE2540339;
 Mon,  9 Jun 2025 12:34:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 09 Jun 2025 12:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749486846;
 x=1749573246; bh=n93MpkjdWYaM/U7/3rDBk/NznNt2NISbfMZ4XZpK98s=; b=
 ON4xbPEmFvDeDDlX7OxGFu4vrnASWYlLUYMdbdHPWtI8ILbPwyMrcoDrKHXnzL4O
 s4miunTaBZ/SLubcMtKG7jrS+YSfLrsfgwr6n6YyAGwmcnuw7N7qGpNxrHh4BVNG
 Hs3TziebZO+dqnR+Qp0RXzmqpvm4g+QX5gNcKTQNmoYzEYD4ErXZKpjl7IxX11NH
 TDkibqNnUYsPDZg7JDZ2aK6tJKKKLE00fNG01k/gW7+8DjX51bXPHe9IVi9Hr8iV
 pOfQaOBsP2ZE2ENvq257LCAKRY4evc0/saHffEpEdRV+/LgGhWomtbqnRlcvWNvo
 vZwQ5MH/LVOqFcwZTK0sLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749486846; x=
 1749573246; bh=n93MpkjdWYaM/U7/3rDBk/NznNt2NISbfMZ4XZpK98s=; b=Q
 6l6GRI182R43w1oZBitGrC20i/N0HZAVMT7OS7djWeuGpPhMuLz4NFExKy4VTTEK
 VwxqankjlffeSz4ekrpVCrkFkNXLC4s+2R7FabwBh7Uo2L46fLOrBZ6GpRGiY+K7
 XisIO8h+y2tUSTKbMWb20HBD+8mtZpb0bipSF+3ClwHHgMbr1G/oTG6+5rfQ1RyZ
 3PcH3es/J6wQb34nNHokeW4oHv+ERefuDCaN59skafHKpMlefrE/vNZKyvYOojYo
 A1QDYmWmoUuHpwGq4GXNEZ6GQBSj+b6ny6WitFidluUCHRpC/+RYJcftZamJ7T/G
 KLNnC6yZGTb70cfuYK93g==
X-ME-Sender: <xms:_QxHaGqjEpFIEzb62mKJkDtALGmdXnhzVm2CcRPccB46DpzOU96m-Q>
 <xme:_QxHaErsbl2Q1dTfGPaqOWfKjM7P5SG-TwltR-v2Oyi50HOKwnbpqMLHvV4pOE9Ix
 hfZqiRNVnOx7mzIEg>
X-ME-Received: <xmr:_QxHaLNvHWiKOnGvc38TxSGvrjetfuMH6Jbh_ZlpjNsZcub9_HfcoYSUDUWAOI3Vqt7dTIZ_fDywVKfNEWaqYeRHlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelheefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeen
 ucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrg
 hlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeethfdvgfeitdetheejhfekheeugfdu
 tdetheeivdffgedvleetieejgffgiefgtdenucffohhmrghinhepkhgvrhhnvghlrdhorh
 hgpdguphgukhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
 ihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtth
 hopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthguuhhsiiihnhhskhhi
 sehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtg
 hpthhtoheprhhuihhfvghnghdrfigrnhhgsegrrhhmrdgtohhmpdhrtghpthhtohepsghr
 uhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrvh
 hiugdrmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopehjvghrihhn
 jhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehkohhnshhtrghnthhinhdrvhdrrg
 hnrghnhigvvheshigrnhguvgigrdhruhdprhgtphhtthhopehmrghtthhirghsrdhrohhn
 nhgslhhomhesvghrihgtshhsohhnrdgtohhmpdhrtghpthhtohepmhgssehsmhgrrhhtsh
 hhrghrvghshihsthgvmhhsrdgtohhm
X-ME-Proxy: <xmx:_QxHaF7Nyj4XMPKyUzK4cuYbPVAqBsPmvRzAhlIipiNF-mmKWjY9Uw>
 <xmx:_QxHaF6pxwNmIL-ZiFPRhV0X89iXT37m-6rbJVb-mev31wJfxG0Iew>
 <xmx:_QxHaFgtvCXv9uxcSJJlK1N1bHNRMaI-wMRq_y-3xC53fvcM0l7vWA>
 <xmx:_QxHaP7vmbGlFLO1432bx1P2CxlhAKCD2LBI71G7ff8nij2rjzckxw>
 <xmx:_gxHaPuQDGhjKynR1UQnFlEJN_rFuYaStFdX871MAz_pZ5bwX6wagLxH>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 12:34:03 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Tomasz Duszynski <tduszynski@marvell.com>
Cc: dev@dpdk.org, Ruifeng.Wang@arm.com, bruce.richardson@intel.com,
 david.marchand@redhat.com, jerinj@marvell.com,
 konstantin.v.ananyev@yandex.ru, mattias.ronnblom@ericsson.com,
 mb@smartsharesystems.com, roretzla@linux.microsoft.com,
 stephen@networkplumber.org, zhoumin@loongson.cn
Subject: Re: [PATCH v17 0/4] add support for self monitoring
Date: Mon, 09 Jun 2025 18:34:01 +0200
Message-ID: <5285753.vfdyTQepKt@thomas>
In-Reply-To: <20250606162736.409485-1-tduszynski@marvell.com>
References: <15762368.uLZWGnKmhe@thomas>
 <20250606162736.409485-1-tduszynski@marvell.com>
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

06/06/2025 18:27, Tomasz Duszynski:
> Hi Thomas,
> 
> >Hello,
> >
> >17/01/2025 10:00, Tomasz Duszynski:
> >>  lib/pmu/meson.build                      |  22 +
> >>  lib/pmu/pmu_arm64.c                      |  94 ++++
> >>  lib/pmu/pmu_private.h                    |  32 ++
> >>  lib/pmu/rte_pmu.c                        | 537 +++++++++++++++++++++++
> >>  lib/pmu/rte_pmu.h                        | 251 +++++++++++
> >>  lib/pmu/rte_pmu_pmc_arm64.h              |  30 ++
> >>  lib/pmu/rte_pmu_pmc_x86_64.h             |  24 +
> >
> >Reading it again, I wonder why it is a separate library.
> >In general we give access to the hardware in EAL.
> >Why not having PMU in EAL?
> 
> I initially started PMU as something tightly coupled with EAL, but after
> feedback from other developers I decided to decouple it completely [1].
> 
> The Technical Board also discussed this and supported the idea of having
> PMU as a separate library [2].
> 
> The main goal is to keep EAL lean and focused only on core essentials,
> making the PMU code easier to manage separately. This separation aligns
> nicely with the broader effort to simplify EAL by moving optional
> features out.
> 
> [1] https://lore.kernel.org/dpdk-dev/20230111210547.GA2134@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/
> [2] https://mails.dpdk.org/archives/dev/2023-January/260035.html#:~:text=PMU%20Library%20,principle%20for%20inclusion%20in%20DPDK

OK I forgot this history.
Let's go with a separate library.

I'm trying to merge it.
I'm moving to a new release notes.
I did a bit of cleanup.
I've replaced __builtin_ffsll with rte_ffs64.
I've exported symbols with the new macro RTE_EXPORT_EXPERIMENTAL_SYMBOL.
Now I hit another kind of issue:
	error: "__rte_weak" is deprecated
I fix this one with using flags like RTE_PMU_SUPPORTED.
(note: it replaces RTE_LIB_PMU which was not defined)

And at the end I get this error for tracing:

rte_eal_trace.h:136:37: error: passing argument 1 of 'rte_pmu_read' makes integer from pointer without a cast [-Wint-conversion]
  136 |         uint64_t val = rte_pmu_read(index);
      |                                     ^~~~~
      |                                     |
      |                                     char * (*)(const char *, int)

I think integration in tracing is too much risky at this stage anyway,
so I'll postpone it.

I'll post my rebased version of this last patch for follow-up.


