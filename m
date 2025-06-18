Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556D9C71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 08:30:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DF92427BD;
	Wed, 18 Jun 2025 10:30:15 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id AA077427AC
 for <dev@dpdk.org>; Wed, 18 Jun 2025 10:30:13 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HNXgTh023489;
 Wed, 18 Jun 2025 01:30:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=H
 WKoW9oZy+4S4pDpi043LJYDPERZm2s5El9lb8s2F3Y=; b=Ce4YUefGATAQjR1zC
 v/TscF0m/d99JT5whX7H7R+wpO49oGkw62AuNoxRRKNpKdX3pKFI5V6z+A4+yxxu
 0Fbs015AMSS6kTra/wq61wNZYzF1yi39b4Q/Gi3KBKVABxuf9YQ0L3AJM3cdmcrb
 65L8t+O7VLHWFyuiMaVrJ1J0P50d2IVUPKzc2KkIeJvb6PE5wU1kGYyzwAIogJm0
 NapKP0WidOl6vti/WOhAD3QNiWF7+Tqij8qVQxywqJdp0swpfYstyxflvf50RrCh
 VSDpW4WZ7zdgwkwPA8A6B/Ge94SG9JXT8LzeqzGHtKYC9QEKODsoHMnm16JZt5E1
 1BG8A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47bj4xrvmv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 01:30:12 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Jun 2025 01:30:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 18 Jun 2025 01:30:12 -0700
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id 2B70D3F7043;
 Wed, 18 Jun 2025 01:30:08 -0700 (PDT)
From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>,
 Volodymyr Fialko <vfialko@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <ndabilpuram@marvell.com>, "Rakesh
 Kudurumalla" <rkudurumalla@marvell.com>
Subject: [PATCH v2 1/1] examples/ipsec-secgw: resolve segfault for IPsec
 packets
Date: Wed, 18 Jun 2025 14:00:06 +0530
Message-ID: <20250618083006.1679656-1-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250407072155.1255817-1-rkudurumalla@marvell.com>
References: <20250407072155.1255817-1-rkudurumalla@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ULrdHDfy c=1 sm=1 tr=0 ts=68527914 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=5tCQYSj4js87i-xCb6kA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA3MyBTYWx0ZWRfXzVnpgx59QV5n
 jDG0XkoACPPdD88IIBhzp3oULzJF6vl4Qm6n7AQ4Ad3Qko1ftuEilsupb/KKMUNtHiWNA2zV+8p
 KMmvXRHdzXnFLKJsqrWCD5sk2Vy3FhsmsQiaJ7OkocG1oZJesooFefmUhraNOpE6ibyqsTdGgBB
 /ISn/NhhCt8gQlTD6w4hrIJsrJ5VTo8ISWCFJMbyZnpgZoGXk0Kwe0PPzG422NL6XGOsmEEJ7JT
 4Dov30dow9RSG1JsZ5xHaUFiiaia/MnOX02UbxTZoa2WqYn5JYgPgVRDT39ECBISD0QDmdXxPVP
 58v5ZOqqvHPe5Oyu+w2N3bdlYo9SxEDSHAkUaAhjlYVi/xqgFyzoP245dtjShNMXgHWSMHBB54y
 z5UB0uISUPJQI7Sp8v7cxfvx6e1MHBgxELrrwBuQNQkJG9zkbSTw5IhZpG2HhXLD5b9m43TX
X-Proofpoint-GUID: y42SHskFY0wGLVUxyjtiWuyjUFnvARqX
X-Proofpoint-ORIG-GUID: y42SHskFY0wGLVUxyjtiWuyjUFnvARqX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_03,2025-06-13_01,2025-03-28_01
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

launching ipsec-segw application in event vector mode
after traffic has started results in segfault because
we are receiving few IPSEC packet and application is trying
to decrypt IPSEC packets using lookaside protocol.
This contradicts inline event mode.This patch fixes the same
by freeing IPSEC packets and processing only plain packets.

Fixes: 1d5078c6cf19 ("examples/ipsec-secgw: support event vector in lookaside mode")

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
V2: Add fixes tag
 examples/ipsec-secgw/ipsec_worker.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/examples/ipsec-secgw/ipsec_worker.c b/examples/ipsec-secgw/ipsec_worker.c
index e0690fc8d9..04609964cd 100644
--- a/examples/ipsec-secgw/ipsec_worker.c
+++ b/examples/ipsec-secgw/ipsec_worker.c
@@ -700,6 +700,9 @@ ipsec_ev_inbound_route_pkts(struct rte_event_vector *vec,
 	struct rte_ipsec_session *sess;
 	struct rte_mbuf *pkt;
 	struct ipsec_sa *sa;
+	uint8_t mask = (1UL << RTE_SECURITY_ACTION_TYPE_INLINE_CRYPTO) |
+		       (1UL << RTE_SECURITY_ACTION_TYPE_INLINE_PROTOCOL);
+
 
 	j = ipsec_ev_route_ip_pkts(vec, rt, t);
 
@@ -707,7 +710,7 @@ ipsec_ev_inbound_route_pkts(struct rte_event_vector *vec,
 	for (i = 0; i < t->ipsec.num; i++) {
 		pkt = t->ipsec.pkts[i];
 		sa = ipsec_mask_saptr(t->ipsec.saptr[i]);
-		if (unlikely(sa == NULL)) {
+		if (unlikely(sa == NULL) || ((1UL << sa->sessions[0].type) & mask)) {
 			free_pkts(&pkt, 1);
 			continue;
 		}
-- 
2.25.1

