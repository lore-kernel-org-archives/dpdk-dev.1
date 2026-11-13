Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B483606A64B
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=FaY0FJsv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A5F9402A4;
	Fri, 13 Nov 2026 19:47:17 +0100 (CET)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 9992C4003C
 for <dev@dpdk.org>; Fri, 13 Nov 2026 19:47:14 +0100 (CET)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cdadf7e248aso518132a12.3
 for <dev@dpdk.org>; Fri, 13 Nov 2026 10:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794595633;
 x=1795200433; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MzuS+bCTFXqNSv6gH3+MtYqpdk5d3mC45+nPZ1haAXI=;
 b=FaY0FJsv/Kq1+YSxC6dU2bCNa6h9f76SDxz0cpsSB4pRbrMTYcPT0a1FmdQpEi1mgF
 QwKVXiiefTK64JwkWX4iLjK58fHSi0Gh+lt0o0dQ5pzP7V55JAxFKsYV5uIaDSWJGKSY
 3eqHoina8PBqAnR6gnD5r7etf9oyl7F2Tb01HC/x5vrTIE97Jc33Fq0Pz+iS4Vp8+kTn
 mSknbLOd8GMaJvKzazLVBaA+FnC72AVBZyTx+7/Bf7mzelp5bb0esA6OqqMmwAZKfD5i
 qxTXn4+LUl0cp+k90yzOwG/uC/g5gmMjsEJ96K6auCNXxC2xH/Su3/QqMlyzCSVJjZuS
 cjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794595633; x=1795200433;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MzuS+bCTFXqNSv6gH3+MtYqpdk5d3mC45+nPZ1haAXI=;
 b=jkp+yVD2bt3gDTzMVI0gpUWJuZ3sMtxUox9PQJHoWSqzTjOZn3a1NLE2YUZ1lfDKES
 LJ6//nx70bYzc7v/2Q2Xonj8MDwpB6aDrcl9rzeayBhWau1kQg15U4TFH34RiHRo9+aM
 zaIdzSVwJhASKLekR9OGg6kgVts+RqKwNVGKe/+6wZdaLhczoMlh2nqfh+SyoXQu4NHX
 pJxU2ghXlKZcPlT8g0fY0KOkuvj1+MLWQI2La5ODGHJmYT7hGNVCnKmMYEnWpsP9Gb42
 P3dyGzdJIhX2NV5i2HjGEYHtLpQtSW3wzVJQz3cY4nCy/FpmhBVao3YS5RgxGBIgVzQl
 qPlA==
X-Gm-Message-State: APuU4Z8IcQ585HKgWhVOJXdQs81/Vf7Uq3CTw8X5L8Zq7OWOKJK2LUVi
 +go6aIfbqopTI4ICkoiquJYRZoXIvhh1s5j8uR1hbChh4jiUZlLHt0jdYAsyHWEffsY=
X-Gm-Gg: AYBFou13Sn3T01y8qAdtaTichKy8rjJLX+eedw1somHCOHejrkaOvAm2UD1L4TvVeHP
 6PbOT/WlI9u63almR66sDgOW60qmHROZKeHS+tJ/mOm8IYK/ygfywz1bCJZJuLfgRS4q78xoZNS
 8/rCBksWhLfLr/NvzW8P8HO5lonwwQtDcBQU00UQHUr9jGcMmG5nIDKMbPA/Tsgr5QlmPKtf1mo
 j49HErkScTDBapSotStai/pb1Z1ACUOB3xBD4Vqh4601BaxIeFQhRImNTdDFXzWF/rl96nzNVPc
 0uW5huNJq+jC95WdcyN2XH1yePgC/YFP2xrh/AUCZbwuhCz0q6N4pfSDjVWzmlzcEmC8aqu3PZY
 YkWP2pRG80vr/z9L/xQ9fQiJ5QF8wb2aPYIiE6eMO2N6FoFkey1kiqTR8eUvsZKSUI0wPazoSjN
 sZsaxu6x1woZPLnz/SKHCBCy59cmzxd2be8gE0zL4bKh6mNi07K4cQgYqvAT4dW4zRUi3doqCqd
 5sSgDvwBmFg3oOw1nqBNa9IzdK9zaBmr+THVNjFRyfGtcLlxNe9nxd9P8+o1yXVHQfZWXZjbEax
 zKmGj90qdpGdfVkFuTNdU2ssrn8q1FLpMXZFw8zlgZX9AAEdyVghoi/hQvTQ/MHP/sPG/LabnA=
 =
X-Received: by 2002:a17:90b:1846:b0:3a4:6f38:f2a2 with SMTP id
 98e67ed59e1d1-3b1b0a3e7bemr2790568a91.25.1794595632998; 
 Fri, 13 Nov 2026 10:47:12 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b2133c5dsm2435624a91.0.2026.11.13.10.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 10:47:12 -0800 (PST)
Date: Fri, 13 Nov 2026 10:47:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/3] deprecate unneeded build options/support
Message-ID: <20261113104709.5538f414@phoenix.local>
In-Reply-To: <20261104201506.4091374-1-bruce.richardson@intel.com>
References: <20260602090847.905721-1-bruce.richardson@intel.com>
 <20261104201506.4091374-1-bruce.richardson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed,  4 Nov 2026 20:15:03 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> Having unnecessary build options just makes things confusing for
> the user, and expands the set of potential builds. This set
> deprecates 3 build options, including deprecating all HPET support,
> and marks them for future removal.
> 
> ---
> v2: rather than always building HPET to remove the option, deprecate
>     all HPET support, which will also allow option removal in future.
> 
> Bruce Richardson (3):
>   build: deprecate kernel dir option
>   build: deprecate standalone tests option
>   build: deprecate HPET support
> 
>  app/meson.build                      |  6 +-----
>  doc/guides/linux_gsg/enable_func.rst | 32 ----------------------------
>  doc/guides/linux_gsg/sys_reqs.rst    |  3 ---
>  doc/guides/rel_notes/deprecation.rst | 11 ++++++++++
>  meson_options.txt                    |  6 +++---
>  5 files changed, 15 insertions(+), 43 deletions(-)
> 
> --
> 2.55.0
> 

Series-acked-by: Stephen Hemminger <stephen@networkplumber.org>
