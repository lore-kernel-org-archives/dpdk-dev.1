Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0F1C624A5
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 16:11:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 985AE40616;
	Mon, 31 Aug 2026 18:11:28 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4FDE540612
 for <dev@dpdk.org>; Mon, 31 Aug 2026 18:11:26 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2cace91f112so30016295ad.0
 for <dev@dpdk.org>; Mon, 31 Aug 2026 09:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788192685;
 x=1788797485; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T/3L5X8ctY+Cqs3cT88RJJ0ocEn04KLy21wnVoQqNMM=;
 b=M/yF62yQpAaCkl/HfzMdf34rRiLlc2+m9lEMlWCrw4ggtdHo63d+x59DwG15kUjIiC
 SKz2epbjYBvG5YVK886It0q8Mc4iKplnwP0nmZ13vcTc5Ma1gvYRCMlEm88klawnDzjW
 bMSU+i/NAPCBcfBcZGo3pPc+0bEPRhUHWnVuELnClyJJT0lkxVM0vzxuEqAzKNnZ4/7B
 6V2gA1MPNoRY6FhJVCp8nWfYNTOJwqAByPPGNNHqgZ/lXdnoxmjOIpalBOJGI2gdGPhD
 O6o9HWl3x4zGUe7yOshS96GGg7UHMCGkXY2eqWRNJl4Q1mnYTHO9Y4rGCUp7sDgNJ5x3
 PPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192685; x=1788797485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T/3L5X8ctY+Cqs3cT88RJJ0ocEn04KLy21wnVoQqNMM=;
 b=aILnjEevhcWPeGCehZeon9yzdyHfgmIq0wmWaEGU6p5e33e/XpSBKl2/IIQl5/nfiH
 Jync/Uprh1xKHQl+dyJlX/JbVjFXXSkfQUrV6PrdWgGXDFI0KYFxeVjWlhKonapt8r9S
 LBpiTgd0PXjsIpZ+q34EWJqGdPZ0r2SiioFTQRcCnNzXerpBwHwAa4hAISdX5xrdL5C6
 R8bWOsox4ymda7LiFw+4DDs52a71Olyh46PKCVWGIX8VoEIhUen/m1fhL2AGvoGsEFNZ
 VDHgVSnkzYJG3NBEWe392u2IF4Lk86C4HBKSMNtcHhzpNpRRlpyO69URCIR4eGmSoZ3B
 uqGw==
X-Gm-Message-State: AFuF++mv/RLZM26xPt3I7v0DeTw7EgQHciiTzz6AGcecHYSgR+sUoAJj
 dS4uN5Qx25bUqAPZ3EjG1jbH7jVkE3gqK98OSJKOAqsSJkMYjHOd9oPS9TL3/W3MY5Kh1wN/JBx
 ZOb7G
X-Gm-Gg: AYBFou0mVA7BwspaSmBR+M/8RNHJ/NHmX69ZDpZ/RbP9/aTqN1exVQ7qdeDrRQn09kH
 M6SXiVoN7v1anhUrkBIKlf05XASOHxFhKnCgDiWmyE+hdc1XXJ0GV4t0eaIduzquMl9h0Bc6iWj
 VrS0EJjQtzPr28Lh4GujitKEyVmSJ0n3h6QHD6k54W23kNWWb84pnC2tbwkCqbAl/B4vXg4rWmj
 Cefm1lwSvS9LMuuUTlmrLfn0rBs7qWMUPV61k3r/5wbd2E7UbBeJa5pAsT/eT05eEIvLGQT8yiT
 El71nIlJwsZRvs4xKD62G7Kry8bzPSpHVb2jxRPuoQuAf3ArhHYMdfBNCKuYqGyaNmtYIFE/Ibt
 KgZF2f25tiLtQwpP049PSLi7csJ0tbjIaR2mO3Xp1yV0KcKIipNtOC3wlzT41205R2s9rsNe5lT
 oIc3V7Rej6CqW6THKghF+DX63HWaMF6bI5Qffh7SqW6wxMq+1kfUnBPGpmsmC0ZHqpvUsd3BuKC
 fyExWQ+TqwjhiCW4KOPKQnkMCU=
X-Received: by 2002:a17:902:f682:b0:2d8:d4d3:3fbc with SMTP id
 d9443c01a7336-2d8d4d34083mr223710585ad.16.1788192682416; 
 Mon, 31 Aug 2026 09:11:22 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f7be607sm31355741eec.10.2026.08.31.09.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:11:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Weijun Pan <wpan3636@gmail.com>, stable@dpdk.org,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Robert Sanford <rsanford@akamai.com>
Subject: [PATCH v2 2/8] net/bonding: skip unavailable member stats
Date: Mon, 31 Aug 2026 09:06:42 -0700
Message-ID: <20260831161105.289670-3-stephen@networkplumber.org>
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

