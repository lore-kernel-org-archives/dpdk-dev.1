Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499CDC5B572
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 05:29:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 117AE40294;
	Mon, 17 Aug 2026 07:29:39 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1A37D40275
 for <dev@dpdk.org>; Mon, 17 Aug 2026 07:29:37 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GNgGSQ876231; Sun, 16 Aug 2026 22:29:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=S
 jQC0ZLaqCEPs2O3x9MvgRDM4WfHiB1RbJyL6Wcj/2Y=; b=Yxhsmwopdtmz263T2
 SJ5HnrV8yCEJXTR4wPMhXvxLVBeQ1vX4LdNymKOymCRYigafipx/0sBrLNYxu4V3
 90uYXPs2ky0CuaGYQ/Am0RwlExXKCi9j6lo4qEvi3AQMzdjqWLTWF6HFKRQCncqT
 VOtrW6fig43e0dCZ9GMt4A65a0xpcntaPA/d+oc4+adiNsYdsH/f4aTVnr5A/5Bs
 GDXxqQwVqUbUPQQ23hKnbQoQmiCMi1DrGGMjPzYg5iWY+948ORQLzLdylsxOHuZV
 N0Gvfy1azW4yi2jDN8GWGdN5ppJ+5oqrD2Cx6exGFRYW60wsJDuGSfjBM0y1LcPB
 i5I7Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g36v39j9p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 16 Aug 2026 22:29:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 16 Aug 2026 22:29:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 16 Aug 2026 22:29:35 -0700
Received: from hyd11149.marvell.com (unknown [10.29.44.105])
 by maili.marvell.com (Postfix) with ESMTP id EE56D3F7040;
 Sun, 16 Aug 2026 22:29:32 -0700 (PDT)
From: Rupesh Chiluka <rchiluka@marvell.com>
To: <rchiluka@marvell.com>
CC: <dev@dpdk.org>, <gakhil@marvell.com>, <ktejasree@marvell.com>,
 <jerinj@marvell.com>, <stephen@networkplumber.org>, Anoob Joseph
 <anoobj@marvell.com>
Subject: [PATCH v2] common/cpt: use timing-safe digest comparison
Date: Mon, 17 Aug 2026 10:59:30 +0530
Message-ID: <a6599af7606f89822590df4285edec38bb86b865.1786943875.git.rchiluka@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <89e98b3ccc1ad93ed67fb5750c88df94f0c1ecf7.1785737875.git.rchiluka@marvell.com>
References: <89e98b3ccc1ad93ed67fb5750c88df94f0c1ecf7.1785737875.git.rchiluka@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAzOCBTYWx0ZWRfX7rPdx7uTpZxt
 GSoTl1ux3l3uHUR6VN0qjZOmRpuV5a2wFDZPinI2xrShy/1inN6T0/Im658ISOxG2HUHluGJNaz
 9O8REXejHriXMY1UzCWRhSBI0h0KjBc=
X-Proofpoint-ORIG-GUID: DrgKRL0Y7j_pfgvu6qPdZBF6x-4zvLUN
X-Authority-Analysis: v=2.4 cv=MatcfZ/f c=1 sm=1 tr=0 ts=6a829c41 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=cY9KfOWxWkrY88BNaiwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: DrgKRL0Y7j_pfgvu6qPdZBF6x-4zvLUN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAzOCBTYWx0ZWRfX6txHY/e6S3hC
 4wSiUkKdhrd07tAgnG0zGv534V+zc/jfvr4dML0AFd9fX+xTLTEry3kJ72uc36aRVCljpXaMzZR
 LpuTUzGgQWdEpQWKmMAM2zyjcch4fo+eVMmbM89PY8tdIURzdaaqdH0SXw8haQCIUgBbi3sYHkG
 jybCOILQsLQ0JYCmoVSeIpVDsm1+wDV8F7O/Ys1gNNku8bG7ScjzgQEk5Ko5Rsq1FqkFYSlWmug
 U5+vjzpBYehiWzdiSFJll/rI4phriVLApYaAtCHo6Y2941FeGGzDbeJQcZOeT8fepS0ue24TJMQ
 upZlhmOpOonHzn27Vu6M0Y43Kmins4kq5fAotCeuYMLNyh/EcFnrFOoMJU/P86zH2kiX4/PqQw7
 CyAP2qpLwkHikjWLaOFQCDsZyjOaUtqz5ezPccL6u0mI6QDtnsTXVLd2aPpIMK2pvEKTZvyPA74
 XpC7dWg1d9gl+tsRnhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
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
v2:
  - dropped salt and MAC address patches (comparisons operate on
    non-secret data; timing-safe compare unnecessary)

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

