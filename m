Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2C2F8DFC5
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 21:12:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BDF240662;
	Thu, 16 Apr 2026 23:12:20 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5929E40661
 for <dev@dpdk.org>; Thu, 16 Apr 2026 23:12:18 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63GHA7Ok1235788; Thu, 16 Apr 2026 14:12:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=g
 7v9hZoUAg0FKY76+fHH0Gy6VD6gDAX1NKMkDZ1RGKQ=; b=ZFNBZjJLSEZuZU73Z
 M7zvssiysIMcC99nX/3Wyqw1bWoBd4ES+WMMRasG+DB60nzqkEV7882KyaCkH8R2
 qy+zIqjCHh6Xfh7ke19ZO6+Nzsy1TqSXtz1CSJHrspSh3Rn3G7wyC+uyNvYKe2Ms
 brgAQLMBqvdCdT1Y9I3rv5bLFXLCTns8+RLnedUTmMTJsJv04tNw1v2pUi0gkUs9
 /p53wZu7FkqtFsSDqCtpDxWYymVjdrJuD+7vqeZzg7qP8bPZREzdYd+ffVxvPOhE
 vTU3Z0sBSDxzWq/oikvQlrHu77i45xXB5oO1Jhwq/CM09I1zrIOde/3A1k0v4ZaI
 /LfGA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dk3wy0md4-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Apr 2026 14:12:15 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 16 Apr 2026 14:12:13 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 16 Apr 2026 14:12:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 16 Apr 2026 14:12:12 -0700
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.165.174])
 by maili.marvell.com (Postfix) with ESMTP id 44F983F704F;
 Thu, 16 Apr 2026 14:12:05 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Wisam Jaddo <wisamm@nvidia.com>, Aman Singh
 <aman.deep.singh@intel.com>, Nicolas Chautru <nicolas.chautru@intel.com>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Radu Nicolau <radu.nicolau@intel.com>,
 "Akhil Goyal" <gakhil@marvell.com>, Tomasz Kantecki
 <tomasz.kantecki@intel.com>, "Fan Zhang" <fanzhang.oss@gmail.com>, Sunil
 Kumar Kori <skori@marvell.com>,
 "Pavan Nikhilesh" <pbhagavatula@marvell.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, Sivaprasad Tummala
 <sivaprasad.tummala@amd.com>, Volodymyr Fialko <vfialko@marvell.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>, John McNamara
 <john.mcnamara@intel.com>, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH v2 2/2] examples: use default mbuf burst size
Date: Fri, 17 Apr 2026 02:41:58 +0530
Message-ID: <20260416211159.44785-2-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260416211159.44785-1-pbhagavatula@marvell.com>
References: <20260220230745.26418-1-pbhagavatula@marvell.com>
 <20260416211159.44785-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDIwMCBTYWx0ZWRfXynFviekGzApw
 PD9H0vQfnU68Y41Wl8kbtYvw1mbdywhvUIXZR1qIp2jHF4h7C/9Va0tj+Tk/IP7wZp2k5qJaHDq
 0WgVP3xu+a7PConvwmGbqsPPPl6ZUfYfLnLdReIRbWkeolj8USW8Y6EQ1qsrhWPZatRtQurlf7v
 fqwQZNrMHXnwXrucQZCDF50j2+SZAcMbB3TfromSwwutB/GXAnZL5Lr6Lksd7OHcmI1C0SXQFAk
 U8MbIDu1qm6iQtWaGnBksaLWmfSpPwMsoJr/vuStHV22zNZD1q55glw6beJh8aogSGpyRJjXYI9
 3zwBxDAWgepONrZuGkaJdN9BuSvZ9YXB8RVs8Lte6dbqOOwfwvux4INhJpDjnqw7vlSNnCczK/e
 bvjUdrrY1vCNalDwGxokxKu08DucbLhkwB1/yyPnW+PvKwxfnf9qrXp7v3AiRlVQwiQkG3iIg89
 gXu1bqnmPj1j0MMcz1A==
X-Proofpoint-ORIG-GUID: VCXp-3mPePUkxVgBznNzp8HyuYg8hdYD
X-Proofpoint-GUID: VCXp-3mPePUkxVgBznNzp8HyuYg8hdYD
X-Authority-Analysis: v=2.4 cv=LsqiDHdc c=1 sm=1 tr=0 ts=69e150af cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=24SG6fbtq0NperX6ajIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
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
 app/test-pmd/testpmd.h                     |  6 +++++-
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
 examples/l3fwd/l3fwd.h                     |  8 ++++++--
 examples/link_status_interrupt/main.c      |  4 +---
 examples/multi_process/symmetric_mp/main.c |  2 +-
 examples/packet_ordering/main.c            |  2 +-
 examples/qos_meter/main.c                  | 12 ++++++------
 examples/qos_sched/main.h                  |  8 ++++----
 examples/rxtx_callbacks/main.c             |  2 +-
 examples/skeleton/basicfwd.c               |  2 +-
 examples/vhost/main.h                      |  2 +-
 examples/vhost_crypto/main.c               |  2 +-
 examples/vm_power_manager/main.c           |  2 +-
 examples/vmdq/main.c                       |  2 +-
 examples/vmdq_dcb/main.c                   |  2 +-
 33 files changed, 52 insertions(+), 47 deletions(-)

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
index 9b60ebd7fc1a..fa6349391dd0 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -78,7 +78,11 @@ struct cmdline_file_info {
 #define TX_DESC_MAX    2048
 
 #define MAX_PKT_BURST 512
-#define DEF_PKT_BURST 32
+#if RTE_MBUF_BURST_SIZE_DEFAULT > MAX_PKT_BURST
+#define DEF_PKT_BURST MAX_PKT_BURST
+#else
+#define DEF_PKT_BURST RTE_MBUF_BURST_SIZE_DEFAULT
+#endif
 
 #define DEF_MBUF_CACHE 250
 
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
index 036bd4f951ab..48f4d7cfa43c 100644
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
index 471e3b488fe6..358640f1adb5 100644
--- a/examples/l3fwd/l3fwd.h
+++ b/examples/l3fwd/l3fwd.h
@@ -23,14 +23,18 @@
 #define RX_DESC_DEFAULT 1024
 #define TX_DESC_DEFAULT 1024
 
-#define DEFAULT_PKT_BURST 32
 #define MAX_PKT_BURST 512
+#if RTE_MBUF_BURST_SIZE_DEFAULT > MAX_PKT_BURST
+#define DEFAULT_PKT_BURST MAX_PKT_BURST
+#else
+#define DEFAULT_PKT_BURST RTE_MBUF_BURST_SIZE_DEFAULT
+#endif
 #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
 
 #define MEMPOOL_CACHE_SIZE RTE_MEMPOOL_CACHE_MAX_SIZE
 #define MAX_RX_QUEUE_PER_LCORE 16
 
-#define VECTOR_SIZE_DEFAULT   MAX_PKT_BURST
+#define VECTOR_SIZE_DEFAULT   RTE_MBUF_BURST_SIZE_DEFAULT
 #define VECTOR_TMO_NS_DEFAULT 1E6 /* 1ms */
 
 #define NB_SOCKETS        8
diff --git a/examples/link_status_interrupt/main.c b/examples/link_status_interrupt/main.c
index aa33e71d7aa5..ab773f25369e 100644
--- a/examples/link_status_interrupt/main.c
+++ b/examples/link_status_interrupt/main.c
@@ -38,7 +38,7 @@
 
 #define NB_MBUF   8192
 
-#define MAX_PKT_BURST 32
+#define MAX_PKT_BURST	  RTE_MBUF_BURST_SIZE_DEFAULT
 #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
 
 /*
@@ -60,8 +60,6 @@ static unsigned int lsi_rx_queue_per_lcore = 1;
 /* destination port for L2 forwarding */
 static unsigned lsi_dst_ports[RTE_MAX_ETHPORTS] = {0};
 
-#define MAX_PKT_BURST 32
-
 #define MAX_RX_QUEUE_PER_LCORE 16
 #define MAX_TX_QUEUE_PER_PORT 16
 /* List of queues must be polled for a give lcore. 8< */
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
 
diff --git a/examples/packet_ordering/main.c b/examples/packet_ordering/main.c
index 748fe0826a14..6147200e7e9e 100644
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
index da1b0b228787..911b7de266f5 100644
--- a/examples/qos_meter/main.c
+++ b/examples/qos_meter/main.c
@@ -76,13 +76,13 @@ static struct rte_eth_conf port_conf = {
  * Packet RX/TX
  *
  ***/
-#define RTE_MBUF_F_RX_BURST_MAX                32
-#define RTE_MBUF_F_TX_BURST_MAX                32
+#define APP_RX_BURST_MAX		RTE_MBUF_BURST_SIZE_DEFAULT
+#define APP_TX_BURST_MAX		RTE_MBUF_BURST_SIZE_DEFAULT
 #define TIME_TX_DRAIN                   200000ULL
 
 static uint16_t port_rx;
 static uint16_t port_tx;
-static struct rte_mbuf *pkts_rx[RTE_MBUF_F_RX_BURST_MAX];
+static struct rte_mbuf *pkts_rx[APP_RX_BURST_MAX];
 struct rte_eth_dev_tx_buffer *tx_buffer;
 
 /* Traffic meter parameters are configured in the application. 8< */
@@ -187,7 +187,7 @@ main_loop(__rte_unused void *dummy)
 		}
 
 		/* Read packet burst from NIC RX */
-		nb_rx = rte_eth_rx_burst(port_rx, NIC_RX_QUEUE, pkts_rx, RTE_MBUF_F_RX_BURST_MAX);
+		nb_rx = rte_eth_rx_burst(port_rx, NIC_RX_QUEUE, pkts_rx, APP_RX_BURST_MAX);
 
 		/* Handle packets */
 		for (i = 0; i < nb_rx; i ++) {
@@ -419,13 +419,13 @@ main(int argc, char **argv)
 		rte_exit(EXIT_FAILURE, "Port %d TX queue setup error (%d)\n", port_tx, ret);
 
 	tx_buffer = rte_zmalloc_socket("tx_buffer",
-			RTE_ETH_TX_BUFFER_SIZE(RTE_MBUF_F_TX_BURST_MAX), 0,
+			RTE_ETH_TX_BUFFER_SIZE(APP_TX_BURST_MAX), 0,
 			rte_eth_dev_socket_id(port_tx));
 	if (tx_buffer == NULL)
 		rte_exit(EXIT_FAILURE, "Port %d TX buffer allocation error\n",
 				port_tx);
 
-	rte_eth_tx_buffer_init(tx_buffer, RTE_MBUF_F_TX_BURST_MAX);
+	rte_eth_tx_buffer_init(tx_buffer, APP_TX_BURST_MAX);
 
 	ret = rte_eth_dev_start(port_rx);
 	if (ret < 0)
diff --git a/examples/qos_sched/main.h b/examples/qos_sched/main.h
index ea66df0434fb..238f6c5ed272 100644
--- a/examples/qos_sched/main.h
+++ b/examples/qos_sched/main.h
@@ -24,10 +24,10 @@ extern "C" {
 #define APP_RING_SIZE (8*1024)
 #define NB_MBUF   (2*1024*1024)
 
-#define MAX_PKT_RX_BURST 64
-#define PKT_ENQUEUE 64
-#define PKT_DEQUEUE 63
-#define MAX_PKT_TX_BURST 64
+#define MAX_PKT_RX_BURST RTE_MBUF_BURST_SIZE_DEFAULT
+#define PKT_ENQUEUE      RTE_MBUF_BURST_SIZE_DEFAULT
+#define PKT_DEQUEUE      (RTE_MBUF_BURST_SIZE_DEFAULT - 1)
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
index 5b070ef2d60c..01869de09742 100644
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
index d6f7b632b900..476f00f1c05e 100644
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

