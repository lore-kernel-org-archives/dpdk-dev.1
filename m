Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE4DCAC598
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 07:48:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C9C64028C;
	Tue, 16 Sep 2025 09:48:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 089F24025A
 for <dev@dpdk.org>; Tue, 16 Sep 2025 09:48:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758008896; x=1789544896;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=d1jyChvMQZHxM/Ss9/6W207rkXw9Y9ZhjjlV+0hMqmQ=;
 b=kL5eceCU8IKiZUqHXnQpqN+h7ULNKQMAD/x4L1CCn4M+q2+5+sWJi0HC
 N9H+ElK+HqaZbdaH6SXocFfBs7I0Ap98fhN+lHG2Hp5WqM7GmhkGpHI6T
 hq6FjyWJ4kyAliRrTpSnRrfyvZ2I5DI2XLoDQffgCQWpwP1JDMtrE+qS0
 eUulIAPixtRXUVW0L5Z4i2DxGCOW33CZLE6OYofjYfvu76+OXDzwVEJVj
 XcwEMfPN7KIGyhmk/m0AneD7/WRX19oce+SylvlJrc89pCgMIR/e6EzGO
 d+F1pWP7br3jBUreyAcPyfDj1hdZDgaJjez/OSuu0VfcRYtrWv5pg0ak6 A==;
X-CSE-ConnectionGUID: aYt91pUQSieUyTNuM13fRw==
X-CSE-MsgGUID: nFcbbwB1T3ORAETNCGt4kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="60423864"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; d="scan'208";a="60423864"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 00:48:13 -0700
X-CSE-ConnectionGUID: 35VmbAm2TPKXSALqyMFW8A==
X-CSE-MsgGUID: gVTjBLmxS8SWJXZA+f4sag==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 00:48:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 00:48:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 16 Sep 2025 00:48:03 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.40) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 00:48:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObdPqv34qwVuXh5iJ8JZdV5UTINamnvXtselMCwMF9GBPGzotHi+r6eenO2Na3t47Sp8BYynz4NI1PSFX5UPZaUpTezcErjdk+D+UJDUDYZ+JoKltwwynUFQpp8qhtYTS0D/Jhdkgv8cAvAjNx7IkYizfzQdernQH93iM6aprY9/N8B68qThtdhbwri1ZlChKR0rmvHMNx4Z4ID5VZIqKrFYZWC8kGmfoVdBJ8HQdm/dPUv2+i8ERcwephsq2pYsqMsF/8jNfLvxrgNEwW5x0OAe0u+SbXeDO2VO1o7XdUsHZR1IK5p3JhnBfQTIcfMlm1f/x8miSmpR7tCl9D858A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPMSVgbPyvrqh6NlXvjnZEMUb1jlhTCqek+AP4+6CZg=;
 b=DIecghVc0It2zyx9aYBScVpF93ce5DZ0N4VFzO77bTIJff9Ubte6d3XJv9gSKfvcWRjIm9Wz4zYdwH5UaKBtiMue0wIa/FpmmgfSxf7zT6Jh49yv59wpZcs+owEMMrhPmidfmWSez4YytY6JyGUYTkL9jegtRS1MkUV08GyGPB37pAWRQMNFiCqujoET4YBwFqts0xk8M+gt74eRPTxQW8/+zLvdAWSjgn2meRpDU0Pu2sKZxWCnE8S929rNgQTYfUojjtR/g9hDVuorexf7bbmV0IGIt2Ez+MwqABXeWI7eccWK1ziG15Bg5NNKP1BivHtXrFbBHm0APWFySvN9fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7896.namprd11.prod.outlook.com (2603:10b6:610:131::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 07:48:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 07:48:00 +0000
Date: Tue, 16 Sep 2025 08:47:54 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] app/testpmd: enable warnings for possibly invalid config
Message-ID: <aMkWKrJPlVFH45JE@bricha3-mobl1.ger.corp.intel.com>
References: <20250912160210.388290-1-bruce.richardson@intel.com>
 <20250915105308.46c31d44@hermes.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250915105308.46c31d44@hermes.local>
X-ClientProxiedBy: DB8P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::21) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f6eac0a-6c98-4143-43de-08ddf4f55b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NtH6TKHrmStcIgtWMDB0Kh2pm3StGOFKzl5JRAk1cq4q5g/QUgWWCH17682E?=
 =?us-ascii?Q?mtxP5vh1+oT11sw+m1JWY49SBRyg0nlG/O0ds94Xcyek83sQo2WltTiiSpRb?=
 =?us-ascii?Q?D7DYxgHH5rea4+tXb9ibwhM8Acb0A/hdRki2HerpQmcAdObJNGaJBI21CMQR?=
 =?us-ascii?Q?fAjGITNr0KrGguwR7lfEgnfFn3uvw+cB3Z9zc1mVVpYgjCvWmVeyCCRJH3dK?=
 =?us-ascii?Q?1fFt9UnUzUnyGZ3Uu/qH/bZv2+QEphoC42Y+fVyqt7Yfa38F0plYjwzshvGq?=
 =?us-ascii?Q?tkqtXp53kZPviLK54fCAbgAaWd8x97rE5WPPWiA032JQV421Dj69Y1XkOSDi?=
 =?us-ascii?Q?As1+eeSsVoafPdbUt7MTUsaZA97/6DuSQtMOZSc8/bPZtn1dvydnAdH1cQlb?=
 =?us-ascii?Q?vKR9Kbq6MQlQ06mxENOPdVCbRZBuqv0A74OaS0oNrOHpEdzeCRmLPmBjRysv?=
 =?us-ascii?Q?i3WPXtfRn94lf2LmNpSpXP17qG2pKGYzXiZyUPzgBEKBxaIZbmXmh+aZmAeL?=
 =?us-ascii?Q?UwoJLZ+05/oNS9IvyBtNvFQ6opLjlZSdr60ywdp22VBPDGA1LEk/LvzcZrTj?=
 =?us-ascii?Q?nHuBKf13xnhHu/ckQIJs0D/FzwBQ/XtRxAd3d75ZWqpD6raBBkGES0tNQftn?=
 =?us-ascii?Q?Ec341wdsFqdI3gsgkVJGKqt1h/+DmSbYVgAFqyWUOYuf3z974M0PlsFNn5xC?=
 =?us-ascii?Q?5hU5rdMB7kn2YtfdYqu5mYH8aGRkUN6PnQGv9wcrY9aXu/FpW3UjpOsntm99?=
 =?us-ascii?Q?QV/KsEXwjpb1cVIdb/rcD7ynW/xUtP1U+WXkSEb//A1pqcpiELSGQ12qMGQx?=
 =?us-ascii?Q?dMOUl+NFuvmPfl/lfID95GjoySvPisbfqXDmxp1ThKdqApCOhRGYkIfQ61fH?=
 =?us-ascii?Q?iMk10cnWpLI5vw8IeBcvvF4lV1Fk53SignRhHVXIhv+J2/JvBRxTfeLTDAkF?=
 =?us-ascii?Q?ZVD/+bdfrLnaW4/Ket+3OV+a4F/NNEo+JINxMSWbxRUAAYQMsHoBVza1YwIu?=
 =?us-ascii?Q?w6oBCZZe6aKXhAM0ai9X04UWPaBidCnyPdNXCqbIpygws8kD6cOFwhFSGipM?=
 =?us-ascii?Q?HCokqgkBGz8WvQSpGpz42Iwt94Qkw/9ekPbEoF8F/oVmu6bdk9tx2pHCehfF?=
 =?us-ascii?Q?SvKwYugT9plAVYNqHup1ZLnSJAY/XIaWj0qAYj6a1tEjAVHGBgg2BbiEuR9m?=
 =?us-ascii?Q?ZVDf7HXGnR+CZW+E4dJGZwFiQ+QvLmV60OZGP+Fxa1MbKYTinlGd4vkBOFHI?=
 =?us-ascii?Q?f2ViuPoGxcumzVeVnjRN4i74uQ2/0+BdcQXt1CglYRsRq24rfdmbs82+yi68?=
 =?us-ascii?Q?xvnhOFQEnNuA4j5mGrxejLueih8GK0vv+LuukZV24Y0dHOfzrHmkQFkMXzQD?=
 =?us-ascii?Q?6m8Q05M7R896pbQFNL9w+BCJ3RTJCf0EHLevi/1AungNJ2Wvcg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SQxaozyINM6qxN2olQjMI65n9RisxLgnAXghfccbD1MvT5z1CgJpxECYDsXk?=
 =?us-ascii?Q?lNtrKsHozgfEmUSZJ02xCvNiDMCpkufpQd5KbRs6VYFpNzpzWEbUlVnP1m2J?=
 =?us-ascii?Q?e8YLJGlCD9HrbjdukPsHe47nDeZ5iu7QgrvTHoMXJeX856/XV7IoQdABxPKZ?=
 =?us-ascii?Q?cbabpJ3PTI4sw9Ve5f6U/fhrWlcTFQNczD2/3hwLWEk7B7B/vmlyNjQZgLpc?=
 =?us-ascii?Q?U8mEX122iqyYwOOQh6YYdpbLx+MG1/eAVXY3VdPdoFAhPEGcTGJqwCQXa8uO?=
 =?us-ascii?Q?khMRVYk1/C1xLLj9Dzwgu7Anr8Y1suClSteciv9ma8/HwRX7bwP8EQblaXGp?=
 =?us-ascii?Q?56/WpkWshNr+HBqJH1zJpFyshRE4wpMtYghw4IYuB6845cRkBCmFDoLI6T4S?=
 =?us-ascii?Q?+5R+KzvsVjmAmf4Yc0m+XvYoWpI9Q5CgH9cZItj3aqaGMiASIjBOMWZLWqFR?=
 =?us-ascii?Q?f2dhqcqf5hHlnv3ZBXYKea4DBKYog9GbsLBMwI0vBLY0x/pNh+U6WwbNwjEd?=
 =?us-ascii?Q?4LaLsf/H1BeUWzvWB2s9xIg9cx493546daD8Q/2v0iqsuStqH6uidk8lZ4NW?=
 =?us-ascii?Q?/VdYAZW1dWNnImnbCWrKqm0TkbmPNu5oXRNO5JGA6cHzanrL1MMDGhjYvols?=
 =?us-ascii?Q?YXpvibhEGHqlukPPLK/56i369xGMA3OnXlAIIp186mvVt/ytgyAgpA0wP912?=
 =?us-ascii?Q?UKTT/7u4f7PL5M1S6lNT7WFrzM6tOCY8ZMwKrFs/sYmVoZJ9INW20Ya1OM9V?=
 =?us-ascii?Q?EEK8PZ1YuDPe1+xsQ/2GboRSMjRQcLzs+WqquqAHw/36gvpbF8KNy0155xnx?=
 =?us-ascii?Q?qskPZE0RQTV8krDRUMyrku4zLaxtoxNMGe7tWra07M7w6TYwbwG4u8QvFHSA?=
 =?us-ascii?Q?IweslmWyt+drG6k9fUuSjfYDiJAO/aReJerJIl7CDaTfORsFI/o+IH3hqC6T?=
 =?us-ascii?Q?TbrRtjFgILbZ66YrAwkDnLJh/LkYE+8FPzbkC+GcHn2ibC70llh3Xq8lVQ37?=
 =?us-ascii?Q?pDcbiM6UAvcb6J+vUt+QRL/KLsMVBiCtr67Rc9d+c4cjri7R+MDvI1XrLyp9?=
 =?us-ascii?Q?mP9hKQJfD7k+53BaY05gKxlAUlefXk8TJ5fZchgYvZ4FZWs6Z5ypTl2Pug5C?=
 =?us-ascii?Q?9vz10syUhzAqUqg/U6XPUcI//t2miq13W/Byw7uQ0a+TmW9BQYZlCzO2jC2x?=
 =?us-ascii?Q?g8x36V6lZEQrYeUFPTA8M/tCbJT1FVLVo1xSqp1H8Cg8qvqV3LHY0LJxu5bW?=
 =?us-ascii?Q?oOiKugCu3+RGnFi4ZV91C827N8KUfBw6LP7pVPGNsb6jZY+BFEH7Ea1vs8CT?=
 =?us-ascii?Q?pXB52DvUNoFbCLRAJu5eSpdJXYNe0Vhmi1Z0Axgm5MuEj/6cBcQU0V/+CBuc?=
 =?us-ascii?Q?iWebS/RN73GaQQeo+N0D3J24QPc/qiLZ4bJaR+I90Lrq7uYvVSSxtu8s60Hv?=
 =?us-ascii?Q?G/v07X6GvCS1iftB0e3ikLaj79b1ljsqwzIIDF4xLiD/uDajrSgrkKqytv0/?=
 =?us-ascii?Q?F+F7Fo9XWyCK4nwyEPuPeHXCW7FEI7rejoIB20nvWa3/epxKMUG54ExwasDM?=
 =?us-ascii?Q?wYYkmCcWal2sdsizkKDk5/XqOUywqMZSC+fiLK3fgNNrGiGwIVQP/0WD/L7h?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6eac0a-6c98-4143-43de-08ddf4f55b6f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 07:48:00.0376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNBGfu7QU9CHYkydiC2FIEbjKpOjAx7ZkqJ7qRr30Guoh15WqzfI7YzTPoSMFO2taHlOznUYvLCqU0LbXrR2LRmBQHcjr9SCJ1No0J4Nagg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7896
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

On Mon, Sep 15, 2025 at 10:53:08AM -0700, Stephen Hemminger wrote:
> On Fri, 12 Sep 2025 17:02:10 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > When dealing with multi-segment packets, there are separate offload
> > flags which should be enabled on Rx (scattered flag) and on Tx
> > (multi-segment flag). Print warnings on testpmd startup if we detect a
> > situation where we suspect the user is missing these flags, e.g. we
> > allow scattered packets on Rx, but not on Tx.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> 
> Should also check for RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT which should require
> multiple segment support.
> 
> Could testpmd also check the descriptor limits of the device?
> Does it validate nb_seg_max for TSO, and nb_mtu_seg_max for all cases?
> 

There are indeed lots of other checks that testpmd could do, but I'm not
going to try and implement them all in this one patch. The main reason for
doing these particular checks is that it's comparatively easy to enable
scattered support on Rx - since there is an explicit flag for it, and some
drivers enable the support automatically if they detect an MTU > mbuf size
- but it's awkward to enable on Tx, since you have to manually specify the
Tx offloads flags.

/Bruce
