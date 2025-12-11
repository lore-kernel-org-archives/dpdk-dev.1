Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90416D41C0B
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 09:06:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 645DB40B98;
	Thu, 11 Dec 2025 10:06:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 7507C40285;
 Thu, 11 Dec 2025 10:06:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765443972; x=1796979972;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=g0n3K2Lmwp/mivO8SZLUSfRhrBeSIyMfjxkR/evwod8=;
 b=Fclz3zwQ8tU/U86mNVveN0/DmvsOkeu/f5obGWM/btHciSUQjnYZdOZ4
 wwu//Q8rt9DOYOSErG2wneOD/JYolHytpB9OuSJ3VoqPzCIM57oGFwhtk
 UenF1MJ7NW81B4qwL0X4/2pjI+zcL9jpxCreOqApV7bWwCyCHzxT/Hvs2
 6elvbfHGHbwlNQK2cnZcRmyZSnDr5JC58bdkFHft8pdOEHKoBeLBgMrPV
 0TOJjOZwTyJAW6fyWPUuP5pzI7w3wZo4nQi+mmmY7UdzjzjBxecgjdxQG
 eiR0HSgGg1f/VT2PLVrU2/OtQIs6wMpk8Uuuw2/BxZ4Rh4Cxr3iTfMHqS Q==;
X-CSE-ConnectionGUID: 9NM+cifFR7WfJ4K2kJhALQ==
X-CSE-MsgGUID: WfEaeNbESQiflgAhZwA79w==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="66423316"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="66423316"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 01:06:08 -0800
X-CSE-ConnectionGUID: UEXp7gN2RQmyWat1f7Mjdg==
X-CSE-MsgGUID: t/rTfpnYRUW6mdeqtPmUbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="200912745"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 01:06:08 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 01:06:07 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 01:06:07 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 01:06:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4kkVlBdigk+dS2xAz/HBj31upQmzp4xX7/5fNfAqIBLpg7G6LQgVI/fWJHq96FzntdbiMr+rmYbbdkr8z4e9sYZV/52gE3vk5Pw5tIfyhjP+MxtEFIG7sM4PrRM1HrYjYBfQpyef9T0fSikcwfQ/+OyN1A3cC/wccr1SghFVm00bsGS2J0aTcgpr3A/Iz5KS/N09S1718XyU6ElnDfyLhXfxEowWmTOVKPF1KQWwUmTSwWpoHLYpTZ5mQOfH4Ou6ITZsZLP48h7y84OTyaO7Hsn1DARavkBlgR4dtxmoOyxvDh+x3XWT3vy9SAKjgkBuJMwt997ilH59gApUEK9CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XNV3msfKyVIc1AQFkU4TJfENeshvHJZGZJSe5ImZKg=;
 b=GB45WRmSL+YzCXyIrkGNpgrQtteJ+EIF6HNC+mLyR4uWXas+ZTMxRtzQKvhj3DHy5kLOHieR0ZkXMmA0c/+hi+qT+H54L8ISqkh9p1VG5Hn0dPEnbrUB97LfJJdOYQu1WG6yLJ6Z/KRV6iVWV6PkDC7L4873KVC/lLChuSLNB1dZGYMpowSoHnHd3kkkRxvaX8PUW027GL8r919lySGqH9BEO6vmcDZX4Bx63YHFavY0LFjm3qeJaTYxL5kEczL+7pLhV76n1L4njMjw0AMADYa8PkpXJuLobnRk5VSkJNVN24vw617QjDPlSbnRIf7nDWXX8gkOui4zSs6d4UnrrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Thu, 11 Dec
 2025 09:06:05 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 09:06:04 +0000
Date: Thu, 11 Dec 2025 09:05:58 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>
CC: "Zage, David" <david.zage@intel.com>, "Hore, Soumyadeep"
 <soumyadeep.hore@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: Re: [PATCH v2 1/1] net/e1000: use device timestamp for igc
 read_clock() operation
Message-ID: <aTqJdlxzmd6m2G5d@bricha3-mobl1.ger.corp.intel.com>
References: <20251108080613.123969-1-yoong.siang.song@intel.com>
 <aTmp_sa2vA_2N3bN@bricha3-mobl1.ger.corp.intel.com>
 <IA3PR11MB9254B5F33796A18695D658C1D8A1A@IA3PR11MB9254.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB9254B5F33796A18695D658C1D8A1A@IA3PR11MB9254.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZP191CA0071.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::11) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW5PR11MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: cd997bfb-3c7e-4b7a-9b07-08de3894830b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w25h4XF22qVBk5ZXI/CC1dYOa6I/YTn4LDPhi/4bHw7Z7McGmncFOTjzehPk?=
 =?us-ascii?Q?p5gi9HLMxzm1OHQ2by+kjDJ5KsuxjDgPDMlR81EUIX8mpNgwqpsN7CSlrijL?=
 =?us-ascii?Q?Uz17lKc3hRGHH16KWKvaaNnw3IBXFcDIGSzNWkjsm+hmAMoHkKgYo6SAScUn?=
 =?us-ascii?Q?EAco9UZRdwf2wSRXOMTEKskhPfCs9YyYsmlAWhcTigKVD73ZhWs6/iDkhHHE?=
 =?us-ascii?Q?uVlgBQpU32QVEy5kqq9nM7ilAs7439zId8TwG/ForH7MB/Q0Y1aShPLJYCIz?=
 =?us-ascii?Q?TNbVUpfHnc0Ek9rOcC/qHiKtXOT/v5w9IQVuw2S0uTuTTo4IxQmHrMx+q9OT?=
 =?us-ascii?Q?/4gYJFktSEPJQjqKVxGMAWFUuo/W/DqMn8HC24WlBCYn0HA4bHxrwsWNUpBz?=
 =?us-ascii?Q?zfquxH7eD3K46mC5M/b8fTJTp++mYWX42UUW1BK6CIsmFm+v423mvhYalTOD?=
 =?us-ascii?Q?6qN6BlFn9qtTJfxvFrEKfwOqQpjVC+nWqliTCodBhBj2OGG/ZLnounCFBFnZ?=
 =?us-ascii?Q?CoXdzXy+2OQpxiJuJlC+MPORtgztvXya02FqYs1iwanfS1CrzgMy6SLl8Wk8?=
 =?us-ascii?Q?NGnCDZb9cWkjvtZS9x4zJI8nQYiblW5YzQwe28mCD8n3VEkAxBEI3P76uciu?=
 =?us-ascii?Q?I7MNxE2qbxmai7EGLO/VQ11QucUk/b5lwXxme0irWgTE/IQfolV45olcQXzw?=
 =?us-ascii?Q?p47YdB5KqusswOqimSLNePHZ3YciaY0cue1l1A4RzRN+3/pXYhsB+ZkpsS7H?=
 =?us-ascii?Q?SgwDS48BuaVC0N5JHtlPfJ3vdouSii1Bmgs2KmkNXtzwTke7SY+7tfkj6Loj?=
 =?us-ascii?Q?dVRI38AFiaC2Q/mkXYf22Y7FJKt9mAjxcDzW6kwTrWIsjTdCvSIhH+GktqF/?=
 =?us-ascii?Q?ubqT0F7T2Os/ntVLpxjlqJ7NpgaNUAxXfuZn+oV1hnUvW0XH5YMFXeaMhqPE?=
 =?us-ascii?Q?OWRLGJALkpvTm652HT13riFDb/A+zM2iZCoh9tsSE/ASqsL0gPZo/AJveS5v?=
 =?us-ascii?Q?yn5M9Na/ZMhxyOziP7gopYBNBLzVnr9Ci26lkidsPia9VoiH8ajnikIblPBJ?=
 =?us-ascii?Q?0/2vat4u7GvRqG5hFxrvWc7qLY9Ux7VeykLIBXsdU06gGP2xl5oKI0mIEMOn?=
 =?us-ascii?Q?aImijhWmX4Mu8Lblez/Pq/716eOa5J+Pr0SbGwK8vSudi1GaQC2aK003acEm?=
 =?us-ascii?Q?8Xh4BtUgzsv44Pw3x4te1MGEzW5b2GQV5q065E0C0JxvtAqAsBHTXYmMV0t+?=
 =?us-ascii?Q?5vowmzYFllR1RwxGNVfQHZCYVSepKaLSKJ+GeJHoSVOQhugGn/qJp2ZHeO82?=
 =?us-ascii?Q?FwYEVx5pg4A9/VTHzstnMKw2U3x2H79Xp2eiRZ06XlF+qLF8rT/zIj5qW04Z?=
 =?us-ascii?Q?glmgBHgRO/NUMTNEWchMdu/8OLx28m0vSQXQw0cmO54DsKBcz4DRUFgnAnp9?=
 =?us-ascii?Q?EWzY/x1bxE13r5wUtttEiVY9Zay0/cGEWNo5Uci376BqEG9nJ7wojg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GP2uNVAlyCsu3ZeIaahiJKyny0GwkK9hdaBthm6s2Lz4r9SzGjurBFOOulMy?=
 =?us-ascii?Q?7PLKzmNwHvoVX8rRc5ZnVZZbOLhjIWXpQ13akmY6G8lRh3kTMcNnfrMYEQ+N?=
 =?us-ascii?Q?O+pNhyDyoFjfbJZjPbSOsOA/vDl1cc6HpMu4vuv60pAjtOn+49ASM90xcTTy?=
 =?us-ascii?Q?+2nhnbsF06Ndw8l74KmJ/kcTdnXN4/m8ZsReLFXb8041Zpgc3u00SpY12FBX?=
 =?us-ascii?Q?jRR+XryCgzO8OjsnXtrvvBpowYcUngSgliqW4dIxurs6kE5GiXP2RXQti1jk?=
 =?us-ascii?Q?zk5MmZhk6C/G107wvYax5mdlBDxECdKkghzttZzn6Is30/IjRkn1LMUPvBtg?=
 =?us-ascii?Q?XARhuwOqJ4oNHPJ/JUGRdg2kEXYgYcRyzKhd4PnS4zE2oMwCvJYclnUA9U59?=
 =?us-ascii?Q?RKbDhUmHFJ0DepgM2LZWPHuHQS4gSMhAZ2P2ibP+IoRk5jLUiWbjpXQbIWfp?=
 =?us-ascii?Q?D50ipIoNtkbqmxdRa+WoQNGm5pNq4AF229FHM9TYHe/yCq8hKKKeCyFHGh1L?=
 =?us-ascii?Q?KpE6iGdm+TLXtRc/qDNNXtBxOq847m1VgGhMU0ruPPS3vcVXhkN8Pi9xe+8b?=
 =?us-ascii?Q?ok2cNSTwHgva87qjsUJmz872FEq251b+L8P8eRe1AaBB8QNuArZzUhUGpAO/?=
 =?us-ascii?Q?+IDpShklxeG6EQAPPz/dMl2yO6e4fv+oy9nVBXaVfRG8oHoQH0Y8hDmM9soR?=
 =?us-ascii?Q?3wxutAORND65zO7bj4D1RxzYeS8DBVbyDLX02M3VYLIcC9BF5H5e+Jdubfbd?=
 =?us-ascii?Q?QmDUHuFcRjXlxk+r3bT8PHe5Ss+U3bxJYtElSTe4dEoF3ztQ1ayC1n9bYDZ+?=
 =?us-ascii?Q?4qzqqrddeFzd3kXHJtU+hsDdQ3BO364CvFnIONODStsPn37GdwB9MmDCXQby?=
 =?us-ascii?Q?NCK9QJ03VFsU+KOddky16kbDuKgXzVeVLPkKPf3AOPJW0ipdDvKh7s8gTe70?=
 =?us-ascii?Q?QGwCbeAik6VwiWEeODAybukfdyJCYbs6OnIYG2OHz8JvVhH8DlXr8ySYmA/x?=
 =?us-ascii?Q?Cm5scO19gRs5XnJvEaWeyQ/uawI6F/3hb2WRxDq+eXQVu0XN4Ya+O39jkIb2?=
 =?us-ascii?Q?64hLNdFdRi86rpj4GXsaNfFjHHycnnzsDIjLrM7seSS6XqwaScIkRU2A5WL+?=
 =?us-ascii?Q?kKUvkoJJ/MCS0HneF9hdBvCbQHYBBBBbp7Y8Zpc1tu3LRw9/smsWu67je79k?=
 =?us-ascii?Q?5945HF0LaUNkgND/IxVO5wcs+lgWtY9wU0zi2eB3YEq8AGd3JymHN/8C5n3t?=
 =?us-ascii?Q?pu8ZTr61zuPEqgsQLOIL31C4nV0p0FJyBFjyRlbyFQC+hhv5j4Cx1TtpwEZH?=
 =?us-ascii?Q?I+swZEfPfmZAsbzk2FNtobFc6bNU6S4jRVPGVxOz+ZQwd7pDYP8KSiFJrCd9?=
 =?us-ascii?Q?LWBQcKw2Tjd+1kjFQ5DICdpZtkcg++cQ2pl0A+99Il8+vqWnOKDLBost2cQT?=
 =?us-ascii?Q?NrPoc23/WxJtj7jrwmhsmpAiwX94IrR2u1KoAgG+0eQ+urX8oJJg4KWdBBRg?=
 =?us-ascii?Q?+bqCDG91jkRsFIfmbA+k0SNWGSnEnWaP6nkSt1hz5ny9Knb6OiysF8H5vADD?=
 =?us-ascii?Q?MS64UsVsjAdKfu8XyX1jd4Fdx1Mw2TQd1x9stmB14Sxus3+GSpFeGPob7oFX?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd997bfb-3c7e-4b7a-9b07-08de3894830b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 09:06:04.6069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vLAy53uJY2gOv9mIdEm0ewsL6G7kJQ4jS820BK41GQdd5uSCAHZ1FT3a1R5QtUw7o40HxKt9jgJ66GFEBJHvcLqyInFMDoWeZ/82ny8d64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5881
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

On Thu, Dec 11, 2025 at 03:24:42AM +0000, Song, Yoong Siang wrote:
> On Thursday, December 11, 2025 1:13 AM, Richardson, Bruce <bruce.richardson@intel.com> wrote:
> >On Sat, Nov 08, 2025 at 04:06:13PM +0800, Song Yoong Siang wrote:
> >> Change eth_igc_read_clock() to read from hardware timestamp registers
> >> (E1000_SYSTIML/E1000_SYSTIMH) instead of using system clock_gettime().
> >>
> >> This ensures that the clock reading is consistent with the hardware's
> >> internal time base used for Qbv cycle and launch time scheduling,
> >> providing better accuracy for Time-Sensitive Networking applications.
> >>
> >> Fixes: 9630f7c71ecd ("net/igc: enable launch time offloading")
> >> Cc: stable@dpdk.org
> >>
> >> Signed-off-by: David Zage <david.zage@intel.com>
> >> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> >> ---
> >> v1: https://patches.dpdk.org/project/dpdk/patch/20251107031507.3890366-1-
> >yoong.siang.song@intel.com/
> >>
> >> changelog:
> >> v1 -> v2
> >> - reuse the existing eth_igc_timesync_read_time() (Soumyadeep).
> >> ---
> >>  drivers/net/intel/e1000/igc_ethdev.c | 12 +++++++++---
> >>  1 file changed, 9 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/net/intel/e1000/igc_ethdev.c
> >b/drivers/net/intel/e1000/igc_ethdev.c
> >> index b9c91d2446..d4edc82668 100644
> >> --- a/drivers/net/intel/e1000/igc_ethdev.c
> >> +++ b/drivers/net/intel/e1000/igc_ethdev.c
> >> @@ -2813,6 +2813,12 @@ eth_igc_timesync_read_time(struct rte_eth_dev *dev,
> >struct timespec *ts)
> >>  {
> >>  	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
> >>
> >> +	/*
> >> +	 * Reading the SYSTIML register latches the upper 32 bits to the SYSTIMH
> >> +	 * shadow register for coherent access. As long as we read SYSTIML first
> >> +	 * followed by SYSTIMH, we avoid race conditions where the time rolls
> >> +	 * over between the two register reads.
> >> +	 */
> >
> >Not sure this is true. If the nsec value == 999,999,999 on read, then the
> >rollover occurs, the resulting timestamp will be almost 1 second out,
> >right?
> 
> Thanks for your comment.
> 
> According to Section 7.5.1.3.1 of the Intel(r) Ethernet Controller I225/I226
> Software User Manual (Revision 1.4.5), the hardware provides atomic access
> to the timestamp through a latching mechanism: When SYSTIML is read, the
> hardware automatically latches the upper 32 bits into a SYSTIMH shadow
> register. This ensures that subsequent reads of SYSTIMH return the value
> that was present at the time SYSTIML was read, providing coherent access to
> the full timestamp. Therefore, the SYSTIML-first, SYSTIMH-second read
> sequence is guaranteed by hardware to be atomic and eliminates the rollover
> race condition you mentioned.
>

Great, thanks for clarifying!

Acked-by: Bruce Richardson <bruce.richardson@intel.com>
 
