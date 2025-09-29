Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8234CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 23:54:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B52BB402D8;
	Tue, 30 Sep 2025 01:54:16 +0200 (CEST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id B45C2402D8
 for <dev@dpdk.org>; Tue, 30 Sep 2025 01:54:14 +0200 (CEST)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-80ff41475cdso51352566d6.2
 for <dev@dpdk.org>; Mon, 29 Sep 2025 16:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1759190054;
 x=1759794854; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8yjbk0nw9bPJVfxqsjidEJuO3KYNBnUETvoxWrwWPKU=;
 b=ZyhXjpJ8Rn6Oehtz2VdcARq4wzh99bJS3EU/PhTQ+bP/GWamg91BSfBQ+XYqaQ0OZC
 nsli7r8PISZowSvpquhY+MkYRW/Y6ZJeRWbmozAmEhZ+N36ETkFHk2gp0lBu/bP+LtWG
 I1GBV5tQR+02+nAG8Wx1dzJD+KrnCZvops5yHDQ4cqtHGyJrm6NBTU/agQjPHhRsA8Ox
 EUdnVMkli3sV31PWO4RK+21tJxsvhWa6CAkoiNbU133FJWkuDZIOL7akYT9QGpxPZBx3
 oYYs8Bm7js5brDhbS5b/JgdwRYz4Kq48TgQT6uic94fFMbFwTyv50UWbTWwwH4MXirKG
 e9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759190054; x=1759794854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8yjbk0nw9bPJVfxqsjidEJuO3KYNBnUETvoxWrwWPKU=;
 b=M60Dey3nPoVuLiJqb0k2pZcMh/EfVkUNU5OIDBxQOYW8wEmnsh7SPLlqu9SHiz5CyQ
 i6ZG6BJYb3nQiLOv28IG52y8GR1HQ4h92pRMiLj5p6HtV70rUMe/zMdRenPJdmf2YXJT
 6kruSYM3o+ml0iyxl/jZE5fm+g9lNlCvgqrrypciSLRJgpFqyJNSfgepKLZ2BXv+ieVM
 sL6QlUA4mSTNKw9/9B8Ba7hWPAMuuWuXa+l2rphrf4H6ryg9BZUhKbpQIBRR4rDuQeUR
 mX57OxF3hsfBRTgA0VQNgR9A2s3H20hVNb5ZAPsZsh13SWumg2OmRohVGR66AYoeaqsn
 fPTw==
X-Gm-Message-State: AOJu0YwVUWPdqRsWlXFrSjNLKulboXfbPKf5x7mZmyYza4/Pa9ts/zhe
 6noxjRVIn/pT8268joA+NtnulN1dfMktZ5UNCPKSBYeX0B3lIo2WjP+l5OYd8MKLMdo=
X-Gm-Gg: ASbGncv1QS/oz4277oLs/KWG4jOOmCqrVR8HZ6mFLCN6f+0Dy4rUVW02+sC3FBvnZWt
 GbU4TtoR25GXflrC01nD7XZXmNjV8KtEXTa7LCi9JQzBiYDH7I8jMi1jsvGUIPq6DIg7ivyjdIg
 fDNUiDr3k/L87+2GkgsD4mg6QzhLL0R8sSRkGJAe5vGGJEQY6RRPl5qGbJ3b/jESuG6L+yJEzOI
 +B4bFIvrzdLXEWZ6wkAOG6dgyfoSOQaBf7q9ZgtnynbBNCW3o3Q+JSlCrw4kouU2zbL8X2hP56G
 17onSkwUvAcqJYjpmFLBp05Zzy5NjfGneLnyc0B/A101SO/VhAk2D8BIb7Z5nERSOTEj9CfjWkY
 njCi8EJiq5Xq7iN+sNr2fTTpWtD35ectHSK12z7oxM+JCjTaain9VbTLmHoHfaIy+RUyopGUhJB
 nhRbOR08xtwQ==
X-Google-Smtp-Source: AGHT+IHj5UMiuMRuwevDGhyDaKwiVOm3hb1bxDrqBbK9Q0d+3IP1d6J3bjYiIqo3ygLtSCP2UzupMw==
X-Received: by 2002:a05:6214:519c:b0:782:3e4c:9ea0 with SMTP id
 6a1803df08f44-7fc417af022mr254880646d6.59.1759190053959; 
 Mon, 29 Sep 2025 16:54:13 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4db0b9458e1sm83823621cf.15.2025.09.29.16.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 16:54:13 -0700 (PDT)
Date: Mon, 29 Sep 2025 16:54:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org, gakhil@marvell.com, konstantin.ananyev@huawei.com,
 bruce.richardson@intel.com, thomas@monjalon.net, mb@smartsharesystems.com,
 stable@dpdk.org
Subject: Re: [dpdk-dev v4 2/2] crypto/ipsec-mb: use constant-time memory
 comparison
Message-ID: <20250929165408.1c9d9d2a@hermes.local>
In-Reply-To: <20250929145049.153078-2-kai.ji@intel.com>
References: <20250926160209.56496-1-kai.ji@intel.com>
 <20250929145049.153078-1-kai.ji@intel.com>
 <20250929145049.153078-2-kai.ji@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 29 Sep 2025 14:50:49 +0000
Kai Ji <kai.ji@intel.com> wrote:

> Replace memcmp() with rte_memneq_consttime() in cryptographic
> authentication verification operations across iipsec-mb drivers.
> 
> Note: OpenSSL crypto driver already uses CRYPTO_memcmp() which
> provides equivalent timing attack resistance and is left unchanged.
> 
> Note: scheduler driver memcmp stays unchanged as its not secret data
> comparison and actually faster with no timing attack risk.
> 
> Bugzilla ID: 1773
> Cc: stable@dpdk.org
> 
> [0] https://bugs.dpdk.org/show_bug.cgi?id=1773
> 
> Signed-off-by: Kai Ji <kai.ji@intel.com>
> ---

Thanks for doing this.
A couple other notes from my searching around.
The function memeq_consttime is in NetBSD (not FreeBSD) sorry if I got confused.
OpenBSD has timingsafe_memcmp() and timingsafe_bcmp().

Also this on LWN:

> You would use a constant-time version of memcmp. OpenBSD added timingsafe_bcmp in 2009, and then timingsafe_memcmp a few years later. (https://man.openbsd.org/timingsafe_memcmp.3) NetBSD has consttime_memequal. (https://man.netbsd.org/consttime_memequal.3) Apple and FreeBSD adopted the OpenBSD routines.
> I don't think either glibc or musl libc have adopted a similar interface. So on Linux or for portable software you'd probably want to use CRYPTO_memcmp from OpenSSL.
> 
> You should of course be hashing the passwords with salts, and only comparing those hashes. In which case using a constant-time compare isn't that important as the attacker can't work backward from the short-circuiting compare to decipher the plaintext input. The hashing itself should be constant-time, assuming modern digests like SHA-256 or SHA-3, though it's possible the *length* of the input password would leak. But there are a gazillion ways for the length to leak, and when it comes to password-based authentication schemes that's the least of your worries.
> 
> 
> 


