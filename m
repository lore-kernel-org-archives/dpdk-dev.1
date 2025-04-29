Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F5CC369D5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 03:04:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E5794026C;
	Tue, 29 Apr 2025 05:04:44 +0200 (CEST)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mails.dpdk.org (Postfix) with ESMTP id AF81E40263
 for <dev@dpdk.org>; Tue, 29 Apr 2025 05:04:41 +0200 (CEST)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T1K2V5017990
 for <dev@dpdk.org>; Mon, 28 Apr 2025 20:04:40 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com
 [147.11.82.254])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 468y0ksdm3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dev@dpdk.org>; Mon, 28 Apr 2025 20:04:40 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Mon, 28 Apr 2025 20:04:39 -0700
Received: from pek-lpg-core6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Mon, 28 Apr 2025 20:04:38 -0700
From: <changqing.li@windriver.com>
To: <dev@dpdk.org>
CC: <changqing.li@windriver.com>
Subject: [PATCH V2] Add new tracepoint function for type time_t
Date: Tue, 29 Apr 2025 11:04:37 +0800
Message-ID: <20250429030437.1128853-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250429030017.1126516-1-changqing.li@windriver.com>
References: <20250429030017.1126516-1-changqing.li@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDAyMSBTYWx0ZWRfXy2+cRpTsLILB
 hynQH96tqpS7gUgwiuXGLbwVNYgkkj29tbmYtlf8oBjr7udaW9ELQYoThfHbVs33KZ+nm8yYj5h
 gqPNwLHMtVfpotLDovMncNhHiNQ67OM590nKbzlDA6OiCb2oa23BWeh14Z8FysyKpGV8V8hoqMw
 Go4Z9fuziRpuiaKIAqSMl+cwUiOJBg5ir3Gyzu8U4k5QSjbvnbRj+LL26j6IE6nVQDjqMaI5OEc
 SvdsQBLCoD0VodClVjsZZv58zHSbN5sbN3ERgkN3OoYtDWLr759ucsDT40ERfjgZMnliklEmRa6
 j7edLgjce8rr+f2F5I7jQ5g7OH1q4nxlr4f+JQrLtXK2Gx3D/UKUk+aILOZo434VQAo62V12pVU
 3HLN+rS/xbWXSnYxrEt6p6WRXcMcpXjgooV3AUJVR868dvsmAEEM+/ze8l+unaswBEIyetys
X-Proofpoint-ORIG-GUID: GU5L72nGsS6VegAidYnyX_HGtl6YlWTI
X-Authority-Analysis: v=2.4 cv=O8A5vA9W c=1 sm=1 tr=0 ts=681041c8 cx=c_pps
 a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17
 a=XR8D0OoHHMoA:10 a=t7CeM3EgAAAA:8 a=trrNUMtqN4mMHeMglJkA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: GU5L72nGsS6VegAidYnyX_HGtl6YlWTI
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxlogscore=904 mlxscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
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

