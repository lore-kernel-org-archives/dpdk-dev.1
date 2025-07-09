Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B70C83F0A
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 15:28:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 478F5402A3;
	Wed,  9 Jul 2025 17:28:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 58C174028C
 for <dev@dpdk.org>; Wed,  9 Jul 2025 17:28:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752074923; x=1783610923;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=EtoomnP5OSD3o9acxUAxgCYn6AVx6GpXC+9Hubn44PA=;
 b=PamqaPdIDTQFblS1arhmrQhaWVc/lB177FYWFK08npMmAppjQ7fgNaTa
 PAa8aKJq6VjdNwmf6gf7EyCh7uehPkHq5RMgZ11rMXchoAw/TW+Co9SEX
 b+R3zcmlbgWU4B2N5iLP6/Cg/hh5yC3UqYibKbioP6OCRKoz/amf9SQT+
 4brW6xsriZvc5+zwFiPXX38A24uGgRobhUgRLjBwgXMSGXo5z3lR/6VZ7
 ckI8DPKznVBQPXxZ9y5JWI9sjJsfWX3XIl1osP1CWXhUTvGXXldKxVchq
 1ENFcaTYs2T1ILTTM8owcJTalxT0WD2OysXOB1JhAWKSBpE0+seoEDNLM g==;
X-CSE-ConnectionGUID: 7ZdqDHLmSsus/CQsoQG4Pg==
X-CSE-MsgGUID: Cyn3uzKlSp+SGexp1uZwkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="65400273"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="65400273"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2025 08:28:42 -0700
X-CSE-ConnectionGUID: FHSvcX1kSZmy+cUpf/Yplg==
X-CSE-MsgGUID: 9Ah6zNPpTr+WwU9Ysj7+zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="161361662"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2025 08:28:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 08:28:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 08:28:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 08:28:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pru8KK0t8mudX0YfRPB6xSpOlVRJQENbN+WsU+sJI/ApV1g5DBxkc1u+I8Climvc+5egtuWz/vJrSKM/pRimNYcGDDCbbPGKDxDWleJLhDoEAIYrVzKNGsRQzOffxe0yPTxRi6YmLHjYm4M8VqRoN+ehN17WkTZblXXY3BPqSBMMV6b3YaXDHoRzg7QDiZf+TiKDgJCWKd6h46NPTqNygla1XgbQ/9Sr5yzqBIeOgE1vcHaHruxsM5P2pscmR89GxXneOjhVow19XNcHw6u6PHvco89d257wC9oznnVTWukzrrrS/ddx4OUGJBdHajQPSNgsA5lQfDEIujxgo7qEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5EnmAEVtGWOFmP/Xt6kwnk8SodaxpYWvL2KKjoyeZY=;
 b=Wt5VRCSxpLbFQMOlGn3Um51sk2owByGFNOmJpGkUf81t2uwccXhd9YfpxQOnTDPevIVNKPQxiMys84i4TXT5YIDhUz9cdCzuo080pGk4UnWi3ut3g4ija+fSrROrKSTbZTMEXuAVceyanXmplTr1JcuJfwsyT0shPvy61iMoOxAIeYsdeRWXCdctx+My9J0UYRAx9BXbHNGNdCFODDYetVErMTSEWrQPMtAZy6z/qTj5+8q2EU7ScsHFTdV0Y6Mf8dF3Sn6vok/tAWBIRoSd9X9WKto2BpFtB4Hij3FrZ/9rQmyKmAiX0IcHRiX/WXnba1MU9zzdRWR4scnXcK2WYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL3PR11MB6410.namprd11.prod.outlook.com (2603:10b6:208:3b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 9 Jul
 2025 15:28:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 15:28:31 +0000
Date: Wed, 9 Jul 2025 16:28:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: Intel i40e rx burst API non-conformance?
Message-ID: <aG6Kmun_ibhZsL3K@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FDAB@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FDAB@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2P251CA0010.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL3PR11MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: f62438ee-da23-4a56-a1a8-08ddbefd426a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?GD30+cmr5x2H/34f703Pvlgz1VRS0y0QWTEEFlVnE+q26XlL0kgUK3qslu?=
 =?iso-8859-1?Q?S+IFaNiSxiDbxPH8OKBTk61XoiBp2XQeZP7+rf+Qnft0qyZ0eNlGGYmNVm?=
 =?iso-8859-1?Q?EuYXz/0abO0ELsYw6LD3hLe6H/NLtqORqcDK4asSR8RF8EcSMu8Yd8aaQE?=
 =?iso-8859-1?Q?GIeuwI1r0PTTDLu6USjjpSfDlyKUvlF/WRzQ2l5qo0LUM5dipaFGrnqu+/?=
 =?iso-8859-1?Q?ylptv5DKKjoqTIyPmeMIryBp6ZgYxexjsNjMfY9stc5qG+C0exuGT8ZHZx?=
 =?iso-8859-1?Q?PwY+Gt1Bz6Z9O65OuRhqrJwNzFTlT8DcO5+Eo25YxPuSONIj5u3U3SqI8W?=
 =?iso-8859-1?Q?HK8bf303BBSUZDhLdLq334OapnGhdzH0r2y9d82LO0Qel9VrF/nSPnITBT?=
 =?iso-8859-1?Q?mRbjU3mVu3lfzHkQPol0HQE0fn6jt9KLuzq0xrXbN3PsLo+cZa1vk4ZClS?=
 =?iso-8859-1?Q?xRpJ7CTci/qd8aWbFkWE25x1MQ42LDw9J3jTNqkgAlO9oOFmhkv/++DxQW?=
 =?iso-8859-1?Q?+cWc9rC2Q9e8DkrY9PrYcZEM1JToQCLrvOz0LZQfHR1JErtnVBsLwSoW38?=
 =?iso-8859-1?Q?rT5b7KGlKLNv/UNHmYuVBTSWU6cKJTdyqO71VVG9YPo2XH6qOAN9PxmtfY?=
 =?iso-8859-1?Q?4Y30osFCWPwOIjqwnxP/bGcrXWPyE3Nsa/L4RGNie5WYydWCmlZ4Goh84r?=
 =?iso-8859-1?Q?xadsI6cwPUZXvOMGV1A4NXinxvSNg7a73fvIJOmuEcpSI6/1jQIaV5VMGJ?=
 =?iso-8859-1?Q?8Qkmm6zwimIASVTHB8DgXGTl0iA6fLsstElhL6WxDNtHDCmIo24C0UDGqU?=
 =?iso-8859-1?Q?eBg1CUpfQtvgt+UASvBf/mnyMcchnGSlPjbbNg72/zAKcvc2qUUf5nv6Wb?=
 =?iso-8859-1?Q?q5bCY8BoNXn8BKpecSV+cqvo0V0STRZCwG2X1bgYYL9FnWRVoV1sgdbL2m?=
 =?iso-8859-1?Q?FU7mIB1HetTz0KNq2P37Q18UYSfNxs8+Om2EFJxeVSyKALkTAcr/yw2DRG?=
 =?iso-8859-1?Q?/ni5ATyyJtsrLLgCNeL6u3qdGk2l5KPcoAC9tv2pAJ5wvoQNulH0r3aT39?=
 =?iso-8859-1?Q?8nimSU059ovyQxj/yVHaotwqymgpOYrJ7PqV7XCeDK3SpKknv800Q0dIl8?=
 =?iso-8859-1?Q?Bm2bAI+lC6c5chWEDKT0qk9n7vDVe1kD2GGVg99JqYQvqhZf9ZC7YpLLmI?=
 =?iso-8859-1?Q?MeyxMkcLMXFtDQ86UDlg3w/io9UmFBHkhQJDrF4mItR6jO0ZnqXiyQsZyB?=
 =?iso-8859-1?Q?EUfuVQAJH1Q5S1iWWBVHE5yTFZoKpAZywBU3dnUUWlg+efpGOna7qjldYR?=
 =?iso-8859-1?Q?ZkgIHBZVxohQhXiQP1Jj7vJmVXHRXenVgm7hsgByeMYs9Drq4T2wNQyXCY?=
 =?iso-8859-1?Q?Q0EGVFbg1dqiRWJJ399geB5USqysRXhnc+lqKaR4I/R4SXO2x6Hs8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?cRq61dhz6zMQZFR0GEh0VXxL9UNytXy5vKVbbmNFT2xAa164T5Mg3xWRM0?=
 =?iso-8859-1?Q?akE43Y3d9wQMXj92yKdTEMSsrHsrcUq4M56SviNeI7GAg+8ZoGWbmR4b+y?=
 =?iso-8859-1?Q?LCmoBynzFFdR4ady2j7J80hsVf26RxtPE0kcI09mNyDNlM6eztnqFR8pNC?=
 =?iso-8859-1?Q?2KbRaDpadmCyWUBQGjkx8sGXxOUPWQv9QfLA4Wbb62eZrBDFpTubLFaYnr?=
 =?iso-8859-1?Q?tqLSmvZEGy9BKq7yHuj5pKKz0tiuVrXL+SXiVIo4g6DfJYdhEtr/hrIhqx?=
 =?iso-8859-1?Q?As8wauzr/ymFX89IwLtw2I+Np6kBHMNISI57wOZf7SNfNJpmObZu1A6/ZA?=
 =?iso-8859-1?Q?ACEDoLrrapJ0jyHaZxAULH0gAxvGBJ2wOFYm2zXpDnT82WEF3K6wCBp0Cd?=
 =?iso-8859-1?Q?9NhfEoJl+7Vtpe3cRQHX5VTzRsIIT1CkAxOyVXERPFG1TFssb1rn4z+3d9?=
 =?iso-8859-1?Q?MlAjwlQhQL/kqwgq/PiIDhWAGHOW3WuPowVOxnh5NmCVEU3RY2eq4enL91?=
 =?iso-8859-1?Q?mboq+LSu2WeIBJ40URnYGJIKAAZvV8KJJ9POM2W97seAXqKAzlTA+ItzO4?=
 =?iso-8859-1?Q?LmnUBZ65GiDU/vC4t8qGhuwygHkFoD3FWXoGFv/6ynoruAyQYXZQyo6Qyk?=
 =?iso-8859-1?Q?9c2WOa6EXa9nexsGf0D1BtNWWshrKXaAc9K267KwPTA0geL6Jbpjx5tfhD?=
 =?iso-8859-1?Q?YWhEOctErqlExDbhbVd5AZ1EefIYFQFNONPDdqEqhtSuur8z/cdZzmCoLR?=
 =?iso-8859-1?Q?6OhWtwnYC3r9CXndKwj4JUmYC530jneUf+YiY5cBxdIMiFIfAkmbglOBb9?=
 =?iso-8859-1?Q?QZgLV4Ucwzs/p+FTWHsFNpLC5qPiqY2pma3OoJ1cGAHnuoBRAbYcHAnbTM?=
 =?iso-8859-1?Q?eg1VTnG/4mBAM/k4A9+pe6ObWg52+UJ2JU9KeDblWymdbSVu3J8FZaJPWM?=
 =?iso-8859-1?Q?1guf5WFJEgCG4oM9gaLx4kV/utZBF3P/Yd4HKJo8T7iYXLcaSKZ3tZAB83?=
 =?iso-8859-1?Q?Lf3Vnmze4BwE7d1E74/ydIvQaeEQpcQUGmwT0+iHvHjBcQtXCXbJmka0H+?=
 =?iso-8859-1?Q?sVJH/ZiAek8OxM7gHWpoZr1FK0W6eKFABdRMCCqD7qrfaVKZedKSzlEVUB?=
 =?iso-8859-1?Q?WNU89Qv3+FCoZt20lZntzVKbeM+HjslTVOreFQUAoEuCbjd4pf90KMVzJo?=
 =?iso-8859-1?Q?UFTQNsRnnS5HbvfU8geBCgU+vkgNN1rC0vb//2gXSWT+gQsCZKio8xegdM?=
 =?iso-8859-1?Q?lVV3a7Sfipqn29+OytJ2oAD1pOniWGnhjhXrJ9oTi/hnOI6y164TbsjUl9?=
 =?iso-8859-1?Q?0CWjmNGDqddgYXKygiDnK8/TqxOFNqirww8bXKlmw6eilTiBBs7EvTNWPr?=
 =?iso-8859-1?Q?sC8bkJEwqI64A0fJZbklINW8QFp6WFklVVaUZHX0X3+IPn+2xdvwT0pOIK?=
 =?iso-8859-1?Q?0e0Nf0Wbi63iz8U0hzSArW3Bu08zxZoU0q1psCxfD5LaJPmEcQEl71p069?=
 =?iso-8859-1?Q?XmL4k/AEadVstUR/1ZJN3UF8TRfwiXebFKglySra5s7iMpay6Pwlx4kRZl?=
 =?iso-8859-1?Q?p9/+26ICr3cQHY9nS8vuvNWYE5ewjI2FIo+V9MWhTTILmBmqtmL0G8s1fE?=
 =?iso-8859-1?Q?uVwAS6HalN8a9VYhi01xgECqcHc6ozH3lZw2QnBPg/O1MmfTWO1m0z0g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f62438ee-da23-4a56-a1a8-08ddbefd426a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 15:28:30.9628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Xv9spUR6YniaM9/5ZMI0MeH9lMXhOIg56EE10EVgO9kdrs5zeY7MZd+CsAgYvD6SGxeEmP7sF9Fb/e33q184fqhMaeM7po9fvf50q/8BzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6410
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

On Wed, Jul 09, 2025 at 04:59:51PM +0200, Morten Brørup wrote:
> Looking at the i40e driver source code, I think it doesn't conform to the API when requesting small bursts.
> 
> Let's say the hardware has received 31 packets.
> rte_eth_rx_burst(...,16) will return 16 packets and leave 15 in the driver's staging buffer (which has capacity for 32 packets).
> 
> Time passes, and more packets are received.
> 
> Now, rte_eth_rx_burst(...,16) will only return the 15 packets from the staging buffer, and not proceed to check for more [1].
> It thereby (according to my interpretation of the API description) informs the application that no more packets are ready to be received, which is incorrect.
> 

Again, the spec is not entirely clear. I would partially agree with you and
partially disagree, but overall, it's probably not the best behaviour here.

Rather than informing the app that there are no more packets, I would say
instead that it incorrectly informs the app that the descriptor ring is not
potentially overloaded. The reason for the difference is that, even in the
case of a driver correctly returning any number of packets, by the time the
function returns there could always be more in the ring. Where the real
risk, IMHO, is that you could miss out on a ring filling up without being
aware of it, because a full burst is a warning sign of overload.

/Bruce

> [1]: https://elixir.bootlin.com/dpdk/v25.07-rc2/source/drivers/net/intel/i40e/i40e_rxtx.c#L640
> 
> PS: I stumbled across this while reviewing how the very old 32 packet limit bugs (where it truncated large rx/tx requests to 32 packets) had been fixed.
> 
