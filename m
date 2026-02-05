Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3889EC1EAF
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 12:47:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3359E41133;
	Thu,  5 Feb 2026 13:46:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id DDCB140EDB
 for <dev@dpdk.org>; Thu,  5 Feb 2026 13:46:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770295605; x=1801831605;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3Fw5V01r8yCSbdgpQIWPHhdW73dT9blt6a6lbpITgRw=;
 b=aB6yJ/UAgGqjfyK8w2IAfO66nN04tejgKSYzRJJFBFr5OLyz2r8pXwPM
 I/h/aS1CpwWhANPq2mUkdErCRAl1NbFvCigX2ypqw5/dX7nTMvnPXjGHh
 vv9+LOswK02e46IKO5Bd3NPb9m+GpwsU+7z5zKt04eIeFyCrzgcHHjyDO
 Zb8p2Ob07F4p+KYoEsHtFfqTzSw6gXxhMXCe3xesxctDSaym2YADy0BfU
 1NT5mnByhAqMDXOQSWTWebrIMZ6VSYi4CaKFXtBWyjJMJy2r6imfxt9VZ
 t7+nAVBFKqpBIfwIzNoJZYr8w09u+Qkr9DjI4XmIbYDE6lkCq/AVA5qIu Q==;
X-CSE-ConnectionGUID: Tq1hUWSuRkS8cWkUj7k+Qg==
X-CSE-MsgGUID: wdADB1zBQeubMfyi4GMBBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71481870"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="71481870"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 04:46:44 -0800
X-CSE-ConnectionGUID: 31SUNa5bSnSy0nQHxrT5WA==
X-CSE-MsgGUID: 8Wl3glPZSvWUZLcmfPAe0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="233454887"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa002.fm.intel.com with ESMTP; 05 Feb 2026 04:46:43 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 09/10] net/idpf: permit secondary process Tx path selection
Date: Thu,  5 Feb 2026 12:46:26 +0000
Message-ID: <20260205124627.371733-10-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205124627.371733-1-ciara.loftus@intel.com>
References: <20260205103008.190493-1-ciara.loftus@intel.com>
 <20260205124627.371733-1-ciara.loftus@intel.com>
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

Commit 7cab7e67363a ("net/idpf: use common Tx path selection
infrastructure") changed the way that secondary processes selected their
Tx burst function. Instead of letting secondary processes select their
own function, they now used the function selected by the primary
process. However, the primary process only selects the function at
device start, so if the primary process hadn't started the device by the
time the secondary process was selecting its Tx burst function, the
secondary process would not select the correct function.

This commit addresses this issue by allowing the secondary process to
select the path if the device has not been started yet.

Fixes: 7cab7e67363a ("net/idpf: use common Tx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/idpf/idpf_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index e7d44f7beb..6d7624731a 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -844,8 +844,8 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
 		.single_queue = (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE)
 	};
 
-	/* The primary process selects the tx path for all processes. */
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+	/* If the device has started the function has already been selected. */
+	if (dev->data->dev_started)
 		goto out;
 
 #ifdef RTE_ARCH_X86
-- 
2.43.0

