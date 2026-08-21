Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28FAC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:30:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E39D140B8D;
	Fri, 21 Aug 2026 21:29:43 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 00D3540289
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:29:41 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cbedbaba5fdso882946a12.0
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340581;
 x=1787945381; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jIev71qLRRHn/s/7s+HKKz2yRmRFpmM2FbiMXANh0Hg=;
 b=zwB3NQIRtu4ba/unPTAd+RSuajkJfGYxxdaPbvY6QIPwjkWPZ+Fcw90qpPIW7GNhky
 PDGahh1HdDfaFv2TZepHwZBViTBZXxX2iM/FFez7DzPab+pCkXpbGhdJ1dopGRRr3ESM
 oJeqyGcDcbE4atYJXuMtEfXb8sHBst0HZ0elP5IDCq6j+8/6g7wzENtjltUgtkPq6qD3
 mg4bHtVHlhcp0iy7cwIwbKcGBSBzlijtSh3XM2AfDD16ZI2uPGwy+rPe03t0U+nyXDLK
 Y3KFwOSyX1QvYcMzoX/v/NqQlRQB6uHmaA1TDo7GfNQv+GXMlXnCNYD9y5tOhAZCoQjI
 5UJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340581; x=1787945381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jIev71qLRRHn/s/7s+HKKz2yRmRFpmM2FbiMXANh0Hg=;
 b=APMkzbCZzuAVu+E1Kxd3WaLwb9K9TUpeqb2ws4EA3l4D0RALk3oC/64yMID2vMngfm
 8d/4ajnz6RDniXZMSLm9wqWE/XW9brxz9GjVov/4rnpOTHqpBxlKii/toPNviD83gC6o
 S1laSmlccDvATBA8tYgsDTQHBFKhnmEAKyCPM40snKIsnt2yVtjjT6hEwBV4n+55ahax
 LTkbJHUlK9bYUj17lfy8qARfuBJWPLJS2WJQASnoc5y7KJ5vg08JNkEggoDjZIjG/ozO
 1fuTDO9INoJVzyc4JXaUt89+cLK3yOPqonROzLBPlMbPtw8bLCFUoyfwBqt4tJTe9Yaf
 6YRg==
X-Gm-Message-State: AFuF++kiixPdphDRWWbvdoBA/ohq+lweFtmOg5QcEB2DKp4iMpX3+u7O
 qIimt89z2/FbsQ1JLdP2vAqivjpi+j23F0nhX88gQNNJJLilwPiCCc/pxHUrkSDXu2FMzfNZxY5
 zReE+s6E=
X-Gm-Gg: AR+sD12RAvu9UbTHB3VC1XtAodZKgLABs7oLmervczsraVPdKxRtsJpdl2trmsFycEK
 vZnp/DZLbP51goa98zPSYX7EMO+ddYctQSiHzUrJWeV9Y+K75ziSDsV9icm57fyv9IOAd6EvT4J
 2y185hkvvhbsHjxiyxvuC4POEWZKMY/jFF5uxS0f1BdriKQVkgSVpydM1jCQYw+yMWliTW6bzFg
 rmJbdL1sNZFYACXmkwJAdc8+sO3ajUJtIKf3WAE1RxJVLgzYiZj5aD3avRjDmBxdv24pJWuSjY/
 Fy77llZAW5dFNLO4d14Ik6sJil0JVJ2ehgLQ6kliodCArYUw4w1R296VNyu/buEih58nmxKcJs6
 h6BZw/kSbVkUSVJwlaAhJwYgV8/M9d934E/9FVIgdxG4Ba9x08oAo7veiVhRG6PmTiJXACCBwhp
 su/FjugWaIJtWFKrin0yLNgP/N75Gjr5YTNmlx3i3S6VZ98qtM2kRxIA0FAAMQmlskJh1byW8jK
 dWpo4fc2tkESt1uDZVMhorckZTF
X-Received: by 2002:a05:6a21:9d48:b0:3cc:fe21:bf6c with SMTP id
 adf61e73a8af0-3cd3009d046mr18448422637.11.1787340581107; 
 Fri, 21 Aug 2026 12:29:41 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:29:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH v2 29/68] net/bonding: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:24 -0700
Message-ID: <20260821192646.146382-30-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bonding/rte_eth_bond_8023ad.c | 4 ++--
 drivers/net/bonding/rte_eth_bond_flow.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/rte_eth_bond_8023ad.c b/drivers/net/bonding/rte_eth_bond_8023ad.c
index d1f30229d0..6d970153cf 100644
--- a/drivers/net/bonding/rte_eth_bond_8023ad.c
+++ b/drivers/net/bonding/rte_eth_bond_8023ad.c
@@ -1548,10 +1548,10 @@ rte_eth_bond_8023ad_member_info(uint16_t port_id, uint16_t member_id,
 	info->selected = port->selected;
 
 	info->actor_state = port->actor_state;
-	rte_memcpy(&info->actor, &port->actor, sizeof(port->actor));
+	memcpy(&info->actor, &port->actor, sizeof(port->actor));
 
 	info->partner_state = port->partner_state;
-	rte_memcpy(&info->partner, &port->partner, sizeof(port->partner));
+	memcpy(&info->partner, &port->partner, sizeof(port->partner));
 
 	info->agg_port_id = port->aggregator_port_id;
 	return 0;
diff --git a/drivers/net/bonding/rte_eth_bond_flow.c b/drivers/net/bonding/rte_eth_bond_flow.c
index 5d0be5caf5..bb9d347e2b 100644
--- a/drivers/net/bonding/rte_eth_bond_flow.c
+++ b/drivers/net/bonding/rte_eth_bond_flow.c
@@ -182,7 +182,7 @@ bond_flow_query_count(struct rte_eth_dev *dev, struct rte_flow *flow,
 	count->hits = 0;
 	count->bytes_set = 0;
 	count->hits_set = 0;
-	rte_memcpy(&member_count, count, sizeof(member_count));
+	memcpy(&member_count, count, sizeof(member_count));
 	for (i = 0; i < internals->member_count; i++) {
 		ret = rte_flow_query(internals->members[i].port_id,
 				     flow->flows[i], action,
-- 
2.53.0

