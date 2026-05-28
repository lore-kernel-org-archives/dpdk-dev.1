Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8049ECD5BD5
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 21:39:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0074140691;
	Thu, 28 May 2026 23:38:30 +0200 (CEST)
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com
 [74.125.224.52]) by mails.dpdk.org (Postfix) with ESMTP id 71C284003C
 for <dev@dpdk.org>; Thu, 28 May 2026 23:38:28 +0200 (CEST)
Received: by mail-yx1-f52.google.com with SMTP id
 956f58d0204a3-6603e24a7f9so1174444d50.2
 for <dev@dpdk.org>; Thu, 28 May 2026 14:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780004308;
 x=1780609108; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PJsIRqez42XyYu8bWkN0lRi/XW3+DGkg5li/itriZ1o=;
 b=vm8GZOnF044qSfcPdsb+3BlVHrlvZ07f9VA+FVXyIAhU1S5nkwm3OvhJkH0VDYRau4
 EImvy8TTiHwKJGM6sfC6hByLQqcpB3uX0Q6lGX54ewDvflR5bHdSx8PgZLZ29U52pprB
 WLY41BogbR9tBSz25ZaNrZuZFUFAURGCOw9VFhEsMqqtjarO9PP3akvuXAoV+tM4pLQe
 NtTCkpV0NH0hyhxSGlfBvtD0VzNfSBB4rpRANEtp37E4zlfJFyEOrwxYnOCRTQxZejYk
 yhT4Ksr/GvYxH2i9Pz5zQ81D17uULrvaYipalu8f2o0MGe6jzRRvwMxQzRPpvcTrkJLH
 MIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780004308; x=1780609108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PJsIRqez42XyYu8bWkN0lRi/XW3+DGkg5li/itriZ1o=;
 b=Pivsz7598VY1p792Vo6zH0fwrRSIlNsfX6dm4zfAdJuM7S+6hdc4EnAKb1WhYfZKIM
 fN0bKJji51kQPfvWryBk66xewz/5IpPtto7UMb3RfrOYpnvUsCiqqYdHvd88DdNo/MNp
 ngArEABT9WbNLjwALwq9frDZXDoXInZ5tQCokSAQhan/V0VFT3HFk9BJujoR6FseNNmO
 UhLeisLu8EUH/CAEqXhxUHWtkd+mgHhmDWqt8DZatwMQrusFBZFDSo7KIg+Tftst6pTs
 p5wb1S9w1cWxCWwrvu4WnxNaFPLngFS+7dtdopvArj/61dM15CD4cgj8LRvb7D5aT/N+
 JBYA==
X-Gm-Message-State: AOJu0Yw7lnwOOEP42Ksr6hkPxfYfnSNRGHXXRCXQllb0C4RPfJ51Lh33
 Rex4mW9in4h5etgMF4Z421F8Hr8r8skI1CKouRbP/SAZgZNQg+vP+SY0t53ghkEWspYwCwBMONy
 EQMJT
X-Gm-Gg: Acq92OHtl5csIBwaHWT7gHB6uGfBWxdu5Mt0naI0iwiH5ZI3TD+SRsLd76LOUdbIaTh
 enCWASSfU8qywEoSFfK8KYPqOz++mIY4zXdo5rH0zYSTiCLigu6qeOcYGxGGk2wjKi2VhVIxRoq
 V/nFhfsUWPoihfwxpeaUMmMHHrFQc61X1Uk4+8O+Sbdv5Mo59PwbYIxo9cBRlqeXTyWnkLcmsCe
 5jhBVkTadu0qBTFVUhX2FD03Y6O99W2YIzKnEvS6FEAfS4nMwHkVKSKzNKzM/a8st5lX95sYgYK
 qs92OC+PfyMqLBObqGEuEYoBEhHzeF22P4W9oSL8hsCGGieicYRc7tLMJ/t4qfAw+XnPst+GDP9
 iyMjk8vNGPgelEJJxvnAcrFGpDjO16QkWA+8BTU7Gtfqf/o+4lXueXGL/dQ1GbW4TbeAdFBBLy7
 qNzhMu8agCtiqzsFcFFX4Whz+wo8U3FBSoK//v/C9pVVTdppFFGbIp7nWj7t20N8TK1PFafPTi
X-Received: by 2002:a05:690e:1306:b0:65c:22f9:859e with SMTP id
 956f58d0204a3-6604e748cb4mr603015d50.53.1780004307565; 
 Thu, 28 May 2026 14:38:27 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6604e12ea23sm208079d50.0.2026.05.28.14.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 14:38:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [RFC 7/8] net/ixgbe: privatize legacy flow director types
Date: Thu, 28 May 2026 14:37:19 -0700
Message-ID: <20260528213816.562910-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528213816.562910-1-stephen@networkplumber.org>
References: <20260528213816.562910-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The ixgbe driver uses several legacy ethdev flow director types
(struct rte_eth_fdir_conf, enum rte_fdir_mode, and related) from
<rte_eth_ctrl.h> and <ethdev_driver.h> as its internal IR for
translating rte_flow rules into hardware programming state. These
types are scheduled for removal from ethdev in DPDK 26.11.

Clone the relevant types into ixgbe_ethdev.h with an ixgbe-private
prefix so the driver no longer depends on the legacy ABI. The
embedded rte_eth_ipv4_flow / rte_eth_ipv6_flow types are cloned
too since they live in the same removal candidate set.

enum ixgbe_fdir_pballoc_type already exists in the Intel base
driver (drivers/net/intel/ixgbe/base/ixgbe_type.h) and is reused
as-is. Its values are NONE=0, 64K=1, 128K=2, 256K=3, whereas the
ethdev enum started at 64K=0. The adapter's pballoc field was
previously zero-initialized and relied on the ethdev convention
that 0 means 64K; initialize it explicitly in eth_ixgbe_dev_init()
to preserve that behavior under the base enum.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  12 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |  95 +++++++++++++-
 drivers/net/intel/ixgbe/ixgbe_fdir.c          | 124 +++++++++---------
 drivers/net/intel/ixgbe/ixgbe_flow.c          |  28 ++--
 .../net/intel/ixgbe/ixgbe_rxtx_vec_common.c   |   4 +-
 5 files changed, 177 insertions(+), 86 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 9dc015dfff..20b7b91cc3 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -1471,6 +1471,14 @@ static int ixgbe_fdir_filter_init(struct rte_eth_dev *eth_dev)
 	/* drop queue is always fixed */
 	IXGBE_DEV_FDIR_CONF(eth_dev)->drop_queue = IXGBE_FDIR_DROP_QUEUE;
 
+	/*
+	 * Initialize pballoc to 64K. The base driver's
+	 * enum ixgbe_fdir_pballoc_type uses NONE=0, 64K=1, ... so an
+	 * uninitialized (zero) pballoc would be rejected by
+	 * configure_fdir_flags(); set it explicitly here.
+	 */
+	IXGBE_DEV_FDIR_CONF(eth_dev)->pballoc = IXGBE_FDIR_PBALLOC_64K;
+
 	return 0;
 }
 
@@ -2618,7 +2626,7 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 	struct ixgbe_adapter *adapter =
 		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
+	struct ixgbe_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	struct ixgbe_vf_info *vfinfo =
 		*IXGBE_DEV_PRIVATE_TO_P_VFDATA(dev->data->dev_private);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
@@ -2723,7 +2731,7 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 	/* Configure DCB hw */
 	ixgbe_configure_dcb(dev);
 
-	if (fdir_conf->mode != RTE_FDIR_MODE_NONE) {
+	if (fdir_conf->mode != IXGBE_FDIR_MODE_NONE) {
 		struct ixgbe_hw_fdir_info *info =
 			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
 		err = ixgbe_fdir_configure(adapter, fdir_conf, &info->mask);
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index c290f04611..2fc9f8433e 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -143,8 +143,91 @@
 					 IXGBE_LINK_SPEED_10GB_FULL)
 
 /*
- * Information about the fdir mode.
+ * Privatized flow director configuration types.
+ *
+ * These were cloned from <rte_eth_ctrl.h> and <ethdev_driver.h> so that
+ * ixgbe no longer depends on the legacy ethdev flow director ABI, which
+ * is scheduled for removal in DPDK 26.11. The semantics are unchanged;
+ * only the names are ixgbe-private.
  */
+#define IXGBE_FDIR_MAX_FLEXLEN 16  /**< Max length of flexbytes. */
+
+struct ixgbe_ipv4_flow {
+	uint32_t src_ip;
+	uint32_t dst_ip;
+	uint8_t  tos;
+	uint8_t  ttl;
+	uint8_t  proto;
+};
+
+struct ixgbe_ipv6_flow {
+	uint32_t src_ip[4];
+	uint32_t dst_ip[4];
+	uint8_t  tc;
+	uint8_t  proto;
+	uint8_t  hop_limits;
+};
+
+struct ixgbe_fdir_masks {
+	uint16_t vlan_tci_mask;
+	struct ixgbe_ipv4_flow ipv4_mask;
+	struct ixgbe_ipv6_flow ipv6_mask;
+	uint16_t src_port_mask;
+	uint16_t dst_port_mask;
+	uint8_t  mac_addr_byte_mask;
+	uint32_t tunnel_id_mask;
+	uint8_t  tunnel_type_mask;
+};
+
+enum ixgbe_payload_type {
+	IXGBE_PAYLOAD_UNKNOWN = 0,
+	IXGBE_RAW_PAYLOAD,
+	IXGBE_L2_PAYLOAD,
+	IXGBE_L3_PAYLOAD,
+	IXGBE_L4_PAYLOAD,
+	IXGBE_PAYLOAD_MAX = 8,
+};
+
+struct ixgbe_flex_payload_cfg {
+	enum ixgbe_payload_type type;
+	uint16_t src_offset[IXGBE_FDIR_MAX_FLEXLEN];
+};
+
+struct ixgbe_fdir_flex_mask {
+	uint16_t flow_type;
+	uint8_t  mask[IXGBE_FDIR_MAX_FLEXLEN];
+};
+
+struct ixgbe_fdir_flex_conf {
+	uint16_t nb_payloads;
+	uint16_t nb_flexmasks;
+	struct ixgbe_flex_payload_cfg flex_set[IXGBE_PAYLOAD_MAX];
+	struct ixgbe_fdir_flex_mask flex_mask[RTE_ETH_FLOW_MAX];
+};
+
+enum ixgbe_fdir_mode {
+	IXGBE_FDIR_MODE_NONE = 0,
+	IXGBE_FDIR_MODE_SIGNATURE,
+	IXGBE_FDIR_MODE_PERFECT,
+	IXGBE_FDIR_MODE_PERFECT_MAC_VLAN,
+	IXGBE_FDIR_MODE_PERFECT_TUNNEL,
+};
+
+enum ixgbe_fdir_status_mode {
+	IXGBE_FDIR_NO_REPORT_STATUS = 0,
+	IXGBE_FDIR_REPORT_STATUS,
+	IXGBE_FDIR_REPORT_STATUS_ALWAYS,
+};
+
+struct ixgbe_fdir_conf {
+	enum ixgbe_fdir_mode mode;
+	enum ixgbe_fdir_pballoc_type pballoc;
+	enum ixgbe_fdir_status_mode status;
+	uint8_t drop_queue;
+	struct ixgbe_fdir_masks mask;
+	struct ixgbe_fdir_flex_conf flex_conf;
+};
+
 struct ixgbe_hw_fdir_mask {
 	uint16_t vlan_tci_mask;
 	uint32_t src_ipv4_mask;
@@ -176,7 +259,7 @@ struct ixgbe_fdir_rule {
 	union ixgbe_atr_input ixgbe_fdir; /* key of fdir filter*/
 	bool b_spec; /* If TRUE, ixgbe_fdir, fdirflags, queue have meaning. */
 	bool b_mask; /* If TRUE, mask has meaning. */
-	enum rte_fdir_mode mode; /* IP, MAC VLAN, Tunnel */
+	enum ixgbe_fdir_mode mode; /* IP, MAC VLAN, Tunnel */
 	uint32_t fdirflags; /* drop or forward */
 	uint32_t soft_id; /* an unique value for this rule */
 	uint8_t queue; /* assigned rx queue */
@@ -468,7 +551,7 @@ struct ixgbe_adapter {
 	struct ixgbe_hw_stats       stats;
 	struct ixgbe_macsec_stats   macsec_stats;
 	struct ixgbe_macsec_setting	macsec_setting;
-	struct rte_eth_fdir_conf    fdir_conf;
+	struct ixgbe_fdir_conf    fdir_conf;
 	struct ixgbe_hw_fdir_info   fdir;
 	struct ixgbe_interrupt      intr;
 	struct ixgbe_stat_mapping_registers stat_mappings;
@@ -706,15 +789,15 @@ void ixgbe_filterlist_flush(struct rte_eth_dev *dev);
  * Flow director function prototypes
  */
 int ixgbe_fdir_configure(struct ixgbe_adapter *adapter,
-			 const struct rte_eth_fdir_conf *fdir_conf,
+			 const struct ixgbe_fdir_conf *fdir_conf,
 			 const struct ixgbe_hw_fdir_mask *fdir_mask);
 int ixgbe_fdir_set_input_mask(struct ixgbe_adapter *adapter,
 			      const struct ixgbe_hw_fdir_mask *mask,
-			      enum rte_fdir_mode mode);
+			      enum ixgbe_fdir_mode mode);
 int ixgbe_fdir_set_flexbytes_offset(struct ixgbe_adapter *adapter,
 				    uint16_t offset);
 int ixgbe_fdir_filter_program(struct ixgbe_adapter *adapter,
-		struct rte_eth_fdir_conf *fdir_conf,
+		struct ixgbe_fdir_conf *fdir_conf,
 		struct ixgbe_fdir_rule *rule,
 		bool del, bool update);
 void ixgbe_configure_dcb(struct rte_eth_dev *dev);
diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c b/drivers/net/intel/ixgbe/ixgbe_fdir.c
index 20cc72ffcd..69fd8c674c 100644
--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
@@ -81,23 +81,23 @@
 static int fdir_erase_filter_82599(struct ixgbe_hw *hw, uint32_t fdirhash);
 static int fdir_set_input_mask_82599(struct ixgbe_adapter *adapter,
 		const struct ixgbe_hw_fdir_mask *mask,
-		enum rte_fdir_mode mode);
+		enum ixgbe_fdir_mode mode);
 static int fdir_set_input_mask_x550(struct ixgbe_adapter *adapter,
 		const struct ixgbe_hw_fdir_mask *mask,
-		enum rte_fdir_mode mode);
+		enum ixgbe_fdir_mode mode);
 static int ixgbe_set_fdir_flex_conf(struct ixgbe_adapter *adapter,
-		const struct rte_eth_fdir_flex_conf *conf, uint32_t *fdirctrl);
+		const struct ixgbe_fdir_flex_conf *conf, uint32_t *fdirctrl);
 static int fdir_enable_82599(struct ixgbe_hw *hw, uint32_t fdirctrl);
 static uint32_t ixgbe_atr_compute_hash_82599(union ixgbe_atr_input *atr_input,
 				 uint32_t key);
 static uint32_t atr_compute_sig_hash_82599(union ixgbe_atr_input *input,
-		enum rte_eth_fdir_pballoc_type pballoc);
+		enum ixgbe_fdir_pballoc_type pballoc);
 static uint32_t atr_compute_perfect_hash_82599(union ixgbe_atr_input *input,
-		enum rte_eth_fdir_pballoc_type pballoc);
+		enum ixgbe_fdir_pballoc_type pballoc);
 static int fdir_write_perfect_filter_82599(struct ixgbe_hw *hw,
 			union ixgbe_atr_input *input, uint8_t queue,
 			uint32_t fdircmd, uint32_t fdirhash,
-			enum rte_fdir_mode mode);
+			enum ixgbe_fdir_mode mode);
 static int fdir_add_signature_filter_82599(struct ixgbe_hw *hw,
 		union ixgbe_atr_input *input, u8 queue, uint32_t fdircmd,
 		uint32_t fdirhash);
@@ -164,20 +164,20 @@ fdir_enable_82599(struct ixgbe_hw *hw, uint32_t fdirctrl)
  * flexbytes matching field, and drop queue (only for perfect matching mode).
  */
 static inline int
-configure_fdir_flags(const struct rte_eth_fdir_conf *conf, uint32_t *fdirctrl)
+configure_fdir_flags(const struct ixgbe_fdir_conf *conf, uint32_t *fdirctrl)
 {
 	*fdirctrl = 0;
 
 	switch (conf->pballoc) {
-	case RTE_ETH_FDIR_PBALLOC_64K:
+	case IXGBE_FDIR_PBALLOC_64K:
 		/* 8k - 1 signature filters */
 		*fdirctrl |= IXGBE_FDIRCTRL_PBALLOC_64K;
 		break;
-	case RTE_ETH_FDIR_PBALLOC_128K:
+	case IXGBE_FDIR_PBALLOC_128K:
 		/* 16k - 1 signature filters */
 		*fdirctrl |= IXGBE_FDIRCTRL_PBALLOC_128K;
 		break;
-	case RTE_ETH_FDIR_PBALLOC_256K:
+	case IXGBE_FDIR_PBALLOC_256K:
 		/* 32k - 1 signature filters */
 		*fdirctrl |= IXGBE_FDIRCTRL_PBALLOC_256K;
 		break;
@@ -189,14 +189,14 @@ configure_fdir_flags(const struct rte_eth_fdir_conf *conf, uint32_t *fdirctrl)
 
 	/* status flags: write hash & swindex in the rx descriptor */
 	switch (conf->status) {
-	case RTE_FDIR_NO_REPORT_STATUS:
+	case IXGBE_FDIR_NO_REPORT_STATUS:
 		/* do nothing, default mode */
 		break;
-	case RTE_FDIR_REPORT_STATUS:
+	case IXGBE_FDIR_REPORT_STATUS:
 		/* report status when the packet matches a fdir rule */
 		*fdirctrl |= IXGBE_FDIRCTRL_REPORT_STATUS;
 		break;
-	case RTE_FDIR_REPORT_STATUS_ALWAYS:
+	case IXGBE_FDIR_REPORT_STATUS_ALWAYS:
 		/* always report status */
 		*fdirctrl |= IXGBE_FDIRCTRL_REPORT_STATUS_ALWAYS;
 		break;
@@ -209,14 +209,14 @@ configure_fdir_flags(const struct rte_eth_fdir_conf *conf, uint32_t *fdirctrl)
 	*fdirctrl |= (IXGBE_DEFAULT_FLEXBYTES_OFFSET / sizeof(uint16_t)) <<
 		     IXGBE_FDIRCTRL_FLEX_SHIFT;
 
-	if (conf->mode >= RTE_FDIR_MODE_PERFECT &&
-	    conf->mode <= RTE_FDIR_MODE_PERFECT_TUNNEL) {
+	if (conf->mode >= IXGBE_FDIR_MODE_PERFECT &&
+	    conf->mode <= IXGBE_FDIR_MODE_PERFECT_TUNNEL) {
 		*fdirctrl |= IXGBE_FDIRCTRL_PERFECT_MATCH;
 		*fdirctrl |= (conf->drop_queue << IXGBE_FDIRCTRL_DROP_Q_SHIFT);
-		if (conf->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN)
+		if (conf->mode == IXGBE_FDIR_MODE_PERFECT_MAC_VLAN)
 			*fdirctrl |= (IXGBE_FDIRCTRL_FILTERMODE_MACVLAN
 					<< IXGBE_FDIRCTRL_FILTERMODE_SHIFT);
-		else if (conf->mode == RTE_FDIR_MODE_PERFECT_TUNNEL)
+		else if (conf->mode == IXGBE_FDIR_MODE_PERFECT_TUNNEL)
 			*fdirctrl |= (IXGBE_FDIRCTRL_FILTERMODE_CLOUD
 					<< IXGBE_FDIRCTRL_FILTERMODE_SHIFT);
 	}
@@ -249,12 +249,12 @@ reverse_fdir_bitmasks(uint16_t hi_dword, uint16_t lo_dword)
 
 /*
  * This references ixgbe_fdir_set_input_mask_82599() in base/ixgbe_82599.c,
- * but makes use of the rte_fdir_masks structure to see which bits to set.
+ * but makes use of the ixgbe_fdir_masks structure to see which bits to set.
  */
 static int
 fdir_set_input_mask_82599(struct ixgbe_adapter *adapter,
 		const struct ixgbe_hw_fdir_mask *mask,
-		enum rte_fdir_mode mode)
+		enum ixgbe_fdir_mode mode)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
 	/*
@@ -317,7 +317,7 @@ fdir_set_input_mask_82599(struct ixgbe_adapter *adapter,
 	reg = IXGBE_PCI_REG_ADDR(hw, IXGBE_FDIRDIP4M);
 	*reg = ~(mask->dst_ipv4_mask);
 
-	if (mode == RTE_FDIR_MODE_SIGNATURE) {
+	if (mode == IXGBE_FDIR_MODE_SIGNATURE) {
 		/*
 		 * Store source and destination IPv6 masks (bit reversed)
 		 */
@@ -332,12 +332,12 @@ fdir_set_input_mask_82599(struct ixgbe_adapter *adapter,
 
 /*
  * This references ixgbe_fdir_set_input_mask_82599() in base/ixgbe_82599.c,
- * but makes use of the rte_fdir_masks structure to see which bits to set.
+ * but makes use of the ixgbe_fdir_masks structure to see which bits to set.
  */
 static int
 fdir_set_input_mask_x550(struct ixgbe_adapter *adapter,
 		const struct ixgbe_hw_fdir_mask *mask,
-		enum rte_fdir_mode mode)
+		enum ixgbe_fdir_mode mode)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
 	/* mask VM pool and DIPv6 since there are currently not supported
@@ -351,7 +351,7 @@ fdir_set_input_mask_x550(struct ixgbe_adapter *adapter,
 	PMD_INIT_FUNC_TRACE();
 
 	/* set the default UDP port for VxLAN */
-	if (mode == RTE_FDIR_MODE_PERFECT_TUNNEL)
+	if (mode == IXGBE_FDIR_MODE_PERFECT_TUNNEL)
 		IXGBE_WRITE_REG(hw, IXGBE_VXLANCTRL, RTE_VXLAN_DEFAULT_PORT);
 
 	/* some bits must be set for mac vlan or tunnel mode */
@@ -375,11 +375,11 @@ fdir_set_input_mask_x550(struct ixgbe_adapter *adapter,
 
 	fdiripv6m = ((u32)0xFFFFU << IXGBE_FDIRIP6M_DIPM_SHIFT);
 	fdiripv6m |= IXGBE_FDIRIP6M_ALWAYS_MASK;
-	if (mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN)
+	if (mode == IXGBE_FDIR_MODE_PERFECT_MAC_VLAN)
 		fdiripv6m |= IXGBE_FDIRIP6M_TUNNEL_TYPE |
 				IXGBE_FDIRIP6M_TNI_VNI;
 
-	if (mode == RTE_FDIR_MODE_PERFECT_TUNNEL) {
+	if (mode == IXGBE_FDIR_MODE_PERFECT_TUNNEL) {
 		fdiripv6m |= IXGBE_FDIRIP6M_INNER_MAC;
 		mac_mask = mask->mac_addr_byte_mask &
 			(IXGBE_FDIRIP6M_INNER_MAC >>
@@ -428,13 +428,13 @@ fdir_set_input_mask_x550(struct ixgbe_adapter *adapter,
 int
 ixgbe_fdir_set_input_mask(struct ixgbe_adapter *adapter,
 		const struct ixgbe_hw_fdir_mask *mask,
-		enum rte_fdir_mode mode)
+		enum ixgbe_fdir_mode mode)
 {
-	if (mode >= RTE_FDIR_MODE_SIGNATURE &&
-	    mode <= RTE_FDIR_MODE_PERFECT)
+	if (mode >= IXGBE_FDIR_MODE_SIGNATURE &&
+	    mode <= IXGBE_FDIR_MODE_PERFECT)
 		return fdir_set_input_mask_82599(adapter, mask, mode);
-	else if (mode >= RTE_FDIR_MODE_PERFECT_MAC_VLAN &&
-		 mode <= RTE_FDIR_MODE_PERFECT_TUNNEL)
+	else if (mode >= IXGBE_FDIR_MODE_PERFECT_MAC_VLAN &&
+		 mode <= IXGBE_FDIR_MODE_PERFECT_TUNNEL)
 		return fdir_set_input_mask_x550(adapter, mask, mode);
 
 	PMD_DRV_LOG(ERR, "Not supported fdir mode - %d!", mode);
@@ -493,13 +493,13 @@ ixgbe_fdir_set_flexbytes_offset(struct ixgbe_adapter *adapter, uint16_t offset)
  */
 static int
 ixgbe_set_fdir_flex_conf(struct ixgbe_adapter *adapter,
-		const struct rte_eth_fdir_flex_conf *conf, uint32_t *fdirctrl)
+		const struct ixgbe_fdir_flex_conf *conf, uint32_t *fdirctrl)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
 	struct ixgbe_hw_fdir_info *info =
 			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
-	const struct rte_eth_flex_payload_cfg *flex_cfg;
-	const struct rte_eth_fdir_flex_mask *flex_mask;
+	const struct ixgbe_flex_payload_cfg *flex_cfg;
+	const struct ixgbe_fdir_flex_mask *flex_mask;
 	uint32_t fdirm;
 	uint16_t flexbytes = 0;
 	uint16_t i;
@@ -513,7 +513,7 @@ ixgbe_set_fdir_flex_conf(struct ixgbe_adapter *adapter,
 
 	for (i = 0; i < conf->nb_payloads; i++) {
 		flex_cfg = &conf->flex_set[i];
-		if (flex_cfg->type != RTE_ETH_RAW_PAYLOAD) {
+		if (flex_cfg->type != IXGBE_RAW_PAYLOAD) {
 			PMD_DRV_LOG(ERR, "unsupported payload type.");
 			return -EINVAL;
 		}
@@ -556,14 +556,14 @@ ixgbe_set_fdir_flex_conf(struct ixgbe_adapter *adapter,
 
 int
 ixgbe_fdir_configure(struct ixgbe_adapter *adapter,
-		const struct rte_eth_fdir_conf *fdir_conf,
+		const struct ixgbe_fdir_conf *fdir_conf,
 		const struct ixgbe_hw_fdir_mask *fdir_mask)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
 	int err;
 	uint32_t fdirctrl, pbsize;
 	int i;
-	enum rte_fdir_mode mode = fdir_conf->mode;
+	enum ixgbe_fdir_mode mode = fdir_conf->mode;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -580,8 +580,8 @@ ixgbe_fdir_configure(struct ixgbe_adapter *adapter,
 	    hw->mac.type != ixgbe_mac_X550EM_x &&
 	    hw->mac.type != ixgbe_mac_X550EM_a &&
 	    hw->mac.type != ixgbe_mac_E610 &&
-	    mode != RTE_FDIR_MODE_SIGNATURE &&
-	    mode != RTE_FDIR_MODE_PERFECT)
+	    mode != IXGBE_FDIR_MODE_SIGNATURE &&
+	    mode != IXGBE_FDIR_MODE_PERFECT)
 		return -ENOSYS;
 
 	err = configure_fdir_flags(fdir_conf, &fdirctrl);
@@ -733,13 +733,13 @@ ixgbe_atr_compute_hash_82599(union ixgbe_atr_input *atr_input,
 
 static uint32_t
 atr_compute_perfect_hash_82599(union ixgbe_atr_input *input,
-		enum rte_eth_fdir_pballoc_type pballoc)
+		enum ixgbe_fdir_pballoc_type pballoc)
 {
-	if (pballoc == RTE_ETH_FDIR_PBALLOC_256K)
+	if (pballoc == IXGBE_FDIR_PBALLOC_256K)
 		return ixgbe_atr_compute_hash_82599(input,
 				IXGBE_ATR_BUCKET_HASH_KEY) &
 				PERFECT_BUCKET_256KB_HASH_MASK;
-	else if (pballoc == RTE_ETH_FDIR_PBALLOC_128K)
+	else if (pballoc == IXGBE_FDIR_PBALLOC_128K)
 		return ixgbe_atr_compute_hash_82599(input,
 				IXGBE_ATR_BUCKET_HASH_KEY) &
 				PERFECT_BUCKET_128KB_HASH_MASK;
@@ -776,15 +776,15 @@ ixgbe_fdir_check_cmd_complete(struct ixgbe_hw *hw, uint32_t *fdircmd)
  */
 static uint32_t
 atr_compute_sig_hash_82599(union ixgbe_atr_input *input,
-		enum rte_eth_fdir_pballoc_type pballoc)
+		enum ixgbe_fdir_pballoc_type pballoc)
 {
 	uint32_t bucket_hash, sig_hash;
 
-	if (pballoc == RTE_ETH_FDIR_PBALLOC_256K)
+	if (pballoc == IXGBE_FDIR_PBALLOC_256K)
 		bucket_hash = ixgbe_atr_compute_hash_82599(input,
 				IXGBE_ATR_BUCKET_HASH_KEY) &
 				SIG_BUCKET_256KB_HASH_MASK;
-	else if (pballoc == RTE_ETH_FDIR_PBALLOC_128K)
+	else if (pballoc == IXGBE_FDIR_PBALLOC_128K)
 		bucket_hash = ixgbe_atr_compute_hash_82599(input,
 				IXGBE_ATR_BUCKET_HASH_KEY) &
 				SIG_BUCKET_128KB_HASH_MASK;
@@ -809,7 +809,7 @@ static int
 fdir_write_perfect_filter_82599(struct ixgbe_hw *hw,
 			union ixgbe_atr_input *input, uint8_t queue,
 			uint32_t fdircmd, uint32_t fdirhash,
-			enum rte_fdir_mode mode)
+			enum ixgbe_fdir_mode mode)
 {
 	uint32_t fdirport, fdirvlan;
 	u32 addr_low, addr_high;
@@ -817,7 +817,7 @@ fdir_write_perfect_filter_82599(struct ixgbe_hw *hw,
 	int err = 0;
 	volatile uint32_t *reg;
 
-	if (mode == RTE_FDIR_MODE_PERFECT) {
+	if (mode == IXGBE_FDIR_MODE_PERFECT) {
 		/* record the IPv4 address (big-endian)
 		 * can not use IXGBE_WRITE_REG.
 		 */
@@ -831,8 +831,8 @@ fdir_write_perfect_filter_82599(struct ixgbe_hw *hw,
 		fdirport <<= IXGBE_FDIRPORT_DESTINATION_SHIFT;
 		fdirport |= IXGBE_NTOHS(input->formatted.src_port);
 		IXGBE_WRITE_REG(hw, IXGBE_FDIRPORT, fdirport);
-	} else if (mode >= RTE_FDIR_MODE_PERFECT_MAC_VLAN &&
-		   mode <= RTE_FDIR_MODE_PERFECT_TUNNEL) {
+	} else if (mode >= IXGBE_FDIR_MODE_PERFECT_MAC_VLAN &&
+		   mode <= IXGBE_FDIR_MODE_PERFECT_TUNNEL) {
 		/* for mac vlan and tunnel modes */
 		addr_low = ((u32)input->formatted.inner_mac[0] |
 			    ((u32)input->formatted.inner_mac[1] << 8) |
@@ -841,7 +841,7 @@ fdir_write_perfect_filter_82599(struct ixgbe_hw *hw,
 		addr_high = ((u32)input->formatted.inner_mac[4] |
 			     ((u32)input->formatted.inner_mac[5] << 8));
 
-		if (mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN) {
+		if (mode == IXGBE_FDIR_MODE_PERFECT_MAC_VLAN) {
 			IXGBE_WRITE_REG(hw, IXGBE_FDIRSIPv6(0), addr_low);
 			IXGBE_WRITE_REG(hw, IXGBE_FDIRSIPv6(1), addr_high);
 			IXGBE_WRITE_REG(hw, IXGBE_FDIRSIPv6(2), 0);
@@ -1035,7 +1035,7 @@ ixgbe_remove_fdir_filter(struct ixgbe_hw_fdir_info *fdir_info,
 
 int
 ixgbe_fdir_filter_program(struct ixgbe_adapter *adapter,
-		struct rte_eth_fdir_conf *fdir_conf,
+		struct ixgbe_fdir_conf *fdir_conf,
 		struct ixgbe_fdir_rule *rule,
 		bool del,
 		bool update)
@@ -1048,11 +1048,11 @@ ixgbe_fdir_filter_program(struct ixgbe_adapter *adapter,
 	int err;
 	struct ixgbe_hw_fdir_info *info =
 		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
-	enum rte_fdir_mode fdir_mode = fdir_conf->mode;
+	enum ixgbe_fdir_mode fdir_mode = fdir_conf->mode;
 	struct ixgbe_fdir_filter *node;
 	bool add_node = FALSE;
 
-	if (fdir_mode == RTE_FDIR_MODE_NONE ||
+	if (fdir_mode == IXGBE_FDIR_MODE_NONE ||
 	    fdir_mode != rule->mode)
 		return -ENOTSUP;
 
@@ -1073,16 +1073,16 @@ ixgbe_fdir_filter_program(struct ixgbe_adapter *adapter,
 	     IXGBE_ATR_FLOW_TYPE_IPV6) &&
 	    (info->mask.src_port_mask != 0 ||
 	     info->mask.dst_port_mask != 0) &&
-	    (rule->mode != RTE_FDIR_MODE_PERFECT_MAC_VLAN &&
-	     rule->mode != RTE_FDIR_MODE_PERFECT_TUNNEL)) {
+	    (rule->mode != IXGBE_FDIR_MODE_PERFECT_MAC_VLAN &&
+	     rule->mode != IXGBE_FDIR_MODE_PERFECT_TUNNEL)) {
 		PMD_DRV_LOG(ERR, "By this device,"
 			    " IPv4 is not supported without"
 			    " L4 protocol and ports masked!");
 		return -ENOTSUP;
 	}
 
-	if (fdir_mode >= RTE_FDIR_MODE_PERFECT &&
-	    fdir_mode <= RTE_FDIR_MODE_PERFECT_TUNNEL)
+	if (fdir_mode >= IXGBE_FDIR_MODE_PERFECT &&
+	    fdir_mode <= IXGBE_FDIR_MODE_PERFECT_TUNNEL)
 		is_perfect = TRUE;
 
 	if (is_perfect) {
@@ -1207,15 +1207,15 @@ void
 ixgbe_fdir_filter_restore(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
+	struct ixgbe_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	struct ixgbe_hw_fdir_info *fdir_info =
 		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
 	struct ixgbe_fdir_filter *node;
 	bool is_perfect = FALSE;
-	enum rte_fdir_mode fdir_mode = fdir_conf->mode;
+	enum ixgbe_fdir_mode fdir_mode = fdir_conf->mode;
 
-	if (fdir_mode >= RTE_FDIR_MODE_PERFECT &&
-	    fdir_mode <= RTE_FDIR_MODE_PERFECT_TUNNEL)
+	if (fdir_mode >= IXGBE_FDIR_MODE_PERFECT &&
+	    fdir_mode <= IXGBE_FDIR_MODE_PERFECT_TUNNEL)
 		is_perfect = TRUE;
 
 	if (is_perfect) {
@@ -1242,7 +1242,7 @@ ixgbe_fdir_filter_restore(struct rte_eth_dev *dev)
 int
 ixgbe_clear_all_fdir_filter(struct rte_eth_dev *dev)
 {
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
+	struct ixgbe_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	struct ixgbe_hw_fdir_info *fdir_info =
 		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
 	struct ixgbe_fdir_filter *fdir_filter;
@@ -1267,7 +1267,7 @@ ixgbe_clear_all_fdir_filter(struct rte_eth_dev *dev)
 	fdir_info->mask = (struct ixgbe_hw_fdir_mask){0};
 	fdir_info->flex_bytes_offset = 0;
 	fdir_info->mask_added = FALSE;
-	fdir_conf->mode = RTE_FDIR_MODE_NONE;
+	fdir_conf->mode = IXGBE_FDIR_MODE_NONE;
 
 	if (had_flows)
 		ret = ixgbe_fdir_flush(dev);
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 9038aae001..e990126b5f 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -1501,7 +1501,7 @@ ixgbe_parse_fdir_act_attr(const struct rte_flow_attr *attr,
 		rule->queue = act_q->index;
 	} else { /* drop */
 		/* signature mode does not support drop action. */
-		if (rule->mode == RTE_FDIR_MODE_SIGNATURE) {
+		if (rule->mode == IXGBE_FDIR_MODE_SIGNATURE) {
 			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
 			rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_ACTION,
@@ -1727,9 +1727,9 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
 	}
 
 	if (signature_match(pattern))
-		rule->mode = RTE_FDIR_MODE_SIGNATURE;
+		rule->mode = IXGBE_FDIR_MODE_SIGNATURE;
 	else
-		rule->mode = RTE_FDIR_MODE_PERFECT;
+		rule->mode = IXGBE_FDIR_MODE_PERFECT;
 
 	/*Not supported last point for range*/
 	if (item->last) {
@@ -1772,7 +1772,7 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
 
 			/* Ether type should be masked. */
 			if (eth_mask->hdr.ether_type ||
-			    rule->mode == RTE_FDIR_MODE_SIGNATURE) {
+			    rule->mode == IXGBE_FDIR_MODE_SIGNATURE) {
 				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
 				rte_flow_error_set(error, EINVAL,
 					RTE_FLOW_ERROR_TYPE_ITEM,
@@ -1781,7 +1781,7 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
 			}
 
 			/* If ethernet has meaning, it means MAC VLAN mode. */
-			rule->mode = RTE_FDIR_MODE_PERFECT_MAC_VLAN;
+			rule->mode = IXGBE_FDIR_MODE_PERFECT_MAC_VLAN;
 
 			/**
 			 * src MAC address must be masked,
@@ -1812,7 +1812,7 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
 		 * IPv6 is not supported.
 		 */
 		item = next_no_fuzzy_pattern(pattern, item);
-		if (rule->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN) {
+		if (rule->mode == IXGBE_FDIR_MODE_PERFECT_MAC_VLAN) {
 			if (item->type != RTE_FLOW_ITEM_TYPE_VLAN) {
 				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
 				rte_flow_error_set(error, EINVAL,
@@ -1955,7 +1955,7 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
 		 * 2. not support last
 		 * 3. mask must not null
 		 */
-		if (rule->mode != RTE_FDIR_MODE_SIGNATURE ||
+		if (rule->mode != IXGBE_FDIR_MODE_SIGNATURE ||
 		    item->last ||
 		    !item->mask) {
 			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
@@ -2432,7 +2432,7 @@ ixgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 		return -rte_errno;
 	}
 
-	rule->mode = RTE_FDIR_MODE_PERFECT_TUNNEL;
+	rule->mode = IXGBE_FDIR_MODE_PERFECT_TUNNEL;
 
 	/* Skip MAC. */
 	if (item->type == RTE_FLOW_ITEM_TYPE_ETH) {
@@ -2920,8 +2920,8 @@ ixgbe_fdir_flow_program(struct rte_eth_dev *dev,
 		bool *first_mask,
 		struct rte_flow_error *error)
 {
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
-	struct rte_eth_fdir_conf local_fdir_conf = *fdir_conf;
+	struct ixgbe_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
+	struct ixgbe_fdir_conf local_fdir_conf = *fdir_conf;
 	struct ixgbe_hw_fdir_info *fdir_info =
 			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
 	int ret;
@@ -2935,7 +2935,7 @@ ixgbe_fdir_flow_program(struct rte_eth_dev *dev,
 	local_fdir_conf.mode = fdir_rule->mode;
 
 	/* Configure FDIR mode if this is the first filter */
-	if (fdir_conf->mode == RTE_FDIR_MODE_NONE) {
+	if (fdir_conf->mode == IXGBE_FDIR_MODE_NONE) {
 		ret = ixgbe_fdir_configure(adapter, &local_fdir_conf, &fdir_rule->mask);
 		if (ret) {
 			return rte_flow_error_set(error, EINVAL,
@@ -3249,7 +3249,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	ret = ixgbe_parse_fdir_filter(dev, attr, pattern,
 				actions, &fdir_rule, error);
 	if (!ret) {
-		struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
+		struct ixgbe_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 		bool first_mask = false;
 
 		ret = ixgbe_fdir_flow_program(dev, adapter, &fdir_rule,
@@ -3420,7 +3420,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	struct ixgbe_filter_ele_base *flow_mem_base;
 	struct ixgbe_hw_fdir_info *fdir_info =
 		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
+	struct ixgbe_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 
 	/* Validate ownership before touching HW/SW state. */
@@ -3487,7 +3487,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 				fdir_info->mask_added = false;
 				fdir_info->mask = (struct ixgbe_hw_fdir_mask){0};
 				fdir_info->flex_bytes_offset = 0;
-				fdir_conf->mode = RTE_FDIR_MODE_NONE;
+				fdir_conf->mode = IXGBE_FDIR_MODE_NONE;
 			}
 		}
 		break;
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
index c42b8fc96b..d2dd640893 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
@@ -120,10 +120,10 @@ int __rte_cold
 ixgbe_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev)
 {
 #ifndef RTE_LIBRTE_IEEE1588
-	struct rte_eth_fdir_conf *fconf = IXGBE_DEV_FDIR_CONF(dev);
+	struct ixgbe_fdir_conf *fconf = IXGBE_DEV_FDIR_CONF(dev);
 
 	/* no fdir support */
-	if (fconf->mode != RTE_FDIR_MODE_NONE)
+	if (fconf->mode != IXGBE_FDIR_MODE_NONE)
 		return -1;
 
 	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
-- 
2.53.0

