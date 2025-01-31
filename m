Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71883C0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 08:06:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FD0C40F1A;
	Fri, 31 Jan 2025 09:06:17 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 32462427BA
 for <dev@dpdk.org>; Fri, 31 Jan 2025 09:06:14 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V80WmS008718
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:06:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=t
 2rcqqJTFD046vhCxBGlEv9Wh5VV0VKJAZAlfARLOdU=; b=hvm+VhuTMa4EDJb3n
 TQmrzj/rSNO0SnCiRRE4COAdsyFMS4ou9y0lBEq12wmhh1wMy2lG1cKX1rc1rMaQ
 Dvuy4hcPKjS9GnSeqnUizVYJA0KxO+B7ua7idGZl5rovgl6GLhptghgEU65icvLn
 zpNqJkx7LRtyVepUjAhPAJutrugsWA3CbSJer9A/N+8N5mPrm4wSnxD1+1bigiUG
 m9M68vYWRuWmu9q4iNx/UXOSW6LFEtHiFeLbmQydAcpdxDGyGBy5OHR9eOPgVoP/
 Erbfcdx4sbVbUNEcEfhJ8x91J+lF05esi7/I26zn7RGy5kp4CLT2GbWYuN/p6bNA
 U6EAw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44gtenr0vx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:06:13 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 31 Jan 2025 00:06:11 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 31 Jan 2025 00:06:11 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 044B73F705C;
 Fri, 31 Jan 2025 00:06:08 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH 12/34] common/cnxk: support for cn20k IPsec session
Date: Fri, 31 Jan 2025 13:35:07 +0530
Message-ID: <20250131080530.3224977-12-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250131080530.3224977-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 07geNSAb1Cu1-6vtHDpJMwdqUhpTNSK5
X-Proofpoint-ORIG-GUID: 07geNSAb1Cu1-6vtHDpJMwdqUhpTNSK5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_03,2025-01-30_01,2024-11-22_01
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

Add support for cn20k IPsec session create/destroy.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/common/cnxk/cnxk_security.c | 546 +++++++++++++++++++++++++++-
 drivers/common/cnxk/cnxk_security.h |  12 +-
 drivers/common/cnxk/version.map     |   2 +
 3 files changed, 557 insertions(+), 3 deletions(-)

diff --git a/drivers/common/cnxk/cnxk_security.c b/drivers/common/cnxk/cnxk_security.c
index 1dfb582f96..1fe750049e 100644
--- a/drivers/common/cnxk/cnxk_security.c
+++ b/drivers/common/cnxk/cnxk_security.c
@@ -4,10 +4,10 @@
 
 #include <rte_udp.h>
 
-#include "cnxk_security.h"
-
 #include "roc_api.h"
 
+#include "cnxk_security.h"
+
 static int
 ot_ipsec_sa_common_param_fill(union roc_ot_ipsec_sa_word2 *w2, uint8_t *cipher_key,
 			      uint8_t *salt_key, uint8_t *hmac_opad_ipad,
@@ -1179,3 +1179,545 @@ cnxk_on_ipsec_inb_sa_create(struct rte_security_ipsec_xform *ipsec,
 
 	return ctx_len;
 }
+
+static int
+ow_ipsec_sa_common_param_fill(union roc_ow_ipsec_sa_word2 *w2, uint8_t *cipher_key,
+			      uint8_t *salt_key, uint8_t *hmac_opad_ipad,
+			      struct rte_security_ipsec_xform *ipsec_xfrm,
+			      struct rte_crypto_sym_xform *crypto_xfrm)
+{
+	struct rte_crypto_sym_xform *auth_xfrm, *cipher_xfrm;
+	const uint8_t *key = NULL;
+	uint8_t ccm_flag = 0;
+	uint32_t *tmp_salt;
+	uint64_t *tmp_key;
+	int i, length = 0;
+
+	/* Set direction */
+	if (ipsec_xfrm->direction == RTE_SECURITY_IPSEC_SA_DIR_EGRESS)
+		w2->s.dir = ROC_IE_SA_DIR_OUTBOUND;
+	else
+		w2->s.dir = ROC_IE_SA_DIR_INBOUND;
+
+	if (crypto_xfrm->type == RTE_CRYPTO_SYM_XFORM_AUTH) {
+		auth_xfrm = crypto_xfrm;
+		cipher_xfrm = crypto_xfrm->next;
+	} else {
+		cipher_xfrm = crypto_xfrm;
+		auth_xfrm = crypto_xfrm->next;
+	}
+
+	/* Set protocol - ESP vs AH */
+	switch (ipsec_xfrm->proto) {
+	case RTE_SECURITY_IPSEC_SA_PROTO_ESP:
+		w2->s.protocol = ROC_IE_SA_PROTOCOL_ESP;
+		break;
+	case RTE_SECURITY_IPSEC_SA_PROTO_AH:
+		w2->s.protocol = ROC_IE_SA_PROTOCOL_AH;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Set mode - transport vs tunnel */
+	switch (ipsec_xfrm->mode) {
+	case RTE_SECURITY_IPSEC_SA_MODE_TRANSPORT:
+		w2->s.mode = ROC_IE_SA_MODE_TRANSPORT;
+		break;
+	case RTE_SECURITY_IPSEC_SA_MODE_TUNNEL:
+		w2->s.mode = ROC_IE_SA_MODE_TUNNEL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Set encryption algorithm */
+	if (crypto_xfrm->type == RTE_CRYPTO_SYM_XFORM_AEAD) {
+		key = crypto_xfrm->aead.key.data;
+		length = crypto_xfrm->aead.key.length;
+
+		switch (crypto_xfrm->aead.algo) {
+		case RTE_CRYPTO_AEAD_AES_GCM:
+			w2->s.enc_type = ROC_IE_SA_ENC_AES_GCM;
+			w2->s.auth_type = ROC_IE_SA_AUTH_NULL;
+			memcpy(salt_key, &ipsec_xfrm->salt, 4);
+			tmp_salt = (uint32_t *)salt_key;
+			*tmp_salt = rte_be_to_cpu_32(*tmp_salt);
+			break;
+		case RTE_CRYPTO_AEAD_AES_CCM:
+			w2->s.enc_type = ROC_IE_SA_ENC_AES_CCM;
+			w2->s.auth_type = ROC_IE_SA_AUTH_NULL;
+			ccm_flag = 0x07 & ~ROC_CPT_AES_CCM_CTR_LEN;
+			*salt_key = ccm_flag;
+			memcpy(PLT_PTR_ADD(salt_key, 1), &ipsec_xfrm->salt, 3);
+			tmp_salt = (uint32_t *)salt_key;
+			*tmp_salt = rte_be_to_cpu_32(*tmp_salt);
+			break;
+		default:
+			return -ENOTSUP;
+		}
+	} else {
+		if (cipher_xfrm != NULL) {
+			switch (cipher_xfrm->cipher.algo) {
+			case RTE_CRYPTO_CIPHER_NULL:
+				w2->s.enc_type = ROC_IE_SA_ENC_NULL;
+				break;
+			case RTE_CRYPTO_CIPHER_AES_CBC:
+				w2->s.enc_type = ROC_IE_SA_ENC_AES_CBC;
+				break;
+			case RTE_CRYPTO_CIPHER_AES_CTR:
+				w2->s.enc_type = ROC_IE_SA_ENC_AES_CTR;
+				break;
+			case RTE_CRYPTO_CIPHER_3DES_CBC:
+				w2->s.enc_type = ROC_IE_SA_ENC_3DES_CBC;
+				break;
+			default:
+				return -ENOTSUP;
+			}
+
+			key = cipher_xfrm->cipher.key.data;
+			length = cipher_xfrm->cipher.key.length;
+		}
+
+		switch (auth_xfrm->auth.algo) {
+		case RTE_CRYPTO_AUTH_NULL:
+			if (w2->s.dir == ROC_IE_SA_DIR_INBOUND && ipsec_xfrm->replay_win_sz) {
+				plt_err("anti-replay can't be supported with integrity service disabled");
+				return -EINVAL;
+			}
+			w2->s.auth_type = ROC_IE_SA_AUTH_NULL;
+			break;
+		case RTE_CRYPTO_AUTH_SHA1_HMAC:
+			w2->s.auth_type = ROC_IE_SA_AUTH_SHA1;
+			break;
+		case RTE_CRYPTO_AUTH_SHA256_HMAC:
+			w2->s.auth_type = ROC_IE_SA_AUTH_SHA2_256;
+			break;
+		case RTE_CRYPTO_AUTH_SHA384_HMAC:
+			w2->s.auth_type = ROC_IE_SA_AUTH_SHA2_384;
+			break;
+		case RTE_CRYPTO_AUTH_SHA512_HMAC:
+			w2->s.auth_type = ROC_IE_SA_AUTH_SHA2_512;
+			break;
+		case RTE_CRYPTO_AUTH_AES_XCBC_MAC:
+			w2->s.auth_type = ROC_IE_SA_AUTH_AES_XCBC_128;
+			break;
+		case RTE_CRYPTO_AUTH_AES_GMAC:
+			w2->s.auth_type = ROC_IE_SA_AUTH_AES_GMAC;
+			key = auth_xfrm->auth.key.data;
+			length = auth_xfrm->auth.key.length;
+			memcpy(salt_key, &ipsec_xfrm->salt, 4);
+			tmp_salt = (uint32_t *)salt_key;
+			*tmp_salt = rte_be_to_cpu_32(*tmp_salt);
+			break;
+		default:
+			return -ENOTSUP;
+		}
+
+		if (auth_xfrm->auth.algo == RTE_CRYPTO_AUTH_AES_XCBC_MAC) {
+			const uint8_t *auth_key = auth_xfrm->auth.key.data;
+			roc_aes_xcbc_key_derive(auth_key, hmac_opad_ipad);
+		} else {
+			roc_se_hmac_opad_ipad_gen(w2->s.auth_type, auth_xfrm->auth.key.data,
+						  auth_xfrm->auth.key.length, &hmac_opad_ipad[0],
+						  ROC_SE_IPSEC);
+		}
+
+		tmp_key = (uint64_t *)hmac_opad_ipad;
+		for (i = 0; i < (int)(ROC_CTX_MAX_OPAD_IPAD_LEN / sizeof(uint64_t)); i++)
+			tmp_key[i] = rte_be_to_cpu_64(tmp_key[i]);
+	}
+
+	/* Set encapsulation type */
+	if (ipsec_xfrm->options.udp_encap)
+		w2->s.encap_type = ROC_IE_OT_SA_ENCAP_UDP;
+
+	w2->s.spi = ipsec_xfrm->spi;
+
+	if (key != NULL && length != 0) {
+		/* Copy encryption key */
+		memcpy(cipher_key, key, length);
+		tmp_key = (uint64_t *)cipher_key;
+		for (i = 0; i < (int)(ROC_CTX_MAX_CKEY_LEN / sizeof(uint64_t)); i++)
+			tmp_key[i] = rte_be_to_cpu_64(tmp_key[i]);
+	}
+
+	/* Set AES key length */
+	if (w2->s.enc_type == ROC_IE_SA_ENC_AES_CBC || w2->s.enc_type == ROC_IE_SA_ENC_AES_CCM ||
+	    w2->s.enc_type == ROC_IE_SA_ENC_AES_CTR || w2->s.enc_type == ROC_IE_SA_ENC_AES_GCM ||
+	    w2->s.enc_type == ROC_IE_SA_ENC_AES_CCM || w2->s.auth_type == ROC_IE_SA_AUTH_AES_GMAC) {
+		switch (length) {
+		case ROC_CPT_AES128_KEY_LEN:
+			w2->s.aes_key_len = ROC_IE_SA_AES_KEY_LEN_128;
+			break;
+		case ROC_CPT_AES192_KEY_LEN:
+			w2->s.aes_key_len = ROC_IE_SA_AES_KEY_LEN_192;
+			break;
+		case ROC_CPT_AES256_KEY_LEN:
+			w2->s.aes_key_len = ROC_IE_SA_AES_KEY_LEN_256;
+			break;
+		default:
+			plt_err("Invalid AES key length");
+			return -EINVAL;
+		}
+	}
+
+	if (ipsec_xfrm->life.packets_soft_limit != 0 || ipsec_xfrm->life.packets_hard_limit != 0) {
+		if (ipsec_xfrm->life.bytes_soft_limit != 0 ||
+		    ipsec_xfrm->life.bytes_hard_limit != 0) {
+			plt_err("Expiry tracking with both packets & bytes is not supported");
+			return -EINVAL;
+		}
+		w2->s.life_unit = ROC_IE_OT_SA_LIFE_UNIT_PKTS;
+	}
+
+	if (ipsec_xfrm->life.bytes_soft_limit != 0 || ipsec_xfrm->life.bytes_hard_limit != 0) {
+		if (ipsec_xfrm->life.packets_soft_limit != 0 ||
+		    ipsec_xfrm->life.packets_hard_limit != 0) {
+			plt_err("Expiry tracking with both packets & bytes is not supported");
+			return -EINVAL;
+		}
+		w2->s.life_unit = ROC_IE_OT_SA_LIFE_UNIT_OCTETS;
+	}
+
+	return 0;
+}
+
+static size_t
+ow_ipsec_inb_ctx_size(struct roc_ow_ipsec_inb_sa *sa)
+{
+	size_t size;
+
+	/* Variable based on Anti-replay Window */
+	size = offsetof(struct roc_ow_ipsec_inb_sa, ctx) +
+	       offsetof(struct roc_ow_ipsec_inb_ctx_update_reg, ar_winbits);
+
+	if (sa->w0.s.ar_win)
+		size += (1 << (sa->w0.s.ar_win - 1)) * sizeof(uint64_t);
+
+	return size;
+}
+
+static void
+ow_ipsec_update_ipv6_addr_endianness(uint64_t *addr)
+{
+	*addr = rte_be_to_cpu_64(*addr);
+	addr++;
+	*addr = rte_be_to_cpu_64(*addr);
+}
+
+static int
+ow_ipsec_inb_tunnel_hdr_fill(struct roc_ow_ipsec_inb_sa *sa,
+			     struct rte_security_ipsec_xform *ipsec_xfrm)
+{
+	struct rte_security_ipsec_tunnel_param *tunnel;
+
+	if (ipsec_xfrm->mode != RTE_SECURITY_IPSEC_SA_MODE_TUNNEL)
+		return 0;
+
+	if (ipsec_xfrm->options.tunnel_hdr_verify == 0)
+		return 0;
+
+	tunnel = &ipsec_xfrm->tunnel;
+
+	switch (tunnel->type) {
+	case RTE_SECURITY_IPSEC_TUNNEL_IPV4:
+		sa->w2.s.outer_ip_ver = ROC_IE_SA_IP_VERSION_4;
+		memcpy(&sa->outer_hdr.ipv4.src_addr, &tunnel->ipv4.src_ip, sizeof(struct in_addr));
+		memcpy(&sa->outer_hdr.ipv4.dst_addr, &tunnel->ipv4.dst_ip, sizeof(struct in_addr));
+
+		/* IP Source and Dest are in LE/CPU endian */
+		sa->outer_hdr.ipv4.src_addr = rte_be_to_cpu_32(sa->outer_hdr.ipv4.src_addr);
+		sa->outer_hdr.ipv4.dst_addr = rte_be_to_cpu_32(sa->outer_hdr.ipv4.dst_addr);
+
+		break;
+	case RTE_SECURITY_IPSEC_TUNNEL_IPV6:
+		sa->w2.s.outer_ip_ver = ROC_IE_SA_IP_VERSION_6;
+		memcpy(&sa->outer_hdr.ipv6.src_addr, &tunnel->ipv6.src_addr,
+		       sizeof(struct in6_addr));
+		memcpy(&sa->outer_hdr.ipv6.dst_addr, &tunnel->ipv6.dst_addr,
+		       sizeof(struct in6_addr));
+
+		/* IP Source and Dest are in LE/CPU endian */
+		ow_ipsec_update_ipv6_addr_endianness((uint64_t *)&sa->outer_hdr.ipv6.src_addr);
+		ow_ipsec_update_ipv6_addr_endianness((uint64_t *)&sa->outer_hdr.ipv6.dst_addr);
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (ipsec_xfrm->options.tunnel_hdr_verify) {
+	case RTE_SECURITY_IPSEC_TUNNEL_VERIFY_DST_ADDR:
+		sa->w2.s.ip_hdr_verify = ROC_IE_OT_SA_IP_HDR_VERIFY_DST_ADDR;
+		break;
+	case RTE_SECURITY_IPSEC_TUNNEL_VERIFY_SRC_DST_ADDR:
+		sa->w2.s.ip_hdr_verify = ROC_IE_OT_SA_IP_HDR_VERIFY_SRC_DST_ADDR;
+		break;
+	default:
+		return -ENOTSUP;
+	}
+
+	return 0;
+}
+
+int
+cnxk_ow_ipsec_inb_sa_fill(struct roc_ow_ipsec_inb_sa *sa,
+			  struct rte_security_ipsec_xform *ipsec_xfrm,
+			  struct rte_crypto_sym_xform *crypto_xfrm)
+{
+	uint16_t sport = 4500, dport = 4500;
+	union roc_ow_ipsec_sa_word2 w2;
+	uint32_t replay_win_sz;
+	size_t offset;
+	int rc;
+
+	/* Initialize the SA */
+	roc_ow_ipsec_inb_sa_init(sa);
+
+	w2.u64 = 0;
+	rc = ow_ipsec_sa_common_param_fill(&w2, sa->cipher_key, sa->w8.s.salt, sa->hmac_opad_ipad,
+					   ipsec_xfrm, crypto_xfrm);
+	if (rc)
+		return rc;
+
+	/* Updata common word2 data */
+	sa->w2.u64 = w2.u64;
+
+	/* Only support power-of-two window sizes supported */
+	replay_win_sz = ipsec_xfrm->replay_win_sz;
+	if (replay_win_sz) {
+		if (!rte_is_power_of_2(replay_win_sz) || replay_win_sz > ROC_AR_WIN_SIZE_MAX)
+			return -ENOTSUP;
+
+		sa->w0.s.ar_win = rte_log2_u32(replay_win_sz) - 5;
+	}
+
+	rc = ow_ipsec_inb_tunnel_hdr_fill(sa, ipsec_xfrm);
+	if (rc)
+		return rc;
+
+	/* Default options for pkt_out and pkt_fmt are with
+	 * second pass meta and no defrag.
+	 */
+	sa->w0.s.pkt_format = ROC_IE_OT_SA_PKT_FMT_META;
+	sa->w0.s.pkt_output = ROC_IE_OT_SA_PKT_OUTPUT_NO_FRAG;
+	sa->w0.s.pkind = ROC_IE_OT_CPT_PKIND;
+
+	if (ipsec_xfrm->options.ip_reassembly_en)
+		sa->w0.s.pkt_output = ROC_IE_OT_SA_PKT_OUTPUT_HW_BASED_DEFRAG;
+
+	/* ESN */
+	sa->w2.s.esn_en = !!ipsec_xfrm->options.esn;
+	if (ipsec_xfrm->options.udp_encap) {
+		if (ipsec_xfrm->udp.sport)
+			sport = ipsec_xfrm->udp.sport;
+
+		if (ipsec_xfrm->udp.dport)
+			dport = ipsec_xfrm->udp.dport;
+
+		sa->w10.s.udp_src_port = sport;
+		sa->w10.s.udp_dst_port = dport;
+	}
+
+	if (ipsec_xfrm->options.udp_ports_verify)
+		sa->w2.s.udp_ports_verify = 1;
+
+	offset = offsetof(struct roc_ow_ipsec_inb_sa, ctx);
+	/* Word offset for HW managed SA field */
+	sa->w0.s.hw_ctx_off = offset / 8;
+	/* Context push size for inbound spans up to hw_ctx including
+	 * ar_base field, in 8b units
+	 */
+	sa->w0.s.ctx_push_size = sa->w0.s.hw_ctx_off + 1;
+	/* Entire context size in 128B units */
+	sa->w0.s.ctx_size =
+		(PLT_ALIGN_CEIL(ow_ipsec_inb_ctx_size(sa), ROC_CTX_UNIT_128B) / ROC_CTX_UNIT_128B) -
+		1;
+
+	/**
+	 * CPT MC triggers expiry when counter value changes from 2 to 1. To
+	 * mitigate this behaviour add 1 to the life counter values provided.
+	 */
+
+	if (ipsec_xfrm->life.bytes_soft_limit) {
+		sa->ctx.soft_life = ipsec_xfrm->life.bytes_soft_limit + 1;
+		sa->w0.s.soft_life_dec = 1;
+	}
+
+	if (ipsec_xfrm->life.packets_soft_limit) {
+		sa->ctx.soft_life = ipsec_xfrm->life.packets_soft_limit + 1;
+		sa->w0.s.soft_life_dec = 1;
+	}
+
+	if (ipsec_xfrm->life.bytes_hard_limit) {
+		sa->ctx.hard_life = ipsec_xfrm->life.bytes_hard_limit + 1;
+		sa->w0.s.hard_life_dec = 1;
+	}
+
+	if (ipsec_xfrm->life.packets_hard_limit) {
+		sa->ctx.hard_life = ipsec_xfrm->life.packets_hard_limit + 1;
+		sa->w0.s.hard_life_dec = 1;
+	}
+
+	rte_wmb();
+
+	/* Enable SA */
+	sa->w2.s.valid = 1;
+	return 0;
+}
+
+int
+cnxk_ow_ipsec_outb_sa_fill(struct roc_ow_ipsec_outb_sa *sa,
+			   struct rte_security_ipsec_xform *ipsec_xfrm,
+			   struct rte_crypto_sym_xform *crypto_xfrm)
+{
+	struct rte_security_ipsec_tunnel_param *tunnel = &ipsec_xfrm->tunnel;
+	uint16_t sport = 4500, dport = 4500;
+	union roc_ow_ipsec_sa_word2 w2;
+	size_t offset;
+	int rc;
+
+	/* Initialize the SA */
+	roc_ow_ipsec_outb_sa_init(sa);
+
+	w2.u64 = 0;
+	rc = ow_ipsec_sa_common_param_fill(&w2, sa->cipher_key, sa->iv.s.salt, sa->hmac_opad_ipad,
+					   ipsec_xfrm, crypto_xfrm);
+	if (rc)
+		return rc;
+
+	/* Update common word2 data */
+	sa->w2.u64 = w2.u64;
+
+	if (ipsec_xfrm->mode != RTE_SECURITY_IPSEC_SA_MODE_TUNNEL)
+		goto skip_tunnel_info;
+
+	/* Tunnel header info */
+	switch (tunnel->type) {
+	case RTE_SECURITY_IPSEC_TUNNEL_IPV4:
+		sa->w2.s.outer_ip_ver = ROC_IE_SA_IP_VERSION_4;
+		memcpy(&sa->outer_hdr.ipv4.src_addr, &tunnel->ipv4.src_ip, sizeof(struct in_addr));
+		memcpy(&sa->outer_hdr.ipv4.dst_addr, &tunnel->ipv4.dst_ip, sizeof(struct in_addr));
+
+		/* IP Source and Dest seems to be in LE/CPU endian */
+		sa->outer_hdr.ipv4.src_addr = rte_be_to_cpu_32(sa->outer_hdr.ipv4.src_addr);
+		sa->outer_hdr.ipv4.dst_addr = rte_be_to_cpu_32(sa->outer_hdr.ipv4.dst_addr);
+
+		/* Outer header DF bit source */
+		if (!ipsec_xfrm->options.copy_df) {
+			sa->w2.s.ipv4_df_src_or_ipv6_flw_lbl_src = ROC_IE_OT_SA_COPY_FROM_SA;
+			sa->w10.s.ipv4_df_or_ipv6_flw_lbl = tunnel->ipv4.df;
+		} else {
+			sa->w2.s.ipv4_df_src_or_ipv6_flw_lbl_src =
+				ROC_IE_OT_SA_COPY_FROM_INNER_IP_HDR;
+		}
+
+		/* Outer header DSCP source */
+		if (!ipsec_xfrm->options.copy_dscp) {
+			sa->w2.s.dscp_src = ROC_IE_OT_SA_COPY_FROM_SA;
+			sa->w10.s.dscp = tunnel->ipv4.dscp;
+		} else {
+			sa->w2.s.dscp_src = ROC_IE_OT_SA_COPY_FROM_INNER_IP_HDR;
+		}
+		break;
+	case RTE_SECURITY_IPSEC_TUNNEL_IPV6:
+		sa->w2.s.outer_ip_ver = ROC_IE_SA_IP_VERSION_6;
+		memcpy(&sa->outer_hdr.ipv6.src_addr, &tunnel->ipv6.src_addr,
+		       sizeof(struct in6_addr));
+		memcpy(&sa->outer_hdr.ipv6.dst_addr, &tunnel->ipv6.dst_addr,
+		       sizeof(struct in6_addr));
+
+		/* IP Source and Dest are in LE/CPU endian */
+		ow_ipsec_update_ipv6_addr_endianness((uint64_t *)&sa->outer_hdr.ipv6.src_addr);
+		ow_ipsec_update_ipv6_addr_endianness((uint64_t *)&sa->outer_hdr.ipv6.dst_addr);
+
+		/* Outer header flow label source */
+		if (!ipsec_xfrm->options.copy_flabel) {
+			sa->w2.s.ipv4_df_src_or_ipv6_flw_lbl_src = ROC_IE_OT_SA_COPY_FROM_SA;
+
+			sa->w10.s.ipv4_df_or_ipv6_flw_lbl = tunnel->ipv6.flabel;
+		} else {
+			sa->w2.s.ipv4_df_src_or_ipv6_flw_lbl_src =
+				ROC_IE_OT_SA_COPY_FROM_INNER_IP_HDR;
+		}
+
+		/* Outer header DSCP source */
+		if (!ipsec_xfrm->options.copy_dscp) {
+			sa->w2.s.dscp_src = ROC_IE_OT_SA_COPY_FROM_SA;
+			sa->w10.s.dscp = tunnel->ipv6.dscp;
+		} else {
+			sa->w2.s.dscp_src = ROC_IE_OT_SA_COPY_FROM_INNER_IP_HDR;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+skip_tunnel_info:
+	/* ESN */
+	sa->w0.s.esn_en = !!ipsec_xfrm->options.esn;
+
+	if (ipsec_xfrm->esn.value)
+		sa->ctx.esn_val = ipsec_xfrm->esn.value - 1;
+
+	if (ipsec_xfrm->options.udp_encap) {
+		if (ipsec_xfrm->udp.sport)
+			sport = ipsec_xfrm->udp.sport;
+
+		if (ipsec_xfrm->udp.dport)
+			dport = ipsec_xfrm->udp.dport;
+
+		sa->w10.s.udp_src_port = sport;
+		sa->w10.s.udp_dst_port = dport;
+	}
+
+	offset = offsetof(struct roc_ow_ipsec_outb_sa, ctx);
+	/* Word offset for HW managed SA field */
+	sa->w0.s.hw_ctx_off = offset / 8;
+
+	/* Context push size is up to err ctl in HW ctx */
+	sa->w0.s.ctx_push_size = sa->w0.s.hw_ctx_off + 1;
+
+	/* Entire context size in 128B units */
+	offset = sizeof(struct roc_ow_ipsec_outb_sa);
+	sa->w0.s.ctx_size = (PLT_ALIGN_CEIL(offset, ROC_CTX_UNIT_128B) / ROC_CTX_UNIT_128B) - 1;
+
+	/* IPID gen */
+	sa->w2.s.ipid_gen = 1;
+
+	/**
+	 * CPT MC triggers expiry when counter value changes from 2 to 1. To
+	 * mitigate this behaviour add 1 to the life counter values provided.
+	 */
+
+	if (ipsec_xfrm->life.bytes_soft_limit) {
+		sa->ctx.soft_life = ipsec_xfrm->life.bytes_soft_limit + 1;
+		sa->w0.s.soft_life_dec = 1;
+	}
+
+	if (ipsec_xfrm->life.packets_soft_limit) {
+		sa->ctx.soft_life = ipsec_xfrm->life.packets_soft_limit + 1;
+		sa->w0.s.soft_life_dec = 1;
+	}
+
+	if (ipsec_xfrm->life.bytes_hard_limit) {
+		sa->ctx.hard_life = ipsec_xfrm->life.bytes_hard_limit + 1;
+		sa->w0.s.hard_life_dec = 1;
+	}
+
+	if (ipsec_xfrm->life.packets_hard_limit) {
+		sa->ctx.hard_life = ipsec_xfrm->life.packets_hard_limit + 1;
+		sa->w0.s.hard_life_dec = 1;
+	}
+
+	/* There are two words of CPT_CTX_HW_S for ucode to skip */
+	sa->w0.s.ctx_hdr_size = 1;
+	sa->w0.s.aop_valid = 1;
+
+	rte_wmb();
+
+	/* Enable SA */
+	sa->w2.s.valid = 1;
+	return 0;
+}
diff --git a/drivers/common/cnxk/cnxk_security.h b/drivers/common/cnxk/cnxk_security.h
index 8ede6c88a3..e324fa2cb9 100644
--- a/drivers/common/cnxk/cnxk_security.h
+++ b/drivers/common/cnxk/cnxk_security.h
@@ -10,6 +10,7 @@
 #include "roc_cpt.h"
 #include "roc_ie_on.h"
 #include "roc_ie_ot.h"
+#include "roc_ie_ow.h"
 
 /* Response length calculation data */
 struct cnxk_ipsec_outb_rlens {
@@ -36,7 +37,7 @@ uint8_t __roc_api
 cnxk_ipsec_outb_roundup_byte(enum rte_crypto_cipher_algorithm c_algo,
 			     enum rte_crypto_aead_algorithm aead_algo);
 
-/* [CN10K, .) */
+/* [CN10K] */
 int __roc_api
 cnxk_ot_ipsec_inb_sa_fill(struct roc_ot_ipsec_inb_sa *sa,
 			  struct rte_security_ipsec_xform *ipsec_xfrm,
@@ -56,4 +57,13 @@ int __roc_api cnxk_on_ipsec_inb_sa_create(struct rte_security_ipsec_xform *ipsec
 int __roc_api cnxk_on_ipsec_outb_sa_create(struct rte_security_ipsec_xform *ipsec,
 					   struct rte_crypto_sym_xform *crypto_xform,
 					   struct roc_ie_on_outb_sa *out_sa);
+/* [CN20K, .) */
+int __roc_api cnxk_ow_ipsec_inb_sa_fill(struct roc_ow_ipsec_inb_sa *sa,
+					struct rte_security_ipsec_xform *ipsec_xfrm,
+					struct rte_crypto_sym_xform *crypto_xfrm);
+int __roc_api cnxk_ow_ipsec_outb_sa_fill(struct roc_ow_ipsec_outb_sa *sa,
+					 struct rte_security_ipsec_xform *ipsec_xfrm,
+					 struct rte_crypto_sym_xform *crypto_xfrm);
+bool __roc_api cnxk_ow_ipsec_inb_sa_valid(struct roc_ow_ipsec_inb_sa *sa);
+bool __roc_api cnxk_ow_ipsec_outb_sa_valid(struct roc_ow_ipsec_outb_sa *sa);
 #endif /* _CNXK_SECURITY_H__ */
diff --git a/drivers/common/cnxk/version.map b/drivers/common/cnxk/version.map
index 8df34c0a9e..95488d5284 100644
--- a/drivers/common/cnxk/version.map
+++ b/drivers/common/cnxk/version.map
@@ -23,6 +23,8 @@ INTERNAL {
 	cnxk_ot_ipsec_outb_sa_fill;
 	cnxk_ot_ipsec_inb_sa_valid;
 	cnxk_ot_ipsec_outb_sa_valid;
+	cnxk_ow_ipsec_inb_sa_fill;
+	cnxk_ow_ipsec_outb_sa_fill;
 	cnxk_on_ipsec_inb_sa_create;
 	cnxk_on_ipsec_outb_sa_create;
 	roc_ae_ec_grp_get;
-- 
2.34.1

