Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FBECCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 14:36:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54C0741144;
	Fri, 17 Oct 2025 16:36:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 60AF0400D7;
 Fri, 17 Oct 2025 16:36:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760711770; x=1792247770;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=d5gNFl3LhYPlqVy24OFxrI3socVU7UT1j93pagPEulM=;
 b=EE1FcY0kqp1a8+qga7CZIc/XRnKTasRnYRo5aNirB+rlSMy0fWG772dR
 ARaW0n31fIzIztN4ANpRs46qohG6zqWT77PajgaqLXxJt3ClSJx30Bmaq
 TtJzg9JdLmvX8ynvwQ1rgzKylhqC7OwnxAQAeMuNhnGsBN2PCmw/oOPYo
 FjRDGl8t+uJXo0DKSgOuzyaOXHMxWtPdtJB+kX6s2OqKyGjRV8B7n51sH
 tQXS5wz7KP7RFNnSnRPwlrELznbhxhWyb3y5TwmwcvUVOS/JrNYE8/jEh
 gkI/gPz1UWz+zxp9DqlBwZV+MA8z7Hlz+9nwcwbrMdKUoFuPR6dZQmfPx A==;
X-CSE-ConnectionGUID: kn7d6787TLC0B6G6CagUkw==
X-CSE-MsgGUID: yK6Es5xRRJCIl7qCaG+Tjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66753620"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="66753620"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 07:35:36 -0700
X-CSE-ConnectionGUID: xi4bmBb9Q/+5qsJ6nSB9Dw==
X-CSE-MsgGUID: Qfa4R9KrSxudinHmHAQF2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="181886868"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 07:35:36 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 07:35:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 17 Oct 2025 07:35:34 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.46) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 07:35:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6TUV1ZyY1wEs0JiDxJvdRKn8Ml3AfWI91QmRrYOV9Ho6HLB/qlwObz9XMwkbJJUKmeK6+PGokhcGIPX3yJTY2r/xuspE+fXV4JXgX6yA+OfNuJ0nvX5UAVCJjVlWKr7Og9bukiVbmJuxEmYBRMUJTdfcAsuYjMBp41CFSVSoPuPkSPitMP1VU/7PEOpvzIoZgEfLhQ09nNjHuA/ahODuw+XnXBA8qeAZW+Zt42vMYMfqreeEXVYKyxqU9Swc9FxoAzdmvri+TWi0rbZ9Q/2QUmY+d682oeeqqcyJc4R2712ut7TV/OvLj1A2wWxrVgLa3SXt1BuVkrnrz2Rv82jJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5gNFl3LhYPlqVy24OFxrI3socVU7UT1j93pagPEulM=;
 b=UgBP0Wy90n3OHho3sDPyFdnMxNGja+TYelxLXNepAqr0iIUAyRmpUy6OgGmLR+fCQqOkp7ShW4JIBfw/jycJ8WU93dVuc561K/rWClOSBWXgi3c+CI445Hj1gK9xEFhepYmge+/9SqT687MUVNFENB+6O6fIIDoAGGXic+PW7nU7Qz2OtwYViCQ+lxDrLXLoPCtXUn1cwa+Skg1QB7ihJlxVPRh5YFCtvC0LannIyzf+9+hFeclizAhMB95bl37rKAVu95VWNhxjz8h1isouTDy0AT5YAJsG5p5Ylm/Kp9LdBqGg6f2Lya9Q/q9jqKPnKVEi8hU5xDp+UrGp6TF53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by PH7PR11MB8503.namprd11.prod.outlook.com
 (2603:10b6:510:30d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 14:35:32 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::1160:23e3:5599:988c]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::1160:23e3:5599:988c%6]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 14:35:32 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>, "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "techboard@dpdk.org" <techboard@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>, 
 "Miskell, Timothy" <timothy.miskell@intel.com>
Subject: RE: [PATCH 1/2] net/iavf: support VF initiated resets
Thread-Topic: [PATCH 1/2] net/iavf: support VF initiated resets
Thread-Index: AQHcMU3AqHIGIyG6mU6GyIhfLzcII7SrcJsAgAGJkoCAA0L78IAH2KkAgAGWzBCAAEs9AIABffxQgAZB9ICAAABZMIAEy25g
Date: Fri, 17 Oct 2025 14:35:32 +0000
Message-ID: <DM3PPF7D18F34A162A17A4202EB186F4E6F8EF6A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250929143039.547207-1-ciara.loftus@intel.com>
 <2774555.irdbgypaU6@thomas>
 <IA3PR11MB8986D47057F5DE567C811B548EEFA@IA3PR11MB8986.namprd11.prod.outlook.com>
 <16117372.JCcGWNJJiE@thomas>
 <DM3PPF7D18F34A11187D26E532A3554CCE08EEBA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF7D18F34A11187D26E532A3554CCE08EEBA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|PH7PR11MB8503:EE_
x-ms-office365-filtering-correlation-id: fe5d3d6a-0ec3-4f7c-b76f-08de0d8a6d4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?YmJua05FQmw2VUxMZ1l0aU56WFgyQjlQM0MyWFhOWnJhTmFsMGZvaHpTR2V0?=
 =?utf-8?B?ZllzNHRyNi9PcE5DZDJKL1R1Y1BMWXJKU2cyRVdUanh6endWOThoNUZvMjky?=
 =?utf-8?B?RzlPWTlDZ0xWMWpGK280RTYrbHNUMDlGcGRoeGlsbkZEdXUvcUZNZ3BJZnBJ?=
 =?utf-8?B?MGplWnorU3MzRlFha3VHQThRWHNHTHBlVSsyZFpSbVQvaUpDbUpVbkI3R1p6?=
 =?utf-8?B?eHNUd1paaGM4dmxuS1BlMDl1YVV2d3BWQWd1Y3RhUmNQZ0srbExFb1VKZEZU?=
 =?utf-8?B?Uk1MbDJvdVhWc240bVg3RitxbHYvVHU1OW1Qa3BMWHZJc0I5WlR3NVpmaThZ?=
 =?utf-8?B?ZWtseE1TQnB3eVJXZWZDV0lZM0Vpa0RtaW9IZ2NmZnIrMkpvbmVqTmxmTHV6?=
 =?utf-8?B?OXh5MzlZSnF3eTB0czlsWEVxcjhWNk83NEV4SHZDZzBkV1N4U3VjK0pMalJ1?=
 =?utf-8?B?T3JvOHdyeFczaHRPdjhza2hEb3hWUW4yeVExVGtLZGE4YS8xK0hGSjVWTUcz?=
 =?utf-8?B?VjY4a1M4YlByVXdGTkFpSE9CdGVsbVZOZkl2a29aMks2TkFScFhJdlh5RkU4?=
 =?utf-8?B?WWN3Z0pFNTRQYVY1ZG1PcXhZcU9ZWTZBblhhYURUNStUVi9wcEt0MHprYi8w?=
 =?utf-8?B?WEtyTFlyc3ZnTThKa1AwaHZHbWl5R3hzbEhGKzRaRHQveDFMTkpRWEFQWDJJ?=
 =?utf-8?B?QllEcWdjZ2RxSXc5Ny9VSGtzTll5ZDJ4TTRndmN0MXVOaFAwM1RFWGVMZ1Yz?=
 =?utf-8?B?eklXMU9HRFZqcklPZk91WENiME9nMGhCeWtUQm5idkxHNDRQQzZDNTF2Wmly?=
 =?utf-8?B?VXhBRmtROTJjM01UbUdONjI5ZXc4V1pnOEhzaXhPbTBQR2RGOUtwRE1nVVpU?=
 =?utf-8?B?YVZtelRNN1ZwbTJaUUhjc244U0ovTi9ka2g0UnJBQnU3eDdlTXZIbXNwSFht?=
 =?utf-8?B?TUhjUXdsemo3YWpDeGpIVkhHRHEvTUlpL2h1WGJWazJhQ2tBUTl3djllVTN2?=
 =?utf-8?B?d0dVTXlqUWp4VFZPTW1JMi9MZ0JiSnlVVkdUeU5lWjdkVjJMT3oxN0JVdUc3?=
 =?utf-8?B?dUlrNkRoUGtxUFIzclBYUVdXenF1Zm84SiswMk82RjREL0QvVjhUcUVkbTYy?=
 =?utf-8?B?ekVrUGJpTHp0SmNLM2JpT0h3dEtONmZJcHJVZHV2MU9WUC9pRDhUQVBiKzlp?=
 =?utf-8?B?OGY0WEM4alpJQ0dodDQ4SzJ4RWEvVHhRZ0thS3lYTzdTNzhESkR3NC9UcUFq?=
 =?utf-8?B?ODlKOHd1ckUzb0NGOTZkMC9CZ0ZDaHlYNmk1OU4rSDEwcnFyYzhodng5dUpW?=
 =?utf-8?B?OHNUTmZaakhIQ1RiZjdXd3VQZ1VzMWdVRGxmVWNZNzFYb20zVWpZaFFzK1Yw?=
 =?utf-8?B?Q1c3by9LT01RN3VIVmtrT3pzbFFIYUZwaFFQRU85OUFiTTcvTGoyaFpOZU1I?=
 =?utf-8?B?U05vaTJhQ2szYmhwTXEyTDNHYU5YS2NBK1R1Z2FpVE9vNzB2d1piallzVEhS?=
 =?utf-8?B?Wnp1QU9saFRCcTBUQXJqN0dkZE10RUVtME5YUnZmbU9uVm5mWjZhSmJGRVEw?=
 =?utf-8?B?UnBnNDdpZDB4S3VOL1dIUzd5NHA4dnpHUnJBSS9vdHdTdE1aZkVKV2JuVlJN?=
 =?utf-8?B?eWthS0ZnUEt2RXZHMTdnYXFndW9tRU56S0RsZC8wZUROTXZvdGJlc2RHNXF6?=
 =?utf-8?B?eTVUN2VVVmxtbXJwM0VxQkU3TVB2bmF5NUVoOHZ3S2VYNEMxZmd5dmN3RDVa?=
 =?utf-8?B?UEdneW1JM0JjclFXMDM3THM0NlozT3Y5K3JoR1BwQUlUZElrcjhNUjRlbjlZ?=
 =?utf-8?B?UXk5SHdXb3R1M2VOcEdhZ0dyZGRJQ1IzOUJ2U3gzbGxPcFlsYzlQeFdoL0Vk?=
 =?utf-8?B?aFBYakZVTEdXYzFaZFZrVVRjK3FTM1p5VHhSRTIvNkpaY0IwK1FuVitDdXhl?=
 =?utf-8?B?Y2ZhZytjbWlEL05RVVFjSWVPQ21PQkw0WDJYd0tSNTYyM2pLSDNacHVWenVO?=
 =?utf-8?B?ak5nV0QzNlFnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHJIdmM4VlNOZUg5Y2xOTmlsdjI5K2NlN1lKU290YWhYUVFlRFZwbTEwazhU?=
 =?utf-8?B?aG94Q0JySGZ5c3VxQmxiR0RaSnY2aDIva21HOUVvb0p4dkZKUVc2QzUxbGk1?=
 =?utf-8?B?emN1eTRYVkJKZlJxdnhkK2ZySlBXT3dzNVZyNW1qUXdnajFVSDg3dUpCTFcx?=
 =?utf-8?B?QVlmSFg1NmFvQ3MwNC9BaVFxNUFvYUhJajZWU0NJQmlTOVFLY3VSQ3JSVnNq?=
 =?utf-8?B?djhrREpOdlB3ek1kd0RsRnZReWFnWUZYd3A5cjBNZXpSNjdWWHNSMm51MVRs?=
 =?utf-8?B?WWw1WldVVFJqTWVwbGVnM0p3WFNxUElPbmFGZWxhaElBWE5DNU9RZXRrcURt?=
 =?utf-8?B?V2FjNmYxRTJyQ2hPOW9EMDhQZm5PRWZkaVJKdzRuamxxd1hwTU5EemFkaXZl?=
 =?utf-8?B?amRaK1BIWHNjLzNpZHRDbFRnaEtsbXc2VDZuUkViN2pIeHU0R0ROWWloelZW?=
 =?utf-8?B?ZGNpMEJSaEd3d3FQYTF5NUw4d29JTXJwQ201dEVxVWgrNHY0MGJLTERNODls?=
 =?utf-8?B?djBCTllTa2lLeWpwZzl0QlF1bk0vQW5XVUFxdjZQUzhVRXIvVEc4dGY0eG9V?=
 =?utf-8?B?TXhpd1ZoUDNhQ0lsNHU1WWhDYVZJcXJEWW9JRURwNFV6dlJtVFowNFk5eDJu?=
 =?utf-8?B?TGdybzVIRXZiU2pENXEvamF6a2MxRkNLNlRvSWdGbzU0aVVSUlI1MkJUbmI2?=
 =?utf-8?B?VWpCSURVTExLeitTZnZxOEIwMm8veEl6TkRyNk5QL1hqRjVhQUIyNDhmbm55?=
 =?utf-8?B?YjZ0Q0g0bm93RjhsQ1VDbHEvRlFWalhRQzhCUHFDdjdCL1ZzaDdkR0NOb1ZQ?=
 =?utf-8?B?aThjNUFDNjhWTS9ZOUVGS0ZYMWZTcm1HT0ZVcUZtcFV1dGd6THE1T01RbHdw?=
 =?utf-8?B?SmljaXBraXZBRkJseFkyc1RjY3hDUmxpSTRvTVNqMzk5d0pwVkUyVEluM3p0?=
 =?utf-8?B?Q1MzL2RMYi9xOU5MWDNMdXU4Yy9QakZLeHloUFo0SDVrZTFOWmxsNTdoaHlk?=
 =?utf-8?B?Z3BvcXhJemhxQnFVWW9zVjJUVkxiU2thdlpUay9WTHZKTjhWQmw3Ui82M0sz?=
 =?utf-8?B?OFV1aWhxSWpCb2kwVVhaTG9MazZmZ0VwR29qWWhBeGtTWUNnSVBSekVrS3lN?=
 =?utf-8?B?U3B0WnFFNVZvSTMrQ0paMlV1dlkvbDZNb3RmZmo4YUpITTJFUUJ6NmtlYW5i?=
 =?utf-8?B?VmQvQndkVUxhTWNoTFJHYi9Md1cvNlZlYlZPdFZ1eUg4VWRuMk5SMWIzZUxO?=
 =?utf-8?B?R0FvVVZHRHhUUWVkdlR2YzE4emNBdlVaTVRwb0RvUGVBVitNOUw1RVE3bmla?=
 =?utf-8?B?YURRWHpCbEd3cTRMQW5hNGgvUFJ2TEd0QTczL3B1L0VMdHFQckZJVzFma2dh?=
 =?utf-8?B?YlJZdGJNcVZwYm1VcWRMdkNhR0QyMWZXclpjME0ydGJybHJ1eXlKMiszQ0wz?=
 =?utf-8?B?eHBza0tQanRTRXEyQmM2Vzc2U1BjMUhRSGQ5dGxObTd5MlVWTjd4bHhFc3ly?=
 =?utf-8?B?NkpBUm9DTllPOHBKTjc2UUwydEcxSHZ5RGkzVmo5STRadm9LOGZtclNuNkQ2?=
 =?utf-8?B?Q2IrSzB5SEp2NEVWcWdjWUROQVV0UjR3c2NzWXZHeVJXeXR1R1k3dHNDK1Z3?=
 =?utf-8?B?TGJrRE5qa0xxMXYxZ2RrY09kSXB3aSs5NDh6djVvbnNnNlljWVoyWk5jRTNp?=
 =?utf-8?B?anlhZDhVSDN6Nk5OUlNGRU1rNmVxdERkbmk1ak0vV2wwQ2k4RUVCNmh1Zjc3?=
 =?utf-8?B?YzIzM2VTUzdTQWpNakg0dDhMeVB5cHN5MmJkZ1pjcE1zeXpWNENzKzlpMXFC?=
 =?utf-8?B?SjBLcWU5SmdVdHdYTmM0MnY1R2g1eTdDa2MvYU9SMkRkRm1ISmFHWG5mWGR0?=
 =?utf-8?B?RkEva2RsMEhqdDErcnVSbDVHeEJZNVA2LzUzWmFnbHhuWHRITjBOZXp3UlZT?=
 =?utf-8?B?T21yWmtFZldwbDE0UkJ0aGhTK1hYUk9KRzRTQ2Y5cE1ZZ1ppcWQ1N2NkUVpR?=
 =?utf-8?B?K1l4N0RacDQzTWNSQmczRkdkeUZkQ0FFZXdxVThZL1R1Tm5obVpzV0ZLekJL?=
 =?utf-8?B?a3MvSEEwZmYwVnlZczRyUTJvMW9ONExTRFp5a1NGMGE3bEFndUpXVVZzK2Mx?=
 =?utf-8?B?UGxIRnJ1S25yU2xIcFNxRHUxNUU2ZmNXZHlnUFhONlIzZEpHZm9tRUh3cW1G?=
 =?utf-8?Q?jHBekNiLMCvWluKOYcRgUCylExFWyHHUyxeZgOyqSRX2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5d3d6a-0ec3-4f7c-b76f-08de0d8a6d4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 14:35:32.3430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 88yZtQGfYk+sz1VTMrI0HEBHaKy5sB66lt5u/sHmnUmXgv32HVdjvOWANQwNUJxensnKGgkT/ZPZ9HzwtBo5CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8503
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

PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IDAzLzEwLzIwMjUgMTI6MjksIExvZnR1cywgQ2lhcmE6
DQo+ID4gPiA+ID4gPiA+ID4gPiA+IEludHJvZHVjZSBhIGZ1bmN0aW9uIHRoYXQgYWxsb3dzIGEg
VkYgdG8gcmVxdWVzdCB0aGUgUEYgdG8gcmVzZXQNCj4gPiA+ID4gaXRzZWxmLg0KPiA+ID4gPiA+
ID4gPiA+ID4gPiBUaGlzIGlzIHVzZWZ1bCBmb3IgZXhhbXBsZSB3aGVuIHRoZSBhcHBsaWNhdGlv
biBkZXRlY3RzIHRoYXQgb25lDQo+ID4gb2YNCj4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiA+ID4g
PiA+IHF1ZXVlcyBoYXZlIGh1bmcgb3IgYW55IGV2ZW50IHdoZXJlIGEgcmVzZXQgaXMgcmVxdWly
ZWQgYW5kDQo+IHRoZQ0KPiA+IFBGDQo+ID4gPiA+IGlzDQo+ID4gPiA+ID4gPiA+ID4gPiA+IHVu
bGlrZWx5IHRvIHRyaWdnZXIgaXQuDQo+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBb
Li4uXQ0KPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+IEluIGdlbmVyYWwsIEkn
bSBub3QgYSBodWdlIGZhbiBvZiBhZGRpbmcgZHJpdmVyLXNwZWNpZmljIGZ1bmN0aW9ucw0KPiA+
IGFuZCBJDQo+ID4gPiA+ID4gPiA+ID4gPiBmZWVsIGxpa2UgdGhpcyBzaG91bGQgZml0IHVuZGVy
IHRoZSBleGlzdGluZyByZXNldCBBUElzIGluIHNvbWUgd2F5Lg0KPiA+IFRoYXQNCj4gPiA+ID4g
PiA+ID4gPiA+IHNob3VsZCBhdm9pZCB0aGUgbmVlZCB0byB1cGRhdGUgKG9yIHN1Y2ggYSBiaWcg
dXBkYXRlKSB0bw0KPiA+IHRlc3RwbWQsDQo+ID4gPiA+IGZvcg0KPiA+ID4gPiA+ID4gPiA+ID4g
ZXhhbXBsZS4NCj4gPiA+ID4gPiA+ID4gPiA+IFNvbWUgdGhvdWdodHMgaGVyZToNCj4gPiA+ID4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiAxLiB3ZSBjb3VsZCBhZGQgYSBkZXZhcmcgdG8g
dGhlIGRyaXZlciB0byBhZGp1c3Qgd2hldGhlciByZXNldA0KPiA+IGRvZXMgYQ0KPiA+ID4gPiA+
ID4gPiA+ID4gICAgInNvZnRlciIgcmVzZXQgb2YgdGhlIFZGIGp1c3QgcmVzZXR0aW5nIGl0c2Vs
Ziwgb3IgYSAiaGFyZCIgcmVzZXQNCj4gPiB3aGVyZQ0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiA+
ID4gPiA+ICAgIFBGIGRvZXMgYSBmdWxsZXIgcmVzZXQgb2YgdGhlIFZGLg0KPiA+ID4gPiA+ID4g
PiA+ID4gMi4gcmF0aGVyIHRoYW4gYSBkZXZhcmcsIHdvdWxkIGRvIHVzZSBhIGRyaXZlci1zcGVj
aWZpYyBmdW5jdGlvbg0KPiB0bw0KPiA+ID4gPiBhZGp1c3QNCj4gPiA+ID4gPiA+ID4gPiA+ICAg
IHRoaXMgYmVoYXZpb3VyLiBUaGUgZGlmZmVyZW5jZSBoZXJlIHdvdWxkIGJlIHRoYXQgdGhlIGRy
aXZlci0NCj4gPiBzcGVjaWZpYw0KPiA+ID4gPiA+ID4gPiA+ID4gICAgZnVuY3Rpb24gd291bGQg
YmUgYW4gaW5pdC10aW1lIG9uZSByYXRoZXIgdGhhbiBydW50aW1lLCBzbyB0aGUNCj4gPiA+ID4g
cnVudGltZQ0KPiA+ID4gPiA+ID4gb2YNCj4gPiA+ID4gPiA+ID4gPiA+ICAgIHRoZSBhcHAsIGxp
a2UgdGVzdHBtZCwgd291bGQgYmUgZ2VuZXJpYy4NCj4gPiA+ID4gPiA+ID4gPiA+IDMuIHRoZSBt
b3N0IGdlbmVyaWMgc29sdXRpb24gd291bGQgYmUgdG8gYWRkIGFuIGFkZGl0aW9uYWwNCj4gPiBw
YXJhbWV0ZXINCj4gPiA+ID4gdG8NCj4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gPiA+ID4g
ICAgcmVzZXQoKSBmdW5jdGlvbiBpdHNlbGYgdG8gc3BlY2lmeSBhIGhhcmQgb3Igc29mdCByZXNl
dC4gVGhpcyB3b3VsZA0KPiA+ID4gPiBtZWFuDQo+ID4gPiA+ID4gPiA+ID4gPiAgICB1cGRhdGlu
ZyBhbGwgZHJpdmVycyB0byBoYW5kbGUgdGhlIG5ldyBwYXJhbWV0ZXIgKHNob3VsZG4ndCBiZQ0K
PiA+IGhhcmQsDQo+ID4gPiA+ID4gPiBzaW5jZQ0KPiA+ID4gPiA+ID4gPiA+ID4gICAgaXQgd291
bGQgYmUgX19ydGVfdW51c2VkIGluIGFsbCBjYXNlcyBieSBkZWZhdWx0KS4gVGhpcyBhbHNvDQo+
IG9wZW5zDQo+ID4gdXANCj4gPiA+ID4gPiA+ID4gPiA+ICAgIHRoZSBwb3NzaWJpbGl0eSBvZiBv
dGhlciBkcml2ZXJzIC0gZXNwZWNpYWxseSBWRnMgLSB1c2luZyBpdCBpbiB0aGUNCj4gPiBzYW1l
DQo+ID4gPiA+ID4gPiA+ID4gPiAgICB3YXkuIFdlIGNvdWxkIGFjdHVhbGx5IGRvY3VtZW50IHRo
YXQgdGhlICJoYXJkIiBvcHRpb24gIm1heQ0KPiBiZQ0KPiA+ID4gPiB1c2VkDQo+ID4gPiA+ID4g
PiBieQ0KPiA+ID4gPiA+ID4gPiA+IFZGDQo+ID4gPiA+ID4gPiA+ID4gPiAgICBkcml2ZXJzIHRv
IHJlcXVlc3QgYSBmdWxsIHJlc2V0IG9mIHRoZSBWRiBieSB0aGUgUEYiLg0KPiA+ID4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiA+ID4gSGkgQnJ1Y2UsDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+ID4gPiBJIGRpZCBub3QgbWFrZSBpdCBjbGVhciBpbiBteSBjb21taXQgbWVzc2FnZXMgdGhl
IGZ1bGwgcHVycG9zZSBvZg0KPiA+IHRoaXMNCj4gPiA+ID4gbmV3DQo+ID4gPiA+ID4gPiBBUEku
DQo+ID4gPiA+ID4gPiA+ID4gQWxvbmcgd2l0aCByZXNldHRpbmcgdGhlIFZGLCB0aGUgVkYgaXMg
YWxzbyByZWNvbmZpZ3VyZWQgYW5kDQo+IHJlc3RhcnRlZA0KPiA+ID4gPiA+ID4gPiA+IHRyYW5z
cGFyZW50bHksIHVzaW5nIHRoZSBleGlzdGluZyBpYXZmX2hhbmRsZV9od19yZXNldA0KPiA+IGlt
cGxlbWVudGF0aW9uLg0KPiA+ID4gPiA+ID4gPiA+IFdoaWxlIHRoZXJlIGlzIHByb2JhYmx5IG1l
cml0IGluIGV4dGVuZGluZyB0aGUgcmVzZXQgQVBJIHRvIGluY2x1ZGUNCj4gYQ0KPiA+ID4gPiA+
ID4gc29mdC9oYXJkDQo+ID4gPiA+ID4gPiA+ID4gcmVzZXQgZmxhZywgSSB3b3VsZCBzdGlsbCBu
ZWVkIHRoaXMgbmV3IEFQSSB0byBmdWxmaWwgdGhlIHB1cnBvc2UNCj4gPiBkZXNjcmliZWQNCj4g
PiA+ID4gPiA+IGFib3ZlLg0KPiA+ID4gPiA+ID4gPiA+IElmIHdlIHdhbnRlZCB0byBtYWtlIHRo
aXMgZ2VuZXJpYyBJIHNlZSB0d28gb3B0aW9uczoNCj4gPiA+ID4gPiA+ID4gPiAxLiBleHRlbmQg
dGhlIHJlc2V0IEFQSSB0byBvcHRpb25hbGx5IHJlY29uZmlndXJlIGFuZCByZXN0YXJ0DQo+ID4g
PiA+ID4gPiA+ID4gMi4gaW50cm9kdWNlIGEgbmV3IGdlbmVyaWMgQVBJIHRoYXQgcGVyZm9ybXMg
YSByZXNldCBmb2xsb3dlZCBieSBhDQo+ID4gPiA+ID4gPiByZWNvbmZpZ3VyZQ0KPiA+ID4gPiA+
ID4gPiA+IGFuZCByZXN0YXJ0Lg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBJJ3ZlIHN1
Ym1pdHRlZCBhIHYyIGFuZCByZW5hbWVkIHRoZSBmdW5jdGlvbiB0byAicmVzdG9yZSIgaW5zdGVh
ZCBvZg0KPiA+ID4gPiAicmVzZXQiDQo+ID4gPiA+ID4gPiB0bw0KPiA+ID4gPiA+ID4gPiBiZXR0
ZXIgZGVzY3JpYmUgdGhlIGJlaGF2aW91ciBvZiB0aGUgZnVuY3Rpb24gLSBub3QganVzdCByZXNl
dHRpbmcsDQo+IGJ1dA0KPiA+IGFsc28NCj4gPiA+ID4gPiA+ID4gcmVzdG9yaW5nIGNvbmZpZ3Vy
YXRpb24gYWZ0ZXJ3YXJkcyBhbmQgcmVzdGFydGluZyB0aGUgZGV2aWNlLg0KPiA+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gPiBJIGFncmVlIHRoYXQgaXQgd291bGQgYmUgYmVzdCB0byBhdm9pZCBh
IGRyaXZlci1zcGVjaWZpYyBmdW5jdGlvbiBsaWtlDQo+ID4gdGhpcy4NCj4gPiA+ID4gQWZ0ZXIN
Cj4gPiA+ID4gPiA+IHNvbWUNCj4gPiA+ID4gPiA+ID4gdGhvdWdodCBJIGRvbid0IHRoaW5rIHdl
IGNhbiBleHRlbmQgdGhlIHJlc2V0IEFQSSB0byBpbmNsdWRlIHRoaXMNCj4gPiA+ID4gYmVoYXZp
b3VyLA0KPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiA+IHJlc2V0IEFQSSBzaG91bGQgcHJv
YmFibHkgbGVhdmUgdGhlIGRldmljZSBpbiBhIHJlc2V0IHN0YXRlLg0KPiA+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gPiBJJ20gd29uZGVyaW5nIGlmIHRoZSBjb21tdW5pdHkgd291bGQgYmUgaW4g
ZmF2b3VyIG9mIGNyZWF0aW5nIGENCj4gbmV3DQo+ID4gPiA+IGV0aGRldg0KPiA+ID4gPiA+ID4g
QVBJDQo+ID4gPiA+ID4gPiA+IGZvciByZXN0b3JpbmcvcmVpbml0aWFsaXNpbmcgYSBkZXZpY2Uu
IEl0IHdvdWxkIGVzc2VudGlhbGx5IGNvbXByaXNlIG9mDQo+ID4gcmVzZXQsDQo+ID4gPiA+ID4g
PiA+IHJlY29uZmlndXJlIGFuZCBxdWV1ZSBzZXR1cCwgYW5kIG9wdGlvbmFsbHkgZGV2aWNlIHN0
YXJ0Pw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEl0IGlzIGNvbmZ1c2luZyB0byBhZGQgYW4g
QVBJIGlmIGl0IGlzIGEgcGVyZmVjdCBvdmVybGFwDQo+ID4gPiA+ID4gPiBvZiB3aGF0IGV4aXN0
cyBhbHJlYWR5Lg0KPiA+ID4gPiA+ID4gSWYgeW91IHdhbnQgdG8gYWRkIGEgbmV3IEFQSSwgeW91
IG5lZWQgdG8gZXhwbGFpbiBob3cgaXQgaXMgZGlmZmVyZW50DQo+ID4gPiA+ID4gPiBvZiBhIGNv
bWJpbmF0aW9uIG9mIHJlc2V0L2NvbmZpZ3VyZS9zdGFydC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+
IEFwb2xvZ2llcyBmb3IgYW55IGNvbmZ1c2lvbi4NCj4gPiA+ID4gPiBUaGUgbmV3IEFQSSB3b3Vs
ZCBwZXJmb3JtIG9ubHkgdGhlIG5lY2Vzc2FyeSByZWNvbmZpZ3VyYXRpb24NCj4gPiA+ID4gPiBh
bmQgc2V0dXAgc3RlcHMgdW5kZXItdGhlLWhvb2QgYW5kIHVzZSB0aGUgZXhpc3RpbmcgZGV2aWNl
DQo+ID4gPiA+ID4gY29uZmlndXJhdGlvbi4gVGhpcyB3b3VsZCBkaWZmZXIgZnJvbSBhIGNvbWJp
bmF0aW9uIG9mDQo+ID4gPiA+ID4gcmVzZXQvcmVjb25maWd1cmUvc3RhcnQgaW4gdHdvIHdheXM6
DQo+ID4gPiA+ID4gMS4gSW4gc29tZSBjYXNlcyAoYXQgbGVhc3QgaW4gdGhlIGNhc2Ugb2YgdGhl
IGlhdmYgZHJpdmVyKSwgYQ0KPiA+ID4gPiA+IGZ1bGwgcnRlX2V0aF9kZXZfY29uZmlndXJlIGlz
IG5vdCByZXF1aXJlZCBhZnRlciBhbiBydGVfZXRoX2Rldl9yZXNldC4NCj4gPiA+ID4gPiBTbyB0
aGUgbmV3IEFQSSBjb3VsZCBqdXN0IGNhbGwgdGhlIGRldmljZSBjYWxsYmFja3MgZm9yIHRob3Nl
IGZ1bmN0aW9ucywNCj4gPiA+ID4gPiByYXRoZXIgdGhhbiBmb3JjaW5nIHRoZSB1c2VyIHRvIGNh
bGwgdGhlIGV0aGRldiBmdW5jdGlvbnMgYW5kIHBlcmZvcm0NCj4gPiA+ID4gPiBzb21lIHVubmVj
ZXNzYXJ5IHJlY29uZmlndXJhdGlvbiBzdGVwcy4NCj4gPiA+ID4gPiAyLiBJdCB0YWtlcyB0aGUg
YnVyZGVuIG9mZiB0aGUgdXNlciB0byBidWlsZCB1cCB0aGUgZGV2aWNlIGNvbmZpZ3VyYXRpb24N
Cj4gPiA+ID4gPiBhZ2FpbiBhZnRlciB0aGUgcmVzZXQuIEFueSBwZXJ0aW5lbnQgY29uZmlndXJh
dGlvbiBjYW4gYmUgc3RvcmVkIGJlZm9yZQ0KPiA+ID4gPiA+IHRoZSByZXNldCBhbmQgdXNlZCB0
byByZWNvbmZpZ3VyZSB0aGUgZGV2aWNlIHRyYW5zcGFyZW50bHkuIEFsbCB0aGUgdXNlcg0KPiA+
ID4gPiA+IG5lZWRzIHRvIHN1cHBseSBpcyB0aGUgcG9ydCBpZC4NCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IEFueXdheSwgSSd2ZSBzdWJtaXR0ZWQgYSB2MyBvZiB0aGUgbm9uLWdlbmVyaWMgdmVyc2lv
biBvZiB0aGlzIGZvciB0aGUNCj4gPiA+ID4gPiBpYXZmIGRyaXZlciwgc28gaWYgdGhlcmUgaXMg
bm8gYXBwZXRpdGUgZm9yIHRoZSBnZW5lcmljIGFwcHJvYWNoIEknbGwNCj4gPiA+ID4gPiBjb250
aW51ZSB0byBwdXJzdWUgdGhlIGRyaXZlci1zcGVjaWZpYyBvbmUuDQo+ID4gPiA+DQo+ID4gPiA+
IEEgZ2VuZXJpYyBBUEkgaXMgd2F5IGJldHRlci4NCj4gPiA+ID4NCj4gPiA+ID4gSSdtIHRyeWlu
ZyB0byB1bmRlcnN0YW5kIHdoYXQgaXMgbWlzc2luZyBpbiB0aGUgY3VycmVudCBBUEkuDQo+ID4g
PiA+DQo+ID4gPiA+IEkgdGhpbmsgd2hhdCB5b3Ugd2FudCB0byBhY2hpZXZlIGlzDQo+ID4gPiA+
IFJURV9FVEhfRVJST1JfSEFORExFX01PREVfUFJPQUNUSVZFLg0KPiA+ID4gPiBXaGF0IGlzIG1p
c3NpbmcgZXhhY3RseSB0byBpbXBsZW1lbnQgaXQgd2l0aCB0aGUgZ2VuZXJpYyBBUEk/DQo+ID4g
PiA+DQo+ID4gPg0KPiA+ID4gVGhhbmtzIGZvciB0aGUgcmVjb21tZW5kYXRpb24sIEkgdGhpbmsg
dGhlcmUgaXMgcHJvYmFibHkgYSBwbGFjZSBpbiB0aGUNCj4gPiA+IGlhdmYgZHJpdmVyIGZvciBS
VEVfRVRIX0VSUk9SX0hBTkRMRV9NT0RFX1BST0FDVElWRSB3aGVuIHdlDQo+ID4gPiBkZXRlY3Qg
YSBQRi10by1WRiByZXNldC4gSG93ZXZlciBJIGRvbid0IHRoaW5rIGl0IGxlbmRzIGl0c2VsZiB0
byB0aGlzDQo+ID4gPiBwcm9ibGVtLg0KPiA+ID4NCj4gPiA+IFdoYXQgaXMgbWlzc2luZyBpcyB0
aGUgdHJpZ2dlciBmb3IgdGhlIHNlcXVlbmNlIHRvIHN0YXJ0Lg0KPiA+ID4gUlRFX0VUSF9FUlJP
Ul9IQU5ETEVfTU9ERV9QUk9BQ1RJVkUgc2VlbXMgdG8gYmUgY29uY2VybmVkDQo+ID4gPiB3aXRo
IHJlY292ZXJpbmcgZnJvbSBoYXJkd2FyZSBlcnJvcnMgZGV0ZWN0ZWQgYnkgdGhlIFBNRC4gVGhl
cmUNCj4gPiA+IGRvZXNuJ3Qgc2VlbSB0byBiZSBhIHdheSB0byBhc2sgdGhlIFBNRCB0byBlbnRl
ciB0aGUgcmVjb3ZlcnkgbW9kZSwNCj4gPiA+IHlvdSBtdXN0IHdhaXQgZm9yIGEgZGV0ZWN0ZWQg
ZXJyb3IgLSBwbGVhc2UgY29ycmVjdCBtZSBpZiBJIGFtIHdyb25nLg0KPiA+ID4NCj4gPiA+IFdo
YXQgSSBhbSBsb29raW5nIHRvIGltcGxlbWVudCBpcyBhbiBBUEkgdGhhdCB3aWxsIGFsbG93IHRo
ZSB1c2VyIHRvDQo+ID4gPiB0cmlnZ2VyIHRoZSBQTUQgdG8gcGVyZm9ybSBhIHJlc2V0IGZvbGxv
d2VkIGJ5IHJlY292ZXJ5IChjb25maWd1cmUsDQo+ID4gPiBzZXR1cCBhbmQgZGV2aWNlIHN0YXJ0
KS4gWWVzIHRoaXMgY2FuIGJlIGRvbmUgdXNpbmcgZXhpc3RpbmcgQVBJczoNCj4gPiA+IHJ0ZV9l
dGhfZGV2X3Jlc2V0DQo+ID4gPiBydGVfZXRoX2Rldl9jb25maWd1cmUNCj4gPiA+IHJ0ZV9ldGhf
cnhfcXVldWVfc2V0dXANCj4gPiA+IHJ0ZV9ldGhfdHhfcXVldWVfc2V0dXANCj4gPiA+IHJ0ZV9l
dGhfZGV2X3N0YXJ0DQo+ID4gPg0KPiA+ID4gQnV0IHRoYXQgaW52b2x2ZXMgcG90ZW50aWFsbHkg
dW5uZWNlc3NhcnkgcmVjb25maWd1cmF0aW9uIGFuZCBtb3JlDQo+ID4gPiBidXJkZW4gb24gdGhl
IHVzZXIgaW4gYnVpbGRpbmcgdXAgdGhlIGRldmljZSBjb25mLCB2ZXJzdXMgYW4gQVBJIHRoYXQN
Cj4gPiA+IGp1c3QgYWNjZXB0cyB0aGUgcG9ydF9pZC4NCj4gPiA+DQo+ID4gPiBUaGUgdXNlciBt
YXkgd2FudCB0byB0ZWFyIGRvd24gdGhlIGRldmljZSBhbmQgYnJpbmcgaXQgc3RyYWlnaHQgYmFj
aw0KPiA+ID4gdXAgYWdhaW4gaW4gY2FzZXMgd2hlcmUgc29tZXRoaW5nIGhhcyBnb25lIHdyb25n
IGVnLiBhIHF1ZXVlDQo+ID4gPiBhcHBlYXJzIHRvIGJlIGh1bmcsIGFuZCByZXNldHRpbmcgaXQg
bWF5IGhlbHAgcmVzb2x2ZSB0aGUgaXNzdWUuDQo+ID4NCj4gPiBPSyB5b3VyIGRlc2NyaXB0aW9u
IG1ha2VzIHNlbnNlLg0KPiA+DQo+ID4gUGxlYXNlIGRyYWZ0IGEgUkZDIG9mIHRoZSBBUEkgd2l0
aCBhbGwgdGhlIG5lZWRlZCBleHBsYW5hdGlvbnMsDQo+ID4gc28gd2UgY2FuIGRpc2N1c3MgaXQg
aW4gbW9yZSBkZXRhaWxzLg0KPiA+IE9yIGFyZSB5b3UgYXNraW5nIHRoZSB0ZWNoYm9hcmQgdG8g
ZGlzY3VzcyBpdCBiZWZvcmUgdGhlIGRyYWZ0Pw0KPiANCj4gSSdsbCBzdWJtaXQgYSBkcmFmdCwg
SSB0aGluayBpdCdzIHRoZSBiZXN0IHdheSB0byBwcm9jZWVkLiBUaGFua3MNCj4gZm9yIHlvdXIg
aW5wdXQuDQoNCkkgc3VibWl0dGVkIGFuIFJGQyBoZXJlOg0KaHR0cHM6Ly9wYXRjaGVzLmRwZGsu
b3JnL3Byb2plY3QvZHBkay9saXN0Lz9zZXJpZXM9MzYzOTENCg0KQ2lhcmENCg==
