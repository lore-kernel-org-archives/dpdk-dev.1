Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716ACCCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 12:47:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E1684042C;
	Wed, 12 Nov 2025 13:47:32 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
 by mails.dpdk.org (Postfix) with ESMTP id A1945402D1;
 Wed, 12 Nov 2025 13:47:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCC732Z1i2bBMxizDnBzZf8+qq3Hnw++c/kzE67wtgQ0Qrf87sWVc7cF54vDgUKA3qcO6TzZaMxqj1X8/Rpz5ID3ZAUv7hiwrSfA1+yIS7hNszWKh7x0SALnjpriWKPP41/1qif1uEb7n2K7xkasnq2TU5robi1Ycvk2UcuTCPmBU7QpnwxhRM7LJo4ffq7GwUk2i6t+k9ssxSFFXP/DfLuIZY3jzRlK0CQ/SOdH3ZVLyeCAA5uUCgPGJjEgSZKvJeHhch6aADzKXdrk3sZMNa6HeSZU0FV91ZuofdCR2n4zc5X9u7Qf5Q44gf9OceAucXqQypg1oxt1O3wwe2yoiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65UZ8AXarfzP+dD5ryu0AUr4B2XtjL1OY4Eu3e21CYk=;
 b=UOVHVrI3Z7rJiCEv+80W9YhDHWRXO31AwZb0jRUoF6v8q8AqxrNs6yFrgjVS9uHH7Fg3dX4cI8j1HU7CTh/0lne7aLPTOB6wAjj/17JDFwl4Xr983x1G/BzS/qkYRBS99mycwKMjnj0HC4jy9BsIbV1mXBkO35POze7Mz8xhgVDB3pBJPBu6PRZpdN+g80uOsfpj+OxWt3NaAA306emMvNjgdXaI8oEvM7We1mobRL3awYess/IPlzn1qnz9ZaRyJU5AGTOH/0emDJ416R1jrBur4vzHKivukBPTnUtKhdwCB+uAqpiT/gUMlqYawGGNswyR0x4CqLVe0ny2oLtiPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65UZ8AXarfzP+dD5ryu0AUr4B2XtjL1OY4Eu3e21CYk=;
 b=uMkbtkjGrUa7n/uiqzDcQBoI5LGwsniWsBw3EooPrNEo365fRVhZZbBgNKZlzqfy8iFSRm8b9pd5FGbWJznMYFjEibvnJqMBsgAsWbZSstNl/5GBwgI56vjXz17BqX+M3zXyEg7ajv1qLLfigkUxm65fniaz3VG/PVF7McLlpzyBFqgo0xUUKBslG4ONWdGPF0Y0Q0WiLuQbI6yK32VD/o/A+Hp8PfBCzvhh28tyRTqBQWIYpoePzsmSO0amvKwC5A0NGBg8VNfDFfpLsR9BMxWeUl/Q7YiwCemYCEEMKXar59r9nRBQS2qUzMpektazL5aisyYTbjF9C10y9ozdIw==
Received: from IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 by PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 12:47:27 +0000
Received: from IA0PR12MB8376.namprd12.prod.outlook.com
 ([fe80::4c58:7502:cc8d:8c7e]) by IA0PR12MB8376.namprd12.prod.outlook.com
 ([fe80::4c58:7502:cc8d:8c7e%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 12:47:26 +0000
From: "Minggang(Gavin) Li" <gavinl@nvidia.com>
To: "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>, Bing Zhao
 <bingz@nvidia.com>
CC: Matan Azrad <matan@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, 
 Ori Kam <orika@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>, Raslan
 Darawsheh <rasland@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>, Maayan
 Kashani <mkashani@nvidia.com>
Subject: RE: [PATCH] net/mlx5: fix IPv6 DSCP offset in NT HWS API
Thread-Topic: [PATCH] net/mlx5: fix IPv6 DSCP offset in NT HWS API
Thread-Index: AQHcMdwPfJa9vqQKlU6vPsQ8iN3lA7TvAVaAgAADLgCAADy1sA==
Date: Wed, 12 Nov 2025 12:47:26 +0000
Message-ID: <IA0PR12MB8376E03456B1B6D738F70FC1B3CCA@IA0PR12MB8376.namprd12.prod.outlook.com>
References: <20250930072827.9630-1-gavinl@nvidia.com>
 <IA4PR12MB97632C78D2EAF7F0987C75A2D0CCA@IA4PR12MB9763.namprd12.prod.outlook.com>
 <4447141.2yuIWEeYC1@thomas>
In-Reply-To: <4447141.2yuIWEeYC1@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8376:EE_|PH8PR12MB6770:EE_
x-ms-office365-filtering-correlation-id: 53329c5d-676f-4de3-6144-08de21e9a256
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZUR1c2pnUDQvR0lYNHZ4YU5RVTNsVk1LN2FGMDBIVWxHVEUrTkgzM0Q0c29o?=
 =?utf-8?B?T0FLcE5TMEEzb3YrM0NudzJBU0g4bFdlRnFVOUlWTHljdlF5UkFxYWN4L2ow?=
 =?utf-8?B?aStLZ1BKT3RZRnVkSnQ2QnBJdzNGT3VjbUFQVzhIckR0d1FGeG1obmRnNEVV?=
 =?utf-8?B?WnN2UVpPUDRKU1RtZEJpSUpMZWlHRWNEVEhHUm9EVjhOY0pUM21UU3p2aGF3?=
 =?utf-8?B?UXNpaWRZUUdMVEFEOW9ycXpWYXpXQjdpOWxIcktxaU9yRGJjWGNvQzREdERx?=
 =?utf-8?B?SFJtK0ltRWRhRU04VDVuTjY4dTlPdVF5SVhGWTdkNURqWFlWbVVUYzFJUjhI?=
 =?utf-8?B?Z1BhZlo4dm4yQkpHTFl0aUdQTXVkanVZc2VxMVlvNVZuUHNQME9lMXU2RnJY?=
 =?utf-8?B?bzRtV3hJVmpTUkFCcTdRQjNNY1YwR0QzQWVUdEc5bVJQblNGR2x0SGg3bDRY?=
 =?utf-8?B?MXpjc0hML0lXUm1ZUDlmUERXbFg5Zm9EdGl6OUJGNmRmTkhLOTJTbjA3MzdJ?=
 =?utf-8?B?OFJ2QWp6OStFNE5sVE1BeWhWQSsvaDNHcjVaLzJ1ei9XU0tTUHZmc3ExUExW?=
 =?utf-8?B?QWRxMVVnWXJvdzBPYkwyaXpxK1hRSEQzZmhPdTBxaXNsb3VhTlluNTNXK0lk?=
 =?utf-8?B?SDBPNkhJY2hKbjUwTEFkeWRQbFNvamRYOFNOcERXZlFDZ1VLazUwQXNvTDdk?=
 =?utf-8?B?bURIYWFPY0dqSStRMlBQdDZBR0lhaWdIVHhUY253VlRtL1V4NUdmV3M0Zmhh?=
 =?utf-8?B?c2hqd28zTmlWeUdBMDRqMmttb1M4VEhzNGNMcC94a3Ayb2lYWVAyc3dPTXli?=
 =?utf-8?B?akFoUXFrbjdOM2lSTWFzbnVZZTFqYVVtdDF4c0xjOHVxOEhVT29zWnNhbS81?=
 =?utf-8?B?M2IreGdXMERuR0hXMytWRlRxUTF0ZU5Xc2czYVBCeFlobUhJM04wdWNzdFV5?=
 =?utf-8?B?cTdMSG0wY0J2OGVNOWdvWUNuTVRKdkR0NWVnUjIxdzQrU2hGYkZTRWg5RGRi?=
 =?utf-8?B?OWVTakd3QWRaZDZNZSs3UE5wNi84NlJkS0RjSit6TVRZY1VSZDJySUYzdDJ3?=
 =?utf-8?B?R1FkeDZYRmxTZkFvOHlVSWx5SC94Q2NhT2Z6NVl0YUFac3dQMjI3c1JpODk3?=
 =?utf-8?B?STVRRmN0VlBtZXNMMzZqTXZCdDZOUjNJN2F4dWs2cmZrMzlUeGVXbzllU211?=
 =?utf-8?B?RGFIWDVnL0NQaFd1K3FJUzVtaUVUN3lZcnA1OTBaeHB6Y013QVc3KytJZmE5?=
 =?utf-8?B?akFReHRHYy9LSkh0OW9zSGM3WSt0aSsyWm5rdnY1U1JpVGpEdHU0aWIwQjQw?=
 =?utf-8?B?Uzd0YkRSeEphMFluMlhhZXVPclBBSEw3TXJLdGRCQ2ZpLzJHM3ZSSDgwRWsy?=
 =?utf-8?B?SFdaK3Ixanp3Mm5CMmU3dVF0ZStLWjBod2FBTERpZHdua0RGUlp4cGg5UjAy?=
 =?utf-8?B?OVNrMjltTEZkakNKVzhEUnlFZnNrN0t6MGV0TFRqd3M1cEIyM1ZCcUZ5K1hI?=
 =?utf-8?B?Z2JQQTh2WW1IbUlINGRCSXg5aFBUd25vQ3lFc2hCYzB2dm5OV2EzL3p1enZj?=
 =?utf-8?B?SURHQ0EzT1NWMDNmUCtwS2FETzdjbUZIY0lnNm5Bc0x3dnY2dWVubE1OdGdh?=
 =?utf-8?B?NDNyL1VYM0hSUTY2K3FmV2NTZVNVWTg1WUNVK1I5WEZRa09FMlVCSW9MSFlm?=
 =?utf-8?B?a2tYZ0N4TFZ2dVVtY05QVDRoY1laWDNnOUVlTHRnMmx0UUk4VG1aQTc4b2ta?=
 =?utf-8?B?M2RZUVl0T21VcnRuMGd0Q05GeFVRYjRtcGo5eTF5ZEh4aXppdGlHOWM0YktB?=
 =?utf-8?B?cnMzcFcrWjVxallrRHJSR1pUOXFEb2IyMmF3OUZ2OUpQT0Q0dzZlRExWRlBC?=
 =?utf-8?B?V1FFTHFtTlU3M1djVFV6LzNaN0NKSWdmeFFzV1JPQmZrZGswZk1SWGlyQmtV?=
 =?utf-8?B?QWRWVlJ3UVM0OEJ4TTVQbFMreG5VVWl6d2dDY3ArZGFXaThvQithUnl6QjFk?=
 =?utf-8?B?S3VaSW8ydU1VbGtnOXBSRU12cHlxbllUeEVla1V5QUxVbVllMTl2RmMxQWFS?=
 =?utf-8?Q?on8Dgg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8376.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnNjcWo2K2hKVzVwUU8xR2F0Mlp4MTlOZ282RHhxTkFZTldVUDlJaHg4T3B3?=
 =?utf-8?B?blNDbmhhRDRQa3Y1V3NkYSs4Zjl6RSs5UE1ab0xpOTJrRkZuVW5CVzRVZHI5?=
 =?utf-8?B?by9GZjhUNSs5OVRIaGtxRjVRc1hZTVZZS2NnVjNacXlXanp0NklGUGZkazQ2?=
 =?utf-8?B?V2lDRUxnRjJFcHBPTjdlRzhZejBOeExvUGFEdXlGeVF1QU5WVVR3OXpzanZu?=
 =?utf-8?B?V1gxUE1vRmFPd3RKczJ2YUVqSDA5bHYwd1ZNdTRBNFk1QVh4eWUwMkhmZzBy?=
 =?utf-8?B?REM3MXRZWHJ4c1pLRmFJemprNkZscUIvdlo0cmh3MzRyWVRRQThSNXJKTE9h?=
 =?utf-8?B?MzlTVnl0ZmJmbWpya0g0a3ZoNGhINDFtTEl2YXVzZmV5UUhlOG9EUzZtSGI5?=
 =?utf-8?B?MStkWDh2MC8zS2JtZ05YSjVTNElYK2hYS3JOT3JGbnNpR1RZYzJKVVZ4V1Na?=
 =?utf-8?B?bUZmNWZ1NXZJak5BOVlMd3U1R0Z5U2pPQlg3OGdDZnhPaUR2YUxQK2lYSkV3?=
 =?utf-8?B?eUczQ0s0b1M2dTFrckgzOXZSZUVPZWdaYWFkVnJ1Q1Evck9HVVVpN1B4bmVH?=
 =?utf-8?B?U0RFODEyQnhORENpeUJMRXBNODU5bWFSTEZXbisyRGs1ZlZDWDM3TS93SVJY?=
 =?utf-8?B?bTM2Z3J2UHRrSGg5eHUxQVhJaXIrRndUUGZpVFFhNVZNYnBjbUdNKzNBUFY1?=
 =?utf-8?B?ZFFvNHd2OUdWOFllRnprL0VvK1llaVpvdEVOL0F0Snkwam5kRlJ4TGtyNkta?=
 =?utf-8?B?QmdIVEFRTHlOTS9mYmx4SUdLT0l2eitCUXlVdzJ0QUprTUprTzUwSU9MNXNp?=
 =?utf-8?B?V0MzekF0M2l1czZNS1pnSHpWUXVPMXp1K0UzUUk3Z2hmZ3cxOU5LRU9iaEFt?=
 =?utf-8?B?VWhIc2J2dWZoSTRYMGc3dGN4bU5WTTZBTTYvQlZJcWVhQTBIWnBwYlJmTTUv?=
 =?utf-8?B?VzFMWlc5VlJsYW94M0tRV1d1Q0FZaVAxa0Zzd3ZEbGpmcVBaWThvbys5Nm1t?=
 =?utf-8?B?S3VPSUI0NDZZWklxa2wySkpYTWJKL3hJNUl3Sjl5L2NpRnZ6N0J1RzhNODJL?=
 =?utf-8?B?dlVwU0h4eEdYSTRBdWh1K3BCcGxMY1lLR3VxTkE3czdncWtnRXF3akRYcWk1?=
 =?utf-8?B?NzUwR1hxbDJOSWNWcmQ5cEIrczBZMzFpbnBIM1lhV2k0Z0tvdnl4aEIweG9H?=
 =?utf-8?B?WXRTK0gyeWFWM0paSzcrMjV3NDgyMlpIOUU5NTQ5bmhQaWhBQTVCd2QzUVZU?=
 =?utf-8?B?SXowSHB5OFBaL1RoZHpvYkh5Vmh3eURkUnFyd2FqaFlXZVlSYlIrVWNGblpk?=
 =?utf-8?B?Wi9PQ04wNDBLdG5vUmxRRng3REVtYWY1NXhBN29FdDBDcEtUaEpObjh4YUlh?=
 =?utf-8?B?UG5rMDgwMVNiVi9HcENsR3ByMXA5NjBsM3AzRnFjakVZTVUyNDBQN2NZM1Iy?=
 =?utf-8?B?a3NQNjZadElKZnlIeWtlaCtoNHBwR0FkYi8xRWhhM0d1aStrWVNBUG5TVTBp?=
 =?utf-8?B?cnJQT1RFRDhDQ1B2eDd6M3RKUGczeW1NREZqa281NjhQc1B1bU9QNkhWcWpr?=
 =?utf-8?B?QW94K1A0SHZCUm9GcENwL2htaEFYbkJnL2R4bEtscUU3djZUMmIzSVdMcnRu?=
 =?utf-8?B?aGMvTzBSUjFpb1UxMDNXdGdHQWczNXZQZ0tVeUh5allRaEhrTHJJdmZ1Sm0r?=
 =?utf-8?B?T2ZKYXJzazdqdWYyekFWN2lBazlVZkxRSk4yVkwwQmRmR3V3MTJpYko2SWN1?=
 =?utf-8?B?WnQzUTExWkNuRmpETHl0NTZYRXFIMnVyYUxKT2VONHVwek9SamF6cGd3azZ5?=
 =?utf-8?B?cm9qTm1XN2ZFSTdSLzFYYk5EdkN0aE14VnhPdXhJOExUdG1uNHNhOUQvUHM1?=
 =?utf-8?B?aFoxdDhxd044cTYrNEFKbDhWSzBQWjZlbk4xbWJUcndMT1RORFZ1cnZTY29E?=
 =?utf-8?B?bmF5WElRT28zZ1RueE9Rall1YzJjR3NaV3R0UHFCSzh5Ymc1a2s1UStLcjJB?=
 =?utf-8?B?SUVjUWRvMnozSnVVOSt6R3ZhdFFNS2RGQ0xDTVRvbDZtZWxsQ1orV1hYWWd1?=
 =?utf-8?B?OE50NCtRbWtVWjQrWFpLV2NRaHZlZTkreUt5YXl3WCtpL1l3TDFSSk9CZjV0?=
 =?utf-8?Q?HB64=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8376.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53329c5d-676f-4de3-6144-08de21e9a256
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 12:47:26.7405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: isRc58J91EsscGufNdjzu7DAitSvj1oxH6KuIo2poOzC/0YmZAO8is25wnCZqzgd1RmXtg0cajWAUac8gtdvTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6770
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhvbWFzIE1vbmphbG9u
IDx0aG9tYXNAbW9uamFsb24ubmV0Pg0KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDEyLCAy
MDI1IDU6MTAgUE0NCj4gVG86IE1pbmdnYW5nKEdhdmluKSBMaSA8Z2F2aW5sQG52aWRpYS5jb20+
OyBCaW5nIFpoYW8gPGJpbmd6QG52aWRpYS5jb20+DQo+IENjOiBNYXRhbiBBenJhZCA8bWF0YW5A
bnZpZGlhLmNvbT47IFNsYXZhIE92c2lpZW5rbw0KPiA8dmlhY2hlc2xhdm9AbnZpZGlhLmNvbT47
IE9yaSBLYW0gPG9yaWthQG52aWRpYS5jb20+OyBEYXJpdXN6IFNvc25vd3NraQ0KPiA8ZHNvc25v
d3NraUBudmlkaWEuY29tPjsgU3Vhbm1pbmcgTW91IDxzdWFubWluZ21AbnZpZGlhLmNvbT47DQo+
IGRldkBkcGRrLm9yZzsgUmFzbGFuIERhcmF3c2hlaCA8cmFzbGFuZEBudmlkaWEuY29tPjsgc3Rh
YmxlQGRwZGsub3JnOw0KPiBNYWF5YW4gS2FzaGFuaSA8bWthc2hhbmlAbnZpZGlhLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSF0gbmV0L21seDU6IGZpeCBJUHY2IERTQ1Agb2Zmc2V0IGluIE5U
IEhXUyBBUEkNCj4gDQo+IDEyLzExLzIwMjUgMDk6NTgsIEJpbmcgWmhhbzoNCj4gPiBNYXliZSB0
aGUgdGl0bGUgY2FuIGJlIGNoYW5nZWQgdG8gbm9uLXRlbXBsYXRlIEFQSSBkaXJlY3RseSBpbnN0
ZWFkIG9mIE5UDQo+IEhXUz8NCj4gDQo+IE5vLCB0aGUgY29ycmVjdCBuYW1lIGlzIHN5bmNocm9u
b3VzIGZsb3cgQVBJIHdpdGggaGFyZHdhcmUgc3RlZXJpbmcuDQo+IFlvdSBjYW4gc2hvcnRlbiBp
dCBhcyAiSFdTIHN5bmMgQVBJIi4NCkFDSw0KPiANCj4gDQoNCg==
