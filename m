Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AA2C369AB
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Apr 2025 06:18:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0325040156;
	Mon, 21 Apr 2025 08:18:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 0C61B40151;
 Mon, 21 Apr 2025 08:18:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745216300; x=1776752300;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wIexAO/dvlto+K7efdHqW2438eR87jFMqZvcG7pAYrY=;
 b=Wfdlzn4rzYJGa0ATlouC9SO6o7AnD6q5Y6bPODxRnFauJ7fNrcbKFyoM
 m1jaj1uQzBV00GsoZL3QaTukVO875L285pe6LwxT8kS9pWcw8PB+ZatqT
 SnnctR/jJq+pzjc5GE+06grnR9XzdO1KH8JiNQwVoEZcamE6yjqebjwZE
 C51gyIdL+HuufhIMLYTK20doXZiFHj7wdD4TViBwqFwIg2DzVE9EBm/Di
 fDlq5QoqGW5E8QoUmsxcU5lK/zhAm7gnSq9rTsBHMjcC0m0qADjj9Ql1u
 EjaugOpKAgPKwctoErA7oTxxeZwBkRmx3xq16s2za2k/AuobDJzgnZVCj w==;
X-CSE-ConnectionGUID: ecre12FQQvaxg/iCNjdwGw==
X-CSE-MsgGUID: +cou7zsGSdeGKpj10AFQLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11409"; a="46915252"
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; d="scan'208";a="46915252"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2025 23:18:18 -0700
X-CSE-ConnectionGUID: fPqZ9nmqTAWYVmTwvY8zOg==
X-CSE-MsgGUID: 5d68Eb3FT5icP0Izux3lOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; d="scan'208";a="162681317"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2025 23:18:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 20 Apr 2025 23:18:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 20 Apr 2025 23:18:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 20 Apr 2025 23:18:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umkRwzs0gCAp2MF3ATk/iRsv0DDYO1piCR4pGJXPO682DANqwBl9kfsqrfVuDLwTnMmUrhOSNoNFugFOhSPoS5vewV015FJN1Xs10wS9cRKfvFqK6wDFijIlBLhjxkIv1mftHfhynOVpNiDntcc35bHO1AZTyKxpnpU5noGltHHYm757jV2WicsB0NAgddfD7Wa2H3KaB5emb6jAd5jt9Gk2l/or1Znaxc4HhidPWcLQ6xiQk9bSemrgiTbzGgNjcIxAYxch0DsRgL9Rt+TwsuxyYz161Y2GjCfBOLGSU2aXKtFH5GsWYhy0/Uq2pRTSxMX2Lb8jKuFnvhXZ9jtXQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cbyGK961EYxxsbEolcY1tun1U5CG58NBeJm7lkZTk4=;
 b=X3ZTK55T1hjhTXUjFT6R4jwnH1yhAJ51T1W6Db4OWgAC1mW8vpZDGqnaOzRf49LQ4SUlJeCd+bIURpcahIvVmB+kKV5UmkvMV7joLWD48smtgcIH62LOV7lMz7c2WIGmAdSBH357wsHrtTCX2KSEwuw2oaKYesuuqasAZUxjHb8m9O5Bp3s/2oOldG5FedsuA+8nbEN7vvV/mEbkiVw/iymkDv9RpxSxRf82zIxN1OZTT+gSOVq+0FVk6oO5fyfnfyNohzJapGHlOe285Vmz7YnUkwOkZ+68xmDMiMNP2PXcr28SXxcyLh6kC3jSmTLfuN2odEiC5bMrbCphpluvEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5924.namprd11.prod.outlook.com (2603:10b6:806:23b::14)
 by SJ0PR11MB5868.namprd11.prod.outlook.com (2603:10b6:a03:42b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.27; Mon, 21 Apr
 2025 06:18:13 +0000
Received: from SA1PR11MB5924.namprd11.prod.outlook.com
 ([fe80::468a:436e:8691:6d66]) by SA1PR11MB5924.namprd11.prod.outlook.com
 ([fe80::468a:436e:8691:6d66%2]) with mapi id 15.20.8655.024; Mon, 21 Apr 2025
 06:18:13 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Kevin Traynor <ktraynor@redhat.com>, "stable@dpdk.org" <stable@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Abhishek Marathe
 <Abhishek.Marathe@microsoft.com>, Ali Alnubani <alialnu@nvidia.com>, "David
 Christensen" <drc@linux.vnet.ibm.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, "Stokes, Ian" <ian.stokes@intel.com>, Jerin Jacob
 <jerinj@marvell.com>, "Mcnamara, John" <john.mcnamara@intel.com>, "Ju-Hyoung
 Lee" <juhlee@microsoft.com>, Luca Boccassi <bluca@debian.org>, Pei Zhang
 <pezhang@redhat.com>, Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>, "yanghliu@redhat.com" <yanghliu@redhat.com>
Subject: RE: 24.11.2 patches review and test
Thread-Topic: 24.11.2 patches review and test
Thread-Index: AQHbn8pY7zK3+jluS0S1GAc81wQs97OtyVcg
Date: Mon, 21 Apr 2025 06:18:13 +0000
Message-ID: <SA1PR11MB5924B25AAEBE0D441AC306779FB82@SA1PR11MB5924.namprd11.prod.outlook.com>
References: <20250328101435.250876-1-ktraynor@redhat.com>
In-Reply-To: <20250328101435.250876-1-ktraynor@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB5924:EE_|SJ0PR11MB5868:EE_
x-ms-office365-filtering-correlation-id: 74f73b40-4caf-4d00-ad88-08dd809c4c05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?aSslYB3Uo9V7cmybkfuUyJyrraI8h8keaikuWjlVapSWQAA4nw3zTfeZV+r7?=
 =?us-ascii?Q?p/0WJrfwP3kw8XbqT/os7i16F8Xwr+zTsl9scan1mxjMURtwRGczNMqo0E97?=
 =?us-ascii?Q?ZrrewfszD7hlA7+OdKSimP9Hz638IKD58+vcDa86jv+Wpd1sUjZQH5za7kqO?=
 =?us-ascii?Q?drfdTAdNdFMtfDSuler6dR3pwSrEam3FRLtnB8VjsGiQ05VIMDrRNmKlLx+2?=
 =?us-ascii?Q?SKEpI6YJPMkGRg/FhzTAsC9br2FLs0Nb8ISLiP+pS3ojHDEAlsmZwQq67vKz?=
 =?us-ascii?Q?PC9QeLjRXP/ahFkkp2N2I6CaTLi8Ifr2CXUFkAoKdQlPOkonw5WUrsgOz7Pw?=
 =?us-ascii?Q?YQeR59v18WYH4abMZszC4E+Yn7mkUSV+443iqtEzvY4Eq9hdn9seHJqBHmqe?=
 =?us-ascii?Q?PX1nJ+do3FrgZBa/cBw9TLKCB0xFxkxhmmx4eJDsa84aUdfjPzVewR4t1A5x?=
 =?us-ascii?Q?n+nHhI2LKfCwnuOy8+nuSnc1Ne+/R+DmmB8uQnEAK3aiTDLb0Z5l7snrLR8V?=
 =?us-ascii?Q?WPp+W+nWF4p//Q9V2/t9r7bhlXG1JIE+ikrBxUnlfIdGu8obp+7xbvzHF7NA?=
 =?us-ascii?Q?R8IJAffkf4gpYMH0YIdrElfHk+wVfqgoYf800xbofhdyPGNi2Ao6xiHl5IRx?=
 =?us-ascii?Q?zwCKyuTL73JpFFJD9wFC08et73V64iscg7JcERyoDN2zhsPXojzBQxTmkNMQ?=
 =?us-ascii?Q?BwwBIcwMSSIhfXyi2Cs8QTD3ngL+YPZ1eeSAjs6Ohrbdz7L5mReNXQ6PlWIq?=
 =?us-ascii?Q?1ceQ9nhBBQ+eshsS99F4mE8bnDAV6Zn3BlOfO9HkxRcF9vMNswx1LM/JKkoc?=
 =?us-ascii?Q?iBdiPTIXUQCreLQeZDzl+tWgiLjQnQm1AJZi9LdGUPGrLaV/2HbW8r0WmWcS?=
 =?us-ascii?Q?zfT9tWkuLUD0jw4e3eSwGniPum4ltrZwXn+nN4Af5ANDlIrliyARmRAAFq4H?=
 =?us-ascii?Q?dK3raji+25fO9O8bCZi0ItwIQW2luGAwFrCdrVUTFvruviefpzsLZ+R8yIPe?=
 =?us-ascii?Q?UcbZKUNs3hLHKl9KoZaN3fgaXPT8dZGFTddhrRmlg2XHlwHpnyKtJAE5oO8U?=
 =?us-ascii?Q?bQ5ypmuIUtnjFV5sPy1nPP+nPLqBzmbV5s7WWY7ti40tBEcA3DS6O7YRF0Ne?=
 =?us-ascii?Q?KPvTPX4rPxeooZQMTIFQcv4c5XLeqX22K/ef4Ht8IbIWdT2tlYIoRRyGtdPu?=
 =?us-ascii?Q?dJ5h7TCVSQEAvcx0MhnqhnV5WhoaveNJOhc2Bcvi2zIhmF/oLnpf2Tcyw7/Q?=
 =?us-ascii?Q?qiToS1jHF1U3nZhUukHmc0JzLEtpchesB80aJmd0eJplgFpdQtcuP5AALuXt?=
 =?us-ascii?Q?fIKdPV0YfqwDN2rWbFN502PkLy9sCYMOkSgTGh8Lkc3/wEj8J/OMZeA+fNS+?=
 =?us-ascii?Q?A4OshAQn9uhm+Bmscf2QPLnp2B3MNaieFn0QnqBTldYEE44eUfa25dU7tz71?=
 =?us-ascii?Q?1z84EtSvzwRi1MaUK4TBJWsoYpR33RS+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB5924.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7RiCxkBRQKioPVX2SsKc0ox6oJxP7km19t24oVcy14vUusz8oCxlZwU4WQFS?=
 =?us-ascii?Q?3LMb2aXyGbqaVZDuqhxw5DSyTU0Puw2Fz0KdtbDslgMpFBMiwEF1Sz8DBI6i?=
 =?us-ascii?Q?vvTKkZkQt4Vi4iK/+yKHxBf/IP5BS+U24we4oBpaE3yGjjConz8Wlp/3ArcX?=
 =?us-ascii?Q?GYHbECTh3NlIFUJ/RL4q335WWO/r4ue/DMJPkwIZ/Ak7Qt6vKMVJt/+cRG1v?=
 =?us-ascii?Q?0/+/KLj44jnm9az0zXYO1EPTXQ/Q37JzbqoKDsxePkRofxs2VyRNwl+qfSPd?=
 =?us-ascii?Q?Lm8hfHZ+ZWRfMlKix6MiTg2WcwELz33lTa+MtBX82M+pl+yscvD1sg5VM55z?=
 =?us-ascii?Q?cMKvSHgvpxHx615dsUlGCDqX1ta+5UWFKKBY6jSPc2S23NUZuJBa13Lm1ye6?=
 =?us-ascii?Q?ulU07rwqzrJRBceYbLZfnv8ZAwmGkXwrf1ic9NXNmEkEyVG3xOdVzbfLEBip?=
 =?us-ascii?Q?vy3e0BYhBGBTYi2Wo5ABxkQP5m18WWkMK2Iu+CPQh3PofvXZEBsilIqyCd7L?=
 =?us-ascii?Q?rybyz1ZNVh32wAiW4WBCgrDYO7xM2XjiYw1Fo9LITt4H8wicedd2OhO4DC5N?=
 =?us-ascii?Q?ud6V/+ZfI3D0Pb21QWO3xnZ/54OCKlSYPEfx3ttQZ4YxvgboFoMIF3luC6Ec?=
 =?us-ascii?Q?nguV542cjEIlpoKfRjafOZ+d+cXcYTbiELdO06iDDG5xYMi1U2CcEKox0PcA?=
 =?us-ascii?Q?53aXsQCySPuddQqFo53DIfgfU5R6BXnKODqYU1blvQkoSG2vgNoAiyztPcJ9?=
 =?us-ascii?Q?ChVpVCw/jntfrE9BAvToIzDYFfJjPz2MwXR2u/soPN4L3mI6eYzw+NnOLJDf?=
 =?us-ascii?Q?eQ+NIMccZSBOKDkKpRw3akDbj1EA6KiNzrxwVUjiEmvloY78iUMSWIXZUfUh?=
 =?us-ascii?Q?HjAnlAJBGS4aiAjfr/YThbIZFU7Eqe5gMF1Ym1tdBSFPToWR6FpVrNh2fRpJ?=
 =?us-ascii?Q?DvXmV9e1EjrxVTzDtjSH3Xuro335o2dkreCzFVnzMxdRIn0EVxrbM3EVqDXa?=
 =?us-ascii?Q?KaCCSjgENeypX5zIqq8CAzrIgXuGP+dExe24/1I37rkLz+d9g5GNmKInvsXF?=
 =?us-ascii?Q?o0NJSILBwEbA57ISVC+wfW6InNi3fi45CwSjsRFe90rgw6AQt4NSQk2jOPdu?=
 =?us-ascii?Q?AwpTiuUmP+2ggVMhdjCF/UkDagNyhxd4/3jN/nLKOl0Y/NLc5t38D5DyQaYN?=
 =?us-ascii?Q?uil/3lzikolG6Y9KJEIh71YndvckP4C/6Ghnt6XqWKAYv1ftoT7maRCMKH04?=
 =?us-ascii?Q?ohOjhxnB6Z6K3MWIeQYULpxNzbbyauQv+epbC8tiClbyLsowHA5Wfuq4fZBd?=
 =?us-ascii?Q?5eVKKnRFCwtU2zkUmhh2HSAc5akAjGfvmWegVf8fJGDy1hQ2Vh7gqDHRAiAx?=
 =?us-ascii?Q?EfydiFpa9PjFTLl0lUc5C9J9mhkbroxKBIjjqhNZYrrypRvbQII7CktyFUP6?=
 =?us-ascii?Q?iAd7Imtluy460ZXOHcBwkz2AgOQHYaKKUuYH+2JvGMpGYDsDglkcsPFXSWe9?=
 =?us-ascii?Q?OfeNpRFxWyopgU/5KKhCPZMPL3TB/Q6uTCm0c4aBZzo7FShUlFgdZXQmxN2e?=
 =?us-ascii?Q?+f6NenxYPVFtGdeuznAndK9uf+4M1JYd6XoBr+Xs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f73b40-4caf-4d00-ad88-08dd809c4c05
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 06:18:13.4896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J/4GGSqwSxsT8l2DIXrpFGk6vVTuVO07Vec7r6pcoQTY7H0K86IMpmiyZJT6ZDJORzSXA3F1pytpFn1tDPh51Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5868
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

> -----Original Message-----
> From: Kevin Traynor <ktraynor@redhat.com>
> Sent: Friday, March 28, 2025 6:15 PM
> To: stable@dpdk.org
> Cc: dev@dpdk.org; Abhishek Marathe <Abhishek.Marathe@microsoft.com>;
> Ali Alnubani <alialnu@nvidia.com>; David Christensen
> <drc@linux.vnet.ibm.com>; Hemant Agrawal <hemant.agrawal@nxp.com>;
> Stokes, Ian <ian.stokes@intel.com>; Jerin Jacob <jerinj@marvell.com>;
> Mcnamara, John <john.mcnamara@intel.com>; Ju-Hyoung Lee
> <juhlee@microsoft.com>; Kevin Traynor <ktraynor@redhat.com>; Luca
> Boccassi <bluca@debian.org>; Pei Zhang <pezhang@redhat.com>; Raslan
> Darawsheh <rasland@nvidia.com>; Thomas Monjalon
> <thomas@monjalon.net>; yanghliu@redhat.com
> Subject: 24.11.2 patches review and test
>=20
> Hi all,
>=20
> Here is a list of patches targeted for stable release 24.11.2.
>=20
> The planned date for the final release is 14 April.
>=20
> Please help with testing and validation of your use cases and report any
> issues/results with reply-all to this mail. For the final release the fix=
es and
> reported validations will be added to the release notes.
>=20
> A release candidate tarball can be found at:
>=20
>     https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv24.11.2-rc1
>=20
> These patches are located at branch 24.11 of dpdk-stable repo:
>     https://dpdk.org/browse/dpdk-stable/
>=20
> Thanks.
>=20
> Kevin
>=20
> ---
Update the test status for Intel part. dpdk24.11.2-rc1 all validation test =
done. no new issue is found.

known issues: fix patch has been merged into main, but they not merged 24.1=
1 LTS, so this issue still exists in 24.11.2-rc1
  1. Bug 1606 - flow_filtering/flow_filtering_mismatch_rule: Some mismatch =
rule packets match the rule.
     - has fix patch: https://patches.dpdk.org/project/dpdk/patch/202501120=
75200.5020-1-shperetz@nvidia.com/
  2. Linkville vfs can't forward packets
     - has fix patches: https://patches.dpdk.org/project/dpdk/list/?series=
=3D34939&archive=3Dboth&state=3D*

* Build & CFLAG compile: cover the build test with latest GCC/Clang version=
 on the following OS(all passed)
  - Ubuntu24.10/Ubuntu24.04.1
  - RHEL9.4/RHEL9.5/RHEL10 beta
  - Fedora41
  - FreeBSD14.2
  - SUSE15.6
  - OpenAnolis8.9
  - AzureLinux3.0

* Function tests: All test done and there are two known issues.
  - i40E-(XXV710, X722) PF/VF: test scenarios including basic/RTE_FLOW/TSO/=
Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.=20
  - IXGBE-(82599, E610) PF/VF: test scenarios including basic/RTE_FLOW/TSO/=
Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.=20
  - ICE-(E810, E830, E2100) PF/VF: test scenarios including basic/Switch/Pa=
ckage Management/Flow Director/Advanced Tx/Advanced RSS/ACL/DCF/Flexible De=
scriptor, etc.
  - IPsec: test scenarios including ipsec/ipsec-gw/ipsec library basic test=
 - QAT&SW/FIB library, etc.
  - Virtio: both function and performance test are covered. Such as PVP/Vir=
tio_loopback/virtio-user loopback/virtio-net VM2VM perf testing/VMAWARE ESX=
I 8.0, etc.
  - Cryptodev: test scenarios including Cryptodev API testing/CompressDev I=
SA-L/QAT/ZLIB PMD Testing/FIPS, etc.
  - DLB: test scenarios including DLB2.0 and DLB2.5
  - Other: test scenarios including AF_XDP, Power, CBDMA, DSA

* Performance test: All test done and passed
  - Thoughput Performance
  - Cryptodev Latency
  - PF/VF NIC single core
  - XXV710/E810 NIC Performance


Regards,
Xu, Hailin
