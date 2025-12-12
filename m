Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3940D4336E
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 06:53:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B730240661;
	Fri, 12 Dec 2025 07:53:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0366A400D6;
 Fri, 12 Dec 2025 07:53:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765522396; x=1797058396;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7/LmtzxcO/Jw4nnwxWQ2elTfIunYT3u0Ah3KtMW+JjI=;
 b=dW3wct4Wy+zMiUT8jVDyeE6iEcqhXAE9iAZZtgUv10t0vQVMioxXK2zC
 rALXRTCPqiixEVWTGgDhaDgjTuA26cv49cqyKon+Vi9qd6FlSnXYaCs1x
 ptHhXjnwvwXeMWiyUTJJd7GKzsy2ggXbuNxsIhOm1/tjNyd6M3yJzn4ce
 HWdlb7VJffeu1f96Aj4xtuMvCSy4ebFnizawNOZbE+xv18k+yMhBUHs0H
 5ZJbcq0tZ/ok4THaZKLRR0lHfZrRwt/c0LeNOXrA6YmqX3MlaYnqjaLJI
 CZgdqtWtnwqY14Sje06c5KLb04OSCaTNihKhFW+iMHumymJHGlp5nkYjV w==;
X-CSE-ConnectionGUID: R8g51R20TB++BL9WoA6kvg==
X-CSE-MsgGUID: 1G19lgmFRSGcVu/vGeQXsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="78134430"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="78134430"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 22:53:15 -0800
X-CSE-ConnectionGUID: /Yw7OnZ+TXKL68qzFo9Cpg==
X-CSE-MsgGUID: Tc3KDLAVS/uP7OuDLnV6LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="197060799"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 22:53:15 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 22:53:14 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 22:53:14 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.60) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 22:53:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehvYiMEX9OMwheR79/lYNTKWL+w/udrZnwsrgUO/NdLWpXcK1wPqN656e3a3g4RVf8ICagZv2M5lX9DS7DfQIzj2k8g/yBRnsQNTaZcf4MQEQmuju8jPLG1sUFmMGpFpk1yTtxmEA2VNw+ci7oFAD1+qeXp4IWTwXJAlsJYeNEl+Uwoiqz/YUiziBFIDSdcFmiSHYgBgEtSqXIUaBPQonAvMNNtU4pRcLNabOSf1xmjXRxbdiaCuUtRrqe1gk0QYzMHS5Ac90cUo1sdpIJxj6wGJl4+VDBZ6olWW8LAJiAFhZ+1exOZA9HdH8JMMUyZic97Zc3TBoNnUb8Oei+G54A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtgrHs6pIc0VA7RrhuLNTun4DUJIpRxZd2bOP8KAQD0=;
 b=KYFsRtNc3y0aJHsEX6QcPArpIHlA5VKw+xPHr6hIBJ62FYOdQQuyZUNYV5FQrAu4hUp+e1/Y8PaV+J3EuzHuYkOIKbxkvlgSAZppSapyEyXUlmN1xwX1yk+Mi5ca4mVl18CWP3zpZqpKPQGLbPDLsKK/wGsc7CP2KBao1EItGSvbEcYdnfH6us013CLJ83H7iDKgOn4/K0437LeunQwCxcHxDUT7FTA62N0H1lEjnivtzTPPWvd8dqSIiNlum4xNBbItEBqTc20sdyxBbWvi5B5Zn7nz3ytMhmnTD51QlCoYBGDd7p0pP3jK2eO5OkV4VBY0HG8TeUQCCdkseqosPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF653E4B531.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::74) by IA1PR11MB7944.namprd11.prod.outlook.com
 (2603:10b6:208:3d8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 06:53:06 +0000
Received: from DS4PPF653E4B531.namprd11.prod.outlook.com
 ([fe80::4d34:9ad2:aef2:7115]) by DS4PPF653E4B531.namprd11.prod.outlook.com
 ([fe80::4d34:9ad2:aef2:7115%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 06:53:06 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: "luca.boccassi@gmail.com" <luca.boccassi@gmail.com>, "stable@dpdk.org"
 <stable@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Abhishek Marathe
 <Abhishek.Marathe@microsoft.com>, Ali Alnubani <alialnu@nvidia.com>, "David
 Christensen" <drc@linux.vnet.ibm.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>, Jerin Jacob
 <jerinj@marvell.com>, "Mcnamara, John" <john.mcnamara@intel.com>, "Ju-Hyoung
 Lee" <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>, "Luca
 Boccassi" <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>, "Raslan
 Darawsheh" <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 Yanghang Liu <yanghliu@redhat.com>
Subject: RE: 22.11.11 patches review and test
Thread-Topic: 22.11.11 patches review and test
Thread-Index: AQHcZLjYEMyDH+f3gU67mGzSkRGRM7UdnOpA
Date: Fri, 12 Dec 2025 06:53:06 +0000
Message-ID: <DS4PPF653E4B5310732D910B6E58C05AD8F9FAEA@DS4PPF653E4B531.namprd11.prod.outlook.com>
References: <20251204005603.3236032-1-luca.boccassi@gmail.com>
In-Reply-To: <20251204005603.3236032-1-luca.boccassi@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF653E4B531:EE_|IA1PR11MB7944:EE_
x-ms-office365-filtering-correlation-id: c1fa2f04-bae2-49e6-5dc3-08de394b1a88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?QuzuWvVxNDXllyXHUYTalP7UpgzuXw1Y8Hv7GxA3eqEPjudNHHzz5mG5Wego?=
 =?us-ascii?Q?u2jgHWQRcC9o4tPaHsyr0WiorIPxTh7Ne8oNl9SRZ2RNnVFa5ZlO7sia/AdG?=
 =?us-ascii?Q?kpq/Bc9TZpdQsTjjuZw5KoyvrvTM1uiY2ooK+480Z4lpUoQKYGbtM8Pac32d?=
 =?us-ascii?Q?ipOivUtBt65kqUeg50wOa2iYuaJ2CNxj2QglyUFc39qT6/H6nMTr+Y6cYjEe?=
 =?us-ascii?Q?qCcoV2XYsPvJhFzSBGatAjN5eh6UhL5AZpD7WpAcqNDFDuORxISWyVcmlmo/?=
 =?us-ascii?Q?x0Kp3H1/7CUfwkeX1FFIJcnsscAkPtpfwXffC5ywGOqq431TPYW7Awy1H2ar?=
 =?us-ascii?Q?9I6OVhrSovrSBVtTdIyCvHMXyfoxUa/GHB8FF5O2hWg/MlUDy+aqQdv6ctqm?=
 =?us-ascii?Q?f+n0XhJfmrE8ILMZAXTIIJjeZWxiBTI+pDV5+Us+OdrWI9b0GnaAk6N4MNvs?=
 =?us-ascii?Q?vQl+stwfcvxsNOCyZZ7Q2+pb2OPIhrXYEMq0XxAyUyV8Wukp1Pbpba7CW02A?=
 =?us-ascii?Q?CdId30iDFRaH52jb0esUPgMUS2O1EB+55W6ZjETGGBvo74VnIW0IrBUELub/?=
 =?us-ascii?Q?Y8wxzhGf6xDHHBhBZK3CBAqZFUO51a+duzc4SyGOBib14ZCbCpZnrEf504q2?=
 =?us-ascii?Q?RVdDwpQkrgoTIFeCoiot34WO/05pC7goHOU26eVCmzjL8xlla42n8/sYnGR1?=
 =?us-ascii?Q?JgOcsFTpyeAsAIOa0MeWglmA19fUuzZvAOc+rPp+985QNHEKIDR2RHAQTT1L?=
 =?us-ascii?Q?mq0D4pG1tndiLqnODd6WBwR+hWl18d8uJcyDBqC5xHu0OBXGJ7p2BAWFJz6b?=
 =?us-ascii?Q?guCBl4e68ICORVcUOQyM5gXlsPbMCn+y1xjH9BfQkJuUr+RzLKNWPMpSTZe+?=
 =?us-ascii?Q?f4tpwobEAHb7FW0h9UyV8yD905Q1SBT0p8f2+exYsJj7Uz0Vvsbqpge3Ucpo?=
 =?us-ascii?Q?eK13MlA5pgmISn1Tu7qc8dB2PxaLLOe/ttUQOTTpRGsapWaq7SVrxJpWOQ8X?=
 =?us-ascii?Q?RehkiURpVmjYx9VyiyzNg3MRDlskshuCc0Q7WH/JBF5RdNqwnluZPAfpkdq4?=
 =?us-ascii?Q?ZvO54h+HUeh6h+T3ZdKrfFzDloUqDLU0LOFsDUCHC1BG4qN/QOn0Io8FY2ju?=
 =?us-ascii?Q?v+HMrX6T1DeQRd9CuyxwvdF92HU8DxwkfiaeVMucBzZshpOCbWR0dXWsT07n?=
 =?us-ascii?Q?V4OiXrGCScapxOWmNAl8JYuSWxgt5Aa9HmXinRoWoo8tsqpi/CMkb+8oGbpP?=
 =?us-ascii?Q?cALwI0NcbPbw0d3UUz26vUpB6yCP4Z/4TxyzPqrOT+j3kHCL7n4vOVRTmbxI?=
 =?us-ascii?Q?tP02G96E5My5hLSxFUyMZjSEgYqCd133MsUVmWtGEuC8cpzdGzmz/46CF72v?=
 =?us-ascii?Q?i8Hin9UHkvzqiTfun6qnsi2pFwOkRE5LIL/bY5Zdz+1wKgXzyODgWyT6ijo0?=
 =?us-ascii?Q?bzqmBETfQFVh2YbscqW38rMMPE5g/GcXVy6NRoVNvpAHlilsnCA5UZLRPEvJ?=
 =?us-ascii?Q?HKNqUMg4Bg4tbFCXyRzfs9Q6OSsP3Icy2SxHo8brwa4CqNOxb/sgU81Ceg?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF653E4B531.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?soYYCdluGN1eG+2DA9Wp0X0a6M6lLRNWuwmoROqMFfCMrYbSErmw8gSiZa/P?=
 =?us-ascii?Q?3uEdutpFUWFFwmV46ONXTVOxRVUcZse5FRdfEgQR14/wmD+U3ljoEgycE0+u?=
 =?us-ascii?Q?x7f1LVLV90sQ+GDALDNwmFUgtnMWNq6e97n5tOXrTvIE+f8dSaS43iXH7a1V?=
 =?us-ascii?Q?HWmmz/QdTvzJQdp86elq29po0fuUnpPxU4hk8iWqVNSgE1KAQbX+u8HfODyl?=
 =?us-ascii?Q?U7qEcTZxx9wEpE+4ai4NtaQkb0ZFXN9gXn3YSpQ1A0KIqVVLcPQgcMXi2Ae2?=
 =?us-ascii?Q?8GRXJcIAmJ6O9pMwt+fxClzEUbCx9WfwAruFz9ik2lFiPJURFW5iknno6Btn?=
 =?us-ascii?Q?uXAw9arVQc738GnvzkH7204CXWeIn2+VQBfqWCtFQufz6bEK3q1If4PVq5kA?=
 =?us-ascii?Q?JHFDHP7CKzQJXZ84NRgn/PyiXWiwKv/TfqVgwHDPDKs8IdlN0+tFXFkShOhf?=
 =?us-ascii?Q?u9GKEo4VWLuB7HwcFQ0liqNCxuLNoAtjUPO7/031PAtjUBn26Pg/s2POGewN?=
 =?us-ascii?Q?BU6KJeQERUHy97Nd2OVnD8Qp7nMaeu2GkuarfnK3MC612EU2DU1E4jiMgGAO?=
 =?us-ascii?Q?FIYmmpnvTafn5NVIwf9A0sEU2ydC1WclvGUy2borNYwiE6ixEKBeEndBSW7U?=
 =?us-ascii?Q?nE0HRxk8ZptadlrquMujqVWvKGwDunY9Plmr3Z7PXwJEiS54vm5irYZX4Mbs?=
 =?us-ascii?Q?MLpxjoZmYMGoqdh33+AzKEFL8sxaHpdKi5/HC+u+nmKrVo9SeaF0UvLfuyPt?=
 =?us-ascii?Q?Gecf1p74D7Z+6/3mKIwNbNQWIBuerVDK9pH0DYtuyfOF6+m4QIA8AFETgcxh?=
 =?us-ascii?Q?cV7BIEwqUDqNptCkNIP032Cr0l20IRXMQcpqY7PSt0aSsx5qMH1sKTVYAU7f?=
 =?us-ascii?Q?A3aXgl9XOzqYd898jw9HzSIwkxgw02nv40T7Vf3lY7aWMFHcEMKoWXhguJxL?=
 =?us-ascii?Q?Buf2QZk4eSGvX5uFID1Ss6Y7aWKi212fEttiLiA43zx/T9Vey9NxkXTUgrRK?=
 =?us-ascii?Q?YO8J30XLuVm5dMpNzIBfBtGb4Y4hilJr+9joeF8AZusAno7T3ZSZnES+EOxg?=
 =?us-ascii?Q?EQW4eI9qO35vWTLEGiQ3/MAtS6JTQcFxlhLrz+WAH7el0HMS4ZXWhXA5w5TV?=
 =?us-ascii?Q?thorTezM3O/9pb88dtTtAUF8xYoqlnLaDIrh6mS6uUVq9MCIj+6AcmVihMoP?=
 =?us-ascii?Q?1iBlMyAxCbDkIGC+kvoSHRm/jaHwoGQ6lfCHisAHO0rTBKNwlZZh9WYJx3sF?=
 =?us-ascii?Q?I2M1FSdpEroQ1e+v4ZSreIg+CRljCVEcrQC1YHG6auMw+U6bMR3dG53JhiVx?=
 =?us-ascii?Q?fhv23HcmkqbUkt2zML4u8hTglzTAZPUPZhGNAv9i7i+QhawyEwLlAJaudFRz?=
 =?us-ascii?Q?EnLbLX/bg2uldFIQuTSn3ahghaFxo9y9yWmAtHsG7XjyRqea24R3hfiXDzIl?=
 =?us-ascii?Q?Shn43+R5DnbknqyvALfheUfRT2FLSd6/mrkZY5GtYW4hm3EBt6NAG37mHICh?=
 =?us-ascii?Q?wmNXMcwZPqMO3SudDI77RHlmAEwmLPSz06Xk8sw8F7mDG/0BqXjjGbP9KrVn?=
 =?us-ascii?Q?1wACpR3sF1zXQ7V7wSkE1/zHfywTtaiV5f7XApzV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF653E4B531.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fa2f04-bae2-49e6-5dc3-08de394b1a88
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 06:53:06.3337 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xfCeSAmLPIYtCuVIQMHANDDtvkROdxmb3YmZdbf5zoVf1AWw0lCGXWj3cGS3tuhHqNGm0s21UzzjquVvS8w6Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7944
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
> From: luca.boccassi@gmail.com <luca.boccassi@gmail.com>
> Sent: Thursday, December 4, 2025 8:56 AM
> To: stable@dpdk.org
> Cc: dev@dpdk.org; Abhishek Marathe <Abhishek.Marathe@microsoft.com>;
> Ali Alnubani <alialnu@nvidia.com>; David Christensen
> <drc@linux.vnet.ibm.com>; Hemant Agrawal <hemant.agrawal@nxp.com>;
> Ian Stokes <ian.stokes@intel.com>; Jerin Jacob <jerinj@marvell.com>;
> Mcnamara, John <john.mcnamara@intel.com>; Ju-Hyoung Lee
> <juhlee@microsoft.com>; Kevin Traynor <ktraynor@redhat.com>; Luca
> Boccassi <bluca@debian.org>; Pei Zhang <pezhang@redhat.com>; Raslan
> Darawsheh <rasland@nvidia.com>; Thomas Monjalon
> <thomas@monjalon.net>; Yanghang Liu <yanghliu@redhat.com>
> Subject: 22.11.11 patches review and test
>=20
> Hi all,
>=20
> Here is a list of patches targeted for stable release 22.11.11.
>=20
> The planned date for the final release is December 18th.
>=20
> Please help with testing and validation of your use cases and report any
> issues/results with reply-all to this mail. For the final release the fix=
es and
> reported validations will be added to the release notes.
>=20
> A release candidate tarball can be found at:
>=20
>     https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv22.11.11-rc1
>=20
> These patches are located at branch 22.11 of dpdk-stable repo:
>     https://dpdk.org/browse/dpdk-stable/
>=20
> Thanks.
>=20
> Luca Boccassi
>=20
> ---
Update the test status for Intel part. dpdk22.11.11-rc1 all validation test=
 done. find one new issue.

new issue:
  Bug 1849 - [dpdk-22.11.11rc1] virtio_perf_cryptodev_func/test_virtio_aes_=
cbc_sha1_hmac: dpdk-test-crypto-perf EAL: Error: Invalid memory

# Basic Intel(R) NIC testing
* Build & CFLAG compile: cover the build test combination with latest GCC/C=
lang version and the popular OS revision such as
  Ubuntu24.04, Ubuntu25.04, Fedora42, RHEL10, RHEL9.6, FreeBSD14.2, SUSE15,=
 AzureLinux3.0, OpenAnolis8.10 etc.
- All test done. No new dpdk issue is found.
* PF(i40e, ixgbe, igc): test scenarios including RTE_FLOW/TSO/Jumboframe/ch=
ecksum offload/VLAN/VXLAN, etc.=20
- All test done. No new dpdk issue is found.
* VF(i40e, ixgbe): test scenarios including VF-RTE_FLOW/TSO/Jumboframe/chec=
ksum offload/VLAN/VXLAN, etc.	=09
- All test done. No new dpdk issue is found.
* PF/VF(ice): test scenarios including Switch features/Package Management/F=
low Director/Advanced Tx/Advanced RSS/ACL/DCF/Flexible Descriptor, etc.
- All test done. No new dpdk issue is found.
* Intel NIC single core/NIC performance: test scenarios including PF/VF sin=
gle core performance test, etc.
- All test done. No new dpdk issue is found.
* IPsec: test scenarios including ipsec/ipsec-gw/ipsec library basic test -=
 QAT&SW/FIB library, etc.
- All test done. No new dpdk issue is found.
	=09
# Basic cryptodev and virtio testing
* Virtio: both function and performance test are covered. Such as PVP/Virti=
o_loopback/virtio-user loopback/virtio-net VM2VM perf testing/VMAWARE ESXI =
8.0, etc.
- All test done. Find one new issue.
* Cryptodev:=20
  *Function test: test scenarios including Cryptodev API testing/CompressDe=
v ISA-L/QAT/ZLIB PMD Testing/FIPS, etc.
    - All test done. No new dpdk issue is found.
  *Performance test: test scenarios including Thoughput Performance/Cryptod=
ev Latency, etc.
    - All test done. No new dpdk issue is found.


Regards,
Xu, Hailin
