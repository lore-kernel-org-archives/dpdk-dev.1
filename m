Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EC0E9E302
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:04:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC7304065B;
	Wed, 11 Feb 2026 14:04:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 9ED0040663
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:04:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770815055; x=1802351055;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=z7diHGNt++cT5woFQfm8GFwgCBla9nt3aHQi0eDDeOc=;
 b=nj1Gz0vH4IGKs3SIg6cP5GbBhvUgPOKP0B0rw7H0qzfrG8zyHV4LoNoA
 kmKf/a9rJGhnRNxhci+Z1Tv46MEnDyKQWIbiTmeHyz0wbDiLbpYFydF+J
 VuCH+9+FhZTxSP9OEe6R+KQ7AGVkBpRYJrjQAt1Kqks22/Mj6jNGK+r5K
 masng2rMqPKmGX3VQWhKeOitNPcKg5qba+Klh4R6vX3FedekxzZh04Yaq
 J6HrkGeVHLg3exduSKknsSy/Q0IPsyA2QXeuM+wj7XH4mEYZu1tH8EvtR
 CsGfzDiYf1X9gIvot65BNQLUZmYcmR1C9j8aJmDN5fucvRWDholC7SLxx w==;
X-CSE-ConnectionGUID: BkeykCaBSHe2XAp8DAKIxA==
X-CSE-MsgGUID: Kz2+TUbfQcG9Ha+HrBgahQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="59529078"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="59529078"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:04:14 -0800
X-CSE-ConnectionGUID: zggfCxZfR4Oh0gJDAy9v7Q==
X-CSE-MsgGUID: 2v6IT3bSRFeOH3UpWtGW8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="217206419"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 11 Feb 2026 05:04:13 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jie Wang <jie1x.wang@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH v3 6/8] net/iavf: fix IPv4 flow subscription
Date: Wed, 11 Feb 2026 13:03:51 +0000
Message-ID: <f4b1d40a7f7255c93e58449a581c6e4c2f7b4977.1770814868.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770814868.git.anatoly.burakov@intel.com>
 <cover.1770814868.git.anatoly.burakov@intel.com>
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

