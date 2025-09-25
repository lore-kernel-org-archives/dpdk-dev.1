Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79E4CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 08:42:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9284402AB;
	Thu, 25 Sep 2025 10:42:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 18C794028F
 for <dev@dpdk.org>; Thu, 25 Sep 2025 10:42:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758789741; x=1790325741;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=77tHEWhxQuinCNQEgh+pJ+qkat2XO8Zyi1UTIadFU0I=;
 b=JnOEUbunwuF3eKu8fzM4oK4uP8gv+84wCmC1XepT43V2JE7iUBFo+Kec
 pGBfk81YNDIhJEAnT/og1BNa+By51js4//92eWlfcai0GWSmE7rDmptbH
 oPCDoIn3UnXwH3TkWRBJCEUxUkZGSjeabFtIvP7G/aghuj0Xi3vw7BWsK
 uPofLY/boSg67JwmFrmppzssJdYnxEB0MG76hQw4x6M+7AFrvRitqhEpS
 Nf8/1qupgXCeSS46NFVU/iblliie2SeufOOUqru4Z8i5PUwFE8XCrcmwc
 zO/1j4YBVYMwwiGeJyNYpa6/lyluyXDhIaphmacB35LMb4UcYNwUZR7G+ A==;
X-CSE-ConnectionGUID: 76fIRjVrTtSdro+fR0Thug==
X-CSE-MsgGUID: OO1gCRTOTj24F5CBXAYjNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="71720568"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="71720568"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 01:42:20 -0700
X-CSE-ConnectionGUID: kyVrkYByQk6XZbKvFet/1A==
X-CSE-MsgGUID: z0gBZPUcRP2gX9/jX0Cz0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="200966200"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 01:42:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 01:42:19 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 01:42:19 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 01:42:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNfoOO1me1y9MAetioznrZJAwrstEW0GRpHkr3k2vPZssmESYrzGqU+tF3TiA8kpYR7gUqLbDtLtn9uIOZmVME+JFwMt2pyf6XR2BsRikKyBjFk4QsPXHG+IYVxA1KeQQUagzrlZ/7kgr5UrymH6/FapCRKC4Ce4iu6E2hbgseIRFEwrgExhd1kRTEZfdOxa0eRm0ZNghU6jofddbexAxkO9xfKJMbz6njbuVRqdBacefh2o4FUIN30MyzURktCpFf0g/CbqyvCHJrHD9cNrb+Z8va2qP/3blHAIlzPBywRkxqD5jDaOY4HqDy5jNcyiVTERl44XPgIYKKlHHTGOEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1GNr3+s38RwZWoClmFgeZ45rzjMIGrVlr6HkbWoySg=;
 b=o/WgEtUeCw2M9bYt/EKd91+qhyPlZASwF2I9nwVHlm6CixuJ9NHnT+p9X3rFz57l25YrN5p1uQ7bVtwiEkNQ8iZstalOtGwxByQ9g6/Xps3vblbSQRwOaXpef2gLKFG0qYA7P/Ph+jUqGak+nrIq6HO0kSCvCFEny+NmBZ7OTyB3yNXrk7Jj0C84ycN259rPQOZsoVu+YGmEWywzTQoFqdHaGBvS2mIDWCc7XBdp2nL61EAlX6b0MW1SAjZ5fyCmQ0eyUPX9V4YbhJj3KKXQ06Wa6zsIXPvZ9RZ+LJB87cq3ROPW8RFLF3OY9lyj06iTzUfFhqufFXtPnSWEnejR2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPF37F43E35D.namprd11.prod.outlook.com (2603:10b6:518:1::d16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Thu, 25 Sep
 2025 08:42:12 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 08:42:12 +0000
Date: Thu, 25 Sep 2025 09:42:07 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v3] build: remove deprecated kmods option
Message-ID: <aNUAX43vE-_0yW6R@bricha3-mobl1.ger.corp.intel.com>
References: <20250919075733.221023-1-bruce.richardson@intel.com>
 <20250923144000.13570-1-bruce.richardson@intel.com>
 <CAJFAV8ySAMbErqh_9_gy-6FK+OP+8D4vvsn1iYYNniYGBPZT7w@mail.gmail.com>
 <aNQTUBumq7jnWqh0@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aNQTUBumq7jnWqh0@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU6P191CA0028.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPF37F43E35D:EE_
X-MS-Office365-Filtering-Correlation-Id: 695d7f83-8676-418c-6ce7-08ddfc0f6baf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rISLNCQ3hCP9qiiD/pbAh4OoDisehwEXR+ssBoLUuQEWmI2dItjTrsE6YinQ?=
 =?us-ascii?Q?QtFA1fyY/H6SrFvq0sUjZE+o43CtKX5+4yp3/UzNMpIFo8Z5RiyocD2KuTRg?=
 =?us-ascii?Q?4gjtnOOICCN8MUCPUxWrAc8PTdAo3+eqZwOGA/BJpm0s/IZTzbQ9XJrGHuD7?=
 =?us-ascii?Q?AXVKISID3npyXQ7C1HHESm39AWWCC70SLBuGE2m6NLuJpaD5XC17Cu2WwNoD?=
 =?us-ascii?Q?h2p3Wv7uPSHGZ/IuoshMqHs9PWlQ82A4lr2H0pKSzoo8YuRbyaw7Hf8/JMex?=
 =?us-ascii?Q?MdmX2RzmuAVAKaCVTY/Q19rd2CSpXxdx5QEMSEajmFr9WBG0KK7iW1fc2WrC?=
 =?us-ascii?Q?sV3Csn5XxzpzuoDtWl4eZF/DtGW+np7yMbwreAstz/k/7Sdj8dNsBEyUreUm?=
 =?us-ascii?Q?qxSw1lAeBU4bQs5RmOaSWEYIjSlF2jkoWIgUyKni+eQLFism2k+fcOsphT1K?=
 =?us-ascii?Q?0fAvt5ZNOwgdv20V/+Sc7CU8Xcheq5Io/07K7BjWM4benTRDGRoz8JrKxeD2?=
 =?us-ascii?Q?wfMSksFW348O6mxHA8QWSfxUk60f8+n7VTrsDuAScWjGWa+i6KjBnGUutHG/?=
 =?us-ascii?Q?3W66WnxV+fd6FGbsRhho+xTIpv4oluXaieEWoqfl+hE+ECzbFmkGHczFm/2I?=
 =?us-ascii?Q?IN5pPpg1KPEWobHFGL3g/PdtBOz0VzGZbO+0c8ECGbTi/wLRiAFDLf3HzLDu?=
 =?us-ascii?Q?rhWvcYAnx6DeerZzojBoDDgfdn2yk+qCLRcL2yEPFX0iVQBVugJ7nxBuDV3e?=
 =?us-ascii?Q?iUXkQ+VRsjHDwQVhTFUxEeA5RzH2zmIfb59lH/rgtYlnRZTeXxreQ8E/CZKl?=
 =?us-ascii?Q?pFnXn9YrXEjNkkEhPv/oF25oYm0aCzgUt9+/dD/M/AOoi6tz5pktAAjHBcKo?=
 =?us-ascii?Q?rEwV2Ra3fc9Brdj2pj+51e3ehEuQT5zyaQGyJSvfMxSRB+pXnlwrFkTPMEqP?=
 =?us-ascii?Q?LidCETYNK5HrC5EHxDq3aF6GRqeADj6wqiSey/O0phZfM0NvxaCQecBLQwvx?=
 =?us-ascii?Q?3jDxWlRP5Bjk+sBCKbmj7BGU+0of9NT1pQvBxeAFopvDQt3/L0b3bPaoZzvK?=
 =?us-ascii?Q?S6k/LB1v5sDdUxIsrSgMkktNtYvdYzLiHoz659oypqaQt1bmgVhkI3hvbHM5?=
 =?us-ascii?Q?Teu9RYFRtaNcFlR3N6LUdzYn/vywJsRhEKkhvVnMuD2vjoeOynVJVb0UKM8j?=
 =?us-ascii?Q?VqpQZOxtC6OF9G72EjvSTKrfyYRvCD1a6flClv89XDkjhjUzVNHH3N6ei8dq?=
 =?us-ascii?Q?+7KvufGS5804D34ehLL/CMptx2KMJRajxh5Ty6kf+4dukRGj5xQzy65AfgJV?=
 =?us-ascii?Q?0/sbAHamN3SPP4WOC2By0v4gh4UlSJwr+AMLJr+rJyy7+ymVPYmTwbPHOzGz?=
 =?us-ascii?Q?T5palSRfmkkV7ocx+AR/SIiAHihf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p9GH/dEs8ILmWQ6xksc03l7b9eEML8K1dCIwdoITGmKBj7JM0EmsHuwl6YA2?=
 =?us-ascii?Q?+L4HHxJ9MiQB+teEYkNi55uIeCGVzZycQzRTlYsG8+2GX16DfJ87XjN5heRh?=
 =?us-ascii?Q?It86cibgRPF6MisrdLRth4jFSQjTJDK//6WnkuYqQUt2BxWCi1I1y61ptfcK?=
 =?us-ascii?Q?rZbbR6pU6Ug4kLNRpqCA1eWYTvlOpF4T7lwfpXGNIKCclsRharjViTzPLP6Z?=
 =?us-ascii?Q?CCqNq+sv8+Iu01S0EtaQnaFBFn56DErGOjzJS0beo+/9AFmQQpl5rV8DLRC0?=
 =?us-ascii?Q?S3Pl5ERWiZvLfoZcXe5Nv2K7B8ufi80vCSfFJegJNLJfUR2RIVvrvwc0P1hx?=
 =?us-ascii?Q?/e4Jf631UJQnlyjqECHynGg/0z2I0j7oJFQshTBzhA0aMNCAuGQzx5or4I5r?=
 =?us-ascii?Q?rYUM7wd4lFWh0+u46AxfXkJQVRci7S9Du1wF8Yz9sqtDlSLRwMvM2N2oL5rG?=
 =?us-ascii?Q?9ry1vBb/8DeOJr5OO101oEucHpZN1sbbFYkk64ogiy/JxkC2B6FMYWjnTR1C?=
 =?us-ascii?Q?7+j/1VW+j3a+pFIX63fwlovFo7YML2HL5AniPgZ3My6p1YPL/QYzqAr40Cq+?=
 =?us-ascii?Q?3fKcbQG/6Bd9FUhFA3XLQRAql0WLO+pzavjSn5i8X71CD9DFdb0/2yJTfk/8?=
 =?us-ascii?Q?0kGHlbRQ68e3LnbNei4t2bHp0Z4ouuZPtK6XMinmyBM0xxS3WalBfUhkKxxP?=
 =?us-ascii?Q?Q4IWYPj6joqd/vHeMdt9YMEgVnCEXFAxlCEnwZRSOMETGRtP3cF+LW2E4ShV?=
 =?us-ascii?Q?hOFZaJIOUY9kvThfDzo1+hiZfxm+exxUpuRzmO6qKJMwOB0K2UOVNuV94xnW?=
 =?us-ascii?Q?OZR7eY1K3VG+rWg3mANtJi5sPZRz/rXk12TdiQXPQvb/O8M61zvugQfm3NwF?=
 =?us-ascii?Q?tgZ9TA2+kMVPGklG5YJBQT9KFaSnbnS4Tu+g3BgNn1v5ErF+Q4P0Eonkr5tg?=
 =?us-ascii?Q?Soyf6dbWHq2pbSI0zMWReGCmT9eLgeEjSClZyRBdebna4pWctCcNJ6/TX65I?=
 =?us-ascii?Q?8Z71Rt4YhnGMnoO0sO8W8svPG3VvT0d6T8TPiRYWDfO+yABMBcRoKoPXLjXA?=
 =?us-ascii?Q?MM7WxS9kJj2ucE32kZ/xTv1RnQhkR/b9R9gyauvVVgNOd9uQt4NspxDbycW4?=
 =?us-ascii?Q?EvHrg4FrOKfnZJnoX0066l+dpwPI0cOFUpAV3K9ZL9LPfWX7LfElPYsdHjkN?=
 =?us-ascii?Q?Cvn1I80c8UQM08qpNPBoxKV+RwzUAnUVodlUS1Ij5QXtwa9aioRj8JglSnIF?=
 =?us-ascii?Q?YziMM2qstyxpa25dd5NkA5XOK1xRla7ZfPemdwgtz98LgleeODOYyTz2cxOY?=
 =?us-ascii?Q?UholyNtLtpNicM8dfUlyG8NzWFF9FS0V2O7u999t4EvazIJKtLM6PPo6o/2U?=
 =?us-ascii?Q?2tcUBQ7ur+FyRDR0cfU4lynImd+kBi3hBHc8xzy5DHj4NNDinCg/N4cezfip?=
 =?us-ascii?Q?jyce1nY7+bgOKk798ibodHUlXBDdjTR7VzUtcDkcwWjMywEWsk9ZzS59g8vQ?=
 =?us-ascii?Q?juXY2lrdr4/vLsNyx4hnA8g+gFksZwjHPNX5ndf4+k04Iakg3noDVfRBXTe+?=
 =?us-ascii?Q?r57Jb5L2aOYqCP411O8StqkJpAsldG5oFX2cQGp2jrv1x74hDXTvpwn5ZscS?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 695d7f83-8676-418c-6ce7-08ddfc0f6baf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 08:42:12.0097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVyxuLSg1RxLnC9Fe+GBYB8vW0mpYZ99Tp4SOuPFYA/e01ZqkQvYbNRU5FNdqv9Oa8DK2uKGqQjJL7LFEMvRPqNuXLMsYkek90GX95WaUW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF37F43E35D
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

On Wed, Sep 24, 2025 at 04:50:40PM +0100, Bruce Richardson wrote:
> On Wed, Sep 24, 2025 at 05:45:38PM +0200, David Marchand wrote:
> > On Tue, 23 Sept 2025 at 16:40, Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > >
> > > The "enable_kmods" meson option was deprecated back in 2023[1], so can
> > > now be removed from DPDK.
> > >
> > > [1] https://doc.dpdk.org/guides-23.11/rel_notes/deprecation.html
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > Acked-by: David Marchand <david.marchand@redhat.com>
> > 
> > I see errors coming from Intel CI that requests enable_kmod option.
> > It needs to be fixed on Intel side so we can merge this series.
> > 
> Yes. I've sent off a couple of hours ago a request to have that fixed in
> our CI. I'll let you know when I hear back.
> 
> /Bruce

This has now been done, I'm told.

https://mails.dpdk.org/archives/test-report/2025-September/911620.html

/Bruce
