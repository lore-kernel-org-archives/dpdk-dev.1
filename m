Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D3CCEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 09:44:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9BB7427BA;
	Mon, 17 Nov 2025 10:44:43 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
 by mails.dpdk.org (Postfix) with ESMTP id 0B6034027D;
 Mon, 17 Nov 2025 10:44:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a39drOzOSpNYXvOdh0MI9PQie1PXHplb+Sma8FINgr2I4/9mOrzBWStrzw5LcH52SrcqgMj2JeiAL5Z7CkLvmBPnXbUN0zpNSn6hqDTLMCSAZ57LPvtiXPVLWlZNsmc1KYwdjzIxgLB8/wExaXxwL69BFTC2spFg7GaW58KQco07ZWordK2Vvr6WqWS/tZXXZiMqcrqO44ZXKjf1zh3+gEzThVVZPQbUM4kild2syfhkPkhURkA0fbpsfXcgzzCHVQ2iWH/ABdnKOtEgFflbhUV/cJnjtNu/kAetY00q1TdhwaWHtH/2a1pKuN7NFu95D6PEQDEjeVANBEcBC1kHew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htJjIpS2mfmR/u84/cnM8llW07XFnVA0mw91CjMVxB8=;
 b=WrctBVuT+WItjgt5fjSF5DBiFdn+pdFjF81iVgMeZDk7OOKxxhtoeVfdLvBVl0a7LgQsTyD54vR8js/qLlRzJR9lSAw0RqPR81CBfMTJSUp6iroyDvlJogOvy0iV2cgBN/9XfVWMasT3n4haRAeweEabWXHFoU/pU+h1Kod2l04eRsVoX/15Xtl9cbTScy22lOAPdfJARswRR10yFysDm8MfdNw1x3yKWau0VAKfSynSTiCpc5L75C/6HNtsp1UPoJEhHrCqq8S7JKbXorKDEWP5hWW4nUte4wKDOY5eaG1cMfY1N5n6/682iyCM/XaOd6Jl+v00djaoeHBVWT99Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htJjIpS2mfmR/u84/cnM8llW07XFnVA0mw91CjMVxB8=;
 b=IJiAp2BCaRwoTh//tQ2A2e2St3ve/mGg9aEaLe+D+DnZvJyLpIifm4BK1+pP7OindMXxK2hDiOE0uqflD4SVDSfyOgInvuhckQmAhPRl31YihlH/77LWpzo9j0TyeA/WjD/CvoqPaSII4CxLzEGJ83yJizAIb28ZcIhOn+sBdNJQtszjjHi6Znz3ndcDw+m8E+HfaOgeLf85tYeeutKhAdFfncgu90BR//CWXTq6P43A8OJQAkzohNV/A6OukAgJFby+Y8KVa/LpOeojcf3G7Skpw8mcgBu6gjcGN3rBMUFgin3RpeYZZ++NiytycoQbziqwsHzQhU3K1B8vt/2Y7Q==
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by GV4PR04MB11730.eurprd04.prod.outlook.com (2603:10a6:150:2df::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 09:44:41 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 09:44:41 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Maxime Leroy <maxime@leroys.fr>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "david.marchand@redhat.com"
 <david.marchand@redhat.com>, Jun Yang <jun.yang@nxp.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH v5 2/4] net/dpaa2: clear active VDQ state when freeing Rx
 queues
Thread-Topic: [PATCH v5 2/4] net/dpaa2: clear active VDQ state when freeing Rx
 queues
Thread-Index: AQHcVS9u/4vBhdB8pkaMuF0ND4fXdLT2jsMAgAAUPJA=
Date: Mon, 17 Nov 2025 09:44:40 +0000
Message-ID: <PAXPR04MB9328DD5AB3BD62D41A9E39A489C9A@PAXPR04MB9328.eurprd04.prod.outlook.com>
References: <20251113114355.2027438-1-hemant.agrawal@nxp.com>
 <20251114062454.2731559-1-hemant.agrawal@nxp.com>
 <20251114062454.2731559-2-hemant.agrawal@nxp.com>
 <CAHHRULUv9o76_zkomOi4jYnd3ci7dbxQD2bXmudWA00aVUwttA@mail.gmail.com>
In-Reply-To: <CAHHRULUv9o76_zkomOi4jYnd3ci7dbxQD2bXmudWA00aVUwttA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: stephen@networkplumber.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9328:EE_|GV4PR04MB11730:EE_
x-ms-office365-filtering-correlation-id: 76ab93cd-1301-4992-dce2-08de25bdee53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|19092799006|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?N2tsVFVvMkF5NXgydmVKNFFDWlg5QlI2NUs1M3pxaWsxSkZObUdmT2czcnNT?=
 =?utf-8?B?TVVleXpxMHlncllhbGZNNm03djV3NzZBR09mckROaEdsQm4vSUt4dmJ0L0xU?=
 =?utf-8?B?c2l2NU8yeDZBRmZBYzJWY2VTTVhvU1VOcEtPM0RuNGI4bFZXVWN4OHVuWWJE?=
 =?utf-8?B?WUQ2QVJqQVU2VmM2djZDbTI3N1NuM1ByUU9ycVZGNHBMaDA0c3VSaC8rc1RG?=
 =?utf-8?B?T2cwalpVbzZFVGNGdHQ1MHprODRVYjdVbzl2TnRqeXRkM082YjYvY1lUU0V4?=
 =?utf-8?B?WThON0FVUThiR0grZThZT1hBWnhQVGpTNTV5WjJuSTBiOXB4RUJvRERPK2JD?=
 =?utf-8?B?T2JWMVptUTZieVZGK1F5ZHZnRjA4MVNoOHRIUmU4eEpIbDZ4UzhFZnZMYXZP?=
 =?utf-8?B?dVdGVnVpMWJHUU4waXRPYlZtbFl5dnZsckl6ZHQxUnFuN1RxNVZZSHdyWUhC?=
 =?utf-8?B?bW42Skd4NTB1eldNWGdsU1h2L3pkM1hsTVlhUTB6UEVIS0hkTTVpWDNOamR4?=
 =?utf-8?B?RkN4cUNURUZ6eDFrV2pwQ2VlbzFLTkltVTRSNjVMdUpOMGxDckpvSXIwMGJJ?=
 =?utf-8?B?SEh4UEpMVm8zMDJNNGl3bTY5dy9rd3NQWmczSW5MS1kvMzJ3WFVubXBPQ2tz?=
 =?utf-8?B?RS9ld0NTcmV3WGkzVW84a09jZEo3dmhNcHJzcUluQThVckVyWC9uTlJlQ3l0?=
 =?utf-8?B?WmVtWnQ1QzJZQnAwSDM4aEczR0d6bFNTbGYzbVFtT0RYaGtJWFRwbVJxL1l6?=
 =?utf-8?B?TzdiRkdSMFR6MGZuUUs2SVFjRVFoUXhDVzNoVkthbFpYaFJ6QVdCdHJIM3JK?=
 =?utf-8?B?VWM0NkkzaUJzdjBxbnl3TnEvM0NjR3JzdzdqNEhxT21SNlZVeWtrS3loNHpL?=
 =?utf-8?B?V1ZWSVcrdnVlVUFTdTZ6TGI4RGdCb1Q4bkh6WjNrd2RaWDdPUVB6d0VCNE8v?=
 =?utf-8?B?NU5od3JxZlhNdGVSN0RWODNpZDl6cXgwdlBJZSsyK0RBbHJxbVJGSzZoMDNi?=
 =?utf-8?B?bHlwME45OU9sRnJUL3FxZWZtUmxkUEVEUGdtT3UwZHhWUCtTaUVCRHVrMFlL?=
 =?utf-8?B?WG1ENTVCUDdObzZBdmREd1ZneklyNitHQ3BHMWtRQU1YOFgyQzAwbHorUXpM?=
 =?utf-8?B?UHVWSTFJSjIrN1h5a3FyYmlReWVDVjVLK21DTnZKbkNhemVPU001MU9FRHRQ?=
 =?utf-8?B?b0Nkdy9TNk1PN0FBSW5TSEF2S2ZXa1VEa0VWTGorWTM1WnBFTE1PZDlkU1NE?=
 =?utf-8?B?ZzNiTi9pV2hDVHZSa1dMZFNHc0hablhiMnlpYmdndnIrV01kc2N4NXN1S1Nv?=
 =?utf-8?B?bXZEMDY1U2RkRmI5ZmI1RUNFRHh3SGlPcE1uY0xuMzUyOEFsV2FGL2hTemtB?=
 =?utf-8?B?M2ZkNDZXRkdaczVIS05TTU9lSDl2d2pXelQ3V3E4NzFzQVZsNUFNazdMWS8x?=
 =?utf-8?B?bDBtRTZyeXA5SmtDaHh4bi9nWEhnU0ZGK1JUSE1adTllODZVU1BPRjVkUWtw?=
 =?utf-8?B?ekRrWlVNc2psSGlyZ01NTlBROFJBSEJFUThsbHE0bkR3bmNsY0kzbG5EYnBX?=
 =?utf-8?B?SG9nTkFhbFlsNXl5YW9WeXNqUzJDYnhGdERNaVJGbDU3RHFvOGN5MWVOVk83?=
 =?utf-8?B?clV4b3NPSmZNZnZKdVVWcWtQS1lIVzdyTi9hcHNFdTdOR2ZNb0FTblhvWnlC?=
 =?utf-8?B?Uzg4QlRqeWE5M2ZQM21yZk9VR1h6Zis4bWhOUUI5MGlvMzhORTVORHlnaWxE?=
 =?utf-8?B?N1ZHbWw5WjlMcGM4bjRZNWd5UHlOZmxGOXhNNmd6MkRzQzJpeFpVQ3hud0d2?=
 =?utf-8?B?UmtLQ0Z4d3BUNDEyWjZDZjAwTmVwZTZZMThRVDVOcnUxVGxTZFN3eTZaTnZs?=
 =?utf-8?B?UEw1L2hmSk56b2NjdjlVbnpCYmhKS3AxdXQwOGw1bkQ5M00zdUlFL3BQOHVk?=
 =?utf-8?B?QTV3WjBtZGVGeFNBdTJXUjBUZGU2SCtDV0tWYXNwWDlHMzVuSVBoRkdTY2hn?=
 =?utf-8?B?Vk8reFpPYSt1NUt4cTFhejBhT3FLY05NMWNwMUU4TURUTmtwcnFkNW1PdlFF?=
 =?utf-8?Q?7V+DYj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODUvVjZOcWFKNlpOMXpWQkVrNEU5M2prbVVxVDRpWnFDR0cxTjY3dUY2N1Bj?=
 =?utf-8?B?bG94Rys5S0ZuVkMwbzR4bjJpRzVHWjhuTVF1Yjl5OVNpVGcvREYwaXlqRnZV?=
 =?utf-8?B?dmxRZlNOUzFyQ2IwcVZGbHZReng4T0NFTUtSS3hsaFliWU5wN3ZqazRqOW8y?=
 =?utf-8?B?b0RibS9MT0hybzRPOEd3UHhNUC9zYytxdTFyUlIreVM2cUFQT0NUVEs2L2xU?=
 =?utf-8?B?NUJZbk44b2RDamJCbVNmRVpnNnA5NlZmWnBqM2NSKzJFcEl2c1A4eFQ1R25x?=
 =?utf-8?B?NFVFY2Y1UWJObU9QZStzdmdVNTY0eFNDejZEaVlhRUhabGpVakdVK2U4L215?=
 =?utf-8?B?Wnd4anlUaXVZQkkvMFM1Zk5WYlBxeUVoY281cFBXZWRNSzh5cFYvTVBucXBp?=
 =?utf-8?B?K2VHR29GSjlzdmRmQ29zQXNQcXFQUUV6WkZocUNHSTFNd3BhY3QwTS8yTk9z?=
 =?utf-8?B?U2tlRGVDNWJkSVV5NXFvSTg2NFFyQjFFWTQ2RmNxNjdoWnFJQjA0RDFLSTVt?=
 =?utf-8?B?dU9PM29ld0tRRkRNTHVuZGlkQWJEU0VqZXhTL3MvUGJ0MVVjb1ByNTVscDIx?=
 =?utf-8?B?MkFKREkrZlhIN25EQ1RzejFFaUdYak9VZTVGUHRHQlJYUnZpTVdYWGRhbjdn?=
 =?utf-8?B?ZGhUanZTZ0o2ZGxtQjIra1pxak9KdFJTTEZrUVpCVG1pZGs4VmtLQm5vUGVH?=
 =?utf-8?B?UkVVNlhsdEI3Z0xvd2tvcnlEKzBlejNLK0tNUlIzTXM0d3ArVUJJSWljSjlj?=
 =?utf-8?B?ajU0MGRjRi84TTFrczI1NUpkK2MyRDZMaFpQRkYxMnBTbnVUVVBDOC9odm9Y?=
 =?utf-8?B?UXRSYk1QdzVtdnNjM2ZIUGVBTnZ3anJMN3J5eTVyblUxdWtpbTRUK0g5eXo5?=
 =?utf-8?B?VzRQNVJtMDQ0czdDTHV4VVlvQmsxZHorNXBNY2o3NVFpYmFYOUxINGkrWElr?=
 =?utf-8?B?MzVLRFl2eDhad2hpODkwM3RobVExbFlhZ2tFdFJPVWs4Szg3aFlWV2djYXpL?=
 =?utf-8?B?SVBuOEJ2azJGOWJ1NTFxWjd5OTB1S3ZveXhLWW5RTlhidjZyWk1jSFhObnVT?=
 =?utf-8?B?NGFua2xCelFvYWNmK0ZkbDB3Q2N2NjBVbFdkamswRzY2SDdjZG1NWjJSbXRO?=
 =?utf-8?B?YzgwUmUvYy9DbkphbUlEWUdXanZhcWY0VlhLMkIxY1B6eWRKVDBYTHpvYmZk?=
 =?utf-8?B?RytTNTMyWHNhZlV0WTBLQXNDeHM3eGxXWEpIdGhyY0k5RzNYTVhHV3BrOWpY?=
 =?utf-8?B?NmtIQ0ZuMmZNejY2QXB2K0hkTDdrc3k2eXh6TFRRanAvb3EvWW1KUmFMeW9x?=
 =?utf-8?B?b2RGVjlyZmM2ZEoxNmtCemxDU0VZWjhxNVpYMnF2a1hQVjFHWnlMQnZTUHB1?=
 =?utf-8?B?ZHF6WDdwRTVLc3V5eDF6bGkvMWhjQ2QvbDZPNUhLcGcvdmM3UldqbFFPcE42?=
 =?utf-8?B?cjI2UmFTcTVqYUdDU21Qbit5ZkUwQXYyR3Q0MUFLN1VBSk1ueld6QW9lSm55?=
 =?utf-8?B?ekpCbjhKSkJLT0dzYURENlg5cm1aUXJkUWNFbnlLSERZSkZXTzhVUklwTUtD?=
 =?utf-8?B?M2x0ekYyZ2V0eTFuenF1cTh4clBmU1BGbWlQdGowWjRhSTNkWERjaHR4S0Zm?=
 =?utf-8?B?YnpxTDJIWFF0eVZCSU81bVdUeDE2Z3N4SUxKOFBWSWVUNEk3TzdGK0FxS3Jw?=
 =?utf-8?B?T2phS2xOZWFDNjdsamxMbnNId2xYTnJEODA0Z1EyL2UzZGVDRlhubkRPYU4z?=
 =?utf-8?B?eVJPQ3ZpNU1NNUs1RnRoa3B4VWxjMkpVOUJTTUpJQ3doOG9qSi9jTDByVGE2?=
 =?utf-8?B?Rm4yWU5hOFpuRitpN3dFcy8vV1VPOXZIWW9mUnJ0MHBTSml1RlVHckFYQmtU?=
 =?utf-8?B?ZDl6WUMyWUtxcG40bUtSTm9oL3c5eXRLS2krY2s3N3ZTNEEwbWsvRUN4ZVhz?=
 =?utf-8?B?VitqbmJFT3RreVcwSDIramVUNUVXd2ExdWdrQTcvUjRaWlBsbWxRUWR1VHlK?=
 =?utf-8?B?UngvZ0VMaUREV2FlU2czY082T29nZ29hQnFVTzdVS1lZVTh5YkVLVEMxcHFk?=
 =?utf-8?B?eXhGUVdzaklwcWVRazJBR3RaSWlzMThMZUpxT0pHRDEwL01sSFRhTlRJY3VL?=
 =?utf-8?Q?6mlCgZeE+YCK+5pnAcv0Wj5GC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ab93cd-1301-4992-dce2-08de25bdee53
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 09:44:41.0005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kp6vjawn0W6lQHfH6BT5AtRkyFmt0/BpJfwzJGVdvoQX9coThA65ieUZis1mdMr22+0WQC1uEW+4RnTXwCaTnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11730
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

PiA+IGRpZmYgLS1naXQgYS8ubWFpbG1hcCBiLy5tYWlsbWFwDQo+ID4gaW5kZXggMTBjMzdhOTdh
Ni4uZDkyZDRmYzI0YiAxMDA2NDQNCj4gPiAtLS0gYS8ubWFpbG1hcA0KPiA+ICsrKyBiLy5tYWls
bWFwDQo+ID4gQEAgLTEwMzUsNyArMTAzNSw3IEBAIE1hdXJpY2lvIFZhc3F1ZXogQg0KPiA8bWF1
cmljaW8udmFzcXVlekBwb2xpdG8uaXQ+DQo+ID4gPG1hdXJpY2lvLnZhc3F1ZXpiZXJuYWxAc3R1
ZGVudGkgIE1hdXJvIEFubmFydW1tYQ0KPiA+IDxtYXVyb2FubmFydW1tYUBob3RtYWlsLml0PiAg
TWF4aW1lIENvcXVlbGluDQo+ID4gPG1heGltZS5jb3F1ZWxpbkByZWRoYXQuY29tPiAgTWF4aW1l
IEdvdWluDQo+IDxtYXhpbWUuZ291aW5ANndpbmQuY29tPg0KPiA+IC1NYXhpbWUgTGVyb3kgPG1h
eGltZS5sZXJveUA2d2luZC5jb20+DQo+ID4gK01heGltZSBMZXJveSA8bWF4aW1lLmxlcm95QDZ3
aW5kLmNvbT4gPG1heGltZUBsZXJveXMuZnI+DQo+IFRoZSBvcmRlciBpcyBpbmNvcnJlY3QuIE15
IG5ldyBlbWFpbCBhZGRyZXNzIGlzIG1heGltZUBsZXJveXMuZnIsIGFuZCBpdA0KPiBzaG91bGQg
YXBwZWFyIGZpcnN0IGluIHRoZSBsaXN0Lg0KDQpIaSBAc3RlcGhlbkBuZXR3b3JrcGx1bWJlci5v
cmcgIHdpbGwgeW91IHBsZWFzZSB0YWtlIGNhcmUgb2YgaXQgaW4gbWVyZ2UsIG9yIEkgc2hvdWxk
IHNlbmQgbmV3IHZlcnNpb24/DQoNClJlZ2FyZHMNCkhlbWFudA0KDQo+IA0KPiBUaGFuayB5b3Us
DQo+IA0KPiBNYXhpbWUgTGVyb3kNCg==
