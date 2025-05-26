Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEE6C54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 17:01:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 585BF40E15;
	Mon, 26 May 2025 18:59:54 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E7DA940BA0
 for <dev@dpdk.org>; Mon, 26 May 2025 18:59:52 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QEulcV028804
 for <dev@dpdk.org>; Mon, 26 May 2025 09:59:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=G
 YTv/rB/IUcxumLYv2UtBt/ak0a12WrwHsazBJopyvU=; b=UHpY/7hp2HQfONLvr
 D2J1z4LVYmXO/WuS+LaaUvCwyyErxOn6ufL9tL47rbttDaiH6bgtpKBRw9librgr
 t9QtI1DT8nP1wTXzk1blAXBPhkGXj3xLkSH+PxVyIyQMkuY12hpIdjSlUU1DnyRJ
 AtGqdEey289XGW4Iy6Nkf6ZfPZKIz1K0bs59Dvum9+eOXslEeN9fiO3agiGagBE0
 gmruZ7s10maf9Y6vri2Ga3VGLv7Fo6hbhhW2u9N9Ky36Q6U9cSdat+09f2h18n89
 4338ngaeSkEjfF8cCizHlB19Ny1+jr6vJqlSCPOVbNZi09GI6YRmtfhUQrEYoCWc
 Jm3vQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46veebhjsh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 09:59:52 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 09:59:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 09:59:51 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 86C033F7048;
 Mon, 26 May 2025 09:59:48 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 27/40] crypto/cnxk: tls post process
Date: Mon, 26 May 2025 22:28:06 +0530
Message-ID: <20250526165819.2197892-28-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: q8gsx6VeFr82qxxvEsV0qa8owGdSrnWR
X-Authority-Analysis: v=2.4 cv=TJ9FS0la c=1 sm=1 tr=0 ts=68349e08 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=weGRBw-3vhUYY0j21ksA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0NCBTYWx0ZWRfX0/PGOXUoBvEA
 0LC7gdusLFjP0+Y9o3UA1VacDn3lCluGBPQXq8yyZcWTRYX6EBdG5yvL+dj41IxXvuZUvXQaKbW
 LmB8BFu3W9RZZqJmPYBhxfNsyGfIln2ePKpPOmqWXgc3orSMhlQbixKuqeDahXFvDGwGE/qIcyg
 bvYl8vZfQDiTLdtS0EIBiyuXZap3z9r5GE8Xz5OOmsFG2DSoxCxiEWTVZJy2rCUIUS4UHTpFFb0
 2noMgQCYK3vcOnTFmc9gHfKtyvboN9u5kRRlK2PnutulECKCSI6H5p0FXQNz1S6vkllhpMnoZNx
 1msmUFjqhND4XapDeFARxasmxnAgwpRxxPE76oEgqLAmnDL7jv3cJh6D+mjRCzbgQkZ0/72GsC1
 vC3ucnaaixElBI1zazOhTH6ZT7zQYk7OaOq2vIt3twfXcN6shTzROnz772XVIjQIw0ZRaHGM
X-Proofpoint-GUID: q8gsx6VeFr82qxxvEsV0qa8owGdSrnWR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_08,2025-05-26_02,2025-03-28_01
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

Add tls post process

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c | 160 ++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index f328d810d2..cd709ac69e 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -317,6 +317,164 @@ cn20k_cpt_ipsec_post_process(struct rte_crypto_op *cop, struct cpt_cn20k_res_s *
 	mbuf->pkt_len = m_len;
 }
 
+static inline void
+cn20k_cpt_tls12_trim_mac(struct rte_crypto_op *cop, struct cpt_cn20k_res_s *res, uint8_t mac_len)
+{
+	struct rte_mbuf *mac_prev_seg = NULL, *mac_seg = NULL, *seg;
+	uint32_t pad_len, trim_len, mac_offset, pad_offset;
+	struct rte_mbuf *mbuf = cop->sym->m_src;
+	uint16_t m_len = res->rlen;
+	uint32_t i, nb_segs = 1;
+	uint8_t pad_res = 0;
+	uint8_t pad_val;
+
+	pad_val = ((res->spi >> 16) & 0xff);
+	pad_len = pad_val + 1;
+	trim_len = pad_len + mac_len;
+	mac_offset = m_len - trim_len;
+	pad_offset = mac_offset + mac_len;
+
+	/* Handle Direct Mode */
+	if (mbuf->next == NULL) {
+		uint8_t *ptr = rte_pktmbuf_mtod_offset(mbuf, uint8_t *, pad_offset);
+
+		for (i = 0; i < pad_len; i++)
+			pad_res |= ptr[i] ^ pad_val;
+
+		if (pad_res) {
+			cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+			cop->aux_flags = res->uc_compcode;
+		}
+		mbuf->pkt_len = m_len - trim_len;
+		mbuf->data_len = m_len - trim_len;
+
+		return;
+	}
+
+	/* Handle SG mode */
+	seg = mbuf;
+	while (mac_offset >= seg->data_len) {
+		mac_offset -= seg->data_len;
+		mac_prev_seg = seg;
+		seg = seg->next;
+		nb_segs++;
+	}
+	mac_seg = seg;
+
+	pad_offset = mac_offset + mac_len;
+	while (pad_offset >= seg->data_len) {
+		pad_offset -= seg->data_len;
+		seg = seg->next;
+	}
+
+	while (pad_len != 0) {
+		uint8_t *ptr = rte_pktmbuf_mtod_offset(seg, uint8_t *, pad_offset);
+		uint8_t len = RTE_MIN(seg->data_len - pad_offset, pad_len);
+
+		for (i = 0; i < len; i++)
+			pad_res |= ptr[i] ^ pad_val;
+
+		pad_offset = 0;
+		pad_len -= len;
+		seg = seg->next;
+	}
+
+	if (pad_res) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		cop->aux_flags = res->uc_compcode;
+	}
+
+	mbuf->pkt_len = m_len - trim_len;
+	if (mac_offset) {
+		rte_pktmbuf_free(mac_seg->next);
+		mac_seg->next = NULL;
+		mac_seg->data_len = mac_offset;
+		mbuf->nb_segs = nb_segs;
+	} else {
+		rte_pktmbuf_free(mac_seg);
+		mac_prev_seg->next = NULL;
+		mbuf->nb_segs = nb_segs - 1;
+	}
+}
+
+/* TLS-1.3:
+ * Read from last until a non-zero value is encountered.
+ * Return the non zero value as the content type.
+ * Remove the MAC and content type and padding bytes.
+ */
+static inline void
+cn20k_cpt_tls13_trim_mac(struct rte_crypto_op *cop, struct cpt_cn20k_res_s *res)
+{
+	struct rte_mbuf *mbuf = cop->sym->m_src;
+	struct rte_mbuf *seg = mbuf;
+	uint16_t m_len = res->rlen;
+	uint8_t *ptr, type = 0x0;
+	int len, i, nb_segs = 1;
+
+	while (m_len && !type) {
+		len = m_len;
+		seg = mbuf;
+
+		/* get the last seg */
+		while (len > seg->data_len) {
+			len -= seg->data_len;
+			seg = seg->next;
+			nb_segs++;
+		}
+
+		/* walkthrough from last until a non zero value is found */
+		ptr = rte_pktmbuf_mtod(seg, uint8_t *);
+		i = len;
+		while (i && (ptr[--i] == 0))
+			;
+
+		type = ptr[i];
+		m_len -= len;
+	}
+
+	if (type) {
+		cop->param1.tls_record.content_type = type;
+		mbuf->pkt_len = m_len + i;
+		mbuf->nb_segs = nb_segs;
+		seg->data_len = i;
+		rte_pktmbuf_free(seg->next);
+		seg->next = NULL;
+	} else {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+	}
+}
+
+static inline void
+cn20k_cpt_tls_post_process(struct rte_crypto_op *cop, struct cpt_cn20k_res_s *res,
+			   struct cn20k_sec_session *sess)
+{
+	struct cn20k_tls_opt tls_opt = sess->tls_opt;
+	struct rte_mbuf *mbuf = cop->sym->m_src;
+	uint16_t m_len = res->rlen;
+
+	if (!res->uc_compcode) {
+		if (mbuf->next == NULL)
+			mbuf->data_len = m_len;
+		mbuf->pkt_len = m_len;
+		cop->param1.tls_record.content_type = (res->spi >> 24) & 0xff;
+		return;
+	}
+
+	/* Any error other than post process */
+	if (res->uc_compcode != ROC_SE_ERR_SSL_POST_PROCESS) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		cop->aux_flags = res->uc_compcode;
+		plt_err("crypto op failed with UC compcode: 0x%x", res->uc_compcode);
+		return;
+	}
+
+	/* Extra padding scenario: Verify padding. Remove padding and MAC */
+	if (tls_opt.tls_ver != RTE_SECURITY_VERSION_TLS_1_3)
+		cn20k_cpt_tls12_trim_mac(cop, res, (uint8_t)tls_opt.mac_len);
+	else
+		cn20k_cpt_tls13_trim_mac(cop, res);
+}
+
 static inline void
 cn20k_cpt_sec_post_process(struct rte_crypto_op *cop, struct cpt_cn20k_res_s *res)
 {
@@ -326,6 +484,8 @@ cn20k_cpt_sec_post_process(struct rte_crypto_op *cop, struct cpt_cn20k_res_s *re
 	sess = sym_op->session;
 	if (sess->proto == RTE_SECURITY_PROTOCOL_IPSEC)
 		cn20k_cpt_ipsec_post_process(cop, res);
+	else if (sess->proto == RTE_SECURITY_PROTOCOL_TLS_RECORD)
+		cn20k_cpt_tls_post_process(cop, res, sess);
 }
 
 static inline void
-- 
2.25.1

