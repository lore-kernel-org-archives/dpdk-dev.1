Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE61106B510
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 12:12:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75F7540E41;
	Wed, 25 Mar 2026 13:12:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id B6319402CE;
 Wed, 25 Mar 2026 13:12:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774440732; x=1805976732;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RFy/csC2S90KhcwNRX+zRn4IoABvpVUrNXWS4em2qC4=;
 b=O/Fu6Tc6Y4RBWr+YpCUIrDYZUmK+4t/xKOPrjn5y2dLJ0Ix9DqI9fJN8
 vmov5s6WR1J55Cxu0RxJjmNDnCNbZ9D9+ox/zCTHHuPQHJjaHkREmPHNB
 PE8NLzx9FTN1BGZOWxXLdAwjHe6jgZc6TdwK45FmPlYsxHjsp2TbChElF
 DPkDRyqL2K/6CLKb+zBs8KXjbW2P9W2LGdgpDLwiwIWIFkxv6tSUdMlS9
 6JQdQc6tX/4Mw/OU93rP0UdnTladOduGoFA11BpM/k1kx8qQLjKODe26h
 2b6bDSaqxTGv/hcXJUADw3mHgT/F9oP8w/8UuPuWc3CE6cVuUPW12EjZa Q==;
X-CSE-ConnectionGUID: 91xj0N77Sp2lUO21lSvg+g==
X-CSE-MsgGUID: whipTLV9SiS4NhSK16x35g==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75191061"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="75191061"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 05:12:11 -0700
X-CSE-ConnectionGUID: IpulaaxOR2SrlaQ9Y6/eZA==
X-CSE-MsgGUID: YZPsZqw8ScuDQqWWXKoeJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="218089624"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 05:12:10 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 05:12:09 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 05:12:09 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.59) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 05:12:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mb2bOSiN4l3+c/m0uBKONStYjx1YN3ACpGlUjo/SCBJ4JqjHGLs5lfmzK4eqaX1Ppd2wI1zI6nDA2fUbBopf55PhWb99Pj3YtO41TReZerFEPdvqVenWfojtKjxrpYLe18AhvpR0wpye3ZzRlEZxhxQtK3ZrgIab4QA4OwzvuhT+RxuHvpCB9FmlWe2Rhi5DdhnIhQ0StE/5aTLLp295/euZpFGUBIMN6UUQxbR4emuMjz2WhPITOjWt9gKyzUv+Ijp78NZ82iAxmqEc0axOF+3/qIMxGFgmnI7Bls2InAl7ppEzTgygiv6Bji+kvklBKZ0b7bVYY9FlJC4GeW2cqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kob8+N/TJuiQsbNRR22LWWCXJQ4ZPhuzzhRXJoIzT6Y=;
 b=bhMJ9dIclzXEtuE4L5CuzxFdtbLzVf8qW0S98+KJ2NqGG11Ye35H7SA8AC0l3l5oT4X1WZaKkBZ7/m7lng9n8O2Yg1PkHUQfmOM99ic3xgE7dagoXJyNXtWbSmTmLwaMUbcsO+7YULZya1XBy0PAzZW7JminSvVbLMMqHEx9+QdPgzzOvvHJNpggtyhlKnl1uQ9Rh9VTVhPWV3NWAmEdkMumdKVtU7SrGK5kFNPdG3dOMoXE/yQJDLZndeo1UWhLqKbNJoKP4yyb3fmIyxCKCJK8Qof2Wi/MW5Dow47ixbxYrNiWh0ykl5nSRCdNssn72X15HHzZjJx57FAhH1nTrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by MW4PR11MB7030.namprd11.prod.outlook.com
 (2603:10b6:303:22f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 25 Mar
 2026 12:12:07 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::6d5e:e9cc:2957:6451]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::6d5e:e9cc:2957:6451%7]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 12:12:07 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/i40e: fix raw flow item validation
Thread-Topic: [PATCH] net/i40e: fix raw flow item validation
Thread-Index: AQHcu6bSkaExGr60Oki1LOcT4s+DerW93NsAgAFLKBA=
Date: Wed, 25 Mar 2026 12:12:07 +0000
Message-ID: <DM3PPF7D18F34A1C342BE2897987EF10AC38E49A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20260324155627.1849904-1-ciara.loftus@intel.com>
 <acK5uJTAJQRgcxIO@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <acK5uJTAJQRgcxIO@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|MW4PR11MB7030:EE_
x-ms-office365-filtering-correlation-id: 30bc3d71-1919-4f94-38a6-08de8a67bc19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|38070700021|22082099003;
x-microsoft-antispam-message-info: SWk4AWaiLslHBseQyPy4Re2ce7IeojGhDeqyIv1PbQ/HJIDZCzz5yhwU+BzQAp6PGyZwMMiWb2KY8fyzBxZC6TfP2DA3+4MaQXxsAzPKGlHHdh6lhEPfAa35tFByCVROV28k1LDwf4elo9RXQd7NDA2TSul6VAni92Km6JDl0D3dl8krYKp0uRCn4EdpnAnD+ryP+kuOpXnprU4/QJLdB/adxRliaxqq4ivLSg6CgzMgxYMrdIgt/cN39PoQY+iU2DQ/0N7PYKIoR+C42Sy6Vtb8cIuSjlW8VJbNMMpiNOD8g9TPEf2iPFj4qpSvKUQ7est7hfC9tchf4ZHbBSzt4qbOnU0THqvCMc1BsZl6sd0HhMz8NK8y7/nB8nc9Cl5FB3ODb24NqNgiBWPxlsjbXj+NFj5qFqBJZx62grDLFzuj5qacAmYGrj6sE0l/gC93gSVWZXGwRs9teCUUEuUdfGW1vpEL+N2kFxgKpwU7wybrbSD57vQ6Q8f/25kr/rsDuzRrQxMt3XvKXARy/QC9LCa6OTc7fLCgVPuRCbJQ+/Jreez0bGL0DQO4aoAO9DeX0Bm1tZ6CJGU0S0mbRTc35zRQhT0zrJrlUrARLpuplHUOMoK4by6/y/xeVz8xm3CC3e6E499uar/vfSTEgYOr6oken1A+pLYQ4g98ygWMMN9NniReoADplRrqanxOPveODqQPBoxJdq0oMy5CouE3S7Uo2Wcy9W1Vsvgsn0FWrHP+koriWl19sjIR60tSI6sfqV19LYog9VMkjJwBc9cFnNh134NqoF3j5ZDmfPFx5mE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(38070700021)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OIbgjE6dd027QUXnMvyk/6SBcLt+R81tZwccvyW/9fe1pB5mSRFD5ubcXJDb?=
 =?us-ascii?Q?76GOWV9Qy+fdCcc1StZKU4s0GeX30on6Oyo7e0sJCsAuqxRvATkxJHbTcQ9A?=
 =?us-ascii?Q?2ZkQcBXuVtWrLNl4cXJd8b7UeVL4lykOsG3EjTEDq1GF7PzzlleWie/CY2UB?=
 =?us-ascii?Q?iGK/eVCO/E/2v7qApQzVAG/shPH48B3igdH3PtJPyT+9SfLvjbT5RWvFJuvk?=
 =?us-ascii?Q?nBx4Cis3Rf4NbkO/sdFtnPfsrNeTwNs1UMXtUgHbyO49O+g3qdgNKRrXTaT7?=
 =?us-ascii?Q?Px4dKw79dIB6HRfyruGJKdx3mgmBFRUBMKAUW60xQuCCxSsAFop4VRe0N64e?=
 =?us-ascii?Q?poTM6zUdzvqExjfQhKwoT/U0WbdJFGNRyj2bfvRS0oY0M7WcK7iFXzQ2I36s?=
 =?us-ascii?Q?37AlAQkFPSIPl3dUNbAypVL8A3NPIqUZPk0xUxEXPzH48K3rTXWXFguKHFs+?=
 =?us-ascii?Q?w7SvMLLjJ959oH+eUNeB8m1CprDFSqdFyPZz4ZJGiPaM5T9BXecUQBAkdIZZ?=
 =?us-ascii?Q?uanDjgrv8S+TwZT8StiM3d8R/ZMazOfASL60rJqE/HyuapM4sbNzEU3ee2SA?=
 =?us-ascii?Q?NgqcXA6LNXCnS/hIfOrYezbx7IjExs0kKrE8db8GxmJOV0NY2c3JCcVDbr+H?=
 =?us-ascii?Q?LmZKV0bWYDIrMASTOsmubYSEvj4mBkVPHLqMJRT8w5UBUQz50S9ma3korZej?=
 =?us-ascii?Q?zB/V47zDhJBVVUSUG8tsf0dXBZfa3ASk3dGl43uj0KtXlT9kY9taEg3tQBLZ?=
 =?us-ascii?Q?wHhEY8/vw/eQx5vFORPo6FWbAa//8KD/nK6hITshnkJ3jZPzWoKt8OFoIseH?=
 =?us-ascii?Q?JI6KGxgkd1DMXfq35tqUq3shduyXn7o52xogBep2qHSncjt7aOFtqHNNpB12?=
 =?us-ascii?Q?6cSXDOsoLV3mgN0bvKdd3/yXTOk7I/VtbMCw3hTe8Oo9a9yKPVr2Taeuji01?=
 =?us-ascii?Q?jCwmD3uxQJMvssU8p2VjNXk3rX8t0hPZ/16gs7VD+z5C8tcLATJwBn27q3AN?=
 =?us-ascii?Q?VMG6IBhChBZCWHhmHpm6kkXCaGx3Pl7oh6f07+jJccBHflezmHFng4Re7v7W?=
 =?us-ascii?Q?ABf29+V2yAMwRhKQeLzb2NcsjLD4vfVzntajLpBGEn+ZS11bO1K6inYwJe1b?=
 =?us-ascii?Q?vg5EEfFAuf3IW0N267G+F8otTWIV13ElBaQCAVn1sdxcxPAknB/iAben0dgg?=
 =?us-ascii?Q?5O9flkRMW7W4QNA2xARXAFbkE/0qccIWb46IsX0yjbEKi23rmBudfI92KS3d?=
 =?us-ascii?Q?5HD9Ue5oiR/JrZgSJil6AST13FJ28J/t/kTr889ypRMkEGs+/eEm2X1uXv1W?=
 =?us-ascii?Q?MtbAxXlNHUsj2Hy5rL2hPNaufONHY2ZdaB72x6wnkEilxp2Ft+s3BNvFX4Vk?=
 =?us-ascii?Q?M5gduonSQdIDcHNICrFNKCYFmdKb6+gCLGQ6laJcemcdZl0yHXPmKJinmJAb?=
 =?us-ascii?Q?QGc3vUa1OmPbjjHX5T2f0kryUBYfqqnDGCMaBPjIGAeg7bhty1ta4dxM8V8z?=
 =?us-ascii?Q?F+A6lscncIWdgGbzYxl21VJrvZlGDFMQVzzvTvxhUnJku9mVFcfDhfKh6MI+?=
 =?us-ascii?Q?a0qpRi7fSMEPCnJpP7BAAgREomhKEJumm91WmKL91x1jx4Wr0S8bYiKmJjGW?=
 =?us-ascii?Q?UTR0/NcPidHHk9XlzSYGzWgYv31RAiEgyPelU1+W0s2jTTiHvTiPfcETDW2V?=
 =?us-ascii?Q?xJOYXe9rBfR98/uAMHTzTvzL8BYmsXNxTYB06qQ89AsAzLkbaCYblBE4RCO5?=
 =?us-ascii?Q?4QzGT2AFPw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Wz8e9T67A2Ha94qcCvG0o0hZarM1/+irJHLJPQCouhYNwP8MpGEQgXJCnpqfFu1M52KJFq/rY0QCC4LMAG5ujfdmrjb76IsJuPyH8YKgCZsH1SdeOggJDOTWrjKRXWCSkGnaNIwAH9cpXOE3K6TffCx66xW1bWxLuOXWBs/YYtCiYSjU+zuCebfCck4iqa8wJy+e2Lqd+pZ2TjgPCdizL+lDB2rpoK1+eDqNvHEWdM2ptXyIu+YssVdCIN5bkTl1xfOhwAoRDuOrA0u/2019GsvkR2DR9/4pIqZyyletMtc7eBD26FMjuxZfGv4WOuz4k6WxroFFIqoGA6ryhYI8tw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bc3d71-1919-4f94-38a6-08de8a67bc19
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 12:12:07.4952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CqFR9l3LW4wmbvBDv9nY1mBpsUA03qTwITxF3akqEZtw7Rvtko0QrIIbSgoLYkMfoko2yFyVGsCLzvxwvZYuLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7030
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

> Subject: Re: [PATCH] net/i40e: fix raw flow item validation
>=20
> On Tue, Mar 24, 2026 at 03:56:27PM +0000, Ciara Loftus wrote:
> > Commit c138a6c3bd0a ("net/i40e: validate raw flow items before
> > dereferencing") rejected raw flow items when spec and mask length
> > fields differ, intending to prevent out-of-bounds pattern access.
> >
> > This breaks flows using the default rte_flow_item_raw_mask, which
> > sets mask.length to 0xffff regardless of the spec pattern size. Remove
> > the erroneous check.
> >
> > Fixes: c138a6c3bd0a ("net/i40e: validate raw flow items before
> dereferencing")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
> >  drivers/net/intel/i40e/i40e_flow.c | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> > diff --git a/drivers/net/intel/i40e/i40e_flow.c
> b/drivers/net/intel/i40e/i40e_flow.c
> > index 84cfddb92d..78191a2d22 100644
> > --- a/drivers/net/intel/i40e/i40e_flow.c
> > +++ b/drivers/net/intel/i40e/i40e_flow.c
> > @@ -2360,13 +2360,6 @@ i40e_flow_parse_fdir_pattern(struct
> rte_eth_dev *dev,
> >  							   "NULL RAW mask
> pattern");
> >  					return -rte_errno;
> >  				}
> > -				if (raw_spec->length !=3D raw_mask->length) {
> > -					rte_flow_error_set(error, EINVAL,
> > -
> RTE_FLOW_ERROR_TYPE_ITEM,
> > -							   item,
> > -							   "RAW spec and
> mask length mismatch");
> > -					return -rte_errno;
> > -				}
> >  			}
>=20
> This looks a correct check to have. Maybe we need to check how the defaul=
t
> mask is generated for this case and fix things there?

It is unclear to me, whether the length field of the mask should hold
a bytecount or a bitmask. For example in testpmd if a raw flow is
created without an explicit mask, the length appears to hold a bitmask
all set to 1s.
If a raw flow is created with an explicit mask, the length appears to
hold the bytecount of the mask.
Modifying that behaviour so that it is consistent appears to be
non-trivial, I would be reluctant to change it this late in the release.
If we wish to continue to permit the ambiguity in the driver for now,
this patch is needed. Otherwise, we are accepting that the field should
always hold a bytecount.

>=20
> >
> >  			for (i =3D 0; i < raw_spec->length; i++) {
> > --
> > 2.43.0
> >
