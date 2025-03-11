Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E785C282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 11:29:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2907D4027F;
	Tue, 11 Mar 2025 12:29:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 63A5740263;
 Tue, 11 Mar 2025 12:28:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741692538; x=1773228538;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0WHuIujq4PIbEVdpdZvINcg3mG7N/ejxpTMVsuuIMqk=;
 b=IQeG/2HO+r6W2msWIL1wZ8pujYLDHJO0AOU+pPOhGdQgHr8St3puOc9W
 elokKic6BAwQy3MvPQ18GKLmXW5CDjX26I96UbUe2Qg9kS7U3FgwkVJRT
 QtQGyLHEEbNXYUX3vjE+zWnx5LgMq8icJ5WkhtTQDmV5HsQy6sei3WxhV
 MzfleYLQIUVwCSy4rI1ZdjBsQaD9+pP3ljfPu2RvPdvnulIiBJRSDr9Bz
 JtKg6egmOp28hsgVTbtCZPqXKzxUcav+nmpwQxoJ+MlOjUZ3zCVbkmtzt
 CmzgFpYvj3ibEFgCRpgvSO+4v4mENHmj+6a3KNSFLCHFeKoxwoCxslFD2 g==;
X-CSE-ConnectionGUID: PsQeiw29Q72AwCqyUwrkjQ==
X-CSE-MsgGUID: aWWDIbblQK2mELnkVaR1Xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="53351610"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; d="scan'208";a="53351610"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2025 04:28:57 -0700
X-CSE-ConnectionGUID: cn/4Al5LQK2s0rB020X5AQ==
X-CSE-MsgGUID: sVVKgwUBSEKllLknxTEPaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; d="scan'208";a="121001406"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2025 04:28:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 04:28:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 04:28:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 04:28:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BT6qiMiLc18cm3/Plu4FHeqp4zB3JrJyFY+SxFD6cHJs+G4kA3ezIcvvYQdaLd6YmoEwpwgtU7sMwa04yIMSaC6eIGkpVlINuPMjOWFLTJzI6MAl6i86BSCPVINJmcZ3WNKZTXy8bZn5B+wFj8xlz7tXce54kCdOY5kIqpPI1keL+5q2kwaNYy4Zw6jPxKYJNz8D7lFMV47lzIqBQ0Hu7yTo8/A81syyRgV4QltHq6XSzBwYLna5rjOuPPxLGipNiVo3PPLkIcXMJpQRDUoQnEIVQhQpvpnhthYFSkrcJOK0uUdzXm12YU63aEX2li9bqA+PFezap23AydVECgxZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wp7nxFh36Iwm/2zDA0safJNMeiBovDw/pz0+HxRFoHA=;
 b=Kk9TKdYDtIdNCHUhrs28C0O4MRBWDkD3X0BrbIrDryBdCnlPC465EMZ8p72X2bXuUhApmR1Z+6+qRsn6i3n3yoxk09Dc5Iwwa834JUSppq0JUxl7vQEZIvKkO81m0GcjdglolcbmHFHANc2QyD4d3aOQe6g2T+UyvpR67FvOk7ENh5aO5MoUrZlqLcehuvKYFaX+b4Yn6ATHeCZScFwFXsjnfeGn5EIPXphEiVFGzkrXgO8NZPazuXoVP4sBBGdPLqeqn7/67T1jJHiEbM1Jd0ADcs6U7CmDLlAm8Tw5yK3RqXr+gu6iYCBUDBrxD1UznrDI90eUaYeeRXLTK9Gs+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB8303.namprd11.prod.outlook.com (2603:10b6:208:487::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 11:28:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 11:28:54 +0000
Date: Tue, 11 Mar 2025 11:28:48 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2] net/ice: fix flow engines order
Message-ID: <Z9AecBquS7anJ-sH@bricha3-mobl1.ger.corp.intel.com>
References: <20250301205327.569853-1-vladimir.medvedkin@intel.com>
 <20250310174028.876789-1-vladimir.medvedkin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250310174028.876789-1-vladimir.medvedkin@intel.com>
X-ClientProxiedBy: DU2PR04CA0276.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb77293-71e2-4fce-7be8-08dd608fe7a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XncwtV3q9e3W3rG8BzVH1vmb64h5aVPYa2xeDQ3G/5n/w5FLzS7DFTN50XTa?=
 =?us-ascii?Q?fIbUkTClVKI+j3HVqNpGuUjLSZuFwvS1uShJ1l0jDGTqc59/F8/DDW2mURss?=
 =?us-ascii?Q?8krXRMldga4prEk5PUeyUzWeX9ra+6z/rgzB2jT8GOB6VTaP+Wydm0bRUkfl?=
 =?us-ascii?Q?1gSeKBtZzxbOSnhpv8rlC9AyxzWdbaM3weY+cYWRnMZTl8fHabOYXvA7le+X?=
 =?us-ascii?Q?thO92WdAHJqJqm9F8hSJO3RgRICrOAj2yMJWAFh2HEJOBJZLypK8GkjBj2f1?=
 =?us-ascii?Q?m1032FMmCrUEMPKywaxrysJE69QK3oHvtz1NiMDxx9CgIWo6RktPNwzPHL+m?=
 =?us-ascii?Q?66Xo8DlzVPb0+RyVmc+eAEhhC/VayKNhOeZmD2mCXyktHsbFJ1RAy+yNpa52?=
 =?us-ascii?Q?Z5rWOHWAHd0sv8jwabonBoR7QVzXez52eyXRqU5hP5C8A/xMy0hD3g4J7N3e?=
 =?us-ascii?Q?vBVjvWH5RsBbCnTwCutqDkusSRp3p4+uyo3StjbqYf+4hObZDaz4+Ni2gwhv?=
 =?us-ascii?Q?7DJdcCC3SrXVDCmXrP9mq76bEo0fHkM3pDrqoNzIycUgre6oJpeznviZB3I4?=
 =?us-ascii?Q?fIWts/cTZGR1KHKQ/zzz4zHyOVL/VcGA8WFZHzXZbpZH6EgZqFd7CJKRZSXA?=
 =?us-ascii?Q?s4863qmZuZoU/GE910AWrUqe/Ik357ZspuwjmUWzOZ67ZBR+WnT0MvAxHOnY?=
 =?us-ascii?Q?WhcdOl42H3w/n4d16ftvhqUIEHBvRZM8iiD+AVHB7uR9DUc5udDOvW2tWtUZ?=
 =?us-ascii?Q?H8yWgJd6uUqVVRvH0dWqe39DXuLD8xXnOBqAJTo6XGrwNtzNsuGBxm0KSSjE?=
 =?us-ascii?Q?6m5qD4F/q1I8DQNVVEuasVtWZSLQzdYTptUiu76BEickMxD2bOq853a5NkgY?=
 =?us-ascii?Q?PbOxkh628+THvb1vOmhe1QSv9MpKtPSzZVGGFmh5z1LU2Hm9GZwjrO2LZlXW?=
 =?us-ascii?Q?UN8NW8oEhZ/hz8MXQFE3zzfaINCz9JiGmKTfluTTFW0eLPy4sDplgX/WW2Gb?=
 =?us-ascii?Q?+Ei4XSc0Apdv0NJigQLU7VgZrnY5VqmUJCyhp2UOGeIzW5eC5xChI20nqSA4?=
 =?us-ascii?Q?knBRyu1UwsKGmV1D8zUOB1dSioZ0Wu3KcluqyY2q/q1jBYd/5YTsCsdKp5wP?=
 =?us-ascii?Q?RkcthuGAwU/RbCi626xyxL+lMERG/toffaXGF3g4s1MIhqgN/Hkuc2C7yBkA?=
 =?us-ascii?Q?4Iv69hD107eTDYixSe0nsiqYoIcmD9GeWxCIKDd6j/qhZ4F1GcjnCywUn8zj?=
 =?us-ascii?Q?MdPQI//jcl5v67d/FW9gPcxRYqtQR5MQ98H/XEtNyuyOU/e+GAZ4KtmpQTCg?=
 =?us-ascii?Q?ZtNxXbSOdLo/L7PSK88YjQxTbvUoM+1uk3Hehf1dvqrkK6FzuWhCpBGTFo3l?=
 =?us-ascii?Q?idb+AfdquX5Mo0+QsHr+WisGj3WA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8cHkvVjlLNBriCoKYAZkRijHtnJlzOfEpu88hnJxe/znWuYFR1O9MyuEBqyo?=
 =?us-ascii?Q?lMdC70xV13IhFDg2NDzuxm6Dy4HZiJpJJo9gR8wqDSHe68AgRyeMaJvp8LgQ?=
 =?us-ascii?Q?+6LCJvv+a0ILb0ssgihdcmsNxwW/KXPPBnHUeJFao/Xj6gq+xu319OwxvBvY?=
 =?us-ascii?Q?qOinWYIzZonNkeJXfp91kWzfQj1NPrJg+AZJzzAjo7sGBz/pnKJnj6i24AWy?=
 =?us-ascii?Q?Clel17iywZdmxPrZg2bXO/gArcPqa8iZDzAKImsHcLbR/w9HBtA/72kbTk9O?=
 =?us-ascii?Q?K9keZgEVpa9pR2x2hpw2OSVCoTVXZeigN4uBVrEGnIZMB3cV1i96CoKJdpjc?=
 =?us-ascii?Q?/B313CckQJIY0Z17Bh1zSI9v0jyXp/MdGPWwMiaWo9X9SgFE4rsl4tVzheCx?=
 =?us-ascii?Q?KDJEFa8ybS8lVfLo2CsupqL87uWhnSWPgyIZf63viSpLQYsq2xdKRyTPZpyw?=
 =?us-ascii?Q?bXdWDiXybXdpr4IqHlN/BO0eVunGM1UHkWSZ6gTFCLn/V5v7zkn1IIEpBK19?=
 =?us-ascii?Q?hLhr6/+zyGXRz4F4J7VLJIrPxHOlRaYpY2ldm0ASnkEmmA7tHiUqcWiHzgYX?=
 =?us-ascii?Q?oNqLr9jXsxfltirtxyUtBjWg90ce/kRZ7tojKGhATbbRoRzhcUkJ6jCEyOW2?=
 =?us-ascii?Q?XJAQ3VRgPCOPdzhxjwyMKg/6dbrhSxhYoEuxKd6jp62CeEc9uxTus7dwB1Nc?=
 =?us-ascii?Q?Az1gXcG8uyRXFdnKBI0V5vgsbV90+/4sExhkYaNFFEeiPepFlpye5NnBzrSO?=
 =?us-ascii?Q?BFFbTxCXrY+bMv5DfEZvvDW7aFlBEM77y9A7ZPEcYP8lc7fAUd8t7eViZO6M?=
 =?us-ascii?Q?4NOvDka6SThDwcNe3H1TsEhMJ3sq1DFqpxF1s8SpbvecM4uVpFmY5MS2Wbub?=
 =?us-ascii?Q?Ohly2V/O2B9pk5ooLqlR7+wxmqXRDlo4Xhs/d0l2fwpzbplWzdCdwudT+/mm?=
 =?us-ascii?Q?CRh2TK2k37Ihy0Tm2gxDdHAlwqJYDbR7J2cgNDbmyf8Ozwm5cmwFDmTSHGId?=
 =?us-ascii?Q?pETLXVXIc6JQmOO1bM8UvsVHxnvO9AczlIlrtepEA3XxE6ov2qi4iSNHfbM1?=
 =?us-ascii?Q?NbrYt1Kela/9nmpllJ72XCVDjsKmvJdYXm3YQz/x7H4mSWdssoiEDkL3GXED?=
 =?us-ascii?Q?rIwb6Kc/m5m9MmnwpOlDIj0HXULt8ksOj3dA5MFO9SNYmSPpqIiLfhgqFNaz?=
 =?us-ascii?Q?Ipz6lFw5wFeG86tvuS8XkRKDThG/PBNb4eteGFLgb9Hlc+uu1x4yY36Hp2Wy?=
 =?us-ascii?Q?mqbFgrgmYcIbiZxwjURcgJw9moso8OI5M7DORccSS1HC1nQcAeZDh49oZomY?=
 =?us-ascii?Q?tJeMLkDHvXBNoQxiOrUQ4QAPmAhb6NnjmSZcWAbtYt2ujpobB4qWgBUxitzc?=
 =?us-ascii?Q?Co+uMMzUUSsksGQIbsWWgMPd5DeHQSoqVd0/Kl1UUVrZG0qFVrtZrgRYnTQA?=
 =?us-ascii?Q?Ki1tKKw7/62Oo2cPBbyMCxaYF/AX6RA9DtuJHaRks5BbYpW+uN2I14lBcP0V?=
 =?us-ascii?Q?zxKi3EjF7f8jYv0KYXuLE+su8aisqaQtnPXDca8MmY6X1zSNlxIna3TJ+3RT?=
 =?us-ascii?Q?5mRG0nSK1X8cnlxqeLvcU55DHEBiVdBRqEleeD7DbCsaOa4Ai3AkSBFL0f9e?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb77293-71e2-4fce-7be8-08dd608fe7a3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 11:28:54.0662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hc2fE/rCqgPFKvSBaooaTOTrz0dISGOYwFYQ3MuEXcE1IGPNRTl/AeG0miuLuoTdOSHWG3Fhsw+6c+E9V7JojPVXlCLGvRVl45Ac9nd50EI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8303
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

On Mon, Mar 10, 2025 at 05:40:28PM +0000, Vladimir Medvedkin wrote:
> Reorder flow engine evaluation for RTE flow rule installation.
> Currently, the driver evaluates rules with engines in the order they are
> executed in the hardware. However, in this situation, some wildcarded flows
> that are also supported by the ACL engine are installed as switch engine
> rules, which scales poorly with each distinct wildcard mask configuration.
> 
> Fixes: fabc9e1322e2 ("net/ice: fix flows handling")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel,

Thanks,
/Bruce
