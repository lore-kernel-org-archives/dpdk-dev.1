Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47025CA5FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 13:08:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A11B40290;
	Tue,  6 Oct 2026 15:08:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 3FFE44025A
 for <dev@dpdk.org>; Tue,  6 Oct 2026 15:08:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791292100; x=1822828100;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=7jHUPhhQQdP5OH0tW66r2j7kvCYZtaD475nxBX5iQ8g=;
 b=hKrKu7dTWl0I1AcEI/AKyNQ3R1Gw6v925V1wmj8TDTOqhk7OwIBt0o4e
 835gxG6YiWHeEZC1DQsZ+Fhc8tdzJWY2usnF1vJq1e6M9TFiBpIsOzbTg
 aLxKodyGeZruFPcJ4pG7k5ZQq0tnTXDL7Hm+YUmwGawn6msV6wthU15SS
 rt4/e/n0oCUSWqWkZyMWR+jvUeWSN5slKbfYIQGxAbE7O33RLQesJxLhg
 rBAeHSXdQg4BRMI2P/TPUckorBV2D85NJejeitb4TAt9MkBTfxn2DRZX8
 tXxHcucPoR/EHCYC0IUnuVMrnKbpa6tBW39JWLeO67mYP/ljOJBcfwfjE A==;
X-CSE-ConnectionGUID: j2hLYDrNQsu5M/9DqgDepw==
X-CSE-MsgGUID: 0y2dLzjgSz+evqfNGB+eYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="35369"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208,217";a="35369"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 06:08:18 -0700
X-CSE-ConnectionGUID: YfPaX+3FR9KazZl4fZT9wg==
X-CSE-MsgGUID: sJ843CBnRZ2GDmiSJ4zQTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
 d="scan'208,217";a="303419902"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 06:08:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 06:08:17 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 06:08:17 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 06:08:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKImLsGmUBMmyuor04NAptsdT3djUrJ8MFTcvbK2xvmBSLerfnL3pXu+H4FAatRgr0G8HnpSTK9mHizk6DyyCCWdsz3DGXwoo/2Tm4z6WbKABSGc9tSZZti9tmrGzvjapYmRT0CMTkA2VWY60FCavDPSh6MJ0aTyhqtM/xXhk1VmwEyOGi14P+t3pBs8kccHYXn7uP4vphw12ioAH1dY5S7kaX5AnbYgTQmsysjLEO6c/XvV+xtQr2TpFCTT4Xm8HPh9WXxvkwxElsmRB2hVNO9EiAM+fL2ApCi3Wa+ewa13hfoI8wrHXSh/FHYBLnUlbcfs8q6pS4nJPsVUl9GwMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JiUbWrc0w+uLMH1ajwxSXdIWnzBqQPIWcBWpIQap44=;
 b=gKaAQuPOd6JSDFGqDMlXpmLRKOWq3hynqNWFs8/MDbRyWesUcfSm1fEyamv5iUX7oDgb4ZVQEXUgnDeEzJ+dAwqUAf9sMJYjhtAPq/pPaAf9oPis7LNvmmaFVRDDJ/QcbazNnpTR6qZvGQFu43iFOqJlHhgZ3io+GzFHDQtLyjdxwJX70sg75QLqMl+q6cg/Pfh4I1lsKVJQFDqyyksAznjD8Rkush1HeNKEtc7OkLDI3j5AarRpPE0gTNYY2jBeADtWmJ8ylFfX50JOYaVcofYzEDQUTBdBvrSeNQubQe2tYHUneEu//xTVo/RwQhLeRCzP9HflbRcTDJizAoL16Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20)
 by SA3PR11MB610523.namprd11.prod.outlook.com (2603:10b6:806:589::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 6 Oct 2026
 13:08:09 +0000
Received: from LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae]) by LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae%6]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 13:08:08 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH 0/4] crypto/ipsec_mb: add support for IPsecMB 3.0
Thread-Topic: [PATCH 0/4] crypto/ipsec_mb: add support for IPsecMB 3.0
Thread-Index: AQHdUlRxh4wvSxn7P0OGyEi4hFxr2LbwgrjD
Date: Tue, 6 Oct 2026 13:08:08 +0000
Message-ID: <LV2PR11MB604513AA3C21FC3411194CD081952@LV2PR11MB6045.namprd11.prod.outlook.com>
References: <20261002095652.1540556-1-radu.nicolau@intel.com>
In-Reply-To: <20261002095652.1540556-1-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6045:EE_|SA3PR11MB610523:EE_
x-ms-office365-filtering-correlation-id: ff7d753f-9611-4b5b-18d4-08df23aade23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|376014|366016|23010399003|1800799024|13003099007|56012099006|22082099003|10067099003|38070700021|11063799006|8096899003|18002099003;
x-microsoft-antispam-message-info: Ec/+gKcyeZd/96xh+a9R0nHkEC2i4QPOqbBp3bLU2kkUO4TMB80MJaCstcHOure6YuB+gzRg9DUdwWPTYjnDEvuWuf9hQ41XhZb2wTAKrlCPMiYhu+XWmH3KK97cqKZMpT91tC4bX/VgOdQO8oAEqshM+uv+yD6lwYVH/8vErUdJ60qADjgylv+sBnNPq9n+yX0CugMUuo7flIX7Fz8SS4EmybJc+eGvIM74WevKC5SMj9r1hnGDrLeOKDKA/3+FpE/0yQ9V5DXKFt8NZYA6DsKreGPhm2k6c+b1Gpvu1+xOwFBiV/2IGz23JZGavjZXXm/DeOgWYnoLAd45XotcEuZKPD0HcyNDK+NJq3iqXJh1frx6HbPavJmVEKz8TcFp0VAkeL/csGl4EN7+SFzJIUqvX2kFkckTF8ASXct+V2chXnD2vpNxbBn2CzREHPJ8gh7TEYODCAyR+tS6KlD7BzXoK86Dzi9YE+ahD2nBAYGrUlEbGWxMGyzU8ZDrFjjIr53gsqIFVHD4j6uZYVwW35gCAv9zig3in4EAHs/LQg4/k1+x8c+g70EkfuUSW761K7TvW1mz5L3GGVAtic4OaYaycGryOz8NnzWhuPdTJsEY35OuspAdEbQ/r+kcqxUWYhkUvECsmhruZkxaoKSeKppocqBdNa/KxpnjqsNcf8VnkkLjcv3DNmX/c8pqYjooPXsf0haWFLLqhqickntcBYvoXiq1i+gRmhLTBlFLWIo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6045.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(376014)(366016)(23010399003)(1800799024)(13003099007)(56012099006)(22082099003)(10067099003)(38070700021)(11063799006)(8096899003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?U++/3dzkvltVJuO5gHFJtK9OfK75WOKlPI2zDPzO8Zhti+RVYW7TD+FGz2?=
 =?iso-8859-1?Q?L1Ukmu7SoeWVrltyCG32VS7VfvqFbncN+kGNWIXj3MXFpOG/JlzqpvBKyI?=
 =?iso-8859-1?Q?75yUlUa/YEq0oWKPW3y1ycXVnyD4w51AZ5nAzN3/RaUQo7wocxYXILzhTC?=
 =?iso-8859-1?Q?zlhEy/wq5OaKN4/YPlS1mlpimO2BnOVcANV82kPkXt9Qn9RfGb2isX5zuM?=
 =?iso-8859-1?Q?9x9dmoWTRtRT5uu1rhetm7VSXRvOWQxRDk/Sjt8bKKubP5dcXzPfaSU71s?=
 =?iso-8859-1?Q?5ep6rHkd9NV+zvhm5spGQLuLWozozdYw6CPw00D5WNWudYjBgYofZWP9EK?=
 =?iso-8859-1?Q?0TAxYcwq3uE7DqQo9wURqqvXuk6Vxfk8m918U8jdIt/vzqhM3Ru1tQoL3e?=
 =?iso-8859-1?Q?5wsWUt32gRBMlMCk88l8Zu5kwpDYnbZXsY9P9rEuoyGYPc9Iet841Hi3wP?=
 =?iso-8859-1?Q?Y+AOkqqN4hj+Nl4S+8eLk2oP5o5QRV13mZ7N2hhyUIG7t2PTE7Kac7QpNK?=
 =?iso-8859-1?Q?sVJwQ4tu9xmnI9vyMzWq6MPgjxF7K7ChPK4eqlyP8MKXSV63a3zAH0XDDF?=
 =?iso-8859-1?Q?NzQQVG4ENOBrjwtgEsSDAjsrXnujWyblfOZuFlhRsaVB3cGUNmLqW9ddWj?=
 =?iso-8859-1?Q?Y9lwWUf8JtXprPlAkhvAsUwxR3lb9hEUn91ZR0C1727ZkKGJFOwv4GfhVr?=
 =?iso-8859-1?Q?Rbc3Di+xNmiyxBxSxtsA9KO98VG1GH1sHsosA+zjL1nGAZ9nv3b69nZwe+?=
 =?iso-8859-1?Q?E9tyaEa6tKxGifeO52CxR8NM/FFeLXPjjKjQtd9/mLnB11+EKmaJAqhjqs?=
 =?iso-8859-1?Q?upx3DVsX4/eTTBYmd1LVhV/SSSFLSabD9MAUTSjC4BCF61Vkc05x65U8CL?=
 =?iso-8859-1?Q?/a7XWuTXw5dGEimUx7fnCSh6ojYsADbqcFmfG9bHD4EBk7/XrJAoxrYe26?=
 =?iso-8859-1?Q?dyxyHZ/YEmJyd2clEjIzI7xrcNWLx5S0jg+9rHPrTKBbICUwtgwREKSi0l?=
 =?iso-8859-1?Q?gBonUAeLCCZzAsR/1ZYsNDUj+lHOyWzJV1sqSgtdszcYqcWiYqjlArQebS?=
 =?iso-8859-1?Q?82MPln2qvyfVNF7Gmd96m6xoOgVatHHBGUB+owquIXKuWgjxbMI2nUeBlC?=
 =?iso-8859-1?Q?N64RxiYyjHiha+LfJWMUXQakn5GLNiNQn6ESzpZc9mTErOUFzGjEE26Qpy?=
 =?iso-8859-1?Q?nbETnnyjmpwnOzwiL9BhWROyZfcOKxWyCgzLh5oTbyQjlZf6AnYMz9oYE8?=
 =?iso-8859-1?Q?3m9YjSNtVRhhBH8TjwH0fBzu4Ur7YvN5yN32I9QxQ0a0f9XYtaxGMMV/HS?=
 =?iso-8859-1?Q?J0kkKW9l4ALBWuXVfhqs0cLjUvg4AqAU3SNbr9BYjIfQwEzuv1b1ocRXHI?=
 =?iso-8859-1?Q?9UBUKKODOUK/piBk+AGk43djTH+W+TiVh6wMahj56lm9GxE32l1WRr357l?=
 =?iso-8859-1?Q?P3YokPYdrWz9pSWKHDxGZP1Ftv3V/QZSMmyhEbjs8AcYUDUjmp9yt5uo6m?=
 =?iso-8859-1?Q?VioSVkgwJ+s5zMuj7ujvHhSRz8fj4BBX/CiXxanrQcrtMht85GKtHd4wK0?=
 =?iso-8859-1?Q?cyFoD8495g28wRC/mcjqaAdDNLF3Wk8HYB7zOb/8rEDqVlLi0VmngK8Ibx?=
 =?iso-8859-1?Q?8COGuhqfi9iYTtFx3/Z+FVX7/71QaNRLAavviDtc10DlF+jgyvw3sFEXv+?=
 =?iso-8859-1?Q?dJunPiUBxJF8tzvb+HVCawUM18uJQFXUGmiGoU/uIPE3VP1WhxUBrCWUpn?=
 =?iso-8859-1?Q?C8SW6fbufsOhWpW1gRwsf1jNG7PMjmQx+9oiGQacMkmoNC?=
Content-Type: multipart/alternative;
 boundary="_000_LV2PR11MB604513AA3C21FC3411194CD081952LV2PR11MB6045namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OQQWIUsKGDjDST0mTw9fTOkZ3E/xz0d6D/GfCqjMMZpDVU53uKlLg9f/CU2CKk60NHgE0Q+hgXVP8amV7cNwHtF7RTjTrGUoZmLvr80LHr8gB+Qhwj4YuJrQWKuFiwJbggdCOzQL/FuKo+Omcqncsk16lzicy1IrchLLx2JjIcBn6O3eyjeObsVOkcksFpsP3YwkE3HM72lOzRQmszyYil2X4srG4dm1iBqKkC62l5Jm0DO8NY/+szF3Fnrwt4qv9DjiIbVD3wf1HJUlTkk/OsrmRRFnjwXj8qRm0C19RtD8j89XlTQ9WWlxJhx5itxVGd8R51JVrIwrqZKxsrWv0Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7d753f-9611-4b5b-18d4-08df23aade23
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 13:08:08.7732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O2N7iHoJW7Q2IW2Fr83baAmBNDcEFP0Olc3JUUqQFWXlo5Td22aPAhW5SwWnSK9fiStYcobIKzRSM/PCb9GEKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB610523
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

--_000_LV2PR11MB604513AA3C21FC3411194CD081952LV2PR11MB6045namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Series-acked-by: Kai Ji <kai.ji@intel.com>

________________________________
From: Radu Nicolau <radu.nicolau@intel.com>
Sent: 02 October 2026 10:56
To: dev@dpdk.org <dev@dpdk.org>
Cc: Nicolau, Radu <radu.nicolau@intel.com>
Subject: [PATCH 0/4] crypto/ipsec_mb: add support for IPsecMB 3.0

Intel(R) Multi-Buffer Crypto for IPsec Library released version 3.0.0
codenamed T=FAnel Pablo
https://github.com/intel/intel-ipsec-mb/releases/tag/v3.0.0

This patchset adds support for the new library version and support
for the new algorithms included in this release.


Radu Nicolau (4):
  crypto/ipsec_mb: add support for IPsecMB 3.0
  crypto/ipsec_mb: add support for 256-NxA4/5/6 algorithms
  crypto/ipsec_mb: add support for ML-KEM and ML-DSA
  test/crypto: add asym test suite for AESNI_MB

 app/test/test_cryptodev_asym.c               |   7 +
 doc/guides/cryptodevs/aesni_gcm.rst          |   4 +-
 doc/guides/cryptodevs/aesni_mb.rst           |  26 +-
 doc/guides/cryptodevs/features/aesni_mb.ini  |  12 +
 doc/guides/rel_notes/release_26_11.rst       |  12 +
 drivers/crypto/ipsec_mb/ipsec_mb_ops.c       |  58 ++
 drivers/crypto/ipsec_mb/ipsec_mb_private.h   |  20 +
 drivers/crypto/ipsec_mb/pmd_aesni_gcm.c      | 267 +++++--
 drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h |  31 +-
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c       | 695 +++++++++++++++++--
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h  | 360 +++++++++-
 11 files changed, 1354 insertions(+), 138 deletions(-)

--
2.52.0


--_000_LV2PR11MB604513AA3C21FC3411194CD081952LV2PR11MB6045namp_
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
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: &quot;Inte=
lOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
Series-acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Radu Nicolau &lt;radu=
.nicolau@intel.com&gt;<br>
<b>Sent:</b> 02 October 2026 10:56<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> Nicolau, Radu &lt;radu.nicolau@intel.com&gt;<br>
<b>Subject:</b> [PATCH 0/4] crypto/ipsec_mb: add support for IPsecMB 3.0</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Intel(R) Multi-Buffer Crypto for IPsec Library rel=
eased version 3.0.0<br>
codenamed T=FAnel Pablo<br>
<a href=3D"https://github.com/intel/intel-ipsec-mb/releases/tag/v3.0.0">htt=
ps://github.com/intel/intel-ipsec-mb/releases/tag/v3.0.0</a><br>
<br>
This patchset adds support for the new library version and support<br>
for the new algorithms included in this release.<br>
<br>
<br>
Radu Nicolau (4):<br>
&nbsp; crypto/ipsec_mb: add support for IPsecMB 3.0<br>
&nbsp; crypto/ipsec_mb: add support for 256-NxA4/5/6 algorithms<br>
&nbsp; crypto/ipsec_mb: add support for ML-KEM and ML-DSA<br>
&nbsp; test/crypto: add asym test suite for AESNI_MB<br>
<br>
&nbsp;app/test/test_cryptodev_asym.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 7 +<br>
&nbsp;doc/guides/cryptodevs/aesni_gcm.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +-<br>
&nbsp;doc/guides/cryptodevs/aesni_mb.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 26 +-<br>
&nbsp;doc/guides/cryptodevs/features/aesni_mb.ini&nbsp; |&nbsp; 12 +<br>
&nbsp;doc/guides/rel_notes/release_26_11.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; |&nbsp; 12 +<br>
&nbsp;drivers/crypto/ipsec_mb/ipsec_mb_ops.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; |&nbsp; 58 ++<br>
&nbsp;drivers/crypto/ipsec_mb/ipsec_mb_private.h&nbsp;&nbsp; |&nbsp; 20 +<b=
r>
&nbsp;drivers/crypto/ipsec_mb/pmd_aesni_gcm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 | 267 +++++--<br>
&nbsp;drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h |&nbsp; 31 +-<br>
&nbsp;drivers/crypto/ipsec_mb/pmd_aesni_mb.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 695 +++++++++++++++++--<br>
&nbsp;drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h&nbsp; | 360 +++++++++-<br=
>
&nbsp;11 files changed, 1354 insertions(+), 138 deletions(-)<br>
<br>
-- <br>
2.52.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_LV2PR11MB604513AA3C21FC3411194CD081952LV2PR11MB6045namp_--
