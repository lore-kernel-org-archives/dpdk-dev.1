Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824B5C8302D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 09:58:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A71640670;
	Mon, 30 Jun 2025 11:58:33 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
 by mails.dpdk.org (Postfix) with ESMTP id ACC7240647
 for <dev@dpdk.org>; Mon, 30 Jun 2025 11:58:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDUFH+2+qkWAUu/TofuRh7xbLyVNgSu7x7yNB1war8/hRzHWM4TwiLPAZZEXY7h/On9s9KxZNNOXZ4etMaoCjrc6cHzBfrMBwPoVG3ep6ntIExJED+AKVbDqmSCm0jfeKqnvvwijMFNsOSz/w4pEOrucSyRODYQQ6cNm51okfgwEQcgnGTl8VOOGJAaujCfPnZ/i8fAI9tYlmLSrGxgq5xauV7NLnaE1LeYZwXnj17u8+yx8YWuMDh+V2tlTI6bV389yoAJng90evXGeESidYfkuYihPEWBxb33AucVzmdpx3f7b/irt1t6nrMYe7iXTlsvQIMJFo01KgUx1pxT7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfeSHvkAHUBSk4TXXETwDb5B4yU5spvKGfPfwx1IXrY=;
 b=MYcx0SZcN39rsKZyWk3qFp5paYHLZAXneBnZKOcElonn6+UkaChkBlxVhCDrMU743X0WSWStq1nkvZZIINWD30Q84QdU7EeR1oTVM8pHQ9lz5dpFfl2Eg/WEhdx91sae/GtgwtQPJ4trxC8ASp+Z73Tkja6/nqW8q+oXpxwt7LsphPXiOkvMVEbYfoIK9BWNqeUIeVU3IIn0lvNWyZJlgNUc/QTwDVEejosZLpx4GX6ImA7PcjGRfrgL/59ShRHBGJ75tef1ezto/BNF5bi9hGyXNkPyVHy00iZ+gu24fcuLVgcAV+xqk/TmIQ3WqZ3n+aDMV98+W+ReBz7O+oATtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfeSHvkAHUBSk4TXXETwDb5B4yU5spvKGfPfwx1IXrY=;
 b=gQDSZYV8fxDx1bS+g0Udz5+cKcGS3xeOwVbwblt8e94zdcBz3QlJt51H5TStP/UsWrcR10ONB3JROA8b1eDEmZeI0pwJdkmb3sNXKXs8HTR36U8iqEnVszKt+qUgk8cKGQkNTBf6zHqc9BHbipbWfMmJGA3Rh7NrnVHWFf2FqWUJJtvBZN3Z8s5Ek8szanohNKZAHN/DZBDgN27bzZi+58KeBxUgTnObX2MH+FheZFBe+dt6sTVs3JcDA2mWT7KmNlBs6IWNIYAqqdzw79KPghFsPJOJhGlUaGhNNrvNuhNjI0UY9EYgeRVEX5pthUyUtWibv6X5dQ8zStQwpxV1Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 30 Jun
 2025 09:58:25 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8880.029; Mon, 30 Jun 2025
 09:58:25 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v6 5/6] net/dpaa2: retrieve DPNI API version at init time
Date: Mon, 30 Jun 2025 15:27:59 +0530
Message-Id: <20250630095800.2943863-6-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250630095800.2943863-1-g.singh@nxp.com>
References: <20250613021125.790614-1-g.singh@nxp.com>
 <20250630095800.2943863-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::34) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: a15483f6-6db6-42ba-245f-08ddb7bca7c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sq5xnt27X4k+Rdsj3GMO5wOBez+ZhCSZbW5S2Oq2u2Gze2qcm8Rqm2bPVusG?=
 =?us-ascii?Q?TG2SG87uHhP3rosCNKYVTHgzi7uSfBlfzhu46j9J9tJVxVNulkYZBf4yfXOC?=
 =?us-ascii?Q?h8h28MyuY8G1p1jF0FfvzeIp0LQZ+fohISxBwDN5s5doa1Z5AAhlhKi9jC2y?=
 =?us-ascii?Q?gf57ZSBn00Tp98n4UB8A8ShgdiAdTggUMsNbG8UBJY4riSMahGoQ26NPzTAH?=
 =?us-ascii?Q?p3Ip4p1KF224Vyl9EeaPTQDNeLaQwlBnjSHJ+EM5HPUJq0EqZHgoqKHrR8Vw?=
 =?us-ascii?Q?hRL95W+71XA749B4JdbwFHe7+6aQLqV9GicdprBwOF+L7dWc7TUAQifNF6lN?=
 =?us-ascii?Q?TK1uKz6B395ZGbTEi3pEEAxrlgHPs0lSjKB2gnrTQ07PswOElDOBXb1gh18c?=
 =?us-ascii?Q?1tUniYIJpIwSH+LvdsxO4H2fcYTEkMwiFsIaQDAxFsEUWnf7HEa75zApjz2E?=
 =?us-ascii?Q?rKkjugBAyvZ6YT9b0j+WcLESMiS7JNERFMgUxNE9VcftGHQR0LdJp/Fpip4D?=
 =?us-ascii?Q?Y2TMDvjaiGvj+mPcTnFIBU05RjwfngirQg0ea+yn1Ppn590gLWcJAfn5siUu?=
 =?us-ascii?Q?NAF3OmS9QTGwFSvh4f2hDCCxS8Gj3umH9wqU7rUhd+vIKIKFQp0cFVtC522d?=
 =?us-ascii?Q?WtUjwN8K3NUFhNTha8kcWNZkjzyavl5bHzA/ZDwjn5ydo+Eb7zmRArOMfBhS?=
 =?us-ascii?Q?MT5cEdS9KWXLKKvKiLtgizG7HKvecS1H7nJyPTX/HjlJHQx5SpMSVItDQ7Ru?=
 =?us-ascii?Q?7yo/sMVcd7UKeILpuHtOH4luqIaj5lBW84q40Buw0QN0X6WH00kPI1k7pNC6?=
 =?us-ascii?Q?7RffKtoiOp7drya95HvIiygv+r5OsMP70MhGBJwA9qa0VMcUlYMomPniTr4Y?=
 =?us-ascii?Q?yu23TuRCmqADFXTAoohLy0IigQBc6nivrCQy0IiuHvaubXWAjGC5q+AxWplb?=
 =?us-ascii?Q?T4pS3ND6Wy39yVNPkQmgDVE6CdVj/9Cux7GIgGZy0+dnz43+ctXWSGjSOo5m?=
 =?us-ascii?Q?4zaNeKWpnDzSTgw4WLHz8l798urr4E9q5f0Y6zkKdw8hWdVCOzZWqXrwhzt2?=
 =?us-ascii?Q?Hp/4CxE9/qvyFxTwWNvI9O4IkU604G3tGq/xid7bN8zDg4xAwm5EiFm31+c+?=
 =?us-ascii?Q?sgqWe8SoYN/RHSHBiCvQDQl6oqDleRveH7VOr0PGf1GgYq8iFP7Aa6aMQKk+?=
 =?us-ascii?Q?BeAwBiWX7GVqhZApUj8bc/COSiIpHMwXA+E7e4gLn4BHRuXz1mZNLrLRLF0g?=
 =?us-ascii?Q?QCTPxbaKPIqjctKINkfQ4nPIPe8Jadi/3SE/VHLKdeuSTy6iIJ5OUKYFNUxK?=
 =?us-ascii?Q?wqk6J+Tk05OuMWS2nXJDEhkqyHyGx887CdShSdKuXUQmsEYvU02XUd6wRFxH?=
 =?us-ascii?Q?p5VuLGfOv7W/KV3rxsxCQUNkjHLAbAEP9+E4GsJyqjFeO5eyaPoOELudoyVl?=
 =?us-ascii?Q?ORZkeR716n9qLAhd1OOfchGp8UXcBxFW9uMa1uzTeEZjQrGltHmIKikqcG9Q?=
 =?us-ascii?Q?knWtHrs5d/if0y8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xYnCt2ntBqAm2s+xn5a9Avq18p7VAFULMr3cCiQwFE/iRRIgybMiMkS45EV6?=
 =?us-ascii?Q?oEQhRnpoecEHo1lnLzCgFmsF4Ua6ugWdxXPKpKcNQrxWukIwT51CyCBZ6z4+?=
 =?us-ascii?Q?MVDYcQ6clRGidy1VkVQVmMNY2XnlyfC7QKf2y+i10j1fUzbI8SKFNgIH8Gis?=
 =?us-ascii?Q?4/lLPsUeu0daWEj9GLdAN9qJbBnVJnK92e9sar+gmxYG1MIqKM8w6dOAi55n?=
 =?us-ascii?Q?/lffy87ApENoE8l6wIXrlUMs0M6jl4x8IJg6zUBFlmhZXUQwB/LU7nlHA+oT?=
 =?us-ascii?Q?mOg7uCC9vf2uJqmCpLp+4GBES89HtSZQjR3EN7LI45jzJdPVffPOVDHf4jB5?=
 =?us-ascii?Q?vX8WhXqjtRu6Wgan4NojKIyL+VSwqDB3dNo88huBqdyTY8l1orD+ztPzRiKJ?=
 =?us-ascii?Q?b++pLhstLSjdOxFS1V0IlWY2uLuAk0pKXDspC3aw6llNAkqJkiZeBWNcWtp8?=
 =?us-ascii?Q?teQwGd/uTMDpRafaaToQJ3MTAy7NK8SulAGibpkbl1b4jNybLMmdxUEw9g1o?=
 =?us-ascii?Q?g2EK2c+57pk5rm2suZsWpvp26bzw2JufcJ3f29gjQf1P/o0xVAAhQq8BAvyQ?=
 =?us-ascii?Q?GHvysrqCQTXf0f39BNfsmhW07u1Z2vCwd7eOh/lh8fTy+LUHwPmJ9asEzNxJ?=
 =?us-ascii?Q?98s3YboAkgYagr1pA3WHdAibI+yGABVkHrJIdBubk5nR+cCChsFztJCxhpZC?=
 =?us-ascii?Q?Uf2ivdWXfW1y2u2au5MaKb7huzuPT7LMsfdGYtCBtwCYeBNAkrrsTyJhGguX?=
 =?us-ascii?Q?ocD5ljNHVIGdqaESvg3w+uqw+GnOFxQOcTe3ah73NCt6C9L1iiHVLG07H5mz?=
 =?us-ascii?Q?zwWvZjby7efozA/BNlAMIycAxJ4J9lsloQTVFN0K75XsciA86nhUhdruxWFM?=
 =?us-ascii?Q?DPiZQvJy37NjcR6UvLDxR3z8otYM1NeJ8HjPXXz2Che6FdJBZ4KXRn2IHmgK?=
 =?us-ascii?Q?VImyb2HyE3JBKkEpee5cwee18YcomJEwij+jnfiWQD2Mvmsr02FLLksdUzUT?=
 =?us-ascii?Q?IH+aCYp2EnhfCLm2i1QJbU/uFimYc8Rm15/kt9E8QBhCL+HbkLZqdXTllk9R?=
 =?us-ascii?Q?VjocHZNkrMARZp0/l6yiqLBhKijJwMNYxEDredZV7XqPz5vlMPjWc+tkuThA?=
 =?us-ascii?Q?gIqeTjt4eVsdDpQky0zlK5VnntSaxzDpBfo6SUUVeIUDwQr5ts/SIdVgEhOm?=
 =?us-ascii?Q?dXzC1U6AyTvDt6MR5mZBKQZvNFeU5pGukjQgn/UP41p9rH+/HM5tgL3gdwxn?=
 =?us-ascii?Q?ERT1G+k/WY6IlRi13NM5ptWxSgw8MFuxQ6Xm/41PRsRlYLnPR2+liLwg8Tz/?=
 =?us-ascii?Q?sNrUDrcCXfHFR5lAY+h8sBEmTy/1QYXKP7F129AaeF8Avb4qAvxfNu1CII9G?=
 =?us-ascii?Q?RVAg1v5jVXk+Bwd8JorISOPxruEfdZ9nkBIChoSQcwLgxH3Kvsj2Efz+Exkk?=
 =?us-ascii?Q?RqAIhmCtY0j2oqz1Kx668H04zoVEUopZJO5BU0v480Sc5roFJOTjn5YI5Na3?=
 =?us-ascii?Q?8EY4vL+BC68b+njuQpWfDnzwSskQEMGsg4vbQkLjAkaQN3Z3eFlhQnuSQx7D?=
 =?us-ascii?Q?/8KutW2Bnd6tS0tbnzA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15483f6-6db6-42ba-245f-08ddb7bca7c1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 09:58:25.5579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YH36QWYVMOwt6OERHmSSp4BtdZoewNHRkmvimv4CybdSCY7YgwAhwvZwNYED2G9x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894
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
index 8e898e303e..741c14426c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -611,6 +611,7 @@ Ilya Maximets <i.maximets@ovn.org> <i.maximets@samsung.com>
 Ilya V. Matveychikov <matvejchikov@gmail.com>
 Ilyes Ben Hamouda <ilyes.ben_hamouda@6wind.com>
 Intiyaz Basha <intiyaz.basha@caviumnetworks.com>
+Ioana Ciornei <ioana.ciornei@nxp.com>
 Isaac Boukris <iboukris@gmail.com>
 Itamar Gozlan <igozlan@nvidia.com>
 Itsuro Oda <oda@valinux.co.jp>
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index bf6d6fc418..aa68f05dcf 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -2691,6 +2691,14 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
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
index 4e3e0338aa..2d01e85d33 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -392,6 +392,9 @@ struct dpaa2_dev_priv {
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

