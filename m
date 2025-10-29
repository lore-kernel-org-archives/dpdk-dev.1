Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF8ECCF9EE
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 13:01:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C784E4064C;
	Wed, 29 Oct 2025 14:00:49 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9E5034064F
 for <dev@dpdk.org>; Wed, 29 Oct 2025 14:00:45 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59TCfX7T3884952 for <dev@dpdk.org>; Wed, 29 Oct 2025 06:00:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=G
 SPt6TmTwPKQRUxef1JuiMECfEHOdPKaH0Q7N8PFGTA=; b=HuABWluElG+f998nd
 xN7zn+u2i+uvEbxXI4IsIKlgh9hanT+Ed14b+v9s33Zyf5IzwuqI+yzF6Osy2LJ5
 TJqp7VG++jyORXg1wMd8awRRA6YQ0AdlBoarMA0ZQP6JevYk12zE92yugNxIDAHj
 8JVnxTnlZ2k+ZQsMZr6QUtnFWTfJO/VHFdJFfURlnWx97Tafr+BKa2+DhM09MI8T
 7pu1oNhv7bFi2oSJkbVZh64y3gdD8RfwYNLKRLVXDBCnMK33OPCb++TeouqOltVf
 UmukD8CLYwdfJJnY2j0ZCSoMhboL8PRQJGxaC950PWObbuLk16be6b0aHbQ0a6R5
 mteiQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a348ma823-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 29 Oct 2025 06:00:44 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 29 Oct 2025 06:00:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 29 Oct 2025 06:00:53 -0700
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id 2863C3F70CC;
 Wed, 29 Oct 2025 06:00:40 -0700 (PDT)
From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH v2 5/5] net/cnxk: enable CPT CQ for outbound traffic
Date: Wed, 29 Oct 2025 18:30:23 +0530
Message-ID: <20251029130023.1637177-5-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251029130023.1637177-1-rkudurumalla@marvell.com>
References: <20251006051402.1387576-1-rkudurumalla@marvell.com>
 <20251029130023.1637177-1-rkudurumalla@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA5OSBTYWx0ZWRfX98FSj7MkO5Qf
 eA8p6jjOgcpq6Ur1ybGH4FXnSy6ZlRw55DZ6OK8YgxWc6OfPamkbu7QPYMvSuI1kYuhnkal+jwv
 RIx/Zbdg93NP3b0bbEMji1o4yGQoAbpk6/tpzy0AFh0g0/iIAlDps8Z25BggtX/zXhqYlcWPxPw
 GQ4cTtnHt4lzoHc/ZQ/MijCb4kQtMAzKma7bcbRv/vpdI/lUBvfgFDkV6+x5E2PJz1ibm3yjch8
 CUsCiiWxNCTJMb2XoRKR3NJE70b6uHKlpLcmjEEaZKKl4mhDxDPkzr7Sobk1p1deqDlKxbf1P99
 /zXnRWjIZ1L4MPdLod5uO0BD2azbSExBu6qyU3EmdCFQ0EbbWSc5enK7k1jMzhe9Po2YjVnk7Q3
 rcK0pcO0s6+dvbWKttf47EoSBgJa6A==
X-Authority-Analysis: v=2.4 cv=T/mBjvKQ c=1 sm=1 tr=0 ts=69020ffc cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=HqzhabLAShF0X3-iVbUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: xLcnHoBkuIlLFuSmMEJR2yXTQhWNvs5v
X-Proofpoint-ORIG-GUID: xLcnHoBkuIlLFuSmMEJR2yXTQhWNvs5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_05,2025-10-29_01,2025-10-01_01
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

enable CPT CQ in cpt instruction to read outbound
error packets from CQ

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 doc/guides/nics/cnxk.rst                       | 12 ++++++++++++
 drivers/common/cnxk/roc_nix_inl.c              | 18 ++++++++++++++++++
 drivers/common/cnxk/roc_nix_inl.h              |  1 +
 .../common/cnxk/roc_platform_base_symbols.c    |  1 +
 drivers/net/cnxk/cn20k_ethdev_sec.c            | 10 ++++++----
 drivers/net/cnxk/cn20k_rxtx.h                  |  2 +-
 drivers/net/cnxk/cn20k_tx.h                    | 11 +++++++----
 7 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/doc/guides/nics/cnxk.rst b/doc/guides/nics/cnxk.rst
index 667a876710..166e964a3c 100644
--- a/doc/guides/nics/cnxk.rst
+++ b/doc/guides/nics/cnxk.rst
@@ -678,6 +678,18 @@ Runtime Config Options for inline device
    With the above configuration, driver would poll for soft expiry events every
    1000 usec.
 
+- ``CPT completion queue enable for outbound expiry packet`` (default ``0``)
+
+   CPT completion queue can be enabled for outbound expiry packet processing
+   by specifying ``cpt_cq_ena`` ``devargs`` parameter.
+
+   For example::
+
+      -a 0002:1d:00.0,cpt_cq_ena=1
+
+   With the above configuration, CPT completion queue will be enabled for
+   outbound expiry packet handling on the inline device.
+
 - ``Rx Inject Enable inbound inline IPsec for second pass`` (default ``0``)
 
    Rx packet inject feature for inbound inline IPsec processing can be enabled
diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index bc63f4ee62..70ab8001e1 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -2563,3 +2563,21 @@ roc_nix_inl_custom_meta_pool_cb_register(roc_nix_inl_custom_meta_pool_cb_t cb)
 {
 	custom_meta_pool_cb = cb;
 }
+
+uint8_t
+roc_nix_inl_is_cq_ena(struct roc_nix *roc_nix)
+{
+	struct idev_cfg *idev = idev_get_cfg();
+	struct nix_inl_dev *inl_dev;
+
+	PLT_SET_USED(roc_nix);
+	if (idev != NULL) {
+		inl_dev = idev->nix_inl_dev;
+		if (inl_dev)
+			return inl_dev->cpt_cq_ena;
+		else
+			return 0;
+	} else {
+		return 0;
+	}
+}
diff --git a/drivers/common/cnxk/roc_nix_inl.h b/drivers/common/cnxk/roc_nix_inl.h
index 4bae261848..7970ac2258 100644
--- a/drivers/common/cnxk/roc_nix_inl.h
+++ b/drivers/common/cnxk/roc_nix_inl.h
@@ -213,6 +213,7 @@ int __roc_api roc_nix_inl_ctx_write(struct roc_nix *roc_nix, void *sa_dptr,
 void __roc_api roc_nix_inl_outb_cpt_lfs_dump(struct roc_nix *roc_nix, FILE *file);
 uint64_t __roc_api roc_nix_inl_eng_caps_get(struct roc_nix *roc_nix);
 void *__roc_api roc_nix_inl_dev_qptr_get(uint8_t qid);
+uint8_t __roc_api roc_nix_inl_is_cq_ena(struct roc_nix *roc_nix);
 
 enum roc_nix_cpt_lf_stats_type {
 	ROC_NIX_CPT_LF_STATS_INL_DEV,
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index e6fa3b540b..16ab37655d 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -281,6 +281,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_eng_caps_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_custom_meta_pool_cb_register)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_xaq_realloc)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_qptr_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_is_cq_ena)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_stats_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_stats_reset)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_init)
diff --git a/drivers/net/cnxk/cn20k_ethdev_sec.c b/drivers/net/cnxk/cn20k_ethdev_sec.c
index 5b0aa8a34f..fd83f64c5d 100644
--- a/drivers/net/cnxk/cn20k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn20k_ethdev_sec.c
@@ -664,6 +664,9 @@ cn20k_eth_sec_outb_sa_misc_fill(struct roc_nix *roc_nix, struct roc_ow_ipsec_out
 {
 	uint64_t *ring_base, ring_addr;
 
+	if (roc_nix_inl_is_cq_ena(roc_nix))
+		goto done;
+
 	if (ipsec_xfrm->life.bytes_soft_limit | ipsec_xfrm->life.packets_soft_limit) {
 		ring_base = roc_nix_inl_outb_ring_base_get(roc_nix);
 		if (ring_base == NULL)
@@ -674,6 +677,7 @@ cn20k_eth_sec_outb_sa_misc_fill(struct roc_nix *roc_nix, struct roc_ow_ipsec_out
 		sa->ctx.err_ctl.s.address = ring_addr >> 3;
 		sa->w0.s.ctx_id = ((uintptr_t)sa_cptr >> 51) & 0x1ff;
 	}
+done:
 	return 0;
 }
 
@@ -909,8 +913,7 @@ cn20k_eth_sec_session_create(void *device, struct rte_security_session_conf *con
 		sess_priv.chksum =
 			(!ipsec->options.ip_csum_enable << 1 | !ipsec->options.l4_csum_enable);
 		sess_priv.dec_ttl = ipsec->options.dec_ttl;
-		if (roc_feature_nix_has_inl_ipsec_mseg() && dev->outb.cpt_eng_caps & BIT_ULL(35))
-			sess_priv.nixtx_off = 1;
+		sess_priv.cpt_cq_ena = roc_nix_inl_is_cq_ena(&dev->nix);
 
 		/* Pointer from eth_sec -> outb_sa */
 		eth_sec->sa = outb_sa;
@@ -1106,9 +1109,8 @@ cn20k_eth_sec_session_update(void *device, struct rte_security_session *sess,
 		sess_priv.chksum =
 			(!ipsec->options.ip_csum_enable << 1 | !ipsec->options.l4_csum_enable);
 		sess_priv.dec_ttl = ipsec->options.dec_ttl;
-		if (roc_feature_nix_has_inl_ipsec_mseg() && dev->outb.cpt_eng_caps & BIT_ULL(35))
-			sess_priv.nixtx_off = 1;
 
+		sess_priv.cpt_cq_ena = roc_nix_inl_is_cq_ena(&dev->nix);
 		rc = roc_nix_inl_ctx_write(&dev->nix, outb_sa_dptr, eth_sec->sa, eth_sec->inb,
 					   sizeof(struct roc_ow_ipsec_outb_sa));
 		if (rc)
diff --git a/drivers/net/cnxk/cn20k_rxtx.h b/drivers/net/cnxk/cn20k_rxtx.h
index 10da42680f..5fc4f8656d 100644
--- a/drivers/net/cnxk/cn20k_rxtx.h
+++ b/drivers/net/cnxk/cn20k_rxtx.h
@@ -106,7 +106,7 @@ struct __rte_packed_begin cn20k_sec_sess_priv {
 			uint16_t partial_len : 10;
 			uint16_t chksum : 2;
 			uint16_t dec_ttl : 1;
-			uint16_t nixtx_off : 1;
+			uint16_t cpt_cq_ena : 1;
 			uint16_t rsvd : 2;
 		};
 
diff --git a/drivers/net/cnxk/cn20k_tx.h b/drivers/net/cnxk/cn20k_tx.h
index 3fb2e1f4e1..9e48744831 100644
--- a/drivers/net/cnxk/cn20k_tx.h
+++ b/drivers/net/cnxk/cn20k_tx.h
@@ -444,14 +444,15 @@ cn20k_nix_prep_sec_vec(struct rte_mbuf *m, uint64x2_t *cmd0, uint64x2_t *cmd1,
 	uint32_t pkt_len, dlen_adj, rlen;
 	uint8_t l3l4type, chksum;
 	uint64x2_t cmd01, cmd23;
+	uint64_t sa, cpt_cq_ena;
 	uint8_t l2_len, l3_len;
 	uintptr_t dptr, nixtx;
 	uint64_t ucode_cmd[4];
 	uint64_t *laddr, w0;
 	uint16_t tag;
-	uint64_t sa;
 
 	sess_priv.u64 = *rte_security_dynfield(m);
+	cpt_cq_ena = sess_priv.cpt_cq_ena;
 
 	if (flags & NIX_TX_NEED_SEND_HDR_W1) {
 		/* Extract l3l4type either from il3il4type or ol3ol4type */
@@ -530,7 +531,7 @@ cn20k_nix_prep_sec_vec(struct rte_mbuf *m, uint64x2_t *cmd0, uint64x2_t *cmd1,
 	cmd01 = vdupq_n_u64(0);
 	cmd01 = vsetq_lane_u64(w0, cmd01, 0);
 	/* CPT_RES_S is 16B above NIXTX */
-	cmd01 = vsetq_lane_u64(nixtx - 16, cmd01, 1);
+	cmd01 = vsetq_lane_u64((nixtx - 16) | cpt_cq_ena << 63, cmd01, 1);
 
 	/* Return nixtx addr */
 	*nixtx_addr = nixtx;
@@ -577,15 +578,16 @@ cn20k_nix_prep_sec(struct rte_mbuf *m, uint64_t *cmd, uintptr_t *nixtx_addr, uin
 	uint8_t l3l4type, chksum;
 	uint64x2_t cmd01, cmd23;
 	union nix_send_sg_s *sg;
+	uint64_t sa, cpt_cq_ena;
 	uint8_t l2_len, l3_len;
 	uintptr_t dptr, nixtx;
 	uint64_t ucode_cmd[4];
 	uint64_t *laddr, w0;
 	uint16_t tag;
-	uint64_t sa;
 
 	/* Move to our line from base */
 	sess_priv.u64 = *rte_security_dynfield(m);
+	cpt_cq_ena = sess_priv.cpt_cq_ena;
 	send_hdr = (struct nix_send_hdr_s *)cmd;
 	if (flags & NIX_TX_NEED_EXT_HDR)
 		sg = (union nix_send_sg_s *)&cmd[4];
@@ -668,7 +670,8 @@ cn20k_nix_prep_sec(struct rte_mbuf *m, uint64_t *cmd, uintptr_t *nixtx_addr, uin
 	cmd01 = vdupq_n_u64(0);
 	cmd01 = vsetq_lane_u64(w0, cmd01, 0);
 	/* CPT_RES_S is 16B above NIXTX */
-	cmd01 = vsetq_lane_u64(nixtx - 16, cmd01, 1);
+	/* CQ_ENA for cpt */
+	cmd01 = vsetq_lane_u64((nixtx - 16) | cpt_cq_ena << 63, cmd01, 1);
 
 	/* Return nixtx addr */
 	*nixtx_addr = nixtx;
-- 
2.25.1

