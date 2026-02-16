Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F95E81A5D
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:32:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53D4340296;
	Mon, 16 Feb 2026 18:32:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7D84140289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:31:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771263119; x=1802799119;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/Ylfv6Vj2jVZ5txCpgpwhrk6oKyGx75YQu32RdKVXuk=;
 b=dB8c/35Sy18dAlL1hPHdkjfmMrBrhbCAYaftGkIZ3mkzQUS8IMUrZsU6
 /rhaYJBQeDZr2sgP9Zn0NZ4YTRp4ixR75Y6LMuM65LR8jtmV/0yv1pivS
 Z9NdcNdzvvQP/6IZCzom02d1qvcyTi56wLST5y+WAKy2EggH2i7QO0vQC
 fhZxWEWFIQFF+fIPxygctujM35FbC3z8pX9Y40ulvI7cyiwrbzHoqcsG0
 0lwNEAvTS/4QjjLduYRy6UmLSaNXE4YI7APISMIcgzvbSkAtVWcaKwyQo
 QfHDcy544c81X+p7OQHaoLHlk820V5zoJXC7y72xLAkvwDAUZFN0+toIQ w==;
X-CSE-ConnectionGUID: UZXXpqSiT1GEqAwyEbW+QQ==
X-CSE-MsgGUID: cJNvrDFaTOeNPqI2hZ4COw==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83783311"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="83783311"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:31:59 -0800
X-CSE-ConnectionGUID: 0XgzUTU7Tl6XeApLir/cZQ==
X-CSE-MsgGUID: gvDypTs3TPyi4g2/nvReTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="213504041"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:31:58 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:31:58 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 09:31:58 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.15) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:31:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuupDiR8/4oibui3+GcyGm3Y6kMeF9LKn3NOM2ZFL2nUG6O3MOEBBre/bOPfs0s4f7DZzM6rffRXx3IKB9s6vA1nuWNSql5SsgH/bRPNEcYxhpBIHMXForGLDCg71TgpuPP3uCURNsqlUQNaspB3gAtk1yjbhavjG0v7n+20sZ2h7hdK7bnC06vnJoTrLgGIkZLDraUXgxCn/BO2I4XccdKqtSXeU/MMjybrCUhemeFwHusx1FDD/i7qhD3mQIGbYF2LPBiGv8nokkrMNDO5or5rnnhIt4kQkPxzDIDvjQmt3EboI60zWkUnSE6zDM2Rh6dUHqIFmsw13nK8MILT8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+G5s1CYq1yZF4Cpx0KCpaSTnHK130szfz+FrGrD9DcM=;
 b=WTuqLVw4jtdvW6OoHyjILpbFxxZnNSQlKa48fN8XM/1RuQs76Ahfd+RHZaPPuvfnRJS7FtQmMVztpHWXi/AlMs4xLOD66tWw4vfFCMSNQL0suzCWlVDwa35alle/kS/+UlOq1wCBUlhwcGTMdHgdV08IopvwjDpHatl4EEqnVWOknkbd5Bh99ukkKgLBzaO2QRitCKUiDfxAMrzPqTuio+MNvQ2xo1v3SKFjgP9bne9qbqoPBVl9VI8vZjoX4UkFAt3KbnjEXQDiz27m25NlhjgI/kKs7fiDvBL5Xc9RsdGZqvI/OwRt9r64pMC//MD/5iytDNUmY1WaOdOh82VgzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB9452.namprd11.prod.outlook.com (2603:10b6:8:263::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 17:31:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:31:56 +0000
Date: Mon, 16 Feb 2026 17:31:52 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 23/27] net/iavf: avoid rte malloc in irq map config
Message-ID: <aZNUiI4kVqZ_rpUF@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <fc61ca4f63c17e6170d0af126e4a4fab6aaedbe9.1770978324.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fc61ca4f63c17e6170d0af126e4a4fab6aaedbe9.1770978324.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2P251CA0022.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: e1cf3b42-9bc9-4d2c-8e6f-08de6d814855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QcM6DZQBr/WRej5w3wdjW1L6tHF+NIW//bkA6OS1l7fghFpX+dz75IBfqffD?=
 =?us-ascii?Q?6xjdsBMQ4xyiUpRUI8+qQvKGT6ix7tl0wZIAsNWUSj90tioZICmi2j8k3Skz?=
 =?us-ascii?Q?6xytCuHdlaQl56XIeLorNdE4PLTV1Lmn7H7lJTM9Hdm7klVuQI3qLxSy1UfC?=
 =?us-ascii?Q?qUXO74ckSgt3y/hLVofE9ZvRS/KQlGAd/xs/U7LtUdIb2biaMnL0GNuSfeX8?=
 =?us-ascii?Q?AEBLbSbJ2B+/s2jJZAA8Lcb7SgNc3dKqhDeVng5dz3lgPSsH+HlVNflzh2bP?=
 =?us-ascii?Q?l4rcRZ08jwiB4dlMS+0SNcn9LzxcQece3MZBRYXe/IfRK81PClnxHzZ5JMMI?=
 =?us-ascii?Q?cDUvgzl7eWynvKRY3/vyu7tH6qjEGnXQTCb4x9MrOpxPhewswa5JU3vCDcvX?=
 =?us-ascii?Q?MxZkwdRVopUBQhkWoe7cPmUFvXEbD90w7uiNMmgkJ4tdkq4TdvgSA0CaIdsD?=
 =?us-ascii?Q?hi8cLioDf9zN3QXICL9DlRnO1sruTuE3lU3rn87cD+xShFI4cfWacepMdsSJ?=
 =?us-ascii?Q?d2lBJ3dKMpE/lklkyObecnuYJ0auUzcVKDMg2j2aEXoFhFEX3Mzl856G8VOy?=
 =?us-ascii?Q?8POmxoU6QMMYPsUpWZgEkvVOv3vjYb1hwEBL1Ciupq2Ce6yLstStm2X8tk9d?=
 =?us-ascii?Q?cCp6qu2g0H1mCN+iAl0LfWbC7qD3acd5IW4aQXg0+pzQbcwAzinIC8CNaCUs?=
 =?us-ascii?Q?4TDnwVoZH4jrpRBAIDeyfXNw0F8g64rvVMxur8R3qEuO7POlZAk4dnl8FZYj?=
 =?us-ascii?Q?5xsjGER3AGuXiXrPga75h2Wwn6ZL5A6+0mV29fK17T/DjQQozh87cl+U0xTg?=
 =?us-ascii?Q?JvKaPUPTUmN05d+NnWz6Yi/C1KSj4pbLHFVBrLs7gwkZ7TQhwR2nqXC3/LHS?=
 =?us-ascii?Q?ot0nDk71xjFKNZlFqmCJnzjfa33HGSR03tdtPJvVPTcIsTqrxOcxiRwkZJ7s?=
 =?us-ascii?Q?k0voYqwbjMaLnO8ghRiZqDj0B2EhSPXuR/uI8gTfDDlYskUOCrjzp6aoMnLQ?=
 =?us-ascii?Q?kV8J5uCtwH+9YDqgks54uLhUcXuSQuUK5IWwNYaMNqmXGJKD4+CRg8NMjcjA?=
 =?us-ascii?Q?hPgy9qXExOi04U9TFHA1V4vI0hU6aO1yEERVGZYVWeGjUMSLwWBwx41WDnXd?=
 =?us-ascii?Q?oqnH+qkoqIGrN3tI2zm/C1Mwu01FpKnsH1UfcY+Ds9Ki6EP/I9cOOEzz5Nzb?=
 =?us-ascii?Q?eo+mEl3IlI+29xByDDWQusZ7+TZl/t7pGSlOCWNe63ovnwEYTfIvxlt1pBsq?=
 =?us-ascii?Q?+pkWBTCIV0+uZmeJIuYp2lsJbcQbBmBKCczbt221Gz+ttLrGVrvUPK+oI+FD?=
 =?us-ascii?Q?EQq11cIRGMa1kZx7vhefQgIlGKOn0UBW0unq0SzYqfa3E3+Pmh+3sfAK0LOi?=
 =?us-ascii?Q?MIpowZXgdyXqrQIUmZ0TZHD9XxJOdep7EhPPeRUuSJWYGQ29tX1MG2Uv+vmY?=
 =?us-ascii?Q?EhB8frJlQFiS5wwy1tUQZmhUk+nsMjhsYmAliBhvdzvrKIIPT07YocHviU48?=
 =?us-ascii?Q?sy/Y462LynlRR8rwHwWuZcfVRhcdsfNIgfJFJPDkY02fJDatWHdk3HpLsMKp?=
 =?us-ascii?Q?f+PGYsMveZlU0nR1MLQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pAtlCwoTvWFx1sRwYyRJIkdExakmMN6M4f8QY6WfMLoBjqw01NAjvB36XijO?=
 =?us-ascii?Q?C0X++zxBPHPw6/Wfd9JH9GJNy02/FfnwHztyZiWzEpMU1zc8zAxKX8jMOhvg?=
 =?us-ascii?Q?LuTtz7AqXL3Z8Q2Mc1uqJWEJ+0WwIzjow7ONFV1UaHI6EqTXlR1WrAF5Ohfi?=
 =?us-ascii?Q?f1E/jqDrz+GQZeDM5p/agAGMR4EV/R1CqCwQa8C0+xIiNqALaISaehx0A15O?=
 =?us-ascii?Q?tLTjdnHk2qkEcFwlA6W+e2Y0Vesj7hnOGMTMUio03DaLPK8eSr2AmERpQ8Cq?=
 =?us-ascii?Q?x0e5AuZ+feafXh5uPM4W1vmXeWgmsKzFwbbjBs3yyjcZ34ESSMVZ5y/IArxm?=
 =?us-ascii?Q?FpUueBGbw1RgGsNdR424MH1UBfpbFTFOaJlBcB9/fKQ5pRSCqaQ53nTabvl4?=
 =?us-ascii?Q?zZhJk6S2/PCfLkRmHcKfAySSX4pE+741FNkSO5502Z/Fw2AZHuEeuhNertUd?=
 =?us-ascii?Q?u82kIhxaYzQM346k/dIhIhmuImUc3dbWK2MUVUkv06jY9wavJ6kb2cVOYCnO?=
 =?us-ascii?Q?32NVhwkczDj3uyfH/MHXL7O3bHn1SpSyAOmfsdkLIXYqa6n1K/eyEImLQrcH?=
 =?us-ascii?Q?dSRa86H1VYC3IqNSovPKIoQx8O0ZPGrdplLR3FrZeUOcqlXhs406pZwJrfbe?=
 =?us-ascii?Q?GCmciThoZF5mSoTb61rG9Uu5DlkO+XSG3C3uOCGWOhfCzZpOxqsJ06Qd7FLv?=
 =?us-ascii?Q?Nj2Ge/QLZgYiPFetiTCpuQftbw9O9JPwpwroZS12zLkEIEUpS4jqvtEGD9Io?=
 =?us-ascii?Q?pyzeK+PVjaW5ZmOEgQEsyGIrT5muINEt+6TavZiW8QYFgA7mTlBm9W6RCNpA?=
 =?us-ascii?Q?O8KIMJtcfGKNzQt2U8l4hjxY7ZKWCe/YF0SKALBSxA0kshPjM8/VKwsUrppH?=
 =?us-ascii?Q?uWnSQq1xZq6qGPYs8pWeoJGNOy1Qm2ZZIVYLuxmjUg08zlmReAd4ozv9XGq3?=
 =?us-ascii?Q?gigyWn/uWI8xm/Pvy2Vf9qvy1DA4wC6R8KjJ5I2v/wrhZYwo+/JtsYC4vVRO?=
 =?us-ascii?Q?Q0U2x+wVFy71iSesggcRpxapo9Z3TFyXUTwJ7HAcbBiFcB8Xt0cAmLNBep1R?=
 =?us-ascii?Q?U2Ik+YJrfitr87ZVCYtqxzdw/odpmLAVFMraWWPlfFGO1lyNCgMuYM+oZfCI?=
 =?us-ascii?Q?catMIcgZX5FPb/aKvjlR3Ho2mDT3/vp5/RQSUQTLYi943A0WMOp9xaTStOUT?=
 =?us-ascii?Q?lwKk431wEFXcfzeqYlgh3KQ/bIc4HvhyeJykmkOoETzWrTQxN0FDMioa/NfP?=
 =?us-ascii?Q?Z1rL2kBF3sU9dPftFDpG/vrSczxVKUn8sQtLjHNIhWqi6s/T6F4xNOEhBq8Y?=
 =?us-ascii?Q?i2pIYLYdvMON2xudCPYULN0+icPk1OfZAJ0/TGItFcUUzdk8SoM2YOcqJQa8?=
 =?us-ascii?Q?LPSCp6jD+xiuJkpBqH2RB73tpqzdgP9oRtopTd4hSyEYRaOqa3DBw8qGfgGz?=
 =?us-ascii?Q?8BcmGY3j0xNEcaNT/f2n9tlPdPZHssvkwivrs5JmP2EabjF4XKhpEWRYloYI?=
 =?us-ascii?Q?A6jV2f1hcsLVCAbuuV/Ao4To4Gnj/B1vfe6vlzhqCRIVkQBT5KY/hRaf6Gu5?=
 =?us-ascii?Q?MfqWqQyg+wT+ogmEH90ZrVKsw5CT3DVNUa/FfqdqEuOqNizx6C9wH++KTgHu?=
 =?us-ascii?Q?RF4ykdfYAXy1718M0n9p+gljJa270GLfFs8sYDXC18MEkU6rE3ORDEo1dQdl?=
 =?us-ascii?Q?7eQm8bfUEvvimWavpvQHwJY7j6FYdfgHPNOSwfO7tvbjX7YsXKd8O5MJ8ptR?=
 =?us-ascii?Q?z31D8c6HRoRy5q3spDZXA3ZhaMt0FNs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1cf3b42-9bc9-4d2c-8e6f-08de6d814855
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:31:56.6312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjITBLIKxiXtDSN3+WZAfsQTfcBAViqZOoZXqhvu332r1Gibop7YwAyn3dxmu6Ljwgs0azjcZ4c/2J74YMC+jjYPdSHEL/xBefQEJeTHGdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9452
X-OriginatorOrg: intel.com
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

On Fri, Feb 13, 2026 at 10:26:34AM +0000, Anatoly Burakov wrote:
> Currently, when configuring IRQ maps, we are using rte_zmalloc followed
> by an immediate rte_free. This is not needed as this memory is not being
> stored anywhere, so replace it with regular malloc/free.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_vchnl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
