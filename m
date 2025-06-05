Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36B3C5B549
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 06:32:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBEF0402C2;
	Fri,  6 Jun 2025 08:32:53 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id B8C95400D7
 for <dev@dpdk.org>; Fri,  6 Jun 2025 01:02:56 +0200 (CEST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555MYKau023418;
 Thu, 5 Jun 2025 23:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0/djSwB9lUdLvMtxY0Vbe5EakfOlNLRx4qsjGD9Gv/Y=; b=ZZz1UXlnc+Iuj6nc
 l1+mKVYvr/GT3EYJszObeLuL2ZXK9t/EcNLUzmXr7U1GDTcLuSaEwG3u0OZ4BRJf
 t1zkBS3DT+y26LrnryAAJ9ccKNev+RIK8oZSPh8b2VX2gaNPk8JDQLW7Qjlj2SBJ
 YKGns4Ip7g3SW9pmFrl7fwmGXFZLbz++QK8LK4Ryit/d3MvJmfjCO/X5+dSKp1tt
 H8Hhs5gZFiAgFGKFJDTE0F72RqApyO5B55fx5VDIRCDMbI9m/7jDAMOhf9vz5SZh
 jHW84nP8DYDGsQg2AWNV0PJOugdEKB1LxJ5FuN8ZToYMhihggGALZkWcUCX8ZSIg
 VIczYw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 472mn0540p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Jun 2025 23:02:51 +0000 (GMT)
Received: from pps.filterd (NASANPPMTA02.qualcomm.com [127.0.0.1])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 555MwLSo006718; 
 Thu, 5 Jun 2025 23:02:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA02.qualcomm.com (PPS) with ESMTPS id 4724nn0yww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Jun 2025 23:02:50 +0000
Received: from NASANPPMTA02.qualcomm.com (NASANPPMTA02.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 555N2oXF016679;
 Thu, 5 Jun 2025 23:02:50 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA02.qualcomm.com (PPS) with ESMTPS id 555N2nTP016673
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Jun 2025 23:02:50 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2342227)
 id 73933400B0; Thu,  5 Jun 2025 17:02:49 -0600 (MDT)
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
Date: Thu,  5 Jun 2025 17:02:37 -0600
Message-Id: <20250605230237.36131-1-schneide@qti.qualcomm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
References: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: bCj8C0_1nC0a4ax3e9OSxtNmfjKOWOCw
X-Proofpoint-GUID: bCj8C0_1nC0a4ax3e9OSxtNmfjKOWOCw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDIwNyBTYWx0ZWRfX+D4rG+64ooUh
 M4K34UTwOEt201uiB4xjJhtvGmgC86PZL295cEbIQINxVXzOWbf2zRA9tN5mDJOK9a757Q76abb
 kC79sAi/B/bxEXzrTmcPkbH+GLDr7Cn3NzzejQa7m8Gy2ko7M+XSO6g2Koygx9YoZDeeKsQxXOV
 M3GNM5mczosuJWmd7LzK2LsXb8alWjXoNs4CpSBU0sws0n5Z37ABw60+ft6Pt+xSRclq668dFUo
 xCEDAo0llG+L3bXTKGYHVXF1EQIbNSCMynN7aGyv5xuUZquV2Jmrkb7xQREpFoLWLASbuhK0kr/
 53bIzQEbQmRDHVmOEzwgRUFgZ844UyQpxq+usQzdMagVY4hQUe5uOKlM7na1w1r9MJNWLTTEKOU
 h1m4fV95LT30jPPiNdBnk02s4dLh9tA9buMDacOpaysu7zWzHmX6ftmE7x2LVg8gciFOtOeX
X-Authority-Analysis: v=2.4 cv=Y8/4sgeN c=1 sm=1 tr=0 ts=6842221b cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=jZVsG21pAAAA:8
 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=GRf2JX_IAAAA:8
 a=VYDjIKVHAAAA:8 a=_gsV02HDAAAA:8 a=eh1Yez-EAAAA:8 a=Er_Z3NQ58ajI8yPWPGwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3Sh2lD0sZASs_lUdrUhf:22
 a=uRw8vnb707Rr89TYUhP5:22 a=-sS9_DeNG7cEylvMdImQ:22 a=GzKgaEE0kT068tgm3IUS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_07,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050207
X-Mailman-Approved-At: Fri, 06 Jun 2025 08:32:51 +0200
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
 app/dumpcap/main.c                     |  4 ++--
 app/test/test_pcapng.c                 |  8 ++++----
 doc/guides/rel_notes/release_25_07.rst |  5 ++++-
 lib/graph/graph_pcap.c                 |  4 +++-
 lib/pcapng/rte_pcapng.c                | 21 +++++++++++++++------
 lib/pcapng/rte_pcapng.h                |  4 +++-
 7 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/.mailmap b/.mailmap
index 91e08f4a1f..a585124832 100644
--- a/.mailmap
+++ b/.mailmap
@@ -390,6 +390,7 @@ Dukai Yuan <dukaix.yuan@intel.com>
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
index 6b070801de..2396c7b014 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -108,7 +108,10 @@ API Changes
    This section is a comment. Do not overwrite or remove it.
    Also, make sure to start the actual text at the margin.
    =======================================================
-
+* pcapng: Changed the API for adding interfaces to include a link type argument.
+  The link type was previously hardcoded to the ethernet link type in the API.
+  This argument is added to ``rte_pcapng_add_interface``.
+  These functions are versioned to retain binary compatibility until the next LTS release.
 
 ABI Changes
 -----------
diff --git a/lib/graph/graph_pcap.c b/lib/graph/graph_pcap.c
index 89525f1220..13d86b7a18 100644
--- a/lib/graph/graph_pcap.c
+++ b/lib/graph/graph_pcap.c
@@ -11,6 +11,8 @@
 #include <rte_mbuf.h>
 #include <rte_pcapng.h>
 
+#include <pcap/pcap.h>
+
 #include "rte_graph_worker.h"
 
 #include "graph_pcap_private.h"
@@ -117,7 +119,7 @@ graph_pcap_file_open(const char *filename)
 
 	/* Add the configured interfaces as possible capture ports */
 	RTE_ETH_FOREACH_DEV(portid) {
-		ret = rte_pcapng_add_interface(pcapng_fd, portid,
+		ret = rte_pcapng_add_interface(pcapng_fd, portid, DLT_EN10MB,
 					       NULL, NULL, NULL);
 		if (ret < 0) {
 			graph_err("Graph rte_pcapng_add_interface port %u failed: %d",
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index cacbefdc50..95c1a4d635 100644
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
 
@@ -319,6 +318,16 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
 	return write(self->outfd, buf, len);
 }
 
+RTE_VERSION_SYMBOL(25, int, rte_pcapng_add_interface,
+				  (rte_pcapng_t *self, uint16_t port,
+				   const char *ifname, const char *ifdescr,
+				   const char *filter))
+{
+	/* Call the new version with a default link_type (Ethernet) */
+	return rte_pcapng_add_interface(self, port, 1 /* DLT_EN10MB */,
+									ifname, ifdescr, filter);
+}
+
 /*
  * Write an Interface statistics block at the end of capture.
  */
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index 48f2b57564..9880d415c4 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -71,6 +71,8 @@ rte_pcapng_close(rte_pcapng_t *self);
  *  The handle to the packet capture file
  * @param port
  *  The Ethernet port to report stats on.
+ * @param link_type
+ *   The link type (e.g., DLT_EN10MB).
  * @param ifname (optional)
  *  Interface name to record in the file.
  *  If not specified, name will be constructed from port
@@ -84,7 +86,7 @@ rte_pcapng_close(rte_pcapng_t *self);
  * must be added.
  */
 int
-rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
+rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 			 const char *ifname, const char *ifdescr,
 			 const char *filter);
 
-- 
2.27.0

