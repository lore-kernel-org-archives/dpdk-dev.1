Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F5CC54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 10:55:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A3A04027A;
	Tue, 27 May 2025 12:55:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id F145B40144
 for <dev@dpdk.org>; Tue, 27 May 2025 12:55:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748343312; x=1779879312;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KDZU9nPXV/fpDr1FjXSMik6B8WAnKy7RNPZXlvAyrPQ=;
 b=BWjasrbPWhGzM+VFAJQjgAngXBEqEnbbUBSbxSaMd/JY9DrCONAgCn7Y
 +0Vih4fGZM+azi6wazl/lKtTPJYjKkg9BZMvVhLCGynRUK2KKBTCvRgNw
 5J4BJMGpLJmTXJVHcle5YnZyOeCvYYvk5zJiGY9UX3eDlpscv6LWi9eYf
 u5MJ4P1aOcikICXR5NREKPK+aebTCU2jRtPU5yDOPisDn/HZM0lxUFg6h
 lj8DiX6aC0nTCk4yZvKnAQBPYrEQJM1Vu8scWDgi7qXt5LqTTNcDGv5Wg
 tHFrNxM+DscfY99Xs6iDWRagdVR6qbp7ED8/fCkY/iLSQ+DbFPJzivdro w==;
X-CSE-ConnectionGUID: 9e96q2aWRSSwbFb66HC6kg==
X-CSE-MsgGUID: uK7dcKusQFOJNCezKnp30w==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="60958738"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="60958738"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 03:55:11 -0700
X-CSE-ConnectionGUID: uofgn6/GTU+dFQmdroNj7g==
X-CSE-MsgGUID: LpYsgzeYTT2MtEoBJYlx4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="142767969"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 03:55:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 03:55:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 03:55:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.79)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 03:55:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkMWVRoAZYb9XKiZLDx1geDIwk/EByvnqy3xMZTO4re+vcqfqn8u5wXp/4pEj5u9wulxbvmBRVq80AGQ7vMKIIVjf4Kd1WhdcwsT9azw6DD/nvqwCTttlAUoTe15H8UER6IiRD9j4sC0OoX5Ssq4K/E5n9xPL2df1dh2BpN7WJe2SLDekZ5fdIM17A3NoHcobgtf02tHaXICS/G3DxNgWxOGvFhP+IqZDz3/OkijPMw2LCuALxjtxa1wRPplAcuRL0Kr1qCCZPqoear8RmD54ZPWiOtGAxm/DIvgNuZ0dfEi6hq1tvU7Xofehedg2tyipUi6LaR4mgRDKTuUHkpqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDZU9nPXV/fpDr1FjXSMik6B8WAnKy7RNPZXlvAyrPQ=;
 b=PzqjOvKTcbc4vn1Qkdf4jdD+JzdqgyHDQfQP69F44RmN8W7kLSD6xpgsqvX1LITWrn/msK8V/cxfH+9md8cYcd0aaAilPDr3gnE8DgAfKijkC/01Gnu06Jv2trupzoP/KvP+cJCwHRobLaO1tIGAKEA0Ywo5G8yoBdWSgThZ23qqbfoMZ5Cy+lVg3pRKP/5QYY6opJBNWFMu8UJ43fFRYeK7UFsKbgpBjet8YbWsrsCllHBiJfexHIF6ce3D1kizZo0a5JJ0MP/xK5uCZ92fybMBgfHtIyGET3OdvK7CoGHldJikFWIa39VREn6SG3+S+g8g9WPTM9c6RGONXBe/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7044.namprd11.prod.outlook.com (2603:10b6:806:29b::5)
 by CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 27 May
 2025 10:55:09 +0000
Received: from SN7PR11MB7044.namprd11.prod.outlook.com
 ([fe80::79ff:96e:c439:d42e]) by SN7PR11MB7044.namprd11.prod.outlook.com
 ([fe80::79ff:96e:c439:d42e%2]) with mapi id 15.20.8769.021; Tue, 27 May 2025
 10:55:08 +0000
From: "Naga Harish K, S V" <s.v.naga.harish.k@intel.com>
To: =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <mattias.ronnblom@ericsson.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <hofors@lysator.liu.se>, Jerin Jacob
 <jerinj@marvell.com>, Peter Nilsson <peter.j.nilsson@ericsson.com>
Subject: RE: [PATCH] event/eth_tx: prefetch mbuf headers
Thread-Topic: [PATCH] event/eth_tx: prefetch mbuf headers
Thread-Index: AQHbn6YFqAHfW3ID8kGgUvaUsg96ILPmqzjQ
Date: Tue, 27 May 2025 10:55:08 +0000
Message-ID: <SN7PR11MB7044C3B89BCFC25021522487A164A@SN7PR11MB7044.namprd11.prod.outlook.com>
References: <20250328054339.489914-1-mattias.ronnblom@ericsson.com>
In-Reply-To: <20250328054339.489914-1-mattias.ronnblom@ericsson.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7044:EE_|CYYPR11MB8429:EE_
x-ms-office365-filtering-correlation-id: 4902e44f-9a01-44ad-2aa7-08dd9d0cf268
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MWY5R2JPOWVQYm5mQkM2N1llVGhuY1ZOWUJJUFRNU2xBdGg0NUlSaTB6MWsr?=
 =?utf-8?B?elRXd3cxQkw2cE02MlBicnAzSnV6V01aNW9hc045M3dqcUpJVFc5dE5tcHVt?=
 =?utf-8?B?QktsMU05b1QyN0FoT1NvcWNwUk14SjhEdXpKMTlJcVpsNlBaVWdUZ3dXZjdT?=
 =?utf-8?B?WWs3ZUtPR3NVTldSTG54eW0zcGlGYStIVjFRYWNobDBkbHZXUlR1TURXRTh3?=
 =?utf-8?B?Z3F4T3o5OHFSMzdvOWhGZ2FRa3UweW5nU1Myanp6bHVlVXY2bWxEUzhkRWMx?=
 =?utf-8?B?R2RQRDVTck9Xam1iTzN0NWw4aXlWVjJCTTFyRkloOTFraWZieVVEVUQrelZw?=
 =?utf-8?B?Y3BuandJQmtDUVcybXRjRnRnZHlsMGdZOXNmOERBVmlLUU1vWnpueFJ5WS9q?=
 =?utf-8?B?emwvVGF3UmhMZUZNeEJ5ZjZUeGYzSURTWi9xK3JXeGpva0k2UlF4ZHF3Z1Nu?=
 =?utf-8?B?RWc0T01QZy83SmlJYTlpdUdVU3BOa0Z3NmtQTVVid002NXJxanIxOFJBcEdV?=
 =?utf-8?B?ZEZidjR2NDFxa2htR1hwWHZrRjA0MTRPS3piV3RyYzZudGIzRFRLNllZQUMz?=
 =?utf-8?B?SURReldBWWpNSGlNZGNuZGlwZTdNWEhmWHZybEhvdXBjd3FmRTFtUGFyeStl?=
 =?utf-8?B?ck1qWnFkMlVkQ2llNFBPRzBBZlFsYjJySUFaVWVFOFRxSXFRRENienhJb3pi?=
 =?utf-8?B?NzBZK3NVdTN6YWVlN1BmMnQxNjVkVEd5cFlsOFFIdWhHZFlGL2RZbkZDWEhT?=
 =?utf-8?B?WHBXenh4U2tYVzVBQWs0K1ZIZGxqMUcyYW0wZjU3NG5uWXFnTm5Tb0Rvam45?=
 =?utf-8?B?c0V1SVFWTFBUREF4WkNiQndRd2p6UUFRSHVjaHVKeThEWFpPWlY2aVk0Rjht?=
 =?utf-8?B?bDlUUDdqRHpOZWU5NEdremlGL00zZ2tiZHF6OHZ5Z2wxK0pYTlVGRUgxcjVj?=
 =?utf-8?B?S25ZNFVpTTJYTzJsaWFCbEMwbkVvbDh2dGhKbDRsZnBVdTlVRFkveTduN1ll?=
 =?utf-8?B?QlQvM0U5ZmxTVFBmRCtaWGxKZC9FV2JNUVlpR2xBdVMzUlVsbTR4ZFRUQ2tH?=
 =?utf-8?B?U2krbzQxZU9QWDRvT2dVR091eVprYVlib0JGa2xadXd2RHVuQ2ZyMlNDYXg0?=
 =?utf-8?B?K0pmNkg5YldUclJwSGNEZFMxTmM5ZHY3bjZMSnVERWU0QjRkcFlqZ2ZTbVM2?=
 =?utf-8?B?U2I1VHhRRWhPT2g3T2Y0YnF3M2cwSzdIMFlOMFZTVGs4ZXQrMTlJMEwyd2F5?=
 =?utf-8?B?NVpDczlZNWJWVWs3dWxnUHYvUEVpN3R3MWcrRGZwelN0aWFiOXdMR1owTlYw?=
 =?utf-8?B?QXlWMGhnVVpjVWMrRUtHZ3Znc3B4ai8wZmlRSDY4aGFLZ1dvTEdHcFNEL09R?=
 =?utf-8?B?aXNkVkEwVHFjb3lIVi9tWElSaGVKZ2laVEw1czJ5aW9NT3MwcUJsVWQvNDd3?=
 =?utf-8?B?bTNtdkJaNFdOb3V2YTJ4UW5vS01LVU44Q2FRNHJJS0lZNzBSUVhRNGJpZmVK?=
 =?utf-8?B?aWo1dkpBTzYxUHdmZXF5dCt6RlZTTm5TdjBYQ3hINFR0Q3lSR1N4UXZnYkhD?=
 =?utf-8?B?MUR0dCtkRUpYWTRvSk1iUWsrRm1mY2Y5Qm1GMmV1RUc1NFY4R1ZTNUQ1a0lW?=
 =?utf-8?B?WGtaV0JYL1lFb0ZFWFhZeVRSdnRYVnpMSHF3bU1XYkdYY2NXOTVVVis0T3I0?=
 =?utf-8?B?TitLcSs0KzRuVGFFeEZKYUs1NjZJR0RnUmlvRk1oQm9XSHhZMG03TDQyNWwz?=
 =?utf-8?B?dkxCcUhqTE5vOGNZR2hxWlp3ZjdMeGhiajZJcGx2OGpBYUdQSGJqeHNkNnVG?=
 =?utf-8?B?MVRMbTZZMzJnZmpjTFZodEtQU2hoZGJjaXFnK211Y2xPNjFTajVEdU15d2Z2?=
 =?utf-8?B?c2gzQ2l2dDdhdm0vWFgyYWxmR0I1Sm43OTlueVdFM2o0MmZWdjFRN2pMVGkw?=
 =?utf-8?B?c01QeUZlU3lQVkpSTGNQWjE3d1ZIanRtUmkvYjFxNGMzVm55RWlPY1JCcTFl?=
 =?utf-8?Q?931Ugvf5+UfD8uQrF9Tt1KM4gDxkBM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB7044.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ak4rbFFRaTRhMElteGRaUFBnd0MrdU1UWDNjNUlydWN1UkpmajJaVW4zMTlC?=
 =?utf-8?B?b3FOYnhndVJvb243dXVBTzhqSjNpbnV3TDJSbVZIbk9ROUVUSTQ2bWhUMXds?=
 =?utf-8?B?Yjh3ZGVoTUhxK3g3cnJwcTlHelBacVhGOUxhaVJWWFdtdmwzMUVXUUpZclpF?=
 =?utf-8?B?STc0eXgxSzNpNTdmZTJYdDNWdGRaTU1TOFZyblNta1hQOEw1L2VxVG1mWWN2?=
 =?utf-8?B?c0NHUm52MThyWXRFUDJ1Z05Mcm1oOEpFT0Fvdi9xTXdSRGpad2h1dUJVSUFz?=
 =?utf-8?B?bmV6bXlHeHVuVS93RTVLTEJPUkgzWnJENmtOZiszNTVCUEdGZ04wejl5OHdv?=
 =?utf-8?B?OHBEcEwzVHdBdHJiYldPZE5UNW44NFlBNDB3VWRKR3JSYkZjN0Vna1N2Q0F0?=
 =?utf-8?B?MWpCVE8rMXpEL1RCTjR2alh3cVZwNWN0OGlNamQ4ZFFxSFVmRmU0L2ZoVlpH?=
 =?utf-8?B?Q3RvY3VseCttcVB6aTJzcTN4Y0VCejlmNTQ3YTFJUUMwWFlYR1k0R0lIdTV5?=
 =?utf-8?B?VldURlIwWWovY0hwMFlqZTJJeTVpUEhwVElianBmNXZUU0ttTEp5L1pKVkRa?=
 =?utf-8?B?ci9aeVducHFsV3dBSlhLT0VORUpXWEsyMXJnT2dHYWpWcWxJblVXMER2TUJN?=
 =?utf-8?B?MlAxUVVyUnVhOUQyWnprYTNCZ1MzQzI2aXpDQ2xJUTY3enA2cEx1OFZqVkdz?=
 =?utf-8?B?bTVodE9NYzJ4eGZaSHpiaVhJbFNzT0RHZFUraVpjd0dHc1lobUNnYlZIb05B?=
 =?utf-8?B?ajN1L0JURm1tL0FyKzZ2Kzk1Y3FmOUJ1YjVsRlhDMUhvd1ppR21TS3kwY1hx?=
 =?utf-8?B?VnpUWGtTRGJFSTN1Ympkc2RYejJjWkhIeVFxcno4SUR0VFRmS2RndGZ1Y1VP?=
 =?utf-8?B?NUxSWFpFdUNGbzlsdERPMVRjQWgwRVBzbVlHTXVDczl2b1FzM0dYSFNNblFi?=
 =?utf-8?B?Q0tQb1JnTDlaMXVVOU5BWU9aYUxMVlRyVUR5WVg2QVpNdDFmWFdkZzZUNWt3?=
 =?utf-8?B?MG0wNEYyNHl5WTliRmdDcjU3Nml5TmlDdHd0Q2ZETkVjSWtKUmNmTE9Pcmsw?=
 =?utf-8?B?NDdUVUtwYU9Ic1dRNWN3Tm93VFk1MmhaeVU2bGt4TDJFNnlEUXJaRHU0b05j?=
 =?utf-8?B?cnYrNnJYRjVkamhxcXh0VHQ2b3BZaFBmUStGWTZGMkNERndhWHVPMTduZXRh?=
 =?utf-8?B?azFxWXBFQVh6MkJGK21CRjVQRFNNRGFtK0FKZm8wc1pBODBXanRnUkQwdEo5?=
 =?utf-8?B?SHBqTUFUZ05nemx1WWpQZHo3NnpndU9Xc2pzdG1UazVSdURpUEJnNHF4Zml2?=
 =?utf-8?B?OUNwV1lzN01qRzhpYXB4Tm9ObmFOTkozYlRUVkEwTEpGaWpMcVVtY3hZRytp?=
 =?utf-8?B?dmhyU0FKSGwzMUJGZ3NjUjNSTGN4OU1JdnpKd3Y0aVlyVzNXTWhpZlVVN2h0?=
 =?utf-8?B?Ulp1OU04UzgxZ05JN0VibVhPK0oxZCs2ME5XRmYycnF3YlMxdTBYVkJXMWNz?=
 =?utf-8?B?cG5tZHZrZHA0cVc5U3F1a1dEWUVGaW9oWW9OdFNDRFRnMkpPR1dXdklqSEFz?=
 =?utf-8?B?aVdIZjlMaXJoTEI2QVMvS08reWZrd1B2dzlYeFAxYytqSXlEdDlPRjIrUVVB?=
 =?utf-8?B?NXlSYnozb1A0dENjcXo0Wm96Z1daRUdnQ3NtMjIybDlpdEhkZjBIMmcyVFpq?=
 =?utf-8?B?SThIb2FDVmR0MGVnSmdWUUY3RE05WUpLK1pxWkswZHFwWkg0d1ZFZFFKSDVJ?=
 =?utf-8?B?VGpURExPTEdTMnQ5YnorQzRPQXI0TitkbFdBaVNlbENHN0htdzdzV0xaQTh4?=
 =?utf-8?B?eHJWZEJXT1VFcVpvT0htM0RIaTdib0ExSENGdXl3QXlvRFkxVjZsUHhIRVlp?=
 =?utf-8?B?d2ozQXQ0Yjh0Z0d0RmhLMVpTeVFtYXVZeVhZVHlaeVJ0VmxWT1M2Y0NuK1du?=
 =?utf-8?B?Q2xjWHpiM01oODNveW9DMUJBU0hHdFlUeGVZRzQvelJzZkJsWWM4dU5kNElL?=
 =?utf-8?B?SWhOZDRTNHIveUs4TVQrM1dmTnEzcnNZUm5VclY0SHB4Y1U1TnByaXRiMVVM?=
 =?utf-8?B?Zjd5ajg3ZVM0VWRTMnlpbHdkanJ6ZjZQOG5lTlNHSENzaVd5aFk2UGk3d0px?=
 =?utf-8?B?TExiUkIyTXBQQlRWS0RBbGNOY05JYk9QUkkrb3d6cGc4OFgwUUs1SER2QzBG?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7044.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4902e44f-9a01-44ad-2aa7-08dd9d0cf268
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 10:55:08.8477 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZdjDinY3faNII5ikxBi+LKDjijH7ZZjwBfLCZp8rL1TZmfnrKY2nn6tFLu2a3tQIa2JKVR+gkKVdf7Ad0KGSZ0Oh8iiwKZCdYiFEuNrBSBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8429
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWF0dGlhcyBSw7ZubmJs
b20gPG1hdHRpYXMucm9ubmJsb21AZXJpY3Nzb24uY29tPg0KPiBTZW50OiBGcmlkYXksIE1hcmNo
IDI4LCAyMDI1IDExOjE0IEFNDQo+IFRvOiBkZXZAZHBkay5vcmcNCj4gQ2M6IE1hdHRpYXMgUsO2
bm5ibG9tIDxob2ZvcnNAbHlzYXRvci5saXUuc2U+OyBOYWdhIEhhcmlzaCBLLCBTIFYNCj4gPHMu
di5uYWdhLmhhcmlzaC5rQGludGVsLmNvbT47IEplcmluIEphY29iIDxqZXJpbmpAbWFydmVsbC5j
b20+OyBNYXR0aWFzDQo+IFLDtm5uYmxvbSA8bWF0dGlhcy5yb25uYmxvbUBlcmljc3Nvbi5jb20+
OyBQZXRlciBOaWxzc29uDQo+IDxwZXRlci5qLm5pbHNzb25AZXJpY3Nzb24uY29tPg0KPiBTdWJq
ZWN0OiBbUEFUQ0hdIGV2ZW50L2V0aF90eDogcHJlZmV0Y2ggbWJ1ZiBoZWFkZXJzDQo+IA0KPiBQ
cmVmZXRjaCBtYnVmIGhlYWRlcnMsIHJlc3VsdGluZyBpbiB+MTAlIHRocm91Z2hwdXQgaW1wcm92
ZW1lbnQgd2hlbiB0aGUNCj4gRXRoZXJuZXQgUlggYW5kIFRYIEFkYXB0ZXJzIGFyZSBob3N0ZWQg
b24gdGhlIHNhbWUgY29yZSAobGlrZWx5IH4yeCBpbiBjYXNlIGENCj4gZGVkaWNhdGVkIFRYIGNv
cmUgaXMgdXNlZCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aWFzIFLDtm5uYmxvbSA8bWF0
dGlhcy5yb25uYmxvbUBlcmljc3Nvbi5jb20+DQo+IFRlc3RlZC1ieTogUGV0ZXIgTmlsc3NvbiA8
cGV0ZXIuai5uaWxzc29uQGVyaWNzc29uLmNvbT4NCj4gLS0tDQo+ICBsaWIvZXZlbnRkZXYvcnRl
X2V2ZW50X2V0aF90eF9hZGFwdGVyLmMgfCAyMCArKysrKysrKysrKysrKysrKysrKw0KPiAgMSBm
aWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9saWIvZXZl
bnRkZXYvcnRlX2V2ZW50X2V0aF90eF9hZGFwdGVyLmMNCj4gYi9saWIvZXZlbnRkZXYvcnRlX2V2
ZW50X2V0aF90eF9hZGFwdGVyLmMNCj4gaW5kZXggNjdmZmY4YjdkNi4uZDc0MGFlMDBmOSAxMDA2
NDQNCj4gLS0tIGEvbGliL2V2ZW50ZGV2L3J0ZV9ldmVudF9ldGhfdHhfYWRhcHRlci5jDQo+ICsr
KyBiL2xpYi9ldmVudGRldi9ydGVfZXZlbnRfZXRoX3R4X2FkYXB0ZXIuYw0KPiBAQCAtNTk4LDYg
KzU5OCwxMiBAQCB0eGFfcHJvY2Vzc19ldmVudF92ZWN0b3Ioc3RydWN0IHR4YV9zZXJ2aWNlX2Rh
dGENCj4gKnR4YSwNCj4gIAlyZXR1cm4gbmJfdHg7DQo+ICB9DQo+IA0KPiArc3RhdGljIGlubGlu
ZSB2b2lkDQo+ICt0eGFfcHJlZmV0Y2hfbWJ1ZihzdHJ1Y3QgcnRlX21idWYgKm1idWYpIHsNCj4g
KwlydGVfbWJ1Zl9wcmVmZXRjaF9wYXJ0MShtYnVmKTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIHZv
aWQNCj4gIHR4YV9zZXJ2aWNlX3R4KHN0cnVjdCB0eGFfc2VydmljZV9kYXRhICp0eGEsIHN0cnVj
dCBydGVfZXZlbnQgKmV2LA0KPiAgCXVpbnQzMl90IG4pDQo+IEBAIC02MDgsNiArNjE0LDIwIEBA
IHR4YV9zZXJ2aWNlX3R4KHN0cnVjdCB0eGFfc2VydmljZV9kYXRhICp0eGEsIHN0cnVjdA0KPiBy
dGVfZXZlbnQgKmV2LA0KPiANCj4gIAlzdGF0cyA9ICZ0eGEtPnN0YXRzOw0KPiANCj4gKwlmb3Ig
KGkgPSAwOyBpIDwgbjsgaSsrKSB7DQo+ICsJCXN0cnVjdCBydGVfZXZlbnQgKmV2ZW50ID0gJmV2
W2ldOw0KPiArDQo+ICsJCWlmICh1bmxpa2VseShldmVudC0+ZXZlbnRfdHlwZSAmIFJURV9FVkVO
VF9UWVBFX1ZFQ1RPUikpDQoNCg0KVGhpcyBnaXZlcyBhwqBicmFuY2ggcHJlZGljdGlvbiBhZHZh
bnRhZ2UgdG8gbm9uLXZlY3RvciBldmVudHMuIElzIHRoYXQgdGhlIGludGVudGlvbj8NCg0KPiB7
DQo+ICsJCQlzdHJ1Y3QgcnRlX2V2ZW50X3ZlY3RvciAqdmVjID0gZXZlbnQtPnZlYzsNCj4gKwkJ
CXN0cnVjdCBydGVfbWJ1ZiAqKm1idWZzID0gdmVjLT5tYnVmczsNCj4gKwkJCXVpbnQzMl90IGs7
DQo+ICsNCj4gKwkJCWZvciAoayA9IDA7IGsgPCB2ZWMtPm5iX2VsZW07IGsrKykNCj4gKwkJCQl0
eGFfcHJlZmV0Y2hfbWJ1ZihtYnVmc1trXSk7DQo+ICsJCX0gZWxzZQ0KPiArCQkJdHhhX3ByZWZl
dGNoX21idWYoZXZlbnQtPm1idWYpOw0KPiArCX0NCj4gKw0KPiAgCW5iX3R4ID0gMDsNCj4gIAlm
b3IgKGkgPSAwOyBpIDwgbjsgaSsrKSB7DQo+ICAJCXVpbnQxNl90IHBvcnQ7DQo+IC0tDQo+IDIu
NDMuMA0KDQo=
