Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE389CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 11:42:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 316C040430;
	Tue,  4 Nov 2025 12:42:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 5E00A40285
 for <dev@dpdk.org>; Tue,  4 Nov 2025 12:42:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762256554; x=1793792554;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TA9LKwDJ/q8TcPgFFErGIqUBA1IZy+eKNTLWAsv4SqA=;
 b=ZNFx8rlu1QD0Lakmbz5ctbEsbVhCtCBO5y48rOI6qYj+WUiDHWweUsgv
 l9XdZnkW6DnnCjo1B0/5E69E6BMMZe6bkjQwV9D+bJsTf3iN5iAIv/+N7
 8qxLukeyfCf4saL4UFWL/GPJ2tVGEupHvD7iPlYcRqGk8LV1TEcSkFs1Z
 SqAc7b0AxeifCGmE3sSwbcZy2F7EFPhMvHgShquyBdwknHzF85zkziwaa
 GHZVGl/qWsDoKGF1bhFsd/29SM4GFMa23DREfSJ2hr/dFEmFn2ATOAEAb
 Ph0zKnp5blf7mZs0HqDUNA7jlHHyM97h+NuVRUz5GEncf3DWJej9nEGPW Q==;
X-CSE-ConnectionGUID: g+dMHlbxS6GOOwGuz9Xm/A==
X-CSE-MsgGUID: Lzm2dMn9T52MUF+4GIvFRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="51919652"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="51919652"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 03:42:33 -0800
X-CSE-ConnectionGUID: VP3FinY0Rs2m7HFdD3Kkxw==
X-CSE-MsgGUID: Gd5rFLxxTzGBegHUhn0yOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="210642475"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 03:42:33 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 03:42:32 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 03:42:32 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.60) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 03:42:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZOfpW2r2jrzvqSKihBXx83mQMPLO6eSWXaf0Rtxt+MtkMYP8/PgYds1/gVGhl+mlA5oWYRnDp7n3gfVe++aNQWEWaocl/0ytWDbxc7K63crEhoTiypw9Ii0fgfqza31YGnsPtPmLCxw4WPqwpeGXDf8+AIK30dODBjFcq02M9d1Zs0tsggcPsJkvwttPf83IfQRThprkX7EZsjbTRv70mdoLezjP2y9Zn9HLLbtkPGfFKIK3V0AAYDbLKvyg7oau7D7HqQYR87J3C/nIb85A+ciYvT1npyGhA7wLiwD2gE11BrTSx81jFv88vD73sjeZrHvtrqi9VzO9dmZ1Mf5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeZj9h2adWXLB4Ea+kKnRs+dGuRnz8MJIbryEjhYipw=;
 b=LtZ4SjhtzZsg8AebNSyc9965/JCAbNBjDgm9O2quUsBpb/InmPq/7dnrbQFjtLeRWB25dj6Kn4Q9VA7YixhwSTsG3nTwZD9C06g3dKmVuFDw3ioziaw1XZioeEd5Fq2CvBRMUX3enPagNnOAN/Rv4FPcDa6n4bauzgvlSB36uaYZbEcyLNAtRFZdOkrypAyH0v94iSz62vnxDae4vYpEPiS0aa0MepWrI3z2yphe0WhcxtsU317c0zF7XtOsadBhGtnm2eAbXijdq5LtstMY9OBS4lqnsIzoRzWK6N7E3ILcdaNzOpI9rVKA6BkfK1KaBRmOKla4tyBLp1GqbSqxjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB8861.namprd11.prod.outlook.com (2603:10b6:208:59a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 11:42:29 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 11:42:29 +0000
Date: Tue, 4 Nov 2025 11:42:24 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH] net/ixgbe: add E610 NIC speed support
Message-ID: <aQnmoDL8fomj-ggg@bricha3-mobl1.ger.corp.intel.com>
References: <20251103133804.585506-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251103133804.585506-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZPR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: b1191963-bd15-4027-c14f-08de1b973c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AyLZur8ng0tIy6koa0sq+ixu9clLhB3YFck0sUUuNWNwuu2bmG85CB+S9TpR?=
 =?us-ascii?Q?jRdVq8GbYWDyEvJIHZUZUYKqSWNz9gmRw9ktoCFQP/290vDIk6MNlIYDEVOc?=
 =?us-ascii?Q?zhe6bQJfT8PscgXgC9WOMy7zS6/cWMSLhKlyp7No2yEbomAeDZawz/8T+ZIF?=
 =?us-ascii?Q?ZHBtmwIUlGFi6yVGYr6Unwe47mPhESUG0w+8bBGuqQLUYrRsVsj9dDQwCyx6?=
 =?us-ascii?Q?HFvAwqZg9p7Uc//2RCQYr7kFhPu76jYA1lGP26SyXEuaNgaVS1FmRaLDJuhN?=
 =?us-ascii?Q?oEJUp+gkhsegXmcfI2SxJTzRM3SqXtffqeeiEBMfxAKw91TAMV+0OxK5cClG?=
 =?us-ascii?Q?iiPz4vdGX6lXx6Kfy/A52vzFU3YwmdnU7sn4QBuNXmN0KtiI3No0jCvFzA6Q?=
 =?us-ascii?Q?8wU1UclHv1gJdD2YDSTtyLT+YyD6drB7+yPQB0BqhuZpVwO1IWOaP9RI420K?=
 =?us-ascii?Q?BsbNdLCChH0/DCvVrm1NOfY9AQqwkFNTrTxX074uXvlmUkr5fI9ahCjeQm3h?=
 =?us-ascii?Q?hHatad3su/43BTG9a42CKgwRgl9kLNICSChjPn8SveFPvD0qKiGfX2hPdDmR?=
 =?us-ascii?Q?qK13fvmyq49DtdBSXeCmCJHkrO1aPXZVXT4xMZaVEOaKh6cuYLy7s/QBAucl?=
 =?us-ascii?Q?Hsg3bqAehHfz3aT0a/Pda3s47TL/iIS953fEjv2x1ycudoKa/aYd/2MWpTPD?=
 =?us-ascii?Q?nIamtNvCMKQgd2MVJ8TsouwZ/zLVMyba5HfEhmx8ae4P0QXmjc3CQlxbDSPM?=
 =?us-ascii?Q?wUUvbCR/IinT/SpGba92P+TAStJMB7ffxRFUQp26csWy230Ti5Gsz9oIUFy4?=
 =?us-ascii?Q?R5Su+7nz3P5r4KNoG+YoOkcMP64t4c3QDkehRGWWtuVJg251r41wX91WN0Jf?=
 =?us-ascii?Q?p7QI58bS1gQ8Xya+cHnzuC0+kh9mkVHeYraYgga7NWwSyDhvCusXzfn49juy?=
 =?us-ascii?Q?he8LpvJPd8AbIMe58W+JU6kFqewsxGiRhdFOcoUuPJh700QIQeJf4p8jSeEO?=
 =?us-ascii?Q?7q7v5Fqwm9Oi66uKZKOGQcYExcsZf8ZpSNguD48bm9Ez9Ym+55I6vYKd7RN5?=
 =?us-ascii?Q?roqH14TWw2WTtRTOSPQRoGmVxXW1Pcb1EAMXEfVfE0Pz+aW5hKQYmbKXqXtv?=
 =?us-ascii?Q?34LvJEpdvwzO1pjwMsjdWlDdgZPAQWKo1VAfbNUucSBViN3VOm52obWxrEaA?=
 =?us-ascii?Q?/F4Ae3LG4k0C9bIffDQ7Ce997UG7UFndPxrF1o0nfkwwEwIOg/Qfx9hscklZ?=
 =?us-ascii?Q?c6EGqw9Oygxf753FdCN0SXoS5JVELdpj3ePhz4eQTknNbTm2cc+dZDNhDY3h?=
 =?us-ascii?Q?iK8axkSf79xBOZYY6h983FmELiEa5wY4T/MQJstAKO7PRC5yU5e7KO3mEq1w?=
 =?us-ascii?Q?Vxitw0ZVFFRUlHYlhwky26Qdg1ikrjHACvqDKT2r38ho+BauU4lwv+WhX5N/?=
 =?us-ascii?Q?MzxTJFZk1++Wdyzou6a+5iMLEGCBktkW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PsHGTg3ommvopFAeUwviluakgdCKyhf/OHTrOwn9NFRD2iY7QbIWa3w7bhTC?=
 =?us-ascii?Q?5J2Pnd1TgLV9/ITJsdlcZZdg7/N45gYahdqkYZPi3vJAMofJ9hF7ah2GhAQv?=
 =?us-ascii?Q?K9lmWK8IUQGIT9pXSChNq0Mk6++SwIxv7tmQDBmgjjMJYKcvRNXjaiRrnbBe?=
 =?us-ascii?Q?dNNCJHow4pQbquO0RQPK9mayAnQ++aPYO+R8FB/eqlA33HTBNqAlgf8ADFy/?=
 =?us-ascii?Q?Lm2uC6qoaVsu0Tz99yqkn+ata5lzlss01Z22BFTpWXLoHlx8AnkV1k4KCIbx?=
 =?us-ascii?Q?YG4O9EumZdz9/VeGP03xkXcdYEYJ9f8jQREoq7rV/7hXPgEcyZWvRG/6ruFc?=
 =?us-ascii?Q?nsvWL8sh3R03K77FPUOU6H0eudTS6a34F+ihHZriF6UFFh9udl4+QCE5wKjF?=
 =?us-ascii?Q?VyGPteC1GqKRUTjbO6Ff0t2G8FKRDVK/D1Wf+2KoBbzfuv3mCjclkDdkQrZh?=
 =?us-ascii?Q?n8BH/K9sLwwcBj5zC+k7qi0tz/TFZBmWpGwMBzvZUvEwkynk1CdaBdXHwBbr?=
 =?us-ascii?Q?S5cnaq9YWCMEgZOK/0t+0biu29fjNWTWryqYB+xRooBLns1lb4y0FDMnZhaD?=
 =?us-ascii?Q?HlKr/NKVdoiGNNjvXJymCcQv4d2s3JfeXFgB1i/evaNsHIk61AMBacNl/aEw?=
 =?us-ascii?Q?h4eQ9jpnBkJVq/cvs44tHjV7CT438NEVWFwL/oBwYpDo8L7Pbv54GhVa+CG1?=
 =?us-ascii?Q?YqbhHISEMjCIZRv1Pr39UMubR2nGEsOXmcg6O4LJNF50kMRCyxBuPoEnLtv7?=
 =?us-ascii?Q?8iWo1nN1+WfJU1eM3gXfjNjahs5oZB3J6PaJCdWds0p2NTg81yF83km+MHzk?=
 =?us-ascii?Q?kZLolR9gQB6FYdkyWMoarvOsDzjDKEGUBooYWL4kYjFw5Z1YD9fGvmMTT9HI?=
 =?us-ascii?Q?3PFTME4JBFwPU7XcWdt2pu8CQivc01wx71v4K0902uJwZOgP85nblGfU+yAE?=
 =?us-ascii?Q?0REYxw4IS45mWh3kotUlGo0g6fOPjOXu8L+GLVcVTgSBh+1CEa7H626t3jhG?=
 =?us-ascii?Q?Pi7CYvccVe57FJlNj0ylWFweXpXc2UXQX5xuVc21Q/GGfylScpv51znLlO4p?=
 =?us-ascii?Q?T57fttJtmL6uXZqT9Ub+MoqIAmtPnKfrS+k2ziutYBKaRMG0djaJbWyAHLIf?=
 =?us-ascii?Q?V4zyuxEx8hG//jkVcxC0bjoTkRnSKn6qSTPlnz5Q7PfprSKFOQ4AUkGW4NrQ?=
 =?us-ascii?Q?lILlrivAC/L4FwJG1Ur9f72bE+4Pnd7Jur5Nh9BLlxlzA/f6QoCEmRBCH+r6?=
 =?us-ascii?Q?QHlLE9bzchJkbXVIuw+eo26DJlHsgP5YTCLzHE3CHuPLbo6k96qlHzJQSa2U?=
 =?us-ascii?Q?7tKQpsK0z4EnQm3YOtIBPntvRH62KVvD/oMCsIqiB6IAQtMjynBF7aqOMa8T?=
 =?us-ascii?Q?XYEVxWbLusZtumhJXSnsnewMymL0Qkht0+JtnD/P3aCYGihOaPePX4XOBYCZ?=
 =?us-ascii?Q?6ehLJ6AEYnpUn3UQeqQUyPduRAwZrNqnBbuDQpOd3qWtOhdAJRCgZiYi7Nkg?=
 =?us-ascii?Q?NeuFZ7j9HFo5tCmlo82xy4smElnggIzomHK2edFa14aqR+bVM0cCpyfiCRhT?=
 =?us-ascii?Q?PwiXbf4E14SWq5xkmgMonDqnyECiy4AjQEd9VvVhayDd662Xe9ifwv0tY9mj?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1191963-bd15-4027-c14f-08de1b973c06
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 11:42:29.5482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfj8UK2TtpCVABLoqvelYaoqlM0RDieepPu5vLzjjOeOVNAGNq/lUui2+5sTCwcgN5QtNJO5FCrSFPy4ct4LBDUiDNsX7npAWHEsAjz9Nl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8861
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

On Mon, Nov 03, 2025 at 07:08:04PM +0530, Shaiq Wani wrote:
> Added a switch case for the E610 NIC adapter to set all supported link
> speeds (10M, 100M, 1G, 2.5G, 5G, 10G) in the ixgbe driver.
> Previously, E610 was not explicitly handled.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>
