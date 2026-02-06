Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE4EEE2082
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 10:25:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43C854029A;
	Fri,  6 Feb 2026 11:25:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id F1B9840293
 for <dev@dpdk.org>; Fri,  6 Feb 2026 11:25:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770373542; x=1801909542;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=F5sxZ4ra48weIWHma8qiUDz5P2xe2mf4D9YTOb9VmOA=;
 b=DN/A4ppGRvhz3G0Drf5h7Qw9L+V3mP7f4Ji242/gCdO5x1zIJpCmQPY7
 elKBD5mX5f/hEcxhldt9M00V8PA3CJ/A6lXRZV7RGV90XWkZB5v6aOWvV
 OVZUL9LcG7AQyET7rEAHGUZKqDiflOc6pVRY2mA1ndDjyrEKKg2peoc3s
 Z7xBKtMRodC0HUIvzIjMb02jIGjR7xbXnXWq/d7HVzYWLpvqtZ/9dUm6l
 qDkKp3f3goi+5G7Z2KTVEgZc7gsWx1Q5qZeyQyiswYgNR02wP8jKkp889
 7YERb2+RsVE/wprq2RsjJo/hzS0gAWTW26j/oce9/BWOk0C/x5Kl195gZ w==;
X-CSE-ConnectionGUID: dzxss0RIQWSwfIYiFwG/nQ==
X-CSE-MsgGUID: uJtKNRsXR/u9Y86fvET9qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82317279"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; d="scan'208";a="82317279"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 02:25:41 -0800
X-CSE-ConnectionGUID: quY+KTruS1yXqwizgR62yw==
X-CSE-MsgGUID: cxru4HIPShCPoFQMBr3+LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; d="scan'208";a="241312826"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 02:25:41 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 02:25:40 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 6 Feb 2026 02:25:40 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 02:25:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Itoz3DxZ3vEWMSxcnE3Ho59ehps+ddoURzsi1V+yaeC7KU/aXD0sstyNOtcM0KUcVDfXjk+9DcOGLRWOyJFXDHDCpb9NHZq+r/jD92JcgTj10EX1LGYu/oQpf7nsJGysta8ILaj0tWKZhgn4IyG038XxnBkaY0iUi7cpNpJVEyqVXR2Y6OmlWSdCBUlaOYnhqtBi8Z9S60wkuoK9R90jatUK/JZxM96DkYMIR33bYhuj9TW1hwrLgQqYHlVzGmyzRqNaOD+5iLQ//VNNRVG+cIC5yaMuoK1dfWejHjGZ1jHH5jinwrt0EjwyAv+o9ziqN/Ao2xsF80vtdfEz7FfqZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kv54LKqFaOg+f0/xD18sdm+ovQwiLKB9AzTpSa0DCEk=;
 b=UjnUCfdc4T40juI8FHv/jB1F1ImrbKesbp7izKm5/tHbOPw0kzQtVUtzvHEo3mRVD/wSxCCr7TLVvKnOsMJ/m4LZb8SBkAGB6B3liqSPIWcKe9V3yXXwf4GpsBMViaCK68sn6TAy6B89QKr6r4mkwJoS9MTOe2/ynGUsXwrZJfxpU/mAPgQWvOR9z2zmwQZVG9zRaVjMssPkDRgeYCFn9eP4bbltNhRM9rhhzAhvKN1UUfzcij65sKVXPG15XSXQKcMjUbeWX1R0N3iEXweY1Ry1ZlC8Nh/zRPezVm8lPnNvJ7nSyX+Fg6U1VVciCxpQ1uzDTSWUI/gM9/St5+2Vsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by SA2PR11MB5210.namprd11.prod.outlook.com
 (2603:10b6:806:fa::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 10:25:36 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 10:25:36 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, "Wu, Jingjing" <jingjing.wu@intel.com>, "Shetty, 
 Praveen" <praveen.shetty@intel.com>
Subject: RE: [PATCH v3 06/36] net/intel: add common fn to calculate needed
 descriptors
Thread-Topic: [PATCH v3 06/36] net/intel: add common fn to calculate needed
 descriptors
Thread-Index: AQHckd2oep47vm7vq0q6+8z8s+bl8bV1gd7w
Date: Fri, 6 Feb 2026 10:25:36 +0000
Message-ID: <DM3PPF7D18F34A1ED8AB89FC2F13E0E152F8E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
 <20260130114207.1126032-7-bruce.richardson@intel.com>
In-Reply-To: <20260130114207.1126032-7-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|SA2PR11MB5210:EE_
x-ms-office365-filtering-correlation-id: f95d568b-70ff-469b-40b4-08de656a112f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?zgjAsfCD9CVm/6t1+sdKtRLMvlUYJV67OKyAF8mirIOcSgcEhWLwZPt98Ch8?=
 =?us-ascii?Q?hKbH2gdYS0An1FCu0CMT5oR+LQ0fdSx4/OqK06l9nM+NBhxromLgz1h7g8SA?=
 =?us-ascii?Q?3TCFn1K0Cfcp4HNzwq519AKigTnSLOYeI8vJ6MCe4mrjvC27QuLfntbZSFpo?=
 =?us-ascii?Q?OLqoW3rlTXhOTSo79OkZOCylOpqCaYWOfyuHmyFtIV3nT6MED7SxvmwqUnyo?=
 =?us-ascii?Q?jF3+ArsE+ui3PsKm6W8haBylJZkI1c+mQdA4RMRqBA2REuXjHvtvBbHibt1c?=
 =?us-ascii?Q?pnW9eqmFI/yVljVW2Zx0DkxwzH5EI6rud0KTxZ+Pqxm4H8nF+iRq+Ml5X+Lo?=
 =?us-ascii?Q?hI4nc0/QxBslfiEcjmIk6J44/NoNT+gmEpvZ9cu61chjbxn8lUUEDGjgKdpn?=
 =?us-ascii?Q?JoE3dtdP3YT8DawqVbluBs8tDyQUV+vdINVM/cfbpFaLxKiQGMR/0X4+gOT1?=
 =?us-ascii?Q?n0NDNBM6FtufwMP2YrrOvFZ95WwEWuzL2SwaelOkIV+15YSlND6WSH08klhk?=
 =?us-ascii?Q?KqHLCuSv3Y8oVWd+7Ex3QMGgYWRHqKAEQpd1SI7sjl3xJ7CrYQR6ZARIAt7l?=
 =?us-ascii?Q?i0y3zCXd1FRuGWQKo665N52ZgZMU90+Zp/b3xg/q3B+WrwV1Xmi8xCKjpeIJ?=
 =?us-ascii?Q?VOPYrx1Qd0l7ihY7dRfnnGQ80vEHszC9zCEG+VGmsRpSeV9jzOLSQWIfzx2y?=
 =?us-ascii?Q?4xnIyWX1v4PCJ6ssvahVZWFZvbHGWf8SUwLxr3Sk04D3AmqMlEzPVcaNBBG2?=
 =?us-ascii?Q?Xa5+5beOd5H3f8tkJJwgaIf7L6XgFzxA7TUWFzyw/5O4rh+nvMAJzRQbsAaH?=
 =?us-ascii?Q?AHLo86cwllaCZyis+pJmZSluKr3+t0w6JvdNAcvKbFnOxdE/JC05t6d39HY5?=
 =?us-ascii?Q?2WoNulfPYv0NQemugnvyQ4oKB5z4WpNXJouzkXDmOl9STe1AhxIecKT8YIXl?=
 =?us-ascii?Q?LvLMI7dM1ziP6u7Rz9u196AwcgZZrsa4mjHp9sVMRtbOcFusfnjvZ/XRw8P/?=
 =?us-ascii?Q?ojPUZxLypq04icteZmKwemMTQS6654GVJfNbLLS2iV92++nBiSm3R6RZAKnB?=
 =?us-ascii?Q?VRs3RoiPS0kMpGhCyrz148GPnbeaGWs7YElgtaCBF5uKj3C0Nfbj3A/ZoBuT?=
 =?us-ascii?Q?yW4zBQspOnHufgQjDdVcRSM3xSpCGronTEILirWo/KVGam7Mm2NmuRo+BLqB?=
 =?us-ascii?Q?X04aPal6XkeNxwX8+LWWItowRnOuUZrK8Ierxpcud0yPZkSgRqNdxHZqeJxs?=
 =?us-ascii?Q?3F3264xVSFniIYFv5qv+SP/bfRUqPcS55GedLRB2sbO/VWrvM0D+w0lfilPQ?=
 =?us-ascii?Q?DoQycOAf86elgGKPlA1bW+cnD1f7Mt3U+9pdFjd7+u6EvOoBBPY5SnLyaNdc?=
 =?us-ascii?Q?/xzDRElSmy2KvMj3OsiZLiTznvynw547vm3IgVd2Z91bjjB+CBgtRtM3gwH9?=
 =?us-ascii?Q?mGw3jQ+mXksKHEGhpA9GeaDY0LSUbyFa7DvSVJEvUlhl8Z4a3j8bC+oLXfvj?=
 =?us-ascii?Q?WC70PwwDCKl9ERVIOLlQ8aG/WNIfWfbkh4zoaAGe9L6M0yYRzNdUmbumW0il?=
 =?us-ascii?Q?mpwgoDORUtkuN3cdfkhk7xfwYFxz3Er7yr78kTxuIdXgJVNpNrHMph6L9JZL?=
 =?us-ascii?Q?KLuU5jvk4CY5ebbNlJ0DgFY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?amYzapD+tcbSGlkhjzjTIopS0RY2wOj5cnJBmmDi1q6BRL5byOWanExgKyc6?=
 =?us-ascii?Q?AaQ1lV7aQo7uScmj7Uxk+b5StliDDE5ZrDS3Q0AC70JKOQnbT3rey6th2SHA?=
 =?us-ascii?Q?Ruo9uIBPwDUMtSI9YXD6c163kIi7VYF3GN93uxbFcWlcGo/QDA4FJrq919Bc?=
 =?us-ascii?Q?cPv/TtKWW5XksApf6iR+AH1OXHq5+bg+xc/U9vDVUGjQf1iBQ4/mdsvRg6jR?=
 =?us-ascii?Q?DJMyJO6oM4aH1RDDY9KehhbQ4irgOfrO1b6AP5mWpQMCoIEfHBdplH6ZhlQf?=
 =?us-ascii?Q?hQB42jQlIX9ZwLIpsD7ez9MHw4TLO1nNRJXWprzsU1+RVzotbnX+MDWdxKXA?=
 =?us-ascii?Q?FAVHx5CJBOmWcQ3z+uYWcDmexjYmdAk7cyTSg4F7hLCGf/zjO++f1DognU9z?=
 =?us-ascii?Q?WUID+uzUUOlm5TeM6Ejzxddz2XbT9F2/mabMCkn9PWymNaL60wNB8pBbBKf0?=
 =?us-ascii?Q?+fTQD2wuu8FwKdumS5/GF59+Z+KjwaOR5Q2CaHEq6gIyfZgN3wSPK9tMvQ3K?=
 =?us-ascii?Q?mu3Y9okuWn9fZa3gOMnT8GZqmcSsMTlja93gWxxKa46TVDmJHUfpSPFeMn+T?=
 =?us-ascii?Q?M7igRVGp1djBSfk7iKLQ3hitGnL0LoN0xmWITU8QkdppwS9Hk2RjNljt7zuR?=
 =?us-ascii?Q?DUrPmesxpkEwF6z/iIrOZeteP2gMSFfmHjzK5XOz1UIb49hzi+XHkPUfFKC6?=
 =?us-ascii?Q?DsDwtG2+4tL7LWqKJHJFNBOOOT3UBg7F7mkxVF5aUWI02Jv+gy9fk5bHyfpe?=
 =?us-ascii?Q?vR7wCaRMrZ1pYOjvvPJLuEjVtMuMjV6gBOF2Fmb1yL6Zvh2nnR0QpKvmFTxX?=
 =?us-ascii?Q?UHhFF8In0F2PR6pOBinmQdMgN50xmuyUdkaAYInc/kxX3RnXD7ojQqUYcQ7q?=
 =?us-ascii?Q?O0unCVCvnzo4guLskGGB7qpiXmi2PbXnml0vuFJ387PXkqQDDt/IlVQMCcrF?=
 =?us-ascii?Q?sBOFE7Oh3oMyKnDVGoyHSqLJkx7LC6JSxkc/mzQ3lplmXJjdmc9N6fWeDvTe?=
 =?us-ascii?Q?BtxqGpa3EoMchK1JI+0wpHqC8vhLhV4phg6D8yDLbPCmuIUcpXNbyA5bOOYZ?=
 =?us-ascii?Q?IdiLBEHKD/NJZCf+zq3Z6RzKTcYFQfJxiB+ds4+pbcg83mzn1PhJhiS9hOv0?=
 =?us-ascii?Q?ZZDMmiMOdItO3eSgLr+fjglGw6t/z38jh7NAv+UK3zlcYtmfDb77jq6cx+nL?=
 =?us-ascii?Q?H9vZevgHu10bDDmnjR+SVIKA5Z7KpnA02Po/+prwIOSnJhnScDMYASOVvw0N?=
 =?us-ascii?Q?0NAl6X9gT9HY07P0gfSgf/A+OAvfiOEm7FvvZe1J2Y1HORUPA6sWcY/Rohke?=
 =?us-ascii?Q?YqIVEgxtOC8BBLwDIjzRas5LxpreCOvF74YUrRe59GaLbJWsr4hcElZat6jt?=
 =?us-ascii?Q?gevIB1QSzzpL4nI7pPoq4mXNgpBZCR3GnCwO64Y421AJs4wA10hOY1E8iJKs?=
 =?us-ascii?Q?M5jQNY3bsZy2IVd2CQGiDGSN/jSMwTKZquQ5IFBOuJpEwPOnqF/VhOUoqfo1?=
 =?us-ascii?Q?hS/oFZ8mWjvyhkkCKELlBYrvi30B7CmF3eIGqjCyraFwgZg6Ri0bHcCL+8Eb?=
 =?us-ascii?Q?1WbzSGt65aX9v/KliRrYDBlGyiWk0s2qvUv4qojOafvV+OXUaaHSNaqropcC?=
 =?us-ascii?Q?/EL+xxYo6t6avacgSIdR4uE7f+7w8sQfDROjnLqXv2/13EI6mABjj4RL+wNo?=
 =?us-ascii?Q?onWChbiM7YTE8UKyk6O2P/qd+dA+42wMhgvuxZGayEpsBmsy9IsxEpt2Yx2P?=
 =?us-ascii?Q?EjkZzIc6Cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f95d568b-70ff-469b-40b4-08de656a112f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 10:25:36.1820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jSvCFaVum3gblCyR/00BNqA3/NUyL5oucVXjTdiK6nz2Qfs4A8ZneTTDNVTRNIXPis9zdHD3/bTZGNyS4498dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5210
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

> Subject: [PATCH v3 06/36] net/intel: add common fn to calculate needed
> descriptors
>=20
> Multiple drivers used the same logic to calculate how many Tx data
> descriptors were needed. Move that calculation to common code. In the
> process of updating drivers, fix idpf driver calculation for the TSO
> case.

Should this fix be split out into a separate patch with a Fixes tag?

>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/common/tx_scalar_fns.h  | 21 +++++++++++++++++++++
>  drivers/net/intel/i40e/i40e_rxtx.c        | 18 +-----------------
>  drivers/net/intel/iavf/iavf_rxtx.c        | 17 +----------------
>  drivers/net/intel/ice/ice_rxtx.c          | 18 +-----------------
>  drivers/net/intel/idpf/idpf_common_rxtx.c | 21 +++++++++++++++++----
>  5 files changed, 41 insertions(+), 54 deletions(-)
>=20
> diff --git a/drivers/net/intel/common/tx_scalar_fns.h
> b/drivers/net/intel/common/tx_scalar_fns.h
> index c79210d084..f894cea616 100644
> --- a/drivers/net/intel/common/tx_scalar_fns.h
> +++ b/drivers/net/intel/common/tx_scalar_fns.h
> @@ -64,4 +64,25 @@ ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
>  	return 0;
>  }
>=20
> +static inline uint16_t
> +ci_div_roundup16(uint16_t x, uint16_t y)
> +{
> +	return (uint16_t)((x + y - 1) / y);
> +}
> +
> +/* Calculate the number of TX descriptors needed for each pkt */
> +static inline uint16_t
> +ci_calc_pkt_desc(const struct rte_mbuf *tx_pkt)
> +{
> +	uint16_t count =3D 0;
> +
> +	while (tx_pkt !=3D NULL) {
> +		count +=3D ci_div_roundup16(tx_pkt->data_len,
> CI_MAX_DATA_PER_TXD);
> +		tx_pkt =3D tx_pkt->next;
> +	}
> +
> +	return count;
> +}
> +
> +
>  #endif /* _COMMON_INTEL_TX_SCALAR_FNS_H_ */
> diff --git a/drivers/net/intel/i40e/i40e_rxtx.c
> b/drivers/net/intel/i40e/i40e_rxtx.c
> index f96c5c7f1e..b75306931a 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> @@ -1029,21 +1029,6 @@ i40e_set_tso_ctx(struct rte_mbuf *mbuf, union
> ci_tx_offload tx_offload)
>  	return ctx_desc;
>  }
>=20
> -/* Calculate the number of TX descriptors needed for each pkt */
> -static inline uint16_t
> -i40e_calc_pkt_desc(struct rte_mbuf *tx_pkt)
> -{
> -	struct rte_mbuf *txd =3D tx_pkt;
> -	uint16_t count =3D 0;
> -
> -	while (txd !=3D NULL) {
> -		count +=3D DIV_ROUND_UP(txd->data_len,
> CI_MAX_DATA_PER_TXD);
> -		txd =3D txd->next;
> -	}
> -
> -	return count;
> -}
> -
>  uint16_t
>  i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t
> nb_pkts)
>  {
> @@ -1106,8 +1091,7 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>  		 * per tx desc.
>  		 */
>  		if (ol_flags & RTE_MBUF_F_TX_TCP_SEG)
> -			nb_used =3D (uint16_t)(i40e_calc_pkt_desc(tx_pkt) +
> -					     nb_ctx);
> +			nb_used =3D (uint16_t)(ci_calc_pkt_desc(tx_pkt) +
> nb_ctx);
>  		else
>  			nb_used =3D (uint16_t)(tx_pkt->nb_segs + nb_ctx);
>  		tx_last =3D (uint16_t)(tx_id + nb_used - 1);
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c
> b/drivers/net/intel/iavf/iavf_rxtx.c
> index 947b6c24d2..885d9309cc 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -2666,21 +2666,6 @@ iavf_build_data_desc_cmd_offset_fields(volatile
> uint64_t *qw1,
>  		((uint64_t)l2tag1 << IAVF_TXD_DATA_QW1_L2TAG1_SHIFT));
>  }
>=20
> -/* Calculate the number of TX descriptors needed for each pkt */
> -static inline uint16_t
> -iavf_calc_pkt_desc(struct rte_mbuf *tx_pkt)
> -{
> -	struct rte_mbuf *txd =3D tx_pkt;
> -	uint16_t count =3D 0;
> -
> -	while (txd !=3D NULL) {
> -		count +=3D (txd->data_len + CI_MAX_DATA_PER_TXD - 1) /
> CI_MAX_DATA_PER_TXD;
> -		txd =3D txd->next;
> -	}
> -
> -	return count;
> -}
> -
>  static inline void
>  iavf_fill_data_desc(volatile struct ci_tx_desc *desc,
>  	uint64_t desc_template,	uint16_t buffsz,
> @@ -2766,7 +2751,7 @@ iavf_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>  		 * per tx desc.
>  		 */
>  		if (mb->ol_flags & RTE_MBUF_F_TX_TCP_SEG)
> -			nb_desc_required =3D iavf_calc_pkt_desc(mb) +
> nb_desc_ctx + nb_desc_ipsec;
> +			nb_desc_required =3D ci_calc_pkt_desc(mb) +
> nb_desc_ctx + nb_desc_ipsec;
>  		else
>  			nb_desc_required =3D nb_desc_data + nb_desc_ctx +
> nb_desc_ipsec;
>=20
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice=
_rxtx.c
> index 52bbf95967..2a53b614b2 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -3075,21 +3075,6 @@ ice_set_tso_ctx(struct rte_mbuf *mbuf, union
> ci_tx_offload tx_offload)
>  	return ctx_desc;
>  }
>=20
> -/* Calculate the number of TX descriptors needed for each pkt */
> -static inline uint16_t
> -ice_calc_pkt_desc(struct rte_mbuf *tx_pkt)
> -{
> -	struct rte_mbuf *txd =3D tx_pkt;
> -	uint16_t count =3D 0;
> -
> -	while (txd !=3D NULL) {
> -		count +=3D DIV_ROUND_UP(txd->data_len,
> CI_MAX_DATA_PER_TXD);
> -		txd =3D txd->next;
> -	}
> -
> -	return count;
> -}
> -
>  uint16_t
>  ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkt=
s)
>  {
> @@ -3152,8 +3137,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>  		 * per tx desc.
>  		 */
>  		if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG |
> RTE_MBUF_F_TX_UDP_SEG))
> -			nb_used =3D (uint16_t)(ice_calc_pkt_desc(tx_pkt) +
> -					     nb_ctx);
> +			nb_used =3D (uint16_t)(ci_calc_pkt_desc(tx_pkt) +
> nb_ctx);
>  		else
>  			nb_used =3D (uint16_t)(tx_pkt->nb_segs + nb_ctx);
>  		tx_last =3D (uint16_t)(tx_id + nb_used - 1);
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c
> b/drivers/net/intel/idpf/idpf_common_rxtx.c
> index 587871b54a..11d6848430 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
> @@ -934,7 +934,16 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct
> rte_mbuf **tx_pkts,
>  		tx_offload.tso_segsz =3D tx_pkt->tso_segsz;
>  		/* Calculate the number of context descriptors needed. */
>  		nb_ctx =3D idpf_calc_context_desc(ol_flags);
> -		nb_used =3D tx_pkt->nb_segs + nb_ctx;
> +
> +		/* Calculate the number of TX descriptors needed for
> +		 * each packet. For TSO packets, use ci_calc_pkt_desc as
> +		 * the mbuf data size might exceed max data size that hw
> allows
> +		 * per tx desc.
> +		 */
> +		if (ol_flags & RTE_MBUF_F_TX_TCP_SEG)
> +			nb_used =3D ci_calc_pkt_desc(tx_pkt) + nb_ctx;
> +		else
> +			nb_used =3D tx_pkt->nb_segs + nb_ctx;
>=20
>  		if (ol_flags & IDPF_TX_CKSUM_OFFLOAD_MASK)
>  			cmd_dtype =3D IDPF_TXD_FLEX_FLOW_CMD_CS_EN;
> @@ -1382,10 +1391,14 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue,
> struct rte_mbuf **tx_pkts,
>  		nb_ctx =3D idpf_calc_context_desc(ol_flags);
>=20
>  		/* The number of descriptors that must be allocated for
> -		 * a packet equals to the number of the segments of that
> -		 * packet plus 1 context descriptor if needed.
> +		 * a packet. For TSO packets, use ci_calc_pkt_desc as
> +		 * the mbuf data size might exceed max data size that hw
> allows
> +		 * per tx desc.
>  		 */
> -		nb_used =3D (uint16_t)(tx_pkt->nb_segs + nb_ctx);
> +		if (ol_flags & RTE_MBUF_F_TX_TCP_SEG)
> +			nb_used =3D (uint16_t)(ci_calc_pkt_desc(tx_pkt) +
> nb_ctx);
> +		else
> +			nb_used =3D (uint16_t)(tx_pkt->nb_segs + nb_ctx);
>  		tx_last =3D (uint16_t)(tx_id + nb_used - 1);
>=20
>  		/* Circular ring */
> --
> 2.51.0

