Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68575CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:07:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CBF940DF6;
	Tue, 30 Sep 2025 09:05:44 +0200 (CEST)
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by mails.dpdk.org (Postfix) with ESMTP id 51FE4402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:36:55 +0200 (CEST)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-2698384978dso38526485ad.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192614; x=1759797414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LMtxASq1/1oBrjK86dsCK0T/No2f00bZhdcrisEv0Qk=;
 b=e876E7up6qWtLtOk4rkNVqtvvE1u290VVOpfp7h5MZmGurEm9nL8HChIP+z9NCmUsN
 CvvNIC+mlSANzrTLTfvJ870SyDlPIANT6okbfTYTe3rS4noPEchiQspMB43IRns54GMD
 3kYpaoVir/X5UHsqlRCjk4tkS7HyVSkG4PcrYGdpH18yl5wTGRTzbjtucT/TZ7PjxMT/
 SooQGF2HWAMtggVM47KSg4gaiTIcHGK094WgaPx/+VOPDd2rLemkAi9/lTvKCo0Gm0DJ
 ZtGBPBnVEXIvHwnjvPDRsEOgWs41HpoGXt73J9ZlRX4EuM2LhTIYP0R7rtyIZLbZ982Q
 G/BQ==
X-Gm-Message-State: AOJu0YyaGZLC2lNogzf/EMKp3mjjfUu+EhG2RlOGNMhOM+T3FlFk17sk
 8wqxpPEermuNUVuBICsNSzR493t+avBh5DucDD6HvDjqf27/+KIu381FygB3z6NYYjnWoDpqHzu
 sTtLChhKS5WCol3lbqYT/GYkAJGmni+zG8pqbCMY25OGSKyVdbJqQ9Ll7pUMbbKlkMoJLBe7pIb
 LkNATnHzBTTr780Q/QbZmV6Odfd+hkbBcgrXXINdOZBSzG123gBClHURKufnxsTxKxReD9Ag==
X-Gm-Gg: ASbGncsNHZY1hGnLtQiUqxBzwOLguP5BS8sYIMR0g0YSWUBayUflm+yIj/ziUIfd7jd
 U65xLBbXOfdj5CgMoETiV1GTFoWvy40ZoWf0Jev6DYqggvOApN1ceNna4ZBrP7Q8WVbTwuvmfz5
 IgygfZE9VqbCSJ4YFgtiWxVkWbIpFmeK9z4zpoKLxKkOHpBXItM/ggEvQSeQADAV9Do0jXQcgOp
 aK49ILAuo+mNzMFsECV+gYTj8a0v0LJA29slc/7Dcp0cKZTSFxzjavHwTCklcbvQGkBE9soS7bU
 Q3zZkOasDyscVwOEyASdVX3TYiCHC1PPxfR/T/EPNQkjOk97DYJKMVMwIxz69ZkHUxvyN/vbwdM
 HC0/od35jQXJe9ofi6AgS2jNxL0cPMYvMwk2kAJQ90ZufBZHNZLJdPtXXGHgv6fC//oTcjhCOke
 7W8SejnVA=
X-Google-Smtp-Source: AGHT+IHV2SZ7lm4LXfDfSO/Ib3irrD4NGfaMo48HKwjg5Q+1NA0YWXlUTmf2Egdz9XNIPKDNYpNcCM1iDCg3
X-Received: by 2002:a17:903:1b63:b0:269:a4ed:13c3 with SMTP id
 d9443c01a7336-27ed49df688mr245624275ad.5.1759192614333; 
 Mon, 29 Sep 2025 17:36:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-334736ccc86sm752985a91.7.2025.09.29.17.36.53
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:36:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b554fdd710bso3756041a12.3
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192612; x=1759797412; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LMtxASq1/1oBrjK86dsCK0T/No2f00bZhdcrisEv0Qk=;
 b=K0KtVdhW1q/6EoqIxetQgYvBkICh/804IcSVxehJvI5ixPmDuO+NixgT8UEItU62qB
 moEX2z0Vh/mhsfL8NGzd3I8sDxcnB8MpTpKiPfIxJjcYVard2a7LxMld7ruxhsHCE/ld
 M5sjLQIeXOFrZK3zr4+KeT6LBgSzPzGvMjT0k=
X-Received: by 2002:a05:6a21:998d:b0:2b0:ff55:f827 with SMTP id
 adf61e73a8af0-2e7c5935d2dmr21400126637.25.1759192611427; 
 Mon, 29 Sep 2025 17:36:51 -0700 (PDT)
X-Received: by 2002:a05:6a21:998d:b0:2b0:ff55:f827 with SMTP id
 adf61e73a8af0-2e7c5935d2dmr21400068637.25.1759192610422; 
 Mon, 29 Sep 2025 17:36:50 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.36.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:36:49 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH 15/54] net/bnxt/tf_ulp: add support for tcam priority update
Date: Mon, 29 Sep 2025 20:35:25 -0400
Message-Id: <20250930003604.87108-16-manish.kurup@broadcom.com>
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

As part of the hot upgrade feature, added supported for TCAM
entry's priority to be updated.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
---
 drivers/net/bnxt/hsi_struct_def_dpdk.h   | 541 ++++++++++++++++++++---
 drivers/net/bnxt/tf_core/v3/tfc.h        |  27 ++
 drivers/net/bnxt/tf_core/v3/tfc_msg.c    |  32 ++
 drivers/net/bnxt/tf_core/v3/tfc_msg.h    |   6 +
 drivers/net/bnxt/tf_ulp/bnxt_ulp.h       |   3 +
 drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h |   3 +-
 drivers/net/bnxt/tf_ulp/ulp_def_rules.c  |  29 ++
 drivers/net/bnxt/tf_ulp/ulp_gen_tbl.c    |  24 +
 drivers/net/bnxt/tf_ulp/ulp_gen_tbl.h    |  12 +
 drivers/net/bnxt/tf_ulp/ulp_mapper.c     |  68 ++-
 drivers/net/bnxt/tf_ulp/ulp_mapper.h     |   8 +-
 drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c  |   1 +
 drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c |  36 ++
 13 files changed, 729 insertions(+), 61 deletions(-)

diff --git a/drivers/net/bnxt/hsi_struct_def_dpdk.h b/drivers/net/bnxt/hsi_struct_def_dpdk.h
index 3a0c1fbdc2..de72e0e9e9 100644
--- a/drivers/net/bnxt/hsi_struct_def_dpdk.h
+++ b/drivers/net/bnxt/hsi_struct_def_dpdk.h
@@ -828,6 +828,18 @@ struct __rte_packed_begin cmd_nums {
 	#define HWRM_UDCC_COMP_QCFG                       UINT32_C(0x25f)
 	/* This command queries the status and statistics of the computation unit. */
 	#define HWRM_UDCC_COMP_QUERY                      UINT32_C(0x260)
+	/*
+	 * This command is used to query the pfc watchdog max configurable
+	 * timeout value.
+	 */
+	#define HWRM_QUEUE_PFCWD_TIMEOUT_QCAPS            UINT32_C(0x261)
+	/* This command is used to set the PFC watchdog timeout value. */
+	#define HWRM_QUEUE_PFCWD_TIMEOUT_CFG              UINT32_C(0x262)
+	/*
+	 * This command is used to query the current configured pfc watchdog
+	 * timeout value.
+	 */
+	#define HWRM_QUEUE_PFCWD_TIMEOUT_QCFG             UINT32_C(0x263)
 	/* Experimental */
 	#define HWRM_TF                                   UINT32_C(0x2bc)
 	/* Experimental */
@@ -950,18 +962,10 @@ struct __rte_packed_begin cmd_nums {
 	#define HWRM_TFC_TBL_SCOPE_CONFIG_GET             UINT32_C(0x39a)
 	/* TruFlow command to query the resource usage state. */
 	#define HWRM_TFC_RESC_USAGE_QUERY                 UINT32_C(0x39b)
-	/*
-	 * This command is used to query the pfc watchdog max configurable
-	 * timeout value.
-	 */
-	#define HWRM_QUEUE_PFCWD_TIMEOUT_QCAPS            UINT32_C(0x39c)
-	/* This command is used to set the PFC watchdog timeout value. */
-	#define HWRM_QUEUE_PFCWD_TIMEOUT_CFG              UINT32_C(0x39d)
-	/*
-	 * This command is used to query the current configured pfc watchdog
-	 * timeout value.
-	 */
-	#define HWRM_QUEUE_PFCWD_TIMEOUT_QCFG             UINT32_C(0x39e)
+	/* TruFlow command to free resources for a global id. */
+	#define HWRM_TFC_GLOBAL_ID_FREE                   UINT32_C(0x39c)
+	/* TruFlow command to update the priority of one tcam entry. */
+	#define HWRM_TFC_TCAM_PRI_UPDATE                  UINT32_C(0x39d)
 	/* Experimental */
 	#define HWRM_SV                                   UINT32_C(0x400)
 	/* Flush any trace buffer data that has not been sent to the host. */
@@ -1246,8 +1250,8 @@ struct __rte_packed_begin hwrm_err_output {
 #define HWRM_VERSION_MINOR 10
 #define HWRM_VERSION_UPDATE 3
 /* non-zero means beta version */
-#define HWRM_VERSION_RSVD 40
-#define HWRM_VERSION_STR "1.10.3.40"
+#define HWRM_VERSION_RSVD 86
+#define HWRM_VERSION_STR "1.10.3.86"
 
 /****************
  * hwrm_ver_get *
@@ -12667,29 +12671,94 @@ struct __rte_packed_begin hwrm_async_event_cmpl_dbg_buf_producer {
 		UINT32_C(0xffff)
 	#define HWRM_ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_SFT \
 		0
-	/* SRT trace. */
+	/* SRT or APE trace. */
 	#define HWRM_ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_SRT_TRACE \
 		UINT32_C(0x0)
-	/* SRT2 trace. */
+	/* SRT2 or AFM/Kong trace. */
 	#define HWRM_ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_SRT2_TRACE \
 		UINT32_C(0x1)
-	/* CRT trace. */
+	/* CRT or ChiMP trace. */
 	#define HWRM_ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_CRT_TRACE \
 		UINT32_C(0x2)
-	/* CRT2 trace. */
+	/* CRT2 or Bono trace. */
 	#define HWRM_ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_CRT2_TRACE \
 		UINT32_C(0x3)
 	/* RIGP0 trace. */
 	#define HWRM_ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_RIGP0_TRACE \
 		UINT32_C(0x4)
-	/* L2 HWRM trace. */
+	/* L2 or ChiMP HWRM trace. */
 	#define HWRM_ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_L2_HWRM_TRACE \
 		UINT32_C(0x5)
-	/* RoCE HWRM trace. */
+	/* RoCE or Bono HWRM trace. */
 	#define HWRM_ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_ROCE_HWRM_TRACE \
 		UINT32_C(0x6)
+	/* Context Accelerator CPU 0 trace. */
+	#define HWRM_ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_CA0_TRACE \
+		UINT32_C(0x7)
+	/* Context Accelerator CPU 1 trace. */
+	#define HWRM_ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_CA1_TRACE \
+		UINT32_C(0x8)
+	/* Context Accelerator CPU 2 trace. */
+	#define HWRM_ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_CA2_TRACE \
+		UINT32_C(0x9)
+	/* RIGP1 trace. */
+	#define HWRM_ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_RIGP1_TRACE \
+		UINT32_C(0xa)
+	/* AFM/Kong HWRM trace. */
+	#define HWRM_ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_AFM_KONG_HWRM_TRACE \
+		UINT32_C(0xb)
 	#define HWRM_ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_LAST \
-		HWRM_ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_ROCE_HWRM_TRACE
+		HWRM_ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_AFM_KONG_HWRM_TRACE
+} __rte_packed_end;
+
+/* hwrm_async_event_cmpl_peer_mmap_change (size:128b/16B) */
+struct __rte_packed_begin hwrm_async_event_cmpl_peer_mmap_change {
+	uint16_t	type;
+	/*
+	 * This field indicates the exact type of the completion.
+	 * By convention, the LSB identifies the length of the
+	 * record in 16B units. Even values indicate 16B
+	 * records. Odd values indicate 32B
+	 * records.
+	 */
+	#define HWRM_ASYNC_EVENT_CMPL_PEER_MMAP_CHANGE_TYPE_MASK \
+		UINT32_C(0x3f)
+	#define HWRM_ASYNC_EVENT_CMPL_PEER_MMAP_CHANGE_TYPE_SFT             0
+	/* HWRM Asynchronous Event Information */
+	#define HWRM_ASYNC_EVENT_CMPL_PEER_MMAP_CHANGE_TYPE_HWRM_ASYNC_EVENT \
+		UINT32_C(0x2e)
+	#define HWRM_ASYNC_EVENT_CMPL_PEER_MMAP_CHANGE_TYPE_LAST \
+		HWRM_ASYNC_EVENT_CMPL_PEER_MMAP_CHANGE_TYPE_HWRM_ASYNC_EVENT
+	/* Identifiers of events. */
+	uint16_t	event_id;
+	/*
+	 * This async notification message is used to inform the driver
+	 * that the memory mapping for a peer device is set. The driver
+	 * will need to query using get_structured_data.
+	 */
+	#define HWRM_ASYNC_EVENT_CMPL_PEER_MMAP_CHANGE_EVENT_ID_PEER_MMAP_CHANGE \
+		UINT32_C(0x4d)
+	#define HWRM_ASYNC_EVENT_CMPL_PEER_MMAP_CHANGE_EVENT_ID_LAST \
+		HWRM_ASYNC_EVENT_CMPL_PEER_MMAP_CHANGE_EVENT_ID_PEER_MMAP_CHANGE
+	/* Event specific data. */
+	uint32_t	event_data2;
+	uint8_t	opaque_v;
+	/*
+	 * This value is written by the NIC such that it will be different
+	 * for each pass through the completion queue. The even passes
+	 * will write 1. The odd passes will write 0.
+	 */
+	#define HWRM_ASYNC_EVENT_CMPL_PEER_MMAP_CHANGE_V          UINT32_C(0x1)
+	/* opaque is 7 b */
+	#define HWRM_ASYNC_EVENT_CMPL_PEER_MMAP_CHANGE_OPAQUE_MASK \
+		UINT32_C(0xfe)
+	#define HWRM_ASYNC_EVENT_CMPL_PEER_MMAP_CHANGE_OPAQUE_SFT 1
+	/* 8-lsb timestamp (100-msec resolution) */
+	uint8_t	timestamp_lo;
+	/* 16-lsb timestamp (100-msec resolution) */
+	uint16_t	timestamp_hi;
+	/* Event specific data */
+	uint32_t	event_data1;
 } __rte_packed_end;
 
 /* hwrm_async_event_cmpl_fw_trace_msg (size:128b/16B) */
@@ -14990,9 +15059,7 @@ struct __rte_packed_begin hwrm_func_qcaps_output {
 	/*
 	 * The maximum number of VFs that can be
 	 * allocated to the function. This is valid only on the
-	 * PF with SR-IOV enabled. 0xFF... (All Fs) if this
-	 * command is called on a PF with SR-IOV disabled or
-	 * on a VF.
+	 * PF with SR-IOV enabled.
 	 */
 	uint16_t	max_vfs;
 	/*
@@ -23717,27 +23784,45 @@ struct __rte_packed_begin hwrm_func_backing_store_cfg_v2_input {
 	/* XID partition context. */
 	#define HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_XID_PARTITION \
 		UINT32_C(0x1d)
-	/* SRT trace. */
+	/* SRT or APE trace. */
 	#define HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_SRT_TRACE \
 		UINT32_C(0x1e)
-	/* SRT2 trace. */
+	/* SRT2 or AFM/Kong trace. */
 	#define HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_SRT2_TRACE \
 		UINT32_C(0x1f)
-	/* CRT trace. */
+	/* CRT or ChiMP trace. */
 	#define HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_CRT_TRACE \
 		UINT32_C(0x20)
-	/* CRT2 trace. */
+	/* CRT2 or Bono trace. */
 	#define HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_CRT2_TRACE \
 		UINT32_C(0x21)
 	/* RIGP0 trace. */
 	#define HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_RIGP0_TRACE \
 		UINT32_C(0x22)
-	/* L2 HWRM trace. */
+	/* L2 or ChiMP HWRM trace. */
 	#define HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_L2_HWRM_TRACE \
 		UINT32_C(0x23)
-	/* RoCE HWRM trace. */
+	/* RoCE or Bono HWRM trace. */
 	#define HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_ROCE_HWRM_TRACE \
 		UINT32_C(0x24)
+	/* TimedTx pacing TQM ring. */
+	#define HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_TTX_PACING_TQM_RING \
+		UINT32_C(0x25)
+	/* Context Accelerator CPU 0 trace. */
+	#define HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_CA0_TRACE \
+		UINT32_C(0x26)
+	/* Context Accelerator CPU 1 trace. */
+	#define HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_CA1_TRACE \
+		UINT32_C(0x27)
+	/* Context Accelerator CPU 2 trace. */
+	#define HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_CA2_TRACE \
+		UINT32_C(0x28)
+	/* RIGP1 trace. */
+	#define HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_RIGP1_TRACE \
+		UINT32_C(0x29)
+	/* AFM/Kong HWRM trace. */
+	#define HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_AFM_KONG_HWRM_TRACE \
+		UINT32_C(0x2a)
 	/* Invalid type. */
 	#define HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_INVALID \
 		UINT32_C(0xffff)
@@ -23877,6 +23962,21 @@ struct __rte_packed_begin hwrm_func_backing_store_cfg_v2_input {
 	uint32_t	split_entry_2;
 	/* Split entry #3. */
 	uint32_t	split_entry_3;
+	uint32_t	enables;
+	/*
+	 * This bit must be '1' for the next_bs_offset field to be
+	 * configured.
+	 */
+	#define HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_ENABLES_NEXT_BS_OFFSET \
+		UINT32_C(0x1)
+	/*
+	 * This field specifies the next byte offset of the backing store
+	 * for the firmware to use. The driver can use this field to
+	 * direct the firmware to resume the logging-to-host from
+	 * the host buffer where the firmware was lastly written
+	 * before it restarts, e.g. due to an error recovery.
+	 */
+	uint32_t	next_bs_offset;
 } __rte_packed_end;
 
 /* hwrm_func_backing_store_cfg_v2_output (size:128b/16B) */
@@ -23992,27 +24092,45 @@ struct __rte_packed_begin hwrm_func_backing_store_qcfg_v2_input {
 	/* VF XID partition in-use table. */
 	#define HWRM_FUNC_BACKING_STORE_QCFG_V2_INPUT_TYPE_XID_PARTITION_TABLE \
 		UINT32_C(0x1d)
-	/* SRT trace. */
+	/* SRT or APE trace. */
 	#define HWRM_FUNC_BACKING_STORE_QCFG_V2_INPUT_TYPE_SRT_TRACE \
 		UINT32_C(0x1e)
-	/* SRT2 trace. */
+	/* SRT2 or AFM/Kong trace. */
 	#define HWRM_FUNC_BACKING_STORE_QCFG_V2_INPUT_TYPE_SRT2_TRACE \
 		UINT32_C(0x1f)
-	/* CRT trace. */
+	/* CRT or ChiMP trace. */
 	#define HWRM_FUNC_BACKING_STORE_QCFG_V2_INPUT_TYPE_CRT_TRACE \
 		UINT32_C(0x20)
-	/* CRT2 trace. */
+	/* CRT2 or Bono trace. */
 	#define HWRM_FUNC_BACKING_STORE_QCFG_V2_INPUT_TYPE_CRT2_TRACE \
 		UINT32_C(0x21)
 	/* RIGP0 trace. */
 	#define HWRM_FUNC_BACKING_STORE_QCFG_V2_INPUT_TYPE_RIGP0_TRACE \
 		UINT32_C(0x22)
-	/* L2 HWRM trace. */
+	/* L2 or ChiMP HWRM trace. */
 	#define HWRM_FUNC_BACKING_STORE_QCFG_V2_INPUT_TYPE_L2_HWRM_TRACE \
 		UINT32_C(0x23)
-	/* RoCE HWRM trace. */
+	/* RoCE or Bono HWRM trace. */
 	#define HWRM_FUNC_BACKING_STORE_QCFG_V2_INPUT_TYPE_ROCE_HWRM_TRACE \
 		UINT32_C(0x24)
+	/* TimedTx pacing TQM ring. */
+	#define HWRM_FUNC_BACKING_STORE_QCFG_V2_INPUT_TYPE_TTX_PACING_TQM_RING \
+		UINT32_C(0x25)
+	/* Context Accelerator CPU 0 trace. */
+	#define HWRM_FUNC_BACKING_STORE_QCFG_V2_INPUT_TYPE_CA0_TRACE \
+		UINT32_C(0x26)
+	/* Context Accelerator CPU 1 trace. */
+	#define HWRM_FUNC_BACKING_STORE_QCFG_V2_INPUT_TYPE_CA1_TRACE \
+		UINT32_C(0x27)
+	/* Context Accelerator CPU 2 trace. */
+	#define HWRM_FUNC_BACKING_STORE_QCFG_V2_INPUT_TYPE_CA2_TRACE \
+		UINT32_C(0x28)
+	/* RIGP1 trace. */
+	#define HWRM_FUNC_BACKING_STORE_QCFG_V2_INPUT_TYPE_RIGP1_TRACE \
+		UINT32_C(0x29)
+	/* AFM/Kong HWRM trace. */
+	#define HWRM_FUNC_BACKING_STORE_QCFG_V2_INPUT_TYPE_AFM_KONG_HWRM_TRACE \
+		UINT32_C(0x2a)
 	/* Invalid type. */
 	#define HWRM_FUNC_BACKING_STORE_QCFG_V2_INPUT_TYPE_INVALID \
 		UINT32_C(0xffff)
@@ -24436,27 +24554,45 @@ struct __rte_packed_begin hwrm_func_backing_store_qcaps_v2_input {
 	/* XID partition context. */
 	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_INPUT_TYPE_XID_PARTITION \
 		UINT32_C(0x1d)
-	/* SRT trace. */
+	/* SRT or APE trace. */
 	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_INPUT_TYPE_SRT_TRACE \
 		UINT32_C(0x1e)
-	/* SRT2 trace. */
+	/* SRT2 or AFM/Kong trace. */
 	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_INPUT_TYPE_SRT2_TRACE \
 		UINT32_C(0x1f)
-	/* CRT trace. */
+	/* CRT or ChiMP trace. */
 	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_INPUT_TYPE_CRT_TRACE \
 		UINT32_C(0x20)
-	/* CRT2 trace. */
+	/* CRT2 or Bono trace. */
 	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_INPUT_TYPE_CRT2_TRACE \
 		UINT32_C(0x21)
 	/* RIGP0 trace. */
 	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_INPUT_TYPE_RIGP0_TRACE \
 		UINT32_C(0x22)
-	/* L2 HWRM trace. */
+	/* L2 or ChiMP HWRM trace. */
 	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_INPUT_TYPE_L2_HWRM_TRACE \
 		UINT32_C(0x23)
-	/* RoCE HWRM trace. */
+	/* RoCE or Bono HWRM trace. */
 	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_INPUT_TYPE_ROCE_HWRM_TRACE \
 		UINT32_C(0x24)
+	/* TimedTx pacing TQM ring. */
+	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_INPUT_TYPE_TTX_PACING_TQM_RING \
+		UINT32_C(0x25)
+	/* Context Accelerator CPU 0 trace. */
+	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_INPUT_TYPE_CA0_TRACE \
+		UINT32_C(0x26)
+	/* Context Accelerator CPU 1 trace. */
+	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_INPUT_TYPE_CA1_TRACE \
+		UINT32_C(0x27)
+	/* Context Accelerator CPU 2 trace. */
+	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_INPUT_TYPE_CA2_TRACE \
+		UINT32_C(0x28)
+	/* RIGP1 trace. */
+	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_INPUT_TYPE_RIGP1_TRACE \
+		UINT32_C(0x29)
+	/* AFM/Kong HWRM trace. */
+	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_INPUT_TYPE_AFM_KONG_HWRM_TRACE \
+		UINT32_C(0x2a)
 	/* Invalid type. */
 	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_INPUT_TYPE_INVALID \
 		UINT32_C(0xffff)
@@ -24531,27 +24667,45 @@ struct __rte_packed_begin hwrm_func_backing_store_qcaps_v2_output {
 	/* XID partition context. */
 	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_OUTPUT_TYPE_XID_PARTITION \
 		UINT32_C(0x1d)
-	/* SRT trace. */
+	/* SRT or APE trace. */
 	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_OUTPUT_TYPE_SRT_TRACE \
 		UINT32_C(0x1e)
-	/* SRT2 trace. */
+	/* SRT2 or AFM/Kong trace. */
 	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_OUTPUT_TYPE_SRT2_TRACE \
 		UINT32_C(0x1f)
-	/* CRT trace. */
+	/* CRT or ChiMP trace. */
 	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_OUTPUT_TYPE_CRT_TRACE \
 		UINT32_C(0x20)
-	/* CRT2 trace. */
+	/* CRT2 or Bono trace. */
 	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_OUTPUT_TYPE_CRT2_TRACE \
 		UINT32_C(0x21)
 	/* RIGP0 trace. */
 	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_OUTPUT_TYPE_RIGP0_TRACE \
 		UINT32_C(0x22)
-	/* L2 HWRM trace. */
+	/* L2 or ChiMP HWRM trace. */
 	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_OUTPUT_TYPE_L2_HWRM_TRACE \
 		UINT32_C(0x23)
-	/* RoCE HWRM trace. */
+	/* RoCE or Bono HWRM trace. */
 	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_OUTPUT_TYPE_ROCE_HWRM_TRACE \
 		UINT32_C(0x24)
+	/* TimedTx pacing TQM ring. */
+	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_OUTPUT_TYPE_TTX_PACING_TQM_RING \
+		UINT32_C(0x25)
+	/* Context Accelerator CPU 0 trace. */
+	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_OUTPUT_TYPE_CA0_TRACE \
+		UINT32_C(0x26)
+	/* Context Accelerator CPU 1 trace. */
+	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_OUTPUT_TYPE_CA1_TRACE \
+		UINT32_C(0x27)
+	/* Context Accelerator CPU 2 trace. */
+	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_OUTPUT_TYPE_CA2_TRACE \
+		UINT32_C(0x28)
+	/* RIGP1 trace. */
+	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_OUTPUT_TYPE_RIGP1_TRACE \
+		UINT32_C(0x29)
+	/* AFM/Kong HWRM trace. */
+	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_OUTPUT_TYPE_AFM_KONG_HWRM_TRACE \
+		UINT32_C(0x2a)
 	/* Invalid type. */
 	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_OUTPUT_TYPE_INVALID \
 		UINT32_C(0xffff)
@@ -24595,6 +24749,26 @@ struct __rte_packed_begin hwrm_func_backing_store_qcaps_v2_output {
 	 */
 	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_OUTPUT_FLAGS_ROCE_QP_PSEUDO_STATIC_ALLOC \
 		UINT32_C(0x8)
+	/*
+	 * When set, it indicates the region for this type is not a regular
+	 * context memory but a memory for firmware text-based debug traces
+	 * which consist of ASCII characters.
+	 */
+	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_OUTPUT_FLAGS_FW_DBG_TRACE \
+		UINT32_C(0x10)
+	/*
+	 * When set, it indicates the region for this type is not a regular
+	 * context memory but a memory for firmware debug traces which
+	 * consist of binary data.
+	 */
+	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_OUTPUT_FLAGS_FW_BIN_DBG_TRACE \
+		UINT32_C(0x20)
+	/*
+	 * When set, it indicates the support of configuring
+	 * the next_bs_offset in hwrm_func_backing_store_cfg_v2.
+	 */
+	#define HWRM_FUNC_BACKING_STORE_QCAPS_V2_OUTPUT_FLAGS_NEXT_BS_OFFSET \
+		UINT32_C(0x40)
 	/*
 	 * Bit map of the valid instances associated with the
 	 * backing store type.
@@ -62274,6 +62448,114 @@ struct __rte_packed_begin hwrm_tfc_resc_usage_query_output {
 	uint8_t	valid;
 } __rte_packed_end;
 
+/****************************
+ * hwrm_tfc_tcam_pri_update *
+ ****************************/
+
+
+/* hwrm_tfc_tcam_pri_update_input (size:256b/32B) */
+struct hwrm_tfc_tcam_pri_update_input {
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
+	/* Logical TCAM ID. */
+	uint16_t	tcam_id;
+	/* Entry new priority. */
+	uint16_t	priority;
+	/* Control flags. */
+	uint8_t	flags;
+	/* Indicates the flow direction. */
+	#define HWRM_TFC_TCAM_PRI_UPDATE_INPUT_FLAGS_DIR     UINT32_C(0x1)
+	/* If this bit set to 0, then it indicates rx flow. */
+	#define HWRM_TFC_TCAM_PRI_UPDATE_INPUT_FLAGS_DIR_RX    UINT32_C(0x0)
+	/* If this bit is set to 1, then it indicates tx flow. */
+	#define HWRM_TFC_TCAM_PRI_UPDATE_INPUT_FLAGS_DIR_TX    UINT32_C(0x1)
+	#define HWRM_TFC_TCAM_PRI_UPDATE_INPUT_FLAGS_DIR_LAST \
+		HWRM_TFC_TCAM_PRI_UPDATE_INPUT_FLAGS_DIR_TX
+	/*
+	 * Subtype of TCAM resource. See
+	 * cfa_v3/include/cfa_resources.h.
+	 */
+	uint8_t	subtype;
+	/* Describes the type of tracking id to be used */
+	uint8_t	track_type;
+	/* Invalid track type */
+	#define HWRM_TFC_TCAM_PRI_UPDATE_INPUT_TRACK_TYPE_TRACK_TYPE_INVALID \
+		UINT32_C(0x0)
+	/* Tracked by session id */
+	#define HWRM_TFC_TCAM_PRI_UPDATE_INPUT_TRACK_TYPE_TRACK_TYPE_SID \
+		UINT32_C(0x1)
+	/* Tracked by function id */
+	#define HWRM_TFC_TCAM_PRI_UPDATE_INPUT_TRACK_TYPE_TRACK_TYPE_FID \
+		UINT32_C(0x2)
+	#define HWRM_TFC_TCAM_PRI_UPDATE_INPUT_TRACK_TYPE_LAST \
+		HWRM_TFC_TCAM_PRI_UPDATE_INPUT_TRACK_TYPE_TRACK_TYPE_FID
+	/* unused. */
+	uint8_t	unused0[5];
+} __rte_packed;
+
+/* hwrm_tfc_tcam_pri_update_output (size:128b/16B) */
+struct hwrm_tfc_tcam_pri_update_output {
+	/* The specific error status for the command. */
+	uint16_t	error_code;
+	/* The HWRM command request type. */
+	uint16_t	req_type;
+	/* The sequence ID from the original command. */
+	uint16_t	seq_id;
+	/* The length of the response data in number of bytes. */
+	uint16_t	resp_len;
+	/* unused. */
+	uint8_t	unused0[7];
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
@@ -63557,9 +63839,14 @@ struct __rte_packed_begin hwrm_pcie_qstats_input {
 	 */
 	uint64_t	resp_addr;
 	/*
-	 * The size of PCIe statistics block in bytes.
-	 * Firmware will DMA the PCIe statistics to
-	 * the host with this field size in the response.
+	 * This field specifies the size of the host buffer for the
+	 * statistics block. The actual size of the statistics block
+	 * returned by FW will depend on the chip. Older chips will
+	 * use the pcie_ctx_hw_stats structure and newer chips will
+	 * use the superset pcie_ctx_hw_stats_v2 structure. The actual
+	 * size of the data will be returned in the HWRM response and
+	 * it will be smaller than or equal to the size specified in
+	 * this field.
 	 */
 	uint16_t	pcie_stat_size;
 	uint8_t	unused_0[6];
@@ -63629,6 +63916,119 @@ struct __rte_packed_begin pcie_ctx_hw_stats {
 	uint64_t	pcie_recovery_histogram;
 } __rte_packed_end;
 
+/*
+ * Extended PCIe Statistics Format. This structure is a superset of
+ * pcie_ctx_hw_stats, i.e. the fields between the two structures are
+ * identical up to and including the pcie_recovery_histogram field.
+ */
+/* pcie_ctx_hw_stats_v2 (size:4096b/512B) */
+struct pcie_ctx_hw_stats_v2 {
+	/* Number of physical layer receiver errors */
+	uint64_t	pcie_pl_signal_integrity;
+	/* Number of DLLP CRC errors detected by Data Link Layer */
+	uint64_t	pcie_dl_signal_integrity;
+	/*
+	 * Number of TLP LCRC and sequence number errors detected
+	 * by Data Link Layer
+	 */
+	uint64_t	pcie_tl_signal_integrity;
+	/* Number of times LTSSM entered Recovery state */
+	uint64_t	pcie_link_integrity;
+	/* Report number of TLP bits that have been transmitted in Mbps */
+	uint64_t	pcie_tx_traffic_rate;
+	/* Report number of TLP bits that have been received in Mbps */
+	uint64_t	pcie_rx_traffic_rate;
+	/* Number of DLLP bytes that have been transmitted */
+	uint64_t	pcie_tx_dllp_statistics;
+	/* Number of DLLP bytes that have been received */
+	uint64_t	pcie_rx_dllp_statistics;
+	/*
+	 * Number of times spent in each phase of gen3
+	 * equalization
+	 */
+	uint64_t	pcie_equalization_time;
+	/* Records the last 16 transitions of the LTSSM */
+	uint32_t	pcie_ltssm_histogram[4];
+	/*
+	 * Record the last 8 reasons on why LTSSM transitioned
+	 * to Recovery
+	 */
+	uint64_t	pcie_recovery_histogram;
+	/* The TL credit histogram counter buckets for non-posted-headers. */
+	uint32_t	pcie_tl_credit_nph_histogram[8];
+	/* The TL credit histogram counter buckets for posted-headers. */
+	uint32_t	pcie_tl_credit_ph_histogram[8];
+	/* The TL credit histogram counter buckets for posted-data. */
+	uint32_t	pcie_tl_credit_pd_histogram[8];
+	/*
+	 * The most recently completed read request times (in microseconds)
+	 * for the 4 tags.
+	 */
+	uint32_t	pcie_cmpl_latest_times[4];
+	/* The longest read completion time (in microseconds). */
+	uint32_t	pcie_cmpl_longest_time;
+	/* The shortest read completion time (in microseconds). */
+	uint32_t	pcie_cmpl_shortest_time;
+	uint32_t	unused_0[2];
+	/*
+	 * This field represents an array of 4 most recent (in time) read
+	 * completion headers for tags 0 to 3. Each header consists of 4
+	 * words, in the following arrangement:
+	 * | Word | Contains                            |
+	 * | ---- | ------------------------------------|
+	 * |   0  | The header bits 0 to 31.            |
+	 * |   1  | The header bits 32 to 63.           |
+	 * |   2  | The header bits 64 to 95.           |
+	 * |   3  | Reserved.                           |
+	 */
+	uint32_t	pcie_cmpl_latest_headers[4][4];
+	/*
+	 * This field represents an array of 4 longest (in time) read
+	 * completion headers for tags 0 to 3. Each header consists of 4
+	 * words, in the following arrangement:
+	 * | Word | Contains                            |
+	 * | ---- | ------------------------------------|
+	 * |   0  | The header bits 0 to 31.            |
+	 * |   1  | The header bits 32 to 63.           |
+	 * |   2  | The header bits 64 to 95.           |
+	 * |   3  | Reserved.                           |
+	 */
+	uint32_t	pcie_cmpl_longest_headers[4][4];
+	/*
+	 * This field represents an array of 4 shortest (in time) read
+	 * completion headers for tags 0 to 3. Each header consists of 4
+	 * words, in the following arrangement:
+	 * | Word | Contains                            |
+	 * | ---- | ------------------------------------|
+	 * |   0  | The header bits 0 to 31.            |
+	 * |   1  | The header bits 32 to 63.           |
+	 * |   2  | The header bits 64 to 95.           |
+	 * |   3  | Reserved.                           |
+	 */
+	uint32_t	pcie_cmpl_shortest_headers[4][4];
+	/* The PCIe write latency histogram data counter values. */
+	uint32_t	pcie_wr_latency_histogram[12];
+	/*
+	 * The total count for all of the requests, less the ones in the
+	 * buckets.
+	 */
+	uint32_t	pcie_wr_latency_all_normal_count;
+	uint32_t	unused_1;
+	/* The count of posted packets sent to the PCI-e. */
+	uint64_t	pcie_posted_packet_count;
+	/* The count of non-posted packets sent to the PCI-e. */
+	uint64_t	pcie_non_posted_packet_count;
+	/*
+	 * The count of other packets (i.e. not posted or non-posted) sent to
+	 * the PCI-e.
+	 */
+	uint64_t	pcie_other_packet_count;
+	/* The count of blocked packets sent to the PCI-e. */
+	uint64_t	pcie_blocked_packet_count;
+	/* The count of completion packets sent to the PCI-e. */
+	uint64_t	pcie_cmpl_packet_count;
+} __rte_packed;
+
 /****************************
  * hwrm_stat_generic_qstats *
  ****************************/
@@ -64641,6 +65041,16 @@ struct __rte_packed_begin hwrm_nvm_write_input {
 	 */
 	#define HWRM_NVM_WRITE_INPUT_FLAGS_BATCH_LAST \
 		UINT32_C(0x4)
+	/*
+	 * This flag can only be used when NIC is running a fastboot image.
+	 * It has no effect when supplied to a non-fastboot image. Normally,
+	 * all signed binaries must have the same CRID as the CRID programmed
+	 * in the NIC SOTP. When the skip_crid_check flag is set, the CRID of
+	 * the signed binary being written to the NVM does not have to match
+	 * the CRID programmed in the SOTP of the NIC.
+	 */
+	#define HWRM_NVM_WRITE_INPUT_FLAGS_SKIP_CRID_CHECK \
+		UINT32_C(0x8)
 	/*
 	 * The requested length of the allocated NVM for the item, in bytes.
 	 * This value may be greater than or equal to the specified data
@@ -68388,29 +68798,44 @@ struct __rte_packed_begin hwrm_dbg_log_buffer_flush_input {
 	uint64_t	resp_addr;
 	/* Type of trace buffer to flush. */
 	uint16_t	type;
-	/* SRT trace. */
+	/* SRT or APE trace. */
 	#define HWRM_DBG_LOG_BUFFER_FLUSH_INPUT_TYPE_SRT_TRACE \
 		UINT32_C(0x0)
-	/* SRT2 trace. */
+	/* SRT2 or AFM/Kong trace. */
 	#define HWRM_DBG_LOG_BUFFER_FLUSH_INPUT_TYPE_SRT2_TRACE \
 		UINT32_C(0x1)
-	/* CRT trace. */
+	/* CRT or ChiMP trace. */
 	#define HWRM_DBG_LOG_BUFFER_FLUSH_INPUT_TYPE_CRT_TRACE \
 		UINT32_C(0x2)
-	/* CRT2 trace. */
+	/* CRT2 or Bono trace. */
 	#define HWRM_DBG_LOG_BUFFER_FLUSH_INPUT_TYPE_CRT2_TRACE \
 		UINT32_C(0x3)
 	/* RIGP0 trace. */
 	#define HWRM_DBG_LOG_BUFFER_FLUSH_INPUT_TYPE_RIGP0_TRACE \
 		UINT32_C(0x4)
-	/* L2 HWRM trace. */
+	/* L2 or ChiMP HWRM trace. */
 	#define HWRM_DBG_LOG_BUFFER_FLUSH_INPUT_TYPE_L2_HWRM_TRACE \
 		UINT32_C(0x5)
-	/* RoCE HWRM trace. */
+	/* RoCE or Bono HWRM trace. */
 	#define HWRM_DBG_LOG_BUFFER_FLUSH_INPUT_TYPE_ROCE_HWRM_TRACE \
 		UINT32_C(0x6)
+	/* Context Accelerator CPU 0 trace. */
+	#define HWRM_DBG_LOG_BUFFER_FLUSH_INPUT_TYPE_CA0_TRACE \
+		UINT32_C(0x7)
+	/* Context Accelerator CPU 1 trace. */
+	#define HWRM_DBG_LOG_BUFFER_FLUSH_INPUT_TYPE_CA1_TRACE \
+		UINT32_C(0x8)
+	/* Context Accelerator CPU 2 trace. */
+	#define HWRM_DBG_LOG_BUFFER_FLUSH_INPUT_TYPE_CA2_TRACE \
+		UINT32_C(0x9)
+	/* RIGP1 trace. */
+	#define HWRM_DBG_LOG_BUFFER_FLUSH_INPUT_TYPE_RIGP1_TRACE \
+		UINT32_C(0xa)
+	/* AFM/Kong HWRM trace. */
+	#define HWRM_DBG_LOG_BUFFER_FLUSH_INPUT_TYPE_AFM_KONG_HWRM_TRACE \
+		UINT32_C(0xb)
 	#define HWRM_DBG_LOG_BUFFER_FLUSH_INPUT_TYPE_LAST \
-		HWRM_DBG_LOG_BUFFER_FLUSH_INPUT_TYPE_ROCE_HWRM_TRACE
+		HWRM_DBG_LOG_BUFFER_FLUSH_INPUT_TYPE_AFM_KONG_HWRM_TRACE
 	uint8_t	unused_1[2];
 	/* Control flags. */
 	uint32_t	flags;
diff --git a/drivers/net/bnxt/tf_core/v3/tfc.h b/drivers/net/bnxt/tf_core/v3/tfc.h
index cb4dc5558a..80a5c64c17 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc.h
+++ b/drivers/net/bnxt/tf_core/v3/tfc.h
@@ -681,6 +681,33 @@ int tfc_tcam_get(struct tfc *tfcp, uint16_t fid,
 int tfc_tcam_free(struct tfc *tfcp, uint16_t fid,
 		  const struct tfc_tcam_info *tcam_info);
 
+/**
+ * Update the TFC TCAM entry priority
+ *
+ * @param[in] tfcp
+ *   Pointer to TFC handle
+ *
+ * @param[in] fid
+ *   FID - Function ID to be used
+ *
+ * @param[in] tt
+ *   Track type - either track by session or by function
+ *
+ * @param[in] tcam_info
+ *   All the information related to the requested index table entry (subtype/dir)
+ *   including the id.
+ *
+ * @param[in] priority
+ *  The priority of the tcam entry to be updated with.
+ *
+ * @returns
+ *   0 for SUCCESS, negative error value for FAILURE (errno.h)
+ */
+int tfc_tcam_priority_update(struct tfc *tfcp, uint16_t fid,
+			     enum cfa_track_type tt,
+			     const struct tfc_tcam_info *tcam_info,
+			     uint16_t priority);
+
 /**
  * @page TBM Table Scope
  *
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_msg.c b/drivers/net/bnxt/tf_core/v3/tfc_msg.c
index fb007a66f6..0a636a1677 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_msg.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_msg.c
@@ -1183,6 +1183,38 @@ tfc_msg_tcam_free(struct tfc *tfcp, uint16_t fid, uint16_t sid,
 	return rc;
 }
 
+int
+tfc_msg_tcam_prioriry_update(struct tfc *tfcp, uint16_t fid, uint16_t sid,
+			     enum cfa_dir dir, enum cfa_track_type tt,
+			     enum cfa_resource_subtype_tcam subtype,
+			     uint16_t tcam_id, uint16_t priority)
+{
+	int rc = 0;
+	struct bnxt *bp = tfcp->bp;
+	struct hwrm_tfc_tcam_pri_update_input req = { 0 };
+	struct hwrm_tfc_tcam_pri_update_output resp = { 0 };
+
+	req.flags = (dir == CFA_DIR_TX ?
+		     HWRM_TFC_TCAM_SET_INPUT_FLAGS_DIR_TX :
+		     HWRM_TFC_TCAM_SET_INPUT_FLAGS_DIR_RX);
+
+	rc = tfc_msg_set_fid(bp, fid, &req.fid);
+	if (rc)
+		return rc;
+	req.sid = rte_le_to_cpu_16(sid);
+	req.tcam_id = rte_le_to_cpu_16(tcam_id);
+	req.subtype = (uint8_t)subtype;
+	req.priority = rte_le_to_cpu_16(priority);
+	req.track_type = (tt == CFA_TRACK_TYPE_FID ?
+			  HWRM_TFC_TCAM_PRI_UPDATE_INPUT_TRACK_TYPE_TRACK_TYPE_FID :
+			  HWRM_TFC_TCAM_PRI_UPDATE_INPUT_TRACK_TYPE_TRACK_TYPE_SID);
+
+	rc = bnxt_hwrm_tf_message_direct(bp, false, HWRM_TFC_TCAM_PRI_UPDATE,
+					 &req, sizeof(req), &resp,
+					 sizeof(resp));
+	return rc;
+}
+
 int
 tfc_msg_if_tbl_set(struct tfc *tfcp, uint16_t fid, uint16_t sid,
 		   enum cfa_dir dir, enum cfa_resource_subtype_if_tbl subtype,
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_msg.h b/drivers/net/bnxt/tf_core/v3/tfc_msg.h
index a03452f00a..2d1a6816c0 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_msg.h
+++ b/drivers/net/bnxt/tf_core/v3/tfc_msg.h
@@ -154,6 +154,12 @@ tfc_msg_tcam_free(struct tfc *tfcp, uint16_t fid, uint16_t sid,
 		 enum cfa_dir dir, enum cfa_resource_subtype_tcam subtype,
 		 uint16_t tcam_id);
 
+int
+tfc_msg_tcam_prioriry_update(struct tfc *tfcp, uint16_t fid, uint16_t sid,
+			     enum cfa_dir dir, enum cfa_track_type tt,
+			     enum cfa_resource_subtype_tcam subtype,
+			     uint16_t tcam_id, uint16_t priority);
+
 int
 tfc_msg_if_tbl_set(struct tfc *tfcp, uint16_t fid, uint16_t sid,
 		   enum cfa_dir dir, enum cfa_resource_subtype_if_tbl subtype,
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp.h b/drivers/net/bnxt/tf_ulp/bnxt_ulp.h
index e0e31532fd..3a2745d405 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp.h
@@ -327,4 +327,7 @@ bnxt_ulp_grp_miss_act_set(struct rte_eth_dev *dev,
 			  const struct rte_flow_action actions[],
 			  uint32_t *flow_id);
 
+int32_t
+bnxt_ulp_hot_upgrade_process(struct bnxt *bp);
+
 #endif /* _BNXT_ULP_H_ */
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
index 08934eac3f..2cea9e5692 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
@@ -1091,7 +1091,8 @@ bnxt_ulp_cap_feat_process(uint64_t feat_bits, uint64_t *out_bits)
 		BNXT_DRV_DBG(ERR, "Multi Instance Feature is enabled\n");
 	if (bit & BNXT_ULP_FEATURE_BIT_SPECIAL_VXLAN)
 		BNXT_DRV_DBG(ERR, "Special VXLAN Feature is enabled\n");
-
+	if (bit & BNXT_ULP_FEATURE_BIT_HOT_UPGRADE)
+		BNXT_DRV_DBG(ERR, "Hot Upgrade Feature is enabled\n");
 
 	*out_bits =  bit;
 	return 0;
diff --git a/drivers/net/bnxt/tf_ulp/ulp_def_rules.c b/drivers/net/bnxt/tf_ulp/ulp_def_rules.c
index b7a893a04f..30cd944362 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_def_rules.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_def_rules.c
@@ -993,3 +993,32 @@ bnxt_ulp_grp_miss_act_set(struct rte_eth_dev *dev,
 flow_error:
 	return ret;
 }
+
+int32_t
+bnxt_ulp_hot_upgrade_process(struct bnxt *bp)
+{
+	uint32_t flow_type = BNXT_ULP_TEMPLATE_HOT_UPGRADE;
+	uint16_t port_id = bp->eth_dev->data->port_id;
+	struct ulp_tlv_param param_list[] = {
+		{
+			.type = BNXT_ULP_DF_PARAM_TYPE_DEV_PORT_ID,
+			.length = 2,
+			.value = {(port_id >> 8) & 0xff, port_id & 0xff}
+		},
+		{
+			.type = BNXT_ULP_DF_PARAM_TYPE_LAST,
+			.length = 0,
+			.value = {0}
+		}
+	};
+
+	if (!BNXT_CHIP_P7(bp))
+		return -EPERM;
+
+	if (ulp_flow_template_process(bp, param_list, flow_type,
+				      port_id, 0))
+		return -EIO;
+
+	BNXT_DRV_DBG(DEBUG, "Hot upgrade operation performed\n");
+	return 0;
+}
diff --git a/drivers/net/bnxt/tf_ulp/ulp_gen_tbl.c b/drivers/net/bnxt/tf_ulp/ulp_gen_tbl.c
index c2ae3dc3a2..ac0a7e6db1 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_gen_tbl.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_gen_tbl.c
@@ -626,3 +626,27 @@ ulp_gen_tbl_simple_list_search(struct ulp_mapper_gen_tbl_list *tbl_list,
 	}
 	return rc;
 }
+
+uint32_t
+ulp_gen_tbl_simple_list_get_next(struct ulp_mapper_gen_tbl_list *tbl_list,
+				 uint32_t *key_idx)
+{
+	struct ulp_mapper_gen_tbl_cont *cont = &tbl_list->container;
+	enum ulp_gen_list_search_flag rc = ULP_GEN_LIST_SEARCH_FULL;
+	struct ulp_mapper_gen_tbl_entry ent = { 0 };
+	uint32_t idx = *key_idx;
+
+	/* Check the given idx is a valid entry, if not get next one */
+	while (idx < cont->num_elem) {
+		ent.ref_count = &cont->ref_count[idx];
+		/* check ref count not zero and exact key matches */
+		if (ULP_GEN_TBL_REF_CNT(&ent)) {
+			/* found the entry return */
+			rc = ULP_GEN_LIST_SEARCH_FOUND;
+			*key_idx = idx;
+			break;
+		}
+		idx++;
+	}
+	return rc;
+}
diff --git a/drivers/net/bnxt/tf_ulp/ulp_gen_tbl.h b/drivers/net/bnxt/tf_ulp/ulp_gen_tbl.h
index 2a6454bf9c..e88fd78acc 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_gen_tbl.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_gen_tbl.h
@@ -219,4 +219,16 @@ uint32_t
 ulp_gen_tbl_simple_list_search(struct ulp_mapper_gen_tbl_list *tbl_list,
 			       uint8_t *match_key,
 			       uint32_t *key_idx);
+
+/*
+ * Perform simple list iteration
+ *
+ * tbl_list [in] - pointer to the generic table list
+ * key_idx [in/out] - returns key index .
+ *
+ * returns 2 on success.
+ */
+uint32_t
+ulp_gen_tbl_simple_list_get_next(struct ulp_mapper_gen_tbl_list *tbl_list,
+				 uint32_t *key_idx);
 #endif /* _ULP_EN_TBL_H_ */
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper.c b/drivers/net/bnxt/tf_ulp/ulp_mapper.c
index d545bd2fda..c463bce3d4 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper.c
@@ -2619,6 +2619,7 @@ ulp_mapper_gen_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 	uint32_t i, num_kflds = 0, key_index = 0, num_par_kflds = 0, pad = 0;
 	uint32_t gen_tbl_miss = 1, fdb_write = 0;
 	uint8_t *byte_data;
+	uint64_t regval = 0;
 	int32_t rc = 0;
 
 	/* Get the key fields list and build the key. */
@@ -2725,7 +2726,9 @@ ulp_mapper_gen_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 							  &gen_tbl_ent)))
 			return -EINVAL;
 	} else if (gen_tbl_list->tbl_type ==
-		   BNXT_ULP_GEN_TBL_TYPE_SIMPLE_LIST) {
+		   BNXT_ULP_GEN_TBL_TYPE_SIMPLE_LIST &&
+		   tbl->tbl_opcode !=
+		   BNXT_ULP_GENERIC_TBL_OPC_ITERATE) {
 		list_srch = ulp_gen_tbl_simple_list_search(gen_tbl_list,
 							   cache_key,
 							   &key_index);
@@ -2826,6 +2829,53 @@ ulp_mapper_gen_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 		fdb_write = 1;
 		parms->shared_hndl = (uint64_t)tbl_idx << 32 | key_index;
 		break;
+	case BNXT_ULP_GENERIC_TBL_OPC_ITERATE:
+		if (gen_tbl_list->tbl_type !=
+		    BNXT_ULP_GEN_TBL_TYPE_SIMPLE_LIST) {
+			BNXT_DRV_DBG(ERR, "%s: Invalid table opcode\n",
+				     gen_tbl_list->gen_tbl_name);
+			return -EINVAL;
+		}
+		/* read the gen table index */
+		if (unlikely(ulp_regfile_read(parms->regfile,
+					      tbl->tbl_operand,
+					      &regval))) {
+			BNXT_DRV_DBG(ERR,
+				     "Fail to get tbl idx from regfile[%d].\n",
+				     BNXT_ULP_RF_IDX_GENERIC_TBL_INDEX);
+			return -EINVAL;
+		}
+		key_index = (uint32_t)rte_be_to_cpu_64(regval);
+		/* get the next index from the simple list table */
+		rc = ulp_gen_tbl_simple_list_get_next(gen_tbl_list, &key_index);
+		if (rc == ULP_GEN_LIST_SEARCH_FOUND) {
+			gen_tbl_miss = 0; /* entry exits */
+			regval = key_index;
+			(void)ulp_regfile_write(parms->regfile,
+						tbl->tbl_operand,
+						tfp_cpu_to_be_64(regval));
+			g = &gen_tbl_ent;
+			rc = ulp_mapper_gen_tbl_entry_get(gen_tbl_list,
+							  key_index,
+							  &gen_tbl_ent);
+			if (rc)
+				return rc;
+
+			/* scan the result list and update the regfile values */
+			rc = ulp_mapper_tbl_ident_scan_ext(parms, tbl,
+							   g->byte_data,
+							   g->byte_data_size,
+							   g->byte_order);
+			if (unlikely(rc)) {
+				BNXT_DRV_DBG(ERR, "Fail to scan ident list\n");
+				return rc;
+			}
+
+		} else {
+			gen_tbl_miss = 1; /* no more entries */
+		}
+		fdb_write = 0;
+		break;
 	default:
 		BNXT_DRV_DBG(ERR, "Invalid table opcode %x\n", tbl->tbl_opcode);
 		return -EINVAL;
@@ -3726,12 +3776,15 @@ ulp_mapper_func_info_process(struct bnxt_ulp_mapper_parms *parms,
 	case BNXT_ULP_FUNC_OPC_HANDLE_TO_OFFSET:
 	case BNXT_ULP_FUNC_OPC_VFR_MARK_SET:
 	case BNXT_ULP_FUNC_OPC_BD_ACT_SET:
+	case BNXT_ULP_FUNC_OPC_MTR_ID_TO_STATS_HANDLE:
+	case BNXT_ULP_FUNC_OPC_TCAM_SET_PRIORITY:
 		process_src1 = 1;
 		process_src2 = 1;
 		break;
 	case BNXT_ULP_FUNC_OPC_NOT_NOT:
 		process_src1 = 1;
 	case BNXT_ULP_FUNC_OPC_COND_LIST:
+	case BNXT_ULP_FUNC_OPC_APP_PRIORITY:
 		break;
 	case BNXT_ULP_FUNC_OPC_PORT_TABLE:
 		process_src1 = 1;
@@ -3854,6 +3907,19 @@ ulp_mapper_func_info_process(struct bnxt_ulp_mapper_parms *parms,
 						    (uint8_t *)&res2,
 						    func_info->func_oper_size);
 		return rc;
+	case BNXT_ULP_FUNC_OPC_MTR_ID_TO_STATS_HANDLE:
+		/* res1 is mtr_id, res2 is stats_id */
+		return op->ulp_mapper_mtr_stats_hndl_set(parms, res1, res2);
+	case BNXT_ULP_FUNC_OPC_APP_PRIORITY:
+		res = parms->app_priority;
+		break;
+	case BNXT_ULP_FUNC_OPC_TCAM_SET_PRIORITY:
+		return op->ulp_mapper_core_tcam_prio_update(parms,
+							    tbl->direction,
+							    tbl->track_type,
+							    CFA_RSUBTYPE_TCAM_WC,
+							    (uint32_t)res1,
+							    (uint16_t)res2);
 	default:
 		BNXT_DRV_DBG(ERR, "invalid func code %u\n",
 			     func_info->func_opc);
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper.h b/drivers/net/bnxt/tf_ulp/ulp_mapper.h
index 79052664dd..a4a42ab84d 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper.h
@@ -103,6 +103,13 @@ struct ulp_mapper_core_ops {
 	(*ulp_mapper_core_tcam_entry_free)(struct bnxt_ulp_context *ulp_ctx,
 					   struct ulp_flow_db_res_params *res);
 	int32_t
+	(*ulp_mapper_core_tcam_prio_update)(struct bnxt_ulp_mapper_parms *parms,
+					    uint8_t dir,
+					    enum cfa_track_type tt,
+					    enum cfa_resource_subtype_tcam type,
+					    uint32_t tcam_id,
+					    uint16_t priority);
+	int32_t
 	(*ulp_mapper_core_em_tbl_process)(struct bnxt_ulp_mapper_parms *parms,
 					  struct bnxt_ulp_mapper_tbl_info *t,
 					  void *error);
@@ -110,7 +117,6 @@ struct ulp_mapper_core_ops {
 	(*ulp_mapper_core_em_entry_free)(struct bnxt_ulp_context *ulp,
 					 struct ulp_flow_db_res_params *res,
 					 void *error);
-
 	int32_t
 	(*ulp_mapper_core_index_tbl_process)(struct bnxt_ulp_mapper_parms *parm,
 					     struct bnxt_ulp_mapper_tbl_info
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c b/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c
index e548a6b91f..72d0f96573 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c
@@ -1368,6 +1368,7 @@ ulp_mapper_tf_mpc_batch_started(struct tfc_mpc_batch_info_t *batch_info __rte_un
 const struct ulp_mapper_core_ops ulp_mapper_tf_core_ops = {
 	.ulp_mapper_core_tcam_tbl_process = ulp_mapper_tf_tcam_tbl_process,
 	.ulp_mapper_core_tcam_entry_free = ulp_mapper_tf_tcam_entry_free,
+	.ulp_mapper_core_tcam_prio_update = NULL,
 	.ulp_mapper_core_em_tbl_process = ulp_mapper_tf_em_tbl_process,
 	.ulp_mapper_core_em_entry_free = ulp_mapper_tf_em_entry_free,
 	.ulp_mapper_core_index_tbl_process = ulp_mapper_tf_index_tbl_process,
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
index d4c03a2d74..046d2c5cf9 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
@@ -1911,11 +1911,47 @@ ulp_mapper_tfc_mtr_stats_hndl_del(uint32_t mtr_id)
 		}
 
 	return rc;
+
+static inline int32_t
+ulp_mapper_tfc_tcam_prio_update(struct bnxt_ulp_mapper_parms *parms,
+				uint8_t dir,
+				enum cfa_track_type tt,
+				enum cfa_resource_subtype_tcam rtype,
+				uint32_t tcam_id,
+				uint16_t priority)
+{
+	struct tfc *tfcp = NULL;
+	struct tfc_tcam_info tcam_info = { 0 };
+	uint16_t fw_fid = 0;
+
+	if (unlikely(bnxt_ulp_cntxt_fid_get(parms->ulp_ctx, &fw_fid))) {
+		BNXT_DRV_DBG(ERR, "Failed to get func_id\n");
+		return -EINVAL;
+	}
+
+	tfcp = bnxt_ulp_cntxt_tfcp_get(parms->ulp_ctx);
+	if (unlikely(tfcp == NULL)) {
+		PMD_DRV_LOG_LINE(ERR, "Failed to get tfcp pointer");
+		return -EINVAL;
+	}
+	tcam_info.dir = (enum cfa_dir)dir;
+	tcam_info.rsubtype = rtype;
+	tcam_info.id = (uint16_t)tcam_id;
+
+	if (unlikely(!tfcp || tfc_tcam_priority_update(tfcp, fw_fid, tt,
+						       &tcam_info,
+						       priority))) {
+		BNXT_DRV_DBG(ERR, "Unable to update tcam priority %u\n",
+			     tcam_info.id);
+		return -EINVAL;
+	}
+	return 0;
 }
 
 const struct ulp_mapper_core_ops ulp_mapper_tfc_core_ops = {
 	.ulp_mapper_core_tcam_tbl_process = ulp_mapper_tfc_tcam_tbl_process,
 	.ulp_mapper_core_tcam_entry_free = ulp_mapper_tfc_tcam_entry_free,
+	.ulp_mapper_core_tcam_prio_update = ulp_mapper_tfc_tcam_prio_update,
 	.ulp_mapper_core_em_tbl_process = ulp_mapper_tfc_em_tbl_process,
 	.ulp_mapper_core_em_entry_free = ulp_mapper_tfc_em_entry_free,
 	.ulp_mapper_core_index_tbl_process = ulp_mapper_tfc_index_tbl_process,
-- 
2.39.5 (Apple Git-154)

