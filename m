Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A97AD2ED17
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 15:22:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D31D40E50;
	Tue, 20 Jan 2026 16:22:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 2377F40E32
 for <dev@dpdk.org>; Tue, 20 Jan 2026 16:22:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768922560; x=1800458560;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=XqFxnyToyELn6wU9xU+/trul+u/WjyC5mPtWVlVPnag=;
 b=E+2cACwAzO8/PfUPwsdbNjG7DSmT5mn91DN3JrSnT55CJqelZwwXitkU
 U8Fgtxg/rCPkUI3Y3E7sZfSbHxAyM1VZeNB/XVM0B5kJbks3NFzN3yfuu
 5Ur1kk8GpvY5r+Cwy4EikGFpXoUtcK4guUvE5CqKU9xQ0S4bCeQh5JHSR
 yhGUuhrDXqfod9b/5+xJb39sRvOMcnr31+r5bEiBvPLdY0T3sQHoE4skX
 uQ0fkjknXRdCYlGrzC0eIKE5iwdIVr8BFVOVQIzYIgoluA7rbMWaFhqWQ
 mh84JmeCLiheKPA5dcW6d3ir1N6QQnnJ8x6MZWsLC69vDunic+YO11Amp g==;
X-CSE-ConnectionGUID: RZ4xk5T6S/qTBdiWoIK6fg==
X-CSE-MsgGUID: tBJdi6IBQUKp0ygFhx2k5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70188247"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="70188247"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 07:22:28 -0800
X-CSE-ConnectionGUID: 9c2x92HaTtq4mh5m9APbYg==
X-CSE-MsgGUID: wvF/f1FRRBqPmFJt1o5ecg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="243732816"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 07:22:28 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 07:22:27 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 07:22:27 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 07:22:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DaxogG3H+oJacoN+7W0R6MUIPIP1r9eMfWXJFuYbSOZEHXz6MnjYVC0I6SIJ8brjDPWZxv+LkLwL9fA5/mPHW2N2b6s6fEyUuTQW3rcrYKZJLNxNsc83uHbE58OcGs3R+aEkSThY9ILpL6TCGYnAsig5ypz/Q4oh8BZfia5SpRy5ts+UzcJf2t2P86QkuqqibSPoAUOVFkm6x7PFbXDnDTQndMcQjUYM0wG0vuL9+XayelWi4bjKG/1+++qULKTtLgffAC18SOx1eCAZ18YClvWog4nI64stfnMWy6Ef9EZjsGu+y8ZESRgQC09QW9m/BAjdm9BSkH2ztBoq716fFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGpRkZxqsGXbR/AUzpMaoBp6WAtHoYxa8mVB0g+cEOg=;
 b=f56eTYHOltvVBxNIWNXfuAR0b9xMSkz0P3A/W8Bfmnwqtkea/AWx+XimAD/PeFFTVwYA2NaPSi46rnxy105l6dJMvMUruTnmGcN9sk7isFig8OAyn9BZz5csIQk1toj+LlY1Wq4rttxj+OQpji7iv7IvD7B77+ljG4WMkW/vCcbqZEczGQr1pSjdYcAcargj4avgFGTGrq9mf0t/cT6DPKFErQ+qiBpjuJfM4N47/X0S4+OCr/f/TDGKx4FrwBm/mikpOdB9X3fiJoBdvLHQvLy3Tkv5RMxm0PrEj2DjkRqKJm+PDvjP5I49UXDY2MC2wViXS7++lBHxSiPEVejK/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN2PR11MB4567.namprd11.prod.outlook.com (2603:10b6:208:26d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Tue, 20 Jan
 2026 15:22:24 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 15:22:24 +0000
Date: Tue, 20 Jan 2026 15:22:18 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH 2/3] test/eal_flags: add line numbers to error messages
Message-ID: <aW-dqgtWe6CBz8We@bricha3-mobl1.ger.corp.intel.com>
References: <20260120112552.921243-1-bruce.richardson@intel.com>
 <20260120112552.921243-3-bruce.richardson@intel.com>
 <20260120070358.56bf69f0@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260120070358.56bf69f0@phoenix.local>
X-ClientProxiedBy: DB9PR06CA0010.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN2PR11MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a8a002-105a-464c-5789-08de5837b691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TQzKnmeXVxCv1I+EqzUUifIM9ZxviijHheMmq73rlfcNDll9knMZXHOGtXeP?=
 =?us-ascii?Q?KnrkZzQG6U8g/QyLO+4DA+/oICn67prWfGmGxeSmwUR3vSLbi9wHnAM5e7Gh?=
 =?us-ascii?Q?7sdU+Zaevlddbq7GRsNbiXb9elsDHci5NgVhbidPAORuyA6A0pOdLUz6MINK?=
 =?us-ascii?Q?5rWGuqBXHTXCxV7MNNiC5J6wTE2Cf5SxR3bjoDuKRZSkmM+Zl2f5g5o7zTFE?=
 =?us-ascii?Q?tvMkareViYOLJIY0BC3qFL/onRm2EkT4NHwHAXin3GGeukrKlNBYcFN8k6t9?=
 =?us-ascii?Q?tlqxWjZ72lI9v2MktCUYf1GruJ9Dj1ppOHcd+1NX0RAl5I6LGC7v2bT8Lurv?=
 =?us-ascii?Q?3ebbYc164EELEQXgdjt9OKM/B8YLB96vu/Esju+ju6eD9eEPW54TX09r7LzS?=
 =?us-ascii?Q?axaxnjHuzuer7l1raflvbxgl5kCGcp1cTNgG1gLiUhRDr4kG67D7ZnhrahP8?=
 =?us-ascii?Q?SUCsSouLco199NHadEHsUBr9YelUVTFUmzJSG3W4ZBof0OsPVBcy30+UmyKN?=
 =?us-ascii?Q?a6Lu434ylNebHe+M9K5zTD8hqJ99JBgQZV0+AM+/f0XSlDbbvXuTRnBn8mXM?=
 =?us-ascii?Q?ZdfJ1dNtboOvyeqINlpKK349GvFY32PntPT7imhEjLoX7kfh4+WURxaMrk3j?=
 =?us-ascii?Q?goIAYFTUTfO8OOEChTptQuc2HfvCpEMkEc9mTgdW7NokulGKNXkb9Jrs+DgD?=
 =?us-ascii?Q?Ae/t8B4MQCuAUsP3ROVrUJ7n1hQ3sVvZzzsq8qkLcXFm2Xez5Gr6BPGxFEKW?=
 =?us-ascii?Q?cxDEHknDNqnZkod/gVCB0qEpNmOwer2Qs5tjV8EyzOmjYBuTF1VTp5iz8nvg?=
 =?us-ascii?Q?FLGTvqoHhQlkLlGfLSmtWuyjYtTH18a2eg1K3nIfwIjzWPJFFP+ecHHrUdK1?=
 =?us-ascii?Q?WSvBb5G8VukZTS7C3ilFl59eejA+H/r7oUkEsHnxWeBCXEd7tSsZTF6Dmfdw?=
 =?us-ascii?Q?9d5FmlboRJhfSt8VWZHQ+y6VqRDmu/upStv82imHeN5Pk2G/zwgdbl/ncfzX?=
 =?us-ascii?Q?7g0tYmIs92baJp7C3xH77xteQnxYiqsd9LIVbICgiKhJdD2nMGdpIcCXjd64?=
 =?us-ascii?Q?aKPQdmk4txM4g0cnbCKY/7Kuq+6D3bYT+YJn3xplu1Q68AZ7P52DDmmPDz6v?=
 =?us-ascii?Q?9sMPX26dXvVqYjWHmEfwsYSmfqxPsn1Nqn7SY4Sc6eqvff2QGw+bVIvAojQt?=
 =?us-ascii?Q?EQnxCkViBOB4OFEhzaWN/UHU3vJ41ClZSP+Jq+sVsxrheUEhbNs1m90iOIlZ?=
 =?us-ascii?Q?++75dCH1jq4iOZoSNA1+nMRR5kE7Kp42xIngupxzsgm+yR3dehWOVRoqUnpK?=
 =?us-ascii?Q?lGe7Ayd8YtKKHalOc9eq++jI33NGcZoPH5BzNvI0oLXn/4+oiOFENc+1NZOi?=
 =?us-ascii?Q?d+Nli1kYWxAVtATJfywPap76PylMIXVide6XbvTT37dxDpJ/nSg7p8itaPPg?=
 =?us-ascii?Q?LP8h2sFVMSzl1OCgkl5oXTb7Vnwv7dB1QBWSD2bL5+mXbzK8THWQ0c13iMKl?=
 =?us-ascii?Q?65Ej3A9v49DaNkrLnFENfdnTnla5Nsrzf3D7xAalqe1e0+O/6bLBUfSeLCmT?=
 =?us-ascii?Q?z9kkxs3IxrMs37nzaMY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AgsIccHemyAiChlFAAqWGX5qbEKY5i+Z0Jx3cmxGDuce6BGJqZaEf+95oh3O?=
 =?us-ascii?Q?noIZKPL01+p871pJCbntZvLmtlIFA4FztN9Zzt3nabgIeMAsA/mqTfoPLGGB?=
 =?us-ascii?Q?JgbVkJYKPI9JT9rrxGGxsoD7SlkcipoqTVJwPFhaQIlyTVqITmsusZV7kG8d?=
 =?us-ascii?Q?NcEeipARv1o4I8SiMHVBSSFRIxhegPqY+EiJqm3vud81rU0bvuAX9ZSZFyeP?=
 =?us-ascii?Q?dREw4dCpmVYqtTYb8P2KyPPwkLRzBvD8x0eXgACKwJFBzM22Kqw9M8zghVe8?=
 =?us-ascii?Q?tEVwO+6vFTZiwNBr6PpDAUPjqukv1oiyW0qCpRP+jqf2+KhNkcJhTjbP2+fK?=
 =?us-ascii?Q?xFS0O+xrCZwOvXsClBoQJej1LJ95pN9eRs1TbfUA5O9X1BxfTdtjWO/cE2gg?=
 =?us-ascii?Q?zg27NrrH7LWjmFnB2bYXUtag27vtwQIACyiYcngo9YRg241DOcoA1Cu+k4C4?=
 =?us-ascii?Q?gcP+I/0SZkSmOF59pGD9XuZ6ZzZyXyL2mxbzCpMquYEssokF2UHqAbJLlBba?=
 =?us-ascii?Q?OpD8gk3KI3dVt7EhVWCN3YA92QQPf//zgdLd7oa2twRVwhgQ86ELT5RoN2pF?=
 =?us-ascii?Q?zg/X8K4bxsir4w6M86mxk35DIgD/Vd2eoE8inZX8lBshyzZ3hTUiFZWsMhW2?=
 =?us-ascii?Q?LF2PgfTq8SjnRTUBJ0ONIFjzzZYbi2W2SfldYRy3UeF9w1Y6f/LRALf3Sm7V?=
 =?us-ascii?Q?xPF6kNrCaxZJclEl7adxEC19s5U4pB82JT+vszNFmpFcI6YxZ7MhJnIoTU2i?=
 =?us-ascii?Q?9fRjdC4ODYd3nkf8wxD7uiiIf5cX2Bbu+ZxDzSYStczn+2DPR34zv1W/2+3n?=
 =?us-ascii?Q?Fj1dDqX5DBdNHWSoSO0t+VVrJvJvOnSLlCjyIzuSMzpsWH660SjILCXyMdpU?=
 =?us-ascii?Q?/6xeMAXPNejQqFb+4r4n4K6fb3uBsSODiqvb1jDhjKewt0G44pnmDGkpBbkT?=
 =?us-ascii?Q?UZ47BNfhVSSuh4vkGt2S9q6i+q3phVHhtUcCqMCJtVunvNXcilM3xWP+6J5z?=
 =?us-ascii?Q?7+quoPMokuOWK+QivFukWo0Tyv259QPlsyA1CENjg0HZlAPpEh3CNNqTepIj?=
 =?us-ascii?Q?VYnLKSNqD+OGZ+WzSKGwIfk73eQO//uBShtW2M6bHBl0RdtwmVKBs5xOA+Lu?=
 =?us-ascii?Q?bm/z/JZ0c6knj4EKnyQGj3gqyCLrarPaHTrUX/HjXmP9CejWQJKnwAwfd1en?=
 =?us-ascii?Q?kERs+d6WROyCal1cMERrF0ZJmovdc41rPXr9yE8Gp6y90ooX04M4Rty5+Sut?=
 =?us-ascii?Q?Vx+NiJriShLidw2+YQFF+URIe5NflegZ7uzK8M4f63kwTN7fNTIck/iqF0vT?=
 =?us-ascii?Q?/bmkKZwxVIO/aujuU116a1LoHQogpsNqUe8DM6Ju7n9IVujWEe0f0+l2ePY4?=
 =?us-ascii?Q?LM6k+4JuP7lQc9mJxyvcFE7AyUs74S26/u7qRB3xT2QQlmSWkNSlclNQ2ZqI?=
 =?us-ascii?Q?EGKUx5BBVHMlNwsFAQ4NHHoZMV7/Bxdop2segj4qeSf/8bsG1cb8E2EWp0Dm?=
 =?us-ascii?Q?4uJf/L5RiMHfkCJVv8WpP+Fl6WbWHn1xs5WTH0DDM7huBvoeAC7aCejgym0g?=
 =?us-ascii?Q?iomLhp+/YmWkb1LwWtPuqw9Gr59HWVCAK/OcnhM0H7TbiEzhm/YGBj1ngRgo?=
 =?us-ascii?Q?TDFsyBzNjADX0JUEVD7wWTYDQPFO8kr2p1iqzPAbN3XrTv8L4fojUX/4TbZN?=
 =?us-ascii?Q?RBc9eWmLvLw3srqZAgvdxx1GJ9m2HKNARmfvAYaXrSoxQ1Cz3v1PU/RhGGTY?=
 =?us-ascii?Q?mgAccHYEA9wlZzakMIVfqWGx/862RBI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a8a002-105a-464c-5789-08de5837b691
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 15:22:24.3876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6IMO13UrEtqu0PXNEch9degLcymIAlKEJMbia0KmFdY+h19B9SW6iqQQRPfaOTJIKPwVmWwjsUYSXI85Aoc6QF6HRpUE/uKk2IElVcnqfaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4567
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

On Tue, Jan 20, 2026 at 07:03:58AM -0800, Stephen Hemminger wrote:
> On Tue, 20 Jan 2026 11:25:51 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > To aid in debugging any problems, and because there are sometimes
> > multiple very similar error messages in tests, add line numbers to the
> > error message printouts.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Alternative but not required would be to the TEST_ASSERT macros
> which have file and line.

Yep. Agreed it would be better. However, for this patch I decided just to
add line numbers directly to minize churn to the code.

/Bruce
