Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7C3C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 11:51:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 001D4402D4;
	Tue, 10 Jun 2025 13:51:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 348BF4026D
 for <dev@dpdk.org>; Tue, 10 Jun 2025 13:51:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749556295; x=1781092295;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xJ4hZAiWY1NjUPoa1uLSkJXMuoZ8/vb4+MnvdsFarv8=;
 b=PfVMMkxUO2RmbYXNW/8D/+GuCH6F/m4ZnQWg3olWwVZ/xJGlQ1eQew/0
 v/TFC3XgF7XIUz+/GeQ55V1BX1kal+xuqvkXTmQ/kMeRSvbHss8dPY4PB
 rKpHEfvTkQFFdGLIEnA0iMvU2lYYPurB0KCQY5H4YAWEpJzpWpMLc7Y6d
 VrhJcoozyGck9BEPYZTBEzeguK0i3aURl+WoXEKH6Kn+Q/B554GcTuJLP
 T1+Yc42bc5T5BhfDPNqFUV3IsrdUc+Hg8L2HcypvjplR3fhAgoWp8fZ6L
 843yK1QaLYlDENK/5R9xwKJn5nAGVNKFxHFl8zcve+bwJFSt5WD+ohtN6 g==;
X-CSE-ConnectionGUID: 3fwxiZ8KSd2eBka8CsUF9w==
X-CSE-MsgGUID: rbIJSw7hSGaQiqQNHqjZ3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="63011878"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; d="scan'208";a="63011878"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 04:51:34 -0700
X-CSE-ConnectionGUID: wuBkFHUSSkii+8cnbPO45g==
X-CSE-MsgGUID: iFUYjnGjTySndAzMMOJuLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; d="scan'208";a="146691741"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 04:51:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 04:51:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 04:51:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.77)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 10 Jun 2025 04:51:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKkizbLqAN+kmvxsa9xSpGIw1YJgzwvKbzRfXwva8+s2eK1/6H/LILSVjeA7vhsptdu1gcVegOI01S0M9G+2AROUYGRaSWiQicqAe6BD0OWs+ohyr3xZFAqVYZ1vsTud5+3wCP3a07eogBax4EBnsK4dh+cyGjuKP7C/oE+RSab2Vi7MJXZQhOUXpOHRjQAXQWN/qIcH0BLoGRKBcI4P/Ce6ty2md9Cifef2WniedbD9u7p8ti+PuVIBaPenCoYH++ukSpPrI1n2mRLxxoVwyN7tNgMh8SUtHBDqDg1oATW5VvQswKJrBO5kMFrpkMrIyjzOE1XTp0QJe7nNH9vP8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKA0i1Ca7zXJieC2Ep0CBU35TEzFFkJ2vk7jiByeI78=;
 b=E/79iV/UGi8/KLNbh9U2T/0ustDWccwA+7RBH1rlo4xCrwS+c0ks11cyL8UT7R0RiYT8ZkxOzT3rgpKOpPaxhjGeIDAF1CFBXlMPkCw8BuFqn0a2jN0Sz+o3p8Fk4kfM19gVIDuEbAlHmSR2fhQXyC0o1k33SXzm+mCl7spp4q5DnFyl01TzwacruOuJpqFO4kPPKTF968VuqM05/igVw1c71TmaRsyQTQ7s3hzgzYqZP6AQM58cO+KTI+uq/THap4dP4QQqZw8ezkrwg4UB4dVreO2sofqvxxL4Ygdyz95lCmmHFv36iOPOGck8A+ILOVuruLR39uATS+bvCxMSPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7747.namprd11.prod.outlook.com (2603:10b6:930:91::17)
 by CO1PR11MB4834.namprd11.prod.outlook.com (2603:10b6:303:90::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Tue, 10 Jun
 2025 11:50:37 +0000
Received: from CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::dd94:c5ad:7fd:fd4f]) by CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::dd94:c5ad:7fd:fd4f%7]) with mapi id 15.20.8769.022; Tue, 10 Jun 2025
 11:50:37 +0000
From: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Singh, Aman Deep"
 <aman.deep.singh@intel.com>, "Subbarao, Manoj Kumar"
 <manoj.kumar.subbarao@intel.com>
Subject: RE: [PATCH v3 2/6] net/intel: add read clock feature in ICE
Thread-Topic: [PATCH v3 2/6] net/intel: add read clock feature in ICE
Thread-Index: AQHb2K19cIv8qUgZSE+y/AMhBXkhg7P626cAgAFuQ0A=
Date: Tue, 10 Jun 2025 11:50:37 +0000
Message-ID: <CY8PR11MB774772C9CF4FF5DDCDBFA53BF96AA@CY8PR11MB7747.namprd11.prod.outlook.com>
References: <20250606211947.473544-2-soumyadeep.hore@intel.com>
 <20250608113223.487043-1-soumyadeep.hore@intel.com>
 <20250608113223.487043-3-soumyadeep.hore@intel.com>
 <aEboZmlQum9B21UL@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aEboZmlQum9B21UL@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7747:EE_|CO1PR11MB4834:EE_
x-ms-office365-filtering-correlation-id: ca8fb28d-60f8-45d0-e32f-08dda81503fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?R0Q2OWgHQUhjmzae8M3ndsjHKZFkxbWLIN3D9NSVaw+Aa/0nY+kVHpYt2b8A?=
 =?us-ascii?Q?UOmRmYN2P4Ty+yWOKEm52KIPukWTtqDm7+1YwXf7h+S729mviw5PBVa1+FR3?=
 =?us-ascii?Q?gUOtFFCCf8KnWaVcAFD/Zd0os5Pt02WXlaEzJGjKNLneEevvxdp+BY2Liso0?=
 =?us-ascii?Q?FkChG+D3lg2JlHdNI5n18Dijqjs2KTpIuXHZbTmccj05H3yCafZ+74y3Qi+k?=
 =?us-ascii?Q?QCZlrvG4jQ1tlIxzXJBpvjxT1gXoSAylGRJgLS5d4gKlAqf3GliNbJXCOMNA?=
 =?us-ascii?Q?DAyvgScf+0zMG0D6PWBiV8XCH1rxFrtnYOF++R9FsJHqO3y7FunAsA/raW73?=
 =?us-ascii?Q?HhSCPWl8YQssz7aokWfb/5b8okreW2Gi/P9AHlUHixP5qWOIEvdXVdDGF8//?=
 =?us-ascii?Q?l6w5in6REeGcZAPEexdSDEWGX7PormowhykmOOx0HMPVF7Kns76/t1mTjQiZ?=
 =?us-ascii?Q?sxlOOzp1U1R7/eUjZdLJ3TBHCKELhHU5Cj9PrNSQpMrN/NKJjsMd8i79vuyl?=
 =?us-ascii?Q?60UtODZUrcXRGeYdB28A/V3Qov4ckbk6vTpYQfSgCa1wV0C+U1JK9/exoTiu?=
 =?us-ascii?Q?MtBxrNWko1o6MfXHGdWD4lFURADfcXZCCNVQnDfbOGhSJWKWoleU6Mj5euyn?=
 =?us-ascii?Q?7GYgG6TmtPtZf6cGYeJyIeU1N0cSCullUamjBnZDm/hiqV7eDAJwuZidhRnI?=
 =?us-ascii?Q?8K0ogUQo5fE7d4rK9EKl0xKQexiFx7t2cvcN+icuCoWOWKNUyvpcBirf1dC4?=
 =?us-ascii?Q?gHOyDEA+XLgJxkC4/3DyL+IJZGd6xgxwFsgnWqB/6CupZq9jc9DRgKQrb9qB?=
 =?us-ascii?Q?lamamw46DV0Z5i/CqrhlqxUDw/aei4SrpBKd0eG5dWjZfPOpEVygXTahunfh?=
 =?us-ascii?Q?PSs/kvZ2Q62ZjPwwjudvxwMVZr11l1310uUZZKj9mIGOoFfIPT0iW0yYOzZc?=
 =?us-ascii?Q?Kq9eLp+PANmcRx9N3gORSPrY+0CiQoGTR6WANRMH6wpmhCITce3Bg2BmAIRY?=
 =?us-ascii?Q?AaKqoGD1Z12ANMoUjahrO652Mju4lxLAxjPcUs6MbRgM8a0maQNZy2UOq530?=
 =?us-ascii?Q?RyufZEbz2TTfHmEQogyit7HsWvyf5+KgYIU4WvN+QmAKAGS5MbgCipn/kaUZ?=
 =?us-ascii?Q?4Gf/T9ho1SL7BenblyunLe3wptSIlq4/J0G8v3hFcR3d5wvHpbvPLbcbResl?=
 =?us-ascii?Q?dl8Gpll+BEbzpkQgFf8m5F/on97rwuwuOm9POJ6sx9ja54nr1qn2Z07jeFW+?=
 =?us-ascii?Q?8oRr5aUP8ipJrrBp3oQnyuEsjWog0xJllJAPk4KAzkvd8mXj+GcxalZQ7X6w?=
 =?us-ascii?Q?UHMEU/AsZW+woCSu+86P7xf8Rvaz9ZKEx7aduUuleWxjcNT/o48OQna84SPV?=
 =?us-ascii?Q?AoujjFg+vqJs1RHs+0yHfSp4PHXxW8uyjKZo4gO1yE4fvGXLdqgWmkp6t316?=
 =?us-ascii?Q?Y0NmjlLbJb6q0I9CuSHtkZal9uhQ2gvkHKvu7Ka+lyEtmJgoV8YEZQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7747.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7n1n+4y/bv3X3fbBkgjaBfccCGVyOnth4Ud8wLBTvMWwkyxB9rLdnLqF5jPT?=
 =?us-ascii?Q?tdrXuC1S4fLJhaRu3bEPUyWNSZwDSJkeJUnsJMOKBOsxCaY6cdLWAvvSLn4o?=
 =?us-ascii?Q?cZ3hLwNIs+ucKtXJXIbsrHnHfqS+9kjZzw5ygI5u4xOZy2GFojY9UX9ItMlr?=
 =?us-ascii?Q?Snarq83U+f2d5zE0XO9MGfn3Mr7oXweZBLJz9s468Ju/n8qClQcUGmuT1RKR?=
 =?us-ascii?Q?BcowtQfOEVRMZ+oHMPMuq+5s/LbFyNEPYekv9Wn/+FAqld5KOWxKO7S5glmp?=
 =?us-ascii?Q?9LRZQ+WkkU3dxNMZuc4pcD5ymcbjNy+qhl6TSl/pPrn20UQ7U7IwTpJihtpZ?=
 =?us-ascii?Q?BMeeaTezHmEXI7W3lny5Wtq1+U/Noq0YHyavOF4hUeMZHbme6PmWVYZbjA/6?=
 =?us-ascii?Q?gB/z+399HOljMxGpMHJJJXRssGSEjkmAkaoaVUSbQd2BoeHPKQV2kEHRKVy0?=
 =?us-ascii?Q?CsmSRtva8QowwQSq+Ym/JBgynKG+PM1qQQzB7PbG4UeoqIoFSzh0Cwr12dhs?=
 =?us-ascii?Q?8U51mxAjsOi9bIUwhfLEjzELRWzY6MkcUy1IltYsM7efAsXNJTxzNIDul5rC?=
 =?us-ascii?Q?f9yCMW2oqONnsH6zQhRhqHU2elhANtQVRvJWu5MpJTOFUvpi3ne/9WqdKoQV?=
 =?us-ascii?Q?RqEFq7aA7Dv/PQuV1LtujcrNpzs/MJaUIaF4mTmSVmxxUGHtyqSmawL+FDg2?=
 =?us-ascii?Q?6nxq2UZELHGgPdAqhNJcdKldiyHaWVBJmleGj2Wz1RpFdHVfe9mqDqeLiLpH?=
 =?us-ascii?Q?ap7dqdnqFTi0Apfwiurxerq/0YMTQO3e1SP/hrKSKkD7yZDPD90BZFfO/YOK?=
 =?us-ascii?Q?xOOBkTq69KmJj4+n+oiYoF0wDos70KeNQ8wSLzIK6OPFuw74BFJ6taRldmcX?=
 =?us-ascii?Q?8a/9RsDJxD4w1YTQw6nuyqZ3h5mIbKOqsXEVLUML10aoBXeaUgW4w2NtgXVZ?=
 =?us-ascii?Q?ky1fvfNuDz5JR4xWknNVYgBs4Yjeb9nVCvcA4ZIP6BbTPm2jP2e43uwVrG2e?=
 =?us-ascii?Q?bP4xj1DVJvQdNeJg4y9BhhsPLnEGbn0sF+b23/MHhdgbMgxHyHqEFELEtLq2?=
 =?us-ascii?Q?hKOY+74TPMlQnOm+ewxnx/Xj9kWuxeuLRBlcdGH25uwIiLTbMmMgBjYk2Sj0?=
 =?us-ascii?Q?w0DMzs4iTBFiF9SYAH+OqYazOgIFmLf0WfomASYS33PkpFAH5SDjxItfQUWZ?=
 =?us-ascii?Q?zCSKpc5dGNexKe/I5YDSKPF8QrVzUWrBVA0KsAZJQzzesCHtIFOzFtdO2AaL?=
 =?us-ascii?Q?6X9bCiZUw+yd/dWomnQ+H9wbxXEJjN/Wli8iwAG4ESFCNRupcp3NyN2GeOwj?=
 =?us-ascii?Q?LJ5imZGXGVJMmeVBCy0lNVNoiHOjjRLlBEXP6OXJKYcZP5kftfGjUphrjNwH?=
 =?us-ascii?Q?6ypbdbcuRMQKR72niMhmfIY0gSyal4kSVvyjB1Otog4JqMyOy9wFKXvBKi60?=
 =?us-ascii?Q?qzeWxz5RmGJ+pmM/j0q1GfgU4Gf1okCC6hrjtvSyb8HumqBN0DupVICFkIGM?=
 =?us-ascii?Q?J8QYUnhAE98yLYcsYVEPkJVDeLvomCBmFIhURg2bZgacpMMPuC3ld+QhtdAS?=
 =?us-ascii?Q?E4dY/O5C/GW7H3WiSA7+lV4DtbRCQAisCRzqzkSAOGbrj91b2QMYDvyxu5Je?=
 =?us-ascii?Q?rYYbjD89VqS2E4AL7RNwpcAooNYUk+XoJXNsjBAdORtz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7747.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8fb28d-60f8-45d0-e32f-08dda81503fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 11:50:37.0508 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RHlCHeHkogeSDRDaHJ1EpNwFpIhOZjCLJ4Erwz24Nc35ChIkQdiWUet0z9BdTUv7EU0VhwGHTHBieS7vHxGl84HnwaAEK39FrxB8anPfc5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4834
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

The similar implementation is done in igc driver. Currently we don't read t=
ime from device.
We read the system time and send it out based on the burst calculations. Th=
e mechanism is
same in kernel drivers too.

On Sun, Jun 08, 2025 at 11:32:19AM +0000, Soumyadeep Hore wrote:
> Adding eth_ice_read_clock() feature to get current time for scheduling=20
> Packets based on Tx time.
>=20
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/net/intel/ice/ice_ethdev.c=20
> b/drivers/net/intel/ice/ice_ethdev.c
> index 7cc083ca32..9478ba92df 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -187,6 +187,7 @@ static int ice_timesync_read_time(struct=20
> rte_eth_dev *dev,  static int ice_timesync_write_time(struct rte_eth_dev =
*dev,
>  				   const struct timespec *timestamp);  static int=20
> ice_timesync_disable(struct rte_eth_dev *dev);
> +static int eth_ice_read_clock(struct rte_eth_dev *dev, uint64_t=20
> +*clock);
>  static int ice_fec_get_capability(struct rte_eth_dev *dev, struct rte_et=
h_fec_capa *speed_fec_capa,
>  			   unsigned int num);
>  static int ice_fec_get(struct rte_eth_dev *dev, uint32_t *fec_capa);=20
> @@ -317,6 +318,7 @@ static const struct eth_dev_ops ice_eth_dev_ops =3D {
>  	.timesync_read_time           =3D ice_timesync_read_time,
>  	.timesync_write_time          =3D ice_timesync_write_time,
>  	.timesync_disable             =3D ice_timesync_disable,
> +	.read_clock					  =3D eth_ice_read_clock,
>  	.tm_ops_get                   =3D ice_tm_ops_get,
>  	.fec_get_capability           =3D ice_fec_get_capability,
>  	.fec_get                      =3D ice_fec_get,
> @@ -6935,6 +6937,17 @@ ice_timesync_disable(struct rte_eth_dev *dev)
>  	return 0;
>  }
> =20
> +static int
> +eth_ice_read_clock(__rte_unused struct rte_eth_dev *dev, uint64_t=20
> +*clock) {
> +	struct timespec system_time;
> +
> +	clock_gettime(CLOCK_REALTIME, &system_time);
> +	*clock =3D system_time.tv_sec * NSEC_PER_SEC + system_time.tv_nsec;
> +
> +	return 0;
> +}
> +

I see a number of problems here:

* The "read_clock" API is for reading the time from an ethernet device.
  This is not the same a reading the system time and returning that.
* This uses a potential system call to read the time. (On some linux
  implementations I think it will avoid a system call, but even so, we
  should not add what may be a system call into these fast-path APIs)

/Bruce
