Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981D2C982E1
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:00:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D710540289;
	Mon, 21 Sep 2026 11:00:21 +0200 (CEST)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11022080.outbound.protection.outlook.com [40.107.75.80])
 by mails.dpdk.org (Postfix) with ESMTP id 2258D40265
 for <dev@dpdk.org>; Mon, 21 Sep 2026 11:00:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEr1kOIFdqGgwdxNycwTwlWbGeOE8y4CSrekQl953a94wi/dLIUIcvYBwpbnn3Wjuhlynz6r5Kf39tZKj50kUbz8qX4FpLfMBmNlo846kgRFIIHibnx9hRzuyOiAuXjNEYUBLL9MyoS8zfQbH0W59/zHbX+UHguRpCamiqCaKMjO3OfK/fy7IefM2tDeNsb/5T9oilYh6lcKNeReNtlhnw7A1Ha4lFP7EEa/BRJ5rT4CVkVWlSH2i0auB8qhIUZLqdLC7W6ysymi4lZnC6JUkkXmvok6T4Dx1afLck8xw+xtjQrFs/MFs8h/pQdWIPein+6JXmf0LLv8nEQXZsGa/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:MIME-Version; 
 bh=OAR13+yf6rqj/H4irhIUxck2DomWpW9iS9059srVx4w=;
 b=NTN3GMl5bMSeNQTXcGR6ScVA8SCE97UNFiDVt57Ah1IzrOWMwQl0yAdA0JUjymEUPgM5ITKTc3NeF6CAT1jhu6FDuUiK0DUUq9Jz9SkXIM0/LcMvb/OCV08gEaIb/PZzIGmA4dT/scAEJoLWdlRZHbC7w6YHLs0QrTZw6+ZaTGZpneR5k7mx8B5p3/HoZYONmcCOKIOW8ZB0TtRBAqRXqkfnB790mwyFw4aK3RiWO68leNd9CwMZiFWGnT2qviYkMBTuGeTs8lo7cLjkAh5G+eNw4Z3DcJtIPCKgiNFKRrtjAOm0k08w5UwIXMNL3eifNGBtPeo7F34+uFYQI/ntcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAR13+yf6rqj/H4irhIUxck2DomWpW9iS9059srVx4w=;
 b=E9XfMoMGsa7zaJ/lAkUKt52UsETiCZvrx6VZ30IPYTJG3jEeA6NrhssCtGC+2i5zsF8dJN/UeDAag9unruaJLXMiUrvqLpz9Us2/+ydUu+8WCNnGGVYmMamixzjN61Ct/REHM+0x20gfxAQrAff8NkMt7bzmHHU9BQ0hgZvCmJI=
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM (2603:1096:101:340::5)
 by OSQP153MB1178.APCP153.PROD.OUTLOOK.COM (2603:1096:604:373::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.2; Mon, 21 Sep
 2026 09:00:15 +0000
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e]) by SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e%6]) with mapi id 15.21.0472.000; Mon, 21 Sep 2026
 09:00:15 +0000
From: Wei Hu <weh@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v2 27/33] net/netvsc: replace SMP barrier in
 RNDIS response
Thread-Topic: [EXTERNAL] [PATCH v2 27/33] net/netvsc: replace SMP barrier in
 RNDIS response
Thread-Index: AQHdSSvgOnnvwQxnC0mTp1PLJ3kcFbbYuhDg
Date: Mon, 21 Sep 2026 09:00:15 +0000
Message-ID: <SE3P153MB1848845EF6BFB3A73CC716C3BB842@SE3P153MB1848.APCP153.PROD.OUTLOOK.COM>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
 <20260920181347.747210-28-stephen@networkplumber.org>
In-Reply-To: <20260920181347.747210-28-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3585cb52-a9a9-4a5c-b09a-affd559dde28;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-21T08:50:07Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3P153MB1848:EE_|OSQP153MB1178:EE_
x-ms-office365-filtering-correlation-id: 930f4337-a3f3-4f0e-b63e-08df17bec0ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|42112799006|7146999003|10067099003|11063799006|3023799007|18002099003|22082099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: RFQX4/MDySRPjYmyj0hzdJ2d/oG3znWS2Gv5XoJVIaluVQ6sVpb8TZeYdyPQjQEfmY32vnzMi7iADyKalrmJutdNQ+srmMOkfVNjYxRiSSrFY3oTiws+ORHX9l9hhdzy1Nl9/MfM5688URTLjlcHSqTBqsoOQs6fi4qi6i6LsQaOhHkBYNJUu/Kw1KTYWWbCKAJcFVY+4BLFWveRWKvVrc19pw3lf2QNXYZ+gG+agO2Q3FQ9uiCQjRd63C/oHfLljkzvADM0AinYVm++ZxNnhSp7CRmuvcb6/q2+igw4Y8qGrSxGF37lN+yE6Gcy+Ix1YfkeF+FNf3nQQLp+YvS9ZTgPaDIFUpEw2TNZwJCj5FfkH0YRcm4QyUCEGH3kyO4NrjRCrbtYqhVANPxPPCtgZl4LJZdD9ovHrAkkpHIJLFL13rzcRmKoiKkIsuLX1WxxtxCGBO+/Qy07qzSJ1xY836wxxnSlGpElXjkwqLxaTFXRf8RHeWNCZBRLFA/n1nVwCF5U8up91nQhjviHUr8NU1H+EkCoLCMFqa/yL+ZQs0FrTN5hOL3184TmBVCHX6BJ+v8yJwMcNDbOc3ihgQeQVicSR0fhVPC1Hk/Kh+FKkAmjKvhI148Z4wERur4bRGoAhJpr0MkAa806ceXX5wo4e8btB+5CGICCMUHx50fNW5/gRHeZmrLsDR+t+0gHAN4Olt0XkoWmXQYZLvP5IE8WAFTZR9BBSfYxBdLYxfnq21k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SE3P153MB1848.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(42112799006)(7146999003)(10067099003)(11063799006)(3023799007)(18002099003)(22082099003)(56012099006)(4143699003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tFih4V220zY69MJ0QD7D6N7L68ZyC6X4lCHaC4r4eC8yxQThoiQZYR7nEoF3?=
 =?us-ascii?Q?kz39kX+BQjDxzTd/QJEsK9X2DmR3v2GTpUmi7OfUQQ/prLvF1sA59hO4GtIw?=
 =?us-ascii?Q?1XAtVqAsDHBOxuLMJXTyDj9YXuEG0EZ1pGN8NEschURjXBnCgbnydJPxRsv1?=
 =?us-ascii?Q?03ZFjBHvdIwszDEan5AYkANwDM/eX79bjJFq2GPeStnrqSyFqS3X7IYvK8MZ?=
 =?us-ascii?Q?sWW1clzAFfAZfubi7za2Bge8ZpCNicx+s4scfK861foYJVNibZCOdH/N7nj0?=
 =?us-ascii?Q?q38Zg5jDa87aHU7bOtV8HKRQDLZReguMyWKq2OUdAqqKtPR5M4dyjEMhXf5F?=
 =?us-ascii?Q?W9j5MzyN5qJccKcob2LOT6c7taJA1G3wgvyFYx9nxpI5oOdLXj8PiBbJZUIO?=
 =?us-ascii?Q?ryMSpUlTZ0hwIjiKE/kBRzW6nl3l8QKEYzXLwXXv/IUjMM1Wcjhy9AGx0ZxV?=
 =?us-ascii?Q?W+SCI1XZ9LCnbWxv2tSTA5BIqdVQpNrHEGvP5Ll7+XRv1HjVnfaqwcvVr5tA?=
 =?us-ascii?Q?oD/Qc3QC+AMmzGZhMqBe+hb7IhYJtJw4NK9q9iKNpoDi1krZhgeo3PSxcmWs?=
 =?us-ascii?Q?+2jUeqMI9pUsf6DAxeaBbX1aRDJZO3dj1t9woitPHOHbV8g9aDLwHp5GEXAs?=
 =?us-ascii?Q?w0tedCb2TDw5+U0waUeVjhwasqkVQttOJcTMeVZtdrcfdxXQeDIZjADw+qEA?=
 =?us-ascii?Q?2pbQuBi2H5Aeg7dbPgKMcBdFFw6SHrhqM5efPrSuFg3BJRUu4g1nn4qn5tCa?=
 =?us-ascii?Q?ARtplGgvaoHwsm8uXBcdrUUgD6xmXhYK1vtuEvTT9G6kBddLyFqKa0SEMzQ7?=
 =?us-ascii?Q?WtuPi5QwaOjLjxRgYse7jmxEwooE4WtvSbhLLklxrnpHANJUnvMf4wZcUPys?=
 =?us-ascii?Q?dLpLmlkKFghGZtEcad9yFCUiTUJXfjFvcPgS0dz9aFi56JbM/nLQ0FwypiAP?=
 =?us-ascii?Q?MNGR5F7DGNQ35+mZ4m2ocZB4veH7/kLYs4MwA+XyjQYH+sQqDW7ppXYBa+o8?=
 =?us-ascii?Q?rFZHvw5oWD2Qze+1cP45oMeYWgwCf2HxgBZVBQULkA9v2ulIgOmWy5PlPznD?=
 =?us-ascii?Q?RLtin0J1OebCiKjrVnYiSF0MKwS81kZJKtrsOtED57cc63b7kQE9JE6+WyZE?=
 =?us-ascii?Q?eE2WPv20k1/6u1SdDY0tW+6wG39NGsEpSZUL8/BmcbR1syW0TLCCpSNSiFQr?=
 =?us-ascii?Q?4MbKW4BbkkVQrNUpvAEEnYa3FmX5aTlcB0HX5VJB8AJFdIZt+VWvLhcXhOPL?=
 =?us-ascii?Q?xKlsO+5glkyzRXym/n553vyn4gg8YPboMyx6vNVX7Ovz/OomfK7GLwzHW2+L?=
 =?us-ascii?Q?FZpZG8eTKK9pXMAaxzsqhpGX9Vqjg3mOr79t8uKEYWrPJv1pAocecaVpIa+k?=
 =?us-ascii?Q?PRyxtyY6HVu77co2r/KJzPMTCArAkl3sOrJqO0u0MKh02pZ6uNPGWskZfxzm?=
 =?us-ascii?Q?uU78VfbGZayHHp8q84Y/2LVlYY+uQ39z4sPHZtAgz6Ha4IxgUtxN5HnEtqdC?=
 =?us-ascii?Q?wvFbX1BrN/KlVhrZOKLuj5rJwLekriaGgkVP5UBk3wI+msN8SF7WFzZgO/n9?=
 =?us-ascii?Q?XslvLcrxQRJlq+7uf/aFQLmfZpZozsH3WqZqlph7U15hLh2EkmfHYOEp+lBA?=
 =?us-ascii?Q?fZQgebk3IJb0yuV/G2YujWN+zhuZ4Fp1O7DD6LilvrHuSo7RLak3ucZcEnF8?=
 =?us-ascii?Q?T9+lpRegGGSIDQOdzCaRhWKzBDxctN4Yn8/lP4mnhqHlXWF5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 930f4337-a3f3-4f0e-b63e-08df17bec0ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 09:00:15.5433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p1L6CiEtP+LOcUFnznCjVEKkTP4y6lGZ6H70WglDWhs/a9uSzqukXTff3bZGZA71ZNtboWrTAkR3d+E79tmFAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQP153MB1178
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday, September 21, 2026 2:10 AM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Wei Hu
> <weh@microsoft.com>
> Subject: [EXTERNAL] [PATCH v2 27/33] net/netvsc: replace SMP barrier in
> RNDIS response
>=20
> Publishing the copied response before clearing the pending id is release
> ordering. The following cmpset is a full barrier today, but keep the expl=
icit fence
> so the ordering survives when cmpset is converted to a release compare
> exchange.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/netvsc/hn_rndis.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/netvsc/hn_rndis.c b/drivers/net/netvsc/hn_rndis.=
c
> index 7c54eebcef..d1142fa1dd 100644
> --- a/drivers/net/netvsc/hn_rndis.c
> +++ b/drivers/net/netvsc/hn_rndis.c
> @@ -357,7 +357,7 @@ void hn_rndis_receive_response(struct hn_data *hv,
>  	memcpy(hv->rndis_resp, data, len);
>=20
>  	/* make sure response copied before update */
> -	rte_smp_wmb();
> +	rte_atomic_thread_fence(rte_memory_order_release);
>=20
>  	if (rte_atomic32_cmpset(&hv->rndis_pending, hdr->rid, 0) =3D=3D 0) {
>  		PMD_DRV_LOG(NOTICE,
> --
> 2.53.0

Reviewed-by: Wei Hu <weh@microsoft.com>

The review reveals a pre-existing issue, not introduced by this patch.=20
The old rte_smp_wmb() only ordered the producer. Hn_rndis_execl() loaked
an acquire operation before reading rndis_resp.

The change perserves the existing producer-side semantics and is stronger o=
n
arm64, so it does not create a regression.=20

The missing consumer acquire should be reported as a separate follow-up fix=
.

Thanks,
Wei

=20

