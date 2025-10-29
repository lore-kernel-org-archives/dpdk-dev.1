Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F161CCCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:23:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58B3640B95;
	Wed, 29 Oct 2025 17:23:38 +0100 (CET)
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com
 [209.85.160.99]) by mails.dpdk.org (Postfix) with ESMTP id DC27640A70
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:23:31 +0100 (CET)
Received: by mail-oa1-f99.google.com with SMTP id
 586e51a60fabf-3d1bc63d5f0so80426fac.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761755011; x=1762359811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C7BKwQxn9WxKmqk9jDHknKPvm0h93ycbhxxDxRHK4gg=;
 b=E/9rNG8VJyd5W0DFFFg5/N4k/nspAhodehLHv6ZtWhAjjUwbPwzDDqU19vEmAADShW
 i3M/PDAaIv9nNL1S3/81SCypITo+Cmk/CUDhYm6R824U0pKw593W6saBt6vj2ni51jh1
 Ng7vAvYN6RwG9FbskLaqp2wChIhG07daNR67iJQPbPfLNwtnbe0YhsjrY70Qq+VUR4/U
 JVPit/3Vl5GC5gd0BNhSb0USCJrZBgxMMmar+fcb64KajD/0qqja/e3vGJ6OCgoQt+hr
 bppV1chRblN7q+hOJIGHqt7eKVYVlLDiKE1Xiu3Ik3SeYiDc80pZi+dOyj+o3AGlv4tc
 gSNg==
X-Gm-Message-State: AOJu0Yw1eFW3jtY1xmOq8TFsuze/I0khTew5A90TPdmkGDB6JuboyK4y
 PEIDYD8qvx9/9qgZHf7ZvdgN842OCvEDy1XuIXEK7E+2GmSp3hYzA+pegytXUl77zNLIJqoz750
 vFmJEJO9FnAWeImPjalYHXnQ8KDDQXy7tbQ/UDQLr7/dczp1jifLIcracpevI8iILwOjBOe/PDS
 t+uJ9WeTU2NHIiEyaP+lAbF49iqQht3X4LfmoHGenmNnXGH1Wm+WB88EcBP873PtV0+nu0ug==
X-Gm-Gg: ASbGncuFyQDc14vVqYa8mrorM0ms6bFzXzxDY+vAoOmEeZjBg2qmJFgWGoQkMYj7eIy
 b+ZnB/oEYUN32bjn5WPr5vGmdSL3PImjTBfNDuansu5vFVSs0I/XxovRRpu+UGBDlFzRae1FmU0
 kgf6jIlLj3DoL+yPAuOjJJnPtNrvoBX3k1t3qSjn6H8EP8sXbsC6zxk5mNVOUtIGgCLujbhhfMk
 Df/av/eRRRzn6JFlfvDAysPlBJ3p3xSxprT87wKRq0jdxZ3YWOhHepifhqHLwlkSNZ2Q6wxgVkj
 i/0ApP1qmNY991mUMP3TZXmQqj2SmqqqABwET9drAExGclaLfj93Pa2jCBMx0aR7yatKIPDsmKc
 RMLTSUvWiCKMk+g4QtLWnE8pWZjIbFW73KGpIWBdE2Bo8o0NXrHtLBvYDpQ+jdrTgcmI9/sMOsm
 MhNvuFBJDJ9/JtOTeXuwb8qnZbvPsVZLE=
X-Google-Smtp-Source: AGHT+IEEvE4Ym18AlUT86cVuAvkPWFc3MRwZgasp8cJ8UWGVzAkgRcOtPf1nF7FHcSOJahdXOwheYep1gwtM
X-Received: by 2002:a05:6870:9e94:b0:3c9:8590:ca1e with SMTP id
 586e51a60fabf-3d745b87fb3mr1723517fac.14.1761755010026; 
 Wed, 29 Oct 2025 09:23:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-3d1e3553124sm1321597fac.15.2025.10.29.09.23.29
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:23:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-89090e340bfso1778385a.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761755009; x=1762359809; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C7BKwQxn9WxKmqk9jDHknKPvm0h93ycbhxxDxRHK4gg=;
 b=hYCYz3mn1YybhiOH/lIVZ1Ma3rZ87lMVdWoFUDO1vuQsTcsVvx23Z6eJ8jVA6c5KLl
 u+Yulcf3xB06hQqQPwVSMwPRtnTAWMnfn7QYNBCEFJoH8PVclRRuuGuWPWaMNpwQaF+T
 UUf5cOR5vOWsPLObQCE1nmImNKilFI81qUgJM=
X-Received: by 2002:a05:620a:2996:b0:8a1:ac72:e3dc with SMTP id
 af79cd13be357-8a8e6287307mr482336185a.43.1761755008684; 
 Wed, 29 Oct 2025 09:23:28 -0700 (PDT)
X-Received: by 2002:a05:620a:2996:b0:8a1:ac72:e3dc with SMTP id
 af79cd13be357-8a8e6287307mr482329385a.43.1761755007893; 
 Wed, 29 Oct 2025 09:23:27 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.23.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:23:27 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com
Subject: [PATCH v5 49/57] net/bnxt: truflow HSI struct definition cleanup
Date: Wed, 29 Oct 2025 12:07:04 -0400
Message-Id: <20251029160712.58519-50-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
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

Modify struct definitions in HSI to add __rte_packed_end

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

