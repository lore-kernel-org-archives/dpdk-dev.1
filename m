Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C762ECC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:42:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 249184064C;
	Thu, 15 Oct 2026 16:42:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 90AC7402E7
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:42:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792075371; x=1823611371;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=oYLYX4UMbYC/tIzV4jf5w06PilkiyPRHk6TzLbdQv0U=;
 b=ChPOFHvqXGEbH2avNa9G4k7/izWz9AH9I2sp52xU8sLbzsCjf5LKFa9t
 NMUepgg25x1E+CirKPYcRLsw2iySHb1VI1ahUBJIvEr+XHzZeufLytFKu
 6glREpiBZHZ08Dnov9nSoUGc94uweUwyz/Z7Klt2RLoVZnWUqpqg0g5vm
 yJuJIBgxPXmtnGo/SoUtAzsZUKzIg6eujnpDZKoUBHXO0R4Im4bOOf7WH
 D6ucK/J58P29fvu8x7IUV0V5yiiHRUodzaIm49QqaMdDfINJ9KKOxxlfk
 Vwu/h0QroU4L/xH64Q2MB0UeDUJtx2Yse6YY4fRSD3JcvbuLP3eGaaIrc Q==;
X-CSE-ConnectionGUID: 8j8iqV55S1WwlU7m4dGstw==
X-CSE-MsgGUID: Avtz4ai/QpCYlZpUZCdaRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="879683"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; d="scan'208,217";a="879683"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:42:50 -0700
X-CSE-ConnectionGUID: BMnza7TjQhG4wGv0OoydfA==
X-CSE-MsgGUID: PN4mRDo8Ti2xMHAvM6gl8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; d="scan'208,217";a="1622788"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:42:51 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:42:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:42:50 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.17) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:42:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmiUM4+QNyTvV0EWG1ldICvgSYqbC+xPuPeNUQXSsoHqtC2qg5yVb5NrKVehNHT0DVBna6V6CbkoBFpNAcKz4sKwVLps4fnCGTsozQu3fELw6vUBb0H/eG1LOjwgERIlsFP9KdcrFEONsK8gHTszQP20CiU7Bf4bgozNOxT1B0UCEVjXE+U8nmIM/vIbZ4UWurRwJis//AMjuYcvS492mYybd4mAJdsaA9eiJgWt9GJ0HRyMFJVdLjkh7JiggK/jlXEOr/Sl9ywwEisbZ7DWB4OKKQpKcis8hH4+HAXn+uK8QnjUnyq5RRiULlN01WTOXZVJmJn9GsTZR7qXt3Ys8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Pz4HwrK3+dyEmG22Gzg1eH/jK5v3n5DhEyHTN+Yp5o=;
 b=CgI1dUPz5aerEPF4dl04C50C2SX7ex1swLp9KL+xo17lhGzCttSBgnsiJV2rr3ELD1IT+qWQp1ehAqFkFT4lW4/mVl2f39pKH4tC0ef1kReA1yAuowD79NENsRGzH2TjSScjbwifczcI97zeOFQxLZRuFPHGizjAyBzImD1x9bWkcuO39TFyR/Gpr2DzdFCECVLg0shPg1lid6/hwetixtUNMpJG2Nv6Yhyapd1zit/OKz3V7hmn6GY0UKKkJgqu/U4BSGDH/1Qdt/efKXXNpHwWyw5mMhqa4j6hlva81vc9UXjJQ4rG35g93CecMzIs2G1b2AaHHzTam8/j+gZ09Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20)
 by SJ0PR11MB4958.namprd11.prod.outlook.com (2603:10b6:a03:2ae::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 14:42:43 +0000
Received: from LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae]) by LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 14:42:43 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Finn, Emma" <emma.finn@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v2 0/2] crypto/ipsec_mb: Add SHA3 and SHAKE support
Thread-Topic: [PATCH v2 0/2] crypto/ipsec_mb: Add SHA3 and SHAKE support
Thread-Index: AQHdWiSuqtRuFZjHf0Sv4D0o1XJQsbb+snIQ
Date: Thu, 15 Oct 2026 14:42:42 +0000
Message-ID: <LV2PR11MB6045094D24E940BF9DD37F90819C2@LV2PR11MB6045.namprd11.prod.outlook.com>
References: <20261005123041.429121-1-emma.finn@intel.com>
 <20261012083506.754857-1-emma.finn@intel.com>
In-Reply-To: <20261012083506.754857-1-emma.finn@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6045:EE_|SJ0PR11MB4958:EE_
x-ms-office365-filtering-correlation-id: d3f15777-fe6e-41c3-f5ca-08df2aca91f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|366016|10070799003|376014|23010399003|18002099003|8096899003|10067099003|22082099003|4143699003|11063799006|261009223027099003|56012099006|38070700021;
x-microsoft-antispam-message-info: 0icsm0VmPW2sQpciqX6rfLyBced9X3+OzxAA9OHfLXSuVIBiUXwLLjECrV4CWX0IuLdQUkdb/TUpbGnLSu4ScVDXN2cJI1Z/zjSUHor59G9pSnvMnoNeMPC0lsebKcxVdDPjAOqI+DpQqGKgMQoUqmqTXt2ZVznCBWlzKOKKmPLkZtGYtC/BsFMuL5kY6EnOUqAIuHZVkjYT5NRps0HW7mQdcaJA/qrnL9pzJVkoCaXyPccRZNbnpey0p0KY93CrEPXe8rCkN2THNnSg2Mi29EvdvZ14qs+WEaMJjKScrO/jwyHP97Yt+CCSV768RQmFAWTDizxPa6U7j87n+8DPDj7P+b7IhlbIpPzFyrA8JB5uufiunpxCKXWnoC8c+Kwn38K98UfICk/0DXa8wLd1Q6I9uuguF3zrjvgZOnVyE2EhpCb85wPxqemrDeOktQrCfO7rVoXOWY3vuPDbiLF4TFp8/eEa8r+mtXcSjrNTXDd56cyC9gb1+RNH4iW6wN9J6H/cxv9cunYzwnIZGP/TeJiLBMKZ2emdmDx80o56zZi0mJHCCUnalBIzqrBOHibK5F7bnSi64X7MrxFhuzBlgZj3g5N1jEEvLWC1oX8Bh0j7+LLkGsVI6ynpcvTg5wcbWrjdR3+9CeTJXLtaK3p8VOc8ODCEZ0thJD3aMQkv9nBZ1c4Y+J7AWn1/dYgorK0uJ4SxbHoAySs97d0O4ZxEhw9TsMwAHLv/x6khjVNEQ9c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6045.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(366016)(10070799003)(376014)(23010399003)(18002099003)(8096899003)(10067099003)(22082099003)(4143699003)(11063799006)(261009223027099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?45mBW0kwxJoqSa7/ZQmkOfZZJl3DbanDHGAIVLSWHAFnYLrxt9uKX+hFsX?=
 =?iso-8859-1?Q?3gCdK98uXHXqOU67AwJfCM9txJntGLUs8/E47gLPJIdFwO4f7ZT98TbmqZ?=
 =?iso-8859-1?Q?1z2JCXL1r+y6ZKmsXTfEtVVIMXrZ6ec4Zcd8BeKt71IZX/TwcQ5UaFBMHZ?=
 =?iso-8859-1?Q?JwPC6FOPsjj17Q0b4jpTZcHcVIvutimLfrptjteoagiil5zr3NTi894zEA?=
 =?iso-8859-1?Q?Ne3CRj0cWEbfAO3HJ5zKkQYs3wIuffgRM77KdfHrecGCD6RwMKXOP5wLha?=
 =?iso-8859-1?Q?qQ8Yzi+3YLIp82XXk5jBf2YVRcH3XAp8lbgDw2fSp1Y7dIQ+UF/p1MjiRB?=
 =?iso-8859-1?Q?8NFNLm+pVHbC6X8DDEh5qxkyDggZWt5lS5rqo5KAoYTD/2sXgcG+hqPF8K?=
 =?iso-8859-1?Q?aqT9wXgGu1yxmubn0CrsUtdX/6g1hdJorKfvMwRHFU6hwRBlPVD183GVtf?=
 =?iso-8859-1?Q?/DBU9f+3ygL8ZStx3kadQTVzE5FJ99mwXt7wElPKTc+o4PJcznOhPhefxc?=
 =?iso-8859-1?Q?tBoh3c9FhCVNOSxmUb4suLziXRyH5kvERp2/Kqb8+3Pot2DIqkxm+xVm+t?=
 =?iso-8859-1?Q?6sPdq4+c/tC9dSgxE1viDOcwHUjzYG1CkeqOjnbQQFHLOyxgUFY35zTiQD?=
 =?iso-8859-1?Q?SXIeZcXqQzHFscLHvIO6Hj3g5cNmFpbwETga510qV7APCP2KdgdhSmMudr?=
 =?iso-8859-1?Q?So1q/f6PDxxkPRDMMSwV9sqYjvZHzKSpoVe+4tdm1IY9p9ajuLyUKaTIkB?=
 =?iso-8859-1?Q?vBRtcDT4gH9LAkyS6zTvP6T5xEt9QpKKdakfKuiEIeAznpSBzSuCVPq7s6?=
 =?iso-8859-1?Q?RWhzdm/y0llkygRTlyy88v3IvjWdC7SqstMkwn7GFSRJjO1vGER6RYtKpB?=
 =?iso-8859-1?Q?4BheNqSG6difZKaIey0nvkcRvqEzGV2DlQom9v1p1+lWIg8gSr3y82Q6ZK?=
 =?iso-8859-1?Q?CRG8fW7jfRbwfpryicPJ3lDoYJ0ffk6Uu2XIb2joRKVVtXZuJNzkIVHCau?=
 =?iso-8859-1?Q?qGHd31at4oxjVBqA+uIXpcG7UM5Y3gdwLVMLhwVR2N/VTM7U+9bnjJR2JW?=
 =?iso-8859-1?Q?nBh9RxGjnXhPvzB/dqyeVDzU8nySIq12am4zk+vdW25RKfANvEq9ur5FrB?=
 =?iso-8859-1?Q?efu5f7ndBOmG3tqCoFeDFr5g0buAnxl4m/ofLeaBuVlhgaazH+P2avszhR?=
 =?iso-8859-1?Q?1EU0bRXUciaIZ6AZSHH0FpaR/odxSCvKUq2pLy4y0ZcIqt+mb6NMyAd+PQ?=
 =?iso-8859-1?Q?YOoRBOmDXp88NjBWhBrfmy1dZynHxYWHgMUFJmvksBQWav2ByqgX4godsp?=
 =?iso-8859-1?Q?R/n9hEgGb8CgR/KY7NFxxlGI4QA+40Iygo341ITmNA0C7h7JgmWEwQTJ3i?=
 =?iso-8859-1?Q?yd/jGvR2tFmRUtGYbH0AERydODSC4T9nM5mu/1Y8mjeqQPhMeM6OU4oQV3?=
 =?iso-8859-1?Q?tZJbunu1wmpoidFqTov/sIDhF2JTd46YO0f8OZ/X2NLDorQEM6ONI5zgiy?=
 =?iso-8859-1?Q?cIsoVvNCAMnDZS2RiVkTnlCkEfHTYvanmmq7sVYiNdAA4Od1x4yHM0MaZj?=
 =?iso-8859-1?Q?r4lhHCxptDfK+2zuFwJx4hYNIMpaR4WdZ/kNMjoiRlD7PIlJmff7VJqTX2?=
 =?iso-8859-1?Q?azDC6KcR1tahCvn8HxMM333JtQUVhvxSPjLR+2OJ0wgpjJRZK64NZgQKtH?=
 =?iso-8859-1?Q?h5P3L45cvLNRqeJkL/lPzoBQG5AqDhxNboSfb2IC5uiSznri8lM1lXswBu?=
 =?iso-8859-1?Q?QUlfaGt1u7vjKxeetyM0MSobtTEYE+XoNzvtaCYuxEELH9nl3B2ypiSGYk?=
 =?iso-8859-1?Q?tIXk7aEd5alAXaZYysIap1ToKZ+6W6UVQviFb7Ky5UH0Uvg1NGiq?=
Content-Type: multipart/alternative;
 boundary="_000_LV2PR11MB6045094D24E940BF9DD37F90819C2LV2PR11MB6045namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SeFcWXqXdwcRi9vrdIQCa+Qi4I4drKTvxKp319MVBymasYGnK9sZcQGwTZ08dcA/byE7beoYVa36dDS2AMclrPdmdkF5R6lrchScHe/fv6jeNG9HraECCfFsORe8wYZdj+qduKgYrILR5o/LoPDJseiKGTE2DtCCuGQGoEx4lZcVotNrNq0mNtsvw45Dfxx1989tWmxmwuiph8TCXMWLxi50nnyH5UPHyOXZZ5UXF38XnRMf+po2yjkd8Ek8rbj57pLyYDy0y6lbssBmTncw3Ogpmkanj0ZvvcFwg1IOa5Fh9UKyn6o7ZtTE6+gubnoCphKm0xujEyuMOeUBnYbFaA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f15777-fe6e-41c3-f5ca-08df2aca91f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 14:42:42.9734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KgNPL+W3Es0F5DFStv9/VBWcOb5QVKBsRkHf/3RzDZ7DXZrl7220bN/+M01WCUEyqSdzlxAw+u8EaOhLW8ST6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4958
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

--_000_LV2PR11MB6045094D24E940BF9DD37F90819C2LV2PR11MB6045namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>



________________________________
From: Emma Finn <emma.finn@intel.com>
Sent: Monday, October 12, 2026 09:35
Cc: dev@dpdk.org <dev@dpdk.org>; Finn, Emma <emma.finn@intel.com>
Subject: [PATCH v2 0/2] crypto/ipsec_mb: Add SHA3 and SHAKE support

Add SHA3 and SHAKE hash algorithm support to the ipsec_mb PMD.

Emma Finn (2):
  crypto/ipsec_mb: Add SHA3 support.
  crypto/ipsec_mb: Add SHAKE support.

 doc/guides/cryptodevs/aesni_mb.rst          |  10 +
 doc/guides/cryptodevs/features/aesni_mb.ini |  10 +
 doc/guides/rel_notes/release_26_11.rst      |   6 +
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c      |  38 +++
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h | 260 +++++++++++++++++++-
 5 files changed, 318 insertions(+), 6 deletions(-)

--
2.43.0

--_000_LV2PR11MB6045094D24E940BF9DD37F90819C2LV2PR11MB6045namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Emma Finn &lt;emma.finn@intel.com&gt;<br>
<b>Sent:</b> Monday, October 12, 2026 09:35<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Finn, Emma &lt;emma.finn@inte=
l.com&gt;<br>
<b>Subject:</b> [PATCH v2 0/2] crypto/ipsec_mb: Add SHA3 and SHAKE support =
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">Add SHA3 and SHAKE hash algorithm support t=
o the ipsec_mb PMD.<br>
<br>
Emma Finn (2):<br>
&nbsp; crypto/ipsec_mb: Add SHA3 support.<br>
&nbsp; crypto/ipsec_mb: Add SHAKE support.<br>
<br>
&nbsp;doc/guides/cryptodevs/aesni_mb.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; |&nbsp; 10 +<br>
&nbsp;doc/guides/cryptodevs/features/aesni_mb.ini |&nbsp; 10 +<br>
&nbsp;doc/guides/rel_notes/release_26_11.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp; 6 +<br>
&nbsp;drivers/crypto/ipsec_mb/pmd_aesni_mb.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp; 38 +++<br>
&nbsp;drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h | 260 +++++++++++++++++++=
-<br>
&nbsp;5 files changed, 318 insertions(+), 6 deletions(-)<br>
<br>
--<br>
2.43.0<br>
</div>
</body>
</html>

--_000_LV2PR11MB6045094D24E940BF9DD37F90819C2LV2PR11MB6045namp_--
