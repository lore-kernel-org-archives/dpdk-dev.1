Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81987CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 23:43:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6F4E402E1;
	Tue, 30 Sep 2025 01:43:24 +0200 (CEST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTP id A71E2402D8
 for <dev@dpdk.org>; Tue, 30 Sep 2025 01:43:23 +0200 (CEST)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-4da37f6e64cso44640181cf.2
 for <dev@dpdk.org>; Mon, 29 Sep 2025 16:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1759189403;
 x=1759794203; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5VduP5azQ5MY+2E5pEASrxTozJilAR1y+JilwXdLWug=;
 b=NN4o70ZFCwUYgCxatStbvb7yqyHvrrPheI8DhlMgTjffXFmr8KI3gjUHU/yIg82ZQ6
 yN4iVsdApv+3TMg+GXQ5SVBdOOrTZ7rlYxIm4IFoFqEvnxmbsPJEdPYwqdHh88pH/hWX
 1xiQH1tLXvbmhoXXYJcDqeQtt7stRns2K/x50cw2qsFACYbg3GH7b0KHvPtg87G+LQVF
 tx/TDAUURD+3YfEhZmL8S+h5840icLejCXSb4hbcIgyfFap+6eZtcPc5eilRVr5IrytI
 9Uqyku07BASdqdaicb5stTBcOWd5rmsFh2GKgGGTIdvAw8F42dXGitLY3mZ+3Lc0UYus
 Dypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759189403; x=1759794203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5VduP5azQ5MY+2E5pEASrxTozJilAR1y+JilwXdLWug=;
 b=c9mWNddfKCdbJbVVwCOTTLBlMMTkKcqpGIzXiC1VcoruSGGs6rf9aSku6jZaTyNVES
 CgSpudUFHoamTeNsjtkU5kjAKj6nMBEoIEzg8RRY3Se5fm9Or4LFWpobFFIyIrNxIBCK
 hWDqV0mmM63U/LzQoB0/gTHzvxzI44V+mKXn13jjeAxth/ZsDZUOMe9aJejlyIE0eGf/
 YMrqybZ3lazeqwNWCQ4ibJR8yOp/g7inAzzHzZ+qj7hDpjxwNDCAjY7Yx/VgStwIyrbF
 Ep+mAaxLJHo0ozumoCaV5QyDW3Hx8qb9zRRcPkkqlmwCqpyCWsrXoRmY3HWGMWBhD39/
 6Uww==
X-Gm-Message-State: AOJu0Yx73rQ1rn+XepNSZquwiDflwL1TjujUhW0MFPK52b2YnJEjRkzc
 wHlnqKdZvWByV7gzgXE1gffOg4hQWjUlhbupQ2vPSGDvJWUmaZDFigsUE3etHK0KwoE=
X-Gm-Gg: ASbGnctl9FZxuwH4cnRY5SrrrfvwmA1/kdyuGnkb8CS5kHB2DKUyc5HSRvABTDEIyWP
 8+kqyeUo/7eMpFMRywKb2kzf9Hwc52K9j6xqTHkU6B5opT/U8NdJb/ikECpRiyYcUrX1YPVPHM/
 T7egOuoTRjx3/LlSFcFB8imVYPgR3a47TrEh6rn64ZC9BCKYwW+QsIZQwQKSK6dK7jE9zsr4PtE
 fDB/KKpShlyc5vYAGa8RLam5DGALkPumjd0eBDP/FUBdMy1PDfiyot+5kIvmuqrUGtO9L7Ct9zB
 sa6bS9vKICkMa56Xh6GtrF622Thi/AxVSNUzLvEsr8dExtvNzajXyFjxAul1znBAYp5A2g4pHVi
 xr7ohdhzaKl4WLrEdXK92nkkrvcosdMe0PpqFZqKhayQhqjjrU8I4easE9oD/mPnRl+TgaU9Bn4
 hunxBVSNp35w==
X-Google-Smtp-Source: AGHT+IE8tMtMfql8Hhi7Famc9a2CrSvhA+9hX52K41y8ZG7Ear59XFu7EbIiLSndLisgjdSH6d8AQw==
X-Received: by 2002:a05:622a:212:b0:4b7:a8ce:a419 with SMTP id
 d75a77b69052e-4da486b7062mr287255561cf.26.1759189402659; 
 Mon, 29 Sep 2025 16:43:22 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4db0b9458e1sm83652861cf.15.2025.09.29.16.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 16:43:22 -0700 (PDT)
Date: Mon, 29 Sep 2025 16:43:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org, gakhil@marvell.com, konstantin.ananyev@huawei.com,
 bruce.richardson@intel.com, thomas@monjalon.net, stable@dpdk.org
Subject: Re: [dpdk-dev v2 1/2] eal: Add rte_consttime_memsq() to prevent
 timing attacks memcmp.
Message-ID: <20250929164318.33d6054c@hermes.local>
In-Reply-To: <20250926154905.54416-1-kai.ji@intel.com>
References: <20250925102223.145471-1-kai.ji@intel.com>
 <20250926154905.54416-1-kai.ji@intel.com>
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

On Fri, 26 Sep 2025 15:49:04 +0000
Kai Ji <kai.ji@intel.com> wrote:

> Bugzilla ID: 1773
> Cc: stable@dpdk.org
> 
> [0] https://bugs.dpdk.org/show_bug.cgi?id=1773
> 
> Signed-off-by: Kai Ji <kai.ji@intel.com>
> ---
>  lib/eal/include/rte_common.h | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
> index 9e7d84f929..ddbba083be 100644
> --- a/lib/eal/include/rte_common.h
> +++ b/lib/eal/include/rte_common.h
> @@ -700,6 +700,40 @@ rte_is_aligned(const void * const __rte_restrict ptr, const unsigned int align)
>  	return ((uintptr_t)ptr & (align - 1)) == 0;
>  }
>  
> +/**
> + * Constant-time memory inequality comparison.
> + *
> + * This function compares two memory regions in constant time, making it
> + * resistant to timing side-channel attacks. The execution time depends only
> + * on the length parameter, not on the actual data values being compared.
> + *
> + * This is particularly important for cryptographic operations where timing
> + * differences could leak information about secret keys, passwords, or other
> + * sensitive data.
> + *
> + * @param a
> + *   Pointer to the first memory region to compare
> + * @param b
> + *   Pointer to the second memory region to compare
> + * @param n
> + *   Number of bytes to compare
> + * @return
> + *   false if the memory regions are identical, true if they differ
> + */
> +static inline bool
> +rte_consttime_memneq(const void *a, const void *b, size_t n)
> +{
> +	const volatile uint8_t *pa = (const volatile uint8_t *)a;
> +	const volatile uint8_t *pb = (const volatile uint8_t *)b;
> +	uint8_t result = 0;
> +	size_t i;
> +
> +	for (i = 0; i < n; i++)
> +		result |= pa[i] ^ pb[i];
> +
> +	return result != 0;
> +}
> +
>  /*********** Macros for compile type checks ********/
>  
>  /* Workaround for toolchain issues with missing C11 macro in FreeBSD */

Also need functional tests for any new function in the functional test suites.
Just some basic tests, suggest using random data, and lengths; validate with memcmp.
And/or see what freebsd already has.
