Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21655C369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 16:06:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C72D0400D7;
	Thu, 24 Apr 2025 18:06:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 649BD400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 18:06:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745510797; x=1777046797;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=p6WdS/vXjMjrSVDB6AflfFrX8h9b4l+s9s25nYNwpp4=;
 b=iHaXEA5HyCX2U/cdDeA/aX50WS4E3wAsrocrw8sYVC3w7ukMSDbbohkv
 XQlvAJppbMRJHLxPcQZy/g5PKhud1W9LJwcRGEPEw0YpWIz++EaXKZaWo
 GHNFYqAamnxbh1wnN4dqcXfkprODgacNsLWHuBNA2g4wf+yonmfodNah0
 D7U91d4b2cWDAf7X306gGF+S7FfCrBTCmW+C6OigPEwv74BTmpBsmNKyC
 3jG1PVlRbePCZOOrHcMU+Zing8IM1Xy0q6Acd5oNUqSoqEcZU0TnxChMs
 AD09awhCliFEfTiRn3jkMQ0h+l1YZbgodL7SMTtfwhI+EawKdD5tY8XL3 g==;
X-CSE-ConnectionGUID: P2CIJ3FiQ0qUfo6SEqtNUA==
X-CSE-MsgGUID: KVUt34DMS7mScYGhzioM0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="46275280"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; d="scan'208,217";a="46275280"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2025 09:06:34 -0700
X-CSE-ConnectionGUID: QJfQZYPvSVeGLxDugAgGGg==
X-CSE-MsgGUID: CTxFpuKtQFu96FgW6dxaJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
 d="scan'208,217";a="133580930"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2025 09:06:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 09:06:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 09:06:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 09:06:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJDVl3MIjk2jx2rKIAAQChmCWYH+yv6gG01OroqkAUZ5xzZCu8ZGMoGTxoSwGznLmev9A5W6o8hAucPQRFCjhwG0YfkPbjD7sOB8z7O/RNcTWMYKXyEVCUsxy1qRwLfHWdt8zxKm6sTrNuxmMImkCZ3klsf5NhawBla7VeKDbF43F3biipnAier6TIoDGlNnyNjIp3DPsQB1OEBCwtCh47B4N/gLr2wAdDprXBOQAkn0BtvjJ6low+IeIgg+Bx17NNYtdgofxl2rdTl75OZ4IsMWLaaIPeKM4uMlmwER2bw8xgsx2k6+Lyt5krzUsMvb5zn9s8nIx7681pS3JDyTPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6WdS/vXjMjrSVDB6AflfFrX8h9b4l+s9s25nYNwpp4=;
 b=itzb4S35UclxotEsfSsREoKvfHqhhWqvW/u04dYItmzoxo996tlJz1jWZFQJvqCpAadwSZCXBWPC6g5d9peToIrh4cK5dJ0IudwIcVuMG+nYCWaieUzsj0ZvB/xWbqBWflZjbPNiit9p2OgxvARf9RWqc8QkvxZY/yAY+oByfOE4ONAn5SzMmwopay1pgMQnUbQMguRK5prPLZDq1w90qclR0wjbdI/nTp4AB95H3Stxncl52AmAd/wnbOPnUE6BqAAQKSmif4IaGdOeI15lTBsi9Fwb4rn1L7iR4iW5vtHSAjzshHvsYUpVWk5CV8RdDicFNX+mMdVHNg3ES4H68g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6803.namprd11.prod.outlook.com (2603:10b6:510:1cb::12)
 by SA1PR11MB8858.namprd11.prod.outlook.com (2603:10b6:806:46a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 16:06:29 +0000
Received: from PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4]) by PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4%5]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 16:06:29 +0000
From: "Van Haaren, Harry" <harry.van.haaren@intel.com>
To: Gregory Etelson <getelson@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "owen.hilyard@unh.edu" <owen.hilyard@unh.edu>
Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Thread-Topic: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Thread-Index: AQHbr6r3ow4K3xJ6vUu8VgAr7QGxzrOoNgYAgAEJ8vWAAwUpAIAGmn3L
Date: Thu, 24 Apr 2025 16:06:29 +0000
Message-ID: <PH8PR11MB680363E200616CBB39DDDCB6D7852@PH8PR11MB6803.namprd11.prod.outlook.com>
References: <20250417151039.186448-1-harry.van.haaren@intel.com>
 <9c4a970a-576c-7b0b-7685-791c4dd2689d@nvidia.com>
 <PH8PR11MB6803458E6348B4D167C47C91D7BF2@PH8PR11MB6803.namprd11.prod.outlook.com>
 <IA1PR12MB63308A2F69036E3ACCC605D0A5B92@IA1PR12MB6330.namprd12.prod.outlook.com>
In-Reply-To: <IA1PR12MB63308A2F69036E3ACCC605D0A5B92@IA1PR12MB6330.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6803:EE_|SA1PR11MB8858:EE_
x-ms-office365-filtering-correlation-id: a0400040-269d-47c4-49e8-08dd8349f944
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Lt+ZU9kps1LlcRtiGp4vsvERzoAqMqzQ3I+4cUbtNvS42TKhnwC1JkCQcB?=
 =?iso-8859-1?Q?RVZAv+bz4t+f0y2D1pZZVJvmNIhEWVt1CX1LSOXSI4S+d9s8FR7jmiG81f?=
 =?iso-8859-1?Q?DSCmbng9Il1exJpX2nFKBeYuh763Wsj53ZowkBTRjKjNUvaFQq8/uUmmDF?=
 =?iso-8859-1?Q?nViPFF+s9mhMb/sZz1RKOMjY8f4Dw2MOXPmQBPxfRcX4CwbrE7zriUu8Hl?=
 =?iso-8859-1?Q?BGI9f0u0Idj8ZIXCkx1rCcwOwfDMAw1cRskZOHxucoXWBYm0RYend6zIM4?=
 =?iso-8859-1?Q?2VJ3jx09WwgdxbN3/i5Y2Cmu4cSj9Ubonil2llArUt9uUAtKgYSWJN5Pwj?=
 =?iso-8859-1?Q?NApxgSR/NdglSS7iOBh2SSqwnnRoOkOCWaRB/E67b/HfqgJD76646F9gX9?=
 =?iso-8859-1?Q?K4ahli/sFNhySF8zCotBNpBgf89dVEflK4JZSCPjoob00+R/GYxfnIYO47?=
 =?iso-8859-1?Q?4PFJHxDYLEqvWmPeLF/7kiVrO8iQvURGSPREF7A0RqCANJaO8ei0nK0HbG?=
 =?iso-8859-1?Q?TlANXqeFj5yBTqRAuunHiXAnAUpqshcnsXrjlrEgfxXPqi0yQ+g3g91hcv?=
 =?iso-8859-1?Q?JFZpbtH2d8JJedgbAFpAc/a4NOCj8Fxn1UPRr0DvzbILlP5Yh1xRLWEtGH?=
 =?iso-8859-1?Q?mfqJw+/heUzb0psJtwKYfH0ogKZjEc6UF4pwYnqF9Z3rVeSVmEOIpqYhLy?=
 =?iso-8859-1?Q?Ib7ilACs2V5MhkzlU8NMyT/USuzAjRxOdt1WCUPFaeXEHvyBrpO4yYa3s7?=
 =?iso-8859-1?Q?MG6qQThvRbJOaUSzxEskLDK4kzpLZkKS297D8iGevO5T+j5aGK0F6/MAjP?=
 =?iso-8859-1?Q?KYz2fULPukGMrPrgYS1glpwDb8mQ7ec+9ai080NgsafI7HZ942dLJwt6aa?=
 =?iso-8859-1?Q?w1IjUAH2i7w38lZtYS3kUOohrGbYjfcsVYzY+wjwlpTIp2Bqwy69+Mf816?=
 =?iso-8859-1?Q?2GbkfJFVLKyIb+cM+h2y79ffP7MrUL5fKE1oXx15pDuBJY65wi4bE/qvR1?=
 =?iso-8859-1?Q?Vd6ba3bgtKT+OWKgcsUETmCgbHKzIZBcqJc1fjUE7HlfFgW80XNk5fMEeZ?=
 =?iso-8859-1?Q?Q1eCNrxHC5gSHxvkGtw9bDxOk/Hsd+WyOSPb7raxkZH8dUtC6FAena/Fz+?=
 =?iso-8859-1?Q?tSV+ejVH7L78L0JeqhR0c7ZiDGdjrNgA8HzAVB2adLQrR7RNLl2kf7dg+9?=
 =?iso-8859-1?Q?GBg7gmdvc00B/K2BhiRVT3DEhhKzMbybv2voclGflNnsyg7X3n2a7XAdPg?=
 =?iso-8859-1?Q?tCkMaTWTrkywaxoLtJb4uGTy/RGw064+VlImSTKywO7VR2HQ/yKKAhJL0Z?=
 =?iso-8859-1?Q?BVKA2tFbnJfdMbdlES1vli6mIgsD1xsymNE8hR4SaVzO+4EV4u10kGzU9O?=
 =?iso-8859-1?Q?xu6vZF4SclKaPjdwSBuPWHJ4097HvwaFPfxnC9tlgkPPEsvDwVS6B/2lUc?=
 =?iso-8859-1?Q?GGN0tni1p3aUX9d13pkRgcMkh2PoXf65Klcq4eGyqEJV+OA6e3OzVDwyKK?=
 =?iso-8859-1?Q?4HAikJNVN8QixbIuiIgpaaHZTEyrhQ4Z2otzaDA1T+vZ33LOlkScAftQtk?=
 =?iso-8859-1?Q?NmHSCmg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6803.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?scBn/1SAptaazP5V5ZBwjS02KyKtGUCu97NN8zV2jEy66naZ4r6wCohgZ5?=
 =?iso-8859-1?Q?0eP5Y42AI0K7Vf2imGD1mYt5tHAtC21k49wO7Js8Zex3PM7E3alnWPM45U?=
 =?iso-8859-1?Q?NjC/Mkxvb9ocKi7hw4a+oQj1r7acNf/CjVcGkYiIImKgXWKyulXWM8/xI+?=
 =?iso-8859-1?Q?K78d7Ajqcz1qj57vYF+SMY22TGcDLKfChjy9u8XyOcdGta2XI2Bcs+0IS1?=
 =?iso-8859-1?Q?vNqT9UGw2epqtBoNB78e0CxQb4o2gXSb3MjPR6PM/+7bFHLGTvwkWerpXm?=
 =?iso-8859-1?Q?NeyWj+lm68FgJ+hPxkBdVV3Hv67nHJqEk0pgEpyn9+c+Wh+eL2hb8U8KMk?=
 =?iso-8859-1?Q?UezJeIXrKj6ZXmvhImRt+yI3lvYFcIpPDzWTJamSZgUtCWOdiQP86pRERw?=
 =?iso-8859-1?Q?hhyactY4nkA6PpSjuo3NTiOwW52IxOcDkdK4JfnB0TUm/R62A2DDoWv6hx?=
 =?iso-8859-1?Q?j+KpuNrbsrEWxo6jJi87uXqZM6A73wKafyDPH1dfpk8Vz3+ZW/J6gEELaW?=
 =?iso-8859-1?Q?rSjcH25jIaGh3P+kFDsn921HhYJTscI34TKl4jqYLPwrcbYZ3YHODodsyD?=
 =?iso-8859-1?Q?GAe/epP83JcahiVv2rthOxto7k9nQgwWwCksjBh81NSKw3/fu8Jjc4njMZ?=
 =?iso-8859-1?Q?0OpS/dVH+R/BMEIKCzOMztXhTzKOnUR5j7MdYlvbx9c7BISWgEHOrXAW7w?=
 =?iso-8859-1?Q?D+kwEcb86fzdt3BUO6RvBcFSgnewR5cJHG8laOyyy0wjln+4AITQPg9HkI?=
 =?iso-8859-1?Q?eCATcT6Aq2jxK6NMgXxG+4taS3Y5AdnHHTkq2+/oib27t4HOKGCfVgR4zG?=
 =?iso-8859-1?Q?ycTziPVxltLqg0Anzy69o5YQBO/0Iqhd2WuzKTZx4qdX5KSIFRIoLY6UdO?=
 =?iso-8859-1?Q?B4m+QCCrDzVEV4k1sXMptNZ/CDg7gBBx8VufsOnWhnE069KiB2lLTMX0+l?=
 =?iso-8859-1?Q?k397IdpYseDLDReMDUEV0rnTKVDzzl3CZnR0jimIfZgr2GWNVFTYJKvihd?=
 =?iso-8859-1?Q?xLD6eYMMqBshC/rf5bZyLF1IQws5xpXUi/IfAWwWLFTHRvTAZCFLe2SNOb?=
 =?iso-8859-1?Q?vyeKbmTUz2GokMPhQ3gB/5JjpdJnZ45lTr7NT9cs9JCVVyu3c76CLzfW6T?=
 =?iso-8859-1?Q?4C0Z0upLtP39cB5ODADoTjXXwcBTAHFsMHfZMzOn+ODmLu2Yt9+VHa7ZyY?=
 =?iso-8859-1?Q?0767LusfON4ad9pWdnRrtrQvcGdxtskDzI36/Rf6pEDNMz9QH0rwBhAtF/?=
 =?iso-8859-1?Q?YXRpR/3cs4L2vR+i2LmCCPOh9bMB3vL670VCNFdOt27fdhrxBA/y2pv2ZK?=
 =?iso-8859-1?Q?L+U+euNiqRYd9VgJWXhd2/+1nV/qU9W+v9SLPyO6Dw8DegIKCUcGVYqQxX?=
 =?iso-8859-1?Q?cfu+LY9LEJEYAfYsOaK0WNolD5mOgExhEQ4CVAN2Nndfm49gz9vF3oQhMw?=
 =?iso-8859-1?Q?qp8GJrUCPHSHtQT3SKzB35CFjoUsWNAiPNbPO7KnrAhtOjSw+fN4diukcD?=
 =?iso-8859-1?Q?f4KH92i+X4SlbY2SMAlY5CdCPJ1whHhnKJpqN8/oQ9aQSPabLdNDsZ+s99?=
 =?iso-8859-1?Q?NAcut3q3GXtpPu+Nz+7XLQoYKQclRa3vJ1StMRrR+uSl7iUPzvSCUed2Yf?=
 =?iso-8859-1?Q?p3WzjND0mZR+BXKev1QsXJYJ4MH7ezAF0A?=
Content-Type: multipart/alternative;
 boundary="_000_PH8PR11MB680363E200616CBB39DDDCB6D7852PH8PR11MB6803namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6803.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0400040-269d-47c4-49e8-08dd8349f944
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 16:06:29.4118 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q756g5fQvwvRo/Kicl+vRDFjLBYjm0w5m/KmasQB67MK9BAVpsGhjWNtGUNsbrWhHSEpSXljiy5Y/ZcJlo+YSCGyBmUDQz+YL4N4dcnXJxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8858
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

--_000_PH8PR11MB680363E200616CBB39DDDCB6D7852PH8PR11MB6803namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> From: Gregory Etelson
> Sent: Sunday, April 20, 2025 9:57 AM
> To: Van Haaren, Harry
> Cc: dev@dpdk.org; Richardson, Bruce; owen.hilyard@unh.edu
> Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
>
> Hello Harry,
>
> I implemented a working echo server with your API.
> The code is here: https://github.com/getelson-at-mellanox/rdpdk/tree/safe=
-q

Ah cool! Great to see the API working.

Reviewing the "echo.rs" code, the MbuffMempoolHandle ergonomics can perhaps=
 be improved,
I'll try work on that and have some API suggestions to the mailing list soo=
n.

I see the echo.rs code uses a normal "std::thread::spawn" (not DPDK lcores)=
, there is
some design to do here to ensuring that best practices are used;
- any dataplane threads are registered as lcores (for best performance, mem=
pool caches etc)
- registered lcores are also unregistered when a thread ends (potentially a=
llowing lcore-id reuse??)
I haven't thought about this much, but had a brief discussion with Bruce (w=
ho is on holidays now).

Suggesting that mempools & lcores are the two next up API sets to "Rustify"=
 :)


> Several changes:
> DPDK configuration is split to 3 mandatory steps:
> port configuration in
> Port::configure(&mut self, rxq_num: u16, txq_num: u16) -> Result<(), Stri=
ng>
> Rx queues configuration in
> Port::config_rxqs(&mut self, desc_num: u16, mempool: DpdkMempool) -> Resu=
lt<(), String>
> Tx queues configuration in
> Port::config_txqs(&mut self, desc_num: u16) -> Result<(), String>
> In the IO thread, I renamed the `enable_polling()` to `activate()` for Rx=
/Tx symmetry.
> I renamed `port` and `q` struct members to `port_id`, `queue_id`

Those seem reasonable changes; no particular concerns.
We can do always do "more more more" type-safety in making it impossible to=
 mis-configure (at compile time).
While type-safety is nice, it will complicate the code too: finding the rig=
ht tradeoff is key.

For me, having the "Rxq" be pollable only from the correct thread (compile-=
time check) is the most valuable.
The configuration is "nice to have", but good/simple examples will help use=
rs start quickly too, particularly
if the APIs are simple.


> Build steps:
>
> Apply https://github.com/getelson-at-mellanox/rdpdk/blob/safe-q/dpdk-patc=
hes/0001-rust-export-missing-port-objects.patch to DPDK source.
> Install DPDK
> Set PKG_CONFIG_PATH to DPDK installation
>
> Activation:
>
> # cargo run --example echo -- -a <port PCI address>

I haven't tried these steps yet, sorry (lack of time at the moment).

> Regards,
> Gregory

Thanks again! -Harry

--_000_PH8PR11MB680363E200616CBB39DDDCB6D7852PH8PR11MB6803namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; From: Gregory Etelson</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Sent: Sunday, April 20, 2025 9:57 AM</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; To: Van Haaren, Harry</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Cc: dev@dpdk.org; Richardson, Bruce; owen.hilyard@unh.edu</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and =
Rxq</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Hello Harry,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; I implemented a working echo server with your API.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; The code is here: https://github.com/getelson-at-mellanox/rdpdk/tree/s=
afe-q</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Ah cool! Great to see the API working.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Reviewing the &quot;echo.rs&quot; code, the MbuffMempoolHandle ergonomics c=
an perhaps be improved,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I'll try work on that and have some API suggestions to the mailing list soo=
n.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I see the echo.rs code uses a normal &quot;std::thread::spawn&quot; (not DP=
DK lcores), there is</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
some design to do here to ensuring that best practices are used;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
- any dataplane threads are registered as lcores (for best performance, mem=
pool caches etc)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
- registered lcores are also unregistered when a thread ends (potentially a=
llowing lcore-id reuse??)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I haven't thought about this much, but had a brief discussion with Bruce (w=
ho is on holidays now).</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Suggesting that mempools &amp; lcores are the two next up API sets to &quot=
;Rustify&quot; :)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Several changes:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; DPDK configuration is split to 3 mandatory steps:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; port configuration in</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Port::configure(&amp;mut self, rxq_num: u16, txq_num: u16) -&gt; Resul=
t&lt;(), String&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Rx queues configuration in</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Port::config_rxqs(&amp;mut self, desc_num: u16, mempool: DpdkMempool) =
-&gt; Result&lt;(), String&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Tx queues configuration in</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Port::config_txqs(&amp;mut self, desc_num: u16) -&gt; Result&lt;(), St=
ring&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; In the IO thread, I renamed the `enable_polling()` to `activate()` for=
 Rx/Tx symmetry.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; I renamed `port` and `q` struct members to `port_id`, `queue_id`</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Those seem reasonable changes; no particular concerns.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
We can do always do &quot;more more more&quot; type-safety in making it imp=
ossible to mis-configure (at compile time).</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
While type-safety is nice, it will complicate the code too: finding the rig=
ht tradeoff is key.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
For me, having the &quot;Rxq&quot; be pollable only from the correct thread=
 (compile-time check) is the most valuable.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
The configuration is &quot;nice to have&quot;, but good/simple examples wil=
l help users start quickly too, particularly</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
if the APIs are simple.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Build steps:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Apply https://github.com/getelson-at-mellanox/rdpdk/blob/safe-q/dpdk-p=
atches/0001-rust-export-missing-port-objects.patch to DPDK source.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Install DPDK</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Set PKG_CONFIG_PATH to DPDK installation</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Activation:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; # cargo run --example echo -- -a &lt;port PCI address&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I haven't tried these steps yet, sorry (lack of time at the moment).</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Gregory</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thanks again! -Harry</div>
</body>
</html>

--_000_PH8PR11MB680363E200616CBB39DDDCB6D7852PH8PR11MB6803namp_--
