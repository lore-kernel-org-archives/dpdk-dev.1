Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CDBC54ED0
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 14:05:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64D6840A67;
	Fri, 23 May 2025 16:05:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 67FF54060F;
 Fri, 23 May 2025 16:05:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748009130; x=1779545130;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=YAZHMubO+mjmdA/mnkORqlr0vCOrAf4ZaGV8zuFGuc4=;
 b=SElGhIu9D0ehNrq7yaYZDQR0dHJ4ta9e8cQHAsAmVaBs8iBI8R/Aea0d
 A7zop4YxuwTitKHA2en5BXycJJ9TQpZhhBY/9DUd5qUiC4Smj7yUkv8cX
 IVouKG/74RdF+nGxdIeiiFQug2NZ/XAe7feY8PopGQFflkl/TaUjQhjMK
 7gWLiEOXlwwI7OwBIeQchnO6yNi5KdQv5AXXLdaClWj5jxW/OPqUnRjFi
 E1hgRT1GxhGBoyPLCXeW4kcvMugY8oGhK6lsHdQ/wzhNvOetKSFdWEofs
 ZEpWChIG3nM07AtyrkoJ4cmpz97QIxGjV3eCY4n71HVIsDdaQxmuD7H5r A==;
X-CSE-ConnectionGUID: YIUjUV62SC+/8XBCmyoVIg==
X-CSE-MsgGUID: w3h1WGcVQOyEJHToP8gl4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="52695941"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; d="scan'208";a="52695941"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2025 07:05:28 -0700
X-CSE-ConnectionGUID: bY2wiiJrSmmWpJBnMKaEyw==
X-CSE-MsgGUID: xoXbM6feSNSgqKXELDBNgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; d="scan'208";a="145872134"
Received: from unknown (HELO silpixa00401749.ger.corp.intel.com)
 ([10.237.222.190])
 by orviesa003.jf.intel.com with ESMTP; 23 May 2025 07:05:26 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: Jay Zhou <jianjay.zhou@huawei.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, Radu Nicolau <radu.nicolau@intel.com>,
 roy.fan.zhang@intel.com, stable@dpdk.org
Subject: [PATCH] crypto/virtio: add request check on request side
Date: Fri, 23 May 2025 14:04:50 +0000
Message-ID: <20250523140450.75543-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.43.0
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

Add same request checks on the request side.

Fixes: b2866f473369 ("vhost/crypto: fix missed request check for copy mode")
Cc: roy.fan.zhang@intel.com
Cc: stable@dpdk.org

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/crypto/virtio/virtio_rxtx.c | 40 +++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/crypto/virtio/virtio_rxtx.c b/drivers/crypto/virtio/virtio_rxtx.c
index 0cc904485c..afdb8fb406 100644
--- a/drivers/crypto/virtio/virtio_rxtx.c
+++ b/drivers/crypto/virtio/virtio_rxtx.c
@@ -193,6 +193,40 @@ virtqueue_dequeue_burst_rx_packed(struct virtqueue *vq,
 	return i;
 }
 
+static __rte_always_inline uint8_t
+virtqueue_crypto_check_cipher_request(struct virtio_crypto_cipher_data_req *req)
+{
+	if (likely((req->para.iv_len <= VIRTIO_CRYPTO_MAX_IV_SIZE) &&
+		(req->para.src_data_len <= RTE_MBUF_DEFAULT_BUF_SIZE) &&
+		(req->para.dst_data_len >= req->para.src_data_len) &&
+		(req->para.dst_data_len <= RTE_MBUF_DEFAULT_BUF_SIZE)))
+		return VIRTIO_CRYPTO_OK;
+	return VIRTIO_CRYPTO_BADMSG;
+}
+
+static __rte_always_inline uint8_t
+virtqueue_crypto_check_chain_request(struct virtio_crypto_alg_chain_data_req *req)
+{
+	if (likely((req->para.iv_len <= VIRTIO_CRYPTO_MAX_IV_SIZE) &&
+		(req->para.src_data_len <= RTE_MBUF_DEFAULT_BUF_SIZE) &&
+		(req->para.dst_data_len >= req->para.src_data_len) &&
+		(req->para.dst_data_len <= RTE_MBUF_DEFAULT_BUF_SIZE) &&
+		(req->para.cipher_start_src_offset <
+			RTE_MBUF_DEFAULT_BUF_SIZE) &&
+		(req->para.len_to_cipher <= RTE_MBUF_DEFAULT_BUF_SIZE) &&
+		(req->para.hash_start_src_offset <
+			RTE_MBUF_DEFAULT_BUF_SIZE) &&
+		(req->para.len_to_hash <= RTE_MBUF_DEFAULT_BUF_SIZE) &&
+		(req->para.cipher_start_src_offset + req->para.len_to_cipher <=
+			req->para.src_data_len) &&
+		(req->para.hash_start_src_offset + req->para.len_to_hash <=
+			req->para.src_data_len) &&
+		(req->para.dst_data_len + req->para.hash_result_len <=
+			RTE_MBUF_DEFAULT_BUF_SIZE)))
+		return VIRTIO_CRYPTO_OK;
+	return VIRTIO_CRYPTO_BADMSG;
+}
+
 static inline int
 virtqueue_crypto_sym_pkt_header_arrange(
 		struct rte_crypto_op *cop,
@@ -228,6 +262,9 @@ virtqueue_crypto_sym_pkt_header_arrange(
 				sym_op->cipher.data.offset);
 		req_data->u.sym_req.u.cipher.para.dst_data_len =
 			req_data->u.sym_req.u.cipher.para.src_data_len;
+		if (virtqueue_crypto_check_cipher_request(
+			&req_data->u.sym_req.u.cipher) != VIRTIO_CRYPTO_OK)
+			return -1;
 		break;
 	case VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING:
 		req_data->u.sym_req.op_type =
@@ -265,6 +302,9 @@ virtqueue_crypto_sym_pkt_header_arrange(
 			VIRTIO_CRYPTO_SYM_HASH_MODE_AUTH)
 			req_data->u.sym_req.u.chain.para.hash_result_len =
 				chain_para->u.mac_param.hash_result_len;
+		if (virtqueue_crypto_check_chain_request(
+			&req_data->u.sym_req.u.chain) != VIRTIO_CRYPTO_OK)
+			return -1;
 		break;
 	default:
 		return -1;
-- 
2.43.0

