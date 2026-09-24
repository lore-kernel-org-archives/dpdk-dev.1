Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2594CC9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 10:40:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3596242F02;
	Thu, 24 Sep 2026 12:40:55 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6613B400D7
 for <dev@dpdk.org>; Thu, 24 Sep 2026 12:40:54 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5e8aZ3983756; Thu, 24 Sep 2026 03:40:53 -0700
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021143.outbound.protection.outlook.com [40.107.208.143])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gvm3kknc4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 03:40:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoAcZeD5jBJV7k910TTa5u00tYgOvgINN1SLZgRym6KN+JEEMlrianwxqtc0CkKN/TBaYOmhTIWMRNTub1wBFwQ9Bw6O/DmZXW+ffIfwCUvuH7wxWDWp+Rf9DAMKPXpeMtXaldNm0OOPAP3GDJQa/GUUcrtQUvzyT1g4d1AO88Ilt47UPpoGipJEQIMOAahommpfSxU81zkR+GCcJPTp3w1ctR0nfWmfSoFQ0aWbDTnCLOYdjSICGAacf0iAnnHzYsqtg4pmc/0wNm/jbVJYooNGWfBA1funMg2087m9YykF7R+0l7zGbhYGChPTI7a9wGKo2dh+dtG5I2bsPYJxQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoRM92S3tfFIAYC9ELFHxczmlksfhVBxH10+WSYs7xY=;
 b=ovf6dcI7Izv1fAl02p+MkoSXdN5Lx3RdElCqoCKGPdtt81w2WGHILb3ky+KQZkxlERe1C27zVhdIfg0wBxl/DRt4g+c/1i+9mfH74QkpgDb9PmWqgoGMURSaHxlJA+fGbc7JS3y56zC7eQpeb8ESabErNrp2imCQoEIM+QpanjUHa9HR862L9eiLykdC8t0q/e0vNmw4yTVppV6/t/xrL0j2eUTtoQ8GITRGCy83PQ5XpvdqQuQZzkggNdlqaSIfl2jlNE1ToP71buCiKc6o9Su9nAOrFpRRhLMKtujn00yyDWlcMU358+qmzsFlP5hjbkcY0FskbeiLz7vEQhMf0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoRM92S3tfFIAYC9ELFHxczmlksfhVBxH10+WSYs7xY=;
 b=b8js3YMr/dofE64ViMpxFgE4TRfvnGkCC4qtmZnI0ptrP5iVsP6+Zt3Y3Xk3j1TaR4gRjLneu1Kpg1D22K9YQAYK6p+9rtn5u/XP41csaRQ0bTeCzN+27MI9na48byFnEjKaWdRLc1oOd8LtsKtYzwLTL3ewJT9vgMbWHdoH/bg=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BL1PPFB109A61B6.namprd18.prod.outlook.com (2603:10b6:20f:fc04::dbc)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 10:40:50 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0428.015; Thu, 24 Sep 2026
 10:40:50 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Rupesh Chiluka <rchiluka@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Tejasree Kondoj <ktejasree@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, Anoob Joseph <anoobj@marvell.com>
Subject: RE: [PATCH v2] common/cpt: use timing-safe digest comparison
Thread-Topic: [PATCH v2] common/cpt: use timing-safe digest comparison
Thread-Index: AQHdLglmBkmLNdB82ke+0ZeU+w0UArbdxigA
Date: Thu, 24 Sep 2026 10:40:49 +0000
Message-ID: <CO6PR18MB44841750F8E43F5B45CEF401D8812@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <89e98b3ccc1ad93ed67fb5750c88df94f0c1ecf7.1785737875.git.rchiluka@marvell.com>
 <a6599af7606f89822590df4285edec38bb86b865.1786943875.git.rchiluka@marvell.com>
In-Reply-To: <a6599af7606f89822590df4285edec38bb86b865.1786943875.git.rchiluka@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BL1PPFB109A61B6:EE_
x-ms-office365-filtering-correlation-id: 9c516c17-c3f2-4097-5043-08df1a284cd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: paXs2xjLIkdMH69qDTo72Y3Pe7XypM4URazMmfr+ZlW9JDWBWsgbPWnJ6j722+WCmoAtVdrQ91D7I2rPMYIy+CfjOqOq1RXGcq1sykAXuDlBJiCtF7+ofsXNrOm6QWsxxuFbFbL+CeIR/X6s5ORmpCJJ/gxQLM75n1UueKHmuHY40I2PrprlbsGLjO4cyE3drKjAtRoAeVZKLmPIQ0Mwn5ZwVR2G1TQmlSljOCkz0p1xMa2UIre4pGQ0p8txCJW3/l9Bnre/5EXzGI143WIVK3iez948LwFLrx9qWr8FhNPy6v4zxsovZXKMTdIGwx5YELbiiE/TadEQfU4OhPvs6SSvEtFW0Hhn/u4S1B3PQNhwbp+x6iSDTX0tFEO6WJMOoXe0kk4UqGx3hXj0ctyai60djiG7idCBJLvohvYh2d5t0godMcGMtYwUxSGbmn1NUFTh81kUJs/D8UiA4dpOFwQKy/ffIkl7lEdh9LArq3u4pj/Y78aSEG2ysCAtMhHJlaCFpchdToECO+p+kaTfn01pg5R4y045pMF8Q+oqn9cVYn9xIGOpaT7dbt9hj+Ao/tLaDPpbS4KX9ZP6C6c1YeCY8LISI3/hunWjbVe4G3vZ8mBpHXe8EEdZprkeDHQyJlM4uaSSTJYptw0/UrhJK6zGzIJpT2YCEJV88zRMbYmo1WtVTKsQbyN2FGX1WDWV0SuUWuN/fmCb7pQU1sn3dpsn1XOjX8Fw+M6mclIUqZo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Il/ARDlET6Z28vi90ibuPbTLZs/z4so9v+nu5PoAC1NQ5k+38EjulDshZN6p?=
 =?us-ascii?Q?+MGmm1XURjsHprSpNKiND8Ud9ymoinCxEn78ThibC1KXtY+o+zlbozjIxZ8T?=
 =?us-ascii?Q?ujAvpOWOkb2+ztJgBv8PECTsTEGyjAONIHbtDzMSmYxneHjlphHHHLuxsZ56?=
 =?us-ascii?Q?NGRNNMckYMlUIuO//ixgZ/wNcybqhm4PXrrODAKVUhrFgyDU0hbHHkFW7vyu?=
 =?us-ascii?Q?XhOcxIFPtJnVCwiZUFz+P4KQPnQvRYXFgQG7O5OtiexBE6itKoOBAH5yzikl?=
 =?us-ascii?Q?v04dsDmpI7e7zJaDmChh7ALKRoGtF8iMsrMR9G473U3L/u31U56WuZaZ4PP9?=
 =?us-ascii?Q?qZRL+ETdEQrnJOibEqw1lw8LphC1l6hD4W2y5kqH8UBaPDIQ9gy95Q0zgeKA?=
 =?us-ascii?Q?rOhhMV2k5dGHdqr4PqIvYuqsSHToEpVbn4bUMwmVBH7u34cvjDJd8H+YqwZB?=
 =?us-ascii?Q?a+EyymOgR1RGfDGGcGI/x466Xs7PYDshGew0OPiDD42kvf8lJXkjS9a1s4fL?=
 =?us-ascii?Q?mK5eI3p2n2sKArf8djsfnQssfuMqlNeheYEukd/bDDwqHohlJvzttC/qArXp?=
 =?us-ascii?Q?FC1Nc1zsB/jQg0CvlkJuafmj5kXQbzvh+77oApeT+nNoTONcIHS5gworYuOm?=
 =?us-ascii?Q?8Ajdw8B1phDtds83yO+v5ULhwlRXTIIX+eu50oc6kbf/E2CcdWzZ8Y6cTMmk?=
 =?us-ascii?Q?beG/AejQvXf1QYOd7XNrClTM0UkA16Vt8pF2/zLPFe6QUmKlFGw2isPyHqTp?=
 =?us-ascii?Q?E1tNAnB+bIs1lV8ozotO0/iHY7/+MpAE+u25AhGvUh8VqW36FzfMfAKqSayj?=
 =?us-ascii?Q?StxWDzjiYiBdLR16gqZ9f9mFERf4cbEzRSTmM06+3oaf6KJtQRnEg5xfZPT/?=
 =?us-ascii?Q?YHVhzticoM+jDbuWA8/pdee/Gy11G2/CvAjZyOGuQuaxireVFHZzYn5oC4g1?=
 =?us-ascii?Q?PGRV4PvWxMliri9hR+b+Y/H3JferpJaJzn5Z98YQW05whvTCz7rTvIvckwME?=
 =?us-ascii?Q?mh6D1pRYJa0ZGs8XPyjq/q5spcMgS4mmgaD/NFIKrG5ZcEYtET7ucqRStHRq?=
 =?us-ascii?Q?fps9I1O9sEvvMOAz4NH52fLhLLYOnHlt1Q4ghKo4lXXZq8FzB6tMJEVC5FFD?=
 =?us-ascii?Q?CKcG07SXcVX5a627t/58l8bsAIZwmVs3vRx4+s9umJ/YAh2EjKglWNnwScyl?=
 =?us-ascii?Q?ezDr4AN2m8JODs8LNPlpZ45ciY/rGQ7K3VEicJxcbrUjHz5CKti1YeZzakWy?=
 =?us-ascii?Q?Ju+gB7h5e5fgqwxpGQZCAUWRzaidWqCMu5cXcsiPpRi1eLCCWPr6uBVS7ond?=
 =?us-ascii?Q?z+uJfJ0yL5+sylToMWyy7GHvyuDopiDCBfyZGD3rPTqtJ0tN7oVzEGZ/sJej?=
 =?us-ascii?Q?kIjc1cDpywBMEHJyPcZYIIftB5GbhuqAhavDziMbXlnAKd6B74ADvXyW6k5j?=
 =?us-ascii?Q?Cvrm5SPDK+H+8Dm3SV80UzO5fQyov6GPuCDnFetGH7Ib7yFhRuyB3fAYHvxO?=
 =?us-ascii?Q?sSpnpkIcmJIFTIYWZk1qBJsvgl1OEZ5LffvJ7vXhydIzCDlMp2vb2HzCqC3+?=
 =?us-ascii?Q?ULpkm9pVgok1+dJh1sfzHGt5iWb6nk3wkGSXYHUf5/JtQcpBM8bArb+YvxzH?=
 =?us-ascii?Q?wBXxhdDDowW5BP0B4qpK3I79EsXVeQq5AkZfxl5rO4UHLOpIc2a5eIJKHk7Y?=
 =?us-ascii?Q?WqanumqyAnun85l4zybo9Di65vK3oeDqhEb4fXkF8e4EBjOY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0uJ8t0fDMSlTdtqRj0M3lYEcMDazfYIqTh5EVd27drJ58tYTdkQgCdedJvJxk4ZzspM+I4CqPo+RLN6o8Monr/Bo7PAY71zYfuvniEv/GrKsE6MzHkdkx/ozgM8bW+oBSx7Wzr+2Edl/rxc4aCOdSHUSk/+n0eH7sgXELVkelDdfYFJfgBr9KFgS52chZIrw3qLPbULu2q9Dfx0D2OhF6EndtB0Nx9fKmXaTP9gPTS6xYgzVGk8D928i+80I7umkbBKx67G8H5O9JAPTIUOO57wyARNFzjcprSVV82KmKFW4uyKdLdabahlMRzIJ10i3ISrGALsTrnqtOK4eDwXM6Q==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c516c17-c3f2-4097-5043-08df1a284cd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 10:40:49.8941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wsVdxCK7PNLrwViqJgRWCN7biJfknuF4dDnP8Udn5WjSOnYd0RlLQTBQ+ks0qLJzSJnGW9Xv52AxbmiQ8o6r4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPFB109A61B6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NCBTYWx0ZWRfXwHxW5Kjsm2pT
 KUJObJd0z17OB6a0l/yP6SHExe3cPsdnUcY77ApnTXdzVoYw6lr/EZ76s0IN1EvIPiHp6LMb/Ap
 y5lEBnJViY3NTXf6keLmid3p50+Wms6P5f8+/0TMx610UqYLaRa1ZbDiz9x/kcKNaq3Nppedyhq
 mFZpOg2B4MRiPR4Ipd3DIut5aQn35HPegVoO5vV7NRuhi//QMDvkuMMd3aZaAxsxkUIuSQAtJO6
 LzDE1qQtIawuaE8p2bs9gXenqvq2rDWli4uzj51x5w2/5D2Qf0AlwXkjKd7T7bDtD+yOxKwdklm
 lQs5k0U57wVtkRQTRkUCXtq+Tib0rT8gtIbT67qqqR8+uHZshR5/bNIDitKSXulolmqRNshq3eC
 Ym2NbpyEn0f7j0BKhUuTzizMR+Mc8Xbugvvf9H9VwpoG/bWT6xMS+6JaMZQCdmKOStAOZFpMAom
 ngUBqloi2NJPMAPDuVg==
X-Proofpoint-ORIG-GUID: ZlgqYjHmuo8vYMK7UEFAh501IMhNcKuX
X-Proofpoint-GUID: ZlgqYjHmuo8vYMK7UEFAh501IMhNcKuX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NCBTYWx0ZWRfXwKePqQR4W8yQ
 4Ueq//MniBvEQCUEONbmyGPm0VEcVaxnQtWYxBHnFqXoHgUgPcFmt4gtAWiTHL4pT5zfJZdWLPb
 xH+F1HgaYETagyXy+yGwPnKqMDre0L4=
X-Authority-Analysis: v=2.4 cv=LtQHWXdc c=1 sm=1 tr=0 ts=6ab4fe35 cx=c_pps
 a=QMhPzt4RVFymwNJSNtbcTg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=jZVsG21pAAAA:8 a=U-ZkvZcfVcgu1Xw1N10A:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=3Sh2lD0sZASs_lUdrUhf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
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
> From: Rupesh Chiluka <rchiluka@marvell.com>
> Sent: Monday, August 17, 2026 11:00 AM
> To: Rupesh Chiluka <rchiluka@marvell.com>
> Cc: dev@dpdk.org; Akhil Goyal <gakhil@marvell.com>; Tejasree Kondoj
> <ktejasree@marvell.com>; Jerin Jacob <jerinj@marvell.com>;
> stephen@networkplumber.org; Anoob Joseph <anoobj@marvell.com>
> Subject: [PATCH v2] common/cpt: use timing-safe digest comparison
>=20
> compl_auth_verify() compared the generated and received MAC with
> memcmp(), which returns early on the first differing byte and leaks
> the number of matching leading bytes through timing.
>=20
> Use rte_memeq_timingsafe() for the verify comparison.
>=20
> Bugzilla ID: 1773
>=20
> Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
> ---
Applied to dpdk-next-crypto
Thanks.
