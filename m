Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68311FED9E4
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 15:56:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64B9540611;
	Tue, 17 Mar 2026 16:56:02 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by mails.dpdk.org (Postfix) with ESMTP id E63B54060C;
 Tue, 17 Mar 2026 16:56:00 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62HCdMIt2722906; Tue, 17 Mar 2026 15:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=4bUbFEZJkncjacXfQustou89pKDTKZODbjCkOD3tu
 ls=; b=DZTtuhk/BLpkJ8wbSn/Jxxwu4iBvoyxiolbBAbq3G9UnuiqhTTL2EB6/0
 nAwaVJNk7uL4U56Q7I9FKhyZs1yPETUJtmookr3pY1VAbRDyRdD6y2MjQNniOZLH
 0QzOHyEJyrZpcpNLNm404ONvGmEOu7ebZE6PkKt9nv1Ry7yByY9biGy211WIBFTV
 c4ivAg4nMA3bEFQfzAc9pwOIZEhnIuAfMTj3iZNAwR+YPBFrBEVe4nd18yNFuRcs
 SubkRCoS8R4X2ssfrvXAs+BUbniAB4PjRwPtaFTXK52nGQ0uL8QWIBwE2/TLrYnT
 8aNZ6Nav4JjRJSZYLXRhze1xXJorg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyaud1kx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 15:56:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HFsCWW028739;
 Tue, 17 Mar 2026 15:55:59 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgk9t2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 15:55:59 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62HFtwt04129768
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2026 15:55:58 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B4B458056;
 Tue, 17 Mar 2026 15:55:58 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC50A58052;
 Tue, 17 Mar 2026 15:55:57 +0000 (GMT)
Received: from li-4c4c4544-0048-3510-8036-cac04f563434.austin.ibm.com (unknown
 [9.24.10.250]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Mar 2026 15:55:57 +0000 (GMT)
From: Riley Fletcher <rileyf@linux.ibm.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Riley Fletcher <rileyf@linux.ibm.com>
Subject: [PATCH] docs: add Power10 testing to 25.11 release page
Date: Tue, 17 Mar 2026 10:55:38 -0500
Message-ID: <20260317155538.1282864-1-rileyf@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEzOSBTYWx0ZWRfX5jNS3laZkYl8
 BhADhtwz+HETGvh8h0xZ4UyYFYDjVf9JaNW3mOHR60+st0VaqfDV9/E05q5x61lNrvmaRXt7jmK
 028n1a9O7lZZvq2KxMh34KfE0rEUQAIx0hZqtyAVMw4pngCoL1AJkrTahjmw987tRqSzXzaSb6r
 3id9zKsWk/aZsy9Tiba1aBOtCjkxqBwcbuecEAxUcQhfrLB2vwKtYvnVlC5RhDB7XFvrn93YQRW
 McCiBePbNnqaDVtqAd+fz1mdGZFH1fi7wWxK0W33x7ULgNLNVMgXOFsf9o6AF7ZP9Lk8ArjD/uM
 VmfocIMvvPVTINTQbppJDLIXkVnYlXAoQ3BFeREwzo9WfVrokM5CoxY+LTjBCbWOHNFQ0TLA84o
 OAIym+lp2cHAs9beLwSfTnx4ZJnpocS4z0BhE02ldK7RMc7TQGK29Xh4aNiQg3go1l1CR2wmlvr
 dgn9n/hMpGwzBuJqNZg==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b97990 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=I-4xFkI7mVfDsojwPMUA:9
X-Proofpoint-ORIG-GUID: CGpjoPD1Oj5m3C9wVtVFXShRhRkO43yM
X-Proofpoint-GUID: CGpjoPD1Oj5m3C9wVtVFXShRhRkO43yM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_03,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170139
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

Adding previous Power10 testing results; can be added to 25.11 docs as
well if deemed necessary
---
 doc/guides/rel_notes/release_25_11.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index f3beb6b3d6..4a284adabc 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -489,3 +489,23 @@ Tested Platforms
   * DOCA:
 
     * DOCA 3.2.0-125000 and above
+
+* IBM Power 10 with NVIDIA\ |reg| NICs combinations
+
+  * CPU:
+
+    * IBM Power10 CHRP IBM,9105-22A
+
+  * OS:
+
+    * RHEL 10.0  kernel: 6.12.0-55.9.1.el10_0.ppc64le
+
+  * NICs:
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-5 100G MT28800 Family
+
+      * Host interface: PCI Express 3.0 x16
+      * OFED 25.07-0.9.7
+      * Firmware Version: 16.35.2000
+
+  
-- 
2.53.0

