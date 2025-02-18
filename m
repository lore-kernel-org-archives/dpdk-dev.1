Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F967C021AD
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 11:04:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 859FC402C4;
	Tue, 18 Feb 2025 12:04:28 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
 by mails.dpdk.org (Postfix) with ESMTP id AF071402A0;
 Tue, 18 Feb 2025 12:04:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5ct1IAtSOEJdhhr/BO6w2KMkK3zA/EsJ9F4Yi5vKzVStuOEw0l/2a6gscQNrpfk5yCQD+BecbZJedMwFNl5XVPCMZqKWh34A8LRJ3OmBsn6C6jN6dTZlVCy+t7Mthc5c0bTzAxEGLYAvpuYcNn3yZ+ELQQtTs0GC99VmiMIYhnGYoaKahJ/vQVB/gqnLzfDfFPClXr0cBLwROSPNin9aveIgPaXtCLGf2H5d8pcUY3GTXw6amotF1uukiQwAiwRbC7F3F1AWNIlVCc1XUELRCdim3YtO6QI6E+NvLtLdGImzFCLGOXwJz+KjxqYS860bW2PxwDc6ZWNVL1mHVFmHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rn4kNJLSzRaPt4356MFhsWxO4h8D1C+VQ08+8lGFK/8=;
 b=YuR9EhiTceN2yOX2W/W18yOaCNiL8rzrXfgCPtFxynYMj8i2mteX6bheyeeQ++OqUHoMg89GwnLZRzKyxwirMzv3V6+O8FLo/1sa3FDwc7c5Tsd9pbVMWBdwgphcGQ/pwPU/w2DtniNOryoSJP6GsaaHn/aC7Ox6PWRc7rrsBGHWqdXhjz6B3X1m9JhkoNOcfG+Mpht+SGAtCcwMYCpgpfIo6RC++XLO3tDeWB5eZyqT3/Ifo1ps+Jz0qnY/YGx95K8Ncby8Pmutdwhlskpqa7J3/EWSMB1rDCk8fKEtBILyDQHXhMCGGqIfmVTB1luREt7nW9k0yKhVo5ga/jHr6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rn4kNJLSzRaPt4356MFhsWxO4h8D1C+VQ08+8lGFK/8=;
 b=jljIrpN8oEDTjha/+urk+TIUFI/PruEpcj0mkBh68Th2W9RAgXOKgkPJSpsN8z/y8jcT8HVE8TGGTEwJW8Yqgvb84e+h7D2xmYOL/DpdpioiTSdci5/IR3gyRCJXhrU1C73yYu01bwdEflA2lqBriiwvnQPCPStSzHBDR8RHJBlqR+Lyq90/ILv56OyIsiTU21kW8ytiB3SRnCdxGynDlXs8bNND+n8CqapnwAK2Ra/Y4B8feTDPXhkIxED2T4MBjeIkHf7f25dxAnZgljBFJAFOA9fAKmwEDireOkXsEcscCibWsXPULAFycKe947ChanAnty1BcNsVq8FXsQZGMw==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by DS7PR12MB6120.namprd12.prod.outlook.com (2603:10b6:8:98::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.16; Tue, 18 Feb 2025 11:04:24 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 11:04:24 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Kevin Traynor <ktraynor@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Maayan Kashani <mkashani@nvidia.com>, Raslan Darawsheh
 <rasland@nvidia.com>, Ori Kam <orika@nvidia.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH] net/mlx5: fix flow null ops seg fault
Thread-Topic: [PATCH] net/mlx5: fix flow null ops seg fault
Thread-Index: AQHbfsgMK5GVyqgiM0CjEbuiB01joLNM6neQ
Date: Tue, 18 Feb 2025 11:04:24 +0000
Message-ID: <CH3PR12MB84601412137591E85FC64022A4FA2@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250214100545.413991-1-ktraynor@redhat.com>
In-Reply-To: <20250214100545.413991-1-ktraynor@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|DS7PR12MB6120:EE_
x-ms-office365-filtering-correlation-id: d0534b09-cd17-452f-e8aa-08dd500c00e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hJIVxgYvN4frKZh3sdxdyjmTW3fKAjDgYfBlpGyT8sArobiSoqmehuLBaVUH?=
 =?us-ascii?Q?7SZF292OyCfLHxkZ32iDCsYwZi0sXIn0x8QD60+WwDTAoK8AtFdJ7/5dzVXl?=
 =?us-ascii?Q?RFcwXfZLrHSJSaTeAHKG3wEOKbQgX6gwUIt0sSmDGAo8QKvZqROlO7GZP9Tw?=
 =?us-ascii?Q?ofzh3no0YkGjoP1MmMu99P5jEYAusmdbR4vBDuGBybtAOeYABp3Pvv2Md6Ge?=
 =?us-ascii?Q?bjPLamTRVi6U+1HxNiET0uNNM7zx80IPGqq5FXhriP4MNIJ7Lm+BnVDQ0tI9?=
 =?us-ascii?Q?BxJpsy0sVk8dV/lUdoBdabgEe8b6ufpujNaMIE4KRZFGeXJcVQpOdwWdoGqE?=
 =?us-ascii?Q?/PmuGGvayCbtssTLak7FU1Yu1uoBt7JvXinjL1q8bACLJq3ZJvYIVKpyMISQ?=
 =?us-ascii?Q?+r+QEjMCkJ7/x0Ku5tlOv7/weLtw8z18sygO37WUzHiyntcmlEZICKGVg33d?=
 =?us-ascii?Q?9ef+xYoRSMJ6rP/TPpW5JnsL3fhqJbpUp0QLi37MoSSOTpXO4PBJd25QuzdO?=
 =?us-ascii?Q?zXO/wciSwIG6W33jdiOjXqVVOfusVaIsDnpXIGwVLcKNs9q0vdjYlcHJMhDy?=
 =?us-ascii?Q?ILL7KF17/0j5/ddSVzJPvdBjW9HaCgbGm0yNU5K+rliJns4KBP3PcMEowTTD?=
 =?us-ascii?Q?Ev1tFs+r6FQDvGPxPWNQk74JE5pLvN5ylymDG6ysWTQxmhuSsRXycsskAK+T?=
 =?us-ascii?Q?LazgRdArLYbZfYfzZ5iSzXC9lBXcE4Kzf/qf6o7/YTNsFsDLk3Who5EeEFB8?=
 =?us-ascii?Q?B8XcRGZCKAb2gQ+Vs99jvYvB4Ir/ur6PXGNyfll7zOFXPBDAmavfpPCIOIdU?=
 =?us-ascii?Q?T9oycuC3IrNwP7vY7C/EoGo6VJ26jVCikkON53jJNxojyP+PaHi9HsOcCwT1?=
 =?us-ascii?Q?gcSOLeWp2M6TrApuSmksG9xedY+YfxvZtEn5+jYt0SEkKezDkHSpjGRY3yAm?=
 =?us-ascii?Q?2j8yfnp2l2hsYUVEEFxf1gXD6UizlaJ/7ZpppqG37SlGAfa8uU9t8eLv4Qsv?=
 =?us-ascii?Q?nCKjIm7WkQ96BtrdJX5OjUSMEucvFjoAUnmqjo7y/5zsy3daYr+OtP4MJLZo?=
 =?us-ascii?Q?eGvsFfmIuCq0cyLiRYKTcTU0agtmEnaVNwsMUXpM5oRrxLvhtOmmfj//WLh4?=
 =?us-ascii?Q?NRZPkiKDIys4lMjHLWOx1xYOibwWEwOdBiI2HxdU5HgzeDOw6U7mv/TPYXZk?=
 =?us-ascii?Q?3pkGuTQv2uAKuRYR1SKMdNMj94RGK1GRTVKJurlnCUssfeju2Fp+lgltI8f/?=
 =?us-ascii?Q?IGtB4cVfOl+iDEbD2R/0zz/OWyeeDPV4WTx00NKXMymBCaF1x7/EUNXBgmil?=
 =?us-ascii?Q?XXmQnKw1iXBnt7nCdMlOxptlOMw1yacZX5Be5TH1dkAiWK5hPUTcgcXvCkar?=
 =?us-ascii?Q?35nWBDTGBAieuq8Oc1vOXQuJF1PHa+Vgi42ZssKB6npYG7NnsavyWStpnOdD?=
 =?us-ascii?Q?w3AyqFOCCE5dd5Y+oixKPU1Ct5I5p3ud?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GZQGZTM6BzfrkY8UkNobedCTpuEnluTngJ0ONBTW6Zd1pDQhd3YQfQE0OAyF?=
 =?us-ascii?Q?bSqFanMojRfeNEW70wmrwDU5hh1OjSrYeICF7iqPaJcYTy1JUKMfy2mew9Ub?=
 =?us-ascii?Q?udEmKcykuV0FhF5Tev40eV3iIVnvRRXAkehTTtzcmCX9MGmWtEx4itJw+QKx?=
 =?us-ascii?Q?1mZLc8UqHOsgEaC3+7HPxpgS2QZ2x/S/2eWtswHwXRLr4zllF51V3JEt3Ane?=
 =?us-ascii?Q?Q24yQySCXhNvqFAdbu6cjb6VfVQ/ZZI9XXZKDrTjKmG5AdIPq2bYh0MJ4Urj?=
 =?us-ascii?Q?FBXl6Who6/l0XkSa3/95HkMjQICWe6gWAWmlECBL/E23xqJeLZ0BkHQmRui6?=
 =?us-ascii?Q?tyDgwSlBRosvy2OWsNR9p+O7gXCBobAaLunDb/cISEuv/tR5uIsM8S6HNiXM?=
 =?us-ascii?Q?6YGDfR7qzweNvYBTOnjJ9GAM+V1aQvehtWiABBGCP8qEzsuOml+9ShgWEvLl?=
 =?us-ascii?Q?xhtePo506HhGtd/I78JfjFXoQm8H/M5MK0pD8xNHuyXtC8X2XW5dHbr+moVy?=
 =?us-ascii?Q?tbryzMsZJRpcVvji2PjswZhYEryHYabktGGIYjHJFCmQjJDiuyyS+VQZuEOG?=
 =?us-ascii?Q?MsDDAdIiDAKJv6APCVaybxb0BJR3WHAgX4Scladyrmuqse13Vm2n7gYCm/pA?=
 =?us-ascii?Q?ZQx+RH4GpuVL/leDUaCjKAAWK0CDl39L0ozXzLxdHQtGenbotGsvwibWtE7T?=
 =?us-ascii?Q?2Hwe0YG8YAU2lI+tCNTz+gI+fjE8ofDm8wllq9ZtZljeYJ5J/gl1e1zRn8AW?=
 =?us-ascii?Q?bLmWk7j6vl3ALgqGgE8AP2wlkX+3OuWK7OLbm4gQ+1BPyIBsVadKKVNVKnJe?=
 =?us-ascii?Q?5EHlLkWk8p4r8D+EGdjiLauoeYMHFq8q8VkI/WfEyEi5ak9obgqV83h8N79s?=
 =?us-ascii?Q?s14v6GC8qkKX46qgMTHNbFWuCxkNXzdVMmjVtzR+QkJw1P0IFYvH0Lt7wWVY?=
 =?us-ascii?Q?hfRcr4AK0qH25PH9zEZhL4ITbas2BbCQrZEM/kJfqC+ZOu4aFdQ+SsS5sglc?=
 =?us-ascii?Q?SQ4s9E6sxROk5J0qC7VmDJxCVIY7QM1mzDOKpPJbQGLpTEAKf1c17CaO35lP?=
 =?us-ascii?Q?zDTRhqK4teRycTpHhDT9rn8rXjbuhySvTpf9qEWzAh7+qXqIwIFXcEi4ApzB?=
 =?us-ascii?Q?Wij+DsuyjfQEI1gIPWDIIU9S5eL8rcKzfIyjqW+gpX1HyGyRjNtoVqaWva97?=
 =?us-ascii?Q?XDrznPutiOdvi5me4HFImoHuEI4R93/NVgAE4AUxSTfN0eiYcAV9E33S3G1U?=
 =?us-ascii?Q?dYXN1u/xMotDZS32rzevbmiSY9A6p6c5BSzaLA0HUgePV45Cb5njZRayCO6z?=
 =?us-ascii?Q?p6JBR+qFtg3Rt7qmAPYgDjoZT41MGHdeF1pEyymoS4bWXyB7uoUI+bdOQmu0?=
 =?us-ascii?Q?S0t79RoEf7XpfvQeWLWDoncTjs574gMu5fQDxsl1kl/YMyfAu2LsIKi+51/Q?=
 =?us-ascii?Q?NlMVgk0ruARd8Ku67hDmhKcc2Rcg5LY8+orIOBjEeN2QDd0QpC9mwwaDN4c/?=
 =?us-ascii?Q?dn2yKIFEAzkXR6QPCePiGq92jpk2sJixMsPrU2Yr8NfVK840lVS1QtahxX5K?=
 =?us-ascii?Q?jaaoM0d0U0wOoAC5TpLFj4Fo4ztY+pywGd33txxn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0534b09-cd17-452f-e8aa-08dd500c00e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 11:04:24.0931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Ggb/j0lgu0CFMt8+xyk9k2LsoaARjc0kcl0x1gLDpE+kHfMYv4suff98gINiEIJckMj1X/gErwWnWQNq7jHfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6120
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



> -----Original Message-----
> From: Kevin Traynor <ktraynor@redhat.com>
> Sent: Friday, February 14, 2025 11:06
> To: dev@dpdk.org
> Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>; Maayan Kashani
> <mkashani@nvidia.com>; Raslan Darawsheh <rasland@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Kevin Traynor <ktraynor@redhat.com>; stable@dpdk.org
> Subject: [PATCH] net/mlx5: fix flow null ops seg fault
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> flow null driver ops may get selected and try to call .list_create causin=
g a seg fault.
>=20
> Full details and back traces in bugzilla.
>=20
> Add a null ops implementation for .list_create.
>=20
> Bugzilla ID: 1661
> Fixes: e38776c36c8a ("net/mlx5: introduce HWS for non-template flow API")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>

For segfault fix:

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Regarding why null ops where selected here, let's continue on Bugzilla.

Best regards,
Dariusz Sosnowski
