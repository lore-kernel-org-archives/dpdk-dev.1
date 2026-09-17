Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D24C982CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:14:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5207427B3;
	Thu, 17 Sep 2026 09:14:43 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 22D10400D6
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:14:41 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60DAC2202685 for <dev@dpdk.org>; Thu, 17 Sep 2026 00:14:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=c
 965nmoeTDNR7P6TmQa2vQbgxtskl/Jkh5tXbQoZ5Ms=; b=XwpRKvVCRgn+KQwIE
 36v4Ul6rdZY1QgjGFof2nk5KPwTMFC9EItoDQSCJNI88aRBe2Kov3NJdv4rFjNRQ
 kmpbgqkqFqjizNv9Ne7QddSrQ99qEnq2fUBUlu/CJzkWQvo9S6GryDXfrIVHV6cO
 P0azaap8sd/+wrh/WMhT/cGQGhSggzdXQyEJEFVFoJmpPunt/G/29cvtXSeGVAit
 z3gINqIXE0YF9sA9Ku0GWYZUpb9g0c6DKriwaKMlbpblQZG8B9oPS0XMkKACclqU
 07dV1Zk9DXYKIGmeicsaIQexDmKaZCgMNBCU/mtd/Lz6iimKBtOLdIyAzZSlg2fq
 I50vg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gra5yge2n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 17 Sep 2026 00:14:41 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Sep 2026 00:14:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 17 Sep 2026 00:14:39 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 1133A5C68E3;
 Thu, 17 Sep 2026 00:14:35 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>,
 "Rahul Bhansali" <rbhansali@marvell.com>
Subject: [PATCH 08/14] net/cnxk: resolve mbuf from CPT CQ format in SSO work cb
Date: Thu, 17 Sep 2026 12:40:10 +0530
Message-ID: <20260917071016.2366467-8-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917071016.2366467-1-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX679OyHmqZnZU
 Suqdj4NLHV9OzPw4Tq06jiKAlKjppK6YO/NZxgyyxJ8HZaKdRVkxo5z6aloW3Kt1VQ/1V5sEpOK
 YhKvpewcvVjDZMx0cVZDoryYdIxYynI=
X-Proofpoint-GUID: XkcNvPgDB9lLzJIGlE11fY94y8yJEeBh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX314ziWJ5o6RC
 lhJo8UmP0rS8xdRynmGoDMGBPnNrNqYPC5Rov17ik2uOoYbTHLcVwrY3U7aJKEej83FYd3LXyqw
 3ET/NEAcBT/Mvrn4piAtLvSAUI2GPswDhtHEX99zxMSMDRmEvBfMgKrgMq1tc9oNL1hQ1F+W8x5
 82Hrsj0PFZuTCbk9v1qG49XtWREOFbmYQQ5Dji8ZqvyF6kRMGZQ4l2MHmnYAD/gX9avR6M9ZxZn
 k5V3BGNFYvubWzuwgvp0k+/3gIexIgLDiqVXg/btUzpTLM1XFJLQgnyjXpj5scIkE+c05DLFy5b
 SMJiRXxsgcC6+5wNnvnThMhkjUlmnQG00VlfcoZ6rfAR2rRO5TUgy2SFAhvB/IhvIvedbwrSpV0
 T3y3mSbYm8bXuxgqqzhYCustAfSwIsTgNaOzJx26ZkaViJhWF39Yg0QdS4iY9RgMWgem29huoXF
 2pzKHPEOJi14kDLnuog==
X-Proofpoint-ORIG-GUID: XkcNvPgDB9lLzJIGlE11fY94y8yJEeBh
X-Authority-Analysis: v=2.4 cv=TekDJhQh c=1 sm=1 tr=0 ts=6aab9361 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=WigpHXL46XyuNxDiFOIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
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

From: Rakesh Kudurumalla <rkudurumalla@marvell.com>

When handling NIX inline CPT CQ events (type < NIX_INL_SSO), derive the
mbuf from the completion queue word layout using fmt bits: WQE_PTR_CPTR
uses w1.esn; CPTR_WQE_PTR uses w3.comp_ptr shifted left by 3 for the byte
address. Pass the mbuf into cn20k_eth_sec_post_event instead of NULL.
Drop RTE_SET_USED(args) since args is consumed by post_event.

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/net/cnxk/cn20k_ethdev_sec.c | 44 +++++++++++++++++++----------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/net/cnxk/cn20k_ethdev_sec.c b/drivers/net/cnxk/cn20k_ethdev_sec.c
index 65f0235a46..b365426065 100644
--- a/drivers/net/cnxk/cn20k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn20k_ethdev_sec.c
@@ -438,7 +438,7 @@ cnxk_pktmbuf_free_no_cache(struct rte_mbuf *mbuf)
 	} while (mbuf != NULL);
 }
 
-static void
+static bool
 cn20k_eth_sec_post_event(struct rte_eth_dev *eth_dev, void *sa, enum nix_inl_event_type type,
 			 uint16_t uc_compcode, uint16_t compcode, struct rte_mbuf *mbuf)
 {
@@ -447,6 +447,7 @@ cn20k_eth_sec_post_event(struct rte_eth_dev *eth_dev, void *sa, enum nix_inl_eve
 	struct cn20k_outb_priv_data *outb_priv;
 	struct cn20k_inb_priv_data *inb_priv;
 	static uint64_t warn_cnt;
+	bool free_mbuf = false;
 	uint64_t life_unit;
 
 	memset(&desc, 0, sizeof(desc));
@@ -454,14 +455,15 @@ cn20k_eth_sec_post_event(struct rte_eth_dev *eth_dev, void *sa, enum nix_inl_eve
 
 	if (type == NIX_INL_INB_CPT_CQ) {
 		struct roc_ow_ipsec_inb_sa *inb_sa = (struct roc_ow_ipsec_inb_sa *)sa;
-		inb_priv = roc_nix_inl_ow_ipsec_inb_sa_sw_rsvd(sa);
-		desc.metadata = (uint64_t)inb_priv->userdata;
-		life_unit = inb_sa->w2.s.life_unit;
+		inb_priv = sa ? roc_nix_inl_ow_ipsec_inb_sa_sw_rsvd(sa) : NULL;
+		desc.metadata = inb_priv ? (uint64_t)inb_priv->userdata : 0;
+		life_unit = inb_sa ? inb_sa->w2.s.life_unit : 0;
 	} else {
 		struct roc_ow_ipsec_outb_sa *outb_sa = (struct roc_ow_ipsec_outb_sa *)sa;
 		outb_priv = roc_nix_inl_ow_ipsec_outb_sa_sw_rsvd(sa);
 		desc.metadata = (uint64_t)outb_priv->userdata;
 		life_unit = outb_sa->w2.s.life_unit;
+		free_mbuf = true;
 	}
 
 	if (mbuf)
@@ -483,6 +485,7 @@ cn20k_eth_sec_post_event(struct rte_eth_dev *eth_dev, void *sa, enum nix_inl_eve
 			desc.subtype = RTE_ETH_EVENT_IPSEC_SA_PKT_EXPIRY;
 		else
 			desc.subtype = RTE_ETH_EVENT_IPSEC_SA_BYTE_EXPIRY;
+		free_mbuf = false;
 		break;
 	case ROC_IE_OW_UCC_ERR_PKT_IP:
 		warn_cnt++;
@@ -503,7 +506,10 @@ cn20k_eth_sec_post_event(struct rte_eth_dev *eth_dev, void *sa, enum nix_inl_eve
 		break;
 	}
 
-	rte_eth_dev_callback_process(eth_dev, RTE_ETH_EVENT_IPSEC, &desc);
+	if (eth_dev)
+		rte_eth_dev_callback_process(eth_dev, RTE_ETH_EVENT_IPSEC, &desc);
+
+	return free_mbuf;
 }
 
 static const char *
@@ -532,13 +538,14 @@ cn20k_eth_sec_sso_work_cb(uint64_t *gw, void *args, enum nix_inl_event_type type
 	struct cn20k_sec_sess_priv sess_priv;
 	struct cn20k_outb_priv_data *outb_priv;
 	struct roc_ow_ipsec_outb_sa *outb_sa;
+	struct rte_eth_dev *eth_dev = NULL;
+	struct rte_mbuf *mbuf = NULL;
 	struct cpt_cn20k_res_s *res;
-	struct rte_eth_dev *eth_dev;
 	struct cnxk_eth_dev *dev;
 	uint16_t dlen_adj, rlen;
-	struct rte_mbuf *mbuf;
 	uintptr_t sa_base;
 	uintptr_t nixtx;
+	bool free_mbuf;
 	uint8_t port;
 
 	plt_nix_dbg("Received %s event", get_inl_event_type(type));
@@ -562,17 +569,19 @@ cn20k_eth_sec_sso_work_cb(uint64_t *gw, void *args, enum nix_inl_event_type type
 		if (type) {
 			struct cpt_cq_s *cqs = (struct cpt_cq_s *)cq_s;
 
-			if (type == NIX_INL_INB_CPT_CQ) {
+			if (type == NIX_INL_INB_CPT_CQ && cqs->w2.s.fmt != WQE_PTR_ANTI_REPLAY) {
 				struct cn20k_inb_priv_data *inb_priv;
 
-				inb_priv = roc_nix_inl_ow_ipsec_inb_sa_sw_rsvd(args);
-				if (inb_priv->eth_sec && inb_priv->eth_sec->eth_dev) {
+				inb_priv = args ? roc_nix_inl_ow_ipsec_inb_sa_sw_rsvd(args) : NULL;
+				if (inb_priv && inb_priv->eth_sec && inb_priv->eth_sec->eth_dev) {
 					eth_dev = inb_priv->eth_sec->eth_dev;
 				} else {
-					plt_err("Inbound CPT CQ event: no eth_dev in SA priv");
+					plt_nix_dbg("Inbound CPT CQ event: cc %x uc_cc %x fmt %x",
+						    cqs->w0.s.compcode, cqs->w0.s.uc_compcode,
+						    cqs->w2.s.fmt);
 					return;
 				}
-			} else {
+			} else if (type != NIX_INL_INB_CPT_CQ) {
 				if (port_id >= RTE_MAX_ETHPORTS) {
 					plt_err("CPT CQ event: invalid port_id %u", port_id);
 					return;
@@ -581,9 +590,14 @@ cn20k_eth_sec_sso_work_cb(uint64_t *gw, void *args, enum nix_inl_event_type type
 			}
 
 			if (type < NIX_INL_SSO) {
-				cn20k_eth_sec_post_event(eth_dev, args, type,
-							 (uint16_t)cqs->w0.s.uc_compcode,
-							 (uint16_t)cqs->w0.s.compcode, NULL);
+				mbuf = (struct rte_mbuf *)(uintptr_t)gw[1];
+
+				free_mbuf = cn20k_eth_sec_post_event(eth_dev, args,
+					    type, (uint16_t)cqs->w0.s.uc_compcode,
+					    (uint16_t)cqs->w0.s.compcode, mbuf);
+
+				if (free_mbuf)
+					cnxk_pktmbuf_free_no_cache(mbuf);
 				return;
 			}
 			if (type == NIX_INL_SOFT_EXPIRY_THRD) {
-- 
2.34.1

