Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408C2C44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 05:38:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 147EF402A7;
	Tue, 21 Jul 2026 07:38:58 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1]) by mails.dpdk.org (Postfix) with ESMTP id 79F0B40289
 for <dev@dpdk.org>; Tue, 21 Jul 2026 07:38:56 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KNEK153568023; Tue, 21 Jul 2026 05:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=fDV/RoIWR9fb7sEA/zrdgD8bgOq0UF2PieQCxF6Kx
 RM=; b=dZQY+jBzK0qnACZawsFtZXXZSXjIovva/wG3mG9o1ikDtQmen7wYpZD/x
 cnaNWGdBp6etb/4E6FxvUq/FnCI5CsBmtLNM2caJDRhUYgQACBJ1OIsBRDAUxDBY
 7UIJ/Buprk1GP1BbnLEAT1EtHUbEFE3pGsd8V2P/ROWAXmqDX2oZ9jmqxF/Irk7m
 HN22vhgFr1PyDkmVt2Lbp5gsmAKR+UNripQMGJufIppiqaRwhlsCvJdTSqn/is0U
 1k4FOAg+CjvZbt3N7UpgHHIaRHeTMUGVx26gN/9ZLtjgmESNIk0uH25w/uqoLPSI
 ISlWqTBS7b4AbwihSxCp+ZqPN4UOg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg790u18j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 05:38:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L5YZZs022236;
 Tue, 21 Jul 2026 05:38:54 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgy8mrn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 05:38:54 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66L5cpmx23200326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jul 2026 05:38:51 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C82CD58050;
 Tue, 21 Jul 2026 05:38:51 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A9A858045;
 Tue, 21 Jul 2026 05:38:51 +0000 (GMT)
Received: from li-4c4c4544-0048-3510-8036-cac04f563434.ibm.com (unknown
 [9.61.182.70]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Jul 2026 05:38:51 +0000 (GMT)
From: Riley Fletcher <rileyf@linux.ibm.com>
To: thomas@monjalon.net
Cc: dev@dpdk.org, Riley Fletcher <rileyf@linux.ibm.com>
Subject: [PATCH] doc: Power11 platform results for release notes
Date: Tue, 21 Jul 2026 00:38:25 -0500
Message-ID: <20260721053825.2434682-1-rileyf@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gUqHflOjQiScif7JK1ug52O9wBGlCjFi
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a5f05ef cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=B5_JP_qafU1pvKadn6QA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA1MSBTYWx0ZWRfX6PDxWLhjMA8p
 uqzUkKjwfc8yzoLP8CJiGhxwGSQaTDxEGuIZ9epFWDxWuvk1MsQ9skfOadFPaHDpfZXtz7N6QE2
 Vlk2vs2ZyegkuxY5t6F5qlWIxlunU8w=
X-Proofpoint-GUID: gUqHflOjQiScif7JK1ug52O9wBGlCjFi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA1MSBTYWx0ZWRfX666PlYWMw3eT
 Q++VnBXbdFLro3nv4hC5ZYg8crM23+jLylv7UX9mUjx3wqICks3Mnnqk6+N32ilLOOFs8UKk/wV
 wpUx1mCNR4o+npoqqrfB7IoXpCJzD777GrY93TIgzlA9eB775m3XTjsxCAAdQnNoG9Ernqlbgo0
 ZV6wkTYqTmd6eXmu86luqoBjD1XyD4uBk8fp9/VKkB3GgeNRXAeqg4+Cg5yblHOAbnhu5UW2xdz
 f6w1eLKiF4T3asA/VWXDjdbQix3bWMoCANL4nOGgKJHqqRIEf9DvUFYrfWlTmnOBJOSVUBP2Xbo
 txq8+vnWvQc7SQiY4E1o0f7+x4eYc+TpwKlufpUanstD3YgP2aHXzohkfyBjKr+lIorjBZYIFh2
 sWkmH6SJfo+h7PBI8vwXpeZRAUrL3QEBz6qPmOd6ICsM/YUqdKQ+8cs3vmWSZ7pnjbefroDSumQ
 i+9eSXqlhL0fG6kg7Gg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210051
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

Power11 tested platform for 26.07 release notes

Signed-off-by: Riley Fletcher <rileyf@linux.ibm.com>
---
 doc/guides/rel_notes/release_26_07.rst | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 6badd6d91b..e919a3b941 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -403,3 +403,32 @@ Tested Platforms
    This section is a comment. Do not overwrite or remove it.
    Also, make sure to start the actual text at the margin.
    =======================================================
+* IBM Power 11 platforms with NVIDIA\ |reg| NICs combinations
+
+  * CPU:
+
+    * Power11 2.0 (pvr 0082 0200)
+
+  * OS:
+
+    * Red Hat Enterprise Linux 10.2 (6.12.0-211.20.1.el10_2.ppc64le)
+    * SUSE Linux Enterprise Server 15 SP7 (6.4.0-150700.53.66)
+    * PowerVM LPARs via pHyp Hypervisor
+
+  * NICs:
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-7 25GbE MCX713104AS-ADAT (4x25GbE)
+
+      * Host interface: PCIe 4.0 x16
+      * Driver version: 26.04-0.8.6
+      * Firmware version: 28.48.1000
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-7 200GbE MCX755106AS-HEAT (2x200GbE)
+
+      * Host interface: PCIe 5.0x16 with x16 PCIe extension option
+      * Driver version: 26.04-0.8.6
+      * Firmware version: 28.48.1000
+
+  * DOCA:
+
+    * DOCA 3.4.0-085000.ppc64le
-- 
2.55.0

