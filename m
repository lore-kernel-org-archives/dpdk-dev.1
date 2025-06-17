Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD80C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 21:34:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 670AC4278A;
	Tue, 17 Jun 2025 23:34:18 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5AC91400D6
 for <dev@dpdk.org>; Tue, 17 Jun 2025 23:34:16 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H9EpHw030038;
 Tue, 17 Jun 2025 14:34:15 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2106.outbound.protection.outlook.com [40.107.237.106])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47b5jcskw5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Jun 2025 14:34:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sn0wzq617Hdbw7EFKFcSXXyx9gzmPEqRy+xKCAIQIsJgyxta/Aep8HyR0WFZBZOJituUqOHGepn6d4No0WitM5pfHIrYMIlMXn744svlwDcFcYVanCR4i7nrM2v2WIpRlbTsGSnmeHxuIBpCZMQQyzeTUQ6ydNL77QMicCRjJRwHvfNSHq8Gl3iYA0flrlDx/aGtGgkNCYzAOLeZ7bpfrwWkZ5QT9uFdYsg4YBgtW9wqix71FFfLk4++Byval0oGr34LGErlm3ucNVwsbzv6KzoJG5thAqnnqxQ6rZtzSjD46kJXtnsSHoAZA0/qemm6/fD2XLgxREl1vOZBVfXWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5ncF9FZPLvWJDjNXLolMeW4X1Whv4Vay5XPhWaUOyY=;
 b=jVAHdqfCQkqTLq03nAOo2T9zrramvJlycky7ZvzYQ1XpjrmOQxUhEQS7lCxY9odI3l0uXZeb2EcgOhI3jEWkSEMeL3Qzs1JpefOvMKnbYUHkR9tVDdv+No1vFDyYrLx6UidA/wox1x0eyaUJpyYGpE0noH5ZK+Kl8emnDLCI19W4WRyx/eoKiC36zqY48ul31uiUa0GSIHY09QbAdDXNtWjCJmYm7fqGakTAGAWoM5omHS8uK9PkU09z24vm4+osWVHwcOjUAMXGxmedZF5rjio1hfD5R1uTbOr//HOjIO55rxsLogydztnve7HUZ2V5yHPv3y58bAIu6bSpXMW/ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5ncF9FZPLvWJDjNXLolMeW4X1Whv4Vay5XPhWaUOyY=;
 b=IoqOlttt7+d4sB/S7Vy7frtk2+5sNXTLJx0zBtsdRnX/dXBkTmFBmyoOhv9QS2HGLWdAq1zxLyaQm/PPm7K3MdRRCj7JyhJvK/0qMxCHlf0zAcPvCAQNUjavJvwVlg9juGACYmM4TN5iF+L46q06L4GH327a3ia8NtYuUIHcS1s=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CH4PR18MB6272.namprd18.prod.outlook.com (2603:10b6:610:223::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Tue, 17 Jun 2025 21:34:11 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 21:34:11 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Sameer Vaze <svaze@qti.qualcomm.com>, Sunila Sahu <ssahu@marvell.com>, Fan
 Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] app/compress-perf: support dictionary files
Thread-Topic: [EXTERNAL] [PATCH] app/compress-perf: support dictionary files
Thread-Index: AQHb0TUsyVBQ3cr3r0uK/R8h31ucUrPrq/gAgAeQrQCAFL6XkA==
Date: Tue, 17 Jun 2025 21:34:11 +0000
Message-ID: <CO6PR18MB4484330DB3461425B5FD4AA7D873A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250530210956.1207580-1-svaze@qti.qualcomm.com>
 <20250604164134.776009-1-svaze@qti.qualcomm.com>
In-Reply-To: <20250604164134.776009-1-svaze@qti.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CH4PR18MB6272:EE_
x-ms-office365-filtering-correlation-id: 5ba4e5ad-d49a-4c38-54a4-08ddade6b2eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?MdRmdfEVWTNawCg0v06Eu8USFxjx04fHyqWvWk85YCfyMijo6oQSPEgR5Hj4?=
 =?us-ascii?Q?OeVPDj5AJPriCoJStS9ZP58lTxu1Qw3xKlOA6DKH9HjhqZZ/ppPrSoJQ+SnN?=
 =?us-ascii?Q?uto2ttlXoeYsyl7ndiRhOXEr0lFlXkYNNW3uCq4MT/tR35dwgyt5WiE/6fpS?=
 =?us-ascii?Q?4qMrRm9AZnnFZS2vOU93CiiQgefbuCdY1o0es1rG+aD7l2Cvx/ExrlIvaToI?=
 =?us-ascii?Q?cEZGmSBMYLSPwD3OMpNir9eN3aId1mZcvYr8abweVZZ7HBwcaWJnYMXhNVXn?=
 =?us-ascii?Q?tVYbfSbeeNaca3k904QOFIt/95ThW5Wy4JVK0T99xBnQ43qfOmj44TQnyEKc?=
 =?us-ascii?Q?5X8IT/6VksiEM25VUhb3QOiidAO3hZ9eq4cthVPednT4ZrRFo9V59h7tIqiW?=
 =?us-ascii?Q?cdxxt76g3Fyl5wMK3oq6RPm4eKYtH+gMvvmgACG6X+c8fWCayS0u94eCwwTH?=
 =?us-ascii?Q?DAfERuvkJ1JNMroJ+yxdri2iUTHQzox7D9GN9N7x+yNd8eNR5i1WyyLuAo59?=
 =?us-ascii?Q?4L+J6S4ZHjaJIaFEq/sZRHoNcfaAR81/udbWpPf+jzmP5KOTaVu9G1LOQQ6Y?=
 =?us-ascii?Q?276INFpUY4ODtBP3Xfo5P0V22acV7xSfpqjHF9YeUs4HjjfAzeOjPhIINpcf?=
 =?us-ascii?Q?x7rk5aUlfYjSxy8aR5sksQx+GjJaOeZGlEn7BM2dHB6WmvojX/24wGZQgkn5?=
 =?us-ascii?Q?p1q2io5Ii3n5BABZg8MG/ibjuVu7l9+ykQohKlhQ4CVDaFjFs8CZRHimCS0E?=
 =?us-ascii?Q?WtTWk5AH6XUd7+sRlx3UCdHMDQ3S08qCpj8kcLJngvRwyk+yy9qgDP5i1vJr?=
 =?us-ascii?Q?sDVfInUBjkPaRV4IrIixDvt8ZCNeu7Tai916DFSzQq8zbqVF7Y+y5kH+2mlx?=
 =?us-ascii?Q?ugcmbhAAG2Q9aYWnguWMamaciRO96qnddrlNzqCjf+AlXSybu0Ir7JmGYdAv?=
 =?us-ascii?Q?91nYvqyuRFU9E9TJYv+DlLZo1g9XEn0q2ErT0Mz+VuzbdhbeWCv8t78lrEtu?=
 =?us-ascii?Q?IAsSvpGl98CVp+Ouxk0WHaPhC2ToR/nQXBZwyBBaXaoTRDBW5iGS/yayBzI3?=
 =?us-ascii?Q?iyvvel3Lz8ORKihlnRVIrq2IZYH5WgAFE2HG1C4Aact2rrOcXjnFssirZvj/?=
 =?us-ascii?Q?92mxXCY6GORzGkhjr1sq9CSbcEy9hTHGdIuwf6teKHEY701bm5v/c/sSB+Wr?=
 =?us-ascii?Q?B3/qrxvVFnFN0ePHo0MxJayujj7GcGpb67lgnqInt9bcu7doAyjuU8ItycQ+?=
 =?us-ascii?Q?5w9UU2PzVQzKES+VpUW6Hg23q0oqzY7EnyBMbkLzFophvfX9+O4g30tBu2V7?=
 =?us-ascii?Q?ytHXHlGz1hgid9/rTJFOCGDTMXvQZJRwEVfqPZKrWG4Xwskzl8jvdQJzkmS0?=
 =?us-ascii?Q?dt2D1Lj/sErIE1kBZDzK4bm+iVm/Wc3e3wWMPGHZr0N8vyQTXw1DzKjSENyX?=
 =?us-ascii?Q?/dn+6+oKJ/KlA1HW9Tby4FUUGbzhkq8c0PFatyGEzgqueZZ9muqxAQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i4kdogGiSbHodQCCv/19xgreA0RXQRtt2wR5sMGqDWSrop5Xv+/zPgBWDA9V?=
 =?us-ascii?Q?mo1wCSTHh3E6rffecTiLYhAxHOa4aD4vUawbzRXPyIRv1EmZzLQ1i1/4hBwo?=
 =?us-ascii?Q?iNssIe5LHXRaq5rLkTvQ1tQc3kvFrFZuDgmoVgYNQ939JThQ7FVZcfoRsnyW?=
 =?us-ascii?Q?cbPPGF7+3yu0u4vfErnHn1fBGYKHugOTlhy058YamApXWrYcgjCAG+eyFs1a?=
 =?us-ascii?Q?LcQVEFtIVOfUyr4Nrwy4sbDA+TczffDxeFg7hhFfZF5+A2iJ/HvPUNA+kgH6?=
 =?us-ascii?Q?IMOX38g9vUXJrA82B3j9JuC3mdFWSbg8pjW17hW2+SRLoqQfksXRbbB+Xid+?=
 =?us-ascii?Q?cq3T6JeZzQD278TuvR9Hcug6Rakx8PREfpBJNpBE9WL8tVIGAuUN4YONRyQ9?=
 =?us-ascii?Q?D/MHBC5tmzQBP5iz3x79IaM99uf2z6+Tm5hdg9DZHhQ4ayy7ZjBDh8RQEbM5?=
 =?us-ascii?Q?LLX7uNYYJNaDOhvb4e8lJUdDjHcsYAvtsGANwUioUG1uHcmAC9xvWzF7rhE5?=
 =?us-ascii?Q?xUG5s9GWuC8qtE4wwll3GgGYbfKYS8Bjerzl0tX0YDNkNIxilU22Hzur5jbG?=
 =?us-ascii?Q?zJyFNmUxdWOBrkPZdB/QCZ/vpDDKUQKFTFkksksvhJErsCsV3PPMY/aPbQRt?=
 =?us-ascii?Q?y0maZD2oC89Y2zHpWmyE6G1wGEc7xSODGqJKXu6z0/6VV/hknL7R8gnNhKqb?=
 =?us-ascii?Q?6roLCzkbtqTVAt3HOzLEetgGFrgNJeEh73jYuN66PARBFzSOW+zbhgKsfiZu?=
 =?us-ascii?Q?IFOfQWicpTI+vOVgHdM2Lqszs5pBP7Qqpx5Y8AAicBbyMsF4XrkrpbtI+gt2?=
 =?us-ascii?Q?W26tdGZwCL8mPgABdMeAWPdLX3KCpK//hwU2rPH4fuSn8eyJdJ1ecZQaw7V9?=
 =?us-ascii?Q?pP/0ZCvr4wHLL+LGmR7eQOdWls9Nu26rtK1xUi7O2mIwQDe7/q79GgJObSoJ?=
 =?us-ascii?Q?ZS79eXU10cA9tSBLSCCTWtyCvtqfYc5kBLFpVtVkdtoNB4a0L7oWx6BwfFF5?=
 =?us-ascii?Q?c0MOkjg9wH0IDH0jQpkNIIzfqs1Urfhi+mQ56tcIZ+lI3N2OtjbzoF98XgTv?=
 =?us-ascii?Q?4UzTUerizhzlhjxd9upYYYnrLCObJlHUEvT+6X1vVvyS0dfrRfSepWgXydgb?=
 =?us-ascii?Q?L0YQS0ugm/RemEZupocZ2Fz0J3K2CPSYu0DbniD24nFAJz6oZRUTbQy+hvkX?=
 =?us-ascii?Q?TDtbeEaSrRJv+77bRLmIcBVBV8KS9fHGB/QM+81JAwVMr7of3Hn39Za+hVFJ?=
 =?us-ascii?Q?Fj6L3j+Ga0a3oVQOVuhM+U57ycvehb7/OhPBYhSng3n6EZ2/6QZYiNHQLBy7?=
 =?us-ascii?Q?xYwo3Vam4XS+/B0OC5P6DDSGZVjf449ht5lHmuolojVkUrkzGVpyfqh7KouD?=
 =?us-ascii?Q?4dXmKoxOIYkBqZjSkWjeQIPP20PF0o6jfzU3jMq72tQyuyglXWcEVr4BPlhS?=
 =?us-ascii?Q?Jh7RJhySjr7DRpZYfR0rNviQKFVJZS96JU4uNSRQ6rH/65l+J+ofgtqW4Tj2?=
 =?us-ascii?Q?bpp95pIGWpbAnhMzs00P/bf4xJyDx5XJeyCJCNaDza47owCj8lVu/EQOSRwR?=
 =?us-ascii?Q?EGzosr+2d0vPiF3RothCYNNbnMCWAtjaTs0itNSD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba4e5ad-d49a-4c38-54a4-08ddade6b2eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 21:34:11.1944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FHH1PVeCA8R/2uT4v2DQ3LwiXR1cjw2QJ24gWzqukZQVIt2FSiRLatZ08eGg9dI1tyxiSR8wmd5HQxsS+7MqYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR18MB6272
X-Authority-Analysis: v=2.4 cv=YaK95xRf c=1 sm=1 tr=0 ts=6851df57 cx=c_pps
 a=EB+sJnAbC/61O7AwsuyHcA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=EUspDBNiAAAA:8 a=baYcRh-HnCDIpjJY-yUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE3MiBTYWx0ZWRfXzQShICLUuMiw
 wDHF8CCJNKn2TvsP2aPlCrioHNfsazRqjCW+vJCCjnDiV5m5qXQXnYggAZNJvGINaSz1LblKQoL
 xnesRPWnQ5XpD+XzFqb/DdTMB3WdrDVFTnHZKxzbkMn6SOBZxaLNWWMVLyKAlvWC3yt1/ERv0ut
 Y05VOQ/ODS2h5tbJhbUkpZMIlh+jIMi1nUiS5pcND/AhUARvePGHT5DSLNvCpc2stqu0/i+6Na3
 3dfrBqS1di3FF+X5/DgiGhQucNaoDr+sBuXgwVj3hvj6YIxpmegt5Vi0jcsGDxv2BtwoaWgeU7z
 2ScJEPBvrsp2oXa9UEysxQ5Vjkg94HmXr7Ik6a7i/3+DpRqBE9SmDvY/vX8W7wFjr+A4wv2g4r1
 rUqXf3NJ6C5qs9sqL2t46GC1SzS4xUw3pW5r0dEkPWWy/9ITAC29Rh+s20p41Q8pPZd8QJwa
X-Proofpoint-GUID: JpuO2OxNiF3yyf2KN3KmzYF_fhV4WcVI
X-Proofpoint-ORIG-GUID: JpuO2OxNiF3yyf2KN3KmzYF_fhV4WcVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
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

> compress/zlib: support PDCP checksum
>=20
> compress/zlib: support zlib dictionary
>=20
> compressdev: add PDCP checksum
>=20
> compressdev: support zlib dictionary
>=20
> Adds support to provide predefined dictionaries to zlib. Handles setting
> and getting of dictionaries using zlib apis. Also includes support to
> read dictionary files
>=20
> Adds support for passing in and validationg 3GPP PDCP spec defined
> checksums as defined under the Uplink Data Compression(UDC) feature.
> Changes also include functions that do inflate or deflate specific
> checksum operations.
>=20
> Introduces new members to compression api structures to allow setting
> predefined dictionaries
>=20
> Signed-off-by: Sameer Vaze <svaze@qti.qualcomm.com>

Seems like multiple patches are squashed into a single patch

I see that this patch has ABI breaks.
We need to defer this patch for next ABI break release.
Please split the patch appropriately.
First patch should define the library changes.
And subsequently logically broken PMD patches
Followed by application patches.
Ensure each patch is compilable.

Since this patch is breaking ABI/API,
Please send a deprecation notice to be merged in this release and
Implementation for next release.

Also avoid unnecessary and irrelevant code changes.

