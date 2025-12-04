Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041BCD24448
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 17:04:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B823B4021F;
	Thu,  4 Dec 2025 18:04:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 2E05540144;
 Thu,  4 Dec 2025 18:04:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764867860; x=1796403860;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=937ZOf9zBH8ml2Y9WqH1tK1INYutqY5ukeQZ3C+7zjo=;
 b=Zrp7/QNTTZwxZEM4/XC8SY8OYhqzPBbYd92/eJaTJZd+imIIF/xo5OPs
 7Kp/9nVZ4NZQ5s6vQKKWivW3e4B+e5NVIfRmEeOocgb7y+xu38uWWaFBc
 h192v77vzmlOp8eM3ZFhIKUuE8u9FKmyGy1aDD/MKcGTyc69M9zBvXpiO
 QN+kJvXFjmf8xyoqfoLYefSzBWCm5SiuVVDiCXsoGLOcLsyJyjHKxhz9G
 mgId/+P0LDnozs5mrI8K9jEtnMveo7LlfBkWuplcZ0OHeEpQD4Ktf7myw
 vtLtRHYdI8Mpd13ahgypZrV5Ck0eH2r736oD7blYz3ybeokoomvvVXZK7 A==;
X-CSE-ConnectionGUID: Dymat3xVTROQyY6H10MyAQ==
X-CSE-MsgGUID: o2k4EBlmSTyEsguQm1oAhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="66081695"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; d="scan'208";a="66081695"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 09:04:19 -0800
X-CSE-ConnectionGUID: jG0GkHn7QsO/l/itcM6WUw==
X-CSE-MsgGUID: IESuPcfuRYu4jzYVkEbiaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; d="scan'208";a="199211966"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 09:04:18 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 09:04:18 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 09:04:18 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.4) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 09:04:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJjm3zmpt9bmLGGwNR4pakBsz85HZ+zskspiJ9NzMbmX43e41luZYRfSf7/NC9pCf/JgNlQycisO+fzXASeHIwx9ZsUd6gOrfPOt9MyxEr4M+wUSxzI612K/1iG9BhpIfgD7I8fNDpGrq0YM56svyrlvi5YytZGfWA56ijSiGtt9lPgFMJkVNTNbkZ+NQ/21Pt6tHu6gM4FmtLLstbUZO3MPDRM0/1UTfhOWNUp5P7vw4fb3ta/HFitwojudMBAG9pvcvl3CNHwO5TBEDC6TRZA4TqLXfM2xv8WCJoo5mV7nOgmXDl0v4PI138ku0DcOyR83OEjvbp7oLCAUbZUmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ri0ls6n1ZKSHD5zHFuQzChCj61GyxIAaK3RjohYu3Z0=;
 b=AGhotLf8ftmnPrMZCkeWwxquz9DRvDrv7y2AawMzWj776Ro3ZfxlUIp9Q/TS55vbQXyyXuFgRVGhB5rN1mSizBsDeGuYDmEIvZ6UTR/HGNdMt1U6GUA2k+5eWQ+SJidFwudo5u6+MGKN+qxwkoAO2slIw5hgjQ5Kxi5TxZ1RHwKil4zl8eYPpitTvbEm5XtYq26PlpNjo3rcs0A1yP4lsdsJf2F78D9+lW+vMXLQyfEQJ9MVYBiAzgFvdfE4kiHwFTAosQkpBLQ3zBU2HQE1aoTRjo2PQd56MeSvLBtrSXdl3q+t865j71K6kaTWVmllhj4VfvghtdD9YdPhgpqQUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7287.namprd11.prod.outlook.com (2603:10b6:8:13f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 17:04:15 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 17:04:15 +0000
Date: Thu, 4 Dec 2025 17:04:08 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <david.marchand@redhat.com>
Subject: Re: [PATCH 0/2] Fix errors with updated MSVC in github actions
Message-ID: <aTG_CL7X12uj7Afk@bricha3-mobl1.ger.corp.intel.com>
References: <20251204112904.2869502-1-bruce.richardson@intel.com>
 <5061127.GXAFRqVoOG@thomas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5061127.GXAFRqVoOG@thomas>
X-ClientProxiedBy: DUZP191CA0033.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a04a78-a3c2-4a65-dda8-08de335727a3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nqL34D28rnsmuylFI9RNrsqJlRRLLnc22UVerrybVnl7/dCOpuHDLbcTjQXL?=
 =?us-ascii?Q?71MIz2fMaKWgJmQ45WiQusKvmeKTSSXOqdtgvvr1U8TDjwRhkKeeE2wVxOLw?=
 =?us-ascii?Q?NbT6K1LcVccWsNcPntKtHrmta4fqfZQVKHdf/ykVS8R6xpj2KvBznO0knrAJ?=
 =?us-ascii?Q?lksPr32XMjF0QMDPcLXkIjUgbWxkPhuzUWliCJe1JL+ev/1QnOmKFVwCf3ei?=
 =?us-ascii?Q?ONW6r5SeyAWWIHML2JvPFKwZWafheHXkrst6IVZLoSHCpwj5rnp0DeKsrwPs?=
 =?us-ascii?Q?kxUk6mwlARnNLnvrIWxBqFjPnBWd5urLAknf/9+xQWDcQOzDln8JwqQ9IFJu?=
 =?us-ascii?Q?Gke/mM5K9lzJWOKTEYmYdTjrHpkJj1R6NKz60Z+WrfEmdY5zNV5YqNQFQDWp?=
 =?us-ascii?Q?uhSSBQ2ZC4EKc8LcElZZu3yqdAA/wWzyzIKn0KqUlDBP0eCZShaEIn5Vk4ch?=
 =?us-ascii?Q?nEj9Pm51fG0bE7uQfmyJTMr8+xnIVpGj4j6YTOGXi3pmHR/XAG1EwICtTtCG?=
 =?us-ascii?Q?CATQUXni3nG/P/GHhosG6buEkjl6p4x9wvsmdNuv9wVm8AK/dPqZ6rqFYqJk?=
 =?us-ascii?Q?tELBzEtp7XEAX3kXIXy1ati0jB8x4niwHXm94Ul1zTZYV8v+yHUkRq9CMOoL?=
 =?us-ascii?Q?8dt2Yr0DxffqNdcqGVXwqcGf0L9vpLN/ypJQOCD4fMy0qK58nE9gxivNcVuI?=
 =?us-ascii?Q?6XQsNRZyeIAYwGw+rlC995BbZFyx+4xH1ZytHBDZqkpEl63ByEXfaRBcOpy8?=
 =?us-ascii?Q?SihPl220H3PaLfLbzVjgu4qBpOuJsG+VYPg65dA6bu3gzRk/HjScppRkAy3/?=
 =?us-ascii?Q?gjZLcECS7a7OneUDNuw8MiuiyWVmqRwlWxHI4fbrxKr/OkCX+ZygtJuwtdmO?=
 =?us-ascii?Q?0QR+lGJT9aH6TghUNvrQJEs6nfzVf6BBG0zvVd6ocnvpqSJhL2Zlb1GD3ypZ?=
 =?us-ascii?Q?C3aJgXO/j2IXlFeIQG3E0/7tly9JrMfxtOmNUI3MjFC24Wy5uG0JhaQQfOhm?=
 =?us-ascii?Q?+VI9iIxJpGJR5HuFjKBOja9/epuFXLRX1YQqOodP/4H3RaVW0Hwivn5G5XvL?=
 =?us-ascii?Q?TbOiQm6V0ACTJbAGbtJRkt9FjEPoMVow7RSRTh4lhSD+WefcMFeW9CnrG6T/?=
 =?us-ascii?Q?3TaWDupGyGUB5b5yRyRSEkh+G8ilm43/ZmQo40ouSO/+cXNWw9nGZHPVLkPl?=
 =?us-ascii?Q?mAejGocfdIavfzFKwNrb+SdnYkGttV4ltBO8K0NToG0mVOEwZpGEILo66zaM?=
 =?us-ascii?Q?IqYSDcxp/Zi71TeCVlCKaLo4MTWWrpZ20Pnj6d2lii5J4/K5B4pkaqaW7WdB?=
 =?us-ascii?Q?wYxGkSINkKgufSzlgYAv9VyQypgLAo8O5wJPnzLpBC4o7Z8JmUtNSRxWdHO1?=
 =?us-ascii?Q?0snQfS4hcN9eH3VxWGCeV/hHCWhmvNDDBH3mFyLCHk89zWySDjdzADZQkuuw?=
 =?us-ascii?Q?kcwjW4hMoD7bZ6RhF7A/H2bdDolhENMQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Mw6qt2gMstdL3rqqWJqadxfP/5UbJ3u3FdAU8OJhclbuc7tjuWhj4WuPmkL?=
 =?us-ascii?Q?iQ0upLDZGiFLM75YIUuCX4nK2lSuTa1h0tZ8sZkqpuOzl5Tw0RS8pwBsprcj?=
 =?us-ascii?Q?RMq2zRL/0xdTzd776zA7x+Fh4N3tDvGH0YEnnp5RikOAvpkbAFg9AzFi9dxG?=
 =?us-ascii?Q?7m0L1c/oy8MflfN60jlh387NfDtc8dmvSXz7DF+iq3n3fYJsC1zfHMUlzQzC?=
 =?us-ascii?Q?gUyrQ+CoSeBJPpLrHLHuB1FrWZ9IqNSqwmMV65ZyESsqHtwGVC3Yc5eqVjp+?=
 =?us-ascii?Q?9wo+4NvmOuyhR51ZcCq7DtafUOhzLHz0LJ/dU14/6arRSUIW6a8iUn4GUqf1?=
 =?us-ascii?Q?woGmRNFRSuRP5NDTw9bwiziafzSrrIc7wiFn2+lcfXu4OmCtSEXKMCFern80?=
 =?us-ascii?Q?IMMhMkATsshjNsAq7DxHC0bJ6PfSu78L81LEM97Z+gq88orzF6V4f8Ju8Ejr?=
 =?us-ascii?Q?3Y1fJEqsE86npNW82lx/muYuLA6z45ov9YQ8dv2bdDoz9RBiKHVKuC10J2by?=
 =?us-ascii?Q?kD4MLnh5N5vlDdYL0B3ZxgBOI5DzRUxW/xHkqhos5r+NJUA4wMg1L9hlZumM?=
 =?us-ascii?Q?kXGCOjZD233o7YQ2u7RpDP85ATF2nf7ra8lvY9uq/iEbALKzSBrpZGGKVagt?=
 =?us-ascii?Q?gbCGX+uGf3iib5ByfCLO3zS6Po0IzB/vjWp1S285qN2mMBfVAcRmccIY7iJc?=
 =?us-ascii?Q?zhyw38s+MYOB3eIXSyyhfMrRAI0pXxQZU+y0yltqSLmzMeriTdZkLyN47dho?=
 =?us-ascii?Q?H8FdFTJXHHEG33BIoEeT/nUrqA2KCRsypGXPIJc9iyHqsNWocx+3SW2bLKhY?=
 =?us-ascii?Q?ecdUt+8H4ppdWURk1tMh0PxnNqxOt04vcW+cB5ISHQwdzz/91TkJlwONAdAF?=
 =?us-ascii?Q?Dp9w9kKMLQjoC3NLcgFy12oiHxYZ1mGnUs1zNafPZaokfyr0uNo4CpKyfngQ?=
 =?us-ascii?Q?LDa7gC46/b+kySc7S0rLXcjZGnH0jgiWXfvG+SCHp/LW809ZE2c4vXNeYEKe?=
 =?us-ascii?Q?sYU8FF4le5G7yBVvT0vlwE28aJaD+2VHaVlLcH/z2S2l3M4mAVhJ3J10glzm?=
 =?us-ascii?Q?bXrz7i/uWLBUNpgeqClGvNKR1uWY4xgV8DFy5Gtn+xVKQekSoWZ92aqg75Q7?=
 =?us-ascii?Q?KHBlIL/yxwZr3Ni02VXiKslUhnrEjdCnW+4nAUYmdOBebyVGe0zLm1Hs2kGt?=
 =?us-ascii?Q?WrPWAzcvefozi/E9QL2WLfM9PywbEQs62gLq4csgn9C3CuIFMldISPOF7L5I?=
 =?us-ascii?Q?ksGgCSJpiomSqvzrqpfhR2bO6iw3B8T2ljoXhNLKceMnWcAkMnt72lMuYScu?=
 =?us-ascii?Q?9QnpIgrpX7Pnq+wiHfvalmZjNsyps4bavek6g388/jp33lbv1gBhpGXgz3ez?=
 =?us-ascii?Q?zWrr8WESVMoXpp0jNGzPylZ22iHYsH67Ol6VteGZTTkE/ypuvXo4+oHrVbUC?=
 =?us-ascii?Q?l5yZXJjYP/fKBJGZYMuwqVsWXJLKBJ8Aawpo59HtvOmU4XaF0+a1rsTmyqwY?=
 =?us-ascii?Q?qtEJb9440mNnBY2RwyWXv7q2+ReT4cvmzkq/U9/fKtRM10/7lFqkCyCcxE71?=
 =?us-ascii?Q?6LDs23RoHh9GiUQK8EFWXWxlpolusSTwVjTSrT91W2jzaPdt6ojRjVDT9cPn?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a04a78-a3c2-4a65-dda8-08de335727a3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 17:04:15.4615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2+KXM6/b0IeBYl8Ge6/xvFua20NF6Eh0DFhV6lOBIXQebsEqTZziXLP16p2nhLXspOcAWg4Zftyx0ZGakefd+KOaGiHTCI2T0Dx7AqGdN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7287
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

On Thu, Dec 04, 2025 at 05:31:49PM +0100, Thomas Monjalon wrote:
> 04/12/2025 12:29, Bruce Richardson:
> > The version of MSVC in our github CI has been updated so new warnings
> > are appearing about "zero extending 'unsigned long' to 'uint64_t' of
> > greater size." These two patches ensure that the build in github is
> > clean again.
> > 
> > Bruce Richardson (2):
> >   rcu: fix warning on Windows builds
> >   net/ice: disable warning in base code for Windows builds
> 
> Applied, thanks.
> 
> Note: MSVC is a more accurate cause than Windows.
> 
Very true, good point!
