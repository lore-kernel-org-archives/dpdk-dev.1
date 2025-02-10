Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18C3C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 19:57:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACA26402A1;
	Mon, 10 Feb 2025 20:57:31 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 9A07D4021E
 for <dev@dpdk.org>; Mon, 10 Feb 2025 20:57:30 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-21f7f03d7c0so38696695ad.3
 for <dev@dpdk.org>; Mon, 10 Feb 2025 11:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739217450;
 x=1739822250; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVh1g1hIAvFt8jMzO3q2Ari8+TG0POwBsCyuU+l8gCQ=;
 b=O8opsE67ecfylueIkDu94/kXh7tzhXTjxVjlVJe8PqXw1AfgNUI+ii6DlZdeHUMLFq
 H7CPRZou3U7vp/nzCH8+mOVpsdNNTw5PPmtFrGfHhLEphulcbdZLl83WUTYr++xHQFT7
 O6DDxilynYns4kKRKX3SQTq4MlWpe7NLhpHKGRbUS7FIUAY2v/AxI6wRrfljpAbsy6Uw
 oMi+wVn2uV+sx12je+jOhy9hB8PHzCCwHDsY5x9BZkuJAb5gbfiMa86uxZEemPz3VCF6
 Q/wyS8vvqbfKb3AqwrtcqjR8po+jhB///j3vzCinZ1oQHDo7twNRMdn43tk2ON4ZvbKc
 pjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739217450; x=1739822250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uVh1g1hIAvFt8jMzO3q2Ari8+TG0POwBsCyuU+l8gCQ=;
 b=vVeRqVzw3Zn3LdvPlrqAd5H6pwUaQGt6Amw7B6hPH086+X84QA7EzDwm4xlAvyIyMa
 JyTF/IuPnvb1DwyoeyR+e2LQ3K4eFN/l5GhP3OOFJGlBkM5kVaFbBC+Bs2zDP78n4nxr
 ozlzaQajjAwxAzuqMdCPeJHVyLWY7UeAKDO898klrS+Mg0K7rZLI3XGqBfpLjGM47O5v
 QKsHQRuXyQt/kifjcPXeCQsCQU1IwyBBEBXgwe3ELmQkLVQPfV8NYWh3UDB8G3xNgsJQ
 gA4w8YG+H+srQ5v+yVkqODYDD7mdd2/MA8kzkzBjI3E6Xih80EOHj63yh8sUYxapVmXx
 u0sg==
X-Gm-Message-State: AOJu0Yx7aNV+/f9B8qpBqwBjgHHqfDyMXNwdnIAUwOokOQ6ps4S+DMXB
 4yhTZSzRl5fRwA7o+iF4cr3ghsaGT7QO2nd/VxB64CH3KENFoRTAQG3nDP3r8gQ=
X-Gm-Gg: ASbGncuTu6E5F3vyGnashyyRqusyXsy3m2nwx5iP93SYzZTm35w2djTGDf6l86+kdzE
 dcSMRr2BsWxoE/O0Bvp4Vr5iUdMHayqXiwJ0/lwG1hoj1Ewtj6rmpoBMYu9D+Enr1wKykQ/+2GD
 MhW47P+0dr4fOhs/uuV1m0EY7Xls6MoHvP2cJkQS4DV8xec/+2upyrxxODX8bF/gDMcanGlR5+z
 FjEHO29lSe3ofnN7UWZs0Oy+EqjQ/ZCAcfIc6zIyv82qTZXZJyO8hDbrZ2nEbujyTcVqICwrodO
 jOXZRuNZVFMyRddCSfvrkzZBUnVNnOOK96RgNWnpF3rFh1CQ9RqUEbRIurV5SxlKU/QH
X-Google-Smtp-Source: AGHT+IGmnkjn/FltENJWfJ2IwhMBoVQB0HalpkR6mCH4Dm9Yj60VHsfkbarg8G+aQVTeVHHromektw==
X-Received: by 2002:a17:903:19cf:b0:210:f706:dc4b with SMTP id
 d9443c01a7336-21f4e6a9a19mr213040065ad.13.1739217449683; 
 Mon, 10 Feb 2025 11:57:29 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3683db25sm82101465ad.134.2025.02.10.11.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 11:57:29 -0800 (PST)
Date: Mon, 10 Feb 2025 11:57:27 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
Cc: dev@dpdk.org, ferruh.yigit@amd.com, kai.ji@intel.com,
 brian.dooley@intel.com
Subject: Re: [PATCH v5] net: add thread-safe crc api
Message-ID: <20250210115727.4e2570dd@hermes.local>
In-Reply-To: <20250207182443.9775-1-arkadiuszx.kusztal@intel.com>
References: <20250207063758.3971992-1-arkadiuszx.kusztal@intel.com>
 <20250207182443.9775-1-arkadiuszx.kusztal@intel.com>
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

On Fri,  7 Feb 2025 18:24:43 +0000
Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com> wrote:

> +static struct
> +{
> +	rte_net_crc_handler f[RTE_NET_CRC_REQS];
> +} handlers_dpdk26[RTE_NET_CRC_AVX512 + 1];
> +

Should have { after the struct

+void rte_net_crc_free(struct rte_net_crc *crc)
+{
+	rte_free(crc);
+}

Add rte_net_crc_free to the coccinelle script that checks for null free.
Also add function attributes please.

> diff --git a/lib/net/rte_net_crc.h b/lib/net/rte_net_crc.h
> index 72d3e10ff6..ffac8c2f1f 100644
> --- a/lib/net/rte_net_crc.h
> +++ b/lib/net/rte_net_crc.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: BSD-3-Clause
> - * Copyright(c) 2017-2020 Intel Corporation
> + * Copyright(c) 2017-2025 Intel Corporation
>   */

Not sure what DPDK policy is around copyright date updates.
The Linux kernel has said no to this (excess churn).

> +struct rte_net_crc *rte_net_crc_set_alg_v26(enum rte_net_crc_alg alg,
> +	enum rte_net_crc_type type)

Since this now an allocator should add function attributes __rte_malloc
and __rte_dealloc(rte_crc_free, 1).


> +{
> +	uint16_t max_simd_bitwidth;
> +	struct rte_net_crc *crc;
> +
> +	crc = rte_zmalloc(NULL, sizeof(struct rte_net_crc), 0);
> +	if (crc == NULL)
> +		return NULL;

Are you using rte_malloc here because it can be shared between primary/secondary?
Otherwise regular malloc has more checks.
