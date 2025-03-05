Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9300C282D9
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 10:43:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E425D40275;
	Wed,  5 Mar 2025 11:43:12 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by mails.dpdk.org (Postfix) with ESMTP id 05D384025F
 for <dev@dpdk.org>; Wed,  5 Mar 2025 11:43:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvVdPIuWPSHKQBdVdm0mYciJCNqRc6vSht59cJ27FfhYpSjRSNz4707nWsxIDHE+dR2a6PG0H9TdLHEG0kem0kixbFwe3WYteKfQLoznHUbozFHsQ3Q/rEhJa4hyiCelUMUzSYrA1N1VEfek7Jo0W7uaxpMRaO8j5lvAkyD3d/SYsx4ADQgjDcMxhjoO6f33sKU6IqVWYDsttHljzDzNYGsLxYOxJCAtDdwod3W2YahbocO/Rjg4Z6mncPwWojrwoaCfeUxyAI3n6Tt925pkaGB4GR6PbyK4z1PDsnP9oCLpvuU89NWDeHpX+Hiaf99Buj8s8h+dpIoJRF2ckKuWsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSHJD/18pD6F1Zd7YFNhAm37KXILse3hDT5erWKMhmE=;
 b=m4cxyU4MzD/TY3MtyCaSC4qmHaHsYCbqTMNtDjzme41I0ARrea6k2n7VVe8grqt7AsNhDcj4XPh2qfSguhxh+s+k5XxSfWKC4mouH52Cd4aXqOfpTJCDb7rme+U0GMlxWHAgGrCj7sR0JKneInqpEJReOTN7ZL3WtojvGCA52aUui7f5CJEOYT8liZLW9CKfgxrBZOpELdBLOct0kKRavCwb/jOgnW2aaf0SfmMEVIb4TS8FxActuGrhxX5dTM9MdB+Eory1CX5iU0JpQNOKOIWqoqurO6QV3xO+sBddtilXPYC4vvoTojcgYjY4CwKLD9F/IbCdbDA/AQGjWtiFgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSHJD/18pD6F1Zd7YFNhAm37KXILse3hDT5erWKMhmE=;
 b=YlnXvYXVlaG0BaieSoGvNi3GbVwYr4mmnVhyWsKgmdC0UW/+Xn2RZThYJDHOYD1UJDb/z1lJC7/SQkkjd1y33Bc7mYqlNtA6Mu0b6pwlcasWbyLuRiDU7gGooxUFMrG3zAt4/Iqz/YJBdqOpS2SCk7B/ywCkKBCOF/NYHT3idUwCzkbTJLD05sbLgD0LZobWrzYBSlYMqgnJa0Gw38ZdL8LOATYdXsOf58UpikR6Mq+67zw0LSHz1n1jHNIMJF+f3XQh8tqj3RIvJ4W5hJRJ/G0eNSt2DU04tjPUNul8rY2XMiA1hG6jaxNF2vTJknTAhl+sgPupO6GU/KYaMKrgmw==
Received: from PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 by PH7PR12MB6980.namprd12.prod.outlook.com (2603:10b6:510:1ba::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 10:43:09 +0000
Received: from PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286]) by PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286%4]) with mapi id 15.20.8489.028; Wed, 5 Mar 2025
 10:43:09 +0000
From: Ali Alnubani <alialnu@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>, Akhil Goyal <gakhil@marvell.com>, Gowrishankar
 Muthukrishnan <gmuthukrishn@marvell.com>
Subject: RE: [PATCH] vhost/crypto: fix build with asserts
Thread-Topic: [PATCH] vhost/crypto: fix build with asserts
Thread-Index: AQHbjbMV2HGFk8Po7kynS7BjaQuFSLNkW1zg
Date: Wed, 5 Mar 2025 10:43:09 +0000
Message-ID: <PH7PR12MB91732EA3B22C22030E24FCF5DACB2@PH7PR12MB9173.namprd12.prod.outlook.com>
References: <20250305094323.598983-1-david.marchand@redhat.com>
In-Reply-To: <20250305094323.598983-1-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB9173:EE_|PH7PR12MB6980:EE_
x-ms-office365-filtering-correlation-id: 68a39ae7-bf85-41fd-5e13-08dd5bd28561
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UFZpQ0hqc1E1UE5mK1lBaUdVVm1zSnVSUER6UkRtaGhzL2VJdzEwL1NYeitD?=
 =?utf-8?B?V0xvZHVOZDVUSU5wYW5yVTBtemxwRWdUSWd6bE82Tjg0dkJjR0lYVXZsZ3V4?=
 =?utf-8?B?b1llS2NXTXdUeGxuN2orYUFzQlRuMENhbk8yMDhaSHFHTkFRTEt1SmNRTHdE?=
 =?utf-8?B?ZEx4ZGhSUEFFZzRSek9iaGdkNVA2SVBtYU9NZ0trOTRtSGFTdzhhTFlFWFd0?=
 =?utf-8?B?S2M5MzJRRnJiSk5ZVjB2TFZlRmg4dEJvdDlKMkdaSmNJTzZ0cERDb0wrWkZ3?=
 =?utf-8?B?alZ3K1BHZ3RHTytONXgzOFFGU3lHbXJQNHRWUFJnZ2ljbUM5cWxlVzRvVFlZ?=
 =?utf-8?B?OGp0OXljbHZlZFVtbXR4V0M2RE02OTIwS3JjTjl1VXAxT2dYM3YrLzlwZUl6?=
 =?utf-8?B?YW5qWEZMcDVKQUhzQjRoN3FNOTNaRG5jcHN4cnAweHNCRUpYYkc4RXVzM3cv?=
 =?utf-8?B?Rzhqb3NudmphSmVndHdVZ2RiYmNiYnhaZ00xOXpyUkI5WVNNeVZEYnFCaFNu?=
 =?utf-8?B?Z3g4MXNYNFprUTdMd2JKZzdFcUIwOUJabm5GVkpzOElsbVJFWmx2cUVKdTZR?=
 =?utf-8?B?dkUrQ2hGL202MC9nL1UreFFhVHFYblN1NXVvTkxBcVN6SThWNkE4SDR3bUtV?=
 =?utf-8?B?RDZKQzF5dDVZcHZtZ1ZSb0hUT2ltLzAxQm9KbFV2NkRDY3dRVHZlVTRpZ2Fo?=
 =?utf-8?B?WkRoR1FKZEo4WGNSVTdHZmZRcW52UmxDTHpHdXRtWkVvbk55bU1Oem00Z1BD?=
 =?utf-8?B?T3E2VlJGVHdDVUU2U2FoNkJxeTM5SEQxZzVERFdnNXd2d0hwN2RjMXBqMWNS?=
 =?utf-8?B?b1lzcFNab2lWVkpwRzlYcGd1Q2lydGpOekVEUEpkbll3ZTROdUpYVFE5azVO?=
 =?utf-8?B?eFR3UHBueVIrcWxJVTJuSXNYUURMS21hNGRGR1VKbzBtQmhPb2NsZ3ZlZXE5?=
 =?utf-8?B?RTRZcmEwMUdmOVNXUHZpbithM0Y4OGZ0QnMybUw0T1VRTUU2NmRXUnZXSity?=
 =?utf-8?B?c2ppa0dWU1I3U21DS25TMTNFWlhHbDNvQUd3N2lpME5xQXdzbTl1YnVZbll6?=
 =?utf-8?B?NUxDcTFIV1pJSzZrakt6U1JBTURrUE90OWcrZkxwUGVPRzM0QVZwN1RTalc3?=
 =?utf-8?B?YUlSZlA3aXMxRndrRmxZRllwUmg1RGFlaVNGZ0VpUG1FSUZITlJUM0kyM3Y0?=
 =?utf-8?B?aU9DSkNDT2w1cmYxQjZtdGcxTFhaRHlXUzhyQ2pybm54MzdCUURIQ0VycG1X?=
 =?utf-8?B?L0hGQ2xMeklLa2NmdnZRS3Y3MGJBVmxiVEtaeHh6ODZUeWNLM1B2UkVST2Fa?=
 =?utf-8?B?aXp6czltSUM1d0ZieG5Ncmc0bHJMRjJhYmNYN3d0US9RZHVYS0U3aGlvTVpF?=
 =?utf-8?B?NEdMcjNWN0FoR0YxRUxNYnlKeDVwZ0d1YUpMUGNLNkJGalRCZjZFWm5RaGVw?=
 =?utf-8?B?NWkva2JKYUdCakpOSjZJVUo5R3NObVNreXZEYldjd2FGNXZ0RG5udHlWVUNH?=
 =?utf-8?B?Uy9nc0xtYTU0OVlaRWtuaE9oU2JxM1BKUXFtOG9zVURoRS9mNTZISmx2bldH?=
 =?utf-8?B?QkFIdXhvd1dyVlJXV2wveVZuNHlhRGlUTWhONElESm5Ra0hqa3RVMExObFRJ?=
 =?utf-8?B?WFU2U3lGbk5qWFFqNlk2Qm5JM3BOU1pzRFFtRmtNZ2ZsWi8vazVMUEd6cWxY?=
 =?utf-8?B?bFhzTGRIVDVuSDdKb0dqNVc3T1hJeGVlK2ZnKzUrbFp1N2c1MDY3TVBGdC82?=
 =?utf-8?B?RmdsWTNKelJob1ZsV0pCTnlSVTF1aVNoM3JCRG1LaVVsVjIrZ21Zdk8zUitR?=
 =?utf-8?B?RE1jak80WWErT1FhbVRWM01sczAvUjZlaHV3NVQ2d2VhTjFjaHRsTzU0SnBL?=
 =?utf-8?B?OGFzU2pPc1dmellwQnpUVncyNWkzR2QwVzlRaE1SQi9VNXZmYXR5Yy9QZWtk?=
 =?utf-8?Q?DbcXOhL7iCHVhy0n5AhwA9+WwXoq4xLM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1MvUEQxeW9wd1dWT0wrMHl6bUdXdEJOR2JaQW5DUUJYMjVScmRRZmZqNVVs?=
 =?utf-8?B?ZFJLSE1BMUxZa2pvTEhQVVNEQXA1UXRoRmZhcWl0a3RyeXRPOWxxazRTaGgv?=
 =?utf-8?B?aWIvWTk3aFNIdWxtK0FWRVJSY2hjOUNPbmovdExieW5vSUxhcHZVNGVyQlZF?=
 =?utf-8?B?R0xkZi81Y2lSc1FlLzJGWEYxZGVDb2ZOaGFVbXJNWVdDRHVFb1BOQmIybDZL?=
 =?utf-8?B?c0JaQVJqaTV1bDkzK21GeWhFSTcvcjlWNVNZdEFDNWhDVWU4Z01MbVE3Sm5Y?=
 =?utf-8?B?VzhtMDBVeVRlZ1NGWngxSk9SeFd1U204aE9LSFRLNUVMTDkzd3BGbTNLcTEw?=
 =?utf-8?B?MERQK2Vlbndva0JNT1pvbVZZbzd6RWNmOWJnQ2pkN0ZTVmVteGplUHVwYmxj?=
 =?utf-8?B?ejF4L1hxb2x6dThjeE1GUHlrOGdoRmxtK0VWR0dPNXAvK3NYZWV4RVdUdlZ5?=
 =?utf-8?B?Y1RtcUhuRm94MmgreXppYUFmN3hhWmtlRC81c3kzVXQzQURNMkQ1VUdzKzZ3?=
 =?utf-8?B?by93djVlVXdSUjVsa0xKRXpLc0Z0M0szaGtHakZvMmNHZXc3UlZkRzlMRWVl?=
 =?utf-8?B?M0o0SFhhTElVZGRINTR1OTVSSE1tUWJ4TWVROEJNRlBBZitZcWVDRjlqdnJn?=
 =?utf-8?B?RE1xY1dLcUI1L2NMZEc5clhIS2JxWEIyV216ZkhOZ2swc3lGZ1VqSm94ano3?=
 =?utf-8?B?dUdxa2NnSms4ZitUODJKTmM2a2xOQnZVRFFXbVRQckM2THZCRXZWMzJSSEp3?=
 =?utf-8?B?OFZoUW1zcGlsTStVcUVNd3hUTGNwZVZqVXRpaXhBWkZyb3QxRlhhWEFxdEpz?=
 =?utf-8?B?WWFpLytuMWhKTEdjUjd5aXEvelFld25ldlRaMlZKaUZ1eTF1QUw4VWdQVERk?=
 =?utf-8?B?OGJ2QUgxR0ZlZ3JCN0twbXRWcGZnMndsL2loc3loeTcwTWh2cTJ5KzUxdi9j?=
 =?utf-8?B?MWh3bkoxd09VMUFYeE5IaFcvemJBNHp5TFZIOE1OMHhpZXY0ekc3cXFUYzdy?=
 =?utf-8?B?U0VmK3J1UG40cU50TGIxUVh1Slh5Q1k3T3dzQzc3Q3V3NWxZa04zNUcrd2xZ?=
 =?utf-8?B?anlHSmRGalZEOFBGZS96eUFMVllmWnNsT0VkNW52eHkwTnB0Z3FKSnBMZy9v?=
 =?utf-8?B?RHE2WVBPdmpwT1lOR1RkcitRbSsvK1pPcCt1OXQxMGtoaHlMOTM2dG9BZzc5?=
 =?utf-8?B?djlpMlE5YnNkMkVaL0V0ekFpRUxmRTV4bXlDd2NoSVNXSnRILzJ5RUxkUkR3?=
 =?utf-8?B?Q09jays2K3pTdHI0TU9RK29WN3B3TjExcFhzOUc3dnpUM2pMYm12d0cxQ0FU?=
 =?utf-8?B?VlhINHBaN2JTUU41NHZkQmtCQjBEQS9Ibks3Tkd2eW55bDl3cjBTV2FxWUVl?=
 =?utf-8?B?V09ieGFpVndqQS83eS9QdkpTQml0SnlGbVhHc0RLL3NLTkhrVnpXN3U5RGRW?=
 =?utf-8?B?bGFSd29RMlgrUFd1L3ZYQnpqajBucU5BaXBOK2VVdjRaNm9ka0dwbG10bGNU?=
 =?utf-8?B?OUdsemM0MlNwU3NUd3p5Y0VJTThxT1JiRlFTYUdLWmgxVmsycGpzOFM0UFZp?=
 =?utf-8?B?NTQyK2tKSm94bXVPRFhxWTR1TXNuWVZNN2Y3M2VERjJXR1d3WGExWEFEZmhv?=
 =?utf-8?B?bERPWGJjRGxFZmE5R3ZoMjNEUGdZZ0JVRzRmYUV5QVJleVhieVF1T21qaVBH?=
 =?utf-8?B?R0FWVDNzWVdlZDk5bVpEejd1SEQrWk1FZXVpTDl6RjVoYU1JRlY3MEFsSkZm?=
 =?utf-8?B?K0FHZHhicU5MS2xZNjJ2dXZFa0xPVU1aSENibDRkZ0haa3k1bzU0UnJNOUJP?=
 =?utf-8?B?Z1NUa202cjFBZEVwY1FpVDRjZzNVc0Vsc29DK2o4bmRmNHVXaFBkYmVudEd6?=
 =?utf-8?B?OEhtdDBDQU9Mb2wzSENiRUt0MHdnOHhpRXJzN0pRMjZDN2dLa2w2YXMrODh0?=
 =?utf-8?B?MERza0t3VjlBZmhDanpUbkl6c0tmMm5KTW1LTTFMUDdXQ2hGTmxFdzRFNnBH?=
 =?utf-8?B?UmhrUC9zeEtDd1lLRE9lTER1cFQzRWpjcEFaYTFZdmhHZVhwQlhNV0JBVitX?=
 =?utf-8?B?K1FtZnZhOGxHcHdwQzA2WkhLbms2VG5CSmJINk0xQkNqbCtLK0lkSC9tVGc1?=
 =?utf-8?Q?Beqo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9173.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a39ae7-bf85-41fd-5e13-08dd5bd28561
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 10:43:09.4817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tmT57Ofb4KAU9ejnJ78em8yvoh1lozc5RHGh+xZIDpkBYqpLRk4rY20xniErv9vlQAHKqncMccKGzThkzhx0pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6980
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBNYXJjaGFuZCA8ZGF2
aWQubWFyY2hhbmRAcmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCA1LCAyMDI1
IDExOjQzIEFNDQo+IFRvOiBkZXZAZHBkay5vcmcNCj4gQ2M6IE1heGltZSBDb3F1ZWxpbiA8bWF4
aW1lLmNvcXVlbGluQHJlZGhhdC5jb20+OyBDaGVuYm8gWGlhDQo+IDxjaGVuYm94QG52aWRpYS5j
b20+OyBBa2hpbCBHb3lhbCA8Z2FraGlsQG1hcnZlbGwuY29tPjsgR293cmlzaGFua2FyDQo+IE11
dGh1a3Jpc2huYW4gPGdtdXRodWtyaXNobkBtYXJ2ZWxsLmNvbT4NCj4gU3ViamVjdDogW1BBVENI
XSB2aG9zdC9jcnlwdG86IGZpeCBidWlsZCB3aXRoIGFzc2VydHMNCj4gDQo+IC4uL2xpYi92aG9z
dC92aG9zdF9jcnlwdG8uYzogSW4gZnVuY3Rpb24g4oCYdmlydGlvX2NyeXB0b19hc3ltX3JzYV9k
ZXJfdG9feGZvcm3igJk6DQo+IC4uL2xpYi92aG9zdC92aG9zdF9jcnlwdG8uYzo1Mzg6NDI6IHdh
cm5pbmc6IGNvbXBhcmlzb24gb2YgaW50ZWdlciBleHByZXNzaW9ucw0KPiAJb2YgZGlmZmVyZW50
IHNpZ25lZG5lc3M6IOKAmGxvbmcgaW504oCZIGFuZCDigJhzaXplX3TigJkge2FrYSDigJhsb25n
IHVuc2lnbmVkIGludOKAmX0NCj4gCVstV3NpZ24tY29tcGFyZV0NCj4gICA1MzggfCAgICAgICAg
IFJURV9BU1NFUlQoKHRsdiArIGxlbiAtICZkZXJbMF0pID09IGRlcl9sZW4pOw0KPiAgICAgICB8
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn4NCj4gLi4vbGliL2Vh
bC9pbmNsdWRlL3J0ZV9icmFuY2hfcHJlZGljdGlvbi5oOjQzOjQ1OiBub3RlOiBpbiBkZWZpbml0
aW9uIG9mIG1hY3JvDQo+IAnigJh1bmxpa2VseeKAmQ0KPiAgICA0MyB8ICNkZWZpbmUgdW5saWtl
bHkoeCkgICAgIF9fYnVpbHRpbl9leHBlY3QoISEoeCksIDApDQo+ICAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+IC4uL2xpYi9lYWwvaW5jbHVk
ZS9ydGVfZGVidWcuaDo0NzoyNTogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmFJURV9W
RVJJRlnigJkNCj4gICAgNDcgfCAjZGVmaW5lIFJURV9BU1NFUlQoZXhwKSBSVEVfVkVSSUZZKGV4
cCkNCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+DQo+IC4uL2xp
Yi92aG9zdC92aG9zdF9jcnlwdG8uYzo1Mzg6OTogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3Jv
IOKAmFJURV9BU1NFUlTigJkNCj4gICA1MzggfCAgICAgICAgIFJURV9BU1NFUlQoKHRsdiArIGxl
biAtICZkZXJbMF0pID09IGRlcl9sZW4pOw0KPiAgICAgICB8ICAgICAgICAgXn5+fn5+fn5+fg0K
PiANCj4gRml4ZXM6IGQxYjQ4NGJmMTg3NiAoInZob3N0L2NyeXB0bzogc3VwcG9ydCBhc3ltbWV0
cmljIFJTQSIpDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBNYXJjaGFuZCA8ZGF2aWQubWFy
Y2hhbmRAcmVkaGF0LmNvbT4NCj4gLS0tDQoNClRlc3RlZC1ieTogQWxpIEFsbnViYW5pIDxhbGlh
bG51QG52aWRpYS5jb20+DQoNClRoYW5rcyENCg0KLSBBbGkNCg==
