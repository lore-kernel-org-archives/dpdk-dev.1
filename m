Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83518F8D75F
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 15:51:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A391F402ED;
	Thu, 16 Apr 2026 17:51:51 +0200 (CEST)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52]) by mails.dpdk.org (Postfix) with ESMTP id 6958440272
 for <dev@dpdk.org>; Thu, 16 Apr 2026 17:51:50 +0200 (CEST)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7d7ebe11bffso6787704a34.0
 for <dev@dpdk.org>; Thu, 16 Apr 2026 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776354709;
 x=1776959509; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5J+AgvCSnhYwT22Znwh3SLi8CI0pcVTIp3ZLSNjsB9A=;
 b=TelFopZUk21zWiaRu7mqwpTGOfkfj5YfAW6PRK/fxbREn3wU0mMnXUfMTvIBkXOBXq
 c2rOaQ2c2mc0w0SKruRL1xccRouo29K/O4BLv1iZg1I6SeE/7/aDNenT4YRgFVUf4+al
 6luy6oz46A0UhRQb6DdRfoj1OZy0jhH9f7TqGVpclxPFES5MEFzD+HvqbzyOvRe7vEvb
 w7NVfVu2wYIxqyEe+aVgo/BGRtp8Rrgozw/3QS15EOTjA+RTCVoybgI2BPzbhOSNNfMm
 24HPhiU0oX2jAIeaSMLd5mB2VPrBRHuyjqKj6ohhM2qbjlQyTvVNQc2SFfDxyk4hk7TC
 U2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776354709; x=1776959509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5J+AgvCSnhYwT22Znwh3SLi8CI0pcVTIp3ZLSNjsB9A=;
 b=CKKvtfwYTS4L6cMCxodlFrlck7mg4x7OG2iFIKzlyzBVY1PYIMFRCd8/fILqdrlhYr
 xqi6M6eZmIa2/5RILCtZi82m0clfkVZamAIkU0In1+qClgfXIRBaZ9wmpyj8c6ez5rQc
 EIPyedtnCcbs/pzuRZJOB8hYb4qScO3q5bqB5TkjeTJxcMPZ32yFiLVts2drEQ7FgXih
 lS/aCdR7V8lpx0PEddwhEJnV3tYV5CZc/Ar8oyjtN2sv6lrY2d5sxpYJ+ssv5qNAU1TR
 XydcT9pP5RMG3aG3GEkGeuDYFW7zHHV2HMpPkvdsCjLIqz4I6tWkjAv/2ixh+GH5h87s
 XZ6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JB2+XmGkKXFcZzgk8prjjyzZqPZDGd8o34HtVjgWJH4Mqh0PGC2sFwiQE65CYz+52QIw=@dpdk.org
X-Gm-Message-State: AOJu0Ywy1Tga2d920pNZWGEgTh8jLWUB5sLFsj1v1TTqWMTdfxJ5vM6e
 iu8TXuNEGE9fahxl7lVtnq9lKVx4+VbNrgx3DlnQg8GKEIdD/DAnYA8C0JtuMGA9LxA=
X-Gm-Gg: AeBDieuTy5f93ZxPrBvFumyXdOMx3o9sRbS+8yn8qUYdNS2UmKqwDgo4qSmaZu6r5WJ
 1+BZaIvPMo2xfMs7zyrV6Zcge775PuQL8bxtTOX7xQKXRlEVcc+6LGyJebLZ2ZNKZwORm4iQSTG
 yQ6Tde7hoqn0gmLU3WqLr86Rp2GNuNy/kptCOKYmNtLWgq8BzlVerDRD48S7LOspjfowHYeZyQn
 NKdqhriWcTNadn6x/vKRb3QO6Ri/3xrzjPFK+d53H1LAtpvNelGml0dw6R2nBy0zWWtzggIQEPG
 sSMBqykKZdnKFF3SD8eJtQGT7eT5mF5Z3eNHrL6ia1UZZUd9RO6bFh8rED/LITfVMF2gJNH1XYS
 qG8iAMuk7AC+0oWJLyKKtDvw3A/bEFuNOuopXPpfmIYdkvNJHX4pMVhpD65lglDAWGy6b4JtK2V
 fBHjJayGsvfs8eFRFuRgQuo85CJjQ9jaWi6G4DXlchkfllnw==
X-Received: by 2002:a05:6820:4b0d:b0:67b:b790:f5d6 with SMTP id
 006d021491bc7-68be623d15amr13114449eaf.15.1776354709426; 
 Thu, 16 Apr 2026 08:51:49 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69460441090sm123259eaf.13.2026.04.16.08.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 08:51:49 -0700 (PDT)
Date: Thu, 16 Apr 2026 08:51:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Huisong Li <lihuisong@huawei.com>
Cc: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>,
 <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>
Subject: Re: [PATCH v1 00/15] power: unify and improve lcore ID verification
Message-ID: <20260416085146.7c268cb8@phoenix.local>
In-Reply-To: <20260416030612.2379407-1-lihuisong@huawei.com>
References: <20260416030612.2379407-1-lihuisong@huawei.com>
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

On Thu, 16 Apr 2026 11:05:57 +0800
Huisong Li <lihuisong@huawei.com> wrote:

> This patch series reworks the lcore ID verification logic within the power
> library to ensure consistency and improve maintainability. Currently, various
> cpufreq drivers implement their own lcore ID checks, often relying on simple
> range checks that do not account for whether a core is actually enabled in
> the application.
> 
> Key Changes:
> 1. Replaces basic range checks with rte_lcore_is_enabled() across all
>    cpufreq drivers (ACPI, AMD P-state, CPPC, Intel P-state, and KVM VM).
>    This ensures the power library only operates on lcores assigned to the
>    application.
> 2. Introduces a common macro in the power library's internal headers to
>    standardize lcore ID verification.
> 3. Moves the verification logic from individual driver implementations up
>    to the high-level framework API. This reduces duplication code and
>    ensures that all drivers benefit from uniform validation.
> 4. Updates the power QoS and PMD Management libraries to use the new macro.
> 
> Huisong Li (15):
>   power/kvm_vm: enforce enabled lcore ID check
>   power/acpi_cpufreq: enforce enabled lcore ID check
>   power/amd_pstate: enforce enabled lcore ID check
>   power/cppc_cpufreq: enforce enabled lcore ID check
>   power/intel_pstate: enforce enabled lcore ID check
>   power: enforce enabled lcore ID check
>   power: add a common macro to verify lcore ID
>   power/pmd_mgmt: replace lcore ID verification with new macro
>   power/qos: replace the lcore ID verification with new macro
>   power/cpufreq: add the lcore ID verification to framework
>   power/acpi_cpufreq: remove the verification of lcore ID
>   power/amd_pstate: remove the verification of lcore ID
>   power/cppc_cpufreq: remove the verification of lcore ID
>   power/intel_pstate: remove the verification of lcore ID
>   power/kvm_vm: remove the verification of lcore ID
> 
>  drivers/power/acpi/acpi_cpufreq.c             | 65 -------------------
>  drivers/power/amd_pstate/amd_pstate_cpufreq.c | 65 -------------------
>  drivers/power/cppc/cppc_cpufreq.c             | 65 -------------------
>  .../power/intel_pstate/intel_pstate_cpufreq.c | 65 -------------------
>  drivers/power/kvm_vm/kvm_vm.c                 | 10 ---
>  lib/power/power_common.h                      |  7 ++
>  lib/power/rte_power_cpufreq.c                 | 14 ++++
>  lib/power/rte_power_pmd_mgmt.c                | 25 ++-----
>  lib/power/rte_power_qos.c                     | 10 +--
>  9 files changed, 30 insertions(+), 296 deletions(-)
> 

Patch 3 did not get sent in the series maybe too big or mail issue?
