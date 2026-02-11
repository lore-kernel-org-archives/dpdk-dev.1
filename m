Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B39BE9E30A
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:50:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5A424067A;
	Wed, 11 Feb 2026 14:49:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 6CC86402B5
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:49:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770817780; x=1802353780;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=z7diHGNt++cT5woFQfm8GFwgCBla9nt3aHQi0eDDeOc=;
 b=j3QPRUeumoRF+jj6F3iX9t6st4X3xXg3S/bIqVkxN8jk4kFIfwSnaXIw
 u3bNwjvIVQUd6uPezcsa2p7hdcid/7jl4Dg+pPpyLkaDsFPLeqKReJrn8
 n2K43axzEaBZ92NIUqKsNeZpmQixXrXiXnTQYS8a9zoWPLMy7IhFczOm0
 IIXw+k2086Ancd2BSo/K6NBP+DDOZ89aNm5TYdDBdyyPHWcKLBlJWwu1G
 E4rrktyPM7M9k5RdL/C99r7R99IUKGLLExPyOOV/nXk6UjmHSf8mABmS0
 aaipEsjo2P13WI42Udp2GetcDvzKfePHm+KIG9LfPjsMlNZtU6Q6rQy2E Q==;
X-CSE-ConnectionGUID: CX2XblSYTFmaK5dUD/yWFg==
X-CSE-MsgGUID: FVCV7lVTRnGyWDt+ODgsVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="83332526"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="83332526"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:49:40 -0800
X-CSE-ConnectionGUID: hIBuC+lrQVKK55xD0M5LAg==
X-CSE-MsgGUID: lI3AR8mTTm2kvAlqRlZb2w==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 11 Feb 2026 05:49:39 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jie Wang <jie1x.wang@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH v4 7/9] net/iavf: fix IPv4 flow subscription
Date: Wed, 11 Feb 2026 13:49:14 +0000
Message-ID: <72142464577caf4c78dff27ed7514be8a4dcbca6.1770817694.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770817694.git.anatoly.burakov@intel.com>
 <cover.1770817694.git.anatoly.burakov@intel.com>
References: 
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

Currently, when IPv4 is parsed as part of flow subscription input set, we
add two bytes to the total number of bytes in the input set for IPv4 source
or destination addresses, whereas they should be 4 bytes. Fix to add the
correct number of bytes.

Fixes: 6d42380e5983 ("net/iavf: add flow subscrption supported pattern")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_fsub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_fsub.c b/drivers/net/intel/iavf/iavf_fsub.c
index 18df9c6500..cf1030320f 100644
--- a/drivers/net/intel/iavf/iavf_fsub.c
+++ b/drivers/net/intel/iavf/iavf_fsub.c
@@ -314,11 +314,11 @@ iavf_fsub_parse_pattern(const struct rte_flow_item pattern[],
 
 				if (ipv4_mask->hdr.src_addr) {
 					*input |= IAVF_INSET_IPV4_SRC;
-					input_set_byte += 2;
+					input_set_byte += 4;
 				}
 				if (ipv4_mask->hdr.dst_addr) {
 					*input |= IAVF_INSET_IPV4_DST;
-					input_set_byte += 2;
+					input_set_byte += 4;
 				}
 				if (ipv4_mask->hdr.time_to_live) {
 					*input |= IAVF_INSET_IPV4_TTL;
-- 
2.47.3

