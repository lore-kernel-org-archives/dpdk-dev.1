Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E24EF9D0D5
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 14:43:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3482A40663;
	Tue, 14 Apr 2026 16:42:58 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id 45DD94065E
 for <dev@dpdk.org>; Tue, 14 Apr 2026 16:42:56 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2d64c756111so6289922eec.1
 for <dev@dpdk.org>; Tue, 14 Apr 2026 07:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776177775;
 x=1776782575; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1YrUaXBP79zJWskApl/6HA+zxhefAMtVwdkeJ0poGY=;
 b=EhEqFcL3bFB877hLz2imgl4Ya6QY4G820RrRP82YXVkgA6snLAFhZS46XhdrWNh4ej
 ileDDTfwKS1/v7FpY375BocVYwVaerOargmCrF6aa1GJEa6ra7kLUDUm1WxGuT1OcDDO
 qiukIaPrUZuLCgNTZuOV7Tj6wvRORsHcTFEwq5kclqJ6pK/aZqbfRrwkZaRfQyuWq8Mf
 HH18+5feED3/jXk9KPVm1a+0Xk7xrCGfZ00MXWZxbRQQg2ilWbMqFRwKR4JZ/b1u9n/4
 4BvD2lUSeemR1Ykd1UI9IVx7bwQy8I2TtR9B09EyS+I7x0IBJu/m2RQo9igUVs+kKgGM
 eoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776177775; x=1776782575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V1YrUaXBP79zJWskApl/6HA+zxhefAMtVwdkeJ0poGY=;
 b=MMMXD0bj0zio53y4IwhGmbcDbs9SqblZEbp9OPR58vRIZL9fWQR/7pQ5Kw3zrm8lxo
 QCSO4eBKWWgFWySCGboaJOt4mL4OBxmkOymQg+y9krAQQ8pRAqQCUgO9rsPKSatDBxZr
 Zs5nDvNu26Pxtyg5pYmhcNNitDUKhKJ1h+tCOMEY7JMzGmeOeq9LjtJZbOOu/x4LsaHh
 ZCo22ihFviHLb4mRQ18Vvjh+AoNrcnWHms40n1T5/mYbJpWpkME76mCAfpMCe5naRxjD
 g2x1ChKP8JKc5z1j4jfoc6ApEbrAbMrQmh2CU5LW/1IN/fAERK9RXmqknTZ0H/uNE42f
 yppA==
X-Gm-Message-State: AOJu0YxMw5ghQdCYg3n7YiwOne9LS5Tk863GhcDrQWKcvAxV+yXJxa9d
 037lrQodWuvWd9PA+QEigY1+rsAZiOT8BfHXkUoU0AfMVeTwrGEqQiVXFYuQOWaaqE18cNmeZ6d
 tZp35
X-Gm-Gg: AeBDies5pH5BbxyZzjya1p1jHit5F75fjW56JaQiCrhN7DQZwHIhsSAygdWGFc83NDa
 SbpfsWhmIq/mDatvesAdAqo4MPKwj1VfDZf1XE1JI6DYO3g+5jWXjDiRKw6zmBFE8BcK2EdES2B
 Ubd4srH4fuwF1XsygpE9oiQeQTV8P3VBfSuauTEKF1GzJcOSYuZ/kayXP/Nq2IakdQUgkBv4k+E
 N3e8FRQtDZxc+HcT69Er8FlQDo20K04QzDmvlq/sGOaEQlogLQ4qZTO4XZ77NbaXWb6ezgtSIK4
 SeguGEjlLgui0b/q+DBuCL46F+SNMMhIcCn7GhImGUN3W6PdU3mPFTlCOXHGFU1NXnKHdM/WjpA
 bZzsGiQi6uGBmWT/KPryCKOX4B6fofShdOsp2GVNDwk2qyJjwZeSzGlEvoPVMbiJenOpxTUN2D/
 NMfycKcRHFhaH1taM9xppIqiYoGCuukO672QUT87bbiE4=
X-Received: by 2002:a05:7300:dc13:b0:2be:2cfe:68b7 with SMTP id
 5a478bee46e88-2d586992571mr9503923eec.11.1776177775295; 
 Tue, 14 Apr 2026 07:42:55 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d55f5c69d5sm24985835eec.3.2026.04.14.07.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 07:42:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH v2 5/6] net/bnxt: fix mutexes for multi-process
Date: Tue, 14 Apr 2026 07:39:57 -0700
Message-ID: <20260414144246.110681-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414144246.110681-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
 <20260414144246.110681-1-stephen@networkplumber.org>
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

The BNXT driver supports secondary processes, as shown by the
explicit check in bnxt_dev_init(). Multiple mutexes are located
in structures allocated in shared memory (dev_private and
rte_zmalloc'd structures) that are accessible by both primary
and secondary processes.

However, the mutexes are initialized without PTHREAD_PROCESS_SHARED
attribute, which means synchronization between processes is
undefined behavior.

POSIX mutexes are by default private to the process creating them.
When a mutex protects data structures in shared memory that are
accessed by multiple processes, pthread_mutexattr_setpshared() must
be called with PTHREAD_PROCESS_SHARED.

This patch adds a helper function and updates all mutex
initializations in the BNXT driver:
  - flow_lock, def_cp_lock, health_check_lock, err_recovery_lock
    in struct bnxt (bnxt_ethdev.c)
  - vfr_start_lock in rep_info (bnxt_ethdev.c)
  - txq_lock in struct bnxt_tx_queue (bnxt_txq.c)
  - bnxt_ulp_mutex in session state (bnxt_ulp.c)
  - flow_db_lock in cfg_data (bnxt_ulp_tf.c, bnxt_ulp_tfc.c)

Bugzilla ID: 662
Fixes: 1cb3d39a48f7 ("net/bnxt: synchronize between flow related functions")
Fixes: 5526c8025d4d ("net/bnxt: fix race between interrupt handler and dev config")
Fixes: b59e4be2b6a7 ("net/bnxt: fix VF representor port add")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnxt/bnxt_ethdev.c         | 11 ++++++-----
 drivers/net/bnxt/bnxt_txq.c            |  3 ++-
 drivers/net/bnxt/bnxt_util.c           | 13 +++++++++++++
 drivers/net/bnxt/bnxt_util.h           |  2 ++
 drivers/net/bnxt/tf_ulp/bnxt_ulp.c     |  2 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c  |  2 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c |  2 +-
 7 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index b677f9491d..3f55ad041d 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -5899,10 +5899,10 @@ static int bnxt_get_config(struct bnxt *bp)
 static int
 bnxt_init_locks(struct bnxt *bp)
 {
-	pthread_mutex_init(&bp->flow_lock, NULL);
-	pthread_mutex_init(&bp->def_cp_lock, NULL);
-	pthread_mutex_init(&bp->health_check_lock, NULL);
-	pthread_mutex_init(&bp->err_recovery_lock, NULL);
+	bnxt_init_mutex(&bp->flow_lock);
+	bnxt_init_mutex(&bp->def_cp_lock);
+	bnxt_init_mutex(&bp->health_check_lock);
+	bnxt_init_mutex(&bp->err_recovery_lock);
 
 	return 0;
 }
@@ -6920,7 +6920,8 @@ static int bnxt_init_rep_info(struct bnxt *bp)
 	for (i = 0; i < BNXT_MAX_CFA_CODE; i++)
 		bp->cfa_code_map[i] = BNXT_VF_IDX_INVALID;
 
-	return pthread_mutex_init(&bp->rep_info->vfr_start_lock, NULL);
+	bnxt_init_mutex(&bp->rep_info->vfr_start_lock);
+	return 0;
 }
 
 static int bnxt_rep_port_probe(struct rte_pci_device *pci_dev,
diff --git a/drivers/net/bnxt/bnxt_txq.c b/drivers/net/bnxt/bnxt_txq.c
index 7752f06eb7..8c834acb1d 100644
--- a/drivers/net/bnxt/bnxt_txq.c
+++ b/drivers/net/bnxt/bnxt_txq.c
@@ -204,7 +204,8 @@ int bnxt_tx_queue_setup_op(struct rte_eth_dev *eth_dev,
 		goto err;
 	}
 
-	return pthread_mutex_init(&txq->txq_lock, NULL);
+	bnxt_init_mutex(&txq->txq_lock);
+	return 0;
 err:
 	bnxt_tx_queue_release_op(eth_dev, queue_idx);
 	return rc;
diff --git a/drivers/net/bnxt/bnxt_util.c b/drivers/net/bnxt/bnxt_util.c
index aa184496c2..c3f0a03f25 100644
--- a/drivers/net/bnxt/bnxt_util.c
+++ b/drivers/net/bnxt/bnxt_util.c
@@ -3,6 +3,7 @@
  * All rights reserved.
  */
 
+#include <pthread.h>
 #include <inttypes.h>
 #include <rte_ether.h>
 
@@ -37,3 +38,15 @@ uint8_t hweight32(uint32_t word32)
 	res = res + (res >> 8);
 	return (res + (res >> 16)) & 0x000000FF;
 }
+
+/* Initialize mutex so that it can be shared between processes */
+void
+bnxt_init_mutex(pthread_mutex_t *mutex)
+{
+	pthread_mutexattr_t attr;
+
+	pthread_mutexattr_init(&attr);
+	pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
+	pthread_mutex_init(mutex, &attr);
+	pthread_mutexattr_destroy(&attr);
+}
diff --git a/drivers/net/bnxt/bnxt_util.h b/drivers/net/bnxt/bnxt_util.h
index 416a6a2609..e1b45d1bb5 100644
--- a/drivers/net/bnxt/bnxt_util.h
+++ b/drivers/net/bnxt/bnxt_util.h
@@ -16,4 +16,6 @@
 int bnxt_check_zero_bytes(const uint8_t *bytes, int len);
 void bnxt_eth_hw_addr_random(uint8_t *mac_addr);
 uint8_t hweight32(uint32_t word32);
+void bnxt_init_mutex(pthread_mutex_t *mutex);
+
 #endif /* _BNXT_UTIL_H_ */
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
index 0c03ae7a83..c2c93859ff 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
@@ -214,7 +214,7 @@ ulp_session_init(struct bnxt *bp,
 			session->pci_info.domain = pci_addr->domain;
 			session->pci_info.bus = pci_addr->bus;
 			memcpy(session->dsn, bp->dsn, sizeof(session->dsn));
-			pthread_mutex_init(&session->bnxt_ulp_mutex, NULL);
+			bnxt_init_mutex(&session->bnxt_ulp_mutex);
 			STAILQ_INSERT_TAIL(&bnxt_ulp_session_list,
 					   session, next);
 		}
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
index bc347de202..d87120aea3 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
@@ -1469,7 +1469,7 @@ ulp_tf_init(struct bnxt *bp,
 		goto jump_to_error;
 	}
 
-	pthread_mutex_init(&bp->ulp_ctx->cfg_data->flow_db_lock, NULL);
+	bnxt_init_mutex(&bp->ulp_ctx->cfg_data->flow_db_lock);
 
 	/* Initialize ulp dparms with values devargs passed */
 	rc = ulp_tf_dparms_init(bp, bp->ulp_ctx);
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
index ad44ec93ca..0c3d1f7dae 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
@@ -1038,7 +1038,7 @@ ulp_tfc_init(struct bnxt *bp,
 		goto jump_to_error;
 	}
 
-	pthread_mutex_init(&bp->ulp_ctx->cfg_data->flow_db_lock, NULL);
+	bnxt_init_mutex(&bp->ulp_ctx->cfg_data->flow_db_lock);
 
 	rc = ulp_tfc_dparms_init(bp, bp->ulp_ctx, ulp_dev_id);
 	if (rc) {
-- 
2.53.0

