Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7BBCCD1B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 19:03:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3061F4278F;
	Tue, 21 Oct 2025 21:03:08 +0200 (CEST)
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com
 [209.85.210.226])
 by mails.dpdk.org (Postfix) with ESMTP id 4B24140A84
 for <dev@dpdk.org>; Tue, 21 Oct 2025 21:03:06 +0200 (CEST)
Received: by mail-pf1-f226.google.com with SMTP id
 d2e1a72fcca58-7811fa91774so5339409b3a.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 12:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073385; x=1761678185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D2y+ASx4MlhC9Btr2Y5TM2XT4VoyEx6wcDs5GvFl2YY=;
 b=JkHAw40dGCEbpk+JLCuGHHpp1TXxwRTGGAS2eSebO+ua6szVBNCv3yh3lKpw8QxgY2
 NuMrMoy3Yds4oFXqg3OBW3eGMr64w748aqZqEqZMiYY+tSZLAVy4eymV5uryIaAnFN2P
 GC5QYmMBIO9JFpNC7lITx9lVqdmBm34AiE0MoHgpo5jJtkg+LBxvRncYx1Mlp8J1AyU1
 JhGht1C4yDsKmR93Lf2LJexPgtQNkxdTtcf96XpM1x2z/R2q1SIcQ6rRtkKAZCoKla2I
 7om5ZLHJxuO8GNZQLUBzQpA4+QnGPsIno59CEENN5CPcm0H0uKfFZHCfx+cQEGDQo/py
 qmjQ==
X-Gm-Message-State: AOJu0YyMvvKps6frCec7d3CzxAE3pO5nTO7P5xxxS8uVAD31M1LMNCz7
 TiRY1ZIW1OOQVhteU/8Z+Uvd0XtdZ+qYnqyBfjbg3U+3OxsgYZdsiIrgaMTAXKEhBI47QqIaPJR
 tJB+lhAWYg9J8Q10SEGoaIbyDspTBHFw58L9TvT8wiTYUa/O+ryrTMDjl2W6xo5aH8nXZ4/UF3/
 JzGdXXSXyOacdWLAk7UE+sGDYvyPrSUlwBx7CJjv+US/7AAVLEQJoPQh9Xc+vl3ynO2YcI2w==
X-Gm-Gg: ASbGncuVGwBknosEgyJfSVtVavr1tR6qyUWRwbAgHWcJuniAP4tEojxV2TjV6wkdzJQ
 XiwqCWiM0DLoQ2tuzocrcNTqcqAlIHcOYMGHjywxtEpEi4dOekqBlPmiUPDJk4SthGZYZCBIE/A
 ko3aFCbbVgjsSYs5CkpL/RAPvopHa/s0fZItGtI06v7HXsvxIZU+ZV+9/L6/Jitaz0gM553EJsX
 vtx9NGQY27PRxVa7WwKxh4hRYyU3NtyXvUCE/o80TBL3nbJVColWogF1J5dxWxGuXpmLO+LNIYR
 j3kMij+R832Cwa8swl2UfXimtIbjX6LfuCtf8ordfOe8cbb4BQLbSpkaSxpS8ttUUplh3KrowLw
 vsErXsmsVFpgGHQstcVHaB2HzVXp0SBn7rOYTBAF7tFpIch2rRFY9JAJcZQw09AOe4rwwxeyZ24
 CPv7jrrPrHosZiD0GG0Q5Lnhlngj4qtVZAqg==
X-Google-Smtp-Source: AGHT+IH0X1dR/QoL8lCzBrtxNeCDeK4OWGJ2kec/yyuMBx8Sz//7uCpRlHvv6zliK0BuP7YJ0QbaLDusg3yz
X-Received: by 2002:a05:6a00:2e12:b0:781:d163:ce41 with SMTP id
 d2e1a72fcca58-7a2208f1472mr20028948b3a.11.1761073385265; 
 Tue, 21 Oct 2025 12:03:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 d2e1a72fcca58-7a2300e0576sm1475168b3a.10.2025.10.21.12.03.04
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 12:03:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7a264d65dbeso116387b3a.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 12:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761073383; x=1761678183; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D2y+ASx4MlhC9Btr2Y5TM2XT4VoyEx6wcDs5GvFl2YY=;
 b=gUwxdUPN4S9DwR2ikV7kTJWJ08XF4l/l1zOWWar7I4XBwr/ChvX82j8UcqKnH3m+jp
 1Y/BNg92Snyq0iw5h2RBzeurB2uuezbI4b3GVfToxterxFxkzmMMI3oHXiE8IyRVWtMb
 40cbkKrvsQTh9tyzy39lx6sJSdMBxkNgI/OQg=
X-Received: by 2002:a05:6a00:94ce:b0:771:fa65:ae6e with SMTP id
 d2e1a72fcca58-7a220a99177mr25506881b3a.17.1761073382860; 
 Tue, 21 Oct 2025 12:03:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:94ce:b0:771:fa65:ae6e with SMTP id
 d2e1a72fcca58-7a220a99177mr25506810b3a.17.1761073382086; 
 Tue, 21 Oct 2025 12:03:02 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a2300f256dsm12011019b3a.50.2025.10.21.12.03.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 12:03:01 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com
Subject: [PATCH v4 57/57] net/bnxt/tf_ulp: remove Truflow DEBUG code
Date: Tue, 21 Oct 2025 15:01:58 -0400
Message-Id: <20251021190158.74064-5-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021190158.74064-1-manish.kurup@broadcom.com>
References: <20251021190158.74064-1-manish.kurup@broadcom.com>
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

This commit cleans up TruFlow debug/non-production prints

Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/bnxt_hwrm.c               | 23 -------
 drivers/net/bnxt/tf_ulp/bnxt_tf_common.h   |  5 --
 drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c |  6 --
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c      |  5 --
 drivers/net/bnxt/tf_ulp/ulp_alloc_tbl.c    |  4 --
 drivers/net/bnxt/tf_ulp/ulp_def_rules.c    |  6 --
 drivers/net/bnxt/tf_ulp/ulp_flow_db.c      |  6 --
 drivers/net/bnxt/tf_ulp/ulp_mapper.c       | 38 ------------
 drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c    | 71 ----------------------
 drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c   | 71 ----------------------
 drivers/net/bnxt/tf_ulp/ulp_matcher.c      |  9 ---
 11 files changed, 244 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 939f35e3da..4d693da1d5 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -2868,29 +2868,6 @@ static uint32_t bnxt_sanitize_rss_type(struct bnxt *bp, uint32_t types)
 	return hwrm_type;
 }
 
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-static int
-bnxt_hwrm_vnic_rss_qcfg_p5(struct bnxt *bp)
-{
-	struct hwrm_vnic_rss_qcfg_output *resp = bp->hwrm_cmd_resp_addr;
-	struct hwrm_vnic_rss_qcfg_input req = {0};
-	int rc;
-
-	HWRM_PREP(&req, HWRM_VNIC_RSS_QCFG, BNXT_USE_CHIMP_MB);
-	/* vnic_id and rss_ctx_idx must be set to INVALID to read the
-	 * global hash mode.
-	 */
-	req.vnic_id = rte_cpu_to_le_16(BNXT_DFLT_VNIC_ID_INVALID);
-	req.rss_ctx_idx = rte_cpu_to_le_16(BNXT_RSS_CTX_IDX_INVALID);
-	rc = bnxt_hwrm_send_message(bp, &req, sizeof(req),
-				    BNXT_USE_CHIMP_MB);
-	HWRM_CHECK_RESULT();
-	HWRM_UNLOCK();
-	PMD_DRV_LOG_LINE(DEBUG, "RSS QCFG: Hash level %d", resp->hash_mode_flags);
-
-	return rc;
-}
-#endif
 
 static int
 bnxt_hwrm_vnic_rss_cfg_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic)
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_tf_common.h b/drivers/net/bnxt/tf_ulp/bnxt_tf_common.h
index 7fc70a3603..8e487d9a0e 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_tf_common.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_tf_common.h
@@ -14,11 +14,6 @@
 #define BNXT_DRV_DBG(lvl, fmt, ...) \
 	RTE_LOG(lvl, BNXT, "%s(): " fmt, __func__, ## __VA_ARGS__)
 
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#define BNXT_DRV_INF(fmt, ...)	RTE_LOG(INFO, fmt, ## __VA_ARGS__)
-#else
-#define BNXT_DRV_INF(fmt, ...)
-#endif
 
 #define BNXT_ULP_EM_FLOWS			8192
 #define BNXT_ULP_1M_FLOWS			1000000
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c b/drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c
index 5854f13447..bfd5f4b230 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c
@@ -16,9 +16,6 @@
 #include "bnxt_hwrm.h"
 #include "bnxt_tf_common.h"
 #include "bnxt_tf_pmd_shim.h"
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#include "ulp_template_debug_proto.h"
-#endif
 
 
 int
@@ -617,9 +614,6 @@ bnxt_pmd_global_tunnel_set(struct bnxt_ulp_context *ulp_ctx,
 			    port_id, rc);
 		return rc;
 	}
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-	ulp_mapper_global_register_tbl_dump(type, udp_port);
-#endif
 	if (udp_port)
 		bnxt_pmd_global_reg_data_to_hndl(port_id, lupar_id,
 						 type, udp_port, handle);
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
index d2d97d9cf0..38cb5c8b31 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
@@ -948,11 +948,6 @@ ulp_tf_eem_tbl_scope_init(struct bnxt *bp)
 		return rc;
 	}
 
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-	BNXT_DRV_DBG(DEBUG, "TableScope=0x%0x %d\n",
-		     params.tbl_scope_id,
-		     params.tbl_scope_id);
-#endif
 
 	rc = bnxt_ulp_cntxt_tbl_scope_id_set(bp->ulp_ctx, params.tbl_scope_id);
 	if (rc) {
diff --git a/drivers/net/bnxt/tf_ulp/ulp_alloc_tbl.c b/drivers/net/bnxt/tf_ulp/ulp_alloc_tbl.c
index f09d072ef3..ac83e42514 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_alloc_tbl.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_alloc_tbl.c
@@ -10,10 +10,6 @@
 #include "ulp_alloc_tbl.h"
 #include "bnxt_ulp_utils.h"
 
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#include "ulp_template_debug_proto.h"
-#include "ulp_tf_debug.h"
-#endif
 
 /* Retrieve the allocator table  initialization parameters for the tbl_idx */
 static const struct bnxt_ulp_allocator_tbl_params*
diff --git a/drivers/net/bnxt/tf_ulp/ulp_def_rules.c b/drivers/net/bnxt/tf_ulp/ulp_def_rules.c
index 4d96882087..8ff3c24993 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_def_rules.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_def_rules.c
@@ -960,12 +960,6 @@ bnxt_ulp_grp_miss_act_set(struct rte_eth_dev *dev,
 	/* Perform the rte flow post process */
 	bnxt_ulp_rte_parser_post_process(&params);
 
-#ifdef	RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef	RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_PARSER
-	/* Dump the rte flow action */
-	ulp_parser_act_info_dump(&params);
-#endif
-#endif
 
 	ret = ulp_matcher_action_match(&params, &params.act_tmpl);
 	if (unlikely(ret != BNXT_TF_RC_SUCCESS))
diff --git a/drivers/net/bnxt/tf_ulp/ulp_flow_db.c b/drivers/net/bnxt/tf_ulp/ulp_flow_db.c
index 46f5a96baf..57f11d02ae 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_flow_db.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_flow_db.c
@@ -532,9 +532,6 @@ ulp_flow_db_fid_alloc(struct bnxt_ulp_context *ulp_ctxt,
 	if (flow_type == BNXT_ULP_FDB_TYPE_REGULAR)
 		ulp_flow_db_func_id_set(flow_db, *fid, func_id);
 
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-	BNXT_DRV_DBG(DEBUG, "flow_id = %u:%u allocated\n", flow_type, *fid);
-#endif
 	/* return success */
 	return 0;
 }
@@ -805,9 +802,6 @@ ulp_flow_db_fid_free(struct bnxt_ulp_context *ulp_ctxt,
 	if (flow_type == BNXT_ULP_FDB_TYPE_REGULAR)
 		ulp_flow_db_func_id_set(flow_db, fid, 0);
 
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-	BNXT_DRV_DBG(DEBUG, "flow_id = %u:%u freed\n", flow_type, fid);
-#endif
 	/* all good, return success */
 	return 0;
 }
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper.c b/drivers/net/bnxt/tf_ulp/ulp_mapper.c
index 9cda3b355b..0ff952950b 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper.c
@@ -653,12 +653,6 @@ ulp_mapper_priority_opc_process(struct bnxt_ulp_mapper_parms *parms,
 		rc = -EINVAL;
 		break;
 	}
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	if (!rc)
-		BNXT_DRV_DBG(DEBUG, "Tcam priority = 0x%x\n", *priority);
-#endif
-#endif
 	return rc;
 }
 
@@ -1504,13 +1498,6 @@ ulp_mapper_key_recipe_alloc(struct bnxt_ulp_context *ulp_ctx,
 			BNXT_DRV_DBG(ERR, "Unable to alloc key recipe\n");
 			return NULL;
 		}
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	BNXT_DRV_INF("Alloc key recipe [%s]:[%s] = 0x%X\n",
-		     (dir == BNXT_ULP_DIRECTION_INGRESS) ? "rx" : "tx",
-		     ulp_mapper_key_recipe_type_to_str(stype), recipe_id);
-#endif
-#endif
 	} else if (alloc_only) {
 		BNXT_DRV_DBG(ERR, "Recipe ID (%d) already allocated\n",
 			     recipe_id);
@@ -1554,13 +1541,6 @@ ulp_mapper_key_recipe_free(struct bnxt_ulp_context *ulp_ctx,
 	}
 	rte_free(recipes[index]);
 	recipes[index] = NULL;
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	BNXT_DRV_INF("Free key recipe [%s]:[%s] = 0x%X\n",
-		     (dir == BNXT_ULP_DIRECTION_INGRESS) ? "rx" : "tx",
-		     ulp_mapper_key_recipe_type_to_str(stype), index);
-#endif
-#endif
 	return 0;
 }
 
@@ -1768,13 +1748,6 @@ ulp_mapper_key_recipe_field_opc_process(struct bnxt_ulp_mapper_parms *parms,
 			}
 		}
 	}
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	if (*written && is_key)
-		BNXT_DRV_DBG(DEBUG, "%-20s bits = %-3d\n", fld->description,
-			     fld->field_bit_size);
-#endif
-#endif
 	return rc;
 }
 
@@ -3064,11 +3037,6 @@ ulp_mapper_stats_cache_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 			     rc);
 		return rc;
 	}
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	BNXT_DRV_DBG(DEBUG, "flow id =0x%x\n", parms->flow_id);
-#endif
-#endif
 	return rc;
 }
 
@@ -4039,12 +4007,6 @@ ulp_mapper_func_info_process(struct bnxt_ulp_mapper_parms *parms,
 			     func_info->func_dst_opr);
 		return -EINVAL;
 	}
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	BNXT_DRV_DBG(DEBUG, "write the %" PRIX64 " into func_opc %u\n", res,
-		     func_info->func_dst_opr);
-#endif
-#endif
 
 	return rc;
 }
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c b/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c
index 3960be4e48..f17fb6e3b2 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c
@@ -11,10 +11,6 @@
 #include "bnxt_ulp_utils.h"
 #include "bnxt_ulp_tf.h"
 
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#include "ulp_template_debug_proto.h"
-#include "ulp_tf_debug.h"
-#endif
 
 /* Internal function to write the tcam entry */
 static int32_t
@@ -50,9 +46,6 @@ ulp_mapper_tf_tcam_tbl_entry_write(struct bnxt_ulp_mapper_parms *parms,
 			     tf_dir_2_str(sparms.dir), sparms.idx);
 		return -EIO;
 	}
-	BNXT_DRV_INF("tcam[%s][%s][%x] write success.\n",
-		     tf_tcam_tbl_2_str(sparms.tcam_tbl_type),
-		     tf_dir_2_str(sparms.dir), sparms.idx);
 
 	/* Mark action */
 	rc = ulp_mapper_mark_act_ptr_process(parms, tbl);
@@ -61,11 +54,6 @@ ulp_mapper_tf_tcam_tbl_entry_write(struct bnxt_ulp_mapper_parms *parms,
 		return rc;
 	}
 
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	ulp_mapper_tcam_entry_dump("TCAM", idx, tbl, key, mask, data);
-#endif
-#endif
 	return rc;
 }
 
@@ -353,11 +341,6 @@ ulp_mapper_tf_em_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 		BNXT_DRV_DBG(ERR, "Failed to build the result blob\n");
 		return rc;
 	}
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	ulp_mapper_result_dump("EM Result", tbl, &data);
-#endif
-#endif
 	if (dparms->em_dynamic_pad_en) {
 		uint32_t abits = dparms->em_blk_align_bits;
 
@@ -372,11 +355,6 @@ ulp_mapper_tf_em_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 		ulp_blob_pad_align(&data, abits);
 
 		ulp_blob_perform_byte_reverse(&data, ULP_BITS_2_BYTE(abits));
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	ulp_mapper_result_dump("EM Merged Result", tbl, &data);
-#endif
-#endif
 	}
 
 	/* do the transpose for the internal EM keys */
@@ -389,11 +367,6 @@ ulp_mapper_tf_em_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 		}
 		tmplen = ulp_blob_data_len_get(&key);
 		ulp_blob_perform_byte_reverse(&key, ULP_BITS_2_BYTE(tmplen));
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	ulp_mapper_result_dump("EM Key Transpose", tbl, &key);
-#endif
-#endif
 	}
 
 	rc = bnxt_ulp_cntxt_tbl_scope_id_get(parms->ulp_ctx,
@@ -444,12 +417,6 @@ ulp_mapper_tf_em_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 		return rc;
 	}
 
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	ulp_mapper_em_dump("EM", &key, &data, &iparms);
-	/* tf_dump_tables(tfp, iparms.tbl_scope_id); */
-#endif
-#endif
 	/* Mark action process */
 	if (mtype == BNXT_ULP_FLOW_MEM_TYPE_EXT &&
 	    tbl->resource_type == TF_MEM_EXTERNAL)
@@ -852,9 +819,6 @@ ulp_mapper_tf_index_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 				     sparms.idx, rc);
 			goto error;
 		}
-		BNXT_DRV_INF("Index table[%s][%s][%x] write successful.\n",
-			     tf_tbl_type_2_str(sparms.type),
-			     tf_dir_2_str(sparms.dir), sparms.idx);
 
 		/* Calculate action record size */
 		if (tbl->resource_type == TF_TBL_TYPE_EXT) {
@@ -1032,10 +996,6 @@ ulp_mapper_tf_if_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 			     iftbl_params.idx, rc);
 		return rc;
 	}
-	BNXT_DRV_INF("Set table[%s][%s][%x] success.\n",
-		     tf_if_tbl_2_str(iftbl_params.type),
-		     tf_dir_2_str(iftbl_params.dir),
-		     iftbl_params.idx);
 
 	/*
 	 * TBD: Need to look at the need to store idx in flow db for restore
@@ -1073,13 +1033,6 @@ ulp_mapper_tf_ident_alloc(struct bnxt_ulp_context *ulp_ctx,
 		return rc;
 	}
 	*identifier_id = iparms.id;
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	BNXT_DRV_INF("Allocated Identifier [%s]:[%s] = 0x%X\n",
-		     tf_dir_2_str(iparms.dir),
-		     tf_ident_2_str(iparms.ident_type), iparms.id);
-#endif
-#endif
 	return rc;
 }
 
@@ -1104,14 +1057,6 @@ ulp_mapper_tf_ident_free(struct bnxt_ulp_context *ulp_ctx,
 	free_parms.id = res->resource_hndl;
 
 	(void)tf_free_identifier(tfp, &free_parms);
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	BNXT_DRV_INF("Freed Identifier [%s]:[%s] = 0x%X\n",
-		     tf_dir_2_str(free_parms.dir),
-		     tf_ident_2_str(free_parms.ident_type),
-		     (uint32_t)free_parms.id);
-#endif
-#endif
 	return rc;
 }
 
@@ -1219,14 +1164,6 @@ ulp_mapper_tf_index_entry_free(struct bnxt_ulp_context *ulp,
 	if (fparms.type == TF_TBL_TYPE_FULL_ACT_RECORD)
 		(void)ulp_mapper_clear_full_action_record(tfp, ulp, &fparms);
 
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	BNXT_DRV_INF("Free index table [%s]:[%s] = 0x%X\n",
-		     tf_dir_2_str(fparms.dir),
-		     tf_tbl_type_2_str(fparms.type),
-		     (uint32_t)fparms.idx);
-#endif
-#endif
 	return tf_free_tbl_entry(tfp, &fparms);
 }
 
@@ -1267,14 +1204,6 @@ ulp_mapper_tf_index_tbl_alloc_process(struct bnxt_ulp_context *ulp,
 
 	*index = aparms.idx;
 
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-		BNXT_DRV_DBG(DEBUG, "Allocated Table Index [%s][%s] = 0x%04x\n",
-			     tf_tbl_type_2_str(aparms.type),
-			     tf_dir_2_str(aparms.dir),
-			     aparms.idx);
-#endif
-#endif
 	return rc;
 }
 
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
index 0f967b838d..f99698a1d8 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
@@ -12,11 +12,6 @@
 #include "bnxt_ulp_utils.h"
 #include "tfc_action_handle.h"
 
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#include "ulp_template_debug_proto.h"
-#include "ulp_tf_debug.h"
-#include "tfc_debug.h"
-#endif
 
 #define BNXT_METER_MAX_NUM 1024
 static struct bnxt_mtr_stats_id_map mtr_stats[BNXT_METER_MAX_NUM];
@@ -80,11 +75,6 @@ ulp_mapper_tfc_tcam_tbl_entry_write(struct bnxt_ulp_mapper_parms *parms,
 		return rc;
 	}
 
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	ulp_mapper_tcam_entry_dump("TCAM", idx, tbl, key, mask, remap);
-#endif
-#endif
 	return rc;
 }
 
@@ -293,11 +283,6 @@ ulp_mapper_tfc_tcam_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 		key = &tkey;
 		mask = &tmask;
 	}
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	ulp_mapper_tcam_entry_dump("TCAM", 0, tbl, key, mask, &data);
-#endif
-#endif
 
 	if (alloc_tcam) {
 		tfcp = bnxt_ulp_cntxt_tfcp_get(parms->ulp_ctx);
@@ -531,11 +516,6 @@ ulp_mapper_tfc_em_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 	ulp_blob_pad_push(&key, align_len_bits);
 	key_len = ULP_BITS_2_BYTE(ulp_blob_data_len_get(&key));
 	ulp_blob_perform_byte_reverse(&key, key_len);
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	ulp_mapper_result_dump("EM Key", tbl, &key);
-#endif
-#endif
 	/* Create the result data blob */
 	rc = ulp_mapper_tbl_result_build(parms, tbl, &data, "EM Result");
 	if (unlikely(rc)) {
@@ -546,11 +526,6 @@ ulp_mapper_tfc_em_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 	key_len = ULP_BITS_2_BYTE(ulp_blob_data_len_get(&data));
 	ulp_blob_perform_byte_reverse(&data, key_len);
 
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	ulp_mapper_result_dump("EM Result", tbl, &data);
-#endif
-#endif
 	rc = ulp_blob_append(&key, &data, 0, dparms->em_blk_align_bits);
 	if (unlikely(rc)) {
 		BNXT_DRV_DBG(ERR, "EM Failed to append the result to key(%d)",
@@ -566,11 +541,6 @@ ulp_mapper_tfc_em_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 	if (unlikely(rc))
 		return rc;
 
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	ulp_mapper_result_dump("EM Merged Result", tbl, &key);
-#endif
-#endif
 	iparms.dir		 = tbl->direction;
 	iparms.lkup_key_data	 = ulp_blob_data_get(&key, &tmplen);
 	iparms.lkup_key_sz_words = ULP_BITS_TO_32_BYTE_WORD(tmplen);
@@ -644,11 +614,6 @@ ulp_mapper_tfc_em_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 		return rc;
 	}
 
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	ulp_mapper_tfc_em_dump("EM", &key, &iparms);
-#endif
-#endif
 	/* Mark action process */
 	rc = ulp_mapper_mark_gfid_process(parms, tbl, *iparms.flow_handle);
 	if (unlikely(rc)) {
@@ -1082,14 +1047,6 @@ ulp_mapper_tfc_index_entry_free(struct bnxt_ulp_context *ulp_ctx,
 
 	/* TBD: check to see if the memory needs to be cleaned as well*/
 	rc = tfc_idx_tbl_free(tfcp, fw_fid, &tbl_info);
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	if (!rc)
-		BNXT_DRV_DBG(DEBUG, "Freed Index [%s]:[%s] = 0x%X\n",
-		     tfc_dir_2_str(tbl_info.dir),
-		     tfc_idx_tbl_2_str(tbl_info.rsubtype), tbl_info.id);
-#endif
-#endif
 	return rc;
 }
 
@@ -1585,13 +1542,6 @@ ulp_mapper_tfc_ident_alloc(struct bnxt_ulp_context *ulp_ctx,
 		return rc;
 	}
 	*identifier_id = ident_info.id;
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	BNXT_DRV_INF("Allocated Identifier [%s]:[%s] = 0x%X\n",
-		     tfc_dir_2_str(direction),
-		     tfc_ident_2_str(ident_info.rsubtype), ident_info.id);
-#endif
-#endif
 
 	return rc;
 }
@@ -1625,13 +1575,6 @@ ulp_mapper_tfc_ident_free(struct bnxt_ulp_context *ulp_ctx,
 		BNXT_DRV_DBG(ERR, "free failed %d\n", rc);
 		return rc;
 	}
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	BNXT_DRV_DBG(DEBUG, "Freed Identifier [%s]:[%s] = 0x%X\n",
-		     tfc_dir_2_str(ident_info.dir),
-		     tfc_ident_2_str(ident_info.rsubtype), ident_info.id);
-#endif
-#endif
 
 	return rc;
 }
@@ -1739,13 +1682,6 @@ ulp_mapper_tfc_tcam_entry_free(struct bnxt_ulp_context *ulp,
 			    tcam_info.id);
 		return -EINVAL;
 	}
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	BNXT_DRV_DBG(DEBUG, "Freed TCAM [%s]:[%s] = 0x%X\n",
-		     tfc_dir_2_str(tcam_info.dir),
-		     tfc_tcam_2_str(tcam_info.rsubtype), tcam_info.id);
-#endif
-#endif
 	return 0;
 }
 
@@ -1804,13 +1740,6 @@ ulp_mapper_tfc_index_tbl_alloc_process(struct bnxt_ulp_context *ulp,
 	}
 
 	*index = tbl_info.id;
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG_MAPPER
-	BNXT_DRV_DBG(DEBUG, "Allocated Table Index [%s][%s] = 0x%04x\n",
-		     tfc_idx_tbl_2_str(table_type), tfc_dir_2_str(direction),
-		     tbl_info.id);
-#endif
-#endif
 	return rc;
 }
 
diff --git a/drivers/net/bnxt/tf_ulp/ulp_matcher.c b/drivers/net/bnxt/tf_ulp/ulp_matcher.c
index 4b2e185278..f739cdf2a3 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_matcher.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_matcher.c
@@ -225,12 +225,6 @@ ulp_matcher_pattern_match(struct ulp_rte_parser_params *params,
 
 error:
 	BNXT_DRV_DBG(DEBUG, "Did not find any matching template\n");
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-	BNXT_DRV_DBG(DEBUG,
-		     "hid:%x,Hdr:%" PRIX64 " Fld:%" PRIX64 " SFl:%" PRIX64 "\n",
-		     class_match_idx, params->hdr_bitmap.bits,
-		     params->fld_bitmap.bits, params->fld_s_bitmap.bits);
-#endif
 	*class_id = 0;
 	return BNXT_TF_RC_ERROR;
 }
@@ -326,9 +320,6 @@ ulp_matcher_action_match(struct ulp_rte_parser_params *params,
 	return BNXT_TF_RC_SUCCESS;
 error:
 	BNXT_DRV_DBG(DEBUG, "Did not find any matching action template\n");
-#ifdef RTE_LIBRTE_BNXT_TRUFLOW_DEBUG
-	BNXT_DRV_DBG(DEBUG, "Hdr:%" PRIX64 "\n", params->act_bitmap.bits);
-#endif
 	*act_id = 0;
 	return BNXT_TF_RC_ERROR;
 }
-- 
2.39.5 (Apple Git-154)

