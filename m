Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D28FD0055
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Mar 2026 04:36:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACA6840A76;
	Sun,  1 Mar 2026 05:36:06 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012060.outbound.protection.outlook.com
 [40.93.195.60]) by mails.dpdk.org (Postfix) with ESMTP id 8E6AF40B8C
 for <dev@dpdk.org>; Sun,  1 Mar 2026 05:36:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtmHamVznc5BeN2Uvs1KN1gU8cBB+OPgldyya3nYkam2foiQSvWIyBwX8mYxrcY4/BqHyKn7WLnG6WcSD8DvtT9C5wgULxJ8OhG6DKDSZdAcrRfk/f/Ueckx4yR6YbgaiC+OoOsQWPcO65C8WUgfyF1GcsSF3goXmdB83lSjabXD9irb8/M5CRho2ognW2hV2U2U/y/nk1McQoB4knxyTP2HFtR8uAAyvtIdzb4oM298iQ5BQTwvYkTDxbpqR0DhOCd7mHvhg58rK22yozUm/KfKsnkF4ixtiZOAOjub3NiCf+qZoHLgdPRcCgtqkBWXb7k0d2byXChXMw6HbO5aJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LIf2eec2aDwMSoUv+/VUpgPrHk9LgBiUIINTpOdVNI=;
 b=KaOjcaumcwjJnIwEDYEYv/a9OvN4/m0noYXMr5XaeMZKSuNtMupjU9obdYhgpara92VDaveegpPw3VOzFlyqMh512aP+wt+pitRD2r31LuPAt3KQqBwLdHoNbnq6E9ioFAsn4Pad1/n/CUn1AHWLcCkVGBMtTEONXU6Ih9v7mH4BsFF4GCminoX8XR76jwRYuqaqAPz2hQVzJGi7x0yypNupD6W13JmLuKal+b9M78jzoIHmdBY5gSdaj5GAsqN9ECH24qplvlpphkhVPf/w0fG9r85xOMCydD0k5WDDuLadY880J8+s3Y2bsjniSyqzvTwMdv6gXsq5FdeivLo/DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LIf2eec2aDwMSoUv+/VUpgPrHk9LgBiUIINTpOdVNI=;
 b=JUElsySZ6Ephyuxt2yCRqxLgglMv75W3Sel0h4lWESN4zcfvNylvv2JVZcmU+VYwzF69REMD59AlOoeCLZQqYqnjtXjMz/3R8XiDrRsdy/JtN1kpoY0aps9fvHFt8RdXD9gu1kd2aGwIDBmLXCYVapkjekoeS1CHTV1Qu5Z2M8Y=
Received: from SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14)
 by PH7PR12MB5878.namprd12.prod.outlook.com (2603:10b6:510:1d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Sun, 1 Mar
 2026 04:35:59 +0000
Received: from SN7PR12MB7321.namprd12.prod.outlook.com
 ([fe80::9f76:498a:5cd4:d25d]) by SN7PR12MB7321.namprd12.prod.outlook.com
 ([fe80::9f76:498a:5cd4:d25d%3]) with mapi id 15.20.9654.014; Sun, 1 Mar 2026
 04:35:59 +0000
From: "Natarajan, Ashok Kumar" <AshokKumar.Natarajan@amd.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Sebastian, Selwin"
 <Selwin.Sebastian@amd.com>
Subject: RE: [PATCH v5 1/3] net/axgbe: add external PHY read/write functions
Thread-Topic: [PATCH v5 1/3] net/axgbe: add external PHY read/write functions
Thread-Index: AQHcqL/jdl/yntbEXkeic1TtKwdoeLWYUKsAgADHduA=
Date: Sun, 1 Mar 2026 04:35:58 +0000
Message-ID: <SN7PR12MB7321865CAC4A2C1B71749E958171A@SN7PR12MB7321.namprd12.prod.outlook.com>
References: <20260227084323.689-1-ashokkumar.natarajan@amd.com>
 <20260228143750.626-1-ashokkumar.natarajan@amd.com>
 <20260228084128.5df65dba@phoenix.local>
In-Reply-To: <20260228084128.5df65dba@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-01T04:35:22.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7321:EE_|PH7PR12MB5878:EE_
x-ms-office365-filtering-correlation-id: 5c59812a-aada-426a-2902-08de774c0966
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: J51FfQoCZmQ1ar+j4VsNGDITbx/pfD5J+YRXI0lfn1xegWrPnQh6FLAbc9q97mIhppNRjPDeManLDxzXQNAsGBWEu+XH5pkBD1u+J6qA1F1asHuLxPr+OyCU665at1MdiMTEUYvgYgBVjk7h42R9ltQkEqEkUlyvjRADAxGRCZ6/diZsniqOrt3mc+ssJ2s8Gdai+/Yj8HQLpkSCVhT8TyyseUGQHSkene+nu4xgGkDJXnKCkCKOP7zZOgfcF/3yVAjjd4XC5znZcuaOBunsFWGphbOaSBjiOSTwQ8S4CiYJ5wvgVxDWfsQqLLQLP91OtIDK6gQB1u5d4dboFH5wMX5TLuz04r+wFJQgFQ69yYGLn+k8U0FXbu18RY8n9ZHBfSNiNq+7kkJDK5j6n/Mu2rvoKPrraUJQvjyeM4JwX2eXbaCHxLyy8a+Tx3d+HqBD41RRViSjKOVfWfvH6x04mPgZSP7BA8++UnS4zlUOdNOcq7PXlD1PVQL9lDa9sBQSU4bmPS2iSU91ePjPHii0RMnAi7GVhGbZKTAHY853GUL+yGAhE8JOIv7fHz3nE/mPXhTLc3OjWXsiXO8ywiVZlPKS0prK+CZ8oBKDD1v3bZKX432BHxIfKZm41WuPQnjR4SPDkCc2cxuwJ+OuIwt+OhU8KCis/iokeb+FZ/hRB0Wm98hgGjeVu6qAu9ZdU1jgu6XF2ksuGk0Ye4VEO6modD2Pd0yBJOINIk3+JrnDy2eD5izREMZ5LWZ2AzQPgoN9Vz62Bn+EMZaNK+gK/fE+IG2NMWHQUn9G2N9oxG3BNeY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7321.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q25aT2szb2cralhwdE1zM04ySXE3QmRMRkM3V0g5UHBlekIwMXZwbDNHWkdR?=
 =?utf-8?B?RkJJZWgyOTNsMGFzS3NDY0tTeUpOMlVzK2pEeUlQcjlwczJFNGZjM2Z4LzRG?=
 =?utf-8?B?bHMrMElhYyt5WVpYZ1lidnZPQlRkcU16K05qemNvMzFSb0VUVk1tQ1RCOVYz?=
 =?utf-8?B?a3BmbUl0dk5mOG1BcFFrU01MczRHZmlHemd1UDlrQW8rUlp5RyszSWNvU1Nj?=
 =?utf-8?B?YXB3N2dKSmNKeVQ2OGZKQk1WU1hBZU5jMDNqMG5tZ1YwZDU3STdoZ0FkWjNI?=
 =?utf-8?B?VFRuTlpqeVRCYzEwZnRUN2gyZytTc2M4dDVWWkROYkhMeUFzdk13NXNDVXJl?=
 =?utf-8?B?WjhXSE5ZYnNvcmtrLy9MdGhQVnhMa0Z1WElDN0ZONmgzL3kxMXFob20zQWhB?=
 =?utf-8?B?emQ3dXlqUWZaTnRQN1o1YXRKdTNIdVFLeUNpaG45VlBYMjJFaGpadWpnL2Rl?=
 =?utf-8?B?Y3J3TzlNYnBXU0d1Z0pnaW9HK3B5ZU0ycTJwVDh0bHVVN2UyRVZlRExwZm9r?=
 =?utf-8?B?cjVabFp2R3ZLZk9vY3FLK1VVdXEvTjJKM01jdmRheU4xUko4U2t2QmhpcnVh?=
 =?utf-8?B?SDR6ME0zRDZJQ2xMcUVXM1Y0L2xNY2RyZURwUDk1bC9sRzZCMHZxdXRuSEZa?=
 =?utf-8?B?Tk10MkFBcE5EMFV4MWtPNkdvQ3VvVittNk1qM2k4ZitocEU1bGl0MUw5QUhK?=
 =?utf-8?B?WDBBYm1TRkRvaE1rcUNobFNEMnowYThTekRKaGVSdEQ3UzA2bTFpcVBSWUlz?=
 =?utf-8?B?cEFTak9MNlIyVzczenJudGxCUXdCTjlvVmpYQnhkeXhpMWRtZzYwcllib1R2?=
 =?utf-8?B?WnFpUlhVUllZV0RiRjhRZjFudzFtbVlldEJYSGFrcEEyNkRPWFpBNmNUSllZ?=
 =?utf-8?B?TktLeFNLWGdBaFcxUWovRHFsQWEzWGhCZ2JGSkl1MGp3djFuUEhkcHVNTTND?=
 =?utf-8?B?TzBVNUtzWXFmbTBEK1BMZHRMcFVkWjJiUy85L013ei9MZjhpL29UanVVTDR4?=
 =?utf-8?B?WHBIbHU0aHowN2I3c0tseDJPenZhZUJ4ZkN5UytzQ0d5NlkzNi90MU5VK0dx?=
 =?utf-8?B?bFRMS3h6NGY4R2VTeVVWcWdFVXJGTVVHYmNoY3dFTWJ1amYrME5VcU0zaDFS?=
 =?utf-8?B?UjZzdFRVbjRBM3pIbS9pak9wc2FaeW5KTGFLdys3WUQ5Y095enJPM1l0U3ZX?=
 =?utf-8?B?SWZjYUx5aVpUNVpIMHFWT1pSQXllZkxLZXhKU0tCRkhPVzVKbW5XRWptZml2?=
 =?utf-8?B?QlBQcW5EQ3N3RTV5aU5jVDdkRkxLOVNQRzJoS1hjNjc1V21hMFVXdlV2YWhM?=
 =?utf-8?B?UXh2TmZOM1hWU0U5WmhzTWFsalprZXdJMHZJZUxtRGgyS05OeEIvdGpSbU0x?=
 =?utf-8?B?VDFZbFJwMFlNc3Rubm9tN1diTlNLODViR3VyaGxXckNEbHB0OFBMQUdKYTEx?=
 =?utf-8?B?NGFncHVSODgzQWtoS04zYWdkRzRpU3N4cXNTQkdQS1VwUFR5U0lRNnhZMURl?=
 =?utf-8?B?NXErbmlsTDRVK3J1dWZMQkJzTlZ4MnJwZ003dnhHRm85VlN2OTVIQ3BXOWg2?=
 =?utf-8?B?YWxVYVk2MVdLNGw1L1hpekE2Wi9CMHJiUHh1R3ZaKzVzeUNNcjFhZzJKVzEr?=
 =?utf-8?B?YW9CeHNPQ1E4UTRHSnlqQ2NSVnRmSmpPdUlSNS9QcWYvKzF0L1EwbFpIQldG?=
 =?utf-8?B?YmlremxGZ3krTTcwN0JIZWtiR2pHdFJlT1krY2liM1pmeXBORzJyNCs0RW9u?=
 =?utf-8?B?VzNBNXk4MStQTGZBVm4xZjFObHNyMWZsUHZnV0hyS2U0TGR2ZnMyeXArWHpD?=
 =?utf-8?B?b3hJcE13UlZUOVVIeFM2QlgySGtYTXlOWklqRWdsZDlpWlFqY2dKNjJZbG1i?=
 =?utf-8?B?TVhXY1dCM0o1dXRXQk45UnVTR1l3WVRPS3RZZkZsS0gzWlpVWFIrUjZOZzlN?=
 =?utf-8?B?b1ZzSHhBSXVtMDFpN1lqSE5ZbW9yNlIxNjhKMDh4QUx6UE9LZkNDeERRQmdC?=
 =?utf-8?B?cWV3OXZ3VkJtNmFnaWhBb1RaeU4xdEpHT0l5ZTYzYkt2cHFYQm9yOUhYRFdU?=
 =?utf-8?B?ajZZcDFKcWlPaDhTVkozbkE0bnJLS2VWcSszQWovT3F2bjUxazBCcnpCRTQz?=
 =?utf-8?B?N3RsNkQ3a2Y4MGtUbXVERVhmeUpZN0piNmhXZWU5SFVhMDJ4R0NnSU5DWVB1?=
 =?utf-8?B?YWdCZzJJVlBsbzlPSmpoVHQxWE9vdlEzWDQ0RlNnRUs2bWdFekVIRUt4azRu?=
 =?utf-8?B?YWxxNnZPZXJqVVZETExkTXR6bXdjWjNKZkFjR2kzRFNSM2x0dWV0UllGdml0?=
 =?utf-8?Q?aHmYKllsLEC7/IAKH7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7321.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c59812a-aada-426a-2902-08de774c0966
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2026 04:35:59.1571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SP/yXV3avoiYWytT4dwpOTCxibBk5n3KPstGsrLVq3GrVDIadnkJ5FNqgUO8YAZku1X0jDJZtwApCoJCiXhaAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5878
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
Cg0KVGhhbmtzIGZvciBhcHBseWluZyB0aGUgcGF0Y2hlcy4NCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVy
Lm9yZz4NClNlbnQ6IFNhdHVyZGF5LCBGZWJydWFyeSAyOCwgMjAyNiAxMDoxMSBQTQ0KVG86IE5h
dGFyYWphbiwgQXNob2sgS3VtYXIgPEFzaG9rS3VtYXIuTmF0YXJhamFuQGFtZC5jb20+DQpDYzog
ZGV2QGRwZGsub3JnOyBTZWJhc3RpYW4sIFNlbHdpbiA8U2Vsd2luLlNlYmFzdGlhbkBhbWQuY29t
Pg0KU3ViamVjdDogUmU6IFtQQVRDSCB2NSAxLzNdIG5ldC9heGdiZTogYWRkIGV4dGVybmFsIFBI
WSByZWFkL3dyaXRlIGZ1bmN0aW9ucw0KDQpDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRl
ZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uIHdoZW4gb3Blbmlu
ZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQoNCg0KT24gU2F0
LCAyOCBGZWIgMjAyNiAyMDowNzo0OCArMDUzMA0KQXNob2sgS3VtYXIgTmF0YXJhamFuIDxhc2hv
a2t1bWFyLm5hdGFyYWphbkBhbWQuY29tPiB3cm90ZToNCg0KPiBJbnRyb2R1Y2UgaGVscGVyIGZ1
bmN0aW9ucyB0byBwZXJmb3JtIGV4dGVybmFsIFBIWSByZWdpc3RlciByZWFkIGFuZA0KPiB3cml0
ZSBvcGVyYXRpb25zLiBUaGVzZSBoZWxwZXJzIGN1cnJlbnRseSBzdXBwb3J0IG9ubHkgSUVFRSBD
bGF1c2UgMjINCj4gUEhZIGFjY2VzcywgcHJvdmlkaW5nIGEgc2ltcGxlIGFuZCBjb25zaXN0ZW50
IEFQSSBmb3IgYWNjZXNzaW5nDQo+IHN0YW5kYXJkIDE24oCRYml0IE1JSSByZWdpc3RlcnMgb24g
ZXh0ZXJuYWwgUEhZIGRldmljZXMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFzaG9rIEt1bWFyIE5h
dGFyYWphbiA8YXNob2trdW1hci5uYXRhcmFqYW5AYW1kLmNvbT4NCj4gLS0tDQo+ICAubWFpbG1h
cCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEgKw0KPiAgZHJpdmVycy9uZXQvYXhnYmUv
YXhnYmVfZGV2LmMgICAgICB8IDU2ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPiAg
ZHJpdmVycy9uZXQvYXhnYmUvYXhnYmVfZXRoZGV2LmggICB8IDE2ICsrKysrKy0tLQ0KPiAgZHJp
dmVycy9uZXQvYXhnYmUvYXhnYmVfcGh5X2ltcGwuYyB8IDQ1ICsrKysrKysrKysrKysrKysrKysr
KysrLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCA4NSBpbnNlcnRpb25zKCspLCAzMyBkZWxldGlvbnMo
LSkNCg0KQXBwbGllZCBhbGwgdGhyZWUgcGF0Y2hlcyB0byBuZXh0LW5ldA0K
