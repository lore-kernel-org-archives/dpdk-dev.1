Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C99EEDF14F
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 10:29:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 140FE40B9D;
	Fri, 13 Feb 2026 11:27:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 717F6402F1
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:27:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770978435; x=1802514435;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=PAJobiJsC0rE3fAHEwH8SIIiy7F+wVl2oTC3EwBUZ2M=;
 b=S8fEKlz5PL1sC7gvfqy0zlPFky5099n7z/2RKueMtkWc6o+vGM8XtoeG
 s3eCLI6gES6zU/FQ14d9kB5r8s4j1s9wNOkgzi0ZdIQcpr+j/HOzoSdzz
 yLqr4CJE/5ViSDyXbzHnzeDaKRia9vRUWKgdXBVNA664cF8RG+mCLrPf5
 M0qv3kikBoh7lR7QafQvT7P+JcBauRFSuUtfue0sncV0hPW3Uh3ZlV6gJ
 K8K64JhvzMpo161CUpUtT0a+kgxY8X6zNorkP6CVJGY0WdyIxHRemcukj
 eV99JN1iLlG7w0u6t0A9EiCXISiJL1C4R+eaAswdw8RfINkqxkv9bdBx3 Q==;
X-CSE-ConnectionGUID: PflvVWPgQOaByXIYzov4qA==
X-CSE-MsgGUID: gMx6Nq5VRnyOpJ8Efyvl7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83603110"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="83603110"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 02:27:15 -0800
X-CSE-ConnectionGUID: z6zf/vwwS+KVRYDO5GOmug==
X-CSE-MsgGUID: gFWOQY0lR22/43IfzBvArQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="217028126"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 13 Feb 2026 02:27:15 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 20/27] net/iavf: avoid rte malloc in MAC address operations
Date: Fri, 13 Feb 2026 10:26:31 +0000
Message-ID: <ad3c77be6c74565b7a9e4544b6565ea91f94fc70.1770978324.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
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

Currently, when adding or deleting MAC addresses, we are using
rte_zmalloc followed by an immediate rte_free. This is not needed as this
memory is not being stored anywhere, so replace it with regular
malloc/free.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 55986ef909..19dce17612 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -1402,7 +1402,7 @@ iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
 			}
 		}
 
-		list = rte_zmalloc("iavf_del_mac_buffer", len, 0);
+		list = calloc(1, len);
 		if (!list) {
 			PMD_DRV_LOG(ERR, "fail to allocate memory");
 			return;
@@ -1434,7 +1434,7 @@ iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
 			PMD_DRV_LOG(ERR, "fail to execute command %s",
 				    add ? "OP_ADD_ETHER_ADDRESS" :
 				    "OP_DEL_ETHER_ADDRESS");
-		rte_free(list);
+		free(list);
 		begin = next_begin;
 	} while (begin < IAVF_NUM_MACADDR_MAX);
 }
-- 
2.47.3

