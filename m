Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A31C71136
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 22:18:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DAC44021F;
	Thu, 12 Jun 2025 00:18:30 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 929C740156
 for <dev@dpdk.org>; Thu, 12 Jun 2025 00:18:29 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 1515B11401F5;
 Wed, 11 Jun 2025 18:18:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Wed, 11 Jun 2025 18:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749680309;
 x=1749766709; bh=9F8BF0ZU2QZ4Kcy2KLMSrBiUCYaF0RDnABz4UKTcD+I=; b=
 mmR6zUum7leis7vCJZoH15fGDDnEmpZDfXtS5F2kf7y0fRtkUtrr0hUNtQPXwugF
 nhWWjh7Ywyqbg0PsL7CgHDDmCWSUR5EBOg1cjvFTIzpc9Mn85tCzc3bgRfYKDhaR
 evtx5+tXSWTQ4eLY9a+1YNEesiUQFIwaF5+a9xx0twt366QKFDBAdrSXLAzqN9aw
 uu+8YK5UH1eK+NuQZYAnpTvx0jcC6I6+4U5puuUcDuGBi99k6rNA0Jni+w+Bv1L5
 CoTKXvgx2Adr78TPDrf5JBW4DsX0qXd59nm5yi7b9UQxGPq2YR+yCDfIXIDOVqxT
 bZ1Sq89YLCKXkh4IcBinhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749680309; x=
 1749766709; bh=9F8BF0ZU2QZ4Kcy2KLMSrBiUCYaF0RDnABz4UKTcD+I=; b=F
 f9w1hxoKEOtrRSUSYc6YZ+tAWmGs1uIqa/g1PBaU3XbAx5LHc7qSIEgan3HJkxVZ
 c332eCE79216xG/oFs+vyeOgkI2qRGuMakH+/W2IRxtUFVvKaSPCD/5Ye5fbCv7Z
 m/h/sJkCYN8t4FaNCRnpNPKEGqQsQlwpIDVgUOc2f02iJ10SJfSwuECNaNkUZ4SO
 LlmgdyM5IywBrZwPzxD+GcuJUZauZeoWTacsUqLh8D9NCpUoecJt26DphqW0clVR
 cFc8FthZZ9xvrNXDjQg2gDX9xhSY4r7jzmtYzw2lrF3DSuiTkcr1YKuNzM5g69rI
 chZTGs7n1jkXCheJ7VCuA==
X-ME-Sender: <xms:swBKaGMMThuIJ5EUwTdUMUr4vXTORIGEiEdtFkrljcnl_ddXGajfBA>
 <xme:swBKaE9Ulkz3992xiDKz5TkvCfRTuwp1DCmNkogZZneE2BOM89fmun2i-8uVKZ6Gf
 WTUh66zk5JzI4CRhQ>
X-ME-Received: <xmr:swBKaNQ39d2uwUwGIJpE6YTX0Ff8kOAqJB2wFGNDE4tS1v0GGTjn-33kWpQdZ_dLstELKuYwpyUPrtZG64duaacT6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddufeefiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvg
 hphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhgpdhrtghpthhtoheprhhorhgvthiilhgrsehlihhnuhigrdhmihgtrh
 hoshhofhhtrdgtohhmpdhrtghpthhtohepmhgssehsmhgrrhhtshhhrghrvghshihsthgv
 mhhsrdgtohhmpdhrtghpthhtohepkhhonhhsthgrnhhtihhnrdgrnhgrnhihvghvsehhuh
 grfigvihdrtghomhdprhgtphhtthhopehrvghshhhmrgdrphgrthhtrghnsehinhhtvghl
 rdgtohhm
X-ME-Proxy: <xmx:tABKaGup5GXDG8qycrm-gAlT7t57XgDEZUiaEjH7tqwVn2-lkuI_Vg>
 <xmx:tABKaOcIegftU2BmVkIrcWzN3mzC6ZZyVRRjM_B8GLt3uX1PGOVzrA>
 <xmx:tABKaK3wz9q7PI0jRhPBmNsd8imWwXPu97v1kKtUWN3I7Fis5bBRkQ>
 <xmx:tABKaC953lRMjUtA2SYRCSBOUk_CTBzo4evLnK8ryaN3vJA_j1nR7w>
 <xmx:tQBKaHuxG7yMevRcKri8wRlH8t06TAUtqYToerg4x8piZsskC1sgmSVC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 18:18:26 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: Re: [PATCH v8 2/7] latencystats: do not use floating point
Date: Thu, 12 Jun 2025 00:18:24 +0200
Message-ID: <15450130.EVyyLHbfrO@thomas>
In-Reply-To: <20250610141355.91759-3-stephen@networkplumber.org>
References: <20240408195036.182545-1-stephen@networkplumber.org>
 <20250610141355.91759-1-stephen@networkplumber.org>
 <20250610141355.91759-3-stephen@networkplumber.org>
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

10/06/2025 16:12, Stephen Hemminger:
> The cycle counts do not need to be stored as floating point.
> Instead keep track of latency in cycles, and convert to
> nanoseconds when read.
> 
> Use scaled math with exponential Weighted Moving Average weight
> of .25 to avoid use of floating point for that.
> 
> The average latency took too long to "warm up".
> Do what RFC 6298 suggests and initialize on first sample.

An error appears when compiling patch by patch on Arm:

error: implicit declaration of function 'llabs'
       glob_stats->jitter += llabs(delta)
note: include '<stdlib.h>' or provide a declaration of 'llabs'

I can fix it while merging.


