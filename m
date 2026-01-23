Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846DBD72379
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 12:09:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE7A04026F;
	Fri, 23 Jan 2026 13:09:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 0F52A40269
 for <dev@dpdk.org>; Fri, 23 Jan 2026 13:09:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769170160; x=1800706160;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=f/XDDi9SV6uuMk2S5hbEscgsmO/7DsISc3J5yCmINuw=;
 b=CXnmh4LZbVJ5LHF9SD083PxwkxI8YOq+7bP/NrJgKEVoQXbXVBvQ+CEI
 st20aBMgx48XOeqObfg9sAVCyyKoUFwx2KSEmU4tBPrUMBEhIlAyhCMfJ
 UxDswLOXE9XetcxDtDHRxKmcU0XO49pLY6sSfqf3Mu6Rad5ON0XA+drob
 olCtEiNMAyFsXxjlJZcFNmvqcR/e15y5c1kyunmlkNDBt6tgQNkFidjjb
 JcKy2ElJedeJbIIVOfXLmUIXbgTWgZJ3ZxazGfWdQVXNk4uK/LpsUqUrR
 Zst1PsU3vj6UxZyzAUTGLGkKp3vXPHZcl1eT3kP9tVfx6g6VX22Vsrljg Q==;
X-CSE-ConnectionGUID: Gs8a6nDYSPGWvMKw4Kmi1A==
X-CSE-MsgGUID: TKY+lskHSiKphAwHYwKNYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70398133"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="70398133"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 04:09:19 -0800
X-CSE-ConnectionGUID: DVahvWB9QCSj8Or1IUOymg==
X-CSE-MsgGUID: NsshiFQkQnaY4pVIoYXAYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="244621552"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 04:09:19 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 04:09:18 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 23 Jan 2026 04:09:18 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.39) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 04:09:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwbfTAV0evRtSuCgF91wtr5kBFboA215ANkFKBv1+KHKk5eX8Vs1aBKwg8iL8i7dlx63SaBrKMqZmL/gtl5pmy4Er11pXsIRdDYlucCAJyAxqeujGUATnNwxYXu4UiGBNjGuLBT0uxm84eaGg/eRPYLC6mve24ZlxtweDclCN/5H5UG8RVU32yLX+KRZ/Y2425O5oWaUB/s4Q+CC2NwR+HKIqPPoodPu6yRv5XyIvGkQyQEqd8Q8HG+JCg8SIRjF5xIrVA9W7lKp3TxuQxKT3KmyBVpj8E9TL8ThJU8xuoW+yVP4qITAovWQ17n3W5UdWrwODOjukIFr6EW+V7IIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLImHleIT/byk8wlBmiCulgKOXfAe+EK97PseFS6dhc=;
 b=PfnPkfjJcUqLYgXno4CDxHuGceZI9oNSAB81htROtrXZzgWzZkw5JZMKuQAmLNC5A7TPva+jbmolC+zCXspseSQgxgvPUfa0obFEzPqSTayrxyOWaRdnQPNyahBZYM3tlQKC0EO8xB2Hlj0aW9VUJeLXzBdVjY8Ck1/NHiTlkpkQmuvdT7atSxOzJThrk39gS9LbJCRdlUc2q8HW+QxcKQCSXLZCAnziSy3Jviyoo07ZCAfExo0FQpe8H32jxpb5GT572tTdyyaHzhirD2RQJZ9UQD0zJ/rjomBD1tnUWaminmSQh5yZ+EleFMx/iK0Hr5NbmxGB7lacpwiTB9OTpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPF1EED2E381.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::817) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 12:09:16 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 12:09:16 +0000
Date: Fri, 23 Jan 2026 12:09:12 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/intel: optimize for fast-free hint
Message-ID: <aXNk6DRHvzH1WuK7@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F6565B@smartserver.smartshare.dk>
 <20260123112032.2174361-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65694@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65694@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZPR01CA0055.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPF1EED2E381:EE_
X-MS-Office365-Filtering-Correlation-Id: d681dc45-d7cd-4b79-7590-08de5a783aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?67FBozC4KhZ5Hz6PkFe00csVco+eyvzgpx6SKe3glrQtWRiL/ZKQC+YYuU?=
 =?iso-8859-1?Q?+MBXEOsRyRqi2LbKRUdtUIpoWEIrZXyJPegmws5Aw0fxurcW+Z62NjrzhK?=
 =?iso-8859-1?Q?rs+LHtC0mrCerMpND6fTSxAfUpTyxY45QoWSShzayprY+grzPTCPcy5FTu?=
 =?iso-8859-1?Q?jey9b7R154awthtOSpk/PVQBF/9imjEneJbjjOVUUtDaG3qU/uaE7Wq9ua?=
 =?iso-8859-1?Q?4RWNT/8Kn/cbegagjWjsPU57G+Ny611u5wUWpeyEaBF1a3suTG9O9bS2JF?=
 =?iso-8859-1?Q?v7PDCcpOEnefcEZ4MkZ6D5CEXspZUbSf38uFFhzv7+PeaMtI4tOYZEtZRS?=
 =?iso-8859-1?Q?w5okHGppOKVH44vD5nmllQxsGERW7uvrqaYHS0KxUDZIC+dY80k+fpqiBg?=
 =?iso-8859-1?Q?KhZ94T0KFu+3Md1uxg4czNlv7R3B9skdNTFZqTjipc1KSDZB2SRuGQ0iQj?=
 =?iso-8859-1?Q?Q6xNlkLMuITsrK8ZNAgpocIC7irwtbNu3Erdklt3fSLv2RStCcUViaMrEq?=
 =?iso-8859-1?Q?0g5rc1QK6YNJT3bBUqKezoNJmaIViUh16C7Q3fvlH6C4UdGJgSlYBXhphh?=
 =?iso-8859-1?Q?jK2om+y1t3C9+6c1fRo6ZXu18TNSjcSzYIO0R9DJtFkA9pDrrMzLipm6ub?=
 =?iso-8859-1?Q?Lc9uoCBUta63B6+tniuj4CBwOyN+/7uY3f/dv8E5ajgGfJ/OapQbcufqwV?=
 =?iso-8859-1?Q?HoYZGAPkVlwXqRtBqUHGjucntjLP6zs4rFikg2659oyCnVAOcyvcuNTQc1?=
 =?iso-8859-1?Q?T/qK/GnrwlMhAVUcDkUcXRkndZmHK4TL0f5iZ9GP10OSV3AUdxuITbsZmf?=
 =?iso-8859-1?Q?Q0loxKrb3NcAYz5al18c1is7LxODxaFUcxdwNl5MRpni2H5v0k6pHHSxbE?=
 =?iso-8859-1?Q?+IqfQlo8wAThARSmJphZnq5eecXLGr12THvmIhK7//OCnTHTU0yOG2YZN3?=
 =?iso-8859-1?Q?2GOvkzCfkxHTQglnC66j5R1m00Np7n97FZsgtGQHUHQRIHMOuEo/fTAOHD?=
 =?iso-8859-1?Q?2YVdJYYhwGGw5WA/Y+mh6fE/1jLRMqBPfU5g03rXf17T2oXtyussqqUC7q?=
 =?iso-8859-1?Q?vZyp5IRfAeWRXhTSLi6pmOgJkV+tdzuEF6diwFqDKWeZF/M0Mjk0Q8gL61?=
 =?iso-8859-1?Q?57ir5bbQRYMZIcFVfg9AGQBrzliPz2GBTwiPvlKlfiJKoJHu4lBcH63t1B?=
 =?iso-8859-1?Q?jkH+O/ZmfQ2buzGvmts8CPYypj9SA6xgruLy4PSMoX3tKuO3LZcNrXane4?=
 =?iso-8859-1?Q?SAVzjLJJ0jiOLl5VQU7F0euwumAyzFAX9rcNDZOBxhdE7JZwNneXaC43Sx?=
 =?iso-8859-1?Q?R9kyqelg4tc2ryv4Vu+zYCYdgVIu7JD+Tf4QiPyg+DHYRgm3aQx0QCyqyO?=
 =?iso-8859-1?Q?aUGJSTUd4bovMUyhvFCTf6VQX15s083qoafl9B4pq5suCP++BoqNnbWx5F?=
 =?iso-8859-1?Q?oQdxzuawYS4K8aIH6LZPMFY3BR2Pb+GXtUhEnWn3T15XvEIn4o83Ua4eVw?=
 =?iso-8859-1?Q?GvFLFcSRQj7u7KUjcFkbHGSB2LxlmYFidwcJSM06w7HMe2nk4Ii3ZLsVaw?=
 =?iso-8859-1?Q?syypWxHx8k/KndmjN36qmlOtxzihXPzZVVuv/ENk1Lgh5Mn3eGkYCvzgHx?=
 =?iso-8859-1?Q?gmPCS2rr8T+lA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wKcAacMW584+rV7YWnVF1U5Vj3Pg0WL7kViUi6RnJlGcfWBX1OYkLpKRYH?=
 =?iso-8859-1?Q?wzopGsP/XDOLN6MMjp8GTDwL+H57qDSXzL02zszQpQXyrhGXDEl4dP7fE0?=
 =?iso-8859-1?Q?24zmyP2M04WJMibZlr8KnFGHJ5cxRUCM8AicaI/l+d2gW/JVNDKyKCLv1u?=
 =?iso-8859-1?Q?954KxnYOz/Olk1Pm+7n7cxaIbqoryUnrgc8EvAsy/BEFampy65Gu6QXJ7F?=
 =?iso-8859-1?Q?MondmfW7TzK4Vu1d1bSKJqoo0NMqlz01W73RSUHIBbO6+p1qpxqOoMb2/Z?=
 =?iso-8859-1?Q?izKXpTN6PGvheDNO/1PZNktowTpk+6x5g+2Ki14qtdvdMz302OuM7EJ2oL?=
 =?iso-8859-1?Q?2NOD2ZwcWPFIBW3CKMlLfJ/aVMdsKf7B2TXkKJIgdRNbabC5FYDrds2Sxb?=
 =?iso-8859-1?Q?eP7HghM+y4FkQPY8/Kc96QLNBrBXFeW2lXL0lMrqYNtMOL6/MELa6a/LUd?=
 =?iso-8859-1?Q?qAZvxMHMMcBj/iejBDZrrqwYWfXjFGL0o7+Yep89wASU3R+iKW2Wxft+Uo?=
 =?iso-8859-1?Q?xFsiXdnE92NW06srrWcb/q/zxsX+eEJ/+pGDxKD8dV8DHepW8aVA9UMLQJ?=
 =?iso-8859-1?Q?8f9XEUq52UvoF93cBK4t/W+Q9ct8Kr1jf8J/R0NHZoQBev+Zm7L9hPEHyl?=
 =?iso-8859-1?Q?q2q5yE4lYDK2NT+dpSE9Ch9u8SqGkR1emmHQBjexcp2+7oT2Eh3T4IDAyR?=
 =?iso-8859-1?Q?w6O24PMsbcECLyPJ0bkwAufflp0uooo5RkTZiETz2ZRBVlexKcQccA5ZCW?=
 =?iso-8859-1?Q?avac08VAHxrDvz1GFCz4e4ShPm0nRfa5J4Xdr9ibIrEw1cKZSXB0DGYoF9?=
 =?iso-8859-1?Q?guLVrj2FXp44vXMPBho5VpWOPjCu+2Fyoes1pz253O+RUNNO/klMYUVRjF?=
 =?iso-8859-1?Q?Do5dkjDYsW5lP+knrE4amBTm8UR4zpzlUfGmLSVsJdqBJ5ay8iWAovbJeo?=
 =?iso-8859-1?Q?QgH7TGCApZ1jWKSwmlBM9j4QTJga0v4MeGSLxCDb7jEE/GqlxPvyXjEulm?=
 =?iso-8859-1?Q?buk7pUs1ij2wZTezJoErvovfw0gEgfq3FWWD2UXQeUfVM5aewmvqcvBBYG?=
 =?iso-8859-1?Q?n5YURaA8Pyq1O4jPA8zZe6cKLEr3cBxPsrzC7Joh8UlNg2nqkuHZyHXta2?=
 =?iso-8859-1?Q?BYuf+gafFYceiGUVpDuHAkHUDiO0Eh8W9e4oxJ/gyAlTj444sV0Mt3kbrT?=
 =?iso-8859-1?Q?6lUzvDMu7mgFQ41cGGkGUdx7lOsbHZ3rflXPoC0sukVdf7zJ17CWMB2U36?=
 =?iso-8859-1?Q?DI6uDaplH4Sbt6CvpSjV/G8oqwASmul5L+Wrp36ESoKw/8vwF8OgVUI8ZH?=
 =?iso-8859-1?Q?9VpwYYpt/QXj4pjMhCZU30TYLHz+A1hVR6qfsyWofo9KksXpISvb4E0ljJ?=
 =?iso-8859-1?Q?+Sw3GtGQYpWtDQqJpAFhjQKfTQIm9qEDWAiur1C5Y1pwWRoyOQ3wp+A0yZ?=
 =?iso-8859-1?Q?gCfqnr4TzpOjJj2PBKk8ydKyuZvYYjiBEQVjfu+Bmg8P753BlTcBIVAKKR?=
 =?iso-8859-1?Q?uzucOXPGtpRRlaZtNwa4NV+ezlhZNOtgHe6HAILRifQ2miC0wb9gKBqU/V?=
 =?iso-8859-1?Q?9+rjxDxMS0Aw2f0LHUVX9p9dLTgzVjLyY4I7E1hBGPYg16S8rYqpPS+jR4?=
 =?iso-8859-1?Q?la0+dFY6ooLcd+GRD/Mm0J9YvhPpxhG8AfF/21JWRAhhqzJKvFCzu8k3LU?=
 =?iso-8859-1?Q?I3gspJx2X4ozHuVbHvaNeI/SuqZ+J4VaMRoEmsQShMhOW7tZfMxrabQTIX?=
 =?iso-8859-1?Q?fEhk5/K5bDgWVz1eVyrkLdHbnGYj8GRujxA3xkeLDAktAvQffgd/Ig78H+?=
 =?iso-8859-1?Q?DCw7RweQNMOybSdMw6F4KX/5bkHQa3s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d681dc45-d7cd-4b79-7590-08de5a783aff
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 12:09:16.7216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+uCWF3mWwF5ftcGJ0Pvzjp2niZsGUaxEoVGg2Z/I2LD6lFn4v/2192Bow0hR9ffvTyFvSXOPXWnyNnLybT17ZkWOrBrGkEgotEE9DaXmVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1EED2E381
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

On Fri, Jan 23, 2026 at 01:05:10PM +0100, Morten Brørup wrote:
> I haven't looked into the details yet, but have a quick question inline below.
> 
> > @@ -345,12 +345,20 @@ ci_txq_release_all_mbufs(struct ci_tx_queue *txq,
> > bool use_ctx)
> >  		return;
> > 
> >  	if (!txq->vector_tx) {
> > -		for (uint16_t i = 0; i < txq->nb_tx_desc; i++) {
> > -			if (txq->sw_ring[i].mbuf != NULL) {
> 
> You changed this loop to only operate on not-yet-cleaned descriptors.
> 
> Here comes the first part of my question:
> You removed the NULL check for txq->sw_ring[i].mbuf, thereby assuming that it is never NULL for not-yet-cleaned descriptors.
> 

Good point, I was quite focused on making this block and the vector block
the same, I forgot that we can have NULL pointers for context descriptors.
That was a silly mistake (and AI never caught it for me either.)

> > +		/* Free mbufs from (last_desc_cleaned + 1) to (tx_tail -
> > 1). */
> > +		const uint16_t start = (txq->last_desc_cleaned + 1) % txq-
> > >nb_tx_desc;
> > +		const uint16_t nb_desc = txq->nb_tx_desc;
> > +		const uint16_t end = txq->tx_tail;
> > +
> > +		uint16_t i = start;
> > +		if (end < i) {
> > +			for (; i < nb_desc; i++)
> >  				rte_pktmbuf_free_seg(txq->sw_ring[i].mbuf);
> > -				txq->sw_ring[i].mbuf = NULL;
> > -			}
> > +			i = 0;
> >  		}
> > +		for (; i < end; i++)
> > +			rte_pktmbuf_free_seg(txq->sw_ring[i].mbuf);
> > +		memset(txq->sw_ring, 0, sizeof(txq->sw_ring[0]) * nb_desc);
> >  		return;
> >  	}
> > 
> > diff --git a/drivers/net/intel/common/tx_scalar_fns.h
> > b/drivers/net/intel/common/tx_scalar_fns.h
> > index 82dc54438f..47ddcf411b 100644
> > --- a/drivers/net/intel/common/tx_scalar_fns.h
> > +++ b/drivers/net/intel/common/tx_scalar_fns.h
> > @@ -30,16 +30,60 @@ ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
> >  	const uint16_t rs_idx = (last_desc_cleaned == nb_tx_desc - 1) ?
> >  			0 :
> >  			(last_desc_cleaned + 1) >> txq->log2_rs_thresh;
> > -	uint16_t desc_to_clean_to = (rs_idx << txq->log2_rs_thresh) +
> > (txq->tx_rs_thresh - 1);
> > +	const uint16_t dd_idx = txq->rs_last_id[rs_idx];
> > +	const uint16_t first_to_clean = rs_idx << txq->log2_rs_thresh;
> > 
> >  	/* Check if descriptor is done - all drivers use 0xF as done
> > value in bits 3:0 */
> > -	if ((txd[txq->rs_last_id[rs_idx]].cmd_type_offset_bsz &
> > rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
> > +	if ((txd[dd_idx].cmd_type_offset_bsz &
> > rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
> >  			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
> >  		/* Descriptor not yet processed by hardware */
> >  		return -1;
> > 
> > +	/* DD bit is set, descriptors are done. Now free the mbufs. */
> > +	/* Note: nb_tx_desc is guaranteed to be a multiple of
> > tx_rs_thresh,
> > +	 * validated during queue setup. This means cleanup never wraps
> > around
> > +	 * the ring within a single burst (e.g., ring=256, rs_thresh=32
> > gives
> > +	 * bursts of 0-31, 32-63, ..., 224-255).
> > +	 */
> > +	const uint16_t nb_to_clean = txq->tx_rs_thresh;
> > +	struct ci_tx_entry *sw_ring = txq->sw_ring;
> > +
> > +	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
> > +		/* FAST_FREE path: mbufs are already reset, just return to
> > pool */
> > +		uint16_t nb_free = 0;
> > +
> > +		/* Get cached mempool pointer, or cache it on first use */
> > +		struct rte_mempool *mp =
> > +			likely(txq->fast_free_mp != (void *)UINTPTR_MAX) ?
> > +			txq->fast_free_mp :
> > +			(txq->fast_free_mp = sw_ring[dd_idx].mbuf->pool);
> > +
> > +		/* Pack non-NULL mbufs in-place at start of sw_ring range.
> 
> Here is the second part of my question:
> How can they (sw_ring[X].mbuf) be NULL here, when they cannot be NULL in ci_txq_release_all_mbufs()?

Because the latter function is wrong! :-)
> 
> > +		 * No modulo needed in loop since we're guaranteed not to
> > wrap.
> > +		 */
> > +		for (uint16_t i = 0; i < nb_to_clean; i++) {
> > +			struct rte_mbuf *m = sw_ring[first_to_clean +
> > i].mbuf;
> > +			if (m != NULL) {
> > +				/* Pack into sw_ring at packed position */
> > +				sw_ring[first_to_clean + nb_free].mbuf = m;
> > +				nb_free++;
> > +			}
> > +		}
> > +
> > +		/* Bulk return to mempool using packed sw_ring entries
> > directly */
> > +		if (nb_free > 0)
> > +			rte_mempool_put_bulk(mp, (void
> > **)&sw_ring[first_to_clean].mbuf, nb_free);
> > +	} else {
> > +		/* Non-FAST_FREE path: use prefree_seg for refcount checks
> > */
> > +		for (uint16_t i = 0; i < nb_to_clean; i++) {
> > +			struct rte_mbuf *m = sw_ring[first_to_clean +
> > i].mbuf;
> > +			if (m != NULL)
> > +				rte_pktmbuf_free_seg(m);
> > +		}
> > +	}
> > +
> >  	/* Update the txq to reflect the last descriptor that was cleaned
> > */
> > -	txq->last_desc_cleaned = desc_to_clean_to;
> > +	txq->last_desc_cleaned = first_to_clean + txq->tx_rs_thresh - 1;
> >  	txq->nb_tx_free += txq->tx_rs_thresh;
> > 
> >  	return 0;
