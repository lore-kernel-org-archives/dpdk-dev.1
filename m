Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295D7CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 07:47:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F3EF40B90;
	Wed,  1 Oct 2025 09:47:27 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1DC2540B90
 for <dev@dpdk.org>; Wed,  1 Oct 2025 09:47:20 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5916L1p2020004
 for <dev@dpdk.org>; Wed, 1 Oct 2025 00:47:19 -0700
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022129.outbound.protection.outlook.com [40.107.209.129])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49efefhd50-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 01 Oct 2025 00:47:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAJ86UYlR7KsACa+id21vBYWn26MMyI5tz3LkT+iUSBvZXZLUxtuD2LV2a1lDKhR8CEoDIP87j4EyzQWE+gJm9iJHskrwC99zgukQLeDMcJlAkCwhpopal8Z+WmrA61blK/W2D9afqWwisn3WtnqSRSBkxykUsCfv/DfH58FNfjjplfF43EtgX+Ju4z4upL0Dk2KXPCuA1jul7V5ukmakKrekBLi9E/WMKv/WdASV0bQrKPJcfTEVoyefcKV0eXMflXEXhRrAayxh9V0xb459w0L1M7N4bVRO8/iodyLGdycyFzDcqUGjkZ4Bw2TQt0lWIVbrFXuswKgHkNNq3R+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flsHwytDShIh6M6S9snRYcsJd8SMcwFKMS5iYHIERik=;
 b=eURrQwKk6d3dop6DRsqe4CGAGisNeVkf2VPOuyiYrG0AtVJt2XTfYoc4dXJyKun2twvtahxW7ujKbQygFsqE+ciyiuihEpRbKkvJrJqlGm/8H0W+pwFFp3I4A/+aKlDc3y0k6Hw/JB4yFGGxyzZhbQ7o3p9eIIuV2X5bEJB7WzVlaMMfWr1CWqbFCtMpo0TOSjSP5Sj/Z+WioomlBL1/CE0Nx7hEBWyl5TRwVFS1ptMCvR8Sfg+5yCS1865nyQf2B4uxW8TVE+5sEECRQ6x5ZUBxpxuTPnZHyZZDH/Av+e005+6b0syoVZWY+sUC1tVvJY1xR4iIPA5E6JpSNCOjdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flsHwytDShIh6M6S9snRYcsJd8SMcwFKMS5iYHIERik=;
 b=Pue0ZMZ0bsiObDpd5XpYLf7B42ZRAeOhVh5LM2p/Ry/ibvyL9m7hzmR/8gkhWqe4nmpAmK9q0XMFXarbHCSepfCQV+4NBEGwbiCKwRelt/lHXnWZB3Dq0AApJJn8gwaIK65SifcvXg9smyemfppzMU8HAZLAFjFtTiuwm1ln59Y=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH3PPF1E89B88DC.namprd18.prod.outlook.com (2603:10b6:518:1::c8a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Wed, 1 Oct
 2025 07:47:17 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 07:47:17 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] app/crypto-perf: update result granularity
Thread-Topic: [PATCH] app/crypto-perf: update result granularity
Thread-Index: AQHcBdiKsvYb/HgvT0KXfjXySAt9JbStQ3EA
Date: Wed, 1 Oct 2025 07:47:17 +0000
Message-ID: <CO6PR18MB4484137246AC11FCC40BE41CD8E6A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250805071401.207884-1-gakhil@marvell.com>
In-Reply-To: <20250805071401.207884-1-gakhil@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH3PPF1E89B88DC:EE_
x-ms-office365-filtering-correlation-id: 6dc6597f-4d52-4255-4bfe-08de00bebe62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?o8mwe7rCiioUO9Eqvo1P9xun/WxBxRb2kH9UmbjnGEd2gUDQjiFeLUUXUkzO?=
 =?us-ascii?Q?Mty2DcNiBGwUtV2BE7353KMoszOFq7mHQiTMCly/sAy9ttdBKUX6CHrMQ9Gl?=
 =?us-ascii?Q?z7Pa1HkgDiPrM9bqH+dzMJXVmnQBVfPnPCe0Hrcborqt7eJ2yNozHVfd9JPU?=
 =?us-ascii?Q?WAgXbEZp5YoEngFE2/wJyXhPFuwGERxCC6oCKTloo1xwfR4fJ4m/kTps4TUm?=
 =?us-ascii?Q?rLpyfVFsWa2aQy+0bePp+R+o65otz0ygK3I8d1QdlfKEXzOjS3QVbU/3crg0?=
 =?us-ascii?Q?5IfCkXr2pmVT98yHKZHJKJplqUKgMZK2VjYFKo04Bvc9ybMfRPGpA//bvSb0?=
 =?us-ascii?Q?YSvv87lVsZ66ZR7V9PsthjppU34UeEkpUTmlcj8WyWA9zEesyD5cumHWVAmE?=
 =?us-ascii?Q?38GZjKX+zIJa2Nn+b7b/NPfqw0xVaIbGPy5P/mfLeD+rMeS9/Z0PnaCSNZ8b?=
 =?us-ascii?Q?kb8EcCeqsSeH1TFrpSVaDby6ypwH7fjzK+1bfr1rYC3+P1LaYxmcGgq9O0Jb?=
 =?us-ascii?Q?ue9v2byXv51GwFZBBhXlfRSBa8kbd2KmnF7CC7nGLSI3hN4WuXNSGERiaOFs?=
 =?us-ascii?Q?UA3RM8+5XXfqhVCCvvqBRP8scpuibpXDhxPNvI2XIF2rqP2DX/vQ+Sue+6to?=
 =?us-ascii?Q?OEZKkPGnCyFMOEtQ+qvq85w7Pft/lwE5vkOPIyNKhARzbWmYvjHE1zVYsNcZ?=
 =?us-ascii?Q?bcFJzNMZBq9s9T0LvdDWpV2pL00dciG1Vx6k5sh0DFh/3pgjfTTZgZR607E1?=
 =?us-ascii?Q?qmwB56TRgYH6x083G7Xh5RSj4E0jTTz4oi+W2aWGrBS9DVMt7U6xDdViS3g4?=
 =?us-ascii?Q?dU2C+GH8fhTbFlxj8A4HZF0vF1L48vlafLiUkvSlny7i95xPjtojGbcCw1tL?=
 =?us-ascii?Q?5gJgZ5lcJ3LCP3Kmeia34zPySCVkUKwZt2JK0yFmcjqZxR3fczPipoCBR3XU?=
 =?us-ascii?Q?3tCOC7j6LpJazoSraC5y7POry4nk2EYBul/wlUYfnVdMPP48rcx0An2aSp/J?=
 =?us-ascii?Q?d0ZesdQgy+yqa6pVxGla/RqKRAx0T82KYLqg24iQcGnWk2ee4FakvWeNuTcI?=
 =?us-ascii?Q?O38LlhqcmOcX/4cYuQkTLrUTTpvJYdhQX5TknBpXx8MFMeen5Wub7yHdYX8N?=
 =?us-ascii?Q?7gPw1PYBWelitDXIP6T1Mah3EYU7YuQM0O2Bifws121s/quhFCp976qYJk5G?=
 =?us-ascii?Q?x/hcmqbj33OK4DQc6mz9aLhCCtDSwDC7+ZtSKYLA1Af8LdbnUrKymB4ezV6X?=
 =?us-ascii?Q?sCq8PHZZzpVk528dpNCvGIlYE73K7NJ3lO2hmeMvH2+m08rgNxorc98qlYET?=
 =?us-ascii?Q?njKM5yelR5J0CQ0WxgH0icmMFsJLY0z6o9ZAf3AYKubW650rvc9oCObK/5Lm?=
 =?us-ascii?Q?L1jz63996L5cDVlaBOepNe0feO0yF9atsFAuHftnv4sDRT6nbe1i38MBElVe?=
 =?us-ascii?Q?ewAtfg4nAngFrLSeXOyjZs6VldN0bbT/PYzMKY9igG7rJdLDfLmRJ19uDH5l?=
 =?us-ascii?Q?ro1zIhCETtPk9jIE/L6dWdCx1d8BpkJNbsWG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PYalJ3wOBlbjhoZ5C7GhGkDQgN0p/Qv0tdWzpDPqGtO0jtMRdUwnXbetgE9w?=
 =?us-ascii?Q?zys5QoFU30Qf6hDyqY0tgtzUZsWYNFGmro1vgswmhohbNLxqidPgyMF6d96d?=
 =?us-ascii?Q?DmJmbDM61vxteoqFz6+MynB4aaKlIf4UHCf5dk1nAG4BWWYceFvzvEMTSloj?=
 =?us-ascii?Q?+WvD85TT8luChUjpJcLCJ6hfxODJrKkPft6I8OxztpLa1jt+ITAK+tOXemoC?=
 =?us-ascii?Q?r9/867up0sGF+SCVEPNMxkfIXqSLmKBjpDNta39pcF73LXx/VLOECgGAeNss?=
 =?us-ascii?Q?P5iNEjV0yOsujxggQtxfkO1Fy/rnHI9livgxVF5cldXHH+oTW0J5epF5Fg9X?=
 =?us-ascii?Q?2qM8utOyRjsb3AEqKcCdZil+7g8FFwWbkf+wc2Iy3qpjvlVBAfEf/EMWutAT?=
 =?us-ascii?Q?8D+8LFM9FnO053dXIjF3aHQsEBVoRrNdsYkTxVlHY4IaCk7/Hh6np+9tDV7Z?=
 =?us-ascii?Q?TgWAANOZP4Z6T6yW8XKFh0Pp2rOC3RqZsiblpuwhNrQbKjESDVC9VWyzhyft?=
 =?us-ascii?Q?B/mKCK27bsT/QBAWyOB9tIHGf2RR3JEMzUQ/2Nwe1AA2FeXtO4vcJ52UeKLF?=
 =?us-ascii?Q?OyPdGamwDKWm69/zjvsgFaS8QcqnhRsSOsTgIxSYVbjydvjTc78otX/lq65P?=
 =?us-ascii?Q?ub2Zs6k85rQ4/XZ9RJmgSDo9c5pwxG+e6UYKjs3SMQ0rGa2OJoP0FAIKv7fa?=
 =?us-ascii?Q?yloBo66nG8Qui4oqrNxTDx2q2slN2FirD0jB+SRplb38WP8H3r/YWNp5zzMl?=
 =?us-ascii?Q?3p6QUPspP1e87OCtoQHXqT7a1FP2hGubLaXdMYehJJbIj6uLQ4XjOdzusxQJ?=
 =?us-ascii?Q?Lda8+1p/fGKD+eg7YBAnEo/6vEM9GBZNDrJBDECUtiRl/DmhoWALtd73v7EQ?=
 =?us-ascii?Q?OWX1JUTxEC3u6iX1qbbgTlYmUhLYaTcwygFihBDreOvPC6Wo4bClAypBzd3o?=
 =?us-ascii?Q?glLgFIYouwMtI+pWgaL6dz9j9cR0OhXYOnQAvfWX5gpCpNvA6n3tmT2eBpQF?=
 =?us-ascii?Q?y1ny9PS/+wGF5LbBdVmDDsPAhBRJm9erKSbCX8W8tvwftwomOeL6r8z5SMrK?=
 =?us-ascii?Q?FVyghuj2RsxUy6vLzmjENgfGlqqhAlgti+H7V3IK8/F4HpnTAjvpVRod7E6q?=
 =?us-ascii?Q?0gr7vRkeyIp6ezt1lWK5j3sYovCXUbukRLqjdenaEqFaucHH+zfutPIiXdqo?=
 =?us-ascii?Q?Y+Wg2bWAY8f6mm/2TdFpLtGUJ7u2O9cL1TX1hpcrDcyCSAQSUZBzmjiOE+YL?=
 =?us-ascii?Q?760EvXd+Jcy2d2xpB+TFdctoP6Li5R2xfIKRQ84LOHjS6ZmGRgkZPJKq7f2l?=
 =?us-ascii?Q?EzFjCU1QIALQFw3UWnMK5K9/FHKY/tHxHmdhLKx8XpbTWvIJqfGPRBpTiyt2?=
 =?us-ascii?Q?Zlp2P18xBc4/h+UWp4A5y0AzgCS75Fpfb+bZYO03UIu7mLThQEJ7nlcVupKk?=
 =?us-ascii?Q?CIi4vciDKp5MIKfaJCCCVQdL+pbZcv/+LqmATmic+HH9rF+38gr7N+JfExkF?=
 =?us-ascii?Q?5i86xFaYmTyrkW5xgIFtfrrvRQvpg+YmevOU4hzmAGPHWCdS8php8iibRgWD?=
 =?us-ascii?Q?rywACcanW8SXfUwsx9YEd7/GOW4OhDqcfO+58D9v?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc6597f-4d52-4255-4bfe-08de00bebe62
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 07:47:17.1063 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8WE8raxE7mJ6Jsr2JiS/ASLoi/dk8GGR/tRW70ILLk/UveG6YeAjeUtkCk4HFWNHsTWFgkkInl39+o/xiwXUpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1E89B88DC
X-Proofpoint-GUID: iq8E9ESnpVgBrXnj1O_yG74E9_BGKhmM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDExMyBTYWx0ZWRfXz8GyLNwxwgSU
 0UbHKjAXCA+fRApBF1Jvt6VyngqoPak4wgdwh4vlBWw4H1p8+3k8uLCCRUYAib+TyxXlptXfYaD
 gUZtIE+IVKuM2ZC6LTglz9kn2xeiXqCBKSKcNqBv2L+Nl0me/zOtvIchjqdhVt1V7Ih3+CY1s6z
 s/jbLpEV9PQ0lTvstBoF7UjSp6Qpw77tcqVkIzTrGxFk/wInq4madCi2y/1icilO+p0XwADkp1E
 wrgnsmnBQzyLWLbr94FXyO/gTz5U57I5heZbJ23syk36gMHnCuffY7jAcXbDAlZgNkqVK9sY9t3
 4AOpNDrodOOuYdpe1DBByRQfhuyGd/nk0pcbk60desO3KCKD3PXbT3HR4khLiDNR6/EEeV6DDD6
 kewgxJcUcsUi1H5G4jPjEvV/zk9ZmA==
X-Authority-Analysis: v=2.4 cv=RorI7SmK c=1 sm=1 tr=0 ts=68dcdc87 cx=c_pps
 a=6Bt0GI45FyvFQl6hnU1EVQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10
 a=M5GUcnROAAAA:8 a=kfwlxbfoPToUrfqLCykA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: iq8E9ESnpVgBrXnj1O_yG74E9_BGKhmM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_01,2025-09-29_04,2025-03-28_01
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

> Subject: [PATCH] app/crypto-perf: update result granularity
>=20
> In cases like RSA which has low performance numbers
> compared to AES, the Mops and gbps may not give accurate results.
> Hence updated the number of decimal places to have meaningful
> results.
> The results are not updated to show Kops or mbps as the results
> may be used in CI scripts which considers them as Mops/gbps and
> hence all scripts will need to be updated.
>=20
> Signed-off-by: Akhil Goyal <gakhil@marvell.com>
Applied to dpdk-next-crypto
