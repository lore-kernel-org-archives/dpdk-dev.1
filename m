Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F29C02198
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 17:20:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51E8140A6C;
	Wed,  5 Feb 2025 18:20:19 +0100 (CET)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50]) by mails.dpdk.org (Postfix) with ESMTP id 9004140678
 for <dev@dpdk.org>; Wed,  5 Feb 2025 18:20:17 +0100 (CET)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-71e2aa8d5e3so25406a34.2
 for <dev@dpdk.org>; Wed, 05 Feb 2025 09:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1738776016; x=1739380816; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7elrpdX6I2KNDHaXAB43jtrTXsgFvTpORSZdo3PoEBE=;
 b=PTvvv5kkoCBYOobYIthoRqI35ASBdbWoF9BuhiVTyIRer4qx6EatiUb/2mmtG080Lr
 huzNe67dQPX3jg1en9XOiN77j8mMyK1ddoPxgYmV0/897fZhz8yY+OjZkFYEJ9F0Zy5p
 pMm1HdWerO7y+IY0bWj0Q+n/2LNSzqprQtjAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738776016; x=1739380816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7elrpdX6I2KNDHaXAB43jtrTXsgFvTpORSZdo3PoEBE=;
 b=WEpF2DHSTWy0/cfSNHBZttWga0/y8w75XlsL+VBWr3lyfUzFvxP3Co8gK4z+6/PsUt
 nldAZsegVTL69Ctq6iI8BLGEO9ea6sLM5Mf+SDTd5YYL/Nr3jLmL2Iiub7DWETeMexcg
 T1BCfhX1RuIfuoplE3ySOF8TmLpljUXl1I5YJxbj1N55XguEI4btXhdH8uvo+AnqS8x6
 +HkqseyJc0HnQyeM17qdpUY1NRcy0rtFm6/rHw/cXP10lBnnCu2FF/lS5U0TGnW//7NJ
 0IUiuAmdU2zXsaqoHZmCeIxIOENN8jGo+y86WTGnwgaiVRIa38E7L1dbac5OiyqeaG1F
 eLUQ==
X-Gm-Message-State: AOJu0Yw04xBXH9nBjaLJaX+iauxu5dF1iDJh4JPRyYO1DkNGMs5AQ9FC
 9APrt4tD2CJSvupOZPwb6gdE+pG3afWVeCk6mmjq6EHsnvml7EGUF5XIiEFDonnmPpGijb/Xc/g
 NGWl4J8sbPjHlZvvd6bMAjN74HkGkkfJs0IpxRaWS+eNzaz5173lSTmqRpDSAWvuiZyKg4ZnHVo
 1fHDgfG6GobmrxdxDW3y3uDxT7/MGt
X-Gm-Gg: ASbGncst3g4jp84P/wg0xor0HDWz+JRBUsUQgOzmVq0EVzU6vkMz024xYOVGOzjD1r7
 CO0KF/QpibiwbNeorVoKWOJu+LXuM0ztj1Jb5dwiKOwaf60fJnvfz0Ag0Z5PcFLxADgs8xthRsP
 w+qzecHUT/nrWuiEKwNoVaygZD9y+64FH6eU8aqfzf+8FFLbGBIiGrMLPIgpOfGcnx+4yLVA+1z
 L0MTx5blXr2QfjRZ5g+tZglyCFzF4DF/2d2UC9NrctFLBWHnDNOLmNbgw+ZwEcqLN4b6vfG/7In
 NtyOJmhFuu6HX/is0pyJNAqfcQS9KdEdwZRqRcDbhSkyEOKSDKrPT/Xo/+kBDiuZnhjVhFU5G+8
 hpDvqq7bq
X-Google-Smtp-Source: AGHT+IHmaoULWXWCdF9bN+FFExZrFvbIdhVk0B0GallUCBhhnmxcJ5UEQ5xwj4XduYJUnJKx9bBc4w==
X-Received: by 2002:a05:6830:630b:b0:71d:f8bd:4be4 with SMTP id
 46e09a7af769-726a428004emr2541195a34.19.1738776016403; 
 Wed, 05 Feb 2025 09:20:16 -0800 (PST)
Received: from C02GC2QQMD6T.wifi.broadcom.net ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726617cde49sm4004016a34.27.2025.02.05.09.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 09:20:16 -0800 (PST)
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH 06/11] net/bnxt: address coverity deadcode issue
Date: Wed,  5 Feb 2025 09:19:59 -0800
Message-Id: <20250205172004.50395-7-ajit.khaparde@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250205172004.50395-1-ajit.khaparde@broadcom.com>
References: <20250205172004.50395-1-ajit.khaparde@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Peter Spreadborough <peter.spreadborough@broadcom.com>

This change addresses the CID 449075:  Control flow issues (DEADCODE)
reported by coverity associated with the ASSERT_RETURN macro. The
change renames the macro and replaces the log macro to use
PMD_DRV_LOG_LINE.

Coverity issue: 449075
Signed-off-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 .../hcapi/cfa_v3/bld/p70/cfa_bld_p70_mpc.c    |  90 +++++------
 .../p70/host/cfa_bld_p70_host_mpc_wrapper.c   | 150 +++++++++---------
 2 files changed, 120 insertions(+), 120 deletions(-)

diff --git a/drivers/net/bnxt/hcapi/cfa_v3/bld/p70/cfa_bld_p70_mpc.c b/drivers/net/bnxt/hcapi/cfa_v3/bld/p70/cfa_bld_p70_mpc.c
index 445d9aad87..3f8ef3a5f1 100644
--- a/drivers/net/bnxt/hcapi/cfa_v3/bld/p70/cfa_bld_p70_mpc.c
+++ b/drivers/net/bnxt/hcapi/cfa_v3/bld/p70/cfa_bld_p70_mpc.c
@@ -31,9 +31,9 @@
 	} while (0)
 
 #ifdef NXT_ENV_DEBUG
-#define ASSERT_RETURN(ERRNO) CFA_LOG_ERR("Returning error: %d\n", (ERRNO))
+#define LOG_RC(ERRNO) PMD_DRV_LOG_LINE(ERR, "Returning error: %d", (ERRNO))
 #else
-#define ASSERT_RETURN(ERRNO)
+#define LOG_RC(ERRNO)
 #endif
 
 /**
@@ -68,7 +68,7 @@ static int fill_mpc_header(uint8_t *cmd, uint32_t size, uint32_t opaque_val)
 	};
 
 	if (size < sizeof(struct mpc_header)) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -87,17 +87,17 @@ static int compose_mpc_read_clr_msg(uint8_t *cmd_buff, uint32_t *cmd_buff_len,
 		sizeof(struct mpc_header) + sizeof(struct cfa_mpc_read_clr_cmd);
 
 	if (parms->data_size != 1) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (parms->tbl_type >= CFA_HW_TABLE_MAX) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (*cmd_buff_len < cmd_size) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -138,17 +138,17 @@ static int compose_mpc_read_msg(uint8_t *cmd_buff, uint32_t *cmd_buff_len,
 		sizeof(struct mpc_header) + sizeof(struct cfa_mpc_read_cmd);
 
 	if (parms->data_size < 1 || parms->data_size > 4) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (parms->tbl_type >= CFA_HW_TABLE_MAX) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (*cmd_buff_len < cmd_size) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -194,22 +194,22 @@ static int compose_mpc_write_msg(uint8_t *cmd_buff, uint32_t *cmd_buff_len,
 			    parms->data_size * MPC_CFA_CACHE_ACCESS_UNIT_SIZE;
 
 	if (parms->data_size < 1 || parms->data_size > 4) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (parms->tbl_type >= CFA_HW_TABLE_MAX) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (!parms->write.data_ptr) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (*cmd_buff_len < cmd_size) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -252,17 +252,17 @@ static int compose_mpc_evict_msg(uint8_t *cmd_buff, uint32_t *cmd_buff_len,
 			    sizeof(struct cfa_mpc_invalidate_cmd);
 
 	if (parms->data_size < 1 || parms->data_size > 4) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (parms->tbl_type >= CFA_HW_TABLE_MAX) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (*cmd_buff_len < cmd_size) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -293,7 +293,7 @@ static int compose_mpc_evict_msg(uint8_t *cmd_buff, uint32_t *cmd_buff_len,
 		break;
 	case CFA_MPC_EV_EVICT_TABLE_SCOPE:
 		/* Not supported */
-		ASSERT_RETURN(-ENOTSUP);
+		LOG_RC(-ENOTSUP);
 		return -ENOTSUP;
 	default:
 	case CFA_MPC_EV_EVICT_SCOPE_ADDRESS:
@@ -326,7 +326,7 @@ int cfa_mpc_build_cache_axs_cmd(enum cfa_mpc_opcode opc, uint8_t *cmd_buff,
 {
 	int rc;
 	if (!cmd_buff || !cmd_buff_len || *cmd_buff_len == 0 || !parms) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -344,7 +344,7 @@ int cfa_mpc_build_cache_axs_cmd(enum cfa_mpc_opcode opc, uint8_t *cmd_buff,
 	case CFA_MPC_INVALIDATE:
 		return compose_mpc_evict_msg(cmd_buff, cmd_buff_len, parms);
 	default:
-		ASSERT_RETURN(-ENOTSUP);
+		LOG_RC(-ENOTSUP);
 		return -ENOTSUP;
 	}
 }
@@ -360,17 +360,17 @@ static int compose_mpc_em_search_msg(uint8_t *cmd_buff, uint32_t *cmd_buff_len,
 			    e->data_size * MPC_CFA_CACHE_ACCESS_UNIT_SIZE;
 
 	if (e->data_size < 1 || e->data_size > 4) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (*cmd_buff_len < cmd_size) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (!e->em_entry) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -405,17 +405,17 @@ static int compose_mpc_em_insert_msg(uint8_t *cmd_buff, uint32_t *cmd_buff_len,
 			    e->data_size * MPC_CFA_CACHE_ACCESS_UNIT_SIZE;
 
 	if (e->data_size < 1 || e->data_size > 4) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (*cmd_buff_len < cmd_size) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (!e->em_entry) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -455,7 +455,7 @@ static int compose_mpc_em_delete_msg(uint8_t *cmd_buff, uint32_t *cmd_buff_len,
 			    sizeof(struct cfa_mpc_em_delete_cmd);
 
 	if (*cmd_buff_len < cmd_size) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -487,7 +487,7 @@ static int compose_mpc_em_chain_msg(uint8_t *cmd_buff, uint32_t *cmd_buff_len,
 		sizeof(struct mpc_header) + sizeof(struct cfa_mpc_em_chain_cmd);
 
 	if (*cmd_buff_len < cmd_size) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -530,7 +530,7 @@ int cfa_mpc_build_em_op_cmd(enum cfa_mpc_opcode opc, uint8_t *cmd_buff,
 {
 	int rc;
 	if (!cmd_buff || !cmd_buff_len || *cmd_buff_len == 0 || !parms) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -548,7 +548,7 @@ int cfa_mpc_build_em_op_cmd(enum cfa_mpc_opcode opc, uint8_t *cmd_buff,
 	case CFA_MPC_EM_CHAIN:
 		return compose_mpc_em_chain_msg(cmd_buff, cmd_buff_len, parms);
 	default:
-		ASSERT_RETURN(-ENOTSUP);
+		LOG_RC(-ENOTSUP);
 		return -ENOTSUP;
 	}
 
@@ -572,17 +572,17 @@ static int parse_mpc_read_clr_result(uint8_t *resp_buff, uint32_t resp_buff_len,
 					      sizeof(struct mpc_header));
 
 	if (resp_buff_len < resp_size) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (result->data_len < rd_size) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (!result->rd_data) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -622,17 +622,17 @@ static int parse_mpc_read_result(uint8_t *resp_buff, uint32_t resp_buff_len,
 					  sizeof(struct mpc_header));
 
 	if (resp_buff_len < resp_size) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (result->data_len < rd_size) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (!result->rd_data) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -671,7 +671,7 @@ static int parse_mpc_write_result(uint8_t *resp_buff, uint32_t resp_buff_len,
 					   sizeof(struct mpc_header));
 
 	if (resp_buff_len < resp_size) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -696,7 +696,7 @@ static int parse_mpc_evict_result(uint8_t *resp_buff, uint32_t resp_buff_len,
 						sizeof(struct mpc_header));
 
 	if (resp_buff_len < resp_size) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -728,7 +728,7 @@ int cfa_mpc_parse_cache_axs_resp(enum cfa_mpc_opcode opc, uint8_t *resp_buff,
 				 struct cfa_mpc_cache_axs_result *result)
 {
 	if (!resp_buff || resp_buff_len == 0 || !result) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -743,7 +743,7 @@ int cfa_mpc_parse_cache_axs_resp(enum cfa_mpc_opcode opc, uint8_t *resp_buff,
 	case CFA_MPC_INVALIDATE:
 		return parse_mpc_evict_result(resp_buff, resp_buff_len, result);
 	default:
-		ASSERT_RETURN(-ENOTSUP);
+		LOG_RC(-ENOTSUP);
 		return -ENOTSUP;
 	}
 }
@@ -762,7 +762,7 @@ static int parse_mpc_em_search_result(uint8_t *resp_buff,
 		    sizeof(struct cfa_mpc_em_search_cmp);
 
 	if (resp_buff_len < resp_size) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -794,7 +794,7 @@ static int parse_mpc_em_insert_result(uint8_t *resp_buff,
 		    sizeof(struct cfa_mpc_em_insert_cmp);
 
 	if (resp_buff_len < resp_size) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -828,7 +828,7 @@ static int parse_mpc_em_delete_result(uint8_t *resp_buff,
 		    sizeof(struct cfa_mpc_em_delete_cmp);
 
 	if (resp_buff_len < resp_size) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -859,7 +859,7 @@ static int parse_mpc_em_chain_result(uint8_t *resp_buff, uint32_t resp_buff_len,
 		sizeof(struct mpc_header) + sizeof(struct cfa_mpc_em_chain_cmp);
 
 	if (resp_buff_len < resp_size) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -894,7 +894,7 @@ int cfa_mpc_parse_em_op_resp(enum cfa_mpc_opcode opc, uint8_t *resp_buff,
 			     struct cfa_mpc_em_op_result *result)
 {
 	if (!resp_buff || resp_buff_len == 0 || !result) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -912,7 +912,7 @@ int cfa_mpc_parse_em_op_resp(enum cfa_mpc_opcode opc, uint8_t *resp_buff,
 		return parse_mpc_em_chain_result(resp_buff, resp_buff_len,
 						 result);
 	default:
-		ASSERT_RETURN(-ENOTSUP);
+		LOG_RC(-ENOTSUP);
 		return -ENOTSUP;
 	}
 }
diff --git a/drivers/net/bnxt/hcapi/cfa_v3/bld/p70/host/cfa_bld_p70_host_mpc_wrapper.c b/drivers/net/bnxt/hcapi/cfa_v3/bld/p70/host/cfa_bld_p70_host_mpc_wrapper.c
index d685cc8a63..4719be2b7e 100644
--- a/drivers/net/bnxt/hcapi/cfa_v3/bld/p70/host/cfa_bld_p70_host_mpc_wrapper.c
+++ b/drivers/net/bnxt/hcapi/cfa_v3/bld/p70/host/cfa_bld_p70_host_mpc_wrapper.c
@@ -21,9 +21,9 @@
 #include "host/cfa_p70_mpc_field_mapping.h"
 
 #ifdef NXT_ENV_DEBUG
-#define ASSERT_RETURN(ERRNO) CFA_LOG_ERR("Returning error: %d\n", (ERRNO))
+#define LOG_RC(ERRNO) PMD_DRV_LOG_LINE(ERR, "Returning error: %d", (ERRNO))
 #else
-#define ASSERT_RETURN(ERRNO)
+#define LOG_RC(ERRNO)
 #endif
 
 /*
@@ -47,7 +47,7 @@
 			uint64_t mapped_val;                                   \
 			retcode = MAP_FUNC(fields[INDEX].val, &mapped_val);    \
 			if (retcode)                                           \
-				ASSERT_RETURN(retcode);                        \
+				LOG_RC(retcode);                        \
 			else                                                   \
 				parms.NAME = (TYPE)mapped_val;                 \
 		}                                                              \
@@ -75,7 +75,7 @@
 			uint64_t mapped_val;                                   \
 			retcode = MAP_FUNC(result.NAME, &mapped_val);          \
 			if (retcode)                                           \
-				ASSERT_RETURN(retcode);                        \
+				LOG_RC(retcode);                        \
 			else                                                   \
 				fields[INDEX].val = mapped_val;                \
 		}                                                              \
@@ -121,7 +121,7 @@ static int table_type_map(uint64_t val, uint64_t *mapped_val)
 		*mapped_val = CFA_HW_TABLE_LOOKUP;
 		break;
 	default:
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -145,7 +145,7 @@ static int read_mode_map(uint64_t val, uint64_t *mapped_val)
 		*mapped_val = CFA_MPC_RD_DEBUG_TAG;
 		break;
 	default:
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 	return 0;
@@ -162,7 +162,7 @@ static int write_mode_map(uint64_t val, uint64_t *mapped_val)
 		*mapped_val = CFA_MPC_WR_WRITE_BACK;
 		break;
 	default:
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 	return 0;
@@ -191,7 +191,7 @@ static int evict_mode_map(uint64_t val, uint64_t *mapped_val)
 		*mapped_val = CFA_MPC_EV_EVICT_TABLE_SCOPE;
 		break;
 	default:
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 	return 0;
@@ -232,7 +232,7 @@ static int status_code_map(uint64_t val, uint64_t *mapped_val)
 		*mapped_val = CFA_BLD_MPC_EM_ABORT;
 		break;
 	default:
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 	return 0;
@@ -266,13 +266,13 @@ int cfa_bld_p70_mpc_build_cache_read(uint8_t *cmd, uint32_t *cmd_buff_len,
 
 	/* Parameters check */
 	if (!cmd || !cmd_buff_len || !fields) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (!fields_valid(fields, CFA_BLD_MPC_READ_CMD_MAX_FLD,
 			  cfa_p70_mpc_read_cmd_gbl_to_dev)) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -291,7 +291,7 @@ int cfa_bld_p70_mpc_build_cache_read(uint8_t *cmd, uint32_t *cmd_buff_len,
 				   CFA_BLD_MPC_READ_CMD_TABLE_TYPE_FLD, fields,
 				   table_type_map);
 	if (rc) {
-		ASSERT_RETURN(rc);
+		LOG_RC(rc);
 		return rc;
 	}
 
@@ -299,7 +299,7 @@ int cfa_bld_p70_mpc_build_cache_read(uint8_t *cmd, uint32_t *cmd_buff_len,
 				   CFA_BLD_MPC_READ_CMD_CACHE_OPTION_FLD,
 				   fields, read_mode_map);
 	if (rc) {
-		ASSERT_RETURN(rc);
+		LOG_RC(rc);
 		return rc;
 	}
 
@@ -316,13 +316,13 @@ int cfa_bld_p70_mpc_build_cache_write(uint8_t *cmd, uint32_t *cmd_buff_len,
 
 	/* Parameters check */
 	if (!cmd || !cmd_buff_len || !fields) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (!fields_valid(fields, CFA_BLD_MPC_WRITE_CMD_MAX_FLD,
 			  cfa_p70_mpc_write_cmd_gbl_to_dev)) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -339,7 +339,7 @@ int cfa_bld_p70_mpc_build_cache_write(uint8_t *cmd, uint32_t *cmd_buff_len,
 				   CFA_BLD_MPC_WRITE_CMD_TABLE_TYPE_FLD, fields,
 				   table_type_map);
 	if (rc) {
-		ASSERT_RETURN(rc);
+		LOG_RC(rc);
 		return rc;
 	}
 
@@ -348,7 +348,7 @@ int cfa_bld_p70_mpc_build_cache_write(uint8_t *cmd, uint32_t *cmd_buff_len,
 				   CFA_BLD_MPC_WRITE_CMD_CACHE_OPTION_FLD,
 				   fields, write_mode_map);
 	if (rc) {
-		ASSERT_RETURN(rc);
+		LOG_RC(rc);
 		return rc;
 	}
 
@@ -364,13 +364,13 @@ int cfa_bld_p70_mpc_build_cache_evict(uint8_t *cmd, uint32_t *cmd_buff_len,
 
 	/* Parameters check */
 	if (!cmd || !cmd_buff_len || !fields) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (!fields_valid(fields, CFA_BLD_MPC_INVALIDATE_CMD_MAX_FLD,
 			  cfa_p70_mpc_invalidate_cmd_gbl_to_dev)) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -387,7 +387,7 @@ int cfa_bld_p70_mpc_build_cache_evict(uint8_t *cmd, uint32_t *cmd_buff_len,
 				   CFA_BLD_MPC_INVALIDATE_CMD_TABLE_TYPE_FLD,
 				   fields, table_type_map);
 	if (rc) {
-		ASSERT_RETURN(rc);
+		LOG_RC(rc);
 		return rc;
 	}
 
@@ -395,7 +395,7 @@ int cfa_bld_p70_mpc_build_cache_evict(uint8_t *cmd, uint32_t *cmd_buff_len,
 				   CFA_BLD_MPC_INVALIDATE_CMD_CACHE_OPTION_FLD,
 				   fields, evict_mode_map);
 	if (rc) {
-		ASSERT_RETURN(rc);
+		LOG_RC(rc);
 		return rc;
 	}
 
@@ -411,13 +411,13 @@ int cfa_bld_p70_mpc_build_cache_rdclr(uint8_t *cmd, uint32_t *cmd_buff_len,
 
 	/* Parameters check */
 	if (!cmd || !cmd_buff_len || !fields) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (!fields_valid(fields, CFA_BLD_MPC_READ_CLR_CMD_MAX_FLD,
 			  cfa_p70_mpc_read_clr_cmd_gbl_to_dev)) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -436,7 +436,7 @@ int cfa_bld_p70_mpc_build_cache_rdclr(uint8_t *cmd, uint32_t *cmd_buff_len,
 				   CFA_BLD_MPC_READ_CLR_CMD_TABLE_TYPE_FLD,
 				   fields, table_type_map);
 	if (rc) {
-		ASSERT_RETURN(rc);
+		LOG_RC(rc);
 		return rc;
 	}
 
@@ -446,7 +446,7 @@ int cfa_bld_p70_mpc_build_cache_rdclr(uint8_t *cmd, uint32_t *cmd_buff_len,
 				   CFA_BLD_MPC_READ_CLR_CMD_CACHE_OPTION_FLD,
 				   fields, read_mode_map);
 	if (rc) {
-		ASSERT_RETURN(rc);
+		LOG_RC(rc);
 		return rc;
 	}
 
@@ -465,20 +465,20 @@ int cfa_bld_p70_mpc_build_em_search(uint8_t *cmd, uint32_t *cmd_buff_len,
 
 	/* Parameters check */
 	if (!cmd || !cmd_buff_len || !fields) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (has_unsupported_fields(fields, CFA_BLD_MPC_EM_SEARCH_CMD_MAX_FLD,
 				   unsupported_fields,
 				   ARRAY_SIZE(unsupported_fields))) {
-		ASSERT_RETURN(-ENOTSUP);
+		LOG_RC(-ENOTSUP);
 		return -ENOTSUP;
 	}
 
 	if (!fields_valid(fields, CFA_BLD_MPC_EM_SEARCH_CMD_MAX_FLD,
 			  cfa_p70_mpc_em_search_cmd_gbl_to_dev)) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -509,20 +509,20 @@ int cfa_bld_p70_mpc_build_em_insert(uint8_t *cmd, uint32_t *cmd_buff_len,
 
 	/* Parameters check */
 	if (!cmd || !cmd_buff_len || !fields) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (has_unsupported_fields(fields, CFA_BLD_MPC_EM_INSERT_CMD_MAX_FLD,
 				   unsupported_fields,
 				   ARRAY_SIZE(unsupported_fields))) {
-		ASSERT_RETURN(-ENOTSUP);
+		LOG_RC(-ENOTSUP);
 		return -ENOTSUP;
 	}
 
 	if (!fields_valid(fields, CFA_BLD_MPC_EM_INSERT_CMD_MAX_FLD,
 			  cfa_p70_mpc_em_insert_cmd_gbl_to_dev)) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -558,20 +558,20 @@ int cfa_bld_p70_mpc_build_em_delete(uint8_t *cmd, uint32_t *cmd_buff_len,
 
 	/* Parameters check */
 	if (!cmd || !cmd_buff_len || !fields) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (has_unsupported_fields(fields, CFA_BLD_MPC_EM_DELETE_CMD_MAX_FLD,
 				   unsupported_fields,
 				   ARRAY_SIZE(unsupported_fields))) {
-		ASSERT_RETURN(-ENOTSUP);
+		LOG_RC(-ENOTSUP);
 		return -ENOTSUP;
 	}
 
 	if (!fields_valid(fields, CFA_BLD_MPC_EM_DELETE_CMD_MAX_FLD,
 			  cfa_p70_mpc_em_delete_cmd_gbl_to_dev)) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -602,20 +602,20 @@ int cfa_bld_p70_mpc_build_em_chain(uint8_t *cmd, uint32_t *cmd_buff_len,
 
 	/* Parameters check */
 	if (!cmd || !cmd_buff_len || !fields) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (has_unsupported_fields(fields, CFA_BLD_MPC_EM_CHAIN_CMD_MAX_FLD,
 				   unsupported_fields,
 				   ARRAY_SIZE(unsupported_fields))) {
-		ASSERT_RETURN(-ENOTSUP);
+		LOG_RC(-ENOTSUP);
 		return -ENOTSUP;
 	}
 
 	if (!fields_valid(fields, CFA_BLD_MPC_EM_CHAIN_CMD_MAX_FLD,
 			  cfa_p70_mpc_em_chain_cmd_gbl_to_dev)) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -653,20 +653,20 @@ int cfa_bld_p70_mpc_parse_cache_read(uint8_t *resp, uint32_t resp_buff_len,
 
 	/* Parameters check */
 	if (!resp || !resp_buff_len || !fields || !rd_data) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (has_unsupported_fields(fields, CFA_BLD_MPC_READ_CMP_MAX_FLD,
 				   unsupported_fields,
 				   ARRAY_SIZE(unsupported_fields))) {
-		ASSERT_RETURN(-ENOTSUP);
+		LOG_RC(-ENOTSUP);
 		return -ENOTSUP;
 	}
 
 	if (!fields_valid(fields, CFA_BLD_MPC_READ_CMP_MAX_FLD,
 			  cfa_p70_mpc_read_cmp_gbl_to_dev)) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -683,7 +683,7 @@ int cfa_bld_p70_mpc_parse_cache_read(uint8_t *resp, uint32_t resp_buff_len,
 	rc = GET_RESP_MAPPED_VALUE(status, CFA_BLD_MPC_READ_CMP_STATUS_FLD,
 				   fields, status_code_map);
 	if (rc) {
-		ASSERT_RETURN(rc);
+		LOG_RC(rc);
 		return rc;
 	}
 
@@ -707,20 +707,20 @@ int cfa_bld_p70_mpc_parse_cache_write(uint8_t *resp, uint32_t resp_buff_len,
 
 	/* Parameters check */
 	if (!resp || !resp_buff_len || !fields) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (has_unsupported_fields(fields, CFA_BLD_MPC_WRITE_CMP_MAX_FLD,
 				   unsupported_fields,
 				   ARRAY_SIZE(unsupported_fields))) {
-		ASSERT_RETURN(-ENOTSUP);
+		LOG_RC(-ENOTSUP);
 		return -ENOTSUP;
 	}
 
 	if (!fields_valid(fields, CFA_BLD_MPC_WRITE_CMP_MAX_FLD,
 			  cfa_p70_mpc_write_cmp_gbl_to_dev)) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -728,7 +728,7 @@ int cfa_bld_p70_mpc_parse_cache_write(uint8_t *resp, uint32_t resp_buff_len,
 	rc = cfa_mpc_parse_cache_axs_resp(CFA_MPC_WRITE, resp, resp_buff_len,
 					  &result);
 	if (rc) {
-		ASSERT_RETURN(rc);
+		LOG_RC(rc);
 		return rc;
 	}
 
@@ -737,7 +737,7 @@ int cfa_bld_p70_mpc_parse_cache_write(uint8_t *resp, uint32_t resp_buff_len,
 	rc = GET_RESP_MAPPED_VALUE(status, CFA_BLD_MPC_WRITE_CMP_STATUS_FLD,
 				   fields, status_code_map);
 	if (rc) {
-		ASSERT_RETURN(rc);
+		LOG_RC(rc);
 		return rc;
 	}
 
@@ -761,20 +761,20 @@ int cfa_bld_p70_mpc_parse_cache_evict(uint8_t *resp, uint32_t resp_buff_len,
 
 	/* Parameters check */
 	if (!resp || !resp_buff_len || !fields) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (has_unsupported_fields(fields, CFA_BLD_MPC_INVALIDATE_CMP_MAX_FLD,
 				   unsupported_fields,
 				   ARRAY_SIZE(unsupported_fields))) {
-		ASSERT_RETURN(-ENOTSUP);
+		LOG_RC(-ENOTSUP);
 		return -ENOTSUP;
 	}
 
 	if (!fields_valid(fields, CFA_BLD_MPC_INVALIDATE_CMP_MAX_FLD,
 			  cfa_p70_mpc_invalidate_cmp_gbl_to_dev)) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -782,7 +782,7 @@ int cfa_bld_p70_mpc_parse_cache_evict(uint8_t *resp, uint32_t resp_buff_len,
 	rc = cfa_mpc_parse_cache_axs_resp(CFA_MPC_INVALIDATE, resp,
 					  resp_buff_len, &result);
 	if (rc) {
-		ASSERT_RETURN(rc);
+		LOG_RC(rc);
 		return rc;
 	}
 
@@ -793,7 +793,7 @@ int cfa_bld_p70_mpc_parse_cache_evict(uint8_t *resp, uint32_t resp_buff_len,
 				   CFA_BLD_MPC_INVALIDATE_CMP_STATUS_FLD,
 				   fields, status_code_map);
 	if (rc) {
-		ASSERT_RETURN(rc);
+		LOG_RC(rc);
 		return rc;
 	}
 
@@ -819,20 +819,20 @@ int cfa_bld_p70_mpc_parse_cache_rdclr(uint8_t *resp, uint32_t resp_buff_len,
 
 	/* Parameters check */
 	if (!resp || !resp_buff_len || !fields || !rd_data) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (has_unsupported_fields(fields, CFA_BLD_MPC_READ_CMP_MAX_FLD,
 				   unsupported_fields,
 				   ARRAY_SIZE(unsupported_fields))) {
-		ASSERT_RETURN(-ENOTSUP);
+		LOG_RC(-ENOTSUP);
 		return -ENOTSUP;
 	}
 
 	if (!fields_valid(fields, CFA_BLD_MPC_READ_CMP_MAX_FLD,
 			  cfa_p70_mpc_read_cmp_gbl_to_dev)) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -849,7 +849,7 @@ int cfa_bld_p70_mpc_parse_cache_rdclr(uint8_t *resp, uint32_t resp_buff_len,
 	rc = GET_RESP_MAPPED_VALUE(status, CFA_BLD_MPC_READ_CMP_STATUS_FLD,
 				   fields, status_code_map);
 	if (rc) {
-		ASSERT_RETURN(rc);
+		LOG_RC(rc);
 		return rc;
 	}
 
@@ -872,20 +872,20 @@ int cfa_bld_p70_mpc_parse_em_search(uint8_t *resp, uint32_t resp_buff_len,
 
 	/* Parameters check */
 	if (!resp || !resp_buff_len || !fields) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (has_unsupported_fields(fields, CFA_BLD_MPC_EM_SEARCH_CMP_MAX_FLD,
 				   unsupported_fields,
 				   ARRAY_SIZE(unsupported_fields))) {
-		ASSERT_RETURN(-ENOTSUP);
+		LOG_RC(-ENOTSUP);
 		return -ENOTSUP;
 	}
 
 	if (!fields_valid(fields, CFA_BLD_MPC_EM_SEARCH_CMP_MAX_FLD,
 			  cfa_p70_mpc_em_search_cmp_gbl_to_dev)) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -893,7 +893,7 @@ int cfa_bld_p70_mpc_parse_em_search(uint8_t *resp, uint32_t resp_buff_len,
 	rc = cfa_mpc_parse_em_op_resp(CFA_MPC_EM_SEARCH, resp, resp_buff_len,
 				      &result);
 	if (rc) {
-		ASSERT_RETURN(rc);
+		LOG_RC(rc);
 		return rc;
 	}
 
@@ -903,7 +903,7 @@ int cfa_bld_p70_mpc_parse_em_search(uint8_t *resp, uint32_t resp_buff_len,
 	rc = GET_RESP_MAPPED_VALUE(status, CFA_BLD_MPC_EM_SEARCH_CMP_STATUS_FLD,
 				   fields, status_code_map);
 	if (rc) {
-		ASSERT_RETURN(rc);
+		LOG_RC(rc);
 		return rc;
 	}
 
@@ -939,20 +939,20 @@ int cfa_bld_p70_mpc_parse_em_insert(uint8_t *resp, uint32_t resp_buff_len,
 
 	/* Parameters check */
 	if (!resp || !resp_buff_len || !fields) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (has_unsupported_fields(fields, CFA_BLD_MPC_EM_INSERT_CMP_MAX_FLD,
 				   unsupported_fields,
 				   ARRAY_SIZE(unsupported_fields))) {
-		ASSERT_RETURN(-ENOTSUP);
+		LOG_RC(-ENOTSUP);
 		return -ENOTSUP;
 	}
 
 	if (!fields_valid(fields, CFA_BLD_MPC_EM_INSERT_CMP_MAX_FLD,
 			  cfa_p70_mpc_em_insert_cmp_gbl_to_dev)) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -960,7 +960,7 @@ int cfa_bld_p70_mpc_parse_em_insert(uint8_t *resp, uint32_t resp_buff_len,
 	rc = cfa_mpc_parse_em_op_resp(CFA_MPC_EM_INSERT, resp, resp_buff_len,
 				      &result);
 	if (rc) {
-		ASSERT_RETURN(rc);
+		LOG_RC(rc);
 		return rc;
 	}
 
@@ -970,7 +970,7 @@ int cfa_bld_p70_mpc_parse_em_insert(uint8_t *resp, uint32_t resp_buff_len,
 	rc = GET_RESP_MAPPED_VALUE(status, CFA_BLD_MPC_EM_INSERT_CMP_STATUS_FLD,
 				   fields, status_code_map);
 	if (rc) {
-		ASSERT_RETURN(rc);
+		LOG_RC(rc);
 		return rc;
 	}
 
@@ -1010,20 +1010,20 @@ int cfa_bld_p70_mpc_parse_em_delete(uint8_t *resp, uint32_t resp_buff_len,
 
 	/* Parameters check */
 	if (!resp || !resp_buff_len || !fields) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (has_unsupported_fields(fields, CFA_BLD_MPC_EM_DELETE_CMP_MAX_FLD,
 				   unsupported_fields,
 				   ARRAY_SIZE(unsupported_fields))) {
-		ASSERT_RETURN(-ENOTSUP);
+		LOG_RC(-ENOTSUP);
 		return -ENOTSUP;
 	}
 
 	if (!fields_valid(fields, CFA_BLD_MPC_EM_DELETE_CMP_MAX_FLD,
 			  cfa_p70_mpc_em_delete_cmp_gbl_to_dev)) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -1031,7 +1031,7 @@ int cfa_bld_p70_mpc_parse_em_delete(uint8_t *resp, uint32_t resp_buff_len,
 	rc = cfa_mpc_parse_em_op_resp(CFA_MPC_EM_DELETE, resp, resp_buff_len,
 				      &result);
 	if (rc) {
-		ASSERT_RETURN(rc);
+		LOG_RC(rc);
 		return rc;
 	}
 
@@ -1041,7 +1041,7 @@ int cfa_bld_p70_mpc_parse_em_delete(uint8_t *resp, uint32_t resp_buff_len,
 	rc = GET_RESP_MAPPED_VALUE(status, CFA_BLD_MPC_EM_DELETE_CMP_STATUS_FLD,
 				   fields, status_code_map);
 	if (rc) {
-		ASSERT_RETURN(rc);
+		LOG_RC(rc);
 		return rc;
 	}
 
@@ -1076,20 +1076,20 @@ int cfa_bld_p70_mpc_parse_em_chain(uint8_t *resp, uint32_t resp_buff_len,
 
 	/* Parameters check */
 	if (!resp || !resp_buff_len || !fields) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
 	if (has_unsupported_fields(fields, CFA_BLD_MPC_EM_CHAIN_CMP_MAX_FLD,
 				   unsupported_fields,
 				   ARRAY_SIZE(unsupported_fields))) {
-		ASSERT_RETURN(-ENOTSUP);
+		LOG_RC(-ENOTSUP);
 		return -ENOTSUP;
 	}
 
 	if (!fields_valid(fields, CFA_BLD_MPC_EM_CHAIN_CMP_MAX_FLD,
 			  cfa_p70_mpc_em_chain_cmp_gbl_to_dev)) {
-		ASSERT_RETURN(-EINVAL);
+		LOG_RC(-EINVAL);
 		return -EINVAL;
 	}
 
@@ -1097,7 +1097,7 @@ int cfa_bld_p70_mpc_parse_em_chain(uint8_t *resp, uint32_t resp_buff_len,
 	rc = cfa_mpc_parse_em_op_resp(CFA_MPC_EM_CHAIN, resp, resp_buff_len,
 				      &result);
 	if (rc) {
-		ASSERT_RETURN(rc);
+		LOG_RC(rc);
 		return rc;
 	}
 
@@ -1107,7 +1107,7 @@ int cfa_bld_p70_mpc_parse_em_chain(uint8_t *resp, uint32_t resp_buff_len,
 	rc = GET_RESP_MAPPED_VALUE(status, CFA_BLD_MPC_EM_CHAIN_CMP_STATUS_FLD,
 				   fields, status_code_map);
 	if (rc) {
-		ASSERT_RETURN(rc);
+		LOG_RC(rc);
 		return rc;
 	}
 
-- 
2.39.5 (Apple Git-154)

