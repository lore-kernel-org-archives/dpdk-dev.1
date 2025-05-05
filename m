Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF42C3ABB8
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:13:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E4A44067E;
	Mon,  5 May 2025 09:13:36 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 433524067D
 for <dev@dpdk.org>; Mon,  5 May 2025 09:13:35 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02lp2113.outbound.protection.outlook.com [104.47.11.113]) by
 mx-outbound18-65.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbftwBP9llWntIWQ7mTcFfgnGBTNNlKFKBzz66KfgPjl3z/D541uTi5JdNRfLSIPVi0Niv1+WLYVT8tzcWJXxuX8iBr7fowdLXAsAS6D4Lw+FSoqGCj4uy48ZWs2CEtVdAp6dFmf2MXPV1QHXIuPAsoPEDKhwtEbgzETWx/QJdhS9aII9+6Uo0Y9UhARNPRMBqiRN8R7Tazk8Zym1tK3xM6Lb+zOYaNaw5ylXaUPHwLDg+J3bafkMUy3XKjbovKE1tmAf80EmbxPTvJclfLLZ+1UBShMX7cHnI0c/58rE3JArkQAn8AwtLbBK/6m19pOFBpsJ+wYOtu+arC2y04M8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkibkoYxOsEtDxloQVMzg79QdnN3fmmv34u3+HabLuY=;
 b=qJZhvsJUijapC5hFNuQ5bN1QPPP6auL7jkv8IUGn+bHBiPOsFMeJftKF5jLpnZ8RvqV/XgiPKJj4Hf0hiil4ItMHSBj7FsyJ9S4U0H2OA08pMgkh9xbyzP6P/aY9lBk3MUEQ8oJLc1Gm14IWIRl5I3byI2faB47PDu+56SWKJYq7SVk70Dt/r8G5sROfDP1bPVF61bL98b8XbPXWYNUHNG4rzFAfERNHWG9+3bA4Ce0A0Cdq9ftM1L5T4Ox/47VlY+WgQPIYRN5ulINOpKHTNFuNEQcny/S7xBxB6/m3qN7kJNOEJ7g/9Af5b6ESJEb/upWTfXACfqWUEwSXnp7qXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkibkoYxOsEtDxloQVMzg79QdnN3fmmv34u3+HabLuY=;
 b=l3k30Gvj/XZaUkwr5OHXylUrg6xoeapVAzlko3Tx5eq+oF9M9D9qTUL0oCC8ST78AZUQ/enP309VHXeUgt2DLBQ+dJPY2E9MIsM8+cgsib7uC969q5f+HQDvwPyRVgMpUFj5RCyqdQo1s5H130kOe/Fnvb9OgsaU88arayQBDPE=
Received: from DU7P191CA0022.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::22)
 by AM9P190MB1236.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 07:13:22 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::8a) by DU7P191CA0022.outlook.office365.com
 (2603:10a6:10:54e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Mon,
 5 May 2025 07:13:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:21
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 13/26] net/ntnic: add error logging for hsh
Date: Mon,  5 May 2025 09:12:53 +0200
Message-ID: <20250505071309.586015-14-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|AM9P190MB1236:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8d210816-897b-4fde-c872-08dd8ba451d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z0EjrSP5z4vBtdOYYoVSd12eyJIhEP/4Y/zEzS3DLcuHiNSzXXxjW5rqdOuO?=
 =?us-ascii?Q?RcHK2HYZS6MA99WEyT96LZz6xVt7tKuD3dMPGQDchEpUSbujdpVc63lradFk?=
 =?us-ascii?Q?a7CU/1s614QAPaAxCBX6ZwyEQYdhcHuadGASvIAInVgh17VITPoC/ESyCNnv?=
 =?us-ascii?Q?W6NP6TAv3bbQx85mLHYXZZ/zqqgfHOZKDStyYPlqP+2SHSb3g2NK/DUx4mka?=
 =?us-ascii?Q?5WgqVRWg2UUNfPDFENV8heBMFbTP50lyM4CjWHq1DHnL3ISpH2lK+EiZEJAh?=
 =?us-ascii?Q?FnsINYJ9md86a83IP82OtBtzZ1sRQ+FV+JU237FQrH4ssaYjyEfCfZ1Vu/Yg?=
 =?us-ascii?Q?bb4JxRc/dxr9gTosBPCevsAxq/i18Cqm3NEbXsRadGG4NDbHd8HgkhhgzdfT?=
 =?us-ascii?Q?280N7A25b7lqZ+WOBPS/WzPe+MnUW/2cYlxtYHnNUAT/GZF9WRToDLN9sTmf?=
 =?us-ascii?Q?ajvbyFzd85Cid10bnu0DQilaffuKzzp/apXglr4cgZySu3mUmD9YmPMSf9bf?=
 =?us-ascii?Q?w6QVW2x6OvoLAgLe9p/IB7ijOvdXUqahLikR8O2UbkLFDmS3YuhHUB1LabLg?=
 =?us-ascii?Q?5dBzQ/PlNNkhN51+w/NaZTfXJUiCBuaL/bme0pOZrBtsPjLScfnXu8S5+37y?=
 =?us-ascii?Q?eAyVnCYKtu9NglQEM8NKCh32iZCleXbtBXBDWyPFijc0oDRuoZD2dV9X3ESA?=
 =?us-ascii?Q?/SnftoUZsIRH/R9iT1Xm+89DaGxCdNmW8zDL6K531xesn2ji4PrbxyNMofUu?=
 =?us-ascii?Q?Yp/2+0GzAZwm3npX+iZi8rN2IeA9v0nsdvAVjetHbcFj6sqQ/6ZiOeVNXWaf?=
 =?us-ascii?Q?GA+a8oW+Rl+xfZ2fqFD4Du9LPuL2YWYg70ODbDbp4l/xtE/E4zafz4QL2lFL?=
 =?us-ascii?Q?zp4C7hUAX9iwuzzafZP6fvSj+FOZfD+0SqUxiwMOKgEHlUe4qYMOR/lCbA+T?=
 =?us-ascii?Q?lH7g8CxiMwIpvQb8/ccIkdWyKo6oUgoGkXWR7hbYjpEyyit2rXaDWLHQeFzm?=
 =?us-ascii?Q?StnNmuS1kCeiljbsIqCkXaK19rVmjEgZGCP0+6nojSl4yhXyyLHYdPBy3pJm?=
 =?us-ascii?Q?yDWj6FZpurx11d8SyZgBsNp7cozITG2KdF9F2hZ0WnTm19BIWEDO0JTwvv7J?=
 =?us-ascii?Q?xHBShdWVCRJ6fyEIPoOw1lBvGH6bTnrmMcsXSIBEsDZNe+E0c0QcjxA3yut3?=
 =?us-ascii?Q?161p98nofG2S8obuKS59Voft9+mGyEGW0jU1sr3zRQuL2mpBJn/WEYKkyFti?=
 =?us-ascii?Q?iGuRorNYR2i3Ex5ZZZJ1VV9FyAmdqMoMrpcgprrkQGZmu/u/CU3hUJqrH18A?=
 =?us-ascii?Q?2VI8cXVQkk92SguxR0+sWd02lldrEZYLVj2atK6Qvf/Z02ux2bb1J4I2nBNj?=
 =?us-ascii?Q?+TSi5+q1W6+gGi2UHzyE72SLTufz/dXBSYUuS9x8+rmcTy4t43mkXiZgC7HP?=
 =?us-ascii?Q?d/qd7jI685CvdY0Dvews58HbMBWp0tPE4CVyJ8I19mbGz0nYynJ3Q4dAnnTD?=
 =?us-ascii?Q?zrGFQHpAInoYBmPkOZRc/I+P0cMy9QVdKXKX?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X+EDv+f/+c8LEqtyKJPPOK6BZHcix9ZiGRssb0v9LGmN3XWfUC9mU5BwVtytDXyqjnr0viIPI4dAwtGbRxv6fom+XfpHWnpcIKk7DDzWliYtCsTMq67SBi/Nie6uTPpjO9dT9afUXeXqSZczfKQ8t1ZXQP6VPepghrZFA8fQfUMt//6KNZ8GoFa9zHIZfJYQA0PWfcgUEg8i1H4XuKTV5lhE8VUSWIKCh65hiez3XxTfSbMCqwQzY/+meQqsPFTsg6HfRDV9XgltlJS8VvfAgS0GeUpWkPYX0cKCqLyhwnMa+xSToXqIya+KF3Y+rcAFkPfMnPZKTVRrKZH7VyvdJbDC9Z4S67Ty5/Ec3/IK0jtu32/smuxnW8QpAwXN7Wgbil7KkRrZA63aF0pqUZR5PqJrycUPgCqdFsJsYqH7xPgnZpwViU9le79OAkHxhzj4Z7MC0QewQSzw+8WfFKXD1lMxWW0oFBB4VhiDagFfYrgzVgmvjk4GOLAXeyVIMTVr+b3R5LShZAM1hu+eLluimaANShBEOhg/C6OCMKC1VbK3gcNlI3EPSuMX8Vb7ZzYopLFlYimXa9naB0n5LMwtfzwy+prIqim+oOeRBzqeADCx81ud2u+tqSzpz2EGzcbSoe/LAt7xs4xRMgUBboPt/A==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:21.8311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d210816-897b-4fde-c872-08dd8ba451d3
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1236
X-BESS-ID: 1746429203-304673-7666-376-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.11.113
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmZoZAVgZQMNnCNNnQMCU5xc
 Iw2czQ3NDYPNEwNSklMdnSMtUoydxcqTYWAA1qYs5BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264372 [from 
 cloudscan16-232.eu-central-1b.ess.aws.cudaops.com]
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

Enhance error logging in hw_db_inline_hsh_deref function to ensure proper
handling of HSH RCP preset failures.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../nthw/flow_api/profile_inline/flow_api_hw_db_inline.c     | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
index fbb7b04cd1..52ca79f104 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
@@ -10,6 +10,7 @@
 #include "flow_api_hw_db_inline.h"
 #include "flow_api_profile_inline_config.h"
 #include "flow_hsh_cfg.h"
+#include "ntlog.h"
 
 #define HW_DB_INLINE_ACTION_SET_NB 512
 #define HW_DB_INLINE_MATCH_SET_NB 512
@@ -2914,7 +2915,9 @@ void hw_db_inline_hsh_deref(struct flow_nic_dev *ndev, void *db_handle, struct h
 		 * it is not used by any flow
 		 */
 		if (idx.ids > 0) {
-			hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_PRESET_ALL, idx.ids, 0, 0x0);
+			int res = hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_PRESET_ALL,
+				idx.ids, 0, 0x0);
+			NT_LOG(ERR, FILTER, "Failed to preset HSH RCP %u: %d", idx.ids, res);
 			hw_mod_hsh_rcp_flush(&ndev->be, idx.ids, 1);
 
 			memset(&db->hsh[idx.ids].data, 0x0, sizeof(struct hw_db_inline_hsh_data));
-- 
2.47.1

