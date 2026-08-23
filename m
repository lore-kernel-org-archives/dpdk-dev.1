Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4866EC5DF81
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Aug 2026 15:17:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A88340270;
	Sun, 23 Aug 2026 17:17:10 +0200 (CEST)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53]) by mails.dpdk.org (Postfix) with ESMTP id 4DEF740265
 for <dev@dpdk.org>; Sun, 23 Aug 2026 17:17:09 +0200 (CEST)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-8eeb4508f29so16521406d6.0
 for <dev@dpdk.org>; Sun, 23 Aug 2026 08:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787498228; x=1788103028; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oUySUztmcDLOecWWYpmfOLoEfMBlOSWDV9a6SQtMzW8=;
 b=aAZU4iXgfSvhsfl8W310h/wBaE1d8eCj/lULDftYWDpKnpNRYRixdylcbksMnpYrjV
 COLRo/+K98Dxy5CaROntUkKGL9EX8sXP4w7dyI/r8AoM+PtWPAjb/JTXCRD2qyqH7C7g
 WNbjMU5s7XG2J8u4DjvK2ga6u2YaEgSyByiuUJ+00fdaPtPbnnjqtRMrD5pVkA45vz7r
 ODPXkMiguii4+uDjVFDmvgMPv6rkr4Q6KK4Ux9NHpg6MAGvRIVCB8RSLSwuuPDRear6f
 /5A4suf98mCW5DaEdAPjWL4lah60qTtBYIWsFaFHq/jtk82DsPXHbYtQN0NHoItTbN0e
 D6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787498228; x=1788103028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oUySUztmcDLOecWWYpmfOLoEfMBlOSWDV9a6SQtMzW8=;
 b=IMokgX1JwYeGC9Y/87cNGhjjV0Pmt3dOUGk8Ht8ZjV6ra5Wu9/fIr53svb+1scn2lt
 DOLGqebB6+01sQJFn7DKuYeU4R4S7zVrEhEqU1jMx/auNGcOJ0Z4ZkNTENtN9y3uyc/T
 zn9IYoQVJHPjOgiy7W5K4wQ5EN8J8VYKwi2i6h4JBmvleffcwefJy5jKmwzX8B5oNDXd
 bqp0EHXN+dC2tlVDa51oheeM+QhybXcVK10rdTHGELDgqU7sk/GeJwRPKqoUXSOlcNN/
 yQtBcUMR7OsMa2wkTCObCRxaqxBlj2mB3R/VP96OghJY62S0prFdQKh5jLHIN97TFmq8
 WuZw==
X-Gm-Message-State: AFuF++nI18nbVwKOC1uxUiceaz6y+LoADsNK+RcldG2689WBe8PJg0f9
 ylVVhN8dNGyA33SLA9Qc335pvgmWy6K0bvubqRLo/KISrNGOoMzDNiqH
X-Gm-Gg: AR+sD12dlCgWLsxEYhYiPvQylOWvZ5gGKZ8TYip/KxaSFrFuw8AE9JMGBzy80UzWSoQ
 oY4iExar2MiMZllzgu2ChUNMxZ8DUcTXEzb6rBpLsf3xqvSbffxjIBUjcjCKJor9mtgZwvddt5/
 IFvQSSqjVV4ScfNxA/QCqt64Ji8FH1g+dds9chKyfPiRkwpgQmUP2zdAaqm2hnnVN9iA+GmfHkc
 +TKqPYboachjHOB0z/3sjZkZniniAeH+iOTcflFlalO43MiM1uJazv95vkt5oWsH3sZ/f8WDTz0
 rQ4i2Rp8C8FJlOfrkQQHcEucdPcEcPi1vosHAg7JCkNPHg/SWdcOWXtZPpcY9/QHThkj8RWmdDu
 eck2HKewxyK7yFh1uGiTsnKiybR7SvIoz3Nwo28GiqIhRPipShULiVw/ajLiXO2vKH3Sd255tlg
 PqIVD8R4neegWMl262yrxpReUxjKpb3YfhX/EpAdWtVAK5WQOtS4IZ4Q==
X-Received: by 2002:a05:6214:3288:b0:8ce:e651:5d63 with SMTP id
 6a1803df08f44-90c8fa8cb2dmr126972766d6.31.1787498228285; 
 Sun, 23 Aug 2026 08:17:08 -0700 (PDT)
Received: from gmail.com ([50.93.222.110]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c935e4437sm40040876d6.2.2026.08.23.08.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 08:17:07 -0700 (PDT)
From: Weijun Pan <wpan3636@gmail.com>
To: Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org,
	Weijun Pan <wpan3636@gmail.com>
Subject: [RFC PATCH v2] net/bonding: restrict secondary control operations
Date: Sun, 23 Aug 2026 10:16:25 -0500
Message-Id: <20260823151625.18687-1-wpan3636@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708174204.72574-1-wpan3636@gmail.com>
References: <20260708174204.72574-1-wpan3636@gmail.com>
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

The bonding PMD currently supports secondary attach with safe fallback
burst functions, but bonding configuration and LACP state are owned by
the primary process.

Use a secondary-specific dev_ops table so unsupported operations are
rejected by ethdev before PMD callbacks can mutate shared device state.
Also reject bonding-specific control APIs from non-primary processes,
while keeping secondary detach and query paths available.

This keeps secondary process behavior safe while leaving room for future
limited datapath support.

Bugzilla ID: 1900

Signed-off-by: Weijun Pan <wpan3636@gmail.com>
---
 .../link_bonding_poll_mode_drv_lib.rst        | 13 ++++++
 doc/guides/rel_notes/release_26_11.rst        |  6 +++
 drivers/net/bonding/eth_bond_private.h        |  8 ++++
 drivers/net/bonding/rte_eth_bond_8023ad.c     | 45 +++++++++++++++++++
 drivers/net/bonding/rte_eth_bond_api.c        | 44 ++++++++++++++++++
 drivers/net/bonding/rte_eth_bond_pmd.c        | 12 ++++-
 6 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst b/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
index 2fa1ac4028..7ecb05d407 100644
--- a/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
+++ b/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
@@ -254,6 +254,19 @@ Like all other PMD, all functions exported by a PMD are lock-free functions
 that are assumed not to be invoked in parallel on different logical cores to
 work on the same target object.
 
+Bonding device configuration is owned by the primary process. Secondary
+processes may attach to an existing bonding device for query and detach
+operations, but must not change bonding configuration or device state.
+
+In a secondary process, bonding control operations such as configuring,
+starting or stopping the device, setting up queues, changing members,
+changing the bonding mode, updating RSS, changing MAC addresses, changing
+MTU, or configuring ``rte_flow`` rules are not supported.
+
+Secondary process datapath support is limited and bonding mode specific.
+Applications should not rely on secondary processes for bonding datapath
+operation unless support for the selected mode is explicitly documented.
+
 It should also be noted that the PMD receive function should not be invoked
 directly on a member devices after they have been to a bonding device since
 packets read directly from the member device will no longer be available to the
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..8df012c99b 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,12 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated bonding PMD secondary process handling.**
+
+  Bonding devices now use a secondary-process device operations table to
+  keep query and detach paths available while rejecting unsupported control
+  operations before shared ethdev state can be modified. Bonding-specific
+  control APIs are also restricted to the primary process.
 
 Removed Items
 -------------
diff --git a/drivers/net/bonding/eth_bond_private.h b/drivers/net/bonding/eth_bond_private.h
index 378bbba4e6..750e5925df 100644
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
@@ -212,6 +214,12 @@ find_member_by_id(uint16_t *members, uint16_t members_count, uint16_t member_id)
 	return pos;
 }
 
+static inline bool
+bond_process_is_primary(void)
+{
+	return rte_eal_process_type() == RTE_PROC_PRIMARY;
+}
+
 int
 valid_port_id(uint16_t port_id);
 
diff --git a/drivers/net/bonding/rte_eth_bond_8023ad.c b/drivers/net/bonding/rte_eth_bond_8023ad.c
index d1f30229d0..e3d02f0539 100644
--- a/drivers/net/bonding/rte_eth_bond_8023ad.c
+++ b/drivers/net/bonding/rte_eth_bond_8023ad.c
@@ -1428,6 +1428,16 @@ rte_eth_bond_8023ad_conf_get(uint16_t port_id,
 	return 0;
 }
 
+static int
+bond_8023ad_check_primary(const char *op)
+{
+	if (bond_process_is_primary())
+		return 0;
+
+	RTE_BOND_LOG(ERR, "%s not supported in non-primary process", op);
+	return -ENOTSUP;
+}
+
 RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_agg_selection_set)
 int
 rte_eth_bond_8023ad_agg_selection_set(uint16_t port_id,
@@ -1436,6 +1446,11 @@ rte_eth_bond_8023ad_agg_selection_set(uint16_t port_id,
 	struct rte_eth_dev *bond_dev;
 	struct bond_dev_private *internals;
 	struct mode8023ad_private *mode4;
+	int ret;
+
+	ret = bond_8023ad_check_primary(__func__);
+	if (ret != 0)
+		return ret;
 
 	if (valid_bonding_port_id(port_id) != 0)
 		return -EINVAL;
@@ -1508,6 +1523,11 @@ rte_eth_bond_8023ad_setup(uint16_t port_id,
 {
 	struct rte_eth_dev *bond_dev;
 	int err;
+	int ret;
+
+	ret = bond_8023ad_check_primary(__func__);
+	if (ret != 0)
+		return ret;
 
 	err = bond_8023ad_setup_validate(port_id, conf);
 	if (err != 0)
@@ -1592,6 +1612,11 @@ rte_eth_bond_8023ad_ext_collect(uint16_t port_id, uint16_t member_id,
 {
 	struct port *port;
 	int res;
+	int ret;
+
+	ret = bond_8023ad_check_primary(__func__);
+	if (ret != 0)
+		return ret;
 
 	res = bond_8023ad_ext_validate(port_id, member_id);
 	if (res != 0)
@@ -1614,6 +1639,11 @@ rte_eth_bond_8023ad_ext_distrib(uint16_t port_id, uint16_t member_id,
 {
 	struct port *port;
 	int res;
+	int ret;
+
+	ret = bond_8023ad_check_primary(__func__);
+	if (ret != 0)
+		return ret;
 
 	res = bond_8023ad_ext_validate(port_id, member_id);
 	if (res != 0)
@@ -1666,6 +1696,11 @@ rte_eth_bond_8023ad_ext_slowtx(uint16_t port_id, uint16_t member_id,
 {
 	struct port *port;
 	int res;
+	int ret;
+
+	ret = bond_8023ad_check_primary(__func__);
+	if (ret != 0)
+		return ret;
 
 	res = bond_8023ad_ext_validate(port_id, member_id);
 	if (res != 0)
@@ -1727,6 +1762,11 @@ rte_eth_bond_8023ad_dedicated_queues_enable(uint16_t port)
 {
 	struct rte_eth_dev *dev;
 	struct bond_dev_private *internals;
+	int ret;
+
+	ret = bond_8023ad_check_primary(__func__);
+	if (ret != 0)
+		return ret;
 
 	if (valid_bonding_port_id(port) != 0)
 		return -EINVAL;
@@ -1756,6 +1796,11 @@ rte_eth_bond_8023ad_dedicated_queues_disable(uint16_t port)
 {
 	struct rte_eth_dev *dev;
 	struct bond_dev_private *internals;
+	int ret;
+
+	ret = bond_8023ad_check_primary(__func__);
+	if (ret != 0)
+		return ret;
 
 	if (valid_bonding_port_id(port) != 0)
 		return -EINVAL;
diff --git a/drivers/net/bonding/rte_eth_bond_api.c b/drivers/net/bonding/rte_eth_bond_api.c
index d9b6f1c417..c4f055bfa5 100644
--- a/drivers/net/bonding/rte_eth_bond_api.c
+++ b/drivers/net/bonding/rte_eth_bond_api.c
@@ -150,6 +150,17 @@ deactivate_member(struct rte_eth_dev *eth_dev, uint16_t port_id)
 	}
 }
 
+static int
+bond_api_check_primary(const char *op)
+{
+	if (bond_process_is_primary())
+		return 0;
+
+	RTE_BOND_LOG(ERR, "%s not supported in non-primary process", op);
+	return -1;
+}
+
+
 RTE_EXPORT_SYMBOL(rte_eth_bond_create)
 int
 rte_eth_bond_create(const char *name, uint8_t mode, uint8_t socket_id)
@@ -159,6 +170,9 @@ rte_eth_bond_create(const char *name, uint8_t mode, uint8_t socket_id)
 	char devargs[52];
 	int ret;
 
+	if (bond_api_check_primary(__func__) != 0)
+		return -1;
+
 	if (name == NULL) {
 		RTE_BOND_LOG(ERR, "Invalid name specified");
 		return -EINVAL;
@@ -643,6 +657,9 @@ rte_eth_bond_member_add(uint16_t bonding_port_id, uint16_t member_port_id)
 
 	int retval;
 
+	if (bond_api_check_primary(__func__) != 0)
+		return -1;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -781,6 +798,9 @@ rte_eth_bond_member_remove(uint16_t bonding_port_id, uint16_t member_port_id)
 	struct bond_dev_private *internals;
 	int retval;
 
+	if (bond_api_check_primary(__func__) != 0)
+		return -1;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -802,6 +822,9 @@ rte_eth_bond_mode_set(uint16_t bonding_port_id, uint8_t mode)
 {
 	struct rte_eth_dev *bonding_eth_dev;
 
+	if (bond_api_check_primary(__func__) != 0)
+		return -1;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -834,6 +857,9 @@ rte_eth_bond_primary_set(uint16_t bonding_port_id, uint16_t member_port_id)
 {
 	struct bond_dev_private *internals;
 
+	if (bond_api_check_primary(__func__) != 0)
+		return -1;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -924,6 +950,9 @@ rte_eth_bond_mac_address_set(uint16_t bonding_port_id,
 	struct rte_eth_dev *bonding_eth_dev;
 	struct bond_dev_private *internals;
 
+	if (bond_api_check_primary(__func__) != 0)
+		return -1;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -950,6 +979,9 @@ rte_eth_bond_mac_address_reset(uint16_t bonding_port_id)
 	struct rte_eth_dev *bonding_eth_dev;
 	struct bond_dev_private *internals;
 
+	if (bond_api_check_primary(__func__) != 0)
+		return -1;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -991,6 +1023,9 @@ rte_eth_bond_xmit_policy_set(uint16_t bonding_port_id, uint8_t policy)
 {
 	struct bond_dev_private *internals;
 
+	if (bond_api_check_primary(__func__) != 0)
+		return -1;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -1036,6 +1071,9 @@ rte_eth_bond_link_monitoring_set(uint16_t bonding_port_id, uint32_t internal_ms)
 {
 	struct bond_dev_private *internals;
 
+	if (bond_api_check_primary(__func__) != 0)
+		return -1;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -1065,6 +1103,9 @@ rte_eth_bond_link_down_prop_delay_set(uint16_t bonding_port_id,
 {
 	struct bond_dev_private *internals;
 
+	if (bond_api_check_primary(__func__) != 0)
+		return -1;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -1093,6 +1134,9 @@ rte_eth_bond_link_up_prop_delay_set(uint16_t bonding_port_id, uint32_t delay_ms)
 {
 	struct bond_dev_private *internals;
 
+	if (bond_api_check_primary(__func__) != 0)
+		return -1;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 6a4f997b5a..f7fb562cee 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -3644,6 +3644,16 @@ bond_ethdev_priv_dump(struct rte_eth_dev *dev, FILE *f)
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
@@ -3828,7 +3838,7 @@ bond_probe(struct rte_vdev_device *dev)
 			return -1;
 		}
 
-		eth_dev->dev_ops = &default_dev_ops;
+		eth_dev->dev_ops = &secondary_dev_ops;
 		eth_dev->device = &dev->device;
 
 		/*
-- 
2.34.1

