Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B24C61DD3
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 16:30:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B77540269;
	Mon, 31 Aug 2026 18:30:01 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012042.outbound.protection.outlook.com
 [40.93.195.42]) by mails.dpdk.org (Postfix) with ESMTP id 1AD444025A
 for <dev@dpdk.org>; Mon, 31 Aug 2026 18:29:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBzYeJlVb/BE+1msAKWbBNO0JK/gYdrER8tUuJ0ZCzG/1g39mATLHlQKwr6NarfqB8w8QxNkRqoDFbDizUmw48bBbpQKpJJffDUMxvMHo1Hf11OwnWmNWg6sbeZ//BxBzIN3/NyFZ8GhRbMUV/zOuVE4xLZ6mzRww70DmrYkJ8ElwmNdQTZ8bX1A+9zIkUPb25Sdw3woPNCOLN18lVXR4+2ONV+rVetfvSdZGPPKI+q+Pfy3hkt0IJeJq1jLyBjhzERJEcPMN10flTE8KCoMyM7FEgPhG+pLueMOhQ8Qqd6g8GiB/ifDTUQTkZ51J8wyiMfnl0srX3/4gwUtDgwfaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cs4RCdf5HNHKwhSSEX7ZRRgQISl7dGmMgpjAQZKD5BI=;
 b=LH5xspXtiOg1dcH7yuqNKfzMbjtQacBOZCCdCt2jwgfRN9RsnQNE3Dj8tM2BrjM1txXmJexENAieDeFamOfTshUiWb/ZAnZmp0hgiOJ1Xm8Q8rrcu07K6Mi3AcEHO5mFWwJMNpVBb9IOSdx5m9WKOxiJI5Rg3ZJRK3n0U7wjPrS5D4yrdBNKtM+lQmTiiFHL2fhRjVo+EJVPTT3Rvc0G2gyiVAkH0wOsa/idaZb213RtZh2mRJEmJf+Ple93+Ajl5FLz9b2bpYMhU1H+YbdIA5bg2m5OLDgETc6n30SyYCKB2o+iA4fKPcghT7fiqurm7ixDBmjEFjiTEd1Qn1eyYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oktetlabs.ru smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cs4RCdf5HNHKwhSSEX7ZRRgQISl7dGmMgpjAQZKD5BI=;
 b=RM1AGOGwRNWuhCt+82JE6LKYn5lh2xqJ7reBQAx81FE0akYqRuRc0RkhoWHVjpHP06zSD3oy8EtRgjOzF5gEjSzDgQ+Atc7BooAKgs27Bz0VU6+aWRaQbECec/WBu76KOKszcZ/Fd35CJgEINUOIXrJTi8tdLLRWHELk57+uweUANz02/vLK1fhsapyFgULe1jaCOqN5S5abse4Uf5dWGkuatbjC6oS6B6CAYz3PKbdE7zI0CXgbWVKkVOqEqBMMrQHBoaWAv9GUA/8JXIWzkQfCEetc0U5BdkJQPtcYwSs7DLVqbEYZgbhOET2e+ccKCkpSeWCpTxkio3eHDw1DNA==
Received: from SJ0PR03CA0374.namprd03.prod.outlook.com (2603:10b6:a03:3a1::19)
 by SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Mon, 31 Aug
 2026 16:29:46 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::66) by SJ0PR03CA0374.outlook.office365.com
 (2603:10b6:a03:3a1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 16:29:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 16:29:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 09:29:28 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 09:29:24 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>, Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: [RFC] ethdev: simplify representor info get API
Date: Mon, 31 Aug 2026 18:29:05 +0200
Message-ID: <20260831162905.383162-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|SJ2PR12MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: dda033b5-d834-4f10-0bee-08df077d113b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|56012099006|10067099003|6133799003|11063799006|18002099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info: DgbUwSZ7uFZts/7hViupTucjiQHT9sHtpE235qqVWNGStrMfO1WFCsfL2E8POS1bS/4ju65XnVAMR0HoBjvWuZkNSLkpGBmDQVgDQZ9UlODgheO8279VafJRXWLf5esI0x/kLViXJBebJNEF1usOLGVDVhOV/MsGvky1Ox+QeSwEWzUZiH1TqAICH/Og6mITtv+y0Sx4F8QmDvD29E+dQZTX8y0e8OaafBoYsXHGhla8x2KVIYPY18Ek59Ju6ODQsF8Z5eaI0bql+l966xBt1OTx0qqf6SRLcZH8b9W8jMFI4LweKDX3JFcxe4JcBkwIbsKdkzo/UwIZr5mZbWEHNXe4l1ZOJdJ+FtVihDA7LMDBzrpn/XZjYu0BPXbAAH8tfTu7cWkcIHoLsQkCeBomapx1zDloJVXwnEs+qrrVTOng8msdLSwnDBBTX6PFpvSkaAjKtvtmj+cIwW8y/vTCbcvbdBU4mcOzVEz3gtb3HJyOTrh+WLdMOodP8kI7/Kq//tgwRhUL6Qel5i0pEAZqdR76Vj/6Z/YclOqRNphBSJQdBGgaFS/dv3kfpcphDNVZo+lkTrKC1145ZjiMR6plOXJ2Q/2D9ophgNalY4Iudafl/IiEzGBcQo8vtvdKJGsiDC9hwwJRNF9c0Hu5KA6zkkSOU2YUjyGnDNq1ks6qLHAol47Ly0nWEgVvvLJtejR6TriAmDxsnVZvEMHT7VarHjpWRrh2qBK7cVloe9/fL3CdHKQ8FETC2McNQ50uQQnT
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(56012099006)(10067099003)(6133799003)(11063799006)(18002099003)(3023799007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I33P8jlCSmjxo5kQ4CqsPuHgVrHxXLtzTTVCvtpOf8qynia2QJZqJv9GJfgPEKHK+CE0mXJFcdNscPf03TB09JeAquFgMoe1RIIiixIX1BiWCaMwiyjCCV6xA6ibup4UXKNGhbFHy6h3bWGjiUPWsMzhnjm5ct+1G4T4cwWIJhSI/CPdetGzkbsJoacDXVPOfsW47Ksy7fbmHeuYK+tTqTRcQfDtDpRxq2gFL9cdheRKRsgdPoiabCYlQqAqfCr/DyV6xyaqUivv83lYto2nx4nfPwfk4iA639ipE7Uhf6NTyCYZ3Y/c5onfcmBmT4yPXU/uS9FAddk45ayPz2N+NwFuJQZtptXPq4Et84FAe+ou9vUuqdGeji9Gjy8JreQlEU7Bjx6hb7kUVA5tWfaz3Wc6A7DspAqOISW+t43ADmzRvEMh7sFO97UEKVbf21Or
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 16:29:45.1028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dda033b5-d834-4f10-0bee-08df077d113b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738
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

* Background on rte_eth_representor_info_get()

rte_eth_representor_info_get() experimental function was added
to ethdev public API in 21.05 DPDK release [1].

Its purpose is to provide representor IDs in form of ID ranges.
Driver can return the following example info:

	info = (struct rte_eth_representor_info){
		.controller = 0, /* Controller ID of caller device. */
		.pf = 0, /* Physical function ID of caller device. */
		.nb_ranges = 2,
		.ranges = {
			{
				.type = RTE_ETH_REPRESENTOR_VF,
				.controller = 0,
				.pf = 0,
				.vf = 0,
				.id_base = 100,
				.id_end = 199,
				.name = "pfvf"
			},
			{
				.type = RTE_ETH_REPRESENTOR_SF,
				.controller = 0,
				.pf = 0,
				.sf = 0,
				.id_base = 200,
				.id_end = 299,
				.name = "pfsf"
			},
		}
	};

This roughly means that, representors on PF 0 will have IDs:

- PF0VF0  -> ID == 100
- PF0VF1  -> ID == 101
- ...
- PF0VF99 -> ID == 199
- PF0SF0  -> ID == 200
- PF0SF1  -> ID == 201
- ...
- PF0SF99 -> ID == 299

All representors are related to controller with ID equal to 0.

Since the introduction, this API was implemented by 3 drivers:

- mlx5
- sfc
- cnxk

and resulting implementations suggest that some clean up is needed
to address the following issues.

** Issue #1: All drivers return degenerate ranges

All 3 drivers implementing rte_eth_representor_info_get() return
degenerate ranges i.e.:

- one struct rte_eth_representor_range is returned per representor
- each has id_base == id_end

Due to this, current range format seems to be an overkill.

** Issue #2: Representor ID is not directly usable by DPDK users

rte_eth_representor_info_get() is part of the public ethdev API.
Applications can, for example, use it to answer a question:

	What representor ID will have a representor of VF 3 on PF 0?

The problem is that applications have no clear way to correlate
an ethdev port with a representor ID.

Representor ID itself is stored in rte_eth_dev_data.representor_id,
but this field is not exposed to the user.
This field is used internally in ethdev to implement
iteration over matching representors. This is exposed to applications
through rte_eth_iterator and related macros.

Drivers implementing rte_eth_representor_info_get()
reuse the same representor ID in rte_eth_switch_info.port_id.
However whether these values should be treated the same way,
is not part of the API contract.

Regardless of that, representor ID alone does not bring any useful
information to the user.

* Proposal

To address the 2 issues above, I would like to propose simplification of
rte_eth_representor_info_get():

- Function should return information about
  what a given ethdev port represents:
    - representor type
    - PCI controller index
    - PF index
    - VF/SF index (for VF/SF type)
- Function will return information only for provided port.
- If driver does not provide representor_info_get() in its dev_ops,
  then ethdev library will handle it for the driver in the following way:

    # for representors
    type = RTE_ETH_REPRESENTOR_VF
    controller_valid = false
    PF_valid = false
    VF = dev_info.switch_info.port_id

    # for non-representors
    type = RTE_ETH_REPRESENTOR_NONE
    controller_valid = false
    PF_valid = false

  This behavior would be consistent with how
  rte_eth_representor_id_get() calculates representor_id for each driver.
- Otherwise, driver is responsible for filling representor info.

As a result rte_eth_representor_info_get() would be implemented
for all drivers.

Iteration over representors can be implemented
in terms of this new implementation by:

- iterating over ethdev ports with matching rte_device
- for ethdev ports which are representors
    - convert devargs to rte_eth_representor_info output
    - compare converted info with rte_eth_representor_info_get() output for port

Comparison mentioned above is provided by internal
rte_eth_representor_info_match() function provided in this RFC.

Changes in eth_representor_cmp() showcase rough algorithm of that new logic.

This change would also deprecate rte_eth_representor_id_get() internal function.

[1]: https://inbox.dpdk.org/dev/1615468416-10115-1-git-send-email-xuemingl@nvidia.com/

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 lib/ethdev/ethdev_driver.c | 89 ++++++++++++++++++++++++++++++++++++++
 lib/ethdev/ethdev_driver.h |  4 ++
 lib/ethdev/rte_class_eth.c | 35 ++++++++++-----
 lib/ethdev/rte_ethdev.c    | 32 ++++++++++++--
 lib/ethdev/rte_ethdev.h    | 47 +++++---------------
 5 files changed, 157 insertions(+), 50 deletions(-)

diff --git a/lib/ethdev/ethdev_driver.c b/lib/ethdev/ethdev_driver.c
index eab5c15d12..514c8fa29d 100644
--- a/lib/ethdev/ethdev_driver.c
+++ b/lib/ethdev/ethdev_driver.c
@@ -902,6 +902,95 @@ rte_eth_recycle_rx_descriptors_refill_dummy(void *queue __rte_unused,
 	/* No action. */
 }
 
+static bool controller_match(const struct rte_eth_representor_info *rep_info,
+			     const struct rte_eth_representor_info *backer_info,
+			     const struct rte_eth_representor_info *other)
+{
+	/* If device has controller, but devargs do not have one, then use backer's controller as default. */
+	if (rep_info->controller_valid && !other->controller_valid) {
+		if (rep_info->controller != backer_info->controller)
+			return false;
+	}
+
+	/* If devargs have controller, but device does not have one, then no way to compare. */
+	if (!rep_info->controller_valid && other->controller_valid)
+		return false;
+
+	/* If both device and devargs have controller, then they must match. */
+	if (rep_info->controller_valid && other->controller_valid && rep_info->controller != other->controller)
+		return false;
+
+	/* If both device and devargs do not have controller, then no need to compare. */
+
+	return true;
+}
+
+static bool pf_match(const struct rte_eth_representor_info *rep_info,
+			     const struct rte_eth_representor_info *backer_info,
+			     const struct rte_eth_representor_info *other)
+{
+	/* If device has pf, but devargs do not have one, then use backer's pf as default. */
+	if (rep_info->pf_valid && !other->pf_valid) {
+		if (rep_info->pf != backer_info->pf)
+			return false;
+	}
+
+	/* If devargs have pf, but device does not have one, then no way to compare. */
+	if (!rep_info->pf_valid && other->pf_valid)
+		return false;
+
+	/* If both device and devargs have pf, then they must match. */
+	if (rep_info->pf_valid && other->pf_valid && rep_info->pf != other->pf)
+		return false;
+
+	/* If both device and devargs do not have pf, then no need to compare. */
+
+	return true;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_representor_id_get)
+bool
+rte_eth_representor_info_match(const struct rte_eth_dev *dev, const struct rte_eth_representor_info *other)
+{
+	struct rte_eth_representor_info info;
+	struct rte_eth_representor_info backer_info;
+	int ret;
+
+	memset(&info, 0, sizeof(info));
+	memset(&backer_info, 0, sizeof(backer_info));
+
+	ret = rte_eth_representor_info_get(dev->data->port_id, &info);
+	if (ret < 0)
+		return false;
+	ret = rte_eth_representor_info_get(dev->data->backer_port_id, &backer_info);
+	if (ret < 0)
+		return false;
+
+	if (!controller_match(&info, &backer_info, other))
+		return false;
+
+	if (!pf_match(&info, &backer_info, other))
+		return false;
+
+	if (info.type != other->type)
+		return false;
+
+	switch (info.type) {
+	case RTE_ETH_REPRESENTOR_VF:
+		if (info.vf != other->vf)
+			return false;
+		break;
+	case RTE_ETH_REPRESENTOR_SF:
+		if (info.sf != other->sf)
+			return false;
+		break;
+	default:
+		break;
+	}
+
+	return true;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_representor_id_get)
 int
 rte_eth_representor_id_get(uint16_t port_id,
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 0f336f9567..349b8bbc71 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -2045,6 +2045,10 @@ struct rte_eth_devargs {
 	enum rte_eth_representor_type type; /* type of representor */
 };
 
+__rte_internal
+bool
+rte_eth_representor_info_match(const struct rte_eth_dev *dev, const struct rte_eth_representor_info *other);
+
 /**
  * PMD helper function to get representor ID from location detail.
  *
diff --git a/lib/ethdev/rte_class_eth.c b/lib/ethdev/rte_class_eth.c
index a8d01e2595..8235ac1d28 100644
--- a/lib/ethdev/rte_class_eth.c
+++ b/lib/ethdev/rte_class_eth.c
@@ -93,19 +93,34 @@ eth_representor_cmp(const char *key __rte_unused,
 
 	/* Return 0 if representor ID is matching one of the values. */
 	for (i = 0; i < nc * np * nf; ++i) {
+		struct rte_eth_representor_info info;
+
 		c = i / (np * nf);
 		p = (i / nf) % np;
 		f = i % nf;
-		if (rte_eth_representor_id_get(edev->data->backer_port_id,
-			eth_da.type,
-			eth_da.nb_mh_controllers == 0 ? -1 :
-					eth_da.mh_controllers[c],
-			eth_da.nb_ports == 0 ? -1 : eth_da.ports[p],
-			eth_da.nb_representor_ports == 0 ? -1 :
-					eth_da.representor_ports[f],
-			&id) < 0)
-			continue;
-		if (data->representor_id == id)
+
+		memset(&info, 0, sizeof(info));
+		info.type = eth_da.type;
+		if (eth_da.nb_mh_controllers > 0) {
+			info.controller = eth_da.mh_controllers[c];
+			info.controller_valid = true;
+		}
+		if (eth_da.nb_ports > 0) {
+			info.pf = eth_da.ports[p];
+			info.pf = true;
+		}
+		switch (info.type) {
+		case RTE_ETH_REPRESENTOR_VF:
+			info.vf = eth_da.representor_ports[f];
+			break;
+		case RTE_ETH_REPRESENTOR_SF:
+			info.sf = eth_da.representor_ports[f];
+			break;
+		default:
+			break;
+		}
+
+		if (rte_eth_representor_info_match(edev, &info))
 			return 0;
 	}
 	return -1; /* no match */
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 9efeaf77cb..5ec08810fd 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -7155,17 +7155,41 @@ rte_eth_representor_info_get(uint16_t port_id,
 			     struct rte_eth_representor_info *info)
 {
 	struct rte_eth_dev *dev;
-	int ret;
+	int ret = 0;
 
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 
-	if (dev->dev_ops->representor_info_get == NULL)
-		return -ENOTSUP;
+	if (info == NULL)
+		return -EINVAL;
+
+	if (dev->dev_ops->representor_info_get == NULL) {
+		if (!rte_eth_dev_is_repr(dev)) {
+			info->type = RTE_ETH_REPRESENTOR_NONE;
+		} else {
+			struct rte_eth_dev_info dev_info = {};
+
+			ret = rte_eth_dev_info_get(port_id, &dev_info);
+			if (ret != 0) {
+				RTE_ETHDEV_LOG_LINE(ERR, "rte_eth_dev_info_get() failed for port %u",
+						port_id);
+				goto finish;
+			}
+
+			info->type = RTE_ETH_REPRESENTOR_VF;
+			info->vf = dev_info.switch_info.port_id;
+		}
+
+		info->controller_valid = false;
+		info->pf_valid = false;
+
+		goto finish;
+	}
+
 	ret = eth_err(port_id, dev->dev_ops->representor_info_get(dev, info));
 
+finish:
 	rte_eth_trace_representor_info_get(port_id, info, ret);
-
 	return ret;
 }
 
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index ee400b386f..940b999c11 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -5785,58 +5785,33 @@ int rte_eth_dev_hairpin_capability_get(uint16_t port_id,
  * @warning
  * @b EXPERIMENTAL: this structure may change without prior notice.
  *
- * Ethernet device representor ID range entry
+ * Ethernet device representor information
  */
-struct rte_eth_representor_range {
-	enum rte_eth_representor_type type; /**< Representor type */
-	int controller; /**< Controller index */
-	int pf; /**< Physical function index */
+struct rte_eth_representor_info {
+	enum rte_eth_representor_type type;
+	uint32_t controller;
+	bool controller_valid;
+	uint32_t pf;
+	bool pf_valid;
 	__extension__
 	union {
-		int vf; /**< VF start index */
-		int sf; /**< SF start index */
+		uint32_t vf;
+		uint32_t sf;
 	};
-	uint32_t id_base; /**< Representor ID start index */
-	uint32_t id_end;  /**< Representor ID end index */
-	char name[RTE_DEV_NAME_MAX_LEN]; /**< Representor name */
-};
-
-/**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice.
- *
- * Ethernet device representor information
- */
-struct rte_eth_representor_info {
-	uint16_t controller; /**< Controller ID of caller device. */
-	uint16_t pf; /**< Physical function ID of caller device. */
-	uint32_t nb_ranges_alloc; /**< Size of the ranges array. */
-	uint32_t nb_ranges; /**< Number of initialized ranges. */
-	struct rte_eth_representor_range ranges[];/**< Representor ID range. */
 };
 
 /**
  * Retrieve the representor info of the device.
  *
- * Get device representor info to be able to calculate a unique
- * representor ID. @see rte_eth_representor_id_get helper.
- *
  * @param port_id
  *   The port identifier of the device.
  * @param info
  *   A pointer to a representor info structure.
- *   NULL to return number of range entries and allocate memory
- *   for next call to store detail.
- *   The number of ranges that were written into this structure
- *   will be placed into its nb_ranges field. This number cannot be
- *   larger than the nb_ranges_alloc that by the user before calling
- *   this function. It can be smaller than the value returned by the
- *   function, however.
  * @return
- *   - (-ENOTSUP) if operation is not supported.
+ *   - (-EINVAL) if @p info is NULL.
  *   - (-ENODEV) if *port_id* invalid.
  *   - (-EIO) if device is removed.
- *   - (>=0) number of available representor range entries.
+ *   - (0) @p info was filled.
  */
 __rte_experimental
 int rte_eth_representor_info_get(uint16_t port_id,
-- 
2.43.0

