Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AD0C88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 14:24:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15F0140DDC;
	Tue, 15 Sep 2026 16:24:15 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1]) by mails.dpdk.org (Postfix) with ESMTP id 84B1E40B91
 for <dev@dpdk.org>; Tue, 15 Sep 2026 16:24:13 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FD1hF13198561 for <dev@dpdk.org>; Tue, 15 Sep 2026 14:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=gWlH/clPvl0e2Cr2wqDsu3GIi+OOwut12+jUWMbC6
 do=; b=kTZj7BSldrCWqKixmylba9ZB6AGoOf89eqrUrmWwncQcyWMmtitz9Fp0M
 VhKHs9gDKQWKd8vcw2ZBTBsInG98oE+qnT8HS4COYANLmgMRCI4LIEbCaPATxB4j
 BMSAS3QYTp+myDD2VaDG/RPBcJKZ8PHRrZdpvWUxUKVMDXTouFjbXqrxZN+5Cf64
 2mh9dKib2j8nbZ0sfQP8QQ1Z85kspdsg/xZyBB+9U8DsLRUTzSTvwwiKAJEejFmE
 4pM99F1WX6AGPpu6282wmT/LVZrXP25ar0DAWW0Kv5BH139JxscA10febvnl7K5N
 fs172spTSnRgwE/h6l1k54ZR1TZXw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdq7h25-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 15 Sep 2026 14:24:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FD54gO739073 for <dev@dpdk.org>; Tue, 15 Sep 2026 14:24:11 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpw6d29ww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 15 Sep 2026 14:24:11 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68FEOAdU34144852
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Sep 2026 14:24:10 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50CD158068;
 Tue, 15 Sep 2026 14:24:10 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 035F658054;
 Tue, 15 Sep 2026 14:24:10 +0000 (GMT)
Received: from li-4c4c4544-0048-3510-8036-cac04f563434.atx-us.ibm.com (unknown
 [9.16.50.223]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Sep 2026 14:24:09 +0000 (GMT)
From: Riley Fletcher <rileyf@linux.ibm.com>
To: dev@dpdk.org
Cc: drc@linux.vnet.ibm.com, Riley Fletcher <rileyf@linux.ibm.com>
Subject: [PATCH] maintainers: add IBM Power maintainer
Date: Tue, 15 Sep 2026 09:23:49 -0500
Message-ID: <20260915142349.1249543-1-rileyf@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIwNCBTYWx0ZWRfX9llbBJltkpPV
 xi6m31XPNkVDz8iofv5EZ/QeqmcZf5P1Ayyn5ekbgiNCbSdPl0tzrtErvAsQXBIJTx8ErnK6C+X
 CHc/usO4vKEYE+9bNqaq8nzF5yReIInucGHOIXj7LMx5XnuVAoVM7SwvXSug/Q+mGv1RqenOshe
 MKglG7LFTJ/p/OjVQSnyYSdsO6A4/ycfVhShx6G4nYRgbdZ7Wio9c4x5r6ujSzFGmEBKVdY+oJs
 ELknzdGvkTHLi/+LBqkNGYqUT+RRaYz0q3Sh7G45SjRqi/laqeskquP4dRZxZHLyaav9vrQMmpw
 9fXZFJsHFad7w2ldtrQmSiYTfdDP3UG1wlAHPv5A1WFwG1omVIYEpFEFuY+OHW2r2XpB2iyMS5v
 WSLhXmZ8aDSvUE6bpDI5A8h/5PbSfcAHSFhO9f01aja4VhSdik1BzDesaJwnFWifrQW6cJFWdsi
 qnz1eTBy8v7b18AQI6A==
X-Proofpoint-GUID: 5Gx29Iow11HtUxp2xUPTBbnJwyb5FapP
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aa9550c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=hjjKd0yZYf76FzRmxhkA:9
X-Proofpoint-ORIG-GUID: 5Gx29Iow11HtUxp2xUPTBbnJwyb5FapP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIwNCBTYWx0ZWRfX5wVWUClsHFpR
 pgvza1dvRlOnkczzkXDib78/x+xRiqr8RADEpZXlI1MksU6gjoFUS8UltU51aWG9cUgHA78oIeq
 6nkZ700TrOnxqpz6Y94OUK228d99F8o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150204
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

Adding Riley Fletcher as Power maintainer.

Signed-off-by: Riley Fletcher <rileyf@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e99a65d197..6447912e0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -331,6 +331,7 @@ F: lib/eal/loongarch/
 
 IBM POWER (alpha)
 M: David Christensen <drc@linux.ibm.com>
+M: Riley Fletcher <rileyf@linux.ibm.com>
 F: config/ppc/
 F: lib/eal/ppc/
 F: lib/*/*_altivec*
-- 
2.55.0

