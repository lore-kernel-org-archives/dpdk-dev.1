Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550F7CA1015
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 13:54:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BD0D415D7;
	Thu,  4 Sep 2025 15:54:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 14A4741156
 for <dev@dpdk.org>; Thu,  4 Sep 2025 15:54:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756994080; x=1788530080;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=jr/qrsDOq9enQPPYMvPZ8nBEfZT4s9xwWc489psCbBc=;
 b=MapNls9mxizKcPvc59wz0WQq9W/N0dH4bUYsfRXSKqhATK/LZ9REw5BJ
 30G+XNrUlNzTwrjA8n+z7R4ZIauympZ/eVME09RuTfwBLsDjnc55aEyw8
 aopcwcXPM7HtvHOhl3AoESA8wvwInzpT49iTuBjNDYJkmYW0tG1DTv5xa
 vNxSbseRPVSjzjuVcJ67fsZBFW7Cud9VyfVShNYd3jp0HxL8su++jsdWm
 amuopYIYqb2WzC2qDCkhR4VxQLY8um9F4Lb2lAGr/ff9cnIyKZNSrbHnV
 Q11yvcsvctwA5Zt0l9zw//CLjyc2jefR8rW8Tg7r2ZZOa/2u510Iu63HP A==;
X-CSE-ConnectionGUID: 5mR9jnY2RROKvvzCbt5U6A==
X-CSE-MsgGUID: ynGiVHRmRSOE06F2rMvTaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="84760256"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="84760256"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 06:54:39 -0700
X-CSE-ConnectionGUID: UHZRW2l0Q92vf7r4XwXr/A==
X-CSE-MsgGUID: PlNGwtqaSyaF7Yod7OrSiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="171787267"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 06:54:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 06:54:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 06:54:38 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.65)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 06:54:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5cD1Ju4PkFT2pGOFWs+pzjXKYv77xCItf0HlbYrSnb6XIumtZCGEtkC7mkSueVKcNnlLVWeldMdNc7DC2Grwxg9+hAqOR0T3Y/AakcXroNFM8QYCE3aLFPn7vBOxKgdVfwiW87naIOqtItB6rHHCVrOfQ4olmEBIwbmYvl1NuYIu4LLdZHDyvwpyEjFNY07Jf5BNdMP/1+d1jT9gcnHPaVE+1RU+k4roZWPBcxcS1wbg3wTbs7gSlrQPn9er1jMBA60YZNxlCSr6kuQwk5wm2PmA2wih5dD9mA/IVk91DlBxnwgOmnhkLjnasVBx1Phm8DQLiuiS97KFKkdBo1sEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQ6uKBgq9yJ2OUeXbMWvg8UCzcEhdt32dHWdBMLVF20=;
 b=O/H9MB9g4zw3HoXCREq7T14cldJpoyJPI5wIqx75avowHOcOwLzQYfdhk7c7Af6avRXHxYPWBBkiIXIXcxtNuVz1yCzLoO4ICUlnLlFXCe8agU4KiceQ5FavLoBLMIyfX3wZ2FFbXolJDs9IGTq3laE3GT3E1dJQ2k1/0tHcIbcC9quihJu2jtuk+pw4Cj5IBwIabpHLqVdRtdSgxwaJLnA/ImDhTbn13H+Pc9jmZSgs0gPRH1a8NTqJJePfIU4lz4pHB6kBB23sfdPpB48vgzMvygSa94GOqh4kUVhSoKgurZC1JvgPf2UcVJKtJwnlSAZs5j+1RWwi6ndtO/My8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPFED9C9AC99.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::85d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 13:54:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 13:54:33 +0000
Date: Thu, 4 Sep 2025 14:54:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Aaron Conole <aconole@redhat.com>, Michael Santana
 <maicolgabriel@hotmail.com>
Subject: Re: [PATCH] ci: switch testing to Fedora 42 in GHA
Message-ID: <aLmaFGE5ysbEnrHp@bricha3-mobl1.ger.corp.intel.com>
References: <20250904134531.2171206-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250904134531.2171206-1-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPFED9C9AC99:EE_
X-MS-Office365-Filtering-Correlation-Id: e141c4e7-0010-4c97-f101-08ddebba9419
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cxu7inHistQeJEa86y/urdrAtk9E0rfExpB2vkOuJ2QH7WNEsTip4BoEdCDo?=
 =?us-ascii?Q?1C+tGldyZFUYQTWDrLgTT/zPC1IqxicajdLy5UtVHHd63rXMcNKn5FpskOa6?=
 =?us-ascii?Q?gW/jZsK3ZZEcL4WnTQfKWA89l89P+7CAMd0cd1T390Kn5vBxB7+q5NDp+oWg?=
 =?us-ascii?Q?8v2g/iQWngEuGkEsa5CpHXOqVnk0L95Oe/Xn5FEKzKbjuc1SO9WOun9+PGy2?=
 =?us-ascii?Q?mt5WdODFCgILhTVjv7qsMvKNaAno7tuBhFjMD2nUhxBRz2e+lQP6HmwHOrMr?=
 =?us-ascii?Q?ZUBMMlKViBUT3tRAJwscI6nzTmkJWyYh41RiFfz5a5L+GDMsATXCbcUID42s?=
 =?us-ascii?Q?h4HgHGcYKtmVZ19Udwds7cpwyiMYeMpaJvaBmXWFjWhe//QidVeansr0rbv7?=
 =?us-ascii?Q?S5LVPvMM9IhuQ0NTfNBGY3EulkiCLQtUAjhqfVhV/HcaRU+b88RhIFdGFYDn?=
 =?us-ascii?Q?MeZzVYwNk5BXwY82JJ20EwguX/GJs5UI0qq5Ys5uwwNsOzOE9H3hyHj68E80?=
 =?us-ascii?Q?kMwrhjCKjeQGFX2M1FDjwIpP4lLE+RlbmQnFpDXgSgU8Bdw9mV72ZRJRPXa9?=
 =?us-ascii?Q?u/1A6y3rETEQFGM+gpRdLYS4K1BVEJaeja8FitRuz6NkFRzWlP4y08Se9+rS?=
 =?us-ascii?Q?Uzv5R1zAQ177su9biy+ubooyzH4CD6czuct/HGj/GQbbY3Rc58JNf+x6we/6?=
 =?us-ascii?Q?QWEe7iP19H628Lie00ZHTkJPitdffk9OiyAlL9xLBzClfFmsc76aq2XMVWUI?=
 =?us-ascii?Q?VKAwNQaV2Q4e+n0nVtXfnmpNbzIODeLGYsDN9Z0WwFAdrzSYYkNjdLEQAVUH?=
 =?us-ascii?Q?q800m6whPjyXzc7vs3IDC0Cv9e0vl7BsAuwo09xAeiOTV9ddwXaa0DG8GRdz?=
 =?us-ascii?Q?zFHuKFT4URL5KrLrkWn9cvBKeRmQi7tG6XTWegfaKvSExFlZoFMTRqEoVrvP?=
 =?us-ascii?Q?VOsP/AKZtVG2sgmD4H1r2jtasasdxs/VowdZcrZDGAcIxRewu1icMUxxUsSv?=
 =?us-ascii?Q?NPMqs+VuykopXgxuRtjPOec45ZpiqJmpdR1pP1qniZL8D2VFZ6KlqM/quzry?=
 =?us-ascii?Q?DyUk8eWPuhGWxF2DyQA0xB+akS4kx+s/ETW4Owra6gRJm9gFZ57QXMkKFwGr?=
 =?us-ascii?Q?Ir4V2VePTMxE2YkvcXAJZW2z678U+pVfg6DToTYCD3Cmah8JxWP9dir3lZKY?=
 =?us-ascii?Q?L1KMR5rYVJIRJ9DQn1ZJIXAXHVeN+OBcuVFF8TZPJ+jO2MdvlYw1eSn1s3D4?=
 =?us-ascii?Q?AYGbM/g3oCbdyIKjQfrB+wAGyG4DtplRsBSxt1ihWpaN/neHIIDXZGVpgSeT?=
 =?us-ascii?Q?x10KJHbUyFcrUc9KjP4UhNJN7+5+EQE2/7DGwB/UX7Vqo1EGKCUG0fW1CPye?=
 =?us-ascii?Q?S+kp/8Tg+TQkAmiAcMNAqIJxPfWFOZQshU12fHiOzn40nfE4ET1D6roLjgcq?=
 =?us-ascii?Q?7Ke9luxX/pU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DlkasofbEj65mQMJ0QfsO+ADKNhkAIgpiACWqKGt86p9AsgU+rzfFv102fOg?=
 =?us-ascii?Q?WaFMtmOfyqKp+J+yLPfEXl8HwADJ1sfQqZ+2L7i9GaapA1CkLe4/GQjckeZ3?=
 =?us-ascii?Q?jyIQwZ7FazWDHyCRWYHXbPvzfR5cVMtRPnlhMrivPm+HOsg+4ya4IZ1xk08s?=
 =?us-ascii?Q?XPdEqONUZ5MzFs7xgG+FowkS5/k7ZVZvMVR6WNcYVV+sXFxBlGO3bEd2taU3?=
 =?us-ascii?Q?au1EZGD5FqSnxoc2RRz7xKGRn/vs10oozKw7bz2aKGpNSWg2QFfTc1EhwfA5?=
 =?us-ascii?Q?pJW1qHQ/9BnmfPaGqLz7NJLSSbyfHpbGQf4jpheRDIj4gzJPboSks+ABFr65?=
 =?us-ascii?Q?EQH/to1omZlCCaJrxSwW92Mw8esOKf4k0yAHtPCyfgxMFp2e8IB0i5tW7uNW?=
 =?us-ascii?Q?yVrAhC8Sc9nn2whK0J9hlle68yEJ43HY+fhA7WFaOHvHUkCsmEWet4AqEsFz?=
 =?us-ascii?Q?WAc3y4fODMLdSi7zhA2XMfAV7pxb7+7YEEdv6b0dvhAdV68S01AvdlCWmz5I?=
 =?us-ascii?Q?5fJ/9fWfAsKRyG8Dcc5AR3jWBqo2AxTBwAncBTpJxyPHzlEwaioB2I+h1Lim?=
 =?us-ascii?Q?LLJnhPpCuwPAMAcaZMgj8Dk0m0cF5UclBbQ6LXdBed6E5JV6aZhVRf53XyhC?=
 =?us-ascii?Q?KoFXxlZwTC+H0lkNR2odT9Zba9hKp6tkDTuAedVbkvdXzfhkO0fwUhDAA3Gu?=
 =?us-ascii?Q?8SZyKGCYWhokmgdEma/ENZf+4o3+CzQN9F/zP4O82BaWrDvRj0HuuKDBDsuh?=
 =?us-ascii?Q?n7OtWqwQSV6sZYO7gfwd3SdHr23IW9j6Md2MvkdYD88/Tj2bD6lYWHzMG3Vo?=
 =?us-ascii?Q?Y/mOL9dIX1DML5Fm36NxOJeco5obRhP3/Af0UDSgspwWBDOYwPr1BjCwqgcy?=
 =?us-ascii?Q?IIryxZ1vBd0JfbIb0tbelLim+XMBG8U5GG/8LCNRm/p8uvhCBgY9d8yLcBOb?=
 =?us-ascii?Q?d2YGGNc7PegDPT3WX/4qQrDTUZbJIojYveRLUlseuhgzu1+oXW7N/pFAiSDi?=
 =?us-ascii?Q?qVatIZ+6qBjgh6fq7axcyizxwcjheW5CdrRijGse5g+pGAhjlX6x5sdpcCww?=
 =?us-ascii?Q?jxwNKYPi5e/sF3fu4+Sfn2kMvfizF9ZbHcY0Yr5iLAN53EaUaZmUw2yY01Aq?=
 =?us-ascii?Q?G8SQ/8rMYf1v/OtycGcD6+wAfF1zEQvKtMSTnp3zlxXmBE8u4c3VOtYJpq1k?=
 =?us-ascii?Q?METvkbP7VoeT2Ra4/ZuVsMuio5jchiVSYMWMyKGVoNtCGcwC5sNTSRz3/28x?=
 =?us-ascii?Q?O81miAeCO6k2Q4FZe8AlfsQPClTfWxI+DEXDYaBngskZuZJJEAUuVviSyfJG?=
 =?us-ascii?Q?aUvXqm6CsYnZSqd8x235P73yZl63BaTfnA09UbxZ9V6taucBQHTl+7tN67zR?=
 =?us-ascii?Q?mTqvdi0P1fnsDudFFlxiaw2xhSalJ5G7I7fYzpwG6/LfnPItvBSK/r4edCPQ?=
 =?us-ascii?Q?WPewVRtwVbzYjSjvsoGQ1W8dTJnxPcVu7vuQK3TobT960oR58EGPfDvsWtYd?=
 =?us-ascii?Q?Kym2BNiyyEuvrQXa5GcnCoD1EGNjx9YrwLvte3boMTYCkuk9B25i7qIY+mZn?=
 =?us-ascii?Q?lPLsylWKFNMCQ+GtpqYHJ5r+LeLAy36U2cLR8oo1wR9qngNgs9PBsyxKfRO+?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e141c4e7-0010-4c97-f101-08ddebba9419
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 13:54:33.9384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVoRvD61yLF74GNjGDoKGNjR0gZX4q4vSqFyLsbgy5Vy8yit6cVqpB4VbauJ7Ry3JxpUT8uYpud2Zsi6d7GsXD4A8RR09/W7mhRZl+9dZyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFED9C9AC99
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

On Thu, Sep 04, 2025 at 03:45:31PM +0200, David Marchand wrote:
> Fedora 39 is EOL for some time.
> Switch to Fedora 42 which will be maintained for a year (until May 2026).
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


