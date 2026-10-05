Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DCECA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 15:17:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D11740B99;
	Mon,  5 Oct 2026 17:17:29 +0200 (CEST)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTP id 5351840B9D
 for <dev@dpdk.org>; Mon,  5 Oct 2026 17:17:27 +0200 (CEST)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-398a5aad413so1273224a91.3
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791213446; x=1791818246;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=l4RataG0jl9Y5ot6IXmb8YXJcGwgPGHBLx2PyDxlpv8=;
 b=ddd44ZHOrA9KPe/RMMbYLiy5rk72fLgwuOVBnNoXdO+JEMBXGG6PQbanTEzCi2W6Mq
 R3Bzglo1tpmPYb3lUtvcBlcQ2xCu7YLpZ5nM2taaWZ9w5Mao6YiXIxBYjr8LVQfYFDSJ
 CbRR1jxwxlSzFqfPqdePPrzKozimrLZ6qP5YHMxyrwgYrYL8UkiKwhXcmk5c4eu9JFdM
 Yrh90XsTaa/NDN1OxNpiOV0dqda2lsjZFLDSTYY7IJllGh9JiWObYFqfV51bPHU37Fcb
 KyN2u2CuVYi98LpImf/LpB07jxkVL3IXtRJNR/TT/Is2F7vjgHsETZW422FR6WLUCm7a
 3maA==
X-Gm-Message-State: AFq9FYJDjS+XBfWxUeEl/cWhPFNPB2qoEnbbPt09jVLU7wHS/ioXF8hI
 9ZkKTrVlyel2u+g0CXhBP07nBiaXtPcTnDjQHPfZF8RkfHUvZy8XBLxpriFLEFV3oQ/vseZXF/G
 jUoaBMRbUmBM6LGQJM99nbx+MA0083B8YlhqCJnQCfONOS/lk/cnxe2eUZ2X+G6q8BjKLjnp5c3
 5W0keeePD8juY8FSpe/kkRXchUrGZWd1eT8vyPr0xvOBYgUB4S9qTIeKni//JQPOAj37b1pA==
X-Gm-Gg: AYBFou0CITbaF8Ia6NyXqeUM6wBPjlgP842egMRaylST77Xlqk/YOqPkeRSfCIrSLKC
 SfLVRpGG2TNUg4na80Rbel5S4Z7IWPxGYngOSYUyuZjRMRNG6r6fGzpKd/obBuDPfwrrb4bfysO
 ipJaxdMTlvhNQzUalk9G3ThZynoBOvUmL10N3EHraU59/SRbv5giQa5ttMxpMc+UDvfKe5sOUlN
 WNMLW0o+aCSfr2G8tLWd5eswiyRsNiGy84sqFLX8OAHGRWJslNzfgWTlmee6z+/H3KcU+7D3dB6
 fIaMfcp38qlWU19GqpxRH0AR23HnTucvXi2Hfax92O8WnvAng1B0dw2WEbwrwr8LN2F9SA4ehz5
 5xQgZtk60CT80I0mHcXM2sxGpPMnnC4U0uQEb0LWr6m2nRc9MwvL+Ggn4XZm09nLMfFJgd9ivjn
 BnfGgllmHIKGXPAdWo3Wgsm6TyV3lRmaRXgPj0uA==
X-Received: by 2002:a17:90b:388b:b0:3a0:7cbf:b8d2 with SMTP id
 98e67ed59e1d1-3a78717dcedmr6576945a91.10.1791213446225; 
 Mon, 05 Oct 2026 08:17:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a78e4a18e2sm4705622a91.7.2026.10.05.08.17.25
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 08:17:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-535294e0f64so22625351cf.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791213445; x=1791818245; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l4RataG0jl9Y5ot6IXmb8YXJcGwgPGHBLx2PyDxlpv8=;
 b=iQyf9x17S6mGmsoedfbN3gOxsV6YiF6nXxqvdny8x2od2SFn661QdriDxOYnj1lxbr
 /UoNyWtN+Be38OjaVk1Rsx17ZCO+noe70tbB/MRDyz76tFVtwAlvYGi7N3TuIQwJBaS2
 CUFBXCphSvPEcuqWbhoIDyDrUtHE0834asj0I=
X-Received: by 2002:a05:622a:c85:b0:532:cacd:e420 with SMTP id
 d75a77b69052e-53511b4c991mr130687451cf.6.1791213444738; 
 Mon, 05 Oct 2026 08:17:24 -0700 (PDT)
X-Received: by 2002:a05:622a:c85:b0:532:cacd:e420 with SMTP id
 d75a77b69052e-53511b4c991mr130686681cf.6.1791213444069; 
 Mon, 05 Oct 2026 08:17:24 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53398d59747sm101423611cf.31.2026.10.05.08.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 08:17:23 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
	stable@dpdk.org
Subject: [PATCH] net/bnxt: fix multiple truflow defects
Date: Mon,  5 Oct 2026 10:17:20 -0500
Message-Id: <20261005151720.1706054-1-manish.kurup@broadcom.com>
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

Fix seven unrelated defects found across the tf_core and tf_ulp
message/table/resource-management code:

1. tf_ulp: fix blob overflow in Thor2 EM key build
   ulp_blob_pad_push() in ulp_mapper_tfc_em_tbl_process() was called
   without checking the return value. If a dynamic EM key length
   plus block-alignment padding exceeded 1024 bits, write_idx would
   advance past bitlen and the subsequent ulp_blob_append() would
   write past the end of the blob.

2. tf_core: fix tcam alloc_set memcpy args
   tfc_msg_tcam_alloc_set() had two bugs in the memcpy calls packing
   key, mask, and remap into the HWRM request: source was
   &key/&mask/&remap (address of the local pointer) instead of
   key/mask/remap (the data), and the length used key_size *
   sizeof(u32) when key_size is already a byte count, making each
   copy 4x oversized and overrunning the buffer.

3. tf_core: fix RM resource leak in tf_sram_mgr_alloc
   When tf_sram_alloc_block() failed to allocate a block struct, the
   function returned -ENOMEM without releasing the RM index(es) just
   claimed via tf_rm_allocate() - both the primary index and, when a
   second sequential 64B block was also claimed, that second index -
   leaving them permanently marked in-use in the bitalloc pool.

4. tf_core: validate FW TCAM response offsets before memcpy
   In tf_msg_tcam_entry_get(), firmware-supplied key_size and
   result_offset/result_size were used as indices into the
   dev_data[] response array without range checks. A malformed FW
   response could cause out-of-bounds reads.

5. tf_core: fix memory leak of query buffer in tf_rm_create_db
   The query buffer allocated at the start of tf_rm_create_db() was
   freed on all error paths but not on the success return path,
   leaking memory on every successful call.

6. tf_core: fix buffer overflow in tf_msg_get_global_cfg
   The memcpy copying global-cfg data back to the caller used the
   HWRM resp_size as the copy length. The existing lower-bound check
   only ensures the FW returned enough data; it does not prevent a
   larger resp_size from overflowing the caller's buffer. Copy only
   params->config_sz_in_bytes instead.

7. net/bnxt: fix double-free of TPM in tbl_scope_pools_create
   After cfa_tim_tpm_inst_set() succeeds, ownership of the TPM
   transfers to TIM, but tpms[dir][region] was never cleared. On any
   subsequent failure the cleanup loop would free the TPM again,
   causing a UAF inside cfa_tpm_close() and a double-free on
   rte_free(). Null out tpms[dir][region] after a successful set to
   mark ownership as transferred.

Fixes: dd0191d5e70d ("net/bnxt/tf_ulp: support Thor2 ULP layer")
Fixes: 80317ff6adfd ("net/bnxt/tf_core: support Thor2")
Fixes: 37ff91c158a3 ("net/bnxt: add SRAM manager model")
Fixes: a9597be79f66 ("net/bnxt: support L2 context TCAM operations")
Fixes: a11f87d3b2ca ("net/bnxt: add global config set and get functions")
Fixes: ced3cded4492 ("net/bnxt: update table get to use new design")
Cc: stable@dpdk.org

Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_core/tf_msg.c           | 12 +++++++++++-
 drivers/net/bnxt/tf_core/tf_rm.c            |  1 +
 drivers/net/bnxt/tf_core/tf_sram_mgr.c      | 17 +++++++++++++++++
 drivers/net/bnxt/tf_core/v3/tfc_msg.c       |  6 +++---
 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c |  1 +
 drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c    |  5 ++++-
 6 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/tf_msg.c b/drivers/net/bnxt/tf_core/tf_msg.c
index 645a4b1e66..c6b661824d 100644
--- a/drivers/net/bnxt/tf_core/tf_msg.c
+++ b/drivers/net/bnxt/tf_core/tf_msg.c
@@ -1243,6 +1243,16 @@ tf_msg_tcam_entry_get(struct tf *tfp,
 			    strerror(-rc));
 		return rc;
 	}
+	if (resp.key_size * 2 > sizeof(resp.dev_data) ||
+	    resp.result_offset + resp.result_size > sizeof(resp.dev_data)) {
+		rc = -EINVAL;
+		TFP_DRV_LOG(ERR,
+			    "%s: FW data out of bounds key_size(%d) result_offset(%d) result_size(%d), rc:%s\n",
+			    tf_dir_2_str(parms->dir), resp.key_size,
+			    resp.result_offset, resp.result_size,
+			    strerror(-rc));
+		return rc;
+	}
 	parms->key_size = resp.key_size;
 	parms->result_size = resp.result_size;
 	tfp_memcpy(parms->key, resp.dev_data, resp.key_size);
@@ -1552,7 +1562,7 @@ tf_msg_get_global_cfg(struct tf *tfp,
 	if (params->config)
 		tfp_memcpy(params->config,
 			   resp.data,
-			   resp_size);
+			   params->config_sz_in_bytes);
 	else
 		return -EFAULT;
 
diff --git a/drivers/net/bnxt/tf_core/tf_rm.c b/drivers/net/bnxt/tf_core/tf_rm.c
index 18f46c0a0a..a99eb68e59 100644
--- a/drivers/net/bnxt/tf_core/tf_rm.c
+++ b/drivers/net/bnxt/tf_core/tf_rm.c
@@ -721,6 +721,7 @@ tf_rm_create_db(struct tf *tfp,
 	rm_db->module = parms->module;
 	*parms->rm_db = (void *)rm_db;
 
+	tfp_free((void *)query);
 	tfp_free((void *)req);
 	tfp_free((void *)resv);
 	tfp_free((void *)req_cnt);
diff --git a/drivers/net/bnxt/tf_core/tf_sram_mgr.c b/drivers/net/bnxt/tf_core/tf_sram_mgr.c
index 0dffd74cd5..654d273baa 100644
--- a/drivers/net/bnxt/tf_core/tf_sram_mgr.c
+++ b/drivers/net/bnxt/tf_core/tf_sram_mgr.c
@@ -710,6 +710,23 @@ int tf_sram_mgr_alloc(void *sram_handle,
 		}
 		block_id = index;
 		block = tf_sram_alloc_block(slice_list, block_id);
+		if (!block) {
+			fparms.rm_db = parms->rm_db;
+			fparms.subtype = parms->tbl_type;
+			fparms.index = block_id;
+			rc = tf_rm_free(&fparms);
+			if (rc)
+				TFP_DRV_LOG(ERR,
+					    "Free block_id(%d) failed rc:%d\n",
+					    block_id, rc);
+			fparms.index = next_index;
+			rc = tf_rm_free(&fparms);
+			if (rc)
+				TFP_DRV_LOG(ERR,
+					    "Free block_id(%d) failed rc:%d\n",
+					    next_index, rc);
+			return -ENOMEM;
+		}
 
 	} else {
 		/* Block exists
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_msg.c b/drivers/net/bnxt/tf_core/v3/tfc_msg.c
index cf72d09184..81ef289c50 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_msg.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_msg.c
@@ -1064,9 +1064,9 @@ tfc_msg_tcam_alloc_set(struct tfc *tfcp, uint16_t fid, uint16_t sid,
 		data = &req.dev_data[0];
 	}
 
-	memcpy(&data[0], &key, key_size * sizeof(uint32_t));
-	memcpy(&data[key_size], &mask, key_size * sizeof(uint32_t));
-	memcpy(&data[key_size * 2], &remap, remap_size * sizeof(uint32_t));
+	memcpy(&data[0], key, key_size);
+	memcpy(&data[key_size], mask, key_size);
+	memcpy(&data[key_size * 2], remap, remap_size);
 	rc = bnxt_hwrm_tf_message_direct(bp, false, HWRM_TFC_TCAM_ALLOC_SET,
 					 &req, sizeof(req), &resp, sizeof(resp));
 
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
index c06099af12..f6dba101aa 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
@@ -631,6 +631,7 @@ static int tbl_scope_pools_create(struct tfc *tfcp, uint8_t tsid,
 			rc = cfa_tim_tpm_inst_set(tim, tsid, region, dir, tpms[dir][region]);
 			if (rc)
 				goto cleanup;
+			tpms[dir][region] = NULL;
 		}
 	}
 
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
index 2d89f10d5e..f02837bf5d 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
@@ -517,7 +517,10 @@ ulp_mapper_tfc_em_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 		align_len_bits = dparms->em_blk_align_bits - key_len;
 	}
 
-	ulp_blob_pad_push(&key, align_len_bits);
+	if (ulp_blob_pad_push(&key, align_len_bits) < 0) {
+		PMD_DRV_LOG_LINE(ERR, "Failed to pad EM key");
+		return -EINVAL;
+	}
 	key_len = ULP_BITS_2_BYTE(ulp_blob_data_len_get(&key));
 	ulp_blob_perform_byte_reverse(&key, key_len);
 	/* Create the result data blob */
-- 
2.31.1

