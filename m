Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DD8CC6B0E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 17:16:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FF4E406BC;
	Tue, 13 Oct 2026 19:16:13 +0200 (CEST)
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com
 [209.85.215.227])
 by mails.dpdk.org (Postfix) with ESMTP id 53387406A2
 for <dev@dpdk.org>; Tue, 13 Oct 2026 19:16:12 +0200 (CEST)
Received: by mail-pg1-f227.google.com with SMTP id
 41be03b00d2f7-cd5cd8d89a7so1185923a12.1
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791911771; x=1792516571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aocpA+oTZSAPiDtdSYfy6vVCEN5rvl8s9aA2tKk+knU=;
 b=jw5Azo4dVFktNqfj5vrRu5z++G2WwMIaZ5aUUOuM3t8JVckENxZdHv3tRuoVfdLf1p
 FzPBiBRR1kmHenp1n6ulWtvG5Q/8m56kTYw+fC+EkesI6t0sP+ir232e67x422pVqJjM
 uExLZht8l/2SVKSMtIgQqsVbVCW+7D2hoMxxyGCssRx5sVckjWYlMMtQ+EpPx/hnV7x5
 nRgM9sIH48idO7/ozjud0VanKnjW3daoAJPiA84XIyP59QugNnioesYq+nqvYqk7sbT+
 JibRLtLlO7o8EH7KifrHLGbxrFzqPu6gfzxPnSX6Tks7ZtABF2HxPvF4exwSdOLTJ2L5
 iqdg==
X-Gm-Message-State: AFq9FYIF0XHpNIceGZ3hT/r6u+P99C5d+3F4kf3P/1RZeNFyjZxqrHn+
 M1r6wfPZsjRqwj/qblrJ3VLMT28sZdTqozo44gTpizUK1TJ7DX/bTXaqL5bznxUa2TsZQFuJ5MX
 cSmToeeSzNZdWEZBtjuBZ6S/c5ghgrq8IX7q64hdUKZWragZasy87y1xxtJz/SBJCR2zHXZhrqD
 FqAR91Aef3/jiqLYcVJraGzU4Q4OiD6I7n/PbQs+B/GveXbtF0wvPmQDYuEI16FLzAVbSmV1DZv
 eC5hdJNWyJh
X-Gm-Gg: AYBFou2f+qVY/csxlQTVayMYh9zy7cEKbR3D91Fm3m4pQ15Li6pN2WcxIX5v/0+mir4
 jdIqGu92HWn7rIjivWxdLzi3wRD+2f+Ts4HXzGF1FnWXRJH3r++U31WrFolb9r81u55cDS0apkc
 fVaycEImZzeziMgONWmJS5NaYAOLPL0VXPYMrxRv/lR9dHjRi7bzKFTE2qTMil9DChfsh5yWHb0
 RnT7Ef22Eai2ccpemj6IlhP0OJLrA8JzzfdbEiZOQoTKwRQHt19sAyj7PNimP7eFUYw82s9DPwW
 5KJWDWqkPaEsI4AyUeWTxt0+T8tjitORcd9PbPL0x8J9GQFo/64rETFgK5cJ2x6LCrgZL8apjYA
 gO4hVfA8COKNCmV/Wy/LN69aDgJJdpFZ13lvXJUzB8tZI3M26UFtLCd1l4WFOfjZdx4qB7DOUJD
 iyzFYdqr4B3lSGQCnuF83193Rjm+wAl43sSQuTCHwJTjf+4MwXww8T
X-Received: by 2002:a17:90b:164b:b0:3a7:a6bc:9d58 with SMTP id
 98e67ed59e1d1-3ab3af76821mr10301031a91.54.1791911771326; 
 Tue, 13 Oct 2026 10:16:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ac5ede81a4sm151635a91.0.2026.10.13.10.16.11
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Oct 2026 10:16:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93dea1b6c89so615868785a.2
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791911770; x=1792516570; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aocpA+oTZSAPiDtdSYfy6vVCEN5rvl8s9aA2tKk+knU=;
 b=PFT844OD27mfkhBRW7kWeypLXqeXh/olwsZMyZqw6O+rXNsLHl5Kf1XIL5sFQ26+ji
 23jiaexSmLz+8ZCbZCArSbGNgUPDz8I5QyHeUQEdXt1LMDaB8pRP6V680bkpNrTDY9B7
 sEfu6/NPL6BaQzz9GrcNJ1cDaG79hUIlSKY4o=
X-Received: by 2002:a05:620a:1a25:b0:93c:c96c:a58d with SMTP id
 af79cd13be357-93ebd25b5e9mr2026129485a.54.1791911769827; 
 Tue, 13 Oct 2026 10:16:09 -0700 (PDT)
X-Received: by 2002:a05:620a:1a25:b0:93c:c96c:a58d with SMTP id
 af79cd13be357-93ebd25b5e9mr2026123485a.54.1791911769074; 
 Tue, 13 Oct 2026 10:16:09 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ef505463esm281874485a.32.2026.10.13.10.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 10:16:08 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, manish.kurup@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH v2] net/bnxt: fix message bounds checks and hot upgrade ID
 limit
Date: Tue, 13 Oct 2026 11:19:52 -0600
Message-ID: <20261013171952.452403-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005151659.1705967-2-manish.kurup@broadcom.com>
References: <20261005151659.1705967-2-manish.kurup@broadcom.com>
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

Fix four medium/low severity issues in the message layer, found by
static analysis. Also fix the hot-upgrade app instance ID limit.

tfc_msg_idx_tbl_get() used the raw FW-reported resp.data_size in a
memcpy() without capping it to the caller's DMA buffer size, and
dereferenced the caller-supplied dev_data/data_size pointers without
a NULL check. Decode resp.data_size and reject the call if it
exceeds the caller-supplied *data_size, and add an early return with
-EINVAL if dev_data or data_size is NULL.

tfc_msg_if_tbl_get() set rc=-EINVAL on a size mismatch but fell
through to *data_size = resp.data_size and then memcpy()'d that many
bytes into the caller's buffer anyway. Return early on error, and
decode resp.data_size before assigning it to *data_size. Also reject
a FW-reported size larger than the response data array, which the
caller's buffer size alone does not bound, and add an early return
with -EINVAL if data or data_size is NULL.

tfc_msg_idx_tbl_alloc_set() and tfc_msg_idx_tbl_set() dereferenced
the caller-supplied dev_data pointer without a NULL check. Add an
early return with -EINVAL if dev_data is NULL.

Despite its name, CFA_HOT_UPGRADE_APP_INSTANCE_MAX (4) is used as the
highest valid app instance ID, and valid IDs are 1-8 (0 disables the
feature), matching the existing devargs validation.
tfc_hot_upgrade_validate() therefore rejected valid IDs 5-8 with an
"Invalid app instance" error. Raise the constant to 8.

Fixes: 80317ff6adfd ("net/bnxt/tf_core: support Thor2")
Fixes: eeefaecba000 ("net/bnxt/tf_ulp: support hot upgrade")
Cc: stable@dpdk.org

Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
v2:
 - Fold in the hot-upgrade app instance ID limit fix that was sent as 2/2 (4 -> 8), with its own Fixes tag; this patch supersedes both patches of the v1 series
 - In tfc_msg_if_tbl_get(), also bound the FW-reported size against the response data array, read the uint8_t data_size directly, and check data/data_size for NULL
 - New subject

 .../bnxt/hcapi/cfa_v3/include/cfa_resources.h |  2 +-
 drivers/net/bnxt/tf_core/v3/tfc_msg.c         | 48 ++++++++++++++++---
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/net/bnxt/hcapi/cfa_v3/include/cfa_resources.h b/drivers/net/bnxt/hcapi/cfa_v3/include/cfa_resources.h
index ada9741dfa1..98b96e0a11e 100644
--- a/drivers/net/bnxt/hcapi/cfa_v3/include/cfa_resources.h
+++ b/drivers/net/bnxt/hcapi/cfa_v3/include/cfa_resources.h
@@ -194,7 +194,7 @@ enum cfa_resource_subtype_gim {
 	 CFA_RSUBTYPE_SM_MAX + CFA_RSUBTYPE_TSM_MAX + CFA_RSUBTYPE_TIM_MAX +   \
 	 CFA_RSUBTYPE_GIM_MAX)
 
-#define CFA_HOT_UPGRADE_APP_INSTANCE_MAX 4
+#define CFA_HOT_UPGRADE_APP_INSTANCE_MAX 8
 enum cfa_hot_upgrade_cmd_op {
 	CFA_HOT_UPGRADE_CMD_ALLOC = 1,
 	CFA_HOT_UPGRADE_CMD_FREE,
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_msg.c b/drivers/net/bnxt/tf_core/v3/tfc_msg.c
index df11910dc3b..89c256b8109 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_msg.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_msg.c
@@ -548,6 +548,11 @@ tfc_msg_idx_tbl_alloc_set(struct tfc *tfcp, uint16_t fid, uint16_t sid,
 	struct tfc_msg_dma_buf buf = { 0 };
 	uint8_t *data = NULL;
 
+	if (!dev_data) {
+		PMD_DRV_LOG_LINE(ERR, "invalid input");
+		return -EINVAL;
+	}
+
 	if (dir == CFA_DIR_RX)
 		req.flags |= HWRM_TFC_IDX_TBL_ALLOC_SET_INPUT_FLAGS_DIR_RX &
 			     HWRM_TFC_IDX_TBL_ALLOC_SET_INPUT_FLAGS_DIR;
@@ -613,6 +618,11 @@ tfc_msg_idx_tbl_set(struct tfc *tfcp, uint16_t fid,
 	struct tfc_msg_dma_buf buf = { 0 };
 	uint8_t *data = NULL;
 
+	if (!dev_data) {
+		PMD_DRV_LOG_LINE(ERR, "invalid input");
+		return -EINVAL;
+	}
+
 	if (dir == CFA_DIR_RX)
 		req.flags |= HWRM_TFC_IDX_TBL_SET_INPUT_FLAGS_DIR_RX &
 			     HWRM_TFC_IDX_TBL_SET_INPUT_FLAGS_DIR;
@@ -671,6 +681,11 @@ tfc_msg_idx_tbl_get(struct tfc *tfcp, uint16_t fid,
 	struct hwrm_tfc_idx_tbl_get_output resp = { 0 };
 	struct tfc_msg_dma_buf buf = { 0 };
 
+	if (!dev_data || !data_size) {
+		PMD_DRV_LOG_LINE(ERR, "invalid input");
+		return -EINVAL;
+	}
+
 	if (dir == CFA_DIR_RX)
 		req.flags |= HWRM_TFC_IDX_TBL_GET_INPUT_FLAGS_DIR_RX &
 			     HWRM_TFC_IDX_TBL_GET_INPUT_FLAGS_DIR;
@@ -702,8 +717,17 @@ tfc_msg_idx_tbl_get(struct tfc *tfcp, uint16_t fid,
 					 &req, sizeof(req), &resp, sizeof(resp));
 
 	if (rc == 0) {
-		memcpy(dev_data, buf.va_addr, resp.data_size);
-		*data_size = rte_le_to_cpu_16(resp.data_size);
+		uint16_t resp_data_size = rte_le_to_cpu_16(resp.data_size);
+
+		if (resp_data_size > *data_size) {
+			PMD_DRV_LOG_LINE(ERR,
+					 "FW resp data_size(%u) > caller buf(%u)",
+					 resp_data_size, *data_size);
+			rc = -EINVAL;
+			goto cleanup;
+		}
+		memcpy(dev_data, buf.va_addr, resp_data_size);
+		*data_size = resp_data_size;
 	}
 
 cleanup:
@@ -1274,10 +1298,16 @@ tfc_msg_if_tbl_get(struct tfc *tfcp, uint16_t fid, uint16_t sid,
 		   uint16_t index, uint8_t *data_size, uint8_t *data)
 {
 	int rc = 0;
+	uint8_t resp_size;
 	struct bnxt *bp = tfcp->bp;
 	struct hwrm_tfc_if_tbl_get_input req = { 0 };
 	struct hwrm_tfc_if_tbl_get_output resp = { 0 };
 
+	if (!data || !data_size) {
+		PMD_DRV_LOG_LINE(ERR, "invalid input");
+		return -EINVAL;
+	}
+
 	req.flags = (dir == CFA_DIR_TX ?
 		    HWRM_TFC_IF_TBL_GET_INPUT_FLAGS_DIR_TX :
 		    HWRM_TFC_IF_TBL_GET_INPUT_FLAGS_DIR_RX);
@@ -1296,14 +1326,20 @@ tfc_msg_if_tbl_get(struct tfc *tfcp, uint16_t fid, uint16_t sid,
 	if (rc)
 		return rc;
 
-	if (*data_size < rte_le_to_cpu_16(resp.data_size)) {
+	resp_size = resp.data_size;
+	if (resp_size > sizeof(resp.data)) {
+		PMD_DRV_LOG_LINE(ERR, "Invalid table response size %u",
+				 resp_size);
+		return -EINVAL;
+	}
+	if (*data_size < resp_size) {
 		PMD_DRV_LOG_LINE(ERR, "Table buffer is too small, rc:%s",
 				 strerror(EINVAL));
-		rc = -EINVAL;
+		return -EINVAL;
 	}
 
-	*data_size = resp.data_size;
-	memcpy(data, resp.data, *data_size);
+	*data_size = resp_size;
+	memcpy(data, resp.data, resp_size);
 
 	return rc;
 }
-- 
2.47.3

