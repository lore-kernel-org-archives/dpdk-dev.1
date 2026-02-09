Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D580BE81BBB
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 13:22:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B85040613;
	Mon,  9 Feb 2026 14:22:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 551EC402C6
 for <dev@dpdk.org>; Mon,  9 Feb 2026 14:22:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770643368; x=1802179368;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=z7diHGNt++cT5woFQfm8GFwgCBla9nt3aHQi0eDDeOc=;
 b=Fbxs7rnYVm7/6/M8fuYdgzKJOriGaLjuNbj+cS5GhIV6e0A1VAxDmm42
 PAL4zUhdeuvJwc7LxVF+0gj0qF0pWRrBbBaZ+9KgEYeT7eMxlnvjH+FN9
 WYtZ3YdrU8ZaDIHcxi7KULvCq7+yI0pl4KIZa/Soiy2qxS3E5pB318Rya
 wP9qEvUuTS9KofELyIPTh/upudgT/EoKYr54gQCNrmPsafbQgfvA6LwlQ
 7h0rsjAMES7ZBcIZuqVEgcuDapia+Rdxk0R1Ug3j1HfeWA0oCPDUO5vWi
 wmfaHFQxBJfuNjvcrfh4hwKULg/A34UMKu/wctuiJb69L1/1qyDDXEV2C A==;
X-CSE-ConnectionGUID: Krz4EpbKT3OxsnY3GgwbAQ==
X-CSE-MsgGUID: r4WrVHNiSB20wLNFeVLEiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="89170712"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="89170712"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 05:22:47 -0800
X-CSE-ConnectionGUID: hkzH2a+XTlynI5+ct8LkgA==
X-CSE-MsgGUID: EItw+4uvTUmMqDIGGq5/dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="210754615"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa006.fm.intel.com with ESMTP; 09 Feb 2026 05:22:45 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Jie Wang <jie1x.wang@intel.com>
Subject: [PATCH v1 1/1] net/iavf: fix IPv4 flow subscription
Date: Mon,  9 Feb 2026 13:22:43 +0000
Message-ID: <fbd32a8a688fd0ed90fcf497703edcc30f69d54d.1770643356.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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

