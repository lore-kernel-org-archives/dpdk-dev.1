Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F61C7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 16:45:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01B2F4060C;
	Sun, 29 Jun 2025 18:45:24 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id C6D2A4025D
 for <dev@dpdk.org>; Sun, 29 Jun 2025 18:45:10 +0200 (CEST)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-7c5f720c717so497126385a.0
 for <dev@dpdk.org>; Sun, 29 Jun 2025 09:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751215510;
 x=1751820310; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ahc4kL6+UfBMavlJRmStyvvjqLhKZyS9G/vBhqcCiF0=;
 b=QpBUHYafqQl+0pQRyKGZgvhHNuMCtjggt1Yca6VmmhBduT8kLygC2SeHREkefcF948
 dBzQvRbj5ZBrTmOr6Rx3oGmoYupyPoP7lrqb72gUAJGSQ83cvdFf0riw+a3PLlOM0D+F
 C1Up/Y/kMwwfe2xEMphCP3R8pPUIZOVype0z7y20gWxLdOxMnnSoNi1EgBg8qnk3uIaz
 PN1q4LyVjEd/V/RpEUQtZFMTdhrPXH6kHpYpqWRX3QQaDX/l27z0QYLJyG1wWIGgNNQ3
 1U276gQTJJPkWdbxBQ7o9C2o8EpVtcjIJXmgemhn6FUVeWl+0XUhR+Sju5mrHbCO3zwt
 /d/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751215510; x=1751820310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahc4kL6+UfBMavlJRmStyvvjqLhKZyS9G/vBhqcCiF0=;
 b=dhvw/d9jJf7FnVq1+ErXBM0zdyOth8AUAQVtFnnm/KBuTs8iAsOv/B5mnr8sTJKTsj
 ZFb2LrjSSrq9wt9cbOTCpemlfNSzIxRbZl4xnPDytbV84oZwZJu9sJNd8NB872hic7cW
 1jlUooTd7yGIVDasL7lgjDobDhaS40DGcs6b1G69mDhNpUBqoDToY5LbNdHih/WMPVnf
 57IdE5h4fiC8HGTBrfUQcKLBzdcC82oYaasIz6MPULROnxppEfjN4gWWcirSFeffG4yt
 OHvargz6KUl/gxNXd1u9Ht0Z+RBMXtHzEi8+1Vq4Dg1vmdEttKIpBP41kJ9BLSL58VD6
 9VwA==
X-Gm-Message-State: AOJu0YzEeHCNEZxN9rbR8lidaq/JGDrHJv6FFMoEMTXh2vfkTvVG/aDS
 Pus7Oq/xbSKMtgk55puIDPqIh4JQcQS/EnHK1znWnIxQE8rgzZIPFqkZldjSAjAXeGHQSM7yitA
 He1h727w=
X-Gm-Gg: ASbGncu2wX+ZfRzULxrKYCm/a2BI6+edPizYn3JdY0yPHSV0FiX26xb1zcJj4RF73k3
 dizPgPu4hUMkhoMcDnxQ/Pvoa1o8LzII2sb8yq7NcZ08NhWiEGzfszmkSE5lR0ML7/Rz+gauh/I
 7lhh/av/9hm1xni4Q+SL8tOmDTNNeuWJr0rYunpb5VheyCZjT5FuA8zdZQlLBFWv4sxB535FShU
 tpNw/6Ag+TUArjfRUrf1bHHXGJqThzJes2G8s9IEI8Ztx1zE0Jiq/ZgVJp3YDEwiMkuP4isyCNq
 IkGKue1pYX3JsSdiG+muePTlMgiLYVs60Z6wmcu/OCNXd8v0axBsqliYoISFtK+17lAbyTlBfA7
 cbHYhNGREtwGQJIOwx6w1YsAc1Bbp2ecam2FEae8=
X-Google-Smtp-Source: AGHT+IF6XQtSe96yPrUb11QbmD7WdzF8fk1f9kpu/agWG3awLbqBPA7mYE9/o7z8mIb4CUQAdnJ4wg==
X-Received: by 2002:a05:620a:4488:b0:7d0:a2c1:975b with SMTP id
 af79cd13be357-7d444177679mr1505329685a.14.1751215510062; 
 Sun, 29 Jun 2025 09:45:10 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d44316547bsm456985385a.27.2025.06.29.09.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 09:45:09 -0700 (PDT)
Date: Sun, 29 Jun 2025 09:37:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Subject: Re: [v4 06/10] mempool/dpaa: adjust pool element for LS1043A errata
Message-ID: <20250629093725.7e4bf5de@hermes.local>
In-Reply-To: <20250611071039.2939950-7-vanshika.shukla@nxp.com>
References: <20250610091411.2500413-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-7-vanshika.shukla@nxp.com>
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

On Wed, 11 Jun 2025 12:40:35 +0530
vanshika.shukla@nxp.com wrote:

> From: Jun Yang <jun.yang@nxp.com>
> 
> Adjust every element of pool by populate callback.
> 1) Make sure start DMA address is aligned with 16B.
> 2) For buffer across 4KB boundary, make sure start DMA address is
>    aligned with 256B.
> 
> Signed-off-by: Jun Yang <jun.yang@nxp.com>
> ---
>  drivers/mempool/dpaa/dpaa_mempool.c | 145 +++++++++++++++++++++++++++-
>  drivers/mempool/dpaa/dpaa_mempool.h |  11 ++-
>  2 files changed, 150 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mempool/dpaa/dpaa_mempool.c b/drivers/mempool/dpaa/dpaa_mempool.c
> index 6c850f5cb2..2af6ebcee2 100644
> --- a/drivers/mempool/dpaa/dpaa_mempool.c
> +++ b/drivers/mempool/dpaa/dpaa_mempool.c
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: BSD-3-Clause
>   *
> - *   Copyright 2017,2019,2023 NXP
> + *   Copyright 2017,2019,2023-2025 NXP
>   *
>   */
>  
> @@ -13,6 +13,7 @@
>  #include <signal.h>
>  #include <pthread.h>
>  #include <sys/types.h>
> +
>  #include <sys/syscall.h>
>  
>  #include <eal_export.h>

Please don't introduce unnecessary whitespace changes.
