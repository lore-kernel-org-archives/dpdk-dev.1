Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172A6E9A053
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 17:40:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C796D4060C;
	Thu, 19 Feb 2026 18:40:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 0811F402AC
 for <dev@dpdk.org>; Thu, 19 Feb 2026 18:40:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771522804; x=1803058804;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lkO2v7Y4DEwNqAn/BU7BVTXFkODh7WNJmpD1vazcupM=;
 b=B3y0yYfwSTC6XJ2dE7IwvaV3XPxo0Fq4Zu5YmA7/vFajXzi9IvVp2cpf
 XxdC3i6QQKzEgC4BPS1QuMg3zuZ1aAPecVYboPwKbR0blZycb1om0qo2j
 y8iHuFtLxuhozbiWhrmKu0ZQidBX+UgwT0dy+eIgc44h5meVbyQgoGUhy
 EhjJo4mCbS12+hNBCNgeBLD4TqFxRutJGkxHDnu32Es6EBOLwZEDHYwl0
 NFqLSol2Py6Tpb5ZMVPBOYyaGkghloS3INnU7PNXUbsG8wGHTAoYEN4K/
 FZyHjNiE8KDNu4md8Sqm2zyW8jdpTZe8o3oI61hWuLdQQjxdc+Z0p/5jH A==;
X-CSE-ConnectionGUID: d1u8LGsEQVehQkG2rkiPLw==
X-CSE-MsgGUID: srJDfpOTQmizCbi/qfPGug==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72518109"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="72518109"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 09:40:03 -0800
X-CSE-ConnectionGUID: znCfWfsqRdWbngINSpI/Bw==
X-CSE-MsgGUID: kG2erZ0vRGeHsdQELUD96w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="212803260"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 19 Feb 2026 09:40:02 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>
Subject: [PATCH v2 1/4] test/event_eth_rx_adapter: skip tests if no ethdevs
Date: Thu, 19 Feb 2026 17:39:50 +0000
Message-ID: <20260219173953.2182757-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260219173953.2182757-1-bruce.richardson@intel.com>
References: <20260122122354.1820368-1-bruce.richardson@intel.com>
 <20260219173953.2182757-1-bruce.richardson@intel.com>
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

If no ethdevs are present and devices cannot be created via net_null
driver, skip the tests rather than failing them.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_event_eth_rx_adapter.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/app/test/test_event_eth_rx_adapter.c b/app/test/test_event_eth_rx_adapter.c
index 2b623bfb28..ae428b3333 100644
--- a/app/test/test_event_eth_rx_adapter.c
+++ b/app/test/test_event_eth_rx_adapter.c
@@ -251,8 +251,11 @@ testsuite_setup(void)
 	if (!count) {
 		printf("Testing with net_null device\n");
 		err = rte_vdev_init("net_null", NULL);
-		TEST_ASSERT(err == 0, "Failed to create net_null. err=%d",
-			    err);
+		if (err != 0) {
+			printf("Failed to create net_null, skipping tests. err=%d\n",
+				err);
+			return TEST_SKIPPED;
+		}
 		eth_dev_created = true;
 	}
 
@@ -311,8 +314,11 @@ testsuite_setup_rx_intr(void)
 	if (!count) {
 		printf("Testing with net_null device\n");
 		err = rte_vdev_init("net_null", NULL);
-		TEST_ASSERT(err == 0, "Failed to create net_null. err=%d",
-			    err);
+		if (err != 0) {
+			printf("Failed to create net_null, skipping tests. err=%d\n",
+				err);
+			return TEST_SKIPPED;
+		}
 		eth_dev_created = true;
 	}
 
-- 
2.51.0

