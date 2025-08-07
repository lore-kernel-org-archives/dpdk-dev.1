Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA8AC87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 13:12:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59F014028B;
	Thu,  7 Aug 2025 15:12:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 082F440270
 for <dev@dpdk.org>; Thu,  7 Aug 2025 15:12:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754572365; x=1786108365;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GPOtOfWajs7gx2oQuwbkdJvL9uaYcHYY1VZpyF9CfM4=;
 b=lDqt620ipTYDr7KQn7s0T320ntPFU8MNtDnl3Mj7u2dEJZUyhXJkk05y
 9/WWEd+QohQJKp4ih9ObWlSN9IyTcZ0HRbI2akRIMj6m1Whk/O2jBWoNl
 8QdareT/42MkZyXejqZFWzb94S2qwPqnu/IZ/lmqotCPv/psESLCBCW69
 gqEb6MLLQH3aIzkyNfkLIv0cIXG2rjv+XukyxJq9wwqN9PiqxgCt9ue+X
 U2+bYJ0wRN0C29J+Opt4UwwbwfDBzGEExxBJUbQgaW3HeSiFEdtYhTVek
 BNqVSGmeEbOxjlc0Li//HIO3hhaR/Ba6GuNS9bSyuR2Di2jKyd3JjIPzb w==;
X-CSE-ConnectionGUID: JSbzUlrVT5iXZsA0VrrgHw==
X-CSE-MsgGUID: P60ot7ztT5y4JOggnTp3WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56870224"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="56870224"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 06:12:43 -0700
X-CSE-ConnectionGUID: CmScRR3XQ76Ke6Ai/23jYA==
X-CSE-MsgGUID: xMP/YwmQT3+sA9qkHGdHtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="170320273"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 06:12:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 06:12:42 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 06:12:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.69)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 06:12:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMuc/I4mxseKMAMOyFdOu+Qb5nlWQhMRtTiIvuwf5Zg4Iooi/KNb4g5VoEMtXFLRgUb7BpIV5fCHfRTTJhqj/GLfEP6fbw/Bmloi/9otnlasANnKJACWzEBHMy1FifUyxFE+cYzYQKTX6dXXz5yAIzrC3WTCubOLhEdDmQoKSnhjmWMcGFvRd+J8KgVadxVKdc25QUVRHs5tKLGkmmfLqkjlhnGsr8qGaS9F06A+1rD40W6sBYICQvYZZYVhhVwDTg/8iba/xH1mWAe/N5dqUmMdh/2YC1q3Is1tvz/MuStjzp2L4vr95kcPRA3xeBPTWmmiS4oiD/T8F1Gn7gGLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaBMwKhXAmlRQLZSTDxfXLwiLXz/KCnJxZ80UXnnge4=;
 b=i+4DTA9A56V4BdHReneNGJHWvzvM8LLqyyPjGR6yn1B9hQieeKdsTZizq8V4ZdrqSjO4H1YAO+FUn0jkQLtmIAS+JhiP1AYvh719uQMl8Bh4LOAvkgvuogpPt5Hy9x/uGF0HTF/DvkY1uGhg7YTDrM5PPiMs0HKeCXJlYPRYsyNvz3Ew99HUchDim5ZT5s5KrTDpZ9AqEx9PEhuIqGuECnilITK452jc2SdpFFNm7XF1w62XHrJ+k9M+hA4n4BOa0Naw+9yfudY8NoZW5875kTANWJHWGLilLwGyHCmi2zkYi7DbckkH07DqAxRTSuudZaUPY+3qFm1rMR0F/sQkGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by PH0PR11MB7563.namprd11.prod.outlook.com
 (2603:10b6:510:286::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Thu, 7 Aug
 2025 13:12:37 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::8884:e7ab:f18e:a4ac]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::8884:e7ab:f18e:a4ac%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 13:12:37 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH] net/ice: fix VLAN tag reporting on Rx
Thread-Topic: [PATCH] net/ice: fix VLAN tag reporting on Rx
Thread-Index: AQHb9Nn4CZvmATK+nEyD2HozHbJiC7RXTzUA
Date: Thu, 7 Aug 2025 13:12:37 +0000
Message-ID: <DM3PPF7D18F34A101278BEFE9987464A1A58E2CA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250714161050.289375-1-bruce.richardson@intel.com>
In-Reply-To: <20250714161050.289375-1-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|PH0PR11MB7563:EE_
x-ms-office365-filtering-correlation-id: ac66a75e-54b5-4919-5c1a-08ddd5b4147a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?BuhWnrQcar67q5qhx82nO5v12Q3YlmuLoxwDVOG9sw6xrmOqfA0G4EgC0g4I?=
 =?us-ascii?Q?KSsyNU1NoeR7bZDWTxU8SqSSovSVaLw1TijutxIoRuq/xxTH6hPRGqEhji++?=
 =?us-ascii?Q?7LSyOi3C82cV9g8+k5D1a46HlN1FUOL6fyO4vpuL7SEMmMqqbrxF6/3d14bi?=
 =?us-ascii?Q?UPk7i1r7sGd6EN3kT1O7RnXPU86lFsJcDYyWinoh1Bl+gfKqngN4nIPjCgG3?=
 =?us-ascii?Q?T0S1v44rJ6mJgwpVjZGxtPTny8P5d2WeFQ8fFu1PL3RLdvi6Y+3oqdLHtjWY?=
 =?us-ascii?Q?Y/uYLNbjleCqUBpDrVWstG/QxUkYeEt5sEBG1OBXyKT5gbCm3XjUUgNGsmU0?=
 =?us-ascii?Q?UVc6z344yYmLt6wb2Y/25XJIUifERtGZym0IiCqOAstTywXGpeH2KmQaVLkB?=
 =?us-ascii?Q?wd5VKGeeHJ+EvfUG0ZgFC6pPyZ48tnNAzqZU5qD8G/wUZEAuw0LkMXxTxSOo?=
 =?us-ascii?Q?qyjeQnOOe/uVWUCUOetLU4TT7+xenBLxhmqipH3/P3qmKh0fbpFH/O9NCOpw?=
 =?us-ascii?Q?pfQTZLyDybS1BQwD7+ejbfoOEH3duvmseRMiAxNJtq4AStQZdcM1gjPatNPz?=
 =?us-ascii?Q?iZVDWnNRSrKXs6p5T8bR7jPvgaHzEfjcwIiGW596qtF+T2pUuhTgDhVfvuw7?=
 =?us-ascii?Q?p5Df0XjYlitP24TojIcHK+WOwWsyWvqGv9LO9vVY5m/7YQARnj9D9awPV25a?=
 =?us-ascii?Q?RFOSj4ESeCHF8KNpe+yark2s+V+eK8lhOL7/iVwipyEFiYO92Guk31CcSFvX?=
 =?us-ascii?Q?g62s/4NZLdkZPrYbI+fFJ4lfF1ExohJlclj3+QDkRFKAo7HmayNCTZUrcd00?=
 =?us-ascii?Q?y3K9fB3kt0VAjmYZ5dFcYMOiNg9vj9ZO1nrMm72pRD3QWmdfn0uxPQdS8KXQ?=
 =?us-ascii?Q?vHIZAWvipi7KaQ/n+X58WLJSb0zghK4a/Nn+VQdtBkauCTK75W3TXcO8i9Uh?=
 =?us-ascii?Q?asBrWiu4jLkrIlpqAqCRyuPkm1qx/6yHz4oIZKK/WJUI7HJ7nPCJUtZNudF3?=
 =?us-ascii?Q?uuzdVbB1cd+quH5Ff6+JctqH4/5PllAmIoTJ56EGShJFJM8ujqcAnZk063Wr?=
 =?us-ascii?Q?1SzCNjUwlcgoLrCgd2Qh+5D+aQ7ylY1GmssJrdRT7PQzkVd8WmbdNrl7RIkR?=
 =?us-ascii?Q?jZJWwysNiui1sD68+V2ieJYGQdb5IiolB908OXeU4jDp6EmkOm2K7FSNL/0Y?=
 =?us-ascii?Q?ETAfETFIynMMg414vdrqxF+siJ8aY0mTklJpHA4a3UTklL5+qfVysUgMY7HY?=
 =?us-ascii?Q?AAVMGgT/Qzdc2uXQx2GN7BQJhSK6oi4Xzai52mFFe6zGzM1qk3HLssrjRB1W?=
 =?us-ascii?Q?tZKQ1bklEjqxKwb+t0/lWEUiqjHl/Z7o1LNdjRI9XTv+uoNbLO/qgBbsSRKN?=
 =?us-ascii?Q?qLL5dUpSaq6FdZN7021m42wOuUodBIT/s5w5S3ts+IIy9jbAckIqfnY5VWt5?=
 =?us-ascii?Q?m4eS+cKMIuNi/b/nVwnff+vUV9452/pCpLjlS1rsVGIvolkBLOcvQdN4vomp?=
 =?us-ascii?Q?IWOG1x9VdPf19TM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AL7Kj6Q/0EslVREsXOL2dqPE9u6Lqx6M9Hl47Nf40D91l/sPXmpfVywaIv3S?=
 =?us-ascii?Q?E4EFjRRN4zzo5p9bkxNMUxek2ujxxeCWOqWX0mxRpsundZxMK/e2I+dgGGdF?=
 =?us-ascii?Q?at5wnDcabCBp98z4nterB+2v4pkwuzIzu09dnF9+H/HVf/QI8rZIJEYUnQ31?=
 =?us-ascii?Q?nQtmuk52Hc/+VoKOy2DVvoWr2bzPD7bU+slPUL1hYzIE2gVWUTNTy6LOYkPp?=
 =?us-ascii?Q?61vdOS7wm/RgcFt3ya5yWBfe9G+JoTuBwat9FkAojzUy5cIAF+VIG0DUVPNS?=
 =?us-ascii?Q?oLgCBjKaV0nSKJlLjh4rpsEJjgcrqjkx9WrZ8pirwfKdo6zM0Gg6hBNUZ5jw?=
 =?us-ascii?Q?S/U3BQLFdEY4uMbDSemgbekR6PLadWE2xS4sK/7UkoCRX6r5DWdKfJzfRFD9?=
 =?us-ascii?Q?BngwIRDj3kszxydaMW0GFxz54iKLVHsGRWu0iHohbCgB2QWDWcKLlsThipSL?=
 =?us-ascii?Q?hZrJUo+BFSfuTUP/mzMAGMtLuJCF4X0AuPE9HWIIOZ0KdtrdpV7O+aLLUThI?=
 =?us-ascii?Q?4/gd+iu59NT4DAdjAKMxQS05TADTgtH10sLWzjjzSMvDHc0Y4YKhz3vtyfg0?=
 =?us-ascii?Q?xQDkV+AsgDGwOERLU9PpIAbCXrqCUc3Vz/XS838o2MQAhJdRoRUvjnF/4VzM?=
 =?us-ascii?Q?VHZpp8PVgiDYvs/oJByMRiAGgt5xfGlZqAhFEPGfF1///m+E37pZ5caipcON?=
 =?us-ascii?Q?P04BlGOhROnmicY5YkLk90r3StL3oem8aXQK+LmH5eOwGelbF93vq7EHx7KQ?=
 =?us-ascii?Q?n0yzeZAxlwDKtO/bTWCGo1qpkGC/zWPGRpLEKWPLKQ9HwtSb9BinMbcO68pf?=
 =?us-ascii?Q?Tybd/A/8Ng7lJjPZHrR8ASi0tZ+vXKBCaPY1i06NPk7BpbCso1FGFWIOP3XA?=
 =?us-ascii?Q?eMpSRzbORZMuUKvSKqksAU3FCftDX8CpP0fVm+r79bw9hbXFrPc1aJZliMzx?=
 =?us-ascii?Q?bcVfBTnAcUcn9+rhdfykryGE3hyfOe7V8Cn6qL0UmxgUDR/jQSin3rSDyauH?=
 =?us-ascii?Q?ldKMWOAgg5i4x3Oz6Zf/M55fgJn+vNglOEfh2LH1qozcmez6bm5S6yJDJjWw?=
 =?us-ascii?Q?Ow7zp+4AHTC6D3vz2L4+qR4MJsDklYuaSXFyzBLTkEUk0Mc0Dsu0rvM/0SKx?=
 =?us-ascii?Q?FhOpOcTcWzIY7DeSrfXPIXusYt8FkOcv5vOXavSfcmSg5XyRN5oS//eg1Ofi?=
 =?us-ascii?Q?C7UB8C0RcF17S+2yb5fp/qhrhRSdNiVgojRNw5t95HhoFN3p1GnOH10pFADw?=
 =?us-ascii?Q?xVjvd37hXWJh9pcdR3/F8wqAxBl53xzZzsVm5SnH7dRFxUeUgtUF8o1oHYX0?=
 =?us-ascii?Q?zhelomVxE6Y203TrL0wFC+7oy6JPOkDWhJE0XGWIBTdTdKRP8+Kquf2XWClP?=
 =?us-ascii?Q?LtYopPoinAwQCoKyAg2AWDEIcVgohvWxQyvBn9f75ZwppHeSDOdqFeYnkD88?=
 =?us-ascii?Q?K8HYyzKkSHNKFA9txePbpFdpSRLapNP8K8QnY+j9yhqbvXYtRmq4jPy3AeO5?=
 =?us-ascii?Q?c/UrH1fmDseUadFYyORVl/jfBeZJ2Q3wVE3f7D7iHfaBEFkPhEKtYUQU6fi0?=
 =?us-ascii?Q?sfDRYmA7wlCL+N/owMVLlNDGmzRUs1LxUHFov4HAStloAyas9yp3kt0pzCEN?=
 =?us-ascii?Q?Jlu9PnZ7L735V3ZFV2G3g1uY7CpUTH2Z5jd75MeIGZNM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac66a75e-54b5-4919-5c1a-08ddd5b4147a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 13:12:37.0779 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0RLGS9iMFVXsSVNyZ848GxHQUERh8QiIOV3uOlpn+DyYJsrLW8ATx9DtCIGc197mdJDWFbvnfDftgPJBMRw7MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7563
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

>=20
> The ice driver expects the first, or outer, VLAN tag in a packet to be
> written to the L2TAG1 field of the descriptor, as configured by the
> l2tsel field when configuring the queue context initially for the
> device. However, when configuring the actual VLAN or QinQ strip
> behaviour, that l2tsel field was changed, sending the single/outer vlan
> tag to the L2TAG2 field in the descriptor. This meant that it was not
> getting picked up correctly by the Rx paths.
>=20
> This issue has been around for a long time, but was previously
> partially hidden by the issue fixed in [1], since due to that bug,
> the l2tsel field was not getting overridden in the single-queue case
> (since the single queue was the final queue).
>=20
> Fix the issue by just removing the code updating the l2tsel field, and
> leave it as set by default in the initial queue configuration.
>=20
> [1] https://github.com/DPDK/dpdk/commit/4cd8c72f6
>=20
> Fixes: de5da9d16430 ("net/ice: support double VLAN")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 75 ++----------------------------
>  1 file changed, 3 insertions(+), 72 deletions(-)
>=20
> diff --git a/drivers/net/intel/ice/ice_ethdev.c
> b/drivers/net/intel/ice/ice_ethdev.c
> index 513777e372..4a6e580628 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -4965,49 +4965,12 @@ ice_vsi_config_vlan_stripping(struct ice_vsi *vsi=
,
> bool ena)
>  	return ret;
>  }
>=20
> -/**
> - * ice_vsi_update_l2tsel - update l2tsel field for all Rx rings on this =
VSI
> - * @vsi: VSI used to update l2tsel on
> - * @l2tsel: l2tsel setting requested
> - *
> - * Use the l2tsel setting to update all of the Rx queue context bits for=
 l2tsel.
> - * This will modify which descriptor field the first offloaded VLAN will=
 be
> - * stripped into.
> - */
> -static void ice_vsi_update_l2tsel(struct ice_vsi *vsi, enum ice_l2tsel l=
2tsel)
> -{
> -	struct ice_hw *hw =3D ICE_VSI_TO_HW(vsi);
> -	struct ice_pf *pf =3D ICE_VSI_TO_PF(vsi);
> -	struct rte_eth_dev_data *dev_data =3D pf->dev_data;
> -	u32 l2tsel_bit;
> -	uint16_t i;
> -
> -	if (l2tsel =3D=3D ICE_L2TSEL_EXTRACT_FIRST_TAG_L2TAG2_2ND)
> -		l2tsel_bit =3D 0;
> -	else
> -		l2tsel_bit =3D BIT(ICE_L2TSEL_BIT_OFFSET);
> -
> -	for (i =3D 0; i < dev_data->nb_rx_queues; i++) {
> -		const struct ci_rx_queue *rxq =3D dev_data->rx_queues[i];
> -		u32 qrx_context_offset;
> -		u32 regval;
> -
> -		qrx_context_offset =3D
> QRX_CONTEXT(ICE_L2TSEL_QRX_CONTEXT_REG_IDX, rxq->reg_idx);
> -
> -		regval =3D rd32(hw, qrx_context_offset);
> -		regval &=3D ~BIT(ICE_L2TSEL_BIT_OFFSET);
> -		regval |=3D l2tsel_bit;
> -		wr32(hw, qrx_context_offset, regval);
> -	}
> -}
> -
>  /* Configure outer vlan stripping on or off in QinQ mode */
>  static int
>  ice_vsi_config_outer_vlan_stripping(struct ice_vsi *vsi, bool on)
>  {
>  	uint16_t outer_ethertype =3D vsi->adapter->pf.outer_ethertype;
>  	struct ice_hw *hw =3D ICE_VSI_TO_HW(vsi);
> -	int err =3D 0;
>=20
>  	if (vsi->vsi_id >=3D ICE_MAX_NUM_VSIS) {
>  		PMD_DRV_LOG(ERR, "VSI ID exceeds the maximum");
> @@ -5019,41 +4982,9 @@ ice_vsi_config_outer_vlan_stripping(struct ice_vsi
> *vsi, bool on)
>  		return -EOPNOTSUPP;
>  	}
>=20
> -	if (on) {
> -		err =3D ice_vsi_ena_outer_stripping(vsi, outer_ethertype);
> -		if (!err) {
> -			enum ice_l2tsel l2tsel =3D
> -
> 	ICE_L2TSEL_EXTRACT_FIRST_TAG_L2TAG2_2ND;
> -
> -			/* PF tells the VF that the outer VLAN tag is always
> -			 * extracted to
> VIRTCHNL_VLAN_TAG_LOCATION_L2TAG2_2 and
> -			 * inner is always extracted to
> -			 * VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1. This is
> needed to
> -			 * support outer stripping so the first tag always ends
> -			 * up in L2TAG2_2ND and the second/inner tag, if
> -			 * enabled, is extracted in L2TAG1.
> -			 */
> -			ice_vsi_update_l2tsel(vsi, l2tsel);
> -		}
> -	} else {
> -		err =3D ice_vsi_dis_outer_stripping(vsi);
> -		if (!err) {
> -			enum ice_l2tsel l2tsel =3D
> -				ICE_L2TSEL_EXTRACT_FIRST_TAG_L2TAG1;
> -
> -			/* PF tells the VF that the outer VLAN tag is always
> -			 * extracted to
> VIRTCHNL_VLAN_TAG_LOCATION_L2TAG2_2 and
> -			 * inner is always extracted to
> -			 * VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1. This is
> needed to
> -			 * support inner stripping while outer stripping is
> -			 * disabled so that the first and only tag is extracted
> -			 * in L2TAG1.
> -			 */
> -			ice_vsi_update_l2tsel(vsi, l2tsel);
> -		}
> -	}
> -
> -	return err;
> +	return on ?
> +		ice_vsi_ena_outer_stripping(vsi, outer_ethertype) :
> +		ice_vsi_dis_outer_stripping(vsi);
>  }
>=20
>  static int
> --
> 2.48.1

You can also remove the following #defines and enum related to the code you=
 have removed as they are not used anywhere else as far as I can see.

#define ICE_L2TSEL_QRX_CONTEXT_REG_IDX	3
#define ICE_L2TSEL_BIT_OFFSET		   23
enum ice_l2tsel {
	ICE_L2TSEL_EXTRACT_FIRST_TAG_L2TAG2_2ND,
	ICE_L2TSEL_EXTRACT_FIRST_TAG_L2TAG1,
};

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

