Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD23C61DE1
	for <dpdk-dev@archiver.kernel.org>; Sun, 30 Aug 2026 16:35:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DF6E4025A;
	Sun, 30 Aug 2026 18:35:51 +0200 (CEST)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50]) by mails.dpdk.org (Postfix) with ESMTP id C49C440151
 for <dev@dpdk.org>; Sun, 30 Aug 2026 18:35:49 +0200 (CEST)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-7ec1e9d3359so2324759a34.0
 for <dev@dpdk.org>; Sun, 30 Aug 2026 09:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788107749; x=1788712549; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gXGnfKDDvhRunv0GWiT3pw+f64joBzRgNDcL3sei0Lc=;
 b=gHaDtp1IijUaMMkIfgloD3J/W2KPuwkFcQoi+daDhcykx6qhVX+u8h5UqJyrVW2/tF
 aha4MF7luTEO32PvdBUprpIEn+JhcHyATKyWlRwF6MRrMyGzxYn+eVUHyJxnXJijVS3n
 dNajI/nPwJQ08pRbKgnDyUNGDT7tCnkRu/xVtQCZ/Jd8+jZd/9KssFCx0mE/a6OnzYAV
 /k872afsWBnoM2DayXohXKfQewQwAMBYGI3cxQZRmfP4IMVSahWKQTwnG1Ah6Jz6OvOW
 tDKObAPGsRgEi4bLjv/HdZERj9g41PVUov05X+LL+XUiJz4V152Zkd9mCKy/0Zj62wM2
 KTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788107749; x=1788712549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gXGnfKDDvhRunv0GWiT3pw+f64joBzRgNDcL3sei0Lc=;
 b=ZMBZZfyZqY7mf587CQ9Q/i5nLZwLTe4Qb6qEVDc5DWuYkg7c8tSrFRJmcPvrm+CXlP
 vD02ku0/Di3pb/ZgXEGn5jatqRwIruyLsz9NylvW3sAAN90ty4OB3U0XUcrS0iIwsB6n
 /uVtRdTRFEHlYkO0klmnik1FVBa0wxVpDu8S5fT0A+FmRkw5bxBLiYan6hvgkRzI892o
 OXf+TByy8NSYJekEbo3a2cHT3YQnqa+PdKgXu4c2pNj6eue8WqQnqfEH0KM3jRIfIABQ
 c5GtvjtSm5wJaMpwrH1n9cif+5xq1U9jso6vjVUhWqXRdjVt6LEtkmJRsQMEJwvM6qU4
 2Hbw==
X-Gm-Message-State: AFuF++mN+VJ6pIaK9mABSlYsGDnRtjUKVSH897CoEQYoNB1cCixzBLtd
 VszU9d79nl6ClrpynRWlH4U1Y7yQ3Sy6WAKf2vwqIoDt4aDFKwn2O2GA
X-Gm-Gg: AR+sD13+b6cHAgwJn9cB/VG6uXyfqvSp13RPlpFf8ib2gQMGpdt6keSFjzPMmH1hf2Q
 CodKtUcnfzPrsMbaxt5VzLZd8d0ay0gTW+dYlJOXjvQ/aAZ1RIlYD4c/PvX3JBjGQ6RCHoVMrth
 vZ69I9VJwGf1EmfxGCiXJwXBrKsI9TgGnQi5yfrcHuF3lShOARic4/1krX40FpsI092JeyaTvlZ
 7CZpTISWLlfO/SU1363OuTAE0lmAte2OUELnml8hZGBcoen37VxdXq8IiuZPG4lkNPBkmr1E5CI
 lG0cICyvH816qlQjmbWviQtU8yR71q2vuIOQ7C04s3S6f1yBB2D34YFy5j0l1nWaDKeJBJYUXCb
 UqjpbUYPuZCrDslYTOBvdqhc4PeV4MfqERVBNChAOuz6ZZBNxTi3TjrOjyYLxXIfDeTUEnlu+Rd
 weO/VW+8kaHCVP58+cpSVUcy5f8W97B94jrYxrXZ6j0+/9jKZ3UNx6FnUX4nbTJvWnGke+L///w
 iYm9SfRfMM=
X-Received: by 2002:a05:6830:3490:b0:7e6:fa37:9797 with SMTP id
 46e09a7af769-7f4f2527bdamr19905995a34.6.1788107748849; 
 Sun, 30 Aug 2026 09:35:48 -0700 (PDT)
Received: from gmail.com (dyn-72-33-2-213.uwnet.wisc.edu. [72.33.2.213])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4fa99f86fsm6102334a34.22.2026.08.30.09.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 09:35:48 -0700 (PDT)
From: Weijun Pan <wpan3636@gmail.com>
To: Chas Williams <3chas3@gmail.com>,
	"Min Hu (Connor)" <humin29@huawei.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Weijun Pan <wpan3636@gmail.com>
Subject: [RFC PATCH v5 1/2] net/bonding: skip unavailable member stats
Date: Sun, 30 Aug 2026 11:35:38 -0500
Message-Id: <20260830163539.21099-1-wpan3636@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260830011445.168073-1-wpan3636@gmail.com>
References: <20260830011445.168073-1-wpan3636@gmail.com>
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
v5:
- Remove the temporary ret variable.

v4:
- Add this preparatory fix.

 drivers/net/bonding/rte_eth_bond_pmd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 6a4f997b5a..63f21d8522 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -2679,7 +2679,9 @@ bond_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	int i;
 
 	for (i = 0; i < internals->member_count; i++) {
-		rte_eth_stats_get(internals->members[i].port_id, &member_stats);
+		if (rte_eth_stats_get(internals->members[i].port_id,
+				&member_stats) != 0)
+			continue;
 
 		stats->ipackets += member_stats.ipackets;
 		stats->opackets += member_stats.opackets;
-- 
2.34.1

