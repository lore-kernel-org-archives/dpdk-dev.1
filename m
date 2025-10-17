Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A34DCCD184
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 04:43:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 516E2402E3;
	Fri, 17 Oct 2025 06:43:16 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012024.outbound.protection.outlook.com [52.101.66.24])
 by mails.dpdk.org (Postfix) with ESMTP id E573940269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 06:43:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCUV+D/WExrZCPzNjnnJZSiIBWYsznkg8ZsPjuIpZiqV4y1p+H3EAGiG2zGIc5dcL+00jd/glf8BCTHB8G3QtPJ9LBpp2fX397eVx7d+74do42vC7Ykz6exabxRigzlb/o+VrMzJUpkJY4rBciCpRhI4pvUiwdM8i1OPIr1Ds2goUoxLUDnnHJ8/N9KYchnyPKIcsHNPHNziaZ6J7zyD+j5jhaWkPpbockoV9o3M1uISYnTB9QspCzn7Q0TlkZpli+H3YPmWFlj4i1VEQLO3vs7krctSSUK+XOXqnSQfAPz8GoTNMCPTFashbi9Lzr9rlsRv84VoUt2KYHkorsQwDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25+J2daI0YgwO3dxF+t8UYLXqnikYSPq9ovqCBcl0pw=;
 b=DVX+D9j5q7sbt8sD5fNUD95XKy5U7OJ4LkooW68Pfu7RWTHTdCkue59usHAgNGeTkz1QuIhI9E7rSS+tdBG1LQreTppia/nJZrmQ80B6VWWtMuwOFMr/R74pBHuSjlaVGf6oG4fdrGR46j64lwepdjzjZmRkM/iQwa4uND0KoBTZJuezkV85be8JT16iw68K7whodsqkDaHYm3hBR2Waj9OTr+MDk570xsccxGoFKD+Nf7yXm5OjHMB2cX7V3HkHNNd9Dlu8XE0jkqo4OgAfvBOjl7TfMBexglYQYyhWnREwGchN9HO1i8my1vGZBCYZOHWtyZlgl4OyhqNvF9etyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25+J2daI0YgwO3dxF+t8UYLXqnikYSPq9ovqCBcl0pw=;
 b=VC946a3IHW0ES7cc08WgyZqqLIYDVrdm/gvFqLrDF/kSAywUbGIhcDvlyu+Ns36OdC+3DkBXNEIPJcmY9NtSaN2c5a4w8iaG6sjnV+zAc1s06XM3PDoLKQI+Y00RYa2jpiD3aSyyb4+ulIhaExoruBz1qHu0mo1BV9Xxv+ZB9WmyrYurFFnR0wmyuw+/xy2MJwPuAB3Ihd773Ks/aiIWGUtxW6OY80/X9qRauM7Q2pOlM6YIJECkX+ZxbR2RpOpgWt4ImYZyCtW+zqUGd6MGVThT6/3KgfdOnuTyyIKmZulnLn1vOFQ3aW4o/d/+1R44uVu8mB2IKs3JARvf2ISixw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by GVXPR04MB11655.eurprd04.prod.outlook.com (2603:10a6:150:2c2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 04:43:12 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 04:43:11 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v4 0/6] DPAA specific changes
Date: Fri, 17 Oct 2025 10:12:50 +0530
Message-Id: <20251017044256.3264737-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251014101716.2885563-1-g.singh@nxp.com>
References: <20251014101716.2885563-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|GVXPR04MB11655:EE_
X-MS-Office365-Filtering-Correlation-Id: 72626fa3-7088-4e6f-205e-08de0d37ad5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MT3CARRh6CS5NoOvch0SW9AIuKw9lxhe7WsiZ+ne7k7D3sFG4czvhl7tydG3?=
 =?us-ascii?Q?JDgFZSfVhFOrA3yAJan2xt4Q/OsSVZf+9WbdIEI2GPb0d1YekBm8A6RXXFym?=
 =?us-ascii?Q?G5QdghZSJEKC6xopKGFf6eHDD7PBJFTLxncl/taKpWhjBuswfGu68qfDqmtw?=
 =?us-ascii?Q?qRQVDiow3I/5FMqzDn5YUQq5sqT6v4sNaB9jTV2sc62VbjhAjATE8p1E6DW1?=
 =?us-ascii?Q?yN2JeymYCoXSZz8v1p1JO7yrFxrblI79zK5/NUD0mVWNDbnxlDDNZ1XMp9RK?=
 =?us-ascii?Q?2hDgYWr/Xt3tHeXyyH/tB2LnTcKIhr+4eQl40VgvBMj2GpvZifwvbr2yDeDu?=
 =?us-ascii?Q?79pAF59KPXZi41SZIU5PqVaaeQsvKjpiniQD3TqCWTcv8tyxu4D5DDNyi8EW?=
 =?us-ascii?Q?2oARPAMbGL8RGYT1HjI55B7HJFdyx406YPlOpSDK+Z694ODa6TpDrIR0emZ2?=
 =?us-ascii?Q?iD10gR/21m796gQnx5tL9x1pWyUMRqx5PVGai8Q5ydEdS6AFvWBhjgcVziJQ?=
 =?us-ascii?Q?+eO3KNn91fHsU8UiDbaMal7YrcebTTSIRiiRZyFG3rlAN1JcRKXrY506hO66?=
 =?us-ascii?Q?0RGpTeP1DgEYc6wvmqZXII7T0xIVDoQOydW4XCMQwo0Gzjtsvq+z/gxQ5wk8?=
 =?us-ascii?Q?jmuyXcoMZzrAkMzWGSSPfRoTwOjG4Z7AorFkzXkMfVaqASfYyUHRKLYzxtrg?=
 =?us-ascii?Q?t7Pb59hTLy2faFHDeGpMxT3EN54CH0uZWktVqkye3J3ap9r3/JcN02QvB/Lf?=
 =?us-ascii?Q?5JOlIVe9HTXCsHCWALOplhZ8ARLdmznNhxtqBDULkzP9nQWgHYBFjgyhxEHK?=
 =?us-ascii?Q?W5SoI7X2LMCHKd2rq0398ieANNlvcxUphcSMBrIzUDQykgzOzJWMxqONSeoZ?=
 =?us-ascii?Q?DK1qrL9lP6QbQIX8eXkblhbSylnc0CiBrTh6K2PFbZkANqHDUr0AvJFx58QZ?=
 =?us-ascii?Q?ExyEbI0hR9zECBZ7AzeojAPxLSLaqM04Rr6DXs+OEXT4SrtH775osF+UtSlm?=
 =?us-ascii?Q?MvcRH6WScgX6blLNpVnPa2cmVq0oWHfYLCX8h5xYY3AeBT+kRQbx2xoWkedO?=
 =?us-ascii?Q?3sVpifljrThXG90Y/fFeW+QwvJJky6AzNSqDtuuTeiwMdHjYMsj1ApQLEo5S?=
 =?us-ascii?Q?7cFXfPxGbe0uD3c42fRuA1ilpm7oQjTC1qj/eOIcBVhKECY+cCvTDXpO/nx6?=
 =?us-ascii?Q?Y7fr+/UlBnapOOqCbQakeiDmRIoq7Wc7Yq2EIqUhngsj7NizH7MES8rGO91T?=
 =?us-ascii?Q?ex6uurXczVUUHMYvHurypYUiEirbEdY+utBQGIGEIPi5QiHRoiFiYLq3nCoZ?=
 =?us-ascii?Q?zfAB1JNXzlvCjR/nRFbBiXc6fjgBiqwHCE3V7s0NtLuOJiMqaVbBEnH/fXVr?=
 =?us-ascii?Q?lv+9iv/ee5gJRbq26uNJP/TGQWvcmwpXfhC+AbV1i8gxqa5bR2wmF4DGI9OT?=
 =?us-ascii?Q?NJ3MtdBJ56ChnFPNrZ2POSCFUWl1GO3eqcVMjiVHMstB5bPM+Y8+Sgr4qasA?=
 =?us-ascii?Q?YnKpKNKCxhw63vUanD8sOYamLol4iMZKmAs2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hzPrXeHSiWv0TABBEq+iq6M1FRvOhhoZMFhZfW5YF6vmi8v5VPmFGmqJC+zX?=
 =?us-ascii?Q?SzHTcYMPO90l9KJPYf+uAJEiJP378zrjoMbzWXRHw7uYotLxAeV6+zQlzf4s?=
 =?us-ascii?Q?BU79RRmSfB9+mOOrVVDRpJxGBWCgflu7IC56rGLWIs6eLUjKq8xkIsKfRL81?=
 =?us-ascii?Q?5Z89OXM09ZbZGUQjfWjhg9QvYsAcuSaP6kMJ09E7OaqMkFGIA79ani+GiMRl?=
 =?us-ascii?Q?c84zjQlYOHU/YrqXLNERGWJcUKa4kwK2hO7QCGpriCkEWhIgbQI3oC8yEzdp?=
 =?us-ascii?Q?GWgxsygvyneL1KikbrRw5QQ1tZNoTPRU2M8XqPCgIWk/cwZb0CeIJYcruupH?=
 =?us-ascii?Q?btF/48FEayqb2AhOVaLlX3agO4t28YARDVjXz4AxNVhWBU0P8sMleoPv9OpL?=
 =?us-ascii?Q?XQ8Rgxc+gMY5xMHa04qvgje/bRVPTyPbdNtP3pDz0qD6ZUbj+oB2kJGeQP5S?=
 =?us-ascii?Q?UO5vSgjrBkjy1hqBMTJxJqF17GLfkbKz1SRCZcodeDLM4xgOXpA+WODEaMVx?=
 =?us-ascii?Q?Sb0LDYtsDoJmC3A7psa6sFcdeX2gYnqhsz/v/qkp4hNgL5PnaT6Ktn6hk/yC?=
 =?us-ascii?Q?RGNWyyyzNRm542dqDChSohT9e/ZIbped88K6fnCVIrp225RhTljhOfu9c5ZO?=
 =?us-ascii?Q?ZjrfW0WtBB8TmbgQyMjEXtPatfFCL/O4ErWFVj/1UwGvSMdwFkxlSZti0EHg?=
 =?us-ascii?Q?OoJ+TyakB8xLlJIDgaWOwDP2Fm9WqeOB0/UGsnpXqaiLWOPUCQNX0K3Ci2Da?=
 =?us-ascii?Q?MnNrCL2c0sI2BBdM8Dmw9pc+v6z9Lynemwu8L9wgAQWkVLVApm0YpjrUc3Tj?=
 =?us-ascii?Q?Jq5cFka13G8VVd6+pAYdSpsluBTqgIwZLUo8vJAmvkbKKFe53XaKs0IsQ702?=
 =?us-ascii?Q?MFdcRmjRFMOwW3QfhohxtMrUo4eOY7iFHGdBwxAZNttxlM/oaBZYlA91BORj?=
 =?us-ascii?Q?crQBhWe23OOOTOtoNKD8RDQIYe1qkNDoKtMQijshDHYT55nzD4skYdPRiMvF?=
 =?us-ascii?Q?J1m8IopodvxKEYlPOLZWNcC7I0XpiWitmhdF2rdmwNXlhhrSkaivPCb5j/cL?=
 =?us-ascii?Q?DmihyHjnb85wztrRGEurZZWNQls036aqaMRMsYmDslcgMIe9YmHuxnI82LVG?=
 =?us-ascii?Q?r62fc5Og2Wjpb24nFOddu6zAbvuMHrjTQISwwqgmkhx2Z4o5Yf4Vpaji1cr8?=
 =?us-ascii?Q?ygW8FUVyKsA1qponKZwtCyhbzGUBRN9OqoNkhFt/bcaedZb/n3LGur29w9jo?=
 =?us-ascii?Q?sM6XuqpKWnij+Ow9f+rRlFcfSo1/zZgVBZAdRUHOVemVNffRD1FQ3879e2bO?=
 =?us-ascii?Q?Jc3P81D9jUlxSE+KUBWnBoJqqkZeAMTBVY+i/t1CGpqTQerqAmVjJlebA19C?=
 =?us-ascii?Q?5Ae7oWJld2zJM+Fj23FCw8CYIwzcuge3Dndy0pvtSyHuwHx8L3z7bMB3/lwg?=
 =?us-ascii?Q?zNMRiOnhw0ptwauueVNdpwIrUCy7rHvwMFCHgAC8nrQLWeJJY0mfYdQZ6gRc?=
 =?us-ascii?Q?rosPN4qg0kYatYgz6N6tGqyfG8JghNPyLXNWoaI7/GSeDgkh/RyR/Y3eKV2o?=
 =?us-ascii?Q?Zo/7AmO5loxc0umO/Z0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72626fa3-7088-4e6f-205e-08de0d37ad5d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 04:43:11.8901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTm4KETjweftLEYJT8aSlC9PHpHZl3OiNY9+Iq0BxCrjW4H2OY6BME3WHw7BU8ZQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11655
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

This series support timesync APIs, improves
queue reset logic and include minor fixes.

v2 change log:
 - fix 32 bit compilation

v3 change log:
 - update commit message of coverity fix patch

v4 change log:
 - seprated queue shutdown and logging patch into two.

Gagandeep Singh (2):
  bus/dpaa: add FQ shutdown and improve logging
  bus/dpaa: imrpove DPAA bus qman logging

Jun Yang (3):
  net/dpaa: Support IEEE1588 by timesync API
  bus/dpaa: Disable qman Invalid Enqueue State interrupt
  bus/dpaa: Set max push RXQ number

Vanshika Shukla (1):
  net/dpaa: fix resource leak coverity issue

 doc/guides/nics/dpaa.rst                  |   3 -
 drivers/bus/dpaa/base/qbman/qman.c        | 459 +++++++++++++---------
 drivers/bus/dpaa/base/qbman/qman_driver.c |  27 +-
 drivers/bus/dpaa/bus_dpaa_driver.h        |   6 +
 drivers/bus/dpaa/dpaa_bus.c               |  51 +++
 drivers/bus/dpaa/include/fsl_qman.h       |   6 +-
 drivers/common/dpaax/dpaax_ptp.h          |  95 +++++
 drivers/net/dpaa/dpaa_ethdev.c            |  69 +---
 drivers/net/dpaa/dpaa_ethdev.h            |  13 +-
 drivers/net/dpaa/dpaa_flow.c              |   6 +-
 drivers/net/dpaa/dpaa_ptp.c               |  50 ++-
 drivers/net/dpaa/dpaa_rxtx.c              |  93 ++---
 drivers/net/dpaa/dpaa_rxtx.h              |   2 +-
 13 files changed, 580 insertions(+), 300 deletions(-)
 create mode 100644 drivers/common/dpaax/dpaax_ptp.h

-- 
2.25.1

