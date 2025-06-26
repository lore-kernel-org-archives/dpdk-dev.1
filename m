Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD931C7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 14:03:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 294B440287;
	Thu, 26 Jun 2025 16:03:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 3AE1940156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 16:03:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750946616; x=1782482616;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=y/iM5wpTIjG5J+pYapQoH4WKNK0olc0noFJ1tnAMKPQ=;
 b=HyQfNfO8SyT4gisu41ofUzj8eoZL2LryUYgr/fXodU7e1hpUE3TNSYKu
 xRRYdWsXMSep0mhs5iQR0o0YF4tXMkIeRoK1x+Xq+EVTh6JumVZXD7p6V
 ESV4h97SB+cXtZDso7FT6opH0C5EJLGDVUm+3j8Gcnm0Jq1z+D/wE2k9+
 cmakenFl8XDbY3xPUiBGfBL4M6HKec9T3hhF2vpY/vy6XvvID78jsUWHf
 3c5eZsklc6WQ5mxqI8fn30l5dbs3I6VvyYLsg54TYWykHbQGDOKVql51V
 UClgrmvdUOuYmIsMZLE+DAEmPIC2TO3rINQ0rWj8Ug9Gd2Td42iLWooB2 Q==;
X-CSE-ConnectionGUID: v1Lm5kgNTneQtuUV5q/4qA==
X-CSE-MsgGUID: KBKoStO2Rqq8dSgqCsLLBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="52471369"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="52471369"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 07:03:35 -0700
X-CSE-ConnectionGUID: 3QqyDXG4SDONllqIndD7GQ==
X-CSE-MsgGUID: Nldr6OSXTxyRrqu6HapJdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="156563405"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 07:03:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 07:03:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 26 Jun 2025 07:03:32 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 07:03:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTatv0nGKjOgg4NDcsR+gZr8r5lTKTEiyAdvtPsB/ddgN0SAK0lJR7S2KWz4CrmTpstF9tJNFxFhKhOYr/SCdke9xaMlSKj3axB7xu4n96zycjpvLT5KdoLcu4BE8G+bnydtZkG2quDb02f4RvTKBFqLYeChaEeAdM/EZcMpX/EfbFy93G0dQ0OGtWO1pm4szmr3sNEa3F/EWrAvC/50+jDeYZK5gzkAO5i4hqDcH7Sm09qpgQuLZ4mDQewp7kBxLGTLK6pR7Qu3V/FhSUNZ58/Dg1lm5oMzLhZsWSbKviwcJizEx1ZR8KZubxWgvQ1x7hKQ8XJ/qUL6Nf+MMjdPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XKUtdRyF7/Q180kd2d1guTu6PubQMOtr5Kv9/7G/8U=;
 b=s+j/8paK3IIiA+qpW6FaqJjdKinqL5H6GZFVs1fLWCBifgyxq2RFMmBmGO/pIuvR5f9VPpESApoAWIG9/rZcH1Qks5iohmZpixtl4LaxJkN1xame+Zxu0uGNrWkrxOljIGj15Ul7a/936nXb+DBZjG3y9f6GBqP45gU/w+gQyOQ3tUj9XwhycqFrIxnUhLEecRZ4vSJF2Lcug4oa1OE/WZrbo/BRcFKaz8TJBw2qCKyRJVmvGmL+WzCJIyZ/XokHXRWjluVF0FSYC+ALEx88O36cyoDnJGTK+Lhi41IgjiN1RFwAJobEkqikBQx0vMXN+2V9dQaSTHLl4ROmTYJ1Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CYYPR11MB8358.namprd11.prod.outlook.com (2603:10b6:930:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Thu, 26 Jun
 2025 14:03:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8880.015; Thu, 26 Jun 2025
 14:03:00 +0000
Date: Thu, 26 Jun 2025 15:02:55 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
Subject: Re: [PATCH v5 1/3] eal: deprecate old coremask-based EAL parameters
Message-ID: <aF1TDzMKdbSCHqLi@bricha3-mobl1.ger.corp.intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250527152913.279011-1-bruce.richardson@intel.com>
 <20250527152913.279011-2-bruce.richardson@intel.com>
 <CAJFAV8zpV=KUDha1tknK0cgv0cboG0htvJZ1kujtx=EJ7hXQHw@mail.gmail.com>
 <aFl8-3IuF9WU_YAe@bricha3-mobl1.ger.corp.intel.com>
 <20250626070011.291d8f70@hermes.local>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250626070011.291d8f70@hermes.local>
X-ClientProxiedBy: DU7PR01CA0037.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CYYPR11MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d3f54e-3638-4b18-cb44-08ddb4ba28cd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qjlocjh1WlB5SERMTi9BMEJCMk1SaTVKdmJFWFJKTjlRTG92RUl5RG1XdEw1?=
 =?utf-8?B?MXhaa3l5OFNZSVp2dVN4ckhVRk1aSXllb28zMi93NUJpN0FsV1JXUkZKUEtG?=
 =?utf-8?B?SUE0M05rN3cyQkZGM0pTNXlBY3lRNFV2dlFQWWNuQWJaSDdPYzV2SGJKSWRO?=
 =?utf-8?B?eXJRdlgvWDhOeUVIcEM1SkRoTll6VjVGelhYdFFJbUN3ZGJ1OGFWRVlDOUpL?=
 =?utf-8?B?ZFc1RUpCczE5OWd1cE1zODVxK2tGcmR3cVpERnI5QlpMSVhjc0EzWTlYdnhn?=
 =?utf-8?B?OUxhREFlMGlVekk3VjRZMTFIUVJDTmNzcHZIb1c0NFQzY1U2Y3lmMWlTdFJl?=
 =?utf-8?B?Z1orVGxzK3FEc0JteXAvekNzSDVIb1lzMndvUU4zazgxbGpLZDJUNTYxV1RD?=
 =?utf-8?B?WnRkaWtMdlNKcG9TYkUxWUZaSEtzeEU2ZlhVbmV5LzRTd2pJbVhiNEc3RDBE?=
 =?utf-8?B?OUdENDFLcHlzM0N5SjdKaEZRNkljSmlXVFE3TXRSOTRjaVFYaTFxalNESXgz?=
 =?utf-8?B?bGtIVkNkSlUwbGxlTVpBS0EzSlZQRlM1Mmk4ak5BSWhjdXRPMDRFWkUwY2p5?=
 =?utf-8?B?WEpsRUc3U3VyaXpSa0I3NG9SY0h3ODArbENQSGdRZFRtWVQ3cittSk9KV1Jo?=
 =?utf-8?B?VnBnTUJMbkYveHJpVWpjTHdiTnM5dXdicThCdE0vMUhkQ3pIdTdsTmJaQUQx?=
 =?utf-8?B?dUdZQlNOYXNYTFV5MEVMQk52Q1JDWU10UzRINGtVc25RVTYzUk80T2NJc2NX?=
 =?utf-8?B?RkE1R0Jhd2VZTkNla1ljeE02Yy9wNnpsZ2g1MTVzQUs0WmdNYWF0UUp1SmRw?=
 =?utf-8?B?VEhFMlp2bEUrTDM5RldCVnpMTVBuNEtnRDhrMjIyUWp6Mit0VW0wb1dFSVN0?=
 =?utf-8?B?OFh5Q05yRkt6SlQyRkpuelFVRWJYNnVQZjcyK21lbElrWUY4OGdMSWd3RXA2?=
 =?utf-8?B?WjJxOEp6K2pGMUxJZmNqYXFQWVZ3TU5ndGl1RUwyVUNWQXloM25xdzVNM2tu?=
 =?utf-8?B?Vkk4Ry8rTUw2VTZWWGM3K0NFYkxxMTl2ejRxRldUbWQ4VGNiajQvS3NHTmkx?=
 =?utf-8?B?TTNXM0RsSVFUZkYycGJKYkhRblMxRmVqbUx6eXdScGZ4ZEgvaXhsNDhCZnZ4?=
 =?utf-8?B?RE94R04rbHhEanVYSEpPZnQ0c09aejNhaG9OYjhCaE5XSkVrc1NLNHUrS0FR?=
 =?utf-8?B?WFdLKy9xT0NZZkRIeS9FQWJXamp0VVVuVC96T2c2amRvREVPamJYYnYyb1ov?=
 =?utf-8?B?MTgya3hOYkJuUEtzQk5PQTE1RkRDM0ViSk5saFdZcjlRRXFxQ0NETXFSb1NJ?=
 =?utf-8?B?KzNNTmtqai9rb0VHMU5oNE1KVHIxRHVyT050azhSS0RVVU01QkVWdjdJT2R2?=
 =?utf-8?B?cnpzTnhOVndhREVQSndUZ1ROTVh2VVVqVDNYbEk1SEovODB0QXRobjF5NFJn?=
 =?utf-8?B?TnZvZCtZRndBRnltTW16K3QwZWcyZzdXSmV0TGdySW5KSUI0VGJYRUYzdVNR?=
 =?utf-8?B?ZEw3NGZXbGU3ZmlxUGFXdG9mSlpxSW9ZRFJZaFYvZTJnS01yNk1rMUZsaVQ5?=
 =?utf-8?B?S0I5MjlveW9Vd2ROMTRMK2pGOVltV29NaEdRSmlYUjZoZDl3YXpvdXNzcFoy?=
 =?utf-8?B?c1UvL2lTYUtzRTViVDFtN1BrSzl0Y1RzMXZsWDIwRHl3NTRteDRNd1Vjd1NW?=
 =?utf-8?B?UDdFMHF0YmZJTC9LbjdaODFxQTdqOVI4cml1VTNVMUdVVmd0MDRIN3A5M2l6?=
 =?utf-8?B?VzFTdnN3VTFoOUhXcXh3RUFsbFR4VUdBMlRsdG00RkhlNFh3dFAzU1JJVFRP?=
 =?utf-8?Q?VxGQ6BgmsZAHTpJnzA43env30ZCSQvYw9DPxw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVB0aDc2anRsbU1SRlJBdUNxRlp5Y2N2OTd6WGJQQXRlci9QcTRzZDlGTUlS?=
 =?utf-8?B?MldBNWpFLzhWcWQ0REczd3d6UHZFcEZUSnNuOXRrOVcySDBPYm5wMEFFc3lN?=
 =?utf-8?B?VldGOUxJSFh6bDJENzRDWGpua202ZUlIR2c0ZFdKWUFzd1hQWjhqeUdDZysr?=
 =?utf-8?B?NWhFTWxBVHRTTXB1dFpaajYvY0lKN3Q4TDVlNW84ZEJoa1NpN1hDbFVSY0d6?=
 =?utf-8?B?eWpLYlRaV21Ib09HdkdQZGhHZkJGTVJDZ1dxYy81dzhtNC9jaGtudG9aalhr?=
 =?utf-8?B?Q0QyN3E2RWRmTk9JMTZ4V2FacjUrQmtkckxPRW9jOXZjcmt1OUxoeFJaUGpL?=
 =?utf-8?B?WE16cE1WTWNJeG4xMlUyRkM1Ri92YzZxQ2JjVmtRWHdDOXVsRHNUL1VGWlhI?=
 =?utf-8?B?Uy9xaUMzWHMwN0gxbnZPT0I2RFRPbHBacG5HMnZPTDlZYVU5c1BQaEhiSmZr?=
 =?utf-8?B?dWRhYW44WmxrNDJwR0JuSlUxU3NJWjI5RncvTmRxTzF2RGFmNWJiMXV5VnhX?=
 =?utf-8?B?U3VRNWgrb2w5aklDV2dpU3h6SUE1NEovZzdKZUxOL1FDQlJ3QXoyR3JKZS9t?=
 =?utf-8?B?ZUZKM0xsSFBYeUVlcE90U3R5dWlNNDRocFMzdkY3MXRPblZmV2hCZDN4Sk5j?=
 =?utf-8?B?NFgxTnV5TnZHSG5EZXZPcHpSMWlvMWEzR3BSeHloazlvYW9wSVB4azJCaTlv?=
 =?utf-8?B?cEkwbGt1NXdwMWdRNUlNVjRIaXRacmlzK0ZWRjcvOFVGQVliWFM1czNYQVVU?=
 =?utf-8?B?Vjc1UzQ5cFAvRFBjci85V2lLcmVhaTNxZHlyRUdiRmJSeUZCK3dvNDlYWm94?=
 =?utf-8?B?NTRpK3FXK0g4b0JwR2dsd0hrbzNLZjhpRVVQdW9FNjZEQmUvbmFmUnN3VjRB?=
 =?utf-8?B?UDduemNhM2swVjhCVUkveU81THJrZktZTk1jTW1qblBxMzBhbWtyWXlQaDZG?=
 =?utf-8?B?YkF5OHNYOERHcWs1VTRuS05WV2czbEVuWGdYMmh5Sk10M2sxdVJpQ0hMM2lL?=
 =?utf-8?B?OVU4UnBDU0NtV3JDSDBtVHZMNWpZOHdLZ2NHamxFTE45QzUyUm91NzRoZ25q?=
 =?utf-8?B?QkhQTUV6Yi9vaW00SDFJU2JLS2Z3Z2pRbzFweDE4RE9WV2xpZ0VTamRYbGFs?=
 =?utf-8?B?Y1NVOVlUZWRSN2VNcGovVjVTVUZCZ0ZGOVJuTWc2YWJDUUJSMkJJcDRRQUNl?=
 =?utf-8?B?b0J3eEt1djhPNlVJQkQxbXd1YXRNTWdlNGxpVno0a1AzaDZ2Lzl0T3FkVTJQ?=
 =?utf-8?B?eFkvbktTNnpTdUFPYUxqdGxWaHNVWVRRNXhYZnZPT21rTHpTYTRpZ0dkdis2?=
 =?utf-8?B?REF0T2c1UXA2b1BieEkvc2l5eTdVdXZ0VWRYVFloRGtPeDdEbEJKWE96QmMv?=
 =?utf-8?B?b216VkR4aHU0SnNzWndrNHdNTkgxMnBZUHYxVVZWRllQd0dLQ3puQmRhNmpi?=
 =?utf-8?B?Y0Y5ZEpDTUpEOUM2Q3hjeDdZbitwcGVtcjZFS2wzUnU4UXdNczFiUkJDaDJG?=
 =?utf-8?B?UzNtS3dBRllIWHFwd2dGd2xJMnhBTEQybHdrcHAyeDl1QnhncDVZUEVUdnh1?=
 =?utf-8?B?QzdBZ21YNUxUWGx2bytDMVU1ZjBhZG1PTTZVWjduTjBFSzFGTWVWZTUydjFn?=
 =?utf-8?B?dllkc21FcW9LU2hqdTAzaE9mS0lFaXRwcFdXa0ZLaTlhNE45eEpsRStrc29T?=
 =?utf-8?B?NzVKbUNTYzJ2WXZwem5BU1BsdVRnMkN5ZzM3R1FEcXVOVnVFWWcyTTlPVzI4?=
 =?utf-8?B?RnFOYmJMb3I3ZHhIVGcrcVp1NVVRenFySE92c3BBOWZIZ0NnR1JQekVld0Fq?=
 =?utf-8?B?SFpDNGVNZlRjZEQydmJab2JUcXBxdzM5UWxGT1dNa0ZiT0l1TnBqeXJyaDlh?=
 =?utf-8?B?aEtWamt0YlVsTGhGc1JPR2tKNTUrd1hwWXJGc2dYR01CMzJweWFiQ2JheE4z?=
 =?utf-8?B?alJ4eEJFUnRiUUNadUZuZDQ4bUQwY3NoNERXQ3NudVB0VWdudTVDdi9ZQ2hK?=
 =?utf-8?B?UnYzcUJRM2NKZ3VJSm1KVjYzNkFTWE5SWi9JMjR2YVV1MkdvczZiNmVKQjJX?=
 =?utf-8?B?dzhKNThGNWpJekxZQUQ0MWpBcDRBZ3psWFpsTi85UGltbWhyaWxpSnJ3QWZF?=
 =?utf-8?B?YjRNRDRkZlhweG91UXFsbmgyL0xScnY3Smkrbk5maHltak9xZUZWS0dqWTF5?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d3f54e-3638-4b18-cb44-08ddb4ba28cd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 14:03:00.0808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnfoSw8FP+Vb6/32leN/HvC1e5A5uhU7X2ScRUga9waTpcR+9cRHb8RxK9+UyNpuBIJ4tlUBmbsZiHDg0avjgHixOeAkUr1VVzZBse6vih0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8358
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

On Thu, Jun 26, 2025 at 07:00:11AM -0700, Stephen Hemminger wrote:
> On Mon, 23 Jun 2025 17:12:43 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > On Mon, Jun 23, 2025 at 06:01:00PM +0200, David Marchand wrote:
> > > On Tue, May 27, 2025 at 5:29 PM Bruce Richardson
> > > <bruce.richardson@intel.com> wrote:  
> > > >
> > > > As the number of cores/cpus on platforms has increased over the years,
> > > > the use of coremasks rather than core-lists for identifying DPDK cores
> > > > has become more and more unwieldy. At this point, let's deprecate the
> > > > coremask-based EAL parameters for future removal, and point users to the
> > > > core-list based versions instead.
> > > >
> > > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > > ---
> > > >  doc/guides/eventdevs/dlb2.rst                |  6 +++---
> > > >  doc/guides/faq/faq.rst                       |  8 +++-----
> > > >  doc/guides/linux_gsg/build_sample_apps.rst   |  7 +++----
> > > >  doc/guides/linux_gsg/eal_args.include.rst    |  8 ++------
> > > >  doc/guides/prog_guide/meson_ut.rst           |  2 +-
> > > >  doc/guides/prog_guide/multi_proc_support.rst |  2 +-
> > > >  doc/guides/prog_guide/service_cores.rst      |  8 ++++----
> > > >  doc/guides/rel_notes/deprecation.rst         | 10 ++++++++++
> > > >  doc/guides/sample_app_ug/ip_frag.rst         |  7 +------
> > > >  doc/guides/sample_app_ug/ip_reassembly.rst   |  7 +------
> > > >  doc/guides/sample_app_ug/multi_process.rst   | 14 +++++---------
> > > >  doc/guides/sample_app_ug/qos_scheduler.rst   |  2 +-
> > > >  doc/guides/sample_app_ug/test_pipeline.rst   |  2 +-
> > > >  doc/guides/tools/testbbdev.rst               |  2 +-
> > > >  lib/eal/common/eal_common_options.c          |  6 ++++++
> > > >  15 files changed, 43 insertions(+), 48 deletions(-)  
> > > 
> > > This patch will need some rebase.
> > > 
> > > I see you fixed a few docs, but there are quite some misses in
> > > copy/pasted blocks:
> > >   
> > I'll take a look and respin this.
> > 
> > I'm think of separating it into two patches: first patch with the doc
> > updates to remove use of -c flag. This should happen independent of the
> > deprecation, I think, and second patch just the deprecation notice. Does
> > that sound reasonable?
> > 
> > /Bruce
> 
> Should also drop use of -n in all the doc examples.
> I had a patch for that probably buried somewhere.

Yep, agreed. I actually thought of doing so when doing patch [1], but
decided against mixing additional changes in with coremask changes.

/Bruce

[1] https://patches.dpdk.org/project/dpdk/patch/20250624133409.550372-3-bruce.richardson@intel.com/
