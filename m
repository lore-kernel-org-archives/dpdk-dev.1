Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EB9C982EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 03:01:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD73840E25;
	Mon, 21 Sep 2026 05:01:26 +0200 (CEST)
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com
 [209.85.210.97]) by mails.dpdk.org (Postfix) with ESMTP id 6A10B40E1D
 for <dev@dpdk.org>; Mon, 21 Sep 2026 05:01:25 +0200 (CEST)
Received: by mail-ot1-f97.google.com with SMTP id
 46e09a7af769-805453b1c0cso904060a34.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789959685; x=1790564485;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0JpOf4HRhSfp0/hKwgwWRVtpL9O/e9S8DBG6FO/C7a0=;
 b=Ke5m8BN2tlvfznh515oX7H9qD0pYJzc1X8x5wsRSBYof/6C+n/LFO/b1+r1XZxgk0e
 uDmxAgzAZo+BRj+8SkAE4acl/0D4GF1IC54XSN/rfBmfzJY9vda6M0jbxYHNo4AA7od2
 VVMChsaxI+BcZX2dnvdlhyNvL/zztdIAyiYTJFUmAZ7DR+3OrOvBthWVmHgNO+ncRI5U
 yv3d1AnCBaZXe7jZ9+bHGw+GEJHRHe//pHN7NNUK9bYZBjsVsrBQuzJslcM/2JEaGxQ3
 xRrIu/T2TAOud7arPEfk0UoIU/0xkOI6Fc7jY80vI0lFWNOfSKavjRTTOb7JFOqO5T+M
 6pfQ==
X-Gm-Message-State: AFuF++nCxDaIvkHgHW2KApHNCEAaw9Fa8XTyWyPAdeYRs7Zsa4GJ1Frd
 r+V4nf/qFOVkI9rQhEYollVd7E6diznpoALHQzoHxvMO41L5J/ORsx9dLKKJj68n1K3vHJ5QzeU
 IE2V8dwX75xMKqOHRyM+pGXshcQFyl6t2VlG8zzF8R1FZ5j3R2sexCscGE12HomRBCFWeORbEXz
 ixkY5fv1Jo/9aAK0w8e9byw6OhAGspLNFaMd2OvC/uUnWaeilmQYc24Dv21RPaC9a2PBa+VUs09
 y2seuDKrXcH
X-Gm-Gg: AYBFou35qg7uCgJKEi1Di515aqFR/s1+ZWwuK51KQ/f5N7qq2FEV10BCkzGXEF1YDcC
 UvVbmXUbON2CZNbkjJdWRiKX6pRJLMfCJcI/8IuYCPOobfaxos5SS9kjDn8dYQSW2eE2o7hi793
 AS8KqsqcfBjLo73lCswDJEoOBqmQ2cA7s4t8+fcybuSLIwYdXEgLjAVm0VczozzbirOZC/a/LK+
 C2yblLGVeMTTKhDsSmyVe/TeLTJlBMDLjOXMEgGndWyKm6Hnnde55SJrb2obaicPeqjAwG0LcSp
 AkWiEJmTfDTO/N4dcQWQMaTUeWWyjExT1T42rsSyQ7PPpIbaKYMN6NQm3bIsw8XBPA+BM0y8OHi
 ycgKtRcKDnXLGc0jMcu6ukGl1YNbxF/vqGCRHU7m3/oFNiLcoDaKcBM9tIR3VK3tr+kCOqHy7cC
 5FyimyUQSueydy/Xeyd/1x28enoD647jZiV4uK3EQL7nwdqtnS9Q==
X-Received: by 2002:a05:6820:188a:b0:6b3:619f:25ce with SMTP id
 006d021491bc7-6ca9b530193mr8274583eaf.30.1789959684479; 
 Sun, 20 Sep 2026 20:01:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 006d021491bc7-6cd35427dd1sm68216eaf.16.2026.09.20.20.01.23
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 20:01:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-532d29d0976so1138821cf.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789959683; x=1790564483; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0JpOf4HRhSfp0/hKwgwWRVtpL9O/e9S8DBG6FO/C7a0=;
 b=B5T60nRFIVR6cPoQ2cE/GDSFZ6xHxgLWVY424sBTzd+UXvOFKQjeiSvlVqOw0T3EmK
 x9vcsw9f5ZATxyxVpB+44nrWqegQvV8DB9WlMPHdA4ru5XeKdIQjjxAWsxitkVmNEibM
 U8fCm9NgFB/ztrDqOI/1UtO3NdDwgGEH+qVNk=
X-Received: by 2002:a05:622a:a589:b0:532:8950:5e49 with SMTP id
 d75a77b69052e-532b7201d76mr79598831cf.29.1789959683048; 
 Sun, 20 Sep 2026 20:01:23 -0700 (PDT)
X-Received: by 2002:a05:622a:a589:b0:532:8950:5e49 with SMTP id
 d75a77b69052e-532b7201d76mr79598451cf.29.1789959682268; 
 Sun, 20 Sep 2026 20:01:22 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532ae511210sm53846021cf.2.2026.09.20.20.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 20:01:21 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 stable@dpdk.org, Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH] net/bnxt: fix VF RSS hash mode configuration
Date: Sun, 20 Sep 2026 21:04:27 -0600
Message-ID: <20260921030427.1034797-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

In bnxt_hwrm_vnic_rss_cfg_hash_mode_p5(), the VF path unconditionally
accessed vnic->fw_grp_ids[0], but fw_grp_ids is NULL when no RSS
contexts have been allocated (num_lb_ctxts == 0). The
bnxt_hwrm_vnic_rss_cfg_p5() call just before it skips its loop when
num_lb_ctxts == 0, so the NULL pointer passed through silently to
this function and caused a segfault on the next RSS hash-level
change after port stop.

A separate HWRM_VNIC_RSS_CFG call to set hash_mode on its own, with
ring_grp_tbl_addr=0 and hash_type=0, is also unsafe on P5/P7 VFs:
firmware treats those zeroes literally and wipes the ring table, so
all traffic lands on queue 0 regardless of the configured RSS level.

Set hash_mode_flags directly in bnxt_hwrm_vnic_rss_cfg_p5() for VFs
on P5/P7, translating DEFAULT to INNERMOST. Firmware now receives one
complete call per context with the ring table, hash type, and hash
mode all set together.

Embedding hash_mode_flags there alone would permanently short-circuit
the separate hash-mode call in bnxt_hwrm_vnic_rss_cfg_hash_mode_p5()
for every VF, silently dropping a trusted VF's explicit RSS
hash-level request (e.g. "rss level-outer") no matter what value was
requested. Firmware's own gate for that separate call (vnic_id ==
0xFFFF && rss_ctx_idx == 0xFFFF) explicitly permits trusted VFs, not
just PFs, to use it. So instead of skipping VFs unconditionally,
bnxt_hwrm_vnic_rss_cfg_hash_mode_p5() now only short-circuits for a
VF that is untrusted or has no initialized RSS context (fw_grp_ids/
num_lb_ctxts), and lets a trusted VF with an initialized context
reach the same call PFs already use. The per-context ring-table-wipe
fix above is unchanged either way.

Fixes: 3fd58de5a903 ("net/bnxt: fix RSS hash mode configuration for VF")
Cc: stable@dpdk.org

Signed-off-by: Farah Smith <farah.smith@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_hwrm.c | 79 +++++++++++++-----------------------
 1 file changed, 28 insertions(+), 51 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 1615b36aae..84e2aee863 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -2893,15 +2893,16 @@ bnxt_hwrm_vnic_rss_cfg_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 
 		req.vnic_id = rte_cpu_to_le_16(vnic->fw_vnic_id);
 		req.hash_type = rte_cpu_to_le_32(bnxt_sanitize_rss_type(bp, vnic->hash_type));
-		/* Update req with vnic ring_select_mode for P7 */
 		if (BNXT_CHIP_P7(bp))
 			req.ring_select_mode = vnic->ring_select_mode;
-		/* When the vnic_id in the request field is a valid
-		 * one, the hash_mode_flags in the request field must
-		 * be set to DEFAULT. And any request to change the
-		 * default behavior must be done in a separate call
-		 * to HWRM_VNIC_RSS_CFG by exclusively setting hash
-		 * mode and vnic_id, rss_ctx_idx to INVALID.
+
+		/* Do not embed hash_mode_flags here for VFs. Doing so, plus
+		 * syncing prev_hash_mode below, permanently short-circuits
+		 * bnxt_hwrm_vnic_rss_cfg_hash_mode_p5()'s guard for every VF,
+		 * so a trusted VF's explicit RSS hash-level request (e.g.
+		 * rss level-outer) is silently dropped. Firmware's own gate
+		 * (vnic_rss_cfg_cmd()) permits trusted VFs on that call, so
+		 * treat VFs the same as PFs here.
 		 */
 		req.hash_mode_flags = BNXT_HASH_MODE_DEFAULT;
 
@@ -2930,70 +2931,46 @@ static int
 bnxt_hwrm_vnic_rss_cfg_hash_mode_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 {
 	struct hwrm_vnic_rss_cfg_output *resp = bp->hwrm_cmd_resp_addr;
-	struct hwrm_vnic_rss_cfg_input req = {.req_type = 0 };
+	struct hwrm_vnic_rss_cfg_input req = {.req_type = 0};
 	int rc = 0;
 
-	/* The reason we are returning success here is that this
-	 * call is in the context of user/stack RSS configuration.
-	 * Even though OUTER RSS is not supported, the normal RSS
-	 * configuration should continue to work.
-	 */
+	/* Return success when outer RSS is unsupported so normal RSS works. */
 	if ((BNXT_CHIP_P5(bp) && BNXT_VNIC_OUTER_RSS_UNSUPPORTED(bp)) ||
 	    (!BNXT_CHIP_P5(bp) && !(bp->vnic_cap_flags & BNXT_VNIC_CAP_OUTER_RSS)))
 		return 0;
 
-	/* TODO Revisit for Thor 2 */
-	/* if (BNXT_CHIP_P5_P7(bp))
-	 *	bnxt_hwrm_vnic_rss_cfg_p5(bp, vnic);
-	 */
-	/* Don't call RSS hash level configuration if the current
-	 * hash level is the same as the hash level that is requested.
-	 */
 	if (vnic->prev_hash_mode == vnic->hash_mode)
 		return 0;
 
+	/* Trusted VFs now reach this call the same as PFs; firmware's own
+	 * gate (IS_PF_FID() || pcie_func_is_trusted_vf()) restricts which
+	 * callers it accepts the request from. Firmware would reject a
+	 * request from an untrusted VF, so keep it a silent no-op here
+	 * instead of surfacing a new HWRM error.
+	 * The fw_grp_ids/num_lb_ctxts check guards against a NULL RSS
+	 * context that is not yet initialized or has been torn down by
+	 * a port stop.
+	 */
+	if (BNXT_VF(bp) &&
+	    (!BNXT_VF_IS_TRUSTED(bp) || !vnic->fw_grp_ids || !vnic->num_lb_ctxts))
+		return 0;
+
 	HWRM_PREP(&req, HWRM_VNIC_RSS_CFG, BNXT_USE_CHIMP_MB);
 
-	/* For FW, hash_mode == DEFAULT means that
-	 * the FW is capable of doing INNER & OUTER RSS as well.
-	 * DEFAULT doesn't mean that the FW is
-	 * going to change the hash_mode to INNER. However, for
-	 * the USER, DEFAULT means, change the hash mode to the
-	 * NIC's DEFAULT hash mode which is INNER.
-	 *
-	 * Hence, driver should make the translation of hash_mode
-	 * to INNERMOST when hash_mode from the dpdk stack is
-	 * DEFAULT.
+	/* FW DEFAULT keeps existing hash level; translate to INNERMOST so
+	 * the NIC uses its hardware default (inner headers).
 	 */
 	if (vnic->hash_mode == BNXT_HASH_MODE_DEFAULT)
 		req.hash_mode_flags = BNXT_HASH_MODE_INNERMOST;
 	else
 		req.hash_mode_flags = vnic->hash_mode;
 
-	/* VFs must use actual vnic_id for per-VNIC configuration.
-	 * PFs can use INVALID vnic_id for global configuration.
-	 * This is because VFs don't have permission to configure
-	 * global hash mode, even if they're trusted.
-	 */
-	if (BNXT_VF(bp)) {
-		req.vnic_id = rte_cpu_to_le_16(vnic->fw_vnic_id);
-		req.rss_ctx_idx = rte_cpu_to_le_16(vnic->fw_grp_ids[0]);
-		PMD_DRV_LOG_LINE(DEBUG, "VF using per-VNIC RSS config (vnic_id=%u)",
-				vnic->fw_vnic_id);
-	} else {
-		req.vnic_id = rte_cpu_to_le_16(BNXT_DFLT_VNIC_ID_INVALID);
-		req.rss_ctx_idx = rte_cpu_to_le_16(BNXT_RSS_CTX_IDX_INVALID);
-		PMD_DRV_LOG_LINE(DEBUG, "PF using global RSS config");
-	}
-
+	req.vnic_id = rte_cpu_to_le_16(BNXT_DFLT_VNIC_ID_INVALID);
+	req.rss_ctx_idx = rte_cpu_to_le_16(BNXT_RSS_CTX_IDX_INVALID);
 	PMD_DRV_LOG_LINE(DEBUG, "RSS CFG: Hash level %d", req.hash_mode_flags);
-	rc = bnxt_hwrm_send_message(bp, &req, sizeof(req),
-				    BNXT_USE_CHIMP_MB);
+	rc = bnxt_hwrm_send_message(bp, &req, sizeof(req), BNXT_USE_CHIMP_MB);
 
 	HWRM_CHECK_RESULT();
-	/* Store the programmed hash_mode in prev_hash_mode so that
-	 * it can checked against the next user requested hash mode.
-	 */
 	if (!rc)
 		vnic->prev_hash_mode = vnic->hash_mode;
 	HWRM_UNLOCK();
-- 
2.47.3

