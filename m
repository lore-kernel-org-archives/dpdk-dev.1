Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B92CD6E45
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 07:29:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAB1C40395;
	Fri, 29 May 2026 09:29:39 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010041.outbound.protection.outlook.com
 [40.93.198.41]) by mails.dpdk.org (Postfix) with ESMTP id E9C9840608
 for <dev@dpdk.org>; Fri, 29 May 2026 09:29:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oe7i0PJm0oGjaTKO8qVV6yYhlDrMhpd4IPlVuNvdK6vYxS5wTO6vku3060hR6pk0CjK5YvhAZ4xsZgl0MM4xWAYpomQRCiQhEzzbHyj2+IVxBYhWSEb+t0eZm4QCUS7NnHXsTkAY+8XKX5sNzDatdejSdnNcS0cNMO+VZ8NZuRM5T0E2aN6e744Z3hsyLOaWwUgenC7Hp0i6WZSM038iaJ6cElESpboowQiWHSU3HtsjdQb/OEJxirSvIPICXyboAiOsn6a3SjEiCcmCmahsgjS60QpQSd+XQQjo+DO7gtfExRu+pL/o+sBckvNsI/qu/kxvSbhk0ARczJY8Szi7HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKNlBM5MdztNt9OgGOBSedDsJxC31XmVwcEcJBHhdds=;
 b=DSk3U8ZElotymtDAqYM1ZaPnS4JyLj6LW/pCSTzhVSlsXKaYk+BnFMB9xe2hKg+6p59Q+10WIxbIx5F19HPHQZhQEBqQK/DejHGGDn6wB0BBu1vTXGY2XEoBDV6VYBWVde70tBULhX0TUkYLO3ptxAHsoZG1XxaC2nid2xyc/JS+ieknJ69PazE1wKXspBOAZ0jcocUSozsIIbQ7ScEeF/BIBhJaVZosLWfIohwYPrYlBLGHynGsaxRskHVtGb7m/KIXmstn39ZGvbm8n8805xX981secDpf1gP7PhjlC5d+k9zYyUBssIrqwSB3096mS9pcfYvwBhn2mczDQpN+AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKNlBM5MdztNt9OgGOBSedDsJxC31XmVwcEcJBHhdds=;
 b=Xts4AQgj1049MYXZlQPC4YMCceb0LVI4jG3yBunUHIe4Uau6XUFEAJawl3Px/JxmpvfJimCx2ekBk5GaqnKtkfOFt5/vR5TR15lJ/ZC7yaMOsIka7/6cr1LengGCKHzffQJnVa/zi2fIAoPcmOWMXIuwyXR4Qm+/An5gGbx2DaqsxlxWNCVEO0jeYzqcSf2K/hahU3nFu+HV+gGSbVX7+YSCS3n54RrUn5hFfqQwZRKjQ44Kp7UAedlPA7VSiUjGnMdv5dLFCO+ol5SP/40B5t9VxY93Y+FmQgx3fSugCjIhvdAgb46BjQZ8S9P/nYcQApjamgwmE9NvJSXSCN9Gcw==
Received: from CH0PR13CA0054.namprd13.prod.outlook.com (2603:10b6:610:b2::29)
 by SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Fri, 29 May
 2026 07:29:32 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::9b) by CH0PR13CA0054.outlook.office365.com
 (2603:10b6:610:b2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Fri, 29
 May 2026 07:29:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 07:29:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 May
 2026 00:29:14 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 May
 2026 00:29:13 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Ori Kam <orika@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>, "Andrew
 Rybchenko" <andrew.rybchenko@oktetlabs.ru>
CC: <dev@dpdk.org>
Subject: [PATCH v2] ethdev: promote flow metadata APIs to stable
Date: Fri, 29 May 2026 09:28:53 +0200
Message-ID: <20260529072853.689683-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260527103246.633327-1-dsosnowski@nvidia.com>
References: <20260527103246.633327-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|SA1PR12MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d9bd06-ce8c-49e0-187e-08debd54067a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099006|11063799006|6133799003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: bETbq+mMVD2/J0Qjx8gBBZrcAokqSU4HpODoY+4XP3o7gtVuZycENJHhAhOEJiqiGU2eTCFzPKpGssUxvZ9guh1UisF2aoojHQ6rrVuffHQWw9l9TVxUttd0NILVxT+c5zumrDFG5jVUcyL7fFbeMRHvTaoVljT00aIgpKMyZnl8IuO1H3wXLeMF3FRdXA7lrS9Hcf7mo5QriCRtcteIDf7tG12qGe7cQ/UmLAdtx5umZFY2BkeuLoM4ZRw66/Xwh7xKHcr3cd2FM/H0+citrK2KAaV6OyrrBDffEY7sxiqh0e0G7K2VLhah4WtUsTzaTShE7dkm5jd7HkQGEf7SbsMPnqfXXw7CXZxADIakQKvYEJ5sJ4H/cvNGDfXAkSmtqbWY39HkEzmFag0j/hzLBgfv9QWsALLNqQGDnYt/d2xoc8jO0kL+VdCfkpQQFY9/v+xgkRAwOxLsTRLQFc8XhAHnX51wIGHjU6CdX8u6YegyvNtmXHt4M4Ige1R8bUUzsgaexzg9+p7aHpeXlcH+JOzrL/fp3rnOEz64v5CkY55XJa0pF4L8wA+IDdJUEtqFX3uf5r2+S4HYOYqQ8D8RBqBlNm5/a8D3gqQTUu6+JJdgJTfVLnkjy7SVWnPGEQAMXRmJV8vaHKgz4lI4NSlqp8/fQZ61JYfMAMVRisePZnHl/F0bSGvptvj2fPKFEjPC7ydHa8qjpfl4T1rMzxeFBluEbDg3LP7TxXlt2pK8EhE=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DFTuYlVWokgI3c5sGfoJgY/q+7SDdyhFE1VLCaAvGVuHgbwn7B+OjH/W4rLzvH87AVr49lX3U4dpZF1zHBIGbvMQHb/Qvi0tEeEkDzhyszbCwaBDnXYsP2/4euQoXQQEbpBKM9jcAz3ALbqT+oQkGgFWfQSwolP6EY+tPPbHyacMpFslnr86rQoHX7+zbEJHQHMGHGhq7h98qAC9M8BJ1lw2xMCBrToubTbHXYTsfqy8sJCadqwUU8wzGPvdqOBdK3Wzi4UPPSSw8Tdo70PMDT+OY+XKNX0mWy+tiTHf4IdAhCKRwoq7c+dKhF4vFB1FFPa5DX+zHhNFbVpMEoQTz8qvtKEARTTgGKq/Xjo0DsGCW3S+rNUPKg5ZNLN0egbDwAOmUJXy4OmuPiEtsFZ7MoUsYCo8q3iLbmqtHnQjHkrmOygq9AL/XYFUswgNYYFF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 07:29:31.5318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d9bd06-ce8c-49e0-187e-08debd54067a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8641
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

Following experimental symbols related to flow metadata
were added in v19.11:

- rte_flow_dynf_metadata_register
- rte_flow_dynf_metadata_offs
- rte_flow_dynf_metadata_mask

Type of rte_flow_dynf_metadata_offs was changed from int to int32_t
in v20.05 release.
There were no changes to these symbols since then.

This patch promotes these symbols and removes __rte_experimental
from the following inline functions:

- rte_flow_dynf_metadata_avail
- rte_flow_dynf_metadata_get
- rte_flow_dynf_metadata_set

All these symbols and functions will be used by netdev-doca
backend in Open vSwitch [1].
Stabilizing these symbols is required by current OVS policy
to remove the need for ALLOW_EXPERIMENTAL_API [2].

[1]: https://patchwork.ozlabs.org/project/openvswitch/list/?series=504726&state=%2A&archive=both
[2]: https://mail.openvswitch.org/pipermail/ovs-dev/2026-May/432066.html

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
v2:
- Updated 26.07 release notes.

 doc/guides/rel_notes/release_26_07.rst | 11 +++++++++++
 lib/ethdev/rte_flow.c                  |  6 +++---
 lib/ethdev/rte_flow.h                  |  4 ----
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 8b4f8401e2..6eba91a5e9 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -116,6 +116,17 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================

+* **ethdev: promoted flow metadata APIs from experimental to stable.**
+
+  The following ethdev APIs and symbols are no longer marked experimental:
+
+  - ``rte_flow_dynf_metadata_register``
+  - ``rte_flow_dynf_metadata_offs``
+  - ``rte_flow_dynf_metadata_mask``
+  - ``rte_flow_dynf_metadata_avail``
+  - ``rte_flow_dynf_metadata_get``
+  - ``rte_flow_dynf_metadata_set``
+

 ABI Changes
 -----------
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 7a51b667cf..ec0fe08355 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -23,11 +23,11 @@
 #define FLOW_LOG RTE_ETHDEV_LOG_LINE

 /* Mbuf dynamic field name for metadata. */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_offs, 19.11)
+RTE_EXPORT_SYMBOL(rte_flow_dynf_metadata_offs)
 int32_t rte_flow_dynf_metadata_offs = -1;

 /* Mbuf dynamic field flag bit number for metadata. */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_mask, 19.11)
+RTE_EXPORT_SYMBOL(rte_flow_dynf_metadata_mask)
 uint64_t rte_flow_dynf_metadata_mask;

 /**
@@ -281,7 +281,7 @@ static const struct rte_flow_desc_data rte_flow_desc_action[] = {
 	MK_FLOW_ACTION(JUMP_TO_TABLE_INDEX, sizeof(struct rte_flow_action_jump_to_table_index)),
 };

-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_register, 19.11)
+RTE_EXPORT_SYMBOL(rte_flow_dynf_metadata_register)
 int
 rte_flow_dynf_metadata_register(void)
 {
diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
index ba3bcc89a3..0c6d42c0d8 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -4253,14 +4253,12 @@ extern uint64_t rte_flow_dynf_metadata_mask;
 #define RTE_MBUF_DYNFLAG_RX_METADATA (rte_flow_dynf_metadata_mask)
 #define RTE_MBUF_DYNFLAG_TX_METADATA (rte_flow_dynf_metadata_mask)

-__rte_experimental
 static inline uint32_t
 rte_flow_dynf_metadata_get(struct rte_mbuf *m)
 {
 	return *RTE_FLOW_DYNF_METADATA(m);
 }

-__rte_experimental
 static inline void
 rte_flow_dynf_metadata_set(struct rte_mbuf *m, uint32_t v)
 {
@@ -4590,7 +4588,6 @@ rte_flow_dev_dump(uint16_t port_id, struct rte_flow *flow,
  * @return
  *   True if registered, false otherwise.
  */
-__rte_experimental
 static inline int
 rte_flow_dynf_metadata_avail(void)
 {
@@ -4607,7 +4604,6 @@ rte_flow_dynf_metadata_avail(void)
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-__rte_experimental
 int
 rte_flow_dynf_metadata_register(void);

--
2.47.3

