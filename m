Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12179CCD193
	for <dpdk-dev@archiver.kernel.org>; Sat, 18 Oct 2025 16:50:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07D4340DCB;
	Sat, 18 Oct 2025 18:50:07 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 8C4954013F
 for <dev@dpdk.org>; Sat, 18 Oct 2025 18:50:05 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id 96D5C1D00097;
 Sat, 18 Oct 2025 12:50:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Sat, 18 Oct 2025 12:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760806204;
 x=1760892604; bh=DosIbLM6vsxAM7EoR8oNOXIAW3kHuV/mSXATw48pyuo=; b=
 CKvVjBb+M0s7noskhOpsJciHJ7rKLBHHcCTtVzTIHzx1D4VbWf8DZvSPfLfnEoOc
 frtLt7Qn/LOARKoJVEIPIpa+Cy7M8+uQh98N6d0+kI58vXKAjXBdie+x71IkxLHU
 GSMGoWIHe1F0q6POzkjJgCiDqbyq9bQVvcUjSpqAP25sK5iW7gAs8Tau6C2Ye1mc
 EmLwJrPVqYd0Fs5IaCEizPdtYd6hSPK1nGNrk/j8YmLKNVfBeB+QFQLxmXYvBUb4
 PKKQuqXBw1c846zrJSZWdm1HEkwipOXc7Aa+9OxxUBKjfEux0jwzik1vHP+fMiNg
 MXTLQlgxBPazM0D2asXWkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760806204; x=
 1760892604; bh=DosIbLM6vsxAM7EoR8oNOXIAW3kHuV/mSXATw48pyuo=; b=g
 r41ao6Jm83BUK6D471hb5Q1OKilBas6WMbA3x8amDFDQLX03xtrzoO7yJb2zXOis
 XKFmIvDACfhtAn5SHr2Xjn7R859VRvG+QHOYHq5MymRObUo/LeCJvVsL3+vFvmUc
 rL7aVWf6HwzLKIZUyRIkHq3rWHJnGNYYxDErCeCuhXv/gcwQDSgPVypXhY+GiUrn
 0S3zVi/18/8eROaMK7mx5L9hCwPzZ6yRdhcaQmx8usW+FZeEiTnF//8Gdei6mlpE
 IqGAeng0iz5yOPMnsYECTSL/Zpu5hOzeGKzE3X0G5bG/eZYA0SrtWLVOZJ87GWFw
 WAITltrhvqTM3afHwWoRw==
X-ME-Sender: <xms:O8XzaEoJ_bAYSPn0RZ4Yig8yJONJpia-NANBezEmZT6o7prEv5-q4Q>
 <xme:O8XzaEvQmsDrGHdrz_cV28-NGrDzbvAzZzE5SKndddwFUeAPl7-nAjRkBe6UN2jhS
 YnOJ596ajGjH4nPk2GDUN1bTETDkRWJYHLontQWWAo2CO9XXKsygQ>
X-ME-Received: <xmr:O8XzaJFtDJxShfvP3MlwsmHKYcNE3Q1HV4HuuoeY33i6IDACDzur4UAwjZPqDeWpGes5AxhRgpln9w4A026gcREF8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedvheejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertd
 dttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevff
 fgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 vhgrthhtuhhnuhhruhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopeguvghvseguph
 gukhdrohhrghdprhgtphhtthhopehfvghnghgthhgvnhhgfigvnheshhhurgifvghirdgt
 ohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtoh
 hmpdhrtghpthhtoheprghnrghtohhlhidrsghurhgrkhhovhesihhnthgvlhdrtghomhdp
 rhgtphhtthhopehkvghvihhnrdhlrggrthiisehinhhtvghlrdgtohhmpdhrtghpthhtoh
 epjhgvrhhinhhjsehmrghrvhgvlhhlrdgtohhm
X-ME-Proxy: <xmx:O8XzaNbnz-mlyAaijPWdVlDGOaHJv2md8lxtcpydOAKcjAcGyc8AtA>
 <xmx:O8XzaBW4pDjnVCluhSjgpw2yxia0i7LZ7VZtI458TU8B1o5cjxJzLg>
 <xmx:O8XzaLlcynm5Mn5F4FIG3htEsTbeZGOuRPu4O-rmqYf_vq0fRZWqrg>
 <xmx:O8XzaEA_QrvIANN3tCOlWD0re0GBmSqA3QypF63Cy-4UuTx0G1V1hw>
 <xmx:PMXzaHBvPpfrlu9MP41cXeWKxrRT-BPy_ci75TRENDo9ODbIz_z9nM5R>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Oct 2025 12:50:02 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Vamsi Krishna <vattunuru@marvell.com>
Cc: dev@dpdk.org, fengchengwen@huawei.com, bruce.richardson@intel.com,
 anatoly.burakov@intel.com, kevin.laatz@intel.com, jerinj@marvell.com,
 vattunuru@marvell.com
Subject: Re: [PATCH v4 1/1] lib/dma: add control-plane APIs for inter-domain
 DMA transfers
Date: Sat, 18 Oct 2025 18:50:00 +0200
Message-ID: <3090080.uoxibFcf9D@thomas>
In-Reply-To: <20251017140652.3186205-1-vattunuru@marvell.com>
References: <20251017122610.3126992-1-vattunuru@marvell.com>
 <20251017140652.3186205-1-vattunuru@marvell.com>
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

17/10/2025 16:06, Vamsi Krishna:
> +Inter-domain DMA Capabilities
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


> +
> +The inter-domain DMA feature enables DMA devices to perform data transfers
> +across different processes and OS domains. This is achieved by configuring
> +virtual channels (vchans) using `src_handler` and `dst_handler` fields, which
> +represent the source and destination endpoints for inter-domain DMA operations.

This belongs to the first patch.

> +Handler information is exchanged between devices based on their DMA class type.
> +These handler details will be exchanged based on the type of DMA devices.

Repeated sentence. The first one looks better.


