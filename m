Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20377EDEBFA
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 22:30:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 241B2402AA;
	Tue,  3 Mar 2026 23:30:43 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11020143.outbound.protection.outlook.com [52.101.56.143])
 by mails.dpdk.org (Postfix) with ESMTP id 24C8F4027C;
 Tue,  3 Mar 2026 23:30:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMn7jsg9p0E1JuAstVVeCe5AeCxiJrvYfgh/M/iUxYAX3QP19oDIiEvhRC72UGhBV9rrr/MBWYfLB2pO5DKujs2Kqcn1B7kFYFVCgq1uWilEr4ClwzFi1oKOl+I9F3vWT8HyeLVtWnzMfzrgq1JFbrohtibdyUSfaEZX3YaEztzrSoSzjxvrFGEs1Tgud65DPJEgI7xeV09Fkgg/IyaXcB+Pk5rUwdC4c+6iAf8c5wE09P714g81fZ9ewajnbyb5CraT1DGMt3Iy+5sUcfN1Q8F/VbF5SgrMdwdDvUCdwsLGPrgn31priJZmVfaJAF3W/maec0EJewkqSZ4qeGKA+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+m/S1E1aUJvh4kNs2+MlrQF7RHRVCDwDKlgJicZ4SNk=;
 b=kWUMpXe10IGhDVrvLyccmAo/tr+c7iagVP8prBR9gL3jM8NlfMoLt3606INuAQuhEe7d5VQGIeP/+L6K/lqZLwP/8N2n1qTVBlz1x9mPQl7DDDyKgHpvjQdc28WEJMUKd6KMOzjAQGom/fmfH6h+EiGZaD1P7BQ8neFTsGaj6l2/sWLBhw1FR824wgFPP1BmUI5WaB8zfYtP7H+VKgqy4kbcAFgnPG6FlTLbhz1aXDviykZlcAcftZthX770NnXzchd0MMxkq2uBXKRzKRXORzPdpoE9biMrv3O3daFetk0A3ymgQjQGvNruM9sE0lkKleQmyXaX5ZMLhfTxqN9pMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+m/S1E1aUJvh4kNs2+MlrQF7RHRVCDwDKlgJicZ4SNk=;
 b=IL7pkwPy+gB4vqlTXFTWHIcJhdLHZnz4wb3wHcsk8wIninFFONOnjZP6n/8uNLtU/4KJUbefjvsTdUD3T4NxxHDQzYmOt7Oc0E9VaoxLVv1x2pJ6XyA6ows3MtNB1VSOv2Muae/zDuNJl8rVZ0o9q8YpA4vFRI8koDxOOm+vhYo=
Received: from LV2PR21MB3374.namprd21.prod.outlook.com (2603:10b6:408:14c::21)
 by LV2PR21MB3108.namprd21.prod.outlook.com (2603:10b6:408:17b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.16; Tue, 3 Mar
 2026 22:30:35 +0000
Received: from LV2PR21MB3374.namprd21.prod.outlook.com
 ([fe80::f2b8:576a:8c2f:ae46]) by LV2PR21MB3374.namprd21.prod.outlook.com
 ([fe80::f2b8:576a:8c2f:ae46%5]) with mapi id 15.20.9678.016; Tue, 3 Mar 2026
 22:30:39 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Wei Hu <weh@microsoft.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] Re: [PATCH v4 0/6] net/netvsc: bug fixes and runtime
 queue reconfiguration
Thread-Topic: [EXTERNAL] Re: [PATCH v4 0/6] net/netvsc: bug fixes and runtime
 queue reconfiguration
Thread-Index: AQHcq0/oZHdJZls5u0Onfj+gDtp0PbWdYAeAgAADxHA=
Date: Tue, 3 Mar 2026 22:30:39 +0000
Message-ID: <LV2PR21MB3374653E83300942F58ADF8ACE7FA@LV2PR21MB3374.namprd21.prod.outlook.com>
References: <20260303205411.325585-1-longli@microsoft.com>
 <20260303141605.02edf0e7@phoenix.local>
In-Reply-To: <20260303141605.02edf0e7@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=940e4d6b-2037-4253-bb3d-e4371043b0e0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-03T22:29:33Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR21MB3374:EE_|LV2PR21MB3108:EE_
x-ms-office365-filtering-correlation-id: 50e30b4a-7c2a-467b-1a85-08de79747f3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: yGVUPDqIGnIZtlbkDpUzvA8+YoQHqOwCZVOqJQAIa7vHsgt/LAs7jHUodWhlS4blyZZ8MtTEuKnjOCZsBMEjB/51oKPHysr1uC8TFflILFY6QzCKelQHOje5jVI2ZQjeApnqvAfu1o/kCjn0RsiWBmkr9nsxyTRZaxQzw+JGHKrR2nT8XdZd+AKekC2rTmPPca++XUQXHbtA7bZkErN0iLyGa3XKBoEKWg19PnZbylfWRf91ttObvhXtKKXY3uf9IsVFFcS92XJ1PyqqiSFYQ69USyEj9+fqi6WXZfD2mmMfTmbZW3XhqepyErUsQ18XENLIXoFIv3jHp4BDxUB0Da+ZUyxBifptXtLr34fPHWdodxAAziBwmJ686yNYl5i3KTDC2+smWaAl1WAxpyU8puPhmaq1HLGOCwj+Mu28+AUVysFPe2C5TTKX77pgfkiqrKg2t/4JF69CkZ8Ox/5kVfyBI74uaVC7+ZCeFg3n2w73kqJpNwygUtDsdKWN3xRKkU848zaqXcFRAdQTgqxkTycwIAxPV6GMBU8L34EF6BJqQaBsmN30MCqYmEgtK7JrCji8VtYckDb92cPlH8lwmOGS5EVagRa3QP+pmnG/RuokFFiyliTTi0YRYpjTqIXWSMpQfK0c8v0WbNFTrvpkbBAOU1Dy+TIaIkNmW5PYK0yo4BYAbt+7IUBEWSo+z0CvuHR5Jb7ZFBpDT0gQXJfkwUgJnF0027GB3SrwGoy2vVKroEYF3JO681gl4I3UNBS+hs/hvhUnqGAtSphwRVbXWw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR21MB3374.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STMyMFB6SzZaWDZ2dFFOY3lqWTlJNG50STlna29ISmFTdTczcTFIZnR2OHFT?=
 =?utf-8?B?elVLa0oySWdyczF6QStlWkZiVVdPUjM0MlFoOGVKSEJlanBTOFUrTDFXbGt3?=
 =?utf-8?B?OGZZTExBRFlESy9WNVYzdWtiNTZPRThBMWZ1V0ZNOGIxSUx6WGcyWkVBejhL?=
 =?utf-8?B?ZXhiOEZ0WHJZa0VjYkRqak5GVW9UYVVzZG5TVmhyRHlsbFl1QUpnMHBKMFlx?=
 =?utf-8?B?YjFhMHAzV045Kzh6K2F1WmxvUlpYRzNDdkdEV1RPTnBLZ3Q2WWVwRTRtaE5I?=
 =?utf-8?B?U2R4Qy9SUC81SFFhdTJVM2d3QVVkRDBYQnNsazUwOVZPaWkxcnZBS0U1eEVT?=
 =?utf-8?B?RVRHTzBJcW5ZdEpTbVhEd1cxNnNKRlgrUkh4enEvbUZLdzRMRFkxMGlQSVdj?=
 =?utf-8?B?Qi9lcEZsNVRuSTRZaTBDYTQydjl3ZjIwWk5KT1BDZjVmd1YzR2I0M3Bvaldn?=
 =?utf-8?B?MnFpWlU2MWg1TUVBaElQbFJMYUN6SFRLcXI3YUZtMFpReURMZm1JZ3BvS2py?=
 =?utf-8?B?RjkvTDNwSGJnK2dZMEorMUdRZzlkMXJYNU9XZzZYbVZTUUdtSUZzSE12U2xu?=
 =?utf-8?B?YTRodzZPVGcrRzJMNWR5S0NTMXl3cVBLcTBhMTNiM1d1VUdYUHdCUmNzQlJh?=
 =?utf-8?B?ZXFQUTBmeFl3ZEg1Tk5zZEZSc0piWWRXTVRBMnZJR1YrbktveWRRKzRyQVJM?=
 =?utf-8?B?ODdnL3VvcjE1dHhsYzNINmJjcjVxMFdmNHh6djNNc3JrZFNoaHNpSnR5VkdD?=
 =?utf-8?B?NmJXcTdMZnVYZy82dGM1cDBpS3RRWk1KTEFhOWRhcDIvY0V4M3VlRldVVWVN?=
 =?utf-8?B?VFAyaWVicy9aSXlXd1FzMG9KQnMxL011emdQVUhaM3lsM1FyUDRBTURVWTha?=
 =?utf-8?B?T01TdlZCTjBudVJ0c0hyeFNjMFh3T3FyY05EYzNQSk9DL2p3RGhlNjRBQjM3?=
 =?utf-8?B?RnZtRm56K2tQekVzbFVoMElMYVJVR09QTjNXVXpwM1pTYXVpL3p1UTNjVlhN?=
 =?utf-8?B?bi9Zb0ZGUkNYYjFoM1gxUW54N2x3U0NKeEUwd2x0SzRocjllUGdkRWxsbVNV?=
 =?utf-8?B?RnFFMTdBWUYwZHZvMCtudVdObXFGdTlaR1NpNCt4UnoxOThlYS9tYzcrNENR?=
 =?utf-8?B?UjIwQ1k4blZ2SVQvZnJXb3ZOT2lwdnRyNTRYalpTMmxOVzhaYWprZE12S3Vz?=
 =?utf-8?B?c3NwL1RYclhJOEdSQncwNUc4NU0yL25LTGV6TGVQRGFFd3lPLzRZN21NZzM1?=
 =?utf-8?B?dkF5eng1d2I5anBWR0dJL3h2UUVBNk5aNXRrWHVydURwWU9idHJpRU44eDNz?=
 =?utf-8?B?WW5LVmhjaHNLTXptc3lMcnM5WnJnMXRIdXU3QmRqa0VIV0NXZFdMNlB4bGJO?=
 =?utf-8?B?VFFqRmRHbUx5UUtjc0NqN0xITGhHSWpKa1FEby9MM1E5Qkw5dlltc2drSllo?=
 =?utf-8?B?YXkyVWVrRFY5RERLYkR1YlZ0UkxDZDFmcWtQcEtPVU5sc3MxT3dodkZKSWZj?=
 =?utf-8?B?eXNNcG9IajRJMnk5NHovYitMUHBvc1B5ZjV2bVJpNHVHVnZRNHc3bEd2dHEr?=
 =?utf-8?B?a3V0UzdlYnNzNy9SVlpEMXlNWk9ET2xkc0RSeWtDQ0FjUzJhY3RBUDNvVDdo?=
 =?utf-8?B?dmpWdlpxdTVwVkRPYzYxS01CZWV4a014OUlZNXh4QjY2RUphZUprZ1gxNTUy?=
 =?utf-8?B?UHFoWU1EV3A4UWhCZ2dzcHAwLzVQT3JYQ09lUnZ2TnNWTTVFWE42OVR3QXg5?=
 =?utf-8?B?SHM1YmkzbXhLR2ttNTcxcTVhT1ZvN01LWFlMOVQ2WWYrMUtMK1AreHNyOUF3?=
 =?utf-8?B?ajE4RFE1NlNSYS9XS2xDeHBXNkVIdlo5YitOOFhwUkZFYlByOHgrd29ybGdE?=
 =?utf-8?B?SDMrQkducWg0UENVZmJ3VEY0RG9KOFJVNkV4YmxGaWg2bjVTb3lGYUpIVmE0?=
 =?utf-8?B?RzFDLzdKYmNrTG93bWJLYVZ2MXNSNllwUWt0bnU1bUg0dnBYRmZhc1lZN2hp?=
 =?utf-8?B?ZHUzRURpR1UzaTNRWVdTMEhyUUhNenZaRG9OOXpPUGpIMm8rSFB1L213RHdx?=
 =?utf-8?B?bHVpMUNPeHkvTGl4ODdLN2pnaGJjRnJBaVF1UHdKOG5NM05wWWxOZHBZbjU0?=
 =?utf-8?B?RXA0UHNxV2djckluZ1p5TU4vM0xuRXpHaVJUUjNiN3hwZFlXV1BqRkg1MkRk?=
 =?utf-8?B?RThxcURxN3pKODNQaFRuRWkyV0EyTmxTVExFVVpyTkJ1a3dlZHdtTnYvOTJF?=
 =?utf-8?B?akRvMDdnZHpBMHFRSU4rR2l2U2dsM2N5T2ZHeFNRQW9pck51NkpZdHF6Zi9P?=
 =?utf-8?Q?cM5up3bfx4Iq3R4+A1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR21MB3374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e30b4a-7c2a-467b-1a85-08de79747f3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 22:30:39.0585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xidi7OAitK4GhLA4m3QENZD+HhtPaDV/6WMKkx3ko5/NiKaML1dCVwc1SShz1wm7OzHckLldLyAJ/QE8fQAmXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3108
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

PiANCj4gTG9va3MgZ29vZCwgYXBwbGllZCB0byBuZXh0LW5ldC4NCj4gDQo+IFBTOiBoYWQgdG8g
YXJndWUgd2l0aCBDbGF1ZGUgdG8gZ2V0IGl0IHRvIHVuZGVyc3RhbmQgcmVsYXRpb25zaGlwIGJl
dHdlZW4NCj4gcXVldWVzIGFuZCB2bWJ1cyBjaGFubmVscw0KDQpUaGFuayB5b3UhDQoNCkxvbmcN
Cg==
