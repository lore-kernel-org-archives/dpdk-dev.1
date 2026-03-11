Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE831125856
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 17:24:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EA5E40A76;
	Wed, 11 Mar 2026 18:24:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id C1D144060A;
 Wed, 11 Mar 2026 18:24:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773249880; x=1804785880;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=hG8uQqVDnDxh/LF2dRdTjqBY/0n20T8OELHLqkzJ4EY=;
 b=HqmYGkMN7RqYfMU/H9oelVT4cbqrkui+iY6gU0SIu6OQP8e9O8B8n4td
 0XWHDJvSH4q2jVz60/bn0c3LPMeojhMlS65IUxpny954GdWb6tNGp+QV4
 8YUw9wHupiMlfZ7YER4R2JIkXHzE7pt9F/gKbRT7EkdfkCoxrCX7u+WhR
 wOwe5yKrYTyvvnWVF4p1NmzhR8J57tOhUEBCdPWR76MzTNZtD3+NXwXQc
 7rqC8bdCPZw5WAFM3IV68K0Gv9Rau88fFmc0r5W97+UdxTWYAjUV5ET9a
 7dk6MLrlet7mPoaTbo8ZPur8yaZiRDRJES1qMWqF8gJ8SHDmkVHrVLoB9 A==;
X-CSE-ConnectionGUID: jh0KxaMPTwCyrQaRpvcuVw==
X-CSE-MsgGUID: 8mEyIu6ZTcmYcvBo+b3GOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74409090"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="74409090"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 10:24:38 -0700
X-CSE-ConnectionGUID: k8EyUKv+TI6pOJAzYrJ35g==
X-CSE-MsgGUID: nnOIaRqVTZO3uCjq275riw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="218406999"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 10:24:39 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 10:24:38 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 10:24:38 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 10:24:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnzSQjrqFj8roTtJqTHv+GJdbHTU0oGu2q93dwRC7TIWlblm4GK6jd7p/eBHgKYnU01xmp7K0h4NuWT/xiLU7+xLWdUwZ/p95lVzzNxBmGm00b5STO/qtU8Z/6koldvU7pHg1JuKzR1AJnBQi8JAtTw7MW9jiSmRexcazAhpmKxjdFOYTdQp1XoVB9f09koGsPPlkuicwdqNWYjic79aw12wGGjKCxplpBlbn4V/izas9ICRca44nC8gC2l7E+sJTkbkWxJqExQ1iocx+ilEpG3M/hmJKOBUxSe7BJlQngwsuJsg/Gc/3uqgpvR0o2jBj7qwe25XH6o6OnfuGxdGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOthsH4BRThbENUx2AUq3S3lUfo5qkJNfkhnQ+DfF80=;
 b=P0ceuOh+tM1OScVwdgnvqz9AKiFJAdZ4sUVQMkjhk8xcRspHODupmURymF1M7nT5pXaWwRh6IU6WIiGniYutASuoh5WOZt0MC2qSY0aILbUi7ezwsLwWZkxI2dhyKtixGHBxRV9Zd9BLc+mwCHFd5AUheWrQNGnZJxnbOg0bvrYDLcyKkfpq8EA8F06CR3G8GFM27dF8xi8YZFa3atwli/WG6DG/BzIbkCPZfi0d7h6Hbo7uW9v/iYAqR2n0ovPHwvc3rZFPbUUb4BY4aevPSVxGQQvXBClvCYgJj1+IL2wkRrqi6LksgdTJcqZYqM7mXR3FZJc44Ray1D0AfI93XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6663.namprd11.prod.outlook.com (2603:10b6:806:257::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 17:24:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 17:24:34 +0000
Date: Wed, 11 Mar 2026 17:24:30 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2] net/i40e: validate raw flow items before dereferencing
Message-ID: <abGlTpezjYrq_NNL@bricha3-mobl1.ger.corp.intel.com>
References: <20260309132802.3094565-1-ciara.loftus@intel.com>
 <20260309152919.3193943-1-ciara.loftus@intel.com>
 <abGIf-dWlkxYsrKi@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abGIf-dWlkxYsrKi@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 82681a04-e0c6-485b-ce4c-08de7f931064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: Qd86E+PiTTQ8/nuPmWiSXc/oiMQvavKeiPjueupKdbnfZxP1rrkIXfCMJU+TLGT3uQo8t2HwZKiYgA5hU/ykLqhIKmxdIS5ooGdt/aGJBjiwUyEphgrZ1od203YL91e+MeeGuLFIcmMm1iXiGwzirHEKmr8KAmii2y5JNc0Khx7HfNDYailuGMswczpzrU2pO0ILQiAqbJgAKq82Laoua/qZKpDNY5exZDVFdlwJFin1zJkxAYYDJVJlDt90/v6LwKoO2l8Rbx9h23TnLwbpv3PjKUIqCA5+x1D+yAqlvORA2cl0px1JqbCAQk1GR3yT5Te0oBQwt1u50qT/vFqn/5/As0LPMkm9jDKUpyXE+EcIjpV7CkpWM6bnU3LxE196ktTtriwVkpJweYk8DYmo9Pm+CXq3K6lD2r+UEvuBS7WCb9h5wvm/iPnWvmpd4rmf3Rk4FtiBW59HzY9eriHV7NFYI73VUQSn/aV7+EBzGHYhFOTLVmLzkzKXvV436qmceykAW3dj007hNKXvKQITWUA8FUiqTx5Ydi49Ah55yEuwbrBK8/GozjYkoCopyDorPN6eo1UuI3K158hDakUx5AlcJt386Uwa3DRCf0g6VOhtPwmQfUW5t/56uaczUNDNdH0szDt+c9iDZld1wmjn7iYTHMzUbWS5eBC2TaASWm1cE83cXqHXrmxns/7ppzRkh2ln8C8vHA2P3Eov/O4PBjt+AJMDw03+460AYo4IJyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZghS0LWDW4yxfMiz0UV0eEGox2O4qMzAHQa6y1EPtGvd6BdtGyUqUQ7KjuJY?=
 =?us-ascii?Q?VeDrsQ/E3lLLInC2bWO5Tkb7/PQ3+UAnUAUBDAH685tUBf0JFZwaYfNtbLMY?=
 =?us-ascii?Q?X5bvYV03luUhoxqIpiD+iWlW4+wzi7sy+ra9GVTHJQ9gqguQT1stFBt41aCP?=
 =?us-ascii?Q?47hz9HEkR+pYPlsInfkpLfc28QejzCpoFwclhv7OgFoutjX+/a+suA2aVzGx?=
 =?us-ascii?Q?42EMqpTc/bCW0l0Fq5qp9Xjcf4HVY9hytDezKeR0Oeqcm/mhc4f7TXP70egj?=
 =?us-ascii?Q?5b6mkrSmcIUb5gC2JOBSfdlh2THt+CxUpp9OW9hHKq+vAFiZ+vBwakHh8zYD?=
 =?us-ascii?Q?a8sTAEVuH3v6+0lsVTwB38+btlfs5hTkz0dx2CUbRxPQUdBKdMOSKTXcexDq?=
 =?us-ascii?Q?/m1mh/4sjUWigrq+1Wh2HxR8dLiP7u60PMNqxczjKVRIehTSTthahX9oyGft?=
 =?us-ascii?Q?/6xMIqZdX4y40P1inDuLyEJiLNuwjJCBib0ZpmUcBM0y6vLFZ409qlQsD/dl?=
 =?us-ascii?Q?LVwv/Fg8ESuE6JbetCGrxUewicJaa6bf8wQd6Xp8YlMJcs/hTg0uB8G0MfFx?=
 =?us-ascii?Q?67YANeL225tFwa6JBhVQzGDjfK3WbaGxJPZFs5GWJesIN3SVCpkHOI6hlheT?=
 =?us-ascii?Q?pBA5eN8mcqC6q6BAaAqdLKrQ8zFW59i4rPdSKkKocmxk8xADkoOQSznCRjgt?=
 =?us-ascii?Q?8uOxye8slhk+u0uYooIXaO9WjEjuWW+hS+bU8Z+0K1t2zFR7cYfljE6aBH0I?=
 =?us-ascii?Q?xQauY2F5CzjzwXa3s3Rw/OGMKoYRrYqX+7utpH5x+OanQ6c6QEftdd8W6aLF?=
 =?us-ascii?Q?a3UR7ileC31QUb/+YUNLtqoIOEPRAxBEsowVpJmxRG/eGHOXXVmrZ6a1ZgRf?=
 =?us-ascii?Q?7ZEcz4B/SGuVI0E6go7JthB7gsQPRLyB1oTaM/PLlpLNpCBct3mmqWnUbozV?=
 =?us-ascii?Q?fsfByxvpkngTzZACuphcqQ388ev9V+yLJW0NwVOi+l3N2SgNAV0CmHzThpHN?=
 =?us-ascii?Q?3PHRIbsH7h8BgENwPaJjAbglRuobCdamac04PU3KSgdVizxYCHkKaifsXZ5T?=
 =?us-ascii?Q?V3DW+bK4Pk4mRHxq8zWZAdU47Ihfoq4x8XpSebiTcZPSV9lpdEPIVKwc0nBJ?=
 =?us-ascii?Q?BDEnrMkYk4oTDhdIH30dyqiYsYX5yDtg7EbiomM0RD57IvseXqomImuDwriC?=
 =?us-ascii?Q?k6khha7pP1qHfVfGk3axdm3DFlMB/2goVzMO+xhjNRHO17sIzp53gUBxsEj3?=
 =?us-ascii?Q?ezvvisvabSUB2KdTrJRvvAQcHGxFcLAtkqVEB82He0+ReLmVTZrMI6B1Ynh1?=
 =?us-ascii?Q?s2c4SYG8Fiwm9Vs10nSXXnNf5ffNvjSLovGg5KyzQ6wlnnV/teamOYdKWY74?=
 =?us-ascii?Q?CvBhz1cqQtfH2aK1L0hj1SU1v/jpXBY9/q4WkcTkyxgtErkZpaP77STsgXF9?=
 =?us-ascii?Q?Ylj9VdWw0K1Gw8IXX+Zj8+rMzjguvGlx/54QcIGDl7Zu9NAWGPXXKBGmxtAo?=
 =?us-ascii?Q?X95PtEQJLDnE7sKaEbJQ/wOzHg8j1ue2xHDcms4Msgk6DJLn/afzaTFkWvui?=
 =?us-ascii?Q?qSyHDQbs75VrXUJ4KNha+M7yS7gqoC7qPTiSpC4beN0K4eS5hyFsnmRTfZia?=
 =?us-ascii?Q?OMB/TFc85gFk2WVVxCDf/dg76E6G9xMo4IGqrfIlroJ7YNOq4P7C/EkNfAl9?=
 =?us-ascii?Q?rFK7XAUj+FlTbNnH+ORX1r7Z6KDLDVGuz9mp2rcMuQ/R5c/bL5FBfwg66A0+?=
 =?us-ascii?Q?7Gz827DqXMKYJivu3OpPkMQfLhaFCSo=3D?=
X-Exchange-RoutingPolicyChecked: BGWIpcNozYGl7RDSEjgSDOzmDNjnV3NV+Sr5LnmCky9gjFikY71FCOepTcZ4D1H65jHZ+/c4o3zYuaXkhfM3NtpcYys5qGUaXFIJQz+ytbK/1kh4UYhEIuNI1GsjRf9ytfUzn1L1jMkkg4jDkGSYgdU1PlQkQwLe8M43S9s7iK1+ESogbgzCvvchuUvNxUrMmB9iWGMrQkKvxtWeEvm7r1OcBqCnzENti6nkc6I+rTYTljp/Xnza9F1QhnBj8y3mDb5l1Mry3/ytknUngPFtfPiJzk5IV/Fkbm0pq0+AL95ZGys6nlQdzm02bh92XHfdJjownpatp/+YXiJ7qjPcBg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 82681a04-e0c6-485b-ce4c-08de7f931064
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:24:34.6735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aW6TvrunJ5LbjayRpXRF4N/tgvkZXV2peUxh2JH5LAs2P/GwoXDUe49wQsuO4ip4mR+6nKy+tBaDPSJw1Hp01CS+DNtrN+OlHQO81wzLHXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6663
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

On Wed, Mar 11, 2026 at 03:21:35PM +0000, Bruce Richardson wrote:
> On Mon, Mar 09, 2026 at 03:29:19PM +0000, Ciara Loftus wrote:
> > When a RTE_FLOW_ITEM_TYPE_RAW item is used with a non-zero length,
> > the spec and mask pattern pointers are dereferenced unconditionally
> > in a loop, causing a segfault if either is NULL. Additionally, no
> > check is made that the spec and mask have equal lengths before
> > iterating, which could result in out-of-bounds access.
> > 
> > Add validation before the loop: reject the item if either pattern
> > pointer is NULL, or if the spec and mask lengths differ.
> > 
> > Bugzilla ID: 1155
> > Fixes: 6ced3dd72f5f ("net/i40e: support flexible payload parsing for FDIR")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> 
> Missed carrying-forward Anatoly's ack from v1:
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
