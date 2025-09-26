Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D0BCAC5B8
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 18:08:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F274B40277;
	Fri, 26 Sep 2025 20:07:59 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 4F42F40262
 for <dev@dpdk.org>; Fri, 26 Sep 2025 20:07:59 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7f04816589bso258688685a.3
 for <dev@dpdk.org>; Fri, 26 Sep 2025 11:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758910078;
 x=1759514878; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RRWOcqOHVK0ilrkQMBEt/S0e13UlPgse3qaa7sXMtBA=;
 b=t4K7sh9d4/NHrLLwq05CzVKzrpJbWi/A03d3ktdwj2wOBUqJK80LpDbL+S7Uf4woyA
 dUTrEbaBjVsAvWDjWzlLtSfq7sSZW3plUV4R0dgq55yMa63HEPeMaOOm983vIZoA0kOL
 IWxl9TLw3NaxVOv7P6+LzsJXblyf4obiVKh2SVMJ6OqzM1R3yRVpij0rLzjrybMhAIz0
 qWATxOOB22yjGTIYbWtTOlUudqS/zaf7zyHBHyOfbfia5oTnR8R4OG9tzDBlwCN8M7P1
 xrholPS5jhdDYpgke0FYxHg3OBYHv5+Bw9Zl5kIH4awVidQADoz47pQfDpHTYytJeFfj
 wDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758910078; x=1759514878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RRWOcqOHVK0ilrkQMBEt/S0e13UlPgse3qaa7sXMtBA=;
 b=uC83MckQZMhJaZ+y8+Jf4nGaMnPwemEWTj5SemNaGke1KW7fiWOLuoKjWe0IdjYdm8
 9ingAoq8s4lyX9UKypDEJHji9oVTkYmOXSYOMahPAhhHU7UfKku/T/NkqQHdr0gKODq9
 QC2rlirOB6e7ypAFfAK6XLJsdiYFecs36kIZzn1t7bLygCbwRudnJ41B3zmbUhj3Lmu9
 7hKJGREa9iQVItdj0FMW2q0onYWrTa9K5HAL8VhvcesszvlQzaCz3gR7o7ZGlmCvHYIw
 uxjM75p1F527ig8PaDywjgqcCkj5r9eAKxRxyO1MsJpmlRws4YewNqoiGmNc/s2exCGF
 ecOg==
X-Gm-Message-State: AOJu0YzfjZngtayTLIO00wELZY0pmtUHKoYWEnkzAqaRco9dWUhgOTbZ
 IzZunWZqabO4+/+0b/ATDcfnH8ge7FIT8MF36Goia6NLFGi/tJ4rwFiTCyBj631IBhY=
X-Gm-Gg: ASbGncvdNrvQouZqkyAlt5T61BIwUV6wY7vsM7CPq1JV11xAaR6DyQprANeApHESyQ0
 RZEELR9eng/EUb5xbdvfuH3FFWLsg6ZEfkvJHPrgKwhSNm43cuzaMfOsGgV8Ibb6Aa5slNQDdoe
 O1a4TsMGtPIFFHx9mqohl2TTk/f9otOkmHI+ZnL/s+uyJ9NpX7vN2bvUCTr5W1X7Rh7Ft2W/qF5
 E68+SBGtOsxhwd6TSdeQP8HoyAe5XNO47tnA8fDWFNnmms5C5FxDnSVJs4vdMldMnZ/7Uctzpq7
 TAGR+tKTQ8IB0KgxOySz+oiOVK4KFFh+/Euk2jTpq3142VtCOu1eRk1PSj7mhExTVf72svsPl/A
 8NZ0YHA/mDJGXqgxDIVDBkdI0u/YNpLyLeh4rQDt10l7XUT3uvWZzJHbLWxAGPbqduShy4xb3Nd
 4=
X-Google-Smtp-Source: AGHT+IFYxIcqX720Y6buwQjY7OxnRvG/mT6cKZV3ZPzKzKmpfGcg3t+ii45r2lh0nY6QQWjFZl6KNg==
X-Received: by 2002:a05:620a:489b:b0:848:8e5b:e1b4 with SMTP id
 af79cd13be357-85adf6c6a76mr261775685a.8.1758910078228; 
 Fri, 26 Sep 2025 11:07:58 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4db1087267csm29940801cf.26.2025.09.26.11.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:07:58 -0700 (PDT)
Date: Fri, 26 Sep 2025 11:07:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org, gakhil@marvell.com, konstantin.ananyev@huawei.com,
 bruce.richardson@intel.com, thomas@monjalon.net, stable@dpdk.org
Subject: Re: [dpdk-dev v2 1/2] eal: Add rte_consttime_memsq() to prevent
 timing attacks memcmp.
Message-ID: <20250926110752.51572f6e@hermes.local>
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

New functions usually have to be marked experimental.

Since DPDK adopts many things from FreeBSD, perhaps the function
should use the same naming conventions. That would mean

int rte_consttime_memequal(void *, void *, size_t len);

And will also need to update release notes.
