Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E06C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 03:00:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3895E402C3;
	Mon,  6 Jul 2026 05:00:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 026534021E
 for <dev@dpdk.org>; Mon,  6 Jul 2026 05:00:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783306836; x=1814842836;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iVXgu3vEBGciUyn233DKZ3EeSabo5qZoges05/Oaang=;
 b=D8IFJRD1aBBRgb1XceAYO4kPjb72p/NTHe4BM/9yxN+u7mmqhSrCg6mM
 IBliEBnikp2rJy16kCknrWRWBS4+LsE3YtfyQFnGAqyVNiiWhoRh3VPSi
 e22e42Lzgfsb+4FSu/IzVjTP92AiWenPT0x59ap5WgtFPqljcVLBya0Z4
 emYFFXDR7sSNGNf/qkKdkK01lus2LGa+UxXKQqhKYJhU3+ezWPmL3Oo0d
 nAqbAbj+ZocsD4mlJtP086Ly2O7+LrXIIWojWNni2za31x5FCwgqVUZ4b
 ITxm/ySLa1v8wml0gS6fYsK/o9XExA0rDpVSj1KrnthI8knhxniIsppqN Q==;
X-CSE-ConnectionGUID: gf+G/Wj/RfKixkgJD+iPYw==
X-CSE-MsgGUID: 0KqPKUFISBa9Os/aNopcoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="95311240"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="95311240"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2026 20:00:34 -0700
X-CSE-ConnectionGUID: dIoWiWs7Rn2OBb5buwk6Ow==
X-CSE-MsgGUID: zkOd3ps+QZuLuQTSfTBu/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="250922592"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2026 20:00:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 5 Jul 2026 20:00:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 5 Jul 2026 20:00:33 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 5 Jul 2026 20:00:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yr4gLfsVJcIjG/1h0ZHWIP28Zz5L2E2bcxjooxhelKxocHh5sd7Pi3TB5ksFrMOFN1cpNlqBq6654IoopluHuT0DQ2ZJSSmsdV8YtwUbfcLT0oBJZOKRz5ZX2u3KPsSmJyfRsdgumtxYRGifnO2o4x4fe1pVAGxVRuPdP2WJ117wpHww4QVjM72E+h9mSSGVSqIi9kPXHnzNXt0ZKDzvjsPBIdeaip1uMmMoWA+8wAp8RMRUVLzA80DHbwKnbpK4WIf1D+6ivMFu1P1D5qNzGgkOUNB2XGdzHI6T9cFzgCZbAUNo9K1bhjn+aPOsoEKNQPoisDWEqw1tjvA39zgOqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHKui/2dYK8xcA7JHHYN2jOhW24kg2CvO3UTGYq9avY=;
 b=L6yHrpA9TNiD8tE5etXpLz/BqqfMMaCzopcBhvrztuAdgTx8jyV5THgClvtbJbHUf12NzkZz9k8IUZo/JM27tbgGWjSRkzYsOGGtIJR67NG1kHdJzVKwzZhL4yQuELj1A3Q46qQ7j8C6SKNP/ogbhDG0+2nbf25Lmn2B9rlS9mgfgRk/z0VKIUVoKP7ebnt1QZAwDCZRKNROIdoCY4jF0vfpSaXJLMq5vvatnq14fHzc/S8GlUtdgHyR00kGbwHJk9Q0g3bZsfAsj1qaXEbnUQEIEE8A5xUoppdX/V0rQ/k+UoNZghlggdk+dUBcEtzZ0cL5T9qojsl2751DFLHcYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB8336.namprd11.prod.outlook.com (2603:10b6:208:490::22)
 by CYXPR11MB8755.namprd11.prod.outlook.com (2603:10b6:930:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 03:00:30 +0000
Received: from IA0PR11MB8336.namprd11.prod.outlook.com
 ([fe80::7cba:57f1:37d7:723c]) by IA0PR11MB8336.namprd11.prod.outlook.com
 ([fe80::7cba:57f1:37d7:723c%3]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 03:00:29 +0000
From: "Jiang, YuX" <yux.jiang@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "Nicolau, Radu"
 <radu.nicolau@intel.com>, "jianjay.zhou@huawei.com"
 <jianjay.zhou@huawei.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: RE: [PATCH] crypto/virtio: cookies are allocated from mempool
Thread-Topic: [PATCH] crypto/virtio: cookies are allocated from mempool
Thread-Index: AQHdCvtLWUsdaWhW+Em9EK9qgikmALZf0QGQ
Date: Mon, 6 Jul 2026 03:00:29 +0000
Message-ID: <IA0PR11MB833694E8E66E452D61D5BB3FFEF12@IA0PR11MB8336.namprd11.prod.outlook.com>
References: <20260703144931.2541180-1-radu.nicolau@intel.com>
In-Reply-To: <20260703144931.2541180-1-radu.nicolau@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB8336:EE_|CYXPR11MB8755:EE_
x-ms-office365-filtering-correlation-id: e8e83bd4-0d45-449e-a297-08dedb0abcde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|6133799003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: fdgGvO/eFugN8Y2v5a5nCg7oGVg0YWgfrm5/U7AC7I9XFJIuQz/71LrwcfDHkJei0HSmRJ2Az5BBtVL1weXDgBrNEOCZUDkfp2X/zvw6QNSn+cbRn/p/1AEoUhlI2rDFLamFinXdN2v2sIK1liYrJG6uYmVmPJb/mV90CbaYultQlaEdkGEHFg6V21Q3wKyrVNwBYoyys4Dt5s7+KQtjHAdRzs7MIy7iUpurd7a0nCkB7l0Qtw42MG8ErbfhN14rwLvkJ+YwehEnib0OQm4K1rAUBPCX4KyEDrFIS99LPoSybGwU62KIVtcZBInRcQNrLmmY6go3M72dwJoFOmJQWRboMszg5sW2nKKHlnLlYnA6UXrldi+AWgNHeymr/xK3Dex8e668Cy4OIbyT/m9gkijzK9P2zSOdDxrVKGwas+2ygSioph410sbBVl2Gze1bxjzum1Torpu1Wdqql0K6KpwdQ0jLa+J+YTTnB0yZaCv5bUVwt/Xaxq59IcdPQb9FzcS8duEJ/6a+VBap2Q2UAa5tqNWg5MiXOguouWLp7fXfLSPHP21e9kqF3DP9EXfJE48PoBjNWNpmk5l6lUEKHnxLHwu6QmCMdDlQJ8V6QszdIwGpMx10+EX3sGjG7yGcb9ZhdWhYGUXstXwAIdEOAh9Idig4tat5o+mqy6EXET5AypsSFYnDO8ptSceQ3L/SXOt2t3FgyXTRj8V6bJ6LYixbO0jZlh6JIR8Prg+uxNg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB8336.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?twvIt4/C5cPDRurecBj0ooclLnkTzacRS9E9oCx55XLyJVCu9rIkkipi+sq3?=
 =?us-ascii?Q?z21R5XAdEYdKUO/mRFYVxx8l3f23n1j8pFE2CH+PLzmbeA7nKQta1nOoRMfy?=
 =?us-ascii?Q?9prGOYGnf52xCGHkcW2iNVT46bSDAGgqUbt0Wyx4dkuycHtgyK9zjnekRq+u?=
 =?us-ascii?Q?+TwBKnlNAsvpdD1a6PM/KI9bJw2HSNKFQ+2kZDySyXILJawG1Bku65waiZ5q?=
 =?us-ascii?Q?kkdd+FmVsfqQdVOnAPHkNY4hXtVWZxWEOThH2TxQVelR2X85lMs+tlnQ6wpa?=
 =?us-ascii?Q?KkMOV/cQAfanEkKlXng2mpNc0PpVjy1lVt99hqJampthxXP5CcFLyTZ0aakx?=
 =?us-ascii?Q?DR/FF+/amLhG+0eO6MocQyAXyLZBzPooxvp7YnJOEaNDLm7o0J4spV2KASC6?=
 =?us-ascii?Q?ZqvMi96yilbBKt4ueGmJVDmkTL4CJNuOwYAfHocI1ld74ScO/BolS0ny0p/F?=
 =?us-ascii?Q?Hrk+ZPBvovKd7zSg3kEifn/OT4mdfsU8IYdVZXroaQtzCWHW9tbjyQ2tbSVr?=
 =?us-ascii?Q?OQMEyXxWDySaPRF9SWgLd3WnCORG73HTVtcpoULe5mDmttzqgtnveiIigVDc?=
 =?us-ascii?Q?+fScJZfy7ESJs1ECzEHD9GMJxwocXvctSZKSsIeha24daK3LUL+vpXACfkex?=
 =?us-ascii?Q?WD51kA5jn2aNXutCb/mEw60i1uWGs3qNAU6rWBAGAQMs0nitlbNQ9ptnFd6q?=
 =?us-ascii?Q?jBaEm6RnRiv0WCMsaDPB1xk+tJWMuatyEgzjrvIUqpHk+lptBUeFoNT2mgQv?=
 =?us-ascii?Q?OEoB9JnVTnt8tspa51FG/XG9Wm/mhaOdpH4KBhsRYEU+HyEyZTTokzFMYfr1?=
 =?us-ascii?Q?9ATw09guqrWL878zyEKRoS2hrAgj6lz85Fxf0Q9MzHrCvGY2rc7z9imM3+QG?=
 =?us-ascii?Q?2nXGpOP11bzy93R9fksY4B992GAEz2mEZImZQhfhzMjsDmAs9z+x/8icZeFZ?=
 =?us-ascii?Q?EG+XfmV9+2Ma6xCmdxxHcT04JtWy3j4D0MLtwnE/u6ByiA31EvG2BE0oqFJY?=
 =?us-ascii?Q?Cwmnx+rzqiUiITQH0LBoOUDMtb1nihbBkjTFOxM/+sZrl6uUoEs3yRlN2yDo?=
 =?us-ascii?Q?1EASJxOSOT49Z/wLQ7adeM7lRaTLSmYnnFEAEVOru3X/VvKF1S8dL03H4GbV?=
 =?us-ascii?Q?Us2xYPySrJRpo2vhuw4l6C/QGgORgTG7bel4Q+36Z6b3WupJcjCpk1NBW8fb?=
 =?us-ascii?Q?iOL5Qy/7JeXuaWU1nZerYqruihfDmTXmUjyXNaqzE6T3XJcXmQi7FT7tF0sm?=
 =?us-ascii?Q?QeVj6ZRzhVivhczusV/BhVcfT8EpLaMi46GM5nG/bO5MxcEbhfX2sRHyWNjY?=
 =?us-ascii?Q?8KzPNEt8r1LBEDI15Dmvarz+zj7BGkboAwyPKD/NXyRoABkgI4WHLTi6t481?=
 =?us-ascii?Q?hvdLBF7wH9FZqCIUpaFW/7Iz8T7+JTXx3akQItqL+A3e5s++MUG+gW5QqSUT?=
 =?us-ascii?Q?394e+fCWcOQDhNkw2mk3fTx0Y715dStmKcpAUmkViWG9u+SstP+PkQ5vtgTs?=
 =?us-ascii?Q?cl4ZH2rJlqoBXvftMz9pmBxpGmezM1cWU9KXHmJvvK3/FMy3m4azGqkb069u?=
 =?us-ascii?Q?uvz0KZhSR++Ve1nEcsLDlDs1na5E+Om+SuHHDx/eMa6L/cpNCqzTO7rqJhGn?=
 =?us-ascii?Q?OUrYG6niGAnhvhadxWbsr7CZdQQpn0l3XGhY2OQ0nymc5qzHvSZr2VONyPyv?=
 =?us-ascii?Q?Z4hh3PH/xFrmyMpzyRd6j0mxePoyhYAuw7TIHfoECjOpLN8n?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fh2ZkfMtcbORTWTvbBLY8yhe5h3DH94F2Zzus8p+JDhnl6gsgC8B1ytKX6pkerqtdYQSBtuOZl+bbmFfX6xMOGQxLv8M6Q/l9yb4D+qhEZRUidhgzLc6obGWoieazBKARyt9NCtUu9kObYZNqa2QoyrimIsl07jgeJ3bM9kLIz+hKzyZK7BZ0MfOxwcBgKxckZIavXCKVr56NU8DgAwMobU8MnhK47LtPE8fZZO8bggrcD1KvQq3EmemL64WkAjfmWzouAW74rs7YngF2y/io5bVFdpcsLpU+3+9pSglGcO43GAiypEhHBIWOt2rFb+RdbzVqcvNDbNjKxh/09q/Iw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8336.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e83bd4-0d45-449e-a297-08dedb0abcde
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 03:00:29.7913 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w0lqwmq+NAAcNubYXAMQ0RB+ps300rI4G2RV/bjpYUwkEG1tNqKHDY2lNUoO1zAwNrnV1SqIMAiJkAk0spcOgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8755
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
> From: Radu Nicolau <radu.nicolau@intel.com>
> Sent: Friday, July 3, 2026 10:50 PM
> To: dev@dpdk.org
> Cc: maxime.coquelin@redhat.com; Nicolau, Radu <radu.nicolau@intel.com>;
> jianjay.zhou@huawei.com; Fan Zhang <fanzhang.oss@gmail.com>
> Subject: [PATCH] crypto/virtio: cookies are allocated from mempool
>=20
> The Rx/Tx functions allocate cookies as needed, no need to allocate and f=
ree from
> heap.
>=20
> Fixes: 6f0175ff53e0 ("crypto/virtio: support basic PMD ops")
> Cc: jianjay.zhou@huawei.com
>=20
> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
> ---
>  drivers/crypto/virtio/virtio_cryptodev.c | 24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)
>=20

Tested-by: Yu Jiang <yux.jiang@intel.com>

Best Regards
Yu Jiang
