Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32D7CA5FAB
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90976410EE;
	Tue, 29 Sep 2026 02:21:54 +0200 (CEST)
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com
 [209.85.210.227])
 by mails.dpdk.org (Postfix) with ESMTP id 73185410ED
 for <dev@dpdk.org>; Tue, 29 Sep 2026 02:21:49 +0200 (CEST)
Received: by mail-pf1-f227.google.com with SMTP id
 d2e1a72fcca58-86a686c0fdaso862245b3a.2
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641308; x=1791246108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8f4PeSM7hNBjDtlsClAV9dc7GtDXtBGQSGtduUju0o4=;
 b=uzz8M0WbjYqzzsGLn5zE13sfQNqm2wuYk7ki7GgeqDJI6Q15QJvKrtQo9y4wvdURbL
 zKrnLL7qmKagGKreqg6J2iOQrkjmELRSBdMB13gXskcMuf6FH/qz6yk2fzd027Nx8og2
 TZWyKnu2I3UDO3hmb5T4FT5E0j4g39BlDrtfTZylypQBNwsFkoqOxy0xzSI9xcdcm9rQ
 vAvGzJGy8IQl+vLkVxyuOG6+jdE8vWFppgjFEWn6gWw9ZGkZk6FyujL51DTNorE+/Np9
 wn5NokTg940U44pzhiindRqVaO6d8U96X8vSEzVID8ovt1SH3VlONFs7gc4toKINosZm
 sHAA==
X-Gm-Message-State: AFuF++mmS6flUeAlpXBJI0oV+k7QfofSUNefpHtK8oHn/qE5W2DB4cx0
 voA19/T5ozTij+jQ5Pm97/KwvxlGzfw+mZX/TgcyK7+jPljUEb7Jn8GIZ+5dboiQLwTuHbLtZ/W
 UwYCD8DdIqp7gAdVyYaYKnDUt8eb1EjxtMAC2uarEDLQdrDDp28fQM8rBxYcyovAb8+GERDmJru
 IKCVKf85TjPu9uy6Z1G1QqYL0bO2qv6OsQyxVO4/o2vl9zfVrt2Aq55BN3ghJaKXyCtb1CRaKRL
 pgh2vQ+lpEi
X-Gm-Gg: AYBFou1Ms2D0MkIVLuexmO9AvHAaPdYL6V823Vj9SLRoQbyydPzadpFhlB82QMaMhJM
 cxupdz/Gh830z7x0tzYY+dOGSf+/3CrtAeBDl3fvHJSsmoqzOplqpa/PPOrkQd9fmJ9gssISKMx
 QV4toliRcHJW8dvX8XKYGMzrQ/h6+aAAGrV81Mu42Z2p1l7QwFcqRFYm/ALtPxwzlthqkM0s8eV
 UgcVcUNV6aaN6yWvf3FK5/yvKe+CJ7Pig+6C1JF7qQDUpGtZ0vyWQcaJYZY5TAPNPmXQEMZtcuZ
 NcT5RCs+v+MR2qd2FexgVOzkxjziOzhfj6pp74y9nTIL3HP8Y1HQBK5bvqfcDlK5hqSPXmoXr4x
 RnsfB7EwOKld5JuM5cAK7pIwEjZKuwZIZO0A7vWLkKo5/5+jE3bQzwFGnCYcVi+H6gFmXwGQRGT
 vWaFskS3xCl3lAZCQzgs6CwSV+RvtSjNnXm9hyol3EjCUuN5WGjg==
X-Received: by 2002:a05:6a00:4c94:b0:881:e626:74a0 with SMTP id
 d2e1a72fcca58-881e62689dcmr4899872b3a.47.1790641308433; 
 Mon, 28 Sep 2026 17:21:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 d2e1a72fcca58-880d6025c93sm5093345b3a.8.2026.09.28.17.21.48
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2026 17:21:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-936708f129aso724961785a.0
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790641307; x=1791246107; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8f4PeSM7hNBjDtlsClAV9dc7GtDXtBGQSGtduUju0o4=;
 b=H5uDmPIXkeDzX1+ZCfbzRItQRnuOBor/4/03q7FNZVOEbJAjHG3d2t/ehhH3N8upWl
 eCbNPSpUbv/tqrxdfnKa3mFcErz/984AyMWwNBjM+wdxBtNKnXoQPvhm3lZXOIdl962V
 OLDCg7Yn6tIoK4niyLPkb92F4+/QPWLlCWmtw=
X-Received: by 2002:a05:620a:1b9c:b0:939:6de6:5487 with SMTP id
 af79cd13be357-93c43dcce3amr2351537485a.44.1790641307078; 
 Mon, 28 Sep 2026 17:21:47 -0700 (PDT)
X-Received: by 2002:a05:620a:1b9c:b0:939:6de6:5487 with SMTP id
 af79cd13be357-93c43dcce3amr2351534585a.44.1790641306433; 
 Mon, 28 Sep 2026 17:21:46 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91430e0f78csm91234246d6.32.2026.09.28.17.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:21:45 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Keegan Freyhof <keegan.freyhof@broadcom.com>, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v3 3/5] net/bnxt: harden sprintf bounds for device memory names
Date: Mon, 28 Sep 2026 18:24:40 -0600
Message-ID: <20260929002442.1208481-4-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929002442.1208481-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032752.763408-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260929002442.1208481-1-Mohammad-Shuab.Siddique@broadcom.com>
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
buffer. bnxt_hwrm_ver_get()'s "bnxt_hwrm_short_" PCI_PRI_FMT label
overflows a 32-byte RTE_MEMZONE_NAMESIZE buffer once the PCI domain
needs more than 4 hex digits: rte_pci_addr.domain is a uint32_t, and
PCI_PRI_FMT's %.4x is a minimum width, not a maximum, so an 8-digit
domain plus the 16-character prefix plus the rest of the PCI address
string plus the terminating NUL is 33 bytes into 32.

Convert this and the other sprintf() calls building memzone/malloc
names and HWRM CFA pair_name request fields to snprintf(), which
bounds the write and truncates instead of overflowing. The return
value is not checked: none of these format strings involve locale or
multibyte conversion, so a negative return is not reachable, and a
truncated debug label or pair_name is not itself a memory-safety
concern -- a truncated pair_name simply fails to match at the
firmware side, handled the same way as any other not-found pair.

Also write the per-flow xstat names directly into
xstats_names[count].name via snprintf() instead of through an
intermediate buf plus strlcpy(), since the destination is already
exactly sized for that format string.

Fixes: 79cc1efd99c6 ("net/bnxt: support extended HWRM request sizes")
Cc: stable@dpdk.org

Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
v3:
* Dropped check_snprintf_rc() and the early-return paths on the CFA
  pair_name sites entirely -- Stephen Hemminger noted the rc < 0
  branch is unreachable and plain snprintf() is enough for the PCI
  domain overflow this patch actually targets. All ten snprintf()
  sites now behave the same way: bounded, unchecked, truncate on
  overflow. This also removes the three bugs (a leak, a stale flag,
  and missing HWRM_UNLOCK()s) v2's early-return paths had introduced
  and fixed, since there is no early-return path left to have them.

 drivers/net/bnxt/bnxt.h        |  1 +
 drivers/net/bnxt/bnxt_ethdev.c | 14 +++++++-------
 drivers/net/bnxt/bnxt_hwrm.c   | 10 +++++-----
 drivers/net/bnxt/bnxt_stats.c  | 15 ++++++---------
 4 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index 336de75da0..f3edfb9530 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -1285,6 +1285,7 @@ extern int bnxt_logtype_driver;
 						       BNXT_LINK_SPEEDS_V2_VF((bp))))
 #define BNXT_MAX_SPEED_LANES 8
 #define BNXT_SUPPORTS_TPA(bp)  (!BNXT_CHIP_P5_P7(bp) || (bp)->max_tpa_v2)
+
 extern const struct rte_flow_ops bnxt_ulp_rte_flow_ops;
 int32_t bnxt_ulp_port_init(struct bnxt *bp);
 void bnxt_ulp_port_deinit(struct bnxt *bp);
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 4d4349457c..11e8f7908d 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -647,12 +647,12 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *bp)
 {
 	struct rte_pci_device *pdev = bp->pdev;
 	char type[RTE_MEMZONE_NAMESIZE];
-	uint16_t max_fc;
 	int rc = 0;
+	uint16_t max_fc;
 
 	max_fc = bp->flow_stat->max_fc;
 
-	sprintf(type, "bnxt_rx_fc_in_" PCI_PRI_FMT, pdev->addr.domain,
+	snprintf(type, sizeof(type), "bnxt_rx_fc_in_" PCI_PRI_FMT, pdev->addr.domain,
 		pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
 	/* 4 bytes for each counter-id */
 	rc = bnxt_alloc_ctx_mem_buf(bp, type,
@@ -661,7 +661,7 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *bp)
 	if (rc)
 		return rc;
 
-	sprintf(type, "bnxt_rx_fc_out_" PCI_PRI_FMT, pdev->addr.domain,
+	snprintf(type, sizeof(type), "bnxt_rx_fc_out_" PCI_PRI_FMT, pdev->addr.domain,
 		pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
 	/* 16 bytes for each counter - 8 bytes pkt_count, 8 bytes byte_count */
 	rc = bnxt_alloc_ctx_mem_buf(bp, type,
@@ -670,7 +670,7 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *bp)
 	if (rc)
 		return rc;
 
-	sprintf(type, "bnxt_tx_fc_in_" PCI_PRI_FMT, pdev->addr.domain,
+	snprintf(type, sizeof(type), "bnxt_tx_fc_in_" PCI_PRI_FMT, pdev->addr.domain,
 		pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
 	/* 4 bytes for each counter-id */
 	rc = bnxt_alloc_ctx_mem_buf(bp, type,
@@ -679,7 +679,7 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *bp)
 	if (rc)
 		return rc;
 
-	sprintf(type, "bnxt_tx_fc_out_" PCI_PRI_FMT, pdev->addr.domain,
+	snprintf(type, sizeof(type), "bnxt_tx_fc_out_" PCI_PRI_FMT, pdev->addr.domain,
 		pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
 	/* 16 bytes for each counter - 8 bytes pkt_count, 8 bytes byte_count */
 	rc = bnxt_alloc_ctx_mem_buf(bp, type,
@@ -5232,8 +5232,8 @@ int bnxt_alloc_ctx_pg_tbls(struct bnxt *bp)
 {
 	struct bnxt_ctx_mem_info *ctx = bp->ctx;
 	struct bnxt_ctx_mem *ctx2;
-	uint16_t type;
 	int rc = 0;
+	uint16_t type;
 
 	ctx2 = &ctx->ctx_arr[0];
 	for (type = 0; type < ctx->types && rc == 0; type++) {
@@ -5254,7 +5254,7 @@ int bnxt_alloc_ctx_pg_tbls(struct bnxt *bp)
 		for (i = 0; i < w && rc == 0; i++) {
 			char name[RTE_MEMZONE_NAMESIZE] = {0};
 
-			sprintf(name, "_%d_%d", i, type);
+			snprintf(name, sizeof(name), "_%d_%d", i, type);
 
 			if (ctxm->entry_multiple)
 				entries = bnxt_roundup(ctxm->max_entries,
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 1615b36aae..361402b36f 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -1583,12 +1583,12 @@ int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp)
 
 int bnxt_hwrm_ver_get(struct bnxt *bp, uint32_t timeout)
 {
-	int rc = 0;
 	struct hwrm_ver_get_input req = {.req_type = 0 };
 	struct hwrm_ver_get_output *resp = bp->hwrm_cmd_resp_addr;
 	uint32_t fw_version;
 	uint16_t max_resp_len;
 	char type[RTE_MEMZONE_NAMESIZE];
+	int rc = 0;
 	uint32_t dev_caps_cfg;
 
 	bp->max_req_len = HWRM_MAX_REQ_LEN;
@@ -1669,10 +1669,9 @@ int bnxt_hwrm_ver_get(struct bnxt *bp, uint32_t timeout)
 	     (dev_caps_cfg &
 	      HWRM_VER_GET_OUTPUT_DEV_CAPS_CFG_SHORT_CMD_REQUIRED)) ||
 	    bp->hwrm_max_ext_req_len > HWRM_MAX_REQ_LEN) {
-		sprintf(type, "bnxt_hwrm_short_" PCI_PRI_FMT,
+		snprintf(type, sizeof(type), "bnxt_hwrm_short_" PCI_PRI_FMT,
 			bp->pdev->addr.domain, bp->pdev->addr.bus,
 			bp->pdev->addr.devid, bp->pdev->addr.function);
-
 		rte_free(bp->hwrm_short_cmd_req_addr);
 
 		bp->hwrm_short_cmd_req_addr =
@@ -3542,7 +3541,7 @@ int bnxt_alloc_hwrm_resources(struct bnxt *bp)
 	struct rte_pci_device *pdev = bp->pdev;
 	char type[RTE_MEMZONE_NAMESIZE];
 
-	sprintf(type, "bnxt_hwrm_" PCI_PRI_FMT, pdev->addr.domain,
+	snprintf(type, sizeof(type), "bnxt_hwrm_" PCI_PRI_FMT, pdev->addr.domain,
 		pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
 	bp->max_resp_len = BNXT_PAGE_SIZE;
 	bp->hwrm_cmd_resp_addr = rte_malloc(type, bp->max_resp_len, 0);
@@ -6792,7 +6791,7 @@ static int bnxt_alloc_all_ctx_pg_info(struct bnxt *bp)
 		if (ctxm->instance_bmap)
 			n = hweight32(ctxm->instance_bmap);
 
-		sprintf(name, "bnxt_ctx_pgmem_%d_%d",
+		snprintf(name, sizeof(name), "bnxt_ctx_pgmem_%d_%d",
 			bp->eth_dev->data->port_id, type);
 		ctxm->pg_info = rte_malloc(name, sizeof(*ctxm->pg_info) * n,
 					   RTE_CACHE_LINE_SIZE);
@@ -7836,6 +7835,7 @@ int bnxt_hwrm_cfa_pair_free(struct bnxt *bp, struct bnxt_representor *rep_bp)
 	HWRM_PREP(&req, HWRM_CFA_PAIR_FREE, BNXT_USE_CHIMP_MB);
 	snprintf(req.pair_name, sizeof(req.pair_name), "%svfr%d",
 		 bp->eth_dev->data->name, rep_bp->vf_id);
+
 	req.pf_b_id = rep_bp->parent_pf_idx;
 	req.pair_mode = HWRM_CFA_PAIR_FREE_INPUT_PAIR_MODE_REP2FN_TRUFLOW;
 	req.vf_id = BNXT_REP_PF(rep_bp) ? rte_cpu_to_le_16(((uint16_t)-1)) :
diff --git a/drivers/net/bnxt/bnxt_stats.c b/drivers/net/bnxt/bnxt_stats.c
index 4074613eb0..05e8944f47 100644
--- a/drivers/net/bnxt/bnxt_stats.c
+++ b/drivers/net/bnxt/bnxt_stats.c
@@ -1165,17 +1165,14 @@ int bnxt_dev_xstats_get_names_op(struct rte_eth_dev *eth_dev,
 	    bp->fw_cap & BNXT_FW_CAP_ADV_FLOW_MGMT &&
 	    BNXT_FLOW_XSTATS_EN(bp)) {
 		for (i = 0; i < bp->max_l2_ctx; i++) {
-			char buf[RTE_ETH_XSTATS_NAME_SIZE];
-
-			sprintf(buf, "flow_%d_bytes", i);
-			strlcpy(xstats_names[count].name, buf,
-				sizeof(xstats_names[count].name));
+			snprintf(xstats_names[count].name,
+				sizeof(xstats_names[count].name),
+				"flow_%d_bytes", i);
 			count++;
 
-			sprintf(buf, "flow_%d_packets", i);
-			strlcpy(xstats_names[count].name, buf,
-				sizeof(xstats_names[count].name));
-
+			snprintf(xstats_names[count].name,
+				sizeof(xstats_names[count].name),
+				"flow_%d_packets", i);
 			count++;
 		}
 	}
-- 
2.47.3

