Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3487DC4451C
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 11:56:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEE56402D9;
	Tue, 21 Jul 2026 13:56:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 24BD640294
 for <dev@dpdk.org>; Tue, 21 Jul 2026 13:56:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784635007; x=1816171007;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=79KUuulLQLsDDeMoMAXUXXoAOuh0p1+GaiNkc4s+g4k=;
 b=FidiJ9Qc3Y9GZWSL91t5G+reNNS37SjE9T1PMu5IvufFCHy9vAUfV3ij
 5tHuSTgPGlDikgkdYLEEekJt81Y4nQCh7P/hb8o2tnEaEmqr0USeai4nl
 iNxGvUCSAbCr4AjmpshT+upKYjGHY4iYy8+6twcYVzrGVOEFyzUIfmLAx
 kDSbNlGUzMa7dWOMQZQB3YDtC5zrV9q3M4T4lJeiW83qIQjRnXe+J3jkh
 +iLrA2q8dZxzUuc9SJ1/eQIMACBuVSgigM+GOv01lWg2S0IgC9xa6OI1M
 FsOgyy5V+eOaJYjNot/wr0Bml+WJt/OBdiVjh8X6UEoZcTiU+YaPVCTNk Q==;
X-CSE-ConnectionGUID: 9hDcYyewRxyzdII+3lDVDg==
X-CSE-MsgGUID: BDnykmtEQHOs7HjkmEUhOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85324525"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="85324525"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 04:56:45 -0700
X-CSE-ConnectionGUID: FpdhC+w4SXCiRKdmOdRyiw==
X-CSE-MsgGUID: 8CkYJd2bQiWhS+avgFQkLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="261524874"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 21 Jul 2026 04:56:44 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>
Subject: [PATCH] test/event_eth_tx_adapter: skip tests if no eventdev
Date: Tue, 21 Jul 2026 12:56:35 +0100
Message-ID: <20260721115635.2209399-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
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

If there is no eventdev present, and the SW eventdev driver is not
available, skip the eth tx adapter tests, rather than failing on event
creation.

Note: We keep the failure case where we do have the event/sw driver
built, but fail to create an instance of it.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_event_eth_tx_adapter.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/app/test/test_event_eth_tx_adapter.c b/app/test/test_event_eth_tx_adapter.c
index bec298a8b8..18801028ce 100644
--- a/app/test/test_event_eth_tx_adapter.c
+++ b/app/test/test_event_eth_tx_adapter.c
@@ -202,12 +202,13 @@ deinit_ports(void)
 static int
 testsuite_setup(void)
 {
-	const char *vdev_name = "event_sw0";
-
 	int err = init_ports();
 	TEST_ASSERT(err == 0, "Port initialization failed err %d\n", err);
 
+#ifdef RTE_EVENT_SW
 	if (rte_event_dev_count() == 0) {
+		const char *vdev_name = "event_sw0";
+
 		printf("Failed to find a valid event device,"
 			" testing with event_sw0 device\n");
 		err = rte_vdev_init(vdev_name, NULL);
@@ -215,6 +216,11 @@ testsuite_setup(void)
 			vdev_name, err);
 		event_dev_delete = 1;
 	}
+#endif
+	if (rte_event_dev_count() == 0) {
+		printf("Failed to find a valid event device, skipping test\n");
+		return TEST_SKIPPED;
+	}
 	return err;
 }
 
-- 
2.53.0

