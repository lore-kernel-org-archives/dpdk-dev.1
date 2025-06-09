Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3B1C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 12:33:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5A754060F;
	Mon,  9 Jun 2025 14:33:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id B270A400EF
 for <dev@dpdk.org>; Mon,  9 Jun 2025 14:33:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749472391; x=1781008391;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=RRH4wtyRTX53QIMsfaYWOSl7TdTSO36r1KLXMNUe4tY=;
 b=cT7txpgJGHjnziyIJ1SgBfDWGCrrFJGrMtehTGq50J/oYDjkjPDyT1ua
 oGSwk7oHq+ktNG8yuNBzbJ3ExGCAblo78dxDWfe78xwK1kvLhTD3IL3n5
 55FUiFz6GbC0jQPvs7KcFoxnn7oRb0rrfb7+VYRnFI1ysTPPA52wZKmMB
 qw0pxd1u3ywJIG+HBytOHtrUF3zpdvaPTs1hV+fkYTm3z5IWoUrdhaj+w
 QiQ/Jmz2vaO9WlDQwtzXxAn9Bbp7prylGSy6YZhm6dMb3vqW/q4jjygay
 9JwvV3L0MzdP7a44Y41f2Q4bbhfFeqZaBczID6GrHJG9vkrlxBNmz0nBh g==;
X-CSE-ConnectionGUID: bB1ZZF5ASiiY3Ry01tgRDw==
X-CSE-MsgGUID: ddagA+rETDGmJodAM2aK2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62200135"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="62200135"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 05:32:38 -0700
X-CSE-ConnectionGUID: o1QkpWFjQVS0eSdFzM42yQ==
X-CSE-MsgGUID: 6eq0bzexRF+RhuayLqyHJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151316001"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 05:32:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 05:32:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 05:32:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.75)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 05:32:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Trawp/RHEVIhU+YZw9tMIheyOqadsISAD8RjxNU4lPGidHCgYRCv7Cxq3Nrgw/TB3t+qzhtX5dwNyyC6ER6lseYUPleSrFB9o67oDUrCXf+W8TaiiAd863n3uWmWLieJyjKeBzOgqsuD9hw23ReZvKnKoxf5TbC/RctwPiKODql0+s2g0EuZ+qrA+7AP6YtUabM8X4xom9raUJLQm0LvZT+PznFhhxeMCDS/6ZTqI1ZMkr/Fx21a5TV28Rp935zCybo9qmQXNtjdGPUYkwGa27yHwsnvYNwr+1PYM1aJ3U9tWPBeSy3k19E5wjkbEtMbCAuutDIYHkdNgz0rEzubfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NsTwLHmYC0S5DmL7//9A2NISeJaID2HCj5sTbhB1zY=;
 b=xxVxLqGDxAxJlvYRF8BnpTQtPWMYXyJt0IW8AYaFH9nAYOr+FOarhoqz9LZphEckDTcyYTe5M/qfqPZbWC4nG7uZ1sKQFLdWzGalKarQBFAmyYTgDX4+Eeqw5mSI5pFEEzwVfr3untDVrLi4WhrzDh5mdgm988/wCWig4pcjbStP8pthJtlGwGH05pGRVzfGNT9a6YTKstDtwqPOithS/vVFCAADthwNjHXiZYL++Rc4Nbn3e8YR3xLVh9SM3wfvTmzMqMUFpStVF59ETAgVPVw7O1aY7beKn6kdYhtxzi7qXEQepZKoWz4fZzbx1pB31Ic+MudXILTuKVSGtELUVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7321.namprd11.prod.outlook.com (2603:10b6:610:150::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.24; Mon, 9 Jun
 2025 12:32:05 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 12:32:05 +0000
Date: Mon, 9 Jun 2025 13:32:00 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Song, Keesang" <Keesang.Song@amd.com>
Subject: Re: [PATCH v4] build: reduce use of AVX compiler flags
Message-ID: <aEbUQNFZHhKFKGeB@bricha3-mobl1.ger.corp.intel.com>
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
 <20250529154249.1310449-1-bruce.richardson@intel.com>
 <PH7PR12MB85967617A71099E2F0E5C835826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <aEaUA7rDVyPJEvP7@bricha3-mobl1.ger.corp.intel.com>
 <PH7PR12MB85969B5D596151F83DA09600826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <aEbSNr7iv7oNJ7_U@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aEbSNr7iv7oNJ7_U@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0192.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab7a4ae-5afa-4f33-769c-08dda751a4b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o/ZoNoBTY+LkVo/oxBhtenqvfV/RMMM9gkUd/JHrouwcH6be9DKT3VOtHit4?=
 =?us-ascii?Q?79f+RiyvesT+RT/tjdVJ8dBjCR29cqioZ999/hf501yl7EXpGGPjrczZfnYV?=
 =?us-ascii?Q?nR6Y+B5ZxXNUaJEygWUtuOK6tqgY4pY/oL13YSl6lJESkc8/qOymHmUiHkVY?=
 =?us-ascii?Q?3bEYCZAEZgScMK51edsrDX/Bd5Bz9FffoVIBtt/kmtYrKvyQvFZJcK0is7cz?=
 =?us-ascii?Q?3Yarl9n1bFOpKTZKUBmkKQBqsjRmOCzly2q6MUUTJlLdMoP6exW64ISDzlEe?=
 =?us-ascii?Q?YRdcBNX5xjvnLnxiMUa20Cdxe+MLNmNJ4HsFxMx8yu7tiZI3xWvt/8XUmyjP?=
 =?us-ascii?Q?vPxuStoCe/cKeMGdooEbXsZjygy0vAPWUFKNR+guaS1oVKznnFQ26hTGtPpK?=
 =?us-ascii?Q?mYopZNRuYkdGQ/VtcWjJFnrBbQrC24HuABU2LFzQYE8rCKaXly8EPppjt/ho?=
 =?us-ascii?Q?VRXt9AvEX3ohg0SZt9htfCsDVE+DJscMqmjseAWbbouSODVGDzL56gRebAE2?=
 =?us-ascii?Q?OObc6XXZ6SyriTIHWApoUuT+bXMnD5XcS4ysYCCHnodaUL2OqZS96NGuaV20?=
 =?us-ascii?Q?6uw8Sfkx5blGw/f+T6mQuIli9kRDuqnQ3x4XrlqgCW5ap9GGX5KS8Su7qv4C?=
 =?us-ascii?Q?cUpYRl9ZdN9NgEzpmua/Bz5gJ5ywiPn5oifSxXLfXu906517DRucl+MnzxLZ?=
 =?us-ascii?Q?OLynDO3uIfUGP1qhGzfdrbMbJ9boVoOSSGuiihXJMTOPOr7f339FBHgw8ur0?=
 =?us-ascii?Q?1RxzzBvrSMXOo4jms/F+S3HQ9CeHN1P8DWWDd8K3R+Yue1MYnvXGZEolfpHd?=
 =?us-ascii?Q?i0kDS/2R9aamM8EkgJSi1Mhlba7y2K5cKc7olnHl+Cd7tUjuiN47eZjQ0OGB?=
 =?us-ascii?Q?XogDgDj/VfYXUgZpXIp8u87nzbrz9Q2fEVasWdnxAbJ5fG3mdJkDHccnYU++?=
 =?us-ascii?Q?NvEJPyb/04MDAyIcry1/dcGI6jyvn4iAvXXKNnTX4TcHakQmh6gxGSMxEozj?=
 =?us-ascii?Q?QVtbfYLk4WYqZtbi0A9vJy2koNhREB328p6OQijs21cbQNGwy8LUkDRKnwS8?=
 =?us-ascii?Q?diawPkLVLhvxqfQ7BNYfkNmRtWbjbyuCapIUFFKp49m7zVYb/Ji4VzkppEoL?=
 =?us-ascii?Q?48mhmiXwBnXpKuw2Xsd7h0dX261gIA4TI1S6vpgCwvi6P0tIuoLsHxiAzEpJ?=
 =?us-ascii?Q?QVs0Ip5J0Sb8TNmU2fFGU7VHBH50yrtCdamqZ5F8X4kOAzSGkqkSBtDqK1rY?=
 =?us-ascii?Q?EiwqTBJv05Xoun9/Ui9IreAAsL+1pqop8JzMEKkUdwB5gNwPywaGgxRPi/zW?=
 =?us-ascii?Q?O1PcFQpVg7/7TcHh84yKrbBthiWN+FhrPMVAUul2F3OF/+dcaF2Y6OaYFmTo?=
 =?us-ascii?Q?jK4xhID8SxRZRqA0vcfOrqmyFhtB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UebWQT1LyCEwNNZAK/x0mZwajayClQLt8g+PeuCBxnLmSNNISKZIBIj3hpY+?=
 =?us-ascii?Q?iciMzVEltlXSYHXRbg0AE2Rol2D4PXsBOHFBTvg7HYJjXrz9OrLG1+tCYVeT?=
 =?us-ascii?Q?INzwHda9XCvZfRBEhFy2j8VswUU5xwK05wnu/ViRY5iWy8RlH+qxzKybQ2kk?=
 =?us-ascii?Q?NlYelqHHQsgPQl4GljyXBehxLzRvTI8uZQrchiHP2AOIxnDh1phskvq555Eb?=
 =?us-ascii?Q?rr/OoDvqrXB/y5ACAUqcXLNzYK2BoscIDhaI19vB4V6WB8TD2aah71y/VLwd?=
 =?us-ascii?Q?KZrMUDomYnHhNNaU8t4SbLZXIZ8Trgk9Rs4LWald3jnqVAR+G1r058riP6pj?=
 =?us-ascii?Q?UbDzR6w7GtnQWJF30JACYEdgOB37FrR/rVFXLAJVK8WSXRGLfPZcSDll9bkJ?=
 =?us-ascii?Q?WjTkZOSWXlKxd+YBqvFYXRZo4W/aZdE0brhvHvijEg/Z1yFuN64XJBU5efTa?=
 =?us-ascii?Q?YxfSFFsXH6WN3mieoayWVOeOejPhKBIUtW7Ey1ywz0yIo4BYmvlbtF+VdOHo?=
 =?us-ascii?Q?kj8NreVGmWmq4+tfKMZ7lwINXhMO2veZ/seu6Fmhj4LneDYDmtWLTkTYh7N/?=
 =?us-ascii?Q?ZgtMNsojcGmmndeABYGIkGFdwdCwDbicMWQImRMbA/0j8wx4VpuheySLgd49?=
 =?us-ascii?Q?owEGPpYSiV7diBQFf/pz2YBjwkOfuIXFL850jX34HsuOVd0GOiHceUoU7g1N?=
 =?us-ascii?Q?WjMJ2EfoopltgosS+945fs/a2AQGtIEBfrxJDG8O57kj8A6VHZjTxDwr2J+G?=
 =?us-ascii?Q?DgvRi39I2DvOOx2ubhuTetyE2rcGnxN73AmgLTrPS6Lh5tMdVZTFD73VxJJO?=
 =?us-ascii?Q?uNbz96OzVw567thuTB60HUquUQYoPR/lOPZWajLyxG23hUtrkBjN1fiwwpHf?=
 =?us-ascii?Q?swerGnviB6+HJHlH3DqQqRy60fHlbkW/94tfp/9dT6ml7U1scl6MKHw5nxvy?=
 =?us-ascii?Q?wFbslqu0J8B1z2SNww5Wt3LDp8fsaX7IYK2oOBQa4lmE2CCYfU7gonXLTXur?=
 =?us-ascii?Q?WMmAzIAHBjcY3OpXTRa0X7R8sgCGrjNY21xu7q/pTfOItDQQLMhsxV11fXYk?=
 =?us-ascii?Q?jnc8QrPcCNTrspCX6xSQYyTgsScQ6qG2cKlqwNs0e77QkUGNdChFfO+L7u9r?=
 =?us-ascii?Q?n2yjE9hv+PC1VW+VNLcUYoUK+Tm3lmUbDBMNEs3uykQAyZDj+PnsBEpLTLa2?=
 =?us-ascii?Q?uuH9GLWwnJGyM/Agn6eEihfUf+um3wGd0sXwfMsejYUlOgl/Ef2xayeNEvdD?=
 =?us-ascii?Q?p2Y83+Zw5J5IKnotL0S+UhG+n6MHrVRDmrXNo0t1dv/8i9PLkUG0bKQGvPsq?=
 =?us-ascii?Q?zvq4IDWB4lC3mZjk8xh0OVRxU5/Kdg47XQATNKLGkzdXJSD7pk9ZmXbwR4xu?=
 =?us-ascii?Q?ZKhtow4ap79FUcGjIScS8KQsXeRU7dAHsCMwAfh0w7rKD3JQ52dDGZoUrRwW?=
 =?us-ascii?Q?itHLWWCWzBIswZnA0Zjw4pOZ0y+VhVig5U2yysH+WbdAQt1Zdc5IzZtDQQgh?=
 =?us-ascii?Q?q2POSSAqggGYcDAnMy9+qk6rtTmcwlU5Y44tUZBOAkn6Tsb9aOjYlSxPVnjz?=
 =?us-ascii?Q?A8vIbZHlaLBiUxHEY7Vg2TfaI5tk+mQeOIlYmELASfGBI1YlAsGNcqEhP0ip?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab7a4ae-5afa-4f33-769c-08dda751a4b1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 12:32:05.6814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiPDbMAqmlLE1v+86azViUW8YLcRiu1uP9XJ6rJRJim+gjFRHbuU6hJDjQNPuh1LljuyxkeYW6ygt8HYXwuEXHeyuNvJM0ECDF0ZzHWDZ7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7321
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

On Mon, Jun 09, 2025 at 01:23:18PM +0100, Bruce Richardson wrote:
> On Mon, Jun 09, 2025 at 11:59:15AM +0000, Varghese, Vipin wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >=20
> > > -----Original Message-----
> > > From: Bruce Richardson <bruce.richardson@intel.com>
> > > Sent: Monday, June 9, 2025 1:28 PM
> > > To: Varghese, Vipin <Vipin.Varghese@amd.com>
> > > Cc: dev@dpdk.org; Song, Keesang <Keesang.Song@amd.com>
> > > Subject: Re: [PATCH v4] build: reduce use of AVX compiler flags
> > >
> > > Caution: This message originated from an External Source. Use proper =
caution
> > > when opening attachments, clicking links, or responding.
> > >
> > >
> > > On Mon, Jun 09, 2025 at 06:02:02AM +0000, Varghese, Vipin wrote:
> > > > [Public]
> > > >
> > > > Snipped
> > > >
> > > > >
> > > > >
> > > > > When doing a build for a target that already has the instruction
> > > > > sets for
> > > > > AVX2/AVX512 enabled, skip emitting the AVX compiler flags, or the
> > > > > skylake-avx512 '-march' flags, as they are unnecessary. Instead,
> > > > > when the default flags produce the desired output, just use them
> > > > > unmodified, and don't bother adding in extra enabling flags for A=
VX2 or AVX-512.
> > > > >
> > > > > Depends-on: series-35006 ("doc/linux_gsg: update recommended
> > > > > compiler
> > > > > versions")
> > > > >
> > > > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > > > ---
> > > > >
> > > > > V4: Fix error flagged by CI with clang builds without AVX512 - ch=
ange
> > > > >     "cc_avx512_args" to correct "cc_avx512_flags"
> > > > >
> > > > > V3: put in version check to work around an issues with some meson
> > > > >     versions, (hopefully) allowing builds to pass in all CIs. The
> > > > >     printout of the extra flags now only happens with meson >=3D
> > > > > 0.60.2
> > > > >
> > > > > V2: dropped the doc update for the minimum compiler version.  Bas=
ed on
> > > > >     discussion, that version bump is larger than proposed in RFC =
and is
> > > > >     now a separate patch/series [series 35006 referenced above]
> > > > >
> > > > > ---
> > > > >  config/x86/meson.build | 31 ++++++++++++++++++++-----------
> > > > >  drivers/meson.build    |  9 +--------
> > > > >  lib/meson.build        |  9 +--------
> > > > >  3 files changed, 22 insertions(+), 27 deletions(-)
> > > > >
> > > > > diff --git a/config/x86/meson.build b/config/x86/meson.build inde=
x
> > > > > c3564b0011..e6612dbd80 100644
> > > > > --- a/config/x86/meson.build
> > > > > +++ b/config/x86/meson.build
> > > > > @@ -4,11 +4,13 @@
> > > > >  if is_ms_compiler
> > > > >      cc_avx2_flags =3D ['/arch:AVX2']
> > > > >  else
> > > > > -    cc_avx2_flags =3D ['-mavx2']
> > > > > +    cc_avx2_flags =3D []
> > > > > +    if cc.get_define('__AVX2__', args: machine_args) =3D=3D ''
> > > > > +        cc_avx2_flags =3D ['-mavx2']
> > > > > +    endif
> > > > >  endif
> > > > >
> > > > >  cc_has_avx512 =3D false
> > > > > -target_has_avx512 =3D false
> > > > >
> > > > >  dpdk_conf.set('RTE_ARCH_X86', 1)
> > > > >  if dpdk_conf.get('RTE_ARCH_64')
> > > > > @@ -65,26 +67,33 @@ if is_linux or cc.get_id() =3D=3D 'gcc'
> > > > >      endif
> > > > >  endif
> > > > >
> > > > > -cc_avx512_flags =3D ['-mavx512f', '-mavx512vl', '-mavx512dq',
> > > > > '-mavx512bw', '- mavx512cd'] -if (binutils_ok and
> > > > > cc.has_multi_arguments(cc_avx512_flags)
> > > > > +avx512_march_flag =3D '-march=3Dskylake-avx512'
> > > > > +cc_avx512_flags =3D []
> > > > > +if (binutils_ok and cc.has_argument(avx512_march_flag)
> > > > >          and '-mno-avx512f' not in get_option('c_args'))
> > > > >      # check if compiler is working with _mm512_extracti64x4_epi6=
4
> > > > >      # Ref: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D82887
> > > > >      code =3D '''#include <immintrin.h>
> > > > >      void test(__m512i zmm){
> > > > >          __m256i ymm =3D _mm512_extracti64x4_epi64(zmm, 0);}'''
> > > > > -    result =3D cc.compiles(code, args : cc_avx512_flags, name : =
'AVX512
> > > checking')
> > > > > +    result =3D cc.compiles(code, args : [avx512_march_flag], nam=
e :
> > > > > + 'AVX512 checking')
> > > > >      if result =3D=3D false
> > > > >          machine_args +=3D '-mno-avx512f'
> > > > >          warning('Broken _mm512_extracti64x4_epi64, disabling AVX=
512 support')
> > > > >      else
> > > > >          cc_has_avx512 =3D true
> > > > > -        target_has_avx512 =3D (
> > > > > -                cc.get_define('__AVX512F__', args: machine_args)=
 !=3D '' and
> > > > > -                cc.get_define('__AVX512BW__', args: machine_args=
) !=3D '' and
> > > > > -                cc.get_define('__AVX512DQ__', args: machine_args=
) !=3D '' and
> > > > > -                cc.get_define('__AVX512VL__', args: machine_args=
) !=3D ''
> > > > > -            )
> > > > > +        if cc.get_define('__AVX512F__', args: machine_args) =3D=
=3D ''
> > > > > +            cc_avx512_flags =3D [avx512_march_flag]
> > > >
> > > > Hi Bruce, we have reviewed this internally and tested the same. We =
would like
> > > your thought for the following.
> > > >
> > > > - Before patch: we were directly setting AVX512 falgs for F, BW, DQ=
,
> > > > VL
> > > > - new patch: we are setting the flags for `skylake-server` as bare =
minimal.
> > > > - AMD supports AVX512 from `znver4 and higher`.
> > > >
> > > > As per GCC `https://gcc.gnu.org/onlinedocs/gcc/x86-Options.html`, t=
he extra ISA
> > > supported between skylake-server (super set) and znver4 and znver5 ar=
e `SAHF,
> > > FXSR, XSAVE, RDRND, LZCNT, HLE, PREFETCHW, SGX`.
> > > > Currently for DPDK microbenchmarks and examples runs safe as it is =
not using
> > > the `SAHF, FXSR, XSAVE, RDRND, LZCNT, HLE, PREFETCHW, SGX`
> > > instructions.
> > > >
> > > > Question: should we check if target is `AMD EPYC` then apply bare m=
inimum as
> > > `-march=3Dznver4`, thus avoid possible unsupported instruction genera=
tion when non
> > > `c_args for march` is passed?
> > > >
> > >
> > > Can you clarify why you mean by the "target" here? Is there a specifi=
c value you
> > > are thinking of for the "cpu_instruction_set" option?
> >=20
> > `Target` is target CPU, when generated without any arguments we get cod=
e for `native build`.
> >=20
> > On AMD target cpu zen4 or zen5; Before patch as per the code ` AVX512 f=
lags for F, BW, DQ` are used in ` cc_avx512_flags`.
> >=20
> > With the patch, the cc_avx512_flags is set to `-march=3Dskylake-avx512`=
 (where compiler optimizations `can add HLE, PREFETCHW, SGX`).
> >=20
>=20
> With this patch for zen4 or zen5 the AVX512 code paths should be compiled
> with no additional flags, since the -march=3Dzen* flag should include
> everything necessary. Can you confirm that you see the extra -march flag =
in
> those cases?
>

Ran a quick test myself, this is what I see, doing a zen4 build:

   $ meson setup -Dcpu_instruction_set=3Dznver4 build-zen4
   The Meson build system
   Version: 1.7.0
   Source dir: /home/bruce/dpdk-github
   Build dir: /home/bruce/dpdk-github/build-zen4
   ...
   Fetching value of define "__AVX512F__" : 1=20
   Message: Extra C flags needed for AVX2 output: []
   Message: Extra C flags needed for AVX512 output: []
   ...

Checking the build.ninja file in the build-zen4 directory, there is no use
of march=3Dskylake. Here is the compilation recipe for i40e AVX-512 code, f=
or
example:

build drivers/librte_net_i40e_avx512_lib.a.p/net_intel_i40e_i40e_rxtx_vec_a=
vx512.c.o: c_COMPILER ../drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
 DEPFILE =3D drivers/librte_net_i40e_avx512_lib.a.p/net_intel_i40e_i40e_rxt=
x_vec_avx512.c.o.d
 DEPFILE_UNQUOTED =3D drivers/librte_net_i40e_avx512_lib.a.p/net_intel_i40e=
_i40e_rxtx_vec_avx512.c.o.d
 ARGS =3D -Idrivers/librte_net_i40e_avx512_lib.a.p -Idrivers -I../drivers -=
Idrivers/net/intel/i40e -I../drivers/net/intel/i40e -Idrivers/net/intel/i40=
e/base -I../drivers/net/intel/i40e/base -Ilib/ethdev -I../lib/ethdev -Ilib/=
eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/incl=
ude -I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include=
 -Ilib/eal/x86/include -I../lib/eal/x86/include -I../kernel/linux -Ilib/eal=
 -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/met=
rics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/net -I../lib=
/net -Ilib/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I.=
./lib/ring -Ilib/meter -I../lib/meter -Idrivers/bus/pci -I../drivers/bus/pc=
i -I../drivers/bus/pci/linux -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I..=
/drivers/bus/vdev -Ilib/hash -I../lib/hash -Ilib/rcu -I../lib/rcu -I/usr/in=
clude/x86_64-linux-gnu -fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D6=
4 -Wall -Winvalid-pch -Wextra -std=3Dc11 -O3 -include rte_config.h -Wvla -W=
cast-qual -Wdeprecated -Wformat -Wformat-nonliteral -Wformat-security -Wmis=
sing-declarations -Wmissing-prototypes -Wnested-externs -Wold-style-definit=
ion -Wpointer-arith -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-stri=
ngs -Wno-packed-not-aligned -Wno-missing-field-initializers -D_GNU_SOURCE -=
fPIC -march=3Dznver4 -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -W=
no-format-truncation -Wno-address-of-packed-member -DRTE_LOG_DEFAULT_LOGTYP=
E=3Dpmd.net.i40e -DCC_AVX512_SUPPORT

Regards,
/Bruce
