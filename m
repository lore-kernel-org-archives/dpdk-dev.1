Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17093606A321
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=BkTwLDDZ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6F4540656;
	Thu, 26 Nov 2026 16:40:18 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 1FFF6402BD
 for <dev@dpdk.org>; Thu, 26 Nov 2026 12:00:29 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQAZ1ZS1060950; Thu, 26 Nov 2026 03:00:29 -0800
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021125.outbound.protection.outlook.com [40.107.208.125])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4j5nhg764f-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2026 03:00:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PC+YSV8CDVtsn36HHegQSSnB7JQkcj/r67gCvHL+C0Wm1yjaf+ohk2saiBxQnF8pGbo8l8GkZgdaVRdK8c7fG7VvaJ4WRM8Do+NaOiHdzDX3+0xRj2ONzcNcIOxIDawThSwkQ9LAbCNArMn2qsEMyDs798OfkYg+aKXxF02EP9CorOWnSU5qxN8Na4fyfDH6cZD/6f8jZ4kBpemmboUtVYrWZIfawU3lpEiYUoSzbMgzTwEK/zNjVrPaTX4Ojk7iOLg4eWMZHEjZYwXDPuXDJiuOi4EdMowveqQHuQRL1kfJxQ0O9m5qOLpkREm0wqvh96q24wL1AYtugJ0BkkisPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhcTfY5Rz+4kdu1EKOrtz1lrwgoU4LchBtAqrwa+RL8=;
 b=vMzkS9I3+CYSH5ztE6WBaVtzpVxOU5Dd0sQC0sDScF4vupsrXkYPI0ZPhKIOd/COvMRwUT5z3CkEzSRQHVA4CzOXScjWZql8QfceYThfA3bd1K122j8h5xFm10GPIaXqYnxA9OB1J931d+UFxtn+VcNkQwahgzG2zZb3ClnNGsfl4XbJcEHr7MhcDRX2Zt2s5bjgIyG28UuQBFr6+HBwbNj8hK+Zg6btSQWNjLhE/BGtkax+Buo9LSYiQJq7mu0EZOBGI91LqY4xx9EffHERp1YVsTjfsUAt4U0/6m2OW8JJw9ygce+/Zt2O7hyApp831wpi7JAuv/K9VihWpLn4LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhcTfY5Rz+4kdu1EKOrtz1lrwgoU4LchBtAqrwa+RL8=;
 b=BkTwLDDZqWXiKCpmUT1sUKlhb8/FCROa3bbifnhLwIcPzurBsm4YpJJ2aZ3Q0qId1U6dcY3TwRzYQcUpsAEj/aaDgTaDjfJUMmMf4CXWG640gUfDdKVxi8JqXD+QZrVqmewVfxUFRHt1EAKG7I6SE5bdkzaezS1PWsfIYL3l2J4=
Received: from MN0PR18MB6095.namprd18.prod.outlook.com (2603:10b6:208:4a4::6)
 by DS4PPF76053B204.namprd18.prod.outlook.com (2603:10b6:f:fc00::aa5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 11:00:24 +0000
Received: from MN0PR18MB6095.namprd18.prod.outlook.com
 ([fe80::849c:e224:2a0d:2cfa]) by MN0PR18MB6095.namprd18.prod.outlook.com
 ([fe80::849c:e224:2a0d:2cfa%4]) with mapi id 15.21.0662.001; Thu, 26 Nov 2026
 11:00:24 +0000
From: Pratik Senapati <psenapati@marvell.com>
To: "Ji, Kai" <kai.ji@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, Akhil Goyal
 <gakhil@marvell.com>, Anoob Joseph <anoobj@marvell.com>
Subject: Re: [PATCH v1 1/1] crypto/openssl: filter legacy ciphers from
 capability list
Thread-Topic: [PATCH v1 1/1] crypto/openssl: filter legacy ciphers from
 capability list
Thread-Index: AQHdV+D33rDuqD9F1kOHV+JXOBdZjLb1WK8LgAdPF+WAQ61sqQ==
Date: Thu, 26 Nov 2026 11:00:00 +0000
Message-ID: <LV8PR18MB6078877E2467BC0C26957E8CBD422@LV8PR18MB6078.namprd18.prod.outlook.com>
References: <20261009112543.1766727-1-psenapati@marvell.com>
 <20261009112543.1766727-2-psenapati@marvell.com>
 <LV2PR11MB604545E17B9928A3A4758C2A81922@LV2PR11MB6045.namprd11.prod.outlook.com>
 <LV8PR18MB60785664769C41BA6F7080BDBD9D2@LV8PR18MB6078.namprd18.prod.outlook.com>
In-Reply-To: <LV8PR18MB60785664769C41BA6F7080BDBD9D2@LV8PR18MB6078.namprd18.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR18MB6095:EE_|DS4PPF76053B204:EE_
x-ms-office365-filtering-correlation-id: 923bba6a-fd1b-4d85-a156-08df4bac7897
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|56012099006|11063799006|4143699003|261028144727099003|261022105027099003|261022075727099003|261026140227099003|38070700021|10067099003;
x-microsoft-antispam-message-info: Grd2t0UsefFLrilmch8wi7z6pDi2tBMUyBHGd86V877FgshvmcNWmurrczfCU4pXjgdJUX6E3+hLJG2Q8Beay9DGOETJGo7QeLJVEZ5kHJC9G4mG3KzYWVGYmj+sxxvd60k1dwXydN7IJyx8wTQVSvq87icBef1q4oJ9Cy+sR5NlzWwWRDNKR0ZWH2xE+BPpxDpQVjWmqoRJgbVDr+xLzesiJd4gYLk5mqh/eTmSaGUviEotfz1cPaSq84QZxPkboc4bp1ETgh0qPrsLPUN7wch9eoHwFNGSTgKZMSZSnm7vIYb0pq1ArYKR7TdofbRSSrYY0JDQYO3tYCYytAQzmzME6kvGwa6qYdunsFynsAcTTtibqYyqjF18qACwmScwq8jjnvmCN7o8+FQzLmQrMr2txL611QgKjFmAsNSTnErwgnhltudzsvolx1fMcnrbgKeXtYFTPW8+oQ20Gm2/uGQycoxKadILuLNuAvw4XflKQuu83jwFdK09WHJKIS4Jy27FXUn2ZVODtRsOltW9Nv0nKH6xMvcXF9LyE3DQ8YcdFhdpBUzSnpZ74BNPeOPwt7yFvZTDKwild+fEAo3vLnVWkdYGnzjM2BgS2qY3VVQi9I2i50048BLeekda0WHA5tFvXJwQuMWaoTUE8fpeMC7rMcI1jWk2fMtCEQAbcoiUjJt51OMqbELhasLroUB0TGv9UXi0hMsdd5B8cASbEaFzSsYliKKvW2/M8mq7MfE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR18MB6095.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261028144727099003)(261022105027099003)(261022075727099003)(261026140227099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tNqXOAvr2ccJkd8pN5Zw4wz/ZcoJRSJEdhXRQUPHpfwc+neThYLWu98dfk?=
 =?iso-8859-1?Q?9Y+uSpCXz/evuAE69zAkt0PMSzxOWSi62sKEUWG37pekj1CJEsuIduIDND?=
 =?iso-8859-1?Q?Y754iB042yRu+lkeMQCnnLHuSA4kowq0hXSS+DkYBYplcVK61/RtOfS6wi?=
 =?iso-8859-1?Q?0DrhT9RfG4+oAoZn3OG667y4mRnGTd0JMzdrsh47OsJh+WUdSOdc9toESK?=
 =?iso-8859-1?Q?lkfX0jALwYCAX1mnOb2m7Ta2a75sDutblqcR+2pfVYqR8IKhZ0VxZH5lZM?=
 =?iso-8859-1?Q?2Pd/t5GAZ+orr9ezJzv9PLETYNuBUBsW2MzBkWRyqB7RDYlss8gR/JUhIJ?=
 =?iso-8859-1?Q?YpIIVBtQ6QUdcUa0mZe9KR2W6DMOakbeAffx2m1BlqjaBssO+htc9sifAZ?=
 =?iso-8859-1?Q?vQvEgnUtcEnDRyKlufDiSMw/sYxS/wQ8lEDMofabRs6LECY8RdR+59SU/6?=
 =?iso-8859-1?Q?uuSCJBAY5hp4vNuyrS4WJ4N3mUvHfgH5dlAZz49jNPTZK2TUU+6QmKCBkS?=
 =?iso-8859-1?Q?v2cSA7eWwRsOKJ2v9OwGltWjksiZG/7nZccKjPtjaTzkcj9AuZHqT2ZvN+?=
 =?iso-8859-1?Q?c4Xipt/Nq0HZjSo+7T/fUuq1POIcjYh+fmlniacWxAd9I26rXj5QgUCZuJ?=
 =?iso-8859-1?Q?4t1XaVflVcxrhEEME3MDviY3p8tpUpNGXmvJlwSQTS0cXJbSOkzK2Xrk3P?=
 =?iso-8859-1?Q?DKH+oWp8kaOfWY5AovPWt7cykqTd7U3KulB2m/zEGVZlCVYk3iViU6as54?=
 =?iso-8859-1?Q?HCwwwsLAd/QKpBz/THV3QKBCqnPGCOFwBi/HbD/VkFINx/R/cR0TJRKC7F?=
 =?iso-8859-1?Q?WoNyikVBap36IGpbQkXTQqoUXIGnKlIW+KIdAOSdwE+y4rk0MGSX5/SpxX?=
 =?iso-8859-1?Q?9eAl7p+6K1GiXkZf6Ein1mvTUX1rHfazA6/ABv+n6W/7rJjS4N/zTWsxWk?=
 =?iso-8859-1?Q?gA9BrqPr9qsdckij+tkcyzNnXc8VZLFOLhB+MnHDHSGpKvWRt5T4wfGA7m?=
 =?iso-8859-1?Q?Iabs82web0f/unJ0yxokyiEyYZS5eBeLaAdFGjTRehDSoFNO2UQgjhK1Gu?=
 =?iso-8859-1?Q?7h2fJZMKTT39UHLMvwGoEmgXwH8b0m+TFNp7zUofZSvuMYlDkavOyCwZ1A?=
 =?iso-8859-1?Q?2Xjp1RCGrYl7eCZ9mEXxJbS+zVaXRTiyZQNXR2wlS4aLMrAtQJnoYDFHXf?=
 =?iso-8859-1?Q?4Mw4WTOI+iQ+TSWZz5KZvludFgFkxSBlODcrFPZ3v42ftI3wmDoyKxzZ/S?=
 =?iso-8859-1?Q?wj5YVQcqBkz0jENLTOYmXxREYn4VAbLnakRrHYLVUaFahRk7HqehL3Sv4E?=
 =?iso-8859-1?Q?8ZxL3MBlm4Z7rq1wy0/GkOEDPv7JSCwsC8/FHt8i+YXXtnM2m9xOdxCNwg?=
 =?iso-8859-1?Q?YSZG52wJ/Egy5Ros5QwIX0bOcbOklZJgF9giotKd3XQllNkdeDpPSK7Ciw?=
 =?iso-8859-1?Q?tTvMvYoRftRCNt8r69hfvHoihzR9upu15K/blKi2k7oNIxHMdPxRo9O+Cm?=
 =?iso-8859-1?Q?fxgipaKqZVHt67HT3l/7/a46y4ZnUOWEwhbn6QsyqYYkXkE4zYk3z0WVf8?=
 =?iso-8859-1?Q?bAvEK1TMjFLfLSBsUBK0QpPvZ7kMmOfK5qhmUdk4Oqm0l5gXSP13aVddVT?=
 =?iso-8859-1?Q?V35pRn7zziWkQGXOxVa9PL8VTuTJqdsDEFO9gb8bV1cgf1vF714Km3XsMa?=
 =?iso-8859-1?Q?1nEGz9NVXmuZAB1ftGXvYVBzTTbTfRWyNj6nceDFUlUkN+bL/pVjV/ZYv3?=
 =?iso-8859-1?Q?+3Iw9VlfKA3fyneVENA4ei7/5ZfPA+hrj2vTUM8tdaHR5GisDKn+XJMq6g?=
 =?iso-8859-1?Q?aKiFqed2Lg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QH/QM9OmCqF7/xMR1rMzoS4NR9H0UDWbqdYv6N0DG/+idCZAHCUCL1ekaF9FQMqjTl314z1/3TFB7uejg6IB7QIka/MCjCtxWYbJeVdnyhpxL6Mih0HxbBWBxer83IVjcrtWArphpWEIr2aGUP78IzEUKFikyEZ9uzPEAGkavAKnSfEm5S/d1VYSnzTJa9ff3nEaIW4L9npAcGGcnZgOW5jrN1Vf+Sdi05pZoGhvThPR+kQu3ctMT1C1XkQgZ9DZx/nZNbb98ay+UzbunkCcDwtD0UbJCtr2uxNGNaIHChPemS1mkYO3JVvQ14R42H2b16D83y/joaAGZqXh/W7Jdw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR18MB6095.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923bba6a-fd1b-4d85-a156-08df4bac7897
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 11:00:23.9105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OZjy8J5F9j0Bxecs75gN42FEqxDh1ERzoTJ2AjIx7ts5N5/i37J83gSVBWuTc/FUF+FJiUZgqi80H6b5zNhahQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF76053B204
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0MiBTYWx0ZWRfX+f1ZYKTanooC
 nShvoH5wGcrDc+oCMrPXZqBZlwSdGAWYSe5w8R7IfIi51n+WOCZswbrPktqNyRmIKxiR4i8SIwT
 2u5UkaAvcFezLJvwy1gMn8qt/MJLnVjR9kD1bZxUL7NFVCvyirbLjLpNfD7TrADkBwiGnHOhpEM
 94LB1QMnpTkmbVwPiY8dhbcACEN7wHAz4OZp3ozm4lqN0vKCHSkJ5sYeYESsdndBs2q7n6RbvqP
 R2bpLtHW2l4jl7GZ6ZORE7Sk7m+EkgyKyQ+hYcVIceaAKr6sQx6NOnLuz77MxdgLjqj+hwoGwle
 mJulqEaOzcn2WC5a3RlcXkJwObul6SXye8vRssEBCQtc5FqUdtZ10VKwF/x6tc/EVlKedWJLtwq
 26gN/I5GRoh0qOV17lBEMbrlCFeZ7wi2c6whxZ32xCa+BqgL5lp1fLjFXlIY+oRO8rZuiRXS86v
 PIY4pqms7ekksl1rPBw==
X-Proofpoint-GUID: NepBf3c7QuWfdjeXW9YPJX2dlK_89kjn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0MiBTYWx0ZWRfXx2fI+yft2/1I
 0dQivcDwcvUGl8ZORIb7P7c3YHKtMtHCSuDLqvu4jhpcIBuY/QgGhTWQvTS32rV/B/3V0UmpqKG
 f4VbF3r9ABhUZNBZa7wgX4d44uC9vbw=
X-Authority-Analysis: v=2.4 cv=WtC+otfv c=1 sm=1 tr=0 ts=6b08114c cx=c_pps
 a=staW6poURGFup6Z6Kk1YsA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=zJRp6_cAMcgA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=77XOSPeotPUk_shIfAYA:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: NepBf3c7QuWfdjeXW9YPJX2dlK_89kjn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-26_01,2025-10-01_01
X-Mailman-Approved-At: Thu, 26 Nov 2026 16:40:15 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

>Hi Kai,=0A=
>=0A=
>You're right, there's an issue where 3-DES is advertised and it causes a s=
ession-failure. This is due to the fact that 3-DES (sessionless) in the 8-B=
yte key mode routes via DES, unlike >the 16/24 byte key-mode.=0A=
>=0A=
>When the legacy provider is missing, 3-DES is still marked as available an=
d when a session is attempted a failure occurs.=0A=
>=0A=
>I will be sending a v2 that fixes this by making a change in the sessionle=
ss path.=0A=
>=0A=
>Also, after testing, I noticed that based on the logic implemented, only t=
he active list is used, and hence I will be altering the logic to only use =
the active list, removing the need to >check whether we need to use the reg=
ular or filtered list; this change will be included in the v2 patch-series.=
=0A=
>=0A=
>Thanks,=0A=
>=0A=
>Pratik Senapati=0A=
=0A=
Hi Kai,=0A=
I've sent the v2 patch-set with the above proposed changes with a cover-let=
ter mentioning the changes and the rationale behind each of them. There are=
 some additional changes beyond the ones discussed that were made based on =
internal reviewing and enhancements, or to deal with any issues that came u=
p.=0A=
=0A=
Thanks,=0A=
Pratik Senapati=0A=
