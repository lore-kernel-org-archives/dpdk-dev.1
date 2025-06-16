Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8C4C71135
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 07:08:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07E1F402E3;
	Mon, 16 Jun 2025 09:08:12 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id D53554027A
 for <dev@dpdk.org>; Mon, 16 Jun 2025 09:08:10 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 464D325401AF;
 Mon, 16 Jun 2025 03:08:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 16 Jun 2025 03:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1750057690;
 x=1750144090; bh=p7gs+L3CJJGm+fy4IL2isYs67k25tYNbrjR81kKV/MY=; b=
 KtMat2DdfCWJsxCrH81L2szojLscLALx7vRNmCrSM01IkZEp551E3Lrrb8gCkS28
 IMkulUOEA/w15aRM5nDie65DHYqUqkVSDkv0H6ylWa2irbpXNY9+9OZc+l1aMLEC
 K59IzPLJf16oD2REh/UcCqfL3/+D1DmJIn+j/LSCbXVIf9wALZQAQ9CkQZVRiqkK
 2q5pNbPNOjQe8dJn7rbLVqlRwTxYsJ3siIRAbfb45mIhj4t92BsnkwdQmNWUEkKY
 TGIH9mRXrRkvuoEMFob7it06Hf6RjJjs9fEYmqR40linVHo+dGkcskNwW46/v9fH
 9YZDfSTx4WTH6VlnufAYdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750057690; x=
 1750144090; bh=p7gs+L3CJJGm+fy4IL2isYs67k25tYNbrjR81kKV/MY=; b=O
 NCOODR73MR8mi9IBTLXkM8Pw8ZkuGtCJOn95b6kT5uWDp2LV5OhqYdAv3jdQAWui
 UbJ5FIoR2FEzDv1Flm7LG7R+tLWwCIVW2tntPPTumMuJhxch8jj70Ac+PIyzY/Q2
 3rE3p9udLOniG4WbM0FqBxGlZSaC4fyKXIvsxbYXiSGe5hNXF5rmu2JhFbJCL+Nn
 k63Otxek9mdYy5wQfgLN9VC86Ng218F18Tjc+VG0tLNQabI/aYIgXrFEpLALw+dB
 +iOU3PnYARNgUOqN7W1O7V9ecDsubH8vXd2umr9FLLPmSwb3QfmJATZ9hqMBvrWS
 cMAlqZA0gp229UuJWdiUQ==
X-ME-Sender: <xms:2cJPaBPZflE4LzdPwZaQPetm07_Np03j2oHDy4W0Jb3SOCWpuN_hMw>
 <xme:2cJPaD-bg4nfcarbOVZw052GuyX2PTtHYUIKQNESZ8ITr8yGFWLXVmDtODHJgqqcb
 k2k9379jTTCbtZ2Rw>
X-ME-Received: <xmr:2cJPaAQM-IHKo9oF4XRbRjIo2yVA4rFg6_oC5FrvOJcOmc_vSof3opZ05u0MR6jqaNgCo46ipmPmoDivPX6En9dDmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvheelgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthguuh
 hsiiihnhhskhhisehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepuggvvhesughpughk
 rdhorhhgpdhrtghpthhtohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgtohhm
X-ME-Proxy: <xmx:2cJPaNsh_AFmmmN3PE4CFvkhJD2gQ9d_UF8Wz1PATrNrL4Jo8CzIbw>
 <xmx:2cJPaJfw7LqabyjLusIAWT_8CQMalqoS2OHKB1RaqxSAF6AxnVeORg>
 <xmx:2cJPaJ22JLXVky52rbn11oyE_8-zCUbU3JfibFwRrMP6fveSkEN4ng>
 <xmx:2cJPaF9gDA7dNgz4gvsNb4lfIAS3KLU4hQ6i568ScIYxpbOkWEqAVQ>
 <xmx:2sJPaEmx0AZn5TyLCiEnYyuS5owDv20hKVenw3ZZkmIO-AGJtB09rlfJ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jun 2025 03:08:09 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Tomasz Duszynski <tduszynski@marvell.com>
Cc: dev@dpdk.org, jerinj@marvell.com
Subject: Re: [PATCH 4/6] lib/pmu: use build system defined RTE_LIB_PMU macro
Date: Mon, 16 Jun 2025 09:08:07 +0200
Message-ID: <5659935.eFTFzoEnKi@thomas>
In-Reply-To: <20250616065341.3233106-5-tduszynski@marvell.com>
References: <20250616065341.3233106-1-tduszynski@marvell.com>
 <20250616065341.3233106-5-tduszynski@marvell.com>
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

16/06/2025 08:53, Tomasz Duszynski:
> RTE_LIB_PMU is defined by build system automatically if DPDK is build
> for Linux. Otherwise it's missing.
> 
> That said all cases where conditional compilation is required
> can be handled without introducing other macros.

You don't need to know if it is compiled for an unsupported arch?

What will happen when calling the unit test on RISC-V?


