Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7BBCD98ED
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 10:14:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C4234042C;
	Thu, 18 Jun 2026 12:14:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 5433E40268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 12:14:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781777648; x=1813313648;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8Sdl+5zO97rjFDJ4s/MluD21+6M+5ZPAVmqtaTpIHEo=;
 b=G3U2G5wMhkudEUe/p1AN0bShlNcqAayvmLrmOhY5etAPyNLWhkAtyXss
 cdVMLmsw+5Mrj+gOJVSuPtOaBr17E3657Q2CJ7agyKV274lO/hGqJgzEG
 LFbbxXb0BA+m18QSM/fu/D+N7NbgTeFZ+G1bE18Ohl7nFPJ27jUzPcsCX
 6e0tLz/0Bk6feeHnS06rt1wAwRnO6v+JM+q7rgcgQlwwx16AcVqrQ911N
 thr8NFWRKItZH49YP2gU3cOyjQOogSHgXdmmL6suZWHD/NiWOXBcB8Gyc
 1U0fBaGGHd1fpkckYbAS5kqFWR9OBEFnLO5Ihnk+JTeK0OTT/BfJ1bhP5 g==;
X-CSE-ConnectionGUID: MwVNiDfZT3qJ7DO9iyVt7w==
X-CSE-MsgGUID: m8FgmAopSqCq0ZV+KHqxCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82610663"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="82610663"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 03:14:07 -0700
X-CSE-ConnectionGUID: hTefDJ2SS9q8jGAee7MvJA==
X-CSE-MsgGUID: U4oDsNI/QTK8YvNspw9alg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="248393255"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 03:14:08 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 03:14:06 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 18 Jun 2026 03:14:06 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 03:14:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hh35N3Aw1aj44gpLN6sKRtGMA22Ncp5Sy5r2aie7sy2cKG97Ecc3yBtHgNE9oZ44GePO93e7cOVZuZB3+7Vqu3LMcRvAdGiqCmH5lP37SQC3CCmMuR3vc6tyT6QMWbhoX+0Fs5ho8eyv78om43cxwvHOQMU1F50rwZ/KSznIBxia7xWsjfbXxdieiukoWgChTx0Qz29HXU5s5kp/N7zkYdzWOOKJcszSNRisKogjS6glnE8l3gL/Iae2sYdxPshrrqEsPuOZUIEbOnt1dfSyNu6SEU7qOaJFiqsQO8eypnWdxNqQBOd5CRdC54pRmPCM2llILFGlo9SHTOn6qxQkQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Sdl+5zO97rjFDJ4s/MluD21+6M+5ZPAVmqtaTpIHEo=;
 b=Kmwo8DRLboyga+GpBeaHoaqIgkh4e022Vcp4e0todQoVr5tvlMPy3jYH6qZ+qYqmx9S1oBuAuglFaZbxyeS+NLWmCu3R7hV4fJgb4zZEvjMA1ajB/7iwMJheFRnUoLWJXnhoIxY4A9m0Yq5rwZFtSwyhfnwCure2LLrabrCDDJZ7BmdtRD6GRSG1J/XljDx0Rw336K44XWhdKdCb5ZwOFarv8C3ivOwJKUlYhnbyj2JpGv1bEK5drj8anHJpoWPRgF0rEjGQ8GxNVL/txAibNmLRE8qZEWDje8VHf9t6tPQQSJjZbmjDtUuzNPg+i45eFO25NCpJU3rONLOdudB8UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5527.namprd11.prod.outlook.com (2603:10b6:208:317::10)
 by CHAPR11MB9656.namprd11.prod.outlook.com (2603:10b6:610:2fe::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 10:14:05 +0000
Received: from BL1PR11MB5527.namprd11.prod.outlook.com
 ([fe80::a41b:abbc:18a1:fb78]) by BL1PR11MB5527.namprd11.prod.outlook.com
 ([fe80::a41b:abbc:18a1:fb78%4]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 10:14:05 +0000
From: "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "paul.elliott@arm.com" <paul.elliott@arm.com>,
 "Shebu.VargheseKuriakose@arm.com" <Shebu.VargheseKuriakose@arm.com>,
 "Kantecki, Tomasz" <tomasz.kantecki@intel.com>, "Islam.Ragimov@arm.com"
 <Islam.Ragimov@arm.com>, "Gowtham.SureshKumar@arm.com"
 <Gowtham.SureshKumar@arm.com>, "Finn, Emma" <emma.finn@intel.com>, "Cornu,
 Marcel D" <marcel.d.cornu@intel.com>, "gakhil@marvell.com"
 <gakhil@marvell.com>, "Mcnamara, John" <john.mcnamara@intel.com>,
 "Jonathan.Wright@arm.com" <Jonathan.Wright@arm.com>, "Dhruv.Tripathi@arm.com"
 <Dhruv.Tripathi@arm.com>, "wathsala.vithanage@arm.com"
 <wathsala.vithanage@arm.com>, "Ji, Kai" <kai.ji@intel.com>
Subject: RE: [PATCH 2/2] crypto/ipsec_mb: remove ZUC and SNOW 3G drivers from
 x86 build
Thread-Topic: [PATCH 2/2] crypto/ipsec_mb: remove ZUC and SNOW 3G drivers from
 x86 build
Thread-Index: AQHc8ztCGAWOVsWZIECJuVABCOlRq7ZEL82Q
Date: Thu, 18 Jun 2026 10:14:05 +0000
Message-ID: <BL1PR11MB5527316211FED14C5246A81E84E32@BL1PR11MB5527.namprd11.prod.outlook.com>
References: <20260603092736.664428-1-radu.nicolau@intel.com>
 <20260603092736.664428-2-radu.nicolau@intel.com>
In-Reply-To: <20260603092736.664428-2-radu.nicolau@intel.com>
Accept-Language: en-US, en-IE, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5527:EE_|CHAPR11MB9656:EE_
x-ms-office365-filtering-correlation-id: 6677c85d-de8b-40c2-e0e7-08decd2253c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|11063799006|56012099006|6133799003|18002099003|22082099003|4143699003|38070700021;
x-microsoft-antispam-message-info: rLhsDVvOJNxGagjC+Gsv9zdROnKOTE2jzdySSzB4Ct3iVuvLJHcGJSE1BZV7qHWv8Y6EC5RrZxj/RVp9F5FcjwZH5IHgiWTtAZO0t17wiqYn9Cf1DMGquiWY+wjF7BP2kG9pn1EPlFAIB26SDP3S2zt0K8Uwa4qqvhfdh9McXh9NuhLZzf40EfXuztTA19tXYcdLcCUqWDmshl28WCWxPNLNDX1/nTNqSEyDMus/HlgAW2dpu5CQsLYoVLbmg9KdMNdhRTzQip6sX/axHKRSDiulHGfIaOJvnUq3/ZrnwN70ns5xd/qUFJM1lq8tnrl4Va1jBYvPgBDsuyWWrP9ApX25gbk3OQ/UkE+oE1Rb/YDZsDjep4UoAbJYvRQTvXBMQcKVj5mHyInJ5jOfJIhrmRIbCwoRLpXoCtBd6QQJU6ZDSzE0zuYxzt14SoltS2aJkdv5WRUwwMknzNgL+oeclI/c/w6zYX+ct04Qx1cZgJ2GU5t5B6m/DfZydSqD36B37/zvPjr2/Bqk0JAKY5tKk7cbpi0LEbCwQbFrmc+fvQ/PwYvNsl/8xh66uHLix0ZmdctvPvj6UkdkzNAo51Nu/+PT5oWt3LAto2U9d3U0zwzTYf0qOa9Pvem2tyUzmrc7Y0X0kDGk2ALlEZiUk6vfoMxP1FvVexnGEnr84V6PN1mvPCwVntdtFMRH3FioiXkaOYNwGkM8fZBMdzbMTraGGtzKgf+yYGPqrs2+PtuqkfDNy1RyjqIv4HGOCMY5ln47
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5527.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JtUPOeuwFBMWvKFAFa4JKUNsjNC7mbSjR8rHqwqGstO1w/1pgvjUprO7ffpp?=
 =?us-ascii?Q?4T3vNvscPc/soR78EtVHVbEo1UCKAMBRPHBQejXBtPzJ7nAQtOAh+3mFimq4?=
 =?us-ascii?Q?vlFR5L5W6Q3qintN1O1xdYUl3tQUAhGXzSgKOHRdcvcPRVGvIo1DyYGFxtzS?=
 =?us-ascii?Q?E2aCFQaG02ZeM8Ef21hqk05nIhiE8Pb4CUzw1Rv5xWUhHFlP3Fi3HD0KoZT6?=
 =?us-ascii?Q?ZGgp26hyoNRLHDRh5l3PTy7IdsrGrbpr0LzWpCLuAqCJuop9YH3U4lW72ArD?=
 =?us-ascii?Q?MaeUvvh3yxPq2HwqQ+97116p9+8IIg0JfsfaoQu8Kakpwcog0jWf0Ied1HtI?=
 =?us-ascii?Q?1Ae7lp76+DRCu+H4JVDNcbchEzQHfkJlhkDIzz9zIYn1i/wS9SzMuUE30DDv?=
 =?us-ascii?Q?eOiSMpv2t0glmjZ1uGRXJvAJu/Bd395yzp09E/agtEhig0vqAWr0r2lwEzyN?=
 =?us-ascii?Q?Wj9x9DRJIJ5JH/7cd7g2alcSTEmsJmW5QGHoU1Bk7keLp3YDbuCAeSDtK91U?=
 =?us-ascii?Q?pYhvaFHSfkjIVPLECX7iYpX1LUaJfpIgVwRLmSV8X2//A8RfnpgT3SskQUoP?=
 =?us-ascii?Q?10lisMJ3LT+XqegCVOUINEMMk6XeyzfHafWmDFJyONvNczfbcRsJbNOW8Lh7?=
 =?us-ascii?Q?a3hnsNJJOqtqhVa09qF2pBsBR8hnKP1otBxLRnekM+0LllTAa9E01D7isEDI?=
 =?us-ascii?Q?R8y9bjj3koefWPGm7iNMxb+xz7/0cGq5/8FGkWHRRVgF8CmetEvFKSvc1Pbx?=
 =?us-ascii?Q?RPSajOTel0tAhLs/TZAQXa0NPMsmNHBWSZitza2zqIhYpcYyvmWeAS+aD6ed?=
 =?us-ascii?Q?xYxuTTDsn99ialN5LEsa7cxcjkHMlRktb0wcsVgpP4MjOrJoPOp2TrSVUwLB?=
 =?us-ascii?Q?cQtgviAB3z6kpqJwL8zcHKd6P/2ex1MMyEQOI4hnHrInxpSwkUF4eEh4RFc7?=
 =?us-ascii?Q?alGPncHLXAA2ovWTja9a+E64CQvw4yayqxy72HlaScD+fxzURIFnwYHJ3rrI?=
 =?us-ascii?Q?nPaQQYDlMvUFSnQzvk5k/GJ7ZWkQ+SeCR8a53ejmDveYuk6wphURALZcSY9z?=
 =?us-ascii?Q?NpnmFQQTCz7q/JUYmTcGEZYPd13H7uafsKSa6hFMALYToxb2DVMbvWAcGj9T?=
 =?us-ascii?Q?/t/Lf2mF9Y4fwFzAXf13FIpW8NfOpqAwKYIKY+X7jG/TF2OEoKPCAjpXA4Mc?=
 =?us-ascii?Q?oGGl0IRfhjT87Wlx0Am7RNx/L06ex24RUI9j5iCjoTEfaQAkt/fdGVtpqkTf?=
 =?us-ascii?Q?9KpNzQaMokDlSMHpa1EMNw9C3OD7xmcfRf76Hha/dXvfe/SGL54jufeT5vpc?=
 =?us-ascii?Q?ldUXryMuUYDiUwLmdUocPZbz7uttoFQ7dEOjYXl5w/oX/R3r868Tfs4cxUR3?=
 =?us-ascii?Q?rcRiP31ANEa/ULSV4pdkGR5HTciqA4E88SK/VfuGPnCo6v1oUH0PVFOUAYlg?=
 =?us-ascii?Q?d/Bh/z5Kqxd3YUghwwLEYwKJRZ9Y7I3l94uVdrpo3IS6I+zP26hAR9W+ieTR?=
 =?us-ascii?Q?56gSm0qp28ZDDCa9AGp0pgZUXGd0D5TcGjni6tzuWknxls+EfvjpnkAY9ji7?=
 =?us-ascii?Q?LCPz7tIXi4HhFpTDvZ05gFgfgJGbYnKC7Unfn9lBmQGyATfK9+tzyweJhoj9?=
 =?us-ascii?Q?ZTU6vx8pTnvmonCiiXaUcnogeamtw57tYDo7qhNExpbKgOWsP0uhnYeJ4Ak3?=
 =?us-ascii?Q?mUAZyNTM9aoJWCScCuMZLsNMrZK+0y5hYxjr8YgM3ZarWEgmVlqP5dli9pIG?=
 =?us-ascii?Q?EBzHFkPNUvUtsx55qnF88NA3RLwaaMY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZhbIsGETmTXzRPBLw3Z9sS0CyZxpcY1VSjD98WE/zo3No1rrXScBkSCqT+yHLuzqICslfFXpIrZlLU121xc3kGWzeEqImzmNkZmqv+yNPajfNof+RxDmXyNwZdZselz9eRFwtPY6Z2OYd43xlgX/GXO/HJlsKeoQe/6mCdkw6k+jazXutJMGsNs/a1dvqCdg8zhdPkJH+V7wIsV8sEQlGD6gF9+drPfqsaDh+DA7XF+jBLT+pJHLjRDja8n1tyUVzd/I+ypPd0NlIXfm8eb6nsD8klQC2/nBYbu5rmI9DZsrJaGBRT8BK5JsSno0p5Knvnvl6oTkyx/Z9qPbpZSczQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6677c85d-de8b-40c2-e0e7-08decd2253c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 10:14:05.0880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M9a+vB/ucfpkItOwiHJfpXGlp6GcSpxXyE3YHo1UCll7F0m6wFva0vYGpOfbVsqhuT5zd+9iZlEy23VgveKlp68StrBt50zYyX5fxau4bqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR11MB9656
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
> From: Nicolau, Radu <radu.nicolau@intel.com>
> Sent: Wednesday, June 3, 2026 10:28 AM
> To: dev@dpdk.org
> Cc: paul.elliott@arm.com; Shebu.VargheseKuriakose@arm.com; Kantecki,
> Tomasz <tomasz.kantecki@intel.com>; Islam.Ragimov@arm.com;
> Gowtham.SureshKumar@arm.com; Finn, Emma <emma.finn@intel.com>;
> Cornu, Marcel D <marcel.d.cornu@intel.com>; gakhil@marvell.com;
> Mcnamara, John <john.mcnamara@intel.com>; Jonathan.Wright@arm.com;
> Dhruv.Tripathi@arm.com; wathsala.vithanage@arm.com; Nicolau, Radu
> <radu.nicolau@intel.com>; Ji, Kai <kai.ji@intel.com>; De Lara Guarch, Pab=
lo
> <pablo.de.lara.guarch@intel.com>
> Subject: [PATCH 2/2] crypto/ipsec_mb: remove ZUC and SNOW 3G drivers
> from x86 build
>=20
> The ZUC and SNOW 3G crypto drivers are using APIs that are now
> deprecated in the Intel IPsec Multi-Buffer library.
>=20
> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
> ---
Acked-by: Pablo de Lara <pablo.de.lara.guarch@intel.com>
