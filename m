Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A933EB28FE
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 09:57:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49A474029A;
	Fri,  6 Feb 2026 10:57:35 +0100 (CET)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id B8F9340293
 for <dev@dpdk.org>; Fri,  6 Feb 2026 10:57:33 +0100 (CET)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.stl.internal (Postfix) with ESMTP id EBB4A7A019B;
 Fri,  6 Feb 2026 04:57:32 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Fri, 06 Feb 2026 04:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1770371852;
 x=1770458252; bh=fBiMWkZejgC3b8Vv0DATA3eKb4VdIXWHXxlafi5ug5k=; b=
 I3uKRAuU0S6+7PGMQfRlr0cBDv59DGcH9PHkc3c1AHkbT22Hjtue2XMYCUMk5sv7
 Y9SaKtaKUKmwn3OdPeTcFhznp6lJmcvObBqKf/1uVNvjLCXiBE3goTnd1yjc6+2s
 Khr/Y8qr4mOScEMkMW/qm7BMYm9BOJ+USPfuEIMpo7+DzNgDNf73W9awx4pdKDrg
 r9JIv+6UwgFGzdneFy4hJfUpxuiWtpqjrXITCizSBSzUYMr9/s1CgidlreCBjLj6
 jJJpLIRI0CBRPyaHPnhbrTuTvBUPArtvs7w1U2+Xj90PBnBOkTIEtYz82zIqGXeK
 rzf3R7LmDSAIsrmXJEpfwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770371852; x=
 1770458252; bh=fBiMWkZejgC3b8Vv0DATA3eKb4VdIXWHXxlafi5ug5k=; b=D
 6TbEpYjXCCu07OVwzzKYBvzeQIhCw7ud06sDIBvhlQrAN8XMd4uPiNYjLb1DV8c0
 4nFIMKPDo8ZdUOz1S9XT1K9D61zU6N1HCgpmXKDEaUGytxg/GUryXAp7Hfdimh0L
 029tOubkS2FTgUq1FunvHHx54+qVVuQSn8ng+B30LJn9vefgweBrsz41ybd11M4C
 GNRroMA0husxoMcaDFD7UlzmzFImzds50CoE4yW7iFdBOezUY0YOjaip+EKxAXbg
 TZkfOjUk+g3a2fsiraPob58UkXR56ff4wwQjWrSno7M3y0oJ4h800FjF/UL8ysjd
 1brPLrD7DuQ+YrSFSSaNw==
X-ME-Sender: <xms:DLuFadcltHo-sZe9AzLwm1ZytRkORhXT91WA0pN9T8sjqRzEhsJ4fg>
 <xme:DLuFaXgzki5YV3oXZBFceeJlOY1A9nzXZubmQ-sq9NDr6hOpUePoReiEjYoYA4D9k
 n0sSpWoKr20XAxDIfnwdee3xTkDrzqdt_wTTPSAuW5FprBZ7wVb>
X-ME-Received: <xmr:DLuFaZTDHMCiKMDTHs4pxk8XYfOygmGSAZXsJudU8eOJ-JEMIaE9zfzAneje_C2-TMhmIebEWU9xCvqs2E1RrwOUUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeejkeeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertd
 dttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevff
 fgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 uggvvhesughpughkrdhorhhgpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhguse
 hrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:DLuFaYzd-SBUS5wdwUczW1FJXfr5JwfBUnRv3mUL0jkiL8zyfhpg5A>
 <xmx:DLuFaccSyGANTrn6GMpXyVZfgL7zlg_LX90tWDrIt18Y9gdEqIpamA>
 <xmx:DLuFacIRXf-H0Fk17GxbFIvctdMiMSkOZeLzsoczu4lKrBZtNvmY0A>
 <xmx:DLuFaVFZM91gBrb7jtF94K_Gj239cayehk7UT27VjAO7BcN1CyRNLQ>
 <xmx:DLuFadwE1iy5vf9fnq4t5Y8pLPRjyTrPOelck_UuHlAP4TM7EQMENz1w>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 04:57:32 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com
Subject: Re: [PATCH v4 00/11] more build tests
Date: Fri, 06 Feb 2026 10:57:30 +0100
Message-ID: <6535162.Sb9uPGUboI@thomas>
In-Reply-To: <20260205213044.702908-1-thomas@monjalon.net>
References: <20210412215339.2439530-1-thomas@monjalon.net>
 <20260205213044.702908-1-thomas@monjalon.net>
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

05/02/2026 22:27, Thomas Monjalon:
> While testing more build types, some errors occur.
> 
> v5: add minsize and fix debug build types in GHA
>     fix new warnings with minsize and debug builds
> v4: fix new warnings with minsize
> v3: fix minsize build with GCC
> v2: fix init of var buildtype
> 
> Thomas Monjalon (11):
>   mem: check fbarray name truncation in secondary process
>   mem: avoid hugepage path overflow
>   argparse: fix minsize build
>   mldev: fix minsize build
>   bus/pci: fix minsize build
>   power/intel_pstate: fix minsize build
>   net/bnxt/tf_ulp: fix minsize build
>   net/iavf: fix minsize build
>   ci: fix debug build type
>   devtools: test different build types
>   ci: check minsize build type in GHA

Applied with the fix for the undefined behaviour of asprintf.



