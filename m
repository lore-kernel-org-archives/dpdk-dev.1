Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449CFC5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 11:12:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88C8B402D4;
	Tue, 10 Jun 2025 13:12:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9A5C04026D;
 Tue, 10 Jun 2025 13:12:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749553972; x=1781089972;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=EZyCLTPn4186mE3YvaO6jeAsfSZgxpvbTOkJtmmdckA=;
 b=S9nois9GRWmwaBSQlC0896wUpoU0hTH8DxLVqbeAJgC9i7wZZZR6hguI
 BwSGb1ecLmdNvXgtoOTalVSKUD847Tl8nXpze1pBW+BiUUMMiBhUACXma
 /+2WXKT2vyRPSgiE5FSDt3qXr552EHrNTtekeLd3w6dcHYEkddIZz8Xfb
 6tsJ8WZmzT9PYIbwDjNTZsR+Cbn+3vpKn4Gv7TV8hMHWu9NB2o/VPAUsf
 AQV5DzCv2gwII9vO0Az2GS5t4j2+OkqGWfPBz3ZVeA+oVO0069Mj/ffJg
 ZSYT540mr5H96D7AUpMJCcnq4A9Hv9qic7f/uPJ4DDXlZH6ZlOSNAA6bw g==;
X-CSE-ConnectionGUID: D8GLH9cvQ2iVsMyEqH8sBA==
X-CSE-MsgGUID: 8kwKXGPSSaSuDeJJg2iyzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="63008711"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; d="scan'208";a="63008711"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 04:12:50 -0700
X-CSE-ConnectionGUID: cI7mIJzqTxyFVfiLoWw/6w==
X-CSE-MsgGUID: ZGMJDLhrR82vvVz354HspA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; d="scan'208";a="152060196"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 04:12:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 04:12:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 04:12:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.86) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 04:12:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgrtogNdB+nloq26POPiMtS4PAdXyP2u4xMmMxJxFF2buae6RZr6gejxrURiE6YGQqBq+frmi5grQp2EAsyewnazpto7+r0iwfD1n0I4YMbgpvZJ3jnPZC/5dVIM9VBBFXyPpNmUL2n6ep3cMT6JFGHN+PwYy3696k9jPk4ihP2e385hxD3cOI3xW/aFlqhg7gTspB6hAU9cynkuNHGODrTLBdcImnZWDT+zWmDZs1NFILmB6zdu7AKLqJWFMN5Ayype0TMqOpBeQgf5HWyrvyqKS3tWXSXJYCVKucILBwd4v83nKNKgSZBOuYy+8tcOgz4f3/IfiFcSjtuJK8Ytvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7yrSISlneaid9RA1KLREDOftWvo+CbC7/tqBY6g7fs=;
 b=dKFPtFxMKMBtRBDfMD3CVkDFsfi2wXY60OoDPY84Tz5sYwTzsqmUa+9Iy4Zb4JveWgSMplJbnUACq3TT/f7sVJR2QPrPyvHKYL3ZZwzjobKX0yPLCVwEhrPqJGkyrZTB5SV3yaKWajVkW54KxgcTRBEOszCcPGQWvxsfWX+qsMPO83VdC/tTB6uQCIkfgM7Q57BPlJX6mH+rl9FhoS9odIRFjYSAP8BX5GaTYdan5N18ESrZFoEg6Dtmog28teTM4bcXi0TThQr5jghW6cI+iUXZylkkni2E53r6lFhCo481zONyimQwM9vmj3aegTU7+5FZ87x2wJr7ZT7AKoo23g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PR11MB8733.namprd11.prod.outlook.com (2603:10b6:0:40::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.30; Tue, 10 Jun 2025 11:12:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Tue, 10 Jun 2025
 11:12:34 +0000
Date: Tue, 10 Jun 2025 12:12:29 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Kaiwen Deng <kaiwenx.deng@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH] net/ixgbe: fix unexpected data in the xstats info
Message-ID: <aEgTHW0dEjJmL62g@bricha3-mobl1.ger.corp.intel.com>
References: <20250520011316.561890-1-kaiwenx.deng@intel.com>
 <20250610054225.988840-1-kaiwenx.deng@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250610054225.988840-1-kaiwenx.deng@intel.com>
X-ClientProxiedBy: DU2PR04CA0192.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PR11MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a2cd96d-4ffb-419d-ca9c-08dda80fb327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NrMTWaFMsCYPtd6TQpR6Fz5RKKpIOpUbhMgnRGIRyI6ptRyknjHjXvmEJO7J?=
 =?us-ascii?Q?2KpQ1h+NXqlDy/LTAeUyLYEPPBBv2q1KKdfA9AqF0mYljqLXlPbdB0a2TNW2?=
 =?us-ascii?Q?MkY1w8VbmCcLuZh29N5OvufpmB0Vlj4cSO9ZddYpFzw/8IBwtxRFTnnNEHBd?=
 =?us-ascii?Q?FUQIuRzxQUIKiC1xDxnU50hbD+S526SNXszdSHJXFjG64/XAYmUzxrzmP/Mn?=
 =?us-ascii?Q?UO2HUymfC3lNQKWYzjnUB7L4IegolBcGQjxc1vp8Qia7BZHv2z+YkqV5nEFG?=
 =?us-ascii?Q?06qJy7CfRYPhEO3Ici6jci8KY85fp78JAG76EDqHHeFagm1ukMG7nB6Ab6ph?=
 =?us-ascii?Q?fj+cB9SuWsJuMM4QUBPkWwojj7nJtNsFo4SFi9G4eiLnoaFJBpdmvfl698RL?=
 =?us-ascii?Q?MmuhOMmSCu6cUzw2U9egFOUp+J/FqrvtwqKlsVNoBB98u04bs/NLoizZK9xz?=
 =?us-ascii?Q?Hbsu6uYXDlH31FzGImjp927B7ZHtwv7kihKQTf2XrVCyS1W2f+iQyGxiO0BC?=
 =?us-ascii?Q?JEqFZdnHhA6HVqpRzYSDu0XgOZ8ZDVXzIYhmMCMzDmunXGE01J9RsdPFis1z?=
 =?us-ascii?Q?YiSkMK/70l2c5CyZuNOTOCimaJJyaVaMruZeq2WHjhTbltjBvAB242jjfroC?=
 =?us-ascii?Q?4pfPd+pzkVqfhKKjbwTSP+ww0wboQes7SyTRLiEgUWBXalbQLErmyUk+Uf3W?=
 =?us-ascii?Q?5p44YFtuj4b6Eb4Q+nEdhk8HS7LWxGsL3KNAvWsZDM661eh+h2FC0KIBZ50l?=
 =?us-ascii?Q?8jODtyletDpVOTae2gH2ddSw8ftQH4zMtdoZJ4+VR9uV4Vs/O/eIR/LdW7bP?=
 =?us-ascii?Q?yObKA1Wicb56P0EAv75gOj5Prk+ViU9W8Ztt+bNm/D4AbLphixvOhf6uNQgk?=
 =?us-ascii?Q?9k9yt0AA/UemzhhaUO+L4ffcwb8F95/A3sy+4UAqaXmj3B40vElZn8yG+Bnj?=
 =?us-ascii?Q?va/loyHO8D4aCO4+YhrB98+sE6+ADkC2TFjwWc7SN8wD8avVZoJ5VtplR5S6?=
 =?us-ascii?Q?F/2GG1yu6TLuChEUu20nFPfLIdddtMU5jftozezafR9hEmyRC14MI8OC6fZe?=
 =?us-ascii?Q?iSGHSlEP/ZrcmYoPhPQIvdFq44Bq0wl8gsI2iIbZsOfTQslqK/d0ZNrr+gG9?=
 =?us-ascii?Q?Rf5lICW2bgGJ4qMVwPYeB5JDHZvG9jFt2H+C4BWdtqh9Id+TJ5urouGUQtuC?=
 =?us-ascii?Q?LSOv01RHhiQQd2IDinLjrsmbzO+ZOaFW6D92wKwZuuIXj39nE3XHBWY1R/cP?=
 =?us-ascii?Q?TRQPHD1MRhjdi2+xvTyNdsyw48gzX9IkFJR3vKoXXVbNKM/mlebjOHeLYkPe?=
 =?us-ascii?Q?MaCy7R9VLOabseYfYhrxmEuugzvIA2ELSjNXhleNifjxJCc0z2Hops3twTf2?=
 =?us-ascii?Q?EP+Q09A5YGAu/K6IQ6aLckc9w2gv3AKqiojUCwVlvGJ9LlYJpg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wHFiWzyn4fc2qTF4LqeYOTvqkElh57hGcDLEno/aEpd07cng2jGK1BU4ktCS?=
 =?us-ascii?Q?4vYYbZn/BEbeSsEdWFsODKoI3d7HHkCku5wJWBvbhaqqLovj91UaBKx11ykM?=
 =?us-ascii?Q?lIpw8whR6epo2HDcJmctQ5E+ZfEI3y3jIwFhc8cLos8ZnhrX0QKJIckmFz/W?=
 =?us-ascii?Q?OZMg/hj6zoMj/OC7NjMt7lLmQt2zWv1gPKpajIFR2pnpU97QDCr2HGwnBl6f?=
 =?us-ascii?Q?XtuF6TqhfsDDpyDX7wy1YZ3T3gqWa1gZvchUgxE1TooSyXOBOB1cMWs5TlJB?=
 =?us-ascii?Q?U8Z+BG8H5G5yVQPvIaigAPWgV71wYEEZps0UJn1nT+EA1P5O7tKBQnxpFBNk?=
 =?us-ascii?Q?r7Mt4nKFKzVSGAeaSuZKjJrATQMLaqwinm2Q7YxwL0jX52w69yVOctFF86C5?=
 =?us-ascii?Q?IDOwvWHTTF/tQMgo1lbEZi1u5o6KFH3dCd1rFbbDp3k4mlQIgFUZY5bHn44l?=
 =?us-ascii?Q?GkJGZFWYnyY1VVNufvFNSrFAR41jKbFDo0sihwgu6aNPqfUNZDLPEWYw3P5R?=
 =?us-ascii?Q?x1YTp06b8eypWnNwFXbg1V63q1PUkVRjUI0GlQ3vzC60uan7d/PN/cj/ViRE?=
 =?us-ascii?Q?fEgrz2O+4dEjdovJLocAYMgkZkGCuug0cRLQ3xRvR2iQpZOejgMmh1Gi58p+?=
 =?us-ascii?Q?mkoeOl7+MHkmW35WljBDgCiUpOLaVrmVvrVw/pYjfZhT/nrwTp8vv/OPVgAz?=
 =?us-ascii?Q?pfjia6Z3wFQe/As8ejqGniqMWxZ/cCn/BST8n/oxQEIBhM5TNfQqNiteQuJ7?=
 =?us-ascii?Q?kw+4hfBfMWXME78hcSgB5Mm5do96GpLNOfoIhMNEp1dUUK8p7iF1L9mQnNM/?=
 =?us-ascii?Q?d9CJ68URy3CHFyyvKPmpoipwiCmW89V4JV+wz3WuMwqYCI9bjI1fkqzxw9n7?=
 =?us-ascii?Q?CzVDJBMQXpuMlON6/wQIwawCkU/3nWzmHiKGj3nCdXzeEIG++ajq2g6vzat7?=
 =?us-ascii?Q?5LR9A9eeCwItj3Sp82aJ+NEpjt8HEWiywNxwln+aMS4mQaP8B2IoURAaNlkZ?=
 =?us-ascii?Q?3tE2rcpNnK8p0kkYdwIHwpknE3g/UOJNxdoBifbS2HBpcPnsE5kzNSaBeKhA?=
 =?us-ascii?Q?iIxwIGTWU2K6yQoNf7CKcPet2ikBqQ2nQpx9jTj4peW1HnIoxgDpv7vyB0BE?=
 =?us-ascii?Q?GglrgBeWDrfhL9OrazS0e7D8NRvJaGK8hb9GIHZwkRGeOWvQ7EeZya+E/IwD?=
 =?us-ascii?Q?jEYMFVZTzJD5cucXAFLdQ9nj0ARR1246ljptVcQyX5/1TXQNpBZl2BaINU/t?=
 =?us-ascii?Q?dW+W7sGyGjdUT55pV6R9sswNQNVPg1E+q4TM4nMw1WCH+uRSNcnjsYfWWWUo?=
 =?us-ascii?Q?3GHIjRxxgQRHW1DU/QpG0Ye5jPe7uOA9F5dUppbZ6gzeM5o4tkYREK2V8+f3?=
 =?us-ascii?Q?czfCoX9laAb6xcgR6jZJY/KMIfr6IMfgJZIxtfEY+xhy6ifwe3sD470ATRku?=
 =?us-ascii?Q?u0HEWHELKh2WT34dBOf4n8ytYqxqQKK4VdUrKe/2UxwNuGOyNTsDT5MtKUK4?=
 =?us-ascii?Q?vXrEmANx2ID1FQ2IAaL/iEue+COjCoCv446m17Yi8vj3/rAymSRZDwJejLvW?=
 =?us-ascii?Q?LcIbRQk8Uo6w43eHNDtRzBfkPm/ybczsPFHvIC1U3DiIeUlILrjq2ZaIDTf+?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2cd96d-4ffb-419d-ca9c-08dda80fb327
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 11:12:34.1254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTGH1cSSgKK6EBmOecgQPeDrZ/vuo2wX8nDD+vk+ppX4bG+2TJOr4yF0sPgjxqMU+y5PrOADYh5j/pqs6RK3aNQNUWwUEMQ6JFpZQT2FRBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8733
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

On Tue, Jun 10, 2025 at 01:42:25PM +0800, Kaiwen Deng wrote:
> E610 device does not support MACsec.
> 
> This commit will excluding MACsec stats from the xstats info
> display for E610 device.
> 
> Fixes: b35d309710fe ("net/ixgbe: add MACsec offload")
> Cc: stable@dpdk.org
> 

Since E610 wasn't around when the MACsec stats support was added, I think
a better commit to identify is '316637762a5f ("net/ixgbe/base: enable E610 device")'
since that is where we should have put in these workarounds originally.


> Signed-off-by: Kaiwen Deng <kaiwenx.deng@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


