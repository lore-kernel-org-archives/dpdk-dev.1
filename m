Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF209CDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 15:48:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D056940A7F;
	Thu, 25 Jun 2026 17:48:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 8C7C540616
 for <dev@dpdk.org>; Thu, 25 Jun 2026 17:48:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782402498; x=1813938498;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=pAOyyHFnJzx9u9tLWtMIfokF1R82bkDhcNxChR99Vs8=;
 b=QP73rTvMZtp6+B/3VAXPu+2KKYlMKMr/STQQNrz6LxxToOj4QsbmnDa1
 QPUKDrBCX7iwdWeSbOghdHwDRYz8sviKqc2lpDxh/16PqDzqErvJj9DF0
 uBJKsjYnEHtst4icsEYj7QeA+wQ3M/qDSMYEzexgoiRUJbyAY2ielTvSV
 yxV/NyLlrewRPu7XT3I9JPbvRrlttannP5EC5qJoYCzD0ovahdaCKavte
 8tizpYs53264ucaN3BzfNu4jp7DJ4n4AwT4pXM/MEV6qR7GmuZgDZ7eFE
 r99CMIRhZTjb8KTiYIoilXDE5JqHWV//OhmM4vWHi94363LrPpoof7f8y Q==;
X-CSE-ConnectionGUID: EO/XQtQlRN+5n90QNbDJnA==
X-CSE-MsgGUID: okOPMCU2TOS7t4ZGLXiMcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83279878"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="83279878"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 08:48:17 -0700
X-CSE-ConnectionGUID: k2JHsyAoQPifZSixkGg0hQ==
X-CSE-MsgGUID: 0RpWCd1KQ6eC+2x0z9n65A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="247571009"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa007.fm.intel.com with ESMTP; 25 Jun 2026 08:48:16 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 2/4] net/ixgbe: fix potential NULL dereference
Date: Thu, 25 Jun 2026 16:48:11 +0100
Message-ID: <736dc471f3da92e420259a8ec14a77b92de7de4c.1782402484.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <c42d6f4efb83f4962ea096a702ed320a3d0a5eed.1782402484.git.anatoly.burakov@intel.com>
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

Static analysis reports that a rule dump may trigger NULL dereference. This
cannot actually happen because dump_blob will not dereference the rule_data
when rule_size is 0, but it's a good defensive check anyway, so add it.

Coverity issue: 503773

Fixes: 51f505a4090f ("net/ixgbe: support flow dump")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 19d7f93d93..6868893d46 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -3345,11 +3345,18 @@ ixgbe_flow_dev_dump(struct rte_eth_dev *dev,
 		if (flow != NULL && p_flow != flow)
 			continue;
 
+		/* this should not happen */
+		if (p_flow->rule == NULL) {
+			PMD_DRV_LOG(DEBUG, "Invalid flow");
+			continue;
+		}
+
+		rule_size = ixgbe_flow_rule_size(p_flow);
+		if (rule_size == 0)
+			continue;
+
 		found = true;
-		if (p_flow->rule != NULL) {
-			rule_data = ixgbe_flow_rule_data(p_flow);
-			rule_size = ixgbe_flow_rule_size(p_flow);
-		}
+		rule_data = ixgbe_flow_rule_data(p_flow);
 		engine_name = ixgbe_flow_rule_engine_name(p_flow);
 		ixgbe_flow_dump_blob(file, engine_name,
 			rule_data, rule_size);
-- 
2.47.3

