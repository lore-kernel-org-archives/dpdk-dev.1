Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6054EC5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 10:42:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E863A4067B;
	Mon,  2 Jun 2025 12:41:22 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
 by mails.dpdk.org (Postfix) with ESMTP id 02BC740661
 for <dev@dpdk.org>; Mon,  2 Jun 2025 12:41:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEUlQ4Ojmk+0XvxbgUn8zoFgqSyaz4GnrxD1NhKiD7hJPphMgX2LwYwjak1YzgRapMvgBS/Hq7yFo74bUouoaPwrPdZP9QJbC86WDSlYK4jfUyInruqIevpRmSUcXxXXF4+FFWFC+tNFp3n9nUJO3MTUkhZyjaLOjIusZB8A0SblPU9k1zzgoGT31AFuRnHZBKpoVTX+XENHkwyd2/Tuftj3IHN0agJUi0ZgxOlSCq3+rS4GUJP91qGyrHZrh3E88R8QYRyo75zu6vucB3D+rypM+kuCyFFe5XsoDgRkKnjQlk2bY6STm8hh6EzNp1rBWlhCX6SHfnfLlT91lrtb1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRWcIPfHSb2am1ilHJsClnMYa3QyedOwxaFuNVgaP1g=;
 b=Pyt6b6atvjr3Ei41U/yWfqU4kxkb7G2PCLNVnMj3TX29O6s1zVamDlSrpiplKcU+wmEnWd+ODCwUC4qhgHxBcM1LAA1XtcJ/1h/S9fI0r8O0Xo5BDqJdKhuoDpcdiAz3FCfucDsHKuIhQhAJwRnFXOrYdFB/QkWz8Sp08A/Ndzg9i3Un8v0Bnu4v4P9M+Cm6+Zj5zqKyV9GsbjEDPeoJ0eik4/8N/jqYTA+K6nPu9Wf58NFckIFHe+9d83THo6+xULeY3bsMID1oZb/IITiUJGUjoMsxqb00Rr+O1I6z2hbMH5yK8x0WpgU+LNqEg9K+ZDdw5SztDvupr9aAU5pDfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRWcIPfHSb2am1ilHJsClnMYa3QyedOwxaFuNVgaP1g=;
 b=eLhZROE6nACrUv9DsYOi/HcKVNbJyYfg4016CNKhYTCGxf7r6RdUQbUUiRbIWj9CdA5xF1S8/1vndixIEcy827HdCxyldCeKEmKgrt184PAAhFSFmoEoN96Qx3IQWfrhD1Tnzbxnmw1r9EsvNK8ofDWFABP9lNFK93czctOly41EOkyjMthszQbLFTNdK3V9FYX56gk3IAtIEU5FGpy5JDu6bJPSrOUp3mhow288c/BuYtKlezp83FS/w6Jc5Lz45mOmljmZFvBJz6TqMM7cvnjr+hR1/jROeDEcMzDvJbWl0rIZj82552OKUlRdSPOEvjhHyuocjulI7We0aD7YAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7)
 by VI2PR04MB10956.eurprd04.prod.outlook.com (2603:10a6:800:276::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 10:41:19 +0000
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561]) by AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561%4]) with mapi id 15.20.8769.029; Mon, 2 Jun 2025
 10:41:19 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 09/11] net/dpaa2: retrieve DPNI API version at init time
Date: Mon,  2 Jun 2025 16:10:39 +0530
Message-Id: <20250602104041.3322164-10-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250602104041.3322164-1-g.singh@nxp.com>
References: <20250530071344.2939434-1-g.singh@nxp.com>
 <20250602104041.3322164-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To AM9PR04MB8194.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e6::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8194:EE_|VI2PR04MB10956:EE_
X-MS-Office365-Filtering-Correlation-Id: 50825a5e-3138-44be-e6e2-08dda1c2029a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NZqi3aKFN1ZA+xxpuluJbO6G2Z4ziMphgIQlDT3WNgoAXt3uJChnqZLJH8Kh?=
 =?us-ascii?Q?wB8nTu4GL6dS138CWifQQRK9PcjWvBSUIsLl1JijroaGSZy9Lr01Grg99xM8?=
 =?us-ascii?Q?C+GfKqyOFZg9POOcKHUeptuFtKsm7JVBqWUv9xRpuUUBsYibuOMeANTUzxDm?=
 =?us-ascii?Q?oDyfN00Expzu42aNtG/I4tzTSOU/jquGa5ZAzhow5i4gi9hBrIXIt6C/FK9N?=
 =?us-ascii?Q?7JLICNg/sG46hBDvqbDBfexk3VmJ0qyn3+B7Zj/Jd1xr8eO1i1xgc7K/WpqH?=
 =?us-ascii?Q?svi4HEz5QAxPNb0RlhbOzIzGQZuOKeBHs7U7SzQ+AAnk5rJDoVnqEv4IqXeI?=
 =?us-ascii?Q?MUD7sgxJ5MdTrjo5T6Miweue17651AAFQrUY42kZ4wS8lMssbn36uvbafCUT?=
 =?us-ascii?Q?IFBgi9p3vGl+XoPio85X2YjdrPSNdDPfQ9IiccuHLKn9Jykt5Csz6310tkrX?=
 =?us-ascii?Q?iP89n69i5V1YN2P2wkHLJ70icmzwofrSpo0o4YE/dHZu6dy8iCKwXztHWv4N?=
 =?us-ascii?Q?YVb3hZcFesnskUbJCLu2nrCpCk5CegbFBSBCXK2bs/jQVduWNhkJj6332I8W?=
 =?us-ascii?Q?f66m0eaQTyvsEqYIR1/gCl24Ee9dRilw0bRW43+7J8Hu1I6izPgHFm+d23gX?=
 =?us-ascii?Q?LDe02dyRtPTG8ggE1O0WL1oMOkNnJEQI19agf77OkS/6nxKmxsNB/BBQDdFc?=
 =?us-ascii?Q?9We/vI33JLisDQGTydeLTUnVBxwcvoCPa/Hk1kcn9VmJNd+ApgOdKak0K2ke?=
 =?us-ascii?Q?tLBn/8anR2YsYppqsdbdk+Mh+HTKSFUTWbLGxmgP/gUeQ2vnxeZAnjQWOwGk?=
 =?us-ascii?Q?bGoGnlFCvbROllMCzbW6Pjotacrqf9vWR7Em1eMDSQEkOznAMI1zNX6Wz4Zk?=
 =?us-ascii?Q?aKGXKU0WzuDZqcb/filMi7FyzEmSF762m0uKgupa1OXBk4F4NWJTX3EXNFgZ?=
 =?us-ascii?Q?hJAmM9fci3Nf12JFXZvhojljqxpLOGlLE36VkvRI/LCFOU4sARGltXq3w/Mb?=
 =?us-ascii?Q?kTVPOyRYjH3mjtqRzyBm0CN4HVUZWqTmRYPoZrz7NPJm8qrYGd2MB86XL9k0?=
 =?us-ascii?Q?Rw4oPOzM3UmcPX1ofdpIwLsb9za+F9xIIJfey0fvMR+c1kRDt7qRMcajQKNW?=
 =?us-ascii?Q?ZqJ5FpbK+xhKcd72zAyZnaMXce0jFab2NbQxan1re7bXbq5pKd45o7Vf/Gzm?=
 =?us-ascii?Q?RwVkIJJqOHaiuwDYFVNyWLfTmj01p6Sk3Sh6sZ4wqdwu8yQyvo1SKdW68a6O?=
 =?us-ascii?Q?eYli4yb053PNzx8H91RPhjMr6EmfODVAeW+JUqrgMznjGEEtqciv71YhQuFN?=
 =?us-ascii?Q?JO4Qauo9MbwXdJUbXiPDUEpxjPaczawEzMlv3eUVMo2JbXprFCpw9/o+mY3n?=
 =?us-ascii?Q?9Sp2xDd2LSmTp4Qxu/+CQVvy0rp4HicTriL7V54mfmvmCMAVcENl4tcxz9yo?=
 =?us-ascii?Q?PF7uXjnH0loO6dXdkb5MYyjH8vIHLEWOQ2zmjsCSoMztNFoKGm7yr5+Lp1x/?=
 =?us-ascii?Q?HJXFwIigwiPQR4Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8194.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O7NceFcQ2q/11os9u/9Nzp5/zWwQsFm8GQGAJNNuIs0290VP5VHmX/56o7dU?=
 =?us-ascii?Q?4lyLoOlAowH9usMjK7BVPLtRlkxmbQxNEIE+kub1C+gzK9gHF2VW6VGP/5Ob?=
 =?us-ascii?Q?m0tlW5wqb4OyJSlCYijCwzw8Grlc7MzMpu166lpdB457IDYqbutzBYS3sdxk?=
 =?us-ascii?Q?rRvqJvwMnAChJXjmPSzEGbQKvldmr0jzb9/Kw3muSXZ+wTNjYN2vfEu/QKa/?=
 =?us-ascii?Q?gQ+/fpW7oluba/aRR63DaH9Zq/n5oUNq7ix55HDGccBo+nlKrBmQbbU3yGKw?=
 =?us-ascii?Q?WjEBL8qlRlizjMs1j+aHX35FV/tWbAlSlhCVHXF+yRF05jUgS2hQSvsfDeyt?=
 =?us-ascii?Q?0EhPEZMjC4k5O69pqAEqimYiDNddxmdeQIG+MlEQHmR8e4at55hr4rzLc2+5?=
 =?us-ascii?Q?lTKtzgqNwriGDv1zwLB+0oKc119KzJBdJvZYyPDhg7AO9se+tKEpZ0M6zeWI?=
 =?us-ascii?Q?t0RTEo29T8+gGoPiGbAIEve7rNUVMFsCvu3GOL4toML6bELWAc8Fn9HYVRQy?=
 =?us-ascii?Q?2mfRyjwCooSK75QHzo4a8psDH3cdweNJX/GHFDCRRsvaHAM3S/I9xOThwcyQ?=
 =?us-ascii?Q?H0K4OztQBI1n+GAbE/vQAtEw8Sh2MFn26w3bbLYGMqoCrltnA01VgoU6vPBA?=
 =?us-ascii?Q?eziuruNKpvaWyPrUG8Y/uT5QVc6NK2YkNHSBLTEQ6X1zSSh2kGZ3g4yXFeeY?=
 =?us-ascii?Q?KbXIoTuTFY0fQgpJhtY9nKieKjFRRYsh49hjc9vp8vpi1twYRQugpDBgNNiD?=
 =?us-ascii?Q?KMCrE4xFu8EMeeSLFtlQVXGdo/kqn4izTs0N3PTRjxocLOUNVBAUfzV5GmGL?=
 =?us-ascii?Q?y5x6n72w+CAxplRx3q/Oiqnuk5S1YlB+iIi7D/p5hX2X4BS8sLBgAS4NkUai?=
 =?us-ascii?Q?u7ciwqQmkEv9vrvgrKkvVi6P9KPHhz0phHKrOE9TgJ7c6R9oUU7Bt3fMDYaU?=
 =?us-ascii?Q?aGSq3b3uQINEDVuj2zCS66sbpRPpFj0dIfxyDoX0cUY9/pBXP4aAnkh0ZljR?=
 =?us-ascii?Q?+6aRDrdCbfBsAwAR1etkxj523Nk/12GywLUsRuXWnF1PlJU2zQL7/UhGqqNZ?=
 =?us-ascii?Q?QQBxfq057ehK9SqJ9NcVBjKyKRm9GXT9cCX8rO4NG036fEGsscdkb/Vw2m0k?=
 =?us-ascii?Q?uGaWoLYMxZDE9gBMRg8wwz2/D6hWYa91rzN4gLCFdZRq9xsxCay+BwcWJHC6?=
 =?us-ascii?Q?pNuqa1P5ljr8GsFGxgCyhqAsmaiGFWWRoFRATYb4adqjCCXECgtRm4v+zYhZ?=
 =?us-ascii?Q?u0ErUcwE64PxF29F2R0SepRt+N8WaN+NwTOcTj3lGyoZ0C5JbZ7tUQMBOAfm?=
 =?us-ascii?Q?F8dEMwQP6+lfg7wtLUGNsLEVH5MGhHyENtYTl8PUqxaNLXbnLBftWTIhLo1s?=
 =?us-ascii?Q?w/rot/nNNBJpPeokuPdt9kwsCE2yhK7JZiqyFL7v3Efbce5JtQnVpxbk9ert?=
 =?us-ascii?Q?Y2nApJ1d/tabOPOkRlfWuk3xpygIExki7JKSO17Xjc8OxVcxiQb6M2Bo5YAE?=
 =?us-ascii?Q?8PRawI2BBaiGmghzZre2n90qoVaq6QebSf5qIxT5Xq+mUKxUOFi9r8A5ldpW?=
 =?us-ascii?Q?XwDLiR8ECpWOP8AN+7E=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50825a5e-3138-44be-e6e2-08dda1c2029a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8194.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 10:41:19.8917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWu/XfXrojYGjFB21Gw7fcpeeEeW5eEJ5YJvJ7BOb0H2NDJv/sMQng61P0Di32jl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10956
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

From: Ioana Ciornei <ioana.ciornei@nxp.com>

The list of availabla DPNI APIs depends on the DPNI API version
available on a system. Retrieve the API version in the init stage and
store it in the private structure so that it can be used at a later
stage.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .mailmap                         | 1 +
 drivers/net/dpaa2/dpaa2_ethdev.c | 8 ++++++++
 drivers/net/dpaa2/dpaa2_ethdev.h | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/.mailmap b/.mailmap
index 91e08f4a1f..93905921b1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -606,6 +606,7 @@ Ilya Maximets <i.maximets@ovn.org> <i.maximets@samsung.com>
 Ilya V. Matveychikov <matvejchikov@gmail.com>
 Ilyes Ben Hamouda <ilyes.ben_hamouda@6wind.com>
 Intiyaz Basha <intiyaz.basha@caviumnetworks.com>
+Ioana Ciornei <ioana.ciornei@nxp.com>
 Isaac Boukris <iboukris@gmail.com>
 Itamar Gozlan <igozlan@nvidia.com>
 Itsuro Oda <oda@valinux.co.jp>
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 298fded65e..b88c9d748a 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -2814,6 +2814,14 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		goto init_err;
 	}
 
+	ret = dpni_get_api_version(dpni_dev, CMD_PRI_LOW, &priv->dpni_ver_major,
+				   &priv->dpni_ver_minor);
+	if (ret) {
+		DPAA2_PMD_ERR("Failure in get dpni@%d API version, err code %d",
+			hw_id, ret);
+		goto init_err;
+	}
+
 	priv->num_rx_tc = attr.num_rx_tcs;
 	priv->num_tx_tc = attr.num_tx_tcs;
 	priv->qos_entries = attr.qos_entries;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 570b1608a0..ee5ae3b70a 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -394,6 +394,9 @@ struct dpaa2_dev_priv {
 	uint8_t max_cgs;
 	uint8_t cgid_in_use[MAX_RX_QUEUES];
 
+	uint16_t dpni_ver_major;
+	uint16_t dpni_ver_minor;
+
 	enum rte_dpaa2_dev_type ep_dev_type;   /**< Endpoint Device Type */
 	uint16_t ep_object_id;                 /**< Endpoint DPAA2 Object ID */
 	char ep_name[RTE_DEV_NAME_MAX_LEN];
-- 
2.25.1

