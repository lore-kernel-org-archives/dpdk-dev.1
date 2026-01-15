Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D6AD41168
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 10:39:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E09C4111C;
	Thu, 15 Jan 2026 11:38:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1F34E406B7;
 Thu, 15 Jan 2026 11:38:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768473526; x=1800009526;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=q3PkxkioQAR+S2xFeWg1zIfR77QpINqh6DT4zHSFvKY=;
 b=m8h4cyByOA4NvP52hGFIP4ZYQqVNFsOsjboV/1C7UtHXQNO+2Onn7rYu
 tEaY/Zh2HUyyU8jMlz4tDyCCKFXmKKSVsP8F6wIN59ubEhxcD0Ha9xfdp
 HJBaccHhfQccE7Oxiv7fhqv55FjLqJSrd3JWLQ0aIwSckhONb1iOhGFyh
 hDKaEe1MFXuHYmsnpHce5sZ3ffFM+IaqB9YvdFHTSU4gFQl4hSeQDGEda
 aZ8tuwnjCUDkhJvBXITMsZEUGKrzJVoMqxyyaHRtwAL7cd3YfF4XUhLO1
 gE7peTyRwdGlJmFce1F2jGu03oNp3smgJHT0WbVMfN7XZsKodOArRGOFe Q==;
X-CSE-ConnectionGUID: TtJ+aRfkS3qLYIiDncYBhQ==
X-CSE-MsgGUID: 9KyiayDNRqieeg3WahzEZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="87187963"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; d="scan'208";a="87187963"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2026 02:38:45 -0800
X-CSE-ConnectionGUID: +Mi5LLDTTmi1ZayBQaCF5Q==
X-CSE-MsgGUID: BOcVjdiHQGmxky1c8YR7cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; d="scan'208";a="205204809"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by fmviesa008.fm.intel.com with ESMTP; 15 Jan 2026 02:38:44 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 3/3] net/ice: re-enable strict priority on non-root levels
Date: Thu, 15 Jan 2026 10:38:23 +0000
Message-ID: <20260115103824.1982220-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115103824.1982220-1-ciara.loftus@intel.com>
References: <20260115103824.1982220-1-ciara.loftus@intel.com>
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

Commit 715d449a965b ("net/ice: enhance Tx scheduler hierarchy support")
disabled strict priority on all levels however it will work on all
levels except for the root level. This commit re-enables configurability
of priority on non-root levels.

Fixes: 715d449a965b ("net/ice: enhance Tx scheduler hierarchy support")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_tm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_tm.c b/drivers/net/intel/ice/ice_tm.c
index db895613cc..ff53f2acfd 100644
--- a/drivers/net/intel/ice/ice_tm.c
+++ b/drivers/net/intel/ice/ice_tm.c
@@ -522,7 +522,8 @@ ice_tm_node_add(struct rte_eth_dev *dev, uint32_t node_id,
 	tm_node->parent->children[tm_node->parent->reference_count++] = tm_node;
 	tm_node->params = *params;
 
-	if (tm_node->priority != 0)
+	/* Priority cannot be configured for the root level */
+	if (tm_node->priority != 0 && level_id == 0)
 		PMD_DRV_LOG(WARNING, "priority != 0 not supported in level %d", level_id);
 
 	if (tm_node->weight != 1 && level_id == 0)
-- 
2.43.0

