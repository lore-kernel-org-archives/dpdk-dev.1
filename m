Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADC5CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 18:59:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DBC5402C5;
	Wed,  5 Nov 2025 19:59:53 +0100 (CET)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id ECDB34021F
 for <dev@dpdk.org>; Wed,  5 Nov 2025 19:59:51 +0100 (CET)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-7af6a6f20easo240137b3a.0
 for <dev@dpdk.org>; Wed, 05 Nov 2025 10:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762369191;
 x=1762973991; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tMdyIuGISo7IjFWKmCGZeuwWtmtzSaq3TWiixecNvr0=;
 b=t72frQ2291rayRFCrMuoviKlC6OAnNdtNsKL6MiJzaThe8Beukhmw+Yj4J2cIsfBDK
 q4w1sJI2Hly+pnbMHJTxN7vHxcDNkXgVmE0xAU25qoGytj6M8riTMyTN5OgoQkjZSkYK
 WyWurYAZPgsAUKe/PEdoAEZe3yHDt/7joXzs3N/byQqTqwpX+oryNPJFuv5bb7f1BbkY
 r6zPEr8wNYKJWHw6OcZNE7ldFxCZ4TytrZa6dNh0ZbdOurE3dkua28KRscSTuRGU1lik
 tDzyrQAAGElJuX7NygdISTs3rG0lfMWKE2LeqmE/TClcT1qe5IWMl5m7JxV9lUnwy54N
 rrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762369191; x=1762973991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tMdyIuGISo7IjFWKmCGZeuwWtmtzSaq3TWiixecNvr0=;
 b=SJB6gSEwIG2JL36FmsBfJSNCck5fTmncFh01ytlMpLwHmSkfmRNzMwiT4c6vFc4y59
 oHW9Bjhd3fczcphtaLpMs6Zalnq1dM7+QK+o8UAtvASyOCo80ChMMbePMS/XXNGewrSw
 CBXUO0wcrexmAmiQHUGVaj1SB4p0R79/DMDNedYW958g7EHDIlXWEh5QHBqCUaCR5czA
 0MHTfCgG4niJiB6oI1m9xW6XVoCN02OONVJmf69r1oyp7VBKF6ObFw+2gQ47VuzDSLG5
 ldc+FmDgjeZJkzRnAPW1jaZfmm80xmwlLZoAPyidOkvXUS9PP/YjtSgK40hKxjgxWDim
 PKLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbNQvmW6A7YDoRgPcXKdZY0NonV6hOI0CfUy90D/oldtcU10RDiJZZzWhdxilIvjSqg9I=@dpdk.org
X-Gm-Message-State: AOJu0YzGZcZmGd1V5sHm6lCLZd0qY7uQzwLrAw0W54DCqJwCy5tjba72
 ARRDfquCkYYMHKs+yxpmp80+b37+8LnxJsxW0f8eitctUTrsDh0uZXsqn+1u7FgVZbo=
X-Gm-Gg: ASbGncukQQAtOjoV5S5ug6pl9sbcpIl5qSKRQCl9YDDXXGFdE8hLmijnGb212/GhxtF
 fxmMSwqjtF5CjNuR+pfZIYU6fhqGBGRvXJRsU/+IT58mvWUDvNwYi7+xnlX+5uiqtJktp435sF+
 y4zX4iTVvvntGcV5JQtMTidoDsEQAKm4+3Wucs7wsufLaB2RvVnOYisqUMK74dUojIOM8Bhif9Q
 xwSJ0U4L5o4K8bmoxTcoJuF247yxUUfr6Vmugp0Jp10FMT0HJyYEy3NMgc7IP663EZtKdRInQcZ
 ANCqDGpg8Jf38xHRfSNlTPhz71L1jiK/oTR/hFoN5I2Yu2u5wUABbK0vTBNnobB+XifBf4EdpLq
 GX3eZUK/NnEFWEjpqA31bkWyx5Lxs76qp+o1pUJD4CQ2G5E7x2jJVCC/elYWNCSlG0PtNRIsTkZ
 39G6XQ+iWpqpZsUqwv9sa6EhCW5Po19YuoVQ==
X-Google-Smtp-Source: AGHT+IH54VxeZ8/k33Ki+8Cb9GJAQjdsG0duVAIAQjwHSPt9pEbZgSwyulrUJyqKO3fsIrwo5hEIog==
X-Received: by 2002:a05:6a20:2729:b0:340:cc06:9514 with SMTP id
 adf61e73a8af0-34f86e0bb65mr4042962637.57.1762369190775; 
 Wed, 05 Nov 2025 10:59:50 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-341a68d5c17sm3718541a91.13.2025.11.05.10.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 10:59:50 -0800 (PST)
Date: Wed, 5 Nov 2025 10:59:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>, <aman.deep.singh@intel.com>,
 <liuyonglong@huawei.com>, <yangxingui@huawei.com>, <lihuisong@huawei.com>
Subject: Re: [PATCH v2 0/3] testpmd support pause/resume specify lcore's fwd
Message-ID: <20251105105946.73a06834@phoenix>
In-Reply-To: <20251105094748.3269-1-fengchengwen@huawei.com>
References: <20251104040916.25864-1-fengchengwen@huawei.com>
 <20251105094748.3269-1-fengchengwen@huawei.com>
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

On Wed, 5 Nov 2025 17:47:45 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> This patch support pause/resume specify lcore's forwarding for testpmd,
> and also include two bugfix which found when test DCB function.
> 
> Chengwen Feng (3):
>   app/testpmd: fix invalid txp when setup DCB forward
>   app/testpmd: fix wrong Rx queues when setup DCB forward
>   app/testpmd: support pause/resume specify lcore
> 
>  app/test-pmd/cmdline.c                      | 126 ++++++++++++++++++++
>  app/test-pmd/config.c                       |   9 +-
>  app/test-pmd/testpmd.c                      |   5 +
>  app/test-pmd/testpmd.h                      |   2 +-
>  doc/guides/testpmd_app_ug/testpmd_funcs.rst |  14 +++
>  5 files changed, 149 insertions(+), 7 deletions(-)
> 

Please split bug fix from enhancements.

The whole scheme looks like an optimization for power usage in testpmd.
Since testpmd is solely focused on performance, I don't think you have
provided enough justification to add the new feature.

With DCB if there are TC's that could receive packets, it is better
not to never poll those queues. 

That said, longer term it would make sense to bring of the power
saving logic that is in examples into testpmd.
