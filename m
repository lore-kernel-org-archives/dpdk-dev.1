Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779D7C54F30
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 07:33:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DC1C4025E;
	Fri, 30 May 2025 09:33:27 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by mails.dpdk.org (Postfix) with ESMTP id 89D6440275
 for <dev@dpdk.org>; Thu, 29 May 2025 19:16:44 +0200 (CEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TC1Kxb008028;
 Thu, 29 May 2025 17:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=+Fj4GD7If4W4M/DVxVvRTtLMiMcrEEjvuj/
 zaqYAaGo=; b=OYEhJzn+dYS6x14xMRBMwrciuu3HRrg9V8HrjltakbaKRjTdmKi
 WEZczzQwL95nVQNFNka0+Z+A4O5sVGc5KFfppmZ0gLDLg4MLxLbAekDYqN61LLuw
 qTf/lIG3K2NAwjAs5iCj6rEojEfGpjfhfvTk04desn7XORbDaJHSnjLirv5kk+4D
 4+DaCa6ft/IW34YPj9L8Rx5ZdlTti5WUwFaKlFtlu7RjeLhZ/fTOsuhRXbpJ8TbQ
 HcFpEdcT3x9mQdELd0PjCMOXMYIjC8ZRRb37jSHXJi4xix08HAD1hOdbi6hajVew
 RFnZAwXieqWQKitG38moOcAJlCTx0q6yxTw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46w992rgpg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 May 2025 17:16:37 +0000 (GMT)
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 54THGajb001820; 
 Thu, 29 May 2025 17:16:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 46wwx5x0uc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 May 2025 17:16:36 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54THGaKM001805;
 Thu, 29 May 2025 17:16:36 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 54THGaAs001798
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 May 2025 17:16:36 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2342227)
 id CFF6840097; Thu, 29 May 2025 11:16:35 -0600 (MDT)
From: Schneide <schneide@qti.qualcomm.com>
To: Thomas Monjalon <thomas@monjalon.net>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Cc: dev@dpdk.org, Dylan Schneider <schneide@qti.qualcomm.com>
Subject: [PATCH] pcapng: allow any protocol link type for the interface block
Date: Thu, 29 May 2025 11:16:09 -0600
Message-Id: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE2NyBTYWx0ZWRfX6hrp1rkF4DPB
 CHS6JeRTkyEpZmYF0OWtgPX6e1KN1DM0QmeBgIzXCj7BaQ7wEX/Pgg1I3wcvce+5BDrHeSufcpz
 jjafKD8L+QU9MNl0osD80HkcE1kyilAOrI4S4t2mmfykwDI2VDD0hhWo/PzGpcmBBQsjAHh/BLh
 GUbFli1nM3isKV+Jp7ljp00Q6SUBLB0JsjYUG3Y1sutVMAgWMGZ504JMbJJ9XOlQ5BpKOAG17eI
 1uTZJopBOxhOWnRLUnU2mjjm9LJkA776ew/mj+Ysw5LQJtKsba6dvUyBReXc8wYT8w2z8lZNObq
 UuI633jV9ro3YUmUbMtRNg+oljT8RowTEUTiaBsZDjA9+MNqMJWhawQ1Kyh55dtdlEPWfM7i5+T
 rICjYY73NbmHvbOWQ5Mqe9IoLidMnRImHOpzw+QemXtO7anhypV6LnRkPfEo/F2KU3IkrFj3
X-Authority-Analysis: v=2.4 cv=Fes3xI+6 c=1 sm=1 tr=0 ts=68389675 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=jZVsG21pAAAA:8 a=20KFwNOVAAAA:8
 a=pGLkceISAAAA:8 a=GRf2JX_IAAAA:8 a=VYDjIKVHAAAA:8 a=QyXUC8HyAAAA:8
 a=_gsV02HDAAAA:8 a=eh1Yez-EAAAA:8 a=vaV7aeZFSSOTtZGL5nwA:9
 a=3Sh2lD0sZASs_lUdrUhf:22 a=uRw8vnb707Rr89TYUhP5:22 a=-sS9_DeNG7cEylvMdImQ:22
 a=GzKgaEE0kT068tgm3IUS:22
X-Proofpoint-GUID: 8RcbMb_YQyy6obaOL5gSg1a2dl3OxpqQ
X-Proofpoint-ORIG-GUID: 8RcbMb_YQyy6obaOL5gSg1a2dl3OxpqQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290167
X-Mailman-Approved-At: Fri, 30 May 2025 09:33:26 +0200
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

diff --git a/.mailmap b/.mailmap
index d9423aa..7ef0964 100644
--- a/.mailmap
+++ b/.mailmap
@@ -388,6 +388,7 @@
 Dumitru Ceara <dceara@redhat.com> <dumitru.ceara@gmail.com>
 Duncan Bellamy <dunk@denkimushi.com>
 Dustin Lundquist <dustin@null-ptr.net>
+Dylan Schneider <schneide@qti.qualcomm.com>
 Dzmitry Sautsa <dzmitryx.sautsa@intel.com>
 Ed Czeck <ed.czeck@atomicrules.com>
 Eduard Serra <eserra@vmware.com>
diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 3d3c0db..e0e2b26 100644
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
index 8f2cff3..bcf9972 100644
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
diff --git a/lib/graph/graph_pcap.c b/lib/graph/graph_pcap.c
index 89525f1..46fab8c 100644
--- a/lib/graph/graph_pcap.c
+++ b/lib/graph/graph_pcap.c
@@ -117,7 +117,7 @@ graph_pcap_file_open(const char *filename)
 
 	/* Add the configured interfaces as possible capture ports */
 	RTE_ETH_FOREACH_DEV(portid) {
-		ret = rte_pcapng_add_interface(pcapng_fd, portid,
+		ret = rte_pcapng_add_interface(pcapng_fd, portid, DLT_EN10MB
 					       NULL, NULL, NULL);
 		if (ret < 0) {
 			graph_err("Graph rte_pcapng_add_interface port %u failed: %d",
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 16485b2..bed1e14 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -205,7 +205,7 @@ pcapng_section_block(rte_pcapng_t *self,
 /* Write an interface block for a DPDK port */
 RTE_EXPORT_SYMBOL(rte_pcapng_add_interface)
 int
-rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
+rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 			 const char *ifname, const char *ifdescr,
 			 const char *filter)
 {
@@ -277,7 +277,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
 	hdr = (struct pcapng_interface_block *)buf;
 	*hdr = (struct pcapng_interface_block) {
 		.block_type = PCAPNG_INTERFACE_BLOCK,
-		.link_type = 1,		/* DLT_EN10MB - Ethernet */
+		.link_type = link_type,
 		.block_length = len,
 	};
 
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index 48f2b57..0a35ec9 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -71,6 +71,8 @@ rte_pcapng_close(rte_pcapng_t *self);
  *  The handle to the packet capture file
  * @param port
  *  The Ethernet port to report stats on.
+ * @param link_type
+ *  The protocol link type of the packets
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
 
