Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CA0606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PLzEY743
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 834A540264;
	Thu, 22 Oct 2026 13:50:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id D963F4003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 13:50:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792669817; x=1824205817;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=LRIhkFMO7hkYC0Ybu/nlF8Qk8R6Gg+i33yT+IyjLRak=;
 b=PLzEY743/RM/qDV0ypspR8OhPNoVOsR1pjH84Rbjdt5osCzYC0Xx3VG2
 sNepRwuIc5zGGY7BbCzIBvQO7RWQSUMxv2AFLN4TWtIbdFBdKO29s8kB9
 NJUZeiUuUX1x+WdDti99hcViaom4xgW7VPQ2Ing0PSeX3BTPcgCyPyBWk
 mnJORngfsUYlHQuwBYPxaiVuRmx6l6GGts2JMBaK9ibQ8RXe/ahau50E2
 SdT42T7/Mw5aF9DgucnY1T/0LTKYqpch35x7hjEtLivG3gKy8HvIcEZHT
 5tazdARooLz7SFcW4BbbhUichXwAH6r04X9J2LU2j2Oe6DZ+6eHjKNUlZ w==;
X-CSE-ConnectionGUID: XPPzaCDiTr6bKJNOfUxe/Q==
X-CSE-MsgGUID: e4eqOci7SA27skTALNoqrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1448930"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1448930"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 04:50:12 -0700
X-CSE-ConnectionGUID: /TWfphL+TjGUpqXNYFsEMA==
X-CSE-MsgGUID: 0qJWfUVfQye86uSz5bb4gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3266010"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 04:50:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 04:50:11 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 04:50:11 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.52)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 04:50:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZJBiSKy6eA66guwhosZnZVJTYWvyx7glXMlKCoB/P2e//mOMkZSQJ2zqptUQeCPLSSTe72F8GNdZz6gCB+bS94tsXajxRyXZcFVngEofhomZQpjbUkbUPAhT/andr9PDbPx0YLdMi/MZtTrqEIQNXSOLGQUAqddAssVihjkb3PnaWjSAAK8s0KohSG420KxtxKhxv34tWbH9yzZfAK/5C5oxbjTTXMjZt5QGo/TXUKVTCbd8QgH6byVeFb2wgVnNUJCveE+H2y/UGLRcyMK8FeaSmscrlO2PJ3/E8VznR3rkJPWjg5Gh5dwMh4ght7r8KA1CmiuKVKdtXPUkqY90w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cvVZo7lhqfG8Y+ZM8mqS0D9nqrBnNqr+6tEkonq/uk=;
 b=VsXf/Glo6HeAXXlLzso37eUCuV0lnT97F5BlNhGGKoINZLkQpkLT3GJQMLH/NQErQrBFpuvOxGf1AYkeRydVqjDTT4A9e506P2Ar3QB+toqWgExdUn+wY71X1Pw0nSW1VtYbab0Ebg950B6ks3H4lW+YVGP6K7sk9PYdhrxABOF9D2I7bHOaPGtVDAtUrpntzw6nh8RQ2ix85xBftDMjM4/Rp948jP0BBgzoX/1qD64rCcGnR96gHmNJvCKHY6h/abRhNcoDY77fGuFIfjNYIHIZ+WWIznkYVj83SvkAkhhOnPK1JyqVcGvD/F9WpIJmCW1Ga462taAFnIUcYdjClg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SJ5PPF3A51834D3.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::821) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 11:50:09 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 11:50:08 +0000
Date: Thu, 22 Oct 2026 12:50:03 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 1/3] net/ice: remove unused flow handle from engines
Message-ID: <atn4a7x6iPRFgwhC@bricha3-mobl1.ger.corp.intel.com>
References: <869a70bf8e9bb8ce36de57ddb46ea2d44d7b9be9.1792577695.git.anatoly.burakov@intel.com>
 <3cbd41baf2db930276ce43893a787ea65770e1ff.1792579964.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3cbd41baf2db930276ce43893a787ea65770e1ff.1792579964.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0050.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::20) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SJ5PPF3A51834D3:EE_
X-MS-Office365-Filtering-Correlation-Id: ad03f212-34f9-437c-3544-08df30329f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|10067099003|261021121427099003|261021123027099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: P/IWh3rEsDQhEAWcbnbQxCrBpSspQ1XPFqKYu/HcgVfaglJw33BWkNZ0+rnzsJMHf/SvvKngBU+vUUHb+pAG/3v9fJm02P/i6eweZXSY1manfhi4E2XMh9EqYGsgJCR8gvI7jY6UuwdqmQxx5engNzC7JXismp4gW+B3r33omsnv4yGtqGuntHbzWqJBakhjkWuf/n+F0//aImQxwlIuMIjwFebKSQkZQAud7PkGUvXd1u6ONPxG/A0LGCOCpYsFg7yI400TNSMv7CoXYj7FUhcdATBxEESX6mM5IHVNxL5BknI0sV+Ht54JPPYO5QQjJcLHJ/1DcD6wrPAvBqVLa1VVZ4Ehoo1B2iKXiX2FBeQew6R8MGajqYJ9U931b963uX/Nk3N0sAo/Z4S6genQr7SZ/IahDyZvASXYJWlAjdZO6FWE4wBIi9jJunjHM3mXUA9V5MwwnDwBYNKuo2GzBJ2MgCVziJ+SpHPkujEYGcFNlYQVG4JKB/8Y+AA99kA0D/laM0NGKIM8FpIa+U2EfQi1vP264Y/9CuZhTPaCC9UQu7ANP11JSxZemIAnIwQFuGoCFDXaxduhU/BIyKEvQ1pcDpy3rGVVxBOzkBJZQA1t2SC1bMvG0qN1SV7Km/SOoFGqPvSsjrdMLLXg3kFvYPN0lSwoOMd9hrTm+t9aqBg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(261021121427099003)(261021123027099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gNojbqJltYX9EPFR5zlYta+34Ng8Bd9BB6ZD+BGIUmN/Hz6iZQ0MJHJ/vclz?=
 =?us-ascii?Q?XqCPV+fEXErANbu2SdUt5Hj2EKXkKo14rRbzXE9ImipTKnYRS+HZRgjccgZ1?=
 =?us-ascii?Q?bDrs8UROVWh1hIehzIjpNOo9jfOq7JDcApQkF+g5wLJn5idZCOV5awzh2p+8?=
 =?us-ascii?Q?6fqVvjLrGr6s7vg0bOQkG1ymk2iyqaMV6o5ObUtK+6AowAPZUNNDc+JCgTF0?=
 =?us-ascii?Q?r1boQteYlPHgWuW7sYMiUfRGHs1EXAknKm9JyhxrTMOefh5VPByCHyZwVdN2?=
 =?us-ascii?Q?J2lAPbq62Pb76KVVHPUHYhNND3bRRiIqpDAEMZkwanUXCvpXalXK2SRdAe69?=
 =?us-ascii?Q?4VFCwVdPNtRnewiEkMg1Lbpc1ZjBCVOMrJ9TpUtx869PlK8pvNqE+zOM/DrP?=
 =?us-ascii?Q?SVwOyu52SzDoqYfcUHibJz7PoAGVMiZ9y0XogpuUa6JmDOo1WTFGNO+UP8mg?=
 =?us-ascii?Q?07zZT/WdXY5hRyfa58Vdw6ZIa54bk5T2Uvl+Q2Abl86+eMn6nVoNeOuw2Mi8?=
 =?us-ascii?Q?spHHXXbyICiFnx71RJRiVdGPun/1C3g4LKbc8Yp6mDoRtqd0xkMjrHbZS5GH?=
 =?us-ascii?Q?jotS15M4KkPioXaV06u/049eKCErsnZ+6LcUDQb/n/oGpR1QWfO6kIGPBAu2?=
 =?us-ascii?Q?gVYIn4sxB3oTgwtwLNMPt8JYKzTjrsvDSo2GxUVQZhMrRaWai+3/rdzw+IqN?=
 =?us-ascii?Q?dh+VGVNMtNDTl1/IkkMdrtW9pE+CNtwmLhyHcX8wKz+gSnWe+Clf1qs6G+XT?=
 =?us-ascii?Q?8gfYpiRoKl/y/Kb++dbRm4TdezxxMmXoh67HHRqbCSxsSzfmooSmkHCBebn8?=
 =?us-ascii?Q?1PCwrdOSIm+3QQ7QFK1B2062VJTOD5xxs39iciKnUGG3eSab1Y0MV1HXOXS7?=
 =?us-ascii?Q?WIBPJjaadiRJqJ9uUhlHDZGvyYRNibiYgsj7xNZHnBj41niw1HTtRvcBB+EG?=
 =?us-ascii?Q?YzJRH//M6kjxLmg80y6ude2s+zF8X2D/pmTqdl77Dcy5uokSgEwZsTOBNpRx?=
 =?us-ascii?Q?pr+rJAAcpiT1MkZTIt8jqXfy7DvsdhU9KmzpKphKk1vo1WORwnQzOKXpG71S?=
 =?us-ascii?Q?92hzGxv6FYQS6DanNZQnwwxraW8EF0g863+FNEDKFkNxoNV9ZVvO35QoA+2u?=
 =?us-ascii?Q?MhlR01P+VqGYxMyot0DgIKDsFAyiDVdbRDes5m6osRDjic7UR/goMmugXyrf?=
 =?us-ascii?Q?RDtbbwx/QPdt2GAt/fbcEzpufEFRlP44ssuQ1HIcbAzhrEm7yHBeataGi/rY?=
 =?us-ascii?Q?4tUorAWx/gAzHUZSrwMynuMNhHXHSyAXARJK7EDYWMgr6Yw0zIPedfFk2Y0U?=
 =?us-ascii?Q?k1s2dmWWJjy9R1fDLtczNiYXw9ikKgQ6sbFK36Xh3808DjfkvTNQ+wgX/jfG?=
 =?us-ascii?Q?vZXNlwmBWbzIxhiOMHnzEdnm3KLTXk/gR1RT3vMm7UbsrClJTzEq7SmPV/Ue?=
 =?us-ascii?Q?Uc9xgXIL9cocMtDq6AHIDtUjZU0qrzn2g72Oom6w9sCqAn+BS8g0t2MB3weU?=
 =?us-ascii?Q?7jq//TRn4gps0siOh3ExKmSo1Lm9pSXq1Gk1i/kjeO8pW4XtGBklYhIga5V7?=
 =?us-ascii?Q?CG82EQJOowpLkRNaoOM1B5+TU7Wtl5/MZYIINa+RQfWiukPwnJhJlnrOXyj2?=
 =?us-ascii?Q?eNizCdzC6LZcB1qW1X+dHfg0HLFYWbyYNdT0PMXQmFwPRpsqO6UDNBLX9+El?=
 =?us-ascii?Q?24X3p6x49nd4xtD1Vzg22lk5cK4YIH9+Kz3PspzTgte7kynERGrgrq4uPBSt?=
 =?us-ascii?Q?J9vw9Xw4seqK/g+7uqTp5as8qzvu3l0=3D?=
X-Exchange-RoutingPolicyChecked: RLK+0oghwGQZ3JU/PHJJBoRHvQoqMoMuMEwjDVU7QQNfJJezIvwCI2lDw8d/9Cvum+0VpHjV1VaTvi/rlZl6KIkIW6hnpwbW6XL1yRbxDr7P/hZ80BK9oE5uq6QElFTf/REczrbn/E3ZD6lN/+khbRAJq69D4FJiUCCPhNtk9TD6tKtXWYbdbV4obgXAtpEKt4NplNSPMPBlys7IaTXS6bM9H8vE/svE8qehniXq6zwszH+buXbgvpPeF5+UzbuNu7+yv/rOjGu6XeRIJOiw1GzF7IeYXTVM+Cfc97L1OnSizHVLSKxrIoagn4j2Znf/xcCibhaRep1SqoeBpFvTuw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ad03f212-34f9-437c-3544-08df30329f12
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 11:50:08.7458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLe3mI0fNeCNAVgbJyrvLshwtyZZI3wIdhE5KJjSdzV23wkmnFi+UeW49UyJDuAMNraY8H9O78EiNgFvcyf1jJMJQ83YXgmWJXdlFR8cFdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3A51834D3
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

On Wed, Oct 21, 2026 at 11:52:48AM +0100, Anatoly Burakov wrote:
> The generic flow layer now assigns the parsed rule to `flow->rule`
> after successful creation. Engine create callbacks no longer use the
> flow handle, and all four implementations mark it as unused.
> 
> Remove the parameter from the callback type, declarations,
> implementations and generic invocation.
> 
> Suggested-by: Bruce Richardson <bruce.richardson@intel.com>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/ice/ice_acl_filter.c    | 1 -
>  drivers/net/intel/ice/ice_fdir_filter.c   | 1 -
>  drivers/net/intel/ice/ice_generic_flow.c  | 2 +-
>  drivers/net/intel/ice/ice_generic_flow.h  | 1 -
>  drivers/net/intel/ice/ice_hash.c          | 2 --
>  drivers/net/intel/ice/ice_switch_filter.c | 1 -
>  6 files changed, 1 insertion(+), 7 deletions(-)
> 
Patch series applied to dpdk-next-net-intel.
Thanks,
/Bruce
