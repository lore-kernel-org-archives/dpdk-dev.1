Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A37C77B7C
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 14:01:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47FAE40DCF;
	Tue, 24 Jun 2025 16:01:34 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0036B4026B
 for <dev@dpdk.org>; Tue, 24 Jun 2025 16:01:32 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O5Bbxj031396;
 Tue, 24 Jun 2025 07:01:32 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2113.outbound.protection.outlook.com [40.107.243.113])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47fnnbs0y5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 07:01:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnzOrhC+0ZIEqTmCxBDIzzFSv8oAos3BCl3jfg24HISamJfw0C1Rz7vlWD/OVbepFsNlVbF0mqRqG05xkSkqrfgnUyULWXUdmdVTtAbyrmTAtsaDvkHfm5bOZyYD5K8vj1lsq7D6eNiCSB1ZXHLo2b0/GESVqKcIdZDfEn3L7Xx2rHzck0Z5NA5zrapZXONv4REEo+hzG44KHrSxrA56gytC7QXmYco1UPkmdW5Jk/ou3WMWCRLhd1xy6CBRNJxkRJnMdW/4GYuG3nwsIHwUrv3j1BTq/iK5JaGEBtrJf9bT3ShnwjEQoTs2buLENWJ3yR/Ak5hR5st9lg/io32vkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/bHTjJ2smmuZU0F7iFjhnzku89ZSOJahwCeZzI6paE=;
 b=pF0czLmiBEUFyOnzgfLnaG/R5G0ykrGEMgoyr4qcY9burbtfz5DSh1b++5kcGjcwZsGCerbjYDpBF6kgzLQczcnHv7L/rTSIOzYytGShfEimq4FYIJUSLSjCUbvkR8tRCUu9YgjNgWY5NsCmPeXq7tXUHjVNH65KAJLKUgWrnHTBKreuK5g2rNq3sFdTVFrGSa/GjD8kJnl5aZQyZydbUnEIvvZl2QcLMvbljvlm0XY7WxGO2HMqSYK5yg+3n/zb4vt+9GaYtcmvX3tZiZFifPUYyQR+aYTKN9cGXJR80VTs1cl/XOkBj6tAfGkjFyO5DPAKJrefBunSmlDV6W5FZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/bHTjJ2smmuZU0F7iFjhnzku89ZSOJahwCeZzI6paE=;
 b=lWVbuwgakIclTfpCP77li72XsxTtWHKo6rQmi6eonafp6//r4dkfpEqUXHMI2JDu9OlL/7dAte2yMpSpSf5RN/pd+LGDx+k7JP/Su9kdZzJQxAWzyfZzl3MdqNTOS/fKQ9NnWqYPvjajbx4jdV45pX4ErwvHSc7dwNIXpJCRnEc=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SJ0PR18MB5164.namprd18.prod.outlook.com (2603:10b6:a03:418::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Tue, 24 Jun
 2025 14:01:29 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 14:01:28 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Sucharitha Sarananaga <ssarananaga@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "kai.ji@intel.com" <kai.ji@intel.com>, Sucharitha Sarananaga
 <ssarananaga@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: RE: [PATCH v3] app/crypto-perf: add support for RSA decrypt
Thread-Topic: [PATCH v3] app/crypto-perf: add support for RSA decrypt
Thread-Index: AQHb3oQVVJEWosX2F0KmONM79xBKfrQSY8pw
Date: Tue, 24 Jun 2025 14:01:28 +0000
Message-ID: <CO6PR18MB44842A8FCB9E4BE03813A985D878A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250605092404.3882473-1-ssarananaga@marvell.com>
 <20250616060103.2503415-1-ssarananaga@marvell.com>
In-Reply-To: <20250616060103.2503415-1-ssarananaga@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SJ0PR18MB5164:EE_
x-ms-office365-filtering-correlation-id: a2b1ee6d-3c5d-4049-9ab4-08ddb3279dbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Sa3kocu3FPbvne+WV5qh5P+QJF34+fUhp+c2thgSGgV0LQhGcYYkPWi1eg+7?=
 =?us-ascii?Q?GS0CO0kMj2vea0K8CVVKMAE1Q3R2XvXqzvHpDHKDHxWS+xGHxNKU42Wx95dP?=
 =?us-ascii?Q?Q9M5RLtTGCOwUuJjI4hhv53URq5fhIdnEFfA6K40m9D+vzEcWtNpZ7CfktU1?=
 =?us-ascii?Q?RRc0+87apdBhkUZdP0IcPd8X91OY5sbrDMtwEPArHTSVdDzK6i0AHpund9KE?=
 =?us-ascii?Q?5bjsJrqyIc49XoehVEDY0+2J6O8831pd+W6JyAQSZoBe85ZNnWOzLLH2YzHE?=
 =?us-ascii?Q?wC9yNQa9CgaLOUrKsrWRM8ykOA74/r7/qoYpk3K0dRVoQ4GZdq1ct2FV2J/7?=
 =?us-ascii?Q?BBV4pYV9Tiu6n5M81No4Wagw9bqAuGh0nvb8fz13vZQEClgHIfP7Efsvq6yV?=
 =?us-ascii?Q?5mYJGJIBy5R66CGtMg5ce1xcslOpueb75hyl/rzbUBO+gup5k28ZtNZV2zJn?=
 =?us-ascii?Q?qhp/FNcFcUM3gfYxtK7XxaKKzFVUPVYLui36q1dSGujocbrO0npLaK1nbQJC?=
 =?us-ascii?Q?RhL1SZOWuln+NFyqcSm/BiVagVl8QrBpxL3PzBP/kSeVY5m8RCKnNqfM6rcH?=
 =?us-ascii?Q?n56Y48O9T/Oah+cbTMFlseJTj9qEXiGE9gajo6s7qEJCSv4+M3d4YZ9cGuXX?=
 =?us-ascii?Q?dj8oicWpnoJ3Vc43GM66c6P34zcVDO3+fAAOAYikRbU3Gutr9++YgbQMBBWg?=
 =?us-ascii?Q?3KK+L3Y65QQtKQK24haiQ3pVnLV43yrNTyyZa3Xrdiov8c4rV/x7Gsrr1BTX?=
 =?us-ascii?Q?rncQJFn67SG9YG8bmtlPgJwEz7NLSvbPLN7lbgYhI7L+R+KX+6RNfXkAzigo?=
 =?us-ascii?Q?ZXuUJLhoJBPb5Iv8hqa7Ro7iZDgj8Xa/mzpiztbYZownMoLljcmqMGLN46bJ?=
 =?us-ascii?Q?Uo95g2vOK0jfOXdWjqXPxoFiKh+WphyVag8FkWEIpI7ARV3HgFWIfcF58Vhg?=
 =?us-ascii?Q?QhixOT1qhaSVWxt/ZcMvYeAu+ubz9rn9F4bEwIUa+n3m7v1zXb/Gp7Mn75U7?=
 =?us-ascii?Q?IK5v8XC0Yk0WNDZctaJ/WREZB6r7Vb/UGhFpgkQcBXstg0aDhmLhkxXfDjln?=
 =?us-ascii?Q?86n3a5MbgrvtaHup5Utm+V0jaWfPMb/Y8Ftwbi9Z3+Fx27xXf8Y6Rq4WcWgB?=
 =?us-ascii?Q?ctQ5wmzSVbHj4i6nb0APoAikuqq9X1K4Osyv7WGvgW0f8cWwXZFVpPpl8F1n?=
 =?us-ascii?Q?csXAE5yX0TfkU0PDiuSjwHl2oOTrLWKYw0a8D8+7PDahhTks1XChbaCld7oS?=
 =?us-ascii?Q?O5SJTqA5t/Ykuu6KJDFa0Bhj7Epr/AnJu5bPVzVgrQ4nCIjWRY5HEFiVQlf8?=
 =?us-ascii?Q?v5AxX/rAW38ev+7OwTYttyrjcyZUflAxEZviEixbxhVnrq1ft3/vDry2rVoN?=
 =?us-ascii?Q?xqv+gYZChFy/EBLcHpWnSSJTpZsSWAkR+6GieyJGvVHVqXXWRWazdKZMGYTw?=
 =?us-ascii?Q?d2/Q8mKghwDMCusfW+DKprIowB2foI6DZYG5jsSw5WAFSoLgFCI7WQZbt5R4?=
 =?us-ascii?Q?Cj4qfgQfLLxpxtw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+4ETv0yn+zAzxU0VHhGk+FPqbq7rHbhHh2blPrZOFyiEp8rn6I9x36xKoYBd?=
 =?us-ascii?Q?fClq8QRRc2WH60jwA7xfrA1+18wMRx6cLJh0Hp3dF1YoaacH7maCh37UUqqp?=
 =?us-ascii?Q?ZsX+HwAnARnhETiLB90vAVhOzAgpksWiZtZ/4t1cNU+/aDqSQIRV4pIbMNGy?=
 =?us-ascii?Q?9SilrST/uvS0k3U6/BIVU66ZAHIjVx1mGikPWHGLQLHUNYjim+c3BxPr45d3?=
 =?us-ascii?Q?EoM2b10ejlKmMm/kykLf6/tc2uMBofhGw1pTiaNFn2ugVBxP1mUNIxd+OFcW?=
 =?us-ascii?Q?L809h8afMspuWAuInT6TeFKQytFc392Tl4+pekHUky9rtWEgDuvde0NzOC71?=
 =?us-ascii?Q?O8jY/43+j2Bkbd96fPdEeniTPn2GEbRTsVs1zOcU0lbqJnupCmqQ6NL2qygm?=
 =?us-ascii?Q?dPLP3BOA8WppvHwg3DdbZZsycFIi8LxYfIJJ3KizQ7AOX5XkpWN3LIlqh38I?=
 =?us-ascii?Q?/TQK2FPefpuQeBz/08IekFkQ8B2wSpGPO+GzqFItYwN2naqhCdw1rtSevaFB?=
 =?us-ascii?Q?4vKWzA4x8/ozmSef9hseLXqqA32Y3cfPSJ5mkklNWZcGW1JIjYHCzT+SnNkz?=
 =?us-ascii?Q?wFy9KwGed5Q0dnlb8behWvAi8BJvakC64s3z8eSSW9HclNMiaTMUGiTKHp6J?=
 =?us-ascii?Q?zV4SC2/YlJoSKv53TXgDX0earNvzmajtJevtSAZ0V+w/SVfpv49pIy5soJAw?=
 =?us-ascii?Q?fLyl3ubc2xLKAbK2zaJyFGKmvJ0SG1+hP72bHImUbgPnAR0UFDPKhVXYn4qF?=
 =?us-ascii?Q?ujcAbqKNuh/zqGkk1MMjdHswIqnC5HyeEc10GhtsEXuNOaAtup6sTUmiYuA4?=
 =?us-ascii?Q?YD3+DuUtytt2TXbkXFA5/Jk94la2x7sGExEcDXZdg7USmJ5pGEp+iIfwGMGW?=
 =?us-ascii?Q?fTzfL1h/9mO1F/Rie83bMIdfxDDUrov3OVVG6Z7wvvfpIqglmwKEvMaJskhg?=
 =?us-ascii?Q?qBBE0A1dW1miE7kMe4p0bt0Maqtq+G9XWcEZw5IzyeMBRmE4Oyrrd37iC5s1?=
 =?us-ascii?Q?jvk25HSat4tcraw7fJR+qQs5KuXo4/q6EyvnEq3+DZ+INyex1XhctVPKZepK?=
 =?us-ascii?Q?e8Fb/+oyK0ywTQ/bagrrBUSiYn8rN11YSKmzRpCppujiyNs0qaWGaCohhVZx?=
 =?us-ascii?Q?mO7TxIPbAsKvTjD24EJtyMXeOFdccT3QLEgJMUul2HPtJhQNJmZtpK93N/cb?=
 =?us-ascii?Q?jjUu3tX2RzJ87d1/TKzo7/6/HS7iVwe1c0bG4n7V/txGicaybfuvQkMbXD4s?=
 =?us-ascii?Q?7tBOieQB0z/VNfIdxIZHFo30keUGj/UsCUSjzCqzIi70F3mFm8GgApmH8LJe?=
 =?us-ascii?Q?U7nwxdGdstAVDkgD1IHLkN47Ul5+ONHTHHiRp8K4w0b9Vz4JVjBFdDeW/His?=
 =?us-ascii?Q?jrfx3i/G12V1krqnRQ8PFHyPfWZZL/T73nAJ9bGOVc7zY5YWLphuMX0qj2F1?=
 =?us-ascii?Q?PxzDD1pT5UrVZ5BkZrHUJ1Dk9BNapRQpt+/jCczAtXfb6WM6TN++Ppf1IZQn?=
 =?us-ascii?Q?+g/zzYFvwx+jw36G82MWOkryPD40mUGla3d0qgEVQVjJYEy4J0tZEQfH9eQw?=
 =?us-ascii?Q?KKNDHMcFG6Io/nlsqHc+7eWNEtUbOtLM8aAvWWkx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b1ee6d-3c5d-4049-9ab4-08ddb3279dbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 14:01:28.7739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 57ZtokIUeMrnXQPMAHyj8WRyhI45luCGx+dR9mOXMReLGAZm39p4zL5YnJhyXE/rs+tmlrZspUz+chbh25BVtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5164
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDExOCBTYWx0ZWRfX6DvmmT8778Yg
 nr/WEu4KsZ7az4Tl3f13R5nTPwbo7tQJA8AJTUdgsStiDCuvqCDYXa+209DJCvDfdpxiXQ7v45S
 rzvfbAClLQXScETb88cbC6uFenk0mol8U6wpB/6SabG5BGBfO32aLGAKyORTUnEiK+8Ps6HLkd+
 0sPwnmN6vnyQVpJ+VaK848A53Nvur3eXF7wdk7RpBOsDUxCY8Lts2qiOM8qM5pWpUsRRu2IjcLI
 DY3L+NfrZC80wZbwGJagnKhGBEC9hgkURxWjrVeKwE+3Lq+3UfnBboJDQ5dXUdvUqfH+BlsgZgY
 E4OgOle5iW8XOlZzrC/0hhneUmYMeVaTnT+y42o6hXV87aBiSAQZ1Sqe5uhS/ah6dnPfXpW26uk
 Ae0k2+OlBWKt1gQu2w2aDpTXIKLiW1Flcj2QzGuFR2RASj+du89mOdorK4+UIDo8nPxum/hy
X-Authority-Analysis: v=2.4 cv=IPECChvG c=1 sm=1 tr=0 ts=685aafbc cx=c_pps
 a=yjLXpF3nzAGyQzzFVx12ag==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=yn0K7mMhma4_TiNU2RUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: p7TTxqpHQ5wyEP0yMxZ5YJF5djEgKIlI
X-Proofpoint-ORIG-GUID: p7TTxqpHQ5wyEP0yMxZ5YJF5djEgKIlI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
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

Recheck-request: rebase=3Dmain, iol-compile-amd64-testing, iol-unit-amd64-t=
esting
