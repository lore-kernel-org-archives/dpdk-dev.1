Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89BEC3600C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 06:02:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A76C40DF5;
	Tue,  8 Apr 2025 08:02:32 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2138.outbound.protection.outlook.com [40.107.220.138])
 by mails.dpdk.org (Postfix) with ESMTP id 780FB400D7
 for <dev@dpdk.org>; Tue,  8 Apr 2025 08:02:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JL7cFY50CNu3za2YbsdLV7l8O281b3VvfXNFoBimCz5bY4IUc9GoTD4g36r6akUsGeSc2jfOnhmi/sY3ET8etyoE2XOsyyMaLOkG7IwSEBfPnAF/wmLrsZvCccOe4IVkh47DUNguWEt7pFbDr04su0et08ckRH5C4bzyEuMCNohU8LSqGR8GCDLbfauawALyM8nnmpm7PP/y1F+HPWijwNd9n1aemPpRKtff/tX6ECHzkzXL4U9HLARhd68VNIezuP/jl73ewAhamvHrS7xbq6NrBDfAwulYQ9q4d/GNiS3xUMamsI3rWBSf9KOKAVlR8NxyMDRasRXeUdCvPVgPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCQv1v3+fYyw32oqNh37aU98yOVvk/c5Ix9G2kG9ELY=;
 b=ZNGaT39BQS6z3VkHd6ogeo8n9pFFXegh+3gpTz0+3853gQlXXdGQLLE1pdyr42ZuOdLOsVyKtIuboBf13jvjzPXljtxGfRiFOPB5RdkLXCEqCWHw7QOG+Yjbc/GzHR/20HIsrXtBfU1RpxRcfrbUiunPbqGdA24WawV6grkUDoighJh0L5F3onm5FpSLdKJCWYubFSb+F1izD6lIvSJcud3k+ntLXXcQa+F5zSMYozbkOH5l4MGQsFsA0Pi7cUi2jpMsk9caHaRF2M1EQH+jn9gW34yMJnKrTEE4HbDqUrLE3EYxc9TfQSmfFChQTtlhpmAB44nh+ZDBDkXWTlts+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCQv1v3+fYyw32oqNh37aU98yOVvk/c5Ix9G2kG9ELY=;
 b=n6S4fsDHFnPEr025PcWL0sU+dPYj41TCS10oXXwHhFgDtxNrwFqiJ0mO8HBf6l16qtF159wGgI52SNEGuvcFvB7lzuGGbGdt6F6YK3T01ifFFjRFmQqMGZoeTw+v8+/Bdv4XZr2V4bZbyYQBwmk4WNku+5mG3SwpneXfmB2qbHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5)
 by SJ0PR13MB5918.namprd13.prod.outlook.com (2603:10b6:a03:439::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 06:02:26 +0000
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833]) by SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833%4]) with mapi id 15.20.8583.043; Tue, 8 Apr 2025
 06:02:26 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: dev@dpdk.org
Cc: oss-drivers@corigine.com,
	Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH 0/3] Correct RSS algorithm related logic
Date: Tue,  8 Apr 2025 14:02:00 +0800
Message-ID: <20250408060203.473733-1-chaoyong.he@corigine.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To SJ0PR13MB5545.namprd13.prod.outlook.com
 (2603:10b6:a03:424::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR13MB5545:EE_|SJ0PR13MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a6cf51-3573-424f-f572-08dd7662efdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6/x5v2+spMai7spZRWZgGeWwJ3QKrqSwqF3As+kVfT+u3rna1aBVYIEAdsqE?=
 =?us-ascii?Q?5w1tgRbFgsPKPgZVHaL/a5fpm5stlBo2ythyDae+oL+2ws1mQJ7v97JQv+OU?=
 =?us-ascii?Q?0FHCzqNzGsMDweDkcAE8ycUofWWkX5tD6n5WbUjubiEFDQY5w+J4ySkggHcO?=
 =?us-ascii?Q?hmdate+7MEKhfK3W2i1gOGdWltACaGPomkpALZ+wigqtMZ+slOylciigVYcA?=
 =?us-ascii?Q?2fMVvyT2RA10j/yDsCu55+XS+quYvJ0KprKWN4ic6LUhAI3pUyCJo34ZDee1?=
 =?us-ascii?Q?30GFiNBi50IVL9fjCeF9ils7f7p2ZvgsQzN+UzJJ100vbHdPnm/tuvx5ZBb2?=
 =?us-ascii?Q?ooi2FKze9LtfzVM5MY1t0pAU+fCjUNzfReeBIt2KZE3YYZ7IUGz4GYWqn2/2?=
 =?us-ascii?Q?ZMcBsJ2ABU2VEbFquRV87qzzADfybF5Ej+PUDQ9F5jJNNAy2XnKUfzExNhbc?=
 =?us-ascii?Q?MTGB8ENywDfr0GU7fdlkOT+xGpRFtALHpFXWaUODwGh85vdlIr9vlhVBVVQY?=
 =?us-ascii?Q?BP/XdfTlXm+b/XNhsR3/v0QH6CupAN5vEFB/jMq0ARRBVRkLliGJ8uBDZNad?=
 =?us-ascii?Q?ulfv+H47V4dwIjwXiuZi4AB//zj1fmJifT0u3ZVBckVL0EtUaNQw9tQFul69?=
 =?us-ascii?Q?5W3mlPb/XID6sHIvjIb4eNhWoubTY8sG/mNVoWbHIO6fzUKJ0+gekrffjkxW?=
 =?us-ascii?Q?eJEL4SBbW+6Ed5dL7B869la1UZS0RvErCUpvPR54czU6snmrESG4xrKRbsnp?=
 =?us-ascii?Q?vYjg4NU9/SpAJXUcRj+pVYpLvFfPTPkoqxSQMpZKUBCaRm5C4cEdgg7U5bh3?=
 =?us-ascii?Q?yRi1fR4gCcWcYwDQC5wPgzuyZkkOaJ88SRWgnjJZB7lHXnJ3G2lJ0UyCSqaa?=
 =?us-ascii?Q?2M27nRAC0dKV3uqFBKXgrBGbMPuG1tTu6wyvC+95wXHHSdlddAr0RfLVPklO?=
 =?us-ascii?Q?o/FoXsgp31JVZuKJMxmTf/lhI3cm6MJ1SsTyggBZYLPZOF1U5zV0dkprlCOK?=
 =?us-ascii?Q?4h2Ze6R9vDeywHgd9cWCkH6hazCVgacf3Lq4RsBQ9CAJMET+3ee0H/rfkrp1?=
 =?us-ascii?Q?8dugjqbFF50eW8vtKf1RniwtQ/m5ieXidT0kIzKCchOoGM6tDULQB5FRk3uD?=
 =?us-ascii?Q?zy4d5UqMakIfS5MLzGgZ9TJZpBLEbz8i9cpyZYuTzIkPfIoqtMpDRMwd/nCk?=
 =?us-ascii?Q?6AFOfiU1IM+aYosin0ImNgVOCT2CiOs+UXJHlovcrHbUI1RlPsShZ+ieXken?=
 =?us-ascii?Q?+W8rQaI5Tl5GLOzlehAw51Fc1GUG+F8LlWnnbAeDrdB8zrLNUIEPGk9zSEMu?=
 =?us-ascii?Q?J74Ij/KfnL3yyQh+z2a20XA0aoNkESCkc6uF3g+iQ72neUZKyUPzOShx6h+l?=
 =?us-ascii?Q?IzAxNGH3NJZWHsxzU74t0rcbcD8PiyGEY7GOAfUqn6FcrhHD0rX5HikTmvfI?=
 =?us-ascii?Q?fTNRLLLp61xd+UKpUf9dlMTma2fHKW1NMbjICAmZ3pUsMiwAhrvs3Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR13MB5545.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KN1fnag7LlazsZuAF7XCJoJZsMqL5O6tIpwE3S88sljESHORWZeVBj2IO4mf?=
 =?us-ascii?Q?FjrrEv5D2wJD5Co8pH6HSNk3C1KNeoCZp8YWGKxYVMOvlOzWDsLYEtsWEeIR?=
 =?us-ascii?Q?+Xo3CWAfcEXSLJPP7Lck1zJqrezWG5JjB/YxwyAZ7y+uxpvlTP5chLJ910gH?=
 =?us-ascii?Q?Q8T7FAz8vJqPjxkqfrbjs3bVkXEHNP2DoFnS+3L0aJY8qcHAGB2UyW86FGnC?=
 =?us-ascii?Q?tq+MujHiHmoMGgAbo1wAO5p75N4lgbVs15it6IKpxgHnNgKvr00Hv1C5h1XR?=
 =?us-ascii?Q?RoQpRInVw+s/HzKfiKkk6FpPdhNbusL1ORban5BGaI9BtHBR+mMmKjTuBcNy?=
 =?us-ascii?Q?bWtnPXcAeMz31AUgPT1rzphouBO8U3FvFSBtS+ltcCPQHxRpiBBiMmgepRZ3?=
 =?us-ascii?Q?GsM82VAs8B1Yk17Z+O5M3idGlT8HZP90rfMdpCMmEk5YmdD834fPW1xWYDFg?=
 =?us-ascii?Q?sUnOMXJKveY4vkhtnYN/ktXPJWZjzzOOUru66toFVmUf+bQVX9i6njhAYeoi?=
 =?us-ascii?Q?R01oL30/MvojrFGwP0zvah0vYjeuZD7MCsR78s10lQbYss5sfjB4OJkliAoV?=
 =?us-ascii?Q?ZySsGViblyGPlrZ0a5q99+h80En33MGoJP9E5eFeGCaSm3vBygONexEFiZzM?=
 =?us-ascii?Q?ne03jZjCmmfkgyMuzYmkNmbDChcczSTIcfx6opnPJt3/I2fblsdtKxegHlEe?=
 =?us-ascii?Q?8Mo60hXg8tfT3I8eb/+t8PiUPECsnoUHpxdLnerB9ee5o/bRULfRhFbf+1zJ?=
 =?us-ascii?Q?FJ7MlyciFAf4Oc4MZsN13Eo36AVjoovU9Zm1Ui9+kDwZumAM2EEQ4ufFnyDm?=
 =?us-ascii?Q?DnPH0SXEWaMWiVQdRKa6apXBrhLdp5UOom77eBu2VUyY57WFH1X9QCWmc/yt?=
 =?us-ascii?Q?54YBekFrVkQ2AJD95vY+A4/ZEk0nyifL+QeV4QvJLTVkyCrJTQfTfekOPeeb?=
 =?us-ascii?Q?Ohcn3Yt9mC0FPbQKIOAD80GkW3fFN2ON6v5TFTHPQhaXsRd1ut8phbdvezZu?=
 =?us-ascii?Q?H0l7s2+xsKG2YSOV2B5hhREbKvotvKsnyjyFyCeZXwNdHdaa3AzOsbNo8HXd?=
 =?us-ascii?Q?I5BHwrTl7WH9VuwfKZ3ODWzneKW0DXYfpgHLZyCLggVRp3+6ruJupSJRECI0?=
 =?us-ascii?Q?pZvjqi6LYw7IcSsIrrIF2nZRgbP1ePRQMUTDo0FmYtpPt+rjQiHY8t5P+M69?=
 =?us-ascii?Q?F1GUP7EnFNlpik30c1eXqUCt1RuYA/1Zq96KZ+4ff7p1xyDyjHN+NX9s5aCC?=
 =?us-ascii?Q?MFxsTEIpF9LtoOaKgNSKS0ld7xT9xZ43y41RDQHIBtDsD0/qnQwRCuYIhbuZ?=
 =?us-ascii?Q?SAMYsXoIeWv67GJUGgp3wVz1lPZUnQTWxMbcDoDKM7qpFyov032ClpOikE76?=
 =?us-ascii?Q?NewOxEAL4qzoMhgt3YCO6rvwVvuCH4zzkF00i0fqm+h7ZC3ixR9rcRvW71AQ?=
 =?us-ascii?Q?AvMnwNFVX1+ue9a3xH04bl5HiGmJK6MSNQ9Wc4E+LkZOI8zHt2mOS2gXHuIy?=
 =?us-ascii?Q?cdIDXcfZWe7V0jaNqI8+uPuQjdjjhiqAc7XOp2lQLjh+KXzqSOxSsVCvc1ME?=
 =?us-ascii?Q?HAFpVkZFQN2ABy/iPEXEUVXlQ1Q+MjK8l3kcwsp1F0m0tN0PpnWdKlUEG8Cb?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a6cf51-3573-424f-f572-08dd7662efdb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5545.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 06:02:26.3651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kT2UAAmi+GvZ1J/yvRHkH7e2W5YqD567NsMN9IIGjhBgFZI/aSwo2fGj2vZPT/aVnRhOlTfiVjOnLnt6sR4Tjfn/XR16PkjshsvQE5FO3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5918
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

This patch series try to correct the RSS algorithm related logic.

Chaoyong He (3):
  net/nfp: support get RSS algorithm capability
  net/nfp: support get RSS algorithm configuration
  net/nfp: correct RSS algorithm configuration logic

 drivers/common/nfp/nfp_common.h               |   1 +
 drivers/common/nfp/nfp_common_ctrl.h          |   3 +
 .../net/nfp/flower/nfp_flower_representor.c   |   1 +
 drivers/net/nfp/nfp_net_common.c              | 227 +++++++++++++-----
 drivers/net/nfp/nfp_net_common.h              |   3 +
 5 files changed, 170 insertions(+), 65 deletions(-)

-- 
2.43.5

