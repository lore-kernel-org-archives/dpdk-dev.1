Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EB9CDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 20:03:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 325244027C;
	Wed, 24 Jun 2026 22:03:28 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 4E76A40279;
 Wed, 24 Jun 2026 22:03:27 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OJlSN6404586; Wed, 24 Jun 2026 13:03:24 -0700
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022095.outbound.protection.outlook.com [52.101.43.95])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eyfr7f7ua-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 13:03:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMu4bipA75gu2WoGldRoUbXsL61s7aouMAZRi1uiHna7bGfmqhw15Nd8eGEkbXqo+tB11CMUWYYypJYA4G3/vAORi0pIWy5xDzrJ0XaRp5jPuvEDaljKWY0m1MGmxU0KkUQjfyWfiYlBNvZbQQzs3Q+Bq1XWMDVwYsvCpxJDx177EcX/7raTga3fSQ8W3vmobG/xhn3VIvdnrwzNJKqscPdoJeO5F0poCCrnVxFyqsXHVdbenYTKKLkOzuCyOT3utmCDunH7o0dzYYP4Nst85zW069bNzCoZ+mD/Y1SGZqxJpwtT3+x5Nbuli/uKxOHx5KqL+R7+3SD5HXu8e/vshw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1pjKu9vxhix6sqdCYuBOMIZckQdWrrDaiCj8wuQG2s=;
 b=MP1Y0g34FFWoW0nRlPQ5BBvCP37/bMrYSRKN0c5G2xg1igDK/OmYMu2UVixqhUUtySIJMp4NeIc6wIofa0ND3Pffydrbax9I3KcUl/Ii4NWD4x3pk9gFMXDjS4WPTEWdHnomIXbVbZUl0kVor3UzUIxgMOviCO7z0sjUFfk79MU1qxLf7hgULXSA8i2qzXwUE/Fvt/hs673ote118UzBBXvbFh99C02sI2DansObKxrirXpekzMBX9omRCmptl2qIfPxXwGM6Mu/96uXaSwwasKAgIYUjbkh7fmS/1BtiAi7Bn9S45NQKIS+caaGkOUpgxSeE3B3QkA2UP1arGqVeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1pjKu9vxhix6sqdCYuBOMIZckQdWrrDaiCj8wuQG2s=;
 b=k6WboC+53x29ets8K84ftLkAx4stcvKJsMDErNW4RfgUdw3siiD2LStEAIki2AsnYGG2FQGMz+xDPLExPfeXUzuEq2mpNugGwcoT2gWCbrMmWnpIugq+xfEIsDu3rDIw+vrgQgAYJC6swmyF7X2zwCIIjbh12wPThvu6KnqPl9Q=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 IA2PR18MB5863.namprd18.prod.outlook.com (2603:10b6:208:4b2::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.12; Wed, 24 Jun 2026 20:03:20 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0159.007; Wed, 24 Jun 2026
 20:03:20 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Cristian Dumitrescu
 <cristian.dumitrescu@intel.com>, Radu Nicolau <radu.nicolau@intel.com>, Fan
 Zhang <fanzhang.oss@gmail.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>, Jasvinder Singh
 <jasvinder.singh@intel.com>, Sergio Gonzalez Monroy
 <sergio.gonzalez.monroy@intel.com>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>, Declan Doherty
 <declan.doherty@intel.com>, Alan Carew <alan.carew@intel.com>
Subject: RE: [EXTERNAL] [PATCH] examples: use strlcpy and strlcat
Thread-Topic: [EXTERNAL] [PATCH] examples: use strlcpy and strlcat
Thread-Index: AQHdAybBt/nG0aHrhE2YkJ6cm3BZFLZOIodg
Date: Wed, 24 Jun 2026 20:03:19 +0000
Message-ID: <CO6PR18MB4484C79ABFE3B22ED50D5ADED8ED2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260623154109.722441-1-bruce.richardson@intel.com>
In-Reply-To: <20260623154109.722441-1-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|IA2PR18MB5863:EE_
x-ms-office365-filtering-correlation-id: 09c0c080-a433-4f06-ab2c-08ded22ba357
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|6133799003|38070700021|18002099003|22082099003|3023799007|56012099006|11063799006;
x-microsoft-antispam-message-info: rMbOgUsUEmIpuZ4WvqjW9RhgsvZK9Q4DKE/pGk5rLJKP6NyLsc1QMrsH+1WnseqTKX/4EjgcIhy5rF5iSeeqUzyjRkm6qoyUbxIQQ2fW/VCmd2SMw9YDC7WUAGWdx4/1NvXbEtg9BzvXqDzuemq12v7u4w6WGqpWq1GR9o5iHAWFguhOK/xe133KKg8YbuoPBUisty3EoIZG3JVPMrp7ovQJBpLOTOZpiW05sNUa8lvJX10ocnVMND6szfPMUj0uKvQhQ4DxWEFG4ja9yRE3abK22JBFkAa5YY+9K/STAG0Hwy81sxFib6atEQGkGR0LVJjTXyHidxG7/zhAoQZOmxL5hKG68uWeSPUO+1En/t9dOT3RsyMiDdKAuqrILJ5r3KZEUJ/ItRG9uiHQnzM7CFiPfATpv/CmIfK5mPht8MmE4r5PsVdbrkFOTVWAJH1YF9BooKZaV4VJ3n+L8VA2LpJ0sA9LhnhHZtwMW4MR5Whz7vLXlT8thApNjzgM2fRMd8bK5lKf3LPRKX/jp/J8LGctzqTr0zHq8/GowPx7i1vKnx4uCwQyyXGhRf4p8DncKm9+K2Pq2pud6l+r4oH2PjqU98Q0Xp8RRnx3MAId4jBVi1T5wfRiGciJxT6EtUV3kNIjFkl/bS+hZkAWUEJNYRUCOlSUm1eL01VIlY+E8o4SeUPt4PX0uMKwsWYLUIDfswrZMdOzuCUBkV8JiEs7mpKYy2G6kojZY8iIAlJ0Jp4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(6133799003)(38070700021)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZERJUXVZa0NGYlBQWVRLZU14bG9PS0F5MXJoLzI0bUhDZGpRcUZPeHlBbGR0?=
 =?utf-8?B?UVgxS3dEZE53V1F0d2ZwM2w3RUVkVk1iRm1FemRpRkllL2dkYU1mdmZyY1M4?=
 =?utf-8?B?RjgyZHhtaGJrdHo5U2VnNkNQbklkaUZzM3RGVnR2UDdiVDBKcE9wK0JuRXcy?=
 =?utf-8?B?MGc2QTcxeEFtdWVSa3FyZ04vY0RvcVFseVZXQnhkUkdwYmY5OWtsdVhZQk9L?=
 =?utf-8?B?eVp1OUdkTVROMHNCa1hacWppRUYwN2NweDdranRzQ29qV3lhdDZEL3EwbWpv?=
 =?utf-8?B?Q2srYVFteEtXdmlteGlsZ1N4TmVOYnRuVS9FbW50Z0E4SUx6U3Z6eUg3Z0pZ?=
 =?utf-8?B?RWljQndnaHE4d2Y2bUI1dTdBTDd3S0ZaUVA1Z1BETlE2cjlWUG40ZmlXa2E0?=
 =?utf-8?B?aUxuZWp3Q1Z2dlp3MUw2cllXM0lFYjc2aDdqVHMyRTV1TE1aQVRYOTA4NW40?=
 =?utf-8?B?NC9SbXQzZXlXY2dhRmpKeE94cjZzWXRiT25zQmM4YkwwYnR6ZEwwNllxYVdX?=
 =?utf-8?B?NTkxUWo2R2NzYlA1dnJTMVhTUVF6V0dxSU5IbWM5YUsvVHh4OUNNMHBSZWZH?=
 =?utf-8?B?RUNjcnlBRkVqN1FpNi9OYXQ1b3V3OUxVcnRFSHFqRGRiRGZZSDBUbW0rKzdi?=
 =?utf-8?B?d1ZCNGVybHlPM2hPRXJRb214a1JteWdMMzduekpsL2VqVTZJVDFkZ21OdWI4?=
 =?utf-8?B?NmlXYzdNRVZWaW5ZZ2EyZkpDNGpOUDVjVzRoOFlQQzM5NXFnTmlTZlJnOXpH?=
 =?utf-8?B?ZGVKS2pPVkJPdU8xblV1WGFXQWJnTXJ0bE1zVVcrakw2WGlwcms3NEF2WjlE?=
 =?utf-8?B?TU5oRnozaGZPM2FHU0htWmdqcXgrRTF4T3YvZCtEUUFUN0ZDMWpwRXNkNU5s?=
 =?utf-8?B?dldhYW5vV09uOTJnMGFsNHB4Y09SSnJSUDFLTEUyUjZHYWd4TFI5MVVZUWFL?=
 =?utf-8?B?ZmZtcUtna29GWnViVFVUVWhUaXJrczlmeUpIcnhSblJuMW8xcm9RajEwOVRG?=
 =?utf-8?B?Z1NORlJLWDNkVVhkNHZkTXZjWnRFNURCK1RkMkIzR3FWVmZtYzdOblFzZG9i?=
 =?utf-8?B?aXRRamNRRGhxdXhjT3FFU2I1Q1F3eWxHZm5XOUxqVE42TEtqMzVGeXBIM1di?=
 =?utf-8?B?ZHNKc1B5YnZlMm9JNWpsck9RZGw2M3pYOXVCZ2tIZjBPcTFCM2pxbTBnQjdB?=
 =?utf-8?B?WEs3N1pHTlV0RUhBRXF2dnphK1Y5UmVMQVdyeS9lbTJJUXZQMW9VVmxOelF4?=
 =?utf-8?B?L1lhelNVbFZ5RFYzdll5ZWRicHhWWnVxSmxldlFvUUpmamlEM0ppMDJSc2xr?=
 =?utf-8?B?MjNkVFpuNjBCQ0VuVjBJYVJJRXpXVDd2c0RBRytmb1RuZC9KQm9mUzBndm5h?=
 =?utf-8?B?bEdQV3BzVE4vRHJDQnJPWGgrc3lteTlsQ0lOcmdWVUdmY21Qb0ZGcC9nMGVz?=
 =?utf-8?B?VzN5NzQrZ20wV01TWlh1aXMyY2R2NkNBaUxsMmY2SWZSYWF6cFlvQXBiUDNo?=
 =?utf-8?B?NVJDMkxWRjN0UElBT2lBTFJLR3d1Y21zRVJCV2RtOFJpV2w3UGMzWHhRcE1P?=
 =?utf-8?B?QlZFb0o2YVQ4WFB5K1F5RzFXVnVQNEZ3OU8wUnJIcFBpbUNJdFBtSHZxWmR4?=
 =?utf-8?B?SjBHbnJodVdIdHl1ekxuQnVwcHlrTk1LZGN3RGRNbkNjbHJTekkzV1I0cUE1?=
 =?utf-8?B?NmcxYXlpMStkVG9zYXVKMFY1elFveXJXMk90c3VCTEtraXlZVUw2bnU0cjhV?=
 =?utf-8?B?aW5LVkdlcW04azJBditubG4zQkZ5RzBzZU8vSEdyZjhDS0Y4VW9JVnlQYUVI?=
 =?utf-8?B?SUw2Y1JnNmZpdWZJZWs2ZDVuZnAwWEx6VDRsYkY3YlVlbnBiczZXcTRINkdq?=
 =?utf-8?B?b3ZrdDhTNWFvSm1uVThIbm53aE9BZksxOEJHZklEeFNpcjlVKzhZNnRtOWln?=
 =?utf-8?B?UGdHTmVJdFZiUUdhT0hpVm5ueSthWHpFVDFrVEFhVlQ0bThPcE0rLzMvbGJ0?=
 =?utf-8?B?SFdMNHJuN0t5RFhPTzg3bkNOdG5rK0hyNmd2ZFBna3JKSEF4cVJQNklSU3ZD?=
 =?utf-8?B?YzhMakhQeXFlaW43Z1h6NEFYd1NOR3FDNHlOVjlRaUhueU5iWmtTamMrTEgv?=
 =?utf-8?B?VHRZTDZaZTVYdFNBbEk2bW1ZMWVDNjRUUUgwNWdRNmtWbHNuVFV3eFRiNjFZ?=
 =?utf-8?B?Q2NLeVozNnlORGY4b1huVXlXTlhKS1pJUUJ0eE1pZWd1akZPcUZOWXpBdy8x?=
 =?utf-8?B?K3VvNUMwMEtFQTNqT0lSUWZvb3FBY3ZzKzRkeEVGSXd1aWUvNFBaY2tuY3pV?=
 =?utf-8?Q?yGZihdgHsbzhwDIasy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XbsnaUCHmhSwfj3q9y5g7xehqWCfuKp3+b6tTqv88wFgG0/8mVjuiPFy8g2rYBWJP5lBPVFlFTlpsxaxbn8Zckpg7SzDBL6G6ktviGq/EqO2aqE5F8QioKIxdAm/tnvxWpfEeQbZHLGBZRPAqYBrtp28qMq4GBhI0KFcK93gmm6y9LjxhK5y48LkaL5p9nqqpku2nylZtUpZ5AyfcI+2B8n1ZOj5OLFTglMP+kIzZRJ6TB/PqN/SqlITPn7Lk/Vxw2cCoom6e/zdnfjfpNJbS1+6nLzLRh3mMSED8bSS7b8774JD47P8kE48HkfbHycW0pHjSu8WIl3ouxkEkVXFBQ==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c0c080-a433-4f06-ab2c-08ded22ba357
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 20:03:19.8329 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ednH/xVLMD3pJsMR+khMSR0+iDyv5T4Y2Dg4pCauWIZbObNaceUAlJXxydzhmzOaUzjSwxgxEWclKCauCT465g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR18MB5863
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE2NyBTYWx0ZWRfXwF0EZAwaDvxV
 Rl4qGTHDpquDfvJNmKlnEYSJOn0wREkLtRhdiF4B3pnXYlOinn6zBCjICaIuzp/aIHvjmWr+So8
 lVqBNshQBnpnTVmBGe+lslHlTfHII4k=
X-Proofpoint-ORIG-GUID: G1J-40MeIbb0UapOKpm8_3ysnI01BNoO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE2NyBTYWx0ZWRfX9ngXNRgt8JCw
 IuGJ7qKnF9MqGwOnLedsMYfppTfOCNvU3HK064DGscWdtEcC5NJjgO5GWnffdQSYbcicHdWn9rg
 Zfk0mzikzh+GHt5EnZv6uLBY5zE4CIQtFqGxdmhdtYfhveavKBKM0uzGCJBQ/QEd4RGw5EIqQDN
 FOSzQqFfuW0MF78XPUEvKYX0O+0C4f2EYL+yXsTnNWycgX+On+YOPSz+kEZSq0KEjikEl7GPubD
 hMc+GfC46roR82NNlTTmN+VBVItL9o0wPxEx6dh9RYqbJ7cjzD75pQdwUdFmzRRH6TeWMZboUav
 vSLJlW2y3RgvbExUUJiY+fEwwjC9TBBWPLZTviffX2YrrdOdY2WZbnXBcn4dl6zBEQXkKxTLocN
 oDNKB+SbFouz2fMm3ltfCCmf5pPGBw==
X-Proofpoint-GUID: G1J-40MeIbb0UapOKpm8_3ysnI01BNoO
X-Authority-Analysis: v=2.4 cv=UIvt2ify c=1 sm=1 tr=0 ts=6a3c380c cx=c_pps
 a=kkxl9DAbGs3C2F6ePkv26A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=8rWy6zfcAAAA:8
 a=QyXUC8HyAAAA:8 a=BupwlckemCiVUoRMUgcA:9 a=QEXdDO2ut3YA:10
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
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

PiBSZXBsYWNlIHN0cm5jcHkgYW5kIG90aGVyIHVuYm91bmRlZCBzdHJpbmcgZnVuY3Rpb25zLCBl
LmcuIHN0cmNweSwNCj4gc3RyY2F0LCB3aXRoIHRoZSBzYWZlciBhbHRlcm5hdGl2ZXMgc3RybGNw
eSBhbmQgc3RybGNhdCwgc28gdGhhdCB3ZSBjYW4NCj4gZ3VhcmFudGVlIG51bGwgdGVybWluYXRp
b24gb2Ygc3RyaW5ncy4NCj4gDQo+IEZpeGVzOiA0YmJmOGUzMGFhNWUgKCJleGFtcGxlcy9pcF9w
aXBlbGluZTogYWRkIENMSSBpbnRlcmZhY2UiKQ0KPiBGaXhlczogNWY2NTdhN2ZiZTg2ICgiZXhh
bXBsZXMvcGlwZWxpbmU6IGFkZCBtZXNzYWdlIHBhc3NpbmcgbWVjaGFuaXNtIikNCj4gRml4ZXM6
IDgzZjU4YTdiN2IwYSAoImV4YW1wbGVzL3BpcGVsaW5lOiBhZGQgY29tbWFuZHMgZm9yIGRpcmVj
dCByZWdpc3RlcnMiKQ0KPiBGaXhlczogMGQ1NDdlZDAzNzE3ICgiZXhhbXBsZXMvaXBzZWMtc2Vj
Z3c6IHN1cHBvcnQgY29uZmlndXJhdGlvbiBmaWxlIikNCj4gRml4ZXM6IDYzZThjMDdjNzI0NSAo
ImV4YW1wbGVzL2lwc2VjLXNlY2d3OiBmaXggY29uZmlndXJhdGlvbiBwYXJzaW5nIikNCj4gRml4
ZXM6IDQxZTk3YzJlYTllNiAoImV4YW1wbGVzL2wyZndkLWNyeXB0bzogZXh0ZW5kIGNyeXB0byBp
bmZvcm1hdGlvbiIpDQo+IEZpeGVzOiBlOGFlOWI2NjI1MDYgKCJleGFtcGxlcy92bV9wb3dlcjog
Y2hhbm5lbCBtYW5hZ2VyIGFuZCBtb25pdG9yIGluDQo+IGhvc3QiKQ0KPiBDYzogc3RhYmxlQGRw
ZGsub3JnDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCcnVjZSBSaWNoYXJkc29uIDxicnVjZS5yaWNo
YXJkc29uQGludGVsLmNvbT4NCkFwcGxpZWQgdG8gZHBkay1uZXh0LWNyeXB0bw0KVGhhbmtzLg0K
