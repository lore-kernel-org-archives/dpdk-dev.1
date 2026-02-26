Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D32BFCE078
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 13:18:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28ACC40608;
	Thu, 26 Feb 2026 14:18:18 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2BAE7402CE
 for <dev@dpdk.org>; Thu, 26 Feb 2026 14:18:16 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61Q71sP11363450 for <dev@dpdk.org>; Thu, 26 Feb 2026 05:18:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
 jYyKfybC7wY3j2a6Vat9kXANkKkRMkD6HFHHtgZu7I=; b=ZIFbxDSfLJA/iLvu0
 8nyzMPeZJjyGsmgP5ZpYqjic1m2fA2uxUhhrqcd1c5CtcqX7YH+IhcmNz/nhIVjQ
 YOIN+Dx8GkUieGzyBId5nFMke4PCCkCOYUfTUMGvczVsaCa0Hu/qzG/RKBDuLoZW
 7dBEWInFaxWjrCnvdW7zxpxJiucKtDHODbnuMp7jGrRQ+ff67SzdM2fH8ePkHW4y
 0bwUAuZQhFTFNrRNOriF+e7Akyv7CVT0O/n3GX8eTvFgm1/X5AiBV9DfdnUmUcpT
 4y23gRiOWuNcwmJnx+Zmmxg0d310WjCWH8nq75s7jIMc8PY2H5bZUlGnlg7M0rF7
 Cc4xQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4chqcyvesq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 26 Feb 2026 05:18:15 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Feb 2026 05:18:14 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 26 Feb 2026 05:18:14 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id C96263F70D8;
 Thu, 26 Feb 2026 05:18:11 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 2/8] net/cnxk: support IPsec Rx inject for cn20k
Date: Thu, 26 Feb 2026 18:47:09 +0530
Message-ID: <20260226131715.2851091-2-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226131715.2851091-1-rbhansali@marvell.com>
References: <20260219090847.3257753-1-rbhansali@marvell.com>
 <20260226131715.2851091-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _FWuLhEMeUYs4e5w7POC4ZcUxkotzmnl
X-Proofpoint-ORIG-GUID: _FWuLhEMeUYs4e5w7POC4ZcUxkotzmnl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDEyMCBTYWx0ZWRfX4g7WmfTRK8fr
 TAQlCkp9sFH/QVpC8OaC9y3NaVvyz735/GasGgbe1xMIYEzoCkEp22YWrigt//upxHe55Fg97vX
 8qIdOVXG1x+YaqtRvhrEp7Y921SsQYPGNuG1zXi2WZZIKFu/vNXeRCmqN1bi69qQp2PeTteWGBM
 qBuVvckAM/P5TeYvfLhCWy+paZyZVRRUMel3VchLlLyPcQGCKpe/ksgynW0Sp/ZU36UIMGcCLsp
 jqc8Yn5sMhBldulyk4ry04GqpO6gNFMETa4qiBhWJQ4EGLx5zjnTHs2AjleXZ5AM3TKIJ9kYEpf
 ZveeMJM4hZ+PcqMscXsb/Hv9z8HExfkBqRhwaYbOvXUaKWrQkbYqZrrc8dc5wzeDpnxllKgXuBW
 9NzdyS58pWh9zaF53ZIkqleWs3AMeIUCcXwQllDrmJ3tCzGPkVbYjM8mb1pw81siCljqBdbGzug
 kohYvAafzapDgcGb1aQ==
X-Authority-Analysis: v=2.4 cv=B/S0EetM c=1 sm=1 tr=0 ts=69a04817 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=ctBjVGk8KDStni5OKZAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-26_01,2025-10-01_01
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

Adds support of IPsec Rx inject handling for cn20k platform.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: fix release notes.

 doc/guides/rel_notes/release_26_03.rst |   1 +
 drivers/net/cnxk/cn20k_ethdev_sec.c    |  50 +++++++
 drivers/net/cnxk/cn20k_rx.h            | 174 +++++++++++++++++++++++++
 3 files changed, 225 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index b1f9b3c82b..62246881d1 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -81,6 +81,7 @@ New Features

   * Added out-of-place support for CN20K SoC.
   * Added plain packet reassembly support for CN20K SoC.
+  * Added IPsec Rx inject support for CN20K SoC.

 * **Updated ZTE zxdh ethernet driver.**

diff --git a/drivers/net/cnxk/cn20k_ethdev_sec.c b/drivers/net/cnxk/cn20k_ethdev_sec.c
index c6a51f99f5..e406f0e879 100644
--- a/drivers/net/cnxk/cn20k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn20k_ethdev_sec.c
@@ -1172,6 +1172,54 @@ eth_sec_caps_add(struct rte_security_capability eth_sec_caps[], uint32_t *idx,
 	*idx += nb_caps;
 }

+static uint16_t __rte_hot
+cn20k_eth_sec_inb_rx_inject(void *device, struct rte_mbuf **pkts,
+			    struct rte_security_session **sess, uint16_t nb_pkts)
+{
+	struct rte_eth_dev *eth_dev = (struct rte_eth_dev *)device;
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+
+	return cn20k_nix_inj_pkts(sess, &dev->inj_cfg, pkts, nb_pkts);
+}
+
+static int
+cn20k_eth_sec_rx_inject_config(void *device, uint16_t port_id, bool enable)
+{
+	struct rte_eth_dev *eth_dev = (struct rte_eth_dev *)device;
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	uint64_t channel, pf_func, inj_match_id = 0xFFFFUL;
+	struct cnxk_ethdev_inj_cfg *inj_cfg;
+	struct roc_nix *nix = &dev->nix;
+	struct roc_cpt_lf *inl_lf;
+	uint64_t sa_base;
+
+	if (!rte_eth_dev_is_valid_port(port_id))
+		return -EINVAL;
+
+	if (eth_dev->data->dev_started || !eth_dev->data->dev_configured)
+		return -EBUSY;
+
+	if (!roc_nix_inl_inb_rx_inject_enable(nix, dev->inb.inl_dev))
+		return -ENOTSUP;
+
+	roc_idev_nix_rx_inject_set(port_id, enable);
+
+	inl_lf = roc_nix_inl_inb_inj_lf_get(nix);
+	if (!inl_lf)
+		return -ENOTSUP;
+	sa_base = roc_nix_inl_inb_sa_base_get(nix, dev->inb.inl_dev);
+
+	inj_cfg = &dev->inj_cfg;
+	inj_cfg->sa_base = sa_base | eth_dev->data->port_id;
+	inj_cfg->io_addr = inl_lf->io_addr;
+	inj_cfg->lmt_base = nix->lmt_base;
+	channel = roc_nix_get_base_chan(nix);
+	pf_func = roc_idev_nix_inl_dev_pffunc_get();
+	inj_cfg->cmd_w0 = pf_func << 48 | inj_match_id << 32 | channel << 4;
+
+	return 0;
+}
+
 #define CPT_LMTST_BURST 32
 static uint16_t
 cn20k_inl_dev_submit(struct roc_nix_inl_dev_q *q, void *inst, uint16_t nb_inst)
@@ -1233,6 +1281,8 @@ cn20k_eth_sec_ops_override(void)
 	cnxk_eth_sec_ops.capabilities_get = cn20k_eth_sec_capabilities_get;
 	cnxk_eth_sec_ops.session_update = cn20k_eth_sec_session_update;
 	cnxk_eth_sec_ops.session_stats_get = cn20k_eth_sec_session_stats_get;
+	cnxk_eth_sec_ops.rx_inject_configure = cn20k_eth_sec_rx_inject_config;
+	cnxk_eth_sec_ops.inb_pkt_rx_inject = cn20k_eth_sec_inb_rx_inject;

 	/* Update platform specific rte_pmd_cnxk ops */
 	cnxk_pmd_ops.inl_dev_submit = cn20k_inl_dev_submit;
diff --git a/drivers/net/cnxk/cn20k_rx.h b/drivers/net/cnxk/cn20k_rx.h
index d6c217cdf5..f8fa6de2b9 100644
--- a/drivers/net/cnxk/cn20k_rx.h
+++ b/drivers/net/cnxk/cn20k_rx.h
@@ -890,6 +890,169 @@ cn20k_nix_flush_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t pk

 #if defined(RTE_ARCH_ARM64)

+static __rte_always_inline uint16_t
+cn20k_nix_rx_inj_prepare_mseg(struct rte_mbuf *m, uint64_t *cmd)
+{
+	union nix_send_sg_s *sg, l_sg;
+	struct rte_mbuf *m_next;
+	uint16_t segdw, nb_segs;
+	uint64_t len, dlen;
+	uint64_t *slist;
+
+	sg = (union nix_send_sg_s *)cmd;
+	l_sg.u = sg->u;
+	l_sg.u &= 0xC00000000000000; /* LD_TYPE */
+	l_sg.subdc = NIX_SUBDC_SG;
+	nb_segs = m->nb_segs;
+	len = m->pkt_len;
+	slist = &cmd[1];
+
+	/* Fill mbuf segments */
+	do {
+		*slist = rte_pktmbuf_iova(m);
+		dlen = m->data_len;
+		len -= dlen;
+
+		/* Set the segment length */
+		l_sg.u |= ((uint64_t)dlen << (l_sg.segs << 4));
+		l_sg.segs += 1;
+		slist++;
+		nb_segs--;
+		if (l_sg.segs > 2 && nb_segs) {
+			sg->u = l_sg.u;
+			/* Next SG subdesc */
+			sg = (union nix_send_sg_s *)slist;
+			l_sg.u = sg->u;
+			l_sg.u &= 0xC00000000000000; /* LD_TYPE */
+			l_sg.subdc = NIX_SUBDC_SG;
+			slist++;
+		}
+		m_next = m->next;
+		m = m_next;
+	} while (nb_segs);
+
+	/* Add remaining bytes of data to last seg */
+	if (len) {
+		uint8_t shft = (l_sg.subdc == NIX_SUBDC_SG) ? ((l_sg.segs - 1) << 4) : 0;
+		dlen = ((l_sg.u >> shft) & 0xFFFFULL) + len;
+		l_sg.u = l_sg.u & ~(0xFFFFULL << shft);
+		l_sg.u |= dlen << shft;
+	}
+	/* Write the last subdc out */
+	sg->u = l_sg.u;
+
+	segdw = (uint64_t *)slist - cmd;
+	/* Roundup extra dwords to multiple of 2 */
+	segdw = (segdw >> 1) + (segdw & 0x1);
+	return segdw;
+}
+
+static __rte_always_inline uint16_t
+cn20k_nix_inj_pkts(struct rte_security_session **sess, struct cnxk_ethdev_inj_cfg *inj_cfg,
+		   struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	uintptr_t c_lbase = inj_cfg->lmt_base;
+	struct cn20k_sec_sess_priv sess_priv;
+	uint64_t sa_base = inj_cfg->sa_base;
+	uint16_t c_lmt_id, burst, left, i;
+	uintptr_t cptres, rxphdr, dptr;
+	struct rte_mbuf *m, *last;
+	uint64_t sa, w0, gthr_sz;
+	uint8_t lnum, shft, loff;
+	uint64x2_t cmd01, cmd23;
+	uint64_t ucode_cmd[4];
+	rte_iova_t c_io_addr;
+	uint16_t segdw, segs;
+	uint64_t *laddr;
+
+	/* Get LMT base address and LMT ID as lcore id */
+	ROC_LMT_CPT_BASE_ID_GET(c_lbase, c_lmt_id);
+	c_io_addr = inj_cfg->io_addr;
+
+	sa_base &= ~0xFFFFUL;
+	left = nb_pkts;
+again:
+	burst = left > 32 ? 32 : left;
+
+	lnum = 0;
+	loff = 0;
+	shft = 16;
+
+	for (i = 0; i < burst; i++) {
+		m = tx_pkts[i];
+		sess_priv.u64 = sess[i]->fast_mdata;
+		last = rte_pktmbuf_lastseg(m);
+
+		cptres = rte_pktmbuf_mtod_offset(last, uintptr_t, last->data_len);
+		cptres += BIT_ULL(7);
+		cptres = (cptres - 1) & ~(BIT_ULL(7) - 1);
+		segs = m->nb_segs;
+
+		if (segs > 1) {
+			/* Pointer to WQE header */
+			/* Reserve 8 Dwords of WQE Hdr + Rx Parse Hdr */
+			rxphdr = cptres + 8;
+			dptr = rxphdr + 7 * 8;
+			/* Prepare Multiseg SG list */
+			segdw = cn20k_nix_rx_inj_prepare_mseg(m, (uint64_t *)(dptr));
+			*(uint64_t *)rxphdr = (uint64_t)(segdw - 1) << 12;
+			cptres += 64 + segdw * 16;
+			gthr_sz = (segs % 3) == 0 ? (segs / 3) : (segs / 3 + 1);
+			ucode_cmd[1] = dptr | (gthr_sz << 60);
+		} else {
+			dptr = (uint64_t)rte_pktmbuf_iova(m);
+			ucode_cmd[1] = dptr;
+		}
+
+		/* Prepare CPT instruction */
+		/* CPT word 0 and 1 */
+		cmd01 = vdupq_n_u64(0);
+		w0 = inj_cfg->cmd_w0 | ((uint64_t)m->l2_len - 2) << 24 | (uint64_t)m->l2_len << 16;
+		cmd01 = vsetq_lane_u64(w0, cmd01, 0);
+		cmd01 = vsetq_lane_u64(cptres, cmd01, 1);
+
+		/* CPT word 2 and 3 */
+		cmd23 = vdupq_n_u64(0);
+		/* Set PF func */
+		w0 &= 0xFFFF000000000000UL;
+		cmd23 = vsetq_lane_u64(w0, cmd23, 0);
+		cmd23 = vsetq_lane_u64(((uint64_t)m + sizeof(struct rte_mbuf)) | 1, cmd23, 1);
+
+		sa = (uintptr_t)roc_nix_inl_ow_ipsec_inb_sa(sa_base, sess_priv.sa_idx);
+		ucode_cmd[0] = (ROC_IE_OW_MAJOR_OP_PROCESS_INBOUND_IPSEC << 48 | 1UL << 54 |
+				((uint64_t)sess_priv.chksum) << 32 | (1ULL << 34) | m->pkt_len);
+
+		ucode_cmd[2] = 0;
+		ucode_cmd[3] = (ROC_CPT_DFLT_ENG_GRP_SE << 61 | 1UL << 60 | sa);
+
+		/* Move to our line */
+		laddr = LMT_OFF(c_lbase, lnum, loff ? 64 : 0);
+
+		/* Write CPT instruction to lmt line */
+		vst1q_u64(laddr, cmd01);
+		vst1q_u64((laddr + 2), cmd23);
+
+		*(__uint128_t *)(laddr + 4) = *(__uint128_t *)ucode_cmd;
+		*(__uint128_t *)(laddr + 6) = *(__uint128_t *)(ucode_cmd + 2);
+
+		loff = !loff;
+		lnum = lnum + (loff ? 0 : 1);
+		shft = shft + (loff ? 0 : 3);
+	}
+
+	left -= burst;
+	tx_pkts += burst;
+	sess += burst;
+
+	cn20k_nix_sec_steorl(c_io_addr, c_lmt_id, lnum, loff, shft);
+
+	rte_io_wmb();
+	if (left)
+		goto again;
+
+	return nb_pkts;
+}
+
 static __rte_always_inline void
 nix_sec_meta_to_mbuf(uintptr_t inb_sa, uintptr_t cpth, struct rte_mbuf **inner, uint64_t *ol_flags,
 		     const uint16_t flags, uint64x2_t *rearm, uint64_t buf_sz)
@@ -1741,6 +1904,17 @@ cn20k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts, c
 	return 0;
 }

+static __rte_always_inline uint16_t
+cn20k_nix_inj_pkts(struct rte_security_session **sess, struct cnxk_ethdev_inj_cfg *inj_cfg,
+		   struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	RTE_SET_USED(sess);
+	RTE_SET_USED(inj_cfg);
+	RTE_SET_USED(tx_pkts);
+	RTE_SET_USED(nb_pkts);
+	return 0;
+}
+
 #endif

 #define RSS_F	  NIX_RX_OFFLOAD_RSS_F
--
2.34.1

