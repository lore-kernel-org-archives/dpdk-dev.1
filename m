Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC207606A328
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jJheq1Kn
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DEA04060F;
	Wed,  4 Nov 2026 14:39:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTPS id 06EB640281
 for <dev@dpdk.org>; Wed,  4 Nov 2026 14:39:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793799571; x=1825335571;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=YFaS+PFAGRWlj6Z1CS7eaR5NIlbMy9mT5BJyLZnQx8Y=;
 b=jJheq1Kn63d2PbvffyZTQ/nsQAIIFORfO4kOrl6wOh2O7Lx1fWQ6Tz7C
 3rmHXgSzxgsTwWZA1Lnp0FLq3tu39nIeHA204TBBBaRy6BHt6+95jvfXF
 ohBk2kBCJmAsPZbaEIsb8cEhUaHtLrf2WMFGHmPqPaQ57+e9h1Tog8//0
 h20h8wvhBN/C/hNj5tWuEjZ/LLDZoKP8JnLYwo6NK/E2beDq1k8qnZjD1
 MJwI4Z4aqOTw0UMwQ50d7xbJT4HhC/u+lDsZWnUjeZfcLbwOJj0PYnE1Q
 lYp1Pd2zYZQ1zTxorvVEmdyATFs7GpLNPjCPic1UHZXr5uLi9JtZBpIO0 Q==;
X-CSE-ConnectionGUID: 381UP+J5TN2F0cBibALFng==
X-CSE-MsgGUID: uRuYbJcnSfiA7VD6HQQ7sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2453042"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2453042"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 05:39:29 -0800
X-CSE-ConnectionGUID: umJbE2c1Rc2Ymr6mntXYYg==
X-CSE-MsgGUID: FBwGUbiUQRyU+lVMr18u7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6608781"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 05:39:30 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 05:39:28 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 05:39:28 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.14) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 05:39:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzDntNb5j8L5Ifo/0eep/ZBf31M1nKI/DkjAWNIJgFhV3W3rwTGOqmwEsic4a3tOQm/aWPb+C/IvM6jDvkZ3j+tBUb8L/Ehey0c4MeN3d7YCz9n2AtUYbW2HOIbC7/ibyUTJAzY0oAB5eOf4UcOSdmiWaAz6vexIshL02f9+z/MThKy22E60+SYt8dtnoeW+mpvNApZ9c/7+2KYuaP9GxUAg8GBRq4Od5z31mpZWgrETQWzbOZlXH+hfw8DigauQpLulXc2eOYjnOLMWSBB65qCiijCSAAgzi26pEVyCc53EkW4iMr3Pg+oqBFBNXAUdn9XtdpREDauebIhOSeguSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vZNvQMjIS7TrvBN4pa/U0k4/gjuN/K4Km/H4y9QPfU=;
 b=RP0QT7nbPeZrN2X1DY1HXh27pjuaZ0SR3m0lQcCOhZUGFuN390ARw2XxscI34TMSFZKj2mEOUeM07OcDzecP8ijJR0n8zPQWhDpu5ufMKMKtxwRXUyPlP1iT5iD8HQAC72ZP0yd605lF5BAC7etAbVpyksLLlwdTpxReYPurja4tH1YM9fFvye2tBG1wfjUVS/Hi/z+ZCoKEuCJbPGkDl1T+icAqasWunBy1zvFmXNbBLvWmzZi5+imnVTYLM5bMQv/8xFu1yufkT8A9hfjfJq0D3Izf3oNKfZich9TZd+nJRk3izkgIpK12QZJvnYfJ5eJyLzGLSHp2UQonT+6/QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH9PR11MB006246.namprd11.prod.outlook.com (2603:10b6:510:414::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 13:39:26 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 13:39:26 +0000
Date: Wed, 4 Nov 2026 13:39:20 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH] app/test-pmd: add explicit parameter for fixed link speeds
Message-ID: <aus1iC7K1V1xnGks@bricha3-mobl1.ger.corp.intel.com>
References: <20261103155033.3740814-1-bruce.richardson@intel.com>
 <20261104132949.4957efe6@stephen-xps.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261104132949.4957efe6@stephen-xps.local>
X-ClientProxiedBy: DUZPR01CA0091.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::26) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH9PR11MB006246:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c99202-fe16-4cf0-8c46-08df3a790b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261022105027099003|261022113327099003|261022115727099003|261022075727099003|261021130227099003|261021123027099003|261021121427099003|261026121527099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|4143699003|5023799004|11063799006|10067099003|56012099006|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: KmjBWcehcUxRa6EIYRdE0lXnBFkF2fzo7uGx7yQ4eVonywVfwRk/nmpJxsnb7oJwiES1LkU0Pvz9+MrkklLm8xdOE0DyAbJddTr1LKZ9R4rR+6Yo6TNR338fWufi7CXYmkLASoGM95M9j6di7wnVncpGjattRrAAKHK+jF8a2vHzAIktYLqnikmOWowtRIpgg2Mh7bNlBIaz6ikjP9FZgEXgdRpKIfdTF+j59sqsgxxGbXe4krx9P/Q6092M4+nAW/m4CX25wuQbmKlr9lQX1Wh+vhJ4oslBF5E5fAIxzd6zvsUVKIgDigzEOUJ+XhevLm4Q5oBriXfXIJ81LxiO/+tWi8aWrHhHbETydmPWYDuh5yvj3J83LZ2NhnUVNgsFmzeDBGhqwrkVCMCI9SPeQV7nH3Ry5DW4qH3WBCEojbyixbP16wI7EYfZwTySS1mkjNN+xiCpKamO0Mp6MpVcQ//KcoICH7o3m3gfbdnCTbPsJdzByL3v1CV242gLdOoMCYw2DQVYdkrqjvGrToR3wfk3oZhpm+2PFJJkvC7cyFiKAR7iQOeQXrRM7spmGtkKVI0oXS1tWWczPj+0VMgAbAxsJ6DkFmkun3yXrva1bRNerI/BzpkEY27N64fPcvKxHxPT0mWNKYsnJlB054K+K7k+42sf4QaghSS1pnW1xm4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261022105027099003)(261022113327099003)(261022115727099003)(261022075727099003)(261021130227099003)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(4143699003)(5023799004)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0sOUJXjLc2q/nr1ZEooX702TGPyndP5LMEaGk6T2fwtnvPcxxEeli3IgEfH2?=
 =?us-ascii?Q?UkK3TrwduAzUPuxpMzE7CtIZen3zar3PyzDsryh8QA9Z2YfhFV1qkfMQzDFe?=
 =?us-ascii?Q?yrQnYII9X/Ysoez0LPjnB8Z28sPO3H9rPxmw2X/9hBc8ugbuos5cg3ecufAP?=
 =?us-ascii?Q?gyqEX1OoVmWN9xFPoAT8wFlUo8Ug/4n4GByUv5Ie705jH+OV/XWG+g0a8QGT?=
 =?us-ascii?Q?3uyY5VGVlfhaJCbiHV0wZJ5lUZ8DqzFArTYTObTYsMTLQLFysG2EiEKHK28H?=
 =?us-ascii?Q?O8TVDrPl1uI5RBJucZtQiJHF9YXxRYc4c/IULEq8oUAhTsQBsSIfcA3HP16D?=
 =?us-ascii?Q?1maW9rrdqrl8TkbiF65RgUGDpJ5dUk/zxLT3+OcZwuTns5Fbkzpyfk1Bz3D3?=
 =?us-ascii?Q?ToXZPAG9VLTebB+OvmpADW99yipjYwCjrLk4yWhhieAVOimuF/XQ8YhFRa3M?=
 =?us-ascii?Q?tcz+roSBTmQ6Sd/kJLlkW5hE7n2pD+bwwPxFYS3TeaeUxxgKME3KFSYLsaHd?=
 =?us-ascii?Q?g5SCBjkWT+cNs7B1K8lnpT08fcZwx5gdIryReJ/DUtCQWalz3r4RUZfSMnXm?=
 =?us-ascii?Q?J3oEe/og67Ub3yq+ChxkNAh2mP4Vm124UuCU3O+xKw/mQx9TxELnqfZvdl4o?=
 =?us-ascii?Q?7F0Gurwy5KhzI7maVCm5wK8I5NPuedvKLYg5FuQaudywmvW25MR0rojMBOQf?=
 =?us-ascii?Q?Cj59VtTXf1ZEQ8dwfKVHpgURYx+yroc1rlfHvw/DNMjUTfMWH7rFu3jhv+u8?=
 =?us-ascii?Q?g93TwqGHWhvXehCfr+erz7a3YSBucLUhYQs7ua7bFvfTx4XL2FCXakezXWpv?=
 =?us-ascii?Q?G5IjWJAWoWBbF7PNmXWDym1lYEmebrs/2nayEF1cDJJFLjhSD6e1V5/DMqcA?=
 =?us-ascii?Q?ePN7lpACUR2QlV4XqjYvTnKx8vTCUwwsUyBiCA7xVLesfD1arz84p3jRR+Kb?=
 =?us-ascii?Q?c7o9YcQXmkbGP/HdrqhAK4vE7ZxaAd+HoI+j4yJbqWkKacCOqG/s1eubI6tE?=
 =?us-ascii?Q?U69cTsbU4YN3A40mOiqtuvbzVlCc1GXxYdZ31RKaYSZk81W/ubitUdNQsEp7?=
 =?us-ascii?Q?rPHbwJPG6bWrFhmEsbS1TA9gqYpg102OFRESrLx8Q37pqBpwfS1btgtMKGe4?=
 =?us-ascii?Q?5fCzhodsjPM4OMNkNqRJMpbOfqI5v6sAl2gnKRpVUW+jOQa9KRXfbomU7cQN?=
 =?us-ascii?Q?gSgTaXXvYftQBIGpmifFQWJBFiVs2ugeajxJWBg+GvmTJ8eo0Y7YR5Bs9WVo?=
 =?us-ascii?Q?oWFSlneAQsxG49Ytk23K8fuxr1t639tkbUWHXHgko2pZBg7wH+8x4/OlUxG4?=
 =?us-ascii?Q?0yKRehEqRcX8/4oCExE513nTrSX7OqZTMfyLsQ0axVZys+sPRWkegGTOeUt5?=
 =?us-ascii?Q?/DiNYWGyZRsFEKLFLoW4b+Ym/2/591C+lzDQ3QXDDxlcXqCMH/yYixuVKAsE?=
 =?us-ascii?Q?zLOY+irPBqsnA7RkEcLeQlA7ANObZaHd2ZOdWv5ugH/HwNxJnvU2jG7zpqJQ?=
 =?us-ascii?Q?hNPStQOCWYI9RYMlmWC70F0jwfXhJYG0wYlui7jj79U95yidyXelLS7kvuNR?=
 =?us-ascii?Q?poWe306ds5lPVLlUHdu/i8Tp9gKMIi4gTkbIg7GSnbOli4q5jnzBQtDJ3YRe?=
 =?us-ascii?Q?WGh6oOKWQqpvyLURXdOMObsqmprwty2lAxew4gsXeY34HS2LmohwcYMGm9S4?=
 =?us-ascii?Q?EEuO+blMdawc6RtbZ0xetBcrb/1pmIk2W5B1gjxix9I3bEyx0hNe22uNgx7l?=
 =?us-ascii?Q?z17otTDdyXhRPWzk9Q0dFldI6S+UzjA=3D?=
X-Exchange-RoutingPolicyChecked: qomN+TgGu+K0Q4irSfCHnFW0zwdZxmj3axELTUsCrbjR0mFgl8HS9TX3tVKYQlHb4vKsyVX36KYYbGqa29HMYBA+YBnwxrAsmwzhpjcXCY8ynggaCMwd5fTB2L56fvLjrHVB9pj5JuzNsJDN4IU3/rxjx5RzwMtwSYH7RmE6lIVaYi1rlFheM6iA2xvivYqtcZWbwdLDgBRiMHfrsP7DZZGI0mlQe4dkvkg4wJioFlr6DX/C+NdGxD8kkJ40ZrFoRzm50MQWbkDyENIsnhQJyjR53aHHCp1L+NBNR44vZ+UZ/NKkKgcOpQvcJnGU5q/zdqzkQ12J6qvcWAHSykkkvA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c99202-fe16-4cf0-8c46-08df3a790b17
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 13:39:26.2809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1e5oRFjPQY4U0n0yZDkR0556dkN0Y2sm+KsEYdRb7wuhzMPppmPuIMydvF4QEZqan3cLBgJWytBHuJ2qqiNTsQXSHNUsrwnGRWWdXy4NdrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR11MB006246
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 01:29:49PM +0100, Stephen Hemminger wrote:
> On Tue,  3 Nov 2026 15:50:33 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > When a particular speed was specified for a port in testpmd, the flags
> > passed to the underlying API call always included the
> > RTE_ETH_LINK_SPEED_FIXED flag. This flag is not a mandatory part of the
> > bitmap when setting speeds, and is used to disable autonegotiation.
> > It's possible to have a link report only a single speed while
> > still have negotiation enabled, so testpmd needs to be extended to
> > support setting a speed both with and without the flag.
> > 
> > This patch does so by adding an optional "fixed" keyword after the speed
> > specified by the user. The presence or absense of the keyword adjusts
> > the presence or absense of the FIXED speed bit in the ethdev
> > configuration structure "rte_eth_conf.link_speeds" bitmap.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> 
> In general it looked ok to me. But I would like testpmd and ethtool have same syntax
> to follow the principle of "least surprise" for users.
> 
> The AI review with its issues and that encouragement was:
> 
> Review: [PATCH] app/test-pmd: add explicit parameter for fixed link
> speeds (patchwork 172601)
> 
> Applies to main (26.11-rc2), builds with -Dwerror=true.
> 
> Warning (should fix)
> --------------------
> 
> 1. Syntax should follow ethtool rather than invent "fixed".
> 
>    ethtool has autoneg as a separate on/off setting:
> 
>      ethtool -s eth0 speed 10000 duplex full autoneg off
> 
>    With autoneg on, a given speed/duplex limits what gets advertised
>    (the kernel's ethnl_auto_linkmodes()). That is the same as this
>    patch's default, so the semantics are right; only the keyword and
>    its position need to change:
> 
>      port config (port_id|all) speed (...|auto) duplex (half|full|auto)
>          [autoneg (on|off)]
> 
>    autoneg off   -> set RTE_ETH_LINK_SPEED_FIXED
>    autoneg on    -> clear it
>    absent        -> leave autoneg alone. ethtool keeps the current
>                     setting, so keep the FIXED bit already in
>                     ports[pid].dev_conf.link_speeds. The default
>                     dev_conf is autoneg, so a fresh port behaves as
>                     posted.
>    speed auto + autoneg off -> error, as now.
> 
>    Putting the optional tokens last leaves the existing
>    "speed N duplex D" prefix alone. Users who know ethtool can guess
>    it. Untested sketch for the all-ports case:
> 
>      struct cmd_config_speed_all {
>      	...
>      	cmdline_fixed_string_t item3;	/* "autoneg" */
>      	cmdline_fixed_string_t value3;	/* "on#off" */
>      };
> 
>      static cmdline_parse_token_string_t cmd_config_speed_all_item3 =
>      	TOKEN_STRING_INITIALIZER(struct cmd_config_speed_all, item3,
>      				 "autoneg");
>      static cmdline_parse_token_string_t cmd_config_speed_all_value3 =
>      	TOKEN_STRING_INITIALIZER(struct cmd_config_speed_all, value3,
>      				 "on#off");
> 
>    The second cmdline_parse_inst_t still needs the two extra tokens.
>    In the handler, res->item3[0] == '\0' means autoneg was not given.
>    The cmdline library zeroes the result buffer, so the
>    ".data = &cmd_config_speed_all_fixed" self-reference used as a flag
>    can go. Same for the per-port instance.
> 

Ack, will rework to use the autoneg syntax.

> 2. Default behaviour of an existing command changes silently.
> 
>    Before this patch "port config 0 speed 10000 duplex full" set
>    RTE_ETH_LINK_SPEED_FIXED. After it, the same command leaves autoneg
>    enabled and advertises only 10G. Existing scripts and test plans
>    (DTS, vendor validation) keep parsing but now do something
>    different. Whether the user sees a difference depends on the PMD.
> 
>    The new default is correct (it matches ethtool), but the release
>    note puts it under New Features. Give the behaviour change its own
>    sentence, e.g.:
> 
>      Speed settings no longer disable autonegotiation by default;
>      add ``autoneg off`` to force the speed.
> 

This becomes moot if we rework the syntax. However, when making the
original change, I had AI do an analysis - only 5 drivers in tree actually
take account of the FIXED flag in turning on/off autoneg. Hopefully, adding
testpmd support will allow that list to increase, because nearly all
drivers just ignore it.

Interestingly, AI also flagged that there is a further set of 5 drivers
which would reject the existing testpmd command as it currently stands
since they reject any speed selection with the FIXED flag set.

> 3. --eth-link-speed is now inconsistent with the runtime command.
> 
>    parse_link_speed() in parameters.c still starts from
>    RTE_ETH_LINK_SPEED_FIXED, and run_app.rst calls it "a forced link
>    speed". So the startup option forces the speed and the runtime
>    command no longer does. Either add a matching option (e.g.
>    --eth-link-autoneg=on|off), or at minimum document it in the speed
>    command section:
> 
>      The ``--eth-link-speed`` command line option always disables
>      autonegotiation.
> 

If we rework this also becomes largely moot, though the option of a
non-fixed link speed flag is a possibility for the future.

> Info (consider)
> ---------------
> 
> 4. testpmd_funcs.rst: the patch leaves three blank lines before
>    "port config - queues/descriptors"; one is enough. "Support for
>    these settings depends on the driver and hardware." adds nothing
>    and can go.
> 
> 5. Commit message: "absense" (twice) -> "absence"; "still have
>    negotiation enabled" -> "still have autonegotiation enabled".
