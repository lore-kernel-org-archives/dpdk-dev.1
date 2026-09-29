Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F173AC9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 15:50:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47C5641132;
	Tue, 29 Sep 2026 17:50:09 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011052.outbound.protection.outlook.com
 [40.107.130.52])
 by mails.dpdk.org (Postfix) with ESMTP id 65FEF40E0A;
 Tue, 29 Sep 2026 17:50:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Se3PBWw8BPODf91xaQzc5FOWNYGuynTQyWI+D9/pmv8yxg99m2cT9y7+PrI1yFpZZXQfC3F6T3VH9W2tnVzIJ/lelPc1TXamosVEQeeXPwDiNQ1sCI3CstJQD/MuYLPyCZulfxCsB0xN5gzhr0m3XNyjJyFayEVpeY6pzYQfF+CoeQVsYDWQY5d8UhlshdELiP0K+ejiUejXwVELmnTqsWDDg5yrFUFqgZPUKfeLiBar3dYPGwJ+GWUAiOkqL1gPJWw75wncV39gvMfXk2p2TbSiEVQHZW1BWPi1X6AQYxhx4+OC0c0kUMc3jZrqUkdLtxFqLjFEAdZnTrIuwCNZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgqsZP+MDamCZWuzTtMprNrdo3QeUhW3BtRPpbtJZ5s=;
 b=eGO1jm1HBxGxwUd0jAdKguUX0BEK+sGV87EBr2xF4s9J2rRr5tbQG7xpK/yF+bZFMCq8T3k3026Qx6O3VrJn2wsrWai6tOSjTd2O0pTdHpXdSZuLXHs0Tnq985ZaG1u/MoH1nMrzMumXieqkO83stRsDEoJwlNP0vRGzx92xzbwBA+g1zqe8iCIGjXGvXb+TKvUdKsK283RYrHDNMGPRKKdXbU3MV9H9GTmZoliDEQATdtrPIZAI7QZJrjIgqMAcds3YAL1xqTxzti/PVnyOKHOHRhGwJR/8nZ2yXlW6Q0DOfUQsNJhO0IAEPXOJ1mSddWi5y5AanaRPNgPo3+mPog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgqsZP+MDamCZWuzTtMprNrdo3QeUhW3BtRPpbtJZ5s=;
 b=Uoyiq0M8mAbbfM3R5RXhk5DEIc8uyAUlCLXX71SOqGg3mHiQypQ+Iv1BIGkfzWoSTgW/agRTDRK+b9ZnVbKGprz9D64Pk/4m3bv1UB23kVmwmOrWrfy6+eH60PUlTDl+bolHXywIzAO/KU9Q7OmpJamM21sliaFZj0HaLqgzABLSReR8VMurPELUkR/JfApJP1VA+2kyx8UCRohW+Ll0dbLr+Z7hiWDzQOJV+mcljD5FgJTEHPoV8rkTEI3qwMYIUNGZGjgugvRcp96oQTO7JjLnxf7WCLxPgU07gb2QIbV10/mk8i5LDfgGZLgkPKiuxPYQ1s6BgxxP0/Z/FYL5JA==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by VI2PR04MB11145.eurprd04.prod.outlook.com
 (2603:10a6:800:298::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 15:50:05 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 15:50:05 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: David Marchand <david.marchand@redhat.com>
CC: "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "thomas@monjalon.net" <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>,
 "stable@dpdk.org" <stable@dpdk.org>, Gagandeep Singh <G.Singh@nxp.com>
Subject: RE: [PATCH v17 01/23] net/dpaa: fix device remove
Thread-Topic: [PATCH v17 01/23] net/dpaa: fix device remove
Thread-Index: AQHdT/+nA42OJHNzbEOjqQo4rTU1BLblf7EAgAA0ZgA=
Date: Tue, 29 Sep 2026 15:50:05 +0000
Message-ID: <GV1PR04MB10750B7E61446BB3F5D677021898C2@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20260928065849.126909-1-hemant.agrawal@nxp.com>
 <20260929104519.1770698-1-hemant.agrawal@nxp.com>
 <20260929104519.1770698-2-hemant.agrawal@nxp.com>
 <CAJFAV8xBzpUAnSvdr2NaGd36ZkDkv26yzLXzbNGGNXi024DfBg@mail.gmail.com>
In-Reply-To: <CAJFAV8xBzpUAnSvdr2NaGd36ZkDkv26yzLXzbNGGNXi024DfBg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-09-29T15:49:00.0000000Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|VI2PR04MB11145:EE_
x-ms-office365-filtering-correlation-id: af604ca8-ebcb-4419-d9b6-08df1e4154d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|366016|23010399003|10067099003|4133799003|11063799006|56012099006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: b963VtYEeUTryOwsAnferyds7EFXUcvlK9ejcN03T94R0fQE65iCTMdyXfzhnZi6UqpF176H5Il0m5DwRtd/4Owhy8g7xOofq+ojRHRUqrkzz8q19/SnYcJDUXpPPVLR1GamBK/O7GGL+Yn+bc9LXjv7mdmEqfoKyZXUkZ21YXc86Dzur8+JMax+OI3rjXyMonuyX8sUtssttqnaMOV8Rl8zE36O7oxYRbyRewKPu2rlZm4VW8HPmTq5x93zCAuy5X+iDq/jd8aLw5NtoxJ3332YFSqMBevTLNNAfvEp7+9fnBIKlI7PnaFpq5WQob6xHyfUl/PHqE6m/+pEb9Xl7jMGrAOZ7h6ZpP1flBFBHSVp9JfUiMeeGNJhqvFKabhE0M9iqeI21g2d1B/jLsiY9gCUx/cP95tyCszCMYNpk1yObfeLiePcOlRosKiogNNQ9QW8WuinArufLfxSsnpprQ51z8345vlIiz9nUdcX/VhFyJcSwl5bJmXjGULwtSJOqzqAAygmMI864KfvPF7f0Msqo2iRbwkphaKZgU84404cVqs39+SRT6ldDtfqnKsEYoY3oJlzvJ2zQhUS3diCnYSYqKoLOVx4vr8VG2WwCraAMysk7O6MAiLOQyHUJsmtQESbDMotrxecIoybwL8nKvUSYKhbbZNRqdsKn5i1f9R0j9ecaPZxlwsqBMJBpuUzcwgdO+Zj+0yI5Saw1F9QyE0t+8oixapwbhlnyHQO884=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(23010399003)(10067099003)(4133799003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUduV0dCTGk4a2pQbHpYQkdxTk1VWEx1RTNuT1M5T1FybHpGYVRyS1Z2OHB4?=
 =?utf-8?B?V3ZOMEtVRHhNTlJoL3NWQlhRb28zQmRlQTBMKzR6ZGJZaDFjcnFaR3F4ZHlh?=
 =?utf-8?B?aGFnUVZHTm5JZ0owaEUzb25UeGcwUU0wenp5a2UzWVJwMlJ3cit4aFN3ZWxF?=
 =?utf-8?B?RDN3Y1dWa2FjTWs4T3FLNDRBWE1WeGpnTmRNMzVlTkNtZWNtMjlaQm9GNlJV?=
 =?utf-8?B?V3lGeG9yR2FYRkJLVlo5R3R3RjBIZWhxQmJJMC9FZEJZMERrRVA3R01WRXhL?=
 =?utf-8?B?d2FkdVBmYllYMlZEQUdzb1Q5WWFKM2Y1MFQ1OUNtNVQwUlBIZmY5aExId3dK?=
 =?utf-8?B?M0R4VHhyOFZsS2pWSXBneDNDcUQvTFVwenMvZzJoM1Rnb3RHNlhxbEJJR2FK?=
 =?utf-8?B?MDdkc2pyYWJUclZXSTFoankvVGZoS3RuYmo4Nk85RmE4U3duTVhkZ1BhVjVL?=
 =?utf-8?B?QXJBK1pIckxzdE0rSTVvOGxuY215QmpCUTIxM3puRURjcm9OemFiZDlXN0My?=
 =?utf-8?B?UktvQmhEdi8yK2VUUEQzaXRPQ0g5dXdwTHNZc0F0RkFuOXk5cVkxSzk4ajBZ?=
 =?utf-8?B?NGxTNDhUelJIUkw2N2k5bmJ4OFAwRmRPZEQ2aVNaanJNWjZKZCtoUU9iYi9j?=
 =?utf-8?B?WHFIVTdWYkoyaU1IL3pjeWlObkVWMDgrdmRlNlNkcVM2NG1LWkMyclE5V3lC?=
 =?utf-8?B?L3lSZ080emZlNUU1Vnc4cmxpYnRMdE9ZeEpCOXJTU3NHVzJtdzl6S2l5ckg3?=
 =?utf-8?B?NnVKdkgxcW9vWk1HajJWRWsvVThkT1A5cy9RUzRORDBIRHY5K0E0Y1l6M1px?=
 =?utf-8?B?N3hRQzNmSG9wNzJmK3AycnpLbENvOW9KcW95WmtZMlRHVWlZUnFlSWdicVRr?=
 =?utf-8?B?YzVPeVFmZ0hUZmk3YXcwbm5DY2dvV3lJdWJZQWh5ZldPYWxLYStJdjlmTGNz?=
 =?utf-8?B?QWx5SmMwem0vemJ4cUJ4b3BjWkNuVkU4WDBTS3o0YThpY2VJV1VDSXN2eGor?=
 =?utf-8?B?Zjk1M2lyNndsa0FOblZmTjRUTTJhODFuYzFtNUxFS0FmNkZ2cmtsSkVWNUk3?=
 =?utf-8?B?MUxKMnFxTTRPM3ZOTjIzNWt3L21RaUxSWitQU3E3NmtRYzlkb1RkdWRyOENS?=
 =?utf-8?B?VVBBbGs1S0s2d1NwSHFKUnJ4QXBrTXF6Tzg2NXpseVFNNmxOMjJRUG1BNSsv?=
 =?utf-8?B?VGdGNEs3SjJmaXN6YldqQkhIald1MSs3b3FndGZOSzZ4QUxodjlDMHhEdHdY?=
 =?utf-8?B?LzFNZVVqbDFzNGJNNU5ReWtNMjRLNXNtM2kzRTJsZUtqVkVPUnZIWmk4ekFV?=
 =?utf-8?B?V0RkZm11WFlDUU9BWFE0OTJaR1dQR01WdmhkeWlkUCtYMTJ1c1NYWGNhdjY0?=
 =?utf-8?B?NEE5Z2lVTHJlRDErRmxVMFZJNkU1cGtBTW83SE1NMzQzN0xFeWVMYmsrNWxa?=
 =?utf-8?B?d3pBdDFpeENLOWh2ZENURjdvSDM5R05oWml0dXVVY2Y3Z3RBa2ZUQXgySEV1?=
 =?utf-8?B?VHlzYzBjQ0tZd0xKRFJjUWdHY0t1MkhabkFSaG1FZC9mSDdNalpXMDJWajNC?=
 =?utf-8?B?NzcwelBjdjdHMHFhRndwT3JHVkppQTkrdjZpWnJkQ3JQZXdGQkRiSGkzQld6?=
 =?utf-8?B?N284Y3FyNnl3ckZkSjJJcDNmSkJ3TUlwQ2RXN0tLT2Q4dFJGVVZUNERXcUli?=
 =?utf-8?B?dXFXdmJUZnRXZENIYXExOENPUGtHOXROYU0vMXBmYXNVdnJ6ekRRVWNDNXBx?=
 =?utf-8?B?MVB0a0lHWHorSjhCUTZGL0ZhL1A3dGw1OTVLbWthUVRnZW5INHJkbjB1ZGJw?=
 =?utf-8?B?QTdRZUtFVjdjeXQ5eFNad0ZnWldxTVJOWHJ6TkFVWjlrWHJPWXdWMFlvQ1dN?=
 =?utf-8?B?ck5mZFR4K0NuMDBKM0pNa1RBTGY2QzVuZGwvWk9zZG1FK0ZCOG9sZ2hqd0Ra?=
 =?utf-8?B?bWQ3QThJdTNZVXNDTW9qdUczamJra1JpcVpVYUxWVjZmN2xtVGwvVk9kRURZ?=
 =?utf-8?B?dGxrVEtLK054VEc0YzF5QXFQbEpXS1A4MDVNWXZ6WTNpSG9WMnphMml3blBw?=
 =?utf-8?B?ZlcybnZUSEJwd2hTbTJpNFh6OHlCMU1JcVZFYlB5bXIrL1Nmd0MyN0p6Z0or?=
 =?utf-8?B?UHRkRTlkdXd0eUQ2YTZaZHFzZjA1ejhKWHRGQXF5K1RITmRkRjI1a2tyb0xs?=
 =?utf-8?B?bkZyWUZ0aEoraytDUXV5RHlZSzVmUkRzS0duSHNzejBRdmdNNW9aREJreUFo?=
 =?utf-8?B?RnphK3RPT3dwWmx5RGxFN3JrKzZWYjNPNHVNNGQ5RVllTXBzejJ2MFR5TDlJ?=
 =?utf-8?B?OTUvK1VkYXAzZ2lNeGVIOHNHQXptam5qT2VzMVhaWVVIdHNkMUlpZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af604ca8-ebcb-4419-d9b6-08df1e4154d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 15:50:05.4536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qxo06tDY3EJxkoMZ5z0v6+tIB34kn8z2C+/bh/YyF/NpNwCJKO3k9C9sRHHS9WlqmTp6yo1oMrT9vwuCFsgRqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11145
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
cm9tOiBEYXZpZCBNYXJjaGFuZCA8ZGF2aWQubWFyY2hhbmRAcmVkaGF0LmNvbT4NCj4gU2VudDog
MjkgU2VwdGVtYmVyIDIwMjYgMTg6MTENCj4gVG86IEhlbWFudCBBZ3Jhd2FsIDxoZW1hbnQuYWdy
YXdhbEBueHAuY29tPg0KPiBDYzogc3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc7IHRob21hc0Bt
b25qYWxvbi5uZXQ7IGRldkBkcGRrLm9yZzsNCj4gc3RhYmxlQGRwZGsub3JnOyBHYWdhbmRlZXAg
U2luZ2ggPEcuU2luZ2hAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTcgMDEvMjNd
IG5ldC9kcGFhOiBmaXggZGV2aWNlIHJlbW92ZQ0KPiBJbXBvcnRhbmNlOiBIaWdoDQo+DQo+IE9u
IFR1ZSwgMjkgU2VwdCAyMDI2IGF0IDEyOjQ1LCBIZW1hbnQgQWdyYXdhbA0KPiA8aGVtYW50LmFn
cmF3YWxAbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBHYWdhbmRlZXAgU2luZ2ggPGcu
c2luZ2hAbnhwLmNvbT4NCj4gPg0KPiA+IEFkZHMgYSBjaGVjayB0byBub3QgdG8gY2xvc2UgZGV2
aWNlIGlmIGFscmVhZHkgY2xvc2VkLg0KPiA+DQo+ID4gRml4ZXM6IDc4ZWE0YjRmY2I1MiAoImJ1
cy9kcGFhOiBpbXByb3ZlIGNsZWFudXAiKQ0KPiA+IENjOiBzdGFibGVAZHBkay5vcmcNCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEdhZ2FuZGVlcCBTaW5naCA8Zy5zaW5naEBueHAuY29tPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC9kcGFhL2RwYWFfZXRoZGV2LmMgfCA5ICsrKysrKy0tLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RwYWEvZHBhYV9ldGhkZXYuYw0KPiA+IGIv
ZHJpdmVycy9uZXQvZHBhYS9kcGFhX2V0aGRldi5jIGluZGV4IDFhYWY5N2YxNzUuLjdkY2Q2N2Zi
ODEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZHBhYS9kcGFhX2V0aGRldi5jDQo+ID4g
KysrIGIvZHJpdmVycy9uZXQvZHBhYS9kcGFhX2V0aGRldi5jDQo+ID4gQEAgLTI2NzksOSArMjY3
OSwxMiBAQCBydGVfZHBhYV9yZW1vdmUoc3RydWN0IHJ0ZV9kcGFhX2RldmljZQ0KPiAqZHBhYV9k
ZXYpDQo+ID4gICAgICAgICBQTURfSU5JVF9GVU5DX1RSQUNFKCk7DQo+ID4NCj4gPiAgICAgICAg
IGV0aF9kZXYgPSBydGVfZXRoX2Rldl9hbGxvY2F0ZWQoZHBhYV9kZXYtPmRldmljZS5uYW1lKTsN
Cj4gPiAtICAgICAgIHJldCA9IGRwYWFfZXRoX2Rldl9jbG9zZShldGhfZGV2KTsNCj4gPiAtICAg
ICAgIGlmIChldGhfZGV2LT5zdGF0ZSAhPSAgUlRFX0VUSF9ERVZfVU5VU0VEKSB7DQo+ID4gLSAg
ICAgICAgICAgICAgIGRwYWFfZXRoX2Rldl9jbG9zZShldGhfZGV2KTsNCj4gPiArICAgICAgIGlm
IChldGhfZGV2ICYmIGV0aF9kZXYtPnN0YXRlICE9IFJURV9FVEhfREVWX1VOVVNFRCkgew0KPg0K
PiBDaGVja2luZyB0aGUgc3RhdGUgbG9va3Mgd3JvbmcuDQo+DQo+IElmIHRoaXMgZHJpdmVyIC5y
ZW1vdmUgb3AgaXMgY2FsbGVkLCBpdCBtZWFucyBhIHByb2Jpbmcgc3VjY2VlZGVkLg0KPiBBbmQg
aWYgcHJvYmluZyBzdWNjZWVkZWQgYW5kIGEgZXRoZGV2IGV4aXN0cywgaXQgc2hvdWxkIGJlIGlu
IGF0dGFjaGVkIHN0YXRlLg0KPg0KPiBOb3csIGluIHRoZSBoeXBvdGhlc2lzIHdlIGVuZCB1cCBo
ZXJlIHdpdGggYW4gYWxsb2NhdGVkICJ1bnVzZWQiDQo+IGV0aF9kZXYsIGl0IHNtZWxscyBsaWtl
IGEgbGVhayBmcm9tIGEgcHJvYmluZyBmYWlsdXJlLg0KPg0KPiBJIHNwb3R0ZWQgb25lLCBidXQg
aXQgZG9lcyBub3Qgc2VlbSByZWxhdGVkIHRvIHRoZSBjdXJyZW50IHBhdGNoLg0KPiBodHRwczov
L2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYl
MkZnaXRodQ0KPiBiLmNvbSUyRkRQREslMkZkcGRrJTJGYmxvYiUyRm1haW4lMkZkcml2ZXJzJTJG
bmV0JTJGZHBhYSUyRmQNCj4gcGFhX2V0aGRldi5jJTIzTDI2MTQmZGF0YT0wNSU3QzAyJTdDaGVt
YW50LmFncmF3YWwlNDBueHAuY29tJQ0KPiA3QzZmNGNiYTkwN2ExZTRiYTNmNzIwMDhkZjFlMjcw
NTY2JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNQ0KPiBjMzAxNjM1JTdDMCU3QzAlN0M2Mzky
NjI4MjUwODA3ODk3MDYlN0NVbmtub3duJTdDVFdGcGJHWg0KPiBzYjNkOGV5SkZiWEIwZVUxaGNH
a2lPblJ5ZFdVc0lsWWlPaUl3TGpBdU1EQXdNQ0lzSWxBaU9pSlhhVzR6TWlJDQo+IHNJa0ZPSWpv
aVRXRnBiQ0lzSWxkVUlqb3lmUSUzRCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9dzZWMzZmM0xZDQo+
IDZKQ2FaU2QwMHZheVdxSERLWnRWdVJ0UENTOGkxWEl2ZlklM0QmcmVzZXJ2ZWQ9MA0KPg0KPg0K
DQpZb3UgYXJlIHJpZ2h0IGl0IGhpZGVzIHRoZSBwcm9iZS1wYXRoIGJ1ZyByYXRoZXIgdGhhbiBm
aXhpbmcgaXQuDQpMZXQgbWUgdHJ5IHRvIGZpeCB0aGUgcmVhbCBjYXVzZSBmb3IgaXQuDQoNCj4g
LS0NCj4gRGF2aWQgTWFyY2hhbmQNCg0K
