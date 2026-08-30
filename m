Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C787C61DEB
	for <dpdk-dev@archiver.kernel.org>; Sun, 30 Aug 2026 20:27:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A94584067D;
	Sun, 30 Aug 2026 22:27:13 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 91CA040663
 for <dev@dpdk.org>; Sun, 30 Aug 2026 22:27:12 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-38dfe910e9dso3210842a91.3
 for <dev@dpdk.org>; Sun, 30 Aug 2026 13:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788121632;
 x=1788726432; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R4eXIDihRhUW7QRGzJaPuM11Gs/KpeBI3Mf6omy22m8=;
 b=YTqX+ZFsFAvwM665J3fto+fPn/exWe+Am0ZnbIcTYFLmz1dvkB3tstBQeKbtyTPunh
 vpO2h59tJi1SjCRSuxQqNhrw6gqinznvXcSC9JYznili1B9cFHomBlAjwVC2xquTHyoQ
 d3LPbo2uLGoP2l0UKBOJjzYL4gtxMLEcq+FhVgU9AI620w5LJeZphsre9H8fWJQqGW1t
 YNi2DAUu9ore0JvjDhgzePCHKJq39zG6t12CBoesB7e/NFOKDmzFqyJd6uTL1fUIp8V0
 tLN1pD/05hsFWtV/UItS3LYnrcuZMsQQFQiMQXVmvSM6E7J4jgN0pKoko1t4EUf9km7D
 +i+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788121632; x=1788726432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R4eXIDihRhUW7QRGzJaPuM11Gs/KpeBI3Mf6omy22m8=;
 b=l8et9ruCJ3PsVeTQ2fYRe1B/qJKKpmgjzZfmBAKWbPhKD1HieF7zcNHRda99NHmnwR
 4YqPGU0yl0U++vwJN0DNmb38X0QcFHXD5ZtgpYtDAglV7qg+B/0dhLBx5U6apfSuDQAn
 u41GPk0ZSeue2bUFrSAGYHpg8mn66rRNKZTILBUOILwNf30zTLtsugJU+4IzZ8EThoaV
 oMD+M9o1QYAccAozW7SHI158M6KHdua3wdFWh+bDFd4gxKGjLvSTxFhAWAplG/EYRPpx
 H98j5tGm2ukA7E4IT3iwvKkjZg0wCBKv8k705SDQnPcw3Yw7t8hsgeWT/wC+DR6xZ9+V
 Bxsw==
X-Gm-Message-State: AFuF++lV/vkzMQsE5A0hKT6APdrkW9lJa8Mn7F+8ywe97o/dETOhlkJy
 EF+G45yHE9hkkdK/73qZ7g+3ASC28luFL6vTKk2DeDfXZhd04nRFD/ScZbDhGJ6AV3ZbOHMzN3h
 AK7j0
X-Gm-Gg: AYBFou1sufUgSziekAWJDojUVssgB4Taqwgytp4T+sz6JbhtVhFA1deHuYS/5TXJ4aM
 lE3sNqG8Z1ONUpzLj6I4ZjIzTUttGYo8JNGpkouDJyEhjWp/MVt0dLDfnXGSKASezOPnmuEmOqw
 GbgXKBQdJSRNK7UDkBZPCbLXDoN8+hIRmOMijm2AwxEA4RgBcERbt97wrbJz3hoZZ8EglcgCUDZ
 w7ykhyzgp/mCwLSfP6IfODjBHn7q+aareYp0Pm66nj9/ou4J8BMJmXghJ6KEP0dP0Xk9BQDCV2t
 rB9sN62Zs+ZFXIfj7Fdh9Srl99iH2aGfn4e8Al0Q1adrSxBampcFLT59iLxDYLQcJL04GYhsL1Y
 tVQ33l+5Jdcctbwb1tKWQIaXGaS77IGNbA1A0Rrr+0X+mfpwA8+Kb71p63Ut2OLt9Xg7PqDYLSM
 7ySmyv+V5jWUsBpT63kKQBR4s/JN7yy86qzIBFn2n0bCZZLT5cghWfauoklFgpBho/80zRW1mw2
 YddGH2SCRohkWxdNcqTrPj1MmU=
X-Received: by 2002:a17:90b:2d04:b0:390:8361:a532 with SMTP id
 98e67ed59e1d1-396d0ebfb40mr38699286a91.7.1788121631735; 
 Sun, 30 Aug 2026 13:27:11 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd5c34sm17683165a91.8.2026.08.30.13.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 13:27:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH 6/8] net/bonding: add extended statistics
Date: Sun, 30 Aug 2026 13:23:48 -0700
Message-ID: <20260830202636.760014-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830202636.760014-1-stephen@networkplumber.org>
References: <20260708174204.72574-1-wpan3636@gmail.com>
 <20260830202636.760014-1-stephen@networkplumber.org>
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

