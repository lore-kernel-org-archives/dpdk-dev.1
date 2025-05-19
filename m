Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E30C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 May 2025 16:07:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 141474065D;
	Mon, 19 May 2025 18:07:49 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 564AA402EB
 for <dev@dpdk.org>; Mon, 19 May 2025 18:07:47 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54INoWj5011154;
 Mon, 19 May 2025 09:07:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=L
 jsEP3DWv4Uu2dWMvJoiAOHxtzniPcZZSAZs0cYM4qg=; b=h0n9+9eB+hPenHRcZ
 o1BNcBgMOWyD6CKHBYK2XTT5qiSxsQY80rXqx7UzulJ8LV2pB3CbhFjN8b/BydpE
 Txyvcy3TaQcKk7f46MNBhpIANxFu+SM+Q3HYEo85nyUP+9DRwPv0jRtn9KtdLol7
 6s3mBT9HMepqKevhXLRfgc9etD+xdw8D/Tb1dgU5n2dsysKk+WveBOZVscSnZgjJ
 AP2MBzoPBjAfEcL5f5vSRsOmAqm0FffL/sbnrsZaV8rjBv/Aur8lXPLjhEBWRiWq
 qDdlhhw8sFns/gyhrWfzzxHojkiyV8JziKiFR4cUY47OSqS8gKzWSH6tvP0IweNE
 ePL8A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46qb79aekb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 May 2025 09:07:46 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 19 May 2025 09:07:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 19 May 2025 09:07:30 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 0DF613F7080;
 Mon, 19 May 2025 09:07:28 -0700 (PDT)
From: <skori@marvell.com>
To: Aman Singh <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>, Sunil Kumar Kori <skori@marvell.com>
Subject: [PATCH 2/2] app/testpmd: clear stale internal len information
Date: Mon, 19 May 2025 21:36:56 +0530
Message-ID: <20250519160711.4024414-2-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519160711.4024414-1-skori@marvell.com>
References: <20250519160711.4024414-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: qCrBS8fz6_sBNwv5X-B-8wnlmg4Ctj6z
X-Proofpoint-ORIG-GUID: qCrBS8fz6_sBNwv5X-B-8wnlmg4Ctj6z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE1MCBTYWx0ZWRfX1VUyI1c9BVcD
 hFsvBNzTqAy0X6f6iq1/uNKk0NWi7ojdGvW96iDoUgWGgt37G/BlHIGZC3PPqG3lojDo1fo8Tq8
 3U5exMouStAjp4SsYFeUG92j3H+EifnupazPiledPht1r77o5ZB40EsBYgdmaYi5vs+2gcMPDyo
 r8pOmDRUFz6GBMsLFbVjz58sDasic9kquVLQqPc6semWJIJA4+rS74xbG8Nvh6DJGASjxTQHZO9
 FpgbvgdUy5lD+sY6+1PKTtC4GhV8vg25sCUMe49jcvnDqwRgWB3H4UxfSziy2gOY/n/FKL8kGWg
 mYzVyjaW4EY3IM7CJe1aaDr9PzcBBpfjAM95v/MPlkju3y9sVZ6k8v8gXYMpE/3xmgDnARTroFF
 FOYBn5kL/TsdgdMDwbHU1iV+nrZL5ZtUfDWthFlzOhax58+K0KKzrv6Mzn1fHM5gZwC97m/n
X-Authority-Analysis: v=2.4 cv=YvQPR5YX c=1 sm=1 tr=0 ts=682b5752 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=pimKMqtlWAp7NM3-mj4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
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

From: Sunil Kumar Kori <skori@marvell.com>

hdr_lens is used to maintain header lengths after parsing packets.
When port receives different type of packets (say first is VXLAN
packet and second is GRE packet).

For first packet, L2/L3/L4 lengths are set for inner and outer header
alongwith tunnel_len.

Now for second packet, tunnel_len is added more than its size it
contains stale value which further leads to wrong header pointers.

Hence clearing stale information before processing each packet.

Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
---
 app/test-pmd/csumonly.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
index fa0002d321..4d02d622d6 100644
--- a/app/test-pmd/csumonly.c
+++ b/app/test-pmd/csumonly.c
@@ -670,6 +670,7 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
 			rte_prefetch0(rte_pktmbuf_mtod(pkts_burst[i + 1],
 						       void *));
 
+		memset(&hdr_lens, 0, sizeof(struct rte_net_hdr_lens));
 		m = pkts_burst[i];
 		info.is_tunnel = 0;
 		info.pkt_len = rte_pktmbuf_pkt_len(m);
-- 
2.43.0

