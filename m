Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56662EF5867
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:31:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E22440296;
	Mon, 16 Feb 2026 18:31:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id CA02540289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:31:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771263084; x=1802799084;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=DlEJyimvyoMFHTwnSbHXOB+MiSGG4yWQIIlNq5Jx8g4=;
 b=Y1le5NmPeSWmBjLww6jjUF57XutIMWfPrtYyZNiN01EfJ3X+HlDAEx3U
 I32bFpSgzGXRA1GlO1W4ll2O+TwYhYI9L0XKfSCUMBhKyt7eXwwhh6yHY
 SbJk/6/WDljNlXw1vjZA2S28svbCFhKQMLXVYVFo/2VzwA++WJXDnajDb
 KG/7xpoLwM1a7kL/rC2Sv/vB6lpOWCFuPRMt0Oaa6mvTvOpRcxwe9xKxe
 pp3RUG7dXNjEI4Zv7DkD2YzQUU5eja5XdHPeKbNOx2UOwKarEkqfT7TlU
 9hcuJ0qkVVG6Oys73oRqi8RXMbcGgl+KdJlQpXMpYBZlqtcJWSW4kQzI3 A==;
X-CSE-ConnectionGUID: jcODTaqiQqO2Gpgc8+AJuA==
X-CSE-MsgGUID: GORcV6Q2Rp+6LrX0EBIfgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="94976975"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="94976975"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:31:20 -0800
X-CSE-ConnectionGUID: kLVN6naYSpOyRLeCmsS0+g==
X-CSE-MsgGUID: 1gqGti7LRNee0cDuBBqt1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="217812837"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:31:20 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:31:19 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 09:31:19 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.22) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:31:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVeLUVnQYASPFFE2G93liAGs283fKvu8TQgOIwqu/XH7qFVIZ3DJ6vPjSetHiVlkEOAuAUk37X7p859kFS3ZuUJMMem+zG7dYx1chRMI42Iku5sG6wqw2P+AVy2ShONLrfdprxzE4rxIuGM7oC8NQ2J1e1mKJFSUoKqsN8p/ri4wGa24PWC8NOcTPJa0ZVSef1LjMc6rGRKfHFmZSvW1N1LU5X3lgyxRIAmgfCi6n8NxtG7CIUgEWsiz8Crewp8Fvb6eX45bdBQYMSsJv0OccCUJ75nYK8bWn0RJDiTsBnMaFaVnpM9V0maQO0ysEQunRAwxQRRzf/Wo9Ff4H01OIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMD0BLFP6fIvVyaAX1vEL8cf4pvZj8a3Y08absTNZQg=;
 b=LU2otZgGtZrFUvcUWXJ+kz88FiJgKwGqCaxUhLl5WDF/HZu4It6IO1CuAW03p5AU3xYyfRNOhrwDIxO9dk6HYQEBGojZqBtGP06aq8ZLnBrnVNuoYyV8FPJOBRjAprzH5n0BGt1YW7C4OhbhBRcN2xnJmvZsQNQ87cW6+GKRn/OU5yt1HVMdWl0VRfkxluUn4Ae6iW4h7rI3Q8aJ1qtfTRP0jLWNcBA5WSgI1iV+69LNDTRDqAfaV/rw1hwkFTcC6a4z0OQWAFbROowyiwQbH4guPNagQAPT9zHt5xbSylKcgktneWkBqHf7LcgRt6GqMDFXWdxAOi+95rSQ0quCsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB9452.namprd11.prod.outlook.com (2603:10b6:8:263::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 17:31:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:31:16 +0000
Date: Mon, 16 Feb 2026 17:31:12 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 22/27] net/iavf: avoid rte malloc in queue operations
Message-ID: <aZNUYJuCrENjnqEX@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <869fa36c643d5f9da0bd4992fc179914eff53a93.1770978324.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <869fa36c643d5f9da0bd4992fc179914eff53a93.1770978324.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB3PR06CA0012.eurprd06.prod.outlook.com (2603:10a6:8:1::25)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e57c5e7-1bb9-4a19-39f3-08de6d8130a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MIxbpTaHzTaUEqwKlDPnCiKG6Yo7Yz392zwDl+Ysnvc0TSVNUIGIExAIV36h?=
 =?us-ascii?Q?haOhdVgiEDMzMeopBIu9ZB3e2qrfOY6G9lyKBks0k8najSgQ6WYCWIF0QmjW?=
 =?us-ascii?Q?NghWpoDjORCmctWkNRgMfgk2Cx7RUFQXfmCGYy6iaD5w29azCOddbRSBSkFg?=
 =?us-ascii?Q?ySCUJlUQ1UiEBHTDA/R9Njs3l2Ch4Y184OpPIh1AskompRXrxbG2GwvDH/Fr?=
 =?us-ascii?Q?7HWMDlogdFEVf3rrjgVaCHOZNt/MJZK8Fi1RiJjwwEwm3u/Bzc5o5i+gPaIN?=
 =?us-ascii?Q?o+RV+W1teWMcM5nELZ50UNQrFzqRZR079xqNcVaeC+bk4kirE1/1G4Ano7J3?=
 =?us-ascii?Q?YOdiPAWbYcuYJZ8N0ce8g9VioeAIWNFu9OEaWRDWDmpX78znFS9LuYuW62C/?=
 =?us-ascii?Q?FvFM+LJ8OfcYYpdgLn5+ujiA8DWtSxPjpgdMZPyogR+rfqYb9y7gNiV10HB8?=
 =?us-ascii?Q?2uZmDVo+GxeS2AtgP+Q2UrmUuddKgGxsNncCfLb144kY6ZdnIN4qO+ceA90H?=
 =?us-ascii?Q?MIkxiR65oaUWOfBdbOWeYypZrLHrw9rrLyUdbZRk3JWPzRALGI0zRhZMtky+?=
 =?us-ascii?Q?AGK16SpM0uVGj6HYlKjfxHC5eMz/B09iSHDkjpGUVreJ2GfzV9V+5iF9/iaa?=
 =?us-ascii?Q?sPKzrnvNIscZAqsYlZvE0T/uujJE9DNhql9vV3/VxwjctlGmMyn6RkJSp5Su?=
 =?us-ascii?Q?C3T8LGRX0AHpP45Psj7jBbHlQbRwmPZkx52+g6T1JGC/SaQAJmpqMCFSKtBP?=
 =?us-ascii?Q?UVWKPJNif0Ge45i3KOSYS7qqM3jMz/kMe0y68Ig5vCT/2aRdMUKa0CZCsTPk?=
 =?us-ascii?Q?nR04zwJyDv/yP9YZqudwDw3I0JvJH61b0OwEyYCv6mqJiN0z1JOqrBcG6dJq?=
 =?us-ascii?Q?IuqJKTeeDA/xe8KcfXVQsfp5+IAkDgoZb57k9DgcMMqhloOsq8/taIDILUwl?=
 =?us-ascii?Q?q+8NtLitJIAb7f/2uZ+iJpAoTOLgCjcThm4+VLytDUyb7B2RWRQgsrs6SXsE?=
 =?us-ascii?Q?cRL2G/5CJ3dIQfLdGjau3eliPxZLBOJrSSGK1/IVIBHMm7kGlZvsd7H1QSZ5?=
 =?us-ascii?Q?d+IBZis3+o30bQatvdVFCQ9ygccH1IYLcBlCQ6cDdhWEmkWWz2ij1wYPwppZ?=
 =?us-ascii?Q?05AkXWQ5fOoi6yNS+2W0JIJXsSBeGS/J1sbDPvbV6uBTIOwg+cFYHQ8PMR2c?=
 =?us-ascii?Q?NligTjy8pAxloWrU/TDH0ZSWN9StCn8Xmm5rbubfTsFin62aUszKauQ7eTTm?=
 =?us-ascii?Q?nka1DGEW4qUdxirnzvzU6elp/7SktY5f1ag1EMqtp79IIN6f+RaUuv0qy8mi?=
 =?us-ascii?Q?ty5ylWcAkF8GvlUy4vsg11FOWlAM33LgiuxY88f+XGIimSJOT+vw3IBxfQ7h?=
 =?us-ascii?Q?qXOtEF7E0FY9TVDbYv9XFGwXAjL57jXI8QX7B55MAM6y8hXcHtlYxG9MBZGq?=
 =?us-ascii?Q?FlK4VfJbJv4pKOS1hpNOig4GPeuX2aCs/6OyxwraX7ZMyfX+ihy+vwq0hgAf?=
 =?us-ascii?Q?VOc3M9pgAMM9NtTnMgaa3XjsIkEYLO/nJPdHwk8JeBzjnnn8VT1AdeiMDc5f?=
 =?us-ascii?Q?hHQLpMDlPnKqlyk6GjU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ht6ckj6L+NKTJh9X92GgqxgIhpfOZBWDt0PQxFJUn6lwdHmR6Xt/urcoZCyo?=
 =?us-ascii?Q?S0MTy+uD5OBFC0YFWH5bawb9JlUhi2bDHXziMHqlNi+ocm4X2+TVB+XqVWmj?=
 =?us-ascii?Q?TGfEeIfg4+yGXorI0a9dyZhizrdysEjHedDoIuh6rvX/NR2YG2Cvg7RVWlp0?=
 =?us-ascii?Q?j7e36EHfcL6f9Zb1ImqnT7SevW1UJtuWyDMbbMlY+PokCLHACQhbauuROH7s?=
 =?us-ascii?Q?YOjM8nWIwwiiRuBApEGYy/JhCO+EU0sTCvoZvQ+tiUNzh7nRL7q8LxvY4M+Y?=
 =?us-ascii?Q?rIiD9zJuUqVv2hs2nZFy8YI6TdZb2Jecfruo7QoM0Pl4s2hE3MMS32YV7ckW?=
 =?us-ascii?Q?JHI4En6gQH97J3rmCyLPub3icwy8/EI1KOXC4xNQHjREL+LMgo0sFPLUQ6h/?=
 =?us-ascii?Q?R0TrnKDaWJhhaB76kZdRli5TW4w1dSjbjemtDivFm7gI39L5bw4VMvS4d+Cl?=
 =?us-ascii?Q?vjPLkbW1u+kHfrCGrGeM8GNc2WKvz2CafqHG66sixhJy5q6+Jp0rzogDC0iH?=
 =?us-ascii?Q?rEUf3ZiAZqjPR3kEAXG7gmRZ3Vbvo4Znw2pWmfqwzrRTPnTEQgMdO44acW3f?=
 =?us-ascii?Q?h9+0dQAaz19zfnJGDrWVMMsMzoYIsi53OBzHTkDJ1VctyCmSEB1ntgxdVlLo?=
 =?us-ascii?Q?Z9NFXBHt4PP1z+6gLuDCULwPfaLgpyfH/6aZCY48bcp7tW+LdO8njH8BN7P7?=
 =?us-ascii?Q?3xU1LyYKKu/N0lRwm01531H/Fu6ckQ0jdFALudAccohRE+rMMDAqmZP1U6vr?=
 =?us-ascii?Q?AnO2s8262+Vw1rzE60wV/HmC1F82ZCB/ANAMh+hyHjwrmLZpxOU13VgXTiqK?=
 =?us-ascii?Q?PGnrTcqenPdeAMTOCwheWXZ6leTU43CgebX6H8abhB+jmRKXl1cPSJ8CuhdL?=
 =?us-ascii?Q?6/GgVXVNoE0h86mK2FjjXA8m3xcflQUIMHrJ0/HQGlk0B2b9Vmngtwiv+BW5?=
 =?us-ascii?Q?AZD5jeKwLOhxiYxPnniVg0faUOsdQTvVtCbQf4i5jKLx7qxoWfAXs/Bci2K9?=
 =?us-ascii?Q?towgWd1DpNJ9n9d5dezOrCMK/e8xB75rIUn1ILhYiO4ZbWBocUzQ4Fk+Hwez?=
 =?us-ascii?Q?h/k1SMGt4cl3hdlJ62kfzshxdc8IIfizJXHJ21YpcesWVybskRz+nlqsY/ri?=
 =?us-ascii?Q?L0B5PiixT7uuAD5440qJHZ06XGhEwxzu9CSAFSz51UuZ11M6+i50ddCJ4/Rx?=
 =?us-ascii?Q?geGdDtLoPpwm/2L80p06LLJKxKLtgc+Kiwy7eCw/E1iCY6WBqrP5z8EBB7Fz?=
 =?us-ascii?Q?diIgKslin6jTxOb3daWg2mNj4A8IPIy4mKhfKPVGKry3yQ11RNiMqRGN+2vq?=
 =?us-ascii?Q?xCiHB41iDmNaJouuP3ZkTwuhexl5GJhrAQiW1g71yGYnsDMUZfu4nq/IHLu6?=
 =?us-ascii?Q?pMlBBqKnmoErH+giEynkhUqvQZQOrWAzL9XKt03aM73YDpEK0qfjloY2m9MX?=
 =?us-ascii?Q?q2T17rhwfwwDoHQrdXol2azCFsS+ggrzNwgC7hMuNGxMMrf5F6yBGw9RE1Mu?=
 =?us-ascii?Q?cTEMYB+MuFplk5ixIyf/p1RWoUIA5TNqF58QnP2nrfyaUg9V0/6W5sUoCNc7?=
 =?us-ascii?Q?pdJasSx/Fe5LAOgrlFoCxeA0TpdgiM/UH23P6nCpG9vxNrggrtEbaiP5sqpp?=
 =?us-ascii?Q?dZGBZQUZDflgy5dWP6D8h7iyVK6LN1KtOUGLPWjmIpghufxXdZ9J5DmKAtQ5?=
 =?us-ascii?Q?scj06jZ35On8uzPIAjGdMBDWxYFBSgvMkGsHWEkTl8Fqjmdg2Ok9QODoVu2e?=
 =?us-ascii?Q?Z5vregsFsoB38Xa8tFTkOAjWClPAJTI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e57c5e7-1bb9-4a19-39f3-08de6d8130a1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:31:16.8413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mM4Wz+kaAuPdT6caszXs14skK8Mv3kDV1Oan+PQCXd8XxWgLyDWGeSoEx1XsRTk32g68cFdlZ5TUTgbY1ovWK47uplmbM+uCOz5GX4IGDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9452
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

On Fri, Feb 13, 2026 at 10:26:33AM +0000, Anatoly Burakov wrote:
> Currently, when enabling, disabling, or switching queues, we are using
> rte_malloc followed by an immediate rte_free. This is not needed as these
> structures are not being stored anywhere, so replace them with stack
> allocation or malloc/free where appropriate.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_vchnl.c | 65 ++++++++++++-----------------
>  1 file changed, 26 insertions(+), 39 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
