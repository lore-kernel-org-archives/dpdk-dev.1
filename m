Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA032C624A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 16:11:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D54204060A;
	Mon, 31 Aug 2026 18:11:42 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2596B402E9
 for <dev@dpdk.org>; Mon, 31 Aug 2026 18:11:41 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2d7195706f1so36492195ad.0
 for <dev@dpdk.org>; Mon, 31 Aug 2026 09:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788192700;
 x=1788797500; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f9a+3ZTR4SI37Jt2qgYP8C80GhEsurOeaWWmmvHZIzE=;
 b=xs4/kveAvDrFR5aLt4r4codv55/9scyvc3k3HjVTWNSj7FvJYJkH9iqhARac3D01q5
 w557aBCgE3GPOHAHoRuvhG7Z6SjqmWDeKztMSC5W0uVoNI1aFU3bxli2bvFVScaji9Xl
 z836egY8CxjTFKuhrEztVIGW/7+wkkrH2FbpuObEt/Ji/pUB1CoYwBMVqrvVtNbkoxyc
 YUrL8aWKgJaMsOZR/PisLzsQqe1UHWGhnph0ZRv/mJ/YQ1/i6Q7aGpAYdnDGLt0x0XB6
 fGgvaimloIJDcQA6WYDecbltLarXWqXP+OQB0H2Ug6W5s34kALxkPNt6Z+eJ9YovWWCM
 3SKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192700; x=1788797500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f9a+3ZTR4SI37Jt2qgYP8C80GhEsurOeaWWmmvHZIzE=;
 b=jdwt8XqigG/VZiUcFAEckEb8uHAJWf6T3t2E8sYZRrIVMSuIvRInRqF8ZLx7jMryej
 qVBlQMqF+uCqdie4k7CZElF3XCuG4erJ6Jo8YR7V+Gz6Gl8iRQtzr9iVSuQxWhFSKRNs
 6bS78Swvg4LJP8cqINSA5mgpMX0GHr4W8iKBhm1601r0x+vD8o1J1i00LNp33bSVym9c
 NukWyMjHEd9RzQCjGirEXCv8w7Vs4nqP7dVDsj+p+IDQFv+IvyXO2YGB6yvNhNICN6nw
 wFhS6jOAYWeNGVilaq2JUMqcAs/8ANdRkRDRbHoDNfz5cOn0UEX85/tizND1YkmrM5qr
 HXkQ==
X-Gm-Message-State: AFuF++l4hxbI/Z6tSidRIn7BH+9Bja9rMH6oC9Jfn/5tCcm23VsXnvK5
 8rXy0kQ/gWOIt8iB8fj78xeXXVW/dC5MJag5vvgyDrv+piFbNq65otbhhrhk15RO/T6t5XmMyUH
 UDBbI
X-Gm-Gg: AYBFou3X8K38byrYOhldFn0q2YnMJ4Y0wT+QZHcVtb5Ol47pgV61V3NZK56NbAhsHOT
 Mpma/0PZW3gS4AOOROJhPzgGLlQVrMWuhaN9G05/Cim3yyqFcJtNk0tJ1hdHA5oM2K46nFce0/w
 I11dchIvdP3znKnNdX5jaizyalxBHPNACDg/vcVfNQHqxaKO6vcM3YlcrXzHpJglCatCtklCQUp
 hIBmh16UH5i8YsQ9Ug47DDK9OtGUt5pPTm+NYT/HSfUv6OfD2Pfk0aLWfGxv7KvuUagBFdPRXhT
 V0AVQRyT8HZe8xgi45W5bJ51QUFwiKP+NtEkhW+kwuiobhrEYxUFu9wgv3X50qBZXVfgwm/6CtS
 ZEy5Hurkzu6yUan+eqdkVpWzJCS5KvRxNinQwdrSGPVaZGOItnGJfdYPj2wg+Sbfgaa+PvH0Nns
 T6NM75YwgOaIjw6MqbEgSE/ZCnR1J5yVZgdJl1EJH+1zT59NKzb6rXs77sFHP8TJG3c6TbqmqGJ
 2GWimukBPtE9UaKPIUkcqUH9oY=
X-Received: by 2002:a17:902:ebd1:b0:2c9:fb11:1bf4 with SMTP id
 d9443c01a7336-2d94a759208mr23558045ad.7.1788192700108; 
 Mon, 31 Aug 2026 09:11:40 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f7be607sm31355741eec.10.2026.08.31.09.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:11:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Weijun Pan <wpan3636@gmail.com>, Chas Williams <3chas3@gmail.com>,
 "Min Hu (Connor)" <humin29@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Robert Sanford <rsanford@akamai.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH v2 5/8] net/bonding: restrict control ops in secondary process
Date: Mon, 31 Aug 2026 09:06:45 -0700
Message-ID: <20260831161105.289670-6-stephen@networkplumber.org>
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

Secondary process control operations could reach memory not shared
by primary process. Restrict the API to only those things that
 should work by reading shared state.

Bugzilla ID: 1900
Fixes: 2efb58cbab6e ("bond: new link bonding library")
Cc: stable@dpdk.org

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

