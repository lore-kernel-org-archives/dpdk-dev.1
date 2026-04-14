Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D495F9D0D3
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 15:25:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59AFE402F2;
	Tue, 14 Apr 2026 17:25:43 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5]) by mails.dpdk.org (Postfix) with ESMTP id EF326402EE
 for <dev@dpdk.org>; Tue, 14 Apr 2026 17:25:41 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63EEevMb1804741; Tue, 14 Apr 2026 15:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=2qeiPVRbv94qb/se4XFYbsUxUltzoAoYm8ipB6xDC
 6A=; b=ToYtGrJpXTwdMzbVRq9k28pYQWvlWBOqUTNclnGpxPDxpQ9HGUovrfdx4
 /qDq4m91CilHtdNbYl9kmDdOpi6GKVxiFf16SB+JDNEoDYqhcWqyf1HN710k+QbR
 th7BBvcYVU7/1X5ZMSjSV09OfLfTtD3Od40fxkr+9bdT2/1jnnfFY/PkOA/VzWop
 PJgSbuRmTV0MzSdhdLzHHXpihpItUCCodc000Sop7KCt7XYO4MG48qCz1uCorFXw
 lPqPyRWaBhNE9CELxcMACHzNASHtl1HhbW3T9MtVazh8IV9Eh5cRKg5BKQc+rV8V
 xxHEaXJ7cI7S34sVNfpUDJuJIkzfQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89k3ay3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Apr 2026 15:25:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63EDsLJ6015621;
 Tue, 14 Apr 2026 15:25:38 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0msj822-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Apr 2026 15:25:38 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63EFPbdw41419308
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Apr 2026 15:25:37 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4212058056;
 Tue, 14 Apr 2026 15:25:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C84558052;
 Tue, 14 Apr 2026 15:25:37 +0000 (GMT)
Received: from li-4c4c4544-0048-3510-8036-cac04f563434.atx-us.ibm.com (unknown
 [9.16.58.171]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Apr 2026 15:25:37 +0000 (GMT)
From: Riley Fletcher <rileyf@linux.ibm.com>
To: luca.vizzarro@arm.com, probb@iol.unh.edu
Cc: dev@dpdk.org, Riley Fletcher <rileyf@linux.ibm.com>
Subject: [PATCH] dts: ConfigurationError not thrown due to lack of next
 default value
Date: Tue, 14 Apr 2026 10:21:16 -0500
Message-ID: <20260414152116.277497-1-rileyf@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yo12OxmoSgDcVTsxYcc9HITnKpLJ0t1R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE0NCBTYWx0ZWRfX6cVN6ORN1CRO
 LFXQsiD4MSEZRUTQv3VvYsEvKYDVQ34ZQ3HC49WilnRvjmJnHTNX06CktrtnN3ytaGxV5ocJDAJ
 07uGUttLQbXAyouatY6PM2EdjMR/6cQYINx83a0571lq8Y40VMi6ChP1dh5jEggvss58yR8r81O
 P8S0kuusOBTQ7qixWWlKylDmYQreeWhLUU7tz2fKln6aLvGdoRolu3/m9274ttfGhcztxR4Vtcc
 nfdGjktOlkD+jzaTDIpUUBM1KLmBh+3hLIY7TMgz24XY5R8gr8bKplT1RFssQhJ1mQgJLYVGMmD
 uUjIovoDDe9QMn+1r1NpJksj+otDNgvKq7gIM7SkA4efXenvACrp4qqsQlOe2KtEAo/UgTWpt33
 b7PvhJnYo1lQmXo81Y+b4pdIqBsAZgy163AtW/et0A28qTJhR1mYPr9fP4SCz3o6j23kHl4o/IE
 +ZB3vpgEbPq39a6Z5KA==
X-Proofpoint-ORIG-GUID: yo12OxmoSgDcVTsxYcc9HITnKpLJ0t1R
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69de5c73 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=LdS19fCNI697wjaF:21 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Pi44RHbeux0Oy0Td5_UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140144
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

In DTS, when providing an nonexisting PCI address, a ConfigurationError
should be thrown. Instead, because the next() is not given a default
None, it instead hits a StopIteration error, which is harder to debug.

Signed-off-by: Riley Fletcher <rileyf@linux.ibm.com>
---
 dts/framework/testbed_model/linux_session.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index ee943462c2..3de92b549e 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -168,7 +168,7 @@ def get_port_info(self, pci_address: str) -> PortInfo:
             ConfigurationError: If the port could not be found.
         """
         bus_info = f"pci@{pci_address}"
-        port = next(port for port in self._lshw_net_info if port.get("businfo") == bus_info)
+        port = next((port for port in self._lshw_net_info if port.get("businfo") == bus_info), None)
         if port is None:
             raise ConfigurationError(f"Port {pci_address} could not be found on the node.")
 
-- 
2.53.0

