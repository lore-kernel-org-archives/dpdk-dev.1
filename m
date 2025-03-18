Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B465AC282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Mar 2025 12:48:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD99A402C4;
	Tue, 18 Mar 2025 13:48:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 5B7ED40291;
 Tue, 18 Mar 2025 13:48:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742302113; x=1773838113;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=YL4/Mft/mJHYZmgtWT9NcVLIxtH+UBQPvPqauuIN3Vo=;
 b=SHe04pWllbbaldMD3JAa/+DuVUjZoFvs45XcTG2c2hv8VHwrA45CBDsF
 A5X+efUK8LDsNUonr54zJ3UmKLuuA/oFIrbybzuYW9+JCCusLQEQzUMqa
 PwqP2u4CZ6i5D4e6fK99QpO0H0NYfMIVHK8NLgQL0iNxHUMkV5vkoB3uV
 kGZnZSGsapQiLZACtbInp9pPgk8F+djfluFBClzqrk1QAf/KHlxJZ6T30
 xihszKKAGBTJwxMqZ1aqjD2VuNlNqmwSaIr/+Oz/MqXqUB45plrHe3L4M
 b7TvgPIrXGdUqvYXy4OjaJrYeXzMmML6yX897BNZxflOGkwM/BEx9LH3s A==;
X-CSE-ConnectionGUID: WlWDfAOuT0+Qbi/9DpGMZg==
X-CSE-MsgGUID: ucqEwye2Qt2JTCJ7ocpqOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54825210"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="54825210"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 05:48:32 -0700
X-CSE-ConnectionGUID: g3S4NiZyTJeG/mWLN4qG0Q==
X-CSE-MsgGUID: ljWXILdBSCu78JigkbK83Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="123189107"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 05:48:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 05:48:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 05:48:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 05:48:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pd8hYVqmju920Y/xy3tP7qP0WNBHODTdcIVkDDirB7/sfdI83JY0YeXEhQAc8kIaB3sQLZQNKXYN+JgDBuWJlXPoq0tp3pq4JuRll5NRbWXSkYMBRgGk91H1PYx4X0v27FXPt27XT8R0tiL0almtLVvr1eQyYivqqSWUDggRHtUh83W5epImMlthALlPm7lFw1oHFRQFSFplmQrTc5IFn6G00Y/rBFw6UwWX2FfVnbH/Odn/QGECKJfyz1+tyFyumUCTpTh+HshIZMm0XUwztxS9uDMa7tX/np78fPyFu3aIqmaiRuC1hwN+P7cCnfS2QS2sCDV9aLg2c5n7XAU1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ryj1u9OmEHbVxqPyA3glSFzT/BWyQWylNTEV5FplqFQ=;
 b=mB7Lv/f9Tu4e8HUE5+5tSGwZPqvmmMJ3xhbMmWAN9qk3qBC94zA9AiGbhGmc0rXv+7PLKOJQlrU2XnxOCQHQ2I2pOkhDDq6NlSwyQayI6pFizMXBSECCgCv1QKxRDiJySDAB8a3LtDbGcH8bJxxavHVnS+O6SEouRZQRnCtndCYZSapXGTx+rVQZudqvrmjfJq466h/oPTH4jUICQEN355mFdBWtfnoiBhayDcfmTfqKu60NE2W92xJQJaRLaMg9sbFK2wtdOIiUxyWTUfgYIDpy87kwr4qcShPLwowzmgbue4ickrYtvuwqeFNoyTyRqIhesbqMRSzE6CSosonNcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV8PR11MB8463.namprd11.prod.outlook.com (2603:10b6:408:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 12:48:27 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 12:48:27 +0000
Date: Tue, 18 Mar 2025 12:48:23 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 1/2] net/iavf: fix missing check for interrupt errors
Message-ID: <Z9lrlyDZ1r59Qn1S@bricha3-mobl1.ger.corp.intel.com>
References: <20250310131116.557117-1-bruce.richardson@intel.com>
 <3c869fa2-e34f-49c7-a8ac-5aa5bfa05caa@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3c869fa2-e34f-49c7-a8ac-5aa5bfa05caa@intel.com>
X-ClientProxiedBy: DUZPR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV8PR11MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: 193504f0-8eb3-46d6-333d-08dd661b2da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FJYrI5W87EjT9sZjV8aGR8Vyg7rIN+4H1tn/BuapcKXgD98pruYdcROEOfFW?=
 =?us-ascii?Q?wtNhj5yuv7pmHuaMUkED5YCjjvtEOXeYkZdWKELn08GybRt1w53PwbjZw5gd?=
 =?us-ascii?Q?n66lVNB0FXmSXy1dyqevsI3lbGVHtrLYsWrHvobrUsQ4VTnGYge9GkFZUoZ+?=
 =?us-ascii?Q?Z4HoEPMphmVG/1yFzFKiOvGShsdW14NpZk6tzyOLeGZCWW3cXb7GTrtSL0Lj?=
 =?us-ascii?Q?e9f+ebHlzsDpTKuNFukzZpRyMX2RTMP7LINF261gFlPUI4mLZwmJwRHKh0sY?=
 =?us-ascii?Q?4QRuH5EEbvOBrMqk+Ml8ypHWKe31xKTL4rwbLTMiwAcgvuhfLC65OA9NnWkP?=
 =?us-ascii?Q?bwh6SK5rYfF5cFr1MgzlArYqP42n6y94sMnxtinvsO54Xg+6u/A6jqRnx6dP?=
 =?us-ascii?Q?LDHd22L7VGOFhn0GuOI4tRSVk07L2+CDxSyADWXtPRzN2ilPENqfLPYbUgCE?=
 =?us-ascii?Q?3XcScdLAnCYd8Zg5eivCUtkPp4agNUlpPyY1yvCUG3XcgmDkjKPPyEvWsEll?=
 =?us-ascii?Q?b0zwx7NffjWvJRD7gjR+kcNY9tCjsxyDwHY4Yt8T0k/TSWNjIjOFgBfAZMai?=
 =?us-ascii?Q?otcrYy3bU1iOvkAlB7Cdl3tXtAUoquB1utmXYZgHXFOnHzkCMXBKBReok4Zd?=
 =?us-ascii?Q?1TytMZoFGpX0mXe5mIReA39oxrwKM48B6qBmsPQpEl99G05mhYOqG157Mbqz?=
 =?us-ascii?Q?2MpYk3Sk7esx4dkN71faDGLri+e9Idq6AABGHEGLvpItaVWBKlSfGE0lNm/I?=
 =?us-ascii?Q?b1wEOn9S7PYi9VsbT5H18aVLzgH4bG2pJS725XoGJfYt4E49oFlanedBR1z8?=
 =?us-ascii?Q?YranDE+6DQub1GNQNSI4LbF29l+gdszLqVGzx0xT925GJgyWfNdjOO1DvQTu?=
 =?us-ascii?Q?DQctb82Dq1iD9cIKooa4IE97RCEVTFXDoiIWxCV29x7z/arEUhNHrNZB93yd?=
 =?us-ascii?Q?kuIPjI0muM+W1LLgfxIDq+EyKrAhspZvLqRM3/6fgUWKKWhe/8sbFRnzduGD?=
 =?us-ascii?Q?YrfMiPoGtt4ZWAIaEPhT0kppM0vBb1XlBkUgqANjIaDBW0TcQ9bgCKkZBqXG?=
 =?us-ascii?Q?IFrd6EAOtDllv1RUVKj84Oq+z+esTRDTFm30xbpoxI9kp0w0+CskonnKksv9?=
 =?us-ascii?Q?7tDNhU7t1HT/D/hqyk03klG5UoiqAOmmdhDmeRVwfhp6xQtLZL2raf4qhMKo?=
 =?us-ascii?Q?EMopW5DHlbT/61+jTb2XV+CagPoEGdeMgj8hv/jdFE64UH4wuHQuICkecqvu?=
 =?us-ascii?Q?sny/i5mT27ApqOheGpwh/TIJiZyhyR6FtS3QwJvyuU/3x21oCRENvjw/GFfb?=
 =?us-ascii?Q?TNV2p6XCVBc9pE0yM8icXnCam2qUuq4hc+8CRyfAfRqOIKle+UyME7e2X9NY?=
 =?us-ascii?Q?jVnfleMtR77X6MJeLp9LYuuPbVlG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YC1kMODicilr5ZfP2dfT7csH6yRAG1UdSHwoX0oKnW2pVBoxR/Y4Y57uEzxN?=
 =?us-ascii?Q?a4W6ZTP6NGQUy/jNlEZ0fe0feV0IYNP4uJ9MEw14SCFQLsSMW62gEd8XxnQZ?=
 =?us-ascii?Q?6sqC9WD8HGd4TQzhxT92twpXZn1PZmimfYwPiGedbYqXFIt0khZXU38VjGUx?=
 =?us-ascii?Q?2ytksVMFZ4Sxhpz9/W/tXm5BY4eTkOPzRWIxYPA9T8bwHAHsXJkcMaJ94GFE?=
 =?us-ascii?Q?1c59QLPxnyoP3m1bQcPgUO/0Mv7g/c2BKaitt1/7wG74F0iesEBMMgsVYhh0?=
 =?us-ascii?Q?yXFhWRfH8W4kYpz2SHG8uTvLdd0a/E8UD4KXQEMQgT0EHvVgfsTelUoCF6FU?=
 =?us-ascii?Q?KAS9SVuIeejZsGAyDgFLSFLcxZdhKNdpJAhSJNlULs3nqWnZ+qV6MwfnnlCS?=
 =?us-ascii?Q?htNIUa5TpaSSbxtz3sV9pkTDzL6dGnOLXcqdhzwcVgzY4WeraYBGHRKpS1C0?=
 =?us-ascii?Q?oEEyxkW5xYe03qBy3cSvTyowluip4wOHdF0+Y5VOSPnfHfHszdI/d15NVOsh?=
 =?us-ascii?Q?t1OLzWxx3Qj7kD10EEWcnLH59jSuBx+YxQmImFOKU24+1/mo2KZGVr+Sqf3o?=
 =?us-ascii?Q?UQN6/AXiSAsrGHYX4P9CcGJCJ8E+D0YcMdcBx9pWhvIkSgrbUyBdiYsPh7cS?=
 =?us-ascii?Q?a+Uq3xyhZISMTy3SIrEHUlD1re91uo6lvvaCLX3uKSa4Q/jaFF4TlHu46AxV?=
 =?us-ascii?Q?/c7BmHgHXLOs/ibPlHlLCjZqN6u/zYXxwhlBQkLCqzzNClqMpEocU46wMqx1?=
 =?us-ascii?Q?MXH0q24zP8nzT0YClE8kWn1KEymQFWzbCAxC7xgqUMMtTSFsSyffVljg4gMz?=
 =?us-ascii?Q?CfshAqVX6SzUgtg5+grIwSvNW1L0i3wmmPju3D5AK72TfH2sCtfB/4dt3fXG?=
 =?us-ascii?Q?gY9ipculLSCNlnhn2uWiXmW37WXAFA0+SbJ5T7M4nQ4cqBNhFnq9CTkbVDRC?=
 =?us-ascii?Q?RLXxlVArQndFLXDHCMZa8NFpVmtyRhXhzf99VEXRalEZJW/Z5WR8/+kUymMS?=
 =?us-ascii?Q?q3TJFA9w2MgROm+rRhTKOVDkknmma3E0NbrHnFdr2IjqPAEPLcfLidqBGhnx?=
 =?us-ascii?Q?iUWFQHydjZX1E+rYe2Hn4CAdnu+6sPnXuuX0bJ7bSv3jCjNIyHD8DYH4LQRW?=
 =?us-ascii?Q?8edyYpbE37dMuaXs0lvmEy7R3RsIgaYKnB79VSUcc8AjjrdwAmbNXlx9eTYF?=
 =?us-ascii?Q?F4Igd6PKOx91jn/F9PbBWvy+fU3ItoAKpexKzPuZDg8e1tUCQQ5Tf8TZbRP/?=
 =?us-ascii?Q?mjDyYxjlELLRnU2iu2qYGRJ/2vUYIkgpJacmcHy+fkLOwjQltfcNiv4ATDGO?=
 =?us-ascii?Q?FCrfocPSA0tBU1P/Yo5f3xRXpKSvIdtmu4VnUl3lF6jbb02ND5BSeHnOtZzd?=
 =?us-ascii?Q?OPxNl3uHzTW85pLG7wdBleR4fnDJLSoeVtIFzDhKUEfDY33HhnbHSfmkvKgF?=
 =?us-ascii?Q?/3ft/hv2LboSLnmk9Ob9MsX8b4wpk8OzUh3HoAfCOiQauec+QknBGqQ2SzHV?=
 =?us-ascii?Q?i+KTVpzuPg4th2I1Ylleyd1y2oz17Uow8m8HwujVcOpjqTWg8fdlrY+WH0qa?=
 =?us-ascii?Q?YgQTm4ghcLVqEoIAuOrSeBHW5XIE/6j5DZzZvmW/hzs/tbv57obDgvnHC9/L?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 193504f0-8eb3-46d6-333d-08dd661b2da5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 12:48:27.3900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ONd8arVxxcHCReHsuU9OYn96QBb/JY78en6DkX6N8/pSdP/A9k2xwOvOgNCeLEM2QF9peSRpetvjFHE2HxoL6ousWCa+cvzYJgfa+NONHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8463
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

On Tue, Mar 18, 2025 at 12:35:01PM +0000, Medvedkin, Vladimir wrote:
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> 
> On 10/03/2025 13:11, Bruce Richardson wrote:
> > When registering interrupts, there was no check if the registration of
> > the interrupt succeeded. Add in such a check, and go to fallback path
> > if the check fails. This prevents errors on FreeBSD due to missed
> > admin queue messages.
> > 
> > Fixes: cd3b124955d4 ("net/iavf: enable interrupt polling")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >   drivers/net/intel/iavf/iavf_ethdev.c | 12 +++++-------
> >   1 file changed, 5 insertions(+), 7 deletions(-)
> > 
Series applied to dpdk-next-net-intel.

/Bruce
