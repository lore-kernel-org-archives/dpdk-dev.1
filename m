Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19980CD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 10:28:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10DB7406BC;
	Tue, 16 Jun 2026 12:28:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id C4F3740DF8
 for <dev@dpdk.org>; Tue, 16 Jun 2026 12:28:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781605682; x=1813141682;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=6MpPggj45bjhXbMrn5Wvufv+MVCiRo2eZHDjPUbKuvA=;
 b=F9/3vn4Giz3KBmRiNrcKY9JI9K8Y33RI5pjkP1rkdnAhDverZJpZyveK
 YVWBEu6D89vkDdapC7VbgLjJyLn7wa8VZnNv32NgQM7UQb8bJ5W92xUnn
 d1qmFJI2FVIJuFSY4IvTFsD2lD/+m2oKIv9xOBi6C8lBc4riG/UFREjdc
 9SI/UfPfA5QZt/Nk00jgFWd4lJJdrtNrAaqzkFbze3hrGDrzCg6WDArWX
 FenY8ptGQK8OM7X6Crmq6l1cddEnzX3nLXFeMBqbd2rs0CM0A+itDF9ZX
 8F7nfzmDVrNmHPcakri5ZbTtkx5zZ9GI42Z9EoKV5wmHPkbsZmi31q7VO w==;
X-CSE-ConnectionGUID: xbmDPC1ZR8KSx13E6ov/kw==
X-CSE-MsgGUID: 44ZqropITfCSrn/U0l2oXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="86005060"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; d="scan'208";a="86005060"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 03:27:48 -0700
X-CSE-ConnectionGUID: rUJJ0+zLSfycnV8gyGdfFQ==
X-CSE-MsgGUID: 6/N5CpFhQ/KkIawgQw6dCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; d="scan'208";a="252856745"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 16 Jun 2026 03:27:42 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Ori Kam <orika@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v1 2/2] app/testpmd: mask VLAN inner type when specified
Date: Tue, 16 Jun 2026 11:27:39 +0100
Message-ID: <1b9982be74ec151a7405d471808d8dbc19321f31.1781605651.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <00f78873fdb3d48542a7226e68a94e74cab4d8c0.1781605650.git.anatoly.burakov@intel.com>
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

Currently, when testpmd command `...vlan inner_type is 0x1234`, the VLAN
inner type field is being specified in spec, but is not masked in mask.
Add full mask to VLAN inner type when specified.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test-pmd/cmdline_flow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index 0b7d268535..e41ab0ef9b 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -4642,8 +4642,8 @@ static const struct token token_list[] = {
 		.help = "inner EtherType",
 		.next = NEXT(item_vlan, NEXT_ENTRY(COMMON_UNSIGNED),
 			     item_param),
-		.args = ARGS(ARGS_ENTRY_HTON(struct rte_flow_item_vlan,
-					     hdr.eth_proto)),
+		.args = ARGS(ARGS_ENTRY_MASK_HTON(struct rte_flow_item_vlan,
+						  hdr.eth_proto, "\xff\xff")),
 	},
 	[ITEM_VLAN_HAS_MORE_VLAN] = {
 		.name = "has_more_vlan",
-- 
2.47.3

