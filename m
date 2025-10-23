Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583EACCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 14:35:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57CF04025E;
	Thu, 23 Oct 2025 16:35:18 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 3FD1C40151
 for <dev@dpdk.org>; Thu, 23 Oct 2025 16:35:16 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11023108.outbound.protection.outlook.com
 [40.107.159.108]) by mx-outbound9-91.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 23 Oct 2025 14:35:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWfgTW9tW3jmpu2WiXJLdBl+sp9XlJpveEOkkFtvmd5Ovr7zrYP8yJQLdvFNQBghq6xDXJiu9dg0pGdCJjAdU9ASpCzEDx3akTqhAXcX15EgN991oA8XgcFjNffEIotC76e+2Jgl7CanZDyM4QkJfshiqaXup7mRhspS1o4o8Elvw20Paqp0kGwcEwZFfFkj1i2u2aFg9wdSx6j9DHpGWqwgi9/6gY4vRdZaagzUAG+XaVrSW5VO0Jrxv4obEr2H2o7X7mfTFvqFgI1yxUkjD6nIO1sowhWFj/Omo8TJEOXhlDPDypSsHpq2br9pP5/I9U8Qbj2wsQj2QS6x3w53Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJjZsm2svmKMH1lJgUFS3BgCh2ebjk2cgz9teneDQx0=;
 b=BQlxrZq3AZYNQlraQphqv0Q7lyccRQIN5dNPP4a+jANlcIHtv5am04lQmS0H5LFaj1feN21vNqTuj8vts+7DLDYSFd6NdLOeJfdl5yrbWEdduGRMArBLYSX6VP0VOOI1tFWwKvryr4nzq4ZCWr8LUoQM4YB+R0ol0kdsox4OfesXiEVikGFQRa5szkjaI4Y9/1Oz3TvSP1+pTTl41R3VJuwBBjUGnN2glBSQ6qOlD3H5DEdmNPoh679Uhj4Nvds9Z7CXq+tGgIbNjbNEfkMScxzSmS6WSWSuUt4d1GjZk4Wi6yoNzSnbLUrj3cPX2ub9oSEsRv5G5GYyaBaHp0ZD9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJjZsm2svmKMH1lJgUFS3BgCh2ebjk2cgz9teneDQx0=;
 b=NF4vK8JucSFYtfi4mQUi9WbAjI8gssSp4SuozVnbnIqaNLOdCZOdhOzRpVGFAAi4ZGfXXwA/XOzRXAHE+BCn/tCd/cLgk+cagkU/ToaEgyoe0b9HkIUNq6xP9KT0n+J47hCE2qqsBpZ3DH1rBfs+18WV/I/i1phjYbPkC5qwMlE=
Received: from CWLP265CA0474.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d4::12)
 by BESP190MB2297.EURP190.PROD.OUTLOOK.COM (2603:10a6:b10:ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 14:35:09 +0000
Received: from AM4PEPF00027A61.eurprd04.prod.outlook.com
 (2603:10a6:400:1d4:cafe::93) by CWLP265CA0474.outlook.office365.com
 (2603:10a6:400:1d4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 14:35:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A61.mail.protection.outlook.com (10.167.16.70) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 14:35:09
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org,
	thomas@monjalon.net
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2] doc: refactoring the guide for NTNIC PMD
Date: Thu, 23 Oct 2025 16:35:05 +0200
Message-ID: <20251023143506.587329-1-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <3590447.BaHzMo0RvP@thomas>
References: <3590447.BaHzMo0RvP@thomas>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A61:EE_|BESP190MB2297:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c398347-c406-4dec-1108-08de12415e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHRmalVuUjVZT29abk9haGNkemdaeTh3amhNb0puK2J2bWxhL2RwdnpncmVu?=
 =?utf-8?B?WlhWbjg3TTFDdDgrRUNzMTBVSFVLSkFGNEtCYlNxa1J0VjlCTmRTUzY4T1hO?=
 =?utf-8?B?cjlKWXB6dDRFTzlSM2xSV2FHaUMrTWUyOHFaQkw1eTRKZzZ2cmdieW51aGNP?=
 =?utf-8?B?WDZaQi85RG4valRMWWxUNjZEVnp4MjRXTUlQYVU1WDBEZEw0bmNycmFjTE5n?=
 =?utf-8?B?eHR5V0FKd1JPN2dBZ2dBQlNaYXRWNVMyVWV1Ti9ueWNqQ2VXaGZsWk5DaHVx?=
 =?utf-8?B?ZmgzQUJqMVh5VnhlSVpHRW85VHJscnliUWhXUVV2SUQzc3p3bVFac0htRUdJ?=
 =?utf-8?B?VUxXenRDL2dNeDczMjNnSUNLdnFZYWZqbERyRmU4OExLK0pndENhQzduVGVK?=
 =?utf-8?B?cko3Yjh4WUgrQWNjRnF5Q2laZGh6ZzhXWTlyTnRtWkEyQXE0ZWYrUDRBd1N6?=
 =?utf-8?B?MVBxeTNIc3Rhbk1Zd292ZGVmVmZVV0VrVE9mUGpvRmlQbVBSa1JwVzk1V1hC?=
 =?utf-8?B?Z05oWTREbU9IWUV2eTk0c2lkL3RXTHFDeFZHbUZROTEwa0ZmNGt2L2x1WVIw?=
 =?utf-8?B?NmZXTWhKZUFJSVlkTWJnWlExQWphZC8wSk9IWDlqcjFiTDFBU0s3MlNDcWpv?=
 =?utf-8?B?T0M2N0FVVDB6RTRtOE1mOXJkTWRCbFlURlF1VElxNDVTNDJRZkxkWWYvSEVt?=
 =?utf-8?B?a1hwM0YrOG94L3RiWUd5SkQvZHdqSmtBQkhtVVJvUStJZmNQQVdaTFI0anNr?=
 =?utf-8?B?RjU3QkxGc0FJSUM3aVpsZDRGQ1lkazRlQjU5ajNaZDcvbGV0Q2pBUGZiUHpD?=
 =?utf-8?B?R2svMW51Z3JUVUwwTHh2WWNBUEptdEYzUHBlWTJCN1dxaDRIOE5JWEdWU1F1?=
 =?utf-8?B?eXVXTHJZdnJhTUFRcDYvN3ZOMERNbUJXa2hrNngzMXFreTlBbTRPZThWdUNP?=
 =?utf-8?B?emVnU0hhc3R0Z3d4ck9MT1RIRHRhY3pXdTNpbHJESjEwMG9Qb2xOMHg1eWNI?=
 =?utf-8?B?ZVpEdTRsbko1QVIwcGRRZ0ZiblJmd1A5Q3hhVlpXRzVRNXh0dHVoYzVUeDJk?=
 =?utf-8?B?aHhqL2ZzU3kwUVhtVkVxNVV1MmlrWGx5bmtnMmxydmEyQkh2cEZYWGw0YVBZ?=
 =?utf-8?B?SEpnaEFGWjFOVDRjREVxa2o4Nm9IWlh3bmtnSjBvakFqL3JOWWxrNHZiUDFC?=
 =?utf-8?B?dVRzU1FhS1U2NmpWZzVwU2Z5NXU3djhPSWxpS1dyMXZzeVVLSFlxV3dHMkJY?=
 =?utf-8?B?T3RIT204WXlVYloxNTU1S24rQUNOeW9kQTRudXUzT0lwVVltTGJGQmtteGJ6?=
 =?utf-8?B?R05kd01WcEsyRFQ1Z3d6c2ZOemVQNWVMeUNqL1FzZWdsemtIK1RsbExYR09L?=
 =?utf-8?B?THFHU1c2dm9hOXF0RGExR2RIdjhVWUY4MWFKNnlhNUhlRVU4UkVFckxEMWtu?=
 =?utf-8?B?MWVqL2JEV1ViaFV3U20vV1plUEdYRTYvUnZqSkxNY0Z0d2dzdVpMVzZjbzA2?=
 =?utf-8?B?cWZNYXV5Zk8xWHllM3NWRHVGYVJZdFpCRXRIem9LWDgxZ1NwTkwzV2Z5ME1l?=
 =?utf-8?B?N3lsNkQ1Mno4ejE4czJ1UVFNeTJ0MTBUMElyb3VoQSthclY3WFYvNWxTam9y?=
 =?utf-8?B?bDdDa2pZZm9YejlDTjdFaHBqRE0zTng3b2V6Ny9ZcmdXUERHQlRUUHBrR1BF?=
 =?utf-8?B?Z2hCbXZ2cmtGay82aXdjTC9Yek9xcEVvZEpvRzBIZUFzRkt6NXBhRGs2dlZQ?=
 =?utf-8?B?SXlKRzdYdHpsNEY5Q3BKaWEydFFmY0t6cTdlQUE0VlU2RTcrK0pLeWg3T0xk?=
 =?utf-8?B?MXMrZnVrcUh4OVNZR3NucitVa21maVA3Nm8yeGRZamZTcWpFRnAwNU5xbHht?=
 =?utf-8?B?OE9KTnYyQTNHZVBxQnZkYWw0NHRxVzc5R1JtSFJvb0dwejRXTVk0bTdkZ3Ns?=
 =?utf-8?B?L01GMURPb1cwQTJWa00yRU9Da0phbnFFeVZQWEFIc2xlRVNBQ0hKMUxvWi9B?=
 =?utf-8?B?Tzl3cWNJSGN4UzdhY0lDcFZMWEtldUVTZzdzRnluTjhOWHNHclhBSTFHL1RC?=
 =?utf-8?B?U2dDTWpSaU9UQnZhYkhheEE0Uy9KN05KMW1sbklCUzd6NXYydStJSllic0NS?=
 =?utf-8?Q?DniI=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: j9kXDmCubPikVMTUnkQVbVS+Hv3kHG9JkEyezGMtQwcaOmP0Wt5aLTsXm2v1rMvEqys2ekDVmPKEI+vIlrBtJ0S5j5J/B7A3HW0OGzA9IoenrrOnoPW7fh37CQZJ7TuQzjyI/56JqDPoD1i/8xErU2drMCunQdxO4Koy5NV5tLTNe+Zo9Qhxpq7oUy+Mm3K5+FY2j1bTV7TT2Xo2YgALaHrRP/V1GadNc5x4XwHT5fDQUBQ8/J25KCGsSkqd3IgnAfDbrx+fiy13wNBZ245PD0qYojp2rucyKRhpjJsH/e3znF3QXain31Xn5XHGagUGtwMwsz3FyQpVazBMpF4X6RpB1ycWQRwxCQIOrQyOkyy9PTMkXDiMvxGGKYd0hWrawrJO31Tao74dPJVd4GgEwK5atPhuqOHo57qgbcPHN7H7EieNn5KwCG8AKScKG5R2GdIE6FKkgMr0d0rIggrrEMNNKIBE1uIOVGSAvcDXAEZrQZdmInzAzB8hdzYwGYq45rwSsSxvP07x3ehwmjLNqTnrCUsiUhANWC6qo3fTuD+gFbWeBS5Ah6jm1+0j7vI/uRN3oJhqSX7h43iWKCpr8jk2VwbMPqn3Qw5Wx7D9K0XWz0iJkXpAu5pm6nmU8s2MIBi+aYMMjZnH//DdHyWR6NIQzftc6vNCmYhexFNMbuM=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 14:35:09.1690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c398347-c406-4dec-1108-08de12415e0a
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A61.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESP190MB2297
X-BESS-ID: 1761230110-302395-7617-13425-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 40.107.159.108
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmhpamQGYGUNTEPNXC3Mgs2T
 g50dTAKM0yOc0kKcXCOMXAwiTRyNIwWak2FgAgahvcQgAAAA==
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268418 [from 
 cloudscan13-150.eu-central-1a.ess.aws.cudaops.com]
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
 doc/guides/nics/ntnic.rst | 221 ++++++++++++++++++++------------------
 1 file changed, 116 insertions(+), 105 deletions(-)

diff --git a/doc/guides/nics/ntnic.rst b/doc/guides/nics/ntnic.rst
index fc40c97095..17cc78af34 100644
--- a/doc/guides/nics/ntnic.rst
+++ b/doc/guides/nics/ntnic.rst
@@ -23,66 +23,67 @@ The physical ports are located behind PF0 as DPDK port 0 and 1.
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
+=========================================================================================== =======
+Supported Features                                                                           Linux
+=========================================================================================== =======
+FW version                                                                                     X
+Speed capabilities                                                                             X
+Link status (Link update only)                                                                 X
+Unicast MAC filter                                                                             X
+Multicast MAC filter                                                                           X
+Promiscuous mode (Enable only. The device always run promiscuous mode)                         X
+Flow API support.                                                                              X
+Support for multiple rte_flow groups.                                                          X
+Multiple TX and RX queues.                                                                     X
+Scattered and gather for TX and RX.                                                            X
+Jumbo frame support.                                                                           X
+Traffic mirroring.                                                                             X
+VLAN filtering.                                                                                X
+Packet modification: NAT, TTL decrement, DSCP tagging                                          X
+Tunnel types: GTP.                                                                             X
+Encapsulation and decapsulation of GTP data.                                                   X
+RX VLAN stripping via raw decap.                                                               X
+TX VLAN insertion via raw encap.                                                               X
+CAM and TCAM based matching.                                                                   X
+Exact match of 140 million flows and policies.                                                 X
+Tunnel HW offload: Packet type, inner/outer RSS, IP and UDP checksum verification.             X
+RSS hash                                                                                       X
+RSS key update                                                                                 X
+RSS based on VLAN or 5*tuple.                                                                  X
+RSS using combinations of fields: L3 only, L4 only or both, and src only, dst only or both.    X
+Several RSS hash keys, one for each flow type.                                                 X
+Default RSS operation with no hash key specification.                                          X
+Port and queue statistics.                                                                     X
+RMON statistics in extended stats.                                                             X
+Link state information.                                                                        X
+Flow statistics                                                                                X
+Flow aging support                                                                             X
+Flow metering, including meter policy API.                                                     X
+Flow update. Update of the action list for specific flow                                       X
+Asynchronous flow support                                                                      X
+MTU update                                                                                     X
+=========================================================================================== =======
 
 Limitations
 ~~~~~~~~~~~
@@ -101,79 +102,89 @@ Configuration
 Command line arguments
 ~~~~~~~~~~~~~~~~~~~~~~
 
-Following standard DPDK command line arguments are used by the PMD:
+Following standard DPDK command line arguments are used by the PMD.
 
-``-a``
-   Used to specifically define the NT adapter by PCI ID.
+NTNIC-specific arguments can be passed in the PCI device parameter list:
 
-``--iova-mode``
-   Must be set to ``pa`` for Physical Address mode.
-
-NTNIC specific arguments can be passed to the PMD in the PCI device parameter list::
+.. code-block:: console
 
    <application> ... -a 0000:03:00.0[{,<NTNIC specific argument>}]
 
-The NTNIC specific argument format is::
+The NTNIC-specific argument format is
+
+<object>.<attribute>=[<object-ids>:]<value>
+
+Multiple arguments for the same device are separated by commas. The
+``<object-ids>`` field can be a single value or a range.
 
-   <object>.<attribute>=[<object-ids>:]<value>
+- ``rxqs`` parameter [int]
 
-Multiple arguments for the same device are separated by ‘,’ comma.
-<object-ids> can be a single value or a range.
+   Number of Rx queues to use. Example:
 
-``rxqs`` parameter [int]
+   .. code-block:: console
 
-   Specify number of Rx queues to use::
+         -a <domain>:<bus>:00.0,rxqs=4,txqs=4
 
-      -a <domain>:<bus>:00.0,rxqs=4,txqs=4
+      By default, the value is set to 1.
 
-   By default, the value is set to 1.
+- ``txqs`` parameter [int]
 
-``txqs`` parameter [int]
+   Number of Tx queues to use. Example:
 
-   Specify number of Tx queues to use::
+   .. code-block:: console
 
-      -a <domain>:<bus>:00.0,rxqs=4,txqs=4
+         -a <domain>:<bus>:00.0,rxqs=4,txqs=4
 
-   By default, the value is set to 1.
+      By default, the value is set to 1.
 
-``exception_path`` parameter [int]
+- ``exception_path`` parameter [int]
 
    Enable exception path for unmatched packets to go through queue 0.
 
-   To enable exception_path::
+   To enable exception_path:
 
-      -a <domain>:<bus>:00.0,exception_path=1
+   .. code-block:: console
 
-   By default, the value is set to 0.
+         -a <domain>:<bus>:00.0,exception_path=1
+
+      By default, the value is set to 0.
 
 
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
@@ -204,7 +215,7 @@ There are list of characteristics that age timeout action has:
 
 
 Service API
------------
+~~~~~~~~~~~
 
 The NTNIC PMD provides a service API that allows applications to configure services:
 
@@ -214,29 +225,29 @@ The NTNIC PMD provides a service API that allows applications to configure servi
 
 The services are responsible for handling the vital functionality of the NTNIC PMD:
 
-FLM Update
-   is responsible for creating and destroying flows;
-Statistics
-   is responsible for collecting statistics;
-Port event
-   is responsible for handling port events: aging, port load, and flow load;
-Adapter monitor
-   is responsible for link control;
+======================== =================================================
+Service name             Service purpose
+======================== =================================================
+**FLM Update**           create and destroy flows
+**Statistics**           collect statistics
+**Port event**           handle port events (aging, port load, flow load)
+**Adapter monitor**      monitor link state
+======================== =================================================
 
-.. note::
+   .. note::
 
-   Use next EAL options to configure set service cores:
+      Use next EAL options to configure set service cores:
 
-   * -s SERVICE COREMASK Hexadecimal bitmask of cores to be used as service cores;
-   * -S SERVICE CORELIST List of cores to run services on;
+   * **-S SERVICE CORELIST** List of cores to run services on;
+   * **-s SERVICE COREMASK** Hexadecimal bitmask of cores to be used as service cores;
 
-   At least 5 lcores must be reserved for the ntnic services by EAL options.
+   At least **5 (five)** lcores must be reserved for the ntnic services by EAL options.
 
-For example,
+   For example,
 
-.. code-block:: console
+   .. code-block:: console
 
-   dpdk-testpmd -S 8,9,10,11,12
+      dpdk-testpmd -S 8,9,10,11,12
 
 The PMD registers each service during initialization by function ``nthw_service_add``
 and unregistered by the PMD during deinitialization by the function ``nthw_service_del``.
@@ -262,11 +273,11 @@ For example to assign lcores 8,9,10,11,12 to the services, the application can u
    rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_PORT_1_EVENT,11);
    rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_FLM_UPDATE, 12);
 
-The API will automatically lcore to service core list and map the service to the lcore.
+The API will automatically map a service to an lcore.
 
-.. note::
+   .. note::
 
-   Use ``rte_service_lcore_start`` to start the lcore after mapping it to the service.
+      Use ``rte_service_lcore_start`` to start the lcore after mapping it to the service.
 
 Each service has its own tag to identify it:
 
@@ -284,9 +295,9 @@ For example, to enable statistics for flm_update service, the application can us
    int flm_update_id = rte_pmd_ntnic_service_get_id(RTE_NTNIC_SERVICE_FLM_UPDATE);
    rte_service_set_stats_enable(flm_update_id, 1);
 
-All other manipulations with the service can be done with the service ID and rte_service API.
+All other manipulations with the service can be done with the service ID and *rte_service* API.
 
-To use the service API, an application must have included the header file:
+To use the NTNIC service API, an application must have included the header file:
 
 .. code-block:: c
 
-- 
2.45.0

