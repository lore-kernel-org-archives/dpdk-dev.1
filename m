Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3F4C61DEB
	for <dpdk-dev@archiver.kernel.org>; Sun, 30 Aug 2026 20:27:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C12654060F;
	Sun, 30 Aug 2026 22:27:10 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 540F3402EF
 for <dev@dpdk.org>; Sun, 30 Aug 2026 22:27:09 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-39647aa9d52so2716900a91.0
 for <dev@dpdk.org>; Sun, 30 Aug 2026 13:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788121628;
 x=1788726428; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3SlpkY9Svel1T44fN0IGDvxvQYY2Dhj7swjZ3dhEiJE=;
 b=HUeTmI3K0KXfkwiC3mSU9i7/Yy+egbOwj/3OqaAEaqUNez/v8B2lgiNVyedQQkcpyW
 kSppHExrF5cGqO16wyQnEYLOfPJpoB+J7FHqPGjSHWo06tY3KKZY+Gbf+4H6/+ChgV18
 EV7O3xCCGd7/mgfKZTI9zklLimxmHRks4QlLDLczSsF00Nx964J1f/XBSO1S11YMvNb/
 IPgvauvPV49bQW48rS76qGEki/QVxRBbXwpY2hClfRg7/4CmfE3hYYFLzm+E9KCRNs38
 rOwcOnaCXB0N+9nluJvfN7mX5udbuFKFqpt0xVuNEXS9SDTGEmO+gZPsr7DVP3rpZu96
 W40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788121628; x=1788726428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3SlpkY9Svel1T44fN0IGDvxvQYY2Dhj7swjZ3dhEiJE=;
 b=QdQicwkVG4+GSPnzKlttjXj8/OgVUW1mk1ghhknNVwEYqyzwZFlbK+lT2gEaARLHCr
 +MeXugbJOX3rrK75/vIs2krAjr25Fu0qjOnLLffU1iE9QQfSUQTpX/M16WW/kotUM7XQ
 ZCQb6SZ/R8jedhUDkvxeTfwcBu78hkPsSMC1fUDSQpaisiY2GjiL8fr5oI22oqVMr8d5
 T4O+Sn4h7BabFYbBL8vo6EngzyD4yGhMBb9UXGIJLEVYVhjTApw1tCfQYk+yiyfHyMrD
 sX/1foD2MWzwEblpYXivVfnN679qyqMP18dleUVzDcbymEO+dl61U4v/WzzHCA72rZj1
 X6EA==
X-Gm-Message-State: AFuF++kEbzdWJZ63lLsxPtmE1mzbJnFDJbLLIAsg0qQaN4NF4eOFEUoQ
 OOgQxYC1Wz5HVW4hhjdQU/+XHHyq0GENSmq62ubM7xs+xaX5F4YrL1eS5Xii/grQqz3t7tIKlyS
 bVwvZ
X-Gm-Gg: AYBFou1o8ztFdGg6NZrMvGX8XtWU5WjgmaDBWN3hkZWMomWFByEJBi7QcPVDSM2zrml
 9BJhgRJaSinBpHp0FyouSMRu6kWhhtM2fmoHucAAOuAgSxFjir0CDk8pvRA+mq23p+ud3J5kwti
 xlu1gurj2neDUHcGFpXeSE2S95csu3R811Gq7pX+Ik+6eq16dXo3FdUbMDD3hABJTbhpeZ0Ahdy
 CYp3emCjQ9y/y1+PRMCgBZq7f6SHenceP4lLXwFRBkhH89Vzo7Cq4U1BmYS9chVBq20dCdDfkPg
 57/c4EXmWzSjALs2zP4G85xKDT7vHqcVJzMD7XQPq32trtro9lM0P/sGrQoJkOulWPnt1wRM1dR
 mrDUivragzXEPL2uuZgvSUl66bmeBSYR9QX2j/Urgqwd6jcbTRm6cMDALQ6b7Ft68QVBuBL4mv1
 87bQOTzv8pvVFsavYCMMpdPdyfPHB68abqB70WniVtkQ28o1uP+GkJOKB6Amstqze639DroG6SD
 8iPCA6RExBHO4fz53SBaxHRSfs=
X-Received: by 2002:a17:90b:1d0d:b0:398:9bd3:d6d1 with SMTP id
 98e67ed59e1d1-398da6f3ec3mr3122774a91.11.1788121628435; 
 Sun, 30 Aug 2026 13:27:08 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd5c34sm17683165a91.8.2026.08.30.13.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 13:27:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Weijun Pan <wpan3636@gmail.com>, Chas Williams <3chas3@gmail.com>,
 "Min Hu (Connor)" <humin29@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Robert Sanford <rsanford@akamai.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Declan Doherty <declan.doherty@intel.com>
Subject: [PATCH 5/8] net/bonding: restrict control operations in secondary
 process
Date: Sun, 30 Aug 2026 13:23:47 -0700
Message-ID: <20260830202636.760014-6-stephen@networkplumber.org>
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

Secondary process control operations could reach memory
not shared by primary process. Restrict the API to only
those things that should work by reading shared state.

Fixes: 2efb58cbab6e ("bond: new link bonding library")
Cc: stable@dpdk.org

Bugzilla ID: 1900

Reported-by: Weijun Pan <wpan3636@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bonding/rte_eth_bond_8023ad.c | 18 +++++++++++++++++
 drivers/net/bonding/rte_eth_bond_api.c    | 24 +++++++++++++++++++++++
 drivers/net/bonding/rte_eth_bond_pmd.c    | 18 +++++++++++++++--
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/rte_eth_bond_8023ad.c b/drivers/net/bonding/rte_eth_bond_8023ad.c
index d1f30229d0..29d4de0e1d 100644
--- a/drivers/net/bonding/rte_eth_bond_8023ad.c
+++ b/drivers/net/bonding/rte_eth_bond_8023ad.c
@@ -1440,6 +1440,9 @@ rte_eth_bond_8023ad_agg_selection_set(uint16_t port_id,
 	if (valid_bonding_port_id(port_id) != 0)
 		return -EINVAL;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -ENOTSUP;
+
 	bond_dev = &rte_eth_devices[port_id];
 	internals = bond_dev->data->dev_private;
 
@@ -1509,6 +1512,9 @@ rte_eth_bond_8023ad_setup(uint16_t port_id,
 	struct rte_eth_dev *bond_dev;
 	int err;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -ENOTSUP;
+
 	err = bond_8023ad_setup_validate(port_id, conf);
 	if (err != 0)
 		return err;
@@ -1532,6 +1538,9 @@ rte_eth_bond_8023ad_member_info(uint16_t port_id, uint16_t member_id,
 	struct bond_dev_private *internals;
 	struct port *port;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -ENOTSUP;
+
 	if (info == NULL || valid_bonding_port_id(port_id) != 0 ||
 			rte_eth_bond_mode_get(port_id) != BONDING_MODE_8023AD)
 		return -EINVAL;
@@ -1564,6 +1573,9 @@ bond_8023ad_ext_validate(uint16_t port_id, uint16_t member_id)
 	struct bond_dev_private *internals;
 	struct mode8023ad_private *mode4;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -ENOTSUP;
+
 	if (rte_eth_bond_mode_get(port_id) != BONDING_MODE_8023AD)
 		return -EINVAL;
 
@@ -1728,6 +1740,9 @@ rte_eth_bond_8023ad_dedicated_queues_enable(uint16_t port)
 	struct rte_eth_dev *dev;
 	struct bond_dev_private *internals;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -ENOTSUP;
+
 	if (valid_bonding_port_id(port) != 0)
 		return -EINVAL;
 
@@ -1757,6 +1772,9 @@ rte_eth_bond_8023ad_dedicated_queues_disable(uint16_t port)
 	struct rte_eth_dev *dev;
 	struct bond_dev_private *internals;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -ENOTSUP;
+
 	if (valid_bonding_port_id(port) != 0)
 		return -EINVAL;
 
diff --git a/drivers/net/bonding/rte_eth_bond_api.c b/drivers/net/bonding/rte_eth_bond_api.c
index d9b6f1c417..505dd86dd8 100644
--- a/drivers/net/bonding/rte_eth_bond_api.c
+++ b/drivers/net/bonding/rte_eth_bond_api.c
@@ -159,6 +159,9 @@ rte_eth_bond_create(const char *name, uint8_t mode, uint8_t socket_id)
 	char devargs[52];
 	int ret;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -ENOTSUP;
+
 	if (name == NULL) {
 		RTE_BOND_LOG(ERR, "Invalid name specified");
 		return -EINVAL;
@@ -643,6 +646,9 @@ rte_eth_bond_member_add(uint16_t bonding_port_id, uint16_t member_port_id)
 
 	int retval;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -ENOTSUP;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -781,6 +787,9 @@ rte_eth_bond_member_remove(uint16_t bonding_port_id, uint16_t member_port_id)
 	struct bond_dev_private *internals;
 	int retval;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -ENOTSUP;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -834,6 +843,9 @@ rte_eth_bond_primary_set(uint16_t bonding_port_id, uint16_t member_port_id)
 {
 	struct bond_dev_private *internals;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -ENOTSUP;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -924,6 +936,9 @@ rte_eth_bond_mac_address_set(uint16_t bonding_port_id,
 	struct rte_eth_dev *bonding_eth_dev;
 	struct bond_dev_private *internals;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -ENOTSUP;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -950,6 +965,9 @@ rte_eth_bond_mac_address_reset(uint16_t bonding_port_id)
 	struct rte_eth_dev *bonding_eth_dev;
 	struct bond_dev_private *internals;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -ENOTSUP;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -991,6 +1009,9 @@ rte_eth_bond_xmit_policy_set(uint16_t bonding_port_id, uint8_t policy)
 {
 	struct bond_dev_private *internals;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -ENOTSUP;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
@@ -1036,6 +1057,9 @@ rte_eth_bond_link_monitoring_set(uint16_t bonding_port_id, uint32_t internal_ms)
 {
 	struct bond_dev_private *internals;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -ENOTSUP;
+
 	if (valid_bonding_port_id(bonding_port_id) != 0)
 		return -1;
 
diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 6f3c13d6fb..0e18ded4a5 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -3695,12 +3695,26 @@ bond_ethdev_priv_dump(struct rte_eth_dev *dev, FILE *f)
 	const struct bond_dev_private *internals = dev->data->dev_private;
 
 	dump_basic(dev, f);
-	if (internals->mode == BONDING_MODE_8023AD)
+
+	/* LACP state machine data is private to the primary process. */
+	if (internals->mode == BONDING_MODE_8023AD &&
+			rte_eal_process_type() == RTE_PROC_PRIMARY)
 		dump_lacp(dev->data->port_id, f);
 
 	return 0;
 }
 
+/* Restricted set of ops allowed in secondary process. */
+static const struct eth_dev_ops secondary_dev_ops = {
+	.dev_close            = bond_ethdev_close,
+	.dev_infos_get        = bond_ethdev_info,
+	.link_update          = bond_ethdev_link_update,
+	.stats_get            = bond_ethdev_stats_get,
+	.reta_query           = bond_ethdev_rss_reta_query,
+	.rss_hash_conf_get    = bond_ethdev_rss_hash_conf_get,
+	.eth_dev_priv_dump    = bond_ethdev_priv_dump,
+};
+
 const struct eth_dev_ops default_dev_ops = {
 	.dev_start            = bond_ethdev_start,
 	.dev_stop             = bond_ethdev_stop,
@@ -3885,7 +3899,7 @@ bond_probe(struct rte_vdev_device *dev)
 			return -1;
 		}
 
-		eth_dev->dev_ops = &default_dev_ops;
+		eth_dev->dev_ops = &secondary_dev_ops;
 		eth_dev->device = &dev->device;
 
 		/*
-- 
2.53.0

