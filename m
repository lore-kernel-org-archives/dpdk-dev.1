Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771BCC369C2
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 00:39:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A8BB40156;
	Wed, 23 Apr 2025 02:39:49 +0200 (CEST)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mails.dpdk.org (Postfix) with ESMTP id C9C7640151
 for <dev@dpdk.org>; Wed, 23 Apr 2025 02:39:47 +0200 (CEST)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N0T3Eh030374
 for <dev@dpdk.org>; Tue, 22 Apr 2025 17:39:46 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com
 [147.11.82.254])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 466jhar5c5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dev@dpdk.org>; Tue, 22 Apr 2025 17:39:46 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Tue, 22 Apr 2025 17:39:45 -0700
Received: from pek-lpg-core6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Tue, 22 Apr 2025 17:39:45 -0700
From: <changqing.li@windriver.com>
To: <dev@dpdk.org>
Subject: [PATCH V3] ethdev_trace.h: Update the trace point function when
 _TIME_BITS=64
Date: Wed, 23 Apr 2025 08:39:44 +0800
Message-ID: <20250423003944.2098565-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422113523.867473-1-changqing.li@windriver.com>
References: <20250422113523.867473-1-changqing.li@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: TrEOoXqHG5lUxzJFSv9uc8SLHgWiRjq8
X-Proofpoint-ORIG-GUID: TrEOoXqHG5lUxzJFSv9uc8SLHgWiRjq8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDAwMSBTYWx0ZWRfXxI4f6I1iBNMN
 J1vklSg3pMIYgAM9HHtIgdq42dYisDLeAdw7iYYW2Slvs7afZsE5XY1yObXa26R8Bx400+1Sp+r
 e9TIYg4u8lkbI2OqDo3LHBvFx8LeNHzX6Zu9U93RXffawRid23xeBqrK3sVT0+U59OnBGHg+4n2
 I9gLFm2c0aUCUSLEYq9f8COF3o8BfANnzGOpTSoHre3NiHR7Uh2mZsInHFoqET23/ES04RedVFp
 1IeGyH0W2/AUrnrCS+RCsT6pFx/0TVgenxC/G0s/5OymEAikLSaaPJMR/AVJSiCzcXmNl+hBm++
 g3k+wvyVf/seZzi8MxNENKvN2TKdU54xh9VyxabAA6oOMjKz2dXW3wA69lyK09KCkycgJTkHzbk
 NB7hU4tn9u1Pw3BBTCvY2jZvP7vDLm/GrhNPmOoKLTfiPSnMYA63v5Dv/fZPKfUFW2KJbGVn
X-Authority-Analysis: v=2.4 cv=Sa33duRu c=1 sm=1 tr=0 ts=680836d2 cx=c_pps
 a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17
 a=XR8D0OoHHMoA:10 a=t7CeM3EgAAAA:8 a=q8yi_ZPvUVNFa_hMH0IA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_11,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 mlxlogscore=860 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2504230001
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

Update the trace point function to fix above issue

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 lib/ethdev/ethdev_trace.h | 49 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h
index c65b78590a..5989b89768 100644
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
+	rte_trace_point_emit_u64(time->tv_sec);
+	rte_trace_point_emit_long(time->tv_nsec);
+	rte_trace_point_emit_int(ret);
+)
+#else
+RTE_TRACE_POINT(
+	rte_eth_trace_timesync_write_time,
+	RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *time,
+	  int ret),
+	rte_trace_point_emit_u16(port_id);
 	rte_trace_point_emit_size_t(time->tv_sec);
 	rte_trace_point_emit_long(time->tv_nsec);
 	rte_trace_point_emit_int(ret);
 )
+#endif
 
 RTE_TRACE_POINT(
 	rte_eth_trace_read_clock,
@@ -2146,29 +2158,65 @@ RTE_TRACE_POINT_FP(
 )
 
 /* Called in loop in examples/ptpclient */
+#if defined(_TIME_BITS) && _TIME_BITS == 64
 RTE_TRACE_POINT_FP(
 	rte_eth_trace_timesync_read_rx_timestamp,
 	RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *timestamp,
 		uint32_t flags, int ret),
 	rte_trace_point_emit_u16(port_id);
+	rte_trace_point_emit_u64(timestamp->tv_sec);
+	rte_trace_point_emit_long(timestamp->tv_nsec);
+	rte_trace_point_emit_u32(flags);
+	rte_trace_point_emit_int(ret);
+)
+#else
+RTE_TRACE_POINT_FP(
+	rte_eth_trace_timesync_read_rx_timestamp,
+	RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *timestamp,
+	  uint32_t flags, int ret),
+	rte_trace_point_emit_u16(port_id);
 	rte_trace_point_emit_size_t(timestamp->tv_sec);
 	rte_trace_point_emit_long(timestamp->tv_nsec);
 	rte_trace_point_emit_u32(flags);
 	rte_trace_point_emit_int(ret);
 )
+#endif
 
 /* Called in loop in examples/ptpclient */
+#if defined(_TIME_BITS) && _TIME_BITS == 64
 RTE_TRACE_POINT_FP(
 	rte_eth_trace_timesync_read_tx_timestamp,
 	RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *timestamp,
 		int ret),
 	rte_trace_point_emit_u16(port_id);
+	rte_trace_point_emit_u64(timestamp->tv_sec);
+	rte_trace_point_emit_long(timestamp->tv_nsec);
+	rte_trace_point_emit_int(ret);
+)
+#else
+RTE_TRACE_POINT_FP(
+	rte_eth_trace_timesync_read_tx_timestamp,
+	RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *timestamp,
+	  int ret),
+	rte_trace_point_emit_u16(port_id);
 	rte_trace_point_emit_size_t(timestamp->tv_sec);
 	rte_trace_point_emit_long(timestamp->tv_nsec);
 	rte_trace_point_emit_int(ret);
 )
+#endif
 
 /* Called in loop in examples/ptpclient */
+#if defined(_TIME_BITS) && _TIME_BITS == 64
+RTE_TRACE_POINT_FP(
+	rte_eth_trace_timesync_read_time,
+	RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *time,
+		int ret),
+	rte_trace_point_emit_u16(port_id);
+	rte_trace_point_emit_u64(time->tv_sec);
+	rte_trace_point_emit_long(time->tv_nsec);
+	rte_trace_point_emit_int(ret);
+)
+#else
 RTE_TRACE_POINT_FP(
 	rte_eth_trace_timesync_read_time,
 	RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *time,
@@ -2178,6 +2226,7 @@ RTE_TRACE_POINT_FP(
 	rte_trace_point_emit_long(time->tv_nsec);
 	rte_trace_point_emit_int(ret);
 )
+#endif
 
 /* Called in loop in examples/ptpclient */
 RTE_TRACE_POINT_FP(
-- 
2.34.1

