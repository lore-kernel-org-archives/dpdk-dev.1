Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B42FCCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:04:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 971E340E18;
	Wed, 15 Oct 2025 11:04:05 +0200 (CEST)
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com
 [209.85.160.99]) by mails.dpdk.org (Postfix) with ESMTP id 1E07740E1D
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:04:04 +0200 (CEST)
Received: by mail-oa1-f99.google.com with SMTP id
 586e51a60fabf-3c8d0d7450eso2867873fac.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519043; x=1761123843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pegLHa6YwTnUrKk2yUoAJjCwPPOmU9VVfLvOuNaLXSY=;
 b=l6oymDL39bZz6SsbtWk0Han+6u8tWlt6EtZLTkbMsd78QVIX7PRpNIdlLg78o0YpzK
 cI+W8qdIDRHtay23k8gQzSBwULXnozbCi3mWp3f8jcxMIQmmV9BL/avgqqGTds1rTP2U
 qcO0ByWPpIvEyjAxnfLfrI+gN2SlZmBsAQjoaqAzYUJMlv2A12Ge+iP0sJBJ1rXQMxMj
 B7+hCDIXvIY5yInb37sp95dSKDXjTPzBITpMl57Nc0ZBsut1tmYjyOMvFexU64mmkoP8
 UarA8c8VfZWFfS1CckJuoEUoxeIPg3ZTfvWtAP4lVaSd44yUNGuj1hpqT51gRWFv9F+l
 c54Q==
X-Gm-Message-State: AOJu0YyNTwFOw3ilw3if02TToo331YfUl0Nl5MoDgmn2Qw3JT6xIFBme
 id9/zLHMYq3DS/exYUxDtz/eHGBNPJJv/EnQF6kDDshLoyYwNTO+WL4qtUWcxPpZJqseMa8TTmG
 94kg6Gscjb/YNqxK4l7lPQ1D8ZCID9AOxj2egfvUcvg8ivFeThhlilxclNkA8EVgn4C/lm+Zkeg
 4gEg2O+GmAqklRe/ceCzeXSIwG5h8Pqf2TdVV6aQ9OS6nDm+xfA/2PIUMB1BYtpTdJ5m6DJQ==
X-Gm-Gg: ASbGncuYy88OYiQ8rXDWM93oIffSRqqEDp36EUgInOap7j8HZvwGw4FBVjOWagLw1Cr
 NVpWc873YQRomqjvx8HS9fisM/d4p9kJyXnzKS1nq8A6tnVyChz/pSoW72BN8bIl/O8cpMDB+pj
 ewLMSYlZlu/JzHpdGycBKXD0omb21wrTl1rK9hpY9oGAOIVqh5bJhx3m5eXfkkcZpQlu1+13AIU
 dHEwqRojm7bYkp6TUvY3aVusT31/tIvBgOfOwSI2hW9J/FyyKOiQx23SVlVzhdDIkVDBB7l70GV
 uI3w8/QIi5oM6VFepCa4kokcSHFtg7Cn94GFVrIlbeZJHFmBZVTE6DfuuKtGkjq4Utv2weyUSb0
 c3biklt+PyspTuox9AnSBaXA8iovQXhdWXiNNtjT3JZX4k4HrQ992soVpZbUa3fud5MPQRV5/zV
 E=
X-Google-Smtp-Source: AGHT+IFlmhlm6lE+l3MnSUmVcEFILGrrumNXG5/j2oyIiygkWpjXmI4ZKSJpOVMVmoi2ulK8ftVuXZbYUA+k
X-Received: by 2002:a05:6870:d365:b0:366:8f87:b1c4 with SMTP id
 586e51a60fabf-3c0f68f3ebamr11614738fac.18.1760519043256; 
 Wed, 15 Oct 2025 02:04:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-3c8c8b7da77sm1441551fac.8.2025.10.15.02.04.01
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:04:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-782063922ceso8846498b3a.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519040; x=1761123840; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pegLHa6YwTnUrKk2yUoAJjCwPPOmU9VVfLvOuNaLXSY=;
 b=LLkxvvdkFtKNnA0PB78eMYp4k2qM03YXMA/FmJkapXHyEH5/aNBbdIFNQW4/6VlaE/
 5DebVYokuKi3jAu37Dc+3jKj3jBPvEKowtiML84h11+VsEXRiQMj1sq9Eh8dn4ue1Tfi
 SZOspOGb+g2pzL03SSZsFxKFbNO6TmxDwQOI4=
X-Received: by 2002:a05:6a00:182a:b0:781:275a:29d9 with SMTP id
 d2e1a72fcca58-7938742c7aemr36467225b3a.18.1760519039699; 
 Wed, 15 Oct 2025 02:03:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:182a:b0:781:275a:29d9 with SMTP id
 d2e1a72fcca58-7938742c7aemr36467170b3a.18.1760519038727; 
 Wed, 15 Oct 2025 02:03:58 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.03.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:03:58 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Michael Baucom <michael.baucom@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v3 16/54] net/bnxt/tf_ulp: hot upgrade support
Date: Wed, 15 Oct 2025 04:59:46 -0400
Message-Id: <20251015090024.32250-17-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251015090024.32250-1-manish.kurup@broadcom.com>
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <20251015090024.32250-1-manish.kurup@broadcom.com>
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

Add support for hot upgrade for a generic application.  An
application can start a backup application and add the same flows
that has been offloaded in primary application and secondary
application can take over primary application.

Update the hwrm version to the correct version number, the
corresponding code version for hot upgrade api got changed.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Michael Baucom <michael.baucom@broadcom.com>
Reviewed-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
---
 drivers/net/bnxt/bnxt.h                       |   1 +
 drivers/net/bnxt/bnxt_ethdev.c                |  37 +++
 .../bnxt/hcapi/cfa_v3/include/cfa_resources.h |   8 +
 drivers/net/bnxt/hsi_struct_def_dpdk.h        | 207 +++++++++++++-
 drivers/net/bnxt/tf_core/v3/meson.build       |   1 +
 drivers/net/bnxt/tf_core/v3/tfc.h             |  84 ++++++
 drivers/net/bnxt/tf_core/v3/tfc_hot_upgrade.c | 142 ++++++++++
 drivers/net/bnxt/tf_core/v3/tfc_msg.c         |  52 ++++
 drivers/net/bnxt/tf_core/v3/tfc_msg.h         |   7 +
 drivers/net/bnxt/tf_ulp/bnxt_ulp.h            |   3 +
 drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c       |  10 +
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c        |  42 ++-
 drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h      |  60 ++++
 drivers/net/bnxt/tf_ulp/meson.build           |  56 +++-
 drivers/net/bnxt/tf_ulp/ulp_mapper.c          |   4 +
 drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c      |   2 +-
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c          |   7 +-
 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c      | 264 ++++++++++++++++++
 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h      |  40 +++
 19 files changed, 1012 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_hot_upgrade.c
 create mode 100644 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c
 create mode 100644 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h

diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index 72ac66b0db..00bdb53215 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -1061,6 +1061,7 @@ struct bnxt {
 	struct bnxt_flow_stat_info *flow_stat;
 	uint16_t		max_num_kflows;
 	uint8_t			app_id;
+	uint8_t			app_instance_id;
 	uint32_t		tx_cfa_action;
 	struct bnxt_ring_stats	*prev_rx_ring_stats;
 	struct bnxt_ring_stats	*prev_tx_ring_stats;
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 0836be3b1e..7edfd8ca89 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -162,6 +162,9 @@ static const struct rte_eth_speed_lanes_capa speed_lanes_capa_tbl[] = {
  */
 #define BNXT_DEVARG_APP_ID_INVALID(val)			((val) > 255)
 
+/* app-instance-id = an non-negative 3-bit number */
+#define BNXT_DEVARG_APP_INSTANCE_ID_INVALID(val)	((val) > 8)
+
 /*
  * ieee-1588 = an non-negative 8-bit number
  */
@@ -6063,6 +6066,40 @@ bnxt_parse_devarg_cqe_mode(__rte_unused const char *key,
 	return 0;
 }
 
+static int
+bnxt_parse_devarg_app_instance_id(__rte_unused const char *key,
+				  const char *value, void *opaque_arg)
+{
+	struct bnxt *bp = opaque_arg;
+	unsigned long app_instance_id;
+	char *end = NULL;
+
+	if (!opaque_arg) {
+		PMD_DRV_LOG_LINE(ERR,
+				 "Invalid param passed to app-instance-id devarg");
+		return -EINVAL;
+	}
+
+	app_instance_id = strtoul(value, &end, 10);
+	if (end == NULL || *end != '\0' ||
+	    (app_instance_id == ULONG_MAX && errno == ERANGE)) {
+		PMD_DRV_LOG_LINE(ERR,
+				 "Invalid parameter passed to instance devargs");
+		return -EINVAL;
+	}
+
+	if (BNXT_DEVARG_APP_INSTANCE_ID_INVALID(app_instance_id)) {
+		PMD_DRV_LOG_LINE(ERR, "Invalid app-instance-id(%d) devargs",
+				 (uint16_t)app_instance_id);
+		return -EINVAL;
+	}
+
+	bp->app_instance_id = app_instance_id;
+	PMD_DRV_LOG_LINE(INFO, "app_instance_id=%u feature enabled",
+			 (uint16_t)app_instance_id);
+	return 0;
+}
+
 static int
 bnxt_parse_devarg_app_id(__rte_unused const char *key,
 				 const char *value, void *opaque_arg)
diff --git a/drivers/net/bnxt/hcapi/cfa_v3/include/cfa_resources.h b/drivers/net/bnxt/hcapi/cfa_v3/include/cfa_resources.h
index d1d62738d3..ada9741dfa 100644
--- a/drivers/net/bnxt/hcapi/cfa_v3/include/cfa_resources.h
+++ b/drivers/net/bnxt/hcapi/cfa_v3/include/cfa_resources.h
@@ -194,6 +194,14 @@ enum cfa_resource_subtype_gim {
 	 CFA_RSUBTYPE_SM_MAX + CFA_RSUBTYPE_TSM_MAX + CFA_RSUBTYPE_TIM_MAX +   \
 	 CFA_RSUBTYPE_GIM_MAX)
 
+#define CFA_HOT_UPGRADE_APP_INSTANCE_MAX 4
+enum cfa_hot_upgrade_cmd_op {
+	CFA_HOT_UPGRADE_CMD_ALLOC = 1,
+	CFA_HOT_UPGRADE_CMD_FREE,
+	CFA_HOT_UPGRADE_CMD_GET,
+	CFA_HOT_UPGRADE_CMD_SET
+};
+
 /**
  * @}
  */
diff --git a/drivers/net/bnxt/hsi_struct_def_dpdk.h b/drivers/net/bnxt/hsi_struct_def_dpdk.h
index de72e0e9e9..6e540359e3 100644
--- a/drivers/net/bnxt/hsi_struct_def_dpdk.h
+++ b/drivers/net/bnxt/hsi_struct_def_dpdk.h
@@ -966,6 +966,8 @@ struct __rte_packed_begin cmd_nums {
 	#define HWRM_TFC_GLOBAL_ID_FREE                   UINT32_C(0x39c)
 	/* TruFlow command to update the priority of one tcam entry. */
 	#define HWRM_TFC_TCAM_PRI_UPDATE                  UINT32_C(0x39d)
+	/* TruFlow command to process hot upgrade requests. */
+	#define HWRM_TFC_HOT_UPGRADE_PROCESS              UINT32_C(0x3a0)
 	/* Experimental */
 	#define HWRM_SV                                   UINT32_C(0x400)
 	/* Flush any trace buffer data that has not been sent to the host. */
@@ -1250,8 +1252,8 @@ struct __rte_packed_begin hwrm_err_output {
 #define HWRM_VERSION_MINOR 10
 #define HWRM_VERSION_UPDATE 3
 /* non-zero means beta version */
-#define HWRM_VERSION_RSVD 86
-#define HWRM_VERSION_STR "1.10.3.86"
+#define HWRM_VERSION_RSVD 87
+#define HWRM_VERSION_STR "1.10.3.87"
 
 /****************
  * hwrm_ver_get *
@@ -41082,6 +41084,59 @@ struct __rte_packed_begin hwrm_queue_adptv_qos_rx_feature_cfg_output {
 	uint8_t	valid;
 } __rte_packed_end;
 
+/* hwrm_queue_adptv_qos_rx_feature_cfg_cmd_err (size:64b/8B) */
+struct __rte_packed_begin hwrm_queue_adptv_qos_rx_feature_cfg_cmd_err {
+	/*
+	 * command specific error codes that goes to
+	 * the cmd_err field in Common HWRM Error Response.
+	 */
+	uint8_t	code;
+	/* Success */
+	#define HWRM_QUEUE_ADPTV_QOS_RX_FEATURE_CFG_CMD_ERR_CODE_SUCCESS \
+		UINT32_C(0x0)
+	/* Unknown error */
+	#define HWRM_QUEUE_ADPTV_QOS_RX_FEATURE_CFG_CMD_ERR_CODE_UNKNOWN \
+		UINT32_C(0x1)
+	/* Cannot configure TCs with interfaces up */
+	#define HWRM_QUEUE_ADPTV_QOS_RX_FEATURE_CFG_CMD_ERR_CODE_INTERFACES_UP \
+		UINT32_C(0x2)
+	/*
+	 * Configured TCs are less than the minimum required.
+	 * The minimum is 3 if RoCE is enabled, else 1.
+	 */
+	#define HWRM_QUEUE_ADPTV_QOS_RX_FEATURE_CFG_CMD_ERR_CODE_MIN_TCS \
+		UINT32_C(0x3)
+	/* Configured TCs are more than the maximum allowed */
+	#define HWRM_QUEUE_ADPTV_QOS_RX_FEATURE_CFG_CMD_ERR_CODE_MAX_TCS \
+		UINT32_C(0x4)
+	/* Configured TCs are not contiguous */
+	#define HWRM_QUEUE_ADPTV_QOS_RX_FEATURE_CFG_CMD_ERR_CODE_CONTIGUOUS_TCS \
+		UINT32_C(0x5)
+	/* Cannot configure TC that has a priority mapping */
+	#define HWRM_QUEUE_ADPTV_QOS_RX_FEATURE_CFG_CMD_ERR_CODE_COS_PRI_MAPPED \
+		UINT32_C(0x6)
+	/* Cannot configure TC that has a priority with pfc enabled */
+	#define HWRM_QUEUE_ADPTV_QOS_RX_FEATURE_CFG_CMD_ERR_CODE_COS_PRI_PFC_ENABLED \
+		UINT32_C(0x7)
+	/*
+	 * Cannot configure TCs 0-2 differently than TC 0 and 2 as
+	 * lossy and TC 1 as lossless.
+	 * A maximum of 4 TCs can be configured as lossless.
+	 * TCs 1, 3, 4, 5, 6, and 7 can be configured as lossless.
+	 */
+	#define HWRM_QUEUE_ADPTV_QOS_RX_FEATURE_CFG_CMD_ERR_CODE_DEFAULT_TCS_CANNOT_BE_CHANGED \
+		UINT32_C(0x8)
+	/*
+	 * Cannot configure more than 4 lossless TCs.
+	 * TCs 1, 3, 4, 5, 6, and 7 can be configured as lossless.
+	 */
+	#define HWRM_QUEUE_ADPTV_QOS_RX_FEATURE_CFG_CMD_ERR_CODE_MAX_LOSSLESS_TCS \
+		UINT32_C(0x9)
+	#define HWRM_QUEUE_ADPTV_QOS_RX_FEATURE_CFG_CMD_ERR_CODE_LAST \
+		HWRM_QUEUE_ADPTV_QOS_RX_FEATURE_CFG_CMD_ERR_CODE_MAX_LOSSLESS_TCS
+	uint8_t	unused_0[7];
+} __rte_packed_end;
+
 /****************************************
  * hwrm_queue_adptv_qos_tx_feature_qcfg *
  ****************************************/
@@ -41397,6 +41452,59 @@ struct __rte_packed_begin hwrm_queue_adptv_qos_tx_feature_cfg_output {
 	uint8_t	valid;
 } __rte_packed_end;
 
+/* hwrm_queue_adptv_qos_tx_feature_cfg_cmd_err (size:64b/8B) */
+struct __rte_packed_begin hwrm_queue_adptv_qos_tx_feature_cfg_cmd_err {
+	/*
+	 * command specific error codes that goes to
+	 * the cmd_err field in Common HWRM Error Response.
+	 */
+	uint8_t	code;
+	/* Success */
+	#define HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_CFG_CMD_ERR_CODE_SUCCESS \
+		UINT32_C(0x0)
+	/* Unknown error */
+	#define HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_CFG_CMD_ERR_CODE_UNKNOWN \
+		UINT32_C(0x1)
+	/* Cannot configure TCs with interfaces up */
+	#define HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_CFG_CMD_ERR_CODE_INTERFACES_UP \
+		UINT32_C(0x2)
+	/*
+	 * Configured TCs are less than the minimum required.
+	 * The minimum is 3 if RoCE is enabled, else 1.
+	 */
+	#define HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_CFG_CMD_ERR_CODE_MIN_TCS \
+		UINT32_C(0x3)
+	/* Configured TCs are more than the maximum allowed */
+	#define HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_CFG_CMD_ERR_CODE_MAX_TCS \
+		UINT32_C(0x4)
+	/* Configured TCs are not contiguous */
+	#define HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_CFG_CMD_ERR_CODE_CONTIGUOUS_TCS \
+		UINT32_C(0x5)
+	/* Cannot configure TC that has a priority mapping */
+	#define HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_CFG_CMD_ERR_CODE_COS_PRI_MAPPED \
+		UINT32_C(0x6)
+	/* Cannot configure TC that has a priority with pfc enabled */
+	#define HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_CFG_CMD_ERR_CODE_COS_PRI_PFC_ENABLED \
+		UINT32_C(0x7)
+	/*
+	 * Cannot configure TCs 0-2 differently than TC 0 and 2 as
+	 * lossy and TC 1 as lossless.
+	 * A maximum of 4 TCs can be configured as lossless.
+	 * TCs 1, 3, 4, 5, 6, and 7 can be configured as lossless.
+	 */
+	#define HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_CFG_CMD_ERR_CODE_DEFAULT_TCS_CANNOT_BE_CHANGED \
+		UINT32_C(0x8)
+	/*
+	 * Cannot configure more than 4 lossless TCs.
+	 * TCs 1, 3, 4, 5, 6, and 7 can be configured as lossless.
+	 */
+	#define HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_CFG_CMD_ERR_CODE_MAX_LOSSLESS_TCS \
+		UINT32_C(0x9)
+	#define HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_CFG_CMD_ERR_CODE_LAST \
+		HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_CFG_CMD_ERR_CODE_MAX_LOSSLESS_TCS
+	uint8_t	unused_0[7];
+} __rte_packed_end;
+
 /********************
  * hwrm_queue_qcaps *
  ********************/
@@ -62556,6 +62664,101 @@ struct hwrm_tfc_tcam_pri_update_output {
 	uint8_t	valid;
 } __rte_packed;
 
+/********************************
+ * hwrm_tfc_hot_upgrade_process *
+ ********************************/
+
+
+/* hwrm_tfc_hot_upgrade_process_input (size:192b/24B) */
+struct hwrm_tfc_hot_upgrade_process_input {
+	/* The HWRM command request type. */
+	uint16_t	req_type;
+	/*
+	 * The completion ring to send the completion event on. This should
+	 * be the NQ ID returned from the `nq_alloc` HWRM command.
+	 */
+	uint16_t	cmpl_ring;
+	/*
+	 * The sequence ID is used by the driver for tracking multiple
+	 * commands. This ID is treated as opaque data by the firmware and
+	 * the value is returned in the `hwrm_resp_hdr` upon completion.
+	 */
+	uint16_t	seq_id;
+	/*
+	 * The target ID of the command:
+	 * * 0x0-0xFFF8 - The function ID
+	 * * 0xFFF8-0xFFFC, 0xFFFE - Reserved for internal processors
+	 * * 0xFFFD - Reserved for user-space HWRM interface
+	 * * 0xFFFF - HWRM
+	 */
+	uint16_t	target_id;
+	/*
+	 * A physical address pointer pointing to a host buffer that the
+	 * command's response data will be written. This can be either a host
+	 * physical address (HPA) or a guest physical address (GPA) and must
+	 * point to a physically contiguous block of memory.
+	 */
+	uint64_t	resp_addr;
+	/*
+	 * Function ID.
+	 * If running on a trusted VF or PF, the fid field can be used to
+	 * specify that the function is a non-trusted VF of the parent PF.
+	 * If this command is used for the target_id itself, this field is
+	 * set to 0xffff. A non-trusted VF cannot specify a valid FID in this
+	 * field.
+	 */
+	uint16_t	fid;
+	/*
+	 * Session id associated with the firmware. Will be used
+	 * for validation if the track type matches.
+	 */
+	uint16_t	sid;
+	/*
+	 * The ID of an hot upgrade application. Will be used to track
+	 * sessions associated with this app.
+	 */
+	uint8_t	app_id;
+	/* The hot-Up command. */
+	uint8_t	cmd;
+	/* Alloc a hot-up app entry and register a session for it */
+	#define HWRM_TFC_HOT_UPGRADE_PROCESS_INPUT_CMD_ALLOC     UINT32_C(0x1)
+	/* Free a hot-up session from hot-up app */
+	#define HWRM_TFC_HOT_UPGRADE_PROCESS_INPUT_CMD_FREE      UINT32_C(0x2)
+	/* Get the count of registered sessions for the hot-up app */
+	#define HWRM_TFC_HOT_UPGRADE_PROCESS_INPUT_CMD_GET       UINT32_C(0x4)
+	/* Set the active session for the hot-up app */
+	#define HWRM_TFC_HOT_UPGRADE_PROCESS_INPUT_CMD_SET       UINT32_C(0x8)
+	/* The count of sessions registered for the hot-up app */
+	uint8_t	cur_session_cnt;
+	/* unused. */
+	uint8_t	unused0;
+} __rte_packed;
+
+/* hwrm_tfc_hot_upgrade_process_output (size:128b/16B) */
+struct hwrm_tfc_hot_upgrade_process_output {
+	/* The specific error status for the command. */
+	uint16_t	error_code;
+	/* The HWRM command request type. */
+	uint16_t	req_type;
+	/* The sequence ID from the original command. */
+	uint16_t	seq_id;
+	/* The length of the response data in number of bytes. */
+	uint16_t	resp_len;
+	/* The count of sessions registered for the hot-up application. */
+	uint8_t	session_cnt;
+	/* unused. */
+	uint8_t	unused0[6];
+	/*
+	 * This field is used in Output records to indicate that the
+	 * output is completely written to RAM. This field should be
+	 * read as '1' to indicate that the output has been
+	 * completely written. When writing a command completion or
+	 * response to an internal processor, the order of writes has
+	 * to be such that this field is written last.
+	 */
+	uint8_t	valid;
+} __rte_packed;
+
 /******************************
  * hwrm_tunnel_dst_port_query *
  ******************************/
diff --git a/drivers/net/bnxt/tf_core/v3/meson.build b/drivers/net/bnxt/tf_core/v3/meson.build
index 5f467d6e5e..159e7a2b17 100644
--- a/drivers/net/bnxt/tf_core/v3/meson.build
+++ b/drivers/net/bnxt/tf_core/v3/meson.build
@@ -31,4 +31,5 @@ sources += files(
         'tfc_util.c',
         'tfo.c',
         'tfc_vf2pf_msg.c',
+        'tfc_hot_upgrade.c',
 )
diff --git a/drivers/net/bnxt/tf_core/v3/tfc.h b/drivers/net/bnxt/tf_core/v3/tfc.h
index 02f24106e7..54c615edc3 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc.h
+++ b/drivers/net/bnxt/tf_core/v3/tfc.h
@@ -1575,4 +1575,88 @@ int tfc_if_tbl_set(struct tfc *tfcp, uint16_t fid,
 int tfc_if_tbl_get(struct tfc *tfcp, uint16_t fid,
 		   const struct tfc_if_tbl_info *tbl_info,
 		   uint8_t *data, uint8_t *data_sz_in_bytes);
+
+/**
+ * Get a TFC hot upgrade status and application instance count
+ *
+ * @param[in] tfcp
+ *   Pointer to TFC handle
+ *
+ * @param[in] fid
+ *   FID - Function ID to be used
+ *
+ * @param[in] app_inst_id
+ *   the applicatoin instance id.
+ *
+ * @param[out] app_inst_cnt
+ *   Pointer to the application instance count.
+ *
+ * @returns
+ *   0 for SUCCESS, negative error value for FAILURE (errno.h)
+ */
+int
+tfc_hot_up_app_inst_count(struct tfc *tfcp, uint16_t fid,
+			  uint8_t app_inst_id, uint8_t *app_inst_cnt);
+
+/**
+ * Allocate and initialize the TFC hot upgrade state
+ *
+ * @param[in] tfcp
+ *   Pointer to TFC handle
+ *
+ * @param[in] fid
+ *   FID - Function ID to be used
+ *
+ * @param[in] app_inst_id
+ *   the application instance id.
+ *
+ * @param[in] app_inst_cnt
+ *   the application instance count.
+ *
+ * @param[out] session
+ *   the session count.
+ *
+ * @returns
+ *   0 for SUCCESS, negative error value for FAILURE (errno.h)
+ */
+int
+tfc_hot_up_app_inst_alloc(struct tfc *tfcp, uint16_t fid,
+			  uint8_t app_inst_id, uint8_t app_inst_cnt,
+			  uint8_t *session);
+/**
+ * Free the TFC hot upgrade state
+ *
+ * @param[in] tfcp
+ *   Pointer to TFC handle
+ *
+ * @param[in] fid
+ *   FID - Function ID to be used
+ *
+ * @param[in] app_inst_id
+ *   the application instance id.
+ *
+ * @returns
+ *   0 for SUCCESS, negative error value for FAILURE (errno.h)
+ */
+int
+tfc_hot_up_app_inst_free(struct tfc *tfcp, uint16_t fid, uint8_t app_inst_id);
+
+/**
+ * Set the TFC hot upgrade state to primary
+ *
+ * @param[in] tfcp
+ *   Pointer to TFC handle
+ *
+ * @param[in] fid
+ *   FID - Function ID to be used
+ *
+ * @param[in] app_inst_id
+ *   the application instance id.
+ *
+ * @returns
+ *   0 for SUCCESS, negative error value for FAILURE (errno.h)
+ */
+int
+tfc_hot_up_app_inst_set(struct tfc *tfcp, uint16_t fid, uint8_t app_inst_id);
+
 #endif /* _TFC_H_ */
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_hot_upgrade.c b/drivers/net/bnxt/tf_core/v3/tfc_hot_upgrade.c
new file mode 100644
index 0000000000..a82c4ccd17
--- /dev/null
+++ b/drivers/net/bnxt/tf_core/v3/tfc_hot_upgrade.c
@@ -0,0 +1,142 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2019-2021 Broadcom
+ * All rights reserved.
+ */
+#include <stdio.h>
+#include "tfc.h"
+#include "bnxt.h"
+#include "tfc_msg.h"
+#include "tfc_util.h"
+
+static int
+tfc_hot_upgrade_validate(struct tfc *tfcp, uint8_t app_inst_id,
+			 uint16_t *sid)
+{
+	struct bnxt *bp;
+	int rc = -EINVAL;
+
+	if (tfcp == NULL) {
+		PMD_DRV_LOG_LINE(ERR, "Invalid tfcp pointer");
+		return rc;
+	}
+
+	if (tfcp->bp == NULL || tfcp->tfo == NULL) {
+		PMD_DRV_LOG_LINE(ERR, "tfcp not initialized");
+		return rc;
+	}
+	bp = tfcp->bp;
+
+	if (!BNXT_PF(bp) && !BNXT_VF_IS_TRUSTED(bp)) {
+		PMD_DRV_LOG_LINE(ERR, "bp not PF or trusted VF");
+		return rc;
+	}
+
+	if (app_inst_id > CFA_HOT_UPGRADE_APP_INSTANCE_MAX) {
+		PMD_DRV_LOG_LINE(ERR, "Invalid app instance: %u",
+				 app_inst_id);
+		return rc;
+	}
+
+	*sid = 0;
+	rc = tfo_sid_get(tfcp->tfo, sid);
+	if (rc)
+		PMD_DRV_LOG_LINE(ERR,
+				 "Failed to retrieve SID, rc:%d",
+				 rc);
+
+	return rc;
+}
+
+int
+tfc_hot_up_app_inst_count(struct tfc *tfcp, uint16_t fid,
+			  uint8_t app_inst_id, uint8_t *app_inst_cnt)
+{
+	uint16_t sid;
+	int rc = 0;
+
+	if (tfc_hot_upgrade_validate(tfcp, app_inst_id, &sid)) {
+		PMD_DRV_LOG_LINE(ERR, "failed validate for instance %u",
+				 app_inst_id);
+		return -EINVAL;
+	}
+
+	rc = tfc_msg_hot_upgrade_process(tfcp, fid, sid, app_inst_id,
+					 CFA_HOT_UPGRADE_CMD_GET, 0,
+					 app_inst_cnt);
+	if (rc)
+		PMD_DRV_LOG_LINE(ERR, "failed for app instance id %d err=%d",
+				 app_inst_id, rc);
+
+	return rc;
+}
+
+int
+tfc_hot_up_app_inst_alloc(struct tfc *tfcp, uint16_t fid,
+			  uint8_t app_inst_id, uint8_t app_inst_cnt,
+			  uint8_t *session)
+{
+	uint16_t sid;
+	int rc = 0;
+
+	if (tfc_hot_upgrade_validate(tfcp,  app_inst_id, &sid)) {
+		PMD_DRV_LOG_LINE(ERR, "failed validate for instance %u",
+				 app_inst_id);
+		return -EINVAL;
+	}
+
+	rc = tfc_msg_hot_upgrade_process(tfcp, fid, sid, app_inst_id,
+					 CFA_HOT_UPGRADE_CMD_ALLOC,
+					 app_inst_cnt, session);
+	if (rc)
+		PMD_DRV_LOG_LINE(ERR, "failed for app instance id %d err=%d",
+				 app_inst_id, rc);
+
+	return rc;
+}
+
+int
+tfc_hot_up_app_inst_free(struct tfc *tfcp, uint16_t fid,
+			 uint8_t app_inst_id)
+{
+	uint8_t session_cnt = 0;
+	uint16_t sid;
+	int rc = 0;
+
+	if (tfc_hot_upgrade_validate(tfcp,  app_inst_id, &sid)) {
+		PMD_DRV_LOG_LINE(ERR, "failed validate for instance %u",
+				 app_inst_id);
+		return -EINVAL;
+	}
+
+	rc = tfc_msg_hot_upgrade_process(tfcp, fid, sid, app_inst_id,
+					 CFA_HOT_UPGRADE_CMD_FREE,
+					 0, &session_cnt);
+	if (rc)
+		PMD_DRV_LOG_LINE(ERR, "failed for app instance id %d err=%d",
+				 app_inst_id, rc);
+
+	return rc;
+}
+
+int
+tfc_hot_up_app_inst_set(struct tfc *tfcp, uint16_t fid, uint8_t app_inst_id)
+{
+	uint8_t session_cnt = 0;
+	uint16_t sid;
+	int rc = 0;
+
+	if (tfc_hot_upgrade_validate(tfcp,  app_inst_id, &sid)) {
+		PMD_DRV_LOG_LINE(ERR, "failed validate for instance %u",
+				 app_inst_id);
+		return -EINVAL;
+	}
+
+	rc = tfc_msg_hot_upgrade_process(tfcp, fid, sid, app_inst_id,
+					 CFA_HOT_UPGRADE_CMD_SET,
+					 1, &session_cnt);
+	if (rc)
+		PMD_DRV_LOG_LINE(ERR, "failed for app instance id %d err=%d",
+				 app_inst_id, rc);
+
+	return rc;
+}
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_msg.c b/drivers/net/bnxt/tf_core/v3/tfc_msg.c
index 0a636a1677..7ec7e9a054 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_msg.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_msg.c
@@ -1319,3 +1319,55 @@ int tfc_msg_resc_usage_query(struct tfc *tfcp, uint16_t sid, enum cfa_dir dir,
 	return rc;
 }
 #endif /* TF_FLOW_SCALE_QUERY */
+
+int
+tfc_msg_hot_upgrade_process(struct tfc *tfcp, uint16_t fid, uint16_t sid,
+			    uint8_t app_inst_id,
+			    enum cfa_hot_upgrade_cmd_op cmd_op,
+			    uint8_t cur_cnt,
+			    uint8_t *app_inst_cnt)
+{
+	struct hwrm_tfc_hot_upgrade_process_input req = { 0 };
+	struct hwrm_tfc_hot_upgrade_process_output resp = { 0 };
+	struct bnxt *bp = tfcp->bp;
+	int rc = 0;
+
+	rc = tfc_msg_set_fid(bp, fid, &req.fid);
+	if (rc)
+		return rc;
+	req.sid = rte_le_to_cpu_16(sid);
+	req.app_id = app_inst_id;
+	req.cur_session_cnt = cur_cnt;
+
+	switch (cmd_op) {
+	case CFA_HOT_UPGRADE_CMD_ALLOC:
+		req.cmd = HWRM_TFC_HOT_UPGRADE_PROCESS_INPUT_CMD_ALLOC;
+		break;
+	case CFA_HOT_UPGRADE_CMD_FREE:
+		req.cmd = HWRM_TFC_HOT_UPGRADE_PROCESS_INPUT_CMD_FREE;
+		break;
+	case CFA_HOT_UPGRADE_CMD_GET:
+		req.cmd = HWRM_TFC_HOT_UPGRADE_PROCESS_INPUT_CMD_GET;
+		break;
+	case CFA_HOT_UPGRADE_CMD_SET:
+		req.cmd = HWRM_TFC_HOT_UPGRADE_PROCESS_INPUT_CMD_SET;
+		break;
+	default:
+		PMD_DRV_LOG_LINE(ERR, "invalid command opcode %u",
+				 cmd_op);
+		return -EINVAL;
+	}
+	rc = bnxt_hwrm_tf_message_direct(bp, false,
+					 HWRM_TFC_HOT_UPGRADE_PROCESS,
+					 &req, sizeof(req), &resp,
+					 sizeof(resp));
+	if (rc) {
+		PMD_DRV_LOG_LINE(ERR,
+				 "sid[%u]:instance[%u]:cmd_op[%u] failed",
+				 sid, app_inst_id, cmd_op);
+		return rc;
+	}
+
+	*app_inst_cnt = resp.session_cnt;
+	return rc;
+}
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_msg.h b/drivers/net/bnxt/tf_core/v3/tfc_msg.h
index 2d1a6816c0..3bf6b04a12 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_msg.h
+++ b/drivers/net/bnxt/tf_core/v3/tfc_msg.h
@@ -174,3 +174,10 @@ tfc_msg_if_tbl_get(struct tfc *tfcp, uint16_t fid, uint16_t sid,
 int tfc_msg_resc_usage_query(struct tfc *tfcp, uint16_t sid, enum cfa_dir dir,
 			     uint16_t *data_size, void *data);
 #endif /* TF_FLOW_SCALE_QUERY  */
+
+int
+tfc_msg_hot_upgrade_process(struct tfc *tfcp, uint16_t fid, uint16_t sid,
+			    uint8_t app_inst_id,
+			    enum cfa_hot_upgrade_cmd_op cmd_op,
+			    uint8_t cur_cnt,
+			    uint8_t *app_inst_cnt);
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp.h b/drivers/net/bnxt/tf_ulp/bnxt_ulp.h
index 3a2745d405..afd883df2c 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp.h
@@ -139,6 +139,7 @@ struct bnxt_ulp_data {
 	uint32_t			max_def_priority;
 	uint32_t			min_flow_priority;
 	uint32_t			max_flow_priority;
+	uint32_t			ha_priority;
 	uint32_t			vxlan_port;
 	uint32_t			vxlan_gpe_port;
 	uint32_t			vxlan_ip_port;
@@ -164,6 +165,8 @@ struct bnxt_ulp_data {
 	uint64_t			default_act_bits;
 	struct ulp_fc_tfc_stats_cache_entry *stats_cache;
 	struct bnxt_ulp_sc_info		*sc_info;
+	struct bnxt_ulp_tfc_ha_mgr_info *tfc_ha_info;
+	uint8_t				app_instance_id;
 };
 
 enum bnxt_ulp_tfo_type {
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c
index 2c22582e1c..386ec57a08 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c
@@ -13,6 +13,7 @@
 #include "ulp_fc_mgr.h"
 #include "ulp_port_db.h"
 #include "ulp_ha_mgr.h"
+#include "ulp_tfc_ha_mgr.h"
 #include "ulp_tun.h"
 #include <rte_malloc.h>
 #include "ulp_template_db_tbl.h"
@@ -92,8 +93,10 @@ bnxt_ulp_set_prio_attribute(struct ulp_rte_parser_params *params,
 {
 	uint32_t max_p = bnxt_ulp_max_flow_priority_get(params->ulp_ctx);
 	uint32_t min_p = bnxt_ulp_min_flow_priority_get(params->ulp_ctx);
+	uint32_t hot_prio = bnxt_ulp_ha_priority_id_get(params->ulp_ctx);
 
 	if (max_p < min_p) {
+		min_p -= hot_prio;
 		if (unlikely(attr->priority > min_p || attr->priority < max_p)) {
 			BNXT_DRV_DBG(ERR, "invalid prio, not in range %u:%u\n",
 				     max_p, min_p);
@@ -101,6 +104,7 @@ bnxt_ulp_set_prio_attribute(struct ulp_rte_parser_params *params,
 		}
 		params->priority = attr->priority;
 	} else {
+		max_p -= hot_prio;
 		if (unlikely(attr->priority > max_p || attr->priority < min_p)) {
 			BNXT_DRV_DBG(ERR, "invalid prio, not in range %u:%u\n",
 				     min_p, max_p);
@@ -245,6 +249,12 @@ bnxt_ulp_init_mapper_params(struct bnxt_ulp_mapper_parms *mparms,
 				    1);
 	}
 
+	/* update the Hot upgrade flag */
+	if (bnxt_ulp_tfc_hot_upgrade_enabled(params->ulp_ctx) &&
+	    bnxt_ulp_tfc_hot_upgrade_is_secondary(params->ulp_ctx))
+		ULP_BITMAP_SET(mparms->cf_bitmap,
+			       BNXT_ULP_CF_BIT_HOT_UP_SECONDARY);
+
 	/* Update the socket direct flag */
 	if (ULP_BITMAP_ISSET(params->hdr_bitmap.bits,
 			     BNXT_ULP_HDR_BIT_SVIF_IGNORE)) {
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
index af3e82a6a7..385dd742d5 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
@@ -32,7 +32,7 @@
 #include "ulp_matcher.h"
 #include "ulp_port_db.h"
 #include "ulp_tun.h"
-#include "ulp_ha_mgr.h"
+#include "ulp_tfc_ha_mgr.h"
 #include "bnxt_tf_pmd_shim.h"
 #include "ulp_template_db_tbl.h"
 #include "tfc_resources.h"
@@ -546,6 +546,21 @@ ulp_tfc_cntxt_app_caps_init(struct bnxt *bp, uint8_t app_id, uint32_t dev_id)
 						  info[i].default_priority);
 		bnxt_ulp_max_def_priority_set(ulp_ctx,
 					      info[i].max_def_priority);
+
+		/* if hot upgrade is enabled */
+		if (bnxt_ulp_tfc_hot_upgrade_enabled(ulp_ctx)) {
+			uint32_t ha_prio = 0;
+
+			if (info[i].min_flow_priority >
+			    info[i].max_flow_priority)
+				ha_prio = info[i].min_flow_priority -
+					info[i].max_flow_priority;
+			else
+				ha_prio = info[i].max_flow_priority -
+					info[i].min_flow_priority;
+			ha_prio = ha_prio / 2;
+			bnxt_ulp_ha_priority_set(ulp_ctx, ha_prio);
+		}
 		bnxt_ulp_min_flow_priority_set(ulp_ctx,
 					       info[i].min_flow_priority);
 		bnxt_ulp_max_flow_priority_set(ulp_ctx,
@@ -678,6 +693,16 @@ ulp_tfc_ctx_init(struct bnxt *bp,
 	}
 	BNXT_DRV_DBG(DEBUG, "Ulp initialized with app id %d\n", bp->app_id);
 
+	rc = bnxt_ulp_app_instance_id_set(bp->ulp_ctx, bp->app_instance_id);
+	if (rc) {
+		BNXT_DRV_DBG(ERR,
+			     "Unable to set app_instance_id for ULP init.\n");
+		goto error_deinit;
+	}
+	if (bp->app_instance_id)
+		BNXT_DRV_DBG(DEBUG, "Hot upgrade instance id %u\n",
+			     bp->app_instance_id);
+
 	rc = ulp_tfc_dparms_init(bp, bp->ulp_ctx, devid);
 	if (rc) {
 		BNXT_DRV_DBG(ERR, "Unable to init dparms for app(%x)/dev(%x)\n",
@@ -875,19 +900,14 @@ static void
 ulp_tfc_deinit(struct bnxt *bp,
 	       struct bnxt_ulp_session_state *session)
 {
-	bool ha_enabled;
 	uint16_t fid_cnt = 0;
 	int32_t rc;
 
 	if (!bp->ulp_ctx || !bp->ulp_ctx->cfg_data)
 		return;
 
-	ha_enabled = bnxt_ulp_cntxt_ha_enabled(bp->ulp_ctx);
-	if (ha_enabled) {
-		rc = ulp_ha_mgr_close(bp->ulp_ctx);
-		if (rc)
-			BNXT_DRV_DBG(ERR, "Failed to close HA (%d)\n", rc);
-	}
+	/* Delete the Hot upgrade manager */
+	ulp_tfc_hot_upgrade_mgr_deinit(bp->ulp_ctx);
 
 	/* Delete the Stats Counter Manager */
 	ulp_sc_mgr_deinit(bp->ulp_ctx);
@@ -1050,6 +1070,12 @@ ulp_tfc_init(struct bnxt *bp,
 		goto jump_to_error;
 	}
 
+	rc = ulp_tfc_hot_upgrade_mgr_init(bp->ulp_ctx);
+	if (rc) {
+		BNXT_DRV_DBG(ERR, "Failed to initialize ulp hot upgrade mgr\n");
+		goto jump_to_error;
+	}
+
 	rc = bnxt_ulp_cntxt_dev_id_get(bp->ulp_ctx, &ulp_dev_id);
 	if (rc) {
 		BNXT_DRV_DBG(ERR, "Unable to get device id from ulp.\n");
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
index 2cea9e5692..cb826b2c19 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
@@ -1098,4 +1098,64 @@ bnxt_ulp_cap_feat_process(uint64_t feat_bits, uint64_t *out_bits)
 	return 0;
 }
 
+/* Function to set the tfc ha info into the context */
+static inline int32_t
+bnxt_ulp_cntxt_ptr2_tfc_ha_info_set(struct bnxt_ulp_context *ulp_ctx,
+				    struct bnxt_ulp_tfc_ha_mgr_info *ha_info)
+{
+	if (unlikely(ulp_ctx == NULL || ulp_ctx->cfg_data == NULL)) {
+		BNXT_DRV_DBG(ERR, "Invalid ulp context data\n");
+		return -EINVAL;
+	}
+	ulp_ctx->cfg_data->tfc_ha_info = ha_info;
+	return 0;
+}
+
+/* Function to retrieve the tfc ha info from the context. */
+static inline struct bnxt_ulp_tfc_ha_mgr_info *
+bnxt_ulp_cntxt_ptr2_tfc_ha_info_get(struct bnxt_ulp_context *ulp_ctx)
+{
+	if (unlikely(ulp_ctx == NULL || ulp_ctx->cfg_data == NULL))
+		return NULL;
+	return ulp_ctx->cfg_data->tfc_ha_info;
+}
+
+/* This function sets the app instance id */
+static inline int32_t
+bnxt_ulp_app_instance_id_set(struct bnxt_ulp_context *ulp_ctx,
+			     uint8_t app_instance_id)
+{
+	if (unlikely(!ulp_ctx))
+		return -EINVAL;
+	ulp_ctx->cfg_data->app_instance_id = app_instance_id;
+	return 0;
+}
+
+/* This function gets the app instance id */
+static inline uint8_t
+bnxt_ulp_app_instance_id_get(struct bnxt_ulp_context *ulp_ctx)
+{
+	if (unlikely(!ulp_ctx || !ulp_ctx->cfg_data))
+		return 0;
+	return ulp_ctx->cfg_data->app_instance_id;
+}
+
+static inline int
+bnxt_ulp_ha_priority_set(struct bnxt_ulp_context *ulp_ctx, uint32_t prio)
+{
+	if (unlikely(!ulp_ctx || !ulp_ctx->cfg_data))
+		return -EINVAL;
+
+	ulp_ctx->cfg_data->ha_priority = prio;
+	return 0;
+}
+
+static inline uint32_t
+bnxt_ulp_ha_priority_id_get(struct bnxt_ulp_context *ulp_ctx)
+{
+	if (unlikely(!ulp_ctx || !ulp_ctx->cfg_data))
+		return 0;
+	return ulp_ctx->cfg_data->ha_priority;
+}
+
 #endif /* _BNXT_ULP_UTILS_H_ */
diff --git a/drivers/net/bnxt/tf_ulp/meson.build b/drivers/net/bnxt/tf_ulp/meson.build
index c8eb39f469..000b05ad0c 100644
--- a/drivers/net/bnxt/tf_ulp/meson.build
+++ b/drivers/net/bnxt/tf_ulp/meson.build
@@ -33,6 +33,60 @@ sources += files(
         'ulp_fc_mgr_tf.c',
         'ulp_alloc_tbl.c',
         'ulp_sc_mgr.c',
-        'ulp_sc_mgr_tfc.c')
+        'ulp_sc_mgr_tfc.c',
+        'ulp_tfc_ha_mgr.c')
+
+#include the templates for compile
+
+if get_option('bnxt_tf_template').contains('app19')
+includes += include_directories('app_19_templates')
+subdir('app_19_templates')
+cflags += '-DBNXT_TF_APP_ID=19'
+
+elif get_option('bnxt_tf_template').contains('app17')
+includes += include_directories('app_16_17_templates')
+subdir('app_16_17_templates')
+cflags += '-DBNXT_TF_APP_ID=17'
+
+elif get_option('bnxt_tf_template').contains('app16')
+includes += include_directories('app_16_17_templates')
+subdir('app_16_17_templates')
+cflags += '-DBNXT_TF_APP_ID=16'
+
+elif get_option('bnxt_tf_template').contains('app14')
+includes += include_directories('app_14_templates')
+subdir('app_14_templates')
+cflags += '-DBNXT_TF_APP_ID=14'
+
+elif get_option('bnxt_tf_template').contains('app13')
+includes += include_directories('app_13_templates')
+subdir('app_13_templates')
+cflags += '-DBNXT_TF_APP_ID=13'
+
+elif get_option('bnxt_tf_template').contains('app10')
+includes += include_directories('app_10_templates')
+subdir('app_10_templates')
+cflags += '-DBNXT_TF_APP_ID=10'
+
+elif get_option('bnxt_tf_template').contains('app11')
+includes += include_directories('app_11_templates')
+subdir('app_11_templates')
+cflags += '-DBNXT_TF_APP_ID=11'
+
+elif get_option('bnxt_tf_template').contains('app12')
+includes += include_directories('app_12_templates')
+subdir('app_12_templates')
+cflags += '-DBNXT_TF_APP_ID=12'
+
+elif get_option('bnxt_tf_template').contains('app15')
+includes += include_directories('app_15_templates')
+subdir('app_15_templates')
+cflags += '-DBNXT_TF_APP_ID=15'
+
+elif get_option('bnxt_tf_template').contains('app1')
+includes += include_directories('app_1_2_templates')
+subdir('app_1_2_templates')
+cflags += '-DBNXT_TF_APP_ID=1'
+endif
 
 subdir('generic_templates')
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper.c b/drivers/net/bnxt/tf_ulp/ulp_mapper.c
index c463bce3d4..1901845499 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper.c
@@ -3785,6 +3785,7 @@ ulp_mapper_func_info_process(struct bnxt_ulp_mapper_parms *parms,
 		process_src1 = 1;
 	case BNXT_ULP_FUNC_OPC_COND_LIST:
 	case BNXT_ULP_FUNC_OPC_APP_PRIORITY:
+	case BNXT_ULP_FUNC_OPC_GET_HA_PRIORITY:
 		break;
 	case BNXT_ULP_FUNC_OPC_PORT_TABLE:
 		process_src1 = 1;
@@ -3920,6 +3921,9 @@ ulp_mapper_func_info_process(struct bnxt_ulp_mapper_parms *parms,
 							    CFA_RSUBTYPE_TCAM_WC,
 							    (uint32_t)res1,
 							    (uint16_t)res2);
+	case BNXT_ULP_FUNC_OPC_GET_HA_PRIORITY:
+		res = bnxt_ulp_ha_priority_id_get(parms->ulp_ctx);
+		break;
 	default:
 		BNXT_DRV_DBG(ERR, "invalid func code %u\n",
 			     func_info->func_opc);
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
index 046d2c5cf9..20b1ac09fc 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
@@ -316,7 +316,7 @@ ulp_mapper_tfc_tcam_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 		/* allocate the tcam entry, only need the length */
 		(void)ulp_blob_data_get(key, &key_sz_in_bits);
 		key_sz_in_words = ULP_BITS_2_BYTE(key_sz_in_bits);
-		tfc_inf.dir = tbl->direction; /* PKB.need an api */
+		tfc_inf.dir = tbl->direction;
 		tfc_inf.rsubtype = tbl->resource_type;
 
 		rc = tfc_tcam_alloc(tfcp, fw_fid, tt, priority,
diff --git a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
index 6b6733133a..fc4207b36c 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
@@ -158,6 +158,8 @@ ulp_sc_mgr_deinit(struct bnxt_ulp_context *ctxt)
 	if (!ulp_sc_info)
 		return -EINVAL;
 
+	ulp_sc_mgr_thread_cancel(ctxt);
+
 	if (ulp_sc_info->stats_cache_tbl)
 		rte_free(ulp_sc_info->stats_cache_tbl);
 
@@ -208,11 +210,11 @@ static uint32_t ulp_stats_cache_main_loop(void *arg)
 				goto terminate;
 			rte_delay_us_block(ULP_SC_CTX_DELAY);
 		}
+		bnxt_ulp_cntxt_entry_release();
 
 		/* get the stats counter info block from ulp context */
 		ulp_sc_info = bnxt_ulp_cntxt_ptr2_sc_info_get(ctxt);
 		if (unlikely(!ulp_sc_info)) {
-			bnxt_ulp_cntxt_entry_release();
 			goto terminate;
 		}
 
@@ -247,7 +249,6 @@ static uint32_t ulp_stats_cache_main_loop(void *arg)
 				tfcp = bnxt_ulp_cntxt_tfcp_get(sce->ctxt);
 				if (unlikely(!tfcp)) {
 					bnxt_ulp_cntxt_release_fdb_lock(ctxt);
-					bnxt_ulp_cntxt_entry_release();
 					goto terminate;
 				}
 
@@ -307,7 +308,6 @@ static uint32_t ulp_stats_cache_main_loop(void *arg)
 				data += ULP_SC_PAGE_SIZE;
 			}
 		}
-		bnxt_ulp_cntxt_entry_release();
 		/* Sleep to give any other threads opportunity to access ULP */
 		rte_delay_us_sleep(ULP_SC_PERIOD_US);
 	}
@@ -400,6 +400,7 @@ void ulp_sc_mgr_thread_cancel(struct bnxt_ulp_context *ctxt)
 		return;
 
 	ulp_sc_info->flags &= ~ULP_FLAG_SC_THREAD;
+	pthread_cancel(ulp_sc_info->tid);
 }
 
 /*
diff --git a/drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c b/drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c
new file mode 100644
index 0000000000..be14b65804
--- /dev/null
+++ b/drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c
@@ -0,0 +1,264 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2019-2024 Broadcom
+ * All rights reserved.
+ */
+
+#include <rte_common.h>
+#include <rte_cycles.h>
+#include <rte_malloc.h>
+#include <rte_log.h>
+#include <rte_alarm.h>
+#include "bnxt.h"
+#include "bnxt_ulp.h"
+#include "bnxt_ulp_utils.h"
+#include "ulp_tfc_ha_mgr.h"
+#include "bnxt_ulp_tfc.h"
+
+#define ULP_HOT_UPGRADE_TIMER_SEC 2 /* in seconds */
+
+bool
+bnxt_ulp_tfc_hot_upgrade_enabled(struct bnxt_ulp_context *ulp_ctx)
+{
+	uint64_t feat_bits;
+
+	if (unlikely(ulp_ctx == NULL || ulp_ctx->cfg_data == NULL))
+		return false;
+
+	feat_bits = bnxt_ulp_feature_bits_get(ulp_ctx);
+
+	/* Both hot upgrade feature and devarg instance id must be configured */
+	if ((feat_bits & BNXT_ULP_FEATURE_BIT_HOT_UPGRADE) &&
+	    bnxt_ulp_app_instance_id_get(ulp_ctx))
+		return true;
+	return false;
+}
+
+bool
+bnxt_ulp_tfc_hot_upgrade_is_secondary(struct bnxt_ulp_context *ulp_ctx)
+{
+	struct bnxt_ulp_tfc_ha_mgr_info *ha_info;
+
+	if (unlikely(ulp_ctx == NULL || ulp_ctx->cfg_data == NULL))
+		return false;
+
+	ha_info = bnxt_ulp_cntxt_ptr2_tfc_ha_info_get(ulp_ctx);
+	if (ha_info == NULL)
+		return false;
+
+	if (ha_info->ha_state == ULP_TFC_HA_STATE_SECONDARY)
+		return true;
+	return false;
+}
+
+static void
+ulp_tfc_hot_upgrade_mgr_timer_cb(void *arg)
+{
+	struct bnxt_ulp_tfc_ha_mgr_info *ha_info;
+	struct bnxt_ulp_context *ulp_ctx = NULL;
+	uint8_t inst_id, inst_count = 0;
+	int32_t restart_timer = 1;
+	struct tfc *tfcp = NULL;
+	uint16_t fw_fid = 0;
+	int32_t rc = 0;
+
+	ulp_ctx = bnxt_ulp_cntxt_entry_acquire(arg);
+	if (ulp_ctx == NULL) {
+		rte_eal_alarm_set(US_PER_S * ULP_HOT_UPGRADE_TIMER_SEC,
+				  ulp_tfc_hot_upgrade_mgr_timer_cb, arg);
+		return;
+	}
+
+	tfcp = bnxt_ulp_cntxt_tfcp_get(ulp_ctx);
+	if (unlikely(tfcp == NULL)) {
+		PMD_DRV_LOG_LINE(ERR, "Failed to get tfcp pointer");
+		goto cleanup;
+	}
+
+	if (unlikely(bnxt_ulp_cntxt_fid_get(ulp_ctx, &fw_fid))) {
+		BNXT_DRV_DBG(ERR, "Failed to get func_id\n");
+		goto cleanup;
+	}
+
+	inst_id = bnxt_ulp_app_instance_id_get(ulp_ctx);
+	if (unlikely(!inst_id)) {
+		BNXT_DRV_DBG(ERR, "Invalid instance id\n");
+		goto cleanup;
+	}
+
+	rc = tfc_hot_up_app_inst_count(tfcp, fw_fid, inst_id, &inst_count);
+	if (rc) {
+		BNXT_DRV_DBG(ERR, "Failed to get hot upgrade status\n");
+		goto cleanup;
+	}
+
+	/* Primary is no longer present */
+	if (inst_count == 1) {
+		ha_info = bnxt_ulp_cntxt_ptr2_tfc_ha_info_get(ulp_ctx);
+		if (ha_info == NULL) {
+			BNXT_DRV_DBG(ERR, "Failed to get ha_info\n");
+			goto cleanup;
+		}
+
+		BNXT_DRV_DBG(DEBUG, "Transition to Primary\n");
+		/* set the current instance as Primary */
+		ha_info->ha_state = ULP_TFC_HA_STATE_PRIMARY;
+		ha_info->app_inst_cnt = inst_count;
+
+		/* Move the tcam entries to lower priority */
+		rc = bnxt_ulp_hot_upgrade_process(ulp_ctx->bp);
+		if (rc)
+			BNXT_DRV_DBG(ERR, "Failed to update tcam entries\n");
+
+		/* set the primary session */
+		rc = tfc_hot_up_app_inst_set(tfcp, fw_fid, inst_id);
+		if (rc)
+			BNXT_DRV_DBG(ERR, "Failed to set as primary\n");
+		restart_timer = 0;
+	} else if (!inst_count) {
+		BNXT_DRV_DBG(ERR, "Invalid instance count\n");
+		restart_timer = 0;
+	}
+
+cleanup:
+	bnxt_ulp_cntxt_entry_release();
+	if (restart_timer)
+		rte_eal_alarm_set(US_PER_S * ULP_HOT_UPGRADE_TIMER_SEC,
+				  ulp_tfc_hot_upgrade_mgr_timer_cb, arg);
+	else
+		BNXT_DRV_DBG(DEBUG, "exiting tfc hot upgrade timer\n");
+}
+
+
+int32_t ulp_tfc_hot_upgrade_mgr_init(struct bnxt_ulp_context *ulp_ctx)
+{
+	uint8_t inst_id, inst_count = 0, session_cnt = 0;
+	struct bnxt_ulp_tfc_ha_mgr_info *ha_info;
+	struct tfc *tfcp = NULL;
+	uint16_t fw_fid = 0;
+	int32_t rc = 0;
+
+	if (!bnxt_ulp_tfc_hot_upgrade_enabled(ulp_ctx))
+		return rc;
+
+	tfcp = bnxt_ulp_cntxt_tfcp_get(ulp_ctx);
+	if (unlikely(tfcp == NULL)) {
+		PMD_DRV_LOG_LINE(ERR, "Failed to get tfcp pointer");
+		return -EINVAL;
+	}
+
+	if (unlikely(bnxt_ulp_cntxt_fid_get(ulp_ctx, &fw_fid))) {
+		BNXT_DRV_DBG(ERR, "Failed to get func_id\n");
+		return -EINVAL;
+	}
+
+	ha_info = rte_zmalloc("ulp_ha_mgr_info", sizeof(*ha_info), 0);
+	if (!ha_info)
+		return -ENOMEM;
+
+	/* Add the HA info tbl to the ulp context. */
+	bnxt_ulp_cntxt_ptr2_tfc_ha_info_set(ulp_ctx, ha_info);
+
+	inst_id = bnxt_ulp_app_instance_id_get(ulp_ctx);
+	if (!inst_id) {
+		BNXT_DRV_DBG(ERR, "invalid instance id\n");
+		goto cleanup;
+	}
+
+	/* get the application instance count */
+	ha_info->app_inst_id = inst_id;
+	rc = tfc_hot_up_app_inst_count(tfcp, fw_fid, inst_id, &inst_count);
+	if (rc) {
+		BNXT_DRV_DBG(ERR, "Failed to get hot upgrade status\n");
+		goto cleanup;
+	}
+
+	/* if instance count is 2 or more then just exit */
+	if (inst_count >= 2) {
+		BNXT_DRV_DBG(ERR, "More than 2 instances, invalid setup\n");
+		goto cleanup;
+	}
+
+	/* Allocate the hot upgrade instance */
+	rc = tfc_hot_up_app_inst_alloc(tfcp, fw_fid, inst_id, inst_count,
+				       &session_cnt);
+	if (rc) {
+		BNXT_DRV_DBG(ERR, "Fail to alloc hot upgrade session\n");
+		goto cleanup;
+	}
+	/* If count is 1 then set as primary app */
+	if (session_cnt == 1) {
+		/* set the current instance as Primary */
+		ha_info->ha_state = ULP_TFC_HA_STATE_PRIMARY;
+		ha_info->app_inst_cnt = session_cnt;
+		BNXT_DRV_DBG(DEBUG, "setting application as Primary\n");
+	} else {
+		/* set the current instance as secondary */
+		ha_info->ha_state = ULP_TFC_HA_STATE_SECONDARY;
+		ha_info->app_inst_cnt = session_cnt;
+		BNXT_DRV_DBG(DEBUG, "setting application as Secondary\n");
+
+		/* Start the Hot upgrade poll timer */
+		rc = rte_eal_alarm_set(US_PER_S * ULP_HOT_UPGRADE_TIMER_SEC,
+				       ulp_tfc_hot_upgrade_mgr_timer_cb,
+				       (void *)ulp_ctx->cfg_data);
+	}
+
+	return rc;
+cleanup:
+	if (ha_info != NULL)
+		ulp_tfc_hot_upgrade_mgr_deinit(ulp_ctx);
+	return -EAGAIN;
+}
+
+static void
+ulp_tfc_ha_mgr_timer_cancel(struct bnxt_ulp_context *ulp_ctx)
+{
+	rte_eal_alarm_cancel(ulp_tfc_hot_upgrade_mgr_timer_cb,
+			     ulp_ctx->cfg_data);
+}
+
+void
+ulp_tfc_hot_upgrade_mgr_deinit(struct bnxt_ulp_context *ulp_ctx)
+{
+	struct bnxt_ulp_tfc_ha_mgr_info *ha_info;
+	struct tfc *tfcp = NULL;
+	uint16_t fw_fid = 0;
+	uint8_t inst_id;
+	int32_t rc = 0;
+
+	ha_info = bnxt_ulp_cntxt_ptr2_tfc_ha_info_get(ulp_ctx);
+	if (ha_info == NULL)
+		return;
+	bnxt_ulp_cntxt_ptr2_tfc_ha_info_set(ulp_ctx, NULL);
+
+	if (!bnxt_ulp_tfc_hot_upgrade_enabled(ulp_ctx))
+		return;
+
+	tfcp = bnxt_ulp_cntxt_tfcp_get(ulp_ctx);
+	if (unlikely(tfcp == NULL)) {
+		PMD_DRV_LOG_LINE(ERR, "Failed to get tfcp pointer");
+		return;
+	}
+
+	if (unlikely(bnxt_ulp_cntxt_fid_get(ulp_ctx, &fw_fid))) {
+		BNXT_DRV_DBG(ERR, "Failed to get func_id\n");
+		return;
+	}
+
+	inst_id = bnxt_ulp_app_instance_id_get(ulp_ctx);
+	if (unlikely(!inst_id)) {
+		BNXT_DRV_DBG(ERR, "Failed to get instance id\n");
+		return;
+	}
+
+	rc = tfc_hot_up_app_inst_free(tfcp, fw_fid, inst_id);
+	if (rc)
+		BNXT_DRV_DBG(ERR, "Fail to free hot upgrade session:%u\n",
+			     inst_id);
+
+	/* disable the hot upgrade timer */
+	if (ha_info->ha_state == ULP_TFC_HA_STATE_SECONDARY)
+		ulp_tfc_ha_mgr_timer_cancel(ulp_ctx);
+
+	rte_free(ha_info);
+}
diff --git a/drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h b/drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h
new file mode 100644
index 0000000000..44cbf56c0a
--- /dev/null
+++ b/drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2014-2024 Broadcom
+ * All rights reserved.
+ */
+
+#ifndef _ULP_TFC_HA_MGR_H_
+#define _ULP_TFC_HA_MGR_H_
+
+#include "bnxt_ulp.h"
+
+enum ulp_tfc_ha_mgr_state {
+	ULP_TFC_HA_STATE_INVALID = 0,
+	ULP_TFC_HA_STATE_PRIMARY,
+	ULP_TFC_HA_STATE_SECONDARY,
+	ULP_TFC_HA_STATE_MAX,
+};
+
+struct bnxt_ulp_tfc_ha_mgr_info {
+	enum ulp_tfc_ha_mgr_state ha_state;
+	uint32_t app_inst_id;
+	uint32_t app_inst_cnt;
+};
+
+bool
+bnxt_ulp_tfc_hot_upgrade_enabled(struct bnxt_ulp_context *ulp_ctx);
+
+bool
+bnxt_ulp_tfc_hot_upgrade_is_secondary(struct bnxt_ulp_context *ulp_ctx);
+
+int32_t
+ulp_tfc_hot_upgrade_mgr_init(struct bnxt_ulp_context *ulp_ctx);
+
+void
+ulp_tfc_hot_upgrade_mgr_deinit(struct bnxt_ulp_context *ulp_ctx);
+
+int32_t
+ulp_ha_mgr_state_get(struct bnxt_ulp_context *ulp_ctx,
+		     enum ulp_ha_mgr_state *state);
+
+#endif /* _ULP_TFC_HA_MGR_H_*/
-- 
2.39.5 (Apple Git-154)

