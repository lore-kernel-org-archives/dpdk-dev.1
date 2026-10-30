Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA22606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RLN2PQP/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59B0240A89;
	Fri, 30 Oct 2026 10:41:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTPS id C2DC040A89
 for <dev@dpdk.org>; Fri, 30 Oct 2026 10:40:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793353259; x=1824889259;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Tizyz8qkSABDp63hCmH6Lxzfsc+65fE230C5u2GGmb8=;
 b=RLN2PQP/q8XJqx7bxBxIOL7pJnJDdC3xao945DNi1xsOmlEezpRfTdnR
 C+rWQlh4ZE6n7INNlhjMKS8Tq4kLpFOJgAX/U1xmr4Oqdm4h7vvfqY0TD
 FpfC2TZ4Ps+2rGCbrbIpheUw1+R/UDn8NoBAF6Hpw+I29X6q51P1OiqpG
 P3ITFFzHT+r5GuEtfxKiLGqsozkoz2Zj049lYUP/2jYA7WnthyJDGqsuz
 53xC/bKi/hWsusfLfuYIH+Hxh0UWbTufPERgZ+OoeM4wg4+onYVnFx1oR
 3R6uSM3NuPjCy3Uuf2fYOTkoNXcqu3rLjW0ljYBQsH+S2Y34ImFxVKwi9 w==;
X-CSE-ConnectionGUID: jvrfDpb2RqKQcSDwxiJNHQ==
X-CSE-MsgGUID: 2qlH1g7SQJarcFbvYGztuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2126050"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2126050"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 02:40:58 -0700
X-CSE-ConnectionGUID: ePsHLE2mRT+CkVFob2chgA==
X-CSE-MsgGUID: wp2CJxiZTZO+4ErHA06nwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5299619"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 30 Oct 2026 02:40:58 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 5/9] net/i40e: validate IPv4 fragment offset without range
Date: Fri, 30 Oct 2026 09:40:18 +0000
Message-ID: <1fe69edc69542560f60b3e0399ff1b36882337cf.1793353214.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <5e64cc416c8ab3b038eee6bb55836e0b8ed507ab.1793353214.git.anatoly.burakov@intel.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The FDIR IPv4 node only checked fragment_offset when the item had a
range. Without one, any fragment_offset mask and spec were accepted and
then ignored, so the rule was installed as a non-fragmented IPv4 rule.
The old parser rejected these.

Check fragment_offset whether or not a range is given.

Fixes: 05432a6e4676 ("net/i40e: reimplement FDIR parser")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow_fdir.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow_fdir.c b/drivers/net/intel/i40e/i40e_flow_fdir.c
index ba8c18250c8..0c9dce6fd9d 100644
--- a/drivers/net/intel/i40e/i40e_flow_fdir.c
+++ b/drivers/net/intel/i40e/i40e_flow_fdir.c
@@ -257,11 +257,9 @@ i40e_fdir_node_ipv4_validate(const void *ctx __rte_unused, const struct rte_flow
 				"Invalid IPv4 header mask");
 	}
 
-	if (ipv4_last == NULL)
-		return 0;
-
 	/* Only fragment_offset supports range */
-	if (ipv4_last->hdr.version_ihl ||
+	if (ipv4_last != NULL &&
+	    (ipv4_last->hdr.version_ihl ||
 	    ipv4_last->hdr.type_of_service ||
 	    ipv4_last->hdr.total_length ||
 	    ipv4_last->hdr.packet_id ||
@@ -269,16 +267,25 @@ i40e_fdir_node_ipv4_validate(const void *ctx __rte_unused, const struct rte_flow
 	    ipv4_last->hdr.next_proto_id ||
 	    ipv4_last->hdr.hdr_checksum ||
 	    ipv4_last->hdr.src_addr ||
-	    ipv4_last->hdr.dst_addr) {
+	    ipv4_last->hdr.dst_addr)) {
 		return rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_ITEM, item,
 				"IPv4 range only supported for fragment_offset");
 	}
 
-	/* Validate fragment_offset range values */
+	/* Validate fragment_offset values */
 	uint16_t frag_mask = rte_be_to_cpu_16(ipv4_mask->hdr.fragment_offset);
 	uint16_t frag_spec = rte_be_to_cpu_16(ipv4_spec->hdr.fragment_offset);
-	uint16_t frag_last = rte_be_to_cpu_16(ipv4_last->hdr.fragment_offset);
+	uint16_t frag_last = ipv4_last != NULL ?
+			rte_be_to_cpu_16(ipv4_last->hdr.fragment_offset) : 0;
+
+	if (frag_mask == 0) {
+		if (ipv4_last == NULL)
+			return 0; /* fragment_offset not matched */
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"IPv4 fragment_offset range requires a mask");
+	}
 
 	/* Mask must be 0x3fff (fragment offset + MF flag) */
 	if (frag_mask != (RTE_IPV4_HDR_OFFSET_MASK | RTE_IPV4_HDR_MF_FLAG)) {
-- 
2.52.0

