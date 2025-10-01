Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5CFCCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 17:54:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A87C40677;
	Wed,  1 Oct 2025 19:54:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 65C44400D5
 for <dev@dpdk.org>; Wed,  1 Oct 2025 19:54:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759341245; x=1790877245;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Bslb9kzJR/vFQZSjgP6/1QzmOuT/EhUvtIzBaJixsTo=;
 b=mQRTpqKCBhLjnoIO7Wqq29oGU/5v9I2Y3Sel7XQIym5QLWU2IJ3VWSqy
 zidiYmKY1nivtGOv+q5KgJGz7+8B8BP6fzoK8uHRnQjgegJ83RjQYEMk0
 i9l9H3vI41P5qKrkYyEcWGybP3CzuoP8VLQvMBgnvZGTsc0h0vrpTCsug
 1HxGqD3MCUqGXP6MLA4J0ELGgnE2W42BBaydDZJOKWcrJZrtsi0zJGJj4
 g1TbfMVPWlgVlZJxvf3Z4VZHd+2uwrnLy/ZhgpwWjgIbp3TC1qjr/gNo7
 4LwkyfXnWWaUMAeEZA47hLSreM47/z6+91R9MxykL+lj3mj6yqQC9Kbz2 g==;
X-CSE-ConnectionGUID: ipreDV7kSW2mqX2XEuHCUg==
X-CSE-MsgGUID: kXiQlJEHTcC5gdKjTqilLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65446259"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="65446259"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 10:54:04 -0700
X-CSE-ConnectionGUID: 78lkD+EFR8uXrT6/wCH1uA==
X-CSE-MsgGUID: gnUQRWTWQHm4LwngmG9PLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; d="scan'208";a="177963039"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 10:54:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 10:54:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 1 Oct 2025 10:54:02 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 10:54:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMFBHrNEoNgofxMeEguREmdTdxOu8tBzn+ELS+7dk8UWvAVJGwOGsStABnZGjxUFpu6TVvJ+cyaLe+0vaz67nOlLh4DlFTuRq8Qxec21kxJE6ko8TQVTKY5Eh6WTTbKivoYoNqS32SfUb4QZm+BEbwcdrucGqHTvwldz0r3RPGc8EiTFB5OPDA9zu5UGx+T6se6Lz8frELQcmB/Kbie9rfzE6SSn/hkgFBk7gK9R+IMZv3rlLvZGd4CRrsPJCCY/N5/mhzABLLeZjwFIa0kwyfKYdZApiaYCoA9idJvCNRVz3n+uLWatB+eu31sTBFsBh9RzszwNdeXHEDxncJxvyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cvq2J/KleptlFYkZPxZP24cSUAZ4+f3363HtxxD/Uzw=;
 b=TUvF1Hs+IfcXUqnPIAJw/sXwRguN68dzbRe8UChW5uLgiHG7uEllMe0k+pFoLYlbbW0DMJ4wGlpTNMxcK5AvdgKCqu2qNZDf0hqJIjREzcr1nTs/6+mLY1wfZFjmzpyFqu2bfOvPKKZ+MRTAVbfFmaCYSqc6OhzKucZnag0gHcl75WSbIUW5+4p1bodaTSpgyqwA4g80VxgPdQ96zL1EJh2B/ziritwvKDJKlL43aH5376v3tru3ixLiuoej2S/OxtCPPOIdC1N6tIDDOoHo+0Yjc+v5STkyQxj+iV1AFaQBNFx5rhDn0YSSdfhwaiCx5U4atN1pWLVoenk/Hugkkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SJ0PR11MB4895.namprd11.prod.outlook.com (2603:10b6:a03:2de::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 17:54:00 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%6]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 17:54:00 +0000
Date: Wed, 1 Oct 2025 18:53:55 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v2 0/5] Update ICE base driver
Message-ID: <aN1qs8svHGv0T9u5@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1759231103.git.anatoly.burakov@intel.com>
 <cover.1759321681.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1759321681.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB7PR05CA0049.eurprd05.prod.outlook.com
 (2603:10a6:10:2e::26) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SJ0PR11MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: a3752379-7c7e-41e0-f1ab-08de01138043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RDMmqpeQyfRzNhT+3iuUuET6AwGaNqVGlDCapLT4eHcnc3W9OvFnqOeARruT?=
 =?us-ascii?Q?F77N1HJBktmfV9HcDu0rPYUGNkbxLroegLW73RW3plog0tJVOLJnaQ9us6/j?=
 =?us-ascii?Q?2H0rfgz7OENWJEbOlfxPsFCSTox7FAgpdxVui1KD8ElV/Auyhg+BGVja16LZ?=
 =?us-ascii?Q?iagSZqDz4Mc5bkkgHu5/9K418xwsnxk/rFe9Nu+wAnJbg2xZpCbSOaPxGAyq?=
 =?us-ascii?Q?HAwOfwZ1tuNxr3HOoRxgwDU3xiajqi+LuYRGAEN8bUMfUHV4+AS0yABi812E?=
 =?us-ascii?Q?8fiepuZMZV4XeSxfiKjsJceiiWnYhmugo759TvVc0aaThPOVgosXdaJLvi8y?=
 =?us-ascii?Q?6Ss0oCzxalIBl4+WXX3TOzqsmmTv6EuctLzuUjRVM4jzOXBPh2RWqCUB9zOm?=
 =?us-ascii?Q?VEK19MIKkl6/gTFqfWbvrLozsG0erFzPhf1ubHs0x3iJXhgffB5vv5kD3DQ0?=
 =?us-ascii?Q?8sE0RE8J/QPF9qf5nlOjges22mlx+hHkdU9LkiscUNNMXhyTB+SnwGDe9K7c?=
 =?us-ascii?Q?cX8NzaQAhvQDEZgak5kUATEHCS0VnS4VizWlKD3ZmrhLNXqNwZO/r15yiVv8?=
 =?us-ascii?Q?IreVPmLWzoFHxgwc05Uo5oC8eSzkBbveyOpxI2564tdYI9nCq3SlBGHE4M5q?=
 =?us-ascii?Q?tIiBnmYNI0EP+btR0+g5SFWGdfjMJFxQwwHy9OdB+hXUxDMxD9vCs6ZRZ5H0?=
 =?us-ascii?Q?VY+OVV/NN3feFEpKakse57ANGLshIZv8te7jo3rtAZFiM5UoW2AEmJauPy1S?=
 =?us-ascii?Q?aKlfo4Tm4iObWwO09DTtAD5m53cCY+wN+iRHMP5kdtu43ZQIWohYll11VXTx?=
 =?us-ascii?Q?Ch37TWMZaad+h89GMu1fS23NWCXhpfOrSZx+MF9Dzpvc9d0kfM5SKRXHTHnT?=
 =?us-ascii?Q?Ta0gMzXrWdRpVhpJdYtOCWWZT69aBxixOXWRJVcA9DtnwQszNuRy5HZSJGE8?=
 =?us-ascii?Q?kRTEMYNEJTF0eBV61nxlBnJur4xvZ3Az9vnN8z8TBCRyUPAD/GgI+9VeAQgf?=
 =?us-ascii?Q?e2EyAP6cUkOyt9grRgd/BXrZ8KsKjKngI6hZpwVQ7FUl3BeyR6aNOdxkX4MV?=
 =?us-ascii?Q?vl/4uYEXoxUsgzDzFBLgmOUucsYF8Lod1EbdBv12X2k0gnCn5+4Y7cduTUsJ?=
 =?us-ascii?Q?h2mRcZ8XVSQYMu0fexJeFSCaiUt7cwZ5vjzVEY74M4b2xFlolIoYSYGoog7P?=
 =?us-ascii?Q?zWv0A0FdGsm+KAISBIL1WNrJeC1LxnR1Ra7xkAR6nzf1wxZWyZMJ2Hkvsm+W?=
 =?us-ascii?Q?qJglXH4ZA5U0Ka5PXAB231/glvhcsF++sS32l1+l7wLOBAvrE6hhNw2ZbrXF?=
 =?us-ascii?Q?Fb67XA7I2ryPSjbg3jE1aZaxAguaPdRcnbBGKuG1/pTb2pVcRrT3OEIruhDe?=
 =?us-ascii?Q?pcRWOCBtkEkMCIczcEhEsleORMYj6Qv/fOa/7Cd54H3V50mkSQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uvlzuyQGZNnJPkC5uFpupu9bhulFA5OlqsKCP/eKrEDHKOoGnS2kO5AB9Tr6?=
 =?us-ascii?Q?5HzZY+v2eL4K1w8jnQbDyhWdrqSZN24HGueRGvcmQoYCXioHl2EEVIcWdMgX?=
 =?us-ascii?Q?/qRP1qUWBi67Y/7XLFdNeDWywlPsJIUsUte9Iuz8vTGqMKdeNSyvSCdnbLRo?=
 =?us-ascii?Q?kKVsWsy34S69xhTonAp8cPPWo8xy/GbQPy/Yvp9f05uxPawkj+xsiaoLaG1E?=
 =?us-ascii?Q?wOCkC6Ge39BcmHOgRumJbivi/qUJmUoPd7BlCGpzR3VDbYCYjqPXV4gK/w8P?=
 =?us-ascii?Q?iragz/7CiVE6cZEL4MUO5wKQZnH+sIGDLa2kMnBZ9q1m8y+053XVks/n4HI4?=
 =?us-ascii?Q?cuVfHbkQj2Xy0o9VeXY8vocr0UeJI6CL+U0KLrs5C3Wflrc1GtaVgV7WQ0+2?=
 =?us-ascii?Q?U0DNBHOX3jNtJGBS9CwP0tf8nIojO91HKUbHvWoMKzIGrHHZhCFbrS7eH/yX?=
 =?us-ascii?Q?isjR0Y7XJp569677EJaFwaCKPU8bzmZ5O4cWMX382Di16kZtrJABCnAFZqcS?=
 =?us-ascii?Q?caPMz9i5tSD6lnG7wHszvSsbndurlzcD6+yEYXzH6pXjvC+4rKrZfK/QogYi?=
 =?us-ascii?Q?6iZ9RFnE19xeJ68Ai58Q75o+q2GnF1vTtnqQ8QuekoHkfmLF/8VZVgzTOmLA?=
 =?us-ascii?Q?bW7hD77aUKD/6fYz/5e1Hdc/8SAKnCI+LD6tzerrmkqcZIpad4Nju16Zttub?=
 =?us-ascii?Q?I4Id+8Su7WiFRjh7U4Mbxj+3ItPqRHgF2E799j513IiiS/3lNDtxcWzfgrZf?=
 =?us-ascii?Q?puZ2OUQ/bJM2WkFGhVaFNJE11EGa9aZg/q0gD0ikuElNouhmXHPaW7FYnl0y?=
 =?us-ascii?Q?Vv6XO5/WW9JlKjYUNwqjZoZkLA4vx7JA1Ry5RZZqELGpUWrzKD23D3/4R0yH?=
 =?us-ascii?Q?kL/mu5zQxca2uVN9Me6upB7CKZe3ZNTXdKW5HptCs/OMeJ7Ln1cMHF9jTT0f?=
 =?us-ascii?Q?ZoPSHwpZmyAp/JAIUBspQU8wYs8Oklff0bnblCDGSGLBcgmdSBfYCrgr7KDV?=
 =?us-ascii?Q?8eia3sBstxsSPMdMp4aNMwfs6GhlIf6+bZWF+ZiO5l2RJ73NbEQk69SuCH99?=
 =?us-ascii?Q?DzKxrfLER9s3z/VFbx4GKFc2mNzUCO+9SVBovSurNe0TVOGdp3QmDgPl8j7O?=
 =?us-ascii?Q?K01x0ctEhOwAKGFa8q2BnhnxVwrYaza6HHxAdbOvJT9u2zo04Sdmc1z9UCG6?=
 =?us-ascii?Q?PQvjIR5wf5lc6I1+zvILGaOvzuQhO7hhbhKsS+gxkIoLUNo9c+tgNv5gSCtN?=
 =?us-ascii?Q?Nzen63TY5NBKH9rOEulnooLxSMKwv259qkeY2r+f1Nr4RXyatL93+n9g7X7z?=
 =?us-ascii?Q?05bNJIOOJgGgBCivvttMl4Y98ES8ut9JC5di8Xz/N5ychRfv2OJgGivmpeTT?=
 =?us-ascii?Q?CRaz2ZqsbAToPHGh8x/m1MuUzREEIP1TxD9nRDASoMTI+wYOxVM3wu/yKD6Z?=
 =?us-ascii?Q?F3kaZtpziA3QdGgXynRJL/iyxgEu8N0zyYTHPHmXLBatyvIp5Iy2irhfftaV?=
 =?us-ascii?Q?4u5cWn/XiCYWjEGQ3OvkyVkPArCFtc5ULJvxCgwVY1DGkv1IjuR9WbvMW8Em?=
 =?us-ascii?Q?f/cHYkpOR9Se44ZbpiyKW0S/9AJSTqZCNU1+JWXtH4VkeGG79Lmi3UaX9zNe?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3752379-7c7e-41e0-f1ab-08de01138043
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 17:54:00.2542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgHus5JBGyDEJ2oZd7G9dy7TaTT2xNiOWvmF4bN18VEG7Ok8dHhvQrsldLVioIqlvrtlxn+CZj26Ex3aed6FYUy8NA3aaJG4ltDxWOd3PgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4895
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

On Wed, Oct 01, 2025 at 01:29:03PM +0100, Anatoly Burakov wrote:
> A few more changes for the ICE base driver:
> 
> - Integer overflow fix
> - DCB/PFC changes that were submitted earlier by Vladimir [1]
> 
> The intent is to merge these as base driver changes, with
> successive work to be built on top.
> 
> v2:
> - Fix setting MAC config when no TC's were specified
> 
> [1] https://patches.dpdk.org/project/dpdk/cover/20250817130152.682972-1-vladimir.medvedkin@intel.com/
> 
> Anatoly Burakov (1):
>   net/ice/base: update README
> 
> Chinh Cao (1):
>   net/ice/base: fix integer overflow on NVM init
> 
> Vladimir Medvedkin (3):
>   net/ice/base: add utility functions
>   net/ice/base: make set MAC config TC aware
>   net/ice/base: add support for asymmetric PFC
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel,

Thanks,
/Bruce
