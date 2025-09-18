Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30056CAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 08:11:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A05140288;
	Thu, 18 Sep 2025 10:11:03 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id BE4AF4027A
 for <dev@dpdk.org>; Thu, 18 Sep 2025 10:11:01 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 63E1C14001B2;
 Thu, 18 Sep 2025 04:11:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 18 Sep 2025 04:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758183061;
 x=1758269461; bh=SgNXledMnwLKwdvYLKlq6TJRDmJrhxU8kzUpRoRTkfM=; b=
 RaDY7XtO/im92f/hVFWkx0Q4TxDeMg51tgE1SjY/fSWKdx14a21crSoF5+R3mMBM
 KIiq91l0V1vTQwkzNtXFvjZoOXl3mVSWjMMLryPrufui3v3JvLmA2nf/miFbjG8u
 PnA6x5ylZdsrQ7B53RGXYqIq+XU+au4Tl0pUf4kSckCZEMA1Fr9B4oB+9k/uBsco
 PRYGwT+iXpD2b7gFbR68/YlNPWnZoYrBtQ7UjHmPJNdj9QIB9YgmSQfp+AHBKrJm
 UHhr+td79lkwDSKuWjTLgR4vGADhzTscENnexFkt+NcXhZ92jZ00PzqNsTL5yPfw
 N+uZ6UpF8K4T9fjs7aVUNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758183061; x=
 1758269461; bh=SgNXledMnwLKwdvYLKlq6TJRDmJrhxU8kzUpRoRTkfM=; b=A
 qcPnX7RIFiv6qLFUJtOnhs2RxI1jAfpT4O9a62B8ZTuOOklkRC1FNiNifXmQHXAp
 YazT5hMbeA5578rSkgEvfGBdGxd3oU0GGhpv1NhVRiqD+aSeMSmHO8FLC2GypE9v
 F7sWkMgR513P6c3zOAPi4VaVo9BUPLcoHG6PsTanIM3DegWh+KiWYNMFlTJ24RJ6
 jbwKg5ZGcntgWyVNrF0WREs2YKY5cbjlR2b8qsJRHf1BXRiFoS5CVAzPnUtEWk6X
 CAiKDQYnqiULM2JvNlqENbkAdZl0ANRrVowbkqWxq/CsCHm3QVhsKFrFQv89ysIk
 rsNmlrsq0KRXCU7dWeFqQ==
X-ME-Sender: <xms:lb7LaJFUC4hFZAIZBDVE5uyagZK4vLE7exzoeOC5ToQUC9elbYWPpQ>
 <xme:lb7LaDlReN2x9PPDAUopTlbnCWpIy_yTKtYFjgfX1ywwBrl0EVRFXrDsbpQNhNykH
 LTIreeWuNlF6f6ekg>
X-ME-Received: <xmr:lb7LaM1qU4wpxuZskiNHsaWLAHZP593ucwq0CrDef49XMxTrrfP42M0dhxqnI_ft5nw-k2bhbRYf9uvuznC3ZZy1aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheekvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkjghfggfgtgesthfuredttd
 dtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhho
 nhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgf
 dtgeekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvg
 htpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegs
 rhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopeguvg
 hvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:lb7LaHSdvSBnpZ0PSaUv79nBQ9QXVjEBVZ3fEt3dWsForeuW9A3CWw>
 <xmx:lb7LaGuL_DLFQSXBRFNFX4OozdXOiZl1RUWvtELpoEWIaXnnZG-CGQ>
 <xmx:lb7LaEb8M9Wkl4LDgjLaXvqizKBpoYgLtioUKigmDg-_FlK9cWjTlQ>
 <xmx:lb7LaDs56V0tOKdvHLevZXk-42GGUZKRVzxhShAe7v0VgPIPspaAmg>
 <xmx:lb7LaGly3vkhr4p2v9sQvJx5g_QhRIoTHmWFZZGzZPFkDxiXmT7xD8az>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 04:11:00 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: bruce.richardson@intel.com
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/3] lib: fix AVX2 checks and macro exposure
Date: Thu, 18 Sep 2025 10:10:59 +0200
Message-ID: <24958055.6Emhk5qWAg@thomas>
In-Reply-To: <20250918073135.1273767-1-thomas@monjalon.net>
References: <20250918073135.1273767-1-thomas@monjalon.net>
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

18/09/2025 09:28, Thomas Monjalon:
> These are fixes for AVX2 in efd and member libraries.
> While at it, I've hidden a macro which was wrongly exported in the API
> without having a correct prefix.
> 
> Thomas Monjalon (3):
>   efd: fix AVX2 support
>   member: remove AVX2 build-time checks
>   member: hide internal macro

The AVX2 changes break the compilation of "x86-generic" with these messages:

lib/member/rte_member_x86.h: In function 'search_bucket_single_avx':
lib/member/rte_member_x86.h:35:28: error: AVX vector return without AVX enabled changes the ABI [-Werror=psabi]
   35 |         uint32_t hitmask = _mm256_movemask_epi8((__m256i)_mm256_cmpeq_epi16(

lib/efd/rte_efd_x86.h: In function 'efd_lookup_internal_avx2':
lib/efd/rte_efd_x86.h:24:17: error: AVX vector return without AVX enabled changes the ABI [-Werror=psabi]
   24 |         __m256i vhash_val_a = _mm256_set1_epi32(hash_val_a);

AVX2 must be forced on these headers.
The solution is probably to move these functions in .c files
declared as sources_avx2 in meson.build.


