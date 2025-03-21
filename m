Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D74DC36000
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 10:04:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFA3140276;
	Fri, 21 Mar 2025 11:04:30 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 81AFF40269
 for <dev@dpdk.org>; Fri, 21 Mar 2025 11:04:28 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L8MNw2008680
 for <dev@dpdk.org>; Fri, 21 Mar 2025 03:04:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
 mGXu2BTH3RUOBPdV+PxBzXJqSBernXEKCsF7M4Viiw=; b=W6dW0Cqk9s+w34nc1
 adqTPM2zFJxETGcwfGDZLk9ucX1lruHcQbwk0CRfK2YHjnIDruOEQ62Dhj1ylCd0
 4QKV5Z0WE1GHt8ItgMTwtcmEEfYeg6OUGX+RVV7h9RoSxCaQ3GXrmlEt5D+6fqEQ
 uKFVg8Ndn8VSW+6YQeGYZT+D4TGKWfGuyxbbnkNgqxBtSX3wO0rY5WvbU15TeL5h
 mphuiTot1gs4LCiAt9bXdhyriZW519Mpxu3NmmxHmwI6lN0y6XVCoA+zU/pN3koB
 jXwwIyAFWYY8hEmt18Sq2pgB8j7o2MZiuAIVIurNnuF3ytNpYqK6PWhsa18RttiG
 WKGYg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45h4hx85gu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 21 Mar 2025 03:04:27 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 21 Mar 2025 03:04:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 21 Mar 2025 03:04:26 -0700
Received: from localhost.localdomain (unknown [10.28.36.158])
 by maili.marvell.com (Postfix) with ESMTP id C9DCA5E6871;
 Fri, 21 Mar 2025 03:04:23 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 3/3] net/cnxk: update IP header of reassembled packets
Date: Fri, 21 Mar 2025 15:33:43 +0530
Message-ID: <20250321100343.1081664-3-rbhansali@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250321100343.1081664-1-rbhansali@marvell.com>
References: <20250321100343.1081664-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=L58dQ/T8 c=1 sm=1 tr=0 ts=67dd39ab cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=FiRQd2fo16MxOy8W4mUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: EssbajDGb4zug8RgAGDrsipGxtBttu6C
X-Proofpoint-ORIG-GUID: EssbajDGb4zug8RgAGDrsipGxtBttu6C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_04,2025-03-20_01,2024-11-22_01
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

Updates IP header data of reassembled packets,
1) IPv4 length, MF bit and checksum correction
2) IPv6 length update and fragment extension header remove
Also, corrects data length of multisegment decrypted
packets.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/net/cnxk/cn20k_rx.h | 112 ++++++++++++++++++++++++++++++++----
 1 file changed, 102 insertions(+), 10 deletions(-)

diff --git a/drivers/net/cnxk/cn20k_rx.h b/drivers/net/cnxk/cn20k_rx.h
index b54d9df662..97a2b2b3d0 100644
--- a/drivers/net/cnxk/cn20k_rx.h
+++ b/drivers/net/cnxk/cn20k_rx.h
@@ -137,6 +137,71 @@ nix_get_mbuf_from_cqe(void *cq, const uint64_t data_off)
 	return (struct rte_mbuf *)(buff - data_off);
 }
 
+static __rte_always_inline void
+nix_sec_reass_first_frag_update(struct rte_mbuf *head, const rte_iova_t *iova_list, uintptr_t cpth,
+				uint64_t cq_w1, uint64_t cq_w5, uint16_t rlen)
+{
+	uint8_t *m_ipptr, *ipptr;
+	uint16_t tot_len;
+	uint32_t cksum;
+	uint8_t lc_ptr;
+	uint8_t lc_off;
+
+	lc_ptr = (cq_w5 >> 16) & 0xFF;
+	lc_off = lc_ptr - (cq_w5 & 0xFF);
+	ipptr = (uint8_t *)*iova_list + lc_off;
+	m_ipptr = (uint8_t *)cpth + lc_ptr;
+
+	/* Find the L3 header length and update inner pkt based on meta lc type */
+	if (((cq_w1 >> 40) & 0xF) == NPC_LT_LC_IP) {
+		const struct rte_ipv4_hdr *m_hdr = (const struct rte_ipv4_hdr *)m_ipptr;
+		struct rte_ipv4_hdr *ip_hdr = (struct rte_ipv4_hdr *)ipptr;
+
+		ip_hdr->fragment_offset = 0;
+		tot_len = rte_cpu_to_be_16(rlen);
+		ip_hdr->total_length = tot_len;
+		/* Perform incremental checksum based on meta pkt ip hdr */
+		cksum = m_hdr->hdr_checksum;
+		cksum += m_hdr->fragment_offset;
+		cksum += 0xFFFF;
+		cksum += m_hdr->total_length;
+		cksum += (uint16_t)(~tot_len);
+		cksum = (cksum & 0xFFFF) + ((cksum & 0xFFFF0000) >> 16);
+		ip_hdr->hdr_checksum = cksum;
+		return;
+	}
+
+	/* Assuming IPv6 packet update */
+	struct rte_ipv6_hdr *ipv6_hdr = (struct rte_ipv6_hdr *)ipptr;
+	size_t ext_len = sizeof(struct rte_ipv6_hdr);
+	uint8_t *nxt_hdr = (uint8_t *)ipv6_hdr;
+	uint8_t *nxt_proto = &ipv6_hdr->proto;
+	int nh = ipv6_hdr->proto;
+
+	tot_len = 0;
+	while (nh != -EINVAL) {
+		nxt_hdr += ext_len;
+		tot_len += ext_len;
+		if (nh == IPPROTO_FRAGMENT) {
+			*nxt_proto = *nxt_hdr;
+			break;
+		}
+		nh = rte_ipv6_get_next_ext(nxt_hdr, nh, &ext_len);
+		nxt_proto = nxt_hdr;
+	}
+
+	/* Remove the frag header by moving header 8 bytes forward */
+	ipv6_hdr->payload_len = rte_cpu_to_be_16(rlen - 8 - sizeof(struct rte_ipv6_hdr));
+
+	/* tot_len is sum of all IP header's length before fragment header */
+	rte_memcpy(rte_pktmbuf_mtod_offset(head, void *, 8), rte_pktmbuf_mtod(head, void *),
+		   lc_off + tot_len);
+
+	head->data_len -= 8;
+	head->data_off += 8;
+	head->pkt_len -= 8;
+}
+
 static __rte_always_inline uint64_t
 nix_sec_meta_to_mbuf_sc(uint64_t cq_w5, uint64_t cpth, const uint64_t sa_base,
 			struct rte_mbuf *mbuf, uint16_t *len, uint64_t *mbuf_init,
@@ -241,19 +306,22 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 {
 	const struct cpt_parse_hdr_s *hdr = (const struct cpt_parse_hdr_s *)cpth;
 	struct cn20k_inb_priv_data *inb_priv = NULL;
+	uint64_t fsz_w1 = 0, cq_w1, cq_w5, sg;
 	uint32_t offset = hdr->w2.ptr_offset;
 	const struct cpt_frag_info_s *finfo;
 	uint8_t num_frags = 0, nxt_frag = 0;
 	struct rte_mbuf *head, *last_mbuf;
-	uint64_t fsz_w1 = 0, cq_w1, sg;
+	uint16_t rlen = hdr->w3.rlen;
 	const rte_iova_t *iova_list;
 	uint8_t sg_cnt = 1, nb_segs;
 	uint16_t later_skip = 0;
 	bool reas_fail = false;
 	const rte_iova_t *eol;
+	uint16_t data_off = 0;
 	uint8_t ts_rx_off;
 	int dyn_off = 0;
-	uint32_t len;
+	uint16_t sg_len;
+	int64_t len;
 	uintptr_t p;
 
 	cq_w1 = *(const uint64_t *)rx;
@@ -266,10 +334,12 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 		if (!hdr->w4.gthr_size && ((flags & NIX_RX_REAS_F) || !hdr->w4.sctr_size))
 			return;
 
+		cq_w5 = *((const uint64_t *)rx + 4);
+		len = rlen + ((cq_w5 >> 16) & 0xFF) - (cq_w5 & 0xFF);
 		num_frags = hdr->w0.num_frags;
 		sg_base = cpth + (offset ? (offset << 3) : 256);
 		finfo = (const struct cpt_frag_info_s *)sg_base;
-		sg_base += num_frags ? (num_frags >> 2 ? 32 : 16) : 0;
+		sg_base += num_frags ? (num_frags > 4 ? 32 : 16) : 0;
 		sg = *(uint64_t *)sg_base;
 		nb_segs = (sg >> 48) & 0x3;
 		iova_list = (rte_iova_t *)(sg_base);
@@ -279,9 +349,8 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 		if ((flags & NIX_RX_REAS_F) && num_frags) {
 			void *inb_sa;
 
-			num_frags = hdr->w0.num_frags;
-			inb_sa = roc_nix_inl_ot_ipsec_inb_sa(sa_base, hdr->w0.cookie);
-			inb_priv = roc_nix_inl_ot_ipsec_inb_sa_sw_rsvd(inb_sa);
+			inb_sa = roc_nix_inl_ow_ipsec_inb_sa(sa_base, hdr->w0.cookie);
+			inb_priv = roc_nix_inl_ow_ipsec_inb_sa_sw_rsvd(inb_sa);
 			dyn_off = inb_priv->reass_dynfield_off;
 			num_frags -= 1;
 
@@ -300,16 +369,24 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 		if (nb_segs == 1)
 			return;
 
+		len = rx->pkt_lenm1 + 1;
+
 		/* Skip SG_S and first IOVA */
 		eol = ((const rte_iova_t *)(rx + 1) + ((rx->desc_sizem1 + 1) << 1));
 		iova_list = ((const rte_iova_t *)(rx + 1)) + 2;
 	}
 
 	/* Update data len as per the segment size */
-	mbuf->data_len = sg & 0xFFFF;
+	sg_len = sg & 0xFFFF;
+	mbuf->data_len = sg_len;
 	mbuf->nb_segs = nb_segs;
 	head = mbuf;
 
+	/* Update IP header */
+	if ((flags & NIX_RX_REAS_F) && num_frags && !reas_fail)
+		nix_sec_reass_first_frag_update(mbuf, iova_list - 1, cpth, cq_w1, cq_w5, rlen);
+
+	len -= sg_len;
 	sg = sg >> 16;
 	nb_segs--;
 
@@ -317,7 +394,7 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 
 	while (nb_segs) {
 		last_mbuf = mbuf;
-		if (flags & NIX_RX_REAS_F) {
+		if ((flags & NIX_RX_REAS_F) && num_frags) {
 			offset = (*iova_list) % (buf_sz & 0xFFFFFFFF);
 			mbuf->next = (struct rte_mbuf *)((*iova_list) - offset + (buf_sz >> 32));
 		} else {
@@ -344,6 +421,7 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 			len = fsz_w1 & 0xFFFF;
 			head->pkt_len = len - ts_rx_off;
 			head->nb_segs = sg_cnt;
+			data_off = rearm & 0xFFFF;
 			sg_cnt = 0;
 			nxt_frag = nxt_frag >> 1;
 			fsz_w1 = fsz_w1 >> 16;
@@ -351,14 +429,28 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 				fsz_w1 = finfo->w1.u64;
 		}
 
-		mbuf->data_len = (sg & 0xFFFF) - ts_rx_off;
+		if ((flags & NIX_RX_REAS_F) && num_frags && !reas_fail)
+			data_off = *iova_list - (uint64_t)mbuf->buf_addr;
+
+		sg_len = sg & 0xFFFF;
+		if ((flags & NIX_RX_OFFLOAD_SECURITY_F) && !(flags & NIX_RX_REAS_F)) {
+			/* Adjust last mbuf data length with negative offset for
+			 * security pkts if needed.
+			 */
+			len -= sg_len;
+			sg_len = (len > 0) ? sg_len : (sg_len + len);
+			len = (len > 0) ? len : 0;
+		}
+
+		mbuf->data_len = sg_len;
 		sg = sg >> 16;
 		p = (uintptr_t)&mbuf->rearm_data;
-		*(uint64_t *)p = rearm & ~0xFFFF;
+		*(uint64_t *)p = (rearm & ~0xFFFF) | data_off;
 
 		sg_cnt++;
 		nb_segs--;
 		iova_list++;
+		data_off = 0;
 
 		if (!nb_segs && (iova_list + 1 < eol)) {
 			sg = *(const uint64_t *)(iova_list);
-- 
2.25.1

