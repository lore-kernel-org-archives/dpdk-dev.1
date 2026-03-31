Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F48109B492
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 15:49:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E959E40A76;
	Tue, 31 Mar 2026 17:49:58 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5]) by mails.dpdk.org (Postfix) with ESMTP id 5324740A79
 for <dev@dpdk.org>; Tue, 31 Mar 2026 17:49:57 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62V7oWAZ108414; Tue, 31 Mar 2026 15:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=pUobOKN0PwALFNMKhkbkcwPhBWe+yCK1XLgciBQb9
 SE=; b=ZemSjz+96AzWHkk5cUo0TsrzPTVXL6KYI/12l6hm/8l18qlle2G0jWo6u
 juGBURWZxXOMfFF/WKx6PWLjeRSgPwl1S7x2aApZX+yGxma8pKZzLW30DehGlKoU
 qQlQn6MUoeLjtEXP4kqKsxK2O/PRfArjsie4/LiR4JzCBnyUPg2yG54YlhaWgsTw
 d37jUhyKiWogV/pgW1dQFSu1nEDgtPgYXcNurUw4bXhHyRJK2Ae+BSBOFKR5fjLW
 75L0+geO/pAEi192MscpLV/U6Z+2WKZlGMSGny6d+kjb12S/C6GR3/tMmGXJ1TYS
 bMWJssEbyPdLtwb1edfiNllj35B+Q==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcbpej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Mar 2026 15:49:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62VCBuI8013932;
 Tue, 31 Mar 2026 15:49:55 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkhpe4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Mar 2026 15:49:55 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62VFns8Q32178896
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Mar 2026 15:49:54 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FB7A58053;
 Tue, 31 Mar 2026 15:49:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19EF058043;
 Tue, 31 Mar 2026 15:49:54 +0000 (GMT)
Received: from li-4c4c4544-0048-3510-8036-cac04f563434.austin.ibm.com (unknown
 [9.24.10.250]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 31 Mar 2026 15:49:54 +0000 (GMT)
From: Riley Fletcher <rileyf@linux.ibm.com>
To: thomas@monjalon.net
Cc: dev@dpdk.org, Riley Fletcher <rileyf@linux.ibm.com>
Subject: [PATCH] doc: Power11 results added to tested platforms
Date: Tue, 31 Mar 2026 10:49:52 -0500
Message-ID: <20260331154952.2077911-1-rileyf@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cbed24 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=0axbP7ssGaT4PJcM5BUA:9
X-Proofpoint-GUID: M7-Gv4Ual9su-U-PPoykAHjFuXc1LoTM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE1MiBTYWx0ZWRfX4MqvO71VcCpO
 kyuaRtqW6r56X028IWM3QNPne58VDHYjR8cZqG/G1ib+aYiIALkVS5mwRgMpd6/cNqKGXk4I81C
 yM1G5DzFlGT0xTck0Kwi7P8zWFaRyWyUPciCoXPHTo4ByeOlkZelN4VZUgMU4TihQf4RzPHWRHD
 RlCEQeuzpF2lOKzXpze+EOkKA5ouZoFJE3GW9gDzq3dVGccmFNxfJ/Qa7W59NboGQt4+dQe4Y5W
 2oznHZ+FE1s6FddR5gEw0XRieHIDcv1gXNhPVHyCINSJ6vRsD4eDYclogXy57f1Wv6udzcGJs1I
 N4Rt9tKfJtpi2f0fclPCC102dVa4mK4HDE3k08OlvjurYGoV/oArdMNw3vZG9ol95ywfP+UQIDV
 QqKRZAhuPIfzbQlJuI7v9E84RKgBQfSwEiEdw7/Iage1X+lgwpDOgxPb3CQFbj2UHnzJaZNhlGO
 ykPj4qQOfh4PrRJ4XlA==
X-Proofpoint-ORIG-GUID: M7-Gv4Ual9su-U-PPoykAHjFuXc1LoTM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310152
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

Power11 testing results for 26.03 release notes

Signed-off-by: Riley Fletcher <rileyf@linux.ibm.com>
---
 doc/guides/rel_notes/release_26_03.rst | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index e323c2d7f1..f24da5fedb 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -393,3 +393,32 @@ Tested Platforms
   * DOCA:
 
     * DOCA 3.3.0-088000 and above
+
+* IBM Power 11 platforms with NVIDIA\ |reg| NICs combinations
+
+  * CPU:
+
+    * Power11 2.0 (pvr 0082 0200)
+
+  * OS:
+
+    * Red Hat Enterprise Linux 10.1 (6.12.0-124.45.1)
+    * SUSE Linux Enterprise Server 15 SP7 (6.4.0-150700.53.31)
+
+  * NICs:
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-7 25GbE MCX713104AS-ADAT (4x25GbE)
+
+      * Host interface: PCIe 4.0 x16
+      * Driver version: 26.01-1.0.0
+      * Firmware version: 28.47.1088
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-7 200GbE MCX755106AS-HEAT (2x200GbE) 
+
+      * Host interface: PCIe 5.0x16 with x16 PCIe extension option
+      * Driver version: 26.01-1.0.0
+      * Firmware version: 28.47.1088
+
+  * DOCA:
+
+    * DOCA 3.3.0-088000
\ No newline at end of file
-- 
2.53.0

