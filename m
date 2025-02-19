Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94666C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 10:56:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4D4B4028B;
	Wed, 19 Feb 2025 11:56:11 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 873CF4025A
 for <dev@dpdk.org>; Wed, 19 Feb 2025 11:56:10 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IJZfI1005913;
 Wed, 19 Feb 2025 02:56:09 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44vyyuhqgb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 02:56:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/n0hTBQzUxB/AVViTdkcKGg13u8CU4ADLUYXjIVEgS7QWfC9UZ06n8cUdXwW4is2OrylxtnEaD6okaCzYyGpN7gRhkXSHVj+ySyyZ/TL2AJg3qAI+VDp/okpXWZEuQICp6t4HxC99S6I6i7SNuyrzMt9VOUGSX6pJzFvklJFKFPsaiaEy8/mqFBHnpO8WT9Z1PUhePXHeDp7IpnFJsHwwoy0VSNX7Uz9g4p2brVMlmWKNRtEYeUEB6jFN+S6XU4wMqg3152PweyiuyIVXHV7+Xv6u3FCeNCAE9q9uE5vuGz1HPoaGuvTjXG2+6rFnyh01jF2u5xiH9VEjiYBEAkfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13hyuIyHrQGY0tUtO+TCH0vqOGvSKaxICPeqHoIkOPo=;
 b=sjL/lVUFQAhJNcKAaEvzKoyB3YQUJ+0gY3nZdVnauOlSvH4UtAWcQJmmR75iV7tZNaLlXAgpt3rYN/a3KW4PTe8q5F8Fq8NLZwNDKNaqmL1IQX7O+TLG+pRC467K/Q27mIVItBvtIEakBx2NzezGqIsEGQ/PI5jfnyAyf92Lj2nU9L7tsQM9LDLshWujMhNVYEpsPnjz+XYTE+NSKN9P8OnQpw36fZReIeT1r9QPCMCC1Dvq3ey69nbWCsAwNPoEdLiyN8ouI/OCjzmZglXpeBMMzK97y0+CNaqiB7wQWLBvG+KgeEeFw3tRNF578F4owavy++GeTh/Fmk3OSyc2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13hyuIyHrQGY0tUtO+TCH0vqOGvSKaxICPeqHoIkOPo=;
 b=v5Oqe6+1aOqfwomRWqLlAAbioru41oy3XtmVTm5M0h6kAZXoNu8oGqYKzbgz0djE4aQp+n64nVEhS55OQaCC9K7xzyCwMi3q70GuL2u+mcX2AGKSrTS7l2CmcBQKjKwKQJNUgIkE6MwpZG2jINeUf8PyisTNsbRT+WJV+ulNzjg=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM8PR18MB4453.namprd18.prod.outlook.com (2603:10b6:8:34::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.18; Wed, 19 Feb 2025 10:50:53 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 10:50:52 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
CC: David Marchand <david.marchand@redhat.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, Reshma Pattan
 <reshma.pattan@intel.com>, Stephen Hemminger <stephen@networkplumber.org>,
 Sunil Kumar Kori <skori@marvell.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>, Brian Dooley <brian.dooley@intel.com>, Vladimir
 Medvedkin <vladimir.medvedkin@intel.com>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>
Subject: RE: [EXTERNAL] Re: [PATCH v6 7/8] app: reduce app dependencies
Thread-Topic: [EXTERNAL] Re: [PATCH v6 7/8] app: reduce app dependencies
Thread-Index: AQHbgqUIJtqemb75i0OJSSs1KGJaRrNORacggAAicUCAAAK4gIAABPiA
Date: Wed, 19 Feb 2025 10:50:52 +0000
Message-ID: <CO6PR18MB44841FB45C9C2C91847757A8D8C52@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <cover.1725462264.git.anatoly.burakov@intel.com>
 <cover.1739877265.git.anatoly.burakov@intel.com>
 <4fef69922f2220f57ea32cb4a31e015622590237.1739877266.git.anatoly.burakov@intel.com>
 <CAJFAV8xGGW9bTvBXKA9Q90etQv97sW29hVC=ptkGPY2EUVMEJw@mail.gmail.com>
 <CO6PR18MB44846826FEEA15C90FCFA837D8C52@CO6PR18MB4484.namprd18.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FA4E@smartserver.smartshare.dk>
 <Z7Wwr-o416zQ3CSa@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z7Wwr-o416zQ3CSa@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM8PR18MB4453:EE_
x-ms-office365-filtering-correlation-id: 70e43308-e396-4f1a-c256-08dd50d347bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?bWk0aHNEcWRFSjVxKytLeFJEUk5CZVZ3MzB0ZnNuR1d5ZFZIZDVUanU3U0NC?=
 =?utf-8?B?Rk1qOWVFTC80aFRmS3Z3ZE5tRXcydmI4cjFwcnFjbllYdGVldDh6aWFwSnVV?=
 =?utf-8?B?WXcrcnNrRmNJSTJqZGltbWFjNm1TUXZMUGZCdjBtaHpodHVST0E1L1dDbkhH?=
 =?utf-8?B?YjhVRWg0Nm1SdEgyVmZSdytENzUybG9VdlM3TWxqVFlqbTYzaWFLMGFIcVI5?=
 =?utf-8?B?SXoxbmxHME5TNkJ5UDU4WTR2Wm5nQTErRFZBbWE0Y0c4aW1pc1pRWDBRRUUw?=
 =?utf-8?B?UjNZT1k1Qm9PVEhueWdoWVVIK3haSk4vZVVwemM0Vk9LRWNNWXZJa1dLTDVY?=
 =?utf-8?B?Z0lISEtYVDYrdEhnbFJXNUVzV2pQdGxHNEJYMElKMTA2dW5ZRGhXRmthQ0hD?=
 =?utf-8?B?NVZTUTVjdkZ5cTVrV2ZHVk15Yis3UGtCNitHNGNKdmk0TlF3V1RDNERMUktY?=
 =?utf-8?B?YW5zVG1pMk5McmRNbkxlc01senRhVGVoVnRoaUxnekNuaDFoRzlLMDF3Q2dM?=
 =?utf-8?B?bGNERVRGNStuMzN4OU53cklmRlhPVlcrSEpuWjhtMVVIeXhkZkovbitmR3lj?=
 =?utf-8?B?WjN2T3VoRGY1ZGdFTlhMK0cvT0lnZDAyK2VGUnZSOE0vd2R2dmZrVDgwc3p5?=
 =?utf-8?B?MmxyUzlYbStMOFhIcmVPYnFFRzlYK09tUUc5MlFhNnRKQnc5Y1Nja2NuY0dz?=
 =?utf-8?B?TERuWGdzMThwT0hsc3RmZW5DTEZFYS9wOWN3UmxzdzYvZXRHMWZKWkJWRlVp?=
 =?utf-8?B?TkxjVHVMSzljZUZ1elk1MWdIdUlvYi9IUDNHcTVNK3pwNGNMcCtvaDQzY2xP?=
 =?utf-8?B?NUFCcUNkaVZiUURRcDZ1NXM1UmVTTnI3ZjdWbGMyUHBqNWlqM3lyWWZzWHkw?=
 =?utf-8?B?cGtLcHhsSjB3QkhNZ2JYLzZvSFZQeW1lelFNRkphY3MzWVA0ajUvd2VINVB5?=
 =?utf-8?B?UjRzNHhqbWt4cElxNGVwS3loNVBDc3ZVYk9MbUJrb0JlOWdvc3k0dDNmUVdC?=
 =?utf-8?B?SURYY2oyU04vaFlPQzRsbVlyUlcxbUh1dlREZWY1RXl5UnZRZWpkSUtoZk5u?=
 =?utf-8?B?anVhV1d4R25DV0pOMXBiQ29oMFdSSzEvcmJmVjF4eUdSQUdMbTZ1NWhnVFZ2?=
 =?utf-8?B?ZUM4VlNHQ3k5c2IxRUh6aWdlNWI1VkpoZTByeFR2MWY5VnhrV2FzTW5UKzRY?=
 =?utf-8?B?bG5GNStkQXhHUDF4K210c1loNmxhK3NWaDkvZ1c4aUQ4TmxwWFovcjQ1THdS?=
 =?utf-8?B?djBCSmdQZ252cFJDak1nU21aam43QlB2c2tURVU4cUUzWGE5VWExNWtCaHk1?=
 =?utf-8?B?UGNyY3l3M2VJN2lHNW9MN0xDZUpHeEYyZTRJSDYvUDltbkxLaVNkc3owNGJl?=
 =?utf-8?B?Nm9tOXJtTEhnRWUveTVqY1N0ZmZHTHA2ejBNMUsySUNScFNzci93Tmt2a1ll?=
 =?utf-8?B?a1RDckJaT1RmblA1RkFKWWlmc2Nyc0FXOEpJeWlCRElDMXY3R0VwSmFYMnVB?=
 =?utf-8?B?Y3dBMUVoZjFmdVU4anZyWFpsQi81VFY2cVg0SXA5ak1TVFpXTENRbVNsTW1n?=
 =?utf-8?B?eUgvc2FjNEJNQ0tnY1U2ZFI3TUxzellqZHdodVVkWmxsYlNwSFZhNXBUdzRx?=
 =?utf-8?B?aDUyNWFldEJjMTY5NVFwYm55K1FVWGJwN3BOWjFDaXFRaWJiVzBXTW1MOUJk?=
 =?utf-8?B?ZVVmQXZWWHlxRlErK0dUbi9uQlNVcVRGLzVnaTMzeWJSbWlXQmhGSjQ4em9Y?=
 =?utf-8?B?QVVCdlZMK2pqZ053b1ljZVZpOXpuT0Ywam80eXZVSnVGYmdjcWFwbzd1UHhY?=
 =?utf-8?B?d3BDQTIzcmptdE54YVVJOFhOcWIzQnR2T2NINS9PREtqUEtRWmJSSXR4SVRG?=
 =?utf-8?B?Y1YvMkFuRVdRNGJzRmpBT2JzSW9SS1hNRC9WN1F6ZkFvd1R2OVhhVkN3MWFy?=
 =?utf-8?Q?Ts2Eh3Qn2c3uXsEzCISQLbcpmULtWKhe?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3d4REozcWY1bnBLSTI1OWMwVHM2TlNBY3RFMWtqc0MxWURuWlBFUm1QWU91?=
 =?utf-8?B?M3pyVzMzb3d5SlJTdnV4RlhNSG40eUxndldGczREdWY3THIxNkorb2k1Z1N0?=
 =?utf-8?B?YUlUOG4yNUN0NmVJblNMSHFJWFJsanRHRWkxMEt5bFhpQVZaRjdqbEtoMlAw?=
 =?utf-8?B?MmpIU1grQ0pLRTJSN25WK1NidU9JSURCVUZKamhRYVpQVm1pT1ZaMnVUdmhy?=
 =?utf-8?B?UXVvRVJWSlZlMG92MzB2YUVwZkJvVGljNEttRHlNd1RjWG9za1VWVWJ3M0Zj?=
 =?utf-8?B?blNTeXpOL05UWTk4cWRVYlRMOEVWUXpiMnU2U1JHcm5Qb08rUmRxT0c2eFlk?=
 =?utf-8?B?SjF5Z2lEODhjV1ZmdHNNeU5kQTJDcVFGSDN4WWxVdkl3aVZFR3FWZUF5OWVV?=
 =?utf-8?B?Q3RWNm9RNkpkMm1tSXZBTXFzdWk1aGlPSXJRU2FNYUdiRWo3dmdUNWpra0Uy?=
 =?utf-8?B?WWFISWoxN3dVK1BHZjlkM3lqVDh3QlFpZ3JOblltZUl5UXk0cUZWcHV3NG5i?=
 =?utf-8?B?ZkhOMk1EbHJOazAvZkRFZzJlUWVOOUxYeElGZU02RDJReEc3TXplV25yOHpT?=
 =?utf-8?B?cEw2T251V1JRM1FaN2ZNaU9YV3RWcFkyVHlKVmlMclNjZjh5UUFVbHdpQlI3?=
 =?utf-8?B?aGxTQzVUa3EzK2F2bTFDZi9ucTVlYzVnZkZ4aDhQeERnaHRiM3NKRUtIdENs?=
 =?utf-8?B?NWU0aXNXN0kxWjQ1bGNheVFPbGpCQWRqTk0xaDB5QU1tSTFKbEFpbWx1RVlE?=
 =?utf-8?B?c2RVVk1UVHowcC8xdEsyYjFoOENrTkkxWGtNZ084Z1YxbE9NRmxwZmhZZ3RF?=
 =?utf-8?B?VHBmVGFoSkMrL08vczJRUTFnWjlCTkpxcUkxUzVpVzVac3czK3NrR0tLTGxq?=
 =?utf-8?B?ckVQbFptL2dvV2NTL1hjMzNpNEMycUR3bWFnUnlLVU10WjNGaGtVWDAxU0NV?=
 =?utf-8?B?S1R6Q3l4eDJ3amZCSnBNdUVsdk1NR1o3djVnMHprM09tTi9VRksvTXhpTVND?=
 =?utf-8?B?dVNNUElZM2NMVE9McW51Z1JzUFJJdWUwb1RpS2dZYjNuOTRtV3lWQ0hUQUY3?=
 =?utf-8?B?Tk1nRmREV3RraGxzdXJWRG5adHJPVS9VaUxBdHhHV2hxbDdZZkZaUy81QVM0?=
 =?utf-8?B?UHZKUGFxaDk4ZHM0VCtyQk1vN1BuTW1STzAvQmlRSHRqdkN5SXRjUXJuU2w3?=
 =?utf-8?B?eWhCWkpxblp5Q2kxTGJUU2p1dW5nWVBQNWNyaURJYnArTXlSdlNJdTJrRmVv?=
 =?utf-8?B?NmNhTjJiaFR2TjRPdVVSSjRydldXRVVBdDZLK3dZMkc5bUdzZXZFc0M1NWRG?=
 =?utf-8?B?UFVCcTNTU2x5Q1hjRlZaZjB4SkhENGhTK0dSRldRd0ZHNktVL2R3enR0MGZX?=
 =?utf-8?B?R0V6NnRiRWNYamJXVXY3Ry9nMWo3aHNESkJsMjJBbjFSY0RMYytoaUx5RXhY?=
 =?utf-8?B?UHkzWHBDbXNXWS9jNkNXOG5uTGNwNUxHYTU4TDdGS1dLN3dudlVEcjBqb2J1?=
 =?utf-8?B?QURTTkFrbXZlNkNNeFFoSks1akVhb20rbmRSRGFIMzhUbUN4bjlsZWp4ZlFL?=
 =?utf-8?B?eHB2aTBRZE1rUGxZSG9ORXZ4Y2RaS3RiaTc1NFUzUTNsUmNXbjN4aERSRDNs?=
 =?utf-8?B?RmczWHJ2cGRheS9US25pSER5dFd6b0ZPQTg4bjRQWlB2ajhCamh5blFvSE9a?=
 =?utf-8?B?dDVFNU9pKyszV3lWUEZLYVNTQUJINUREMlo2cEIrT0dacGJkYWxNR2FDcUYw?=
 =?utf-8?B?QjRwZStIamN4QnZJa0ZvNjA2enRMNERUTE1xcTgxQzhRRUV5aXdSMGQ0Y0Y5?=
 =?utf-8?B?d3pCZlc0WWlUR3JXaFJiUmcySmlSYTlaaXhKVy9aS3lHeUw4ekcwNHljZGhy?=
 =?utf-8?B?R2l1U0pWV2hyc3lvTXNrdSs1eFlJWkdLZHpPZzVFN1ZzM0ZJYmdRQlAzSjAv?=
 =?utf-8?B?bzB6dEZnK2psOVR4SlBxMmNLWXNES0tDNDV0cGlGdTdIWHJkc1JPajZ1WUVx?=
 =?utf-8?B?WWVBWXZUOURvZWhDczhjNzh6b2tOUmoxUFVFdVRpbFhiZk1xZ0ZTaW1TMGdw?=
 =?utf-8?B?dk44clVodjdBeHJEbW1VQTlhZDRKVjAvVlRvUnNXMXlPRll4SkhqaGttdEZF?=
 =?utf-8?Q?WHL8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e43308-e396-4f1a-c256-08dd50d347bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 10:50:52.7894 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +rLhr7lAypmlt1Shfr8MSAXPkZCk9xuEXrp4WUCpTlZuvbAvjIRmtsa7TPzJh8gm7Jgi06HFEtR5B4vOlzJrIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4453
X-Proofpoint-GUID: NfiLGDY-AnvJPeD9Tsx34VvCK4tF5IkI
X-Proofpoint-ORIG-GUID: NfiLGDY-AnvJPeD9Tsx34VvCK4tF5IkI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_04,2025-02-19_01,2024-11-22_01
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

PiBPbiBXZWQsIEZlYiAxOSwgMjAyNSBhdCAxMToxODo0NkFNICswMTAwLCBNb3J0ZW4gQnLDuHJ1
cCB3cm90ZToNCj4gPiA+IEZyb206IEFraGlsIEdveWFsIFttYWlsdG86Z2FraGlsQG1hcnZlbGwu
Y29tXQ0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCAxOSBGZWJydWFyeSAyMDI1IDA5LjE2DQo+ID4g
Pg0KPiA+ID4gSGkgRGF2aWQsDQo+ID4gPiA+IEhlbGxvLA0KPiA+ID4gPg0KPiA+ID4gPiBDYzog
QWtoaWwuDQo+ID4gPiA+DQo+ID4gPiA+IE9uIFR1ZSwgRmViIDE4LCAyMDI1IGF0IDEyOjE24oCv
UE0gQW5hdG9seSBCdXJha292DQo+ID4gPiA+IDxhbmF0b2x5LmJ1cmFrb3ZAaW50ZWwuY29tPiB3
cm90ZToNCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvYXBwL3Rlc3QtY3J5cHRvLXBlcmYvbWVzb24u
YnVpbGQgYi9hcHAvdGVzdC1jcnlwdG8tDQo+ID4gPiA+IHBlcmYvbWVzb24uYnVpbGQNCj4gPiA+
ID4gPiBpbmRleCBmYjQ4ZDllYzI5Li5mMDU2NDMxYmY0IDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBh
L2FwcC90ZXN0LWNyeXB0by1wZXJmL21lc29uLmJ1aWxkDQo+ID4gPiA+ID4gKysrIGIvYXBwL3Rl
c3QtY3J5cHRvLXBlcmYvbWVzb24uYnVpbGQNCj4gPiA+ID4gPiBAQCAtMTksNyArMTksNyBAQCBz
b3VyY2VzID0gZmlsZXMoDQo+ID4gPiA+ID4gICAgICAgICAgJ2NwZXJmX3Rlc3RfdmVyaWZ5LmMn
LA0KPiA+ID4gPiA+ICAgICAgICAgICdtYWluLmMnLA0KPiA+ID4gPiA+ICApDQo+ID4gPiA+ID4g
LWRlcHMgKz0gWydjcnlwdG9kZXYnLCAnbmV0JywgJ3NlY3VyaXR5J10NCj4gPiA+ID4gPiArZGVw
cyArPSBbJ2NyeXB0b2RldiddDQo+ID4gPiA+ID4gIG9wdGlvbmFsX2RlcHMgKz0gJ2NyeXB0b19z
Y2hlZHVsZXInDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAgY2ZsYWdzICs9IG5vX3d2bGFfY2ZsYWcN
Cj4gPiA+ID4NCj4gPiA+ID4gLSBUaGlzIGFwcCBkb2VzIHNlZW0gdG8gcmVseSBvbiBsaWIvbmV0
Lg0KPiA+ID4gPg0KPiA+ID4gPiBbOTg5LzEyNjZdIENvbXBpbGluZyBDIG9iamVjdA0KPiA+ID4g
PiBhcHAvZHBkay10ZXN0LWNyeXB0by1wZXJmLnAvdGVzdC1jcnlwdG8tcGVyZl9jcGVyZl9vcHMu
Yy5vDQo+ID4gPiA+IEZBSUxFRDogYXBwL2RwZGstdGVzdC1jcnlwdG8tcGVyZi5wL3Rlc3QtY3J5
cHRvLXBlcmZfY3BlcmZfb3BzLmMubw0KPiA+ID4gPiBjY2FjaGUgYWFyY2g2NC1saW51eC1nbnUt
Z2NjIC1JYXBwL2RwZGstdGVzdC1jcnlwdG8tcGVyZi5wIC1JYXBwDQo+ID4gPiA+IC1JLi4vYXBw
IC1JbGliL2NyeXB0b2RldiAtSS4uL2xpYi9jcnlwdG9kZXYgLUlsaWIvbWJ1ZiAtSS4uL2xpYi9t
YnVmDQo+ID4gPiA+IC1JbGliL21lbXBvb2wgLUkuLi9saWIvbWVtcG9vbCAtSWxpYi9yaW5nIC1J
Li4vbGliL3JpbmcgLUkuIC1JLi4NCj4gPiA+ID4gLUljb25maWcgLUkuLi9jb25maWcgLUlsaWIv
ZWFsL2luY2x1ZGUgLUkuLi9saWIvZWFsL2luY2x1ZGUNCj4gPiA+ID4gLUlsaWIvZWFsL2xpbnV4
L2luY2x1ZGUgLUkuLi9saWIvZWFsL2xpbnV4L2luY2x1ZGUNCj4gPiA+ID4gLUlsaWIvZWFsL2Fy
bS9pbmNsdWRlIC1JLi4vbGliL2VhbC9hcm0vaW5jbHVkZSAtSS4uL2tlcm5lbC9saW51eA0KPiA+
ID4gPiAtSWxpYi9lYWwvY29tbW9uIC1JLi4vbGliL2VhbC9jb21tb24gLUlsaWIvZWFsIC1JLi4v
bGliL2VhbA0KPiA+ID4gPiAtSWxpYi9rdmFyZ3MgLUkuLi9saWIva3ZhcmdzIC1JbGliL2xvZyAt
SS4uL2xpYi9sb2cgLUlsaWIvbWV0cmljcw0KPiA+ID4gPiAtSS4uL2xpYi9tZXRyaWNzIC1JbGli
L3RlbGVtZXRyeSAtSS4uL2xpYi90ZWxlbWV0cnkgLUlsaWIvcmN1DQo+ID4gPiA+IC1JLi4vbGli
L3JjdSAtZmRpYWdub3N0aWNzLWNvbG9yPWFsd2F5cyAtcGlwZSAtRF9GSUxFX09GRlNFVF9CSVRT
PTY0DQo+ID4gPiA+IC1XYWxsIC1XaW52YWxpZC1wY2ggLVdleHRyYSAtV2Vycm9yIC1zdGQ9YzEx
IC1PMyAtaW5jbHVkZQ0KPiA+ID4gcnRlX2NvbmZpZy5oDQo+ID4gPiA+IC1XdmxhIC1XY2FzdC1x
dWFsIC1XZGVwcmVjYXRlZCAtV2Zvcm1hdCAtV2Zvcm1hdC1ub25saXRlcmFsDQo+ID4gPiA+IC1X
Zm9ybWF0LXNlY3VyaXR5IC1XbWlzc2luZy1kZWNsYXJhdGlvbnMgLVdtaXNzaW5nLXByb3RvdHlw
ZXMNCj4gPiA+ID4gLVduZXN0ZWQtZXh0ZXJucyAtV29sZC1zdHlsZS1kZWZpbml0aW9uIC1XcG9p
bnRlci1hcml0aCAtV3NpZ24tDQo+ID4gPiBjb21wYXJlDQo+ID4gPiA+IC1Xc3RyaWN0LXByb3Rv
dHlwZXMgLVd1bmRlZiAtV3dyaXRlLXN0cmluZ3MgLVduby1wYWNrZWQtbm90LWFsaWduZWQNCj4g
PiA+ID4gLVduby1taXNzaW5nLWZpZWxkLWluaXRpYWxpemVycyAtRF9HTlVfU09VUkNFIC1tY3B1
PWNvcnRleC1hNzINCj4gPiA+ID4gLURBTExPV19FWFBFUklNRU5UQUxfQVBJIC1Xbm8tdmxhIC1N
RCAtTVENCj4gPiA+ID4gYXBwL2RwZGstdGVzdC1jcnlwdG8tcGVyZi5wL3Rlc3QtY3J5cHRvLXBl
cmZfY3BlcmZfb3BzLmMubyAtTUYNCj4gPiA+ID4gYXBwL2RwZGstdGVzdC1jcnlwdG8tcGVyZi5w
L3Rlc3QtY3J5cHRvLXBlcmZfY3BlcmZfb3BzLmMuby5kIC1vDQo+ID4gPiA+IGFwcC9kcGRrLXRl
c3QtY3J5cHRvLXBlcmYucC90ZXN0LWNyeXB0by1wZXJmX2NwZXJmX29wcy5jLm8gLWMNCj4gPiA+
ID4gLi4vYXBwL3Rlc3QtY3J5cHRvLXBlcmYvY3BlcmZfb3BzLmMNCj4gPiA+ID4gLi4vYXBwL3Rl
c3QtY3J5cHRvLXBlcmYvY3BlcmZfb3BzLmM6NjoxMDogZmF0YWwgZXJyb3I6IHJ0ZV9ldGhlci5o
Og0KPiA+ID4gTm8NCj4gPiA+ID4gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQ0KPiA+ID4gPiAgICAg
NiB8ICNpbmNsdWRlIDxydGVfZXRoZXIuaD4NCj4gPiA+ID4gICAgICAgfCAgICAgICAgICBefn5+
fn5+fn5+fn5+DQo+ID4gPiA+IGNvbXBpbGF0aW9uIHRlcm1pbmF0ZWQuDQo+ID4gPiA+IG5pbmph
OiBidWlsZCBzdG9wcGVkOiBzdWJjb21tYW5kIGZhaWxlZC4NCj4gPiA+ID4NCj4gPiA+ID4NCj4g
PiA+ID4gLSBCdHcsIHJ0ZV9zZWN1cml0eS5oIGlzIGluY2x1ZGVkIGluIGFwcC90ZXN0LWNyeXB0
by0NCj4gPiA+IHBlcmYvY3BlcmZfb3BzLmMuDQo+ID4gPiA+IEhvd2V2ZXIsIGdpdmVuIHRoZXJl
IGlzIGEgI2lmZGVmLCBJIHN1c3BlY3QgdGhlIGludGVudGlvbiB3YXMgdG8gaGF2ZQ0KPiA+ID4g
PiBsaWIvc2VjdXJpdHkgYXMgYW4gb3B0aW9uYWwgZGVwLg0KPiA+ID4NCj4gPiA+IFllcyBpdCB3
YXMgaW5pdGlhbGx5IG1lYW50IHRvIGJlIG9wdGlvbmFsIHdoZW4gcnRlX3NlY3VyaXR5IHdhcw0K
PiA+ID4gZXhwZXJpbWVudGFsLg0KPiA+ID4gQnV0IG5vdywgaXQgaXMga2luZCBvZiBtYW5kYXRv
cnkgbGlicmFyeS4gSSBhbSBub3Qgc3VyZSBpZiBpdCB3aWxsDQo+ID4gPiBjb21waWxlIHdpdGhv
dXQgcnRlX3NlY3VyaXR5Lg0KPiA+ID4gV2UgY2FuIHJlbW92ZSB0aGUgaWZkZWZzIG92ZXIgcnRl
X3NlY3VyaXR5IGFuZA0KPiA+ID4gd2Ugc2hvdWxkIG5vdCByZW1vdmUgc2VjdXJpdHkgZGVwZW5k
ZW5jeSBmcm9tIGNyeXB0by1wZXJmLg0KPiA+ID4NCj4gPiA+IC1Ba2hpbA0KPiA+DQo+ID4gTm90
IHN1cmUgd2hhdCB5b3UgbWVhbiBoZXJlLCBidXQ6DQo+ID4gVGhlICJzZWN1cml0eSIgbGlicmFy
eSBpcyBvcHRpb25hbCwgbm90IGFsd2F5cyBlbmFibGVkLCB3aGVuIGJ1aWxkaW5nIERQREsuDQo+
ID4gUmVmOiAvc291cmNlL2xpYi9tZXNvbi5idWlsZA0KPiA+DQo+ID4gTm90IGFsbCBhcHBsaWNh
dGlvbnMgdXNlIHRoZSBzZWN1cml0eSBsaWJyYXJ5IChvciBzdHVmZiB0aGF0IGRlcGVuZHMgb24g
aXQpLCBzbyBkb24ndA0KPiBtYWtlIGl0IG1hbmRhdG9yeSENCj4gPg0KPiBJIGJlbGlldmUgaGUn
cyBqdXN0IHJlZmVycmluZyB0byBtYWtpbmcgaXQgYSBtYW5kYXRvcnkgZGVwZW5kZW5jeSBmb3Ig
dGhpcw0KPiBhcHAsIG5vdCBmb3IgYWxsIG9mIERQREsuIChPciBzbyBJIGhvcGUpLiBDdXJyZW50
bHkgaXQncyBhbiBvcHRpb25hbA0KPiBkZXBlbmRlbmN5IG9mIHRoZSBhcHAuDQo+DQpJIHdhcyB0
YWxraW5nIGFib3V0IGFsbCBhcHBsaWNhdGlvbnMgd2hpY2ggZGVwZW5kIG9uIHJ0ZV9zZWN1cml0
eS4NCg0KUHJldmlvdXNseSBhbGwgYXBwbGljYXRpb25zIHdoaWNoIHdlcmUgc3VwcG9zZWQgdG8g
dXNlIHJ0ZV9zZWN1cml0eSwNCndlIG1hZGUgc3VyZSB0aGF0IGFwcGxpY2F0aW9ucyBhbHNvIGdl
dCBjb21waWxlZCB3aXRob3V0IHJ0ZV9zZWN1cml0eS4NCihieSBza2lwcGluZyB0aGUgcnRlX3Nl
Y3VyaXR5IHJlbGF0ZWQgY2FzZXMgdXNpbmcgaWZkZWZzKQ0KQnV0IG5vdywgdGhhdCBiaWZ1cmNh
dGlvbiBpcyBub3QgbWFpbnRhaW5lZCBhbmQgDQp3ZSBjYW4gcmVtb3ZlIGlmZGVmcyBmcm9tIGFs
bCBhcHBsaWNhdGlvbnMgd2hpY2ggaGF2ZSBydGVfc2VjdXJpdHkgZGVwZW5kZW5jeS4NCg==
