Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CA5F0182C
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 11:49:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9DE5402D3;
	Fri,  6 Mar 2026 12:49:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id C3D5040278
 for <dev@dpdk.org>; Fri,  6 Mar 2026 12:49:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772797770; x=1804333770;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zraczjAr6HW3nmGBxgfw3vw4ojj3WwAS+VHNEBaK+ZU=;
 b=Xzegw3xjo+c85/iL9Gsz9Ezyh5VWhaKNpqVFyh6wGUP/CqlcB0ekxY7R
 7mgdrJ5n4AjrpPauyaj61QciOeSTk6CclDIL3VVocctsCuzeJP5caOSQX
 JHMOWIb5IuiT7JvZkJ3buvnyfzTZ4hj05l/jRnd6ElLNqbE9reuG3LtQs
 CEhAL1kElcGXeWv5E23Sjjh3qO6AGxXBGEQ1iwjyFdlF8qZPMFphElXXn
 4NnL9kd+K78tbDRoXrpVLT/62CQojc9c1s8nJPZWDq3C+bj/ps/SwIo1d
 Uwgl1FUnKWiNcgJ1CwjslmZcbTU/xQzTZUCcP3pZDkZmgHPTMHC85OQza w==;
X-CSE-ConnectionGUID: I5HJ7n+uQKmWFkCYGH31RA==
X-CSE-MsgGUID: HOw7i3WWTxi54Ji9a8W7iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="74020080"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="74020080"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 03:49:29 -0800
X-CSE-ConnectionGUID: iuypISr8RAW4qM9+MPWO+w==
X-CSE-MsgGUID: y6VNqdsQSjCl/nYX+Ulr3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="218140237"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 03:49:29 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 6 Mar 2026 03:49:28 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 6 Mar 2026 03:49:28 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.32) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 6 Mar 2026 03:49:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJ0NhlDcpULR0iF7vvy90VZKLvWe6N7Yt8SJ0gQKar990sliv/H6iKBynhq+smdR97frJyWxnR60s2Xjknl00GaBvyneJnVqO5lfzCuapIayaOhhH0Asl6RiIwzGMi99nMlbJu6xhHl50lnTNvhcVzEp7U0dP+kl60m/sJKlRxt/1ocvxnZAyqBerPEog8YtWnKBfgBBbqkOwS7e3X+JuU0KkMEIq5c9EGOli9wlompdaOo9ue0f5hMNOvgoV+lR9w5e0dOrkNOwwxm1etBgFPtiPMhrnhKpsdkr3ky/yHHKctHt3jpznsTsSoXE+V0tmqHcUuezrVOjWNnp2t5K0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xeQl+mN7disKZJD0TiMEW5n+cKWGmvWS/gvr9KcKiI=;
 b=tuTZ5xT/nOdgDeCvfUjnyJcf7PF2iHfOUc5Z7Ok9OLVuqfQ+f86Jduk3NKCq05IPGfN2EALQIc9DRsd8BqunNhDWKIg6Xe3x9xvetqhYo2OyJEs1pmq5zu9CbssVTlI4TnxSymdt10RwT67LWQslZhlm4QJJK+dzAQGek6UhxotfufNM2N8USt4dOA+ZsOcBQ43tHLimj17dzjJC2JpN6to6d/RGulrPBEMfktyKVOuTwofDbv6lC6w11Zmobpq1n2P8QlgUV81Vnaz9KZ5fbRMg5jIAa0W2+3BVwUfGHesTb/IfKbK95KjEWZP2PDKDOrDrdp4qjaWiOj3fFFbfyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by SA1PR11MB7062.namprd11.prod.outlook.com
 (2603:10b6:806:2b3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 11:49:20 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::6d5e:e9cc:2957:6451]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::6d5e:e9cc:2957:6451%7]) with mapi id 15.20.9678.016; Fri, 6 Mar 2026
 11:49:20 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 1/2] net/iavf: use mbuf packet type instead of dynfield
 for LLDP
Thread-Topic: [PATCH 1/2] net/iavf: use mbuf packet type instead of dynfield
 for LLDP
Thread-Index: AQHcmde8lr8rog9Np0qBA8cq677Mw7V6iZUAgCb+BAA=
Date: Fri, 6 Mar 2026 11:49:20 +0000
Message-ID: <DM3PPF7D18F34A105284DA73F198039A0FC8E7AA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20260209152049.1640121-1-ciara.loftus@intel.com>
 <20260209152049.1640121-2-ciara.loftus@intel.com>
 <aYoHAPSKLXs3m67F@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aYoHAPSKLXs3m67F@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|SA1PR11MB7062:EE_
x-ms-office365-filtering-correlation-id: 0fb33995-d659-4fcb-89bf-08de7b766786
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: dNF84FVPxqnN4QLLaagXwj8aFpgJqK7ipD8g8ANyiOlTSOnE+N1CP3Zzqiv3OQPrkTN8r17Miz+XPv2mTI7NAW0VSjD5Kpocg4nA2mmhzbsM0p+h8WVUMOedjSFzTeJm8CuktgZ2sZgr46S3LnpIo9tUO0yB2H0PRli65T079ZvEHaxkrG+fT7irNWv9Zn2XM8wTHj3wkqBbf7NVQ37vneySwYKjpUul7fyEf3boZ7kS3b9MsVCx2If1JyooMpmJW2CJ9AFnZKsSyFFPZfABbKMFSED837I+nrQWa48kTakCB+dG9SQJuvP5ogWnb1S344/hdEMb2rAgMYEVztYYHXXEawTl9Oa6tF1u+my+6YZbhcRijsIDd8lcgHOMCqbzgbnYh4A08IXe1D1mczurf0re7nH21tQS76DkH21uo4Qp//0KQsTcFDmfITQsJCKRLOgklRkZfFoPkdW9BA99LP3KADFXuMztPyK4qdWR2dZ6D3Ytb0tg0Cl5F8Yp4cHinIr60F+MXXxKEhYz/LC6wdq2UJ3sk7uJo8W6VWxyN5Q8kLmTrwf6ywPmuNb2PyWzfTMtrvl09tS1j1xvHcrpks/uyQEN70MhMIfjH4HGPW9hRq5iTVyyc6AXUdedJ2cMIfQ3Elrym/oH+GRbKndt6Ghwkjga3/CJulElSEANZ64dLDFi78/6ksLBRiKS4oAHmzhHDmieFGY6qe+BQZJEWV/ZM2tghJJBd6pid+xNvnJX+wMEntp05ed/M127b+t8vURIPB1tKtMLnH+SfVUcYyTnnz0UrGIjxqgT1uRYPkU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ObcGiOwV4RXWMRndxQKFSIn8LHY+m7pSmy1NBEd9U16MAvW6xVXJtCZ1HWBu?=
 =?us-ascii?Q?YdWHDmz06UTFlVrD2dK7Bev579nP1xjWSyDmvJM5aXZGjOuz8esVtU6LQ7HX?=
 =?us-ascii?Q?y3V18WGP4m1ZV8kj8bM8VbbTxJ3RpLiWLAjKUxYXZ/HSs6ORFZS2qj6MZj4h?=
 =?us-ascii?Q?s8tzO6tQAkq+MXHbKuX4Vkgy9xcsh/VaLRVpl+kPAT9HeTm24V94gDD7PHsT?=
 =?us-ascii?Q?l3ExUjVa2uHW1zuT75043m7sOBShMb6PqGjJ2P5dK5ptglRxpcItlm3aX8xS?=
 =?us-ascii?Q?mQKpbXweDJehnmGRoRF5Y0FcbGiC+6LJityxCSU8yO9uu7lLs+zEmSQ0PJ6n?=
 =?us-ascii?Q?vIkw5Km8cqVmBldtQYDR5aDHg7DXV9wxbBdyQ5lLhy7s5FJygpnsDWDE+J7v?=
 =?us-ascii?Q?Ai4MVfDOAb5pHKS1Usm2NaFHYIIwh26CGfeXwIUayHFZjmgptDxKhoCdWxOa?=
 =?us-ascii?Q?HfX4tCWmAFTXV1BFltpOABAfkhvHXFpXNkdHUBm4q9RFj9Es/bvO2u+hEvCK?=
 =?us-ascii?Q?fQXm70QWgw0WAU7it8EAH1sPQvmLQ67c4lFIsvYewoBj47Od6tnERAvGpj2f?=
 =?us-ascii?Q?j4QOVraxYHQUqlJsmuLrIQiS2IWO8Y1fmCwqbl6t+IPYgLo6X7weSNd0RZP2?=
 =?us-ascii?Q?7bUj8t6Gbke3CWox6N0DAkyJX2WcXmRwUKIc9X4XwE59UOv8ayveW147jAY+?=
 =?us-ascii?Q?7PXZKerFbSSd95+F4EQnX98AgZhyM33glnr5AvgxrL+8Ll4+AZRaNMj6fPRT?=
 =?us-ascii?Q?7GY0t1U6IPCLhlnd1E+EtNkjd4jdTg+NOUEYWPG1RSVdeyUUbh3n7QWrdCDL?=
 =?us-ascii?Q?bHA9Y1De8/vucYeVHx1nEGOhSKgNQpQ60QakN7Wc/fVCjVOZkPXD9mj5Yh9r?=
 =?us-ascii?Q?cY+zexlhM3UphslfPDSaAurNS3wMVpeS5JWaYE9M67FUn5Ib6sD3tAokS5uk?=
 =?us-ascii?Q?JXLDMw4j6SejSrNUmEalYaSzY7BEOE3Ji9Sb4VuTobjC6mRG7R0H8C2lAOQ3?=
 =?us-ascii?Q?Apz5fnR284mgSvsrf4TrheOh+rvfbEq4fSUjFVYSYg1LLg13FGEy9lsfsoGk?=
 =?us-ascii?Q?i+myxy/OYasEUH6+v1Inz7/1dWy82eRuuTCP2VZFWKTcQc4L8/W0OkBVHQ2k?=
 =?us-ascii?Q?ISF/Ss/B0Urwmemed0A+GR2rqjf3UAy3EuFujN7aG9J2HMpu3lvvPov1qIic?=
 =?us-ascii?Q?JNvwY87bpKu+33vk2zcampw9nfbbR1cj+CNComSpMP+pbq05P1M3pYZHuTVz?=
 =?us-ascii?Q?xOmMhQB+qpY1eOAQQ86bd/PFDT6I5UDy2m6duIppNwJa3Rdv6fAcVd/zyhxQ?=
 =?us-ascii?Q?KCBmvyjudQI2KY6bpDgpnJHnwisldPE82M3LmOWBn/Wp+MZSfGfvViIhs0/Z?=
 =?us-ascii?Q?gU73hSwiFb3g9n4q4WNDl5ce8d1mBwuTZvGBCv+70B6g4VKXhLfagWkIV+fb?=
 =?us-ascii?Q?OwRoPBbL3LZqvLjZit43S3/7jxLLicgGU0PVrjPTFaYNJ9w9rQduFqO9YFaz?=
 =?us-ascii?Q?CRahhQguqoN7TcoQGjFeu5bwJYrqGfidkMbZMoyo48TLkmvGQxvSLl+s7lex?=
 =?us-ascii?Q?2SAG3A++vgcRhAZP2QkyILjNRc4J7pZonX5015UbzaWzGovp8VEJa5BW7kGh?=
 =?us-ascii?Q?1++8lRdxsNgSHgDcqKSEmfwwGt6jGbAh1duEIwfjWhk3d72A7bFJ2gsB76JH?=
 =?us-ascii?Q?GyUeUpddrUMh6pRvc2iV8REukfibt9maZezGWKVed9qbv2olPBNCtFeVjSTB?=
 =?us-ascii?Q?NH9AOsb00A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb33995-d659-4fcb-89bf-08de7b766786
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 11:49:20.5985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kPGp7wzdSqNSy9xVSIsj05/XsiQYw07omuYfCDCwzNpETR3cF8pvHXbtGzarSYm61jMpmmYJc/ua5nPk66UBkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7062
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

> Subject: Re: [PATCH 1/2] net/iavf: use mbuf packet type instead of dynfie=
ld for
> LLDP
>=20
> On Mon, Feb 09, 2026 at 03:20:48PM +0000, Ciara Loftus wrote:
> > Instead of using a dynamic mbuf field to flag a packet as LLDP, instead
> > utilise the mbuf packet type field as the identifier instead. If the
> > type is RTE_PTYPE_L2_ETHER_LLDP the packet is identified as LLDP. This
> > approach is preferable because the use of dynamic mbuf fields should be
> > reserved for features that are not easily implemented using the existin=
g
> > mbuf infrastructure. No negative performance impacts were observed with
> > the new approach.
> >
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
>=20
> For ABI compatibility, though, I think we need to keep the old method of
> identifying LLDP packets there too. While I completely agree that using
> packet types is the better approach, we need to go through a deprecation
> process for the old dynamic field method, though.

I will submit a v2 supporting both the dynfield and ptype approach, and a
deprecation notice flagging the future removal of the dynfield.

>=20
> > ---
> >  doc/guides/nics/intel_vf.rst           | 16 +++++++++-------
> >  doc/guides/rel_notes/release_26_03.rst |  1 +
> >  drivers/net/intel/iavf/iavf_ethdev.c   | 13 ++++++++-----
> >  drivers/net/intel/iavf/iavf_rxtx.c     |  3 +--
> >  drivers/net/intel/iavf/iavf_rxtx.h     |  8 +++-----
> >  drivers/net/intel/iavf/iavf_testpmd.c  | 20 +++++---------------
> >  drivers/net/intel/iavf/rte_pmd_iavf.h  | 10 ++++++++++
> >  7 files changed, 37 insertions(+), 34 deletions(-)
> >
> > diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rs=
t
> > index bc600e4b58..197918b2e8 100644
> > --- a/doc/guides/nics/intel_vf.rst
> > +++ b/doc/guides/nics/intel_vf.rst
> > @@ -668,19 +668,21 @@ Inline IPsec Support
> >  Diagnostic Utilities
> >  --------------------
> >
>=20
> <snip>
> >
>=20
> > +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_iavf_enable_tx_lldp,
> 26.03)
> > +void
> > +rte_pmd_iavf_enable_tx_lldp(bool enable)
> > +{
> > +	iavf_tx_lldp_enabled =3D enable;
> > +}
> > +
> Rather than a private function, this looks something that should be a
> feature flag or capability somewhere, e.g. like TSO.

I think that would be a neater solution for iavf, but I
can't find any evidence of any other driver requiring this
sort of explicit enabling of LLDP as a feature. So it would
be hard to justify adding such a feature flag/capability
when it looks like there might only be one driver to use it.
I will consider this some more.
Since we are keeping the dynfield implementation for now,
registering the dynfield is equivalent to enabling the
feature so we don't need an API like this in the v2. When we
eventually remove the dynfield I will try to find a better
solution for enabling the feature, that isn't a private
function.



