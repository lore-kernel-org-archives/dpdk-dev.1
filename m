Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B08CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 16:08:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F292C402F0;
	Tue, 19 May 2026 18:08:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 45019402F0
 for <dev@dpdk.org>; Tue, 19 May 2026 18:08:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779206919; x=1810742919;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T3hO4RnDHvT6OxrzoxDqaAJcY1qT6OWBz49dpeQKZqk=;
 b=JGM04lgQhLz23emWRF7u81bEjw6471Avg4xHwgFHnJbTrscbLh2RZoZj
 Y5UZUJ+hEK+awJHI78uiZzyS4FdZDgRvMLDBjhBI/vog0MnKfTSr9iQw6
 E7UN5bG9O2ZtD6iKIt1ntbygkBbIwt/kI5EpXbSiaYws/OBNV5DYjitbu
 6LbT9Awlhwu3CravxaxgLCfYPjqqcyH2brN0uP3o7Dh9YSn8cH5SKlnI9
 Eu+9cDi3eiIzGjdlO0SfggjPAjPxivQ3T4pjBhefXyjUbePSgQG6zZo25
 +/c7cCu2HMbsc6AejKz6AGA6IX7svmtF5a/WFllyGqgLR3oUwV3M37tsr w==;
X-CSE-ConnectionGUID: Be1yhp6zQW6+D2UR3lXjdw==
X-CSE-MsgGUID: aps400CwQWWDczO6GR0Hvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80070046"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="80070046"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 09:08:38 -0700
X-CSE-ConnectionGUID: tigNd684R7OOjqgJHV6S/w==
X-CSE-MsgGUID: TE7MgTvFSfu69l9E7zLp8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="244784772"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.20.224.247])
 by orviesa005.jf.intel.com with ESMTP; 19 May 2026 09:08:37 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 2/8] net/iavf: replace use of DPDK-specific memcpy function
Date: Tue, 19 May 2026 16:05:59 +0000
Message-ID: <20260519160823.1004973-3-bruce.richardson@intel.com>
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
 drivers/net/intel/iavf/base/iavf_osdep.h   |  3 +-
 drivers/net/intel/iavf/iavf_ethdev.c       | 12 +++---
 drivers/net/intel/iavf/iavf_fdir.c         | 46 +++++++++++-----------
 drivers/net/intel/iavf/iavf_fsub.c         | 26 ++++++------
 drivers/net/intel/iavf/iavf_generic_flow.c |  4 +-
 drivers/net/intel/iavf/iavf_hash.c         |  4 +-
 drivers/net/intel/iavf/iavf_tm.c           |  6 +--
 drivers/net/intel/iavf/iavf_vchnl.c        | 14 +++----
 8 files changed, 57 insertions(+), 58 deletions(-)

diff --git a/drivers/net/intel/iavf/base/iavf_osdep.h b/drivers/net/intel/iavf/base/iavf_osdep.h
index 1b0ca933cc..cb95b848b6 100644
--- a/drivers/net/intel/iavf/base/iavf_osdep.h
+++ b/drivers/net/intel/iavf/base/iavf_osdep.h
@@ -12,7 +12,6 @@
 #include <stdarg.h>
 
 #include <rte_common.h>
-#include <rte_memcpy.h>
 #include <rte_memzone.h>
 #include <rte_malloc.h>
 #include <rte_byteorder.h>
@@ -124,7 +123,7 @@ writeq(uint64_t value, volatile void *addr)
 #endif /* __INTEL_NET_BASE_OSDEP__ */
 
 #define iavf_memset(a, b, c, d) memset((a), (b), (c))
-#define iavf_memcpy(a, b, c, d) rte_memcpy((a), (b), (c))
+#define iavf_memcpy(a, b, c, d) memcpy((a), (b), (c))
 
 #define iavf_usec_delay(x) rte_delay_us_sleep(x)
 #define iavf_msec_delay(x) iavf_usec_delay(1000 * (x))
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 1eca20bc9a..ea1ecc1d9b 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -553,7 +553,7 @@ iavf_init_rss(struct iavf_adapter *adapter)
 		for (i = 0; i < vf->vf_res->rss_key_size; i++)
 			vf->rss_key[i] = (uint8_t)rte_rand();
 	} else
-		rte_memcpy(vf->rss_key, rss_conf->rss_key,
+		memcpy(vf->rss_key, rss_conf->rss_key,
 			   RTE_MIN(rss_conf->rss_key_len,
 				   vf->vf_res->rss_key_size));
 
@@ -1536,7 +1536,7 @@ iavf_dev_rss_reta_update(struct rte_eth_dev *dev,
 		return -ENOMEM;
 	}
 	/* store the old lut table temporarily */
-	rte_memcpy(lut, vf->rss_lut, reta_size);
+	memcpy(lut, vf->rss_lut, reta_size);
 
 	for (i = 0; i < reta_size; i++) {
 		idx = i / RTE_ETH_RETA_GROUP_SIZE;
@@ -1545,11 +1545,11 @@ iavf_dev_rss_reta_update(struct rte_eth_dev *dev,
 			lut[i] = reta_conf[idx].reta[shift];
 	}
 
-	rte_memcpy(vf->rss_lut, lut, reta_size);
+	memcpy(vf->rss_lut, lut, reta_size);
 	/* send virtchnl ops to configure RSS */
 	ret = iavf_configure_rss_lut(adapter);
 	if (ret) /* revert back */
-		rte_memcpy(vf->rss_lut, lut, reta_size);
+		memcpy(vf->rss_lut, lut, reta_size);
 	free(lut);
 
 	return ret;
@@ -1605,7 +1605,7 @@ iavf_set_rss_key(struct iavf_adapter *adapter, uint8_t *key, uint8_t key_len)
 		return -EINVAL;
 	}
 
-	rte_memcpy(vf->rss_key, key, key_len);
+	memcpy(vf->rss_key, key, key_len);
 
 	return iavf_configure_rss_key(adapter);
 }
@@ -1689,7 +1689,7 @@ iavf_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
 		return 0;
 
 	rss_conf->rss_key_len = vf->vf_res->rss_key_size;
-	rte_memcpy(rss_conf->rss_key, vf->rss_key, rss_conf->rss_key_len);
+	memcpy(rss_conf->rss_key, vf->rss_key, rss_conf->rss_key_len);
 
 	return 0;
 }
diff --git a/drivers/net/intel/iavf/iavf_fdir.c b/drivers/net/intel/iavf/iavf_fdir.c
index 9eae874800..08724d78a8 100644
--- a/drivers/net/intel/iavf/iavf_fdir.c
+++ b/drivers/net/intel/iavf/iavf_fdir.c
@@ -374,7 +374,7 @@ iavf_fdir_create(struct iavf_adapter *ad,
 	if (filter->mark_flag == 1)
 		iavf_fdir_rx_proc_enable(ad, 1);
 
-	rte_memcpy(rule, filter, sizeof(*rule));
+	memcpy(rule, filter, sizeof(*rule));
 	flow->rule = rule;
 
 	return 0;
@@ -672,14 +672,14 @@ iavf_fdir_refine_input_set(const uint64_t input_set,
 		VIRTCHNL_ADD_PROTO_HDR_FIELD_BIT(hdr, IPV4, PROT);
 		memset(&ipv4_spec, 0, sizeof(ipv4_spec));
 		ipv4_spec.hdr.next_proto_id = proto_id;
-		rte_memcpy(hdr->buffer, &ipv4_spec.hdr,
+		memcpy(hdr->buffer, &ipv4_spec.hdr,
 			   sizeof(ipv4_spec.hdr));
 		return true;
 	case VIRTCHNL_PROTO_HDR_IPV6:
 		VIRTCHNL_ADD_PROTO_HDR_FIELD_BIT(hdr, IPV6, PROT);
 		memset(&ipv6_spec, 0, sizeof(ipv6_spec));
 		ipv6_spec.hdr.proto = proto_id;
-		rte_memcpy(hdr->buffer, &ipv6_spec.hdr,
+		memcpy(hdr->buffer, &ipv6_spec.hdr,
 			   sizeof(ipv6_spec.hdr));
 		return true;
 	default:
@@ -894,7 +894,7 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 									ETHERTYPE);
 				}
 
-				rte_memcpy(hdr1->buffer, eth_spec,
+				memcpy(hdr1->buffer, eth_spec,
 					   sizeof(struct rte_ether_hdr));
 			}
 
@@ -985,7 +985,7 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 				input_set |= IAVF_PROT_IPV4_INNER;
 			}
 
-			rte_memcpy(hdr->buffer, &ipv4_spec->hdr,
+			memcpy(hdr->buffer, &ipv4_spec->hdr,
 				   sizeof(ipv4_spec->hdr));
 
 			hdrs->count = ++layer;
@@ -1075,7 +1075,7 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 				input_set |= IAVF_PROT_IPV6_INNER;
 			}
 
-			rte_memcpy(hdr->buffer, &ipv6_spec->hdr,
+			memcpy(hdr->buffer, &ipv6_spec->hdr,
 				   sizeof(ipv6_spec->hdr));
 
 			hdrs->count = ++layer;
@@ -1110,7 +1110,7 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 				VIRTCHNL_ADD_PROTO_HDR_FIELD_BIT(hdr1, ETH,
 								 ETHERTYPE);
 
-				rte_memcpy(hdr->buffer, &ipv6_frag_spec->hdr,
+				memcpy(hdr->buffer, &ipv6_frag_spec->hdr,
 					   sizeof(ipv6_frag_spec->hdr));
 			} else if (ipv6_frag_mask->hdr.id == UINT32_MAX) {
 				rte_flow_error_set(error, EINVAL,
@@ -1162,11 +1162,11 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 				}
 
 				if (l3 == RTE_FLOW_ITEM_TYPE_IPV4)
-					rte_memcpy(hdr->buffer,
+					memcpy(hdr->buffer,
 						&udp_spec->hdr,
 						sizeof(udp_spec->hdr));
 				else if (l3 == RTE_FLOW_ITEM_TYPE_IPV6)
-					rte_memcpy(hdr->buffer,
+					memcpy(hdr->buffer,
 						&udp_spec->hdr,
 						sizeof(udp_spec->hdr));
 			}
@@ -1219,11 +1219,11 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 				}
 
 				if (l3 == RTE_FLOW_ITEM_TYPE_IPV4)
-					rte_memcpy(hdr->buffer,
+					memcpy(hdr->buffer,
 						&tcp_spec->hdr,
 						sizeof(tcp_spec->hdr));
 				else if (l3 == RTE_FLOW_ITEM_TYPE_IPV6)
-					rte_memcpy(hdr->buffer,
+					memcpy(hdr->buffer,
 						&tcp_spec->hdr,
 						sizeof(tcp_spec->hdr));
 			}
@@ -1265,11 +1265,11 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 				}
 
 				if (l3 == RTE_FLOW_ITEM_TYPE_IPV4)
-					rte_memcpy(hdr->buffer,
+					memcpy(hdr->buffer,
 						&sctp_spec->hdr,
 						sizeof(sctp_spec->hdr));
 				else if (l3 == RTE_FLOW_ITEM_TYPE_IPV6)
-					rte_memcpy(hdr->buffer,
+					memcpy(hdr->buffer,
 						&sctp_spec->hdr,
 						sizeof(sctp_spec->hdr));
 			}
@@ -1300,7 +1300,7 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 					VIRTCHNL_ADD_PROTO_HDR_FIELD_BIT(hdr, GTPU_IP, TEID);
 				}
 
-				rte_memcpy(hdr->buffer,
+				memcpy(hdr->buffer,
 					gtp_spec, sizeof(*gtp_spec));
 			}
 
@@ -1355,7 +1355,7 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 				psc.qfi = gtp_psc_spec->hdr.qfi;
 				psc.type = gtp_psc_spec->hdr.type;
 				psc.next = 0;
-				rte_memcpy(hdr->buffer, &psc,
+				memcpy(hdr->buffer, &psc,
 					sizeof(struct iavf_gtp_psc_spec_hdr));
 			}
 
@@ -1376,7 +1376,7 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 					VIRTCHNL_ADD_PROTO_HDR_FIELD_BIT(hdr, L2TPV3, SESS_ID);
 				}
 
-				rte_memcpy(hdr->buffer, l2tpv3oip_spec,
+				memcpy(hdr->buffer, l2tpv3oip_spec,
 					sizeof(*l2tpv3oip_spec));
 			}
 
@@ -1397,7 +1397,7 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 					VIRTCHNL_ADD_PROTO_HDR_FIELD_BIT(hdr, ESP, SPI);
 				}
 
-				rte_memcpy(hdr->buffer, &esp_spec->hdr,
+				memcpy(hdr->buffer, &esp_spec->hdr,
 					sizeof(esp_spec->hdr));
 			}
 
@@ -1418,7 +1418,7 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 					VIRTCHNL_ADD_PROTO_HDR_FIELD_BIT(hdr, AH, SPI);
 				}
 
-				rte_memcpy(hdr->buffer, ah_spec,
+				memcpy(hdr->buffer, ah_spec,
 					sizeof(*ah_spec));
 			}
 
@@ -1439,7 +1439,7 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 					VIRTCHNL_ADD_PROTO_HDR_FIELD_BIT(hdr, PFCP, S_FIELD);
 				}
 
-				rte_memcpy(hdr->buffer, pfcp_spec,
+				memcpy(hdr->buffer, pfcp_spec,
 					sizeof(*pfcp_spec));
 			}
 
@@ -1464,7 +1464,7 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 									 PC_RTC_ID);
 				}
 
-				rte_memcpy(hdr->buffer, ecpri_spec,
+				memcpy(hdr->buffer, ecpri_spec,
 					sizeof(*ecpri_spec));
 			}
 
@@ -1480,7 +1480,7 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 			VIRTCHNL_SET_PROTO_HDR_TYPE(hdr, GRE);
 
 			if (gre_spec && gre_mask) {
-				rte_memcpy(hdr->buffer, gre_spec,
+				memcpy(hdr->buffer, gre_spec,
 					   sizeof(*gre_spec));
 			}
 
@@ -1529,7 +1529,7 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 								SESS_ID);
 				}
 
-				rte_memcpy(hdr->buffer, l2tpv2_spec,
+				memcpy(hdr->buffer, l2tpv2_spec,
 					   sizeof(*l2tpv2_spec));
 			}
 
@@ -1547,7 +1547,7 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 			VIRTCHNL_SET_PROTO_HDR_TYPE(hdr, PPP);
 
 			if (ppp_spec && ppp_mask) {
-				rte_memcpy(hdr->buffer, ppp_spec,
+				memcpy(hdr->buffer, ppp_spec,
 					   sizeof(*ppp_spec));
 			}
 
diff --git a/drivers/net/intel/iavf/iavf_fsub.c b/drivers/net/intel/iavf/iavf_fsub.c
index bfb34695de..50046af96a 100644
--- a/drivers/net/intel/iavf/iavf_fsub.c
+++ b/drivers/net/intel/iavf/iavf_fsub.c
@@ -92,7 +92,7 @@ iavf_fsub_create(struct iavf_adapter *ad, struct rte_flow *flow,
 		goto free_entry;
 	}
 
-	rte_memcpy(rule, filter, sizeof(*rule));
+	memcpy(rule, filter, sizeof(*rule));
 	flow->rule = rule;
 
 	rte_free(meta);
@@ -280,9 +280,9 @@ iavf_fsub_parse_pattern(const struct rte_flow_item pattern[],
 					input_set_byte += 2;
 				}
 
-				rte_memcpy(hdr1->buffer_spec, eth_spec,
+				memcpy(hdr1->buffer_spec, eth_spec,
 					   sizeof(struct rte_ether_hdr));
-				rte_memcpy(hdr1->buffer_mask, eth_mask,
+				memcpy(hdr1->buffer_mask, eth_mask,
 					   sizeof(struct rte_ether_hdr));
 			} else {
 				/* flow subscribe filter will add dst mac in kernel */
@@ -333,9 +333,9 @@ iavf_fsub_parse_pattern(const struct rte_flow_item pattern[],
 					input_set_byte++;
 				}
 
-				rte_memcpy(hdr->buffer_spec, &ipv4_spec->hdr,
+				memcpy(hdr->buffer_spec, &ipv4_spec->hdr,
 					   sizeof(ipv4_spec->hdr));
-				rte_memcpy(hdr->buffer_mask, &ipv4_mask->hdr,
+				memcpy(hdr->buffer_mask, &ipv4_mask->hdr,
 					   sizeof(ipv4_spec->hdr));
 			}
 
@@ -396,9 +396,9 @@ iavf_fsub_parse_pattern(const struct rte_flow_item pattern[],
 					input_set_byte += 4;
 				}
 
-				rte_memcpy(hdr->buffer_spec, &ipv6_spec->hdr,
+				memcpy(hdr->buffer_spec, &ipv6_spec->hdr,
 					   sizeof(ipv6_spec->hdr));
-				rte_memcpy(hdr->buffer_mask, &ipv6_mask->hdr,
+				memcpy(hdr->buffer_mask, &ipv6_mask->hdr,
 					   sizeof(ipv6_spec->hdr));
 			}
 
@@ -433,9 +433,9 @@ iavf_fsub_parse_pattern(const struct rte_flow_item pattern[],
 					input_set_byte += 2;
 				}
 
-				rte_memcpy(hdr->buffer_spec, &udp_spec->hdr,
+				memcpy(hdr->buffer_spec, &udp_spec->hdr,
 					   sizeof(udp_spec->hdr));
-				rte_memcpy(hdr->buffer_mask, &udp_mask->hdr,
+				memcpy(hdr->buffer_mask, &udp_mask->hdr,
 					   sizeof(udp_mask->hdr));
 			}
 
@@ -474,9 +474,9 @@ iavf_fsub_parse_pattern(const struct rte_flow_item pattern[],
 					input_set_byte += 2;
 				}
 
-				rte_memcpy(hdr->buffer_spec, &tcp_spec->hdr,
+				memcpy(hdr->buffer_spec, &tcp_spec->hdr,
 					   sizeof(tcp_spec->hdr));
-				rte_memcpy(hdr->buffer_mask, &tcp_mask->hdr,
+				memcpy(hdr->buffer_mask, &tcp_mask->hdr,
 					   sizeof(tcp_mask->hdr));
 			}
 
@@ -506,9 +506,9 @@ iavf_fsub_parse_pattern(const struct rte_flow_item pattern[],
 					return -rte_errno;
 				}
 
-				rte_memcpy(hdr->buffer_spec, &vlan_spec->hdr,
+				memcpy(hdr->buffer_spec, &vlan_spec->hdr,
 					   sizeof(vlan_spec->hdr));
-				rte_memcpy(hdr->buffer_mask, &vlan_mask->hdr,
+				memcpy(hdr->buffer_mask, &vlan_mask->hdr,
 					   sizeof(vlan_mask->hdr));
 			}
 
diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
index 42ecc90d1d..2a9f3a8acb 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.c
+++ b/drivers/net/intel/iavf/iavf_generic_flow.c
@@ -2016,7 +2016,7 @@ iavf_pattern_skip_void_item(struct rte_flow_item *items,
 		pe = iavf_find_first_item(pb + 1, true);
 
 		cpy_count = pe - pb;
-		rte_memcpy(items, pb, sizeof(struct rte_flow_item) * cpy_count);
+		memcpy(items, pb, sizeof(struct rte_flow_item) * cpy_count);
 
 		items += cpy_count;
 
@@ -2026,7 +2026,7 @@ iavf_pattern_skip_void_item(struct rte_flow_item *items,
 		pb = pe + 1;
 	}
 	/* Copy the END item. */
-	rte_memcpy(items, pe, sizeof(struct rte_flow_item));
+	memcpy(items, pe, sizeof(struct rte_flow_item));
 }
 
 /* Check if the pattern matches a supported item type array */
diff --git a/drivers/net/intel/iavf/iavf_hash.c b/drivers/net/intel/iavf/iavf_hash.c
index cb10eeab78..e9ea2a8401 100644
--- a/drivers/net/intel/iavf/iavf_hash.c
+++ b/drivers/net/intel/iavf/iavf_hash.c
@@ -953,8 +953,8 @@ iavf_hash_parse_raw_pattern(const struct rte_flow_item *item,
 			msk_buf[j] = tmp_val * 16 + tmp_c - '0';
 	}
 
-	rte_memcpy(meta->proto_hdrs.raw.spec, pkt_buf, pkt_len);
-	rte_memcpy(meta->proto_hdrs.raw.mask, msk_buf, pkt_len);
+	memcpy(meta->proto_hdrs.raw.spec, pkt_buf, pkt_len);
+	memcpy(meta->proto_hdrs.raw.mask, msk_buf, pkt_len);
 	meta->proto_hdrs.raw.pkt_len = pkt_len;
 
 	rte_free(pkt_buf);
diff --git a/drivers/net/intel/iavf/iavf_tm.c b/drivers/net/intel/iavf/iavf_tm.c
index 1d12196ba6..54ec6e9750 100644
--- a/drivers/net/intel/iavf/iavf_tm.c
+++ b/drivers/net/intel/iavf/iavf_tm.c
@@ -342,7 +342,7 @@ iavf_tm_node_add(struct rte_eth_dev *dev, uint32_t node_id,
 		tm_node->id = node_id;
 		tm_node->parent = NULL;
 		tm_node->reference_count = 0;
-		rte_memcpy(&tm_node->params, params,
+		memcpy(&tm_node->params, params,
 				 sizeof(struct rte_tm_node_params));
 		vf->tm_conf.root = tm_node;
 		return 0;
@@ -403,7 +403,7 @@ iavf_tm_node_add(struct rte_eth_dev *dev, uint32_t node_id,
 	tm_node->reference_count = 0;
 	tm_node->parent = parent_node;
 	tm_node->shaper_profile = shaper_profile;
-	rte_memcpy(&tm_node->params, params,
+	memcpy(&tm_node->params, params,
 			 sizeof(struct rte_tm_node_params));
 	if (parent_node_type == IAVF_TM_NODE_TYPE_PORT) {
 		TAILQ_INSERT_TAIL(&vf->tm_conf.tc_list,
@@ -543,7 +543,7 @@ iavf_shaper_profile_add(struct rte_eth_dev *dev,
 	if (!shaper_profile)
 		return -ENOMEM;
 	shaper_profile->shaper_profile_id = shaper_profile_id;
-	rte_memcpy(&shaper_profile->profile, profile,
+	memcpy(&shaper_profile->profile, profile,
 			 sizeof(struct rte_tm_shaper_params));
 	TAILQ_INSERT_TAIL(&vf->tm_conf.shaper_profile_list,
 			  shaper_profile, node);
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 08dd6f2d7f..14bd869be4 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -112,7 +112,7 @@ iavf_dev_event_post(struct rte_eth_dev *dev,
 	elem->param = param;
 	elem->param_alloc_size = param_alloc_size;
 	if (param && param_alloc_size) {
-		rte_memcpy(elem->param_alloc_data, param, param_alloc_size);
+		memcpy(elem->param_alloc_data, param, param_alloc_size);
 		elem->param = elem->param_alloc_data;
 	}
 
@@ -732,7 +732,7 @@ iavf_get_vf_resource(struct iavf_adapter *adapter)
 	len =  sizeof(struct virtchnl_vf_resource) +
 		      IAVF_MAX_VF_VSI * sizeof(struct virtchnl_vsi_resource);
 
-	rte_memcpy(vf->vf_res, args.out_buffer,
+	memcpy(vf->vf_res, args.out_buffer,
 		   RTE_MIN(args.out_size, len));
 	/* parse  VF config message back from PF*/
 	iavf_vf_parse_hw_config(hw, vf->vf_res);
@@ -921,7 +921,7 @@ iavf_get_vlan_offload_caps_v2(struct iavf_adapter *adapter)
 		return ret;
 	}
 
-	rte_memcpy(&vf->vlan_v2_caps, vf->aq_resp, sizeof(vf->vlan_v2_caps));
+	memcpy(&vf->vlan_v2_caps, vf->aq_resp, sizeof(vf->vlan_v2_caps));
 
 	return 0;
 }
@@ -1151,7 +1151,7 @@ iavf_configure_rss_lut(struct iavf_adapter *adapter)
 
 	rss_lut->vsi_id = vf->vsi_res->vsi_id;
 	rss_lut->lut_entries = vf->vf_res->rss_lut_size;
-	rte_memcpy(rss_lut->lut, vf->rss_lut, vf->vf_res->rss_lut_size);
+	memcpy(rss_lut->lut, vf->rss_lut, vf->vf_res->rss_lut_size);
 
 	args.ops = VIRTCHNL_OP_CONFIG_RSS_LUT;
 	args.in_args = (u8 *)rss_lut;
@@ -1183,7 +1183,7 @@ iavf_configure_rss_key(struct iavf_adapter *adapter)
 
 	rss_key->vsi_id = vf->vsi_res->vsi_id;
 	rss_key->key_len = vf->vf_res->rss_key_size;
-	rte_memcpy(rss_key->key, vf->rss_key, vf->vf_res->rss_key_size);
+	memcpy(rss_key->key, vf->rss_key, vf->vf_res->rss_key_size);
 
 	args.ops = VIRTCHNL_OP_CONFIG_RSS_KEY;
 	args.in_args = (u8 *)rss_key;
@@ -1574,7 +1574,7 @@ iavf_add_del_eth_addr(struct iavf_adapter *adapter, struct rte_ether_addr *addr,
 	list->vsi_id = vf->vsi_res->vsi_id;
 	list->num_elements = 1;
 	list->list[0].type = type;
-	rte_memcpy(list->list[0].addr, addr->addr_bytes,
+	memcpy(list->list[0].addr, addr->addr_bytes,
 		   sizeof(addr->addr_bytes));
 
 	args.ops = add ? VIRTCHNL_OP_ADD_ETH_ADDR : VIRTCHNL_OP_DEL_ETH_ADDR;
@@ -2001,7 +2001,7 @@ iavf_get_qos_cap(struct iavf_adapter *adapter)
 	len =  sizeof(struct virtchnl_qos_cap_list) +
 		IAVF_MAX_TRAFFIC_CLASS * sizeof(struct virtchnl_qos_cap_elem);
 
-	rte_memcpy(vf->qos_cap, args.out_buffer,
+	memcpy(vf->qos_cap, args.out_buffer,
 		   RTE_MIN(args.out_size, len));
 
 	return 0;
-- 
2.51.0

