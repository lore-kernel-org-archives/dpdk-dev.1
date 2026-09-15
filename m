Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EE3C88E73
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 08:37:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C42E406A2;
	Tue, 15 Sep 2026 10:37:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id E863240290
 for <dev@dpdk.org>; Tue, 15 Sep 2026 10:37:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789461426; x=1820997426;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=EnLqEIVx/jwEvAk4FryDfx4fZGJJEGCqnt74qzGmpXY=;
 b=ThxZrxY3T/V0UmE953rUQMwoYBjgvW4kss1B1gNQOVrqv09dmRY/+X+W
 KwK9lAInf9nUnna3WU37RcFsw/NNCA0GPBFvVWKZp+FRD5IFcYXplrVw6
 2AGNU0E9DLbe5VZRuM52Jqz46rPMWTFBP/zkrNeA5OcJkWuWgdzSwulv0
 og2GH1NPWUZHFiVMnLjeTpgUWqw3Mbv+Smt+Qwrzjs0LzoU0CUV33LuI3
 WHmTScLZSbvQlP5+ZB0ZYwiKFq0pkjL255CfLyannrmzVqRf1Rw7aAXbi
 t3gtAV70f2IXdPUv8RFR0FHSyRJJ8fFWF8pqLGrShSC0EFZM0i5FMeg0x Q==;
X-CSE-ConnectionGUID: S9xFyR+lSU+ZfpTwH3clcA==
X-CSE-MsgGUID: w+lDaiIeSq2rcMk3DJisFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100415037"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="100415037"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 01:37:04 -0700
X-CSE-ConnectionGUID: YLKftTlWRdCXE7B7mCNAmQ==
X-CSE-MsgGUID: 5ua1UzFvRey4Cdc9jkaJUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="272879335"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 15 Sep 2026 01:37:02 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Qiming Chen <chenqiming_huawei@163.com>, Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH v1 1/1] net/iavf: fix resource leak on IPsec init fail
Date: Tue, 15 Sep 2026 09:37:00 +0100
Message-ID: <049b6e36e7303a5f5c9ce96a3bcb116fc8c25af6.1789461413.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
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

Currently, during `dev_init`, we try to create a security context. At that
point we have already initialized the rte_flow engines, so any subsequent
failures must trigger flow engines uninit. However, if we fail to create a
security context (or if its initialization fails), we do not uninit the
rte_flow engines. Fix the code to do so on failure.

Fixes: 45570d7e4439 ("net/iavf: fix resource leak on probing failure")
Cc: chenqiming_huawei@163.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 2ac4dbdac4f..2b2eb4a93f8 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3153,7 +3153,7 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 		ret = iavf_security_ctx_create(adapter);
 		if (ret) {
 			PMD_INIT_LOG(ERR, "failed to create ipsec crypto security instance");
-			goto flow_init_err;
+			goto security_init_err;
 		}
 
 		ret = iavf_security_init(adapter);
@@ -3183,6 +3183,7 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 
 security_init_err:
 	iavf_security_ctx_destroy(adapter);
+	iavf_flow_uninit(adapter);
 
 flow_init_err:
 	vf->aq_intr_enabled = false;
-- 
2.52.0

