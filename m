Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756CFC021B0
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 14:55:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58E6140EF0;
	Wed, 19 Feb 2025 15:55:23 +0100 (CET)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 5CDE340E6E
 for <dev@dpdk.org>; Wed, 19 Feb 2025 15:55:22 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D352011400E8;
 Wed, 19 Feb 2025 09:55:21 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 19 Feb 2025 09:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1739976921;
 x=1740063321; bh=YnZAI+kuhKcv9KF3EH7akipFdf2Kek+nUcUVuPrwE0w=; b=
 Ymmjxf1eVJKO2dzTRb6JqNMFUqUvzGUVqS1hGMsiAT5CSnSGeDKc9CcQ62XQr/lj
 ZewlKVThnl/OazIUCsh8KPeofh6jPUhvqKzGkABNL4olX/y80rXSmePoSHskVKTe
 XKpVgkpCnjtbPSnbvpvxuxDcXWubtbX6w2RfDQXnQ8BrzrXp8C34uzgntF5YU8YG
 wVaMXADXtQ6GW9x6wlQXEuzBwAuIeoKJFK98OPsHNaRtmUY4486Lkeg3+7SEIbI7
 Ps5csy2TAILH61e8NA1mYW4rff6fwp9M+fPWCQDVDR0b8df9yAlz4lrw8vGDJowb
 SWdXrI5KThboHKsWQP64OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739976921; x=
 1740063321; bh=YnZAI+kuhKcv9KF3EH7akipFdf2Kek+nUcUVuPrwE0w=; b=N
 T4X1kCgoKBDJRCjXWmHMY5lxw9hx7yPc1IHA0LP/7oMt1LqLDt8pAhOFdvJJu7Qc
 C/Eb3f9EP98VgYAjAQCW6g2KhWTr5aiOwBUUl8s1rbtm9VyFLS8Yo5U27BBVJvFO
 QOahIz/OUGTm2qqZ4ue7rmMViQEAAEGBjMRRY1q1gU8b+2Ufune9OYzRMnQzhqmA
 fCYkffGxO8XbafB8dcqVNozkGc0s1OFX8p9egZ1b67w5JwDRx1VHW/CHh4gRbfPG
 U5zzxYnZA2NMCzUgnC8A9r7ot6uZ2xtLs4KmJwS4kXc1bYrR228ZrDoMGq6IPzyd
 pf6mUCm1kKRLtke/RJVOg==
X-ME-Sender: <xms:2fC1Z9Fi3yF7P1aAxmfhVAiDhd1y4SgreBTJftkyv7BxTzeGt8imrg>
 <xme:2fC1ZyX1hr0TOn01ucgqQ8V7OPjlXXP90qOFHEbw5gh63Wl-pZO-xw01issKaPifo
 02w6-naofdAbaAk0A>
X-ME-Received: <xmr:2fC1Z_L2Mf4Wc13APAv5TfbuexQJvhZ5SkVrnFNVFHQlnOKSOu7GRl7Hf9ImvTGf2_M826xY55A2tU6HGhtMzjLFfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeehhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvg
 hphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhgpdhrtghpthhtoheprhhorhgvthiilhgrsehlihhnuhigrdhmihgtrh
 hoshhofhhtrdgtohhm
X-ME-Proxy: <xmx:2fC1ZzH9HucrRSdsVHwsiJetOXvmk5oilUxLnyZ8OC282kynBJ2Rlg>
 <xmx:2fC1ZzWYG2N2MOVvOmmMriYViAGn-9qf4v6tRxE5HYv04U5bBJ2COQ>
 <xmx:2fC1Z-MIQsUZIOeGoQAcfGebVwclzwhcDM6e34XzXCiQ6s---2rgSQ>
 <xmx:2fC1Zy1M-86u1awKt6ZQAaXDpnMngPY8XHPNkgXQAFiDBkGTHssc7w>
 <xmx:2fC1Z-SHf5ylZc1k2v_dJMwJ4BLmukJt95M_PjyVJFh8HbaiHs5YfX55>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 09:55:20 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v2 1/7] eal: add queue macro extensions from FreeBSD
Date: Wed, 19 Feb 2025 15:55:17 +0100
Message-ID: <12279496.nUPlyArG6x@thomas>
In-Reply-To: <20250214172134.73908-2-stephen@networkplumber.org>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250214172134.73908-1-stephen@networkplumber.org>
 <20250214172134.73908-2-stephen@networkplumber.org>
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

14/02/2025 18:20, Stephen Hemminger:
> The Linux version of sys/queue.h is frozen at an older version
> and is missing the _SAFE macro variants. Several drivers started
> introducing the own workarounds for this. Should be handled in EAL.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

We may want to unify with lib/eal/windows/include/sys/queue.h


