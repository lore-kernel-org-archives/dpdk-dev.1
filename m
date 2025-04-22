Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90119C369C2
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Apr 2025 11:35:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C65E402E7;
	Tue, 22 Apr 2025 13:35:28 +0200 (CEST)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mails.dpdk.org (Postfix) with ESMTP id 3F05B402E6
 for <dev@dpdk.org>; Tue, 22 Apr 2025 13:35:26 +0200 (CEST)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M5A64E022725
 for <dev@dpdk.org>; Tue, 22 Apr 2025 11:35:26 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com
 [147.11.82.252])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4642t8tvph-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dev@dpdk.org>; Tue, 22 Apr 2025 11:35:25 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Tue, 22 Apr 2025 04:35:24 -0700
Received: from pek-lpg-core6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Tue, 22 Apr 2025 04:35:24 -0700
From: <changqing.li@windriver.com>
To: <dev@dpdk.org>
Subject: [PATCH] ethdev_trace.h: Update the trace point function when
 _TIME_BITS=64
Date: Tue, 22 Apr 2025 19:35:23 +0800
Message-ID: <20250422113523.867473-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vhXq6o44ip5_Eowc_P988P8ioPUvcR1s
X-Proofpoint-GUID: vhXq6o44ip5_Eowc_P988P8ioPUvcR1s
X-Authority-Analysis: v=2.4 cv=TJ9FS0la c=1 sm=1 tr=0 ts=68077efe cx=c_pps
 a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17
 a=XR8D0OoHHMoA:10 a=t7CeM3EgAAAA:8 a=q8yi_ZPvUVNFa_hMH0IA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_05,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 phishscore=0 impostorscore=0 mlxlogscore=844
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504220087
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

Update the trace point function to fix above issue

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 lib/ethdev/ethdev_trace.h | 57 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h
index c65b78590a..20390140dd 100644
--- a/lib/ethdev/ethdev_trace.h
+++ b/lib/ethdev/ethdev_trace.h
@@ -1116,15 +1116,27 @@ RTE_TRACE_POINT(
 	rte_trace_point_emit_int(ret);
 )
 
+#if defined(_TIME_BITS) && _TIME_BITS == 64
 RTE_TRACE_POINT(
 	rte_eth_trace_timesync_write_time,
 	RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *time,
 		int ret),
 	rte_trace_point_emit_u16(port_id);
-	rte_trace_point_emit_size_t(time->tv_sec);
+	rte_trace_point_emit_u64(time->tv_sec);
 	rte_trace_point_emit_long(time->tv_nsec);
 	rte_trace_point_emit_int(ret);
 )
+#else
+RTE_TRACE_POINT(
+    rte_eth_trace_timesync_write_time,
+    RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *time,
+        int ret),
+    rte_trace_point_emit_u16(port_id);
+    rte_trace_point_emit_size_t(time->tv_sec);
+    rte_trace_point_emit_long(time->tv_nsec);
+    rte_trace_point_emit_int(ret);
+)
+#endif
 
 RTE_TRACE_POINT(
 	rte_eth_trace_read_clock,
@@ -2146,38 +2158,75 @@ RTE_TRACE_POINT_FP(
 )
 
 /* Called in loop in examples/ptpclient */
+#if defined(_TIME_BITS) && _TIME_BITS == 64
 RTE_TRACE_POINT_FP(
 	rte_eth_trace_timesync_read_rx_timestamp,
 	RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *timestamp,
 		uint32_t flags, int ret),
 	rte_trace_point_emit_u16(port_id);
-	rte_trace_point_emit_size_t(timestamp->tv_sec);
+	rte_trace_point_emit_u64(timestamp->tv_sec);
 	rte_trace_point_emit_long(timestamp->tv_nsec);
 	rte_trace_point_emit_u32(flags);
 	rte_trace_point_emit_int(ret);
 )
+#else
+RTE_TRACE_POINT_FP(
+    rte_eth_trace_timesync_read_rx_timestamp,
+    RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *timestamp,
+        uint32_t flags, int ret),
+    rte_trace_point_emit_u16(port_id);
+    rte_trace_point_emit_size_t(timestamp->tv_sec);
+    rte_trace_point_emit_long(timestamp->tv_nsec);
+    rte_trace_point_emit_u32(flags);
+    rte_trace_point_emit_int(ret);
+)
+#endif
 
 /* Called in loop in examples/ptpclient */
+#if defined(_TIME_BITS) && _TIME_BITS == 64
 RTE_TRACE_POINT_FP(
 	rte_eth_trace_timesync_read_tx_timestamp,
 	RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *timestamp,
 		int ret),
 	rte_trace_point_emit_u16(port_id);
-	rte_trace_point_emit_size_t(timestamp->tv_sec);
+	rte_trace_point_emit_u64(timestamp->tv_sec);
 	rte_trace_point_emit_long(timestamp->tv_nsec);
 	rte_trace_point_emit_int(ret);
 )
+#else
+RTE_TRACE_POINT_FP(
+    rte_eth_trace_timesync_read_tx_timestamp,
+    RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *timestamp,
+        int ret),
+    rte_trace_point_emit_u16(port_id);
+    rte_trace_point_emit_size_t(timestamp->tv_sec);
+    rte_trace_point_emit_long(timestamp->tv_nsec);
+    rte_trace_point_emit_int(ret);
+)
+#endif
 
 /* Called in loop in examples/ptpclient */
+#if defined(_TIME_BITS) && _TIME_BITS == 64
 RTE_TRACE_POINT_FP(
 	rte_eth_trace_timesync_read_time,
 	RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *time,
 		int ret),
 	rte_trace_point_emit_u16(port_id);
-	rte_trace_point_emit_size_t(time->tv_sec);
+	rte_trace_point_emit_u64(time->tv_sec);
 	rte_trace_point_emit_long(time->tv_nsec);
 	rte_trace_point_emit_int(ret);
 )
+#else
+RTE_TRACE_POINT_FP(
+    rte_eth_trace_timesync_read_time,
+    RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *time,
+        int ret),
+    rte_trace_point_emit_u16(port_id);
+    rte_trace_point_emit_size_t(time->tv_sec);
+    rte_trace_point_emit_long(time->tv_nsec);
+    rte_trace_point_emit_int(ret);
+)
+#endif
 
 /* Called in loop in examples/ptpclient */
 RTE_TRACE_POINT_FP(
-- 
2.34.1

