Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48201C369A2
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 08:10:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43A1A40B94;
	Fri, 11 Apr 2025 10:10:38 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2100.outbound.protection.outlook.com [40.107.244.100])
 by mails.dpdk.org (Postfix) with ESMTP id 8AB8740A67
 for <dev@dpdk.org>; Fri, 11 Apr 2025 10:10:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evxUkw5i/3a8LesYrojt10qDUyZ5FOSKeTGn+yA70PfDsPLTbrXVqbL46Vcbtg3fRipZRNpIiwUlwJvQ/DJh/+KG4LCy92LnHjye4oR7TAVrYvWwUK+N8ryUH9QaeZJN1+U890swOZbNGBycB3k6/aJI5yfPf92dy6mNA1j+0aitxrPcHH+Nz7oU7Sw+aJPlaBDtCITD+ATGqQXfKjaNG7wp8xlPWstNvRdJnYKRgrskjU8LAGp+WQs7W9lf6GwKxzNEo3Rk+VcfIqk6E/W5xtcpVLTLRj7rGOUzPhAH5PbD4MIQg1/M4DIYZNDyodUecIL5e7ecjMg9oL3Qlmoukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sNP6t+qlEBEvdIu7XRr2j03o43W7uOMtloYTE4OGbo=;
 b=vGQZgv/D/dkZpdR8Cpf1gB4IahX5erQcit8lt+ibHF39JehwLbaauzePYiK0I4tteALk7zRbn01CZID+cBpQchZ/nDf76bXP5Er8T2DDnQSPpOElCjwmA+9GdQyBcXNZ8ZtoA96i+7czezdXILi2fEiehQS/hXnpBdyMHOFMj04g33BK5ww4LsRpP9Bu0kzQU0f93/4oFcwcRNObgIN4SbgAczABVDQCuj9HJ1cLUZJRxtxszzUF1iq2tEM2c86cecKjNyyDCCF/1VoxbVqiUdQyMHDUW33Cs4bQJijJjpaAfg6J4QXpfBkcY4Cnb0lJbqQrya0MByAC8Eec6F6b4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sNP6t+qlEBEvdIu7XRr2j03o43W7uOMtloYTE4OGbo=;
 b=d6Xe/Ai00Is4AK9vO4yDNWn/lnjBe6rCzHYVsS+OyjDbv/BUBW7YfHak67EC3lsFEYwbJ2u/JQ9dbKwDESQVj+9rmZGll+qI6K8hpZ+8laHrVHm8efe/NEoUy7mPh6c2k2A41RF8BfPQPaHccSLYD2LsyUry0tTyDbQpaanBs2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5)
 by DM6PR13MB3940.namprd13.prod.outlook.com (2603:10b6:5:2a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 08:10:34 +0000
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833]) by SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833%6]) with mapi id 15.20.8632.017; Fri, 11 Apr 2025
 08:10:34 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: dev@dpdk.org
Cc: oss-drivers@corigine.com, Long Wu <long.wu@corigine.com>,
 Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH 2/3] ethdev: retrieve VLAN filter configuration
Date: Fri, 11 Apr 2025 16:10:04 +0800
Message-ID: <20250411081005.1133509-3-chaoyong.he@corigine.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250411081005.1133509-1-chaoyong.he@corigine.com>
References: <20250411081005.1133509-1-chaoyong.he@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To SJ0PR13MB5545.namprd13.prod.outlook.com
 (2603:10b6:a03:424::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR13MB5545:EE_|DM6PR13MB3940:EE_
X-MS-Office365-Filtering-Correlation-Id: 7825a9c3-765f-461d-3b49-08dd78d055e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7zY/EX49ZlKY5WErgTHhL2k+5gcb5V4TJoZEWTTNR7A53H7qgmPMGsYCqlv3?=
 =?us-ascii?Q?jOXSm7kfll+wkXFn8mEZrYMuwVr6PF8HeZVVcFTSLTOoBHy9W2bhOniktmbF?=
 =?us-ascii?Q?DiUS/7Higg41t4xJ/fk0kG/6JH754JI81OFhB0TFLgMgIJ/xwk1aK/sgBBYD?=
 =?us-ascii?Q?oqJEBlGx6/pGWkirvhaFVZ3uh2voEI4CTPm+aRR1ffUumsYS2bYcAC/N80/5?=
 =?us-ascii?Q?dByzka5nX5e6LwObuTU16Yl5kv+Nqz5XjA43j5VwZgP+H1vsM1u6T/aVFh82?=
 =?us-ascii?Q?A2d7D17qhLoVxDv1kb1OznvpDO2TVxt0GT5EKqEqwjXk0v7KSEUN5/NjABbx?=
 =?us-ascii?Q?2ccKKtPo1fE63SWq4mB/IvpcwOFQyHHQL2/hZVUX5jK481YwrLgaBH6Yryxx?=
 =?us-ascii?Q?m5PwKAGGSJM2ytKTFOywSYchWyIUoekKR2Srj5wnAXbUGuhcPdnEkURABZAs?=
 =?us-ascii?Q?BrbHt7+ZIiF9CButzFyrf1rsqJrHTqjUSRI+L68oPxnOFy2mAzO9bXAu9z4I?=
 =?us-ascii?Q?AsoUHoq8+woQlqk3iLo7NWygGYW48BBJyodfFfHs86VUfnUme5cHUpcLVLxX?=
 =?us-ascii?Q?AHo7862c1Lm+3sV119dS9Fksyt8KQ00GhazV2HdSUuzORSvuKAZE0MvrgaGV?=
 =?us-ascii?Q?PQUE+qgSsR3yisSOTemDiBOZwePx3yAjNTS0uIWzK5/Abcng2KKMCgwQfYyk?=
 =?us-ascii?Q?H5hF3btUYtkKo8px6frhnkjZIJiyTQSxdHkuJI3/sS7WQdR6WW5bn0H9fCUy?=
 =?us-ascii?Q?DbaNH0p4Xyqa2FAqL32k7RF1ueq8j3PqjdKtRaU62YWpxBhzPcNdwJDq1RKc?=
 =?us-ascii?Q?PNo61GFG5Xj3ajMmJL9DmvVXVf8kLTr8fJ3ZTtpHxxexoRj6Uc1jD0YoVka2?=
 =?us-ascii?Q?lKJt/eNnMCrO7pgtalYu4UAPon1MMvyAmHWO7sH1CenOT6bkb/l7jf/DY23n?=
 =?us-ascii?Q?L6aEhVQxA3tCK7N/xG3kPvPnpaqNRL8v4JAWYzbnma/YSrSKhl6vBn9MWgDb?=
 =?us-ascii?Q?fAdLDgdFSx4blq29bk6IfIyXCkmSLOfsBYOW3l0N2X32Z5aeQKUpgoQGVfw1?=
 =?us-ascii?Q?ML4AptqVZaSXE8XDCsX6iFvNyec6x5DYU5I3qQNP4qQg1UUB9OpVsFV64h7L?=
 =?us-ascii?Q?LUYv6d9A+YxQG15KxGsPSZyTjcs07UvmOwwdFSz8TRDGdjHiARco8t+rfq4l?=
 =?us-ascii?Q?d8cOdGd3iuENULOgIigBZhVZzqtGZjE19Px8xeYedbiuwRevhawlnaSQ+PoH?=
 =?us-ascii?Q?ykNCE+CME85ojsGGEC+3NnFgi62I5ag4uy3wSh8YRt6pP1x8OXoJVYwp5qOA?=
 =?us-ascii?Q?x7CwTR1tGwxQj6lTOwbzXuH+gNHLRJa0tf67s//jEEKsEgAlP08kDWzfgzAk?=
 =?us-ascii?Q?PR4ZM5YTWLWLfoGbKisrlPo64WvK0yOH/tE63DLAyb7a4w+mBI9gCcH/XbJF?=
 =?us-ascii?Q?/UTG7ykQH7U0x+x51/m84ztLbG4k4j4yQ/cLxZWstkHzpG9Tp1E6WQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR13MB5545.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S/x1M85FseoOyOEX1bFIGbohSNlXyq0+CRevJdn8+1kWP+6oPXP1NNqml1Ys?=
 =?us-ascii?Q?xW8Jx81ba9+9rjGoEvVYUNoeywpbuNiWGbExk5nFGE02ygu4IGZvTCZsnMeN?=
 =?us-ascii?Q?WJulch969fMRLUHMdNNBDjhF4eQsFFsGH4MfhDCLsQdkr0/VTGvi9cXtAPEv?=
 =?us-ascii?Q?rP4JgRrdjAUWIqetWUemGE5Sdg3tHo9zOrrjYX725By8jNWr+gkJ06iMXbPF?=
 =?us-ascii?Q?vOkVv1DHJomR/4BT9RVKOUsrPiywsHcL64QmxSYHSPFKrSa8/u7Tg637dmFu?=
 =?us-ascii?Q?OS8AzA6ahHrsRkPXNuQcxpTOIYSNTrPH+DE4nVpqsdWucpuvq9LQY11HpjEt?=
 =?us-ascii?Q?fhZFUwqVhBE3JDmrXejiFkuZzmLElDbo4Q/Cz3DphqCJe6xxZ8IJltKYHgdU?=
 =?us-ascii?Q?5k1fKJVDqaIpr+9cU+wPSaq+wbECjtb1uuV4jV/eLavmfpOcg8MZ6jJW8yk0?=
 =?us-ascii?Q?mq7DjNXRwcL0hvyI0RGO2kW31oLSpR9sIREPWnLR0/qXzSAVguKu3Y8hEY4c?=
 =?us-ascii?Q?hPC9eu0rrOXtJjfpESPTStJf01hSVDso25mhSUk16hJQ6CEmOrSobzYXphYx?=
 =?us-ascii?Q?27SCoy56GvSx856WT1x21hBju8+EPHGseKn1hGnkR7mFu2+j4g439LB3BYXI?=
 =?us-ascii?Q?xxlYt7T1L/2mKUsIFac3vfZDQ6nfjCkf1PFr4+Z7R2citINK3jQFjWd0sIbA?=
 =?us-ascii?Q?9UBbhPNgYdi8XKpPZ0siYajYfS2sx6xFX0c/P3xQ3Hq34RvnljqH/6HbwHn9?=
 =?us-ascii?Q?wQG1rwIfa2GR+s+vjVyCxhvGUKly+2iocIwGZM9gjhbYi3yLVukPspLWvSNL?=
 =?us-ascii?Q?EUwYHKPbgDS47UNRcmx5Xy53CuBD5SjRoZzllkLF6uMAWOH2yrSlEtV/d9/U?=
 =?us-ascii?Q?CR5Y3pdL7X1bp6SHs1IlAyGXnTSW7lF+t+RK8m3MqJrbdkU/FbCV0BaesteP?=
 =?us-ascii?Q?DouBvwWRn1TBbddxEiuoYJA1Y2l/GH+waA32xL1sSuQU+nmdqUbSJvjvtIZp?=
 =?us-ascii?Q?CYq9v00Rc/QyK2046OxIiL9kXttIh/YFSz4cuhMszJ7NmRlwqTbl9zD+axs4?=
 =?us-ascii?Q?XdT4T7N1sj4RDD1PBSRKArMeI0T77mN2utV20jfbOEv4BuHqZClOcBRV5qWm?=
 =?us-ascii?Q?xa9UEcmRIKPKu1p+rplLIP03G0dLby6uCsCqLsLjUz93iHUpNLhWoe6Airof?=
 =?us-ascii?Q?S3Zd7/hsFZnwIMYa1bZxYFPUPmNfvvN+sdeKmb4uTkJ/SxNP9ungOEghSNyP?=
 =?us-ascii?Q?xfiQwHvVKNCyOS+WXB9XJDiyBbo1Wl5yA21cNXXgkhpxOMAI7tLVSTzv/eHm?=
 =?us-ascii?Q?oCS3NR2t2cYbCb137wh16VtCWU+2e2w9sXfuWtyK3cbbJjhIvTVnK2k3C2tb?=
 =?us-ascii?Q?Oja0hTl+2aLvHcB7FWnlhyqT+Vyzknlef7xO4RbKNsoSxcwKdeevJ8EZ2dXC?=
 =?us-ascii?Q?fiVSc5Q4ALfPJq0I/5mtOebj+tD4UeDc34Tgz7NsbUViyC6TaPZ85GfNQ5LA?=
 =?us-ascii?Q?sl9j2UB4y+Lp55HqCxhPSeWHfWzsC2wey0CvRnBG2Wbx//wG3pgEBiiaxpru?=
 =?us-ascii?Q?RYQB/xZ9MzFZqulCpE5QkMCxH5LUmrDb5ZDh587vwvMOazZ4pyZDajvD80B0?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7825a9c3-765f-461d-3b49-08dd78d055e3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5545.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:10:34.7737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sItVkngr2DYvIiuakphsTImBKSdzhNH5L5WY9X2moHr+7bgLLkEaUmLNucsSnArn7rV5QIJ42JgVi1OT37I+9lbicMz5TBdshlgv/nondcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3940
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

From: Long Wu <long.wu@corigine.com>

Added an API `rte_eth_dev_get_vlan_filter_conf()` to retrieve
the VLAN filter configuration of an Ethernet device.

Signed-off-by: Long Wu <long.wu@corigine.com>
Reviewed-by: Chaoyong He <chaoyong.he@corigine.com>
---
 doc/guides/rel_notes/release_25_07.rst |  5 +++++
 lib/ethdev/ethdev_trace.h              |  8 ++++++++
 lib/ethdev/ethdev_trace_points.c       |  3 +++
 lib/ethdev/rte_ethdev.c                | 24 ++++++++++++++++++++++++
 lib/ethdev/rte_ethdev.h                | 19 +++++++++++++++++++
 5 files changed, 59 insertions(+)

diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 093b85d206..81d4c36f77 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added an API to retrieve VLAN filter configuration.**
+
+  Added an API ``rte_eth_dev_get_vlan_filter_conf`` to retrieve the VLAN filter
+  configuration of an Ethernet device.
+
 
 Removed Items
 -------------
diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h
index c65b78590a..ecea305c66 100644
--- a/lib/ethdev/ethdev_trace.h
+++ b/lib/ethdev/ethdev_trace.h
@@ -639,6 +639,14 @@ RTE_TRACE_POINT(
 	rte_trace_point_emit_int(ret);
 )
 
+RTE_TRACE_POINT(
+	rte_ethdev_trace_vlan_filter_conf_get,
+	RTE_TRACE_POINT_ARGS(uint16_t port_id,
+			struct rte_vlan_filter_conf *vf_conf),
+	rte_trace_point_emit_u16(port_id);
+	rte_trace_point_emit_ptr(vf_conf);
+)
+
 RTE_TRACE_POINT(
 	rte_ethdev_trace_set_vlan_strip_on_queue,
 	RTE_TRACE_POINT_ARGS(uint16_t port_id, uint16_t rx_queue_id, int on),
diff --git a/lib/ethdev/ethdev_trace_points.c b/lib/ethdev/ethdev_trace_points.c
index 071c508327..913a99f8c0 100644
--- a/lib/ethdev/ethdev_trace_points.c
+++ b/lib/ethdev/ethdev_trace_points.c
@@ -266,6 +266,9 @@ RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_set_mtu,
 RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_vlan_filter,
 	lib.ethdev.vlan_filter)
 
+RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_vlan_filter_conf_get,
+	lib.ethdev.vlan_filter_conf_get)
+
 RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_set_vlan_strip_on_queue,
 	lib.ethdev.set_vlan_strip_on_queue)
 
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index d4197322a0..a2c05594ff 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -4433,6 +4433,30 @@ rte_eth_dev_vlan_filter(uint16_t port_id, uint16_t vlan_id, int on)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_get_vlan_filter_conf, 25.07)
+int
+rte_eth_dev_get_vlan_filter_conf(uint16_t port_id,
+		struct rte_vlan_filter_conf *vf_conf)
+{
+	struct rte_eth_dev *dev;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	dev = &rte_eth_devices[port_id];
+
+	if (vf_conf == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR,
+			"Cannot get ethdev port %u vlan filter configuration to NULL",
+			port_id);
+		return -EINVAL;
+	}
+
+	memcpy(vf_conf, &dev->data->vlan_filter_conf, sizeof(struct rte_vlan_filter_conf));
+
+	rte_ethdev_trace_vlan_filter_conf_get(port_id, vf_conf);
+
+	return 0;
+}
+
 RTE_EXPORT_SYMBOL(rte_eth_dev_set_vlan_strip_on_queue)
 int
 rte_eth_dev_set_vlan_strip_on_queue(uint16_t port_id, uint16_t rx_queue_id,
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index ea7f8c4a1a..190fd4d3a7 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -3709,6 +3709,25 @@ int rte_eth_dev_set_mtu(uint16_t port_id, uint16_t mtu);
  */
 int rte_eth_dev_vlan_filter(uint16_t port_id, uint16_t vlan_id, int on);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Retrieve the VLAN filter configuration of an Ethernet device.
+ *
+ * @param port_id
+ *   The port identifier of the Ethernet device.
+ * @param vf_conf
+ *   Location for Ethernet device VLAN filter configuration to be filled in.
+ * @return
+ *   - (0) if successful.
+ *   - (-ENODEV) if *port_id* invalid.
+ *   - (-EINVAL) if bad parameter.
+ */
+__rte_experimental
+int rte_eth_dev_get_vlan_filter_conf(uint16_t port_id,
+		struct rte_vlan_filter_conf *vf_conf);
+
 /**
  * Enable/Disable hardware VLAN Strip by a Rx queue of an Ethernet device.
  *
-- 
2.43.5

