Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7781606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eE3hZKKd
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1F4C40395;
	Mon, 23 Nov 2026 16:46:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTPS id 958F640262;
 Mon, 23 Nov 2026 16:46:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795448768; x=1826984768;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=o8n7iQQr6/jLI4dmTpaqI3viBEF1w8A0p1koJp402g0=;
 b=eE3hZKKdXjGCneYvnpuJCxd1mGy7pFL1fEQzk0Rv82LMOksvjKfZf0W1
 Fhpg9iuj7YqDKEpyGv7hbTea3tre1ZZdN2hRn+15iTWrWNtbY5CNIw3Oy
 R7i7C2lvDNgUBz/f72h3bGeEyW2VQN6eIGiPKeAadPggSer3E5hBRvBLd
 QVGG9dKvDteFf/U9728ARWMeOAPHG9GyE+t81oC8t9eN1vSBgv6mVpD8r
 R0z+03czdS54KyMK5fWK7fubaInp8TSbu0A1gMCur9h0IR+dRqS6yqJ6J
 uKronkyT1iG247QItR/2QZ2cPfyaDxrjAVWRjv33mw4tdbi5ePxGxUb8B Q==;
X-CSE-ConnectionGUID: q3zo/ppcRBO2SusM8qoXqA==
X-CSE-MsgGUID: oGJz0SFDSnSoayAUx5cCSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4303138"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4303138"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 07:46:06 -0800
X-CSE-ConnectionGUID: 4CFr/KK/SwqybkCHgY+sRA==
X-CSE-MsgGUID: lqWpiWQrTQmM9ppdEsg2rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11685754"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by fmviesa009.fm.intel.com with ESMTP; 23 Nov 2026 07:46:05 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/iavf: fix handling of refused queue request
Date: Mon, 23 Nov 2026 15:45:43 +0000
Message-ID: <20261123154543.305664-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, a request for additional queues is sent without waiting for
a reply, as the PF resets the VF when it grants the request. If the PF
refuses the request it sends a response instead, which the VF discards
as a command mismatch. The driver then reports "only 0 queues
available" after a two second timeout.

Fix this by waiting for the reply, treating a VF reset during the wait
as a grant. A refusal is now reported immediately, and a reply offering
fewer queues than requested returns `-ENOSPC`. Any command waiting for
a reply when a reset begins now fails with `-ECANCELED` instead of
timing out, and the admin queue alarm is no longer cancelled around the
request, as it delivers the reply when interrupts are unused.

Fixes: 675a104e2e94 ("net/iavf: fix abnormal disable HW interrupt")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 53 ++++++++++++-----------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 64ca93c20b..a256e3219e 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -15,7 +15,6 @@
 #include <rte_os_shim.h>
 
 #include <rte_debug.h>
-#include <rte_alarm.h>
 #include <rte_atomic.h>
 #include <rte_eal.h>
 #include <rte_ether.h>
@@ -456,8 +455,7 @@ iavf_get_cmd_resp_count(enum virtchnl_ops op)
 {
 	switch (op) {
 	case VIRTCHNL_OP_RESET_VF:
-	case VIRTCHNL_OP_REQUEST_QUEUES:
-		/* These commands trigger reset and are not waited for */
+		/* This command triggers reset and is not waited for */
 		return 0;
 	case VIRTCHNL_OP_INLINE_IPSEC_CRYPTO:
 		/* IPsec crypto commands generate two responses */
@@ -501,6 +499,11 @@ iavf_wait_for_msg(struct iavf_adapter *adapter, struct iavf_cmd_info *args,
 			if (vf->pend_cmd == VIRTCHNL_OP_UNKNOWN)
 				break;
 		}
+		/* the PF will discard the command and not answer if in reset */
+		if (rte_atomic_load_explicit(&vf->vf_reset, rte_memory_order_acquire)) {
+			PMD_DRV_LOG(INFO, "VF reset while waiting for cmd %d", args->ops);
+			return -ECANCELED;
+		}
 		iavf_msec_delay(ASQ_DELAY_MS);
 	} while (i++ < MAX_TRY_TIMES);
 
@@ -2389,7 +2392,6 @@ iavf_request_queues(struct rte_eth_dev *dev, uint16_t num)
 	struct iavf_cmd_info args;
 	uint16_t num_queue_pairs;
 	int err;
-	int i = 0;
 
 	if (!(vf->vf_res->vf_cap_flags &
 		VIRTCHNL_VF_OFFLOAD_REQ_QUEUES)) {
@@ -2409,44 +2411,33 @@ iavf_request_queues(struct rte_eth_dev *dev, uint16_t num)
 	args.out_buffer = msg_buf;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
-	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR) {
-		iavf_phc_sync_alarm_stop(dev);
-		err = iavf_execute_vf_cmd_safe(adapter, &args);
-		iavf_phc_sync_alarm_start(dev);
-	} else {
-		iavf_phc_sync_alarm_stop(dev);
-		rte_eal_alarm_cancel(iavf_dev_alarm_handler, dev);
-		err = iavf_execute_vf_cmd_safe(adapter, &args);
-		rte_eal_alarm_set(IAVF_ALARM_INTERVAL,
-				  iavf_dev_alarm_handler, dev);
-		iavf_phc_sync_alarm_start(dev);
-	}
-
-	if (err) {
-		PMD_DRV_LOG(ERR, "fail to execute command OP_REQUEST_QUEUES");
-		return err;
-	}
-
-	/* wait for interrupt notification vf is resetting */
-	while (i++ < MAX_TRY_TIMES) {
-		if (rte_atomic_load_explicit(&vf->vf_reset, rte_memory_order_acquire))
-			break;
-		iavf_msec_delay(ASQ_DELAY_MS);
-	}
+	iavf_phc_sync_alarm_stop(dev);
+	err = iavf_execute_vf_cmd_safe(adapter, &args);
+	iavf_phc_sync_alarm_start(dev);
 
 	/* request queues succeeded, vf is resetting */
-	if (rte_atomic_load_explicit(&vf->vf_reset, rte_memory_order_acquire)) {
+	if (err == -ECANCELED ||
+	    (err == 0 && rte_atomic_load_explicit(&vf->vf_reset, rte_memory_order_acquire))) {
 		PMD_DRV_LOG(INFO, "vf is resetting");
 		return 0;
 	}
 
-	/* request additional queues failed, return available number */
+	/* request additional queues failed */
+	if (err != 0) {
+		if (err == -EINVAL || err == -ENOTSUP)
+			PMD_DRV_LOG(ERR, "PF refused request for %u queues", num);
+		else
+			PMD_DRV_LOG(ERR, "fail to execute command OP_REQUEST_QUEUES");
+		return err;
+	}
+
+	/* PF replied with success but did not reset; it offers fewer queues than requested */
 	num_queue_pairs =
 	  ((struct virtchnl_vf_res_request *)args.out_buffer)->num_queue_pairs;
 	PMD_DRV_LOG(ERR, "request queues failed, only %u queues "
 		"available", num_queue_pairs);
 
-	return -1;
+	return -ENOSPC;
 }
 
 int
-- 
2.43.0

