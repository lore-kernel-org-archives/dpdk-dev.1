Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67912C4452F
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 13:24:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9B9D4042F;
	Tue, 21 Jul 2026 15:24:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 36C24402A7
 for <dev@dpdk.org>; Tue, 21 Jul 2026 15:24:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784640241; x=1816176241;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JcQ1QBsh/DQumeRTFsmAw0MekiS/VAmNXE8EyA5zcEk=;
 b=l4b0zjkrVRnXBoTk6I1aNJ0kOXtl5emYsz4Z/S4pm4a0GWMm7IlYpCQ7
 9/tOwjlQust65vPGpvArJASep7x6ZA/+ZFa50b4hiAyRtzALKsfXXa03G
 wHotlJjRNNiyo6Qd2Ta53IakFGj3X5/XXKfJD+Gv143kyX8LqnpqRV8dK
 NuDOCSo1d5wjiP5e4UiK96aGZdreMln0v4DE+sr5XMCe0VAMwlRzCd57D
 UuMwPwQ8HPds2ev7Sop+P5vLgZllJ1PPBkiEj9huPy3d9dwhk1ui6X4HV
 xMGhDmDbv4HvCIr2GpzzJO6qQeOYbecYUZJkS+5qqXZE382pW11aZlO4B w==;
X-CSE-ConnectionGUID: 14LgNLipQQOE4/PFfNhmIw==
X-CSE-MsgGUID: hW/t0VsCSdSYpVLDUHe+KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="110790783"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="110790783"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 06:23:59 -0700
X-CSE-ConnectionGUID: NRllyC3DRbe0W9F7MVbKdQ==
X-CSE-MsgGUID: mBAr5a9iS+eny8uwOXz0Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="255118500"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 21 Jul 2026 06:23:58 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>
Subject: [PATCH v2] test/event_eth_tx_adapter: skip tests if no eventdev
Date: Tue, 21 Jul 2026 14:23:49 +0100
Message-ID: <20260721132349.2579128-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721115635.2209399-1-bruce.richardson@intel.com>
References: <20260721115635.2209399-1-bruce.richardson@intel.com>
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
 app/test/test_event_eth_tx_adapter.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/app/test/test_event_eth_tx_adapter.c b/app/test/test_event_eth_tx_adapter.c
index bec298a8b8..0c161897ce 100644
--- a/app/test/test_event_eth_tx_adapter.c
+++ b/app/test/test_event_eth_tx_adapter.c
@@ -202,18 +202,23 @@ deinit_ports(void)
 static int
 testsuite_setup(void)
 {
-	const char *vdev_name = "event_sw0";
-
 	int err = init_ports();
 	TEST_ASSERT(err == 0, "Port initialization failed err %d\n", err);
 
 	if (rte_event_dev_count() == 0) {
+#ifdef RTE_EVENT_SW
+		const char *vdev_name = "event_sw0";
+
 		printf("Failed to find a valid event device,"
 			" testing with event_sw0 device\n");
 		err = rte_vdev_init(vdev_name, NULL);
 		TEST_ASSERT(err == 0, "vdev %s creation failed  %d\n",
 			vdev_name, err);
 		event_dev_delete = 1;
+#else
+		printf("Failed to find a valid event device, skipping test\n");
+		return TEST_SKIPPED;
+#endif
 	}
 	return err;
 }
-- 
2.53.0

