Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8852CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 15:52:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A6B540DC9;
	Fri,  7 Nov 2025 16:51:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id CCED540666;
 Fri,  7 Nov 2025 16:51:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762530673; x=1794066673;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Rl0CC8MrCUSSflLK51DbqiML4nvv06unMhqn5s1jI/U=;
 b=KQAMXguSQhV1bcf6DBsRClV19tsZ0TBSrmxFX92LVDuBaxNJsexS4XL2
 QW26e3zyCdCIQx4rzjkT2q6iaYbS6WSHQKtmcFCIBqq1yNNlEMNTyh86x
 4pQL5ckQOMRmk2UzsStBQPs72sHlqi7bUECyQ6l6+yr15s3OXnyOgg/Do
 vYVRxGiB1GAbJbRzLPTLmCFAQqeU/dND+J+w8/AC6d94hU8mD0Chq+GKV
 qaKpSUmO+JsZzMZpYbvt0pEU6nKfxDwzTGs6JX69bR5dOATiqyOwhnW9D
 8sc1bRbFcqL01Ggq46xSeAzVuIDqrWB11N6D+foasPY5Rd8hZKMd8t+SW w==;
X-CSE-ConnectionGUID: iMgLlFnLSwyWKEkJHU3+9A==
X-CSE-MsgGUID: sLvEj4RmTVm9rPm7SG3TzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="90151844"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="90151844"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 07:51:12 -0800
X-CSE-ConnectionGUID: S/9vCA0GQkuH66o8HLCRBw==
X-CSE-MsgGUID: IPPI/iz0RmOR8yGJQrtPwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="187321682"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 07 Nov 2025 07:51:12 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>, Amr Mokhtar <amr.mokhtar@intel.com>
Subject: [RFC PATCH v2 11/33] bbdev: fix variable shadowing
Date: Fri,  7 Nov 2025 15:50:07 +0000
Message-ID: <20251107155034.436809-12-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251107155034.436809-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
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

The "ret" variable is declared twice in rte_bbdev_setup_queues function.
The second declaration is unneeded so remove it.

Fixes: 4935e1e9f76e ("bbdev: introduce wireless base band device lib")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/bbdev/rte_bbdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
index 6c98296bdb..ea644c1f9b 100644
--- a/lib/bbdev/rte_bbdev.c
+++ b/lib/bbdev/rte_bbdev.c
@@ -357,7 +357,7 @@ rte_bbdev_setup_queues(uint16_t dev_id, uint16_t num_queues, int socket_id)
 	if (dev->data->queues != NULL) {
 		VALID_FUNC_OR_RET_ERR(dev->dev_ops->queue_release, dev_id);
 		for (i = 0; i < dev->data->num_queues; i++) {
-			int ret = dev->dev_ops->queue_release(dev, i);
+			ret = dev->dev_ops->queue_release(dev, i);
 			if (ret < 0) {
 				rte_bbdev_log(ERR,
 						"Device %u queue %u release failed",
-- 
2.48.1

