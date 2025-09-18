Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2304ECAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 08:16:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 810F04065C;
	Thu, 18 Sep 2025 10:16:48 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 3EB2F4027A;
 Thu, 18 Sep 2025 10:16:47 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E8C1D14001D7;
 Thu, 18 Sep 2025 04:16:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Thu, 18 Sep 2025 04:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758183406;
 x=1758269806; bh=QhDbMEzEk2UitaCVXyzRrEn8qv5jR6xtbiCOa1Ct/5E=; b=
 cHYbGyp/InecL331Z4zCBa7Y0GniT+2sfxw1J4rGT4o6BXz6ts6Vzi6G1FdsRGjO
 cq+v2IsdC6OTUsawKpFoxyBaMQ+3nwhB8hdLxcrLwoN2xSCIwHcQoe7gKhMNHv42
 viH8lSznKS/2rkqH3lNAjbJtxPjxV4GI2SiuS4iSL1cvY+gyiqRpoKbWxk1WYbeC
 ee2ir8xS5YvJKGXada9g70nxQLXlWYMI891BuqX0HkAyyofKV7CRtZ0fBmWWI+LY
 g6EfguQmiV+wNpCshNsq7DwYn/IWtqGur7/WcVsqdr2pWM1aYqK/n/0bhewJQl2A
 ZlMGhZKbk3FVS1j/ut9pHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758183406; x=
 1758269806; bh=QhDbMEzEk2UitaCVXyzRrEn8qv5jR6xtbiCOa1Ct/5E=; b=j
 kexEBa9+P082hqJVdxGOh/fWday7v+lYe6ip1LBNzwDJfoTZSjHUy5OmzJeyJGs2
 Dll7/9WGdG1c+GV0125H1teAW9sDr4UmAhUTKTiveFCb7pnm2fxm9Ra45n5s+Ntb
 i4SLOBo5R8dwjzzwSp5cAZJXgH27P1580wvIZD+kKyohBvCK6Tl4R2ijWXmVNjH9
 JQmsqK5rcnqc3R39vTty1gDi/E7TlNq+HS6IrA2Kod4zhgiCdMwZpjwbjwnwi8/e
 ceD1x0qR18XcuHifAgeLQ67Y1uiNBnSgkLiwdeyVyxf2F8MD1F9ygYmm3bNpgZAR
 HLPqqGbxZ2ZAuJ2FQ6KVA==
X-ME-Sender: <xms:7r_LaPHvAHlcPt-tLgVo-Op29COBbakPOPorGiCEiQH1CHE1RvI4bw>
 <xme:7r_LaKT3XeMk2IHawGwfw-oK7RtdWHPwvJfAvSIafHjKNrS_1zu8Ki1YwR-u155cK
 cU1bdWqtAkrG8XPdA>
X-ME-Received: <xmr:7r_LaDcKIbaAq3rDuqv7EZllYB0ar5pgArFZ9xAolUVcocd3_zmBn4UTwbe84zUT5-_RibCKcru3cDoGgBIaDK6IKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheekvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnse
 hinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopegshihrohhnrdhmrghroh
 hhnhesihhnthgvlhdrtghomhdprhgtphhtthhopeihihhpvghnghdurdifrghnghesihhn
 thgvlhdrtghomhdprhgtphhtthhopehluhgtrgdrsghotggtrghsshhisehmihgtrhhosh
 hofhhtrdgtohhm
X-ME-Proxy: <xmx:7r_LaBoetqAUUawJE31plg1sElsKVkXmDCFrNDEnbTTlAj2LDF2gMA>
 <xmx:7r_LaM-cezxIwpPMiRSlCvTNWOKrdEBigy0u6rZfulB1sLIVq2ipjQ>
 <xmx:7r_LaFeNzUZ0ZlcsXF9eOkBXDsznmj0ELxONV3iWLfq-Jpbx5_bAcg>
 <xmx:7r_LaOJ25R-RGlpf2OAHDjIX_oQ7KshIvvbbjz1D8nA6yCcIjR1LrQ>
 <xmx:7r_LaDn5ACKyQyppWOl1mOZm1rg4gd5kFnp-ppGJ5xUMwEbp-3a7H29F>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 04:16:45 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, Byron Marohn <byron.marohn@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Luca Boccassi <luca.boccassi@microsoft.com>
Subject: Re: [PATCH 1/3] efd: fix AVX2 support
Date: Thu, 18 Sep 2025 10:16:44 +0200
Message-ID: <4582603.R56niFO833@thomas>
In-Reply-To: <aMu5MKGFjrrffCnv@bricha3-mobl1.ger.corp.intel.com>
References: <20250918073135.1273767-1-thomas@monjalon.net>
 <20250918073135.1273767-2-thomas@monjalon.net>
 <aMu5MKGFjrrffCnv@bricha3-mobl1.ger.corp.intel.com>
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

18/09/2025 09:48, Bruce Richardson:
> On Thu, Sep 18, 2025 at 09:28:03AM +0200, Thomas Monjalon wrote:
> > -#if defined(RTE_ARCH_X86) && defined(CC_SUPPORT_AVX2)
> > +#if defined(RTE_ARCH_X86)
> 
> Ok to remove this, because indeed all supported compilers have AVX2.
> 
> However, given that the efd meson.build file doesn't check for compiler
> support and optionally build some extra files with the AVX2 flags, I wonder
> if this define should actually be changed to an __AVX2__ one, to detect if
> the build has AVX2 support rather than just the compiler.

Correct

> > @@ -19,7 +19,6 @@ efd_lookup_internal_avx2(const efd_hashfunc_t *group_hash_idx,
> >  		const efd_lookuptbl_t *group_lookup_table,
> >  		const uint32_t hash_val_a, const uint32_t hash_val_b)
> >  {
> > -#ifdef __AVX2__
> 
> This may not be safe to remove though, because AVX2 support may not
> actually be present in the build. For example, when doing a default build
> with -march=corei7, __AVX2__ will not be defined, because the target CPU
> doesn't support it, even though the compiler does.

Correct

I was sending you an email to explain I was at this point in this series,
but your review was too fast :)

Because compilers have the support, I suppose we could force AVX2
on this function with the impact of not being inline.
But given it was not used for years, I believe it is OK.


