Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367B3C83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 10:45:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74D1B4021E;
	Mon, 21 Jul 2025 12:45:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id CFBD24014F
 for <dev@dpdk.org>; Mon, 21 Jul 2025 12:45:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753094749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Q6mJb4akcW/PBkdzGWrMt0yfALNAB80LbzJTBczVK1o=;
 b=bMVieBrJXV3MEO32aYQSKT1Btj7Vdldu5/96tKwsFVVwfXOtvrBtfYTIbsRSguK7u8IHEk
 3u2mIgw8CZbPNTT/dGzxhS0Qt5U+HVRCZIoJqtIClP8YgoHKycursg/rhmrwDvwwKFeXu9
 HVFWA4kGaUUnHpUCwXP0JbtA5f7iNu4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-YxjptxBtNSy6zPulQAmxfw-1; Mon, 21 Jul 2025 06:45:47 -0400
X-MC-Unique: YxjptxBtNSy6zPulQAmxfw-1
X-Mimecast-MFC-AGG-ID: YxjptxBtNSy6zPulQAmxfw_1753094747
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f6ba526eso2838912f8f.1
 for <dev@dpdk.org>; Mon, 21 Jul 2025 03:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753094747; x=1753699547;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q6mJb4akcW/PBkdzGWrMt0yfALNAB80LbzJTBczVK1o=;
 b=S7vfxjHVBtsW/d3dc81i2ZRUldnizYMZYqrx6tCxV8/S/4I9gQfqxd88ipnptnnZhJ
 ZKxYJOaxHG8NazQpd6lfF/QQujaqh77fwRKEhZqWpk/b07olhHbLI445/fUewakNSVXb
 O5wfbHvooMjLBBeHs2qBODVUIzFdhzFMtp9cHjjaF/qu00neerknHF1AI9/i2cuqZqyh
 4di8YsvWvK5UMPWizAqhYVICj/uArC9dUNv6CxVAsSygS5BQDhG8n8xCXfjZmf7oqw0c
 8kHbywIEe7sq9tStATEG5z3gRpKv4lk98+ZZTqDqERk3ba3bKdFnmOHPCF9BUWe2TTLG
 iU2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3tNncgHcCEBrOf/TMAmJd0eXW+JvUhqlBsnojSM8uFNm1ZCIMY6AxU1kyuzeuCyiXIUg=@dpdk.org
X-Gm-Message-State: AOJu0YzwGqNzFNcKBczy5by/Gk+ZBg/ZoPyvKh+7CeiRr6l1OXhwaElO
 LiQkVpMUYz1Nm70tVZ0ICwfdQXDKhSABBz83ihjYf/kjU4Ev+9KUvQ8VaIdN6bRUdoxUEn0tvvA
 A1NxnlToglzeJEXsh8ZClgPMXnZb6D8XeTSRTnJ1M0TS4
X-Gm-Gg: ASbGncuKKO/wDFzL/LVjyIjJNqmONA4WpnxKwbIqsFhFQGObyZHkGfFVA/GnrmkG2a9
 M875zQmIKRlPpl8JhSp97lQ32SuqwxnnBQx69CuTgAw2Q9miS2XiGylh2cKP/1LENUBXHOso0DR
 +sjdmwtvmTRKfDYRSTO7HKHvA56/OiphK8PexiqnOO4YuQVTA09dK66rps5yVgECyw9LdhEQsjj
 O3tcGOjrlA9iY1897JFAzvO5E0jK4lVoMGLgEnTO3EIoT81uCi7ycjQp4X9WCtFUaiR/2FIk00z
 eh8lpFrl+UL5jdOFVY9PenDTc0NaE02IKnzDi+LPgA==
X-Received: by 2002:a05:6000:1887:b0:3a5:298a:3207 with SMTP id
 ffacd0b85a97d-3b60e520535mr16442603f8f.48.1753094746686; 
 Mon, 21 Jul 2025 03:45:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbd+ZLQI+3Bbjt2FZ/kjlqiv9z2WBps+Ns/vKyxoyCQBVzKB4gur8rlZwUr1UdZCpGt+5ziQ==
X-Received: by 2002:a05:6000:1887:b0:3a5:298a:3207 with SMTP id
 ffacd0b85a97d-3b60e520535mr16442583f8f.48.1753094746247; 
 Mon, 21 Jul 2025 03:45:46 -0700 (PDT)
Received: from [192.168.0.56] ([78.16.130.126])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4d475sm9872464f8f.65.2025.07.21.03.45.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 03:45:43 -0700 (PDT)
Message-ID: <8fc75987-9397-4290-8c22-d4c6354e2fd2@redhat.com>
Date: Mon, 21 Jul 2025 11:45:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: update kernel version requirement
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>, Luca Boccassi <bluca@debian.org>
References: <20250409035408.199320-1-stephen@networkplumber.org>
 <20250410152117.5822-1-stephen@networkplumber.org>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <20250410152117.5822-1-stephen@networkplumber.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rhFBqdgN4IucXWQW3SJDkJjUUIQ7FtN-jx-P7KBOfJU_1753094747
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 10/04/2025 16:20, Stephen Hemminger wrote:
> The 4.19 kernel version was end of life in December 2024.
> Update to 5.4 and also add better description of what "not supported"
> means in this case.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Morten Brørup <mb@smartsharesystems.com>
> ---
> v2 - better wording
> 
>  doc/guides/linux_gsg/sys_reqs.rst | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/doc/guides/linux_gsg/sys_reqs.rst b/doc/guides/linux_gsg/sys_reqs.rst
> index 5a7d9e4a43..ba48b8afc0 100644
> --- a/doc/guides/linux_gsg/sys_reqs.rst
> +++ b/doc/guides/linux_gsg/sys_reqs.rst
> @@ -105,11 +105,20 @@ System Software
>  
>  **Required:**
>  
> -*   Kernel version >= 4.19
> -
> -    The kernel version required is based on the oldest long term stable kernel available
> -    at kernel.org when the DPDK version is in development.
> -    Compatibility for recent distribution kernels will be kept, notably RHEL/CentOS 7.
> +*   Kernel version >= 5.4
> +
> +    The Linux userspace API is compatible across releases but there are some
> +    restrictions. The oldest kernel tested by the DPDK testing infrastructure
> +    is the oldest maintained Long Term Stable (LTS) at time of release.
> +    The DPDK is likely to still work with older releases but it is not guaranteed.

It's just word semantics, but I mentioned before, I don't like the use
of "guarantee" that is is implied for newer kernels.

We can simply say that older kernels are not tested with and/or that
DPDK is not maintained to keep compatibility with them etc.

> +    Compatibility for recent distribution kernels will be kept, notably RHEL, and Ubuntu.
> +    It may work on older distributions, that are no longer under standard period
> +    but this is no longer but this is no longer tested or guaranteed to work.

"but this is no longer" is repeated

Again, it is implying there are "guarantees" for newer kernels

> +    The following are outside the current support window: RHEL 7, SLES 15.5, Ubuntu 20.04
> +    and earlier.
> +
> +    Some drivers and hardware support may require more recent kernels, check the
> +    documentation (e.g. :doc:`../nics/index`)
>  
>      The kernel version in use can be checked using the command::
>  

With some minor tweaks,
Acked-by: Kevin Traynor <ktraynor@redhat.com>

