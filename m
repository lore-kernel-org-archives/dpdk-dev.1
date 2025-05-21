Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEB7C54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 09:21:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3338041133;
	Wed, 21 May 2025 11:21:17 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id CF81540151
 for <dev@dpdk.org>; Wed, 21 May 2025 11:21:15 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KGeoJY026264;
 Wed, 21 May 2025 02:21:15 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46rwfghm1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 02:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcswSD+jPLL4p5jfMx2e1G14eVIcOaNa6hwWp3K7trm9gSYsj4/GRyicZ9500FiXkJ5mL4Xu8+U5sBc0ZCnOdJk50G0FWUAsbidxSJkf9W6OgNFQDY6fnAdt1I9qhrsLu3AepkL0ZIOGn+HDgMcVLljvbtGfA5a1ZD7abrRMouLsdQGjkLsjcz5CIrgea8yiPUMXnpw7wRk/96J2iPz5KVWgbUbGEibbGwvs/a0mAUYXNfeyXHWKjKP6LZRv7kwh4nx6TOml5FAWVvxhV9caSQMmjuKdOKWxg0FNZlCaVRm0RZPlw2Y6UuU/VLPi/vQ/7KVjH9+4bZPyhuzbaQ4qig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Zv8+1CEPctpdWojPlun3UyLsrEtQNmDiPiYO+BBkr0=;
 b=P8ZdsZ8RUErP4QIBNlmXExsJ3FHJk7F1vnl08JDKo2aqoqLLRet2oBaiYO9tbvT6Oond78GG0bv7TOuGxb0kiAuDS/kzjyqiGGz++80dPnDE+kWZtv1x0pf9vC9f3TFKZbfdIlVBmRfgO3BrtFLP4hZ2TJRdmhzGYVCcIglHlmZU+zSUt9jMN2Q0qKkUXrb0T81TPrxg3+9BfUJfJurfAr/9vIpdE95fu7gCpzYNXOADj5n1fcO1qz6E+V+xtggO4yl5JGxiJiXzVVfOlqV3TCXVakUxka+TQ2C2kyJwJPZL88I41K6wrAkEBUGg3BfpX+iF8jLoQHBNoagRTLw+hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Zv8+1CEPctpdWojPlun3UyLsrEtQNmDiPiYO+BBkr0=;
 b=li80BZ3C7lCZE2pJKPyanOppieeiGG/iqmTAsfw0bFkxhQR/3kVLZYRodwgyxHMzdklNN2kTESJMhcwdluMqSADtGLCi9VO6v6plkeyqajeoWbkzgGa1yGscZ6c3Z2wiwU7E8p2e3za/Rm/fvai/5H4XeCmaEdt0YHuLa2BRetA=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV3PR18MB6260.namprd18.prod.outlook.com (2603:10b6:408:273::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 21 May
 2025 09:21:10 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 09:21:10 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Fan Zhang <fanzhang.oss@gmail.com>, Gowrishankar
 Muthukrishnan <gmuthukrishn@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>
Subject: RE: [PATCH] test/crypto: fix return value in RSA test
Thread-Topic: [PATCH] test/crypto: fix return value in RSA test
Thread-Index: AQHbxXCfgFVntwDdckes1l+KCet0fbPc2HAg
Date: Wed, 21 May 2025 09:21:10 +0000
Message-ID: <CO6PR18MB4484F084F23A09A41878BA15D89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250515080853.1708-1-gmuthukrishn@marvell.com>
In-Reply-To: <20250515080853.1708-1-gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV3PR18MB6260:EE_
x-ms-office365-filtering-correlation-id: 526f535a-865f-4bcb-bf3e-08dd9848d320
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?gwHl5pzl0DxnfWf64wLn/GeUndV624b8idQ+jiTyKU70lf+qSutYeTCzgnsZ?=
 =?us-ascii?Q?cxVDFPo+GN2fiEud+xcdqmYtAoKtSLK7q9WiFh29uHvHCHyOgXr6Di6uH0X9?=
 =?us-ascii?Q?x9THoAJc1AHi5LQQx+Oehq3SunwKKM2D0+79vUbLa0nePgoOkzX3JhCWQ2wy?=
 =?us-ascii?Q?g3AphurCTVHRkcrqrbSskXfrM306V7LTNZFURKx7ekD6oxOmXqRZH0iYyT4F?=
 =?us-ascii?Q?z6m6aRNFhr2IXNVUIIq1XSIS8myL8jn3VwKS/+ygi5mkrS4sSDYeboP3QLZS?=
 =?us-ascii?Q?GT0OSgOkL+HLYDRRCeWpNz0mpSYJI+sXJJQVXuA+gDVTpSOzIZ1was7bZgIs?=
 =?us-ascii?Q?5LfJvdp9nusQG+YTKIQmqr+M+amxfhTLdDfvnSlDrvVehxbg12UfXISuc2F9?=
 =?us-ascii?Q?wVf/t1Wzz8TspJEVxwYLGQvVUEQfSqpEr2qiF4wiovYT2EUMF7iFRMVzBlNE?=
 =?us-ascii?Q?YuILFMgNpqnxOqvoQl1JAgF/9uuTMCpne96vnzE1CYtGB0o84bLAJIXJjgJv?=
 =?us-ascii?Q?Y5sHdLGfcQJsnXjCp9Fx9rdDrLPtoLnlcnfSkdeXp1zKQ56K260fmB1ifnOU?=
 =?us-ascii?Q?aDymTat5a3Djmi8p4zwb2MMX03H/JT4Ku4kT77QYXJ9ikBl/UccSjj8A2oEK?=
 =?us-ascii?Q?RSK/xeNJBDlusgRePxNyPKMnQQugH7MptQI+dxlG1laU/2SvZqDtiOZ2yvdX?=
 =?us-ascii?Q?ued6PjdLBpJAqBzrodY9qvtM/EhM462gF2XvEDSmAhti6NCvO5YDNVO+zYSr?=
 =?us-ascii?Q?kGPAfJrD9tmNU3qqo8iRthJBWubPQ3vmACPQGnHL2lPitVTyBJvGhnzESGtm?=
 =?us-ascii?Q?ELJZYEHUaq2BSVShF3TQN46MyzkXDPgMgdLjHZDO0ogdPjAxJEHyfVVM1dsf?=
 =?us-ascii?Q?dbJ/MrkPRUmzc041djx4V1eHaW0v19ZSh2T/aHLwg+pakE+eoViIL/9bAtiJ?=
 =?us-ascii?Q?1EnOWFsRSwcoA5yo/6SwxzbKxs/8f2UrsaFS/o3GsbYSqMmo1q/29g6YrBz4?=
 =?us-ascii?Q?FMm6hbkZt/hVR3/o7TGOF3AjHjmiDIyWT44dca8z1ise7yHEBNF0Y5FIDz+T?=
 =?us-ascii?Q?jeWaPoVWcPITtDeMEMRDsybQUZxh2Dpl31IwDlOqGWI+6tDwUKkBXpDifAF5?=
 =?us-ascii?Q?3ZtugwKGo+MumVJeweQLQrMPoM4ypA8+MlQjbBmq/TNfSfgrcEKxUshbIdWl?=
 =?us-ascii?Q?G7z7AfrY2CFT6HRl53lroQx4qplbZdciTJjCTYDLCfofuQ5zi/R7qQXkKUgg?=
 =?us-ascii?Q?BCMJRFcPFPYYTmrmIpTzs/EUCeWi0+5EqO6sRiFk74p8Ntqf9Qh5k5JH7HeC?=
 =?us-ascii?Q?ajOO+jjVWh/6cmRWiWLx88t6Q2hu3KBipMlJW4Rkbks72mvh9YlA9oXX7Dbf?=
 =?us-ascii?Q?3L3XrtvX23mSEhnrMNvQ3MVUpy2MiJpmVbzzqLAm+SN0MV7wH25NgbfaWWCy?=
 =?us-ascii?Q?nBViNk646oXIqbOC5aMPMNxiODTAgmUhIGhKI7odaaofQpyzSI69QQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a+4IL9Rz8RdouWlH6TWkCPb9caS3f1l4KIxdUW+77s76mchhx/fxrUsBF+CE?=
 =?us-ascii?Q?kklymRmOANG/AQcSQI37UlUgCDT8TjZSBEgBcIbDBGwP80m0cMFl/tO6K9v3?=
 =?us-ascii?Q?IcDhPSvgAxH1hqy0+ma/jejjrAs23nQR5DKfgHSIAuZD/hrUWu6obVbiTkaa?=
 =?us-ascii?Q?NaPl5zKNGgFcp1RA8IJBSBHq4mVGEgWMYtYKGZ5yqLiLRXmDE5CXpxTY+Hvp?=
 =?us-ascii?Q?BZKbhFDh8AZ8WIBkTkNYa2Juwn4q/IjfAgxpX+4CSfI6DP5/OxhsM/cChoys?=
 =?us-ascii?Q?F9GZBBlCNlmTA0BsNdJMJ6HlqJHpeo7se6LOICq1rvnT7KZfeG872nL8TqEJ?=
 =?us-ascii?Q?pMb4An2en9pnxkW6lPGg+ffQbotddZq3nCVacxNqv+m0/9TRVPCPi+8Z+ms1?=
 =?us-ascii?Q?Pzcs4QyRPBGTYMzZzYOdtPsjKoyVcxkrLwj6qOu7zboNEETguTOQRTMrKWi2?=
 =?us-ascii?Q?4lCFmTsyeX5M7QSGUL1T+0Pp1e/tcs3fj4wjEwZP264PVzmazU3EHYo2Fvlf?=
 =?us-ascii?Q?fRxxVw9LTWMzjpw+05VphVrAeKODveJWda7aNXBUlsvDRryoXT6v6hAhrTrs?=
 =?us-ascii?Q?9seSwuuSCavx22O9J1NEBubTWakikJM2GNA70UN48+aMtuoXn+3KXzm+zGyH?=
 =?us-ascii?Q?FFCfc+cdVTgIcNaL8BOU4Cqu41x7VQeGDtiOxLdOTJssJkmV9Hu1kwCkSefK?=
 =?us-ascii?Q?s+PKm1g8V2s119ivMpqOZK/vHpAfyTkQRy+ODkfiy4obywf5f0KJJLhpz0mA?=
 =?us-ascii?Q?2gw7Nad4FEUYi51eqNj8znKEdgS0kErT/TzZW2ObTLFPo2mO+2E2qvgmv8FD?=
 =?us-ascii?Q?2c9b0WFDL4B9FCYiVMiPwsGw+9bastcGIXvd5mLqToDwEw6+vMtV/3BzrCYN?=
 =?us-ascii?Q?osGYL56+RnjRzWmvSTr3xLHmIGUoPuP2+RKo1e0HE6Yc2AH5mT2emdcz5Eg8?=
 =?us-ascii?Q?mLeUaLhfZI/ofT9s7QWVw/SOYW46MC/mpDZi8sEeBr8GcFjArJI4GyGbjzcq?=
 =?us-ascii?Q?D60h4TSzo1qGMME6/41sR2fX4jhAlpoY2QcFpwZ80vCveP6FylS4if7gac7a?=
 =?us-ascii?Q?0bP9QpDHUqrxaqXnl1Vec15Mf3ogiwf1tI6mWKrPOYixVeeQtGYyeOZwqbcX?=
 =?us-ascii?Q?JHyC4kuL5BWrS2NOieZ26IsO7/XJgKXUidlABjvueU1ujH21Kucx1N6o0Fz4?=
 =?us-ascii?Q?X/gsOJCqLAxSvg9/hR7uFBskt7Un+whW9oKAuHrIGk4obFshhvv9vNZCf3B4?=
 =?us-ascii?Q?t3PEYLKXK0GRnrKqtGkr3hp06nJRn8l1aidBmaSnO753E3VGqfFaQvDVMiri?=
 =?us-ascii?Q?wRSK7F3q1Yc/20mTQGQzEjioieNmUWRR+PM6N7ndzwXMaBlauZu+pvLahJ1B?=
 =?us-ascii?Q?jZnB2dJCe4WD6zALBksCQWoODqAmUleDISCeNALN0F9UAC9N5dWmRpk0PNpf?=
 =?us-ascii?Q?hcVdxq0UdlblyRX9bVm4CiRQvjYaKhPKaXpLmwbO1AUFzHxOxDtI8dqdGUtF?=
 =?us-ascii?Q?sd7ZU2WUAJAhyarvYITSnz2ZpJmuVbAuI8eb2G/AojaI1adJWUAhcDC2sMzf?=
 =?us-ascii?Q?k6Xvq1RnlfB0xws/nj2BDyvjpJRR3MZ1CIFFNTtN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526f535a-865f-4bcb-bf3e-08dd9848d320
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 09:21:10.3099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DAXeoRwNdPn+Gdu7KB2NlRY3rC26NE8IzQ6wjA4lf8qjXPT6qSEY5BNpWR6ffEr5wBHAer1TXv6m8F5R9uqDEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6260
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA5MSBTYWx0ZWRfX9g1tzZhC20aq
 Qztuk64g8jwDzOBAv6AcwZOnD8dtkuSCzfPGUQuh0rury0f0QGxUvfQ7AkUTx9Gyo1tKFbRBa6o
 SNY+30onRJ6g9nTWiq0n8gDE4v7Lrpt9SwV8DHAEULOQztF/oyRCMz38G+RUJI7JcvsPLM26DKL
 sBuljPjJa9YCkqfgIuD8O4mg2Dhw88OnYoFDx6ZdhyUTg+mtmzAyZdLj8Q/Ntb0lkzvMwK1QrF2
 41oQy96ZyHpE4up+O7Pg5xH0D8+BCBsUhOuVoWu6r70TbTgHMMaECTKQBjaLgWke52GaTwY71Dx
 MDAJbqanS1bsPjJ/Onuq0Jz/zbohnyKKt09UZDm9u/ZQWXuD+fU0KcgYXksKXBk0BkiApy27NhV
 Npgm2nLXj3hJoJyqwMVofcVjAxwesulyK7OshAmlYSky8iuOFbWaHUDBaptdWU2G7sx9EMEv
X-Proofpoint-GUID: 7ZgZ2ZlJUUFyKwq8rvn3_PrV2PznOI8J
X-Authority-Analysis: v=2.4 cv=T6OMT+KQ c=1 sm=1 tr=0 ts=682d9b0b cx=c_pps
 a=vIBLTX18KUGM0ea88UIWow==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=gaIhsQxkhxOIL-rsylwA:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 7ZgZ2ZlJUUFyKwq8rvn3_PrV2PznOI8J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
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

> This patch fixes incorrect return value when RSA negative
> test scenario is validated.
>=20
> Coverity-issue: 457463
> Fixes: 9682e8246ae ("test/crypto: add negative case for RSA verification"=
)
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Acked-by: Akhil Goyal <gakhil@marvell.com>

Applied to dpdk-next-crypto
Thanks.
