Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECCAC982EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 02:17:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18BE840E17;
	Mon, 21 Sep 2026 04:17:06 +0200 (CEST)
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com
 [209.85.160.98]) by mails.dpdk.org (Postfix) with ESMTP id 85076402A4
 for <dev@dpdk.org>; Mon, 21 Sep 2026 04:17:02 +0200 (CEST)
Received: by mail-oa1-f98.google.com with SMTP id
 586e51a60fabf-46fdd5884d0so43149fac.0
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789957022; x=1790561822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZHtRuG01ev2GO7v8F6NktWewTngDDJ3/HCaHVYOXTGs=;
 b=PWBHFMCmvwF59MjbBVwy7LLSuioWEoGTPZD2sbpOKp5arMCWN08Kl8V6A3sCDH4QFC
 iMYWaxocPgT4kV+elB9TPWmUpqnalDcdD9JtKRpLLgFp5MfLA/7nTuBZEOQlc9lKP6ZQ
 PuSA9FuMPbq93pVNrH7wIHN8LpjJSp2+RnjAdySLr8pOoQeNLsJsLG6E52VK2jDlxXNb
 rmw8V8a5TpVgJ1lH8p2mjKjeoLGmtlXcPvND/CS898k2zi8anNFR/PAhCpbaiuMl8zMm
 jd/R99JwG3QGMf4Na06fSZWUIG/Cy5vqfXvkE/S8diuymbE3v8mZinsXSll0Nl7zuSrx
 NXxA==
X-Gm-Message-State: AFuF++lYoLpXdyl3FyNjCRQPAtMDXxG4z0fdOOjskndrNaEoeJ/c7Lhk
 yTVuepXtYswH6TFcwgyXjFtxNA9PdDEBn6UZ+QlyZCK64fGnaSD6cM625Lq/by5GoLtRq/R9uEu
 3CeDw8iYt5JRtPbgJbJBg0fo6/hkJoR8MUswN74kDkjPc7blVca4nFeqNG0B1QH7tpFV4a40WZ2
 +2ct0B4kq3Nnb2AGksr4bccWAAh6XsFVUgZ9QNqTdTH0dX0NejDfjOw11Qdwn68THDH+Xgq8X97
 92p3AIrL+aI
X-Gm-Gg: AYBFou1THmU+eAxw4X9EMN/6lfueTLEP2IwDfZazB0iUaTUJ/OJ2LSTW2S6A1B3jl+A
 k6oqvK4wfAmryzAQOJxBGWvrdMKZ81k2Cl4nm8bJWOooP7CT7qcOg3AGGwR1sz9Um7cp18NyQLe
 Vd4Wgrwu+f6tOKsW5usmZ7jkmkzvBkN5ojjv2qXTV7jJ6K/TsWMw22Hdt7QOi4E21Ba2vlvPcq7
 vC2GPJigFUQhfkvFTFAQlK3Ro5oR31sh7M7FLfiFN0oaJdCnewBzVP7IrVsbMU3Da0nuJvYHgng
 A4kEHB0jngurt3Y/kDvQEUrB10QBW+aV4MG+xdWlDwvYeuccXy7w5GDunH73du6O5Rp4WSuXXDo
 DxjloFhIhZzAgxx8y/XyF4rzPGTy6d6xdjLUBK2NGq1+JI9vCIS2YCRX0Qh9v6xL+RX476hZmQo
 qcF5ns08uVhuutsJWnwta1ownJw+hrUHwDAH1wg9cQ2ZGiw/e17g==
X-Received: by 2002:a4a:ec45:0:b0:6c2:10e7:e044 with SMTP id
 006d021491bc7-6ca9d54ea7dmr8777272eaf.64.1789957021571; 
 Sun, 20 Sep 2026 19:17:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
 by smtp-relay.gmail.com with ESMTPS id
 006d021491bc7-6cd34c3c73asm71317eaf.13.2026.09.20.19.17.00
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 19:17:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc1eb205d31so3531791a12.2
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789957020; x=1790561820; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZHtRuG01ev2GO7v8F6NktWewTngDDJ3/HCaHVYOXTGs=;
 b=a48DCodwWzMmVUdJKWmRMbCV8XVCY5DI10tdifWpjmUxRA93hfTrhwiveGv/2VaofJ
 4wgaMkEEFSmm3Ssu9CxxlQznLuus4HQiXKSYr9Ga6jZ/yEPej5pXvc+I2lel12cyfIuW
 Ze49pX3qXhSa7TIRP8g0ui+ZCwAnC+tWskNV8=
X-Received: by 2002:a05:6300:14c:b0:3da:4cc6:17d3 with SMTP id
 adf61e73a8af0-3dd8c57c621mr15868850637.26.1789957019725; 
 Sun, 20 Sep 2026 19:16:59 -0700 (PDT)
X-Received: by 2002:a05:6300:14c:b0:3da:4cc6:17d3 with SMTP id
 adf61e73a8af0-3dd8c57c621mr15868819637.26.1789957019205; 
 Sun, 20 Sep 2026 19:16:59 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c331d55cfsm18536753eec.30.2026.09.20.19.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 19:16:58 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Joseph Wong <joseph.wong@broadcom.com>,
 stable@dpdk.org, Mohammad Shuab Siddique <shuab.siddique@broadcom.com>
Subject: [PATCH v2 1/5] net/bnxt: add VF ID boundary check before usage
Date: Sun, 20 Sep 2026 20:19:58 -0600
Message-ID: <20260921022002.1033815-2-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921022002.1033815-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921022002.1033815-1-Mohammad-Shuab.Siddique@broadcom.com>
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
Signed-off-by: Mohammad Shuab Siddique <shuab.siddique@broadcom.com>

---
v2:
* Initialize fwd_cmd/req_len at declaration instead of only on the
  reject path, removing the now-redundant explicit reset there. This
  also silences a GCC 8 false-positive uninitialized-variable warning
  in non-debug builds (reported independently after v1).
---
 drivers/net/bnxt/bnxt_cpr.c  | 27 ++++++++++++++-------------
 drivers/net/bnxt/bnxt_hwrm.c |  3 ++-
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_cpr.c b/drivers/net/bnxt/bnxt_cpr.c
index 5c255de59ea..edbfc14ec60 100644
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
index a2b0c280353..2b45f05bae9 100644
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

