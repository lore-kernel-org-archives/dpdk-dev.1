Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E992DC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 May 2025 10:46:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A58BA402AC;
	Mon, 19 May 2025 12:46:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id D394840276
 for <dev@dpdk.org>; Mon, 19 May 2025 12:46:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747651609; x=1779187609;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=9FZsJxw7qXYTJbsW6pFoFSBlVSx9ZehOISEDGbIKBaE=;
 b=B7QC2+Oo4a20VKWx/NOdBknWBhX66wR8nC84qQRWQTbao/mi4ipA9DRh
 I0/qxFEvejofre/VZsSp6oNTnwhcp0xkkkPNRDwff4rb7UbHo4H7fJpcJ
 QLH37QRDXglGum5v8JdhhD2rYjpHdqIftTt99NTFlVmc02uDB7CDVzUTe
 15nLnHw5J6rzWjA+3FuxDiLlTOh0KdMKUCPPk6vkfLXSUya0tIh1eF6/Y
 SIcFp4sxK3pblFUp8BRRTbGpTvT33E8HCZsyvMtuOA0gXMEB7MIEOfZVK
 FiVucJ15zsXzswqa2KmwTlevoKE3M1X7/pv4vHRr8ClPH9+8gz7WGRQMa w==;
X-CSE-ConnectionGUID: xn15iK5yR1KHyr9ZLotybQ==
X-CSE-MsgGUID: qualK12DRAOGlJMo+00Aww==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="49527819"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; d="scan'208,217";a="49527819"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2025 03:46:47 -0700
X-CSE-ConnectionGUID: zkoxNCa4SMO8LOpP3/GmQQ==
X-CSE-MsgGUID: sfhyDj/2Thmmfq3XOC+R1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
 d="scan'208,217";a="143335164"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2025 03:46:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 May 2025 03:46:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 19 May 2025 03:46:45 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 19 May 2025 03:46:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wc1K2ETV5WTcA7JWlZx5QzmtSLyge2RVWM11HYhXI3xUIlXSie/poJxYKAfEjV6yhpCv8oSkzPfG1deAjF3xa+8EX/c7M69RlZMwqpGI71TB5Vv/lri0VkZsWfbcAygnRkzVEYvTQvQE/0KwUdDSRGexEJWHErAKrqLlmnBz5w8rMRKsrtnGXvbMx7SqXdDCVyPm+2ITiD+y9gOM9XpheLZ18nu7sCfz6RxLHWBIVMCVjk9wBGitVvuFTq7RQvEnyqcOoDU4bSpYSdlf7mN23sCggaBppWB7JkE0R7yVaNY4r5iq8gkpDXpIlCORKzCjQUbP5FSlrdw/7a40OlfdYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JRf4JQ4VGlp1WyKxVHCMu/dN1z1sAfRx93R6NvvJBs=;
 b=V0lJe1SAXxNmdnkqEhQVqPOjuUeGol9a/a++FAW4S9kLp5U1cqQlpWM49z6NkxpYp/ykBVn40DNlDh/1MV0axQP5T8KRDiRtAg70lTjBVBupzYg0rxpb3BGVm3jkhco5OYBe/jFyopVqtk4cF6wg04QAxHfsTvIlYDtQ8kF1FWO53UWzZG2S9IT+Gv1oac7PHupAtQ2UbVK6IsLSNQC5xQorg2bWJC58UtbrVe6To+ijbkFs1pT/bAN3zFATkWmuLhmYsodDvPbh/TSFbcpYGR04gyEvfzjTkD+tmFw65PMd2aUo7U/yD6hc0khpnvh++Yx7BcJIbprnA4l+Igf5HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 19 May
 2025 10:46:40 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79%3]) with mapi id 15.20.8722.027; Mon, 19 May 2025
 10:46:40 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: Moses Young <mosesyyoung@gmail.com>, Yang Ming
 <ming.1.yang@nokia-sbell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v2 2/2] crypto/ipsec_mb: fix QP release in secondary
Thread-Topic: [PATCH v2 2/2] crypto/ipsec_mb: fix QP release in secondary
Thread-Index: AQHbp32qmg0KacNIKUSAnuBr0goc/LOy+rqAgBR653mAB4eRAIAK/LQd
Date: Mon, 19 May 2025 10:46:40 +0000
Message-ID: <DS0PR11MB74589B3EB4B98A5DE37AF748819CA@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20250314103638.2198-1-ming.1.yang@nokia-sbell.com>
 <20250407052532.1913-1-ming.1.yang@nokia-sbell.com>
 <20250407052532.1913-2-ming.1.yang@nokia-sbell.com>
 <6d31ea07-8bbb-4e9c-ab88-be50e0132e31@nokia-sbell.com>
 <DS0PR11MB74583A392F4BEEB1E2AC9F2E8188A@DS0PR11MB7458.namprd11.prod.outlook.com>
 <7cf98921-1ca2-4707-a0fd-609c1d2cce65@gmail.com>
In-Reply-To: <7cf98921-1ca2-4707-a0fd-609c1d2cce65@gmail.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|IA1PR11MB6395:EE_
x-ms-office365-filtering-correlation-id: 2e4b3642-bebb-46e0-74ce-08dd96c27005
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007|8096899003|13003099007;
x-microsoft-antispam-message-info: =?Windows-1252?Q?D2SLi1snGoflID62aU3aFKxgAXSeXwSycUo5Hu41Fz3fQzsZuSB/zgCO?=
 =?Windows-1252?Q?yrG+lkTe1sllQHr1cyl1ejvB9ceOyJ8clLsrE3ku/u+UhHZvK/mtxG4o?=
 =?Windows-1252?Q?EUHzT4RcR/iAWv7HTGc9ye98opoWHKVsyzwb/g0aUbcrUBk1A05v/0Sz?=
 =?Windows-1252?Q?LdRqeYCSQP190+NWcZHb7NJckuzttSAC/Xp9xmVB9yYfAd4jZLB44BAK?=
 =?Windows-1252?Q?p6ujERqYy8cvmljTtT8MMIx9UdTynl1x3AyslKTMbsXjH+vvbcItuujn?=
 =?Windows-1252?Q?JAtplBr9645Y4aT/rVPzFpCQ3gA56jWP3W5KINg+SJW7TC3wN2LcQJV0?=
 =?Windows-1252?Q?XlT5OwYSA+adKNK/ygeUWpVEUqinCEud47XM9yFdT7mhS3cynvOxnRxY?=
 =?Windows-1252?Q?+/DjbIiSNm9HEtyH2X5UVuwFJFOffrY04NI32YuE5TDILCNKMbzIYiQx?=
 =?Windows-1252?Q?71kCpX4f6DJD+gT1c9ntlcl6rna5JpVrbUe8NjZyn49y8KYcB2uxQgQc?=
 =?Windows-1252?Q?2M4ZJMeO7lZ0lt63D0z2tP1tG5c5z8mUiXCg4j/wu5OGuYhLDmBA9/TA?=
 =?Windows-1252?Q?BcfGutgwamKct0bkv6g5INM2rqnQegUrWtTTfkuKG2+ag3Vcj+u8Z7Ch?=
 =?Windows-1252?Q?nT0DUziP0RadGVv+EZHHDvjQz7omG02mbjhCqBCCKdRb9bK/dMEKX8Nm?=
 =?Windows-1252?Q?Z7a6l8D5WZOfuzl7VKwq4ZaonkriiZZ9lVLI87F+0I3H4A5ownrAepAQ?=
 =?Windows-1252?Q?zLybTlb67tFq26niyxQ3Rg/HUDyoMNz5TbToJh1br1IZZYK1BmtpCPEi?=
 =?Windows-1252?Q?qITYYSP8ENQHwT5LKBF922vprXFWc44NUA0J9FpQmhJc8A8PBnX6gkgP?=
 =?Windows-1252?Q?4FgqawP8K6cQn3UFai6BlygX6m6jI2eqgXDHymyz/Yh1adcayoY+1I5a?=
 =?Windows-1252?Q?UHcRRgSS+h112pZsfRtWaTHT/suJljH6B08PSwc/od5ZrMdxBC8DL+oL?=
 =?Windows-1252?Q?doYGAGxmrcEOxvzAvCB5cIGYfFFbc2VlT/Jf8Ihw0ln00n3Ml343DoUa?=
 =?Windows-1252?Q?mROVp1002ulG+EaicUVMYcU6FqZGD5rEjPNviZP0tp1nKcAURdUPY0Bp?=
 =?Windows-1252?Q?bWMhQISeKCqm3E7uGlo+NGYn/vTdy3B5El9ON+GUl2tzv1tz6LA16pLS?=
 =?Windows-1252?Q?tRg5becbY4OD+NvE/xlnrTBYiFXXE+f/z0vS3130+fcUIqznaIBaCaAC?=
 =?Windows-1252?Q?6fKQHsEKTFm6qqhwa26iJe5SZRK3RUr+9taaMjgilHWWEVtKa0KBO9g3?=
 =?Windows-1252?Q?CBbGd4XJ3Ww4etLGqTJR+LpTLRagjtJbvaJDn+edSVqjsdNOYwJIYWiT?=
 =?Windows-1252?Q?bfz0/gGXky63xAqKsdp7LiYmNg3tT/E64So1QPseBARvQdGC3OYfVjvJ?=
 =?Windows-1252?Q?92j/jsGnMovL/Ki+60IbsxTwMkdATpV4uSXtT2Ik0efDUgy/g//NYSVn?=
 =?Windows-1252?Q?RQAj9zeQo25RjrCFA4/g4YUZng1AW7fdjH6QGIgShEnTJ2DoU5o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007)(8096899003)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?7l7Y6Efo6qoCKE6tS3H+WDatRUwwGeMF9qMfahFQLUggEnVcT83ilGTY?=
 =?Windows-1252?Q?9M2+8idexCXnOWGGO3ZHQ7e8sVkZho68LDsGLcSXpQAznEflnvmjlSWE?=
 =?Windows-1252?Q?YKsnU5ka65zOoSw20exnEJ/R8EJ4jNsmuiJN4a+J3jeIPVag+g2PLoYO?=
 =?Windows-1252?Q?y3C1236aDs17JFpPoRR2omtZhLNQOaDc0NBXSr6q4hp0kFuCNdRvQuNF?=
 =?Windows-1252?Q?YgctblJjWkHHkSWYz7NKhLjqhw9wwvq+H4KK1W1hItYzTn9cmy51iCeD?=
 =?Windows-1252?Q?BJI86L/mvkFw9IBY8W0IgSfsTKZpxMZkhzv5VQS2XgR9zFZsFD9HKqhc?=
 =?Windows-1252?Q?vPdfcibd/q45jgZAJu47HHzgmhpnsn/uqURNlRAAb6FIkkazYDIyh6hE?=
 =?Windows-1252?Q?UpZovPqGbAHzUegaJA4dXte3m1qA5+qm51BFUjKOcXHEVjG3TLxiisbo?=
 =?Windows-1252?Q?N3EzHiLi4o6PumZbbkAjFoY18Rx7GVOQe3WYv+hFFiZEbfReiNm4ya/Z?=
 =?Windows-1252?Q?Zh7mHKAuZQ+MxqFdsAWamm8MQYqduQAiJb2X/QCT0X7b3pQqV1hnfGTz?=
 =?Windows-1252?Q?cvQCuUMnIwfjBSgBfeWoB6uo3eFB7TFEi5cSFLNlnQ1BHdm9/ZAB7LN6?=
 =?Windows-1252?Q?AbvgWgW1MnfGvEviyrEFIbXHtCoflPwDnArrzTPd5jrCzxYvSekOiahu?=
 =?Windows-1252?Q?U03c/RBQgdX2WZLanVb9/NsIw29+HAlO34FQCKRuBScvLMXsWuQoEX1h?=
 =?Windows-1252?Q?3AZBprGujC+HvvjhjmhsFwPJpfMqhjMGx3/IP45QeLV/NDS91Lg03ras?=
 =?Windows-1252?Q?XoXd3PbF+1Er36DBluSTSTBqBLmPJc4DLDl1sPU1TfYFRBZVq2JEtsTh?=
 =?Windows-1252?Q?h3elG56p+Xte5kpxELD1iRIFFMX288FCdqmlt1fwYf2KzJVOez39Xwx0?=
 =?Windows-1252?Q?AF/W6q/5kaZTQNLN8WkN3RQKf3eWvZwTsqcCJ8+E6AMCDgRckScKUMEi?=
 =?Windows-1252?Q?NZU1bgIYVjrvKTW1PV7/j7uORZUzxcpR6ZwZB5WnO58nLX6ybcFiI0f4?=
 =?Windows-1252?Q?ZoMETTpxf/KtY7vpxuSJ8B+/9E7XpvuQi+YpcqWr1bxU05H4OGr1ycS0?=
 =?Windows-1252?Q?AW/7qk4RKWsoFXiA3ZxiTLTjqk88XxGYSYW7WKHteEFB+Bl+6+07THq0?=
 =?Windows-1252?Q?AUdChzPEw2Egu2WNdloB3pOs5XW4bIj+Thdp0LWfIm+VTvOAbwh8jcz/?=
 =?Windows-1252?Q?5q4s3bI8UpftNm8JqiRr8hJPKxd5GsOWmx4e5OSNU77wZeXJELp1kw1D?=
 =?Windows-1252?Q?CTAJ+H87A5HfAnktFogmPzbK79KiPky/BSxxvrIDz8kylGUqIskL8l5U?=
 =?Windows-1252?Q?WJIRStlDbB6fY3ZywEiyNs42hBRyFrQDy66IEXp8vgJ9vW5TUQskmIZ/?=
 =?Windows-1252?Q?5FN8gUWXN/RCUGvqG8Oa+gJNPF/nerM1y9iQfNWlcO6zRzMdwcIBLsJj?=
 =?Windows-1252?Q?BEyWuC22B2UwLIVXCUHvW4YOYmHVZOT8X7HVfyWzvjyDoFwwQRyhEWrQ?=
 =?Windows-1252?Q?K7T5pVf9BJXDquZLd+Ky+nzzXgAt6Tcfvke4l20KHHkLD0hLQmCsr2PW?=
 =?Windows-1252?Q?q5mg8qKcM3v4d5wLm6Q6/VlVpw968Ww5SHzgF2gveXLwQ5sF2raqBZgq?=
 =?Windows-1252?Q?FmflsUrD0HI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB74589B3EB4B98A5DE37AF748819CADS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4b3642-bebb-46e0-74ce-08dd96c27005
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 10:46:40.3634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zXqwl29ZodAy1V0e2UYulRB4RObvwlbrpwqqVTYpa7Xf4cq9oDk92ZuUjmU8LDbvum61KfQf2mLlXatYOd0MjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6395
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

--_000_DS0PR11MB74589B3EB4B98A5DE37AF748819CADS0PR11MB7458namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Yangming,

How did you configure the queue pairs differently between the primary and s=
econdary processes?

The application must call rte_cryptodev_queue_pair_setup() with a unique qp=
_id for each process. This implies that each process should receive distinc=
t queue pair configurations at runtime. From what I can tell, it=92s likely=
 that the secondary process is still using the same queue pair as the prima=
ry process.

Regards

Kai




________________________________
From: Moses Young <mosesyyoung@gmail.com>
Sent: Monday, May 12, 2025 11:10
To: Ji, Kai <kai.ji@intel.com>; Yang Ming <ming.1.yang@nokia-sbell.com>; de=
v@dpdk.org <dev@dpdk.org>
Subject: Re: [PATCH v2 2/2] crypto/ipsec_mb: fix QP release in secondary


On 5/7/2025 11:25 PM, Ji, Kai wrote:

Hi Yangming,

PID check is implemented here:
https://github.com/DPDK/dpdk/blob/75f179ebe347b6098cf3af26d3d3b7168fe3fe24/=
drivers/crypto/ipsec_mb/ipsec_mb_ops.c#L376

Can you share the steps to re-produce the error ?

Regards

Kai

________________________________
From: Yang Ming
Sent: Thursday, April 24, 2025 15:26
To: dev@dpdk.org<mailto:dev@dpdk.org>
Subject: Re: [PATCH v2 2/2] crypto/ipsec_mb: fix QP release in secondary

Hi,

On 2025/4/7 13:25, Yang Ming wrote:
> From: myang <ming.1.yang@nokia-sbell.com><mailto:ming.1.yang@nokia-sbell.=
com>
>
> When a secondary process tries to release a queue pair (QP) that
> does not belong to it, error logs occur:
> CRYPTODEV: ipsec_mb_ipc_request() line 373: Unable to release
> qp_id=3D0
> EAL: Message data is too long
> EAL: Fail to handle message: ipsec_mb_mp_msg
> EAL: Fail to recv reply for request /tmp/dpdk/l2hi/mp_socket:
> ipsec_mb_mp_msg
>
> This patch ensures that a secondary process only frees a QP if
> it actually owns it, preventing conflicts and resolving the
> issue.
>
> Signed-off-by: myang <ming.1.yang@nokia-sbell.com><mailto:ming.1.yang@nok=
ia-sbell.com>
> ---
>   drivers/crypto/ipsec_mb/ipsec_mb_ops.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c b/drivers/crypto/ipse=
c_mb/ipsec_mb_ops.c
> index 910efb1a97..50ee140ccd 100644
> --- a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
> +++ b/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
> @@ -138,6 +138,7 @@ int
>   ipsec_mb_qp_release(struct rte_cryptodev *dev, uint16_t qp_id)
>   {
>        struct ipsec_mb_qp *qp =3D dev->data->queue_pairs[qp_id];
> +     uint16_t process_id =3D (uint16_t)getpid();
>
>        if (!qp)
>                return 0;
> @@ -152,8 +153,10 @@ ipsec_mb_qp_release(struct rte_cryptodev *dev, uint1=
6_t qp_id)
>                rte_free(qp);
>                dev->data->queue_pairs[qp_id] =3D NULL;
>        } else { /* secondary process */
> -             return ipsec_mb_secondary_qp_op(dev->data->dev_id, qp_id,
> -                                     NULL, 0, RTE_IPSEC_MB_MP_REQ_QP_FRE=
E);
> +             if (qp->qp_used_by_pid =3D=3D process_id)
> +                     return ipsec_mb_secondary_qp_op(dev->data->dev_id,
> +                                             qp_id, NULL, 0,
> +                                             RTE_IPSEC_MB_MP_REQ_QP_FREE=
);
>        }
>        return 0;
>   }

Hi Experts,

Is there any chance to review and accept this patch?

Brs,

Yang Ming

Hi,

David. Thanks for your feedback. I will Cc maintainers in next version.

Kai, Thanks for your feedback. Here's our test steps after applying the pre=
vious patch called "eal: prevent socket closure before MP sync" in this ser=
ious:
1. Start the primary process: Run the DPDK primary process with the IPsec M=
B crypto device.
2. Launch the secondary process: Start a DPDK secondary process using the s=
ame device parameters.
3. Exit the secondary normally.

On secondary exit, error logs show below as my commit log's description:
CRYPTODEV: ipsec_mb_ipc_request() line 373: Unable to release qp_id=3D0
EAL: Message data is too long
EAL: Fail to handle message: ipsec_mb_mp_msg
EAL: Fail to recv reply for request /tmp/dpdk/l2hi/mp_socket: ipsec_mb_mp_m=
sg

This message corresponds exactly to the PID check in the code you reference=
d:
if (qp->qp_used_by_pid !=3D req_param->process_id) {
    CDEV_LOG_ERR("Unable to release qp_id=3D%d", qp_id);
    goto out;
}

In our view, this log indicates an abnormal condition: a secondary process =
should be able to release its own QPs without triggering an error during no=
rmal shutdown.

Thanks for your help.

Best,
Yang Ming

--_000_DS0PR11MB74589B3EB4B98A5DE37AF748819CADS0PR11MB7458namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
Hi Yangming,&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
How did you configure the queue pairs differently between the primary and s=
econdary processes?</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
The application must call rte_cryptodev_queue_pair_setup() with a unique qp=
_id for each process. This implies that each process should receive distinc=
t queue pair configurations at runtime. From what I can tell, it=92s likely=
 that the secondary process is still
 using the same queue pair as the primary process.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
Regards</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
Kai&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend" style=3D"color: inherit;"></div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Moses Young &lt;mosesyyoung@gmail.com&gt;<br>
<b>Sent:</b>&nbsp;Monday, May 12, 2025 11:10<br>
<b>To:</b>&nbsp;Ji, Kai &lt;kai.ji@intel.com&gt;; Yang Ming &lt;ming.1.yang=
@nokia-sbell.com&gt;; dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH v2 2/2] crypto/ipsec_mb: fix QP release in =
secondary </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">On 5/7/2025 11:25 PM, Ji,=
 Kai wrote:</p>
<blockquote>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);">
Hi Yangming,&nbsp;</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"line-height: 19px; font-family: &quot;IntelOne Text&quot;; fo=
nt-size: 10pt; color: rgb(0, 0, 0);">
PID check is implemented here: &nbsp;</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);">
<a href=3D"https://github.com/DPDK/dpdk/blob/75f179ebe347b6098cf3af26d3d3b7=
168fe3fe24/drivers/crypto/ipsec_mb/ipsec_mb_ops.c#L376" id=3D"OWAce7322dc-1=
9fb-9a60-b9da-0cc56219bc49" class=3D"x_OWAAutoLink x_moz-txt-link-freetext"=
 data-auth=3D"NotApplicable">https://github.com/DPDK/dpdk/blob/75f179ebe347=
b6098cf3af26d3d3b7168fe3fe24/drivers/crypto/ipsec_mb/ipsec_mb_ops.c#L376</a=
></div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);">
Can you share the steps to re-produce the error ?</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);">
Regards</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);">
Kai&nbsp;&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Yang Ming<br>
<b>Sent:</b>&nbsp;Thursday, April 24, 2025 15:26<br>
<b>To:</b>&nbsp;<a href=3D"mailto:dev@dpdk.org" id=3D"OWAb157fb33-c271-4671=
-52d4-55ae7fc02603" class=3D"x_moz-txt-link-abbreviated OWAAutoLink">dev@dp=
dk.org</a><br>
<b>Subject:</b>&nbsp;Re: [PATCH v2 2/2] crypto/ipsec_mb: fix QP release in =
secondary</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">Hi,<br>
<br>
On 2025/4/7 13:25, Yang Ming wrote:<br>
&gt; From: myang <a href=3D"mailto:ming.1.yang@nokia-sbell.com" id=3D"OWA3f=
9efb88-ef9c-2a54-dceb-f658b1698fba" class=3D"x_moz-txt-link-rfc2396E OWAAut=
oLink">
&lt;ming.1.yang@nokia-sbell.com&gt;</a><br>
&gt;<br>
&gt; When a secondary process tries to release a queue pair (QP) that<br>
&gt; does not belong to it, error logs occur:<br>
&gt; CRYPTODEV: ipsec_mb_ipc_request() line 373: Unable to release<br>
&gt; qp_id=3D0<br>
&gt; EAL: Message data is too long<br>
&gt; EAL: Fail to handle message: ipsec_mb_mp_msg<br>
&gt; EAL: Fail to recv reply for request /tmp/dpdk/l2hi/mp_socket:<br>
&gt; ipsec_mb_mp_msg<br>
&gt;<br>
&gt; This patch ensures that a secondary process only frees a QP if<br>
&gt; it actually owns it, preventing conflicts and resolving the<br>
&gt; issue.<br>
&gt;<br>
&gt; Signed-off-by: myang <a href=3D"mailto:ming.1.yang@nokia-sbell.com" id=
=3D"OWAb2264f81-2e4b-4c96-ab14-a31b1a26ffdf" class=3D"x_moz-txt-link-rfc239=
6E OWAAutoLink">
&lt;ming.1.yang@nokia-sbell.com&gt;</a><br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/crypto/ipsec_mb/ipsec_mb_ops.c | 7 +++++--<br>
&gt;&nbsp;&nbsp; 1 file changed, 5 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c b/drivers/crypto/i=
psec_mb/ipsec_mb_ops.c<br>
&gt; index 910efb1a97..50ee140ccd 100644<br>
&gt; --- a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c<br>
&gt; +++ b/drivers/crypto/ipsec_mb/ipsec_mb_ops.c<br>
&gt; @@ -138,6 +138,7 @@ int<br>
&gt;&nbsp;&nbsp; ipsec_mb_qp_release(struct rte_cryptodev *dev, uint16_t qp=
_id)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ipsec_mb_qp *qp =3D d=
ev-&gt;data-&gt;queue_pairs[qp_id];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint16_t process_id =3D (uint16_t)getpid();<=
br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!qp)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; @@ -152,8 +153,10 @@ ipsec_mb_qp_release(struct rte_cryptodev *dev, ui=
nt16_t qp_id)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; rte_free(qp);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev-&gt;data-&gt;queue_pairs[qp_id] =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else { /* secondary proces=
s */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return ipsec_mb_secondary_qp_op(dev-&gt;data-&gt;dev_id, qp_id,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NU=
LL, 0, RTE_IPSEC_MB_MP_REQ_QP_FREE);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (qp-&gt;qp_used_by_pid =3D=3D process_id)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ipsec_mb_seconda=
ry_qp_op(dev-&gt;data-&gt;dev_id,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp_id, NULL, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_IPSEC_MB_MP_REQ_QP_FREE);=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
<br>
Hi Experts,<br>
<br>
Is there any chance to review and accept this patch?<br>
<br>
Brs,<br>
<br>
Yang Ming<br>
<br>
</div>
</blockquote>
<div>Hi,<br>
<br>
David. Thanks for your feedback. I will Cc maintainers in next version.<br>
<br>
Kai, Thanks for your feedback. Here's our test steps after applying the pre=
vious patch called &quot;eal: prevent socket closure before MP sync&quot; i=
n this serious:<br>
1. Start the primary process: Run the DPDK primary process with the IPsec M=
B crypto device.<br>
2. Launch the secondary process: Start a DPDK secondary process using the s=
ame device parameters.<br>
3. Exit the secondary normally.<br>
<br>
On secondary exit, error logs show below as my commit log's description:<br=
>
CRYPTODEV: ipsec_mb_ipc_request() line 373: Unable to release qp_id=3D0<br>
EAL: Message data is too long<br>
EAL: Fail to handle message: ipsec_mb_mp_msg<br>
EAL: Fail to recv reply for request /tmp/dpdk/l2hi/mp_socket: ipsec_mb_mp_m=
sg<br>
<br>
This message corresponds exactly to the PID check in the code you reference=
d:<br>
if (qp-&gt;qp_used_by_pid !=3D req_param-&gt;process_id) {<br>
&nbsp;&nbsp;&nbsp; CDEV_LOG_ERR(&quot;Unable to release qp_id=3D%d&quot;, q=
p_id);<br>
&nbsp;&nbsp;&nbsp; goto out;<br>
}<br>
<br>
In our view, this log indicates an abnormal condition: a secondary process =
should be able to release its own QPs without triggering an error during no=
rmal shutdown.<br>
<br>
Thanks for your help.<br>
<br>
Best,<br>
Yang Ming</div>
</body>
</html>

--_000_DS0PR11MB74589B3EB4B98A5DE37AF748819CADS0PR11MB7458namp_--
