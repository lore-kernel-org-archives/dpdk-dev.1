Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDDBFD45E4
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 19:30:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF3D64027F;
	Wed, 25 Feb 2026 20:30:51 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 34538400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 20:30:50 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61PGU1T03039456; Wed, 25 Feb 2026 11:30:49 -0800
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022076.outbound.protection.outlook.com
 [40.107.200.76])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4chmmnaq8e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 11:30:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kxl1CVZ2gdYQ2xYjG/UB25N7IpO5KNRPCxXFsYfP8DKrntX9obIgfDOkHP9XWQFPDDemoxKS1N44a6anB5doytMjDXpdiWLl4bpeG9c+k6DP9JOtpjGx2v9XDkAFJycJRC+drlkdcQV1bXPMgMF7rY/ywG5Cbvy+xtWLmYJ6XVoqDfkxrVm6PxSOM4PCsp4jgvoxtK76NxgkvzuCdHpJkTQHUK20hBGq/v2bNsO3Ub3045m3gsjK9n/QkImBNrxjhqo8jUWiwM9+wovJLTRfddtP7swOzN8byfOh//MQWId5XF2Rd8RzBAHjax44bNniExZA5/gjfOYL6EFfWGFbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPTv+ZJk5Mhu/wvzJ6WshVi1rVQaYGvrsV5WbLdc+kQ=;
 b=rMg+8dBeyihYPVL+VhU3p+A5CPcUOSJcRDZp2/djg8KQDlQWTXt3ccgh6kCTpwtpgsFURNgcyuKofWsI/xdsV7rwY/RyrrS4lJTDGOms1iINvc5epZToEItR3oZN1gc+ZPpe+yfUoMAHlILNk5uotm+024c6Bp7ISOjhchn9Z/hyAMivD7uHSxet9Eh6hXY7e7zkdpmFJVtXs2K+Q6HiKyx8EzYg54cDlA5YYuVR34OyX6c6WVw6rxoT9zCovE4TL+VUCyyeGmkeBvlUJ+Wv8SCwcoDMnw+cUbtPigQ3nerQGnSL89TUrhWNm6vuLSw+nTS6fq6BgYVUsQav2ppCXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPTv+ZJk5Mhu/wvzJ6WshVi1rVQaYGvrsV5WbLdc+kQ=;
 b=rkYAgT+mrb6JqNyyelYNTcTA+PpvoEhVpXOaWLZcCoHETxhxmN5asw8lomhKqHy5z6wrRhvVetXTK7DQnVgibjxcAAhp4+G+SI5vTjURKzlUkxuGRoEEcqaW41cYhRJatNURcnArHSSj62Oi0xfm2/DZ544OmkpBxF99Txnf+PQ=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 LV8PR18MB5867.namprd18.prod.outlook.com (2603:10b6:408:22b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.11; Wed, 25 Feb 2026 19:30:46 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::5757:762c:5bd5:938a]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::5757:762c:5bd5:938a%6]) with mapi id 15.20.9632.015; Wed, 25 Feb 2026
 19:30:45 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
Subject: Re: [EXTERNAL] [RFC] net/cnxk: only build if platform is specified
Thread-Topic: [EXTERNAL] [RFC] net/cnxk: only build if platform is specified
Thread-Index: AQHcpc1jpvvtk8CaqEm1+ZmUQ/c2TrWTDb6zgACjMgCAAB042g==
Date: Wed, 25 Feb 2026 19:30:45 +0000
Message-ID: <PH0PR18MB40860D76EA53C8DC495E81CFDE75A@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20260224203709.27696-1-stephen@networkplumber.org>
 <PH0PR18MB4086434B58662DA7BF5F5F00DE75A@PH0PR18MB4086.namprd18.prod.outlook.com>
 <20260225094338.5f0641a5@phoenix.local>
In-Reply-To: <20260225094338.5f0641a5@phoenix.local>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|LV8PR18MB5867:EE_
x-ms-office365-filtering-correlation-id: f7448e6d-19a7-4b4d-eb63-08de74a45f7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: yJRN7DdGWGy33HljyGSyvZRHbjAXQ9tlClwHz44sPJ/WDKt0DQ9J1KVbLkg6RHUuoDCV/lc4V5MtpQh9GS3A/DdV0Ry4L6AWv0KZ4JTuPcXaNrhQhvwGfwdoTsoHJSiVGHqf4/h4sQ8XSEiKBB17d7uE4aVQqh5L8rhU13LaIUx3usykTLZyBfk4azG0omyrWm1szAvi0o1UnPRIT6slmqZhPZmis+qqPAi6Hu9ut/JDpeEBtBt160pa7gsCZXb1Fj7L0jP7MWFeFrkiPd4wiWdIuIWzaJZDewZPI+9MQITaYOL9nEPa75YenyKN5EyNpr+MDzFLN6xUujgwSmfYPcsDZyvrxPn6cfNjRXYPUHzRVb791Q3kj3JjLDET2GQjoCzuJl7zxhHXBJRrVTI5etwbKWN2Bc4stbVNMlLPwXFCDqvOvZQ3rAJLVoLy+oSkoQbI6CPx8H/OcfxxMAMMMVawqYXKfCt55qA6d7tQD6SLcacEvxWcpqBIf6STxzQXSVwJuS/ynEkavWN9aU/4VHbrLuBw/wwsqJpBvwxoBGr5rzvNBaiMd0ah+LG2VWPk3w5bh15oV16UxEWzQ4+3bd83BIbv716/Z2zTVexDpDTFiP6Sl8Xk6ocNiFeQskroN1NPEG3MHHQwgx6IqpWvWxEXWfd+9dbs5fTRGzVa/8eGWvpM6BwnKuNxP4PYXRhiuGSOMhpTKW5OJ0O0/97yQgacv8WhCe685ilT9yYLg9LBlIVFc03wu9VtjYFX/wsJH4LNr5rnMap2H6EQtWRMIsW1zg5Z6WJIUIt7r3dbI2E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2hOLgjh9ShR0sDifTXz8SAWrLvVFI5K9dwt7Z7Nj/lzNtcX+TYO370ajdE?=
 =?iso-8859-1?Q?/zaGpAtuolFKkFsx2mDRFYAs1fMRiJ7LUGnquO170V3F+aa6pcKp/KNiOq?=
 =?iso-8859-1?Q?A2NPXzAIZNeYWKW6OMi8Dz0bYbYRjMNF0lwE4v5rViOvwic3F71CX30WoP?=
 =?iso-8859-1?Q?5cUPKp+61X6AW5dbGmDbFrl7Z8t8dTuq5O/MQ/iXm3Fa+iRanU0nVVE55g?=
 =?iso-8859-1?Q?20UmokqTfc0n9NM2NGgmXXmEJNqkCVVN7TYf1h/EhN4G3QvcQCnlWYiaHU?=
 =?iso-8859-1?Q?uOETAOmKxj7Dd+SyJmg3XgqmiOJ0LQRBeLwPfThwsyyq4ldE/R3/MjTmfr?=
 =?iso-8859-1?Q?RUgcK/AmTvYPSpqHLJ65QodUrasCtJEhthGDvBU+KIdBiGQBy6c/1Z0FX3?=
 =?iso-8859-1?Q?eInbaAN2u+MIVfv0co88ZCLJimfTv15F0iW2lDbLfq8Sm4NJ2uP2teevxu?=
 =?iso-8859-1?Q?1L20/k3+yKtB+exyWGJEmy1KL26AUri3KsBNs4Rmyv/iFBSClsFpg9wZtz?=
 =?iso-8859-1?Q?i/7O+KpIRQgUyTpVCUe8PkkZxrZUCc5J8hQ/nSqHsuqZOf7OZeNZwAc4wU?=
 =?iso-8859-1?Q?miBqwi9yFZSJM2I5Ljkyeun/mhZV7cVUAQ+LiV5D0dGV81A4P1gIPom5vB?=
 =?iso-8859-1?Q?Kb/PaRjxODyLB+QAK83DslMW5s+aYlcJBIXjup6sN4TPkhLrLZy7unKWcM?=
 =?iso-8859-1?Q?cP/nCqcsfLfPizUganxAIKLEmpYfB08PRK0ozRAYlUHJt3m3yDmJ5C+ngp?=
 =?iso-8859-1?Q?mKNR1/DGKhnCi6Ni2xiL3/dnFz6/Vda0LtrbKG2rczb+eEgexzlTjGLs8g?=
 =?iso-8859-1?Q?kYMubKD4xuQ4fO/HcRenpda95oL5gYVSMdARk5KhOqoV+YqpskgaaAlTn/?=
 =?iso-8859-1?Q?Qs6w3Fjk+0l5TlExd2E/UcSDUo8qv6bu/0copwMX9mNJTUywakc6jEKLxH?=
 =?iso-8859-1?Q?tuzWjAwhGOTIFRB29rgItb4FUp2mdSHhnuoH9qI8veF0lIuTavJj3Y0YSJ?=
 =?iso-8859-1?Q?a6wFPlIoUE7iSnbVvqICWTA/1XNQia5g4FfEezhB+fzsw+YzewVMTbC8MS?=
 =?iso-8859-1?Q?KDXZqN1NR1s2TOt1sRXZ82NFJ11ymjiU6Plp9p6H4x4UvMnPvZKgVS3eSj?=
 =?iso-8859-1?Q?owGFrwAvyM4RhzDSpyc+abTrSKMGIfpWhVUQGYw/lnuTOmAa3YXIsBVkeg?=
 =?iso-8859-1?Q?GYYpaadNF8IxG155LnUKWYBCcPfd+pTrH0+wvLPkD4O98t4kwkzJN8xxFe?=
 =?iso-8859-1?Q?ESh/8rhxZCsZU+q7PAezYZjFdryKXYrHbl+F4X/VsqurK2ZapQsGon4Xux?=
 =?iso-8859-1?Q?kvaeVNF2XHFvOvRWRWiHwPggjUGmWr70mE1UV8n4/2UwAEkNhrA6v+bd5D?=
 =?iso-8859-1?Q?ubEgPzv+EpbzFxFS/jpVpsMNPpJo+ShPzzHeKRIHy6fAAxt293aFGUQxXf?=
 =?iso-8859-1?Q?B8ekhFwISYLDj/etZ5urbpdbjjMsBsNADTyRlxAMvBpKhcNWeuq+RgGgjP?=
 =?iso-8859-1?Q?nhoizNZmKzdwbFVsq2U4GFbbpjeYHPDiBYHhJRip5Cg2rX0bRWfu5ZTo97?=
 =?iso-8859-1?Q?DitsiRv171Zhl1FM57oSrHBi7PRO3bFGg3PgiEcLGYECEqWgoSqRZjGZD+?=
 =?iso-8859-1?Q?Sk4mUlQfgpc7uR4GS8qs6pw25M4QVUniC1CBO2L/4r6n9upvy0yYuoNCJ7?=
 =?iso-8859-1?Q?XnAbiNo6psuggCh6tlZy4vWGQmk0hZfU0iKDh19rrJLru+OTauAAZDHlAB?=
 =?iso-8859-1?Q?f5U342a6wLl4GtoD0JrVtUxrtIpXySEF8KVCDsR+bHz9xCRRImQ+NX/rqi?=
 =?iso-8859-1?Q?OLpK97fpRQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7448e6d-19a7-4b4d-eb63-08de74a45f7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 19:30:45.8462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ALB8clTVXC1X3fBUD5nOQ7ADtFiH17rZwatlmQmXV4H6oSrAm9cwW44N/rHojcvkkN7R8rwzNoAezPeKEFtwpBg22Nfhr9aYrSqmFgp+2Gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5867
X-Authority-Analysis: v=2.4 cv=KrJAGGWN c=1 sm=1 tr=0 ts=699f4de9 cx=c_pps
 a=6VYWsXuvEQJVY5rZSrULAg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=jZVsG21pAAAA:8
 a=y3p8l95GgsZ-LgsplXQA:9 a=wPNLvfGTeEIA:10 a=3Sh2lD0sZASs_lUdrUhf:22
X-Proofpoint-GUID: bsIqsbcOB9t60JTuN3-9yCXp7lT5j6KU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE4NyBTYWx0ZWRfX4XIskox+mAjU
 N96p1hdfpgaxNFxFFMjEc036ILWF+blVFcw0YA91sukpV3+q43U3+aVhwibmhAxJaULZZceOhln
 1a9oCVh3CPCyH5KhEVkjERt/tusNDB/32nnwF4MVAxWf2mCTeLQYWdt1tmBD4hywEAKd8WVKMad
 +YdH6ELozMdp+S8MZsOFW1Vf8YxYKFJ3GzvScvOJoGHnmZDjXG/artyogLT2mqzZNl2NuyecDgB
 qZb6Lhsh+P+5ed/Sk/ecV4iNMv4AhVQOUtf3jiFyWfj1LkqFicrCWY/83oCJkQH82dUbz2M8LmV
 OGs5vwNnY4p7bQ62I6Tf/BhGX44BLwHyff8jBaASwBfc4cQCYL9QfpgpG2TYPvPYblGhWGDPO2T
 Uit2KShSP0Nf6oCvII6sSUah9InQmPVyhh/YnbloDb4LyczKmnX9N5fkq4QwKcEiJ82XXgxxtvk
 8IYpj33abn08Ii0eOIg==
X-Proofpoint-ORIG-GUID: bsIqsbcOB9t60JTuN3-9yCXp7lT5j6KU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_03,2026-02-25_01,2025-10-01_01
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

>> >The generic build was building for all SOC types and that=0A=
>> >takes a long time (like 10 minutes). The driver should only be=0A=
>> >built if soc_type is set to one of the know values.=0A=
>> >=0A=
>> >Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>=0A=
>> >---=0A=
>> > drivers/net/cnxk/meson.build | 6 ++++--=0A=
>> > 1 file changed, 4 insertions(+), 2 deletions(-)=0A=
>> >=0A=
>> >diff --git a/drivers/net/cnxk/meson.build b/drivers/net/cnxk/meson.buil=
d=0A=
>> >index 53caa6c171..4a2f4e1a92 100644=0A=
>> >--- a/drivers/net/cnxk/meson.build=0A=
>> >+++ b/drivers/net/cnxk/meson.build=0A=
>> >@@ -14,8 +14,10 @@ else=0A=
>> >         soc_type =3D platform=0A=
>> > endif=0A=
>> >=0A=
>> >-if soc_type !=3D 'cn9k' and soc_type !=3D 'cn10k' and soc_type !=3D 'c=
n20k'=0A=
>> >-        soc_type =3D 'all'=0A=
>> >+if soc_type !=3D 'cn9k' and soc_type !=3D 'cn10k' and soc_type !=3D 'c=
n20k' and soc_type !=3D 'all'=0A=
>> >+        build =3D false=0A=
>> >+        reason =3D 'not supported on soc_type ' + soc_type=0A=
>> >+        subdir_done()=0A=
>> > endif=0A=
>>=0A=
>> Instead of disabling the build, we can just diable template functions wh=
en soc_type is 'all'=0A=
>>=0A=
>> diff --git a/drivers/event/cnxk/meson.build b/drivers/event/cnxk/meson.b=
uild=0A=
>> index 24b48d045f..00295246b6 100644=0A=
>> --- a/drivers/event/cnxk/meson.build=0A=
>> +++ b/drivers/event/cnxk/meson.build=0A=
>> @@ -36,6 +36,10 @@ if meson.version().version_compare('>=3D1.1.0')=0A=
>>          endif=0A=
>>  endif=0A=
>>=0A=
>> +if soc_type =3D=3D 'all'=0A=
>> +    disable_template =3D true=0A=
>> +endif=0A=
>> +=0A=
>>  if soc_type =3D=3D 'cn9k' or soc_type =3D=3D 'all'=0A=
>>  sources +=3D files(=0A=
>>          'cn9k_eventdev.c',=0A=
>> diff --git a/drivers/net/cnxk/meson.build b/drivers/net/cnxk/meson.build=
=0A=
>> index 53caa6c171..9382491ae4 100644=0A=
>> --- a/drivers/net/cnxk/meson.build=0A=
>> +++ b/drivers/net/cnxk/meson.build=0A=
>> @@ -52,6 +52,11 @@ if meson.version().version_compare('>=3D1.1.0')=0A=
>>          endif=0A=
>>  endif=0A=
>>=0A=
>> +if soc_type =3D=3D 'all'=0A=
>> +    disable_template =3D true=0A=
>> +endif=0A=
>> +=0A=
>> +=0A=
>>  if soc_type =3D=3D 'cn9k' or soc_type =3D=3D 'all'=0A=
>>  # CN9K=0A=
>>  sources +=3D files(=0A=
>>=0A=
>>=0A=
>> Thanks,=0A=
>> Pavan.=0A=
>>=0A=
>> >=0A=
>> > sources =3D files(=0A=
>> >--=0A=
>> >2.51.0=0A=
>>=0A=
>>=0A=
>=0A=
>=0A=
>Good idea, but fails miserably.=0A=
=0A=
My bad, here is the full fix, verified on our arm64 machine with =0A=
meson setup build -Dplatform=3Dgeneric=0A=
=0A=
diff --git a/drivers/event/cnxk/meson.build b/drivers/event/cnxk/meson.buil=
d=0A=
index 24b48d045f..c21e01c930 100644=0A=
--- a/drivers/event/cnxk/meson.build=0A=
+++ b/drivers/event/cnxk/meson.build=0A=
@@ -36,6 +36,11 @@ if meson.version().version_compare('>=3D1.1.0')=0A=
         endif=0A=
 endif=0A=
 =0A=
+if soc_type =3D=3D 'all'=0A=
+    disable_template =3D true=0A=
+    cflags +=3D '-DCNXK_DIS_TMPLT_FUNC'=0A=
+endif=0A=
+=0A=
 if soc_type =3D=3D 'cn9k' or soc_type =3D=3D 'all'=0A=
 sources +=3D files(=0A=
         'cn9k_eventdev.c',=0A=
diff --git a/drivers/net/cnxk/cn10k_tx.h b/drivers/net/cnxk/cn10k_tx.h=0A=
index be9e020ac5..0a6abf998a 100644=0A=
--- a/drivers/net/cnxk/cn10k_tx.h=0A=
+++ b/drivers/net/cnxk/cn10k_tx.h=0A=
@@ -1445,7 +1445,7 @@ cn10k_nix_xmit_pkts(void *tx_queue, uint64_t *ws, str=
uct rte_mbuf **tx_pkts,=0A=
 {=0A=
        struct cn10k_eth_txq *txq =3D tx_queue;=0A=
        const rte_iova_t io_addr =3D txq->io_addr;=0A=
-       uint8_t lnum, c_lnum, c_shft, c_loff;=0A=
+       uint8_t lnum, c_lnum =3D 0, c_shft =3D 0, c_loff =3D 0;=0A=
        uintptr_t pa, lbase =3D txq->lmt_base;=0A=
        uint16_t lmt_id, burst, left, i;=0A=
        struct rte_mbuf *extm =3D NULL;=0A=
@@ -1453,9 +1453,9 @@ cn10k_nix_xmit_pkts(void *tx_queue, uint64_t *ws, str=
uct rte_mbuf **tx_pkts,=0A=
        uint64_t lso_tun_fmt =3D 0;=0A=
        uint64_t mark_fmt =3D 0;=0A=
        uint8_t mark_flag =3D 0;=0A=
-       rte_iova_t c_io_addr;=0A=
-       uint16_t c_lmt_id;=0A=
-       uint64_t sa_base;=0A=
+       rte_iova_t c_io_addr =3D 0;=0A=
+       uint16_t c_lmt_id =3D 0;=0A=
+       uint64_t sa_base =3D 0;=0A=
        uintptr_t laddr;=0A=
        uint64_t data;=0A=
        bool sec;=0A=
@@ -1599,17 +1599,17 @@ cn10k_nix_xmit_pkts_mseg(void *tx_queue, uint64_t *=
ws,=0A=
        const rte_iova_t io_addr =3D txq->io_addr;=0A=
        uint16_t segdw, lmt_id, burst, left, i;=0A=
        struct rte_mbuf *extm =3D NULL;=0A=
-       uint8_t lnum, c_lnum, c_loff;=0A=
+       uint8_t lnum, c_lnum =3D 0, c_loff =3D 0;=0A=
        uintptr_t c_lbase =3D lbase;=0A=
        uint64_t lso_tun_fmt =3D 0;=0A=
        uint64_t mark_fmt =3D 0;=0A=
        uint8_t mark_flag =3D 0;=0A=
        uint64_t data0, data1;=0A=
-       rte_iova_t c_io_addr;=0A=
-       uint8_t shft, c_shft;=0A=
+       rte_iova_t c_io_addr =3D 0;=0A=
+       uint8_t shft, c_shft =3D 0;=0A=
        __uint128_t data128;=0A=
-       uint16_t c_lmt_id;=0A=
-       uint64_t sa_base;=0A=
+       uint16_t c_lmt_id =3D 0;=0A=
+       uint64_t sa_base =3D 0;=0A=
        uintptr_t laddr;=0A=
        bool sec;=0A=
 =0A=
@@ -2166,14 +2166,14 @@ cn10k_nix_xmit_pkts_vector(void *tx_queue, uint64_t=
 *ws,=0A=
        uint64x2_t len_olflags0, len_olflags1, len_olflags2, len_olflags3;=
=0A=
        uint64x2_t cmd0[NIX_DESCS_PER_LOOP], cmd1[NIX_DESCS_PER_LOOP],=0A=
                cmd2[NIX_DESCS_PER_LOOP], cmd3[NIX_DESCS_PER_LOOP];=0A=
-       uint16_t left, scalar, burst, i, lmt_id, c_lmt_id;=0A=
+       uint16_t left, scalar, burst, i, lmt_id, c_lmt_id =3D 0;=0A=
        uint64_t *mbuf0, *mbuf1, *mbuf2, *mbuf3, pa;=0A=
        uint64x2_t senddesc01_w0, senddesc23_w0;=0A=
        uint64x2_t senddesc01_w1, senddesc23_w1;=0A=
-       uint64x2_t sendext01_w0, sendext23_w0;=0A=
-       uint64x2_t sendext01_w1, sendext23_w1;=0A=
+       uint64x2_t sendext01_w0 =3D {0}, sendext23_w0 =3D {0};=0A=
+       uint64x2_t sendext01_w1 =3D {0}, sendext23_w1 =3D {0};=0A=
        uint64x2_t sendmem01_w0, sendmem23_w0;=0A=
-       uint64x2_t sendmem01_w1, sendmem23_w1;=0A=
+       uint64x2_t sendmem01_w1 =3D {0}, sendmem23_w1 =3D {0};=0A=
        uint8_t segdw[NIX_DESCS_PER_LOOP + 1];=0A=
        uint64x2_t sgdesc01_w0, sgdesc23_w0;=0A=
        uint64x2_t sgdesc01_w1, sgdesc23_w1;=0A=
@@ -2181,13 +2181,13 @@ cn10k_nix_xmit_pkts_vector(void *tx_queue, uint64_t=
 *ws,=0A=
        rte_iova_t io_addr =3D txq->io_addr;=0A=
        uint8_t lnum, shift =3D 0, loff =3D 0;=0A=
        uintptr_t laddr =3D txq->lmt_base;=0A=
-       uint8_t c_lnum, c_shft, c_loff;=0A=
+       uint8_t c_lnum =3D 0, c_shft =3D 0, c_loff =3D 0;=0A=
        uint64x2_t ltypes01, ltypes23;=0A=
        uint64x2_t xtmp128, ytmp128;=0A=
        uint64x2_t xmask01, xmask23;=0A=
        uintptr_t c_laddr =3D laddr;=0A=
-       rte_iova_t c_io_addr;=0A=
-       uint64_t sa_base;=0A=
+       rte_iova_t c_io_addr =3D 0;=0A=
+       uint64_t sa_base =3D 0;=0A=
        union wdata {=0A=
                __uint128_t data128;=0A=
                uint64_t data[2];=0A=
diff --git a/drivers/net/cnxk/meson.build b/drivers/net/cnxk/meson.build=0A=
index 53caa6c171..a0d9849595 100644=0A=
--- a/drivers/net/cnxk/meson.build=0A=
+++ b/drivers/net/cnxk/meson.build=0A=
@@ -52,6 +52,11 @@ if meson.version().version_compare('>=3D1.1.0')=0A=
         endif=0A=
 endif=0A=
 =0A=
+if soc_type =3D=3D 'all'=0A=
+    disable_template =3D true=0A=
+    cflags +=3D '-DCNXK_DIS_TMPLT_FUNC'=0A=
+endif=0A=
+=0A=
 if soc_type =3D=3D 'cn9k' or soc_type =3D=3D 'all'=0A=
 # CN9K=0A=
 sources +=3D files(=0A=
=0A=
