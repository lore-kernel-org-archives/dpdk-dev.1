Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4AFC021B3
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 21:31:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CE5E40648;
	Thu, 20 Feb 2025 22:31:17 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3EA1E40395
 for <dev@dpdk.org>; Thu, 20 Feb 2025 22:31:14 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 86D51205A9E9; Thu, 20 Feb 2025 13:31:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86D51205A9E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740087073;
 bh=uhNsLjsm6REH06PIzbAStibCADxCqc6rMvdGz9R1y5o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=N4nGIT2DDmY+GxkBkFwXoCghu0htprA+keWTRaHmaC1Aqwnep8tteQTUhh9DImv3a
 Je6Ur1ZqoIUKfeM3S9s4Mvx+4c1is6SdaWv/bRNITcdVQbfa/1eZLp3G2T/JGPujll
 YE3rEz28ZH082OWGeDZNjqpeubzFsN/8c7zlnIjY=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v4 03/10] test-pmd: fix printf format string mismatch
Date: Thu, 20 Feb 2025 13:30:57 -0800
Message-Id: <1740087064-18680-4-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740087064-18680-1-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740087064-18680-1-git-send-email-andremue@linux.microsoft.com>
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

Compiling with MSVC results in warnings like the one below:

app/test-pmd/csumonly.c(1085): warning C4477: 'printf' : format string
    '%d' requires an argument of type 'int',
    but variadic argument 1 has type 'uint64_t'

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/csumonly.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
index d77a140641..5f273e60d7 100644
--- a/app/test-pmd/csumonly.c
+++ b/app/test-pmd/csumonly.c
@@ -1070,7 +1070,7 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
 				info.l2_len, rte_be_to_cpu_16(info.ethertype),
 				info.l3_len, info.l4_proto, info.l4_len, buf);
 			if (rx_ol_flags & RTE_MBUF_F_RX_LRO)
-				printf("rx: m->lro_segsz=%u\n", m->tso_segsz);
+				printf("rx: m->lro_segsz=%u\n", (unsigned int)m->tso_segsz);
 			if (info.is_tunnel == 1)
 				printf("rx: outer_l2_len=%d outer_ethertype=%x "
 					"outer_l3_len=%d\n", info.outer_l2_len,
@@ -1082,28 +1082,29 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
 					    RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
 					    RTE_ETH_TX_OFFLOAD_SCTP_CKSUM)) ||
 				info.tso_segsz != 0)
-				printf("tx: m->l2_len=%d m->l3_len=%d "
-					"m->l4_len=%d\n",
-					m->l2_len, m->l3_len, m->l4_len);
+				printf("tx: m->l2_len=%u m->l3_len=%u "
+					"m->l4_len=%u\n",
+					(unsigned int)m->l2_len, (unsigned int)m->l3_len,
+					(unsigned int)m->l4_len);
 			if (info.is_tunnel == 1) {
 				if ((tx_offloads &
 				    RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM) ||
 				    (tx_offloads &
 				    RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM) ||
 				    (tx_ol_flags & RTE_MBUF_F_TX_OUTER_IPV6))
-					printf("tx: m->outer_l2_len=%d "
-						"m->outer_l3_len=%d\n",
-						m->outer_l2_len,
-						m->outer_l3_len);
+					printf("tx: m->outer_l2_len=%u "
+						"m->outer_l3_len=%u\n",
+						(unsigned int)m->outer_l2_len,
+						(unsigned int)m->outer_l3_len);
 				if (info.tunnel_tso_segsz != 0 &&
 						(m->ol_flags & (RTE_MBUF_F_TX_TCP_SEG |
 							RTE_MBUF_F_TX_UDP_SEG)))
-					printf("tx: m->tso_segsz=%d\n",
-						m->tso_segsz);
+					printf("tx: m->tso_segsz=%u\n",
+						(unsigned int)m->tso_segsz);
 			} else if (info.tso_segsz != 0 &&
 					(m->ol_flags & (RTE_MBUF_F_TX_TCP_SEG |
 						RTE_MBUF_F_TX_UDP_SEG)))
-				printf("tx: m->tso_segsz=%d\n", m->tso_segsz);
+				printf("tx: m->tso_segsz=%u\n", (unsigned int)m->tso_segsz);
 			rte_get_tx_ol_flag_list(m->ol_flags, buf, sizeof(buf));
 			printf("tx: flags=%s", buf);
 			printf("\n");
-- 
2.48.1.vfs.0.0

