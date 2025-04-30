Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7947CC369DC
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:50:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98E2140662;
	Wed, 30 Apr 2025 15:49:25 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id E3AA3402BB
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:17 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2175.outbound.protection.outlook.com [104.47.17.175]) by
 mx-outbound12-177.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sH6IAjoRy/P1BEhnJPmanRWqJJdmbCMFOtvH1TsONv4b2tBUcKG2ZD473ThmGdKUJtskjSL6ecFgwrW5jEQsG5aAVoihF9lQecMELIlZXYA5dOk/xAVBKhaQmA+Q8e4HhuDQpe0Z4sVbWXCbjhxdVKCJZbLHUTETWJSzXFInjloAR9oNDD2ZmFD99OgnbXJQML3UvnLsyngezPxo2PWQbW5IFJ66N9Jw4Cb8Q3Z+9JqiyerCxBJAj3tQTcGsJJyX3lGqHWqW46ALnK5JO6TnVS3WObHhzB8C04fs3NNQSbe+0ZDIjR2lhxdbMPJbJgijvFntSxlA9v7kY8egmfeMmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ve8F8+aaU2oJtSlKNVauokq/p17708lGS9U6ev6ryjA=;
 b=CUDLuBAWLtUega8VCwjT0w8yZ/qurc+1i0IcbjFuDyuasPuKucoxM7LL7AFcXIeM+nRBGuzNFlbWLVqXD3GQTf+ZNBHuseC57e3vdtewNux0x68jK3Kogr/LEUceqBhMSTjhD3DT1FSN/aCZaExIh8oX7nY+QamL/aPuUxqWS4PznWYsLehaJliZnqwMjRNImE5RW5FuIu2DzYHZzQad8XrxAWMn1toAWEpdu6AXZT8VkKAlFv/2Z1YR+U6xucAUWRX9A+LcvsLLYZXqYum++sSl/dqGo6oXzm4ro5lGgmFL6NLsNLKuINblcRBGetBnLn/d5Ll887lTGBN8dvqrog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve8F8+aaU2oJtSlKNVauokq/p17708lGS9U6ev6ryjA=;
 b=OsX+A5lVFGa+iXu0RhFxgroD4QO6J7A5FDhF/dordvResHcaEArMZYb/ROLGnQhiBfxi5ZuB4klc2KCHmZAsEi92L02TmRPIhTxoJomyQzNYlxrPWZK75vXeYjxJKgetYrYxKbrf+nMeoWhRabTxegt14yKjXSY5w+A0yBnp1ek=
Received: from AM9P193CA0014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::19)
 by DBAP190MB0837.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 13:49:12 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::b7) by AM9P193CA0014.outlook.office365.com
 (2603:10a6:20b:21e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 30 Apr 2025 13:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:12 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 10/25] net/ntnic: remove unused code
Date: Wed, 30 Apr 2025 15:48:22 +0200
Message-ID: <20250430134840.402553-11-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|DBAP190MB0837:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e327c43f-38ee-4164-4893-08dd87edca3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iUMeHZ1eUiqIySGm4iixHAAeG+XPHd0wELJg1jlotEFpDWfuTirE8g3QuyUP?=
 =?us-ascii?Q?wK22OPvxdRhnohkcSIh+mi5PPDIhwWoS9WhnVG3odGOYpsCjMeadzJBHTg38?=
 =?us-ascii?Q?jjEN6/ACAp7ljg1v5J3l/vAGBF+4Lq2PpGcNBnF1xD6zZmDzPj9/DBNx/PJx?=
 =?us-ascii?Q?/S20qP3FdAqjnN2OCHL2DKEvfZSTL8sohCtk5r6NLtsKcKzd+6IcB66txjfB?=
 =?us-ascii?Q?a7Hgxc8/F/l5fcAeAfLa372cl+0TfTQyCxpeWkYTC/OWKwS5mq4kF6hpzBhN?=
 =?us-ascii?Q?XYrMxVz9tqWp53huVEFCa2U5J3Q3uEEdecWlItXSlFPweNDAf1ED/2LL8GaD?=
 =?us-ascii?Q?vYDPRj8SmtnsJ01udyN5Gmoj2+IMjjSJSB5O3zohkKBRGFN/ZHMbRH9cwLmP?=
 =?us-ascii?Q?orJSdCSm2tzp0N9PEJ+MG5ClvNC8J9Gg8VfqzMMAOlL0SKVIRDCBeqZ7q7v5?=
 =?us-ascii?Q?3FIQDrGW+YsLGHViJdWC+uhN1NmmTFJQ1FwKfsbjZrSEPC9pPvXOamAWL9Bs?=
 =?us-ascii?Q?mk5+vQqxizTy3iTUuQAZNO9My9yLG7X3oxve0j1HoEL60GsGb1Gk81VoQGfq?=
 =?us-ascii?Q?XcZkk5bsISEpksGzBVUvhG3ZwKqahX3MCkS2L86z5l9cD5e2vXsVHoBGILkQ?=
 =?us-ascii?Q?mOIFSlQ1DfiWqDYN1I6eZul7jB5FI17w73HIYp/bM+ljTvGQG+Fj7eVHuOZQ?=
 =?us-ascii?Q?dWSJuW2nImK2U4NqqLFrotndupBtICYDdQ1uyRhV46tjMQEcrEmnPWwRSkXD?=
 =?us-ascii?Q?BgwcmUZvpFs6XgAaH6RBEYhJ2N06xzGhIALsiOD9eNqFaUhgpWoa5NduJOIW?=
 =?us-ascii?Q?RfY+T/r4gWpIFSRdLarfhPoF7cuCv/qwrapgu+4EVhJXcg/SQV9IWaNIqNzb?=
 =?us-ascii?Q?UUz28KI3tZu+yZv+NYeVOt3IBE9ELbRTjEqt1Cjou/XSA1ROD4vBBxcw7mwS?=
 =?us-ascii?Q?WwMe+nNfDnxpLJy9kKtkrDWZXA+qFsbpEqJRr6iXdU/PUtBl7TlOcOY3yhTk?=
 =?us-ascii?Q?5yezonbiDfmUIao82BA4+oyHm3Xseo35GZ4SCSBqZKt5sGQ1xOaUD4fNtmRj?=
 =?us-ascii?Q?VGomUN7fvdl/A/OTYnH72ev+rYRb6PqYp5fdYyekesrRVajvf6Ow+4CnlVOk?=
 =?us-ascii?Q?hsufCaPWNKN0hOsCH8wHIhMVSSwCXTaVtqrngvU8FlmhMvUPx6rnDtAtZOq2?=
 =?us-ascii?Q?fvdWStlDErRFUqaMtc2gtZkOVI1tRXny8W2PFy+uOWPROmyJothQHi1eA5Q0?=
 =?us-ascii?Q?CmC2eXg9OvlBg7gL+ooUpPrzhNg+mYySMEDs+Y2ieOJT77yeIo7+0vKK0zyR?=
 =?us-ascii?Q?tCo4ZvqunYixMbwBMDOzPAJQ1yelLHWX9cIGA3hjDByDALVMSIUqsAtKhGzI?=
 =?us-ascii?Q?kfIZLjxZ2plUerhkEDtPRwnpAqYDSVBp0QrYP1J1xO/BuNKBW8G4iHFnulk5?=
 =?us-ascii?Q?VmMKQkA1pcxwHKGwX9iUJ/subWsbbBRNox2BQoJcQOFMmrdj/fZJQwTYCo6x?=
 =?us-ascii?Q?dE8pe+UZVAToK96K/CjjbAgHuLORSoMwedcH?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: st7lMTMBeFRKq4fC4+8vknSVOdDdoMxU9Iu4TZRxN+DWbMyn0zXsqERFdG+pIvFlXIJP08XGQ/eOYEfi7BXJPRgPCCeBi8jct5YCFXEWSHJNAHCcZwVlLsEGExbGB3ZY3Oagu9M1KJUOv5XkK8wlCCSxoUFgyHzZADcC7JHBbYyXo53baIMV+wDA4msGyjRgqZMzcfDuo3zDwuOGmSbd77uCbeqbCESNYsivuv6vT8DYGM6DB1brImjXQyjoTX7shXh7/Aey2kGcGcIoHyOeIBlNaNmQ/sgQL3pPlRjhbkNOltr4VSMgjKNPe3mXqyX8kgd5wlFgtmzdSfe/52Mls6qcpZv0Ed5eiLZRRP8PO2vCz35oqtvPH8SCP/PafFi5UVQb6pnXB84F9dq2AtJirQOJoxZ1zvAcs40H5o5OK9/19F9fGy4ec6BQpUMSzw10wiSq9DbX1T/G+aGaZgSEgo3DTHP7uIWy1Wj8vdy9jHOHFoBKF3l1Xa+z18e7VTKLC7x6txxJitoQOCL+SK/YRR/DmXQRAtVdLpb77Mivz1cQNPzqBlOU0wm47PCYdyt2M8CbFeJuo5n3XQyL7djt2aHyHRsTrmGRChz2L3ZRg93xZeoC52N2Lzl096hJ1PQoKi3RcrUTJLf8M/KoiZLBew==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:12.4879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e327c43f-38ee-4164-4893-08dd87edca3a
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0837
X-BESS-ID: 1746020954-303249-7652-575-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.17.175
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGhkYGQGYGUNQ8JTklMSU5yc
 IozTDV3NzSIMXE0NgyJdnAzNTMKNE0Wak2FgAgC46PQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan17-121.eu-central-1b.ess.aws.cudaops.com]
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

Remove unused CRC calculation and simplify AVR probe logging.
The condition is always false.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/nthw/core/nthw_fpga.c | 299 +-----------------------
 1 file changed, 11 insertions(+), 288 deletions(-)

diff --git a/drivers/net/ntnic/nthw/core/nthw_fpga.c b/drivers/net/ntnic/nthw/core/nthw_fpga.c
index 8831eeb4d3..485e912912 100644
--- a/drivers/net/ntnic/nthw/core/nthw_fpga.c
+++ b/drivers/net/ntnic/nthw/core/nthw_fpga.c
@@ -152,26 +152,6 @@ int nthw_fpga_silabs_detect(nthw_fpga_t *p_fpga, const int n_instance_no, const
 	return res;
 }
 
-/*
- * Calculate CRC-16-CCITT of passed data
- * CRC-16-CCITT ^16 + ^12 + ^5 + 1 (0x1021) (X.25, HDLC, XMODEM, Bluetooth,
- *   SD, many others; known as CRC-CCITT)
- */
-static uint16_t crc16(uint8_t *buffer, size_t length)
-{
-	uint16_t seed = 0;
-
-	while (length--) {
-		seed = (uint16_t)(seed >> 8 | seed << 8);
-		seed = (uint16_t)(seed ^ *buffer++);
-		seed = (uint16_t)(seed ^ (seed & 0xff) >> 4);
-		seed = (uint16_t)(seed ^ seed << 8 << 4);
-		seed = (uint16_t)(seed ^ (seed & 0xff) << 4 << 1);
-	}
-
-	return seed;
-}
-
 int nthw_fpga_avr_probe(nthw_fpga_t *p_fpga, const int n_instance_no)
 {
 	struct fpga_info_s *p_fpga_info = p_fpga->p_fpga_info;
@@ -314,150 +294,15 @@ int nthw_fpga_avr_probe(nthw_fpga_t *p_fpga, const int n_instance_no)
 		rx_buf.p_buf = &rx_data;
 		res = nthw_spi_v3_transfer(p_avr_spi, AVR_OP_SYSINFO_2, &tx_buf, &rx_buf);
 
-		if (res == 0 && avr_vpd_info.n_avr_spi_version >= 3 && rx_buf.size >= 16) {
-			if (rx_buf.size != 16) {
-				NT_LOG(WRN, NTHW,
-					"%s: AVR%d: SYSINFO2: reply is larger than expected: %04X %04X",
-					p_adapter_id_str, n_instance_no, rx_buf.size, 16);
-
-			} else {
-				NT_LOG(DBG, NTHW, "%s: AVR%d: SYSINFO2: OK: res=%d sz=%d",
-					p_adapter_id_str, n_instance_no, res, rx_buf.size);
-			}
-
-			avr_vpd_info.sysinfo_container_version = rx_data[0];
-			NT_LOG(DBG, NTHW, "%s: AVR%d: SYSINFO_REQ_VER: %d", p_adapter_id_str,
-				n_instance_no, avr_vpd_info.sysinfo_container_version);
-
-			memcpy(&avr_vpd_info.sysinfo_avr_libc_version, &rx_data[0 + 1],
-				sizeof(avr_vpd_info.sysinfo_avr_libc_version));
-			NT_LOG(DBG, NTHW, "%s: AVR%d: LIBC_VER: %d", p_adapter_id_str,
-				n_instance_no, avr_vpd_info.sysinfo_avr_libc_version);
-
-			avr_vpd_info.sysinfo_signature_0 = rx_data[5];
-			avr_vpd_info.sysinfo_signature_1 = rx_data[6];
-			avr_vpd_info.sysinfo_signature_2 = rx_data[7];
-			NT_LOG(DBG, NTHW, "%s: AVR%d: SIGNATURE: %02x%02x%02x", p_adapter_id_str,
-				n_instance_no, avr_vpd_info.sysinfo_signature_0,
-				avr_vpd_info.sysinfo_signature_1, avr_vpd_info.sysinfo_signature_2);
-
-			avr_vpd_info.sysinfo_spi_version = rx_data[8];
-			NT_LOG(DBG, NTHW, "%s: AVR%d: SPI_VER: %d", p_adapter_id_str,
-				n_instance_no, avr_vpd_info.sysinfo_spi_version);
-
-			avr_vpd_info.sysinfo_hw_revision = rx_data[9];
-			NT_LOG(DBG, NTHW, "%s: AVR%d: HW_REV: %d", p_adapter_id_str,
-				n_instance_no, avr_vpd_info.sysinfo_hw_revision);
-
-			avr_vpd_info.sysinfo_ticks_per_second = rx_data[10];
-			NT_LOG(DBG, NTHW, "%s: AVR%d: TICKS_PER_SEC: %d", p_adapter_id_str,
-				n_instance_no, avr_vpd_info.sysinfo_ticks_per_second);
-
-			memcpy(&avr_vpd_info.sysinfo_uptime, &rx_data[11],
-				sizeof(avr_vpd_info.sysinfo_uptime));
-			NT_LOG(DBG, NTHW, "%s: AVR%d: UPTIME: %d", p_adapter_id_str,
-				n_instance_no, avr_vpd_info.sysinfo_uptime);
-
-			avr_vpd_info.sysinfo_osccal = rx_data[15];
-			NT_LOG(DBG, NTHW, "%s: AVR%d: OSCCAL: %d", p_adapter_id_str,
-				n_instance_no, avr_vpd_info.sysinfo_osccal);
-
-			{
-				bool b_spi_ver_match = (avr_vpd_info.n_avr_spi_version ==
-						avr_vpd_info.sysinfo_spi_version);
-				(void)b_spi_ver_match;
-				NT_LOG(DBG, NTHW, "%s: AVR%d: SPI_VER_TST: %s (%d %d)",
-					p_adapter_id_str, n_instance_no,
-					(b_spi_ver_match ? "OK" : "MISMATCH"),
-					avr_vpd_info.n_avr_spi_version,
-					avr_vpd_info.sysinfo_spi_version);
-			}
-
-			/* SYSINFO2: if response: only populate hw_id not hw_id_emulated */
-			p_fpga_info->nthw_hw_info.hw_id = avr_vpd_info.sysinfo_hw_revision;
-
-		} else {
-			/* AVR_OP_SYSINFO */
-			tx_buf.size = 0;
-			tx_buf.p_buf = NULL;
-			rx_buf.size = sizeof(rx_data);
-			rx_buf.p_buf = &rx_data;
-			res = nthw_spi_v3_transfer(p_avr_spi, AVR_OP_SYSINFO, &tx_buf, &rx_buf);
-
-			if (res == 0 && avr_vpd_info.n_avr_spi_version >= 3 && rx_buf.size >= 16) {
-				if (rx_buf.size != 16) {
-					NT_LOG(WRN, NTHW,
-						"%s: AVR%d: SYSINFO: reply is larger than expected: %04X %04X",
-						p_adapter_id_str, n_instance_no, rx_buf.size, 16);
-
-				} else {
-					NT_LOG(DBG, NTHW, "%s: AVR%d: SYSINFO: OK: res=%d sz=%d",
-						p_adapter_id_str, n_instance_no, res, rx_buf.size);
-				}
-
-				avr_vpd_info.sysinfo_container_version = rx_data[0];
-				NT_LOG(DBG, NTHW, "%s: AVR%d: SYSINFO_REQ_VER: %d",
-					p_adapter_id_str, n_instance_no,
-					avr_vpd_info.sysinfo_container_version);
-
-				memcpy(&avr_vpd_info.sysinfo_avr_libc_version, &rx_data[0 + 1],
-					sizeof(avr_vpd_info.sysinfo_avr_libc_version));
-				NT_LOG(DBG, NTHW, "%s: AVR%d: LIBC_VER: %d", p_adapter_id_str,
-					n_instance_no, avr_vpd_info.sysinfo_avr_libc_version);
-
-				avr_vpd_info.sysinfo_signature_0 = rx_data[5];
-				avr_vpd_info.sysinfo_signature_1 = rx_data[6];
-				avr_vpd_info.sysinfo_signature_2 = rx_data[7];
-				NT_LOG(DBG, NTHW, "%s: AVR%d: SIGNATURE: %02x%02x%02x",
-					p_adapter_id_str, n_instance_no,
-					avr_vpd_info.sysinfo_signature_0,
-					avr_vpd_info.sysinfo_signature_1,
-					avr_vpd_info.sysinfo_signature_2);
-
-				avr_vpd_info.sysinfo_spi_version = rx_data[8];
-				NT_LOG(DBG, NTHW, "%s: AVR%d: SPI_VER: %d", p_adapter_id_str,
-					n_instance_no, avr_vpd_info.sysinfo_spi_version);
-
-				avr_vpd_info.sysinfo_hw_revision = rx_data[9];
-				NT_LOG(DBG, NTHW, "%s: AVR%d: HW_REV: %d", p_adapter_id_str,
-					n_instance_no, avr_vpd_info.sysinfo_hw_revision);
-				NT_LOG(INF, NTHW, "%s: AVR%d: HW_REV: %d", p_adapter_id_str,
-					n_instance_no, avr_vpd_info.sysinfo_hw_revision);
-
-				avr_vpd_info.sysinfo_ticks_per_second = rx_data[10];
-				NT_LOG(DBG, NTHW, "%s: AVR%d: TICKS_PER_SEC: %d",
-					p_adapter_id_str, n_instance_no,
-					avr_vpd_info.sysinfo_ticks_per_second);
-
-				memcpy(&avr_vpd_info.sysinfo_uptime, &rx_data[11],
-					sizeof(avr_vpd_info.sysinfo_uptime));
-				NT_LOG(DBG, NTHW, "%s: AVR%d: UPTIME: %d", p_adapter_id_str,
-					n_instance_no, avr_vpd_info.sysinfo_uptime);
-
-				avr_vpd_info.sysinfo_osccal = rx_data[15];
-				NT_LOG(DBG, NTHW, "%s: AVR%d: OSCCAL: %d", p_adapter_id_str,
-					n_instance_no, avr_vpd_info.sysinfo_osccal);
-
-				{
-					bool b_spi_ver_match = (avr_vpd_info.n_avr_spi_version ==
-							avr_vpd_info.sysinfo_spi_version);
-					(void)b_spi_ver_match;
-					NT_LOG(DBG, NTHW, "%s: AVR%d: SPI_VER_TST: %s (%d %d)",
-						p_adapter_id_str, n_instance_no,
-						(b_spi_ver_match ? "OK" : "MISMATCH"),
-						avr_vpd_info.n_avr_spi_version,
-						avr_vpd_info.sysinfo_spi_version);
-				}
-
-				p_fpga_info->nthw_hw_info.hw_id = avr_vpd_info.sysinfo_hw_revision;
-				p_fpga_info->nthw_hw_info.hw_id_emulated =
-					avr_vpd_info.sysinfo_hw_revision;
+		/* AVR_OP_SYSINFO */
+		tx_buf.size = 0;
+		tx_buf.p_buf = NULL;
+		rx_buf.size = sizeof(rx_data);
+		rx_buf.p_buf = &rx_data;
+		res = nthw_spi_v3_transfer(p_avr_spi, AVR_OP_SYSINFO, &tx_buf, &rx_buf);
 
-			} else {
-				NT_LOG(ERR, NTHW, "%s: AVR%d: SYSINFO: NA: res=%d sz=%d",
-					p_adapter_id_str, n_instance_no, res, rx_buf.size);
-			}
-		}
+		NT_LOG(ERR, NTHW, "%s: AVR%d: SYSINFO: NA: res=%d sz=%d",
+				p_adapter_id_str, n_instance_no, res, rx_buf.size);
 
 		/* AVR_OP_VPD_READ */
 		tx_buf.size = 0;
@@ -466,132 +311,10 @@ int nthw_fpga_avr_probe(nthw_fpga_t *p_fpga, const int n_instance_no)
 		rx_buf.p_buf = &rx_data;
 		res = nthw_spi_v3_transfer(p_avr_spi, AVR_OP_VPD_READ, &tx_buf, &rx_buf);
 
-		if (res == 0 && avr_vpd_info.n_avr_spi_version >= 3 &&
-			rx_buf.size >= GEN2_VPD_SIZE_TOTAL) {
-			avr_vpd_info.n_crc16_calced = crc16(rx_buf.p_buf, rx_buf.size - 2);
-			memcpy(&avr_vpd_info.n_crc16_stored, &rx_data[rx_buf.size - 2],
-				sizeof(avr_vpd_info.n_crc16_stored));
-			NT_LOG(DBG, NTHW, "%s: AVR%d: VPD_CRC: %04X %04X", p_adapter_id_str,
-				n_instance_no, avr_vpd_info.n_crc16_stored,
-				avr_vpd_info.n_crc16_calced);
-
-			avr_vpd_info.b_crc16_valid =
-				(avr_vpd_info.n_crc16_stored == avr_vpd_info.n_crc16_calced);
-			NT_LOG(DBG, NTHW, "%s: AVR%d: CRC_TST: %s", p_adapter_id_str,
-				n_instance_no, (avr_vpd_info.b_crc16_valid ? "OK" : "ERROR"));
-
-			if (avr_vpd_info.b_crc16_valid) {
-				memcpy(&avr_vpd_info.psu_hw_version, &rx_data[0],
-					sizeof(avr_vpd_info.psu_hw_version));
-				NT_LOG(DBG, NTHW, "%s: AVR%d: PSU_HW_VER: %d", p_adapter_id_str,
-					n_instance_no, avr_vpd_info.psu_hw_version);
-
-				memcpy(&avr_vpd_info.vpd_pn, &rx_data[0 + 1],
-					sizeof(avr_vpd_info.vpd_pn));
-				NT_LOG(DBG, NTHW, "%s: AVR%d: PN: '%.*s'", p_adapter_id_str,
-					n_instance_no, GEN2_PN_SIZE, avr_vpd_info.vpd_pn);
-
-				memcpy(&avr_vpd_info.vpd_pba, &rx_data[0 + 1 + GEN2_PN_SIZE],
-					sizeof(avr_vpd_info.vpd_pba));
-				NT_LOG(DBG, NTHW, "%s: AVR%d: PBA: '%.*s'", p_adapter_id_str,
-					n_instance_no, GEN2_PBA_SIZE, avr_vpd_info.vpd_pba);
-
-				memcpy(&avr_vpd_info.vpd_sn,
-					&rx_data[0 + 1 + GEN2_PN_SIZE + GEN2_PBA_SIZE],
-					sizeof(avr_vpd_info.vpd_sn));
-				NT_LOG(DBG, NTHW, "%s: AVR%d: SN: '%.*s", p_adapter_id_str,
-					n_instance_no, GEN2_SN_SIZE, avr_vpd_info.vpd_sn);
-
-				memcpy(&avr_vpd_info.vpd_board_name,
-					&rx_data[0 + 1 + GEN2_PN_SIZE + GEN2_PBA_SIZE +
-						GEN2_SN_SIZE],
-					sizeof(avr_vpd_info.vpd_board_name));
-				NT_LOG(DBG, NTHW, "%s: AVR%d: BN: '%.*s'", p_adapter_id_str,
-					n_instance_no, GEN2_BNAME_SIZE,
-					avr_vpd_info.vpd_board_name);
-
-				union mac_u {
-					uint8_t a_u8[8];
-					uint16_t a_u16[4];
-					uint32_t a_u32[2];
-					uint64_t a_u64[1];
-				} mac;
-
-				/* vpd_platform_section */
-				uint8_t *p_vpd_board_info =
-					(uint8_t *)(&rx_data[1 + GEN2_PN_SIZE + GEN2_PBA_SIZE +
-					GEN2_SN_SIZE + GEN2_BNAME_SIZE]);
-				memcpy(&avr_vpd_info.product_family, &p_vpd_board_info[0],
-					sizeof(avr_vpd_info.product_family));
-				NT_LOG(DBG, NTHW, "%s: AVR%d: PROD_FAM: %d", p_adapter_id_str,
-					n_instance_no, avr_vpd_info.product_family);
-
-				memcpy(&avr_vpd_info.feature_mask, &p_vpd_board_info[0 + 4],
-					sizeof(avr_vpd_info.feature_mask));
-				NT_LOG(DBG, NTHW, "%s: AVR%d: FMSK_VAL: 0x%08X",
-					p_adapter_id_str, n_instance_no, avr_vpd_info.feature_mask);
-
-				memcpy(&avr_vpd_info.invfeature_mask, &p_vpd_board_info[0 + 4 + 4],
-					sizeof(avr_vpd_info.invfeature_mask));
-				NT_LOG(DBG, NTHW, "%s: AVR%d: FMSK_INV: 0x%08X",
-					p_adapter_id_str, n_instance_no,
-					avr_vpd_info.invfeature_mask);
-
-				avr_vpd_info.b_feature_mask_valid =
-					(avr_vpd_info.feature_mask ==
-						~avr_vpd_info.invfeature_mask);
-				NT_LOG(DBG, NTHW, "%s: AVR%d: FMSK_TST: %s", p_adapter_id_str,
-					n_instance_no,
-					(avr_vpd_info.b_feature_mask_valid ? "OK" : "ERROR"));
-
-				memcpy(&avr_vpd_info.no_of_macs, &p_vpd_board_info[0 + 4 + 4 + 4],
-					sizeof(avr_vpd_info.no_of_macs));
-				NT_LOG(DBG, NTHW, "%s: AVR%d: NUM_MACS: %d", p_adapter_id_str,
-					n_instance_no, avr_vpd_info.no_of_macs);
-
-				memcpy(&avr_vpd_info.mac_address,
-					&p_vpd_board_info[0 + 4 + 4 + 4 + 1],
-					sizeof(avr_vpd_info.mac_address));
-				NT_LOG(DBG, NTHW,
-					"%s: AVR%d: MAC_ADDR: %02x:%02x:%02x:%02x:%02x:%02x",
-					p_adapter_id_str, n_instance_no,
-					avr_vpd_info.mac_address[0], avr_vpd_info.mac_address[1],
-					avr_vpd_info.mac_address[2], avr_vpd_info.mac_address[3],
-					avr_vpd_info.mac_address[4], avr_vpd_info.mac_address[5]);
-
-				mac.a_u64[0] = 0;
-				memcpy(&mac.a_u8[2], &avr_vpd_info.mac_address,
-					sizeof(avr_vpd_info.mac_address));
-				{
-					const uint32_t u1 = ntohl(mac.a_u32[0]);
-
-					if (u1 != mac.a_u32[0]) {
-						const uint32_t u0 = ntohl(mac.a_u32[1]);
-						mac.a_u32[0] = u0;
-						mac.a_u32[1] = u1;
-					}
-				}
-
-				avr_vpd_info.n_mac_val = mac.a_u64[0];
-				NT_LOG(DBG, NTHW, "%s: AVR%d: MAC_U64: %012" PRIX64 "",
-					p_adapter_id_str, n_instance_no, avr_vpd_info.n_mac_val);
-			}
-
-			p_fpga_info->nthw_hw_info.vpd_info.mn_mac_addr_count =
-				avr_vpd_info.no_of_macs;
-			p_fpga_info->nthw_hw_info.vpd_info.mn_mac_addr_value =
-				avr_vpd_info.n_mac_val;
-			memcpy(p_fpga_info->nthw_hw_info.vpd_info.ma_mac_addr_octets,
-				avr_vpd_info.mac_address,
-				ARRAY_SIZE(p_fpga_info->nthw_hw_info.vpd_info.ma_mac_addr_octets));
-
-		} else {
-			NT_LOG(ERR, NTHW, "%s:%u: res=%d", __func__, __LINE__, res);
-			NT_LOG(ERR, NTHW, "%s: AVR%d: SYSINFO2: NA: res=%d sz=%d",
-				p_adapter_id_str, n_instance_no, res, rx_buf.size);
-		}
+		NT_LOG(ERR, NTHW, "%s:%u: res=%d", __func__, __LINE__, res);
+		NT_LOG(ERR, NTHW, "%s: AVR%d: SYSINFO2: NA: res=%d sz=%d",
+			p_adapter_id_str, n_instance_no, res, rx_buf.size);
 	}
-
 	return res;
 }
 
-- 
2.47.1

