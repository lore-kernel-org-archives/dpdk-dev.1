Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D63DC982EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 02:21:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04ECA410D5;
	Mon, 21 Sep 2026 04:21:27 +0200 (CEST)
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com
 [209.85.210.100])
 by mails.dpdk.org (Postfix) with ESMTP id D2F32402A4
 for <dev@dpdk.org>; Mon, 21 Sep 2026 04:21:23 +0200 (CEST)
Received: by mail-ot1-f100.google.com with SMTP id
 46e09a7af769-805453b1c0cso898885a34.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789957283; x=1790562083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tYzKcqBaqGB8rZbfjodyRFEF5AVV5rVV/0c7MdeChCw=;
 b=mWFqNw+gMa6II4azqOGvA/W5Kg+SDH/gpUABc74EdmGmgFvoTvVIyOiotfJQ/pIRoo
 1G6NmLujO2+c8dOQtXrHoM60F98SmfuwXAd1agiq1xWEpIVJR4rsxhz5uZA9DV03RaHc
 BiIcxFbxCqGbgXDmUcbOuOmjb0hFHq/bv5N0tBz7AgOWRGIVfISl25fSvK7XrN2Wh5MC
 pZomE1sN1s1DHOajGyepo/gtCi7fpXI3FZ5TX4hMZWlR1Fc0PJKOJSJ1FCZYqknLC/As
 wqhygviU+3BhKA6N0x2cBE8+D+nlDqkr+EQPPVX+VUT4tAjM699AnEwsf/p0TKAft3M5
 UOUg==
X-Gm-Message-State: AFuF++ku5g4jsjN7/wFgAq4GpyuY1ScFKK3piDiVVLT7XkGfTeTupywG
 jKNFONnSlur3DMd07+sWeCQmmSlqrnqkoiC/k2eTi1WYkeQb/2qmKqcjKrCJ3TfRkKfp45vkBcI
 CTBbdPn+jw1LlS6Mp7l6qC4zcFQV3bM2aK0+CuVx5Z55Zx45ON0Db9wJppPUWznt7PNfh0mBvWF
 yDO1ZOdHYYyZa3F9j4re0b4C2+tjhvPoTcSNgYDine80f3tr4Zym4M8xoNPoP3+4U1RQdwuG9GV
 +e46cNp9xPD
X-Gm-Gg: AYBFou2rXe5h+qlPBDhWosjzsytSLoO5BcnsItSARF7W//Xqcxh6PGPGZsTDw4tG2I/
 WZQ99x7L3tHA58nZtDhrkjFvSlDUqsP3Zd7dDMgWMHif1OJpV5anvlFBj5KYd8r66g2EJhCF6l4
 xKy7KSBtw9Ybpe3Gr0LqkYq4CTw1+p45PtNCaWCIQYSjNJ1/02+8gV1PIhgK+vdqWo9pL6W7Vyd
 BDWKD8i/JCDIcE4bZmWIbwRvNsHsyRAtjbBABfWhkSdA4aE8+0NVJgQdKyjA0RLkqoDyd78dTiu
 PdY0RbDELnnEDu3v16tNCLONsQUtk0Wj0qPkDjGowWMhWHv4yzYKhQmFtQpi0Pb5Xe4H0fqSzeV
 SrmibUIJsppu1kmuELLc7LAOdHGJrN5NRLDT+cTJvYEZUX8tDGHI4oGgIwF5FZGEq2F2t4/yfN6
 zaXg4DEczuQ5At37B6+mShe058ToNMlhRkEMnGBwE+RcG3+jyUwg==
X-Received: by 2002:a05:6820:198e:b0:6ba:3635:8017 with SMTP id
 006d021491bc7-6ca9dc82069mr7998462eaf.66.1789957282842; 
 Sun, 20 Sep 2026 19:21:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 46e09a7af769-8107dd8c125sm3639898a34.7.2026.09.20.19.21.22
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 19:21:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc4b524ce78so1763889a12.2
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789957281; x=1790562081; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tYzKcqBaqGB8rZbfjodyRFEF5AVV5rVV/0c7MdeChCw=;
 b=Kb+cMEiedLDQSEQM14SH+thzoGMfGb+Qzm2/IEluGxVKh6CuCzHLFVvcqmYz/4ykko
 KKQZGGd5fzavXPjSyinh/3m/3dUfFfJCw3Fb8qAXBHIAtmhTzRQKu0LoCIYoULggK/2b
 hgRO95ce9fSqdtBLue2ApmKua6GoqH2Oqclu8=
X-Received: by 2002:a05:6a20:9f8a:b0:3dd:a009:3180 with SMTP id
 adf61e73a8af0-3dda009320bmr9541764637.40.1789957280873; 
 Sun, 20 Sep 2026 19:21:20 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f8a:b0:3dd:a009:3180 with SMTP id
 adf61e73a8af0-3dda009320bmr9541738637.40.1789957280284; 
 Sun, 20 Sep 2026 19:21:20 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d53968afsm16587294c88.0.2026.09.20.19.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 19:21:19 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Keegan Freyhof <keegan.freyhof@broadcom.com>,
 Mohammad Shuab Siddique <shuab.siddique@broadcom.com>
Subject: [PATCH v2 3/5] net/bnxt: harden sprintf bounds for device memory names
Date: Sun, 20 Sep 2026 20:24:18 -0600
Message-ID: <20260921022420.1034071-4-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921022420.1034071-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032752.763408-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921022420.1034071-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Keegan Freyhof <keegan.freyhof@broadcom.com>

sprintf() into fixed-size stack buffers such as
char type[RTE_MEMZONE_NAMESIZE] does not bound the write to the
buffer, so a long enough formatted string (e.g. from PCI address
fields) overflows it.

Add check_snprintf_rc(), a helper that logs and returns an error on a
failed snprintf() call and logs (without failing) a truncated one.
Convert sprintf() calls building a memzone/malloc name to snprintf()
plus this check, and add the same check to the existing snprintf()
calls building HWRM CFA pair_name request fields. Unlike a truncated
memzone/malloc label, a truncated pair_name would be sent to firmware
and could match the wrong pair or none at all, so
bnxt_hwrm_cfa_pair_exists()/_alloc()/_free() additionally reject a
truncated pair_name outright instead of proceeding.

Three bugs introduced by this change and fixed here: in
bnxt_hwrm_ver_get(), free bp->hwrm_short_cmd_req_addr (and null it)
before checking the new snprintf's return, instead of after, so an
early return on a snprintf failure doesn't leak the previous
allocation; also clear BNXT_FLAG_SHORT_CMD on that same early return,
since it may already have been set a few lines above and would
otherwise claim short-command support with no buffer allocated. In
bnxt_hwrm_cfa_pair_exists()/_alloc()/_free(), the new early-return
paths exited without releasing bp->hwrm_lock (held since the
preceding HWRM_PREP()), which would deadlock every later HWRM call;
added the missing HWRM_UNLOCK() before each return.

Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <shuab.siddique@broadcom.com>

---
v2:
* Fixed three bugs the v1 diff itself introduced, found in a second
  review pass: in bnxt_hwrm_ver_get(), free/null
  bp->hwrm_short_cmd_req_addr and clear BNXT_FLAG_SHORT_CMD before
  (not after) checking the new snprintf's return, so an early return
  on failure doesn't leak the previous allocation or leave the flag
  claiming short-command support with no buffer behind it; in
  bnxt_hwrm_cfa_pair_exists()/_alloc()/_free(), added the missing
  HWRM_UNLOCK() on the new early-return paths, which previously
  exited holding bp->hwrm_lock and would deadlock every later HWRM
  call.
---
 drivers/net/bnxt/bnxt.h        | 15 +++++++
 drivers/net/bnxt/bnxt_ethdev.c | 24 ++++++++----
 drivers/net/bnxt/bnxt_hwrm.c   | 72 +++++++++++++++++++++++++---------
 drivers/net/bnxt/bnxt_stats.c  | 10 +++--
 4 files changed, 93 insertions(+), 28 deletions(-)

diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index 69455af31f9..ad0d5fe5dba 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -1288,6 +1288,21 @@ extern int bnxt_logtype_driver;
 						       BNXT_LINK_SPEEDS_V2_VF((bp))))
 #define BNXT_MAX_SPEED_LANES 8
 #define BNXT_SUPPORTS_TPA(bp)  (!BNXT_CHIP_P5_P7(bp) || (bp)->max_tpa_v2)
+
+static inline int
+check_snprintf_rc(int rc, size_t max_size, const char *ctx)
+{
+	if (rc < 0) {
+		PMD_DRV_LOG_LINE(ERR, "Error when creating string for %s", ctx);
+		return rc;
+	}
+
+	if (rc >= (int)max_size)
+		PMD_DRV_LOG_LINE(INFO, "String truncated when creating string for %s", ctx);
+
+	return 0;
+}
+
 extern const struct rte_flow_ops bnxt_ulp_rte_flow_ops;
 int32_t bnxt_ulp_port_init(struct bnxt *bp);
 void bnxt_ulp_port_deinit(struct bnxt *bp);
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index eefd99464e9..7b9d1c862d8 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -647,13 +647,15 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *bp)
 {
 	struct rte_pci_device *pdev = bp->pdev;
 	char type[RTE_MEMZONE_NAMESIZE];
+	int rc = 0, snp_rc = 0;
 	uint16_t max_fc;
-	int rc = 0;
 
 	max_fc = bp->flow_stat->max_fc;
 
-	sprintf(type, "bnxt_rx_fc_in_" PCI_PRI_FMT, pdev->addr.domain,
+	snp_rc = snprintf(type, sizeof(type), "bnxt_rx_fc_in_" PCI_PRI_FMT, pdev->addr.domain,
 		pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
+	if (check_snprintf_rc(snp_rc, sizeof(type), "bnxt_rx_fc_in_") < 0)
+		return snp_rc;
 	/* 4 bytes for each counter-id */
 	rc = bnxt_alloc_ctx_mem_buf(bp, type,
 				    max_fc * 4,
@@ -661,8 +663,10 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *bp)
 	if (rc)
 		return rc;
 
-	sprintf(type, "bnxt_rx_fc_out_" PCI_PRI_FMT, pdev->addr.domain,
+	snp_rc = snprintf(type, sizeof(type), "bnxt_rx_fc_out_" PCI_PRI_FMT, pdev->addr.domain,
 		pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
+	if (check_snprintf_rc(snp_rc, sizeof(type), "bnxt_rx_fc_out_") < 0)
+		return snp_rc;
 	/* 16 bytes for each counter - 8 bytes pkt_count, 8 bytes byte_count */
 	rc = bnxt_alloc_ctx_mem_buf(bp, type,
 				    max_fc * 16,
@@ -670,8 +674,10 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *bp)
 	if (rc)
 		return rc;
 
-	sprintf(type, "bnxt_tx_fc_in_" PCI_PRI_FMT, pdev->addr.domain,
+	snp_rc = snprintf(type, sizeof(type), "bnxt_tx_fc_in_" PCI_PRI_FMT, pdev->addr.domain,
 		pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
+	if (check_snprintf_rc(snp_rc, sizeof(type), "bnxt_tx_fc_in_") < 0)
+		return snp_rc;
 	/* 4 bytes for each counter-id */
 	rc = bnxt_alloc_ctx_mem_buf(bp, type,
 				    max_fc * 4,
@@ -679,8 +685,10 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *bp)
 	if (rc)
 		return rc;
 
-	sprintf(type, "bnxt_tx_fc_out_" PCI_PRI_FMT, pdev->addr.domain,
+	snp_rc = snprintf(type, sizeof(type), "bnxt_tx_fc_out_" PCI_PRI_FMT, pdev->addr.domain,
 		pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
+	if (check_snprintf_rc(snp_rc, sizeof(type), "bnxt_tx_fc_out_") < 0)
+		return snp_rc;
 	/* 16 bytes for each counter - 8 bytes pkt_count, 8 bytes byte_count */
 	rc = bnxt_alloc_ctx_mem_buf(bp, type,
 				    max_fc * 16,
@@ -5226,8 +5234,8 @@ int bnxt_alloc_ctx_pg_tbls(struct bnxt *bp)
 {
 	struct bnxt_ctx_mem_info *ctx = bp->ctx;
 	struct bnxt_ctx_mem *ctx2;
+	int rc = 0, snp_rc = 0;
 	uint16_t type;
-	int rc = 0;
 
 	ctx2 = &ctx->ctx_arr[0];
 	for (type = 0; type < ctx->types && rc == 0; type++) {
@@ -5248,7 +5256,9 @@ int bnxt_alloc_ctx_pg_tbls(struct bnxt *bp)
 		for (i = 0; i < w && rc == 0; i++) {
 			char name[RTE_MEMZONE_NAMESIZE] = {0};
 
-			sprintf(name, "_%d_%d", i, type);
+			snp_rc = snprintf(name, sizeof(name), "_%d_%d", i, type);
+			if (check_snprintf_rc(snp_rc, sizeof(name), "index and type.") < 0)
+				return snp_rc;
 
 			if (ctxm->entry_multiple)
 				entries = bnxt_roundup(ctxm->max_entries,
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 4e50ff7e1e0..7719084a6d3 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -1591,12 +1591,12 @@ int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp)
 
 int bnxt_hwrm_ver_get(struct bnxt *bp, uint32_t timeout)
 {
-	int rc = 0;
 	struct hwrm_ver_get_input req = {.req_type = 0 };
 	struct hwrm_ver_get_output *resp = bp->hwrm_cmd_resp_addr;
 	uint32_t fw_version;
 	uint16_t max_resp_len;
 	char type[RTE_MEMZONE_NAMESIZE];
+	int rc = 0, snp_rc = 0;
 	uint32_t dev_caps_cfg;
 
 	bp->max_req_len = HWRM_MAX_REQ_LEN;
@@ -1677,11 +1677,16 @@ int bnxt_hwrm_ver_get(struct bnxt *bp, uint32_t timeout)
 	     (dev_caps_cfg &
 	      HWRM_VER_GET_OUTPUT_DEV_CAPS_CFG_SHORT_CMD_REQUIRED)) ||
 	    bp->hwrm_max_ext_req_len > HWRM_MAX_REQ_LEN) {
-		sprintf(type, "bnxt_hwrm_short_" PCI_PRI_FMT,
-			bp->pdev->addr.domain, bp->pdev->addr.bus,
-			bp->pdev->addr.devid, bp->pdev->addr.function);
-
+		snp_rc = snprintf(type, sizeof(type), "bnxt_hwrm_short_" PCI_PRI_FMT,
+				  bp->pdev->addr.domain, bp->pdev->addr.bus,
+				  bp->pdev->addr.devid, bp->pdev->addr.function);
 		rte_free(bp->hwrm_short_cmd_req_addr);
+		bp->hwrm_short_cmd_req_addr = NULL;
+		if (check_snprintf_rc(snp_rc, sizeof(type), "bnxt_hwrm_short_") < 0) {
+			bp->flags &= ~BNXT_FLAG_SHORT_CMD;
+			rc = snp_rc;
+			goto error;
+		}
 
 		bp->hwrm_short_cmd_req_addr =
 				rte_malloc(type, bp->hwrm_max_ext_req_len, 0);
@@ -3526,9 +3531,12 @@ int bnxt_alloc_hwrm_resources(struct bnxt *bp)
 {
 	struct rte_pci_device *pdev = bp->pdev;
 	char type[RTE_MEMZONE_NAMESIZE];
+	int snp_rc = 0;
 
-	sprintf(type, "bnxt_hwrm_" PCI_PRI_FMT, pdev->addr.domain,
-		pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
+	snp_rc = snprintf(type, sizeof(type), "bnxt_hwrm_" PCI_PRI_FMT, pdev->addr.domain,
+			  pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
+	if (check_snprintf_rc(snp_rc, sizeof(type), "bnxt_hwrm_") < 0)
+		return snp_rc;
 	bp->max_resp_len = BNXT_PAGE_SIZE;
 	bp->hwrm_cmd_resp_addr = rte_malloc(type, bp->max_resp_len, 0);
 	if (bp->hwrm_cmd_resp_addr == NULL)
@@ -6769,6 +6777,7 @@ static int bnxt_alloc_all_ctx_pg_info(struct bnxt *bp)
 {
 	struct bnxt_ctx_mem_info *ctx = bp->ctx;
 	char name[RTE_MEMZONE_NAMESIZE];
+	int snp_rc = 0;
 	uint16_t type;
 
 	for (type = 0; type < ctx->types; type++) {
@@ -6781,8 +6790,10 @@ static int bnxt_alloc_all_ctx_pg_info(struct bnxt *bp)
 		if (ctxm->instance_bmap)
 			n = bnxt_hweight32(ctxm->instance_bmap);
 
-		sprintf(name, "bnxt_ctx_pgmem_%d_%d",
-			bp->eth_dev->data->port_id, type);
+		snp_rc = snprintf(name, sizeof(name), "bnxt_ctx_pgmem_%d_%d",
+				  bp->eth_dev->data->port_id, type);
+		if (check_snprintf_rc(snp_rc, sizeof(name), "bnxt_ctx_pgmem_") < 0)
+			return snp_rc;
 		ctxm->pg_info = rte_malloc(name, sizeof(*ctxm->pg_info) * n,
 					   RTE_CACHE_LINE_SIZE);
 		if (!ctxm->pg_info)
@@ -7740,7 +7751,7 @@ int bnxt_hwrm_cfa_pair_exists(struct bnxt *bp, struct bnxt_representor *rep_bp)
 {
 	struct hwrm_cfa_pair_info_output *resp = bp->hwrm_cmd_resp_addr;
 	struct hwrm_cfa_pair_info_input req = {0};
-	int rc = 0;
+	int rc = 0, snp_rc = 0;
 
 	if (!(BNXT_PF(bp) || BNXT_VF_IS_TRUSTED(bp))) {
 		PMD_DRV_LOG_LINE(DEBUG,
@@ -7749,8 +7760,16 @@ int bnxt_hwrm_cfa_pair_exists(struct bnxt *bp, struct bnxt_representor *rep_bp)
 	}
 
 	HWRM_PREP(&req, HWRM_CFA_PAIR_INFO, BNXT_USE_CHIMP_MB);
-	snprintf(req.pair_name, sizeof(req.pair_name), "%svfr%d",
-		 bp->eth_dev->data->name, rep_bp->vf_id);
+	snp_rc = snprintf(req.pair_name, sizeof(req.pair_name), "%svfr%d",
+			  bp->eth_dev->data->name, rep_bp->vf_id);
+	if (check_snprintf_rc(snp_rc, sizeof(req.pair_name), "svfr") < 0) {
+		HWRM_UNLOCK();
+		return snp_rc;
+	}
+	if (snp_rc >= (int)sizeof(req.pair_name)) {
+		HWRM_UNLOCK();
+		return -EINVAL;
+	}
 	req.flags =
 		rte_cpu_to_le_32(HWRM_CFA_PAIR_INFO_INPUT_FLAGS_LOOKUP_TYPE);
 
@@ -7768,7 +7787,7 @@ int bnxt_hwrm_cfa_pair_alloc(struct bnxt *bp, struct bnxt_representor *rep_bp)
 {
 	struct hwrm_cfa_pair_alloc_output *resp = bp->hwrm_cmd_resp_addr;
 	struct hwrm_cfa_pair_alloc_input req = {0};
-	int rc;
+	int rc, snp_rc = 0;
 
 	if (!(BNXT_PF(bp) || BNXT_VF_IS_TRUSTED(bp))) {
 		PMD_DRV_LOG_LINE(DEBUG,
@@ -7778,8 +7797,16 @@ int bnxt_hwrm_cfa_pair_alloc(struct bnxt *bp, struct bnxt_representor *rep_bp)
 
 	HWRM_PREP(&req, HWRM_CFA_PAIR_ALLOC, BNXT_USE_CHIMP_MB);
 	req.pair_mode = HWRM_CFA_PAIR_FREE_INPUT_PAIR_MODE_REP2FN_TRUFLOW;
-	snprintf(req.pair_name, sizeof(req.pair_name), "%svfr%d",
-		 bp->eth_dev->data->name, rep_bp->vf_id);
+	snp_rc = snprintf(req.pair_name, sizeof(req.pair_name), "%svfr%d",
+			  bp->eth_dev->data->name, rep_bp->vf_id);
+	if (check_snprintf_rc(snp_rc, sizeof(req.pair_name), "svfr") < 0) {
+		HWRM_UNLOCK();
+		return snp_rc;
+	}
+	if (snp_rc >= (int)sizeof(req.pair_name)) {
+		HWRM_UNLOCK();
+		return -EINVAL;
+	}
 
 	req.pf_b_id = rep_bp->parent_pf_idx;
 	req.vf_b_id = BNXT_REP_PF(rep_bp) ? rte_cpu_to_le_16(((uint16_t)-1)) :
@@ -7814,7 +7841,7 @@ int bnxt_hwrm_cfa_pair_free(struct bnxt *bp, struct bnxt_representor *rep_bp)
 {
 	struct hwrm_cfa_pair_free_output *resp = bp->hwrm_cmd_resp_addr;
 	struct hwrm_cfa_pair_free_input req = {0};
-	int rc;
+	int rc, snp_rc = 0;
 
 	if (!(BNXT_PF(bp) || BNXT_VF_IS_TRUSTED(bp))) {
 		PMD_DRV_LOG_LINE(DEBUG,
@@ -7823,8 +7850,17 @@ int bnxt_hwrm_cfa_pair_free(struct bnxt *bp, struct bnxt_representor *rep_bp)
 	}
 
 	HWRM_PREP(&req, HWRM_CFA_PAIR_FREE, BNXT_USE_CHIMP_MB);
-	snprintf(req.pair_name, sizeof(req.pair_name), "%svfr%d",
-		 bp->eth_dev->data->name, rep_bp->vf_id);
+	snp_rc = snprintf(req.pair_name, sizeof(req.pair_name), "%svfr%d",
+			  bp->eth_dev->data->name, rep_bp->vf_id);
+	if (check_snprintf_rc(snp_rc, sizeof(req.pair_name), "svfr") < 0) {
+		HWRM_UNLOCK();
+		return snp_rc;
+	}
+	if (snp_rc >= (int)sizeof(req.pair_name)) {
+		HWRM_UNLOCK();
+		return -EINVAL;
+	}
+
 	req.pf_b_id = rep_bp->parent_pf_idx;
 	req.pair_mode = HWRM_CFA_PAIR_FREE_INPUT_PAIR_MODE_REP2FN_TRUFLOW;
 	req.vf_id = BNXT_REP_PF(rep_bp) ? rte_cpu_to_le_16(((uint16_t)-1)) :
diff --git a/drivers/net/bnxt/bnxt_stats.c b/drivers/net/bnxt/bnxt_stats.c
index c4efcb4b179..19153f96ae6 100644
--- a/drivers/net/bnxt/bnxt_stats.c
+++ b/drivers/net/bnxt/bnxt_stats.c
@@ -1108,7 +1108,7 @@ int bnxt_dev_xstats_get_names_op(struct rte_eth_dev *eth_dev,
 	struct bnxt *bp = (struct bnxt *)eth_dev->data->dev_private;
 	unsigned int stat_cnt;
 	unsigned int i, count = 0, sz;
-	int rc;
+	int rc, snp_rc = 0;
 
 	rc = is_bnxt_in_error(bp);
 	if (rc)
@@ -1183,12 +1183,16 @@ int bnxt_dev_xstats_get_names_op(struct rte_eth_dev *eth_dev,
 		for (i = 0; i < bp->max_l2_ctx; i++) {
 			char buf[RTE_ETH_XSTATS_NAME_SIZE];
 
-			sprintf(buf, "flow_%d_bytes", i);
+			snp_rc = snprintf(buf, sizeof(buf), "flow_%d_bytes", i);
+			if (check_snprintf_rc(snp_rc, sizeof(buf), "flow_%d_bytes") < 0)
+				return snp_rc;
 			strlcpy(xstats_names[count].name, buf,
 				sizeof(xstats_names[count].name));
 			count++;
 
-			sprintf(buf, "flow_%d_packets", i);
+			snp_rc = snprintf(buf, sizeof(buf), "flow_%d_packets", i);
+			if (check_snprintf_rc(snp_rc, sizeof(buf), "flow_%d_packets") < 0)
+				return snp_rc;
 			strlcpy(xstats_names[count].name, buf,
 				sizeof(xstats_names[count].name));
 
-- 
2.47.3

