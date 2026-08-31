Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F22C624A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 16:11:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F41D540616;
	Mon, 31 Aug 2026 18:11:46 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id C8A8340616
 for <dev@dpdk.org>; Mon, 31 Aug 2026 18:11:44 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2cc891373e0so32719015ad.2
 for <dev@dpdk.org>; Mon, 31 Aug 2026 09:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788192704;
 x=1788797504; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R4eXIDihRhUW7QRGzJaPuM11Gs/KpeBI3Mf6omy22m8=;
 b=K8iU4wvKFOLVrbskH3DeVBqEpHe9UbkMZwvJ3X2jacdpwEwZZjDnlVP8OHDIkCEgZi
 0aDyEXn/l6JWKaeYE1pQBtJ8LLUubdzXAjiMdRO5ozcT0D2g2l8dHWF5ixlQ5Eq4+1Kz
 JDpGjBgzMNH2CG+aYyGkHGiHMlcV4IapTe+HNhD7EELJpMODbzOCVfJF6hea/MRq0LMZ
 YC4w+b44cKO6GWjPlyUlVYTaR/RaMSSrGst/7U2ojGo8s23olojrvMJRULHNr5bQFfTX
 KpZQOljUaiVLff5T38qRtao0PaHOaw7AEW8UGimyuSW/Quax3QfXPKHlVssFaCX18CnP
 0ZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192704; x=1788797504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R4eXIDihRhUW7QRGzJaPuM11Gs/KpeBI3Mf6omy22m8=;
 b=AKm9nYruzkps5Y4D1xtqTXy17InStP8GkwLG9Q3XQOgDFubTIaSbbbZzbhOWGna7Kh
 kCZtfJgfAPAkoVLLv1eg2lERTF0/AoepKJTgAV3D8hQSqWNyim8D33HXg/DpxDhzBGUu
 TKbfj5XAZ+VMQWY5e9DW0atDqAbNrheQIRr3kNQ2dUfioMmVJhwvvbKoWGnLxaMfsSLK
 lWJRsi0pgkWBvWQaA4i89z0s7+n4shObCQMktDXER+hiIf1VvgevjdlFVJKwX8A1coBc
 ihMvGTar5vWLlNj0qFPvvQ51NiGWvK/DbosqOjPV/LH4+3Y877BGlyzs5e0rE2R1aU+j
 tciQ==
X-Gm-Message-State: AFuF++mTPD1RCbKz27uBzhniRITtNkAUWaWWBNyL5uOH4tS3sd09j9Dg
 BMlZan0aGdfr3mlTcGZBInlNxbpHyQfGfU6PAO3aKLHTf/FgB8ab3BsBUzw3NZRRpMKAtP1vPAF
 lA+iM
X-Gm-Gg: AYBFou0wJowLa6CWtMlS5U5XIWFtoauhFKwU9Mxy8A3ruRqHH8kahIOws0SKz8n3+lS
 1mV0dih2I3eUiQiVkRTb47WrTTQebE+z2f5JZeL11n/1/liCkxn43mrUciQ/YTpSemkc/HUTabT
 cHN1ectOPbOEGnRHyU3lsXW4sMf7Gk/9FHlBumRfewmpDd5FycN86cilyYxMqoncrDooj+AmjoU
 OXFkHL8ZSCnnTTHnzz9KFAhLVuNBbXziEtbsKQw3GI9QuGjO6oAao2wh0g1tsJ0J+m0NepD/Lf7
 zKxbvgs/wNM+4fuL3RDMAee3pLFJAA4q2lj//yhZspedgWOBtJkNeHa4QQVnLwMwSQyzMGm+kjG
 HpkS5ZTUzdQZR+bNKKdaXOTR75YhcTpcBYDVhhHX8mjfSd31Sy21Uo0qq1czag9x2zE6Ypimjvk
 Oru952idpnrUqkNpA4NToptpnepKZJFmZvcHFvL9rRi/cmmzS5rypK5iNiSy1QMa5nTfKR1XxTJ
 UFxLeyyviuaQ+ClUb0VraC8XbKVCVuw++fcUfc=
X-Received: by 2002:a17:902:ce86:b0:2d7:2edd:d140 with SMTP id
 d9443c01a7336-2d74dbfd59amr387714435ad.3.1788192703662; 
 Mon, 31 Aug 2026 09:11:43 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f7be607sm31355741eec.10.2026.08.31.09.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:11:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH v2 6/8] net/bonding: add extended statistics
Date: Mon, 31 Aug 2026 09:06:46 -0700
Message-ID: <20260831161105.289670-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831161105.289670-1-stephen@networkplumber.org>
References: <20260708174204.72574-1-wpan3636@gmail.com>
 <20260831161105.289670-1-stephen@networkplumber.org>
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

The bonding device reported only the sum of its members, so there was
no way to see how traffic was distributed across them.
This patch adds xstats which reports per-member packets/bytes/errors.

Also drop RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS since driver never
implemented per-queue stats.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |   6 ++
 drivers/net/bonding/rte_eth_bond_pmd.c | 113 ++++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 87c7e81bde..83d70872af 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,12 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added extended statistics to bonding PMD.**
+
+  Extended statistics now report the packets, bytes and errors
+  of each member as ``rx_memberN_*`` and ``tx_memberN_*``.
+  The per-queue entries, which were always zero, are no longer reported.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 0e18ded4a5..46bc1db120 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -2764,6 +2764,111 @@ bond_ethdev_stats_reset(struct rte_eth_dev *dev)
 	return err;
 }
 
+#define BOND_MEMBER_STAT_PREFIX_LEN (sizeof("rx_member") - 1 + 5 + 1)
+
+struct bond_member_stats_name_off {
+	char name[RTE_ETH_XSTATS_NAME_SIZE - BOND_MEMBER_STAT_PREFIX_LEN];
+	size_t offset;
+};
+
+static const struct bond_member_stats_name_off bond_member_rxq_stats_strings[] = {
+	{ "packets", offsetof(struct rte_eth_stats, ipackets) },
+	{ "bytes", offsetof(struct rte_eth_stats, ibytes) },
+	{ "errors", offsetof(struct rte_eth_stats, ierrors) },
+};
+
+#define BOND_NB_MEMBER_RX_STATS RTE_DIM(bond_member_rxq_stats_strings)
+
+static const struct bond_member_stats_name_off bond_member_txq_stats_strings[] = {
+	{ "packets", offsetof(struct rte_eth_stats, opackets) },
+	{ "bytes", offsetof(struct rte_eth_stats, obytes) },
+	{ "errors", offsetof(struct rte_eth_stats, oerrors) },
+};
+
+#define BOND_NB_MEMBER_TX_STATS RTE_DIM(bond_member_txq_stats_strings)
+
+#define BOND_NB_MEMBER_STATS (BOND_NB_MEMBER_RX_STATS + BOND_NB_MEMBER_TX_STATS)
+
+static int
+bond_ethdev_xstats_get_names(struct rte_eth_dev *dev,
+			     struct rte_eth_xstat_name *xstats_names,
+			     unsigned int limit)
+{
+	struct bond_dev_private *internals = dev->data->dev_private;
+	unsigned int count = internals->member_count * BOND_NB_MEMBER_STATS;
+	unsigned int i, j;
+
+	if (xstats_names == NULL || limit < count)
+		return count;
+
+	count = 0;
+	for (i = 0; i < internals->member_count; i++) {
+		uint16_t member_id = internals->members[i].port_id;
+
+		for (j = 0; j < BOND_NB_MEMBER_RX_STATS; j++)
+			snprintf(xstats_names[count++].name,
+				 RTE_ETH_XSTATS_NAME_SIZE, "rx_member%u_%s",
+				 member_id, bond_member_rxq_stats_strings[j].name);
+
+		for (j = 0; j < BOND_NB_MEMBER_TX_STATS; j++)
+			snprintf(xstats_names[count++].name,
+				 RTE_ETH_XSTATS_NAME_SIZE, "tx_member%u_%s",
+				 member_id, bond_member_txq_stats_strings[j].name);
+	}
+
+	return count;
+}
+
+static int
+bond_ethdev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
+		       unsigned int n)
+{
+	const struct bond_dev_private *internals = dev->data->dev_private;
+	unsigned int count = internals->member_count * BOND_NB_MEMBER_STATS;
+	unsigned int i, j;
+
+	if (xstats == NULL || n < count)
+		return count;
+
+	count = 0;
+	for (i = 0; i < internals->member_count; i++) {
+		struct rte_eth_stats member_stats;
+		uint16_t member_id = internals->members[i].port_id;
+
+		/* If member query fails just report zero. */
+		if (rte_eth_stats_get(member_id, &member_stats) < 0)
+			memset(&member_stats, 0, sizeof(member_stats));
+
+		for (j = 0; j < BOND_NB_MEMBER_RX_STATS; j++) {
+			xstats[count].id = count;
+			xstats[count].value = *(const uint64_t *)((const char *)&member_stats +
+					bond_member_rxq_stats_strings[j].offset);
+			count++;
+		}
+
+		for (j = 0; j < BOND_NB_MEMBER_TX_STATS; j++) {
+			xstats[count].id = count;
+			xstats[count].value = *(const uint64_t *)((const char *)&member_stats +
+					bond_member_txq_stats_strings[j].offset);
+			count++;
+		}
+	}
+
+	return count;
+}
+
+static int
+bond_ethdev_xstats_reset(struct rte_eth_dev *dev)
+{
+	const struct bond_dev_private *internals = dev->data->dev_private;
+	uint16_t i;
+
+	for (i = 0; i < internals->member_count; i++)
+		rte_eth_stats_reset(internals->members[i].port_id);
+
+	return 0;
+}
+
 static int
 bond_ethdev_promiscuous_enable(struct rte_eth_dev *eth_dev)
 {
@@ -3710,6 +3815,8 @@ static const struct eth_dev_ops secondary_dev_ops = {
 	.dev_infos_get        = bond_ethdev_info,
 	.link_update          = bond_ethdev_link_update,
 	.stats_get            = bond_ethdev_stats_get,
+	.xstats_get           = bond_ethdev_xstats_get,
+	.xstats_get_names     = bond_ethdev_xstats_get_names,
 	.reta_query           = bond_ethdev_rss_reta_query,
 	.rss_hash_conf_get    = bond_ethdev_rss_hash_conf_get,
 	.eth_dev_priv_dump    = bond_ethdev_priv_dump,
@@ -3729,6 +3836,9 @@ const struct eth_dev_ops default_dev_ops = {
 	.link_update          = bond_ethdev_link_update,
 	.stats_get            = bond_ethdev_stats_get,
 	.stats_reset          = bond_ethdev_stats_reset,
+	.xstats_get           = bond_ethdev_xstats_get,
+	.xstats_get_names     = bond_ethdev_xstats_get_names,
+	.xstats_reset         = bond_ethdev_xstats_reset,
 	.promiscuous_enable   = bond_ethdev_promiscuous_enable,
 	.promiscuous_disable  = bond_ethdev_promiscuous_disable,
 	.allmulticast_enable  = bond_ethdev_allmulticast_enable,
@@ -3780,8 +3890,7 @@ bond_alloc(struct rte_vdev_device *dev, uint8_t mode)
 	}
 
 	eth_dev->dev_ops = &default_dev_ops;
-	eth_dev->data->dev_flags = RTE_ETH_DEV_INTR_LSC |
-					RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
+	eth_dev->data->dev_flags = RTE_ETH_DEV_INTR_LSC;
 
 	rte_spinlock_init(&internals->lock);
 	rte_spinlock_init(&internals->lsc_lock);
-- 
2.53.0

