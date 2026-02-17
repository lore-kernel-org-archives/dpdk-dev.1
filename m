Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03209E83855
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 05:45:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F64D40616;
	Tue, 17 Feb 2026 06:45:03 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 11A8840616
 for <dev@dpdk.org>; Tue, 17 Feb 2026 06:45:01 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61H1hJda839342 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:45:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
 I/z4rswmwWIPjLh7Fq86JaFunQluGB8JAN84cgfj3E=; b=aXIJKfvG6o69mBFvG
 5rq5UTR6jMgWRZI5LZlfPMtXINkJNU/COYKS+MSKaoyDXbbiDHDy8j5rALeE+LKu
 lK56gthVi1W9tl2B1ryUblaVqi+XrM4vxuflq65POBVa6ZQDwnIYiTYxQd7fpnO+
 Zv2yn4O0023uPjpDqQrKkzxR+/A9y52Ual2jJU8+F/BSsiL8iq1Rif6AQaK0+NuQ
 YDkKFQepdMNywPRxzN8AZK+syUABNKPmNgOY/5OC3wi+fhdhS846zlVdmzdUo3fG
 3YoDPjkfu/qHm+eFPx4guJgl8H3/IrveMkR/hyWYfWpw5ZJ3xq1YDl4n+Y1DxCJi
 S7I1g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cccxf8d25-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:45:01 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Feb 2026 21:45:17 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 16 Feb 2026 21:45:16 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 805065B696D;
 Mon, 16 Feb 2026 21:44:57 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>
Subject: [PATCH v2 15/18] net/cnxk: enable PDB in IPsec outbound path
Date: Tue, 17 Feb 2026 11:13:42 +0530
Message-ID: <20260217054345.2759687-15-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217054345.2759687-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
 <20260217054345.2759687-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=cdbfb3DM c=1 sm=1 tr=0 ts=6994005d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8 a=0k7kYyM8wT41UG9DH_wA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0NSBTYWx0ZWRfX3wEDn17+GrxZ
 89O4lRJeXz5IHj/t02M9M8cNyJ0yG9kTtw1KYX3h0RVovfhxqPp7b6FuqvxKeJ2btiCVT4TzxFw
 97O1IiP42g+kNhY9/wcuQp4ZpgIbuBCdi/rEojwq6ZDNIVusVPYeDZWsBSuvXROogc5q5qV5dNG
 anGaoHoJXNWg9wFPxvzk+nuBwTAO8y0ySMUE+y49SvEAge0v9CTZD6IIw4T+1+WJ2QFgYRed/Pn
 ySxWCpqIamPnn4emHrYzV9QOinFZIROukTTEYOGEKigfJuWEGykehD53QFAleaYgCVDXVO/yAC4
 U8Ut1SUZy+2AyGZgABGtX+gLP+lPKMqv/asVXMprK88Qk0CL7p3bbJ1KxA/Q087Ri3CL2VSAIst
 Cp0yycPCq+9oX87Px4bC6AXTKprh3PJfdv85E4rvfr7KVDxXXFa58SvgA4hyeL+WByORu6GKTf4
 Iwexx7ieIYGvug4JWmQ==
X-Proofpoint-ORIG-GUID: FIzxiIUhMomhHRPK5q6aXt1xGgSVEfyM
X-Proofpoint-GUID: FIzxiIUhMomhHRPK5q6aXt1xGgSVEfyM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
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
Changes in v2: No change.

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

