Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C002DCA1012
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 10:44:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7157340F16;
	Thu,  4 Sep 2025 12:44:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 6B6934027D
 for <dev@dpdk.org>; Thu,  4 Sep 2025 12:44:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756982689; x=1788518689;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=P9lMESKzmc1tgg5Zf6hRRwOOsCWnwJEcp4x8nInYTcI=;
 b=oAhQgWkYLNser1vgGnkYPPeNsiNTOos6ngyLbwJilppX29m01Tg+1wio
 k7dd6/+ao9jWTkqrdygmgaLEO5DqMLtjNDJCPmXS2D1t1CnFfZccbNllM
 liTPvpG2naJ8y7LwljmtNVzNrjMbzE3UY+QO3OkQh8MkgWoSvgoue5Zs/
 hw0N9SAYrS1SVZkv3mJWaaZg1XWlXeu7xD0q7vKvjARxQHzwzjXrJ78Mp
 +G3WakaA9waNImme6wtmtJHFinLoIWRz7mEKypAag85j/lf/ZuKdzc6am
 7efQZV7HlP31pOgYZqiD5dBYG43+2m9K/cMAt0cJxo6gwnz/5ZZYgk893 Q==;
X-CSE-ConnectionGUID: aw3EjeZNSoqpcGLdM0g8KA==
X-CSE-MsgGUID: 6R/We+pYQuq+plfKIHymaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59463068"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="59463068"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 03:44:47 -0700
X-CSE-ConnectionGUID: UTDy/hIiQ9inCbotkQuOaA==
X-CSE-MsgGUID: 71W1IzoVR5SD9Z7Aer4pUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="195512082"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa002.fm.intel.com with ESMTP; 04 Sep 2025 03:44:46 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 1/3] net/iavf: fix Tx vector path selection logic again
Date: Thu,  4 Sep 2025 10:44:38 +0000
Message-Id: <20250904104440.2167205-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904104440.2167205-1-ciara.loftus@intel.com>
References: <20250904104440.2167205-1-ciara.loftus@intel.com>
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

Commit b39aeea703b8 ("net/iavf: fix Tx vector path selection logic")
fixed an issue which caused the scalar path to be chosen even when the
AVX-512 path could have been a viable candidate. The commit
be1a887b83cd ("net/iavf: use the new common vector capability function")
accidentally undid this fix, so this commit fixes this again, this time
in a new way due to the changed code landscape since the last fix.

Fixes: be1a887b83cd ("net/iavf: use the new common vector capability function")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index ab44558a85..ce0a12c348 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -4090,7 +4090,7 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 				    dev->data->port_id);
 			tx_func_type = IAVF_TX_SSE;
 		}
-		if (use_avx2) {
+		if (!use_avx512 && use_avx2) {
 			if (check_ret == IAVF_VECTOR_PATH) {
 				tx_func_type = IAVF_TX_AVX2;
 				PMD_DRV_LOG(DEBUG, "Using AVX2 Vector Tx (port %d).",
-- 
2.34.1

