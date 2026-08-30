Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699D6C61DD9
	for <dpdk-dev@archiver.kernel.org>; Sun, 30 Aug 2026 16:35:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 384AF402B6;
	Sun, 30 Aug 2026 18:35:55 +0200 (CEST)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47]) by mails.dpdk.org (Postfix) with ESMTP id 58F35402BB
 for <dev@dpdk.org>; Sun, 30 Aug 2026 18:35:53 +0200 (CEST)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7f18c0e03e3so1611467a34.2
 for <dev@dpdk.org>; Sun, 30 Aug 2026 09:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788107752; x=1788712552; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DKVkDzu4Bst92jHy7QPSPsGOru4cfG2xRCM6++RpYhE=;
 b=KOvbX88JA5KosW/5+i9+AydCiBpizLWdpEdQftsjAaso+/RERNBHte23jkK9IKNC7q
 CJXZlzo5o7EePzIlWPTSwH7zQ77l9PeEQfXZsYvQ6D3UvhhfJO+TBLgLNM2hD2LUVCYW
 4oiKWxntfPAtUnZeTm1tObhViHCWe5uj7YJwrcBeQ4UE/3a4YZAHvgjHcyvWu0wWFltW
 Eky8dTdTRbN5QjW4E63u1Yt0UxEGpEU8HWC47c4Ev8IbrcYyEt+Hf9nG2Cx7YLzSy3q3
 5Y07AzbfcJaxGtM+F6zQY6DOiErK6sgA7yIXROAZDMwG0vhlzIstPPkR8x9D23HUyZxp
 ucsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788107752; x=1788712552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DKVkDzu4Bst92jHy7QPSPsGOru4cfG2xRCM6++RpYhE=;
 b=g6+D+E44E5OmYUzcJsdlgkIkohvM0L7R9lBmLO9WaqqY/fA6Qo4phmY+OTMrIDYmmn
 YgRO1XlQseGgrKws6H46tlD2y/qMoTj1HfCA1R6H3zk6/l3ajxcRAXq7Wguxn7Pgdgve
 jDgxqmrpSSBbPgK91UrRak2GwgVq0zsi4HqbsklBCCesAeQuNRKmscTd2NSBwC9wG9wr
 54cGPkoYNHgAVPWKtLj7+k6w3Sc2/fUsSc/c+BZrr+kyH3lIdomi2YwAsQWsfIrvtMAm
 154XRC+FkgbSUfIY3ukl2s7fonw1iuFAjUO5BzIuMl+tTaWwZe+VS/CeghMuLvvSRgNN
 avSQ==
X-Gm-Message-State: AFuF++mHhhITJavTkRFLK7fkVLoAOSgc8G5/nVQKrck+bsYHKmaFuBSR
 iC53lkPaJoaCuu792AgengbxA+9GNKdh3eg0CgRe4BXWyllBt2xI67X9
X-Gm-Gg: AR+sD13kPjiE2vhOkgOMpuNcjisiwkiJjfZQQ4/RTk3OcFunw0hcbZa3HgtwwVhcLdH
 88QvlHB+hh6HCV/u3SH9mlLkv8Faz+Dsjgts7JbiWlRi3ceDwf+JexkOje+huUoHXqZ03erZl4y
 RBfZsbODIlyPTqYEelNEx9bEGCYzU5MyzPGmg7ukoeFCQz7c/QICwKf/oilJukuIlMNYmB4APbV
 AfIh0sgRsH4Y+Uq3ZCDhvInmJHDYsQVUJ3C2XsGAii+5rjieMivx0jMsWDXP4d+UX3D+lp9j+Yd
 CdHy8HbFe7Sk8LCYfh0g+0ySio6dIiJ8ZlcElbLwTF4q3koOMSmkzW2KO9Preh7zMxDkVniAn2+
 /Wm6zUOF1ch7jKMWhzzaF0Q5RE4+NF4eD5hxcEgExaz6jlZkwEvMeF8H/V4RWNNkJ/74gcG3qCV
 YUcbSukm6rpSUPPprs6gE2w8hFpTJpp78w4o9mBoTEP137cypBKF45vkm7/QE6KVsy/wHZnWrfw
 QtvV0WdY2c=
X-Received: by 2002:a05:6830:6519:b0:7e9:bf64:b70b with SMTP id
 46e09a7af769-7f4f223b997mr24266010a34.1.1788107752371; 
 Sun, 30 Aug 2026 09:35:52 -0700 (PDT)
Received: from gmail.com (dyn-72-33-2-213.uwnet.wisc.edu. [72.33.2.213])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4fa99f86fsm6102334a34.22.2026.08.30.09.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 09:35:51 -0700 (PDT)
From: Weijun Pan <wpan3636@gmail.com>
To: Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Weijun Pan <wpan3636@gmail.com>
Subject: [RFC PATCH v5 2/2] net/bonding: restrict secondary control operations
Date: Sun, 30 Aug 2026 11:35:39 -0500
Message-Id: <20260830163539.21099-2-wpan3636@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260830163539.21099-1-wpan3636@gmail.com>
References: <20260830011445.168073-1-wpan3636@gmail.com>
 <20260830163539.21099-1-wpan3636@gmail.com>
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

Bonding configuration and LACP runtime state are owned by the primary
process. Install a reduced dev_ops table in secondary processes so
ethdev rejects control operations, and reject bonding control APIs
when called from a secondary process.

Supported query and detach paths remain available, while LACP runtime
state queries are restricted to the primary process.

Bugzilla ID: 1900

Signed-off-by: Weijun Pan <wpan3636@gmail.com>
---
v5:
- Simplify the helper and release note wording.

v4:
- Address secondary link update, docs, and private dump handling.

 .../link_bonding_poll_mode_drv_lib.rst        | 30 ++++++++++
 doc/guides/rel_notes/release_26_11.rst        |  5 ++
 drivers/net/bonding/eth_bond_private.h        | 12 ++++
 drivers/net/bonding/rte_eth_bond_8023ad.c     | 30 ++++++++++
 drivers/net/bonding/rte_eth_bond_api.c        | 34 ++++++++++-
 drivers/net/bonding/rte_eth_bond_pmd.c        | 58 +++++++++++--------
 6 files changed, 144 insertions(+), 25 deletions(-)

diff --git a/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst b/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
index 2fa1ac4028..a3f197c8b5 100644
--- a/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
+++ b/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
@@ -254,6 +254,36 @@ Like all other PMD, all functions exported by a PMD are lock-free functions
 that are assumed not to be invoked in parallel on different logical cores to
 work on the same target object.
 
+Bonding device configuration and LACP runtime state are owned by the primary
+process. Secondary processes may attach to an existing bonding device for
+detach and supported query operations only.
+
+Supported secondary-process queries include device information, statistics,
+link status, RETA query, RSS hash configuration, bonding mode, member list,
+primary member, transmit policy, link monitoring configuration, and LACP
+configuration. Private dump is limited to shared bonding information and skips
+LACP runtime state in a secondary process.
+
+Control operations are restricted to the primary process. This includes
+configuring, starting or stopping the device, setting up queues, changing
+members, changing the bonding mode, selecting the primary member, changing the
+transmit policy, changing link monitoring or propagation delays, updating RSS,
+changing MAC addresses, changing MTU, configuring VLAN filters, changing
+promiscuous or all-multicast mode, resetting statistics, configuring
+``rte_flow`` rules, and changing 802.3ad settings, including aggregation
+selection, external collect/distribute/slow-Tx controls, and dedicated queue
+enable or disable.
+
+LACP runtime state queries, including ``rte_eth_bond_8023ad_member_info()``,
+``rte_eth_bond_8023ad_ext_collect_get()``, and
+``rte_eth_bond_8023ad_ext_distrib_get()``, are also restricted to the primary
+process.
+
+Rx and Tx are not supported on a bonding device in a secondary process;
+receive returns no packets and transmit drops packets. In a secondary process,
+``rte_eth_dev_stop()`` returns ``-ENOTSUP`` and ``rte_eth_dev_close()`` is the
+detach operation.
+
 It should also be noted that the PMD receive function should not be invoked
 directly on a member devices after they have been to a bonding device since
 packets read directly from the member device will no longer be available to the
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..2a8e3a2d20 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -24,6 +24,11 @@ DPDK Release 26.11
 New Features
 ------------
 
+* **Added bonding PMD secondary-process support.**
+
+  Added support for querying and detaching bonding devices from secondary
+  processes.
+
 .. This section should contain new features added in this release.
    Sample format:
 
diff --git a/drivers/net/bonding/eth_bond_private.h b/drivers/net/bonding/eth_bond_private.h
index 378bbba4e6..b3c2ddf24e 100644
--- a/drivers/net/bonding/eth_bond_private.h
+++ b/drivers/net/bonding/eth_bond_private.h
@@ -7,12 +7,14 @@
 
 #include <stdint.h>
 #include <sys/queue.h>
+#include <stdbool.h>
 
 #include <ethdev_driver.h>
 #include <rte_flow.h>
 #include <rte_spinlock.h>
 #include <rte_bitmap.h>
 #include <rte_flow_driver.h>
+#include <rte_eal.h>
 
 #include "rte_eth_bond.h"
 #include "eth_bond_8023ad_private.h"
@@ -212,6 +214,16 @@ find_member_by_id(uint16_t *members, uint16_t members_count, uint16_t member_id)
 	return pos;
 }
 
+static inline bool
+bond_check_primary(const char *op)
+{
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		return true;
+
+	RTE_BOND_LOG(ERR, "%s not supported in secondary process", op);
+	return false;
+}
+
 int
 valid_port_id(uint16_t port_id);
 
diff --git a/drivers/net/bonding/rte_eth_bond_8023ad.c b/drivers/net/bonding/rte_eth_bond_8023ad.c
index d1f30229d0..5f52cc2bcc 100644
--- a/drivers/net/bonding/rte_eth_bond_8023ad.c
+++ b/drivers/net/bonding/rte_eth_bond_8023ad.c
@@ -1437,6 +1437,9 @@ rte_eth_bond_8023ad_agg_selection_set(uint16_t port_id,
 	struct bond_dev_private *internals;
 	struct mode8023ad_private *mode4;
 
+	if (!bond_check_primary(__func__))
+		return -ENOTSUP;
+
 	if (valid_bonding_port_id(port_id) != 0)
 		return -EINVAL;
 
@@ -1509,6 +1512,9 @@ rte_eth_bond_8023ad_setup(uint16_t port_id,
 	struct rte_eth_dev *bond_dev;
 	int err;
 
+	if (!bond_check_primary(__func__))
+		return -ENOTSUP;
+
 	err = bond_8023ad_setup_validate(port_id, conf);
 	if (err != 0)
 		return err;
@@ -1532,6 +1538,9 @@ rte_eth_bond_8023ad_member_info(uint16_t port_id, uint16_t member_id,
 	struct bond_dev_private *internals;
 	struct port *port;
 
+	if (!bond_check_primary(__func__))
+		return -ENOTSUP;
+
 	if (info == NULL || valid_bonding_port_id(port_id) != 0 ||
 			rte_eth_bond_mode_get(port_id) != BONDING_MODE_8023AD)
 		return -EINVAL;
@@ -1593,6 +1602,9 @@ rte_eth_bond_8023ad_ext_collect(uint16_t port_id, uint16_t member_id,
 	struct port *port;
 	int res;
 
+	if (!bond_check_primary(__func__))
+		return -ENOTSUP;
+
 	res = bond_8023ad_ext_validate(port_id, member_id);
 	if (res != 0)
 		return res;
@@ -1615,6 +1627,9 @@ rte_eth_bond_8023ad_ext_distrib(uint16_t port_id, uint16_t member_id,
 	struct port *port;
 	int res;
 
+	if (!bond_check_primary(__func__))
+		return -ENOTSUP;
+
 	res = bond_8023ad_ext_validate(port_id, member_id);
 	if (res != 0)
 		return res;
@@ -1636,6 +1651,9 @@ rte_eth_bond_8023ad_ext_distrib_get(uint16_t port_id, uint16_t member_id)
 	struct port *port;
 	int err;
 
+	if (!bond_check_primary(__func__))
+		return -ENOTSUP;
+
 	err = bond_8023ad_ext_validate(port_id, member_id);
 	if (err != 0)
 		return err;
@@ -1651,6 +1669,9 @@ rte_eth_bond_8023ad_ext_collect_get(uint16_t port_id, uint16_t member_id)
 	struct port *port;
 	int err;
 
+	if (!bond_check_primary(__func__))
+		return -ENOTSUP;
+
 	err = bond_8023ad_ext_validate(port_id, member_id);
 	if (err != 0)
 		return err;
@@ -1667,6 +1688,9 @@ rte_eth_bond_8023ad_ext_slowtx(uint16_t port_id, uint16_t member_id,
 	struct port *port;
 	int res;
 
+	if (!bond_check_primary(__func__))
+		return -ENOTSUP;
+
 	res = bond_8023ad_ext_validate(port_id, member_id);
 	if (res != 0)
 		return res;
@@ -1728,6 +1752,9 @@ rte_eth_bond_8023ad_dedicated_queues_enable(uint16_t port)
 	struct rte_eth_dev *dev;
 	struct bond_dev_private *internals;
 
+	if (!bond_check_primary(__func__))
+		return -ENOTSUP;
+
 	if (valid_bonding_port_id(port) != 0)
 		return -EINVAL;
 
@@ -1757,6 +1784,9 @@ rte_eth_bond_8023ad_dedicated_queues_disable(uint16_t port)
 	struct rte_eth_dev *dev;
 	struct bond_dev_private *internals;
 
+	if (!bond_check_primary(__func__))
+		return -ENOTSUP;
+
 	if (valid_bonding_port_id(port) != 0)
 		return -EINVAL;
 
diff --git a/drivers/net/bonding/rte_eth_bond_api.c b/drivers/net/bonding/rte_eth_bond_api.c
index d9b6f1c417..91207e8573 100644
--- a/drivers/net/bonding/rte_eth_bond_api.c
+++ b/drivers/net/bonding/rte_eth_bond_api.c
@@ -159,6 +159,9 @@ rte_eth_bond_create(const char *name, uint8_t mode, uint8_t socket_id)
 	char devargs[52];
 	int ret;
 
+	if (!bond_check_primary(__func__))
+		return -1;
+
 	if (name == NULL) {
 		RTE_BOND_LOG(ERR, "Invalid name specified");
 		return -EINVAL;
@@ -640,9 +643,11 @@ rte_eth_bond_member_add(uint16_t bonding_port_id, uint16_t member_port_id)
 {
 	struct rte_eth_dev *bonding_eth_dev;
 	struct bond_dev_private *internals;
-
 	int retval;
 
+	if (!bond_check_primary(__func__))
+		return -1;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -781,6 +786,9 @@ rte_eth_bond_member_remove(uint16_t bonding_port_id, uint16_t member_port_id)
 	struct bond_dev_private *internals;
 	int retval;
 
+	if (!bond_check_primary(__func__))
+		return -1;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -802,6 +810,9 @@ rte_eth_bond_mode_set(uint16_t bonding_port_id, uint8_t mode)
 {
 	struct rte_eth_dev *bonding_eth_dev;
 
+	if (!bond_check_primary(__func__))
+		return -1;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -834,6 +845,9 @@ rte_eth_bond_primary_set(uint16_t bonding_port_id, uint16_t member_port_id)
 {
 	struct bond_dev_private *internals;
 
+	if (!bond_check_primary(__func__))
+		return -1;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -924,6 +938,9 @@ rte_eth_bond_mac_address_set(uint16_t bonding_port_id,
 	struct rte_eth_dev *bonding_eth_dev;
 	struct bond_dev_private *internals;
 
+	if (!bond_check_primary(__func__))
+		return -1;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -950,6 +967,9 @@ rte_eth_bond_mac_address_reset(uint16_t bonding_port_id)
 	struct rte_eth_dev *bonding_eth_dev;
 	struct bond_dev_private *internals;
 
+	if (!bond_check_primary(__func__))
+		return -1;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -991,6 +1011,9 @@ rte_eth_bond_xmit_policy_set(uint16_t bonding_port_id, uint8_t policy)
 {
 	struct bond_dev_private *internals;
 
+	if (!bond_check_primary(__func__))
+		return -1;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -1036,6 +1059,9 @@ rte_eth_bond_link_monitoring_set(uint16_t bonding_port_id, uint32_t internal_ms)
 {
 	struct bond_dev_private *internals;
 
+	if (!bond_check_primary(__func__))
+		return -1;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -1065,6 +1091,9 @@ rte_eth_bond_link_down_prop_delay_set(uint16_t bonding_port_id,
 {
 	struct bond_dev_private *internals;
 
+	if (!bond_check_primary(__func__))
+		return -1;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -1093,6 +1122,9 @@ rte_eth_bond_link_up_prop_delay_set(uint16_t bonding_port_id, uint32_t delay_ms)
 {
 	struct bond_dev_private *internals;
 
+	if (!bond_check_primary(__func__))
+		return -1;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 63f21d8522..04a2d6f1d2 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -2558,22 +2558,24 @@ bond_ethdev_link_update(struct rte_eth_dev *ethdev, int wait_to_complete)
 
 	struct bond_dev_private *bond_ctx;
 	struct rte_eth_link member_link;
+	struct rte_eth_link bond_link;
 
 	bool one_link_update_succeeded;
 	uint32_t idx;
 	int ret;
 
-	bond_ctx = ethdev->data->dev_private;
+	rte_eth_linkstatus_get(ethdev, &bond_link);
+	bond_link.link_speed = RTE_ETH_SPEED_NUM_NONE;
 
-	ethdev->data->dev_link.link_speed = RTE_ETH_SPEED_NUM_NONE;
+	bond_ctx = ethdev->data->dev_private;
 
 	if (ethdev->data->dev_started == 0 ||
 			bond_ctx->active_member_count == 0) {
-		ethdev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
-		return 0;
+		bond_link.link_status = RTE_ETH_LINK_DOWN;
+		goto out;
 	}
 
-	ethdev->data->dev_link.link_status = RTE_ETH_LINK_UP;
+	bond_link.link_status = RTE_ETH_LINK_UP;
 
 	if (wait_to_complete)
 		link_update = rte_eth_link_get;
@@ -2586,7 +2588,7 @@ bond_ethdev_link_update(struct rte_eth_dev *ethdev, int wait_to_complete)
 		 * Setting link speed to UINT32_MAX to ensure we pick up the
 		 * value of the first active member
 		 */
-		ethdev->data->dev_link.link_speed = UINT32_MAX;
+		bond_link.link_speed = UINT32_MAX;
 
 		/**
 		 * link speed is minimum value of all the members link speed as
@@ -2597,19 +2599,16 @@ bond_ethdev_link_update(struct rte_eth_dev *ethdev, int wait_to_complete)
 			ret = link_update(bond_ctx->active_members[idx],
 					  &member_link);
 			if (ret < 0) {
-				ethdev->data->dev_link.link_speed =
-					RTE_ETH_SPEED_NUM_NONE;
+				bond_link.link_speed = RTE_ETH_SPEED_NUM_NONE;
 				RTE_BOND_LOG(ERR,
 					"Member (port %u) link get failed: %s",
 					bond_ctx->active_members[idx],
 					rte_strerror(-ret));
-				return 0;
+				goto out;
 			}
 
-			if (member_link.link_speed <
-					ethdev->data->dev_link.link_speed)
-				ethdev->data->dev_link.link_speed =
-						member_link.link_speed;
+			if (member_link.link_speed < bond_link.link_speed)
+				bond_link.link_speed = member_link.link_speed;
 		}
 		break;
 	case BONDING_MODE_ACTIVE_BACKUP:
@@ -2619,15 +2618,15 @@ bond_ethdev_link_update(struct rte_eth_dev *ethdev, int wait_to_complete)
 			RTE_BOND_LOG(ERR, "Member (port %u) link get failed: %s",
 				bond_ctx->current_primary_port,
 				rte_strerror(-ret));
-			return 0;
+			goto out;
 		}
 
-		ethdev->data->dev_link.link_speed = member_link.link_speed;
+		bond_link.link_speed = member_link.link_speed;
 		break;
 	case BONDING_MODE_8023AD:
-		ethdev->data->dev_link.link_autoneg =
+		bond_link.link_autoneg =
 				bond_ctx->mode4.member_link.link_autoneg;
-		ethdev->data->dev_link.link_duplex =
+		bond_link.link_duplex =
 				bond_ctx->mode4.member_link.link_duplex;
 		/* fall through */
 		/* to update link speed */
@@ -2640,7 +2639,7 @@ bond_ethdev_link_update(struct rte_eth_dev *ethdev, int wait_to_complete)
 		 * In theses mode the maximum theoretical link speed is the sum
 		 * of all the members
 		 */
-		ethdev->data->dev_link.link_speed = RTE_ETH_SPEED_NUM_NONE;
+		bond_link.link_speed = RTE_ETH_SPEED_NUM_NONE;
 		one_link_update_succeeded = false;
 
 		for (idx = 0; idx < bond_ctx->active_member_count; idx++) {
@@ -2655,17 +2654,17 @@ bond_ethdev_link_update(struct rte_eth_dev *ethdev, int wait_to_complete)
 			}
 
 			one_link_update_succeeded = true;
-			ethdev->data->dev_link.link_speed +=
-					member_link.link_speed;
+			bond_link.link_speed += member_link.link_speed;
 		}
 
 		if (!one_link_update_succeeded) {
 			RTE_BOND_LOG(ERR, "All members link get failed");
-			return 0;
+			goto out;
 		}
 	}
 
-
+out:
+	rte_eth_linkstatus_set(ethdev, &bond_link);
 	return 0;
 }
 
@@ -3640,12 +3639,23 @@ bond_ethdev_priv_dump(struct rte_eth_dev *dev, FILE *f)
 	const struct bond_dev_private *internals = dev->data->dev_private;
 
 	dump_basic(dev, f);
-	if (internals->mode == BONDING_MODE_8023AD)
+	if (internals->mode == BONDING_MODE_8023AD &&
+			rte_eal_process_type() == RTE_PROC_PRIMARY)
 		dump_lacp(dev->data->port_id, f);
 
 	return 0;
 }
 
+static const struct eth_dev_ops secondary_dev_ops = {
+	.dev_close         = bond_ethdev_close,
+	.dev_infos_get     = bond_ethdev_info,
+	.link_update       = bond_ethdev_link_update,
+	.stats_get         = bond_ethdev_stats_get,
+	.reta_query        = bond_ethdev_rss_reta_query,
+	.rss_hash_conf_get = bond_ethdev_rss_hash_conf_get,
+	.eth_dev_priv_dump = bond_ethdev_priv_dump,
+};
+
 const struct eth_dev_ops default_dev_ops = {
 	.dev_start            = bond_ethdev_start,
 	.dev_stop             = bond_ethdev_stop,
@@ -3830,7 +3840,7 @@ bond_probe(struct rte_vdev_device *dev)
 			return -1;
 		}
 
-		eth_dev->dev_ops = &default_dev_ops;
+		eth_dev->dev_ops = &secondary_dev_ops;
 		eth_dev->device = &dev->device;
 
 		/*
-- 
2.34.1

