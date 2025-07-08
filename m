Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1794DC8303C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 21:03:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C12A740649;
	Tue,  8 Jul 2025 23:03:00 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by mails.dpdk.org (Postfix) with ESMTP id C301D40292
 for <dev@dpdk.org>; Tue,  8 Jul 2025 23:02:58 +0200 (CEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568ITYK6030383;
 Tue, 8 Jul 2025 21:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=FbbKXRs2PWr
 PcsARfFfJ5mxPwPrLpoqxGcBtowrdqOM=; b=Q3rvlL50GqbtlW3qNsQVl2XIZ3/
 tr9HWI+FhXdsk1BhOvxEm/D0f8A91t7fy0Si0vcJpGvr19+I9TOff4Zz45YdDSg7
 RVw8GFpJEf4Z17PSXUBTNabf5Ffh8MQ2hg4rcDr8TxcpPoMFVAk5ZEovJNQ+llE6
 tcN7RDxbxb2O68MGQeIAef+UpyxZrPhQRaJRHgnYsqFoUr3k8dRrvZUAZHnGxzvf
 EPhqfm9Fx+yrebVaLy/rpEpLd7s6wllqRRchN8rXCq6Pb1wkPHvxeXJtvpFriiag
 TLvmXUZnZ3fVAldHjNDOvaJg9Ll1gTBiPOGusBfiPrkCi70IpbMifzW86yw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b0ye2r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Jul 2025 21:02:50 +0000 (GMT)
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 568L2nWr001696; 
 Tue, 8 Jul 2025 21:02:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 47rqtj93kw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Jul 2025 21:02:49 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 568L2mcx001688;
 Tue, 8 Jul 2025 21:02:49 GMT
Received: from tbs-5gnr-mt-32 (tbs-5gnr-mt-32.qualcomm.com [10.239.80.185])
 by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 568L2mi9001680
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Jul 2025 21:02:48 +0000
Received: by tbs-5gnr-mt-32 (Postfix, from userid 2342227)
 id 54A71400A4; Tue,  8 Jul 2025 15:02:48 -0600 (MDT)
From: Schneide <schneide@qti.qualcomm.com>
To: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Cc: Dylan Schneider <schneide@qti.qualcomm.com>
Subject: [PATCH v3] pcapng: allow any protocol link type for the interface
 block
Date: Tue,  8 Jul 2025 15:02:45 -0600
Message-Id: <20250708210245.3967578-1-schneide@qti.qualcomm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250609211937.345620-1-schneide@qti.qualcomm.com>
References: <20250609211937.345620-1-schneide@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=686d877a cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=jZVsG21pAAAA:8 a=QyXUC8HyAAAA:8
 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=GRf2JX_IAAAA:8 a=VYDjIKVHAAAA:8
 a=_gsV02HDAAAA:8 a=eh1Yez-EAAAA:8 a=t_NVbEpo0bFBxwTkvzcA:9
 a=3Sh2lD0sZASs_lUdrUhf:22 a=uRw8vnb707Rr89TYUhP5:22 a=-sS9_DeNG7cEylvMdImQ:22
 a=GzKgaEE0kT068tgm3IUS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE3OSBTYWx0ZWRfX9zc1xF3a8/gJ
 fgOXQZ+96BbwSsDqJkzNUXQqU0E4UA6e8k4BsAMfajtaFdyi2GEfSB0LL58aG8EHuPmB+/CBHhz
 FfASgs3GIWftSD+7Z4VrmnwWnCrGGV0x+QeC1lhu+9a/X4RK0UJdhtqp6Rpv1hKt4h5jZZgW8hx
 VjQYLSAeEQ3ZAgenid41oFYVJw6hWiMUQfIMXER3QxAhSSIHlJUqWzqIC0EdkYRHgxxVUywbmh/
 k4wxxRrHnyvUChvQHHyYTXaxyjJRq9WsUpFuucyIjb8iDRDYHtHv01nSFlb+q9f8uUaHr3sp+DL
 G5WyFfLaPCuFEolRj26XlIIMkEunKJZErE5avz44na7Y35Kv3F6RRjZT8UipItfgcpB34PYkLIS
 tlzqf3mWHAKzRt+yZMmaFuQU9d41dm6TLVQ7ej3IIPynFVh0Nj7vTmJzOM4Q8d5U5J1dE0mr
X-Proofpoint-GUID: ajFl6gdnOtP8hXltf9r6-3lDbEmNljFn
X-Proofpoint-ORIG-GUID: ajFl6gdnOtP8hXltf9r6-3lDbEmNljFn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_06,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080179
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

From: Dylan Schneider <schneide@qti.qualcomm.com>

Allow the user to specify protocol link type when creating pcapng files.
This change is needed to specify the protocol type in the pcapng file,
DLT_EN10MB specifies ethernet packets only. This will allow dissectors
for other protocols to be used on files generated by pcapng.

Includes a breaking change to rte_pcapng_add_interface to add link_type
parameter. Existing calls to the function have been updated to pass
DLT_EN10MB for the link type argument.

Fixes: d1da6d0d04c7 ("pcapng: require per-interface information")
Signed-off-by: Dylan Schneider <schneide@qti.qualcomm.com>
Cc: stephen@networkplumber.org
---
 .mailmap                               |  1 +
 app/dumpcap/main.c                     |  4 +--
 app/test/test_pcapng.c                 |  8 +++---
 doc/guides/rel_notes/release_25_07.rst |  4 +++
 lib/graph/graph_pcap.c                 |  2 +-
 lib/pcapng/meson.build                 |  2 ++
 lib/pcapng/rte_pcapng.c                | 22 +++++++++++-----
 lib/pcapng/rte_pcapng.h                | 35 +++++++++++++++++++++++++-
 8 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/.mailmap b/.mailmap
index 37655f4a57..ee0743fdd8 100644
--- a/.mailmap
+++ b/.mailmap
@@ -393,6 +393,7 @@ Dukai Yuan <dukaix.yuan@intel.com>
 Dumitru Ceara <dceara@redhat.com> <dumitru.ceara@gmail.com>
 Duncan Bellamy <dunk@denkimushi.com>
 Dustin Lundquist <dustin@null-ptr.net>
+Dylan Schneider <schneide@qti.qualcomm.com>
 Dzmitry Sautsa <dzmitryx.sautsa@intel.com>
 Ed Czeck <ed.czeck@atomicrules.com>
 Eduard Serra <eserra@vmware.com>
diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 3d3c0dbc66..e0e2b26269 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -800,8 +800,8 @@ static dumpcap_out_t create_output(void)
 		free(os);
 
 		TAILQ_FOREACH(intf, &interfaces, next) {
-			if (rte_pcapng_add_interface(ret.pcapng, intf->port, intf->ifname,
-						     intf->ifdescr, intf->opts.filter) < 0)
+			if (rte_pcapng_add_interface(ret.pcapng, intf->port, DLT_EN10MB,
+				intf->ifname, intf->ifdescr, intf->opts.filter) < 0)
 				rte_exit(EXIT_FAILURE, "rte_pcapng_add_interface %u failed\n",
 					intf->port);
 		}
diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index 8f2cff36c3..bcf99724fa 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -345,7 +345,7 @@ test_add_interface(void)
 	}
 
 	/* Add interface to the file */
-	ret = rte_pcapng_add_interface(pcapng, port_id,
+	ret = rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
 				       NULL, NULL, NULL);
 	if (ret < 0) {
 		fprintf(stderr, "can not add port %u\n", port_id);
@@ -353,7 +353,7 @@ test_add_interface(void)
 	}
 
 	/* Add interface with ifname and ifdescr */
-	ret = rte_pcapng_add_interface(pcapng, port_id,
+	ret = rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
 				       "myeth", "Some long description", NULL);
 	if (ret < 0) {
 		fprintf(stderr, "can not add port %u with ifname\n", port_id);
@@ -361,7 +361,7 @@ test_add_interface(void)
 	}
 
 	/* Add interface with filter */
-	ret = rte_pcapng_add_interface(pcapng, port_id,
+	ret = rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
 				       NULL, NULL, "tcp port 8080");
 	if (ret < 0) {
 		fprintf(stderr, "can not add port %u with filter\n", port_id);
@@ -406,7 +406,7 @@ test_write_packets(void)
 	}
 
 	/* Add interface to the file */
-	ret = rte_pcapng_add_interface(pcapng, port_id,
+	ret = rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
 				       NULL, NULL, NULL);
 	if (ret < 0) {
 		fprintf(stderr, "can not add port %u\n", port_id);
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 6f49bf8f90..5dc19c2b8c 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -215,6 +215,10 @@ API Changes
 * argparse: The ``rte_argparse_arg`` structure used for defining arguments has been updated.
   See ABI changes in the next section for details.
 
+* pcapng: Changed the API for adding interfaces to include a link type argument.
+  The link type was previously hardcoded to the ethernet link type in the API.
+  This argument is added to ``rte_pcapng_add_interface``.
+  These functions are versioned to retain binary compatibility until the next LTS release.
 
 ABI Changes
 -----------
diff --git a/lib/graph/graph_pcap.c b/lib/graph/graph_pcap.c
index 89525f1220..08dcda0d28 100644
--- a/lib/graph/graph_pcap.c
+++ b/lib/graph/graph_pcap.c
@@ -117,7 +117,7 @@ graph_pcap_file_open(const char *filename)
 
 	/* Add the configured interfaces as possible capture ports */
 	RTE_ETH_FOREACH_DEV(portid) {
-		ret = rte_pcapng_add_interface(pcapng_fd, portid,
+		ret = rte_pcapng_add_interface(pcapng_fd, portid, DLT_EN10MB,
 					       NULL, NULL, NULL);
 		if (ret < 0) {
 			graph_err("Graph rte_pcapng_add_interface port %u failed: %d",
diff --git a/lib/pcapng/meson.build b/lib/pcapng/meson.build
index 4549925d41..3aa7ba5155 100644
--- a/lib/pcapng/meson.build
+++ b/lib/pcapng/meson.build
@@ -5,3 +5,5 @@ sources = files('rte_pcapng.c')
 headers = files('rte_pcapng.h')
 
 deps += ['ethdev']
+
+use_function_versioning = true
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 2a07b4c1f5..22a9917173 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -200,11 +200,10 @@ pcapng_section_block(rte_pcapng_t *self,
 }
 
 /* Write an interface block for a DPDK port */
-RTE_EXPORT_SYMBOL(rte_pcapng_add_interface)
-int
-rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
-			 const char *ifname, const char *ifdescr,
-			 const char *filter)
+RTE_DEFAULT_SYMBOL(26, int, rte_pcapng_add_interface,
+			(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
+			const char *ifname, const char *ifdescr,
+			const char *filter))
 {
 	struct pcapng_interface_block *hdr;
 	struct rte_eth_dev_info dev_info;
@@ -274,7 +273,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
 	hdr = (struct pcapng_interface_block *)buf;
 	*hdr = (struct pcapng_interface_block) {
 		.block_type = PCAPNG_INTERFACE_BLOCK,
-		.link_type = 1,		/* DLT_EN10MB - Ethernet */
+		.link_type = link_type,
 		.block_length = len,
 	};
 
@@ -319,6 +318,17 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
 	return write(self->outfd, buf, len);
 }
 
+RTE_VERSION_SYMBOL(25, int, rte_pcapng_add_interface,
+			(rte_pcapng_t *self, uint16_t port,
+			const char *ifname, const char *ifdescr,
+			const char *filter))
+{
+	/* Call the new version with a default link_type (Ethernet) */
+	return rte_pcapng_add_interface(self, port, DLT_EN10MB,
+					ifname, ifdescr, filter);
+}
+
+
 /*
  * Write an Interface statistics block at the end of capture.
  */
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index 48f2b57564..382268ea4a 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -28,6 +28,37 @@
 extern "C" {
 #endif
 
+/* pcap link types */
+#define DLT_NULL	0	/* BSD loopback encapsulation */
+#define DLT_EN10MB	1	/* Ethernet (10Mb) */
+#define DLT_EN3MB	2	/* Experimental Ethernet (3Mb) */
+#define DLT_AX25	3	/* Amateur Radio AX.25 */
+#define DLT_PRONET	4	/* Proteon ProNET Token Ring */
+#define DLT_CHAOS	5	/* Chaos */
+#define DLT_IEEE802	6	/* 802.5 Token Ring */
+#define DLT_ARCNET	7	/* ARCNET, with BSD-style header */
+#define DLT_SLIP	8	/* Serial Line IP */
+#define DLT_PPP		9	/* Point-to-point Protocol */
+#define DLT_FDDI	10	/* FDDI */
+
+/* User-defined link types */
+#define DLT_USER0		147
+#define DLT_USER1		148
+#define DLT_USER2		149
+#define DLT_USER3		150
+#define DLT_USER4		151
+#define DLT_USER5		152
+#define DLT_USER6		153
+#define DLT_USER7		154
+#define DLT_USER8		155
+#define DLT_USER9		156
+#define DLT_USER10		157
+#define DLT_USER11		158
+#define DLT_USER12		159
+#define DLT_USER13		160
+#define DLT_USER14		161
+#define DLT_USER15		162
+
 /* Opaque handle used for functions in this library. */
 typedef struct rte_pcapng rte_pcapng_t;
 
@@ -71,6 +102,8 @@ rte_pcapng_close(rte_pcapng_t *self);
  *  The handle to the packet capture file
  * @param port
  *  The Ethernet port to report stats on.
+ * @param link_type
+ *  The link type (e.g., DLT_EN10MB).
  * @param ifname (optional)
  *  Interface name to record in the file.
  *  If not specified, name will be constructed from port
@@ -84,7 +117,7 @@ rte_pcapng_close(rte_pcapng_t *self);
  * must be added.
  */
 int
-rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
+rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 			 const char *ifname, const char *ifdescr,
 			 const char *filter);
 
-- 
2.27.0

