Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97AEE909DF
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 17:09:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28A77402C5;
	Tue, 17 Feb 2026 18:09:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id A60B240261
 for <dev@dpdk.org>; Tue, 17 Feb 2026 18:09:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771348181; x=1802884181;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=DcE3bhA290lpvriDurJwB+lExvi3LLO2mmvBRgfwWsw=;
 b=YHHgeCmhvh50PCcQHhgqxkLHNacMz+nP96i+FEXi930K1m+ednVdEeQc
 aTLxASR9xfHndkQFapQnskquPuxIwTRxPSs4KoPifIWMgFloVdy6O0Znz
 J2kRCD2Ud/H80wqmAsAJ25BGqjBZrW2TunOXFBNPNSZaOL6TerPodmGGL
 qG+qOgiSnBJrvOrvNK+Bde8uss6AxiQXFGkpyuR0bvg19X8fT6ZoDpVdJ
 nBKG8GoKTZ7gLRSeJOCkMQvDmcMSipEYY0RGmfaUMroPotS/0GS5s4Y+w
 FNMelx4l0yLguo5r5v90nNoYnfXa9PWNU3PIehBb0d9xLEk7WzWrH0Bzg w==;
X-CSE-ConnectionGUID: eYthlEZ6SpmWe3X5EEF4Dw==
X-CSE-MsgGUID: umlG+FDDS6yCeC2QC36MQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="59989071"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="59989071"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 09:09:40 -0800
X-CSE-ConnectionGUID: 94k71zVNS7O918S+7UM3DA==
X-CSE-MsgGUID: MJoQmdxvQbmGBW3EylQViQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="251625991"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 09:09:33 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 09:09:32 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 09:09:32 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.5) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 09:09:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RD/LdkFd3GaE6ed2ErNvAVZf1GBNRCFyyfZpLwDzBsZV5K1DZ7Slf4SacdDaoXqllbmaLg5EEnQv0oAmCOrIhE3nUo0V44nD9HgP5kKrzkvKLAmpFsgIcBfzumKMD502d7TAldt8Ru13wncG4V3i7mn2hfpDZnIEtyofU6K6r2OPaV3sg1cMH+K9uIsdCtBe7REHWvfDadBrkdMRYd/M3JXTZkIQEJ5a+ZjZ2sU3qDoFAHnJcgIUwJtnQAUigsFV4QG5iEjuU2vOG8O2EegT4UGCp0B+N2TfwK9vGzuJNH6zI8DGly87MphH8Bf0DBtCFxAQ+pg3RIGdvgUuELFw3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YU7r+8JCfxUrF8dGkZLFBlz8yIOzCJQB8xq1WpsHJ8o=;
 b=No/QeNSsmjHtT6BYx3bDnv0ij/xXZlKsbtasMR11E2B1kaCG6KABBFZ4DkGdHk+JbwmNbBKl90ig6NfIo5DISCEa4Vg8g0jxPnAzfad18lzUWJG3O2YdqH5EgXzmpiW35K4hwmc2obXbtwTsHJ1XNDoTPomK1IzUvO7DcgKlHs7DYlkEORrk0ywvwMwhbS5uvFZWGqP4UsQM5xATMriyaVjcBoudPcYFMV2hbrx9j/7jrws6JSmFVtNuHnENXsn1LVOlOyMlcP/D+kXzBtirMFzZin6vu4ubbElKKzHKvOQ92CDvZPFxKF/2MHzygdE6eako/kEN6xiTNsu5SuQtTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB6840.namprd11.prod.outlook.com (2603:10b6:303:222::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Tue, 17 Feb
 2026 17:09:29 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 17:09:28 +0000
Date: Tue, 17 Feb 2026 17:09:23 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, Song Jiale
 <songx.jiale@intel.com>
Subject: Re: [PATCH v5 3/7] net/ice: add L2TPv2 protocol and field definitions
Message-ID: <aZSgwyBjSZI1WibW@bricha3-mobl1.ger.corp.intel.com>
References: <20260202094244.447966-1-shaiq.wani@intel.com>
 <20250826170541.5010-1-shaiq.wani@intel.com>
 <20250826170541.5010-4-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250826170541.5010-4-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZPR01CA0210.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: f3fb3aeb-275b-40fb-9e62-08de6e474f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0mPowJ6Vvy1CMVOHIjOvtgIzkcwjBDA6iwHulo3bGgBoFiVG8SMPZ/cUuiR4?=
 =?us-ascii?Q?jJ8xLg01Y7+fVAxhQ8KASWxhINWSpLtnGoquYtUa4Gb93s6Wq67VpMDl3l/U?=
 =?us-ascii?Q?zbbr/cBSCj1085je09tL3xUro3Gzahgc3Eq+zBA88F6TD918ZFlhwx/0nrhz?=
 =?us-ascii?Q?dbau52q2SJam7332+Mp7iHxD3DvfuD+fF7jPX94QwmU9eEf7zA9DS5O6yC8Q?=
 =?us-ascii?Q?dx4yQgILEvF/+K8hcUlJZiMBXdXO9Hsh3TtqXsqvXkBsqvVLMccCS1S2wvBj?=
 =?us-ascii?Q?DUsm9G78MxhC5sOvMGMHV35T/2PjK5yVm7AoUvWZG62pvKgoLo4ti/QAmwsh?=
 =?us-ascii?Q?TJjM6OvZymHjUb/eJ4STkjttDPpcr0dpUqsvYDKZcrlXoCJ3TIk0+/LRGeuG?=
 =?us-ascii?Q?nl9WXT1K+zrPnygeelhoMX2rTba5595PEwBGKG0yP+Xm9EaD7ZxnjOc/4wnl?=
 =?us-ascii?Q?MK0jHyVq9R4ezChIQNPRG74B/OTCGs98laPjPaQvKGZANxP2PqtcA8Oc2c80?=
 =?us-ascii?Q?P2W6MgmJG7jLEfqup88+svz6tTFIvPV5NgTak9mmDYn2YL7VskmskLesgEnU?=
 =?us-ascii?Q?HZihUmSKFSTvZGiWeWxean/PjIf/CB7uxr+KAbBPxpQjLLiN3rvdsPB/O5I4?=
 =?us-ascii?Q?nw0SC1TAkHToymzn8px8Z3ozcWwMZCX85ilYp5XsAjdcC6N5Vj73BW3vZw9S?=
 =?us-ascii?Q?KjW5JJe2gA6xPDjLE85fah51zeba9jQ1Db/LfgSzJE9qfG5b+RthV3vh4A4l?=
 =?us-ascii?Q?6uylpvVDIXBNAAYyrId7GgH5XR8eRifI/mV0NmSoQkBjwBKM7dAxT8btcqmB?=
 =?us-ascii?Q?XYgAmY/sYKh3e8+aMS9RWueRQq1VCJLuvzYXuoljmqPx8lKqvwkUCTQeeV2z?=
 =?us-ascii?Q?bx8hXFnKP8ciouTQloOXpwnHW1HsNk8FM5ndz52Cr4Xn0w3rD+ee/Av0dzXh?=
 =?us-ascii?Q?8/wKWHzbCi/jpe//rgqSc8SktJhd/rZrb/rkZgEt24YdM7f73ZseKKh+FQcH?=
 =?us-ascii?Q?8kbuKVMvjIEueQULZLKrIL4Jcfv/m62Exh89ftlAC5ACV9KGZpCJMISSP9PW?=
 =?us-ascii?Q?APXgdBXIRDZ9Ux+fdDDJJ4gDt9LItjiokFKnzhCrz1axUZhFtS+CPGwHRvcP?=
 =?us-ascii?Q?wkxOipiM+KIcbrEQaIT5db3Fk0b7HAdV0a5eNWqYn/P6jJSn6/cQYHGorpWc?=
 =?us-ascii?Q?+Wj8I9WjNxxbO0l7KUO55SEWRU9VtmCaX8Q7gnfyiBUc+OpGgk+zIdWTW6+s?=
 =?us-ascii?Q?svRX9irjnix+8K71vJHf8gGqrLo8HtT0iiagiLA8sv8GZFuIvwF2A7In6w72?=
 =?us-ascii?Q?qlyVDHP+sfPEda7IJ0gL/M2JnlrX22iWboQpRp7+A3/XlN9ealaCgM6wgPJs?=
 =?us-ascii?Q?/xZ2YioCde5VNucAeYB9wsXInZL8wuX2iT9pa0IjM+atZOk5cnxgEDaCb6Mr?=
 =?us-ascii?Q?f1u4Gvxn7MLVfcRv5+LFP6w6wFGfLJLVv4xLK+nz8W1rRmX77cfFqdY8qGV2?=
 =?us-ascii?Q?CJXfqvvlxUVaTfVBQCd1zsYGAFsDmAwaLObjxicDWOyL2Qdj4ql/4MJmqZSw?=
 =?us-ascii?Q?2YEKBXY4zOwcjk1YbGw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BGzDylQtTA0PT2P5BIzJj4Qjbo2tG+BZbLiAfAEVmIyIxJWYgBk6YP9wpIR1?=
 =?us-ascii?Q?93lpeSzdW0ttH26A+XX5znogCFAXw2TTJRUwdCQ571jpojJ0nS2E0X67dbIW?=
 =?us-ascii?Q?rmoXWtR8mpl/k9tmqAawzROkxnPvwdxTwRiaMAPEwTm4XJrAd9x/kJ3tm1bG?=
 =?us-ascii?Q?iF/dItNMXgrBHFBptLV4hFsEKfE+mJptB21K5kUt7c1iys45nvAR68jSmMT9?=
 =?us-ascii?Q?Z+zIh41r/xai8+UIFKNv/43sUyI/08ulhvjuwPmVtCp1tt46k1+HmFl7xJXj?=
 =?us-ascii?Q?go12mQ+O1y9bFD8TEltWlYmHBIANHspOqSib3mEOlnwRYJD0lhtL+alATXx5?=
 =?us-ascii?Q?6s8i2G/2/4hkEAPduVRTdsj1pfrGsZSBRYEk2ZMbAoKjnmx2WeqFIOJPNj5O?=
 =?us-ascii?Q?yBnribypVqCORn28iXpZv9RwTPVugh3b9JuLgnjiosenBDXMjKcv/+K47X5S?=
 =?us-ascii?Q?oW6oAiNST+DugM7+66X/V9pH1cZHrAMc3wCnYDfX83jVQlPe8tXsCGxmOYth?=
 =?us-ascii?Q?XmY4hHUJ8QwffqWCuqlVjHrTbzN13n/7HqWhGFgYIRqNNpd5cL3xiukde3d2?=
 =?us-ascii?Q?wSKhPeke74lCrmmvEF0+ptjOZLqChUtsqKYVRxU575SMk2/7eGP/7h5wZtIl?=
 =?us-ascii?Q?k0mZr5COdxEF3Y0UyzPJT3hKbwUZeDP50Ppsh0uDjuU216tiPAZQI5kfuzbF?=
 =?us-ascii?Q?+QHEqc01KEUMLPr9mHRmJonfP/KLe0TNo6bjD5kUFOAEkFdBou2cGWNWOnVb?=
 =?us-ascii?Q?BrdbaOPgJGRkDOBux38Gc002r+lQ5a7Cylc97GscUdXRrfN+UBGI6LCzEfV3?=
 =?us-ascii?Q?dOjxrGzReRYGOOJ+PoW/y5NZbfoatmG20TiRNToXVAyIVN/O39n1eaVSH7If?=
 =?us-ascii?Q?9ddYZk4EyKzW56Sdc5rRaswTNgaPZ4Q1Ncxfe31d4zMxwYwzw/QROBMj17+T?=
 =?us-ascii?Q?WIJ/k60nK+i1Ui3JaxxWwKzl8CjDzMNEklOWxVAkMbFxBDaNoTHmdJmDiPv3?=
 =?us-ascii?Q?DOz1S9MrY2Z1kz9IlxEefeA0gB8roOWNLlFF72sTF0bBZgdKYmw91ULpBSt3?=
 =?us-ascii?Q?BmyhXk49tK1w2oNd2JhehjRnAsBA6suxfJ14yLUGkBPzoKR4gVY0Q4KElGv5?=
 =?us-ascii?Q?wyhxHT4/rSYTmJ5hUBOkp//irDiBGeIzrW6SjqS+N5EtzNvswoR8wrzU71Z6?=
 =?us-ascii?Q?QR3QT3QM9mfnmKG4CQ76fvxPthGU1LKcuaBXgN/b9checB7XMOGu3wZX1lqi?=
 =?us-ascii?Q?/d/ML7ona3uY8tSGMxx/JUddKtsSM+8yRGxOJdMSqTA1paOzAdsXP5IR7sCd?=
 =?us-ascii?Q?hBWna8lyEcFCxxduaTc/B08qjqninUXw89pukbaJ08o/5Pgjzc9F6TVfK7Zg?=
 =?us-ascii?Q?idFnbpL+M5zQQr5m/DK55lB8Voz5Sfy+PVQdR9tHipJmkh7F5OU7eh7n9XoF?=
 =?us-ascii?Q?W6kExlRpWUz7mGtONSgTp915jW63XsU/syGj56TMRnEwrBYYAYZ2B9PgFg1f?=
 =?us-ascii?Q?IoK62ziTCqJyq0PetEJVnPIGEJAR5DEOFr4qp3DOh4NQTQh+L6/nBZD8vpJM?=
 =?us-ascii?Q?wXTqRwpuvQ58am9eKqblklV/s9Y/9eEZh+Ca+Ws1wnYYHP82HRlUokx5xIJy?=
 =?us-ascii?Q?9lvppKR1AvRAuMcrSUfXGEYiXUvki5mPJqVyCO3lD+G87sMEy2m3zpV1dK0s?=
 =?us-ascii?Q?vGjJunBcjWnC1c7wxzJyD5/M9qNGy1OrEDjbkbfmQJh1cRHb0MHfM5Rnsh6M?=
 =?us-ascii?Q?cymDlch9lcgLUbSiPWE4jGcVBaF6RFI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fb3aeb-275b-40fb-9e62-08de6e474f42
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 17:09:28.7784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iko1/m6tBCqzf7fSMA1V2EqeQ0xYCvCXPtmTB1olwmy67Xn1GEfQLi139Jf0PqYrgIy0tQWhui9jqdbq+Kl6Ar3ee1pyhWCs1EEDr916K4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6840
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

On Tue, Aug 26, 2025 at 10:35:37PM +0530, Shaiq Wani wrote:
> Add L2TPv2 protocol identifier (ICE_PROT_L2TPV2OIP) and session ID
> field definition (ICE_L2TPV2OIP_SESSION_ID) to the generic flow header.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> Tested-by: Song Jiale <songx.jiale@intel.com>
> ---
>  drivers/net/intel/ice/ice_generic_flow.h | 129 ++++++++++++++++-------
>  1 file changed, 88 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_generic_flow.h b/drivers/net/intel/ice/ice_generic_flow.h
> index 54bbb47398..deaf7b66e5 100644
> --- a/drivers/net/intel/ice/ice_generic_flow.h
> +++ b/drivers/net/intel/ice/ice_generic_flow.h
> @@ -9,15 +9,15 @@
>  
>  /* protocol */
>  
> -#define ICE_PROT_MAC			BIT_ULL(1)
> -#define ICE_PROT_VLAN			BIT_ULL(2)
> -#define ICE_PROT_IPV4			BIT_ULL(3)
> -#define ICE_PROT_IPV6			BIT_ULL(4)
> -#define ICE_PROT_TCP			BIT_ULL(5)
> -#define ICE_PROT_UDP			BIT_ULL(6)
> -#define ICE_PROT_SCTP			BIT_ULL(7)
> -#define ICE_PROT_ICMP4			BIT_ULL(8)
> -#define ICE_PROT_ICMP6			BIT_ULL(9)
> +#define ICE_PROT_MAC_OUTER		BIT_ULL(1)
> +#define ICE_PROT_VLAN_OUTER		BIT_ULL(2)
> +#define ICE_PROT_IPV4_OUTER		BIT_ULL(3)
> +#define ICE_PROT_IPV6_OUTER		BIT_ULL(4)
> +#define ICE_PROT_TCP_OUTER		BIT_ULL(5)
> +#define ICE_PROT_UDP_OUTER		BIT_ULL(6)
> +#define ICE_PROT_SCTP_OUTER		BIT_ULL(7)
> +#define ICE_PROT_ICMP4_OUTER		BIT_ULL(8)
> +#define ICE_PROT_ICMP6_OUTER		BIT_ULL(9)
>  #define ICE_PROT_VXLAN			BIT_ULL(10)
>  #define ICE_PROT_NVGRE			BIT_ULL(11)
>  #define ICE_PROT_GTPU			BIT_ULL(12)
> @@ -27,6 +27,16 @@
>  #define ICE_PROT_L2TPV3OIP		BIT_ULL(16)
>  #define ICE_PROT_PFCP			BIT_ULL(17)
>  #define ICE_PROT_NAT_T_ESP		BIT_ULL(18)
> +#define ICE_PROT_L2TPV2OIP		BIT_ULL(19)
> +#define ICE_PROT_MAC_INNER		BIT_ULL(20)
> +#define ICE_PROT_VLAN_INNER		BIT_ULL(21)
> +#define ICE_PROT_IPV4_INNER		BIT_ULL(22)
> +#define ICE_PROT_IPV6_INNER		BIT_ULL(23)
> +#define ICE_PROT_TCP_INNER		BIT_ULL(24)
> +#define ICE_PROT_UDP_INNER		BIT_ULL(25)
> +#define ICE_PROT_SCTP_INNER		BIT_ULL(26)
> +#define ICE_PROT_ICMP4_INNER		BIT_ULL(27)
> +#define ICE_PROT_ICMP6_INNER		BIT_ULL(28)
>  

This patch has a lot of renaming going on and most of the changes are
renames unrelated (as far as I can see) to L2TP as described in the commit
log.

Please split this patch into two, with first patch doing all the renaming
of existing values. Then you can have a second patch that adds the new L2TP
parts.

/Bruce

