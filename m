Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23170C369A2
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 08:10:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B595C40695;
	Fri, 11 Apr 2025 10:10:35 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2103.outbound.protection.outlook.com [40.107.237.103])
 by mails.dpdk.org (Postfix) with ESMTP id 0152240285
 for <dev@dpdk.org>; Fri, 11 Apr 2025 10:10:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9UQoy6iY7pzTEIy2CkPEAO7uWNFyZT3Pv2y4CTVsMunMGy+Uno0y1kyZvbm6jw3bRFRtUQAo8ry/ovePB4804JDmGuYI+oprp33K20a/M5CvDcaF3GaAXU9vZxGEvcpnxU7+PhEwi53MuEeW3t+2YTqlRgmlETGrgxKR4yKooeM8QBbRHx9eUM0L7JALIlM7/2Udxh7stwmzJeXQ1SwwH2G7mgy48KzUY0OYYK7ytaTs8GfCcwHoQ9OY6nZeuq7ORgb1bPyfaWimin+1It3rf8pqSdPGGcbYydY9RuLPa3he2p8XB+SmSqwWgXplCk/zTDGPCD3gFupi6l+0lMnuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ci+pdiLrEBxMwNUmkbwbsFeCoCjq+gbY7Ach+cOIdqs=;
 b=nQy6eV+XT4YnNe5/iZJff9IqDMvaA4diV1oK2m7AGLulOCpOh6L5PfJMwiMTCiFdIUhAYtedIX/RHWhXJOzg9uSF/Fp1iXwunr/+8bGmtAkuyoOQleb2eXC9xY2YfSzp3mpdz5d7dANTPrZXj5eVP4L4l3MNB65o018wNVgok/LGEWMEnlWB6argNbroVf6M0+5PNPE6QwuGFi3B4vBIsTMkmVVR8IVcdESm2FHKwvupiQb3B3u1ia+FuyJnBZFihC2Xg9yZ4Rh0LHbNVoMasyvtVQ0UaHJJ2iNP+yzswJaA5sEEkb6ydeotGnB5N1roxJT/n31NGsmMerpR7pHVQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ci+pdiLrEBxMwNUmkbwbsFeCoCjq+gbY7Ach+cOIdqs=;
 b=jRzHCvH0uHGVOmOIo9rYGfJtSK+ZZrbY8bpFDh9Q6zwyV6H27zSNxny7XluPKwdW2m05voqg5CBDlCUl2AK0J2UFJXCiQ+6vlL0GXBkCuRyvbJcfbmS0lV11n9C4oaF5n5120ek3fjioTVbLDxBDsq8iHoo3t5321yRZEKujgnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5)
 by DM6PR13MB3940.namprd13.prod.outlook.com (2603:10b6:5:2a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 08:10:31 +0000
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833]) by SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833%6]) with mapi id 15.20.8632.017; Fri, 11 Apr 2025
 08:10:30 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: dev@dpdk.org
Cc: oss-drivers@corigine.com,
	Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH 0/3] enhance the vlan filter feature
Date: Fri, 11 Apr 2025 16:10:02 +0800
Message-ID: <20250411081005.1133509-1-chaoyong.he@corigine.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To SJ0PR13MB5545.namprd13.prod.outlook.com
 (2603:10b6:a03:424::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR13MB5545:EE_|DM6PR13MB3940:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d957db-c8d2-4cfb-e17a-08dd78d0535a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UCgl271quceSzHJ9cQJ2EWaNFA5w7JUXH4sn48DP5Iu9UK3boOBhWhRetJB5?=
 =?us-ascii?Q?tE635H7xji3ZJzXPEGExhp5UW+bfnh+iIqTDj0aUfuWBJtGSExeJ2WmFux0D?=
 =?us-ascii?Q?g+eJY90rl+xEUKTKIXYW3uAdIE/pEtQfzi5h3b8S8AolhaI4zxksA9U8r9Zf?=
 =?us-ascii?Q?XlRIJv3HYCfjQWz7b/2MDFsrv2JgbX+VZclGBB8+E4dXfvSry664eL7Psnre?=
 =?us-ascii?Q?eRXKzoFu43zqNX8bXOfXAR05t+sb0GSEmbfoQ0Tx5lKHrAZTKTlkz7+YslrH?=
 =?us-ascii?Q?4wpCNnYM/OAoXnke6+HLYCKjqCjuuKg8zF2DgoxWqEbK2H6jewuy81G88MS/?=
 =?us-ascii?Q?fPLOeDQzwdfVdLYiLgPYddPDKdKwCr6as+0DO+Besat4Foqcw3cMqJQDBb14?=
 =?us-ascii?Q?DfEehix4gStAzTyNpJszyDNdGx6X+xdq/7C9CZNxuyx+pVwqzrdISk0zdonK?=
 =?us-ascii?Q?hu9Kg7s9weV2t//JMASC9Ramw1ueKyxkD7pm/X3E6vUIJjXe3ORVhXN2nZxB?=
 =?us-ascii?Q?GqeY57dzCb2zCaaG9gkZERfUNiesHSKqTK+cRqQj49m1gk3FONSRV7oJ+hUQ?=
 =?us-ascii?Q?GGXB/uBcOBy1p3RD9wsPEHJL3jJH79Q2o9/RKEIOI4wTpWfpiZSq6DlgPBrU?=
 =?us-ascii?Q?qfrCi1UZX2jAMIF5aijuZA4wrs5hzCB8W9pebIpyanRRF6/nJZ5Lva9Hfs72?=
 =?us-ascii?Q?OsdRFK36tq+stTs+ZxsTSSi/swqFxKSwOdkdptQuEcaBBqPkNwWpFq11w0KI?=
 =?us-ascii?Q?ZnA+Ncu3YfkKaKbxcJHAwwE/dO9RFr5agPkI2VUkM3zM4cCMxc+Qixeo/E0L?=
 =?us-ascii?Q?xwVyp6HePhwuUBL4NDJHS74G3xu0COWq94rTRtEymq8REIYeUVmPOCYsADIx?=
 =?us-ascii?Q?+4dpILfW+TJ97Cy3qsq2nTxVRaenN4kOMRlvoYwDPDxYNp4mj5lIbMJtgM9F?=
 =?us-ascii?Q?J0vQQ2NzGJS7PovJLzZ7Fjvk/NY4Hk+WArJmViBrye44rwYFGDzmheJWLWBQ?=
 =?us-ascii?Q?KNhkKKUpeximVJRKbq85X4Hr74gu4EoRtKMV356XaDIk/dz+kFJbhlKOtNXN?=
 =?us-ascii?Q?EvMpWTqePY3sLgKDy5ulv+2Uyl4vV7Xmwv9FrZ1TNVURZRexwq45D4oCcwcv?=
 =?us-ascii?Q?zemh+Pk425usRmGwviTvNYGzKY48xcPdQZnxXTU9N3cyGLq84FPbbMepUvRv?=
 =?us-ascii?Q?GVy9D7bPUa7sgpI+9iOjULnhStE9Om9gvpm9XDZVzHzlgS7j/gOJ/BfhWG2r?=
 =?us-ascii?Q?RY/MaPSam/56zwVdjxbRy3cPIpk3dmMfr2haaTC3n1y90fuW51WcI/T5dMSj?=
 =?us-ascii?Q?rQnnUSGqeoajFwgYeK72NbwvREG2tC+k1XVXT3u9/z6kCI/Zso4uPzYCwBVx?=
 =?us-ascii?Q?t9EdD+K1zWbqpD1+aRz9iYFcdooAP7BcxjqfQhWOHb/A9IfLY5x8B3lu43wq?=
 =?us-ascii?Q?EGRovpRj22khlVkTP4S7pm7vMJpOl7+a6O3u3gV8bGiIxSR+g3l8Pg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR13MB5545.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kyt2uQpzvXmY2gp5BnU1Kwwzjmp9y5HEvwAPn99mpasGMfxRU27YfYcaD/MN?=
 =?us-ascii?Q?XJtc1ab2bVxJi0YtovO/6hpwyZYMNmHLy2t5FT5zLBNUCgQqk+goHpWj9mKs?=
 =?us-ascii?Q?pAJ4zpzjkCslwLwJ47Qf0+Uf9ZB/st/SKKKGnbnhutB+GvZNmFpSsOYZFmxh?=
 =?us-ascii?Q?1+L+cDRkcc0YO38gr4yd5XsoVTqF4FJ61yE7IOELH4hcR51Rf9laFJmFzni3?=
 =?us-ascii?Q?klkVsWegm17bYLxDyfGuIhx/OYuqxnC1vMStG7FShW1G0NKV/0AUX4FRBizv?=
 =?us-ascii?Q?YsUXuPUi+YWZd2JVUernc5nA//EmIWx/T7e/xzc33II+KwRDekeoeEQe0NyP?=
 =?us-ascii?Q?QoF/fWGMrBoCIdQOgRPPJh1n8+6wH0WfVQAnFk3quC8nPOd46MYIX0SsvKry?=
 =?us-ascii?Q?ELd3TpLsJkD8oOh6dDLl/9wcY50m0ge/6vnotV7mxrHb60lE+9EByBeMNLOp?=
 =?us-ascii?Q?Q+wUAymTcqTfGu48cAQ+J3Ff/BJMLFHUN7MciF2uHefIO8qk1SEzzZgA51jj?=
 =?us-ascii?Q?k4S7WxfMEf2rDThPMGLznKqqlcdp0lEFvhzNuSmG9bkkoZmoMg4wx/TF3e8g?=
 =?us-ascii?Q?HcBOy3Hqrv61ooXZabebICKlhyRnqSgAosvTcM6Yk2PDKUYW+TumucyYy30v?=
 =?us-ascii?Q?xu8lMw1lphayG4NtPDEtuhHdl2Kd/tqUqaniuIl2Pd144iJVdX6CinLg/00O?=
 =?us-ascii?Q?z4TU9nw0bUB8Di+Nqpy78Ih9APG/cC276uzBANIDsEckMQu/lAuc7Sq9KYAL?=
 =?us-ascii?Q?nlXLFgd/5i/K2f1jiLjnbQdO3g2OCY2bjyQDfcVf3kIdSTfVeXv5nn9dSLVD?=
 =?us-ascii?Q?/ZoQ2G/5Uvlv2Q7hwQugE6/TGP8A9nr9NwePhn3dul1wdMjLZoeiukoQDkDj?=
 =?us-ascii?Q?bAAxNjULFuYS0Wh1iin9bOfZ3r9sEYjUDRJJaefdYXMGTuTqcXFndjNM2ohl?=
 =?us-ascii?Q?lkZUaGPsySePUlZoIYeG2Ymav9tbFQH7ODQZ4k5nAXD6lZePR9CO9NsuH9h9?=
 =?us-ascii?Q?UdFOWOvknwr1Klk4JztcFxC7ksVLsHHxO84HEyq3kD6L6TamQxeXmYhX6HQZ?=
 =?us-ascii?Q?nt7gCfSU5rnVNu2l7rUFsseYx+ABptnDLO77fi6Nfde+OuTZv3FKjy94RSZx?=
 =?us-ascii?Q?bR09j6D0DSuZ/g+ara6ua3w7kgBlIG4hkVr/61CXgQl3XsocPSzGyILuyKgu?=
 =?us-ascii?Q?3d/hWqyQPrWZjLogugCD/eTJjVOsfhnpz10lNbYvD4MvFZtS0O3Xv3RJptUB?=
 =?us-ascii?Q?dFE+2a+XGyXy4oElc0a9wEetmUZ5h6Ij93ZiMK9SYmzAvZwRYfDgon2iZ6b6?=
 =?us-ascii?Q?puqbmKIl65V9qbDUogrUqaSf9SHOnlpgLIWJqLLL+c4oO+nUzkJSP/lzOcr0?=
 =?us-ascii?Q?RcsgmyrMnz1EHyR0SggWt1Ep2TaU1CdJpSiFJllLMpt7pxYAhKKNYf+XKfNv?=
 =?us-ascii?Q?YwH/zmdfB7/1zylooLeWjYIPUHtDc/+YUMgAAIcxi/aPXGUv7yVDS55muwRp?=
 =?us-ascii?Q?2VL13JCwKezC+TS/TQ93rNK7fqYeMkMv6QoTLxvXryvSCNXEKkO6oIvSY9+s?=
 =?us-ascii?Q?3Gk8OXirPSGYvF+qAvLQjwIip4wj6ljIVgDoUA6ahnUtxhb/dim6BVyNZ3Gt?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d957db-c8d2-4cfb-e17a-08dd78d0535a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5545.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:10:30.6689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+vL58C0Tirl6xOt2t16QiGyEqVWGdWmalwfp53BAGAbgRh4PVU19KLBVdISQfn2I6/CMYDnmnLGwYW3PwrM2IejWZcH2UqX09MvzM5lbYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3940
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

This patch series aims to enhance the vlan filter feature:
- Support add/remove multiple vlan IDs just in one comment.
- Support show the already configured vlan IDs.

Long Wu (3):
  app/testpmd: add/remove multiple VLAN filter IDs at once
  ethdev: retrieve VLAN filter configuration
  app/testpmd: add a command to show VLAN filter IDs

 app/test-pmd/cmdline.c                      |  92 +++++++++++---
 app/test-pmd/config.c                       | 128 ++++++++++++++++++++
 app/test-pmd/testpmd.h                      |   2 +
 doc/guides/rel_notes/release_25_07.rst      |   5 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  27 ++++-
 lib/ethdev/ethdev_trace.h                   |   8 ++
 lib/ethdev/ethdev_trace_points.c            |   3 +
 lib/ethdev/rte_ethdev.c                     |  24 ++++
 lib/ethdev/rte_ethdev.h                     |  19 +++
 9 files changed, 289 insertions(+), 19 deletions(-)

-- 
2.43.5

