Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91EACAC58E
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 14:35:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19CF8402E9;
	Thu, 11 Sep 2025 16:35:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 52510402C4
 for <dev@dpdk.org>; Thu, 11 Sep 2025 16:35:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757601340; x=1789137340;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WosBjMSn/X1+UoB9ueIWLMm/3kYDJotWmdNEpIdY9TQ=;
 b=KRY19ZbqJFU7ybBNGHXTJlC47ib8hKvLurYeJeV9y5Ua6AXqSd1K8ElN
 NPBUNlSGd7YN8aAwcHC1XMFVXwxDW19/SFTHkuEWQncy6g/19uEa2AVzp
 6nVJLb20IkwDwOsibP9jinuzEm7XeAOku5AJ1xItCn4rODh1CNLr4o5g0
 qhnDBs2t6ej3WZa1K2otm0c7bsPqMH6EVh6pnj3gYW6hQRU/b9rATyc9h
 /tW8GtWp3poSwMQC1dNkoCAkVXVVvyHTs/x1Qh1/TnBm7X058kfaoolr5
 XzJZbx2TsKRjf3t368N/kPZ55zolOQ6Vec/slIW6SWJHdLOIs+x8h32MO w==;
X-CSE-ConnectionGUID: Ja9b+BCBTUq50vcpBezCqw==
X-CSE-MsgGUID: 1yRX5DybTq6hmCbguyOZpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82522648"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="82522648"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 07:35:38 -0700
X-CSE-ConnectionGUID: zx3q4nJzTzmfnAfxwYc0Gg==
X-CSE-MsgGUID: dNmxwqHrS4GjH9di2VVEng==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 07:35:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 07:35:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 11 Sep 2025 07:35:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.84)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 07:35:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rdq+UNoCLzDf+0+dpqk07BAtuXDpZejcX9b5rlpSu8JHwhe0Z6nnbzFebcdC1WJHfi/wN2vAci5VIVVMAz0ktqbVDx2j/hhe2ooxqSPJRxoyXInQTaRMwT8d3fpcNrVeqffalaWDu86a26O08KXncT/UH5xgHmu9120cggcypjodH0BS8vE1uiWW7a8Ce+INSvkUmljLrsBXKxnlCiq3Not6qDH0MrFfA3Nhogz5bhvXS2dOzQDlIQII0oU8D6cgtUApwVQcKmEMxj8UGhkEZr3oIOBXYvhlZ5JnsL9xqrceKgN8paycyjdkJEvfby2jNXvB4xpCl2FFilsaHcXCGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMvDX6mXXitqPnwAL6HmRrG0JpUv/aHIXwHS77Mo++U=;
 b=nKGRwnDFuNxvAvatuosCutbSPx78NfaWvlSksWdRKbmIvfsygcFOeP3I3sHRzjkaSe4jnJ5VD2cdsdmrHDXe8Et9l70skYdKwEw1A+b+IoeF71OT9A4AGHITdHi+trEc3dTQDrsAA8P3uKi9KBUTjiDSu1/g3LIZYYM0HJ765ddI0975zKFlcUm1DhsZDiuOoQ4FX+r7L7oA9KORZwzeXO33mXHMgsVGySo4BxG4zY00vGscAJPgYs9Z4SELVdD0fx+vDUQfC7MaM6QA6G3AxW0FkI3IkfQ+nE9dME1DLOHSXBDnWxD370f6VVl/PPhqz266mTHLnUWqj1Jdql3n5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB7496.namprd11.prod.outlook.com (2603:10b6:510:280::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:35:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 14:35:34 +0000
Date: Thu, 11 Sep 2025 15:35:29 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 1/4] net/idpf: use the new common vector capability
 function
Message-ID: <aMLeMQOKemomvoO-@bricha3-mobl1.ger.corp.intel.com>
References: <20250911143145.3355960-1-ciara.loftus@intel.com>
 <20250911143145.3355960-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250911143145.3355960-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0230.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: b52145a6-e146-46a1-d902-08ddf14077cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2vGccXldr85xdUYCStTUh5XIuOMJFESGP1EWxsxngfW6uyr84S9mPmv82opH?=
 =?us-ascii?Q?uXTRETuJ7rGu81NGEiuy1uTExbGkpXv2rRKPOXpgkupA68aknETgod8NIoFF?=
 =?us-ascii?Q?2bKF+V2ERzw58bvQczcnfDxW8S2ssD3gMvhPGxTf4OmksET16aRBUw5ZGikn?=
 =?us-ascii?Q?2e6QXNpUJJ19irSE70BO4zxZ2X8WbJQbGZWWYx3f0fN2IhEMGx3ymfkoQZWX?=
 =?us-ascii?Q?drGuKQwDvHs3FP6nftConeb0hcJ9M4vO+Jrdy/M5N/amTWsSQqEZD/rrJuCy?=
 =?us-ascii?Q?4pddAdi/xpUrixRi1trBJaIHzK1nCeTeUkTOvmv9qDf7RSROkhbgjsF3zzFl?=
 =?us-ascii?Q?sfL5Q0JO20CU3R83hHVpVVZb+TAz5echT+q30P20nwzrc1MZ7NpVGs1FAMAM?=
 =?us-ascii?Q?y1u8n0JaIeWMz09GnCKHc2C9APKJOsfvLN5B0Gzyo4Ci4Ur372TCTtML0y8g?=
 =?us-ascii?Q?9lVcHJadW6kiyh1MrPjwgIAgr60wDhqkxuP6ISF3oEf6bPF64B+zatZmhEsx?=
 =?us-ascii?Q?Sq1gHrCkKukyfdu5/DUTKBv0Tszbwa7N4dmj8A0ATmQDDA5qkTgFIWAkqrd0?=
 =?us-ascii?Q?iHtSWfKzcCN9WVJm5S2C7hmeFh1btgM4Og+I/JMtRNzNOfIT8r/8E7IpU7xf?=
 =?us-ascii?Q?FnnavtNN4LKXYA55PHwfBjJY2yU+m1IWQ8l3difg+hkCHQCf+RWTJlVp3paV?=
 =?us-ascii?Q?XhYFR8+GE6fTyzMxec3qfFA7NktLrwkI01BFfFUQqFWS2P/7D1Cw6GKEcxjk?=
 =?us-ascii?Q?QEmojMWGG1n3HcDi1QlXu2A4f5JSnMfA8edOir7zLxDKtaScvqzvnon+8dJ7?=
 =?us-ascii?Q?0ZUr/kj8C/mkz2Z7rdExlDXVTJD8s0yZ4zckAU6pefndNqyxaPm6AbP0MkPR?=
 =?us-ascii?Q?Jr9ZOnc3QWI5VsDWnADR37ORM6EuvWyHU7fejk//rzDtk4B5x8s5/lTSspUG?=
 =?us-ascii?Q?jl846Wo0rl2LxoyN1TfgUowUhEAooTBY+EnbAqhLy3nMuFjzgWAiL0YS1KmW?=
 =?us-ascii?Q?I3NcWnnOtIPspcquLw16N5Te+WQS3IslkJbsztNzInLNgOEfvLIU4tmR5Bk9?=
 =?us-ascii?Q?OouWg3qH39Rv1jsERZE2lY2NEP5Q4/RIHuPd0FhumpzzH5Go8IrrYPUX64Ln?=
 =?us-ascii?Q?1p/PewMDogX3RQ+eC0WiR5rOWGI+sa/cth7AWAdg20L4uKAYwAeqR8o7gjGv?=
 =?us-ascii?Q?4DwYF1YyV/atymam7v7ifM+lFKs02viyZF/58HaTxBAuE8q88v8jbg/cz0b3?=
 =?us-ascii?Q?Izqpd+HlzP37SAusZ4a0xsCPGjL17AoxtFjZMz3NK11zaG5p2MZderFiiFfJ?=
 =?us-ascii?Q?7VAYyGlZ/w077ZKT/QF3Z7HGe2bQn01ao+cDKSKDG0FamO4PqCIPlZvwKDKl?=
 =?us-ascii?Q?ttR0LaIsUd2U6RYUzuWA0VMPPWv0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?daR06ZyJrRXn0zpmt59TUXvJ0q7ro+madnLwX+mI8WaazsrxY4w6zHJvtRvL?=
 =?us-ascii?Q?/ASchvW05g05pQaH+sUkR8BmVwgB/iaFdgdptXHgh25vbXB7NdB4G5wsufHp?=
 =?us-ascii?Q?zxroU7t1PcA51b8XY223AcBT+nc+bfZNpEnJUFDCfBBkKR3SC5czHnAwwx54?=
 =?us-ascii?Q?3pvW7JMh8V6RzlLWA7nnkmG9jZUnvzgG1YXbBSDdzaH3ex7653SFjQdOFprR?=
 =?us-ascii?Q?AgkVER89ZabLV8+I7Apy1V5aF6kCcZ9O7zbYry00JNFmY/0YokZDanLiSx7W?=
 =?us-ascii?Q?kDmwcmxbbPD232ONTl3EJlQW2/e8JoqGYvIR2BObTYBxFBhVPe8tyAEKj8St?=
 =?us-ascii?Q?mA7ZGc+TKI3q7tzTYA5rJR7sDsbN+d8uWq7zUf4HEqtG0n97KPBmd90LvEkD?=
 =?us-ascii?Q?0/MFoLZcSTyKYynnCK6XqKKjloX4GUB7cPSMOw/aKusntJPCcf7HEJOlDneS?=
 =?us-ascii?Q?tMk/yDoenOOnoiSBMqaSk7ncr28KxvTxZYg2uQwBgTVGhQi8m+7qtekpBu+v?=
 =?us-ascii?Q?U5Dg4jbKyBSPod8P/kXvtWbldpIIcrqLD+/1NJszLuzziSiJ1dcLMlUSM1tV?=
 =?us-ascii?Q?0WHblXyJhTmvchv3bWNnoGQsz6y59lIF7YC7i1/tosjhEObhsfkVCmuFY+Hi?=
 =?us-ascii?Q?LGU9JGMH1VWMj72glDUvALdLIDAoXG5FqO5W3DiVrvf/Eor69+yc3FuJueK5?=
 =?us-ascii?Q?LI4ymnJdBacTTeXosoA78rpfjCT60vOF/leNcnESYGRd+2GG9j0Ej7Px0GoE?=
 =?us-ascii?Q?Tp4iIUbVVJ/vOimFxnPpQuooAQcS6NLA36FTmWh5wE15g6vmvvqlCYPAzV5z?=
 =?us-ascii?Q?VXMdis0xiMkT/NiL5Rm7F6aLsMvixbINQ123gsbyPmE9sx1csEnEdy6vvlBw?=
 =?us-ascii?Q?P3BGFpiWQd7aIgK7YTY9u8l8hFPz3mmKPM2wkuosTIfAcTAq/jsNOrQTmpy1?=
 =?us-ascii?Q?ZOGpEux+Ta2kGBg7tVEt3Fp0gm+0avTpmZDq4g+rsrSWIoHUVGf9H/fnYLFt?=
 =?us-ascii?Q?uSC2haKsfA+OExU2cbUGBTc6u7L1PlNL88TdEej6Rlw32x+PdTOBrxvYrMo2?=
 =?us-ascii?Q?h1WZv7XB+vytLq4RuY4HpjcUZ98LAWNb72MvigD/e+3xBbY+5MsvrhGaWiE9?=
 =?us-ascii?Q?taOlbRvMrRnakCkKGgUmC5p0MclkFqtdCZtiT8+1/Ojos9CdyvghUCpzypgR?=
 =?us-ascii?Q?Qz0LeXjc1lCPhH1NsFJom5q+7+HYJEb3svVnUc7m7Bx35GVhSnGKePqvKJxJ?=
 =?us-ascii?Q?+NjRpANCIwzR9l3uun+2pLQVWYuTu3V89fKjtqQ7naNdzTcqs/dNwFbtWUBy?=
 =?us-ascii?Q?EchkNzoCwYrH2mFsOLaqd+/TaRf7Ri7E0pjB0IJ3u8UtIowOjURv5Ac6/m3S?=
 =?us-ascii?Q?np+oCss4SzBok/PtLIxUw1u8HrYyXpPXtGW45gKHnC59GiTQHGsnvRh29nuq?=
 =?us-ascii?Q?vm2wbn5/v+1jubsBAWr8C/yWBOWWQoCQuw814aZGxkuN7eS9ZNMD8iH9Q/MD?=
 =?us-ascii?Q?V4EaP26IgOw+j+iilxbIV+4jLYYbRKk3BMbY2Z1jJ0MryzbXUU667dibX655?=
 =?us-ascii?Q?saVahHImgANnI17KiUkkU0AVyaTjWnSH6tUfYFWFfmv6N60l2NciVtNkL4ta?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b52145a6-e146-46a1-d902-08ddf14077cc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:35:34.8533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECctfizFpJebluZbba4lQdT/Dm9d4B3Rh07VzM4hV/10TqSovXZNKENlW+/oxzbDEOYWW9obHzGv+6wNipJOzSR+lnDM9ToKravDqSpLff8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7496
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

On Thu, Sep 11, 2025 at 02:31:42PM +0000, Ciara Loftus wrote:
> Use the new function for determining the maximum simd bitwidth in the
> idpf driver. An additional check is required for the AVX512DQ flag which
> is not performed in the common function. Since no other drivers require
> this flag, the check will remain outside of the common function.
> 
DQ can just be checked in the common function too. It was introduced the
same time as AVX-512VL and BW (see [1]). There is no need for special-case
handling of it.

/Bruce

[1] https://en.wikipedia.org/wiki/AVX-512#Instruction_set
