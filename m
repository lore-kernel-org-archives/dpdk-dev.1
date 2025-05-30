Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D2BC54F30
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 07:14:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5E8A4065B;
	Fri, 30 May 2025 09:14:18 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011005.outbound.protection.outlook.com [40.107.130.5])
 by mails.dpdk.org (Postfix) with ESMTP id 157A6402A9
 for <dev@dpdk.org>; Fri, 30 May 2025 09:14:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSZnSwwao6CEXTCo4ISjI6Si3xMvzzWjZFRzAmi8LN2yZnMhjPFQ1FzwWWRAdCLbFzDBVv3R+enY6M/qYk9bSRFgIoU071V4XlYTKpd8qWrlsU+WpAauMNjzhsH2a8owd//1LM4z6iNC1i/lnO+uaQ1NqnNk7i036RLyB1fADgxQEOL951erjvKZIyFZovFf1vYI0CBPuVvrN+j1Vw+Oxo52RNVmPK7pmtfjD4U325hHbnFTfd0AlWoSLa3uRfj7e3dun9ZrgJHLtsHun6ymnghDXWBuNTm2zlBoN8i7lg3w3QR4eV6xOA0NmiLSdo+4G0bOUCARtQzsVJgrUrztUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZq0n0QD122SEdi3KGERshbSJWaMieKqbM3EQAVYCwo=;
 b=EbrTboykp3zevCN2uKusG3+5xFIr6/Fq62hsX1305I6fYyK8tQBBSkDri04OxNMK6WsS5pf/b0Tdnl1BGw4GDJ/AMqa8fyeyCmN4v4r+R48rvXGUA8Go3lNi2+jZuL/tcNzJVwLjHhtzk9e4AzyrSkJGgkefqNbcuMpkUF4SJAJtME1uI+uxyXf60NV9MD5PavEyjNpiFtMx7QEwK3uJJNidWeBOFG00cK+xwJ8b9LlOUo/RdtHC+QxhyH1paj25v+TSmme53dGn1VeEXn1miP/ccHBX/8ES63d/ZxqFAYK2whwPpwiPq36YmGbM8/7M5jiiHj5CKjjVG1YkCGSoog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZq0n0QD122SEdi3KGERshbSJWaMieKqbM3EQAVYCwo=;
 b=iYWlgZLHgdyhnwbjRPUY/mv/TqB1Ay01QgkZwp3tSk7eXoXT9p9PZeUsv0HBJLNiwQllwkSn/mKHS0EjyWZx0HI4h3fWNQAosfC1bwcOgBIJNR906VBrPhtzulaWt+M0E5FygQCRnYVgFh28lnVW9qlcb2uL8wJz21XdBNPUxsKF6KOtHwXHBix+AUMd/TPkR0b86RkRhk19M1RE/BWCMNlw9/lz0LaAzXitbz/m+oxU/UkJXDdONpRDIide1BZN0dcmFvGI369CWO3YKcYs8dDE7YcUDJIu0ZRZ/vF4/5Fdd9+OYN33+CYwfcVzuelfaWxUcJKreoT3igG59toQPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com (2603:10a6:102:1c2::20)
 by DBAPR04MB7223.eurprd04.prod.outlook.com (2603:10a6:10:1a4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Fri, 30 May
 2025 07:14:16 +0000
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f]) by PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f%4]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 07:14:16 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>
Subject: [PATCH 05/11] net/dpaa2: add dpmac MC header file
Date: Fri, 30 May 2025 12:43:38 +0530
Message-Id: <20250530071344.2939434-6-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250530071344.2939434-1-g.singh@nxp.com>
References: <20250530071344.2939434-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0153.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::33) To PAXPR04MB8205.eurprd04.prod.outlook.com
 (2603:10a6:102:1c2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8205:EE_|DBAPR04MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: c5194020-eb11-4b94-65d6-08dd9f499624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?csmh9q0MW3z/EVzP4YclBr+D189UlpMQmYecO0evkGgndNoAcSrB6w1+LM4Z?=
 =?us-ascii?Q?52tr/Bqz4fJw1xDlq0I0TYbb0kXRmPl40Voe9Hj0x+YmbPCzstGJBm07I+jG?=
 =?us-ascii?Q?XgXSOf9DdB7wXZtfQX9OJ00IoVSbFng9wLynB+UEBMKjJSjj42fgPwNNSgR3?=
 =?us-ascii?Q?TEXdRRDspocQHNI8Q3MDoNPzJkWTRmRMxpjHavS6ktDd0HHf1Cc42FezHlcj?=
 =?us-ascii?Q?Nb7f4u6plrYuA8qCrm/s38iXjj6CMXC371nVBfEK6oNp3tnY6WBiqZC5QMxy?=
 =?us-ascii?Q?6jHG6sbaswmxdkRYX1ovleYz4tO96TE/PgzO5ZRpujK4cdFs1vy/8Goc0iI9?=
 =?us-ascii?Q?rueMJ1UsyocSBogcxbpL0ZEfDAVTge1+14ZGbCi9mmlUpGk/Zxj+/rB31kws?=
 =?us-ascii?Q?/c4GdNtvrb1Pf+wm4OqvaLH1s6hSh2gyv843eX7/BlHUu7H15RSZdvbS5iir?=
 =?us-ascii?Q?4Zqgr1uZ9l766WtU2Q8FrW5W+xQX1MIHvVTk09+UUqk7HayqhyQQag/+cVgG?=
 =?us-ascii?Q?KGN8Zh3aYMJb1hdw7OwYVqSZmLrBYTIgXzpFT1MjtZ1QF0FCfh1/ohpxNa0V?=
 =?us-ascii?Q?o/HZ4Bjazwsj1LJCkxUMgj7TBXffBpk5IrrGhxJRHvP5Cy7McSRHfwyJfZLR?=
 =?us-ascii?Q?6qaNvFYY9msvpIm3+Y5cHQvREs7I2P0CGnqYxzAvnMky5V4XGhcqNjpqJemg?=
 =?us-ascii?Q?nFWCToTgItwjkdRDZmumj41OG9eeX6XnqPVtJ30ptd5thNgIyE8AmS3xywS1?=
 =?us-ascii?Q?C1j56G94GKi0T4q4WOnRByRRZ653yeS0coZ+LxwYuCS5FWaL1bbT1fnc7kEt?=
 =?us-ascii?Q?MPo1hk+hcXtnE3hxFCFogHEC5Ub0RjQ6hJI4+aeWSM9ID7hsuVJzML0yicrB?=
 =?us-ascii?Q?hs9uhoPZjr28DqW6vNoCv2shsuKd7Wqcy7s/gYlLLtzgBr/lOrPVbpdqLUPj?=
 =?us-ascii?Q?rHad0PPp1BEfhyhVV7D2KylCBP+8IrMZN3W6cZEpKwnnqnf8/8Trh803Gxsh?=
 =?us-ascii?Q?EljoyQbve9od4ZAJiDCUpwn4GqE8E1VXbPoaXCUcuukkYKmtX7q90o5TeAzM?=
 =?us-ascii?Q?mrJuZyCPjFp/b35yH8U+6GF8Y0LfH6od8sEPQ/yWy8s3i46auZ5Nw+gXLJb7?=
 =?us-ascii?Q?YIGj7HFfx6wiau5F30Lcbbq0P5WxFXD+K64T90zEC+HvE7TRYhH6VFPpPJZR?=
 =?us-ascii?Q?DjjKq4/d88H4xOf+IZPaJMEXWcEWMw4pcMqeIB3RE6YNDWSmpimvAQY2reXS?=
 =?us-ascii?Q?Mjg1CTZ9ZirnAeTXEpELYHq+MRCNHui7A5nqfdmLk04yHIZMRCuIzQYEVCYQ?=
 =?us-ascii?Q?qxoSB3CetY0WFDwYzOSEFKfR9FNVAsuF0aBfAtX58adPA/7aVS+vPG1oOph7?=
 =?us-ascii?Q?eEF8dx5RJQxDSEPgXTrXhzq6UxEhK+LsHhK6vAS2k9Bz0jjHoS64as1uJEXw?=
 =?us-ascii?Q?kqBVygq9qXRmP4d0J0nz94jWYWSFjpC4J8VsUI/n+2RG+LRZ5hEEF9LLIG4M?=
 =?us-ascii?Q?36tNpuVQwapf/lQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8205.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UbyOL1vG4NyrRCjYSnd4mpsfdMVNkIfzUlysIwtO/L6IMQ6t+91RaFr8fU7l?=
 =?us-ascii?Q?KmLiOelHcq/ecmSHtkSdtm25InmNxIsQdID/Wq1mpmhxdlpGQw8VNSx/O2GQ?=
 =?us-ascii?Q?m27aPKmkfTN5S8uCygDRNJeNY+2fXHNEBOXRUD4ujoGENfN4ypS5IhhqLpIJ?=
 =?us-ascii?Q?bKo93TadiCl2Bq0OgFGOKKLHUEt9uEAGv2yQyLoiR5VCMrC3lXmxVsPJu0LS?=
 =?us-ascii?Q?Jim3mKaPGcVxwAEcHjLrg5R/WMFbk2dTsv6NUFfOYIxgQ5QooUOydtHizXiC?=
 =?us-ascii?Q?YhqGPciaY32+vOExC9nd5ZBi/nnJMa1jzjPEEpMEILAfxxlRfYaju/RMVIk8?=
 =?us-ascii?Q?0awG7NvVTAo99Fd4W4Cnkg8/LSTwd9aCcQdeyIj1BbqM5p4plnbUkOOj0EAL?=
 =?us-ascii?Q?SCsJtKlRsZH2EZB/XWg2n77lihAWD95DF+5cWw9R1W+I6iR68I2NIr/VKfaE?=
 =?us-ascii?Q?wwbIlRzPRzF9bLy+rO2z3PF0iG9xybtsYi6vWeo6xFdh7B74+4XAu9ZLGS7j?=
 =?us-ascii?Q?l248bu1GXG+caVkMIUNzPRoOfBYEiywaHvrDEbc60e4QD/GQ4H7HusSCqHx7?=
 =?us-ascii?Q?HC0FsgvdOdn6odtE/nPLQeF7dBfMG61I6jb3lE66DoGIJqHufZqjH9ZZLglW?=
 =?us-ascii?Q?ln0ILyQnu5b//1+D8RxgdhwIQLy2q0HcNU3j2AlJuddV8rSUv0MhlNq0pqy1?=
 =?us-ascii?Q?yX9M7B84j4a/2mcfZ+ptjqZtHhTvq5RPNbavkuQ+BlpEwYH/1PQPi/WtJYn2?=
 =?us-ascii?Q?Pmz+xjxDtfGI99fMeBHz0WjI5B1yzo5KhiVys1VL4StonlKdosRd1cL0r8k+?=
 =?us-ascii?Q?Memwx5YLNvbnFgaRBY6bnDEr2R38i6mejQFG4jc6+tSt5uNwAJZmnI69+Siz?=
 =?us-ascii?Q?4mjXqJbMviNKzvbAYDisdzD1RKuoq8toJpt9Ny6107tlbmFXdMDu4UrJ5I5e?=
 =?us-ascii?Q?NOCIQGEAJGVBfVDbdw8x+emcPYBjNvWm19FSSQUchxrHmYSpVjzkkQdaDK6U?=
 =?us-ascii?Q?Y8UnIV80a67zyobr66hXYt679i2UFMB1H51BkopFECnbWgTdcEJ9G+q7EA+C?=
 =?us-ascii?Q?5SQb8RJVpDEVSFmV1AtIw33mv7tPVwBw+OsV1l0tloT1logI5KKDKjwK7FwA?=
 =?us-ascii?Q?dxb2CRRKLuFvO/+oP23p/X1/hfz2vI6xTI7y1k6XflDlkz352o6Mfkn7LGUb?=
 =?us-ascii?Q?qi8trzsvgxsPML+SfVu45TbrZ8lrSJSpTOHCQRx/U6Mul8KP/MyivXeHKsOf?=
 =?us-ascii?Q?nuOhEpKEX2Vj7rffjaCAILbTFlss9dmQjxLv1PyZPb43jQ2a7JiYq7hRUGPZ?=
 =?us-ascii?Q?iwxLCU7K9Tgbq8b2bRvXTZFItHzXOoFMJs/b/cNErzjYH+8ewfBbIUfA8o+e?=
 =?us-ascii?Q?VIfi2IzoanuhnLZaEw8eNQYRdMLolw0Rr3Jv1BESvWLEZVNAZOgmkvCyfqlI?=
 =?us-ascii?Q?Fh85Ogamh2HU4vjzmCw9iTrK6KIAzoV72GBBhvvOF0Y2gagoiQmbiqJ2ZMew?=
 =?us-ascii?Q?nhnF2Z3tDGs+t56blLVmvXs8+qUpvhB0I33n5zVtT8hNXMLE+0hk+nqKJTf9?=
 =?us-ascii?Q?Uq3JcYv02NWUCAzl3mc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5194020-eb11-4b94-65d6-08dd9f499624
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8205.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:14:16.1304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLvgg/GZKa5evVveC2ZzKuMWXa6drX8gQdSj4cgEwmDKHw9NgI/QqdGX+1XKLqa9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7223
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

From: Apeksha Gupta <apeksha.gupta@nxp.com>

This patch upgrades the MC firmware release API compatibility
to 10.39.0. Added mc/fsl_dpmac.h file.

Signed-off-by: Apeksha Gupta <apeksha.gupta@nxp.com>
---
 drivers/net/dpaa2/mc/fsl_dpmac.h | 490 +++++++++++++++++++++++++++++++
 1 file changed, 490 insertions(+)
 create mode 100644 drivers/net/dpaa2/mc/fsl_dpmac.h

diff --git a/drivers/net/dpaa2/mc/fsl_dpmac.h b/drivers/net/dpaa2/mc/fsl_dpmac.h
new file mode 100644
index 0000000000..f1be36ee79
--- /dev/null
+++ b/drivers/net/dpaa2/mc/fsl_dpmac.h
@@ -0,0 +1,490 @@
+/* Copyright 2013-2016 Freescale Semiconductor Inc.
+ * Copyright 2018-2022, 2024 NXP
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ * * Redistributions of source code must retain the above copyright
+ * notice, this list of conditions and the following disclaimer.
+ * * Redistributions in binary form must reproduce the above copyright
+ * notice, this list of conditions and the following disclaimer in the
+ * documentation and/or other materials provided with the distribution.
+ * * Neither the name of the above-listed copyright holders nor the
+ * names of any contributors may be used to endorse or promote products
+ * derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ */
+#ifndef __FSL_DPMAC_H
+#define __FSL_DPMAC_H
+
+/** @addtogroup dpmac Data Path MAC API
+ * Contains initialization APIs and runtime control APIs for DPMAC
+ * @{
+ */
+
+struct fsl_mc_io;
+
+int dpmac_open(struct fsl_mc_io *mc_io,
+	       uint32_t cmd_flags,
+	       int dpmac_id,
+	       uint16_t *token);
+
+int dpmac_close(struct fsl_mc_io *mc_io,
+		uint32_t cmd_flags,
+		uint16_t token);
+
+/**
+ * enum dpmac_link_type -  DPMAC link type
+ * @DPMAC_LINK_TYPE_NONE: No link
+ * @DPMAC_LINK_TYPE_FIXED: Link is fixed type
+ * @DPMAC_LINK_TYPE_PHY: Link by PHY ID
+ * @DPMAC_LINK_TYPE_BACKPLANE: Backplane link type
+ */
+enum dpmac_link_type {
+	DPMAC_LINK_TYPE_NONE,
+	DPMAC_LINK_TYPE_FIXED,
+	DPMAC_LINK_TYPE_PHY,
+	DPMAC_LINK_TYPE_BACKPLANE
+};
+
+/**
+ * enum dpmac_eth_if - DPMAC Ethrnet interface
+ * @DPMAC_ETH_IF_MII: MII interface
+ * @DPMAC_ETH_IF_RMII: RMII interface
+ * @DPMAC_ETH_IF_SMII: SMII interface
+ * @DPMAC_ETH_IF_GMII: GMII interface
+ * @DPMAC_ETH_IF_RGMII: RGMII interface
+ * @DPMAC_ETH_IF_SGMII: SGMII interface
+ * @DPMAC_ETH_IF_QSGMII: QSGMII interface
+ * @DPMAC_ETH_IF_XAUI: XAUI interface
+ * @DPMAC_ETH_IF_XFI: XFI interface
+ * @DPMAC_ETH_IF_CAUI: CAUI interface
+ * @DPMAC_ETH_IF_1000BASEX: 1000BASEX interface
+ * @DPMAC_ETH_IF_USXGMII: USXGMII interface
+ */
+enum dpmac_eth_if {
+	DPMAC_ETH_IF_MII,
+	DPMAC_ETH_IF_RMII,
+	DPMAC_ETH_IF_SMII,
+	DPMAC_ETH_IF_GMII,
+	DPMAC_ETH_IF_RGMII,
+	DPMAC_ETH_IF_SGMII,
+	DPMAC_ETH_IF_QSGMII,
+	DPMAC_ETH_IF_XAUI,
+	DPMAC_ETH_IF_XFI,
+	DPMAC_ETH_IF_CAUI,
+	DPMAC_ETH_IF_1000BASEX,
+	DPMAC_ETH_IF_USXGMII,
+};
+/*
+ * @DPMAC_FEC_NONE: RS-FEC (enabled by default) is disabled
+ * @DPMAC_FEC_RS: RS-FEC (Clause 91) mode configured
+ * @DPMAC_FEC_FC: FC-FEC (Clause 74) mode configured (not yet supported)
+ */
+enum dpmac_fec_mode {
+	DPMAC_FEC_NONE,
+	DPMAC_FEC_RS,
+	DPMAC_FEC_FC,
+};
+
+/* serdes sfi/custom settings feature internals
+ * @SERDES_CFG_DEFAULT: the default configuration.
+ * @SERDES_CFG_SFI: default operating mode for XFI interfaces
+ * @SERDES_CFG_CUSTOM: It allows the user to manually configure the type of equalization,
+ *	amplitude, preq and post1q settings. Can be used with all interfaces except RGMII.
+ */
+enum serdes_eq_cfg_mode {
+	SERDES_CFG_DEFAULT = 0,
+	SERDES_CFG_SFI,
+	SERDES_CFG_CUSTOM,
+};
+
+/**
+ * struct dpmac_cfg - Structure representing DPMAC configuration
+ * @mac_id:	Represents the Hardware MAC ID; in case of multiple WRIOP,
+ *		the MAC IDs are continuous.
+ *		For example:  2 WRIOPs, 16 MACs in each:
+ *				MAC IDs for the 1st WRIOP: 1-16,
+ *				MAC IDs for the 2nd WRIOP: 17-32.
+ */
+struct dpmac_cfg {
+	uint16_t mac_id;
+};
+
+int dpmac_create(struct fsl_mc_io *mc_io,
+		 uint16_t dprc_token,
+		 uint32_t cmd_flags,
+		 const struct dpmac_cfg *cfg,
+		 uint32_t *obj_id);
+
+int dpmac_destroy(struct fsl_mc_io *mc_io,
+		  uint16_t dprc_token,
+		  uint32_t cmd_flags,
+		  uint32_t object_id);
+
+/**
+ * DPMAC IRQ Index and Events
+ */
+
+/**
+ * IRQ index
+ */
+#define DPMAC_IRQ_INDEX				0
+/**
+ * IRQ event - indicates a change in link state
+ */
+#define DPMAC_IRQ_EVENT_LINK_CFG_REQ		0x00000001
+/**
+ * IRQ event - Indicates that the link state changed
+ */
+#define DPMAC_IRQ_EVENT_LINK_CHANGED		0x00000002
+/**
+ * IRQ event - The object requests link up
+ */
+#define DPMAC_IRQ_EVENT_LINK_UP_REQ			0x00000004
+/**
+ * IRQ event - The object requests link down
+ */
+#define DPMAC_IRQ_EVENT_LINK_DOWN_REQ		0x00000008
+/**
+ * IRQ event - indicates a change in endpoint
+ */
+#define DPMAC_IRQ_EVENT_ENDPOINT_CHANGED	0x00000010
+
+int dpmac_set_irq_enable(struct fsl_mc_io *mc_io,
+			 uint32_t cmd_flags,
+			 uint16_t token,
+			 uint8_t irq_index,
+			 uint8_t en);
+
+int dpmac_get_irq_enable(struct fsl_mc_io *mc_io,
+			 uint32_t cmd_flags,
+			 uint16_t token,
+			 uint8_t irq_index,
+			 uint8_t *en);
+
+int dpmac_set_irq_mask(struct fsl_mc_io *mc_io,
+		       uint32_t cmd_flags,
+		       uint16_t token,
+		       uint8_t irq_index,
+		       uint32_t mask);
+
+int dpmac_get_irq_mask(struct fsl_mc_io *mc_io,
+		       uint32_t cmd_flags,
+		       uint16_t token,
+		       uint8_t irq_index,
+		       uint32_t *mask);
+
+int dpmac_get_irq_status(struct fsl_mc_io *mc_io,
+			 uint32_t cmd_flags,
+			 uint16_t token,
+			 uint8_t irq_index,
+			 uint32_t *status);
+
+int dpmac_clear_irq_status(struct fsl_mc_io *mc_io,
+			   uint32_t cmd_flags,
+			   uint16_t token,
+			   uint8_t irq_index,
+			   uint32_t status);
+
+/**
+ * @brief	Inter-Frame Gap mode
+ *
+ * LAN/WAN uses different Inter-Frame Gap mode
+ */
+enum dpmac_ifg_mode {
+	DPMAC_IFG_MODE_FIXED,
+	/*!< IFG length represents number of octets in steps of 4 */
+	DPMAC_IFG_MODE_STRECHED
+	/*!< IFG length represents the stretch factor */
+};
+
+/**
+ * @brief Structure representing Inter-Frame Gap mode configuration
+ */
+struct dpmac_ifg_cfg {
+	enum dpmac_ifg_mode ipg_mode; /*!< WAN/LAN mode */
+	uint8_t ipg_length; /*!< IPG Length, default value is 0xC */
+};
+
+/**
+ * @brief Structure used to read through MDIO
+ */
+struct dpmac_mdio_read {
+	uint8_t cl45; /*!< Clause 45 */
+	uint8_t phy_addr; /*!< MDIO PHY address */
+	uint16_t reg; /*!< PHY register */
+};
+
+/**
+ * @brief Structure used to write through MDIO
+ */
+struct dpmac_mdio_write {
+	uint8_t cl45; /*!< Clause 45 */
+	uint8_t phy_addr; /*!< MDIO PHY address */
+	uint16_t reg; /*!< PHY register */
+	uint16_t data; /*!< Data to be written */
+};
+
+#define DPMAC_SET_PARAMS_IFG 0x1
+
+/**
+ * struct serdes_eq_settings - Structure  SerDes equalization settings
+ * cfg: serdes sfi/custom/default settings feature internals
+ * @eq_type: Number of levels of TX equalization
+ * @sgn_preq: Precursor sign indicating direction of eye closure
+ * @eq_preq: Drive strength of TX full swing transition bit to precursor
+ * @sgn_post1q: First post-cursor sign indicating direction of eye closure
+ * @eq_post1q: Drive strength of full swing transition bit to first post-cursor
+ * @eq_amp_red: Overall transmit amplitude reduction
+ */
+struct serdes_eq_settings {
+	enum serdes_eq_cfg_mode cfg;
+	int eq_type;
+	int sgn_preq;
+	int eq_preq;
+	int sgn_post1q;
+	int eq_post1q;
+	int eq_amp_red;
+};
+
+/**
+ * struct dpmac_attr - Structure representing DPMAC attributes
+ * @id:		DPMAC object ID
+ * @max_rate:	Maximum supported rate - in Mbps
+ * @eth_if:	Ethernet interface
+ * @link_type:	link type
+ * @fec_mode:	FEC mode - Configurable only for 25G interfaces
+ * serdes_cfg:	SerDes equalization settings
+ */
+struct dpmac_attr {
+	uint16_t id;
+	uint32_t max_rate;
+	enum dpmac_eth_if eth_if;
+	enum dpmac_link_type link_type;
+	enum dpmac_fec_mode fec_mode;
+	struct serdes_eq_settings serdes_cfg;
+	struct dpmac_ifg_cfg ifg_cfg;
+};
+
+int dpmac_get_attributes(struct fsl_mc_io *mc_io,
+			 uint32_t cmd_flags,
+			 uint16_t token,
+			 struct dpmac_attr *attr);
+
+int dpmac_set_params(struct fsl_mc_io *mc_io,
+		       uint32_t cmd_flags,
+		       uint16_t token,
+			   uint32_t flags,
+			   struct dpmac_ifg_cfg ifg_cfg);
+
+int dpmac_get_mac_addr(struct fsl_mc_io *mc_io,
+			   uint32_t cmd_flags,
+			   uint16_t token,
+			   uint8_t mac_addr[6]);
+
+/**
+ * DPMAC link configuration/state options
+ */
+
+/**
+ * Enable auto-negotiation
+ */
+#define DPMAC_LINK_OPT_AUTONEG		0x0000000000000001ULL
+/**
+ * Enable half-duplex mode
+ */
+#define DPMAC_LINK_OPT_HALF_DUPLEX	0x0000000000000002ULL
+/**
+ * Enable pause frames
+ */
+#define DPMAC_LINK_OPT_PAUSE		0x0000000000000004ULL
+/**
+ * Enable a-symmetric pause frames
+ */
+#define DPMAC_LINK_OPT_ASYM_PAUSE	0x0000000000000008ULL
+/**
+ * Advertise 10MB full duplex
+ */
+#define DPMAC_ADVERTISED_10BASET_FULL           0x0000000000000001ULL
+/**
+ * Advertise 100MB full duplex
+ */
+#define DPMAC_ADVERTISED_100BASET_FULL          0x0000000000000002ULL
+/**
+ * Advertise 1GB full duplex
+ */
+#define DPMAC_ADVERTISED_1000BASET_FULL         0x0000000000000004ULL
+/**
+ * Advertise auto-negotiation enable
+ */
+#define DPMAC_ADVERTISED_AUTONEG                0x0000000000000008ULL
+/**
+ * Advertise 10GB full duplex
+ */
+#define DPMAC_ADVERTISED_10000BASET_FULL        0x0000000000000010ULL
+/**
+ * Advertise 2.5GB full duplex
+ */
+#define DPMAC_ADVERTISED_2500BASEX_FULL         0x0000000000000020ULL
+/**
+ * Advertise 5GB full duplex
+ */
+#define DPMAC_ADVERTISED_5000BASET_FULL         0x0000000000000040ULL
+
+/**
+ * struct dpmac_link_cfg - Structure representing DPMAC link configuration
+ * @rate: Link's rate - in Mbps
+ * @options: Enable/Disable DPMAC link cfg features (bitmap)
+ * @advertising: Speeds that are advertised for autoneg (bitmap)
+ */
+struct dpmac_link_cfg {
+	uint32_t rate;
+	uint64_t options;
+	uint64_t advertising;
+};
+
+int dpmac_get_link_cfg(struct fsl_mc_io *mc_io,
+		       uint32_t cmd_flags,
+		       uint16_t token,
+		       struct dpmac_link_cfg *cfg);
+
+/**
+ * struct dpmac_link_state - DPMAC link configuration request
+ * @rate: Rate in Mbps
+ * @options: Enable/Disable DPMAC link cfg features (bitmap)
+ * @up: Link state
+ * @state_valid: Ignore/Update the state of the link
+ * @supported: Speeds capability of the phy (bitmap)
+ * @advertising: Speeds that are advertised for autoneg (bitmap)
+ */
+struct dpmac_link_state {
+	uint32_t rate;
+	uint64_t options;
+	int up;
+	int state_valid;
+	uint64_t supported;
+	uint64_t advertising;
+};
+
+int dpmac_set_link_state(struct fsl_mc_io *mc_io,
+			 uint32_t cmd_flags,
+			 uint16_t token,
+			 struct dpmac_link_state *link_state);
+
+/**
+ * enum dpmac_counter - DPMAC counter types
+ * @DPMAC_CNT_ING_FRAME_64: counts 64-bytes frames, good or bad.
+ * @DPMAC_CNT_ING_FRAME_127: counts 65- to 127-bytes frames, good or bad.
+ * @DPMAC_CNT_ING_FRAME_255: counts 128- to 255-bytes frames, good or bad.
+ * @DPMAC_CNT_ING_FRAME_511: counts 256- to 511-bytes frames, good or bad.
+ * @DPMAC_CNT_ING_FRAME_1023: counts 512- to 1023-bytes frames, good or bad.
+ * @DPMAC_CNT_ING_FRAME_1518: counts 1024- to 1518-bytes frames, good or bad.
+ * @DPMAC_CNT_ING_FRAME_1519_MAX: counts 1519-bytes frames and larger
+ *				  (up to max frame length specified),
+ *				  good or bad.
+ * @DPMAC_CNT_ING_FRAG: counts frames which are shorter than 64 bytes received
+ *			with a wrong CRC
+ * @DPMAC_CNT_ING_JABBER: counts frames longer than the maximum frame length
+ *			  specified, with a bad frame check sequence.
+ * @DPMAC_CNT_ING_FRAME_DISCARD: counts dropped frames due to internal errors.
+ *				 Occurs when a receive FIFO overflows.
+ *				 Includes also frames truncated as a result of
+ *				 the receive FIFO overflow.
+ * @DPMAC_CNT_ING_ALIGN_ERR: counts frames with an alignment error
+ *			     (optional used for wrong SFD).
+ * @DPMAC_CNT_EGR_UNDERSIZED: counts frames transmitted that was less than 64
+ *			      bytes long with a good CRC.
+ * @DPMAC_CNT_ING_OVERSIZED: counts frames longer than the maximum frame length
+ *			     specified, with a good frame check sequence.
+ * @DPMAC_CNT_ING_VALID_PAUSE_FRAME: counts valid pause frames (regular and PFC)
+ * @DPMAC_CNT_EGR_VALID_PAUSE_FRAME: counts valid pause frames transmitted
+ *				     (regular and PFC).
+ * @DPMAC_CNT_ING_BYTE: counts bytes received except preamble for all valid
+ *			frames and valid pause frames.
+ * @DPMAC_CNT_ING_MCAST_FRAME: counts received multicast frames.
+ * @DPMAC_CNT_ING_BCAST_FRAME: counts received broadcast frames.
+ * @DPMAC_CNT_ING_ALL_FRAME: counts each good or bad frames received.
+ * @DPMAC_CNT_ING_UCAST_FRAME: counts received unicast frames.
+ * @DPMAC_CNT_ING_ERR_FRAME: counts frames received with an error
+ *			     (except for undersized/fragment frame).
+ * @DPMAC_CNT_EGR_BYTE: counts bytes transmitted except preamble for all valid
+ *			frames and valid pause frames transmitted.
+ * @DPMAC_CNT_EGR_MCAST_FRAME: counts transmitted multicast frames.
+ * @DPMAC_CNT_EGR_BCAST_FRAME: counts transmitted broadcast frames.
+ * @DPMAC_CNT_EGR_UCAST_FRAME: counts transmitted unicast frames.
+ * @DPMAC_CNT_EGR_ERR_FRAME: counts frames transmitted with an error.
+ * @DPMAC_CNT_ING_GOOD_FRAME: counts frames received without error, including
+ *			      pause frames.
+ * @DPMAC_CNT_EGR_GOOD_FRAME: counts frames transmitted without error, including
+ *			      pause frames.
+ */
+enum dpmac_counter {
+	DPMAC_CNT_ING_FRAME_64,
+	DPMAC_CNT_ING_FRAME_127,
+	DPMAC_CNT_ING_FRAME_255,
+	DPMAC_CNT_ING_FRAME_511,
+	DPMAC_CNT_ING_FRAME_1023,
+	DPMAC_CNT_ING_FRAME_1518,
+	DPMAC_CNT_ING_FRAME_1519_MAX,
+	DPMAC_CNT_ING_FRAG,
+	DPMAC_CNT_ING_JABBER,
+	DPMAC_CNT_ING_FRAME_DISCARD,
+	DPMAC_CNT_ING_ALIGN_ERR,
+	DPMAC_CNT_EGR_UNDERSIZED,
+	DPMAC_CNT_ING_OVERSIZED,
+	DPMAC_CNT_ING_VALID_PAUSE_FRAME,
+	DPMAC_CNT_EGR_VALID_PAUSE_FRAME,
+	DPMAC_CNT_ING_BYTE,
+	DPMAC_CNT_ING_MCAST_FRAME,
+	DPMAC_CNT_ING_BCAST_FRAME,
+	DPMAC_CNT_ING_ALL_FRAME,
+	DPMAC_CNT_ING_UCAST_FRAME,
+	DPMAC_CNT_ING_ERR_FRAME,
+	DPMAC_CNT_EGR_BYTE,
+	DPMAC_CNT_EGR_MCAST_FRAME,
+	DPMAC_CNT_EGR_BCAST_FRAME,
+	DPMAC_CNT_EGR_UCAST_FRAME,
+	DPMAC_CNT_EGR_ERR_FRAME,
+	DPMAC_CNT_ING_GOOD_FRAME,
+	DPMAC_CNT_EGR_GOOD_FRAME
+};
+
+int dpmac_get_counter(struct fsl_mc_io *mc_io,
+		      uint32_t cmd_flags,
+		      uint16_t token,
+		      enum dpmac_counter  type,
+		      uint64_t *counter);
+
+int dpmac_get_api_version(struct fsl_mc_io *mc_io,
+			  uint32_t cmd_flags,
+			  uint16_t *major_ver,
+			  uint16_t *minor_ver);
+
+int dpmac_reset(struct fsl_mc_io *mc_io,
+		uint32_t cmd_flags,
+		uint16_t token);
+
+int dpmac_set_protocol(struct fsl_mc_io *mc_io, uint32_t cmd_flags,
+		       uint16_t token, enum dpmac_eth_if protocol);
+
+int dpmac_get_statistics(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
+			 uint64_t iova_cnt, uint64_t iova_values, uint32_t num_cnt);
+
+#endif /* __FSL_DPMAC_H */
-- 
2.25.1

