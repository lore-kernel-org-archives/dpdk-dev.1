Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFAAC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 04:51:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D678340E3E;
	Wed, 21 May 2025 06:51:36 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
 by mails.dpdk.org (Postfix) with ESMTP id 43E3040E34
 for <dev@dpdk.org>; Wed, 21 May 2025 06:51:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdmybpdjE2f00YSN2/oaF2mnbeqkY2JEk1oOQxZU84/6hPpyM2cXE1sRa5qnFoDcRjDx1YsQdE0v5mKXuOi0cIlaR0PltnEo9xqmLIJtgztaNVzxVYzX5rLhIRBp2AfbQHas3BzNCTLNKgftMZXkN80yvx11Y6gK64CUDvcG2Yof6+/4+TRixJWZD6QoH1C3EISEypHTe7cNW0i9CmtAEark3UaMgVpRYaSQR0Zc4yhCkB58xXrR0YOZMcix2Nnf9YFEZwT+HYz8zVo+woNtFwGKKox50HMQqjExb2xvR5YpZ/W95CwHXsFJgB1FTL6nkkhlZSWu2fP9C/xbpUlYsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20OoLICVqbIj1yPS3v2LFik1wBc+IdsFP7IqZ/N4YWc=;
 b=a3tAqTgCRILnRv2M0DGrdZKjSxpuIsZW0SaTahVwLXgT3OCaYEl1385uRBVz4RKkEAeK5UDWpFcjx4t+UUCyfOWquSpdxP8/kcZ9P93CNQcoBi4UbrR19PbamZwYFCuafAoP+2BdoEzB6vcfargCES7MNR/PxgnVoi5gitAVmmAX8nMDkwb5AP+q1h5n3el57SCTMW0CdnLb2gzLv/3sL1TjdNuyYTCUuhs8wVFBT5FM6UFb+HUDYVMHZiCJt7BahJeZHotV3ZvqlQDT811INJrmtF2ISqv7mpQ2Ske29GxVBhvJpgORyVN8qtRxhSrBrE89LzRDRenzhWCwuA4cbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20OoLICVqbIj1yPS3v2LFik1wBc+IdsFP7IqZ/N4YWc=;
 b=i/Dl7dDckJhncwk1CwK2ExW0Bc6ErtllEswz/0FUm41tnJViijFY5Vn5HkEZLi1yeclLqXwExyKLi7d+ksbtWP08aeTFuykegXN2vFEqIw96lK18exJlHfO+thgEEpBZw+MVuQLHpp1e2CUQDeAnkWVHDLe7EVAJpnFzB/Jx2+BR4Sp7FW3aN5E4rpiTlcR17d2zLng+ACm/iauV+0idfx/IEqUijgfLixFHHSzw0BVCE1ruXOq92toAG7NVy9wotfARA0AMzfFS5Y/XZGWLpMVQqgWb6Oq7nftvNQI7MEGRm9om8xPuzQRN3VR7JOrq5g7O6PQkoWmsA0PQ+vbBUg==
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PA4PR04MB7823.eurprd04.prod.outlook.com (2603:10a6:102:c1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 04:51:34 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%6]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 04:51:33 +0000
From: Gagandeep Singh <G.Singh@nxp.com>
To: "Hemant Agrawal (OSS)" <hemant.agrawal@oss.nxp.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: RE: [PATCH 6/9] crypto/dpaa2_sec: add null algo capability
Thread-Topic: [PATCH 6/9] crypto/dpaa2_sec: add null algo capability
Thread-Index: AQHbyUtTmDY2r5CrcEmymybPU7u9iLPbC+wAgAF5X7A=
Date: Wed, 21 May 2025 04:51:33 +0000
Message-ID: <AS8PR04MB8198741771B80D7049E2CD4CE19EA@AS8PR04MB8198.eurprd04.prod.outlook.com>
References: <20250520055133.506071-1-g.singh@nxp.com>
 <20250520055133.506071-6-g.singh@nxp.com>
 <3c0a10d2-83ec-963e-66b5-34f7c0bd9404@oss.nxp.com>
In-Reply-To: <3c0a10d2-83ec-963e-66b5-34f7c0bd9404@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8198:EE_|PA4PR04MB7823:EE_
x-ms-office365-filtering-correlation-id: d1f44b47-36fd-4d8f-4a11-08dd982328e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZnFDUEh6Q0FQZ0FVcTdOYUhrN3MrbW1BUmdMN3BlUkZpTER1dTAxRjZCclZo?=
 =?utf-8?B?MDlEM1hhQzlCSk5YVWYzWkk4NFdnRk9Db1NuZDE0Q21hUi83clViOUFJd005?=
 =?utf-8?B?bDBuSGlucUcwTUNXMWFDNWxkWUxpZ2ZoVUc2UE5ROVNjTGxEQnZvbmRiMXVC?=
 =?utf-8?B?bmo2ZlZleTNEVzRWWndsZDBHdFBtclVIRXN6RmlZbHBSMWVhWUgra3BJN3Mx?=
 =?utf-8?B?ejNoQmVmMFlRRUEza2hzbDk1Rjd3TXN5enpzTGRtbHpuWHM3cFUrUGJGckRR?=
 =?utf-8?B?UnFUUEI2Z1ZIbWIwbmM1dm5jMUt3UFY4WWYwV1ArSXRvcS9VeVRNYnhBQjVR?=
 =?utf-8?B?blp4UUVYNE9EL25QdGM5RFNFVlB1REwvQTJUNVRnQlpQaEpNN1dsVnNDb0VH?=
 =?utf-8?B?T3lucHdKcDBTOFFoak5yeVlGYmQxQXRuT1RXTVNjY3lUczRTSTN3WUttNWtl?=
 =?utf-8?B?V1pvT2hvMWhteENDdWYxMmpQdXBGZXdaNE9hQlJzY0hUalpFaWlyeVc1eDAx?=
 =?utf-8?B?bEw2VXFDQi9JOVFzL1FlUTNlR1c0RDB1Tk0xT0gvVnljUHYrckJnUjVjbWJ0?=
 =?utf-8?B?QmNEa1p4VURwT3c0WnRPSlRPUnhpT08yOUZSZEE4eHVzUUJJYlpnUCtLMmtX?=
 =?utf-8?B?cXR6U2RhZW1NeWt1OG0zeW9sblZNR3NkbEVDOUxjSGdndm9heTBETFNscE5P?=
 =?utf-8?B?a0toYjZmZkpSU2doVXg5Y1RoVHgzK3g5V2g0Qkdkb1dCdnBMVmhPdk9LWlVp?=
 =?utf-8?B?VW11dXc1azFYTDRTRUk0RWI4YWxBazFDK00yWEhBTkErZ2Fzc3QxYVhHT0RX?=
 =?utf-8?B?UU41MXZXWWNIblBPUVVrWHR2Q2Q3dVNZQSs4ekhwZUhRVEF6YWN4eUlmbWdl?=
 =?utf-8?B?MitKL3FLZjNzU1ZpSjlrQk52NFAzOGJaTnBIc1N5a1UwZ3VlMThYRlBIOERy?=
 =?utf-8?B?c3IvR205eGtjbzI4Yk42MVZCNDF4bFhuWjFIWHBjZys5NlM5aE41SGNHaHk3?=
 =?utf-8?B?ejUyd0FrbEJYS2pFeUFkcVAxYU43VzdDa3BBZjJ0RmpXbUhuVHVEWU5nbzNP?=
 =?utf-8?B?OWhGV0lFeFVLZDE0T3RmNTJYOGxkNDIxNFluNEJCWUVUMm03aDFGUE10SHV5?=
 =?utf-8?B?Z1NycFRWdGhaVEVlTFhHVGdiVVZxY3ZCTFpGSG9RdG5PZVkxdDIzMHhETzFW?=
 =?utf-8?B?aWZxeHVWTnBabit0RTVIeThVMGdqdGw0REt0R012d0lXcUJ0TTRjMy9SY1hR?=
 =?utf-8?B?SnB0WWNQUmtDR1BmMmFrUytwVDVUY3FkZ1l2bHIxS2dkNUlSZ1N3KzNKazVL?=
 =?utf-8?B?Q1NCUE9FZVUxcUFZdGp2UU1FaDFQWmkySlUxU1MxUFVjL3FaV2JyK1hlaGVv?=
 =?utf-8?B?WHhLcTAxa3B2NmQzbGcyZkNPZEROTzZ1K01RQXhqQ0JJcHAzQXh1bk9YNWUv?=
 =?utf-8?B?Q1orUXoxZUY0WmhlOGo5Qmo3NjBic2l0dGs4elIxOFNtb3FoMnZHRkZxK1Zo?=
 =?utf-8?B?Rk9TS3JZQ0l5d1VQc1k4RUh3ejVPanpBa2RROGZMcVgyY2hRZ3dyVnJ4cGVi?=
 =?utf-8?B?bHA4VUcvNjgwbTF1ODBISHNPQmZxbGxsempsU2lyaTBpYm9JZkR2azE4TTNy?=
 =?utf-8?B?TmxrWkhSdkZqcXRBUzZVazhRcHYrSEQ1Y3V0VTlQVGtnVjlhRjRIdktONnls?=
 =?utf-8?B?TFBGak5PRlUzano4N04rNmEzTCt0MUVkUFh2Ry9ZWjRidTF4MnQ1QjhFUXJa?=
 =?utf-8?B?czNHTk1sOTRSZGVoaVZJNjV5bnA2SENUMHdBVnFleElLWlZqUVZKYXIrS3NR?=
 =?utf-8?B?aWtXOExYaFlwVjNvSzRUVVczSGdNY2kwK1hCNmF2MXR0RENaOWpYWDAxdDlX?=
 =?utf-8?B?R1J6cG53NitIMDMwQXZiZUdOVzFEREZsS2lROUo5NlZ0ZnVoK3hldnNna0NM?=
 =?utf-8?B?eW1FUVQ4ZU02NmZPKzVvOVE0V2dvZ29BTlVPclFpVnBNTEg4QWtuTk9DSDZl?=
 =?utf-8?B?VG1zQ0V6RmR3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnVZZGQxK2I4UjltY0RiU3UzdFdVLzhxZ1BnVDVUN2tnZW11R0RHYmo2cGJi?=
 =?utf-8?B?bWFNSFRmbktFNDdocHhNQTlDS0ZRTFVWbjRiNGQ5ZE9QbDR4eDVSRlZVMDU4?=
 =?utf-8?B?REdzbVF0bGM0QWpKRTdqdkpOWVpXb0VMcXYweGpGWkJOd3FXU2o1R0FTNEl4?=
 =?utf-8?B?bjFWM1JDcW5CcThKM09LcElyZU9NSEZnSlVqZVNNMzlSaU40NWhxMVF1OGVE?=
 =?utf-8?B?TDNvTk9NN2ZTRm9xdlBMQW9Da01CS1BtNmlTbDMrNUMvektMdUhmVTBWWnVR?=
 =?utf-8?B?djBSQ2FaMjNBdm5ZRXBMTk96NmZFbWxjNm5Oa0lXbi9vMWFIQVdzNjkrVEp1?=
 =?utf-8?B?RkIveU91QnV5SURVdFo2dlBwbGc5TzAyYkFScFpYS1E3Z1lpeVBaSElwaUtY?=
 =?utf-8?B?MlFVYXp1SW9QMzJEQUVQckVRYVJKaXUrbVRKdUVuaHEwVGFDdmlqWXViVTlx?=
 =?utf-8?B?Qmprdm9jMktBSmlweHV3SmdEc3hMM2NjNXNlRW50VmlKcnhyUVRXeHRQa0x4?=
 =?utf-8?B?dWc1MDlMM1NGWTZ1WU93bHljZzJIUWZ6bmRiMHY4cko5L0dXYmtibGR4a1FB?=
 =?utf-8?B?cDQwdWpURDBlR2FXRGw4OUxHN2JnWDdFd2RUWmUzYnVXZW80cUFMUDEwdGlm?=
 =?utf-8?B?c1Z4K0pkZ0YrU0xwV01lUE9GMTI1TmN0Wnh2TDdDcEVRbjRTUlFIR0gwcVpj?=
 =?utf-8?B?Yy9Ub2h0UE40aFBHR2pFcFZXNFdCd2hjVlBpci9XSjl5WGdNVkRGZTBCZUpq?=
 =?utf-8?B?UlNlNFdwVEZEd1JoSTJWenE1Y1J0V2d6ZnFMdWdBdGdKY2JEbDVjUUcxcVNU?=
 =?utf-8?B?VGNSZ0NSdDJrSjduSElQa0ZxOEE0dC9lYUtXSjFSeDJFTVlqS2M0STVubzdh?=
 =?utf-8?B?c3lscnk4NTlJbDQ4WmNrUXRiK2FWc0JQMHZrVEcvU0lUOXBVREtzeDlmeTM0?=
 =?utf-8?B?V3BrbEVxdlQ4cHBoRE93YmRDNmppRUpJdjVQU0cvYWdNSEdjcGhUMmZyWUxq?=
 =?utf-8?B?Z0JMalA1UzdGL3VIVUlmOWFyZWZ1a0NQWERXZ1VIQnlDdHgxdTlEc25iOHBK?=
 =?utf-8?B?VUhjNTliUkR3Q1NOMmNxem9ZZlJ2ZG1tUjl6djJ3MWJ5YklNT2Z3MDJja2xv?=
 =?utf-8?B?ZFFoNGZDQU9OTWZsMjRCM3RYZlBLZXRWeXNBaVNKVWdhNnZTemVuYytEY0hI?=
 =?utf-8?B?bDdyMFE4TmZqYjVGalhuMnF3QVNpWmJPeS81Mm45SXFYYnJ1SUZtanl3ZVU1?=
 =?utf-8?B?ZE9GM1ZrK1lqb29QVk9BV3IwN1pkSm55ZElQUDBlVjBoMVY3K21FaWpQbGgy?=
 =?utf-8?B?NDlyaFlNTzY3QXp6dlI5djBkNDZrM283N2s0QmlrdG55UVgvS2pvMWVqTVJM?=
 =?utf-8?B?cVM2WFJyMHZKcU9pY0pxRjdITXlpUkxmcytMdmpNTnlJQTVMZUNNWnRSQVdl?=
 =?utf-8?B?NlBGclZpdWN6UHU5cllIeUtoNDNPV095b29ZNk5SLzIzaEkwcDRJN2hNNmR4?=
 =?utf-8?B?MDNPM2N0TUNtQTIyMGV2QW1EcUVUL2w4U2M1c2g5MHN0Snc4UTIzSklNWGRh?=
 =?utf-8?B?MEtHdTVLSUZqalNtYzF4S3EyVzdmVnVFSktmK1RwU1ZNSFIzaXIrdWdQTkRp?=
 =?utf-8?B?UTdxbmZ5eDlodWJ0bG9uTjlKcjJQOHh6T3JGNFRrZ0xrc2FLUTBxTzFBSDF4?=
 =?utf-8?B?a1FuMlFDRGNXZUt1UXZoNG8wNVRHUDVOOFcxSU52NFM5WkFZUWFzejZQWGp1?=
 =?utf-8?B?YTNZZ3pzNVpLOExSSy9iLzVhVGJMRnVISUY4OFd5cXdPd1lMVkxEdk15TmNy?=
 =?utf-8?B?bGlnRTc1cUxJVDVYR3A3QTNiMmhITldEajZPdDU4Ymc5ZHJsUlFOZjZ6WWhm?=
 =?utf-8?B?RlpVZjlia2ozS3BkMWFXY3BhSnI4OFRYZDB3aUg2QklCRG5mMWpWdURna1gx?=
 =?utf-8?B?RUR0WnllRHVTaENwak1pSVB3MFlJNktHOThid3VVZnQwelhkMTlUL2xnVVdo?=
 =?utf-8?B?VFZYZ1VwTTlieUVQc3ppeUIwQVVLVFFva2dYM2hRTjM5eXhUZldCVU8rUUFP?=
 =?utf-8?B?S1BNSjg5SmpFRUpCUTRyTlgyUXc1d0Z0WUdVTUVBNlVLSXdiTGxob093Skxj?=
 =?utf-8?Q?Fnc8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f44b47-36fd-4d8f-4a11-08dd982328e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 04:51:33.3258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BFM0RIqLMhiNpN0zH7aF12iVEH91UkEp5jf5qBybnXvTPs3FvlUFoVoNsVhVGWuZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7823
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVtYW50IEFncmF3
YWwgKE9TUykgPGhlbWFudC5hZ3Jhd2FsQG9zcy5ueHAuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBN
YXkgMjAsIDIwMjUgMTE6NTAgQU0NCj4gVG86IEdhZ2FuZGVlcCBTaW5naCA8Ry5TaW5naEBueHAu
Y29tPjsgZGV2QGRwZGsub3JnOyBIZW1hbnQgQWdyYXdhbA0KPiA8aGVtYW50LmFncmF3YWxAbnhw
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCA2LzldIGNyeXB0by9kcGFhMl9zZWM6IGFkZCBu
dWxsIGFsZ28gY2FwYWJpbGl0eQ0KPiANCj4gDQo+IE9uIDIwLTA1LTIwMjUgMTE6MjEsIEdhZ2Fu
ZGVlcCBTaW5naCB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIGFkZHMgTlVMTCBhbGdvIGNhcGFiaWxp
dGllcy4NCj4gRG8geW91IGFsc28gbmVlZCB0byB1cGRhdGUgZG9jdW1lbnRhdGlvbiBmb3IgdGhl
IHNhbWU/DQpZZXMsIEkgd2lsbCBzZW5kIHRoZSB1cGRhdGUgaW4gbmV4dCB2ZXJzaW9uLg0KDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBHYWdhbmRlZXAgU2luZ2ggPGcuc2luZ2hAbnhwLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvY3J5cHRvL2RwYWEyX3NlYy9kcGFhMl9zZWNfcHJpdi5o
IHwgNDEgKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0MSBp
bnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcnlwdG8vZHBhYTJf
c2VjL2RwYWEyX3NlY19wcml2LmgNCj4gYi9kcml2ZXJzL2NyeXB0by9kcGFhMl9zZWMvZHBhYTJf
c2VjX3ByaXYuaA0KPiA+IGluZGV4IDFjMGJjM2Q2ZGUuLmU5YjYwMWMwMzUgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9jcnlwdG8vZHBhYTJfc2VjL2RwYWEyX3NlY19wcml2LmgNCj4gPiArKysg
Yi9kcml2ZXJzL2NyeXB0by9kcGFhMl9zZWMvZHBhYTJfc2VjX3ByaXYuaA0KPiA+IEBAIC0yMjcs
NiArMjI3LDI3IEBAIHR5cGVkZWYgc3RydWN0IGRwYWEyX3NlY19zZXNzaW9uX2VudHJ5IHsNCj4g
Pg0KPiA+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBydGVfY3J5cHRvZGV2X2NhcGFiaWxpdGllcyBk
cGFhMl9zZWNfY2FwYWJpbGl0aWVzW10gPSB7DQo+ID4gICAJLyogU3ltbWV0cmljIGNhcGFiaWxp
dGllcyAqLw0KPiA+ICsJewkvKiBOVUxMIChBVVRIKSAqLw0KPiA+ICsJCS5vcCA9IFJURV9DUllQ
VE9fT1BfVFlQRV9TWU1NRVRSSUMsDQo+ID4gKwkJey5zeW0gPSB7DQo+ID4gKwkJCS54Zm9ybV90
eXBlID0gUlRFX0NSWVBUT19TWU1fWEZPUk1fQVVUSCwNCj4gPiArCQkJey5hdXRoID0gew0KPiA+
ICsJCQkJLmFsZ28gPSBSVEVfQ1JZUFRPX0FVVEhfTlVMTCwNCj4gPiArCQkJCS5ibG9ja19zaXpl
ID0gMSwNCj4gPiArCQkJCS5rZXlfc2l6ZSA9IHsNCj4gPiArCQkJCQkubWluID0gMCwNCj4gPiAr
CQkJCQkubWF4ID0gMCwNCj4gPiArCQkJCQkuaW5jcmVtZW50ID0gMA0KPiA+ICsJCQkJfSwNCj4g
PiArCQkJCS5kaWdlc3Rfc2l6ZSA9IHsNCj4gPiArCQkJCQkubWluID0gMCwNCj4gPiArCQkJCQku
bWF4ID0gMCwNCj4gPiArCQkJCQkuaW5jcmVtZW50ID0gMA0KPiA+ICsJCQkJfSwNCj4gPiArCQkJ
CS5pdl9zaXplID0geyAwIH0NCj4gPiArCQkJfSwgfSwNCj4gPiArCQl9LCB9LA0KPiA+ICsJfSwN
Cj4gPiAgIAl7CS8qIE1ENSAqLw0KPiA+ICAgCQkub3AgPSBSVEVfQ1JZUFRPX09QX1RZUEVfU1lN
TUVUUklDLA0KPiA+ICAgCQl7LnN5bSA9IHsNCj4gPiBAQCAtNTUzLDYgKzU3NCwyNiBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IHJ0ZV9jcnlwdG9kZXZfY2FwYWJpbGl0aWVzDQo+IGRwYWEyX3NlY19j
YXBhYmlsaXRpZXNbXSA9IHsNCj4gPiAgIAkJCX0sIH0NCj4gPiAgIAkJfSwgfQ0KPiA+ICAgCX0s
DQo+ID4gKwl7CS8qIE5VTEwgKENJUEhFUikgKi8NCj4gPiArCQkub3AgPSBSVEVfQ1JZUFRPX09Q
X1RZUEVfU1lNTUVUUklDLA0KPiA+ICsJCXsuc3ltID0gew0KPiA+ICsJCQkueGZvcm1fdHlwZSA9
IFJURV9DUllQVE9fU1lNX1hGT1JNX0NJUEhFUiwNCj4gPiArCQkJey5jaXBoZXIgPSB7DQo+ID4g
KwkJCQkuYWxnbyA9IFJURV9DUllQVE9fQ0lQSEVSX05VTEwsDQo+ID4gKwkJCQkuYmxvY2tfc2l6
ZSA9IDEsDQo+ID4gKwkJCQkua2V5X3NpemUgPSB7DQo+ID4gKwkJCQkJLm1pbiA9IDAsDQo+ID4g
KwkJCQkJLm1heCA9IDAsDQo+ID4gKwkJCQkJLmluY3JlbWVudCA9IDANCj4gPiArCQkJCX0sDQo+
ID4gKwkJCQkuaXZfc2l6ZSA9IHsNCj4gPiArCQkJCQkubWluID0gMCwNCj4gPiArCQkJCQkubWF4
ID0gMCwNCj4gPiArCQkJCQkuaW5jcmVtZW50ID0gMA0KPiA+ICsJCQkJfQ0KPiA+ICsJCQl9LCB9
LA0KPiA+ICsJCX0sIH0NCj4gPiArCX0sDQo+ID4gICAJewkvKiBBRVMgQ0JDICovDQo+ID4gICAJ
CS5vcCA9IFJURV9DUllQVE9fT1BfVFlQRV9TWU1NRVRSSUMsDQo+ID4gICAJCXsuc3ltID0gew0K
