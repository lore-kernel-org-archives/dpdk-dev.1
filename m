Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8228BCCD192
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 14:09:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54C7F4060A;
	Wed, 15 Oct 2025 16:09:47 +0200 (CEST)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id CA53040273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 16:09:45 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 099A87A01B3;
 Wed, 15 Oct 2025 10:09:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 15 Oct 2025 10:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760537384;
 x=1760623784; bh=LfnP6ckgCFwvRMA5kHFUgWQYHMka46sCL/eUJCgKPWU=; b=
 fE05A4iQetypHOV7Cqb/M86lKQV6FfJy3FGkua24IGyD8ObjKL0OHJuDVXV9F+N2
 2bsFTDQyCUGVYsvD+HbXfJmmHaRFGfDQK/mzk77ytjY2ThsSy8ih0HNYAEeGMzW5
 eo6sYfFSujQzyEVYFvdwrmc5TlqU3UiR9tt1M9H2DcnsUm5aVpptjEcPQia/KSAo
 oz06RYnJoe32DQniycG+bjTVZX4CaW2UW+zqkZyCB1ZPCvzxzg+naLETR3CwNDzK
 avpq53ASc2ppChOhbx1EmmsJnrXVws/uvCXbEigocZZyPh4dSnl9cmPliryRo0Rz
 c1VDh7ySB+Qsk8m+VlzS2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760537384; x=
 1760623784; bh=LfnP6ckgCFwvRMA5kHFUgWQYHMka46sCL/eUJCgKPWU=; b=u
 mw8y5yxCUg9OwawUyAIG4jABWhcXcqND92LQK2sr7IwJsvL8Zo6C+Ot07l1wAQxw
 5Jog+kOIiES+lHL5GmkFaf7zUAldZzk29H13hLJH09XPA/xEe/afBB61VMnUnZov
 vxPCF0UVAZtBrt/G2F3CdqYmfO/OU6m1N3QavUCRgBVfcgl1AVMynjehocTWl+IJ
 Q18pE9zuHWNy4LR4xn0R8g+dQe8gwqQMUFz6mRGi9f6dgN095gI3tWflO/0aQUZr
 w7dq93EcFuRbArdyayPdZ+4sLcnmEE4jPQnMPVEPj7EPWivccP68WVD/0QM9cTEa
 /sgtH0V6v/wk7VPS2P7Zg==
X-ME-Sender: <xms:J6vvaHVVrDDx14O9NCILSh4yk-NppNag_f2QhNsR_X0zpi9ulTxsmQ>
 <xme:J6vvaD5sm2mPTcME5ju40AxqdPP2PPvijLonlkrccZ15bRFq-vo2QEuhsfMCirWO1
 KmCU2h260ZBnyFQ4XlGijFZv2rpZ1NN_uE0twopzMwCBIA3VdREsA>
X-ME-Received: <xmr:J6vvaCh9KQP6zmcYPF0kzSAjYyGcZpbcSJIygV7nRUlye05IfncutFCEvz57gXNtce5WMQeFuRqTK70C7mFxDglfAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefieduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertd
 dttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevff
 fgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 fhgvnhhgtghhvghnghifvghnsehhuhgrfigvihdrtghomhdprhgtphhtthhopeguvghvse
 guphgukhdrohhrghdprhgtphhtthhopehlihhuhihonhhglhhonhhgsehhuhgrfigvihdr
 tghomh
X-ME-Proxy: <xmx:J6vvaKcxzmEF2X_YJlHBfDsyBsjLZ240XyGy6lT01nmNcE8oZm9DqQ>
 <xmx:J6vvaHc22bFRKOmwisaUK4xn9erTuf_0weh9EChOmRtXxjJpFyc0dA>
 <xmx:J6vvaE-e6TArI17IvErcIdd6CyiUIlf2kb_AVQi6s0_QZ09DYmMyOg>
 <xmx:J6vvaDnd6JTor8WbM18O-TSaIJoGoVDw1VSqPmr_i0lar34aXA0aYw>
 <xmx:KKvvaFFeezgM5nvl9ZVp99nRF43m5FGH1M_mEeKXW252IxTdjuKAqVel>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 10:09:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: fengchengwen <fengchengwen@huawei.com>
Cc: dev@dpdk.org, liuyonglong@huawei.com
Subject: Re: [PATCH v4 4/4] dma/acc: add doc
Date: Wed, 15 Oct 2025 16:09:42 +0200
Message-ID: <6737262.UjTJXf6HLC@thomas>
In-Reply-To: <91af2066-2501-0864-f5f4-68037a8515b8@huawei.com>
References: <20250827092729.10719-1-fengchengwen@huawei.com>
 <6737235.31tnzDBltd@thomas>
 <91af2066-2501-0864-f5f4-68037a8515b8@huawei.com>
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

15/10/2025 14:55, fengchengwen:
> On 2025/10/15 20:01, Thomas Monjalon wrote:
> > 15/10/2025 13:10, fengchengwen:
> >> On 2025/10/15 18:05, Thomas Monjalon wrote:
> >>> 13/10/2025 11:11, Chengwen Feng:
> >>>> +HISILICON Accelerator DMA Driver
> >>>> +================================
> >>>> +
> >>>> +Kunpeng SoC has an internal accelerator unit which includes zip function, and
> >>>> +the zip also supports data copy and fill. This driver exposes this capability to
> >>>> +DPDK application.
> >>> How is it different of drivers/dma/hisilicon/ ?
> >>>
> >>> "
> >>> Kunpeng SoC has an internal DMA unit which can be used by application
> >>> to accelerate data copies.
> >>> "
> >>>
> >>> If it is the same hardware (Kunpeng),
> >>> I recommend having a single driver, or a single directory.
> >>> Also we already have a driver named "acc" in baseband.
> >>
> >> they belong to different hardware IP of Kunpeng platform, /dma/hisilicon
> >> is the PCIE subsystem DMA's driver, while this acc is the
> >> Accelerator(ZIP) subsystem DMA's driver.  they don't exist in the same
> >> specific Kunpeng Soc.
> >>
> >> a single driver will add complex.
> >>
> >> as for a single directory, should we do for all vendor?  I see there
> >> are  dpaa and dpaa2, ioat and idxd both belong to vendor platform.
> > When it is really different driver, it is OK to keep them separate.
> >
> >> if there are no rule to have same name with different subsystem driver,
> >> I prefer keep it.
> > OK but why it does not contain HiSilicon or Kunpeng in its name?
> > "acc" is a really short name, and already used.
> > Please find something else.
> 
> how about hacc and kacc ?   Hisilicon / Kunpeng accelerator DMA

You already have one DMA driver in drivers/dma/hisilicon/
Can you build around that? like hisilicon_something?
hisil_acc?


