Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F54CCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 07:50:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A45884026D;
	Tue, 11 Nov 2025 08:50:05 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011070.outbound.protection.outlook.com [52.101.65.70])
 by mails.dpdk.org (Postfix) with ESMTP id 859A14026A
 for <dev@dpdk.org>; Tue, 11 Nov 2025 08:50:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A13aXa16FYKGY1tmbFrCMgGOhWwjPxqQcIw0AekiI3YyAfBpTZ7Hv5DyuuX9rmjn21GXDD38SFou6ufG40jdc651dR8LoQ00ZASd2md52kQrnVgUD4gGo7WbyqPbe9Feb95onUR+haz72pElMg84M0dru5NOQVLlYPJlei1UM+wD/YdQVhJDvVY/iv7JibOw7mU/WwPVJDSJn5DZHMoNVwv24FozJtjtqwZPVjvL1+M+FeavOtOM1XsN7Lgbq5l0noCP4GrsgQOtgGmYo3SCzQb+BU6i9CQJw7yE7d8GyVIc+jZE+dgrQdNIvoWL864UccR5GAP3ZsiIERhzVxYpBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pmv8c9DIIsJbSl2pokr5e1693RiPyAG5v1en3GLG4n4=;
 b=RDN6M2bmWkhfhxbUpnY40e7Rawc2ydNXjttW9kr+9dpWZonQOOeUjyF2l0cRIP0vYd8kIPzA0EuanhVOBvdeW/6K3VI1oGXZVy4cF6XYpzM35ycyjN4ie//jDQej6cXcNZR8s+b43cYfiREjtZky0MUQDGpSrUhQaREUGFwecQJA1QCzzbkd+TOVpJElcUy+JTKvjLsCQEjWVZ03QXHhA1BoY7KnW2Fwd7GEGcf+Fa/d98tG15cB/AdXJ/y6WedWZsFbocO/d/5CmmYVMA+wMYRp3SNkudtzw+J5yTD0PT9Q1BGBVp1Z4lg4D6ZqvJdRVDdxToD5wEg7NmrKUqdZbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pmv8c9DIIsJbSl2pokr5e1693RiPyAG5v1en3GLG4n4=;
 b=W/OPdPPZquUHvLCImWc3OVxBqs+8sp9QOGlej805zyZew+9UKaF7SjijIT8KazBcNuM3RlCoLShuwaoOZekRQT4N9nCF5lemSPXR5oAOfMyTuYsZ1G7C51zHXL/7JXZRshoklDAbvRe96MBj99wcuJ1uiK4YbOUslFXf4G/CcIQoZ571/b1r4rf9gx6V2rMza5FpAvQ2RSTkhYmvtBgUWN3VLsa2Cp2QqERGfi94sbdGn77fIB9i5VL8XJGQiYGW3RNwRsHxp/7LFX7P865qwbD1a9liID6ek1ioYPjckDlqXz1/3LvASDR2VflklkV969fhc+22hAlGvD8YB2+Bug==
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by GVXPR04MB10149.eurprd04.prod.outlook.com (2603:10a6:150:1c2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 07:50:01 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 07:50:01 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Thomas Monjalon <thomas@monjalon.net>, Sachin Saxena
 <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>, Gagandeep Singh
 <G.Singh@nxp.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Stephen Hemminger
 <stephen@networkplumber.org>, David Marchand <david.marchand@redhat.com>
Subject: RE: [PATCH v6 4/6] bus/dpaa: disable qman Invalid Enqueue State
 interrupt
Thread-Topic: [PATCH v6 4/6] bus/dpaa: disable qman Invalid Enqueue State
 interrupt
Thread-Index: AQHcRK4px6aKhL8Vc0mgzHWICL6RerTrwFkAgAF1k4A=
Date: Tue, 11 Nov 2025 07:50:01 +0000
Message-ID: <PAXPR04MB93282215F6A4701BB6972C1689CFA@PAXPR04MB9328.eurprd04.prod.outlook.com>
References: <20251017044848.3269627-1-g.singh@nxp.com>
 <20251024061906.3535470-1-g.singh@nxp.com>
 <20251024061906.3535470-5-g.singh@nxp.com> <2722532.aiPYRZItUj@thomas>
In-Reply-To: <2722532.aiPYRZItUj@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9328:EE_|GVXPR04MB10149:EE_
x-ms-office365-filtering-correlation-id: f5b7a3e4-fb04-437b-7910-08de20f6eb61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?a0VLdktna3BuYzZtMHdMWmRqeUpJd0poN2N5c1hJbHV2bjJGV1I1NDFTVEw0?=
 =?utf-8?B?RXhhZ2dCa3ZNUzRWb3ZxWE9hWEtMbVY0UW5KME5jbWxXbU9MdTV4Uk1yRlZh?=
 =?utf-8?B?MG42eDUrVGtFbWY1NzIxM1hQKzV6WFQ2U1U2UHZRMElvNSt5eEhYVVJzQ2Jn?=
 =?utf-8?B?WjFrUXU5bHg1aWNzUlBaSDhTQlM2YzlSY1pNRzZ3MEZybHllS0hDb1VkNUUr?=
 =?utf-8?B?TE9NWVlQUjVLdTlKMlV6L2lGbkFaeHE4RkRDUkpqOVl6Zlg3aU5WL2w2Qm9i?=
 =?utf-8?B?UERDeHpQZHYwT1hqTGtRRk5WcDFROXllRkp2d0E5cTR0azZpakxtay9nUjFC?=
 =?utf-8?B?MUFadFczbnExSDkyVkhxdTZYYlc0R1lJMlJRcHJmSUZKK2M3SURkOWZ2TzUz?=
 =?utf-8?B?Sk1XUVZ2MmluMG1yTEdhV0tSUWFwQjUybDMrbU0zbmk4TWU5a3VoSCszaVAv?=
 =?utf-8?B?V0xna2dmYURINU1ZT0FOWEpDelNkNXdUbVNvcDVjYzFZYmN4ZG5BT1dvWXRu?=
 =?utf-8?B?RFNabjZOa2owei9idnVsNllQeGlPemtVYVlKeTRHbERkMFpVQUFDOWd4WmI1?=
 =?utf-8?B?c0ZiMWtreEdPdWxvQmtJMlVNMTJwQktkY1ZTaXZ2NnBTd0FlYnVWY0ZQMWtp?=
 =?utf-8?B?eFlHdnZpUzFhZ25GakZ6ODlQai96enZGQis2OVIxbEV1Sk1VZzJLN0RsL0Qx?=
 =?utf-8?B?bGJuM0w4aXltbVRKdDRMMWJEcGthLzNBeTRNWTY4Q3VEM1FYQU9qNDcrc2VJ?=
 =?utf-8?B?N09DQ3FXcCtTZzhKaTRHcnhwRDFiOWE4SjduYzUvOGdpYm1NcmE1d1dFcm5m?=
 =?utf-8?B?Wk9NbGhLMDgyeG9Bc3ZPcW9IYnNvODFJSjNvRFRDZ2FqbjRObUF6TlFDRlo3?=
 =?utf-8?B?V1UzeHRDOTB2cXpaaG1oSVRtYUJ6bnBMRlBHazE5dnc3YzAxcWd0L2orR3Ur?=
 =?utf-8?B?Ync4OXQzU2pvM3ZXUzdUK2Z6QlRFaDRIeG9wZ0k0MHZERWp0b3IvdjIrVmw1?=
 =?utf-8?B?am5BQmRCdm1BMUVTRlFtdnpvYUs4QitBOHAvWDU0V0RDL0pVdjlWVDkwNWJl?=
 =?utf-8?B?NnVRZzBIU2w4MGNVVkRRNzE1aUZrL3FSbUtMS3l2cEw0VFM5UU0wZEtZejlz?=
 =?utf-8?B?Wk0zMTB2cFB4dlVKenhxU2hrUXFiVVFJcnNJN1VlYTlNTGdpcTc2aUFvYXBE?=
 =?utf-8?B?c3J2UGJRcGRMS3RzOEkyWVVWb3RsRDZEbVErZllIWVczUVpjRWV3anJkcVJz?=
 =?utf-8?B?STh0Ni9GSkYrNGRxcFgxM0JtdXVMY1Rad1VOMGlVWGM5KzI1b3ZVQ3dGaU5T?=
 =?utf-8?B?Q3B3cGYrZFVFR2xkZ2FnNm8yUUdjMjFXbmFaMXpJaWtwN1NCNFFyNUlkOTJy?=
 =?utf-8?B?MmNwbS9meFI2akF6bXhoVXNUTVlyWXdGQlFjVldyZTdNK3ROMGVUMnovL085?=
 =?utf-8?B?WEpkMmVnY0NqeUh2WkViaGY2RENITjNDcDBsVnVDdGRlQ0I2ZWQ0QXpFRG5R?=
 =?utf-8?B?NStkTi96OW5qOFAzRHJFS203eG5YSXFJNHFScVV0d1BTaG1VaHNHZnpRQlg4?=
 =?utf-8?B?ZXdmWUk3NlVaNDRNT0RzZ0ZZZXV2UXkyRFBRanFJMEl6azNwRExKbHZTdURI?=
 =?utf-8?B?WGhjanhLN1NPNTFUcmlvUCtNZzVOQzl1ZmlXeDVwSGxYRVlMNE44UVlZTURW?=
 =?utf-8?B?dHVDZlZ0cTZKWjdDVlgyL3M0WU5iZU8wZUwzaDQ5YTA4TGRab2pTb2dWWVJR?=
 =?utf-8?B?MzNJQU56Ym9YSzkyZUpjMmM4eE56eDA3ZC9pVHQ2ckhzcWh2dkhVbEZkMXR3?=
 =?utf-8?B?ckFjT3ZNWkllYVlJaUhFc2FUQ0duR1R6UDNaOE4rOGEvbzV3enNJTUZRMUla?=
 =?utf-8?B?VmFSTlBVbWprUC9McldWWFdOUndaMythSk84b2pQakZnQmZlY0NaeEdzVjlR?=
 =?utf-8?B?RmRobGc0UHFkQlJReFJtMkV4MUROMkZ0ZFNpbGhZOUtVTElDNCswcE1qMWVT?=
 =?utf-8?B?bGdaVUoyaVFtZXBmUG8xalQ0WWdrU0tDMDZzaXFweW1KVlltUVdNaC8zYk9y?=
 =?utf-8?Q?UIXgCQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWIreHBUS1FzNC9QSy9la2tXMWoza0lYeVM3L1k3VkcvTlJwNk5VMnMrelpH?=
 =?utf-8?B?L043VGQyd1JPNGgrZGNDLzhadlBZTW1aMGFJcTJwUFJJTnVaeWY2enkxK2Np?=
 =?utf-8?B?V1R6S3dPdjF6bnpENjB6Y2RjSGdYVVZsR2hMaitQQm9ZSWpYYXlPbzB3bk9z?=
 =?utf-8?B?Y0tVSlZ4bmxOMkRhUlhaZ1NtWXRKNmxoeE00dDU3Q0l1QnZGNU8zM2Q5VVZF?=
 =?utf-8?B?OXV6VlNtN1ZRUFp5MzYxU0Q1QzIveVVCQllHYnk1Rm40dStXczFTUlR1V3I4?=
 =?utf-8?B?S1RlZFVIK2J1UW8rczB3czhtd3J5MVRKdVZzUnJlZERyWmlhd0s0UFVVbmg1?=
 =?utf-8?B?TjVteGkzMHBqZjRjSDZ6RG91dUhBUnlhTkNScnlOYjZQRE1WeEhETk5VYlJt?=
 =?utf-8?B?NXhmMkQzbEJpRDU5bHA4OUVWTlloaTI0dU9Wb3Y3UEFHYko1TjVxVFJJdFNh?=
 =?utf-8?B?NVVyc0ZZb240MmpYWFlGM0dMM3VRaXpZdmk1dWRwN3VMS0p4cjhra3Q2TVNF?=
 =?utf-8?B?TkVybHlkMkFtbHZMRmFZR1dIdDVsemtxaVhOZmc1Skh4NU1UMksxNDV6cnVS?=
 =?utf-8?B?bEhrZ0oxYzlBKzZvUzAxN1lYVHJGWEEwVmNtNDdzNTBobld2VjdMUFJ2RzYy?=
 =?utf-8?B?YTcxWDUySnFBSExaUjhGdWpVVzAwR3g2YTE0TnlxWW51eWFVZFB5RDR1Vy8r?=
 =?utf-8?B?VzFRUWRHbk1Ga3IzVWd1bDlGMXBDSm9PS283NGQzTWdEYkg2ZVNETTZCUFBD?=
 =?utf-8?B?bVRhVS9ZUDNjVEJOWVpHViszZ2p3cUpCZ29KdlJpdzUwbjZGOXNBS3lBV3NX?=
 =?utf-8?B?SUtYTXJ4V2c0cDZOSGpYWXVWU0Q3TzJoR2VZQ29BbEkzREhqa0hNU1ZCN1ZQ?=
 =?utf-8?B?ay84RlVGeDEwNmE4QS9ndGZpeitXVTF5MHdaeXY4bkl0VFVIOFNDT0FiQml5?=
 =?utf-8?B?bE4wbVBRQmRpejFZM3hCVGxCaDdBa1B6alh3NHJKL3U3ZTV2SnJyQVl4MnFJ?=
 =?utf-8?B?Q3krVEZTUng2TFZ1bitjS1dxS0pMNkpDblh5emdDdDVVTmdYQ2JmM0svZE1D?=
 =?utf-8?B?Z1hWWXhUQStDaXhBbjhzcXlkQ2tmTE9qOUk0TWdreFNvZC9ZZ0h6VDcxM1lH?=
 =?utf-8?B?d2xHSTVJTXgxYTRYUVVsVURsZ2psVkNwc2hXM3FTZzF0aG51MnRqWFZnSXpF?=
 =?utf-8?B?eGwwYnhxQnFCSmpLdUp0ZlRwelk4bHNRYVR6OTVUSnF1TndxWGpOV29jR1dH?=
 =?utf-8?B?aUVjSk1BMWRJVS9uQnpMNE1rRjV1NllZdklLZTBxd0tDWFZuTUU3MFRxSnJi?=
 =?utf-8?B?bTFvK0FNbEdIRis0N1lKUWJURm9RNGdVbnI3NWhTdDNXSnV2dDJVMXBmSzlS?=
 =?utf-8?B?WjZCSmdsZVhiRG5USDN4RENmSmZBQ3Q4RmJrOFErMTFNM2JabHZ1d2REU1hC?=
 =?utf-8?B?eDVkUnpUK09UOVdtYVJNbkxBQ2FrRXQ4MWNIZGhSYnVMcmg0MGdENjc2ZEVq?=
 =?utf-8?B?b005Q005SzkvQ2pzRnU0R2RPaTdmbG9FaUJ0c2tNdU41a0NiSzNNQUp1ZnVz?=
 =?utf-8?B?MTh2SlRyR3N2MmE0NlBBb3BCa3NMR3RmSXppZFkxL1lnQmptVm9Nc1NVeWpR?=
 =?utf-8?B?dUg5TnZuMWpJQnpwenBJZWtaZ0hGZWl4OFozOHZnamxEa2J3a2Y0NVRzak5p?=
 =?utf-8?B?Z2VhY2pockxSRnN2dWZCU09HdUlDVGVNUjV5S0kvZy9remQ2MDdTR1ZlTitZ?=
 =?utf-8?B?amtXaERudVVMQlhRblNYbFNuSEpwOVVBb1g3R1U1cUhncGJlWEp6ZkRaeHFn?=
 =?utf-8?B?VVVTbE43ZWtiMDlkZjV2N0hrT3NCckxkN0pFVUNDTU9FbktTMHFCMmVTSGFE?=
 =?utf-8?B?eDBLUFp6UVkwSEUxZFpOL3IrbW1mM0ZTbnE0TjFicGk0NVJZT3FPcllFcGFS?=
 =?utf-8?B?b3U2ekJIei8wWXVzVDJoUkMrZmpMQlpmYW5QbjFJZzhpYS84OFhzMy8vaCs2?=
 =?utf-8?B?dzRkN0ZkcGtGQmFBVHJqeTlmcFZtb0xnbnQ2UTRHc3JLdENIWUpyY1ZZVGhQ?=
 =?utf-8?B?WHBZQm1EQVJYUkRxM3F0WERQR2hEU0RKdEF0Q3NhWmN3ZWsrM1ozTVpOdzVB?=
 =?utf-8?Q?qWwHrAz4WGwtiksWX+NEIuBJ7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b7a3e4-fb04-437b-7910-08de20f6eb61
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 07:50:01.5636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q/pbOUlNZxiKvBEowaKloaIcg2GCxQlh/mb/wnHkAEL1pqAEvqiazps9pT+P/E4fRuJGob79mxS2I6eoA8MaKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10149
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9tYXMgTW9uamFsb24gPHRo
b21hc0Btb25qYWxvbi5uZXQ+DQo+IFNlbnQ6IDEwIE5vdmVtYmVyIDIwMjUgMTU6MDINCj4gVG86
IEhlbWFudCBBZ3Jhd2FsIDxoZW1hbnQuYWdyYXdhbEBueHAuY29tPjsgU2FjaGluIFNheGVuYQ0K
PiA8c2FjaGluLnNheGVuYUBueHAuY29tPjsgSnVuIFlhbmcgPGp1bi55YW5nQG54cC5jb20+OyBH
YWdhbmRlZXAgU2luZ2gNCj4gPEcuU2luZ2hAbnhwLmNvbT4NCj4gQ2M6IGRldkBkcGRrLm9yZzsg
U3RlcGhlbiBIZW1taW5nZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPjsNCj4gRGF2aWQg
TWFyY2hhbmQgPGRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjYgNC82XSBidXMvZHBhYTogZGlzYWJsZSBxbWFuIEludmFsaWQgRW5xdWV1ZSBTdGF0ZQ0K
PiBpbnRlcnJ1cHQNCj4gSW1wb3J0YW5jZTogSGlnaA0KPiANCj4gMjQvMTAvMjAyNSAwODoxOSwg
R2FnYW5kZWVwIFNpbmdoOg0KPiA+IEZyb206IEp1biBZYW5nIDxqdW4ueWFuZ0BueHAuY29tPg0K
PiA+DQo+ID4gU2hhcmVNQUMgcG9ydCBpcyBzdGlsbCBhbGl2ZSBhZnRlciBkcGRrIHByb2Nlc3Mg
cXVpdHMgYnV0IFJYUSBzZXR1cCBpbg0KPiA+IGRwZGsgcHJvY2VzcyBpcyBpbiBpbnZhbGlkIHN0
YXRlLiBJZiBoaWdoIGxvYWRpbmcgaW5ncmVzcyB0cmFmZmljIGhpdHMNCj4gPiB0aGUgRk1hbiBQ
Q0QgdGhlbiBpdCdzIGVuLXF1ZXVlZCB0byB0aGUgUlhRIHRvIGdlbmVyYXRlIGZyZXF1ZW50DQo+
ID4gaW50ZXJydXB0cy4gVGhpcyBjYXVzZXMgc3lzdGVtIHN0dWNrLg0KPiA+IFVzZXIgY2FuIGRp
c2FibGUgdGhpcyBraW5kIG9mIGludGVycnVwdCBieSBlbnYgdG8gYXZvaWQgdGhpcyBpc3N1ZToN
Cj4gPiBleHBvcnQgRFBBQV9RTUFOX0lFU1JfSVNSX0RJU0FCTEU9MQ0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogSnVuIFlhbmcgPGp1bi55YW5nQG54cC5jb20+DQo+IA0KPiBGb3IgdGhpcyBwYXRj
aCBhbmQgdGhlIG5leHQgb25lLA0KPiBJIGRvbid0IHRoaW5rIHVzaW5nIGVudmlyb25tZW50IHZh
cmlhYmxlIGlzIGEgZ29vZCBkaXJlY3Rpb24uDQo+IFdlIGhhdmUgZGV2YXJncy4NCj4gQWxzbyB0
aGVzZSBlbnZpcm9ubWVudCB2YXJpYWJsZXMgYXJlIG5vdCBkb2N1bWVudGVkIGF0IGFsbC4NCj4g
DQo+IA0KW0hlbWFudF0gWWVzLCBZb3UgYXJlIGNvcnJlY3QsIHdlIGFyZSBzbG93bHkgbW92aW5n
IGF3YXkgZnJvbSBlbnYgdmFyaWFibGVzLg0KSSBoYXZlIGFza2VkIEp1biB0byB1cGRhdGUgdGhl
IGRvY3VtZW50YXRpb24uIA0K
