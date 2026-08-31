Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB3CC624A5
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 16:11:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30EE8402E4;
	Mon, 31 Aug 2026 18:11:32 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 8C515402E4
 for <dev@dpdk.org>; Mon, 31 Aug 2026 18:11:30 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2d91518a63fso12236465ad.0
 for <dev@dpdk.org>; Mon, 31 Aug 2026 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788192690;
 x=1788797490; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RfMAHDReZJQEPit0TIHxdf1WNVUhFzkErw6+FTDG410=;
 b=CcQOoHPfSw/Y6AznqtfFMXF8poHpE+NuLYx7KgTCwEZIum6tDolQPOkvlEQehfR6hS
 JV6PGOxfp276pTR5TDI30o2IqHp+Jk4dcOZ1poJvkBTE+UvmHL3igeYD5iBjiO/iKLg4
 w5AWXLIVzW/k/U1rz0rRO1R2gxCSlJBshUVRkbHc2dj/fThtF4bJNyhJdlBopuN3OipH
 O2jCCxV8Z5463xm8UDNfdZCHNUOyP7J0Yliwqok+LKCWhDmG+nis/AZOvaPqu3CiMZc7
 l/Kxcd9baRE6dttN08R+nwRPGixvCf1eXuQ2XKfITct+5+MF34NmWqL7t7P+CXmr65Tx
 IV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192690; x=1788797490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RfMAHDReZJQEPit0TIHxdf1WNVUhFzkErw6+FTDG410=;
 b=WDq9jMh/EPX+R7H7CEqFecQdcKfpHb8g7Idrts8FptNWvalzzOomp2WC+ng5ytQeqD
 TrPFlG9iMeJfpOJaV0vmqEoPqeC/VPz27HBNygQZ50vsJJN9JTEjvi1QaW6kc3hi8ubV
 L3YKz6xd1SE07HNiI8barDBDh1Ox55JHAg+PvHTCnpEMWFYsBio2zlVpSWjV+hu7sNWP
 Xk0pfP9iUPCczca26H0Ny6Ynsv5pkNpuX6zFLvxUZMhBEDjE3ryZ0dj9LmdvmtlTKHHG
 RgtJ8qHdTVn+vowjIZNcr5i0CBahreYepLeIRSzVaHf9q6FDW4H1WK8WJTpdN+FqCg7U
 yBXQ==
X-Gm-Message-State: AFuF++koNZH6IdIdT1qL0yWnHfjq3tSCzcLv8NeZaqhBCGyDCNfBhnTX
 2J0E++TPuSf010WRp0OeCeVCSU2R2DYyFJgay2CLWAVSaGUOLTyrPiQpBHl0vrV3/XCriSBKlLY
 vp/dV
X-Gm-Gg: AYBFou28hZ83NZA2S811OqrO7z2TkuTynqT9iE/nzngzxISCETZIjX0rmqEd2pos6kg
 iny47nOcJV+uMelIz1yzIqBMlyc6CTd6tDhRY7ILTai5+SMaDlGaixdrAeDXXy5/71F+4KCJLic
 aLGJ9/w2kGY9Frirz50VO5iW1EydR0PRGLIV9WVU+uKv+QwCtlOftHCFVb557iK7ZZB27mBvTZl
 SqR43ltlHwrJkQHmX5InCQ4Lw+e8fnTY+5V1fA+NrEHxYuaij0Cn4RHS3Q9qPEn+TaGii3DP29C
 VDoWdf4haSd+D2wn3ZXwZkKdWYyT01nDAFhbyvcXtj1bknux9/rOrqkwMKUE6DVLbCPhxophleO
 sVxOOCtctL5laaMWIuMAOdy+zLwFvq+b64jowawrZTtG8hDAnL3nl7K57mFg5NsxxQHxbZE4wIM
 h/NGy64kCYrD2vwbe/pSPOGjq+FGf1oPJf6GCyR3JN1c1uj9XQHPgyg3UA5R73tZuTCh92e+KPd
 hQp+fmPDVs4Ww8D/NVfJIWoIj8=
X-Received: by 2002:a17:902:f68c:b0:2d8:d4cd:dc8f with SMTP id
 d9443c01a7336-2d8d4cddf3dmr241877935ad.18.1788192689533; 
 Mon, 31 Aug 2026 09:11:29 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f7be607sm31355741eec.10.2026.08.31.09.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:11:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Declan Doherty <declan.doherty@intel.com>
Subject: [PATCH v2 3/8] net/bonding: skip unavailable members in device info
Date: Mon, 31 Aug 2026 09:06:43 -0700
Message-ID: <20260831161105.289670-4-stephen@networkplumber.org>
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

bond_ethdev_info() queries every member to derive the maximum number of
Rx and Tx queues the bonding device can support. A single failing
member aborted the whole call.

Skip members that cannot be queried and derive the queue limits from
the rest.

A bonding device with no members at all keeps reporting UINT16_MAX, as
it did before: no member has constrained it yet.

Fixes: acfb51e2fe96 ("net/bonding: fix number of bonding Tx/Rx queues")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bonding/rte_eth_bond_pmd.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 6235c07679..7579b97b06 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -2360,28 +2360,40 @@ bond_ethdev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	/* Max number of tx/rx queues that the bonding device can support is the
 	 * minimum values of the bonding members, as all members must be capable
 	 * of supporting the same number of tx/rx queues.
+	 *
+	 * A member may be unqueryable here: it can be removed concurrently, or
+	 * simply not be probed in this process. Skip those, but do not report
+	 * the UINT16_MAX default if no member could be queried at all, since
+	 * that would let any queue count pass rte_eth_dev_configure().
 	 */
 	if (internals->member_count > 0) {
 		struct rte_eth_dev_info member_info;
+		uint16_t queried = 0;
 		uint16_t idx;
 
 		for (idx = 0; idx < internals->member_count; idx++) {
 			member = internals->members[idx];
 			ret = rte_eth_dev_info_get(member.port_id, &member_info);
 			if (ret != 0) {
-				RTE_BOND_LOG(ERR,
-					"Error getting device (port %u) info: %s",
+				RTE_BOND_LOG(WARNING,
+					"Skipping device (port %u) info: %s",
 					member.port_id, strerror(-ret));
-
-				return ret;
+				continue;
 			}
 
+			queried++;
+
 			if (member_info.max_rx_queues < max_nb_rx_queues)
 				max_nb_rx_queues = member_info.max_rx_queues;
 
 			if (member_info.max_tx_queues < max_nb_tx_queues)
 				max_nb_tx_queues = member_info.max_tx_queues;
 		}
+
+		if (queried == 0) {
+			RTE_BOND_LOG(ERR, "No member device info available");
+			return -ENODEV;
+		}
 	}
 
 	dev_info->max_rx_queues = max_nb_rx_queues;
-- 
2.53.0

