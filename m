Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D50C982D8
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 15:29:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1F024279C;
	Fri, 18 Sep 2026 17:29:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id A1A7C40285
 for <dev@dpdk.org>; Fri, 18 Sep 2026 17:29:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789745363; x=1821281363;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=7b4PgOYsERjOsuigNJF/MxMBgoTTa+dUqqvHH5dAISE=;
 b=kC0m+zzFBQNg/V4Mjvq5qpdnaBtWYyCgzDPjcjTKQg20rO2r3bl5U/wY
 ES8xgfXe80scg1F+w1S+BHT6fVH9VN80D+IV7eogIFqXhjtw5HqUksQQO
 p2gKs3DAe1NLMKM9lj1Lh2jpOhtqndOuCcs5ouYv63doswXvN+U2iqKhU
 wC81Fa/riStq8yP2fTFM+Rw0nnLDdqcTumXh5Hh6iaPnaEyXyBKb+bOVO
 2iB9sbuXE0IjTenbbiMmBeJpq++Iu1PpT9XLhrjQhUCO+AxkUa2lGTead
 EteRiR81EvNqT8fMb7CC9fWZnYlUhkGRWRMd5Cp6BPz5b8ZJnuwe38HD3 g==;
X-CSE-ConnectionGUID: e25eqkTZQ5iYRSfHYXh0eQ==
X-CSE-MsgGUID: 2VtdN9pHRgCvtnuqugDbxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="90126690"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="90126690"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 08:29:21 -0700
X-CSE-ConnectionGUID: HnNEHj//SKeeOVgAIcyySg==
X-CSE-MsgGUID: F/j/xUxxRHuT6PR8ZZsPHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2896060"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 08:29:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:29:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 08:29:16 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.58) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:29:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOlrS3YEi3BMkr6I655P5dFU45usCScBf9nwmPmX9f0YSbvRx0DfE3XhCOg+LUhZHHEkDsR0tGDGz5Ce537PWQZ1ftwpch3x23Q0Y64NFrNTehKoXuZTefxH7qTwvIrzoFarYQ+aLf45sdr6edULulfupWOJWtembdm/luuktmVKHOrLJQ6DCzckwUs3w8EjitjoQfmnzZN+FgL0SwYQBtonzBqlXQxGjVG+SYiBj9qhHI47jBOZ+2r27WDdwmBMa8t43WNAEbQIjSmjE0ycUAlj4CLRHbinLmJzDSMB3ODPwh8X14nR+r7BOX4JHVJPdpHTe3EBEcwvGi/rF+nOVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKv57G+TK5WWG+u18hKuwcn2zlyXXL3wRnggJdbAjE8=;
 b=yf0AhWj/OtcEs8E30/L0v9LF8Iwdx6jyIoNywBhn0mXdciIF7bNQhFoNiye+3mF3m770ZSVaQc6w1tiZ0tki01cfmurM1R+8J+NvXFXlYSH4mgJbdlynBtk8QSiJ4ENwXWEXOuq9P1oJsafHEmzhr5JzRBm1BM8O62PmEbcGcvgJX80RjYJ4ViSpXi1LEbjS42/2hPu+593vA+XOwNocykpoPJyOS6DB6ByHWcxbbIzHyuOfBGHqBKL99+/mxSW/kgJcF0eQzxm+ntj+teYDl4f1Ot8G/ocjGj0vAyKLZzX6qHEyK6hq0x7mUa3iLRK1Pof3kCfAwT4prezcadIVhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS0PR11MB7560.namprd11.prod.outlook.com (2603:10b6:8:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Fri, 18 Sep
 2026 15:29:08 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 15:29:08 +0000
Date: Fri, 18 Sep 2026 16:29:03 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Nicolas Chautru <nicolas.chautru@intel.com>
Subject: Re: [PATCH v2 1/9] bbdev: add per-queue statistics API
Message-ID: <aq1Yvzae51CiJ9MN@bricha3-mobl1.ger.corp.intel.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260723125559.3087579-1-david.marchand@redhat.com>
 <20260723125559.3087579-2-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260723125559.3087579-2-david.marchand@redhat.com>
X-ClientProxiedBy: DU7P195CA0015.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::33) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS0PR11MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: 93004812-42b7-45ff-e974-08df159994fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: loBN6XJKrSnG/RCXruknVPOW7XfEZR9ykrwr8eOY4ywVJJGGsn68DDd01y7QhzJVkkB0Bt0NRi8GfaTpy35kkmkBMcWrow/4ikS+aUTUfYLoD7d5Ca8WkmiUkOzKrDAS7L2UPLmogAK7R8QckAcpkQE77vDg6G+71QoKSjWr+LcfpwjxRIHXrfh1PRxNVBZn6yr9zGIRoBxVnSjGzqpGOYfLOiepGqsAzUq/nASKz0V0SWMs3v9lMYHNrht40CZv36/aHk+dAdM9puKIUyhoesM7hkRj1akPbaWWAz+DnFtD+rYDqjOetQVBU9kr8755EwAcffs4ncETpszuKWVwI0KfdNs2DkeXXk5LXucf1kh3WNm2oVq32tl1Qu1X9sOEUOeLP2guHxG1G2sCmhiXfRu9o2HusubSdDcPNFNdEdDl54nXabcAuKjSVFP0s8EmvEsXUnHRPUlaVscpUQz24jAeaYEAJJ9LzD3Kjs6e/0y42ZCItE/KYKgO5TGpUyRP2HZfhA9IzrTYHEJEYgRReCQOO0c7k8NcSUknaQC+jxYICgkKeVcteiCdXahsNe2ZXNSnkVCzc/zq3vPjbB4VE/2qLJGyLXEd/4nYWERm2DlXacxmsDYtidHXm41lgfOWEwMPBftYAKdvXH6HkSeXf/ylc3oaGxtBJd+eNCyECZ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p8RP2mw8MTo23i3BuFS4pswEHThUfnxqm0J1N5YFtBXL1voryF6m8V+YIWSt?=
 =?us-ascii?Q?syvhFvOR/T0PwE/bwHWXBpMc3oYgl/h0zUTyTjOO2m5nfJ2CYoPUMJEoRqiy?=
 =?us-ascii?Q?sy/fweKZCD3AVvYfYyfrmoXOFDqd0XZPFmYYG6+MTgQFB2fYj4fKiPNyqDSI?=
 =?us-ascii?Q?0uaDhhMYLizM51SJ+lwB3d9sssvwJe9QIjGcZYZ2o7fZlIlCAtjwqySNznP0?=
 =?us-ascii?Q?zbDiOLuAO9I0ZmBitfcTxOjo2LCoMYRKhBB+laEgYYAVd9Xfdn2dwzHzxszl?=
 =?us-ascii?Q?STRIAhcbvrw6Vq9cEqTyruHliPZmut6cFSMib53+/cl4WEHAr3kIFm5kVqmO?=
 =?us-ascii?Q?cm8cjCQ+9rnAVt69gOwlkgvnInmQJBSsO8hyGhODKOPxS57dPxcGOPS+K7Qv?=
 =?us-ascii?Q?4hUpVo4K8Hqs3wLuQA+ZfIbbW+pB51bucPabPbbW+RDcU5Ga/by6KrLJ+c/p?=
 =?us-ascii?Q?6RDPcZr/oBqYU3/KSMBMwTpWBk90+3bW01DqPuV8qfETyTJ+DG8FLX/9cGw9?=
 =?us-ascii?Q?vKgIPuGQH7mJa37R+H4nNVGXqwEkD0l6ae2un/OtPcwPvA3UW5IBIDMsSwCz?=
 =?us-ascii?Q?1DgE7Nqq3XwADXOcF5c80NtAWhTaRZYHKFN1nY4IeWl4zCdQFLnj3INmuZTL?=
 =?us-ascii?Q?HC8XW50l7n0nR/+LufjNWOsNKIsQ/yav22XNCgdnSyErR4Bg/wZrQcRwoZQO?=
 =?us-ascii?Q?YSrFjUOBWbHoFhITRP9WFf5FWhpWMKQTcLDd0tCVxQGWcOzHPPqo7YG7RyO0?=
 =?us-ascii?Q?yg9PS9HcYJ5T9aSCeXEd9fj5nPNpZNagaTt35utZSipplummuw9CvJj/yLDd?=
 =?us-ascii?Q?oeGu5I2fc7PraYuOJgRrBMvbkCmuouWQ2mULJG1R4wfg/QZuPgghh8EpnUbs?=
 =?us-ascii?Q?Q4LTTDyHvmK4LqSNHMPkfCfwLuRojzf+H0sak4Zyn4xxI1VQ26iwwlPMEbdk?=
 =?us-ascii?Q?HtVzoXS7U41fqYshlw0pi/9xTnXAfnRBm/ewNvqhjGs6c+zwLGojgHfIZvLe?=
 =?us-ascii?Q?bnPufdEBTLettOPTtb/9C6DKUt+d81iySL0ImIDYk1VpIFj3dTsNw+Z+r5Qc?=
 =?us-ascii?Q?gi/bOLfd6hGAnrGa8YfLhuLZQfMaOznR/y+yYXPhc4EhqDp+tvIUmgpXO16m?=
 =?us-ascii?Q?rF5PRyFfiRZPePYXVGTOTwsuCS+8YlOqZ3YPbZxlI52PveY9fPBu0YxoWdVs?=
 =?us-ascii?Q?Di111iFQqGpUK/XZDZIZcHpmvv+uIFfP8njhlh574i7dVQNc9XWGrQAqhOF2?=
 =?us-ascii?Q?jqx6KAsGLqK5G6Wfj5HCrvnMXEzygwGX/hwgRy4csIhm8MXXEXLjYm3F0lNx?=
 =?us-ascii?Q?ldso6c2TkfCSx9B4u5Zuu4mJ1w33csRqzGfQFSLQoVdA+0A9vkyrKl6wvKQm?=
 =?us-ascii?Q?13PVLdSrkgnJ3hWyezlq5Eh6/hu6gJHesliVYtkU+8ZWSiK6eIsYCsdIIIO9?=
 =?us-ascii?Q?tr3rCeIILtFxGO4hpKwa269afjLBRq9Awmdl0j6Q5eXqAF7I8fcX7hX/SXj/?=
 =?us-ascii?Q?0SoxmEhAiAI9VR7D8ApjR/1Y4xiovqoUKOiMTg8LB2qibwYzN983Q7j2ovyY?=
 =?us-ascii?Q?7tPUwZ3QjMDe3Z2K3TsRsLzdx23De7QXkp4eEPz4U0SACPE8RU5u3aJ//eIH?=
 =?us-ascii?Q?RTjV93VyuJO48C2PM+wFOKFWVp90HALZcPnBpdygHlj9cC8FqVGd8CKXJWVG?=
 =?us-ascii?Q?gOctrW02ePJ2kSlLQtFeckQrfiQxyj78oJMeCi9aPWkZiPn2+AGez7klLh5s?=
 =?us-ascii?Q?4KpgzeOrxDpxWfy3S4UuYdNZsKL/yjs=3D?=
X-Exchange-RoutingPolicyChecked: EqwZ5bD/xFIdB3d+RC+Qj2vDZbJBzIT7F48/Eu343S4A9ZhnfjCY3AkagkObk4xoeJIVh+g2ndqB82FCNTZxdEdaMQvUSzQBZLlmTecHS67sCGO+9BsUQzF9Uw2AMRyNTvR62wqp7O29PmjwQLgpqFZUav5XzchRzJ6dfcG89sRlmG4stnIpAACHvOKCOA6pG8UveQkjzZ+bn1Nh03bv6R2y6MwRK9+rF23jDFhYEwz00zU3F2ngW5UwNHt0F4TcPbwIsoIYbBM2s6TH20/qY8iqOfoDsdfh8w6C2xJy4+r+Xxkmbk4t4dRYWGorNHH0QpVpS4isjg0KHkwQixcs1g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 93004812-42b7-45ff-e974-08df159994fc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 15:29:08.5748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUS7a7FA4s9EWUhE5X2wP2cRll0uDcZQOm11fIUNIsvXPoRD1vVZAUbkHjsL6dADPzHoS5j8Iy8p0kgqQBCSlCQ8FkH+LdIr5osy7cinNSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7560
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

On Thu, Jul 23, 2026 at 02:55:50PM +0200, David Marchand wrote:
> Add rte_bbdev_queue_stats_get() to retrieve statistics for a specific
> queue. This allows applications to get per-queue stats without
> accessing internal data structures.
> 
> Update test-bbdev to use the new API.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Seems entirely reasonable. Code looks ok to me too.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

