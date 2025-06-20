Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C08C7115D
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 11:27:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77E6B42EDB;
	Fri, 20 Jun 2025 13:27:36 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 46BB942EC5
 for <dev@dpdk.org>; Fri, 20 Jun 2025 13:27:34 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11021100.outbound.protection.outlook.com
 [40.107.130.100]) by mx-outbound9-227.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 20 Jun 2025 11:27:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/TxLU83ip0AhDyF5OfwTeKPcL9pgWupXsXLHT3C1Lq191raSDqfi9iL6ydHfJReovefq/ytz7XOsulCRAw+6t02mszOQVZghaLvTJmoBj+aRAzwG+redjM+adM7O9M6yVp/GzKXf3fYQKARerymdnOpsDMEE5LIpB1J4G/t/kUXdcttf3DNCmDgVq8UQIwsq/8VZL95Sk8aLyUu3PYvCNEMzJQCVd7sO27ASgA8s4Mlu8Zz2k8hy6XosF2YF8sBLte+fj22yd9QI7PuUfzxvZDSKxJBDbu5lBpXvTNyiUdqzMRu91WfpLKujRYO0VK9baanJhjrlb/KmwLHI4MWzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVYCX7CrzjEBRuJYLFpP0Wh+hXRDy2KT/j5Z8c3hS4o=;
 b=d2640ORCExo85d3TOLzMpzAQFrfk1zMlY2WBujtpKqnv82k++SCq4ENT58ydyF15T/2aHuGWNBQ3XE25PRsxJRf1TledofY+ewB8Ynql4QlQpCSXhCwsLeW8HFxEVO+xKWF92cWtXpHFjYn/MetQTmwFpuOIEc3+hqenM/fd6uLxAroL8msyUGASX3JhhUWx+UR8kVXjSl+abX45DjQNuzTnWp9T5mCN8tEWszQFwKY3dqTJSU9v5B3dvfhaquZNO6nOE9fEhjT82dzSQo+lWjsDCxw675HU+ZxTAL8lxFSt15oA+XK9qdFCXi1aAPorj5EGQBccbaImxXGorBWvaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVYCX7CrzjEBRuJYLFpP0Wh+hXRDy2KT/j5Z8c3hS4o=;
 b=nZttKekjcUJ5L/fgU4JyJ2GSfNbWojKX9Av/q3kM28zS5i18zaXpJYwAwJa+61erYAUaFWe7u19iTUwiJD+aSlHHynzT/dSDHUjMih+g4K+/ZwVG5FN6CDUydgakxZmyUIqeYjyzjvYlpb8OvjmNK+ML7sAQiu4EdchLBs8nkWU=
Received: from DUZPR01CA0009.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::16) by PR3P190MB0972.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:102:80::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 11:27:31 +0000
Received: from DB5PEPF00014B93.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::47) by DUZPR01CA0009.outlook.office365.com
 (2603:10a6:10:3c3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.25 via Frontend Transport; Fri,
 20 Jun 2025 11:27:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DB5PEPF00014B93.mail.protection.outlook.com (10.167.8.231) with Microsoft
 SMTP Server id 15.20.8857.21 via Frontend Transport; Fri, 20 Jun 2025
 11:27:30 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 1/4] net/ntnic: implement start/stop for Rx/Tx queues
Date: Fri, 20 Jun 2025 13:27:04 +0200
Message-ID: <20250620112707.294596-2-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250620112707.294596-1-okl-plv@napatech.com>
References: <20250620112707.294596-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B93:EE_|PR3P190MB0972:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 19ebd79d-f8ed-4e41-d1e7-08ddafed7186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e0p6KHkDZC26VDx8RSPYAQeE18aCwNcz3nMDoX7GQQG3fceVVOsCk6Y8bqc4?=
 =?us-ascii?Q?JHqmRcxRZKukkKB6dtjUjLYb8wfiWg3uLMgOYX/y4usw5IttgkBVG3DKjJ9W?=
 =?us-ascii?Q?JKKFhc2gl5WfADM7bd6Za52bmr3zdhJw2EBP7ZVtfKGAKrrHV7SKRb5txXai?=
 =?us-ascii?Q?TxCjHR42EDNMIjfOAfplpMqog5l+/2qukAQgCZrtv3rVM3/jTR5gWgCC+jpe?=
 =?us-ascii?Q?hUrS/01VOVgSn6JmLQQEEK5SC3pgc2kdzWGsPtSrFRc6QuEFW8f7Ab6fbZgM?=
 =?us-ascii?Q?QlmPdUb9Qw2pBtNOWfovwFvZ1LKVHsp7GAsfyWMZatfwWvd+sb2DAIvID/82?=
 =?us-ascii?Q?wj+mLAdj/5V/M0Ya3NMdbxqjOEGXtqHcY6040h3F1jfaXq7paS6Ez9DUG4j/?=
 =?us-ascii?Q?1gRfOYbsr1e9pkWWCTWfK8ac5R3ZJhJ39CyZ3u/aOkIICMMlpyDEjRSC+VaG?=
 =?us-ascii?Q?gFvjJaQ7BSD+bvk2RYwXLsyIDz1MXtWA6mVjg6DHNYPLXgSpHgkweVst1Aul?=
 =?us-ascii?Q?xGLvd94L02/G2l4D4vSaoUaRBCl5ZFxq9vInjfU8bWPsfxwry4UpS2IVXz69?=
 =?us-ascii?Q?9nHd5oClKygH/H2aAMsGTXN5nkexn8CiJKL461GTnB9y4ktf0NyrN8poJ78B?=
 =?us-ascii?Q?qWrG5uhq/XficheKD/wPcevnwieERqDeF1GQy2L6ajQ62F9hiZ6wa2A6QfnY?=
 =?us-ascii?Q?TCWFI0sZ9OZiuzyz+9+3VkNDapwS0xrWk31IVMae2WpnW5izURS8OPciwLia?=
 =?us-ascii?Q?buoFkPiytZ69It7l4vZxDHd+gKoBl31nZHnCUQlxfObfVqkq0J1atuFlBvsU?=
 =?us-ascii?Q?LiH2/LVtdaDQI/bEAd4nuSNEjbBNSzZY4jEIiODwXqpTS00b54TzFIDZtA8J?=
 =?us-ascii?Q?M0m+a/rjiD8/5Jke1OmdODaluqeTA/LNOpNI9APAJLAq+yV4u6/8n0Na5j7o?=
 =?us-ascii?Q?KypT3Dgo1FVaVsvXq8AJd+punB+goUhsZcA3yBOCuAYSeW4oCvSPaKAXnjk0?=
 =?us-ascii?Q?3yJLENNvhOQUsFKfJJdksNizp8sitQ3I78ILUYlLl+l9jgidHubi4tQIlCg7?=
 =?us-ascii?Q?ynacp4cqLK0GkHhCAhmh0wloOQOT2zfLxtM6weHJCPtB9y63cyDYivKVtCKs?=
 =?us-ascii?Q?mnWDg+pS5fGwn8tZ5AcYtDG8VmTjTPMqx4WWlAZTbKKdBJsbJPx3ao3c3bEf?=
 =?us-ascii?Q?khJPCrYYUvTTTHeoOkBFnPno2qegyxR9sdO+fyOjk9uYqdv2Ig1aVhDALqkf?=
 =?us-ascii?Q?HjdxRUdOeS9pxnapJPOjHqqdWZ71pYx6oNagNjRfL+SySx1XkXDAeMrjfOdM?=
 =?us-ascii?Q?mZfwgAUc7y0LXzQ4l2KdUaYWCi9qciy9y7A5JamImb+2oQ2u9+6NnpTwqZKm?=
 =?us-ascii?Q?XJHCn5FifSizpYnmLtp6qFVj98LofheSLzoEgEDtI1Ky8fClqdl+8qXeZmku?=
 =?us-ascii?Q?fcde9K+jOqxZ9ijMr8FJ91RBkdBYgbAOrU3F/lz4GezI7/rU44+q07sjQ4rZ?=
 =?us-ascii?Q?EASaAMGjbxbqu4WOmeUh8on0X8VWkbjqNNQE?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nWREtc2iRrwjrJ5K9Z/l78cxYP65L1pzDwMzHT7lt7LlQssgyLLI3TczsGPxMJNTvPl+LYQuWh9dI4zsy/kO2kApkQ1UJnxVVktbIsa0wzzYS+kA5fdNkRnUODJ/ULXrh1ZP6o+w2SNbAdWCCbSuO1JuZQZ0ZeAO5r6rnhulOxNglvuuvx738Sw8LrAxjGphZt//DuZfvqmCGy7IO5HzwjybdhgSMNb2vcYm4vJJVlp9jpSSF8bVC1hqiTkH0hsrVIXRA3gQhxye9KicBHGP5uQGRzDq5UGzPU8mKldWYxCdFUVcQkT3v5fqnR/3/wFhrUxcSer3owNSRDScvZhgZCrTIW5yokkmLZEwBWEr088ifXk2gMOvTWSm9NmcUuSs3CdUbHLW5XSso7AUqBQTqDO7U0ed7ELwoRkkT082oMUVGtugTtNZCTVI20t/JWOAypiiubOGCSJvtYc9qrkwPMBeypfoAIglPq52S53yZTtSOLaPfAwUtK6uQcQFapsEiiHktRdHJqtLhTO8x6aWfENuWAbUANYA/MoHlGDXgD+lNzUXOHsLUE1kTOB5Q+MON2Ykx2GceQeMK/+sKvJZ2qIcnM7nEwPAuRUdDy0qNT8rdLMihoWj/WF5w0bijB11f0a7wHWZhgzzZgskrbA6Sy8CIQAnNz5hRHEkEFX9+jU=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 11:27:30.1720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ebd79d-f8ed-4e41-d1e7-08ddafed7186
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B93.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P190MB0972
X-BESS-ID: 1750418853-302531-7648-16395-1
X-BESS-VER: 2019.1_20250611.1405
X-BESS-Apparent-Source-IP: 40.107.130.100
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhZGxoZAVgZQMMXE0NIoyTLZOM
 XCLNnENC3F2DjJJMUs0dzQwtwsLdFYqTYWAFGMwx5BAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.265470 [from 
 cloudscan8-220.eu-central-1a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.50 BSF_RULE7568M          META: Custom Rule 7568M 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

The following functions exported by the driver were stubs
which merely changed the status flags:
*	rx_queue_start
*	rx_queue_stop
*	tx_queue_start
*	tx_queue_stop

Proper implementation was added to control queues's state.

Signed-off-by: Oleksandr Kolomeiets <okl-plv@napatech.com>
---
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c | 12 +++
 drivers/net/ntnic/include/ntnic_dbs.h         |  2 +
 drivers/net/ntnic/nthw/dbs/nthw_dbs.c         | 20 +++++
 drivers/net/ntnic/ntnic_ethdev.c              | 80 ++++++++++++++++++-
 drivers/net/ntnic/ntnic_mod_reg.h             |  2 +
 5 files changed, 112 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
index 94b0c97d27..0b049a8559 100644
--- a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
+++ b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
@@ -1115,6 +1115,16 @@ nthw_setup_mngd_tx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	return NULL;
 }
 
+static int nthw_switch_rx_virt_queue(nthw_dbs_t *p_nthw_dbs, uint32_t index, uint32_t enable)
+{
+	return set_rx_am_data_enable(p_nthw_dbs, index, enable);
+}
+
+static int nthw_switch_tx_virt_queue(nthw_dbs_t *p_nthw_dbs, uint32_t index, uint32_t enable)
+{
+	return set_tx_am_data_enable(p_nthw_dbs, index, enable);
+}
+
 static uint16_t nthw_get_rx_packets(struct nthw_virt_queue *rxvq,
 	uint16_t n,
 	struct nthw_received_packets *rp,
@@ -1419,6 +1429,8 @@ static struct sg_ops_s sg_ops = {
 	.nthw_release_mngd_rx_virt_queue = nthw_release_mngd_rx_virt_queue,
 	.nthw_setup_mngd_tx_virt_queue = nthw_setup_mngd_tx_virt_queue,
 	.nthw_release_mngd_tx_virt_queue = nthw_release_mngd_tx_virt_queue,
+	.nthw_switch_rx_virt_queue = nthw_switch_rx_virt_queue,
+	.nthw_switch_tx_virt_queue = nthw_switch_tx_virt_queue,
 	.nthw_get_rx_packets = nthw_get_rx_packets,
 	.nthw_release_rx_packets = nthw_release_rx_packets,
 	.nthw_get_tx_packets = nthw_get_tx_packets,
diff --git a/drivers/net/ntnic/include/ntnic_dbs.h b/drivers/net/ntnic/include/ntnic_dbs.h
index 247ae76d98..c35a7cb99b 100644
--- a/drivers/net/ntnic/include/ntnic_dbs.h
+++ b/drivers/net/ntnic/include/ntnic_dbs.h
@@ -267,6 +267,7 @@ int set_rx_am_data(nthw_dbs_t *p,
 	uint32_t host_id,
 	uint32_t packed,
 	uint32_t int_enable);
+int set_rx_am_data_enable(nthw_dbs_t *p, uint32_t index, uint32_t enable);
 int set_tx_am_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
@@ -274,6 +275,7 @@ int set_tx_am_data(nthw_dbs_t *p,
 	uint32_t host_id,
 	uint32_t packed,
 	uint32_t int_enable);
+int set_tx_am_data_enable(nthw_dbs_t *p, uint32_t index, uint32_t enable);
 int set_rx_uw_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
diff --git a/drivers/net/ntnic/nthw/dbs/nthw_dbs.c b/drivers/net/ntnic/nthw/dbs/nthw_dbs.c
index aed52f67f5..da64dbab48 100644
--- a/drivers/net/ntnic/nthw/dbs/nthw_dbs.c
+++ b/drivers/net/ntnic/nthw/dbs/nthw_dbs.c
@@ -618,6 +618,16 @@ int set_rx_am_data(nthw_dbs_t *p,
 	return 0;
 }
 
+int set_rx_am_data_enable(nthw_dbs_t *p, uint32_t index, uint32_t enable)
+{
+	if (!p->mp_reg_rx_avail_monitor_data)
+		return -ENOTSUP;
+
+	nthw_dbs_set_shadow_rx_am_data_enable(p, index, enable);
+	flush_rx_am_data(p, index);
+	return 0;
+}
+
 static void set_tx_am_data_index(nthw_dbs_t *p, uint32_t index)
 {
 	nthw_field_set_val32(p->mp_fld_tx_avail_monitor_control_adr, index);
@@ -680,6 +690,16 @@ int set_tx_am_data(nthw_dbs_t *p,
 	return 0;
 }
 
+int set_tx_am_data_enable(nthw_dbs_t *p, uint32_t index, uint32_t enable)
+{
+	if (!p->mp_reg_tx_avail_monitor_data)
+		return -ENOTSUP;
+
+	p->m_tx_am_shadow[index].enable = enable;
+	flush_tx_am_data(p, index);
+	return 0;
+}
+
 static void set_rx_uw_data_index(nthw_dbs_t *p, uint32_t index)
 {
 	nthw_field_set_val32(p->mp_fld_rx_used_writer_control_adr, index);
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index c2a507675c..d961edb903 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -1180,25 +1180,97 @@ static int dev_set_mtu_inline(struct rte_eth_dev *eth_dev, uint16_t mtu)
 
 static int eth_rx_queue_start(struct rte_eth_dev *eth_dev, uint16_t rx_queue_id)
 {
+	if (sg_ops == NULL) {
+		NT_LOG_DBGX(DBG, NTNIC, "SG module is not initialized");
+		return -1;
+	}
+
+	struct pmd_internals *internals = eth_dev->data->dev_private;
+	struct drv_s *p_drv = internals->p_drv;
+	struct ntdrv_4ga_s *p_nt_drv = &p_drv->ntdrv;
+	nthw_dbs_t *p_nthw_dbs = p_nt_drv->adapter_info.fpga_info.mp_nthw_dbs;
+	struct ntnic_rx_queue *rx_q = &internals->rxq_scg[rx_queue_id];
+	int index = rx_q->queue.hw_id;
+
+	if (sg_ops->nthw_switch_rx_virt_queue(p_nthw_dbs, index, 1) != 0) {
+		NT_LOG_DBGX(DBG, NTNIC, "Failed to start Rx queue #%d", index);
+		return -1;
+	}
+
+	rx_q->enabled = 1;
 	eth_dev->data->rx_queue_state[rx_queue_id] = RTE_ETH_QUEUE_STATE_STARTED;
 	return 0;
 }
 
 static int eth_rx_queue_stop(struct rte_eth_dev *eth_dev, uint16_t rx_queue_id)
 {
+	if (sg_ops == NULL) {
+		NT_LOG_DBGX(DBG, NTNIC, "SG module is not initialized");
+		return -1;
+	}
+
+	struct pmd_internals *internals = eth_dev->data->dev_private;
+	struct drv_s *p_drv = internals->p_drv;
+	struct ntdrv_4ga_s *p_nt_drv = &p_drv->ntdrv;
+	nthw_dbs_t *p_nthw_dbs = p_nt_drv->adapter_info.fpga_info.mp_nthw_dbs;
+	struct ntnic_rx_queue *rx_q = &internals->rxq_scg[rx_queue_id];
+	int index = rx_q->queue.hw_id;
+
+	if (sg_ops->nthw_switch_rx_virt_queue(p_nthw_dbs, index, 0) != 0) {
+		NT_LOG_DBGX(DBG, NTNIC, "Failed to stop Rx queue #%d", index);
+		return -1;
+	}
+
+	rx_q->enabled = 0;
 	eth_dev->data->rx_queue_state[rx_queue_id] = RTE_ETH_QUEUE_STATE_STOPPED;
 	return 0;
 }
 
-static int eth_tx_queue_start(struct rte_eth_dev *eth_dev, uint16_t rx_queue_id)
+static int eth_tx_queue_start(struct rte_eth_dev *eth_dev, uint16_t tx_queue_id)
 {
-	eth_dev->data->tx_queue_state[rx_queue_id] = RTE_ETH_QUEUE_STATE_STARTED;
+	if (sg_ops == NULL) {
+		NT_LOG_DBGX(DBG, NTNIC, "SG module is not initialized");
+		return -1;
+	}
+
+	struct pmd_internals *internals = eth_dev->data->dev_private;
+	struct drv_s *p_drv = internals->p_drv;
+	struct ntdrv_4ga_s *p_nt_drv = &p_drv->ntdrv;
+	nthw_dbs_t *p_nthw_dbs = p_nt_drv->adapter_info.fpga_info.mp_nthw_dbs;
+	struct ntnic_tx_queue *tx_q = &internals->txq_scg[tx_queue_id];
+	int index = tx_q->queue.hw_id;
+
+	if (sg_ops->nthw_switch_tx_virt_queue(p_nthw_dbs, index, 1) != 0) {
+		NT_LOG_DBGX(DBG, NTNIC, "Failed to start Tx queue #%d", index);
+		return -1;
+	}
+
+	tx_q->enabled = 1;
+	eth_dev->data->tx_queue_state[tx_queue_id] = RTE_ETH_QUEUE_STATE_STARTED;
 	return 0;
 }
 
-static int eth_tx_queue_stop(struct rte_eth_dev *eth_dev, uint16_t rx_queue_id)
+static int eth_tx_queue_stop(struct rte_eth_dev *eth_dev, uint16_t tx_queue_id)
 {
-	eth_dev->data->tx_queue_state[rx_queue_id] = RTE_ETH_QUEUE_STATE_STOPPED;
+	if (sg_ops == NULL) {
+		NT_LOG_DBGX(DBG, NTNIC, "SG module is not initialized");
+		return -1;
+	}
+
+	struct pmd_internals *internals = eth_dev->data->dev_private;
+	struct drv_s *p_drv = internals->p_drv;
+	struct ntdrv_4ga_s *p_nt_drv = &p_drv->ntdrv;
+	nthw_dbs_t *p_nthw_dbs = p_nt_drv->adapter_info.fpga_info.mp_nthw_dbs;
+	struct ntnic_tx_queue *tx_q = &internals->txq_scg[tx_queue_id];
+	int index = tx_q->queue.hw_id;
+
+	if (sg_ops->nthw_switch_tx_virt_queue(p_nthw_dbs, index, 0) != 0) {
+		NT_LOG_DBGX(DBG, NTNIC, "Failed to stop Tx queue #%d", index);
+		return -1;
+	}
+
+	tx_q->enabled = 0;
+	eth_dev->data->tx_queue_state[tx_queue_id] = RTE_ETH_QUEUE_STATE_STOPPED;
 	return 0;
 }
 
diff --git a/drivers/net/ntnic/ntnic_mod_reg.h b/drivers/net/ntnic/ntnic_mod_reg.h
index 9d14bebd7a..7f5bd5e0ec 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.h
+++ b/drivers/net/ntnic/ntnic_mod_reg.h
@@ -94,6 +94,8 @@ struct sg_ops_s {
 		int irq_vector,
 		uint32_t in_order);
 	int (*nthw_release_mngd_tx_virt_queue)(struct nthw_virt_queue *txvq);
+	int (*nthw_switch_rx_virt_queue)(nthw_dbs_t *p_nthw_dbs, uint32_t index, uint32_t enable);
+	int (*nthw_switch_tx_virt_queue)(nthw_dbs_t *p_nthw_dbs, uint32_t index, uint32_t enable);
 	/*
 	 * These functions handles both Split and Packed including merged buffers (jumbo)
 	 */
-- 
2.47.1

