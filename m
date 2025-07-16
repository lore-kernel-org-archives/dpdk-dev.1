Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EEDC83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 10:26:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0A54402D8;
	Wed, 16 Jul 2025 12:26:32 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by mails.dpdk.org (Postfix) with ESMTP id 4B7D74013F;
 Wed, 16 Jul 2025 12:26:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/ZuFFlyuuokEElCd5LeyHvWaRXlLfp9Xrtw2uEA4S3vhakQgT1YuPetYsL/wYsZDTV8hi261UhWNFMlaOmq5lFafJ/HPqwVxuddurjEYxYsNUqzsWglA/7rapMqfQIaDP1Dk/gdeCeKfDEusXqKl4iap1to3eraVj6lQ7T+FkiQN70008X356Cav7+4cNapTApEwXPTzxv1U0vdIaJK566whD8FYa8ZZrsyZIEZgTIA/aIiMOZXJixrhmJKxg3sb7BmMA0GYHd4wfv4wR+u3ugRQSXNyHBN/fcpYLu2FYn/NU+4FFQ6SJoqIchkHwoRm56Ap+fwXjhWdDLNbc6Qhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbkqjJHIhpEK0pWHEpmNQF76CZU1pH3wktjQ63MHiZI=;
 b=Hrfhu0q3SgMm1CgvDswgb6y5rciqeftWOh9WMytQmRf3F+GRrkg+1nomQKm+NDZHc0ZxChT8WoKji9fMwQn1LM+sYH4MOFe1zJQxAzI1N10xamgYSqJNit3bS0iEIrCPSeB92y/wWsMxY7ctsNBJXhXBlIBMM4DpmC2L07WgAKL5Lk4t4HgYcgTOKGw1+uJXGt19GEUCwnzYzOf1Y2GkgJYMCov46ZyhbYS5hl5QlH0oEa6XPnz7RLDus0GzU5SUV5W8a1zG1McMxRHxMG9brlQ6/rw/uxFkJLskT/m1RkyxNyc5f9Zmc4iAq4vnWv8LKo9390TkcWo27D60Nn4Ghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=6wind.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbkqjJHIhpEK0pWHEpmNQF76CZU1pH3wktjQ63MHiZI=;
 b=VWp8ImxSvkYnRHmwL3ip9c8W3yBOXAikt4p/kAJay+b1q/nxke/vhEfnCSZCLefXW6wVSCqvDwpn50EHV+gVIBdLjcTwtsisb4mYKlODh3JqQ8Rex3NwsvyhSyCnehf6d4r4kbz/l8pQuJ1i5C7VtXwxmcAqs00rgawGuUSWGfPU9oHLKjpcFUpmijMH4I18SdryMVgrwqh22MNxG4Kbf51yEMVFq1hdEYNFxhy76vdW3W1jXRZXUFSuv37FG0frFiizjTBL/1GBOwD3hBI5U8XKhgj4UpIuoNv+4vjEtyIcM7GvVANf7g/czxRB9iWJdK+xR1yt+wp5dVlAXy1dxA==
Received: from DM6PR08CA0040.namprd08.prod.outlook.com (2603:10b6:5:1e0::14)
 by DM4PR12MB7550.namprd12.prod.outlook.com (2603:10b6:8:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 16 Jul
 2025 10:26:26 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:5:1e0:cafe::f0) by DM6PR08CA0040.outlook.office365.com
 (2603:10b6:5:1e0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 10:26:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.1 via Frontend Transport; Wed, 16 Jul 2025 10:26:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 03:26:09 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Jul
 2025 03:26:05 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Didier Pallard
 <didier.pallard@6wind.com>, Adrien Mazarguil <adrien.mazarguil@6wind.com>,
 Nelio Laranjeiro <nelio.laranjeiro@6wind.com>, Francesco Santoro
 <francesco.santoro@6wind.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix min and max MTU reporting
Date: Wed, 16 Jul 2025 12:25:45 +0200
Message-ID: <20250716102546.1118749-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|DM4PR12MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: d263c210-324e-4c41-4bb2-08ddc453377f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qBvx2XJDX9ZmRX028zdroc91EEGf7FGHDNOj77nzuHQKW667U7ePXS3DvPro?=
 =?us-ascii?Q?6rZs4txAi9E8O6tTpYYjAnWkWJLb9mZvgmtYU7VdAQHWmRORvq9pbNQHnYSE?=
 =?us-ascii?Q?Uz2KoTLsKnp3M0TBkyo/cqODpqZRWr/mhMcdWaJpzYqJT2PTAURUj2mS4Gsv?=
 =?us-ascii?Q?HAle7tPANiiyVuIlmxdMvMvOppIU6/GVHizdfK+DyhNfZ6kwfRWyapQODg4o?=
 =?us-ascii?Q?4F7V5C50Im9Fkv0wWqohdz/dpXmuKblRpDI89aDFk09oluMOeXvkuEZp3wVY?=
 =?us-ascii?Q?vO5cJJL4q7Y2S0r73jySl9ch/0Em5bt4oAFUuNBh9xRDWiTtP/9Z3xmdR+Hx?=
 =?us-ascii?Q?vcM62bpQrJx62NdoQwEyzseuseC72kDUmJvR/ondD3rvd1EnvWfiUHEfYJ3H?=
 =?us-ascii?Q?SLPHd5BYJ5NfWwQROcOxUaDF2iREaI4mU8dmLQgFc/4XEFWrF3v42McBxgeK?=
 =?us-ascii?Q?owAtSa2S/+IHYA0jKsaK8VuKqiEkxWd3X6Myk2gGHn4PPnbrVHDFS1zRdGtQ?=
 =?us-ascii?Q?mXi++N5lQOLdRumOxdWpA8xVuywUNQN3hA0zrglUJY9/PCtF8HwatIsDDkkb?=
 =?us-ascii?Q?QQnJSzniSTkY9maqvITbQUEsVg5EgcQBe8Lf5g6BAEgRKCxbP53FWz83v+Ez?=
 =?us-ascii?Q?TpB3p/D36KMwwurvsUcexeppRR4CmgTA92qiFBkug0Z98hpma+GFzrcWtIVc?=
 =?us-ascii?Q?ndCirgDPeR9f9ZyQr3H1KWVYAHpLEuNuFgfFOdahKI14X0WyJEG2opQMMYgk?=
 =?us-ascii?Q?bBdfzp69g9tCBZRlp+BgrWvWEujchsjZy7l+kS/ZcW6mKX7A64WBvUtvBT0z?=
 =?us-ascii?Q?fm2D2SzJcq48XidiI6xygVNlqxwSYnYNFTi/O33hJ20LK3wcjivJfoBnvHRz?=
 =?us-ascii?Q?EJQtw2mLZskVfzEQL/6OBQgPMNhNUhdqDa5qRkhsHgURhA9+oQ8tYCVHw/eO?=
 =?us-ascii?Q?Sgw/NMy1JBw4ePFvuGep8T7zmCj2G6nB3QN1RAOQfY8yK1sU0R8JtLWalCef?=
 =?us-ascii?Q?GIfGhFl191nAQrPoZoRdvXEydg9bder4m+MiB1gPecKNmVhz906dZy9ZrdS6?=
 =?us-ascii?Q?Qx7TTO2hNHOITw3niii9UBach58AHddZIs61TEt4PzLDrTY0MPmCKskS7h21?=
 =?us-ascii?Q?AANYWql4reFtj5qGb1XLdel1D9W9lS/J6KxFJnOMLCpmid+GjmQ7R3kLjofj?=
 =?us-ascii?Q?rD8g2UrByp5/NpzlltNAcXea0qhqHYMDcLlvsW9xD7IB1FPAvA0j36jEyFYS?=
 =?us-ascii?Q?Y4A5ul8ldyqfBJ8PyloS2dRif0EC9thDkDTK6W9EG4pURd5fDTVrEkbd73pS?=
 =?us-ascii?Q?FVB9QTmXUjT5ufdur/7/8etTtUBJ9XKAAa9r5Rm5VAWJZFZZOSrZP5Ye4Lms?=
 =?us-ascii?Q?NhHjoDDyg7QFhEW6UKXAfRfqohI9z50iyGH04A8T2/7kTJHYGaZmNDB6gudi?=
 =?us-ascii?Q?1CVoVJ00huFZGC7OuqNFxkCLMKNpHNjQ6C0uAxqVzce21r/ssdjNPUxQlCwB?=
 =?us-ascii?Q?Q1BIkIhm/UUi4iPCYwWUuv4A8JUYALzcKEqm?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 10:26:24.7173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d263c210-324e-4c41-4bb2-08ddc453377f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7550
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

mlx5 PMD used hardcoded and incorrect values when reporting
maximum MTU and maximum Rx packet length through rte_eth_dev_info_get().

This patch adds support for querying OS for minimum and maximum
allowed MTU values. Maximum Rx packet length is then calculated
based on these values.

On Linux, these values are queried through netlink,
using IFLA_MIN_MTU and IFLA_MAX_MTU attributes added in Linux 4.18.

Windows API unfortunately does not expose minimum and maximum
allowed MTU values. In this case, fallback hardcoded values
(working on currently supported HW) will be used.

Bugzilla ID: 1719
Fixes: e60fbd5b24fc ("mlx5: add device configure/start/stop")
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/common/mlx5/linux/mlx5_nl.c       | 109 ++++++++++++++++++++++
 drivers/common/mlx5/linux/mlx5_nl.h       |   3 +
 drivers/net/mlx5/linux/mlx5_ethdev_os.c   |  30 ++++++
 drivers/net/mlx5/linux/mlx5_os.c          |   2 +
 drivers/net/mlx5/mlx5.h                   |  13 +++
 drivers/net/mlx5/mlx5_ethdev.c            |  42 ++++++++-
 drivers/net/mlx5/windows/mlx5_ethdev_os.c |  28 ++++++
 drivers/net/mlx5/windows/mlx5_os.c        |   2 +
 8 files changed, 228 insertions(+), 1 deletion(-)

diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index 86166e92d0..dd69e229e3 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -2247,3 +2247,112 @@ mlx5_nl_rdma_monitor_cap_get(int nl, uint8_t *cap)
 	}
 	return 0;
 }
+
+struct mlx5_mtu {
+	uint32_t min_mtu;
+	bool min_mtu_set;
+	uint32_t max_mtu;
+	bool max_mtu_set;
+};
+
+static int
+mlx5_nl_get_mtu_bounds_cb(struct nlmsghdr *nh, void *arg)
+{
+	size_t off = NLMSG_LENGTH(sizeof(struct ifinfomsg));
+	struct mlx5_mtu *out = arg;
+
+	while (off < nh->nlmsg_len) {
+		struct rtattr *ra = RTE_PTR_ADD(nh, off);
+		uint32_t *payload;
+
+		switch (ra->rta_type) {
+		case IFLA_MIN_MTU:
+			payload = RTA_DATA(ra);
+			out->min_mtu = *payload;
+			out->min_mtu_set = true;
+			break;
+		case IFLA_MAX_MTU:
+			payload = RTA_DATA(ra);
+			out->max_mtu = *payload;
+			out->max_mtu_set = true;
+			break;
+		default:
+			/* Nothing to do for other attributes. */
+			break;
+		}
+		off += RTA_ALIGN(ra->rta_len);
+	}
+
+	return 0;
+}
+
+/**
+ * Query minimum and maximum allowed MTU values for given Linux network interface.
+ *
+ * This function queries the following interface attributes exposed in netlink since Linux 4.18:
+ *
+ * - IFLA_MIN_MTU - minimum allowed MTU
+ * - IFLA_MAX_MTU - maximum allowed MTU
+ *
+ * @param[in] nl
+ *   Netlink socket of the ROUTE kind (NETLINK_ROUTE).
+ * @param[in] ifindex
+ *   Linux network device index.
+ * @param[out] min_mtu
+ *   Pointer to minimum allowed MTU. Populated only if both minimum and maximum MTU was queried.
+ * @param[out] max_mtu
+ *   Pointer to maximum allowed MTU. Populated only if both minimum and maximum MTU was queried.
+ *
+ * @return
+ *   0 on success, negative on error and rte_errno is set.
+ *
+ *   Known errors:
+ *
+ *   - (-EINVAL) - either @p min_mtu or @p max_mtu is NULL.
+ *   - (-ENOENT) - either minimum or maximum allowed MTU was not found in interface attributes.
+ */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_get_mtu_bounds)
+int
+mlx5_nl_get_mtu_bounds(int nl, unsigned int ifindex, uint16_t *min_mtu, uint16_t *max_mtu)
+{
+	struct mlx5_mtu out = { 0 };
+	struct {
+		struct nlmsghdr nh;
+		struct ifinfomsg info;
+	} req = {
+		.nh = {
+			.nlmsg_len = NLMSG_LENGTH(sizeof(req.info)),
+			.nlmsg_type = RTM_GETLINK,
+			.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
+		},
+		.info = {
+			.ifi_family = AF_UNSPEC,
+			.ifi_index = ifindex,
+		},
+	};
+	uint32_t sn = MLX5_NL_SN_GENERATE;
+	int ret;
+
+	if (min_mtu == NULL || max_mtu == NULL) {
+		rte_errno = EINVAL;
+		return -rte_errno;
+	}
+
+	ret = mlx5_nl_send(nl, &req.nh, sn);
+	if (ret < 0)
+		return ret;
+
+	ret = mlx5_nl_recv(nl, sn, mlx5_nl_get_mtu_bounds_cb, &out);
+	if (ret < 0)
+		return ret;
+
+	if (!out.min_mtu_set || !out.max_mtu_set) {
+		rte_errno = ENOENT;
+		return -rte_errno;
+	}
+
+	*min_mtu = out.min_mtu;
+	*max_mtu = out.max_mtu;
+
+	return ret;
+}
diff --git a/drivers/common/mlx5/linux/mlx5_nl.h b/drivers/common/mlx5/linux/mlx5_nl.h
index e32080fa63..26923a88fd 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.h
+++ b/drivers/common/mlx5/linux/mlx5_nl.h
@@ -117,4 +117,7 @@ void mlx5_nl_rdma_monitor_info_get(struct nlmsghdr *hdr, struct mlx5_nl_port_inf
 __rte_internal
 int mlx5_nl_rdma_monitor_cap_get(int nl, uint8_t *cap);

+__rte_internal
+int mlx5_nl_get_mtu_bounds(int nl, unsigned int ifindex, uint16_t *min_mtu, uint16_t *max_mtu);
+
 #endif /* RTE_PMD_MLX5_NL_H_ */
diff --git a/drivers/net/mlx5/linux/mlx5_ethdev_os.c b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
index 9daeda5435..a371c2c747 100644
--- a/drivers/net/mlx5/linux/mlx5_ethdev_os.c
+++ b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
@@ -159,6 +159,36 @@ mlx5_ifreq(const struct rte_eth_dev *dev, int req, struct ifreq *ifr)
 	return mlx5_ifreq_by_ifname(ifname, req, ifr);
 }

+/**
+ * Get device minimum and maximum allowed MTU values.
+ *
+ * @param dev
+ *   Pointer to Ethernet device.
+ * @param[out] min_mtu
+ *   Minimum MTU value output buffer.
+ * @param[out] max_mtu
+ *   Maximum MTU value output buffer.
+ *
+ * @return
+ *   0 on success, a negative errno value otherwise and rte_errno is set.
+ */
+int
+mlx5_os_get_mtu_bounds(struct rte_eth_dev *dev, uint16_t *min_mtu, uint16_t *max_mtu)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	int nl_route;
+	int ret;
+
+	nl_route = mlx5_nl_init(NETLINK_ROUTE, 0);
+	if  (nl_route < 0)
+		return nl_route;
+
+	ret = mlx5_nl_get_mtu_bounds(nl_route, priv->if_index, min_mtu, max_mtu);
+
+	close(nl_route);
+	return ret;
+}
+
 /**
  * Get device MTU.
  *
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 696a3e12c7..2bc8ca9284 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1562,6 +1562,8 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	eth_dev->data->mac_addrs = priv->mac;
 	eth_dev->device = dpdk_dev;
 	eth_dev->data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
+	/* Fetch minimum and maximum allowed MTU from the device. */
+	mlx5_get_mtu_bounds(eth_dev, &priv->min_mtu, &priv->max_mtu);
 	/* Configure the first MAC address by default. */
 	if (mlx5_get_mac(eth_dev, &mac.addr_bytes)) {
 		DRV_LOG(ERR,
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index c08894cd03..53f0a27445 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -74,6 +74,15 @@
 /* Maximal number of field/field parts to map into sample registers .*/
 #define MLX5_FLEX_ITEM_MAPPING_NUM		32

+/* Number of bytes not included in MTU. */
+#define MLX5_ETH_OVERHEAD (RTE_ETHER_HDR_LEN + RTE_VLAN_HLEN + RTE_ETHER_CRC_LEN)
+
+/* Minimum allowed MTU to be reported whenever PMD cannot query it from OS. */
+#define MLX5_ETH_MIN_MTU (RTE_ETHER_MIN_MTU)
+
+/* Maximum allowed MTU to be reported whenever PMD cannot query it from OS. */
+#define MLX5_ETH_MAX_MTU (9978)
+
 enum mlx5_ipool_index {
 #if defined(HAVE_IBV_FLOW_DV_SUPPORT) || !defined(HAVE_INFINIBAND_VERBS_H)
 	MLX5_IPOOL_DECAP_ENCAP = 0, /* Pool for encap/decap resource. */
@@ -1981,6 +1990,8 @@ struct mlx5_priv {
 	unsigned int vlan_filter_n; /* Number of configured VLAN filters. */
 	/* Device properties. */
 	uint16_t mtu; /* Configured MTU. */
+	uint16_t min_mtu; /* Minimum MTU allowed on the NIC. */
+	uint16_t max_mtu; /* Maximum MTU allowed on the NIC. */
 	unsigned int isolated:1; /* Whether isolated mode is enabled. */
 	unsigned int representor:1; /* Device is a port representor. */
 	unsigned int master:1; /* Device is a E-Switch master. */
@@ -2333,6 +2344,7 @@ struct mlx5_priv *mlx5_dev_to_eswitch_info(struct rte_eth_dev *dev);
 int mlx5_dev_configure_rss_reta(struct rte_eth_dev *dev);
 uint64_t mlx5_get_restore_flags(struct rte_eth_dev *dev,
 				enum rte_eth_dev_operation op);
+void mlx5_get_mtu_bounds(struct rte_eth_dev *dev, uint16_t *min_mtu, uint16_t *max_mtu);

 /* mlx5_ethdev_os.c */

@@ -2372,6 +2384,7 @@ int mlx5_os_get_stats_n(struct rte_eth_dev *dev, bool bond_master,
 			uint16_t *n_stats, uint16_t *n_stats_sec);
 void mlx5_os_stats_init(struct rte_eth_dev *dev);
 int mlx5_get_flag_dropless_rq(struct rte_eth_dev *dev);
+int mlx5_os_get_mtu_bounds(struct rte_eth_dev *dev, uint16_t *min_mtu, uint16_t *max_mtu);

 /* mlx5_mac.c */

diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
index 68d1c1bfa7..7747b0c869 100644
--- a/drivers/net/mlx5/mlx5_ethdev.c
+++ b/drivers/net/mlx5/mlx5_ethdev.c
@@ -360,9 +360,11 @@ mlx5_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 	unsigned int max;
 	uint16_t max_wqe;

+	info->min_mtu = priv->min_mtu;
+	info->max_mtu = priv->max_mtu;
+	info->max_rx_pktlen = info->max_mtu + MLX5_ETH_OVERHEAD;
 	/* FIXME: we should ask the device for these values. */
 	info->min_rx_bufsize = 32;
-	info->max_rx_pktlen = 65536;
 	info->max_lro_pkt_size = MLX5_MAX_LRO_SIZE;
 	/*
 	 * Since we need one CQ per QP, the limit is the minimum number
@@ -863,3 +865,41 @@ mlx5_get_restore_flags(__rte_unused struct rte_eth_dev *dev,
 	/* mlx5 PMD does not require any configuration restore. */
 	return 0;
 }
+
+/**
+ * Query minimum and maximum allowed MTU value on the device.
+ *
+ * This functions will always return valid MTU bounds.
+ * In case platform-specific implementation fails or current platform does not support it,
+ * the fallback default values will be used.
+ *
+ * @param[in] dev
+ *   Pointer to Ethernet device
+ * @param[out] min_mtu
+ *   Minimum MTU value output buffer.
+ * @param[out] max_mtu
+ *   Maximum MTU value output buffer.
+ */
+void
+mlx5_get_mtu_bounds(struct rte_eth_dev *dev, uint16_t *min_mtu, uint16_t *max_mtu)
+{
+	int ret;
+
+	MLX5_ASSERT(min_mtu != NULL);
+	MLX5_ASSERT(max_mtu != NULL);
+
+	ret = mlx5_os_get_mtu_bounds(dev, min_mtu, max_mtu);
+	if (ret < 0) {
+		if (ret != -ENOTSUP)
+			DRV_LOG(INFO, "port %u failed to query MTU bounds, using fallback values",
+				dev->data->port_id);
+		*min_mtu = MLX5_ETH_MIN_MTU;
+		*max_mtu = MLX5_ETH_MAX_MTU;
+
+		/* This function does not fail. Clear rte_errno. */
+		rte_errno = 0;
+	}
+
+	DRV_LOG(INFO, "port %u minimum MTU is %u", dev->data->port_id, *min_mtu);
+	DRV_LOG(INFO, "port %u maximum MTU is %u", dev->data->port_id, *max_mtu);
+}
diff --git a/drivers/net/mlx5/windows/mlx5_ethdev_os.c b/drivers/net/mlx5/windows/mlx5_ethdev_os.c
index 49f750be68..4f43b95a09 100644
--- a/drivers/net/mlx5/windows/mlx5_ethdev_os.c
+++ b/drivers/net/mlx5/windows/mlx5_ethdev_os.c
@@ -71,6 +71,34 @@ mlx5_get_ifname(const struct rte_eth_dev *dev, char (*ifname)[MLX5_NAMESIZE])
 	return 0;
 }

+/**
+ * Get device minimum and maximum allowed MTU.
+ *
+ * Windows API does not expose minimum and maximum allowed MTU.
+ * In this case, this just returns (-ENOTSUP) to allow platform-independent code
+ * to fallback to default values.
+ *
+ * @param dev
+ *   Pointer to Ethernet device.
+ * @param[out] min_mtu
+ *   Minimum MTU value output buffer.
+ * @param[out] max_mtu
+ *   Maximum MTU value output buffer.
+ *
+ * @return
+ *   (-ENOTSUP) - not supported on Windows
+ */
+int
+mlx5_os_get_mtu_bounds(struct rte_eth_dev *dev, uint16_t *min_mtu, uint16_t *max_mtu)
+{
+	RTE_SET_USED(dev);
+	RTE_SET_USED(min_mtu);
+	RTE_SET_USED(max_mtu);
+
+	rte_errno = ENOTSUP;
+	return -rte_errno;
+}
+
 /**
  * Get device MTU.
  *
diff --git a/drivers/net/mlx5/windows/mlx5_os.c b/drivers/net/mlx5/windows/mlx5_os.c
index d583730066..c4e3430bdc 100644
--- a/drivers/net/mlx5/windows/mlx5_os.c
+++ b/drivers/net/mlx5/windows/mlx5_os.c
@@ -477,6 +477,8 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	eth_dev->data->mac_addrs = priv->mac;
 	eth_dev->device = dpdk_dev;
 	eth_dev->data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
+	/* Fetch minimum and maximum allowed MTU from the device. */
+	mlx5_get_mtu_bounds(eth_dev, &priv->min_mtu, &priv->max_mtu);
 	/* Configure the first MAC address by default. */
 	if (mlx5_get_mac(eth_dev, &mac.addr_bytes)) {
 		DRV_LOG(ERR,
--
2.39.5

