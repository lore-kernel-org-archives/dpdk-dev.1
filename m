Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9A7606A31D
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BoRb0Qmu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17D3B4069D;
	Mon, 26 Oct 2026 17:28:16 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011034.outbound.protection.outlook.com [52.101.52.34])
 by mails.dpdk.org (Postfix) with ESMTPS id 91192402E4
 for <dev@dpdk.org>; Mon, 26 Oct 2026 17:28:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDulqc3AHkZ1otiOdwS6OHv7SFlill9AkfB7e0ZRBupbCoruIk9aPBVKy7CDNG01n4hIZMhuwpOHRTLgINjBYnL25BNDfDbAL1gbXdy1BSVjtoNnXQuDdocJ90LlEJ/073ZpNCLEfS3ZRGLFZ/7e6k0e0dGeiZ4ZYhGrOSde2jTEPmWgEKVvaatHjLwd1bZBIAvxitcqDdjKitqTkwfK011/XURB0qppK42TZuluZXfscZ3ynEucRhZrpqJf8tQxPphBba7YabYjh10A/JE7mWJJAuW/jwBCQJ4GpG1PuqYYludgq/64ZunlkEp41nN6mLG/AIiWFnS99gX6lFoy0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87sM8ClusMR5Di/M//NPDxHUerqllcD5zkyYAFZH8dI=;
 b=dmAUX0zRLlP2fPFxyh/I6zxzeXadPSIuwASgM+iPUlg0eu8Y+Y7e4FXqxv/T0B9+AsnbSWcV+9gjYJAvZbX2HrxRQzqDJtCXcIKNn4xlz5x+amElPCehXgRQVhjLXlr5ybpEG32hYSKoo1t4clhk7iCmALgnCn5jXNjZU/RJ0o18cvP+8zXLjgsCCI6iRVP2n9Klzj2Ka9lTvCRVx8r+sCx5wxdOZ4ViLvRw07q0GGY/6fQaLoA+VN8zkL1fGlmLill+XPEnPeJYqe3hmDwaYD1RWxCSCr+a+kay9eZV1NBXK/ctapRYXEARh5KG/zJL43UP5px7Kr/TC+GtQicTWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87sM8ClusMR5Di/M//NPDxHUerqllcD5zkyYAFZH8dI=;
 b=BoRb0QmuvlwDqPtA+mjzenEBIMwfKBdtCLqJUiNMfJ46zl8z0rHuFh6JXURYN7v/K/rncrHsFSEeYK+RvdrCeI7prSafMNiF2NePGdR780OxKsUhCeNOf8JDbEdxEcWTp+gH6OS2tQQFXG4B26IIp/o4PhjeBWOFIqrbvqajnHwyoJlDM8bKJc81lQ6YWm6TinKVBmswmyLQwaIQZCZF3zWNy/XVYSzbA7DwM5AtxVjHp7PginWPaN8FYm+qtFDGrh+76T+gvg6VuOxssAXWjZOpZvVVbNjZlR/x0UxzCnQeb//YSROfrjdXbRQ0XoYoKOJ3Tw7R6io1OVWZOfTMyA==
Received: from DM6PR03CA0095.namprd03.prod.outlook.com (2603:10b6:5:333::28)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:28:00 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::3b) by DM6PR03CA0095.outlook.office365.com
 (2603:10b6:5:333::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 16:28:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 16:27:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:36 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:34 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH 06/13] common/mlx5: gather associated devices
Date: Mon, 26 Oct 2026 17:27:02 +0100
Message-ID: <20261026162709.1292958-7-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026162709.1292958-1-dsosnowski@nvidia.com>
References: <20261026162709.1292958-1-dsosnowski@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: b4864af6-c486-4b40-4d7b-08df337e1999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|261009223027099003|261022105027099003|261022113327099003|261021123027099003|261021130227099003|261021133027099003|261021121427099003|261021135927099003|261022115727099003|261022075727099003|10067099003|56012099006|261026121527099003|3023799007|6133799003|22082099003|18002099003|261026135527099003|11063799006|261026140227099003|261026130827099003;
X-Microsoft-Antispam-Message-Info: Ya2VqzCnsxFIQi5kd7LxUxVld9leiPiO8Co2l9rZzaP73sTApvLE3baZQwPn4zthTApqDePiRDL03P10mqXX8TkwkJGQL4vojc/U6+u9fBdXb0sXanAFZWy4ualHSgBHD5UXRoOg7+EoYu0pwY8s/P+CSFrqjfd71pRCCZn67jS/aCFiFIJhneMbQ4vk6i/MgPqWcrpDST3GD/jV6g0jiX/uJZ+QP6QVgIjb6bJdGumzKAhVnM5FMNPmc012wUmtfCkOczeJ7irg8EuqozsiLNUI3JjXZTLWF1HRYaAW9v63ofmTcP5iL2JQtX7sbEE60L/CNo0jPkA9CNG0xI2jooQzNcnkYM+rAJUt1ARnCyD3XwMZx3B/TiHmtQpn8ksEBEIEMpdmoCPMYum18rW3tznwJCnLN6i//XVLmZN45DNle2WinJ4hp1QAW2xCTn7o5DjJ3aFN+ICOPMa2uAj1Atwz7fEfAlh1klQvIebcz4fBM/85TYQBeI0NbsHh1FCH+cW7VM1N8GDMbvW46pVoKq9SW+E1KWX/3g9HWYGGKzQ/OF3UqJ+3vFnetnIv2b0gsAdXjr8R9fX3ytXcCTn9PdZLWkOP1rTMLbm+AOKQFCnq/KVlCR2ggYfcnblXktAj18rEI1eE0gUE3rYX1AU6cYI9AXFUQyaV6D6mpFQxc5qkCi/Cx8klgrcHj2AEv7/3+7zkAXJC520r0JHu6sOq7g==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(261009223027099003)(261022105027099003)(261022113327099003)(261021123027099003)(261021130227099003)(261021133027099003)(261021121427099003)(261021135927099003)(261022115727099003)(261022075727099003)(10067099003)(56012099006)(261026121527099003)(3023799007)(6133799003)(22082099003)(18002099003)(261026135527099003)(11063799006)(261026140227099003)(261026130827099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3I0V+A9NiAEdrX4UwLUHfc0zHmE0mHcMyI9U/Q/tWFogxXN3LOez35nezypHowJQP9aba7bfsTjtwWHBJeJ4gqON3w43Jo5DyA0MrFk1Akth3o+N49Arfl9xcogSgQ+OpjrsnbK/W8U7t3qV2GU99cg4AeNF/T2Z+0T83qB6STBj0cs2F+W+c0i1+DzWi7neGGp0Wft6HuoyjyF0X7bj83r+oNvvhaUWYLbUFDZjt37joBJvNIeO2x9knWcKiIXCPezb6Rlld8M6cFj1p7uiac4YyQLbxZZNSnsSaWtMJOU361/8ZwrDGAsDl1z6XoaNvWINPseyj7jUjgDC9if8dMXwyV+OSJCgaP5JRUGZwlu0jNaem3yVPDokt+TpkZ8/+nnT4Ef5FtZSAcfzadBc3sqauqzQuITHkiXvQZ4SPoPSJtCyder6GfnaVl2ECrlv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:27:59.6455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4864af6-c486-4b40-4d7b-08df337e1999
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
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

There was one-to-one association between rte_device
and mlx5_common_device. Specifically on Linux, this rte_device
is either PCI or auxiliary device where IBV context can be opened.
This association is limiting for cases where embedded switch is shared
between different PFs/VFs/SFs. In such cases:

- There is one IB device where IBV context can be opened.
  This IB device is owned by a single PF/VF/SF.
- There are multiple PCI/auxiliary devices within embedded switch
  domain.

Goal of this patch is to allow probing ports belonging to the
embedded switch using the real associated device name.

When mlx5_common_device is created on Linux, a list of associated
devices is gathered:

- Number of IB ports (for mlx5 driver IB port is equivalent
  to embedded switch port) is queried.
- Using netlink RDMA interface, mlx5 driver translates IB port
  to netdev ifindex.
- Using netlink interface, mlx5 queries parent device
  of each netdev.
- Each parent device is added to associated devices list:
    - Device is added as a pair of bus/name strings.
    - Later on probe this are matched to allocated rte_device
      and replaced with that info.

As of this patch, all mlx5 driver will support only probing
with the main device (IB device owner).
Future patches will allow networking driver to probe
using multiple rte_device's.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/common/mlx5/linux/mlx5_common_os.c   | 164 +++++++++++++++++++
 drivers/common/mlx5/linux/mlx5_common_os.h   |   4 +
 drivers/common/mlx5/mlx5_common.c            |  52 ++++++
 drivers/common/mlx5/mlx5_common.h            |  20 +++
 drivers/common/mlx5/windows/mlx5_common_os.c |  19 +++
 drivers/common/mlx5/windows/mlx5_common_os.h |   1 +
 6 files changed, 260 insertions(+)

diff --git a/drivers/common/mlx5/linux/mlx5_common_os.c b/drivers/common/mlx5/linux/mlx5_common_os.c
index 903963670d..bd23c990f0 100644
--- a/drivers/common/mlx5/linux/mlx5_common_os.c
+++ b/drivers/common/mlx5/linux/mlx5_common_os.c
@@ -1251,3 +1251,167 @@ mlx5_os_is_device_bond(const void *dev)
 	closedir(net_dir);
 	return result;
 }
+
+static bool
+associated_device_matches_dev(const struct mlx5_associated_device *assoc,
+			      const char *bus_name,
+			      const char *dev_name)
+{
+	return assoc->is_rte_device && mlx5_dev_matches(assoc->dev, bus_name, dev_name);
+}
+
+static bool
+associated_device_matches_info(const struct mlx5_associated_device *assoc,
+			       const char *bus_name,
+			       const char *dev_name)
+{
+	return !assoc->is_rte_device &&
+	       strcmp(assoc->info.bus_name, bus_name) == 0 &&
+	       strcmp(assoc->info.dev_name, dev_name) == 0;
+}
+
+static bool
+associated_device_exists(const struct mlx5_common_device *cdev,
+			 const char *bus_name,
+			 const char *dev_name)
+{
+	struct mlx5_associated_device *assoc;
+
+	TAILQ_FOREACH(assoc, &cdev->associated_devices, next) {
+		if (associated_device_matches_dev(assoc, bus_name, dev_name) ||
+		    associated_device_matches_info(assoc, bus_name, dev_name))
+			return true;
+	}
+
+	return false;
+}
+
+static struct mlx5_associated_device *
+associated_device_alloc(const char *bus_name, const char *dev_name)
+{
+	struct mlx5_associated_device *assoc;
+	size_t bus_name_len;
+	size_t dev_name_len;
+	size_t size;
+	char *dst;
+
+	bus_name_len = strlen(bus_name) + 1;
+	dev_name_len = strlen(dev_name) + 1;
+
+	size = sizeof(*assoc);
+	size += bus_name_len;
+	size += dev_name_len;
+
+	assoc = mlx5_malloc(MLX5_MEM_ZERO, size, 0, SOCKET_ID_ANY);
+	if (!assoc)
+		return NULL;
+
+	assoc->is_rte_device = false;
+
+	dst = (void *)(assoc + 1);
+	memcpy(dst, bus_name, bus_name_len);
+	assoc->info.bus_name = dst;
+
+	dst = RTE_PTR_ADD(dst, bus_name_len);
+	memcpy(dst, dev_name, dev_name_len);
+	assoc->info.dev_name = dst;
+
+	return assoc;
+}
+
+int
+mlx5_os_fill_associated_devices(struct mlx5_common_device *cdev)
+{
+	struct mlx5_associated_device *assoc;
+	struct ibv_device *ibdev;
+	unsigned int portnum;
+	int nl_route = -1;
+	int nl_rdma;
+	int ret = 0;
+
+	MLX5_ASSERT(cdev != NULL);
+	MLX5_ASSERT(cdev->dev != NULL);
+	MLX5_ASSERT(TAILQ_EMPTY(&cdev->associated_devices));
+
+	assoc = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*assoc), 0, SOCKET_ID_ANY);
+	if (!assoc)
+		return -ENOMEM;
+	assoc->is_rte_device = true;
+	assoc->dev = cdev->dev;
+	TAILQ_INSERT_HEAD(&cdev->associated_devices, assoc, next);
+
+	ibdev = ((struct ibv_context *)cdev->ctx)->device;
+
+	nl_rdma = mlx5_nl_init(NETLINK_RDMA, 0);
+	if (nl_rdma < 0) {
+		ret = -rte_errno;
+		goto release_return;
+	}
+
+	portnum = mlx5_nl_portnum(nl_rdma, ibdev->name, NULL);
+	if (portnum == 0) {
+		ret = -rte_errno;
+		goto release_return;
+	}
+	if (portnum == 1) {
+		ret = 0;
+		goto release_return;
+	}
+
+	nl_route = mlx5_nl_init(NETLINK_ROUTE, 0);
+	if (nl_route < 0) {
+		ret = -rte_errno;
+		goto release_return;
+	}
+
+	for (unsigned int port = 1; port <= portnum; ++port) {
+		struct mlx5_netdev_info netdev_info = { 0 };
+
+		netdev_info.ifindex = mlx5_nl_ifindex(nl_rdma, ibdev->name, port, NULL);
+		if (netdev_info.ifindex == 0)
+			continue;
+
+		ret = mlx5_nl_netdev_info_get(nl_route, &netdev_info);
+		if (ret < 0) {
+			/*
+			 * On any failure just skip and don't add the device
+			 * to the associated devices list.
+			 */
+			DRV_LOG(DEBUG,
+				"ibdev %s port %u ifindex %u failed to get netdev info (%s)",
+				ibdev->name, port, netdev_info.ifindex, rte_strerror(-ret));
+			ret = 0;
+			continue;
+		}
+
+		if (!(netdev_info.flags & MLX5_NETDEV_INFO_FLAG_PARENT_DEV_NAME) ||
+		    !(netdev_info.flags & MLX5_NETDEV_INFO_FLAG_PARENT_DEV_BUS_NAME))
+			continue;
+
+		if (associated_device_exists(cdev,
+					     netdev_info.parent_dev_bus_name,
+					     netdev_info.parent_dev_name))
+			continue;
+
+		assoc = associated_device_alloc(netdev_info.parent_dev_bus_name,
+						netdev_info.parent_dev_name);
+		if (assoc == NULL) {
+			ret = -ENOMEM;
+			goto release_return;
+		}
+
+		TAILQ_INSERT_HEAD(&cdev->associated_devices, assoc, next);
+	}
+
+release_return:
+	while (ret < 0 && !TAILQ_EMPTY(&cdev->associated_devices)) {
+		assoc = TAILQ_FIRST(&cdev->associated_devices);
+		TAILQ_REMOVE(&cdev->associated_devices, assoc, next);
+		mlx5_free(assoc);
+	}
+	if (nl_rdma >= 0)
+		close(nl_rdma);
+	if (nl_route >= 0)
+		close(nl_route);
+	return ret;
+}
diff --git a/drivers/common/mlx5/linux/mlx5_common_os.h b/drivers/common/mlx5/linux/mlx5_common_os.h
index 7d4e3c5fe8..e39afcb9de 100644
--- a/drivers/common/mlx5/linux/mlx5_common_os.h
+++ b/drivers/common/mlx5/linux/mlx5_common_os.h
@@ -22,6 +22,8 @@
 #include "mlx5_glue.h"
 #include "mlx5_malloc.h"
 
+struct mlx5_common_device;
+
 /* verb enumerations translations to local enums. */
 enum {
 	MLX5_FS_NAME_MAX = IBV_SYSFS_NAME_MAX + 1,
@@ -326,4 +328,6 @@ mlx5_os_interrupt_handler_destroy(struct rte_intr_handle *intr_handle,
 __rte_internal
 bool mlx5_os_is_device_bond(const void *dev);
 
+int mlx5_os_fill_associated_devices(struct mlx5_common_device *cdev);
+
 #endif /* RTE_PMD_MLX5_COMMON_OS_H_ */
diff --git a/drivers/common/mlx5/mlx5_common.c b/drivers/common/mlx5/mlx5_common.c
index 11a53c8b56..67566e01b2 100644
--- a/drivers/common/mlx5/mlx5_common.c
+++ b/drivers/common/mlx5/mlx5_common.c
@@ -755,6 +755,18 @@ mlx5_dev_hw_global_prepare(struct mlx5_common_device *cdev, uint32_t classes)
 	return ret;
 }
 
+static void
+mlx5_associated_devices_release(struct mlx5_common_device *cdev)
+{
+	struct mlx5_associated_device *assoc;
+
+	while (!TAILQ_EMPTY(&cdev->associated_devices)) {
+		assoc = TAILQ_FIRST(&cdev->associated_devices);
+		TAILQ_REMOVE(&cdev->associated_devices, assoc, next);
+		mlx5_free(assoc);
+	}
+}
+
 static void
 mlx5_common_dev_release(struct mlx5_common_device *cdev)
 {
@@ -762,6 +774,7 @@ mlx5_common_dev_release(struct mlx5_common_device *cdev)
 	TAILQ_REMOVE(&devices_list, cdev, next);
 	pthread_mutex_unlock(&devices_list_lock);
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		mlx5_associated_devices_release(cdev);
 		if (TAILQ_EMPTY(&devices_list))
 			rte_mem_event_callback_unregister("MLX5_MEM_EVENT_CB",
 							  NULL);
@@ -791,6 +804,7 @@ mlx5_common_dev_create(struct rte_device *eal_dev, uint32_t classes,
 		return NULL;
 	}
 	cdev->dev = eal_dev;
+	TAILQ_INIT(&cdev->associated_devices);
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		goto exit;
 	/* Parse device parameters. */
@@ -822,6 +836,16 @@ mlx5_common_dev_create(struct rte_device *eal_dev, uint32_t classes,
 		rte_mem_event_callback_register("MLX5_MEM_EVENT_CB",
 						mlx5_mr_mem_event_cb, NULL);
 	cdev->dev_info.probe_opt = cdev->config.probe_opt;
+
+	ret = mlx5_os_fill_associated_devices(cdev);
+	if (ret < 0) {
+		DRV_LOG(DEBUG,
+			"cdev %s Failed to initialize associated devices list. "
+			"Only owner device is allowed",
+			cdev->dev->name);
+		rte_errno = 0;
+	}
+
 exit:
 	pthread_mutex_lock(&devices_list_lock);
 	TAILQ_INSERT_HEAD(&devices_list, cdev, next);
@@ -1468,4 +1492,32 @@ mlx5_devx_uar_prepare(struct mlx5_common_device *cdev, struct mlx5_uar *uar)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_dev_matches)
+bool
+mlx5_dev_matches(const struct rte_device *dev,
+		 const char *bus_name,
+		 const char *dev_name)
+{
+	if (strcmp(dev->bus->name, bus_name) != 0)
+		return false;
+
+	if (mlx5_dev_is_pci(dev)) {
+		const struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev, *pci_dev);
+		struct rte_pci_addr addr;
+
+		if (rte_pci_addr_parse(dev_name, &addr) < 0)
+			return false;
+
+		return rte_pci_addr_cmp(&addr, &pci_dev->addr) == 0;
+	}
+
+	if (mlx5_dev_is_auxiliary(dev)) {
+		const struct rte_auxiliary_device *aux_dev = RTE_BUS_DEVICE(dev, *aux_dev);
+
+		return strcmp(dev_name, aux_dev->name) == 0;
+	}
+
+	return false;
+}
+
 RTE_PMD_EXPORT_NAME(mlx5_common_driver);
diff --git a/drivers/common/mlx5/mlx5_common.h b/drivers/common/mlx5/mlx5_common.h
index f579ca0904..8f8ab01700 100644
--- a/drivers/common/mlx5/mlx5_common.h
+++ b/drivers/common/mlx5/mlx5_common.h
@@ -515,6 +515,22 @@ struct mlx5_common_dev_config {
 	/* Whether memseg should be extended for MR creation. */
 };
 
+struct mlx5_associated_device_info {
+	const char *bus_name;
+	const char *dev_name;
+};
+
+struct mlx5_associated_device {
+	TAILQ_ENTRY(mlx5_associated_device) next;
+	bool is_rte_device;
+	union {
+		const struct rte_device *dev;
+		struct mlx5_associated_device_info info;
+	};
+};
+
+TAILQ_HEAD(mlx5_associated_device_list, mlx5_associated_device);
+
 struct mlx5_common_device {
 	struct rte_device *dev;
 	TAILQ_ENTRY(mlx5_common_device) next;
@@ -525,6 +541,7 @@ struct mlx5_common_device {
 	uint32_t pdn; /* Protection Domain Number. */
 	struct mlx5_mr_share_cache mr_scache; /* Global shared MR cache. */
 	struct mlx5_common_dev_config config; /* Device configuration. */
+	struct mlx5_associated_device_list associated_devices;
 };
 
 /**
@@ -669,4 +686,7 @@ __rte_internal
 void
 mlx5_os_wrapped_mkey_destroy(struct mlx5_pmd_wrapped_mr *pmd_mr);
 
+__rte_internal
+bool mlx5_dev_matches(const struct rte_device *dev, const char *bus_name, const char *dev_name);
+
 #endif /* RTE_PMD_MLX5_COMMON_H_ */
diff --git a/drivers/common/mlx5/windows/mlx5_common_os.c b/drivers/common/mlx5/windows/mlx5_common_os.c
index bdafb95df9..e15a97677f 100644
--- a/drivers/common/mlx5/windows/mlx5_common_os.c
+++ b/drivers/common/mlx5/windows/mlx5_common_os.c
@@ -493,3 +493,22 @@ mlx5_os_wrapped_mkey_destroy(struct mlx5_pmd_wrapped_mr *wpmd_mr)
 	mlx5_os_dereg_mr(&pmd_mr);
 	memset(wpmd_mr, 0, sizeof(*wpmd_mr));
 }
+
+int
+mlx5_os_fill_associated_devices(struct mlx5_common_device *cdev)
+{
+	struct mlx5_associated_device *assoc;
+
+	MLX5_ASSERT(cdev != NULL);
+	MLX5_ASSERT(cdev->dev != NULL);
+	MLX5_ASSERT(TAILQ_EMPTY(&cdev->associated_devices));
+
+	assoc = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*assoc), 0, SOCKET_ID_ANY);
+	if (!assoc)
+		return -ENOMEM;
+	assoc->is_rte_device = true;
+	assoc->dev = cdev->dev;
+	TAILQ_INSERT_HEAD(&cdev->associated_devices, assoc, next);
+
+	return 0;
+}
diff --git a/drivers/common/mlx5/windows/mlx5_common_os.h b/drivers/common/mlx5/windows/mlx5_common_os.h
index 65394035de..a63e29f5f1 100644
--- a/drivers/common/mlx5/windows/mlx5_common_os.h
+++ b/drivers/common/mlx5/windows/mlx5_common_os.h
@@ -282,5 +282,6 @@ mlx5_os_interrupt_handler_destroy(struct rte_intr_handle *intr_handle,
 	(void)cb_arg;
 }
 
+int mlx5_os_fill_associated_devices(struct mlx5_common_device *cdev);
 
 #endif /* RTE_PMD_MLX5_COMMON_OS_H_ */
-- 
2.43.0

