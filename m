Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B28CCF9EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 13:00:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81E42402E3;
	Mon, 27 Oct 2025 14:00:15 +0100 (CET)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id A3482402E1
 for <dev@dpdk.org>; Mon, 27 Oct 2025 14:00:14 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11021096.outbound.protection.outlook.com [52.101.70.96])
 by mx-outbound42-44.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 27 Oct 2025 13:00:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAtpVwIBb6tjvmfehbQc24BJE4q4UwjRrdfdSfVTcM1DGkIr90FMcYCZ97BwHZ+vmDrR5mLmE3/AROc6eXTY6U1BFXDuLQZ6UEkslunTYWiiw+lo8HGnEbeMgBYAiaww1nkiYdISQ0ncH4vru3OZMs6mX/UwQBxepm0J693jls5i/Xo0pUgNvr6IwEPXxU+pNFr8v02U68lGGug9pjWzAGxol0fDDuaGsCp16dzN2tW54bAHtWb6IPdAwhRYfAGtqjtu8l6PWT2m06FTtlUb+a32+TaROrU8jzEp3BNeibEls+lSHMnOhxLQuPctRX0oM4KUr3U7/m/8mR0crxN/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGsJMG4mq86uSTCNZjIFzANWJRujoX1gQIVHcc/Db5c=;
 b=ZEeL7AO5+cJPTttCDqgfcAon8/Bc7g8y9eSXFKMXyy9088cDEDQ92xkny7R8ELs785+iNqzLD5B/n5/xl8XhZTJ9N5MY2jRokrStKSFkdyobp7nVMvSanp7xfT5gCkVuUWBEjeyRVlzeKnV6lsrGUKQwIj/wJyn/updxaAEl2BdS09oMy5wcm78l3rEuKHesnlPwgezwASYavRsl8RwuVSIljJ4Vb1h5bCasYIZ3AVo0q+D3tudiKPpZxg136nLVK6fmb4vfT0OkoEL/Wwau3BxFpczWgODkOCSQCtNxK6KUDPLTESJbhV39R8tyHq8NIUtU18waO30A5vU8+/bKsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGsJMG4mq86uSTCNZjIFzANWJRujoX1gQIVHcc/Db5c=;
 b=a97EW/4jxB1enJZ7EylovOP3ZT0yCgow3bWENFA7cCHVmdBZs24x2Hl6WCnk583u6ihkNa5bvW+T/9R4KeoKluLyZo8Li6YlVGSjfuocruIdBBSvxC9nOstU0RgrdF0P/X9aNhjKJpVytW+LMUnC1cM4wncZtZm6zvN0WVQd6hk=
Received: from AS4P250CA0018.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::13)
 by AS4P190MB1807.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:4b6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.9; Mon, 27 Oct
 2025 13:00:08 +0000
Received: from AM1PEPF000252DE.eurprd07.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::de) by AS4P250CA0018.outlook.office365.com
 (2603:10a6:20b:5e3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Mon,
 27 Oct 2025 13:00:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM1PEPF000252DE.mail.protection.outlook.com (10.167.16.56) with Microsoft
 SMTP Server id 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025
 13:00:07 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org,
	thomas@monjalon.net
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v3 1/1] doc: refactoring the guide for NTNIC PMD
Date: Mon, 27 Oct 2025 14:00:01 +0100
Message-ID: <20251027130002.597552-2-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251027130002.597552-1-sil-plv@napatech.com>
References: <2974305.OYXXYNVTWy@thomas>
 <20251027130002.597552-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DE:EE_|AS4P190MB1807:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8696ac-a565-4217-5f9a-08de1558c17d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0ZKeHRMR2pUeHRCL0M3OFYybHdsdUw4L09vSVNKVS9ITGdnVmwrZlI5VkZz?=
 =?utf-8?B?ek4wbk5CV0F4MDFsMHlCNTJ0VEd2eEZMOGcxaElhNHNId0RsdmFkZytSUjZR?=
 =?utf-8?B?Yk44SXZnNHNzdmRsQmc0aHNqUTNQbzVlWGswWHVaclFCTHdNazVXL296OGMw?=
 =?utf-8?B?YXVMb2JqOEtza3ptQW1oWUo3U0FQNU9EMzJjRkFnS1NmbEVXMzRLTzZnUGhq?=
 =?utf-8?B?eENabnZXL2R5NTBsMWc5UlpQM0pXTVQxVFk5cXl5dGVTN1RuY25OSXo4UmJp?=
 =?utf-8?B?TG5nTGR0NE8vN2dvRzFQZzJobS9Gb3lKT1F3TUFLcWd0VFNCNlJmamJmUWRV?=
 =?utf-8?B?SVBnRjUvMFdUYmJVRWc5eW04d0MxcTV3YzJBUjIvcnBFRHRTNDBMTFhWL21u?=
 =?utf-8?B?dzEyaDNteG8yczhiNzVtaTVSMW92UUEzaW5ZTEI0eEdzQXQ4Q21Wa0ZsQ2Fz?=
 =?utf-8?B?cHdON1UvSml1Mzh1dU5VZE55YzhIKzJ1OHR1RjVoa0VSZzRuWjZaK09La3Rh?=
 =?utf-8?B?UyswWXp2QTFSTVoyV0duSldqbnUwbWQ3T2lxc1VJZ0pBQ0xnNGcvMkRUdFdI?=
 =?utf-8?B?NnJXYXo4UDFzb2luQmNibnBlUWQ4dmNPS3lkVk1xWWNQQkVpdTlLRU9TUFZq?=
 =?utf-8?B?UGRNQjNITmczb0d0Y2lwMHRzbElFYzN0V3VROEdEK29JSkd5U25ONUNOUlFm?=
 =?utf-8?B?bGdEUXF1M0NieGRSVGoyQUgvaHloZ0NwTnFpTFoxSE9ZemQ2Y2x4TSsvQlBr?=
 =?utf-8?B?UGZ5akRmTVdXam5QdmtpVEYrdGtzdXFZNW1zOUdFMFBzUVh5VnNyUzJVUTNV?=
 =?utf-8?B?b0JXckRDSzFjREFGSHlTS1Vjd3laZG5Dc0ZOV3BSa1cxY1EyWHk4aFc2TGpM?=
 =?utf-8?B?UiszWjU5WmZIOUZVUUNJWmg5RHBPTXlXbXJkbTNqQlhzbUlPRVVUbC9KblRl?=
 =?utf-8?B?ajhoNG45T1JJUjY2dHEyTWh4SVYyUmxiU21uMEJnc0tibG1vcTBRNlJMZzE5?=
 =?utf-8?B?czNPWkVNYlFUcXJJRnI4RDMrK1ZsdWZRbWFBM2RlaUNaZ3d3d01IUlNqbmxU?=
 =?utf-8?B?M01BWmE1N2JzVnBhU0ZiNEllMW51TWRiaXdoTGI4c0dicllXZHViV3djWDRr?=
 =?utf-8?B?SDRoNS9MWVNoRGhIWnhXWkxYZTVsM3JpUzM5RDY1Ungvdk1vS3NMa0poVDVl?=
 =?utf-8?B?Z2IwMHFYYzlPZmczcmwzUFVVc3VSck5SaFlYMUlwZGJOSkNtTXRHK1dEdWxq?=
 =?utf-8?B?ZXBWWCtXQitSaC9FRmNleDZrSUlrcXEwY25JclJpNEdPNVp6alpGbjJUeVAw?=
 =?utf-8?B?aGhOR2t6cDYyRWhLb2ZtV2VMM3BLSlAraUZ3VFBkRUdxVHhTOUE0RFFvVlRu?=
 =?utf-8?B?SmpvNi91azhkOThtOStjQ2R4cDFKOFRzbTJqVklQUkd2OE9keGNJUHlwZnIz?=
 =?utf-8?B?N1BheVMxY3hPRGhLYlpjb1U2eUN4d1pxbk1nOWViVHBENDJvRFMvek5JSGlJ?=
 =?utf-8?B?MlVpTm82U3FJeVFBS3U0VlRlV0dscFRTZFN5SjB1RzM2RlEyeE5TTFM4TVlz?=
 =?utf-8?B?bHBXeVpJck1UVm1OcjIxcnYrMndzVlhyTTVjamFvNVhHdE85SnY1cXJpS2RZ?=
 =?utf-8?B?K2ZRbmJxcVZSNVlvMjhESHM0cWNXbXozZHV3QzJQN2wwZmlQK3VzWTJJTHl2?=
 =?utf-8?B?SWRYS2lybFQ0M1JrZ2xWMXc2WVpWbkJzNzluKzg5QjNJYm1BOCtZRmZkbzdx?=
 =?utf-8?B?S0hXQXlTajdna2UyR0k0blJ5NmRETzRGVGdPRTFRcnhnRXc4NDhrcmNBdmw0?=
 =?utf-8?B?dkRRS3pHYzhXM0FSV096bU9xWTBhMkx0WDhxV1JXTm5ybnNibiszdWMvcGhR?=
 =?utf-8?B?aW1iUmF5Y21sVmpEWDNqdXE0L3Uvdkl0bndJSFN1QWNHaGxLS0lUZnVsT2c5?=
 =?utf-8?B?VVQ3N1REdkdjczIzNWlXVytnUWxBYVpjZVpGK3dWNHByN1Z1RUlheENjVEtK?=
 =?utf-8?B?ZXhsS1pXZFAzS043eFR0OWJRQzQvT2dNZVpqUDJBQm1TeWxCcFJWUnNUdkIz?=
 =?utf-8?B?TXRkeGpoK3VUK1ZCd3pGRk45aVhPZm50WGFRd09vY25QbmF1Z2QzdExrVmcz?=
 =?utf-8?Q?aZkE=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eQ3l6Kg5chKvGiC0/6XRms93xLvJJRVecrsOubv4a1E5Z4JebKtea5xoenE/V34e4H/rUJPW6VcQAdcPgYCLurhgw5e8Ofb+8+5JWFe2SMEG8GbA+pwrkTxXu/q87iqF2BrGhcxX8S4FWg94YXnaHX7b0VXBVJ2Riu4Qn7Cuy60ZLx9RveSDc9nKKWjgzAN7szXqm0AqSHK8K7uBN9oxnEFrTOLh75nG7OTDuRl9YmSvu4QYW5lJPj2CWa2gSQ+9RQfYg17F9K5SXPhC70pDUbOp8NOPcKnAxsvQglAZDsjjYAE1GL2/ca0jaEUyJYXE6RWr3yBnxSOzx2s7tzjjYFIuiWsBV6N2w3B0GwPcOteRRXG3v7SzUWI6ixUdbXuZ/nV0ZUA/uKbB899u8IPKMKJo88rzEY9l1D4gWAZB2sv9tXSjlgT2DJjoJ7uhvje994zYmBITusFMsdNJ/cYQktEODv4WMDk8YGgC6wTV3It9GdXIqpiwH8aT+PqeXFQwdaPCDDXmyzDCw4S5r+uUC62CJjAHCLAXdHDPYdmk0Y029T/uL0ixKls5jhx7QG2JjH2/GuISc1q681h7QxrxZHK24oS1dKy/kC8XyGXSjTETmg2ShBnoR03hR+nsVyKK3Rf986NSbIBlVeq1rxL0UDg9KItqP4EWbp5GidM7UTE=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 13:00:07.9466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8696ac-a565-4217-5f9a-08de1558c17d
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P190MB1807
X-BESS-ID: 1761570011-310796-7662-113862-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.70.96
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGxgYGQGYGUDTZwtg02SzNzD
 TN0jzRKC051dDI2NLM3CQpNTXVKNUkWak2FgCL9N/MQgAAAA==
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268512 [from 
 cloudscan8-246.eu-central-1a.ess.aws.cudaops.com]
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
 doc/guides/nics/ntnic.rst | 204 ++++++++++++++++++++------------------
 1 file changed, 106 insertions(+), 98 deletions(-)

diff --git a/doc/guides/nics/ntnic.rst b/doc/guides/nics/ntnic.rst
index fc40c97095..9f5349494e 100644
--- a/doc/guides/nics/ntnic.rst
+++ b/doc/guides/nics/ntnic.rst
@@ -23,66 +23,64 @@ The physical ports are located behind PF0 as DPDK port 0 and 1.
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
+.. list-table:: Supported Features
+   :widths: 100
+
+   * - FW version
+   * - Speed capabilities
+   * - Link status (link updates only)
+   * - Unicast MAC filtering
+   * - Multicast MAC filtering
+   * - Promiscuous mode (device always runs in promiscuous mode)
+   * - Flow API support
+   * - Support for multiple rte_flow groups
+   * - Multiple TX and RX queues
+   * - Scatter/gather for TX and RX
+   * - Jumbo frame support
+   * - Traffic mirroring
+   * - VLAN filtering
+   * - Packet modification: NAT, TTL decrement, DSCP tagging
+   * - Tunnel types: GTP
+   * - Encapsulation and decapsulation of GTP data
+   * - RX VLAN stripping via raw decap
+   * - TX VLAN insertion via raw encap
+   * - CAM- and TCAM-based matching
+   * - Exact match for up to 140 million flows and policies
+   * - Tunnel HW offload: packet type, inner/outer RSS, IP and UDP checksum verification
+   * - RSS hash
+   * - RSS key update
+   * - RSS based on VLAN or 5-tuple
+   * - RSS using combinations of fields (L3, L4, source/destination)
+   * - Several RSS hash keys (one per flow type)
+   * - Default RSS operation with no hash key specification
+   * - Port and queue statistics
+   * - RMON statistics in extended stats
+   * - Link state information
+   * - Flow statistics
+   * - Flow aging support
+   * - Flow metering, including meter policy API
+   * - Flow update (update action list for a specific flow)
+   * - Asynchronous flow support
+   * - MTU update
 
 Limitations
 ~~~~~~~~~~~
@@ -101,79 +99,89 @@ Configuration
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
 
-   <object>.<attribute>=[<object-ids>:]<value>
+``<object>.<attribute>=[<object-ids>:]<value>``
 
-Multiple arguments for the same device are separated by ‘,’ comma.
-<object-ids> can be a single value or a range.
+Multiple arguments for the same device are separated by commas. The
+``<object-ids>`` field can be a single value or a range.
 
 ``rxqs`` parameter [int]
 
-   Specify number of Rx queues to use::
+   Number of Rx queues to use. Example:
 
-      -a <domain>:<bus>:00.0,rxqs=4,txqs=4
+   .. code-block:: console
 
-   By default, the value is set to 1.
+         -a <domain>:<bus>:00.0,rxqs=4,txqs=4
+
+      By default, the value is set to 1.
 
 ``txqs`` parameter [int]
 
-   Specify number of Tx queues to use::
+   Number of Tx queues to use. Example:
+
+   .. code-block:: console
 
-      -a <domain>:<bus>:00.0,rxqs=4,txqs=4
+         -a <domain>:<bus>:00.0,rxqs=4,txqs=4
 
-   By default, the value is set to 1.
+      By default, the value is set to 1.
 
 ``exception_path`` parameter [int]
 
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
@@ -204,7 +212,7 @@ There are list of characteristics that age timeout action has:
 
 
 Service API
------------
+~~~~~~~~~~~
 
 The NTNIC PMD provides a service API that allows applications to configure services:
 
@@ -214,29 +222,29 @@ The NTNIC PMD provides a service API that allows applications to configure servi
 
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
 
 .. note::
 
    Use next EAL options to configure set service cores:
 
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
@@ -262,7 +270,7 @@ For example to assign lcores 8,9,10,11,12 to the services, the application can u
    rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_PORT_1_EVENT,11);
    rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_FLM_UPDATE, 12);
 
-The API will automatically lcore to service core list and map the service to the lcore.
+The API will automatically map a service to an lcore.
 
 .. note::
 
@@ -284,9 +292,9 @@ For example, to enable statistics for flm_update service, the application can us
    int flm_update_id = rte_pmd_ntnic_service_get_id(RTE_NTNIC_SERVICE_FLM_UPDATE);
    rte_service_set_stats_enable(flm_update_id, 1);
 
-All other manipulations with the service can be done with the service ID and rte_service API.
+All other manipulations with the service can be done with the service ID and *rte_service* API.
 
-To use the service API, an application must have included the header file:
+To use the NTNIC service API, an application must have included the header file:
 
 .. code-block:: c
 
-- 
2.45.0

