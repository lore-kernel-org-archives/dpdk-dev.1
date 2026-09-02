Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA028C61DFD
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 09:41:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C147840374;
	Wed,  2 Sep 2026 11:41:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 38A8F402F0;
 Wed,  2 Sep 2026 11:41:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788342081; x=1819878081;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ib7r+wdYFmiNoiRER2yCC35v3zWYAUrCLBJQ0oIDBJo=;
 b=b5HF5mhmElVDrD72WgtqI3dxHqVhi4pzGLl3erOpdwMtSFIC35FBOIBo
 4KNLM9thnNRHRbGXcEpkFgWNYJlrGKpFAyUU06GBCDJibO7PakvP/7zvt
 zsEb8lFrldTKN1rNGnRpUmNDoUnEXEERDJ0FoaqCVobrw8srcUif0BKj9
 Rv5JjBm0ZIa77tsheDNNW8a+qDfuNEn3q24vmoJ/hhFRWzpwLsscXFU04
 oR56PRcRB89wX2VwCQazpz6TwRmtHPG4deEk/GuIkReJRX7NMqypupICb
 B3EmT50Zx97gHo3AKHJyFwZBeXtKyXm1/l6JqDajzx29mYzGho36OI6PS A==;
X-CSE-ConnectionGUID: 859kBrTQTWib80xjEcyCgQ==
X-CSE-MsgGUID: CitR6GIbSI68GpzKqXp3fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="76343786"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="76343786"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 02:41:19 -0700
X-CSE-ConnectionGUID: /FgMiFZgQxO5cTTVNwbL6Q==
X-CSE-MsgGUID: du+giTPST1SLAAIASWXBlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="265651211"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 02:41:19 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 02:41:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 02:41:18 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 02:41:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQAlwCjeN7kzfGdHFmNuFhfPoK5UPWPEf5FRpL3zsVa/5Y+5yZ0ClWmw99zS9fffNUm7zL1iVQyRg3GcS/KnZw9owqW5lLkBeN1Wpw+wRJagU28N2tnCbYmiSRbP6HX1l+yEI9ktaeNr0Zp7JS+hk9JlnsoPxvrInbeqpR9fPu0AVdmdYbO/ExIvxy4E5u5EkgaF8+6qbVjQC8dxfw0oMEsbTcjzRyhDNGoJDBNtj8y3TdTWIOe0NuhLxjBR8ff9owyaA8QV2tGdZ9dmMNK3N0dFW8BUsEOEJrv+mHSO6QTrBHfzgli0TjHoHWBvcsTu1p/ij1rVn+lzaJlxkg/PlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Y0Z6yjsULmLoggMqtzQxaPh1CjVza4NgTQYkB1C584=;
 b=LYwUsz7Ply+BqbH1B+TD+cwHZClpIFgDRFmKJhi4eHuXL2+2UxGVM+ISBUsalmUoydJi8LuVfOC75lUukr9DA8cqJm3FPUNmKQ7hjrJ5hm2XMKluhPHU7Ns8Rgpr+aFVBUEn9i1fuB6sUODIGGRa8Efbk/BDYw5+kzcJio/8wdMluNn0AS6Mqj7XTI3v9jb2OZeJAfcCO+Lu7H7spBRwOWlDpuVPznCPQR4B9uLs0hLwH5aDuivUdrif90Txt4nzz0Uo6wnHhv9Hyg8LwtoG+l9fW/QBIL/VPBd/nmCHtMYEO9w1HDD/mmzL3mynvQ6q2dcB1IDkla0XJadV+MgQIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by MN2PR11MB4632.namprd11.prod.outlook.com (2603:10b6:208:24f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:41:15 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 09:41:14 +0000
Date: Wed, 2 Sep 2026 10:41:10 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <jerinj@marvell.com>, Rajesh Kumar <rajesh3.kumar@intel.com>,
 <dev@dpdk.org>, <thomas@monjalon.net>, <stable@dpdk.org>
Subject: Re: [dpdk-dev] [PATCH v1] examples/ptp_tap_relay_sw: fix build
 inclusion
Message-ID: <apfvNj3ye24sbGbb@bricha3-mobl1.ger.corp.intel.com>
References: <20260902082523.206083-1-jerinj@marvell.com>
 <CAJFAV8zRf5YuW3O2c7kZRmCTQ_b85DWEMqAE6UjH7ynHO6JCrw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8zRf5YuW3O2c7kZRmCTQ_b85DWEMqAE6UjH7ynHO6JCrw@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0318.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::23) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|MN2PR11MB4632:EE_
X-MS-Office365-Filtering-Correlation-Id: 51edd89c-b9ee-42cf-2d3c-08df08d6549a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: N/MR3mmBjmosOpIwfjpxlVxy5TBiI6hbeQaYNz2pplkj5UVQ6CRnK9ViSL761miS2aBThOvlB2+WTXh0tFTQphqcvDc3B/RoOl31M2FG15OKfzfikJk8bHgS2zswyuB+Ex5aQliGOIYnnUCPkxgMYQ3phnh2AHCQ2aO55fxD3ghvGyKCtF5wWRu//whUWcTt2PGsN3lCDzqtUgvqOJCXvkiRL4a9KFS62LUhuH+M7OvrjbGDESgcbb3HVSh2YluCEz2VA+5OwUAxg6OYQWcep1w+hkjYj2p4eBZVVxosmoLeKtZi7B7BnqGeEjhTViPwRFHcS00Bz7RtlCaCj17WY/DRsHzJwcF6R5goOlDc+AU3CVZPTGxSBn1Ty+eFRWNhA4Brvy+8BcH9WXyOtGA4xpuqniEQhlRrJz8qhjTlmFqQU42x9gsEvtXQFwPg0dOjw42EVlOU9woz9WBWIni6Pb+2xGrQ453rcg99DoF4/bjVTUwGeV25JVJWrMd1xldodlko/27d6fmV2Hs5F/mpHDbsuIeg3qfPUzyOqsZeCsdO/LHGagqvBi7NYdRLUQH6B1Nx6dwoMnZsJ9sF0+wnUZI+mUnidA8tD06bxLxBgohB5gaFY8mQ/XbLek/bkz++ivxay80596cRaGOHf+iXqblKXRDeY05X8t/MVyyxi1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dHk41oL7RGpXNJEa4dva8/v3Vv4TL4wYPlmcRawTrprFyzFBM4mhftFmVm+m?=
 =?us-ascii?Q?JUvnFdbdY/b3MJTmC2PemmiVWBbBAkndsWhi1b0ojcWhqvjIypA4K1lHTkj2?=
 =?us-ascii?Q?yWlv+2RgD+vFCjfyRr/8GzgYJlmdhVfA3CQdFeRh01vhqJL565H8ZiADMmcN?=
 =?us-ascii?Q?l1KFYQNHGSeZY3k1uo0+FsDp+FpgVuT4KwMkX8PEA3vNmpjp62p152Lg9wB/?=
 =?us-ascii?Q?nOSJ9e3ribz2JhYtQEUIbIG+gpDQNHTEe18A5fMV/1Vkc2bhM4Fvk3Kdhoz/?=
 =?us-ascii?Q?3CeJT9WaMnlqMESxb+cShf254+4i+T8PJXFS+1ivmnx2Zmsg9njlqWa1fq6e?=
 =?us-ascii?Q?mNv8XuFQRJjodjqc/WB7yxOuwgRiZmJ9IXaYC1ugFEY+OVnVol0NqXrsV0kj?=
 =?us-ascii?Q?nHdCeUnlf/T2NwDeXFEjjUMBo9k/moSlr/inD99PhNxP44eEVv8RQpyabHyq?=
 =?us-ascii?Q?xl3pw6XZNSFc/Mn1t9JC3m74mGfDGz9G0xvoJ14Rbp7YbHXMrZhQRnInz2gZ?=
 =?us-ascii?Q?hmWc9rM0Uv45c71KP+Nkggw3kmkza6xIQI6ATUpSfgKcJYqA3qmDbudz0CrT?=
 =?us-ascii?Q?oUjUnNWsW1C7yfMbqW9B3LQThdqLF3UZgmDBXIw1J4Go4RAOQfMxNErZEwe8?=
 =?us-ascii?Q?ivkc/MPumUWMzx5z3C/VXmfE0BANzTklm3oELqRvQkruVQLoB0WPHhvKQFKD?=
 =?us-ascii?Q?Z0/QFKkRwPnrZKLkY47pxi7NtwFg4eSt/h5rPFDdvJvw18D5BngVBuyrmxDY?=
 =?us-ascii?Q?r2x8btJPy2eCQEgCiE8nzLjAGe+ZcB3LoCbfUF6zUGVL2DeBEgXFMwMbxVa9?=
 =?us-ascii?Q?AfGjiIzOBwTj3Dq8S5mr+7qYVJVHGo0vg1q/Qd2jdGDspeQNN8kEPonSg5fQ?=
 =?us-ascii?Q?lTc2y4Bv/+oBkvfBWcPgv5KmJBle6RrxqKCdVSlrxg2yYjUwuWqMPmSL9FsG?=
 =?us-ascii?Q?tdhazCAGlJW++aMhdMVKFAgFjBSWjY3ue5uLnLZV+jgqnanP1o4p1UIflWcr?=
 =?us-ascii?Q?usSYu1XAAAVYCv5s9TNYgrl2WRj3BhsZU+EYdWro/4gNLO4kn69rutPXk5NJ?=
 =?us-ascii?Q?XvwnArigIqVygYyeKJ9HIMBDVTVqnGADlp4L1grvzjqUxdAcj3u8wvab1w5X?=
 =?us-ascii?Q?8eE+c7ZmOKxdguNtis48mXQ8JlBpBlLsjkZ+liphMe/rHjF/dIFrLFC7g5t1?=
 =?us-ascii?Q?XXm0PXNZBfGED74ytDej30nZK7KYCzlDeQ5kJhLQY95JMKdi6Zvt/pIB/E2s?=
 =?us-ascii?Q?vvD5PMs8d2/y8WEoOaZ3K+PDbhS1G53NQ7/s6DpzDy3FXRi0LD/9nkaqL8Uc?=
 =?us-ascii?Q?EFKO07xa4FjcqRsg6T0oP1G1pG/N6y9BG1UZfopNmneppYxjHxIdTgh9fNIH?=
 =?us-ascii?Q?O/72RmqJOm7oCpzApydSBe6O+2xCAJEnzcxwc+M9PRkKe+TIR8My8z6C/lfB?=
 =?us-ascii?Q?hx+SZVYuNAHS+8+vNBa3ZiU5t4QS6Ha9pi+U1iwXQ8wM+Gv7qiyJRwMnpSVS?=
 =?us-ascii?Q?kDR5jULLSTfSDiywYQB5nQut4DuvsSYUq5HOdqDTEpBYafeHTnaAAJlKGWOK?=
 =?us-ascii?Q?lxU1Bkaj6DXyAr1sIl/DCU8ya64qkXVh6yFik2uH40EdDNUgCfrCPd/ZlJm3?=
 =?us-ascii?Q?ertKa5tHM1v0eo3UzWf1+Xxb/RKWQKj9e9yYWq4YmuerENwDwrX2d/tVampw?=
 =?us-ascii?Q?DUNw3/xD7T1/CZxeHQxTIG6cBp57V/nmB70c9mH/Bu/KOMDI/fjnj/LeMPHj?=
 =?us-ascii?Q?xWtDLWmP4DQEzGCnT42rhU3rVJDTru8=3D?=
X-Exchange-RoutingPolicyChecked: ul9LwRPNAwbqjsXuejmUyWPREaVbfvemxI8goonr+VgMOQnMnlN+2hLloDDWSNh6A9gbOBcwGthw4VqfHgXcT6FGZIgAM/rh5GkB3DmeGHMTpFWgA/i2fST4lVkfxOkNDG54IsUwp7Ng9+fZcFyy0UDM3RDvmYLPhl02vPA3xeEgq9MwlT/sKyR1Iw6QryvOyK2yh+fsNBjp0LZ6iOhK7w+ZZcb7V0tN8FPtm77Y3qCi361yNcpJ1JccTokP1jVFKdZ8mVuDelQ8lUlY3lplEB8PIaamYjzWKhmI+iwPkzcupy2MYY0fkPjYzmhFsbJ5p1Jshm2MD/24MuDVIKW54Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 51edd89c-b9ee-42cf-2d3c-08df08d6549a
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:41:14.6522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D44xs0Oi1zOVjVUDzXLBGAvTuvRBIISpb//5LjqvCv1Mv4chfHz0MmNi7z0B5E4KwuBwB/7OHDHYEuN79Un6FbWxehTXzVO048H0i3N2qnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4632
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

On Wed, Sep 02, 2026 at 11:09:02AM +0200, David Marchand wrote:
> On Wed, 2 Sept 2026 at 10:25, <jerinj@marvell.com> wrote:
> >
> > From: Jerin Jacob <jerinj@marvell.com>
> >
> > The ptp_tap_relay_sw example was not building because
> > examples/meson.build was not updated to wire up this directory.
> 
> Ouch, the whole example looks like dead code.
> I wonder how it was tested by the author...
> The series that introduced it has no trace of touching
> examples/meson.build in the v6, v7 and v8 iterations :-(.
> 
> 
> >
> > Fixes: bec00deaa8fb ("examples/ptp_tap_relay_sw: add PTP transparent clock relay")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Jerin Jacob <jerinj@marvell.com>
> 
> The fix lgtm.
> For the record, it is the only dead example at this point in time in DPDK.
> 
It's not dead code, since it was buildable before when it was named using
"examples=" parameter. The list of all examples is only used when
"-Dexamples=all" is passed, so we are just missing this examples from
automated build testing using the "all" param.
