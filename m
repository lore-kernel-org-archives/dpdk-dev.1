Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE464CCD1A5
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 18:59:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAE09410F9;
	Tue, 21 Oct 2025 20:58:31 +0200 (CEST)
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com
 [209.85.222.228])
 by mails.dpdk.org (Postfix) with ESMTP id 66C6F40A6E
 for <dev@dpdk.org>; Tue, 21 Oct 2025 20:58:30 +0200 (CEST)
Received: by mail-qk1-f228.google.com with SMTP id
 af79cd13be357-891667bcd82so29009285a.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073110; x=1761677910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MRsENC4Viidj19eJaPgx+JkoWlc3pPOeodcuteLCIgY=;
 b=wB3IWQFZTKgbC8EsFn+DTVPJLR4ZMs/+65+dOfKYZ8YEucjMvUE5K9UQ/xNSnXYWcu
 I07HkwfVPo6QlBXStld7KAHHZ1q54K5cL6RPSCSLOphsqJh/9nzsQlH4GKDzOfdUpRsT
 4XGR/oV+9trubv05Cc9/DvF5PTLcGV1+59TOXHbS2Aw0f+wEagxlfa0Hf6wTFnhzPp72
 q+j5Rdy85MCT0GDFyI6yB1EWk5G6F+Sq0+6rUdfS4C5GFtuUXg6zalYQabkKP06tBYpA
 +IMDDO4NbL2gg20BfSSseDuSqzUyZ0yfx6iJTCMU3lNuQnACKza3anw6CwPwNzQsmNz+
 rJsg==
X-Gm-Message-State: AOJu0Yz6I2DETXa1yB43HKv7WNYmuFV23qpIm+rec7jTU2X6G1Rb3FLY
 h4dDT9JE97xk9GqZMEu/EF3YKPCGNUguzUorxEvE+u0nzbiIB5J2EZ/vwpv3ZKpfDu32AM9aPIk
 qTqrxWmG8UyYDbB6rXOapKFxjXlsSsTgEYdZqGBkb0xVVb/4bk5mdDGSgOZVj+YD8qM4+VZ3X0x
 2YwXna2FNdcrlg5HLGAIqLCeG5GXV9NN8E7xRjqOAAvuRd+U2Y1BOuRA/K10WkQhohti3PsA==
X-Gm-Gg: ASbGncv0CnXL+8cQvRUr8xTYIbPmnqi5Grp+PrahQNMLV8Los7r5X/KI9Kb8qiMwNo8
 M0v+yYxj9dRxzSHfsuCHPNA5sOgP+GPsT2N+oNeODPKSS9+9TPwUBw31EPD20n6hltfobSjVuR2
 4+QZoFZZ4Uo/79nMFOWF1c9y7ZikhSQ+OF/xcptRCWgcE1aw5Iqn+ZMu+8FqIIl+XK7cegDmAfQ
 Qsa9MjoZ8WpYqQTYYJivjrRLLLB3acFMN1utSVTRllaHPJFyFsOcB+zNRjotS3iyBclxEhEkA2n
 hMp3JaoLxvaMqgI6DSb/xEAJKOS/KUHAYRt2/4XjCMzUrolvYuI7elz7fenIBtyGsLxQ4EzedDf
 QDERcblrq1ZlHhMNstu2/m3igqbLcTx33e6vgRURdNZlEGkm2hi7YZWyI9UPn4qQQJEYIcNG39L
 flT+WwMkZW9wX32c9/aSQBTJzFPzkld87NDg==
X-Google-Smtp-Source: AGHT+IF1w33eqZXcTFZbETCvO0Qlp1ShuvcwCl8wIP76AgF89krBZbIArON7nLNKjMB65EDwBlNmZ49CsrgI
X-Received: by 2002:a05:620a:458d:b0:816:dc4a:1aec with SMTP id
 af79cd13be357-899e89ef83cmr104326885a.25.1761073109570; 
 Tue, 21 Oct 2025 11:58:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 af79cd13be357-891cf29d279sm130391285a.4.2025.10.21.11.58.29
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 11:58:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2909daa65f2so2182095ad.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761073108; x=1761677908; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRsENC4Viidj19eJaPgx+JkoWlc3pPOeodcuteLCIgY=;
 b=ZTJa0f8I8lT2mTb4Mmu2wE2nvya6AzWX3G8QTSSboAPCpIxzmz9B5ly+psgB8WIWws
 bkm0fIE2t1HqqTcmyvN1rcCq82VyMCQGVdeKEFPHzIPXKyxBZAoMZfyZjLoEgZy4JLwT
 3w6OoPLpMNKYsL5J7K13fQ91CD3+fDfMgY4Hk=
X-Received: by 2002:a17:903:246:b0:25d:510:622c with SMTP id
 d9443c01a7336-292ffc8d087mr9008025ad.28.1761073107873; 
 Tue, 21 Oct 2025 11:58:27 -0700 (PDT)
X-Received: by 2002:a17:903:246:b0:25d:510:622c with SMTP id
 d9443c01a7336-292ffc8d087mr9007725ad.28.1761073107360; 
 Tue, 21 Oct 2025 11:58:27 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246fdc9cfsm116598155ad.45.2025.10.21.11.58.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 11:58:26 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com
Subject: [PATCH v4 49/57] net/bnxt: truflow HSI struct fixes
Date: Tue, 21 Oct 2025 14:56:53 -0400
Message-Id: <20251021185701.71881-18-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021185701.71881-1-manish.kurup@broadcom.com>
References: <20251021185701.71881-1-manish.kurup@broadcom.com>
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

