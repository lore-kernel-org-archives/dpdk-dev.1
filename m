Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3CECCD19A
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 08:58:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6053C427C9;
	Fri, 17 Oct 2025 10:58:33 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 37F5A40269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 10:58:32 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H4cavj014947
 for <dev@dpdk.org>; Fri, 17 Oct 2025 01:58:31 -0700
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022135.outbound.protection.outlook.com [52.101.53.135])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49uadkh5ve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 17 Oct 2025 01:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfMlzOX9C66ufGhB1rNLJdnmPgOG0WOKRyi2mwKyz8GX0BtFB1CAa10/uvSJCuUElz/rCg/qTIBr00ccYDl/5GnJ21WFefUAYPqB/xZkpRyInjRRNJxn28+n0KCL2y5JDLRKyK9uuRDWsLr8atFSFuCrk0E94PEZwZnrF9PG69O7hDb+z092EXAY8odrIeFVt3g0Ne2zpYfUV6DNW7eB4cWIZUgPhC6R9BmnEuwOeZtIdenqOedp14ElImKNzfDrHTCYRU65+VVlGYYC1in6A37SutAWVmiUqcfsGD78RWuMkCWpRRn3chAqiErh0dalOC9jLu6Aws2nfLX8clujzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbV5JwTPGz30XLj0OtBiK0ufN5gpHbUiQsHDg/+0f+I=;
 b=hJq5lPdVVZi7td8P1jaG02gp0cQ5MPHzk+iM+FLisRpddqNtDWEI9RkHLjnnV9TpxaHJEfXLZdNx3JnRYMpVJK+32XcGeLEW7ApuNqpCWcwfCYxiBkSqOer1Vot4zW9oHLPzoOffghd3s28n2DEqdRIPNBta2IpOqpgcT+yKSfeCT0zvLJFxSC1Db2qrZT5Q4lapeVsX4O4MInRGj15WiiVPSH8reiOtBzvrxaDAPrxVi1IUzjTkK0CoBqy5Jq9D/xGpiq0BYVEMiuN8OcSOsNALr+8sCNKmQgYDxPsk4Z2U+M1I+Yfwtm5oytBtV+D5LRolHNyoruRb2698SLYM3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbV5JwTPGz30XLj0OtBiK0ufN5gpHbUiQsHDg/+0f+I=;
 b=RnA8vR9Dgn/J0Lp4sfiVTSHCh92UhMUDotQ7VfPAGY7vgfyEKPZT1axJ1y1fakWxjrbkh2KcKoWHldVOxCjLLVckld/9gHSQSySwX9z3hepVSZEgz2gUKuWGkgehBOmc9lVyauF85CSy9+TIJfo8Xx9pG0tmVOdR1UMGuwRyUn8=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SA0PR18MB3471.namprd18.prod.outlook.com (2603:10b6:806:71::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.13; Fri, 17 Oct 2025 08:58:28 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 08:58:28 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Tejasree Kondoj <ktejasree@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Vidya Sagar Velumuri <vvelumuri@marvell.com>, Pavan
 Nikhilesh Bhagavatula <pbhagavatula@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] crypto/cnxk: add packet vector support
Thread-Topic: [PATCH] crypto/cnxk: add packet vector support
Thread-Index: AQHcMr+VMnEpxPPEVkGAsb31UI6zXrTGItCg
Date: Fri, 17 Oct 2025 08:58:28 +0000
Message-ID: <CO6PR18MB4484DE95A177F6A7A5D9A3B9D8F6A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251001103846.1130824-1-ktejasree@marvell.com>
In-Reply-To: <20251001103846.1130824-1-ktejasree@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SA0PR18MB3471:EE_
x-ms-office365-filtering-correlation-id: 030fdb20-56ab-4514-a127-08de0d5b56e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?aBmOML2crM752V195jzfMtzsXOF8CJIH73GXm51oOJeCYRgZcHuW0ZRwl8yw?=
 =?us-ascii?Q?OEEfTNtZE+Us4wwRpI7RI14X0GG1kDomNKWrtJ3QsT82WdKR6qNXZS42JATC?=
 =?us-ascii?Q?s9GDXXq0fS75/0AqEPVwNHjSUHgTqWw1iCKlG/1KI+aNCWddecXHsIX6yKu4?=
 =?us-ascii?Q?4nB2b21ZmoQoUpPzWALm4rz5W/ToWDSufnlW+lWFcgRWL61Z0A2KBqZJ4IMf?=
 =?us-ascii?Q?JZ+cNYVOOQCx3kw7LwTyV2KULEIW6H/XaAN8LbwLv2bzZAjM4WeCJAvJUexk?=
 =?us-ascii?Q?ZI4a71JLAKm/QsSE9RlAErGUPmUGk4UvxzwHPq1vkd20bXkevsN6Zi4Ppq22?=
 =?us-ascii?Q?MMKl1VBxuWRwTcEabIPyZS9ZJtvIwaJ4n8jf2s0hVtT8AtA3kIEwih7A4m/o?=
 =?us-ascii?Q?45I3Oq6kqDx7baqovrzaRqVhQiGsBJI6KuXoKAppTahVesiI4k+ERag6v/NZ?=
 =?us-ascii?Q?yvXJyFp6kVL+o1O8z8b7iMrn3qEzvIOwTrybcu8vfKju9qROBPkhQEBD9RjJ?=
 =?us-ascii?Q?zy+GwxCjIJhkHF4ii4FmEkteF/vepR06o0o01i7B0kqWZut7m8rfP9hBMHb6?=
 =?us-ascii?Q?+AmHROko2QSPWYlC0Mey+2dTbiwU4yXAyQI5yAWmjYElucLTV1gH6me8iAxh?=
 =?us-ascii?Q?pzyAOzj6PXUdSpUStnD1vu8fGlgQ1wOMfHCUMCutW8K+7VARUvPH0+y96bt2?=
 =?us-ascii?Q?ygNMDseRlxC5/tw33JQj7uJ5XhYLA0sFhDhs5tzV+8B2Bf3a8a+N+8cm9vtb?=
 =?us-ascii?Q?tNoJW1Owu3+ARRyna4uT44vrhTBNyra1AgGloz5AeNgwk7Co/vIUTOmOhNoR?=
 =?us-ascii?Q?DQ0TSCLxIa7FjFw/d9lbNpQxihlBAjeHdtD7Jmsg6xWkDmiXyfHlZhJ5Tc0g?=
 =?us-ascii?Q?VL+h+tVI93am03ClO0F+ucoWD2YrQlUsqTfoLA57NQfu5B9o3yyTiBJ+qAf8?=
 =?us-ascii?Q?ophh2NvMMc0k7OoTADWEQbNgFT7koya88N4Q2JsAB0W+IgmdFqSz6uZpPOSW?=
 =?us-ascii?Q?wpX48tvuk1i4h9C+z9iLvjiA5cTMopaA9U1EQEnrzY2Jyk/jZhme4Owm4BWb?=
 =?us-ascii?Q?37hm6tzTtJ7U6Ym5NIReTfgrETqjXwL6TeqjnKEhyVNWjntQNnpTObM3GooU?=
 =?us-ascii?Q?WvrFlauPvVPhrFCuLtc7/s0gpZ3AkEXNDWnlDyFxcOHBVFZ9PDI4mxnG2thC?=
 =?us-ascii?Q?vIVoX1/S+ZC+3tqaE0q+sCSj0xB8rQPZlZ4+8PzBNI3Y+K0uqYzsZ/Rjz+Iu?=
 =?us-ascii?Q?F9vIFdNotFQG3hqyFVxgt0U7Z8dOaKxIJX9CWO8iFfbJn+x/wQ9m9dF0Y+YT?=
 =?us-ascii?Q?PglNjWs+f4HYYF7dk5uvBDjkJZSpYPs/OIrKmItiDO2fAm9NHsP2GWDR2XNE?=
 =?us-ascii?Q?bh1T0gLLFvTvHumDJeljMek3K3jj1IbwCxMSfgjcQKo2u0E1NtC8fo/MqzzQ?=
 =?us-ascii?Q?3JcHVTTrdSUGzFw/J1+ymjFQy9F3DBHZNHgsM2mK6i3loFhrVMu2a0X4lJBE?=
 =?us-ascii?Q?vtExbq8pds9zkZf716SEWRO5CE0sKHc3rx27?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ljJPVO2ikZ8XdwcFysJFFTwa5TBMBxMlr6dKkV1pqlYG+0avr6aOV35EZbD6?=
 =?us-ascii?Q?k4oB9WRojsAOqlP/Y6kAWfOp1XV0RsxewEZfKbCrj2Q2mUoNgzUKj1bYGp65?=
 =?us-ascii?Q?OArTmwaEbOPc6UcWJvT3ctROrpBW3DIfwBDq0Eyms87iIfDUD+Xdk/lL4XKO?=
 =?us-ascii?Q?1+MmzSYwYzvOTdluC+NpcmJdFaChXZpe1qQDu3VcNi4KB+f0IbHBljABKIII?=
 =?us-ascii?Q?a7XqGuJe99HVtgpZymo8N2tRSMPjNIJf1g3SX8tpKPbfdYQ7BxODfdgH5ylq?=
 =?us-ascii?Q?3ctUq+R+Ln6wmarVAiym3V0lNHgpMlim5ltGufiKfLtrGkqzWuP+Imxo2RlG?=
 =?us-ascii?Q?A8hR19PZrutrXoa6ZUkicsdZM4NAmjW5TVr4+0vUKZud2DmMHPkgLhGJpIXs?=
 =?us-ascii?Q?Du/V+H8ofFEhNTT1U1qP9tpsyyItE6cCLMWu61VG13ixkb/ucDQCwdjaAZel?=
 =?us-ascii?Q?KYsWt1cd/3VaNTncqWoet350okZVH57CLkwCBZ5d+3mwypQEn+c9b7a084VQ?=
 =?us-ascii?Q?rlhyk1MmG1O8kZwEp0YkLwYNyDJ+R4DwAEWQs6Xsko209+c8C5WBHdW1jiLj?=
 =?us-ascii?Q?WZzncx3JHOfnF3KKbGWWNuWUg+ix4S+h5aDiRCxDe3fErP2jghpD8NFz0QqU?=
 =?us-ascii?Q?Y3asMFcxYXcSZ/H+CV71PhYY1NdFAeYdpx7rUVntW1KJGL+4AHn6GYunnhbA?=
 =?us-ascii?Q?+LSkbg1K6B/i9pkSFinPpV47N4Ju5RbZ/YRFiaa5fz/MdWsdO5K/TT8otGyb?=
 =?us-ascii?Q?XhiRzlwwMLxCXwkfkaqjPdIU137hf5l8SoDkWj6cbU2T375MQ7nLiWO8r2hZ?=
 =?us-ascii?Q?pHMiAFw9/IwaMa2k2E8QuQTTLWAAODPh2Dbi8pT4Q2wlkW4a4eENCv0d9DR7?=
 =?us-ascii?Q?rb3CDhxGn5B2l4OPW0KWknns2GNLceEIxEfmR/OuCM7Ssna0Xsc4SWBWZRWa?=
 =?us-ascii?Q?pErkEfvoo+QG1NQTXdog9y6OfKlaXxLS4CgYCWtErHjtiXIJiAQTczZSb+4r?=
 =?us-ascii?Q?q1afVUGY211d/zPi4NDgGxsEU6B8zzCRt7s4dBtK/aOF1kViJz9i1zfTFDdG?=
 =?us-ascii?Q?OYg5s//DrDjQI30dapB6xTq/NYj7O9hEJKocpjrJtZAGzIJgTtOqw5Mnkepc?=
 =?us-ascii?Q?w3RNW5EcCTCKMydryFAYkn/iEXmHrL++6ira5BPCiyrFjz5kqdMC1SXPUYfF?=
 =?us-ascii?Q?oczuObZEHy26UTf+WZKcmz/ZnsbwWNSN4teogO8IGxaSkIVUE2XKeWUt1EkW?=
 =?us-ascii?Q?QAltLhlwMGjuhdVPuJq6AGX0Q7zMtiFCp3DtPBct6WJwLkjIVYvUGiJtOG1/?=
 =?us-ascii?Q?o0INeASP6VD+/sMTgSA665+dbMj2eSTJflkBH83F5E5Y6O9/oBZUagBt8Qv2?=
 =?us-ascii?Q?sbjvkKoinJjInt9Mg/I9O12C805o2mxZ/fRaXNGvQGg+DC8RFlvqzcY2+ieg?=
 =?us-ascii?Q?wwx1V/Qy3o6/wH+7iG/F0iTA+2nSdZY+UXbS8LeUDbqi5vB6mMcGlts1LB+R?=
 =?us-ascii?Q?J5lT+pMHsqwFKygJgNYh0Jq2klv2NPNBXbbu+jh9QM8wOFC34IMJPdPwKT10?=
 =?us-ascii?Q?730111KY0SnW6lBM8lY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030fdb20-56ab-4514-a127-08de0d5b56e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 08:58:28.4165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dYtWLd3lgeIYFjuJlZK4VkatUa0U/2aG8Kk/tbPRB3XqkpVVizD+U1U9plj3hYWyNmzdBnVuuHr6qVsv+Y0C6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3471
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDE3NyBTYWx0ZWRfX9dnBxMkZAiMc
 VgYGrkwPJFUheF4DB1q48HfYQToomR3tXv6H8m74E22ODHnAyYFFx3kyGqPGJT+0/Vjp8ZJWU7u
 g59hHuzk4NXRMdBu38JqAUArb5uXpZ+LlP8Q+Lj3Q8Wtbz9xPm3BM+GoZcYs6qrShtjqUB5PvmF
 s1TboWnXZnXsMs18Id1rVf6+dnGtcUtUIRs1b64NrGhX3VGc4oAZ+x3XwIYa/kIaEsxjcVbFXz6
 HFr0VFXyM7iRVKEbTXPMxJI5AGhuaq7aMjWQ34qaomZwhgi20UK6sS5Rvs7PjcBeRmsXlwD1bGO
 XHU+JiHINwy+wzzUEB+CW0vg49Hu0mJ3RkLF8wK6w4Re5ODfjLrovl+zxzqjMjPzLSLpH2TXp9+
 EQhuXCv2LPltUJTamUvlquRfCozivw==
X-Proofpoint-ORIG-GUID: ai1N19JNLLlHwQ-OFCojLrqLoKb2RuZm
X-Proofpoint-GUID: ai1N19JNLLlHwQ-OFCojLrqLoKb2RuZm
X-Authority-Analysis: v=2.4 cv=YOKSCBGx c=1 sm=1 tr=0 ts=68f20536 cx=c_pps
 a=Ti5/GRJ+HbT0op5tcGUr/A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=T5PzmWcsDfvLamThPpQA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
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
> Sent: Wednesday, October 1, 2025 4:09 PM
> To: Akhil Goyal <gakhil@marvell.com>
> Cc: Nithinsen Kaithakadan <nkaithakadan@marvell.com>; Anoob Joseph
> <anoobj@marvell.com>; Vidya Sagar Velumuri <vvelumuri@marvell.com>; Pavan
> Nikhilesh Bhagavatula <pbhagavatula@marvell.com>; Jerin Jacob
> <jerinj@marvell.com>; dev@dpdk.org
> Subject: [PATCH] crypto/cnxk: add packet vector support
>=20
> From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
>=20
> Add packet vector support in cn20k crypto adapter.
>=20
> Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
Applied to dpdk-next-crypto

