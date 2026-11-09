Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57349606A32A
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=jIEl9eGh
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AEEE40ECF;
	Mon,  9 Nov 2026 20:43:45 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTPS id B8C3540E35
 for <dev@dpdk.org>; Mon,  9 Nov 2026 20:43:42 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HXi631270353; Mon, 9 Nov 2026 11:43:41 -0800
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021104.outbound.protection.outlook.com [52.101.57.104])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hujp6rhew-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 11:43:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e60nx7/0yYpePbkG13VJipYVolTfbe2UeGzq3EF3Kw71hORV+d8vP3otfIYAFqpDzF1sICT0KWy4D0e2LEuqk5kj5lYjM4M3mSG/r+G5XiZ+tce0oshmDR9VEzbz9McZniw30ajzxcHS2l8JeEfALxqugWrpvf3r7I31DJbDOxs5ZsPwD61chGko2tZ54x2M/mxe/6GfBKIUt84hfb3WWa4/XGjwSF1ingpEFE6wtQQDNai1q0UJZrWQiIgBtDLMS2NDkCPsDKzmib8G3zF8L63PhwHq1Lz/GuB6NYJmYdey5KIcqOAPMG/IMEzy1c/G7GGFCrhQGwpQZFkZgDQ6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ec73JcMYCJ+BbC8Un8bVrtz8FsbIaDzOUiHNOR2+F3s=;
 b=pNP/+cYeRuKQwZOD+pQJnXfxtuTbrPSDNV2ErPxu26o76LR2n8Zx7VxuoYTSx51wHwR604kK/50QkIhqApYTmWnmpBDHk4mwUpNvYiNoxQ841XYMNq4cKBfIkQZ6zCEG7csAnGY+SPuuulbrxJsvZ+LMveaEbvbkwfU2fnJrQ1FvgCL5BYh/G5YofkEOMi6gLQi1SVbcDUzBKqRWUC/7kFZPJjLzyzykirTs1oEQCkjC+7Tqwgs7dpAp2XaRGNIW92ntVlh/u5n3DFTneO0Jwm1NivHLYYmHrGh+d4OUaruqK+00pDAZlem95PU91CPAfckdBGGX4Vq+Ii1CKf2zsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ec73JcMYCJ+BbC8Un8bVrtz8FsbIaDzOUiHNOR2+F3s=;
 b=jIEl9eGhYSO7aBlmPBCWqtF5pNSTSZPuN7PFEMHMSyOCbE3hDZL6lbb6I09q0Se4LymJEUDyy44a4vEJeBdKgjWxaKkiIdT7ZFrtSbVIUikpjDD6SmVi2dv1sjBvz/PvCpp0GdF1dP7TfG+nR8Nrz1sXaqwd76qxKzvYKFnegbQ=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH3PPF9936212C8.namprd18.prod.outlook.com (2603:10b6:518:1::cb7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 19:43:32 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 19:43:32 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "marcel.d.cornu@intel.com" <marcel.d.cornu@intel.com>, Kai Ji
 <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: RE: [EXTERNAL] [PATCH v5 1/4] crypto/ipsec_mb: add support for
 IPsecMB 3.0
Thread-Topic: [EXTERNAL] [PATCH v5 1/4] crypto/ipsec_mb: add support for
 IPsecMB 3.0
Thread-Index: AQHdXLCP11DOSUatN0WdJncC9S+6TbcmSxgg
Date: Mon, 9 Nov 2026 19:43:32 +0000
Message-ID: <CO6PR18MB44842A0D635DD6C165CD0ECFD8732@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20261015141426.2275568-1-radu.nicolau@intel.com>
 <20261015141426.2275568-2-radu.nicolau@intel.com>
In-Reply-To: <20261015141426.2275568-2-radu.nicolau@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH3PPF9936212C8:EE_
x-ms-office365-filtering-correlation-id: 34c4d6da-982b-47b1-2435-08df3e99bc77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|11063799006|261021135927099003|56012099006|261022105027099003|261022075727099003|261026140227099003|261028144727099003|4143699003|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: HBW7T7+j9R5OJ7TcdZGcoVYLp/uyYQA1Vjvp7O0a+y+O9cAeo0VxWX38PuRvRaEbBw2nkg5rUYbbviwd/Tz1moFrVediy1QmKOILj4k03aqj5iwtYFG8QUxPVUPh12NFkQOTggWiXdjRQIplJpt7T4m9OnXypS8bb744eZAc0gjyZATP22QrvQH9A1oR645na+YI2rGgd7qTUidXScuBbeetqNql/XW0wMJ/jplqRS/tQu2qvtlARm37e5jr82WeV5hWXOESvfiq1UmrOX64WBQD2WXQ98ThgM+00HtJr7TscCldeGXLbd3/qJPEAV4tsLShiGTTuhsBQwxAldEf1txb8XFdiJS2/g2gWjIAbpM3bNnpP/o9XeSY/0dojW99dnpyMImWDEH8a4NPqXsvwwQP2mLd7KEUBvCjzeqMVMcdJGVjLrLg/lNqwt6SqLQDg6Yd30Bo5L/oQwswxQAosdjV6CTsehlmhp+XlwqiHWir9m7xFVGxMsjovy2iP3XPPoKrtzXQpfK7wKyiNjd+JFgP88Y+Ai6Gx2RZcoKqRtQdAjnBlElf6c8X2ovcRUqRMhL1gxhCRHYS9UCQrQ8g4VgplKT0Jc31ssgMVpMHi0f8Jpv0Fd2h999hGPcOnpYeWaZxtuQSw0HWRI8j0hsvLtj1zhoteUxdtbAbU2RnSS2nNOklLI3O8mgZIriAlYGMKmH/3BhK0GnPiJ7DacQV12nV6cEEFrprU9g4N/rYn6s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(11063799006)(261021135927099003)(56012099006)(261022105027099003)(261022075727099003)(261026140227099003)(261028144727099003)(4143699003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkRYbmNVVXFMaDVkMW9lUEw1bE0zaHBxWEJFZG9PZHQ0UmNSTHUzeG05QmNu?=
 =?utf-8?B?eGtFSEJqVGJhSHRnQXUyekNENTJBem5TUUxYQkdaK0dEaDZCNzFtRXdSSDVs?=
 =?utf-8?B?RURqLzJQQ0hmaEM5cXlPck1HM3lWTDFpdUE3aGRzcjRtWW9rN0M1UTlkZXFM?=
 =?utf-8?B?RE5ld2NWSGdzUGEyMXV0bjFlczBhdUZBNTNicXBKam1pL0paVWFUcnRyVjMr?=
 =?utf-8?B?L1JNWDBZTzkyaWhGMzVCSWF6TWZoMmdWRWU3ZmtuZ2paQ0dkWUxWZkJjOFpC?=
 =?utf-8?B?Ky9FWHh1M0ZFVGwxeTA2YnFTV3BoVlJzeUtRVUdtQlF5RHdPc3lYQmNpK1Qv?=
 =?utf-8?B?UHVJUkNFdi93SVRRMWhiRHpmcFB4OTFzRjZ2eEtaTTkvV3R4dzZxbU5jTGJI?=
 =?utf-8?B?M0N6MWQwcVNqSm4zUzRvYVgrUklXYlFIbjQvNDBxNzUweHN5Y0dQNERRQ1lq?=
 =?utf-8?B?cjVEVDMrMVQrOWo5cFVocHNnL1c1djFia1lid05ZSkhJaDdpSUVwWDhDODUw?=
 =?utf-8?B?ekRpMWpJZk9VcTQvcHZqSzNyWXBzTnpsbUsrNlh6VytYUkQ4cnlueCtaenB2?=
 =?utf-8?B?NjFoUWM2MFNqdG1SVEF4MWhyRWNMVzc1cWJ3eUVVd2VKeXlxY1F0YWt3UjJF?=
 =?utf-8?B?eVQyUWtyRjBIUkN3S3VmdWh1bk03RU5wUUdQMTNTOFRQdUtGNWRZYXRBMS91?=
 =?utf-8?B?OWY2RWVLb3YxLzZGZllJbHRtV1VxaHFCZVFIQnRKZnNKOWNCdjdpWEV2K2RJ?=
 =?utf-8?B?elUrR2czbTdmeG1zQWl3YjBJMm9HeVlPNHJHbjM1dUhKYnN2cHVGT2M1bWJV?=
 =?utf-8?B?aXRLZTlwallmbnd2V3ByQktSVXc0RWNrYklNRkRxSHVSbDErMUN3WnNBRHRR?=
 =?utf-8?B?VHVGRVZ3NVVIVGlrbkZFdFJzc3FibmwrbTJiMXJMckU0QTZPUDYrU09zRThB?=
 =?utf-8?B?R3hzVURQUHJTNUZYbXJwVTNQdW9IeEpJK21JdFQ0Zm56YmZoUzN0WDd1dnR4?=
 =?utf-8?B?a1I4aTlOOU9ZbVEyQVZ5VGRwNmJtcjF1VCtOL0hKeGNvempFTlVjbHNXNUZV?=
 =?utf-8?B?bGd5MFN0bHhsVTRiOUZqVFdKR21NUzRRU2tEaFp3Mk5mdkMxajgzZ0JjL0JD?=
 =?utf-8?B?VmNHMEI5QTJSa0QwalV5L0xjR1k1N05zbS9wQk03Nk15dWpvcmRrb2FBdEdw?=
 =?utf-8?B?azRFLy8wZ05vNFFLQWZQU1lwU2dVakJ1bUhvWXh2aldXMWxhYmU0YUNFTGxy?=
 =?utf-8?B?aFBLRUZsZkVnYUNKWGRaR2RqbW1BYk9HY0NQamcxcTg4VHlNMTNXLzdHRkw2?=
 =?utf-8?B?MlhmYS8rUnFhYVd6NWJvMmd0dEtvY1ZZd2xwbjhBNlBiN1lQcURlbS9TY05m?=
 =?utf-8?B?RFdoWlhyL2MyWitEU2ZucEhrclFwTmRmOXNHd2pSZHRlSzVFMVpOS0hUM0Rj?=
 =?utf-8?B?N1NJV3RXZ044c2F3bjdpVXJnZGJNNDd6a0dCeXBqVnBRc3ZwL281UmRuTjRY?=
 =?utf-8?B?QVdnRXJiaGhVRDdVRDNYSy9FOUtYL0M0Q09pTlZyOFp6WXZjakpDYTkzOG9x?=
 =?utf-8?B?b1pLTU9GaGk5WkZONlVKZVdzMSthZnA0UVdSYXRxU3pyZzFEcERvRXc5WjR5?=
 =?utf-8?B?Z3VUQVZGR2pnSVhDWDRrUWpWUWFZQlpSTlpzZTNmNHhUa0NFVk0zWTBSU0Vk?=
 =?utf-8?B?bkdLenI2aElFWDQrdzVjZ0p1clNTSEF4aFNBTlFtMHFkdHBjZGQ5dld0SjdH?=
 =?utf-8?B?WWJtS3o0UnAybjdvTlhNallFbWdtanVpUk03bjFDUmZGQ1lZalVHdDd3T2My?=
 =?utf-8?B?clNuR29OU3gxcEpIaE5iYzcxYVpuYVJLdDY1a1RBWjZZZ0pSMExVTm1PV1ZY?=
 =?utf-8?B?M0ZuTEtJbnhndTNTZktXMEgyZ3JRdHI1SFRnR3UySUk2Vm1UN0IxZ29CWmt6?=
 =?utf-8?B?bWJGRlYySVFlUytHczFmQkdNdkFFUUJVcFVtTzJoT1VrK1pTamJueVNqUjdL?=
 =?utf-8?B?Wng0dytGSyt5UHlDc3RoenZXblhvdW9aMGl4dWRuV3lvVDIxZDMxMUUvUWd6?=
 =?utf-8?B?VUszU2tIaWNaeTEzeDViNm5SUGN3d29lc3J4VC9KSC9MNE84aVF2UjdpSy9Q?=
 =?utf-8?B?MURPU1ZxWUJ6dUhFRFdldHU0V1ovNWt3cEcvQnhPUXRNM2x4OFcybEkyM0ZQ?=
 =?utf-8?B?eGJ2MmpLZm9hNi9FeE5DblduWkpJbW5ibUZSbFlYR1JCRTNKRXQ2ZVFEdGlo?=
 =?utf-8?B?MVdlaU5kNHRmV0FiN1UrYzhzZkh2TWo5Z3o0L2tPNURvNUNEelFEblNDbkhs?=
 =?utf-8?Q?yKW2KI6YNi6VL94fLP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZRWEZrpk6Mb9/tesW1HgWZInyC57b+p/x2IxdzDlwZSHi4VlYUxWe1wWdwnllZXIuVBf05ZrrvFcffgFrl98qPANFG2pqcGAyIDBuJKUIGOE0GBFYtZGX1q+QHyqSda0mgFf+lWgqtoCxSd9UNNEBrdsR0+2qUOG6wUhM0M5i4+oj9Ow63qSASrkVy+81JSO27wsQV44cs1WvhwKfvVTQb+WFTRSeURBN4x3yT7zPF2BZTXlZ0blkrcAQQVaTe4LVlypTfZf6QyqfpKGPTBjaCnaHQtuL7I48ml1B0//q/WCsruzGxmAIBS+JH9zvRyrgUgK5UbrOzhHR+OMDeGxWQ==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c4d6da-982b-47b1-2435-08df3e99bc77
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 19:43:32.2253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sQEWKBC4hGrrnH9/6QYMq02xcrUxOy4a2rM2/iKYYAFixkgNB35bbNKDcOQNa5Sbb3FZyIg/BbEmYUYpmZtnwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF9936212C8
X-Authority-Analysis: v=2.4 cv=d85gWhjE c=1 sm=1 tr=0 ts=6af2226c cx=c_pps
 a=qAO2aVrDdLyRlaU/jZBZ7Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=QyXUC8HyAAAA:8
 a=Vjazs9KMiTO-OikrR3sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8uM1ZbS9MHFh33bw1yZ8l1GmKHlfdPQc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfX+q1yDYkxrfsc
 DExYPZ+dgPwZHmdVFzmOLzJM9vp3jpJAjChX8jjUVCzb8Lk9XIR3Td1NSL9gCWum51FYL7mbco6
 SmHtWH0JtLT2BjOKVpLWRet/F7iKBZA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfXzP3ioWhCFZ3i
 tDMyWhoEj64noLDJM3byNc2mi9WBxHekfMZTzHTbDsJymayeKUpdHtJhljZXBX+GouqUkwTUK1s
 kpygrzDvd/Cq1wM1agICDynttwAepo6hCqqgoVXsESkgx8JE4G4xKmN8IGUabplE81D3icguFfW
 X+NXo9EdbA1i8Z7kZBfzI/pi0FHT0UPHd0JHr1u7zsHAmFK/0GtiVy3hgA5Li6eSdgmyHWWfDxS
 DU4NmBciok7JWIawns4gHSxUD9Qbuqd9xWqFebOZlnGz2YlkIsY8zM6hjlZ9ndcxE7uTCSZqloE
 bS98rxib/f10k0ZEj4fRiITM6Oxya1PS3Et2yOIUZlOSyRMSoyDH4ix/iUkwJZAvaEeHrYGmDWP
 EIKSNfiJeXe0Z1qeuH/diLgJIIDRTtZ4vjqq0dQwkbLZO63H5vXPp4yEbf0TNra/jNgjsPTJPhT
 Ay0VusgXsVc6YxBwy+w==
X-Proofpoint-GUID: 8uM1ZbS9MHFh33bw1yZ8l1GmKHlfdPQc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBBZGQgc3VwcG9ydCBmb3IgSVBzZWNNQiByZWxlYXNlIDMuMA0KPiAgLSByZW1vdmVkIGFsbCBf
QklUTEVOIGVudW1zLCBhbGwgbGVuZ3RocyBhcmUgaW4gYnl0ZXMNCj4gIC0gcmVtb3ZlZCBmZWF0
dXJlIGZsYWcNCj4gIC0gdXNlIG5vbiBjb25zdCBJTUJfTUdSDQo+ICAtIHVzZSBJTUIgQVBJIGlu
c3RlYWQgb2YgZnVuY3Rpb24gcG9pbnRlcnMgaW4gdGhlIEdDTSBQTUQNCj4gIC0gcmVtb3ZlIFpV
QyAyNTYgc3VwcG9ydA0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFkdSBOaWNvbGF1IDxyYWR1Lm5p
Y29sYXVAaW50ZWwuY29tPg0KPiBBY2tlZC1ieTogS2FpIEppIDxrYWkuamlAaW50ZWwuY29tPg0K
DQoNClBsZWFzZSByZWJhc2UgdGhlIHNlcmllcy4gSXQgY29uZmxpY3RzIHdpdGggRW1tYSdzIHBh
dGNoZXMuDQpBbHNvIGZpeCB3aGl0ZSBzcGFjZSBpc3N1ZXMgaW4gMi80IHBhdGNoLg0KCWlmIChj
aXBoZXJfbW9kZSA9PSBJTUJfQ0lQSEVSX1pVQ19FRUEzIHx8DQogCQljaXBoZXJfbW9kZSA9PSBJ
TUJfQ0lQSEVSX1NOT1czR19VRUEyIHx8DQotCQljaXBoZXJfbW9kZSA9PSBJTUJfQ0lQSEVSX0tB
U1VNSV9VRUExKQ0KKwkJY2lwaGVyX21vZGUgPT0gSU1CX0NJUEhFUl9LQVNVTUlfVUVBMSB8fA0K
KwkJY2lwaGVyX21vZGUgPT0gSU1CX0NJUEhFUl9TTk9XNUdfTkVBNCB8fA0KKyAgICAJY2lwaGVy
X21vZGUgPT0gSU1CX0NJUEhFUl9BRVNfTkVBNSB8fA0KKyAgICAJY2lwaGVyX21vZGUgPT0gSU1C
X0NJUEhFUl9aVUNfTkVBNikNCiAJCW1fb2Zmc2V0ID4+PSAzOw0KICNlbmRpZg0KDQoNCg0KDQo=
