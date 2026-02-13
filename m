Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3025BEDF150
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 10:28:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F40F2406BB;
	Fri, 13 Feb 2026 11:27:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 79F55402BE
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:27:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770978427; x=1802514427;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=JDJwC/dT3zHOUSL4CWaGVZjFR/cQjAUxaQFLx7/JDvg=;
 b=ctTbDzBt9PRuZFgeappKo1rQuEjGmEZia+LY6IcJunM1WrWf69xB2EHT
 Q6wQO+fNpMgPb0grl5ObVgkVH7Po2/yedCSx8Wp98BgYaPPYOmDpHGI42
 MVlUOvRv7oZ+PLZCjottvcxcVQEe52+K9JBrFomQDPrXpjAxLeI7DjOVL
 iK24R5ODNf2EG7qmmuFPHgMswHwdimrkhSV/yuTHlZTQSHIJZNJb4qbV0
 DAvhrzwwG3+GW5gGFCFZir8Tsmm+7XfOwDn0W6mJXpIqbx0hdHxaKaWBz
 qlu1qVTQdLK+4eXaq++ibjs6bKVrNJ1n3p4PMrgI8xYXLgzwh3CqrFwdU Q==;
X-CSE-ConnectionGUID: 4MMe9wkjRFu7fEe49gI8mQ==
X-CSE-MsgGUID: +G3GluEoQxClxV3EQNBlYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83603098"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="83603098"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 02:27:07 -0800
X-CSE-ConnectionGUID: Zex//ddtQnClf5+euPcbDQ==
X-CSE-MsgGUID: mI4EAALlRUKNAwZ0otYqjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="217028092"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 13 Feb 2026 02:27:07 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 13/27] net/i40e: avoid rte malloc in adminq operations
Date: Fri, 13 Feb 2026 10:26:24 +0000
Message-ID: <59713d4fa172d12fe42eb7c4cdd924aa613dae03.1770978324.git.anatoly.burakov@intel.com>
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

Currently, when processing admin queue messages, we are using rte_zmalloc
followed by an immediate rte_free. This is not needed as the message
buffer is only used temporarily within the function scope, so replace it
with regular malloc/free.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 806c29368c..2e0c2e2482 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -6896,7 +6896,7 @@ i40e_dev_handle_aq_msg(struct rte_eth_dev *dev)
 	int ret;
 
 	info.buf_len = I40E_AQ_BUF_SZ;
-	info.msg_buf = rte_zmalloc("msg_buffer", info.buf_len, 0);
+	info.msg_buf = calloc(1, info.buf_len);
 	if (!info.msg_buf) {
 		PMD_DRV_LOG(ERR, "Failed to allocate mem");
 		return;
@@ -6936,7 +6936,7 @@ i40e_dev_handle_aq_msg(struct rte_eth_dev *dev)
 			break;
 		}
 	}
-	rte_free(info.msg_buf);
+	free(info.msg_buf);
 }
 
 static void
-- 
2.47.3

