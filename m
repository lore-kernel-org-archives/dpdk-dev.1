Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741A9CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 16:09:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C9B5406B4;
	Tue, 19 May 2026 18:08:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 27DB440665
 for <dev@dpdk.org>; Tue, 19 May 2026 18:08:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779206923; x=1810742923;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6jm+zVy12tq5UFU6ZL27J4sXkWmoZpfgxMHMC2vZBH4=;
 b=UIbMxth3S/jqDByV/6evw0tscJ8a2fJ3ihejZ8L9rjaTduinccKc+uf8
 /FAs1XoOBNHDFPpXVOkCm7tDx3pW5Skyr6oYsLDPOqv5z+rjCepXlG/ld
 3b4LRw7bVvNGzibK8NE+MASbqF3cTKF5HJl1S1cYC6xEjKFoxV9H62kld
 JAKqTDM0B4ndC2DkvYJsU4Z0U1appJHZL8XjmbuSBUu3b1i7jGzirsv64
 lxJe6Rxa/A1N39R14gp2y4Igie+LsidHMtJcT2Nap6smlZF3RqRDvtY9f
 kkNYtAW9079eedvMwkUdPRyVSf6dZAjivrJHfbpfBFVoMN4AO8dYo86B6 w==;
X-CSE-ConnectionGUID: 7bd7QAUBTrqkUapuOCg5MQ==
X-CSE-MsgGUID: g0g6TBI2QZitBJbCQhIVRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80070064"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="80070064"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 09:08:42 -0700
X-CSE-ConnectionGUID: GfwOVfzvSNuRGoRAD9TQKw==
X-CSE-MsgGUID: o4JIQHJjS+SsUQAkR8lyCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="244784791"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.20.224.247])
 by orviesa005.jf.intel.com with ESMTP; 19 May 2026 09:08:41 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 6/8] net/idpf: replace use of DPDK-specific memcpy function
Date: Tue, 19 May 2026 16:06:03 +0000
Message-ID: <20260519160823.1004973-7-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260519160823.1004973-1-bruce.richardson@intel.com>
References: <20260519160823.1004973-1-bruce.richardson@intel.com>
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

The driver use of memcpy is for control path work, for example, flow
configuration and so is fine using the standard libc memcpy function in
place of the DPDK-specific rte_memcpy version.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/idpf/base/idpf_osdep.h      |  5 ++---
 drivers/net/intel/idpf/idpf_common_device.c   |  2 +-
 drivers/net/intel/idpf/idpf_common_virtchnl.c | 20 +++++++++----------
 drivers/net/intel/idpf/idpf_ethdev.c          | 10 +++++-----
 drivers/net/intel/idpf/idpf_rxtx.c            |  8 ++++----
 5 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/net/intel/idpf/base/idpf_osdep.h b/drivers/net/intel/idpf/base/idpf_osdep.h
index 47b95d0da6..67bc33f2e6 100644
--- a/drivers/net/intel/idpf/base/idpf_osdep.h
+++ b/drivers/net/intel/idpf/base/idpf_osdep.h
@@ -14,7 +14,6 @@
 #include <stdbool.h>
 
 #include <rte_common.h>
-#include <rte_memcpy.h>
 #include <rte_malloc.h>
 #include <rte_memzone.h>
 #include <rte_byteorder.h>
@@ -199,8 +198,8 @@ struct __rte_packed_begin idpf_virt_mem {
 #define idpf_free(h, m)		rte_free(m)
 
 #define idpf_memset(a, b, c, d)	memset((a), (b), (c))
-#define idpf_memcpy(a, b, c, d)	rte_memcpy((a), (b), (c))
-#define idpf_memdup(a, b, c, d)	rte_memcpy(idpf_malloc(a, c), b, c)
+#define idpf_memcpy(a, b, c, d)	memcpy((a), (b), (c))
+#define idpf_memdup(a, b, c, d)	memcpy(idpf_malloc(a, c), b, c)
 
 #define CPU_TO_BE16(o) rte_cpu_to_be_16(o)
 #define CPU_TO_BE32(o) rte_cpu_to_be_32(o)
diff --git a/drivers/net/intel/idpf/idpf_common_device.c b/drivers/net/intel/idpf/idpf_common_device.c
index 24ee00db23..f27a911977 100644
--- a/drivers/net/intel/idpf/idpf_common_device.c
+++ b/drivers/net/intel/idpf/idpf_common_device.c
@@ -496,7 +496,7 @@ idpf_vport_init(struct idpf_vport *vport,
 	vport->num_rx_q = vport_info->num_rx_q;
 	vport->num_rx_bufq = vport_info->num_rx_bufq;
 	vport->max_mtu = vport_info->max_mtu;
-	rte_memcpy(vport->default_mac_addr,
+	memcpy(vport->default_mac_addr,
 		   vport_info->default_mac_addr, ETH_ALEN);
 	vport->rss_algorithm = vport_info->rss_algorithm;
 	vport->rss_key_size = RTE_MIN(IDPF_RSS_KEY_LEN,
diff --git a/drivers/net/intel/idpf/idpf_common_virtchnl.c b/drivers/net/intel/idpf/idpf_common_virtchnl.c
index f8c487c537..4befd5fc83 100644
--- a/drivers/net/intel/idpf/idpf_common_virtchnl.c
+++ b/drivers/net/intel/idpf/idpf_common_virtchnl.c
@@ -141,7 +141,7 @@ idpf_read_msg_from_cp(struct idpf_adapter *adapter, uint16_t buf_len,
 		return result;
 	}
 
-	rte_memcpy(buf, ctlq_msg.ctx.indirect.payload->va, buf_len);
+	memcpy(buf, ctlq_msg.ctx.indirect.payload->va, buf_len);
 
 	opcode = rte_le_to_cpu_32(ctlq_msg.cookie.mbx.chnl_opcode);
 	adapter->cmd_retval = rte_le_to_cpu_32(ctlq_msg.cookie.mbx.chnl_retval);
@@ -323,7 +323,7 @@ idpf_vc_caps_get(struct idpf_adapter *adapter)
 		return err;
 	}
 
-	rte_memcpy(&adapter->caps, args.out_buffer, sizeof(struct virtchnl2_get_capabilities));
+	memcpy(&adapter->caps, args.out_buffer, sizeof(struct virtchnl2_get_capabilities));
 
 	return 0;
 }
@@ -361,7 +361,7 @@ idpf_vc_vport_create(struct idpf_vport *vport,
 		return err;
 	}
 
-	rte_memcpy(&(vport->vport_info.info), args.out_buffer, IDPF_DFLT_MBX_BUF_SIZE);
+	memcpy(&(vport->vport_info.info), args.out_buffer, IDPF_DFLT_MBX_BUF_SIZE);
 	return 0;
 }
 
@@ -419,7 +419,7 @@ idpf_vc_queue_grps_add(struct idpf_vport *vport,
 		return err;
 	}
 
-	rte_memcpy(p2p_queue_grps_out, args.out_buffer, IDPF_DFLT_MBX_BUF_SIZE);
+	memcpy(p2p_queue_grps_out, args.out_buffer, IDPF_DFLT_MBX_BUF_SIZE);
 	return 0;
 }
 
@@ -475,7 +475,7 @@ idpf_vc_rss_key_set(struct idpf_vport *vport)
 
 	rss_key->vport_id = vport->vport_id;
 	rss_key->key_len = vport->rss_key_size;
-	rte_memcpy(rss_key->key, vport->rss_key,
+	memcpy(rss_key->key, vport->rss_key,
 		   sizeof(rss_key->key[0]) * vport->rss_key_size);
 
 	memset(&args, 0, sizeof(args));
@@ -528,7 +528,7 @@ int idpf_vc_rss_key_get(struct idpf_vport *vport)
 				return -ENOMEM;
 			}
 		}
-		rte_memcpy(vport->rss_key, rss_key_ret->key, vport->rss_key_size);
+		memcpy(vport->rss_key, rss_key_ret->key, vport->rss_key_size);
 	} else {
 		DRV_LOG(ERR, "Failed to execute command of VIRTCHNL2_OP_GET_RSS_KEY");
 	}
@@ -553,7 +553,7 @@ idpf_vc_rss_lut_set(struct idpf_vport *vport)
 
 	rss_lut->vport_id = vport->vport_id;
 	rss_lut->lut_entries = vport->rss_lut_size;
-	rte_memcpy(rss_lut->lut, vport->rss_lut,
+	memcpy(rss_lut->lut, vport->rss_lut,
 		   sizeof(rss_lut->lut[0]) * vport->rss_lut_size);
 
 	memset(&args, 0, sizeof(args));
@@ -605,7 +605,7 @@ idpf_vc_rss_lut_get(struct idpf_vport *vport)
 				return -ENOMEM;
 			}
 		}
-		rte_memcpy(vport->rss_lut, rss_lut_ret->lut, rss_lut_ret->lut_entries);
+		memcpy(vport->rss_lut, rss_lut_ret->lut, rss_lut_ret->lut_entries);
 		vport->rss_lut_size = rss_lut_ret->lut_entries;
 	} else {
 		DRV_LOG(ERR, "Failed to execute command of VIRTCHNL2_OP_GET_RSS_LUT");
@@ -742,7 +742,7 @@ idpf_vc_vectors_alloc(struct idpf_vport *vport, uint16_t num_vectors)
 	if (err != 0)
 		DRV_LOG(ERR, "Failed to execute command VIRTCHNL2_OP_ALLOC_VECTORS");
 
-	rte_memcpy(vport->recv_vectors, args.out_buffer, len);
+	memcpy(vport->recv_vectors, args.out_buffer, len);
 	rte_free(alloc_vec);
 	return err;
 }
@@ -1007,7 +1007,7 @@ idpf_vc_ptype_info_query(struct idpf_adapter *adapter,
 	if (err != 0)
 		DRV_LOG(ERR, "Failed to execute command of VIRTCHNL2_OP_GET_PTYPE_INFO");
 
-	rte_memcpy(recv_ptype_info, args.out_buffer, IDPF_DFLT_MBX_BUF_SIZE);
+	memcpy(recv_ptype_info, args.out_buffer, IDPF_DFLT_MBX_BUF_SIZE);
 	return err;
 }
 
diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index 5e57a45775..6b3016ba77 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -439,7 +439,7 @@ idpf_init_rss(struct idpf_vport *vport)
 			     vport->rss_key_size);
 		return -EINVAL;
 	} else {
-		rte_memcpy(vport->rss_key, rss_conf->rss_key,
+		memcpy(vport->rss_key, rss_conf->rss_key,
 			   vport->rss_key_size);
 	}
 
@@ -558,7 +558,7 @@ idpf_rss_hash_update(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
-	rte_memcpy(vport->rss_key, rss_conf->rss_key,
+	memcpy(vport->rss_key, rss_conf->rss_key,
 		   vport->rss_key_size);
 	ret = idpf_vc_rss_key_set(vport);
 	if (ret != 0) {
@@ -631,7 +631,7 @@ idpf_rss_hash_conf_get(struct rte_eth_dev *dev,
 	if (rss_conf->rss_key_len > vport->rss_key_size)
 		rss_conf->rss_key_len = vport->rss_key_size;
 
-	rte_memcpy(rss_conf->rss_key, vport->rss_key, rss_conf->rss_key_len);
+	memcpy(rss_conf->rss_key, vport->rss_key, rss_conf->rss_key_len);
 
 	return 0;
 }
@@ -1363,7 +1363,7 @@ idpf_handle_virtchnl_msg(struct idpf_adapter_ext *adapter_ex)
 			return;
 		}
 
-		rte_memcpy(adapter->mbx_resp, ctlq_msg.ctx.indirect.payload->va,
+		memcpy(adapter->mbx_resp, ctlq_msg.ctx.indirect.payload->va,
 			   IDPF_DFLT_MBX_BUF_SIZE);
 
 		mbx_op = rte_le_to_cpu_16(ctlq_msg.opcode);
@@ -1477,7 +1477,7 @@ idpf_adapter_ext_init(struct rte_pci_device *pci_dev, struct idpf_adapter_ext *a
 
 	strncpy(adapter->name, pci_dev->device.name, PCI_PRI_STR_SIZE);
 
-	rte_memcpy(&base->caps, &req_caps, sizeof(struct virtchnl2_get_capabilities));
+	memcpy(&base->caps, &req_caps, sizeof(struct virtchnl2_get_capabilities));
 
 	ret = idpf_adapter_init(base);
 	if (ret != 0) {
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index b316c77b62..07f3df4a80 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -74,7 +74,7 @@ idpf_dma_zone_reserve(struct rte_eth_dev *dev, uint16_t queue_idx,
 		else
 			ring_size = RTE_ALIGN(len * sizeof(struct ci_tx_desc),
 					      IDPF_DMA_MEM_ALIGN);
-		rte_memcpy(ring_name, "idpf Tx ring", sizeof("idpf Tx ring"));
+		memcpy(ring_name, "idpf Tx ring", sizeof("idpf Tx ring"));
 		break;
 	case VIRTCHNL2_QUEUE_TYPE_RX:
 		if (splitq)
@@ -83,17 +83,17 @@ idpf_dma_zone_reserve(struct rte_eth_dev *dev, uint16_t queue_idx,
 		else
 			ring_size = RTE_ALIGN(len * sizeof(struct virtchnl2_singleq_rx_buf_desc),
 					      IDPF_DMA_MEM_ALIGN);
-		rte_memcpy(ring_name, "idpf Rx ring", sizeof("idpf Rx ring"));
+		memcpy(ring_name, "idpf Rx ring", sizeof("idpf Rx ring"));
 		break;
 	case VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION:
 		ring_size = RTE_ALIGN(len * sizeof(struct idpf_splitq_tx_compl_desc),
 				      IDPF_DMA_MEM_ALIGN);
-		rte_memcpy(ring_name, "idpf Tx compl ring", sizeof("idpf Tx compl ring"));
+		memcpy(ring_name, "idpf Tx compl ring", sizeof("idpf Tx compl ring"));
 		break;
 	case VIRTCHNL2_QUEUE_TYPE_RX_BUFFER:
 		ring_size = RTE_ALIGN(len * sizeof(struct virtchnl2_splitq_rx_buf_desc),
 				      IDPF_DMA_MEM_ALIGN);
-		rte_memcpy(ring_name, "idpf Rx buf ring", sizeof("idpf Rx buf ring"));
+		memcpy(ring_name, "idpf Rx buf ring", sizeof("idpf Rx buf ring"));
 		break;
 	default:
 		PMD_INIT_LOG(ERR, "Invalid queue type");
-- 
2.51.0

