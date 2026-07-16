Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1C5C44501
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 10:58:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5211B40270;
	Thu, 16 Jul 2026 12:58:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 6E4CD400D5
 for <dev@dpdk.org>; Thu, 16 Jul 2026 12:58:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784199521; x=1815735521;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=k7gxQFMnrwEO0Xxati5BB2x58gYXLa7Pl2l0kt3m52M=;
 b=HJ39PMoQQ1uLtsSyY1PFbWHxPdYd3G/rfMEd/W3GusRxm4HBpqvQL0f4
 FVfTJsJE7r+LiPrealZhuiM4Jy8wExCkYUyJ4ORsJCxRiXyjp+b3xZm3C
 DcA7cnsCXzJVBb7ta8apua3FWTf4Uk2Ab62GOM7jq4dPAuFHua6bIVyoF
 WKMJseEzvkc0ltzZ5nl7He3DLV/4WncTGOMua12wCIXgebFuVqKFUBT+R
 5Jf5cvb9R+BfYWttft9ld6tvUSP5XRdzQchI2ZdlK3AuMdCkA8YfYZyve
 3ZJsYJfWe7bdUMFeDnbFPa1gR3mr/GOXm/XdLOLcp9cSOiDl1P2H1tLzd Q==;
X-CSE-ConnectionGUID: SFLnImJKSJ6snKm4BjeBvw==
X-CSE-MsgGUID: izXOy2iCT82MHX2xT+EiBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95458082"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="95458082"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 03:58:38 -0700
X-CSE-ConnectionGUID: 9LddWybiSw+BCrhZrWlizA==
X-CSE-MsgGUID: OtSWgHPSSCG6qLwmzHrj8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="255328246"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 03:58:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 03:58:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 03:58:38 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.60) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 03:58:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHhGhecz+K49tGTxu1Qb/skES9fWTRROQM1TOmIVzzrHYIXvIK7GbNMhact4Wlzd6tYmrPGBfiOOQx+ITI5VhEhTEShMWDeiBnwQrm2Vh8n2LoXQeXRbhU7f81eU6+0CV8LwCHgUZ2wNTFkzLVtUdc4j0lrec6oyXyESwrTRlQTJL+KqKGGqJ0MIGE4i5N5BnPhilCry5g7vpAozwET03R229rarEbfNkpLoF+yLl9+7fB6ox9OqA0FxVhdmI9D/x9+ikVIYggH2kDHilhZII3pkqygIsWa+hP8NJ/RP/y4qng8fqfSS9gfor8kUEGrkHqqTjrwqioy7gGYcxoosnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSizDFSUeJfSKftqYKWI8bbEFVALBkPbotwoziCs/Cg=;
 b=WnwkgHYf8nJyCRjvzgGVQax1+BNUUbyynmxGyhJaT34EbbasUBn3tuH8GkRv7/+8vowiry6qjqOfqxF+UcHF7Tf75UwN8bmePvN0XkBJDq7MorjzD3EZ0b0hS9EsdVcW5P8XrJ1hDDzdXpS4u01KK35336+GteFrwOkWI/76tQ8i3VAmKoBcLvNIk7fh7yr32CzBfa1cekUFYDFW3KJYvIA89/mKNEVNxGqsSFWYLg6FfEmGfHtJiB45UlkNeiWFcMA7BxjrD7DkPkAUVZXi5UAzMHLlQKMG3HoJLX+Vsps4PXl9LfEj8W1Zi+N7tgw/KVVEgG+0HNAlzLsUeoxwPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by CY8PR11MB7922.namprd11.prod.outlook.com (2603:10b6:930:7b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 10:58:34 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 10:58:36 +0000
Date: Thu, 16 Jul 2026 11:58:31 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Robin Jarry <rjarry@redhat.com>
CC: <dev@dpdk.org>, Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH dpdk] meson: bump the minimum required version to 0.60.0
Message-ID: <ali5V3LlVPtDNBny@bricha3-mobl1.ger.corp.intel.com>
References: <20260716105330.1612578-2-rjarry@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260716105330.1612578-2-rjarry@redhat.com>
X-ClientProxiedBy: DU2PR04CA0152.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::7) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|CY8PR11MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d9ae813-83c8-4d9b-5ebc-08dee3292f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: QlMUwhMCpbh1cVu1WRSc6RNGNtuSGVQGt/2mlLPjulB0K3IhZGJ/VwVEg6mbL3nmdhYs0OspzXf/BrTC3eS3rLaA5+M3zWkncILR7tlZ0TqNSgl7Nrj4s+WgMiIT4CmUz2eIJUwumB6xnBA2u0aHp4kwjOsxYZJ2Qz28aEgmSKPRioBk/NK9to+xG1pUnQdsBjvzyPMdgU0wVCSvKoe5u8cRaCLB9vP3OTvHx8i+2pr5VZvxfixf/Uf4Eh1vBW3UteM/DFKHWwc/MDAsuyg1rmd0LwkR73fSnnDHigLkvQDqkzbBUN8fYB34uoq7f3dbgW9m6bVLkGpQvR9JVwZmj7CwQGKDafl1HlJo+qd5zrj9IL+izUE/CB2t3FOurWlao5+qYKniED39PL1Xew2mKKWYl48vfCi6xE3FfF09Le30pi+RrA3LgtqnL1h9SQY/IHYWO0z3FWrh+OGRv0kHOdA4qI5Nnr7EInU75YnmozdhVBJxGwNb8apZiau8r7enmlRFg3bjzunS09u4DK3/a7X04XA1XlVUupsWWsZ7rFDZnkhE0hLQCv1tJ4M0Xqm1kCzYkfOOkpRIqe/rE5dGA+ufWPwWHooz69iX6SofCNW3NiUxmyPX48CXGuM9plEUwu4TRIZIf2LCT0wArfAuNuZipO82tcqf8uzUVpVY5XA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1aw5gp9UeJR+TcdEwwD/XwFsVkMAcZcojqgR+SG1GmO2bWFN3AYzbmpo45UT?=
 =?us-ascii?Q?Q62QEPat2MqDipHQiHTwFtGDu8DeMItkNUUux1zVdsXKSGts8JC3M3d6thji?=
 =?us-ascii?Q?p07GE7zE7N6BjxBrn1kRdHpjZWaNI2AT7ovl/HCY8CtyDYm3hIzPsyjT2ZU4?=
 =?us-ascii?Q?R06fCFcqiufri+x8mcP9SWquFqGeWRS2ItoFRzgWSnm/bYVjCJOQFsa5tkpY?=
 =?us-ascii?Q?Cobsl96tUMr9yBwMA0+zRf8J/rXiqcgu4r3IUqwIjI01dFVaOLixt++jrZ+T?=
 =?us-ascii?Q?a+tc3s29++9BreiZ9RoXLLK720Z5kW59FRltg8cnh+8Soyu78plYcEwMH59H?=
 =?us-ascii?Q?OgqZp2CIvBZkOT6gpBMcGFghJyotJcdrP6LsgPchJb/qFD2MolRLoeRrNMMu?=
 =?us-ascii?Q?g3WMoxFibTMGZTnROIwHUKZXhsjiFG38sQh0B/j/oK5jLKTwO/rROGrvrNtH?=
 =?us-ascii?Q?VBx8leOhnedqCS7t9i6GeTkYA0vk6mP6isva9xaxhBnvO5Ha1I6/2t7LRaY9?=
 =?us-ascii?Q?rjP1p2g5kJ/HEmRrLz2dqJV8Z7AgFvmWPkS4KjoDK+p1fnC3TkfLO7qLdARP?=
 =?us-ascii?Q?5/1yLkxVYQelaCr7R3Y89R9lKyP4YmMMbjNam/xxQ+e9dvvt1fc0YgBIPC4L?=
 =?us-ascii?Q?FKyVKJovIr7kGUjC2kTn19ycg6+vOn+et3w5dm9h9yxdofdkGi0v3W1wlImu?=
 =?us-ascii?Q?cXiRv8iR6Y+IZBb5wCezbXBujB5otj7FjtlQ1SMPpxEwqKcaN6qGhjG4AMe9?=
 =?us-ascii?Q?s2nN5zvBKKtIeeP9MuPCEdoOHK5OIMJkF43B4FLlHBR9xTKHA6QbXqLzaTvb?=
 =?us-ascii?Q?8i3KHQIiEROs1EovF8x3k/dc66vxi2T4lq55xO+LpZov56PjKYGpbDpcag7r?=
 =?us-ascii?Q?8xTtzaPbAIw3inbVB2gxqSJXbacd5NHugrkq+uHey0mDy1DGweI7RM/11lru?=
 =?us-ascii?Q?pwPuljUDYqlmg3AL7lDIF7G6Ia8QBCXDHqcyNC791EESaF1XrTueTeYgu6sd?=
 =?us-ascii?Q?/vggTkEp2q0NkdPEkf/1kG4J12bHmziKSjRnBGlsqDbgYCfPVAUPHE8MWLyA?=
 =?us-ascii?Q?CRt8SE+nuRPhumeidM8l/zm5GqeIzyUc712X6fTwHKRRIj3hUPOZz25jsf7f?=
 =?us-ascii?Q?Jj+9U9iu8NqK7utiZv4bOEsfRupbnLQ6XphiJSMbT47gOtMZKuqV1w3qLMXC?=
 =?us-ascii?Q?aF9cfyaBLB10B8cNIeJqmhw+kFQQFXN9HiooQYfCXldvAqbMIGBlk5NNPZAl?=
 =?us-ascii?Q?TCz8GZ+j4WgpPuhz5l9CKBQPglixDoyh2RyAjtBFsPEUZHbIEFKTNvmzwgZb?=
 =?us-ascii?Q?MxpOzFKvc1oATFZnDBfTinu0ftA7BeXqCDIeQDfjL1xI9ecdfg8NOJcinLjt?=
 =?us-ascii?Q?ZWClFkj9n9JK0IzxIeebllfBMnpWqh2keq1BKjn//OUrm5BQVKxFnRHyWzzt?=
 =?us-ascii?Q?1c3Cyv04CnrEuDp9kPTiiwO4He+PKYf/gxIcvQuHk0g5+SpNY89ooJR/mxc2?=
 =?us-ascii?Q?/mCfE7uvHltTSXcH2e5QFzB1/BaOujyfAydKbK61jhmsEezCH4G7IIW0E4sf?=
 =?us-ascii?Q?PQ0tcsNqe+LvnMDal0i6kfJkj7fEPlW9gyoqA4k5CZnJRjYfvO50FmELjl7R?=
 =?us-ascii?Q?1H7PhlZ5p3BYsBxvwBA74INQUcUhkhIdE+M5/8E00p13WIPscoGOze9JI15U?=
 =?us-ascii?Q?rV1YNaL0Hi5m1HeS/8d/IJmTD/ArTnsM6iEK2kmPXS8jsuRKnwGWBV3A2u2m?=
 =?us-ascii?Q?Nuz282LCIEyZrKwD/3N5sWOMwEco0eg=3D?=
X-Exchange-RoutingPolicyChecked: a0QJrGXneh8K7xZkyPfU/spBGyDzTahtkx76CYfrGnrw8RrcsLzWF46Xs4WL2jFYxxZyGN3fvIPmcNe4TCUK8F9RvR+cKsDG/a+cmrT2YRxHYe2UgG8GKDtPU6RkkYZiiNIl3qi5Tys2bYojqB3JloW41MrloSfqtcdTbIFrT/+Clxu9ECfcEaKT9n0x9nrUdG457h1Kjm4WwBlhofmHu+DJ/wTGpJ3HgTFSMIQ2fpJRkCX95qKuyispL1aPYiRHGUdXnSXiIXcK/OHsCw9cZsZ2j5z1GBb0veeyfSbO2JWAyKXMdfU/XUg5F0SLPJrfCKZJAxkBrnDPOCwv30iIqQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9ae813-83c8-4d9b-5ebc-08dee3292f68
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 10:58:36.2957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZPtFOjC18le5RMCNo44t9R/Ay1ZPsskA+uDCiJDKh8OIiYhNiAwMPaoA4Uww5+6UVaCPQiKBif9bPHaXtXrPRStW777K2UcJKYhczgetks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7922
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

On Thu, Jul 16, 2026 at 12:53:31PM +0200, Robin Jarry wrote:
> Fix the following warnings:
> 
> doc/api/meson.build:24: WARNING: Project targets '>= 0.57.2' but uses
> 	feature introduced in '0.60.0': install_tag arg in custom_target.
> doc/api/meson.build:71: WARNING: Project targets '>= 0.57.2' but uses
> 	feature introduced in '0.60.0': install_tag arg in custom_target.
> doc/api/meson.build:86: WARNING: Project targets '>= 0.57.2' but uses
> 	feature introduced in '0.60.0': install_tag arg in custom_target.
> doc/guides/meson.build:16: WARNING: Project targets '>= 0.57.2' but uses
> 	feature introduced in '0.60.0': install_tag arg in custom_target.
> 
> Run the CI with --fatal-meson-warnings to ensure future warnings get
> detected.
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
> 
> Notes:
>     NB: it would probably be nice to run builds with the latest meson release too.
>
@See
https://patches.dpdk.org/project/dpdk/patch/20251205121301.3443561-1-bruce.richardson@intel.com/

/Bruce 
