Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D23C982D2
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 03:25:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 197E1432B0;
	Fri, 18 Sep 2026 05:24:55 +0200 (CEST)
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com
 [74.125.224.98]) by mails.dpdk.org (Postfix) with ESMTP id 620E840270
 for <dev@dpdk.org>; Fri, 18 Sep 2026 05:24:53 +0200 (CEST)
Received: by mail-yx1-f98.google.com with SMTP id
 956f58d0204a3-671471be40bso8798d50.2
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789701893; x=1790306693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kIAz63giobqIehShZkLvIVA4ewc/Ng5L9Mz4ptjEkPk=;
 b=gQ7oLePOdtvBWK07GB+jYmQv9nWzuTtiHvfrPM2mnPDxIdkbuW0q9zYCt4N+YGc4Qr
 DJKnresLQEx4W0vV609D3+GlgkJZYRHI6GePjFtQ7FO8T0cZlem1wr3SqMN/UDMnF5a2
 /6jijuPU02k0mA9RM/NVGZ3762LasYOZtA24qD/d5Tyb71WljptgHguhvc92zUKa9PBY
 9bIqg9vzk9qwhpA7jb5zQNyQGMTgMdawjefYvVjTV0cz7fINR70wQq+AN0TvI/fq0Dl7
 Rrv+V69JJwTlETtWhEsGp0I2J0gyiCoWHVdXrQWHmNbGuAYE8Oc3VcMGIVfvGK6Oy9xz
 rnAw==
X-Gm-Message-State: AFuF++nm4mwQ7cuyHOLK/i9DP3p+zgn+bdu0zGnRTKu1Y+guj+Tg393D
 Bu6bNi4gfOYTePOa3VV/kGCra9W2bImH4FWM1aXN+1gdytGXelOu5SyiW2nfw08hRHQti2yBBpN
 g/nH/MtL3uaWRF7+7P5UtSKadHbTWQVKerwXOSH8itNL/G3BTdNnZi8fhojgTR0hY2A2hs9iGHF
 n0CvHxt3WSAOx5O8yKGgZ1SBrLSvOl3pmneWYRzLtye8PetUCVccwS+7Ax5s7zMJluBGI4dSBoD
 RCy8/CgCZmb
X-Gm-Gg: AYBFou3k+8v75sgSmlXqw1mTcyeUSiaocaKnHGe1e/mIcPmfhWiSbYWjFq/YdOH8X0Y
 YVcgIxMwzBx2B+wQfuc++yDqrliEBu1LTP2CBZbKROErpLldNu85ssvsPv1aXBIk0wAvlDaEolr
 BNMaG3uKk2LXnmhjC2X8gOsfaGsb5IJh9YPWpAITRwdON0JsdkHbbHeqNjvIMerAXL0LRUgUwAA
 oJl4iwBfFxYiaJgiwm5LiIg9yHGC4KdJkaYC0FhGeTKoOaj88R6//r+JOY7ip9rQb7DNuL6L9u9
 dWUIGx8q4CVps9feOE3lc1n91+jDSfVBbeRfnoKtVtAWzmFyVY5sc9JRcHO2G2wfIB1wWZBSdvr
 Jq82DPGq7A4YPI/cVtBoCXz6PLcivGPTCXqy5kSCif/L6zY13AqLdylCaRyb/g98X3Eg4x8ffA5
 2BBbA5gh7TPly3J0CUYdERS/8fRYFL6DGHYfhSx+Us72bRY3S4qg==
X-Received: by 2002:a05:690e:4545:20b0:671:3ecb:62a6 with SMTP id
 956f58d0204a3-6717fc90e64mr208459d50.28.1789701892647; 
 Thu, 17 Sep 2026 20:24:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-671833da48esm5476d50.1.2026.09.17.20.24.51
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Sep 2026 20:24:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cec4226c70so4200005ad.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789701891; x=1790306691; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kIAz63giobqIehShZkLvIVA4ewc/Ng5L9Mz4ptjEkPk=;
 b=cKLTalpFZaBq9mEbkN8YdQk9MJQKucZWy97rV3brNqvRiWfTbOKXNUZBpwlLvuJyOx
 mWn+wr278XX6PBT8Zo4AnMryOfBtry3sFFdFiFWkrA8aWgF8h6O6R2FeFvBUgn0U0eSG
 zQM2RGsUr7jD7t60VWAA9wZ+YC8HvRbl+yc2U=
X-Received: by 2002:a17:903:178b:b0:2cc:864b:539 with SMTP id
 d9443c01a7336-2ddb1ac4c42mr22626225ad.6.1789701891064; 
 Thu, 17 Sep 2026 20:24:51 -0700 (PDT)
X-Received: by 2002:a17:903:178b:b0:2cc:864b:539 with SMTP id
 d9443c01a7336-2ddb1ac4c42mr22625815ad.6.1789701890554; 
 Thu, 17 Sep 2026 20:24:50 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c286d98c6sm537742eec.5.2026.09.17.20.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:24:49 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Chenna Arnoori <chenna.arnoori@broadcom.com>, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 4/5] net/bnxt: fix bounds in MAC pool index and flow parsing
Date: Thu, 17 Sep 2026 21:27:51 -0600
Message-ID: <20260918032752.763408-5-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918032752.763408-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032752.763408-1-Mohammad-Shuab.Siddique@broadcom.com>
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

Fixes: 51fafb89a9a ("net/bnxt: get rid of ff pools and use VNIC info array")
Fixes: 5c1171c972 ("net/bnxt: refactor filter/flow")
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

