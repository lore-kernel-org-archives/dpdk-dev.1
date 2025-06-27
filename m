Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2FEC77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 09:11:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E06E4026D;
	Fri, 27 Jun 2025 11:11:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 38F9D4025D
 for <dev@dpdk.org>; Fri, 27 Jun 2025 11:11:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751015485; x=1782551485;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=moU9/8a40C7F77cfRCqA0u5GWXIc9CM4eFBqcvcSprM=;
 b=cY1F3t//3QCVGgg6NfZBs//0Fg97i7SjN9mEQPz104B85iJPblwaKXRR
 nVQUqnkIyFaIeUp4V7SJySzFe0QgSshyTVzILusGQic9MknWV8Os4ClfL
 TlpEWAstBV1ankYbwlpI8RPNrvAEEe8ICWrWHf+MoXK/va6saCZl/qCMl
 IrjcQ3Mq3Rc2FRIs65Gz4JzRam5ZH8DE4DHlrBMbGi0mpVXrMDoXzcjXw
 v+1FtpjTb0koWcI9sE6uYTAPUl30roUgKDHmsKX3fdL6FH2hMqgp3EnFM
 HrB1z2KbEH/2h0TfFIHrALX5lEvJuSlbEqotEpwOKtjw45Ae49G58BsMM A==;
X-CSE-ConnectionGUID: 3helk0uFTzOzKAl3LWWvSA==
X-CSE-MsgGUID: ytPGJuLfSqe7VDDhBTB+tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="52445231"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="52445231"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 02:11:24 -0700
X-CSE-ConnectionGUID: 8HNwnLQvSga/BnWVGgQh8A==
X-CSE-MsgGUID: oeWIcUBpT3m5nwiNR7EgXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="153464482"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 02:11:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 02:11:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 27 Jun 2025 02:11:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.82)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 02:11:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLm4FarZECcdLi4aNcemuszaldRAzYvffOcspbotIp/XAGKSDpP2ysvM1TvKAhxqFW1adWJPKJJlwriGXZGZKZBggudPa3KMGIKGqlC11A12Sj5wEsEyXb7z4hXK/G+eJPrtFeda7c87r8dbwPYFsbY1fFnEgqqn+FpVvB9xg2YUOwb5i7w4X1jO43NCYAAyxQ7shssZGml8EAOERVu2TrZoErLVxkszEI57mRQH0CQCl3OGYsyfni3XnZntcql/U2T+ihIXfh5nYpYRJgWtfTMsLY37mPH6pWqeADD1dFqVg3FAeEIKqNK7qruRsWtF40AF/Eui+zbM0lZCSyoDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fIs4PmmPAOZTKALgnKXAGHgW03VZQnZT4oBhwxneyk=;
 b=uaTLQB84XDK3qmN6cSdhTkq/Hrh2ZU7vVyd39siyVUVuLUD05RHlCykvBWVR0o27m/5JI0pjH4UMS1CSezkjcEce/HB+VYZHBNVJgGC7K41RCmgXNDkpWisavOpAIgBqTpv400J5P/EYqtJP8zoc1b8ybjumlIxzg+euLGZ6MClKQqlKdeLFmEmdhhzcIhzmoPfqWhchB6gE24OUoRbZz+PL0+Zi6UAyFGh6sOBPILEnSZGPpLtWutDZ0x7Ntuq9x2Ka8p1YlUB8rcZYyGQFL4gjbJbBP5Rd7USJqfVdAHFzDxRZPZ5QSoUuy7FdRewP6mph4zdnz2xAglXo6fZLrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6897.namprd11.prod.outlook.com (2603:10b6:806:2a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 27 Jun
 2025 09:10:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 09:10:52 +0000
Date: Fri, 27 Jun 2025 10:10:46 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH v1] net/ice: update null check for TxPP support
Message-ID: <aF5gFus_tZRlSFzn@bricha3-mobl1.ger.corp.intel.com>
References: <20250627002044.632971-1-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250627002044.632971-1-soumyadeep.hore@intel.com>
X-ClientProxiedBy: LO3P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: a5cc6f20-cdeb-4195-50ed-08ddb55a8435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?28qmNWSjknVrCwBIfbcbf389ur+Cxa4xGv1c8RXbS4wEbbW8rJZFp5cRinMl?=
 =?us-ascii?Q?wby8oCPiGWQlb2Jys5U+n3t+2ACT8bDXYnFEPmHGd5QaUvENvn0D9Cu+Z66G?=
 =?us-ascii?Q?Q1rYTk99WFHjJZeUiBqLBpBhynYVFq5FOod2Q4zA1FeIALG6x4qI6aEA9wNY?=
 =?us-ascii?Q?XFlPhWzJNXl1zc4Nx991z+qSu+MIOaFlO5oABGEZPaqOzk0WqfJ5Omu7EeL+?=
 =?us-ascii?Q?wb6BK9+LBGbv63UoFzY3uXiSzlq6yIi8Unto1wd1JgBq02SMiirLVNnPEYk3?=
 =?us-ascii?Q?SyAN0T7RwqjvebDqx64s10AroyKsCh95vTcxn4OjQOF5fkwL24Zp0wHdX8GM?=
 =?us-ascii?Q?wOt4w/pPGdi4QuwNZRj087SE2vAcIGMG58ScJpsVs2uU4OEbqhYQQt0b9Xp4?=
 =?us-ascii?Q?ae+4geJy1ddLQTn3F/yt1owR2igojCsNfVfE3MmR7+vD+G+4+CoQSgrjFQH9?=
 =?us-ascii?Q?lkrN5bN8QtTu+WDrfh7huAezIJC0maSnNaUKbrtV6LLyglroKcz+nMgWNZ7K?=
 =?us-ascii?Q?uxn7JM2SF6K9RWVzmB1eycDKdx4FJy4RNDQnpa3H5EQFM2WBCfu12daf1Xa4?=
 =?us-ascii?Q?O9JTM4gqniGM7YB+5gg+izdV9/mCkixoH2LcqhJz0mQM2F+d6SNJ+DJ9uVnv?=
 =?us-ascii?Q?hA9JCEQ3s4nX2kcFHp/2fKYKXQX9SJ6YjFRGr8WFBJu1Y6dHuhSy2/PXFy7R?=
 =?us-ascii?Q?/nrm37crzyVD67cGLdPB/7FFLi8sKrYVG+L5GJoT9i82TbLNFAKJBqYbgyIq?=
 =?us-ascii?Q?mfwC7p9+f6F+qPGKDfeNdRSmUQMcmU03FukE8CYxZT65QBmS7i9/wmswR/By?=
 =?us-ascii?Q?USchwjgcWa1gS0E8hLggKqJH2DmIB3sTwpR+O2BMWqNjojqfW6rM+Wpr7GM2?=
 =?us-ascii?Q?cBRUERKIHYYjDkgLDMlQ8Z1X7eMKxwugMlajcIYWf2VDyeclb8V0WODiL0uI?=
 =?us-ascii?Q?ZGZqdrFZA21xY0BjHUHCH9asvrg8fwlGoy5liT19sQZ6BiuFcZESjEWp153p?=
 =?us-ascii?Q?D1fNSv1dkJx1nKnHs67coggI/RaoDEHS/hYL1ngc0CHZNf+qF303YymTM8Yj?=
 =?us-ascii?Q?6U6Un4J3zGfU3HnEjMNVz1eq1nZjIatauP2dClK75nKZv3fUoQDFP0cpMJRf?=
 =?us-ascii?Q?wRRs7uTyXWNpzuNVP/PBH5VljxIuVkr+MAYy4DEEgWgGX5s4mDzLomoC9tTJ?=
 =?us-ascii?Q?rmEcLR0erljalVtjGUxWGlbSIJfLrBvzqd5Km+hGCxDjSgmBCiDfou+tcUBK?=
 =?us-ascii?Q?fMFcX/oA6ZrRydBoWRAzAHDVb8lsNpRFPi9zheAJgOlsyaw4ft3yWGLZzAV2?=
 =?us-ascii?Q?ATbMGr1Mc51TbaWOwVDlt9+Z13TmHEe3pzRgvJHgfjO2g5UElruM7ZyxvBgj?=
 =?us-ascii?Q?q1mSjS+X4WEqF+anj/Gk0INL+bF1DzN79h+YvcCEsU2mXSlYyg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vC2DR25FWeeyyy2zOzNbOduSeW2z6jb9btK0NsVccG8JXY5BNJX3PH9JkSiH?=
 =?us-ascii?Q?yvEh0jd6fC29LvlRZ2d0IAKDZMzL+DoP66zXVGXv2BFaX6JODYnBiDtY8mVE?=
 =?us-ascii?Q?UlAgrK7V/ASa2fhZCXK5LOXzT+DO+HCpL32Zz2tWYvTWl8MICXE4NQcfLVte?=
 =?us-ascii?Q?uurF5YTQ+joAHXg1d8WQy7lRbw1006BQQpsbKHTOujw/F1a8rnA43Qg+ccv3?=
 =?us-ascii?Q?c4Wg8PGFNR3VD7a0hoQq6KyHuOZNFMaIn6iORdT3PzkpAmGJ17NZjjS+5EOV?=
 =?us-ascii?Q?r/nVxv1xvKGNqOPln74KFyrMSHcd7akNnDxoRDLcdYPGUcbQ1IZqnr+JDvcG?=
 =?us-ascii?Q?IbRLhckSQmxI/L6UlbQOhyrRmTBJUSkBXmi3ouVb95xVga/7FdJcLX3m3PDQ?=
 =?us-ascii?Q?aXn+CYUWx96ksPX7HOybtBtcwGYUU16qh+gnvEnVstGGxw3cIm+IHsCRJQIO?=
 =?us-ascii?Q?XJnIznYmwbGT1K5dMKZm9Lfp1+kUyPuYOCi2FGlbmSrskpKlfYedkIONZO3C?=
 =?us-ascii?Q?7VHE4HpJaHEqpie5QY49FcvBb7uXLvWzRYF+pUt5X7Kcy+3H2Rz8DHZY+VTh?=
 =?us-ascii?Q?NLBosaHInBrNC5dOiYP+00bR3uTr8EhlbEke5P8YWlf4WOWLhD4ifVe/mY9P?=
 =?us-ascii?Q?hwMlGF1dPRKpp/2gl3rzuRjWy7sK0SwJrQoBzBdyKqahLsEgMLLCwQblasw4?=
 =?us-ascii?Q?JGvc0WtJMKPtcVDwD7qOvFsB06h288WDGYTjmjs0ANPK+K2bFgAsWTnNBv3C?=
 =?us-ascii?Q?J6mUvaFrgRiq7J4cWvpbaHMqTDDYvh1FZd4jBr1I3yiOxswo/bibVPDoYgie?=
 =?us-ascii?Q?LD8iJbDE0Jn+DcGcYIjW4t/5IvYRNUSSEwa076WkeXzRtVwq+QXJP4DzBJuu?=
 =?us-ascii?Q?UpaIUXne44nEO/Zzu8uq7YqdWshUBcIUL9vC9M/z2bZpBgTi3ywo0t7MeDKm?=
 =?us-ascii?Q?gC4AylI+8GEhj1mvRsV6f4682ZyAZEoSMEPfTM7P+WrZqAmWiIsf+Sylumbg?=
 =?us-ascii?Q?+mFJPWsMV66eu8Ylqp5KjE9lJ45fqxEY1aA6MZCjnPBdE9xANus6zcwSsFZa?=
 =?us-ascii?Q?PduiX0AhgH0JQKPcx+CS0T/0TD1B6b+B+wlOhMniO3QdURPy9mS18t8+Pg2x?=
 =?us-ascii?Q?VnfEszBiAuZndghxdu9zgBkkA2cgWCoK2pI1F2Kf/vwdD0baojOq4W7Ziob3?=
 =?us-ascii?Q?EnKY0GhL2CbWShr46yifBFilMHgrBGa4R0U/qewIhCtQiiAkJ/agGCO5sWpe?=
 =?us-ascii?Q?CskRQitLQlIHRPZJgJchgIiZkNUQGfPF8PoUJpl5epe2mqvA+jYY1YqhdWlF?=
 =?us-ascii?Q?HlCClprspKa4uBHIJ6aSfyDIjmtw+zIFkwv7FV5vimYs1zh98BMD2cjcGc2E?=
 =?us-ascii?Q?MAqd0IM+Re5oseCedKb1JgKUTsUpeUe8S0DzrRV1qwDAWY1oJ2Bv4nz8N/dn?=
 =?us-ascii?Q?kE6SviakWT73m81p2q/YsxdUhxjuUmSawvq3U+wxR/laA5XbHQUo8GVf5eq1?=
 =?us-ascii?Q?30bmHcKHsX1Z2LUSh7ePVhWXMFywVXXosMGlUapctoXkwzqKWGjqO63bGUmF?=
 =?us-ascii?Q?5uOnuyCKPrkaqMxEOnPXI+rIiJPJeB9nGTwxG+9VyFxlESDfGpTP2eI3qBoT?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cc6f20-cdeb-4195-50ed-08ddb55a8435
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 09:10:52.7729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PtHa8AIZB2P5sRf4bZEVVxyKibmKsrlAruTVz+FUhP+2xHzq4KHqQqNaM5gwMxs1cUkfCbddADMYOmSphsnr9bn5WuCpf/YggtZQeECYC4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6897
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

On Fri, Jun 27, 2025 at 12:20:44AM +0000, Soumyadeep Hore wrote:
> The absence of NULL checking was causing segmentation fault.
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  drivers/net/intel/ice/ice_rxtx.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
Patch applied and squashed to original commit in next-net-intel tree.

Thanks,
/Bruce
