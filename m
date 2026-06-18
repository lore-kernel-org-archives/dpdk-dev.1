Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49248CD98DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 06:17:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E4B64027E;
	Thu, 18 Jun 2026 08:17:28 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010070.outbound.protection.outlook.com [52.101.69.70])
 by mails.dpdk.org (Postfix) with ESMTP id 1D19840268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 08:17:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYppQBKgw6jokuoBwO9GDOHlcLywt5WEk8o+L1qhsfB+d4K/+O7AcQZcjUzvcFFgk/cOqXTx3ArqD9hM21+Od52KC49eyFx1yRZdtvvpQtkAe+dtNQIJwEoqvURZkSFE3PP9XqWwOb7LHPTLBCkvEAnAoCokvp3LV4zLlYKuiVnN5gHbVzAdNRHvcTvsnqoIVLHzES6zU4jJ4CzrzmcnxybM7FzMfJ+c3oN9ISQWyNketTezaRquQRPmIDEVZ3m9sTIHD872AXym+o9Md8mxAWrt3XREb89JbPMVniLZn5kNBle4au+ndmLEzc7FcIS1GDmLKOw9/FcXYTrnuzRHsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tK/mVYq5WdoHBBJ73yZSaRMhM9bkYj0BXNFio59a7sI=;
 b=bDsugy/6x9pkbgAi7EEZKr0irF0o1bnQEPDWHL68pGy1o2V+bjZjenFGmTm86Vi1zTskCpNW5DRS4RmJ8X96UtymMbIZhLeUzifrS0rUanh9t/U6xHfN3MKEF7ka7fgIBavEYT9bbXEBMRx5kYc0vT4lmUJTw9P/Kw5ygwXR/OH2wWx/ctIQ1d51ocyeJbYW8fTt8emeAROQCQ9vzxRoPCTniPkrQo6SiEwNbqS/e9TIFaEYOmryNauSV6hGsGJUe/cx1S9ietX+m0GXQZN3nEqTfCvAAXhzgiBCXaP7dc1MIGEj1VpTmp+VaXv8ck9SPpgpCpgSa6Y842KdzJcF3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tK/mVYq5WdoHBBJ73yZSaRMhM9bkYj0BXNFio59a7sI=;
 b=GTFuOghtmscpVQA3FFLRE1xZmhxTroP94Xhh3NjM1AIBuUX6cAcNrOz3QE/h/91pyY4rXhjhGa5c3zOJfaZAtwebxXroqBEiYc7ES7dJ5shkw9V3FG+JRhHebq5fV+mcXF4/jABJD78xMcdEJ5Gp/IvOxPISE1SEBi4iOQFFC+NUUAXkrySKJTDAvNkRIVbPcONhirl8+NsYYXOIinM4o+zQ5BbGBD7s8G806/5sf84PPHZkRtDW4CymRyxYG7k9q9CrHc1ypFDjxo7661FtqDeuTe+ZRgDDSIXA86xo3hkjcklepQLHyryy54Bl+EcyK4YGSjfnkerm2tEAH6xdCg==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by DU4PR04MB12345.eurprd04.prod.outlook.com
 (2603:10a6:10:62b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 06:17:24 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 06:17:24 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>,
 =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Maxime Leroy <maxime@leroys.fr>, Gagandeep
 Singh <G.Singh@nxp.com>
Subject: RE: ARM v8 rte_power_pause
Thread-Topic: ARM v8 rte_power_pause
Thread-Index: AdzzT/Q/gutdQ3oPTzyy3YuhY3IVZAGWx3xwASlV5gAAJmMs0A==
Date: Thu, 18 Jun 2026 06:17:24 +0000
Message-ID: <GV1PR04MB10750F8AC96BEFB29C1DD13BD89E32@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F658E5@smartserver.smartshare.dk>
 <GV1PR04MB10750E293DBDCCDF9FEEFE00289182@GV1PR04MB10750.eurprd04.prod.outlook.com>
 <09dbd9b1-f4a6-48e2-9424-546eafdfa01b@arm.com>
In-Reply-To: <09dbd9b1-f4a6-48e2-9424-546eafdfa01b@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|DU4PR04MB12345:EE_
x-ms-office365-filtering-correlation-id: 8c4220f9-1261-4e3a-30a0-08decd014366
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|19092799006|366016|6133799003|4133799003|4143699003|5023799004|11063799006|56012099006|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: mJx8LhIDAEDKQkA/UIQmqjuvd4RixLvg1uECOuB5O+KXUSqsFq7/2TZgduoy/F5uqdA3JfttaJ0xRAaAeiYoZy4GWot9vAAsUrce6G8u3AfTDwERu036mV/KxJH6MwphxRhP22Ve++mRLnBWd3RUIyiRW6FvUpZD6KX5RLYME5RaGkYoIrAe3tuk/Lvjxbi7VZ52GJGeNyyJ3whs9LDKnuc3tjQ3Uf3w9hVbGUJS8F/+OZfow0KI546RIdnrEQ9XcgKqurfWhJLl9T/RKd9ixfz7e/5kR/Yi2CE1IhS4QW0RVLG564BUsAKKU5PkTJ8GDDeqyK+6G0X3mMaQfYWA+CAL6mmiiq8BPDlFCw08jv/W9a8YpqWFG2V/f6mWr4MHWFl+OAO0yAv7c6Nryafkd4uw5JcQtSNUBRZBz9T8uFkW5aL1ySEns34ZTqRntiYRfgp44RrxKDp4/HfS2Rsh/x1VmU1EvB0roEbfwpD93RmQDJPFlL0K/GOVAClgiCLDbZ1t37pZOozgNT5u2u5P1HTOnF6+N7jHmukb2cE+qlM8iaCfHw6Yn0GiMjMM4X4iF0nRXDCTtHzF2JTF4uiVRG2w/9nHt7N9M9HSLoOt9gWM3PFZ0T1p49xEmunP587CrLN5HFM7WVS6T3nib0Pw8ouIDDKzPQ73Mh8WC2UlRoUSfXQB8lrlJie4X4BdvmRURQ4XWF7fI+ohhazXMX4J3GBcLA6wGSKuJCWNgA7Ks8iKRNAXEzXR72NebWVk7Q+Q
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(19092799006)(366016)(6133799003)(4133799003)(4143699003)(5023799004)(11063799006)(56012099006)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bENydVI0OFdabjNueGhzWnJoUVlZRml0azlrNXNNUUpKUmMxUkpPdFh0dHhn?=
 =?utf-8?B?ZkhvQjgrSzlTc1lEVTdzR01EZ05pUUY5RCtDeGFSQVdxSVV6U1BXR0prbi9Q?=
 =?utf-8?B?OVVEakdubmEzSHBpUWhkU2h2QVArWDhLVXk1c21YL3VDNWZnekhGMk1Eb000?=
 =?utf-8?B?SHg2ejEwVXlLbm90NVNDQTNON3A5d0lHQnk1TldlUXhsenJIM1VEZnAzcGhv?=
 =?utf-8?B?MEhJVlAxSkx5bzdINjNlcG5JaTFTcmh2Q2dqdnozdFNKdTR6bjluNjlPV1FF?=
 =?utf-8?B?TnhFaU1zdTVjZW82RmI4ZlJlNTJPSWRTUG5Cc2gxZHJtZkVNRVhNM0l0VER4?=
 =?utf-8?B?NEF4MU9BeXRLM3JQZDFkaHlpYTJhN2NQL2p0aG5WZlZ2dGVpcmVSUUJEUDQ3?=
 =?utf-8?B?cHJOZDdNelJlb0Z3TnA4eGlPSmtnQW1JbTBwSkJ6TGtXK2E5OUZiN2h1TXhj?=
 =?utf-8?B?NkhNNjNsUmNRWVMrMWpHVXEzczlhUWZhV3BJRkFtVU5TRnhHZytxUUFid1ZM?=
 =?utf-8?B?VDVDYWJobWdyZlZYVW8rMnRERzFnUFVQRlBsREk5YzhZNEFRaVRxckJTQ1Z6?=
 =?utf-8?B?VHQ4UDl6QjhUZVFXUGVUVHF6ZC9EV2hZWmw5Q0JTVDBxY1RXazhxZXlPbjJi?=
 =?utf-8?B?eDJ0YnlZTVlHWVp1aHVqOUlxdG5IZFAvWEhIM1BTSVA2SlloS2dSZmF6S08z?=
 =?utf-8?B?YVNlR1RoZnVUNTgrbXpKdmlqRENBNTM4VjNMK2IrcERjSzUwWlluMzNrb3pX?=
 =?utf-8?B?RGorZGhVbnNvT0tvWEllOTlOTFdpSVVETEd5VEhRQ0FyVklpOWVQT0twT1dJ?=
 =?utf-8?B?aTlHU0ZpWDdoVFlsdVFlZEdGczJzSStTYndXMG1yNFc2WnZaMm1USklyeDIx?=
 =?utf-8?B?bW12bmtZZ1dZdy84elcvc1p4VHdUTmZLK1FxdTcxUHJhT0NJcmFsYXdhbmM4?=
 =?utf-8?B?eTVEOWMvRVpDL3NhZFJUSkx3SG1uYXdZWkFBSVZnWE96Ump6dnoyTTBUZTZ2?=
 =?utf-8?B?djJ0T3hucjlFcllibTBvTW00eURJdHhROVFRNVhTRjBTWlNNb2h0c040VU5O?=
 =?utf-8?B?alMwOGlrZkhKTkRveTY5RkdKREFRd2o5M1RMOHV5UWIyQTNLRFlvUVRZc0JO?=
 =?utf-8?B?U0ZwaDVuSVZTd29lSWlkNWNjanBKVEFkSWJHZFdWVG50ZytFOS9IUkhtZjFZ?=
 =?utf-8?B?djRraVRjT29qVXhrQ01SSVhTN0JOOCtzd0NqQWhJZUFJQTZyM1hRVTdFNm1G?=
 =?utf-8?B?ZzJZOGRkUzdlVzhiVDE3TXpRb1Vlam1OS2dGY2Y3ZjYyQkF0TCttYzcvUzNz?=
 =?utf-8?B?eGtPRTl0WVZ0S2JKSEJwa0M1azFBYitTcGFnUXdaWUx3R3lXZi9Wd1hSVXR4?=
 =?utf-8?B?K1ZKQUtkQ01YaU1qeUUxMGdxSWp3dzdHdXhpQ0JXenAwbDZxeXFBdkRTNkZu?=
 =?utf-8?B?bjIvK0V4SlpYMmJQQ1VKTkgrVVF6UjlFSzdqT1A0S0pLNDB2Ry9SZUJaMlNl?=
 =?utf-8?B?RDY2OHJvRzBSZ3VGMGs5aGpNWWFwL3Fva2hFY2l2YzhtbGVuajNXNGNNN2do?=
 =?utf-8?B?Wk90N29CV1VIOUx4Z2VJdk9Mdll2RDNGY3FxMXZOQ0EyOCtFOFdpajB2UUNu?=
 =?utf-8?B?SS9TWW4ydFFNakdVeG5LL1A3bVB5dnpJMlF4ZFJZaDZJaFNBT2g5Sm5nQllp?=
 =?utf-8?B?SzNUMFJmaHUxWUdlYkdlbmZ4NWd1UXZqNis2U3V3VUJyNG9TMXowY0RvVU5P?=
 =?utf-8?B?dk44eHg3aTNhMk9MVEVxeWQ4S2NuSkpQYTQ3eENKbkUxVVBCWGlYNmZTNlp0?=
 =?utf-8?B?Rk5melVVVXROVlJLY1FXNUNrSUNHandrYjlaanJMWklhZDR5N21mcUFnUyt5?=
 =?utf-8?B?RDhtNE1JdjllczJFU3hrNjQ1M0ZZbWJBem92T2lFazE0OHN5L3hTcFRRWXBS?=
 =?utf-8?B?dGwvNElvbXNROVdBcENWVWE4YlFtRDR5NHBWcDJPQUx2RjZnSUdYZG4xemFC?=
 =?utf-8?B?Vm96WnlzM0l4eFAwVGdaTTA5b2FJTlB0VnB4NDZISXVhalFjZjhONUV1VmEy?=
 =?utf-8?B?TXJFV3I0KzhXMHdrenJKV3JKWHU2Y3BsMGluRzVsK1RiMTFJUUZmSG5BN2pT?=
 =?utf-8?B?ZUZSV0J3YmR0b2FtQVM5eWs1dnJvUFBUdTZUczBxNFhDMFBMTkZtSFlpZGxu?=
 =?utf-8?B?NjVIcTdQRno5TlZvemdVV0ZtUHJJTlN6L1lhWUREcFJkTnVPSXFmc0hiL1hk?=
 =?utf-8?B?d2g2OGRidjBJd0U3VDBOdmE0NGpWejZiUVpMRU9DTGUvdlVmQWRDQzhkUFlY?=
 =?utf-8?B?MCtTK3ZoTjZ1dEg0Z0V1ZGlOVHJUUTgvQm11d3djbDZXQzh4NkpkUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4220f9-1261-4e3a-30a0-08decd014366
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 06:17:24.2122 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pTY2uMjAJScnnM+Lo3fmm8Zq5ZWqxfUH/RBtLq/KaigDwUe2/V1WJmE0ET6Do/feQOgu5PykYuUSOFSXxyB10w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12345
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

SGkgV2F0c2hhbGEsDQoJSSB0aGluayBXRkVUIGlzIG5vdCBhdmFpbGFibGUgb24gQTcyIGNvcmUu
IA0KQ2FuIHlvdSB1cGRhdGUgeW91ciBhbnN3ZXIgdy5yLnQgQ29ydGV4LUE3Mi9Bcm0gdjguMCBh
cmNoaXRlY3R1cmU/IA0KDQpSZWdhcmRzDQpIZW1hbnQNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IFdhdGhzYWxhIFZpdGhhbmFnZSA8d2F0aHNhbGEudml0aGFuYWdl
QGFybS5jb20+DQo+IFNlbnQ6IDE3IEp1bmUgMjAyNiAxNzoyNw0KPiBUbzogSGVtYW50IEFncmF3
YWwgPGhlbWFudC5hZ3Jhd2FsQG54cC5jb20+OyBNb3J0ZW4gQnLDuHJ1cA0KPiA8bWJAc21hcnRz
aGFyZXN5c3RlbXMuY29tPg0KPiBDYzogZGV2QGRwZGsub3JnOyBNYXhpbWUgTGVyb3kgPG1heGlt
ZUBsZXJveXMuZnI+OyBHYWdhbmRlZXAgU2luZ2gNCj4gPEcuU2luZ2hAbnhwLmNvbT4NCj4gU3Vi
amVjdDogUmU6IEFSTSB2OCBydGVfcG93ZXJfcGF1c2UNCj4gSW1wb3J0YW5jZTogSGlnaA0KPiAN
Cj4gSGkgTW9ydGVuIGFuZCBIZW1hbnQsDQo+IA0KPiBZSUVMRCBpcyBhIE5PUCBvbiBub24tU01U
IENQVXMsIHN1Y2ggYXMgTmVvdmVyc2UuDQo+IA0KPiBXRkUgaXMgdW5pdmVyc2FsbHkgYXZhaWxh
YmxlIG9uIEFBcmNoNjQsIGJ1dCBpdCBjb21lcyB3aXRoIGEgY2F2ZWF0OiB0aGUgQ1BVDQo+IGNh
biByZW1haW4gaW4gYSBsb3ctcG93ZXIgc3RhdGUgaW5kZWZpbml0ZWx5IHVubGVzcyBhbiBldmVu
dCBpcyB0cmlnZ2VyZWQuIFRoYXQNCj4gZXZlbnQgY2FuIGJlIGdlbmVyYXRlZCBleHBsaWNpdGx5
IHZpYSBTRVYvU0VWTMKgYnkgYSBkaWZmZXJlbnQgQ1BVLCBvciBpbXBsaWNpdGx5DQo+IHRocm91
Z2ggYWRkcmVzcyBtb25pdG9yaW5nIChMREFYUikuDQo+IA0KPiBXRkVUIGlzIHRoZSBzYWZlciB2
YXJpYW50IGJlY2F1c2UgaXQgaW5jbHVkZXMgYSB0aW1lb3V0LCBzbyBleHBsaWNpdCBvciBpbXBs
aWNpdA0KPiBldmVudC1yZWdpc3RlciBtYW5pcHVsYXRpb24gaXMgbm90IHJlcXVpcmVkLg0KPiAN
Cj4gLS13YXRoc2FsYQ0KPiANCj4gT24gNi8xMi8yNiAwMToxMSwgSGVtYW50IEFncmF3YWwgd3Jv
dGU6DQo+ID4gSGkgTW9ydGVuLA0KPiA+IE9uIENvcnRleOKAkUE3MiAoQVJNdjgpLCB0aGUgb25s
eSBhcmNoaXRlY3R1cmFsIHByaW1pdGl2ZXMgYXZhaWxhYmxlIGFyZQ0KPiBZSUVMRCwgV0ZFLCBh
bmQgV0ZJOg0KPiA+DQo+ID4gCVlJRUxEIGlzIHRoZSBvbmx5IGRldGVybWluaXN0aWMsIGxvdy1v
dmVyaGVhZCBvcHRpb24gKHB1cmUgQ1BVIHJlbGF4LA0KPiBubyBlbnRyeSBpbnRvIGxvdy1wb3dl
ciBzdGF0ZSkNCj4gPiAJV0ZFIGNhbiBiZSB1c2VkIGFzIGEgbG93LXBvd2VyIGlkbGUgaGludCwg
YnV0IGl0IGlzIGV2ZW50LWRyaXZlbiBhbmQNCj4gbm90IHRpbWUtYmFzZWQgKGl0IG1heSByZXR1
cm4gaW1tZWRpYXRlbHkpDQo+ID4gCVdGSSBkZXBlbmRzIG9uIGludGVycnVwdCB3YWtldXAgYW5k
IGlzIHRoZXJlZm9yZSBub3Qgc3VpdGFibGUgZm9yDQo+ID4gdGlnaHQgbGF0ZW5jeSBsb29wcw0K
PiA+DQo+ID4gRm9yIH4xIMK1cyBsYXRlbmN5IHRhcmdldHMsIHRoZSBwcmFjdGljYWwgYXBwcm9h
Y2ggaXMgYSBoeWJyaWQgc3RyYXRlZ3k6DQo+ID4NCj4gPiBTaG9ydCB3YWl0cyDihpIgc3BpbiB1
c2luZyBZSUVMRA0KPiA+IFNsaWdodGx5IGxvbmdlciB3YWl0cyDihpIgb3Bwb3J0dW5pc3RpY2Fs
bHkgdXNlIFdGRSBmb3IgcG93ZXIgcmVkdWN0aW9uDQo+ID4NCj4gPiBBIHNpbXBsZSBpbXBsZW1l
bnRhdGlvbiBjb3VsZCBsb29rIGxpa2UgKG5vdCB0ZXN0ZWQpOg0KPiA+DQo+ID4gc3RhdGljIGlu
bGluZSB2b2lkIHJ0ZV9hcm12OF9wYXVzZSh1bnNpZ25lZCBpbnQgaXRlcnMpIHsNCj4gPiAJaWYg
KGl0ZXJzIDwgNjQpIHsNCj4gPiAJCWZvciAodW5zaWduZWQgaW50IGkgPSAwOyBpIDwgaXRlcnM7
IGkrKykNCj4gPiAJCQlhc20gdm9sYXRpbGUoInlpZWxkIik7DQo+ID4gCX0gZWxzZSB7DQo+ID4g
CQlhc20gdm9sYXRpbGUoInNldmwiKTsNCj4gPiAJCWFzbSB2b2xhdGlsZSgid2ZlIik7DQo+ID4g
CX0NCj4gPiB9DQo+ID4NCj4gPiBAV2F0aHNhbGEgVml0aGFuYWdlIOKAlCB3b3VsZCBhcHByZWNp
YXRlIHlvdXIgdGhvdWdodHMsIGVzcGVjaWFsbHkgaWYgdGhlcmUNCj4gYXJlIGFueSBtaWNyby1h
cmNoaXRlY3R1cmFsIG51YW5jZXMgd2Ugc2hvdWxkIGNvbnNpZGVyLg0KPiA+DQo+ID4gUmVnYXJk
cywNCj4gPiBIZW1hbnQNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
PiBGcm9tOiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0KPiA+PiBT
ZW50OiAwMyBKdW5lIDIwMjYgMTc6MjYNCj4gPj4gVG86IFdhdGhzYWxhIFZpdGhhbmFnZSA8d2F0
aHNhbGEudml0aGFuYWdlQGFybS5jb20+OyBIZW1hbnQgQWdyYXdhbA0KPiA+PiA8aGVtYW50LmFn
cmF3YWxAbnhwLmNvbT47IFNhY2hpbiBTYXhlbmEgKE9TUykNCj4gPj4gPHNhY2hpbi5zYXhlbmFA
b3NzLm54cC5jb20+DQo+ID4+IENjOiBkZXZAZHBkay5vcmc7IE1heGltZSBMZXJveSA8bWF4aW1l
QGxlcm95cy5mcj4NCj4gPj4gU3ViamVjdDogQVJNIHY4IHJ0ZV9wb3dlcl9wYXVzZQ0KPiA+PiBJ
bXBvcnRhbmNlOiBIaWdoDQo+ID4+DQo+ID4+IEhpIFdhdGhzYWxhLCBIZW1hbnQgYW5kIFNhY2hp
biwNCj4gPj4NCj4gPj4gT3ZlciBhdCB0aGUgR3JvdXQgcHJvamVjdCwgd2UgYXJlIGRpc2N1c3Np
bmcgcG93ZXIgbWFuYWdlbWVudCBpbiB0aGUNCj4gPj4gY29udGV4dCBvZiAxMDAgR2JpdC9zIGxh
dGVuY3kgZGVhZGxpbmVzIFsxXS4NCj4gPj4NCj4gPj4gcnRlX3Bvd2VyX3BhdXNlKCkgaXMgbm90
IGltcGxlbWVudGVkIGZvciBBUk0gdjggLyBDb3J0ZXgtQTcyLg0KPiA+PiBTeXNjYWxscyBzdWNo
IGFzIG5hbm9zbGVlcCgpIGhhdmUgdG9vIG11Y2ggb3ZlcmhlYWQsIGFuZCBjYW5ub3QgYmUgdXNl
ZC4NCj4gPj4NCj4gPj4gQW55IHN1Z2dlc3Rpb25zIGZvciBhIHBvd2VyLXJlZHVjaW5nIG1ldGhv
ZCB0byBtYWtlIGEgQ1BVIGNvcmUgInNsZWVwIg0KPiAoaS5lLg0KPiA+PiBkbyBub3RoaW5nKSBm
b3IgZHVyYXRpb25zIGluIHRoZSBvcmRlciBvZiAxIG1pY3Jvc2Vjb25kPw0KPiA+Pg0KPiA+PiBb
MV06DQo+ID4+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwcyUzQSUyRiUyRmdpdA0KPiA+Pg0KPiBodSUyRiZkYXRhPTA1JTdDMDIlN0NoZW1h
bnQuYWdyYXdhbCU0MG54cC5jb20lN0MwNmE2NTE1NzFkYg0KPiA1NDVkNDdkN2EwDQo+ID4+DQo+
IDhkZWNjNjc5MDhlJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3
QzYzOQ0KPiAxNzI5NDIzNTMNCj4gPj4NCj4gOTY3NjE3JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNk
OGV5SkZiWEIwZVUxaGNHa2lPblJ5ZFdVc0lsWWkNCj4gT2lJd0xqQXVNRA0KPiA+Pg0KPiBBd01D
SXNJbEFpT2lKWGFXNHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsZFVJam95ZlElM0QlM0QlN0MwJTdD
JTcNCj4gQyU3QyZzDQo+ID4+DQo+IGRhdGE9N05DaDMlMkJTM1RBdTFzUkxZZ3FHTkFhVHdxZGd3
anFoQXMyYXdQaXhJZUVNJTNEJnJlc2VydmUNCj4gZD0wDQo+ID4+IGIuY29tJTJGRFBESyUyRmdy
b3V0JTJGcHVsbCUyRjYyNCUyM2lzc3VlY29tbWVudC0NCj4gPj4NCj4gNDYwMjAzNjM2NCZkYXRh
PTA1JTdDMDIlN0NoZW1hbnQuYWdyYXdhbCU0MG54cC5jb20lN0NkYmZmNWYyZQ0KPiA+Pg0KPiA4
ZGIxNDA2ZjBjNDAwOGRlYzE2NzE3OTElN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYz
NSU3DQo+ID4+DQo+IEMwJTdDMCU3QzYzOTE2MDg0NTcyODQ3MjgyNiU3Q1Vua25vd24lN0NUV0Zw
Ykdac2IzZDhleUpGYg0KPiA+Pg0KPiBYQjBlVTFoY0draU9uUnlkV1VzSWxZaU9pSXdMakF1TURB
d01DSXNJbEFpT2lKWGFXNHpNaUlzSWtGT0lqb2lUVw0KPiA+Pg0KPiBGcGJDSXNJbGRVSWpveWZR
JTNEJTNEJTdDMCU3QyU3QyU3QyZzZGF0YT1EUnBKV2ptMnlhRjNDbmhrMGINCj4gPj4gYkZGaG1H
YktSd2VPT2lXZHNXY28yTmJYMCUzRCZyZXNlcnZlZD0wDQo+ID4+DQo+ID4+IC1Nb3J0ZW4NCg==
