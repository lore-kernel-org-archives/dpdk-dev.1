Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15344EF0702
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 16:16:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED05B40E34;
	Tue, 10 Feb 2026 17:14:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 10EB140E16
 for <dev@dpdk.org>; Tue, 10 Feb 2026 17:14:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770740067; x=1802276067;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=PAJobiJsC0rE3fAHEwH8SIIiy7F+wVl2oTC3EwBUZ2M=;
 b=HjOzeGMdHmYgP3f26oZPljM2zx/jRBRsyIkRJ+uFJxUdmYQK279WL0cr
 O+juXzwR8YsbbZHCxA5LutNPShMzG0e8mSeHgQmy7HFXEEzsLz25+2o3J
 YeNfA2Yfx1iOwNPsfqezA6jh/U50Zg9ucnc01JyU2oNC732yszdkjN5TG
 +5c9VWsS3At688L2dxVwh1NN/DbeC6Lu5zDq19wwcypX/Ufke1B4h3PG4
 RJ1dfZYRbypR9OkcTXPYBzWOWXv9bjMgIDQ5b8Qq2ZOplm4kio16qoVl5
 u6q4zLhP1KWtZyAyIBxfZRQwEt/Fe0FsA2QyyFmNR5+LlXWV5NhbuRf0k Q==;
X-CSE-ConnectionGUID: ld5Dx1O4RySQIOzkK3K57Q==
X-CSE-MsgGUID: j1dfdTH+TS+9C4TfTkA00Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89286245"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89286245"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 08:14:27 -0800
X-CSE-ConnectionGUID: eWH6ijx5Th2nPkCAMUIbZw==
X-CSE-MsgGUID: j32WGZk8TDuB1/dNBGjAcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216127816"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 10 Feb 2026 08:14:26 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 20/26] net/iavf: avoid rte malloc in MAC address operations
Date: Tue, 10 Feb 2026 16:13:49 +0000
Message-ID: <ce0043b16e107b89c4bb4ce2914167db517535d0.1770739925.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770739924.git.anatoly.burakov@intel.com>
 <cover.1770739924.git.anatoly.burakov@intel.com>
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

