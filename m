Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13681CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 03:20:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14A044042F;
	Wed,  5 Nov 2025 04:20:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 0F383402EB;
 Wed,  5 Nov 2025 04:20:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762312843; x=1793848843;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WVerYD5mooI3IBAcOBTmJa5K/67CnpPkJa912g9NcrI=;
 b=dlsJTCU6BPFoz/D00qd8QSeFATjeRd2lNeaB8aJsuizHzQ0NSNFYrDXu
 v2Llywilecw5R/1+DMI0uLVfVZGFnScVudSbRXdt+qXyf8wlxC0VOWO8b
 G2HMalrNtJlr4/huwH33FrhFsTvglvLV9Ni5BCabNSTCaXlOmxuzPF+Jr
 B6pwEiUaHSejQy5r+jvZ0wakePv0C8paGJqr3zNwCOipTBLMZlnyiGl2V
 ky02h+zjBs0mxbAppyMbwJ5pd2kaj8MtAomkB+Ge2yqJBtdoPXLI65HJc
 7n6aoplC+ZvJagSL/laLzOvIzxBT99zHoq/3RAocoxX1VpCunBadQU9XL Q==;
X-CSE-ConnectionGUID: 9PWutgEvQlO6p0OfGw/2hg==
X-CSE-MsgGUID: e9W+D0LkRUWiFH5JFwkMEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="63624381"
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; d="scan'208";a="63624381"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 19:20:42 -0800
X-CSE-ConnectionGUID: BNmVPzJBSouzGCx3paJO/w==
X-CSE-MsgGUID: ac1RCpKgT7mWv5BnF0PWgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; d="scan'208";a="187277482"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.253])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 19:20:41 -0800
From: Mingjin Ye <mingjinx.ye@intel.com>
To: dev@dpdk.org
Cc: Mingjin Ye <mingjinx.ye@intel.com>, stable@dpdk.org,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH 1/2] app/testpmd: revert L4 protocol retrieval from L3 header
Date: Wed,  5 Nov 2025 02:47:23 +0000
Message-Id: <20251105024724.830304-2-mingjinx.ye@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251105024724.830304-1-mingjinx.ye@intel.com>
References: <20251105024724.830304-1-mingjinx.ye@intel.com>
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

This reverts commit 496159613ffc7b6ba592432a1ba4d1a38f6935de.

When the TX IP checksum offload feature is enabled, it may result in
internal UDP checksum errors in VXLAN tunnel packets.

Fixes: 496159613ffc ("app/testpmd: fix L4 protocol retrieval from L3 header")
Cc: stable@dpdk.org

Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
---
 app/test-pmd/csumonly.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
index a6e872e5a4..d355dbd8c0 100644
--- a/app/test-pmd/csumonly.c
+++ b/app/test-pmd/csumonly.c
@@ -525,8 +525,20 @@ get_tunnel_ol_flags_by_ptype(uint32_t ptype)
 	}
 }
 
+static void
+parse_inner_l4_proto(void *outer_l3_hdr,
+			struct testpmd_offload_info *info)
+{
+	struct rte_ipv4_hdr *ipv4_hdr = outer_l3_hdr;
+	struct rte_ipv6_hdr *ipv6_hdr = outer_l3_hdr;
+	if (info->ethertype == _htons(RTE_ETHER_TYPE_IPV4))
+		info->l4_proto = ipv4_hdr->next_proto_id;
+	else
+		info->l4_proto = ipv6_hdr->proto;
+}
+
 static uint8_t
-parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype, bool parse_inner)
+parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype)
 {
 	int frag = 0, ret;
 
@@ -545,19 +557,16 @@ parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype, bool pars
 		if (unlikely(ip6h == NULL))
 			return 0;
 
-		if (!parse_inner && (ptype & RTE_PTYPE_L3_MASK) != RTE_PTYPE_L3_IPV6_EXT)
-			return ip6h->proto;
-
-		if (parse_inner && (ptype & RTE_PTYPE_INNER_L3_MASK) != RTE_PTYPE_INNER_L3_IPV6_EXT)
-			return ip6h->proto;
+		if ((ptype & RTE_PTYPE_INNER_L3_MASK) ==
+				RTE_PTYPE_INNER_L3_IPV6_EXT) {
+			ret = rte_net_skip_ip6_ext(ip6h->proto, m, &off, &frag);
+			if (ret < 0)
+				return 0;
+			return ret;
+		}
 
-		off += sizeof(struct rte_ipv6_hdr);
-		ret = rte_net_skip_ip6_ext(ip6h->proto, m, &off, &frag);
-		if (ret < 0)
-			return 0;
-		return ret;
+		return ip6h->proto;
 	}
-
 	return 0;
 }
 
@@ -696,7 +705,7 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
 		info.l4_len = hdr_lens.l4_len;
 		info.ethertype = get_ethertype_by_ptype(eth_hdr,
 					ptype & RTE_PTYPE_L3_MASK);
-		info.l4_proto = parse_l4_proto(m, info.l2_len, ptype, false);
+		info.l4_proto = parse_l4_proto(m, info.l2_len, ptype);
 
 		l3_hdr = (char *)eth_hdr + info.l2_len;
 		/* check if it's a supported tunnel */
@@ -714,11 +723,9 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
 		}
 		/* update l3_hdr and outer_l3_hdr if a tunnel was parsed */
 		if (info.is_tunnel) {
-			uint16_t l3_off = info.outer_l2_len +  info.outer_l3_len + info.l2_len;
-
 			outer_l3_hdr = l3_hdr;
 			l3_hdr = (char *)l3_hdr + info.outer_l3_len + info.l2_len;
-			info.l4_proto = parse_l4_proto(m, l3_off, ptype, true);
+			parse_inner_l4_proto(l3_hdr, &info);
 		}
 		/* step 2: depending on user command line configuration,
 		 * recompute checksum either in software or flag the
-- 
2.25.1

