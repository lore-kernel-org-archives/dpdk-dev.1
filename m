Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFBAC282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 10:05:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94729402D2;
	Fri, 14 Mar 2025 11:05:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 8373C40289
 for <dev@dpdk.org>; Fri, 14 Mar 2025 11:05:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741946734; x=1773482734;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+F46izYw5B2FBgcp8T34qgL7y8fS1RQEId5TO3kTw9c=;
 b=BraQTGMA71EvFv7eeJMzwIZvmnBkLlDfLvxjKz+iKO3mojtGYpSRxh32
 BQaX75zkvFja0/bxa6fZCx6tmQbNscERtKUBtBB/of4qN1rAsDtWZntZL
 of6xE+T5q3iysbORV0PU31n35cDAUBJndlCiMoWb5oX6pjTkAXnExi68q
 903ieASFvjlUz/vuzbyRDwUfhfauQDW8w0DAHNOU1MYn4yXxaJbUYWECH
 Yez/XoGTHf2+cPlGOIjEDQISXEOjpjcbDGG7j/ULPMLabjrlb4ZZ9ps+W
 d6FVcYzfTZI3uBDRTsEujciDYymZK4fjbDMSP29mlsHIaAbGv2OjvsKHW Q==;
X-CSE-ConnectionGUID: 3UpAaqeISoyKafXZQMBGyQ==
X-CSE-MsgGUID: 0RIqGQZNTeeFDHXse/AvqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="46882850"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="46882850"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2025 03:05:33 -0700
X-CSE-ConnectionGUID: 6ci3K140SlGBgsfpme3ULw==
X-CSE-MsgGUID: qpcPox/bQwe09GFTT9I7Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="126105263"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Mar 2025 03:05:32 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Mar 2025 03:05:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 14 Mar 2025 03:05:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 03:04:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBonEwoajOOrn/qI8Ts63mboHG5gp6xtCtiXEaUm9RPbRtLrL0ampan2eixlttXGHxfthoFU+niJN6I9qkawxVX/8/NpmcQiEMZO21O2fEZV64RESrp0s3YXHCi/WuzFKP62jWiAxlt0024RYQ6R5WUNbpJdtOsJjk0RQoO0keJ4U0SfdSLNBzD7QqTdIWRqFN6r6WZ/MtbDRKoz9JXroyKN9JLIO4+mGLYccehaAoY3X0jPAF13HnFGFplAhWvIpWDjLlAPdAIixclGDBlY9FUZ8yPzhnPJLQLxSXsZHBncDrSsjkEmsWkfpVmlCVaGN5yQ87hB4ndreCaWM7pkkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtLE4almkIFiR+AXzuni0vvrImhKX4M6UD8u8IkuSKg=;
 b=EVfCQf5GyJBU8OlDCHVuVSvlOrzRN3Wtl6pFuqD4RQBgKqojYmNsGYHNxdwiXqrwfy/BgsCpQHCMlf06LdSIA6en6cLSeJZRxwn78NIL705Oo6mRC2osfYI0GA+YGfmuKw4M0KUQtDFbqGTNZ94JoEqut8cIicy3ySCKdRkr71UHzl/aTiYojBGhioJT6QosYUOC/JFajk+EVnlOA94dI5ki5jcYkmFi3k8M6IzDQc6fEoT2LOBL7AQcCCTmrWBvaZlXxstlT8I97810OebJZlT/DswkUhZ6WyAN1WkzhTAQmmUDPuSqj1RyK/s/0PT77Cp7zv3D5ZsgA/uOxfiEng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7736.namprd11.prod.outlook.com (2603:10b6:8:f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 10:03:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 10:03:54 +0000
Date: Fri, 14 Mar 2025 10:03:50 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>
Subject: Re: [PATCH] net/intel: remove unnecessary compiler flag for mingw
Message-ID: <Z9P_BsgJOn7vPL0S@bricha3-mobl1.ger.corp.intel.com>
References: <20250312155458.1395709-1-bruce.richardson@intel.com>
 <20250313182443.GA20942@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250313182443.GA20942@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-ClientProxiedBy: DB8PR06CA0060.eurprd06.prod.outlook.com
 (2603:10a6:10:120::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 066e4be6-9fbb-4e0f-5056-08dd62df8764
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o8HHsBLru/wLulQfOjLQFRiPLXVVFG9naIX0f7mqT4n3f4kqey2jhsONmHvh?=
 =?us-ascii?Q?5gvC72XhZeaQMBUDOrFn0+pGN/Dr6k1VZTfIuDKXboOBVlwqZOfYt3R2zdoh?=
 =?us-ascii?Q?zrXnDIFGgM5eToEdZ4ixCpbujqiKhjTzbdU86tOhN5JxRHltmNXSLyT8CmRZ?=
 =?us-ascii?Q?a+zRW07v9RIv49l/cMd2LrBOlimK75vK8DuwiDvThS1We10JWaCocsuSCzvj?=
 =?us-ascii?Q?agQrSvrXWkymztq69IR/liuMSP3roNR4PpqTN22bz0t8RCaZsEYxPk/TW9dV?=
 =?us-ascii?Q?PjtZAqa7JZ3r0/a5f/0wNr47Q6FpoGCgN6g4p+C7W1xA6N4fd5PyrZYLBCqo?=
 =?us-ascii?Q?P+a9toZqA2CBc7O6zPMs7hUoSHgX79tp5LlEBDemGWlyBQkKPLQDEiLOQhcZ?=
 =?us-ascii?Q?oZ1oEN++0VT84RqvNqLdBhfjh+hsuO2vF867rmiz86LZkjGs6uQGSINzdLCa?=
 =?us-ascii?Q?dvqlvCi9wX1oWnaeLrXqRUEa4T+4QdljHw2PfOqWm30jJY/9fxjrDt0+edUL?=
 =?us-ascii?Q?8DsQFGUFXwGkXreHhJeCqI7KlUJcBGrlbwt+fLCjKdVDktJzdJLic2FAWNPu?=
 =?us-ascii?Q?S8Ez8/0sb3LNit1YnABFJDMvMHXTry0AHKQlW8Bz9KaxTEbO29Ky+YRR60lJ?=
 =?us-ascii?Q?gizkXwyiLJE01clBAQ+OGdhbyhY+UY7HU6zwHLgv9m/NhHAw2Wudxqo8jqry?=
 =?us-ascii?Q?5akYzL9Za7TfMG8R4vc2HPVrg+Um4otZsO+NuW9dzjT+y7+GXiz5SQcHlTFf?=
 =?us-ascii?Q?gQ6i6fx9WjUDUc8G81KsQ0iOjgKnfLjgR5jz1oITgK2g+xNN1SpQieJpk56U?=
 =?us-ascii?Q?E6HBCEtSKzpNksswy0KFodDVLCAqGCaOLvQqjH6jj7ZOgwiH/2e2jhwG0fDu?=
 =?us-ascii?Q?aYq5P7xAQmvNO4ThtSbcgcnF0ndKdDdJr0SqhrOzVYbJ1g/XkDWUnRVaaplq?=
 =?us-ascii?Q?Z0Eb5YVf/UdENH7Sb2dAyXMl2q9ZnCLy5w/q8O8mURnkqdgIlZEp3bXOwXVE?=
 =?us-ascii?Q?pqYRPnbemZHG8B3GpYCb8x48EHyIR8xCXelb0C0eCbg+bO60EZYpm0BIU5Xa?=
 =?us-ascii?Q?3yHw6zDrm3qlvedB25p03dAZrzCySzPPifOTxmooOctjZqXGVFJFeNud+U9j?=
 =?us-ascii?Q?ewyUIz0tUKMrY+0zMohaehRjAM+iU+TMkl4LLrt+Xp0IXHtEitOYhZwwJ8gA?=
 =?us-ascii?Q?VG+HPHD3V0NP7a/WPsGdiEkgZi0IeHag6Q4bojBhOpDjWXenBN4cZX/cT+7I?=
 =?us-ascii?Q?aXChg85SPnmrPpDIiZvD1TNHwkkBG74llNAlUAB7f7VQQjLCgI/QYmKfZJ4K?=
 =?us-ascii?Q?18tyaQkWdC8LqbiI033PW+ZCzJi8Nu53sMkh2djMtfyljQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HN9DdpKIpYt3Juqr41tYVl0hgUKY10+ZXuyWbND2pa/3YDq7cJEg1WfyJ0ma?=
 =?us-ascii?Q?HFsI+y9JOtFCSzrIhLCHCTIMPP4AV68eWlgvH1uHol4DlimgMfEXFrxpeOPD?=
 =?us-ascii?Q?H63zvFy4tgYAfIb2k9TKK5aWXu/nHm89H1Zz7LHAR8utT1WoOshI1xPRWdpV?=
 =?us-ascii?Q?NwGj9oAC8sb00IRDERglSdjk5NofQW5+fMfzk5qs/8yQz8+2UR/OqK2DqIyp?=
 =?us-ascii?Q?pFDl0GD/e6Xfbu9l3L/j3+eCOdbUBE3f0OoC5ZDBwPgTZLTf/vl0mwyGgdD2?=
 =?us-ascii?Q?aR0sWr+PL+EsDjLBotM+BBllHLYpnTgnSA7Ani+k0rqfhARqLQbVzBSZhmWA?=
 =?us-ascii?Q?iIkjHhwsf/4PEa5WvJzlBQOlrBhpBKWh7PqQOpHAU3B/YlYZhYBufVjjsmKJ?=
 =?us-ascii?Q?h/qHLuSzPxNoln22HiWuiI3qCTB5p0vZC3SwPPryqK//u7HO7ZM9TTgi2EB2?=
 =?us-ascii?Q?ni6eMA3yBPsk0/PCCVTZgwXnAHspkKDDT9A/WZAfT5uxB2JP3smr/GkxcjXh?=
 =?us-ascii?Q?WkowGauPfbcfnwHpsK2iFzXobQuf9PEM1t+PYe/5hvNtF3ALKCHM0Uf6OtoV?=
 =?us-ascii?Q?V8NE85Oy4Kr1vmd8W2uPag8/5EAuI63tifVje1s74/uMRwfQOOzJ1Qg9O12P?=
 =?us-ascii?Q?oNbprjddVXhDj9n6moO24GY4bOVPzUKeWesDuJWgBP8wVbQnJUDXJ65YGMQa?=
 =?us-ascii?Q?Iv4X3cNTt0K3sEPCEFC3X03L2km3N9H/EByZ15KsauESraTUM4Xid78jL89M?=
 =?us-ascii?Q?xsksGwGDMBJoRBSe05+oAIp2LnX91oSV8l9dFcyBG6LI1nwyOQqR/xebBQTt?=
 =?us-ascii?Q?SZIW3jO+BKhTcxf7MpjSF3eKC2xlaN7YnIeyZBO8m3jh5d92kkIe0ncmteKM?=
 =?us-ascii?Q?n2K+GI9w5lfppXTzM8182UQ6O+1brLzBHnh9bozl0XFBeXbfwQR1A+tb+ozz?=
 =?us-ascii?Q?x/mjSNrw/C1Z6Syua7vQZ+Kl7gJ9N2s+mpuOwMDyjCIbrQw3vSszPtSIOCsY?=
 =?us-ascii?Q?gR/dKMrq/0+V/z4zUNXAHRFrPLOz1p+rebwtz7fSXumpDBsFZCj7KKOjOhme?=
 =?us-ascii?Q?to66cAKr/JDJXM0H5FEBfCVhUUaDRHBjyZj+4wcdqrrHUENrIv66pRgz1wc3?=
 =?us-ascii?Q?cZi64qRCa8I16Chyjwt5/cF9arnT7ni60nlJBj9TpFraVXIrRyISNpZJ8n3G?=
 =?us-ascii?Q?Rv2pQL7cSlQET4YxHvWG/5gW3mxFDVRJDpNP0uofddOxdKlB2wVzf1xVfvNQ?=
 =?us-ascii?Q?/G3v4Iwr4IRVKl6BxJSoQtV0dtGUIwHNb23iYj6CIUab3S6n4uUcDCftAMU8?=
 =?us-ascii?Q?ZLGOgs6m1JRHZpxGHxWI5e99I8xqD7E/ObGVR51swPW6iju+4zT13kMPJI6w?=
 =?us-ascii?Q?V7WDsk2s/FnSQJX57Td+tmSdLahGrmLRxMjqndtwc7CBCoLZJjldP5kFFNOD?=
 =?us-ascii?Q?TAj4ttc7i4vxTFPq5kfWvLrzgCA2B2ItKuL15rqWmGa6gKAE1wCH17lraGgd?=
 =?us-ascii?Q?2hD4V4qJ0rPxpnGKdb+E2q7PqPG2BnETJf4xEgQa1iIsk7xZpBePqxsS2rOu?=
 =?us-ascii?Q?ZoDZwpfKcZ1HC+wQ64XsxSstUdb5ixY/4zjsGE/xfewLeae7amJEtuMKl3ad?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 066e4be6-9fbb-4e0f-5056-08dd62df8764
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 10:03:54.6825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIxEukJg9BpOMEws4GDhhauJqx0UmiNFzkz4zvjrTUmo8zZKCto1xnFQGALomDWkneuuqqcn8JhhLLanNRJkUCOxjXLtCruMKrHNeO7G/9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7736
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

On Thu, Mar 13, 2025 at 11:24:43AM -0700, Andre Muezerie wrote:
> On Wed, Mar 12, 2025 at 03:54:58PM +0000, Bruce Richardson wrote:
> > There was an issue with building DPDK using mingw v8.1[1], which
> > required using the "-fno-asynchronous-unwind-tables" compiler flag when
> > building using the mingw compiler. However, recent versions of the
> > compiler no longer seem to need this flag, so remove it.
> > 
> > [1] https://inbox.dpdk.org/dev/CAJFAV8z3qFhT9Vv5xOpLhi74BYAht2YCfL2ffLrmei4hfSG5jg@mail.gmail.com
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  drivers/net/intel/i40e/meson.build     | 4 ----
> >  drivers/net/intel/iavf/meson.build     | 4 ----
> >  drivers/net/intel/ice/base/meson.build | 4 ----
> >  drivers/net/intel/ice/meson.build      | 4 ----
> >  drivers/net/intel/ixgbe/meson.build    | 3 ---
> >  5 files changed, 19 deletions(-)
<snip>
> 
> I'm fine with these changes.
> 
> Acked-by: Andre Muezerie <andremue@linux.microsoft.com>

Applied to dpdk-next-net-intel

/Bruce
