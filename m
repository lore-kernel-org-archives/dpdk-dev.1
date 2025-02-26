Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FD7C021BE
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 03:06:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D94A4402E0;
	Wed, 26 Feb 2025 04:06:31 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2138.outbound.protection.outlook.com [40.107.244.138])
 by mails.dpdk.org (Postfix) with ESMTP id A09A4402DC;
 Wed, 26 Feb 2025 04:06:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9+RPmL8fbHMGsga+dfd1xovVWqzFy6/AQ0+T0UpWl9Ub1uxmvsr488qSiLvOaGFDDHvAkKhX3hQht5AhvACedfPZ0NhMhIdyqVDZpx58q9WZJLpuVPhVEwMtNl/YPWRGlmQSa/d5/IJ5aMyTFDL5qTFir1Rdd+q5KxumaTRV6YAIvovp1Jx3JX6RJVgrEyOIvDV3zUFaRA6oLKULRKdr0kdwvxP2c+EJJ7SdVh8k/mO8i5GcouIQKTuGLz3KrTVP3Tm2NwgL/PttRasqW3GybgZDw5S9ZlNlmIIr2kM5PO/XkS3q9J5HSPTGOvS5HBRgruU/Py2dlcqY4aqUSMLEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEo5b0HmkTinnF/0f2uDXfJHMNbpvd91ImP6l7jOlrA=;
 b=FQIWZaA9XEBYFg5Mazdv73GIGzgeTWz2lF3o0J1fm7aZQl3gernP9QOcO9T3TqVNXiIFERaR5ALvAIF5jEEGXYoSmGa4pM6VSYOcbR908Q7QKwDbqyy67+AvR0oN10+VQxGjWtYLuu/mtY5Umkbqkngw9ObBr0oISvqP2uuJgjwAtdqNkKJ1KJYujUUIlL0iy9kbEVV5hn/b+f1ShVaZkRPOaRC/qk2X/x5AtKig+IiKPNfTFbnkcNoAn1OVWUJDP40cpyPIcRcof8LjFofzbR8wjAGL1I6a7qiILoDk4hEFoYU9uOGKyQNQ5NrDO8HMXCn8udPjS60oEEijn0WZJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEo5b0HmkTinnF/0f2uDXfJHMNbpvd91ImP6l7jOlrA=;
 b=NHYWIFeupR8EpuFUy0YYkWUXWaL2vBsXfWEIwF3V4QFPABG9xA824tu37vGFni79jIkwsgqes/LUQwUOyLiXyfcndF3Eu6T5aecgRSoN6PkEqtbIxjZIRdVKypX/x8E7UxWK7cE8DZarOy+buncLglcaVTB8CJg91LKCAo3Jy+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB5568.namprd13.prod.outlook.com (2603:10b6:510:12b::16)
 by BY3PR13MB4916.namprd13.prod.outlook.com (2603:10b6:a03:36f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 03:06:27 +0000
Received: from PH0PR13MB5568.namprd13.prod.outlook.com
 ([fe80::277d:5013:95a1:d8b9]) by PH0PR13MB5568.namprd13.prod.outlook.com
 ([fe80::277d:5013:95a1:d8b9%3]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 03:06:27 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: dev@dpdk.org
Cc: oss-drivers@corigine.com, Chaoyong He <chaoyong.he@corigine.com>,
 peng.zhang@corigine.com, stable@dpdk.org
Subject: [PATCH] net/nfp: fix two bugs of error process logic
Date: Wed, 26 Feb 2025 11:06:05 +0800
Message-ID: <20250226030605.567179-1-chaoyong.he@corigine.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To PH0PR13MB5568.namprd13.prod.outlook.com
 (2603:10b6:510:12b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB5568:EE_|BY3PR13MB4916:EE_
X-MS-Office365-Filtering-Correlation-Id: d2807d63-4e55-4961-a409-08dd56128f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dBE8yc7D9U8kSgpZHuIFH9ufU0a0gq8WLVatWnDxX8hI8sO6d9oJNStrYYHE?=
 =?us-ascii?Q?kltHdnAE1OF73JF/QPLDTPZlI9LC7BKb7r5SDQgQ2dRWZCwcgitbxjhhnj1i?=
 =?us-ascii?Q?LqZh+3v029mg6SzgewONmAkVHksp3+GKHM1CBgiPxWjHJPPZRMCkCjmBfwsC?=
 =?us-ascii?Q?9RYENmVYHB5tPz1Qu1+DVGmhavQk3WxcvzZTbVrncW8NZXkxO1CcbxHFyf2o?=
 =?us-ascii?Q?V+NGuxJrommtmVO5cNCe/gF3YY4IP0ACgbuPM6RM+r3A5ab7TYe+X38qOrav?=
 =?us-ascii?Q?9kVdKSeYgaeU5Wr4QXlgOxh9HxCSw2wyaWBqJKuB18Apvuhrb1E0Jh8bhH8n?=
 =?us-ascii?Q?/R8agv14+ej8ftV2zcsV48SrpDWtH+hwCZAaUWvPtD794zyPD+ezxJbMbHYH?=
 =?us-ascii?Q?NxwoO26QzK9M/1zaIRyMzpmLWuOJJUN+aNl1SHCVlfLDt3X5f+2guDeOY7uY?=
 =?us-ascii?Q?SYN4/P0+KgtxzDGJKUvXF7ReYFgjrdnpWaH/SF+NpfkKI/tsuRyzHLknvAOe?=
 =?us-ascii?Q?VmEhw/FBs4shXfkHOXL78WDyNTrCEn+O5OmFZN/8LTzHBEEoeU8Jt9XWpL9A?=
 =?us-ascii?Q?3ZHl1Z4u4VuOuA5B/cek/nuPdCFy0a+ZHlN1nrQZdhU5nRe8PLno1U9SRw38?=
 =?us-ascii?Q?W1Emgm676rNlZXw4zSyb7ZCshNLe+5/3wjdeZMsUVj2uv2HSY7mYYhRQylVa?=
 =?us-ascii?Q?QJMQn0ZAvCWjSxZFDjyvPyWYLaF9wZXGvzq9+urL1CyUP+dN3/BpORCmEnMa?=
 =?us-ascii?Q?8T1kIVCW8r1jsLqVV8Ozo83JLS/zZvQMbR1XQ3jz26cwJmiZUEvBnshb2bjU?=
 =?us-ascii?Q?HjIuUfekrMKVujiCkZyiZg3kC7HGgDQxErl8ZkDbjLNb9mDo1ZBI2xwFB6b8?=
 =?us-ascii?Q?NECxm28KeYQAj6ZRJ8jvx4eudb+z47plKwH8GBaePdmYYP6CS64LCDAw9efD?=
 =?us-ascii?Q?uCv+IrtRZ8pKjxlv8uT6aenv6Pmyszd/YBZhCl7xXcD19jsQ7Co6odeg/wzY?=
 =?us-ascii?Q?pgUgYwZr3lc/coV0vs/+9pySoDsp6ReR57245D6WfnmTTIxWHmv0fOfqp9i9?=
 =?us-ascii?Q?qslT+gkqh0vF2zDApxVkKvZaWsS6B8VYBadPijZddlKgbK1ipvEyOnfmg/6n?=
 =?us-ascii?Q?jxx1ttta/fQLblG4p8RR0jG2fQaihRnDVAiFJCl5jIup5D0cQ9qSUnrjUbGv?=
 =?us-ascii?Q?LpVHoqDNmoU6/kdssNsnjXBEc6+WUvjQk2qRRHf9RLmv5xlkesig6OXg/pr0?=
 =?us-ascii?Q?7cz29l8pIG4J+EaRsizhGTRIrhw26VEgA5VKuItJnZBF56R4LzS4Z0py/n2X?=
 =?us-ascii?Q?eE4JTFH8j+UknRFd4qbA0C4jevBMALVx0NaUwGIaefFxGn95ibB9RwPTDEGe?=
 =?us-ascii?Q?Rk0QDMZkkheO01JMHlOjkblxnptf9X/RCENSTMZ7s0gIWRqsRyhzZCsT/eKh?=
 =?us-ascii?Q?T7VEJO3rSBbfu83OgZwDBOhnemBOFb4E?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR13MB5568.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8paKUHP+8TjOzl8TarMOF4Yk1lJKn+s8ql3VqjApwC8dvfqpKsKzTP5iAAi8?=
 =?us-ascii?Q?zsEDysEIfce7X6YBOIUh+KkmbckbG6jp/L6czN/qrg3cIGPzV2rIbAR+8SuE?=
 =?us-ascii?Q?uy1dvNn/YajQYcuOnnVkDzgURwoxCHPsHyohONF7/SQNFZwTpLBxmf07seIt?=
 =?us-ascii?Q?WeNKxn30fylAQ3MFUHqeK50/0h5XkkYadi2NDxPGHawOvpMqcoXPT3P/9GzN?=
 =?us-ascii?Q?HcDcmQTOu6609EENz1sq1d7qvg4B4RHUKb8s2W2Syj2Enon7wT5xnOpnu4K3?=
 =?us-ascii?Q?1dal2on0TcRd6GXA+2CPHtjTbCj62R0uCOx9E9LbB8IKd02zQA7sLju/a+M5?=
 =?us-ascii?Q?rHd9j2uAU/DLYmpD76YZPBjb9jNjsGF2Mnd7anZroHGzl1B6hJvSCvpU9HCA?=
 =?us-ascii?Q?Qiyp0vDfKzMSkfzLReNe5FjqVDB11dC/oW6zfva/I2rvHiqTEgfD+zFTsnTh?=
 =?us-ascii?Q?LGMMXo1Tmp5BscoDqDbeqPJeyoJ6lfqLHk3uqt1ZitES5v7IIvLWk7n41623?=
 =?us-ascii?Q?xflqX88D39Qghtd4A8io2HPpVghEpxONpMMRbBDY6NM7eEMUJ5S4iaTxYZjX?=
 =?us-ascii?Q?rzcluctwVTOmKWhGMpfBz96bNSa0LUk2AYJZgMGxKz1dz4AZcWcsYIdnM5ez?=
 =?us-ascii?Q?YJ1axa6x4H97TU+SuMRsobXD/Gf1gk2hnpYyNNoh2BEdlkk0T5kqiSvwduTS?=
 =?us-ascii?Q?WCvnpcqPuo2S+/8S2aR2B6uGYpK4HUyHVquZu4iL6peILO7NO2ODmc5F8gi3?=
 =?us-ascii?Q?0G3pGnN7pZHab51L4fSZJSnQtn2BOIHHLo89k2eGWT7b8C2GEezRWAhvZqVZ?=
 =?us-ascii?Q?8z4Df6q70TOgy+9EqELUFzBpolbxAd1hoVc57xeRVowt/nV1IyPDbR/wpxfD?=
 =?us-ascii?Q?iJNUMmHqaHqcpwADpn/7Tp0OMPFIQgF6dIeNx3wV25QpB/0EU4AkmqGhB1lo?=
 =?us-ascii?Q?BDizBlW3/1cm+fmHt61F229N2ojhQYEKLSsJhfzwDZqP9jT1C3K8zqlCkxHo?=
 =?us-ascii?Q?Sj2tmQ4ZSPg3JoZlN3uHgNZdx6tKsm9iAPSIH5k7rp5x2sxEbgw6aDYIlsHB?=
 =?us-ascii?Q?ZbrZrxDb3LVe2Efg1bvMA3/mw2AHH+zIzhXX3H461BJlgnDP19XaugNyPqJJ?=
 =?us-ascii?Q?dXh4yzLFCINicpMckrWQU304kBhhIM9yVYbceTXLGBUqmdD9Zw1GLhz1MR8I?=
 =?us-ascii?Q?bokxeVsfXkKJMj7n+cJrXqSXEqNTKzHfERGTHa0HiCowaT+AZt3jbI78sPEJ?=
 =?us-ascii?Q?ium+H6ncQrKlL1vTQuyrxXd14vRjyujxyrLJl86sBMc96cRr2/J8dTyP0nGX?=
 =?us-ascii?Q?JBhRrlfftV1RZygAK4vMxZ4+Nc/78tvtqPwP8ADvL2dIuf9hQeWtuuUldLeE?=
 =?us-ascii?Q?c2Ny1uG3c1PDIl59g22NyGFLa4nx1YAxre9s5A+DmEPdBS6ua/L6o8xsAWix?=
 =?us-ascii?Q?QO8fLRYKUX6UZnRG20BGXGZ1WkIiZUEjizBzC+DFltqKTKJm0iqm5cpN7Slr?=
 =?us-ascii?Q?sNQRODwHMaj2nswBBlv/9UiT6oS02ufl2ItXSrPEAcVJGyNpzNvlI3vpmraN?=
 =?us-ascii?Q?Y8BA0TcEtb4iylceu+Cg3L416h2rufI0xzXs6H6s5buculht3gv8KKUyT9Dn?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2807d63-4e55-4961-a409-08dd56128f3b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB5568.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 03:06:27.2134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMeVtfmtFR6J3OephHQ5fecdgeeU2KcbNXcFda1KTF7nyJ43kprtY7C1FeXfy/1bgwI+AedlWGMfgIULQ960hSViI+oTBaUoSccIDq1bJsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4916
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

Fix two bugs of error process logic.

Fixes: 19bd7cce5705 ("net/nfp: support different configuration BAR size")
Fixes: 636e133ec891 ("net/nfp: update Tx and Rx for multiple PF")
Cc: peng.zhang@corigine.com
Cc: stable@dpdk.org

Signed-off-by: Chaoyong He <chaoyong.he@corigine.com>
Reviewed-by: Peng Zhang <peng.zhang@corigine.com>
---
 drivers/net/nfp/nfp_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/nfp/nfp_ethdev.c b/drivers/net/nfp/nfp_ethdev.c
index b9cb9fc652..cbd1deffb4 100644
--- a/drivers/net/nfp/nfp_ethdev.c
+++ b/drivers/net/nfp/nfp_ethdev.c
@@ -2549,7 +2549,7 @@ nfp_pf_init(struct rte_pci_device *pci_dev)
 	ret = nfp_net_vf_config_init(pf_dev);
 	if (ret != 0) {
 		PMD_INIT_LOG(ERR, "Failed to init VF config.");
-		goto vf_cfg_tbl_cleanup;
+		goto mac_stats_cleanup;
 	}
 
 	hw_priv->is_pf = true;
@@ -2557,7 +2557,7 @@ nfp_pf_init(struct rte_pci_device *pci_dev)
 	if (!nfp_net_recv_pkt_meta_check_register(hw_priv)) {
 		PMD_INIT_LOG(ERR, "PF register meta check function failed.");
 		ret = -EIO;
-		goto hw_priv_free;
+		goto vf_cfg_tbl_cleanup;
 	}
 
 	/*
-- 
2.43.5

