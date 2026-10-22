Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75151606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mB9EM3n6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B46C64027D;
	Thu, 22 Oct 2026 18:36:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id CAA0B4003C;
 Thu, 22 Oct 2026 18:36:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792686968; x=1824222968;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=qOQI75mSvyxnGnizFNWcbqTKmoczWMnoGkjt2RWps0Q=;
 b=mB9EM3n6xo37ns01sGjY4HsoJrin6xgKky6dOA37KSpGKSg/DIAPLH01
 /2NGYRclyPJx5TSP5QlHrt2fsJKNVlR9tFMsLz78SsOQcPwRqNshpBirI
 LHMdZTwS9Eovo2pdfedOFOGspkyu5mk6GNQEmmCfNUxFGi3u2RvrAnzDp
 CrFSY2NibfrZomn7Nni8Fy8DWUCuFRnfD+dzvnWPiVs5hwTc7licLaaMD
 xA1CfJ53ZLvqCA00PsAYABAnil542fliuxfVERwShRr5GWl1simtrMwty
 JKP2PttLX9K0Y23rYxfyo6G2VVpzC8Fd3OySkVYQkwdCY7dI9VoPuS9/Y A==;
X-CSE-ConnectionGUID: m55zAvyrRqiD1bQLYQOGHw==
X-CSE-MsgGUID: bdhvziJrROCUa6HHr8VD5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1428956"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1428956"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 09:36:06 -0700
X-CSE-ConnectionGUID: bSJCFbuMS2aCPFFwnQB2Zg==
X-CSE-MsgGUID: SV/nDaRiQ9u+XdQoTA3RhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3407801"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 09:36:06 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 09:36:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 09:36:05 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.27)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 09:36:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVOFFZjvJNF4zhanv6bEvs5t68pNPX+yJXPVQTZ47s8eyOLY0WE4jrusz6QbGwYJj8GfGfWsYiRQh6itQJbCF0DWO19pOnmhYHZoBeHXpF4C1QLGjJXEUN13xdRjUaL3svSixol/62Lt2AFEgFTkaO0jmmXL6Ws5W25JiB31w7dXI5IGQg02qwPfY7C6X5rMX1/4pNYLUDfrV0mpwP5YvKToWzOy2xSeQg9FzKKQ1hHxe+zq6oaU9hTcRPnLOVcuYNyTFCqpVlv8OwqDrrd+Es4+zImRWOabE4RV/pbgYjohsfyYXKNkiS81NcqNClt2jAP7uUIuGr3AtAD5Fp4vXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lV6WoG9Bv1mj/qfgoFdW3WG6GH/mdsKIHoR/z5EwekI=;
 b=J2Fe9ON4PZ9JCXwF3X85gFnXmIpsQBBeuHLaVXDCW0Ky00fJc3dF7l1/9qV5fn79ujgFToyx8JnHPfAYJK/zam7JBa9rPEos/uhA7CHOMBAImm9yHulwlzNCrM2RrQWKk7+XUmFrg7QRhF46k5YsK+zKnrHhWwzOHvFhAHl9dmNR7ISf0CfMg3ANlH40bOwCZGA4NrTQpE6TrzrBW5KYTEmrha9HL/uP3b38PCaujlEG+iTq74idMjtSInIPobXk46Uo+J5qbXDlBi29fz7otOQN4Ig1MQs2PKypaJZ1KY5fHoB4gKQY7hqbTPuv60Vd5xXA4Rre9ktoBw9kJMyyCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH7PR11MB7571.namprd11.prod.outlook.com (2603:10b6:510:27e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 16:35:58 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 16:35:56 +0000
Date: Thu, 22 Oct 2026 17:35:51 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Wei Chen <allen.chen@jaguarmicro.com>, <dev@dpdk.org>,
 <cristian.dumitrescu@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH] cfgfile: fix isspace() undefined behavior
Message-ID: <ato7Z9-rOgvF3g4H@bricha3-mobl1.ger.corp.intel.com>
References: <20261022122348.3467-1-allen.chen@jaguarmicro.com>
 <20261022085411.6932d274@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261022085411.6932d274@phoenix.local>
X-ClientProxiedBy: DU7PR01CA0041.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::6) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH7PR11MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: bb453957-778b-4995-fafa-08df305a8bc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|261009223027099003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003|261021121427099003;
X-Microsoft-Antispam-Message-Info: DQ/8Pzl6KaP3plLDM8VJPLEhAVhjacx1UmrFP1rzRwRecUqGcFOUxsIdMpnqu85cT6T9Q9Nq86KSKzdSLAuRDeqXIkGVDRfzXcpZCRVh65hX5r0Bn+/Ax5xs9wW12PcqMtWS2ArJ21bBBC9oIHolyyliP9UAgjoX2GNmGA+mOklCEIJ4G21GN643DQ1IDzQ4o7uEhDTq8aBSZEMiGxBZvaM9g/hld7wTYerKTSVnVBXWvTM63FEb1Ogafk8/cGmmPzayDFpyqs76VMYmvnLsoeht96vvpwymSltvbQXFAFvBNKlCMVcDyrhF5MT5O4O0yKgcp4p0rYVOQFRFd1jS0SnstsgKhla8CfN/CEMPkwBAiPciGvi1PyK7myAoZiI5oYBbSbZyWAx2FWwmQS4d9SXXcu9hJibLWQ6rcDxgWSjZ4omIezT4nmKGi4cHG+ieRdLlJJxoP7G/O5bH6iKBDviWdZNTUfy2SFTa2TvnUgLlmB6rRzQRFStMZOFg6Tbo0olPyOJ6xNXzpZSpSpjRA2LA+8T+HQXLKkPSWkThEb1kb/55k4mO4/3e7CzvFyfpoH6mz97TsaM69g10tjW4LUpnOnalkWxtgW3ctaaBhRUclx7Ib201Lu0Ub+xJEjHYBMxZm2fKys0IGobLP7wi/WLUSYKVMLudOB2JDTUoOTE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261009223027099003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FCxT1+jlYBkn8BqDWTbCqF5qP/HLFqmNZWgf8C70NEqWIJleXajC2SZZWKKj?=
 =?us-ascii?Q?3rrEu64YVTbqSJu6oWlVLyBq5ym8FOLPUvf1eJ3M5PGlhJ1qA1T1iibkwmte?=
 =?us-ascii?Q?grBII6dH8uOu5Tic5YEi3jBUmRkbCQ8e/n/fisUFL1+Gvqgk773F36SsCnJw?=
 =?us-ascii?Q?4mt3Rm2OW8Nw6DKMsY/gWi8qkFQso97bokIIbtmPH/tO1iRKoxgdzgriV87/?=
 =?us-ascii?Q?3FRl3XhtCXKjK2Tf6UMsmxdXNOIdSO5Fb/ClHPfPaGmn7hDnU0+ECJB+yaA2?=
 =?us-ascii?Q?EDBRSVqjSonNJGBlHS6IX474z8OjwBy+afUgZVkDRGFNwyFxZ1aAFHnm0FtU?=
 =?us-ascii?Q?lPSZZWOfhSxwUmFb4dLLmYtx9sRFxEULYsZ5sTpykdJ09RoON/WBEtP8EDXz?=
 =?us-ascii?Q?FxN2MkfPK6zAr8Odj7jyFU3RCQZjeGaCKmMA6j7BxgF2U2voYLPVCjBYLnlN?=
 =?us-ascii?Q?U0mm46TxRLXjubVGm8qLsWjb1kJZcWJXnG1rRwugzA8H9hxPk7zPxCvEF5/M?=
 =?us-ascii?Q?rJFPN6pnRFbm/JwRZyUbd1X+QjIb/XNsp6VMHWY9DTUU9DP8RdnRCvcxPSEJ?=
 =?us-ascii?Q?1p4A0rwRlZLVfI8XJKkPAiohPCJZ2jqLKm15J9l7wMLot/fudc30rEz9hbRq?=
 =?us-ascii?Q?2k04eO3XuRYIzLmoARL5vI/LsFq+xr6tme6bh75blmA3qlEzg6oLUXglGhef?=
 =?us-ascii?Q?Ohr5FClKdBV8YBj6koGhpsxKKMdvhkxFULyr3IXRp7Ghb4GCbTzFnSb8oV/V?=
 =?us-ascii?Q?eXSiv3m65LDlhHHriaXAAw7y5ymfQXYz6+Ua1EvU0R+1GiZmIXDzr3v/l0Zu?=
 =?us-ascii?Q?JXn9b2iPi8q/fBtxWmCjwRvDGNDnCU5YqF3uNwXwMi/BMieQu/M6xWQVWnfg?=
 =?us-ascii?Q?TRabIKkptVMB7JaTbYakzr6BxkTKWvHstj6bjKiXxf2b073Qj5nC6vhC7KNH?=
 =?us-ascii?Q?NpPOj/DpBqKAYhwmXyIu1p2lbhqQ0na5n+n9g6fjKVWiO90syosbPBLaYCGI?=
 =?us-ascii?Q?VAxJo/mNMfIbWenqFMgoujFOB+0yc3sW3r9zSVr5FGSDS/twIG9cMHNBkww3?=
 =?us-ascii?Q?xpBIACaibHTzYwUbQiXtdWWN8wPtVxCuLPtRo7uQD54QJR4DdozVmfisAWfo?=
 =?us-ascii?Q?ySHk2xi08QO0cpPeGegnFwX96kXZEAMy8kQs64u28T34HF84wf3DoVlnLhT4?=
 =?us-ascii?Q?c9MvAGkkj2ViBKjym6mcYhZDnWor7AF9EosDJBOCdMY+2PecRQWvdriiYSg3?=
 =?us-ascii?Q?oYZcWdoYE6zH6WDGOFn2zo9mT4Fk1OKlll1Cfn8i1fMw0MjeTzfWJ8fnvsRO?=
 =?us-ascii?Q?xHXI4uc4+fpAnWzpmZTNCipQll5Tfnwl+4SF53yJZ5C7YDjeKhUmmoMoxl5g?=
 =?us-ascii?Q?gtH2CZnggwtRXqmgAxyCy5qO707Adew3cE/LSf2TLNVwdtAras9gBC0zwaH1?=
 =?us-ascii?Q?Ag/2DRpCoNzuVHzXg/LSuhlMRWuDVTLP7B9YalRxm+rbrYgcYlqEagdUURbb?=
 =?us-ascii?Q?blSZNmKmEcXjRJnoOF0FPdfpKZ0aTxkuTFkzIxMHBwhznkYq+ULNKwuTjCoC?=
 =?us-ascii?Q?o00RLsEvoa8WamXpzSfnmOmhDZjDX299xTTHyyXvMGkZzGaQEB9Js3C+ahRU?=
 =?us-ascii?Q?rBudZ5prrqJL4C1JbYf/yA+25xCuVtS4/5FZIfnpuH7zrPpqd8NWsyaFFCUU?=
 =?us-ascii?Q?3bc25ovN+RSkvLVZmnt8syF8+UPxbDyMknovYUID4D717jgrUhEjAt5tZ+28?=
 =?us-ascii?Q?HITpzjRf0Vg9PWBSH86V70gT2ZEiHAg=3D?=
X-Exchange-RoutingPolicyChecked: Mpusxej3ttSBF1g+Sc1fEy8il1I1FLA2mG8RkfrKldOV8q2yYBtELFR3fXM8rz+AyUrA1eIdqh3d9FPxyakJoC+YyD1aTu0DJumR9WI4n9v3DW91AmdTQuVfNvDLIFkddawqzRFfWbH4thEHE8awgmUJtjPbCrCSJXZPw/UdgsqJHRRDOaQy1jjwECA3V9esVTTlCgGEw+Fz/tSFZLVJY/v9NTOu8yLDDua/+jhoGhmKDneLPDNfQnw6XedauZBFFt1JXSa1OjtRHONofeNkrXI8jSNZweUCs09NikDJ1xCVKljUKrzCK/BnYaPPCm6Jmmu8m9tjtH2R8pmOTGCNNA==
X-MS-Exchange-CrossTenant-Network-Message-Id: bb453957-778b-4995-fafa-08df305a8bc1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 16:35:56.1927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVWLWU7svUep9zMelgS1PuImZeVInA6uFoa7gnC0butOUXuluwAE+Jkpc14ivJjtUxbRWak1mNIzbP4KBw0qBa6iEWZiuwmRBmDy0aleNMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7571
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

On Thu, Oct 22, 2026 at 08:54:11AM -0700, Stephen Hemminger wrote:
> On Thu, 22 Oct 2026 20:23:48 +0800
> Wei Chen <allen.chen@jaguarmicro.com> wrote:
> 
> > The _strip() function passes a char directly to isspace(), which is
> > undefined behavior. The ctype functions require an int argument that is
> > either an unsigned char value or EOF, but char is signed by default on
> > x86 and ARM, so any byte >= 0x80 in the input is promoted to a negative
> > int and indexes the ctype table out of bounds.
> > 
> > Such bytes are reachable from a user-provided config file containing
> > UTF-8 or other non-ASCII content.
> > 
> > Cast the argument to unsigned char, as is already done in
> > app/test-bbdev/test_bbdev_vector.c and elsewhere.
> > 
> > Fixes: eaafbad419bf ("cfgfile: library to interpret config files")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Wei Chen <allen.chen@jaguarmicro.com>
> > ---
> 
> Looks good, there seems to be lots of places with same issue.
> Perhaps putting helpers in rte_string_fns.h which handle the
> common ctype case and use comparisons to avoid pitfalls.
> 
>    static inline bool
>    rte_isspace(char c)
>    {
>    	return c == ' ' || c == '\t' || c == '\n' ||
>    	       c == '\r' || c == '\f' || c == '\v';
>    }
> 
> Quick AI doodle.
> 
Not fully convinced we need a DPDK wrapper for this. If we do, I suggest
simplifying to just being a casting wrapper:

static inline bool
rte_isspace(char c) { return isspace((unsigned char)c); }

Rather than a wrapper, I'd prefer some sort of static check for this, if
such a thing is possible in checkpatches or similar. Better to teach how to
use the standard API properly than try and hide it. IMHO rte_ prefixed-
wrappers/replacements for standard functions should only be used in cases
where the standard function is missing on some platforms (e.g. strlcpy) or
has varying behaviour (basename).

/Bruce
