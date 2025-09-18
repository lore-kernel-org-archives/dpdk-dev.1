Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB56CAC597
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 09:47:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC14640288;
	Thu, 18 Sep 2025 11:47:45 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 40F844027A;
 Thu, 18 Sep 2025 11:47:44 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id ABE5AEC0213;
 Thu, 18 Sep 2025 05:47:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 18 Sep 2025 05:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758188863;
 x=1758275263; bh=3aWXmkXXoNU572Sd1oCJcGwR6L8cZOKGqYddQzdlXoM=; b=
 VmBThQmuUHDCjRMLn87fzP/NIqigvNMQI7GJJdtzp0Q7eeimfWO+CDNiwRyqVJ3c
 dca4ACZeVKpyVH6hWbyFWfkDtuI1EbvS6c2fvrsQOdYtplz00L+oJnco4rlsTTA/
 QS/P2UbkNEiSQmW3byTA9NwXZGI9TobTlx+OYVTr5DK1IRxvgpBxYmVortW1YNKr
 fNJ/MxoR0OJV9+/TZL9ajPprY6DcRPN1hq1CSvaKphvYKf6EZjVOkIhZUXOBxCZ6
 mYrV4Iwl0Qd2chwhA3VO2gKIocpfVjL122LjAw8SW/phyZR3skECPr62/k+7HIou
 NN2ftaidt4ix93FpIIRG8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758188863; x=
 1758275263; bh=3aWXmkXXoNU572Sd1oCJcGwR6L8cZOKGqYddQzdlXoM=; b=Q
 kUOtwl6g7AVDeUEyBJLuQ4SEp6+UpnMFKwFQPN5s4vxADIvAe7QWoRUntOd/kpJE
 3Z6ysnAeluNSvi05oyg9q+XOLhqCYNYHn5hl41w5mNDNBii6SbglsF2SCUSnbRio
 hnWTGAUfFbrTnqfHyxOvQEEKpL+ERoC5bjX9LulRIozZOWC9y8slQeZJIj8KjKqF
 P9e9dJonhSM20AeF1loZD9hv4yKPR2AtILweyxTKh9kOf3x64VEsrtgGu7V6U/YE
 9Ashr60hazfX7phmPoW9wytVqxm/5G6WFlTGTFf+qazWXv70JqeW3ZGxhpBJRs1R
 jh/nnWFrfEq+TTVsETH8A==
X-ME-Sender: <xms:P9XLaHC4FrK-Qg0w2LRb763Zs1BgIKK9FnQIOdA0W1pVXJK4xjG5iw>
 <xme:P9XLaC47jOz1G_UxmpzwJo1ffrqdgof_0del-7zuuZ4xv4qYBhykgXZbI9hu7JbEt
 I7O98IstwWtC3DNjw>
X-ME-Received: <xmr:P9XLaCxtdUKxG8GV3ktQEus2s1HRKV1XOZtGADoNLOn0ESC1jYARWtBf3VPfKS4Q0242UVU2Ip1_JtnkGvWUqLULlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegiedtudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnse
 hinhhtvghlrdgtohhmpdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhrghdprhgt
 phhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopegshihrohhnrdhmrghroh
 hhnhesihhnthgvlhdrtghomhdprhgtphhtthhopeihihhpvghnghdurdifrghnghesihhn
 thgvlhdrtghomh
X-ME-Proxy: <xmx:P9XLaJyWtzu6THNLzseWHs6RfoIRcgcWGUcillUiGkQmo3PvFcwlNw>
 <xmx:P9XLaKxy7AMszn9iLPxDWhFbU1AOhdpVlNejZoxYibq56qI5tK-b-w>
 <xmx:P9XLaDYYWS4yfVyOvgW-xvXKAAjYnJbjAgO4_ovelbzV0y9Tr9-HZA>
 <xmx:P9XLaLUsdPEb4uek31PjUXKElJIZIHRir59n7mesX9_iToqzribApA>
 <xmx:P9XLaFpWixKO0wEdGGN9FMMKEmfmm_GLfAhPaL6sK-yDHiMgMt9AypDM>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 05:47:42 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: bruce.richardson@intel.com
Cc: stable@dpdk.org, dev@dpdk.org, Byron Marohn <byron.marohn@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>
Subject: Re: [PATCH v2 1/4] efd: fix AVX2 support
Date: Thu, 18 Sep 2025 11:47:41 +0200
Message-ID: <2896588.yKVeVyVuyW@thomas>
In-Reply-To: <879967569.0ifERbkFSE@thomas>
References: <20250918073135.1273767-1-thomas@monjalon.net>
 <20250918091039.1368875-2-thomas@monjalon.net> <879967569.0ifERbkFSE@thomas>
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

18/09/2025 11:40, Thomas Monjalon:
> 18/09/2025 11:08, Thomas Monjalon:
> > When switching to Meson build, the compilation check on CC_SUPPORT_AVX2
> > became obsolete, thus the case EFD_LOOKUP_AVX2 became dead.
> > The function efd_lookup_internal_avx2() was never called,
> > and its header include rte_efd_x86.h has been removed later.
> > 
> > AVX2 is assumed to be always supported on x86 with supported compilers,
> > so the check for AVX2 is simply removed, and the include is added back.
> [...]
> > -#if defined(RTE_ARCH_X86) && defined(CC_SUPPORT_AVX2)
> > +#if defined(RTE_ARCH_X86)
> >  	case EFD_LOOKUP_AVX2:
> >  		return efd_lookup_internal_avx2(group->hash_idx,
> >  					group->lookup_table,
> 
> I've forgotten to say that there is a runtime check:
> 
>     if (RTE_EFD_VALUE_NUM_BITS > 3
>             && rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2)
>             && rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
>         table->lookup_fn = EFD_LOOKUP_AVX2;

So the end of the commit log must be changed with this explanation:

  EFD_LOOKUP_AVX2 is chosen at runtime after checking AVX2 availability,
  so the obsolete build-time check for AVX2 can be simply removed,
  and the missing include added back.



