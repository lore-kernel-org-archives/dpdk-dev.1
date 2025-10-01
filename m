Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FB3CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 15:12:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 499C240ED4;
	Wed,  1 Oct 2025 17:10:42 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id A4FF740E54
 for <dev@dpdk.org>; Wed,  1 Oct 2025 17:10:38 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11023120.outbound.protection.outlook.com
 [40.107.159.120]) by mx-outbound22-252.eu-central-1b.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 01 Oct 2025 15:10:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgScq7K3wJtRxonYb77ILF8tPw3PZULNCFIPiShYu7NvqcNnV3Ay3oYyTQdbfm4uo1axaSotzeYnLS4BDeXpm2VGbAQFDdt9yl0dEWFn7zRlKuJR/kQ9SczqJET0dm2k1zHnA5oKsTL9nmw+bU/p6d6ewLMCexaDSXrOmx/1JLI5e24z4Py2kcAJAOen2QajrytBoEtaNszy3iTfawlv22bJl4feDjJEdDi32vl+5ZKsxecEnhutkhp6fJzIbaDiNRat/3LcNahLSZythDAj17XUraIThar9BMYTq4MW2J8KR5FINbDrbcb8ORGRyYAjN2xzLNgdlaodGYdWwWTP6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9Q23eD046qRmgVWxEOckjtuDJpVewlrSREG7uHEQR0=;
 b=AE/6BihQzw2GLMpjPzxo14c1NhXfl8B/tZxL9EZvs/Rk+IOxQzaJviVRno2Tey1778ERjAfxVjruzputcQcNv6b2Pgn/DBWdqzrd3Ur7Z6WitoxAZrNxZ4EKHahrM7jM6osy02oJxpd52UyQ4Ajch2uaC/rzTNzk8H1UAMjjOChUBf3wRytqwoG7cOGkSoVDWzPnXeAzwSFqtFlR8F55W4bfsPfVau7QXkRdHOPrA796rBA7TPSwvbejW78vw9Fz0PX8Boj0OoTlIrDYWHIrJJerLPeeB4C84rZu98rJXsb6Ih0GsM5zUT/TpWMNSFrFn4DW/NYyg/IVQScPeinSFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9Q23eD046qRmgVWxEOckjtuDJpVewlrSREG7uHEQR0=;
 b=dlcs61m/ELsZjndGm1sQlBvkEC/yBMpqhiUsec2ewGo6ZsA+28rGucNYUbDyUMj3zoRIgmhPuby/gPHYDexSD/J15qvzlqiVHxZyQHxPxYvXE2m5qHUTTppOoMaQZktjo7nBREJOLYWv80K+IhUsMYD6rUiu1P0wpuj68TeyPYM=
Received: from DB9PR02CA0002.eurprd02.prod.outlook.com (2603:10a6:10:1d9::7)
 by PA6P190MB2072.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:3c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 15:10:34 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::32) by DB9PR02CA0002.outlook.office365.com
 (2603:10a6:10:1d9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Wed,
 1 Oct 2025 15:10:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server id 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:10:34
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 14/20] net/ntnic: add handling exception path option
Date: Wed,  1 Oct 2025 17:09:56 +0200
Message-ID: <20251001151018.250671-15-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251001151018.250671-1-sil-plv@napatech.com>
References: <20251001151018.250671-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|PA6P190MB2072:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e162bde-0be5-4c11-2029-08de00fcabbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3FpeWdBNUlMc2tsckwyT2pFaXMrWXVaMElrYlp1aDM4aFh0czBQKzVTNkgr?=
 =?utf-8?B?OFRmSGtHL2pWaElJZ3p6OHYrR1dRbk45VmJXWW82RW9mMTc4dzR3ZitiUWxo?=
 =?utf-8?B?R0tsaUZZeS9yVkl1RzVHMUttN3dHd1l5NHVDNkxPblBDZEhCanNmU3JCbW81?=
 =?utf-8?B?MEo4R2pXS3pURW1NY3BrTXZVM21FZkdNTjQrNUNZZDVibjZncnVML2NMam5R?=
 =?utf-8?B?QkFGcXljSEhESXdTZWFGMklGVTVPR1N6c1VudG9IZ0Fua0dObEpoc3p6R3VK?=
 =?utf-8?B?NFMzUEswL0Z1VkVtNE8zSXZncmxFVVZoSi9CcTVPQS9PdEZyZzNKNFVKSXZo?=
 =?utf-8?B?TU5WS2MrbnZkcE85TkxrMkx6QWdoQm5VVnZ6bEYzQzYya3JJeFpHaldmOVQ4?=
 =?utf-8?B?aDFhaXFWb1VqRTZmREtFUVJvUXl4QVhzYWVCdS9vU1drWVB3OHArWVVuOEhG?=
 =?utf-8?B?TWFrcWNBbE1ZK3lINEttd296bmdzNms5NHZGL2hmZzNteEp1WURoc1l2eUpl?=
 =?utf-8?B?cjMxVkhwTmdQc21Pang1VmUySU0raG8vUEpTY0lzQmR3V1BMeXlLdkZKMis4?=
 =?utf-8?B?QXdIUjhMVU51Y1Z5VzdFNmVpK2VyUHZNaWZYL1B0ZFhJZnBqSFhqK0huYzVQ?=
 =?utf-8?B?a0poZ281R05iVDJvSTEwVlpzY01uZXhMenNobEZGYlZ2ZXFNdzVCdzBIYVlX?=
 =?utf-8?B?OEFUNmRtUi8zZnF4NmdSZjJpaG9uNHFvK2VXa2IxUXFjRjIzZFVnb2pDRVVo?=
 =?utf-8?B?NE9ZTFJDYmpaM3dlc0ZpVy96RjNoRWVIK3FkMStrdy84VU8vbGF5U05aM3Ri?=
 =?utf-8?B?OWRqY1JVRWhJME5NcmlDMzN3T2ZqNmlPVzBDSVZNVEVmMXlRRWNtd3E0eG9C?=
 =?utf-8?B?bzVqcnhreWgyQThlNytYWUhmbUh6a1dPM2lOVnhJQ1Q1QWYwVHdVNmI3L1cy?=
 =?utf-8?B?VXFPQ3pVWUljZElXdnppRXNPTS9QVDQzY1IzQWVUeDhBUVlvMzBSOHhQVldo?=
 =?utf-8?B?YkNqM3ZOcG1nMU1zUmk0akU4Q2dVSVdOazdsaXpvSnAwYjFxUy9sSnN3eXVR?=
 =?utf-8?B?cWFOMG5MaElBckh1ZlVQRFNKemt2Wm1QQXlsSDdESFZ4Zk5tM1dJM29ucHhT?=
 =?utf-8?B?QmZQY3RUNE5xTWFqWmZUMllQMmVCbmY5eFFiVWo0Mk05UWs2aC9zNTB3N2Vw?=
 =?utf-8?B?SUFOR010cEZDUDdEb0RqUDZwOXhSVXNCVVV2VytXOG1NOFZlbDVRaEpXaTRW?=
 =?utf-8?B?ZlA2MGJSNEJ3V1FCaXFsblFaOVhYY0JmNDBkTEdGclRnNS9ZcndEZkZTMmxD?=
 =?utf-8?B?VWNvaFVUT1lSSzlOTk5paTBvQlhGVnY2SXZPYXdOT05YRVR4Uk5ONzVDTHZi?=
 =?utf-8?B?YTA4OUI5b0lVK3Ryc2lmRDlCM0xPbFVSL2xVMWliMGtRRU5JVE1NZ2ZrNENs?=
 =?utf-8?B?QTJacVNZa0dqMzIrcHpvQ1JJMFF1akd1SXpCSWQ5YWRXa3VramtTWDZiS3c1?=
 =?utf-8?B?aEF2S2MzMnlnV21KdHVFTTczZVJZWk5oRmR3ckFTMC9idVhoWk53RXplRDlu?=
 =?utf-8?B?WEJIL2hTY3pJb3NRSm14MVlicGJlWVR6M0I0UWkyNjVIVlZGaVZxSlFyVGNw?=
 =?utf-8?B?dHg5bEZpSDdNc1ZqUmdUb0tpYm1tR1Zhc04weWNZbWtxVTRmQUtZL3ppVkpt?=
 =?utf-8?B?S1B6eUNSdlZqWnhqRjl1NFp1bTZGQUxGODNUV0RVdkJ1ekN5QkpaVURzM29s?=
 =?utf-8?B?S0thUnFmWDhsdDJmY1NZSkNUNk8vbmVVcHVKcnlnUGN0NzZ4L0t1QUNCcXBU?=
 =?utf-8?B?RWRlcjNoM2Z0SUUveG95ZXdHVWg5eGVlQTd5NS83bUp5M2Y0c1NIZ1lzRmRR?=
 =?utf-8?B?b3BKV1p2K0QrUlZ5blpzdHAxSTA5UlRNZlU3dk5TMmhmWTJoUTVYZjkyQUhL?=
 =?utf-8?B?SUVGb3VoMkQwUzNtZzRSMGZqbG1QYXRraUd6Qmd1SHFCbWRVbElQUHhOd3lX?=
 =?utf-8?B?NHMvRXZ5Q2lLcFV3V1VpME01WURJZ1VzL0QzREdHT1lUMWYrdy9jZHNubTBz?=
 =?utf-8?B?SVpWWHM4ZWo5YW13MXlkYjl6czBZVjlRMjBnK2lTWk96MDExVlpXMUtzdFVE?=
 =?utf-8?Q?cgFE=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X+JPhmDI8xuaFx8wCvZ/WGX+wfOHAezdJeTjelJXOkEHPNIVwsQSs+QLORJ7YHsnVScwqxBPSZCk85vIybhPzxQs38L5kBQvP6HSfU3k8L0qERiYskfLNN8ETxsN4PC5sZUVhPtu+puZHZ3CswIypNjFlhOc3SXRJkZ8pmu1DTBohnVAmSUSb2LG4uqNvAmT4T+gGdpgNA0mnpUgHIXuyaRw4N1CUD3NBYI6MqSecxLXqCIoZsrOKvNGeRoz+8XcO/vcGEM6TgOSEX0bHzSvJtEx2ZsbBpcdOkkbCUfSE+q/hrXKHk5kD2YpJjFTXPKkF3/+8XH3fBEYecu0jdnKUPupHu3m0fVrbbtiZ00yrpKV0EuZwfCAP+AVGCtJ0hxmZ/2RPlEhpPGqlTmO6HtNCVZe1HDkuYVqAYFOimfpVAMUAgd1twfMPYCzAxStVE0sZDXyea6j621DuXKfv4XMZPKqPXm3VQLIX2fKandYjVhWyBmxrNt8ZA/Otrqc0oGG+U9pFJh6DYlcHKxyBkaEIqB3nBvgDVhNsbhmwq25S3W7vDiH5IOQyVIcUdOMfXgeshHY+T8pcD4nTI4KG+Dbc343Ov0z6pqzSIDW8/1waXYpWmnZgu0gUkExT5XbZJe5ks/Xs3D6SabTTy2Q6NtPqA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:10:34.3814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e162bde-0be5-4c11-2029-08de00fcabbc
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6P190MB2072
X-BESS-ID: 1759331437-305884-7641-4391-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 40.107.159.120
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaG5oZAVgZQ0Mwg2dLU0tIg2c
 zA3DDNNCXVLNXIwDLF0sg8ycjQ2NxCqTYWAHYa/19BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267892 [from 
 cloudscan16-167.eu-central-1b.ess.aws.cudaops.com]
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

Enable exception path for unmatched packets to go through queue 0.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 doc/guides/nics/ntnic.rst        |  9 +++++++++
 drivers/net/ntnic/ntnic_ethdev.c | 21 +++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/doc/guides/nics/ntnic.rst b/doc/guides/nics/ntnic.rst
index 5375d89a2d..01b6dca652 100644
--- a/doc/guides/nics/ntnic.rst
+++ b/doc/guides/nics/ntnic.rst
@@ -136,6 +136,15 @@ Multiple arguments for the same device are separated by ‘,’ comma.
 
    By default, the value is set to 1.
 
+``exception_path`` parameter [int]
+
+   Enable exception path for unmatched packets to go through queue 0.
+
+   To enable exception_path::
+
+      -a <domain>:<bus>:00.0,exception_path=1
+
+   By default, the value is set to 0.
 
 Logging and Debugging
 ---------------------
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 01b3fe00ef..29508888a3 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -73,11 +73,13 @@ uint64_t rte_tsc_freq;
 #define ETH_DEV_NTNIC_HELP_ARG "help"
 #define ETH_DEV_NTHW_RXQUEUES_ARG "rxqs"
 #define ETH_DEV_NTHW_TXQUEUES_ARG "txqs"
+#define ETH_DEV_NTHW_EXCEPTION_PATH_ARG "exception_path"
 
 static const char *const valid_arguments[] = {
 	ETH_DEV_NTNIC_HELP_ARG,
 	ETH_DEV_NTHW_RXQUEUES_ARG,
 	ETH_DEV_NTHW_TXQUEUES_ARG,
+	ETH_DEV_NTHW_EXCEPTION_PATH_ARG,
 	NULL,
 };
 
@@ -2260,6 +2262,25 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 			NT_LOG_DBGX(DBG, NTNIC, "devargs: %s=%u",
 				ETH_DEV_NTHW_TXQUEUES_ARG, nb_tx_queues);
 		}
+
+		kvargs_count = rte_kvargs_count(kvlist, ETH_DEV_NTHW_EXCEPTION_PATH_ARG);
+
+		if (kvargs_count != 0) {
+			assert(kvargs_count == 1);
+			res = rte_kvargs_process(kvlist, ETH_DEV_NTHW_EXCEPTION_PATH_ARG,
+					&nthw_string_to_u32, &exception_path);
+
+			if (res < 0) {
+				NT_LOG_DBGX(ERR, NTNIC,
+					"problem with command line arguments: res=%d", res);
+				return -1;
+			}
+
+			NT_LOG_DBGX(DBG, NTNIC, "devargs: %s=%u",
+				ETH_DEV_NTHW_EXCEPTION_PATH_ARG, exception_path);
+		}
+
+		rte_kvargs_free(kvlist);
 	}
 
 
-- 
2.45.0

