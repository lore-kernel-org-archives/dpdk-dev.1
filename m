Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B5BCCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:07:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 228974113D;
	Wed, 15 Oct 2025 11:05:28 +0200 (CEST)
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by mails.dpdk.org (Postfix) with ESMTP id 529D640E3E
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:05:27 +0200 (CEST)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-27edcbbe7bfso73729015ad.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519126; x=1761123926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MRsENC4Viidj19eJaPgx+JkoWlc3pPOeodcuteLCIgY=;
 b=cOcYHxLEyYLvs/9Ah+Q7UJwUHzEUKvB+SjgnbRePabzAJkdEyZOXE1ziSkHBVhghf6
 3r4Ab6+CO75O6xg0ZZO8d5TM7kPNE6Tx0oZ6dffzIOiwdJeDxZ0reQXdCmcI9pzxDPP7
 ASImbWHNSc3NwfGSESXvgeCfLQ8TA28M86M1yeayiwPg/mQvOdkNZEeQ/M5UGvdXfGo3
 BrObdj08mPL4tk8hGExCwuhfI29Re4HPX7v0mqX5fwhl4S+gWzRfMEicbKCVRQf+yCJM
 Z/i94qJoqIt1CbbEwYUqtPdGyo3ogcXOCsVGise0XAgz3c/QITmIyIV96MTCUH+j0Djw
 AXPw==
X-Gm-Message-State: AOJu0YyqsFmJBkAgqUqqkwuDeGGl2Z2yHTFKZZZ6hk7Lhf0nbgoPXZZd
 FgqEQrrWyR+fE7KGdqbz0MVODOxbrBB42pyiEHs4G/pLpW1ZQSg5u3C0LG8Pao+cB94HCxyps9e
 KG1OwbZs6+FUtb0DiR+6tQAN1Cc7kw6xzhh6lM/LRbLjTim/QVthtDcY+SwFU3nLzyZFr6UBnhm
 qX9yf6f+4ovyhKKh9CWQZUvxeBja3H+Gu/w3L5n+yLb3gaz2SJ8HbPn06fCeD6y9GX+AdHdg==
X-Gm-Gg: ASbGncs5mR3MsWrfLBcm8KwqcCeiydWTtL2bJj/sCvat/E3enG8YI9GLIX1lnXT0XJ9
 GJsOoV3c0cgVu0jV1KK9K4386lDNLbXycH38p27xUETdtpD4nY6Iy+oRc6IS4qsYMVamHwacy5D
 NYv3ioGV94B41nnhN5X0CX97aN0gbVqNJdqXPnQyF3mBR5hT9pvhBjHjjqIeIQbnerL4+o+G8lj
 1lvvT+bYfaJNu/1yGf/WNFxSeDN61S2yPe29zAm5j4GnltL+Qxbm/A422SL0oTwpk752iTShiKp
 46Abr0HrbjK8uBmsS4dKD3Rn2ZB6vgj6+ujVzpeX5mZgLg49d9arH95h7tPRmx0admZ8/jr4lXQ
 u/gMf+zQ5nggo8F71lrWw4CLtxU9uFu87EhS11GEWM4K/CeWd6JlM9F3QaMGW6/HgC0Q3jI4j
X-Google-Smtp-Source: AGHT+IEj25BSxqBwsgsmHQdDxWzLah4ImVjzC8OkVqcTZOEPc6+s3twrPjKP8+28tHMT0O3oGwkrFrzZDAEh
X-Received: by 2002:a17:903:2b0c:b0:267:9e3d:9b6e with SMTP id
 d9443c01a7336-290272ff562mr328997685ad.51.1760519126377; 
 Wed, 15 Oct 2025 02:05:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2907fdcd784sm3205425ad.51.2025.10.15.02.05.25
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:05:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7810af03a63so17896261b3a.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519124; x=1761123924; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRsENC4Viidj19eJaPgx+JkoWlc3pPOeodcuteLCIgY=;
 b=RM+oVVkzoShwB7EDW0bxMKbD4rECdykfpAgInx2nu+bfCdea3oxO0pHaCXB3gxVr8H
 EP06ejK1mT/RALCLGLFBjQgLrO6arE+Sbo3jL/It6b9NGYbLO+rLiRR6OnJ5z6ILPqAe
 9fuAR8iBadMQI3NxqKOg1kG1Qv61squtTzl0M=
X-Received: by 2002:a05:6a00:1385:b0:781:9f2:efb1 with SMTP id
 d2e1a72fcca58-79387146b38mr36892150b3a.15.1760519123887; 
 Wed, 15 Oct 2025 02:05:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:1385:b0:781:9f2:efb1 with SMTP id
 d2e1a72fcca58-79387146b38mr36892096b3a.15.1760519123127; 
 Wed, 15 Oct 2025 02:05:23 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.05.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:05:22 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com
Subject: [PATCH v3 46/54] net/bnxt: truflow HSI struct fixes
Date: Wed, 15 Oct 2025 05:00:16 -0400
Message-Id: <20251015090024.32250-47-manish.kurup@broadcom.com>
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

