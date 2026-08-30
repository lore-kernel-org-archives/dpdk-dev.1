Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED88DC61DD6
	for <dpdk-dev@archiver.kernel.org>; Sun, 30 Aug 2026 01:15:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8B6A402D5;
	Sun, 30 Aug 2026 03:15:03 +0200 (CEST)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53]) by mails.dpdk.org (Postfix) with ESMTP id 277DB4025A
 for <dev@dpdk.org>; Sun, 30 Aug 2026 03:15:02 +0200 (CEST)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-7f3ff92cf4aso2427471a34.1
 for <dev@dpdk.org>; Sat, 29 Aug 2026 18:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788052501; x=1788657301; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2ntRrK4Asd1xoZsBjOiMFJLyCDKPWn+pKQ0g2AOpHDA=;
 b=VXKeCuPa8D5t7Cs+3uY8sbjQq3oRqOozFCKdHaEHkC/AmVRdMlJib7hW2ags5o9DvD
 TyPQPxMd5B2Zp0tqbcXwediXPmnFwzG03IAOpbKzjtuLcnUcmlX6j6nbTy9a2RGqP0WO
 Wn7S4Qd5a4GFdmZ8J5ThuyqOrxiTCcRft+AVbdNOC2rnotzahga7d11TUUdMdtilhaT+
 dU0rkaKtPV6uBxP5X9oBZO13p01/7xjPFQKF3Ktzd4ESCjrVFngYLCYqnDlxMBNMmGEC
 bk8PFZx5wu/0MJn36ukOpXfjq8lDMNJXcn0M9rCI0z30EEkr/GTaJTYhJ/XpNEA2SiKk
 4Wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788052501; x=1788657301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2ntRrK4Asd1xoZsBjOiMFJLyCDKPWn+pKQ0g2AOpHDA=;
 b=cJ6kkQA97AAoB1DbqVRo4CzKtyBKOP0PBWtYhCtOJPnrnWrXN7o6dJMlQG6NN7rF1A
 CtwndxfOXsje7MWfZLVGZFN91EcjMq9S4PJ8OJGJGXnlSCQz2txNSCIrbfaozCHhF/d+
 zdcORZU7uJs0QsfVJu0xdf5ebmnfUeN9wSkmjTq0Q8j9INcP+l0nbm1ldjl0x9S9nL1s
 aBG8x2c09udGLXtuO3TDq4D8cqcf8UMGO69qNfYv7N/GVI/8yOwkzEVPoYYKr1ld93VP
 TPlc/olMimOoJlCdTyv6HiybhvM/uQtu2ZM4SDbymitEFNtAlD7TNIXK9eje24te7VFQ
 m/Tg==
X-Gm-Message-State: AFuF++l+Ot6WBVDFM7tXBWnrdSckJwd8jXgOUlNlczR3pO924TS/YxUC
 ofeRxo/WHc/A5IgR8auot/Ej7yxj8UtdzhVUKe1eg5iewEUs/SUNoFpP
X-Gm-Gg: AR+sD13/ycbPHxnOoLdQ7Eq7OPy5BtEwsOj+I053p7fF4v45vczaZt5rr83RSxYAI7K
 m72fo9n/Ae3h0A3G3iPmRTMnCP7aFA3eAZp5vL2WrC3t9tOWxu9XdyLGLjB7K9umbQr/yIyvMID
 NTO5ZCIgVryTQqRz9Z5hhnsxTAybgvU6q84ZUEEbOq7TZqo09gczlZVi1YaH/Mt4A1X20L3Wzxi
 +2tvBZLNtqDQvLNV51sza7GOHLaWegEG/LmCxFDCeCi6ZTUoUnjtJOPoTu+Nqxxpii4jQrXyYsC
 J8c4ITyACPAURTqZtQ8Ua9WFUp0CzkNRMiqUg8tZTnAiaeMNQqcx+rwp4p29QfcHRaajrNy9lQS
 9odq4VCvR8XXBy2rQfCUYrEgdBbdlKwE/NPZyhM2JXec03/ha54mu1wnxCRyi9aG3j79sqJ2UBN
 psXU3rfpoHH45J8whbv2MQ13LJyrnJn/8zc5viAxobcSAGkRlS1wG5zqAWzuitLOZVNH8fo77nd
 i4RY2iRoBg=
X-Received: by 2002:a05:6830:498a:b0:7f4:eaba:faf4 with SMTP id
 46e09a7af769-7f4f235dd2amr21884817a34.11.1788052501318; 
 Sat, 29 Aug 2026 18:15:01 -0700 (PDT)
Received: from gmail.com (dyn-72-33-2-213.uwnet.wisc.edu. [72.33.2.213])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4fa99d927sm4702369a34.19.2026.08.29.18.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 18:15:00 -0700 (PDT)
From: Weijun Pan <wpan3636@gmail.com>
To: Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org,
	Weijun Pan <wpan3636@gmail.com>
Subject: [RFC PATCH v4 2/2] net/bonding: restrict secondary control operations
Date: Sat, 29 Aug 2026 20:14:45 -0500
Message-Id: <20260830011445.168073-2-wpan3636@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260830011445.168073-1-wpan3636@gmail.com>
References: <20260826161009.37875-1-wpan3636@gmail.com>
 <20260830011445.168073-1-wpan3636@gmail.com>
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
when called from a non-primary process.

Supported query and detach paths remain available, while LACP runtime
state queries are restricted to the primary process.

Bugzilla ID: 1900

Signed-off-by: Weijun Pan <wpan3636@gmail.com>
---
v4:
- Use rte_eth_linkstatus_set() in link update.
- Document supported secondary query and detach paths.
- Move the release note to API Changes.
- Keep secondary private dump but skip LACP state.

 .../link_bonding_poll_mode_drv_lib.rst        | 30 ++++++++++
 doc/guides/rel_notes/release_26_11.rst        |  6 ++
 drivers/net/bonding/eth_bond_private.h        | 12 ++++
 drivers/net/bonding/rte_eth_bond_8023ad.c     | 48 +++++++++++++++
 drivers/net/bonding/rte_eth_bond_api.c        | 53 ++++++++++++++++-
 drivers/net/bonding/rte_eth_bond_pmd.c        | 58 +++++++++++--------
 6 files changed, 182 insertions(+), 25 deletions(-)

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
index c8cc86295d..60d8146d68 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -81,6 +81,12 @@ Removed Items
 API Changes
 -----------
 
+* **Restricted bonding device control to the primary process.**
+
+  Bonding device configuration and LACP runtime state operations are now
+  rejected in secondary processes. Secondary processes may detach and use
+  supported query operations only.
+
 .. This section should contain API changes. Sample format:
 
    * sample: Add a short 1-2 sentence description of the API change
diff --git a/drivers/net/bonding/eth_bond_private.h b/drivers/net/bonding/eth_bond_private.h
index 378bbba4e6..526bcd0363 100644
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
 
+static inline int
+bond_check_primary(const char *op, int err)
+{
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		return 0;
+
+	RTE_BOND_LOG(ERR, "%s not supported in non-primary process", op);
+	return err;
+}
+
 int
 valid_port_id(uint16_t port_id);
 
diff --git a/drivers/net/bonding/rte_eth_bond_8023ad.c b/drivers/net/bonding/rte_eth_bond_8023ad.c
index d1f30229d0..65f417a444 100644
--- a/drivers/net/bonding/rte_eth_bond_8023ad.c
+++ b/drivers/net/bonding/rte_eth_bond_8023ad.c
@@ -1436,6 +1436,11 @@ rte_eth_bond_8023ad_agg_selection_set(uint16_t port_id,
 	struct rte_eth_dev *bond_dev;
 	struct bond_dev_private *internals;
 	struct mode8023ad_private *mode4;
+	int ret;
+
+	ret = bond_check_primary(__func__, -ENOTSUP);
+	if (ret != 0)
+		return ret;
 
 	if (valid_bonding_port_id(port_id) != 0)
 		return -EINVAL;
@@ -1508,6 +1513,11 @@ rte_eth_bond_8023ad_setup(uint16_t port_id,
 {
 	struct rte_eth_dev *bond_dev;
 	int err;
+	int ret;
+
+	ret = bond_check_primary(__func__, -ENOTSUP);
+	if (ret != 0)
+		return ret;
 
 	err = bond_8023ad_setup_validate(port_id, conf);
 	if (err != 0)
@@ -1531,6 +1541,11 @@ rte_eth_bond_8023ad_member_info(uint16_t port_id, uint16_t member_id,
 	struct rte_eth_dev *bond_dev;
 	struct bond_dev_private *internals;
 	struct port *port;
+	int ret;
+
+	ret = bond_check_primary(__func__, -ENOTSUP);
+	if (ret != 0)
+		return ret;
 
 	if (info == NULL || valid_bonding_port_id(port_id) != 0 ||
 			rte_eth_bond_mode_get(port_id) != BONDING_MODE_8023AD)
@@ -1592,6 +1607,11 @@ rte_eth_bond_8023ad_ext_collect(uint16_t port_id, uint16_t member_id,
 {
 	struct port *port;
 	int res;
+	int ret;
+
+	ret = bond_check_primary(__func__, -ENOTSUP);
+	if (ret != 0)
+		return ret;
 
 	res = bond_8023ad_ext_validate(port_id, member_id);
 	if (res != 0)
@@ -1614,6 +1634,11 @@ rte_eth_bond_8023ad_ext_distrib(uint16_t port_id, uint16_t member_id,
 {
 	struct port *port;
 	int res;
+	int ret;
+
+	ret = bond_check_primary(__func__, -ENOTSUP);
+	if (ret != 0)
+		return ret;
 
 	res = bond_8023ad_ext_validate(port_id, member_id);
 	if (res != 0)
@@ -1636,6 +1661,10 @@ rte_eth_bond_8023ad_ext_distrib_get(uint16_t port_id, uint16_t member_id)
 	struct port *port;
 	int err;
 
+	err = bond_check_primary(__func__, -ENOTSUP);
+	if (err != 0)
+		return err;
+
 	err = bond_8023ad_ext_validate(port_id, member_id);
 	if (err != 0)
 		return err;
@@ -1651,6 +1680,10 @@ rte_eth_bond_8023ad_ext_collect_get(uint16_t port_id, uint16_t member_id)
 	struct port *port;
 	int err;
 
+	err = bond_check_primary(__func__, -ENOTSUP);
+	if (err != 0)
+		return err;
+
 	err = bond_8023ad_ext_validate(port_id, member_id);
 	if (err != 0)
 		return err;
@@ -1666,6 +1699,11 @@ rte_eth_bond_8023ad_ext_slowtx(uint16_t port_id, uint16_t member_id,
 {
 	struct port *port;
 	int res;
+	int ret;
+
+	ret = bond_check_primary(__func__, -ENOTSUP);
+	if (ret != 0)
+		return ret;
 
 	res = bond_8023ad_ext_validate(port_id, member_id);
 	if (res != 0)
@@ -1727,6 +1765,11 @@ rte_eth_bond_8023ad_dedicated_queues_enable(uint16_t port)
 {
 	struct rte_eth_dev *dev;
 	struct bond_dev_private *internals;
+	int ret;
+
+	ret = bond_check_primary(__func__, -ENOTSUP);
+	if (ret != 0)
+		return ret;
 
 	if (valid_bonding_port_id(port) != 0)
 		return -EINVAL;
@@ -1756,6 +1799,11 @@ rte_eth_bond_8023ad_dedicated_queues_disable(uint16_t port)
 {
 	struct rte_eth_dev *dev;
 	struct bond_dev_private *internals;
+	int ret;
+
+	ret = bond_check_primary(__func__, -ENOTSUP);
+	if (ret != 0)
+		return ret;
 
 	if (valid_bonding_port_id(port) != 0)
 		return -EINVAL;
diff --git a/drivers/net/bonding/rte_eth_bond_api.c b/drivers/net/bonding/rte_eth_bond_api.c
index d9b6f1c417..029e141d89 100644
--- a/drivers/net/bonding/rte_eth_bond_api.c
+++ b/drivers/net/bonding/rte_eth_bond_api.c
@@ -159,6 +159,10 @@ rte_eth_bond_create(const char *name, uint8_t mode, uint8_t socket_id)
 	char devargs[52];
 	int ret;
 
+	ret = bond_check_primary(__func__, -1);
+	if (ret != 0)
+		return ret;
+
 	if (name == NULL) {
 		RTE_BOND_LOG(ERR, "Invalid name specified");
 		return -EINVAL;
@@ -640,9 +644,12 @@ rte_eth_bond_member_add(uint16_t bonding_port_id, uint16_t member_port_id)
 {
 	struct rte_eth_dev *bonding_eth_dev;
 	struct bond_dev_private *internals;
-
 	int retval;
 
+	retval = bond_check_primary(__func__, -1);
+	if (retval != 0)
+		return retval;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -781,6 +788,10 @@ rte_eth_bond_member_remove(uint16_t bonding_port_id, uint16_t member_port_id)
 	struct bond_dev_private *internals;
 	int retval;
 
+	retval = bond_check_primary(__func__, -1);
+	if (retval != 0)
+		return retval;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -801,6 +812,11 @@ int
 rte_eth_bond_mode_set(uint16_t bonding_port_id, uint8_t mode)
 {
 	struct rte_eth_dev *bonding_eth_dev;
+	int ret;
+
+	ret = bond_check_primary(__func__, -1);
+	if (ret != 0)
+		return ret;
 
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
@@ -833,6 +849,11 @@ int
 rte_eth_bond_primary_set(uint16_t bonding_port_id, uint16_t member_port_id)
 {
 	struct bond_dev_private *internals;
+	int ret;
+
+	ret = bond_check_primary(__func__, -1);
+	if (ret != 0)
+		return ret;
 
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
@@ -923,6 +944,11 @@ rte_eth_bond_mac_address_set(uint16_t bonding_port_id,
 {
 	struct rte_eth_dev *bonding_eth_dev;
 	struct bond_dev_private *internals;
+	int ret;
+
+	ret = bond_check_primary(__func__, -1);
+	if (ret != 0)
+		return ret;
 
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
@@ -949,6 +975,11 @@ rte_eth_bond_mac_address_reset(uint16_t bonding_port_id)
 {
 	struct rte_eth_dev *bonding_eth_dev;
 	struct bond_dev_private *internals;
+	int ret;
+
+	ret = bond_check_primary(__func__, -1);
+	if (ret != 0)
+		return ret;
 
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
@@ -990,6 +1021,11 @@ int
 rte_eth_bond_xmit_policy_set(uint16_t bonding_port_id, uint8_t policy)
 {
 	struct bond_dev_private *internals;
+	int ret;
+
+	ret = bond_check_primary(__func__, -1);
+	if (ret != 0)
+		return ret;
 
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
@@ -1035,6 +1071,11 @@ int
 rte_eth_bond_link_monitoring_set(uint16_t bonding_port_id, uint32_t internal_ms)
 {
 	struct bond_dev_private *internals;
+	int ret;
+
+	ret = bond_check_primary(__func__, -1);
+	if (ret != 0)
+		return ret;
 
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
@@ -1064,6 +1105,11 @@ rte_eth_bond_link_down_prop_delay_set(uint16_t bonding_port_id,
 
 {
 	struct bond_dev_private *internals;
+	int ret;
+
+	ret = bond_check_primary(__func__, -1);
+	if (ret != 0)
+		return ret;
 
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
@@ -1092,6 +1138,11 @@ rte_eth_bond_link_up_prop_delay_set(uint16_t bonding_port_id, uint32_t delay_ms)
 
 {
 	struct bond_dev_private *internals;
+	int ret;
+
+	ret = bond_check_primary(__func__, -1);
+	if (ret != 0)
+		return ret;
 
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 6f10dbb0c7..bba93a5638 100644
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
 
@@ -3641,12 +3640,23 @@ bond_ethdev_priv_dump(struct rte_eth_dev *dev, FILE *f)
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
@@ -3831,7 +3841,7 @@ bond_probe(struct rte_vdev_device *dev)
 			return -1;
 		}
 
-		eth_dev->dev_ops = &default_dev_ops;
+		eth_dev->dev_ops = &secondary_dev_ops;
 		eth_dev->device = &dev->device;
 
 		/*
-- 
2.34.1

