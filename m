Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5235CCFD647
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Jan 2026 15:27:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B61540267;
	Wed,  7 Jan 2026 16:27:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id EC7454021E
 for <dev@dpdk.org>; Wed,  7 Jan 2026 16:27:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767799623; x=1799335623;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=SQcwKBPT2rJw7ct8YgReLnpOjo3N80QHrRUlgx/SMww=;
 b=Tor7kUxMbBlnBdXMiQSklmsi9oSwmOH7W18rBA9gWXtpLerZma/R0zuA
 6ZmlwyfKVxbX/XeVaiSkBtsS14TUzdSEPcwuZvUC9seYt/EE5UtXJfw+F
 vAsUFNLqFMa6FEL5g7d6sEA0tmY9xYiroQGjzhJI2NkEaKwglPmQ9vjNd
 ZnhYEmioF8cnOFXEJ9ayler9EoyDR/UpWhl0kfGEfdDxTyf/uL/vV5V43
 Wa0ghUge0R7IotKpMhugHQ+yVH4cBHTdaEYQr+ceQSc6nZviXGmo510ZP
 im15gCdIemdNkI0fgfx83zw0GgfxcDFRdtnK9TbbTYjN8VEKco/gmqtBS A==;
X-CSE-ConnectionGUID: 2GrqPGSvRw+1CVzRcFVG+A==
X-CSE-MsgGUID: wtHSx9roRZqMhQbjewPzgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69330900"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; d="scan'208,217";a="69330900"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2026 07:27:01 -0800
X-CSE-ConnectionGUID: 4OnF5HqYSsu92vV/Lz+ybA==
X-CSE-MsgGUID: t2c1YwzXTAaDC4xB/BWHxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
 d="scan'208,217";a="234098540"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2026 07:27:01 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 07:27:00 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 7 Jan 2026 07:27:00 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 07:27:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yualwKKG8Roz4hPBQHoXGW0irLdkLe+kpevs/UaZemLhQU0yWB6Zu4kUwGfWBbp88k2N5rH7SIc8l/hEh9z2ioWMN7novNTaPCmoNPsgKDYWOCzQ70LfVWFzmYoV4cadBAGIJuAaD8nDUTS9s4u3rAZjAUnJ1gbkLXyj8r3xkdogjgwaNuO4lP1sm4nfyuTVdKDMr/K+XF3B5l9DLQROju4DljsOeAmEeyZ1/ORd0CPLAmw8Mt3+MkbhV9IPajV1uuyjRvtc6e0Ex9iutnbFoWaZOp1VIgH6WuRxHvFbujC72ohP7O6XWevWrUgfniqsXoI9J/1GQJR/GbAQmHL14A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+tXp7vSE5Un5DPFOM3sibFWUhgNoTlmMvD6vr4D7xo=;
 b=TbFYt+pPF29sGZBfADQz7ObiKPe5sA7YMJU9XvWHzyw7/sw6I+aQH63/uaAwVZyFqHh1G3fxQQ+ws2MLFIlVouqeteVoMn4SevuUUVMF2/hhWApT6n59SCweonshY0Pt1L2FGWkwb3EqVpAwAoUYoQ5YNrgb3pWmZGkH/wYXFsdOAmAtaYmCYhZ8+mD6UIvFyemJ69B+V4E+CEQ9z3HDFBqB3nlUHXYRHb5TJWrQa0xpaYWj5ATL93Y60PSabthL9rxjw7UV65VuJQDWfKxk1RzLIi8zeCQxch0xl8Kj+/CoId/wWrA8I4JCxEFYiqQqzHRpjCWpX++nNg8DdN+rxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d16) by SA2PR11MB4969.namprd11.prod.outlook.com
 (2603:10b6:806:111::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:26:57 +0000
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::bdf:9086:1292:5d72]) by PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::bdf:9086:1292:5d72%5]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 15:26:57 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-01-06
Thread-Topic: DPDK Release Status Meeting 2026-01-06
Thread-Index: Adx/6fz+qHDWaIawTfam/O2ChWlrrA==
Date: Wed, 7 Jan 2026 15:26:57 +0000
Message-ID: <PH3PPF37F43E35DEEB407ED016EC5515CEFFC84A@PH3PPF37F43E35D.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF37F43E35D:EE_|SA2PR11MB4969:EE_
x-ms-office365-filtering-correlation-id: ae84edad-b4d4-4c9a-45e1-08de4e013247
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?zioQUcHwD+NsIMwk1MalB7zlBPw8NqA4B26P1hBCfa8nwlrknCJwt+pCm/P2?=
 =?us-ascii?Q?qQ1vX2GhQsZyRroGG8BLYJ30EfYPpbWUINvb3KxMQp2oMY3HgfU4Qg7pFc1a?=
 =?us-ascii?Q?yPnA7IztuefZFSFpBVnbS1pW2x+q89JrGntv25v2SWVrG+ceDxM0vJqZHlOJ?=
 =?us-ascii?Q?zbQCyM3NB09TmQI/qrDEy9yYhKwe7g7eYRcubofBapF6ow28RgddQ7NvEGR8?=
 =?us-ascii?Q?EqNYUgVMraZZeO3A5DoY5COEYX6WEsA+nqE6qjOtO8sTAtU25ykaQlb802bk?=
 =?us-ascii?Q?bTqBT/8Mi4MqBHby3LtXLA9chEENnnGfR8w7vSLshMbvia/ab6FD/mvW/x0r?=
 =?us-ascii?Q?JvFDVYCx9A6x9raIK/pztJf4X4KF1XMM6/nKSZoRcvP7WgQ5hCWC495CuteF?=
 =?us-ascii?Q?gjVZ6wwvvClWXKQvO9kx+WJJdrPnFbJQEt9S1BlDo7MFSBCz5PgHQ7oST5bH?=
 =?us-ascii?Q?OkGzbrZu6iIBsGbDvjexgQxp6w6RS5MXdNs10k61jVN6i0k6bkcEDBbQz4yj?=
 =?us-ascii?Q?Rmzind9EPRBE1T1s5z0ZwVfZXXJQqSn9dOKeca1+aL2B8NS46sglDkqx/Tsr?=
 =?us-ascii?Q?y1491WCPwRtKqOmyiudJCeO74QicIcgR8jImNMWh38fbCnVasMpctSXTMU0d?=
 =?us-ascii?Q?gKQ1w0a4Dfzmk2WGhYUHTPPa57SFY33QPnWqNtzBcW1n+r92IURA2TorJLdt?=
 =?us-ascii?Q?Hn5K3dbJR6HKKWF4vHNCOapZcm+Gg6rxEhiLhXIpXt4hoAfA0BoGNE6i6XQN?=
 =?us-ascii?Q?Mjo39wcpjePLsKCXqWdwEfGmNUOpD55WzGb2gkeCh4Np+Z8ky0IqpVwMpugs?=
 =?us-ascii?Q?+DIB/JpN8wBmk4kTA2Wey+GQjpE+gTzuKk9tquaOykQWUvuDZPIeVzEsoFP2?=
 =?us-ascii?Q?GZ9tt3X/Sa2j/zpLGMK885SqOyVdY0SRmhlrJ9K6vf2vIwlUf/GbKgoxncgE?=
 =?us-ascii?Q?1Pb0emHQ9morhAL3WwkUL5Mazo9ovZwO3EKEdzwTmcQyktpG8hRzQCiPt8GL?=
 =?us-ascii?Q?+bpa0UOdeq8tNelwL/P5YUwHFdx9ugratvK/mI71cx9ofalyCL/qTpwC4PQQ?=
 =?us-ascii?Q?yTXWngLyFrnWnJ4xffJHx+lXIeOPkhbhXvCO449wHrA7rs03vOPCAhC8aOj2?=
 =?us-ascii?Q?c4gdrFHl5GLzyLVtqqBTvAiRibLyi4KMGF2Za/RfSpiWlPmddURU2pBrTTnz?=
 =?us-ascii?Q?qYKi3C+vJHncFAHjeTNesugof1Htoj50TcytsWHtL3JwTjdTmDVlZxlWBbaU?=
 =?us-ascii?Q?ZGArYdZrDU8LBkZ+wlayeCFoTvpRL6Bp8RpMxNbGIH61voIkL2fZWGxY8+B8?=
 =?us-ascii?Q?BM6l3Y4QRO3oDMznHuaBQG56mVLHHiDJxLeRWFI1gllzPoCimBNN4djeH4TI?=
 =?us-ascii?Q?Z7HtVsx9gz0yzNj6UnGNn9sBgs/zVc5ASSKLIvmtJlhs1aGahPvcAcyzpQu0?=
 =?us-ascii?Q?3e29cugp5dc75jGNPdbfSqG3T1xb/5t5Gd/ELyldCWLiqn93jhhCtg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF37F43E35D.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1081u3QcyPraHcxXKCrsUnya6bYDCxVHdqBnrYCHTbsJg3Uaa4ji1/SaSqt6?=
 =?us-ascii?Q?+BvRKsAiwGusiKW/d5UzriDJ5zx8yBpq8uQCVJatWq88cqNs33ybfB7tfMgE?=
 =?us-ascii?Q?ESNeAXOoZbCyNRw6bO1P1hm2xNx6qcXBd7YOaBAOuQeJqKh460vZ1c6PfVFs?=
 =?us-ascii?Q?/bqyvk3LtXRThV7wQr4L5gTM3Tl5STvMKrukwNoDjeg/CPdnqqP+X8xZ9AC4?=
 =?us-ascii?Q?OuvMfT+iwCYAOwsRsO15x/jn6ZQVKHIeQKUMZRdeb7GTsluodoiRfyZEINJ/?=
 =?us-ascii?Q?8P7o6qKBAdezfcS0NEcmZ2L9/wWEKGrj86RaYNkKn/qNbr6VKZS4lSUsS17m?=
 =?us-ascii?Q?6S+StW1ocL4w96YEz+2lqp6vqjL1Giyw8wiDvcjDuHDQxgrNeLG/v2Gw+CDI?=
 =?us-ascii?Q?USpaOD5r4+ngVUqjg+ENynbDWGiOX5Bozvdv5lkhGjNygvT95RuuAQo3Xa5v?=
 =?us-ascii?Q?uCCqYcgLfYiMxoJoQYdGNHvMCJfq20q26wAe6/DTpJ6GsxmnUdAZJPPhsEbV?=
 =?us-ascii?Q?2e9enXHCUlydVas8uhBMRnci7CqCXddBW5WBKJNa5kr/fEIvly9o3b5pFLrR?=
 =?us-ascii?Q?MAuTPAWzyIYQTw5tbM9NKUAp7cA0OloV/jXGzbdM79zFybzMeXe57WrJcN0U?=
 =?us-ascii?Q?XwKpwtzwgTGrDn6aKzIchTjbI3ZstuX7tHdkFjN8YYdewp/FgktDfdAmX9hH?=
 =?us-ascii?Q?gCDIDn0lVy7JF9mB8L1IX7Ch8pwHoYfWCJ/85oTRHVK7FYL3xdtqYST1/+ib?=
 =?us-ascii?Q?qHc+epuTLJZAm/sJdQtFMWdtErAj0UaSwyoaEWoXG3X5YoPgqayooM6Bnasb?=
 =?us-ascii?Q?v05qqXHwemg1oF83ZbvdeaM7SwbE6fOf+H8CBh2fAK7nm7gY8tAIGOTiHayF?=
 =?us-ascii?Q?3p191w6/pPKimCN17Rd3E8IXM9X2TfWtatmvR6Imi/Vvf5Hy2DRXQ9hLOK0+?=
 =?us-ascii?Q?4W6Ea4IrU9wo/U5QthLAL2BWfTtzbeals0YtSL9h8qMhDOcY8HymlhkwKokI?=
 =?us-ascii?Q?XyQOa4/G46zYFNWFewOO0wpPLT+dTG2l/jW415VX7LKECzbGBiDE0jDXV9BT?=
 =?us-ascii?Q?PorG9HlY4017h/6VS8bsvPmJHVBYapMyeavIlWqRnwNL2aDVLxgX7Fw7QTUc?=
 =?us-ascii?Q?6HZLI6QsQbjXnka5hEqY3TU5xDH+7ZCkdRuTuLn0XuQdtX2+LuMFm385iRf/?=
 =?us-ascii?Q?uxm1S8IAgvh6mFFn7RWVeRLGhJ/qBk8sq8Qjkm14pmTW0/HUri0GSdw5Ni6y?=
 =?us-ascii?Q?yCu5uOovpkU5yCskGZuEbXp78W8q0auszVgwRXm2uiR76R+r7UwBSg49llmb?=
 =?us-ascii?Q?COEB/lvqknwvHFlcVvc1LSnTQrAoII5mMacteTEDiZf6aIS1qc1XxK4pm+A+?=
 =?us-ascii?Q?ZkxJcTjfdIjKQWCugsA0JKKeAKhqsbrwW7++mD2FFozZaAC7BN/8CGa9itq/?=
 =?us-ascii?Q?dwWbpBL5pyjj2ICP2jDA3MpLlminkJ9hyNjTwOJX4QBQMdNlSb0KLW46PWOU?=
 =?us-ascii?Q?faWVyMrI/jDnbK0u5p3CVoUujutySHQ0Py6kvtaLEglpvgAUcaGfVtLrTR18?=
 =?us-ascii?Q?WupxJa1si+q9lXccaCIDJ1Xu16y9km1TIIeng/wiZdAR3fnkx/UMgligdS89?=
 =?us-ascii?Q?zd3h2B3+qmJSW+oIneEWmxUY6ivPYPD9u9hJfZ7dYLrrH6QqqcxXiMoeQ10J?=
 =?us-ascii?Q?Tg2OSfpk931T6/V7blvbzg0Ac9HH+gqCC9tPq6OII0S+VXHjMbYmMoADr0QC?=
 =?us-ascii?Q?BNcKzi07XQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH3PPF37F43E35DEEB407ED016EC5515CEFFC84APH3PPF37F43E35D_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF37F43E35D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae84edad-b4d4-4c9a-45e1-08de4e013247
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 15:26:57.8348 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sIp+tZ0MvwWVX6ZmZliOUL4EAqewYsvFYdl296aOsJUc+cdOTh/IHg5gLXNISEC2i+RTcaqkSVKYfZmrUxbxVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4969
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

--_000_PH3PPF37F43E35DEEB407ED016EC5515CEFFC84APH3PPF37F43E35D_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-01-06
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Agenda:
- Release Dates
- Subtrees
- Roadmaps
- LTS
- Defects
- Opens

Participants:
- Broadcom
- Intel
- Marvell
- Nvidia
- Red Hat

Release Dates
-------------

The following are the proposed working dates for 26.03:


| Date            | Milestone      | Description                    |
| --------------- | -------------- | ------------------------------ |
| 5 January 2026  | RFC/v1 patches | Proposal deadline              |
| 9 February 2026 | 26.03-rc1      | API freeze                     |
| 2 March 2026    | 26.03-rc2      | PMD features freeze            |
| 9 March 2026    | 26.03-rc3      | Builtin apps features freeze   |
| 16 March 2026   | 26.03-rc4      | Documentation ready            |
| 19 March 2026   | 26.03.0        | Release                        |

See https://core.dpdk.org/roadmap/


Subtrees
--------

- next-net
  - No update.

- next-net-intel
  - 18 patches merged, but a large enough backlog of >40 packets.

- next-net-mlx
  - No major changes in this release.

- next-broadcom
  - Some fixes.

- next-net-mvl
  - Some patches in progress.

- next-eventdev
  - Some patches in progress.

- next-baseband
  - Under review.

- next-virtio
  - Under review.

- next-crypto
  - ~ 11 patches.
  - Snow 5G.

- next-dts
  - Two doc changes that could make it in.

- main
  - Unit test work under review.
  - Series adding additional warnings and fixing
    the resulting issues.
  - Fix for GCC 16.


Other
-----
  - None.

LTS
---

See also: https://core.dpdk.org/roadmap/#stable

LTS versions ongoing/released:

- 24.11.6 - Released.
- 23.11.5 - Ongoing.
- 22.11.11 - Released.

Older releases:
- 20.11.10 - Will only be updated with CVE and critical fixes.
- 19.11.14 - Will only be updated with CVE and critical fixes.


- Distros
  - Debian 13 contains DPDK v24.11
  - Ubuntu 25.04 contains DPDK v24.11
  - Ubuntu 24.04 LTS contains DPDK v23.11
  - RHEL 9 contains DPDK 24.11

Defects
-------

- Bugzilla links, 'Bugs',  added for hosted projects
  - https://www.dpdk.org/hosted-projects/



DPDK Release Status Meetings
----------------------------

The DPDK Release Status Meeting is intended for DPDK Committers to discuss =
the
status of the master tree and sub-trees, and for project managers to track
progress or milestone dates.

The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK

You don't need an invite to join the meeting but if you want a calendar rem=
inder just
send an email to "John McNamara <john.mcnamara@intel.com>" for the invite.


--_000_PH3PPF37F43E35DEEB407ED016EC5515CEFFC84APH3PPF37F43E35D_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Consolas;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-IE" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release status =
meeting minutes 2026-01-06<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Agenda:<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Release Dates=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Subtrees<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Roadmaps<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- LTS<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Defects<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Opens<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Participants:<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Broadcom<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Intel<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Marvell<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Nvidia<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Red Hat<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release Dates<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------------<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The following a=
re the proposed working dates for 26.03:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| Date&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Milestone&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; | Description&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; |<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| -------------=
-- | -------------- | ------------------------------ |<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| 5 January 202=
6&nbsp; | RFC/v1 patches | Proposal deadline&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| 9 February 20=
26 | 26.03-rc1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | API freeze&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| 2 March 2026&=
nbsp;&nbsp;&nbsp; | 26.03-rc2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | PMD features =
freeze&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| 9 March 2026&=
nbsp;&nbsp;&nbsp; | 26.03-rc3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Builtin apps =
features freeze&nbsp;&nbsp; |<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| 16 March 2026=
&nbsp;&nbsp; | 26.03-rc4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Documentation read=
y&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| 19 March 2026=
&nbsp;&nbsp; | 26.03.0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Release&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See https://cor=
e.dpdk.org/roadmap/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Subtrees<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">--------<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - No upd=
ate.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - 18 pat=
ches merged, but a large enough backlog of &gt;40 packets.<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - No maj=
or changes in this release.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-broadcom=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Some f=
ixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Some p=
atches in progress.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Some p=
atches in progress.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Under =
review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Under =
review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - ~ 11 p=
atches.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Snow 5=
G.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Two do=
c changes that could make it in.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Unit t=
est work under review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Series=
 adding additional warnings and fixing<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; the resulting issues.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Fix fo=
r GCC 16.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Other<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-----<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - None.<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">LTS<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See also: https=
://core.dpdk.org/roadmap/#stable<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">LTS versions on=
going/released:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 24.11.6 - Rel=
eased.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 23.11.5 - Ong=
oing.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 22.11.11 - Re=
leased.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Older releases:=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 20.11.10 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 19.11.14 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Distros<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Debian=
 13 contains DPDK v24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Ubuntu=
 25.04 contains DPDK v24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Ubuntu=
 24.04 LTS contains DPDK v23.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - RHEL 9=
 contains DPDK 24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Defects<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Bugzilla link=
s, 'Bugs',&nbsp; added for hosted projects<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - https:=
//www.dpdk.org/hosted-projects/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">DPDK Release St=
atus Meetings<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---------------=
-------------<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The DPDK Releas=
e Status Meeting is intended for DPDK Committers to discuss the<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">status of the m=
aster tree and sub-trees, and for project managers to track<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">progress or mil=
estone dates.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The meeting occ=
urs on every Tuesday at 14:30 DST over Jitsi on https://meet.jit.si/DPDK<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">You don't need =
an invite to join the meeting but if you want a calendar reminder just<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">send an email t=
o &quot;John McNamara &lt;john.mcnamara@intel.com&gt;&quot; for the invite.=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
</div>
</body>
</html>

--_000_PH3PPF37F43E35DEEB407ED016EC5515CEFFC84APH3PPF37F43E35D_--
