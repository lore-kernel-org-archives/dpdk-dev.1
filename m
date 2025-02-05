Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20B2C02194
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:49:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D2EB40E17;
	Wed,  5 Feb 2025 11:46:41 +0100 (CET)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 1C23440A84
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:29 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02lp2104.outbound.protection.outlook.com [104.47.11.104]) by
 mx-outbound43-8.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGYQ+WA2dMpiECUVdaTzOn8UStHMwnQ7nZCPKA0e1OvwObdEDrb70SqRxm49ah8MWF01cK3Z2rm9ApWTpWkM9bDg2LoRk71exQBC1pK+7PlAnrXxjABUuzu0f2GWcIQbGZcCXSr+bpVqWbE6dmrjAnNhXrWz4YQqdfFThNBB7T12m/ABShpOgkRZAOS0tfNjxcUgH4vlJMvbLOMW/pwY8yN0vjKk/8bGoAwAbtdmpV4hzjqu+z4boyEZxUiqtHS2STRyaaodfUyyXSccKpp7177dXa2Imuen8hLFPxLZpQ/pDK4g72cfFjbcDJfipxfnxIiSvfGFvKt/vJY6RJSLIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrl55lT8g/p8kcpD9+ASdtD6PHkT/HAE0Ge+46xkYkc=;
 b=ZMAAt+tlR+UT+W07WX5Kb5eJ8ugWpmRj1NTGGaJXl/Xdw72mwX/VxmKS1ECXtkQDrFAn2C1zOZWlVtK6CjlydE05HPgfYHjQHW5dhMIzadBO0jgoZGw/2piEZqZz6dPB2R7CZBoQ9pSVFDNbSxQHuAP1XKA6wu1X3Gvc+2iwmdIW2HubKYex+JYHJck7fwx5ir84EeyBfWU9qS9dcrveC2KzLX47fXed2cajZdI/mIr0xelc7RErhpE7YjIejniVsCN78O/ygFQ003v3Iwy/zA5mnMo3LuSN2n3VyXY7W7DjynlheHQyI6/gDS7J9dreE+bMkMhmo/4rl6IushV6Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrl55lT8g/p8kcpD9+ASdtD6PHkT/HAE0Ge+46xkYkc=;
 b=ai86bhikbbyAtP4aFXDLiUVOZ2dDL9OuBDKLwM6Wmy+rjOZ02XYbbKqlCZjVSzBxwPEhiDbO2jt6BsMDqCLFKZJcGP8p9I+kslf2hCJ2XvLGmNXpwOZFvS6f+JJF++x3FCeiREHOoW/lb/dJkbbaSdaW/zehdo/oN3iuonJI0bM=
Received: from CWLP265CA0338.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::14)
 by PA2P190MB2101.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:40d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Wed, 5 Feb
 2025 10:46:26 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::2d) by CWLP265CA0338.outlook.office365.com
 (2603:10a6:401:5a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 10:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:25
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 32/34] net/ntnic: add checks for action modify
Date: Wed,  5 Feb 2025 11:45:41 +0100
Message-ID: <20250205104548.1533554-33-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|PA2P190MB2101:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3ea5bbe7-47cf-4254-3f45-08dd45d256de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r9OMCFlQWEch/fUDAZLst1f4OXpIgESM83vhD7UISPHyvfgCNBxACk7O3dpO?=
 =?us-ascii?Q?zATbIbopOU0E8PB5gvHjWbVWfJyG2gUewwDQEUooilHFx+S4/Cs3hXstcrZ/?=
 =?us-ascii?Q?wDIiDJ6ciddRubNm0j7FMBkWSNGj0+XAOmnJ1M6tvfrIDxAMZbKLiKGctzVV?=
 =?us-ascii?Q?pbbfjNznMUMI+DtOugeHVDB0dVtWfVTIoBzhpcsybeJU8/vfxzNGH85u1fyB?=
 =?us-ascii?Q?nsQpZnb8om+U1UfmGxFmJ2xd7i7g7+DmxokAX+DKungdU03ZR6uI93KYdDcl?=
 =?us-ascii?Q?EQPyYifYjb/KH6Puvx16QSk26GrRpLltJdSMMhL/A9Zw22QY0CKEUXgu4TJp?=
 =?us-ascii?Q?Is+SoDqTpstHxwokPrgLmVVHurbZ4wGDfNgq+PbOo0rVVsx3wphQhr7zfCA5?=
 =?us-ascii?Q?ZMlM+kiSGM/nIlBqVSNblm5Nt8P34/e4Zr/6VTmNVKYaW3IBRjDhf4UPrLxb?=
 =?us-ascii?Q?pxuFosGoN6w6lv6jpl8qv8iBmV+279yBLuxRScVY2cWNIBhm7Axef/9Ciju+?=
 =?us-ascii?Q?mlTxw1ShZ9NLrxCK+MW2irzi/x/jrOPdxvvMY2e+a85HAkvTqzQGxJZnP5h/?=
 =?us-ascii?Q?EKkS98w+t8Qn2HWh9RpJp44TXVT5gnQ5zWy5XbztqT/Si33WPTPCQGgyu3nw?=
 =?us-ascii?Q?kPQRakZUooD+nO4AAvpYBT85IuOE5HBtC/48Kj2lxrejsfr41JyLou7V8y5n?=
 =?us-ascii?Q?PV0MO6BNRXrqgB+6eBVMUkr7DD1zmcjQNCtIdiUxitsXGSFb+/7mlaDUnI4O?=
 =?us-ascii?Q?OXKR9nnyszD5uWZ2M0jPXr3phrmQIvqx7SX1FgZ8fdRI8BjyEfQNxUsOX42v?=
 =?us-ascii?Q?ytfVlq7xdfd/UyjgDM3BPt8mbL+Bi1rT2eUV9tE8273QHVkbGW7YmrrLQb+w?=
 =?us-ascii?Q?ka4oaQiM2Alr2/hheY2kNcr2N0KznSCbebwGbqPnY6ssWH9wPHl+hoXq8JPh?=
 =?us-ascii?Q?HH+nqqElnjfCoR7tnnaEqbvCDNUnCRy01Oq49Qq51I/n9Qr6E0UwJ5xZWk9+?=
 =?us-ascii?Q?O9Dm8vvRYGC1r1Vr3b9YaUcivpIe82zREywD2sZ3WPzu9URXp9MljL9GompV?=
 =?us-ascii?Q?cWUia2F1fCd5ovrQ8Mq4zSCgz7fwZ33WhujjguKTmqIDLDCR1dbsuOSIeciB?=
 =?us-ascii?Q?8MCMoxJ21utGfYsOfp8582CLxHBCwd/DIU88oVmOk+hM7V+Jyc6BJa/IWbuo?=
 =?us-ascii?Q?EHgo5fLNkoDEcLSCQdkQc/Ea+WaNMvNvOYxIwZfRd78AXXmLCoLHv0t0en2e?=
 =?us-ascii?Q?9CGxkCFiteO1JhckYax+VpysG+F5/m7AdEfEsGO53/C2y2xVP67CXiCKB6w7?=
 =?us-ascii?Q?ccGKTcAu9bl2xCHKleSC/C3EqJ3c0I21LTNNyzmcDw+Sc+gHxL6nBVLg60Op?=
 =?us-ascii?Q?yHrfAdxRQFO8/Tqc8cnlY9pxOZXwXrhnyemqrVzUqKcjfxHEHiqjaxD0aI3y?=
 =?us-ascii?Q?la1LGPGaLX/IarKAkJ4FS/YbTlOE2aKY4WvdO3ucvjb515Lj48mqqvEBlnaF?=
 =?us-ascii?Q?AJYAn04oCgEDcLA=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7JY25oWGO17GRAI7lL8SO7NtHnvGjKhVZMbvk9vmOGJo4mGQSKA+bjF3wnabOZd68p6N6IPoxTA9wmvDEBwzMQT+VyXxCVFWztrxYuQhQKGdxNYys53rXMsFBMqKgLBu9xb+2RePWsliVdnAHjlQDdwuNdie3wR5LKaLyOKFPUkOp/EDL5E9WqI2L4asJy3ccJrsmO6F2I0hhYR7F8Fkr8axkdkl/EVOtz0gOMoLeaPdbQHz5hFmLCQWhTAgAiFyzTO6iaw7Gmps1A8u8rKKSH/DqJu4dr+IrnkynvkumIJdbOpNCcyyI83zBl073AZoGQulepOuz1YAx1IRK289eorQ/Hq6X7BE+Pg9zXHZNCqhdNaRGeAF16WlVEXu+44z+Bxu+6ny/BYeqoX23lWHPbdtK7jOyrghr5bcTjv0dZd53YRnBmg2Uye68NfiYUPcfH0AWNJYC4oADcKaVIT8nAT9qOYqywkC3CpbjpOr6IHpFXc/LZ02GF5pVW6QyOXeE53j77dRIcwhkC+pGDmcMZxoKqvOZIBCX5VQy3St7u9oOOfnVDPSE1HIE2KskRCNoZ6MgkXTSlumul0gU2rezX8DOE/ogFjH5VdUkg0oPoCebfujaOa1nk8xw3fH1Ge5T9Ov0Jb5FeAMi4pRJ547KQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:25.8082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea5bbe7-47cf-4254-3f45-08dd45d256de
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P190MB2101
X-BESS-ID: 1738752387-311016-7902-653-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.11.104
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqbmZoZAVgZQ0MTYyMIw2SApOS
 XNyDDFLMXQJNnAMi3J3NTM1DDFMs1cqTYWANWCCaJBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan17-75.eu-central-1b.ess.aws.cudaops.com]
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

Following checks were added for `action modify`:
* range check to trigger an error in case that value is too large
* check for unsupported types of action modify for group 0

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../profile_inline/flow_api_profile_inline.c  | 89 ++++++++++++++++---
 1 file changed, 79 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index e911860c38..fe72865140 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -2990,7 +2990,36 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 	return 0;
 }
 
-static void copy_fd_to_fh_flm(struct flow_handle *fh, const struct nic_flow_def *fd,
+static bool has_only_valid_bits_set(const uint8_t *byte_array, const uint16_t byte_array_len,
+	uint16_t bit_len)
+{
+	if (byte_array_len * 8 < bit_len)
+		bit_len = byte_array_len * 8;
+
+	uint8_t mask;
+	uint16_t byte;
+
+	for (byte = 0; byte < byte_array_len; byte++) {
+		if (bit_len >= 8) {
+			bit_len -= 8;
+			mask = 0x00;
+
+		} else if (bit_len > 0) {
+			mask = 0xff >> bit_len << bit_len;
+			bit_len = 0;
+
+		} else {
+			mask = 0xFF;
+		}
+
+		if (byte_array[byte] & mask)
+			return false;
+	}
+
+	return true;
+}
+
+static int copy_fd_to_fh_flm(struct flow_handle *fh, const struct nic_flow_def *fd,
 	const uint32_t *packet_data, uint32_t flm_key_id, uint32_t flm_ft,
 	uint16_t rpl_ext_ptr, uint32_t flm_scrub __rte_unused, uint32_t priority)
 {
@@ -3056,23 +3085,47 @@ static void copy_fd_to_fh_flm(struct flow_handle *fh, const struct nic_flow_def
 		switch (fd->modify_field[i].select) {
 		case CPY_SELECT_DSCP_IPV4:
 		case CPY_SELECT_DSCP_IPV6:
+			if (!has_only_valid_bits_set(fd->modify_field[i].value8, 16, 8)) {
+				NT_LOG(ERR, FILTER, "IP DSCP value is out of the range");
+				return -1;
+			}
+
 			fh->flm_dscp = fd->modify_field[i].value8[0];
 			break;
 
 		case CPY_SELECT_RQI_QFI:
+			if (!has_only_valid_bits_set(fd->modify_field[i].value8, 16, 6)) {
+				NT_LOG(ERR, FILTER, "GTPU QFI value is out of the range");
+				return -1;
+			}
+
 			fh->flm_rqi = (fd->modify_field[i].value8[0] >> 6) & 0x1;
 			fh->flm_qfi = fd->modify_field[i].value8[0] & 0x3f;
 			break;
 
 		case CPY_SELECT_IPV4:
+			if (!has_only_valid_bits_set(fd->modify_field[i].value8, 16, 32)) {
+				NT_LOG(ERR, FILTER, "IPv4 address value is out of the range");
+				return -1;
+			}
+
 			fh->flm_nat_ipv4 = ntohl(fd->modify_field[i].value32[0]);
 			break;
 
 		case CPY_SELECT_PORT:
+			if (!has_only_valid_bits_set(fd->modify_field[i].value8, 16, 16)) {
+				NT_LOG(ERR, FILTER, "NAT port value is out of the range");
+				return -1;
+			}
+
 			fh->flm_nat_port = ntohs(fd->modify_field[i].value16[0]);
 			break;
 
 		case CPY_SELECT_TEID:
+			if (!has_only_valid_bits_set(fd->modify_field[i].value8, 16, 32)) {
+				NT_LOG(ERR, FILTER, "GTPU TEID value is out of the range");
+				return -1;
+			}
 			fh->flm_teid = ntohl(fd->modify_field[i].value32[0]);
 			break;
 
@@ -3085,6 +3138,8 @@ static void copy_fd_to_fh_flm(struct flow_handle *fh, const struct nic_flow_def
 
 	fh->flm_mtu_fragmentation_recipe = fd->flm_mtu_fragmentation_recipe;
 	fh->context = fd->age.context;
+
+	return 0;
 }
 
 static int convert_fh_to_fh_flm(struct flow_handle *fh, const uint32_t *packet_data,
@@ -3113,8 +3168,10 @@ static int convert_fh_to_fh_flm(struct flow_handle *fh, const uint32_t *packet_d
 	for (int i = 0; i < RES_COUNT; ++i)
 		fh->flm_db_idxs[i] = fh_copy.db_idxs[i];
 
-	copy_fd_to_fh_flm(fh, fd, packet_data, flm_key_id, flm_ft, rpl_ext_ptr, flm_scrub,
-		priority);
+	if (copy_fd_to_fh_flm(fh, fd, packet_data, flm_key_id, flm_ft, rpl_ext_ptr,
+		flm_scrub, priority) < 0) {
+		return -1;
+	}
 
 	free(fd);
 
@@ -3476,8 +3533,11 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 		}
 
 		/* Program flow */
-		convert_fh_to_fh_flm(fh, packet_data, flm_idx.id1 + 2, flm_ft, flm_rpl_ext_ptr,
-			flm_scrub, attr->priority & 0x3);
+		if (convert_fh_to_fh_flm(fh, packet_data, flm_idx.id1 + 2, flm_ft, flm_rpl_ext_ptr,
+				flm_scrub, attr->priority & 0x3) != 0) {
+			flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+			goto error_out;
+		}
 		flm_flow_programming(fh, NT_FLM_OP_LEARN);
 
 		nic_insert_flow_flm(dev->ndev, fh);
@@ -3512,6 +3572,13 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 			/* Action Set doesn't contain jump */
 			action_set_data.contains_jump = 0;
 
+			/* Group 0 supports only modify action for TTL/Hop limit. */
+			if (fd->modify_field_count > 0) {
+				NT_LOG(ERR, FILTER, "Unsupported MODIFY ACTION for group 0");
+				flow_nic_set_error(ERR_MATCH_RESOURCE_EXHAUSTION, error);
+				goto error_out;
+			}
+
 			/* Setup COT */
 			struct hw_db_inline_cot_data cot_data = {
 				.matcher_color_contrib = 0,
@@ -5179,11 +5246,13 @@ struct flow_handle *flow_async_create_profile_inline(struct flow_eth_dev *dev,
 		fh->caller_id = template_table->caller_id;
 		fh->user_data = user_data;
 
-		copy_fd_to_fh_flm(fh, fd, packet_data, pattern_action_pair->flm_key_id,
-			pattern_action_pair->flm_ft,
-			pattern_action_pair->flm_rpl_ext_ptr,
-			pattern_action_pair->flm_scrub_prof,
-			template_table->attr.priority & 0x3);
+		if (copy_fd_to_fh_flm(fh, fd, packet_data, pattern_action_pair->flm_key_id,
+				pattern_action_pair->flm_ft,
+				pattern_action_pair->flm_rpl_ext_ptr,
+				pattern_action_pair->flm_scrub_prof,
+				template_table->attr.priority & 0x3) != 0) {
+			goto err_exit;
+		}
 
 		free(fd);
 
-- 
2.45.0

