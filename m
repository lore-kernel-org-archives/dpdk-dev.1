Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C5DC7EE30
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 08:48:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6D53402D4;
	Wed,  2 Jul 2025 10:48:17 +0200 (CEST)
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com
 [99.78.197.219]) by mails.dpdk.org (Postfix) with ESMTP id 5CAE24003C
 for <dev@dpdk.org>; Wed,  2 Jul 2025 10:48:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1751446095; x=1782982095;
 h=from:cc:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=c496D3exZpoQpSdCLYbAyJWrkWZafAwI3lcOVc02FPA=;
 b=tGz/8Kt+sHiQ9Npsb5FG/ymqJYgteNzY28ZUve0AMpol5igFjvRuXIHx
 JgmeTBqjyIu1MmoyCZ0/s68qSRFCwUV6cwPU+GUI1GUWVZmWPHTxtJziM
 Afqkwc0T8550YV+kECvFNbPpRTUDpaV6aBgb5Wlbl/laXk1v3xlD28XRR
 SPRlFY7zdaTgidDgp0DzMWQxPerwjex4JQdRejfZQ99E3wBdX6GJCW0/b
 T1KAK9GC1p181q2l+NoJoc1SnUgGDmfgwWHWvR4fhS9xDmVnvHdb8conA
 n7ZPTQD2oeVuCBImkDgVcqhY3ITKP6RTU+rjbeU31bsBe2GAZp/jCkcT7 w==;
X-IronPort-AV: E=Sophos;i="6.16,281,1744070400"; d="scan'208";a="212181819"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-80008.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 08:48:13 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:35591]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.232:2525]
 with esmtp (Farcaster)
 id ca74ecb2-32d2-4074-86cf-8560a9864d97; Wed, 2 Jul 2025 08:48:12 +0000 (UTC)
X-Farcaster-Flow-ID: ca74ecb2-32d2-4074-86cf-8560a9864d97
Received: from EX19EXOUWB001.ant.amazon.com (10.250.64.229) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Jul 2025 08:48:12 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.250.64.238)
 by EX19EXOUWB001.ant.amazon.com (10.250.64.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14
 via Frontend Transport; Wed, 2 Jul 2025 08:48:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFB7TQtxvmK2QDuOcrnBM1csJKJObE1Qu9LM1n+rBVQooXlqBwJ7U7Sa3j70K3dIbYHQLidIDUUE7PeB21nRvL/yix3aPv1GBh3J4iuCeXjHEAm72xkDkFSG9oJPyCXHYTv0Abt0KrouzVC9eOSfVUs2fW/0X9TCr6iY2cNXjMBPK8fNAJTayVRlhfSE+5kA9NzntwawzFw/v98Cq89UswaiOs1YK4UjusW1oC9jrLsvlIIPC9DuyFQdFpZxB+NsBZnGNIV05ESWRP0mv/HktOBZO1IpUiEGw2K8RQBcVHvNY65NvVMfHi/XTyyzqiqkm7YirxHL1K1r8blazPBwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c496D3exZpoQpSdCLYbAyJWrkWZafAwI3lcOVc02FPA=;
 b=EucilOtNIUzLWoxY+i6A1F5Y5NXNansEXOrLdI1daxAvvprX1gGsF01yKBkxOKeVSUC2r3Oqbly02mqeSDLBq4Q/7U5sBDq/47Y0lthmPYlK1f4ry9IDoRkeYj17Z9OBML2ljuuhIei38RYqTxHePk1tzxl1+CX354zxG8rFH64UZA93O7G3Ek3yk7q2mEPd3CgIrHSpyHRkLdAR49BbEhiIRi2kViKNT40Z7WbwXHXCiQltqm062sk51rZVtuS27J41flcmFXnp+d3DIuLRZV937Qo5dtJ099O7P3xjyryhdKk0rsKtTHKJo7Qgwb/JP/JMTzUiCvyY7v9OEzoDvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.onmicrosoft.com; s=selector2-amazon-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c496D3exZpoQpSdCLYbAyJWrkWZafAwI3lcOVc02FPA=;
 b=D8/4/MLnoZYvGiyO7ctBl4/W3kozxKi5JM/LamehnfHYppf1VWLBbtMnQoeeJfFN+GaofxwWNBrylv6EbcuDq28vmwPA2ugEDpYYvgzx8wXHHVmgZn7RHkl7uTEhugOmDGa9pX39tQqn1GKdywFXYDQxDPav/HXRGvzg9gYHzvE=
Received: from SN1PR18MB2351.namprd18.prod.outlook.com (2603:10b6:802:30::28)
 by PH0PR18MB4589.namprd18.prod.outlook.com (2603:10b6:510:c0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 08:48:10 +0000
Received: from SN1PR18MB2351.namprd18.prod.outlook.com
 ([fe80::bf35:e96a:c269:911]) by SN1PR18MB2351.namprd18.prod.outlook.com
 ([fe80::bf35:e96a:c269:911%5]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 08:48:10 +0000
From: "Brandes, Shai" <shaibran@amazon.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 0/7] net/ena: release 2.13.0
Thread-Topic: [PATCH 0/7] net/ena: release 2.13.0
Thread-Index: AQHb6bAlJIfdEg3ANkWDepWgEArCorQeh/rw
Date: Wed, 2 Jul 2025 08:48:10 +0000
Message-ID: <SN1PR18MB23514CFC26B657D25DBAFA3EAF40A@SN1PR18MB2351.namprd18.prod.outlook.com>
References: <20250630111358.3476-1-shaibran@amazon.com>
In-Reply-To: <20250630111358.3476-1-shaibran@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR18MB2351:EE_|PH0PR18MB4589:EE_
x-ms-office365-filtering-correlation-id: 5f620fa9-97b0-4da4-6479-08ddb9452c2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?5u3SQHvIWP0CrviOyj7w+JmrBs8BwzIUu0beNcAyN9udrbBS5S4QZUGZkhfm?=
 =?us-ascii?Q?+OYoTjTB4ecjZET7j17PplpkbPlSf3eUJv3sSGvkC/mW02IZIk1wKCDDKyhV?=
 =?us-ascii?Q?vaD8mLPtIuzUuw0UbrKlzmoj/zkETpTUgAAe4OwNYJy2OxcA3XGfpv6G1sqM?=
 =?us-ascii?Q?fh+++bvPZ2Rkg62DBazwaZ7NnOew9z3K5EUjfztGiQsaHD5FToS0FxyiuP38?=
 =?us-ascii?Q?POmhSRTey+Y8euzKF6OtXip1BlfhuoxLe8E0w6+vq4sowCYGZqIuhNKh7vF3?=
 =?us-ascii?Q?YtA6BcUzDr/HBnBGbmN9bkQm5uM/jwa5B30cvu8Lwlj/yrE9D88qXifBv07d?=
 =?us-ascii?Q?HUD9ZvCQGHJf6PQmtcKkrngyLAatgovurYOJaG4v+1PKoaFrTYL1EdqPOPV7?=
 =?us-ascii?Q?XCXoEtsTSIpZckYPh3n5FSrqq9YQ+0FlKkIrtsDpP/u0gga5IABd2fQnaVLi?=
 =?us-ascii?Q?hbAzkNuVFHNpjtEWSSAv2B8l9QPpkutHWWkauvrUnYfKDrFTOV93lFYgwwAX?=
 =?us-ascii?Q?94ekMXZDmHSNX14OX5h1G2bctJjipn7kLkjtleYcN75QrtfguXAaQXo9KpWc?=
 =?us-ascii?Q?MeWJsOxR31e2yLcHN9Qh4V7jnmS8xtqyRLD3ruz+OxxefMFxsL9xUgv7VSrh?=
 =?us-ascii?Q?gyGib+q6k+iU3CUMYBaLLIq64ICJe0SBAg6dhrgky780ZTh2LckKIvzrFjAC?=
 =?us-ascii?Q?s/+ipfM3nJoKTHgkq5RY+oDDefz00uh9YLzAuoBLsHzi7SGoTd6M8yvjCGVL?=
 =?us-ascii?Q?hPNeUf+un68RmqK+C9Pi/ekHmXOrGQvolGFZ4yJ1VtUMXmp9nS3yrOAgLCOM?=
 =?us-ascii?Q?KTJKA9PpSAQr2wm+moO3VJhuQyGmYM3YRmXt7hQ1UH4wJE0oUQHPQAQZczxq?=
 =?us-ascii?Q?daWYAfTDEai/zqqpq3/ntZ5ur9eTsVfZ0AVMZTMeFVlWtCXjqo4Yy1LXuwCw?=
 =?us-ascii?Q?VrLwoJiHbwgzcW6nDhUdWNjmImjO+M1yktXWqEIMkgwUHNs6KgQYIPnYFpZU?=
 =?us-ascii?Q?TrfjIp+jsFLcsJxTV2CAEGFMAaMesx2NRxXE7KgDYRr/5RSxzd17QmZoiFPl?=
 =?us-ascii?Q?w1EY36M55Ddsulh7kbAWkkHZhxLHMJQ/iSF07KCoQiPjn11LiyM9scJrgYhq?=
 =?us-ascii?Q?z6nfXioF+QGWa/SY4bA2fiMMQ7ImqMBXrA2HEmTSvHJJgO0uwmRI+lvDPW+2?=
 =?us-ascii?Q?PyW4HunDWkQtMAgcx6z9vPbtUbZKNvFjJmedg22e1mbhKijV31HNs1bblMuj?=
 =?us-ascii?Q?JyRL8r1lhpGo8DhlXfOPwoHcZogFQlglI5mCNeyJ4tOtrGonumnTBPXSiU3h?=
 =?us-ascii?Q?lebsOcBUtozd3Hg53Mx5P5ur90rPcP2OEXXySQvsyLseNdcYH7LzFmmBs6rK?=
 =?us-ascii?Q?SA4LGw4r6vOKpAEJBGFfHXcRHIkiIprkgy1KzG1g+FLdfeobwIcJ//n3H/ak?=
 =?us-ascii?Q?jaG89qdbtTxuoVakcr5RxlTatLtCib+F9i8BnB7cfO9ClTWlhPxblQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR18MB2351.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yfyqTfDE3jbjW8+CY7+rtKUR0pEkXMiRI1nHli1RBoi5dyLHxE+qCmMDdLHD?=
 =?us-ascii?Q?IWPeOpyxD5Zyjzdwt80E4+rQCyN7ZnqVAoGvlOfv/DbgNJfulNweWYKLspL7?=
 =?us-ascii?Q?5JTuUrBEeYDCWRztNwDrK2ZBSaL3l1dzTpTH7WKe1agP/wGrQNeO+kulyhl3?=
 =?us-ascii?Q?c/iib0Es6tYO9076G8fvg8Zk/t7h5ceqivUOv9I0pASg1WYvyVCU9nQtNrM9?=
 =?us-ascii?Q?SBYOtgN+w2DLejAqsz0G6CZu5T8Jl9M52tSLxkLtOFQkKc12DDtpRzQMM63p?=
 =?us-ascii?Q?jLo3qm+6p0y3qbxGR49eykZjtINwn6cU0F+mCcp3cGldRni10Vl+tDGG1cxZ?=
 =?us-ascii?Q?nmqzXJDA3irzoQBnJ3X4ISoigfihsjF2v3FJ+C1u5qzHZAf+4fiISGPjoIOL?=
 =?us-ascii?Q?CNhIuC8jVoKGOuF6w/oVR/K31SScpwEmRqgzp9IHza3ySFy0neS0ftSH0tty?=
 =?us-ascii?Q?ntl7DZLY+PEjAkYCyJPiDlVlBBgDqunGwX9TRa5NVaLG4m/c9S/B5NguwGyj?=
 =?us-ascii?Q?xxZOYYi8OaVDJWLWCbflLnWM0gpIU8POXAE7SOXSm3hyR9cPPHFSlIdCuI01?=
 =?us-ascii?Q?a8fPyC+TsdHLri+1LnDZAdwnVcLLJLBg/1LgVhHgYVX/UI3Y/4ZoCTeGAOte?=
 =?us-ascii?Q?BM5yETaJ6lb8u3gg0ZhUzAHw8K22i+vMpgOnIHjyMzQsGex3nqVaUvjspAIH?=
 =?us-ascii?Q?Ndhs8/HrdP2O/jlc+p4Mu0qeWUn6/ml70Gm73cLGz2obyMzDMuRld0t7sJL3?=
 =?us-ascii?Q?hgKrtGE1dqRYT1sQMH41dcaLt5slpOfQUSifPv+AxxinWBaeqyzKxvgEe05d?=
 =?us-ascii?Q?bYO5C5NT7vsxtDazhYtNHve6pIQ/cqHfscWLk5SsGEn0olJrEyB1IgRPf15L?=
 =?us-ascii?Q?08yzekRYB8p7E2fwchMs+cZdta6RlO7pfeaOFrIz+iRy2Wp6CBUgtAgoAGFF?=
 =?us-ascii?Q?EtsiUD2sT0wFUUyIxgYUSbVezhneFhtZwvK5DuGk8lrB2W3HR7M/aN8wnAVO?=
 =?us-ascii?Q?qNjb0ecneZeyWeeLMxfo5j6bxJu7MOQkgrGQJt1wy1bTc8jhSJI26y+R8O6I?=
 =?us-ascii?Q?gY5SHxUFv9s3XR5eY+hjIzalRCU6erje/1946532V1e3IqyOwe/3Vg4HDKCV?=
 =?us-ascii?Q?SldIcqsL5X6Er5EvD5INV37gTY1inO6ZeTbe2+f3dhuvJnd8gnslyf99KW3t?=
 =?us-ascii?Q?pQAxBvvD4fF6z0OG+6mb72d5kcRzYTFSy25Euz/jxMLbKb0qMYE+mbU22sj0?=
 =?us-ascii?Q?LMpHPfsCWjhbG5NZq0cTGe4RW/YS9W/pfgca4Mf3HSAqNK3R3sTdQTdwl79O?=
 =?us-ascii?Q?0W95RaDpNkdi3ZOKbz/r7gnm5rEsAAl7zmO7OQY5QAHBJ/KuqJyxFdCYFCd2?=
 =?us-ascii?Q?D90fTDatcOlXg87peQD5WcIMpirsHdor5ne+LowO4/O4zsoCJpKCUkbguk57?=
 =?us-ascii?Q?+UDvA4rPoX74kUccjDzsOKIoh0FhvQjNG23KOs+Y47a0A85h4/q7TbtxHw7X?=
 =?us-ascii?Q?j5MwYBFQI9VUnMZkyXpy2kKavjHwSw0MV6pefQUugr3ZwvD4g1Gbj8xZtRKu?=
 =?us-ascii?Q?2VcM3/LSgvYmfxtdZsc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR18MB2351.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f620fa9-97b0-4da4-6479-08ddb9452c2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 08:48:10.0783 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eNJmneWzxef8YstfIQXMWNUWu5qPhWONXKx40hDcXK6b2QJPVzkfl3PfOktGu/QUaDyFJlykmncbK+HPKmZBCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4589
X-OriginatorOrg: amazon.com
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

Recheck-request: aws-unit-testing
We added support for rerun to aws lab bot, this is to verify it function we=
ll on the cover letter option

> -----Original Message-----
> From: Brandes, Shai <shaibran@amazon.com>
> Sent: Monday, June 30, 2025 2:14 PM
> To: stephen@networkplumber.org
> Cc: dev@dpdk.org; Brandes, Shai <shaibran@amazon.com>
> Subject: [PATCH 0/7] net/ena: release 2.13.0
>=20
> This patchset includes an upgrade of the ENA HAL, introduces a new featur=
e,
> and addresses three bug fixes.
>=20
> Thank you in advance to the net maintainers and community members for
> your time and effort reviewing the code.
>=20
> Best regards,
> Shai Brandes
> AWS Elastic Network Adapter team
>=20
> ---
> v2:
> Removed patch "net/ena: fix virtual address calc for unaligned BARs"
> which contained a problematic casting when compiling with 32-bit system
>=20
> v3:
> no change, there was some technical issue when sending the emails where
> part of the patches apeared on different series.
>=20
> v4:
> Each patch in the series should compile independently.
> Patch 4/7 causes a compile error that was missed, as the full series pass=
ed our
> directed tests when applied together
>=20
> v5:
> Reworked the patchset so it applies cleanly on origin/main due to release
> notes mismatch.
>=20
> Shai Brandes (7):
>   net/ena/base: avoid recalculating desc per entry
>   net/ena/base: coding style changes
>   net/ena: separate doorbell logic for Rx and Tx
>   net/ena: support fragment bypass mode
>   net/ena: fix unhandled interrupt config failure
>   net/ena: fix aenq timeout with low poll interval
>   net/ena: upgrade driver version to 2.13.0
>=20
>  doc/guides/nics/ena.rst                       | 13 ++-
>  doc/guides/rel_notes/release_25_07.rst        |  9 ++
>  drivers/net/ena/base/ena_com.c                | 40 +++++++-
>  drivers/net/ena/base/ena_com.h                |  7 ++
>  .../net/ena/base/ena_defs/ena_admin_defs.h    | 14 +++
>  drivers/net/ena/base/ena_eth_com.c            |  6 +-
>  drivers/net/ena/base/ena_eth_com.h            | 15 ++-
>  drivers/net/ena/ena_ethdev.c                  | 98 +++++++++++++++----
>  drivers/net/ena/ena_ethdev.h                  |  4 +-
>  9 files changed, 175 insertions(+), 31 deletions(-)
>=20
> --
> 2.17.1

