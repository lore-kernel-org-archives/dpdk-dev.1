Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7C2D73EBC
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 05:22:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC1E640673;
	Fri, 30 Jan 2026 06:22:02 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 9407240679
 for <dev@dpdk.org>; Fri, 30 Jan 2026 06:22:00 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so1114259f8f.0
 for <dev@dpdk.org>; Thu, 29 Jan 2026 21:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769750520;
 x=1770355320; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gk7ijCDi36pGsoqP+jdxCcq73zEvkdPwZuA5aci4hu0=;
 b=PoXCorf2aOikJw3w+4CHVLk/17/69pun0VGQB8rd+ZUxUd/E5N7dpjtNXCKQoXqsvh
 4DBUNn/tMGPFNCz7lga6x+LHF5carXP6orotHxSAWn7+/kB8a1RspjywAPLoAUtsJymY
 chlHyewhhnRnF6o4v9kDNy8mtLwaHIRP+G7960N9bixgw+2hukY44IHiPAptMPipKjvq
 BVj3AWUPhqNeT7xielNe6mELl/s7Af+Ag+zyj6bWtrezsSBvDQiSz0TtYgXc/fWASI4h
 hST2Kz5vM16s86qTtOhlyz/Ebgi9nkJqy7oXwyTpsT1Ze2WKntNemR3A//YjDNISKpq6
 ZC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769750520; x=1770355320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gk7ijCDi36pGsoqP+jdxCcq73zEvkdPwZuA5aci4hu0=;
 b=vbRy4dEoTZdSA5VcNgM1gbD1hoLeCkWTROrCvw3yhuvJn5Ay2uD5fjh1XpKQ9hPY15
 1C9As2Wg8p96s4hONmk6Top4gXE884+7nRX1gtN2XEgAWEjnvPXv3sTiQl4QCXyNTJI6
 3mz/8vQbNJxYhaSfG6pCoAQbHljNFxhtrLYMvS+joRvEkmZvfyzxzL+K/0zJ3h2hWI00
 2eOlbbsDKMTWiv3tTYx+GzgVADaIikpks10+vuQJp6SfE75AZG3RozxH3DB5e21E00R9
 N238+dCizWfhIKRUy2QNK/Fo1SBOasE1hCrTclsNOnd32lMNptmZ7jlRxVdA6AUYGMQ3
 9pkw==
X-Gm-Message-State: AOJu0YxLntQ5kbZwQrg2nLacf9Imgwx6kVCWryAiElIALp9NelyQhYZm
 jJAJIr+eKcFSVTufgxwGWH2rgU3C+qC/QduRxHQdv7EFWEpvq1BeA8w+euNOCIhmLu4dYY1wJYK
 29FGg
X-Gm-Gg: AZuq6aL685E9a9IaSAxOXQd1FRyPtfa+Wl/QSQgX0yHsfxSXbHT6rHwIoYP/US+Nrf4
 q9XSvrseG/R2B9YHkAtpSn+7gHxydkIZeuqvV/hgaY6EO/oXrnaC0m92TU7fw15b/s+xyyb2dsl
 kzsKNY1NODk2rBgE47CsWtVyL8vwAgMwhqD6dIbEfkpS6hheoOLPWf93YUUp4AEQQ6a39XA+bWK
 vBJ1cQ4vSk9nlRQ1otEcjl6MAAee0EokY5mAbQadTylPEksz4Id7urtyag4HEN0tbVJjQRAHhnw
 jTgL5PNsB3lUpeETcJ8UIgRB1AE91ove1v/pdtthH1PeQA1A1mvyLUnJwa0UQlGzJCOiBh0LBil
 Su8T+/i9MNkPyPNX2raBSP56eNiBrWGwDag7Dx7RqaF9PwvUnqIlDBS2sXtyLN6VQROkyTAWwq3
 RzeUwB00q693GliGNLDDswnPOlQNsclnRcdxupAd3TIkZJmMXULQ==
X-Received: by 2002:a5d:5d13:0:b0:435:ad52:31d8 with SMTP id
 ffacd0b85a97d-435f3aafc5dmr2562026f8f.44.1769750520137; 
 Thu, 29 Jan 2026 21:22:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1323034sm19182107f8f.35.2026.01.29.21.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 21:21:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [RFC 5/6] net/bnxt: fix mutexes for multi-process
Date: Thu, 29 Jan 2026 21:17:36 -0800
Message-ID: <20260130052142.251649-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130052142.251649-1-stephen@networkplumber.org>
References: <20260130052142.251649-1-stephen@networkplumber.org>
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
index 3c618c6e82..a954514014 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -5858,10 +5858,10 @@ static int bnxt_get_config(struct bnxt *bp)
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
@@ -6879,7 +6879,8 @@ static int bnxt_init_rep_info(struct bnxt *bp)
 	for (i = 0; i < BNXT_MAX_CFA_CODE; i++)
 		bp->cfa_code_map[i] = BNXT_VF_IDX_INVALID;
 
-	return pthread_mutex_init(&bp->rep_info->vfr_start_lock, NULL);
+	bnxt_init_mutex(&bp->rep_info->vfr_start_lock);
+	return 0;
 }
 
 static int bnxt_rep_port_probe(struct rte_pci_device *pci_dev,
diff --git a/drivers/net/bnxt/bnxt_txq.c b/drivers/net/bnxt/bnxt_txq.c
index 3938ebc709..6deed08ad7 100644
--- a/drivers/net/bnxt/bnxt_txq.c
+++ b/drivers/net/bnxt/bnxt_txq.c
@@ -198,7 +198,8 @@ int bnxt_tx_queue_setup_op(struct rte_eth_dev *eth_dev,
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
index 38cb5c8b31..5cb79a03e4 100644
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
2.51.0

