Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A36FF8875
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 11:59:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37DFA402AC;
	Wed, 29 Apr 2026 13:59:12 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 99B0E402A3
 for <dev@dpdk.org>; Wed, 29 Apr 2026 13:59:10 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TAHLET3104495; Wed, 29 Apr 2026 04:59:09 -0700
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020139.outbound.protection.outlook.com
 [40.93.198.139])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dth1md7q6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 04:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iV4OYjNEm/c5zlofcVldgVXZ3IcLS4B6LKmamr3kagk0yhhY2C2OQTlP1eyX3nQlfxImdqPP+iDHHai6ZGIRcNFKkIXAMOeiIWIJVttcESDQXD+6AK/3AQFnSzTmOoedWARUX5mz4pi+iDQIKxGQyAiCKACsW6BTo1sFpeuDQwQKlEs5iNWdrz17P9Fadih7RUF2LUcNXK0zOjiUy6bLX38YpaSi5WWd0hqrAe7pA8bZwrem3QTOkJNZRBxiNvXhl4Z6kXFMF1ypOGurx8hC/2M3RYw8tyPXxBntvLUfyRQ+K3T/G/6MUIN4pZ2TWyIeKc/5stW7rxZZk4yOG773LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvrJAHh92wotApRwUcQh99Ov8WDWRZ097tKLLiW2Yek=;
 b=IErMhV8B+3w3ja12wI/HHrHKGF6d45VHWvYgrVCChbB+cSG5kb8HyNheVutRiA+OhM+iIIw02ZQP8hYi+knAbxQpGhZkQgJsqCCGxRo2ymgZIVTrxuRMGuh+clnfItfTOjLFN41qIafvy1gDtmT3RUCnBxCvlzAIVoMsoJHtArRZqtDaRpBj8qf5No9yt/eZ9dwDHYDWV9RGQkV+z4Mf9+TcFZRjgE5tgatXdsXI9Sy1ktyPlaCQKEhw5kNHVszE2anwMdpc4ntd4tB35yMcXIZDn+0GoWGdmgCYHfUBZKJdiDqmjQLQUJos8LFPXQjhG+baF6U+7B5cxKiZgvOhzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvrJAHh92wotApRwUcQh99Ov8WDWRZ097tKLLiW2Yek=;
 b=E01d6xfUL3sOvUYtX9QCZz3yuY9WtLCHe3IzJ2VEF/upf54rcHksMVFWPorOMLK9UmfOrqHajPKKTpkiAY4PQZBjWgdxdXIVxH10tTJLHBeVo0jkRpBtZTXg1nEA2K6y7O+cnRDQLGTaYWOkH0phopQWidVTrm0G7jOuac5RFeU=
Received: from PH0PR18MB4672.namprd18.prod.outlook.com (2603:10b6:510:c9::16)
 by DM3PPF09A669757.namprd18.prod.outlook.com (2603:10b6:f:fc00::687)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Wed, 29 Apr
 2026 11:59:07 +0000
Received: from PH0PR18MB4672.namprd18.prod.outlook.com
 ([fe80::9135:40ca:3414:9812]) by PH0PR18MB4672.namprd18.prod.outlook.com
 ([fe80::9135:40ca:3414:9812%7]) with mapi id 15.20.9846.025; Wed, 29 Apr 2026
 11:59:07 +0000
From: Anoob Joseph <anoobj@marvell.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>
Subject: Re: [EXTERNAL] [PATCH 02/23] crypto/octeontx: remove check on driver
 in remove
Thread-Topic: [EXTERNAL] [PATCH 02/23] crypto/octeontx: remove check on driver
 in remove
Thread-Index: AQHc182tr0u2T9W4kkiz2RoFd1EALLX17yDf
Date: Wed, 29 Apr 2026 11:59:07 +0000
Message-ID: <PH0PR18MB46726D822DDE04A776F5DA62DF342@PH0PR18MB4672.namprd18.prod.outlook.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260429114503.932575-3-david.marchand@redhat.com>
In-Reply-To: <20260429114503.932575-3-david.marchand@redhat.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4672:EE_|DM3PPF09A669757:EE_
x-ms-office365-filtering-correlation-id: 1e413a29-adbf-46ee-ae70-08dea5e6b770
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 4y/9n435kzs3470yXnct3zJ/49qlCyhZSeFRD6wePanlY0uc2c7vR8Yuek5JNC0HIgxKOxX27DV4JkncGSb1ZPpCHphz6Ijgyv5QVMqmhzzXu9cYyvbXhlYlslONpnyVEBBpOT+wR4JCpuNyBYy/jq7O/pz+HDZZLaq4T1URPSfUIn7n0hXmGhJ90edpCEi0bVnySnKPIK5q5zGpltQypF7yMMZWZxwlWn9q29Xeuucs5HNxlaZkZTbXsbnM7J7gc7hDiRUKNA1Y6MN8WPeKNg05dlcA9qNdY72LSLZ5ygSD9v2G5GizQWDUXok8M/58XTphOY5/4q0YIgMykP+qBGmgur+pbfwVh0tr/CCXdbuVcoYl5ykSdtBEPIPmi5AsA5KbDMdy+p5eoLomZUYTH79YP8hibY8ibTVrkXz7xqrZ3Pg0NS/Yema0ridJteTvYTigvixBv2VxT7f9byqG8IWgIE1UU/3d3ieRtRPGoIDpxtprYCSSflT0ihBGBKOjtCM3+Gb1+AmXUPtt/njUYJ3CCW2Yys9ZiobGyMHrR2wZxxARKI0cAKFonLF83FTY0KabaFLhUaul1VAPbIFRv3xQnV84bRxUahXuqrLjOchJ20QFq0fz7jtq57sXarZGI0egRa8dqc/MTXaLsnatzkgy0OOSRNHD0eiYH091k5K+fC6MLUVrHf9160bDlL+U91pGTwxGzLVuFOnKwXyg8w9DAGNLHPfHf+uQXXtlqQk+PdmrgJ34jgXaInTXZVcQRt+0lTJhTUfTrYx8siBxhlZV6yk1TLbkFDFnEPtpXDA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4672.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1VkOvJVNDZFcTZQQ24/uoUh5BsbdW4E1T0Pc/JhDmPBy6ZizbNeC9byYI4?=
 =?iso-8859-1?Q?uHD/ZwVLRL3TALHIoxkiSHe9QjUno2NAQE9+hSq6NpKI2kSlNTJ5HV+MzP?=
 =?iso-8859-1?Q?C7LANQCDkXjFynpZxfib52YHoq93GQ5Z+MbnAGDIZwmqPtYMNMSCoxJKdX?=
 =?iso-8859-1?Q?evRE/zyLslvcRE+oTaoPzvWhnTcauJaJOXT7INQESEyapsR92JOyr6ADXa?=
 =?iso-8859-1?Q?lK4+Bo0pfw9w3oVCD6g7cY6/mSFGrLzfVkqKjoDFm98OIP2DwI75G5G1zF?=
 =?iso-8859-1?Q?HYBGI6gLmJ6TEpA376vcfBN1/JOPZDsh3Q8+Dcrc65BFs+OdhejS4kFr2s?=
 =?iso-8859-1?Q?bPnxi5vdoFeL3dhnIAZueZ9wQC9KeGRjWZAKFC1KaB2/KbbQ75a+XoU9dC?=
 =?iso-8859-1?Q?Lt4QiU8r+oRRQYQELVEiQ9UvrlMLQRlqzdQLyDT474CXq9a5hkTjo5Ls/z?=
 =?iso-8859-1?Q?yruphVVItLrKwkj9fAVzqBq6fhCY2Ih/1S1dl97xfkrSEts7sfvMd08Nf9?=
 =?iso-8859-1?Q?XoNBYqdM0PEebJs2SwIQO4ygoyA0l8uOX5WNTMHYZasIG8EdWsNpPPVXz0?=
 =?iso-8859-1?Q?1kbaSYRk/MmfIZaIH29VE4IgLg3HQBsixDq+LdWtBS9bQQ0lGTOLKoLxSq?=
 =?iso-8859-1?Q?bkyyUYZqx+Lq/neDLISlZjWTTtWo3BqGeJJpIdk3md1j4aHneOEGBXAJvm?=
 =?iso-8859-1?Q?xqYZjtf6N5DrZxrPd1If5elKCZ4MuG6sFL7vhJqYyjX4w8OulFJFPEoOoh?=
 =?iso-8859-1?Q?TTRj1b8ht/Ek6UejjYOSTzOCkY/Vu+BEvwE8KJvl0p4anxzddWuEmLLy/x?=
 =?iso-8859-1?Q?6AMpLEzv1BBzHkcj2tLIgsPsIJl/8BJEMy5C1v5Qmj9BWC5Xb44yIZuQct?=
 =?iso-8859-1?Q?qdkSJNfrRTWandjulUs9oI0bzsc9vkMoD86VKLh7DabSDMno+IVCkNBUKO?=
 =?iso-8859-1?Q?vu2EoFRdzhPVORIkaDSnuObWlfXxtVoaCurVeaYyOuOZBVuuXHr+ZceWAb?=
 =?iso-8859-1?Q?l1zQT9aUSCdqy27geYfIjWPHE3tMRw2bjcsRXdglNKCPp/YZ7wCUk5lual?=
 =?iso-8859-1?Q?COTSfTB8ClgkiGtyDXZ93iHax8sdfMadoSdgG8haxVJuSTDogEISJmjlRp?=
 =?iso-8859-1?Q?H/zH235LgM6Hi5UQRZjTLYg/EoR1NUNCx54+dd5hcTw/5c8gvz8x1sBkCJ?=
 =?iso-8859-1?Q?eAZdiarK3Wxg9zHCw0di3SGGkPwbeAvz4Wi22rjt7MOWOkGih+2SI1OkD4?=
 =?iso-8859-1?Q?t/4nk4rcd+QuuPuGpUBppgycA54UJ5dtWUdoqQ4mbykIJNP7X6jM5v5jQz?=
 =?iso-8859-1?Q?I9pF3CH9jN81KGQbYogexKK0cpE1BoR5zwgwlMvxZBmyGdIU999Qb4pLhO?=
 =?iso-8859-1?Q?bacj7Q3caMI09Yh0XsKQWBL6FChncKEX7MCgDJIjN1kYzGj/PQmZajB7eb?=
 =?iso-8859-1?Q?eSvLE6n520jwkREPyz14J4Kb1Te2YaziP/HhfIuSs6I0U/GES0KOrgLQ3E?=
 =?iso-8859-1?Q?krtk0f+U7C6kcMFDnPiXHRtB7WHfW0fhYoyJe3Pox4gwzQ2QGnx+P/U+Cu?=
 =?iso-8859-1?Q?6JyKaNKkb43FGWJA5pBu2r+ZppI7wfj5Dtj3UtQgsHLuonpxokslEUMeRS?=
 =?iso-8859-1?Q?QQbcjVCCT/HHKxGdS2LBDcB+69Pe4m1Fn11eG2NL9/Lls6HO59w7Z3WSZi?=
 =?iso-8859-1?Q?3FRBVJJefn8RMq2+ghC6u40h63FdoT78AiwL1GE5kVO7Uu9EqzM8/mTsiW?=
 =?iso-8859-1?Q?zqYYKT5ECk0t5Xn5U/86j6vaDboYABfHSFCJqVUdzvNwl8?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vjDN3kSLTcKkIzWRCTLS5plAsPPutsJrU/gNjZssbUdi7+etXxwjTkVtgvZYD9YNzXlbUItWKgjyT7U7JEI60NEWhf/7QZH4K+tow3jyZ+hnfZMWwsPdAy+HkbbWXDDyxl5eHFHB0qiKhajFLlgPqTiCBsBFEkCIhLqDrS+c384OEyA5DCnmXx+qLqh4ed9g2c7clxUSKMab2GAvAJ5EE7wMGwqBiwTg6CheUJS59X0v9Vg1wSsFo056lljgctqpK8xastUXNEAUq6dlS8B/ZfibUnyOH9d9N9jUZFQKwsjoJquYDbHherB7/FLj0Wus4UjtSvAKr8xHuz+U9WnYHQ==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4672.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e413a29-adbf-46ee-ae70-08dea5e6b770
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 11:59:07.1513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cjCiRejK7pOR7yDzdcD6Ko6AdxIYcD3DmOBksNslxvMnLyZl4Gn+RWJbYkI1TVJmt4Mie1CU0+mNi2GvhQKvhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF09A669757
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEyMSBTYWx0ZWRfXxuhq1WHomiX2
 2s4v7kVAAAk0RSQYuDij/IvoVKTxymLhWj4SSNwqSYHQvgtImsdFkcKMhymyWV5eSd5kahC9ius
 P/zAjqy+QCfxDd10JAS4CPglPWEsb9d2uOe41wO1UD5bqoK95eO4bIVFXp4r+aQR5D7aGebkKLQ
 21Z2AVhZ3ti5ReRNhAw5oLm5GzPgcctaS5IlsaYvRk1MgRRDZWLMnUgcrC+9yoeKIjbBgicsvi3
 VPfMi7chH2e9I57PHRL1XIg/PDEL+x7z4RE2kSjLtO4MVe1do4lixXRYBI6DGS+joUMxfgpLGkC
 iLUijXrxFA70fhpd1Qx3wJW5iBsZJ+rPPfh1erVIbg6d3K3Kj9TjxjGDe+cve5VLO9HUdK0Tk6K
 6lnAVtjJDSQ2Az1XnGGM6/VlW+Cmgm+3j/FTp6Gur5MOS4eT8EpvnrFnnr1BsLzK7lDb7IApQEX
 XgPvGkdSi7ZsolEhXvg==
X-Proofpoint-GUID: lM8lRAdrLBy3PzUL4a1giKrmppm2eTVd
X-Proofpoint-ORIG-GUID: lM8lRAdrLBy3PzUL4a1giKrmppm2eTVd
X-Authority-Analysis: v=2.4 cv=bapbluPB c=1 sm=1 tr=0 ts=69f1f28d cx=c_pps
 a=dNw5gGrGfw7lLk+3QxxirQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=2w_7sdlk2ULtdQKP:21 a=xqWC_Br6kY4A:10
 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10 a=-AAbraWEqlQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22
 a=20KFwNOVAAAA:8 a=M5GUcnROAAAA:8 a=_nzd8k07FKvhjgl1Q9YA:9 a=wPNLvfGTeEIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
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

> The driver reference in the bus-specific device cannot be NULL since=0A=
> calling the .remove is done after dereferencing this pointer.=0A=
> =0A=
> Signed-off-by: David Marchand <david.marchand@redhat.com>=0A=
> ---=0A=
>  drivers/crypto/octeontx/otx_cryptodev.c | 3 ---=0A=
>  1 file changed, 3 deletions(-)=0A=
=0A=
Acked-by: Anoob Joseph <anoobj@marvell.com>=0A=
=0A=
=0A=
