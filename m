Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F61CD5BC8
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 09:50:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EFFE402E1;
	Tue, 26 May 2026 11:50:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 2E19B402D7
 for <dev@dpdk.org>; Tue, 26 May 2026 11:50:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779789050; x=1811325050;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=vuqAPPTOt7PzS390WXlL5I47u/esQPrnozredxuCQAo=;
 b=KZqPFNYIDUpYP6NYtRdTmt7YuhFFF2sJGghZrcTGooofXWuoCeQbgFic
 Kg9qTXEL7dhuhzqGtBS3dxqZPdeSQr3SlxBBeSSyYSx+yv2nZUEFemCZw
 bgb7SycNszxwpqfvm8800GwVgg5l3J0lDYKGJnWgqyw6H0AhcZ+hS5UBU
 gcqaB8e8mYJiDGOb5NYsOda5H6dWWY6iZ3/jcIHx1EIWHsFqwxtWks5j/
 /+zvNfUTH7copy2yw+cGyOUemn1mqNlChdQVOK7IOG6rN3wVfXeUTsyxK
 LiCu8DKVi+Ez2AXWFyNXMd7iKPNsENsRv7b6hhqHcJ72LVYM0r7RDrNSc Q==;
X-CSE-ConnectionGUID: 82ZBnVJiSdasVLOtNcBrnw==
X-CSE-MsgGUID: WGEJzN7pTReswzGTWz+UQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="91287718"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="91287718"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 02:50:49 -0700
X-CSE-ConnectionGUID: UOS4ezfMRMeoi0lOo4wGvw==
X-CSE-MsgGUID: lM3/6VlvT6C+xvx1pJx0ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="246961007"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 02:50:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 02:50:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 02:50:48 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 02:50:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dv8T4ZvvtA+VmKXeJkEUd5o/n3LVHwXQZZYOUIX3LIVrUGukp+f550dZg0fTAOsZQDTllBX74cNveOb4U8wel2yAlhN9huM9fwYQcR6K8mDRIxUI5KJJwwg4UrTJh832oEQBKtoQlKsycjaU3+l8o/FGfNwGP9TN9zjzwtGS35TVOxzbvbTPf4t/fpJrMzbbpJCVi2fjRVbZD4gGryEtqa8A70XIpbS/ltgjWx0tvfIxiN240WXOG3jldeHM5M7/MlYYawscvgrLCh6x42e5BXHIDFcPlkp7qyHCqZDJFJcJJw9TUtqSTSRUmFJddftCaXsN5Wl/HZEtyfinPbp84g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3EdwQOVOStX8zC8RxSNNoH3DBoE3bAFi/DrVBl9MgA=;
 b=hCUGEes3qnS5vh4duRQxLOmrw9arLXeXxp2gzzLsCdaNVSBu90epvthQke82QttqrkBQvmjY7BSHsuG9tvvyADkep7OKniuPv64sJ94XuVPD6stlumDpqZaBzc+8fKcotXLX2552bPF0DEU4B29jKsfszM1K04wSBGMbNBSA+WyLX1aUhR9/cpt6TSSSddAfV/7giuCev30JGuM3rMTd3PdekdPq2rSq9mhVOYl0FpZKPoryi5t4H7WcYOEhbcuAFbqRxYR9MfMJvOm/h5KYEPE3T5CsnjBIAoWvsWn04SCmvRJP2YeDcvEPe4XSY+OG7RFWB5ql/eMNNqUdCui4CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB8063.namprd11.prod.outlook.com (2603:10b6:510:252::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 09:50:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 09:50:40 +0000
Date: Tue, 26 May 2026 10:50:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 "Kevin Laatz" <kevin.laatz@intel.com>
Subject: Re: [PATCH v3 04/25] dma/idxd: clear device at scan
Message-ID: <ahVs6zrNSyLSKNLZ@bricha3-mobl1.ger.corp.intel.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260526084212.3145685-1-david.marchand@redhat.com>
 <20260526084212.3145685-5-david.marchand@redhat.com>
 <ahVq9dJrOK04Ujwd@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8zC=LUR8r4s7q5o9W2KaAa3PjKD8+qoAUsV70Ddqvgp1A@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8zC=LUR8r4s7q5o9W2KaAa3PjKD8+qoAUsV70Ddqvgp1A@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0278.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 06752825-0b3d-41a0-1f30-08debb0c3ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SbhCBJeQmXHsySwzxfq+7GfXG60dWbBnveQ82hLX3f7hvJxSY/WIAijgQeaQ71ZFnwxf3eCWaa3gZ9qXtWs83cz/VTR3UnMpnhFsljv18u/QCSnUwEEXQPenGK9Ywa8zL5fJiWIuc5YnhQsBmEz9TxIhWS2o3OoR8OedRiHLQJDBroQ7CnA+bxsIf8IEj8C7w4X3/rsgeQD1h7w2iTwMqkn7HdlB/pprhGBSf3UAMvojo7EBg51cMtPqZVU8HwAt/YS5Tic/CH/Isaew/GpJO4nrKSxqvJ9iCZv7PcIzLMmGKz7ZAPabbMj980D9g6h70VP4gEofRH0bbHBDe4pjdtddzx4aJLh6HSAXEwoaMSxnCTFO/3LNx6bcirEkWe3olooaLffBa2Qenzy52JyLVYKIep+M3drVXvDQVbm2IMpSDCJlSXPLSm0rBv8QXR03FuoYIP+EkVibMZFHcZ4JOdw9cB5yMTQ6yDJQipR3/0hB7zSCHbcQ2zQd7BYu3a2ULqsdVMJ3TwQIWJ+AcpE9nzC8X7hPbWgzi1K4vk1JP7TP7T+rPk+QR+r4Gzjo7AEgmohvW8MBUEkHs9+AM31uCSY4wpUvhiQpZWpKjfVfqtfNrp+IDTSO+EVlZ5Pwse2ykbcthXg1yCxKFajCqTCb21ha+oW5HKJapo2WJ0uElCJtotDkQWfexDQ2Rv6FUoum
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ixPG4EP/OAUAOocZjZsnCEq7yw4b2kqTG65UZ5x3IS52Kkes4R/8gY4CcW9s?=
 =?us-ascii?Q?v9gFbh9GT2qgpSY1VJy+eDdBPzCwrktJ029GonGnQelkJjjZ5RBvAGkhYUxP?=
 =?us-ascii?Q?XdGluE9oQ43IuJUFepToSUD2yLVA/q9TKoEFlOYuVoDcGXHduLumgdIVmERr?=
 =?us-ascii?Q?BqCmJpkJYFgMJtdV4xtTdFB4scKoV03vJZjjck/05sAncVKFeAXSj80FTUFB?=
 =?us-ascii?Q?QXhtyryr2xyEonKH0ulAnvNnYJFxDj9uGoC9sZ3eZcA8ftQWPkvzV8/BxIAG?=
 =?us-ascii?Q?DJjah7KQOJL/BYCbBOtN0EYjG8u/gUSNG/FxXjQ+kdVz/kx+irTxogVVf3ZX?=
 =?us-ascii?Q?Hb6sSyVrbzepFORkD9e/339q2Gmkaex2TRKx46Xuy7dMI2FW5vVIKVWpAFEj?=
 =?us-ascii?Q?mScaWDNfFP/PCkUg9O1tVX767bkci7fip5D/e2nfSdEW2tbuwZjr0MElRbpn?=
 =?us-ascii?Q?Icgqj136Csfxtqh2SmrbwMimWyISUeGsqvuVhQh5Z6nDRwvTeFW85WH9/lqz?=
 =?us-ascii?Q?0PLIeFID2jujiLb/bNNZFLbp5FWDG7EVEqwcjIRXvAqAF/6uKV/vqheMSqRS?=
 =?us-ascii?Q?Nav4bHJVmju/D3dLCgg8jwCew/FMuLuXj5aaG2Gtsn0Mr/nudcF28NJ79QCv?=
 =?us-ascii?Q?ZFMofesD+Au4WaZU8LAmtQISnCcUpLf29dJiQ7xwUu0YTv3x2PPD1LcIIKJT?=
 =?us-ascii?Q?lq5AgOY0kmKYc3rk5lnqaxsGmzf+X3QkBNibiAgTrFUCvpVMz+mttMkDmyYF?=
 =?us-ascii?Q?33d8PDtJvJEnp/WRTRLwg7QyWA4gum3AbBMtyuaBWwYVVCL/YcF8tFNKTstV?=
 =?us-ascii?Q?9mnH5NiVIAVjOcvNQEzvR7z8Qjp1nMab91hUzeW74YlscaOpOR4s+u0cPjPU?=
 =?us-ascii?Q?bajkH53AlAFDmh97YdpdRieyLhIiLa73y4Cu/0Ohyi61r1hZvVXbJp4BPSm0?=
 =?us-ascii?Q?PkxrSQH1dx+MvBD+sZImwB+HkC49xNIDw+ROH/5wQpmI0Th1x88WJe6CF/0J?=
 =?us-ascii?Q?GJcBeJ2pWWDZU0wWOT+SXDJAmDPfl+a312/mg09Mmvs7uMoMg4lYcwpOPL17?=
 =?us-ascii?Q?bz971WH77/t60KHRCSWXtn9QU3+1ZgHYJ5CQABgBu+CQDfNwOnIpMYgCpRUQ?=
 =?us-ascii?Q?8eBa7DDFqfNQY5MYactBNEgmKEx8Dnu1WBJRY92+R2tM3BG1XNq6s6ImeGl7?=
 =?us-ascii?Q?l2zkxONEgaYxiKIAQ6/8wnas70LyM9WCBy9j5grJIq3in2lhNlgf+HrYHcfv?=
 =?us-ascii?Q?/KLTDXAIqJPrAfuU5xFUP+iHSSQKy7XwaHFfy6PXwSbFweR2b4Lh4y5dmWhx?=
 =?us-ascii?Q?AuWBJe6yUXMZxkhZ/CsGjr91j0QfaoOtniMp84pj2ctGTzwCSD0i24eq7wmm?=
 =?us-ascii?Q?vQCeiQU6VzFRDtltX0a+PXhPg78piZ2eJNIYa54O36+6Ti61T+RUoI+mdIvP?=
 =?us-ascii?Q?2S/vp1gFQa/Eq6UDMbX+vUNKCtpN/NBcvHqLjEUIz0mdN+T9LK/JRsD6Uqjk?=
 =?us-ascii?Q?/voq2JRiYNSefLBRj9kqBGIkdBuHnS1BFLpk/Bj2KWvN00uiJRJ1ucCm1pFN?=
 =?us-ascii?Q?1bxSre55AW/lIEiPWcsmbi4alQCf5UYFrG3hKY4ZdUjhOpQsWPMKCyAV+gRi?=
 =?us-ascii?Q?yUfqfW2rL9Vxgp18FzESA//3enl3FHPB5/IuQupWAIv5LopwK4slcAVuxynm?=
 =?us-ascii?Q?OR/dkyMLaENFHfw8ehVxAzIoCVe2cDpWbx4ZSncOpcd8b8Gq+PUDg195H1CP?=
 =?us-ascii?Q?s0xb4abM2Bd2PSTonHdwoKfaAFhdW1A=3D?=
X-Exchange-RoutingPolicyChecked: GjBanyAnywUBW/e94CRng7BTNRq2wIXkpxM3u0UOS5S5zfLnsw4CI7ue9fHmU2nkHvbMzmwDUF7Q9eRW9NZU1ZTm5uwX/eqlH+hTCOROfrYOlKMXTbZaUMXk7KGNux5+rQRQm+hiaiE8jxHBnusWxc70zB7/nJX3lradcJXlU/Nu+B1DVPSkeSgJP6VEE9N/6aRciPPcHlNixmMI/Qwf/Km2U/riHASwnJwV53Qn1WdEk22kfQ15goj8QlsRpoVb7l/40b2ZH/4mb1EmlqMZDOka+Oef3s115NtJhwjjAfiuTiNtcl/rhybVhKLF7EH6ZdF0Ulo+w4weOt7h78HReQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 06752825-0b3d-41a0-1f30-08debb0c3ef7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 09:50:40.8503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNd6BeHV/sGSK29WB5AXhMRyyWmzqK9bHe8fENy31Q+q73Z265OqTcXEbJ5Lr7On6A7RUFWJLIedrXRVoNhs4Y+2c62rUKJWJRjpW6D3z2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8063
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

On Tue, May 26, 2026 at 11:48:46AM +0200, David Marchand wrote:
> On Tue, 26 May 2026 at 11:42, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Tue, May 26, 2026 at 10:41:44AM +0200, David Marchand wrote:
> > > Currently, the device object is only manipulated by the dma/idxd bus
> > > callbacks and EAL is not looking too much into this object.
> > >
> > > However, in the next refactoring, EAL will expect a clean object, like
> > > when checking that the device has been already probed
> > > (iow dev->driver != NULL).
> > >
> > > Request a 0'd object when allocating.
> > >
> > > Reported-by: Bruce Richardson <bruce.richardson@intel.com>
> > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > ---
> > >  drivers/dma/idxd/idxd_bus.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> >
> > Out of interest, did you (or Claude :-) ) run a scan over the other bus
> > drivers to see if any others are similarly not properly zeroed on init?
> 
> I did check, the "legacy" way.
> 
> All other are calling calloc(), or rte_zmalloc_*, or manually clearing.
> I hesitated at changing the malloc+memset pattern to calloc, but I
> left it for later.
> The series is big enough.
> 
Great, thanks for confirming. I also agree with your choice to not bother
changing the patterns for this set.

/Bruce
