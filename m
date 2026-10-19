Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468A6CCF2DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:09:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 850E840A75;
	Mon, 19 Oct 2026 15:08:44 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7CED74067B
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:08:43 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OLo2110515 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=6
 63y0RgoaAK73vhH14QWxg8TtYpxsmIPqjDuGX4d1Xc=; b=O9iwK4U8quE8N5fIp
 3uS2J0yKwRjhHAzSbEEM7A9Su7COGcFTpyoCC4MUAtk17+hx3sMMiIGEBz3kjkk5
 kE1wie4JoMn8Ai42dvZP3PuwOey4d4ZDtCN2hYKBCOLtBdhSR13rXaFlK8MKoydD
 E31PzpudTxAXHgcmuL4P6f5jaaThmnFhRCx5Ke7OrXh1C3INpMDjdBz7hCWG+GQU
 JDvkHmT9ag+tvJsXvfpYd0jNBNnpltv70Bp3GyYzyO5kf/glx8GqS0yBP1um5OfR
 //FM1BQPg1X44bQcegyrglpdwrjHvOMhd0u8zWE4TdNqAv/t2/NnWUi3wDZ8Yctf
 8rpBQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hc8hh4yr9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:42 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 Oct 2026 06:08:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 19 Oct 2026 06:08:41 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.38.254])
 by maili.marvell.com (Postfix) with ESMTP id 38B763F704D;
 Mon, 19 Oct 2026 06:08:38 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Rupesh Chiluka <rchiluka@marvell.com>, Anoob Joseph <anoobj@marvell.com>, 
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, Ankur Dwivedi
 <adwivedi@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 14/16] crypto/cnxk: bound SG iovec index in mbuf walk
Date: Mon, 19 Oct 2026 18:37:55 +0530
Message-ID: <20261019130759.2181566-15-ktejasree@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019130759.2181566-1-ktejasree@marvell.com>
References: <20261019130759.2181566-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5j61Y_72RAu0PJ1geS_iubwAdGnLcguW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX9BSBnFyoTgzu
 tQd9aLLEXeYJYAWw22B9aResmXNorc/Kgz34TS/b99NO0OPCDbHvQ4C2gf1HMVsl/HpkTTx0Zni
 AH7wHycSjTKxbbws4yNZp3IR8UekUiKW7RAAt+lzzgXvOrH3Qqm3noxBo3c36sPdfu+5gEvwUKn
 ii38Q/rVz3f6gn/JB+H8s/pWLGd0u1CkNYILoqPW57p6p30M7q1ESxLGjy/UrKT85bJ1DivoapP
 R+MU1VY13aaVbyxfGoGTtQcKe5/GItVmmrnQFEmNWWkuM6LXhXVg2H6JRkCEyZwn5Updfu2Cz0N
 0hRiXObFOfTl9wH5T/UfRzWTiLg1luKg3VxtsV9JLuNYcobLgghRSL4RmOb1J18NGdMZ0EetfkD
 t9QiZ20UPBRPEZArTEOWSqiDZGK/ifynRN2G+1Chhe/s0fstdDXwSuQz8aWUAKTla45D+tSuG5q
 HFib+eP/d5yjFbEMzKw==
X-Proofpoint-GUID: 5j61Y_72RAu0PJ1geS_iubwAdGnLcguW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfXwyKUBsJbVJFO
 LJHHJnqwgAyxQ8h5WeczJ+TuqiyKpMO5CizoWRDWZ4PKjOacfr8TBKrIYz45Ahz+vbF5NCymeBw
 k7K+Xp6zYlFz+VqeRWkDkRCi7TEpdA8=
X-Authority-Analysis: v=2.4 cv=LfupeTfi c=1 sm=1 tr=0 ts=6ad6165a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=KgKL6rwPNvPiic21Ch4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
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

From: Rupesh Chiluka <rchiluka@marvell.com>

prepare_iov_from_pkt() and prepare_iov_from_pkt_inplace() rely on
nb_segs to limit the number of segments written to the on-stack iovec.
Also check the index against ROC_MAX_SG_CNT inside the walk, so a chain
longer than nb_segs reports cannot overrun the buffer.

Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
---
 drivers/crypto/cnxk/cnxk_se.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/crypto/cnxk/cnxk_se.h b/drivers/crypto/cnxk/cnxk_se.h
index a3c3c3ce86..b93a2bfaf8 100644
--- a/drivers/crypto/cnxk/cnxk_se.h
+++ b/drivers/crypto/cnxk/cnxk_se.h
@@ -2720,6 +2720,11 @@ prepare_iov_from_pkt(struct rte_mbuf *pkt, struct roc_se_iov_ptr *iovec, uint32_
 		if (!seg_size)
 			break;
 
+		if (unlikely(index >= ROC_MAX_SG_CNT)) {
+			plt_dp_err("Number of segments exceeds max supported (%u)", ROC_MAX_SG_CNT);
+			return 1;
+		}
+
 		iovec->bufs[index].vaddr = seg_data;
 		iovec->bufs[index].size = seg_size;
 
@@ -2776,6 +2781,11 @@ prepare_iov_from_pkt_inplace(struct rte_mbuf *pkt,
 		if (!seg_size)
 			break;
 
+		if (unlikely(index >= ROC_MAX_SG_CNT)) {
+			plt_dp_err("Number of segments exceeds max supported (%u)", ROC_MAX_SG_CNT);
+			return 1;
+		}
+
 		iovec->bufs[index].vaddr = seg_data;
 		iovec->bufs[index].size = seg_size;
 
-- 
2.43.0

