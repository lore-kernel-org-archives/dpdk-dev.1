Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A767CCD1AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 16:40:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A509E40262;
	Wed, 22 Oct 2025 18:40:37 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 0E7554025E
 for <dev@dpdk.org>; Wed, 22 Oct 2025 18:40:36 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020112.outbound.protection.outlook.com [52.101.69.112])
 by mx-outbound9-130.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 22 Oct 2025 16:40:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTBtYSHDlpk+SekRCUedxpDAPgtpvB8nptkSDLZHXoPwjp6Me3R57YpJEu6Erpd3CADq5dSdJ96s+U95Nu8ehRfDC9i4WOKeW6yDs+bozw+TOiczqiX7LHvIsUUx36pQiEXEUF9IgnVP6wVH3hnuTtAExBrImSW3XGgjOKZWLuhkzmUyyiKnjv9WzzfwAftJT7xK+Yisla0+zloCnsO8ui52sx/iterV+WwV6u0lD6OVz5JV2awY9XjGspPNYeL5B8ux1c9zhsjE1ik6tqRCNjpDLGd01qcNSVoLSe+SI9r/Nbri3k2H2qQkMsAIplUbrCe0VHjnCNQWxnOb/kU/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ta9K52q33EaTJ8kmf9DE2lRHaDWLK4396Ntu91WtbI8=;
 b=UGA07O8Ict29vF0gIHDLdL0Ey3IRzRz70ElqZWXG4gAi3sWzzDA1ZrGZAsT4wtd38u3zUGmq0RyddDoP2cYZHeRaYRi5mQ0xts+DFUYPjo/pdpNCtfCqTpYwxziOwW2luYYKaMflEHEze2QK3niUyKCo0yD6D8EEv/DAl+Xdpl8ggjpINFDSFAhP6g169mcvD8XVPh+5pCCdvpJP33KbBxQGKUjCVfgPaHBOTy+3N8Vxmp+5tPNoDdAucJJtyu4sUy2Sd69+QyBquowEFueIWEti9ckrHb1zb6luOU+//sQd95L39ljZAhPy/OGVjn8Aj3jzFaXAvdYKVAQYuheAiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ta9K52q33EaTJ8kmf9DE2lRHaDWLK4396Ntu91WtbI8=;
 b=AOT8BATQ7DHlXTwGjG4pF2dPbLRBYYVUPBerKIqr5J9RkHsJ+nFNKjckDsAioyl9ehRA+6FDkAG4ThP6aecMLkomm3WTw+k8EuP/WcRR5ErDa3XLMb6Qq7nECX0qYZWJ2XuAYaB6T/Vt5rHhRKr7UtVOsxvYSHmPEB3sjaYjoFI=
Received: from AS4P195CA0013.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::16)
 by PA2P190MB2101.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:40d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 16:40:30 +0000
Received: from AMS1EPF00000048.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::3a) by AS4P195CA0013.outlook.office365.com
 (2603:10a6:20b:5e2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Wed,
 22 Oct 2025 16:40:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS1EPF00000048.mail.protection.outlook.com (10.167.16.132) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 16:40:28
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org,
	thomas@monjalon.net
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 1/1] doc: refactoring the guide for NTNIC PMD
Date: Wed, 22 Oct 2025 18:40:14 +0200
Message-ID: <20251022164015.507050-2-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251022164015.507050-1-sil-plv@napatech.com>
References: <9256303.5OynTdThKG@thomas>
 <20251022164015.507050-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000048:EE_|PA2P190MB2101:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a6d203-1787-43b7-1eb2-08de1189b5c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y01mQXZjd3l4eW83ZGdhWmQ5NU5FTW1RMnhJaVh3aVRpMnNYZGRnZDhIV0hP?=
 =?utf-8?B?TUN2QnJPQkdMeDVCTTgraHFLckdseVBLZmhISVBGM0Jxd0xJNDdveDc3RTZ0?=
 =?utf-8?B?SUswc2FLY3BKeDVvTXJxcWRvTE03SEVQQWI0L1pLemZoZ25iRHhWcmRIaFNO?=
 =?utf-8?B?eWtreFJwTDRjR1VWTEpOTE90U3haT04zcncrU3hhYzRxWnJtTGIxcXRuTGV1?=
 =?utf-8?B?eHpVYkxTSXVkYnRZSDRMMisxUmllTTh3ZlU2NDN1UEhqbm9YVE4yNkN5MHRY?=
 =?utf-8?B?RXVmekswRS9uUTF0Q0o5azBsd2prT1NxUW43Z2JjZjl2Z1R1d3lobTFmNmcr?=
 =?utf-8?B?RXRVRUVVVURPOXkrWXFSVUJsVXhkRkYya0tlSDRQMFU4MXlyZWNzWGdUdjZz?=
 =?utf-8?B?eUJhZmtubWYvTmxhbmZhWEdxdUpjZ1huNSszWU1OQlVjTFg4YWQ1cFlITXBz?=
 =?utf-8?B?UUFEUWUybURyM2dudlZFTTJYamtsTmE0MnZBaHBvaHAzdlY2YmRaL0twUWE3?=
 =?utf-8?B?UnNMa1dXczd0L0psODhiWXJKRXRpU3NvSG1HaTFJUHVrNUJEUVdiRWdKV1Zu?=
 =?utf-8?B?WU16UWY5SXJpUmxFL2tCakRPZWltcTc3NzV0MkJEVG9yUXY5U3ducVhZSUxK?=
 =?utf-8?B?bHpZKzBOOUd4SDdwMkhNaVJtbDRtQW45djg5U2kyN0p2TDRyaEdtNW1BQWxi?=
 =?utf-8?B?UUNMQS9HUTRXYVZLeExHdkRkdHRKQVgwN0VvVngrTVlxbEtrVWQyRzlqc21k?=
 =?utf-8?B?K0pWMVVIaGdIVEZ3aTRVbDU4WWhrdk8vZVUzNDlZU2ZRWnZ1eUpkdGxpNDRC?=
 =?utf-8?B?b3NadHllOE93Sk9LcEVDaVljZFJyTHVPYWVYVzc4clNYQ1AxN0NkbE82bHgz?=
 =?utf-8?B?aUp1ZXpkWEVDR1FTS2VjQmI3MHVQc28raXRoZXpocXlwS0dKd0R0ZjhLNm9B?=
 =?utf-8?B?Zms5VnhvZHUyMUx6WWkzZnBsNythMlB1cHpaUEIwaFd2eGRWUDRoOFc5aTFW?=
 =?utf-8?B?Y0IyWXh3cEtwQlAwRFpFUjkyd3JwSmJhbC9hL3RRYWlkbUhQYVBKamFaSTdl?=
 =?utf-8?B?OEdSemdhb0R3UStNVFhhVVcwY0FjQkF1QkhnY3d6cmdYSWY2R3lPWGN6Tk5s?=
 =?utf-8?B?Y0lGQUcyWlV1ZnBLT3U0U1VGYzBCMi9qY3VYVVV6U0pIaVgwUUZ2cTJnUlhh?=
 =?utf-8?B?UUpKa3VKcjZuN01LQytMZmlERlZxSElBd3VzRWJvQWw2NGthYXk3aG1BN2lk?=
 =?utf-8?B?OHFKbHhTN05UYmk2S09ESjZlRlBYQlFidlhDOE1vSG96RWZlYUQ2UE9MQmZw?=
 =?utf-8?B?UjVmSWd0M0ZxUUpCWUF0aHJPdkRsVU1OUWxYZnY4a2FFbzNlejhkSDl5aG9D?=
 =?utf-8?B?WjlFampHazZaYXA4MkFzVURtUmxwUC94MTd2MGhhUStnNWhrMzNKUEl4MzhB?=
 =?utf-8?B?a05lSncxMHh4TFB2dmcvcXAzbGVoMjlkWm5nNFF1a1lPL2xjblFXZFZrQlF3?=
 =?utf-8?B?a0U1VEVUSU5wZDl2RmJjaHlDLzFqVWNEL0JXUzNXeGwybXoyZnlKcSttY3JI?=
 =?utf-8?B?VkorTmFwNEJidjYzUCtrLzhFVTZaNHpKRnl3VERCTWM5THNvRit4Ymt3N2pP?=
 =?utf-8?B?TS92RnkxanRQL2Z2WW5idlc5QXFJNVhDeFpCTXV4U1EvNjlMZWpRZ0VHcytE?=
 =?utf-8?B?RXBxVUVhWGhRaTRDQ2VBZVo2Zk1vdXBEWFY3dFAvOTJ5K01xSjBKS1c1NUcx?=
 =?utf-8?B?Vml5UFoyc05rb2JabW8wT21TaTBuenVJMm5OMmdBVkEvZHNPT3laNEk0OEt1?=
 =?utf-8?B?by9LTklMWXNKQXQwQVNRS3R1UE5JcS9YL3dabTFpNnl1VWkrdC9LTkF2RTMv?=
 =?utf-8?B?ZlBzTmlOQWtFVmFXVWhGNkxIMGlRZ09lOHdPdUREWGNaajhFeGhBamc4Qnpm?=
 =?utf-8?B?T0J1VGZWemdHRHFvNXpXeTZyRCtUaC9VSmlTcUUzbXNOM3RYdkgrbS9MaUFR?=
 =?utf-8?B?ZXJieFZxV0FpRWF2RzFCcGtkRm05RXZ4aTFaZE9BdENvOE9FajBtZmwrV2Qr?=
 =?utf-8?B?NXZLenBGOHRzcUEwdERSemVFWHJ2MW80QXRjaG9MTjV1RDFaZUtta0cwWVJK?=
 =?utf-8?Q?U7m4=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YvBlEcgGistCFwWBc4DLvTnMOI3XckkpRXDRY5SbsmeT/9zLg8qisck49AjE/Kw/R0cQdAmYhxuqMKR9Z1yQJ0Sn6cDfCTk9mJ7L39gu7HExMVgFppJwdiYsTr/kFgbahwSAq6io39ioLKdfNXPN1TzIYxL+VSgZzAMHPUs40DWUReVxylrUyrbncmI1T6pAwUqFoYXIyaqt9P9XNcl1Gm+3Mx0Gp3KQSiT/YT12gxcAagxkar/VCU+iHjfIWfvN/xRfaGLYP8CKM5zRBCPEpNSqS4Ph9CWG5fis2kkR9CAM90SbqIkBl/9myW4kp7X9AfMhl0lUC790hznWTm70wp5lWNYErRj/xzqwUmlkPSo5BaUvTVP1NW4ktFZj/bUcxVFsYFRus4cknwdZqaWK5CVq/N+ZMegDBZOC9aAoQ8rsJKtoarCUXzM36QeR27viyL0yTvMcO9wfUfjX9Hj66nZ1LRbPkIoIZlIGnTJ/zkV4Ies+caI1MVWCu/iMEH40A3ZP2kjmZwiNvLKWFNPHmoAOyqNBB3G0QOroi1V+7k5+sOUtHz/WwcoypuPJ9JJqQ1qUaKjITLoiUZc801N1fo4xRDVKgFl09vOuYFj3zxvpG0ckREphPHKbFzNYKfC4TNzeZbJ8X36MdEV4xR/LABtMb5mUXngzmtA5KO8b1Co=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 16:40:28.9919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a6d203-1787-43b7-1eb2-08de1189b5c7
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P190MB2101
X-BESS-ID: 1761151232-302434-13312-13937-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.69.112
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobmpgaGQGYGUNTQ1MTA0NDSxC
 gt1Sg1KdUyxSI1NdXSwsIy0dzcwDjVVKk2FgBVL/0lQgAAAA==
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268396 [from 
 cloudscan17-132.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
 0.01 BSF_SC7_SG0146_1       META: Custom rule SG0146_1 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC7_SG0146_1
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

Improve the doc formatting.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 doc/guides/nics/ntnic.rst | 262 ++++++++++++++++++++------------------
 1 file changed, 140 insertions(+), 122 deletions(-)

diff --git a/doc/guides/nics/ntnic.rst b/doc/guides/nics/ntnic.rst
index 01b6dca652..48f0e55c52 100644
--- a/doc/guides/nics/ntnic.rst
+++ b/doc/guides/nics/ntnic.rst
@@ -4,7 +4,7 @@
 NTNIC Poll Mode Driver
 ======================
 
-The NTNIC PMD provides poll mode driver support for Napatech smartNICs.
+The NTNIC PMD provides poll-mode driver (PMD) support for Napatech SmartNICs.
 
 
 Design
@@ -23,66 +23,66 @@ The physical ports are located behind PF0 as DPDK port 0 and 1.
 Supported NICs
 --------------
 
-- NT200A02 2x100G SmartNIC
+================== ================ ================================
+SmartNIC           total bandwidth  FPGA id
+================== ================ ================================
+**NT200A02**       2x100 Gb/s        9563 (Inline Flow Management)
+**NT400D11**       2x100 Gb/s        9569 (Inline Flow Management)
+**NT400D13**       2x100 Gb/s        9574 (Inline Flow Management)
+================== ================ ================================
 
-    - FPGA ID 9563 (Inline Flow Management)
+All information about Napatech SmartNICs can be found by links below:
 
-- NT400D11 2x100G SmartNIC
-
-    - FPGA ID 9569 (Inline Flow Management)
-
-- NT400D13 2x100G SmartNIC
-
-    - FPGA ID 9574 (Inline Flow Management)
-
-All information about NT200A02 and NT400D13 can be found by links below:
-
-- https://www.napatech.com/products/nt200a02-smartnic-inline/
-- https://www.napatech.com/products/nt400d11-smartnic-programmable/
-- https://www.napatech.com/products/nt400d13-smartnic-programmable/
-- https://www.napatech.com/support/resources/data-sheets/link-inline-software-for-napatech/
+- `NT200A02 <https://www.napatech.com/products/nt200a02-smartnic-inline/>`_
+- `NT400D11 <https://www.napatech.com/products/nt400d11-smartnic-programmable/>`_
+- `NT400D13 <https://www.napatech.com/products/nt400d13-smartnic-programmable/>`_
+- `Napatech FPGA-based SmartNICs <https://www.napatech.com/support/resources/data-sheets/link-inline-software-for-napatech/>`_
 
 
 Features
 --------
-
-- FW version
-- Speed capabilities
-- Link status (Link update only)
-- Unicast MAC filter
-- Multicast MAC filter
-- Promiscuous mode (Enable only. The device always run promiscuous mode)
-- Flow API support.
-- Support for multiple rte_flow groups.
-- Multiple TX and RX queues.
-- Scattered and gather for TX and RX.
-- Jumbo frame support.
-- Traffic mirroring.
-- VLAN filtering.
-- Packet modification: NAT, TTL decrement, DSCP tagging
-- Tunnel types: GTP.
-- Encapsulation and decapsulation of GTP data.
-- RX VLAN stripping via raw decap.
-- TX VLAN insertion via raw encap.
-- CAM and TCAM based matching.
-- Exact match of 140 million flows and policies.
-- Tunnel HW offload: Packet type, inner/outer RSS, IP and UDP checksum verification.
-- RSS hash
-- RSS key update
-- RSS based on VLAN or 5-tuple.
-- RSS using different combinations of fields: L3 only, L4 only or both,
-  and source only, destination only or both.
-- Several RSS hash keys, one for each flow type.
-- Default RSS operation with no hash key specification.
-- Port and queue statistics.
-- RMON statistics in extended stats.
-- Link state information.
-- Flow statistics
-- Flow aging support
-- Flow metering, including meter policy API.
-- Flow update. Update of the action list for specific flow
-- Asynchronous flow support
-- MTU update
+.. rst-class:: punchcard
+
+================================================================================================================ =======
+Supported Features                                                                                                Linux
+================================================================================================================ =======
+FW version                                                                                                          X
+Speed capabilities                                                                                                  X
+Link status (Link update only)                                                                                      X
+Unicast MAC filter                                                                                                  X
+Multicast MAC filter                                                                                                X
+Promiscuous mode (Enable only. The device always run promiscuous mode)                                              X
+Flow API support.                                                                                                   X
+Support for multiple rte_flow groups.                                                                               X
+Multiple TX and RX queues.                                                                                          X
+Scattered and gather for TX and RX.                                                                                 X
+Jumbo frame support.                                                                                                X
+Traffic mirroring.                                                                                                  X
+VLAN filtering.                                                                                                     X
+Packet modification: NAT, TTL decrement, DSCP tagging                                                               X
+Tunnel types: GTP.                                                                                                  X
+Encapsulation and decapsulation of GTP data.                                                                        X
+RX VLAN stripping via raw decap.                                                                                    X
+TX VLAN insertion via raw encap.                                                                                    X
+CAM and TCAM based matching.                                                                                        X
+Exact match of 140 million flows and policies.                                                                      X
+Tunnel HW offload: Packet type, inner/outer RSS, IP and UDP checksum verification.                                  X
+RSS hash                                                                                                            X
+RSS key update                                                                                                      X
+RSS based on VLAN or 5*tuple.                                                                                       X
+RSS using different combinations of fields: L3 only, L4 only or both, and source only, destination only or both.    X
+Several RSS hash keys, one for each flow type.                                                                      X
+Default RSS operation with no hash key specification.                                                               X
+Port and queue statistics.                                                                                          X
+RMON statistics in extended stats.                                                                                  X
+Link state information.                                                                                             X
+Flow statistics                                                                                                     X
+Flow aging support                                                                                                  X
+Flow metering, including meter policy API.                                                                          X
+Flow update. Update of the action list for specific flow                                                            X
+Asynchronous flow support                                                                                           X
+MTU update                                                                                                          X
+================================================================================================================ =======
 
 Limitations
 ~~~~~~~~~~~
@@ -103,76 +103,86 @@ Command line arguments
 
 Following standard DPDK command line arguments are used by the PMD:
 
-``-a``
-   Used to specifically define the NT adapter by PCI ID.
+NTNIC-specific arguments can be passed in the PCI device parameter list:
 
-``--iova-mode``
-   Must be set to ``pa`` for Physical Address mode.
-
-NTNIC specific arguments can be passed to the PMD in the PCI device parameter list::
+.. code-block:: console
 
-   <application> ... -a 0000:03:00.0[{,<NTNIC specific argument>}]
+      <application> ... -a 0000:03:00.0[{,<NTNIC specific argument>}]
 
-The NTNIC specific argument format is::
+   The NTNIC-specific argument format is
 
    <object>.<attribute>=[<object-ids>:]<value>
 
-Multiple arguments for the same device are separated by ‘,’ comma.
-<object-ids> can be a single value or a range.
+   Multiple arguments for the same device are separated by commas. The
+   ``<object-ids>`` field can be a single value or a range.
+
+- ``rxqs`` parameter [int]
 
-``rxqs`` parameter [int]
+   Number of Rx queues to use. Example:
 
-   Specify number of Rx queues to use::
+.. code-block:: console
 
       -a <domain>:<bus>:00.0,rxqs=4,txqs=4
 
    By default, the value is set to 1.
 
-``txqs`` parameter [int]
+- ``txqs`` parameter [int]
+
+   Number of Tx queues to use. Example:
 
-   Specify number of Tx queues to use::
+.. code-block:: console
 
       -a <domain>:<bus>:00.0,rxqs=4,txqs=4
 
    By default, the value is set to 1.
 
-``exception_path`` parameter [int]
+- ``exception_path`` parameter [int]
 
    Enable exception path for unmatched packets to go through queue 0.
 
-   To enable exception_path::
+   To enable exception_path:
+
+.. code-block:: console
 
       -a <domain>:<bus>:00.0,exception_path=1
 
    By default, the value is set to 0.
 
 Logging and Debugging
----------------------
+~~~~~~~~~~~~~~~~~~~~~
 
 NTNIC supports several groups of logging
 that can be enabled with ``--log-level`` parameter:
 
 NTNIC
-   Logging info from the main PMD code. i.e. code that is related to DPDK::
+   Logging info from the main PMD code. i.e. code that is related to DPDK:
+
+   .. code-block:: console
 
       --log-level=pmd.net.ntnic.ntnic,8
 
 NTHW
-   Logging info from NTHW. i.e. code that is related to the FPGA and the adapter::
+   Logging info from NTHW. i.e. code that is related to the FPGA and the adapter:
+
+   .. code-block:: console
 
       --log-level=pmd.net.ntnic.nthw,8
 
 FILTER
-   Logging info from filter. i.e. code that is related to the binary filter::
+   Logging info from filter. i.e. code that is related to the binary filter:
+
+   .. code-block:: console
 
-        --log-level=pmd.net.ntnic.filter,8
+      --log-level=pmd.net.ntnic.filter,8
 
-To enable logging on all levels use wildcard in the following way::
+To enable logging on all levels use wildcard in the following way:
+
+.. code-block:: console
 
    --log-level=pmd.net.ntnic.*,8
 
 Flow Scanner
-------------
+~~~~~~~~~~~~
 
 Flow Scanner is DPDK mechanism that constantly and periodically scans
 the flow tables to check for aged-out flows.
@@ -202,46 +212,55 @@ There are list of characteristics that age timeout action has:
   and its aged-out status will be reverted;
 
 Service API
------------
+~~~~~~~~~~~
+
+The NTNIC PMD provides a service API that allows applications to configure
+and manage PMD services.
+
+Primary service functions:
+
+**nthw_service_add**, **nthw_service_del**, **nthw_service_get_info**
 
-**nthw_service_add**
-**nthw_service_del**
-**nthw_service_get_info**
+Services handle vital PMD functionality such as:
 
-The NTNIC PMD provides a service API that allows applications to configure services
+======================== =================================================
+Service name             Service purpose
+======================== =================================================
+**FLM Update**           create and destroy flows
+**Statistics**           collect statistics
+**Port event**           handle port events (aging, port load, flow load)
+**Adapter monitor**      monitor link state
+======================== =================================================
 
-The services are responsible for handling the vital functionality of the NTNIC PMD:
+Reserve service lcores via EAL options. Examples:
 
-- **FLM Update**: is responsible for creating and destroying flows;
-- **Statistics**: is responsible for collecting statistics;
-- **Port event**: is responsible for handling port events: aging, port load, and flow load;
-- **Adapter monitor** is responsible for link control;
+- ``-s SERVICE COREMASK`` — hexadecimal bitmask of cores to use as service cores
+- ``-S SERVICE CORELIST`` — list of cores to run services on
 
-**NOTE**: Use next EAL options to configure set service cores
-   * -s SERVICE COREMASK Hexadecimal bitmask of cores to be used as service cores;
-   * -S SERVICE CORELIST List of cores to run services on;
+   .. note::
 
-**NOTE**: **At least 5 lcores must be reserved** for the ntnic services by EAL options. above.
+      At least **five (5)** lcores must be reserved for NTNIC services.
 
-For example
+For example:
 
 .. code-block:: console
 
    dpdk-testpmd -S 8,9,10,11,12
 
-The PMD registers each service during initialization by function:
+
+The PMD registers each service during initialization with:
 
 .. code-block:: c
 
    int nthw_service_add(struct rte_service_spec *srv_spec, const enum rte_ntnic_service_tag tag)
 
-and unregistered by the PMD during deinitialization by the function:
+And unregister it during deinitialization with:
 
 .. code-block:: c
 
    int nthw_service_del(const enum rte_ntnic_service_tag tag)
 
-The service info may be retrieved by function:
+Retrieve service info can be done with `nthw_service_get_info`:
 
 .. code-block:: c
 
@@ -249,32 +268,19 @@ The service info may be retrieved by function:
 
 The service info includes the service ID, assigned lcore, and initialization state.
 
-Service API for user applications
----------------------------------
-**rte_pmd_ntnic_service_set_lcore**
-**rte_pmd_ntnic_service_get_id**
-
-The exported service API is available for applications to configure the services.
-
-By API function:
+Service API for applications
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-.. code-block:: c
+Exported functions:
 
-   int rte_pmd_ntnic_service_set_lcore(enum rte_ntnic_service_tag tag, uint32_t lcore_id)
+- ``rte_pmd_ntnic_service_set_lcore``
+- ``rte_pmd_ntnic_service_get_id``
 
-For example to assign lcores 8,9,10,11,12 to the services, the application can use:
+Set a service lcore with:
 
 .. code-block:: c
 
-   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_STAT, 8);
-   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_ADAPTER_MON, 9);
-   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_PORT_0_EVENT, 10);
-   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_PORT_1_EVENT,11);
-   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_FLM_UPDATE, 12);
-
-The API will automatically lcore to service core list and map the service to the lcore.
-
-.. note:: Use `rte_service_lcore_start` to start the lcore after mapping it to the service.
+   int rte_pmd_ntnic_service_set_lcore(enum rte_ntnic_service_tag tag, uint32_t lcore_id)
 
 Each service has its own tag to identify it.
 
@@ -289,26 +295,38 @@ Each service has its own tag to identify it.
       RTE_NTNIC_SERVICE_MAX
    };
 
-The application may use next API function to retrieve the service id:
+Example: assign lcores 8–12 to services
 
 .. code-block:: c
 
-  int rte_pmd_ntnic_service_get_id(enum rte_ntnic_service_tag tag);
+   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_STAT, 8);
+   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_ADAPTER_MON, 9);
+   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_PORT_0_EVENT, 10);
+   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_PORT_1_EVENT, 11);
+   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_FLM_UPDATE, 12);
 
+The API maps services to lcores and returns a service ID via:
 
-For example, to enable statistics for flm_update service, the application can use:
+.. code-block:: c
+
+  int rte_pmd_ntnic_service_get_id(enum rte_ntnic_service_tag tag);
+
+Example: enable statistics for the flm_update service
 
 .. code-block:: c
 
    int flm_update_id = rte_pmd_ntnic_service_get_id(RTE_NTNIC_SERVICE_FLM_UPDATE);
    rte_service_set_stats_enable(flm_update_id, 1);
 
-All other manipulations with the service can be done with the service ID and rte_service* API.
 
-To use the service API, an application must have included the header file:
+   .. note:: Use `rte_service_lcore_start` to start the lcore after mapping it to the service.
+
+All service operations use the service ID and the standard `rte_service*` APIs.
+
+To use the NTNIC service API include the header:
 
 .. code-block:: c
 
    #include <rte_pmd_ntnic.h>
 
-And linked with the library: `librte_net_ntnic.so` or `librte_net_ntnic.a` for static linking.
+Link with `librte_net_ntnic.so` or `librte_net_ntnic.a` for static linking.
-- 
2.45.0

