Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7EDCAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:09:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4BEF40E68;
	Tue, 30 Sep 2025 09:06:03 +0200 (CEST)
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com
 [209.85.166.227])
 by mails.dpdk.org (Postfix) with ESMTP id 31B04402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:21 +0200 (CEST)
Received: by mail-il1-f227.google.com with SMTP id
 e9e14a558f8ab-426f9f275b2so18305695ab.3
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192640; x=1759797440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q9EtDqChgs11ff3HdlP+YBFHRiW51mcpPlRLZQSeyGA=;
 b=nnm0/B8YVI0hXqU30uivQKg1BcVf34jnmqJNpOBMR9jerFnLUPJq1SJMal5KkaEvVk
 rCK1a0wMXQqC2q6wi9RjdDW1tyR2AYK7M/fdq8OgOlxfhydltYAjUUYBY/W7txjoKSj6
 JjopjF6duXskudoga+n/1bTWNguwZVBaBL8/396927DyuvDN/bBILATR6yDCaDi/kaiD
 F2tV71tZFR7wfKRPEVtYAjcSW+rUIiTol+wkZ0eJL7zN9dIVNO0KeCSeo3EXAXwoUlj0
 KbuaeXmt/HDCNgBZ24lBon3HtCvNoXXO3D5nmi9CxLasL/ndMxZL5XGufAkC1TeZ2r7Z
 4kbA==
X-Gm-Message-State: AOJu0YwJC9yptCwj4n+OFlmF90a1wRo6ScexjMJ0DiwiDardFxNzoNub
 IleHYsiLOsXgXTydoGlhOs8w4Q/A9DCDBcnufCgFtNXOOTugMdCHLbi5F1+CvK9ASLii+rS8TtU
 9ufY1AX4ViSStmGM2luqAgZBk9ePhAC1fML0XX8zjXxbP7IVBdajPhh0u5IntvWkqZZB/7DH4DA
 XSW07FoyYCOf8z/FwoC5CDGvJoiab6gAp2/n4R0ydXEsfTFnyCEdaTNXnjBkZzpr7K98RjDg==
X-Gm-Gg: ASbGncu3Vd8E1XTvHc9mLXzPJmB3DbNUZBld1d60xAIWWZmwYMK/rrp5OsLuPRYH3FY
 Kjq05kzue4jGDdvxCxAMnBxulm13VfKozd+Q0oQItqA5hpmlDAsZHL4b5A4jpFohij/sXrRa4I9
 gVF+a6C5tESTsJXy6DdXAmRZNvlJTSURE1OknL/TvVfpzN/XrLR9oQgRtHn3Od1ZdpvCQsSC/xi
 uJhOpHuzgu+Eg7mP2imM65iDxnIA2HGidDBe+IOu+xMuueddUPZ45jUzf2wdOfNdzC/v93NveDH
 puDmW6EBrprlhd8NnRWChKUVQNX/WBdqjVantkNXq6zTRvEGJKsA5T+v09rK+8KnJN0OIfyej6J
 9cGZO5apVYrcUbIikGgaLYKfaK4TkrIhhDDuvfFdlImUU0+VN9ewmNTZjlU5t0YIdi7LfqH7OwF
 csSw==
X-Google-Smtp-Source: AGHT+IEwFUov+Qw5g93yfUc8FkaEwFy1Nz9QYK2q2Yh1X6n1b1phRJ+WTtIA9mz0MQLp97hKWnJnD4LmHPgf
X-Received: by 2002:a05:6e02:2142:b0:41b:6e7b:3e9f with SMTP id
 e9e14a558f8ab-4259563bdebmr242916475ab.19.1759192640296; 
 Mon, 29 Sep 2025 17:37:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-572d4ddcb4esm310018173.5.2025.09.29.17.37.18
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-780f914b5a4so4963728b3a.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192637; x=1759797437; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9EtDqChgs11ff3HdlP+YBFHRiW51mcpPlRLZQSeyGA=;
 b=Z2ENvRW/s2rjzwqR26peV8ZHwEYHNAMwufJ6F9RQq9SqFcj5TfAiMklZoAXhuCNfHm
 WNWUxQIpIY8OkSb9S4yDqvIwXOQ+ZRU3mscRDZwjEl1mcH6wUFTMhhFxkqSKkB+6E75P
 eCORT9+Xd2q3mbmTFJr7v2HIE+1YhGNroSuGE=
X-Received: by 2002:a05:6a20:d491:b0:2f3:f59b:3b03 with SMTP id
 adf61e73a8af0-2f3f59b5a96mr16812216637.42.1759192636205; 
 Mon, 29 Sep 2025 17:37:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:d491:b0:2f3:f59b:3b03 with SMTP id
 adf61e73a8af0-2f3f59b5a96mr16812142637.42.1759192634646; 
 Mon, 29 Sep 2025 17:37:14 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:14 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Jay Ding <jay.ding@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH 30/54] net/bnxt/tf_core: truflow global table scope
Date: Mon, 29 Sep 2025 20:35:40 -0400
Message-Id: <20250930003604.87108-31-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:07 +0200
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

From: Farah Smith <farah.smith@broadcom.com>

1. Add support for a global table scope used for socket direct
   applications.  Create database, select database based upon table
   scope supplied.  Table scopes can now be one of 3 types: global,
   shared application and non-shared.
2. Fix issue when shutting down DPDK.  Firmware deconfigures the
   table scope when the fid is removed so no need to issue deconfig,
   just free the memory.

Signed-off-by: Farah Smith <farah.smith@broadcom.com>
Reviewed-by: Jay Ding <jay.ding@broadcom.com>
Reviewed-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Manish Kurup <manish.kurup@broadcom.com>
Reviewed-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c                |  53 ++---
 .../net/bnxt/hcapi/cfa_v3/include/cfa_types.h |  10 +
 drivers/net/bnxt/hsi_struct_def_dpdk.h        | 221 +++++++++++++++---
 drivers/net/bnxt/tf_core/v3/tfc.h             |  81 ++++---
 drivers/net/bnxt/tf_core/v3/tfc_act.c         |  32 +--
 drivers/net/bnxt/tf_core/v3/tfc_cpm.c         |  13 ++
 drivers/net/bnxt/tf_core/v3/tfc_em.c          |  16 +-
 drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c   |  16 +-
 drivers/net/bnxt/tf_core/v3/tfc_msg.c         |  63 +++--
 drivers/net/bnxt/tf_core/v3/tfc_msg.h         |   8 +-
 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c   | 205 ++++++++--------
 drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c  |   2 +-
 drivers/net/bnxt/tf_core/v3/tfc_util.c        |  15 ++
 drivers/net/bnxt/tf_core/v3/tfc_util.h        |  11 +
 drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.c   |   3 +-
 drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.h   |   4 +-
 drivers/net/bnxt/tf_core/v3/tfo.c             | 214 ++++++++++++-----
 drivers/net/bnxt/tf_core/v3/tfo.h             |  39 ++--
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c        |  70 ++++--
 .../net/bnxt/tf_ulp/ulp_template_db_enum.h    |   3 +-
 20 files changed, 716 insertions(+), 363 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 7177941e09..fad357f3ae 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -6147,37 +6147,6 @@ bnxt_parse_devarg_app_id(__rte_unused const char *key,
 	return 0;
 }
 
-static int
-bnxt_parse_devarg_mpc(__rte_unused const char *key,
-		      const char *value, __rte_unused void *opaque_arg)
-{
-	char *end = NULL;
-
-	if (!value || !opaque_arg) {
-		PMD_DRV_LOG_LINE(ERR,
-				 "Invalid parameter passed to app-id "
-				 "devargs");
-		return -EINVAL;
-	}
-
-	mpc = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (mpc == ULONG_MAX && errno == ERANGE)) {
-		PMD_DRV_LOG_LINE(ERR, "Invalid parameter passed to mpc "
-				 "devargs");
-		return -EINVAL;
-	}
-
-	if (BNXT_DEVARG_MPC_INVALID(mpc)) {
-		PMD_DRV_LOG_LINE(ERR, "Invalid mpc(%d) devargs",
-				 (uint16_t)mpc);
-		return -EINVAL;
-	}
-
-	PMD_DRV_LOG_LINE(INFO, "MPC%d feature enabled", (uint16_t)mpc);
-	return 0;
-}
-
 static int
 bnxt_parse_devarg_ieee_1588(__rte_unused const char *key,
 			    const char *value, void *opaque_arg)
@@ -6214,6 +6183,14 @@ bnxt_parse_devarg_ieee_1588(__rte_unused const char *key,
 	return 0;
 }
 
+static int
+bnxt_parse_devarg_mpc(__rte_unused const char *key,
+		      __rte_unused const char *value, __rte_unused void *opaque_arg)
+{
+	PMD_DRV_LOG_LINE(INFO, "mpc=1 arg not required.");
+	return 0;
+}
+
 static int
 bnxt_parse_devarg_rep_is_pf(__rte_unused const char *key,
 			    const char *value, void *opaque_arg)
@@ -6527,6 +6504,13 @@ bnxt_parse_dev_args(struct bnxt *bp, struct rte_devargs *devargs)
 		goto err;
 
 err:
+	/*
+	 * Handler for "mpc" devarg.
+	 * Invoked as for ex: "-a 000:00:0d.0,mpc=1"
+	 */
+	rte_kvargs_process(kvlist, BNXT_DEVARG_MPC,
+			   bnxt_parse_devarg_mpc, bp);
+
 	/*
 	 * Handler for "app-id" devarg.
 	 * Invoked as for ex: "-a 000:00:0d.0,app-id=1"
@@ -6541,13 +6525,6 @@ bnxt_parse_dev_args(struct bnxt *bp, struct rte_devargs *devargs)
 	rte_kvargs_process(kvlist, BNXT_DEVARG_IEEE_1588,
 			   bnxt_parse_devarg_ieee_1588, bp);
 
-	/*
-	 * Handler for "mpc" devarg.
-	 * Invoked as for ex: "-a 000:00:0d.0,mpc=1"
-	 */
-	rte_kvargs_process(kvlist, BNXT_DEVARG_MPC,
-			   bnxt_parse_devarg_mpc, bp);
-
 	/*
 	 * Handler for "cqe-mode" devarg.
 	 * Invoked as for ex: "-a 000:00:0d.0,cqe-mode=1"
diff --git a/drivers/net/bnxt/hcapi/cfa_v3/include/cfa_types.h b/drivers/net/bnxt/hcapi/cfa_v3/include/cfa_types.h
index 4339fc1053..b00b21385d 100644
--- a/drivers/net/bnxt/hcapi/cfa_v3/include/cfa_types.h
+++ b/drivers/net/bnxt/hcapi/cfa_v3/include/cfa_types.h
@@ -92,6 +92,16 @@ enum cfa_app_type {
 	CFA_APP_TYPE_INVALID = CFA_APP_TYPE_MAX,
 };
 
+/**
+ * CFA table scope types
+ */
+enum cfa_scope_type {
+	CFA_SCOPE_TYPE_NON_SHARED = 0,
+	CFA_SCOPE_TYPE_SHARED_APP = 1,
+	CFA_SCOPE_TYPE_GLOBAL = 2,
+	CFA_SCOPE_TYPE_INVALID = 3
+};
+
 /**
  * CFA FID types
  */
diff --git a/drivers/net/bnxt/hsi_struct_def_dpdk.h b/drivers/net/bnxt/hsi_struct_def_dpdk.h
index 6e540359e3..866fc5379d 100644
--- a/drivers/net/bnxt/hsi_struct_def_dpdk.h
+++ b/drivers/net/bnxt/hsi_struct_def_dpdk.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright (c) 2014-2024 Broadcom Inc.
+ * Copyright (c) 2014-2025 Broadcom Inc.
  * All rights reserved.
  *
  * DO NOT MODIFY!!! This file is automatically generated.
@@ -804,6 +804,20 @@ struct __rte_packed_begin cmd_nums {
 	#define HWRM_MFG_PRVSN_EXPORT_CERT                UINT32_C(0x219)
 	/* Query the statistics for doorbell drops due to various error conditions. */
 	#define HWRM_STAT_DB_ERROR_QSTATS                 UINT32_C(0x21a)
+	/* This command is used to select and run manufacturing tests */
+	#define HWRM_MFG_TESTS                            UINT32_C(0x21b)
+	/* This command is used to write a cert chain from production firmware */
+	#define HWRM_MFG_WRITE_CERT_NVM                   UINT32_C(0x21c)
+	/*
+	 * The command is used to enable/disable the power on ethernet for
+	 * a particular I/O expander port.
+	 */
+	#define HWRM_PORT_POE_CFG                         UINT32_C(0x230)
+	/*
+	 * The command is used to query whether the power on ethernet
+	 * is enabled/disabled for a particular I/O expander port.
+	 */
+	#define HWRM_PORT_POE_QCFG                        UINT32_C(0x231)
 	/*
 	 * This command returns the capabilities related to User Defined
 	 * Congestion Control on a function.
@@ -1252,8 +1266,8 @@ struct __rte_packed_begin hwrm_err_output {
 #define HWRM_VERSION_MINOR 10
 #define HWRM_VERSION_UPDATE 3
 /* non-zero means beta version */
-#define HWRM_VERSION_RSVD 87
-#define HWRM_VERSION_STR "1.10.3.87"
+#define HWRM_VERSION_RSVD 97
+#define HWRM_VERSION_STR "1.10.3.97"
 
 /****************
  * hwrm_ver_get *
@@ -12647,9 +12661,9 @@ struct __rte_packed_begin hwrm_async_event_cmpl_dbg_buf_producer {
 	 * value of 8192. This field rolls over to zero once the firmware
 	 * writes the last page of the host buffer
 	 */
-	#define HWRM_ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA2_CURRENT_BUFFER_OFFSET_MASK \
+	#define HWRM_ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA2_CURR_OFF_MASK \
 		UINT32_C(0xffffffff)
-	#define HWRM_ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA2_CURRENT_BUFFER_OFFSET_SFT \
+	#define HWRM_ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA2_CURR_OFF_SFT \
 		0
 	uint8_t	opaque_v;
 	/*
@@ -15718,6 +15732,18 @@ struct __rte_packed_begin hwrm_func_qcaps_output {
 	 */
 	#define HWRM_FUNC_QCAPS_OUTPUT_FLAGS_EXT3_RX_RATE_PROFILE_SEL_SUPPORTED \
 		UINT32_C(0x8)
+	/*
+	 * When set to 1, indicates that the device is capable of supporting
+	 * the RoCE bi-directional optimization feature.
+	 */
+	#define HWRM_FUNC_QCAPS_OUTPUT_FLAGS_EXT3_BIDI_OPT_SUPPORTED \
+		UINT32_C(0x10)
+	/*
+	 * When set to 1, indicates that the device is capable of supporting
+	 * port mirroring on RoCE device.
+	 */
+	#define HWRM_FUNC_QCAPS_OUTPUT_FLAGS_EXT3_MIRROR_ON_ROCE_SUPPORTED \
+		UINT32_C(0x20)
 	/*
 	 * The number of VFs that can be used for RoCE on the function. If less
 	 * than max_vfs, roce vfs will be assigned to the first VF of the
@@ -15725,7 +15751,13 @@ struct __rte_packed_begin hwrm_func_qcaps_output {
 	 * This is valid only on the PF with SR-IOV and RDMA enabled.
 	 */
 	uint16_t	max_roce_vfs;
-	uint8_t	unused_3[5];
+	/*
+	 * The maximum number of Rx flow filters for KTLS and QUIC. If both
+	 * KTLS and QUIC are enabled, then this maximum number is shared
+	 * between them.
+	 */
+	uint16_t	max_crypto_rx_flow_filters;
+	uint8_t	unused_3[3];
 	/*
 	 * This field is used in Output records to indicate that the output
 	 * is completely written to RAM. This field should be read as '1'
@@ -16426,8 +16458,19 @@ struct __rte_packed_begin hwrm_func_qcfg_output {
 	 * value is used if ring MTU is not specified.
 	 */
 	uint16_t	host_mtu;
-	uint8_t	unused_3[2];
-	uint8_t	unused_4[2];
+	uint16_t	flags2;
+	/*
+	 * If set to 1, then VF drivers are requested to insert a DSCP
+	 * value into all outgoing L2 packets such that DSCP=VF ID modulo 64
+	 */
+	#define HWRM_FUNC_QCFG_OUTPUT_FLAGS2_SRIOV_DSCP_INSERT_ENABLED \
+		UINT32_C(0x1)
+	/*
+	 * This value is the S-tag VLAN identifier setting for the function
+	 * when in NPAR 1.2 mode. This field is read from firmware and is
+	 * in LE order.
+	 */
+	uint16_t	stag_vid;
 	/*
 	 * KDNet mode for the port for this function. If a VF, KDNet
 	 * mode is always disabled.
@@ -16450,7 +16493,23 @@ struct __rte_packed_begin hwrm_func_qcfg_output {
 	 * feature, 0xffff will be returned.
 	 */
 	uint16_t	port_kdnet_fid;
-	uint8_t	unused_5[2];
+	uint8_t	unused_5;
+	uint8_t	roce_bidi_opt_mode;
+	/* RoCE bi-directional optimization feature is disabled. */
+	#define HWRM_FUNC_QCFG_OUTPUT_ROCE_BIDI_OPT_MODE_DISABLED \
+		UINT32_C(0x1)
+	/*
+	 * Requester and Responder traffic use separate transmit scheduler
+	 * queues and CoSQs.
+	 */
+	#define HWRM_FUNC_QCFG_OUTPUT_ROCE_BIDI_OPT_MODE_DEDICATED \
+		UINT32_C(0x2)
+	/*
+	 * Requester and Responder traffic use separate transmit scheduler
+	 * queues, but share the same CoSQ.
+	 */
+	#define HWRM_FUNC_QCFG_OUTPUT_ROCE_BIDI_OPT_MODE_SHARED \
+		UINT32_C(0x4)
 	/* Number of KTLS Tx Key Contexts allocated. */
 	uint32_t	num_ktls_tx_key_ctxs;
 	/* Number of KTLS Rx Key Contexts allocated. */
@@ -16525,7 +16584,13 @@ struct __rte_packed_begin hwrm_func_qcfg_output {
 	 * partition on Rx crypto key contexts.
 	 */
 	#define HWRM_FUNC_QCFG_OUTPUT_XID_PARTITION_CFG_RX_CK     UINT32_C(0x2)
-	uint8_t	unused_7;
+	/*
+	 * The VNIC ID used for mirroring. This VNIC is pre-reserved.
+	 * This VNIC could be used for mirroring to a single L2 ring
+	 * or a raw QP.
+	 */
+	uint16_t	mirror_vnic_id;
+	uint8_t	unused_7[7];
 	/*
 	 * This field is used in Output records to indicate that the output
 	 * is completely written to RAM. This field should be read as '1'
@@ -24348,8 +24413,10 @@ struct __rte_packed_begin hwrm_func_backing_store_qcfg_v2_output {
 	uint8_t	valid;
 } __rte_packed_end;
 
-/* Common structure to cast QPC split entries. This casting is required in the
- * following HWRM command inputs/outputs if the backing store type is QPC.
+/*
+ * Common structure to cast QPC split entries. This casting is required
+ * in the following HWRM command inputs/outputs if the backing store
+ * type is QPC.
  * 1. hwrm_func_backing_store_cfg_v2_input
  * 2. hwrm_func_backing_store_qcfg_v2_output
  * 3. hwrm_func_backing_store_qcaps_v2_output
@@ -24368,8 +24435,10 @@ struct __rte_packed_begin qpc_split_entries {
 	uint32_t	rsvd;
 } __rte_packed_end;
 
-/* Common structure to cast SRQ split entries. This casting is required in the
- * following HWRM command inputs/outputs if the backing store type is SRQ.
+/*
+ * Common structure to cast SRQ split entries. This casting is required
+ * in the following HWRM command inputs/outputs if the backing store
+ * type is SRQ.
  * 1. hwrm_func_backing_store_cfg_v2_input
  * 2. hwrm_func_backing_store_qcfg_v2_output
  * 3. hwrm_func_backing_store_qcaps_v2_output
@@ -24382,8 +24451,10 @@ struct __rte_packed_begin srq_split_entries {
 	uint32_t	rsvd2[2];
 } __rte_packed_end;
 
-/* Common structure to cast CQ split entries. This casting is required in the
- * following HWRM command inputs/outputs if the backing store type is CQ.
+/*
+ * Common structure to cast CQ split entries. This casting is required
+ * in the following HWRM command inputs/outputs if the backing store
+ * type is CQ.
  * 1. hwrm_func_backing_store_cfg_v2_input
  * 2. hwrm_func_backing_store_qcfg_v2_output
  * 3. hwrm_func_backing_store_qcaps_v2_output
@@ -24396,8 +24467,10 @@ struct __rte_packed_begin cq_split_entries {
 	uint32_t	rsvd2[2];
 } __rte_packed_end;
 
-/* Common structure to cast VNIC split entries. This casting is required in the
- * following HWRM command inputs/outputs if the backing store type is VNIC.
+/*
+ * Common structure to cast VNIC split entries. This casting is required
+ * in the following HWRM command inputs/outputs if the backing store
+ * type is VNIC.
  * 1. hwrm_func_backing_store_cfg_v2_input
  * 2. hwrm_func_backing_store_qcfg_v2_output
  * 3. hwrm_func_backing_store_qcaps_v2_output
@@ -24410,8 +24483,10 @@ struct __rte_packed_begin vnic_split_entries {
 	uint32_t	rsvd2[2];
 } __rte_packed_end;
 
-/* Common structure to cast MRAV split entries. This casting is required in the
- * following HWRM command inputs/outputs if the backing store type is MRAV.
+/*
+ * Common structure to cast MRAV split entries. This casting is required
+ * in the following HWRM command inputs/outputs if the backing store
+ * type is MRAV.
  * 1. hwrm_func_backing_store_cfg_v2_input
  * 2. hwrm_func_backing_store_qcfg_v2_output
  * 3. hwrm_func_backing_store_qcaps_v2_output
@@ -24424,9 +24499,10 @@ struct __rte_packed_begin mrav_split_entries {
 	uint32_t	rsvd2[2];
 } __rte_packed_end;
 
-/* Common structure to cast TBL_SCOPE split entries. This casting is required
- * in the following HWRM command inputs/outputs if the backing store type is
- * TBL_SCOPE.
+/*
+ * Common structure to cast TBL_SCOPE split entries. This casting is
+ * required in the following HWRM command inputs/outputs if the backing
+ * store type is TBL_SCOPE.
  * 1. hwrm_func_backing_store_cfg_v2_input
  * 2. hwrm_func_backing_store_qcfg_v2_output
  * 3. hwrm_func_backing_store_qcaps_v2_output
@@ -24442,13 +24518,15 @@ struct __rte_packed_begin ts_split_entries {
 	 * Array is indexed by enum cfa_dir
 	 */
 	uint8_t	lkup_static_bkt_cnt_exp[2];
-	uint8_t	rsvd;
+	/* Indicates the region is locked in the cache */
+	uint8_t	locked;
 	uint32_t	rsvd2[2];
-} __rte_packed_end;
+} __rte_packed;
 
-/* Common structure to cast crypto key split entries. This casting is required
- * in the following HWRM command inputs/outputs if the backing store type is
- * TX_CK or RX_CK.
+/*
+ * Common structure to cast crypto key split entries. This casting is
+ * required in the following HWRM command inputs/outputs if the backing
+ * store type is TX_CK or RX_CK.
  * 1. hwrm_func_backing_store_cfg_v2_input
  * 2. hwrm_func_backing_store_qcfg_v2_output
  * 3. hwrm_func_backing_store_qcaps_v2_output
@@ -42583,13 +42661,20 @@ struct __rte_packed_begin hwrm_vnic_alloc_input {
 	 */
 	#define HWRM_VNIC_ALLOC_INPUT_FLAGS_VIRTIO_NET_FID_VALID \
 		UINT32_C(0x2)
+	/*
+	 * When this bit is '1', firmware will allocate the VNIC
+	 * specified in vnic_id field.
+	 */
+	#define HWRM_VNIC_ALLOC_INPUT_FLAGS_VNIC_ID_VALID \
+		UINT32_C(0x4)
 	/*
 	 * Virtio-net function's FID.
 	 * This virtio-net function is requesting allocation of default
 	 * VNIC through proxy VEE PF.
 	 */
 	uint16_t	virtio_net_fid;
-	uint8_t	unused_0[2];
+	/* VNIC ID to allocate. */
+	uint16_t	vnic_id;
 } __rte_packed_end;
 
 /* hwrm_vnic_alloc_output (size:128b/16B) */
@@ -42958,6 +43043,9 @@ struct __rte_packed_begin hwrm_vnic_cfg_input {
 	/* This bit must be '1' for the l2_cqe_mode field to be configured. */
 	#define HWRM_VNIC_CFG_INPUT_ENABLES_L2_CQE_MODE \
 		UINT32_C(0x200)
+	/* This bit must be '1' for the raw_qp_id field to be configured. */
+	#define HWRM_VNIC_CFG_INPUT_ENABLES_RAW_QP_ID \
+		UINT32_C(0x400)
 	/* Logical vnic ID */
 	uint16_t	vnic_id;
 	/*
@@ -43080,7 +43168,8 @@ struct __rte_packed_begin hwrm_vnic_cfg_input {
 	#define HWRM_VNIC_CFG_INPUT_L2_CQE_MODE_MIXED      UINT32_C(0x2)
 	#define HWRM_VNIC_CFG_INPUT_L2_CQE_MODE_LAST \
 		HWRM_VNIC_CFG_INPUT_L2_CQE_MODE_MIXED
-	uint8_t	unused0[4];
+	/* Raw QP ID to be used for the VNIC. */
+	uint32_t	raw_qp_id;
 } __rte_packed_end;
 
 /* hwrm_vnic_cfg_output (size:128b/16B) */
@@ -44944,6 +45033,8 @@ struct __rte_packed_begin hwrm_vnic_plcmodes_cfg_input {
 	 * Packets with length larger than this value will be
 	 * placed according to the HDS placement algorithm.
 	 * This value shall be in multiple of 4 bytes.
+	 * HW supports only 10-bit value for hds_threshold. If this value is
+	 * more than 0x3FF, FW will fail this command.
 	 */
 	uint16_t	hds_threshold;
 	/*
@@ -44985,6 +45076,24 @@ struct __rte_packed_begin hwrm_vnic_plcmodes_cfg_output {
 	uint8_t	valid;
 } __rte_packed_end;
 
+/* hwrm_vnic_plcmodes_cfg_cmd_err (size:64b/8B) */
+struct hwrm_vnic_plcmodes_cfg_cmd_err {
+	/*
+	 * command specific error codes that goes to
+	 * the cmd_err field in common HWRM Error Response.
+	 */
+	uint8_t	code;
+	/* Unknown error */
+	#define HWRM_VNIC_PLCMODES_CFG_CMD_ERR_CODE_UNKNOWN \
+		UINT32_C(0x0)
+	/* hds_threshold value is invalid */
+	#define HWRM_VNIC_PLCMODES_CFG_CMD_ERR_CODE_INVALID_HDS_THRESHOLD \
+		UINT32_C(0x1)
+	#define HWRM_VNIC_PLCMODES_CFG_CMD_ERR_CODE_LAST \
+		HWRM_VNIC_PLCMODES_CFG_CMD_ERR_CODE_INVALID_HDS_THRESHOLD
+	uint8_t	unused_0[7];
+} __rte_packed;
+
 /***************************
  * hwrm_vnic_plcmodes_qcfg *
  ***************************/
@@ -45408,7 +45517,10 @@ struct __rte_packed_begin hwrm_ring_alloc_input {
 	#define HWRM_RING_ALLOC_INPUT_CMPL_COAL_CNT_COAL_320 UINT32_C(0xd)
 	/* Generates a TX coalesced completion for up to 384 TX packets. */
 	#define HWRM_RING_ALLOC_INPUT_CMPL_COAL_CNT_COAL_384 UINT32_C(0xe)
-	/* Generates a TX coalesced completion up to the last packet. (Maximum coalescing). */
+	/*
+	 * Generates a TX coalesced completion up to the last packet.
+	 * (Maximum coalescing).
+	 */
 	#define HWRM_RING_ALLOC_INPUT_CMPL_COAL_CNT_COAL_MAX UINT32_C(0xf)
 	#define HWRM_RING_ALLOC_INPUT_CMPL_COAL_CNT_LAST \
 		HWRM_RING_ALLOC_INPUT_CMPL_COAL_CNT_COAL_MAX
@@ -59915,8 +60027,32 @@ struct __rte_packed_begin hwrm_tfc_tbl_scope_qcaps_output {
 	 * support. This field is only valid if tbl_scope_capable is not zero.
 	 */
 	uint8_t	max_lkup_static_buckets_exp;
+	/* Control flags. */
+	uint8_t	flags;
+	/* Indicates whether a global scope is supported in the firmware. */
+	#define HWRM_TFC_TBL_SCOPE_QCAPS_OUTPUT_FLAGS_GLOBAL \
+		UINT32_C(0x1)
+	/* If this bit set to 0, a global scope is not supported */
+	#define HWRM_TFC_TBL_SCOPE_QCAPS_OUTPUT_FLAGS_GLOBAL_UNSUPPORTED \
+		UINT32_C(0x0)
+	/* If this bit is set to 1, a global scope is supported */
+	#define HWRM_TFC_TBL_SCOPE_QCAPS_OUTPUT_FLAGS_GLOBAL_SUPPORTED \
+		UINT32_C(0x1)
+	#define HWRM_TFC_TBL_SCOPE_QCAPS_OUTPUT_FLAGS_GLOBAL_LAST \
+		HWRM_TFC_TBL_SCOPE_QCAPS_OUTPUT_FLAGS_GLOBAL_SUPPORTED
+	/* Indicates whether a locked scope is supported in the firmware. */
+	#define HWRM_TFC_TBL_SCOPE_QCAPS_OUTPUT_FLAGS_LOCKED \
+		UINT32_C(0x2)
+	/* If this bit set to 0, a locked scope is not supported */
+	#define HWRM_TFC_TBL_SCOPE_QCAPS_OUTPUT_FLAGS_LOCKED_UNSUPPORTED \
+		(UINT32_C(0x0) << 1)
+	/* If this bit is set to 1, a locked scope is supported */
+	#define HWRM_TFC_TBL_SCOPE_QCAPS_OUTPUT_FLAGS_LOCKED_SUPPORTED \
+		(UINT32_C(0x1) << 1)
+	#define HWRM_TFC_TBL_SCOPE_QCAPS_OUTPUT_FLAGS_LOCKED_LAST \
+		HWRM_TFC_TBL_SCOPE_QCAPS_OUTPUT_FLAGS_LOCKED_SUPPORTED
 	/* unused. */
-	uint8_t	unused0[5];
+	uint8_t	unused0[4];
 	/*
 	 * This field is used in Output records to indicate that the output
 	 * is completely written to RAM. This field should be read as '1'
@@ -60001,8 +60137,27 @@ struct __rte_packed_begin hwrm_tfc_tbl_scope_id_alloc_input {
 	uint8_t	act_pool_sz_exp[2];
 	/* Application type. 0 (AFM), 1 (TF) */
 	uint8_t	app_type;
+	/*
+	 * Specifies the type of table scope. Overrides the shared flag if set.
+	 * If set, this field takes precedent over the shared flag.
+	 */
+	uint8_t	scope_type;
+	/* A table scope not shared between functions */
+	#define HWRM_TFC_TBL_SCOPE_ID_ALLOC_INPUT_SCOPE_TYPE_NON_SHARED \
+		UINT32_C(0x1)
+	/*
+	 * A table scope shared between functions which share the same parent
+	 * PF.
+	 */
+	#define HWRM_TFC_TBL_SCOPE_ID_ALLOC_INPUT_SCOPE_TYPE_SHARED_APP \
+		UINT32_C(0x2)
+	/* A global table scope accessible by any function (e.g. LAG) */
+	#define HWRM_TFC_TBL_SCOPE_ID_ALLOC_INPUT_SCOPE_TYPE_GLOBAL \
+		UINT32_C(0x3)
+	#define HWRM_TFC_TBL_SCOPE_ID_ALLOC_INPUT_SCOPE_TYPE_LAST \
+		HWRM_TFC_TBL_SCOPE_ID_ALLOC_INPUT_SCOPE_TYPE_GLOBAL
 	/* unused. */
-	uint8_t	unused0[6];
+	uint8_t	unused0[5];
 } __rte_packed_end;
 
 /* hwrm_tfc_tbl_scope_id_alloc_output (size:128b/16B) */
diff --git a/drivers/net/bnxt/tf_core/v3/tfc.h b/drivers/net/bnxt/tf_core/v3/tfc.h
index 2195c0035d..18af4a71d9 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc.h
+++ b/drivers/net/bnxt/tf_core/v3/tfc.h
@@ -762,14 +762,12 @@ enum tfc_tbl_scope_bucket_factor {
  * tfc_tbl_scope_size_query API.
  */
 struct tfc_tbl_scope_size_query_parms {
-	/**
-	 * [in] If a shared table scope, dynamic buckets are disabled. This
-	 * affects the calculation for static buckets in this function.
-	 * Initially, if not shared, the size of the static bucket table should
-	 * be double the number of flows supported. Numbers are validated
-	 * against static_cnt and dynamic_cnt
+	/** Scope is one of non-shared, shared-app or global.
+	 * If a shared-app or global table scope, dynamic buckets are disabled.
+	 * this combined with the multiplier affects the calculation for static
+	 * buckets in this function.
 	 */
-	bool shared;
+	enum cfa_scope_type scope_type;
 	/**
 	 * [in] Direction indexed array indicating the number of flows.  Must be
 	 * at least as large as the number entries that the buckets can point
@@ -852,6 +850,12 @@ struct tfc_tbl_scope_size_query_parms {
  * to be used by a table scope.
  */
 struct tfc_tbl_scope_mem_alloc_parms {
+	/** Scope is one of non-shared, shared-app or global.
+	 * If a shared-app or global table scope, dynamic buckets are disabled.
+	 * this combined with the multiplier affects the calculation for static
+	 * buckets in this function.
+	 */
+	enum cfa_scope_type scope_type;
 	/**
 	 * [in] If a shared table scope, indicate whether this is the first
 	 * if, the first, the table scope memory will be allocated.  Otherwise
@@ -920,32 +924,51 @@ struct tfc_tbl_scope_mem_alloc_parms {
 	uint32_t lkup_rec_start_offset[CFA_DIR_MAX];
 };
 
+
+/**
+ * tfc_tbl_scope_qcaps_parms contains the parameters for determining
+ * the table scope capabilities
+ */
+struct tfc_tbl_scope_qcaps_parms {
+	/**
+	 * [out] if true, the device supports a table scope.
+	 */
+	bool tbl_scope_cap;
+	/**
+	 * [out] if true, the device supports a global table scope.
+	 */
+	bool global_cap;
+	/**
+	 * [out] if true, the device supports locked regions.
+	 */
+	bool locked_cap;
+	/**
+	 * [out] the maximum number of static buckets supported.
+	 */
+	uint8_t max_lkup_static_bucket_exp;
+	/**
+	 * [out] The maximum number of minimum sized lkup records supported.
+	 */
+	uint32_t max_lkup_rec_cnt;
+	/**
+	 * [out] The maximum number of  minimum sized action records supported.
+	 */
+	uint32_t max_act_rec_cnt;
+};
+
 /**
  * Determine whether table scopes are supported in the hardware.
  *
  * @param[in] tfcp
  *   Pointer to TFC handle
  *
- * @param[out] tbl_scope_capable
- *   True if table scopes are supported in the firmware.
- *
- * @param[out] max_lkup_rec_cnt
- *   The maximum number of lookup records in a table scope (optional)
- *
- * @param[out] max_act_rec_cnt
- *   The maximum number of action records in a table scope (optional)
- *
- * @param[out] max_lkup_static_buckets_exp
- *   The log2 of the maximum number of lookup static buckets in a table scope
- *   (optional)
+ * @param[in,out] parms
  *
  * @returns
  *   0 for SUCCESS, negative error value for FAILURE (errno.h)
  */
-int tfc_tbl_scope_qcaps(struct tfc *tfcp, bool *tbl_scope_capable,
-			uint32_t *max_lkup_rec_cnt,
-			uint32_t *max_act_rec_cnt,
-			uint8_t	*max_lkup_static_buckets_exp);
+int tfc_tbl_scope_qcaps(struct tfc *tfcp,
+			struct tfc_tbl_scope_qcaps_parms *parms);
 
 /**
  * Determine table scope sizing
@@ -968,8 +991,8 @@ int tfc_tbl_scope_size_query(struct tfc *tfcp,
  * @param[in] tfcp
  *   Pointer to TFC handle
  *
- * @param[in] shared
- *   Create a shared table scope.
+ * @param[in] scope_type
+ *   non-shared, shared-app or global
  *
  * @param[in] app_type
  *   The application type, TF or AFM
@@ -984,7 +1007,7 @@ int tfc_tbl_scope_size_query(struct tfc *tfcp,
  * @returns
  *	 0 for SUCCESS, negative error value for FAILURE (errno.h)
  */
-int tfc_tbl_scope_id_alloc(struct tfc *tfcp, bool shared,
+int tfc_tbl_scope_id_alloc(struct tfc *tfcp, enum cfa_scope_type scope_type,
 			   enum cfa_app_type app_type, uint8_t *tsid,
 			   bool *first);
 
@@ -1023,10 +1046,14 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
  * @param[in] tsid
  *   Table scope identifier
  *
+ * @param[in] fid_cnt
+ *   Used for global scope cleanup.  If a fid remains, do not delete scope
+ *
  * @returns
  *   0 for SUCCESS, negative error value for FAILURE (errno.h)
  */
-int tfc_tbl_scope_mem_free(struct tfc *tfcp, uint16_t fid, uint8_t tsid);
+int tfc_tbl_scope_mem_free(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
+			   uint16_t fid_cnt);
 
 /**
  * tfc_tbl_scope_cpm_alloc_parms contains the parameters for allocating a
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_act.c b/drivers/net/bnxt/tf_core/v3/tfc_act.c
index 7b1f82b842..3c1c76359b 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_act.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_act.c
@@ -45,12 +45,12 @@ int tfc_act_alloc(struct tfc *tfcp,
 	struct tfc_cmm *cmm;
 	uint32_t entry_offset;
 	struct cfa_mm_alloc_parms aparms;
-	bool is_shared;
+	enum cfa_scope_type scope_type;
 	struct tfc_ts_pool_info pi;
 	bool valid;
 	uint16_t max_pools;
 
-	rc = tfo_ts_get(tfcp->tfo, tsid, &is_shared, NULL, &valid, &max_pools);
+	rc = tfo_ts_get(tfcp->tfo, tsid, &scope_type, NULL, &valid, &max_pools);
 	if (unlikely(rc)) {
 		PMD_DRV_LOG_LINE(ERR, "failed to get tsid: %s", strerror(-rc));
 		return -EINVAL;
@@ -67,7 +67,11 @@ int tfc_act_alloc(struct tfc *tfcp,
 		return -EINVAL;
 	}
 
-	tfo_ts_get_pool_info(tfcp->tfo, tsid, cmm_info->dir, &pi);
+	rc = tfo_ts_get_pool_info(tfcp->tfo, tsid, cmm_info->dir, &pi);
+	if (unlikely(rc)) {
+		PMD_DRV_LOG_LINE(ERR, "%s: failed to get pool info: %s",
+				 __func__, strerror(-rc));
+	}
 
 	/* Get CPM instances */
 	rc = tfo_ts_get_cpm_inst(tfcp->tfo, tsid, cmm_info->dir, &cpm_lkup, &cpm_act);
@@ -99,8 +103,9 @@ int tfc_act_alloc(struct tfc *tfcp,
 		/* There is only 1 pool for a non-shared table scope
 		 * and it is full.
 		 */
-		if (unlikely(!is_shared)) {
-			PMD_DRV_LOG_LINE(ERR, "no records remain");
+		if (unlikely(scope_type == CFA_SCOPE_TYPE_NON_SHARED)) {
+			PMD_DRV_LOG_LINE(ERR, "%s: no records remain",
+					 __func__);
 			return -ENOMEM;
 		}
 		rc = tfc_get_fid(tfcp, &fid);
@@ -157,7 +162,6 @@ int tfc_act_alloc(struct tfc *tfcp,
 			return -EINVAL;
 		}
 	}
-
 	aparms.num_contig_records = 1 << next_pow2(num_contig_rec);
 	rc = cfa_mm_alloc(cmm, &aparms);
 	if (unlikely(rc)) {
@@ -231,7 +235,7 @@ int tfc_act_set(struct tfc *tfcp,
 	struct cfa_bld_mpcinfo *mpc_info;
 	uint32_t record_size;
 	uint8_t tsid;
-	bool is_shared;
+	enum cfa_scope_type scope_type;
 	bool valid;
 
 	tfo_mpcinfo_get(tfcp->tfo, &mpc_info);
@@ -247,7 +251,7 @@ int tfc_act_set(struct tfc *tfcp,
 					  &record_size,
 					  &entry_offset);
 
-	rc = tfo_ts_get(tfcp->tfo, tsid, &is_shared, NULL, &valid, NULL);
+	rc = tfo_ts_get(tfcp->tfo, tsid, &scope_type, NULL, &valid, NULL);
 	if (unlikely(rc)) {
 		PMD_DRV_LOG_LINE(ERR, "failed to get tsid: %s", strerror(-rc));
 		return -EINVAL;
@@ -382,7 +386,7 @@ static int tfc_act_get_only(struct tfc *tfcp,
 	struct bnxt_mpc_mbuf mpc_msg_out;
 	uint32_t record_size;
 	uint8_t tsid;
-	bool is_shared;
+	enum cfa_scope_type scope_type;
 	struct cfa_bld_mpcinfo *mpc_info;
 	bool valid;
 
@@ -393,7 +397,7 @@ static int tfc_act_get_only(struct tfc *tfcp,
 					  &record_size,
 					  &entry_offset);
 
-	rc = tfo_ts_get(tfcp->tfo, tsid, &is_shared, NULL, &valid, NULL);
+	rc = tfo_ts_get(tfcp->tfo, tsid, &scope_type, NULL, &valid, NULL);
 	if (unlikely(rc)) {
 		PMD_DRV_LOG_LINE(ERR, "failed to get tsid: %s", strerror(-rc));
 		return -EINVAL;
@@ -561,7 +565,7 @@ static int tfc_act_get_clear(struct tfc *tfcp,
 	struct bnxt_mpc_mbuf mpc_msg_out;
 	uint32_t record_size;
 	uint8_t tsid;
-	bool is_shared;
+	enum cfa_scope_type scope_type;
 	struct cfa_bld_mpcinfo *mpc_info;
 	bool valid;
 	uint16_t mask = 0;
@@ -573,7 +577,7 @@ static int tfc_act_get_clear(struct tfc *tfcp,
 					  &record_size,
 					  &entry_offset);
 
-	rc = tfo_ts_get(tfcp->tfo, tsid, &is_shared, NULL, &valid, NULL);
+	rc = tfo_ts_get(tfcp->tfo, tsid, &scope_type, NULL, &valid, NULL);
 	if (unlikely(rc)) {
 		PMD_DRV_LOG_LINE(ERR, "failed to get tsid: %s",
 				 strerror(-rc));
@@ -739,7 +743,7 @@ int tfc_act_free(struct tfc *tfcp,
 	uint32_t record_offset;
 	struct cfa_mm_free_parms fparms;
 	uint8_t tsid;
-	bool is_shared;
+	enum cfa_scope_type scope_type;
 	bool valid;
 	bool is_bs_owner;
 	struct tfc_ts_mem_cfg mem_cfg;
@@ -750,7 +754,7 @@ int tfc_act_free(struct tfc *tfcp,
 					  &record_size,
 					  &record_offset);
 
-	rc = tfo_ts_get(tfcp->tfo, tsid, &is_shared, NULL, &valid, NULL);
+	rc = tfo_ts_get(tfcp->tfo, tsid, &scope_type, NULL, &valid, NULL);
 	if (unlikely(rc)) {
 		PMD_DRV_LOG_LINE(ERR, "failed to get tsid: %s", strerror(-rc));
 		return -EINVAL;
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_cpm.c b/drivers/net/bnxt/tf_core/v3/tfc_cpm.c
index 36a9189805..f58ec48db7 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_cpm.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_cpm.c
@@ -293,6 +293,10 @@ int tfc_cpm_set_cmm_inst(struct tfc_cpm *cpm, uint16_t pool_id, struct tfc_cmm *
 		return -EINVAL;
 	}
 
+	if (pool_id >= cpm->max_pools) {
+		PMD_DRV_LOG_LINE(ERR, "Pool ID:0x%x > max 0x%x", pool_id, cpm->max_pools);
+		return -EINVAL;
+	}
 	pool = &cpm->pools[pool_id];
 
 	if (pool->valid && cmm != NULL) {
@@ -324,6 +328,11 @@ int tfc_cpm_get_cmm_inst(struct tfc_cpm *cpm, uint16_t pool_id, struct tfc_cmm *
 		return -EINVAL;
 	}
 
+	if (pool_id >= cpm->max_pools) {
+		PMD_DRV_LOG_LINE(ERR, "Pool ID:0x%x > max 0x%x", pool_id, cpm->max_pools);
+		return -EINVAL;
+	}
+
 	pool = &cpm->pools[pool_id];
 
 	if (!pool->valid) {
@@ -359,6 +368,10 @@ int tfc_cpm_set_usage(struct tfc_cpm *cpm, uint16_t pool_id, uint32_t used_count
 		return -EINVAL;
 	}
 
+	if (pool_id >= cpm->max_pools) {
+		PMD_DRV_LOG_LINE(ERR, "Pool ID:0x%x > max 0x%x", pool_id, cpm->max_pools);
+		return -EINVAL;
+	}
 	pool = &cpm->pools[pool_id];
 
 	if (!pool->valid) {
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_em.c b/drivers/net/bnxt/tf_core/v3/tfc_em.c
index 8264f9a05d..828b7838f5 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_em.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_em.c
@@ -133,19 +133,18 @@ int tfc_em_insert(struct tfc *tfcp, uint8_t tsid,
 	uint32_t i;
 	uint32_t hash = 0;
 	struct cfa_mpc_data_obj fields_cmd[CFA_BLD_MPC_EM_INSERT_CMD_MAX_FLD];
-	bool is_shared;
+	enum cfa_scope_type scope_type;
 	struct cfa_bld_mpcinfo *mpc_info;
 	bool valid;
 	uint16_t max_pools;
 #if TFC_EM_DYNAMIC_BUCKET_EN
 	struct cfa_mm_alloc_parms bucket_aparms;
-	bool shared = false;
 	uint32_t bucket_offset;
 #endif
 
 	tfo_mpcinfo_get(tfcp->tfo, &mpc_info);
 
-	rc = tfo_ts_get(tfcp->tfo, tsid, &is_shared, NULL, &valid, &max_pools);
+	rc = tfo_ts_get(tfcp->tfo, tsid, &scope_type, NULL, &valid, &max_pools);
 	if (unlikely(rc)) {
 		PMD_DRV_LOG_LINE(ERR, "failed to get tsid: %s", strerror(-rc));
 		return -EINVAL;
@@ -202,8 +201,9 @@ int tfc_em_insert(struct tfc *tfcp, uint8_t tsid,
 		/* There is only 1 pool for a non-shared table scope and
 		 * it is full.
 		 */
-		if (!is_shared) {
-			PMD_DRV_LOG_LINE(ERR, "no records remain");
+		if (scope_type == CFA_SCOPE_TYPE_NON_SHARED) {
+			PMD_DRV_LOG_LINE(ERR, "%s: no records remain",
+					 __func__);
 			return -ENOMEM;
 		}
 
@@ -278,7 +278,7 @@ int tfc_em_insert(struct tfc *tfcp, uint8_t tsid,
 	}
 
 #if TFC_EM_DYNAMIC_BUCKET_EN
-	if (!shared) {
+	if (scope_type == CFA_SCOPE_TYPE_NON_SHARED) {
 		/* Allocate dynamic bucket */
 		bucket_aparms.num_contig_records = TFC_EM_DYNAMIC_BUCKET_RECORD_SIZE;
 		rc = cfa_mm_alloc(cmm, &bucket_aparms);
@@ -598,7 +598,7 @@ int tfc_em_delete(struct tfc *tfcp, struct tfc_em_delete_parms *parms)
 	uint32_t record_size;
 	struct cfa_mm_free_parms fparms;
 	uint8_t tsid;
-	bool is_shared;
+	enum cfa_scope_type scope_type;
 	struct tfc_ts_pool_info pi;
 	bool is_bs_owner;
 	struct tfc_ts_mem_cfg mem_cfg;
@@ -615,7 +615,7 @@ int tfc_em_delete(struct tfc *tfcp, struct tfc_em_delete_parms *parms)
 					&record_offset,
 					&static_bucket);
 
-	rc = tfo_ts_get(tfcp->tfo, tsid, &is_shared, NULL, &valid, NULL);
+	rc = tfo_ts_get(tfcp->tfo, tsid, &scope_type, NULL, &valid, NULL);
 	if (rc != 0) {
 		PMD_DRV_LOG_LINE(ERR, "failed to get tsid: %s",
 				 strerror(-rc));
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c b/drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c
index f0512c41cc..670c3a75fc 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c
@@ -43,7 +43,7 @@ int tfc_mpc_table_read(struct tfc *tfcp,
 	struct cfa_mpc_data_obj fields_cmp[CFA_BLD_MPC_READ_CMP_MAX_FLD];
 	struct bnxt_mpc_mbuf mpc_msg_in;
 	struct bnxt_mpc_mbuf mpc_msg_out;
-	bool is_shared;
+	enum cfa_scope_type scope_type;
 	struct cfa_bld_mpcinfo *mpc_info;
 	uint64_t host_address;
 	uint8_t discard_data[128];
@@ -53,7 +53,7 @@ int tfc_mpc_table_read(struct tfc *tfcp,
 
 	tfo_mpcinfo_get(tfcp->tfo, &mpc_info);
 
-	rc = tfo_ts_get(tfcp->tfo, tsid, &is_shared, NULL, &valid, NULL);
+	rc = tfo_ts_get(tfcp->tfo, tsid, &scope_type, NULL, &valid, NULL);
 	if (rc != 0) {
 		PMD_DRV_LOG_LINE(ERR, "failed to get tsid: %s", strerror(-rc));
 		return -EINVAL;
@@ -212,12 +212,12 @@ int tfc_mpc_table_write_zero(struct tfc *tfcp,
 	struct bnxt_mpc_mbuf mpc_msg_in;
 	struct bnxt_mpc_mbuf mpc_msg_out;
 	struct cfa_bld_mpcinfo *mpc_info;
-	bool is_shared;
+	enum cfa_scope_type scope_type;
 	bool valid;
 
 	tfo_mpcinfo_get(tfcp->tfo, &mpc_info);
 
-	rc = tfo_ts_get(tfcp->tfo, tsid, &is_shared, NULL, &valid, NULL);
+	rc = tfo_ts_get(tfcp->tfo, tsid, &scope_type, NULL, &valid, NULL);
 	if (rc != 0) {
 		PMD_DRV_LOG_LINE(ERR, "failed to get tsid: %s", strerror(-rc));
 		return -EINVAL;
@@ -340,12 +340,12 @@ int tfc_mpc_table_invalidate(struct tfc *tfcp,
 	struct bnxt_mpc_mbuf mpc_msg_in;
 	struct bnxt_mpc_mbuf mpc_msg_out;
 	struct cfa_bld_mpcinfo *mpc_info;
-	bool is_shared;
+	enum cfa_scope_type scope_type;
 	bool valid;
 
 	tfo_mpcinfo_get(tfcp->tfo, &mpc_info);
 
-	rc = tfo_ts_get(tfcp->tfo, tsid, &is_shared, NULL, &valid, NULL);
+	rc = tfo_ts_get(tfcp->tfo, tsid, &scope_type, NULL, &valid, NULL);
 	if (rc != 0) {
 		PMD_DRV_LOG_LINE(ERR, "failed to get tsid: %s", strerror(-rc));
 		return -EINVAL;
@@ -1288,7 +1288,7 @@ static void bucket_show(FILE *fd, struct bucket_info_t *bucket_info, uint32_t of
 int tfc_em_show(FILE *fd, struct tfc *tfcp, uint8_t tsid, enum cfa_dir dir)
 {
 	int rc = 0;
-	bool is_shared;
+	enum cfa_scope_type scope_type;
 	bool is_bs_owner;
 	struct tfc_ts_mem_cfg *lkup_mem_cfg;
 	struct tfc_ts_mem_cfg *act_mem_cfg;
@@ -1299,7 +1299,7 @@ int tfc_em_show(FILE *fd, struct tfc *tfcp, uint8_t tsid, enum cfa_dir dir)
 	uint32_t bucket_offset = 0;
 	bool valid;
 
-	rc = tfo_ts_get(tfcp->tfo, tsid, &is_shared, NULL, &valid, NULL);
+	rc = tfo_ts_get(tfcp->tfo, tsid, &scope_type, NULL, &valid, NULL);
 	if (rc != 0) {
 		fprintf(fd, "%s: failed to get tsid: %d\n",
 			   __func__, rc);
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_msg.c b/drivers/net/bnxt/tf_core/v3/tfc_msg.c
index 7ec7e9a054..cf72d09184 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_msg.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_msg.c
@@ -181,6 +181,8 @@ tfc_msg_free_dma_buf(struct tfc_msg_dma_buf *buf)
 int
 tfc_msg_tbl_scope_qcaps(struct tfc *tfcp,
 			bool *tbl_scope_capable,
+			bool *global_scope_capable,
+			bool *locked_scope_capable,
 			uint32_t *max_lkup_rec_cnt,
 			uint32_t *max_act_rec_cnt,
 			uint8_t	*max_lkup_static_buckets_exp)
@@ -200,8 +202,24 @@ tfc_msg_tbl_scope_qcaps(struct tfc *tfcp,
 		return -EINVAL;
 	}
 
+	if (global_scope_capable == NULL) {
+		PMD_DRV_LOG_LINE(ERR,
+				 "%s: Invalid global_scope_capable pointer",
+				 __func__);
+		return -EINVAL;
+	}
+
+	if (tbl_scope_capable == NULL) {
+		PMD_DRV_LOG_LINE(ERR,
+				 "%s: Invalid locked_scope_capable pointer",
+				 __func__);
+		return -EINVAL;
+	}
+
 	bp = tfcp->bp;
 	*tbl_scope_capable = false;
+	*global_scope_capable = false;
+	*locked_scope_capable = false;
 
 	rc = bnxt_hwrm_tf_message_direct(bp, false, HWRM_TFC_TBL_SCOPE_QCAPS,
 					 &req, sizeof(req), &resp,
@@ -211,6 +229,10 @@ tfc_msg_tbl_scope_qcaps(struct tfc *tfcp,
 
 	if (resp.tbl_scope_capable) {
 		*tbl_scope_capable = true;
+		if (resp.flags & HWRM_TFC_TBL_SCOPE_QCAPS_OUTPUT_FLAGS_GLOBAL)
+			*global_scope_capable = true;
+		if (resp.flags & HWRM_TFC_TBL_SCOPE_QCAPS_OUTPUT_FLAGS_LOCKED)
+			*locked_scope_capable = true;
 		if (max_lkup_rec_cnt)
 			*max_lkup_rec_cnt =
 				rte_le_to_cpu_32(resp.max_lkup_rec_cnt);
@@ -226,7 +248,7 @@ tfc_msg_tbl_scope_qcaps(struct tfc *tfcp,
 }
 int
 tfc_msg_tbl_scope_id_alloc(struct tfc *tfcp, uint16_t fid,
-			   bool shared, enum cfa_app_type app_type,
+			   enum cfa_scope_type scope_type, enum cfa_app_type app_type,
 			   uint8_t *tsid,
 			   bool *first)
 {
@@ -247,8 +269,21 @@ tfc_msg_tbl_scope_id_alloc(struct tfc *tfcp, uint16_t fid,
 
 	bp = tfcp->bp;
 	req.app_type = app_type;
-	req.shared = shared;
-
+	switch (scope_type) {
+	case CFA_SCOPE_TYPE_NON_SHARED:
+		req.scope_type = HWRM_TFC_TBL_SCOPE_ID_ALLOC_INPUT_SCOPE_TYPE_NON_SHARED;
+		break;
+	case CFA_SCOPE_TYPE_SHARED_APP:
+		req.scope_type = HWRM_TFC_TBL_SCOPE_ID_ALLOC_INPUT_SCOPE_TYPE_SHARED_APP;
+		break;
+	case CFA_SCOPE_TYPE_GLOBAL:
+		req.scope_type = HWRM_TFC_TBL_SCOPE_ID_ALLOC_INPUT_SCOPE_TYPE_GLOBAL;
+		break;
+	default:
+		PMD_DRV_LOG_LINE(ERR, "%s: Invalid scope_type",
+				 __func__);
+		return -EINVAL;
+	}
 	rc = tfc_msg_set_fid(bp, fid, &req.fid);
 	if (rc)
 		return rc;
@@ -393,28 +428,6 @@ tfc_msg_backing_store_cfg_v2(struct tfc *tfcp, uint8_t tsid, enum cfa_dir dir,
 	return rc;
 }
 
-int
-tfc_msg_tbl_scope_deconfig(struct tfc *tfcp, uint8_t tsid)
-{
-	struct hwrm_tfc_tbl_scope_deconfig_input req = { 0 };
-	struct hwrm_tfc_tbl_scope_deconfig_output resp = { 0 };
-	struct bnxt *bp;
-	int rc;
-
-	if (tfcp == NULL) {
-		PMD_DRV_LOG_LINE(ERR, "Invalid tfcp pointer");
-		return -EINVAL;
-	}
-
-	bp = tfcp->bp;
-	req.tsid = tsid;
-	rc = bnxt_hwrm_tf_message_direct(bp, false, HWRM_TFC_TBL_SCOPE_DECONFIG,
-					 &req, sizeof(req), &resp,
-					 sizeof(resp));
-
-	return rc;
-}
-
 int
 tfc_msg_tbl_scope_fid_add(struct tfc *tfcp, uint16_t fid,
 			  uint8_t tsid, uint16_t *fid_cnt)
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_msg.h b/drivers/net/bnxt/tf_core/v3/tfc_msg.h
index 3bf6b04a12..6f07890cd6 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_msg.h
+++ b/drivers/net/bnxt/tf_core/v3/tfc_msg.h
@@ -16,11 +16,14 @@
 int
 tfc_msg_tbl_scope_qcaps(struct tfc *tfcp,
 			bool *tbl_scope_capable,
+			bool *global_scope_capable,
+			bool *locked_scope_capable,
 			uint32_t *max_lkup_rec_cnt,
 			uint32_t *max_act_rec_cnt,
 			uint8_t	*max_lkup_static_buckets_exp);
 
-int tfc_msg_tbl_scope_id_alloc(struct tfc *tfcp, uint16_t fid, bool shared,
+int tfc_msg_tbl_scope_id_alloc(struct tfc *tfcp, uint16_t fid,
+			       enum cfa_scope_type scope_type,
 			       enum cfa_app_type app_type, uint8_t *tsid,
 			       bool *first);
 
@@ -31,9 +34,6 @@ tfc_msg_backing_store_cfg_v2(struct tfc *tfcp, uint8_t tsid, enum cfa_dir dir,
 			     uint32_t rec_cnt, uint8_t static_bkt_cnt_exp,
 			     bool cfg_done);
 
-int
-tfc_msg_tbl_scope_deconfig(struct tfc *tfcp, uint8_t tsid);
-
 int
 tfc_msg_tbl_scope_fid_add(struct tfc *tfcp, uint16_t fid,
 			  uint8_t tsid, uint16_t *fid_cnt);
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
index ac805916cc..b229f07596 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
@@ -56,9 +56,8 @@
  * @param[in] key_sz_in_bytes
  *   The lookup key size in bytes
  *
- * @param[in] shared
- *   True if the table scope will be shared.  Shared table scopes cannot have
- *   dynamic buckets.
+ * @param[in] scope_type
+ *   Shared-app or global table scopes cannot have dynamic buckets.
  *
  * @param[in] factor
  *   This indicates a multiplier factor for determining the static and dynamic
@@ -76,7 +75,7 @@
  *
  */
 static int calc_lkup_rec_cnt(uint32_t flow_cnt, uint16_t key_sz_in_bytes,
-			     __rte_unused bool shared,
+			     __rte_unused enum cfa_scope_type scope_type,
 			     enum tfc_tbl_scope_bucket_factor factor,
 			     uint32_t *lkup_rec_cnt,
 			     uint8_t *static_bucket_cnt_exp,
@@ -127,7 +126,7 @@ static int calc_lkup_rec_cnt(uint32_t flow_cnt, uint16_t key_sz_in_bytes,
 	key_rec_cnt = flow_cnt * entry_size;
 
 #ifdef DYNAMIC_BUCKETS_SUPPORTED
-	if (shared) {
+	if (scope_type != CFA_SCOPE_TYPE_NON_SHARED) {
 #endif
 		*static_bucket_cnt_exp =
 			next_pow2(flow_adj / ENTRIES_PER_BUCKET);
@@ -531,9 +530,9 @@ static int alloc_link_pbl(struct tfc_ts_mem_cfg *mem_cfg, uint32_t page_size,
  */
 struct tbl_scope_pools_create_parms {
 	/**
-	 * [in] Indicates if the table scope will be shared.
+	 * [in] Indicates non-shared, shared-app or global scope.
 	 */
-	bool shared;
+	enum cfa_scope_type scope_type;
 	/**
 	 * [in] The number of pools the table scope will be divided into. (set
 	 * to 1 if not shared).
@@ -599,7 +598,7 @@ static int tbl_scope_pools_create(struct tfc *tfcp, uint8_t tsid,
 		return -EINVAL;
 	}
 
-	rc = tfo_tim_get(tfcp->tfo, &tim);
+	rc = tfo_tim_get(tfcp->tfo, &tim, tsid);
 	if (rc)
 		return -EINVAL;
 
@@ -703,7 +702,7 @@ static int tbl_scope_pools_destroy(struct tfc *tfcp, uint8_t tsid)
 		return -EINVAL;
 	}
 
-	rc = tfo_tim_get(tfcp->tfo, &tim);
+	rc = tfo_tim_get(tfcp->tfo, &tim, tsid);
 	if (rc)
 		return -EINVAL;
 
@@ -755,7 +754,7 @@ static int tbl_scope_tpm_fid_rem(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 				 uint16_t *pool_cnt)
 {
 	int rc = 0;
-	bool shared;
+	enum cfa_scope_type scope_type;
 	bool valid;
 	enum cfa_dir dir;
 	uint16_t pool_id;
@@ -783,15 +782,16 @@ static int tbl_scope_tpm_fid_rem(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 		PMD_DRV_LOG_LINE(ERR, "only valid for PF");
 		return -EINVAL;
 	}
-	rc = tfo_ts_get(tfcp->tfo, tsid, &shared, NULL, &valid, NULL);
-	if (!valid || !shared) {
-		PMD_DRV_LOG_LINE(ERR, "tsid(%d) valid(%s) shared(%s)",
-				 tsid, valid ? "TRUE" : "FALSE",
-				 shared ? "TRUE" : "FALSE");
+	rc = tfo_ts_get(tfcp->tfo, tsid, &scope_type, NULL, &valid, NULL);
+	if (!valid || scope_type == CFA_SCOPE_TYPE_NON_SHARED) {
+		PMD_DRV_LOG_LINE(ERR,
+				 "%s: tsid(%d) valid(%s) scope_type(%s)",
+				 __func__, tsid, valid ? "TRUE" : "FALSE",
+				 tfc_scope_type_2_str(scope_type));
 		return -EINVAL;
 	}
 
-	rc = tfo_tim_get(tfcp->tfo, &tim);
+	rc = tfo_tim_get(tfcp->tfo, &tim, tsid);
 	if (rc) {
 		PMD_DRV_LOG_LINE(ERR, "Failed to get TIM");
 		return -EINVAL;
@@ -879,10 +879,7 @@ static int tbl_scope_tpm_fid_rem(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 
 /* Public APIs */
 
-int tfc_tbl_scope_qcaps(struct tfc *tfcp, bool *tbl_scope_capable,
-			uint32_t *max_lkup_rec_cnt,
-			uint32_t *max_act_rec_cnt,
-			uint8_t	*max_lkup_static_buckets_exp)
+int tfc_tbl_scope_qcaps(struct tfc *tfcp, struct tfc_tbl_scope_qcaps_parms *parms)
 {
 	int rc = 0;
 
@@ -890,14 +887,17 @@ int tfc_tbl_scope_qcaps(struct tfc *tfcp, bool *tbl_scope_capable,
 		PMD_DRV_LOG_LINE(ERR, "Invalid tfcp pointer");
 		return -EINVAL;
 	}
-	if (tbl_scope_capable == NULL) {
-		PMD_DRV_LOG_LINE(ERR, "Invalid tbl_scope_capable pointer");
+	if (parms == NULL) {
+		PMD_DRV_LOG_LINE(ERR, "%s: Invalid parms", __func__);
 		return -EINVAL;
 	}
 
-	rc = tfc_msg_tbl_scope_qcaps(tfcp, tbl_scope_capable, max_lkup_rec_cnt,
-				     max_act_rec_cnt,
-				     max_lkup_static_buckets_exp);
+	rc = tfc_msg_tbl_scope_qcaps(tfcp, &parms->tbl_scope_cap,
+				     &parms->global_cap,
+				     &parms->locked_cap,
+				     &parms->max_lkup_rec_cnt,
+				     &parms->max_act_rec_cnt,
+				     &parms->max_lkup_static_bucket_exp);
 	if (rc)
 		PMD_DRV_LOG_LINE(ERR,
 				 "table scope qcaps message failed, rc:%s",
@@ -927,15 +927,15 @@ int tfc_tbl_scope_size_query(struct tfc *tfcp,
 	}
 
 	if (is_pow2(parms->max_pools)) {
-		PMD_DRV_LOG(ERR, "%s: Invalid max_pools %u not pow2\n",
-			    __func__, parms->max_pools);
+		PMD_DRV_LOG_LINE(ERR, "%s: Invalid max_pools %u not pow2",
+				 __func__, parms->max_pools);
 		return -EINVAL;
 	}
 
 	for (dir = CFA_DIR_RX; dir < CFA_DIR_MAX; dir++) {
 		rc = calc_lkup_rec_cnt(parms->flow_cnt[dir],
 				       parms->key_sz_in_bytes[dir],
-				       parms->shared, parms->factor,
+				       parms->scope_type, parms->factor,
 				       &parms->lkup_rec_cnt[dir],
 				       &parms->static_bucket_cnt_exp[dir],
 				       &parms->dynamic_bucket_cnt[dir]);
@@ -970,7 +970,7 @@ int tfc_tbl_scope_size_query(struct tfc *tfcp,
 	return rc;
 }
 
-int tfc_tbl_scope_id_alloc(struct tfc *tfcp, bool shared,
+int tfc_tbl_scope_id_alloc(struct tfc *tfcp, enum cfa_scope_type scope_type,
 			   enum cfa_app_type app_type, uint8_t *tsid,
 			   bool *first)
 {
@@ -994,13 +994,13 @@ int tfc_tbl_scope_id_alloc(struct tfc *tfcp, bool shared,
 		return -EINVAL;
 	}
 	rc = tfc_msg_tbl_scope_id_alloc(tfcp, ((struct bnxt *)tfcp->bp)->fw_fid,
-					shared, app_type, tsid, first);
+					scope_type, app_type, tsid, first);
 	if (rc) {
 		PMD_DRV_LOG_LINE(ERR,
 				 "table scope ID alloc message failed, rc:%s",
 				 strerror(-rc));
 	} else {
-		rc = tfo_ts_set(tfcp->tfo, *tsid, shared, app_type, valid, 0);
+		rc = tfo_ts_set(tfcp->tfo, *tsid, scope_type, app_type, valid, 0);
 	}
 	return rc;
 }
@@ -1014,7 +1014,6 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 	uint64_t act_base_addr[2];
 	int dir;
 	int rc = 0;
-	bool shared = false;
 	uint32_t page_sz;
 	uint16_t pfid;
 	uint8_t lkup_pbl_level[2];
@@ -1044,8 +1043,8 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 	}
 
 	if (is_pow2(parms->max_pools)) {
-		PMD_DRV_LOG(ERR, "%s: Invalid max_pools %u not pow2\n",
-			    __func__, parms->max_pools);
+		PMD_DRV_LOG_LINE(ERR, "%s: Invalid max_pools %u not pow2",
+				 __func__, parms->max_pools);
 		return -EINVAL;
 	}
 
@@ -1083,12 +1082,6 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 			return rc;
 	}
 
-	/*
-	 * A shared table scope will have more than 1 pool
-	 */
-	if (parms->max_pools > 1)
-		shared = true;
-
 	/* If we are running on a PF, we will allocate memory locally
 	 */
 	if (is_pf) {
@@ -1176,9 +1169,9 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 				goto cleanup;
 			}
 
-			/* Set shared and valid in local state */
+			/* Set scope_type and valid in local state */
 			valid = true;
-			rc = tfo_ts_set(tfcp->tfo, tsid, shared, CFA_APP_TYPE_TF,
+			rc = tfo_ts_set(tfcp->tfo, tsid, parms->scope_type, CFA_APP_TYPE_TF,
 					valid, parms->max_pools);
 			if (rc)
 				goto cleanup;
@@ -1190,7 +1183,7 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 
 			cfg_cnt++;
 		}
-		cparms.shared = shared;
+		cparms.scope_type = parms->scope_type;
 		cparms.max_pools = parms->max_pools;
 
 		for (dir = 0; dir < CFA_DIR_MAX; dir++) {
@@ -1205,7 +1198,7 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 		/* If not shared, allocate the single pool_id in each region
 		 * so that we can save the associated fid for the table scope
 		 */
-		if (!shared) {
+		if (parms->scope_type == CFA_SCOPE_TYPE_NON_SHARED) {
 			uint16_t pool_id;
 			enum cfa_region_type region;
 			uint16_t max_vf;
@@ -1239,7 +1232,7 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 
 	} else /* this is a VF */ {
 		/* If first or !shared, send message to PF to allocate the memory */
-		if (parms->first || !shared) {
+		if (parms->first || parms->scope_type == CFA_SCOPE_TYPE_NON_SHARED) {
 			struct tfc_vf2pf_tbl_scope_mem_alloc_cfg_cmd req = { { 0 } };
 			struct tfc_vf2pf_tbl_scope_mem_alloc_cfg_resp resp = { { 0 } };
 			uint16_t fid;
@@ -1252,6 +1245,7 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 			req.hdr.fid = fid;
 			req.tsid = tsid;
 			req.max_pools = parms->max_pools;
+			req.scope_type = parms->scope_type;
 			for (dir = CFA_DIR_RX; dir < CFA_DIR_MAX; dir++) {
 				req.static_bucket_cnt_exp[dir] = parms->static_bucket_cnt_exp[dir];
 				req.dynamic_bucket_cnt[dir] = parms->dynamic_bucket_cnt[dir];
@@ -1298,9 +1292,9 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 			if (rc)
 				goto cleanup;
 
-			/* Set shared and valid in local state */
+			/* Set scope_type and valid in local state */
 			valid = true;
-			rc = tfo_ts_set(tfcp->tfo, tsid, shared, CFA_APP_TYPE_TF,
+			rc = tfo_ts_set(tfcp->tfo, tsid, parms->scope_type, CFA_APP_TYPE_TF,
 					valid, parms->max_pools);
 		}
 	}
@@ -1330,7 +1324,8 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 	return rc;
 }
 
-int tfc_tbl_scope_mem_free(struct tfc *tfcp, uint16_t fid, uint8_t tsid)
+int tfc_tbl_scope_mem_free(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
+			   uint16_t fid_cnt)
 {
 	struct tfc_ts_mem_cfg mem_cfg;
 	bool local;
@@ -1338,7 +1333,9 @@ int tfc_tbl_scope_mem_free(struct tfc *tfcp, uint16_t fid, uint8_t tsid)
 	int lrc = 0;
 	int rc = 0;
 	bool is_pf = false;
-	bool shared;
+	enum cfa_scope_type scope_type;
+	struct tfc_cpm *cpm_lkup;
+	struct tfc_cpm *cpm_act;
 
 	if (tfcp == NULL) {
 		PMD_DRV_LOG_LINE(ERR, "Invalid tfcp pointer");
@@ -1355,7 +1352,7 @@ int tfc_tbl_scope_mem_free(struct tfc *tfcp, uint16_t fid, uint8_t tsid)
 		return -EINVAL;
 	}
 
-	rc = tfo_ts_get(tfcp->tfo, tsid, &shared, NULL, NULL, NULL);
+	rc = tfo_ts_get(tfcp->tfo, tsid, &scope_type, NULL, NULL, NULL);
 	if (rc)
 		return rc;
 
@@ -1370,7 +1367,6 @@ int tfc_tbl_scope_mem_free(struct tfc *tfcp, uint16_t fid, uint8_t tsid)
 		return rc;
 
 	if (!is_pf) {
-		PMD_DRV_LOG_LINE(DEBUG, "Send VF2PF message and await response");
 		struct tfc_vf2pf_tbl_scope_mem_free_cmd req = { { 0 } };
 		struct tfc_vf2pf_tbl_scope_mem_free_resp resp = { { 0 } };
 		uint16_t fid;
@@ -1382,22 +1378,44 @@ int tfc_tbl_scope_mem_free(struct tfc *tfcp, uint16_t fid, uint8_t tsid)
 		req.hdr.type = TFC_VF2PF_TYPE_TBL_SCOPE_MEM_FREE_CMD;
 		req.hdr.fid = fid;
 		req.tsid = tsid;
-
 		rc = tfc_vf2pf_mem_free(tfcp, &req, &resp);
-		if (rc != 0) {
-			PMD_DRV_LOG_LINE(ERR, "tfc_vf2pf_mem_free failed");
-			/* continue cleanup regardless */
-		}
-		PMD_DRV_LOG_LINE(DEBUG, "%s: tsid: %d, status %d",
-				 __func__, resp.tsid, resp.status);
-		if (shared) {
+		if (rc != 0)
+			PMD_DRV_LOG_LINE(ERR, "%s: tfc_vf2pf_mem_free failed",
+					 __func__);
+		/* continue cleanup regardless */
+
+		if (scope_type == CFA_SCOPE_TYPE_SHARED_APP) {
+			/*
+			 * Check if any direction has a CPM instance and, if so, free
+			 * it.
+			 */
+			rc = tfo_ts_get_cpm_inst(tfcp->tfo, tsid, CFA_DIR_RX, &cpm_lkup,
+						 &cpm_act);
+			if (rc == 0 && (cpm_lkup != NULL || cpm_act != NULL))
+				(void)tfc_tbl_scope_cpm_free(tfcp, tsid);
+
 			/* reset scope */
-			tfo_ts_set(tfcp->tfo, tsid, false, CFA_APP_TYPE_INVALID, false, 0);
+			tfo_ts_set(tfcp->tfo, tsid, CFA_SCOPE_TYPE_INVALID,
+				   CFA_APP_TYPE_INVALID, false, 0);
+			return rc;
+		} else if (scope_type == CFA_SCOPE_TYPE_GLOBAL) {
+			if (fid_cnt == 0) {
+				/*
+				 * Check if any direction has a CPM instance and, if so, free
+				 * it.
+				 */
+				rc = tfo_ts_get_cpm_inst(tfcp->tfo, tsid, CFA_DIR_RX, &cpm_lkup,
+							 &cpm_act);
+				if (rc == 0 && (cpm_lkup != NULL || cpm_act != NULL))
+					(void)tfc_tbl_scope_cpm_free(tfcp, tsid);
+				/* reset scope */
+				tfo_ts_set(tfcp->tfo, tsid, CFA_SCOPE_TYPE_INVALID,
+					   CFA_APP_TYPE_INVALID, false, 0);
+			}
 			return rc;
 		}
 	}
-
-	if (shared && is_pf) {
+	if (scope_type != CFA_SCOPE_TYPE_NON_SHARED && is_pf) {
 		uint16_t pool_cnt;
 		uint16_t max_vf;
 
@@ -1423,13 +1441,6 @@ int tfc_tbl_scope_mem_free(struct tfc *tfcp, uint16_t fid, uint8_t tsid)
 		}
 	}
 
-	/* Send Deconfig HWRM before freeing memory */
-	rc = tfc_msg_tbl_scope_deconfig(tfcp, tsid);
-	if (rc) {
-		PMD_DRV_LOG_LINE(ERR, "deconfig failure: %s", strerror(-rc));
-		return rc;
-	}
-
 	for (region = 0; region < CFA_REGION_TYPE_MAX; region++) {
 		for (dir = 0; dir < CFA_DIR_MAX; dir++) {
 			lrc = tfo_ts_get_mem_cfg(tfcp->tfo, tsid, dir, region, &local,
@@ -1462,8 +1473,7 @@ int tfc_tbl_scope_mem_free(struct tfc *tfcp, uint16_t fid, uint8_t tsid)
 		}
 	}
 	/* cleanup state */
-	rc = tfo_ts_set(tfcp->tfo, tsid, false, CFA_APP_TYPE_INVALID, false, 0);
-
+	rc = tfo_ts_set(tfcp->tfo, tsid, CFA_SCOPE_TYPE_INVALID, CFA_APP_TYPE_INVALID, false, 0);
 	return rc;
 }
 
@@ -1499,8 +1509,6 @@ int tfc_tbl_scope_fid_add(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 int tfc_tbl_scope_fid_rem(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 			  uint16_t *fid_cnt)
 {
-	struct tfc_cpm *cpm_lkup;
-	struct tfc_cpm *cpm_act;
 	int rc = 0;
 
 	if (tfcp == NULL) {
@@ -1529,16 +1537,6 @@ int tfc_tbl_scope_fid_rem(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 				 "table scope fid rem message failed, rc:%s",
 				 strerror(-rc));
 
-	/*
-	 * Check if any direction has a CPM instance and, if so, free
-	 * it.
-	 */
-	rc = tfo_ts_get_cpm_inst(tfcp->tfo, tsid, CFA_DIR_RX, &cpm_lkup,
-				 &cpm_act);
-	if (rc == 0 && (cpm_lkup != NULL || cpm_act != NULL))
-		(void)tfc_tbl_scope_cpm_free(tfcp, tsid);
-
-	/* tbl_scope_mem_free() will reset the remaining tsid state */
 	return rc;
 }
 
@@ -1547,7 +1545,7 @@ int tfc_tbl_scope_cpm_alloc(struct tfc *tfcp, uint8_t tsid,
 {
 	int dir;
 	struct tfc_ts_pool_info pi;
-	bool is_shared;
+	enum cfa_scope_type scope_type;
 	int rc;
 	struct tfc_cmm *cmm_lkup = NULL;
 	struct tfc_cmm *cmm_act = NULL;
@@ -1560,8 +1558,9 @@ int tfc_tbl_scope_cpm_alloc(struct tfc *tfcp, uint8_t tsid,
 		PMD_DRV_LOG_LINE(ERR, "tsid(%d) invalid", tsid);
 		return -EINVAL;
 	}
-	if (tfo_ts_get(tfcp->tfo, tsid, &is_shared, NULL, NULL, NULL)) {
-		PMD_DRV_LOG_LINE(ERR, "tsid(%d) info get failed", tsid);
+	if (tfo_ts_get(tfcp->tfo, tsid, &scope_type, NULL, NULL, NULL)) {
+		PMD_DRV_LOG_LINE(ERR, "%s: tsid(%d) info get failed",
+				 __func__, tsid);
 		return -EINVAL;
 	}
 
@@ -1569,6 +1568,14 @@ int tfc_tbl_scope_cpm_alloc(struct tfc *tfcp, uint8_t tsid,
 	 */
 	for (dir = 0; dir < CFA_DIR_MAX; dir++) {
 		tfo_ts_get_pool_info(tfcp->tfo, tsid, dir, &pi);
+
+		/* If global scope, do not overwrite the CPM instance
+		 * already configured
+		 */
+		if (scope_type == CFA_SCOPE_TYPE_GLOBAL &&
+		    pi.act_cpm)
+			return 0;
+
 		pi.lkup_max_contig_rec = parms->lkup_max_contig_rec[dir];
 		pi.act_max_contig_rec = parms->act_max_contig_rec[dir];
 		tfc_cpm_open(&pi.lkup_cpm, parms->max_pools);
@@ -1578,12 +1585,13 @@ int tfc_tbl_scope_cpm_alloc(struct tfc *tfcp, uint8_t tsid,
 		tfo_ts_set_cpm_inst(tfcp->tfo, tsid, dir, pi.lkup_cpm, pi.act_cpm);
 		tfo_ts_set_pool_info(tfcp->tfo, tsid, dir, &pi);
 
+
 		/* If not shared create CMM instance for and populate CPM with pool_id 0.
 		 * If shared, a pool_id will be allocated during tfc_act_alloc() or
 		 * tfc_em_insert() and the CMM instance will be created on the first
 		 * call.
 		 */
-		if (!is_shared) {
+		if (scope_type == CFA_SCOPE_TYPE_NON_SHARED) {
 			struct cfa_mm_query_parms qparms;
 			struct cfa_mm_open_parms oparms;
 			uint32_t pool_id = 0;
@@ -1704,7 +1712,6 @@ int tfc_tbl_scope_cpm_free(struct tfc *tfcp, uint8_t tsid)
 		return -EINVAL;
 	}
 
-
 	for (dir = 0; dir < CFA_DIR_MAX; dir++) {
 		uint16_t pool_id;
 		struct tfc_cmm *cmm;
@@ -1801,7 +1808,7 @@ int tfc_tbl_scope_pool_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 	}
 
 	if (is_pf) {
-		rc = tfo_tim_get(tfcp->tfo, &tim);
+		rc = tfo_tim_get(tfcp->tfo, &tim, tsid);
 		if (rc) {
 			PMD_DRV_LOG_LINE(ERR, "Failed to get TIM");
 			return -EINVAL;
@@ -1895,7 +1902,7 @@ int tfc_tbl_scope_pool_free(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 	}
 
 	if (is_pf) {
-		rc = tfo_tim_get(tfcp->tfo, &tim);
+		rc = tfo_tim_get(tfcp->tfo, &tim, tsid);
 		if (rc)
 			return -EINVAL;
 
@@ -2000,7 +2007,7 @@ static void tfc_tbl_scope_delete_by_pool(uint16_t *found_cnt,
 int tfc_tbl_scope_func_reset(struct tfc *tfcp, uint16_t fid)
 {
 	int rc = 0;
-	bool shared;
+	enum cfa_scope_type scope_type;
 	enum cfa_app_type app;
 	bool valid;
 	uint8_t tsid;
@@ -2026,20 +2033,20 @@ int tfc_tbl_scope_func_reset(struct tfc *tfcp, uint16_t fid)
 		return -EINVAL;
 	}
 
-	rc = tfo_tim_get(tfcp->tfo, &tim);
-	if (rc) {
-		PMD_DRV_LOG_LINE(ERR, "Failed to get TIM");
-		return -EINVAL;
-	}
-
 	data = rte_zmalloc("data", 32 * TFC_MPC_BYTES_PER_WORD, 32);
 
 	for (tsid = 1; tsid < TFC_TBL_SCOPE_MAX; tsid++) {
-		rc = tfo_ts_get(tfcp->tfo, tsid, &shared, &app, &valid, NULL);
+		rc = tfo_ts_get(tfcp->tfo, tsid, &scope_type, &app, &valid, NULL);
 		if (rc)
 			continue; /* TS is not used, move on to the next */
 
-		if (!shared || !valid)
+		rc = tfo_tim_get(tfcp->tfo, &tim, tsid);
+		if (rc) {
+			PMD_DRV_LOG_LINE(INFO, "%s: Failed to get TIM", __func__);
+			continue;
+		}
+
+		if (scope_type == CFA_SCOPE_TYPE_NON_SHARED || !valid)
 			continue; /* TS invalid or not shared, move on */
 
 		for (dir = 0; dir < CFA_DIR_MAX; dir++) {
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c b/drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c
index cff93f931f..3b7ca7b8b1 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c
@@ -1804,7 +1804,7 @@ int tfc_wc_show(FILE *fd, struct tfc *tfcp, uint8_t tsid, enum cfa_dir dir)
 	struct wc_frp_context wc_frp;
 	bool is_bs_owner;
 	struct bnxt *bp;
-	bool is_shared;
+	enum cfa_scope_type scope_type;
 	bool valid;
 	int rc = 0;
 
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_util.c b/drivers/net/bnxt/tf_core/v3/tfc_util.c
index 91ad3ad657..ac6f9cc565 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_util.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_util.c
@@ -145,6 +145,21 @@ tfc_ts_region_2_str(enum cfa_region_type region, enum cfa_dir dir)
 	}
 }
 
+const char *
+tfc_scope_type_2_str(enum cfa_scope_type scope_type)
+{
+	switch (scope_type) {
+	case CFA_SCOPE_TYPE_NON_SHARED:
+		return "non_shared";
+	case CFA_SCOPE_TYPE_SHARED_APP:
+		return "shared_app";
+	case CFA_SCOPE_TYPE_GLOBAL:
+		return "global";
+	default:
+		return "Invalid scope type";
+	}
+}
+
 uint32_t
 tfc_getbits(uint32_t *data, int offset, int blen)
 {
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_util.h b/drivers/net/bnxt/tf_core/v3/tfc_util.h
index 5114517792..f71ade5c59 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_util.h
+++ b/drivers/net/bnxt/tf_core/v3/tfc_util.h
@@ -87,6 +87,17 @@ const char *tfc_ts_region_2_str(enum cfa_region_type region, enum cfa_dir dir);
  */
 const char *tfc_if_tbl_2_str(enum cfa_resource_subtype_if_tbl if_tbl_stype);
 
+/**
+ * Helper function converting the scope type to text string
+ *
+ * [in] scope_type: table scope type
+ *
+ * Returns:
+ *   Pointer to a char string holding the string for scope type
+ */
+const char *tfc_scope_type_2_str(enum cfa_scope_type scope_type);
+
+
 /**
  * Helper function retrieving field value from the buffer
  *
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.c b/drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.c
index cbe243e79c..7550ed4e84 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.c
@@ -179,6 +179,7 @@ tfc_vf2pf_mem_alloc_process(struct tfc *tfcp,
 	/* This is not for local use if we are getting a message from the VF */
 	ma_parms.local = false;
 	ma_parms.max_pools = req->max_pools;
+	ma_parms.scope_type = req->scope_type;
 	rc = tfc_tbl_scope_mem_alloc(tfcp, req->hdr.fid, req->tsid, &ma_parms);
 	if (rc == 0) {
 		PMD_DRV_LOG_LINE(ERR, "tsid(%d) PF allocation succeeds",
@@ -222,7 +223,7 @@ tfc_vf2pf_mem_free_process(struct tfc *tfcp,
 	PMD_DRV_LOG_LINE(ERR, "Table scope mem free cfg cmd:");
 	PMD_DRV_LOG_LINE(ERR, "\ttsid: 0x%x", req->tsid);
 
-	rc = tfc_tbl_scope_mem_free(tfcp, req->hdr.fid, req->tsid);
+	rc = tfc_tbl_scope_mem_free(tfcp, req->hdr.fid, req->tsid, 0);
 	if (rc == 0) {
 		PMD_DRV_LOG_LINE(ERR, "tsid(%d) PF free succeeds", req->tsid);
 	} else {
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.h b/drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.h
index efa35665f6..5bc592de9b 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.h
+++ b/drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.h
@@ -73,6 +73,8 @@ struct tfc_vf2pf_tbl_scope_mem_alloc_cfg_cmd {
 	uint8_t act_pool_sz_exp[CFA_DIR_MAX];
 	/** start offset in 32B records of the lkup recs (after buckets) */
 	uint32_t lkup_rec_start_offset[CFA_DIR_MAX];
+	/** scope type non-shared, shared-app or global */
+	enum cfa_scope_type scope_type;
 };
 /**
  * Truflow VF2PF Table Scope Memory allocate/config response
@@ -103,7 +105,7 @@ struct tfc_vf2pf_tbl_scope_mem_free_resp {
 	struct tfc_vf2pf_hdr hdr;
 	/** status of request */
 	enum tfc_vf2pf_status status;
-	/** tsid memory freed */
+	/** table scope identifier */
 	uint8_t tsid;
 };
 
diff --git a/drivers/net/bnxt/tf_core/v3/tfo.c b/drivers/net/bnxt/tf_core/v3/tfo.c
index 12d80877a6..0d304f7d56 100644
--- a/drivers/net/bnxt/tf_core/v3/tfo.c
+++ b/drivers/net/bnxt/tf_core/v3/tfo.c
@@ -14,8 +14,8 @@
  */
 struct tfc_tsid_db {
 	bool ts_valid; /**< Table scope is valid */
-	bool ts_is_shared; /**< Table scope is shared */
-	bool ts_is_bs_owner; /**< Backing store allocated by this instance (PF) */
+	enum cfa_scope_type scope_type; /**< non-shared, shared-app, global */
+	bool ts_is_bs_owner; /**< Backing store alloced by this instance (PF) */
 	uint16_t ts_max_pools; /**< maximum pools per CPM instance */
 	enum cfa_app_type ts_app; /**< application type TF/AFM */
 	/** backing store memory config */
@@ -24,6 +24,22 @@ struct tfc_tsid_db {
 	struct tfc_ts_pool_info ts_pool[CFA_DIR_MAX];
 };
 
+/* Only a single global scope is allowed
+ */
+#define TFC_GLOBAL_SCOPE_MAX 1
+
+/* TFC Global Object
+ * The global object is not per port, it is global.  It is only
+ * used when a global table scope is created.
+ */
+struct tfc_global_object {
+	uint8_t gtsid;
+	struct tfc_tsid_db gtsid_db;
+	void *gts_tim;
+};
+
+struct tfc_global_object tfc_global;
+
 /** TFC Object Signature
  * This signature identifies the tfc object database and
  * is used for pointer validation
@@ -48,12 +64,14 @@ struct tfc_object {
 	 *  table scope.  Only valid on a PF.
 	 */
 	void *ts_tim;
+	struct tfc_global_object *tfgo; /**< pointer to global */
 };
 
 void tfo_open(void **tfo, bool is_pf)
 {
 	int rc;
 	struct tfc_object *tfco = NULL;
+	struct tfc_global_object *tfgo;
 	uint32_t tim_db_size;
 
 	if (tfo == NULL) {
@@ -79,7 +97,7 @@ void tfo_open(void **tfo, bool is_pf)
 		return;
 	}
 	if (is_pf) {
-		/* Allocate TIM */
+		/* Allocate per bp TIM database */
 		rc = cfa_tim_query(TFC_TBL_SCOPE_MAX, CFA_REGION_TYPE_MAX,
 				   &tim_db_size);
 		if (rc)
@@ -99,7 +117,31 @@ void tfo_open(void **tfo, bool is_pf)
 			goto cleanup;
 		}
 	}
+	tfco->tfgo = &tfc_global;
+	tfgo = tfco->tfgo;
 
+	if (is_pf && !tfgo->gts_tim) {
+		/* Allocate global scope TIM database */
+		rc = cfa_tim_query(TFC_GLOBAL_SCOPE_MAX + 1, CFA_REGION_TYPE_MAX,
+				   &tim_db_size);
+		if (rc)
+			goto cleanup;
+
+		tfgo->gts_tim = rte_zmalloc("GTIM", tim_db_size, 0);
+		if (!tfgo->gts_tim)
+			goto cleanup;
+
+		rc = cfa_tim_open(tfgo->gts_tim,
+				  tim_db_size,
+				  TFC_GLOBAL_SCOPE_MAX + 1,
+				  CFA_REGION_TYPE_MAX);
+		if (rc) {
+			rte_free(tfgo->gts_tim);
+			tfgo->gts_tim = NULL;
+			goto cleanup;
+		}
+	}
+	tfgo->gtsid = INVALID_TSID;
 	*tfo = tfco;
 	return;
 
@@ -119,13 +161,11 @@ void tfo_close(void **tfo)
 
 	if (*tfo && tfco->signature == TFC_OBJ_SIGNATURE) {
 		/*  If TIM is setup free it and any TPMs */
-		if (tfo_tim_get(*tfo, &tim))
-			goto done;
-
-		if (!tim)
-			goto done;
-
 		for (tsid = 0; tsid < TFC_TBL_SCOPE_MAX; tsid++) {
+			if (tfo_tim_get(*tfo, &tim, tsid))
+				continue;
+			if (!tim)
+				continue;
 			for (region = 0; region < CFA_REGION_TYPE_MAX; region++) {
 				for (dir = 0; dir < CFA_DIR_MAX; dir++) {
 					tpm = NULL;
@@ -145,10 +185,13 @@ void tfo_close(void **tfo)
 				}
 			}
 		}
-		rte_free(tim);
+		if (tim)
+			rte_free(tim);
 		tfco->ts_tim = NULL;
-done:
-		rte_free(*tfo);
+		tfco->tfgo = NULL;
+
+		if (*tfo)
+			rte_free(*tfo);
 		*tfo = NULL;
 	}
 }
@@ -176,6 +219,7 @@ int tfo_mpcinfo_get(void *tfo, struct cfa_bld_mpcinfo **mpc_info)
 int tfo_ts_validate(void *tfo, uint8_t ts_tsid, bool *ts_valid)
 {
 	struct tfc_object *tfco = (struct tfc_object *)tfo;
+	struct tfc_global_object *tfgo;
 	struct tfc_tsid_db *tsid_db;
 
 	if (tfo == NULL) {
@@ -192,7 +236,11 @@ int tfo_ts_validate(void *tfo, uint8_t ts_tsid, bool *ts_valid)
 		PMD_DRV_LOG_LINE(ERR, "Invalid tsid %d", ts_tsid);
 		return -EINVAL;
 	}
-	tsid_db = &tfco->tsid_db[ts_tsid];
+	tfgo = tfco->tfgo;
+	if (tfgo && tfgo->gtsid == ts_tsid)
+		tsid_db = &tfgo->gtsid_db;
+	else
+		tsid_db = &tfco->tsid_db[ts_tsid];
 
 	if (ts_valid)
 		*ts_valid = tsid_db->ts_valid;
@@ -200,10 +248,11 @@ int tfo_ts_validate(void *tfo, uint8_t ts_tsid, bool *ts_valid)
 	return 0;
 }
 
-int tfo_ts_set(void *tfo, uint8_t ts_tsid, bool ts_is_shared,
+int tfo_ts_set(void *tfo, uint8_t ts_tsid, enum cfa_scope_type scope_type,
 	       enum cfa_app_type ts_app, bool ts_valid, uint16_t ts_max_pools)
 {
 	struct tfc_object *tfco = (struct tfc_object *)tfo;
+	struct tfc_global_object *tfgo;
 	struct tfc_tsid_db *tsid_db;
 
 	if (tfo == NULL) {
@@ -220,21 +269,32 @@ int tfo_ts_set(void *tfo, uint8_t ts_tsid, bool ts_is_shared,
 		return -EINVAL;
 	}
 
-	tsid_db = &tfco->tsid_db[ts_tsid];
+	tfgo = tfco->tfgo;
+	if (scope_type == CFA_SCOPE_TYPE_GLOBAL) {
+		tsid_db = &tfgo->gtsid_db;
+		tfgo->gtsid = ts_tsid;
+	} else if (scope_type == CFA_SCOPE_TYPE_INVALID && tfgo &&
+		   ts_tsid == tfgo->gtsid) {
+		tfgo->gtsid = INVALID_TSID;
+		tsid_db = &tfgo->gtsid_db;
+	} else {
+		tsid_db = &tfco->tsid_db[ts_tsid];
+	}
 
 	tsid_db->ts_valid = ts_valid;
-	tsid_db->ts_is_shared = ts_is_shared;
+	tsid_db->scope_type = scope_type;
 	tsid_db->ts_app = ts_app;
 	tsid_db->ts_max_pools = ts_max_pools;
 
 	return 0;
 }
 
-int tfo_ts_get(void *tfo, uint8_t ts_tsid, bool *ts_is_shared,
+int tfo_ts_get(void *tfo, uint8_t ts_tsid, enum cfa_scope_type *scope_type,
 	       enum cfa_app_type *ts_app, bool *ts_valid,
 	       uint16_t *ts_max_pools)
 {
 	struct tfc_object *tfco = (struct tfc_object *)tfo;
+	struct tfc_global_object *tfgo;
 	struct tfc_tsid_db *tsid_db;
 
 	if (tfo == NULL) {
@@ -250,13 +310,17 @@ int tfo_ts_get(void *tfo, uint8_t ts_tsid, bool *ts_is_shared,
 		return -EINVAL;
 	}
 
-	tsid_db = &tfco->tsid_db[ts_tsid];
+	tfgo = tfco->tfgo;
+	if (ts_tsid == tfgo->gtsid)
+		tsid_db = &tfgo->gtsid_db;
+	else
+		tsid_db = &tfco->tsid_db[ts_tsid];
 
 	if (ts_valid)
 		*ts_valid = tsid_db->ts_valid;
 
-	if (ts_is_shared)
-		*ts_is_shared = tsid_db->ts_is_shared;
+	if (scope_type)
+		*scope_type = tsid_db->scope_type;
 
 	if (ts_app)
 		*ts_app = tsid_db->ts_app;
@@ -274,6 +338,7 @@ int tfo_ts_set_mem_cfg(void *tfo, uint8_t ts_tsid, enum cfa_dir dir,
 		       struct tfc_ts_mem_cfg *mem_cfg)
 {
 	struct tfc_object *tfco = (struct tfc_object *)tfo;
+	struct tfc_global_object *tfgo;
 	int rc = 0;
 	struct tfc_tsid_db *tsid_db;
 
@@ -294,7 +359,11 @@ int tfo_ts_set_mem_cfg(void *tfo, uint8_t ts_tsid, enum cfa_dir dir,
 		return -EINVAL;
 	}
 
-	tsid_db = &tfco->tsid_db[ts_tsid];
+	tfgo = tfco->tfgo;
+	if (tfgo && tfgo->gtsid == ts_tsid)
+		tsid_db = &tfgo->gtsid_db;
+	else
+		tsid_db = &tfco->tsid_db[ts_tsid];
 
 	tsid_db->ts_mem[region][dir] = *mem_cfg;
 	tsid_db->ts_is_bs_owner = is_bs_owner;
@@ -309,6 +378,7 @@ int tfo_ts_get_mem_cfg(void *tfo, uint8_t ts_tsid, enum cfa_dir dir,
 		       struct tfc_ts_mem_cfg *mem_cfg)
 {
 	struct tfc_object *tfco = (struct tfc_object *)tfo;
+	struct tfc_global_object *tfgo;
 	int rc = 0;
 	struct tfc_tsid_db *tsid_db;
 
@@ -329,7 +399,11 @@ int tfo_ts_get_mem_cfg(void *tfo, uint8_t ts_tsid, enum cfa_dir dir,
 		return -EINVAL;
 	}
 
-	tsid_db = &tfco->tsid_db[ts_tsid];
+	tfgo = tfco->tfgo;
+	if (tfgo && tfgo->gtsid == ts_tsid)
+		tsid_db = &tfgo->gtsid_db;
+	else
+		tsid_db = &tfco->tsid_db[ts_tsid];
 
 	*mem_cfg = tsid_db->ts_mem[region][dir];
 	if (is_bs_owner)
@@ -345,6 +419,7 @@ int tfo_ts_get_cpm_inst(void *tfo, uint8_t ts_tsid, enum cfa_dir dir,
 {
 	int rc = 0;
 	struct tfc_object *tfco = (struct tfc_object *)tfo;
+	struct tfc_global_object *tfgo;
 	struct tfc_tsid_db *tsid_db;
 
 	if (tfo == NULL) {
@@ -368,7 +443,11 @@ int tfo_ts_get_cpm_inst(void *tfo, uint8_t ts_tsid, enum cfa_dir dir,
 		return -EINVAL;
 	}
 
-	tsid_db = &tfco->tsid_db[ts_tsid];
+	tfgo = tfco->tfgo;
+	if (tfgo && tfgo->gtsid == ts_tsid)
+		tsid_db = &tfgo->gtsid_db;
+	else
+		tsid_db = &tfco->tsid_db[ts_tsid];
 
 	*cpm_lkup = tsid_db->ts_pool[dir].lkup_cpm;
 	*cpm_act = tsid_db->ts_pool[dir].act_cpm;
@@ -382,6 +461,7 @@ int tfo_ts_set_cpm_inst(void *tfo, uint8_t ts_tsid, enum cfa_dir dir,
 {
 	int rc = 0;
 	struct tfc_object *tfco = (struct tfc_object *)tfo;
+	struct tfc_global_object *tfgo;
 	struct tfc_tsid_db *tsid_db;
 
 	if (tfo == NULL) {
@@ -396,7 +476,11 @@ int tfo_ts_set_cpm_inst(void *tfo, uint8_t ts_tsid, enum cfa_dir dir,
 		PMD_DRV_LOG_LINE(ERR, "Invalid tsid %d", ts_tsid);
 		return -EINVAL;
 	}
-	tsid_db = &tfco->tsid_db[ts_tsid];
+	tfgo = tfco->tfgo;
+	if (tfgo && tfgo->gtsid == ts_tsid)
+		tsid_db = &tfgo->gtsid_db;
+	else
+		tsid_db = &tfco->tsid_db[ts_tsid];
 
 	tsid_db->ts_pool[dir].lkup_cpm = cpm_lkup;
 	tsid_db->ts_pool[dir].act_cpm = cpm_act;
@@ -409,6 +493,7 @@ int tfo_ts_set_pool_info(void *tfo, uint8_t ts_tsid, enum cfa_dir dir,
 			 struct tfc_ts_pool_info *ts_pool)
 {
 	struct tfc_object *tfco = (struct tfc_object *)tfo;
+	struct tfc_global_object *tfgo;
 	int rc = 0;
 	struct tfc_tsid_db *tsid_db;
 
@@ -428,7 +513,12 @@ int tfo_ts_set_pool_info(void *tfo, uint8_t ts_tsid, enum cfa_dir dir,
 		PMD_DRV_LOG_LINE(ERR, "Invalid tsid %d", ts_tsid);
 		return -EINVAL;
 	}
-	tsid_db = &tfco->tsid_db[ts_tsid];
+
+	tfgo = tfco->tfgo;
+	if (tfgo && tfgo->gtsid == ts_tsid)
+		tsid_db = &tfgo->gtsid_db;
+	else
+		tsid_db = &tfco->tsid_db[ts_tsid];
 
 	tsid_db->ts_pool[dir] = *ts_pool;
 
@@ -441,6 +531,7 @@ int tfo_ts_get_pool_info(void *tfo, uint8_t ts_tsid, enum cfa_dir dir,
 			 struct tfc_ts_pool_info *ts_pool)
 {
 	struct tfc_object *tfco = (struct tfc_object *)tfo;
+	struct tfc_global_object *tfgo;
 	int rc = 0;
 	struct tfc_tsid_db *tsid_db;
 
@@ -460,7 +551,11 @@ int tfo_ts_get_pool_info(void *tfo, uint8_t ts_tsid, enum cfa_dir dir,
 		PMD_DRV_LOG_LINE(ERR, "Invalid tsid %d", ts_tsid);
 		return -EINVAL;
 	}
-	tsid_db = &tfco->tsid_db[ts_tsid];
+	tfgo = tfco->tfgo;
+	if (tfgo && tfgo->gtsid == ts_tsid)
+		tsid_db = &tfgo->gtsid_db;
+	else
+		tsid_db = &tfco->tsid_db[ts_tsid];
 
 	*ts_pool = tsid_db->ts_pool[dir];
 
@@ -519,9 +614,10 @@ int tfo_sid_get(void *tfo, uint16_t *sid)
 	return 0;
 }
 
-int tfo_tim_set(void *tfo, void *tim)
+int tfo_tim_get(void *tfo, void **tim, uint8_t ts_tsid)
 {
 	struct tfc_object *tfco = (struct tfc_object *)tfo;
+	struct tfc_global_object *tfgo;
 
 	if (tfo == NULL) {
 		PMD_DRV_LOG_LINE(ERR, "Invalid tfo pointer");
@@ -532,68 +628,60 @@ int tfo_tim_set(void *tfo, void *tim)
 		return -EINVAL;
 	}
 	if (tim == NULL) {
-		PMD_DRV_LOG_LINE(ERR, "Invalid tim pointer");
-		return -EINVAL;
-	}
-
-	if (tfco->ts_tim != NULL &&
-	    tfco->ts_tim != tim) {
-		PMD_DRV_LOG_LINE(ERR,
-				 "Cannot set TS TIM, TIM is already set");
+		PMD_DRV_LOG_LINE(ERR, "%s: Invalid tim pointer to pointer",
+				 __func__);
 		return -EINVAL;
 	}
 
-	tfco->ts_tim = tim;
+	*tim = NULL;
+	tfgo = tfco->tfgo;
 
-	return 0;
-}
-
-int tfo_tim_get(void *tfo, void **tim)
-{
-	struct tfc_object *tfco = (struct tfc_object *)tfo;
-
-	if (tfo == NULL) {
-		PMD_DRV_LOG_LINE(ERR, "Invalid tfo pointer");
-		return -EINVAL;
-	}
-	if (tfco->signature != TFC_OBJ_SIGNATURE) {
-		PMD_DRV_LOG_LINE(ERR, "Invalid tfo object");
-		return -EINVAL;
-	}
-	if (tim == NULL) {
-		PMD_DRV_LOG_LINE(ERR, "Invalid tim pointer to pointer");
-		return -EINVAL;
-	}
-	if (tfco->ts_tim == NULL) {
+	if (ts_tsid == tfgo->gtsid) {
+		if (!tfgo->gts_tim)
 		/* ts tim could be null, no need to log error message */
-		return -ENODEV;
+			return -ENODATA;
+		*tim = tfgo->gts_tim;
+	} else {
+		if (!tfco->ts_tim)
+			/* ts tim could be null, no need to log error message */
+			return -ENODATA;
+		*tim = tfco->ts_tim;
 	}
 
-	*tim = tfco->ts_tim;
-
 	return 0;
 }
 
-
 int tfo_tsid_get(void *tfo, uint8_t *tsid)
 {
 	struct tfc_object *tfco = (struct tfc_object *)tfo;
+	struct tfc_global_object *tfgo;
 	struct tfc_tsid_db *tsid_db;
 	uint8_t i;
 
 	if (tfo == NULL) {
-		PMD_DRV_LOG(ERR, "%s: Invalid tfo pointer", __func__);
+		PMD_DRV_LOG_LINE(ERR, "%s: Invalid tfo pointer",
+				 __func__);
 		return -EINVAL;
 	}
 	if (tfco->signature != TFC_OBJ_SIGNATURE) {
-		PMD_DRV_LOG(ERR, "%s: Invalid tfo object", __func__);
+		PMD_DRV_LOG_LINE(ERR, "%s: Invalid tfo object",
+				 __func__);
 		return -EINVAL;
 	}
 	if (tsid == NULL) {
-		PMD_DRV_LOG(ERR, "%s: Invalid tsid pointer", __func__);
+		PMD_DRV_LOG_LINE(ERR, "%s: Invalid tsid pointer",
+				 __func__);
 		return -EINVAL;
 	}
 
+	tfgo = tfco->tfgo;
+	if (tfgo) {
+		tsid_db = &tfgo->gtsid_db;
+		if (tsid_db->ts_valid && tfgo->gtsid != INVALID_TSID) {
+			*tsid = tfgo->gtsid;
+			return 0;
+		}
+	}
 	for (i = 1; i < TFC_TBL_SCOPE_MAX; i++) {
 		tsid_db = &tfco->tsid_db[i];
 
diff --git a/drivers/net/bnxt/tf_core/v3/tfo.h b/drivers/net/bnxt/tf_core/v3/tfo.h
index e572db5991..93a6a5c064 100644
--- a/drivers/net/bnxt/tf_core/v3/tfo.h
+++ b/drivers/net/bnxt/tf_core/v3/tfo.h
@@ -50,6 +50,10 @@
  * @ref tfo_sid_set
  *
  * @ref tfo_sid_get
+ *
+ * @ref tfo_tim_get
+ *
+ * @ref tfo_tsid_get
  */
 
 /** Invalid Table Scope ID */
@@ -161,8 +165,8 @@ int tfo_ts_validate(void *tfo, uint8_t ts_tsid, bool *ts_valid);
  * @param[in] ts_tsid
  *   The table scope ID
  *
- * @param[in] ts_is_shared
- *   True if the table scope is shared
+ * @param[in] scope_type
+ *   non-shared, shared-app or global
  *
  * @param[in] ts_app
  *   Application type TF/AFM
@@ -171,12 +175,12 @@ int tfo_ts_validate(void *tfo, uint8_t ts_tsid, bool *ts_valid);
  *   True if the table scope is valid
  *
  * @param[in] ts_max_pools
- *   Maximum number of pools if shared.
+ *   Maximum number of pools
  *
  * @return
  *   0 for SUCCESS, negative error value for FAILURE (errno.h)
  */
-int tfo_ts_set(void *tfo, uint8_t ts_tsid, bool ts_is_shared,
+int tfo_ts_set(void *tfo, uint8_t ts_tsid, enum cfa_scope_type scope_type,
 	       enum cfa_app_type ts_app, bool ts_valid,
 	       uint16_t ts_max_pools);
 
@@ -189,8 +193,8 @@ int tfo_ts_set(void *tfo, uint8_t ts_tsid, bool ts_is_shared,
  * @param[in] ts_tsid
  *   The table scope ID
  *
- * @param[out] ts_is_shared
- *   True if the table scope is shared
+ * @param[out] scope_type
+ *   True if the table scope is sharednon-shared, shared-app, global
  *
  * @param[out] ts_app
  *   Application type TF/AFM
@@ -199,12 +203,12 @@ int tfo_ts_set(void *tfo, uint8_t ts_tsid, bool ts_is_shared,
  *   True if the table scope is valid
  *
  * @param[out] ts_max_pools
- *   Maximum number of pools returned if shared.
+ *   Maximum number of pools.
  *
  * @return
  *   0 for SUCCESS, negative error value for FAILURE (errno.h)
  */
-int tfo_ts_get(void *tfo, uint8_t ts_tsid, bool *ts_is_shared,
+int tfo_ts_get(void *tfo, uint8_t ts_tsid, enum cfa_scope_type *scope_type,
 	       enum cfa_app_type *ts_app, bool *ts_valid,
 	       uint16_t *ts_max_pools);
 
@@ -399,32 +403,35 @@ int tfo_sid_set(void *tfo, uint16_t sid);
 int tfo_sid_get(void *tfo, uint16_t *sid);
 
 /**
- * Set the table scope instance manager.
+ * Get the table scope instance manager.
  *
  * @param[in] tfo
  *   Pointer to TFC object
  *
- * @param[in] tim
- *   Pointer to the table scope instance manager
+ * @param[out] tim
+ *   Pointer to a pointer to the table scope instance manager
+ *
+ * @param[in] ts_tsid
+ *   Table scope id
  *
  * @return
  *   0 for SUCCESS, negative error value for FAILURE (errno.h)
  */
-int tfo_tim_set(void *tfo, void *tim);
+int tfo_tim_get(void *tfo, void **tim, uint8_t ts_tsid);
 
 /**
- * Get the table scope instance manager.
+ * Get the table scope
  *
  * @param[in] tfo
  *   Pointer to TFC object
  *
- * @param[out] tim
- *   Pointer to a pointer to the table scope instance manager
+ * @param[out] tsid
+ *   Pointer to the returned table scope
  *
  * @return
  *   0 for SUCCESS, negative error value for FAILURE (errno.h)
  */
-int tfo_tim_get(void *tfo, void **tim);
+int tfo_tsid_get(void *tfo, uint8_t *tsid);
 
 /**
  * Get the table scope
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
index 084a3db92d..8443e3e7ba 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
@@ -20,6 +20,7 @@
 #include "bnxt_tf_common.h"
 #include "hsi_struct_def_dpdk.h"
 #include "tf_core.h"
+#include "tfc_util.h"
 #include "tf_ext_flow_handle.h"
 
 #include "ulp_template_db_enum.h"
@@ -313,14 +314,6 @@ ulp_tfc_tbl_scope_deinit(struct bnxt *bp)
 	if (rc)
 		return;
 
-	rc = tfc_tbl_scope_cpm_free(tfcp, tsid);
-	if (rc)
-		BNXT_DRV_DBG(ERR, "Failed Freeing CPM TSID:%d FID:%d\n",
-			     tsid, fid);
-	else
-		BNXT_DRV_DBG(DEBUG, "Freed CPM TSID:%d FID: %d\n", tsid, fid);
-
-
 	rc = tfc_tbl_scope_fid_rem(tfcp, fid, tsid, &fid_cnt);
 	if (rc)
 		BNXT_DRV_DBG(ERR, "Failed removing FID from TSID:%d FID:%d",
@@ -329,7 +322,14 @@ ulp_tfc_tbl_scope_deinit(struct bnxt *bp)
 		BNXT_DRV_DBG(DEBUG, "Removed FID from TSID:%d FID:%d",
 			     tsid, fid);
 
-	rc = tfc_tbl_scope_mem_free(tfcp, fid, tsid);
+	rc = tfc_tbl_scope_cpm_free(tfcp, tsid);
+	if (rc)
+		BNXT_DRV_DBG(ERR, "Failed Freeing CPM TSID:%d FID:%d",
+			     tsid, fid);
+	else
+		BNXT_DRV_DBG(DEBUG, "Freed CPM TSID:%d FID: %d", tsid, fid);
+
+	rc = tfc_tbl_scope_mem_free(tfcp, fid, tsid, fid_cnt);
 	if (rc)
 		BNXT_DRV_DBG(ERR, "Failed freeing tscope mem TSID:%d FID:%d",
 			     tsid, fid);
@@ -345,8 +345,10 @@ ulp_tfc_tbl_scope_init(struct bnxt *bp)
 	struct tfc_tbl_scope_size_query_parms qparms =  { 0 };
 	uint16_t max_lkup_sz[CFA_DIR_MAX], max_act_sz[CFA_DIR_MAX];
 	struct tfc_tbl_scope_cpm_alloc_parms cparms;
+	struct tfc_tbl_scope_qcaps_parms qcparms;
 	uint16_t fid, max_pools;
-	bool first = true, shared = false;
+	bool first = true;
+	enum cfa_scope_type scope_type = CFA_SCOPE_TYPE_NON_SHARED;
 	uint64_t feat_bits;
 	uint8_t tsid = 0;
 	struct tfc *tfcp;
@@ -368,18 +370,37 @@ ulp_tfc_tbl_scope_init(struct bnxt *bp)
 	max_act_sz[CFA_DIR_TX] =
 		bnxt_ulp_cntxt_act_rec_tx_max_sz_get(bp->ulp_ctx);
 
-	shared = bnxt_ulp_cntxt_shared_tbl_scope_enabled(bp->ulp_ctx);
+	if (bnxt_ulp_cntxt_shared_tbl_scope_enabled(bp->ulp_ctx))
+		scope_type = CFA_SCOPE_TYPE_SHARED_APP;
 
 	feat_bits = bnxt_ulp_feature_bits_get(bp->ulp_ctx);
 	if ((feat_bits & BNXT_ULP_FEATURE_BIT_MULTI_INSTANCE)) {
 		if (!BNXT_PF(bp)) {
-			shared = true;
+			scope_type = CFA_SCOPE_TYPE_SHARED_APP;
 			max_pools = 32;
 		}
 	}
 
+	rc = tfc_tbl_scope_qcaps(tfcp, &qcparms);
+	if (rc) {
+		PMD_DRV_LOG_LINE(ERR,
+				 "Failed obtaining table scope capabilities");
+		return rc;
+	}
+
+	if (feat_bits & BNXT_ULP_FEATURE_BIT_SOCKET_DIRECT) {
+		if (qcparms.global_cap) {
+			scope_type = CFA_SCOPE_TYPE_GLOBAL;
+			max_pools = 4;
+		} else {
+			PMD_DRV_LOG_LINE(ERR,
+					 "Socket direct requires global scope");
+			return -EINVAL;
+		}
+	}
+
 	/* Calculate the sizes for setting up memory */
-	qparms.shared = shared;
+	qparms.scope_type = scope_type;
 	qparms.max_pools = max_pools;
 	qparms.factor = bnxt_ulp_cntxt_em_mulitplier_get(bp->ulp_ctx);
 	qparms.flow_cnt[CFA_DIR_RX] =
@@ -394,15 +415,12 @@ ulp_tfc_tbl_scope_init(struct bnxt *bp)
 	if (rc)
 		return rc;
 
-
-
-	rc = tfc_tbl_scope_id_alloc(tfcp, shared, CFA_APP_TYPE_TF, &tsid,
+	rc = tfc_tbl_scope_id_alloc(tfcp, scope_type, CFA_APP_TYPE_TF, &tsid,
 				    &first);
 	if (rc) {
 		BNXT_DRV_DBG(ERR, "Failed to allocate tscope\n");
 		return rc;
 	}
-	BNXT_DRV_DBG(DEBUG, "Allocated tscope TSID:%d\n", tsid);
 
 	rc = bnxt_ulp_cntxt_tsid_set(bp->ulp_ctx, tsid);
 	if (rc)
@@ -410,7 +428,7 @@ ulp_tfc_tbl_scope_init(struct bnxt *bp)
 
 	/* If we are shared and not the first table scope creator
 	 */
-	if (shared && !first) {
+	if (scope_type != CFA_SCOPE_TYPE_NON_SHARED && !first) {
 		bool configured;
 		#define ULP_SHARED_TSID_WAIT_TIMEOUT 5000
 		#define ULP_SHARED_TSID_WAIT_TIME 50
@@ -426,12 +444,12 @@ ulp_tfc_tbl_scope_init(struct bnxt *bp)
 			}
 			timeout -= ULP_SHARED_TSID_WAIT_TIME;
 			BNXT_DRV_DBG(INFO,
-				     "Waiting %d ms for shared tsid(%d)\n",
-				     timeout, tsid);
+				     "Waiting %d ms for %s tsid(%d)",
+				     timeout, tfc_scope_type_2_str(scope_type), tsid);
 		} while (!configured && timeout > 0);
 		if (timeout <= 0) {
-			BNXT_DRV_DBG(ERR, "Timed out on shared tsid(%d)\n",
-				     tsid);
+			BNXT_DRV_DBG(ERR, "Timed out on %s tsid(%d)",
+				     tfc_scope_type_2_str(scope_type), tsid);
 			return -ETIMEDOUT;
 		}
 	}
@@ -457,8 +475,9 @@ ulp_tfc_tbl_scope_init(struct bnxt *bp)
 		qparms.act_pool_sz_exp[CFA_DIR_RX];
 	mem_parms.act_pool_sz_exp[CFA_DIR_TX] =
 		qparms.act_pool_sz_exp[CFA_DIR_TX];
+	mem_parms.scope_type = scope_type;
 
-	if (shared)
+	if (scope_type != CFA_SCOPE_TYPE_NON_SHARED)
 		mem_parms.local = false;
 	else
 		mem_parms.local = true;
@@ -540,7 +559,10 @@ ulp_tfc_cntxt_app_caps_init(struct bnxt *bp, uint8_t app_id, uint32_t dev_id)
 				ulp_ctx->cfg_data->ulp_flags |=
 					BNXT_ULP_APP_SOCKET_DIRECT;
 				BNXT_DRV_DBG(DEBUG,
-					    "Socket Direct feature is enabled\n");
+					    "Socket Direct feature is enabled");
+			} else {
+				BNXT_DRV_DBG(DEBUG,
+					     "No Socket Direct feature - must enable multiroot");
 			}
 		}
 		/* Update the capability feature bits*/
diff --git a/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h b/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
index 02534d8fe8..c30a43568b 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
@@ -911,7 +911,8 @@ enum bnxt_ulp_feature_bit {
 	BNXT_ULP_FEATURE_BIT_SOCKET_DIRECT = 0x00000008,
 	BNXT_ULP_FEATURE_BIT_MULTI_INSTANCE = 0x00000010,
 	BNXT_ULP_FEATURE_BIT_SPECIAL_VXLAN = 0x00000020,
-	BNXT_ULP_FEATURE_BIT_HOT_UPGRADE = 0x00000040
+	BNXT_ULP_FEATURE_BIT_HOT_UPGRADE = 0x00000040,
+	BNXT_ULP_FEATURE_BIT_GLOBAL_TBL_SCOPE = 0x00000080
 };
 
 enum bnxt_ulp_flow_dir_bitmask {
-- 
2.39.5 (Apple Git-154)

