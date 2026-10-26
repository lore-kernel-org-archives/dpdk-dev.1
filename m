Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB6A606A31D
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kNeXonke
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B06F9402A3;
	Mon, 26 Oct 2026 17:05:06 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
 by mails.dpdk.org (Postfix) with ESMTPS id E296D40275;
 Mon, 26 Oct 2026 17:05:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPOZ4QV6CbCmcvtqAGESlPddCL6RT/eqx8OV4z9E4oPpdr0Oog3mFjLydAF461hPTG2NTGwcnPfGqwPkQqx2zxFl4xiOliSmeUFKB4ygbNi1vfkqyzwUBG2EUWCTyxkGecR09G9n3hB53VCbeLhLg/6kcdfP0s/GQSwJstr7t6OGsu6p75xIhgJkfCghrPOMSxqOj2fhvawKYcxtOoTIdp6GpxkxeinX6XcVJYOoagcNqocmtybR6o84fZegqwzG7fKHCsZuwkLgeoYxYl+f9yRN8SetbDeUUCCS2hOqpptaReb9qC2NelFwq3JVGbHAHqGOqd5ff4uGBBM/in1j2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c925pI8YWk7RqJ7i1wGqjd3SAmtWzoHOjWGXTs3+DIQ=;
 b=tbyqDbYi+8DAFj80VOJ4UPnCqqZUhUhl5NOq9MriL7M+AjrI1zHF6w1R5LRw2qRBYmXR7OBv96Pr+Ly7s0BJznMxii1eCgINsJfschfPH19mFBT4ckAL21EMkz9fD+B0/XVy1EQy1WC7tQMUqMQKhElJqgd0ocvxXVBv2kRmlbuGRVK3czYLcMulCCW8KGQLIjzU/FbiZcTTgAd9Nb44PSXNjRkhwALNIzYWve3nutbwfLdpWLVhma38jTe8b7NLLUM+qE2KAbVmykF8e9VHNGjUT5br5vLzs/Lc+CnWPopzkKqR2tntgOP6q/E6ZVQHgv3lKIgnDqxJM1GqI1RPsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c925pI8YWk7RqJ7i1wGqjd3SAmtWzoHOjWGXTs3+DIQ=;
 b=kNeXonkeIQh9r63t9g8SdWOys+Nr021CMMA5fvm5a/XfZcJ13No2zZrxPOyMtlYHXMO1txtnO5JU+Q/cJWobmvMWnnDp5ZXHn00Ixbxcpe2xYpDh5c1SSI14fpEuBtHBjD7bY10PRfRSBYKO63AVt+zWw4/xkCWtxjU4+W8HLxp5ueSOdB1opK2FUymZ0RlxsVkWCMJ0P41MlpkNkONl0MdqaYc8VwOb5wkyCP2G6lGY/+/FDZ9XlgqmuhcKdLJWhu6ajRINvZ9ukn0S6r1xbN8VoFgNvJgipSlYEUbeb6qrjKDmjk2Uj85PQJ63Ul4Dul7CtIRQoHyCR66RWIVEgA==
Received: from BN1PR14CA0020.namprd14.prod.outlook.com (2603:10b6:408:e3::25)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Mon, 26 Oct
 2026 16:04:44 +0000
Received: from BN3PEPF00022BCE.namprd03.prod.outlook.com
 (2603:10b6:408:e3:cafe::7f) by BN1PR14CA0020.outlook.office365.com
 (2603:10b6:408:e3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 16:04:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF00022BCE.mail.protection.outlook.com (10.167.248.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 16:04:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:04:15 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:04:12 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Thomas Monjalon <thomas@monjalon.net>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH] net/mlx5: move to polling for LSC interrupts
Date: Mon, 26 Oct 2026 17:04:00 +0100
Message-ID: <20261026160400.1290443-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCE:EE_|SA0PR12MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2a846e-ded4-4768-f36c-08df337ad9d4
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|261026140227099003|260925021911599003|260925022911599003|260925021311599003|56012099006|11063799006|261022075727099003|261021123027099003|261022105027099003|261021135927099003|261021121427099003|261022113327099003|261009223027099003|10067099003|261026121527099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: xnSVrQIhVN3y6p+Dxwc/rI9ZVA5jlt13+2sho1natWXNBfo10HAiwmiqTKG9fbmoXjIZmWgZvUrCGOHDdgPfwSveD+3KQOWS6t5OrULNawv3uy5ir3PQ+Y8q98wkYNY0zMSOlyudsnsw08vQzuzqG09Zzk7C0N8r9AZuSGFYa6PfFUmzUscmBc1l/F8V8BjTTl94qqBIPVJMRS8gKn9CA0pomst7s9uv+8fyAxhbGNXteLZUhnavSo+Sc6EJ2268XioOv03BnrLnvsc3s5ks0Srt6sas2JEAqlVe3uVl1IFymWJK0Df7mqS7MOA1Sa5Lsm/As9OOxJQaesnsxyPhlndhriZjpB4eOXKHqBcPnBzwUf1ZkAJSdCQzWr4ccobrV626IR2tOQOh5bV3QRDDPP4H00K8xxGaQLdqaf2nFdLRPHhXEmZF87SIwg56hOZr/1LyLnx6NOElJTvfJPmakeTH5DwuNa2VRHAH+Fb00465YuWTdzbbVLEEdkAXkPLFKM1AaIZLBIUrmtxemMLU6/VfEwFetivixAIPnCRDIdsjNE6ifGWa2HsHhKyJwdCLhB+wRyUbRn3yquNDuXdJ0XPmINOl8iPaY42iN95QeDpVM2jFJa6Y6Hn84dJdMzUNoNc7o6l1mFDvjRXlw4sTVY4upgoHZTZ7AjiJR1YOnSC4z6eUndvTJTxs3JBIMlarFYo4gYtInuuHlS6wUv3E7w==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(261026140227099003)(260925021911599003)(260925022911599003)(260925021311599003)(56012099006)(11063799006)(261022075727099003)(261021123027099003)(261022105027099003)(261021135927099003)(261021121427099003)(261022113327099003)(261009223027099003)(10067099003)(261026121527099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6DyN0YouuzerZd4wIxqnxyqahPr/9B6l/1DnZrmBmxPXerIxsnP37LiWkojzgb1AzpF8wTHPEW87ARd+G8SmmDBevkhr596hD2yTfQkHRd1GYgML0MZVKS5pj8xYrJILlxGzbJ1ngOIL1SEO/AwSpSAeUD34nZKNhOoc+0aEc8Py5W/2pa32wA1bUsILWFnaAlUQlkQg6uvp2JJ/gt2kit97KA2Ufxv1RK2l6vLq9x+YokoL8YMPYbvDhV8uMRqZ2wdfCXga7NCqQkErKC5HCt3paK51GoVi3mUyRlXT4opVVTdhWbJytYYY0R4bp4h6ozOZYqoXvi378ian8nY++5CEefpng7Zb++MmugFCEn3sE4w4ZcKBaO/hyfaxAnq0VT1MTa0oiO8hIAAh/cHPpU5W/zqQvcxGT/ROMOPhBI8o1lMS9v8sh5T7azh7Fr9F
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:04:44.1732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2a846e-ded4-4768-f36c-08df337ad9d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BCE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mlx5 networking driver on Linux implemented LSC interrupts
by listening on netlink events.
This method is unfortunately not reliable enough,
because of linkwatch mechanism. It can delay link up/down events
for up to ~1 second. This introduces unnecessary delay
when mlx5 ports are used with DPDK bonding driver for examples.

This patch addresses that by migrating LSC checks
to polling on link status using ETHTOOL_GLINK command.
This ethtool command, implemented by mlx5 since kernel 4.14,
will always get the current link status.
As a side effect it is also flushes the pending link watch events.

Fixes: 17f95513adca ("net/mlx5: fix link status change detection")
Cc: dmitry.kozliuk@gmail.com
Cc: stable@dpdk.org

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 .mailmap                                 |   1 +
 drivers/common/mlx5/linux/mlx5_nl.c      |  29 ---
 drivers/common/mlx5/linux/mlx5_nl.h      |   2 -
 drivers/net/mlx5/linux/meson.build       |   1 +
 drivers/net/mlx5/linux/mlx5_ethdev_os.c  | 147 ++++-------
 drivers/net/mlx5/linux/mlx5_lsc_intr.c   | 302 +++++++++++++++++++++++
 drivers/net/mlx5/linux/mlx5_os.c         |  22 --
 drivers/net/mlx5/mlx5.c                  |   7 -
 drivers/net/mlx5/mlx5.h                  |   4 +-
 drivers/net/mlx5/mlx5_lsc_intr.h         |  15 ++
 drivers/net/mlx5/mlx5_trigger.c          |  19 +-
 drivers/net/mlx5/windows/meson.build     |   1 +
 drivers/net/mlx5/windows/mlx5_lsc_intr.c |  24 ++
 13 files changed, 398 insertions(+), 176 deletions(-)
 create mode 100644 drivers/net/mlx5/linux/mlx5_lsc_intr.c
 create mode 100644 drivers/net/mlx5/mlx5_lsc_intr.h
 create mode 100644 drivers/net/mlx5/windows/mlx5_lsc_intr.c

diff --git a/.mailmap b/.mailmap
index 6d9e262cfb..ba580bdd1c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -315,6 +315,7 @@ Congjie Zhou <zcjie0802@qq.com>
 Congwen Zhang <zhang.congwen@zte.com.cn>
 Conor Fogarty <conor.fogarty@intel.com>
 Conor Walsh <conor.walsh@intel.com>
+Cosmin Ratiu <cratiu@nvidia.com>
 Cristian Bidea <cristian.bidea@keysight.com>
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
 Cristian Sovaiala <cristian.sovaiala@nxp.com>
diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index 3fabcfaee0..cc33a9231f 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -1994,35 +1994,6 @@ mlx5_nl_enable_roce_set(int nlsk_fd, int family_id, const char *pci_addr,
 	return mlx5_nl_driver_reload(nlsk_fd, family_id, pci_addr);
 }
 
-/**
- * Try to parse a Netlink message as a link status update.
- *
- * @param hdr
- *  Netlink message header.
- * @param[out] ifindex
- *  Index of the updated interface.
- *
- * @return
- *  0 on success, negative on failure.
- */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_parse_link_status_update)
-int
-mlx5_nl_parse_link_status_update(struct nlmsghdr *hdr, uint32_t *ifindex)
-{
-	struct ifinfomsg *info;
-
-	switch (hdr->nlmsg_type) {
-	case RTM_NEWLINK:
-	case RTM_DELLINK:
-	case RTM_GETLINK:
-	case RTM_SETLINK:
-		info = NLMSG_DATA(hdr);
-		*ifindex = info->ifi_index;
-		return 0;
-	}
-	return -1;
-}
-
 /**
  * Read pending events from a Netlink socket.
  *
diff --git a/drivers/common/mlx5/linux/mlx5_nl.h b/drivers/common/mlx5/linux/mlx5_nl.h
index 07a3b531b5..d1c0c92e1e 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.h
+++ b/drivers/common/mlx5/linux/mlx5_nl.h
@@ -102,8 +102,6 @@ int mlx5_nl_enable_roce_set(int nlsk_fd, int family_id, const char *pci_addr,
 
 __rte_internal
 int mlx5_nl_read_events(int nlsk_fd, mlx5_nl_event_cb *cb, void *cb_arg);
-__rte_internal
-int mlx5_nl_parse_link_status_update(struct nlmsghdr *hdr, uint32_t *ifindex);
 
 __rte_internal
 int mlx5_nl_devlink_esw_multiport_get(int nlsk_fd, int family_id,
diff --git a/drivers/net/mlx5/linux/meson.build b/drivers/net/mlx5/linux/meson.build
index e45ea988db..9fdb1555a6 100644
--- a/drivers/net/mlx5/linux/meson.build
+++ b/drivers/net/mlx5/linux/meson.build
@@ -10,6 +10,7 @@ sources += files(
         'mlx5_mp_os.c',
         'mlx5_vlan_os.c',
         'mlx5_flow_os.c',
+        'mlx5_lsc_intr.c',
 )
 
 cflags += no_wvla_cflag
diff --git a/drivers/net/mlx5/linux/mlx5_ethdev_os.c b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
index f6394ebd19..d6103896f5 100644
--- a/drivers/net/mlx5/linux/mlx5_ethdev_os.c
+++ b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
@@ -317,6 +317,40 @@ mlx5_find_master_dev(struct rte_eth_dev *dev)
 	return NULL;
 }
 
+/**
+ * Retrieve the carrier state of a device.
+ *
+ * The IFF_RUNNING flag reported by SIOCGIFFLAGS reflects the RFC 2863
+ * operational state, which the kernel only refreshes from its link watch
+ * work queue and which may therefore lag the actual carrier by up to a
+ * second. ETHTOOL_GLINK reports the carrier directly, and additionally
+ * flushes any link watch event still pending for the device.
+ *
+ * @param dev
+ *   Pointer to Ethernet device structure.
+ *
+ * @return
+ *   1 if the carrier is up, 0 otherwise.
+ *   Negative errno value is returned on error.
+ */
+int
+mlx5_link_carrier_get(struct rte_eth_dev *dev)
+{
+	struct ethtool_value ecmd = {
+		.cmd = ETHTOOL_GLINK,
+	};
+	struct ifreq ifr;
+	int ret;
+
+	memset(&ifr, 0, sizeof(ifr));
+	ifr.ifr_data = (void *)&ecmd;
+	ret = mlx5_ifreq(dev, SIOCETHTOOL, &ifr);
+	if (ret != 0)
+		return ret;
+
+	return !!ecmd.data;
+}
+
 /**
  * DPDK callback to retrieve physical link information.
  *
@@ -347,9 +381,11 @@ mlx5_link_update_unlocked_gset(struct rte_eth_dev *dev,
 			dev->data->port_id, strerror(rte_errno));
 		return ret;
 	}
+	ret = mlx5_link_carrier_get(dev);
+	if (ret < 0)
+		return ret;
 	dev_link = (struct rte_eth_link) {
-		.link_status = ((ifr.ifr_flags & IFF_UP) &&
-				(ifr.ifr_flags & IFF_RUNNING)),
+		.link_status = ((ifr.ifr_flags & IFF_UP) && ret),
 	};
 	ifr = (struct ifreq) {
 		.ifr_data = (void *)&edata,
@@ -428,9 +464,11 @@ mlx5_link_update_unlocked_gs(struct rte_eth_dev *dev,
 			dev->data->port_id, strerror(rte_errno));
 		return ret;
 	}
+	ret = mlx5_link_carrier_get(dev);
+	if (ret < 0)
+		return ret;
 	dev_link = (struct rte_eth_link) {
-		.link_status = ((ifr.ifr_flags & IFF_UP) &&
-				(ifr.ifr_flags & IFF_RUNNING)),
+		.link_status = ((ifr.ifr_flags & IFF_UP) && ret),
 	};
 	ifr = (struct ifreq) {
 		.ifr_data = (void *)&gcmd,
@@ -537,10 +575,7 @@ mlx5_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 			return ret;
 		}
 	} while (wait_to_complete || retry-- > 0);
-	ret = !!memcmp(&dev->data->dev_link, &dev_link,
-		       sizeof(struct rte_eth_link));
-	dev->data->dev_link = dev_link;
-	return ret;
+	return rte_eth_linkstatus_set(dev, &dev_link) == 0;
 }
 
 /**
@@ -663,102 +698,6 @@ mlx5_dev_interrupt_device_fatal(struct mlx5_dev_ctx_shared *sh)
 	}
 }
 
-static bool
-mlx5_dev_nl_ifindex_verify(uint32_t if_index, struct mlx5_priv *priv)
-{
-	struct mlx5_bond_info *bond = &priv->sh->bond;
-	int i;
-
-	if (bond->n_port == 0)
-		return (if_index == priv->if_index);
-
-	if (if_index == bond->ifindex)
-		return true;
-	for (i = 0; i < MLX5_BOND_MAX_PORTS; i++) {
-		if (!strlen(priv->sh->bond.ports[i].ifname))
-			continue;
-		if (if_index == bond->ports[i].ifindex)
-			return true;
-	}
-
-	return false;
-}
-
-static void
-mlx5_link_update_bond(struct rte_eth_dev *dev)
-{
-	struct mlx5_priv *priv = dev->data->dev_private;
-	struct mlx5_bond_info *bond = &priv->sh->bond;
-	struct ifreq ifr = (struct ifreq) {
-		.ifr_flags = 0,
-	};
-	int ret;
-
-	ret = mlx5_ifreq_by_ifname(bond->ifname, SIOCGIFFLAGS, &ifr);
-	if (ret) {
-		DRV_LOG(WARNING, "ifname %s ioctl(SIOCGIFFLAGS) failed: %s",
-			bond->ifname, strerror(rte_errno));
-		return;
-	}
-	dev->data->dev_link.link_status =
-		((ifr.ifr_flags & IFF_UP) && (ifr.ifr_flags & IFF_RUNNING));
-}
-
-static void
-mlx5_dev_interrupt_nl_cb(struct nlmsghdr *hdr, void *cb_arg)
-{
-	struct mlx5_dev_ctx_shared *sh = cb_arg;
-	uint32_t i;
-	uint32_t if_index;
-
-	if (mlx5_nl_parse_link_status_update(hdr, &if_index) < 0)
-		return;
-
-	for (i = 0; i < sh->max_port; i++) {
-		struct mlx5_dev_shared_port *port = &sh->port[i];
-		struct rte_eth_dev *dev;
-		struct mlx5_priv *priv;
-
-		if (port->nl_ih_port_id >= RTE_MAX_ETHPORTS)
-			continue;
-		dev = &rte_eth_devices[port->nl_ih_port_id];
-		/* Probing may initiate an LSC before configuration is done. */
-		if (dev->data->dev_configured &&
-		    !dev->data->dev_conf.intr_conf.lsc)
-			break;
-		priv = dev->data->dev_private;
-		if (mlx5_dev_nl_ifindex_verify(if_index, priv)) {
-			/* Block logical LSC events. */
-			uint16_t prev_status = dev->data->dev_link.link_status;
-
-			if (mlx5_link_update(dev, 0) < 0) {
-				DRV_LOG(ERR, "Failed to update link status: %s",
-					rte_strerror(rte_errno));
-			} else {
-				if (priv->sh->bond.n_port)
-					mlx5_link_update_bond(dev);
-				if (prev_status != dev->data->dev_link.link_status)
-					rte_eth_dev_callback_process
-						(dev, RTE_ETH_EVENT_INTR_LSC, NULL);
-			}
-			break;
-		}
-	}
-}
-
-void
-mlx5_dev_interrupt_handler_nl(void *arg)
-{
-	struct mlx5_dev_ctx_shared *sh = arg;
-	int nlsk_fd = rte_intr_fd_get(sh->intr_handle_nl);
-
-	if (nlsk_fd < 0)
-		return;
-	if (mlx5_nl_read_events(nlsk_fd, mlx5_dev_interrupt_nl_cb, sh) < 0)
-		DRV_LOG(ERR, "Failed to process Netlink events: %s",
-			rte_strerror(rte_errno));
-}
-
 /**
  * Handle shared asynchronous events the NIC (removal event
  * and link status change). Supports multiport IB device.
diff --git a/drivers/net/mlx5/linux/mlx5_lsc_intr.c b/drivers/net/mlx5/linux/mlx5_lsc_intr.c
new file mode 100644
index 0000000000..2fb3b9adfc
--- /dev/null
+++ b/drivers/net/mlx5/linux/mlx5_lsc_intr.c
@@ -0,0 +1,302 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 NVIDIA Corporation & Affiliates
+ */
+
+#include <stdint.h>
+#include <time.h>
+
+#include <ethdev_driver.h>
+#include <rte_alarm.h>
+#include <rte_bitset.h>
+#include <rte_interrupts.h>
+#include <rte_pause.h>
+#include <rte_spinlock.h>
+#include <rte_stdatomic.h>
+
+#include "mlx5.h"
+#include "mlx5_lsc_intr.h"
+#include "mlx5_utils.h"
+
+#define LINK_POLL_DEFAULT_PERIOD_US (UINT64_C(100) * 1000)
+#define LINK_POLL_MINIMUM_PERIOD_US LINK_POLL_DEFAULT_PERIOD_US
+#define LINK_POLL_MAXIMUM_PERIOD_US (UINT64_C(800) * 1000)
+
+#define POLLED_PORTS_MAX (RTE_MAX_ETHPORTS)
+
+struct mlx5_lsc_intr_ctx {
+	RTE_BITSET_DECLARE(polled_ports, POLLED_PORTS_MAX);
+	uint64_t period_us;
+	bool armed;
+	rte_spinlock_t lock;
+	RTE_ATOMIC(bool) cb_in_progress;
+};
+
+static struct mlx5_lsc_intr_ctx lsc_intr_ctx = {
+	.period_us = LINK_POLL_DEFAULT_PERIOD_US,
+	.lock = RTE_SPINLOCK_INITIALIZER,
+};
+
+static inline bool
+lsc_intr_cb_in_progress(struct mlx5_lsc_intr_ctx *ctx)
+{
+	return rte_atomic_load_explicit(&ctx->cb_in_progress, rte_memory_order_seq_cst);
+}
+
+static inline void
+lsc_intr_cb_set_in_progress(struct mlx5_lsc_intr_ctx *ctx, bool val)
+{
+	rte_atomic_store_explicit(&ctx->cb_in_progress, val, rte_memory_order_seq_cst);
+}
+
+static struct timespec
+timespec_sub(const struct timespec *t0, const struct timespec *t1)
+{
+	struct timespec ts;
+
+	ts.tv_sec = t0->tv_sec - t1->tv_sec;
+	ts.tv_nsec = t0->tv_nsec - t1->tv_nsec;
+	if (ts.tv_nsec < 0) {
+		ts.tv_sec--;
+		ts.tv_nsec += 1000000000L;
+	}
+	return ts;
+}
+
+static uint64_t
+adjust_period_and_calc_delay(struct mlx5_lsc_intr_ctx *ctx,
+			     struct timespec *after,
+			     struct timespec *before)
+{
+	struct timespec delta = timespec_sub(after, before);
+	uint64_t new_period;
+	uint64_t delta_us;
+
+	delta_us = delta.tv_sec * 1000000;
+	delta_us += delta.tv_nsec / 1000;
+
+	new_period = ctx->period_us;
+
+	if (delta_us > new_period / 2) {
+		/* If takes too long, adjust period up. */
+		while (new_period < LINK_POLL_MAXIMUM_PERIOD_US && delta_us > new_period / 2)
+			new_period = RTE_MIN(new_period * 2, LINK_POLL_MAXIMUM_PERIOD_US);
+	} else if (delta_us < new_period / 4) {
+		/* If polling is fast, adjust period down. */
+		while (new_period > LINK_POLL_MINIMUM_PERIOD_US && delta_us < new_period / 4)
+			new_period = RTE_MAX(new_period / 2, LINK_POLL_MINIMUM_PERIOD_US);
+	}
+
+	if (new_period != ctx->period_us) {
+		DRV_LOG(DEBUG, "adjusting link polling period: %" PRIu64 " us to %" PRIu64 " us",
+			ctx->period_us, new_period);
+		ctx->period_us = new_period;
+	}
+
+	if (ctx->period_us == LINK_POLL_MAXIMUM_PERIOD_US) {
+		/*
+		 * If at maximum period and querying link still takes too long, then default to
+		 * half of the maximum period so other interrupt thread users are not starved.
+		 */
+		if (delta_us > ctx->period_us / 2)
+			return LINK_POLL_MAXIMUM_PERIOD_US / 2;
+	}
+
+	MLX5_ASSERT(delta_us <= ctx->period_us / 2);
+	return ctx->period_us - delta_us;
+}
+
+static void
+lsc_intr_disarm(struct mlx5_lsc_intr_ctx *ctx)
+{
+	rte_spinlock_lock(&ctx->lock);
+	ctx->armed = false;
+	rte_spinlock_unlock(&ctx->lock);
+}
+
+static bool
+lsc_intr_dev_add(struct mlx5_lsc_intr_ctx *ctx, struct rte_eth_dev *dev)
+{
+	uint16_t port_id = dev->data->port_id;
+	bool schedule = false;
+
+	rte_spinlock_lock(&ctx->lock);
+	rte_bitset_set(ctx->polled_ports, port_id);
+	if (!ctx->armed) {
+		ctx->armed = true;
+		schedule = true;
+	}
+	rte_spinlock_unlock(&ctx->lock);
+
+	return schedule;
+}
+
+static void
+lsc_intr_dev_remove(struct mlx5_lsc_intr_ctx *ctx, struct rte_eth_dev *dev, bool disarm)
+{
+	rte_spinlock_lock(&ctx->lock);
+	rte_bitset_clear(ctx->polled_ports, dev->data->port_id);
+	if (disarm)
+		ctx->armed = false;
+	rte_spinlock_unlock(&ctx->lock);
+}
+
+static int
+lsc_intr_gather_devs(struct mlx5_lsc_intr_ctx *ctx,
+		     struct rte_eth_dev *out[POLLED_PORTS_MAX])
+{
+	ssize_t port_id;
+	int ret = 0;
+
+	rte_spinlock_lock(&ctx->lock);
+	RTE_BITSET_FOREACH_SET(port_id, ctx->polled_ports, POLLED_PORTS_MAX) {
+		out[ret++] = &rte_eth_devices[port_id];
+	}
+	rte_spinlock_unlock(&ctx->lock);
+
+	return ret;
+}
+
+static void
+lsc_intr_check_links(struct rte_eth_dev **devs, int devs_nb)
+{
+	for (int i = 0; i < devs_nb; ++i) {
+		struct rte_eth_dev *dev = devs[i];
+		struct rte_eth_link dev_link;
+		int ret;
+
+		ret = mlx5_link_carrier_get(dev);
+		if (ret < 0) {
+			devs[i] = NULL;
+			continue;
+		}
+
+		dev_link = dev->data->dev_link;
+		if (dev_link.link_status == ret) {
+			devs[i] = NULL;
+			continue;
+		}
+		dev_link.link_status = ret;
+		dev->data->dev_link = dev_link;
+	}
+}
+
+static void
+lsc_intr_notify(struct rte_eth_dev **devs, int devs_nb)
+{
+	for (int i = 0; i < devs_nb; ++i) {
+		if (devs[i] == NULL)
+			continue;
+
+		rte_eth_dev_callback_process(devs[i], RTE_ETH_EVENT_INTR_LSC, NULL);
+	}
+}
+
+static bool
+lsc_intr_should_reschedule(struct mlx5_lsc_intr_ctx *ctx)
+{
+	bool should;
+
+	rte_spinlock_lock(&ctx->lock);
+	should = rte_bitset_count_set(ctx->polled_ports, POLLED_PORTS_MAX) > 0;
+	if (!should)
+		ctx->armed = false;
+	rte_spinlock_unlock(&ctx->lock);
+
+	return should;
+}
+
+static bool
+lsc_intr_cb(struct mlx5_lsc_intr_ctx *ctx, uint64_t *delay_us)
+{
+	static struct rte_eth_dev *to_process[POLLED_PORTS_MAX];
+	struct timespec before;
+	struct timespec after;
+	int to_process_nb = 0;
+	bool have_time = true;
+
+	if (clock_gettime(CLOCK_MONOTONIC, &before) < 0)
+		have_time = false;
+
+	to_process_nb = lsc_intr_gather_devs(ctx, to_process);
+	if (to_process_nb == 0)
+		return lsc_intr_should_reschedule(ctx);
+
+	lsc_intr_check_links(to_process, to_process_nb);
+	lsc_intr_notify(to_process, to_process_nb);
+
+	if (clock_gettime(CLOCK_MONOTONIC, &after) < 0)
+		have_time = false;
+
+	if (have_time) {
+		*delay_us = adjust_period_and_calc_delay(ctx, &after, &before);
+	} else {
+		DRV_LOG(WARNING, "link polling callback failed to calculate polling time");
+		*delay_us = ctx->period_us;
+	}
+
+	return lsc_intr_should_reschedule(ctx);
+}
+
+static void
+mlx5_lsc_intr_cb(void *arg)
+{
+	struct mlx5_lsc_intr_ctx *ctx = arg;
+	uint64_t delay_us = ctx->period_us;
+	bool reschedule;
+	int ret;
+
+	lsc_intr_cb_set_in_progress(ctx, true);
+	reschedule = lsc_intr_cb(ctx, &delay_us);
+	lsc_intr_cb_set_in_progress(ctx, false);
+
+	/* Reschedule the polling */
+	if (reschedule) {
+		ret = rte_eal_alarm_set(delay_us, mlx5_lsc_intr_cb, ctx);
+		if (ret < 0) {
+			DRV_LOG(ERR, "rescheduling link polling callback failed (%s)",
+				rte_strerror(-ret));
+			lsc_intr_disarm(ctx);
+		}
+	}
+}
+
+int
+mlx5_lsc_intr_setup(struct rte_eth_dev *dev)
+{
+	struct mlx5_lsc_intr_ctx *ctx = &lsc_intr_ctx;
+	bool schedule;
+	int ret;
+
+	schedule = lsc_intr_dev_add(ctx, dev);
+	if (!schedule)
+		return 0;
+
+	ret = rte_eal_alarm_set(ctx->period_us, mlx5_lsc_intr_cb, ctx);
+	if (ret < 0) {
+		DRV_LOG(ERR, "port %u registering link polling callback failed (%s)",
+			dev->data->port_id, rte_strerror(-ret));
+		lsc_intr_dev_remove(ctx, dev, true);
+		return ret;
+	}
+	DRV_LOG(DEBUG, "registered link polling callback");
+
+	return 0;
+}
+
+void
+mlx5_lsc_intr_cleanup(struct rte_eth_dev *dev)
+{
+	struct mlx5_lsc_intr_ctx *ctx = &lsc_intr_ctx;
+
+	lsc_intr_dev_remove(ctx, dev, false);
+
+	/*
+	 * If callback is running, then wait until it finishes to prevent
+	 * freeing dev while it is running.
+	 *
+	 * mlx5_lsc_intr_cb will be called only from interrupt thread.
+	 * If cleanup was called from the callback, then no need to wait.
+	 */
+	while (lsc_intr_cb_in_progress(ctx) && !rte_thread_is_intr())
+		rte_pause();
+}
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 7c2c35c945..08dd2b46d9 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1803,8 +1803,6 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 		eth_dev->data->port_id);
 	/* Read link status in case it is up and there will be no event. */
 	mlx5_link_update(eth_dev, 0);
-	/* Watch LSC interrupts between port probe and port start. */
-	priv->sh->port[priv->dev_port - 1].nl_ih_port_id = eth_dev->data->port_id;
 	mlx5_set_link_up(eth_dev);
 	for (i = 0; i < MLX5_FLOW_TYPE_MAXI; i++) {
 		icfg[i].release_mem_en = !!sh->config.reclaim_mode;
@@ -1956,8 +1954,6 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	return eth_dev;
 error:
 	if (priv) {
-		priv->sh->port[priv->dev_port - 1].nl_ih_port_id =
-							       RTE_MAX_ETHPORTS;
 		rte_io_wmb();
 #ifdef HAVE_MLX5_HWS_SUPPORT
 		if (eth_dev &&
@@ -3262,19 +3258,6 @@ mlx5_os_dev_shared_handler_install(struct mlx5_dev_ctx_shared *sh)
 			}
 		}
 	}
-	nlsk_fd = mlx5_nl_init(NETLINK_ROUTE, RTMGRP_LINK);
-	if (nlsk_fd < 0) {
-		DRV_LOG(ERR, "Failed to create a socket for Netlink events: %s",
-			rte_strerror(rte_errno));
-		return;
-	}
-	sh->intr_handle_nl = mlx5_os_interrupt_handler_create
-		(RTE_INTR_INSTANCE_F_SHARED, true,
-		 nlsk_fd, mlx5_dev_interrupt_handler_nl, sh);
-	if (sh->intr_handle_nl == NULL) {
-		DRV_LOG(ERR, "Fail to allocate intr_handle");
-		return;
-	}
 	if (sh->cdev->config.devx) {
 #ifdef HAVE_IBV_DEVX_ASYNC
 		struct mlx5dv_devx_cmd_comp *devx_comp;
@@ -3312,11 +3295,6 @@ mlx5_os_dev_shared_handler_uninstall(struct mlx5_dev_ctx_shared *sh)
 
 	mlx5_os_interrupt_handler_destroy(sh->intr_handle,
 					  mlx5_dev_interrupt_handler, sh);
-	fd = rte_intr_fd_get(sh->intr_handle_nl);
-	mlx5_os_interrupt_handler_destroy(sh->intr_handle_nl,
-					  mlx5_dev_interrupt_handler_nl, sh);
-	if (fd >= 0)
-		close(fd);
 #ifdef HAVE_IBV_DEVX_ASYNC
 	mlx5_os_interrupt_handler_destroy(sh->intr_handle_devx,
 					  mlx5_dev_interrupt_handler_devx, sh);
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index a04884fb4b..2fdd17f08e 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -1930,7 +1930,6 @@ mlx5_alloc_shared_dev_ctx(const struct mlx5_dev_spawn_data *spawn,
 	for (i = 0; i < sh->max_port; i++) {
 		sh->port[i].ih_port_id = RTE_MAX_ETHPORTS;
 		sh->port[i].devx_ih_port_id = RTE_MAX_ETHPORTS;
-		sh->port[i].nl_ih_port_id = RTE_MAX_ETHPORTS;
 	}
 	if (sh->cdev->config.devx) {
 		sh->td = mlx5_devx_cmd_create_td(sh->cdev->ctx);
@@ -2559,12 +2558,6 @@ mlx5_dev_close(struct rte_eth_dev *dev)
 	mlx5_free(priv->mac);
 	dev->data->mac_addrs = NULL;
 	mlx5_free(priv->mac_own);
-	sh->port[priv->dev_port - 1].nl_ih_port_id = RTE_MAX_ETHPORTS;
-	/*
-	 * The interrupt handler port id must be reset before priv is reset
-	 * since 'mlx5_dev_interrupt_nl_cb' uses priv.
-	 */
-	rte_io_wmb();
 	/*
 	 * Free the shared context in last turn, because the cleanup
 	 * routines above may use some shared fields, like
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index e3df458915..51c789bf45 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -838,7 +838,6 @@ struct mlx5_age_info {
 struct mlx5_dev_shared_port {
 	uint32_t ih_port_id;
 	uint32_t devx_ih_port_id;
-	uint32_t nl_ih_port_id;
 	/*
 	 * Interrupt handler port_id. Used by shared interrupt
 	 * handler to find the corresponding rte_eth device
@@ -1649,7 +1648,6 @@ struct mlx5_dev_ctx_shared {
 	/* Shared interrupt handler section. */
 	struct rte_intr_handle *intr_handle; /* Interrupt handler for device. */
 	struct rte_intr_handle *intr_handle_devx; /* DEVX interrupt handler. */
-	struct rte_intr_handle *intr_handle_nl; /* Netlink interrupt handler. */
 	struct rte_intr_handle *intr_handle_ib; /* Interrupt handler for IB device. */
 	void *devx_comp; /* DEVX async comp obj. */
 	struct mlx5_devx_obj *tis[16]; /* TIS object. */
@@ -2382,13 +2380,13 @@ int mlx5_get_mtu(struct rte_eth_dev *dev, uint16_t *mtu);
 int mlx5_set_mtu(struct rte_eth_dev *dev, uint16_t mtu);
 int mlx5_read_clock(struct rte_eth_dev *dev, uint64_t *clock);
 int mlx5_link_update(struct rte_eth_dev *dev, int wait_to_complete);
+int mlx5_link_carrier_get(struct rte_eth_dev *dev);
 int mlx5_dev_get_flow_ctrl(struct rte_eth_dev *dev,
 			   struct rte_eth_fc_conf *fc_conf);
 int mlx5_dev_set_flow_ctrl(struct rte_eth_dev *dev,
 			   struct rte_eth_fc_conf *fc_conf);
 void mlx5_dev_interrupt_handler(void *arg);
 void mlx5_dev_interrupt_handler_devx(void *arg);
-void mlx5_dev_interrupt_handler_nl(void *arg);
 void mlx5_dev_interrupt_handler_ib(void *arg);
 int mlx5_set_link_down(struct rte_eth_dev *dev);
 int mlx5_set_link_up(struct rte_eth_dev *dev);
diff --git a/drivers/net/mlx5/mlx5_lsc_intr.h b/drivers/net/mlx5/mlx5_lsc_intr.h
new file mode 100644
index 0000000000..4e4a1eef5b
--- /dev/null
+++ b/drivers/net/mlx5/mlx5_lsc_intr.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 NVIDIA Corporation & Affiliates
+ */
+
+#ifndef RTE_PMD_MLX5_LSC_INTR_H_
+#define RTE_PMD_MLX5_LSC_INTR_H_
+
+#include <stdbool.h>
+
+struct rte_eth_dev;
+
+int mlx5_lsc_intr_setup(struct rte_eth_dev *dev);
+void mlx5_lsc_intr_cleanup(struct rte_eth_dev *dev);
+
+#endif /* RTE_PMD_MLX5_LSC_INTR_H_ */
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index c5f493117b..7c166fa687 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -18,6 +18,7 @@
 #include "mlx5_rx.h"
 #include "mlx5_tx.h"
 #include "mlx5_utils.h"
+#include "mlx5_lsc_intr.h"
 #include "rte_pmd_mlx5.h"
 
 static void mlx5_traffic_disable_legacy(struct rte_eth_dev *dev);
@@ -1507,6 +1508,14 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 	dev->rx_pkt_burst = mlx5_select_rx_function(dev);
 	/* Enable datapath on secondary process. */
 	mlx5_mp_os_req_start_rxtx(dev);
+	if (dev->data->dev_conf.intr_conf.lsc) {
+		ret = mlx5_lsc_intr_setup(dev);
+		if (ret < 0) {
+			DRV_LOG(INFO, "port %u failed configure LSC interrupts, starting without",
+				dev->data->port_id);
+			dev->data->dev_conf.intr_conf.lsc = 0;
+		}
+	}
 	if (rte_intr_fd_get(priv->sh->intr_handle) >= 0) {
 		priv->sh->port[priv->dev_port - 1].ih_port_id =
 					(uint32_t)dev->data->port_id;
@@ -1515,14 +1524,6 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 			dev->data->port_id);
 		dev->data->dev_conf.intr_conf.rmv = 0;
 	}
-	if (rte_intr_fd_get(priv->sh->intr_handle_nl) >= 0) {
-		priv->sh->port[priv->dev_port - 1].nl_ih_port_id =
-					(uint32_t)dev->data->port_id;
-	} else {
-		DRV_LOG(INFO, "port %u starts without LSC interrupts.",
-			dev->data->port_id);
-		dev->data->dev_conf.intr_conf.lsc = 0;
-	}
 	if (rte_intr_fd_get(priv->sh->intr_handle_devx) >= 0)
 		priv->sh->port[priv->dev_port - 1].devx_ih_port_id =
 					(uint32_t)dev->data->port_id;
@@ -1664,7 +1665,7 @@ mlx5_dev_stop(struct rte_eth_dev *dev)
 	mlx5_rx_intr_vec_disable(dev);
 	priv->sh->port[priv->dev_port - 1].ih_port_id = RTE_MAX_ETHPORTS;
 	priv->sh->port[priv->dev_port - 1].devx_ih_port_id = RTE_MAX_ETHPORTS;
-	priv->sh->port[priv->dev_port - 1].nl_ih_port_id = RTE_MAX_ETHPORTS;
+	mlx5_lsc_intr_cleanup(dev);
 	mlx5_txq_stop(dev);
 	mlx5_rxq_stop(dev);
 	mlx5_dev_free_consec_tx_mem(dev, true);
diff --git a/drivers/net/mlx5/windows/meson.build b/drivers/net/mlx5/windows/meson.build
index c7d6617275..73cdcc47ae 100644
--- a/drivers/net/mlx5/windows/meson.build
+++ b/drivers/net/mlx5/windows/meson.build
@@ -8,4 +8,5 @@ sources += files(
         'mlx5_ethdev_os.c',
         'mlx5_vlan_os.c',
         'mlx5_flow_os.c',
+        'mlx5_lsc_intr.c',
 )
diff --git a/drivers/net/mlx5/windows/mlx5_lsc_intr.c b/drivers/net/mlx5/windows/mlx5_lsc_intr.c
new file mode 100644
index 0000000000..eac5bfdac2
--- /dev/null
+++ b/drivers/net/mlx5/windows/mlx5_lsc_intr.c
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 NVIDIA Corporation & Affiliates
+ */
+
+#include <errno.h>
+#include <stdbool.h>
+
+#include <ethdev_driver.h>
+#include <rte_common.h>
+
+#include "mlx5_utils.h"
+#include "mlx5_lsc_intr.h"
+
+int
+mlx5_lsc_intr_setup(struct rte_eth_dev *dev)
+{
+	DRV_LOG(ERR, "port %u does not support LSC interrupts", dev->data->port_id);
+	return -ENOTSUP;
+}
+
+void
+mlx5_lsc_intr_cleanup(struct rte_eth_dev *dev __rte_unused)
+{
+}
-- 
2.43.0

