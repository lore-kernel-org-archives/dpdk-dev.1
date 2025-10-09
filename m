Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31051CCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:18:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C81740B9B;
	Fri, 10 Oct 2025 00:16:39 +0200 (CEST)
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by mails.dpdk.org (Postfix) with ESMTP id B250140E54
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:37 +0200 (CEST)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-2897522a1dfso14375735ad.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048197; x=1760652997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MRsENC4Viidj19eJaPgx+JkoWlc3pPOeodcuteLCIgY=;
 b=TAd45hLGEUr0HbIwNhghH1QvdhU+F/DKO9O70+SMXIs5H/PJT6lXphbmJco6fdeCBw
 5R4KpuwwvsiiyREHmpU/Chf3StMfHhdEI4t7o2N9x8L3VmTdDmELMnPFkv3K/LQh6T59
 PrlvazInHBvSPGq+t+isDvetB2zqun0o1VS8agEZzyfUfwChbukDEK1CmVSnpJO0q0Sv
 Xw0EixsAnRbcNox6uIS/JDGEWHDFLF63A5YssQeUC5Q7nUR5Ol96J/JfWU/uMPGxk2Uj
 JJoOpkyFZH/iPRmTzfXUwpnj3n1aTAN1yl+5JuvTwFFOkh1JSWQXErE/ZV3NFGHxSg4Y
 +tHQ==
X-Gm-Message-State: AOJu0YxHsm+VFJM+onfTmDZrgxopzXJWYdXaP3VNF+F2q2HPcbN1X45g
 WrxvN+cxsMSZ2MV8jBg0LOhaFZNcbUFR6/hf4Lei7KCDGEdtI33W0pAA66J4ETmpyRzv6KiZy4b
 B6OTTMR9VHKlqhOEiyoPTapPm0ZKDuVkXhsJYwtpYXRAQEO5uQxK70LM3+L5XmrS70+M6J9Bzl0
 9pQg76Q7OOi2lVQmJxY0sFEcZ66OoBQdg3Npz252VwAYIkMy1fpi+6HZJEkS2fN6euLy5kyA==
X-Gm-Gg: ASbGncsnWylTFu7ART017wEyp6v7gGQRypLtH+tBnH8P0ZgqDzfSP3yfJYVMtm6cffu
 V43J8pVMJdm5306FkCOFGeh3Jt4jkCNykR0yWIBr5OKGeyoMcCgCkApR/Gx+LE1AW2ZTjZJURww
 lRZkl5aiObQg3BgAMtW3fcGcxUgRZ+RxfQO/FZcW3PjXPOnoOENdEfiO2wlJOcVYz5PFp30Gtva
 rvGsxpocl+SgbbzdEY+WpzXxciMg3fhtz0G184uJMLwGhXShR2qEoigX3blIazoEzt8qjUmwx6K
 FNozdrW2EsnsbnbdR4QGItUqHcnykbqOfs6JDELyDQS74FHeReKF1H0SlZmiryP0Eu8E8zTGKDC
 Pna+Aak/EID0Ffye4kymyeMluLyIPHt0//vxYdi+mY3CwjP6jBH+L0XBzYPtXv87K4BD1SCY6ke
 RPhJvh0jY=
X-Google-Smtp-Source: AGHT+IEihaIDHPB5dNqWj4aOzHDIh1/CuQlMQwop34MM26bQ2Y3uiZM81d76rwiO46sMuP7J8uAuwBwKDRgy
X-Received: by 2002:a17:902:e883:b0:271:fead:9930 with SMTP id
 d9443c01a7336-290272f835amr138083305ad.59.1760048196735; 
 Thu, 09 Oct 2025 15:16:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29034f2dcb5sm3376055ad.50.2025.10.09.15.16.36
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4df60ea7a1bso51924931cf.2
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048195; x=1760652995; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRsENC4Viidj19eJaPgx+JkoWlc3pPOeodcuteLCIgY=;
 b=WDdlUpDjh+GAte7huTU0Hy39RX/wPEuvXFPfaVnuN58/4ndJoLKAd2rFE0QVHRF75w
 DY1yWkiFGDU/PIqzLzS0OiGfoOSzGefcXuEsjiegC+eXFAcsusg98W2r2Sb0kHrkv/wi
 O+C06ueabZ2cbAaS4jD1aCWYG1Ft5MgdzHfm0=
X-Received: by 2002:ac8:5a55:0:b0:4e5:8088:e7c3 with SMTP id
 d75a77b69052e-4e6eacccc41mr129553771cf.9.1760048194982; 
 Thu, 09 Oct 2025 15:16:34 -0700 (PDT)
X-Received: by 2002:ac8:5a55:0:b0:4e5:8088:e7c3 with SMTP id
 d75a77b69052e-4e6eacccc41mr129553301cf.9.1760048194476; 
 Thu, 09 Oct 2025 15:16:34 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.16.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:16:34 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com
Subject: [PATCH v2 46/54] net/bnxt: truflow HSI struct fixes
Date: Thu,  9 Oct 2025 18:11:21 -0400
Message-Id: <20251009221129.28256-47-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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

Fix struct definitions in HSI to add __rte_packed_end

Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/hsi_struct_def_dpdk.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/bnxt/hsi_struct_def_dpdk.h b/drivers/net/bnxt/hsi_struct_def_dpdk.h
index 866fc5379d..06c61cba8f 100644
--- a/drivers/net/bnxt/hsi_struct_def_dpdk.h
+++ b/drivers/net/bnxt/hsi_struct_def_dpdk.h
@@ -24521,7 +24521,7 @@ struct __rte_packed_begin ts_split_entries {
 	/* Indicates the region is locked in the cache */
 	uint8_t	locked;
 	uint32_t	rsvd2[2];
-} __rte_packed;
+} __rte_packed_end;
 
 /*
  * Common structure to cast crypto key split entries. This casting is
@@ -45077,7 +45077,7 @@ struct __rte_packed_begin hwrm_vnic_plcmodes_cfg_output {
 } __rte_packed_end;
 
 /* hwrm_vnic_plcmodes_cfg_cmd_err (size:64b/8B) */
-struct hwrm_vnic_plcmodes_cfg_cmd_err {
+struct __rte_packed_begin hwrm_vnic_plcmodes_cfg_cmd_err {
 	/*
 	 * command specific error codes that goes to
 	 * the cmd_err field in common HWRM Error Response.
@@ -45092,7 +45092,7 @@ struct hwrm_vnic_plcmodes_cfg_cmd_err {
 	#define HWRM_VNIC_PLCMODES_CFG_CMD_ERR_CODE_LAST \
 		HWRM_VNIC_PLCMODES_CFG_CMD_ERR_CODE_INVALID_HDS_THRESHOLD
 	uint8_t	unused_0[7];
-} __rte_packed;
+} __rte_packed_end;
 
 /***************************
  * hwrm_vnic_plcmodes_qcfg *
@@ -62717,7 +62717,7 @@ struct __rte_packed_begin hwrm_tfc_resc_usage_query_output {
 
 
 /* hwrm_tfc_tcam_pri_update_input (size:256b/32B) */
-struct hwrm_tfc_tcam_pri_update_input {
+struct __rte_packed_begin hwrm_tfc_tcam_pri_update_input {
 	/* The HWRM command request type. */
 	uint16_t	req_type;
 	/*
@@ -62794,10 +62794,10 @@ struct hwrm_tfc_tcam_pri_update_input {
 		HWRM_TFC_TCAM_PRI_UPDATE_INPUT_TRACK_TYPE_TRACK_TYPE_FID
 	/* unused. */
 	uint8_t	unused0[5];
-} __rte_packed;
+} __rte_packed_end;
 
 /* hwrm_tfc_tcam_pri_update_output (size:128b/16B) */
-struct hwrm_tfc_tcam_pri_update_output {
+struct __rte_packed_begin hwrm_tfc_tcam_pri_update_output {
 	/* The specific error status for the command. */
 	uint16_t	error_code;
 	/* The HWRM command request type. */
@@ -62817,7 +62817,7 @@ struct hwrm_tfc_tcam_pri_update_output {
 	 * to be such that this field is written last.
 	 */
 	uint8_t	valid;
-} __rte_packed;
+} __rte_packed_end;
 
 /********************************
  * hwrm_tfc_hot_upgrade_process *
@@ -62825,7 +62825,7 @@ struct hwrm_tfc_tcam_pri_update_output {
 
 
 /* hwrm_tfc_hot_upgrade_process_input (size:192b/24B) */
-struct hwrm_tfc_hot_upgrade_process_input {
+struct __rte_packed_begin hwrm_tfc_hot_upgrade_process_input {
 	/* The HWRM command request type. */
 	uint16_t	req_type;
 	/*
@@ -62887,10 +62887,10 @@ struct hwrm_tfc_hot_upgrade_process_input {
 	uint8_t	cur_session_cnt;
 	/* unused. */
 	uint8_t	unused0;
-} __rte_packed;
+} __rte_packed_end;
 
 /* hwrm_tfc_hot_upgrade_process_output (size:128b/16B) */
-struct hwrm_tfc_hot_upgrade_process_output {
+struct __rte_packed_begin hwrm_tfc_hot_upgrade_process_output {
 	/* The specific error status for the command. */
 	uint16_t	error_code;
 	/* The HWRM command request type. */
@@ -62912,7 +62912,7 @@ struct hwrm_tfc_hot_upgrade_process_output {
 	 * to be such that this field is written last.
 	 */
 	uint8_t	valid;
-} __rte_packed;
+} __rte_packed_end;
 
 /******************************
  * hwrm_tunnel_dst_port_query *
@@ -64280,7 +64280,7 @@ struct __rte_packed_begin pcie_ctx_hw_stats {
  * identical up to and including the pcie_recovery_histogram field.
  */
 /* pcie_ctx_hw_stats_v2 (size:4096b/512B) */
-struct pcie_ctx_hw_stats_v2 {
+struct __rte_packed_begin pcie_ctx_hw_stats_v2 {
 	/* Number of physical layer receiver errors */
 	uint64_t	pcie_pl_signal_integrity;
 	/* Number of DLLP CRC errors detected by Data Link Layer */
@@ -64385,7 +64385,7 @@ struct pcie_ctx_hw_stats_v2 {
 	uint64_t	pcie_blocked_packet_count;
 	/* The count of completion packets sent to the PCI-e. */
 	uint64_t	pcie_cmpl_packet_count;
-} __rte_packed;
+} __rte_packed_end;
 
 /****************************
  * hwrm_stat_generic_qstats *
-- 
2.39.5 (Apple Git-154)

