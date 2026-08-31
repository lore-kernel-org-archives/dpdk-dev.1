Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDBFC624A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 16:11:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6ACC9402E9;
	Mon, 31 Aug 2026 18:11:20 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id C091B402E9
 for <dev@dpdk.org>; Mon, 31 Aug 2026 18:11:18 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-cc1c7364550so3898750a12.1
 for <dev@dpdk.org>; Mon, 31 Aug 2026 09:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788192678;
 x=1788797478; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DUsEVuxhv72Xh4emCxLNhs5aAH3hXcxcZi7c2D/ypcs=;
 b=vtHVOySWvUMigOwo5Oe17lTZGcWy66cbJWmXlw37bExLbWrkJnre9c9hIbx+X4b7Ou
 XJzncikfHGMznDUDkSutqtprkagIrwYVOE2vrOPHiiAbD0kQCeLizk0Awu0sOnReVGuH
 b2TFH8a3JlmWugpv4rIM8iqFfSYdQjA5T9j05F2p8/QWMlt7uyOUyKon+TNdCAYW49ho
 VNqxfi8lXueLMUqnvsJX/hJL3II/MI8kqyuVphfsnNBU6Zb8cIsMtCYF5qM7pS+JdFcg
 iWfuB7sZ4LBKL8Zt7lJElPIULeIIDnNbixi72WCC9i+dz1BRxkxKJkeqRoFulfTsXYCO
 yJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192678; x=1788797478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DUsEVuxhv72Xh4emCxLNhs5aAH3hXcxcZi7c2D/ypcs=;
 b=USa7tb4Hnea8fahihUsiOjcad9L5C5irrF3Pg7Xh7huahWBtKq9+zQoC1M4tuTQ4wk
 Kpxv26VVHzAMqRsRtjZWUZ1iUmaUimz2zVKQM5k0mf8/hK7c4LQ8pMbt3Mh3c9GEk8/R
 gZB364FG/14TWnoy4f4DUQJXZi6ZNX+F9URpKB7k6WyWQEL4DooRNdRgWc3oihmtp7Uv
 Q1Hdy8XnskYly0DVnoMFTJMCpn2cc60EK/X6WD4f4jchThQdX7CBnzPz0Wx3k0fptFmg
 XJcvaLREsbr34aAh7cKt7ec6nSF+kPt3M3S3VDtT5dM+KAaBGY2ixLn34BXlCdWs9XGo
 liIg==
X-Gm-Message-State: AFuF++k30tqNCZ/J8HvizDHUqOCvoS/8OVGyfNKqBNU+62s2b6pYF5vz
 EXGwk0JVWQtC1AqKvVRG4jEmI1fu6fuTjIYZlbqJv5/a64Pj5KQbmQ+GWjb83kyhEaENoN07buM
 qBoGS
X-Gm-Gg: AR+sD13sBANu9b7aPV0jqVXJLI/6pxYbIOSAJ4AGzV1N3o0X/LbXkxT0MVQRrsuqRhb
 NjMlnzKAi6UpSClTE2/xha7CV4LiIuKL9EusgZa5IkC/OyD2fkI4O837aRyDyiSyUbCpCle+NcK
 vtxg3cX/SEajGAXCT8V9/MTV00f4Vrpz93Y5ikH9ZS7EgZ1iE0TJw+xPcoXfCnHq1K/Gg8AKK0l
 64Zd4tBtMwXZP8Yx1SDM654UZN1qRXBodbEOCLiasCgaQJK6l+D1UQ49uElGefiZtG/i3G12A4b
 gYS9xn6WCLGs+/4r9yb/zowf1nY6iKVLSUhrmth9s5vjNw76tZZvnHlCYWdf7LW28szcSrfXfOp
 El8+ektWn5iExZeaaVZQ47C4x+T8vwP0O/qQajtVNeQ6Jc9ABEAef7y8j0nl8RtScU/utCoztad
 2qFBmqP874mktm0h4TJ6lJgGEddgIuudPJroiXu+BONcHNR2Yy9wtRqGFtc6YDrrEngttOd+LBT
 s7bYTWBZrjoIgT4F1ha8NznmpE=
X-Received: by 2002:a05:6a21:d86:b0:3cc:2552:ddd7 with SMTP id
 adf61e73a8af0-3d7adeb5a49mr3334586637.5.1788192677702; 
 Mon, 31 Aug 2026 09:11:17 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f7be607sm31355741eec.10.2026.08.31.09.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:11:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Igor Romanov <igor.romanov@oktetlabs.ru>,
 Declan Doherty <declan.doherty@intel.com>,
 Daniel Mrzyglod <danielx.t.mrzyglod@intel.com>
Subject: [PATCH v2 1/8] net/bonding: fix TLB member ordering with unusable
 member
Date: Mon, 31 Aug 2026 09:06:41 -0700
Message-ID: <20260831161105.289670-2-stephen@networkplumber.org>
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

The TLB rebalance callback assumed every active member could be
queried. If the link is down, has no usable speed, or stats fail,
the member was ordered on garbage bandwidth values.

Skip such members. Transmit reads active_member_count entries of
tlb_members_order but only measured members are written, so pad
the tail rather than leave stale port ids behind.

Members are not deactivated here; the link status callback owns
that and also updates the primary port and bonding link state.

The callback runs every millisecond, so an unusable member logged
1000 times per second. Log only on state change.

Fixes: fc1134c79283 ("net/bonding: check status of getting link info")
Fixes: 7c76a747e68c ("bond: add mode 5")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bonding/rte_eth_bond_pmd.c | 99 ++++++++++++++++----------
 1 file changed, 62 insertions(+), 37 deletions(-)

diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 6a4f997b5a..5b4b3d6ac2 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -33,6 +33,7 @@
 
 /* Table for statistics in mode 5 TLB */
 static uint64_t tlb_last_obytets[RTE_MAX_ETHPORTS];
+static bool tlb_unusable[RTE_MAX_ETHPORTS];
 
 static inline size_t
 get_vlan_offset(struct rte_ether_hdr *eth_hdr, uint16_t *proto)
@@ -865,8 +866,10 @@ void
 bond_tlb_activate_member(struct bond_dev_private *internals) {
 	int i;
 
-	for (i = 0; i < internals->active_member_count; i++)
+	for (i = 0; i < internals->active_member_count; i++) {
 		tlb_last_obytets[internals->active_members[i]] = 0;
+		tlb_unusable[internals->active_members[i]] = false;
+	}
 }
 
 static int
@@ -890,22 +893,10 @@ bandwidth_cmp(const void *a, const void *b)
 }
 
 static void
-bandwidth_left(uint16_t port_id, uint64_t load, uint8_t update_idx,
-		struct bwg_member *bwg_member)
+bandwidth_left(uint64_t load, uint64_t link_bwg, uint8_t update_idx,
+	       struct bwg_member *bwg_member)
 {
-	struct rte_eth_link link_status;
-	int ret;
-
-	ret = rte_eth_link_get_nowait(port_id, &link_status);
-	if (ret < 0) {
-		RTE_BOND_LOG(ERR, "Member (port %u) link get failed: %s",
-			     port_id, rte_strerror(-ret));
-		return;
-	}
-	uint64_t link_bwg = link_status.link_speed * 1000000ULL / 8;
-	if (link_bwg == 0)
-		return;
-	link_bwg = link_bwg * (update_idx+1) * REORDER_PERIOD_MS;
+	link_bwg = link_bwg * (update_idx + 1) * REORDER_PERIOD_MS;
 	bwg_member->bwg_left_int = (link_bwg - 1000 * load) / link_bwg;
 	bwg_member->bwg_left_remainder = (link_bwg - 1000 * load) % link_bwg;
 }
@@ -914,44 +905,78 @@ static void
 bond_ethdev_update_tlb_member_cb(void *arg)
 {
 	struct bond_dev_private *internals = arg;
-	struct rte_eth_stats member_stats;
 	struct bwg_member bwg_array[RTE_MAX_ETHPORTS];
-	uint16_t member_count;
-	uint64_t tx_bytes;
-
-	uint8_t update_stats = 0;
-	uint16_t member_id;
+	uint16_t active_count = internals->active_member_count;
+	uint16_t member_count = 0;
+	bool update_stats;
 	uint16_t i;
 
 	internals->member_update_idx++;
+	update_stats = internals->member_update_idx >= REORDER_PERIOD_MS;
 
+	for (i = 0; i < active_count; i++) {
+		uint16_t member_id = internals->active_members[i];
+		struct rte_eth_link link;
+		struct rte_eth_stats stats;
+		const char *reason = NULL;
+		int ret;
 
-	if (internals->member_update_idx >= REORDER_PERIOD_MS)
-		update_stats = 1;
+		ret = rte_eth_link_get_nowait(member_id, &link);
+		if (ret == 0)
+			ret = rte_eth_stats_get(member_id, &stats);
 
-	for (i = 0; i < internals->active_member_count; i++) {
-		member_id = internals->active_members[i];
-		rte_eth_stats_get(member_id, &member_stats);
-		tx_bytes = member_stats.obytes - tlb_last_obytets[member_id];
-		bandwidth_left(member_id, tx_bytes,
-				internals->member_update_idx, &bwg_array[i]);
-		bwg_array[i].member = member_id;
-
-		if (update_stats) {
-			tlb_last_obytets[member_id] = member_stats.obytes;
+		if (ret < 0)
+			reason = rte_strerror(-ret);
+		else if (link.link_status == RTE_ETH_LINK_DOWN)
+			reason = "link down";
+		else if (link.link_speed == RTE_ETH_SPEED_NUM_NONE ||
+			 link.link_speed == RTE_ETH_SPEED_NUM_UNKNOWN)
+			reason = "link speed unknown";
+
+		/*
+		 * Skip the member rather than treat it as idle, which would
+		 * sort it first and attract traffic. Deactivating it is the
+		 * link status callback's job. Log only on state change,
+		 * this runs every millisecond.
+		 */
+		if (reason != NULL) {
+			if (!tlb_unusable[member_id]) {
+				tlb_unusable[member_id] = true;
+				RTE_BOND_LOG(ERR, "Member (port %u) excluded from TLB ordering: %s",
+					     member_id, reason);
+			}
+			continue;
 		}
+		if (tlb_unusable[member_id]) {
+			tlb_unusable[member_id] = false;
+			RTE_BOND_LOG(INFO, "Member (port %u) usable for TLB ordering",
+				     member_id);
+		}
+
+		bandwidth_left(stats.obytes - tlb_last_obytets[member_id],
+			       link.link_speed * 1000000ULL / 8,
+			       internals->member_update_idx,
+			       &bwg_array[member_count]);
+		bwg_array[member_count++].member = member_id;
+
+		if (update_stats)
+			tlb_last_obytets[member_id] = stats.obytes;
 	}
 
-	if (update_stats == 1)
+	if (update_stats)
 		internals->member_update_idx = 0;
 
-	member_count = i;
 	qsort(bwg_array, member_count, sizeof(bwg_array[0]), bandwidth_cmp);
 	for (i = 0; i < member_count; i++)
 		internals->tlb_members_order[i] = bwg_array[i].member;
 
+	/* Transmit reads active_member_count entries, don't leave stale ones. */
+	for (i = member_count; i < active_count; i++)
+		internals->tlb_members_order[i] = member_count > 0 ?
+			bwg_array[0].member : internals->active_members[i];
+
 	rte_eal_alarm_set(REORDER_PERIOD_MS * 1000, bond_ethdev_update_tlb_member_cb,
-			(struct bond_dev_private *)internals);
+			internals);
 }
 
 static uint16_t
-- 
2.53.0

