Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A2FCAC5AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 16:18:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B55BF40647;
	Fri, 26 Sep 2025 18:18:43 +0200 (CEST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id F1A9E40262
 for <dev@dpdk.org>; Fri, 26 Sep 2025 18:18:42 +0200 (CEST)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-8276e579242so245513685a.0
 for <dev@dpdk.org>; Fri, 26 Sep 2025 09:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758903522;
 x=1759508322; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=60YNUSwTrbj7aE6YMYriLrN8+BFolBAotgdGSfI75Rg=;
 b=ceedPgex09/t7QZcy52B2rL8VPi53p5EF1D2HzKSAApxsmel4vd0gxDIBSeRaXFMYT
 oVaqfSxJalY1QcPG6yy5Bq9u8lxnQDQplTvwCEfGBynqgEmzaV2QGTZZwE/lj13oNSN4
 TXRXuvSSUtdt+HVLS2H8OglXQ+D7g2Hlo1SH+xzQqcJlpc7FYIxiZEsE5a0R6AdrQU9d
 kUz/347wRJkJ/f31vGtAZjciYyOJRw8Lo13SwU1MuHa6c1tk2rxbpjLXvxfiYgEppEc8
 kaV/W5GbDfmglvXUB1gmDI7zxFRQkY3yT+NxvYJc82YLGpELq7PcIXw9TOOhe9oiNONd
 gG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758903522; x=1759508322;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=60YNUSwTrbj7aE6YMYriLrN8+BFolBAotgdGSfI75Rg=;
 b=L8oCJC8l1nj7dIGzJfU+vCSjpZRXFBwX1nOzlS0izWmTxzZbi3xJbeBVsuuyx7zU3J
 RlnvWYuB22N7JBsx/ff0asP8vBmGB0fTNYoobZclew3PyALwSq8aOXy+YSQPKDnG4m6D
 f0tFZH+SXYrC/lMciajJ0891WCJETV9Nho4orzph+jOxTb45Xr9chDprHaIO10Dyzyxe
 CLYrTdw3hu6y8fbzNyXJFmmVLomWpOwegnlxOWxRfaFiQTuKtI37nVaZ/DS3UrFiDAuj
 RU/0yOai/QQg97NWhrsJD4u0TVoduLNutd5rcEbqzeO1WQfyLawepQfD5Tq3dqU8uBHu
 ruuQ==
X-Gm-Message-State: AOJu0YwfHlmE3wkLb7pV5/Vb0bmRj004UWKPSfXJC+OUgxVUPhFZWSeu
 Wr6wDvV2REf2AJfcbvMv84CotxKLtAz/luoYtzmTVUd5K0yqlt0fgOQb7K1Y0+2OL5MsWTv1Stc
 khKg3g/g=
X-Gm-Gg: ASbGncvcFX/KUcZqz53+3PiWWRjdQJRozvrh/poGtcGXCj1y0UMw43p8wv0MhggbM7j
 kHJeJ4AskNM1jtrozrABXHLVYG++HN2NHsPync/zbcCcFYYW/QKze83vNbeBX9lsT/ED+2Plg2t
 pNA0a1y9fPedUbVs7iYz46TxcXhx1CDWn4ruCMTjzMxxtMJkcX4Vg1Z5m/oO///9Z5XWcwAo9RY
 gIfB3glWWOXkFnJoc4+2dz1AGkdwxOl9/g4KqhaVR1icmIuM1QC9XDZTxxIMvdgXASQlZGD+U2R
 PZwCIfjg83Loo5ctkMGHIdLFoduu/Q6V2/pPfjXStNZfAatDxHoNGhGhEnfIf29p5E/OXUEuH+d
 R6tzajJOgmugQ5+xQGP11kbBBv9JXRHLIo1+ItA/3aCXhKmc6cpVhrfSrgW++PliLiFCS6kjo
X-Google-Smtp-Source: AGHT+IF/HpCO99LUwDuMnXLbWIFIyLxPzRlVGXOE/h2ob4m8k/u+lm1Pgfi2EKTI1bfKtXtNLhI9jA==
X-Received: by 2002:a05:620a:4012:b0:850:efbf:381e with SMTP id
 af79cd13be357-85ae1d14608mr1087448285a.36.1758903521942; 
 Fri, 26 Sep 2025 09:18:41 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c307acc4bsm305791785a.40.2025.09.26.09.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 09:18:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH] net/bonding: rename global symbols
Date: Fri, 26 Sep 2025 09:18:37 -0700
Message-ID: <20250926161837.400929-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
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

All global symbols should use a consistent prefix to avoid
conflict when linking statically. The device ops can just
be made local.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bonding/eth_bond_private.h | 57 +++++++++------------
 drivers/net/bonding/rte_eth_bond_api.c | 45 ++++++++---------
 drivers/net/bonding/rte_eth_bond_pmd.c | 69 +++++++++++++-------------
 3 files changed, 80 insertions(+), 91 deletions(-)

diff --git a/drivers/net/bonding/eth_bond_private.h b/drivers/net/bonding/eth_bond_private.h
index 378bbba4e6..1796bf5d9d 100644
--- a/drivers/net/bonding/eth_bond_private.h
+++ b/drivers/net/bonding/eth_bond_private.h
@@ -188,11 +188,6 @@ struct bond_dev_private {
 	struct rte_bitmap *vlan_filter_bmp;
 };
 
-extern const struct eth_dev_ops default_dev_ops;
-
-int
-check_for_main_bonding_ethdev(const struct rte_eth_dev *eth_dev);
-
 int
 check_for_bonding_ethdev(const struct rte_eth_dev *eth_dev);
 
@@ -218,65 +213,61 @@ valid_port_id(uint16_t port_id);
 int
 valid_bonding_port_id(uint16_t port_id);
 
-int
-valid_member_port_id(struct bond_dev_private *internals, uint16_t port_id);
-
 void
-deactivate_member(struct rte_eth_dev *eth_dev, uint16_t port_id);
+bond_deactivate_member(struct rte_eth_dev *eth_dev, uint16_t port_id);
 
 void
-activate_member(struct rte_eth_dev *eth_dev, uint16_t port_id);
+bond_activate_member(struct rte_eth_dev *eth_dev, uint16_t port_id);
 
 int
-mac_address_set(struct rte_eth_dev *eth_dev,
-		struct rte_ether_addr *new_mac_addr);
+bond_mac_address_set(struct rte_eth_dev *eth_dev,
+		     struct rte_ether_addr *new_mac_addr);
 
 int
-mac_address_get(struct rte_eth_dev *eth_dev,
-		struct rte_ether_addr *dst_mac_addr);
+bond_mac_address_get(struct rte_eth_dev *eth_dev,
+		     struct rte_ether_addr *dst_mac_addr);
 
 int
-mac_address_members_update(struct rte_eth_dev *bonding_eth_dev);
+bond_mac_address_members_update(struct rte_eth_dev *bonding_eth_dev);
 
 int
-member_add_mac_addresses(struct rte_eth_dev *bonding_eth_dev,
-		uint16_t member_port_id);
+bond_member_add_mac_addresses(struct rte_eth_dev *bonding_eth_dev,
+			      uint16_t member_port_id);
 
 int
-member_remove_mac_addresses(struct rte_eth_dev *bonding_eth_dev,
-		uint16_t member_port_id);
+bond_member_remove_mac_addresses(struct rte_eth_dev *bonding_eth_dev,
+				 uint16_t member_port_id);
 
 int
 bond_ethdev_mode_set(struct rte_eth_dev *eth_dev, uint8_t mode);
 
 int
-member_configure(struct rte_eth_dev *bonding_eth_dev,
-		struct rte_eth_dev *member_eth_dev);
+bond_member_configure(struct rte_eth_dev *bonding_eth_dev,
+		      struct rte_eth_dev *member_eth_dev);
 
 int
-member_start(struct rte_eth_dev *bonding_eth_dev,
-		struct rte_eth_dev *member_eth_dev);
+bond_member_start(struct rte_eth_dev *bonding_eth_dev,
+		  struct rte_eth_dev *member_eth_dev);
 
 void
-member_remove(struct bond_dev_private *internals,
-		struct rte_eth_dev *member_eth_dev);
+bond_member_remove(struct bond_dev_private *internals,
+		   struct rte_eth_dev *member_eth_dev);
 
 void
-member_add(struct bond_dev_private *internals,
+bond_member_add(struct bond_dev_private *internals,
 		struct rte_eth_dev *member_eth_dev);
 
 void
-burst_xmit_l2_hash(struct rte_mbuf **buf, uint16_t nb_pkts,
-		uint16_t member_count, uint16_t *members);
+bond_xmit_l2_hash(struct rte_mbuf **buf, uint16_t nb_pkts,
+			uint16_t member_count, uint16_t *members);
 
 void
-burst_xmit_l23_hash(struct rte_mbuf **buf, uint16_t nb_pkts,
-		uint16_t member_count, uint16_t *members);
+bond_xmit_l23_hash(struct rte_mbuf **buf, uint16_t nb_pkts,
+		   uint16_t member_count, uint16_t *members);
 
 void
-burst_xmit_l34_hash(struct rte_mbuf **buf, uint16_t nb_pkts,
-		uint16_t member_count, uint16_t *members);
-
+bond_xmit_l34_hash(struct rte_mbuf **buf, uint16_t nb_pkts,
+		   uint16_t member_count, uint16_t *members);
 
 void
 bond_ethdev_primary_set(struct bond_dev_private *internals,
diff --git a/drivers/net/bonding/rte_eth_bond_api.c b/drivers/net/bonding/rte_eth_bond_api.c
index 9e5df67c18..d5c6510f21 100644
--- a/drivers/net/bonding/rte_eth_bond_api.c
+++ b/drivers/net/bonding/rte_eth_bond_api.c
@@ -37,7 +37,7 @@ valid_bonding_port_id(uint16_t port_id)
 	return check_for_bonding_ethdev(&rte_eth_devices[port_id]);
 }
 
-int
+static int
 check_for_main_bonding_ethdev(const struct rte_eth_dev *eth_dev)
 {
 	int i;
@@ -56,7 +56,7 @@ check_for_main_bonding_ethdev(const struct rte_eth_dev *eth_dev)
 	return 0;
 }
 
-int
+static int
 valid_member_port_id(struct bond_dev_private *internals, uint16_t member_port_id)
 {
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(member_port_id, -1);
@@ -80,7 +80,7 @@ valid_member_port_id(struct bond_dev_private *internals, uint16_t member_port_id
 }
 
 void
-activate_member(struct rte_eth_dev *eth_dev, uint16_t port_id)
+bond_activate_member(struct rte_eth_dev *eth_dev, uint16_t port_id)
 {
 	struct bond_dev_private *internals = eth_dev->data->dev_private;
 	uint16_t active_count = internals->active_member_count;
@@ -107,7 +107,7 @@ activate_member(struct rte_eth_dev *eth_dev, uint16_t port_id)
 }
 
 void
-deactivate_member(struct rte_eth_dev *eth_dev, uint16_t port_id)
+bond_deactivate_member(struct rte_eth_dev *eth_dev, uint16_t port_id)
 {
 	uint16_t member_pos;
 	struct bond_dev_private *internals = eth_dev->data->dev_private;
@@ -496,7 +496,7 @@ __eth_bond_member_add_lock_free(uint16_t bonding_port_id, uint16_t member_port_i
 		return -1;
 	}
 
-	member_add(internals, member_eth_dev);
+	bond_member_add(internals, member_eth_dev);
 
 	/* We need to store members reta_size to be able to synchronize RETA for all
 	 * member devices even if its sizes are different.
@@ -509,7 +509,7 @@ __eth_bond_member_add_lock_free(uint16_t bonding_port_id, uint16_t member_port_i
 		 * bonding device.
 		 */
 		if (!internals->user_defined_mac) {
-			if (mac_address_set(bonding_eth_dev,
+			if (bond_mac_address_set(bonding_eth_dev,
 					    member_eth_dev->data->mac_addrs)) {
 				RTE_BOND_LOG(ERR, "Failed to set MAC address");
 				return -1;
@@ -566,7 +566,7 @@ __eth_bond_member_add_lock_free(uint16_t bonding_port_id, uint16_t member_port_i
 	}
 
 	/* Add additional MAC addresses to the member */
-	if (member_add_mac_addresses(bonding_eth_dev, member_port_id) != 0) {
+	if (bond_member_add_mac_addresses(bonding_eth_dev, member_port_id) != 0) {
 		RTE_BOND_LOG(ERR, "Failed to add mac address(es) to member %hu",
 				member_port_id);
 		return -1;
@@ -575,13 +575,13 @@ __eth_bond_member_add_lock_free(uint16_t bonding_port_id, uint16_t member_port_i
 	internals->member_count++;
 
 	if (bonding_eth_dev->data->dev_started) {
-		if (member_configure(bonding_eth_dev, member_eth_dev) != 0) {
+		if (bond_member_configure(bonding_eth_dev, member_eth_dev) != 0) {
 			internals->member_count--;
 			RTE_BOND_LOG(ERR, "rte_bond_members_configure: port=%d",
 					member_port_id);
 			return -1;
 		}
-		if (member_start(bonding_eth_dev, member_eth_dev) != 0) {
+		if (bond_member_start(bonding_eth_dev, member_eth_dev) != 0) {
 			internals->member_count--;
 			RTE_BOND_LOG(ERR, "rte_bond_members_start: port=%d",
 					member_port_id);
@@ -590,7 +590,7 @@ __eth_bond_member_add_lock_free(uint16_t bonding_port_id, uint16_t member_port_i
 	}
 
 	/* Update all member devices MACs */
-	mac_address_members_update(bonding_eth_dev);
+	bond_mac_address_members_update(bonding_eth_dev);
 
 	/*
 	 * Register link status change callback with bonding device pointer as
@@ -683,7 +683,7 @@ __eth_bond_member_remove_lock_free(uint16_t bonding_port_id,
 		internals->active_member_count, member_port_id);
 
 	if (member_idx < internals->active_member_count)
-		deactivate_member(bonding_eth_dev, member_port_id);
+		bond_deactivate_member(bonding_eth_dev, member_port_id);
 
 	member_idx = -1;
 	/* now find in member list */
@@ -710,7 +710,7 @@ __eth_bond_member_remove_lock_free(uint16_t bonding_port_id,
 			&internals->members[member_idx].persisted_mac_addr);
 
 	/* remove additional MAC addresses from the member */
-	member_remove_mac_addresses(bonding_eth_dev, member_port_id);
+	bond_member_remove_mac_addresses(bonding_eth_dev, member_port_id);
 
 	/*
 	 * Remove bond device flows from member device.
@@ -735,7 +735,7 @@ __eth_bond_member_remove_lock_free(uint16_t bonding_port_id,
 	}
 
 	member_eth_dev = &rte_eth_devices[member_port_id];
-	member_remove(internals, member_eth_dev);
+	bond_member_remove(internals, member_eth_dev);
 	member_eth_dev->data->dev_flags &= (~RTE_ETH_DEV_BONDING_MEMBER);
 
 	/*  first member in the active list will be the primary by default,
@@ -747,7 +747,7 @@ __eth_bond_member_remove_lock_free(uint16_t bonding_port_id,
 			internals->current_primary_port = internals->members[0].port_id;
 		else
 			internals->primary_port = 0;
-		mac_address_members_update(bonding_eth_dev);
+		bond_mac_address_members_update(bonding_eth_dev);
 	}
 
 	if (internals->active_member_count < 1) {
@@ -931,14 +931,14 @@ rte_eth_bond_mac_address_set(uint16_t bonding_port_id,
 	internals = bonding_eth_dev->data->dev_private;
 
 	/* Set MAC Address of Bonding Device */
-	if (mac_address_set(bonding_eth_dev, mac_addr))
+	if (bond_mac_address_set(bonding_eth_dev, mac_addr))
 		return -1;
 
 	internals->user_defined_mac = 1;
 
 	/* Update all member devices MACs*/
 	if (internals->member_count > 0)
-		return mac_address_members_update(bonding_eth_dev);
+		return bond_mac_address_members_update(bonding_eth_dev);
 
 	return 0;
 }
@@ -972,14 +972,13 @@ rte_eth_bond_mac_address_reset(uint16_t bonding_port_id)
 		}
 
 		/* Set MAC Address of Bonding Device */
-		if (mac_address_set(bonding_eth_dev,
-			&internals->members[member_port].persisted_mac_addr)
-				!= 0) {
+		if (bond_mac_address_set(bonding_eth_dev,
+			&internals->members[member_port].persisted_mac_addr) != 0) {
 			RTE_BOND_LOG(ERR, "Failed to set MAC address on bonding device");
 			return -1;
 		}
 		/* Update all member devices MAC addresses */
-		return mac_address_members_update(bonding_eth_dev);
+		return bond_mac_address_members_update(bonding_eth_dev);
 	}
 	/* No need to update anything as no members present */
 	return 0;
@@ -999,15 +998,15 @@ rte_eth_bond_xmit_policy_set(uint16_t bonding_port_id, uint8_t policy)
 	switch (policy) {
 	case BALANCE_XMIT_POLICY_LAYER2:
 		internals->balance_xmit_policy = policy;
-		internals->burst_xmit_hash = burst_xmit_l2_hash;
+		internals->burst_xmit_hash = bond_xmit_l2_hash;
 		break;
 	case BALANCE_XMIT_POLICY_LAYER23:
 		internals->balance_xmit_policy = policy;
-		internals->burst_xmit_hash = burst_xmit_l23_hash;
+		internals->burst_xmit_hash = bond_xmit_l23_hash;
 		break;
 	case BALANCE_XMIT_POLICY_LAYER34:
 		internals->balance_xmit_policy = policy;
-		internals->burst_xmit_hash = burst_xmit_l34_hash;
+		internals->burst_xmit_hash = bond_xmit_l34_hash;
 		break;
 
 	default:
diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 4906701a95..6bf638f598 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -699,10 +699,9 @@ ipv6_hash(struct rte_ipv6_hdr *ipv6_hdr)
 			(word_src_addr[3] ^ word_dst_addr[3]);
 }
 
-
 void
-burst_xmit_l2_hash(struct rte_mbuf **buf, uint16_t nb_pkts,
-		uint16_t member_count, uint16_t *members)
+bond_xmit_l2_hash(struct rte_mbuf **buf, uint16_t nb_pkts,
+		  uint16_t member_count, uint16_t *members)
 {
 	struct rte_ether_hdr *eth_hdr;
 	uint32_t hash;
@@ -718,8 +717,8 @@ burst_xmit_l2_hash(struct rte_mbuf **buf, uint16_t nb_pkts,
 }
 
 void
-burst_xmit_l23_hash(struct rte_mbuf **buf, uint16_t nb_pkts,
-		uint16_t member_count, uint16_t *members)
+bond_xmit_l23_hash(struct rte_mbuf **buf, uint16_t nb_pkts,
+		   uint16_t member_count, uint16_t *members)
 {
 	uint16_t i;
 	struct rte_ether_hdr *eth_hdr;
@@ -756,8 +755,8 @@ burst_xmit_l23_hash(struct rte_mbuf **buf, uint16_t nb_pkts,
 }
 
 void
-burst_xmit_l34_hash(struct rte_mbuf **buf, uint16_t nb_pkts,
-		uint16_t member_count, uint16_t *members)
+bond_xmit_l34_hash(struct rte_mbuf **buf, uint16_t nb_pkts,
+		   uint16_t member_count, uint16_t *members)
 {
 	struct rte_ether_hdr *eth_hdr;
 	uint16_t proto;
@@ -1434,8 +1433,8 @@ link_properties_valid(struct rte_eth_dev *ethdev,
 }
 
 int
-mac_address_get(struct rte_eth_dev *eth_dev,
-		struct rte_ether_addr *dst_mac_addr)
+bond_mac_address_get(struct rte_eth_dev *eth_dev,
+		     struct rte_ether_addr *dst_mac_addr)
 {
 	struct rte_ether_addr *mac_addr;
 
@@ -1456,8 +1455,8 @@ mac_address_get(struct rte_eth_dev *eth_dev,
 }
 
 int
-mac_address_set(struct rte_eth_dev *eth_dev,
-		struct rte_ether_addr *new_mac_addr)
+bond_mac_address_set(struct rte_eth_dev *eth_dev,
+		     struct rte_ether_addr *new_mac_addr)
 {
 	struct rte_ether_addr *mac_addr;
 
@@ -1486,8 +1485,8 @@ static const struct rte_ether_addr null_mac_addr;
  * Add additional MAC addresses to the member
  */
 int
-member_add_mac_addresses(struct rte_eth_dev *bonding_eth_dev,
-		uint16_t member_port_id)
+bond_member_add_mac_addresses(struct rte_eth_dev *bonding_eth_dev,
+			      uint16_t member_port_id)
 {
 	int i, ret;
 	struct rte_ether_addr *mac_addr;
@@ -1514,8 +1513,8 @@ member_add_mac_addresses(struct rte_eth_dev *bonding_eth_dev,
  * Remove additional MAC addresses from the member
  */
 int
-member_remove_mac_addresses(struct rte_eth_dev *bonding_eth_dev,
-		uint16_t member_port_id)
+bond_member_remove_mac_addresses(struct rte_eth_dev *bonding_eth_dev,
+				 uint16_t member_port_id)
 {
 	int i, rc, ret;
 	struct rte_ether_addr *mac_addr;
@@ -1536,7 +1535,7 @@ member_remove_mac_addresses(struct rte_eth_dev *bonding_eth_dev,
 }
 
 int
-mac_address_members_update(struct rte_eth_dev *bonding_eth_dev)
+bond_mac_address_members_update(struct rte_eth_dev *bonding_eth_dev)
 {
 	struct bond_dev_private *internals = bonding_eth_dev->data->dev_private;
 	bool set;
@@ -1735,7 +1734,7 @@ member_configure_slow_queue(struct rte_eth_dev *bonding_eth_dev,
 }
 
 int
-member_configure(struct rte_eth_dev *bonding_eth_dev,
+bond_member_configure(struct rte_eth_dev *bonding_eth_dev,
 		struct rte_eth_dev *member_eth_dev)
 {
 	uint16_t nb_rx_queues;
@@ -1817,8 +1816,8 @@ member_configure(struct rte_eth_dev *bonding_eth_dev,
 }
 
 int
-member_start(struct rte_eth_dev *bonding_eth_dev,
-		struct rte_eth_dev *member_eth_dev)
+bond_member_start(struct rte_eth_dev *bonding_eth_dev,
+		  struct rte_eth_dev *member_eth_dev)
 {
 	int errval = 0;
 	struct bond_rx_queue *bd_rx_q;
@@ -1941,8 +1940,8 @@ member_start(struct rte_eth_dev *bonding_eth_dev,
 }
 
 void
-member_remove(struct bond_dev_private *internals,
-		struct rte_eth_dev *member_eth_dev)
+bond_member_remove(struct bond_dev_private *internals,
+		   struct rte_eth_dev *member_eth_dev)
 {
 	uint16_t i;
 
@@ -1975,7 +1974,7 @@ static void
 bond_ethdev_member_link_status_change_monitor(void *cb_arg);
 
 void
-member_add(struct bond_dev_private *internals,
+bond_member_add(struct bond_dev_private *internals,
 		struct rte_eth_dev *member_eth_dev)
 {
 	struct bond_member_details *member_details =
@@ -2048,7 +2047,7 @@ bond_ethdev_start(struct rte_eth_dev *eth_dev)
 		if (new_mac_addr == NULL)
 			goto out_err;
 
-		if (mac_address_set(eth_dev, new_mac_addr) != 0) {
+		if (bond_mac_address_set(eth_dev, new_mac_addr) != 0) {
 			RTE_BOND_LOG(ERR, "bonding port (%d) failed to update MAC address",
 					eth_dev->data->port_id);
 			goto out_err;
@@ -2069,14 +2068,14 @@ bond_ethdev_start(struct rte_eth_dev *eth_dev)
 	for (i = 0; i < internals->member_count; i++) {
 		struct rte_eth_dev *member_ethdev =
 				&(rte_eth_devices[internals->members[i].port_id]);
-		if (member_configure(eth_dev, member_ethdev) != 0) {
+		if (bond_member_configure(eth_dev, member_ethdev) != 0) {
 			RTE_BOND_LOG(ERR,
 				"bonding port (%d) failed to reconfigure member device (%d)",
 				eth_dev->data->port_id,
 				internals->members[i].port_id);
 			goto out_err;
 		}
-		if (member_start(eth_dev, member_ethdev) != 0) {
+		if (bond_member_start(eth_dev, member_ethdev) != 0) {
 			RTE_BOND_LOG(ERR,
 				"bonding port (%d) failed to start member device (%d)",
 				eth_dev->data->port_id,
@@ -2099,7 +2098,7 @@ bond_ethdev_start(struct rte_eth_dev *eth_dev)
 	}
 
 	/* Update all member devices MACs*/
-	if (mac_address_members_update(eth_dev) != 0)
+	if (bond_mac_address_members_update(eth_dev) != 0)
 		goto out_err;
 
 	if (internals->user_defined_primary_port)
@@ -2203,7 +2202,7 @@ bond_ethdev_stop(struct rte_eth_dev *eth_dev)
 		if (find_member_by_id(internals->active_members,
 				internals->active_member_count, member_id) !=
 					internals->active_member_count)
-			deactivate_member(eth_dev, member_id);
+			bond_deactivate_member(eth_dev, member_id);
 	}
 
 	for (i = 0; i < eth_dev->data->nb_rx_queues; i++)
@@ -3076,12 +3075,12 @@ bond_ethdev_lsc_event_callback(uint16_t port_id, enum rte_eth_event_type type,
 			internals->current_primary_port = port_id;
 			lsc_flag = 1;
 
-			mac_address_members_update(bonding_eth_dev);
+			bond_mac_address_members_update(bonding_eth_dev);
 			bond_ethdev_promiscuous_update(bonding_eth_dev);
 			bond_ethdev_allmulticast_update(bonding_eth_dev);
 		}
 
-		activate_member(bonding_eth_dev, port_id);
+		bond_activate_member(bonding_eth_dev, port_id);
 
 		/* If the user has defined the primary port then default to
 		 * using it.
@@ -3094,7 +3093,7 @@ bond_ethdev_lsc_event_callback(uint16_t port_id, enum rte_eth_event_type type,
 			goto link_update;
 
 		/* Remove from active member list */
-		deactivate_member(bonding_eth_dev, port_id);
+		bond_deactivate_member(bonding_eth_dev, port_id);
 
 		if (internals->active_member_count < 1)
 			lsc_flag = 1;
@@ -3107,7 +3106,7 @@ bond_ethdev_lsc_event_callback(uint16_t port_id, enum rte_eth_event_type type,
 						internals->active_members[0]);
 			else
 				internals->current_primary_port = internals->primary_port;
-			mac_address_members_update(bonding_eth_dev);
+			bond_mac_address_members_update(bonding_eth_dev);
 			bond_ethdev_promiscuous_update(bonding_eth_dev);
 			bond_ethdev_allmulticast_update(bonding_eth_dev);
 		}
@@ -3297,7 +3296,7 @@ static int
 bond_ethdev_mac_address_set(struct rte_eth_dev *dev,
 			struct rte_ether_addr *addr)
 {
-	if (mac_address_set(dev, addr)) {
+	if (bond_mac_address_set(dev, addr)) {
 		RTE_BOND_LOG(ERR, "Failed to update MAC address");
 		return -EINVAL;
 	}
@@ -3617,7 +3616,7 @@ bond_ethdev_priv_dump(struct rte_eth_dev *dev, FILE *f)
 	return 0;
 }
 
-const struct eth_dev_ops default_dev_ops = {
+static const struct eth_dev_ops default_dev_ops = {
 	.dev_start            = bond_ethdev_start,
 	.dev_stop             = bond_ethdev_stop,
 	.dev_close            = bond_ethdev_close,
@@ -3692,7 +3691,7 @@ bond_alloc(struct rte_vdev_device *dev, uint8_t mode)
 	internals->mode = BONDING_MODE_INVALID;
 	internals->current_primary_port = RTE_MAX_ETHPORTS + 1;
 	internals->balance_xmit_policy = BALANCE_XMIT_POLICY_LAYER2;
-	internals->burst_xmit_hash = burst_xmit_l2_hash;
+	internals->burst_xmit_hash = bond_xmit_l2_hash;
 	internals->user_defined_mac = 0;
 
 	internals->link_status_polling_enabled = 0;
@@ -4257,7 +4256,7 @@ bond_ethdev_configure(struct rte_eth_dev *dev)
 	for (i = 0; i < internals->member_count; i++) {
 		struct rte_eth_dev *member_ethdev =
 				&(rte_eth_devices[internals->members[i].port_id]);
-		if (member_configure(dev, member_ethdev) != 0) {
+		if (bond_member_configure(dev, member_ethdev) != 0) {
 			RTE_BOND_LOG(ERR,
 				"bonding port (%d) failed to configure member device (%d)",
 				dev->data->port_id,
-- 
2.47.3

