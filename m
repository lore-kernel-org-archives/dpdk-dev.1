Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4D5CD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 07:34:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23EE742EE7;
	Thu, 11 Jun 2026 09:34:01 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4530C42EDB
 for <dev@dpdk.org>; Thu, 11 Jun 2026 09:33:59 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B0R2D21253872 for <dev@dpdk.org>; Thu, 11 Jun 2026 00:33:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=e
 aXkoRByyESafOl08sGzO4KfCZEUw71ih+IZor2ttkg=; b=BmOpmYmXuOkt0ggr6
 umh9dAkX/yzfT7g2OThVEEzP4d56zSTbdlQ7Qpd2dNDyYzRRAmlwJjLylKoEyzax
 m9qh2t6ojDFJCS0jLF2V7MVzIPGZ7qRq0iwu5w0Da7+f3ZWTKfiMu9X3FMtXRzGg
 /NnQyCEsQSVXgwIjg/4HNN7C/Bg5I0cuTr43N3xCGi4QghDXjGgESGruyIJW477s
 J362GX6s/ccaFGpVg4Yvvfu3cTpBMzJShQoAezr/4kJEPC0CFPQOy6seQ2GAfnn2
 lxzR4XMTjNIoOA/tBMuG2vxT+kWmUgthVlqTsK08Lnki9TsoQJIaby1fbN8gJOsc
 WZFmA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5vswr5-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 00:33:58 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 00:33:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 00:33:56 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 392845B6973;
 Thu, 11 Jun 2026 00:33:53 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>
Subject: [PATCH 07/17] drivers: add support for devargs skip size
Date: Thu, 11 Jun 2026 13:03:01 +0530
Message-ID: <20260611073311.3129711-7-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611073311.3129711-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfXy5M0JzvEAbNf
 eVK7MOy9vvc40PksSnh0k7azq7VMCBLblOS4CpAXdDBVty3scIo3AMXVRDUj4+RoDQJSJO9au2h
 sqEl/39W48I77u0RdktAKSD1pvena2A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfXx7ljLnrUSKkL
 FF6cJpkbwQIiaIRqZ9W3vyUk5McMvhC1tg0RuUFOPd2j5oLBIN2Lhd86T71pAh4yKhdJ2Jcl4il
 n5MMi1VwUWLXHI+vC4gyjoDdpzIlooEBFxjtID4RHvbaAGM5CzZSUSjKGTfaXG12MsF8ZPY9Kcw
 0bx6sJYEjl2AzqrQ1135hIugWqC4Pd4W+Wk7HPSYcD6oGh3NatXjp+iVWdk2upg33rMN5oV5Kdu
 R3JyGtnDTWi68Pi5VnF5Av0cnPxLeN4HNarSuyepbBuYPok7U7wkml1/SSn7B32esfq1wqxOJNQ
 5z3KQyiRG6WhhL0PYwz7U8uYYCMlfoTwxXgKxvus3sx+Yim7svuoIlL4ak+SOYnqNBqcOXx6Egx
 eLSAA14HyDGf5xHOdxm1HtO3SWSmvQ05E+vvsd7Otjyzs9OvBch2CB9Smw5+C37dyEjmB8CXST7
 IVzTUrbPEnPqQyNxHCg==
X-Authority-Analysis: v=2.4 cv=UPDt2ify c=1 sm=1 tr=0 ts=6a2a64e6 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=2YtHqsP3R5qAAzF3K54A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: BGYKXcLGAF8V7f7GbnfdrRNNhdaiIsgp
X-Proofpoint-GUID: BGYKXcLGAF8V7f7GbnfdrRNNhdaiIsgp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
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

From: Kiran Kumar K <kirankumark@marvell.com>

Adding support for devargs skip_size to cnxk driver.
This allows users to specify the number of bytes to skip in the packet
parsing before L2.

Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
---
 doc/guides/nics/cnxk.rst                      | 19 +++++++-
 drivers/common/cnxk/roc_mbox.h                | 12 ++++-
 drivers/common/cnxk/roc_nix.h                 | 14 ++----
 drivers/common/cnxk/roc_nix_ops.c             | 46 +++++++++++++++++--
 drivers/common/cnxk/roc_npc.c                 | 44 +++++++++++++++++-
 drivers/common/cnxk/roc_npc.h                 |  2 +
 drivers/common/cnxk/roc_npc_priv.h            | 11 +++++
 .../common/cnxk/roc_platform_base_symbols.c   |  1 +
 drivers/net/cnxk/cnxk_eswitch.c               |  2 +-
 drivers/net/cnxk/cnxk_ethdev.c                |  7 ++-
 drivers/net/cnxk/cnxk_ethdev_devargs.c        | 29 +++++++++++-
 11 files changed, 163 insertions(+), 24 deletions(-)

diff --git a/doc/guides/nics/cnxk.rst b/doc/guides/nics/cnxk.rst
index b5bd50ceea..239ebcd05c 100644
--- a/doc/guides/nics/cnxk.rst
+++ b/doc/guides/nics/cnxk.rst
@@ -183,8 +183,8 @@ Runtime Config Options
 
    With the above configuration, higig2 will be enabled on that port and the
    traffic on this port should be higig2 traffic only. Supported switch header
-   types are "chlen24b", "chlen90b", "dsa", "exdsa", "higig2", "vlan_exdsa" and
-   "pre_l2".
+   types are "chlen24b", "chlen90b", "dsa", "exdsa", "higig2", "vlan_exdsa",
+   "pre_l2" and "skip_size".
 
 - ``Flow pre_l2 info`` (default ``0x0/0x0/0x0``)
 
@@ -212,6 +212,21 @@ Runtime Config Options
    is 0 (i.e., left shift) then the shift count will be 1, that is, (8 - n),
    where n is the absolute position of leftmost set bit.
 
+- ``Skip size info`` (default ``0x0``)
+
+   When the switch header type is set to "skip_size", the number of bytes to
+   skip before the Ethernet header can be configured using ``skip_size_info``
+   ``devargs`` parameter. The value is in hexadecimal format and the valid
+   range is 0x0 to 0xff. This configures the PKIND so that the NPC parser
+   skips the specified number of bytes.
+
+   For example::
+
+      -a 0002:02:00.0,switch_header="skip_size",skip_size_info=0x2
+
+   With the above configuration, 2 bytes will be skipped before the Ethernet
+   header when parsing the incoming packets.
+
 - ``RSS tag as XOR`` (default ``0``)
 
    The HW gives two options to configure the RSS adder i.e
diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index e31abf2234..1158ff50a7 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -462,8 +462,11 @@ struct ready_msg_rsp {
 };
 
 enum npc_pkind_type {
+	NPC_RX_SKIP_SIZE_PKIND = 46ULL,
+	NPC_RX_CPT_SKIP_SIZE_PKIND = 50ULL,
+	NPC_RX_CPT_HDR_PTP_PKIND = 54ULL,
 	NPC_RX_CUSTOM_PRE_L2_PKIND = 55ULL,
-	NPC_RX_VLAN_EXDSA_PKIND = 56ULL,
+	NPC_RX_VLAN_EXDSA_PKIND,
 	NPC_RX_CHLEN24B_PKIND,
 	NPC_RX_CPT_HDR_PKIND,
 	NPC_RX_CHLEN90B_PKIND,
@@ -474,6 +477,8 @@ enum npc_pkind_type {
 	NPC_TX_DEF_PKIND,
 };
 
+#define NPC_SKIP_SIZE_PKIND_MAX 4
+
 /* Struct to set pkind */
 struct npc_set_pkind {
 	struct mbox_msghdr hdr;
@@ -484,6 +489,7 @@ struct npc_set_pkind {
 #define ROC_PRIV_FLAGS_EXDSA	  BIT_ULL(4)
 #define ROC_PRIV_FLAGS_VLAN_EXDSA BIT_ULL(5)
 #define ROC_PRIV_FLAGS_PRE_L2	  BIT_ULL(6)
+#define ROC_PRIV_FLAGS_SKIP_SIZE  BIT_ULL(7)
 #define ROC_PRIV_FLAGS_CUSTOM	  BIT_ULL(63)
 	uint64_t __io mode;
 #define PKIND_TX BIT_ULL(0)
@@ -499,6 +505,10 @@ struct npc_set_pkind {
 	/* Shift direction to get length of the
 	 * header at var_len_off
 	 */
+	uint8_t __io skip_size;
+	/* Number of bytes to skip before the Ethernet header.
+	 * Valid only in case custom flag.
+	 */
 };
 
 /* Structure for requesting resource provisioning.
diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index 8ba8b3e0b6..49ede85f9a 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -990,18 +990,14 @@ int __roc_api roc_nix_mac_stats_reset(struct roc_nix *roc_nix);
 int __roc_api roc_nix_mac_fwdata_get(struct roc_nix *roc_nix, struct roc_nix_mac_fwdata *fwdata);
 
 /* Ops */
-int __roc_api roc_nix_switch_hdr_set(struct roc_nix *roc_nix,
-				     uint64_t switch_header_type,
-				     uint8_t pre_l2_size_offset,
-				     uint8_t pre_l2_size_offset_mask,
-				     uint8_t pre_l2_size_shift_dir);
+int __roc_api roc_nix_switch_hdr_set(struct roc_nix *roc_nix, uint64_t switch_header_type,
+				     uint8_t pre_l2_size_offset, uint8_t pre_l2_size_offset_mask,
+				     uint8_t pre_l2_size_shift_dir, uint8_t skip_size);
 int __roc_api roc_nix_lso_fmt_setup(struct roc_nix *roc_nix);
-int __roc_api roc_nix_lso_fmt_get(struct roc_nix *roc_nix,
-				  uint8_t udp_tun[ROC_NIX_LSO_TUN_MAX],
+int __roc_api roc_nix_lso_fmt_get(struct roc_nix *roc_nix, uint8_t udp_tun[ROC_NIX_LSO_TUN_MAX],
 				  uint8_t tun[ROC_NIX_LSO_TUN_MAX]);
 int __roc_api roc_nix_lso_fmt_ipv4_frag_get(struct roc_nix *roc_nix);
-int __roc_api roc_nix_lso_custom_fmt_setup(struct roc_nix *roc_nix,
-					   struct nix_lso_format *fields,
+int __roc_api roc_nix_lso_custom_fmt_setup(struct roc_nix *roc_nix, struct nix_lso_format *fields,
 					   uint16_t nb_fields);
 int __roc_api roc_nix_lso_alt_flags_profile_setup(struct roc_nix *roc_nix,
 						  nix_lso_alt_flg_format_t *fmt);
diff --git a/drivers/common/cnxk/roc_nix_ops.c b/drivers/common/cnxk/roc_nix_ops.c
index 4653bb2049..13a548216b 100644
--- a/drivers/common/cnxk/roc_nix_ops.c
+++ b/drivers/common/cnxk/roc_nix_ops.c
@@ -501,17 +501,49 @@ roc_nix_lso_fmt_get(struct roc_nix *roc_nix,
 	return 0;
 }
 
+static int
+skip_size_pkind_get(uint8_t skip_size, uint8_t *pkind)
+{
+	struct skip_size_pkind_cfg *cfg;
+	const struct plt_memzone *mz;
+	int i;
+
+	mz = plt_memzone_lookup(SKIP_SIZE_PKIND_MEMZONE);
+	if (!mz)
+		return -ENOMEM;
+	cfg = mz->addr;
+
+	for (i = 0; i < cfg->count; i++) {
+		if (cfg->entries[i].skip_size == skip_size) {
+			*pkind = cfg->entries[i].pkind;
+			return 0;
+		}
+	}
+
+	if (cfg->count >= NPC_SKIP_SIZE_PKIND_MAX) {
+		plt_err("skip_size PKIND limit (%d) reached", NPC_SKIP_SIZE_PKIND_MAX);
+		return -ENOSPC;
+	}
+
+	i = cfg->count;
+	cfg->entries[i].skip_size = skip_size;
+	cfg->entries[i].pkind = NPC_RX_SKIP_SIZE_PKIND + i;
+	*pkind = cfg->entries[i].pkind;
+	cfg->count++;
+	return 0;
+}
+
 int
 roc_nix_switch_hdr_set(struct roc_nix *roc_nix, uint64_t switch_header_type,
-		       uint8_t pre_l2_size_offset,
-		       uint8_t pre_l2_size_offset_mask,
-		       uint8_t pre_l2_size_shift_dir)
+		       uint8_t pre_l2_size_offset, uint8_t pre_l2_size_offset_mask,
+		       uint8_t pre_l2_size_shift_dir, uint8_t skip_size)
 {
 	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
 	struct dev *dev = &nix->dev;
 	struct mbox *mbox = mbox_get(dev->mbox);
 	struct npc_set_pkind *req;
 	struct msg_resp *rsp;
+	uint8_t pkind = 0;
 	int rc = -ENOSPC;
 
 	if (switch_header_type == 0)
@@ -524,6 +556,7 @@ roc_nix_switch_hdr_set(struct roc_nix *roc_nix, uint64_t switch_header_type,
 	    switch_header_type != ROC_PRIV_FLAGS_EXDSA &&
 	    switch_header_type != ROC_PRIV_FLAGS_VLAN_EXDSA &&
 	    switch_header_type != ROC_PRIV_FLAGS_PRE_L2 &&
+	    switch_header_type != ROC_PRIV_FLAGS_SKIP_SIZE &&
 	    switch_header_type != ROC_PRIV_FLAGS_CUSTOM) {
 		plt_err("switch header type is not supported");
 		rc = NIX_ERR_PARAM;
@@ -564,6 +597,13 @@ roc_nix_switch_hdr_set(struct roc_nix *roc_nix, uint64_t switch_header_type,
 		req->var_len_off = pre_l2_size_offset;
 		req->var_len_off_mask = pre_l2_size_offset_mask;
 		req->shift_dir = pre_l2_size_shift_dir;
+	} else if (switch_header_type == ROC_PRIV_FLAGS_SKIP_SIZE) {
+		rc = skip_size_pkind_get(skip_size, &pkind);
+		if (rc)
+			goto exit;
+		req->mode = ROC_PRIV_FLAGS_CUSTOM;
+		req->pkind = pkind;
+		req->skip_size = skip_size;
 	}
 
 	req->dir = PKIND_RX;
diff --git a/drivers/common/cnxk/roc_npc.c b/drivers/common/cnxk/roc_npc.c
index a906fe0413..111ad0e8bb 100644
--- a/drivers/common/cnxk/roc_npc.c
+++ b/drivers/common/cnxk/roc_npc.c
@@ -420,6 +420,16 @@ roc_npc_init(struct roc_npc *roc_npc)
 
 	roc_npc->flow_age.age_flow_refcnt = 0;
 
+	/* Create skip-size PKIND memzone if it doesn't exist */
+	if (!plt_memzone_lookup(SKIP_SIZE_PKIND_MEMZONE)) {
+		const struct plt_memzone *mz;
+
+		mz = plt_memzone_reserve_cache_align(SKIP_SIZE_PKIND_MEMZONE,
+						     sizeof(struct skip_size_pkind_cfg));
+		if (mz != NULL)
+			memset(mz->addr, 0, sizeof(struct skip_size_pkind_cfg));
+	}
+
 	return rc;
 
 done:
@@ -457,12 +467,42 @@ roc_npc_fini(struct roc_npc *roc_npc)
 		npc->prio_flow_list = NULL;
 	}
 
+	{
+		const struct plt_memzone *mz;
+
+		mz = plt_memzone_lookup(SKIP_SIZE_PKIND_MEMZONE);
+		if (mz)
+			plt_memzone_free(mz);
+	}
+
 	return 0;
 }
 
 int
-roc_npc_validate_portid_action(struct roc_npc *roc_npc_src,
-			       struct roc_npc *roc_npc_dst)
+roc_npc_skip_size_pkind_get(struct roc_npc *roc_npc)
+{
+	struct skip_size_pkind_cfg *cfg;
+	const struct plt_memzone *mz;
+	int i;
+
+	if (roc_npc->switch_header_type != ROC_PRIV_FLAGS_SKIP_SIZE)
+		return -1;
+
+	mz = plt_memzone_lookup(SKIP_SIZE_PKIND_MEMZONE);
+	if (!mz)
+		return -1;
+	cfg = mz->addr;
+
+	for (i = 0; i < cfg->count; i++) {
+		if (cfg->entries[i].skip_size == roc_npc->skip_size)
+			return cfg->entries[i].pkind + NPC_SKIP_SIZE_PKIND_MAX;
+	}
+
+	return -1;
+}
+
+int
+roc_npc_validate_portid_action(struct roc_npc *roc_npc_src, struct roc_npc *roc_npc_dst)
 {
 	struct roc_nix *roc_nix_src = roc_npc_src->roc_nix;
 	struct nix *nix_src = roc_nix_to_nix_priv(roc_nix_src);
diff --git a/drivers/common/cnxk/roc_npc.h b/drivers/common/cnxk/roc_npc.h
index 130990bda7..a7254f35ca 100644
--- a/drivers/common/cnxk/roc_npc.h
+++ b/drivers/common/cnxk/roc_npc.h
@@ -423,6 +423,7 @@ struct roc_npc {
 					  */
 	uint8_t pre_l2_size_shift_dir;	 /**< Shift direction to calculate size
 					  */
+	uint8_t skip_size;		 /**< Switch header skip size */
 	uint16_t flow_prealloc_size;
 	uint16_t flow_max_priority;
 	uint16_t channel;
@@ -506,4 +507,5 @@ void __roc_api roc_npc_sdp_channel_get(struct roc_npc *roc_npc, uint16_t *chan_b
 				       uint16_t *chan_mask);
 int __roc_api roc_npc_mcam_get_stats(struct roc_npc *roc_npc, struct roc_npc_flow *flow,
 				     uint64_t *count);
+int __roc_api roc_npc_skip_size_pkind_get(struct roc_npc *roc_npc);
 #endif /* _ROC_NPC_H_ */
diff --git a/drivers/common/cnxk/roc_npc_priv.h b/drivers/common/cnxk/roc_npc_priv.h
index f8f4489f06..6a27f0e0fa 100644
--- a/drivers/common/cnxk/roc_npc_priv.h
+++ b/drivers/common/cnxk/roc_npc_priv.h
@@ -554,4 +554,15 @@ int npc_aging_ctrl_thread_create(struct roc_npc *roc_npc, const struct roc_npc_a
 				 struct roc_npc_flow *flow);
 void npc_aging_ctrl_thread_destroy(struct roc_npc *roc_npc);
 int npc_rss_free_grp_get(struct npc *npc, uint32_t *pos);
+
+#define SKIP_SIZE_PKIND_MEMZONE "roc_skip_size_pkind_cfg"
+
+struct skip_size_pkind_cfg {
+	uint8_t count;
+	struct {
+		uint8_t skip_size;
+		uint8_t pkind;
+	} entries[NPC_SKIP_SIZE_PKIND_MAX];
+};
+
 #endif /* _ROC_NPC_PRIV_H_ */
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index ed34d4b05b..d1c9f2304d 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -492,6 +492,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_fini)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_validate_portid_action)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_parse)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_sdp_channel_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_skip_size_pkind_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_create)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_destroy)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_dump)
diff --git a/drivers/net/cnxk/cnxk_eswitch.c b/drivers/net/cnxk/cnxk_eswitch.c
index e45c7dfd07..7e717a2fbf 100644
--- a/drivers/net/cnxk/cnxk_eswitch.c
+++ b/drivers/net/cnxk/cnxk_eswitch.c
@@ -553,7 +553,7 @@ nix_lf_setup(struct cnxk_eswitch_dev *eswitch_dev)
 		goto free_cqs;
 	}
 
-	rc = roc_nix_switch_hdr_set(nix, 0, 0, 0, 0);
+	rc = roc_nix_switch_hdr_set(nix, 0, 0, 0, 0, 0);
 	if (rc) {
 		plt_err("switch hdr set failed = %s(%d)", roc_error_msg_get(rc), rc);
 		goto free_cqs;
diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index c782dc51a8..a21e170229 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -1639,10 +1639,9 @@ cnxk_nix_configure(struct rte_eth_dev *eth_dev)
 		goto free_nix_lf;
 	}
 
-	rc = roc_nix_switch_hdr_set(nix, dev->npc.switch_header_type,
-				    dev->npc.pre_l2_size_offset,
+	rc = roc_nix_switch_hdr_set(nix, dev->npc.switch_header_type, dev->npc.pre_l2_size_offset,
 				    dev->npc.pre_l2_size_offset_mask,
-				    dev->npc.pre_l2_size_shift_dir);
+				    dev->npc.pre_l2_size_shift_dir, dev->npc.skip_size);
 	if (rc) {
 		plt_err("Failed to enable switch type nix_lf rc=%d", rc);
 		goto free_nix_lf;
@@ -2364,7 +2363,7 @@ cnxk_eth_dev_uninit(struct rte_eth_dev *eth_dev, bool reset)
 		return 0;
 
 	/* Disable switch hdr pkind */
-	roc_nix_switch_hdr_set(&dev->nix, 0, 0, 0, 0);
+	roc_nix_switch_hdr_set(&dev->nix, 0, 0, 0, 0, 0);
 
 	/* Clear the flag since we are closing down */
 	dev->configured = 0;
diff --git a/drivers/net/cnxk/cnxk_ethdev_devargs.c b/drivers/net/cnxk/cnxk_ethdev_devargs.c
index da8fc83f9d..ea18090919 100644
--- a/drivers/net/cnxk/cnxk_ethdev_devargs.c
+++ b/drivers/net/cnxk/cnxk_ethdev_devargs.c
@@ -239,6 +239,25 @@ parse_switch_header_type(const char *key, const char *value, void *extra_args)
 	if (strcmp(value, "pre_l2") == 0)
 		*(uint16_t *)extra_args = ROC_PRIV_FLAGS_PRE_L2;
 
+	if (strcmp(value, "skip_size") == 0)
+		*(uint16_t *)extra_args = ROC_PRIV_FLAGS_SKIP_SIZE;
+
+	return 0;
+}
+
+static int
+parse_skip_size_info(const char *key, const char *value, void *extra_args)
+{
+	RTE_SET_USED(key);
+	uint32_t val;
+
+	errno = 0;
+	val = strtoul(value, NULL, 0);
+	if (errno || val > 255)
+		return -EINVAL;
+
+	*(uint16_t *)extra_args = val;
+
 	return 0;
 }
 
@@ -303,6 +322,7 @@ parse_val_u16(const char *key, const char *value, void *extra_args)
 #define CNXK_FORCE_TAIL_DROP	  "force_tail_drop"
 #define CNXK_DIS_XQE_DROP	  "disable_xqe_drop"
 #define CNXK_RXC_STEP		  "rxc_step"
+#define CNXK_SKIP_SIZE_INFO	  "skip_size_info"
 
 int
 cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
@@ -317,6 +337,7 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 	uint16_t custom_meta_aura_dis = 0;
 	uint16_t flow_prealloc_size = 1;
 	uint16_t switch_header_type = 0;
+	uint16_t skip_size_info = 0;
 	uint16_t flow_max_priority = 3;
 	uint16_t outb_nb_crypto_qs = 1;
 	uint32_t ipsec_in_min_spi = 0;
@@ -392,6 +413,8 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 	rte_kvargs_process(kvlist, CNXK_FORCE_TAIL_DROP, &parse_flag, &force_tail_drop);
 	rte_kvargs_process(kvlist, CNXK_DIS_XQE_DROP, &parse_flag, &dis_xqe_drop);
 	rte_kvargs_process(kvlist, CNXK_RXC_STEP, &parse_rxc_step, &rxc_step);
+	rte_kvargs_process(kvlist, CNXK_SKIP_SIZE_INFO, &parse_skip_size_info,
+			   &skip_size_info);
 	rte_kvargs_free(kvlist);
 
 null_devargs:
@@ -424,6 +447,7 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 		dev->npc.flow_max_priority = flow_max_priority;
 
 	dev->npc.switch_header_type = switch_header_type;
+	dev->npc.skip_size = skip_size_info;
 	dev->npc.sdp_channel = sdp_chan.channel;
 	dev->npc.sdp_channel_mask = sdp_chan.mask;
 	dev->npc.is_sdp_mask_set = sdp_chan.is_sdp_mask_set;
@@ -448,7 +472,7 @@ RTE_PMD_REGISTER_PARAM_STRING(net_cnxk,
 			      CNXK_MAX_SQB_COUNT "=<8-512>"
 			      CNXK_FLOW_PREALLOC_SIZE "=<1-32>"
 			      CNXK_FLOW_MAX_PRIORITY "=<1-32>"
-			      CNXK_SWITCH_HEADER_TYPE "=<higig2|dsa|chlen90b>"
+			      CNXK_SWITCH_HEADER_TYPE "=<higig2|dsa|chlen90b|skip_size>"
 			      CNXK_RSS_TAG_AS_XOR "=1"
 			      CNXK_IPSEC_IN_MAX_SPI "=<1-65535>"
 			      CNXK_OUTB_NB_DESC "=<1-65535>"
@@ -463,4 +487,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_cnxk,
 			      CNXK_CUSTOM_META_AURA_DIS "=1"
 			      CNXK_FORCE_TAIL_DROP "=1"
 			      CNXK_DIS_XQE_DROP "=1"
-			      CNXK_RXC_STEP "=<0-1048575>");
+			      CNXK_RXC_STEP "=<0-1048575>"
+			      CNXK_SKIP_SIZE_INFO "=<0x0-0xff>");
-- 
2.34.1

