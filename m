Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB92EC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 17:37:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3916402E0;
	Wed,  5 Feb 2025 18:37:58 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
 by mails.dpdk.org (Postfix) with ESMTP id 47C7A402DC
 for <dev@dpdk.org>; Wed,  5 Feb 2025 18:37:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+LL1Moz7cQAOzcrL3Aem1cNj5i3RQHTvknV/IWv1F6ScS4gRrVvWTYU1wQjMkyDH5d5dP27eu7FwqgYKNzGq2CdwV6w/i2PlWyR0jK1DjsDPIcH4GMfkQV7jtz2bAXeb9MINbX4WCTj41Eq/hdSMuj6vusnGwVACkHroQVrDYm89GpciHWKATF5ZmBfUAiAbiYMWh9Lsg9pnx1qd1Wkl0PaaXM8iEXVcDf2GfvH0VMA0bXK543uXctPO4BZOnxSYF8haBScdhnRpU3kcySWnyxjO2udUiVXh6CbehD6GGPqjcqh93tRaAa6eY+b+uZ7abT6JBpBs+lD3hdxp4LEqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BvHGdKfFmiYjjqIpMdoG6I0x+FUMRP8wGKWrJYxcZE=;
 b=vISmwa6bKkk7MFx3/8rOgsBD09w8mZdu5IxAcbZSGPdQpwsIPxwebxWNMoIOfeQx2+evLYfX2i4aA38EHPTcrLbVB0WKZPvsgAw0sFMPlJor0AMt311KTZflySVr8PDO/iRiW8mXjStVi5bKky1dxhuYo8HKoAnJg+KAH40LvKwydgOxyPFOiU3jOz29F6P1BrR618Eno9pnUirc5nSnv69MPwNJBBe6L3oCiA3DzuGceWTJGEtz7iK7+Qd91cZa9ZgoaqrbOTuTDe6bN9S7gck0mEdXgfgffjMiqA4oAWGtvxfjW5jaDvvoCClONQM/mjhfY0itStWYgVHTZXECLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BvHGdKfFmiYjjqIpMdoG6I0x+FUMRP8wGKWrJYxcZE=;
 b=oJjw8vVkqrDPJyqXKFvfQ2t0+v4EAvmEit0fVVaGHPbMZK/fh/D0qEZ4rCY/kYxdjlO0xsiarURUtScaVtKc3DY9sxhbOGrVninShuer8aINjDRM6N1stja12wPUyrVvNLlrZvcdB1lDd3O4paDPEkXDvh5nC+2mvSfdhaRJs7YTUj08pIGXiSNIXkbjXlruOHlXtCEgwGb+sApfkH/WCL+MR8c4/1mr5oMdihEyHCvSaS3OU+Zf+YJ44PHQOMG39pn7nmM1HA3fuX6QDkyQIS4fSdVnWkJoi7sgZqfycd6QXk7+jAynprVOOAAEhxZ3LQqynU10wNOs1hfDh+peHA==
Received: from SA1PR12MB9491.namprd12.prod.outlook.com (2603:10b6:806:458::21)
 by IA1PR12MB6531.namprd12.prod.outlook.com (2603:10b6:208:3a4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 17:37:54 +0000
Received: from SA1PR12MB9491.namprd12.prod.outlook.com
 ([fe80::83e7:75dc:5128:784]) by SA1PR12MB9491.namprd12.prod.outlook.com
 ([fe80::83e7:75dc:5128:784%7]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 17:37:54 +0000
From: Shani Peretz <shperetz@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Tyler Retzlaff <roretzla@linux.microsoft.com>, Parav
 Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, Hemant
 Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Rosen Xu <rosen.xu@intel.com>, Chenbo Xia <chenbox@nvidia.com>, Tomasz
 Duszynski <tduszynski@marvell.com>, Chengwen Feng <fengchengwen@huawei.com>,
 "NBU-Contact-longli (EXTERNAL)" <longli@microsoft.com>, Wei Hu
 <weh@microsoft.com>, Bruce Richardson <bruce.richardson@intel.com>, Kevin
 Laatz <kevin.laatz@intel.com>, Jan Blunck <jblunck@infradead.org>
Subject: RE: [PATCH v4] bus: fix inconsistent representation of PCI numbers
Thread-Topic: [PATCH v4] bus: fix inconsistent representation of PCI numbers
Thread-Index: AQHbcitqrFX8S5R050u+BzY3Knp28rMt8G0AgAsCg8CAAAJ8AIAADxkw
Date: Wed, 5 Feb 2025 17:37:54 +0000
Message-ID: <SA1PR12MB9491A6FDB9AD2FC28CC5A0BEBFF72@SA1PR12MB9491.namprd12.prod.outlook.com>
References: <20240708165145.1405107-1-shperetz@nvidia.com>
 <20250129085416.226718-1-shperetz@nvidia.com>
 <20250129082518.47630942@hermes.local>
 <SA1PR12MB94915F840D6A2D631AA02E1ABFF72@SA1PR12MB9491.namprd12.prod.outlook.com>
 <20250205084202.264d9781@hermes.local>
In-Reply-To: <20250205084202.264d9781@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB9491:EE_|IA1PR12MB6531:EE_
x-ms-office365-filtering-correlation-id: 5b0dc6d0-9822-456e-3500-08dd460bd226
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?YWJTRlVMeVRSZ3BlUytkeUtuYnRmMFpENnBZL1FvYmgrS0dJanRsZTZtZ1gv?=
 =?utf-8?B?M2dHTjNBb3Zkand4ZldGQmw0VGlFL0VsWlpxVjJSUzdyRHhoSVZYZkFmQmla?=
 =?utf-8?B?L3BNdEVGdHZRcEZpbjdRZDJaRGwxVitOc3ZUdVZOT3JVSXB6c2VBa0FFV0tG?=
 =?utf-8?B?RDhLck4xMkticmxYb0pKaHJPMEJja2VOMFk3RTF3V1NYZGRTaU5KR083OVkv?=
 =?utf-8?B?ZG14KzhITDE1VEI4MjNtMzdYTVRqWEdwc2lIUjFKWFpLYWNLb3o2YjV0bDhp?=
 =?utf-8?B?dmhqSTJRVFJ1VHF4bG81b1B1VW1OVVFmT3dKb29rMEdORWQzdHBaRWxlZWVx?=
 =?utf-8?B?V2dnU0wraWRMaE9HWHFyR0JURDBFQkhYUkM5R1I1TTVXVUJOaGJ6RUhiaFhp?=
 =?utf-8?B?eWhWV1VDUmxkb1BoOXdDSGVRVjVPTDRvRG5MM0FxVGtkek82dzJtTmFvbHdR?=
 =?utf-8?B?WTJ5SVR1SWhyRjUrdWt3UzIzQ2dGUVZocXNOYk5ZRWdpM2JlRVV1NHo1bHJD?=
 =?utf-8?B?clVhKzhTTHoxemc0aWV1WTFUMFZXZGhpRDNOcjcva0JBSGwyUER5clJpT250?=
 =?utf-8?B?dzlES0thLytDTG1uT3lUVlQwTWlBQVgwYXBLU25yZDU3bWhWOVRUWlVnblRa?=
 =?utf-8?B?eXYzM3BRY3hNT3FHS2hBQ0pCdWRQQ3ZEdXVpVGU0SVlxZzZROTRZQUxFSUR4?=
 =?utf-8?B?U21uLzZyOUgyOFhRYmpIOC94eWhCdStGTjFRR0lSbUFZalp1VlVXV3RtTjBY?=
 =?utf-8?B?VGZzbXhHSkZiWi9uR1BLNGdTbThyQVRGb0hnSDMwTHFyOVAySUY0N1p6Nmta?=
 =?utf-8?B?M0VkMGJKZ3NwL1Jha1h3NlZSV1RUMWM0UXFOTHdRRHVFdEZJVkNHOUp4b2RT?=
 =?utf-8?B?MnhVc01sUU5JaXFHU2hZU2xvb21UUjgvUHNkN2RWSzgzWG5kSjk0aFY5cFVT?=
 =?utf-8?B?RFZPalhBOTdlZzltbmhWaEtVTUVBb0sxM04xZ21wWlk1dEdlemFaQllvR1Jo?=
 =?utf-8?B?Wlk1OVRMU1RMVlJKdHhvaWNOWEhHcVc5aWpLWjZaODQxWlBHWEpTdFpORGd2?=
 =?utf-8?B?cW5SOEdyMmc4ei9uSjBRNnJYNFUwWlJiZ2dkaFZNVWZTbnBITWZmSWI1ZFpi?=
 =?utf-8?B?ZXFyeWx1cnNNNmZubDQxL1JwenBnc0xEaUQ5Z2dxVnJTZjd6d0t3VTlPYXZS?=
 =?utf-8?B?Z2M5Wm9ZMUhnWWdxcXZyUlJJbUg3bHJxM2dicG1DeHczZ21QbURwY3pwSjVP?=
 =?utf-8?B?bnFQaWpkblVyRzFVZFBWejU0M3VmaC9VWkgrMTJ2V1pnRFVJME9GaEFWc0p0?=
 =?utf-8?B?SXQ4Nmx2Z2k4aWpLMlRjenFaTWZ2SUhCdlpSalFzd2RGNUsybHZyc1ovcFNP?=
 =?utf-8?B?ZGhWY1hwQVZnNXhGTVc2MFdwZGU3RndSTEgxN2VCbG45eTZ5VzdVZnJtSTJC?=
 =?utf-8?B?Uld3aXllM2FQSnYyaDJMV2s0MHRabndQNXlWWWpQQnA0U0ZQVHVTZ0cwM1BL?=
 =?utf-8?B?VUw0OE1GSGJucXlkOGVySkIzSmNscWdBRDFMaWtja2RHUGJIYW1pbDlEOEpS?=
 =?utf-8?B?Sm10MlZwNitBdmkvcWh0MnhXblE3eGN0S1NKU3h1bFZ0eUEzMTZsOGg1NjB1?=
 =?utf-8?B?Tkh4TjRlWW1rT3Z2YnNlOW4rZVBNNzJVSzlWNm9NVUROWHA3OURQaHpEdjA2?=
 =?utf-8?B?cW1RMTdFUVpIalBiYVdBeCt6MW13TFJzMlRmaGFzZlJnSEx4RndJMUQwZFhS?=
 =?utf-8?B?M01pS1V2ZWErUExodkM4SEw3a1A4TmtEdjlRUlBsWGlUUFlCY3g2SnFKbkJj?=
 =?utf-8?B?MXRrT0NCR2duVEtqbVgvejRNMXBXVStUM2NmZUhNR2RSRHhPSy81YUl6RjBi?=
 =?utf-8?B?YUVCb2xteGV1T2tNMVZjbmt6aDAxMVd0SlV6NG14RlYvalJQVjBzVzdUZm5S?=
 =?utf-8?Q?V9yRq+Pgp9BY825GFxZHKJY+zePYlFgn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB9491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2sxWWdmUmlHc2NVWTRnVm81T1pEWW14aEo4NlpRSzNkTWJrTGMySVJFYUZl?=
 =?utf-8?B?TTRaMXN5eFhFWG42a1pvSVlZOUhWUEpzL2IvamdWK1R1NFU1RFlEdmpJK01r?=
 =?utf-8?B?ZDcvaHE3TTM2azhmdjlHUEJsY0ZjSTZIZElHUk0wZ2dQQXpsaDNQbE53c25K?=
 =?utf-8?B?M1Y1Y3d4YXpqTS83ZllSNUt3bW1PQThQNzRoRFlOWVE3T1ZWOUFVQnByMElM?=
 =?utf-8?B?NWpQdFVuSHVLZUpSMGZHeXptZFFvQVNyTzE1cjRTdXVpUlhhbnVGd2xmYnI5?=
 =?utf-8?B?YkZwYTVVakUvNWdlTmlIRjFwcmFtMkQ3WW5aQkk4eWViQmhjRUU1WmdoU2Rt?=
 =?utf-8?B?VURMVXlFRGNibURNVUZFNnJsQldidGZZM2hzODlpdWdOMlRPdG5rbjFObjAr?=
 =?utf-8?B?NDhuTTl3Y0kzdGlib1hWRU1TckpYN0N1cWg3N2l3N3R1YlMzWkdLVUlIaTNC?=
 =?utf-8?B?elRYRjBXRlNOeUJlVjFpSHN0QTNhVU8zQk5YMTE3Sm5WV0dZNmF5K2JtK1pC?=
 =?utf-8?B?VzBsQlIwMldlcURnY2JNalFqSXRNREJJVS94OW9zSjlxaVhLeGFja0JBSTly?=
 =?utf-8?B?NWNWNnhHT2xwQW9TMWNab29pYVhybVpVZkNsTEV2ZlpIeVZUbDRadXNvRGtS?=
 =?utf-8?B?SEpXZCsxTFg2eUNCVUZ3K2EySURrdFA5T1lhSnNTSzRCaGltVklKT0J4RHdK?=
 =?utf-8?B?MGdudEt3UDdLU0lQV3cramJ5Z3ZnN2szY25SQ0pSRDN4TlJreHdGVGlhK2Ex?=
 =?utf-8?B?QTFpbEd3WFlwUEZTRG83aVYrbExnVk9oYzJTWjVwakp2dWZENDVxb0tTYVox?=
 =?utf-8?B?bFVvRDlvT0tzdmhjSUZ4Y1Z1eEZOZzBXY3ByanNVMlhFTkFLMTdiNTlKYitw?=
 =?utf-8?B?Wit2OUVraVB0R2pMbC94UkR6NUxMRlRVcjlHcGQ3enFFcWkxYVRsc3J1Ynls?=
 =?utf-8?B?RzhFSVRqWWtMbUNJYmh2WVp4ZXhqUlVVaHNIOGNiSGcvU0JPYi9wcVEyM1hD?=
 =?utf-8?B?c2Vpd3RzQTEzZzZycUtxUWE2TWQ3ZlNVM3hhWE1qSTFMVEJ1Sk9lZWMrL00r?=
 =?utf-8?B?WStoclpmbktuR2ZoSWpQemlENkU4eXhtUDhhTmxVMXZkR1JlMEZOTjJoZWFu?=
 =?utf-8?B?dFhsbnFkSGJ0Mk1DT3Q4bldNMlpZTmI4UFZ0RXlGc0JTaFowUWpQcDVzdVhj?=
 =?utf-8?B?ei8yaTJWVFBLTE8ySGxzb3VPN3YremZtVS9LOEFadEZScmxQZTR5Ky9WUXlk?=
 =?utf-8?B?NFBORXdURnhaaTYvaTlpM2t0cE8rOFR1Tk51RVVoYkdueVBwQS9zQnpvMnEy?=
 =?utf-8?B?YkVXM2dRWm9pbHQvcFRJN1hmc295Rm9iSllCSjFXNGdnOFE0ODhCb29rVFF6?=
 =?utf-8?B?ZkdHNFlpRW9OL2NEUzdDampIN1JHOENCanFFUDNESkY4VXE5OGRZTUdyYkI4?=
 =?utf-8?B?QUJUY3MwN0FyRXF2blpoNjVuRnF3amI4Yjh0YVJsaFMza2RRaEVmQURHaHVp?=
 =?utf-8?B?V1lWQVVIckZkRXFGa0ZyRXpHUHZCRm8yR1puY1FoV3F1aVlweU85TnZ5bGVZ?=
 =?utf-8?B?YndRTWErVDRBWFhjckt6S2plOERmVUI4RHZxQ0dwTVVobXpXYUQwb01DODVL?=
 =?utf-8?B?aVRCcTFjTTM0NVR5TlY1RW9WUzVWZm95Uy9TYk02RDNqcHNMOFlVa2lMRXN5?=
 =?utf-8?B?aG9ERWk4eGhYeWhvYjRURUlXS1lvclYzTGFiaVY0T1dLYUpnQUtHeFNUVHNp?=
 =?utf-8?B?S0RKMWhabkEvNUdDcVJDaWlMU2hkZWRCMXEyaFozNE9XZ0NkdTB1RVp1ZThk?=
 =?utf-8?B?YjRmZkRqZXhUOTFwNWM0a1M1dmM1aGNXZU9pSnhpWDNMWnBKVG0yM0VpSjdy?=
 =?utf-8?B?NWpuQ2RTYW13SFNTeFZjSXc0eHl1dGdnR2kvbXQwTm9tc1ByVml6Y2ZCcWJL?=
 =?utf-8?B?MVFCOUxucWlzUy9kVCtwNmRDc0N1a2FBRTlHV055eENaOFJIdUZYd1p0Y2FI?=
 =?utf-8?B?S3d1R01mbzh5WnA2Q3psRHFrcWFqSnJjS3JmNlB3OXVSY1BXaDBUQzU0Tmlt?=
 =?utf-8?B?QzNuTTU2N2xPUmRDYncwVFE0NUcvV0xVOWFIRTUvTmNPQVovYUhYRENlUkd1?=
 =?utf-8?Q?TlV+I5fff0A8dCKIzjpYLdai+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB9491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0dc6d0-9822-456e-3500-08dd460bd226
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 17:37:54.0239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rSpErrKGQ5BlyyoDR/r1qiuKw3hZ/HZ9+CiUwVd9V00eeUx4aiyJ/7F0fShy3s5supiXcDxXivF9S25uMtzKmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6531
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBIZW1taW5n
ZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIDUgRmVi
cnVhcnkgMjAyNSAxODo0Mg0KPiBUbzogU2hhbmkgUGVyZXR6IDxzaHBlcmV0ekBudmlkaWEuY29t
Pg0KPiBDYzogZGV2QGRwZGsub3JnOyBOQlUtQ29udGFjdC1UaG9tYXMgTW9uamFsb24gKEVYVEVS
TkFMKQ0KPiA8dGhvbWFzQG1vbmphbG9uLm5ldD47IFR5bGVyIFJldHpsYWZmIDxyb3JldHpsYUBs
aW51eC5taWNyb3NvZnQuY29tPjsgUGFyYXYNCj4gUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPjsg
WHVlbWluZyBMaSA8eHVlbWluZ2xAbnZpZGlhLmNvbT47IE5pcHVuIEd1cHRhDQo+IDxuaXB1bi5n
dXB0YUBhbWQuY29tPjsgTmlraGlsIEFnYXJ3YWwgPG5pa2hpbC5hZ2Fyd2FsQGFtZC5jb20+OyBI
ZW1hbnQNCj4gQWdyYXdhbCA8aGVtYW50LmFncmF3YWxAbnhwLmNvbT47IFNhY2hpbiBTYXhlbmEN
Cj4gPHNhY2hpbi5zYXhlbmFAbnhwLmNvbT47IFJvc2VuIFh1IDxyb3Nlbi54dUBpbnRlbC5jb20+
OyBDaGVuYm8gWGlhDQo+IDxjaGVuYm94QG52aWRpYS5jb20+OyBUb21hc3ogRHVzenluc2tpIDx0
ZHVzenluc2tpQG1hcnZlbGwuY29tPjsNCj4gQ2hlbmd3ZW4gRmVuZyA8ZmVuZ2NoZW5nd2VuQGh1
YXdlaS5jb20+OyBOQlUtQ29udGFjdC1sb25nbGkNCj4gKEVYVEVSTkFMKSA8bG9uZ2xpQG1pY3Jv
c29mdC5jb20+OyBXZWkgSHUgPHdlaEBtaWNyb3NvZnQuY29tPjsgQnJ1Y2UNCj4gUmljaGFyZHNv
biA8YnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5jb20+OyBLZXZpbiBMYWF0eg0KPiA8a2V2aW4ubGFh
dHpAaW50ZWwuY29tPjsgSmFuIEJsdW5jayA8amJsdW5ja0BpbmZyYWRlYWQub3JnPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY0XSBidXM6IGZpeCBpbmNvbnNpc3RlbnQgcmVwcmVzZW50YXRpb24g
b2YgUENJIG51bWJlcnMNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5n
IGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24gV2VkLCA1IEZlYiAyMDI1IDE2OjM2
OjExICswMDAwDQo+IFNoYW5pIFBlcmV0eiA8c2hwZXJldHpAbnZpZGlhLmNvbT4gd3JvdGU6DQo+
IA0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFN0ZXBoZW4g
SGVtbWluZ2VyIDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz4NCj4gPiA+IFNlbnQ6IFdlZG5l
c2RheSwgMjkgSmFudWFyeSAyMDI1IDE4OjI1DQo+ID4gPiBUbzogU2hhbmkgUGVyZXR6IDxzaHBl
cmV0ekBudmlkaWEuY29tPg0KPiA+ID4gQ2M6IGRldkBkcGRrLm9yZzsgTkJVLUNvbnRhY3QtVGhv
bWFzIE1vbmphbG9uIChFWFRFUk5BTCkNCj4gPiA+IDx0aG9tYXNAbW9uamFsb24ubmV0PjsgVHls
ZXIgUmV0emxhZmYNCj4gPiA+IDxyb3JldHpsYUBsaW51eC5taWNyb3NvZnQuY29tPjsgUGFyYXYg
UGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPjsNCj4gPiA+IFh1ZW1pbmcgTGkgPHh1ZW1pbmdsQG52
aWRpYS5jb20+OyBOaXB1biBHdXB0YQ0KPiA8bmlwdW4uZ3VwdGFAYW1kLmNvbT47DQo+ID4gPiBO
aWtoaWwgQWdhcndhbCA8bmlraGlsLmFnYXJ3YWxAYW1kLmNvbT47IEhlbWFudCBBZ3Jhd2FsDQo+
ID4gPiA8aGVtYW50LmFncmF3YWxAbnhwLmNvbT47IFNhY2hpbiBTYXhlbmEgPHNhY2hpbi5zYXhl
bmFAbnhwLmNvbT47DQo+ID4gPiBSb3NlbiBYdSA8cm9zZW4ueHVAaW50ZWwuY29tPjsgQ2hlbmJv
IFhpYSA8Y2hlbmJveEBudmlkaWEuY29tPjsNCj4gPiA+IFRvbWFzeiBEdXN6eW5za2kgPHRkdXN6
eW5za2lAbWFydmVsbC5jb20+OyBDaGVuZ3dlbiBGZW5nDQo+ID4gPiA8ZmVuZ2NoZW5nd2VuQGh1
YXdlaS5jb20+OyBOQlUtQ29udGFjdC1sb25nbGkNCj4gPiA+IChFWFRFUk5BTCkgPGxvbmdsaUBt
aWNyb3NvZnQuY29tPjsgV2VpIEh1IDx3ZWhAbWljcm9zb2Z0LmNvbT47IEJydWNlDQo+ID4gPiBS
aWNoYXJkc29uIDxicnVjZS5yaWNoYXJkc29uQGludGVsLmNvbT47IEtldmluIExhYXR6DQo+ID4g
PiA8a2V2aW4ubGFhdHpAaW50ZWwuY29tPjsgSmFuIEJsdW5jayA8amJsdW5ja0BpbmZyYWRlYWQu
b3JnPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NF0gYnVzOiBmaXggaW5jb25zaXN0ZW50
IHJlcHJlc2VudGF0aW9uIG9mIFBDSQ0KPiA+ID4gbnVtYmVycw0KPiA+ID4NCj4gPiA+IEV4dGVy
bmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+ID4g
Pg0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgMjkgSmFuIDIwMjUgMTA6NTQ6MTYgKzAyMDANCj4gPiA+
IFNoYW5pIFBlcmV0eiA8c2hwZXJldHpAbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4g
PiArY3JlYXRlX3BjaV9kZXYoY29uc3QgY2hhciAqbmFtZSkNCj4gPiA+ID4gK3sNCj4gPiA+ID4g
KyAgICAgaW50IHBvcnRfaWQ7DQo+ID4gPiA+ICsgICAgIHVpbnQ4X3Qgc2xhdmVfbWFjMVtdID0g
ezB4MDAsIDB4RkYsIDB4MDAsIDB4RkYsIDB4MDAsIDB4MDAgfTsNCj4gPiA+ID4gKyAgICAgc3Ry
dWN0IHJ0ZV9ldGhlcl9hZGRyICptYWNfYWRkciA9IChzdHJ1Y3QgcnRlX2V0aGVyX2FkZHINCj4g
PiA+ID4gKyopc2xhdmVfbWFjMTsNCj4gPiA+DQo+ID4gPiBVc2UgZGlmZmVyZW50IGluaXRpYWxp
emVyIGFuZCB5b3UgY2FuIGF2b2lkIHRoZSBuZWVkIGZvciBjYXN0IGhlcmUuDQo+ID4gPg0KPiA+
ID4NCj4gPiA+ID4NCj4gPiA+ID4gKy8qKg0KPiA+ID4gPiArICogR2VuZXJhbCBkZXZpY2UgbmFt
ZSBjb21wYXJpc29uLiBXaWxsIGNvbXBhcmUgYnkgdXNpbmcgdGhlDQo+ID4gPiA+ICtzcGVjaWZp
YyBidXMNCj4gPiA+ID4gKyAqIGNvbXBhcmUgZnVuY3Rpb24gb3IgYnkgY29tcGFyaW5nIHRoZSBu
YW1lcyBkaXJlY3RseS4NCj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsgKiBAcGFyYW0gZGV2DQo+ID4g
PiA+ICsgKiAgIERldmljZSBoYW5kbGUuDQo+ID4gPiA+ICsgKiBAcGFyYW0gbmFtZQ0KPiA+ID4g
PiArICogICBOYW1lIHRvIGNvbXBhcmUgYWdhaW5zdC4NCj4gPiA+ID4gKyAqIEByZXR1cm4NCj4g
PiA+ID4gKyAqICAgMCBpZiB0aGUgZGV2aWNlIG1hdGNoZXMgdGhlIG5hbWUuIE5vbnplcm8gb3Ro
ZXJ3aXNlLg0KPiA+ID4gPiArICovDQo+ID4gPiA+ICtfX3J0ZV9pbnRlcm5hbA0KPiA+ID4gPiAr
aW50IHJ0ZV9jbXBfZGV2X25hbWUoY29uc3Qgc3RydWN0IHJ0ZV9kZXZpY2UgKmRldiwgY29uc3Qg
dm9pZA0KPiA+ID4gPiArKm5hbWUpOw0KPiA+ID4NCj4gPiA+IEl0IHdvdWxkIG1ha2UgbW9yZSBz
ZW5zZSB0byBtZSBpZiBuYW1lIHdhcyBhIGNoYXJhY3RlciBub3Qgdm9pZCBwb2ludGVyLg0KPiA+
ID4NCj4gPiA+IFRoZSBkZXNpZ24gbWlnaHQgYmUgY2xlYXJlciBpZiBidXMgYWRkcmVzcyB3YXMg
bW9yZSBvZiBhbiB0eXBlZGVmDQo+ID4gPiB3aXRoIGEgcG9pbnRlciBhbmQgc2l6ZSB0b2dldGhl
ci4gVHJlYXQgaXQgbW9yZSBsaWtlIGFuIG9iamVjdC4NCj4gPg0KPiA+DQo+ID4gT2theSBzbyBq
dXN0IHRvIHVuZGVyc3RhbmQsDQo+ID4gdGhpcyBpcyB0aGUgc3RydWN0IEkgYW0gYWRkaW5nOg0K
PiA+DQo+ID4gICAgICAgc3RydWN0IHJ0ZV9idXNfYWRkcmVzcyB7DQo+ID4gICAgICAgICAgICAg
IGNvbnN0IHZvaWQgKmFkZHI7DQo+ID4gICAgICAgICAgICAgIHNpemVfdCBzaXplOw0KPiA+ICAg
ICAgIH07DQo+ID4NCj4gPiBUaGlzIGlzIGhvdyBJIHBhc3MgaXQgdG8gZmluZF9kZXZpY2U6DQo+
ID4NCj4gPiAgICAgICBzdHJ1Y3QgcnRlX2J1c19hZGRyZXNzIGRldl9hZGRyID0gew0KPiA+ICAg
ICAgICAgICAgICAgICAuYWRkciA9IGRhLT5uYW1lLA0KPiA+ICAgICAgICAgICAgICAgICAuc2l6
ZSA9IFJURV9ERVZfTkFNRV9NQVhfTEVODQo+ID4gICAgICAgfTsNCj4gPiAgICAgICBkZXYgPSBk
YS0+YnVzLT5maW5kX2RldmljZShOVUxMLCBydGVfY21wX2Rldl9uYW1lLCAmZGV2X2FkZHIpOw0K
PiA+DQo+ID4gQW5kIHRoaXMgaXMgaG93IEkgdXNlIGl0IGluIHJ0ZV9jbXBfZGV2X25hbWU6DQo+
ID4NCj4gPiAgICAgICBydGVfY21wX2Rldl9uYW1lKGNvbnN0IHN0cnVjdCBydGVfZGV2aWNlICpk
ZXYxLCBjb25zdCB2b2lkICphZGRyKQ0KPiA+ICAgICAgICB7DQo+ID4gICAgICAgICAgICAgIGNv
bnN0IHN0cnVjdCBydGVfYnVzX2FkZHJlc3MgKmRldjJfYWRkciA9IGFkZHI7DQo+ID4gICAgICAg
4oCmDQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gSXMgdGhhdCB3aGF0IHlvdSBtZWFudD8NCj4gPiBB
bHNvLCBJJ20gbm90IHN1cmUgaWYgdGhlIHNpemUgaXMgcmVhbGx5IG5lZWRlZCwgYmVjYXVzZSB3
ZSBjaGVjayB0aGUNCj4gPiBzaXplIG9mIHRoZSBwYXJzZWQgbmFtZSwgd2hpY2ggbWF5IGJlIGRp
ZmZlcmVudCB0aGFuIHRoZSBzaXplIG9mIHRoZQ0KPiA+IG9yaWdpbmFsIG5hbWUNCj4gPg0KPiAN
Cj4gSXQgd291bGQgYmUgYmVzdCB0byBwYXNzIHJ0ZV9idXNfYWRkcmVzcyB0byBydGVfY21wX2Rl
dl9uYW1lIHJhdGhlciB0aGFuDQo+IGhhdmluZyBpbXBsaWVkIGNhc3QuDQo+IE5vdCBzdXJlIGlm
IHRoYXQgaXMgcG9zc2libGUgd2l0aG91dCBicmVha2luZyBBUEkgdGhvdWdoLg0KDQpJIHRoaW5r
IHlvdSBhcmUgcmlnaHQsIGFsc28gaXQgd2lsbCByZXF1aXJlIHRvIGNoYW5nZSB0aGUgc2lnbmF0
dXJlIG9mIGZpbmRfZGV2aWNlIHdoaWNoIHdpbGwgbWFrZSBpdCBldmVuIGJpZ2dlciBjaGFuZ2UN
Cg==
