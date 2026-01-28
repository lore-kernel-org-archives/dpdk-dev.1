Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45047D3567F
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 06:05:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95A24402E5;
	Wed, 28 Jan 2026 07:05:19 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5E542402C1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 07:05:17 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60RGPxke1390280 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:05:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
 dU2CoDsKSLo5p9VAwGZb6FEf4z3B6itAv00M5xJ4tY=; b=JL4f8qyrFNoOyMss7
 rGmar05DIbSO22BRJpLFQ/1KnjPJe6/VkGZevK1J9CNf1XYxK/FRBNU6cB+0pLXP
 BptPfzAgic5JWghydkZvK0sGdh6b+0EF72Xez+7ZsdajaqsIoEOfFnTDFTRO5Agy
 /wp3tEGHeg2n5ERecO8kDb2ULKMzOdi+bVP15VKFSF9dqKrQ5y87sqNbOAR01jo7
 9PY68NShmnS/AUSitZDG0UrHou5FF94dRmdQ1FOw25h91kOW2Ykr3pANSlGfPJn1
 YS9X33tFlVu1G9e3fZVOKAXwTa/geR2JfSQjN6xwnAkNbh0AZQRYj5gR8qJQNyuP
 OvvHw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bx0qsws60-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:05:16 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 22:05:04 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 22:05:04 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 30E7E3F706F;
 Tue, 27 Jan 2026 22:04:45 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>
Subject: [PATCH 15/18] net/cnxk: enable PDB in IPsec outbound path
Date: Wed, 28 Jan 2026 11:33:13 +0530
Message-ID: <20260128060316.3967610-15-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128060316.3967610-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA0NiBTYWx0ZWRfX3Ovc6MwsEKR9
 jQVk1K/ugonzf3tcn8tFg11OxyVAFAEiR9skHYlb1vM2zDzZZqbrwyYIOPaqFpLhRPDBQuU5K8Z
 MYy9u3MXsly8kn6KdTqJqLvGAaw4I3zuhSIiy/CqMkGiiKM09Gop4ZseDO4W71llgrO2WU5F31d
 iLNZjYdkGFbaK/FqH6NyUpCok8SQmXYMLmYIWXY3T/bCA6wnGKKhpEZf6IQ0SyLulQOjEHlTrzt
 xVm3+U0iawQK7masAuAovO2E7qxqVnN9bRGns7CSYIRkMLaA0OL04Ii63vCFjrXhOTJw4gDrHKY
 uPwSCIjcuApPT4asy7BiGjNgbNzf9xvwKKqwcoqSuOHoBU5g+eFYJ9yeBDyOxC3ILg4TBNQiCax
 f8Z9Wo8WyY2NtCxuSox3sWfyQOqgIQE9NtAhGv6766ZCnDk9P0sEXdOLicpx7GwQBhMREE4RaA4
 B1zygf2IrT2mGNJTiWg==
X-Authority-Analysis: v=2.4 cv=P9E3RyAu c=1 sm=1 tr=0 ts=6979a71c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=0k7kYyM8wT41UG9DH_wA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 5sOFhWT6YAqi0JyOh2cWTXFjEoQ-r2YC
X-Proofpoint-GUID: 5sOFhWT6YAqi0JyOh2cWTXFjEoQ-r2YC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
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

From: Nithin Dabilpuram <ndabilpuram@marvell.com>

Enabled PDB in IPsec outbound datapath.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/net/cnxk/cn20k_tx.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/cnxk/cn20k_tx.h b/drivers/net/cnxk/cn20k_tx.h
index 9e48744831..8e64d2e352 100644
--- a/drivers/net/cnxk/cn20k_tx.h
+++ b/drivers/net/cnxk/cn20k_tx.h
@@ -520,6 +520,7 @@ cn20k_nix_prep_sec_vec(struct rte_mbuf *m, uint64x2_t *cmd0, uint64x2_t *cmd1,
 		nixtx += 16;
 
 		w0 |= cn20k_nix_tx_ext_subs(flags) + 1ULL;
+		w0 |= sess_priv.chksum ? BIT_ULL(63) : BIT_ULL(62);
 		dptr += l2_len;
 		ucode_cmd[1] = dptr;
 		*cmd1 = vsetq_lane_u16(pkt_len + dlen_adj, *cmd1, 0);
@@ -660,6 +661,7 @@ cn20k_nix_prep_sec(struct rte_mbuf *m, uint64_t *cmd, uintptr_t *nixtx_addr, uin
 		nixtx += 16;
 
 		w0 |= cn20k_nix_tx_ext_subs(flags) + 1ULL;
+		w0 |= sess_priv.chksum ? BIT_ULL(63) : BIT_ULL(62);
 		dptr += l2_len;
 		ucode_cmd[1] = dptr;
 		sg->seg1_size = pkt_len + dlen_adj;
-- 
2.34.1

