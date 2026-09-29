Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D6FCA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 00:21:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8469D40ECF;
	Tue, 29 Sep 2026 02:21:29 +0200 (CEST)
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com
 [209.85.214.228])
 by mails.dpdk.org (Postfix) with ESMTP id C07C240E96
 for <dev@dpdk.org>; Tue, 29 Sep 2026 02:21:27 +0200 (CEST)
Received: by mail-pl1-f228.google.com with SMTP id
 d9443c01a7336-2df8d686d10so11566515ad.3
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641287; x=1791246087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o2d+GsCOwb4bIGD8LLkcaR91kIAj1nu5JsvHL1JY578=;
 b=wsokBeov5a1Ql86o4yQrpzBYE+wy3g4GzTgclR2bmByaCx6m+4RgqI9X+v556Pc0uC
 B0dsFIIwva26qYMA8+f4LJWrJ/Klo3ETiW+Czi06TCdK1ZShLR3KqVEQLt3IZAUNnai8
 t5iCDvZWM413SjhMWLZGlA1jUSux4PPumdC/IFatz7SxkvO7VxIBDIGjMRg+n3iZmurd
 /R9JpQNm3BSWeY/Tax9g54T6UVdPkLTYxYZEurfpo9MPodeOtCBgbbn3Zq6ztQA6kmyT
 W/L7gqmVG7kRBzRoIej3ZWSVpyhcNLHUHjoHjplpcJWwhSYT+sdnWDQDxZCNWpKSWyQz
 FF2A==
X-Gm-Message-State: AFq9FYLKuRAtJC+nWQq9SJSHt7u0NNKFGUJL2KPJLj6l2krUtFWAmTpo
 G+P45vmY85/odVzoKcDkuo9JkZhkMQOoF5tNbqMw82q2J+3HYBPnoaaU9whDx5qKtNDMjqCbpTS
 CSCX8w+axj0CpD0MhkvW0A19FNnnSYcdg8MQdnGKMZjhqq+NNMRiWx1s2VJU+5V7IERwIHaSQql
 tW0EOWJ4fgxk3tYTnRaQK5nnkpqkBo0B5tq7XWI7YagjvwA9wtbO6Odb09TqBvwZ4F1pYCpN/1B
 2FF76UKwlfT
X-Gm-Gg: AYBFou2wvIFxFo4PDXfZKlQiEKKQyBDwjodWnl9lxhPlv83zgsQ5i0BlroIU83KDyc1
 CfTe7QZQPoyOpU8dUP7LV6SxYJuFkoeoLsaF9g8kRrnOhNJSJyjJfzej03svGjzWR6PaQYIgX+H
 cgu+fJpBbaIit213BM2+L1jz0wD09MlD1FLEjvfAjX0ybTuzuA+dK1vIVI9bq0Sh+xuWpHi32uO
 gQKCHYicPsC1+w5gaU318NqsAj8WHweprNaT2FKsi26KJi5P5sNbghvZhCFJtxI4s5fVX6sK2ki
 H1kion0Asmtyem9HD8tRtervMQFqyl76fi1oYbbJR6DQoZUOIPMeOZuePY8/zwHRQtp1JCAzTvR
 nm39KTXDh77R3+0lqThNSoULMf4j6VAcudNP+mhJij5E5fwkqN0tfGpENuSBOGnbrZgx6D7hh0l
 w/Hsi46uNtjohfh8W3OJL5RtlucPL2J9XUsQjgVKlmkbtEhIoB+l95
X-Received: by 2002:a17:90b:3c8e:b0:3a0:e0a5:dbcd with SMTP id
 98e67ed59e1d1-3a0e0a5df1emr6902496a91.37.1790641286714; 
 Mon, 28 Sep 2026 17:21:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a4980201besm687290a91.8.2026.09.28.17.21.26
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2026 17:21:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93c5c205127so416556785a.2
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790641285; x=1791246085; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o2d+GsCOwb4bIGD8LLkcaR91kIAj1nu5JsvHL1JY578=;
 b=NGraaysQHVIRm+Digj8+9Cir6jtq2Xnp6YbBzhHLpXCa682Suug7a1tlq1NrfoKa8X
 A9OkEs5ZWco4BABqdNwR7E2h1cGOPy3DF0jcrNWZ3Q1vglR2F4JUQlovj5ZpN4rneTmk
 XIJlFnQtcRCn4NQQspcXNdI+j7pJywDPlxnBE=
X-Received: by 2002:a05:620a:40d2:b0:93b:fafd:3adf with SMTP id
 af79cd13be357-93c43d0ddf0mr2282007485a.48.1790641285456; 
 Mon, 28 Sep 2026 17:21:25 -0700 (PDT)
X-Received: by 2002:a05:620a:40d2:b0:93b:fafd:3adf with SMTP id
 af79cd13be357-93c43d0ddf0mr2282003985a.48.1790641284881; 
 Mon, 28 Sep 2026 17:21:24 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c813a5ae6sm273808385a.13.2026.09.28.17.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:21:23 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Joseph Wong <joseph.wong@broadcom.com>,
 stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v3 1/5] net/bnxt: add VF ID boundary check before usage
Date: Mon, 28 Sep 2026 18:24:20 -0600
Message-ID: <20260929002424.1208457-2-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929002424.1208457-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260929002424.1208457-1-Mohammad-Shuab.Siddique@broadcom.com>
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
vf_info[] lookup. Initialize fwd_cmd/req_len to NULL/0 at
declaration so they're always safe to use on the reject path,
which also silences a GCC 8 false-positive uninitialized-variable
warning in non-debug builds. Also guard
bnxt_hwrm_reject_fwd_resp()'s memcpy() against a NULL encaped
pointer for the same reason.

Fixes: f2a768d4d186 ("net/bnxt: add completion ring")
Cc: stable@dpdk.org

Signed-off-by: Joseph Wong <joseph.wong@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_cpr.c  | 27 ++++++++++++++-------------
 drivers/net/bnxt/bnxt_hwrm.c |  3 ++-
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_cpr.c b/drivers/net/bnxt/bnxt_cpr.c
index 5c255de59e..edbfc14ec6 100644
--- a/drivers/net/bnxt/bnxt_cpr.c
+++ b/drivers/net/bnxt/bnxt_cpr.c
@@ -362,10 +362,10 @@ void bnxt_handle_fwd_req(struct bnxt *bp, struct cmpl_base *cmpl)
 {
 	struct hwrm_exec_fwd_resp_input *fwreq;
 	struct hwrm_fwd_req_cmpl *fwd_cmpl = (struct hwrm_fwd_req_cmpl *)cmpl;
-	struct input *fwd_cmd;
+	struct input *fwd_cmd = NULL;
 	uint16_t fw_vf_id;
 	uint16_t vf_id;
-	uint16_t req_len;
+	uint16_t req_len = 0;
 	int rc;
 
 	if (bp->pf->active_vfs <= 0) {
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
@@ -396,6 +386,17 @@ void bnxt_handle_fwd_req(struct bnxt *bp, struct cmpl_base *cmpl)
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
@@ -495,7 +496,7 @@ void bnxt_handle_fwd_req(struct bnxt *bp, struct cmpl_base *cmpl)
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

