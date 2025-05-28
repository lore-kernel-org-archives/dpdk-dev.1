Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F444C3ABB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 10:28:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF49D40A73;
	Wed, 28 May 2025 12:28:01 +0200 (CEST)
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com
 [52.119.213.154])
 by mails.dpdk.org (Postfix) with ESMTP id EB10C40279;
 Wed, 28 May 2025 12:28:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1748428081; x=1779964081;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tkBHEYGTtS96gNGJ9NM1oQBGasdKXJSVcr7Ofp2/LJw=;
 b=RlhYqWR79TeUGrDJChKyD+p+0Chg1/N9Xfd59wb7ZP5FvTq0FWxBT2mo
 wPKHJWGYJnOW1VFQLf9AmtF61eeiW26vKhGqpKr774Rrmb6fPpraP45r4
 TLg7bRlHPvC5XJrxhns2v9PYjAnOnbDzAcCxv68G1XUlKC5iP7SgAB9iK
 zSUixlNETJekUe5CQHBPTpAWfq297PhjveUCzul4Yz625uvTFg6juaKDs
 jbOus0H8us4dyLQrjOzLjvs4aimYEsR/hF1vfyyzqEOurXWsdqCCFmEBO
 VX6MlPI2mOHqxqJnykRbXoroiX6JfhpE3YQ9Ce9QwnlsCHVdwGWonhF9B A==;
X-IronPort-AV: E=Sophos;i="6.15,320,1739836800"; d="scan'208";a="302405642"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
 by smtp-border-fw-52004.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 10:28:01 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:3811]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.16.84:2525]
 with esmtp (Farcaster)
 id 19664f00-7598-4796-9fa1-419c443cdfe0; Wed, 28 May 2025 10:27:59 +0000 (UTC)
X-Farcaster-Flow-ID: 19664f00-7598-4796-9fa1-419c443cdfe0
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 28 May 2025 10:27:58 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.9) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 28 May 2025 10:27:55 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, <stable@dpdk.org>
Subject: [PATCH v4 6/7] net/ena: fix aenq timeout with low poll interval
Date: Wed, 28 May 2025 13:27:40 +0300
Message-ID: <20250528102740.9981-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.1.213.9]
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D007EUA002.ant.amazon.com (10.252.50.68)
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

The driver can work in polling-based functionality of the admin
queue, eliminating the need for interrupts in the control-path.
This mode is mandatory when using the uio_pci_generic driver,
which lacks interrupt support.

The control_path_poll_interval devarg is being set within the range
[1..1000]. A value of 0 disables the polling mechanism.
This value defines the interval in milliseconds at which the driver
checks for asynchronous notifications from the device.

Testing revealed that setting this interval below 500 milliseconds
might lead to false detection of device unresponsiveness.
This patch clamps the user-defined value to the updated valid range
[500..1000] that ensures reliable aenq monitoring.

Fixes: ca1dfa85f0d3 ("net/ena: add control path pure polling mode")
Cc: stable@dpdk.org
Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 doc/guides/nics/ena.rst                |  4 +++-
 doc/guides/rel_notes/release_25_07.rst |  2 ++
 drivers/net/ena/ena_ethdev.c           | 24 ++++++++++--------------
 drivers/net/ena/ena_ethdev.h           |  3 ++-
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/doc/guides/nics/ena.rst b/doc/guides/nics/ena.rst
index a42deccd81..decb6be766 100644
--- a/doc/guides/nics/ena.rst
+++ b/doc/guides/nics/ena.rst
@@ -136,7 +136,9 @@ Runtime Configuration
 
      0 - Disable (Admin queue will work in interrupt mode).
 
-     [1..1000] - Number of milliseconds to wait between periodic inspection of the admin queues.
+     [500..1000] – Time in milliseconds to wait between periodic checks of the admin queues.
+     If a value outside this range is specified, the driver will automatically adjust it to
+     fit within the valid range.
 
      **A non-zero value for this devarg is mandatory for control path functionality
      when binding ports to uio_pci_generic kernel module which lacks interrupt support.**
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 8c245d6805..9bff9a4627 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -69,6 +69,8 @@ New Features
     This mode bypasses the PPS limit enforced by EC2 for fragmented egress packets on every ENI.
   * Fixed the device initialization routine to correctly handle failure during the registration
     or enabling of interrupts when operating in control path interrupt mode.
+  * Fixed an issue where the device might be incorrectly reported as unresponsive when using
+    polling-based admin queue functionality with a poll interval of less than 500 milliseconds.
 
 * **Updated virtio driver.**
 
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index 8ba4f3a9cf..d249701144 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -30,6 +30,8 @@
 #define GET_L4_HDR_LEN(mbuf)					\
 	((rte_pktmbuf_mtod_offset(mbuf,	struct rte_tcp_hdr *,	\
 		mbuf->l3_len + mbuf->l2_len)->data_off) >> 4)
+#define CLAMP_VAL(val, min, max)					\
+	(RTE_MIN(RTE_MAX((val), (typeof(val))(min)), (typeof(val))(max)))
 
 #define ETH_GSTRING_LEN	32
 
@@ -3756,25 +3758,19 @@ static int ena_process_uint_devarg(const char *key,
 				uint64_value * rte_get_timer_hz();
 		}
 	} else if (strcmp(key, ENA_DEVARG_CONTROL_PATH_POLL_INTERVAL) == 0) {
-		if (uint64_value > ENA_MAX_CONTROL_PATH_POLL_INTERVAL_MSEC) {
-			PMD_INIT_LOG_LINE(ERR,
-				"Control path polling interval is too long: %" PRIu64 " msecs. "
-				"Maximum allowed: %d msecs.",
-				uint64_value, ENA_MAX_CONTROL_PATH_POLL_INTERVAL_MSEC);
-			return -EINVAL;
-		} else if (uint64_value == 0) {
+		if (uint64_value == 0) {
 			PMD_INIT_LOG_LINE(INFO,
-				"Control path polling interval is set to zero. Operating in "
-				"interrupt mode.");
-				adapter->control_path_poll_interval = 0;
+				"Control path polling is disabled - Operating in interrupt mode");
 		} else {
+			uint64_value = CLAMP_VAL(uint64_value,
+				ENA_MIN_CONTROL_PATH_POLL_INTERVAL_MSEC,
+				ENA_MAX_CONTROL_PATH_POLL_INTERVAL_MSEC);
 			PMD_INIT_LOG_LINE(INFO,
-				"Control path polling interval is set to %" PRIu64 " msecs.",
+				"Control path polling interval is %" PRIu64 " msec",
 				uint64_value);
-				adapter->control_path_poll_interval = uint64_value * USEC_PER_MSEC;
 		}
+		adapter->control_path_poll_interval = uint64_value * (USEC_PER_MSEC);
 	}
-
 	return 0;
 }
 
@@ -4081,7 +4077,7 @@ RTE_PMD_REGISTER_KMOD_DEP(net_ena, "* igb_uio | uio_pci_generic | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_ena,
 	ENA_DEVARG_LLQ_POLICY "=<0|1|2|3> "
 	ENA_DEVARG_MISS_TXC_TO "=<uint>"
-	ENA_DEVARG_CONTROL_PATH_POLL_INTERVAL "=<0-1000> ")
+	ENA_DEVARG_CONTROL_PATH_POLL_INTERVAL "= 0|<500-1000> "
 	ENA_DEVARG_ENABLE_FRAG_BYPASS "=<0|1> ");
 RTE_LOG_REGISTER_SUFFIX(ena_logtype_init, init, NOTICE);
 RTE_LOG_REGISTER_SUFFIX(ena_logtype_driver, driver, NOTICE);
diff --git a/drivers/net/ena/ena_ethdev.h b/drivers/net/ena/ena_ethdev.h
index f4461733e9..e5d23e2e27 100644
--- a/drivers/net/ena/ena_ethdev.h
+++ b/drivers/net/ena/ena_ethdev.h
@@ -42,7 +42,8 @@
 #define ENA_MONITORED_TX_QUEUES		3
 #define ENA_DEFAULT_MISSING_COMP	256U
 
-#define ENA_MAX_CONTROL_PATH_POLL_INTERVAL_MSEC 1000
+#define ENA_MAX_CONTROL_PATH_POLL_INTERVAL_MSEC 1000U
+#define ENA_MIN_CONTROL_PATH_POLL_INTERVAL_MSEC 500U
 
 /* While processing submitted and completed descriptors (rx and tx path
  * respectively) in a loop it is desired to:
-- 
2.17.1

