Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106F9C61DEB
	for <dpdk-dev@archiver.kernel.org>; Sun, 30 Aug 2026 20:27:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90AF640611;
	Sun, 30 Aug 2026 22:26:56 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id DBAE0402E9
 for <dev@dpdk.org>; Sun, 30 Aug 2026 22:26:54 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-398ba166ce3so853076a91.1
 for <dev@dpdk.org>; Sun, 30 Aug 2026 13:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788121614;
 x=1788726414; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T/3L5X8ctY+Cqs3cT88RJJ0ocEn04KLy21wnVoQqNMM=;
 b=jK04o9nw4cfs86QTnPkmT/4grziuO7XoqXzdmg5UF5XbnLU2FsvFbruzJaKvRdnc4f
 1S6+89AS7qtb9DKg8iBvDhhef4TbUJWAwE6w0aOEJKAwXV2wXa3bEty5uK01vM+wIj4Z
 EHbQooaL0U22ObP8Z3hbTpL8dnbQ6Z/Y7IESjXgIrfX7TpUeG9YxXB2XDYTlmry8UsMQ
 1ee5HRBuOOt4xfFTdSI0bZXLt+3MWxmMExolLubPCyUw89spF0pi12ee+4vNcAb29hH+
 1BGA4q49Udf/+xjjeVRJX3Sc+4z8WUg7FMWR8vWvugjXTIByHS1KzYg+9guKWRNkYoQG
 3C+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788121614; x=1788726414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T/3L5X8ctY+Cqs3cT88RJJ0ocEn04KLy21wnVoQqNMM=;
 b=mndAxWxedCD0bilTKw8BZ428q0QqYbQ93e/2ZXlMw8KGPCF0PKU3eoHZkiIGDrpOZN
 KKzoWCH4tzqLWsyLNmy1JtTUWhR5Mrkej/5P82/Itt9TGzOqCdvI5YxiR4i4zRiUz7Xd
 tc+8EFkWEnWOpji1IN7CCw57TPcIkkcIBIMn0LIi0fsCJrKeCO/QgO4R9MGTQdGRaGdf
 wXejJoNsLvh54UoyYHWJ3pTdNSDBrYesKXQmthlJY6b7lFzcmBWkhf59XVZAw7Z7fJv9
 oDfetabAXkHvSgu9FyVq2+QGF4WIRZoPfLKiQ0jMuBphFthVHUq5yKys5A4chAD7KkPB
 2kVg==
X-Gm-Message-State: AFuF++kRz4ses9iWPbHmnVleL8CqRYHKtdlHlFIbbxPVWyAuc4ibUOMc
 htAMydGWVrddvvE4aQz+QqVBvStOoiOLgn3tZdLsP8+c7DcL6WZ3TcM5pe/bsbOKW4sATrI4CAA
 IhKI+
X-Gm-Gg: AYBFou0uJ4Dc9RICfH/NfZ5qiFh2wkA8scOIBVM1PbZk5avt0Q2zs/zKR1krvh9b1S8
 YdSq0pzRO/kjmXs+PZK2hQOoUF0iA1Ydsn9e+QPdZvGMIE12oSJY8AaxSucuTZNgq5AktY/qOWw
 j7oJqfZnNODdaLYnCCyIhGDYYGSUS8dWkQGHS4oYOh6hj+71C1elAOfLSj3pB7qQ5HgPL5DxcqJ
 orb/Ax8iqEQPNhEeN8UixVcn2h6PKfl+5YCfkNHTsRZFTNWoRNncTuHDnXHwZ7DVW1Y92TSRy/3
 +mnLGx2w5p/dAKjw0D0FKky2LbqPN/+/O3nxGrCEXkMPXBKekt8jDK8MYZDiKMoH/zSwIxNUO3G
 e8ZdvRufh9LvchTrHoEfwV4HxAmoEZaN9yx+2Fn1jmDAlHys8YwpAhR1zSd2o2KWxxiQxgrwqWU
 +U5K0pNwyVROylnH2TYt/xF830uuqlyt1MIAuqbvaiyW1OXO2IrIg0N10Q61jmIy1WLqSRCd0Eu
 N+hZVwh3hBkN9xYkxa2tMNTmLM=
X-Received: by 2002:a17:90b:564e:b0:381:25ce:bcc2 with SMTP id
 98e67ed59e1d1-396d0ee7010mr31854399a91.6.1788121613956; 
 Sun, 30 Aug 2026 13:26:53 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd5c34sm17683165a91.8.2026.08.30.13.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 13:26:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Weijun Pan <wpan3636@gmail.com>, stable@dpdk.org,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Robert Sanford <rsanford@akamai.com>
Subject: [PATCH 2/8] net/bonding: skip unavailable member stats
Date: Sun, 30 Aug 2026 13:23:44 -0700
Message-ID: <20260830202636.760014-3-stephen@networkplumber.org>
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

From: Weijun Pan <wpan3636@gmail.com>

bond_ethdev_stats_get() accumulates statistics from each bonding
member. If rte_eth_stats_get() fails for a member, the local
member_stats structure may be left unchanged.

Skip members whose statistics cannot be read, instead of accumulating
stale or uninitialized counters.

Fixes: 2efb58cbab6e ("bond: new link bonding library")
Cc: stable@dpdk.org

Signed-off-by: Weijun Pan <wpan3636@gmail.com>
---
 drivers/net/bonding/rte_eth_bond_pmd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 5b4b3d6ac2..6235c07679 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -2704,7 +2704,9 @@ bond_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	int i;
 
 	for (i = 0; i < internals->member_count; i++) {
-		rte_eth_stats_get(internals->members[i].port_id, &member_stats);
+		if (rte_eth_stats_get(internals->members[i].port_id,
+				&member_stats) != 0)
+			continue;
 
 		stats->ipackets += member_stats.ipackets;
 		stats->opackets += member_stats.opackets;
-- 
2.53.0

