Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E11C8302F
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 10:20:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11D18402E3;
	Tue,  1 Jul 2025 12:20:37 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id AB73D402E3
 for <dev@dpdk.org>; Tue,  1 Jul 2025 12:20:35 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11023119.outbound.protection.outlook.com
 [40.107.159.119]) by mx-outbound8-231.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 01 Jul 2025 10:20:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAi4pUbXhDyi0LbrFg9yemb/NLqWGMSSMSLCenHL8Ifg984DYjnZ7kQDouiBaqFFwCRAUfFFu95vpXf5118jzSXNLgDwMtX2b9zXQp9d8Mlhe7rrd/cA7p+WSclm6MG2RVYNpygWsEmCdIEKiBWBi3ZHL986Nk3dC7Vnyxq7Nu7FtKhWVR3cfuK85/oq3ZcJDavSWzAZQTP0xB4upZcET1vKI4xAZqn49IMER+YkzkJF9NQGyF2m7o7uk87DBFI9HllkSKb9p83DqzIuaZLU/uwVoqbcuiUwfM/e4OzdLxks9KcCcbz3LsiAg+ItGb0g9PGi4l8tKIA8z0CRT14cPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+HoOazM+GNPpg1Jd5fIYJkZb2x/tWLXJWKKuZaipV4=;
 b=v/cWhMReC9fWgVTc50vp5iz0qeEvgQkMb/va5E3wRNXclMBRdrBseY7DqpkR0suL545sMTB+oi//thj/352UAiDsIDN8KPblZSSJnpmJs8AoVyJsEkR/8BInjN5ctNRk4mGhy+WKeu10o3H+twk2NmhcaO6LTCvEDYn1PjfzrtLMIgKaNiACbxzzWgNQU0FFWMjvOxf8GskaK0jntZSngRORoHkZEdyUjr+8T7drs3z6lLwoT2NxaZovmbgIB0R85nP4kLl8fpLzKDqEijhAgoDAkqZeZTUven/1pyNY9+yAQBc0sQQP1zbXUWnNT2wCtPKdaJ4sXFNbLmvX65dnyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+HoOazM+GNPpg1Jd5fIYJkZb2x/tWLXJWKKuZaipV4=;
 b=IGY2f3LBko+n0B4C5QHEV/axb+gidH/ZCF0daWhwGoLlABenWhYrBUlaNC5Utj6kIxaL/nslLrr6PxTcuo24oLzea3DLrdCQ7nHs/KRfhNwrb/4M/K3fHEo9rqNJp5VAziKtVyoPINu8S879J3d4vzG4b9HYFM4hpvQo9BIgytA=
Received: from DU2P251CA0027.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::33)
 by PA4P190MB1120.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:10d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Tue, 1 Jul
 2025 10:20:31 +0000
Received: from DU6PEPF0000B61B.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::7c) by DU2P251CA0027.outlook.office365.com
 (2603:10a6:10:230::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Tue,
 1 Jul 2025 10:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF0000B61B.mail.protection.outlook.com (10.167.8.132) with Microsoft
 SMTP Server id 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 10:20:31
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Oleksandr Kolomeiets <okl-plv@napatech.com>
Subject: [PATCH v2 1/3] net/ntnic: implement start/stop for Rx/Tx queues
Date: Tue,  1 Jul 2025 12:20:25 +0200
Message-ID: <20250701102027.3525524-2-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250701102027.3525524-1-sil-plv@napatech.com>
References: <20250620112707.294596-1-okl-plv@napatech.com>
 <20250701102027.3525524-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61B:EE_|PA4P190MB1120:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9c7363cb-2ff7-47e2-be6d-08ddb888e87c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nPlnTOWY0KT3ix9EVKUW5DeptXzVLNzjjhNsmmA/nWUEhhC9/52qelYm9BC4?=
 =?us-ascii?Q?m7lln2RRdk9sgT+HUJhROs3k6m+/NLnXR6dRisLELagMjrJBPr6JSt6J3aiY?=
 =?us-ascii?Q?eoDQkbFHh85zKjGaUd4fsyKTQHk8GqbSvC6ZN3NOi7T34Mo/pkjpk2QmfOe3?=
 =?us-ascii?Q?wxHMWBErFGhAgyvb/iIR21isRL9QqvXpxS/38UH4pVjU1N/hWbAstORREhx9?=
 =?us-ascii?Q?mPRwDk4l5lLnktcT/b57I1V//aRyxIIeJeVOAzPwfnhO0/rX71yzZ4PRpL1P?=
 =?us-ascii?Q?1qAEW6UAYI4Kf+pe/vKRBNtjELIMvyRTd+jjayZWsb8XH79dNZzgs3d+P5V4?=
 =?us-ascii?Q?HneQO5DAED7LgL8cLyycvVvO4Rqa+i3Qrba0cpI3OUZmMQBUulDq7mPCtnVP?=
 =?us-ascii?Q?BNABG71tVcOnKaoqx/WlWSzIfuhswY9qmOul3zepJdBH/Ao+bmFnZQb1KE3J?=
 =?us-ascii?Q?FMy39YxrGEJfcCxiTO5NbIQXq8bIQLwo5mAoRAWdNCU+SiHoFTCqY0GJiUNz?=
 =?us-ascii?Q?yDkqrGn4js48kYIr+VSxmg0ygwioERJKtnQ6Mr8sBzTx8J2IlMhfKWtXc3gN?=
 =?us-ascii?Q?9kFWCejd3gj7XzD+nn8C1UaxcC2qg+G6+kjgsSlULxLdabAfe6yCewQz9/UX?=
 =?us-ascii?Q?F9OSJLmwk3c00WogxNVHAqmk8JWLM8jK/wdVpfKopnFVdxTcyKwnXA2MGZYg?=
 =?us-ascii?Q?GaX6W4boBoX3C0R4IOFpCRnuhOpZLo/MBosIF6XEOYSq5Qw/srSLFK1ORyOn?=
 =?us-ascii?Q?nhrT+OdDmUgmdoPxBlke4Vo5JelbCZOJTqP1E4TeawzV5wrfmDXntZyBlpYu?=
 =?us-ascii?Q?a5tXHEC1ge5S+hWRV8l6RNMqJCYx28RiximU6JtWrX+9No2BvaZWy8gAeQh0?=
 =?us-ascii?Q?MkNUe6w6SLMAvcQxc9OeF8PZvgmKjAYHbVVGyT4II3xhjslfbRxsjxKOZlKN?=
 =?us-ascii?Q?tko0qXrQsFLp57pXZqmhZVwk0lvYHY3619dbMf10n16GLA/QDqq6LnBvwfhw?=
 =?us-ascii?Q?8tn8SInryfz5Wq5KP8Tj5LSbZWnvA7MTVpvrSIptv8p2ok0n1lArJIfLc2Pk?=
 =?us-ascii?Q?EE99u4Id2ZvrpwW52XgotxYcER8udHEdBbrVZGC1kfp6rGS5c/9F2WDDFfFM?=
 =?us-ascii?Q?N3bUYZO2YgZUYU4VEzlnWyGgThYCXGH81E7ZcZ4h5EP4m6thUAz+gHAi+Lh6?=
 =?us-ascii?Q?yxF3SFePNvThhTNpkpbfjaZzXbeEu/N+DcdU/EaqMK9xn8xM95+qqg0c7krj?=
 =?us-ascii?Q?m87rEfj6tasSLNfNNuvGPqWwCOiVDWjlL6oZ8MKOo5CKFy3pSPHF7h2DBGyK?=
 =?us-ascii?Q?pP6XR4jyAK1JkJmgJgAXHun1HuxLris8R4zf94zfGwXNng4bkhI/niELHpMV?=
 =?us-ascii?Q?M1M8jjHb7cxDe7BHLpQmf90VWymRHltVeZq3IM7WgvwZkj7Fln29X4IRUs73?=
 =?us-ascii?Q?xkTj+RpD0fBlTSX7zlQxtlGU0hLL7WBVSIJFClWbHuVKGCWU3YQ8H3P9kncu?=
 =?us-ascii?Q?wn0m26hyvskivGMQMj9TCkVzvxtB5q7T1DoQ?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ei+aeZxgv2WhIQFJT+oEvNldoS3mtHqTNX7lGNLVT5chSkLfHcIQZllVtJV1pzOt9vKJpk7Jq1YHc9POTvXZz5J3JhMyIr1TzOXmbY6NYytEI+3Ryo9JKpX+L3wfLsJaxRPKXfu0vJIcRA0+sP73Zak0dKFFLKbxIanh7lkDXThZuMufAq6vfFOsQvRZ52X4j/l04c6rIe8/MbLhZQsNPtYHZEZJL6Y3nFkNnSqlpt7UCnfhny9SXtBz6NAybJYLwXVW4q3BaeTMefTBLlVG5rzalT6lCkzFVlkmS1p1zoz00m2gxcyppGTXUxWAaUmAQGMGzzVwXFOlQJ/YVV7PHjrrL/i38aR7FFSxvhpvWTV1vrn466pfWap/c44rkHq3wx84bHM0NPNnuZk2i7sN6DQXYTZjEdHQbTOw1hwXgo8iAW5f6gtkXkNvd2pHYiYB2/jL3logdmRwsJg9XnKaS4o/6ahC9z5uK1OEg2aK/XRwzk5uvq2lnlWuvMkoDy8ceeELsFCJviNrNpcQCq4gbjT7tytFAyOcIsNaC1PtPnfea4gmBUqjDFe5r/3quvKfEKwgjizKwv/ExoOv0+Vb4dak9qcQ1XcsRi4nAQeLzCspUfOpZhQ17oK9AgEBz4k0r24ky2aX+zS7ptTc5I9gWw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 10:20:31.0253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7363cb-2ff7-47e2-be6d-08ddb888e87c
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1120
X-BESS-ID: 1751365234-302279-7676-865-1
X-BESS-VER: 2019.1_20250616.1856
X-BESS-Apparent-Source-IP: 40.107.159.119
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhZGFkZAVgZQMBXINkszNTROTD
 YxNzYxNTQ0MU9MNUqyNDYzTrM0NVaqjQUA83lYbkEAAAA=
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.265646 [from 
 cloudscan8-5.eu-central-1a.ess.aws.cudaops.com]
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

From: Oleksandr Kolomeiets <okl-plv@napatech.com>

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
2.45.0

