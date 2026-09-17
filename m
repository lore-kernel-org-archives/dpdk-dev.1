Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6A9C982CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:15:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A5F8427E9;
	Thu, 17 Sep 2026 09:14:57 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 86769427A5;
 Thu, 17 Sep 2026 09:14:54 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H61XqH4005243; Thu, 17 Sep 2026 00:14:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=y
 kz7IvSBq5AvvOsRyE6Z4Y4XRF9JQMhXLtMxZJGoOPk=; b=L/fSIAFpR9OSJRU+3
 ZsF2Mi8s4LNBPHlM2Xf2WR/PENLzi0FkmEOcQGi85uOQD6k+dDMkCDjivL9Nu6vO
 ZRDYkqxVrcgLxnzoGMgglyroMY4PjuoIpJzHDjf2sQEHAejsNkYVkVZPke1vlYrd
 wAMAzpR+a2BpaMsFiGc1OwgT1sOMkqe0tTPucwxuDbFb731G7seZZRiKNgCpc7UL
 3c6Tl4jmWhDYtrcsmZmGsuk90WK4jyFUXJttUosSqErZkfXEMq/lYna/WjPJQ+NE
 vScX8c+g5xBsZguHRcdDhO3zlRuuRjG3LE6kSfFRKtH9wj3F4un49jyL71Guh9RY
 ZWgdw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gr7tvs2qk-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 00:14:53 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Sep 2026 00:14:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 17 Sep 2026 00:14:52 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 71BCC5C68E1;
 Thu, 17 Sep 2026 00:14:48 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Rahul Bhansali
 <rbhansali@marvell.com>
CC: <jerinj@marvell.com>, Alok Mishra <almishra@marvell.com>, <stable@dpdk.org>
Subject: [PATCH 11/14] common/cnxk: fix CPT CQ base address calculation
Date: Thu, 17 Sep 2026 12:40:13 +0530
Message-ID: <20260917071016.2366467-11-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917071016.2366467-1-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX4HLFicr9mbaX
 SYxWL6LN/Inzw73TUkUQVgr+nobTm47LB7lZMqxyZWDycLTfm0TX6l8BbkDbIQuvcMiiVB/ofXR
 2WCjmNAK2h+JygxSueoeotgo4T2wP9fkdtoJN0kiBQuhOAjbD2BlQyXN0Ux1Pozsm52b/jt03Ts
 qICmvs/wvJe4cC1YTWKx5hPloBY/PK898j6teVspRSA/P0qpRiuS8sr42yP5JsNBJ4+RATCr9yV
 JCqMRmkm90lV49NdFs28FSI/TIr6cb10v+RHBE8aShFA0YOb1YXHpJiipooDRQH9PNJSMKBqEYY
 hqzAVg4yYEksYDgYYi8BWDUo2GV4iDk+rSv/2G1jaSbg8pwHs9W9Z3e4an9zlAHRCPkf1v9W3g7
 cLBfQ1VuYA3F+mSqM9lfcFNzqC+65L2LbzsXssCbmJDmN/GHzGEIgRhOnX25kQBQFAIoLsyOwAR
 n8rxumy4O/aYEKfDctA==
X-Authority-Analysis: v=2.4 cv=M5fYuCws c=1 sm=1 tr=0 ts=6aab936d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=7iHoW4ZpYgh0hXGdV4IA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: kyyzHOP8vjMQK6PfR1-alq3DMYt8OMF_
X-Proofpoint-GUID: kyyzHOP8vjMQK6PfR1-alq3DMYt8OMF_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX+HyJjeSzCF4d
 hB6Nxmr6EwMGCqI/FNZuJ5Jz6aHE/7MxxLq5+uImyqmoC7UUTQ6217o8/ccMSO45O2EOKGetmHh
 FCExDn7XEMRE+zVuSUaivQpsBhhRWko=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
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

From: Alok Mishra <almishra@marvell.com>

In nix_inl_cpt_cq_cb(), the CPT CQ base address is reconstructed by
left-shifting CPT_LF_CQ_BASE.s.addr by 7 bits. Since s.addr is a 46-bit
field, the shift operation truncates the result to 46 bits, discarding
any higher address bits.

This produces an incorrect CQ base address for higher virtual
addresses, causing invalid memory access.

Fixed by casting s.addr to uint64_t before shifting, ensuring the full
64-bit address is preserved.

Fixes: 63b16e267106 ("common/cnxk: fix CPT CQ roll over handling")
Cc: stable@dpdk.org

Signed-off-by: Alok Mishra <almishra@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl_dev_irq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix_inl_dev_irq.c b/drivers/common/cnxk/roc_nix_inl_dev_irq.c
index dcf77a29a5..977b5e05e2 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev_irq.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev_irq.c
@@ -103,7 +103,8 @@ nix_inl_cpt_cq_cb(struct roc_cpt_lf *lf)
 	}
 
 	for (i = 0; i < count; i++) {
-		cq_s = (struct cpt_cq_s *)(uintptr_t)(((cq_base.s.addr << 7)) + (head << 5));
+		cq_s = (struct cpt_cq_s *)(uintptr_t)((((uint64_t)cq_base.s.addr << 7)) +
+						      (head << 5));
 
 		if (cq_s->w0.s.uc_compcode && cq_s->w0.s.compcode) {
 			switch (cq_s->w2.s.fmt & fmt_msk) {
-- 
2.34.1

