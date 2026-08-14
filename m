Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866B2C5B572
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 11:26:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE3994013F;
	Fri, 14 Aug 2026 13:26:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 0667A400D5;
 Fri, 14 Aug 2026 13:26:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786706766; x=1818242766;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Ck9g4rQ9dcZ8ZX5gEDwRTvV1Zd/I68a4ycNTBKyzAUk=;
 b=deKUqSxxLkGeKcZa1BMI4Apf92WS3Qz3Jtpk17KdB6A4ariHsQKYHR78
 dRSQXvc8bu/hL/dLvsfaCkqLhsDuopYUj55QqeZRv3RNaZc+T/5Uzqfh0
 df6UQoJQ7kAI5IrelMm3A24CISntHbe0N0VK1J4XhAvRM7RNwKUalQ4OM
 SxpBvQNSpthi/0zzkqTOMsqp7efxBf62CDlKxHqXxRsGDN/USbnbY6FnV
 SzkDNFKiKJf22k67Q1f4m2KBp7v1ohE+sPpCZ8ITIgfx+qYgaN2m4rEto
 /wpzdlrXjVPj43ikwGZRl0tSjFO+Y/keto77J8TPz1SRN0BzPrXChQ5xK w==;
X-CSE-ConnectionGUID: Q5FGg+tDSR2qfqzHDaH/LQ==
X-CSE-MsgGUID: GuAi3GfTSTmlRYEzGPJgeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="110072967"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="110072967"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 04:25:59 -0700
X-CSE-ConnectionGUID: PUC109grSdy0eg4gmsdwbg==
X-CSE-MsgGUID: l3gnk8R0TdWnBcInYOsOTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="264810745"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 04:25:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 04:25:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 14 Aug 2026 04:25:57 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 04:25:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DnGW5A6AuK9oW6Cv0rlBIfxV6BAvVMySm67GIL6yZKoiZS/1FJeg9XfQ8HZilmTPxYYACqVsotxwlHyLWx4KaoEbQYgt2x/NpacQ3y3Hh6+H7biRmVpQVs5lbu3GrNyI6+1hUeR2C/OBITk1WVGmc4aWtAwkdDZs0pxibtTcZWjiO/YOC2aHL6sGYaUVJVkZFhD+mHO8a+qQSLEKkPRoQr6BbvukFZmcE5xqlTUCEkNuztm1ofaY9vHvnKsjaL7stduhFj85jTscwXayxKp/GLshWU2BnZZIEvjfxFaXeOQjtcc1B2x3S1BAlgO8u0IqTi4Zc0fx/R2FJzw7GnglmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcI0wfD7eq5Gqv2fWhd5fN31HjrTJPXsOYqJYe/RP2A=;
 b=ZUJ1aez4+bA2tIXGct0X6Ky3a95iXLSzYpecyP7igCmLk6lkzLpq2NS0fomaBqAhjpLh4+TljswXkkGRQ3jWltniKTAZr1HWFzPNu0LmOLFL+aUd8zUdF9eClcasghGCpBpOzjGGpeM1CnQEiBMAim4KSn9ORBE+sV2FH/6ux9nJ8NJvpAB+I+ymOpaLpUx8azfq4nXttVx2gvOjd20ssVEi8W/uwAuVTkSbCwPJHRchbr6QCxM3Xaa/vgXtzP0YmyqV5OzxLKC9Jux4MJRzfAgydN23DL2OjkhjsrALcz6kauhCiiHJ06FixATqRfWW//xG7eJl6mUmo8WClOmGPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SJ5PPF8A49C4DF4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::83f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 11:25:54 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 11:25:53 +0000
Date: Fri, 14 Aug 2026 12:25:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 1/2] net/i40e: preserve RSS RETA across port stop and start
Message-ID: <an77PfrEDxuqSBu1@bricha3-mobl1.ger.corp.intel.com>
References: <20260812143844.71339-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260812143844.71339-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0032.eurprd04.prod.outlook.com
 (2603:10a6:10:234::7) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SJ5PPF8A49C4DF4:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d7a4eb-f9f6-4abb-81b6-08def9f6cd5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aJO/NNGdX3gawwG4rU7EfzYuj5sVkY9tEZgyYreBrHPQMduoBqc4ycoX/cN/fa8hJ9QCxmbdTnVgj0rCy8WBrfDrLQgUvo9WkPxfP5JiNAs0ZfhazrFobGuZqUlmzo7rL01IOvGn9DHj4Thk+R/5PChD25FJTovdm6AIS16SFeiDul8NRvQJaeXvM8n7bzgkkbxc4AoqM49PDGItKeSpakNiidqz9N0jCT8tcvnmQG+bvoMiNLJ7g0Ph4rD0RkJENFmsjizJuMdpM2YlvwsrdikHteMK3mLf9Z95Ga4WwbuH7uBQK1VcNnegmHdlKnhlZCkWI/b5sYKaXXShEBOyr5znPShUoCNxCy3XJuUMWGnzzKxxdy3wDA9p0RQd4o09LjD0bBt15qqoMtsJw7cgnFL1seac7lO2VzT2LRNSDMUI7MxWkvB/RxFpQO10q5IxlOWAyHtasyA4b/EVeXLcWzs1G/9a0FlLKItShi8zkdyxoYS8fv76UwkYy36sYPuqBIecpcp1l72NoeH4irrLD77kQ9ueUCu2PR2LZu0du8XxPciS8DBxG4Rlg+4Uf6JrAhYtNKBiCwhGskLtokiU4UvoCqEf6XxGyKKfpWBuIkGSKwPVFwNXgo+lQr6rPtfDQNSfGTvJaEOyeyW+Q0Oy0A0wc9/NPuGhITItC5R8yYY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?798QsMSC+zS1NfbP92j2mUAJwftnHisjrs1MK1NlY/mQnpC70MAGqvlu5yzL?=
 =?us-ascii?Q?FbvkbBOSTXT7q7hoCYZd+g3IMBfXzrjA68GvGuy9k+PMcJkEiCLBPZHdzvZo?=
 =?us-ascii?Q?OPEdbQOMqpy0O7T9ZXSTBlMptRSkcuTxStO/xw4YVlMeGJ+TjI6PasTVqdAe?=
 =?us-ascii?Q?FLR+20zhHEGpxIJ2twJdXxUJ19KMa+fNC0gCrgS36XZF+2z59i3Vs/X9k/55?=
 =?us-ascii?Q?xM75w50Y9hjbqnWpVqQt4OcvR+yM0ftqFoml88lwA1ICiiy32A8cbFmkS5mF?=
 =?us-ascii?Q?glHYhRdftXYwfesMByC06+DH6sA2jI+nw+DBkceZJyUWKKubNda4gXi93/QK?=
 =?us-ascii?Q?yo+xciJvMU+pi08u2j4mVnWGYsQIPL+wZqkz4Ol/D8woSnm5UpW1p98HRkfU?=
 =?us-ascii?Q?krKANLR0jFQcS/0Ir/hN0wKNhVIlBf8WzaYwUfK0ZY48l3SeKJCverChUVbc?=
 =?us-ascii?Q?Y9WD+NWmmBKTn31dPR1fF92DHxHfOsvF6KraR1KqK5aI1LSrXp5eArhRjXDP?=
 =?us-ascii?Q?wz2UQjJ9Bvt4nfRqlQBsSDvUXUlff+sji2N8KEwYnIwLGf+kxNuSTx5uL6d1?=
 =?us-ascii?Q?uEN/gYIzqftocWLr1dstfAnScaCMNW3FU4hNB3DEyXJZVeOVriKP7YfuSOW8?=
 =?us-ascii?Q?ltdko7V6LjnfSvoReUR2Lg4B1xgXFevjcF7Y2535IEAzwveNJBAGSHJThWMC?=
 =?us-ascii?Q?nkILq8oR4s2UxAEQLXykzAdQAfLJExA6hmjDXY8WhqS1Stlcti08Rd0AWj1I?=
 =?us-ascii?Q?ZldpspmbFJAd93PgZ2hlRFn67zoSnsHiQnEnB9PRPxxIJoFFlXTB4Po0yvh4?=
 =?us-ascii?Q?tpjwRpk+THXk7fkCr9YXRGr6vRurXLl1hOfkZGYL/7RShLUdV7xgyg4XOpEB?=
 =?us-ascii?Q?YgElKGdxEOUPhYMXZkdWRtiMMTJbmRzDCwp99gc/AzCCjdg2JGCZyhyuT549?=
 =?us-ascii?Q?OLlfdpQ0XUppvPZDEv0iFCLCwnRF2msiv8m63+X1sZnZoTNC4tzZEhtX+PrZ?=
 =?us-ascii?Q?WH9uiQgdLHtyzVZiyjfs8BxiNJU0hjBfIEHFX/WkHcuMZngFgX6Ij5sLdZT8?=
 =?us-ascii?Q?xSGku3mEVSis9wmEuRdtVPQqvnf+HQYSLnzkuM7wTeeOOM9f/SAcGGPGW7Hv?=
 =?us-ascii?Q?bURVktc0sOnE7Lqcq91euSXUgnNy7mdDEtjRgITP2po10lHJrSklMI8WU2zt?=
 =?us-ascii?Q?ya2xl9YeQQ8P5lh8S1OHbSyDszlefVw0Of9NY1DE6ys/BnBPfY6xe3VwqvqG?=
 =?us-ascii?Q?7A5D/ZKX8GtsLnDb9ITCYo4QNsGDL0tj4hDcD1Bb0kWlG/8ykWK3GknjyhLV?=
 =?us-ascii?Q?IK6YkDLqxyH9QkozOrIVK60vUXJWMFkPzZ0o+nUN3p3cloDHyGce0jQx2XDZ?=
 =?us-ascii?Q?5nM1DpK3CjmKyEx4PNvSBuY0k0a6VX1jtHTHmXYpuHi92RgRcwW6uIdv9QAS?=
 =?us-ascii?Q?O+Z0symzKeg/lK8e2+JeARCbetV1GJ1faG2H/yhkE8Sl/PKgYKj0x47ukNWO?=
 =?us-ascii?Q?yGcdogHVV7eHvCvH4v6rT4F2oDUfyGukUpy07/fFo2ut1kh0Y+nkvH6F0unO?=
 =?us-ascii?Q?FCu3m2AUEsoDFFXJTku3cdNdgufK5k1B5hORvwakNxaJ8GctXwNKZRJqR+Xb?=
 =?us-ascii?Q?Ulpqd6WMbJDWDnVD8WkzmF/M1UmpNRbNY9mM8zTA3itwWdRiVOeJLinKfNas?=
 =?us-ascii?Q?1gMvIj0UPt6kutYq8BHAVTtW88HGKAevgIsaA+mOwXHzCPRqPo+mYZ/yZnds?=
 =?us-ascii?Q?PYGo/ieKkJZOMSkGqCYtr69t00QrC2g=3D?=
X-Exchange-RoutingPolicyChecked: OyU0KSrTw9izvlhQgAi6TyxO+2TzZ4FRVhQARkfBa7qvlBzrVpnWI6jsio888yZR77VWI3f5YGAkWbRYYNcEcSiNBa1cZZ3yasRMLgwANCtZgvpnBc4ClkhvFwc0K5rL+VjENkaLpv86PzhYdgpoZqCgnKGE+s0Eetybx+Uw5zJkmlD0pnSBXaD9KavDGPcNczBAN3J910wTV/lG8PAg5ExxcLezSdxxZJReWEYhU4aQoNoarcKdFANZDNiANzlfxTHRbrwX6UJKZSVHrmab5fgLHU8mDt1P+Lv9UDDcsFvdrV/NTEYVhAsG96ur6jEkG+9fGqqmSUznE0bof3v/tQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d7a4eb-f9f6-4abb-81b6-08def9f6cd5b
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 11:25:53.7213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krjGmx7fWHc8LxFYCIkfReZfcRP5jzfMT5XeowHyS2hmJzgb/AHs3TvKMy4KbaKRPKbd7lfcFe73eQ3DjOEPIAwz63qv/edExg/w/22DBR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8A49C4DF4
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

On Wed, Aug 12, 2026 at 02:38:43PM +0000, Ciara Loftus wrote:
> Currently, updating the RSS redirection table and then stopping and
> starting a port loses the update. The port comes back with the default
> table. The ethdev API requires RSS settings to be retained across
> stop/start.
> 
> The `rss_reta_updated` flag protects a user-provided RETA from being
> overwritten by the default table when the device is started. However
> `i40e_dev_stop()` clears this flag, so a subsequent `i40e_dev_start()`
> treats the RETA as untouched and resets it to the default.
> 
> Fix it by clearing `rss_reta_updated` in `i40e_dev_configure()` instead of
> `i40e_dev_stop()`. A reconfiguration still reverts to the default table,
> while a plain stop/start now preserves the RETA.
> 
> Bugzilla ID: 1127
> 
> Fixes: 36c5dc8e5d3c ("net/i40e: fix overwriting RSS RETA")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_ethdev.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
