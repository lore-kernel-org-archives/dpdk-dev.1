Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D469C982DA
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:14:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFC9D40E31;
	Sun, 20 Sep 2026 20:14:10 +0200 (CEST)
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43]) by mails.dpdk.org (Postfix) with ESMTP id B051940DF8
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:04 +0200 (CEST)
Received: by mail-pz2-f43.google.com with SMTP id
 41be03b00d2f7-cc1cea4ae2dso1294759a12.3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928044;
 x=1790532844; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8uc6CKTt4J/rs+2MByFfL1PislzEC7x9D2Hb/MJ7FE4=;
 b=JMxpjHxIhDsNuWuN+i02208mbw1cVgZ1GDq49n9IZyWxhKBE2p0lCWGGT5ApbDviR2
 LtL0wGBQ2K4fZHxb2wbq7+HOzOBRimYwHth1uZcmZYC6IktHHYrKMj0Gi4X7a3vPehB1
 1eDB/1spStHQXWGoHeEKvx5JxWpJNw4ZqN21MVa0Ve3xaAxN8CcTQI6sT4O/lnm8Qx6I
 K627MLtY2b2zohuICD2XEiXur1a04zay8/BLu2FUAaQUAroHm7QmRG9fIhmK4/A4hbDR
 TM316dmPnt7l0r1+ZFoXkdrcfcyiUvYsotUzbHIMNFdMjivovYNP9KYUoOItFUd2XxOH
 PV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928044; x=1790532844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8uc6CKTt4J/rs+2MByFfL1PislzEC7x9D2Hb/MJ7FE4=;
 b=D/R+3HIEd8pb2nvRkYiUQ6PHVtP/WUj/gUuXPEdTvxQDlAUxzEmfv2v4m10GuTxT9/
 dTvjzZc0JCTk/240h3ugm989Ik42NTs6rXar67lOCk+Bm96ub88UScpRWtrYHplnW4MG
 1R6bHB6LZGMRcGo2Ca8N1dMOO1R8tX50BAnhpWhKVEpzcxt3lTvDRiIEyn/yAN8pLgBZ
 p4ADjxFg2G5y3rfEkiyZjeAZ4xg+vZ5u/1I2v8P2xlvc8CINGJawxa21Yus8Vwm7z2J4
 4ILui9FK5XGhA6aYlS4GSiVKHdhIxka09a3aJo0735FoxwY6dBcJelVTcY1APJjpiCUM
 p9wA==
X-Gm-Message-State: AFuF++lFstFzMD3NweRRjjKUtEpk3BFDY+KsLpaB/ysvJJxvY0ysOUG1
 CWO5gLijGyj9RY4VUvhLXc78dueETNFTRA3U63o/IiNLv2bbYP8t7ONxpuMNREXD0ceSI65MR5v
 cJSgo
X-Gm-Gg: AYBFou1Z5BdSgmoaxQzEBy4aFE+RYrfSaWgCFDNRXkqHzx3GygrLOCe+5YUCKoUIjYn
 X1JG4fu8vowrTqEHB6XeGZSxIgWIOweGv/GHfqD/OndforKq8pttG7WfgUmkaRXu9yOKdhZZ4jE
 z1/pE+fIx1s4GHWrDsyw3tkQn6GUOqtCxr2MmqsVn1HednUH/1RUlAaNYh1VGVFZ0JUS/8jvGTc
 6NGRR36cfafZBv/Weend3tye+91kepExLAdNg3CBnWsnJCIQWFr3OpzgWt1kRIGKHrfONyHTCcu
 afFjijS7Cvkbwa2b+n2aZcrXYLj/zq2EDvI3diN33pJsyxyzpwtjiaAaf7HqeurrnZP7xw+9oBx
 aZJleAjEGetaxlr1UQ1hbr/lbcp0lj+LiI2Oz/x2gPBCS246E9a712gcMea2uFBceF0jzCgx8o1
 kwMG3behAJQWV6NPD9dWga6c3bpRUeeKE7rpO1Ftor+EYnA+R1a6jr6DFmhRniG0mJ3/DMgKell
 uZdb62KA30OlLVtSI4OBD2SAq/fVCnm2plbiXnCSx4tkmJV
X-Received: by 2002:a17:90a:4cc7:b0:3a0:22bd:6ef0 with SMTP id
 98e67ed59e1d1-3a022bd85efmr4219706a91.30.1789928043832; 
 Sun, 20 Sep 2026 11:14:03 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>
Subject: [PATCH v2 10/33] net/thunderx: replace rte_smp_rmb
Date: Sun, 20 Sep 2026 11:10:02 -0700
Message-ID: <20260920181347.747210-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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

Replace rte_smp_rmb with equivalent
rte_atomic_thread_fence(rte_memory_order_acquire).

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/thunderx/base/nicvf_plat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/thunderx/base/nicvf_plat.h b/drivers/net/thunderx/base/nicvf_plat.h
index 8421f57040..7d22563035 100644
--- a/drivers/net/thunderx/base/nicvf_plat.h
+++ b/drivers/net/thunderx/base/nicvf_plat.h
@@ -26,7 +26,7 @@
 /* barrier */
 #include <rte_atomic.h>
 #define nicvf_smp_wmb() rte_smp_wmb()
-#define nicvf_smp_rmb() rte_smp_rmb()
+#define nicvf_smp_rmb() rte_atomic_thread_fence(rte_memory_order_acquire)
 
 /* utils */
 #include <rte_common.h>
-- 
2.53.0

