Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216C9C282CD
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Mar 2025 20:30:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6839D40041;
	Sun,  2 Mar 2025 21:30:52 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0F3A14003C
 for <dev@dpdk.org>; Sun,  2 Mar 2025 21:30:50 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522KKf3Z031439;
 Sun, 2 Mar 2025 12:30:50 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 454kvegsbg-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 02 Mar 2025 12:30:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naedUTymwUqjnxKYacIstB8XylXuKe2SfY3gDUboIgv8Qwo81f6dMl2TcfU+NI5yYVjCSV1dGP2PP9UdnehfbP1GGQhtnWxpC5cScP4djikZxsITaBEVSwZuieWRGDu+Pa0fB2g4GXQPpVU8p9QYVBYeefFHRvDndRTFmOe3BlODAGzWWjAQxhSn5/iCZX984bjr8cKtDBMuny/tBsPR6hD8qBWkZx0hiqE5qMbG+546DinrHmWGpyLVYMTzEFIf7Pi2TxuJUzWng0GuAkjesFXGpqH25aETdPIOAyf0YCY3ZM1sEHBo9B9BJyJW0tZlsvKcco2ytGGWUNJrs0J/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyaRc/gIJgXIrZfDO7GwYrw6BaTYxX7/OSaSzPFQTGg=;
 b=HZPppe7CAsEWOcEIygLvbhEAmX35diywlm2W6QWmP4dmtACCx3lgvzQ7H3MD6wSuh2YjTXpiOE07J8rZrY1pSMdr0RHv/QTHJeXSyvOtC0C1zIGQq0+GMf89Zzk+JzsYy0I7agyMKNoGexulwQQKkfwbtU5W3GM0H8DsBDakpqoTYf0qu+8fOKfy5bw0XiVArFOr/oNI4yw/2WGKSp/j0qalCDHOpfDqh23ksc3DtZTZ32QRJsla5STfVPMHxHl7umRRmAUEUuQLMab+9092JfcFvEvYY0xuGC6Owsi0xzJp/C3PgRAZK1CWs2LukRTFKRHfq1Ze0rFm9MeOyfE6sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyaRc/gIJgXIrZfDO7GwYrw6BaTYxX7/OSaSzPFQTGg=;
 b=qjk5QQDtNdzj5LBtYuGs291bNpOHNIXHh5uWzT2mYhQAsXWWD4XiDfHjiorLy5h14bl6CXgvskOxu39mmbU1Y6xgyTXYc/Nvz3wSPsdzjbwk2ozqlQEutp6m6x+o7be/l8RtHzgCnOYH9DwuHhXOep5ehSXNVvMKuUXdMN0L0JU=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB5525.namprd18.prod.outlook.com (2603:10b6:8:17d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.25; Sun, 2 Mar 2025 20:30:45 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 20:30:45 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Kai Ji <kai.ji@intel.com>,
 Fan Zhang <fanzhang.oss@gmail.com>
CC: Anoob Joseph <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [v2 1/2] crypto/openssl: validate incorrect signature in verify op
Thread-Topic: [v2 1/2] crypto/openssl: validate incorrect signature in verify
 op
Thread-Index: AQHbhbjJo5/zyTBxRkKjpRxtRxKt5rNgWE/Q
Date: Sun, 2 Mar 2025 20:30:45 +0000
Message-ID: <CO6PR18MB448415225296D5D2D48574C6D8CE2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250221170908.1613-1-gmuthukrishn@marvell.com>
 <1c35f6536b049d2dde122f29e444d462b3d3f948.1740290302.git.gmuthukrishn@marvell.com>
In-Reply-To: <1c35f6536b049d2dde122f29e444d462b3d3f948.1740290302.git.gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB5525:EE_
x-ms-office365-filtering-correlation-id: c73e866e-a963-4b0f-78fb-08dd59c91c6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?tgzQiqqVOmhmjwelXkBV3wUy45IsJGuJUJG5usXVnZ86i0b8ThjlloW9gOhx?=
 =?us-ascii?Q?cLYdavMvDb+j9gEuVLwl+QuNCOORbmup8SS/BFo/bpWTVv+YxqvSSe87gT0W?=
 =?us-ascii?Q?OtU7WAsCPV4YcVk1WvO3h7q2aCpdU+S0aRDBofJu3i7lO5wg1X91abg7/Z8O?=
 =?us-ascii?Q?AEkkek8PdLA1X+659J/+u3Rp5CRQMV+i19HbWFc3KuTa57DprZpFJhBsB6hb?=
 =?us-ascii?Q?+1+1qmZAvcIv4AMjis4ZbV/N7+dQotmwvUl8OPWIycfaeU5VJRB+KynZWX+t?=
 =?us-ascii?Q?WX82hWjjBRdKmqZHC8nAp7B173MmA3crJcZZRQ+ntRn7FL9kLqwpNbXlzr9W?=
 =?us-ascii?Q?Z7dRZ1w/TZr3o1VwQ1nRujA+uM3mOKI1uMHf5XK11NYZPdYhW3SqbT7STrgH?=
 =?us-ascii?Q?jOpPTXA/1p2B5MPfMhlV6Tmne1h+waIYjFQsFtULOVwF3OE+c+3pgfMhXJsM?=
 =?us-ascii?Q?Fqs+bu+/zDRS6BC6X10Rhl3lklXG6KBp4K4kRPcXtFLkz6ee6+DfprkKQcbq?=
 =?us-ascii?Q?ass4wmBwf+zmRXMpkVhOkpwLB5stKNU7msZULyxfbpq6O6nXvZG2P3xxqrzZ?=
 =?us-ascii?Q?vBtURsXoLH7/AmRGoCdSpuqSoEDm35wyFTCYPl+/AEyekYNfwlTAmBPMhZr3?=
 =?us-ascii?Q?ND1wASd2YpHtPsSjXI1w5F5Ln3OVlC6dzcRqp6V8ZC+wZ++wCECIktdB9OkQ?=
 =?us-ascii?Q?50vrLIpuYM98AVOMVLqS4z3aGz/u+FbLtMmg2+mj+T4hrcoSesjP6gS5uiYp?=
 =?us-ascii?Q?/yJ1xCK3BxYKpeHmcCPbtxu2c5OUNHeVrPOE0EsTBens+7CU/AwEsAm+N49Q?=
 =?us-ascii?Q?orIzHxdtfBV2W5QSOa5ang8jw6ttKclm4n1z4TiNa2v+YuRHfV87GwDyjoPG?=
 =?us-ascii?Q?AnTVZP0n/FR/3YOsJUSNTj1lckiByjo4ej9vic/yv/DcC/w1K1Du531ze37L?=
 =?us-ascii?Q?qUSI1m131rsh8SqrC01O1BGv0Fv0rWMXcelVvwBfft8uvCHI50rXvUiugme0?=
 =?us-ascii?Q?J8U3xNCFOowRlXER7a4f9x/3loRgxS+BbA00OWzpWP69dj+sQeYYG8W1JSV4?=
 =?us-ascii?Q?I+4k/0pQXuV3fe+Cflf4v8djpbkKZ3trpW1iSGHsAcvUfpT/vF1K/mNtdo6m?=
 =?us-ascii?Q?k6UvwnfDZI3Q2g8rW0C/K6IyMBaqLiJ1AcmU0Gfndm9JCwKeqlm5vR9wFtTF?=
 =?us-ascii?Q?l9TyJhx5WSLHMvcOYcS6WcxPrqNO7OLWlf2AbUt97OgM6MxlbsCnq2ZpXl2n?=
 =?us-ascii?Q?yY5oCTBwm74GxsTxr4cnFeAJH5NuSpEBPzQuv8TLPA2JUtqwb6rFYSNeIMsd?=
 =?us-ascii?Q?vEx9uw3VoqG6ySUf89gRkZVLNXQaLelXHC83L3RFd52YCaiSZ754udH1QqbC?=
 =?us-ascii?Q?++uIh3W8Co7eG8IqGCz9liQCnNR4RS6FmqcTGrPjW7PHfCIZVTXxWwW0NY9j?=
 =?us-ascii?Q?vHbREn5AI0cll/GJtyliuAmiKC2fvLzo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zhs41R4pSfjwzQLlX5AZEjfo86Lir98kJzrI47vp+1IGaKXUkaSBANiVQ/zf?=
 =?us-ascii?Q?2o2r8OaTNJkUNPcxjCStKa+CIgHHwXRzAN9fHV1t+lyN3TKy9cvZAyA8CWOM?=
 =?us-ascii?Q?8mUAjYCEdRXbHoujHA8+r5dIzWgpcTf7mV6B34Nluawza4LMNxzlEX2zk8Fh?=
 =?us-ascii?Q?25M+aS8ufS7Qk8sJsxHgGPgyPaMgON2f/01JYV3aPzsPBxceKi69divMIvD/?=
 =?us-ascii?Q?IpMpIclZB3oVMyzuzIZN/XIITZ3fxcccM5Laf2LRQZvKIo7LMbpt+JIM5YpM?=
 =?us-ascii?Q?3+7xtBlXgHxNK6Wpk/zUlpcO1pXmS53vFhrSanXXOknU4qvOAazL6xAe2XLy?=
 =?us-ascii?Q?e0ao0y1MlpF58JEY+sojhXComvdoZ36tq4dSBz59EU0cKIPcYv9G+9ay+hXz?=
 =?us-ascii?Q?Y6nkSbvB/UpjMY5JPBznmNjq10OcK6Ic4oeW3ov+jGrkflVM6vURQ5NSPoSY?=
 =?us-ascii?Q?h/OtEXsjVYPFijgCl4Zej9XbK+ZOsfrNPlHKKFHN2eNwJOSHQEI4jfKEwFPS?=
 =?us-ascii?Q?8PDya0o5fLOdz9r2UjqFRT7StF1wF3qtl47GCTOcxj1t1nP6Ep8DxEiPhuO/?=
 =?us-ascii?Q?CCnKE8VoPiwXt8TAFZcSU0CTHeJ+HxWhgew9Ht4rLW/N6nAUCSsd/YyXmmD9?=
 =?us-ascii?Q?ftQU3AcX1KNmVwY45upHfSGhhsXFQWoAJD/4L0S6UzcErnH6wg18lvFjc72f?=
 =?us-ascii?Q?DrbQ6nDqIteXfQ7pjhHbwIvKdR5UfXmtBJNpKHbCNlaqHPlJ/AbUdNckw5Bc?=
 =?us-ascii?Q?sHP7PrLIYFXVVr7oQ4YW3dTTDZ+4YBHuxBNdqTXx5uiM88C5efpji2n5VZrQ?=
 =?us-ascii?Q?ZA2WWr+1nxWUzBsTlBgiCnDoE0nmMjBrbmHCdZL2LeBKbCgciOib3do8apFy?=
 =?us-ascii?Q?irRaVddyDuno9XyQwlLwGcdcuxAyX/9IZUTqfrMGLzrL1huWYNheHkFp2RTE?=
 =?us-ascii?Q?Co/X461GCM2YOVpUhj4Et//QjpSRw7/PQKfqzbZI9fI10NJQ/caubD1MrhO2?=
 =?us-ascii?Q?s7NhI3hIQwVI5mkpDxLJ6WJRltHigiXZ0IaCleqR9jJs4e99wNVvpJLSd1F5?=
 =?us-ascii?Q?vheB1Z1rFD/T8NtDu4+ZOBDvwJYjn1Vu7zp4WXCnsXv+zulSdFVSoTnz3bT/?=
 =?us-ascii?Q?otlr5ai1Yg7qYDLCwufeDy5cSSLVjsJI44+GR9FHx3RbUAzFj7HVuGTvoN9Q?=
 =?us-ascii?Q?jemwYyTvUP+pYtlUe7+XBt/zvFB0eqeqF7irsVHB/1TqfGCa6HzSapVzka3P?=
 =?us-ascii?Q?zgG495Bo5F9Uj1vanQd1YcSp7E3FJHEe1TZNDBzhv+BNtyfTgI8eh4QSmTGa?=
 =?us-ascii?Q?hyyHe+cuIqSluiPzaF5KDcJcXME2dIRI8fBtJ6rtSdbwMrCJJ/5BLMalsI4i?=
 =?us-ascii?Q?7ohAPAepqBg4ORYEZrH8BvHb5WlE0g8wrquAEa8ZSIAHpWhJDDTg1bSr+L+j?=
 =?us-ascii?Q?X76F+55kxPktjoJ3lEn0ptblKI3LEFnvijhyZdxqn9jwLgAXL4gO9vSda9IY?=
 =?us-ascii?Q?hmgXw/uUzglgFDWmwX5AakcPyVlBT52TQH0LBO6fQKTvTaDIkTmhMjcZVf3k?=
 =?us-ascii?Q?yWyysQ5Z8yHsNC0kHQ4RJgFeamZ0MU0MDdh2aY7Z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73e866e-a963-4b0f-78fb-08dd59c91c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2025 20:30:45.6493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nqHCTvWZCwVhboQQYC0L5BYK4gE8iXkC295oxuHbbH9mLsApser1e5rgtgZDCrjlPw4I+TRwe0EgillxoyhlGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5525
X-Proofpoint-GUID: 6mOoqWiL5qumWYb7kIuiZCBzGNM3dIlz
X-Authority-Analysis: v=2.4 cv=O73DvA9W c=1 sm=1 tr=0 ts=67c4bffa cx=c_pps
 a=kqCqMoaEgQjRYYKBKtAp1Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=B0Bu9vcteVzgPnJYiykA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 6mOoqWiL5qumWYb7kIuiZCBzGNM3dIlz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-02_06,2025-02-28_01,2024-11-22_01
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

> Subject: [v2 1/2] crypto/openssl: validate incorrect signature in verify =
op
>=20
> Return correct error status when incorrect signature is
> used in RSA verify op.
>=20
> Fixes: d7bd42f6db19 ("crypto/openssl: update RSA routine with 3.0 EVP API=
")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Acked-by: Akhil Goyal <gakhil@marvell.com>
Series applied to dpdk-next-crypto
