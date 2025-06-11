Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C21C678DC
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 15:09:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EA09402EA;
	Wed, 11 Jun 2025 17:09:00 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 47D82402DB
 for <dev@dpdk.org>; Wed, 11 Jun 2025 17:08:58 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id B617411400A3;
 Wed, 11 Jun 2025 11:08:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 11 Jun 2025 11:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749654537;
 x=1749740937; bh=ptqKtIvAB5VGWkSk/XezC8IQfCenw4dn//MLO3rzf24=; b=
 jylw+oRAzb/ZtTGEjskuwIQoMwbmO3oaCgj0SAFalaU840SxkW6o5i/B2dXPHEhJ
 97LPWaDuQ9gfllmGxEY5I+gJpb4XTYUmmkeh62R18qJV0Cbtj7cXjL3bj/OI1MlG
 myhjggtY7e2GX/EzGnZ3TaCliuDRlO2HZFWW1F4XEQjfTi8Epxy9BMpSj/7c3E+q
 v49alc2Wgb879IT/RJ0rukbmbTlHDPP5Qwb2E3H8iImz8/7t+4YUQOurPkhCeK9w
 OAKfTFwydr4P9XgM64UTD6+fOzRycLxzPFzuOvHbEacWLFk8Jb7Fhoz+UHEdpduv
 tRJQxIcY4EnTTsekCkPBuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749654537; x=
 1749740937; bh=ptqKtIvAB5VGWkSk/XezC8IQfCenw4dn//MLO3rzf24=; b=e
 tl6x8GnBPkNajWMc6Yu34y1qfpejPDul0d8ZsE5g//RqQve/Hlw1YA35KrLsS9cZ
 /CRhUNaWSEEwd0K5raIhMwlnzB4djc7cEacKQbacOog3Et7/jyj9C1gOCJUn5nHS
 dQNWXkfTLdKk/LoaRoovAiKDdKyAjCPNLC7XXhpq/IVfq80oL+2K8fVMCaBXc+m0
 syoJfEzCvUTD6tpPSSFOB5eqBgl57ycKgQFaXMxT8apdxQ5GMuy24HdN2KDHbILD
 3Jj8YNJSUJAhn48a/xzLYkvgCHUcUd59tBCa4kNX7Bd0ZC4pQ+Yc9bqYAYHDo5pA
 v0xXPWWv+4KFPKbns3ciQ==
X-ME-Sender: <xms:CZxJaCacHEasjo7ib5_on3zNly7ueC0ijD2FwMANboDITEoDF-gnXw>
 <xme:CZxJaFa8dr1LDIdbMsjHFF3Az7n2BF8VKYilzkp0Qa9M-goedCixKwdwYLm0oRx86
 6Og3jEu2-2UMC7zWg>
X-ME-Received: <xmr:CZxJaM_Ma4OY6mUxTvCWO0a5JL8C9fPwR9ZRRVGwN_A4pdsuMW6IMiCQV3gyZtM3EN3-yS4yZiCXRdDFCRXN2arQDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdehudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvg
 hphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhgpdhrtghpthhtohepmhgssehsmhgrrhhtshhhrghrvghshihsthgvmh
 hsrdgtohhmpdhrtghpthhtoheprhhorhgvthiilhgrsehlihhnuhigrdhmihgtrhhoshho
 fhhtrdgtohhm
X-ME-Proxy: <xmx:CZxJaEqan2RJgrnoAxHo1fgBo4SdnCOD33f-tGPfOIzPUVrGffgrpw>
 <xmx:CZxJaNrxDuEw1FotR9M08x462XG9knhSdQhKMHDQOvAZIk9thmVfdw>
 <xmx:CZxJaCRyhcLmW6iduXQxPf7xxzN83GoRhxStT91hvy-qLetmJmrH2w>
 <xmx:CZxJaNqCK5vdc0WCkReXDW_W743wpQBhbQWoakp_Ve_zy2Zg60ZaRw>
 <xmx:CZxJaLyrmPqGfp92nLLJ3GbBJ9biUD4j1YAhf_BM75gr0kYgudhnGudc>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 11:08:56 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v9 01/15] eal: introduce new secure memory zero
Date: Wed, 11 Jun 2025 17:08:55 +0200
Message-ID: <3876454.QZUTf85G27@thomas>
In-Reply-To: <20250611075727.31e3b44a@hermes.local>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <3950340.g5d078U9FE@thomas> <20250611075727.31e3b44a@hermes.local>
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

11/06/2025 16:57, Stephen Hemminger:
> On Wed, 11 Jun 2025 14:34:49 +0200
> Thomas Monjalon <thomas@monjalon.net> wrote:
> 
> > 20/02/2025 17:27, Stephen Hemminger:
> > > --- a/lib/eal/include/rte_string_fns.h
> > > +++ b/lib/eal/include/rte_string_fns.h
> > > +__rte_experimental
> > > +void
> > > +rte_memzero_explicit(void *dst, size_t sz);  
> > 
> > This function is not about strings.
> > Better to move it to rte_memory.h (even if not ideal).
> > I'll try to move while merging.
> 
> I chose rte_string_fns.h since regular memset prototype
> is in string.h

I know, and I think the libc choice was strange :)


