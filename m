Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEA2CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 22:32:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 195C14029E;
	Thu, 28 Aug 2025 00:32:31 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by mails.dpdk.org (Postfix) with ESMTP id 4701240298
 for <dev@dpdk.org>; Thu, 28 Aug 2025 00:32:29 +0200 (CEST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RG7gol029334;
 Wed, 27 Aug 2025 22:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lWu0aP8ySD7
 Fld0FC2/D+KTXVGxkVgmvRctolPuWJx8=; b=WKCzzkZTKcrvQ6f94KvaZdQ2Rgt
 iZEueRSpYAD4BI5z/mey/oRgMls1JCZwOfObo7jY7DT0jDuyS6jP7gtqMzSMUEoe
 XerdK+sXFGuadt5JOVR/BO+DwQG8uW3A4cnO+5/PoJlmJ+fJfDq4Ri5yXgfvLLLS
 LHU2atmBXOkVU6wyOycxZzbEw/rGwdG1JRAdzDVyVnxXX2XT5fslMjMeq0hcVjdm
 MR7+AEiihWgt28TnBCcpvJdRQE4d9Y/7AZIydl5zF1vxi5HU654UtBbWDzsUoki+
 Q1Q0uAx+zoxSPTzUSjA6Kwf2PZ0VrfQo16c7R1hoqw5dWEedDYaZqaInCig==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5w2x9g9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 22:32:20 +0000 (GMT)
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
 by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 57RMWKwi006430; 
 Wed, 27 Aug 2025 22:32:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 48saf07tf1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 22:32:20 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57RMWJxq006421;
 Wed, 27 Aug 2025 22:32:20 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 57RMWJC0006409
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 22:32:19 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2342227)
 id 4CDAA400B4; Wed, 27 Aug 2025 16:32:19 -0600 (MDT)
From: Schneide <schneide@qti.qualcomm.com>
To: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Cc: Dylan Schneider <schneide@qti.qualcomm.com>
Subject: [PATCH v2] pcapng: allow any protocol link type for the interface
 block
Date: Wed, 27 Aug 2025 16:32:15 -0600
Message-Id: <20250827223216.1337749-1-schneide@qti.qualcomm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250827153852.1066521-1-schneide@qti.qualcomm.com>
References: <20250827153852.1066521-1-schneide@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=Z/vsHGRA c=1 sm=1 tr=0 ts=68af8774 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=jZVsG21pAAAA:8 a=QyXUC8HyAAAA:8
 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=GRf2JX_IAAAA:8 a=VYDjIKVHAAAA:8
 a=_gsV02HDAAAA:8 a=eh1Yez-EAAAA:8 a=oXXHsp1HpUjNabu4yUkA:9
 a=3Sh2lD0sZASs_lUdrUhf:22 a=uRw8vnb707Rr89TYUhP5:22 a=-sS9_DeNG7cEylvMdImQ:22
 a=GzKgaEE0kT068tgm3IUS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXwy4JqYW79lB1
 cy+8bLCxG6wIauTRjJxwEqhTynyZ2cGSg83S0nMmrxGVpdqNUhQJc3c+mcQS44vSwpPwADSuo0O
 imMzEX1nlryr3Qq71/8ykC3t7I7c93Zle+8+OcY65zAbQlF+c8psKNKqY6qQg1lofqOXsTJ7zsU
 Hx4WCBE6XiCQ6+dSimDfPJvnnQiqdt1kCIIydzftmo5/aZumFdhY8wYKaoKs06R3sXK0XvAZReG
 xgwEN+k5OrB7+yml7lmhkk0wG0jvT9H1I6YNiSaXkPlkoQUYF/c2JjYYhsRz93/9JAQCxyF0z1Q
 jAPY/amWiuknDdIDq366J5v0wIoHcKbC6K9IgozY1NF08OXTGZcw+Fod/tUXNRwZTDcTVNGAUD5
 seNsSJwf
X-Proofpoint-GUID: 25_JeppXcpXKl6mTuDZLGsEq_sQaGHFS
X-Proofpoint-ORIG-GUID: 25_JeppXcpXKl6mTuDZLGsEq_sQaGHFS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033
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
v2:
* Remove function versioning
* Define DLT_EN10MB macro only if it has not been defined

 .mailmap                               |  1 +
 app/dumpcap/main.c                     |  5 +++--
 app/test/test_pcapng.c                 |  8 ++++----
 doc/guides/rel_notes/release_25_11.rst |  4 ++++
 lib/graph/graph_pcap.c                 |  2 +-
 lib/pcapng/rte_pcapng.c                |  4 ++--
 lib/pcapng/rte_pcapng.h                | 10 +++++++++-
 7 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/.mailmap b/.mailmap
index 34a99f93a1..1a003778b2 100644
--- a/.mailmap
+++ b/.mailmap
@@ -402,6 +402,7 @@ Dukai Yuan <dukaix.yuan@intel.com>
 Dumitru Ceara <dceara@redhat.com> <dumitru.ceara@gmail.com>
 Duncan Bellamy <dunk@denkimushi.com>
 Dustin Lundquist <dustin@null-ptr.net>
+Dylan Schneider <schneide@qti.qualcomm.com>
 Dzmitry Sautsa <dzmitryx.sautsa@intel.com>
 Ed Czeck <ed.czeck@atomicrules.com>
 Eduard Serra <eserra@vmware.com>
diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 3d3c0dbc66..e5ba36350b 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -800,8 +800,9 @@ static dumpcap_out_t create_output(void)
 		free(os);
 
 		TAILQ_FOREACH(intf, &interfaces, next) {
-			if (rte_pcapng_add_interface(ret.pcapng, intf->port, intf->ifname,
-						     intf->ifdescr, intf->opts.filter) < 0)
+			if (rte_pcapng_add_interface(ret.pcapng, intf->port, DLT_EN10MB,
+						     intf->ifname, intf->ifdescr,
+						     intf->opts.filter) < 0)
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
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index ccad6d89ff..b1f75a489c 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -84,6 +84,10 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
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
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 2a07b4c1f5..21bc94cea1 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -202,7 +202,7 @@ pcapng_section_block(rte_pcapng_t *self,
 /* Write an interface block for a DPDK port */
 RTE_EXPORT_SYMBOL(rte_pcapng_add_interface)
 int
-rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
+rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 			 const char *ifname, const char *ifdescr,
 			 const char *filter)
 {
@@ -274,7 +274,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
 	hdr = (struct pcapng_interface_block *)buf;
 	*hdr = (struct pcapng_interface_block) {
 		.block_type = PCAPNG_INTERFACE_BLOCK,
-		.link_type = 1,		/* DLT_EN10MB - Ethernet */
+		.link_type = link_type,
 		.block_length = len,
 	};
 
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index 48f2b57564..c51c63fccf 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -28,6 +28,12 @@
 extern "C" {
 #endif
 
+
+/* default link type for ethernet traffic */
+#ifndef DLT_EN10MB
+#define DLT_EN10MB 1
+#endif
+
 /* Opaque handle used for functions in this library. */
 typedef struct rte_pcapng rte_pcapng_t;
 
@@ -71,6 +77,8 @@ rte_pcapng_close(rte_pcapng_t *self);
  *  The handle to the packet capture file
  * @param port
  *  The Ethernet port to report stats on.
+ * @param link_type
+ *  The link type (e.g., DLT_EN10MB).
  * @param ifname (optional)
  *  Interface name to record in the file.
  *  If not specified, name will be constructed from port
@@ -84,7 +92,7 @@ rte_pcapng_close(rte_pcapng_t *self);
  * must be added.
  */
 int
-rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
+rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 			 const char *ifname, const char *ifdescr,
 			 const char *filter);
 
-- 
2.27.0

