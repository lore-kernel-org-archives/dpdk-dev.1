Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D56CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:34:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 884FC40A82;
	Tue, 19 Aug 2025 01:33:30 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 4039740A6B
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:33:29 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-45a1b0b42d5so32888235e9.2
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560009;
 x=1756164809; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jk6locsOFPpvA4vf/kLMB7P2mFVKXJV63PITgnnEy8A=;
 b=WcRpLIzrayOnTOHrlUCBUwcatFwGfitxe3GD1Y12Zhyxj0mVCn0Z3v2bQqIcD8zyTX
 9TjMjlWI117UrPi2R5bmtOc8Ef8adaBCB1/mX+oRQpwtgeKlsHu5//jioibag3bGIMWN
 faw4xLhSu5h1UF7gE2k4ENLvAZFtoHKVSpUVqkG09L+ckf+GWsr1ME66scK0C2s5UGrO
 elqFeZfE60Dxbd4qCeIdqmaWjYmmqQrLXb2Sqk5x7LEg7CUpSEqh2G5s+VS5zIkztxgF
 u2ADA+or+yzyzZ4EymuIyoDjErkAitSTpx7G8TcGsUHGi2vLk4Rc6hJb0QdvxFAnariU
 o+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560009; x=1756164809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jk6locsOFPpvA4vf/kLMB7P2mFVKXJV63PITgnnEy8A=;
 b=wgOz5bSV8sLhBTtISDQImHp/4xMVzyg2APgoCkfs+b9GYz57T24B4HrawuRiMSypFb
 6JAHUjg+bg4RjnTTpl1mCnxyZ/eUkQ1MvYCd60bqr+TscqF51R8OEdNMGHpOLqvl6yhI
 4NDzElUQhq0xPXfTTj4okEpl1A7wMiMh+b5N1pzIG7xTGKTjf2lTK1hyO8JdhigM3O6F
 asTN6/DFSUTXRILQJl5MPII5ivigTpVMOdtfPJ4T541RW9FvsRixDljhLOOcFil8nmv7
 4q1g2A95+QkPcYKoaG0SCvWWzLdyQPCQ5cOplFs+BaOrRUwWNrhDJTP99C7NKKDWDo/D
 JHeA==
X-Gm-Message-State: AOJu0YyDFS292KK47yEbqkLhhIzsTq7NDWjZVZdfKlLujB2IqlVATXgY
 VGgB/CaoEfHhnDl1mL1hfWcIJdrQIgwXhsEFpN6HzgwOUYjubFc4RxVWwDLTYAAngJpdjAKGpAi
 t7HDt
X-Gm-Gg: ASbGnctdVBcSKt+hxH2kwVyAhFM7FWtiFOz1fdD9kdpaA9Kt8ygsDfUucJ4zKsA1/hF
 Y/FIotCcOLtf4bQ0MdYbzTdVK6HNFcSLg/+x81OwnrYKQsyoobHESIlaCkydPYtQlSj1isu6ujo
 I/BW3V0qxk6xLou1hE207xDNRApVnWpu0lDdznDiTnPE+w3Zhfm3jk/oG4agU3wsfw8g8323ONe
 pnPzvZ2iL7qS40SyNr0WGZDtN4ncQnNDs9dZ8N0vlUbQIXIdjNqX6RxiHta2yi+w/dZ9E919PQS
 hUataU96yatztVb6FVeq2ZLljzgvxVOd+9QUG8h1WcUvbRUZpg8M2qrUQug3teXole5hpGd45iu
 TQMKUM6o/K6OW0Eytlf8BjZsKkrbotELwgTt+5nIiuNv0YOMdk9GtURBDNtM8rem7AH/MDzYQ
X-Google-Smtp-Source: AGHT+IGFGWMndz+p8isXOKrEM4emTzH75tmKa0TDOQ2ZP2ucABN/04aTnGviiTaU/V8DsG3r60EOGw==
X-Received: by 2002:a05:6000:220c:b0:3b8:d5cb:ae1c with SMTP id
 ffacd0b85a97d-3c0ebadd7bemr290996f8f.28.1755560008854; 
 Mon, 18 Aug 2025 16:33:28 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:33:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC 20/47] bus/fslmc: use rte_tailq.h
Date: Mon, 18 Aug 2025 16:27:31 -0700
Message-ID: <20250818233102.180207-21-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818233102.180207-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
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

Use macros from rte_tailq.h instead using sys/queue.h directly.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/fslmc/bus_fslmc_driver.h     |  1 -
 drivers/bus/fslmc/fslmc_vfio.c           |  1 +
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c | 11 ++---------
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index 442de1a3fb..211864f945 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -17,7 +17,6 @@
 #include <stdlib.h>
 #include <limits.h>
 #include <errno.h>
-#include <sys/queue.h>
 #include <stdint.h>
 #include <inttypes.h>
 #include <linux/vfio.h>
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 68439cbd8c..d69bbb236c 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -21,6 +21,7 @@
 #include <sys/eventfd.h>
 #include <ctype.h>
 
+#include <bsd_queue.h>
 #include <eal_export.h>
 #include <eal_filesystem.h>
 #include <rte_mbuf.h>
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index e32471d8b5..8c87d35742 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -15,7 +15,6 @@
 #include <signal.h>
 #include <pthread.h>
 #include <sys/types.h>
-#include <sys/queue.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
@@ -32,6 +31,7 @@
 #include <rte_cycles.h>
 #include <rte_kvargs.h>
 #include <dev_driver.h>
+#include <rte_tailq.h>
 
 #include <fslmc_logs.h>
 #include <bus_fslmc_driver.h>
@@ -39,13 +39,6 @@
 #include "dpaa2_hw_dpio.h"
 #include <mc/fsl_dpmng.h>
 
-#ifndef TAILQ_FOREACH_SAFE
-#define	TAILQ_FOREACH_SAFE(var, head, field, tvar)			\
-	for ((var) = TAILQ_FIRST((head));				\
-	    (var) && ((tvar) = TAILQ_NEXT((var), field), 1);		\
-	    (var) = (tvar))
-#endif
-
 #define NUM_HOST_CPUS RTE_MAX_LCORE
 
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_io_portal)
@@ -105,7 +98,7 @@ static struct dpaa2_dpio_dev *get_dpio_dev_from_id(int32_t dpio_id)
 	struct dpaa2_dpio_dev *dpio_dev = NULL;
 
 	/* Get DPIO dev handle from list using index */
-	TAILQ_FOREACH(dpio_dev, &dpio_dev_list, next) {
+	RTE_TAILQ_FOREACH(dpio_dev, &dpio_dev_list, next) {
 		if (dpio_dev->hw_id == dpio_id)
 			break;
 	}
-- 
2.47.2

