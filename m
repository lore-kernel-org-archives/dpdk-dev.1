Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A912ACAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 15:12:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E06840ED0;
	Wed,  1 Oct 2025 17:10:44 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id CBF5240E4C
 for <dev@dpdk.org>; Wed,  1 Oct 2025 17:10:39 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020093.outbound.protection.outlook.com [52.101.69.93])
 by mx-outbound40-101.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 01 Oct 2025 15:10:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAw6gdIgCxVl15DVJh4ASVfYKqY7fQ4T1Y7hYkG7psYGPBpnzLupehjubf5pShgCF/tOYXCJa+pV4OWF1ekHuODYIw6Ts7Qstg7AR9HHd+Sgp38lfUBjfuGUk0etipVky0zew0ervJTB6h7H/oV7nWAdi/rpDMkBSInfy/6i3pdq/4QADAj0iNYVsDqnu/sM0kM/TNuof58rpyFloTV+YjpeL9WtXTcDhvE9oSI4AYxcw1m8lJDrbH5qhyp/vKEOHh0w1vel65J5sQ658rsh+H9pHWX7YcE0KmNXwA8rvkow4lsxyUw6YPNTimHV4R530hc9eySWYde3sLmzfARJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsMF0K8yyM9OZXYV5n6DAcIF3JAYzM1DbTsBuWaQMLU=;
 b=OiqAkMXDIcvRNSj4VTqBIKEpfxxZMvtaZGVuPeXxnYcTmQRBvfChBpxLDTikJpb9YAtopE3QXQToodcSDrhvIuz5HqvkIQxNGskv9WMSlTN+J5oftJuNJl6rk2oSgB2r7O1S/6vF4q2+LVX+HN3pznqYAvjcWMJc8CxxZicb/BOCenNowJ6MjtzERNw4RarGQMsc2l8nrv3JBFdmJ96yM1y1tiUTPNCgPzaaAhH5jT0ZeAIFz64A2mrB15Y9V/ke0oVT5wTMnqXDI2ztHd0mAES76g10v4ikszSZM2Nv60nTM1apmiF3ziZZHLijuWmegCxfeDUrKb1kl+36ieP7Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsMF0K8yyM9OZXYV5n6DAcIF3JAYzM1DbTsBuWaQMLU=;
 b=EVXiY5W3C+hlTKxrgdaWVWYceUMFzGCRrcd1GM4eEF+nvRpkmzqWdAz+QcvKxNiict8a3wsnLZIiqTYyLB2VQoGFgV/anh5z7HBU5J4tsVpfKoC8xSXBXyjXphglPsGdLW89HC+W3fnPvvUDuM8gWiynt0rtTkL+iyRN6owehLg=
Received: from DB9PR02CA0009.eurprd02.prod.outlook.com (2603:10a6:10:1d9::14)
 by GVXP190MB1944.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 15:10:35 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::26) by DB9PR02CA0009.outlook.office365.com
 (2603:10a6:10:1d9::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 15:10:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server id 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:10:35
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 15/20] net/ntnic: add flow query with count action
Date: Wed,  1 Oct 2025 17:09:57 +0200
Message-ID: <20251001151018.250671-16-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251001151018.250671-1-sil-plv@napatech.com>
References: <20251001151018.250671-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|GVXP190MB1944:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2e88c60a-9cd1-452d-85b1-08de00fcac36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d/4vf3P7gX3NTxY/Oj2hAbzTQrqfuB87Jl9wxPX7MOzfwk8Hic7vocqIBr1X?=
 =?us-ascii?Q?sqvytqF6+olHuuqj3dHsEHUsUzECF2eWw/JgBmwtLy/JA/XyePpgZawJAKFt?=
 =?us-ascii?Q?WDN7cpti23fx13PkOJAMflHFvElOQ4fi3xSx8rNfgTJvpzceXiqRsq72RKxv?=
 =?us-ascii?Q?PTkO7wPZuPebAqb3vH/jXy6LKbQ5M57GhXOIOiqKPk5z2+R/WLldcFU077Rb?=
 =?us-ascii?Q?qM+aLO4xGTp8LbjcuiVcm/GfUTR+S9G1flbxGFEtvLPK/CbxoSOgF3qxk0fI?=
 =?us-ascii?Q?NYlVw90KzKM+kWirZBTn9pc5nhO4GSHW2aOFVVkYZ3gko3SHbUygwopxPWwY?=
 =?us-ascii?Q?d3dputZ3uGSKr3SNlIcMwy71G77nBqinPEV6xfZW4vVn5jp6SBb9FG/u2v/k?=
 =?us-ascii?Q?hUPPn+i9RltomrKcgEesU0leBVKBpK1itMHFgHp8giAdtC8ygT9M+VN/boO6?=
 =?us-ascii?Q?I5M58IQh2G2h/vJyLNtfjNoyxyMcMK850uWr5C/DazZEDoybqf/SJ9I8dqGA?=
 =?us-ascii?Q?KWww1mDHp3/Cmse2Qfw4zC7t6+j5AfkLAhjAVfzCX4NMNVWxpP/EBMXaztNF?=
 =?us-ascii?Q?JnEKE68ygJReFHD3RIGW5MxqBaGi3UJdonm8v1wqrx3ZV1d5qv2Bd17MRvIw?=
 =?us-ascii?Q?JlaWQdaq6C7bIilEgwvNMjTYPqRwt9FvedVe3U3Av2KtPM2L08ytV8txgdVI?=
 =?us-ascii?Q?dZVxe6anV3iLxtcQ6vlcU43YLjmAzKtCbHhITeyHjStww+O1Zux4WONdru6M?=
 =?us-ascii?Q?O34c8UvVEAyyDlLM3dQAF2t50kgcAaWxxBPBrChRyxM5bTsr3ZrB11rA1KVy?=
 =?us-ascii?Q?R14i9STGnLdcUmjhcw+daEcuhximGxpx7q7Vn8neABfAyywYuH8fVQ3w/EJx?=
 =?us-ascii?Q?9YHvcvdVTy93T/F1UEhFaE/mJrVSlxI1N8prj3bi7CSj+tjmNBJ3+tWoZBZp?=
 =?us-ascii?Q?YQb0DfA/7xjc5T+dQR9EE/WqOiK78DMH/uZZqaqZk7AL3Vn94HSs+wMJ3Ezz?=
 =?us-ascii?Q?B3yV5epcRDyRM7rLTHufQZ+yVKxmJIIUpk3zOqG7ci+5zRg6sFHHLMARxZLF?=
 =?us-ascii?Q?2IFILefg3626bRCIQSVLHQOAB+C78BqZLbQv8HC5pZTLREvex9gyU169u5/7?=
 =?us-ascii?Q?mackxVP0hp5lBQJL1d0+oUc1b2VuMq2nR2GXXmvt7s90/nhIxT8IaLfEcQP6?=
 =?us-ascii?Q?Hn7G48a7rMiBsWZi4KZ3qjXtbXDrv5DUl9q00yu+GXEc9JJHsNCjIUPy7VnX?=
 =?us-ascii?Q?YDxuhdyluHWlcyzYqp4EjjwgXk878VHgIruYMTAAP1vg7H66ZKxDiOkWyTQL?=
 =?us-ascii?Q?8kkaL/0pSV8fgDJPIW0NYihMtQFHh/y71l5e2pFIoVQgHQHQr2oPHwq9xgbC?=
 =?us-ascii?Q?A9xoCSzrsc/akGOVW1rWG5gusWDduM/C5y1YLAFQCc2GCmVwhngkaf0yghzE?=
 =?us-ascii?Q?AOv30cpmE99qEfMYpvRpY9WLh4BpxQ7DF+ZkvzTPRhUHWODn7y8CxOZtX/sA?=
 =?us-ascii?Q?r53kcrQMgXWXyTaTQWCv0mM6DjuBhLBUhV4ZwlaBq4ucWRyjr1QsR6U7BvXn?=
 =?us-ascii?Q?lTJWPWo5uBzeZgNdnKU=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: O80sCqa9TonBsBPaNYXpWf726yIDaBUOEnnUNZb1KjRrnKZanmi1O5TQ8FEW7yDrWhFTJrKmEOc6YrOyOf7wpzczFa92ocGSIgR30KjU8uKn4vqAESSyuYQPpbMylrs5XBl0XTMXVc6wuK30voTHNOQiiXoo8n1UjKMWc7RSN1AgueR0EjbfFVva8mrL5bxZBzTeQ2QGWAEkl/WXGJ8rXvxNk7E9SJZpDYtsaekYQMnhKJOisu1ft31ehwc1V1JEj7kKG9WycZygtgTXWsS/gpZlORfPTHUndrFB3p8m4vltd/hWhQQC37H2kNgd4Fo9MdlgAlkEe2yb//Ljn+pe+AQj/3/Jz7NA/7AejnZqE+GO86NBaipI329jPKH5Qed8aYiKMuLVxn0bRAdG1Xv/NpbZNHSJ8mtyF86gw3o/9B1GACuK+dEsXde9fsPYohAzY9DDLQxnQq6uDZnxr3NtZkzMIDaDcUuNroDuBB4eSarcdpL5qvRKENUtzrw+9mspf0KbD4+07FyFrSE+Dby0VBfOpfJChCpvmHnbxEYE4vSf/iDowuOW1U1RW1IGHPscJ1YzqPX7ISQg0l1CYyE3+ogadpVxTBo8MnTzJefymtDjhBybXwCmYiqaEBCptfCi7wKCs39bhbZEdmbr2cWy4A==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:10:35.1855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e88c60a-9cd1-452d-85b1-08de00fcac36
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP190MB1944
X-BESS-ID: 1759331439-310341-7709-4283-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.69.93
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkZmZgZAVgZQ0Nwi2djEyMTU2M
 AgxSDJzMDExNDMyNIiySTRMCXVJClVqTYWAExVn59BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267892 [from 
 cloudscan19-185.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
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

Implemented the `eth_flow_query` function to handle
flow queries for ntnic driver.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 doc/guides/nics/features/ntnic.ini            |  1 +
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c | 46 +++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/doc/guides/nics/features/ntnic.ini b/doc/guides/nics/features/ntnic.ini
index 1bf9bd76db..a5aadf33ee 100644
--- a/doc/guides/nics/features/ntnic.ini
+++ b/doc/guides/nics/features/ntnic.ini
@@ -35,6 +35,7 @@ vlan                 = Y
 
 [rte_flow actions]
 age                  = Y
+count                = Y
 drop                 = Y
 jump                 = Y
 mark                 = Y
diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index 813ac04481..124d9a5b67 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -1285,6 +1285,51 @@ static int poll_statistics(struct pmd_internals *internals)
 	return 0;
 }
 
+static int eth_flow_query(struct rte_eth_dev *eth_dev,
+	struct rte_flow *flow,
+	const struct rte_flow_action *action,
+	void *data,
+	struct rte_flow_error *err)
+{
+	struct pmd_internals *internals = (struct pmd_internals *)eth_dev->data->dev_private;
+	err->cause = NULL;
+	err->message = NULL;
+
+	if (is_flow_handle_typecast(flow)) {
+		rte_flow_error_set(err, EFAULT, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL, "Error in flow handle");
+		return -1;
+	}
+
+	poll_statistics(internals);
+
+	if (action->type == RTE_FLOW_ACTION_TYPE_COUNT) {
+		struct rte_flow_query_count *qcnt = (struct rte_flow_query_count *)data;
+		if (qcnt) {
+			if (flow) {
+				qcnt->hits = flow->stat_pkts;
+				qcnt->hits_set = 1;
+				qcnt->bytes = flow->stat_bytes;
+				qcnt->bytes_set = 1;
+
+				if (qcnt->reset) {
+					flow->stat_pkts = 0UL;
+					flow->stat_bytes = 0UL;
+					flow->stat_tcp_flags = 0;
+				}
+			} else {
+				qcnt->hits_set = 0;
+				qcnt->bytes_set = 0;
+			}
+		}
+	} else {
+		rte_flow_error_set(err, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION, NULL, "Unsupported query");
+		return -1;
+	}
+
+	rte_flow_error_set(err, 0, RTE_FLOW_ERROR_TYPE_NONE, NULL, "Success");
+	return 0;
+}
+
 static const struct ntnic_filter_ops ntnic_filter_ops = {
 	.poll_statistics = poll_statistics,
 };
@@ -1299,6 +1344,7 @@ static const struct rte_flow_ops dev_flow_ops = {
 	.destroy = eth_flow_destroy,
 	.flush = eth_flow_flush,
 	.actions_update = eth_flow_actions_update,
+	.query = eth_flow_query,
 	.dev_dump = eth_flow_dev_dump,
 	.get_aged_flows = eth_flow_get_aged_flows,
 	.info_get = eth_flow_info_get,
-- 
2.45.0

