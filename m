Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BFDCA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 15:17:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8BEC40B91;
	Mon,  5 Oct 2026 17:17:22 +0200 (CEST)
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97]) by mails.dpdk.org (Postfix) with ESMTP id F0F9740A70
 for <dev@dpdk.org>; Mon,  5 Oct 2026 17:17:20 +0200 (CEST)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-3964dfb5b9aso520667a91.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791213440; x=1791818240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M5JtuJmj6IGDoCgbAJ50GZUlyWqpGN2KoxtKRULG/7U=;
 b=OhXKOjab+PDGULmWaCc9KFqJOdKBYxHU80EIyB67aluRXVJPFsYWp8X/rkdUKmx2Jg
 Fkr/HOcAs7BNJJrvJMBCo20nJdCBQhW3LVss/tuVGvDP+ylE67MHQ9N6CaU6PahAA0uT
 3569xRlrJu112CqtqbArH34WAyV3JhTlM8La0t7VMpm+bHajHBClQRn9f5FMQnnkRXK2
 208WRcNAGyHJ1+rkdMKS1MsQWxYQXMvuzP6+rC6onqVZ+U4QXVhRWKlDR9ygqIDaIrh/
 yBSjyQ/G1SJYmcaCxDt1oNuItmWN69CTToHwv1Mpu48CTZcB3DREOvEkc7IKnr2kuvQp
 jFjQ==
X-Gm-Message-State: AFq9FYL6gUNgi36r+bctp9MEBpjUqtN8nOctDdw70rFHGq0rFCTYlHbc
 DmRuPmxAD5x6I70IM3NswC/XTkGN4Owt6pY7GVFPXf/w4s/VYbKz1xULaaJTzq7MmcKALuxPWx+
 LVs5UmDOsEmE107i52BKJ5jcllU2AMQi/uCw0uwRiq1/raOJSbM/my2+gmDadvOo7X2VooO9FLM
 3gIOzWkF4D43rUdxNTwlJWslo7m0B3DU4Tvq0A8wDMt4+qI2v4VLUpac55lfEWTk/Iox8SUA==
X-Gm-Gg: AYBFou0H3co/PVpTKMRBsT/Ca7i165C7jCbgkvHHiDvgkmPd/7y84jwNlSrJscC2rXV
 yZ33jlQ8947u43DIG8lYxCU68WaDD7d2Ca3W2UfKyAx4v2pLtT0uE3UJU0UG0opF3s2IFK1/XLm
 JQH+QzFO7AXQg2cX0vLWoltdkSWjK8v2+rFSkv4agGekbQewB/elRS82ARaLqAiA3hq0GeBtv49
 6Mdl9WA0aHauV9qdzS1hU2tGcCFPoF0QUwRKX4qZjpF73OPkCDWuckNLiAziWYjFoPeS1pz1hua
 OJSPYnzivNzZNHAZ1VyX4hCL9BxQm+LsgQm7dg24VFK/ZJe3kShZNz60P/XilYIywXy9xIFOh0r
 O2+X3pNIkurl1RyDOvb4jGQxGs2Aj2q81q1A3LwT+Ksw1M3cxZnvpP4YGtBHly+VrPuy1eCVNh+
 6AUlza6UdlW7YjMGEBJW+AaVw6RfHB/5GkcCVZiQ==
X-Received: by 2002:a17:90b:50c5:b0:3a7:ada8:c19e with SMTP id
 98e67ed59e1d1-3a7ada8c65emr5163746a91.61.1791213439886; 
 Mon, 05 Oct 2026 08:17:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a808b2c7f4sm1646892a91.3.2026.10.05.08.17.19
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 08:17:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a3f673221so424666485a.0
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791213439; x=1791818239; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M5JtuJmj6IGDoCgbAJ50GZUlyWqpGN2KoxtKRULG/7U=;
 b=hJJ7Rqf1sERg2ytubAZ6Gg6mVdm38J7P6LrqOxapmD+iS2zeM7OSjk7hxHUyOWCpYk
 mzSRxJ527YhEGlJRuL7k9KhVO/hvvDEcC7lEEeX3eRNETzkm5Uuo7lcCiUMoY/31FchY
 OoEWuTSkUYbI3hSmt25IPv0OHuHOTr/FJ5LIE=
X-Received: by 2002:a05:620a:298c:b0:93e:6865:7e3a with SMTP id
 af79cd13be357-93e6865aedcmr732299085a.55.1791213438653; 
 Mon, 05 Oct 2026 08:17:18 -0700 (PDT)
X-Received: by 2002:a05:620a:298c:b0:93e:6865:7e3a with SMTP id
 af79cd13be357-93e6865aedcmr732293485a.55.1791213438045; 
 Mon, 05 Oct 2026 08:17:18 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93e7ec53cd0sm110432285a.14.2026.10.05.08.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 08:17:17 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH 1/2] net/bnxt: fix message-layer bounds and pointer checks
Date: Mon,  5 Oct 2026 10:16:58 -0500
Message-Id: <20261005151659.1705967-2-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261005151659.1705967-1-manish.kurup@broadcom.com>
References: <20261005151659.1705967-1-manish.kurup@broadcom.com>
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
static analysis.

tfc_msg_idx_tbl_get() used the raw FW-reported resp.data_size in a
memcpy() without capping it to the caller's DMA buffer size, and
dereferenced the caller-supplied dev_data/data_size pointers without
a NULL check. Decode resp.data_size and reject the call if it
exceeds the caller-supplied *data_size, and add an early return with
-EINVAL if dev_data or data_size is NULL.

tfc_msg_if_tbl_get() set rc=-EINVAL on a size mismatch but fell
through to *data_size = resp.data_size and then memcpy()'d that many
bytes into the caller's buffer anyway. Return early on error, and
decode resp.data_size before assigning it to *data_size.

tfc_msg_idx_tbl_alloc_set() and tfc_msg_idx_tbl_set() dereferenced
the caller-supplied dev_data pointer without a NULL check. Add an
early return with -EINVAL if dev_data is NULL.

Fixes: 80317ff6adfd ("net/bnxt/tf_core: support Thor2")
Cc: stable@dpdk.org

Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_msg.c | 32 +++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_msg.c b/drivers/net/bnxt/tf_core/v3/tfc_msg.c
index cf72d09184..6282449b44 100644
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
@@ -1289,10 +1313,10 @@ tfc_msg_if_tbl_get(struct tfc *tfcp, uint16_t fid, uint16_t sid,
 	if (*data_size < rte_le_to_cpu_16(resp.data_size)) {
 		PMD_DRV_LOG_LINE(ERR, "Table buffer is too small, rc:%s",
 				 strerror(EINVAL));
-		rc = -EINVAL;
+		return -EINVAL;
 	}
 
-	*data_size = resp.data_size;
+	*data_size = rte_le_to_cpu_16(resp.data_size);
 	memcpy(data, resp.data, *data_size);
 
 	return rc;
-- 
2.31.1

