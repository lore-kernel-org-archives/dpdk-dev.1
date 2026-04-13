Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49670F34C74
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Apr 2026 17:19:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D979D40661;
	Mon, 13 Apr 2026 19:18:48 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 1A31440666
 for <dev@dpdk.org>; Mon, 13 Apr 2026 19:18:47 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2d868d014a5so1424668eec.1
 for <dev@dpdk.org>; Mon, 13 Apr 2026 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776100726;
 x=1776705526; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1YrUaXBP79zJWskApl/6HA+zxhefAMtVwdkeJ0poGY=;
 b=MNVYGmqFkrInqHiXL2Hy2iC3TyOOjT97/hQJrgn6cybqH03YKd9rwAMxz1upnCmjbi
 YrOUQvgkKU1EWii+3Wyew/V/XaufkQ+fDUZ4y4lk7jvdFsTzSdkHHd2CKg6078jKaLL7
 jwf6zn6edZ/+qizcBZJSShqWjc8PYQBLyDku8OzCZhX17kMy5zD+9/WpKwm+UcsIukPu
 ahT83x1HQ3UdBvAcX8RLWSg7F55Oe3JaVDXCap3dKICZQsagXmzy5C1c4y68zgI2Q8uF
 isQmSrCRgN6/r2mse1DlLXwYBOpYTiAzYMOE12MyHM5T22LZCneJzPTOdGo0juT81akB
 NQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776100726; x=1776705526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V1YrUaXBP79zJWskApl/6HA+zxhefAMtVwdkeJ0poGY=;
 b=FS0zqzYgHoSta8Fj6KygUrprTMMTo3i+kRhvg5bxut/uPFPGP797EtgAQelCJBBA3b
 1wzRHU9rKAugjw++O8nI+usHL3yZ3pPigAphl97berhfE+5AN1BZvDR3ektw2IFn4Uht
 6oi95BYBYQAYIHIOGUbnXz54vaPYc6+daR5d49+o6LN+vArtH4ujUj9PpqUe5rK1pF9w
 JStjsGCx+W7upLyCogwPxueKInSK9R1YZ05nxZtIxaf804sDS7Iq6NsyGu7S4bp1vcjq
 jiMPPzxbW+kl43PyVgOhVu74KY6v3cwgYrhRq6qgkUYwQS5IPzM022E233cYxJ+070BI
 LHHQ==
X-Gm-Message-State: AOJu0YwGcSCdhpzLhOhVCdWOHA+4FbWPeyItKOHkdsGO1bhoVvItBdtT
 taBE3DWQDl/lY9YPSrJW4jYYVgmkfwktxDUGC1Ru+05UR2iuPBQCf9/0HHgJVKvZRusRIktXaPq
 pa0V0
X-Gm-Gg: AeBDievreYaMfwYRKeci40lmtOwWSypQcgSj9mjJ+R+KapClkf9pV8+STbFibPRrRwV
 dGhPT2kcJhYsh5c/XQVsLaSq8Qsh/q2qmtOAXrN38FmO+GpC4QuDz/Hy8lNAfvOGHDsETmo7RQ0
 ldaySP88PNDA+IRrYKCGsnWH2+Xmp352t96VSKK0ZoOvr0qE79Gz/SNGHQHGJJenH2FEou0Uk3H
 jbLnrVzkmlo6mw6u+ijdK5hUsGfu3/egm45IRRg15ebzZWT2PgR6nuQvsxOZTenxFWEq0xhyhhG
 1J8+YBdim+jNdy5qyLTSjf47RqY1j73ioPaLyPnoJI3Z+a9Ai7h9jgSszVAZsrLOUdrkH+VFx9L
 tMwgL269ulV4niygCwAEccjZVx9oAKCQZFU3ia13yLGz7PkrRBEjGpVGFVNp3/aZF9uUOqp40va
 TLctOIdzOeSuP3RThdXMGvuq1NY2cBGRDAv70A8hKmp7M=
X-Received: by 2002:a05:7301:1525:b0:2d9:bc8d:f62a with SMTP id
 5a478bee46e88-2d9bc8df8eamr1458586eec.16.1776100726076; 
 Mon, 13 Apr 2026 10:18:46 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d55f5c69d5sm20258602eec.3.2026.04.13.10.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 10:18:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH 5/6] net/bnxt: fix mutexes for multi-process
Date: Mon, 13 Apr 2026 10:14:49 -0700
Message-ID: <20260413171836.123467-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413171836.123467-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
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

