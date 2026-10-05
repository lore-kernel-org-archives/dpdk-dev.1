Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA6ECA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 15:17:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45E5540BA0;
	Mon,  5 Oct 2026 17:17:33 +0200 (CEST)
Received: from mail-dl1-f98.google.com (mail-dl1-f98.google.com [74.125.82.98])
 by mails.dpdk.org (Postfix) with ESMTP id 46D6C40DD0
 for <dev@dpdk.org>; Mon,  5 Oct 2026 17:17:31 +0200 (CEST)
Received: by mail-dl1-f98.google.com with SMTP id
 a92af1059eb24-141395927feso7565c88.0
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791213450; x=1791818250;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=o8kTDhijd64Cl936hnUKlTY8Z5fZQYX57vCp//MzHCw=;
 b=Lg+t2W+f3Tfu6Y98gV9V4kFrf6jNEBNA2uhFg08QgxwSeti10YijhI1PKpSKJHJMzb
 FnN1j5eXj3ksUEt9MI80I5xRLNqmxFrMRCmpZXZOGeUlgJ2BlnQEmBm82jzq+Eb2oQxN
 2ludi22gL6j0qSmEFIOAgkq8IalnYtc1JLb0/7SZDecSf8PK7zxtxRJi4Rg2PX2fC8c+
 oaWa8Iw3zwzczzIbKUw/eQi69Nh2SQfR+YKSJF3Pv1EyWNyQY05axq2cFr75BrrMhisY
 wR9MnpCbO2/xMvQrndwte876YX02NT4hveWUclyOGo+dbuNGUyDhu9ZurkUcdjcbvjaS
 V7vQ==
X-Gm-Message-State: AFuF++mv2Du5PBMX4RTR/9sIK9CD54xYIf6UwlW8gQayo6lJdyufE0Xz
 ZnEP3jjhS1RS51hn7ypQXXOhukULVBmMdRdB1dY0Cn9TyppBiY5TLq7IxD6K2VVpoBm8OJKNbFe
 pSYJS2oZpeqFhOX4SHRgqVf94tDW7yFuF3gTZ5m9NuB35F2wIdGVSdsFeR26o+54flThz0iJZKq
 Bl38qE//J4hsD+2x1sBJKLw6qjw1MkCly7/8PgjncD430jiWdDhyjsVMNd1XDLr/kG9kCm8g==
X-Gm-Gg: AYBFou055sfpIqooRBZhaYwUKItQe/hjv+GkHW36xGxnshLeWS2xFffJPjVDArUPBiK
 Ce3Lfm0TDaZzlq7Ye9YwXrXhQIrTeEzOCPhvMEtfj+18gAiH0llExAeIfVj/2GJK7XMDNb6HNcI
 VgD9xKKmH1oz3iUX84DF48LDM+IJgxiiv0vjC7zDJDzmPhaKR776AsFOu3AJAq/HWGNgBhgZv8w
 ZLs5C6EB6Zp12xRvlG+OJa2zvNNOAeTBo5bb/DE++rqA2HSO5ooDavakVqUnw2kFd3j/lSAa0Qf
 JyhoAOC5cH+NBcF0DJRToj6UA+d/L/ju/9t6qOfUVsG3//55q+c64FL2Im8EfOAo14sciRVJXPQ
 PuWq+u+nIAGObS8nEJow/FbIQNXibX7SHuAfeRjP/bjYy1mUro5r/ywg5bMuHngVGGP5KYAwSbB
 PSf5rCIBOmV7AfUfuaLMGC8NxH60FsvwpAXCqfEg==
X-Received: by 2002:a05:701b:458e:20b0:151:ece6:b16d with SMTP id
 a92af1059eb24-151ecf60557mr9682076c88.23.1791213449795; 
 Mon, 05 Oct 2026 08:17:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 a92af1059eb24-151fc77d830sm52170c88.6.2026.10.05.08.17.29
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 08:17:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-535066512b0so42577371cf.0
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791213448; x=1791818248; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o8kTDhijd64Cl936hnUKlTY8Z5fZQYX57vCp//MzHCw=;
 b=QQoklxRRqyoDBfV1Wpry+t1rq05jU6G5GOx4q0+YGDJS2BoY0TcdKs5oMtrRgTnKAU
 ySDAZFwsHPzD8O26jQlUR4C7QUUf0VHTFeeVJ+zqVG0zR2qwIXDppggHWkiLijvEBWoQ
 7lJ+228KEcU21zbQf2CBFVrC3DJCkD+PJCROQ=
X-Received: by 2002:a05:622a:130b:b0:535:2447:3d02 with SMTP id
 d75a77b69052e-5352447413cmr76968021cf.33.1791213448164; 
 Mon, 05 Oct 2026 08:17:28 -0700 (PDT)
X-Received: by 2002:a05:622a:130b:b0:535:2447:3d02 with SMTP id
 d75a77b69052e-5352447413cmr76967241cf.33.1791213447467; 
 Mon, 05 Oct 2026 08:17:27 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53398aa33basm100126941cf.14.2026.10.05.08.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 08:17:26 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH] net/bnxt: fix TFC mem free use-after-free race
Date: Mon,  5 Oct 2026 10:17:24 -0500
Message-Id: <20261005151724.1706104-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

tfc_tbl_scope_mem_free() contains a race window: the
tfo_ts_get_mem_cfg() / tfo_ts_set_mem_cfg() pair allows concurrent
teardown paths to each observe a non-zero mem_cfg and both proceed
to call unlink_and_free() on the same backing-store memory, causing
a use-after-free.

Replace the get/set pair with tfo_ts_get_and_clear_mem_cfg(), which
atomically reads and zeros the slot under rte_spinlock in a single
operation. A concurrent caller receives num_lvl == 0 and skips the
free. Memory release happens outside the lock so the spinlock is
never held across blocking operations.

Fixes: 80317ff6adfd ("net/bnxt/tf_core: support Thor2")
Cc: stable@dpdk.org

Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c | 17 +++---
 drivers/net/bnxt/tf_core/v3/tfo.c           | 57 +++++++++++++++++++++
 drivers/net/bnxt/tf_core/v3/tfo.h           | 30 +++++++++++
 3 files changed, 95 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
index c06099af12..0a5dce43fa 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
@@ -1437,22 +1437,21 @@ int tfc_tbl_scope_mem_free(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 
 	for (region = 0; region < CFA_REGION_TYPE_MAX; region++) {
 		for (dir = 0; dir < CFA_DIR_MAX; dir++) {
-			lrc = tfo_ts_get_mem_cfg(tfcp->tfo, tsid, dir, region, &local,
-						 &mem_cfg);
+			lrc = tfo_ts_get_and_clear_mem_cfg(tfcp->tfo, tsid, dir, region,
+							    &local, &mem_cfg);
 			if (lrc) {
 				rc = lrc;
 				continue;
 			}
+			if (!mem_cfg.num_lvl) {
+				PMD_DRV_LOG_LINE(DEBUG,
+						 "tsid(%d) dir(%d) region(%d) already freed",
+						 tsid, dir, region);
+				continue;
+			}
 			/* memory only allocated on PF */
 			if (is_pf)
 				unlink_and_free(&mem_cfg, mem_cfg.pg_tbl[0].pg_size);
-
-			memset(&mem_cfg, 0, sizeof(mem_cfg));
-
-			/* memory freed, set local to false */
-			local = false;
-			(void)tfo_ts_set_mem_cfg(tfcp->tfo, tsid, dir, region, local,
-						 &mem_cfg);
 		}
 	}
 	if (rc) {
diff --git a/drivers/net/bnxt/tf_core/v3/tfo.c b/drivers/net/bnxt/tf_core/v3/tfo.c
index 681d1dd8d3..927b3a7640 100644
--- a/drivers/net/bnxt/tf_core/v3/tfo.c
+++ b/drivers/net/bnxt/tf_core/v3/tfo.c
@@ -36,6 +36,9 @@ struct tfc_global_object {
 	uint8_t gtsid;
 	struct tfc_tsid_db gtsid_db;
 	void *gts_tim;
+	rte_spinlock_t mem_cfg_lock; /**< serialises mem_cfg take/set across
+				       *  ports sharing this global scope
+				       */
 };
 
 struct tfc_global_object tfc_global;
@@ -58,6 +61,7 @@ struct tfc_object {
 	uint16_t sid; /**< Session ID */
 	bool is_pf; /**< port is a PF */
 	struct cfa_bld_mpcinfo mpc_info; /**< MPC ops handle */
+	rte_spinlock_t mem_cfg_lock; /**< serialises mem_cfg take/set */
 	struct tfc_tsid_db tsid_db[TFC_TBL_SCOPE_MAX]; /**< tsid database */
 	/** TIM instance pointer (PF) - this is where the 4 instances
 	 *  of the TPM (rx/tx_lkup, rx/tx_act) will be stored per shared
@@ -87,6 +91,7 @@ void tfo_open(void **tfo, bool is_pf)
 	tfco->is_pf = is_pf;
 	tfco->sid = INVALID_SID;
 	tfco->ts_tim = NULL;
+	rte_spinlock_init(&tfco->mem_cfg_lock);
 
 	/* Bind to the MPC builder */
 	rc = cfa_bld_mpc_bind(CFA_P70, &tfco->mpc_info);
@@ -408,6 +413,58 @@ int tfo_ts_get_mem_cfg(void *tfo, uint8_t ts_tsid, enum cfa_dir dir,
 	return rc;
 }
 
+/** Get and atomically clear the table scope memory configuration for this
+ *  direction
+ */
+int tfo_ts_get_and_clear_mem_cfg(void *tfo, uint8_t ts_tsid, enum cfa_dir dir,
+				  enum cfa_region_type region, bool *is_bs_owner,
+				  struct tfc_ts_mem_cfg *mem_cfg)
+{
+	struct tfc_ts_mem_cfg empty = { .num_lvl = 0 };
+	struct tfc_object *tfco = (struct tfc_object *)tfo;
+	struct tfc_global_object *tfgo;
+	struct tfc_tsid_db *tsid_db;
+	rte_spinlock_t *lock;
+	bool bs_owner;
+
+	if (tfo == NULL) {
+		PMD_DRV_LOG_LINE(ERR, "Invalid tfo pointer");
+		return -EINVAL;
+	}
+	if (tfco->signature != TFC_OBJ_SIGNATURE) {
+		PMD_DRV_LOG_LINE(ERR, "Invalid tfo object");
+		return -EINVAL;
+	}
+	if (mem_cfg == NULL) {
+		PMD_DRV_LOG_LINE(ERR, "Invalid mem_cfg pointer");
+		return -EINVAL;
+	}
+	if (ts_tsid >= TFC_TBL_SCOPE_MAX) {
+		PMD_DRV_LOG_LINE(ERR, "Invalid tsid %d", ts_tsid);
+		return -EINVAL;
+	}
+
+	tfgo = tfco->tfgo;
+	if (tfgo && tfgo->gtsid == ts_tsid) {
+		tsid_db = &tfgo->gtsid_db;
+		lock = &tfgo->mem_cfg_lock;
+	} else {
+		tsid_db = &tfco->tsid_db[ts_tsid];
+		lock = &tfco->mem_cfg_lock;
+	}
+
+	rte_spinlock_lock(lock);
+	*mem_cfg = tsid_db->ts_mem[region][dir];
+	tsid_db->ts_mem[region][dir] = empty;
+	bs_owner = tsid_db->ts_is_bs_owner;
+	rte_spinlock_unlock(lock);
+
+	if (is_bs_owner)
+		*is_bs_owner = bs_owner;
+
+	return 0;
+}
+
 /** Get the Pool Manager instance
  */
 int tfo_ts_get_cpm_inst(void *tfo, uint8_t ts_tsid, enum cfa_dir dir,
diff --git a/drivers/net/bnxt/tf_core/v3/tfo.h b/drivers/net/bnxt/tf_core/v3/tfo.h
index 93a6a5c064..a4c83a4ef4 100644
--- a/drivers/net/bnxt/tf_core/v3/tfo.h
+++ b/drivers/net/bnxt/tf_core/v3/tfo.h
@@ -268,6 +268,36 @@ int tfo_ts_get_mem_cfg(void *tfo, uint8_t ts_tsid, enum cfa_dir dir,
 		       enum cfa_region_type region, bool *is_bs_owner,
 		       struct tfc_ts_mem_cfg *mem_cfg);
 
+/**
+ * Get and atomically clear the table scope memory configuration.
+ *
+ * @param[in] tfo
+ *   Pointer to TFC object
+ *
+ * @param[in] ts_tsid
+ *   The table scope ID
+ *
+ * @param[in] dir
+ *   The direction (RX/TX)
+ *
+ * @param[in] region
+ *   The memory region type (lookup/action)
+ *
+ * @param[out] is_bs_owner
+ *   True if the caller is the owner of the backing store
+ *
+ * @param[out] mem_cfg
+ *   Receives the mem_cfg that was cleared from the database.
+ *   If a concurrent caller already claimed the slot,
+ *   mem_cfg->num_lvl will be 0 and the caller must skip the free.
+ *
+ * @return
+ *   0 for SUCCESS, negative error value for FAILURE (errno.h)
+ */
+int tfo_ts_get_and_clear_mem_cfg(void *tfo, uint8_t ts_tsid, enum cfa_dir dir,
+				  enum cfa_region_type region, bool *is_bs_owner,
+				  struct tfc_ts_mem_cfg *mem_cfg);
+
 /**
  * Set the pool memory configuration for this direction.
  *
-- 
2.31.1

