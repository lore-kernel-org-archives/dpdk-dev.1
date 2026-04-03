Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960E1E7E36B
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 10:37:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CCC640296;
	Fri,  3 Apr 2026 12:37:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 51E224028B
 for <dev@dpdk.org>; Fri,  3 Apr 2026 12:37:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775212654; x=1806748654;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=G0GiXKs8hFSyWBunLdua7OQEdG7d2hsqLucVd6X7iO0=;
 b=aa93d9x+5u7wiV/PMUCDSdMsB1kNlst3jtr4RgJGbmziOTIjIFLfkVks
 QmWVD5GeN46SNe6ngIt/z8ZjP3rgxTli54IftrjHYWujMw+l+ED9+uu6e
 DSOY+E6UgOeFvR0R3wOVqgAAy4axUNsjPHKp8r8oifQ3YCRjbUhWt/u6Y
 Npti6U9/KMjN31LhZNjIFhgoqcBJFP69LTxrDU791tQwaiqq/WzuqLZpg
 Ucf1MxpCm7jIw9XlaTulV0hYNo9CMGzuqApnhYveKCy7s53reZo45hMIx
 RN2Q4v15F2Yx6wv2xDppAw/W5r+KQcyxN2W8fzzXgfg+sS/Dwmg2KYgn9 g==;
X-CSE-ConnectionGUID: fxTM7aizTP2C3dUqVQXvVw==
X-CSE-MsgGUID: D7ExJzMpS9CzxSdM3UOIWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="78870674"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="78870674"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 03:37:32 -0700
X-CSE-ConnectionGUID: CS9VXx9tQaGzs0S1i+WMrw==
X-CSE-MsgGUID: fbnc2H7OQ3y1mCm3dNz5DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="250308000"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 03:37:32 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 03:37:31 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 03:37:31 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 03:37:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3y/neHUt2YhLB35/074dNZVyEEPe9UpwD6vwZ04YThND+tx0JQPLlh2/pi1jX7xG7AnXdAdcXSm+BwKeZ019ZKbxYPWZIBrVP6mK0AoqtdiXfIVief1O78o8Fz+saO0IxBwUCajzFLgvPGysWTgyntPbfpqdtyl8VeXDtXjAyc79+862RqqGymc6riC+yqWIYkoeg2WJUKaRs9w/RRsoTtjffABcTWtktaHbiebefIEJz1aRMnslMka6z9p7XzSR70ZsCSlMETqcCQ9RwXFfXBrFZuSV+Mq5YuQnWkS2cZ841LJBRh8Oo366+WUlRsPvBghhnYckQnV+dZCXtxEug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMoDQ7gTSNyqBnQvaRN2ptM5U6B4HYnnaOK504nTGGM=;
 b=b3fvCZZi68saVhGvo2w8WiINDMtjJUQL5cQobJeStukFHMIH6o8Y0DqHGuxW1NUvhI4mMCbTejkDdqs3PH0/jiszSebTcRwtku8djfsVYtj0baKgGSCr5Hrp2PoAz2d+F4IezuRtf4GGeIaSAzzfE8V86o02Qgj9aJfq3PGl3tHtHHGdaL+KklhoK6WVuhUioHymEW/cv9pvxCIu9EOI+CQbQSNU6clz1mg173i9mNIJhswaDU4Uat8AB0wtcyAo6U4d2iJjcQv/RteSr70gDRrcb7TZdRlcNPvOB98wi86CCwpsY7jQV5z1p70uMaFyTp+Q+sS00cUmshWio7jrpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB6290.namprd11.prod.outlook.com (2603:10b6:208:3e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 10:37:28 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 10:37:28 +0000
Date: Fri, 3 Apr 2026 11:37:23 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 1/8] net/iavf: avoid passing around pointers
Message-ID: <ac-YY9C6usJgkaYc@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1772794442.git.anatoly.burakov@intel.com>
 <cover.1772794442.git.anatoly.burakov@intel.com>
 <6aa2ba5f52bef763fab2923f4b74757230c41376.1772794442.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6aa2ba5f52bef763fab2923f4b74757230c41376.1772794442.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0229.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 2483d039-b2f1-488b-6a1d-08de916d00c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: BgC1DJx3flD8lPFT9oanN8Oaja6OV0Z+Smrdz8XMh7xVrW3xZUIiw331vMRd7Pa1OECk+beArcT/XfDerVRNF8P3TXsdFaI4p5Kb7Kc5aegATdNzJceNN36NKWmDinNBX6KswQwpjmCJEKLg00qAmREGmYbPaokt153XLNY2Qxj049jsIPJkNns7F0rcD1oniY3SJHOCeD/sDqXapySGBJicCSydZTXwd6QyVfUt/Pc7k8OgOvVNl2ut+ynQLQ34EyUne5KE7aW3S4//0VzjnAWQtHA9hJ026Gd66GviGJmKNjylKNubtsLCPOlhpGjU4ANBhqEPz56zx/dTZJ9cDGEuSNqBObvHZanTJxPzlPYc2ngbadLIsXbhljQH7YMeBFMt5G1fJ2rP0L/m/3yb6UF76C9nGblzu04tnxLIDdHZbNIxvQLjv6/4ncow+/0AsxiShjgfvUscCOsYnYEU5JQbj6s4MmokHVx9K4e3Azr+qYF9jxsynJHmsmEJA1HzTDJZmW+BBW82yGFGT0UaXIW7Eadc1rA20njYfD7MDDpuGNBzpD4QsLwbMWLnUKysS+bQkr/3h9MmpuL2nwoT4v6FalL+Q/09Y9sdxen7S5E02/yWYAKOEvvNIZDqJrOPR9nbjSvU0HuCtcECUMmbvvB3/fhR/NjAnGHtooLZt1onh3xJUj9s/RXM6zRQH5Jma71usHaR0Aq9Wa6MzId0XmCQ+blm2QFkEsTaoUVFNbo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jX6D1NSPC8bZj3wzwux+63PXWAwFs3NuUhRP5FzNurf2WgZV4bKNFXYfDljP?=
 =?us-ascii?Q?504Ld2TOLvWaxyqSSum6FuM2Oy2834DBvvWz5aJdKlUKi5YGjLGK62jwrxXH?=
 =?us-ascii?Q?ADoRivQ4r+FEpRaIkzm6nqB/NDU3v9E90rKEzP+m1R76Fz6peO4ZNiqKGFti?=
 =?us-ascii?Q?3Fbo5627QMepCI5hZG/aO2NWJae9im5c+5exadze3U+TvGKdzwq4Pa9ban+y?=
 =?us-ascii?Q?Ag5um8YdlJ/uFqjMz5tAmZ6/kROp+VJK94MikaIGV086owTnbSKGVz5YpzTK?=
 =?us-ascii?Q?H5zwS+kYXEb68O4Qxdkvyfk6Y85jb/oerbbGYnKdwr5FPqR1vOE2UwFX76b4?=
 =?us-ascii?Q?1NEG9tGTqYAgOCb32kVX0K3Lb+BpKKLTJuEZAHCQcaJ8kTOuhrWm7cCryras?=
 =?us-ascii?Q?lPCs2mWOrv0GiL6HL7pEUrpXQh2pkRXU8JwB+DMOXFtmzsw6CaFldxjnjOJN?=
 =?us-ascii?Q?VPcYB6TGToCrYOIp9hblQoiEOyNpfVYHb/lHZxCLLktqjGwNvmVXmzJVoT47?=
 =?us-ascii?Q?3uzz0ga60Zvklys4FpZFF+jcLvQbisF4HR90aAlRNwaMSpTxUZFYKO1sVSsZ?=
 =?us-ascii?Q?VG3YWChH2I/gc2yKk9DJB0ugF5d2JO0qIQtcoCQqqNid+sGeyedv8hf16xsY?=
 =?us-ascii?Q?NY/Eyvz/aUtQSSqYyY7YVqXgu2hl09RQDxcOXrlsZB8pWD4Gs4+VEXXmNMND?=
 =?us-ascii?Q?C2mADPV18oRycvNKQnYcNOSuK+sIVRXrI+zuvKZ/hOQLm4fHCg4vls0doZMt?=
 =?us-ascii?Q?yRT8AhabEcngFMgqCWDhXvIeLdgquQ0BOLYOaZd4W/GWzB3yorpv+v14d9w2?=
 =?us-ascii?Q?ix4zaylwpnQ26Z70+eGNUCZhaq7rPmJN19xCVZPyKP4I/mQWHVRWyXxhvAPd?=
 =?us-ascii?Q?bQ/BKmmLSEoyrLOgzuAIwyBAr4uL+5BiE80xPsIy7nM/p8LXobCiCfZCWqJt?=
 =?us-ascii?Q?gBj3mx6/W17lSB8Jwfap7h3H9HhnYHxJv7EQzQAFCLE/UfdEY1pjVfSctJoG?=
 =?us-ascii?Q?2i/H3UaD79kOKrv00t55gFenvm6oSwOmAuNyCG3SOI4VA4XV1lA5/Cn8gY3w?=
 =?us-ascii?Q?GROYbnIDFL7aCOrA1Rw8CfIlHogBczYz+8XmSW5Nu8BjmPX72i2Fks0ZNNEE?=
 =?us-ascii?Q?A50/TF0B5zfIUVdm1MRTbwY+ldCjlCMin5P9mMdOA1so6E3lOqaidQMTROUS?=
 =?us-ascii?Q?ZrmJ4PqDSH31FtL4WoTLLOy7L0XSMAVLVsyJTuocnWiEcM3DEwg0EScb3RPU?=
 =?us-ascii?Q?WD/GmPrkDK63vPcantO7n99WmzeqBEIHEuoIzBU5PR0SMDxjEshtTXv+KfCu?=
 =?us-ascii?Q?UhgEv211vaPlqLfuFjf1NhDABH6UgXE4iwStyHx+9JtkZUI04M3/3cKWK8vo?=
 =?us-ascii?Q?Z2c8MZClDNB1gUR7LPe1kwLLq1KhMNVa2ADFFoOC6ZTfOer2ylHBJfE2s6cQ?=
 =?us-ascii?Q?LLC3BSsG0obnndTdwfvHdz9RZ9OXriiUy8OBqJNG/rEovYmGPMYXN95oCIs0?=
 =?us-ascii?Q?YzU6Sl01uZfl9Fy2TolJg5XpGt4zoGntNqZ4b+Bwu4CfYqNLR4OpHtKlM36E?=
 =?us-ascii?Q?XYVpqqrkqFUv2XqIG4Hnr/o1qKk0KeKKVnyKPSHS6OFputXS9+8COck9EgqL?=
 =?us-ascii?Q?+B8jmT8BzCe1t5wvOlNR8n++q+XWhndD9p9VWOjBzV448mrzHurlzrgtUWZg?=
 =?us-ascii?Q?7eVK51UznAHqT55zEXVTW4irlFBGKfn6RebgncUe2on4aIp5bzK0dY4rBp2C?=
 =?us-ascii?Q?XC78/dJjZAGI4SJCywqXMM6B/yZpVjI=3D?=
X-Exchange-RoutingPolicyChecked: o1Jn91kixjxjouKhlACPu0KFL+dgHjm4bpzilF03xosf0V2TqQMvDj5vFuExp9prKavmdozYGHhrZBtyJVjFYzGVUj272dbtA9pDMuqy6p55pLt9G6flINywOez21bvo9d/tzswAIcl1joAX6N7FtZeLi5Pyw/u2ax82IwADkShlvQ8Bor+A7jLR318p+qNon38qn0JYYiBQWkRSjlFD2zj0XZ90Rq+mB2uZMzILR+ikYCx9xXn1mflYkxfch2vgPKg6bmavgja7dZCYgTYbyMjqbpygXsNjEEKskmvz5Z7VmKAs/1rJ1BceifoURURhHcrOv3yd8WREU8O+VJWpSg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2483d039-b2f1-488b-6a1d-08de916d00c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 10:37:28.6181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ndP4d6ZU6U/J0kuRED1WK2i8orKLRmDvKffOJ602AXSoYFaFEp91OdxhZO4iboRAPAu58XMFlTZrLHzQ0E/KiKKp97izqzYqMKIZ/Jn2Mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6290
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

On Fri, Mar 06, 2026 at 10:58:17AM +0000, Anatoly Burakov wrote:
> Currently, when querying the stats for IAVF, we pass a pointer-to-pointer
> and then use it as an input for another function. It does not really need
> to be a pointer because it is populated from virtchnl command response
> anyway. Replace it with passing in a stack-allocated struct, and pass it
> into the stats query function.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

