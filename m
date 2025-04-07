Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71595C3601E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 13:25:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52B7240156;
	Mon,  7 Apr 2025 15:25:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7584D40041
 for <dev@dpdk.org>; Mon,  7 Apr 2025 15:25:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744032303; x=1775568303;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=LbTeNm05kADej2vBbHcaA7imDFriIMk2OZqozzLieIc=;
 b=Hri+3z1GgGINGhE4pqb2B7i2p4ZSTMf70KOr2dcMEBF4L+5dcpDYq/nN
 6KIRAc3efFlD0y0lrJ92VQqfA7QkesHmYWKGUJG8IT1iSfYzG/ySgoSeY
 5QvsPzF5Tt/hcqzrCyy+v6N+uiNZ9SBIL+HpiF9lZtmjgLDfk8HtCFXPN
 Mrbsvu0iVNlEPKDwBvSE/WjuAP6EcknenNINxBRo6tTtkBTxYmahITGOW
 Jbtdm7oX7JPUB+vKXntJU4oXBaVVSL34AcDvkNZjkXtre/Z2/zPq25eCD
 1/GEO3uSb5ou8L48EkNtXLQoOkjfrrSzTfjzLA3eNzX+YVLwIsoxxJArn Q==;
X-CSE-ConnectionGUID: xOVE0LaCQFOEY/kNCynwdQ==
X-CSE-MsgGUID: TQjs3kPXR22/cL2lqkRC7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56788207"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="56788207"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 06:25:02 -0700
X-CSE-ConnectionGUID: eJAy+ZfQRDGNjV7+0vVL7Q==
X-CSE-MsgGUID: 7kDzfdfiTDmJAF2WfmM+UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="128816326"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Apr 2025 06:25:03 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Apr 2025 06:25:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 7 Apr 2025 06:25:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 7 Apr 2025 06:25:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRv4kTC1r71Lvo61XiqbkvS8QeM4h7toix35vDFmYRVlR/7QuP0Z4ehmkGPl4p60f4kvI+y56HLijs5N7Dsd094CmL/KgeY99oOPD8KIWnqknL+wGU/VMdGEWb5CuHlCb8TlnT4KXR0HayPixXKMs1YbPDjngbOKAxcerRYiIwXH5gFX4IXj4TvTIumyfamBXL59owMG8n1RrybzNNbbxOvV32aQkd4rDZKlNDDzxE5WD+KIAGypXSsUoPWI9+wCc2aws69HRiMmHfrNLhYs1J/Derg+7Kx5mFsGSho6+BAyi/25Vcxy3ZSJSvCqwNZIGRd8ISciy7WcCA646uk9Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4RN986lAvMsYjUhFhxu45/pIsLf6TkflnRV2n5Njg4=;
 b=QzI5NCmsaBFA6PkWPK4MlOACD8hNvXvdXh7i1+UeCVJpET5B5NicNgdaQG8bJCPUsTVJKZoH7Jsu+v2UXbBKvUo9egZrhVmmrY56TKvk1DGb2oSF3vhmbbiFVf1T3s683hOSYpnh9vrhbTOaq0Z+wRqGI8ji/Ca1O28l80PO/uC9yj0PGVEQ2RRRMBMs7jhf8rUszhvA2hpkk1GT//8mlWN/VCiNBdUUNHFVZSg8B7akj5tHa63F7dgk8AMQ3+ZKnqbyik4G0hLobNcWI4llI8Z55dkwl00Vg08FQf0brWPa1pc3APxNksyQlNI43I4k/BZHWomUT515rYLjPotlBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB8347.namprd11.prod.outlook.com (2603:10b6:a03:544::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 13:24:26 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 13:24:26 +0000
Date: Mon, 7 Apr 2025 14:24:21 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2 0/3] allow easier use of high lcore-ids
Message-ID: <Z_PSBYXzrZlInTq5@bricha3-mobl1.ger.corp.intel.com>
References: <Z-vzAS8TXWn9WSV0@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8zcFU_K0feJMK=YEouyxYxwURUPQq7EGcacJ++RxoTuEw@mail.gmail.com>
 <Z_Ofcb4ktAmn2RqJ@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB99@smartserver.smartshare.dk>
 <Z_OrsVaV64pLREqv@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB9A@smartserver.smartshare.dk>
 <Z_O9Uq_Mg86yjKzi@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB9E@smartserver.smartshare.dk>
 <Z_PIBLQIT3eu6Ab3@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FBA0@smartserver.smartshare.dk>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FBA0@smartserver.smartshare.dk>
X-ClientProxiedBy: DU6P191CA0068.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: f456a117-3d8b-4ddd-ead3-08dd75d784be
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTRGUWU5MGpvY3NiOWdJaTMrZ2NXbStUQnFZTkMxVEZEcC9va1Z2QTBNMzQz?=
 =?utf-8?B?K0JvK0JJVXVWc1l2c3IzQlFrWk51Zk0xdXhxbVNGeVd3aC8rYmE3cFNscEkw?=
 =?utf-8?B?blVZSHVWdlY5ZzM4YnJNKzc1SEptQUZ3K1Q3TzE2T1Jvb05nZjdpUnRjdGF4?=
 =?utf-8?B?ZmJmbmN6WHpuY1FocDV2aXlJMVBoSnRPUHEyUDJVVTVWNndjR2NZSURJamFN?=
 =?utf-8?B?TW5WOVdiTnZhb2NaZ21jTGZjTS9kd1UybmkvdkphQnBaYnVOZHh4S0hnRjNZ?=
 =?utf-8?B?MjBYdHlkVkJUc051SGhLOERIeGlZbHlZenp1aEtLZ1hkWWN4TnRKTExRQ1JO?=
 =?utf-8?B?NEkzRXR2cjlhdzFVNU90cXBSWlNyTXMwWUlpUjFzWVl2clphbU5IUWpCNjEz?=
 =?utf-8?B?cm5VM0FjWVdraUorTXNqZ1h2WkVCVHdWditJTncvL0dkWnZBb1ZUQmRqaGhH?=
 =?utf-8?B?MXErSXJxVDdMV2dieUZVY3ZqSGRPZG1WTWdEQ3V1dG1mN0NYL3V1eVJMM3Bp?=
 =?utf-8?B?QzR6NHVRTDlNZ1BaWisyLzIvWkkrL3YvY216ZXgrMDZDWWNacnpkRGZFTlJo?=
 =?utf-8?B?VTdWOWlEcVdTRURjMzdoakNlU00wbmVuZHJ2YUd6Z0lEVVAzUE5VNzNHV1hq?=
 =?utf-8?B?WGkzWHpId1ZjTnhGQ2NodncvQUNJUEtnd0VLUlpGbHRnMG5wdGJ5czlUUTZs?=
 =?utf-8?B?V2lNR0xWU1Zyc0dYejRrZmpyNmszQmkyQzhVR29QdVJpZkZHWXNXekxmY2dh?=
 =?utf-8?B?Si9YOTRUZmlVYndIK3VtU0xGcWNQbGtJSnJUZWlLQnlWUUFZVU5CVCt2NXZE?=
 =?utf-8?B?TlArckNzYkZYR0UzaHc4L1o4S244OTZ1L3A1czJLdmdvRWphVmJZWVNwTWRi?=
 =?utf-8?B?cmtVaXM4eU5pUG5GSklJSnc4eFgrNGpzR1VNSlBGb3N5M2hUUm5Td2NxUHla?=
 =?utf-8?B?ZS85OWZsWVJrQVZuNlNCS0JVeGdHRkM4OENBeDhaQ2FVWGgxR3orYjR2dW12?=
 =?utf-8?B?QlJYcFBpeWRIeHlkN2xGYUltelNKR1pkSmhhOGNZMTlYdU1qb3NFaVo2bWY1?=
 =?utf-8?B?RGFQbkErNDQwN01Fb3VJWlk5THZQd090eHBYUENPQWVpdFZ0eFNXWHpUWHRy?=
 =?utf-8?B?N0R0eVFkdWsxaU9aWGtqWXVIVDJZRmlFdGFnTEUvOGMxTEo3YnRzTkNDMGlS?=
 =?utf-8?B?dFFDM1V4MWtFVTJuVDdPc2REMWR5eTdoSnpZUmV6REdIVGNIeEJVZ0RkcGZO?=
 =?utf-8?B?ZFFTYnpsSVlLY0t4a1lJU1p6SFloSzdLR0lYK296UFl0dEJHd1hOdlU3cmtN?=
 =?utf-8?B?NGZQOFhuRy9JYko2NFRNUm1UYzZHWDgwbnRjRklRcTRkbXloNUUrYkt2dEJw?=
 =?utf-8?B?YVNsM0hzRVNLeDFpTWxoSjE4aURvOTBXbGRSc3hXMWNnT2orRXpncUtHTi9q?=
 =?utf-8?B?aVllcWtmQ1RzdThYMXhEUEc2Qzl6VU0xZkxCeUZFcFNzWjdZeitieDN6YVJX?=
 =?utf-8?B?ODdmNkE5UjlDQkJTa3AxSlFxYnVEVG82M3Z1Vnc5VFJkSU9LU2pmbVdCQ1E4?=
 =?utf-8?B?NzBkVEphT3NiT09JSmJZTWVlc1gzVXRNU0k2SSsvZXRia3ZmNkpoUVRLQTNj?=
 =?utf-8?B?ZlRxck1GQ1hxNzZ4dWlYeWJ4bXpzSzJ0aTBRU0ZwUGxaN1B5Ym1wUm9UdnY1?=
 =?utf-8?B?dmNCMEM3RkE1THNzY3VOUWsxbktYaFIwZ3Ruc21PWnZYL2FxTi83b245QkNj?=
 =?utf-8?B?OTFTSHBWTE9nalUzaWJjc3VxeFlsZ2hxT2JHeFRPVkhuQkk2ZGErQk9rcmMv?=
 =?utf-8?B?L0x1VTF1NmJhNGk3amZzdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGNWZm9SNGg2cU1TZnNIRWpTLzBySTlSTTdmeTg4UmxBakhQbGJVakR4a2N4?=
 =?utf-8?B?c2V3ekFhc2NDTFpyTVlQT2JwVGZiL2R0WHoyeUV2MHVVYTNncjJxSnpocjRJ?=
 =?utf-8?B?RGlnWERDdDBGRWIvSmk0OHF0Qjk1eE90cjZyYkVDNzN5M1ZHRXU2SU02aEVW?=
 =?utf-8?B?M0h3T0ZlT05POHI2WUh2Qi9jQUYxd2RRUWd0NUhLWi9DZFpoUTdwaDcvaHhw?=
 =?utf-8?B?bndCTGVlT2VxM2VlMVQ1ZFNzT3JId2I4eGVwVWNOUjJZMFZSUkkrR0lmQkpL?=
 =?utf-8?B?dTBYQzc2Qmw5Z01qRXl6d1M4d251ZTlkUHIvM1BXK2ZSVGRoVDRYYVVtbEFG?=
 =?utf-8?B?MTJ6UmdJS215c2RmN2NjZkJmMm9wWVdkZDJjMS8rMW11OTE0VHZKQzRZdGNE?=
 =?utf-8?B?c0ttektvNS9Za3lvTGk2TXZjM3JjV1RTRFA0UEg1SEtvNkt2Qjh1Wi9DU2h1?=
 =?utf-8?B?SnlCeWhzZWxHRkNWM2FNaDk4cE9VNTZhTElZMnp1YTR2c0xXWFkrL0doU0Fi?=
 =?utf-8?B?bVRXRXA5V1RaNVA1UzN2UUlTM2pCSXVsOTBzbmcwTVNvOHk1cU1EbmJJWjN2?=
 =?utf-8?B?YmF1eEdqOXhmWFpDZ1AvOUJFS1lPUVZzNlVaNUhjQXV0c0ZnVlNOL25oUHVx?=
 =?utf-8?B?UERicmxvR0VPN0M4Z3FGa2UwcCt2WisxMGt1WFVncUlaOFNVOUVoTVYvRGlS?=
 =?utf-8?B?bm9hTnlpZlBiWVZnME9XK2dVZ1V4YWlpSjhYcFV3bVRMZWk5YXQraVpWb1Zv?=
 =?utf-8?B?eHRmSWpOallVd0oxMXozSkRwdTIvb1lBclNvR25aSzI3R01GeEtlazNtYm5T?=
 =?utf-8?B?QVZqekx4c1ZmYWtSajdiMWJNdWZaRjNUTVlVL0lRb1ZaRVkySE9IMWd6VTZa?=
 =?utf-8?B?dkROUGdSY2xzb3gyQjhacW1xa1c1MkRyYnhuNHkrbzQ0NEZjd1kyMTlYWk1v?=
 =?utf-8?B?U2piRmwvK2d5aE5scWJ6bXVsUzNYMVduYXo2cEhNYVJ4QzBNRFFyMHpaN2h2?=
 =?utf-8?B?eGpiUmZQdWN3SVJ6dzIxbkhRUEsvQlZHN0JyKzIxRmxDTHdTbGpNaXcvRjAy?=
 =?utf-8?B?ekpnWnJCeTVzOHV5U0JzdlZjc295MmdJOEFQbS9pbndxcGxDS0VkakdGc1Rs?=
 =?utf-8?B?YTcrTFhma3k1bWNWS2hvdmNoNkZnVDloQS9vZFJ5TVluWkpUUkNkNU1iajBS?=
 =?utf-8?B?UEtZSis5K3Y2Q1BRWFdBNHdwZ0ozenBWZlRQeE9ZVHlPOHNjVzArbFllcGJQ?=
 =?utf-8?B?SzVRUzZoaFNwNkZaZnIyMks4Wjk3dFVmTjhjYXo0enU1NytEQkQ5UzVpMk5E?=
 =?utf-8?B?bHhGbGoxTEVTS0RxN2RxYzNGbFpJNXQ0UFA4RUlrcEpPdDFHbEZzQUlGTnh5?=
 =?utf-8?B?bU9haG85bHNzczAvWmVWbWFIYzNXQ0toNERzeEdTOUxzeU1RTzBwSDZhVkxQ?=
 =?utf-8?B?aStNZTVWaEM3NjQybjhVdEFOa1k2NGdvS0o3TzFkRjlSRnZuNml2d1ZZV0RB?=
 =?utf-8?B?UkVsM2ZUd2xPT2M2NmhySHNzR3NOU25nQmVIcWczUmJHVC9VWW90cFVSSVha?=
 =?utf-8?B?ZmxPa2dkTGdWMVBBMXI4cFJUVTRKaVlXZHBoTHRTd0lVa2RoQXlIRWwyQVVV?=
 =?utf-8?B?ZERZTTFNSjNBallQMXhKTXdaN2I4T1FJb2RNT3M1YXlGSUo2azVmVlpsVExP?=
 =?utf-8?B?M3hUSmsyRkJVdENlemwrblloWUk3Y3RuUmRjNmdEdzJZSXByQzRWTkxLUURa?=
 =?utf-8?B?Z3FFQ2hkMVJIbzYySDFzWEFZeEM1ZmNZQ2ovdjFKNXRQSnZXL3VwNDQ2dTdJ?=
 =?utf-8?B?UE5UdkhQWWFzbllXY2dPbGJZRjVDakcwTXlnTzFJWnBNcitjRFhaakUvd2E4?=
 =?utf-8?B?dlU0K3lIdEd2UmRDdDg2SmIyOXl6Mk1OMDBhMHhEWmlIRnNtTk1pNVhhMXJn?=
 =?utf-8?B?V0JmOWxlUzdMZlJqSFNJSm9pQjBWVWE0TW04MGI4aVpRaGhBd3RNY3M5WEox?=
 =?utf-8?B?Z0c5d3A0QnFDY05aR2Y4SWVwK3pKNzY3RlZNcEJXTVcvTWRQY2tuR3puQzlm?=
 =?utf-8?B?K0w3dGV1VWJvT24xVEwwMWlPazg3UDVlYkd0QmpEZzA5ZlZBYU9DOU1WeGNw?=
 =?utf-8?B?enNZdFpvQVNJTkJNM3IzTnJkVmVyQ0UyLzIxQ2lzdWRZNkxJL3FCTDlSNlQ3?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f456a117-3d8b-4ddd-ead3-08dd75d784be
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:24:26.4072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5mH6HgHmgg7Xgsr2OS8qP3W0rPFeZjR9lY/vTyjLuR4xmB1OJWV5V6EhhPv52+qgQYEQM5+v2ky8uS+XFhorSADlqWD7SkCnJ1TGKFAolA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8347
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

On Mon, Apr 07, 2025 at 03:18:36PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Monday, 7 April 2025 14.42
> > 
> > On Mon, Apr 07, 2025 at 02:25:46PM +0200, Morten Brørup wrote:
> > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > Sent: Monday, 7 April 2025 13.56
> > > >
> > > > On Mon, Apr 07, 2025 at 01:32:59PM +0200, Morten Brørup wrote:
> > > > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > > > Sent: Monday, 7 April 2025 12.41
> > > > > >
> > > > > > On Mon, Apr 07, 2025 at 12:15:13PM +0200, Morten Brørup wrote:
> > > > > > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > Sent:
> > > > > > > > Monday, 7 April 2025 11.49
> > > > > > > >
> > > > > > > > On Mon, Apr 07, 2025 at 09:04:05AM +0200, David Marchand
> > wrote:
> > > > > > > > > Hello Bruce,
> > > > > > > > >
> > > > > > > > > On Tue, Apr 1, 2025 at 4:08 PM Bruce Richardson
> > > > > > > > > <bruce.richardson@intel.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Mar 24, 2025 at 05:30:26PM +0000, Bruce
> > Richardson
> > > > > > wrote:
> > > > > > > > > > > Traditionally, DPDK has had a direct mapping of
> > internal
> > > > > > lcore-
> > > > > > > > ids, to
> > > > > > > > > > > the actual core numbers in use. With higher core
> > count
> > > > > > servers
> > > > > > > > becoming
> > > > > > > > > > > more prevalent the issue becomes one of increasing
> > memory
> > > > > > > > footprint when
> > > > > > > > > > > using such a scheme, due to the need to have all
> > arrays
> > > > > > > > dimensioned for
> > > > > > > > > > > all cores on the system, whether or not those cores
> > are
> > > > in
> > > > > > use by
> > > > > > > > the
> > > > > > > > > > > app.
> > > > > > > > > > >
> > > > > > > > > > > Therefore, the decision was made in the past to not
> > > > expand
> > > > > > the
> > > > > > > > > > > build-time RTE_MAX_LCORE value beyond 128. Instead,
> > it
> > > > was
> > > > > > > > recommended
> > > > > > > > > > > that users use the "--lcores" EAL parameter to take
> > the
> > > > high-
> > > > > > > > numbered
> > > > > > > > > > > cores they wish to use and map them to lcore-ids
> > within
> > > > the 0
> > > > > > -
> > > > > > > > 128
> > > > > > > > > > > range. While this works, this is a little clunky as
> > it
> > > > means
> > > > > > that
> > > > > > > > > > > instead of just passing, for example, "-l 130-139",
> > the
> > > > user
> > > > > > must
> > > > > > > > > > > instead pass "--lcores 0@130,1@131,2@132,3@133,...."
> > > > > > > > > > >
> > > > > > > > > > > This patchset attempts to simplify the situation by
> > > > adding a
> > > > > > new
> > > > > > > > flag to
> > > > > > > > > > > do this mapping automatically. To use cores 130-139
> > and
> > > > map
> > > > > > them
> > > > > > > > to ids
> > > > > > > > > > > 0-9 internally, the EAL args now become: "-l 130-139
> > --
> > > > map-
> > > > > > lcore-
> > > > > > > > ids",
> > > > > > > > > > > or using the shorter "-M" version of the flag: "-Ml
> > 130-
> > > > 139".
> > > > > > > > > > >
> > > > > > > > > > > Adding this new parameter required some rework of the
> > > > > > existing
> > > > > > > > arg
> > > > > > > > > > > parsing code, because in current DPDK the args are
> > parsed
> > > > and
> > > > > > > > checked in
> > > > > > > > > > > the order they appear on the commandline. This means
> > that
> > > > > > using
> > > > > > > > the
> > > > > > > > > > > example above, the core parameter 130-139 will be
> > > > rejected
> > > > > > > > immediately
> > > > > > > > > > > before the "map-lcore-ids" parameter is seen. To work
> > > > around
> > > > > > > > this, the
> > > > > > > > > > > core (and service core) parameters are not parsed
> > when
> > > > seen,
> > > > > > > > instead
> > > > > > > > > > > they are only saved off and parsed after all
> > arguments
> > > > are
> > > > > > > > parsed. The
> > > > > > > > > > > "-l" and "-c" parameters are converted into "--
> > lcores"
> > > > > > arguments,
> > > > > > > > so all
> > > > > > > > > > > assigning of lcore ids is done there in all cases.
> > > > > > > > > > >
> > > > > > > > > > > RFC->v2: * converted printf to DEBUG log * added "-M"
> > as
> > > > > > shorter
> > > > > > > > > > > version of flag * added documentation * renamed
> > internal
> > > > API
> > > > > > that
> > > > > > > > > > > was changed to avoid any potential
> > > > > > > > hidden
> > > > > > > > > > >   runtime issues.
> > > > > > > > > > >
> > > > > > > > > > > Bruce Richardson (3): eal: centralize core parameter
> > > > parsing
> > > > > > eal:
> > > > > > > > > > > convert core masks and lists to core sets eal: allow
> > > > > > automatic
> > > > > > > > > > > mapping of high lcore ids
> > > > > > > > > > >
> > > > > > > > > > Ping for review.
> > > > > > > > > >
> > > > > > > > > > At a high level, does this feature seem useful to
> > users?
> > > > > > > > >
> > > > > > > > > This seems useful, though I am not I would touch the
> > existing
> > > > > > > > options.
> > > > > > > > > I would have gone with a simple -L option (taking the
> > same
> > > > kind
> > > > > > of
> > > > > > > > > input than -l but with new behavior), and not combine a
> > flag
> > > > with
> > > > > > > > > existing options.
> > > > > > > > >
> > > > > > > >
> > > > > > > > That would be an easier patchset to do up. However, it
> > would
> > > > then
> > > > > > mean
> > > > > > > > that we have no less than 4 different ways to specify the
> > cores
> > > > to
> > > > > > use:
> > > > > > > > "- c", "-l", "-L", "--lcores" - and therefore need 4
> > different
> > > > sets
> > > > > > of
> > > > > > > > parsing options for them, and more checks to ensure we have
> > > > only
> > > > > > one of
> > > > > > > > the 4 specified in any run. That's why I chose the modifier
> > > > option,
> > > > > > and
> > > > > > > > to try and consolidate the core setup a bit.
> > > > > > > >
> > > > > > > > However, if having a completely new option is preferred, I
> > am
> > > > happy
> > > > > > > > enough to do up a different patchset for that.
> > > > > > > >
> > > > > > > > > I scanned through the series, not much to say.  Maybe add
> > a
> > > > unit
> > > > > > test
> > > > > > > > > for new cmdline option.
> > > > > > > > >
> > > > > > > > Sure. Once it's decided what approach (if any) to take,
> > I'll do
> > > > up
> > > > > > a
> > > > > > > > new patchset, taking into account any relevant feedback on
> > this
> > > > > > set.
> > > > > > > >
> > > > > > > > /Bruce
> > > > > > >
> > > > > > > Changing the EAL parameter parser to a "two pass parser"
> > makes
> > > > sense.
> > > > > > I
> > > > > > > think checking for existence of more than one lcore
> > specification
> > > > > > options
> > > > > > > should suffice; we don't need to accept multiple lcore
> > > > specification
> > > > > > > options and check for conflicts.
> > > > > > >
> > > > > > > When remapping, do we need to support gaps in the "lcore"
> > > > (logical
> > > > > > cores)
> > > > > > > array, e.g. for secondary processes, or can it be continuous
> > from
> > > > 0
> > > > > > to
> > > > > > > the number of specified lcores?
> > > > > > >
> > > > > > > And are new EAL parameters for this really beneficial?
> > Doesn't
> > > > e.g.
> > > > > > "-l
> > > > > > > 0-9@130-139,100@140" suffice?
> > > > > > >
> > > > > > Actually, I believe "0-9@130-139"[1]  is not the same as
> > > > > > "0@130,1@131,2@132,...". The latter affinities one thread to
> > one
> > > > core
> > > > > > ten
> > > > > > times over, while the former affinitizes 10 threads to 10 cores
> > -
> > > > > > leaving
> > > > > > those threads free to move about within the 10 cores specified.
> > > > >
> > > > > Interesting. The documentation [GSG] isn't clear to me about
> > this; a
> > > > example there could help clarify.
> > > > >
> > > > > [GSG]:
> > > >
> > https://doc.dpdk.org/guides/linux_gsg/linux_eal_parameters.html#lcore-
> > > > related-options
> > > > >
> > > >
> > > > Yep, agreed.
> > > >
> > > > > If users are manually passing lcore parameters to the EAL, then I
> > see
> > > > why some sort of remapping shorthand is useful.
> > > > > IMO, if the mappings are relatively exotic, it should be
> > acceptable
> > > > requiring an external script to build a long list of mapping
> > parameters
> > > > and then invoke the application with those script-generated EAL
> > > > parameters.
> > > > > This would reduce the scope to support relatively simple, common
> > > > mappings.
> > > > >
> > > > > Could we expand the --lcores syntax to support common mappings?
> > > > >
> > > > > E.g. "0-9@130+" to do what I thought.
> > > > > The lack of "()" treats the entries individually (not as a
> > group),
> > > > and the "+" indicates auto-increment.
> > > > >
> > > > > A more advanced example:
> > > > > "0-9@(130-131)+", meaning lcore 0 gets cpus 130-131, lcore 1 gets
> > > > cpus 132-133, etc.
> > > > >
> > > >
> > > > My issues with the above syntax idea is:
> > > > * I think it's overly complicating the lcores parameter adding in
> > the
> > > >   support for the "+" symbol - especially in the advanced case
> > example
> > > > you
> > > >   provide. I worry about code maintainability here.
> > > > * More significantly for me, I think it's also getting things
> > backwards
> > > > in
> > > >   that it is focusing more on the lcore ids visible to the app,
> > rather
> > > > than
> > > >   the physical cores to be used. For the example above of 0-9@130+,
> > > > what I
> > > >   would expect is that the user is mainly thinking about the cores
> > he
> > > > wants
> > > >   to use 130-139, which are then to be mapped to lower ids. If we
> > had
> > > > the
> > > >   syntax reversed where the physical cores were first, I'd say it
> > would
> > > >   make more sense, e.g. 130-139@0+
> > >
> > > I 100 % agree on the syntax being backwards.
> > > A good reason for introducing a new parameter, rather than expanding
> > on "--lcores".
> > >
> > 
> > Yes and no.
> > I agree with not expanding on --lcores, but I also don't think any new
> > parameter added should attempt to reproduce all of what lcores does. I
> > would leave --lcores as-is, as the power-tool for lcore config e.g.
> > what
> > you talk about below for mapping multiple lcores to the same physical
> > cpu.
> > 
> > > We should consider deprecating the old (backwards) syntax, so users
> > don’t get confused about one EAL parameter being "backwards" of the
> > other.
> > >
> > 
> > I disagree with this. I would be ok with deprecating the old "-c"
> > coremask
> > syntax - I think the time is long past when we should be dealing with
> > masks. However, removing "-l" and "--lcores" flag is, to me anyway, too
> > big
> > and jarring a change for end users for us to consider.
> > 
> > > > * finally, as I found out last month, there are systems on which
> > the
> > > > cores
> > > >   are spread across numa-nodes on odd/even boundaries, so to have
> > an
> > > > app
> > > >   running on socket 0, you need to give the core ids as a list i.e.
> > > >   0,2,4,6, and cannot use ranges. [This also reenforces the point
> > above
> > > >   too, where again it's the internal ids we need to generalize, not
> > the
> > > >   physical cpus]
> > >
> > > For this, we could use "/2" (like in subnets), or "+2" as increment
> > parameter.
> > >
> > > >
> > > > My thinking on the matter, and I'm happy to be corrected if I'm
> > wrong
> > > > here,
> > > > is that end-users are unlikely to significantly care what the
> > actual
> > > > lcore
> > > > ids are internally in the program, so long as they work and are
> > unique.
> > >
> > > Generally yes.
> > > Note that we should allow the same physical CPU core to be assigned
> > to multiple lcores...
> > > If a CPU core is shared between multiple worker lcores, then it could
> > be problematic, but with a mix of lcore roles, this might be handy for
> > some applications. E.g. a virtual machine with only one CPU core could
> > use that single CPU core as both main and worker lcore, or as main and
> > service lcore.
> > > Sharing an lcore between threads requires the developer to take
> > special care of e.g. spinlocks, but the EAL parameter parser should not
> > prohibit it. It might log a notice, though.
> > >
> > 
> > This is already taken care of via --lcores, so I don't see the need to
> > reimplement it using a new flag also. Any new flags we add should be
> > kept
> > deliberately simple.
> > 
> > > > What does matter is the physical cpus on which the code is to run.
> > > > Therefore, my approach to this is to find the simplest possible
> > > > solution
> > > > whereby the user can just provide a list of cores and tell EAL to
> > just
> > > > map
> > > > them to reasonable values. For the "reasonable" values, I would
> > imagine
> > > > that for the vast majority of cases starting "0" is what is wanted.
> > For
> > > > anything beyond that, we already have the existing --lcores syntax
> > to
> > > > be
> > > > used.
> > >
> > > Agree with all of the above. :-)
> > >
> > 
> > Great. That still leaves us with the problem of what exactly to do as
> > the
> > best solution. Here are some alternatives that I see:
> > 
> > 1. Add a modifier flag for -l and -c parameters to auto-remap the lcore
> > ids
> >    to zero, so user is just specifying physical CPU id's.
> > 2. Add a new flag for specifying physical cpu ids, which auto-remaps
> > the
> >    cores specified to zero.
> >    2a. To simplify our code and user experience we could at the same
> > time:
> >        * deprecate "-c" flag for coremasks
> >        * make "-l" and "--lcores" the same flag just in long and short
> >          versions. This should not break anything as "-l" parameter is
> >          just as subset of what "--lcores" provides.
> >        * that would leave us with effectively two core flag paths:
> >           - -l/--lcores, behaviour as now, full explicit control
> >           - -L/--lcores-remapped, takes simplified core list (only ","
> > and
> >             "-" supported as with "-l" now), and maps them to zero-
> > based.
> 
> +1 for 2a.
> 
> > 
> > Third options? Any other feedback?
> 
> If the internal lcore ids are effectively hidden by passing physical CPU ids, any related options should take physical CPU ids too. I.e. the options for choosing main lcore and service lcores also need variants with other names.

Yes, I suppose so. That may be tricky, but we'll have to see what we can
do.

> The service cores are passed as a core mask; this should be deprecated (like "-c"). And superseded by a parameter taking a core list.
> 

Yes to deprecate -s. I believe -S already exists to take a service core
list, so that can be marked off the list.

/Bruce
