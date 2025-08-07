Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691F3C87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 18:59:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7521F40270;
	Thu,  7 Aug 2025 20:59:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id A1E1140150;
 Thu,  7 Aug 2025 20:59:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754593158; x=1786129158;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=8GO76wi2DhEjlb056g+O5wclbI4xV9FOP6Stw7LW3l0=;
 b=PFC4HCyQN5/WnxAarNwVVAz9o6RVqc9YlcFPD+xwjIJXuzaYXL5CP1Gy
 Kp8QgdvbqcZxKipSiU8f+vApWjiCCbHxSfhgd9Q79s18LVbzDIYPtMEBs
 f/sE/VmDyQLl8I16T6d+sOj8n6eFniYqn+izXk71qH6Mx2UXfFPzu1XEf
 QmA6qJFHGGawM6StWjg48ZOdAT08poxSFG99HwnrDEYwZc053vqlPJgAr
 Kj2BebEkHFLGpQGnVzTtfdpPqWtdzKjkp/cTx4gl3poM1r0vEYzygIvEk
 mGFSX5ZGgVfjcSB8vI3bWIMaQICKaeocZ7dYZIXjcKqcYs3I1ljmyUscD Q==;
X-CSE-ConnectionGUID: 7pT2YRNGRRiJLx9pCuHQbg==
X-CSE-MsgGUID: 0AZcr5rgRwGu4jslDe9RKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57080824"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57080824"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 11:59:17 -0700
X-CSE-ConnectionGUID: 106/4tagR02BJfh//v8yng==
X-CSE-MsgGUID: Sa2NPxNLRB+jmGYg7QUo2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="202301334"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 11:59:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 11:59:16 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 11:59:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.71)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 11:59:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLAzxD/Yh6UbM3IKmXTFGsR8rWepnY4dW4WC0i7wYLfAW3diNWUAlpAYoQDJ2BnkhrAqb6f/eiJm66mdkz8hBhifsHHB9OOGvLQqTfHRtsSIBf6d9/IV+XxfaV5Jmq3nBc8gEYgNvfnphZvjwUbYPtNFL5USxmvyxF6sOZtHD0O8NsqApr05yK7AvTseApIkaDofAcieeYVXrzRQprRxUQJdksNZa/h3PtpWZPXgK2VHVyD4IiC68hJYHyIPo7tjLDJSc05bIZ6nKv+huo1cVyL0lOUMHfpBHukyVBKuJkH5bWn+Ixz2FHfM5375JOl6mrWeQXA3OxsHRfOqyRWuiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlrqe0xoa2UYmV7Y1UHyb6SJ9vmJaqlyavg/0UIYk+M=;
 b=wL6c7mO76qK+y4Snv0UXj7DA/TzpuzszpbSPhjfhxH9NfYxPT33eMcKS8UbIcI2oWq2c/NTZ4CLK2woEYROwLFWaTXq5GVSEeXW9Y/Ccv0oINysCX2KIz7DQMi5L3iDH/RWxK77jx/xsjR0oivK8LTDv1qq2jFNs1YuJnj2J+Ffwi2j7wRD4bsV68BZT/eIqjLL/PAfXldk0vAfogaYLeIQSv0DMhxvNcm+5pKijqEjcGwF99RNevKP9dVXHEG6DkEu1cJORSzi7UDzEZnyvrkq7rLiSVErKquRVHfcxJU8KDXBJWPQig7NMNVfESOt4+Q9jYhQ9oh+TYx2BTkWHfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8187.namprd11.prod.outlook.com (2603:10b6:610:160::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 18:59:14 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 18:59:14 +0000
Date: Thu, 7 Aug 2025 19:59:09 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH v2] net/intel: fix assumption about tag placement order
Message-ID: <aJT3fdWUFb1agmkg@bricha3-mobl1.ger.corp.intel.com>
References: <20250716173922.688476-1-bruce.richardson@intel.com>
 <20250718154312.1716432-1-bruce.richardson@intel.com>
 <DM3PPF7D18F34A1F6C722854325BC750B9C8E2CA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A1F6C722854325BC750B9C8E2CA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0038.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 6797ad4a-44a0-4508-0788-08ddd5e48055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MWPGFMNA9nWV/K/AeE23h5oCNHDAt8LwUSbtTJPiq4RABeWo+H9xLEuKeYxZ?=
 =?us-ascii?Q?CQPtHBrGeVVYKl2YajnMt0574+tPAinFMLjbpHIqtGjDXgbkstwkxCTplphI?=
 =?us-ascii?Q?AoktzS4wQzFtam7ONI7OVWO8NOHwvslKFTNVg+lh5w36boKHpbp8AMayOBNJ?=
 =?us-ascii?Q?ime9vC7WZBqUXOX3V7dmr0bGccrItpzhvaAqcFsYAKLHxpxA0qYhf2IAAtZP?=
 =?us-ascii?Q?/lK7c5pglOYv60PeTqMDzG1zc9mT7gXyH8eHh1nEwHWJlvqDAC8f6gPSfN/C?=
 =?us-ascii?Q?7OJ74nmM3ajhiwnAFb8TAxUxj0QOv1AxO3Lq8+xNJPEYsuWGwESHWBftbe/f?=
 =?us-ascii?Q?rSKhVOE3hmXVYNH56lWFEAbrrh6YUX95kSYV4MISlkeNEDncr4iibFhLMF1C?=
 =?us-ascii?Q?6YnEoL4yUjzJsXgNHYhuVrgeI0Akanc+jNKFCPGoLLzk6YMOoY6MQXABR4Dr?=
 =?us-ascii?Q?ZGS2/RA9wpS3lN5BsG+umm0ezILUVd03sch0wpyB7xPtrQHZ7YSKKzXN6sku?=
 =?us-ascii?Q?7O9Y5OV+dlU8ycA4idgHCJs2atxR1J7MzLXDQtbZBOXSIaDKv1zpBgb6s46i?=
 =?us-ascii?Q?NnVbJ42Uh6qAh8rzzvKSjLyaoSTAdoDJiXyIqgV+vnlNgRJZix8uYY+4PWea?=
 =?us-ascii?Q?Ud5nwGmLFVLpKD7K3aWZsRDhz6GOb0ohGmJNZH2awiL0yw6AM2FrnYfKk6a8?=
 =?us-ascii?Q?ckcD6U5bf6P6Qw1mA0gUZ7+pvPMoKrZn5oHQ8P2rPYLkXuP8X2PLt8tqQjKr?=
 =?us-ascii?Q?mpP64hQW4cDbgDf1iPYNdYTgMMlv6YZOmTrNt1uRA6dSmGwUgncO/xnqIFO8?=
 =?us-ascii?Q?KGrE4Xsjrxqs9P6IxSDatsG1+B365WwgmTVV4L84npSrjlju1n4DENunGDU2?=
 =?us-ascii?Q?lcaESyWL1Q9RREp4VxSuIHe4Vbzi62A+fn3GiHH3OsUBamYNDn248mNeQkZN?=
 =?us-ascii?Q?PZEd+C3NipaTB6vZGaW0ru0LPCp5etq4dZCVSIJcGNXU7Bb0eCSvNC4/rJ2H?=
 =?us-ascii?Q?g96uuYlH/WLZjdnyxeiV6THJe2gZMNMUDSf2BX2y6gf3Js0FneBx5c88xibk?=
 =?us-ascii?Q?UGsnuLGOBvds/v0a1flgo2hUTrlfaBxBVnOclD4DMw4+NLdgzP6KqAqMcBdt?=
 =?us-ascii?Q?MkR5KkEdaI5/9eMZsMgIqFFpQfx97jYQ42DLPYlFzOhzqOQoHPT/xsU2E9+2?=
 =?us-ascii?Q?734GcaZ+riJLViujndRLdMqvYyQwOUU6WZrCEsb737C0PuslQ3z/ANVdwZRN?=
 =?us-ascii?Q?mrrAUdPQt8SWYcud+mqes+yuYJf1LENHxJzeEsbhbGnUI4BksD9k+jUNFFgA?=
 =?us-ascii?Q?qGPLoHfHv/J1Ffz5D55STo/qRAZ6g9djFEHsqkZEgPQXZ9u1baQ7oox5vLyP?=
 =?us-ascii?Q?aAMp0EYt+btojtZgm1/qe0dWS/axaTu7zQNi4t/vspcGMTo2Ch/dmoNoqJoI?=
 =?us-ascii?Q?gJiZO2iHyQY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?570bupBL0Mv7GXWxutl/diP8DjDe4TVyyQPXlXDOElWaCDyE6GDwymLScu/q?=
 =?us-ascii?Q?DYtjablaG+1WOMKXFesK8lUknW+NabJqNFi7Bem82RZ5lDRkmby1tz+vUXUY?=
 =?us-ascii?Q?mOIrNYmC0VBbTpHW+21xLmkQv7nA4Kv64quuWdvuoNQ4OweGjv4AbyJ7U7+f?=
 =?us-ascii?Q?highQgHmkkMqRJIlMXseDBs+gpgaAAGCLSo8/SEX8k54sYzeIPVyvF5PaRKm?=
 =?us-ascii?Q?g22vI9qlFIMv4c0kBxlraFAe8Qo4kfAZ8Nt6xVAUECitHjvR5CChV7S/rESA?=
 =?us-ascii?Q?nk9o1cTeJ05kQCqp34dq/REJT7xSNS+/9djoN6l/C1Rt6aMegdRfKftMGtpJ?=
 =?us-ascii?Q?VjfPnx4gytmXDrybmpOKlF28MH64jJ0fAEknad6cL4lrhXyHcAq5KKHIATTP?=
 =?us-ascii?Q?K+1bZ/9IdHPxUAqf0uE9PozHpIgC/Q1qHpQimkR4eCJyWZRUQk2yajUkSwQO?=
 =?us-ascii?Q?QzS7RX8zbpx47ftpwEJd71oc+Yow7vbOZ1sZJmpjN1WmlNxHx83ecj8WNAfs?=
 =?us-ascii?Q?Qh93N/hDCke353C1YMN3M5JFx6r09TOllyhvoi56ouvStIdOFT4kcRnOoevc?=
 =?us-ascii?Q?HPUET6Cjz6DueHK/caBVKBtQRFV+a2iyb6ghWgvA3RWekrb0oOEfqtSKC90S?=
 =?us-ascii?Q?TTkGINlu8lZ9Nv9JV12UOw/5kjnjKnK6XWcTgd22YhvMTZ7kq7YM7GaejMhR?=
 =?us-ascii?Q?sX5XIBR+8fuW9H7fVkpLrHq/0/TgsrWridoKh92UoOZFriSww3za+QysbP7z?=
 =?us-ascii?Q?QtHcLVONDtycaJjgEBghP2xedhFtZuSh3kKfzNv2gnQHk9ar+oVYZOQUh1qJ?=
 =?us-ascii?Q?rKia+94GOJdhj1FSWa7GggeeP7UUYy7ifSHEK5BPzNwtU11mW6pWsHjQ+ihl?=
 =?us-ascii?Q?ab6XCmrvbH+Zt5Gw/2+55bp375Aadec7YbGtqEb2jxOeSn8wxbSvOQmPj2nB?=
 =?us-ascii?Q?ip+LG2blHljUgqrP+ndNAKQvlzssGiRw3U2ME7QRSvoTae2l58blWWgbbLDy?=
 =?us-ascii?Q?YrxV4RFCkRNZdKzKffvS5WoxYHqWpXTt3WXAWLGYedo3tbdtjPZi87dgccmn?=
 =?us-ascii?Q?qjvZdOfnF3o+ILdLgLVqxbnPGGj5fQuvvpvSIY1Jc+eUboS5HWhDo6hYWlue?=
 =?us-ascii?Q?7ypdLDOEt4Fn6M5jywCs73LvaTb4xs8Bn0HM1JffRqRRqXih6csK20CT5P0K?=
 =?us-ascii?Q?PiPzoJJOswOe10CjqUPHZqVLfdb1hi3pOQp1rCuoZ5QqwP6Ax7q5iN4eB8my?=
 =?us-ascii?Q?I17BNgxXD+ygEwiU6Vi04pCW9X+4GR22/SFgneZZTgvSCqXjwqX7PflnfuWV?=
 =?us-ascii?Q?c2yn+7KqCbvqEvPiuRwwoNXu/C5HxuxtInwcryrs6SaN5F5w26VploSIPFzd?=
 =?us-ascii?Q?lFWy+FNChKBH43Au4yKdwh5wpKo1Q+cXXVrt49LPSNHCt0Jdbx3VlOz97w3k?=
 =?us-ascii?Q?p88z4gsmbcRLer1DEh82OkC8EXKKf4J0tDFBTPJPM4RlCHu8PneAaOxrdwMb?=
 =?us-ascii?Q?89kldDYYL9aYuY2X8Bu1X2I0vvfgiZyoH2NIn4f1+pI72PVFPGOhukTMo8ht?=
 =?us-ascii?Q?LOeoKGeCiROYaTHqb3OzT2hZlueZKZBG4ZaN8FEO4MiOau5hs9WhdfhBqghz?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6797ad4a-44a0-4508-0788-08ddd5e48055
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 18:59:14.0170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+rN7NhNPd391mjwpsZSgkpAXcd2i4gyOr5glaYZ/W6mJiM2BQkJ8wE2QjYdbeaWVWfKTGKi3SO8eBOI+ilnRXldZ/PXHRi3o3Qxo8xPunk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8187
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

On Thu, Aug 07, 2025 at 03:31:11PM +0100, Loftus, Ciara wrote:
> > 
> > The specific placement of outer/inner VLAN tags in NIC descriptors
> > is configurable. Therefore, remove the assumption that if the L2Tag2
> > field is filled in, that the L2Tag1 must also be. Instead, check the
> > existing mbuf VLAN flags, and move tags and set flags as appropriate.
> > This fixes an issue where, with QinQ packets with different Tag ethtypes
> > (0x88a8 vs 0x8100), we get an mbuf reporting two valid tags, but only
> > having had one tag stripped.
> > 
> > Fixes: cc9d0456b870 ("i40e: support double vlan stripping and insertion")
> > Fixes: 1e728b01120c ("net/iavf: rework Tx path")
> > Fixes: e0dcf94a0d7f ("net/ice: support VLAN ops")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  drivers/net/intel/i40e/i40e_rxtx.c | 10 +++++++---
> >  drivers/net/intel/iavf/iavf_rxtx.c | 12 +++++++-----
> >  drivers/net/intel/ice/ice_rxtx.c   | 10 +++++++---
> >  3 files changed, 21 insertions(+), 11 deletions(-)
> 
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>
>
Applied to dpdk-next-net-intel.

/Bruce 
