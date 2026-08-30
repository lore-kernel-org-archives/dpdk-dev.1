Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECB9C61DDE
	for <dpdk-dev@archiver.kernel.org>; Sun, 30 Aug 2026 01:15:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5B7D4026D;
	Sun, 30 Aug 2026 03:14:59 +0200 (CEST)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50]) by mails.dpdk.org (Postfix) with ESMTP id 57A604025A
 for <dev@dpdk.org>; Sun, 30 Aug 2026 03:14:59 +0200 (CEST)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-7e6b5737bb2so2951631a34.1
 for <dev@dpdk.org>; Sat, 29 Aug 2026 18:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788052498; x=1788657298; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i4In/YdQwzAFukzQo1cHs0G+k5Koz/Eommzez3WYi2o=;
 b=BfcWHurvX9nb270wB9se1XOT027FwFeLtFUaj4kp14hL/a0vjYzG3TVOdUbnRm1pDs
 huQgXiruTxFNrRkUcFOkGeFM4iSg1lyyS8MoDWTPKxen/w/Qt4iO5JwH4BANqvDo5tyT
 IBZWQZA0ZkhxJxwkaU/frGMHqGEh5orZ/YPoXFt87qnibBszLx1cDNFS5bJ0dstp87Pt
 d3gmLmy43IDRfkStgxwCAdnoeMiABeJUXXT3PU2xsoe09ru/ZK/NR2/gbZElBPx/wxA0
 V4HLgNeCXSReYsPwhtQbsjxHRHlgolL2hSQ+Y+rCGVryN+lbWpGZjTwliyhs/TXA8YwY
 1YlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788052498; x=1788657298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i4In/YdQwzAFukzQo1cHs0G+k5Koz/Eommzez3WYi2o=;
 b=bWWgLYDjC/4bKUJKfd5Efn/zQq8lvCRjDDpD7XEHblJkxFhdqY/efMtC8SZlbGwDxP
 HdwGGm+EExBRSz1GZt83TRudOH01cvYTf2VlNJmbWaW26bM/+7rrbL8JZzhNnIbNrmkp
 WuAp5EJoCTCZMcvRO6A2OC+gWN55oDkFNF9XQphtmLn/C4lgwG9nvhUZVbrnu6Akc5ck
 av8GJpfVhoQZtKjO4ep8b+CQ4CL9WDdJRvZDihgTlaLLjAzzy9kgMSJCZWuecRxdBtKg
 fsGBkAIj/Sg+zeQR05f2miLMw6BxR2lvB538ttotMsZ4RF7N6EoOn3rJsD1PuIcLSBdA
 F7sw==
X-Gm-Message-State: AFuF++nzLgqyFVwBQxYkcXL8t/btHVlbUJVB2cf150NZ23SmHuYt9tUE
 xz+ayCTwPAt2RwHLPuBG/asYDNLXmThd4PhyhrDk/6uoj6UqUffTevNt
X-Gm-Gg: AR+sD13TPK0Uyq1obJ+i0DMhBO/ortOZ/4ojQZvzNDUzbVeBsRbLLo3NQ0LOxnrG/0C
 IBsYk1Kz8slGfTFx+Uu1q6G6nDwpAWOV80kOIKQMH2EG5kR3o87iUKoZJyfBuznR7I5AnYjnfcC
 xPpXs6Z1ihkC1+xC070ErQGPqr6lVLFXs40T/HMR1L+UNNoVXp+lelSryo1Q428te+LSpnpxjep
 XA23cJq7wluu3UzgAOYq1T/y4Sxpa9r7umhKEID3Nm1+B6krmwG/CJzGHdAJVk0Jd1KTD+2ln/M
 Zbv82KSY3GOYCZj1uY4g4rGf47r7mEOo7WPirm33KnH06ioxxX46C4+uCl9RYyKR1beO05zUvtd
 6YJdXqwIE24xXX5oGMirf8fckW2B11YHCCLPaBVd0z6WwNynC6J/XlIpQELDkLL1fB8leDY3jYM
 fo2/LphGQCZUCfJB+xUwNkH4IMa50XxLRuVjNpBIRSEV8mwXyWa4bsXKcpzOt4Hh21RX4HBoVyr
 2Mjew6qNLo=
X-Received: by 2002:a05:6830:235b:b0:7f4:f9fb:fd28 with SMTP id
 46e09a7af769-7f4f9fbff71mr11315690a34.2.1788052498388; 
 Sat, 29 Aug 2026 18:14:58 -0700 (PDT)
Received: from gmail.com (dyn-72-33-2-213.uwnet.wisc.edu. [72.33.2.213])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4fa99d927sm4702369a34.19.2026.08.29.18.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 18:14:58 -0700 (PDT)
From: Weijun Pan <wpan3636@gmail.com>
To: Chas Williams <3chas3@gmail.com>,
	"Min Hu (Connor)" <humin29@huawei.com>
Cc: dev@dpdk.org,
	Weijun Pan <wpan3636@gmail.com>
Subject: [RFC PATCH v4 1/2] net/bonding: skip unavailable member stats
Date: Sat, 29 Aug 2026 20:14:44 -0500
Message-Id: <20260830011445.168073-1-wpan3636@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826161009.37875-1-wpan3636@gmail.com>
References: <20260826161009.37875-1-wpan3636@gmail.com>
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

bond_ethdev_stats_get() accumulates statistics from each bonding
member. If rte_eth_stats_get() fails for a member, the local
member_stats structure may be left unchanged.

Skip members whose statistics cannot be read, instead of accumulating
stale or uninitialized counters.

Signed-off-by: Weijun Pan <wpan3636@gmail.com>
---
v4:
- Add this preparatory fix as a separate patch.

 drivers/net/bonding/rte_eth_bond_pmd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 6a4f997b5a..6f10dbb0c7 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -2677,9 +2677,12 @@ bond_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	struct bond_dev_private *internals = dev->data->dev_private;
 	struct rte_eth_stats member_stats;
 	int i;
+	int ret;
 
 	for (i = 0; i < internals->member_count; i++) {
-		rte_eth_stats_get(internals->members[i].port_id, &member_stats);
+		ret = rte_eth_stats_get(internals->members[i].port_id, &member_stats);
+		if (ret != 0)
+			continue;
 
 		stats->ipackets += member_stats.ipackets;
 		stats->opackets += member_stats.opackets;
-- 
2.34.1

