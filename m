Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0498ECAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 16:55:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C39E40DDE;
	Wed, 24 Sep 2025 18:55:40 +0200 (CEST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id 750B940615
 for <dev@dpdk.org>; Wed, 24 Sep 2025 18:55:36 +0200 (CEST)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-4da3019b6b6so432351cf.3
 for <dev@dpdk.org>; Wed, 24 Sep 2025 09:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758732936;
 x=1759337736; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fKKw3z/NFMAH3CxgzH31FIDFgg6hB1Y5AsLanAcmMZs=;
 b=ErbyerIWB5j24A+IUEdWajsEvcA0r0SWtubOFeQJETTEzEasfwyJZ5g69d9Z79nwRE
 IRyc6DxleRx7iY2w6lQRVJ8OVvVyb/VbMBZM/AxIrtf5+GzwSot/hUjEsSZjftO9f3zI
 HmRrVcRLAPrsRpy1wkZu5hbIs+pOLgXBuexJmP40uox42ai69VybivRPuIUILvrRHo8k
 YsULQZn5Bvk1MOA44Js3PuR0iCwGvTWMTwwJpvY62kn96i0Ezy2RiLn9gqofbUbPi+ri
 tXbLPrkgV4Wex5pauRy7U/cqhoaqceV5aPzmL9K1uZrNTzDWh8eBMThQ+t4vsQa3Pop5
 14fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758732936; x=1759337736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fKKw3z/NFMAH3CxgzH31FIDFgg6hB1Y5AsLanAcmMZs=;
 b=fEpRWj7FB8d4LXY6hrSZGgONllel6tNYS0DvyrKHED290iT2SbAaZE4yR/A+jQG1Wr
 eUTl+egvEgmeFomXbhYOTRSzPVKOEmj5rMBtaDvJRfeDP+cZV+vm/linYVeJNpwCtqVG
 Nm0pjRUfq/Mh6bCX3bRyPafMSWyjakY8rTda0+XWc6Em34q7deOrBsDS7DLOX3UJkzYw
 pU2BQdYf2bwFa0Ww18q6/pRq2u6EAYimDXSWx60WvelcpbOiZJyONbalckPwlK2RvHp0
 87p+pgI1i13Quv0iNtx4fN43kEQY2dSOjrJZ+yPrNIGpvdI5tKoz76VJM1TzvPTMn0Ua
 /X1w==
X-Gm-Message-State: AOJu0Yzl1fZmJfihxi4p5yP5FguXsss434ZzCzOeDLaljGRhmbMyJsnN
 M9xozhY+P+r5pIRDX8piJk0ZuPiP1PPmGZiWIAGjSJHFtEW09uToe6EJfFDtL6Lwwqa9rMqSNQ6
 owtI8
X-Gm-Gg: ASbGncubbpRBBDq2NQ8rNoFohFe/7cOcLHuN2qjNdcgmlPE7MCvYAbHWO1lpt6Dq4mE
 NBNe+FXU9K3JCqiHaIrH8iqwhi1AWZx4Lila5uOutVr9J0QMZ7U4/wUA0cveFZtj/Vxa2sVpGYp
 4JdquRgdX4/f6RN3NSPSkyXENeq41CfoD9pQm6arNJZZ9aXKJ57NasrSWGY3Cd2o2tbQsxsmx+7
 cvwyvW58Lmz0BVkHltNHgsV4DitF7jxBVdtC44yaa2MT/ucXc+NKoiHVyF0o8sD3mXXLSNfmRyq
 EVMVQxthlcT4RWLh0jQRAcXDhw178IaC29hRekuZSJWsdsZBetPdrocZLOaUI6Az6nz0b+7KiwA
 p7r/yCrDaiGeQanlCWLfdw7JgkrVTCjp5X+Kz/18OcAyNObWBCJ6F1U2fceJj9e0w9POGwa97
X-Google-Smtp-Source: AGHT+IGtgNUS2rr32z/e3tSQtPav9Iy4g2cjRWtDrUaRzlwMxT9DXkY8lQaxNotO1O0XPTIUlTzcxA==
X-Received: by 2002:a05:622a:1a0f:b0:4b0:da90:d7d with SMTP id
 d75a77b69052e-4da47a1a220mr7855851cf.3.1758732935632; 
 Wed, 24 Sep 2025 09:55:35 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4bda15f91a0sm106052751cf.1.2025.09.24.09.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 09:55:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC 4/6] dma/skeleton: avoid use of pthread_cancel
Date: Wed, 24 Sep 2025 09:51:11 -0700
Message-ID: <20250924165527.268645-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250924165527.268645-1-stephen@networkplumber.org>
References: <20250924165527.268645-1-stephen@networkplumber.org>
MIME-Version: 1.0
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

Can use exit_flag to do controlled shutdown of the control thread.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/dma/skeleton/skeleton_dmadev.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/skeleton/skeleton_dmadev.c b/drivers/dma/skeleton/skeleton_dmadev.c
index e287802eb9..62a25f9d34 100644
--- a/drivers/dma/skeleton/skeleton_dmadev.c
+++ b/drivers/dma/skeleton/skeleton_dmadev.c
@@ -5,8 +5,6 @@
 #include <inttypes.h>
 #include <stdlib.h>
 
-#include <pthread.h>
-
 #include <bus_vdev_driver.h>
 #include <rte_cycles.h>
 #include <rte_eal.h>
@@ -215,10 +213,9 @@ skeldma_stop(struct rte_dma_dev *dev)
 {
 	struct skeldma_hw *hw = dev->data->dev_private;
 
+	/* setting exit flag causes cpuwork_thread to exit polling loop */
 	hw->exit_flag = true;
-	rte_delay_ms(1);
 
-	(void)pthread_cancel((pthread_t)hw->thread.opaque_id);
 	rte_thread_join(hw->thread, NULL);
 
 	return 0;
-- 
2.47.3

