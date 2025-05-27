Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F43C5B549
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 12:04:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BE2A4028F;
	Tue, 27 May 2025 14:04:11 +0200 (CEST)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mails.dpdk.org (Postfix) with ESMTP id 731A24028D
 for <dev@dpdk.org>; Tue, 27 May 2025 14:04:09 +0200 (CEST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R80gcH026836
 for <dev@dpdk.org>; Tue, 27 May 2025 12:04:08 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com
 [147.11.82.254])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46u3b12n1m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 May 2025 12:04:08 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Tue, 27 May 2025 05:04:06 -0700
Received: from pek-lpg-core6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Tue, 27 May 2025 05:04:05 -0700
From: <changqing.li@windriver.com>
To: <dev@dpdk.org>
CC: <changqing.li@windriver.com>
Subject: [PATCH V4] Add new tracepoint function for type time_t
Date: Tue, 27 May 2025 20:04:04 +0800
Message-ID: <20250527120404.2027529-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250429030017.1126516-1-changqing.li@windriver.com>
References: <20250429030017.1126516-1-changqing.li@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hr-sza1s2YMLWy3-1wdRc8Wc4ZZAIp0z
X-Authority-Analysis: v=2.4 cv=VpYjA/2n c=1 sm=1 tr=0 ts=6835aa38 cx=c_pps
 a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17
 a=dt9VzEwgFbYA:10 a=t7CeM3EgAAAA:8 a=q8yi_ZPvUVNFa_hMH0IA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: hr-sza1s2YMLWy3-1wdRc8Wc4ZZAIp0z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA5OCBTYWx0ZWRfX+R+E94clHKWj
 c6G4/QQLQJzGM0jsrDfgFUXY+P+kXeTh/68Hu5me6B4WWBuLWw0v5TweV6CGs77SJ2reDT9OX4b
 igvIs+8FtolhWV6yI6IQ23Q5WFIGli3mdRyFYVtXBRNdqZ5MwFizxYv4RG5e/bH5OILi9o8GMgE
 xygqaMZ5IN/Txx5wtqreZUBnS02PytOvhzx8WqarJOYpSx9Sf0so3UTfQzIiLp89LerZMrt8uy2
 zaLt1nE6Sn9pn+CSpAibAK9paVqPqcnUz9TmXxTClCpPte5mJQt1MGW1TsCmL9okYBTu/WflQbR
 ZmYmytG9PJefpHAz2zDuHzoNYE8m1mjnGT22ay2morMDOpBekID71PnIJONclwKNAbFl8/CTWK1
 cNB/mo5ZX7rTw9iQwP+TOVvr5wulzu9l3owMTK3duYNmc5yY6AdqzDS9AoN7QKTKB7QzXbxY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=842 malwarescore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2505160000
 definitions=main-2505270098
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

From: Changqing Li <changqing.li@windriver.com>

To support Y2038 issue, for 32bit system, -D_TIME_BITS=64 is passed to
gcc, struct timespec time->tv_sec is 64bit, but size_t is 32bits, so
dpdk will compile failed with error:
"../git/lib/ethdev/ethdev_trace.h: In function
'rte_eth_trace_timesync_write_time':
../git/lib/eal/include/rte_common.h:498:55: error: size of unnamed array
is negative
  498 | #define RTE_BUILD_BUG_ON(condition) ((void)sizeof(char[1 -
      2*!!(condition)]))"

Add a new tracepoint function for type time_t to fix this issue

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 lib/eal/common/eal_common_trace_ctf.c | 5 +++++
 lib/eal/include/rte_trace_point.h     | 5 +++++
 lib/ethdev/ethdev_trace.h             | 8 ++++----
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/lib/eal/common/eal_common_trace_ctf.c b/lib/eal/common/eal_common_trace_ctf.c
index f089da22df..aa60a705d1 100644
--- a/lib/eal/common/eal_common_trace_ctf.c
+++ b/lib/eal/common/eal_common_trace_ctf.c
@@ -89,6 +89,11 @@ meta_data_type_emit(char **meta, int *offset)
 		"typealias integer {size = 64; base = x;} := size_t;\n"
 #else
 		"typealias integer {size = 32; base = x;} := size_t;\n"
+#endif
+#if defined(_TIME_BITS) && _TIME_BITS == 64
+		"typealias integer {size = 64; base = x;} := time_t;\n"
+#else
+		"typealias integer {size = 32; base = x;} := time_t;\n"
 #endif
 		"typealias floating_point {\n"
 		"    exp_dig = 8;\n"
diff --git a/lib/eal/include/rte_trace_point.h b/lib/eal/include/rte_trace_point.h
index 8a317d31d2..d6bacf1752 100644
--- a/lib/eal/include/rte_trace_point.h
+++ b/lib/eal/include/rte_trace_point.h
@@ -18,6 +18,7 @@
 
 #include <stdbool.h>
 #include <stdio.h>
+#include <time.h>
 
 #include <rte_branch_prediction.h>
 #include <rte_common.h>
@@ -150,6 +151,8 @@ _tp _args \
 #define rte_trace_point_emit_ptr(val)
 /** Tracepoint function payload for string datatype */
 #define rte_trace_point_emit_string(val)
+/** Tracepoint function payload for time_t datatype */
+#define rte_trace_point_emit_time_t(val)
 /**
  * Tracepoint function to capture a blob.
  *
@@ -438,6 +441,7 @@ do { \
 #define rte_trace_point_emit_float(in) __rte_trace_point_emit(RTE_STR(in), &in, float)
 #define rte_trace_point_emit_double(in) __rte_trace_point_emit(RTE_STR(in), &in, double)
 #define rte_trace_point_emit_ptr(in) __rte_trace_point_emit(RTE_STR(in), &in, uintptr_t)
+#define rte_trace_point_emit_time_t(in) __rte_trace_point_emit(RTE_STR(in), &in, time_t)
 
 #define rte_trace_point_emit_u64_ptr(in) __rte_trace_point_emit(RTE_STR(in)"_val", in, uint64_t)
 #define rte_trace_point_emit_i64_ptr(in) __rte_trace_point_emit(RTE_STR(in)"_val", in, int64_t)
@@ -452,6 +456,7 @@ do { \
 #define rte_trace_point_emit_size_t_ptr(in) __rte_trace_point_emit(RTE_STR(in)"_val", in, size_t)
 #define rte_trace_point_emit_float_ptr(in) __rte_trace_point_emit(RTE_STR(in)"_val", in, float)
 #define rte_trace_point_emit_double_ptr(in) __rte_trace_point_emit(RTE_STR(in)"_val", in, double)
+#define rte_trace_point_emit_time_t_ptr(in) __rte_trace_point_emit(RTE_STR(in)"_val", in, time_t)
 
 #endif /* __DOXYGEN__ */
 
diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h
index c65b78590a..482befc209 100644
--- a/lib/ethdev/ethdev_trace.h
+++ b/lib/ethdev/ethdev_trace.h
@@ -1121,7 +1121,7 @@ RTE_TRACE_POINT(
 	RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *time,
 		int ret),
 	rte_trace_point_emit_u16(port_id);
-	rte_trace_point_emit_size_t(time->tv_sec);
+	rte_trace_point_emit_time_t(time->tv_sec);
 	rte_trace_point_emit_long(time->tv_nsec);
 	rte_trace_point_emit_int(ret);
 )
@@ -2151,7 +2151,7 @@ RTE_TRACE_POINT_FP(
 	RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *timestamp,
 		uint32_t flags, int ret),
 	rte_trace_point_emit_u16(port_id);
-	rte_trace_point_emit_size_t(timestamp->tv_sec);
+	rte_trace_point_emit_time_t(timestamp->tv_sec);
 	rte_trace_point_emit_long(timestamp->tv_nsec);
 	rte_trace_point_emit_u32(flags);
 	rte_trace_point_emit_int(ret);
@@ -2163,7 +2163,7 @@ RTE_TRACE_POINT_FP(
 	RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *timestamp,
 		int ret),
 	rte_trace_point_emit_u16(port_id);
-	rte_trace_point_emit_size_t(timestamp->tv_sec);
+	rte_trace_point_emit_time_t(timestamp->tv_sec);
 	rte_trace_point_emit_long(timestamp->tv_nsec);
 	rte_trace_point_emit_int(ret);
 )
@@ -2174,7 +2174,7 @@ RTE_TRACE_POINT_FP(
 	RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *time,
 		int ret),
 	rte_trace_point_emit_u16(port_id);
-	rte_trace_point_emit_size_t(time->tv_sec);
+	rte_trace_point_emit_time_t(time->tv_sec);
 	rte_trace_point_emit_long(time->tv_nsec);
 	rte_trace_point_emit_int(ret);
 )
-- 
2.34.1

