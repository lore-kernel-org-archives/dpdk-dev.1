Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159BECD98CF
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 10:28:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B55F40E24;
	Tue, 16 Jun 2026 12:28:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 6D77340DF8
 for <dev@dpdk.org>; Tue, 16 Jun 2026 12:28:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781605682; x=1813141682;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JsWMG53Dw/myKazbfXudAykzDQcXHPI+1SXmYVE2KQE=;
 b=eAwsZYsneXvfiXu2QZrn7Xjs7vTUxBDL7L0bywABXYG9qosH0rmNZnCf
 ekFXfsYa3ad443MAEtXWbaVOXImNm/QInHxquOt+zemUBsVgO2rdjf0J5
 d1nx2fYWoMKJ+8B7ELzqDc1xhdi70oTKoZzWNS2tn7AujtPcGry0qstp5
 BTgrcI3VYLKp7LT08OGMUt6ZRDmduNkoUAbzCXQc1BXEcXd6ZNtOx4Nbp
 hH6KR1q7NglzLHQPPVrLjd9NhYCTUwKZWoyRAf9DhP20sNYi8u3Vkj2qS
 4RjOVndn7GRcNOVuGT/XCTwN9zOR8L5PYjEsA5aj2TqxESkVI1lA4dUjL g==;
X-CSE-ConnectionGUID: XJ5B9eh5TY6fuKXCCCTcxQ==
X-CSE-MsgGUID: pkoaKDt/Tjye98uEcA4e9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="86005066"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; d="scan'208";a="86005066"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 03:27:49 -0700
X-CSE-ConnectionGUID: /dTKa9rKQE66qB2QVstdjA==
X-CSE-MsgGUID: Me8j49xESSK7dChgVwetkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; d="scan'208";a="252856743"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 16 Jun 2026 03:27:41 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Ori Kam <orika@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v1 1/2] app/testpmd: mask VLAN TCI when specified
Date: Tue, 16 Jun 2026 11:27:38 +0100
Message-ID: <00f78873fdb3d48542a7226e68a94e74cab4d8c0.1781605650.git.anatoly.burakov@intel.com>
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

Currently, when testpmd command `...vlan tci is 0x1234`, the VLAN TCI field
is being specified in spec, but is not masked in mask. Add full mask to
VLAN TCI when specified.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test-pmd/cmdline_flow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index 67f200f2e3..0b7d268535 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -4610,7 +4610,8 @@ static const struct token token_list[] = {
 		.help = "tag control information",
 		.next = NEXT(item_vlan, NEXT_ENTRY(COMMON_UNSIGNED),
 			     item_param),
-		.args = ARGS(ARGS_ENTRY_HTON(struct rte_flow_item_vlan, hdr.vlan_tci)),
+		.args = ARGS(ARGS_ENTRY_MASK_HTON(struct rte_flow_item_vlan,
+					  hdr.vlan_tci, "\xff\xff")),
 	},
 	[ITEM_VLAN_PCP] = {
 		.name = "pcp",
-- 
2.47.3

