Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAC5C61DD9
	for <dpdk-dev@archiver.kernel.org>; Sun, 30 Aug 2026 20:26:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FCFB402B3;
	Sun, 30 Aug 2026 22:26:51 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 15E184025A
 for <dev@dpdk.org>; Sun, 30 Aug 2026 22:26:50 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-398b3d66515so1228831a91.0
 for <dev@dpdk.org>; Sun, 30 Aug 2026 13:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788121609;
 x=1788726409; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DUsEVuxhv72Xh4emCxLNhs5aAH3hXcxcZi7c2D/ypcs=;
 b=0s4BLzVhxqHDv9KftJupai2bWN+Qh3MFuDuX+wlGmGGiMYzOHeD4bQXuandnQfE6vA
 p8O27qn9q0/mczXUO/i/++gJIvSTrbbBgPRTEaAzAJpaB7GtVIs5LcxpW2JymMt46FyJ
 a2lj3I1XWDuV3XMIddPRb6VlYXf4c2Ew4oX+/WnWLFMi326bceYCkESPNVEOwP5ywHnm
 G/ZueGcHS0+3jtRbQmEPP7zWfzXJtLVtrKKlfxr6wCBxeOaLM4xIzfS6hNbuKskRzzWf
 Rz86KWSQMNkWNTAhhSh+2JQ43hJvjQLjtVt4TO/8+/KX9ROCWX30l8HVcoqyebzNy0yU
 qcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788121609; x=1788726409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DUsEVuxhv72Xh4emCxLNhs5aAH3hXcxcZi7c2D/ypcs=;
 b=fLdObDmSPb8rzC+NV4EZQYdcK0y255kVqWP1V+hwl2vbUMl7iGeqd/mj1gnuToYWI+
 NLWyR5AzY+hHO+C5Y5BLYJL5UBp5LdrNo/flaSNUo0HlXACDjm8ouTDoibDq0W6hbmAf
 Lh/ssb4HECy2sIrNRLaxRPXaePd26NojAO41Q4OlcAsth41c/rj19LjYZuyz89VJ84pO
 h8TlsrKMp1UOn936NjGOadVOOU6m0qQT7yImU0YvA0OUxeaOjLGiBNnHAkIOmB7CsXPJ
 Sy71Wqe9W0ebAwORPPm4fKSYlCnwhmw7oiTYV3/4NIYc+xpzGpIRqCtwDXs+FEJibSTo
 QqLw==
X-Gm-Message-State: AFuF++nCwtXl7V0GpenQTmk4PDffnd2mNflgoF6HOV6gS7K6onTeNVY0
 QRFQQd/ihaPNTFJwLTh0NApy7FI8Mq94miDI3Plobo/bkjM7R24Zf5wHmGtKAGUU6w2etYKesrF
 UD18T
X-Gm-Gg: AYBFou0a0Q/BZrz/IRyKNlO4QjCZ/N6LZedaeQzGd0Vr7fFdEQyUBWY+97wtK0ej0Sn
 Z1d3bykKmtVyG7GauIffmTfOPYjd3owJUeblg+r7HMEpM3zh0oLqJT/Bgz5fGApR0DPCkKaNN6E
 8E45k0kqHuVZtw88eWbazVw3e5W26GJKO9myphyBZO7Q2Ua6Bl2T1QxeYFNM3Q+1gyhcsgf0RIJ
 HESC2qcfQLTgzSzPJxokNJbKFos6Txr9g1qsuhIZMPnsULv62Hf7djcVGGnphlsuAQlym2mJ5mE
 tVutfyfia8Hh6L3S9dGQbFSCb5nGotBoo34BhAyKTzKeE/iMxlBXkACwrxMFukzx/SJ3G/oJlTd
 +cVGrZMZjgA+pa+TYarA9W5W6oAUSiQwLeORFN5YVBp///FUM+z0c3TgDkByU0B+AC7fkk8Pvvm
 9EK8+FqOMl9sfEKXzuNlwUjWNfAIOnBiboqCGI0icbbO/J8mN9NvjKgrQOl87vBvApRK2BKarG5
 CxQl4dui/cwnOOtfmNhh3oxFi8=
X-Received: by 2002:a17:90b:4a06:b0:38e:9045:bac0 with SMTP id
 98e67ed59e1d1-396d0ea50b4mr30491575a91.5.1788121609172; 
 Sun, 30 Aug 2026 13:26:49 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd5c34sm17683165a91.8.2026.08.30.13.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 13:26:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Igor Romanov <igor.romanov@oktetlabs.ru>,
 Declan Doherty <declan.doherty@intel.com>,
 Daniel Mrzyglod <danielx.t.mrzyglod@intel.com>
Subject: [PATCH 1/8] net/bonding: fix TLB member ordering with unusable member
Date: Sun, 30 Aug 2026 13:23:43 -0700
Message-ID: <20260830202636.760014-2-stephen@networkplumber.org>
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

