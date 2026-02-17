Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A82E6817B
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 12:16:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9645F40DCB;
	Tue, 17 Feb 2026 13:15:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0D10840A84
 for <dev@dpdk.org>; Tue, 17 Feb 2026 13:15:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771330502; x=1802866502;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=PAJobiJsC0rE3fAHEwH8SIIiy7F+wVl2oTC3EwBUZ2M=;
 b=mOLj0TitW0EZL3V8JSPsIFrYmsifSzpJNoRVfKssvKaTHgJf5DOnx+ig
 EX6qXOQMYQ0tuxkDScvD6Mw/X2Xb+CYjMsEGLkz62mqS7zqB+UrW84oy2
 p4XH0MkHDSrrv+sNCvAGQPbNE5Qb8BV2inV73I4No9ESDukHmtXIBOp2I
 MOWioqnv865H80FPhBS55KhYMVRWwIBgRmli3slOKRRXCECH5bOZDxNjF
 knUt9NGnC2+JCBw7DjpHx1a2ysEXOS23DfJrtd/FhUlyR7eXICcoZSMli
 /UqCd0mt9Dwg2jAYiAOUS919zWD6kzfJo3bp6fBvNzRKvOzufY2qYxgpK w==;
X-CSE-ConnectionGUID: DmKB3UXcRQSoC253cvTmuw==
X-CSE-MsgGUID: 91e2iSXnTsm7uf0wAggIag==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="74996050"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="74996050"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:15:02 -0800
X-CSE-ConnectionGUID: xSSamr5pSdG2z5EU1d9lQg==
X-CSE-MsgGUID: CjU1ql0uRvqd2dLlOPq2bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="218396833"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2026 04:15:01 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v5 20/27] net/iavf: avoid rte malloc in MAC address operations
Date: Tue, 17 Feb 2026 12:14:09 +0000
Message-ID: <e4095948bdc7d02dfc7b177f7bc546bc463e766b.1771330391.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771330390.git.anatoly.burakov@intel.com>
 <cover.1771330390.git.anatoly.burakov@intel.com>
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

