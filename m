Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772D7C5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 20:52:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E708E4026C;
	Wed,  4 Jun 2025 22:52:46 +0200 (CEST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 3A8AA4025D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 22:52:45 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-6f8aa9e6ffdso3830896d6.3
 for <dev@dpdk.org>; Wed, 04 Jun 2025 13:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749070364;
 x=1749675164; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DyLsrMpBITUYDR2mamYoL6y5GNuFQI4XvkHclT45yM=;
 b=zsECKdkj0SUiCqeOQNvVayVIEz28WSQuD8WtyZtQt1uRHVkL7M9fEuNrtGq2LxVKxh
 bTVGmF2v6VKRFV4l4IOgE+xoFPcZIJm5fkBLrDNupGaglJWmOgohqZHLCpIhGxKyp6A8
 tS/VIBanZAN8qjbKWITe+tnBZCE8cCwmk518PrpO+qVEF+zknhi/jYSZ0ZZRfcqfHyvx
 MLg3umWEp37NYWqi5Wqo9c08yMcwMgJZbxh+K2MXq1vbeHIRVrGYmlxKyGUdK1H1AUSR
 0aDzVEgFp3vKCSNWGZaSbquUhF0zB2DUXdxkOJNDHHf9qSShJEpl4knOKFWdJ0yqG5VX
 WJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749070364; x=1749675164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7DyLsrMpBITUYDR2mamYoL6y5GNuFQI4XvkHclT45yM=;
 b=A3wNMeIrnGcSAGn7CHi+b3Vrj3jpMAnDS6X3vkzxsx1nZjXwIuh8jPm3Rhiv246ARB
 HhkeXSwsH9flTzDWw0VCvcytFbd/Ot5pSnXZqVa4cutwahPL5vQIxjPnE0ngXYeq+Yy9
 qkcaEGCPoqDGZ9BzXQUTxf0zFs1g4CpE++vVVvvXLTwVeV5GijL1ACym+XmbvOC3kxHL
 kOb+kdCnf56r9ats44vbkeggAXxmr/jgLi78lSiHUutWbLJX3fpk811+z2DfyxtFa8ez
 5EbbMu1Kb0cM5nkbTcLzH0BIHAMVSdPqF1ksJK63NNjVkztNFNKH43fT0yFXoErgbBjk
 /j4Q==
X-Gm-Message-State: AOJu0Yw64qG0WscYpPNC2pHmvoTQuEDE9OCPGnfW0pj4YxKVpd/ppVk5
 Np5bc3dsAIxWROjHeMEa5OXU5u9dAotRXRXJM3XAZ04n9rmDHw48K/xrRfV7tFG6kC2pk8b3TNv
 rjlG3
X-Gm-Gg: ASbGncsP40b0CnVPx+1GDbSyPJEbqIevr+l1Ij56fkXxnJb3RGuakuZFc5y3GNTA2WF
 CqfhwGpNIp/1oBEwJ/63PNMtG7J1yxtFimNX94EnNzG2gkZu2a6BdHY8p+YQReVzLVdj4P55n0o
 sj8Lw8+Ca+Ohi/Oj/B9cZfw+uJb/svxn1CLGS/wvRnmHXbONW82G7LioebDFwzDKA1+xX8tACRy
 8UxaTWNhy9awuHpx24HhHem18iXxMaA68j6Q4xT/3hPg9/UL4U9ZVepaZFASM8F2FPxRdJmEUBY
 q0Pz/4Uro3PSeb9ii/+onhFkpG62lNepxVUfEwAyVpCz84uhOXqqkuvSUPndGafh+clkvONcnMY
 xYJbYhNGhyyc8IKKr9YdgxPU+A5Pp
X-Google-Smtp-Source: AGHT+IFCHzIWdnbnD9xD+6Jb9SosxBOscZYf948s5K/KZvXxHPTgpy7NFwTz6V7dTknlVPKUA1LMKw==
X-Received: by 2002:ad4:5c6b:0:b0:6fa:c0ca:ba70 with SMTP id
 6a1803df08f44-6faf7a6e582mr62567126d6.42.1749070364455; 
 Wed, 04 Jun 2025 13:52:44 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fac6d337aesm105855476d6.8.2025.06.04.13.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 13:52:44 -0700 (PDT)
Date: Wed, 4 Jun 2025 13:52:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wencheng Li <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v8 1/3] net/macb: add new poll mode driver
Message-ID: <20250604135239.15e7eadb@hermes.local>
In-Reply-To: <1749020395-44053-1-git-send-email-liwencheng@phytium.com.cn>
References: <1744946730-31821-1-git-send-email-liwencheng@phytium.com.cn>
 <1749020395-44053-1-git-send-email-liwencheng@phytium.com.cn>
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

On Wed,  4 Jun 2025 06:59:55 +0000
Wencheng Li <liwencheng@phytium.com.cn> wrote:

> diff --git a/drivers/net/macb/base/macb_uio.c b/drivers/net/macb/base/macb_uio.c
> new file mode 100644
> index 0000000..19b757d
> --- /dev/null
> +++ b/drivers/net/macb/base/macb_uio.c
> @@ -0,0 +1,351 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2022 Phytium Technology Co., Ltd.
> + */
> +#include <dirent.h>
> +
> +#include "macb_uio.h"
> +
> +#define MACB_UIO_DRV_DIR "/sys/bus/platform/drivers/macb_uio"
> +#define UIO_DEV_DIR "/sys/class/uio"
> +

If this driver requires a kernel module, it should use
RTE_PMD_REGISTER_KMOD_DEP like other drivers.

Where is the source for this kernel module? What is its license?
