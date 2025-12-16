Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF8DD5E146
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Dec 2025 12:05:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFAED402AC;
	Tue, 16 Dec 2025 13:05:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 3E83D4026D
 for <dev@dpdk.org>; Tue, 16 Dec 2025 13:05:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765886751; x=1797422751;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=m+mVb3cWBxLGB1QS7hc2CBU9T0lAD+cy2uwKvXn4UUo=;
 b=hShciK+7X6RoC1mwc/uSBlC9sK2JMFC1tQHLt/1wfsQ2uslVa4tG16SM
 ryhzpPwFpQcj41mk8e1jHjKkKS3liVJOLT8/f1ufGc/XkfU2mQ3BgahRl
 xZ+Wz+29dHjwI07w67t8wR0kv8kdgxw4O7+btnIPtXWma1dfuCB1hR0Ca
 BwzH5PJd1AXhjXP6hXdaWtnCjBSGbumZla/4Nvpsdm3JVRzKBFQmoUeY0
 vC1/GZPkTM9tFUHM7vm0jWPgXMXqgXVQJaIuZxy+9nGGRIcu2jL13RAHt
 aLsVr0vKE6n0PunDLs6I8lko3MHI0dN9eQZG8+zGD//ZCabCvDIiwutYB w==;
X-CSE-ConnectionGUID: DvdevIY4TRWSV8mNP+PPaA==
X-CSE-MsgGUID: MBR8l4QKT5+zIM5oanBKiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67681668"
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; d="scan'208";a="67681668"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 04:05:50 -0800
X-CSE-ConnectionGUID: fvZIoDG5SHW54KFkUj+byg==
X-CSE-MsgGUID: CUJJspCjQXeJUBWk3BTWkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; d="scan'208";a="198479513"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 04:05:49 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 04:05:48 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 16 Dec 2025 04:05:48 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 04:05:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCGnS51aVKBZVlPdYKiIAcTPTT6I348WRwBt0QkGB0umTv3kCX+rwO0aUi8ki6+Yu/GP6HmWcMEstJye7MHJxYqYE+9g3mX9SCIciZ9dqKrcW0rOsU9ZSlTNdLv6SnKdRLiXR9Uw4JpYFS76CCO4phZu0u0d8XWdMypQCLV4dn4SaT8kxmsEsAFCuty1fX2Bz3jX5+SwVKHIqDuG3zSwZhwVmc+4TUURQWaddRIV8809jXSS9pKJ5Uu3CyvVJqstxTZQDMXEHFxkASz5ioIQHOzBqtNzTv7jDfxeKvahKhuWCSIj/tLmOH0AZqbQZNl3uwGh/OOUOhO4VRKt8KwAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdPO8wB2E1dnlO4u4pJhJYUXJZJIOwEbh82vxdqoSFY=;
 b=QBmzt/DRsFihRVwFaorf2YQMS4DMMg1sIHlNx0r+D/Z9kWoRQ7J25xV/3myKTsFQsj6qycrMdZ8Kw8jrZpWdomp71feizIeQRX0la09i5DsoT120oAEexSJdWNKCZ8h4O/y3XmqefnJ60cpAG4q8ZqpHix2d+KxMmeC96le2y+P1rWNDj4OgLg2h9IBTaRToAe2ClchNySXkhqvo0EF1n9WMGv5nH0OtifEj2lQbqXH9M+7hAGm18ZOkEgegsllYbrYLvX6bY1KcbOA7114+umZLWx8fZLvoriEee9QlRSQr3TZoMxAfT/HzxH0X6h3i2NKJ1naw/WmV5tdeUZiRkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW3PR11MB4572.namprd11.prod.outlook.com (2603:10b6:303:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 12:05:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 12:05:45 +0000
Date: Tue, 16 Dec 2025 12:05:39 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 1/3] net/intel: prevent selection of a null Tx burst
 function
Message-ID: <aUFLE8ccRaQ-Nyts@bricha3-mobl1.ger.corp.intel.com>
References: <20251215140553.2283531-1-ciara.loftus@intel.com>
 <20251216103504.2624535-1-ciara.loftus@intel.com>
 <20251216103504.2624535-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251216103504.2624535-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW3PR11MB4572:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d876e4c-89bb-43cb-59cf-08de3c9b70b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k2ygHqucvs9kpMiZr3V+5IaB1MakN3yjcRXghJ/j+jFySB4JHCfrubmIu2Bk?=
 =?us-ascii?Q?2hLbO8cUl5wdHPPm8IEUCQ2UvAR/akVC1bTToa3pfNWWhhV5195mzWfEo6P6?=
 =?us-ascii?Q?72dpbR15Xha7AIdK+NwuNMS5vJ1RY8d10rfSpsYpyGkoz0yxKlNBJEn/ERgx?=
 =?us-ascii?Q?q9/MkLucsFOnvJrlCtLKqrGviZ8nf1rU4ifFETw46/3mkT3Z8BIztTBqfjsE?=
 =?us-ascii?Q?mtapX6Y0bYDjNnxry1523uLkl30buipE9gAWFpMdm8YIsRhFASAkAo26AbLu?=
 =?us-ascii?Q?sy+qR6oI9GpfhLUy8FxHs7vFYq7nyvZYehbn4b830lg6n6eX6qTTsKXpO7SV?=
 =?us-ascii?Q?RKgyhv/lafwD+FjZqc+Dw8oOM4mnr/1XVRPWwDMZ66NEeTVivNdKkzXRIf9a?=
 =?us-ascii?Q?WqiuHmwhvLPnluPO0LW7GB/0UhGe0bUZBMpNwabIxQwGStVjQ3M+yb9E/Z01?=
 =?us-ascii?Q?MeE/YFlnieURcazYtGWEo+zAq28AWtHY00ibpiveK8sMrtP2IA2g9vNtFtbQ?=
 =?us-ascii?Q?FtVs26ZmCSozugHt6gGzHG5RxhuLRZjgqZx4S5kFPtJJOuQOKicqS3VZ3J/F?=
 =?us-ascii?Q?2x650HKJXaUULb9B+L7SqDWTuBpPpMTKYeILm+v/rTRzCmmnxBOX+wf+Bzpu?=
 =?us-ascii?Q?EmGDKyz1klrYnbwrXtFxkcEy5MVcVZomf2TNilOWazk5Gbwc3rC3CJS4gyeO?=
 =?us-ascii?Q?NqRW/Ylv6Oq53GHqJRyN95+kHYjxT3mlAWZXjxEqXe9cr8P3jQVCBGN/Y7CL?=
 =?us-ascii?Q?oDNCMfeOXbeZc7sbUYZRBFXyKYR6YZXzxXSivNwIvDrMycdkBnGo4GnMnUcb?=
 =?us-ascii?Q?E+0zbZC64yv/v5G2f90OzStQPXmH1Ky0qHTAxcOZ2bG5+VrS3CwTxh7vqs9t?=
 =?us-ascii?Q?0NNcB26bUW0oFQzvm1rwn+VE1NisKUUdgN/TyoY9PcROmg3VFvZJgkA8Pa2J?=
 =?us-ascii?Q?y1c3LNshEmchzO6ZFp6tWP4op2y7OTrgtQ5da9KLxa7tOSJxdVaCKL+vTk+r?=
 =?us-ascii?Q?t4yteGOvQVaMpPKazDeDZ/+3Tm8YwprRXkOVEFx+5S2twh8oyeT4PBnGVzst?=
 =?us-ascii?Q?DuQhYPEBui6Nu6VM5LSE8ovcvvBwvfeYFUlFZOUVbXaIXvfK9HxeHzt9R0VJ?=
 =?us-ascii?Q?OnUY3UH4ysKEq2fJrVc9jH/vODjcD0iT2y1hhM0y0oPLJdw6C+9y5tTvJWNe?=
 =?us-ascii?Q?TYrlP+FjetK1Ma1RR9uh6dDzOKQwPFFsiHVL2mN42+WmEFLl2B1I5RlF64Ea?=
 =?us-ascii?Q?j0zeHs7m/1z6BIK7yBeCKyuiwiA6QN/nRMix2QloAYDhNmq4J91FuEokAyRc?=
 =?us-ascii?Q?7m2YMUaqf1531bazKn0cM1bOCl+RYMBEHXsPJOYJby8iO/vBkdfefgWMSXZW?=
 =?us-ascii?Q?bEHw6wXd7JwFh/NJ5SZ1mYha3HcmzTLGFuKIoBhAolIaWH8GGwvjx8RN3ehN?=
 =?us-ascii?Q?n+wbeqs6jAGSH81r3Isq9KBpjrvIjNFv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/5goIGTe/nYMBdb4sd0tJEZTOt7gdHdn/qV8gbCmNsFRb1XjE5QKBlEjPa2Z?=
 =?us-ascii?Q?4+LKUYxuAvr4p2XvNP8pg3c/GtFg3M6vf83Pmt96pl/M9voNzo4HpHhL8yyY?=
 =?us-ascii?Q?rIL67TfgxIRu+w+jjAmtsm5WxOJbFn5gfZZ5GBgDMTzVJKXYUrgj4uC91gmf?=
 =?us-ascii?Q?6lVf+ffBMSNxVkTFc+KK4Csu/BxljDBe2rixZlq3B9MDGKVx22pB59a/mBjF?=
 =?us-ascii?Q?Rn0h+BNwghb8XivCYnwiW+7cEou77PGGcJjrPJIRyEynev9wBcH9D4h0a4mZ?=
 =?us-ascii?Q?oQnNn8q5A8JgtpuIF1bZ2/PYPM+G7rVlC/avTxEj76rd47fEUEFEQn1Im2T1?=
 =?us-ascii?Q?ml8JdqvmK5x3tifDE5acRXnxXvFN1+SSCbGLOJbnmmeSOcLDt6Up2IU5534y?=
 =?us-ascii?Q?v3qkBB1U6ZAsJ4Tr601yHsEm+qWLU1nrW/8oWvi+C8TOfy/Hkyttt4t/uecN?=
 =?us-ascii?Q?fJP2YLN4dIXeSGAaO70S6XlZJIZsKKYYo39K76ystFR/v6a0fdcUoJTEM4OW?=
 =?us-ascii?Q?0CF69HQaZi3N8zlOzjyljDsLyd7vT/ahl8gBANSx5VVpnpFl+2XUJlAAub0j?=
 =?us-ascii?Q?gQ34CD6hpXrabT+/FNjA4Yt08bLr03WrYvJrUcOqfsmUFtjCyD+zrsQFKhue?=
 =?us-ascii?Q?81oWcppJT9D1XGSvBNjUL46jBoB3n8Lh21PdMrrMCZcwHgKRxGsx42si4cCc?=
 =?us-ascii?Q?Gu8QmZbSbyFjGYi+aCfcRUAKh0JbIirl3pdhRgop+1/7tLA44c8r1S5tBboB?=
 =?us-ascii?Q?9eGMiUprnYV0SIKGW2PgWK/Wo20+D9l9Qlf71W2slnEcsG3M3pihy87vyXn3?=
 =?us-ascii?Q?tjOBsDKAvCiWu2btO45Sj6YUopsVHoOj/PHOX+CumBjCaoDdTtUmWZbHbmDB?=
 =?us-ascii?Q?PKvzfE+F2CH/rqVTenPA1GgViBE6+TfzFuRTlrIF1ITH7X7KlU4ZvymS6Yru?=
 =?us-ascii?Q?KiBi2VhIRqcvz8a2GXgFN+ellri3GcHf7+P8Zm0FkpVBpkBHIIkY3qLXvsTA?=
 =?us-ascii?Q?xwPozXPG0nP8+UXMG1z7kY5Vy/ZeWhBldt8peRwAwASEwmAeYPB9CHxbJA2G?=
 =?us-ascii?Q?thf4Qa7JSZ2GtNn8wfeN0pNtIEzvvNWNDZO8W+qS4HxLjQ0fDvfWAk+I+7Zt?=
 =?us-ascii?Q?nOIjaA/PSvnDbrDLAxl4W+eHoh6Z22iE0JjS0Y3UxPgXUdOR2vL0t6upkH8T?=
 =?us-ascii?Q?6XDWqy8dHZvr2Qs/S83F0DM2xpxND/eZOqJQm/4HbGFlfdDUc/g+TOgW/Ro9?=
 =?us-ascii?Q?17Ip9/SSLgwqBUXcNW4M+t6O2PitKC0hnQeNv4vcfaB5HKKvXrdv2U1nj14w?=
 =?us-ascii?Q?XypOXyFIawLgOg1+4nHS1y9yyV+1nisWtqJgAFXsz2hGxXjGhNmtjEXKhhdg?=
 =?us-ascii?Q?8ykvmae7sZsG8w+IQwSaxfFTpmccD2BxQWxkYY24iXSnYC4EEUhpRJs+7zSf?=
 =?us-ascii?Q?sHHASiaco5wnp3DsOQhLAIe28MU3oiDuWeTqJKv/tAoCzNpkaezizA1cew5K?=
 =?us-ascii?Q?Kl079fmXNMDqYiWQ4284WuCqspmFjRAz/QmXQV9qbxZEsp2W1qT26PRSQf1X?=
 =?us-ascii?Q?C4uAHGmrExHDchkrKSe0AE4OwgljdlQa/X3A6pVsv+xINc/85DjDQhGSJ662?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d876e4c-89bb-43cb-59cf-08de3c9b70b1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 12:05:45.0821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qIf6hDo5rA52UFylV3mOX+34AgsvAAoOkziz63olfR0veLG0Sc/iw8zXky51lwk3/Di71gATzLTC8M5rmrf+YDGPi4a/E/wita3538b6dA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4572
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

On Tue, Dec 16, 2025 at 10:35:02AM +0000, Ciara Loftus wrote:
> Depending on the underlying architecture and CPU flags available, a
> different set of Tx paths may be defined by a driver using the common
> path selection infrastructure. However the Tx path selection function
> iterates through the entire array of potential Tx paths, regardless of
> whether they are available for selection by that platform. This could
> result in a null Tx burst function being selected. Fix this by
> discarding paths with a null Tx burst function from selection.
> 
> Fixes: 336374d8454c ("net/intel: introduce infrastructure for Tx path selection")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

