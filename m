Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C8ECD8CA8
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Jun 2026 06:11:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75C5C4027F;
	Fri, 12 Jun 2026 08:11:27 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
 by mails.dpdk.org (Postfix) with ESMTP id B2C3E40279
 for <dev@dpdk.org>; Fri, 12 Jun 2026 08:11:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSB0VpJ1+mYNl7A0aIijkACWmNhOXV1LVWPq/ZhN96nn3VjdjaNa/25ZlC2We2h9pA9odG7hEaiQ7JFdx7SPApczPKIWbGHlv1K2ic9+sWN72zRmflSUCPgK2VbhpQ8D0h8mrrSBi9ukIaQ8wI+dvOYEawmC+AlXV7tle3RL1656DKoRM5Lzk357CjT66XP/86zROFlqsT5nkO3ElZI6bSgs1MVKYoA8FZMyB8MR0amOXlEJdAUTGlCvE1ngp93sRwSI4kQvgzi7yHfQnA9CLRM4qDp89p2WK5Eu59voybZGSYUTtnmFGDWq0zapXXx8xuhH8ekQwYZbzucKK+GX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sp/TkYU/4uaft9pBo47R5KAFScRmYXEMD/NkQWUxrWw=;
 b=o3HJIUJVZJKSvwPmBtJAegA2b6cCuKIlNpVUT0RKGK5cw+unfm3hk0hmA2z+fW7M0fREY4tG8S4FHffr/5iK9ZXoWdv2BBm7qBkYXccuxcEdjN0veDtXViZdCJ1HREOVonzvlV7YmF570bMvkzHUVz52jIRfekBK/BlUDhrMvHqfjCGFV2Fcn1hWX6Jz6vRbJaFaU9itJwz5tOnqUB46Raoso2eMal8D9g0BWQcYAdgPfoC4/wl8iBglqpfzwZkTgrgbWfwNmWYHCat2UdEdRaDg4k37hWemAFSRkRTeQywXe8hjwMMsLwQBkvbaHcma0jJlnXP4MCzihVu1DhIyZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sp/TkYU/4uaft9pBo47R5KAFScRmYXEMD/NkQWUxrWw=;
 b=ECxMStXr0P1l0gn6+D56raHOVU+H/UxlrIvg7hbktOAGykn4HxoOiZsEr5+gk8Swxdnh6X9RUCWrRqHVgFliq65boSXQPzwRU2xAi8tZtMqu8KWn7Df4du1Lr1K68tihy1jFAqx8r0FAB44poG+4v0MYEo4RjriaEm4MiSLuG7vSTCp2icvcQ3bhNpSj3to4d0q4bsBT8strp8JbvhDV3YBG46XvP4f6ihtIKNmMoLt01KoG3oMybKJOMVMRuh0clsxcL+1K15+oo03gWKLPkWRJ67O/sW9WPcSxsG4fNGWylpWLFd+VZxG0NzcHPWd9Xy2DMgBwHjXjAyUA6cq03A==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by VI0PR04MB11700.eurprd04.prod.outlook.com
 (2603:10a6:800:2fc::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 06:11:25 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 06:11:24 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, Wathsala
 Vithanage <wathsala.vithanage@arm.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Maxime Leroy <maxime@leroys.fr>, Gagandeep
 Singh <G.Singh@nxp.com>
Subject: RE: ARM v8 rte_power_pause
Thread-Topic: ARM v8 rte_power_pause
Thread-Index: AdzzT/Q/gutdQ3oPTzyy3YuhY3IVZAGWx3xw
Date: Fri, 12 Jun 2026 06:11:24 +0000
Message-ID: <GV1PR04MB10750E293DBDCCDF9FEEFE00289182@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F658E5@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F658E5@smartserver.smartshare.dk>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: wathsala.vithanage@arm.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|VI0PR04MB11700:EE_
x-ms-office365-filtering-correlation-id: d9622691-1737-4a70-e431-08dec8496eae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|23010399003|376014|38070700021|6133799003|18002099003|4133799003|22082099003|11063799006|5023799004|56012099006;
x-microsoft-antispam-message-info: nt5wgFFa0O46Xvh2LS6CR8TjZeVEd/VNn1VZFZgmYVf+MREKoZTAsR/UFFIzNUUEfSF7D4e7nT+Ci6jnWtUIwGa5Jp95H5TIXIlgN5EQ8pCTf/e+LmiDVVqI+mXECZqAc04U5Ei8AIeOIgM17GJQ8K5eibI2T1qCVkjV68eckItwIQ6I8FXkBWMophqcpSurJOLnJO+ygAzgkVLzWQY86Ru2LsUGxsy6ce/BvQE84KblBNcAEK4rmBWbyXuG8hyxZSCZp28OIPdftqz6k8YqGWZ46SGiJsNVsJJxXiZXGGQ8BsHV9m3TZOrzalXQ3t7vE4HH8aRkNo9j4hZ3jQZdw/m+5MJCtEOHmBf8lk2k4AjElz74ghO3nYlNAWFqcmaKOrOJaHkdBsbf2fBrItq0NNpnMIjniaZfoGRqWWsTJ0Ei00JG/FAUaV7UKejn0y7Z3L2BFpROoB3zJbZl8TwH7MxvC/WCB2UvxAtGWMam1cu9MJEdMfnVRigMCgf2M9kfT8yp9i++evYtmDzyo+23Cwl6+uhS69EGD9jyZG7SNpnMPt7C18lEA42zElg4gt17wiq9tvcleMrwhEJKkFio/F16+6+Woz6pBq38IM90iIk8huvlsQC8OF79Nt04IGAlSD75jXkUTBJTJ+TLHEMVCUq8Z6w6r4Qumi6qNOcqp1hcA57Hr/UAiBH+BaBSXIVzVBW1eF7c6Rd7bhDzJvmUdzB/ugAnSFQZ7W3kA31I10PohDtEW3iuP5+WsmRN8ZQs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(23010399003)(376014)(38070700021)(6133799003)(18002099003)(4133799003)(22082099003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RThwN21MbmdZWkNuZFlrVkVlZnhlbDBDaWdWUnZKUW1reVppbmFHNlZtZlR3?=
 =?utf-8?B?am1zY0hnRzR5SUh2Ny96eDFnODZoUDZjdjhtUDYxbElKK2tpd2pRa1M0L2xh?=
 =?utf-8?B?UVBvYUthbHVRMC9la29NaHAxK3BUUjJoZlJFTWZuVG5mbjNISzBLMmtyY2VF?=
 =?utf-8?B?WFYwVWE2SzFodGRxamlMZnRZbHVQSnV4RGVXM0pxdFBMYUJuTEFFdVNkemlF?=
 =?utf-8?B?V1pxNHRMME5yWlZqRUVCN1lETGUvcjBBazVUeXNUR2VpNGRNWlJmakpXdFE5?=
 =?utf-8?B?Zjg1L0tJZ0JXSzdaRm13K3BIbTRvV3N6OFVxdERHTjdUYi9XWXpTNXBZNmxX?=
 =?utf-8?B?NjZVTW44QTBGeWJYMlFScFJ6TDJmOUhUVEdHa0dDSnpITUg1MXpIaDR4bXdJ?=
 =?utf-8?B?eGNQMFNENkE3Z0FQaHV5NXBJSE5JMmVIRkg4ZGVlN0hteEpOMGZld2ZIMlhS?=
 =?utf-8?B?RnRxd1dDeEwycUNhekJ1VDJSSUhpcHg0MDNXTU9nbkE0UTZLR3ZtZVBUMk9n?=
 =?utf-8?B?a200NXIxc2VlUVEwL0xmNDlCMTZldzBkU0xUbW4yR1I0c2JzMTV6OEpNTkxN?=
 =?utf-8?B?N1J3N04rdy9UN1lWTHJJRkorYVRwc0NrWDF6T29wR1pVMmdKK3BpOVQ2MXc4?=
 =?utf-8?B?ZmRqZnptdU9sUElZbW9jVXN3N28rN3NOUWRnNHhSTDNHK0dwS0ROUUdUSVR2?=
 =?utf-8?B?aWF2QXVjUjRhWCs1WnJ0Y2RWa3YyK0Y1QWl3OFExbmVNVXdRS21jZWxEZHZF?=
 =?utf-8?B?OWQvOWlIZDYvYlpSUlBSNlR2TFNVajRaRG5JVVVzQ1J6enRObmF6ZXdtbm1U?=
 =?utf-8?B?NVU5aWZ6UVRxN2lycytYdnVqTS9IQWw4V09DMTROOXphRHdrb2hxOVF4TEtB?=
 =?utf-8?B?M1FJeW1CNThHOGttMXFnVjRlaXU0N0hQalBFK2pTM0FQQURsOEJIdmR0V3My?=
 =?utf-8?B?YnJiTnY3OHE1dTBPcjdobU9LeDJtanFSSE1Dbncvci81WTJ1aUpocmErKzdu?=
 =?utf-8?B?QmlSTTRQMVR0Mmw3YTl5RXhnWTBvMEtkRVRHWHM4M2Z5eENvMk9RTW1IcS9G?=
 =?utf-8?B?Uy9qSlljMlBYbGt2ZTRDdk15TXlJSENicnZWM0JVVDNUYXFNK2xuV2hCNEV6?=
 =?utf-8?B?a2dWWU9oQWFnaGVJM2kzRDdrUG1mR2FIeUhNU0g3TDR2eGQxSWE1UTVTc3lq?=
 =?utf-8?B?RWFtMnUwR2JiWFVER2FWeVpNSGFHUUZ6UDlLb2JOWDN1cUpEQmwxbTVLeEZN?=
 =?utf-8?B?RC9xQnhuTkMzZXZ2SGVOcDdRZFpJQ2pUYXpiaStGVXFyT01LSTA5c2lFZTFC?=
 =?utf-8?B?S1NuTUNkV0ZuSkJEaWxlS01GUVRON05kRzNPUEdpZGVXdzNsYXMzeXlwVEhm?=
 =?utf-8?B?Mkk2UWVLNzdKelc1cGxoZTJBNXUrSVRwRVo3MlhrVHVER3c3QThDK1hwNFph?=
 =?utf-8?B?bHhndXlsODA4SC9sNXlJelBmclhzazFLNi9hSzlTQ3BNM1MxWVNXQ2tiMzZ3?=
 =?utf-8?B?YVFsMGRTclJhTnV5V2wvM3RJdXN4bjN0TUJTYkRaWVNGTHNGYzB2SWxUWSs3?=
 =?utf-8?B?RFRpbnl3K0pMamFkUXlFZ0JtRHA3TEJlNGlYZ29NUGQ0YzJmYTdYTXRsWGV0?=
 =?utf-8?B?clBOSm5mbjBFeXVQNjZGU2hQUXVxSmx0UGhYTFdSZmxpd2FTNjg5UDlWM3Ra?=
 =?utf-8?B?NUE1azlSeGJFUUdkQkc5WFFwRm1MUU1Cc29oREh5K3Fua251Z3J3SGlTUVky?=
 =?utf-8?B?VHNoR2ptSDh5WUkyU2hJazZ2aFVkRzRJYUptVTdnT1NYdEFsUitncC9oUVo5?=
 =?utf-8?B?Q0YyMmJjeXpYeHhNa1JSM1YzK0Z5RFNOQVoybDJBQk5zWEpRbzdvSnpIUXpD?=
 =?utf-8?B?c2k4SXlncWZrWElKTlcyYkpCeEZhVWlPWjBDUXFqVzRzNXBwUE5Sa21FbUZy?=
 =?utf-8?B?VDhyc09tTERKMkRqUW1XN0MrRXd0Y3pPa3V3VEJLeXEyQzRlSyttN0NRUTg5?=
 =?utf-8?B?cnEwYjBDQTQwR1Y5UnQwNHdpU2RYdWMxdTlDT1ZheExzVkRSNEZRSjVvaG12?=
 =?utf-8?B?Sk9jUWF1MlpGT3QxcHJvZ29LRzBnV3FnWk5iZDdJc0NlUE4vblladVNIYkNj?=
 =?utf-8?B?YldBSU9XdmxFamR3U3hlWE9nd2R3dVorUGhMM3FGK2pYZ01mM296OUhZeDZi?=
 =?utf-8?B?NEJaWUVnNi93NlByOEFDcno4WVFSSmNxcEFrZzVxZXRrZTlrVHN3eXZSTHZQ?=
 =?utf-8?B?cnY0NHpNSE96TEV3SzRNWWdFZ3J5YTJwMGR3bmYyNTVwQ0RYejQ0NnhldVZ2?=
 =?utf-8?Q?jB2pQz4e3dIZAsEy+T?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9622691-1737-4a70-e431-08dec8496eae
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 06:11:24.8166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yMmH7D/CwO1zHKH+BY0x4Zwvtzuh/J4tATFwkvA1pZmac+7DmWVqCp8s6Ghxb5aKasx+8t0UFRn7liz/3FJIHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11700
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

SGkgTW9ydGVuLA0KT24gQ29ydGV44oCRQTcyIChBUk12OCksIHRoZSBvbmx5IGFyY2hpdGVjdHVy
YWwgcHJpbWl0aXZlcyBhdmFpbGFibGUgYXJlIFlJRUxELCBXRkUsIGFuZCBXRkk6DQoNCglZSUVM
RCBpcyB0aGUgb25seSBkZXRlcm1pbmlzdGljLCBsb3ctb3ZlcmhlYWQgb3B0aW9uIChwdXJlIENQ
VSByZWxheCwgbm8gZW50cnkgaW50byBsb3ctcG93ZXIgc3RhdGUpDQoJV0ZFIGNhbiBiZSB1c2Vk
IGFzIGEgbG93LXBvd2VyIGlkbGUgaGludCwgYnV0IGl0IGlzIGV2ZW50LWRyaXZlbiBhbmQgbm90
IHRpbWUtYmFzZWQgKGl0IG1heSByZXR1cm4gaW1tZWRpYXRlbHkpDQoJV0ZJIGRlcGVuZHMgb24g
aW50ZXJydXB0IHdha2V1cCBhbmQgaXMgdGhlcmVmb3JlIG5vdCBzdWl0YWJsZSBmb3IgdGlnaHQg
bGF0ZW5jeSBsb29wcw0KDQpGb3IgfjEgwrVzIGxhdGVuY3kgdGFyZ2V0cywgdGhlIHByYWN0aWNh
bCBhcHByb2FjaCBpcyBhIGh5YnJpZCBzdHJhdGVneToNCg0KU2hvcnQgd2FpdHMg4oaSIHNwaW4g
dXNpbmcgWUlFTEQNClNsaWdodGx5IGxvbmdlciB3YWl0cyDihpIgb3Bwb3J0dW5pc3RpY2FsbHkg
dXNlIFdGRSBmb3IgcG93ZXIgcmVkdWN0aW9uDQoNCkEgc2ltcGxlIGltcGxlbWVudGF0aW9uIGNv
dWxkIGxvb2sgbGlrZSAobm90IHRlc3RlZCk6DQoNCnN0YXRpYyBpbmxpbmUgdm9pZCBydGVfYXJt
djhfcGF1c2UodW5zaWduZWQgaW50IGl0ZXJzKQ0Kew0KCWlmIChpdGVycyA8IDY0KSB7DQoJCWZv
ciAodW5zaWduZWQgaW50IGkgPSAwOyBpIDwgaXRlcnM7IGkrKykNCgkJCWFzbSB2b2xhdGlsZSgi
eWllbGQiKTsNCgl9IGVsc2Ugew0KCQlhc20gdm9sYXRpbGUoInNldmwiKTsNCgkJYXNtIHZvbGF0
aWxlKCJ3ZmUiKTsNCgl9DQp9DQoNCkBXYXRoc2FsYSBWaXRoYW5hZ2Ug4oCUIHdvdWxkIGFwcHJl
Y2lhdGUgeW91ciB0aG91Z2h0cywgZXNwZWNpYWxseSBpZiB0aGVyZSBhcmUgYW55IG1pY3JvLWFy
Y2hpdGVjdHVyYWwgbnVhbmNlcyB3ZSBzaG91bGQgY29uc2lkZXIuDQoNClJlZ2FyZHMsDQpIZW1h
bnQNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNb3J0ZW4gQnLDuHJ1
cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0KPiBTZW50OiAwMyBKdW5lIDIwMjYgMTc6MjYN
Cj4gVG86IFdhdGhzYWxhIFZpdGhhbmFnZSA8d2F0aHNhbGEudml0aGFuYWdlQGFybS5jb20+OyBI
ZW1hbnQgQWdyYXdhbA0KPiA8aGVtYW50LmFncmF3YWxAbnhwLmNvbT47IFNhY2hpbiBTYXhlbmEg
KE9TUykNCj4gPHNhY2hpbi5zYXhlbmFAb3NzLm54cC5jb20+DQo+IENjOiBkZXZAZHBkay5vcmc7
IE1heGltZSBMZXJveSA8bWF4aW1lQGxlcm95cy5mcj4NCj4gU3ViamVjdDogQVJNIHY4IHJ0ZV9w
b3dlcl9wYXVzZQ0KPiBJbXBvcnRhbmNlOiBIaWdoDQo+IA0KPiBIaSBXYXRoc2FsYSwgSGVtYW50
IGFuZCBTYWNoaW4sDQo+IA0KPiBPdmVyIGF0IHRoZSBHcm91dCBwcm9qZWN0LCB3ZSBhcmUgZGlz
Y3Vzc2luZyBwb3dlciBtYW5hZ2VtZW50IGluIHRoZQ0KPiBjb250ZXh0IG9mIDEwMCBHYml0L3Mg
bGF0ZW5jeSBkZWFkbGluZXMgWzFdLg0KPiANCj4gcnRlX3Bvd2VyX3BhdXNlKCkgaXMgbm90IGlt
cGxlbWVudGVkIGZvciBBUk0gdjggLyBDb3J0ZXgtQTcyLg0KPiBTeXNjYWxscyBzdWNoIGFzIG5h
bm9zbGVlcCgpIGhhdmUgdG9vIG11Y2ggb3ZlcmhlYWQsIGFuZCBjYW5ub3QgYmUgdXNlZC4NCj4g
DQo+IEFueSBzdWdnZXN0aW9ucyBmb3IgYSBwb3dlci1yZWR1Y2luZyBtZXRob2QgdG8gbWFrZSBh
IENQVSBjb3JlICJzbGVlcCIgKGkuZS4NCj4gZG8gbm90aGluZykgZm9yIGR1cmF0aW9ucyBpbiB0
aGUgb3JkZXIgb2YgMSBtaWNyb3NlY29uZD8NCj4gDQo+IFsxXToNCj4gaHR0cHM6Ly9ldXIwMS5z
YWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZ2l0aHUN
Cj4gYi5jb20lMkZEUERLJTJGZ3JvdXQlMkZwdWxsJTJGNjI0JTIzaXNzdWVjb21tZW50LQ0KPiA0
NjAyMDM2MzY0JmRhdGE9MDUlN0MwMiU3Q2hlbWFudC5hZ3Jhd2FsJTQwbnhwLmNvbSU3Q2RiZmY1
ZjJlDQo+IDhkYjE0MDZmMGM0MDA4ZGVjMTY3MTc5MSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5
YzVjMzAxNjM1JTcNCj4gQzAlN0MwJTdDNjM5MTYwODQ1NzI4NDcyODI2JTdDVW5rbm93biU3Q1RX
RnBiR1pzYjNkOGV5SkZiDQo+IFhCMGVVMWhjR2tpT25SeWRXVXNJbFlpT2lJd0xqQXVNREF3TUNJ
c0lsQWlPaUpYYVc0ek1pSXNJa0ZPSWpvaVRXDQo+IEZwYkNJc0lsZFVJam95ZlElM0QlM0QlN0Mw
JTdDJTdDJTdDJnNkYXRhPURScEpXam0yeWFGM0NuaGswYg0KPiBiRkZobUdiS1J3ZU9PaVdkc1dj
bzJOYlgwJTNEJnJlc2VydmVkPTANCj4gDQo+IC1Nb3J0ZW4NCg0K
