Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15184D4336B
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 06:51:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D490C40268;
	Fri, 12 Dec 2025 07:51:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1CA66400D6;
 Fri, 12 Dec 2025 07:51:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765522291; x=1797058291;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UGKH9byJzh71tQsKOedOLopfXP9et9VxY0AC3XgPJIs=;
 b=VXhSDkZjCIDTaWqJj4+8YUIpWa2EHlmlovNY+CX0aULqBPlrV5z8b1Kl
 daPXdBpwbBV3ecpqogTDHJcEBT2WgiD4ae3T9IEmwgCDBs0z7A3MPfP7P
 2XXHbQlBd3COngh83uNgin5GbYq6T0uRvGnMetvKjFXUDzmwhb336F/uT
 ZzlSFkhY1HHjxXAbdfimfYTffUzBtHlfoLepGRTYe6tExEO6bcdBu/nTw
 6TEkFGBCz8c/4gB/NjhME7w43fmOh2QqpB2/gfXPGT5R4vc2C1lRmBIXU
 eB8F7rVW5zCeuSEPSvP/amP2UIisNUANrfFthlxJ/wKLjfNdBP7vVzIRU A==;
X-CSE-ConnectionGUID: P15KY7KqRZWD0PNw+hUw3Q==
X-CSE-MsgGUID: +GwEzUJHThKsESkdIrVxDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="67587240"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="67587240"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 22:51:22 -0800
X-CSE-ConnectionGUID: ENs3izTQRDujhZoE3bsDTA==
X-CSE-MsgGUID: THMAPlTETdGpY/02MTEwYg==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 22:51:21 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 22:51:20 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 22:51:20 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.7) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 22:51:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsHvJK+8Vye22cAY04L55zwvSCplhjYTZ1RZrPM0tFsppw7Fq0jXs6GEIymhn5JBbHxnqGB74gVb8NInvSNPLVU3wcFHKKLimN5qlrw9UBplKpjn25McunuJ8Z/jmSgeTfR0nOHHUv1Jcmhas/AU3knCPSITTdUD7rHo7Kd0Xm88cLW0SmM/nl2SL64RAgPpBuBQThl2HftQej/4ynes18FcJKGS8Pja0TJoH28m4Bbv73wEop+utQbD9W5cB/yqQqgKELrH6XBqXDGz4T+IOMDD826Z1rQcANm3ZkV5KpPcPrHfM0is2043441LCLU1OvwX47ArUrP8pwLxNKvCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtDv32UVgP0hxOJAPybRsAx0nmG79nidWoIObYFf0dQ=;
 b=DrvuQNXXNQxWILpBOKopeJ1vfZEL6YsyuyAgujwrExAuvBcpUJp1LeBR07xuK/8SwBA0VKKDdPDJYvnLaq7nlEX7CbYfrlsocPj6fX14SHYC7umGmq9cWzRsHRAOrIxbGacVTFuoi/Dx6o07XQk0ERpGaKC55fhdpDB5TwexdCJyXd4FnODmlxXiDW962Hw3N+2+IUT/S7cSIlUSWHBlT++l/WFATzrZh2p6elhdVgLM14Dp7sYJIciIs4ET8v9d1o+8jwSr14JD9dYqBs5FgPsLCp9Ix0bBhjSxYWS1TxTM/stfAbPEVe0UmryD/MSmWI2EElyVWfA0fBvHvMp93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF653E4B531.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::74) by BL1PR11MB6052.namprd11.prod.outlook.com
 (2603:10b6:208:394::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 12 Dec
 2025 06:51:17 +0000
Received: from DS4PPF653E4B531.namprd11.prod.outlook.com
 ([fe80::4d34:9ad2:aef2:7115]) by DS4PPF653E4B531.namprd11.prod.outlook.com
 ([fe80::4d34:9ad2:aef2:7115%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 06:51:17 +0000
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
Date: Fri, 12 Dec 2025 06:51:17 +0000
Message-ID: <DS4PPF653E4B53102B0B7AFBCACE9F031539FAEA@DS4PPF653E4B531.namprd11.prod.outlook.com>
References: <20251204005603.3236032-1-luca.boccassi@gmail.com>
In-Reply-To: <20251204005603.3236032-1-luca.boccassi@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF653E4B531:EE_|BL1PR11MB6052:EE_
x-ms-office365-filtering-correlation-id: fc1092f3-dfaf-4f65-d3f9-08de394ad96d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?jDF0ERPMwb4jk45aLgBsSxe/s0bTw9KF+drXSfuUrHBC/yZSUNZ/1rRpEi8q?=
 =?us-ascii?Q?t9z6cVzABCDJgzvvc5aTHoOqZe7/MoPh1odQS+emnN/bCtQ7XhZy/YzsYVlu?=
 =?us-ascii?Q?/qE4NOwN62Sq+fQBc8FzWv11rhDX/s07bMmUDHnql3vKxcZQHUn2tTeZWnaj?=
 =?us-ascii?Q?Ytjxzm2ePfukajPoHQaqZeOsMQJP3cLxMrVrWnRQ2sTHTXPJo4Xa9d8qXRVi?=
 =?us-ascii?Q?9uSsLcwa4BghmoPUT2bQMK12HJr76RIog3NovL5R+cA2BISpqF+geeGv2CrA?=
 =?us-ascii?Q?467WLounTk+ehteCmB8NoQCIUsYDD6H8Sk2JY1xVztHptzqoixNX0LTuYbvJ?=
 =?us-ascii?Q?LGGarFY6O7cks1yCJEzp/jd5I/XP+zA2OHypYBi+qPxQhVhQZP1673ItYlvJ?=
 =?us-ascii?Q?yh7hynLXIR09xiKzoFNAA634B1el5v0dl+uHSb0IbuWvaEyyRP5oyKeKjYMg?=
 =?us-ascii?Q?Uroe7j4A5U4Rwk8ERtt1P0hI/7c9OV/1N5T2Rj8rLtmlbYIHpH+U3aYajbO8?=
 =?us-ascii?Q?vk/mBLK+diqE1VjsmOJW8JQukKcBp3ocjjh7fkROMlem2Ym5wsDTRAxsvW/j?=
 =?us-ascii?Q?AorJXPlTAPr/gYkEByo27NVW4/IBrY+Z5fFUftqPZ35cxjZuebiKvGlDo7EY?=
 =?us-ascii?Q?o8AF81TjHUbyf8xBkjLCq/kT+1tcXoQtIKNWABGqlMoH+aIbOvEbow28e284?=
 =?us-ascii?Q?IV8RuaWetrBu74N+7S+fvsRLnatzIEWCKQheVCK6RVaDL6/w+1wfvBl9V05s?=
 =?us-ascii?Q?v6+Cr3xavKARwN4SQo+R3oJ5EXfNFSkf2Wzrk1AP63XhIvG5V+2UNprFK3Fy?=
 =?us-ascii?Q?M8n7u1LiWXIOdmNMEt6/ETlmlqUkMdg7HHJILFb88jfQ2MQZWsYBOLu1xQR0?=
 =?us-ascii?Q?cikHqRP5seHjINfZis1xC8mCjyjWgnPLCft2pKqviLAHaDamgmjnmbQbbwhy?=
 =?us-ascii?Q?lPZW64dEvU5e7tZZsj+tkEKP6aTq5KMX6zdOKO9qyirh7RlZIHz5OasjVyCV?=
 =?us-ascii?Q?hLDk5bkAL1ruZgsZzcUXlERXMMD6vqO0kIIAy0cqLoOKhwRYa/eFQe+YdQKO?=
 =?us-ascii?Q?3Frs2k39HOOsIBJu06snQXR1WL4pgSGHKkHFhRik02/hHFAKHcf6pdsfzSuz?=
 =?us-ascii?Q?06sX2MgWixNR6MuI5FgheVUQFjGkBnBlvQSALWYVhtnl45D1Zn2SF8Z91bFy?=
 =?us-ascii?Q?DdgNHx6D0dc8KE41Cei4K9IUcdtrdtkkQjvLPNwfxOM9YkC/j/RMRjEzJfDx?=
 =?us-ascii?Q?OhGiukCpQQyYqIuZmr6DaCYK+0e5Py4jllXZbpob2rQMzr4v89Os3NZote+g?=
 =?us-ascii?Q?0Vvfkcs2PTp13r6bKEHAolxsZ7xDzhghdybo24r6XVhHgXzS7PUceoVywjQA?=
 =?us-ascii?Q?mBsssVAmrI+hdKedMng5VghqDg5HEIWEfpb6N/YrJn6uG724dl4qBbWmB0Ke?=
 =?us-ascii?Q?j8vL9xHk2ZoDkU+QRIauaQaUVa6G/QhcnrPRth4mc8z6RY3OEjjpINRs8vN/?=
 =?us-ascii?Q?fRvtj38aKzisHgWBu64I4635R2oiDgzdkBghAxgDNXTRe2N4bzGOGsg/1Q?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF653E4B531.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5mU+PfXwAPSPnxajIIbB6hERilNAdO8qkl5KkaLiNd2PZ1zMYV7DQMlkDmSZ?=
 =?us-ascii?Q?leKV9OKUC9Bb4syC6vhi++tkem+rH3loWMZgjJ8ng5/jS7E4rFCw+u7YZMZB?=
 =?us-ascii?Q?XrktGztU+fpLn7bc+O8q5UXQIqdw3gOpLzBFE4owW5SAJVKSf7FWcY50ZX6s?=
 =?us-ascii?Q?NFR/0Hvcrp1W/r1z5Le++wOfyNVb8FSJ/MIsq58mGVbWiAbfP71ZU5gDD8Mv?=
 =?us-ascii?Q?jtCJZvcGOOY7pjA68II1k+2mjAd2cBCIfINZq3U8vzXpC+v8WtdYnuiqQaj0?=
 =?us-ascii?Q?xAiEXdbjZryLczMUhNKpgpcK8RdB/BApghEnn38ouDijclQLtf9HUlk9gokw?=
 =?us-ascii?Q?71NEglp//oHl1+9ag15F+9ZQNf8uAd2yo4R62tLXz1AwdK1jb1Rv5PQ4oH/Q?=
 =?us-ascii?Q?QhVCs620dWhQfkl1T3LEKWFzqHze4cIq8Y+Y55C9Y9S1bVjup4qMQ6YdG3uo?=
 =?us-ascii?Q?SsF2OqZNLkx0e2WvfgzIvw/QOkIoI4dD6nUYR10kqkP0YW3BAiIs6qijssgZ?=
 =?us-ascii?Q?+bjxld374n6QWZRkd6A58c+nTRRtCOy0mwrewpKTjoCD8bzzmNb1QV4IlGAe?=
 =?us-ascii?Q?DJ3JV9qNru+NjmztySEXYsj6rLgto8ESZePbEB1ZJutAs2VldYuyrr4nDKo8?=
 =?us-ascii?Q?/XzZlXlRzIaVbgfIDfdlhbzRn9//Q9zkPqhRFpeGAREzLSZzwCw0Wr30tqHz?=
 =?us-ascii?Q?rSjq+Ifp8pav3NPkwAgOG/oKfEG0xLTFUuE/FzA5fLtd2PE+rVBJIlIo8aCA?=
 =?us-ascii?Q?5l3zpSPHf67IhndZjsXNLidAO3dtIQdOZr4tcWxDPwNRZGmK6avmoFG+linY?=
 =?us-ascii?Q?9RDbkblehQuzr0vL6kosS4Ixo1Z8THQhZfwMf8NSnFIDUKX6HbPCzlWhJ0R2?=
 =?us-ascii?Q?FRxp68X8N7CKdNjGECgDGIx7gNdxnlfNxU6DH438a0NqsYghZT2P7LlAZ3p8?=
 =?us-ascii?Q?SI1hbkDfVyU23QpCqtdk43SiJwQckNrZEdaCSTEk6DjCAzuhS2oDz8COfO8r?=
 =?us-ascii?Q?uw/5lT9dkeDK4deExXWlSsLbqbduzp/8W85modV7gVIdT0QIxG9+ZpdoyFxf?=
 =?us-ascii?Q?FzrYcSduKyXM2kujJR4XfjOyvnd5LbvC26epDsVCf9ILkYlQIBuJeNYudXDK?=
 =?us-ascii?Q?gFQJbbCWMsq/vAeK1kzE9p5uB1epZdrSB3IOzXK2++R3cHQlfVhno3gU/gAR?=
 =?us-ascii?Q?8iXXFHd1tsGnAFyRouwiYwZS0ejfg6mbVfGhr7w+ri6FYusvOgApmfzTZomB?=
 =?us-ascii?Q?mYHm77t1kWcYgJgc76/90/jxIscPeDfKO6ajQFjNlOgfVhzAq28yjSFSGg2O?=
 =?us-ascii?Q?89jXvCl2XOit8sQfmO2/q1t9VL6rYqECwomyExkR179pFnU0G/qhLLlUq3xR?=
 =?us-ascii?Q?BcVStowNowILQ9mPpGszZkwwMXFi4ubXGd1ozJykQOYu2nD06YH6tD9Nszsp?=
 =?us-ascii?Q?YJEgLwrp2sjKjxParzSA3bAVonobIa8vKEW6xCZSFLyZ3IHKJuNTeZumLwAg?=
 =?us-ascii?Q?nZOOS6e959L1TvPsmGEyrCnwmO+I1FYiXU+5KiXMYekunJZ3cK+9HKJf70Iq?=
 =?us-ascii?Q?nmrX7EA5dGrsphKTU1yJui6f7BZPgzisylfPdrjy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF653E4B531.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1092f3-dfaf-4f65-d3f9-08de394ad96d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 06:51:17.0791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NzbQDdng1gLbnFK8+c0N9ysVpwmZOCGdbULAjSM2PasiEc+KLESfDpu7fsBJcxFVl1d/ctFYN9qjmdZaQ0Mclw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6052
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
- All test done. No new dpdk issue is found.
* Cryptodev:=20
  *Function test: test scenarios including Cryptodev API testing/CompressDe=
v ISA-L/QAT/ZLIB PMD Testing/FIPS, etc.
    - All test done. No new dpdk issue is found.
  *Performance test: test scenarios including Thoughput Performance/Cryptod=
ev Latency, etc.
    - All test done. No new dpdk issue is found.


Regards,
Xu, Hailin
