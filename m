Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE2AC369DC
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 May 2025 14:09:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C606B402D3;
	Thu,  1 May 2025 16:09:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 33A8A402C5;
 Thu,  1 May 2025 16:09:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746108554; x=1777644554;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=pMvovF8HKPYMVcdopYoc2o2R2EBtD5fDb2zskcq7eYI=;
 b=QnFNIjs5S13SISgBJoHIoe4dyI7yhX+2vF7zf4vTtlqmL5pfN2vfLrhj
 EeMbfRbp4wF5o9aPT1SEw9Yg+i304pbgNj6mP0PqmjSsyD/x6bL7fYojg
 P73/Yp1FOltNmMqi5HfJX6bIMluwxhcLnwRfx1N9Gje1RrUIPMz2uwjY8
 4d2OHJ5gWws2wEf3ntGXlN+IH3sbspVW6S6BwrQqTuyM7pb/v6ifHBvch
 mJLRbydiQ0h0BXykMO7jv46+oKrmAVsxWDYRuxhehRqGJMdNdOfn47DNl
 AnDv4Tzgxt4CUGTCL2XSAOKiV3JBLRXB6tsaYS5tGQKYFT9OcL0OHZfAH w==;
X-CSE-ConnectionGUID: K9SMrIZrQjmqziz+XETong==
X-CSE-MsgGUID: tJFPJaFISGq7BaHF0BpEFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="47497887"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; d="scan'208";a="47497887"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2025 07:09:12 -0700
X-CSE-ConnectionGUID: njv5LCzDRCKeFNVp7SddYw==
X-CSE-MsgGUID: qKGC7buqTmG2OZsjhudDHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; d="scan'208";a="134341136"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2025 07:09:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 07:09:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 1 May 2025 07:09:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 1 May 2025 07:09:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYNanQhBIj7uCzCvaB49mB/C/Yp6yXTOc/MCBi3zhzKei7a+wErPGUs+MoSOGdQdxteCyk5tpu+oj383CKJg6Ziw5hhwf/uV6B9eyAC8WG3JV89DagRmEAmY2yVSiin4i6RlhoPWHz2qCZF3I7GhTiwpAhmHk/h2YR10qgyinik0TxAMbTPlwdSyWTG7ci3pYkFCRBx4kLFxEp4MXTp827rcUNUZ2ioF4tHNKy37ZU8Aq1GBbqErEX8EeliGyE+peZvcy07G5WEnXDmAHeTvfW+IxE2dZnhZvFjRIfr7WDumpGWNOEoz89XkZ5eHiDnFe9WGf0VO6OL8XwWt8Y88Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBJHJpnoEzYEH5J3J3yQl1e7Eoo1j6hoiWGYTCLvrjM=;
 b=JRwYvjj2wdtVr9tpDKwfNOjZHc112ORdkWIwYVFUtKsbnbCQ+mhJgyINAw1RftqqBw4XjzacExI4M5iY1qvfcZ8DAfzNItkSqN0yP47x3Z6/jse7tQuLitChjVBy+txxeA27iXYxc6PAKDocbaS/9foLJRm/2VR134G6acVDek/KHbrxgTAlG0+KFkyVg2riJjcaD4YFVvlVKHauPqq1FLksPuBxuBNpq6Vi7v9CGH3Dx5vg5NrmI98jAIqd3JE43G1Apg3LAAWLV11QhJ41cy98hUXtfIGmRgENUuPze1EA/auerVsggv/GGg3xIAhVLXaN7UWtknN+vqXSMtzaAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB9393.namprd11.prod.outlook.com (2603:10b6:208:569::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 1 May
 2025 14:08:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8699.012; Thu, 1 May 2025
 14:08:54 +0000
Date: Thu, 1 May 2025 15:08:50 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Xu, HailinX" <hailinx.xu@intel.com>
CC: "Deng, KaiwenX" <kaiwenx.deng@intel.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "stable@dpdk.org" <stable@dpdk.org>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, Wenzhuo Lu <wenzhuo.lu@intel.com>, Wei Zhao
 <wei.zhao1@intel.com>
Subject: Re: [PATCH] net/intel: enable ethertype filter for E610
Message-ID: <aBOAco9hqY6zSPzC@bricha3-mobl1.ger.corp.intel.com>
References: <20250423055339.79209-1-kaiwenx.deng@intel.com>
 <MW4PR11MB59122B51B4F90F9AE32E1A859F852@MW4PR11MB5912.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <MW4PR11MB59122B51B4F90F9AE32E1A859F852@MW4PR11MB5912.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0069.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB9393:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c0dab18-97e8-4284-f334-08dd88b9b50b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g5yk5JPj7BO4/deuHeBlMQVATz6y6jAPAP7DZBJjYfEaczVl3yFZRIRY14dZ?=
 =?us-ascii?Q?HEdWU9+XSL9GDCbVZW0WHxnqBwa0W5yAJ2vb+HHMZXefU+CjliCMub2+CEYc?=
 =?us-ascii?Q?P+NLGhedhnq3fSztPeLgyKaIC6a9nH/TXML5ncfOy6wE5iQGq4CTVPvv6iYR?=
 =?us-ascii?Q?ZdVE9jPf/7O5+hUMw8TzwEy0r61hsDFqFj/a7VDJdhaFhIIHbNCCsFx7UD4i?=
 =?us-ascii?Q?iwE0IzIzooelCykgYfRLfyjCYF8c8bmSBh0apEpKfHvSxEaIX7PuzzVF9y5x?=
 =?us-ascii?Q?HFKoSBmuoGSQtcuf1Zlky/4aLW7/nEg0fdRSlOPoZ8EzPsv68NRtJ7ZiW8sb?=
 =?us-ascii?Q?IoZ+3qSgboaOJhDXkp8xyCcFwELYvRVuasEUcS9lh34qfftiWYuv51rr6cKZ?=
 =?us-ascii?Q?3q0WPESGmZ59N6B8OnEe/3GeEiGNY3juvrjiEjlRA6MACp8OGxD4cl+VrHtT?=
 =?us-ascii?Q?ZfpE3NW0bnHygxXx8mKU3mEJ/DqNW8T1QVTb8IcCufBK9GhSTdNb4ayN28yT?=
 =?us-ascii?Q?8aUSu63MdjgoREVIqW1OquVAdjsYD2utEsAEncQS4YzRuzBg6ME27iR7V9pZ?=
 =?us-ascii?Q?ktcEWn34WJ/xAd+yq0u9Brf1aSXIOw9Ps6c42TqhdRNj5B2Ivzhzwq4obiga?=
 =?us-ascii?Q?OES/eZ80a2ET+6qLafyKFybw/OUzlsmMdpYegj63T2BRK3fVyb6qKFfXjr6c?=
 =?us-ascii?Q?MA0xN/HfBTZ6sYTZG/hx8yZMJS5rTfWbXR6aRSaAg7+fs7YkNdACzD7r4CWL?=
 =?us-ascii?Q?3Ut5MkUNpQk/FFrnxmu1AnADchCbsbCnIUQTVF3mYweb0hekIDZtMKKvihhk?=
 =?us-ascii?Q?xuilYHMSbUWuHRkpXs45U77vFSA0Ankns7tbwITmKKWty/apItsArCxEzJqN?=
 =?us-ascii?Q?7SX0Zz+ptimBMBny88gGDvjPN3CmMV9v46jyUdzrdA3MJGsGAnW5yoqlKvYZ?=
 =?us-ascii?Q?71fc9q6TpOuO7FvJ+Mjp5skYH6rJSwQLa9Fsx3u6VVkAPV/gZmF/ZFd1tSmS?=
 =?us-ascii?Q?br/SkTvMrrmMJ6T7NI+V08eVQ2XHSw/x9fBcHpp0edwA/pYoFoOTN+/zKJ69?=
 =?us-ascii?Q?zQtePC4/DT0/Klhqg4iYOIEvVfUR6giI0GQVp7uHAzlsy3oQ9/aEFcj+i0gU?=
 =?us-ascii?Q?jDHgj09Npl7/eDvBLKM2fuIB3lAg9p2mlbQjLlN93Yl5ZOfzUZz+nh4XXGOE?=
 =?us-ascii?Q?+Tz2a8Gu6Tvjf2bDt8hnomjcliJYD0tjfYYOcmEyaCX4BYBHjgr06wLtqb2m?=
 =?us-ascii?Q?Eyl2l2WkPuZy3EvPuubATsiQnrqbH/KEFkx2YZFy2mODPa4KI+z/qIk3crBV?=
 =?us-ascii?Q?Ybq6wtD0c7bUQok+4hcjH681RJ6M8Dy1Luvvo415WLhPu3N+V+Acp5Ws5sJa?=
 =?us-ascii?Q?nPkCFWDiqPRXk2Hh5YSHjp9vvUc08YWSdAgaA2VlQ2hQRbobRGV31gmgAw5F?=
 =?us-ascii?Q?acdH9cohX/o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KY4amBIGAW9pP5ba9y68JJcmLah2FulxGDI+THl4iHNbaG8zg9sOCSI4eT3C?=
 =?us-ascii?Q?f/6rM1E1rJDeeHcqyZpIhiAkssTNquq7GKgnmCfbvjKaf8AH+pqbivk33BLO?=
 =?us-ascii?Q?dhZ2vYX+czEmjJ2iXCphhtl8baJ5l17EzsRRdDm0lQ5gVf+msQRNSorKDVsO?=
 =?us-ascii?Q?gyK5+74CFbnHD3D4egAF0i/PrNzYk8GtNki/N87/TdmOb1fMsXVwKdtskmyl?=
 =?us-ascii?Q?+guR3Yx9uyJVg27mFy7kUbuRfZx3vjWxk5G02m0U9wSVcCTtHQ/yxMxGglbf?=
 =?us-ascii?Q?moNCecjJEUP/0QkH6hTrNWFEQnsPxdf0MFzVkythec0rkvVcE310iGoMQgZp?=
 =?us-ascii?Q?F4dVsrnhg17MOxKolIcZcrUdiUsB+2eId57NdQgZj1Ieusgs2qVK+wM8rz2K?=
 =?us-ascii?Q?xHhz4MPaUp/3vWlgk+A6CU6lgd1wwGnFjtpJDHe7qvbvwdCDRLM/ziHyj5BD?=
 =?us-ascii?Q?DzfkixUqwkfHHeC/QteNG43XAixlcVemPC74cHpdtio7u1wygxX6YGFggHUS?=
 =?us-ascii?Q?vrT9AUWqL3ximz9pWqL8MSMDqe38049IlLqXtiJJJ8u3TavQsGIdvAEkf8Zx?=
 =?us-ascii?Q?Q5DKERy2AikqGofuA7OoZHTAINALBHd/L0+qo+iaTw0sJvzU+F5a2Kv4i0sC?=
 =?us-ascii?Q?wd0jM3Y30uGLDmb3Fpl376rMbErjkDP0Wx4zEnkBlEUr/RtpfwiO+VdCOyMo?=
 =?us-ascii?Q?zD5je3Li0sZhsdOeG2OV3yeIfgmzll21DTYMrfdppi7gBU6kozEFG8X2RYmK?=
 =?us-ascii?Q?o1DJcX+/7DMqqaQavSZ7BW3cX7XIr8IM8giWBThVaNDIzeUaQTuEKxg3QoVJ?=
 =?us-ascii?Q?PkU50o884H0UtDVG+qBM8JLGwJSIrtxGIb+KLL9w8MxqnEzVLKWvsxng6UfO?=
 =?us-ascii?Q?8NNBKhV2Wyv79DzS7ADtpQ4oz0jj42mQ64bo6EyIQjucDWG/z3pL0dxqhAMo?=
 =?us-ascii?Q?bRKtvkyhPXixq6JpMFMJySoTvmvFyiphTBB3cejPU0J/DTap8y78zJQEJW9m?=
 =?us-ascii?Q?+KOX407NE5OrChXLqgSVC+8bJgFHHceHFWJslHX/yndx25DGUo8TqBGP2pFO?=
 =?us-ascii?Q?vyMoxTh1MrI/PP0591tTxwaG9ShWbCae5llxzUbr/dhSwmZfc19SMdGCYThD?=
 =?us-ascii?Q?+6APracBzxlCthSvEeM5ahb1uuW+3x0nOXnuTnsm3ingaK5acJrvtrAs5Rud?=
 =?us-ascii?Q?dsfpg2WCAp85JMHaX3A69K7dCmECDSblEQRH61xEcZlwiiUiz7q7khepAHwJ?=
 =?us-ascii?Q?Obbg5zADJxFlzMSxu9yjekzeSYNDCzqlvdi4yfdlqdnH+IpViMI4NeakDbs9?=
 =?us-ascii?Q?/G5B4HWDmMWVB6t29RTBa1dUI4f4x9JAItXzehst3qove9G4XBwOt3ts0ZWD?=
 =?us-ascii?Q?5h7knG3tEaFjnHf8+NYNLEJjMkDLdFMxslH+Sxj61j4U8nMtlA7e+GusH6tK?=
 =?us-ascii?Q?E+vUQppa4DS8/UHYaAPxwbMKUOvN9/AuU87W5ohwEgXQ9ddb+TfBXC5LNWb4?=
 =?us-ascii?Q?ykXQ5myqHVNmoISCHqvHubVaJ7jJusC8IyAi8bLR/97/zDij97Nh5+A8U2gA?=
 =?us-ascii?Q?oQCXsmuUGcHQoK4KK9RJmULXSOuN3nV8ocb4fhOGfYL+Lb4DGveq4ibje58A?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0dab18-97e8-4284-f334-08dd88b9b50b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 14:08:54.6067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGmCEYySmcnoUCCKlgXr0QA//6nYo/v6FyEywqNtEBpiU6f3wjMphGaLVxtELH60I+wcBhPIDI6/wYQT3T/6SIE/v0oFz6dHJ4jfRCnqJBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9393
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

On Thu, Apr 24, 2025 at 06:45:06AM +0000, Xu, HailinX wrote:
> > -----Original Message-----
> > From: Kaiwen Deng <kaiwenx.deng@intel.com>
> > Sent: Wednesday, April 23, 2025 1:54 PM
> > To: dev@dpdk.org
> > Cc: stable@dpdk.org; Deng, KaiwenX <kaiwenx.deng@intel.com>; Burakov,
> > Anatoly <anatoly.burakov@intel.com>; Medvedkin, Vladimir
> > <vladimir.medvedkin@intel.com>; Wenzhuo Lu <wenzhuo.lu@intel.com>; Wei
> > Zhao <wei.zhao1@intel.com>
> > Subject: [PATCH] net/intel: enable ethertype filter for E610
> > 
> > This commit adds the E610 MAC type to the filter support check.
> > 
> > Fixes: 962549bb27c7 ("net/ixgbe: move MAC type check macros")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Kaiwen Deng <kaiwenx.deng@intel.com>
> > ---
> Tested-by: Xu, HailinX <hailinx.xu@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce
