Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9193C5CFF1
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 23:08:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECC69402E6;
	Sat, 21 Feb 2026 00:08:04 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 70190402E3
 for <dev@dpdk.org>; Sat, 21 Feb 2026 00:08:03 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61KEpaCb554712; Fri, 20 Feb 2026 15:08:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
 DiXi6RyGkc/185gzizaIX8TPbIbMEN+MlzQCVKXb2s=; b=B3xhqzLfd6lkuxl+0
 B0eRJEFEs0mGNez7a1G9YtaTcR6JiYb6SpG7npMtiGRWv8qwdYKX8wbyBQ1YWluw
 KPB1SJgZKmZr1FVG+r4r31n0KnEGfQUl7jAY8DQbA0qcooTgWcFPKF2vozNtm0ny
 SR+/LZLO7FiBLHgs7GkEcDDFC41xcpPjmnr9h6xfzfouquFlATCdfRuDb4TF3UkC
 dLmYvyXeJEQu2Goo44dXB7XNJeDtR+OMM1dQFrM8vb7T0Hdr1Q5S4pWq3di22Zuw
 +I/fEJ+YD0I5S/JV00Kb4tvyfEhxdeEhHwS/4o81HdERYa0KGBCpjG2SuPkvjIzs
 Jd0hQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cdsfan7nf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Feb 2026 15:08:01 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Feb 2026 15:08:17 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 20 Feb 2026 15:08:16 -0800
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.165.174])
 by maili.marvell.com (Postfix) with ESMTP id DB8B15B6943;
 Fri, 20 Feb 2026 15:07:51 -0800 (PST)
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
Subject: [PATCH 2/2] examples: use default mbuf burst size
Date: Sat, 21 Feb 2026 04:37:44 +0530
Message-ID: <20260220230745.26418-2-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260220230745.26418-1-pbhagavatula@marvell.com>
References: <20251126082414.91933-1-pbhagavatula@marvell.com>
 <20260220230745.26418-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=T/GBjvKQ c=1 sm=1 tr=0 ts=6998e951 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8 a=VzVU17rXeMfJ8yOAV_kA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE4OSBTYWx0ZWRfXyl98LYGqK6Hb
 YRCQK3w6A6/jx1FB42bbZzXJBb6YKSkdy0F+BY5L0DiYuiRFU9ib5wRrJ3+QONTqb1BccWyFzpl
 8TlQPC/zsQY7VGL2U0SyBLfRM/tOxaYjWpPfYH21pUuygudXanXDQA2HsOkCPBBiL8C09Vb7PEs
 e+0x2A8esaYPrqwW+LXIhz/YHIf5nmyaQTU2CP8M3/lwo+ipr7+FDExDBduEL/Ex1vzMrKR+U11
 EfeetPMJpTbCeXnYpml4bHhIsgNeYLKP/Rh+7pu5/2wl+peYgJdXhL21nlrcHu6sGYA9hkB3J23
 rOu+tyIPh8eCmxhOmOJUlM5AfeVDKRMcJ5MUROXSGaqeEWpCNn7JB1r66Lh4xWIXZZ2fBRhAuQM
 GOZgO7iTkUfN+br3Oxp7VdL4YHjaUBcpp8+ydS2EptiMr1ZBk6e2ngGGS/2qIDLqKnLWyTOOcWx
 tPTy/qzROc7lVzsw6jw==
X-Proofpoint-ORIG-GUID: B1qSwh3RSGtv6Bguyi5pHXq3BOMmmH-9
X-Proofpoint-GUID: B1qSwh3RSGtv6Bguyi5pHXq3BOMmmH-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_04,2026-02-20_04,2025-10-01_01
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

Replace hardcoded burst sizes with RTE_MBUF_BURST_SIZE_DEFAULT
to adapt to platform-specific optimal burst sizes.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 app/test-eventdev/evt_options.c            |  2 +-
 app/test-flow-perf/main.c                  |  2 +-
 app/test-pmd/testpmd.h                     |  2 +-
 app/test/test_link_bonding.c               |  2 +-
 app/test/test_link_bonding_mode4.c         |  4 ++--
 app/test/test_pmd_perf.c                   |  2 +-
 app/test/test_security_inline_proto.c      |  2 +-
 examples/bbdev_app/main.c                  |  2 +-
 examples/bond/main.c                       |  2 +-
 examples/distributor/main.c                |  4 ++--
 examples/dma/dmafwd.c                      |  2 +-
 examples/ethtool/ethtool-app/main.c        |  2 +-
 examples/ip_fragmentation/main.c           |  2 +-
 examples/ip_reassembly/main.c              |  3 +--
 examples/ipsec-secgw/ipsec-secgw.h         |  4 ++--
 examples/ipv4_multicast/main.c             |  2 +-
 examples/l2fwd-cat/l2fwd-cat.c             |  2 +-
 examples/l2fwd-crypto/main.c               |  2 +-
 examples/l2fwd-event/l2fwd_common.h        |  2 +-
 examples/l2fwd-jobstats/main.c             |  2 +-
 examples/l2fwd-keepalive/main.c            |  2 +-
 examples/l2fwd-macsec/main.c               |  2 +-
 examples/l2fwd/main.c                      |  2 +-
 examples/l3fwd-power/main.c                |  2 +-
 examples/l3fwd/l3fwd.h                     |  4 ++--
 examples/l3fwd/main.c                      | 27 ++++++++++++++--------
 examples/link_status_interrupt/main.c      |  4 ++--
 examples/multi_process/symmetric_mp/main.c |  2 +-
 examples/ntb/ntb_fwd.c                     |  4 ++--
 examples/packet_ordering/main.c            |  2 +-
 examples/qos_meter/main.c                  |  4 ++--
 examples/qos_sched/main.h                  |  4 ++--
 examples/rxtx_callbacks/main.c             |  2 +-
 examples/skeleton/basicfwd.c               |  2 +-
 examples/vhost/main.h                      |  2 +-
 examples/vhost_crypto/main.c               |  2 +-
 examples/vm_power_manager/main.c           |  2 +-
 examples/vmdq/main.c                       |  2 +-
 examples/vmdq_dcb/main.c                   |  2 +-
 39 files changed, 64 insertions(+), 56 deletions(-)

diff --git a/app/test-eventdev/evt_options.c b/app/test-eventdev/evt_options.c
index 0e70c971eb2e..ebdb1eb33478 100644
--- a/app/test-eventdev/evt_options.c
+++ b/app/test-eventdev/evt_options.c
@@ -37,7 +37,7 @@ evt_options_default(struct evt_options *opt)
 	opt->expiry_nsec = 1E4;   /* 10000ns ~10us */
 	opt->prod_type = EVT_PROD_TYPE_SYNT;
 	opt->eth_queues = 1;
-	opt->vector_size = 64;
+	opt->vector_size = RTE_MBUF_BURST_SIZE_DEFAULT;
 	opt->vector_tmo_nsec = 100E3;
 	opt->crypto_op_type = RTE_CRYPTO_OP_TYPE_SYMMETRIC;
 	opt->crypto_cipher_alg = RTE_CRYPTO_CIPHER_NULL;
diff --git a/app/test-flow-perf/main.c b/app/test-flow-perf/main.c
index 6636d1517f48..fc4f70d583ce 100644
--- a/app/test-flow-perf/main.c
+++ b/app/test-flow-perf/main.c
@@ -100,7 +100,7 @@ static uint8_t max_priority;
 static uint32_t rand_seed;
 static uint64_t meter_profile_values[3]; /* CIR CBS EBS values. */
 
-#define MAX_PKT_BURST    32
+#define MAX_PKT_BURST	  RTE_MBUF_BURST_SIZE_DEFAULT
 #define LCORE_MODE_PKT    1
 #define LCORE_MODE_STATS  2
 #define MAX_STREAMS      64
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index f319471c732e..107cc2891a21 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -78,7 +78,7 @@ struct cmdline_file_info {
 #define TX_DESC_MAX    2048
 
 #define MAX_PKT_BURST 512
-#define DEF_PKT_BURST 32
+#define DEF_PKT_BURST RTE_MBUF_BURST_SIZE_DEFAULT
 
 #define DEF_MBUF_CACHE 250
 
diff --git a/app/test/test_link_bonding.c b/app/test/test_link_bonding.c
index 19b064771aef..6fe9b40e5f54 100644
--- a/app/test/test_link_bonding.c
+++ b/app/test/test_link_bonding.c
@@ -52,7 +52,7 @@
 #define RX_DESC_MAX	(2048)
 #define TX_DESC_MAX	(2048)
 #define MAX_PKT_BURST			(512)
-#define DEF_PKT_BURST			(16)
+#define DEF_PKT_BURST			(RTE_MBUF_BURST_SIZE_DEFAULT)
 
 #define BONDING_DEV_NAME			("net_bonding_ut")
 
diff --git a/app/test/test_link_bonding_mode4.c b/app/test/test_link_bonding_mode4.c
index ff13dbed93f3..c772108f31d5 100644
--- a/app/test/test_link_bonding_mode4.c
+++ b/app/test/test_link_bonding_mode4.c
@@ -41,8 +41,8 @@
 
 #define TEST_RX_DESC_MAX        (2048)
 #define TEST_TX_DESC_MAX        (2048)
-#define MAX_PKT_BURST           (32)
-#define DEF_PKT_BURST           (16)
+#define MAX_PKT_BURST		(RTE_MBUF_BURST_SIZE_DEFAULT)
+#define DEF_PKT_BURST		(RTE_MBUF_BURST_SIZE_DEFAULT)
 
 #define BONDING_DEV_NAME         ("net_bonding_m4_bond_dev")
 
diff --git a/app/test/test_pmd_perf.c b/app/test/test_pmd_perf.c
index 995b0a6f20c4..b0ec93f89a2a 100644
--- a/app/test/test_pmd_perf.c
+++ b/app/test/test_pmd_perf.c
@@ -17,7 +17,7 @@
 #define NB_ETHPORTS_USED                (1)
 #define NB_SOCKETS                      (2)
 #define MEMPOOL_CACHE_SIZE 250
-#define MAX_PKT_BURST                   (32)
+#define MAX_PKT_BURST			(RTE_MBUF_BURST_SIZE_DEFAULT)
 #define RX_DESC_DEFAULT        (1024)
 #define TX_DESC_DEFAULT        (1024)
 #define RTE_PORT_ALL            (~(uint16_t)0x0)
diff --git a/app/test/test_security_inline_proto.c b/app/test/test_security_inline_proto.c
index 8b88fce3e990..5c86a9a7707a 100644
--- a/app/test/test_security_inline_proto.c
+++ b/app/test/test_security_inline_proto.c
@@ -44,7 +44,7 @@ test_inline_ipsec_sg(void)
 
 #define NB_ETHPORTS_USED		1
 #define MEMPOOL_CACHE_SIZE		32
-#define MAX_PKT_BURST			32
+#define MAX_PKT_BURST			RTE_MBUF_BURST_SIZE_DEFAULT
 #define RX_DESC_DEFAULT	1024
 #define TX_DESC_DEFAULT	1024
 #define RTE_PORT_ALL		(~(uint16_t)0x0)
diff --git a/examples/bbdev_app/main.c b/examples/bbdev_app/main.c
index 03f15f91cc6b..e318025c9095 100644
--- a/examples/bbdev_app/main.c
+++ b/examples/bbdev_app/main.c
@@ -39,7 +39,7 @@
 #define LLR_1_BIT 0x81
 #define LLR_0_BIT 0x7F
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST	   RTE_MBUF_BURST_SIZE_DEFAULT
 #define NB_MBUF 8191
 #define MEMPOOL_CACHE_SIZE 256
 
diff --git a/examples/bond/main.c b/examples/bond/main.c
index 4e8eeb7a5e1b..0fd968c44b4a 100644
--- a/examples/bond/main.c
+++ b/examples/bond/main.c
@@ -51,7 +51,7 @@
 
 #define NB_MBUF   (1024*8)
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST	     RTE_MBUF_BURST_SIZE_DEFAULT
 #define BURST_TX_DRAIN_US 100      /* TX drain every ~100us */
 #define BURST_RX_INTERVAL_NS (10) /* RX poll interval ~100ns */
 
diff --git a/examples/distributor/main.c b/examples/distributor/main.c
index ea44939fba04..d60de85a369f 100644
--- a/examples/distributor/main.c
+++ b/examples/distributor/main.c
@@ -23,10 +23,10 @@
 #define TX_RING_SIZE 1024
 #define NUM_MBUFS ((64*1024)-1)
 #define MBUF_CACHE_SIZE 128
-#define BURST_SIZE 64
+#define BURST_SIZE	 RTE_MBUF_BURST_SIZE_DEFAULT
 #define SCHED_RX_RING_SZ 8192
 #define SCHED_TX_RING_SZ 65536
-#define BURST_SIZE_TX 32
+#define BURST_SIZE_TX	 RTE_MBUF_BURST_SIZE_DEFAULT
 
 #define RTE_LOGTYPE_DISTRAPP RTE_LOGTYPE_USER1
 
diff --git a/examples/dma/dmafwd.c b/examples/dma/dmafwd.c
index 5ba0aaa40b21..d282db911dc5 100644
--- a/examples/dma/dmafwd.c
+++ b/examples/dma/dmafwd.c
@@ -15,7 +15,7 @@
 
 /* size of ring used for software copying between rx and tx. */
 #define RTE_LOGTYPE_DMA RTE_LOGTYPE_USER1
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST		     RTE_MBUF_BURST_SIZE_DEFAULT
 #define MEMPOOL_CACHE_SIZE 512
 #define MIN_POOL_SIZE 65536U
 #define CMD_LINE_OPT_PORTMASK_INDEX 1
diff --git a/examples/ethtool/ethtool-app/main.c b/examples/ethtool/ethtool-app/main.c
index b6bbae70d29f..cbfb92ce4d94 100644
--- a/examples/ethtool/ethtool-app/main.c
+++ b/examples/ethtool/ethtool-app/main.c
@@ -19,7 +19,7 @@
 #include "ethapp.h"
 
 #define MAX_PORTS RTE_MAX_ETHPORTS
-#define MAX_BURST_LENGTH 32
+#define MAX_BURST_LENGTH   RTE_MBUF_BURST_SIZE_DEFAULT
 #define PORT_RX_QUEUE_SIZE 1024
 #define PORT_TX_QUEUE_SIZE 1024
 #define PKTPOOL_EXTRA_SIZE 512
diff --git a/examples/ip_fragmentation/main.c b/examples/ip_fragmentation/main.c
index 218068237331..aa944a353233 100644
--- a/examples/ip_fragmentation/main.c
+++ b/examples/ip_fragmentation/main.c
@@ -74,7 +74,7 @@
 
 #define NB_MBUF   8192
 
-#define MAX_PKT_BURST	32
+#define MAX_PKT_BURST	  RTE_MBUF_BURST_SIZE_DEFAULT
 #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
 
 /* Configure how many packets ahead to prefetch, when reading packets */
diff --git a/examples/ip_reassembly/main.c b/examples/ip_reassembly/main.c
index 520fbea1c2ec..20858643f721 100644
--- a/examples/ip_reassembly/main.c
+++ b/examples/ip_reassembly/main.c
@@ -43,8 +43,7 @@
 
 #include <rte_ip_frag.h>
 
-#define MAX_PKT_BURST 32
-
+#define MAX_PKT_BURST RTE_MBUF_BURST_SIZE_DEFAULT
 
 #define RTE_LOGTYPE_IP_RSMBL RTE_LOGTYPE_USER1
 
diff --git a/examples/ipsec-secgw/ipsec-secgw.h b/examples/ipsec-secgw/ipsec-secgw.h
index b4ef4b6d04bc..191b60c8e2ee 100644
--- a/examples/ipsec-secgw/ipsec-secgw.h
+++ b/examples/ipsec-secgw/ipsec-secgw.h
@@ -11,8 +11,8 @@
 
 #define NB_SOCKETS 4
 
-#define MAX_PKT_BURST 32
-#define MAX_PKT_BURST_VEC 256
+#define MAX_PKT_BURST	  RTE_MBUF_BURST_SIZE_DEFAULT
+#define MAX_PKT_BURST_VEC RTE_MBUF_BURST_SIZE_DEFAULT
 
 #define MAX_PKTS                                  \
 	((MAX_PKT_BURST_VEC > MAX_PKT_BURST ?     \
diff --git a/examples/ipv4_multicast/main.c b/examples/ipv4_multicast/main.c
index bd4c3f335be0..1ea330c5e4a6 100644
--- a/examples/ipv4_multicast/main.c
+++ b/examples/ipv4_multicast/main.c
@@ -53,7 +53,7 @@
 /* allow max jumbo frame 9.5 KB */
 #define	JUMBO_FRAME_MAX_SIZE	0x2600
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST	  RTE_MBUF_BURST_SIZE_DEFAULT
 #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
 
 /* Configure how many packets ahead to prefetch, when reading packets */
diff --git a/examples/l2fwd-cat/l2fwd-cat.c b/examples/l2fwd-cat/l2fwd-cat.c
index 6e16705e9931..d79e9b0a29b3 100644
--- a/examples/l2fwd-cat/l2fwd-cat.c
+++ b/examples/l2fwd-cat/l2fwd-cat.c
@@ -17,7 +17,7 @@
 
 #define NUM_MBUFS 8191
 #define MBUF_CACHE_SIZE 250
-#define BURST_SIZE 32
+#define BURST_SIZE	RTE_MBUF_BURST_SIZE_DEFAULT
 
 /* l2fwd-cat.c: CAT enabled, basic DPDK skeleton forwarding example. */
 
diff --git a/examples/l2fwd-crypto/main.c b/examples/l2fwd-crypto/main.c
index a441312f5524..4c27bb7d78e3 100644
--- a/examples/l2fwd-crypto/main.c
+++ b/examples/l2fwd-crypto/main.c
@@ -61,7 +61,7 @@ enum cdev_type {
 #define MAX_KEY_SIZE 128
 #define MAX_IV_SIZE 16
 #define MAX_AAD_SIZE 65535
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST		RTE_MBUF_BURST_SIZE_DEFAULT
 #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
 #define SESSION_POOL_CACHE_SIZE 0
 
diff --git a/examples/l2fwd-event/l2fwd_common.h b/examples/l2fwd-event/l2fwd_common.h
index f4f1c45cd16b..f8fee3e45963 100644
--- a/examples/l2fwd-event/l2fwd_common.h
+++ b/examples/l2fwd-event/l2fwd_common.h
@@ -41,7 +41,7 @@
 #include <rte_mbuf.h>
 #include <rte_spinlock.h>
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST	       RTE_MBUF_BURST_SIZE_DEFAULT
 #define MAX_RX_QUEUE_PER_LCORE 16
 #define MAX_TX_QUEUE_PER_PORT 16
 
diff --git a/examples/l2fwd-jobstats/main.c b/examples/l2fwd-jobstats/main.c
index a7cd5b4840d5..a2531c6a6214 100644
--- a/examples/l2fwd-jobstats/main.c
+++ b/examples/l2fwd-jobstats/main.c
@@ -38,7 +38,7 @@
 
 #define NB_MBUF   8192
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST	  RTE_MBUF_BURST_SIZE_DEFAULT
 #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
 
 /*
diff --git a/examples/l2fwd-keepalive/main.c b/examples/l2fwd-keepalive/main.c
index 993e0bf9dacc..0e384266f510 100644
--- a/examples/l2fwd-keepalive/main.c
+++ b/examples/l2fwd-keepalive/main.c
@@ -42,7 +42,7 @@
 
 #define NB_MBUF_PER_PORT 3000
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST	  RTE_MBUF_BURST_SIZE_DEFAULT
 #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
 
 /*
diff --git a/examples/l2fwd-macsec/main.c b/examples/l2fwd-macsec/main.c
index 98763440bc7a..957c2a900c97 100644
--- a/examples/l2fwd-macsec/main.c
+++ b/examples/l2fwd-macsec/main.c
@@ -48,7 +48,7 @@ static int promiscuous_on = 1;
 
 #define RTE_LOGTYPE_L2FWD RTE_LOGTYPE_USER1
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST		RTE_MBUF_BURST_SIZE_DEFAULT
 #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
 #define MEMPOOL_CACHE_SIZE 256
 #define SESSION_POOL_CACHE_SIZE 0
diff --git a/examples/l2fwd/main.c b/examples/l2fwd/main.c
index 59ea3172aee5..1feda5a1d43a 100644
--- a/examples/l2fwd/main.c
+++ b/examples/l2fwd/main.c
@@ -47,7 +47,7 @@ static int promiscuous_on;
 
 #define RTE_LOGTYPE_L2FWD RTE_LOGTYPE_USER1
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST	   RTE_MBUF_BURST_SIZE_DEFAULT
 #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
 #define MEMPOOL_CACHE_SIZE 256
 
diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index 02ec17d79963..8cc099132057 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -54,7 +54,7 @@
 RTE_LOG_REGISTER(l3fwd_power_logtype, l3fwd.power, INFO);
 #define RTE_LOGTYPE_L3FWD_POWER l3fwd_power_logtype
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST RTE_MBUF_BURST_SIZE_DEFAULT
 
 #define MIN_ZERO_POLL_COUNT 10
 
diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h
index 471e3b488fe6..7979249e726a 100644
--- a/examples/l3fwd/l3fwd.h
+++ b/examples/l3fwd/l3fwd.h
@@ -23,14 +23,14 @@
 #define RX_DESC_DEFAULT 1024
 #define TX_DESC_DEFAULT 1024
 
-#define DEFAULT_PKT_BURST 32
+#define DEFAULT_PKT_BURST RTE_MBUF_BURST_SIZE_DEFAULT
 #define MAX_PKT_BURST 512
 #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
 
 #define MEMPOOL_CACHE_SIZE RTE_MEMPOOL_CACHE_MAX_SIZE
 #define MAX_RX_QUEUE_PER_LCORE 16
 
-#define VECTOR_SIZE_DEFAULT   MAX_PKT_BURST
+#define VECTOR_SIZE_DEFAULT   RTE_MBUF_BURST_SIZE_DEFAULT
 #define VECTOR_TMO_NS_DEFAULT 1E6 /* 1ms */
 
 #define NB_SOCKETS        8
diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
index 4c641947949a..5fdd7f2bbc8f 100644
--- a/examples/l3fwd/main.c
+++ b/examples/l3fwd/main.c
@@ -1073,17 +1073,26 @@ parse_args(int argc, char **argv)
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
 
diff --git a/examples/link_status_interrupt/main.c b/examples/link_status_interrupt/main.c
index aa33e71d7aa5..0adc93153bd5 100644
--- a/examples/link_status_interrupt/main.c
+++ b/examples/link_status_interrupt/main.c
@@ -38,7 +38,7 @@
 
 #define NB_MBUF   8192
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST	  RTE_MBUF_BURST_SIZE_DEFAULT
 #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
 
 /*
@@ -60,7 +60,7 @@ static unsigned int lsi_rx_queue_per_lcore = 1;
 /* destination port for L2 forwarding */
 static unsigned lsi_dst_ports[RTE_MAX_ETHPORTS] = {0};
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST RTE_MBUF_BURST_SIZE_DEFAULT
 
 #define MAX_RX_QUEUE_PER_LCORE 16
 #define MAX_TX_QUEUE_PER_PORT 16
diff --git a/examples/multi_process/symmetric_mp/main.c b/examples/multi_process/symmetric_mp/main.c
index 7314a9c6ea83..f10b66963f3d 100644
--- a/examples/multi_process/symmetric_mp/main.c
+++ b/examples/multi_process/symmetric_mp/main.c
@@ -45,7 +45,7 @@
 
 #define NB_MBUFS 64*1024 /* use 64k mbufs */
 #define MBUF_CACHE_SIZE 256
-#define PKT_BURST 32
+#define PKT_BURST	RTE_MBUF_BURST_SIZE_DEFAULT
 #define RX_RING_SIZE 1024
 #define TX_RING_SIZE 1024
 
diff --git a/examples/ntb/ntb_fwd.c b/examples/ntb/ntb_fwd.c
index 33f3c1ef17e4..330693c13b38 100644
--- a/examples/ntb/ntb_fwd.c
+++ b/examples/ntb/ntb_fwd.c
@@ -83,8 +83,8 @@ static uint16_t nb_desc = NTB_DEFAULT_NUM_DESCS;
 
 static uint16_t tx_free_thresh;
 
-#define NTB_MAX_PKT_BURST 32
-#define NTB_DFLT_PKT_BURST 32
+#define NTB_MAX_PKT_BURST  RTE_MBUF_BURST_SIZE_DEFAULT
+#define NTB_DFLT_PKT_BURST RTE_MBUF_BURST_SIZE_DEFAULT
 static uint16_t pkt_burst = NTB_DFLT_PKT_BURST;
 
 #define BURST_TX_RETRIES 64
diff --git a/examples/packet_ordering/main.c b/examples/packet_ordering/main.c
index 5ffdf72d71ab..7bbd8133e570 100644
--- a/examples/packet_ordering/main.c
+++ b/examples/packet_ordering/main.c
@@ -21,7 +21,7 @@
 #define RX_DESC_PER_QUEUE 1024
 #define TX_DESC_PER_QUEUE 1024
 
-#define MAX_PKTS_BURST 32
+#define MAX_PKTS_BURST	     RTE_MBUF_BURST_SIZE_DEFAULT
 #define REORDER_BUFFER_SIZE 8192
 #define MBUF_PER_POOL 65535
 #define MBUF_POOL_CACHE_SIZE 250
diff --git a/examples/qos_meter/main.c b/examples/qos_meter/main.c
index da1b0b228787..9e493ac4e79f 100644
--- a/examples/qos_meter/main.c
+++ b/examples/qos_meter/main.c
@@ -76,8 +76,8 @@ static struct rte_eth_conf port_conf = {
  * Packet RX/TX
  *
  ***/
-#define RTE_MBUF_F_RX_BURST_MAX                32
-#define RTE_MBUF_F_TX_BURST_MAX                32
+#define RTE_MBUF_F_RX_BURST_MAX		RTE_MBUF_BURST_SIZE_DEFAULT
+#define RTE_MBUF_F_TX_BURST_MAX		RTE_MBUF_BURST_SIZE_DEFAULT
 #define TIME_TX_DRAIN                   200000ULL
 
 static uint16_t port_rx;
diff --git a/examples/qos_sched/main.h b/examples/qos_sched/main.h
index ea66df0434fb..3cac415003d4 100644
--- a/examples/qos_sched/main.h
+++ b/examples/qos_sched/main.h
@@ -24,10 +24,10 @@ extern "C" {
 #define APP_RING_SIZE (8*1024)
 #define NB_MBUF   (2*1024*1024)
 
-#define MAX_PKT_RX_BURST 64
+#define MAX_PKT_RX_BURST RTE_MBUF_BURST_SIZE_DEFAULT
 #define PKT_ENQUEUE 64
 #define PKT_DEQUEUE 63
-#define MAX_PKT_TX_BURST 64
+#define MAX_PKT_TX_BURST RTE_MBUF_BURST_SIZE_DEFAULT
 
 #define RX_PTHRESH 8 /**< Default values of RX prefetch threshold reg. */
 #define RX_HTHRESH 8 /**< Default values of RX host threshold reg. */
diff --git a/examples/rxtx_callbacks/main.c b/examples/rxtx_callbacks/main.c
index 4682921285de..774516994e31 100644
--- a/examples/rxtx_callbacks/main.c
+++ b/examples/rxtx_callbacks/main.c
@@ -19,7 +19,7 @@
 
 #define NUM_MBUFS 8191
 #define MBUF_CACHE_SIZE 250
-#define BURST_SIZE 32
+#define BURST_SIZE	RTE_MBUF_BURST_SIZE_DEFAULT
 
 static int hwts_dynfield_offset = -1;
 
diff --git a/examples/skeleton/basicfwd.c b/examples/skeleton/basicfwd.c
index 133293cf15bb..22e2576bee54 100644
--- a/examples/skeleton/basicfwd.c
+++ b/examples/skeleton/basicfwd.c
@@ -16,7 +16,7 @@
 
 #define NUM_MBUFS 8191
 #define MBUF_CACHE_SIZE 250
-#define BURST_SIZE 32
+#define BURST_SIZE	RTE_MBUF_BURST_SIZE_DEFAULT
 
 /* basicfwd.c: Basic DPDK skeleton forwarding example. */
 
diff --git a/examples/vhost/main.h b/examples/vhost/main.h
index c986cbc5a994..e684f8b3ed16 100644
--- a/examples/vhost/main.h
+++ b/examples/vhost/main.h
@@ -17,7 +17,7 @@
 
 enum {VIRTIO_RXQ, VIRTIO_TXQ, VIRTIO_QNUM};
 
-#define MAX_PKT_BURST 32		/* Max burst size for RX/TX */
+#define MAX_PKT_BURST RTE_MBUF_BURST_SIZE_DEFAULT /* Max burst size for RX/TX */
 
 struct device_statistics {
 	uint64_t	tx;
diff --git a/examples/vhost_crypto/main.c b/examples/vhost_crypto/main.c
index 8bdfc40c4b20..37a7b9cc18dc 100644
--- a/examples/vhost_crypto/main.c
+++ b/examples/vhost_crypto/main.c
@@ -23,7 +23,7 @@
 #include <cmdline.h>
 
 #define NB_VIRTIO_QUEUES		(1)
-#define MAX_PKT_BURST			(64)
+#define MAX_PKT_BURST			(RTE_MBUF_BURST_SIZE_DEFAULT)
 #define MAX_IV_LEN			(32)
 #define NB_MEMPOOL_OBJS			(8192)
 #define NB_CRYPTO_DESCRIPTORS		(4096)
diff --git a/examples/vm_power_manager/main.c b/examples/vm_power_manager/main.c
index c14138202004..11a412e41e2d 100644
--- a/examples/vm_power_manager/main.c
+++ b/examples/vm_power_manager/main.c
@@ -45,7 +45,7 @@
 
 #define NUM_MBUFS 8191
 #define MBUF_CACHE_SIZE 250
-#define BURST_SIZE 32
+#define BURST_SIZE	RTE_MBUF_BURST_SIZE_DEFAULT
 
 static uint32_t enabled_port_mask;
 static volatile bool force_quit;
diff --git a/examples/vmdq/main.c b/examples/vmdq/main.c
index 12ef5bffc2e6..eee44ff5c9ec 100644
--- a/examples/vmdq/main.c
+++ b/examples/vmdq/main.c
@@ -41,7 +41,7 @@
 						TX_DESC_DEFAULT))
 #define MBUF_CACHE_SIZE 64
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST RTE_MBUF_BURST_SIZE_DEFAULT
 
 /*
  * Configurable number of RX/TX ring descriptors
diff --git a/examples/vmdq_dcb/main.c b/examples/vmdq_dcb/main.c
index 6eccee086d82..d60261d535a8 100644
--- a/examples/vmdq_dcb/main.c
+++ b/examples/vmdq_dcb/main.c
@@ -42,7 +42,7 @@
 						TX_DESC_DEFAULT))
 #define MBUF_CACHE_SIZE 64
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST RTE_MBUF_BURST_SIZE_DEFAULT
 
 /*
  * Configurable number of RX/TX ring descriptors
-- 
2.50.1 (Apple Git-155)

