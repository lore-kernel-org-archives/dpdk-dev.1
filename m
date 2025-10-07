Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E511DCAC5B0
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 06:53:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A27F1402A3;
	Tue,  7 Oct 2025 08:53:38 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 936C04027F
 for <dev@dpdk.org>; Tue,  7 Oct 2025 08:53:37 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5970nArA005582
 for <dev@dpdk.org>; Mon, 6 Oct 2025 23:53:36 -0700
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023076.outbound.protection.outlook.com
 [40.93.196.76])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49mqg58nqq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 06 Oct 2025 23:53:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhY0abHhaOOMg+jFylysXWpj8V/CL1YGDrcYAZFAKyHnnK8N6zi9gFD1nFmuA4qRrEn8povBYB02W2bfplNrEZaK04WHFx3GWlcFqvP8en0M4Rq1ioaq+C/9bic3JrblmIKUY6MVvhzsaP1apGwbu+jyVmKuxBrHHdVCM3alk9RQE7lnBy1iiZpc+481L4uEffxJyGa2/yBowGfMvkfWZJkm7yh2JS/NQR1w/a0RA12XZZg8//bgDitC8acHHjtl1cVFO47S1w+kUPU0HdEcWqhoaU+yy5qQ1ilSullmOja3PDCpAbVVVfgi2llfy4c6oYD1YbUfKhwpGkQUHBrPfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2NnEVvFTc4ccl9+Sc7gEQFHlxKesoDtCrcKMyrLg1Q=;
 b=uZDHjCzTrbvx+2pjcx9TRU845eawiwMNEIkF/5jwbdGkSeQPG9K29mkuAwfrVZuNUJPFJm5TSW1rHOHoXOIK1jEFBbIb0gZwgUJTXwDrGrR31f32rsNqBNkashZYXCWpAjL2V0O91M+TrN+m0hM1C+eVuTa6A9mUhUtcGbcxcU6ndQtcRfo05w4JpwN4YaR4CZEonThtE/RCvyszTnN6SCYpZ6jWiDL6nHN4bm1R754JzN4RkoZj7DxgKee5QHlEDeMDVlw8FAnFaDNyoyGxzvyzK69FO5DzOUQDq1SgRceTzxZDQD9QJDbJWRpu/pNKIy7QcW7n4WaVokqBt2WPzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2NnEVvFTc4ccl9+Sc7gEQFHlxKesoDtCrcKMyrLg1Q=;
 b=QCH6qJjdXhc1zLajDnKLCNor81Fent6ZcWaWvHzssZhoMe1LXB7OHpwL0YJnqX+3WISaEzUY6s20OXo9W7HyIdg0lduq3xapGhNhCGiesXTIdXaESSQFGzalPLX9oH04iCUXWkL77WnXx9tczDBRk2xqy8V2N08KkFgVLZvVjlQ=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by IA0PPF820E5265F.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::c2b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 06:53:28 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::f458:534:2d1:7afc]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::f458:534:2d1:7afc%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 06:53:27 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Tejasree Kondoj <ktejasree@marvell.com>, Pavan Nikhilesh Bhagavatula
 <pbhagavatula@marvell.com>, Shijith Thotton <sthotton@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] event/cnxk: increase inflight buffer count
Thread-Topic: [PATCH] event/cnxk: increase inflight buffer count
Thread-Index: AQHcMSu8q6G6NgvcSUSJWTaAOy5fw7S2S7yA
Date: Tue, 7 Oct 2025 06:53:27 +0000
Message-ID: <BY3PR18MB4785D87A5DA42625DF2EAA8DC8E0A@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250929102753.1036004-1-ktejasree@marvell.com>
In-Reply-To: <20250929102753.1036004-1-ktejasree@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|IA0PPF820E5265F:EE_
x-ms-office365-filtering-correlation-id: 6cb647d4-c7ea-4424-6034-08de056e37dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?OOoX5a5TR22OF/tN63W4L8LaeyJRJtqTXF/pTP9OHvDCzlbwsuAJJojNA8H9?=
 =?us-ascii?Q?8t0F3pZwlebKb6qc6BKv97NeWBrKFvLWOjwsYdP9WTjf7q9+1+yZHrup5wiO?=
 =?us-ascii?Q?kXvo2xZJhqmwotWhSZ/ciae0/UnEVYlOogjKTzGyZQDkuLui+MGGnhOiqEGc?=
 =?us-ascii?Q?HxMp6+L9nu02VzZhlddd0/1SZiWcs6KKxazAHcuIBvqMSjdEEBXCNX4YQJSN?=
 =?us-ascii?Q?iMXDp9eIbS82TTpnn5u2jOtMvS9RDULsoJ1CmbG8UKBJtGNsPc+eCWi96nzK?=
 =?us-ascii?Q?OLXClx996F+gfVJllUUurE7z/bl0Udx7ezBgafAIQthkUHc7cjOo4w6hV1W9?=
 =?us-ascii?Q?SNRgCqq8zQ3fYErXfG3QbHfaC2Cts9wM/WcGnsTPLtg+hFj1iAkfvhTbmwAX?=
 =?us-ascii?Q?5fbzkrCnkb5tYH7AACOSEmg8hosXoR4SwispN54+pg+whTsd8GZb2t5OGLMm?=
 =?us-ascii?Q?2+XN4CYZUxUSZFTpOc4rWgeDjXg/BVRh9xfFwSL+S5BUZVY9TQTk52JmATMh?=
 =?us-ascii?Q?aRm01lcVQR6BaHZVpsrGVOqm7fGFcKrkxQQjQLB8+FKdv2rYIKonLnOiF1GY?=
 =?us-ascii?Q?N5jRZwqqq2aMwH8oU+mMAB6ONBOTFWM589bVl0PR4ZSgkaJG/o47bEVxiDB0?=
 =?us-ascii?Q?j6I0tR78nal53qbLwujJlp6szRo4hqYuYDEKQRUPikD77em+i05XyOnXQbzK?=
 =?us-ascii?Q?Y/sf7mrjEumno3nColoomtLaJ066O7uFajIG0+rvlatjT1kjFFGEyiYVOvYE?=
 =?us-ascii?Q?2oPtN48XAELCANSGMJXxDRnhF0cZ0nqThW7wIluvHp6V76BrZO2t6DDTIwnh?=
 =?us-ascii?Q?gcuy5qQ9ztcSYku7LZ9JQHT8T5GZdMFS4heJehq8EeT7exFMqiZwxdVAR6kZ?=
 =?us-ascii?Q?7vm/3wIrhAXc1YdB0Sh4bh6Llo4ZGKb2o8IiYOxValtzc0MNayM24AlGNV+S?=
 =?us-ascii?Q?+YJ9SeBbPGDi0/l34mwbSkpmhXwjzOHWwtTC+kAlcxUkEjEEzH3AZ8Ohs1Wy?=
 =?us-ascii?Q?RAgWOTMbwLKybSD6TaU5uD/5hVDg/+npnfJ7+mxMQl2FnBJQ8zVfIvhTBoUT?=
 =?us-ascii?Q?genuU0vDG02ErUQ6boW+UWeb/DkZVaOc4MwP13eB+aG7dT8/UK8K+2vjGX4e?=
 =?us-ascii?Q?Mu0RWRboyZmlCeU3cz8I/M4kkj6T1Ad9jx/BpYE6Uk0vMtr5/iDgA+4IRxwx?=
 =?us-ascii?Q?OJQmit5SGny7DkiuAQU9MFpQSngorbMcfXymeJaTRYyqHsxyRgb04ElTl9a2?=
 =?us-ascii?Q?GIxbQwhonN1k2rEWdPndzrvUHU6Y8k+lfvsJOn3IFOm0qbv5YRlER6hAi1HF?=
 =?us-ascii?Q?sfZ0Sf5ljgkqM7qvbUm0uEe/EyH/gKntxKx++GfJVyguAL2/qJeH5vmoO4Kn?=
 =?us-ascii?Q?MIdvf8htwowMQVi/P3MZO1afNXWeUdb1Fdb96+1weGTk8OYLDHeygXQpoeDL?=
 =?us-ascii?Q?mUe0OGLhpk+vxJjCevGn/CFQYo7mUz5yyg5WCjI8Pc6elN9HK3cnBP97xGCm?=
 =?us-ascii?Q?5YjBGfPYwUimKZ73ioFmU8SoAY6M79GuNQyb?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jQVGO8pqQ4OQsa+IgKutA7KFTMuMrlsqMk/wxUklSt+dxqZVMmohZ7QLOqLT?=
 =?us-ascii?Q?oOAS1AftLcBYJvaVgMUy+h5JZSBk1ansV/17Y7TvO9NkZzY9v4OTJdT8oQ8b?=
 =?us-ascii?Q?nYBbCCnT4vWL2M2AB8xQ2Q8SahocDRmFqU6sm8nRSUlhz08brkp17v8gJqbq?=
 =?us-ascii?Q?QvyJgLpysnAxcjVkn3icak8KZxZjWviYo18GUvbD4z6k5di3keudPCGmcflJ?=
 =?us-ascii?Q?uvtEvgmffLVrlPccje6SOzIiexNTD/oZQ2vxPSpI9vEimNKG46TC79HNt3ud?=
 =?us-ascii?Q?W7Y2lN7xs2H/eRtAyTrj6K7mETLndB32yXyBKkYfAFVDNQ/8ad9YfueHB/oj?=
 =?us-ascii?Q?gz3vCwPhxhI/znDw8UxkiK8SATs2h5E61MQnEN2vEJJbczK1BbV4C5KgE0KQ?=
 =?us-ascii?Q?96kUYBhYsKss2iK45OpznUNAhuT2lV4is6u4AnFU0ohqMHNbnyz1OB4NNo5c?=
 =?us-ascii?Q?ZG3fAaP8QVbE4FsD4TjRJwYLi7nzIhLFLhWVIR2EZQdTk7xRC3dzW56GtJ+3?=
 =?us-ascii?Q?EIKiexdYb1LozbqeOxZYie/cJlMuYuY6FvZdqOdw2+W0nmCRVW98SGoKQ3sH?=
 =?us-ascii?Q?FSUyxzxOYXSEpLB+aoNWDgEzCsaoJvm+lQaU1p2SueYshGlAeYK2qQP56f5b?=
 =?us-ascii?Q?BrOLiRcyWwtyWWJtgaxWSTlDy30kYzrcIZoBy7eCtZvTzkwkF/vFJP7u0KCd?=
 =?us-ascii?Q?FIGjOVGi0UTBjRdQ2kUY7l8XF/WtRy+IhAmdAJsB0mKuxzP/Ju8ULj7xher+?=
 =?us-ascii?Q?5E2eu8rVL07ryqkSUBdItIsvGLhjPyBEiQbvnB4pd4vKmCttUI6j1mBCXJQu?=
 =?us-ascii?Q?Xghb5ldG6Yqs8Qb2m7ZiRkl74k6oNu/Ns6HSOGjR/hn9CqNzC+0yWm9iqhuV?=
 =?us-ascii?Q?+UyZ01Yq6vCNrkPno69CvIEIdrluHFycUZwi978UgXlCG4H1tV2eIGZCt6YI?=
 =?us-ascii?Q?tRJHPOZLaGiBvohPNjm8vHOBYoiQMzdMjqgT8fRQtjcOvkZ6GRhD4k0zLSLb?=
 =?us-ascii?Q?dd8ekpQaXGfQLFG/5YPzfqpZymSId/fxrTwqtXKjGidEIB9OAUfkF6A0Bq2d?=
 =?us-ascii?Q?U2iA2FD6kijtlFWh6dn7hiLqeWAEAV4a0ikzMNqxDB1scll6V/i04gMRUF/+?=
 =?us-ascii?Q?PNELwakxrvtKCPT+Dn7OjLDoIXVSRD3D8cdw4g+kRIDuAuoSj3+QiLYDCFos?=
 =?us-ascii?Q?O+SYMQOw9xi6Jc1FexaFkXH0g0bA+cJvbO9s6demAP0CVMOc7udNGEb1x90E?=
 =?us-ascii?Q?7MpzKvfciUAwzckhjiDHI0RZ5qzPZrPamPgaThsizhY6R4lEIZByHmvOXfQ4?=
 =?us-ascii?Q?lGmffBjbDIJ8oL2rE68iiw1xIK+6+G1JDZTpgpbemXeGX6I0XgRnjXOSKGuV?=
 =?us-ascii?Q?ezfEuvnpwmWpoN3xecQbdW2zPV+wLxr0fR2UjvgWc5GNLTlZwzUHakxzX7dL?=
 =?us-ascii?Q?nfuwfA/+ELoandC5BEJ3kZudrRCU3bUP9j3aNO5s0/NCVutXjoql3kKOncZy?=
 =?us-ascii?Q?AFlRDhYOjbUhSX2kTo+epijyTmxt4QaDMunsIqffppsjsz1K52CsOH/YHmkC?=
 =?us-ascii?Q?TdneRNUYumJBiLvb/vAW/AQ8rDNR9RJ9BE1/yQpH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb647d4-c7ea-4424-6034-08de056e37dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 06:53:27.4905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nyYikC/gdgSwhkmkDypC5lJi1Ob0YzVEO5oxGKm/GZi+CkVUcGUQC1NbAR1QQE4uXIv7PfuwrvZdHhw+36t9eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF820E5265F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDE4NiBTYWx0ZWRfX72MBk8knCyi8
 YGdbxKHkltOcsVYwgq/7/k4/u/u7FMJz6VejSxxsKYbJPKopv+O4nVCF4oJsYWSQZ7k2DfPjSK4
 qDgDJK4ipWSjqdK2otJ+0i7WmsAwct5p6G6a+2skVoVDcW8FdlLdka2MppQXkNLqLksakNeL0us
 CJzeG1/7/Uvc1xjY9oyU/QIPc241pipwwm6TS5PdzGBRmGZmpwKnBoQtniZt40+ZGIP3C8h6P4M
 D5gkJfInqOZvHP13ojn4UZWOW86oLcg1GvDBK86bG4HV68KvZMxSBq2DixnfCFIVW8FDTNLqtiA
 QUZTzhOY7BsM9uTBAk9Zg1ur+htr4N+F5Pok/dZEY9gcp44xv0z5stnkNIsm1lZzgiqRdOBJYtD
 b/XW0Vo4uZPxac3G7fMiQPI85DIu+g==
X-Authority-Analysis: v=2.4 cv=ZqDg6t7G c=1 sm=1 tr=0 ts=68e4b8f0 cx=c_pps
 a=WCj0fYrPW/3OlnWPEMveVg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=trUtw1fdr_ybtP_4VzEA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: QQ5PQBNM5cmYTEfsVvonyEnwtp11by2P
X-Proofpoint-ORIG-GUID: QQ5PQBNM5cmYTEfsVvonyEnwtp11by2P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
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
> From: Tejasree Kondoj <ktejasree@marvell.com>
> Sent: Monday, September 29, 2025 3:58 PM
> To: Jerin Jacob <jerinj@marvell.com>; Pavan Nikhilesh Bhagavatula
> <pbhagavatula@marvell.com>; Shijith Thotton <sthotton@marvell.com>
> Cc: Anoob Joseph <anoobj@marvell.com>; dev@dpdk.org
> Subject: [PATCH] event/cnxk: increase inflight buffer count
>=20
> Increasing crypto adapter inflight buffer count as performance is dropped=
 to
> zero when high traffic is sent on 16 or 24 cores in event vector mode.
>=20
> Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>



Applied to dpdk-next-net-eventdev/for-main. Thanks

> ---
>  drivers/event/cnxk/cnxk_eventdev_adptr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/event/cnxk/cnxk_eventdev_adptr.c
> b/drivers/event/cnxk/cnxk_eventdev_adptr.c
> index 80f770ee8d..3380712095 100644
> --- a/drivers/event/cnxk/cnxk_eventdev_adptr.c
> +++ b/drivers/event/cnxk/cnxk_eventdev_adptr.c
> @@ -667,7 +667,7 @@ crypto_adapter_qp_setup(const struct rte_cryptodev
> *cdev, struct cnxk_cpt_qp *qp
>  	snprintf(name, RTE_MEMPOOL_NAMESIZE, "cnxk_ca_req_%u:%u",
> cdev->data->dev_id, qp->lf.lf_id);
>  	req_size =3D sizeof(struct cpt_inflight_req);
>  	cache_size =3D RTE_MIN(RTE_MEMPOOL_CACHE_MAX_SIZE, qp-
> >lf.nb_desc / 1.5);
> -	nb_req =3D RTE_MAX(qp->lf.nb_desc, cache_size * rte_lcore_count());
> +	nb_req =3D qp->lf.nb_desc + (cache_size * rte_lcore_count());
>  	qp->ca.req_mp =3D rte_mempool_create(name, nb_req, req_size,
> cache_size, 0, NULL, NULL, NULL,
>  					   NULL, rte_socket_id(), 0);
>  	if (qp->ca.req_mp =3D=3D NULL)
> --
> 2.25.1

