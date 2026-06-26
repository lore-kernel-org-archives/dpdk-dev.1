Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231D8CDE00B
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 03:10:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD2FD40272;
	Fri, 26 Jun 2026 05:10:58 +0200 (CEST)
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com
 [209.85.160.226])
 by mails.dpdk.org (Postfix) with ESMTP id D821440269
 for <dev@dpdk.org>; Fri, 26 Jun 2026 05:10:56 +0200 (CEST)
Received: by mail-qt1-f226.google.com with SMTP id
 d75a77b69052e-519ff1c8b8bso5043551cf.3
 for <dev@dpdk.org>; Thu, 25 Jun 2026 20:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782443456; x=1783048256;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8DdkP+ORnd30fr6r0cCDLc+5ohYL6LI4VfpvOMAbhq8=;
 b=AzHmSnZCsK5rWIoDCTKQVLk2B+dIxQCWoWF6hw8G33bbNDlQNMO5p8gMDeswLTdyn4
 1VYb8qkCf9HuN0QGE17r5DHJJzV5nksBSXKQbTV03oS1PbvDrUOCd4THIB5ONQh4jqqo
 a7EbnSk48AL63yu3gQ2xGqAFA4yFQyK1QbVGhhGtvhU3vXQ3SGz2q7DoKSW8ABIHEVuM
 eXLgZf0y4Gp5imFqwnLJ9MpsEDvYNyGv3PBWiU2c6nQ+ugwgJ6M2ehC1GKP/DzWGUBd3
 3QP+C1HgEPxIH2kyZWZd0tOGbLxtOe/Nv3SOBXssrOPl+Eo+Ib4lfyhj2h4FbKhgaifQ
 Z7TQ==
X-Gm-Message-State: AOJu0YzxvByTcD+WRqhdpmF6x3LMESGCiN3kRasTzKCDfYiwIMF1rdET
 XrurGpikBE0yDVdegZjm4u9Z04XZHopTOKRlHU4bMVDMOudxpR1nglrfXm4dQSZfG26iC5xm6RO
 gpS/DmV34eJIbfMqXfVIVByUW5BUXQ77ikhvuGNM7VXOp7YDuFUZL208d67ESCwaV/Vls8+r/KI
 DC3w6iqSNp7OmFar4J3PMxBaDBZsVrsfMu/+Bsha5Y7CNQLDwKXQ5SQhLDaMQ/yLx0lvbOuG8oa
 RvGFiJ0PQyf
X-Gm-Gg: AfdE7cnSRjSq4HQ5LR4dA+ubf9F96V69Yug3JPJ6XR5WiL2t1pFR6SwTKJXyRbmrQVI
 SPqmxvyjDblLcxdJbAhttDVQPiQ9U+OvXmd6LpfPjMFtHSCAE35495S0duuJvDIOIwEDmoKY1sq
 dx/w5Ns2qFRtCFrVyy8HhXgGWftOk5JU/JFfhixN4F3joCqmmEUQ2PZ/iwFu02TTCDc8RoElYy7
 Yanfoy6tW55j+Tby+AnqufwlCD8/6fzyzjvt4ZyMRZDPkIz75wHPnSA4fXG8T+NT+WYLLpAo6ig
 6Ha1QvSZSzTdCHj7B7Nuk3/ZMmFcIpXiZO/tQL6ErktSWowzgilqf8uy3pWBg0njz7BmToosHGq
 qYAjZf78lEfCUSHhX7igauR0K7IbqU3cadIqOW/niq/OlPWkCM8k9lOo3DyKCp6pac0k7gtq4Xs
 lFc32XG68/DYIFcbsMlV3IBbPehU+mO64OZ70qoIgxAAd1SlIHeViXywJhkggE9yM=
X-Received: by 2002:ac8:51d9:0:b0:517:8960:6d28 with SMTP id
 d75a77b69052e-51a77d84899mr46098641cf.54.1782443455649; 
 Thu, 25 Jun 2026 20:10:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-8df7fae609dsm13388006d6.6.2026.06.25.20.10.54
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jun 2026 20:10:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30ba395b047so1363758eec.0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 20:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1782443454; x=1783048254; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8DdkP+ORnd30fr6r0cCDLc+5ohYL6LI4VfpvOMAbhq8=;
 b=W8Tv+SOmsqKhgPyB7QoSV/E1hndGzxMFVXqcGSavT3Zi1nnlKs1cMKIM9vnSZnH8CS
 MHzh14Jd8UjKL/ng0BPx6aQHogNgKD0NZJMJkL/CvnYhs43sEZ+lZ8+utuerQG9TkgiS
 AKUEXEencazlqrs02wKg9cu9dInKB50qZLXks=
X-Received: by 2002:a05:7300:7241:b0:30b:9e57:1e6b with SMTP id
 5a478bee46e88-30c84dad34amr6004638eec.17.1782443453915; 
 Thu, 25 Jun 2026 20:10:53 -0700 (PDT)
X-Received: by 2002:a05:7300:7241:b0:30b:9e57:1e6b with SMTP id
 5a478bee46e88-30c84dad34amr6004600eec.17.1782443453176; 
 Thu, 25 Jun 2026 20:10:53 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52eed6sm12931385eec.9.2026.06.25.20.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 20:10:52 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Dakota Sicher <dakota.sicher@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH] net/bnxt: fix ttxp backing store always configured
Date: Thu, 25 Jun 2026 21:13:17 -0600
Message-ID: <20260626031317.928974-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
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

From: Dakota Sicher <dakota.sicher@broadcom.com>

Driver attempts to configure the TTX pacing TQM rings regardless
of firmware capabilities. When the card does not support timed TX
pacing the device fails to initialize.

Skip the TTX_PACING_TQM_RING backing store type when
BNXT_FW_CAP_TIMED_TX_PACING is not set. The capability is defined
but not set until timed TX pacing support is enabled, so the ring
type is unconditionally skipped on unaffected cards.

Fixes: fe2f715ca580 ("net/bnxt: support backing store v2")
Cc: stable@dpdk.org

Signed-off-by: Dakota Sicher <dakota.sicher@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt.h      |  1 +
 drivers/net/bnxt/bnxt_hwrm.c | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index 5ae4e620a4..b2736befd1 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -887,6 +887,7 @@ struct bnxt {
 #define BNXT_FW_CAP_TX_COAL_CMPL	BIT(10)
 #define BNXT_FW_CAP_RX_ALL_PKT_TS	BIT(11)
 #define BNXT_FW_CAP_BACKING_STORE_V2	BIT(12)
+#define BNXT_FW_CAP_TIMED_TX_PACING	BIT(15)
 #define BNXT_FW_CAP_RX_RATE_PROFILE	BIT(17)
 #define BNXT_FW_CAP_MULTI_DB		BIT(18)
 #define BNXT_FW_BACKING_STORE_V2_EN(bp)	\
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 4a5b83d29c..273561aabb 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -6625,7 +6625,10 @@ int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
 
 		flags = rte_le_to_cpu_32(resp->flags);
 		type = rte_le_to_cpu_16(resp->next_valid_type);
-		if (!(flags & HWRM_FUNC_BACKING_STORE_QCAPS_V2_OUTPUT_FLAGS_TYPE_VALID)) {
+		if (!(flags & HWRM_FUNC_BACKING_STORE_QCAPS_V2_OUTPUT_FLAGS_TYPE_VALID) ||
+		    (rte_le_to_cpu_16(req.type) ==
+		    HWRM_FUNC_BACKING_STORE_QCAPS_V2_INPUT_TYPE_TTX_PACING_TQM_RING &&
+		    !(bp->fw_cap & BNXT_FW_CAP_TIMED_TX_PACING))) {
 			cnt = false;
 			goto next;
 		}
@@ -6702,7 +6705,10 @@ int bnxt_hwrm_func_backing_store_types_count(struct bnxt *bp)
 		type = rte_le_to_cpu_16(resp->next_valid_type);
 		HWRM_UNLOCK();
 
-		if (flags & HWRM_FUNC_BACKING_STORE_QCAPS_V2_OUTPUT_FLAGS_TYPE_VALID) {
+		if ((flags & HWRM_FUNC_BACKING_STORE_QCAPS_V2_OUTPUT_FLAGS_TYPE_VALID) &&
+		    !(rte_le_to_cpu_16(req.type) ==
+		    HWRM_FUNC_BACKING_STORE_QCAPS_V2_INPUT_TYPE_TTX_PACING_TQM_RING &&
+		    !(bp->fw_cap & BNXT_FW_CAP_TIMED_TX_PACING))) {
 			PMD_DRV_LOG_LINE(DEBUG, "Valid types 0x%x", req.type);
 			types++;
 		}
-- 
2.47.3

