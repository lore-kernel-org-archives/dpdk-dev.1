Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C8ACAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:06:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 395B040B94;
	Tue, 30 Sep 2025 09:05:17 +0200 (CEST)
Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com
 [209.85.217.100])
 by mails.dpdk.org (Postfix) with ESMTP id B8BE8402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:36:42 +0200 (CEST)
Received: by mail-vs1-f100.google.com with SMTP id
 ada2fe7eead31-5b62ab6687dso3951047137.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192602; x=1759797402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p7IzjS1s0bNef64GLMBRSJvVqao76Vm81Z7YtWhUduU=;
 b=hPpsBnpBlS8J/tYF1FO6iwytWOL/NYUKbWpy0P/KolTMfqLo3RJDnvk/A8mpt7Dend
 ajl49ev0z1wTbYF333v1YDEnOlcD6OJ1oV+OFdeIsWstMFctRCp6natSRoox6xz0uZLz
 /twPyR7YcTREn+8cxxRTT4IAiiOrIXHg3yoTTBhIVb/jJR5G+3CkZxY9GTVNoECnnQrK
 XVnDM6Hz/7JriLJw32f4dWLgg56lpI0BfmJVWJwJYlcFz/ldyK2Fsz1mawbBTPaxVatK
 ieBj/siLJYvfSe3c0ZvtQSJpDYyfL9vzwRLthxUwyGrL+0uv6Bv18TdNnLp23j8FMCQH
 lD+w==
X-Gm-Message-State: AOJu0Yxl6LRKhPz0w1AjxTRmvQGSq2WDBZAB9HEo3+0RpTiN5Rgm3ZH+
 YDVEOsMD14NGPkcYMB3SDdKy49Wy1tEZb/FI8OPpcKok7uAVTuAI0DPxrcL72q7D0tLGXCj4i/K
 5FDWq/tcoAxLPESWpx5JgyBab+XSzbACR60ig7nht4Rc0xCX4NnACWRgrmFXnZTEp1vkPg2nsXv
 /XALNmcrlKFY1mOZnQxOBL0TN6EjfGnLJ21VKzpx7YAXHGoUofkI++/2fIMpIzBJOBb14D3Q==
X-Gm-Gg: ASbGncs1gzWq72PZSrCjS7EBq2+1pinJbZJu7VhKAMZUFFahqYFMI45sJWJHubtq/jp
 mtqfIg204RjuNcv2v82+9ADoyV6FK3nCW7TErXnsxUJ7oPlnXMCzcRUxv1WwQ6ju8bpxE7iP0bk
 tbgcUA21qFyRrM3vksQYx+KRoQqwg06ExXV8nMghYnF637rVlybKPab+8NCqfs3sqFefKcpscq6
 wSn2Zw06wH/BMtBBckfLDKH8IqptcGBxKOtpIDBOa7DB4+RiOdP7iU7nENX1yxsqVh8mvecPtZi
 JhWMb+E6jZWBEVar7WdP24gxhwMrck7APKj51UQ4nmHAOlokLx5CVmC6dzOTK6uBKGeTJy/cZRB
 sowQKWOKvFJnNB3359xGZknBtJNY047ounbHlJt3EUjZf10FiV+iGxkOS1M4KwxvFhv8tqZOPP6
 F5EOenS/M=
X-Google-Smtp-Source: AGHT+IEXBTV3GQkd7vPhQ1vWnfrQd6u/w+PJSoyF8Pd0+thRpmB4yNTCioXBGJMJSU2qqmDCXwLXEidsRPjo
X-Received: by 2002:a05:6102:390d:b0:523:e010:df0f with SMTP id
 ada2fe7eead31-5acb88f5cbamr8243905137.0.1759192602008; 
 Mon, 29 Sep 2025 17:36:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
 by smtp-relay.gmail.com with ESMTPS id
 ada2fe7eead31-5b153e6996esm1041189137.2.2025.09.29.17.36.41
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:36:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-330a4d5c4efso4922088a91.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192600; x=1759797400; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p7IzjS1s0bNef64GLMBRSJvVqao76Vm81Z7YtWhUduU=;
 b=Jaj5uf+ZSM817ANgor2WXU3QCXPmccEGVIr60kErSnwtM51JpghG6ZzxXfAfPBpVUm
 sRm8OYkTpjWYgs3RsE+n67hE5y27r01g17/59eNWWviPF9XmBOyxvb3h4+Qozp/SsGBi
 XTSUGwl2AAcNAOJxcTpOACsgHnHxQhEMApxtM=
X-Received: by 2002:a17:90b:3882:b0:32e:1b1c:f8b8 with SMTP id
 98e67ed59e1d1-3342a2d2459mr20337429a91.26.1759192599689; 
 Mon, 29 Sep 2025 17:36:39 -0700 (PDT)
X-Received: by 2002:a17:90b:3882:b0:32e:1b1c:f8b8 with SMTP id
 98e67ed59e1d1-3342a2d2459mr20337401a91.26.1759192598938; 
 Mon, 29 Sep 2025 17:36:38 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.36.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:36:38 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Michael Baucom <michael.baucom@broadcom.com>
Subject: [PATCH 08/54] net/bnxt/tf_ulp: add support for global identifiers
Date: Mon, 29 Sep 2025 20:35:18 -0400
Message-Id: <20250930003604.87108-9-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:06 +0200
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

Added support in the mapper to enable global identifier
allocations.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Michael Baucom <michael.baucom@broadcom.com>
---
 drivers/net/bnxt/hsi_struct_def_dpdk.h      | 164 ++++++++++++++------
 drivers/net/bnxt/tf_core/v3/tfc_global_id.c |  42 ++++-
 drivers/net/bnxt/tf_core/v3/tfc_tcam.c      |  55 +++++++
 drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h    |   2 +
 drivers/net/bnxt/tf_ulp/ulp_mapper.c        |  89 +++++++++--
 drivers/net/bnxt/tf_ulp/ulp_mapper.h        |  11 ++
 drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c     |   2 +
 drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c    |  64 ++++++++
 8 files changed, 370 insertions(+), 59 deletions(-)

diff --git a/drivers/net/bnxt/hsi_struct_def_dpdk.h b/drivers/net/bnxt/hsi_struct_def_dpdk.h
index f089813a68..3a0c1fbdc2 100644
--- a/drivers/net/bnxt/hsi_struct_def_dpdk.h
+++ b/drivers/net/bnxt/hsi_struct_def_dpdk.h
@@ -61178,32 +61178,6 @@ struct __rte_packed_begin hwrm_tfc_idx_tbl_free_output {
 	uint8_t	valid;
 } __rte_packed_end;
 
-/* TruFlow resources request for a global id. */
-/* tfc_global_id_hwrm_req (size:64b/8B) */
-struct __rte_packed_begin tfc_global_id_hwrm_req {
-	/* Type of the resource, defined in enum cfa_resource_type HCAPI RM. */
-	uint16_t	rtype;
-	/* Indicates the flow direction in type of cfa_dir. */
-	uint16_t	dir;
-	/* Subtype of the resource type. */
-	uint16_t	subtype;
-	/* Number of the type of resources. */
-	uint16_t	cnt;
-} __rte_packed_end;
-
-/* The reserved resources for the global id. */
-/* tfc_global_id_hwrm_rsp (size:64b/8B) */
-struct __rte_packed_begin tfc_global_id_hwrm_rsp {
-	/* Type of the resource, defined in enum cfa_resource_type HCAPI RM. */
-	uint16_t	rtype;
-	/* Indicates the flow direction in type of cfa_dir. */
-	uint16_t	dir;
-	/* Subtype of the resource type. */
-	uint16_t	subtype;
-	/* The global id that the resources reserved for. */
-	uint16_t	id;
-} __rte_packed_end;
-
 /****************************
  * hwrm_tfc_global_id_alloc *
  ****************************/
@@ -61248,30 +61222,36 @@ struct __rte_packed_begin hwrm_tfc_global_id_alloc_input {
 	 * field.
 	 */
 	uint16_t	fid;
-	/* Firmware session id returned when HWRM_TF_SESSION_OPEN is sent. */
+	/*
+	 * Session associated with function requesting the global identifier
+	 * resource.
+	 */
 	uint16_t	sid;
-	/* Global domain id. */
-	uint16_t	global_id;
 	/*
-	 * Defines the array size of the provided req_addr and
-	 * resv_addr array buffers. Should be set to the number of
-	 * request entries.
+	 * Firmware CFA Resource Type, for definitions see
+	 * cfa_v3/include/cfa_resources.h.
 	 */
-	uint16_t	req_cnt;
+	uint16_t	rtype;
 	/*
-	 * This is the DMA address for the request input data array
-	 * buffer. Array is of tfc_global_id_hwrm_req type. Size of the
-	 * array buffer is provided by the 'req_cnt' field in this
-	 * message.
+	 * Firmware CFA Resource Subtype, for definitions see
+	 * cfa_v3/include/cfa_resources.h
 	 */
-	uint64_t	req_addr;
+	uint8_t	subtype;
+	/* Control flags. */
+	uint8_t	flags;
+	/* Indicates the flow direction. */
+	#define HWRM_TFC_GLOBAL_ID_ALLOC_INPUT_FLAGS_DIR     UINT32_C(0x1)
+	/* If this bit set to 0, then it indicates rx flow. */
+	#define HWRM_TFC_GLOBAL_ID_ALLOC_INPUT_FLAGS_DIR_RX    UINT32_C(0x0)
+	/* If this bit is set to 1, then it indicates tx flow. */
+	#define HWRM_TFC_GLOBAL_ID_ALLOC_INPUT_FLAGS_DIR_TX    UINT32_C(0x1)
+	#define HWRM_TFC_GLOBAL_ID_ALLOC_INPUT_FLAGS_DIR_LAST \
+		HWRM_TFC_GLOBAL_ID_ALLOC_INPUT_FLAGS_DIR_TX
 	/*
-	 * This is the DMA address for the resc output data array
-	 * buffer. Array is of tfc_global_id_hwrm_rsp type. Size of the array
-	 * buffer is provided by the 'req_cnt' field in this
-	 * message.
+	 * Context id of the resource. This is opaque to FW and used to
+	 * uniquely map the identifier.
 	 */
-	uint64_t	resc_addr;
+	uint8_t	context_id[16];
 } __rte_packed_end;
 
 /* hwrm_tfc_global_id_alloc_output (size:128b/16B) */
@@ -61285,12 +61265,10 @@ struct __rte_packed_begin hwrm_tfc_global_id_alloc_output {
 	/* The length of the response data in number of bytes. */
 	uint16_t	resp_len;
 	/*
-	 * Size of the returned hwrm_tfc_global_id_req data array. The value
-	 * cannot exceed the req_cnt defined by the input msg. The data
-	 * array is returned using the resv_addr specified DMA
-	 * address also provided by the input msg.
+	 * returns the allocated global id, it could be identifier
+	 * based on the request.
 	 */
-	uint16_t	rsp_cnt;
+	uint16_t	global_id;
 	/* Non-zero if this is the first allocation for the global ID. */
 	uint8_t	first;
 	/* unused. */
@@ -61306,6 +61284,96 @@ struct __rte_packed_begin hwrm_tfc_global_id_alloc_output {
 	uint8_t	valid;
 } __rte_packed_end;
 
+/***************************
+ * hwrm_tfc_global_id_free *
+ ***************************/
+
+
+/* hwrm_tfc_global_id_free_input (size:256b/32B) */
+struct __rte_packed_begin hwrm_tfc_global_id_free_input {
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
+	 * Session associated with function requesting the global identifier
+	 * resource.
+	 */
+	uint16_t	sid;
+	/*
+	 * Firmware CFA Resource Type, for definitions see
+	 * cfa_v3/include/cfa_resources.h.
+	 */
+	uint16_t	rtype;
+	/*
+	 * Firmware CFA Resource Subtype, for definitions see
+	 * cfa_v3/include/cfa_resources.h
+	 */
+	uint8_t	subtype;
+	/* Indicates the flow direction. */
+	uint8_t	dir;
+	/* Global id of the resource. */
+	uint16_t	global_id;
+	/* unused. */
+	uint8_t	unused0[6];
+} __rte_packed_end;
+
+/* hwrm_tfc_global_id_free_output (size:128b/16B) */
+struct __rte_packed_begin hwrm_tfc_global_id_free_output {
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
+	 * This field is used in Output records to indicate that the output
+	 * is completely written to RAM. This field should be read as '1'
+	 * to indicate that the output has been completely written.
+	 * When writing a command completion or response to an internal
+	 * processor, the order of writes has to be such that this field
+	 * is written last.
+	 */
+	uint8_t	valid;
+} __rte_packed_end;
+
 /*********************
  * hwrm_tfc_tcam_set *
  *********************/
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_global_id.c b/drivers/net/bnxt/tf_core/v3/tfc_global_id.c
index 4c90afaee1..ec1b2f728f 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_global_id.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_global_id.c
@@ -51,7 +51,45 @@ int tfc_global_id_alloc(struct tfc *tfcp, uint16_t fid,
 		return rc;
 	}
 
-	rc = tfc_msg_global_id_alloc(tfcp, fid, sid, domain_id, req_cnt,
-				     req, rsp, rsp_cnt, first);
+	rc = tfc_msg_global_id_alloc(tfcp, fid, sid, req, rsp, first);
+	return rc;
+}
+
+int tfc_global_id_free(struct tfc *tfcp, uint16_t fid,
+		       const struct tfc_global_id_req *req)
+{
+	int rc = 0;
+	struct bnxt *bp;
+	uint16_t sid;
+
+	if (tfcp == NULL) {
+		PMD_DRV_LOG_LINE(ERR, "%s: Invalid tfcp pointer", __func__);
+		return -EINVAL;
+	}
+
+	if (tfcp->bp == NULL || tfcp->tfo == NULL) {
+		PMD_DRV_LOG_LINE(ERR, "%s: tfcp not initialized", __func__);
+		return -EINVAL;
+	}
+
+	if (req == NULL) {
+		PMD_DRV_LOG_LINE(ERR, "%s: global_id req is NULL", __func__);
+		return -EINVAL;
+	}
+
+	bp = tfcp->bp;
+	if (!BNXT_PF(bp) && !BNXT_VF_IS_TRUSTED(bp)) {
+		PMD_DRV_LOG_LINE(ERR, "%s: bp not PF or trusted VF", __func__);
+		return -EINVAL;
+	}
+
+	rc = tfo_sid_get(tfcp->tfo, &sid);
+	if (rc) {
+		PMD_DRV_LOG_LINE(ERR, "%s: Failed to retrieve SID, rc:%s",
+			    __func__, strerror(-rc));
+		return rc;
+	}
+
+	rc = tfc_msg_global_id_free(tfcp, fid, sid, req);
 	return rc;
 }
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tcam.c b/drivers/net/bnxt/tf_core/v3/tfc_tcam.c
index 2497929671..054431be12 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_tcam.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tcam.c
@@ -297,3 +297,58 @@ int tfc_tcam_free(struct tfc *tfcp, uint16_t fid, const struct tfc_tcam_info *tc
 				 strerror(-rc));
 	return rc;
 }
+
+int tfc_tcam_priority_update(struct tfc *tfcp, uint16_t fid,
+			     enum cfa_track_type tt,
+			     const struct tfc_tcam_info *tcam_info,
+			     uint16_t priority)
+{
+	int rc = 0;
+	struct bnxt *bp;
+	uint16_t sid;
+
+	if (tfcp == NULL) {
+		PMD_DRV_LOG_LINE(ERR, "%s: Invalid tfcp pointer", __func__);
+		return -EINVAL;
+	}
+
+	if (tfcp->bp == NULL || tfcp->tfo == NULL) {
+		PMD_DRV_LOG_LINE(ERR, "%s: tfcp not initialized", __func__);
+		return -EINVAL;
+	}
+	bp = tfcp->bp;
+
+	if (tcam_info == NULL) {
+		PMD_DRV_LOG_LINE(ERR, "%s: tcam_info is NULL", __func__);
+		return -EINVAL;
+	}
+
+	if (tcam_info->rsubtype >= CFA_RSUBTYPE_TCAM_MAX) {
+		PMD_DRV_LOG_LINE(ERR, "%s: Invalid tcam subtype: %d", __func__,
+				 tcam_info->rsubtype);
+		return -EINVAL;
+	}
+
+	if (!BNXT_PF(bp) && !BNXT_VF_IS_TRUSTED(bp)) {
+		PMD_DRV_LOG_LINE(ERR, "%s: bp not PF or trusted VF", __func__);
+		return -EINVAL;
+	}
+
+	rc = tfo_sid_get(tfcp->tfo, &sid);
+	if (rc) {
+		PMD_DRV_LOG_LINE(ERR, "%s: Failed to retrieve SID, rc:%s",
+				 __func__, strerror(-rc));
+		return rc;
+	}
+
+	rc = tfc_msg_tcam_prioriry_update(tfcp, fid, sid, tcam_info->dir, tt,
+					  tcam_info->rsubtype, tcam_info->id,
+					  priority);
+	if (rc)
+		PMD_DRV_LOG_LINE(ERR, "%s: update failed: %s:%s %d %s", __func__,
+				 tfc_dir_2_str(tcam_info->dir),
+				 tfc_tcam_2_str(tcam_info->rsubtype), tcam_info->id,
+				 strerror(-rc));
+
+	return rc;
+}
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
index e6f316539c..c8b6f544ca 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
@@ -1088,6 +1088,8 @@ bnxt_ulp_cap_feat_process(uint64_t feat_bits, uint64_t *out_bits)
 		BNXT_DRV_DBG(ERR, "Port Mac Address Feature is enabled\n");
 	if (bit & BNXT_ULP_FEATURE_BIT_MULTI_TUNNEL_FLOW)
 		BNXT_DRV_DBG(ERR, "Multi Tunnel Flow Feature is enabled\n");
+	if (bit & BNXT_ULP_FEATURE_BIT_MULTI_INSTANCE)
+		BNXT_DRV_DBG(ERR, "Multi Instance Feature is enabled\n");
 
 	*out_bits =  bit;
 	return 0;
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper.c b/drivers/net/bnxt/tf_ulp/ulp_mapper.c
index 4829ae41d1..d58899bdb1 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper.c
@@ -729,11 +729,13 @@ ulp_mapper_tbl_ident_scan_ext(struct bnxt_ulp_mapper_parms *parms,
 static int32_t
 ulp_mapper_ident_process(struct bnxt_ulp_mapper_parms *parms,
 			 struct bnxt_ulp_mapper_tbl_info *tbl,
+			 struct ulp_blob *key __rte_unused,
 			 struct bnxt_ulp_mapper_ident_info *ident,
 			 uint16_t *val)
 {
 	const struct ulp_mapper_core_ops *op = parms->mapper_data->mapper_oper;
 	struct ulp_flow_db_res_params fid_parms = { 0 };
+	bool global = false;
 	uint64_t id = 0;
 	int32_t idx;
 	int rc;
@@ -742,14 +744,25 @@ ulp_mapper_ident_process(struct bnxt_ulp_mapper_parms *parms,
 	fid_parms.resource_func = ident->resource_func;
 	fid_parms.resource_type = ident->ident_type;
 	fid_parms.critical_resource = tbl->critical_resource;
-	ulp_flow_db_shared_session_set(&fid_parms, tbl->session_type);
 
-	rc = op->ulp_mapper_core_ident_alloc_process(parms->ulp_ctx,
-						     tbl->session_type,
-						     ident->ident_type,
-						     tbl->direction,
-						     tbl->track_type,
-						     &id);
+	if (tbl->resource_func == BNXT_ULP_RESOURCE_FUNC_GLOBAL_IDENTIFIER)
+		global = true;
+
+	if (!global) {
+		ulp_flow_db_shared_session_set(&fid_parms, tbl->session_type);
+		rc = op->ulp_mapper_core_ident_alloc_process(parms->ulp_ctx,
+							     tbl->session_type,
+							     ident->ident_type,
+							     tbl->direction,
+							     tbl->track_type,
+							     &id);
+	} else {
+		rc = op->ulp_mapper_core_global_ident_alloc(parms->ulp_ctx,
+							    ident->ident_type,
+							    tbl->direction,
+							    &id);
+	}
+
 	if (unlikely(rc)) {
 		BNXT_DRV_DBG(ERR, "identifier process failed\n");
 		return rc;
@@ -781,7 +794,11 @@ ulp_mapper_ident_process(struct bnxt_ulp_mapper_parms *parms,
 
 error:
 	/* Need to free the identifier */
-	op->ulp_mapper_core_ident_free(parms->ulp_ctx, &fid_parms);
+	if (!global)
+		op->ulp_mapper_core_ident_free(parms->ulp_ctx, &fid_parms);
+	else
+		op->ulp_mapper_core_global_ident_free(parms->ulp_ctx,
+						      &fid_parms);
 	return rc;
 }
 
@@ -2413,7 +2430,7 @@ ulp_mapper_tcam_tbl_ident_alloc(struct bnxt_ulp_mapper_parms *parms,
 
 	idents = ulp_mapper_ident_fields_get(parms, tbl, &num_idents);
 	for (i = 0; i < num_idents; i++) {
-		if (unlikely(ulp_mapper_ident_process(parms, tbl,
+		if (unlikely(ulp_mapper_ident_process(parms, tbl, NULL,
 						      &idents[i], NULL)))
 			return -EINVAL;
 	}
@@ -3006,6 +3023,55 @@ ulp_mapper_stats_cache_tbl_res_free(struct bnxt_ulp_context *ulp,
 	return 0;
 }
 
+static int32_t
+ulp_mapper_global_identifier_process(struct bnxt_ulp_mapper_parms *parms,
+				     struct bnxt_ulp_mapper_tbl_info *tbl)
+{
+	int32_t rc = 0;
+	struct bnxt_ulp_mapper_ident_info *idents;
+	struct bnxt_ulp_mapper_key_info	*kflds;
+	struct ulp_blob key;
+	uint32_t num_idents;
+	uint32_t num_kflds;
+	uint32_t i;
+
+	/* check the table opcode  */
+	if (tbl->tbl_opcode != BNXT_ULP_GLOBAL_IDENTIFIER_TBL_OPC_ALLOC) {
+		BNXT_DRV_DBG(ERR, "Invalid global ident table opcode %d\n",
+			     tbl->tbl_opcode);
+		return -EINVAL;
+	}
+
+	/* Create the key blob */
+	if (unlikely(ulp_blob_init(&key, tbl->blob_key_bit_size,
+				   BNXT_ULP_BYTE_ORDER_BE))) {
+		BNXT_DRV_DBG(ERR, "blob init failed.\n");
+		return -EINVAL;
+	}
+
+	kflds = ulp_mapper_key_fields_get(parms, tbl, &num_kflds);
+	for (i = 0; i < num_kflds; i++) {
+		rc = ulp_mapper_field_opc_process(parms, tbl->direction,
+						  &kflds[i].field_info_spec,
+						  &key, 1, "Global Id Context");
+		if (unlikely(rc)) {
+			BNXT_DRV_DBG(ERR, "Key field set failed %s\n",
+				     kflds[i].field_info_spec.description);
+			return rc;
+		}
+	}
+
+	/* Get the identifiers to process it */
+	idents = ulp_mapper_ident_fields_get(parms, tbl, &num_idents);
+	for (i = 0; i < num_idents; i++) {
+		if (unlikely(ulp_mapper_ident_process(parms, tbl, &key,
+						      &idents[i], NULL)))
+			return -EINVAL;
+	}
+
+	return rc;
+}
+
 /* Free the vnic resource */
 static int32_t
 ulp_mapper_vnic_tbl_res_free(struct bnxt_ulp_context *ulp __rte_unused,
@@ -4211,6 +4277,9 @@ ulp_mapper_tbls_process(struct bnxt_ulp_mapper_parms *parms, void *error)
 		case BNXT_ULP_RESOURCE_FUNC_STATS_CACHE:
 			rc = ulp_mapper_stats_cache_tbl_process(parms, tbl);
 			break;
+		case BNXT_ULP_RESOURCE_FUNC_GLOBAL_IDENTIFIER:
+			rc = ulp_mapper_global_identifier_process(parms, tbl);
+			break;
 		default:
 			BNXT_DRV_DBG(ERR, "Unexpected mapper resource %d\n",
 				     tbl->resource_func);
@@ -4353,6 +4422,8 @@ ulp_mapper_resource_free(struct bnxt_ulp_context *ulp,
 		rc = ulp_mapper_stats_cache_tbl_res_free(ulp,
 							 fid);
 		break;
+	case BNXT_ULP_RESOURCE_FUNC_GLOBAL_IDENTIFIER:
+		rc = mapper_op->ulp_mapper_core_global_ident_free(ulp, res);
 	default:
 		break;
 	}
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper.h b/drivers/net/bnxt/tf_ulp/ulp_mapper.h
index f9a407cd84..2bcfc6ef1b 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper.h
@@ -147,6 +147,17 @@ struct ulp_mapper_core_ops {
 	int32_t
 	(*ulp_mapper_core_ident_free)(struct bnxt_ulp_context *ulp_ctx,
 				      struct ulp_flow_db_res_params *res);
+
+	int32_t
+	(*ulp_mapper_core_global_ident_alloc)(struct bnxt_ulp_context *ulp_ctx,
+					      uint16_t ident_type,
+					      uint8_t direction,
+					      uint64_t *identifier_id);
+
+	int32_t
+	(*ulp_mapper_core_global_ident_free)(struct bnxt_ulp_context *ulp_ctx,
+					     struct ulp_flow_db_res_params *r);
+
 	uint32_t
 	(*ulp_mapper_core_dyn_tbl_type_get)(struct bnxt_ulp_mapper_parms *parms,
 					    struct bnxt_ulp_mapper_tbl_info *t,
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c b/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c
index e755591716..e548a6b91f 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c
@@ -1377,6 +1377,8 @@ const struct ulp_mapper_core_ops ulp_mapper_tf_core_ops = {
 	.ulp_mapper_core_if_tbl_process = ulp_mapper_tf_if_tbl_process,
 	.ulp_mapper_core_ident_alloc_process = ulp_mapper_tf_ident_alloc,
 	.ulp_mapper_core_ident_free = ulp_mapper_tf_ident_free,
+	.ulp_mapper_core_global_ident_alloc = NULL,
+	.ulp_mapper_core_global_ident_free = NULL,
 	.ulp_mapper_core_dyn_tbl_type_get = ulp_mapper_tf_dyn_tbl_type_get,
 	.ulp_mapper_core_index_tbl_alloc_process =
 		ulp_mapper_tf_index_tbl_alloc_process,
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
index db7aa22c57..3db98fa160 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
@@ -1636,6 +1636,68 @@ ulp_mapper_tfc_ident_free(struct bnxt_ulp_context *ulp_ctx,
 	return rc;
 }
 
+static int32_t
+ulp_mapper_tfc_global_ident_alloc(struct bnxt_ulp_context *ulp_ctx,
+				  uint16_t ident_type,
+				  uint8_t direction,
+				  uint64_t *identifier_id)
+{
+	struct tfc *tfcp = NULL;
+	struct tfc_global_id_req glb_req = { 0 };
+	struct tfc_global_id glb_rsp = { 0 };
+	uint16_t fw_fid = 0;
+	uint16_t rsp_cnt;
+	int32_t rc = 0;
+	bool first = false;
+
+	if (unlikely(bnxt_ulp_cntxt_fid_get(ulp_ctx, &fw_fid))) {
+		BNXT_DRV_DBG(ERR, "Failed to get func_id\n");
+		return -EINVAL;
+	}
+
+	tfcp = bnxt_ulp_cntxt_tfcp_get(ulp_ctx);
+	if (unlikely(tfcp == NULL)) {
+		BNXT_DRV_DBG(ERR, "Failed to get tfcp pointer\n");
+		return -EINVAL;
+	}
+
+	glb_req.rtype = CFA_RTYPE_IDENT;
+	glb_req.dir = direction;
+	glb_req.cnt = 1;
+	glb_req.rsubtype = ident_type;
+
+	rc = tfc_global_id_alloc(tfcp, fw_fid, 1, 1, &glb_req, &glb_rsp, &rsp_cnt, &first);
+	if (unlikely(rc != 0)) {
+		BNXT_DRV_DBG(ERR, "alloc failed %d\n", rc);
+		return rc;
+	}
+	*identifier_id = glb_rsp.id;
+
+	return rc;
+}
+
+static int32_t
+ulp_mapper_tfc_global_ident_free(struct bnxt_ulp_context *ulp_ctx,
+				 struct ulp_flow_db_res_params *res)
+{
+	struct tfc *tfcp = NULL;
+	int32_t rc = 0;
+	uint16_t fw_fid = 0;
+
+	if (unlikely(bnxt_ulp_cntxt_fid_get(ulp_ctx, &fw_fid))) {
+		BNXT_DRV_DBG(ERR, "Failed to get func_id\n");
+		return -EINVAL;
+	}
+
+	tfcp = bnxt_ulp_cntxt_tfcp_get(ulp_ctx);
+	if (unlikely(tfcp == NULL)) {
+		BNXT_DRV_DBG(ERR, "Failed to get tfcp pointer\n");
+		return -EINVAL;
+	}
+
+	return rc;
+}
+
 static inline int32_t
 ulp_mapper_tfc_tcam_entry_free(struct bnxt_ulp_context *ulp,
 			       struct ulp_flow_db_res_params *res)
@@ -1849,6 +1911,8 @@ const struct ulp_mapper_core_ops ulp_mapper_tfc_core_ops = {
 	.ulp_mapper_core_if_tbl_process = ulp_mapper_tfc_if_tbl_process,
 	.ulp_mapper_core_ident_alloc_process = ulp_mapper_tfc_ident_alloc,
 	.ulp_mapper_core_ident_free = ulp_mapper_tfc_ident_free,
+	.ulp_mapper_core_global_ident_alloc = ulp_mapper_tfc_global_ident_alloc,
+	.ulp_mapper_core_global_ident_free = ulp_mapper_tfc_global_ident_free,
 	.ulp_mapper_core_dyn_tbl_type_get = ulp_mapper_tfc_dyn_tbl_type_get,
 	.ulp_mapper_core_index_tbl_alloc_process =
 		ulp_mapper_tfc_index_tbl_alloc_process,
-- 
2.39.5 (Apple Git-154)

