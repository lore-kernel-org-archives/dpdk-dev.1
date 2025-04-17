Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A46C369B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Apr 2025 11:12:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10A7C400D6;
	Thu, 17 Apr 2025 13:12:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 2E9EB400D5
 for <dev@dpdk.org>; Thu, 17 Apr 2025 13:12:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744888338; x=1776424338;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=R2Wul3VUlt0sHHhSDV0pAV/xVWz4Oaomx2rfKrhZTHU=;
 b=metKvAWg9qDU0N3Z92H/OIh7Euw88vjG3QxMHcqxy5XB9afFmbwgVqrD
 amCBkNf0eHk2lQWx31/YmVoldJfkLRAuXlobchhjQafmvKmcgYGJ5bsUH
 Z8aM3C4Y7uK1nXLwSHgTwSizeSdy+aELkGPBGAuhVXdkG953C+AqD9ctl
 WNX2lwOviFxv9RtYw6QJIx5cUyuT3A5O1scL7T3siZwF7JFg/pJ6F1+EO
 4IZDSb3MSXmy/6ywyurrfswIGjr7v1XiB1wxXAaTmZnBMvSM7x0sHR73z
 eqlJaM/QL6y+t3NoM1YvPICDs4Z9h5vB41GJiJ3c70/Y//0eA8Ceye9zt g==;
X-CSE-ConnectionGUID: NNYun5QKSRaEyRSn7tmTkw==
X-CSE-MsgGUID: S5l3qce1SbKX+YKC+NSQRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="57854202"
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; d="scan'208";a="57854202"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2025 04:12:17 -0700
X-CSE-ConnectionGUID: C7nZSgKBTba2AprplNH+cw==
X-CSE-MsgGUID: Erw6vOvLRzeLCkodbX1xGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; d="scan'208";a="135627928"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2025 04:12:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 04:12:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 04:12:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 04:12:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcoxMczBEyJ4WeD7sBZ3CywjA8RmSMPJ9DOm17IcvYNi6uQGe7fwKS58/2VwVn+99NRD+qn6lvJcEdVkysRCkhuC4o38k6pI/CHuhzjrdFKAOhQhWQsbhlXB0rz5EWlt9OEOaYOYzPmceOXb0R+6qPG1AJs1LXJ3opyqawh3RfsJ4E2dt39NwtEqZ5mmZAcxJAjnYIHWTgpwN8dUmiAUBaEXoUcWz+H0ALAJOmlUpWa+mnDOANKBR0rwsnPKIazGQt/rpVtmb7L3pgchfOxHKgL3C/5Nafqv/qtEeJwZhpNfqVmbTKHLWzJ7P6HENAqARPB9YWUiz10gFC3OmWOVcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2Wul3VUlt0sHHhSDV0pAV/xVWz4Oaomx2rfKrhZTHU=;
 b=aXpxHWUha1s3fxwOHaIiy1BALf9rZl+ONYghKsEJI/EjwVKXFXDYkZCNE6K2JQiNFBSZypskjkAfHIAsYl2qxBgqlj35UtBGwSVl3nqvHot54U/0TeK0cXud5fc+vv9IImWnLet1G2c7uHL1wxG5/7YOkXRUSf2LcUkRLwo9j5jX44+f6q48VallyD+lhfiyepqj9gUmXF/zaQC4LDm/ychjKs+u8TSSJxZdSGu44iulvi2GYfMEkXy+yNx6NBgVg3MvdkAKeTA+mtD2rMo579GpBfZJNcEAfx+N42l60uahk9e9yQbJmZZrSGxYEABysr3pfD/g00/Ro2Nuc2wAQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6803.namprd11.prod.outlook.com (2603:10b6:510:1cb::12)
 by IA1PR11MB8245.namprd11.prod.outlook.com (2603:10b6:208:448::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 11:11:30 +0000
Received: from PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4]) by PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4%5]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 11:11:30 +0000
From: "Van Haaren, Harry" <harry.van.haaren@intel.com>
To: Owen Hilyard <Owen.Hilyard@unh.edu>, "Etelson, Gregory"
 <getelson@nvidia.com>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [RFC PATCH] add rust binding support to DPDK
Thread-Topic: [RFC PATCH] add rust binding support to DPDK
Thread-Index: AQHbqJbQrTpmpKHoHE2sfKugVvsbB7OcYZ4AgAIImgeAADRNAIAAA2F5gAKi/oCAAJeGgIAF4qpO
Date: Thu, 17 Apr 2025 11:11:30 +0000
Message-ID: <PH8PR11MB68032BB0D3CB4356312222BFD7BC2@PH8PR11MB6803.namprd11.prod.outlook.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <20250408145838.2501034-1-bruce.richardson@intel.com>
 <187447a-fb49-2833-7e44-ad5bb0d67a99@nvidia.com>
 <PH8PR11MB6803EEFBDE79D34996494ADAD7B62@PH8PR11MB6803.namprd11.prod.outlook.com>
 <95367723-36f5-13a4-b513-27a7b4f7ee7c@nvidia.com>
 <PH8PR11MB6803A8EFAF0A3E8DA8211254D7B62@PH8PR11MB6803.namprd11.prod.outlook.com>
 <4bdd732d-03ed-3de1-e412-6d57a1b7a8e4@nvidia.com>
 <DM8P223MB0383C15F887791405AAD784A8DB02@DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM>
In-Reply-To: <DM8P223MB0383C15F887791405AAD784A8DB02@DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6803:EE_|IA1PR11MB8245:EE_
x-ms-office365-filtering-correlation-id: 7f2c06db-ddf7-438e-355e-08dd7da09b00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?VWl2bw18OgxJF6Qh+SCBD5hcG1/NEgCUHauE4rjjniRo2vu7hOycH35Sem?=
 =?iso-8859-1?Q?lE/w9sitkB+dX6StvNIPKKPRnNolp721nTHuxSBuObyeAxFNH6UA1C9xw1?=
 =?iso-8859-1?Q?qrZfRhvzp5nc8VRO0gZifZxxurSl+JkN+RS9Hn2I86CHcv0kWYNL73bZ9R?=
 =?iso-8859-1?Q?ivhVKo1W49PLnx479IOwHq0dXP+kqzot0eXZiYq7HUoVQqkkeC6wpdHKVG?=
 =?iso-8859-1?Q?pw1gejTKS1dh0gU2vot5yY4+bcHM3dRgjT/FF6da34Ka3E/vhyCXCp1GDO?=
 =?iso-8859-1?Q?BRcX+l2C99vW6kyVeYiGwrUj0APsggjsqnfarWKidDTXjS8zrBRMDAmJAR?=
 =?iso-8859-1?Q?5j2c4vyLSGBbONAquJODp4jcji8S9+370z2rIdYSArsUHS3MHpPfeg3NV0?=
 =?iso-8859-1?Q?P89lCt0OY+rlrFyyjve55KIsj5dblv6ndNyHeZI1lYY+0MKF8YA6r4NhMS?=
 =?iso-8859-1?Q?mtSCkESd5T8lrcVSHy5mHG82CLu1xbEP3RcYMzpJ89j480W3Fz2zZTqGE4?=
 =?iso-8859-1?Q?8GmhBIzlsckwACRmNmcOfLvcvNdvuzys0bjuQ5OLqejpnb/fZrX1c5IjUf?=
 =?iso-8859-1?Q?Vof4Hy0uVm2LfXDeB1hF6Re8pdNQCRo4kYleZN+Gx3qseFscvebtH1yw0y?=
 =?iso-8859-1?Q?iVsheMr5/ayk3UgQ8a1COlkQeVe5cRRplvyEr5yH+VNZ+xzSEEM73UmNJD?=
 =?iso-8859-1?Q?FrC9eW3FHHdHftdNUS7+dCVKtrQOY3GqwwW8FClfJ8rKRPrZTkfg5IBUdm?=
 =?iso-8859-1?Q?+YzAevNJ1L842/C+RO1wxy/yfDPOI5Iz32ZWTfBnkJWS9x7Kg75v88xhhI?=
 =?iso-8859-1?Q?lQSBzBVrg9O39T7uK2fCIE+rA/zAa4bQ1zBrP1YzgsZ3gueuGxbACNbva+?=
 =?iso-8859-1?Q?pyUJv0B+ME1uyiipOIHZYaZqtPSxhuoAXpsYrmM5B5KhXHy6n5CEg2AeEa?=
 =?iso-8859-1?Q?EtYgkQLmYFREbvZaYJ2IL7s1a+qppYXQ8P1PN/Pe4bKVxADda69do77fzU?=
 =?iso-8859-1?Q?xxJwPwbbEd6xvpT6/dQ4O/novkMXHYIYRrG5jYBLpDH1tDRwrUTKVaMxJA?=
 =?iso-8859-1?Q?LD7szDm27jcyCtjOnnQiRy1Kj4j8UqiWWl2sCaYZbnrA91HWyiK1Hi98A6?=
 =?iso-8859-1?Q?CeH9gJfTkz8l4I35Mj4HVTdSCpOm8HqYbr14t+3oYEU1/J1Mf24nXvGPju?=
 =?iso-8859-1?Q?r86Qw2/A44rawCy35AXhezqPCVIZ5UVPG/Sw31C2JXU1pjqw1yxzCULqrn?=
 =?iso-8859-1?Q?GD4Gr2JkJPwpWQSbHxsHL4U36JmgBEqT1607f+cDr0IcByL7qPse3PCs5A?=
 =?iso-8859-1?Q?+xPC3JujTGd4jEfgg40Ll8g357a9EZyvFQ/zFvHShbH4Op8KHJHVniIoQE?=
 =?iso-8859-1?Q?OX7DFfBfv4TJp5KfymPX1iXB2qz8uHsIjrLxnLPLLVS2jraBUq8RTycnou?=
 =?iso-8859-1?Q?9DXx1ocyoaRl+UszE5HuhDYxZpcoZLMVKOz7CnZhDEnqv87caHQNzHqx2b?=
 =?iso-8859-1?Q?VBorXep2QjpqPDGhkWDBUQ8d7g+96I1DWDcvw2hOus3IvDe0fmYjzQ7Q4M?=
 =?iso-8859-1?Q?nTBWRdE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6803.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ntuizuzQVhWBL/lDX6QUgZ80ymvFUqvaxW3uFACM9Z8EIumkwjKKmfIuCq?=
 =?iso-8859-1?Q?7/TTy7YIVPeIEhL39f7Ar91VCn4iLoJzZCWILp2gyXQXnSQ3/myFIpGBIu?=
 =?iso-8859-1?Q?ajEPRzujTFipg8G7wgmRRwmThx38eLkgx/rcklSpOePgkeSgHTjHTQDF0R?=
 =?iso-8859-1?Q?ldzVPyBHSA1O5nciF1ZKqWkS8zPj4l6u5pnYaLJnY5na2VYCSz1WMmQNWn?=
 =?iso-8859-1?Q?J/VyGOyWCg4fUPMyoGBGVZnBk9dg7q4QbHxcdJhz0wnqC0+M3U2xMMq0uL?=
 =?iso-8859-1?Q?rN05JxFH87hfXo4IagVkLHkCj92VnZyPuX189Gk2fXP6HlFmsFtZzfPlHd?=
 =?iso-8859-1?Q?RFwlbtvdR2+0AjeF75yutFyieVsnCoTvEjAtx6F6AvyeypDdexDB5WWz8U?=
 =?iso-8859-1?Q?Et032ZDSu024uUK8MdLZdSWjl53wYxsDID/yyhlMEIkCGTucL4FA3iwi3M?=
 =?iso-8859-1?Q?KUx+/wLVPUiySBl0S7WWnPPggfMplrQYnmJK3Dd9YgNyUKCl3zyGMIf2gA?=
 =?iso-8859-1?Q?UHQHOXJsIihcmpZ17JWyUG6piWeAsVP9om0PV34DZjgPT30zn/CCgN1eVP?=
 =?iso-8859-1?Q?KWg3bs81qTJyzlWbc9Cg/GLfQw/XPMr1l+0Z629AVJsch0xzZcVCWLQIns?=
 =?iso-8859-1?Q?ZqbvnvrHxDgqHFBR/8T79+79d7d97RJGlF88FTEF0bT47c39HyJWB19wIJ?=
 =?iso-8859-1?Q?K+hUghq5kMnf/XT9N7LK5EwaQzfxBkYTDW/u6MKmUlb5ydCDlxdyXDORSh?=
 =?iso-8859-1?Q?5SErly+ApwEJjb+QsuNZLi1O4LTY8/zIrgY//ZUSbOZlA0+KCDoHcch9sn?=
 =?iso-8859-1?Q?4+qs66cTzMEIBKrz0+VJYmLqLIfvcl3UJ4rUzDYsMQOPscvY1aTZTdJqv5?=
 =?iso-8859-1?Q?MbU6j4Q6vmqGfSp2KyNBmS7nX3PFh8YAZj5aj088ECiYzMGPwCVn+R9y8C?=
 =?iso-8859-1?Q?t4/MSZ3pqid+XnQ/3Aa8dHv0Y4t1CyYJ++apREaZ3wt+mbjLMerCQ2FTUQ?=
 =?iso-8859-1?Q?SmLnsesfPbw5hbVpJ1q7fugmYEaht7mM3zlRohJVBO7ITghPkflD+vjvXq?=
 =?iso-8859-1?Q?yx2lKlA972xm8DggUCM9uRi5G5Ep1XSz4PuhnW1Ri8uBiHbQHuKba7yrIE?=
 =?iso-8859-1?Q?eXANePkDejYPN+2Tzeq9uNB1gWc3PDb6QIXyiPgsns9mIVH0ChK3UlGQYF?=
 =?iso-8859-1?Q?5xX5oY1SGZT+NBcBrF5JIblVsVwHelQ0vicWHyr/4G1QmTehmDCGfpJkM9?=
 =?iso-8859-1?Q?V3WjtCIJ2Us1eQkSShaUe3Uz47mhp6Ob/F8nyEDFZ+EU/SM2gd0ic4JsHl?=
 =?iso-8859-1?Q?XsXtwDILZ+w70c3FCZBh96CMNNHyj8QQDX/mI1mDu0YlIhKll9Uf/n46Xh?=
 =?iso-8859-1?Q?alWLClFVBNHukTsipugEal8MAkGdRoxFEatcX8IFD9i5v8ugICATL1x1YN?=
 =?iso-8859-1?Q?KICxb6f5ipPDa7w7cVqfYMiN4JqzRR2KKGIWuPvWxWUBdPxt6tQCsF6TCD?=
 =?iso-8859-1?Q?1ZtoT15ykwMoEXHXtAiCWzpT08SZTrf1ldMkLzho61mcDPlcnfUCYoXqH7?=
 =?iso-8859-1?Q?vWN1NR+MgbrEwblzCHCRh8gpfbaWya+U3HfuulmmPevwJUa5FT8G2FwsnC?=
 =?iso-8859-1?Q?ggzScRIEobmlwUYelo5DrCoB4bvFSZaeba?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6803.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2c06db-ddf7-438e-355e-08dd7da09b00
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 11:11:30.4823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9tlS2yJN3RfRPU6tY1SlE6VVMk344DB+YpHAPt7UzfuD8/vgaT0wS+Y1Yp13MCg7q9E3qsrcceAV5Egx1RCHuQITkQE8vTwp3uQar5roDEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8245
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

>From: Owen Hilyard=0A=
>Sent: Sunday, April 13, 2025 6:09 PM=0A=
>To: Etelson, Gregory; Van Haaren, Harry=0A=
>Cc: Richardson, Bruce; dev@dpdk.org=0A=
>Subject: Re: [RFC PATCH] add rust binding support to DPDK=0A=
>=0A=
>Hello all, =0A=
>=0A=
>I wanted to chime in as someone who uses DPDK from Rust in quite a few pro=
jects.=0A=
=0A=
Great - thanks - more input from different perspectives is good!=0A=
=0A=
<big snip>=0A=
=0A=
> I think most of the value of Rust can be gotten by making a good Rust API=
 available to consumers of DPDK.=0A=
=0A=
Yes - agree here! Adoption of DPDK in Rust ecosystem must "feel normal" jus=
t like depending on any other Rust crate.=0A=
=0A=
=0A=
> There is value in having Rust for PMDs, but there is a lot more code writ=
ten which consumes DPDK than code in new PMDs. It might be better to hold t=
hat conversation until someone wants to write a Rust PMD.=0A=
=0A=
Building PMDs in Rust (while interesting) is not the primary goal here; cor=
rect. "End user" of DPDK having a safe and high-performance Rust API is the=
 goal.=0A=
=0A=
> I think that there is also value in a version which is "maximum safety" t=
hat takes performance hits where necessary. DPDK is far enough ahead of the=
 performance of most other options that "DPDK at 80%" is still going to be =
fast enough for many purposes and the extra safety is valuable there from a=
n ease-of-use perspective. There are, of course, applications which need ev=
erything DPDK has to offer from a performance perspective, and those should=
 be served as well, but I think DPDK can offer a spectrum where users get s=
teadily closer to "zero overhead abstraction over the DPDK C API" the more =
performance they need, possibly sacrificing some safety along the way. =0A=
=0A=
I like this perspective - as hardware vendors its easy to get hyper focused=
 on maximum performance. To be clear; I want to ensure DPDK+Rust can hit ma=
x=0A=
performance too, but lets focus on Safety/Ergonomics first and then optimiz=
e, not the other way around.=0A=
=0A=
I see (Gregory) you posted some more "Rust like abstraction" code for DPDK:=
 https://mails.dpdk.org/archives/dev/2025-April/317088.html=0A=
I'll reply there shortly, and give some thoughts on the details as next ste=
ps towards a safe/abstracted (but high performance!) API.=0A=
=0A=
Regards, -Harry=
