Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F0F10FC464
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 01:05:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAE9440264;
	Thu,  9 Apr 2026 03:05:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 183A84014F
 for <dev@dpdk.org>; Thu,  9 Apr 2026 03:05:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775696757; x=1807232757;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=r/WxXaLvwA0dWbmhjnhjb3aOhTAjzxqz/VNLes9is6s=;
 b=g0JIjckAF7Gg2Zf0KDvwP3UweUFoNiwSrgKQfcUepuGxK7vsteMLyCKQ
 tMpKFZQzYlnxWK5/Kf32nqxBfWsEtTbNl8g4VJfn3ScYoQz9i9pm8U7Le
 mRaKBc+kmz2bvXoej2uVOcokEoRuF2hVycgCv6LvQW2TF209f35UyO2RT
 hcbVjRfh9wTynRV3EV6kPlnPlRN2ytWonAhQp2/tz27Fq2yHVDi4rQjfW
 Q39UJr69TnR+jFUnbG+IfOf2DL5nkg1pVf6+6q7sHfLQHWygU1Pq1Jxpn
 LqIcXbSskeZEqy35OG6NDHarT1wk13W/vXpIHBjsSYtmJIYcTNI4IcMJo Q==;
X-CSE-ConnectionGUID: Ah/zAPyvRHCX/Kc6zXuTDA==
X-CSE-MsgGUID: y2joStnaRAGbCnRHP1g2AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="102146890"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="102146890"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 18:05:56 -0700
X-CSE-ConnectionGUID: 68GzDcsERG60wyJfp4g/MA==
X-CSE-MsgGUID: C9o9yvx3SIu7pA/J3JM0aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="228853806"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 18:05:56 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 18:05:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 18:05:55 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.5) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 18:05:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niQlJBX6ZcgpaO3tYJ5NTruJ8iMEVf1sdCVzu8JRldbMRCZDJOZca1UjIdjT/yBNPzh/rrzzzrJOidVBFvU0Bs/ZtDoND3RDpRNAvTYebS1hLdChn05ByVmt0cS4x6gveSO50a8QkmloCR4zCUTvqOeyLototlOA3GRUxxJcabRLFIrbabMw8ARk8wTxIlBgOW/cp9nq9vbt9L3ILuRqmbM3x/B+RTRQ3rfB4qW7/0L1Q6DgUTtR1UF7WTiQhWMUKWDKQGZo90Ic0yRrRJnfXkJcwXOf+AglLlg3VmijCwSBlcevHjp3WD+kxFkYO2nuDKLEC8tI5af/CiU8yYpAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/WxXaLvwA0dWbmhjnhjb3aOhTAjzxqz/VNLes9is6s=;
 b=DpY56CFauu8mqam9gkDGVIq7DeC21bLdQNr7xqRHkNQofIHLhIaaBUQ/k1n/r4f1SoHGW0jG3jcyL/3fmBvAywNRngIPlbYJ5TFNOZ0IkqK1cExWYQYWmSqQEN3u/yd9vFI8uv3CMRqoqTiF8kvOBsqoDxseXAK+Lgk4KbgzLqjrYyFe8f+Bm+RHYl5nT/RtQ1DXr9djTVfUSRbYDMC+KugNPkW+4L50zEaSd9Qho99neiPiYr1fJrayR8wGaTWaYLdnV4N7KzTfw6AWB1QP60ouHnEcH7LMik1Lcz40s6t/4UboAAGNZIDepo/vORcogkoqGbHXIdAyIQVbI0Lflw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by IA1PR11MB7199.namprd11.prod.outlook.com (2603:10b6:208:418::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 9 Apr
 2026 01:05:51 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b%5]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 01:05:50 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "Mandal, Anurag" <anurag.mandal@intel.com>
Subject: RE: [PATCH v3] net/iavf: add support for QinQ strip
Thread-Topic: [PATCH v3] net/iavf: add support for QinQ strip
Thread-Index: AQHcx5IghM4c71UzD0WAyb31SJ+9MLXV6pvg
Date: Thu, 9 Apr 2026 01:05:50 +0000
Message-ID: <CY5PR11MB611616B1FC076DCE99A2A38AE4582@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20260216103710.195777-1-anurag.mandal@intel.com>
 <20260408195947.51386-1-anurag.mandal@intel.com>
In-Reply-To: <20260408195947.51386-1-anurag.mandal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|IA1PR11MB7199:EE_
x-ms-office365-filtering-correlation-id: da5c44f5-95a7-4049-ddcc-08de95d4242f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: hEfRjucq8xAgR1EmiiB/Dt5ZjCrHb7bmrtBydf86VaK63Nhxx3EEa0Slkcjh2sL+83gLxUAY6iYCX3Dm4EYPaVrFeKMOkpbMqN5zr7Vl6iJOxkhFr1XZJDjPjd59fZGd3FdVZyycCexLyFwSBZfKLztmGHmh0zTweNpSo87E7JJlBmnuHqcRtBMvbAb326o/ULlQal4fbEQCFwMeh0xpNHWYPgYm/iv98D1fwlBPqETP41i/DbWT4SDVqlHzlTnNk5dT8v24zNaF6rsWN8Ll79/5jsXREtB1DYNqik79tjjeE/ojUFMAAFdB06u2Zq2kVZPHGrGMkIVeZ1yJbS16iUjpdF0/+2Af38PqtPsRJmS7UAif8lOC++1dSVSi+OhgnCZt1ivvGfho5Hbk+baO3lvmQqlRMjYEBH1TDUkJPVOalPdE9x0R23/EJP55WOb0SKGO83RkCw3fptLIul7MXkwUCV09CVjpH1zCP6j0RHHV8x7ge4j9GqgJy6pexTeO6/l9zesKWCHksR8hVvBwpv/qv1uBDv28QBb16mRLCICKRwnYfMBQotFQB0nrkozCAXkvA5v8+dDonWHCl5frLyQQzV4l1tiKJ5q8k0IPCL/1jmly91zaUTs1FZ1GfmLZ1bBHKI4T0C57HLgzj8/QEqGntd4tLbCZVyxhnG2gksDr52vv6Uoa+/d15hAdP3cHsjS/PEsI1jSdbOstSaiHLEgUYxe64FolXbaCa1KnoEb8XVq4KvDexbcusBNMVNZSWDa9VHA8emX4Af2jNwAEqkMR3IGu27RmTiCUFBpHzXY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pH7gNzeRhHgNLzwv81bM7PyuNyN7OSrhb1zjRHsmRehfx0oFwTm2kQMgHShi?=
 =?us-ascii?Q?MgzVgzhdkAgEbGINFCwgJBpSp4A3a83wOmgRPEU5K7xZX2Y8fcfGNzwrxZ3t?=
 =?us-ascii?Q?nR1RzlGbst+2iNzVniNEF6jDQbMZ8ZjxVqeoGNWdsQmIJY6xW3gvRJal8yj2?=
 =?us-ascii?Q?UfJEkOFqlVt0Xg6vcQ6oKU7A6NtxqxdIThlOn+ndEn7nqzMm6wHJVI43UO+C?=
 =?us-ascii?Q?jWtRtsbU1Qe+Tl8Hoi8P91/C7yQuJybvaVgS/Is6eV2Uq3EO74M0HkngU8eb?=
 =?us-ascii?Q?t5qeoGwXcX4bbk5pg1VYWEdYiUP/JjskBzozPK/a6rsFgJml/EOW5/pM40uh?=
 =?us-ascii?Q?Hh1uHIXR++ifztBfGCJ9KonMNGHYRoSjYMeeuwzWJhIx6/xwln8BUrkRJFGh?=
 =?us-ascii?Q?WXOs+oLFAmIPk0NSH4BZ/7oTTKa5wqkPlI+sg756bpsLaM2pHk6bfjb03bx5?=
 =?us-ascii?Q?KK7AIEenlRn5pW32GHaMioIjJwTNdbdUvaJI1qiMDXViPE0Upfsmhwo3P/I2?=
 =?us-ascii?Q?Hk41mEiLMxzT8U+603xdDap7S4l4D18LNBRcM6Qd4VOfmbsVq6U3v9tEBSFG?=
 =?us-ascii?Q?eqxppv15ZBDpKTDz3zbZEEGXxTHeIj6BeMwzLctSoOnQ75kxFzDdOCURHSI+?=
 =?us-ascii?Q?tQ/8lDqAWrtVXED8wBDYTz1O4Jj4fLuxu+OtzhXb0FxAE8hLdqkD28Jin74a?=
 =?us-ascii?Q?ufYaR+duj2kvyUTRceBCbMmCmGqjIWrv85sN7mBlqqwkH3jLRH5SkXq9CIjN?=
 =?us-ascii?Q?I9qCaJSNuqCaXJAl7y/uroVbLvGff4hBgOkKrW4vId6Hu5dPV6LUVtE0YKuw?=
 =?us-ascii?Q?42HmblyyIOcC2cFJpsMSOl+x+T2M0jgaBpPKUgHnkqa5l6nouEwBtd4U/roT?=
 =?us-ascii?Q?ghoR/huxRr+r3IuatdySrIxbUDngoTcT9EvOTFV8VN1wqBRIt8zfmceeLlu4?=
 =?us-ascii?Q?+IsRqAbetMpDraZfNSLea9ojU2eBvo3ODPqDD6yEUXL56GD6fFEpvBPxEU3/?=
 =?us-ascii?Q?pZY2yvw0nWTk33Oonwm9wI3rgb8KUrhzFf2c3oTkW/GK8Rcw1GQ+v+U8h7ru?=
 =?us-ascii?Q?8CVaSz5IEmW4DPbbuYBGt/NZgZC1MrEG9ehCIwgiBdwXMe4is+M+7yrefW/r?=
 =?us-ascii?Q?U9p+cwE5+ifZQ6GKKIqMZmKWEbfHv+/ou5oUhxnd8AzoUgpwlD3qJzYrp5xl?=
 =?us-ascii?Q?mZHG5Bx1D9HmoO9oAFeJUv3aChCfrDD5M1YZQKfU11AvfdH2P0fI2fRflJ9P?=
 =?us-ascii?Q?HiCXsIzxD+6j0riyJNFs7gCsHoOxJoGhA354osYH3E2NI/aEw71a/EHMQA/h?=
 =?us-ascii?Q?9EPX5Fwelda8uHuzJHl5lrTz8bDUwRwaUCXLy4GooV2fdmDCRGJU8T6VkCem?=
 =?us-ascii?Q?K/ssE/2PeTBieRODYPnbbJ7j4KWowQUZYqDFUUT0QIVVoT+4CGL53BYIv2AM?=
 =?us-ascii?Q?p18jEoTa7xD678p9EqEv3XTlgZdQMUFoN/NlEUBr0bXzQlcU3tvRtxRJKaw9?=
 =?us-ascii?Q?CHVGmlMWBFJhXTsxCydBLxqeUImx2zXmN67YN5ID5p3VP78ItBev06L0+zlB?=
 =?us-ascii?Q?Fq7S1WdOYuSO999OwcKPMc0ewLLlhEpwSayYTifX1acl6I2YxON0729VemHL?=
 =?us-ascii?Q?ZIf0sdxH77uesHONUUmqksNdfEkiulPQ21QfdTLS/69A17suDLm5FVJ0cToW?=
 =?us-ascii?Q?gUxptV5WfVNbW0mjJVCOw8cHGGUeqEzvL5pWcQf0VNYfTtWlNUTKifc0uR3n?=
 =?us-ascii?Q?5BoU4mdoFQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: whE6+m3FzDMlEipIQqz5dhJoLsmAoHMVqn9xemn3PPv+MiGe0JkOuxyBmfDfs7ReZRus0EiKNa6HMRlUblskuERvqCskKe0jaxSesnvuCp8PA5l04nsdBt7CnpZrNI6gj7Ih/EwQzmXoy3ImvEdMLYb9fHPIKT9ioiEe39TGiJzyWnQYZ5EeTV6nkAgXg0JZoyIE/CQ5SJmhexTDnHEdcc4bm5hAPFUyeM3RIJX0nISCKJD0bSxhRTUpCeO9vKTvxs9+PxWb9QpCTZFUyGfSZwc2PLT9i8p0y/xZme0nAEmk1o289eGUdBeImW2EgeIuSDbL42aI2BCtdqc0Ln5kRA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5c44f5-95a7-4049-ddcc-08de95d4242f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 01:05:50.5455 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NnU42HPFt84eFP3eiIgaduT3i0shcPtSp/UARSMZiOUdI4mmpBPraK05Wdlli41JNQTtRhZVJGpuvZbazWL43A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7199
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

Recheck-request: github-robot: build


