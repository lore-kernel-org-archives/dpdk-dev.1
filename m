Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CA6CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:11:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00B17410DC;
	Tue, 30 Sep 2025 09:06:24 +0200 (CEST)
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com
 [74.125.224.98]) by mails.dpdk.org (Postfix) with ESMTP id 6A8FD402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:41 +0200 (CEST)
Received: by mail-yx1-f98.google.com with SMTP id
 956f58d0204a3-633bca5451cso4175741d50.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192661; x=1759797461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MRsENC4Viidj19eJaPgx+JkoWlc3pPOeodcuteLCIgY=;
 b=mWndUrYA3oo0h+blYWDkCiYdqGyKfu9j9kX2Uv2B9vDLwRk0G9WfH5m8rFzVVsgMUw
 dzFLwGLEFW5xHDOZaSgwt7G9SeuqXyEwHaYKB9lqN1y7QLBl332xZgpIbtirw3+p85e6
 RVqJ5YBPRUUI4o9mOLZpe/vysvz2EV6+ijkb8Hx157+yJ1Y2vAWIvR8k7EDScleROAlI
 OD7h3RXsoOTFpt8k37121SSJ8HREMJv1d8ubnzP5ajOiPxCDZaZKOpCbtGf+HlqbGjbb
 GIbZHtezvJoC0SOg66lPAVSVHctpMWdEuR8YERyzG6FvM8w/2Gm/mYYdhHCuxOAflBFN
 Da/g==
X-Gm-Message-State: AOJu0YzY9Hd+7LTPSYQvevlQc7sXp51E7g5ws9k4nUq0K4ZbsuveRFVg
 iNbI3F8YkwyuFf75ezOwX81NAISwch0ypmHQSmCWZ+T8zqwgG87TfcKhwA0BKguYs2pHtBYKga1
 qWkB0RzXgYUByWtHpzjbQNxikQWi3I1vIwVVeLzsPEiv+8h08olDf0T5aOXka/CQXWdzGaJIkNe
 3AUFf3NS1TUBSEgv1Ayu85K9veEtEa3Aw8ZFRNpEYcX+rY4r61nQ/lh25r/tV+hMRUCV6Pag==
X-Gm-Gg: ASbGnct85I1RMoJpNYfTVEZQ1d14T5XfsWasZX6agik7aFOIV2ECsKs0XS3vkC/13W5
 E9dJvJnfEGrMsKDpGzYhtFrnXXnpX6d5sieYXDTpszdnRwXB2jSo3R+V6ROLjGmBGuvhOhHZjuP
 dxy/83NgjiJBNwHwQThrOR3yAkp4C0xUbS1B/+qcr6CICQFnvq4wXahOCKY2zUbVkB3o4tm042y
 8jO3l3lhC6KoJ/Ks847oMTwHJ539FiC/aa4d2+rZJiXzVoULBOtDgIyBCDgNzTbYqHnIHQRvrFy
 euwMQWn/Zhz5IeQhd96ip0o3vsR5PbqpWqkusQhsIgKGPllus2oU1Y/+YkUxPyx2kc/axvitPXk
 Gf2c7TL+f+aLmPiIWWXUE+RXp/dCmRRgVfNqj3aA/Q02jXNJiuYW2kRaSJH16zs2Nb85pO70fTF
 UR1UjXq34=
X-Google-Smtp-Source: AGHT+IHnE76G7DSSCP1vGumR4qsprqBsU8AYpzZJ1PbzCCeC2V/anxyKR2wXq1m21ZhlIhB1tq4XuYv3ktdI
X-Received: by 2002:a05:690e:245b:b0:62c:b00b:8f74 with SMTP id
 956f58d0204a3-6361a85f9efmr15309106d50.31.1759192660757; 
 Mon, 29 Sep 2025 17:37:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-6361e9416d5sm580351d50.14.2025.09.29.17.37.40
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-781171fe1c5so3354931b3a.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192659; x=1759797459; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRsENC4Viidj19eJaPgx+JkoWlc3pPOeodcuteLCIgY=;
 b=BN2sDLie5Vysgm5c0BKGB6RrUVditLl70Gi6HjMRfrsoaXgUFuRPlWn7yPzlIWGpx6
 7Fd1M2oM3OML4syJrt+Z4P1NYkvWxS1Z39tziakkchzpJgFvUfyioruN910p50tSGwhs
 WvZA5yzWq71FFUnqg0iW6blCFOImWtN2wdxXM=
X-Received: by 2002:a05:6a20:918e:b0:24c:f8f:2b95 with SMTP id
 adf61e73a8af0-2e7d0ad11ddmr25001035637.40.1759192659135; 
 Mon, 29 Sep 2025 17:37:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:918e:b0:24c:f8f:2b95 with SMTP id
 adf61e73a8af0-2e7d0ad11ddmr25000995637.40.1759192658610; 
 Mon, 29 Sep 2025 17:37:38 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:38 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com
Subject: [PATCH 46/54] net/bnxt: truflow HSI struct fixes
Date: Mon, 29 Sep 2025 20:35:56 -0400
Message-Id: <20250930003604.87108-47-manish.kurup@broadcom.com>
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

