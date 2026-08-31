Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA671C624C6
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 16:11:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A70F840611;
	Mon, 31 Aug 2026 18:11:37 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id C2EBA40679
 for <dev@dpdk.org>; Mon, 31 Aug 2026 18:11:35 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-c9aea40d799so2075945a12.0
 for <dev@dpdk.org>; Mon, 31 Aug 2026 09:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788192695;
 x=1788797495; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Urae24+OwzFeuN1bmXZ9k6ebe7YSxNPGj7mQ/pWLsjs=;
 b=OdsoS2fydxaRAvWqpAdDP2G2Gokq6ONpmavwkjtVXagSJdD2TgO2igt2QUyh5m2hvi
 e6qcZvz85jm/0COF48Sd1i/dr6DowYq08jnBsro8w/Sg9sczIZJdskmfBzDC55a+g7fe
 W4NtNuGfrzt7hZiBFMqikugTSvHvyDSf0u5UEJx38/MRTrsQzOHnn3WOQXB+j16zlWNl
 IjgwBwXLaMIRa0G5GJwRyff89yIjBxZyIhqCuB6UQOSjuq33yL3ijsMl2LioIuERi43g
 sVbcG0VOGiqHxu8L6dlxR+UNURsDWu/GvE+37BDPgSWIRymdX5z4EuH6jXS7/pEPwC84
 aVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192695; x=1788797495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Urae24+OwzFeuN1bmXZ9k6ebe7YSxNPGj7mQ/pWLsjs=;
 b=QcV9pOloI4lAJHTPW86iWghgfD3jJBXa9bb4wYd2VwxeVjBt2O5ExJxR81I3QgbCHe
 RgAwQhfuQd0Sxr1V8XK1VAOolSZL+swhjqcSRfsLtWND+a/QhoaPoDpexsXjLsnLEmR5
 QReEYnCS9x3Be/VEfhaNCIDu9UVrbf0o+oQDxLxmJH/7do+Ko4IkRo7itwVzEvxSTRqH
 NJ24RWovu/cj4JBFti2CGXATjfG+twrcSaVB81VMVV0L+z78+oKVmsahSOZsjjZjp0zD
 Eej3yClkfhuyrod2o4CvmrGszlhkP2dZcVOeuC/yhDNMNsdBsF8Nyu+iLjuq1EquMt3H
 UV4A==
X-Gm-Message-State: AFuF++nl+wK3ydLOFBtvXEAOIPwGLwpRDwxLlgWfMckVij/T6F1Sf1Ti
 YidcUGOJSQvmoGaRAbd87ndX7V/7Efmo3xkJ5dXgK5n75+IHRzWDA29CoMp+z3jMfB5fGT8JJbM
 dxb5J
X-Gm-Gg: AYBFou3a/Awg6nU76L1f07H38be/SSataDb6tsPxsfNuZXVDv3qcSpMAxStMDpmpvaS
 OAuRvEu0qxg0N/DI84NwIGbDvp7xgPv7+nM9LmU0B096DS9DVY7Cp3MFc0MlQhWp60kVIR4MshF
 DgvxKMijkIOfX5nFg/eSQr/kHKz6GY6Hvr3K1s9SovmjiqZZYUIyi0oHY2P0liPpZ7Q6sAyXPfF
 QUdJ4omdWSts4HqzbdbWhRG+kp5p0l4mkZtO3AwQmOUSt2K14kTMMlWr/QKw7LtVxnqnEjty0GM
 yXC6/aP0X8EQjhV5T33mW2FPRGm3am8HZLEDNXT1dkwagXdx0bNtj04u7QxL0qdURzWzjUPshs1
 nC1RzsP7OJRMNn8G5D4pzmilZB2CKB4NXSEeLnnS0IGy3PmIIV1VIYdk5DtONPP7T2MngryShXR
 1v8H2Jrj2cs0PK7jFOKu7CBYfFj5nHQ84xg77n7QJjU/b/X2CZ2N4G4eYUZcpn5OI5jGsMLtkpe
 C0R9N/XbSMHKvtLrkHhIfckHL0e
X-Received: by 2002:a17:90b:2d82:b0:38e:5c6:4db9 with SMTP id
 98e67ed59e1d1-396d0f2f709mr42588911a91.11.1788192694649; 
 Mon, 31 Aug 2026 09:11:34 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f7be607sm31355741eec.10.2026.08.31.09.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:11:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Robert Sanford <rsanford@akamai.com>
Subject: [PATCH v2 4/8] net/bonding: use atomic link status accessors
Date: Mon, 31 Aug 2026 09:06:44 -0700
Message-ID: <20260831161105.289670-5-stephen@networkplumber.org>
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

The bonding PMD read and wrote rte_eth_dev_data.dev_link directly.
Since a struct rte_eth_link is a 64 bit value updated concurrently
it needs to be done atomically. Use existing helpers.

Fixes: 2efb58cbab6e ("bond: new link bonding library")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bonding/rte_eth_bond_pmd.c | 84 ++++++++++++++++----------
 1 file changed, 51 insertions(+), 33 deletions(-)

diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 7579b97b06..6f3c13d6fb 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -1461,8 +1461,12 @@ link_properties_set(struct rte_eth_dev *ethdev, struct rte_eth_link *member_link
 		 * In any other mode the link properties are set to default
 		 * values of AUTONEG/DUPLEX
 		 */
-		ethdev->data->dev_link.link_autoneg = RTE_ETH_LINK_AUTONEG;
-		ethdev->data->dev_link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+		struct rte_eth_link link;
+
+		rte_eth_linkstatus_get(ethdev, &link);
+		link.link_autoneg = RTE_ETH_LINK_AUTONEG;
+		link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+		rte_eth_linkstatus_set(ethdev, &link);
 	}
 }
 
@@ -2077,6 +2081,16 @@ bond_ethdev_primary_set(struct bond_dev_private *internals,
 static int
 bond_ethdev_promiscuous_enable(struct rte_eth_dev *eth_dev);
 
+static void
+bond_ethdev_link_down(struct rte_eth_dev *eth_dev)
+{
+	struct rte_eth_link link;
+
+	rte_eth_linkstatus_get(eth_dev, &link);
+	link.link_status = RTE_ETH_LINK_DOWN;
+	rte_eth_linkstatus_set(eth_dev, &link);
+}
+
 static int
 bond_ethdev_start(struct rte_eth_dev *eth_dev)
 {
@@ -2090,7 +2104,7 @@ bond_ethdev_start(struct rte_eth_dev *eth_dev)
 		return -1;
 	}
 
-	eth_dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
+	bond_ethdev_link_down(eth_dev);
 	eth_dev->data->dev_started = 1;
 
 	internals = eth_dev->data->dev_private;
@@ -2242,7 +2256,7 @@ bond_ethdev_stop(struct rte_eth_dev *eth_dev)
 			tlb_last_obytets[internals->active_members[i]] = 0;
 	}
 
-	eth_dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
+	bond_ethdev_link_down(eth_dev);
 	eth_dev->data->dev_started = 0;
 
 	if (internals->link_status_polling_enabled) {
@@ -2537,6 +2551,7 @@ bond_ethdev_member_link_status_change_monitor(void *cb_arg)
 {
 	struct rte_eth_dev *bonding_ethdev, *member_ethdev;
 	struct bond_dev_private *internals;
+	struct rte_eth_link member_link;
 
 	/* Default value for polling member found is true as we don't want to
 	 * disable the polling thread if we cannot get the lock */
@@ -2569,9 +2584,11 @@ bond_ethdev_member_link_status_change_monitor(void *cb_arg)
 			member_ethdev->dev_ops->link_update(member_ethdev,
 					      internals->members[i].link_status_wait_to_complete);
 
+			rte_eth_linkstatus_get(member_ethdev, &member_link);
+
 			/* if link status has changed since last checked then call lsc
 			 * event callback */
-			if (member_ethdev->data->dev_link.link_status !=
+			if (member_link.link_status !=
 					internals->members[i].last_link_status) {
 				bond_ethdev_lsc_event_callback(internals->members[i].port_id,
 						RTE_ETH_EVENT_INTR_LSC,
@@ -2595,6 +2612,7 @@ bond_ethdev_link_update(struct rte_eth_dev *ethdev, int wait_to_complete)
 
 	struct bond_dev_private *bond_ctx;
 	struct rte_eth_link member_link;
+	struct rte_eth_link link;
 
 	bool one_link_update_succeeded;
 	uint32_t idx;
@@ -2602,15 +2620,17 @@ bond_ethdev_link_update(struct rte_eth_dev *ethdev, int wait_to_complete)
 
 	bond_ctx = ethdev->data->dev_private;
 
-	ethdev->data->dev_link.link_speed = RTE_ETH_SPEED_NUM_NONE;
+	rte_eth_linkstatus_get(ethdev, &link);
+	link.link_speed = RTE_ETH_SPEED_NUM_NONE;
 
 	if (ethdev->data->dev_started == 0 ||
 			bond_ctx->active_member_count == 0) {
-		ethdev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
+		link.link_status = RTE_ETH_LINK_DOWN;
+		rte_eth_linkstatus_set(ethdev, &link);
 		return 0;
 	}
 
-	ethdev->data->dev_link.link_status = RTE_ETH_LINK_UP;
+	link.link_status = RTE_ETH_LINK_UP;
 
 	if (wait_to_complete)
 		link_update = rte_eth_link_get;
@@ -2623,7 +2643,7 @@ bond_ethdev_link_update(struct rte_eth_dev *ethdev, int wait_to_complete)
 		 * Setting link speed to UINT32_MAX to ensure we pick up the
 		 * value of the first active member
 		 */
-		ethdev->data->dev_link.link_speed = UINT32_MAX;
+		link.link_speed = UINT32_MAX;
 
 		/**
 		 * link speed is minimum value of all the members link speed as
@@ -2634,19 +2654,16 @@ bond_ethdev_link_update(struct rte_eth_dev *ethdev, int wait_to_complete)
 			ret = link_update(bond_ctx->active_members[idx],
 					  &member_link);
 			if (ret < 0) {
-				ethdev->data->dev_link.link_speed =
-					RTE_ETH_SPEED_NUM_NONE;
+				link.link_speed = RTE_ETH_SPEED_NUM_NONE;
 				RTE_BOND_LOG(ERR,
 					"Member (port %u) link get failed: %s",
 					bond_ctx->active_members[idx],
 					rte_strerror(-ret));
-				return 0;
+				goto done;
 			}
 
-			if (member_link.link_speed <
-					ethdev->data->dev_link.link_speed)
-				ethdev->data->dev_link.link_speed =
-						member_link.link_speed;
+			if (member_link.link_speed < link.link_speed)
+				link.link_speed = member_link.link_speed;
 		}
 		break;
 	case BONDING_MODE_ACTIVE_BACKUP:
@@ -2656,16 +2673,14 @@ bond_ethdev_link_update(struct rte_eth_dev *ethdev, int wait_to_complete)
 			RTE_BOND_LOG(ERR, "Member (port %u) link get failed: %s",
 				bond_ctx->current_primary_port,
 				rte_strerror(-ret));
-			return 0;
+			goto done;
 		}
 
-		ethdev->data->dev_link.link_speed = member_link.link_speed;
+		link.link_speed = member_link.link_speed;
 		break;
 	case BONDING_MODE_8023AD:
-		ethdev->data->dev_link.link_autoneg =
-				bond_ctx->mode4.member_link.link_autoneg;
-		ethdev->data->dev_link.link_duplex =
-				bond_ctx->mode4.member_link.link_duplex;
+		link.link_autoneg = bond_ctx->mode4.member_link.link_autoneg;
+		link.link_duplex = bond_ctx->mode4.member_link.link_duplex;
 		/* fall through */
 		/* to update link speed */
 	case BONDING_MODE_ROUND_ROBIN:
@@ -2677,7 +2692,7 @@ bond_ethdev_link_update(struct rte_eth_dev *ethdev, int wait_to_complete)
 		 * In theses mode the maximum theoretical link speed is the sum
 		 * of all the members
 		 */
-		ethdev->data->dev_link.link_speed = RTE_ETH_SPEED_NUM_NONE;
+		link.link_speed = RTE_ETH_SPEED_NUM_NONE;
 		one_link_update_succeeded = false;
 
 		for (idx = 0; idx < bond_ctx->active_member_count; idx++) {
@@ -2692,16 +2707,15 @@ bond_ethdev_link_update(struct rte_eth_dev *ethdev, int wait_to_complete)
 			}
 
 			one_link_update_succeeded = true;
-			ethdev->data->dev_link.link_speed +=
-					member_link.link_speed;
+			link.link_speed += member_link.link_speed;
 		}
 
-		if (!one_link_update_succeeded) {
+		if (!one_link_update_succeeded)
 			RTE_BOND_LOG(ERR, "All members link get failed");
-			return 0;
-		}
 	}
 
+done:
+	rte_eth_linkstatus_set(ethdev, &link);
 
 	return 0;
 }
@@ -3069,7 +3083,7 @@ bond_ethdev_lsc_event_callback(uint16_t port_id, enum rte_eth_event_type type,
 {
 	struct rte_eth_dev *bonding_eth_dev;
 	struct bond_dev_private *internals;
-	struct rte_eth_link link;
+	struct rte_eth_link link, bond_link;
 	int rc = -1;
 	int ret;
 
@@ -3122,7 +3136,8 @@ bond_ethdev_lsc_event_callback(uint16_t port_id, enum rte_eth_event_type type,
 			goto link_update;
 
 		/* check link state properties if bonding link is up*/
-		if (bonding_eth_dev->data->dev_link.link_status == RTE_ETH_LINK_UP) {
+		rte_eth_linkstatus_get(bonding_eth_dev, &bond_link);
+		if (bond_link.link_status == RTE_ETH_LINK_UP) {
 			if (link_properties_valid(bonding_eth_dev, &link) != 0)
 				RTE_BOND_LOG(ERR, "Invalid link properties "
 					     "for member %d in bonding mode %d",
@@ -3137,8 +3152,10 @@ bond_ethdev_lsc_event_callback(uint16_t port_id, enum rte_eth_event_type type,
 		 */
 		if (internals->active_member_count < 1) {
 			/* If first active member, then change link status */
-			bonding_eth_dev->data->dev_link.link_status =
-								RTE_ETH_LINK_UP;
+			rte_eth_linkstatus_get(bonding_eth_dev, &bond_link);
+			bond_link.link_status = RTE_ETH_LINK_UP;
+			rte_eth_linkstatus_set(bonding_eth_dev, &bond_link);
+
 			internals->current_primary_port = port_id;
 			lsc_flag = 1;
 
@@ -3194,7 +3211,8 @@ bond_ethdev_lsc_event_callback(uint16_t port_id, enum rte_eth_event_type type,
 			rte_eal_alarm_cancel(bond_ethdev_delayed_lsc_propagation,
 					bonding_eth_dev);
 
-		if (bonding_eth_dev->data->dev_link.link_status) {
+		rte_eth_linkstatus_get(bonding_eth_dev, &bond_link);
+		if (bond_link.link_status) {
 			if (internals->link_up_delay_ms > 0)
 				rte_eal_alarm_set(internals->link_up_delay_ms * 1000,
 						bond_ethdev_delayed_lsc_propagation,
-- 
2.53.0

