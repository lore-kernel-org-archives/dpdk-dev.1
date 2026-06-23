Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4067CD98F0
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 04:27:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5ACA34003C;
	Tue, 23 Jun 2026 06:27:37 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6EA8C4003C
 for <dev@dpdk.org>; Tue, 23 Jun 2026 06:27:34 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N0fsq22831753; Mon, 22 Jun 2026 21:27:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=F
 gE5hPCD35cJt9LAspwTkoNANTvc5KDVizKhytWMmFk=; b=bPKSGjNKu59GW4t5b
 dequoxp6F8bosYkEVdOsjfISTNQgIL3td8Z0MpTMsZ3jwj5fR9KLRXqckE3T+1OB
 /vwEQEQYABr8q0Q+pgYWjaTmeKlnqXuM2IhDA+YjoVQY0/23vHV22T0yFmt4N6tS
 gFQLXGXUPz4vfKkx6FzMeQPIoAEOneu4K29qBrNLU+duCxZLJmGD0gyPLHVA5btK
 66tCziFEWmczYGwXBIPSCP0QbsAhHHBQvnNa2o9YUrEUWujMS2UHzEdF+zUCluxB
 xCqhks5BqGY7F4ZHNag5yMrwgB6OJRLaBGinx8vzSC2Mxr4aHo7odEHi4PnA+Nq3
 SkPRg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4exf48wnby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 21:27:33 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 22 Jun 2026 21:27:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 22 Jun 2026 21:27:33 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 387EE3F708D;
 Mon, 22 Jun 2026 21:27:30 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 3/3] test/crypto: add unit test for Rx inject multi seg
Date: Tue, 23 Jun 2026 09:57:23 +0530
Message-ID: <20260623042723.89226-4-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260623042723.89226-1-ktejasree@marvell.com>
References: <20260623042723.89226-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GEduWbjYrZE1WeWqDBr2u09bSEmJCZ3j
X-Proofpoint-GUID: GEduWbjYrZE1WeWqDBr2u09bSEmJCZ3j
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAzMiBTYWx0ZWRfX9uyA/VIjkONF
 opF7m3HQqswJespoPV8V7ZQ622SZEKDoaIlLLqoJTKHbPdiHmMNUxW8pItu3ZV6ojCKoN+OCdsc
 iiE9YS8BP1jdNWyz2mLuyzkxpUwyMOI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAzMiBTYWx0ZWRfX33bU/AhoaZo+
 1RZe5ljqixlVgN0Etr82680o/tqrQl1+yGyLZ0/KKtEgWmJxNc6cjXUW1pUMBLdjPWWW+4vRL4P
 NnR3wneoxbVu0d1Ss33M/RY7e+jAg6Kxr50xasPfkyfKzEEwWEc/96Y4JRoyYyT0KHfixzhXz9K
 /K9913J9XReTEzyfwfEAT20fqNHfuVLAvNgoIWnqjntUYBIr/n6+ZWgv/Ld4pFcBvt6hMiL0/Xm
 EnpMmw132mCn5lKEejonfJa75Zd0RoCdFay8EYsy4eMbOUa4b63gnFmE0loS37damaGtrxF1R54
 UzhAOTpqs3cJJyQhb2WYMgn7tH/OTCKV0zv6zuDg4EKuOuwH4bqYv0t46wHVqvSvQtmXINg77C2
 EGV65viWBNS5rQ+pAmvmPWWAMXtgn6xYPGr/gP57x8L5MizzRyrcJlDwav/np4ZdLKP/+npP9eN
 neUvbdBIf8Ags5gYYGA==
X-Authority-Analysis: v=2.4 cv=J9uaKgnS c=1 sm=1 tr=0 ts=6a3a0b35 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=Wr31DqYP4mucbMYCTD4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
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

From: Vidya Sagar Velumuri <vvelumuri@marvell.com>

Add unit test to verify the multi segment support in RX Inject

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 app/test/test_cryptodev.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index 884629ec8c..fd02107baf 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -1564,7 +1564,8 @@ ut_setup_security_rx_inject(void)
 	struct rte_eth_conf port_conf = {
 		.rxmode = {
 			.offloads = RTE_ETH_RX_OFFLOAD_CHECKSUM |
-				    RTE_ETH_RX_OFFLOAD_SECURITY,
+				    RTE_ETH_RX_OFFLOAD_SECURITY |
+					RTE_ETH_RX_OFFLOAD_SCATTER,
 		},
 		.txmode = {
 			.offloads = RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE,
@@ -10781,6 +10782,25 @@ test_ipsec_proto_known_vec_inb_rx_inject(const void *test_data)
 	return test_ipsec_proto_process(&td_inb, NULL, 1, false, &flags);
 }
 
+static int
+test_ipsec_proto_known_vec_inb_rx_inject_multi_seg(const void *test_data)
+{
+	const struct ipsec_test_data *td = test_data;
+	struct ipsec_test_flags flags;
+	struct ipsec_test_data td_inb;
+
+	memset(&flags, 0, sizeof(flags));
+	flags.rx_inject = true;
+	flags.nb_segs_in_mbuf = 4;
+
+	if (td->ipsec_xform.direction == RTE_SECURITY_IPSEC_SA_DIR_EGRESS)
+		test_ipsec_td_in_from_out(td, &td_inb);
+	else
+		memcpy(&td_inb, td, sizeof(td_inb));
+
+	return test_ipsec_proto_process(&td_inb, NULL, 1, false, &flags);
+}
+
 static int
 test_ipsec_proto_all(const struct ipsec_test_flags *flags)
 {
@@ -18389,6 +18409,11 @@ static struct unit_test_suite ipsec_proto_testsuite  = {
 			"Inbound known vector (ESP tunnel mode IPv4 AES-GCM 128) Rx inject",
 			ut_setup_security_rx_inject, ut_teardown_rx_inject,
 			test_ipsec_proto_known_vec_inb_rx_inject, &pkt_aes_128_gcm),
+		TEST_CASE_NAMED_WITH_DATA(
+			"Inbound known vector (ESP tunnel mode IPv4 AES-GCM 128) Rx inject multi seg",
+			ut_setup_security_rx_inject, ut_teardown_rx_inject,
+			test_ipsec_proto_known_vec_inb_rx_inject_multi_seg, &pkt_aes_128_gcm),
+
 		TEST_CASES_END() /**< NULL terminate unit test array */
 	}
 };
-- 
2.34.1

