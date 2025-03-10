Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4338CC282EC
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 14:59:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19E6A402E1;
	Mon, 10 Mar 2025 15:59:54 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 99F49400D7
 for <dev@dpdk.org>; Mon, 10 Mar 2025 15:59:52 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2241053582dso69308255ad.1
 for <dev@dpdk.org>; Mon, 10 Mar 2025 07:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741618791;
 x=1742223591; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=44MhMkyNVL1XXf2o6oJe/G+WCeEmBJsWNoVbWl/OjYI=;
 b=mJ5G1DHf50F2gBFCWHWADPMGdtd//5nDUD85Q64Yin9OxFn0pPwJGw7Bt8kDEWrLwl
 TXfdS0GYa0LhUs7J0pjFmFyDbi2XPjaXsFC52KRweEaxu4sevW7jNDsKeb+0T4qZoElm
 +D4+/kQ1XhjaVdSgyLn6fRm0gL5sVRD7HjYLx+N5rin47Jz2HQv8CKRLZClUzjQpqCiR
 iwFguK3S73D79rZubLl4oQKMk69hrig/fhxnTWIIytlujvtxY5KSzaXu9fTtEDEhMwNQ
 s5nXbHsLOhb5ZnG3CkFnGfdearG2LyQan93CC6amJXLr7a2PZ4j4fcXXFj3AKzwPJmbn
 9J1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741618791; x=1742223591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=44MhMkyNVL1XXf2o6oJe/G+WCeEmBJsWNoVbWl/OjYI=;
 b=FKvSsFMi6TK1KzobCEbZm1PTUHj2ieq7qH8MYdIjnm3kMK0Nf/pv0u4l2BSbOQin2I
 n/I+CcSegCrI8FQxWJSG6DPofC1D8ZsAwIvjPo9ljS3s0bWKWB2paNaOKq11Dcveiicp
 njfGDnZDoGHmchwWkoJ63ZbA655DHOGmvVorjr1mm8sUolbWBrDbavokcQQvEKJ3W8un
 k2q1qtHqKAodxVsSvp/4m7Ndb9LRJmN7roxzzb9B7Wa10uc7KGYDeOyx1QgsUERsAKHP
 eI2MHjVqUR6inB3PzyineJmlTUbNVhKUeef0RFJG+1zQx/9hCJnV9QSIuzLUgvcpT2zC
 Y/2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjJeBZBW7Py31/Blemyx4UHwDui+h8VekGxasFMYLl6woZcYoodPkvD85lMWZVzx8iRiw=@dpdk.org
X-Gm-Message-State: AOJu0Yz3MiX62HVxbrwdMC4M7UDhdBZNzWlmVUeqM4D36cQz1Iphask4
 76MNDXdrhzou/qvesF/sKOZ2GIK2ByBJc5zB3GFRrQQtKFHd56r7l65wFAtj4zo=
X-Gm-Gg: ASbGncsryqrwi2R/lcAIWdFIHBMZYtbFp48D29rj9eov1yK9hW7n8BjDwwSUgd/psYI
 Q1T0sM+sN3aq3sR2b112CgE0z9Ll5mJdin/1B0i7RFjiagqVhmf9ElaCgvqvtA5sNxY3FnTZQ0r
 XRj5jr9s+yhd2SFFGDMfk5I8LENu41AcuXc3ybct0Os668Kr9Y5y7ye5qV2kd5ZvsnmSLE6ZLSz
 8DizapjL7fKT3nekWB+HQJ3a6EYo8tpk85llcdHwJ+2XIZRegdhomZZjbkxIe8OUSTPTFyokcdD
 lagkPU+mizhQ9JOvOB27UurtE/dnWdVq1ve4kOPgydSiGc8LhquIuIA7afQ9cLRGjomFRcP5w7z
 Q/AUFmjbOKLktlctVRsOcrxRufKEXJoZX
X-Google-Smtp-Source: AGHT+IGhWtuiWq3LC7dEwsnlJ/kgcmgcPxJCusK6KWXZQsS4O79BfyL5iqtogi1Pe6+e6Ho/oCgsnA==
X-Received: by 2002:a17:903:181:b0:21f:7082:1137 with SMTP id
 d9443c01a7336-224288974bbmr260030735ad.22.1741618790322; 
 Mon, 10 Mar 2025 07:59:50 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109e9850sm79238365ad.86.2025.03.10.07.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 07:59:50 -0700 (PDT)
Date: Mon, 10 Mar 2025 07:59:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bing Zhao <bingz@nvidia.com>
Cc: Yang Ming <ming.1.yang@nokia-sbell.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH 2/2] net/mlx5: improve log file path
Message-ID: <20250310075948.56109517@hermes.local>
In-Reply-To: <SN7PR12MB69096FB0FD4930E9CE8A8F80D0C82@SN7PR12MB6909.namprd12.prod.outlook.com>
References: <20241213092444.2987-1-ming.1.yang@nokia-sbell.com>
 <20241213092444.2987-2-ming.1.yang@nokia-sbell.com>
 <SN7PR12MB69096FB0FD4930E9CE8A8F80D0C82@SN7PR12MB6909.namprd12.prod.outlook.com>
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

On Tue, 4 Mar 2025 06:23:06 +0000
Bing Zhao <bingz@nvidia.com> wrote:

> Hi Ming,
> 
> > -----Original Message-----
> > From: Yang Ming <ming.1.yang@nokia-sbell.com>
> > Sent: Friday, December 13, 2024 5:25 PM
> > To: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> > <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> > <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad
> > <matan@nvidia.com>
> > Cc: dev@dpdk.org; Yang Ming <ming.1.yang@nokia-sbell.com>
> > Subject: [PATCH 2/2] net/mlx5: improve log file path
> > 
> > External email: Use caution opening links or attachments
> > 
> > 
> > 1. /var/log is hard code which is not a good coding style.
> > 2. /var/log may be not allowed to be written via container's read-only
> > mode.
> > 
> > Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
> > ---
> >  drivers/net/mlx5/mlx5_rxtx.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/mlx5/mlx5_rxtx.c b/drivers/net/mlx5/mlx5_rxtx.c
> > index eadadcdffb..a0da73c9c3 100644
> > --- a/drivers/net/mlx5/mlx5_rxtx.c
> > +++ b/drivers/net/mlx5/mlx5_rxtx.c
> > @@ -12,6 +12,7 @@
> >  #include <rte_prefetch.h>
> >  #include <rte_common.h>
> >  #include <rte_branch_prediction.h>
> > +#include <rte_eal.h>
> >  #include <rte_ether.h>
> >  #include <rte_cycles.h>
> >  #include <rte_flow.h>
> > @@ -311,7 +312,7 @@ mlx5_set_swp_types_table(void)
> >         }
> >  }
> > 
> > -#define MLX5_SYSTEM_LOG_DIR "/var/log"
> > +#define MLX5_SYSTEM_LOG_DIR rte_eal_get_runtime_dir()  
> 
> I agree that using the fixed PATH is not a good practice. Can you ensure that the runtime DIR is with RW+ permissions?

Drivers doing any kind of custom logging is bad practice.
This should be handled by EAL logging, not private fprintf's


