Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676BDC0219E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 17:54:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B190C409FA;
	Tue, 11 Feb 2025 18:54:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id B706740BA2
 for <dev@dpdk.org>; Tue, 11 Feb 2025 18:54:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739296480; x=1770832480;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=brX26TqfTL26XSe/ibBTaNN6Sh8SlNqyCaeuerU+oSk=;
 b=FoKwVG8YYx6aPGxJmtoj/3tN2vzHzrzLEKxKGHm3uPJIknzjF/IB2EWx
 s5QrQG99rcqUverzHozWS1hWpqApm/w9YZMGHwsqUttRZu8INLJtPWz9o
 7Jibdfp3CSXND+z/sk0vgnt5UmdroXHh5W9odNXn1P1E7ADR9fCMvk+Od
 Vw7MT178s5eBUQi28Xas6+nmVUslLY4CPnoHG7gErXngFESw8C0CzOLHv
 ub5a6a9B0OzuJBKmFXKAIX7mSGYTIqNhDHBmUKG7z+NDS1YnUrV8eRBoE
 wlDkPUtxrKSxygWbNkPyOGhA2mamTvTBmSYwcBZL7hw4MzN1+ZGJHRsy9 A==;
X-CSE-ConnectionGUID: wHHsnUF1S7abz8cQWR7cXA==
X-CSE-MsgGUID: iafQ4nWcSRu9oXbxVNCq3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="57339833"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; d="scan'208";a="57339833"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2025 09:54:38 -0800
X-CSE-ConnectionGUID: sTTE08F2SDOXKsAtuwKDGg==
X-CSE-MsgGUID: HwvGdcBSQhyuhBddHSV/0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="149769488"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Feb 2025 09:54:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 09:54:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 09:54:35 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 09:54:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPU3o6vabusxX0LbUzynsre5n9lfP/I9wHA9jnBkpx1miA6wOIix7O4FEfMo9KSuLyzEU/5EHmugkz3yBw2OkMk/WZh0NJNnoqtUmpYVtcWhY2xUEWv67kplOxtcaGyB2gPlAtcr7uvVpdcomioVsLxgcF7Kxz7OSb5MBegoDwBYnGt+kDyAw21L0LjCzi5UiPbW+HfBBLYsWzPOD44A+EqlOQ1pIDL/NUUqxdU4/Axg+wKofw5qPnLo3VZe6BPiryilxgPzUcEknp7KhjenPgfQB10T2AxtPdDhAxVVRvGTkR/W/pxvzLaIqHLZPzqppCFZc5fo3O8ElFEFxKvE/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2cTIrdRFN3DcRRKRBiO5viPRsvdghcwg1rsWzfwbGg=;
 b=YkS4mvZxpn2iK2BqODKLZbFv3jwLfBpcq4LRDL9UCfmzpJGV969b78SB8EOQo/FjddErApBFWDED1Bm5jSG8QFjZfeWNnOWM1JzwM5GKYMOfxprolR9Rv7gPkQRHw1qZ/W66IczR6dG4AkbE/7F8v+bQq3LGmMO+wIZ+Zwgbf89maBZiEjU7hBNyUHTKCOnBneudcGOVO6Q9WIB6wov4DBZa8Gg7VqSinC6snvWjDc5+ihMh7ok/5hTMvXitwETUXFUEDLnFa/Es9qx7O6I6bd4dlBLIbgijzJvkCogKZFGA2soOHR1s4OJ4U+qWt7reiZbYHTRERLv4YCKwLkrKrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7289.namprd11.prod.outlook.com (2603:10b6:930:99::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 17:54:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 17:54:33 +0000
Date: Tue, 11 Feb 2025 17:54:26 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Shani Peretz <shperetz@nvidia.com>, <dev@dpdk.org>, Parav Pandit
 <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, "Hemant
 Agrawal" <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Rosen Xu <rosen.xu@intel.com>, Chenbo Xia <chenbox@nvidia.com>, "Tomasz
 Duszynski" <tduszynski@marvell.com>, Chengwen Feng <fengchengwen@huawei.com>, 
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Tyler Retzlaff <roretzla@linux.microsoft.com>, "Jan
 Blunck" <jblunck@infradead.org>
Subject: Re: [PATCH v5 2/4] lib: fix comparison between devices
Message-ID: <Z6uO0mlaIYFekKGZ@bricha3-mobl1.ger.corp.intel.com>
References: <20250129085416.226718-1-shperetz@nvidia.com>
 <20250206000838.23428-1-shperetz@nvidia.com>
 <20250206000838.23428-3-shperetz@nvidia.com>
 <20250211094832.0b164537@hermes.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250211094832.0b164537@hermes.local>
X-ClientProxiedBy: DUZPR01CA0342.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: 6179ca6a-0409-43b2-173c-08dd4ac523ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VReuCMhJ9Y9BxUyuF4bCsllpDcq+mPSF4DmOEQtwAnUqBGiL5RZZVe/yEHhN?=
 =?us-ascii?Q?HflKDPnbUDFq7G0qGa+y//5fNPvqxYrHXY0N83Fh/SSa1s3KrfSOJ8SKMfQM?=
 =?us-ascii?Q?As7VACJOrJvl5rAIeE4k58/9lLDt7UoyrKhghB6ZdrZzR9SZPDEKF1XIL23/?=
 =?us-ascii?Q?9cwTHBowmgG5MG+vEkcVZQTdMnKdQNuyloyhjz4mIVEKhUQr029+a/xmJOvq?=
 =?us-ascii?Q?ryc3gBhcfr4SX/mX6B2K0hOikEyHdIeQ4qEbnX8gqUN+dkhHL/cynP0VB153?=
 =?us-ascii?Q?7/LY/uN1TXxiZsbBkNmSp9EtuLqVgnRGPZsfU8Wx4q89u8sOWgKmaOWF5WWV?=
 =?us-ascii?Q?I24xPx4wnzpQm/z8OBxFH9az0UTcmZv5JxXzQesuKyaydaUTsG4FfVN63ZkQ?=
 =?us-ascii?Q?ELt2Gh5D1BL4IfBZ16HEa66qp09xGQnIpjRL9zM0bjX/IDtf5uzduCKARVxc?=
 =?us-ascii?Q?L43U85Tl+T1LtrJeAN5asEM/PVtbGEN126STvD4Pkch2PQU7QEoysSQX/SM+?=
 =?us-ascii?Q?CcT6iW4Z5vxKe6QXilBgnRqC4VTrpu5YfAB6w44GM4PwnDpWqffE1Cby6SgV?=
 =?us-ascii?Q?KzjtSTVeA28Vg/WMQ7RXe+mDylVCSZwCkoz2QmfKOUTOTg87D/AM+chY4YSd?=
 =?us-ascii?Q?bLE3RZRbz1HN7N3GU9L4LQ9FkZv2c5h8db0IdsHKa8mORpkxOd6V7RW32vuA?=
 =?us-ascii?Q?48KkAzoW/iYZyhppvJeplLTLLKiTWU8Roexs0tJ6tf3b+HMcmP0lDMgs92lX?=
 =?us-ascii?Q?t6RCdt1bnYpfO3G8oJGoLfOWVt21+K4QRKrZZh5OqUgT0YSIIond34wkypDm?=
 =?us-ascii?Q?L66i9FdOr1EUS8KPSUSxahFY+ElOl/xtVkY7VtDojwMZUstjwzMzwM52cbdQ?=
 =?us-ascii?Q?NT0kFWiozesJtW0ci7Vu7R/YiTEBvqHX7zcFuVebp6zdYN0FmhUPdL2esURx?=
 =?us-ascii?Q?trcGy659bBEvz4oQh7UJiDE2un1f5QV5hSytpTh/zJW7u3zWYaC81+HDUfbZ?=
 =?us-ascii?Q?Bcj2enJTdrleEeEQjnCtmCWu4qOj8rmCKqY0LSWh0Zq44xDVT1ftTEdHbY4S?=
 =?us-ascii?Q?aAwcD0Y3X0ODt2g/bGwmhNpVw4C2OpK3fTPJ1AdlaxY3+DT7+hA4ne3Kb05E?=
 =?us-ascii?Q?oBvt2y8X49FLh6zh3QYyfM306UBt1P8YLS1PviAuNXi+fAXvcrHQLlLNO3N3?=
 =?us-ascii?Q?F+fw5av/cjjPUeC4X03JCdTZitFfOycZI7X9WNDwdMpC4KEutdz89y6cVzM1?=
 =?us-ascii?Q?MwnsZX0E30trqrw++rmkEujwirpS8/VXCCbq2eeHyFxVqVFWq9FzI4WT+ZLX?=
 =?us-ascii?Q?O00RNZVSgN/blAEFQ96FVXpyBGRJ6gQFzw9o9Wx2aU9t27BNhJPgTTQ5OnGF?=
 =?us-ascii?Q?IwximNUFk0lwWaSA2w3lzjhICoIc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bmu47ckiCi8F7t3ZChqAjbMlk8fzEdWPKbLdoQVMVhDjBcMjzpHLaB5Xsj5l?=
 =?us-ascii?Q?kR3UsH7z46Kh8FNmAOsU5SOlTrhlSj+KBpBsIFGyElmffHufeL+/GeHzT2fl?=
 =?us-ascii?Q?tSGd5b53tRiZa6GDod5hsj8Tcbp3uCPH4LNHV0oI630SM89uPJScpw/6K3Q3?=
 =?us-ascii?Q?ipHRkrkpv40hA83TmP4sODGYFwxZ7WqOpoJg41bzKIO+hkZVCWM8fo086psz?=
 =?us-ascii?Q?vhRpIvf+UX2zPTK6MA7Kg27Hh/+zHnoomZo1nDL/nRAU71Kgg8vYX+kzAm/a?=
 =?us-ascii?Q?0uWQgvZEGoB+255pZhEk6KsTysxaiyamFhedE38JjGRJk3+Z9OLPVSJSutVa?=
 =?us-ascii?Q?bFJtuxroo/XY0cWo6NuHG9KdYWpiSZejz1Wvocq8HyKi941tAw12q8Mnw4vx?=
 =?us-ascii?Q?xpe9KvY28vNM7v6TpPjOdaWuXKAUUnkD0at6XTYf6uUUjVn1TE9bNNfmnGLZ?=
 =?us-ascii?Q?JYgS1NrkheX16ouRBNImlOrOOBHxchUJjqL1wjHv1VuPjm++mhRe4Q0OCuKU?=
 =?us-ascii?Q?jW5V4STGUUH0R5EOeG7E2h+VmFoOvAB4w4p73IT/7y1JzulknVpyuCFVe3RI?=
 =?us-ascii?Q?M+3zmz7wo7q8TVq6fsOht/VjPVGdR9jT/w5JugCvltX2rp5Ljk+kLYf6fZ1v?=
 =?us-ascii?Q?4i4FNst+YDrcVrlZtvd/i2PgIRO7Ta0eJnbz23aEL+6Gec1F2diDlA87XR3S?=
 =?us-ascii?Q?BLpOySfzwGi041+fP3I8ALbgv6cHWQbSCrrSUWEYZe7ER108pliPzBRRx1ZG?=
 =?us-ascii?Q?+odFHiFHE3iWGDShPb/wTXdIb358xF3DWnz0p6/055oxIqa1Ek+JUYkILF/d?=
 =?us-ascii?Q?mEdBoXuJF7udwv08n7WY3XRO9mcdizcWQ+aWir03gad0cXzePL9WOHHoUTSi?=
 =?us-ascii?Q?7O0QiADO0No/v7eGHhsK6eHuN5w0juOQ3MjlAdHE39g05/rFaJYAwAYJ0FQp?=
 =?us-ascii?Q?zPZBGhb4ufPTy5h6Y5SFEfIjKbR+b9NB0crCnZvYNMqzUoc3xjlA5JHAERmW?=
 =?us-ascii?Q?wNezt2KYWhFVB3/vRLvkYuDItg5KoX4Fvws2zhwn75D3v3niRyH5pqicP+8Z?=
 =?us-ascii?Q?wzQjqW9+RNbxAQuyPflKXSjSa11RsKIjvPtF4kAKEDJDXymo1Y9ByMZDYVkf?=
 =?us-ascii?Q?ZGY15BFKiAPvSBZpb9VfKVs+oTKZxGt8u7+KcHEioyqEJI+3ZwfH4xgVTx0p?=
 =?us-ascii?Q?f9BiBbPji8VCHb+5qZXz+LGRYTvnPLgVJqLbRmm1xXKOoEe8OY5RxS2Y61hS?=
 =?us-ascii?Q?hMx7KNL5941zgJmv4E3GSiMOGMSQ7lypeZqLH+NQLH2MZI8KKRZEgNyvwXDW?=
 =?us-ascii?Q?5Tb/EOFZixyJIj7zGN7HDnax1ho9lpBP4Y4OTSFTSbH3B4O0U4wQERZoExhL?=
 =?us-ascii?Q?xOWwuEZ6jwUr9zsXLkkdptBnCxo5nzpqY2JcJKD6nADchLZscRRl8KRQ+W9K?=
 =?us-ascii?Q?GuHalrRnexomKjSllGUX3zgrmXiFiGNWTw1ph/vjzlQGvl003o8vQ1JcheZy?=
 =?us-ascii?Q?dfkcjj3ukV+AB3XLVOUlVCtS8cgSfQcw4TY14AbH/7xsclw9Rd7R3xp0Xd2i?=
 =?us-ascii?Q?BWJhGoFL8Xp3KzRiooPD5RW1HNQqsUzuQ9GCgZremZIQD1O5KlU08y2pJ8jC?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6179ca6a-0409-43b2-173c-08dd4ac523ff
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 17:54:33.1879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+3Mr6vD5KTjh4a8tjQ9iXzstX7L/latUPfc/KSL1GT8LSNwOReKf52eYcH9VaA4G8+9NlpCJyfMh5qVD6xiWlBjYoPKlzWAQ6Sn4RHKjzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7289
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

On Tue, Feb 11, 2025 at 09:48:32AM -0800, Stephen Hemminger wrote:
> On Thu, 6 Feb 2025 02:08:36 +0200
> Shani Peretz <shperetz@nvidia.com> wrote:
> 
> >  static int
> > -cdx_parse(const char *name, void *addr)
> > +cdx_parse(const char *name, void *addr, int *size)
> >  {
> > -	const char **out = addr;
> >  	int ret;
> >  
> >  	ret = strncmp(name, CDX_DEV_PREFIX, strlen(CDX_DEV_PREFIX));
> >  
> > -	if (ret == 0 && addr)
> > -		*out = name;
> > +	if (ret != 0)
> > +		return ret;
> > +
> > +	if (size != NULL)
> > +		*size = strlen(name) + 1;
> > +
> > +	if (addr != NULL)
> > +		rte_strscpy(addr, name, strlen(name) + 1);
> 
> Why use rte_strscpy() here?
> 
> The intention of strscpy() is to handle case where the resulting
> buffer is limited in size. By using the input string length you aren't really
> doing anything different than strcpy(). Still unsafe if output (addr) is not big enough.

And using strlcpy is probably fine too, without having to use dpdk-specific
string functions.

/Bruce
