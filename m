Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06836C54E90
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 May 2025 08:47:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD554402AF;
	Sun, 25 May 2025 10:47:37 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by mails.dpdk.org (Postfix) with ESMTP id 9C9CD402A8
 for <dev@dpdk.org>; Sun, 25 May 2025 10:47:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAspZ3oWUNMDfHH+Cu4N7LgT6xT4llGTV7hffBG7nQKTLQU7Ida/JFm2LwcyZLAps8u3GfHTctt8SR85kXxr5Yz640Qj9+PBnFdWyj5acOVtH64dZNAdseKLt0iNZxShJpj8hBwjZKmVKcqeJzihTV9AVz6AwVpZhgDAgyYVfrCC2oI771Lk54yxZblQIW2PVScpCpSxQUOvlCpDakPKDZZKA47FXWYcdEdkhlxiJOUBLM1Q5bzoSwwbFWDptB8LXycBxiSEeVMuBSveoB1sp6FyW0KLPNkLVaNU53kegJTV25Fy4zlDRL5f+q3FrK5YXPEneByBcxsj/2XLqrVHFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1IJ7sDilNJ7VPVwZQBRD2lsTpa34v3jfiN4xHwBkqg=;
 b=i/kLIZjFgThoU4MaVfSvs9FQhnuLDfX4ufiZNdDxQo6yLuUCrlqY3fyS52mnQccE1WqyzDuEjH6PaXFL9rFwVqPxYSCa8Dr50yCKNNfAY5QEafUOCbbDEyHy6fglBbNxcLZXmGKrlZhs23Xq3JZ68gPv3uNAFChX00fz73RuiTPZxlCO2jIkT0w2O7T41NZQurCRJLsvO4/vU+aTp6S6FK3W/kdd68xzxeiFjl6XXm6fFSheeAKM09SLFJ9ta3gJimrKK79e7u5c3YxZUJqMhVXvE+GLlrUAGIttGJxWMvGK7XfY3HwS7mj3uZHr5sJ2oF77UUMJNPC3s+YH2gFoeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1IJ7sDilNJ7VPVwZQBRD2lsTpa34v3jfiN4xHwBkqg=;
 b=NuYzxMGeaYO6atkR1nWe+9ufXSCc8OKCldm4VHkYEvZ+Fq4wvflGrCh060Gmg4KeiRGrdPBYyiH/uj1kaIggCURKk5fnhEI7+1bOZ0nKXKcAvxwCdD6znfxnq1noAMGELa8BiR7zRfYIoaSWmytXxsWuomjty66opOzQfmE+8TUdpPXu4FFWfmw49BLHiH2nOF5hwFx2PrV+KEj2MMKyOjGswepvwEhXlGB3Aa4aSGHa7mebazM6HJms8FKzucgoS5w5IkjiwhEjBzLPYoJpKrwadzueF3D9FmZWvumo45t/21NfjYOOrK8oC3rCri5vImodCDwZTcWmel/3JiKcpA==
Received: from PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14)
 by PH7PR12MB8039.namprd12.prod.outlook.com (2603:10b6:510:26a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sun, 25 May
 2025 08:47:31 +0000
Received: from PH7PR12MB7018.namprd12.prod.outlook.com
 ([fe80::5cff:1844:4c17:a0e3]) by PH7PR12MB7018.namprd12.prod.outlook.com
 ([fe80::5cff:1844:4c17:a0e3%4]) with mapi id 15.20.8769.019; Sun, 25 May 2025
 08:47:31 +0000
From: Maayan Kashani <mkashani@nvidia.com>
To: Andre Muezerie <andremue@linux.microsoft.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] net/mlx5: declare size of rte_v128u32_t
Thread-Topic: [PATCH] net/mlx5: declare size of rte_v128u32_t
Thread-Index: AQHbvc/b1g2/zbt88Ui451ZHFwxA8LPjJw4A
Date: Sun, 25 May 2025 08:47:31 +0000
Message-ID: <PH7PR12MB7018AF2B11C04F5B177B3568B29AA@PH7PR12MB7018.namprd12.prod.outlook.com>
References: <1746457823-11135-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1746457823-11135-1-git-send-email-andremue@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7018:EE_|PH7PR12MB8039:EE_
x-ms-office365-filtering-correlation-id: 0270d24a-8b44-497f-553b-08dd9b68c959
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T1dob0xKV3JHVFpGVFNnWUVwdXFLT3RzaVA5Y3FqekNxVmgxOTJqQUlyQmdP?=
 =?utf-8?B?alVkNFZsVVZOaVVzazBld0U0ODYraUlHLyt6SGJ0L21xLzh3ODZoMitOK2wr?=
 =?utf-8?B?cHdXcUg3a1I4YWN0OTVYV21zSUkvOWxrNVFPeEVqY2I3YnpCZU9LUFZzVHo4?=
 =?utf-8?B?aVhQd0VlRmhpbk55dE80K1d2N2FFMUhkTjM1MmFkY1o5NXRDaVNmWDNnV1Fq?=
 =?utf-8?B?TklmZDRIQklkUmZVMGs0bE5QV0h3ZGFnUm1jdG4yNU1rczQ1SkZoL0xFd2Z6?=
 =?utf-8?B?VUJ0Y1BxTXRnL1JFMm9lbUtuT0VsUW9XaTc3b3NmbUVOOTNNZUN3V0tEcklJ?=
 =?utf-8?B?RE5hUVRMZTF5Y1kxSXphSHkvOUJMOTB0d1BHRkVtd1djSDF4ZkdiWTA0Wmc0?=
 =?utf-8?B?YkZLRjl3ZDVyTDBYRUhnODdqTTU5NUgvQmhoNDBxKzYydzc2VUNNSXFVdGh6?=
 =?utf-8?B?WHFGNUJmMnRZc2lQN3JzYllyTlpPOGlyZGtKV0k5R1JhdVpLek4vZklYaFVU?=
 =?utf-8?B?NXdNQXBvL1FxcWpSdVZKN3lRMHpTcUF5Uno3VmFQNlpSek5XVElFZkNXbW9L?=
 =?utf-8?B?MDFqbVFtbUpXZ0JPWHhGcnFQenJ6RU0xUENwUzN6TkhZSU55WGZGdXpreUtV?=
 =?utf-8?B?MDkxOHgrZFRPeHE2QXdjWG9GOEFKaEZiTUwwMkdtbUZXZy9VR2lhNjl3UGhq?=
 =?utf-8?B?SmpDY3BERXlnbnZCcEhDMXBRbXc5eUc2N0hDaWE5eXNud0dHcUJETCt4bWNw?=
 =?utf-8?B?VFZoWlZ5dU15dnpCSEpjK3kwU01LbFRDQkpuem1mczhZRXhwRnRPck8vdHpQ?=
 =?utf-8?B?RnJEUXN4a3Q1UGM4eGNwMFdvRTNWQjM0b3M4eGMvVWdQN3lVeUhWNXNMcWdR?=
 =?utf-8?B?Mk5xaFZJOHl6dUpNcjlyK3RMUjMvNW9JUHYvK1NIRmc0OW1EUmltSmFWalN3?=
 =?utf-8?B?MFVtK0Y1MTlaN09FZ1U5YVJsRTZtUWl2anNJNnNtVHEyU1BWckhqbGVmaWhy?=
 =?utf-8?B?d3hLQytLK2s2Wkw1c1RhTExwcjVQa1Y0dDhMQ0V6SUpxQjREdU1FamdkT1Y4?=
 =?utf-8?B?SWsydzRNMjVtRkxyODBqVjlqRVpiaGRVNlhkNEVHNk1vVDhIN1QxMkFBeW9k?=
 =?utf-8?B?bnZMaG5qV01vWnVpQjRWUStHN2J6bWh5R3NnL1lNbGFyVVErTjFYWnl0aGRZ?=
 =?utf-8?B?UXFPQXZYL0swbWtPcGZMTUp3SzA0M2gxMUZpUUNPMUtZcHJWVnlPSm12RFEx?=
 =?utf-8?B?aTBSK01ZRjdzRDllQWtZR2traDJuRmZKT3d5UStERENJRGxlOFovVmduNllF?=
 =?utf-8?B?aWJ3R2Q4UnBZUUdRN3lFSnlWRklyVDhPZTJxbVo2c3UvZjRGVGRHVEVkTFpJ?=
 =?utf-8?B?ZzJRSHltRitpWUJQRWMvcFgyVStMZW5sSERFODljeHFONUZjY25BZm81SmNU?=
 =?utf-8?B?Tmg5S0xxWmRjU2hpaXE5RE5ZMjNBbVJHdmJUcXg4bm4zb0ZXWkNUamRHY21q?=
 =?utf-8?B?T3o3bUI1MzQ0WDdxYWFFN1RFMUFybVV2VGUyL3I5T2puR3I0RzRPejRXOC95?=
 =?utf-8?B?Zmh2ckduSTZWQkYvNU9TMmFzUWR2N2liVUlVMW81bHpWRENCeG8vd2dwaVZH?=
 =?utf-8?B?YzBQZTlTU2RQTUtzdGp0SW9GNVpLUmFvUmF1akxxZ2hKTjBsY3l4cEdHMDdu?=
 =?utf-8?B?dk82bHJaSG9uVS9CU0I2ODNINHJsbE9CWXd1ditWcllsKzAveTIxaW41SENS?=
 =?utf-8?B?VFJZMGFQdENpeHl1c0hzYzYxV3hYZHFjUlVEa1JUTXJ0QTdoMU9GdDlsTyti?=
 =?utf-8?B?NmE3ckNGRUNZVnNoVWlsUHZjcXpEMkN0YWNKeFJKSis3VnE0clhtTzdKWGpy?=
 =?utf-8?B?NWlTdHhkUzJDbUdLOFBaWDlrbnlyaUdiNUZTTTlIYnBEZkYzbVZIME1sOWxI?=
 =?utf-8?B?TjZwTlVueFptVmNFcnJ5TG9PbWJuWTU4TmVOMDVtSGh0V1BwaFZlUU5nNmdP?=
 =?utf-8?Q?iK+DDbWav0/OmshrcwnvkE2xsah0SY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7018.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXdiand1YTVFb2d1QjFZYjVkMHhWUkRKakp1UjYxUFVIbldwem9sMUpwcU81?=
 =?utf-8?B?Szg0OUpJd1V0QmM0eC96NVhSbjRMNDNjN0UybmxNWi91YS96cldwOWNrYU5V?=
 =?utf-8?B?aEJBRDcrOVh2ODBwaW9SQnJUdWc5KzBmRENyc3VLeW1lcnVCa2V4RmRrUW4w?=
 =?utf-8?B?ZEJzUk1nNnVlRTJvNC9mdjgram5Nem5KcklQdzNub0NocjZ5dTVvMEtDT1dy?=
 =?utf-8?B?Yjk4RURtWXM0V2tGSXR1VjNVY0wrNzhFbWduQ1RQSnh5QlhnbWR2aVJ3WXo2?=
 =?utf-8?B?WVdBOGFhQllWK2VtYzEycGQvc3pnVWxRSDMwYm1sNVZsc3pTRTB3Mk51Mlcv?=
 =?utf-8?B?Vmtuam9xZW81cm8xRmI5d1JwUDlCdmFld1Z4VXl6aFBYV1dMczllaHdNZEI2?=
 =?utf-8?B?c3NLRmlqMWZ3QUZ2ZEpaMVdWRUFtUlFMWHEzZVpoM1dJTyswNHh3cmo3T0t1?=
 =?utf-8?B?d0pNejEyYnJEMHVHSkdQSkt0Q2dmOFprbGJLVVoxWGE1eEJSUWVkaFRNSFF1?=
 =?utf-8?B?ZzVTZ0Y1NUhmejJybGtnK2paK3dxK1cyL05NRWVpRkYvc0o5WmcyRlRWVzBU?=
 =?utf-8?B?QnpFMmQ5MGlrVVc5QmJxQzN2cmRWMEdKTi8vWk1zMHdQRkN0M2VDTCtxMkFw?=
 =?utf-8?B?VENvYzNqN01vN0t6aDlTaXdTQm9wRXJQbVJnTE5SaFZFUHA2OWVDOFJob2x6?=
 =?utf-8?B?YjB6aXdlN0tEc1VBTUNycW53czRiQUxHeUZxcVFNdHN5Uk1sNFV6ekdpVEsr?=
 =?utf-8?B?cXRZVjhIbVRYRk84cEJLZXo5ay9TMWNrOGZEQkc4ejB5NlVVUWtBQmxtU2ZC?=
 =?utf-8?B?cHZIa3dnU1JIZmR3RXlCOG9rUURMZFVaZHd4TjEzT0ZHbkF2TW0vQTUwamFW?=
 =?utf-8?B?QXZnSXNvdWUyUExxaTR6R2l3dkpwek10ZlFNZUVIcGZWS0hLU0R6NU9qZUQy?=
 =?utf-8?B?akdTNndzTGdsZlhydkhlNjVETFFZTFNKN1dyVS9GRVNoeWVFcFJwUWYyQkpz?=
 =?utf-8?B?cDhKTUcyUXJMM0hRd202WTA5Z1hlN1BBSlF5K3h3Mm51Tk04MnFhY2RoQ205?=
 =?utf-8?B?eFpqQ3kvYTVFc0w4RXB4SVhPSkV5ZVUvc3lPV1ptNWlCSzBHb2doaGZUZ2NM?=
 =?utf-8?B?Q1k5NE8rQzNmdWo4Wmd0SVlwT3dtd3RtQzVaZkw3RE5VSE1xSlN2dTNkaUZq?=
 =?utf-8?B?NERUTTNkRUZpcWJ0VlB5SUhwNllXdmlLV2VHZXpqQzlNMS84OHRUM2phWWdI?=
 =?utf-8?B?VXN0NXBEZVE5eVh0bitzVWxWOTFlNEU2T1FWRG5rK0tZTzFzLzZyUTJOWHJk?=
 =?utf-8?B?L1k3d2c4WktSL2dJWWt4UzI1TGFRV2ttalNlNC8wUSszcGpWekIwZkFYRjF2?=
 =?utf-8?B?K1loeUc5NjhzNE44cy85cHNiWkpiQThvUklrUnE4OEY0Z0JSV1RwWmcwNUQz?=
 =?utf-8?B?T2poK2xFRjhYaEROL3ZZaFZmd3N6OVFVaGh4M0Vld3Z2SzYweXdVMnZneDdE?=
 =?utf-8?B?TkRydmI4dnlTeUE2ZTd5amJXSm5tUkVvNnRmdGtHTDNLYTMzSmVzTmtLSkVi?=
 =?utf-8?B?NGwzL2NWRFFITytHdklBTWVBNHZSWFJNWlB4c3lNMmFaaHhVTG1CR28wVTJR?=
 =?utf-8?B?MWF1WWpZRnQwcTJYb3RFampMTnhzZ3JCcGR5amlIZzlsTkhOTnMza0J3UWZW?=
 =?utf-8?B?Qjd3anhCYklLODJyUHpyQmpVMTYzcjViZEsvZkpoOEhBcGhnSlFBbU9xOXZV?=
 =?utf-8?B?U01NVlVndEVqSTZlYjBtSkRiVXBmb2tpOUN6L3U2TWJMSkw0UnNEMjhaQUNO?=
 =?utf-8?B?M09UZ3Vhc3ExdnZ6bHArTzI0UGoyaGc1YUpoY1pxc04wUXRnL3dRK01FZCtn?=
 =?utf-8?B?VHBJRWlzODdOendsMmN1QU5Ocms0ZlRFcnI5YmRMUU03eGJZMFhYR3FEak5W?=
 =?utf-8?B?SGlMZUlwL1M3QkFKMCtPQ0VSS25ZblFyZW1GTFQ2ZTlPMmxHM3B1RnhvSG91?=
 =?utf-8?B?Y0pCNWdJbnhWMnl2SDhaZGxRNkN5NXZON3NmLzFqUXJrT2k1S1dsbzEyVEl2?=
 =?utf-8?B?bGhGRk1uNGEvUHFJZXZMR250L1JLdGtCd1F1ZG1oZnVuK0M2dGZUR29tcjVS?=
 =?utf-8?Q?42z8I3Bs1RYxAx5E+Ekx7trM9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0270d24a-8b44-497f-553b-08dd9b68c959
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2025 08:47:31.2911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRXHtV70YdOIh81i6xtDUhwxywRAC2hNqwUHW6Uin+4FmR1rV4A3oN+hvLVX5Gwc0kSLhDgOzlhwh0xoSWYFdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8039
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

SGksIEFuZHJlLA0KVGhhbmtzIGZvciB5b3VyIGNvbnRyaWJ1dGlvbiBhbmQgcGF0Y2hlcywNClRo
aXMgZml4IHNob3VsZCBiZSBoYW5kbGVkIGRpZmYgYW5kIG5vdCBieSBjb25zdCwgDQphcyB0aGUg
dHlwZWRlZiBtaWdodCBjaGFuZ2UgaW4gZnV0dXJlIGFuZCB0aGUgY29uc3QgdmFsdWUgd2lsbCBz
dGF5IGFuZCBjYXVzZSBhIGJ1Zy4NCg0KUmVnYXJkcywNCk1hYXlhbiBLYXNoYW5pDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmUgTXVlemVyaWUgPGFuZHJlbXVl
QGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgNSBNYXkgMjAyNSAxODoxMA0K
PiBUbzogRGFyaXVzeiBTb3Nub3dza2kgPGRzb3Nub3dza2lAbnZpZGlhLmNvbT47IFNsYXZhIE92
c2lpZW5rbw0KPiA8dmlhY2hlc2xhdm9AbnZpZGlhLmNvbT47IEJpbmcgWmhhbyA8YmluZ3pAbnZp
ZGlhLmNvbT47IE9yaSBLYW0NCj4gPG9yaWthQG52aWRpYS5jb20+OyBTdWFubWluZyBNb3UgPHN1
YW5taW5nbUBudmlkaWEuY29tPjsgTWF0YW4NCj4gQXpyYWQgPG1hdGFuQG52aWRpYS5jb20+DQo+
IENjOiBkZXZAZHBkay5vcmc7IEFuZHJlIE11ZXplcmllIDxhbmRyZW11ZUBsaW51eC5taWNyb3Nv
ZnQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIG5ldC9tbHg1OiBkZWNsYXJlIHNpemUgb2YgcnRl
X3YxMjh1MzJfdA0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlu
a3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBXaGVuIGNvbXBpbGluZyB3aXRoIE1TVkMgdGhl
IGVycm9yIGJlbG93IGlzIGhpdDoNCj4gDQo+IGRyaXZlcnNcbmV0XG1seDVcbWx4NV90eC5oKDEx
NDgpOiBlcnJvciBDMjA2NTogJ3J0ZV92MTI4dTMyX3QnOg0KPiAgICAgdW5kZWNsYXJlZCBpZGVu
dGlmaWVyDQo+IA0KPiBUdXJucyBvdXQgdGhhdCB3aXRoIE1TVkMgdGhlIGRhdGEgdHlwZSBydGVf
djEyOHUzMl90IGlzIG5vdCB1c2VkLCBidXQgaXRzDQo+IHNpemUgbmVlZHMgdG8gYmUga25vd24u
IFRoaXMgcGF0Y2ggZGVmaW5lcyBhIG1hY3JvIHRvIHN0b3JlIHRoYXQgc2l6ZSBhbmQNCj4gcmVw
bGFjZXMgaW5zdGFuY2VzIG9mIHNpemVvZihydGVfdjEyOHUzMl90KSB3aXRoIHRoYXQgbWFjcm8u
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZSBNdWV6ZXJpZSA8YW5kcmVtdWVAbGludXgubWlj
cm9zb2Z0LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9tbHg1L21seDVfZGVmcy5oIHwgMiAr
Kw0KPiAgZHJpdmVycy9uZXQvbWx4NS9tbHg1X3J4dHguYyB8IDYgKysrLS0tDQo+ICBkcml2ZXJz
L25ldC9tbHg1L21seDVfdHguaCAgIHwgMiArLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
bWx4NS9tbHg1X2RlZnMuaCBiL2RyaXZlcnMvbmV0L21seDUvbWx4NV9kZWZzLmgNCj4gaW5kZXgg
OWM0NTQ5ODNiZS4uYzVlMmM1OTMwOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvbWx4NS9t
bHg1X2RlZnMuaA0KPiArKysgYi9kcml2ZXJzL25ldC9tbHg1L21seDVfZGVmcy5oDQo+IEBAIC0x
OTYsNCArMTk2LDYgQEANCj4gDQo+ICAjZGVmaW5lIE1MWDVfQ05UX1NWQ19DWUNMRV9USU1FX0RF
RkFVTFQgNTAwDQo+IA0KPiArI2RlZmluZSBNTFg1X1NJWkVPRl9WMTI4VTMyX1QgMTYNCj4gKw0K
PiAgI2VuZGlmIC8qIFJURV9QTURfTUxYNV9ERUZTX0hfICovDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC9tbHg1L21seDVfcnh0eC5jIGIvZHJpdmVycy9uZXQvbWx4NS9tbHg1X3J4dHguYw0K
PiBpbmRleCA5YzA3NWY2YTU2Li5iMzBkNjIwZjU0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25l
dC9tbHg1L21seDVfcnh0eC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L21seDUvbWx4NV9yeHR4LmMN
Cj4gQEAgLTMyLDcgKzMyLDcgQEAgc3RhdGljX2Fzc2VydChNTFg1X0NRRV9TVEFUVVNfSFdfT1dO
IDwgMCwgIk11c3QNCj4gYmUgbmVnYXRpdmUgdmFsdWUiKTsgIHN0YXRpY19hc3NlcnQoTUxYNV9D
UUVfU1RBVFVTX1NXX09XTiA8IDAsICJNdXN0DQo+IGJlIG5lZ2F0aXZlIHZhbHVlIik7ICBzdGF0
aWNfYXNzZXJ0KE1MWDVfRVNFR19NSU5fSU5MSU5FX1NJWkUgPT0NCj4gICAgICAgICAgICAgICAg
IChzaXplb2YodWludDE2X3QpICsNCj4gLSAgICAgICAgICAgICAgICBzaXplb2YocnRlX3YxMjh1
MzJfdCkpLA0KPiArICAgICAgICAgICAgICAgTUxYNV9TSVpFT0ZfVjEyOFUzMl9UKSwNCj4gICAg
ICAgICAgICAgICAgICJpbnZhbGlkIEV0aGVybmV0IFNlZ21lbnQgZGF0YSBzaXplIik7DQo+IHN0
YXRpY19hc3NlcnQoTUxYNV9FU0VHX01JTl9JTkxJTkVfU0laRSA9PQ0KPiAgICAgICAgICAgICAg
ICAgKHNpemVvZih1aW50MTZfdCkgKw0KPiBAQCAtNDEsNyArNDEsNyBAQCBzdGF0aWNfYXNzZXJ0
KE1MWDVfRVNFR19NSU5fSU5MSU5FX1NJWkUgPT0NCj4gICAgICAgICAgICAgICAgICJpbnZhbGlk
IEV0aGVybmV0IFNlZ21lbnQgZGF0YSBzaXplIik7DQo+IHN0YXRpY19hc3NlcnQoTUxYNV9FU0VH
X01JTl9JTkxJTkVfU0laRSA9PQ0KPiAgICAgICAgICAgICAgICAgKHNpemVvZih1aW50MTZfdCkg
Kw0KPiAtICAgICAgICAgICAgICAgIHNpemVvZihydGVfdjEyOHUzMl90KSksDQo+ICsgICAgICAg
ICAgICAgICBNTFg1X1NJWkVPRl9WMTI4VTMyX1QpLA0KPiAgICAgICAgICAgICAgICAgImludmFs
aWQgRXRoZXJuZXQgU2VnbWVudCBkYXRhIHNpemUiKTsNCj4gc3RhdGljX2Fzc2VydChNTFg1X0VT
RUdfTUlOX0lOTElORV9TSVpFID09DQo+ICAgICAgICAgICAgICAgICAoc2l6ZW9mKHVpbnQxNl90
KSArDQo+IEBAIC01MCw3ICs1MCw3IEBAIHN0YXRpY19hc3NlcnQoTUxYNV9FU0VHX01JTl9JTkxJ
TkVfU0laRSA9PQ0KPiAgICAgICAgICAgICAgICAgImludmFsaWQgRXRoZXJuZXQgU2VnbWVudCBk
YXRhIHNpemUiKTsNCj4gc3RhdGljX2Fzc2VydChNTFg1X0VTRUdfTUlOX0lOTElORV9TSVpFID09
DQo+ICAgICAgICAgICAgICAgICAoc2l6ZW9mKHVpbnQxNl90KSArDQo+IC0gICAgICAgICAgICAg
ICAgc2l6ZW9mKHJ0ZV92MTI4dTMyX3QpKSwNCj4gKyAgICAgICAgICAgICAgIE1MWDVfU0laRU9G
X1YxMjhVMzJfVCksDQo+ICAgICAgICAgICAgICAgICAiaW52YWxpZCBFdGhlcm5ldCBTZWdtZW50
IGRhdGEgc2l6ZSIpOw0KPiBzdGF0aWNfYXNzZXJ0KE1MWDVfRVNFR19NSU5fSU5MSU5FX1NJWkUg
PT0NCj4gICAgICAgICAgICAgICAgIChzaXplb2YodWludDE2X3QpICsNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L21seDUvbWx4NV90eC5oIGIvZHJpdmVycy9uZXQvbWx4NS9tbHg1X3R4Lmgg
aW5kZXgNCj4gNTU1NjhjNDFiMS4uNTY0N2Y2YTM3ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9u
ZXQvbWx4NS9tbHg1X3R4LmgNCj4gKysrIGIvZHJpdmVycy9uZXQvbWx4NS9tbHg1X3R4LmgNCj4g
QEAgLTExNDUsNyArMTE0NSw3IEBAIG1seDVfdHhfZXNlZ19kYXRhKHN0cnVjdCBtbHg1X3R4cV9k
YXRhDQo+ICpfX3J0ZV9yZXN0cmljdCB0eHEsDQo+ICAgICAgICAgfSBlbHNlIHsNCj4gICAgICAg
ICAgICAgICAgIC8qIEZpbGwgdGhlIGdhcCBpbiB0aGUgdGl0bGUgV1FFQkIgd2l0aCBpbmxpbmUg
ZGF0YS4gKi8NCj4gICAgICAgICAgICAgICAgIHJ0ZV9tb3YxNihwZHN0LCBwc3JjKTsNCj4gLSAg
ICAgICAgICAgICAgIHBzcmMgKz0gc2l6ZW9mKHJ0ZV92MTI4dTMyX3QpOw0KPiArICAgICAgICAg
ICAgICAgcHNyYyArPSBNTFg1X1NJWkVPRl9WMTI4VTMyX1Q7DQo+ICAgICAgICAgfQ0KPiAgICAg
ICAgIHBkc3QgPSAodWludDhfdCAqKShlcyArIDIpOw0KPiAgICAgICAgIE1MWDVfQVNTRVJUKGlu
bGVuID49IE1MWDVfRVNFR19NSU5fSU5MSU5FX1NJWkUpOw0KPiAtLQ0KPiAyLjQ5LjAudmZzLjAu
MA0KDQo=
