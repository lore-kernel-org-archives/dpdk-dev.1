Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B15C44536
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 16:22:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67A9F427C5;
	Wed, 21 Jan 2026 17:22:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id B5F7540261;
 Wed, 21 Jan 2026 17:22:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769012531; x=1800548531;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=o+mZrfvyFTccuM9Wl2H7Rkh4cpO+Q8IjvG1eLI/Qumg=;
 b=RFAhv0by9tWgZZTZp5Lzmavbnr9BLQVhr81eGOZgoC4qCZhERFiUMyD4
 3oExizY4iXqPsjOq/Yyal9a4vVtKO+DPnCowb7uCgusXrC7QzRZB1TnKP
 +wkvRnpiud/39d8DnOii72TVdeBofGkNgFBUR2TRIhggGkPln73cPa+wQ
 1FxpXo6vY2mKSh3vZ/6IxnFGh6SY0J3U7rXVPflCVSjrpJuP4bj5IpvDS
 SopL4xOUiCfs7a6pNuU9bbNuRYI3sm4bTY4HS07ooV29Xt1ZTzJRu3bGE
 nJXoLaBVMmRaf+SbSNQsXC8TsFOMSw+iRdFWRbXUoon/Wk6VoLIW4lXvz Q==;
X-CSE-ConnectionGUID: V4MsKj+WR26T/Kf5NoIsxw==
X-CSE-MsgGUID: zDUU6IS1RX+0KB10wlrYOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="80546353"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="80546353"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2026 08:22:10 -0800
X-CSE-ConnectionGUID: yygrkb3FRTiAbMvVPUt0ow==
X-CSE-MsgGUID: v+odn+U7Rc+zH0L6Qip/qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="206554656"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2026 08:22:10 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 08:22:09 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 08:22:09 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.36) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 08:22:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2LaLJgWBa1uuWsdiXQpj5fj5DEe1k2hJPu2xjpoe5WSJw7SDEltxp8zXRGZE+Re/bOpWyPJisKexx+9uPBDExl2+8tHYJjyWIcLj20fSaeKkWLCs+OtWcuiJVp0j3ElJ8LW/vCj5JCEiTYkf0L9fr0E3hMIhoxcxYgBUZ6d14kKGBqQD5aac9JLiCw4h0tvWCpdXJRp5F3w+4tm9H3J6Dy8HUD+tnE3ItB8rfeRMaHkZ0oLxlGJfzgefQs2eC5/eVSnV86XPmj8jrCv00wQgKW4s3kFszb7MfXHbNLBbCvtLdx3v/M65hZt6i7oRy2/8E/ixvni1G46XzOBKMOo7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qd4SedgcpmdptuFrrruZuOotTcaqJyxwzDUpQue9xbs=;
 b=ML6YNFzVgyeAlaAjDcTInBESH0JP6SPqwaJYylZbdzEqR4RsnsJk4jXJP4RlzR8iNMUWEe7/Ke5kR1W0Is5ToE+SBFj1D0UI0S8w7l785jMgkBGtyd25wmlO8jY7M0bocFXkQUbJEDAJuYGvzvOJv33IO8KwUMqauFNwrniSMkcr7Cq8mNjk6RljtWFsllySYnZMWl5+lful2hPe051D23ksIPvpZCHgdFmd7F3yyfHOgOQ7p6wW1RA6ywtXNSetDQX6w1VhVKn9IGVdZAS6h3bmuqx9ebEYUHB1dFiHb95per9MR8a7nglH/GB0cw8Y3i5g0Psb++V6S6SQt8yCdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB7821.namprd11.prod.outlook.com (2603:10b6:208:3f0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 16:22:06 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 16:22:06 +0000
Date: Wed, 21 Jan 2026 16:22:01 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Marat Khalili <marat.khalili@huawei.com>
Subject: Re: [PATCH v2 5/6] test: add file-prefix for all fast-tests on Linux
Message-ID: <aXD9KfiEXpn1v1bE@bricha3-mobl1.ger.corp.intel.com>
References: <0260118201223.323024-1-stephen@networkplumber.org>
 <20260120015759.301155-1-stephen@networkplumber.org>
 <20260120015759.301155-6-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260120015759.301155-6-stephen@networkplumber.org>
X-ClientProxiedBy: DUZP191CA0058.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3f92cd-3a9d-440d-a42b-08de590937c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3jeTRRkNy1sZfQ6uFXau/O/SljvmgOpXI4Q/R5OGubBR8QDC9tC/h1mh20Ku?=
 =?us-ascii?Q?JBZI1RU1m0AxS8TW015D30h1MuucWAND+a6dlstnEKHisWWC/H0fwVHwF4oG?=
 =?us-ascii?Q?Fjzh93EbzbX01sTj2yEEjS332bRxOVWNAkkvYZApkzygvHBeZFN+P4SoNGTU?=
 =?us-ascii?Q?phVXSUN43XJ7KUzoWoMbKuOJph1AnHlravpTEsYu81QmIK2XJ3TEA9vbY5zU?=
 =?us-ascii?Q?fr72FO+RTVNUYeqFGc9pAL6jwEmFYTfNKRHYcXiDcx/EfzsxvqaiSS3oQTUa?=
 =?us-ascii?Q?5tLAirOQCbVDQt2uXRLTVpI3bPt8WSnJ8HplISLuUd8lYCdUmXUq24KozK+9?=
 =?us-ascii?Q?hIe4q6rwKW8bJpR9Ocj+i+EJ9Su3z2XnvzP+tcF3Ts4m1KYhJyuLNF8fXqsq?=
 =?us-ascii?Q?GNY/UkY3/EsX+yvU5EZYz2kM6+BRehOBZuXmIyHTfBFSyexJavfO2r9btQC8?=
 =?us-ascii?Q?HpI+AjNjm2GT4qTqq+dkSGImFj0cuNz6laUzBfnX0JOQ0V3+RLXMFimE97bY?=
 =?us-ascii?Q?H7MtB19dZ2jePYJDkebFmLd5FC6oNMLsOCjvkqPnF60zFoxEk0MmAz9JLGTs?=
 =?us-ascii?Q?XORESG4hNkCzH6FTI/luwSNqgMnGDCtEj2441eFhwNrTZc6lDipIMpNOlJEf?=
 =?us-ascii?Q?L/JMKlE/thHPCXp1UA/GhytEb32eNnWs+W8Cx4c4JFP/4+SW3ifR7sg7AqMb?=
 =?us-ascii?Q?XA6MUt2be7aqXV/zB3oyjI1sKCeUZk9CQsITn/Kzqq9T41DP3+ABW2KNZzOe?=
 =?us-ascii?Q?SkSfAD0k8gQuR1W4X13Wv/ccbIprrR5479koHCCouvs5L4RE5SqUIKXzL3pN?=
 =?us-ascii?Q?gK3MV/p+pEHeayxNZa/WMVP6bM32NswhgUCATfC+Pp4l3nWbt5d9AuwUwckU?=
 =?us-ascii?Q?TPA8XKbF1AvO/9jPraHoO6ED6fj1n3v39v67f5pjL7d6c26VAZjH5E9yASqe?=
 =?us-ascii?Q?pO9+Y67xf5P5/uaUskeQf44FmQAwvB/CVu7sgd5sQvoG7qfaIW65rMg53Nf1?=
 =?us-ascii?Q?+znybmGYRtI6KAg5rMFc4Ce7UOC9C8fD/mmGv5GV71XYNQaTQhCO+z8roQfk?=
 =?us-ascii?Q?Yvt2jKJtPaBmCtD3Nl5VRxFduxFcZbKlMtLf6HupWpF/CVfbLG1w/nHWTKPd?=
 =?us-ascii?Q?n/Mqoyutebh9BZPhTVL5/Cvb3anXXF09fVtvpdUqtfCDIvc5Och7E0fsbLsX?=
 =?us-ascii?Q?GIjksORVFeQnPnxYAJPYVjCCspWyPxM4qEToUZITrKH+i+QTGbv4LEE1C9qS?=
 =?us-ascii?Q?BX21NWNauqB5fPmi7PlM208ymetXhAGlfMjMiAIwkGiPqMND8rvd2wUUf5ke?=
 =?us-ascii?Q?8OT6ofgpKsVLot+E3jYNp67v3vE9gK2K2GT+dzcdXwswt5WM1GhKGUAiWBbR?=
 =?us-ascii?Q?mChvyVDnM0YxQlSvFqBc2cSJoULx79bBIFhPYxg7xmdj7jTZN2FUJDcE9C0Y?=
 =?us-ascii?Q?ad4H+N1znpBhTEe1yko9xz93wRDgY7T3DwjqmDJ2tTLBUc8joRQqIOf1uG3n?=
 =?us-ascii?Q?UP7/j4dNm6RtsRtlppZqFmBLCHNN/j80pWKNfc32jsMv5kj1EIGE2V1eyPG+?=
 =?us-ascii?Q?I1GVGUB6dRzc/NnTU/0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sR1fPC/EM7oIhFZWrnRlyVmsLDBOyYBsA9YuyYO7yUFOVoHrFOI+u+pfyCRR?=
 =?us-ascii?Q?3gId+ml/rc+4QV52J1bgR6fbZIw8/wzw3bV0xytZ1g7UmfW2MgwjlgN/R6jM?=
 =?us-ascii?Q?OI5tZeRtttcQO5iLBAva99DiqTZ0SYPB/KT9Mj5qGkQdiZT8aJ9O2DCgGn2o?=
 =?us-ascii?Q?kiQBbFncJ6Tl3selnvJvwRFpCjL/9yxTLScTGpWbQyTNHSHu2XUkFyAdFz0s?=
 =?us-ascii?Q?W6qGgZh89NjZlb9rX1k2CDlF53XYp2rcr1dhbLnqCyOm2b9uMruGPot0zqtp?=
 =?us-ascii?Q?AJ4a9zvf5zUite1ALAghA8SLYQIHB5+TpBKYY4Teg0hocxdBPB7k/CSAsWZi?=
 =?us-ascii?Q?/pIFwsY6OxwrheEh7ASzsRWDnwoF2CoUWjoSsGjhWM6Jdrc4l/wM7bfQ5p2t?=
 =?us-ascii?Q?wOUSocO2Ew/5tdkYur3ru+VG5vGyh2R3AJdGCl7LUwMn0plAKsmLT3Pq0F8r?=
 =?us-ascii?Q?a/dmtB+Xo+zeg+IgwuAdDhNkeyS25d9/AQBDRe9n7edZw7HLxta+ypOd3WWZ?=
 =?us-ascii?Q?RFCi43iPVGdcSIpvdRzF/6pImM02Ua4jo5/0au4IG26Err15kN7pVomTowm0?=
 =?us-ascii?Q?ipIezXg+5XxsM7sp/m6mL8nB3NNNgXPKLWRoTjJJR3c+VUdlTUPZ4c4ltnOY?=
 =?us-ascii?Q?aTZuO6ye0D/PsgG+cmbjPA5q8Z2oZ3PHl6RUkncxL2r1j18WfR6qclO5PYyH?=
 =?us-ascii?Q?jyiDsivwRfZSeYUpM5oa4jUyfP/1QJ9PPqaX2URrKM5K8Z65hwdJLNNM+R2a?=
 =?us-ascii?Q?hqKdOxc5FlACXkdCCsrKPAyXggvK0+XORhe+usB7prJwqV7rnNni/1M0FO2r?=
 =?us-ascii?Q?6GSfcJzXAwQDJiNrlv9bsWPhJHLwAesuysSChdoI2hRkABghhzD89wc5y9Ps?=
 =?us-ascii?Q?d/w3iIq784RKDSXeZp2nKMl+p/AqxCnK3sb+6xvro1FCYnhSqOTiVsXyGwhH?=
 =?us-ascii?Q?I4xclCt3cJlHWUZxm1fgLPTFrPIyUvVv642JrwmB001KBGQZiIreIjxvaeJe?=
 =?us-ascii?Q?iLZ+S5fyvMZ3VYZl1PH3M/eGD9OChxddfOsGsMZ2x5u3MAPfu/ZXnuMbAvr0?=
 =?us-ascii?Q?I+KKiqRU58i6DcnKzdOcvoIOqdgh7YQ4ryRbmXfjKkMulABe6gnliVeVxf/M?=
 =?us-ascii?Q?zKuo+en0Fdsl8nUdfQyrS+5xiSoGDHXvDO4Xl4N7xyEMwjWSOB9PYJx5hWLK?=
 =?us-ascii?Q?ePC+/cC7J9tvc6v7uXnFkjJLFbUBpyx05rIyMv+AYlLdlOL23VGiOnofKKou?=
 =?us-ascii?Q?/TZb3idZQcQCqgdshq8S8CsvWJSiBF0+cFDFb5EWHhnjRkx1E9hFDlb1v4tc?=
 =?us-ascii?Q?RLDjW48yf8FLuMdF+4QXvAozUv8T2SnctQUFYgf0tGYkl7lVx8Q8J7GdVPUW?=
 =?us-ascii?Q?we7wMaHO4Z1NJpcLUxzw2o9W05ry4ofDyyArK1KGkzA00Ix/ZX/2VkU6yuoj?=
 =?us-ascii?Q?JdhpACIJIGh3+VdkPqYa5RpQ8rqwcyIw8ayT8c04wQEvNjCYQP+YW0R0E096?=
 =?us-ascii?Q?LM3rzPZKezh9yBRe68oyC6pkLAVkOtgUCUX88+ejd/S0wcwUqjwdgAu8RcQq?=
 =?us-ascii?Q?6QqzpV1tOT/ZAFht9g9KYCtqxC4p4sDW1rFcxoHtka85kj7bcO5t+TmjyPjB?=
 =?us-ascii?Q?ov5dVwZkdhdZGSa2rsAFv32671gyMHRCiO4ofxM/qim5J1K67LNe9NJ+DzUr?=
 =?us-ascii?Q?cHDO2C02tyWtU9hGgni4WP+6rG0w9rKZcNgEYIjb9xuJcKBWyW1cXfuV9a6S?=
 =?us-ascii?Q?/Xd+cAx8roFgFRHW8oed2nPD/jtUZ8w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3f92cd-3a9d-440d-a42b-08de590937c1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:22:06.0597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRGayPmX7aAGslLFzgH49DrGdl83dP1p0WPEBJk9jdHpex9x9MAqR9DqJNFDY9eKPKyBIk5wSKevE0OIMqYDGHQW0E/NrAsgqJn9erHjSTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7821
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

On Mon, Jan 19, 2026 at 05:55:08PM -0800, Stephen Hemminger wrote:
> When running tests in parallel on systems with many cores, multiple test
> processes collide on the default "rte" file-prefix, causing EAL
> initialization failures:
> 
>   EAL: Cannot allocate memzone list: Device or resource busy
>   EAL: Cannot init memzone
> 
> This occurs because all DPDK tests (including --no-huge tests) use
> file-backed arrays for memzone tracking. These files are created at
> /var/run/dpdk/<prefix>/fbarray_memzone and require exclusive locking
> during initialization. When multiple tests run in parallel with the
> same file-prefix, they compete for this lock.
> 
> The original implementation included --file-prefix for Linux to
> prevent this collision. This was later removed during test
> infrastructure refactoring.
> 
> Restore the --file-prefix argument for all fast-tests on Linux,
> regardless of whether they use hugepages. Tests that exercise
> file-prefix functionality (like eal_flags_file_prefix_autotest)
> spawn child processes with their own hardcoded prefixes and use
> get_current_prefix() to verify the parent's resources, so they work
> correctly regardless of what prefix the parent process uses.
> 
> Fixes: 50823f30f0c8 ("test: build using per-file dependencies")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Marat Khalili <marat.khalili@huawei.com>
> ---
>  app/test/suites/meson.build | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/app/test/suites/meson.build b/app/test/suites/meson.build
> index 1010150eee..4c815ea097 100644
> --- a/app/test/suites/meson.build
> +++ b/app/test/suites/meson.build
> @@ -85,11 +85,15 @@ foreach suite:test_suites
>              if nohuge
>                  test_args += test_no_huge_args
>              elif not has_hugepage
> -                continue  #skip this tests
> +                continue  # skip this test
>              endif
>              if not asan and get_option('b_sanitize').contains('address')
>                  continue  # skip this test
>              endif
> +            if is_linux
> +                # use unique file-prefix to allow parallel runs
> +                test_args += ['--file-prefix=' + test_name.underscorify()]
> +            endif
>  

No harm in this, even though I suspect parallel runs may hit other issues.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

