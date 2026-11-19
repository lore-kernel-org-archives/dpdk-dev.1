Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA4606A324
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n0zh1XBR
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFFFF402D6;
	Thu, 19 Nov 2026 16:46:10 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by mails.dpdk.org (Postfix) with ESMTPS id 22DB7400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 16:46:09 +0100 (CET)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJFQIXv340174; Thu, 19 Nov 2026 15:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=nRhkpagq9BtmZ6yoVr33l7jHq+caqphE6afNZzqqG
 18=; b=n0zh1XBRlBGEl/9zWgZIXyLmnNdiHhL43gGv4Y8b8njoyDXAdBH3txhwO
 oA5UQVE15TtqDRMvX1yANdqujUfKZds/6OXBy9t/DwAGmWPohNevXnFkv3wJ13cJ
 h+J4VRh3aiaalWfk7trbs+jx5OqyrnoToivlUXVd1ikmZUTRqPqDOohBOIIo49W4
 GKMRB2/1XlS10tmwuP4WO5vBpRpjNii4GqmB4/I5Y8+P07r2Kjz2xSqef8LTGysY
 S2g1cN634LkTivO/M0x9u4/qH/guFofjOL26gEJB09UekxaK4Vo7+M5knAnx8WDR
 Hakh30dVajwL2Fqh6eFG8ilHIh5Iw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105ta788-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 15:46:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJF5xsL2738217; Thu, 19 Nov 2026 15:46:07 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1v9xagqg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 15:46:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AJFk69V27394812
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Nov 2026 15:46:06 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75DBC58056;
 Thu, 19 Nov 2026 15:46:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A85258052;
 Thu, 19 Nov 2026 15:46:06 +0000 (GMT)
Received: from li-4c4c4544-0048-3510-8036-cac04f563434.atx-us.ibm.com (unknown
 [9.16.50.223]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Nov 2026 15:46:06 +0000 (GMT)
From: Riley Fletcher <rileyf@linux.ibm.com>
To: thomas@monjalon.net
Cc: dev@dpdk.org, Riley Fletcher <rileyf@linux.ibm.com>
Subject: [PATCH] doc: Power11 results for tested platforms
Date: Thu, 19 Nov 2026 09:46:04 -0600
Message-ID: <20261119154604.281229-1-rileyf@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6aff19c0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=B5_JP_qafU1pvKadn6QA:9
X-Proofpoint-ORIG-GUID: 6m1YyKWjcKzyX0BM3UroF6DiIKNbBtsO
X-Proofpoint-GUID: 6m1YyKWjcKzyX0BM3UroF6DiIKNbBtsO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA2MSBTYWx0ZWRfX0PQFsS8iKflL
 9uF9waZl0nLZeEp/mwoDybTzGtnhTMPEYEidZ1DKX/SpS2dJJK7Dr8+trw0QL4a9IBJZ8ADyyw5
 4VaJk1iAhUjfqDxZNC9m45h+rk2yaqqvpB/SkDc8aIldfMX11mxATl+QlWybMMa3iBFFEhL63lw
 j8YefBZAAKM2C4EuLNPZg4+wafS76wQtrAa3obCkosObQLyC3xm/p1vDDEuFBc7JS0XYLs2RyNK
 T5Ij7+PFJZbKXmBIqewZbpoOuEVQ+Vdh1q5rjGi7CS17qYV09fgCqjhdTqkZQSftOaYCcEdrTiB
 nA8Bwwh7Ngi02R4hy4/w8G+N7Q00kaDXE32P3vwWb8ZxpN7ua9IVHx3lTb7tvUlFZKgCExPWifo
 ageJmyUgIe1YVm3BDi09A/i/kFyUveUnumITZIyDEf3KJEUKuPcK/vAtx5+QBgnmwLPaRYSC+FJ
 OKy5scAyt0FEBFHiuJQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA2MSBTYWx0ZWRfX0sfehoWoTw7n
 bWWBwdM5viLXfWcl0ObOlALpU4s9tWPQHOekDcfVgh/ZCpL73b7BSTM8l+59YTKXGaqoa3VCEg9
 qUV6xPn9kjPkgY/H8cJstmSQ46V5ZMA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190061
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Power11 testing results for 26.11 release notes

Signed-off-by: Riley Fletcher <rileyf@linux.ibm.com>
---
 doc/guides/rel_notes/release_26_11.rst | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 8387949ef3..eb6df021b7 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -761,3 +761,32 @@ Tested Platforms
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
+    * SUSE Linux Enterprise Server 16.0 (6.12.0-160000.36)
+    * PowerVM Logical Partitions via pHyp Hypervisor
+
+  * NICs:
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-7 25GbE MCX713104AS-ADAT (4x25GbE)
+
+      * Host interface: PCIe 4.0 x16
+      * Driver version: 2607.0.100
+      * Firmware version: 28.47.1088 (MT_0000000834)
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-7 200GbE MCX755106AS-HEAT (2x200GbE)
+
+      * Host interface: PCIe 5.0x16 with x16 PCIe extension option
+      * Driver version: 2607.0.100
+      * Firmware version: 28.47.1088 (MT_0000000834)
+
+  * DOCA:
+
+    * DOCA 3.5.0-082000.ppc64le
\ No newline at end of file
-- 
2.56.1

