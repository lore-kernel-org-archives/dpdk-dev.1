Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1863C83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 13:06:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 008914069F;
	Fri, 18 Jul 2025 15:06:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 395B54014F
 for <dev@dpdk.org>; Fri, 18 Jul 2025 15:06:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752843963; x=1784379963;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=qETsomAq7Wc5G4Un4ByPRbGc9dYxOgfqadBFt/P+NQ0=;
 b=lUI0d7LXFTu78HGtIH7Ljgr/VpBXlDxFTYYJWSfaaJNjv6pLsc1Ka3EY
 nxYtrHBIHplvXtNUK+Un10wiskB7q2LbupGwLIuhmZ+YlHZ+79CJrHj/O
 7gqzX4d+rPMDxRRTL1TgLmyWQLvYq5f0W6HIUlsxHb2eVhmD4JK1M8HtF
 Y3JiF5HsrlMuCQ6ZAVzW67JSYXv4wXrQ4T+XEsB+JVv+KuIeAHu0L3cp7
 jCLtxrXZyNJSDlLuNpNn65sc/p6mcQe4ojLWjwNAIk912wq+ETmzIRkie
 AwbZ4hEh5jxi8oHiQ0PY632kqtAiqt6B9PuLKFzZW54xGy4LrogXrMJhp Q==;
X-CSE-ConnectionGUID: GDhOOFtdRv+tVkzOJsUxRw==
X-CSE-MsgGUID: j8WeHzPzSNyrH4Ao1oMPpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="54850109"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="54850109"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 06:06:02 -0700
X-CSE-ConnectionGUID: sN1ZzrMEQHWPWZ3rZSqvUQ==
X-CSE-MsgGUID: MefzNRQ/T624ZK7CgLa9dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="158407808"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 06:06:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 06:06:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 06:06:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.73) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 18 Jul 2025 06:06:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bb4clVMerzBR5aC3mR8LNSAmrgImLIcdWVjzaHlNZ72/yUvSo4RPrzfTvEeFVFMWzzQjYHup9kVjnsitoyz7VVVP9Ea20RwC9lBZmAvFwGBkJp73BiruX73oET8MiIOj3l38qxxklr85s7VNNgyAW9GT9R0Hl7nOwcyurB3TcLu5iN5S/nzHej+Z3u9e3xuVucur2ll09AGbTFQSmgQ1ZBNBHG6jJsq4Rw3lO6mGrs6L2ZHgaL+9gvgegscKlTE+/Jht1OBfmBWHzLmdPIZQgqSOSqvqQSNpXJ0nrwXbasHYmm5rnpUJ2rx1O3aG1gDohpTTGGiilZZD+YrLaI09TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32SgmTFnM529effmSiAL33H3MCh6PWQxu8zeg2dg4jE=;
 b=QGHmQqTBl/ihWr3Hv0M1k7qxtGp9TFLhBx2rSbuXxmtjQ3RsAtu7HmLyTlbbeCkHJkH/VMWXa4qUTuMCilg505giwtpXMbQFlyHNFWlBGtrEiy87XLQz1x4sXu5j/gFHkGQUQfl/7j6QWwpIIqmpa/y/yDfepFaZjp5iG6jGla3qAXWg9dJ/9TuHmwbjN09AG8nKqzTLnJ5USdlEwD6o5p9E1GOHrZcgJF7EsiyHP15K7+ZYWuyvr2zR9S3jGg1iLv7h2VGZMh5KVE2nAuNRe7/CdLZcJ++i1SALWqKO0q/+9HXfrjfHndDMk2E/AFF4j3G46rfVak0HlteuJJ1BFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB6490.namprd11.prod.outlook.com (2603:10b6:208:3a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Fri, 18 Jul
 2025 13:05:58 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 13:05:58 +0000
Date: Fri, 18 Jul 2025 14:05:53 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] build: remove obsolete compiler checks
Message-ID: <aHpGsX_il5_oRWBv@bricha3-mobl1.ger.corp.intel.com>
References: <20250718121402.856265-1-bruce.richardson@intel.com>
 <CAJFAV8wYyWbdRMTZB7ZJW-6703RPFc+7+v8BhMdvadJcm1Jadw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8wYyWbdRMTZB7ZJW-6703RPFc+7+v8BhMdvadJcm1Jadw@mail.gmail.com>
X-ClientProxiedBy: DB8PR09CA0006.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 770e3d16-8ac7-44d0-9e60-08ddc5fbd63a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUtvUFVPdktzWDlXUE1qUTdYK1ZCZ1l6STVSdUMxRjY2SGRlYzhBWDBYdjlS?=
 =?utf-8?B?MzdjMFpMcmFEUGh6SDJzdExOOTRMc0hrWGt2eTBQMTU0VHFKMnpzKytQRDlw?=
 =?utf-8?B?Zk5hVkVYSWVPLzZkbGhzZ3Z0cU84VkJ5dnkzNEpISnpWWmRpN3dsVlZYQ0lo?=
 =?utf-8?B?Mk92T295Rjg2ZW9CYlZWU2t5MXBDZjFwdmJScnQ0NkRRaDBpUGpTTHdhTW51?=
 =?utf-8?B?bWxGbDBoYnZTSWlhNXhqc2psVHlONUd0Y1JJeDhWUXZWZERiZVU2S0s0b2lY?=
 =?utf-8?B?QlR6QUlISGE4dzZ5RDdrcmh2dEw5dXY4MFVFSXhHbzcrQy8vVi9CUzIwL2lm?=
 =?utf-8?B?YlM3K1BkUzdSU2VOTTh2SEhRaDZzZEdSaTBJSGN4THVoVy9NczJoRWV0OXA0?=
 =?utf-8?B?a1pwcEpFUS80c0RFTFphWEdwZ3BhSDkzN25WaWRtQjgwdEJsVHZiQ0poNVp1?=
 =?utf-8?B?UEpRd2lnUVN2UHpMM29TRlZ5QU9CcVg3Qmt4aER2eG5tVzhEVVJQVXlqSGha?=
 =?utf-8?B?cy9BQ3V2TW5HeWpkWFRjTVRiTnkzbzZvVGx3REprNDFQZEhxSUpKaVErOStB?=
 =?utf-8?B?cDcweWdqY1RxY29aTGsxYmZldzNHOGVQTEE4UEl2VWdZOS9YM3d1M2RQbDY5?=
 =?utf-8?B?ak9zNTdjWXFpK05ReUxSMHBLU044bnNrbGFOTzZKakRyWmRLYVBXSzJyT3c2?=
 =?utf-8?B?SjNlTnR0OTNBVXFBdWEyS3pnZmNDVUVJOXhwdGxGTTRIZjJMZmY5eUpDWFhL?=
 =?utf-8?B?Nk1jQWRUb1dyZ0NTNWEvdlhybVhFNjFmVWt6WXZJMS9CRnNKYUZTVnpqUXgy?=
 =?utf-8?B?bFpkTjFMYkJSSDd4RTRYaXF3SWVHeXAxdno2ays5dWFmWTdIU1RORWkrTUdw?=
 =?utf-8?B?a0JldGdXejduWGZ3WWZ3OWhpVkFPZTVKUEhCbE9pNlo1Mm1WTkpReVl2bGxy?=
 =?utf-8?B?OE83bTFXSTl6emRnVGVaT1hDcFNtS0FCeVlURExUOGRJV0l0aUJJa1N0WFYr?=
 =?utf-8?B?b1pWQjQ2YzhOd2xsaVhFVTdDUWt3MndFeVZqa21rNklZbnEvRm5BVDlOSEU0?=
 =?utf-8?B?ZHVtbTBIUzdQZ2M4SW41VzJDTzNBOHNjc2RZNG1SU2RrN2RsS2RwU0dQNVkv?=
 =?utf-8?B?WGRmTDZMVjVLNS9GQTlUQWw0aURGL0MrSlpGc2xmM0VxNmJnUTNRRlZ3ZHRF?=
 =?utf-8?B?aGRCenhGSUZKMkVNdzdPbUtrSVp5ZW5pc1NHcms5T05sS2xySkpWdjFMc0VV?=
 =?utf-8?B?S01KeWdQdlo2N0U2dDl1RTZHcUZvMHMrbDV0ZVNtT3JCMWZRMndrRkRzSlZY?=
 =?utf-8?B?VXZSeFZWbVpOME9NRUVjQWwvK1pzMWNTa3JUNmFaQ3hJaUZibEtLaWJDeGl3?=
 =?utf-8?B?NVBjL3lrdXFsb3d3eHR4QlRSWENpb0s1VE1ZNC9ISGhNczZtT1kzK1pUN0sr?=
 =?utf-8?B?SlhUME9uK1VlQlM5ZHBLTzJ6ZWRsM0ExOXNDQ2dNemJzY2thYnBUcnlzYTVr?=
 =?utf-8?B?UDRwSEp4T1lSWFc3VkF5RUVIbXMyd2MrbEE1M3VLWnlSNTNad3gyTjFQengz?=
 =?utf-8?B?VlFKTTRyNzMxcGY4K2liTHBiWlFSZmVpbXZ5N3RuWnl3RHNFWmFadFJYTjRj?=
 =?utf-8?B?MFR4ZEs2MmZiblZmZlZkYk43bFpkNDdMVjlZakRpTUNhRXJRNHYzb2lVbFNG?=
 =?utf-8?B?L3hGa01icDVBaDZ3TFI3YlZSdndHdW8zdGpIL0hJMHdKTlhNNm5WMlBXY1do?=
 =?utf-8?B?Wm1qa1VVbDAwc2prY1hYYmRBUHowczBuK2ZMREZpREMvUUdNWmVTN2VuMUhl?=
 =?utf-8?Q?VKQyZu+9mXOPGkxWQYeEKlasje++h5qJhd7kk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEpVMS9jUE1LWFg0VjJCMzllYi92SWg3aHR1dE9hNittWEVNc09MdDN5cXJ5?=
 =?utf-8?B?eXVqUCtxTDFxZmVRSXZoNkZGSHdtVjZqQ2tlN2llYlJtUVYxb0JsUXNINFk2?=
 =?utf-8?B?Z0plUEdQKzJwUGkzMFVNNWw4Yktqb0c2ZDJHZG40d1lOTW9EcmFrVkRMeEcz?=
 =?utf-8?B?NHV0K0dESHRuTEs5WmloUVlZd0czU0ZRS3hicjRVZGhZMTV6MHV0ZTV2U293?=
 =?utf-8?B?QnVFcnU5SFY0aGlsWlNsbGRQTElhaFBXSlFXWC9xRkZGbXBpY2hXa2RkUElZ?=
 =?utf-8?B?cDZ5ZVY2YlMwRjVURlYwRHFncjhVdVR3NndVM0cvLzVqc0FWdkEwdWdqYlRm?=
 =?utf-8?B?MkxURUVCL3NFbHM4TTlrd25lTnBWUm1QRzhqUHBnb1VuZ3BEUW5hM2tkK041?=
 =?utf-8?B?SysyUHBHSUQ5Nk12SlZyM1hOUTF1YmpjTnhHeTlHdm43dXVtdEptS0dpTDIz?=
 =?utf-8?B?d2Y4K1V3MCtxVVVOY01QOVVIN0xpNnVkTGRaV0JUWlBqUXlHaTYrZWl1MjBu?=
 =?utf-8?B?eVNUanVqYm9ETXFrSEJzd3l4b2JFT3V1YUxiYlByWkVIcjA1MFhIelhzZG1X?=
 =?utf-8?B?c1VJMWNxSkR3NFd6OGpvcFlmREU2aFJHMGhIUXB1WnJKdlFBS3VZWUNVMXc0?=
 =?utf-8?B?b2FCYkM3U2ovTDJyZGxRcGlZK1FJbG15eHJHWFVSYTF6VUk1Ty80aWt0N3hj?=
 =?utf-8?B?ZldRMmZleDMyZW13SkJjd1lYNTh5dEpZK1hVaGJ0UHRJQVd5VytoSjZTdUdm?=
 =?utf-8?B?djVncUpMQXExWnVjNngwK0dSR21XMDBEKzQ3V3VqRE5ka1dTMWQwdStKakhy?=
 =?utf-8?B?ZkFjQllJRHdnWnBFUlZLLzZIajBWOTRkQ1N2ZGdmcHIxT2FWb3BLMmlMVHZm?=
 =?utf-8?B?d09Jc3RuWnpzanBMemJPWWJZYU1CY3pYaWF1cUFTTER5amp2eXUxdFNBUGRG?=
 =?utf-8?B?bHQ0ZnNmVmVSK2t4dUYzeSt0NHdOZFRzM2QyVGpHWkUrMjg0Z2g3U2JRWWFF?=
 =?utf-8?B?MUJlcjBwRE94NTVJVkd6d3YwYlNOWnRZOEFYOXNTNzNJQ2k5OHMrL3NaQlU2?=
 =?utf-8?B?Mld5OExSYXFoMFRIWXo2M0F4cXM5MjhDM2t1UHY3UE9hUmY4RTZTUkc3cHNu?=
 =?utf-8?B?T2hGY3ZmbzZLZm5aYXNoMlFmVURMNmw4d0x0dmZDOVp2bTRWYTBKdVdkRlIx?=
 =?utf-8?B?MHNwY2RIdlJCM2k5QVFUR0U0OEZCVk1uT0dPeDRSczNTZG1mYmw1YXczQXZh?=
 =?utf-8?B?MVdiWSsrNEFtc0k4eCtwbU13dGR6eFZBNUxLN2xWTEl4TThZY0ZFMU5BeEJQ?=
 =?utf-8?B?YndidEYvdnZxSzBwcHdKRHpvdXYyK3NvVE4yeFE1UUhYUnBUY3FpdVpOa2hH?=
 =?utf-8?B?T01Cd1Z1M2NPZjg0MS81V0w1SEZSOU40Qyt1ckM1Yjh4aVZtMml5K0dEaTNG?=
 =?utf-8?B?dFZCSXhjYnFQMlBCVnNMS3NOK1V2VU9PbmtzRGR1cnByTGJDYzR3aHFIMjVN?=
 =?utf-8?B?QlhzN3piVThGMEZqbzl3eUVucEprTHVQaUFhTlU2aExWQTJwUXREb3FrNzFN?=
 =?utf-8?B?c21mOEFRdVkvY1Z0enIrNVp3N0hvSjFvYjgvaWxvSGExVFJKREJIa3lvZmRx?=
 =?utf-8?B?RVlKTnBUQmlaNEdWWW9pTDB1bHUyR05uY0t1Uy83OC9XcmhqeC84c3ErbmY4?=
 =?utf-8?B?YUNhYjhBb2ZqRG43WS9KZWVicjROTi9vTVFNbHlwZDZvY285L2Q0K2lNYlZq?=
 =?utf-8?B?N2tTelJLSnNTQThZWlhnbXpBRE15M25YV3poTHR3d2tIVGc0WjFMSFdnWVRC?=
 =?utf-8?B?WUFNVHpUV2VTZ29ITlU1b242NHhFSlZEeFgreXd2Y1FKY2xaNHY1SDYwcDVE?=
 =?utf-8?B?WDdLck82QnRJQ3pwNUNDODNGRld3b2QwNlhLMlYzNkhyZ0xZQ2pmRHBMa2ZS?=
 =?utf-8?B?aVhJUzcxelVXUDExT0VWd2ZtdTdmL05EUDZwTEtvRW5NS0JhN21sc2JBT2tu?=
 =?utf-8?B?a1VKbTlQdldQeEE5TGVNTnV5TjRhbUJqZWRIY0JIWTBNVmpSeTUzOGlGRDRx?=
 =?utf-8?B?MnJVczNpS3JpNVBFN0dsL1dkc3VmcG1nQ1J1c3QrUDB3RDh1QjZrem9uMFJs?=
 =?utf-8?B?a2Zib1BjOVN2Q25aYXU2NE01MUtXSHJRWXhiTFUvT0kvaU1aS1hPektmc0dl?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 770e3d16-8ac7-44d0-9e60-08ddc5fbd63a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 13:05:58.0425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cc2l+btwR2/vpmNtWYBxAmteiGjhkGQ+DfPSj7hETPS9L/+D50iqxGk/xiYSO+4spLqspoWZEf4/IWQ8RZnx5/lTYY3hp6c7YQhNNBeihvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6490
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

On Fri, Jul 18, 2025 at 02:45:48PM +0200, David Marchand wrote:
> On Fri, Jul 18, 2025 at 2:14 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> > diff --git a/drivers/net/virtio/meson.build b/drivers/net/virtio/meson.build
> > index d3caa3a3b4..a9ff87e863 100644
> > --- a/drivers/net/virtio/meson.build
> > +++ b/drivers/net/virtio/meson.build
> > @@ -31,7 +31,7 @@ if arch_subdir == 'x86'
> >          sources_avx512 += files('virtio_rxtx_packed.c')
> >          if (toolchain == 'gcc' and cc.version().version_compare('>=8.3.0'))
> >              cflags += '-DVIRTIO_GCC_UNROLL_PRAGMA'
> > -        elif (toolchain == 'clang' and cc.version().version_compare('>=3.7.0'))
> > +        elif (toolchain == 'clang')
> >              cflags += '-DVIRTIO_CLANG_UNROLL_PRAGMA'
> >          endif
> >      endif
> 
> One other nit, not blocking.
> 
> There should be no need for special casing clang vs gcc, since clang
> supports gcc syntax in general.
> https://clang.llvm.org/docs/AttributeReference.html#pragma-unroll-pragma-nounroll
> 
I was actually thinking of doing a follow-up patch to remove the "if" and
instead do:

	cflags += '-DVIRTIO_' + toolchain.to_upper() + "_UNROLL_PRAGMA"

on the basis that having a define for any other unknown compilers would be
harmless. However, you are right that there seems to be little reason to do
this in meson.build, and the code can do it directly itself. I'll leave
this part as it is in the patch for now.

/Bruce
