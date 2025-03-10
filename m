Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB60C282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 10:52:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B01B64021F;
	Mon, 10 Mar 2025 11:52:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 1FDC140151
 for <dev@dpdk.org>; Mon, 10 Mar 2025 11:52:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741603935; x=1773139935;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bA35sGKf5EBEmpCCCkT6lnpSj8NnYzHWAoVUsXoa0uE=;
 b=kM3v17BRuNDlylZoMy28cd9Nk+2LzfjlEYkIBgIdadXJA2cyfwlLiOk4
 OolzQb+bDU2nygqrHM95xgo1kVmiSmObYNZ5u6+hV4+B2ClNVLOaoP9Jz
 3dapL4MC61ccUxOlBp0jRL6dlvZTGqJMpfR9JFzaqeZH0aOopYBY/0Als
 U4iwMBKohx2/joOEx2GDo4j7cr6D9iJMzvTjVXR0M+wuPDZwQubXYHjpf
 L7fjKMVXOltBPYRRwW/AHZXW620uer35V7PeSt65oKmFSaKvlXebxy9PA
 ZtezZtfE/ouof0qWf4ACoXBOcL/me1YkxIguLb5jkRMQSXR0/UxArevT/ Q==;
X-CSE-ConnectionGUID: xzVcPfAaTF+szwfHAIrWCw==
X-CSE-MsgGUID: +eTHshqyS+Cwxcm9KaJQmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="53584038"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; d="scan'208";a="53584038"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2025 03:52:13 -0700
X-CSE-ConnectionGUID: 6CHpZBNFSBKabOU2atJJHQ==
X-CSE-MsgGUID: eyW7YZk6QNiPX1UnUdhBrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; d="scan'208";a="150739082"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2025 03:52:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 03:52:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 03:52:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 03:52:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZoU+y0AvDGuj8fuW2aCmVMyM5VhbKssrB7KVKQirQ0AoAULMaqnqeyC+MfZN1OHOx8La59ixpL0Ho4SrUJ0HNY6lKhAsJybzE+LFVQHiuLWDi7jAUPg6qbPQ9Ad73kIS3peB8BzXAm6DbaKxfuRf6Hs8z+jJ9Fpn/1gF382DevyQrQ+OX8N2D4On/IW+mq8HzHQZQ2I/AiwHqbEWfathPRJTg94AdG8VGmiI0IGXIJywiRIU0QcbaRXdautILQVK7odDlQPyeoacNr9F+n6OfvvnDtq3aidItYLl8zmshSHX/MVAQMiIMvuQEVc5UwEIzzkm7U3KOWoM9ZSLDHPvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ea8riKdWJdNJAiC2R/2NsGYwkH5etw3YqaI4guLxnMk=;
 b=WKAKSwtzYr+RAmQkY8Jc+jrEproRJoVEu0i3MVR2Cc3G37k7oU4GXD05qFCLDYgRQKk/SHtI5ZnKxWxXIrJT/c6gI0PgNL/5pczScfj2JAjBn2st9m4VsMsi0vHOSruBCiSFOk9zYIlYXsUgh5RVDgV47FINmTg1oQPaWdA0w07+XeML1++S0xDG3DgdmDmQeGlci2Q1gk8JSVMdiNXMasftCbkYhQ9Rm1DiPhkFyFgIC+DlALEza/5u/8S/2T2uPbvB/MyFL81lIvQzMzlH/tVp09Knm913BxmEh+DOU5z1RF6FZ3nc7Th+lgotx289DbBdtVYNQBkzn/smUkPySw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6799.namprd11.prod.outlook.com (2603:10b6:806:261::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 10:51:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 10:51:56 +0000
Date: Mon, 10 Mar 2025 10:51:51 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Yipeng Wang <yipeng1.wang@intel.com>, Sameh Gobriel
 <sameh.gobriel@intel.com>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, 
 <dev@dpdk.org>
Subject: Re: [PATCH] hash_readwrite_autotest: fix printf parameters
Message-ID: <Z87ER_iHAgTw1wuO@bricha3-mobl1.ger.corp.intel.com>
References: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
 <Z8q16Ikzl4_flbpK@bricha3-mobl1.ger.corp.intel.com>
 <20250307223401.GA27687@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250307223401.GA27687@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-ClientProxiedBy: DUZPR01CA0171.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f80090-b197-4f8c-a66a-08dd5fc19373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BD/s1dAOcsOsAfpFVMhlaXnhURefvo1YKy0KVVTnw0R27hXlVRkxp/JVsKA7?=
 =?us-ascii?Q?sg2Ex6Hm/uE7RlcaHzzDnHBhQeBH3T0zRYjyFeuOv/bLzrXcPPthxR39KEHR?=
 =?us-ascii?Q?qh+HdZskoFDVJ1CcpWxqWgV1Ja1Nh7coN9ux/D0SkPu6Eax+BVhAPiBGUT7M?=
 =?us-ascii?Q?xUwtqy+I5t93eKW6JZXcemOJVAbyx6WxmmaMe3i7yUGwiUxux9rDN7Iz+PV4?=
 =?us-ascii?Q?zGAlsRbWj9xd6N8j64O4W6KUSCuphFIapN2lrZpUnHPj69VHfQfqo4tAc7f2?=
 =?us-ascii?Q?S4Hzn7zz8eiP0zBdyn8DMfn4oA3BXmxbN2gUpkQwJrbn2NdTpI8e3uvjO2ZO?=
 =?us-ascii?Q?KpWMlCzL6Dtg7XbsZQmnb129rBxhAa1BqXCvv0kCRJ27MxitDIY2uKiwZlj9?=
 =?us-ascii?Q?Rz7UvaqqAD+L/DmO/lcJWQOrPRtthPjndiOiRQ5cs6tGpWB6udnjucq4GGl4?=
 =?us-ascii?Q?kIJzu6ZYo6MH9EJalh/KVsKNldjbbZeoPHoIpYsTjkQWMcHDgDWrs7f8XiDk?=
 =?us-ascii?Q?Qy6ONLt5rUkE8pAuDRv6fzA/wT3BRrEFrePUb264uprddYXhrQn4Vh9yvl4J?=
 =?us-ascii?Q?ogV6LHqttVNgaWaY08lPXRty4egc8gWfIiAQnrSYcCS0WBHN4xpEWdKEJ3Oh?=
 =?us-ascii?Q?nnR/0ZMStPRRLJBRknSWLi5Vbp8n6nWRXErute8ckm4SYgHiRf+NFAIxGeTd?=
 =?us-ascii?Q?TLcpq2elxf6XT5EGdLbZINgP9nMC+k1wbf6wPBYONqakQglzBNKgZfgpEDbI?=
 =?us-ascii?Q?/Po5TjsCm05RIASLpNE1QszXTpLJAKBh9uvI1x7aWka0z5si2jDbULZ4tlCw?=
 =?us-ascii?Q?nhx2PbjIS9DPBm52S+e/a12r/4aZfl0UvvtaBN/OrQubffm7P5uvsqPXiP9D?=
 =?us-ascii?Q?8zOTtAEwQLPrbufZ0sEA/Y8i0o/+7cQtM5UWhJE288+lHrKUrdk07mr1cq3k?=
 =?us-ascii?Q?P9O4IsAtfGNgdLdqpe7mtOzOZIlcdFAyjjbg/+Gyr+1hvAQYG01YRZPS7k/V?=
 =?us-ascii?Q?FDUeEnas9O3Vk448YdKNVuw/etnQmxlxM0NhHCIqGkK/uB1cdBr+oH8LvyJt?=
 =?us-ascii?Q?xAaFmbmrKMqJ0TvAVakwpk6ARDB7IkFc8MZcclrIvdyQA6OeSv0CUA4cMnfp?=
 =?us-ascii?Q?SSL77bRY5Y3iwTArbqTjJyQD3T9n/Wil/7NwCMnAYfO5DFKVKGgiBjPtI2Eg?=
 =?us-ascii?Q?9v9FN8o9Qs7tZs/fKbf6F06O/As4Bn0OMDyqGxWTgSrqz19PtoEmWgiDxnqF?=
 =?us-ascii?Q?PMg8KuXb80KVWQph6wv2KkwEKM1kFdqGEJqS4Ps6AQapQaHMBBKQSgglH0TI?=
 =?us-ascii?Q?uEMPubL+LbG6Ad95cer+fQtauQEwvloNCqHRs/ey44MyEQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CqbwB369kgsujdUtntUwmOf8IFdig62RM8ze/TjgwvSG9EMj6uU8r0YJkH14?=
 =?us-ascii?Q?Ud40Vo6LA5IQ12ED0/2ocPR8dDCD2NS5AHf5Adkfeo0ox3zdwl3ZgqvVyAsy?=
 =?us-ascii?Q?7MP3N+KtkTeCTrFZbd99//1/jh3Zx2Arf9cVzamRJVhzVj2Q/pBHcJA0bNy2?=
 =?us-ascii?Q?oGDEyGwlqrW6kEfV1X+O5Lgkv9L/qOpq5FbJTZIRw/Rt4EXcbuqg1Hpc1UqX?=
 =?us-ascii?Q?RZazszjFskuxoseCPZG1/vdubYOMa38oLwhIq30QGVbnXhcX5FvKqayvg2Qh?=
 =?us-ascii?Q?mmuCKc4b4D883Hr1K7QCTv2kW2wk6zfMW4fd0VVrw14Fluhbtxdva45/Scjn?=
 =?us-ascii?Q?xAgDmP6oPRJBrMhSivvMAce4yeVEIlB/Ve00Q8ZjqoFUjQ+L5Uto63bKao27?=
 =?us-ascii?Q?T2pKM/F6dM1Hkidyu5i1F0DwwquQg7gBZ3ru4eaMdoCuCLDpYA0ieF18XGCl?=
 =?us-ascii?Q?TwM9FxKvAYFb8dRLkYuK5bUE+WqagoY53A1r3GQKhiK8UkovMl7MrM/ojk9J?=
 =?us-ascii?Q?vTMyglgDfSmUG+iauvDQ+9uTx97eocWRStB2G0jDjguDlDx0y1OuO/bu/4yF?=
 =?us-ascii?Q?yFbR8+kmBx2mbXsRPAZ1D4SsJb7WHfkEJ7bX+NV9Et2oeH1bN8qrGW11KCP2?=
 =?us-ascii?Q?UW6qngI+7XBgj4Ol/NmcC/ru/QHXaPE+rwJe8f2W8ihz8C/FIhHMTvGw3Mc8?=
 =?us-ascii?Q?fmi+wdjhm7wAz6OZLWM2AtOUsBA+ZUpQve5n4U7NmSMqfy4SqUgrMWW/PTKl?=
 =?us-ascii?Q?m2r0XKwJAv1jX5C+J2arvmpckml2HkTmoqaAngXcfDTSLAQ4EAyzkHFdy5No?=
 =?us-ascii?Q?yg8PwNI5hDY252PLUCEk4IsDP73ZoPNQgMQ8blfHaBSTKrfHxcsopH9u6Rjg?=
 =?us-ascii?Q?RfmG+LF88D6lR1P5du33eI359ndgq4/5ncDtj9XgKXYz2AKZQ1rQocp7ste1?=
 =?us-ascii?Q?i9j7J6JXo9Pdcsn1j1daz8TxJbRuCmAsKDMr8GZLIuFEfvVxhI8nvqNJsv2h?=
 =?us-ascii?Q?28eYjEV8Iwbo+I1Bi1U36R3ZwCDA8FLmfAXst5TpuwSUnHAup5824F+SZqXo?=
 =?us-ascii?Q?5VMqU2LdT3yHMEID1rzPC6Wcs0/JoO8MZ1n67iOWihxjGxV2LCKDf4WTFnTE?=
 =?us-ascii?Q?cm18wz+3dHlY0OGLXZGSkESdXsl59fd6Bduv7x53mcH+j/IKrvB+MNSux4CK?=
 =?us-ascii?Q?BNbHubdZNBxjh0TJgGhcvzBwHfVjlEfZHy0pPzLw5lQg6jjwBPCYPcFSWhtD?=
 =?us-ascii?Q?rLX63DUgt/WAD5hb17EgBAER2NfFSXDUbV/iiJzQOEjZc4RwdWbGx8j1idqz?=
 =?us-ascii?Q?/FhQEuYRCQAea3j7TGF0x7317mLrWAOybpWDS7yXbU3ZrBzu6uDEPqD/1iUA?=
 =?us-ascii?Q?u1EOTcFz/e+hElkzjs02jqtAZa8aNHDib+95y3/lJyglBWtEHI69KvgKRxOh?=
 =?us-ascii?Q?BWZT3qLJsDYRZx7GJz+k12tZ19HBN/ZZef1V0zsRHEFIjEckCsh6GrtlXr4A?=
 =?us-ascii?Q?/AS+cuPChoNa9d3cNTCGz7TwNYXF23xGx1PUpgCQbTpkNQygdlYgefzYkv6F?=
 =?us-ascii?Q?iQ9bVXJvyoqfgU911Mv1sZnVi5mpSd3I3F6sp4zud1J645HozWFxCJVvaxIz?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f80090-b197-4f8c-a66a-08dd5fc19373
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 10:51:56.6384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Tny5vbWJMuWuXnvzGbFQ6ugWWi2m5mffQ+1YV02m4/ykUG9Z3tRQJ2gE3NZ0GXnXAvoBqHP6qvjAK4WdTsuMSPWdKFwzLxIj2O3iDEB1OU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6799
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

On Fri, Mar 07, 2025 at 02:34:01PM -0800, Andre Muezerie wrote:
> On Fri, Mar 07, 2025 at 09:01:28AM +0000, Bruce Richardson wrote:
> > On Thu, Mar 06, 2025 at 12:03:28PM -0800, Andre Muezerie wrote:
> > > Compiling with MSVC logs the warnings below, which result in
> > > build error:
> > > 
> > > ../app/test/test_hash_readwrite.c(73): warning C4476: 'printf' :
> > >     unknown type field character ''' in format specifier
> > > ../app/test/test_hash_readwrite.c(75): warning C4474: 'printf' :
> > >     too many arguments passed for format string
> > > ../app/test/test_hash_readwrite.c(75): note: placeholders and
> > >     their parameters expect 2 variadic arguments, but 4 were provided
> > > 
> > > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > > ---
> > >  app/test/test_hash_readwrite.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > IF the "'" character is not supported, is there some other method to do
> > thousands grouping in MSVC?
> > 
> > /Bruce
> 
> The problem exists with all compilers I tried on Windows:
> 
> 1) MSVC logs the error I mentioned above
> 
> 2) GCC and Clang don't complain at compile time, but don't honor the "'" as a special
> character. As an example,
> printf("%'d\n", 1024);
> results in
> 'd 
> 
> It seems that for this syntax to work as you would expect, support needs to exist in both the
> compiler and the libraries used.
> 
> Back to your question: there's no equivalent syntax on Windows that provides the thousands grouping.
> If really needed (and I understand it is useful for large numbers), we could get the same result
> by calling a helper function that would convert the number in the formatted string and use that
> in the printf statement.
> 
> There is a Win32 API that does that. It takes a string as input though: GetNumberFormatA.
> (https://learn.microsoft.com/en-us/windows/win32/api/winnls/nf-winnls-getnumberformata)
> 
> We could use ifdefs to keep the old logic on Linux and use new logic on Windows (for all compilers).
> 
> Let me know if this is something that would need to be done, or if the current output
> without thousands grouping is good enough.
> --
The thousands grouping is incredibly helpful when working with large
numbers, but given the lack of support for this on Windows, we'll just have
to go without, I think.

/Bruce
