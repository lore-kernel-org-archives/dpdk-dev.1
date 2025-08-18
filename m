Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA96CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 08:05:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2447E40267;
	Mon, 18 Aug 2025 10:05:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 83FE14013F
 for <dev@dpdk.org>; Mon, 18 Aug 2025 10:05:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755504352; x=1787040352;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=9zZPJkCRLW0drqHwA6ll5gyRAcDISvQBeRwzb7Kjbyc=;
 b=LJOwAtrcZP5uKYwhqGZoOVv28KBT4ixOudG/HxFTqu7m5qAzqcL1l/qb
 SLI0mOkC/VmNzIcTTzV2JytNGreRX8RpxEjmO5vrLHYZy5KpuYAgmZJiA
 TLVluLPjXYBQJaYA/LZlYJth9NjkyJd/uwc2zVR7GAkyZFQSww0QZttU/
 Mc0nZhdjZsq/DULImaMRqNENYaZatvVU67j4j9mhWdzwfNZSLzFh4hoUM
 er6LPIa5QQ3TsKKDuVyOw4evsOzSrQHbIopV9I9cbrUhOnQrpRzVnxoF+
 HB99YcO+aCJG25OMMPIAjcrNzACUjA5u3L050MMmbTRm5oJY+UTM4SGRA w==;
X-CSE-ConnectionGUID: Ft41HbkmSp+rt3ZGi5XSng==
X-CSE-MsgGUID: CNywaOvqR722bgVeXUCHSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="69093324"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="69093324"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 01:05:51 -0700
X-CSE-ConnectionGUID: 1LCJMFngQPewNJ7/0HLu+w==
X-CSE-MsgGUID: +xbtTYzEQV66yi16nw05hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="167907836"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 01:05:51 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 01:05:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 01:05:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.71) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 01:05:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqlTQ+p/bAzq8dn4dex/SSRgyyqH0fji0eT9RDNxW+Mne2JzWH9xExOo4H/Kl/AVfC+LODYQp0M5BsN1UdpbGeRgl0hBzhqfs3K2Ifwv4he4DGc1oe9aSvYrh6VJAuGcpG+zPSWTy0s2V0EXgt3FiySvrAj1J9okwdim3NSzcIwdE52TsHk14rVbmsL6Q1TFTQtpoLVHup0o+hwF3JjCOgVuzLY5DMXuv5NxFSU+dcOa9T/BCBxGsafNV4Cz24Y5h0a4LM7GmhlDWlaAE3MrBZnqM5nEWZNnOaPNnKsHzvzSfhdGITCBmHaUrG5OfqHg9hCg+ThIy4L4JtIauzxzww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yT08pq5hI+7g0x/wXmQBQHRV7488ePpDb7AEo1xkiU4=;
 b=P81VuT/x5/g/lYnzLsBZ1KjD7Mh4uzlIMSsWbmGLsYj+oXphtLsJzPdYdRqCLwLBQRlegSPXi03VKcy8beNqkGLgocC6pX3GkFEqAyEE2s2IgopXzSfZ2yci+TDxTFMEPJ4c3XlN/l+vcMlBtkQXxrra/45it4PDyqHPwsbv3/oOkJ4oXyZXiLDldbjc72kXHYhx4nNAf7P6IGgLKQjT0JgDw/xaLva+6hA/HqYSNtbTW5vIk+b9kKFF33sOZVZ+yICq8HBzZCZrezOeBwFc820EEDYvJIka99qKsqM72wAG+QSH903fVH5ApeN8nwDzJGoxLrQIycxnrQIHzX7UJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7940.namprd11.prod.outlook.com (2603:10b6:610:130::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 08:05:42 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 08:05:42 +0000
Date: Mon, 18 Aug 2025 09:05:36 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Ori Kam <orika@nvidia.com>, Aman Singh
 <aman.deep.singh@intel.com>
Subject: Re: [PATCH v2 5/6] app/testpmd: replace comma operator with bracket
Message-ID: <aKLe0I8337-tXlnL@bricha3-mobl1.ger.corp.intel.com>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250814212901.88863-1-stephen@networkplumber.org>
 <20250814212901.88863-6-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250814212901.88863-6-stephen@networkplumber.org>
X-ClientProxiedBy: DU2P250CA0003.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: db8f2244-1297-4670-bacd-08ddde2e06ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9GzPIcwwgteH2RVU5oUMbxXBKrkxtnAyHX22qjmv0dicS7gESZTSvHL2e7z9?=
 =?us-ascii?Q?+TtXzb5uN1w/dakQrppLhgqL3WnaCnua8c6d3bmewQspP9dmyt4Dr22LHK4Y?=
 =?us-ascii?Q?6eqe8BdhTiZPyAz3InYlaSgdTw9yQhK9DfHXDB+QxvTP+mkMZ0VsgDwP8zy2?=
 =?us-ascii?Q?XNPy0wkAxKA4mQbB/p0XHKvHoNRgdF7CiQKldov3RWF1T+d28Ltx9hvLfPjk?=
 =?us-ascii?Q?G1+e+LLs3/ACmMWhLiBTZddLZRdQ0tMR+5PJ7udQ60qJcjUhSqitljvJR1AF?=
 =?us-ascii?Q?q9qBLdadXDDBMiVuSVxL8TqpRZQ49i5MMz8jKJ1P3kZCo8ykl1gWL7BVzKJC?=
 =?us-ascii?Q?rcYcvkJlrY39sieBTY/dS9JJ9hEPorXwEMH38iEHlp+iX4E5Y0uzlk7JZjC6?=
 =?us-ascii?Q?87N5PwRm6dNJNam0Osx1M6m23aXsPH0HSAQkv/2m4hP8GGNxi1X3gGQVLefX?=
 =?us-ascii?Q?FZuIMueBBEcUtXlUVNLGtuGhZZROAfy0yGOV4UrGkzkvS+gKNyJYr7tPPxxw?=
 =?us-ascii?Q?qH8WbY+vuoD2qBGwK7xYyJ2VkaEzJBC3uJQ3PFK9ufcdNI6Q40LslwaPRDHx?=
 =?us-ascii?Q?2R+gVzNHSmo+sbtvh6YaXXuo0hkky2v35T4RUEW+Oia2hJx5BujCUjvyZ16F?=
 =?us-ascii?Q?BExUnhHN7zq81GJQDW057MPnepoANHvjeFnOTlTBLh5ZIc5bI6B/4J1dKXiG?=
 =?us-ascii?Q?NExUwqjH/MRfsuqfgMDaP7q94YmgLc0hBHjo5+H0yj/fWTOnMuhQyJCh+5SX?=
 =?us-ascii?Q?ZWz42/GaVMDTJMWPj4lNLdHo8mtpZAhZF2gbmocqgw+k/3GxDJUBW76YFQJt?=
 =?us-ascii?Q?/A+D0T2GNcWrsgD/sqPJ6PTrWNsi2XQXFdy5apMraJHwp+O5FWnmwkZMAnhf?=
 =?us-ascii?Q?OipC/uogIt0zArXj8omGTpReGmFG+7xrP5y2YEpjFCHmnlEMfJzhEuZHeMAW?=
 =?us-ascii?Q?N7u57LazawzXzJ0GGjHEeh+asXwq72Z+FWCiNe+3BWujYtcl1TTFayEbmnZG?=
 =?us-ascii?Q?l+6XLTexZ5J7J2knc/zbcQtyRMsf9c7E6eFfgUhVZGsNjCgvaRpvd6nM8q5y?=
 =?us-ascii?Q?4q82b0w2i8TQHj6qDwCPJkwfJ4C75wgaqkQPsfD/7o4b5mxekcDEniUF2X3+?=
 =?us-ascii?Q?XhX7FhLR3ZE5vJMAgaYka6WTlS0ru44FVQsdR0cWwMHI/20moyC0nzMux2QE?=
 =?us-ascii?Q?8u6/pSHnsSwZ0BYtjiHocl/diVu3daHcZgABeqizURh/a8ij4cxhbjtu1i9i?=
 =?us-ascii?Q?opAb0LZKgZ+mVfwM2iJnltPB59JvR2IX4uQg3xYbVOrIHZ0AT6+TYJbszCs9?=
 =?us-ascii?Q?hISbJVfbp3K/Ll0+rKNhFnnKWj+fXCZHjxiOu/N1hJNR5TVtzoEwS2cKcHOW?=
 =?us-ascii?Q?l/j7sIg0H4NBCV3ie+ea82hNfBLR93ZBMU37v8c1ezHIaTw6xMhv7MRpBxYR?=
 =?us-ascii?Q?hyVlissIu6s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bUI8il2Fq/iwSBq//RRGZqBKBXUbVyWSPEXG5mStcJF8zQvbe4pO9Po8A0SN?=
 =?us-ascii?Q?fJvIevbAHcQN/rhMAv5knYhEMAOR/g4wzeuF9h6oKZMdd47M0e2jnaZMTb/z?=
 =?us-ascii?Q?lsvzY9iqujWgZo8+bUeHdj0LkCyDcpbCERuWbuB1hlBVOja48S3ziHB0Bsfj?=
 =?us-ascii?Q?EtAJ+1dO566FMcU3y6UG4LJPbPeKT1r/YvVn5ZRlJA3HVd8fgf8aoXIFa1vR?=
 =?us-ascii?Q?9/Ke7pNIQ3hhmjQIT+rhiyizV+GF7he/pz0bPUAwHSMZ3Vw+f4H1D0FDQXCY?=
 =?us-ascii?Q?GNBcGVlJ/tbXDAoajEsROx929a5pENyHwAmmXiLtj9vmZ1V6MarttvTRGU1B?=
 =?us-ascii?Q?dg+cS2xLNqiDC/u5jh5fPvTtQgkzAgRLmA6L0AFPIshosGe5ik5ZSKi3IdTc?=
 =?us-ascii?Q?dGMQ5CLkj8+1q5kLEX+fbIdLYe7k+RF8O8uljTpNm8vKV3J5fUTQXCYsTRGA?=
 =?us-ascii?Q?8BpxEaU+w/NCcTIAvPp1HZOknJX1cirEWg//iFqBeqehct2igyGcizQaolsS?=
 =?us-ascii?Q?fiL7gtQj1LWBq/izQH5t4+203fIN3J+vNOqYHM7aNxGcidMLKvU4n23Ju0Jr?=
 =?us-ascii?Q?nLLcr/+FlTxjpzVn+d6Ke1BGeXpDPwkIH8A+oSTAWXDeBtjHqyJU/hBf93TF?=
 =?us-ascii?Q?qP8K6FaAfnSK+iu17yfgA7WQn5O8mI/AbCaTARRowhk1iFjq93DCse3s4wKP?=
 =?us-ascii?Q?HOqpCpKITl0LVa3nA4vWRrNNtWQPinseXdi8la+tCB37fZJ+JubpH5Ey29I2?=
 =?us-ascii?Q?VHp3hHK+sNAsNl8y/IFI+zmlC+wF+9kVgPRsAsAeU7wb0YNnQEz4iR+cgo7O?=
 =?us-ascii?Q?v9e6D53cwA0vFX2DSWPK6EwVDT8si8U2htEAjSYMZScjEFaQtODL8m0rhheE?=
 =?us-ascii?Q?vYqcmyF78f6WpNCpCci20zXfkNpaYos4RjKBUhr4OKEwTYQ6igII40K75hxF?=
 =?us-ascii?Q?0Wh5fIybezWT2YBivXeUTVhPUcZsDBf7uapZM3GiYm7oSq5i8b3zQi7/pkDE?=
 =?us-ascii?Q?73CLfQXg2/acD90QU5swOoTTfdIn+hjzZAUD1n9psF4MpxM73qLCv9SSmwod?=
 =?us-ascii?Q?d0pkB7G27bza0YKp6NihRTLQUk/sp/lBeYYS/PLzqNtJt8SoxCUxdGG+8JjZ?=
 =?us-ascii?Q?lj/J80B/HsFrgO8BYlc0L+LmQ5SQHCaqTVu5t6PWlX0ZGd1v8ljL6bfI6n+M?=
 =?us-ascii?Q?qPaKTQvaK3e3txJ3vhbgBJ2G5AEHoK6b1lI50UhhH07fpiVYPLzskdUO6xlB?=
 =?us-ascii?Q?Fy6pJRX43MlUpHWirHH2bnZ0zdLYSRXLdXwfSmobt72nBqn0uGkPwrl/e8dz?=
 =?us-ascii?Q?bKVJh99BKlHlLdThVuVjEpS1xlAuz6tYfW5bH5BUE++Ras/xODX5m51YPxW6?=
 =?us-ascii?Q?0eKJjNI7bJcfn0wyrFOcRErZ4b1MJ/S28VIPOow4NpWZgsxAksg8T8kb0Ki+?=
 =?us-ascii?Q?o7x59aKDBoMMjle428pDRb7XTABxxPzgVI6pKlg1emmE6DmPiryvNJ6LdcND?=
 =?us-ascii?Q?dQUs3tgl+YD3k5rGEIHFgu5XH1euS7c/Bynspc5lU9ayv5WhRMtFBysPrrCb?=
 =?us-ascii?Q?kvJTzsXpPJccf/f0N8i5k2i7JLTOy7PR8RyQu6bddE54ofqqx6NnoFWPyBtk?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db8f2244-1297-4670-bacd-08ddde2e06ae
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 08:05:41.9572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgTEXWLf+pRwStIggk4RHaUICFJu9qHHzRvVdDdA8CqwQ0P7CRxZFOL1TCfYHa4hKw7puyTDRz6BacV6pNfWp5sAomLAK6118DUX2g+BYoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7940
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

On Thu, Aug 14, 2025 at 02:28:51PM -0700, Stephen Hemminger wrote:
> Use while with brackets in favor of comma operator.
> 
> In flow print replace with temporary variable.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test-pmd/cmdline_flow.c |  6 ++++--
>  app/test-pmd/config.c       | 10 ++++++----
>  2 files changed, 10 insertions(+), 6 deletions(-)
>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
 
