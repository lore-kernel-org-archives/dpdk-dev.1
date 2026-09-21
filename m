Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2422C982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 02:21:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B664410FA;
	Mon, 21 Sep 2026 04:21:28 +0200 (CEST)
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by mails.dpdk.org (Postfix) with ESMTP id E778A40E35
 for <dev@dpdk.org>; Mon, 21 Sep 2026 04:21:24 +0200 (CEST)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-2d7200b2e15so12503225ad.3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789957284; x=1790562084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gw8sqpoQ2chdKdyOrZFB06HR77u46UftjvFe7TMNwRY=;
 b=ePEWPKk6L5Rkhs0JfWItUYDvx3DQt57VFIl6OGCtR91B51DL8d+C8VTA7ciIncQ+uZ
 /et5KVcSs0LNUbJ4DQXP22nww1zuoPAPYsiP9WkbToVseoXVfBA+SWVPQ36DSXNF7ggN
 boYts7aJxr+lCz3tYSoArG1/Lz1kxFvjsFFPjx7iyHmt+ufNP2nZ9YX15BPq7P3eRBI2
 gZBaRm66T+Jq2Nwy+ISl+bRvVXkzGS5ElmKgyUdIZB8foazaFAcTQ/Xl7N1c/n3kqDJU
 nsUeCmT0Q/KYzKVJycAY/bYjbshTHR+aY56it2lDzOxWyOCQEcwlIfAgWeR0Is09NKDD
 8JAA==
X-Gm-Message-State: AFuF++kc72VSCX7SeZHDuIeYdgmFFlp1nAA5Vg7kwQxgEDFnfc2cvCMd
 f9xWllZoeaLCeeVQDu0r70TW6gQXQzI1h4rWJgy59MzUrSkNigqm5GxMuJWPj3MRq2YXakpX5/H
 kj10q3NVAuRR+UnQDd8jThZCUVKUVvLAl9sKAnhCw0rylPxQL+7RyTaj4ntgQfXTObx42q9Aaex
 lmF+8grrK/H+hyqJMVEGXpXuWBCJZ9Rlh0JWWkn+rdO2ejE5qR8kp7J6LWxd0QmuafIGoqLMc3y
 72uxgEVMnc5
X-Gm-Gg: AYBFou3pJz8/1fnafosAU45IcJo6Bre4VcoC0GS+ioo3PvW1TQf4Lh8JmWTxgloBWG4
 38iwHnfEmxeS+g0oxwcsI8a5iUtULTSRtAdqNQDPTWe0D9h4BuJAS63+J7h9oPPZ3P6b7nntptm
 EY7qKd7N16DbFUR1vAAwnIkrdjwg9uSS/fZOrIal9zz41qqvnmf+D1vFKG1GEuNGaelGyJ9wvXt
 wB+B7PD42siSSoH95jcOBmKYYcNRlKWmMHGeEo4MckkD18bIe1Yv8IiynRAaBlsNoddvMJYjADT
 f5HbNIGgfUV0RXURZ0WNncdAfnFks1YN9HX8CeNTYmP1FIqfQWrS6lhT1ZR05pUwRvtbr0GMjwz
 bNUMxSEzOJ+1KGkVmaWLMQMXzOqKdEfaoCnNTyGUgGOyazYrutlL78whcVuTwKi1n7rtZyY67ZU
 3a6JruOiRrdr+eCzftT6NNi63tP0TRFjjGbeFxh02JXXBAy4kNsg==
X-Received: by 2002:a17:90b:280a:b0:39e:2530:2102 with SMTP id
 98e67ed59e1d1-39e54f4221amr22676796a91.11.1789957283807; 
 Sun, 20 Sep 2026 19:21:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-39e5550046dsm1066482a91.3.2026.09.20.19.21.23
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 19:21:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39de4a68f7cso4589803a91.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789957282; x=1790562082; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gw8sqpoQ2chdKdyOrZFB06HR77u46UftjvFe7TMNwRY=;
 b=BOroLJXhQmcDDwG4pEqJgBxCuQCKmz/HoKN3YgQFbfPYyF0Z8P+iBWRfGX/XI/rK9w
 52cPEjpQ7sWkkL7K+Mexctp9o+o8FoRdsmp4myqm31HfRvmhdLXDhCeQsZxpp8/rMULj
 PvzLkhinYwiaFCcm/5Cl8MCZ2vQVWgN7Zz6ww=
X-Received: by 2002:a17:90b:5587:b0:3a0:309d:5549 with SMTP id
 98e67ed59e1d1-3a04b116fcamr1854458a91.8.1789957282117; 
 Sun, 20 Sep 2026 19:21:22 -0700 (PDT)
X-Received: by 2002:a17:90b:5587:b0:3a0:309d:5549 with SMTP id
 98e67ed59e1d1-3a04b116fcamr1854430a91.8.1789957281486; 
 Sun, 20 Sep 2026 19:21:21 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d53968afsm16587294c88.0.2026.09.20.19.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 19:21:21 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Chenna Arnoori <chenna.arnoori@broadcom.com>, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 4/5] net/bnxt: fix bounds in MAC pool index and flow parsing
Date: Sun, 20 Sep 2026 20:24:19 -0600
Message-ID: <20260921022420.1034071-5-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921022420.1034071-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032752.763408-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921022420.1034071-1-Mohammad-Shuab.Siddique@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Chenna Arnoori <chenna.arnoori@broadcom.com>

Two independent out-of-bounds issues in the driver:

- bnxt_mac_addr_add_op() indexed bp->vnic_info[pool] with a
  caller-supplied pool before validating it against bp->max_vnics, and
  before checking bp->vnic_info was even allocated yet (it is NULL
  until the port is started). The existing "if (!vnic)" check was
  always false, since vnic held the address of an array element and
  is never NULL. Reorder to check dev_started/vnic_info first, then
  bounds-check pool against max_vnics before indexing.

- bnxt_flow_non_void_item()/bnxt_flow_non_void_action() looped
  unconditionally until a non-VOID item/action was found, walking off
  the end of a pattern/actions array that lacked a terminating END
  item. Bound the skip loop and stop advancing once the limit is hit.

Fixes: 51fafb89a9a0 ("net/bnxt: get rid of ff pools and use VNIC info array")
Fixes: 5c1171c97216 ("net/bnxt: refactor filter/flow")
Cc: stable@dpdk.org

Signed-off-by: Chenna Arnoori <chenna.arnoori@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 16 ++++++++++------
 drivers/net/bnxt/bnxt_flow.c   | 28 ++++++++++++++++++++--------
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 27cf67c04f..db9b49238a 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -2113,7 +2113,7 @@ static int bnxt_mac_addr_add_op(struct rte_eth_dev *eth_dev,
 				uint32_t index, uint32_t pool)
 {
 	struct bnxt *bp = eth_dev->data->dev_private;
-	struct bnxt_vnic_info *vnic = &bp->vnic_info[pool];
+	struct bnxt_vnic_info *vnic;
 	int rc = 0;
 
 	rc = is_bnxt_in_error(bp);
@@ -2125,15 +2125,19 @@ static int bnxt_mac_addr_add_op(struct rte_eth_dev *eth_dev,
 		return -ENOTSUP;
 	}
 
-	if (!vnic) {
-		PMD_DRV_LOG_LINE(ERR, "VNIC not found for pool %d!", pool);
-		return -EINVAL;
-	}
-
 	/* Filter settings will get applied when port is started */
 	if (!eth_dev->data->dev_started)
 		return 0;
 
+	if (bp->vnic_info == NULL)
+		return 0;
+
+	if (pool >= bp->max_vnics) {
+		PMD_DRV_LOG_LINE(ERR, "Pool %u exceeds VNIC count %u!", pool, bp->max_vnics);
+		return -EINVAL;
+	}
+	vnic = &bp->vnic_info[pool];
+
 	rc = bnxt_add_mac_filter(bp, vnic, mac_addr, index, pool);
 
 	return rc;
diff --git a/drivers/net/bnxt/bnxt_flow.c b/drivers/net/bnxt/bnxt_flow.c
index a2e590540b..14d52e1818 100644
--- a/drivers/net/bnxt/bnxt_flow.c
+++ b/drivers/net/bnxt/bnxt_flow.c
@@ -58,24 +58,36 @@ bnxt_flow_args_validate(const struct rte_flow_attr *attr,
 	return 0;
 }
 
+#define BNXT_MAX_FLOW_ITEMS 256
+
 static const struct rte_flow_item *
 bnxt_flow_non_void_item(const struct rte_flow_item *cur)
 {
-	while (1) {
-		if (cur->type != RTE_FLOW_ITEM_TYPE_VOID)
-			return cur;
+	int i = 0;
+
+	if (!cur)
+		return NULL;
+
+	while (cur->type == RTE_FLOW_ITEM_TYPE_VOID && i < BNXT_MAX_FLOW_ITEMS) {
 		cur++;
+		i++;
 	}
+	return cur;
 }
 
 static const struct rte_flow_action *
 bnxt_flow_non_void_action(const struct rte_flow_action *cur)
 {
-	while (1) {
-		if (cur->type != RTE_FLOW_ACTION_TYPE_VOID)
-			return cur;
+	int i = 0;
+
+	if (!cur)
+		return NULL;
+
+	while (cur->type == RTE_FLOW_ACTION_TYPE_VOID && i < BNXT_MAX_FLOW_ITEMS) {
 		cur++;
+		i++;
 	}
+	return cur;
 }
 
 static int
@@ -109,7 +121,7 @@ bnxt_filter_type_check(const struct rte_flow_item pattern[],
 			PMD_DRV_LOG_LINE(DEBUG, "Unknown Flow type");
 			use_ntuple |= 0;
 		}
-		item++;
+		item = bnxt_flow_non_void_item(item + 1);
 	}
 
 	if (has_vlan && use_ntuple) {
@@ -680,7 +692,7 @@ bnxt_validate_and_parse_flow_type(const struct rte_flow_attr *attr,
 		default:
 			break;
 		}
-		item++;
+		item = bnxt_flow_non_void_item(item + 1);
 	}
 	filter->enables = en;
 	filter->valid_flags = valid_flags;
-- 
2.47.3

