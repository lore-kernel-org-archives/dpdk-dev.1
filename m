Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5844ECAC597
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 09:40:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17FB5402C9;
	Thu, 18 Sep 2025 11:40:31 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id D66404027A;
 Thu, 18 Sep 2025 11:40:28 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 6461FEC0253;
 Thu, 18 Sep 2025 05:40:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Thu, 18 Sep 2025 05:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758188428;
 x=1758274828; bh=OvznXqtp0lPE7A/0rvX5uue/YQRQhe5fA9fLot3HLa8=; b=
 dFUKQPtbTN6zDqGhnQC++sCHO0IgzHKBBH4bCUZFCl5R/ESuYi9qXrvK3MBwIFxQ
 c7F/3tYbOKXvgrH3jDl2XOWCphxxufpMxZ+Zne2HefuV7N1UhpD9SsoUX2MKGaYC
 AQMzAYH744fOn6VN8u0h+xbMPu8yewcmbuw+5SOG2k5+e0nJg2ZU0z4vLchXeCRo
 j5B/sQwLjm/xx1stXIl2thpTW2GK6F6JmdtjEHEAvECzOx8IZUZfXStIyE36T16R
 2VQPieCft4tg0kFTiT3fnmkd9TzViemZtQvKmZ9rUOb+pu4WpP273C1YpYtB1uvZ
 i4CZUd8M+qltOdf4Sl83xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758188428; x=
 1758274828; bh=OvznXqtp0lPE7A/0rvX5uue/YQRQhe5fA9fLot3HLa8=; b=l
 VLUXEq0VIf43Tvz8GF3irMcHkst8BcSfSIE+loGQLBk+PBvatrAZ3ULkoqlUj4u+
 f3mYfe0qQK+FTiK3iEy5S5dxrvHVYAQQo7+DsbupMJ2IFPAPT9rFDpaffvr8TPza
 kSRNvFc+XVjVF701lfsbnIGcjFgRfvB/XEun8cru6nCtgIOAuX/v3M1C6podE9IU
 Nm3W0VA/aGDLPfnbMYKS9TvWrazWRJiJJMlDHoC0GEtlFk0lYBrWNhR8hexZdU1u
 +jEn+PCwIgaWsfTe4ZeCsvYff0LIqekjXML9UQYY6uzOoh933D6Qz/nz/r0mRJTe
 cNU3wIdtn4KBX+ipbLc9w==
X-ME-Sender: <xms:jNPLaCBM1M59lD0_grEes85dUdfmxBnvpEPQotSCN2G-UN8M8nW_wQ>
 <xme:jNPLaB49NEKUXvsQ75cqzb94qYg4_1SRJ--IuBY4-R6J9WgDidM7zUfO-MbnH-ogR
 Fb6q7DOvdz6NOpbNA>
X-ME-Received: <xmr:jNPLaFzg-5V0-TykEDjCXmdrHbK8T2dXd6o53pDfD54tt_y5CzZ2X-4UBCkKXU3HCZmz-TpkqXqg63ddMDQXMO9pxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheellecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnse
 hinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopegshihrohhnrdhmrghroh
 hhnhesihhnthgvlhdrtghomhdprhgtphhtthhopeihihhpvghnghdurdifrghnghesihhn
 thgvlhdrtghomh
X-ME-Proxy: <xmx:jNPLaAzCs2cJlYRCF-PwfCx5JHjrtjYtLljxLNPjXU5VZGENe6tWLQ>
 <xmx:jNPLaFyRkXj9oSGD3Nvww_PPf20dl9tTQWUvkpSVogGqu_m32F4ATQ>
 <xmx:jNPLaCZJeRzvppsJsR7uSqrv66MWuD_28F0h_vvZi2zpYavaIHjmYw>
 <xmx:jNPLaOWiYH4Vb--DEAsOucxJv7su9r2NcHhrE7aV-Si8X2Ex5Wt27A>
 <xmx:jNPLaOdcuRu3XDT-Ib3FVl7eueEAofMzDS1QZiwpEKStOxc8e90j-Cvv>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 05:40:27 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: bruce.richardson@intel.com
Cc: dev@dpdk.org, stable@dpdk.org, Byron Marohn <byron.marohn@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>
Subject: Re: [PATCH v2 1/4] efd: fix AVX2 support
Date: Thu, 18 Sep 2025 11:40:26 +0200
Message-ID: <879967569.0ifERbkFSE@thomas>
In-Reply-To: <20250918091039.1368875-2-thomas@monjalon.net>
References: <20250918073135.1273767-1-thomas@monjalon.net>
 <20250918091039.1368875-1-thomas@monjalon.net>
 <20250918091039.1368875-2-thomas@monjalon.net>
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

18/09/2025 11:08, Thomas Monjalon:
> When switching to Meson build, the compilation check on CC_SUPPORT_AVX2
> became obsolete, thus the case EFD_LOOKUP_AVX2 became dead.
> The function efd_lookup_internal_avx2() was never called,
> and its header include rte_efd_x86.h has been removed later.
> 
> AVX2 is assumed to be always supported on x86 with supported compilers,
> so the check for AVX2 is simply removed, and the include is added back.
[...]
> -#if defined(RTE_ARCH_X86) && defined(CC_SUPPORT_AVX2)
> +#if defined(RTE_ARCH_X86)
>  	case EFD_LOOKUP_AVX2:
>  		return efd_lookup_internal_avx2(group->hash_idx,
>  					group->lookup_table,

I've forgotten to say that there is a runtime check:

    if (RTE_EFD_VALUE_NUM_BITS > 3
            && rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2)
            && rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
        table->lookup_fn = EFD_LOOKUP_AVX2;


