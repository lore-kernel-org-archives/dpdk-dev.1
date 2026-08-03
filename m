Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5434FC5516F
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 06:24:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4595640272;
	Mon,  3 Aug 2026 08:24:26 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 10C3840269
 for <dev@dpdk.org>; Mon,  3 Aug 2026 08:24:24 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6730G2mM3311422; Sun, 2 Aug 2026 23:24:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=26Nkw98YMCKg7nT+FRxGodh
 wpGmcj2dtYNYrY4l7U7Y=; b=k6gTA3wux1KTAyPH7hLYw4uS21dj7vwAtEE3rod
 Pc0E1BQFQc4fwp2e8R9EDZWTYm9F/TSthijdkGDr5eMgc7guk2o4Fr7wlSNAiknq
 PE1rF6vZqL4NWXBMzQWBncYnsN4cB0rcNqbOy2f3wB8Do9ol8eSgrfqH0QAth+LA
 IAT1B97qE0enzkpqawbPB3MetnspG8gZeUvxSi+dmm4GpDyzh282QFzd1xzbUoGt
 Ela0cjHUP3bdiwoQU0Sn8CeJXgOxZKMmI6nOVl0YsmPIpqfTW1ilShPGnpPA5vXk
 6+gCly6nT1KNERcs0zqwuuwvZ0e3TjMlkqEYYBmwXdqLr7w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ft1j8hwk5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 02 Aug 2026 23:24:24 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 2 Aug 2026 23:24:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 2 Aug 2026 23:24:22 -0700
Received: from hyd11149.caveonetworks.com (unknown [10.29.44.105])
 by maili.marvell.com (Postfix) with ESMTP id 743F63F70A4;
 Sun,  2 Aug 2026 23:24:20 -0700 (PDT)
From: Rupesh Chiluka <rchiluka@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <ktejasree@marvell.com>, <anoobj@marvell.com>,
 <jerinj@marvell.com>, <stephen@networkplumber.org>, Rupesh Chiluka
 <rchiluka@marvell.com>
Subject: [PATCH v1 1/3] common/cpt: use timing-safe digest comparison
Date: Mon, 3 Aug 2026 11:54:13 +0530
Message-ID: <89e98b3ccc1ad93ed67fb5750c88df94f0c1ecf7.1785737875.git.rchiluka@marvell.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Ip0utr/g c=1 sm=1 tr=0 ts=6a703418 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=JR0WhENSYSrLnM2BT_EA:9
 a=zZCYzV9kfG8A:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1MyBTYWx0ZWRfX9DQZzqTLbMU5
 fkvZnY+/6F2BCTGF/9VzwTQxsYgsLEYP3khErO3+c6GCu4SFYsdqdU5LNbVqigJ5RB1sPJ3CQ/m
 HHGGVk3fEcOE/ejnB7C/QdCGGBvpG6M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1MyBTYWx0ZWRfX/1zmlNvCLPxT
 xlhwc9uV2sf4UwGKaaj2XAA4EcCeFspTPmv/S0//5xLKjzIoeGcL66XyPxeg07kAD3+my/QvEFu
 JqplGLTcviZmJhdrtbpZi+YJsaU/LipaWmhesjJ8ETNlPCNcvAC0/OcZdUkukrOL38Ihauf8sS+
 D3xN5sFha44CFOyqAUqxYbi6ywMpUr/KIZ5FKFAkk17zUHJdlY4stKv2aM59JHgPN9M78IzK0vB
 QBq4l4vydmLEQzb1aB8SaklsfGaSVGY+G/bnx6C85O+xTmrYAxolm8NPKvfuySSkd3Fv/N1BXnN
 yIC0NtICF5O3oUErG5Mf3E1WX+/3iVB70l8KCb4xk5bgj3Un5mGZ0wJHmEHzisF6z/BcLai7PWD
 mQXEE61976LFXyiSIWi1LUEM+2au2S8VY2LZ4RRfTq9a6ygFo0Ubnv2ZssRFNeFN5MMrt01CExY
 Ce266SARamyLFwlDSGg==
X-Proofpoint-GUID: K5hXVVNkGD5Fh8GtyAOCh8pWv8F1jYzF
X-Proofpoint-ORIG-GUID: K5hXVVNkGD5Fh8GtyAOCh8pWv8F1jYzF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
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

compl_auth_verify() compared the generated and received MAC with
memcmp(), which returns early on the first differing byte and leaks
the number of matching leading bytes through timing.

Use rte_memeq_timingsafe() for the verify comparison.

Bugzilla ID: 1773

Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
---
 drivers/common/cpt/cpt_ucode.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/common/cpt/cpt_ucode.h b/drivers/common/cpt/cpt_ucode.h
index 636f93604e..a6ecbaf429 100644
--- a/drivers/common/cpt/cpt_ucode.h
+++ b/drivers/common/cpt/cpt_ucode.h
@@ -3354,10 +3354,10 @@ compl_auth_verify(struct rte_crypto_op *op,
 		return;
 	}
 
-	if (memcmp(mac, gen_mac, mac_len))
-		op->status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
-	else
+	if (rte_memeq_timingsafe(mac, gen_mac, mac_len))
 		op->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
+	else
+		op->status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 }
 
 static __rte_always_inline void
-- 
2.48.1

