Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF76EB491F
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 12:54:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64187409FA;
	Thu, 12 Feb 2026 13:54:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id C4E04406A2
 for <dev@dpdk.org>; Thu, 12 Feb 2026 13:53:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770900838; x=1802436838;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=uPE33KVplWCde1icdrjFxNtpLc/I37yxXvzHVuzaT3g=;
 b=TtkVKorI0BiGEVf1EIR/2J8HvS9jM7Ru9PeWrJddAw/Kic/9FSI8RjOC
 aOdGxnxAlfhjrOzkpFrj83H6AjaWHwcH66kgZ2PZpvHXD4WjdyMoeE3PX
 HggM7Y6QxYVbByvWzZ2zV9uCbl8vfCSJn3D1h+/ukj17jAjWY01uY9onb
 nlYWLSbtdRhWaMkYKDoJ5nHQdkUIgw0Bkj17QzSJS6OKFjxhx2wlUYInp
 YIsjxAnhp7oYEjZQdo8pBjhSPqtewoGi9Sgy1HRRbzXVqJfc9/WhA862t
 FrFMcv3Uir0HxGGoaQIKFWRNRx94kSpFBQ8OcRVRUMOxWQaVmJ78XPCCy g==;
X-CSE-ConnectionGUID: jjONODY1QNKFAYvVfc7GBw==
X-CSE-MsgGUID: yjGlVWx2S/SJKHwdJp1FrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71785497"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="71785497"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:53:58 -0800
X-CSE-ConnectionGUID: yv1TFCHkQT24fJxYEArtKA==
X-CSE-MsgGUID: 2J7LpVmFRCiHhBZ341vziw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="243179194"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 12 Feb 2026 04:53:56 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Jie Wang <jie1x.wang@intel.com>
Subject: [PATCH v5 10/12] net/iavf: fix IPv4 flow subscription
Date: Thu, 12 Feb 2026 12:53:33 +0000
Message-ID: <03c03e386e2b3d8b313be999a214adf838a27b4b.1770900758.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770900757.git.anatoly.burakov@intel.com>
 <cover.1770900757.git.anatoly.burakov@intel.com>
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
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
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

