Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF3AC0219B
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 01:19:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 518B2402D1;
	Mon, 10 Feb 2025 02:19:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id DECD84021F
 for <dev@dpdk.org>; Mon, 10 Feb 2025 02:19:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739150358; x=1770686358;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=orkBywV69QvtRuSDXGPYGBfxQR0+83RXIrJCSw79eP0=;
 b=BgGewPjHEYwBP8IZ9kRnYyO6D7fnH3jb7sKhydfgyWSnsha7HUv0QepA
 nJnc2JqKukruc3BYLzM6NfU2KPx2wnhP0m5QLe2ooCl1tUudc3kEvjN80
 PpJ+0sN2CoEbc/TnVBM4PfgsktOdo8qN6CUzIxjk5m70jj8gOnD+aJ4II
 N02+UwHLJxCZpolTIawSxHqHfTOw41ST29s08PfChSwlhzo0XNAB8Ua3S
 aNLR903DHeosRiKSaRuXoNe9CYqJuJ41d/Flsfb3R30wUtKim8z+5HUPo
 ys1N0KTZNXuR9NidKUaWudL82DmXYVHih+Bp20Tmt1lO+YzIGYFcN23Vc A==;
X-CSE-ConnectionGUID: MSlKXI1fTGKUdJha4PXxJg==
X-CSE-MsgGUID: N11JMmLFRq+Tt/Gs3BNj8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="42562113"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; d="scan'208";a="42562113"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2025 17:19:16 -0800
X-CSE-ConnectionGUID: asZk2timS/yxvA7V2TBMnA==
X-CSE-MsgGUID: 0HHD39jCRJyxBME8JqDm+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; d="scan'208";a="117105195"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Feb 2025 17:19:16 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 9 Feb 2025 17:19:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 9 Feb 2025 17:19:15 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 9 Feb 2025 17:19:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0fSWGqrnpi7zxTVC/r0X3jALnsKqbte/iq6YNTls1cVDl9bjl0p25rKimA3/iefUwnpO++M5T67V/6PwDEoNfVnuKqNVrvKMwVqmxSWHg0vXluyNbYalyLuUn4HO6LZv+Og9DJXjQvNdjh01qU3GJMOPvOvagDEL6DGGiMn1oBuQyiaf9Ob5tmxC5hdUrMSMQRHyukVWAuGjjjOcv+cmXJ4v8kEU4xNknMI3+ZVUvIysVbvbEQ4HXNjf+U1hgtrR3oRxYyR8NR6NEMoYAlK2Gwh9Zc5cNAtm/0AZOR4o52jaycTHaz6YTqrpYRMVo5YBBkxgvJzJ8ODD7IyvZXy6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orkBywV69QvtRuSDXGPYGBfxQR0+83RXIrJCSw79eP0=;
 b=ToCmryxNdob1SfNXl+gagifnX74oOT1I4Iliatg6OXmabYNq6LOCCk8akHspvyipYOFTMB9MKNilSHSSR+VOxHr0d/qdt9CMEeXoPzTmCURNlhtvs6BD+28kFYeoDH3MMsrVrlqrVWlq7/aggFLdNEH3/+Zgg8R/aU/YKrgsx93+GnIG4Ad3LW3ORiDEuVGpt8cu7JjQFZyL/D6q98qo3bn1nSEH8d3zuF+xB2CFwI6HLcOti3ZEdDzGTQTv0nmA0+s00QG0/7IxbOrtg/4MFsDve/pRFIU3P97zRuCUpA4L/Vx/d0y7cho/pBjwpqAyqn7yPLNYSxlyyKRjCAuINA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB7757.namprd11.prod.outlook.com (2603:10b6:8:103::22)
 by DM6PR11MB4564.namprd11.prod.outlook.com (2603:10b6:5:2a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 01:18:30 +0000
Received: from DM4PR11MB7757.namprd11.prod.outlook.com
 ([fe80::60c9:10e5:60f0:13a1]) by DM4PR11MB7757.namprd11.prod.outlook.com
 ([fe80::60c9:10e5:60f0:13a1%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 01:18:30 +0000
From: "Xu, Rosen" <rosen.xu@intel.com>
To: Shani Peretz <shperetz@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stephen@networkplumber.org" <stephen@networkplumber.org>, Parav Pandit
 <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, "Hemant
 Agrawal" <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>, "Wei
 Hu" <weh@microsoft.com>, "Richardson, Bruce" <bruce.richardson@intel.com>,
 "Laatz, Kevin" <kevin.laatz@intel.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, Jan Blunck <jblunck@infradead.org>
Subject: RE: [PATCH v5 2/4] lib: fix comparison between devices
Thread-Topic: [PATCH v5 2/4] lib: fix comparison between devices
Thread-Index: AQHbeCtpgr4VIyuYK0OclP+9vjbejrM/wvXQ
Date: Mon, 10 Feb 2025 01:18:29 +0000
Message-ID: <DM4PR11MB77572A191EEA0D1D9DC167BA89F22@DM4PR11MB7757.namprd11.prod.outlook.com>
References: <20250129085416.226718-1-shperetz@nvidia.com>
 <20250206000838.23428-1-shperetz@nvidia.com>
 <20250206000838.23428-3-shperetz@nvidia.com>
In-Reply-To: <20250206000838.23428-3-shperetz@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB7757:EE_|DM6PR11MB4564:EE_
x-ms-office365-filtering-correlation-id: 78e00cea-3529-4295-fd73-08dd4970d41e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?FfjsX6mKro/5k6tN1YWY2vtMJkujwWGw5LCj1FCu+coWGbV3qU8jpyOTJXU8?=
 =?us-ascii?Q?fJA3iTv/B9Y/84voUe7ng75Ps4JuXGPGBvMexSMODLnsJb8k/2Z9tc+rm3kd?=
 =?us-ascii?Q?RzZLFg7hzfUQFDh13iGzAqBWVMBpVbD8+ebqt+zTjQJxxtmjvJr1OJm2rAub?=
 =?us-ascii?Q?rRC1vzfb4Bav8JDsoEp+29FZHLSFOvbNHw5yNuuC0kq4AlQp3gE+/nqsGY84?=
 =?us-ascii?Q?hN2Lo2oVWD8aW5C2SMPqvWgTc3hl953AVQSIj/HfGdYSRH6RKmg8OtBe+ilY?=
 =?us-ascii?Q?efNrFVX6PIVQnIGXxFlwaltNNGexpwD6uh6lkxup5ZfOKFHwaOezdSa2d2RI?=
 =?us-ascii?Q?QT8vmQYGIUmQ4uH7cvhc1P5mLbItBwRMnWQLhQITUIWINDgH0UNR+GbnvQRA?=
 =?us-ascii?Q?kPfFQU1KziJHBjPK6F+HBX26IdiCgvQQdLr4xJoO1TWq5O6HREZl6mMz8XtQ?=
 =?us-ascii?Q?akwvK9DEWPZ+ljfzn83JfEY7uqPAHcSb5fqRIfsXJ6Gk0bx0XQm0QYZIYkOI?=
 =?us-ascii?Q?r3yialDAj2t4LrTj8m897dYZD5u0jiZFox/7ZZ08Y41IkDskZ4814xM+cgn4?=
 =?us-ascii?Q?mum5tv6hpR0kz2rad7jqVwEXkFTDLQX4uCd7K6kXUCdwOOTxSavpKjZq4bQF?=
 =?us-ascii?Q?8EmaOis8QNp8uQspyr30Q4EiUv1nAXJhay9+TOuYOfEdgAw1N/QdlW5+OvZi?=
 =?us-ascii?Q?BWU8MOVrn8cZ4mE6lNHYe2MD3G9dmG+qdDBlvKWV5WdsFwyrZfZnHwScj9Gd?=
 =?us-ascii?Q?SD3xK1tJR2IDPco1ZQfCfHF3V2CXxGnX1fyV+Xi3MHtFW6azaoezyIPIZGOc?=
 =?us-ascii?Q?NR1ycVUGg0Hpxkdkd0hW2/hVyxLIdkx4aixGRevpFeNfw3VusNfSXDdtELQ8?=
 =?us-ascii?Q?IoFcEjNEXCeL/DyjuLsbUsVt/flGV2l9uCUTRIn4yzPe3XT4F4BysoSkuahO?=
 =?us-ascii?Q?jwA62I6bEmAjp7Fyp6ukczMI1OUdEps6p5afE5N7TlS/gO0ZHEpmc5/+ioPO?=
 =?us-ascii?Q?s49MZpOulr+IwhVA+N7oRJyK6VQYpF7MvGkKsHtBylAly6/g5kSwDuD+IFr/?=
 =?us-ascii?Q?VGlTZKC04RIkKLSrs77HdJeH6BBrAR7M7ARZK9zSCpWF90mk5MghdnumX9wV?=
 =?us-ascii?Q?KtKPtb0tKegBlyrybq214IBQtv0DQBWo0nulWE7jjLkky5ump+Hw8xD0umEp?=
 =?us-ascii?Q?pLKTwGcMpcao/h/aATleoVromAD6uwgYKat0oi5jsjy2HbQJXkC+lakCVYUk?=
 =?us-ascii?Q?MjDHE12kIeYDlph8rZ80C6f0QJTeJe9AcCQtPT35yBHRlspRA2cGTv3sN5cW?=
 =?us-ascii?Q?Q8FbC4q5mB1d9jDpiYzquQXkc83oDNiKk5HYkPlrTj4dqwmzN+Jea0KeS2jr?=
 =?us-ascii?Q?0pyqFkAGI3h3xyhpKDXElPWcSCrwsUveRhLaDX6NX/Cy57qGBj8EuSdaAEzu?=
 =?us-ascii?Q?sa2IDsthmD2MxG2UpDGoUDFvO+oO2RqB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB7757.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dmVhYWf7lgVxFx/iAmApuJsE0drXMbIcLRNPyhAwL8rYiesRCXSFl3yxfzby?=
 =?us-ascii?Q?+efE8pJUJHAwxAuAcaX+MSkVEnI5ILQYPDeEFLfs6q2/HfGk4iMLNDJyTGrd?=
 =?us-ascii?Q?uXLleRs9y5Z4m5z4flR3s2pVDnf5CioahNNf7qkHM72B1o6bc8KoZnhcpbxg?=
 =?us-ascii?Q?lTLl4zTMvR+tzwPaH7uJZTY2Z9IR/URErJR9IKZe5YEke0kFFzYob8500LuJ?=
 =?us-ascii?Q?LRJhbsg+h1mPIw7cI/RYNtM0DXyffF5dxL0Icf6sC4nCzilUHcWjGTJ//r53?=
 =?us-ascii?Q?6qOI0llUut7rosoEZCQ7np0LeBFqYAXoUbAfdNOSSCUHlZJS0/EdBqgPhCuC?=
 =?us-ascii?Q?uoy1S6wDyB4BQXpRnZDLi1GFCxCQoZAw7QsiLZJKIhkEDaFrqsE4qd7cFwxE?=
 =?us-ascii?Q?msrv8sRqif5RHpDzD5qT+ZcjsZ0nzs6SC/2MqexFmA3rp8nKTgogplLNFvq3?=
 =?us-ascii?Q?abBRF7fAn/Jjk+HnsEcPQFJSEUP3fPWxX+0qJlPMuPqqWLEZZgr1BlFU/ODm?=
 =?us-ascii?Q?YqEBdGIwC+IQ7+cnyoR8Prr+wubdpU5IOOd42KhZfsWbp43PEYnYFQsa/9Bp?=
 =?us-ascii?Q?MNCGU0k2KAFSojYDnH6OHl6VsUiPsGbZoywEQNIpWx/qBwy24tGFaRYT/AnN?=
 =?us-ascii?Q?XeBLMlwJuS94tT/hprNoA67xQYTSjHvDPkPkiubROlbI0bQ6N+zf1/eV5JJB?=
 =?us-ascii?Q?m3BgT0leMOIQ6OE8DoraSwpK0ygQ8O0v+pW5Qs8YVaqXuAOwiEiCbmWPGNvN?=
 =?us-ascii?Q?vBexs6xrwcvkPOkJJ+GU7R2+Z2c8/c/XqjdYmalPFzk0ffsC8hxyukdnr8bR?=
 =?us-ascii?Q?Qgi0zMLJzsipRNrwg10Vh80+1XVQvHPCZ61wrml6599EedBi4WmPbEwD5S+A?=
 =?us-ascii?Q?mOXnFUoQei2rPsd9URpqT+jXceFAOvDXSwLPTQfDYJdX/7anivQ9E/P4/3tw?=
 =?us-ascii?Q?Zsz/YO8uPNtnB1FjbFlak+X1Qb9fUmzBsdMMxbQ75a3vVC4zCrxCvPzZRfhP?=
 =?us-ascii?Q?SkSRqGY4EwDNllP+pzhphMo5de15KOvZ2B+VzLxdx9sbpxYBklhAIp9D/JBo?=
 =?us-ascii?Q?t1TaRLFpesOyA3IdAw9Xh1ltIovcs+1qKB2yBu4ymLXS3ljk/jeo7jnnwdjH?=
 =?us-ascii?Q?+/V1eteuRJ7+vY0sFRMQQ3ad/5Rh7YjwVtmcIzArDoILcRly0O+z41jmIRjk?=
 =?us-ascii?Q?/LnP4dY8m4M/89xDJhkp+PKxzd0ZsoXRy/e6wx54Tacm3diNXjNsmANqvcA8?=
 =?us-ascii?Q?go9dbCOKTIkWLj44rxDnVtdRs+0Ge5Akazq+/oLYhKs6gNw2D1uHLlHGNmm6?=
 =?us-ascii?Q?MjWBlaASEW+vYg3XXzykht0Fjnqur3ItRFKjHZ+/fIGj/bSUEHZkj4hPqttB?=
 =?us-ascii?Q?a2yq1/E92LQSSC5u1Hur7kvw0KyjiQC/P8BVJ+3URH00ScnIQ6wLPHWxhwe2?=
 =?us-ascii?Q?Vhi1qpG6ocgKQzpZvDA8nopcXHWVRxwmKrP5vzHrUFgSeCzBP2EQ4LQNI2gU?=
 =?us-ascii?Q?KJK1XtHjJT59+Ve4UbOxtXKLqbS9dEAZGBqDOxxwldM8mclwNbQjAVuJX5nE?=
 =?us-ascii?Q?9iRN8QesiNJC8naxp9YPsEXPp1wW4wc6DYDe8+J1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB7757.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e00cea-3529-4295-fd73-08dd4970d41e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 01:18:30.0148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e0p09mPdOEx+xwyiADB2rcQlMHd7g5NKDwtqK5d2cmKN9CwsZ2DeX01gV5u3XFjgSJGOFb1dwVT7SsksuV9GKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4564
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

Hi,

> -----Original Message-----
> From: Shani Peretz <shperetz@nvidia.com>
> Sent: Thursday, February 6, 2025 8:09 AM
> To: dev@dpdk.org
> Cc: stephen@networkplumber.org; Shani Peretz <shperetz@nvidia.com>;
> Parav Pandit <parav@nvidia.com>; Xueming Li <xuemingl@nvidia.com>;
> Nipun Gupta <nipun.gupta@amd.com>; Nikhil Agarwal
> <nikhil.agarwal@amd.com>; Hemant Agrawal <hemant.agrawal@nxp.com>;
> Sachin Saxena <sachin.saxena@nxp.com>; Xu, Rosen <rosen.xu@intel.com>;
> Chenbo Xia <chenbox@nvidia.com>; Tomasz Duszynski
> <tduszynski@marvell.com>; Chengwen Feng
> <fengchengwen@huawei.com>; Long Li <longli@microsoft.com>; Wei Hu
> <weh@microsoft.com>; Richardson, Bruce <bruce.richardson@intel.com>;
> Laatz, Kevin <kevin.laatz@intel.com>; Tyler Retzlaff
> <roretzla@linux.microsoft.com>; Jan Blunck <jblunck@infradead.org>
> Subject: [PATCH v5 2/4] lib: fix comparison between devices
>=20
> DPDK supports multiple formats for specifying buses, (such as "0000:08:00=
.0"
> and "08:00.0" for PCI).
> This flexibility can lead to inconsistencies when using one format while
> running testpmd, then attempts to use the other format in a later command=
,
> resulting in a failure.
>=20
> The issue arises from the find_device function, which compares the user-
> provided string directly with the device->name in the rte_device structur=
e.
> If we want to accurately compare these names, we'll need to bring both
> sides to the same representation by invoking the parse function on the us=
er
> input.
>=20
> The proposed solution is to utilize the parse function implemented by eac=
h
> bus. When comparing names, we will call parse on the supplied string as w=
ell
> as on the device name itself and compare the results.
> As part of the change the parse function will now return the size of the
> parsed address.
>=20
> This will allow consistent comparisons between different representations =
of
> same devices.
>=20
> In addition, fixed vdev test to use the rte_cmp_dev_name function instead
> of the custom one.
>=20
> Fixes: a3ee360f4440 ("eal: add hotplug add/remove device")
>=20
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>


Reviewed-by: Rosen Xu <rosen.xu@intel.com>
