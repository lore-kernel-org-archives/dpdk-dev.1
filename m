Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77945C9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 11:18:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D4A7402F2;
	Thu, 24 Sep 2026 13:18:42 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 81B1E400D7
 for <dev@dpdk.org>; Thu, 24 Sep 2026 13:18:40 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O7Lvlc2557031; Thu, 24 Sep 2026 04:18:39 -0700
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023106.outbound.protection.outlook.com
 [40.93.196.106])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gvydggrdp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 04:18:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1I1I+1GlMyJ/2MVWuIOzi+F86tmPFVHnYGnj6XDIwHRX3f+ddVMQgLCobazAvvWbHK1ig8NdEB6MnKDenaUyYSuoR6J0rbIgzBq0+v8nOoLXe/AGa4I4007M/iQQnAYq6FgmHd7t9L1v9DNdFlw+GUVZoZSpX0/tf55G8SW2W+h7I+plzTG5v7sNcbULqBZvnuXJJ+UQhG92Cxqd17p1aQhgqmodzoKxzaktKRGbvtxDb1VBtdXxCqMhsamPbrNuuXxvPKIAW6UZb4vDDsvo0vbRR6ejKnDTjeraooVD4OdHBvtbUb/gzzWEkULU59JMqnHQAMPp42ZpEjKzNCyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bptrz+SGe73eQJffVmO4gfqiHlt1eoH7nRUARiR2yVo=;
 b=kJeHxVHqSjUSkbsYJzG7EOLWj6IpwUQAQxzax5AJRHhU0sZaUjwpXMyq2SIUN8kCEozY6c1mz5g0jZypPVJ2ZsvLy0OJm4BpBsBwlZUxHrkmgVL2Lndu1wsOKwtQ59yIlH9tMwGOI4BFF4LozuziW8xKuLPw1lpq+5U4298VwwIOQfekXc3ctOBdCGj+PxrpcawnWc4wkt1Sb8FEHVe9qOetTaRjwUePAR2iXvqC/8tq2VI2yUCKv1QB6dotXjTWxDGrnjZQHpgtmasNhlwMWspC1v6TUwIdKPgs+xE19gKg0Hd/QGKe3wVVzCRcRJBJOIXVgurcgZWZXHOX2SLoGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bptrz+SGe73eQJffVmO4gfqiHlt1eoH7nRUARiR2yVo=;
 b=vhDmhpFq8gxj4DrvyIkmJKEd118GQqr8S4mP0hnOAsLdxqFB5TNKJ7Z05YrlY27Ez2h9SuVuEMDzSHoAmhWLx9LOfuJ9U8MXh8O95w9ens04zSIdSGx04hf2OYbbXZrMmYF65fONhxh43OEjTDFNTJrKPNy4grhfaE31de/POxo=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DS6PR18MB459596.namprd18.prod.outlook.com (2603:10b6:8:531::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.18; Thu, 24 Sep 2026 11:18:37 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0428.015; Thu, 24 Sep 2026
 11:18:37 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>, "Nicolau, Radu"
 <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Ji, Kai" <kai.ji@intel.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: RE: [PATCH v2] crypto/ipsec_mb: require minimum version 2.0 for IPsec
 MB
Thread-Topic: [PATCH v2] crypto/ipsec_mb: require minimum version 2.0 for
 IPsec MB
Thread-Index: AQHdLkDmJuObjuz+fUWawj6a2klmnbbd0B2A
Date: Thu, 24 Sep 2026 11:18:37 +0000
Message-ID: <CO6PR18MB44840100B18E768A90E3A5F3D8812@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260811112636.4106950-1-radu.nicolau@intel.com>
 <20260817093934.139988-1-radu.nicolau@intel.com>
 <SAWPR11MB992100DA82CA3158F0D374C184A72@SAWPR11MB9921.namprd11.prod.outlook.com>
In-Reply-To: <SAWPR11MB992100DA82CA3158F0D374C184A72@SAWPR11MB9921.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DS6PR18MB459596:EE_
x-ms-office365-filtering-correlation-id: 08dc468e-00ac-45c7-3add-08df1a2d9434
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|38070700021|4143699003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: n58RmKOY5XhpL5UUN1IarSHRHnC4rbHLYjLpRbb1iLV5QnwmjuhvSfPj7rwaTs5M0gj0W5XSZS3NO9LJBJOr0JCj1Z37+QQa5EbzqMg5OjA57hM4Yfhzyl4JIeVSnWre2IviM7PBOq+wmWKTRU1ZhVBi0uhTgbI6XCyiJ7jBjr/KdRyt9eR77kcs6i8gr2aiFQHbRuwpo9iESLxBXdFZTPdrb5sw7nvnrFEywiSr+5UJMyprjJW2zlJLauW6qxDhipbmIJpJipU/xwOOO0WGBZ3ssAocxtlQ3Rjv9rpC80Kp26DRPOsKLsRyxkRA7FtccT0QviPcL8B2Qr4Rb2A8SvfESGViSb3vfeHayfPTQ7x4Vi5CYvqBU2sj1mv/LybHEcXD6y8tDbQ1MMGa9vwUYvvZ4lZtHxDBzH3kjmZ8TsX22Roi4J6h0ukKTcqKALs5aSRQRLp6C7/YibMVxnV+l88NakiSd+Eo+aC6BDVXNE5USovz84f1vqvyqiLIWR+yup9+IqJuF+MF2ganf9NrKVp+ytxIBkGC+OkJM80ymJHwBeBDLK0vbfi7pGq8e5AfZwD8PNYSM2cfGHIRWpxhPGqh8EQ1rJZixt7XSAxfhC6orSuBru0GJ/7xvEo/BHcEdPTJF6lAG/K+yvj2stWkVdkTvGqyuA0ISA87wyozKhtr/eLVbmjOD35+ue7AdakLg+Tr3Gt4znAEwWRIBptypg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDh0Zmk5Nk9WSWYxN2twejNhVEpsTjJtRUxFalVVenJsRm0yN0xhN20rcjhF?=
 =?utf-8?B?bG1hNEozNjFFaWhGSXNIc1cyMDFBUnpzYWZYYkQyWDd6YWRRUit0RmdkeXNu?=
 =?utf-8?B?dUxKR2pYc3phRHM0VFVDdnFSaGdKYzk4TktWNzFRWkVORHFreHFBa054UEI4?=
 =?utf-8?B?eWRMYWRoMkRhTnptdG9yUFFYMFJWN0EwTFVXNjRxVHZ4cTYvME5nV1lKVzlj?=
 =?utf-8?B?dXc2bGd5dzhGT09IZTg1bUN0aXNGazZiQnRJc0o1ZEp5YUYySkU4SzJRRGwz?=
 =?utf-8?B?R0lrNXNwZG44STc5Qkc1SG1SYkM0bHFuSjFJRjdwbGZRemxiM3lTYks0RWx3?=
 =?utf-8?B?cWl1R0ZSYlNGWFlKaEZsTnNVTzArZWhVUlF0b1oyMkhlNGZ3aDl2cnJWeFNE?=
 =?utf-8?B?UGJETmpuNWJlK05odHJZaWhUa3Y3TDdqV3lyN3pzNTRINTFRTUhDYnlEeS9m?=
 =?utf-8?B?d2hpZlpMeFdydmhpWWRPcC8xUjU4MmprVDhUaXZOdCtRS1VUcjlYbTUxeExI?=
 =?utf-8?B?Z1pGVmY1RE1nU3dwaFg1YzViRU8rVi9oUGx4bHE0Wm83eS9wdXREcmJCZDZ1?=
 =?utf-8?B?bXI0QzU1UXlRNUtiTm9BVnRVZDVtQWZXbWxEYVFpQ0t6c0dGQjNNcGk4ZWlN?=
 =?utf-8?B?NkdZMjdRcjFrMmgxandoMDhGSlVoSnFSTitaT2c5VDRkNHl4ZHlCbVF2VFEz?=
 =?utf-8?B?Wkgxd1AvS0lMZ2FNZjFjdWN3dkwzMW5ubjZMUUUwbklBR3JYUmlCOFFFeWFn?=
 =?utf-8?B?RmJEa0xtdDEzdndNOSt1cG14MmI5LzJoc0ZhUlVwUkdtZzlWS0NEWHlDVDJK?=
 =?utf-8?B?VDFPZEpPNzB3STVFbjBmM1NwKzJxb2EwZ0hBMi9jbjVMaE53N1lEbk9MaU5o?=
 =?utf-8?B?czBnaHRTaFI1MXlRTlpzZ1NRZTV6NGVSVHhFY0tCODdTQkJZdzRReDZ2azdY?=
 =?utf-8?B?ci9Xd2tUS2F4c1daOUMzc1hGMFdYL3h4VCtLaVRrcFBITHNiV3NMRE90WEJP?=
 =?utf-8?B?cVB1ZEZzNHF6NVl4TjVyMzY2SHBabHdlNnlnU2w3bVIvVFVQQUVNYjJzRFF5?=
 =?utf-8?B?Zm9XUmt1RjJleVpyVEZRWGlHWXZ5MFNxSDhlbTlIamtRSlhzT1BTcDNYQmNT?=
 =?utf-8?B?TmNNbzhXUHU1akVUSUZGUm1lbWFrRkhQSm0vRTBkbENGQU0xV21oRE55ZnNs?=
 =?utf-8?B?bmlUQ041OHVNaDBhRVhwVWM2Ukt2bmVxdEQzQ0F0M0hEYXhVZXVDL3k4MlQ4?=
 =?utf-8?B?RlFxbC9sdmsycld0WEovem5yaFNSUE5oMDdSdW5QYWhrdXRlSFpBdzZVbWk2?=
 =?utf-8?B?US8vVmlXdXFQZXNjRis5RXZoL0p1UGxxSmhpdW5VTlBteXluWmR6VzZ6S2tx?=
 =?utf-8?B?cGh5Zi9ReWRJTXVWcm5NU1IwQ1RXdEJlUG52dlpTZW1vTVBQQVpmb1NEbElk?=
 =?utf-8?B?MXhzUTNSZ3Vsb1BZOXZSb0VtR1RLVXhrMjBPa0p3RENPSS9iM210bkRLQjNP?=
 =?utf-8?B?YXdqWnd6eGRIcDAxQTBIRFBuNUJmaHpWOTkyOXBMUWgwTUNkYXlzVDYrWllj?=
 =?utf-8?B?QlJqK3V3R1M3L2NwcytMbk5HNXV4MkxJZHRVZ0dsbUhOSGh0dWJHNHlYVU4x?=
 =?utf-8?B?Mk9XVnVqMU5BRzZxL0FML1k2VjRBMXl4c1prRnNXSTRkblEwZGl2bThLbXBu?=
 =?utf-8?B?dVlTcUxUTkR5ZDBNNnBFUisrTWhTaDlIeGVtM2VWQVlPN0gvazhMc0RPallK?=
 =?utf-8?B?b05nMEFSNXJEZmhYYmhnanoxOGtrUFhFak5HU0NMY0ZTTU9HYWkxb0FiaVk2?=
 =?utf-8?B?NlE5ZW1hc0FNWUlJc0pDcmZHaTlXN2FOQjlJL0ZTUnNrT2NiVEhNbHJuZkd2?=
 =?utf-8?B?YVZESXltcTJHaTdnY01DSlpQSHM3SGx1aFMvZ01NTVVWdnZYMnc1Q05yOVBJ?=
 =?utf-8?B?RGJmL09takpkMFBNU3d0V0MzTU5kRHBVSDhXcVNwUml6dFQybUVyOG4reFhQ?=
 =?utf-8?B?U3Bab2pRK1FDc3oxRlVpSXZVVkdPRmkzZGcwWWpDOXNBRWZjWjZXZUp4NlIw?=
 =?utf-8?B?Mk5RYXRveWpONVRKeVFiM0FZS0hIVDRjV3ZuNDhvZGpBOHdRVlpMOVZEdDRv?=
 =?utf-8?B?NVFLQUovMXFRZG5mYW1wNmdKb2NLY3BqcGEwQlZmdTg3R1c3T0hGQlhnN05t?=
 =?utf-8?B?Z05LNkxVa2R0c25rTHBjWnZrZGx3OG9ybW1jL3V4WTZ2U2ppemlsbEI0djBm?=
 =?utf-8?B?bFhNaFlJUVFHK2JKRkpUcEhxZTVianRWaUN5UERMc2pvSDFISlhGcGFFM1Vq?=
 =?utf-8?Q?N3lSIAd/dulV8IRJdK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kinkUi2jS2cBCl5YwZCEJSOwKVmSl8hrPnuE2/NbuVur1kIgTNy3OAQy1ymEARAWxsDFk7DUhnkrA7Qq15XYX08ZEmap1Tlt4WiL+dndsnTTYPkVQ9dMBwl/bwu/OXc5JKLG7IilNIUA1it1iFiNlZjPx254Siq+un0XdMczswK4KS5hHdkerzopCsw02+H9wm1EZ/WYfF31bJZUAkLQ+y6TnetzeLEZMEHyzTFe+H+ZX4/SFwp6Q1zW8FTFLlECI1k7VnziKC2WY94aEe0/PKLIRaVLhFpfv+9IRbnvuwtI3snYNjl8IdMMKT0HR5+NN6DMiVJZ+UKZn8WBqfQp6A==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08dc468e-00ac-45c7-3add-08df1a2d9434
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 11:18:37.1899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8huLt3pE6NxjsvL9DqIe9Bdnl42cPleNfdNcU1tVqPHs5ozVv7RZn5geBC/hVVtNKUNU36aTJZvB0/QdNXBuJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR18MB459596
X-Proofpoint-GUID: caXxdsfAibGhLpsjhprZfuSKPBF_4AUX
X-Proofpoint-ORIG-GUID: caXxdsfAibGhLpsjhprZfuSKPBF_4AUX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX6zGoZyVakuQA
 Qyelt7pRVixWdyXrq7/3Ve3AGJG76wdMHPZhxccW7gGClxmbAibU+uH5PfIkC2QQYWUlzmHk0gq
 6t21KwvOOMo0hKVqxJqSfF2FgDdaVuU=
X-Authority-Analysis: v=2.4 cv=e8yT2qp/ c=1 sm=1 tr=0 ts=6ab5070f cx=c_pps
 a=glTcUGO0A6QcesvNX5ZrRQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=QyXUC8HyAAAA:8
 a=8rWy6zfcAAAA:8 a=KN1GQHPiQUtAd7Q6UzMA:9 a=QEXdDO2ut3YA:10 a=0lgtpPvCYYIA:10
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX1rhB00nZm3V1
 Jysr34DCwjEOQhfukK39IWCyfRFd2ALVwNOyhChXVWTdQWEY1Kb0W+ajX7MxTph4oqqtnBMixKO
 hOJYz/UegSfO3oA1T60nypOYWhrcPKVzKzGvVK0BJv1SiSj7jH28l0MmTR41HKI9norxBHjkMjD
 lhbpudqu5BTDA6yr2zzkrKKz4T0ECKa2+2TUKt0vsmV7uDLckJ/4fMq0YKOHNCfXuPip9b8WBSH
 a1Q0FzVVpADWG6fitN2EaTa7yMljTmw/SDT/uTXemEpl0xNuel1zRMMKfzp66pSPkm9acb4FMey
 mJvqx0VCbgdzFoOmxci+rihqjs4lb/BgFe/8CjXVyOINc+t/UTaabhCKaKMJsHPl+SiNGzLhYnF
 mMYL68/5XdVK0O/PkYKotmAsBDt49UXxnOm0QhzaZO6+x7GHuclF4V59F8JnpMVGpZwmtM5jkLK
 kY0O0q2NvVGmpIl+fvw==
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

PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogTmljb2xhdSwgUmFkdSA8
cmFkdS5uaWNvbGF1QGludGVsLmNvbT4NCj4gPiBTZW50OiBNb25kYXksIEF1Z3VzdCAxNywgMjAy
NiAxMDozOSBBTQ0KPiA+IFRvOiBkZXZAZHBkay5vcmcNCj4gPiBDYzogTmljb2xhdSwgUmFkdSA8
cmFkdS5uaWNvbGF1QGludGVsLmNvbT47IEppLCBLYWkgPGthaS5qaUBpbnRlbC5jb20+OyBEZQ0K
PiA+IExhcmEgR3VhcmNoLCBQYWJsbyA8cGFibG8uZGUubGFyYS5ndWFyY2hAaW50ZWwuY29tPg0K
PiA+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gY3J5cHRvL2lwc2VjX21iOiByZXF1aXJlIG1pbmltdW0g
dmVyc2lvbiAyLjAgZm9yIElQc2VjDQo+ID4gTUINCj4gPg0KPiA+IEluY3JlYXNlIHRoZSBtaW5p
bXVtIHJlcXVpcmVkIElQc2VjIE1CIGxpYnJhcnkgdmVyc2lvbiB0byAyLjAgQXMgYQ0KPiA+IGNv
bnNlcXVlbmNlLCBjbGVhbiB1cCB0aGUgYWVzbmlfbWIgUE1EIGNvZGUuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBSYWR1IE5pY29sYXUgPHJhZHUubmljb2xhdUBpbnRlbC5jb20+DQo+IA0KPiBB
Y2tlZC1ieTogUGFibG8gZGUgTGFyYSA8cGFibG8uZGUubGFyYS5ndWFyY2hAaW50ZWwuY29tPg0K
DQpBcHBsaWVkIHRvIGRwZGstbmV4dC1jcnlwdG8NClRoYW5rcy4NCg==
