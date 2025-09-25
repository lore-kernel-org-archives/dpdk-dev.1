Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0DCCAC5AC
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 08:50:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95A8340262;
	Fri, 26 Sep 2025 10:50:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 6E7B0402AB
 for <dev@dpdk.org>; Thu, 25 Sep 2025 12:28:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758796138; x=1790332138;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CavaS1SvAivv34bx7mRXhQydr/2PewXT0cI9rN6XNMM=;
 b=OuO1KwLJ3tVzWLbDFBJXn5JUUbiMx+Rrahn86lhM1g2WLW/MFW0ksscA
 9ajhR2iXrN8Xw9Nm81vsj8auvRD4plRj1BZtGxL2vdtkb0dragdUYnUyv
 hOdqboGazaM4PIgXFN9rBsKHAQeJU8AcxaO+6uhR8ovXGhhKIaxGD/M1A
 0AKHd2W4dq0ARu/is9fj9utp0IbUh+Kr4p7QfQMHNN4OkGMGcMb/vrn3W
 +R76h0/Z24tnVDJZoGXl+RawJJGJrYDdnGzA5wd05jWO+1Vf1K7mFYa3a
 +uUqzAPb8XdFmMADQWGkMQx8jCoXAh1rJBTtKW8b9/+GO6KKgwu+0KFrK w==;
X-CSE-ConnectionGUID: Z0C+9ImgRUKrpKeQNquC0g==
X-CSE-MsgGUID: C0AqlHAoREatYald87b5+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="64949079"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="64949079"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 03:28:57 -0700
X-CSE-ConnectionGUID: 2RRiRR+uS/6tjG2IC4g5zg==
X-CSE-MsgGUID: ggf0NUzJQ3uCr9MYOPOQYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="176903277"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 03:28:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 03:28:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 03:28:56 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.36) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 03:28:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gbh5NXLCs4lfgwj1IQEUcUQGrjbnrfHhFhI9+GRTy/qmOzwYOaQ11uzQC9saveQC1H130zgCi5U3cjCwb8rHVq7AwFvb6J8eaw09gZf+dHpS9WByBEGT4GVXXr4h56ue9e3wv1I9oYk3ZNtcIqDmG6S5cbS9g4UTMQYKYecz7LRBo6Ko2PNJDIytSCS0WGm8F8qhxo9FUn8PN9qJDqOU0Jnht6oi7THUEbw17b5A6d6FWccym/XJg5gQ40t8Rs2RXkPVjKsduKSKo5o9kxf76sU7z6xbJJydhJg3LU6Ncz8pW7If1eb/uGh8iHwbHrZr16yBKDDF9nVZaZCoQyyz9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLsL6tkPV4AiiBQcn4LWVk4BMAKACEjKLh7DyY7P2K4=;
 b=ynTXfPeP0y1Ishfxg2SPbgSSn/dqKACIHedNM1kQhJDviS3qB73OEtpDkisivxWa47qgJomBJ5oGZjlzvvMBarAichh/j1E9OtTi24dng6+bnRWX6z8xnT86Zk06cLhgVKjSdkEKC6wvP7hDPvq0noRA5EjGKBENbUbtITgTCElXouMZruHzpDztaybKFUVpNFv2P4oW2ssEgdSCJ8+ED2N9BxlJgQ3rmRf/Gtny1BaNrcETtuuW879rVvD2g6AuROXyu6hYj3DvBvo2+dzT8wdUYEIQiX2dlgu7yvgrl6v68SdB7WnzXKN6uqaXcYvfELUbsnogjiXhXZmi3YP6wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7762.namprd11.prod.outlook.com (2603:10b6:610:151::15)
 by LV4PR11MB9490.namprd11.prod.outlook.com (2603:10b6:408:2e1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 10:28:53 +0000
Received: from CH3PR11MB7762.namprd11.prod.outlook.com
 ([fe80::2881:e12f:a804:cb14]) by CH3PR11MB7762.namprd11.prod.outlook.com
 ([fe80::2881:e12f:a804:cb14%5]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 10:28:53 +0000
From: "Vemula, Venkatesh" <venkatesh.vemula@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Singh, Aman Deep"
 <aman.deep.singh@intel.com>, "Wani, Shaiq" <shaiq.wani@intel.com>, "Marchand, 
 David" <david.marchand@redhat.com>
Subject: RE: [PATCH v2] net/intel: add IDPF PCI class ID support
Thread-Topic: [PATCH v2] net/intel: add IDPF PCI class ID support
Thread-Index: AQHcLWBqS+mWdrH0ckKUi5HWQDDyULSjqqzw
Date: Thu, 25 Sep 2025 10:28:53 +0000
Message-ID: <CH3PR11MB77627D41B445AAE2826B3C2E9A1FA@CH3PR11MB7762.namprd11.prod.outlook.com>
References: <20250919145125.113028-1-venkatesh.vemula@intel.com>
 <20250924125749.83507-1-venkatesh.vemula@intel.com>
 <aNQBkHHlRXghKY7j@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aNQBkHHlRXghKY7j@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7762:EE_|LV4PR11MB9490:EE_
x-ms-office365-filtering-correlation-id: ceb6e238-62bf-4451-8121-08ddfc1e535f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?WFvQdNX/Ay2u6DzDAKjXuhK1tAJXsM8+PDkAOnB24Eg2Me6OKZnyqHdLFGc/?=
 =?us-ascii?Q?Kgd9Ah2/4gWgfKoRqEcvs5YJ1FPhwkbE7T0qi6TQnY6HRagUcw6OA2NaT0NW?=
 =?us-ascii?Q?PYmLK+UrKLyIbl4foKn21nL9ARFxFzI5D0RkIDlPy43MjHZ1IMaSILm89Vpm?=
 =?us-ascii?Q?LhCqxHUMSc1YHTCMxDC+tBm88DKAJX36PIq5s4jWpKyfmMQl1RW2DQTh2r8p?=
 =?us-ascii?Q?PG0BXokHTGs20ZoMnfOkIF9hBIU8OtS0Knpau/kh9oAv/htTTyUvoGOm1GhY?=
 =?us-ascii?Q?tA2Bq7uLnx2oxLgSW9xJwBcjdDNkcMJxDAXkBBRqgmHf12IMu9I9UWQViSWD?=
 =?us-ascii?Q?8ECxFhe6MnX9N1bpYsh5h1rzHaVB9LcIp9GOcNYT+FYp0vrvFVWMHM6M4Tla?=
 =?us-ascii?Q?N3ZvjyRROaYQIUlrXMsyrBpcxzpvpqH65xbrajhb3+AHnmQ+sOxQ+HPRuNUB?=
 =?us-ascii?Q?x06S7K8bWBu7p6ufMsyz1SS8Ee07T40TD6NMOx0frGMAL1l8E+GLCmWwv1pn?=
 =?us-ascii?Q?CCICzu4VUg8YgdlNpmgIzcsLgkkiZ0JzmBlkQWRAqmhe05O9+NbcVec2yjVm?=
 =?us-ascii?Q?7XjPbyYbITJ8JJQTZYkPWWzr51OjOBzoB1UZspRTyaLk2Gq2laHxQnq6/K6q?=
 =?us-ascii?Q?O756OCwHuQ74m+lF1PW36n3l9ZGYsY1DHWxQOze0WKxWcYsqFCFkUo+8KSyT?=
 =?us-ascii?Q?s4L2uCmZsiYBsl7vnk9MwycfsovYed0xRYxADtmNBFNh3Nj1qmxhS6ifw4jH?=
 =?us-ascii?Q?3XYl/6CYfU2Y6IpkYtD8TyH0PLRUrmtzD7+RTKBHfHcVH7q3HdKW8qLKcJiF?=
 =?us-ascii?Q?H4OjKDdcmdIAPs2lxP7gyA+b609iryBXB3c/LTAm9s36g78ELy4EHjInazmN?=
 =?us-ascii?Q?UwbTPNYCBfrlX1/ukAXW3eC7nZY5oYab2aFVnbUX5j/g7ZaXudbePTduYPbb?=
 =?us-ascii?Q?R0xOc5al31ecfyK2vq2TDTL6B+WGRyO7kIBAncYZnsvgg5ljsOi1m1rkzjM8?=
 =?us-ascii?Q?bAMf6+rdf2xO3dLB0Xs7U5jzNDIaYJi7yw+EUBo5cQUgzQwmN3fOJClrE8AT?=
 =?us-ascii?Q?cld1DB/9f06RpAvRIGBYrHiygzCJFPD5e3QzJr0Oz51ziLHgXgM9IL9ugSeQ?=
 =?us-ascii?Q?qemjpto84CirK1VVnNjoFmeBZDfvaVGqdKdZp2f6U1Nes2pYnXIAnjB+OzHR?=
 =?us-ascii?Q?7/oD+aW8lwHYFaLFxz9roPk4TTfQeD4Ek422LIYtUj6E8tFUa3UXDcfjVLsA?=
 =?us-ascii?Q?gENMujnrtiEpywpkej9cCvEMkhhXBP4AXg+Ct8hY0Mz9eTOv8E6ue7NCEDZc?=
 =?us-ascii?Q?D4RGRd46P63Rys0/aIvh14fDmlbDqMwEqzqBZyN9Ildn+pyCTBH/nUs5PJM1?=
 =?us-ascii?Q?sgvsFdhZfMxGPbN/kYmmmHHxFdjnN1ORRXNY/jg0uYPgVpgjZ7sbdkhO6JaK?=
 =?us-ascii?Q?dP3Sve3bskKl1xKUbhfQXGn6zn8xah6kt68U4SCgzHxj2WAk9ysKC9KACLyD?=
 =?us-ascii?Q?6tRRc2lk+i6zsGc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7762.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HmoDS2AJfxfRIEJV6ilmsSx7cwxEaX1x3ghQKreLQVOlMGrHSSWS+ZwSHyTJ?=
 =?us-ascii?Q?eXuXnAs8dfvYY5vSVFJCsphpBMF70nEtQkzqN3IH064NDSk+1tXV8aR7/bPY?=
 =?us-ascii?Q?uNvh3u21nEX80cNWm0+EWccEK0A7EXmfWxGeffbMoq54FVobXddlB2PqROjN?=
 =?us-ascii?Q?R/2yg4xrm2MGIalZDgkotgWZ9hLgRyyCA+IGDkHuEOOWI7DZ7cXaKrc62POu?=
 =?us-ascii?Q?jdpxTeVXB65/mSNBqWASR/jXBMqZaBwDfXy4BnD7659oWhJFljIrM69MuXbi?=
 =?us-ascii?Q?2hl6Fu4XrgIaiR2MdFXIcNjq6fBlPs8xAJv5PCvhxTykI4jDpiEEjkJTFwG0?=
 =?us-ascii?Q?QwbZW8AxrF7zBYZcCiBB/GCwtXwP5hVT1KK9hFwgLvdD3YjTsf46wu6IqgkZ?=
 =?us-ascii?Q?fXkZJEizbzSnwEeWzRgNsFMkvoSjfh4VK01vGkqP3sCQh5Jb5zhlBD2U8P4p?=
 =?us-ascii?Q?U3vpQ1KKT5EBIHXeOayNOCGsy4SvxVLUyrmY/96N/z7a5lYoDY2uggn6hbIg?=
 =?us-ascii?Q?cdh+shNvK23Qg1dxGXlcc+wkZTOyVdKjo2pio+QYjSOPkoVkjyF9uXCNMjQO?=
 =?us-ascii?Q?N3uaEuRra4hzZR1YoVVDQnhAHS/geR0EgerOd7PgyP8kOjrtwZUc3kXgNBXj?=
 =?us-ascii?Q?I9ESJEbhjpmZiGe4RB9hI1TnSC2lVN8Z5D0FzTZu3mt/XoBtekY2wxGurjnT?=
 =?us-ascii?Q?1YXB50ZFiANHtLzQre2JHZbNABrAsFRFFScW+Zgcya+zu0h4Y1bH9I0OCEe6?=
 =?us-ascii?Q?d30qAafFm4p6Aco4d1EmRoAKV1f84UKG1qRp92HtmnALzHRqTjsUfMUSjJn2?=
 =?us-ascii?Q?D6soobxYam/zvn8TP/RL9WC00uH7x3y5NlMVvJ/jU/CjcQTZRWmNv+k1ifwC?=
 =?us-ascii?Q?+p9e/mOgvO5irxCnXijmNlMEQwBKBGqwTa/taQmiTy36hPvneu9Q1M3TIIix?=
 =?us-ascii?Q?wx7xXcempEmxbrG3itYd+6thn+S7JxXXIftN6vg3qfakV3jZyz3qyvU5TvPN?=
 =?us-ascii?Q?HvVYGq/+cc5PDg3tnAwRTQHavusN/QWP0qH6mx/ogdhMQ/CBDMWJvdC2bhIt?=
 =?us-ascii?Q?S7m0VLmYTxG6eNDld29tljncQju4l+Rqc8ObZTAKvXi4N0J1ZffpPWkx6JzO?=
 =?us-ascii?Q?OJGk10yG483WUbtngFWyafKwymsbqFlTz98Sm4p1u3XCadeI3zg3Nr513RWa?=
 =?us-ascii?Q?qxRheqXD/u1xvq/ImcpGa1b5GAott7i+1fTHbQXVEbVhKfECRnkvyarE8fNR?=
 =?us-ascii?Q?I4A8ZcXEma/BvHQvaR+8laZSWNZqAQUTzal3DQWHvFvdFBVVkzLNC7k3hulr?=
 =?us-ascii?Q?6hNs1iNf/j/R2rMlkWlUNr9og9aS2uTzQoi6CSFuumvc3xYXYOehsgsJHiB5?=
 =?us-ascii?Q?OBkuvDDfF7szbriBOEec3m2pRvcMtGf0oKXhmbfy0EGJcxPV68Vs1qIq/OJW?=
 =?us-ascii?Q?Q8PUFRlI8iWFYP4Schj79Dsv1GFtlk0PCtqCTSNnLIa2WBDsBaC2ZEIk+tea?=
 =?us-ascii?Q?dn1X2akhNjZmOilL87ih7kWQh1tLcnzsujTxjEOUNs9cl8iAY0pgCXMuNXO4?=
 =?us-ascii?Q?vLWpu7ivhOeaI4yDBuk/m4cA95dI2bddjQs2jKXgprYfTX1m5P7N595avCrp?=
 =?us-ascii?Q?3Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7762.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb6e238-62bf-4451-8121-08ddfc1e535f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 10:28:53.4172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W+IBV5fwSx0LewyZK0UOkWb1AyG4xtJM5vHS+EjrmGXDCl5zceUlnqUL4i25JLL2yncI8ESdX47yzI+kBHmDwjS6SSVKyOU57ICDkOK3CM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9490
X-OriginatorOrg: intel.com
X-Mailman-Approved-At: Fri, 26 Sep 2025 10:50:13 +0200
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

Thanks, Bruce, for all your comments ,=20
Noted, will address in V3 patch,=20

Thanks,
Venkatesh

-----Original Message-----
From: Richardson, Bruce <bruce.richardson@intel.com>=20
Sent: 24 September 2025 20:05
To: Vemula, Venkatesh <venkatesh.vemula@intel.com>
Cc: dev@dpdk.org; Singh, Aman Deep <aman.deep.singh@intel.com>; Wani, Shaiq=
 <shaiq.wani@intel.com>; Marchand, David <david.marchand@redhat.com>
Subject: Re: [PATCH v2] net/intel: add IDPF PCI class ID support

On Wed, Sep 24, 2025 at 06:27:49PM +0530, Vemula Venkatesh wrote:
> Current IDPF supports only the MEV device IDs. MMG has new set of=20
> device IDs and same might be the case for the future devices. Instead=20
> of adding new device IDs every time, make use of the IDPF PCI class
> ID(0x20001) to differentiate between PF and VF.
>=20
> Write and read the VF_ARQBAL register to find if the current device is=20
> a PF or a VF.
>=20
> v2: addressed reviewers comments.
>=20
> Signed-off-by: Vemula Venkatesh <venkatesh.vemula@intel.com>
> ---
>  drivers/net/intel/cpfl/cpfl_ethdev.c          |  3 +-
>  drivers/net/intel/cpfl/cpfl_ethdev.h          |  3 +-
>  .../net/intel/idpf/base/idpf_controlq_api.h   |  1 +
>  drivers/net/intel/idpf/idpf_common_device.c   | 37 +++++++++++++++++--
>  drivers/net/intel/idpf/idpf_common_device.h   | 17 +++++++++
>  drivers/net/intel/idpf/idpf_ethdev.c          |  2 +
>  6 files changed, 57 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c=20
> b/drivers/net/intel/cpfl/cpfl_ethdev.c
> index 6d7b23ad7a..8cec977ecf 100644
> --- a/drivers/net/intel/cpfl/cpfl_ethdev.c
> +++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
> @@ -2606,7 +2606,8 @@ cpfl_dev_vport_init(struct rte_eth_dev *dev,=20
> void *init_params)  }
> =20
>  static const struct rte_pci_id pci_id_cpfl_map[] =3D {
> -	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, IDPF_DEV_ID_CPF) },
> +	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, CPFL_DEV_ID_MEV) },
> +	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, CPFL_DEV_ID_MMG) },
>  	{ .vendor_id =3D 0, /* sentinel */ },
>  };
> =20
> diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h=20
> b/drivers/net/intel/cpfl/cpfl_ethdev.h
> index d4e1176ab1..566b395dae 100644
> --- a/drivers/net/intel/cpfl/cpfl_ethdev.h
> +++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
> @@ -59,7 +59,8 @@
>  #define CPFL_ALARM_INTERVAL	50000 /* us */
> =20
>  /* Device IDs */
> -#define IDPF_DEV_ID_CPF			0x1453
> +#define CPFL_DEV_ID_MMG			0x11E0
> +#define CPFL_DEV_ID_MEV			0x1453
>  #define VIRTCHNL2_QUEUE_GROUP_P2P	0x100
> =20
>  #define CPFL_HOST_ID_NUM	2
> diff --git a/drivers/net/intel/idpf/base/idpf_controlq_api.h=20
> b/drivers/net/intel/idpf/base/idpf_controlq_api.h
> index 8a90258099..7c25aabb28 100644
> --- a/drivers/net/intel/idpf/base/idpf_controlq_api.h
> +++ b/drivers/net/intel/idpf/base/idpf_controlq_api.h
> @@ -184,6 +184,7 @@ struct idpf_hw {
>  	u16 subsystem_device_id;
>  	u16 subsystem_vendor_id;
>  	u8 revision_id;
> +	uint32_t cls_id;
>  	bool adapter_stopped;
> =20

This is a poor location to add a new 32-bit field, right between two 8-bit =
fields. Adding it here will likely cause more padding than necessary to be =
added. Add the new field alongside other 32-bit fields to minimize padding.

>  	LIST_HEAD_TYPE(list_head, idpf_ctlq_info) cq_list_head; diff --git=20
> a/drivers/net/intel/idpf/idpf_common_device.c=20
> b/drivers/net/intel/idpf/idpf_common_device.c
> index ff1fbcd2b4..6f083770d8 100644
> --- a/drivers/net/intel/idpf/idpf_common_device.c
> +++ b/drivers/net/intel/idpf/idpf_common_device.c
> @@ -125,12 +125,12 @@ struct idpf_ctlq_create_info=20
> vf_ctlq_info[IDPF_CTLQ_NUM] =3D {  };
> =20
>  static int
> -idpf_init_mbx(struct idpf_hw *hw)
> +idpf_init_mbx(struct idpf_hw *hw, bool is_vf)
>  {
>  	struct idpf_ctlq_info *ctlq;
>  	int ret =3D 0;
> =20
> -	if (hw->device_id =3D=3D IDPF_DEV_ID_SRIOV)
> +	if (is_vf =3D=3D 1)
>  		ret =3D idpf_ctlq_init(hw, IDPF_CTLQ_NUM, vf_ctlq_info);
>  	else
>  		ret =3D idpf_ctlq_init(hw, IDPF_CTLQ_NUM, pf_ctlq_info); @@ -388,8=20
> +388,21 @@ idpf_adapter_init(struct idpf_adapter *adapter)  {
>  	struct idpf_hw *hw =3D &adapter->hw;
>  	int ret;
> +	int err;
> +	bool is_vf =3D 0;
> =20
> -	if (hw->device_id =3D=3D IDPF_DEV_ID_SRIOV) {
> +	switch (hw->device_id) {
> +	case IDPF_DEV_ID_SRIOV:
> +			is_vf =3D 1;
> +			break;
> +	default:
> +			if (hw->cls_id =3D=3D IDPF_CLASS_NETWORK_ETHERNET_PROGIF) {
> +				err =3D idpf_is_vf_device(hw, &is_vf);
> +				if (err)
> +					return err;
> +			}
> +	}

There is no need for a switch statement here, I think. Simplify the code by=
 just adding a "(hw->device_id =3D=3D IDPF_DEV_ID_SRIOV)" check at the star=
t of idpf_is_vf_device function, and use that in all cases.


> +	if (is_vf) {
>  		ret =3D idpf_check_vf_reset_done(hw);
>  	} else {
>  		idpf_reset_pf(hw);
> @@ -400,7 +413,7 @@ idpf_adapter_init(struct idpf_adapter *adapter)
>  		goto err_check_reset;
>  	}
> =20
> -	ret =3D idpf_init_mbx(hw);
> +	ret =3D idpf_init_mbx(hw, is_vf);
>  	if (ret !=3D 0) {
>  		DRV_LOG(ERR, "Failed to init mailbox");
>  		goto err_check_reset;
> @@ -443,6 +456,22 @@ idpf_adapter_init(struct idpf_adapter *adapter)
>  	return ret;
>  }
> =20
> +#define IDPF_VF_TEST_VAL		0xFEED0000
> +
> +/**
> + * idpf_is_vf_device - Helper to find if it is a VF device
> + * @pdev: PCI device information struct
> + * @is_vf: used to update VF device status
> + *
> + * Return: 0 on success, errno on failure.
> + */
> +int idpf_is_vf_device(struct idpf_hw *hw, bool *is_vf) {
> +	IDPF_WRITE_REG(hw, VF_ARQBAL, IDPF_VF_TEST_VAL);
> +	*is_vf =3D (IDPF_READ_REG(hw, VF_ARQBAL) =3D=3D IDPF_VF_TEST_VAL);
> +	return 0;
> +}
> +

Why pass in is_vf as parameter and return int here, given that there is no =
possible error. I would rewrite as:

bool idpf_is_vf_device(struct idpf_hw *hw) {
	if (hw->device_id =3D=3D IDPF_DEV_ID_SRIOV)
		return 1;
	IDPF_WRITE_REG(hw, VF_ARQBAL, IDPF_VF_TEST_VAL);
	return IDPF_READ_REG(hw, VF_ARQBAL) =3D=3D IDPF_VF_TEST_VAL; }

While only one line longer, it removes the need for the switch statement ab=
ove and all the error handling for a non-zero result which can never happen=
.

>  RTE_EXPORT_INTERNAL_SYMBOL(idpf_adapter_deinit)
>  int
>  idpf_adapter_deinit(struct idpf_adapter *adapter) diff --git=20
> a/drivers/net/intel/idpf/idpf_common_device.h=20
> b/drivers/net/intel/idpf/idpf_common_device.h
> index 5f3e4a4fcf..51da8214cb 100644
> --- a/drivers/net/intel/idpf/idpf_common_device.h
> +++ b/drivers/net/intel/idpf/idpf_common_device.h
> @@ -44,6 +44,23 @@
>  	(sizeof(struct virtchnl2_ptype) +				\
>  	 (((p)->proto_id_count ? ((p)->proto_id_count - 1) : 0) *=20
> sizeof((p)->proto_id[0])))
> =20
> +/** Macro used to help building up tables of device IDs with PCI class *=
/
> +#define IDPF_PCI_CLASS(cls)          \
> +	.class_id =3D (cls),      \
> +	.vendor_id =3D RTE_PCI_ANY_ID,  \
> +	.device_id =3D RTE_PCI_ANY_ID,  \
> +	.subsystem_vendor_id =3D RTE_PCI_ANY_ID, \
> +	.subsystem_device_id =3D RTE_PCI_ANY_ID
> +
> +
> +/* PCI Class network ethernet */
> +#define PCI_CLASS_NETWORK_ETHERNET  0x0200
> +#define IDPF_NETWORK_ETHERNET_PROGIF				0x01
> +#define IDPF_CLASS_NETWORK_ETHERNET_PROGIF			\
> +	(PCI_CLASS_NETWORK_ETHERNET << 8 | IDPF_NETWORK_ETHERNET_PROGIF)
> +

So the device does not identify itself as an ethernet device because it has=
 it's class id set as the ethernet-class shifted by 8?


> +int idpf_is_vf_device(struct idpf_hw *hw, bool *is_vf);
> +
>  struct idpf_adapter {
>  	struct idpf_hw hw;
>  	struct virtchnl2_version_info virtchnl_version; diff --git=20
> a/drivers/net/intel/idpf/idpf_ethdev.c=20
> b/drivers/net/intel/idpf/idpf_ethdev.c
> index 90720909bf..80bf53db0f 100644
> --- a/drivers/net/intel/idpf/idpf_ethdev.c
> +++ b/drivers/net/intel/idpf/idpf_ethdev.c
> @@ -1201,6 +1201,7 @@ idpf_adapter_ext_init(struct rte_pci_device *pci_de=
v, struct idpf_adapter_ext *a
>  	hw->vendor_id =3D pci_dev->id.vendor_id;
>  	hw->device_id =3D pci_dev->id.device_id;
>  	hw->subsystem_vendor_id =3D pci_dev->id.subsystem_vendor_id;
> +	hw->cls_id =3D pci_dev->id.class_id;
> =20
>  	strncpy(adapter->name, pci_dev->device.name, PCI_PRI_STR_SIZE);
> =20
> @@ -1313,6 +1314,7 @@ idpf_dev_vport_init(struct rte_eth_dev *dev,=20
> void *init_params)  static const struct rte_pci_id pci_id_idpf_map[] =3D =
{
>  	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, IDPF_DEV_ID_PF) },
>  	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, IDPF_DEV_ID_SRIOV) },
> +	{ IDPF_PCI_CLASS(IDPF_CLASS_NETWORK_ETHERNET_PROGIF) },
>  	{ .vendor_id =3D 0, /* sentinel */ },
>  };
> =20
> --
> 2.34.1
>=20
