Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707C6C369D5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 03:00:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A14F4026C;
	Tue, 29 Apr 2025 05:00:23 +0200 (CEST)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mails.dpdk.org (Postfix) with ESMTP id 8B94540263
 for <dev@dpdk.org>; Tue, 29 Apr 2025 05:00:21 +0200 (CEST)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T1eVsA005986
 for <dev@dpdk.org>; Tue, 29 Apr 2025 03:00:20 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com
 [147.11.82.252])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 468pf93qg4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dev@dpdk.org>; Tue, 29 Apr 2025 03:00:19 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Mon, 28 Apr 2025 20:00:18 -0700
Received: from pek-lpg-core6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Mon, 28 Apr 2025 20:00:17 -0700
From: <changqing.li@windriver.com>
To: <dev@dpdk.org>
CC: <changqing.li@windriver.com>
Subject: [PATCH] Add new tracepoint function for type time_t
Date: Tue, 29 Apr 2025 11:00:17 +0800
Message-ID: <20250429030017.1126516-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: VcN2LLBuboIcquKOw2UjjfgWb_FkhJqM
X-Authority-Analysis: v=2.4 cv=EavIQOmC c=1 sm=1 tr=0 ts=681040c3 cx=c_pps
 a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17
 a=XR8D0OoHHMoA:10 a=t7CeM3EgAAAA:8 a=trrNUMtqN4mMHeMglJkA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDAyMSBTYWx0ZWRfX8Ga3ecP/IzGw
 h0XmhYutujeIUmRcCipRVsA3IH0uwWn6db/3tALQ38bNdEcSK3PKza3yDRzhbxzanFT43qrEZnJ
 AfhTKfNZdggyrsO/uJIywuUCfRfFAhm9lcmG0VvFzSRU+GWHKhRlUr/JKCSctDM/JOYf46fbEMn
 9OW7QWm10fR27u5xYcJfymYsTN7qfuF9UPYAJceIb205GOM0z3GsCDA6I40J515NDli0XXtiPzt
 /gMFXsNGg5/q9Gpy462DyxsTEW8OSuaIGie/wxjY2zpsI6O3b2i6F3DBK1Q7XIQM+XUBALHb2NK
 VYp1cSgvAUbp9V4sGCO0X+nBdIB7yp2B1Jq3prUbGXinodYwB4AZVV7MELXMMxQTkqqISnnaV66
 GzAyGTS7ZN4KbRfNYJkgtRCI2tQ1J2KdoCfOT6hkmuciZJ3W1CPOysJEoW2JyjmChoYCb69b
X-Proofpoint-ORIG-GUID: VcN2LLBuboIcquKOw2UjjfgWb_FkhJqM
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=892 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2504290021
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
../git/lib/ethdev/ethdev_trace.h: In function 'rte_eth_trace_timesync_write_time':
../git/lib/eal/include/rte_common.h:498:55: error: size of unnamed array is negative
  498 | #define RTE_BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))

Add a new tracepoint function for type time_t to fix this issue

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 lib/eal/include/rte_trace_point.h | 4 ++++
 lib/ethdev/ethdev_trace.h         | 8 ++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/eal/include/rte_trace_point.h b/lib/eal/include/rte_trace_point.h
index 8a317d31d2..6aac4d0191 100644
--- a/lib/eal/include/rte_trace_point.h
+++ b/lib/eal/include/rte_trace_point.h
@@ -150,6 +150,8 @@ _tp _args \
 #define rte_trace_point_emit_ptr(val)
 /** Tracepoint function payload for string datatype */
 #define rte_trace_point_emit_string(val)
+/** Tracepoint function payload for time_t datatype */
+ #define rte_trace_point_emit_time_t(val)
 /**
  * Tracepoint function to capture a blob.
  *
@@ -438,6 +440,7 @@ do { \
 #define rte_trace_point_emit_float(in) __rte_trace_point_emit(RTE_STR(in), &in, float)
 #define rte_trace_point_emit_double(in) __rte_trace_point_emit(RTE_STR(in), &in, double)
 #define rte_trace_point_emit_ptr(in) __rte_trace_point_emit(RTE_STR(in), &in, uintptr_t)
+#define rte_trace_point_emit_time_t(in) __rte_trace_point_emit(RTE_STR(in), &in, time_t)
 
 #define rte_trace_point_emit_u64_ptr(in) __rte_trace_point_emit(RTE_STR(in)"_val", in, uint64_t)
 #define rte_trace_point_emit_i64_ptr(in) __rte_trace_point_emit(RTE_STR(in)"_val", in, int64_t)
@@ -452,6 +455,7 @@ do { \
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

