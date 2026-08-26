Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803B3C5DF97
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 16:10:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46B0740268;
	Wed, 26 Aug 2026 18:10:38 +0200 (CEST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 999A440264
 for <dev@dpdk.org>; Wed, 26 Aug 2026 18:10:36 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-90cd4631090so130286d6.1
 for <dev@dpdk.org>; Wed, 26 Aug 2026 09:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787760636; x=1788365436; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C2H750ej6Q5SURJb5G5TepyIGJOzXRlWKIe9E9Oeiw4=;
 b=myChaubOM6y6TuNRF2WY3JDQvKT77ssTpcEKCrs877RleGDQFGSYDuIH0jJ9Ow06tq
 y5SAcwASd9Jp9WoER4d5lLQK3OlDRHG6hHvTCThLVsfLrAVfvP2uOSZoIfdMJ/yxvsXU
 iYROoJEWCxaebqzTAI3m4wQ42yTlme2QYcxE3/tQe6W6W+4I2mmCAaehv9VvAJ8rr8ZX
 EzWNhjj0LHzdNTPzK8NKh0+kwwnpkGScS8i+GaOL1Ue6973wAP0z7jSTAi1THTFGciW+
 Rkj3UGmnszFSwjeD9j7mrY4IrT1iiHNU/po063X/0ovYiyEZufXRWo5gtqqSOAupek2N
 lxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787760636; x=1788365436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C2H750ej6Q5SURJb5G5TepyIGJOzXRlWKIe9E9Oeiw4=;
 b=jP1XiOdS/dMUwwg/n7Mi25KCH497Y558q0p0dFrmu0PU2GGCzDuU+8d4oyOYIpyT0h
 Rdxmh717C0tR0DASHM0mPc4V1zim+Ev1ir+FjeYQLz1wQb03OwJHiEZLfBVYIBITIdxt
 0WT1jiaEEiPB6cGMtylE9r3mnSCEPJQKhWcirUxgYjxCqRWhdwQ09JcmpFKKxWnaBkwm
 5RBhYuoe2YnyU55QfMxRoUKbKdD4gQFMTLkm0/A5kSVbxtif1B8Kiy7ZeNwLn0AU3NAc
 hbH8tSRmcL7RqAuwfmfu0Go9r6iQtncC/kKOEspeliMSdkG+d5TkA1oiRe5OAIzRPqSP
 9Jhg==
X-Gm-Message-State: AFuF++kkyEkhqaKlYqVgTqr6byDd4wf6arDXHWB/uRP8xfnGom3qQm0/
 V8Xf4N3PSQR/u97u4CPPhoxueojYRgoib4d4pdg8t76erMUC1sj/2X6Y
X-Gm-Gg: AR+sD130bWiuhYpv606ERisyWMLI9cXwi/Z5YTwllr5ckjYgqsczyB39LPXcrkDMNPA
 GbPDt+7hevJQLejyGNPSD3Vy1oNeqU36+myslJnu7tM8rg/BSgkUDWLBQDihHAAO+l0DbnuV4ET
 49drHPr7sreMYCeFpHnUfDt4T3VxwmXKAx5OJ7xT97zi2VM/+HtsObOr/QP8xKKuGwNRhyZ7K7m
 Lq54BBNQgZcYH5ioGEfx0eISSMFoPRgGDZR+qtEclxJ1dlOUcb8BYw/rvD/QbEPvlrtWuwlZuj4
 FsYmWji6FjCQzF7NR6eI+41MDzYFp/OSAd6qd2S2/6KlOiP3ywEIY7f6yqkdBhsf9UitdvYKcd0
 pnpgt+3ylf4QKhRsNzcUDdOFePiJBdF/8d2l77KywLj1GfWrjY/uOi2Qm6gyph7+ceuq79FxzxO
 MV4cbObeYxPjAdxLjXH/JLze+NbbQi/uLB5+/DbqmwD6LFdMlAZAEFpw==
X-Received: by 2002:a05:6214:4009:b0:8f1:5e32:9b06 with SMTP id
 6a1803df08f44-90cd447d97fmr2923796d6.13.1787760635484; 
 Wed, 26 Aug 2026 09:10:35 -0700 (PDT)
Received: from gmail.com ([50.93.222.110]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cc65270a9sm28996776d6.38.2026.08.26.09.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:10:35 -0700 (PDT)
From: Weijun Pan <wpan3636@gmail.com>
To: Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org,
	Weijun Pan <wpan3636@gmail.com>
Subject: [RFC PATCH v3] net/bonding: restrict secondary control operations
Date: Wed, 26 Aug 2026 11:10:09 -0500
Message-Id: <20260826161009.37875-1-wpan3636@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260823151625.18687-1-wpan3636@gmail.com>
References: <20260823151625.18687-1-wpan3636@gmail.com>
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

Bonding configuration and LACP state are owned by the primary
process. Install a reduced dev_ops table in secondary processes so
ethdev rejects control operations, and reject the bonding control
API when called from a non-primary process. Query and detach remain
available.

Bugzilla ID: 1900

Signed-off-by: Weijun Pan <wpan3636@gmail.com>
---
v3:
- Document that secondary bonding Rx/Tx are unsupported.
- Reject secondary LACP runtime state queries.
- Remove private dump from secondary dev_ops.
- Use a common primary-process helper.
- Shorten release notes.

 .../link_bonding_poll_mode_drv_lib.rst        | 13 +++++
 doc/guides/rel_notes/release_26_11.rst        |  4 ++
 drivers/net/bonding/eth_bond_private.h        | 12 +++++
 drivers/net/bonding/rte_eth_bond_8023ad.c     | 48 +++++++++++++++++
 drivers/net/bonding/rte_eth_bond_api.c        | 53 ++++++++++++++++++-
 drivers/net/bonding/rte_eth_bond_pmd.c        | 11 +++-
 6 files changed, 139 insertions(+), 2 deletions(-)

diff --git a/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst b/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
index 2fa1ac4028..8e602e51b1 100644
--- a/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
+++ b/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
@@ -254,6 +254,19 @@ Like all other PMD, all functions exported by a PMD are lock-free functions
 that are assumed not to be invoked in parallel on different logical cores to
 work on the same target object.
 
+Bonding device configuration and LACP runtime state are owned by the primary
+process. Secondary processes may attach to an existing bonding device for
+supported query and detach operations, but control operations are restricted
+to the primary process.
+
+In a secondary process, bonding control operations such as configuring,
+starting or stopping the device, setting up queues, changing members,
+changing the bonding mode, updating RSS, changing MAC addresses, changing
+MTU, or configuring ``rte_flow`` rules are not supported.
+
+Rx and Tx are not supported on a bonding device in a secondary process;
+receive returns no packets and transmit drops packets.
+
 It should also be noted that the PMD receive function should not be invoked
 directly on a member devices after they have been to a bonding device since
 packets read directly from the member device will no longer be available to the
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..1d03e3ee9b 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,10 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Restricted bonding device control to the primary process.**
+
+  Supported query and detach paths remain available to secondary processes,
+  while bonding device configuration changes are rejected.
 
 Removed Items
 -------------
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
index 6a4f997b5a..b250d01445 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -3644,6 +3644,15 @@ bond_ethdev_priv_dump(struct rte_eth_dev *dev, FILE *f)
 	return 0;
 }
 
+static const struct eth_dev_ops secondary_dev_ops = {
+	.dev_close         = bond_ethdev_close,
+	.dev_infos_get     = bond_ethdev_info,
+	.link_update       = bond_ethdev_link_update,
+	.stats_get         = bond_ethdev_stats_get,
+	.reta_query        = bond_ethdev_rss_reta_query,
+	.rss_hash_conf_get = bond_ethdev_rss_hash_conf_get,
+};
+
 const struct eth_dev_ops default_dev_ops = {
 	.dev_start            = bond_ethdev_start,
 	.dev_stop             = bond_ethdev_stop,
@@ -3828,7 +3837,7 @@ bond_probe(struct rte_vdev_device *dev)
 			return -1;
 		}
 
-		eth_dev->dev_ops = &default_dev_ops;
+		eth_dev->dev_ops = &secondary_dev_ops;
 		eth_dev->device = &dev->device;
 
 		/*
-- 
2.34.1

