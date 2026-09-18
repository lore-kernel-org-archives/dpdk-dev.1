Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38066C88E75
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 03:24:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C38742F99;
	Fri, 18 Sep 2026 05:24:29 +0200 (CEST)
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com
 [74.125.224.100])
 by mails.dpdk.org (Postfix) with ESMTP id E108B40270
 for <dev@dpdk.org>; Fri, 18 Sep 2026 05:24:27 +0200 (CEST)
Received: by mail-yx1-f100.google.com with SMTP id
 956f58d0204a3-6711bc23524so35440d50.3
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789701867; x=1790306667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AQzTLKr6u52eVGcUAlngt3nLYlqxTUtsw32h/LL5La0=;
 b=j8WkybYtSHpWaNp+ll2ON6dS8ZxTJSMLR68FxYNhIhY8ih676qMNVBxjxa199KHyWX
 Z3ti0RkV/4g19eqxjqj4+fKdU5otS2prFl8S08rzDmG8WU+nFeQuOiX2RKNYY20AnBaI
 MHnR22RSwHpuQ6YDane+c9cemNVM55i8Mvixbiu87rwF8e/B0WUAgVCVDd3v+ef9pl2X
 Xii8Z/eTe+HOdI+vHrc9pvQ6UVNpoPq63LONzjU2pJUZLo++KJYaPqGe2KK16Hw4j2tl
 5eJ6Bo2Tc1dV2zXuE4dbn9OFjvfMWaz5XJRY+YUar2MZB0dot77tixmoyZM7b6a+sWkf
 6sKQ==
X-Gm-Message-State: AFuF++k34kGgtgogiY91zaBdYkbw9huVD3fyrbyQqzpcCgwQ6WaJ5A2p
 r4t8djRwZT0Su74P39dMBEjRWVODoi4fPtRik2LwAeeOjRuHXhXeQ6buUiQMf83SQR6+iPhk/md
 jwOFrMQECRKJz4/zyjvcJncALd1K5AcujAXjOgCymX1SEY/py4Xc1tRKNk0n/e3DkIOYvhg8xeF
 hQWgFGX5HLCiCRI7QicYqILgjTSiVZirw3Q1PLOJdt6BYAB++AayfSpJs8+c2yElXUyIpyg8Kmm
 SUqldId4f2w
X-Gm-Gg: AYBFou2xCiLRvdrNK8LlYjQq/S90PPEsniMNI+qylRTiq06IeHHfX3xXT/XIrl1TOus
 1VnHt+nV/LhXnzUP4vVXZ/QbQxIUXRB8jSLFeoUff5O9PrGJB7LvViE7XROEdNSU3kJY3cnZPFE
 cbuHnHjyVsK4dYw1lmvFxlcGrPLtNNzcSqyZkCgkbsTRuAfMtaRZP6gfC5NA5mMFHchG6UVGTjg
 j9Id3fG45YUa83jI2psCU9MivDzMePWwXnodTJaL+yO4sliO9pZgxJw+WiqUBZMjx4MkqROXkHS
 fPLKle0zh5mneDKUVsPC4zsOlJPpmdgSNKZ3/4ULw4woNPPPIuo9sE8DfkvdYFUWDdMP1xh4aBa
 I43U+k8X+R6WWR/BDVCL4a3SuwmRdJL60AFl1n0wf8v3oeSTo2zn1EHR5nzcma5XcyUnnp/KbAo
 xrK65PDFLsDSFDRHsFqJ3Ch+56TmnbdHSa8Y4Vvqi3/g1QtLtlHA==
X-Received: by 2002:a05:690c:c509:b0:81e:98d3:cac7 with SMTP id
 00721157ae682-8973296fd9dmr4077977b3.12.1789701867013; 
 Thu, 17 Sep 2026 20:24:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-897e7be6c91sm31287b3.12.2026.09.17.20.24.25
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Sep 2026 20:24:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d7443e0f0bso6407865ad.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789701864; x=1790306664; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AQzTLKr6u52eVGcUAlngt3nLYlqxTUtsw32h/LL5La0=;
 b=b6qp9X7cGw10MdzPtxA6/ntvW0PMO1HZyqk8QwpNR2tC9RaeVzgYh+xxyflKjn/c7W
 TSgD98HiK00CXizKwv+bnomxu1r/XI5W9SfiEmKvsA5xixNOnjy9Sek4OpcyRkxf6au+
 2B7TTagHi3+Y2lQC58hVgGa8xmsvNJWeSQ2Ls=
X-Received: by 2002:a17:902:d4c3:b0:2d7:f0:896b with SMTP id
 d9443c01a7336-2ddb1b096bfmr26481065ad.13.1789701864353; 
 Thu, 17 Sep 2026 20:24:24 -0700 (PDT)
X-Received: by 2002:a17:902:d4c3:b0:2d7:f0:896b with SMTP id
 d9443c01a7336-2ddb1b096bfmr26480575ad.13.1789701863809; 
 Thu, 17 Sep 2026 20:24:23 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c287b023bsm597708eec.23.2026.09.17.20.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:24:23 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Joseph Wong <joseph.wong@broadcom.com>,
 stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 1/5] net/bnxt: add VF ID boundary check before usage
Date: Thu, 17 Sep 2026 21:27:22 -0600
Message-ID: <20260918032726.763384-2-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Joseph Wong <joseph.wong@broadcom.com>

bnxt_handle_fwd_req() computed vf_id from an unvalidated,
firmware-controlled source_id and used it to index
bp->pf->vf_info[] before checking that the ID falls within the
active VF range. An out-of-range VF ID could index past
vf_info[] and cause memory corruption.

Move the range check ahead of the vf_id computation and the
vf_info[] lookup. Guard the later fwd_cmd/req_len usage on the
reject path, since they are no longer set when the request is
rejected early. Also guard bnxt_hwrm_reject_fwd_resp()'s memcpy()
against a NULL encaped pointer for the same reason.

Fixes: f2a768d4d186 ("net/bnxt: add completion ring")
Cc: stable@dpdk.org

Signed-off-by: Joseph Wong <joseph.wong@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_cpr.c  | 25 ++++++++++++++-----------
 drivers/net/bnxt/bnxt_hwrm.c |  3 ++-
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_cpr.c b/drivers/net/bnxt/bnxt_cpr.c
index 5c255de59e..ac731ea72f 100644
--- a/drivers/net/bnxt/bnxt_cpr.c
+++ b/drivers/net/bnxt/bnxt_cpr.c
@@ -375,16 +375,6 @@ void bnxt_handle_fwd_req(struct bnxt *bp, struct cmpl_base *cmpl)
 
 	/* Qualify the fwd request */
 	fw_vf_id = rte_le_to_cpu_16(fwd_cmpl->source_id);
-	vf_id = fw_vf_id - bp->pf->first_vf_id;
-
-	req_len = (rte_le_to_cpu_16(fwd_cmpl->req_len_type) &
-		   HWRM_FWD_REQ_CMPL_REQ_LEN_MASK) >>
-		HWRM_FWD_REQ_CMPL_REQ_LEN_SFT;
-	if (req_len > sizeof(fwreq->encap_request))
-		req_len = sizeof(fwreq->encap_request);
-
-	/* Locate VF's forwarded command */
-	fwd_cmd = (struct input *)bp->pf->vf_info[vf_id].req_buf;
 
 	if (fw_vf_id < bp->pf->first_vf_id ||
 	    fw_vf_id >= bp->pf->first_vf_id + bp->pf->active_vfs) {
@@ -393,9 +383,22 @@ void bnxt_handle_fwd_req(struct bnxt *bp, struct cmpl_base *cmpl)
 			fw_vf_id, bp->pf->first_vf_id,
 			(bp->pf->first_vf_id) + bp->pf->active_vfs - 1,
 			bp->pf->first_vf_id, bp->pf->active_vfs);
+		fwd_cmd = NULL;
+		req_len = 0;
 		goto reject;
 	}
 
+	vf_id = fw_vf_id - bp->pf->first_vf_id;
+
+	req_len = (rte_le_to_cpu_16(fwd_cmpl->req_len_type) &
+		   HWRM_FWD_REQ_CMPL_REQ_LEN_MASK) >>
+		HWRM_FWD_REQ_CMPL_REQ_LEN_SFT;
+	if (req_len > sizeof(fwreq->encap_request))
+		req_len = sizeof(fwreq->encap_request);
+
+	/* Locate VF's forwarded command */
+	fwd_cmd = (struct input *)bp->pf->vf_info[vf_id].req_buf;
+
 	if (bnxt_rcv_msg_from_vf(bp, vf_id, fwd_cmd)) {
 		/*
 		 * In older firmware versions, the MAC had to be all zeros for
@@ -495,7 +498,7 @@ void bnxt_handle_fwd_req(struct bnxt *bp, struct cmpl_base *cmpl)
 		PMD_DRV_LOG_LINE(ERR,
 			"Failed to send REJECT req VF 0x%x, type 0x%x.",
 			fw_vf_id - bp->pf->first_vf_id,
-			rte_le_to_cpu_16(fwd_cmd->req_type));
+			fwd_cmd ? rte_le_to_cpu_16(fwd_cmd->req_type) : 0xFFFF);
 	}
 
 	return;
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 1615b36aae..aa8152eaa0 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -5520,7 +5520,8 @@ int bnxt_hwrm_reject_fwd_resp(struct bnxt *bp, uint16_t target_id,
 	HWRM_PREP(&req, HWRM_REJECT_FWD_RESP, BNXT_USE_CHIMP_MB);
 
 	req.encap_resp_target_id = rte_cpu_to_le_16(target_id);
-	memcpy(req.encap_request, encaped, ec_size);
+	if (encaped)
+		memcpy(req.encap_request, encaped, ec_size);
 
 	rc = bnxt_hwrm_send_message(bp, &req, sizeof(req), BNXT_USE_CHIMP_MB);
 
-- 
2.47.3

