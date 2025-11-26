Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE44AD1038F
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 08:24:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9ABA940DD1;
	Wed, 26 Nov 2025 09:24:32 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id CA51E40DCF
 for <dev@dpdk.org>; Wed, 26 Nov 2025 09:24:30 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5APDrVtY698485; Wed, 26 Nov 2025 00:24:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
 aWA0uCh9juK+xGPy6noQS1tTPUlw7tvgpKxto0KoPg=; b=Z2kJwQ86Jr5J0uGvW
 VmcK2csGlkWGkfr0Ba2OSFfcFACtEIBa7j/EUa8Q19/k9DtcbUMOPKDObNeoM02H
 wgj64pdtSDCmqBcIPpaCnxePLXvmyT7ejYAMiboMZhIAmLqtb14ADgniB+tt5/qP
 PEgmoT9sqU/4mHhR1mFrqwGnx3mbspzUqp6essCVRPFgsrulxca95PRHNl9InGTu
 RD+QF4FEwMt14Z0Z1JNbFw3mcgSK6xCgiM7KyUUI9ykHZNDvAQWEoHUBBYB7K5jB
 swZDKZUI51enW/cX/+q7ElVEcu++uo6jrLhBMOUhOq+9DfKYJbh06Ei5DZ6hJn2S
 YH+3g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4amxrav124-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Nov 2025 00:24:28 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 26 Nov 2025 00:24:27 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 26 Nov 2025 00:24:27 -0800
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.21.218])
 by maili.marvell.com (Postfix) with ESMTP id 8E4C13F7040;
 Wed, 26 Nov 2025 00:24:19 -0800 (PST)
From: <pbhagavatula@marvell.com>
To: <mb@smartsharesystems.com>, <jerinj@marvell.com>, Wisam Jaddo
 <wisamm@nvidia.com>, Aman Singh <aman.deep.singh@intel.com>, Chas Williams
 <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>, Akhil Goyal
 <gakhil@marvell.com>, Anoob Joseph <anoobj@marvell.com>, Nicolas Chautru
 <nicolas.chautru@intel.com>, David Hunt <david.hunt@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Radu Nicolau <radu.nicolau@intel.com>,
 Tomasz Kantecki <tomasz.kantecki@intel.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Sunil Kumar Kori <skori@marvell.com>, "Pavan
 Nikhilesh" <pbhagavatula@marvell.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Volodymyr Fialko <vfialko@marvell.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>, John McNamara
 <john.mcnamara@intel.com>, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
CC: <dev@dpdk.org>
Subject: [RFC 2/2] examples: use optimal burst size
Date: Wed, 26 Nov 2025 13:54:14 +0530
Message-ID: <20251126082414.91933-2-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251126082414.91933-1-pbhagavatula@marvell.com>
References: <20251126082414.91933-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Xu/3+FF9 c=1 sm=1 tr=0 ts=6926b93c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=VzVU17rXeMfJ8yOAV_kA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: NtFctItRRSRf6-z90AZe5aF5sb_-teoA
X-Proofpoint-ORIG-GUID: NtFctItRRSRf6-z90AZe5aF5sb_-teoA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDA2OCBTYWx0ZWRfX3Y5/xWfpl1as
 SYZe/huQEvfdLGVrqkj4U/SrBG30Cswk075AtG9QXOcQRUfut0Q6XPcAni1HcB6K4vpIW4vsYKZ
 mrLJK1d97VoktBjrn4BWC9BzWxamoe2pFY4GLGKnFgxi0h3Qg7eb7I7SZ1ED91lx32+ap5OO3JM
 4oTqKIPrDoecEqJ8h9BfSVs5nCZ+SWHOIYS7WIO7j0QDq0G/y8e3ApbsPI+9ABJuYqfBeIC4AtS
 KTeZP5JFT8o+XI6KO7AcKjWu0mRqo5IdJNayCVEA6JHmxthkaKLUfZsH+kE9jRIXKIyCJ2vZMlF
 2caV9aj33rGNz9XOtoKBqsIGfL49ny6/5s8Eg9M2tuuIulo6/CGZXluxYkfnf6JTVp5epFywqdn
 cc9WpZHuM98vWFUxJC2iq5gfuikbKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

Replace hardcoded burst sizes with RTE_OPTIMAL_BURST_SIZE to
adapt to platform capabilities.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 app/test-eventdev/evt_options.c            |  2 +-
 app/test-flow-perf/main.c                  |  2 +-
 app/test-pmd/testpmd.h                     |  2 +-
 app/test/test_link_bonding.c               |  2 +-
 app/test/test_link_bonding_mode4.c         |  4 +--
 app/test/test_pmd_perf.c                   |  2 +-
 app/test/test_security_inline_proto.c      |  2 +-
 examples/bbdev_app/main.c                  |  2 +-
 examples/bond/main.c                       |  2 +-
 examples/distributor/main.c                |  4 +--
 examples/dma/dmafwd.c                      |  2 +-
 examples/ethtool/ethtool-app/main.c        |  2 +-
 examples/ip_fragmentation/main.c           |  2 +-
 examples/ip_reassembly/main.c              |  3 +--
 examples/ipsec-secgw/ipsec-secgw.h         |  4 +--
 examples/ipv4_multicast/main.c             |  2 +-
 examples/l2fwd-cat/l2fwd-cat.c             |  2 +-
 examples/l2fwd-crypto/main.c               |  2 +-
 examples/l2fwd-event/l2fwd_common.h        |  2 +-
 examples/l2fwd-jobstats/main.c             |  2 +-
 examples/l2fwd-keepalive/main.c            |  2 +-
 examples/l2fwd-macsec/main.c               |  2 +-
 examples/l2fwd/main.c                      |  2 +-
 examples/l3fwd-power/main.c                |  2 +-
 examples/l3fwd/l3fwd.h                     |  4 +--
 examples/l3fwd/main.c                      | 29 +++++++++++++++-------
 examples/link_status_interrupt/main.c      |  4 +--
 examples/multi_process/symmetric_mp/main.c |  2 +-
 examples/ntb/ntb_fwd.c                     |  4 +--
 examples/packet_ordering/main.c            |  2 +-
 examples/qos_meter/main.c                  |  4 +--
 examples/qos_sched/main.h                  |  4 +--
 examples/rxtx_callbacks/main.c             |  2 +-
 examples/skeleton/basicfwd.c               |  2 +-
 examples/vhost/main.h                      |  2 +-
 examples/vhost_crypto/main.c               |  2 +-
 examples/vm_power_manager/main.c           |  2 +-
 examples/vmdq/main.c                       |  2 +-
 examples/vmdq_dcb/main.c                   |  2 +-
 39 files changed, 66 insertions(+), 56 deletions(-)

diff --git a/app/test-eventdev/evt_options.c b/app/test-eventdev/evt_options.c
index 0e70c971eb2e..55e2b07157d7 100644
--- a/app/test-eventdev/evt_options.c
+++ b/app/test-eventdev/evt_options.c
@@ -37,7 +37,7 @@ evt_options_default(struct evt_options *opt)
 	opt->expiry_nsec = 1E4;   /* 10000ns ~10us */
 	opt->prod_type = EVT_PROD_TYPE_SYNT;
 	opt->eth_queues = 1;
-	opt->vector_size = 64;
+	opt->vector_size = RTE_OPTIMAL_BURST_SIZE;
 	opt->vector_tmo_nsec = 100E3;
 	opt->crypto_op_type = RTE_CRYPTO_OP_TYPE_SYMMETRIC;
 	opt->crypto_cipher_alg = RTE_CRYPTO_CIPHER_NULL;
diff --git a/app/test-flow-perf/main.c b/app/test-flow-perf/main.c
index a8876acf1f90..13c5d6bf02eb 100644
--- a/app/test-flow-perf/main.c
+++ b/app/test-flow-perf/main.c
@@ -100,7 +100,7 @@ static uint8_t max_priority;
 static uint32_t rand_seed;
 static uint64_t meter_profile_values[3]; /* CIR CBS EBS values. */
 
-#define MAX_PKT_BURST    32
+#define MAX_PKT_BURST	  RTE_OPTIMAL_BURST_SIZE
 #define LCORE_MODE_PKT    1
 #define LCORE_MODE_STATS  2
 #define MAX_STREAMS      64
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 492b5757f113..229146a8d677 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -78,7 +78,7 @@ struct cmdline_file_info {
 #define TX_DESC_MAX    2048
 
 #define MAX_PKT_BURST 512
-#define DEF_PKT_BURST 32
+#define DEF_PKT_BURST RTE_OPTIMAL_BURST_SIZE
 
 #define DEF_MBUF_CACHE 250
 
diff --git a/app/test/test_link_bonding.c b/app/test/test_link_bonding.c
index 19b064771aef..dd1b19104732 100644
--- a/app/test/test_link_bonding.c
+++ b/app/test/test_link_bonding.c
@@ -52,7 +52,7 @@
 #define RX_DESC_MAX	(2048)
 #define TX_DESC_MAX	(2048)
 #define MAX_PKT_BURST			(512)
-#define DEF_PKT_BURST			(16)
+#define DEF_PKT_BURST			(RTE_OPTIMAL_BURST_SIZE)
 
 #define BONDING_DEV_NAME			("net_bonding_ut")
 
diff --git a/app/test/test_link_bonding_mode4.c b/app/test/test_link_bonding_mode4.c
index ff13dbed93f3..ec336f06848c 100644
--- a/app/test/test_link_bonding_mode4.c
+++ b/app/test/test_link_bonding_mode4.c
@@ -41,8 +41,8 @@
 
 #define TEST_RX_DESC_MAX        (2048)
 #define TEST_TX_DESC_MAX        (2048)
-#define MAX_PKT_BURST           (32)
-#define DEF_PKT_BURST           (16)
+#define MAX_PKT_BURST		(RTE_OPTIMAL_BURST_SIZE)
+#define DEF_PKT_BURST		(RTE_OPTIMAL_BURST_SIZE)
 
 #define BONDING_DEV_NAME         ("net_bonding_m4_bond_dev")
 
diff --git a/app/test/test_pmd_perf.c b/app/test/test_pmd_perf.c
index 995b0a6f20c4..be4ebdf4c3ad 100644
--- a/app/test/test_pmd_perf.c
+++ b/app/test/test_pmd_perf.c
@@ -17,7 +17,7 @@
 #define NB_ETHPORTS_USED                (1)
 #define NB_SOCKETS                      (2)
 #define MEMPOOL_CACHE_SIZE 250
-#define MAX_PKT_BURST                   (32)
+#define MAX_PKT_BURST			(RTE_OPTIMAL_BURST_SIZE)
 #define RX_DESC_DEFAULT        (1024)
 #define TX_DESC_DEFAULT        (1024)
 #define RTE_PORT_ALL            (~(uint16_t)0x0)
diff --git a/app/test/test_security_inline_proto.c b/app/test/test_security_inline_proto.c
index 04ecfd02c6a1..40b579107008 100644
--- a/app/test/test_security_inline_proto.c
+++ b/app/test/test_security_inline_proto.c
@@ -44,7 +44,7 @@ test_inline_ipsec_sg(void)
 
 #define NB_ETHPORTS_USED		1
 #define MEMPOOL_CACHE_SIZE		32
-#define MAX_PKT_BURST			32
+#define MAX_PKT_BURST			RTE_OPTIMAL_BURST_SIZE
 #define RX_DESC_DEFAULT	1024
 #define TX_DESC_DEFAULT	1024
 #define RTE_PORT_ALL		(~(uint16_t)0x0)
diff --git a/examples/bbdev_app/main.c b/examples/bbdev_app/main.c
index 03f15f91cc6b..453bab9758f6 100644
--- a/examples/bbdev_app/main.c
+++ b/examples/bbdev_app/main.c
@@ -39,7 +39,7 @@
 #define LLR_1_BIT 0x81
 #define LLR_0_BIT 0x7F
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST	   RTE_OPTIMAL_BURST_SIZE
 #define NB_MBUF 8191
 #define MEMPOOL_CACHE_SIZE 256
 
diff --git a/examples/bond/main.c b/examples/bond/main.c
index 9f38b63cbbad..36e7e0f4b54d 100644
--- a/examples/bond/main.c
+++ b/examples/bond/main.c
@@ -52,7 +52,7 @@
 
 #define NB_MBUF   (1024*8)
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST	     RTE_OPTIMAL_BURST_SIZE
 #define BURST_TX_DRAIN_US 100      /* TX drain every ~100us */
 #define BURST_RX_INTERVAL_NS (10) /* RX poll interval ~100ns */
 
diff --git a/examples/distributor/main.c b/examples/distributor/main.c
index ea44939fba04..977b80e03697 100644
--- a/examples/distributor/main.c
+++ b/examples/distributor/main.c
@@ -23,10 +23,10 @@
 #define TX_RING_SIZE 1024
 #define NUM_MBUFS ((64*1024)-1)
 #define MBUF_CACHE_SIZE 128
-#define BURST_SIZE 64
+#define BURST_SIZE	 RTE_OPTIMAL_BURST_SIZE
 #define SCHED_RX_RING_SZ 8192
 #define SCHED_TX_RING_SZ 65536
-#define BURST_SIZE_TX 32
+#define BURST_SIZE_TX	 RTE_OPTIMAL_BURST_SIZE
 
 #define RTE_LOGTYPE_DISTRAPP RTE_LOGTYPE_USER1
 
diff --git a/examples/dma/dmafwd.c b/examples/dma/dmafwd.c
index 5ba0aaa40b21..3f9d934cd1b4 100644
--- a/examples/dma/dmafwd.c
+++ b/examples/dma/dmafwd.c
@@ -15,7 +15,7 @@
 
 /* size of ring used for software copying between rx and tx. */
 #define RTE_LOGTYPE_DMA RTE_LOGTYPE_USER1
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST		     RTE_OPTIMAL_BURST_SIZE
 #define MEMPOOL_CACHE_SIZE 512
 #define MIN_POOL_SIZE 65536U
 #define CMD_LINE_OPT_PORTMASK_INDEX 1
diff --git a/examples/ethtool/ethtool-app/main.c b/examples/ethtool/ethtool-app/main.c
index 1f011a932166..183cbd714020 100644
--- a/examples/ethtool/ethtool-app/main.c
+++ b/examples/ethtool/ethtool-app/main.c
@@ -19,7 +19,7 @@
 #include "ethapp.h"
 
 #define MAX_PORTS RTE_MAX_ETHPORTS
-#define MAX_BURST_LENGTH 32
+#define MAX_BURST_LENGTH   RTE_OPTIMAL_BURST_SIZE
 #define PORT_RX_QUEUE_SIZE 1024
 #define PORT_TX_QUEUE_SIZE 1024
 #define PKTPOOL_EXTRA_SIZE 512
diff --git a/examples/ip_fragmentation/main.c b/examples/ip_fragmentation/main.c
index 1f841028442f..57bb0f52cb90 100644
--- a/examples/ip_fragmentation/main.c
+++ b/examples/ip_fragmentation/main.c
@@ -75,7 +75,7 @@
 
 #define NB_MBUF   8192
 
-#define MAX_PKT_BURST	32
+#define MAX_PKT_BURST	  RTE_OPTIMAL_BURST_SIZE
 #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
 
 /* Configure how many packets ahead to prefetch, when reading packets */
diff --git a/examples/ip_reassembly/main.c b/examples/ip_reassembly/main.c
index 25b904dbd44d..bf4d30d0ef20 100644
--- a/examples/ip_reassembly/main.c
+++ b/examples/ip_reassembly/main.c
@@ -44,8 +44,7 @@
 
 #include <rte_ip_frag.h>
 
-#define MAX_PKT_BURST 32
-
+#define MAX_PKT_BURST RTE_OPTIMAL_BURST_SIZE
 
 #define RTE_LOGTYPE_IP_RSMBL RTE_LOGTYPE_USER1
 
diff --git a/examples/ipsec-secgw/ipsec-secgw.h b/examples/ipsec-secgw/ipsec-secgw.h
index b4ef4b6d04bc..939159dd32b0 100644
--- a/examples/ipsec-secgw/ipsec-secgw.h
+++ b/examples/ipsec-secgw/ipsec-secgw.h
@@ -11,8 +11,8 @@
 
 #define NB_SOCKETS 4
 
-#define MAX_PKT_BURST 32
-#define MAX_PKT_BURST_VEC 256
+#define MAX_PKT_BURST	  RTE_OPTIMAL_BURST_SIZE
+#define MAX_PKT_BURST_VEC RTE_OPTIMAL_BURST_SIZE
 
 #define MAX_PKTS                                  \
 	((MAX_PKT_BURST_VEC > MAX_PKT_BURST ?     \
diff --git a/examples/ipv4_multicast/main.c b/examples/ipv4_multicast/main.c
index 1eed645d02e0..742151749bbe 100644
--- a/examples/ipv4_multicast/main.c
+++ b/examples/ipv4_multicast/main.c
@@ -54,7 +54,7 @@
 /* allow max jumbo frame 9.5 KB */
 #define	JUMBO_FRAME_MAX_SIZE	0x2600
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST	  RTE_OPTIMAL_BURST_SIZE
 #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
 
 /* Configure how many packets ahead to prefetch, when reading packets */
diff --git a/examples/l2fwd-cat/l2fwd-cat.c b/examples/l2fwd-cat/l2fwd-cat.c
index 6e16705e9931..bac18496a7fb 100644
--- a/examples/l2fwd-cat/l2fwd-cat.c
+++ b/examples/l2fwd-cat/l2fwd-cat.c
@@ -17,7 +17,7 @@
 
 #define NUM_MBUFS 8191
 #define MBUF_CACHE_SIZE 250
-#define BURST_SIZE 32
+#define BURST_SIZE	RTE_OPTIMAL_BURST_SIZE
 
 /* l2fwd-cat.c: CAT enabled, basic DPDK skeleton forwarding example. */
 
diff --git a/examples/l2fwd-crypto/main.c b/examples/l2fwd-crypto/main.c
index a441312f5524..bfe0b662a5ed 100644
--- a/examples/l2fwd-crypto/main.c
+++ b/examples/l2fwd-crypto/main.c
@@ -61,7 +61,7 @@ enum cdev_type {
 #define MAX_KEY_SIZE 128
 #define MAX_IV_SIZE 16
 #define MAX_AAD_SIZE 65535
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST		RTE_OPTIMAL_BURST_SIZE
 #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
 #define SESSION_POOL_CACHE_SIZE 0
 
diff --git a/examples/l2fwd-event/l2fwd_common.h b/examples/l2fwd-event/l2fwd_common.h
index 8cf91b919cd4..2f271ac06972 100644
--- a/examples/l2fwd-event/l2fwd_common.h
+++ b/examples/l2fwd-event/l2fwd_common.h
@@ -42,7 +42,7 @@
 #include <rte_mbuf.h>
 #include <rte_spinlock.h>
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST	       RTE_OPTIMAL_BURST_SIZE
 #define MAX_RX_QUEUE_PER_LCORE 16
 #define MAX_TX_QUEUE_PER_PORT 16
 
diff --git a/examples/l2fwd-jobstats/main.c b/examples/l2fwd-jobstats/main.c
index 308b8edd2023..7018d2b7e185 100644
--- a/examples/l2fwd-jobstats/main.c
+++ b/examples/l2fwd-jobstats/main.c
@@ -39,7 +39,7 @@
 
 #define NB_MBUF   8192
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST	  RTE_OPTIMAL_BURST_SIZE
 #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
 
 /*
diff --git a/examples/l2fwd-keepalive/main.c b/examples/l2fwd-keepalive/main.c
index bff2b99531aa..29ce52580678 100644
--- a/examples/l2fwd-keepalive/main.c
+++ b/examples/l2fwd-keepalive/main.c
@@ -43,7 +43,7 @@
 
 #define NB_MBUF_PER_PORT 3000
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST	  RTE_OPTIMAL_BURST_SIZE
 #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
 
 /*
diff --git a/examples/l2fwd-macsec/main.c b/examples/l2fwd-macsec/main.c
index 73e32fc197b6..dcfa97896a7e 100644
--- a/examples/l2fwd-macsec/main.c
+++ b/examples/l2fwd-macsec/main.c
@@ -49,7 +49,7 @@ static int promiscuous_on = 1;
 
 #define RTE_LOGTYPE_L2FWD RTE_LOGTYPE_USER1
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST		RTE_OPTIMAL_BURST_SIZE
 #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
 #define MEMPOOL_CACHE_SIZE 256
 #define SESSION_POOL_CACHE_SIZE 0
diff --git a/examples/l2fwd/main.c b/examples/l2fwd/main.c
index c6fafdd01935..c98350f58fba 100644
--- a/examples/l2fwd/main.c
+++ b/examples/l2fwd/main.c
@@ -48,7 +48,7 @@ static int promiscuous_on;
 
 #define RTE_LOGTYPE_L2FWD RTE_LOGTYPE_USER1
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST	   RTE_OPTIMAL_BURST_SIZE
 #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
 #define MEMPOOL_CACHE_SIZE 256
 
diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index ec12d1cc0b73..46dbefaebbb2 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -55,7 +55,7 @@
 RTE_LOG_REGISTER(l3fwd_power_logtype, l3fwd.power, INFO);
 #define RTE_LOGTYPE_L3FWD_POWER l3fwd_power_logtype
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST RTE_OPTIMAL_BURST_SIZE
 
 #define MIN_ZERO_POLL_COUNT 10
 
diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h
index 471e3b488fe6..0fa166c6d528 100644
--- a/examples/l3fwd/l3fwd.h
+++ b/examples/l3fwd/l3fwd.h
@@ -23,14 +23,14 @@
 #define RX_DESC_DEFAULT 1024
 #define TX_DESC_DEFAULT 1024
 
-#define DEFAULT_PKT_BURST 32
+#define DEFAULT_PKT_BURST RTE_OPTIMAL_BURST_SIZE
 #define MAX_PKT_BURST 512
 #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
 
 #define MEMPOOL_CACHE_SIZE RTE_MEMPOOL_CACHE_MAX_SIZE
 #define MAX_RX_QUEUE_PER_LCORE 16
 
-#define VECTOR_SIZE_DEFAULT   MAX_PKT_BURST
+#define VECTOR_SIZE_DEFAULT   RTE_OPTIMAL_BURST_SIZE
 #define VECTOR_TMO_NS_DEFAULT 1E6 /* 1ms */
 
 #define NB_SOCKETS        8
diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
index a5626ff02d13..00375a74fbe7 100644
--- a/examples/l3fwd/main.c
+++ b/examples/l3fwd/main.c
@@ -1074,17 +1074,26 @@ parse_args(int argc, char **argv)
 		return -1;
 	}
 
-	if (evt_rsrc->vector_enabled && !evt_rsrc->vector_size) {
-		evt_rsrc->vector_size = VECTOR_SIZE_DEFAULT;
-		fprintf(stderr, "vector size set to default (%" PRIu16 ")\n",
-			evt_rsrc->vector_size);
+	if (evt_rsrc->vector_enabled) {
+		if (!evt_rsrc->vector_size) {
+			evt_rsrc->vector_size = VECTOR_SIZE_DEFAULT;
+			fprintf(stderr, "vector size set to default (%" PRIu16 ")\n",
+				evt_rsrc->vector_size);
+		} else {
+			fprintf(stderr, "vector size set to (%" PRIu16 ")\n",
+				evt_rsrc->vector_size);
+		}
 	}
 
-	if (evt_rsrc->vector_enabled && !evt_rsrc->vector_tmo_ns) {
-		evt_rsrc->vector_tmo_ns = VECTOR_TMO_NS_DEFAULT;
-		fprintf(stderr,
-			"vector timeout set to default (%" PRIu64 " ns)\n",
-			evt_rsrc->vector_tmo_ns);
+	if (evt_rsrc->vector_enabled) {
+		if (!evt_rsrc->vector_tmo_ns) {
+			evt_rsrc->vector_tmo_ns = VECTOR_TMO_NS_DEFAULT;
+			fprintf(stderr, "vector timeout set to default (%" PRIu64 " ns)\n",
+				evt_rsrc->vector_tmo_ns);
+		} else {
+			fprintf(stderr, "vector timeout set to (%" PRIu64 " ns)\n",
+				evt_rsrc->vector_tmo_ns);
+		}
 	}
 #endif
 
@@ -1687,7 +1696,9 @@ main(int argc, char **argv)
 	if (ret < 0)
 		rte_exit(EXIT_FAILURE, "Invalid L3FWD parameters\n");
 
+#ifndef RTE_LIB_EVENTDEV
 	RTE_LOG(INFO, L3FWD, "Using Rx burst %u Tx burst %u\n", rx_burst_size, tx_burst_size);
+#endif
 
 	/* Setup function pointers for lookup method. */
 	setup_l3fwd_lookup_tables();
diff --git a/examples/link_status_interrupt/main.c b/examples/link_status_interrupt/main.c
index ac9c7f62170e..2cf8e3f67f91 100644
--- a/examples/link_status_interrupt/main.c
+++ b/examples/link_status_interrupt/main.c
@@ -39,7 +39,7 @@
 
 #define NB_MBUF   8192
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST	  RTE_OPTIMAL_BURST_SIZE
 #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
 
 /*
@@ -61,7 +61,7 @@ static unsigned int lsi_rx_queue_per_lcore = 1;
 /* destination port for L2 forwarding */
 static unsigned lsi_dst_ports[RTE_MAX_ETHPORTS] = {0};
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST RTE_OPTIMAL_BURST_SIZE
 
 #define MAX_RX_QUEUE_PER_LCORE 16
 #define MAX_TX_QUEUE_PER_PORT 16
diff --git a/examples/multi_process/symmetric_mp/main.c b/examples/multi_process/symmetric_mp/main.c
index f7d8439cd4e6..1780e93fd742 100644
--- a/examples/multi_process/symmetric_mp/main.c
+++ b/examples/multi_process/symmetric_mp/main.c
@@ -46,7 +46,7 @@
 
 #define NB_MBUFS 64*1024 /* use 64k mbufs */
 #define MBUF_CACHE_SIZE 256
-#define PKT_BURST 32
+#define PKT_BURST	RTE_OPTIMAL_BURST_SIZE
 #define RX_RING_SIZE 1024
 #define TX_RING_SIZE 1024
 
diff --git a/examples/ntb/ntb_fwd.c b/examples/ntb/ntb_fwd.c
index 33f3c1ef17e4..5e7629753089 100644
--- a/examples/ntb/ntb_fwd.c
+++ b/examples/ntb/ntb_fwd.c
@@ -83,8 +83,8 @@ static uint16_t nb_desc = NTB_DEFAULT_NUM_DESCS;
 
 static uint16_t tx_free_thresh;
 
-#define NTB_MAX_PKT_BURST 32
-#define NTB_DFLT_PKT_BURST 32
+#define NTB_MAX_PKT_BURST  RTE_OPTIMAL_BURST_SIZE
+#define NTB_DFLT_PKT_BURST RTE_OPTIMAL_BURST_SIZE
 static uint16_t pkt_burst = NTB_DFLT_PKT_BURST;
 
 #define BURST_TX_RETRIES 64
diff --git a/examples/packet_ordering/main.c b/examples/packet_ordering/main.c
index 5ffdf72d71ab..a2092930523a 100644
--- a/examples/packet_ordering/main.c
+++ b/examples/packet_ordering/main.c
@@ -21,7 +21,7 @@
 #define RX_DESC_PER_QUEUE 1024
 #define TX_DESC_PER_QUEUE 1024
 
-#define MAX_PKTS_BURST 32
+#define MAX_PKTS_BURST	     RTE_OPTIMAL_BURST_SIZE
 #define REORDER_BUFFER_SIZE 8192
 #define MBUF_PER_POOL 65535
 #define MBUF_POOL_CACHE_SIZE 250
diff --git a/examples/qos_meter/main.c b/examples/qos_meter/main.c
index da1b0b228787..cdfdfde82aec 100644
--- a/examples/qos_meter/main.c
+++ b/examples/qos_meter/main.c
@@ -76,8 +76,8 @@ static struct rte_eth_conf port_conf = {
  * Packet RX/TX
  *
  ***/
-#define RTE_MBUF_F_RX_BURST_MAX                32
-#define RTE_MBUF_F_TX_BURST_MAX                32
+#define RTE_MBUF_F_RX_BURST_MAX		RTE_OPTIMAL_BURST_SIZE
+#define RTE_MBUF_F_TX_BURST_MAX		RTE_OPTIMAL_BURST_SIZE
 #define TIME_TX_DRAIN                   200000ULL
 
 static uint16_t port_rx;
diff --git a/examples/qos_sched/main.h b/examples/qos_sched/main.h
index ea66df0434fb..58abd5b9c4e2 100644
--- a/examples/qos_sched/main.h
+++ b/examples/qos_sched/main.h
@@ -24,10 +24,10 @@ extern "C" {
 #define APP_RING_SIZE (8*1024)
 #define NB_MBUF   (2*1024*1024)
 
-#define MAX_PKT_RX_BURST 64
+#define MAX_PKT_RX_BURST RTE_OPTIMAL_BURST_SIZE
 #define PKT_ENQUEUE 64
 #define PKT_DEQUEUE 63
-#define MAX_PKT_TX_BURST 64
+#define MAX_PKT_TX_BURST RTE_OPTIMAL_BURST_SIZE
 
 #define RX_PTHRESH 8 /**< Default values of RX prefetch threshold reg. */
 #define RX_HTHRESH 8 /**< Default values of RX host threshold reg. */
diff --git a/examples/rxtx_callbacks/main.c b/examples/rxtx_callbacks/main.c
index 4682921285de..8b01248f286d 100644
--- a/examples/rxtx_callbacks/main.c
+++ b/examples/rxtx_callbacks/main.c
@@ -19,7 +19,7 @@
 
 #define NUM_MBUFS 8191
 #define MBUF_CACHE_SIZE 250
-#define BURST_SIZE 32
+#define BURST_SIZE	RTE_OPTIMAL_BURST_SIZE
 
 static int hwts_dynfield_offset = -1;
 
diff --git a/examples/skeleton/basicfwd.c b/examples/skeleton/basicfwd.c
index 133293cf15bb..28ab971f56db 100644
--- a/examples/skeleton/basicfwd.c
+++ b/examples/skeleton/basicfwd.c
@@ -16,7 +16,7 @@
 
 #define NUM_MBUFS 8191
 #define MBUF_CACHE_SIZE 250
-#define BURST_SIZE 32
+#define BURST_SIZE	RTE_OPTIMAL_BURST_SIZE
 
 /* basicfwd.c: Basic DPDK skeleton forwarding example. */
 
diff --git a/examples/vhost/main.h b/examples/vhost/main.h
index c986cbc5a994..b85c251037d0 100644
--- a/examples/vhost/main.h
+++ b/examples/vhost/main.h
@@ -17,7 +17,7 @@
 
 enum {VIRTIO_RXQ, VIRTIO_TXQ, VIRTIO_QNUM};
 
-#define MAX_PKT_BURST 32		/* Max burst size for RX/TX */
+#define MAX_PKT_BURST RTE_OPTIMAL_BURST_SIZE /* Max burst size for RX/TX */
 
 struct device_statistics {
 	uint64_t	tx;
diff --git a/examples/vhost_crypto/main.c b/examples/vhost_crypto/main.c
index 8bdfc40c4b20..d60e17bee7d0 100644
--- a/examples/vhost_crypto/main.c
+++ b/examples/vhost_crypto/main.c
@@ -23,7 +23,7 @@
 #include <cmdline.h>
 
 #define NB_VIRTIO_QUEUES		(1)
-#define MAX_PKT_BURST			(64)
+#define MAX_PKT_BURST			(RTE_OPTIMAL_BURST_SIZE)
 #define MAX_IV_LEN			(32)
 #define NB_MEMPOOL_OBJS			(8192)
 #define NB_CRYPTO_DESCRIPTORS		(4096)
diff --git a/examples/vm_power_manager/main.c b/examples/vm_power_manager/main.c
index c14138202004..839348bb75d6 100644
--- a/examples/vm_power_manager/main.c
+++ b/examples/vm_power_manager/main.c
@@ -45,7 +45,7 @@
 
 #define NUM_MBUFS 8191
 #define MBUF_CACHE_SIZE 250
-#define BURST_SIZE 32
+#define BURST_SIZE	RTE_OPTIMAL_BURST_SIZE
 
 static uint32_t enabled_port_mask;
 static volatile bool force_quit;
diff --git a/examples/vmdq/main.c b/examples/vmdq/main.c
index 4a3ce6884c5c..19af8b052adf 100644
--- a/examples/vmdq/main.c
+++ b/examples/vmdq/main.c
@@ -42,7 +42,7 @@
 						TX_DESC_DEFAULT))
 #define MBUF_CACHE_SIZE 64
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST RTE_OPTIMAL_BURST_SIZE
 
 /*
  * Configurable number of RX/TX ring descriptors
diff --git a/examples/vmdq_dcb/main.c b/examples/vmdq_dcb/main.c
index 4ccc2fe4b01c..94b077ccbc75 100644
--- a/examples/vmdq_dcb/main.c
+++ b/examples/vmdq_dcb/main.c
@@ -43,7 +43,7 @@
 						TX_DESC_DEFAULT))
 #define MBUF_CACHE_SIZE 64
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST RTE_OPTIMAL_BURST_SIZE
 
 /*
  * Configurable number of RX/TX ring descriptors
-- 
2.50.1 (Apple Git-155)

