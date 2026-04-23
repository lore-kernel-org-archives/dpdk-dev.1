Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1084FDEE27
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 17:06:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10124402B2;
	Thu, 23 Apr 2026 19:06:13 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
 by mails.dpdk.org (Postfix) with ESMTP id E6C45402B0
 for <dev@dpdk.org>; Thu, 23 Apr 2026 19:06:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EyKH2KXpKw461ZAG8EmaXecogNvdasVbNc7rGacyeMvaVW74CtLNoPKOE8GGhoFQUKsG3S5JQ2M9vb+zhboHYEDEarTdcE0rYaQz0gov59Fg8NDViEBU0zfNkvO5zPaDt7kNKAQLx30bpWe8nZQWQEjuwc0a5B/Yiw2mhHMj64h0P3e2Xha5XccdA/ElXcXJPBS+LIsWj8fLur4khXPYTPEO+9ALEs4WwQLoeiiinhVlvUaiJ3Flt+U6ammHyl/ii3S8eaKWNpm1socwS1nOYeAj4+cnkhLIqyW82DB+ZUy0TtIFJrOWQmX3xqQREkdAVXzJ+SyuUu8lok0BgA6UAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHPhCQJNTYfzK4MzBNKfTgpWh1F1ARho6tqjbuAaHZw=;
 b=MqCiBK0pTnIhjVG9fp7Y/4t5Sz+CYXIFX/aN+yLazE9stM2PM4xV3bReIo8loW2nqdSA32CVi86N2/YZZwdUGJ3/ps/JrVyhC7sTe7Ja4VZIukL5dlnYEvIZNl5aBmK9Jajz9CoOQfrDrIyWjy2Usq+I041uepx1yDI86WZdP8Mcd6xzHEjn7YYI5KAgkPrIxdzNXcFd+JliU/YTZEQmSogbVm/EMIeHV+PA3f5LQSIAlMKwjps6+cOrAQaKLORXQLc3qpg4iTs5NzcTklZ4RXsdtsH7YCghDSBqNcA+HZsmNK5/5FaOARCoMW6s4rx7qh6j4zxFLp8KPlLp4VOSIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHPhCQJNTYfzK4MzBNKfTgpWh1F1ARho6tqjbuAaHZw=;
 b=pVbTnpiJc2nIr8YMfZSL2tioTXQkezuF2UA2GPq82DxatXQbs0xIloZAtSfAWmzGwWAAx+iCsvt45d/UefB+4tCgdvIidspUNrRBEVSO+4UTwWaH1npzCIgFuORl5iVWgB2DZLzkY3ozSf20JEzy9bXTWASCe9rvvdJdeE4JkZGGA6peA6JKo/JGFiFOXjul+VEL/O1uNJYiEPV1+TyswTsvGYUkfeu8BatpPqqoBzi9JJGj1Q0MsvsYG4EjD1BF3w8ljTkJaCZJ+uoJPV1fHRx5VgxBzuHKc9hqDoefe64TOlWDd6bvUPix51vTn39kWk5fzB95dCIYKYE53YQS4A==
Received: from SN7PR12MB6960.namprd12.prod.outlook.com (2603:10b6:806:260::18)
 by EAYPR12MB999131.namprd12.prod.outlook.com (2603:10b6:303:2be::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Thu, 23 Apr
 2026 17:06:09 +0000
Received: from SN7PR12MB6960.namprd12.prod.outlook.com
 ([fe80::faca:1bd8:d3be:a464]) by SN7PR12MB6960.namprd12.prod.outlook.com
 ([fe80::faca:1bd8:d3be:a464%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 17:06:09 +0000
From: Cliff Burdick <cburdick@nvidia.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
Subject: RE: [PATCH v4 1/2] eal: support dmabuf
Thread-Topic: [PATCH v4 1/2] eal: support dmabuf
Thread-Index: AQHcle5ljmlbJM5vaEi9DF71TnQg6LV/Iz6AgG40N0A=
Date: Thu, 23 Apr 2026 17:06:09 +0000
Message-ID: <SN7PR12MB69604B778A001E389DB929B4AB2A2@SN7PR12MB6960.namprd12.prod.outlook.com>
References: <20260203230338.1066297-1-cburdick@nvidia.com>
 <20260204155206.2345189-1-cburdick@nvidia.com>
 <20260204155206.2345189-2-cburdick@nvidia.com>
 <39632c4b-10c3-4bdc-b4ea-9010391b4ada@intel.com>
In-Reply-To: <39632c4b-10c3-4bdc-b4ea-9010391b4ada@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6960:EE_|EAYPR12MB999131:EE_
x-ms-office365-filtering-correlation-id: d43db375-4dd4-4fe6-5b44-08dea15a9d5b
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: BUetiiNGwH+Tx5gnt7zxO6rm8oIukl8TbiUT7m6tKe+xFlhFlw/RWcluzUHD5nMel1gp2633oQqQmqZKh8dTVmhMRPRaQ6CuWPvtghlZdGCBpEaT/7qa7SIKsWHGQrDBYUHRN+PGukRDSm0fQAgUSQokD9D1OTUk8oA34vTJZblf0bbm2s0SqZOKLj95PGPy+jhamAlBQUOigyvpIP1xak/WwvL4U37A0FHYsVQ1lXjVvfHVVUrmrfy/DwORSQi4B0YWB2D63V8UuvkmMyAZ/0EOBWb9Rz1gunl8MMRKP28wyj9zCXoM/RsAp5wsbvPWXas1a5Lw/QfmI5Nimzm9JRH3uhlRqFjaAL2zJUWQ9FIg9ALwtjwozL9vaZd/4PLeqTZyzaWEvqo87mjeYvVulMG7q5mdB1/RdUgXZlSDG2qTBp+xREKcqGqKbH5MI21gDz4/ZPa60KW3Ss65Uo3yZfwWMVe9mT0N9T/fpu+na3+kGi+raU2qo5mMkv/w/WUhcwgZ1ocGT6gyK3JfwH2E1zTpu7vc4dIDpbMI3YrkYyIvL23O46zr6GZe0OxRx/prmn4ZroaT9KKtnRrZ2n/6BzSYZqrSRyqkoIsY7Hv42/qGya8bdtzLjtmzyFnlc6/hGkvLu94dJeMaX/xotcJ6l3WG9SmZsbzrhETqEE9Bm1wNA5PEhPDzzw7xMujJKBVXGB8QA0E+CwVo/g4j1ZVKiGH8FGBV29wo9GJycrE/UfJAI3c62R9PIvP43Ez1WCa3fyP1YcynmZbzans2wUKhhS4kJfCxflX/ydtS5OiUmTo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6960.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlY4YkxwNU04VEFnQnlqbzBZNkNnY01tNDI4Q0RyZElISENhNHJRdzBrdFlZ?=
 =?utf-8?B?WDQwL0t1cFc2R2RmMllRZ2dQN1FaalVSQU5yK2x6TE1yYzQvRGhjVXlFcG1P?=
 =?utf-8?B?SVJjbVcwbTlvekFqU1d1WjYzWkVCZTZEcGVjVGdycVUzOUlsaHQwR1dlMUtD?=
 =?utf-8?B?a3RvdjF2M2ZPdmhyRjc2STlzbG93Q0doWXNhNVZMb01vYUk2UXFLUW0yWlBy?=
 =?utf-8?B?Z3RUdDl3Vm1kZFRockMzVEY2TDhSLzR1RnUvLzlpQVVsdU5MdytHTjBFdklj?=
 =?utf-8?B?Mm5oUnIwRjV2SWEyd2ZIWDFDeDFSTVAxMklEQ0lZVThyeitLWHNZdDF3M3cr?=
 =?utf-8?B?SXdDZnJ5UmpGbHRoWmphSGxBYzBKaFlmd1JjL2U2cmFldk14R3g1OXpudFVy?=
 =?utf-8?B?eWl3YS96bXV3eW1iVmIrR0VHaUlXSGt0MTBLY2wwR1UzV0RKclZpVlB0Nlcz?=
 =?utf-8?B?MVZhczRaaHNVc2ZSSTdiS01WZ01DbTdzSXBJTmlGR1BQcWpmOUJpaG8xTFZC?=
 =?utf-8?B?U0VqbVplaFNTZjRqcDZJc3dlcDVlYjlHNUQ4WGp5YVNiN1BkRmc0QkZwbHYx?=
 =?utf-8?B?V3dCZFNTcjdQQkZ5ajlPRnlsNGgzRXJWSmpQdUxIcisyRmxaOGE3TWxUR3Bu?=
 =?utf-8?B?S2FHa3lOVGJpTTc3UzRpR3lYQTNNM2xTK0Z2dmNHdmdyS2M3czBjYngrT0Y0?=
 =?utf-8?B?WEpicVhVWDVGbjRPN2E4VDE4ZGM3Z2xxU1lmejFHUzNvaldwbGloR0ZVU0xs?=
 =?utf-8?B?WE9qOVhuT29FazJuS2VwY2xNNHRWRVp1L0Iydk1Mc3V0WFZFd09kUDE2VGJZ?=
 =?utf-8?B?ZktHais5RytkU0JYZjZGU1hMRk9FMk9jYWhUazUxZnVsVHhBTXBSbzZWaGJX?=
 =?utf-8?B?WjYrN29VaFdxSU5RVVpqcXhaY09PUmdyblhYeElmTU5Jd25sdU5neE4yYUJZ?=
 =?utf-8?B?elRTSk9TeFpEM2I0RVRyK1FQbnR0VnJFZld4MCtRb2RHS3k0TnNIR3FiWlVv?=
 =?utf-8?B?WjBaZS8xSUJoZFdjcFBTWEhydDZmVjVIT0l0Q3NSdHFYdkpad3NmRXpudzBE?=
 =?utf-8?B?OTVDT0VmL3RBZzZXbzlVU0tUeHNnc3pJTWRtdnV3aEN3K1F3YVpjc0taaGc2?=
 =?utf-8?B?SWV4clVCeGlNbStqaUE2dXNLNHIxdS9kMWZYdXFsNlBXdjQxYVNHSVpieDhY?=
 =?utf-8?B?RWVScXo2TW52R3hBcG5FSTVabFNBV25EaC91YXRiWDZvN3JBZmxzdncwbHlo?=
 =?utf-8?B?d1dZc2JEZmdkM2NEaGEvYmZ3NGVmOERjbXVMTzhwU1drTXFFajFrRGhJYVNK?=
 =?utf-8?B?SmtodlZudXhORVhvWE1EcVZyTFByekpUWENuQWUzWTV1MitPVUdZOTNRVjFP?=
 =?utf-8?B?Q0RVR1BDRHBmQTZpcnVPUGE5Mm5xZGxFREwvcEVIU2czbGJ0aEhrTkJkZHo2?=
 =?utf-8?B?UFFEcWVkYWZiL1psNStzTWlLVWYxQnVQVFJub0NpcFlNODNyZE0wbFhnT1hs?=
 =?utf-8?B?anRHRVRIT2tpWDNnQVZWVTVQMWFLNDJPY045WVF1N21SLzZLUWJ3YWFWK0J3?=
 =?utf-8?B?YW9NZGlLd3B3OHF5OExxVm5VS1g0OGJWRENiVUZmaFRYaWFsZEZBKzNEY0xq?=
 =?utf-8?B?eGhydzg4VWZBaVZjeHZ6VEdMazlUQkVZVkpYeWV3dGYyckVGVGtKM0FDSE04?=
 =?utf-8?B?TlVtTUpPYWpldjRoOWtTdElzN0w2N2ZxSUVxcWwrM1Ftd3VFMkFTbUxGMmY1?=
 =?utf-8?B?VmRzL3B6TjBrMnFjazFlNzNPdEpicWF6SXEwdjRZTVBEMEJOMS9laXhjNmZi?=
 =?utf-8?B?ay9SdWJidWNDa1FZRU5tMFN6d0c5bm9CRG5oMlVnSC9hWXN3QVR6UkFXS1ZW?=
 =?utf-8?B?NU43cWdoeGtBaU1vUHN3QWhWOUV6VHJLRHJQZDB2cXNDUEgxanhraXFnNkpL?=
 =?utf-8?B?VDl0RVhaemJCaEU2d1dPb1VYWmE1dUNvUDNOOGxJemFneHl6d1lRK1Q2RDVI?=
 =?utf-8?B?ZXhqY0VhQmFiOWNnQlhKS0ZKTFBmUFNycU53dGx6cW1tRXdDamdwOExBOHQz?=
 =?utf-8?B?VnpxTVhZcFJNSE84ZWFXTFFQSmRCL3gyU2NWNDJqT2hrcVZQdDRFcWVmMVZB?=
 =?utf-8?B?K2hmaUs4ZlJzNnZyWU1VMXZ3Tmx6MDdLV3o0YklRdmJOUy9VSEFkWVlDT2dn?=
 =?utf-8?B?dUUvUUl2cStVc2w5UyswU3JwdTh0ckl5VE1Jb3h1UWxkd3YxLzhVaG9YZzVL?=
 =?utf-8?B?K0tXQVNkNzV3Tm9uTzdHdTRpTVgra1BnbWl3b1Y3TlZRRTZtYVNWQUNBd1V5?=
 =?utf-8?B?dGt5cXFYT1plUVRGWWZwblEvMUF3MU9id2pqU2dGMzZ6YVNiZXJBZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6960.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43db375-4dd4-4fe6-5b44-08dea15a9d5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 17:06:09.1965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ly00ip0WctjI+HMdlhQi3T62p6dshfCS/rGsodOtkAdIe2L+wCh8H6UzOFerWmFWpB38b1Ka3dxk7SXq+p5xsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999131
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

PiAgWy0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ICBGcm9tOiBCdXJha292LCBBbmF0b2x5
IDxhbmF0b2x5LmJ1cmFrb3ZAaW50ZWwuY29tPg0KPiAgU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5
IDEyLCAyMDI2IDU6NTggQU0NCj4gIFRvOiBDbGlmZiBCdXJkaWNrIDxjYnVyZGlja0BudmlkaWEu
Y29tPjsgZGV2QGRwZGsub3JnDQo+ICBDYzogTkJVLUNvbnRhY3QtVGhvbWFzIE1vbmphbG9uIChF
WFRFUk5BTCkgPHRob21hc0Btb25qYWxvbi5uZXQ+DQo+ICBTdWJqZWN0OiBSZTogW1BBVENIIHY0
IDEvMl0gZWFsOiBzdXBwb3J0IGRtYWJ1Zl0oKQ0KPiAgIA0KPiAgRXh0ZXJuYWwgZW1haWw6IFVz
ZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gICANCj4gICANCj4gIE9u
IDIvNC8yMDI2IDQ6NTAgUE0sIENsaWZmIEJ1cmRpY2sgd3JvdGU6DQo+ICA+IGRtYWJ1ZiBpcyBh
IG1vZGVybiBMaW51eCBrZXJuZWwgZmVhdHVyZSB0byBhbGxvdyBETUEgdHJhbnNmZXJzIGJldHdl
ZW4NCj4gID4gdHdvIGRyaXZlcnMuIENvbW1vbiBleGFtcGxlcyBvZiB1c2FnZSBhcmUgc3RyZWFt
aW5nIHZpZGVvIGRldmljZXMgYW5kDQo+ICA+IE5JQyB0byBHUFUgdHJhbnNmZXJzLiBQcmlvciB0
byBkbWFidWYgdXNlcnMgaGFkIHRvIGxvYWQgcHJvcHJpZXRhcnkNCj4gID4gZHJpdmVycyB0byBl
eHBvc2UgdGhlIERNQSBtYXBwaW5ncy4gV2l0aCBkbWFidWYgdGhlIHByb3ByaWV0YXJ5DQo+ICA+
IGRyaXZlcnMgYXJlIG5vIGxvbmdlciByZXF1aXJlZC4NCj4gID4gDQo+ICA+IEEgbmV3IGFwaSBm
dW5jdGlvbiBydGVfZXh0bWVtX3JlZ2lzdGVyX2RtYWJ1ZiBpcyBpbnRyb2R1Y2VkIHRvIGNyZWF0
ZQ0KPiAgPiB0aGUgbWFwcGluZyBmcm9tIGEgZG1hYnVmIGZpbGUgZGVzY3JpcHRvci4gZG1hYnVm
IHVzZXMgYSBmaWxlDQo+ICA+IGRlc2NyaXB0b3IgYW5kIGFuIG9mZnNldCB0aGF0IGhhcyBiZWVu
IHByZS1vcGVuZWQgd2l0aCB0aGUga2VybmVsLiBUaGUNCj4gID4ga2VybmVsIHVzZXMgdGhlIGZp
bGUgZGVzY3JpcHRvciB0byBtYXAgdG8gYSBWQSBwb2ludGVyLiBUbyBhdm9pZCBBQkkNCj4gID4g
Y2hhbmdlcywgYSBzdGF0aWMgc3RydWN0IGlzIHVzZWQgaW5zaWRlIG9mIGVhbF9jb21tb25fbWVt
b3J5LmMsIGFuZA0KPiAgPiBsb29rdXBzIGFyZSBkb25lIG9uIHRoaXMgc3RydWN0IHJhdGhlciB0
aGFuIGZyb20gdGhlIHJ0ZV9tZW1zZWdfbGlzdC4NCj4gID4gDQo+ICA+IElkZWFsbHkgd2Ugd291
bGQgbGlrZSB0byBhZGQgYm90aCB0aGUgZG1hYnVmIGZpbGUgZGVzY3JpcHRvciBhbmQNCj4gID4g
b2Zmc2V0IHRvIHJ0ZV9tZW1zZWdfbGlzdCwgYnV0IGl0J3Mgbm90IGNsZWFyIGlmIHdlIGNhbiBy
ZXVzZSBleGlzdGluZw0KPiAgPiBmaWVsZHMgd2hlbiB1c2luZyB0aGUgZG1hYnVmIEFQSS4NCj4g
ID4gDQo+ICA+IFdlIGNvdWxkIHJlbmFtZSB0aGUgZXh0ZXJuYWwgZmxhZyB0byBhIG1vcmUgZ2Vu
ZXJpYyAicHJvcGVydGllcyIgZmxhZw0KPiAgPiB3aGVyZSAiZXh0ZXJuYWwiIGlzIHRoZSBsb3dl
c3QgYml0LCB0aGVuIHdlIGNhbiB1c2UgdGhlIHNlY29uZCBiaXQgdG8NCj4gID4gaW5kaWNhdGUg
dGhlIHByZXNlbmNlIG9mIGRtYWJ1Zi4gSW4gdGhlIHByZXNlbmNlIG9mIHRoZSBmbGFnIGZvcg0K
PiAgPiBkbWFidWYgd2UgY291bGQgcmV1c2UgdGhlIGJhc2VfdmEgYWRkcmVzcyBmaWVsZCBmb3Ig
dGhlIGRtYWJ1ZiBvZmZzZXQsDQo+ICA+IGFuZCB0aGUgc29ja2V0X2lkIGZvciB0aGUgZmlsZSBk
ZXNjcmlwdG9yLg0KPiAgPiANCj4gID4gU2lnbmVkLW9mZi1ieTogQ2xpZmYgQnVyZGljayA8W2Ni
dXJkaWNrQG52aWRpYS5jb21dKG1haWx0bzpjYnVyZGlja0BudmlkaWEuY29tKT4NCj4gID4gLS0t
DQo+ICAgDQo+ICBIaSwNCj4gICANCj4gIEEgZmV3IHJhbmRvbSB0aG91Z2h0cyBhYm91dCB0aGUg
cGF0Y2hzZXQuDQo+ICAgDQo+ICBGb3Igb25lLCB0aGlzIEFQSSBpcyBvYnZpb3VzbHkgTGludXgt
b25seS4gVGhpcyBpbiBpdHNlbGYgaXMgbm90IGEgcHJvYmxlbSAod2UgZG8gaGF2ZSBWRklPIEFQ
SS4uLikgYnV0IEkgd291bGQgcmVhbGx5IGxpa2UgdG8gYXZvaWQgdGhhdCBpZiBwb3NzaWJsZS4N
Cj4gICANCj4gIEZvciBhbm90aGVyLCBJIGRvbid0IHNlZSBhbnkgc3VwcG9ydCBmb3Igc2Vjb25k
YXJ5IHByb2Nlc3NlcyAtIHRoZSBkbWFidWYgYXJyYXkgaXMgcHJvY2Vzcy1sb2NhbCwgYW5kIGNh
bGxpbmcgcmVnaXN0ZXIoKSBmcm9tIHNlY29uZGFyeSBwcm9jZXNzIHdvdWxkIHByZXN1bWFibHkg
ZWl0aGVyIGZhaWwgb3IgY3JlYXRlIGEgZHVwbGljYXRlIHNlZ21lbnQsIGRlcGVuZGluZyBvbiBl
eGFjdGx5IHdoYXQgeW91IHBhc3MgaW50byB0aGUgcmVnaXN0ZXIgY2FsbC4gSWYgdGhpcyBzY2Vu
YXJpbyBpc24ndCBzdXBwb3J0ZWQsIGl0IHNob3VsZCBhdCBsZWFzdCBiZSBleHBsaWNpdGx5IGRp
c2FsbG93ZWQgYW5kIGRvY3VtZW50ZWQgdG8gYmUgc3VjaC4NCj4gICANCj4gIE15IGJpZ2dlc3Qg
Y29uY2VybiBpcyB0aGF0IHRoaXMgaXMgY3JlYXRpbmcgYW5vdGhlciB0eXBlIG9mIGV4dGVybmFs
IG1lbW9yeSBzZWdtZW50IGFuZCB0aHVzIHNlZ3JlZ2F0aW5nIHRoZSBBUEksIGJ1dCBpc24ndCBk
b2luZyBpdCBpbiBhIHdheSB0aGF0IGlzIGdlbmVyaWMuIEkgY2FuIHNlZSBhIHZhbGlkIHVzZWNh
c2UgZm9yIHRoaXMsIGJ1dCB3aGF0IHdlJ3JlIGVzc2VudGlhbGx5IGRvaW5nIGhlcmUgaXMgc3Rv
cmluZyBzb21lIG1ldGFkYXRhIHRvZ2V0aGVyIHdpdGggdGhlIHNlZ21lbnQuIFNvLCBwZXJoYXBz
LCB0aGlzIGlzIHdoYXQgd2Ugc2hvdWxkIGRvPyBUaGF0IHdvdWxkIHNlZW0gbGlrZSBhIGNsZWFu
ZXN0IHNvbHV0aW9uIGZvciBtZSwgYW5kIGl0IHdvdWxkIGV4dGVuZCB1c2VmdWxuZXNzIG9mIHRo
ZSBBUEkgdG8gb3RoZXIgdXNlIGNhc2VzIHdoZXJlIHRoZXJlIG1heSBiZSBhIHJlcXVpcmVtZW50
IHRvIHN0b3JlIHNvbWUgbWV0YWRhdGEvZmQvd2hhdGV2ZXIgd2l0aCB0aGUgc2VnbWVudC4NCj4g
ICANCj4gIFlvdSBjb3VsZCB0aGVuIGJ1aWxkIGFub3RoZXIgQVBJIG9uIHRvcCBvZiB0aGlzIChh
IGxpYnJhcnk/KSB0aGF0IHdvdWxkIGhhbmRsZSB0aGluZ3MgbGlrZSBzZWNvbmRhcnkgcHJvY2Vz
cyBzeW5jaHJvbml6YXRpb24gd2l0aCBJUEMsIHNvIHRoYXQgeW91IGhhdmUgYWxsIGZkJ3MgdmFs
aWQgaW4gYWxsIHByb2Nlc3Nlcy4NCj4gICANCj4gIFRob3VnaHRzPw0KPiAgLS0NCj4gIFRoYW5r
cywNCj4gIEFuYXRvbHkNCg0KSGkgQW5hdG9seSwgc29ycnkgZm9yIHRoZSBkZWxheS4gSXQgaXMg
dHJ1ZSB0aGF0IGl0J3MgTGludXgtb25seS4gSSBkaWQgbm90IHNlZSBlaXRoZXIgQlNEIG9yIFdp
bmRvd3MgaGF2aW5nIGFuIGVxdWl2YWxlbnQgdG8gZG1hYnVmLCBidXQgSSdtIG5vdCB2ZXJ5IGZh
bWlsaWFyIHdpdGggdGhlbS4gDQoNCkFkZGluZyBzdXBwb3J0IGZvciBzZWNvbmRhcnkgcHJvY2Vz
c2VzIGlzIHNvbWV0aGluZyBJJ2QgcmF0aGVyIGRlbGF5IGZvciBhIGxhdGVyIHJlbGVhc2UgaWYg
cG9zc2libGUgc2luY2UgaXQgY291bGQgYmUgYSBsb3QgbW9yZSB3b3JrLiBJIGNhbiBhZGQgYSBn
dWFyZCB0aGF0IHNheXMgaXQncyBub3Qgc3VwcG9ydGVkIGlmIGEgc2Vjb25kYXJ5IHByb2Nlc3Mg
Y2FsbHMgdGhlIHJlZ2lzdGVyIGZ1bmN0aW9uLg0KDQpGb3IgYSBtb3JlIGdlbmVyaWMgQVBJIGFy
ZSB5b3Ugc3VnZ2VzdGluZyBzb21ldGhpbmcgbGlrZSBydGVfZXh0bWVtX3JlZ2lzdGVyX2V4KCkg
dGhhdCB3b3VsZCB0YWtlIGFuIGVudW0gdHlwZSBhbG9uZyB3aXRoIHNvbWUgb3BhcXVlIG1ldGFk
YXRhLCBvZiB3aGljaCBETUFCVUYgaXMgb25lIHR5cGU/DQo=
