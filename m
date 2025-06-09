Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEA8C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 21:19:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79D6240E34;
	Mon,  9 Jun 2025 23:19:53 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by mails.dpdk.org (Postfix) with ESMTP id E1EEB402C8
 for <dev@dpdk.org>; Mon,  9 Jun 2025 23:19:51 +0200 (CEST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5599XTVU027298;
 Mon, 9 Jun 2025 21:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aGdRgtjC4RNB/QbyJ3hf0EQNfN4iEZM2e0Q1GfOcgBQ=; b=KVYPnWSpfnWzzLBy
 mattI5Y2ItxU1uxiUXtq/Hr2r7M1mJUa7o2LXJ2+VLENlnjZSk78G8sAiuBlTdBg
 tMUaYujrYiIvdKxmG82SJkt8WN1ubU3ADUtOu99M2sAbLoiVpdj4CtPtIX6diRkX
 LDLuR3JQk4klVBHJMZCKxJ4dU7sVTQ6EPm6bisplSGcV+X0jw8cCPQeFjqeJ0jrA
 xNMkMGUKrrhQX3xKbH+eW54qHdeoNRUzymz7U5aa+tvWLjwKJXnCb9BC/VQtmm07
 ypp/qW51AATnxlqEvgVQULbcWsiIUW0dU4NdH5CLNHx5EFwmWmu96ILLYb5l13WI
 nEB4Vw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474e6jf3cr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 21:19:43 +0000 (GMT)
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
 by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 559LJhPZ032543; 
 Mon, 9 Jun 2025 21:19:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 474egnxd3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 21:19:43 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 559LIbj7031150;
 Mon, 9 Jun 2025 21:19:43 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 559LJgQo032524
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 21:19:42 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2342227)
 id 3CD8E400B8; Mon,  9 Jun 2025 15:19:42 -0600 (MDT)
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
Date: Mon,  9 Jun 2025 15:19:37 -0600
Message-Id: <20250609211937.345620-1-schneide@qti.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Id6HWXqa c=1 sm=1 tr=0 ts=68474fef cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=jZVsG21pAAAA:8
 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=GRf2JX_IAAAA:8
 a=VYDjIKVHAAAA:8 a=_gsV02HDAAAA:8 a=eh1Yez-EAAAA:8 a=t_NVbEpo0bFBxwTkvzcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3Sh2lD0sZASs_lUdrUhf:22
 a=uRw8vnb707Rr89TYUhP5:22 a=-sS9_DeNG7cEylvMdImQ:22 a=GzKgaEE0kT068tgm3IUS:22
X-Proofpoint-ORIG-GUID: VPpDfHaiLDF5nAuv5IVa9yaiF3Ia1pXC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDE2MyBTYWx0ZWRfXxnbLNJbgiGZx
 pD5VFsIXmmVT4ggcK9m/gv4/cbxBvKMt6d/MR80dLNl8CZnRf49eO7GJ7iJeJ375RHpd8k4C6us
 /GRqloFDU5ZoQW/Tc++cJtiAlq7/gRWxIQDOy+HPHt7qHPjFIiAyeRHWnH6JkYOdVn+1Xd/Vu86
 7/eKq08gkjIO+00g6DNyjqZkO3eUddpE/f/faDrHIBRmff06u0G0a818+pkb22fsihcUdUtzrJX
 e/1DAol6cK+mmDJ5RxXTErQR+yut7UiIciZjNdBigiJn7Q2t7j2dbWEK2DvPy/i+gjoRhcgkATk
 9b2cD5/O/SjQ1Wv3TAOOb0WA7ugQyFPz46p/oNC0oMUHgCcaM2FeDWTloPpCGMuqmKiDKPVPL5r
 DwsC/MisGj7kTUK++nFdpXE+1v6Ab8ByrT0ENnfCJoGoL/BjfEv6mOipew0Ai6InERvELiYK
X-Proofpoint-GUID: VPpDfHaiLDF5nAuv5IVa9yaiF3Ia1pXC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_09,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090163
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
 doc/guides/rel_notes/release_25_07.rst |  4 ++++
 lib/graph/graph_pcap.c                 |  4 +++-
 lib/pcapng/meson.build                 |  7 +++++++
 lib/pcapng/rte_pcapng.c                | 22 ++++++++++++++++------
 lib/pcapng/rte_pcapng.h                |  4 +++-
 8 files changed, 40 insertions(+), 14 deletions(-)

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
index 6b070801de..5f8a472928 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -109,6 +109,10 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
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
diff --git a/lib/pcapng/meson.build b/lib/pcapng/meson.build
index 4549925d41..d1ace87feb 100644
--- a/lib/pcapng/meson.build
+++ b/lib/pcapng/meson.build
@@ -1,7 +1,14 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2019 Microsoft Corporation
 
+if not dpdk_conf.has('RTE_HAS_LIBPCAP')
+    build = false
+    reason = 'missing dependency, "libpcap"'
+endif
+
 sources = files('rte_pcapng.c')
 headers = files('rte_pcapng.h')
 
 deps += ['ethdev']
+
+use_function_versioning = true
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index cacbefdc50..9db8813696 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -29,6 +29,7 @@
 #include <rte_reciprocal.h>
 #include <rte_time.h>
 
+#include "pcap/dlt.h"
 #include "pcapng_proto.h"
 
 /* conversion from DPDK speed to PCAPNG */
@@ -200,11 +201,10 @@ pcapng_section_block(rte_pcapng_t *self,
 }
 
 /* Write an interface block for a DPDK port */
-RTE_EXPORT_SYMBOL(rte_pcapng_add_interface)
-int
-rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
-			 const char *ifname, const char *ifdescr,
-			 const char *filter)
+RTE_DEFAULT_SYMBOL(26, int, rte_pcapng_add_interface,
+		   (rte_pcapng_t *self, uint16_t port, uint16_t link_type,
+		   const char *ifname, const char *ifdescr,
+		   const char *filter))
 {
 	struct pcapng_interface_block *hdr;
 	struct rte_eth_dev_info dev_info;
@@ -274,7 +274,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
 	hdr = (struct pcapng_interface_block *)buf;
 	*hdr = (struct pcapng_interface_block) {
 		.block_type = PCAPNG_INTERFACE_BLOCK,
-		.link_type = 1,		/* DLT_EN10MB - Ethernet */
+		.link_type = link_type,
 		.block_length = len,
 	};
 
@@ -319,6 +319,16 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
 	return write(self->outfd, buf, len);
 }
 
+RTE_VERSION_SYMBOL(25, int, rte_pcapng_add_interface,
+		   (rte_pcapng_t *self, uint16_t port,
+		   const char *ifname, const char *ifdescr,
+		   const char *filter))
+{
+	/* Call the new version with a default link_type (Ethernet) */
+	return rte_pcapng_add_interface(self, port, DLT_EN10MB,
+					ifname, ifdescr, filter);
+}
+
 /*
  * Write an Interface statistics block at the end of capture.
  */
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index 48f2b57564..cce141e3f4 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -71,6 +71,8 @@ rte_pcapng_close(rte_pcapng_t *self);
  *  The handle to the packet capture file
  * @param port
  *  The Ethernet port to report stats on.
+ * @param link_type
+ *  The link type (e.g., DLT_EN10MB).
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

