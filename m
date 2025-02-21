Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542E1C021B3
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 18:50:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4362A410E8;
	Fri, 21 Feb 2025 19:50:10 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id C9770410E6
 for <dev@dpdk.org>; Fri, 21 Feb 2025 19:50:08 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2fbfa8c73a6so4956838a91.2
 for <dev@dpdk.org>; Fri, 21 Feb 2025 10:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740163808;
 x=1740768608; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FydIl6WAJ0IeNkPItkK/iTQacMAb1mycyh1ypQlvK58=;
 b=CYfaZIsEG9n1TjSjdspoKg1lqO0WJqaDv+t8ly8Z1GIp9elCw67dzPILfwP4Mk2IGn
 ac2Kax2TwusVYN8vbA2gio5m1GwrKISg8kCxFcBLaC6MSxEqrrRkrD6jOScXsDzLZIKH
 GKBSiz+wjQ6A9ARXOgXW4Gam1ENz3hdtUS+PrRXjTpJLbdFsITmHns3Hx6wTV2btxiMR
 QTW5HQHau6EHhjnFsI/V7HjJOlnVH9gi7H4lJ2rtAqXk1c/5pEcfgfCwPxpIrEGfmWKZ
 H+a8qWCoy8MPf7ysVkH8MdaoeZkyhDmUDFCGZzvrgn+V/wQNwLThu0nq/vcsZ/knvz8q
 Msnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740163808; x=1740768608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FydIl6WAJ0IeNkPItkK/iTQacMAb1mycyh1ypQlvK58=;
 b=h95KukxUKgbqMwZVqojPPiNJAlL/YJMJ3wi5wVNxAMOzv4ZuKK8kDzx2PQ3G46dPqk
 53dt/+IY99EEcPUQ/m0AU10Car2orDduVwnJfEus+dAXBlVgvmgOpZ5HDPw7tBNWL24g
 4U43qgHOMwgkd0r1K5vlxN6Ojk3Wk302gqGvFVzrt3FYIC4NGLp9A7IYPvuFtJE9V9Du
 29FMYs2dO+6kxAIaySFYZZkb57n7UHSG0gJIcvbWrr1dcBjctyPG1Z/QMBhPOH50nco1
 TbOnJktxaeHTWLs/OnnZysTMm/+Y0WxxdVhmM29yFkrzEMmUkVJaIRLiJ1tGpihnsXu1
 Jadw==
X-Gm-Message-State: AOJu0YxJWnOJaOsaYPMk8jiszJDoqCf5thphajwfX/DjQYYyU4IKxy0U
 XZL3wq9Sr6YBib4wdzANhsD3BKeSAno7kClOPzN4TIVobrp9D6uRLMCwbcX6lU8=
X-Gm-Gg: ASbGncufc0HL+/15z4sOVpILXFYrzJNV/v2k1mMy8MA8/89IlJnqOxIAR6mAGCnQ9BH
 Xa6owG8SnlaLX7eB/RyqpZD+1CD5fhkLoP1iwOz40wkPz6dETZtgnCxT0sH3AU8Q8bO/8tf6D56
 7VGfE3TMYe8Zg2zUPm/wmTZZYakfcKSc+7TzVoAL39AKyL4iinVzUM480/yEXtVer/h7oLrtg5M
 CFCxBIYXVyO0UeUe4lIPtw7m+Z9odEw6v+ni2SILA3ZKYMxr9DEfyjVYx7AsieWQMmXpvqXE5xZ
 Gzsd0POI8fc9rnYOKGWgkhQ+KNXW1ARjSrUwxJUBppP99XOO0YtAQ73lkQj5OCNwgypIpnPlERw
 6yu4=
X-Google-Smtp-Source: AGHT+IFhwvdhuZBMnBraqndUAKPJ1OSPuwX9HFKXIXOt0t30EAYZCglMs0Htit/N4PV6qEKFbvZoWw==
X-Received: by 2002:a17:90b:2b8b:b0:2f9:9ddd:689c with SMTP id
 98e67ed59e1d1-2fce87247d0mr6449629a91.25.1740163807884; 
 Fri, 21 Feb 2025 10:50:07 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fceb10fab1sm1734066a91.32.2025.02.21.10.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 10:50:07 -0800 (PST)
Date: Fri, 21 Feb 2025 10:50:05 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chris MacNamara <chris.macnamara@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1] doc/guides: update monitor PMD mode description
Message-ID: <20250221105005.40567940@hermes.local>
In-Reply-To: <20250221165440.832528-1-chris.macnamara@intel.com>
References: <20250221165440.832528-1-chris.macnamara@intel.com>
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

On Fri, 21 Feb 2025 16:54:40 +0000
Chris MacNamara <chris.macnamara@intel.com> wrote:

> A recent CPU change requires an extra enabling step for
> the umonitor instruction on Intel CPUs.
> This is now detailed in the l3 fwd power manager doc.
> 
> Signed-off-by: Chris MacNamara <chris.macnamara@intel.com>
> ---
>  .mailmap                                          | 1 +
>  doc/guides/sample_app_ug/l3_forward_power_man.rst | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/.mailmap b/.mailmap
> index a03d3cfb59..c4bc38752f 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -263,6 +263,7 @@ Christopher Reder <christopher.reder@broadcom.com>
>  Christoph Gysin <christoph.gysin@gmail.com>
>  Christos Ricudis <ricudis@niometrics.com>
>  Chris Wright <chrisw@redhat.com>
> +Chris MacNamara <chris.macnamara@intel.com>
>  Chuanshe Zhang <zhangchuanshe@icloudshield.com>
>  Chuanyu Xue <chuanyu.xue@uconn.edu>
>  Chuhong Yao <ych@panath.cn>
> diff --git a/doc/guides/sample_app_ug/l3_forward_power_man.rst b/doc/guides/sample_app_ug/l3_forward_power_man.rst
> index 3271bc2154..d0af28e0ec 100644
> --- a/doc/guides/sample_app_ug/l3_forward_power_man.rst
> +++ b/doc/guides/sample_app_ug/l3_forward_power_man.rst
> @@ -293,6 +293,11 @@ and has three available power management schemes:
>  ``monitor``
>    This will use ``rte_power_monitor()`` function to enter
>    a power-optimized state (subject to platform support).
> +  On recent Gen 4 Xeon Scalable Processors the umonitor instruction
> +  is disabled by default.
> +  An additional step is required to enable the umonitor instruction.
> +  Writing 0 to bit 6 of register 0x123 will enable umonitor.
> +  `More details are available via Monitor and Umonitor Performance Guidance <https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/monitor-umonitor-performance-guidance.html>`_
>  

This should be done by the power library, what is the point of having a power API
if we require applications to test for CPU type and go tweak some CPU register bits.
And it may be restricted by OS permissions etc.

