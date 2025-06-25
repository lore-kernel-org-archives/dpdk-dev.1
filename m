Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40E2C7115C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 14:01:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 504E440E09;
	Wed, 25 Jun 2025 16:01:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 2FCA9402B9;
 Wed, 25 Jun 2025 16:01:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750860083; x=1782396083;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GPZmYNjF+s168IzupO+wBBcr3Ld6Oz37ef2hUwxv5fI=;
 b=NrdAvfMsX2kyxMB/G9TfYTnkjUbPCPopVZrz4KrxTadfCeOiH84U1RUZ
 iGWt2Y4s5IIXLbLRFClwU3A6qj24mN1idX4JmYB64dxrsGE8oCrnba4DI
 HfHsdN6MohRTrTfj6ByFtFyMP8ayVpELai1UcADelJ3KuMxJeZqL6tW6x
 z0apST9vUJT5lJrSZzHVqQC0zTw+Mo81vBlX7EtcZPbOgm1FEwX9mutIO
 JMLVWGsJebUFks7xWsKJDjrlRoIRsUI8NY+U5BX7O8AoLD5WwlVYRC6zL
 AC93QjjMl1SXwUrhbKDPLdkaoy969bKtWvarsnixMQAyD1Dh8uModAMe9 A==;
X-CSE-ConnectionGUID: lqN1D9nsSN+SsGNRS6m1LQ==
X-CSE-MsgGUID: M10VekDhQoSFgycA/ezVrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="70564589"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; d="scan'208";a="70564589"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2025 07:01:22 -0700
X-CSE-ConnectionGUID: MtW9MpbSRYe2ltd1tvQgXw==
X-CSE-MsgGUID: zSS+5+zdQme3UYFEeaUk2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; d="scan'208";a="157726838"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2025 07:01:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 07:01:19 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 07:01:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.43)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 07:01:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNGs9CqNEzB6R3yvERx7ihf1JNcFT3mJsuFVViJBvY3Z8I0eqh42qTiDvJAJIAMjSBqdguZmMhQWVtwlQDvaa//Oy2yEVHQzr1pGM0uDLwClr5hO9xomKp5rJXgIxaggPRGewmQV0U3T5wkQwxWlCVDuaeHKJU5IGSHGlYZwM9tFUVf0Epe5EZlcWdJClISN7UjQTg94/aUI/el43MGjobw1YQ3oRGt5VDMgZquu987Vp9GFL26RoevurDqRsF/GBTAOTj64BK8LAgyrRv2ag4dKVSt+5DxWQEIYxeUgv8/Jb2jeahpTetED/6k1fPeu/0rSFMbIhVg2gYdJ9CVVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPZmYNjF+s168IzupO+wBBcr3Ld6Oz37ef2hUwxv5fI=;
 b=oP7xJ9lV1Hp7yzbzsPM47enxINj9pfUQ2X3nfAbFRLnAFnhAjd5edx2ZOJTwe8TITbP/2DHTcb12I4i3GHy/D1ZN7yepk/AVIvJX+ldISbfRYxkedsi9uDpO2Dy3qthbucsE5eTR/O1vVcuz5oWPq3JH4hj8iV4Asw1Ur70fW36PxoGz4GFJT3uxHycn6bk0FJwJejtwIKzQRqoW5gJSrTA+wgyC/RYkvNLthU/0EGa47UkgMP2l4biiCZibIRQ4sIz4vM+tzlU1tfAxqsSBItr13VaWeKAQO03IngbRwx+WeSkxrOuE8zefx/I3m2dMKaiK/1C39uFGj2mf6NF6uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by DS0PR11MB8183.namprd11.prod.outlook.com
 (2603:10b6:8:161::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 14:01:16 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::19b1:dfa1:9d1f:38e9]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::19b1:dfa1:9d1f:38e9%8]) with mapi id 15.20.8769.025; Wed, 25 Jun 2025
 14:01:16 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2] net/iavf: fix VLAN offload strip flag
Thread-Topic: [PATCH v2] net/iavf: fix VLAN offload strip flag
Thread-Index: AQHb5Gpb7TXAi/b41EmOaR4zKI/ft7QRFnSAgADyFWCAAGg1AIABeY7A
Date: Wed, 25 Jun 2025 14:01:15 +0000
Message-ID: <DM3PPF7D18F34A1770F61E83BA4D365FDDD8E7BA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250621015624.35284-1-amiyaranjan.mohakud@gmail.com>
 <20250623181136.48239-1-amiyaranjan.mohakud@gmail.com>
 <CAL+mCpOU+q542mGrA+aT+nO8Rs4dtAY==U2SbvYJFvVd1e4qCA@mail.gmail.com>
 <DM3PPF7D18F34A1A1141693EF5A3DDF8B588E78A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
 <CAL+mCpMZDed=QQ-RH0Y0GT095Cnyhz2rsvg8abKuM4_U13-eGw@mail.gmail.com>
In-Reply-To: <CAL+mCpMZDed=QQ-RH0Y0GT095Cnyhz2rsvg8abKuM4_U13-eGw@mail.gmail.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|DS0PR11MB8183:EE_
x-ms-office365-filtering-correlation-id: 8abd551d-8f09-4622-db24-08ddb3f0c093
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aEdKWTFLZ21hNi9VZmx1RVZZY1BSWnhpRi9IRDBJYlM2NXQ5UmtPVXJobU9t?=
 =?utf-8?B?dTl1NjFybnFLMzF5aW1mSEY3cVdSQXNpMlBnR2NMVnQrTTFaL1dxclhDYTI5?=
 =?utf-8?B?TEwybnFlMlpjd0F0V2I0Q2NudnVTSUMyRjk2T1M4NGNoeDU5SkVMbDhjN1gr?=
 =?utf-8?B?VS9lQnhxVzBqR0U0M3U0c2U0a1R1T0s2UzFpQVhISC9jY3g4MDRGSjFjNzI3?=
 =?utf-8?B?NlAvOWtIYTNqbkdUSXRiVTNQK0czbERWMTFVN1oxeUc4amNFazRoSDc0MGRz?=
 =?utf-8?B?UU9pakJXVTRJYUsxWGdBZTBYRkFwN2ptZXhOeG9FVzBmWnMxcEYwejc1V2Rr?=
 =?utf-8?B?VERPTjVINGppYmh0L1NCUWFFNGNGOCtDZlAxbUh5ZUVYUklMUW1mQU51ZCtt?=
 =?utf-8?B?aVBGZXR2RjlEQ3VzenlPWmFkREdpOU9iVDIzTkhla2JEeDdwRDdWV1dOdTdz?=
 =?utf-8?B?WW1IYlRBSG1NREt4RWY0MlBqRUtuc0Qvd3ViWjl2ditZRldGTUNqbVcyTTlI?=
 =?utf-8?B?Q0RQM0ZoKytnU3VhYXNmRUJ5azY4Vm1UZHJkNWNxNzZHQXRxaDZTd0pwTGdU?=
 =?utf-8?B?MmNVWGZYOUpOdWhUajIxcVQ3ZHNsb2pRSzNHL3hBZ0dSRk1hUTJBUy9kYmhy?=
 =?utf-8?B?RG95RXlTbjNMVFF0SEIrZCthM1Y5cXJCcktDRkF4UVFuVTd2UEJhK0V3ZFh1?=
 =?utf-8?B?TnZUTDdpSW1Bc0NzcHRhd1RDS1R3dFA4VEFmNjg1akg5bzBlTWRLZThxcUdh?=
 =?utf-8?B?SGNERE54Rkx4N2FFSEp3UUlNU094VnNKK1VFOFcxd25mN2pYWElDQkxSeWtQ?=
 =?utf-8?B?MytROEZRYUN0amFoRzZxTm9QUitrWi82SmhBc3JzUjdNazRDaUVFYnFJbWZa?=
 =?utf-8?B?SkhPU1NyNUI4NnlQMjJRQmVBaXAyRjlodkFSY281OXFrclllL2VlNjkySEIy?=
 =?utf-8?B?cTIyWTZ2UVFNM0RkdEpMZHVaM1h6STV4S3FLRFp0RndlSUttK0tONFdNdkdI?=
 =?utf-8?B?YTFuaDdsNUZ4QlZZNGQ2TUJtQXpwdkU0Uzh6b3NOTHIyby9HZS9DMG9zQkpF?=
 =?utf-8?B?RDRnUHhSZzZ1WThhQkdzbFBXbVI3SkpyTUFBaW9VZjBUdm0vNGVRYk9KSWhm?=
 =?utf-8?B?MUZmZThnWnQvWHNyZmJTc01VeDRwMnIzVkZqLy9ZNENXajZMclVkWTFWNlJH?=
 =?utf-8?B?TWdRSzRyYlpHU1BDZnQ0WjlVODlOUC9LS0k5dUJNTmdhNnBGYUlqU2VpYVdO?=
 =?utf-8?B?OHNVZDJ3ajNmQSs4NkZtWXY0djFTZzdaTVFpZ0NrUkJKL0VoTjVON0lsZ1J1?=
 =?utf-8?B?UkQwVXFqT2xabFJCdDBrRk93NzBQM040aVd1UXhPRDBQVGVjeEZGL3U0SWMz?=
 =?utf-8?B?eDFqbTVnbnhseCtDajhyTC9kODhkeWY5MmliOGJTSHdmV09LeW5IZTNTcVc3?=
 =?utf-8?B?ZWJuS3NQNEtESU95WkFzb1BUMVVMbHZEU29tc1J5L2VjWmFIdndWUVQxaU91?=
 =?utf-8?B?dXJNNTQvOXZncjVTUTdLMVhudW1DazhEbDdyQk5ldUxnSkxEYkhlSllJVU5a?=
 =?utf-8?B?ZzZweXNIL0g0ZEFBdXplOWVOQ1B5Ui9GT0NSRVMyNzR4dHRLVXRsMFpMYzV6?=
 =?utf-8?B?ZDNXQmx3UHpGeGx2anBRbVoxSUIyeURlUDYxVmJmTk5QV24wcThzWlVsOWt2?=
 =?utf-8?B?Mm5laDlhTWpIVGtnei9JeVNMOHJGUHZWc3pnQThnUjFHeDdLYjh0NDdPeUhC?=
 =?utf-8?B?bkZkRFJZZzRiRTdEVndmTUJpMUR0VGF4cGs2dDVRTXYwMUhQSE0rcXFwN1lx?=
 =?utf-8?B?QklwVlpPMm1od3RFZW9UcmM4S2FmK0NUQytJVDlXKzRYYk5VaStsdUtLdmRz?=
 =?utf-8?B?Z3ZqZG5wcEE4YmtQOWFKYnppQjlwTVRaZlorMVUwZWtjZE5HSHo3RmdZYmNt?=
 =?utf-8?B?TFdKTjk0WTUzQ3V5bkZqNDFGdThVaFRhbWZIbEJFdzcrY1ZseEs5b0NJMnQy?=
 =?utf-8?Q?5xZHDGpdGSor+VZsCojqSwFfGj5CcU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTRSTENycjQxaWRsSGtXNCtMbzZTdUpsN0Z3WmxhVllBWjZnV2gzYVhIMHhW?=
 =?utf-8?B?MnloM05oNkhpcVRlaElXYlRxMmp5amNjbndaOERzNGpFazhUamRnallRSGU1?=
 =?utf-8?B?dkFvWHdVTUVYMlRUcDR1TjhLZG9zQko5VTRXVDErQk5HbTIzeG9yekNUcUNj?=
 =?utf-8?B?UU9rRmJ3YnZ5NktpNWtWYUZmcWE2eDQ4NDRNdkhPcHVmQ0dQVCtpN3B5K0t3?=
 =?utf-8?B?QmIrZnpDc1VFWUhUbGpvSE5hWU9reVl3UWI1T1JFRVl6eVhXMitRZ2s2c05U?=
 =?utf-8?B?WGxra0VKaGh2YkFHVkZnNEdvNThjb2dxY0JEOFNtL0FXcE9RTlFNSDNOOFlX?=
 =?utf-8?B?S3dibUdFbEk0Tmx2bmhwWExxWDNTRUorSDJueFMwZkVLUWMwRVVkQndCaFQv?=
 =?utf-8?B?bHhFeDYwNitRb0Qvam45b2FaNVZIWlJqbTZEUUJ6YmlGOGs5WEVwbnFuTTd4?=
 =?utf-8?B?NElTdmpLbHc2WHN5ek4zcmJoRlYrb1grM1JKbVJ3VjA2N2dZWlNzNDdXTm9t?=
 =?utf-8?B?d3VOeWxOODZKczM2MDhFektVQ1Y0ZitZdWNzbWNZRXlTaUFEUEYyOTUzN2hW?=
 =?utf-8?B?WDVTbG5zdmk4VU0vNnNqdFdYeXZNV2RoVTBwZ096VU5kV1NTWW5IelUrUS82?=
 =?utf-8?B?Yk9qMVQwdHY2KzNvSktzL2ExR3JhdXpiNkdEaFNQYWlNVUxuZllQYkUwT29D?=
 =?utf-8?B?SzR3SzhMZDdkY0Y4LzVMaktQZ2RnM2dtR2tHSkVrRXZaODJWSExHYW1haFFU?=
 =?utf-8?B?alpNWGJJKy8rdnRsRVVXaWlxSUtSRnJiUXcyUU1sZnlaVHB5bG8xaXdNTTAy?=
 =?utf-8?B?MnlRS251UDNXKzZFbnZvekRWVkVUOS81Nlc2SU5ML1p2U004Y1o4SmNWWVlX?=
 =?utf-8?B?NnFxaS8vSHJpUzhOQ0FiVzZUNkhINHlkWDFnSnhXeU1URHVqeXF5QUYrbVdx?=
 =?utf-8?B?dGxOMk84NGZ2a1RXQVlkMGprR2VzN3NzTE5YK015bkpVdEZMMHZDZStnVHNK?=
 =?utf-8?B?S1BkenA4eHRZSkRpakpHbnhwUFVlZWsrVXU2ZTZ6S3B4aC9EZXVFaFVBWkIw?=
 =?utf-8?B?RGJ5Q01rNkNBc1RTZVVYcEkrRkwvSmpuWHk3Y2NVUzJXa3dkSjJQOTlVcmlD?=
 =?utf-8?B?ZWNEU1FMc1BTUE9lVXlzYk4wMGY4WTJzcFBGRi9GQm1OL01xbExHWFgvYkYy?=
 =?utf-8?B?cEg1OGV2ckhGTHJpRDNab3ZIRW95TmFrTllLelZ2amlESXZVVXhCVXN0RWt2?=
 =?utf-8?B?NVZockNJUFRPaTEyUzRqQkE3MTNUQ0FkYm5YWmNZc0VxMEhnS0VUTFRkWHgx?=
 =?utf-8?B?RGJMOU9zaFJCczhIWjBSeWdIa3NjU24wVEhqOE5CenY0TUV4MnQ5WXlVaWJE?=
 =?utf-8?B?WW9qYlo0cyttbEdjK0RzV0VHd0IxTGYxc1k5ZWFNc2xhSlQxcmJSTm9CaHJB?=
 =?utf-8?B?cVlLbXZOQXF4Z3NLTW9nNVdwUWNhMzgwR3ZSRjJSOVVSMzBxc1dHV0N2eE00?=
 =?utf-8?B?MWtoRWo2cE5KRlZpU2gwZXJmS01zU3JOSWJBcHNrYzk4amtuclRGMStBcVpz?=
 =?utf-8?B?bXM4SG1UT0ZINWVTNTVuMXBUOXZQTmlqYXdlV0VDNUkwNjNITmh3VUdYaElZ?=
 =?utf-8?B?TVJUYTlrY0IyTmwreFB0eEVKVkFKbUpVV1MrK0ZrMmU0OStiWEVuUDRXL1li?=
 =?utf-8?B?YlNqOEtUbUNGT3drYm1UZ3RrdFBaU04wc2VuTzFLZWZZVVk0cVBMUjlDQU1a?=
 =?utf-8?B?UG5ISGZEcXJ6blVCbGEwSDBNb1UvdWkzTCtVYkIySk9IL1Q1VmtpZ3E5WTBD?=
 =?utf-8?B?cExqK21PYXg3ejNrU2J2K3d3ZC9ZRHpqdWJHSVZMeHZvRGpQNDFyUmFoVlpC?=
 =?utf-8?B?V3JWUFMxb1I1N2ZHWVNab0JZQUU3emVSOStTeHRyLzU2WXVSUGcwWjJyMTRh?=
 =?utf-8?B?aTZ6RlN3QmVXUlcvVzVONGtOOEFMb2QwN25vbDNBM3BkNlFqNWcxRWI3WTRI?=
 =?utf-8?B?ZXZ0ZFdJSW50djdpS0dYdjloT3A5Y1pHWVBIRlpxTlRxK1QybXN5c201WjlD?=
 =?utf-8?B?NkRrOStXSE8yU2ZQZjBJWlZ5R013TElKamEydllKUkJRQlN4cGgvRm5jb1Q2?=
 =?utf-8?Q?mMU0krKY5867r9jBZs57t7N4S?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abd551d-8f09-4622-db24-08ddb3f0c093
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 14:01:16.0608 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 59IPl7OD00q7S9CYoqMYEx6ATjMouFqDEFJ0J5dk4l0I4kMlYMMastoHsB55FawtFv5BygxXBfYDnBZFDSFVmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8183
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

PiANCj4gVGhhbmtzLg0KPiANCj4gSnVzdCB3YW50ZWQgdG8ga25vd8KgIC0gd2hhdCBhcmUgdGhl
IG5leHQgc3RlcHMgb2YgdGhlIHJldmlldyBhbmQgYXBwcm92YWwNCj4gcHJvY2Vzcz8NCj4gDQo+
IFRoZXJlIGlzIGEgdGVzdCBzdWl0ZSAiY2kvaW50ZWwtVGVzdGluZyIgZmFpbGluZyBub3cgd2l0
aCB2MiB3aGljaCBwYXNzZWQgaW4gdjEuICgNCj4gV2Uga25vdyBmb3Igc3VyZSwgdGhlcmUgaXMg
YWJzb2x1dGVseSBubyBjb2RlIGNoYW5nZSBiZXR3ZWVuIHYxIGFuZCB2Mg0KPiBleGNlcHQgdGhl
IGNvbW1pdCBtZXNzYWdlKS4gSXMgdGhlcmUgYSB3YXkgdG8gdHJpZ2dlciB0aGUgdGVzdCBzdWl0
ZSBhZ2Fpbj8NCg0KSGkgQW1peWEsDQoNClRoZXJlIGlzIG5vIGZ1cnRoZXIgYWN0aW9uIHJlcXVp
cmVkIG9uIHlvdXIgZW5kIHNpbmNlIHRoZSBmYWlsdXJlIHNlZW1zIGxpa2UgYW4gaXNzdWUgd2l0
aCB0aGUgdGVzdCBpbmZyYXN0cnVjdHVyZS4gSWYgdGhlIG1haW50YWluZXIgZm9yIHRoZSBpbnRl
bCBuZXh0LW5ldCB0cmVlIGlzIGhhcHB5IHdpdGggdGhlIHBhdGNoIHRoZXkgd2lsbCBwdWxsIGl0
IGludG8gdGhlIHRyZWUuDQoNClRoYW5rcywNCkNpYXJhDQoNCj4gDQo+IFRoYW5rcw0KPiBBbWl5
YQ0KPiANCj4gDQo+IE9uIFR1ZSwgMjQgSnVuIDIwMjUgYXQgMTQ6NDksIExvZnR1cywgQ2lhcmEg
PG1haWx0bzpjaWFyYS5sb2Z0dXNAaW50ZWwuY29tPg0KPiB3cm90ZToNCj4gPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYyXSBuZXQvaWF2ZjogZml4IFZMQU4gb2ZmbG9hZCBzdHJpcCBmbGFnDQo+ID4N
Cj4gPiBIacKgQ2lhcmENCj4gPiBUaGFua3MgZm9yIHlvdXIgZWZmb3J0IGluIHJlcHJvZHVjaW5n
IHRoZSBpc3N1ZSBhbmQgY29uZmlybWluZyB0aGF0IHRoZSBwYXRjaA0KPiA+IHdvcmtzLsKgSG93
ZXZlciwgSSBoYXZlIHRha2VuIGNhcmUgb2YgdGhlIGluZGVudGF0aW9uIGluIHRoZSBjb21taXQg
bWVzc2FnZQ0KPiA+IGFuZCBzZW50IG91dCBhIHYyIHBhdGNoLsKgQXBwcmVjaWF0ZSB5b3VyIHJl
dmlld8KgY29tbWVudHMuDQo+ID4NCj4gPiA+Pj5QZXJoYXBzIHdlIHNob3VsZCBtYWtlIHRoZSBk
aXNhYmxpbmcgdW5jb25kaXRpb25hbCBvciBldmVuIGJldHRlciBtYWtlDQo+IGl0DQo+ID4gZGVw
ZW5kIG9uIGlmIHRoZSBzdHJpcHBpbmcgd2FzIGVuYWJsZWQgYWx0aG91Z2ggSSdtIG5vdCBzdXJl
IGlmIHRoZXJlJ3MgYSB3YXkNCj4gPiB0byBjaGVjayBmb3IgdGhpcy4NCj4gPg0KPiA+IEkgdW5k
ZXJzdGFuZCBhbmQgYWdyZWUgd2l0aCB5b3VyIHBvaW50IG9mIGRpc2FibGluZyB2bGFuX3N0cmlw
IGFmdGVyIGNoZWNraW5nDQo+IGlmDQo+ID4gdGhlIHN0cmlwcGluZyBpcyBlbmFibGVkLiBCdXQg
bGlrZSB5b3UgbWVudGlvbmVkLCBJJ20gYWxzbyBub3Qgc3VyZSBpZiB0aGVyZSBpcw0KPiA+IGFu
eSB3YXkgdG8ga25vdyB0aGF0Lg0KPiA+DQo+ID4gSG93ZXZlciwgSSB0aGluaywgdGhlIGN1cnJl
bnQgY2hlY2sgYWxzbyBkb2VzIGEgZ29vZCBqb2IgYnkgY2hlY2tpbmcgdGhlDQo+ID4gZGV2X2Nv
bmYgcGFyYW1ldGVyIGFnYWluc3TCoFJURV9FVEhfUlhfT0ZGTE9BRF9WTEFOX1NUUklQIGFuZCBy
ZS0NCj4gPiBkaXNhYmxlcyB0aGUgdmxhbl9zdHJpcCBhZnRlciBldmVyeSB2bGFuX2FkZCBvcGVy
YXRpb24uDQo+IA0KPiBUaGFua3MgZm9yIHRoZSB2Mi4NCj4gSSB0aGluayB0aGlzIGFwcHJvYWNo
IGlzIGZpbmUgZm9yIG5vdywgaXQgbWF0Y2hlcyB3aGF0IHdhcyBhbHJlYWR5IGluIHBsYWNlIGZv
cg0KPiBWSVJUQ0hOTF9WRl9PRkZMT0FEX1ZMQU4oVjEpLg0KPiBBIGZ1dHVyZSBpbXByb3ZlbWVu
dCB3b3VsZCBiZSB0byBmaW5kIGEgd2F5IHRvIGRldGVybWluZSBpZiB0aGUgc3RyaXBwaW5nDQo+
IHdhcyByZS1lbmFibGVkIGFuZCBvbmx5IGF0dGVtcHQgdG8gZGlzYWJsZSBpbiB0aGF0IGNhc2Uu
DQo+IA0KPiA+DQo+ID4NCj4gPiBUaGFua3MNCj4gPiBBbWl5YQ0KPiA+DQo+ID4NCj4gPiBPbiBN
b24sIDIzIEp1biAyMDI1IGF0IDIzOjQxLCBBbWl5YSBSYW5qYW4gTW9oYWt1ZA0KPiA+IDxtYWls
dG86bWFpbHRvOmFtaXlhcmFuamFuLm1vaGFrdWRAZ21haWwuY29tPiB3cm90ZToNCj4gPiBGb3Ig
aTQwZSBrZXJuZWwgZHJpdmVycyB3aGljaCBzdXBwb3J0IGVpdGhlciB2bGFuKHYxKSBvciB2bGFu
KHYyKQ0KPiA+IFZJUlRDSE5MIE9QLGl0IHdpbGwgc2V0IHN0cmlwIG9uIHdoZW4gc2V0dGluZyBm
aWx0ZXIgb24uIEJ1dCBkcGRrDQo+ID4gc2lkZSB3aWxsIG5vdCBjaGFuZ2Ugc3RyaXAgZmxhZy4g
VG8gYmUgY29uc2lzdGVudCB3aXRoIGRwZGsgc2lkZSwNCj4gPiBleHBsaWNpdGx5IGRpc2FibGUg
c3RyaXAgYWdhaW4uDQo+ID4NCj4gPiBCdWd6aWxsYSBJRDoxNzI1DQo+ID4gQ2M6IG1haWx0bzpt
YWlsdG86c3RhYmxlQGRwZGsub3JnDQo+ID4NCj4gPiB2MjoNCj4gPiAtIEZpeGVkIGluZGVudGF0
aW9uIGluIGNvbW1pdCBtZXNzYWdlDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbWl5YSBSYW5q
YW4gTW9oYWt1ZA0KPiA+IDxtYWlsdG86bWFpbHRvOmFtaXlhcmFuamFuLm1vaGFrdWRAZ21haWwu
Y29tPg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9uZXQvaW50ZWwvaWF2Zi9pYXZmX2V0aGRldi5j
IHwgNDggKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQs
IDI5IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L2ludGVsL2lhdmYvaWF2Zl9ldGhkZXYuYw0KPiA+IGIvZHJpdmVycy9uZXQv
aW50ZWwvaWF2Zi9pYXZmX2V0aGRldi5jDQo+ID4gaW5kZXggYjNkYWNiZWY4NC4uZjkzZTdiZjlh
ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9pbnRlbC9pYXZmL2lhdmZfZXRoZGV2LmMN
Cj4gPiArKysgYi9kcml2ZXJzL25ldC9pbnRlbC9pYXZmL2lhdmZfZXRoZGV2LmMNCj4gPiBAQCAt
MTM3OCwxMyArMTM3OCwzOCBAQCBpYXZmX2Rldl9kZWxfbWFjX2FkZHIoc3RydWN0IHJ0ZV9ldGhf
ZGV2DQo+ID4gKmRldiwgdWludDMyX3QgaW5kZXgpDQo+ID4gwqAgwqAgwqAgwqAgdmYtPm1hY19u
dW0tLTsNCj4gPiDCoH0NCj4gPg0KPiA+ICtzdGF0aWMgaW50DQo+ID4gK2lhdmZfZGlzYWJsZV92
bGFuX3N0cmlwX2V4KHN0cnVjdCBydGVfZXRoX2RldiAqZGV2LCBpbnQgb24pDQo+ID4gK3sNCj4g
PiArwqAgwqAgwqAgwqAvKiBGb3IgaTQwZSBrZXJuZWwgZHJpdmVycyB3aGljaCBzdXBwb3J0cyBi
b3RoIHZsYW4odjEgJiB2MikgVklSVENITkwNCj4gPiBPUCwNCj4gPiArwqAgwqAgwqAgwqAgKiBp
dCB3aWxsIHNldCBzdHJpcCBvbiB3aGVuIHNldHRpbmcgZmlsdGVyIG9uIGJ1dCBkcGRrIHNpZGUg
d2lsbCBub3QNCj4gPiArwqAgwqAgwqAgwqAgKiBjaGFuZ2Ugc3RyaXAgZmxhZy4gVG8gYmUgY29u
c2lzdGVudCB3aXRoIGRwZGsgc2lkZSwgZXhwbGljaXRseSBkaXNhYmxlDQo+ID4gK8KgIMKgIMKg
IMKgICogc3RyaXAgYWdhaW4uDQo+ID4gK8KgIMKgIMKgIMKgICoNCj4gPiArwqAgwqAgwqAgwqAg
Ki8NCj4gPiArwqAgwqAgwqAgwqBzdHJ1Y3QgaWF2Zl9hZGFwdGVyICphZGFwdGVyID0NCj4gPiAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBJQVZGX0RFVl9QUklWQVRFX1RPX0FEQVBURVIoZGV2LT5k
YXRhLT5kZXZfcHJpdmF0ZSk7DQo+ID4gK8KgIMKgIMKgIMKgc3RydWN0IHJ0ZV9ldGhfY29uZiAq
ZGV2X2NvbmYgPSAmZGV2LT5kYXRhLT5kZXZfY29uZjsNCj4gPiArwqAgwqAgwqAgwqBpbnQgZXJy
Ow0KPiA+ICsNCj4gPiArwqAgwqAgwqAgwqBpZiAoYWRhcHRlci0+aHcubWFjLnR5cGUgPT0gSUFW
Rl9NQUNfWEw3MTAgfHwNCj4gPiArwqAgwqAgwqAgwqAgwqAgwqBhZGFwdGVyLT5ody5tYWMudHlw
ZSA9PSBJQVZGX01BQ19WRiB8fA0KPiA+ICvCoCDCoCDCoCDCoCDCoCDCoGFkYXB0ZXItPmh3Lm1h
Yy50eXBlID09IElBVkZfTUFDX1g3MjJfVkYpIHsNCj4gPiArwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpZiAob24gJiYgIShkZXZfY29uZi0+cnhtb2RlLm9mZmxvYWRzICYNCj4gPiBSVEVfRVRIX1JY
X09GRkxPQURfVkxBTl9TVFJJUCkpIHsNCj4gPiArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBlcnIgPSBpYXZmX2Rpc2FibGVfdmxhbl9zdHJpcChhZGFwdGVyKTsNCj4gPiArwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoZXJyKQ0KPiA+ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtRUlPOw0KPiA+ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0NCj4gPiArwqAgwqAgwqAgwqB9DQo+ID4gK8KgIMKgIMKg
IMKgcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gwqBzdGF0aWMgaW50DQo+ID4gwqBpYXZm
X2Rldl92bGFuX2ZpbHRlcl9zZXQoc3RydWN0IHJ0ZV9ldGhfZGV2ICpkZXYsIHVpbnQxNl90IHZs
YW5faWQsIGludCBvbikNCj4gPiDCoHsNCj4gPiDCoCDCoCDCoCDCoCBzdHJ1Y3QgaWF2Zl9hZGFw
dGVyICphZGFwdGVyID0NCj4gPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJQVZGX0RFVl9QUklW
QVRFX1RPX0FEQVBURVIoZGV2LT5kYXRhLT5kZXZfcHJpdmF0ZSk7DQo+ID4gwqAgwqAgwqAgwqAg
c3RydWN0IGlhdmZfaW5mbyAqdmYgPSBJQVZGX0RFVl9QUklWQVRFX1RPX1ZGKGFkYXB0ZXIpOw0K
PiA+IC3CoCDCoCDCoCDCoHN0cnVjdCBydGVfZXRoX2NvbmYgKmRldl9jb25mID0gJmRldi0+ZGF0
YS0+ZGV2X2NvbmY7DQo+ID4gwqAgwqAgwqAgwqAgaW50IGVycjsNCj4gPg0KPiA+IMKgIMKgIMKg
IMKgIGlmIChhZGFwdGVyLT5jbG9zZWQpDQo+ID4gQEAgLTEzOTQsNyArMTQxOSw4IEBAIGlhdmZf
ZGV2X3ZsYW5fZmlsdGVyX3NldChzdHJ1Y3QgcnRlX2V0aF9kZXYgKmRldiwNCj4gPiB1aW50MTZf
dCB2bGFuX2lkLCBpbnQgb24pDQo+ID4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZXJyID0gaWF2
Zl9hZGRfZGVsX3ZsYW5fdjIoYWRhcHRlciwgdmxhbl9pZCwgb24pOw0KPiA+IMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGlmIChlcnIpDQo+ID4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgcmV0dXJuIC1FSU87DQo+ID4gLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIDA7
DQo+ID4gKw0KPiA+ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBpYXZmX2Rpc2FibGVf
dmxhbl9zdHJpcF9leChkZXYsIG9uKTsNCj4gPiDCoCDCoCDCoCDCoCB9DQo+ID4NCj4gPiDCoCDC
oCDCoCDCoCBpZiAoISh2Zi0+dmZfcmVzLT52Zl9jYXBfZmxhZ3MgJiBWSVJUQ0hOTF9WRl9PRkZM
T0FEX1ZMQU4pKQ0KPiA+IEBAIC0xNDA0LDIzICsxNDMwLDcgQEAgaWF2Zl9kZXZfdmxhbl9maWx0
ZXJfc2V0KHN0cnVjdCBydGVfZXRoX2Rldg0KPiAqZGV2LA0KPiA+IHVpbnQxNl90IHZsYW5faWQs
IGludCBvbikNCj4gPiDCoCDCoCDCoCDCoCBpZiAoZXJyKQ0KPiA+IMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHJldHVybiAtRUlPOw0KPiA+DQo+ID4gLcKgIMKgIMKgIMKgLyogRm9yIGk0MGUga2Vy
bmVsIGRyaXZlciB3aGljaCBvbmx5IHN1cHBvcnRzIHZsYW4odjEpIFZJUlRDSE5MIE9QLA0KPiA+
IC3CoCDCoCDCoCDCoCAqIGl0IHdpbGwgc2V0IHN0cmlwIG9uIHdoZW4gc2V0dGluZyBmaWx0ZXIg
b24gYnV0IGRwZGsgc2lkZSB3aWxsIG5vdA0KPiA+IC3CoCDCoCDCoCDCoCAqIGNoYW5nZSBzdHJp
cCBmbGFnLiBUbyBiZSBjb25zaXN0ZW50IHdpdGggZHBkayBzaWRlLCBkaXNhYmxlIHN0cmlwDQo+
ID4gLcKgIMKgIMKgIMKgICogYWdhaW4uDQo+ID4gLcKgIMKgIMKgIMKgICoNCj4gPiAtwqAgwqAg
wqAgwqAgKiBGb3IgaTQwZSBrZXJuZWwgZHJpdmVyIHdoaWNoIHN1cHBvcnRzIHZsYW4gdjIsIGRw
ZGsgd2lsbCBpbnZva2UgdmxhbiB2Mg0KPiA+IC3CoCDCoCDCoCDCoCAqIHJlbGF0ZWQgZnVuY3Rp
b24sIHNvIGl0IHdvbid0IGdvIHRocm91Z2ggaGVyZS4NCj4gPiAtwqAgwqAgwqAgwqAgKi8NCj4g
PiAtwqAgwqAgwqAgwqBpZiAoYWRhcHRlci0+aHcubWFjLnR5cGUgPT0gSUFWRl9NQUNfWEw3MTAg
fHwNCj4gPiAtwqAgwqAgwqAgwqAgwqAgwqBhZGFwdGVyLT5ody5tYWMudHlwZSA9PSBJQVZGX01B
Q19YNzIyX1ZGKSB7DQo+ID4gLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKG9uICYmICEoZGV2
X2NvbmYtPnJ4bW9kZS5vZmZsb2FkcyAmDQo+ID4gUlRFX0VUSF9SWF9PRkZMT0FEX1ZMQU5fU1RS
SVApKSB7DQo+ID4gLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJyID0gaWF2
Zl9kaXNhYmxlX3ZsYW5fc3RyaXAoYWRhcHRlcik7DQo+ID4gLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaWYgKGVycikNCj4gPiAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLUVJTzsNCj4gPiAtwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB9DQo+ID4gLcKgIMKgIMKgIMKgfQ0KPiA+IC3CoCDCoCDCoCDCoHJldHVybiAwOw0KPiA+
ICvCoCDCoCDCoCDCoHJldHVybiBpYXZmX2Rpc2FibGVfdmxhbl9zdHJpcF9leChkZXYsIG9uKTsN
Cj4gPiDCoH0NCj4gPg0KPiA+IMKgc3RhdGljIHZvaWQNCj4gPiAtLQ0KPiA+IDIuMzkuNSAoQXBw
bGUgR2l0LTE1NCkNCg==
