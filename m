Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2271ACCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 18:48:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8585B40BA4;
	Wed, 29 Apr 2026 20:47:53 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 6F38F40A73
 for <dev@dpdk.org>; Wed, 29 Apr 2026 20:47:51 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso258506eec.1
 for <dev@dpdk.org>; Wed, 29 Apr 2026 11:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777488470;
 x=1778093270; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HgwKE+OoHEdrqozl3t/NQZTGIqGAemQ6nTxV2Tpib1s=;
 b=skzoVd8S6rkNClUeVDxNK338gbMNlD6y3/ixY/WgO/yjNMkIFLh/YPCCdvwEVnJNdK
 woIP7NX8hRsnkklXY29FPhM43RV3a4siHkidbcMOYtdevfwEZVBTgsvKVvdqiHlHMl8M
 o85pXZvhPUwjq57qXM5j4Ie7BCiq3aYViDP341/3hZlJYBd1W4XZq3yN9WitqqdjFDfi
 Aq/0g9DvFsZH9hPmFArvS5YmbmA1mEJkYpJ0OYf79Hi0y68KAKZruuJGHIslGbB26E3H
 Ti+ju5ssBqOt5VlbWIWtBJwjx8nrA90dQ5ODZ62bl5TwXGN2v74ySddsAzpJ3mMX8FnQ
 w2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777488470; x=1778093270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HgwKE+OoHEdrqozl3t/NQZTGIqGAemQ6nTxV2Tpib1s=;
 b=Q2NSIOpo/z79dQYnr1V8flv7gnLm6cLa6fvVla2KhkFUWFJ47sTGHvadspgREiW20P
 PXhfTzalOaPKaiZuehrOr5I+tmoYzdfpB4PPMcO50idcFG/WtloFjbZri338gT6CqL9k
 aCFiaYX1pfkMxrRGqsAvFMdF3/UPGTXG4urZC0yjecjnTtUbN6VxYZ+VvO3/kIjt8HYS
 YaIS8M6K9QXaWPFzl+6Bx6FUoSa/zFrO8B+EZw9DGB0mYfYU2WxOjCuYz+zdJo0pxrs4
 f7wF2nq6evZXgThBI6+ExyMP4hk2MpTI4opEyCamQzCiikBHgBJfMj8VYSkquoNElTAw
 TclA==
X-Gm-Message-State: AOJu0YzCthNzAbv+WnzzX865Jz/PMs3qv23EzhANOyYV55s4NhmUy/MX
 miLlM+U4Bd1R7a0nBpede22oQ6YhJsXW8n3gnE6uyvtMY+ifpS2uTwyr0JtCUEHBbwV8/8yq0wn
 kJ69S
X-Gm-Gg: AeBDietBxYlJGxcfy/cHJ0F5dz2HQt25VlC9t1M9yTkmFzxGFnNF2ZUEO0MXb2I2GOJ
 KrvkRsz9wuKRwN2Ii7c0XV/QgwEaVGm8Kr2telujBFkEVs1879hdAf+4qymSgTttPw/5QsIJ7bJ
 Hu4F2z6s7hPvw/UnJFWZm7fL2FUyM6eUeV0GryEheTXZW7hxPdVI4CsRJTVpVYt2f9Zxke/2yS9
 oebLqIzywsN3+gAoHyXfgkU+YyzcCw5fFrhzkeUndNYjHFAkzaJmQD23oRyoe0LousO6rDfiEoU
 UBf2XlUPIz6JeVWWl4uwLKldOV1vDo1gJQ3ZO1JUjwiadLF6H2Sbd4eylh/T6fPw3t52wT4oiNT
 VdKkxaWjxhPPMPx8cOD/qWAiHyZpxOSCBqT33SNthPeyFHnScY1umRb8stRG3mp5FWk1XPpZ60c
 a2/hACPGHiwVdY5NXjjpdjIJeENwCwt8p+iOL8BoI9W24=
X-Received: by 2002:a05:7300:5708:b0:2da:1874:f3bd with SMTP id
 5a478bee46e88-2ed198bf621mr2580491eec.16.1777488470486; 
 Wed, 29 Apr 2026 11:47:50 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c09ca30sm3271027eec.24.2026.04.29.11.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 11:47:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH v3 6/7] net/bnxt: fix mutexes for multi-process
Date: Wed, 29 Apr 2026 11:46:43 -0700
Message-ID: <20260429184739.706250-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429184739.706250-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
 <20260429184739.706250-1-stephen@networkplumber.org>
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

The BNXT driver supports secondary processes. Several mutexes live in
structures allocated in shared memory (dev_private and rte_zmalloc'd
structures) and must be initialized with PTHREAD_PROCESS_SHARED:

  - flow_lock, def_cp_lock, health_check_lock, err_recovery_lock
    in struct bnxt
  - vfr_start_lock in rep_info
  - txq_lock in struct bnxt_tx_queue
  - bnxt_ulp_mutex in session state
  - flow_db_lock in cfg_data

Bugzilla ID: 662
Fixes: 1cb3d39a48f7 ("net/bnxt: synchronize between flow related functions")
Fixes: 5526c8025d4d ("net/bnxt: fix race between interrupt handler and dev config")
Fixes: b59e4be2b6a7 ("net/bnxt: fix VF representor port add")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnxt/bnxt_ethdev.c         | 11 ++++++-----
 drivers/net/bnxt/bnxt_txq.c            |  3 ++-
 drivers/net/bnxt/tf_ulp/bnxt_ulp.c     |  2 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c  |  2 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c |  2 +-
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index b677f9491d..4c5c042ed8 100644
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
+	rte_thread_mutex_init_shared(&bp->flow_lock);
+	rte_thread_mutex_init_shared(&bp->def_cp_lock);
+	rte_thread_mutex_init_shared(&bp->health_check_lock);
+	rte_thread_mutex_init_shared(&bp->err_recovery_lock);
 
 	return 0;
 }
@@ -6920,7 +6920,8 @@ static int bnxt_init_rep_info(struct bnxt *bp)
 	for (i = 0; i < BNXT_MAX_CFA_CODE; i++)
 		bp->cfa_code_map[i] = BNXT_VF_IDX_INVALID;
 
-	return pthread_mutex_init(&bp->rep_info->vfr_start_lock, NULL);
+	rte_thread_mutex_init_shared(&bp->rep_info->vfr_start_lock);
+	return 0;
 }
 
 static int bnxt_rep_port_probe(struct rte_pci_device *pci_dev,
diff --git a/drivers/net/bnxt/bnxt_txq.c b/drivers/net/bnxt/bnxt_txq.c
index 7752f06eb7..03407c556a 100644
--- a/drivers/net/bnxt/bnxt_txq.c
+++ b/drivers/net/bnxt/bnxt_txq.c
@@ -204,7 +204,8 @@ int bnxt_tx_queue_setup_op(struct rte_eth_dev *eth_dev,
 		goto err;
 	}
 
-	return pthread_mutex_init(&txq->txq_lock, NULL);
+	rte_thread_mutex_init_shared(&txq->txq_lock);
+	return 0;
 err:
 	bnxt_tx_queue_release_op(eth_dev, queue_idx);
 	return rc;
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
index 0c03ae7a83..c28cf4f2b5 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
@@ -214,7 +214,7 @@ ulp_session_init(struct bnxt *bp,
 			session->pci_info.domain = pci_addr->domain;
 			session->pci_info.bus = pci_addr->bus;
 			memcpy(session->dsn, bp->dsn, sizeof(session->dsn));
-			pthread_mutex_init(&session->bnxt_ulp_mutex, NULL);
+			rte_thread_mutex_init_shared(&session->bnxt_ulp_mutex);
 			STAILQ_INSERT_TAIL(&bnxt_ulp_session_list,
 					   session, next);
 		}
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
index bc347de202..6ca9d3309b 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
@@ -1469,7 +1469,7 @@ ulp_tf_init(struct bnxt *bp,
 		goto jump_to_error;
 	}
 
-	pthread_mutex_init(&bp->ulp_ctx->cfg_data->flow_db_lock, NULL);
+	rte_thread_mutex_init_shared(&bp->ulp_ctx->cfg_data->flow_db_lock);
 
 	/* Initialize ulp dparms with values devargs passed */
 	rc = ulp_tf_dparms_init(bp, bp->ulp_ctx);
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
index ad44ec93ca..fa98b2bca9 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
@@ -1038,7 +1038,7 @@ ulp_tfc_init(struct bnxt *bp,
 		goto jump_to_error;
 	}
 
-	pthread_mutex_init(&bp->ulp_ctx->cfg_data->flow_db_lock, NULL);
+	rte_thread_mutex_init_shared(&bp->ulp_ctx->cfg_data->flow_db_lock);
 
 	rc = ulp_tfc_dparms_init(bp, bp->ulp_ctx, ulp_dev_id);
 	if (rc) {
-- 
2.53.0

