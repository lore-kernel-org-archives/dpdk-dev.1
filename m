Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B6FD0E6EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 15:06:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 572E340B9B;
	Tue, 25 Nov 2025 16:06:35 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
 by mails.dpdk.org (Postfix) with ESMTP id 73E88402E1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 16:06:33 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKBv5P0X5SLo4U9p/AvnTfiJYMpRWuF7e6hrb89bplHKp0E/y9xjU4a3Gx6vyZeeczAoJxQohQjX1GBfQPOxESFtYr9OtHU1yDLWnSs4NPy3GXWCma+R3OVUt8wrmKxL/4c7SggSUBHF8nMfM3w80Edigc7VHaG0eGJNIWWDb3SiqNdtJ5ExW7lbSlIki8p6BuDt0UbO6JooZ9vLo2U8qEyiq44l1PCUwBM5o+3RJVKwWejiwZLVnaJzj39NgUcuRrfF2JuNkkADAwpctJrWjocEiFAQvQlWgjXShL3oR9aeP2kZx/E8WVb3yJ3087k/CjuyepBs9m8yKgP3UZUPzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFpnvN8aXU6d3hId1oDt37+39A16iwWUaxRd6TjhlKg=;
 b=kDfRXQnm4acxXOykUXJoL3btbnymXTjlkniUaGdT96hlGkJ8kghTY70nZpWBP1dc4js5APXFaLAyUH446oUuKNgYSbFXuWG+UDmXdMOGotenNQcuK1a5PlPBtQUiuGXiNipnYUzaou4Q2ymTUFijelHh2GE8VKh+CxZevcFfD42AlTeRvMZZCKORFcmlQrgiKp9N7fiZqD6cuRuGuHF0ffv+6ilH+CJebwTpoWiY8Nj+66k6Xo7FjC8wgAF1/RyGqVkTCGqfC/D5HOXnr6AUvkFpBjGB27Vx4oUMFY+44Rf6biUBiZ2WjJSa3BBNysQqHWw6ca+po26liW9Aujq4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFpnvN8aXU6d3hId1oDt37+39A16iwWUaxRd6TjhlKg=;
 b=h+SJydhW0GUL6S99+M47p4wcRRBzUNic9ZmPWghLgvHwjS07LQYyOARdRTsRGxDl3Y9OFhc9eDQ2B0v5h2JqURjm44xyc3/gN6F+dPQ2xgaQYqgVDEW/v5BsM2kQTM1d3xPfX1im3yFRbP2fwtzy0y7pziWwgVyUQjlDKuzQNRiLrmlniyDM900jbW7pYJUJMXs61vAOZ94/lrUvw7nMcy+FN/hychg6R3nU0/ksNPe4m92GRCmJIN5+uEyUihALWRltW8EaasFbqV43y9HstyI5ZHMoWhwpuCn1bSsAV6sIv8r5b+qOcBKKAA391AFMwn6YxpyWiCqTd7LQKRIWLQ==
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AS8PR04MB8657.eurprd04.prod.outlook.com (2603:10a6:20b:428::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 15:06:32 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 15:06:32 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Sachin Saxena <sachin.saxena@nxp.com>
Subject: RE: [PATCH] bus/fslmc: fix warning in device scan
Thread-Topic: [PATCH] bus/fslmc: fix warning in device scan
Thread-Index: AQHcXhpCVkDOyj5s/UWsV3v5WoowmLUDfdRg
Date: Tue, 25 Nov 2025 15:06:31 +0000
Message-ID: <PAXPR04MB9328299BD30A95A8A98D303889D1A@PAXPR04MB9328.eurprd04.prod.outlook.com>
References: <20251125144610.37661-1-stephen@networkplumber.org>
In-Reply-To: <20251125144610.37661-1-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9328:EE_|AS8PR04MB8657:EE_
x-ms-office365-filtering-correlation-id: 10565fe7-569e-473f-aa7e-08de2c3437d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|10070799003|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?RTB5MWdnNENnbDJOZmM1dTZ0UExpNmVNK2NNdkxsMnBJWStmdnBmUE1hRDQ2?=
 =?utf-8?B?RjdhVkFkenRYc0JQS2tGMkRJTXZpVU1EekEvMlB4UTVjRHp6ek9OSUZFREsw?=
 =?utf-8?B?TWd6T1RWVlFqcnB4Z09BelFqRmxWbHc0YkQ1cVRxZEIxdEhYNnRJZk1rRVBX?=
 =?utf-8?B?SXlpSXhMK3dkTDh1Q2RaeFB4UEx6VWptakdNUk45UUhrNDh2QVhYZzBqYVlU?=
 =?utf-8?B?N1VXZWowdUJGOUlYN2w5eFVseWNUajBQQ2pSdmtvZU9vVGRIRVBRWFY2LzI1?=
 =?utf-8?B?MGI4TWRNdHMxMlFvOTJwQm1yd3BwbHZ1QUoxaXRjbGxlVzRCMnQvWGxjbW5P?=
 =?utf-8?B?QUhFTzN5Q0NQd3grKy8wZEIxaEJZLzAzVE54WlJpU1d4Z3VPeGhzQ0w0UmNQ?=
 =?utf-8?B?cUdTSExURVQrZ29TS0QwdCtRRko1ckYrU0FzYzBVVGhnVlkzMHpMclQ3cndy?=
 =?utf-8?B?cTBDbFlxNlN2NmpTTmF0aTFyenk0amNkbzgrOHVGNHZzcVp5SXgxK3N2Y2cv?=
 =?utf-8?B?OVNXL3NFY2NCT2hYcUdEVFNHNHU1NHE3RlBOc01UaFhBRGxYOXNNUUxJUjhV?=
 =?utf-8?B?TjE3VGhQRE92Ni9UMHEyQWFsaXVYLzBJOWVOL0JiNUVNR2tmRXJCa1c5dkxw?=
 =?utf-8?B?djRkdjlFWUdMN3p5NkUvbzhVZVJTMDA1dmdieWErYkxuM2FxYUJyTU9HeG44?=
 =?utf-8?B?Vk1reHlFaEtSUnhZSllCMHFkaGsvVy9Ga01jNU0rSzhoMTFJMFFncmlabERU?=
 =?utf-8?B?cEk1N0t2UiszMHpHOXdkS2hybEtIOTd3OGg3clV6UEV6dkFLL2JDMEorNEUy?=
 =?utf-8?B?MElialkrYjMyMFdvTHZBcG9TM3loWVdCbTNMQzBlMzdyVEpFV1lMMW5CMTR6?=
 =?utf-8?B?U3dLYzNVSE5VMXRVODBCM09RdVMrNmFCaEdrNjB4blpvOGRGSUkxSTEwWWs1?=
 =?utf-8?B?V0xiQ25Hc25WRHhLclZIZkxUWGhXV1NDM0cza1FwMkJGYlN0TStXeFVLdWkw?=
 =?utf-8?B?ZUNTNEc5TXpmQTJKd0JWY3NDL01qS3ZZcTNEcFZMdHRLTEE0elhwdzQ1OGpC?=
 =?utf-8?B?RGJnN0lMR1p3Qjd2cFR2RGxPR3pETk92Mnp0WjFTaTlBV0N1bmZvaGs5K3gr?=
 =?utf-8?B?OE44L1I1Z0tvVFp4VWZtQ0VOR21vejRISjYvUmxBOS9ZQ3BhNlRmUzZrYzJK?=
 =?utf-8?B?cUZkaWZkQ1FHU2l5a1NhaDNlQit4bWZPdTYxSnA3MzJ6dUJnRFIzWXo2d2Vv?=
 =?utf-8?B?ZFA2UUlwMzhtdjNmNHRRUXJZT0JjNjFKMkVJV2Z2aml1cit3YnFuZmlXaUoz?=
 =?utf-8?B?ckJNbi91T1A2RE0vKzlrbnBPOVJueFhSaDVDYmtqMTJJS0taa0tTUE1xMEdN?=
 =?utf-8?B?eU9EdWV0VlRpNTNmV2ZLcHR5YThPc0tuTHhWL0tWVkNIMm5LR2NNdklUTDBY?=
 =?utf-8?B?TWQ1YS9UMGF5WXZRRHJKNWtYaW5mVElucU5uNEtNTWl2MHdGUms3WlhuK3Fs?=
 =?utf-8?B?WC9VRmNoRTQxUkszeE5mZ2s4RzJ2OGdBYkhacmlDSnlKdlVXYVBqOHc4OUor?=
 =?utf-8?B?RlJBdmtXYVZQVzZzaWplaFUvaGZEVHdrREFqMWtmYldpWVp0c2xlVlk5UEZI?=
 =?utf-8?B?SnJlSUNjRC90WGZvUER4cHkzc0U2K1BIY1pCZGVIdGpqR0dFa09GRC9sYnNU?=
 =?utf-8?B?VjQwMEY0Y2J2NUVacEoram5rbzl2Yk5Ha09obW5CRk1ubVNoZVcyd0JtQ2dQ?=
 =?utf-8?B?WUFRM1lidVB3ZnNDS21zTmFTd0NDT3YzSzJLdjhqdkFBbmtLTkhwL1Z1Rzc2?=
 =?utf-8?B?aVZmZGlEN3NiY3lPb0E1Z1lOcnl3dGVVVVJ0akg1ejVmaW9zeW5qUzZFTThK?=
 =?utf-8?B?d25sbTloMUpSVmxvWGhMd1A0ckdLdWxKczNQNGpmRmZjblh1RVB5OFA5T1FR?=
 =?utf-8?B?U0NXV3lkSkRLS2xrNVV0VmtrUitjZDVqRGhVZW5BMUd1djIwajdHcUtEUFNr?=
 =?utf-8?B?REJ4eTkwVTArRFFTa3BBOGZGR3Z3N3dDRXBMaHhyUyszMFBoMzUxaHJaVnRL?=
 =?utf-8?Q?Y1JbsJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(10070799003)(366016)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjdjYldHNThvdlJDVGM5SFArSzJRcUJjQ3hIN3ZIQ0tmL2gvVUVaK2lRVzVR?=
 =?utf-8?B?NCtrRnAweEFITTdUZDBra0o5czlCbTdNeE90MU5welcwNXY4aTBoQU03ZVpV?=
 =?utf-8?B?QUdQUmdlRkZwT3NGSkE5bFhRdXlidlV5U3Zta2RJMDE5ZDlPMzFUTmpWZTRX?=
 =?utf-8?B?UjdyU3BmRE5pWGxEaUdML1hoVEdVSy9JRUVGd2Qwa21jRnhWNlQ4NTJZQ3NH?=
 =?utf-8?B?eDRGd2c0anF5R1Y1YVFGNGcybWpFdDJ3Zi9GYk11eUJmdE5DTkdIYUk5bGZ2?=
 =?utf-8?B?NFo5ZXo5bEY3QU1FK2xpK3B5T0JIdDBVRVFKUGdoM0lGTHd1NGxRbW1SREdr?=
 =?utf-8?B?Z3JWbDBSWlB0eEtTdllXWWpEL0p2L2ZsejdoRUxjV1pPU2ZkMEt2d2ZTcGs5?=
 =?utf-8?B?S29iMUtxdGFlU3FIUUQzQjRESlNwVlowL2s2WlRwT3U0NWwxYjNIVWg3VWhz?=
 =?utf-8?B?UVlkOUdBcGI0dmk3aEhoNURtUm1mTmhEUUZUdXBhYkFhNjhIa0V0Z09vVmlM?=
 =?utf-8?B?V056K1NUNjdDSm9oN0k2ZUdFc3ZQUTdVQmFFTHRCL0graXRqOFdnQ1NxOThi?=
 =?utf-8?B?eUFlQjlEQ0RwbjM2d21oTyt5VFNyNjl5d0Y3YnpRNVVBL2JmL1hEaklvRk4w?=
 =?utf-8?B?LzVxVWZnRENlM29YcXdnUlJkZXJaNjhzdWdSZEpySWtBQlVyZnNGNTEwRjJY?=
 =?utf-8?B?Y0pzVWxRdzRzSElnM3R1NnUvQTQ5N2VXblBGNmVidVgrY1drRzIxQmp2cHVH?=
 =?utf-8?B?dStsd1loV1hLYmp1YnhRb2QzVU1yZFBXeTlDYkxFQUhtY0dvSEtmNjNpWXFu?=
 =?utf-8?B?MlNON3cyWWdsd3VJclA4NDdaSkIyVWZtazdJcW1lU3RJeGMvUVU5SnNJckdL?=
 =?utf-8?B?STVEMWJGSlh4a3hrOVIwSkxTK3gwclVyQ2VhaVpmN0ROV1l5QXZoQUpJd212?=
 =?utf-8?B?TTYrZ3lPYktLOUd3NHpWc1B6VXViMmRKR1ZVWFlXZG9XMUZKUm1ES2RkYUNV?=
 =?utf-8?B?ZHh1b293K25xNWRSd0dMQUVmL1paL2lmTVVXeHJCQ2tiVGVYTlVQUnhSbVhD?=
 =?utf-8?B?aWVNUmF5Vnl6OWNjcndNQ2tXYk45OFhUTzIwakNRN0NrZEFGd1dBRGIxVEl5?=
 =?utf-8?B?bWxPekJOQTJ1YUlzdkpKWTNZdTRsb2JpRW5QSDJRbnZHc0FKVnNVcCt5QWlo?=
 =?utf-8?B?QmNPL1N6WUY2SGd2cGFYM0xJbG0wd0R5QmE5Tml2a1ZJZ1Z6SGhYMkNyUU5E?=
 =?utf-8?B?c3dCaUpYaENmVVU0K3RDN2dpdi8zdzNsYjVkcmV6TXkvVVc0QnArTU5rejdv?=
 =?utf-8?B?MzhvRGEydkJsdE56Tmc1bzZublAwcUczemEyd0p5VUovekNaUjZDRDZhTXhD?=
 =?utf-8?B?SUlFQWg1d1ZnYUk4R1JmVm80ci80dGtuN1Z4RlVDYUdtc2I1bG0zTlFpZ2Zh?=
 =?utf-8?B?RXVYbWxuNSthMFArUkd0RG1iaWFud0JvYStxaW54OE0xU280MnRRdmM2VVdo?=
 =?utf-8?B?NjRNOVZ6bXZnL2ZTZ05oYS9wVm1JYUNHT0o4akp6cVhWZ3JUNGg4ZVJMV0RF?=
 =?utf-8?B?MDhVWExQeUQ1c3pTVDIwbjR2R0JFOEkrZkw5TE5RMks0c3hEc0xQYjZnVkNX?=
 =?utf-8?B?ZUlaQWlOaFB5aUMrOGpjRnA2cStYWVFXaGRNWUI4dVgrTXkza3BidzZITk5T?=
 =?utf-8?B?TnpadnM5ZkhaaGlyVXRPL0JGUWttb3pXUC9hejBjMFlhdUs1Tm5VZjF2TWti?=
 =?utf-8?B?c0laWWVSeWg0anA1My9zclpWcmQrQ3FDRTBmSEJUZmFoMWQ0VnRWMXEyRVdZ?=
 =?utf-8?B?ZnhMd2lBbFl5ZXdsTzMxUnBLTU1xNEpGbkNQZmc5TDNya1BXbEN3RFc1K0F3?=
 =?utf-8?B?bFM1Rm9IRFlvdWNZUXlISzBzejVPSXV6OVY5WHpqa29mY29UNkZMczd5VEZu?=
 =?utf-8?B?aitOV0NsQ1VNalYwL1JRTnJWVWhOSFo3YTFlTStiU3BqUlpKb3F3TVpPOGox?=
 =?utf-8?B?eEVFNW4vWCs4Ynhsdzh4T0FPaFJhdjUxVEhySGNHcUVRdzZDVE4vQWMvNEZK?=
 =?utf-8?B?MHdJT3Q2dEExWFlML1BWT0c4S0ZPYTA3MCtZTTNsREFLZnNGK0gzNjl5Zkph?=
 =?utf-8?B?dEVTQ3hFbytzRkFaNWNaTGZMQWNsWm9vclJHcmErVTZ2QlBDbUN0UElubndv?=
 =?utf-8?Q?Jq9B3yMVTtiCeMmmdW6pgs2xx6XhsUUrWBY0VD87csnz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10565fe7-569e-473f-aa7e-08de2c3437d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 15:06:31.9094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b2in8UMQcbeGlkhFR51s8vyjUVvyd0f05iOG1DiJ4HDVs5m4A9d3jeKbuDp3hW3mD9zWnwsqdUTprt8zF0xWPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8657
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

QWNrZWQtYnk6IEhlbWFudCBBZ3Jhd2FsIDxoZW1hbnQuYWdyYXdhbEBueHAuY29tPg0K
