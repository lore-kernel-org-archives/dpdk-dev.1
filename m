Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BEEE81A29
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 14:29:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BE1840289;
	Mon, 16 Feb 2026 15:29:40 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id AA01A40269
 for <dev@dpdk.org>; Mon, 16 Feb 2026 15:29:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771252174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ISzpiJQfA2kxPtQr+os0mdxcxCuZqzt3tyOoy00P22M=;
 b=Zcs3h6io5mpOdF/qI9QAZmlwzA2iUfecPHApumheEp0VjW2lSEDYMBnV+W8yU3mLrBdMf0
 HtrX8dSiFq/+dLgplYk0Q8lDrFiDg5M3Z0wVNCD335J4Mqsb5FlVLmcqNZsLQnkFpSLW23
 bk8d53t9PjCuVMh8H+cgXm71cy3k2YM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-mkK6obtgOLaeaYIis-FnSA-1; Mon, 16 Feb 2026 09:29:30 -0500
X-MC-Unique: mkK6obtgOLaeaYIis-FnSA-1
X-Mimecast-MFC-AGG-ID: mkK6obtgOLaeaYIis-FnSA_1771252163
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-38302f5aba6so18022971fa.1
 for <dev@dpdk.org>; Mon, 16 Feb 2026 06:29:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771252163; x=1771856963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ISzpiJQfA2kxPtQr+os0mdxcxCuZqzt3tyOoy00P22M=;
 b=AgePGAiDghXoFiOPyc/s5uqh8JuZVXtcB4uzsRzVX+jIyi55d0rHt288vm0dpj1y/u
 N+yjLscPJ/KymqESRPQkBGRl40W+56liA5ychK+LsA3f+VflppGBFWaZNNCLb6mi0Tfu
 KiVd9ZzhCdIUNW7hzcC5hGegbbtkKSX1HnVjrla2oFI2SNkhUZx5g52yADmfbKBljUR5
 c6PB5TXjDza58G8/lymbxhDlnX0meQKHwJS5n5y1x31r4/kixTxOropzeCvBzSxgwtF7
 liXrBhfFZxDkNmFWQDF5TUAzSsSeZ8DzLKRLCg7dDOa5r2gL88acw8hOo5LDEYD7ptba
 oAiA==
X-Gm-Message-State: AOJu0YxBiOFenotCS9mzrntUwnyUM5+a0oSANb5xGGTEbcWHOyydczee
 oBbuLPB11ODb7RE/0CWDOnjmsonubiLdY1jH48CmhbRtNqlWSrM0dRf5KVU07apT/JJ+HbmUykx
 U/CcRGprp7ioR/3//ZC5/RkS+mDM6Z+Yyt0JJeV6b6VLm/ILDGStC1680mHacuyMqexl4jO7T+u
 60NsDM2zdE/YtuV3ZBvnw=
X-Gm-Gg: AZuq6aLfLkGZuZIhhy0Aj50B/h3pmB669/OuKNIdNfh2inLFTUnB7OaHoZnAxaeuVcE
 o9sFtnkS5VVbUBs49eHwpZWSO3lpTFnhCvxKRbQK9iHEpOo05jnC5uWhtni2LggExJgF7cclaQy
 if0yhUu1D/qF+8thjkjrwXZ+RGf0RqpkEdkYGiWepkbmyAJzYGwOU+Ce/YW1rQkfavw3HFu8uh2
 /7syfT6M9ZMvz/Wwq1JuvVStsCH+uyGKKgD5hGN0/MO1aFKIZVzp2K3bnjCZyJw4F+a5w==
X-Received: by 2002:a05:651c:f09:b0:385:f0ce:e222 with SMTP id
 38308e7fff4ca-388106be1a2mr26158621fa.41.1771252163356; 
 Mon, 16 Feb 2026 06:29:23 -0800 (PST)
X-Received: by 2002:a05:651c:f09:b0:385:f0ce:e222 with SMTP id
 38308e7fff4ca-388106be1a2mr26158491fa.41.1771252162882; Mon, 16 Feb 2026
 06:29:22 -0800 (PST)
MIME-Version: 1.0
References: <20260128194141.90018-1-scott.k.mitch1@gmail.com>
 <20260202044841.90945-1-scott.k.mitch1@gmail.com>
 <20260202044841.90945-2-scott.k.mitch1@gmail.com>
In-Reply-To: <20260202044841.90945-2-scott.k.mitch1@gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 16 Feb 2026 15:29:10 +0100
X-Gm-Features: AaiRm52odX8Bw-nUb-SKV4OjgcbdwhnBPXHLzVZ3-RC0tyuYkfyYHcOQMo94gYk
Message-ID: <CAJFAV8zr6zcvOwY920y=Sbo60UUSWhMw4jROs0h=ugNXJAHQ+A@mail.gmail.com>
Subject: Re: [PATCH v19 1/2] eal: add __rte_may_alias and __rte_aligned to
 unaligned typedefs
To: scott.k.mitch1@gmail.com, Andre Muezerie <andremue@linux.microsoft.com>, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Cc: dev@dpdk.org, mb@smartsharesystems.com, stephen@networkplumber.org, 
 bruce.richardson@intel.com, Cyril Chemparathy <cchemparathy@ezchip.com>,
 stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4VFCOv5LHO7ENiL4CkxFHAMmxsesxn79MzKRW6LGwnM_1771252163
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Hello Scott, Andre, Tyler,

On Mon, 2 Feb 2026 at 05:48, <scott.k.mitch1@gmail.com> wrote:
>
> From: Scott Mitchell <scott.k.mitch1@gmail.com>
>
> Add __rte_may_alias attribute to unaligned_uint{16,32,64}_t typedefs
> to prevent GCC strict-aliasing optimization bugs. GCC has a bug where
> it incorrectly elides struct initialization when strict aliasing is
> enabled, causing reads from uninitialized memory.
>
> Add __rte_aligned(1) attribute to unaligned_uint{16,32,64}_t typedefs
> which allows for safe access at any alignment. Without this, accessing
> a uint16_t at an odd address is undefined behavior. Without this
> UBSan detects `UndefinedBehaviorSanitizer: undefined-behavior`.
>
> Fixes: 7621d6a8d0bd ("eal: add and use unaligned integer types")
> Cc: stable@dpdk.org
>
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>

[snip]

> diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
> index 573bf4f2ce..7b36966019 100644
> --- a/lib/eal/include/rte_common.h
> +++ b/lib/eal/include/rte_common.h
> @@ -121,16 +121,42 @@ extern "C" {
>  #define __rte_aligned(a) __attribute__((__aligned__(a)))
>  #endif
>
> -#ifdef RTE_ARCH_STRICT_ALIGN
> -typedef uint64_t unaligned_uint64_t __rte_aligned(1);
> -typedef uint32_t unaligned_uint32_t __rte_aligned(1);
> -typedef uint16_t unaligned_uint16_t __rte_aligned(1);
> +/**
> + * Macro to mark a type that is not subject to type-based aliasing rules
> + */
> +#ifdef RTE_TOOLCHAIN_MSVC
> +#define __rte_may_alias
>  #else
> -typedef uint64_t unaligned_uint64_t;
> -typedef uint32_t unaligned_uint32_t;
> -typedef uint16_t unaligned_uint16_t;
> +#define __rte_may_alias __attribute__((__may_alias__))
>  #endif
>
> +/* Unaligned types implementation notes:
> + * __rte_aligned(1) - Reduces alignment requirement to 1 byte, allowing
> + *                    these types to safely access memory at any address.
> + *                    Without this, accessing a uint16_t at an odd address
> + *                    is undefined behavior (even on x86 where hardware
> + *                    handles it).
> + *
> + * __rte_may_alias  - Prevents strict-aliasing optimization bugs where
> + *                    compilers may incorrectly elide memory operations
> + *                    when casting between pointer types.
> + */
> +
> +/**
> + * Type for safe unaligned u64 access.
> + */
> +typedef __rte_may_alias __rte_aligned(1) uint64_t unaligned_uint64_t;
> +
> +/**
> + * Type for safe unaligned u32 access.
> + */
> +typedef __rte_may_alias __rte_aligned(1) uint32_t unaligned_uint32_t;
> +
> +/**
> + * Type for safe unaligned u16 access.
> + */
> +typedef __rte_may_alias __rte_aligned(1) uint16_t unaligned_uint16_t;
> +
>  /**
>   * @deprecated
>   * @see __rte_packed_begin
> @@ -159,15 +185,6 @@ typedef uint16_t unaligned_uint16_t;
>  #define __rte_packed_end __attribute__((__packed__))
>  #endif
>
> -/**
> - * Macro to mark a type that is not subject to type-based aliasing rules
> - */
> -#ifdef RTE_TOOLCHAIN_MSVC
> -#define __rte_may_alias
> -#else
> -#define __rte_may_alias __attribute__((__may_alias__))
> -#endif
> -
>  /******* Macro to mark functions and fields scheduled for removal *****/
>  #ifdef RTE_TOOLCHAIN_MSVC
>  #define __rte_deprecated

This change raises a warning in checkpatch.
https://mails.dpdk.org/archives/test-report/2026-February/955237.html

IIRC, we added this check for MSVC support, making sure no
__rte_aligned() would be added in unsupported locations.

@Microsoft guys, do you have a suggestion?


-- 
David Marchand

