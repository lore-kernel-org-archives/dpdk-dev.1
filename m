Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95409606A330
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mf0jXreD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D4CD40151;
	Wed, 28 Oct 2026 11:07:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTPS id 84023400D7
 for <dev@dpdk.org>; Wed, 28 Oct 2026 11:07:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793182031; x=1824718031;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=K4OrVVUOlYRHaYt8IyL5jdfZ8kMmjP3uLJm/VJxroEA=;
 b=mf0jXreDQqpvUAcA416rDoRClfBXcQLX196u4QLWMO6Teepi0Te0P2OJ
 N1UgA6OBWovPXqp+2OBRoPYx0j7ZTBVpkSljNnfJB+65eXjhebsHnBxlA
 5bcwg+fMbdyzfRksHdHC1C8F/TncPa9NNT8tDEzGBUhDfyH1MO2MwzP2q
 4hvRNs75rUTaDyrHvsr9Mi3lsU5ciFK6W4iDdEIVk+OgqC+9cUq2YW+KC
 XFhTruGmBk0UN0MmxsG3mb+XvfuG8JkszP8wLEnT2+ahZsvqYk2gK+m4G
 BRGP6zKdlbULvMG/aIm6RreX2Ks1fNH1m8FTxNu8kgExg7hDI/KAkHwZo w==;
X-CSE-ConnectionGUID: 7eHvqF6pS5mM2wJ4eSVi1Q==
X-CSE-MsgGUID: Rhn81wTCSzS/JODnpODZEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1799833"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1799833"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 03:07:10 -0700
X-CSE-ConnectionGUID: /XLI6hlhRd+rGZC33kn5VA==
X-CSE-MsgGUID: Y+fpnvgySyK3LomJYTyY9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="6640306"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 03:07:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 03:07:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 03:07:08 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 03:07:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6wZlW3+9dDRoy7V4YoYzdGWbmDm9pebGuUccNaAeuf1aQW83obRTck7d706n66ZApRdhv6gMLUTHjvCPGRb+nArd3Zhi4Pp81vFWj9smB61PKzpuUsL9uVltimReCUQ+8/74n/CJEMm+RoJOboA7scY5PRNMFjreTEfxWRYS9uJU3y8gPyP/hNwZkwRyirSRUhFO7Ue06KkKHDVHr/8nwY2TZ/gjxMDMnOj73T4AZoATQCvLCE/jMORh50o+6kB9VaPacO89mOZAF827nI/2gcfvHe2UzTQTYOaSLzI5nw/Bq4Iaz22WBiOE7JRW2cZdzNirTAf4Pz4Jb5mLHEfLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SEazqTwqXOkKP5Pa3x/DM4oK8WvSXYEszCMLb5S+MM=;
 b=rrsDZXeEu3ddwtJc8zmecoen3YJlEkpgg72eoGzKj3LStR53VsG8fZBOsjx6kqHaD6KOhEQLdnJEllPW7kHz8T91mZxlLpoz+r+6j5Q0fSAPRnDRstNjrGg5pjWDBiMvK35vIv6C+WqJpep/mdeZMqP4tnS4o0/l0w/7NuqoSW9z0iwbU/W3BModGCpgRUP4nKuntScsrJz+wTOzrm7VuBzCQGD7N89Fc3vwCZ7QZpPsCkDI68aUCkwa4+MuqTdm5pXgYwQfBELtIbDggTo1XMmjMoYvyJqKy0vVc5ajCKW4Hix3wrWEeKs9ohKSGpMD7RdgU0WFHa8QB0vE5b2hRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MW3PR11MB4683.namprd11.prod.outlook.com (2603:10b6:303:5c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 10:06:54 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0546.016; Wed, 28 Oct 2026
 10:06:53 +0000
Date: Wed, 28 Oct 2026 10:06:48 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH] net/idpf: add 400G link speed support
Message-ID: <auHJOD4sgw80heCB@bricha3-mobl1.ger.corp.intel.com>
References: <20261028095132.1110128-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261028095132.1110128-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZPR01CA0328.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::13) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MW3PR11MB4683:EE_
X-MS-Office365-Filtering-Correlation-Id: 378df47c-3cfb-42a3-1049-08df34db311a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|56012099006|11063799006|261022105027099003|261021121427099003|261026140227099003|10067099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: POevBcpE6H+cFluKucO+CF+vWM4mk4A9HMp2vwVVqQxk+hk8o1GHHETLUi+24YfAqzfrAmGVE0/lfsK0WoDrDYD9XTLCMWPLgpyDb7+mUdoK6WWO6L8DeKW827geIWYZBtjjgM6IMdvbq339jk0foCSlNkid82ceUWNYDFq+txqIveIIZM7PHAp+IeI3tOUg6GN4PQN20k02Uxq4EvmgCcIplTuRLh96HMD3TwSNX03c9TXKbY8DuOYRInpzarpHIv9l/PgwS+EQh38WuFosatLx65BIJo9d/Qz7hGRtdyL1UZUlE74JgKb2b+Np4bhFxZlTueNJNtiigXryykfpvk7Rqk51TVsiQtgLc0jTmnP8XLLhQuYRRY58WRKauv+1TqxmQ2zajadTmxht2du0NdB8frPZQfcHdhndjhCGZtox0VNBLIjxslDMpYn4dk1ShzYuN9+Z1+LjsuQfeuIWmyLyv8AJMxDkstNMi/3fbV4LNo7IguZbG51w+oth/24gouaDOcSL5zoWz3flUyNe3ox9BWWaOlp4FVlhie9yuxIV1Z2lUKtmW8TXXDYtyvZ16swkpDapfOHx1S0IlMhKtO16hXtkHtLedT+PE+k5OGLxBvoRFtzpdNYWaiqGRz7qCkrk5izyCXoGUFnuayQQGrkpPJNoXP+puY+6QmIYNaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(261022105027099003)(261021121427099003)(261026140227099003)(10067099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5JWmCS4ASwqy7uXDx9YCEYP8mb0SXFymqsbWc4qTlijIzp26LR/54LXwqzi2?=
 =?us-ascii?Q?ZusX5sFS6M6DkQ5/LSlSJHKpxmTrdmBmssuczP2J20jFPfcUX4BQgNyLwy98?=
 =?us-ascii?Q?+oFxD4I83aTF+GhiWHc6gch+ToYOivmBAbgHOigTDjQlzDgGDePwl3zCKTqy?=
 =?us-ascii?Q?vpKTdlBkPfGmPOqFFTOjI0kSdr/IR289PvJgVIs/Mhg578VGygGBLXrl6WOx?=
 =?us-ascii?Q?3RvZS03XHvRbxIaiNx4biFselR+s/40h+E++EjDovmOkdVJ7TbqwnqbXLFlv?=
 =?us-ascii?Q?E5r/KoQV5fWS3DP6Z41MqxwLDCnISDgGNQg+Fk14ArYV3mwXlw0nncNshO90?=
 =?us-ascii?Q?3lKXYt1jb/BzhS1a2LdsjzENRWlszBTt95M88a3CSMyIGEzsZ35+8rh7OtDG?=
 =?us-ascii?Q?CLouKj5EKeBNFdmC328bn8VDSWrMGuDT2qX+052FwHJyrAG5CrXKyz0Xqv0k?=
 =?us-ascii?Q?0al5nWO0FPDQe0qzSNbiILdzf1WN50tdbCR25W3YJBZNy1hE9+r9hQPB/nnA?=
 =?us-ascii?Q?93xByxQHeOOJ+ZjMP8hqmpOqqL2EbHrp9DuV1/XRUGWjuJqsP+R9N6wnjr96?=
 =?us-ascii?Q?4wkh33UxcnAN0A0EId/CqTSZi95Y8i+aQwKQUYoEi4tR6pRK1aNUiJK7TmlC?=
 =?us-ascii?Q?5vO8He9yXSHMMxZeKJHM1YdNetWxbDAaAj+x3cER2qhB3Q4ASqC/LiskM97/?=
 =?us-ascii?Q?n3+ekF7SxzqRc8kKKC1KQ3KeMRZzf9kS7SNlkoG6GNw3+/xk/Z0jAYzEyeeR?=
 =?us-ascii?Q?p7rCgLuHmfUNNG5IKqTSXN3K2uC8gD1uHDSCyz8YIXMvohJCr1E0xmyO3e4O?=
 =?us-ascii?Q?y7dBOoy68AP/2sPyMhpwrTcwAqGxPUReMMleUuZv3oRFDJXrg5qNkMLXgoc3?=
 =?us-ascii?Q?/pkr3fbtr4uxEIaK1ADwELxkS6bVF4IfMASfBx9oq9O2vbXBrwF5oAFpE3d4?=
 =?us-ascii?Q?VDX2iTlTj7CHi84tzf13HbYQK4f+23hpdRv/AsAsaDbk8rRxjKQ8bDDLAo2n?=
 =?us-ascii?Q?Pj0/HmvNaB1QF2WiwuEDsO53zwpsN00cal2ZWJjVWcVPdL90tdK/jQ4/4xjL?=
 =?us-ascii?Q?q+zK95vxcwMDXYxVg9Zd7ta3EkdjKt4e5glghukkuig9OQNoNlhDZIceQDDT?=
 =?us-ascii?Q?Zrihb1b11G6PU2Ck11C8XrbSz/YOdKWxuGxu45pCmO5tYTKmjGzAxkWPgQba?=
 =?us-ascii?Q?P/9KiWmFHKebx/Cqf6tMZRRtDiRURsFz2GrYoyzSmfFfgsndaL9nTFm6iGYY?=
 =?us-ascii?Q?XBJ/QzPNmrA2qNSRmx4yjC/Snry86mQkaYrboPS3uqBrU/GMvxbS0S2UW7Uv?=
 =?us-ascii?Q?pjoK6K4u9ZZ5Y+rcmUfOpMw4bFd1DAL9oTNYMmHd90oXCuIMU84bCW8Nw1zV?=
 =?us-ascii?Q?j+itsn1LO/3EIPl9f63UFwRhn0yeD9aJrocITwhYxaFpYnBrU62anJDs+nU+?=
 =?us-ascii?Q?6AAEghCkOprjtxwL7nVWCZKHPfz6tkLxJ9BCHaioK4P6TXGnVodIv+BdWq3B?=
 =?us-ascii?Q?SoT+bthCxJSWQjBTIq/K7k8XI357pW/RmvjPtQp/Sot69dw0rs61O8oWvVL9?=
 =?us-ascii?Q?RbSMN8tXRrPYWVLpTBy5l+iIGkLyTvbH0Iyp4yR0ugwkFyi117V90BfSkarZ?=
 =?us-ascii?Q?PA4NSwFqwFMq9zxl5cmavpznUyMpfhDsfx/ZOc6bsQnkRQx69DvIEZx7xREh?=
 =?us-ascii?Q?Wl6ka1e73fugNe/v5OEKLJpzfAtWHtgV9pCxe6s1KAn1x2L57nLeucFxDLic?=
 =?us-ascii?Q?nd96We7Mn333iscwVR9uwwgPejY//nU=3D?=
X-Exchange-RoutingPolicyChecked: 5JInL39gGSyAS9IO/KPaFPFhAvIOoq6+G7rMOGEzJzvY9iDljFn6iwbfP9vxquZTe4/1u6cygB5vVc3CMqfhBd3sd5KtV5uJjD6UrWRnTRyzLYRWPMRdU9FErOJu40yfps9/FltRRML9UBYD4bdmsxli18EvHIR17dJ7MqjZmOoOS2+YZy6AKcVebCA4oQ7Cd7QcwIlXfFLhPTQ3am/Qz3HKU2MGmuoxZvKEuSwGnteHix6xic099A5lfIlwOVm3oigUpyHFkF/9dh6qg9IWCTfAQCyUJDPXjZzzFt0wP2JojcTNLYIpmByC7cSKnr57v5DSJjZb+W8DOC/423V9Jg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 378df47c-3cfb-42a3-1049-08df34db311a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 10:06:53.7140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCXlFTN/TnMihU+WcwXXzLpPQtrjKUcwUhg4gBx57t9n9kWFGxZVEUkSzu112Y5NufcoO3E/jC3DiBHbagMchW3gQOmAdMaTM8VY2YUWWlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4683
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 03:21:32PM +0530, Shaiq Wani wrote:
> The idpf PMD did not map the 400 Gbps link speed, so adapters
> operating at 400G reported their link speed as "Unknown": the speed
> value advertised by the device had no matching entry in
> idpf_supported_speeds[] and idpf_dev_link_update() fell back to
> RTE_ETH_SPEED_NUM_UNKNOWN.
> 
> Add RTE_ETH_SPEED_NUM_400G to idpf_supported_speeds[] so the driver
> reports the correct 400 Gbps link speed.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  drivers/net/intel/idpf/idpf_ethdev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
