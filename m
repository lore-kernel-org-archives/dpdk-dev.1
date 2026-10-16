Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDB0CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 17:07:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59A4240291;
	Fri, 16 Oct 2026 19:07:52 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013028.outbound.protection.outlook.com
 [52.101.83.28]) by mails.dpdk.org (Postfix) with ESMTP id 901C74026C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 19:07:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsOPpZ3wjSQNRK4nmaa+LGr3m0tBNOytFDnQbJ3fjnc+ZOHr/Lx15vA0UYN3ANouGVgJ5Rk586gDfXzp4pBshJaCbRzJqCYhSPkbZbw3mMHNOdxxm9Jnq+pzONKrpkROTGBr15FoaAuFDbI0H4GASomsknu8hMUhcD39+NfaKvk4MVEJ+D9KfMouE737btgjF/KYbKSErWgLb42PgiHs5hecpU1QojfdorlMz0R9LLHUo2pC5KUnKGNqMAutNtKyseCrUrEYKgURWiGoOs7I3uYSq/FCuet30I/LvQZ80+lCUVex7MZ9DqBh83pR5BnaeKDEYGU8KqrC3q98H5/NUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTUG0JLz5wG465cyOPoZy1cYNLYEigOvD/kh7maZiqw=;
 b=FA7EWuK45AISQXE+7xGJfl/MDA4FaILXwxDUjHvXxWC/KA3BbrvFI+BDp0oeEgNF5ed8FxBy2iGBYixF1WeAwc40Nu2E9DjQkREKBOwKj16hrieLxHs+Lj7u0qdbwxE03CeP8NxCFNZ4ZgrgKazqkcPOZIbWRvA8dJabomblT6HCf94KAxjW7zqQtIrDPx6T6BHU4kD2UReb8XG6vAvBrjxflWycAe5CbrPz1R5PD9IKYbjB50WMLo5sx1QpxOIYTjkMhEIlVO87RxS74eUEeS33VjiwXPyCQ6gC3ORIN+V3U91UXtBywux3I3PvieOcnbB01S4m7a2FHs37RkCJtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTUG0JLz5wG465cyOPoZy1cYNLYEigOvD/kh7maZiqw=;
 b=WVOcP2DUv5DnENMiHyOZe7j5horb5sJOvp1GgjYwDoL/rrXNQdGSKBmzPQ131MLm4kVwOSI2yvfGAfldzCDfrVkFX/H+61bdgME/Isv8KyCmqrKBtxqHgWhM50rcuAJ54WmHOea7LekbxLwor+/kFTI7gIb2gt0orpQ7awfdcNckhSJuAOjWLfu/4byt0Fsu2+GV2YFzJZibxGAlFi+7uJFIhJXQ5re3Yb87H8Od5reUP50Zr82eKHr06CcbgqrECWgDWva7C5QlfZ0I+utgWm/q1pJdnAN1tUj8DcTFSI5Ixn5KQv7jZ4xE8UJkKJWElFC/rP1/gVGvhEPKZsWHzw==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by MMZPR04MB625833.eurprd04.prod.outlook.com
 (2603:10a6:190:52::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 17:07:48 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 17:07:48 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v27 00/25] NXP DPAA driver enhancements and fixes
Thread-Topic: [PATCH v27 00/25] NXP DPAA driver enhancements and fixes
Thread-Index: AQHdXWBMnOwr8hhdk0Si6YK9HoxH8LcAXvaAgAACLDCAAAT0gIAAAJ2A
Date: Fri, 16 Oct 2026 17:07:48 +0000
Message-ID: <GV1PR04MB10750B1B09B39DB39187773B5899B2@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20261015141144.3140281-1-hemant.agrawal@nxp.com>
 <20261016111958.163060-1-hemant.agrawal@nxp.com>
 <20261016093848.7dbe6c73@phoenix.local>
 <GV1PR04MB10750670E599D034FA89E627A899B2@GV1PR04MB10750.eurprd04.prod.outlook.com>
 <20261016100435.4dc6dc10@phoenix.local>
In-Reply-To: <20261016100435.4dc6dc10@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-10-16T17:06:46.0000000Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|MMZPR04MB625833:EE_
x-ms-office365-filtering-correlation-id: 3fce6b9b-5793-4b9a-7b64-08df2ba80126
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|19092799006|23010399003|38070700021|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: h/jMfP6OCC7h4Cz4KN5JPlsgJwd5waGJL24otL/rIyWLOLMQXLm0d2VvhJfsItpl2lp1YffV7PfqF6hQy3z2MKtIoyVSwnT9EgCXmWLdFPSlpmtTuCN31TBjRRiMumBDWnSm+pDei47sUbLB9rsuFJBpN9En1o7uqVkI3GfX1b1UqEtFxWJNAI/agxEv3p/VolElveY8g62jfIk4OXv4Jh9lxcvuoy8pZ2GvAXNTb8vv06f/+jfx0ZJDCFUsXitYmATipdqOD/94K7it57psD7xfBzrw3r0JFLtQtcudqRas2TKKI4eJ2qCTL78NdUii6PON+piujWD3W5Qiuf7yV1G6bYOqi+GZuBPtk9/SDQYI+E1+AHI2+p6waqIyBFZmor/LwiAs1AAYJox0Zl9554gJk7BUwswFU0NLKVLp6nlyMPKBr+tbz2/bkyAikDpT4FLNa2+J213oQ3uncU4E28T7P1akzNyZeJO0O+j2XehNXvt6xOiq6U3aeXTicZd/eJW9EMQHV/QxGDTpaiaWevhhqAotS0sdfAimMiPC2xk9/hdAc/iso45HOqdzIb/IYSI9BNkmASP52T1/VY5/ec556oorod2y7gqzhEB2rm5mf4QBJ/p+mM0ACOZJ/JY2g0dwopGhM9/aWEhqu8mPvSmTJjD3r9D7ts497IVhT/Int1ANxnJ2muIDfquD5hHVo7to1oxaR9l9QEES74ivv7Rq3moOs0u78Li7kZ7qG/I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(23010399003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVZQTU96U0dGMTVIVlpxSGc3anN3R240aDY3d1NhWk9XL2svdWhELzVaS1Aw?=
 =?utf-8?B?cnpSNkxibGRjMlgyYisxRmUxVUUxc2xiTTBtYUtxZ1ZzNmNXWTNZd0plUlNp?=
 =?utf-8?B?L0poeFBOTEpMRUJOSURjR091TmMzcU01Ym1RM3ZldVVTeUFSWVpicUN5UjN6?=
 =?utf-8?B?R3pCOTBtTVZTVS9rMCtzbCs4UzkrbEF0azIzQXQyNEdjZzdEZ3crL1BHZWw2?=
 =?utf-8?B?cWxBbHgyMG9xMjh0MWZVN3ErOTNsSHYwUm5zV2gzSmo1eCs0dlc4d3hqQ3Vn?=
 =?utf-8?B?K2RBNUxBeFBmQUdHcERSL29BWWplcjRza0VoQ2pGcytmUmVKS3Q3U3podHN5?=
 =?utf-8?B?R3E4SlRIVGJCSTc0ZU1wM1NzaTFGNjhXYThOU0owTXNyYkpHZHdXZnRBcTFq?=
 =?utf-8?B?TldCV21zREs5N0xSN1RQU2xkVzZCVFlIWFNBNElxMHdwQWtucUhxNzhoRWRM?=
 =?utf-8?B?bnBGNm9sNDd5bk94RzRxSjFxdXFCd1RzQkIvcjVIVnZyamNNQjlOTTlRc3dv?=
 =?utf-8?B?UU05OHAxcWRKZUkxZi9rOUd0YnlLR2hXekxxT2ZsaU9BeXB0S2NaQ1hhTU91?=
 =?utf-8?B?UVVPS2dqcG1URXdGaHdUSHk3clgzRzdNUUFCcU9QZS93cTk1WlVzSWVuZy9Q?=
 =?utf-8?B?VFZzMDdkUEMxVDZSY0tTKzBveTh0djNRcDhnSWp3WGRzNjYyNjV3K3hkaitF?=
 =?utf-8?B?WityaUVCbFBPc0EwWlRCa0tVWmt4UXVoM3NnbVVYRkZkMC85NERXeDRKVTJt?=
 =?utf-8?B?cEs5cHZ2OEUwSGM3OXAyT0lUdmd2MStEZndQV250bWpUd1lnU3kvZ1VUSlBj?=
 =?utf-8?B?V0ZJSnlYazRhZWFKdjk5MnRGR1RUVTlyK216K2p1Wkp4Y2s2ckVHd0JLMHR4?=
 =?utf-8?B?UUNNRTJDOHlkZU5HQ09XVzY5UnN5QjlJeHducWZCcXR5dEUvL3VWU1pvYXBa?=
 =?utf-8?B?ck9aaTZ6NTgwcUlJako2VGd6RDVPQzlDcGV2dXJTNnI1cERtNHQ0bWVMenZw?=
 =?utf-8?B?RE9NVXZRdmJacE9wL3YreUo0Umh4cGNlWENaVGRZWUkyNmNLM1JpQ254aWVa?=
 =?utf-8?B?NUQ3WmZxTC9lek5ZN3k1MkljRWQ1dzF0eW9KR2ZJZFp1TDRZVnNIcTdzYmxG?=
 =?utf-8?B?L3lkZW1RWkhHaTl6WS9kODdDcFdwVHpJaUN6TmljT2lBRE9WZjI1Mkk2SVlI?=
 =?utf-8?B?dmtrQllVNTFHeFhmMVNVbnoxNlpwUmsrUitSaFQ4RklXcWxlZzBjUFd3SXRt?=
 =?utf-8?B?bFBtM0Vhb0EvMnJKT1lNR3hES3ZmWXJaVEs1Y05GcjJKa2t0QmYvWS96MFdB?=
 =?utf-8?B?dWhtb0I4bXppbHg3Yy8zQ2ZYVFhHN01qYkorU0dtdjMwbU5aSHFJT2w3WURU?=
 =?utf-8?B?UU9KWnNFRXhwZ0lpNGRHT25qM2xnVTBIZURieWo4TGIxRys5Qm9zVmZUcC9v?=
 =?utf-8?B?UklQUTlNVktOSlc2dkJBdjhENmcyZG1mTGlUTVpKT0JYUU02SWZUTks4NVBS?=
 =?utf-8?B?aks1VGU5dnNvWXFGMWdsSXgwZ2xIaTNqQ0ZMclZGQ1NFTHI5c0I2eHUrTzhM?=
 =?utf-8?B?Q0w4MHpjc29iM2U1bVI2U1c4cThJbUkrRmg2cFY3NTFFVlpaODBTMExUNjBi?=
 =?utf-8?B?ZmE0QXNRL1dieGNDMnNneFJHcUJUeDhlWndsWElRQ0o5by9PeGVUMjIxb3Bq?=
 =?utf-8?B?QldNL2lVS2FYbEtuc01iWUdRQkNtYldicllUd1UyNnJNUktYc1FrcjhadjY0?=
 =?utf-8?B?blVQUGFVbXQ1a3F6dUJBcVhSbW5HUjRYTnJTZW9OMWZaeExReUlONTBnRjhz?=
 =?utf-8?B?M1U0dXFXdmNGcjNGcjNETExpM2xucUNKQTZnZ3ljQW0xdXBtbkNnaUlBdEIy?=
 =?utf-8?B?cFN6aXJIeE10VVYxZDlDc0J3YVlDMElvU0tIU2xweTdMY3AwWUZhR3JybC9r?=
 =?utf-8?B?c3F5dHl0ZlU5WHRaV2RINDFOcWVYYkNob3h6WThpbDAvdW1kckpNZHRsaEpa?=
 =?utf-8?B?R0QwbWlZWkRtRlpKNVluNHhFN2ZyL1BkclVaYUY5eURGekF0andacTVnbmNM?=
 =?utf-8?B?R1o0ajV6aGErLzJONmFCN3VCWk5xZzJzc0E0RkVWMTJLNE5RaGdpaGxMMjBv?=
 =?utf-8?B?VW1xNXVIVFVKWkFxWEZVaUhJeVFmOFMyZXlEblJoQWR4QStORjJleUpHUEd2?=
 =?utf-8?B?ZVFGTkJBN1RlU1N0d1pOUnMyR1V6N00rcXZmcjdWV0VVeUV5OWUxTVJRcnc2?=
 =?utf-8?B?OWlKYkxVMkt5UDF6VDBvME1reWl5MWdXcE5HbXJybG1CM2xGK2tOaUdaaWFB?=
 =?utf-8?B?UURrbThSd1RKZlNsUXJPakJnWlRDOHdRbFQwSUdCenk4MTZSTXRHdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fce6b9b-5793-4b9a-7b64-08df2ba80126
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 17:07:48.3486 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sgVp+N7xwY3mqWSRJwgXVa8rMV6wNLRfOWtbAWgxpx5PrQgg5Hj3OjONm8pYg9IDhGxReHW09qpgP22uixx2HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB625833
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

DQoNCg0KTlhQIENvbmZpZGVudGlhbA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+IFNl
bnQ6IDE2IE9jdG9iZXIgMjAyNiAyMjozNQ0KPiBUbzogSGVtYW50IEFncmF3YWwgPGhlbWFudC5h
Z3Jhd2FsQG54cC5jb20+DQo+IENjOiB0aG9tYXNAbW9uamFsb24ubmV0OyBkZXZAZHBkay5vcmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MjcgMDAvMjVdIE5YUCBEUEFBIGRyaXZlciBlbmhhbmNl
bWVudHMgYW5kIGZpeGVzDQo+IEltcG9ydGFuY2U6IEhpZ2gNCj4NCj4gT24gRnJpLCAxNiBPY3Qg
MjAyNiAxNjo0ODozMCArMDAwMA0KPiBIZW1hbnQgQWdyYXdhbCA8aGVtYW50LmFncmF3YWxAbnhw
LmNvbT4gd3JvdGU6DQo+DQo+ID4gSGkgU3RlcGhhbiwNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGVwaGVuQG5l
dHdvcmtwbHVtYmVyLm9yZz4NCj4gPiA+DQo+ID4NCj4gPiBOWFAgQ29uZmlkZW50aWFsDQo+ID4g
PiBPbiBGcmksIDE2IE9jdCAyMDI2IDE2OjQ5OjMzICswNTMwDQo+ID4gPiBIZW1hbnQgQWdyYXdh
bCA8aGVtYW50LmFncmF3YWxAbnhwLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gPiBUaGlzIHNl
cmllcyBjb2xsZWN0cyBhIHNldCBvZiBmaXhlcyBhbmQgZW5oYW5jZW1lbnRzIGZvciB0aGUgTlhQ
DQo+ID4gPiA+IERQQUEgYnVzLCBtZW1wb29sLCBkbWEsIGNyeXB0byBhbmQgbmV0IGRyaXZlcnMg
dGFyZ2V0aW5nIDI2LjExLg0KPiA+ID4gPg0KPiA+ID4gPiBJdCBpbmNsdWRlcyBtZW1vcnktbGVh
ayBhbmQgcmVzb3VyY2UtY2xlYW51cCBmaXhlcyBvbiB0aGUgZGV2aWNlDQo+ID4gPiA+IHJlbW92
ZS9jbG9zZSBwYXRocywgbW9yZSByb2J1c3QgZnJhbWUgcXVldWUgc2h1dGRvd24sDQo+ID4gPiA+
IHNlY29uZGFyeS1wcm9jZXNzIHNhZmV0eSBndWFyZHMsIEJQSUQgbGlmZWN5Y2xlIGhhbmRsaW5n
LCBhbmQNCj4gPiA+ID4gc2V2ZXJhbCBuZXcNCj4gPiA+IGZlYXR1cmVzOg0KPiA+ID4gPiBlbmhh
bmNlZCB2aXJ0dWFsIHN0b3JhZ2UgcHJvZmlsZSAoVlNQKSBwb3J0IHN1cHBvcnQsIGZtY2xlc3Mg
UngNCj4gPiA+ID4gcXVldWUgY29uZmlndXJhdGlvbiwgbm9uIGZtWC1tYWNZIHNoYXJlZCBFdGhl
cm5ldCBuYW1pbmcsIGFuZCBETUENCj4gPiA+ID4gc2NhdHRlci1nYXRoZXIgYW5kIGVycmF0YS13
b3JrYXJvdW5kIGRldmFyZ3MuIERvY3VtZW50YXRpb24gYW5kDQo+ID4gPiA+IHJlbGVhc2Ugbm90
ZXMgYXJlIHVwZGF0ZWQgYWNjb3JkaW5nbHkuDQo+ID4gPiA+DQo+ID4gPiA+IFYyNzoNCj4gPiA+
ID4gLSBmaXhlZCBxbV9jaGFubmVsX3Bvb2xfbnVtIGNoZWNrIGlzc3VlLg0KPiA+ID4gPiAtIGZp
eGVkIGNvbW1pdCBtZXNzYWdlIGFzIGRldmFyZyBmb3IgZm1jbGVzcyByeHEgbnVtYmVyIHdhcyBy
ZW1vdmVkLg0KPiA+ID4gPiAtIEFkZGVkIG1pc3NpbmcgZXhwb3J0IGludGVybmFsIHN5bWJvbCBh
bmQgZnEgZGVzdHJveS4NCj4gPiA+ID4gLSBtZXJnZWQgYm90aCBGUSBzaHV0ZG93biBwYXRjaGVz
IGFzIHdlIGNhbm5vdCBjaGFuZ2UgdGhlIHNlcXVlbmNlDQo+ID4gPiA+ICAgIGJlY2F1c2Ugb2Yg
dGhlIGRlcGVuZGVuY3kuDQo+ID4gPiA+IC0gbWFjX2lkeCBoYXMgYSB1c2VyIHdoaWNoIGlzIGRw
YWEgZmxvdyBzbyBubyBjaGFuZ2UuIEFkZGVkIHN0YXRpYyB0bw0KPiA+ID4gPiAgICBnX2ZtY19t
b2RlbCBhbmQgdXBkYXRlZCByZWxlYXNlIG5vdGVzLg0KPiA+ID4gPiAtIElzc3VlcyByZXBvcnRl
ZCBpbiB2MjUgd2hpY2ggYXJlIG5vdCBoYW5kbGVkLCB3ZXJlIG9wdGlvbmFsLCBzbw0KPiA+ID4g
PiAgICBza2lwcGluZyB0aGVtLg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBGWUkgLSB3aGF0IEkgZG8g
aXMgZmVlZCB0aGUgcGF0Y2ggaW50byBhIENsYXVkZSBwcm9qZWN0IHdpdGgNCj4gPiA+IGV4aXN0
aW5nIEFHRU5UUy5tZCBmaWxlLiBUaGUgY2hhdCBjb250aW51ZXMgYXMgdmVyc2lvbnMgZ2V0IHNl
bnQgdG8NCj4gPiA+IGVtYWlsIHNvIHRoZSBjb250ZXh0IHdpbmRvdyBoYXMgYWxsIHRoZSB2ZXJz
aW9ucyBvZiB0aGUgcGF0Y2guIFRoaXMNCj4gPiA+IGxldHMgaXQgc2VlIHRoZSBwcm9ncmVzcyBh
bmQgY2hlY2sgaWYgcHJldmlvdXMgZmluZGluZ3Mgd2VyZSBhZGRyZXNzZWQuDQo+ID4gPg0KPiA+
ID4gUmV2aWV3IG9mIFtQQVRDSCB2MjcgMDAvMjVdIE5YUCBEUEFBIGZpeGVzIGFuZCBlbmhhbmNl
bWVudHMNCj4gPiA+DQo+ID4gPiBTZXJpZXMgYXBwbGllcyBjbGVhbmx5IHRvIDI2LjExLXJjMSBh
bmQgZXZlcnkgY29tbWl0IGJ1aWxkcyB3aXRoIC0NCj4gPiA+IER3ZXJyb3I9dHJ1ZS4gVGhlIGZp
eGVzIGFyZSBub3cgZmlyc3QuIDA4IGNoZXJyeS1waWNrcyBjbGVhbmx5IG9udG8NCj4gPiA+IHYy
NC4xMSBhbmQgdjI1LjExLCBhbmQgMDYgYXBwbGllcyB0aGVyZSBvbmNlIDAxLTA1IGFyZSBpbi4N
Cj4gPiA+DQo+ID4gPiB2MjYgV2FybmluZ3Mgb24gMTIgKG5vdyAxNCkgYW5kIDIwIGFyZSBhZGRy
ZXNzZWQuIFRoZSAyNCBXYXJuaW5nIGlzDQo+ID4gPiBvbmx5IHBhcnRseSBmaXhlZC4NCj4gPiA+
DQo+ID4NCj4gPiBJIHNlZSBvbmx5IG9uZSB3YXJuaW5nIGluIHRoaXMgcGF0Y2hzZXQgMjQvMjUg
LSAgIGlzIGl0IHBvc3NpYmxlIHRoYXQgeW91IGRyb3ANCj4gdGhpcyBwYXRjaCBhbmQgYXBwbHkg
cmVzdCBvZiB0aGUgc2VyaWVzPw0KPg0KPiBJIGNvdWxkIGlmIHRoYXQgaXMgd2hhdCB5b3Ugd2Fu
dA0KDQpZZXMsIHBsZWFzZS4NCg0KSSB3aWxsIHNlbmQgdGhlIDI0LzI1IGluZGVwZW5kZW50bHkg
bGF0ZXIuDQo=
