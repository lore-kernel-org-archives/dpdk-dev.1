Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18862D4A5EB
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 05:59:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAEA04025D;
	Mon, 19 Jan 2026 06:59:15 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 884784025A
 for <dev@dpdk.org>; Mon, 19 Jan 2026 06:59:14 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60INEkCv1417386; Sun, 18 Jan 2026 21:59:13 -0800
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021128.outbound.protection.outlook.com [52.101.62.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bryjc949g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 18 Jan 2026 21:59:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2MtfpwlX+qVkUYNEj+wPZ2s8CxwM7qMYaZu9sYZPGcFb0Xz5deqC33eaM0equ4aSs/y4J1OQD3fsQF2oJwZYot2J/GbykNj5kjxXTX6Ku/ZHfYypTMrDyQVUeesdboYBq7pYXYxD4vqRbG8A46/S1coHheEm/jlBGK9XYDEGlLwMHKM0vTOwa8kOjPY7Xr/JKrVINKID1Us+ops2C80l1A1S/VPrAltYPgLBHK3a1VxRLyYq5KSwBPDN+rYgfDZv0Tho9mmEG7NCHgHTaBhRaFFPACl0sB0QuXC77ORIA4Lr8lPUFN2bzlayRIPvX5k9tUhWjNJTkLScT0BmeZucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GI89EEw0mHazfunhr87MQDqM9h3Kn49Eeq8Slg8zYqc=;
 b=ZRI5tLrVsCnKDR4b8fAu6VBvQ3PRxc4UONLsRIaa+yznCykVf1ipKezziOMZeHZ1Y4b0IZeUbSoQo7D3J4s5WNzma7ISL6hAlCUR/ZOs1/jqWR/q+KTL8w+7a+sDCN4aQ4wwncpKrWNuA697GvYWqkctscNwkWlakcl3PiGqo7Z2UJursWQLe+21q5TKQ7XnsxERKZb/e1DNFekpI+JItKeV6dC665ZyY0OzMQoE9u8EhOK77F59gt+NVuwXccUDcz+FAwjMwDX3WqBNUWt9WGfoxlO4h3MUXdC4RLH5Du0EF/XQMMuqZFWToyOdQIqBc/1sX2jbSmShgK63TmG70w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GI89EEw0mHazfunhr87MQDqM9h3Kn49Eeq8Slg8zYqc=;
 b=aFQZi1cNcfS8JA9E658f01fb5sEv8KbK3zre1oJGYT/omU2ejc0ZLwDOnGk2ZIxA6chcFS/SebdF81qii407nRQM9Cxp5qyE6ukbrNODoil4k8bPMKMkdru1WcAVHAgzYPL85N+2WBDtEwtzFN3qlxDR3FBPRDedMoUfvkk+2y8=
Received: from CO1PR18MB4714.namprd18.prod.outlook.com (2603:10b6:303:e9::18)
 by BY1PR18MB6092.namprd18.prod.outlook.com (2603:10b6:a03:4b9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.8; Mon, 19 Jan
 2026 05:59:10 +0000
Received: from CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::4e2:8a80:85b:4920]) by CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::4e2:8a80:85b:4920%6]) with mapi id 15.20.9542.006; Mon, 19 Jan 2026
 05:59:10 +0000
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH 17/29] doc/guides: improve FIPS validation
 sample app guide
Thread-Topic: [EXTERNAL] [PATCH 17/29] doc/guides: improve FIPS validation
 sample app guide
Thread-Index: AQHchaS4e+ZEWI2IEkuu6r3UwsmEpbVZBeVg
Date: Mon, 19 Jan 2026 05:59:09 +0000
Message-ID: <CO1PR18MB4714C4B04A486DBDD424C9EFCB88A@CO1PR18MB4714.namprd18.prod.outlook.com>
References: <20260114222458.87119-1-stephen@networkplumber.org>
 <20260114222458.87119-18-stephen@networkplumber.org>
In-Reply-To: <20260114222458.87119-18-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4714:EE_|BY1PR18MB6092:EE_
x-ms-office365-filtering-correlation-id: 4bf2045b-68eb-457b-0ae1-08de571fdd27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?QBIEPXbcdwWKzwUfOZz/KC7Faqs6hVKyqbLlilmADNRdPfjpauLMBD14mx6+?=
 =?us-ascii?Q?U16uJ/pFLBCif7kHWKGa3BgGrOihwg6v97JDFKlczM5Ma+s2LeWDJMBjUhlH?=
 =?us-ascii?Q?05XrgOq4354iiJLlRCK3PoyULiqKlvODI2ulhWYWsXrQ+bE1aN0C6BPY2czL?=
 =?us-ascii?Q?7in0E/BlNBPLB01JJ3YFZIXpZRUG0tSc7XRc0uavOr6ix3ZQ4T/haj8Yj5qA?=
 =?us-ascii?Q?Zuw9osd0Q0FmfIqxa/7pV65BQ1FW1pTybojEv32jSA1M7eyVat+62abLXQT8?=
 =?us-ascii?Q?79i/PwJXNKcPV5Jt4CHZW3mFSL+4e5aBE3/z6viMX0qNXHqPcYykr1pKl0kO?=
 =?us-ascii?Q?Y637FY3pEgXBHkVSO9TuillPqhg+oemgZ5tKo001sfnYp2krPuXlFEURogAW?=
 =?us-ascii?Q?jrPUF6dnGZ+dEiOyhpdTISj9lAPtIt0xZTj4PoX0TDN868w0/uP8RdK2JwWu?=
 =?us-ascii?Q?A3pPc4C/EvtA79EdMp450K5gEGOIlxpLB95j7xrZsu5Wt6zXlU345uYvgC7m?=
 =?us-ascii?Q?WE+Onvtkxpd7jynjQ7ElUSIb6vARSe9vjcMPYzNUVntQlM+bKDtx7JO5jKKg?=
 =?us-ascii?Q?i3/w5DOlQiRgP5a/J5D/dRM5owJsGCN3Rmlv8mAN6i9uNQ3foM9WG2WMuCvW?=
 =?us-ascii?Q?4fuabQ6wMZWk6TMjxt2wBiQBBsO1oUMvfrPH8y2lJHWQTyf+9qb7wIvaqVQd?=
 =?us-ascii?Q?dhjVlaKQ9pPGXwqeT+NYwbfCvUnBZLI4h6Tn/FbdjfN65klkPNmXWo0rukMp?=
 =?us-ascii?Q?6qWX0XJpHlHn+doncTG+LfEJ4A0uBoZuio5opdgK6a0M7VqPWpxocAaFwnqX?=
 =?us-ascii?Q?Mk1wt3jUXvv1V1mx0dkm7djHBXCOhXAtF2fgV69gWrDriXt6FUN4u1Q79ira?=
 =?us-ascii?Q?Ui1RhQB/SLJe41Uezi+acOnyM3iq8kdLQoLHs+6NjEustmpE7rIajWYKfRFk?=
 =?us-ascii?Q?hx0RmqGjS91vGkZYwT0FMPe9jYi6m+1jkdINP/42731uHC6B0HcDyZkdPSg2?=
 =?us-ascii?Q?YDnubE3a/fbkYbqxH0A7mwnVLc2pZahjeRd1cLAwqzo/Ken0Lym8Y4eAT4dK?=
 =?us-ascii?Q?2fhrqxILHaJm9h3irmucrCAlOIrVaxOvRv9ISjKNpgHlEZtgcdg8xF2z3wI8?=
 =?us-ascii?Q?LWQWFvWTDpmqP4Zol1V0axGMMykFL4n/7ATuqhtkCERPpDo28MhhBTTLDMq8?=
 =?us-ascii?Q?Sd/YHbPdKDn3ShaGPTWLFx0HZ80IgZW+RyJoX5003tLDe5qMdtBmuIw+e66r?=
 =?us-ascii?Q?vyl5sT5aAHnFZKjQkeNz/5JFD32S9i64GigvtsZHcz5DezcyMD6UTQAg20t8?=
 =?us-ascii?Q?44ad6lB3aydhk0q7bV5wkqpEqhnkTg2xl5PtdK5tia24OcQZFnjOIGtqrZWE?=
 =?us-ascii?Q?qdkExKOw6sVNIFgXIrwB/s/YfGFq86KsuYmqjqg0vCvxzGYxeicuYk+gU588?=
 =?us-ascii?Q?UYvhuwDc4roHGtOcZNC8XlYzwHDJeHCvcObKnDssqaLvqfe8216e2M87D3Mj?=
 =?us-ascii?Q?lr0ffpCBov4x3nOxdCJXCsI37AKAThXM6KiRIY+KZr9t5fWERjgRs2gcTUFi?=
 =?us-ascii?Q?EdyfTIBgygTx6VVQdngySTKA6YXGVTAA+bjmFdojcjMT9w9vRHGagpOBnaW9?=
 =?us-ascii?Q?8TELGj53D4zmhZFU6GTTKsQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR18MB4714.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EwJgEit9WICXE49NfRvU9cWLg3aU/sMfqC+1ROdyme/BoH2ydTdrNC99tUEx?=
 =?us-ascii?Q?JS8+dFYcVdatu0O7+bilSOHQsmZXzVkgHWAmnj3cOpY5+s2n883pX0uMcXAV?=
 =?us-ascii?Q?cwn3TPWbRktYhQbB/VoMsM08CTr/BYEWMSEKajSr3Y6iVS5Zs8E17gG4tpW0?=
 =?us-ascii?Q?1Ar87Jb/Dj5bdkHvhIAzlYp+ZxAnuwxLe1mmS5zzfoGldhInw6aLa2zj6wpC?=
 =?us-ascii?Q?gGQ6TCLwMBg8hKYRG1Ihcvg7pqOTZn7s6GdhjJzkfCXKqMtETTANXUXTbumK?=
 =?us-ascii?Q?XO3N9wxK4VxcE5Eas0tOo7J9kmhxwJJUTviG4E3a2cNqJ8drBi68QHIT1zrS?=
 =?us-ascii?Q?sWErddBPEsSl76SE5BCwqtpaUDOV0+4xGDMy/9leYaC5iQPK22pGM6pI4akt?=
 =?us-ascii?Q?AlsGeFBmcNZ4fnECPIBVmr+26MAeS0RykT9P3Nm0ZIFnc+TA+KjXhX6U+TUQ?=
 =?us-ascii?Q?eXpS/RsS6kdlAdxkfyXsG0LI3OvMh57RPPGBTGNd9m6btGg9Z8oreZ7G/6PW?=
 =?us-ascii?Q?d+WgOPSmGa2nBtQoFb1ZaCnwdn3Y0Cm7Pkd0Nhabg9wG1fvIF88RzkxtSqa+?=
 =?us-ascii?Q?871HtaGBYFCPKv2Y5H2TMdrEZ/Eqz0LX/3n/10ROJkMgIvmk2sJMSieEgwBP?=
 =?us-ascii?Q?tOZET9n+go9Atqv1BEAn3tiK+DlEh5VrxGAS1BSaORTLmmVAkq7xz6P6sCqQ?=
 =?us-ascii?Q?dllcZu+vcK2zkCOpC7ljZaJavmS1zIqCYErrA3E+JEZ3YTmI2wp1ytUG+XuG?=
 =?us-ascii?Q?4/C27K00alEpvBnGL70QZY199jBo5QxDUSj4XLDLayA0E0B5cYz2saH0uSj8?=
 =?us-ascii?Q?FPUOlkE47IWWka+y8vR11LY6CkopHQnO2jjt746LT/DBc+5Mwd2yF/XqkQdW?=
 =?us-ascii?Q?L540myd0L0qeRKs16vOkQUe++lOCJiE3iuutl2L6tCt+9jlUItXf2myRVg1M?=
 =?us-ascii?Q?suWNZysWqvIEaQ8PPVP5AvFoE4V6tqxLUH4LLiQpVZggEZxbualab/Mk1f8T?=
 =?us-ascii?Q?fWbeBKBhHxqjui5RHWazRbKB7S1zXOd2hb9i8lMRd/kt+rK/Yrk0AjBGm1VT?=
 =?us-ascii?Q?5gVKWgY7xE4BOWRtfPjo0KvxBcxiQZncX3+rL3rxmOJznMfgy6/Nb7xNeH05?=
 =?us-ascii?Q?aKvOKdNmFRIl6d5jcRubo5LWg6K5QNuXEYGtP5YFTom8HdEC5QkkoMvqmHXj?=
 =?us-ascii?Q?FFGCR8JY3f0ZxvRdpbPkTSXwpdL8RPkYpSgoiWJ0nby3gFnjglvMxqOPwgQN?=
 =?us-ascii?Q?5YbU+XBxXGIj6zZ37l0R+wvFk4FO+A3R32Vhf9iYRiyUGJx/tvqTFXiZ+3yq?=
 =?us-ascii?Q?ml2uoeNQVvhjQcX8uTrqlq84EjqXCXZJB3zIS8wd3RhJYS9ce2MhCAHjSrf6?=
 =?us-ascii?Q?sYJLIq/uRTLbMTbyUG2Ic5zGNpkV4Uw1KCqTBlHtU5WapibkscUKyh1hNTLc?=
 =?us-ascii?Q?CZe40I6qKR5O3HSvxGsi0dIiazOA4WWmQ4vmZ0rBIqG5rmkhOBI02V9rIdgx?=
 =?us-ascii?Q?0uzdXerQzsxc4DCG3AZzyYMTKvViy4gTZODeeHH4xMw3MraiR4TIhIMF+lvD?=
 =?us-ascii?Q?+0ey5HgnAPi6RG6fv+kLefM1R4YGg6sCD17tgyxyyiL9kYo0GNlRER5TtHTV?=
 =?us-ascii?Q?un/s648q8y7U7XONysBSXQZT0A+w5552r8CQE7jahWULOuMApeVHc7SDHf6J?=
 =?us-ascii?Q?4azbsdmurhluWx/rSGehqevzmBTxTX10RJgXzjwx16ayg0BGPttIUmxPxkA9?=
 =?us-ascii?Q?o6IINepPWQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4714.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf2045b-68eb-457b-0ae1-08de571fdd27
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 05:59:09.8918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ecc6uh6tbj1HWiNyV30doBQqHa+9M0+CQEGHlmnaqNDzRj6q2Y23gtA4YJwHYU3NM50erCNFw0yL/Cot5E/l8Mv5MHOwzT3bTYADiztuDXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB6092
X-Proofpoint-GUID: pEGJl-ws4LqYvfVa5MxYrWRCZC5UF6t5
X-Proofpoint-ORIG-GUID: pEGJl-ws4LqYvfVa5MxYrWRCZC5UF6t5
X-Authority-Analysis: v=2.4 cv=RuDI7SmK c=1 sm=1 tr=0 ts=696dc831 cx=c_pps
 a=ONq/xaQmkJr++vtO36SE+g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jZVsG21pAAAA:8 a=M5GUcnROAAAA:8 a=QPE-niTOZ6c2HdfDz9IA:9 a=CjuIK1q_8ugA:10
 a=3Sh2lD0sZASs_lUdrUhf:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA0NSBTYWx0ZWRfX5AEjTD9DO5bA
 g6MHhLPLcq3OFjIJNaZvbqvnzRGfRl8Y04zY8/oqHZkJa+gzmQvyxospoPJumzlWvu73FLccml2
 cYTUYWsiXTa4T9o+1uwcYb6T/6ZW0FRjdWXJDoTvFRuQxECJMcPsY755eNVO6k+SwDu4zMOY5Z0
 vekGy8H8ET0E+1TRI3imKPUZiDVCRz0d5xg0hVQZtc8TniOjPBu8qPMLEpdYd/6H4+S1UNIyDSX
 SOcYQxx/V0oDjFsZcnFKPMTawELwO4JUQ5yKZVfG3kieW7PQULXUjEOEXdlxUzK4REYDOUqtlDV
 L2Ze0rsd7r1+jOPim3mQ6odPKEqpZU2MCuOeSLNRcPiEytjcbtgMwWzq3Ap9Wx3r/pwbBzvJ1gw
 EdufNIcOaQf6YNJ7ZKwY0URphmULcYOqg+/a96RlJJt58ZUFG1tSqoa+X2Rc4CMVLqRCgQtCVTh
 IdpQiLIMSo4Q25eulpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_01,2026-01-18_02,2025-10-01_01
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

> Improve the FIPS validation sample application documentation:
> - restructure CAVP and ACVP as subsections under Limitations
> - fix indentation of code blocks and bullet lists
> - improve grammar and clarify explanations
> - use consistent formatting for options
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
