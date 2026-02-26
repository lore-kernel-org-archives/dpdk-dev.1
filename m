Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03DCFD8FE1
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 17:09:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEBF5402B2;
	Thu, 26 Feb 2026 18:09:44 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013026.outbound.protection.outlook.com
 [40.107.201.26]) by mails.dpdk.org (Postfix) with ESMTP id 9C45A4028F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 18:09:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFVrA8exMiNo6QWTpO6IOpsFv/3AfJF/fPjbJD0Z+zhNPi7oUFAbIMeQkq697BrwENf+arNolwo75i1vD/bBjl1Bc5tHbDUiY3DQ8mrKKu3Jj+0t5PNGqztJqDXB8hDr3bZni2+RG24Gudt8ZGxARIcOGExLtloF9m/cD1ynH15Ji3RbcWEFtmdK9yNkW/+jRQLWbpgWQElD6yvIF8dgamp04WZRzOUFes4yqcJdDHZBetRVHPTRs6LrEltHB2/OaV+HMiThhgbnSgEBrYgfwbuZ8l02TQ/1HEzyoOzHWtoy2uX3PbmMCH6fa3qZPAXdHSET+vSfNSp32xztQGUsVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxJda82ejSJrRLKvJMN/IMKa1bjJMqLCni52E9StQ3Y=;
 b=IIz0eUkQOC1Yk0BtSE0RD+zz6owbzmJ93wW8PuVp4boBCW1NY7IDDifz5WferBkDd4RHASVcAcHCbbTGuiqclHBw3pHOSG70319NLQYkASh1eTaw5L3yHJu/gkipLCdedKSFsRAdxccfVyqV3x+goq+1tpWQ154BlCNZH33r0L8aJadX88dSb9gBOeJddoNf4JjjtrwpT4z9NKv31vqZdvP4wwlNrhml9KKUwL4dmCLEEJ2jtL8tf/jRQz1aYJCeHknoTty+8zJZcQPK6PKE/JTopLazkDB3yrZgNTbAUFRUPiTCgw0f/wE6jqFXStKdp530EQrwsXxHUyiU3rTRnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxJda82ejSJrRLKvJMN/IMKa1bjJMqLCni52E9StQ3Y=;
 b=UIZz+bObrc9CmqDfPESGBSWkLn4O3mCo5HlKIMHxM5qXhVngk0p98WHXF5aZoUYf+rWVWT2NPlq8ikYY/8OGe7PNVDWuqx+idYV9reHefSso48Rzh7wHrK74da5NzhQ4j657GVTtU94AjPZwJeYPTaGdvhmrk+EedA4/l1Mryng=
Received: from SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 17:09:39 +0000
Received: from SN7PR12MB7321.namprd12.prod.outlook.com
 ([fe80::9f76:498a:5cd4:d25d]) by SN7PR12MB7321.namprd12.prod.outlook.com
 ([fe80::9f76:498a:5cd4:d25d%3]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 17:09:39 +0000
From: "Natarajan, Ashok Kumar" <AshokKumar.Natarajan@amd.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Sebastian, Selwin"
 <Selwin.Sebastian@amd.com>
Subject: RE: [PATCH v2 1/3] net/axgbe: add external PHY read/write functions
Thread-Topic: [PATCH v2 1/3] net/axgbe: add external PHY read/write functions
Thread-Index: AQHcplS5E0PkR29kREGxMFtAX2ZuPbWUCtKAgAEnIiA=
Date: Thu, 26 Feb 2026 17:09:39 +0000
Message-ID: <SN7PR12MB7321038CA06FFEBBE9CB05F18172A@SN7PR12MB7321.namprd12.prod.outlook.com>
References: <20260216125205.1032-1-ashokkumar.natarajan@amd.com>
 <20260225124456.1871-1-ashokkumar.natarajan@amd.com>
 <20260225150907.54d467ef@phoenix.local>
In-Reply-To: <20260225150907.54d467ef@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-26T16:45:26.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7321:EE_|PH7PR12MB5830:EE_
x-ms-office365-filtering-correlation-id: c5dfd258-3f89-44ad-dd63-08de7559d392
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: 4mX19p5Zgt69WtQ/1pEZZBWNV39NkP9p/fRV5KI3EUp8nMPMeOgqOWcULDPhc12WsQhU7/3QTqTAa4MUaEXimrnigevFK3E639KzwQKhPJXI+7D0omPesL68lJHXGOwyqf+Wpdfez0uB9TEaVTn6X4MeKrkCvZz0dzf9zngx8NM4G2PaGXxsDSWLpgQ1kw4v51v9xIgBijqYkOotyKxKSpSB+qRXNPnsXMWOApegM1n5Lr80+1LWjxfAwizKYeevbJ0v94N4QWvNzSBlcIhlF+aYbyLzgm/fouZQy6akTpkaro0IwtC57BDUyr/MKGkQ8ztSLcbmXqT61mSXVJ7e2DDQ+UVP0wQv47qJg5aECg5CwA1dQT23OTdoBeKcSnmphu24Z7hramG/2RqLUF8ZBI87cK7zdxUlgyK261EcRHuNfrXX/gdO4jBBAv0eHh+PdL2nGQCf1+I12Fsme1m3Rou8XpQvz0lxamqRNDNWDVbDoQ47lzFE1e9Ut8FU9cJFmpx6UCwCaNMRfpXrpHEi9G875sU4I939aCmOH+0SynahaW5yZZWTCmY0ENvQWE4bLH8c0VayjOisr3FJ4iOF3FRTRtcyzgi+cqBxKVQMRqfNHa4zQbfP4PtSU/LazgSSOQeU3CYlRgdtnFmTArXmr4Hq7t4auwPGt0N5KAVu/XKq9Sgfyy1IVgpdElL+NVKy7IrAgpeqqmYovnSqXX/vTdzBqaZ9vGX8/bX+GnW998WHS4cIFcQ0oidX68vPZXtKeX4fbpIRRhqWrxsRyetFc3yzhtAA6Y6NMHeB1ex76l4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7321.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUtnU3FhRXJjNXVTL3lHb3Nkd05hNUsxb3hiOHdBWkdRM2VmNG9qcEhMbGxU?=
 =?utf-8?B?L2pHbXVzc0tmTmRhekp6Z1FsTy9heUN4YW5yWHY2NkpwV0hxbWcrL1hQR29t?=
 =?utf-8?B?TkZVWEZyZUd0anU2RnZDOGRmWTJEay8ybjVnU0IvQ21INi9zWndzVWhMREly?=
 =?utf-8?B?d2RmZ0R6Vk9NUG13YUYwZ01YS3R3RWFZaWRFNmM3RElmNU5BZ2pja3B4OUli?=
 =?utf-8?B?UFcrQy9NTU1JZHFRSlk3OVpYRmpaNXhwYzE1U2lJRXd4L3FCeTNxSG9CQVdQ?=
 =?utf-8?B?SEpEQWRNMGl2Q1JnY2NsckNNRC8rRXprTWhuTDZRclhOeGNQZFVoUTFaZVpl?=
 =?utf-8?B?UnFETlBCWmszK1JWSUVnODVZcGR2cklYS0I5L1VqUGxPOXBmMGNyUk5HMzVR?=
 =?utf-8?B?cHdVN29nUEZSdC9IQjI3M0lkOElVN0ExQ1p0ajR3N1BtanpqZTdQU3dqNzlN?=
 =?utf-8?B?NXllZzlZMGw1RVRTRmNPa0xrenkzRy9QTmErMWFNcWFJZWVXQkNSbXFHSFdh?=
 =?utf-8?B?azFuWDBiRTZlOTB1SWx0WVlINm40YjVJY1NpUDJNOGk0dXRwbVF2TnNESFJi?=
 =?utf-8?B?cHl1ZzdoMjNURnRRZWxtM0gvMkhGYTVvKzVMbUpoUWRRQnBUMHZGd0JaSThK?=
 =?utf-8?B?RndHc1R6TDFXVGJKNkFJZE03VmV6TjNMVmpYOFl2WUI2eDh6MU9ZT2M4ZEN3?=
 =?utf-8?B?YVQ1dEpnbzZnVW9Bc1gvV1ZndlVxR01nY3YxQnFqdUVaMDJIU0lEem9OR0FG?=
 =?utf-8?B?UWE4WEltWlVXdTRvc0ZKVXdwZGREWFo1c0tEOGZadDFIbEJzdlVGVElkVjV3?=
 =?utf-8?B?RDdaYVE1eGg4VHY3UjF6RFNJZ1RrZ3hUOG96RTYvTHlsR1ROTnlIUGNpZS94?=
 =?utf-8?B?ZytMWVRyc3VoTWZLWW55Q1pqMTZ0WHl4bGRxQ3A0UjFuTnZtSjFwVXdRKzFj?=
 =?utf-8?B?WGJoTEFWRy8va0I2UTBUZUNDV25ScFRZY1pxSTBVL0hab05Ua1dxVzdySVdw?=
 =?utf-8?B?d1pMUTRRV0NnWGhNMzhNaFhWWkJhdGM0ZUZUbS8xOTV3dFVpT0U0YlBVYXlh?=
 =?utf-8?B?RzcyMDBzblZ6RDNXcXNZZGZyT0dEdm0rN3YwMm10bTQ1cW0rc0hLc1h0OEtx?=
 =?utf-8?B?eTBJcG9uSmFkMmpLd3lmYms5eTVzRlhCcWNIS1MvK1d1T2pGTGo5S25UN1hH?=
 =?utf-8?B?MFBiSHhFbzdyZUlyM255eDA0T2l6Lyt2MXhrdW8veWRmV0hleVpYSDRHVTNt?=
 =?utf-8?B?M2Nud3FQN1BSYVlmY2RvTktabUpid0VWN0ora3JyZ21FbzJQcENVSEg4TkZM?=
 =?utf-8?B?Q2hyMTRXcUU0NDY4NzFwelU4azlXWnRySHFZU2NCUGU4RC9Lam9VKzBPMW5l?=
 =?utf-8?B?Wlk4dDk5TG41bExTbzRpOWg1Z2V3S1ppZEFvTkVMOVVaRjcvTC9NUzdZQ3N2?=
 =?utf-8?B?SGJmcWtoc2lLZVFOcXd6SysvN0RBNXNqNG5RU2wvUnVNN3JqMDdvWFpDdXN5?=
 =?utf-8?B?MFRJQjYzcHc3MjlTUnVGTUIwS3VVeGdpeVB5UVJiUjhRMlZnbml6ak5GTGJX?=
 =?utf-8?B?L21pQWxhL0QyemRwZFZEbFBuZ0IycS9qUGZNZXRMQjNpbWsxWHhuK2hvS1da?=
 =?utf-8?B?ZE9Tb1JoNitNUG9RWHI3a2VkNnVmbXhaK1FVWW5lYWtMclZpaE15dmJueU1T?=
 =?utf-8?B?N2tpVEhkSWs5cDF0VTh5WDZSNXZUUTBXWktBSWZ6RFRwb2h0RDlNdEM2THhk?=
 =?utf-8?B?SEhFU1d0bnljR05oS2x5UFJaeGpvK2VKazNYeThwaWp6NmVXWmRnYXc5VE5E?=
 =?utf-8?B?U0Y5U3pJLzZGQ29lM1BUSHhWTkg1b0FhNVRrWURQWWZOSlJBZ29sWlc0ZUJH?=
 =?utf-8?B?SWROS2psdFg2MTRROXlVRjdDdjNPNGw1SXgxTklmVWkrL2h4aFJsY2ptTHB0?=
 =?utf-8?B?aU5MTXdScEdibTFxUVJwZ0RubVF6YUJqa1FOYkVXRGp4Y0hHN2hyNStJc3pU?=
 =?utf-8?B?a0RKVmNGeUMvdzdOaXdpalcvQXM1OW16dTJ1Y2NxUktkYUhPSFhEQzBBMzJt?=
 =?utf-8?B?NnphdWZTUHp5VlJndkNZejRMak1mOExldC9IdFdyOFVtM0R5eVFIdkZyRVpO?=
 =?utf-8?B?SnNRMENKcjNFVHdHaGVTYnZicHp3eTFRRVRjY1VnZ0p1V0k5ZFVxOXJYZFl6?=
 =?utf-8?B?QkxzanpZQUxqT25xN284Y3lUVTA3UTE5dGlhdnlTRFlITEt1Qnh6QWx2RUFp?=
 =?utf-8?B?Qm82M3BOMmRrVzNoZTZGZWhWM2hTQ2E3L0ZaTmZhdzR2cUt2eVJUblA5U2Vz?=
 =?utf-8?Q?pnAQGdcLtNcrK4EhbR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7321.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5dfd258-3f89-44ad-dd63-08de7559d392
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 17:09:39.4991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TpAUZynoFOLTU92ThBewmts6xghPZgJdPBdIkrYoOAzuR2VzUiwPdy7KDOsh4k4xa764iOYXju8RiO+trUXazA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpheGdiZV9waHlfbGlua19zdGF0dXMoKSBmb2xs
b3dzIHRoZSBleGlzdGluZyBkcml2ZXIgY29udmVudGlvbiB3aGVyZSBpdCByZXR1cm5zIDAgd2hl
biB0aGUgbGluayBpcyBkb3duIGFuZCAxIHdoZW4gdGhlIGxpbmsgaXMgdXAuIFRoZSBsb2dpYyBp
biB0aGUgcGF0Y2ggaXMgYWxpZ25lZCB3aXRoIHRoaXMgYmVoYXZpb3IuIEFkZGVkIGEgYnJpZWYg
Y29tbWVudCBpbiB0aGUgY29kZSh2MykgdG8gbWFrZSB0aGlzIHJldHVybiBzZW1hbnRpY3MgY2xl
YXJlci4NCg0KVGFrZW4gY2FyZSBvZiB0aGUgb3RoZXIgY29tbWVudHMgaW4gdjMgcGF0Y2hlcw0K
DQpDb3VsZCB5b3Ugc2hhcmUgd2hpY2ggQUkgdG9vbCB3YXMgdXNlZCBmb3IgdGhpcyByZXZpZXc/
DQoNClRoYW5rcywNCkFzaG9rDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz4NClNlbnQ6IFRo
dXJzZGF5LCBGZWJydWFyeSAyNiwgMjAyNiA0OjM5IEFNDQpUbzogTmF0YXJhamFuLCBBc2hvayBL
dW1hciA8QXNob2tLdW1hci5OYXRhcmFqYW5AYW1kLmNvbT4NCkNjOiBkZXZAZHBkay5vcmc7IFNl
YmFzdGlhbiwgU2Vsd2luIDxTZWx3aW4uU2ViYXN0aWFuQGFtZC5jb20+DQpTdWJqZWN0OiBSZTog
W1BBVENIIHYyIDEvM10gbmV0L2F4Z2JlOiBhZGQgZXh0ZXJuYWwgUEhZIHJlYWQvd3JpdGUgZnVu
Y3Rpb25zDQoNCltZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gc3RlcGhlbkBuZXR3b3Jr
cGx1bWJlci5vcmcuIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5t
cy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KDQpDYXV0aW9uOiBUaGlzIG1lc3Nh
Z2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9u
IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcu
DQoNCg0KT24gV2VkLCAyNSBGZWIgMjAyNiAxODoxNDo1NCArMDUzMA0KQXNob2sgS3VtYXIgTmF0
YXJhamFuIDxhc2hva2t1bWFyLm5hdGFyYWphbkBhbWQuY29tPiB3cm90ZToNCg0KPiBJbnRyb2R1
Y2UgaGVscGVyIGZ1bmN0aW9ucyB0byBwZXJmb3JtIGV4dGVybmFsIFBIWSByZWdpc3RlciByZWFk
IGFuZA0KPiB3cml0ZSBvcGVyYXRpb25zLiBUaGVzZSBoZWxwZXJzIGN1cnJlbnRseSBzdXBwb3J0
IG9ubHkgSUVFRSBDbGF1c2UgMjINCj4gUEhZIGFjY2VzcywgcHJvdmlkaW5nIGEgc2ltcGxlIGFu
ZCBjb25zaXN0ZW50IEFQSSBmb3IgYWNjZXNzaW5nDQo+IHN0YW5kYXJkIDE24oCRYml0IE1JSSBy
ZWdpc3RlcnMgb24gZXh0ZXJuYWwgUEhZIGRldmljZXMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFz
aG9rIEt1bWFyIE5hdGFyYWphbiA8YXNob2trdW1hci5uYXRhcmFqYW5AYW1kLmNvbT4NCj4gLS0t
DQoNCkkgZGlkbid0IHNlZSBhbnl0aGluZyBoZXJlLCBidXQgQUkgc3BvdHRlZCBzb21lIHRoaW5n
cy4NClBsZWFzZSByZXZpc2UgYW5kIHJlc3VibWl0Lg0KDQpUaGFua3MgZm9yIHRoZSBzZXJpZXMu
IEEgZmV3IGZpbmRpbmdzLCBtb3N0bHkgaW4gcGF0Y2ggMjoNClBhdGNoIDIgKE04OEUxNTEyIHN1
cHBvcnQpOg0KDQoxLiBheGdiZV9waHlfbGlua19zdGF0dXMoKSBhbHdheXMgcmV0dXJucyAwIChs
aW5rIHVwKSBldmVuIHdoZW4gdGhlDQpNODhFMTUxMiByZXBvcnRzIGxpbmsgZG93biBvciB0aGUg
cmVhZCBmYWlscy4gVGhlIGdvdG8gb3V0IHBhdGggbGVhZHMgdG8gcmV0dXJuIDAsIHdoaWNoIG1l
YW5zICJsaW5rIHVwIiBpbiB0aGlzIGZ1bmN0aW9uJ3MgY29udHJhY3QuIFRoZSBsaW5rLWRvd24g
YW5kIGVycm9yIHBhdGhzIG5lZWQgdG8gcmV0dXJuIGEgbm9uLXplcm8gdmFsdWUuDQoNCjIuIElu
dGVnZXIgc2hpZnQgVUIgaW4gYXhnYmVfZ2V0X3BoeV9pZCgpOiAodTMyKShwaHlfaWRfMSA8PCAx
NikgZXZhbHVhdGVzIHRoZSBzaGlmdCBhdCBpbnQgd2lkdGggYmVmb3JlIHdpZGVuaW5nLiBJZiBi
aXQgMTUgb2YgcGh5X2lkXzEgaXMgc2V0LCBzaGlmdGluZyBpbnRvIHRoZSBzaWduIGJpdCBpcyB1
bmRlZmluZWQgYmVoYXZpb3IuIE1vdmUgdGhlIGNhc3QgYmVmb3JlIHRoZSBzaGlmdDogKHUzMilw
aHlfaWRfMSA8PCAxNi4NCg0KMy4gYXhnYmVfZ2V0X2V4dF9waHlfbGlua19zdGF0dXMoKSBkb2Vz
bid0IHNldCAqbGlua3VwID0gZmFsc2Ugb24gdGhlIEJNQ1JfQU5SRVNUQVJUIGVhcmx5LXJldHVy
biBwYXRoLiBXb3JrcyB0b2RheSBiZWNhdXNlIHRoZSBjYWxsZXIgcHJlLWluaXRpYWxpemVzIHRo
ZSB2YXJpYWJsZSwgYnV0IHRoZSBmdW5jdGlvbiBzaG91bGQgYmUgc2VsZi1jb250YWluZWQuDQoN
CjQuIFRoZSBuZXcgb3V0IGxhYmVsIHVuY29uZGl0aW9uYWxseSBjbGVhcnMgcnhfYWRhcHRfZG9u
ZSBvbiB0aGUgTTg4RTE1MTIgbGluay1kb3duIHBhdGgg4oCUIHBsZWFzZSB2ZXJpZnkgdGhpcyBp
cyBpbnRlbnRpb25hbCBhbmQgZG9lc24ndCBpbnRlcmZlcmUgd2l0aCB0aGUgaW50ZXJuYWwgU2Vy
RGVzIHJlY2VpdmVyIGFkYXB0YXRpb24gc3RhdGUgbWFjaGluZS4NCg0KUGF0Y2ggMyAoMTAwTWJw
cyk6DQoNCjUuIFRoZSBTUEVFRF8xMDAwIOKGkiBTUEVFRF8xMDAgY2hhbmdlIGluIGF4Z2JlX3Nn
bWlpXzEwMF9tb2RlKCkgaXMgYSBidWcgZml4IGluIGV4aXN0aW5nIGNvZGUg4oCUIHRoZSAxMDBN
IG1vZGUgZnVuY3Rpb24gd2FzIGluY29ycmVjdGx5IGNvbmZpZ3VyaW5nIHRoZSBNQUMgZm9yIDFH
LiBUaGlzIHNob3VsZCBoYXZlIGl0cyBvd24gRml4ZXM6IHRhZyBhbmQgQ2M6IHN0YWJsZUBkcGRr
Lm9yZyBzbyBpdCBnZXRzIGJhY2twb3J0ZWQgdG8gc3RhYmxlIGJyYW5jaGVzLg0KDQpJdGVtIDEg
aXMgdGhlIG1vc3QgY3JpdGljYWwg4oCUIGl0IGludmVydHMgbGluayBzdGF0dXMgcmVwb3J0aW5n
IGZvciB0aGUgTTg4RTE1MTIuDQo=
