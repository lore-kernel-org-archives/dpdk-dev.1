Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C8BCA0EE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 21:06:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5A8140657;
	Wed, 13 Aug 2025 23:06:52 +0200 (CEST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 2C78E40269
 for <dev@dpdk.org>; Wed, 13 Aug 2025 23:06:51 +0200 (CEST)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-45a1b00e4a1so1553765e9.0
 for <dev@dpdk.org>; Wed, 13 Aug 2025 14:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755119210;
 x=1755724010; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DfUzgc5tDNlZe/AhGvEEFQFlM8bIqxWkrt4zhov2M1M=;
 b=1QcOzPweaOGJlD6u1C/m3NWeLpYXy86Ar4MREC5+oJD75Df/PD8zY1WsYZ7F7nA3ti
 Vv/1uYBSWUmv5wyQESHqNltqh47/DhunlmAyb4CyseoxLfAiRF9a+xNiyLSwS6HFaCCW
 Ttdx2KUbDAcrXHh8XuAtVqeaPLOvD+2d+7KyuB0T/TkPpdFl77d+46BENXUjYzU11QTv
 RJi9bwU6O7vUDRozjde+UMpSiikpDW8PvarpTh12H71T5B1EUjESLjkB1RdigGsGG8PV
 MKEm2mqTeyEBWDNWj7bX2TsK7uTbtEuRQqf4M/hE4uWfc6CxzihxuVfJkiiL4cCZpGTr
 iT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755119210; x=1755724010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DfUzgc5tDNlZe/AhGvEEFQFlM8bIqxWkrt4zhov2M1M=;
 b=sHsPW7xb8pRoU4YOKlqzShHOrNhYvSa+pJFGifouEEWUY0ahU0ZLk3FiQ3LZE/EDdX
 90K5RY9SHTIbiDukEzot2BXf8+wvKB1w1R3QNOwdTlv6MxSa8eLKG7MqbX1fEhC/lueZ
 m3Zxiio31SejchO1PGTcZZpcCKo5c8YbvBQ7S6NNsPBOlsBV8nm6kDV2mLjSAICrqs09
 KvlPiuS9kcWWCAciB+zsXgQwTxEI/HkwTdbZLoB+AV7JlyR0pYIvjx9aK1kI5bzjhwAA
 jTMPdJ5y29jOFtMxn4MhQTjw19KyX+iu7Qda1B/xibftVMdCmQAhmTg9+c9GWwI9GK5B
 jQwg==
X-Gm-Message-State: AOJu0YwTUyK5DqRzYjD5djomVxzbB4MD1+wY8QF9iSwdi4Ph5z87eElF
 BNrnd7kDm1+nHJWftYIj+JDgI06jGiKe/ovMSNxPmKXxsKJSYkyOv/E16EQA84vMVvQ=
X-Gm-Gg: ASbGncuXsIgW8roYsvVBjNIeru400gUGegc3OSXzJn2Ln5XPAdpDi+bs2iNbH1vxDww
 /VmNlPLLwofJz8uM1QKLztYujUkqmNd8NFRB5mhvmazl6EV6n+LdVkZ3w0QQZNTCt06x0sUobqh
 DTTOzfqJiW4tu2VCvWBkHjuoagjF/VetcZq8wjL4Rna7nLY+x+YduWTDG7xuKRm/mU66FRUYM23
 Hmpjqsi5lIQmFksGSaeNhPBsK/FNcL+5uyxAg2nmVG2sxR5HKcsd7H6h5GM7f3d/6yyPVB6kPOl
 M57rwl1N2k+NGx5HV/PrWU4nZ8uRwF5krfaGKZBkQXdN/R0ru/x2J+xpmI/db66ckrrtPuOfAIi
 Uy/objNuEsS+D+iAM/MjoIdaGSO1ie1atYPWIHdP+7MVSEAfdSLWwNiYJpJGrfCSCP7Znt7RkAq
 0=
X-Google-Smtp-Source: AGHT+IHpzed09kNE19tb3oKntrwKn0k0j6bYmkSRq0y5OV9tt9vW+VgD99YtXuDfHVYXXsTau1V4gw==
X-Received: by 2002:a05:600c:3586:b0:458:b068:777a with SMTP id
 5b1f17b1804b1-45a1b667fd8mr2304995e9.30.1755119210321; 
 Wed, 13 Aug 2025 14:06:50 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3abec8sm50817421f8f.8.2025.08.13.14.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 14:06:50 -0700 (PDT)
Date: Wed, 13 Aug 2025 14:06:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dengdui Huang <huangdengdui@huawei.com>
Cc: <dev@dpdk.org>, <lihuisong@huawei.com>, <fengchengwen@huawei.com>,
 <liuyonglong@huawei.com>
Subject: Re: [PATCH 1/3] net/hns3: fix inconsistent lock
Message-ID: <20250813140646.48a2ff16@hermes.local>
In-Reply-To: <20250813073317.1352274-2-huangdengdui@huawei.com>
References: <20250813073317.1352274-1-huangdengdui@huawei.com>
 <20250813073317.1352274-2-huangdengdui@huawei.com>
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

On Wed, 13 Aug 2025 15:33:15 +0800
Dengdui Huang <huangdengdui@huawei.com> wrote:

> The hns3 driver supports configuring RSS through both ops API and
> rte_flow API. The ops API uses spink lock, while the rte_flow API uses
> pthread mutex lock. When concurrent calls occur, issues may arise.
> This patch replaces the lock in the flow API with spink lock.
> 
> Fixes: 1bdcca8006e4 ("net/hns3: fix flow director lock")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> ---

With that mutex removed, you can also go farther and remove all references to pthread.

$ git diff
diff --git a/drivers/net/hns3/hns3_ethdev.h b/drivers/net/hns3/hns3_ethdev.h
index a63ab99edc..f6bb1b5d43 100644
--- a/drivers/net/hns3/hns3_ethdev.h
+++ b/drivers/net/hns3/hns3_ethdev.h
@@ -5,7 +5,6 @@
 #ifndef HNS3_ETHDEV_H
 #define HNS3_ETHDEV_H
 
-#include <pthread.h>
 #include <ethdev_driver.h>
 #include <rte_byteorder.h>
 #include <rte_io.h>
diff --git a/drivers/net/hns3/hns3_flow.c b/drivers/net/hns3/hns3_flow.c
index 458d4ffbf1..f2d1e4ec3a 100644
--- a/drivers/net/hns3/hns3_flow.c
+++ b/drivers/net/hns3/hns3_flow.c
@@ -2853,13 +2853,10 @@ void
 hns3_flow_init(struct rte_eth_dev *dev)
 {
        struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-       pthread_mutexattr_t attr;
 
        if (rte_eal_process_type() != RTE_PROC_PRIMARY)
                return;
 
-       pthread_mutexattr_init(&attr);
-       pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
        dev->data->dev_flags |= RTE_ETH_DEV_FLOW_OPS_THREAD_SAFE;
 
        TAILQ_INIT(&hw->flow_fdir_list);
