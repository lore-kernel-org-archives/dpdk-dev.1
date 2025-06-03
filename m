Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223E9C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 05:45:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1E8C4028E;
	Tue,  3 Jun 2025 07:45:04 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 67AD04025A
 for <dev@dpdk.org>; Tue,  3 Jun 2025 07:45:03 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5535U3ON017157;
 Mon, 2 Jun 2025 22:45:02 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2127.outbound.protection.outlook.com [40.107.95.127])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 471txwr0rh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Jun 2025 22:45:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXkRCzGgPas1Zx42P6hSPBIWVVwaKeIXuB+D7tQf91ws3COwc///S4VGNnuCbc882GKPLYMHwWoJlkSrViB1Uz9UABNFWIo1Gtz/dbNfDGzBj1F07wi9D21d3zOD+Y144X+dFdOvtlA3ALA+SsL8K8STGtSbtNnW09qQJ/hlwJxRj3t6GIR8RGC3yVPp4ga/wj7fp5M85VoWQo+JgHM+xz8JbE5kewNQWP7WAUOsT9ws9dMjyV9K4UB4JlKYIEWyIU6h/7707dyt+WB1dFvqzy7KK3qFxGXMC43DOGj7JEmQH1Eipdm5vRcnow5VZ+LpgPOmhbidnDyZY3GfcvwhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrPGzgESp6qv1Tmu7KukyY305Og/bP1soRzerLExwik=;
 b=OinQFKLOeKF1cJbzoO1iZIhkaJ+9v8T1cfmslYp0fK41D7TNWaooyU/0PyljWqt8pe/3/fwg5RC17uYNpJ2VhlNtPQ2aS9hSCiakhIey0yIoCCjQdHg4z8jRdUwjsCFuCkjEnm7ddOj9dtWz3znXSx3r8C9GNJdAXGd6lBLEfzSUOdNM3oNoQHZu1Xbfi+zIpTQ/V+lyaF8RKW1TdbokUCmq8aiyltK72PmeRSAp58J6bKMMW5n53bZKqlf4kz3ucvgovYqlwvQzK3vFhp9rRlfgUlbQmdYL6dz+pB02sSADYdkGo7BYJwe1uLGFcf/wWxrZkiT/BsGvniPPmnsaTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrPGzgESp6qv1Tmu7KukyY305Og/bP1soRzerLExwik=;
 b=RWr0EwSLdXgT0EPQ7c4vpmsB2fkx0Ag97tUyEpGbHyAuds9lMrz8vQH8r8B+4VS9jeGOJKo0J1iMFJsDAL2UGHXL9AwnEkhwgUsDjCvqX3JTT7hrKpmucc6N4a6nQEKDqvmpbv+/IHGs+gd4fO0HXPq8Js8KzNPAXlvJOOx86W4=
Received: from BY1PR18MB6109.namprd18.prod.outlook.com (2603:10b6:a03:4a6::17)
 by PH0PR18MB4410.namprd18.prod.outlook.com (2603:10b6:510:e1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 05:45:00 +0000
Received: from BY1PR18MB6109.namprd18.prod.outlook.com
 ([fe80::8b06:27d0:59ed:cf27]) by BY1PR18MB6109.namprd18.prod.outlook.com
 ([fe80::8b06:27d0:59ed:cf27%5]) with mapi id 15.20.8769.035; Tue, 3 Jun 2025
 05:44:59 +0000
From: Ankur Dwivedi <adwivedi@marvell.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
CC: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, Pavan Nikhilesh
 Bhagavatula <pbhagavatula@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>, Nitin Saxena
 <nsaxena@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>, Robin Jarry
 <rjarry@redhat.com>, Jerin Jacob <jerinj@marvell.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH v3 00/14] add lookup fib nodes in graph library
Thread-Topic: [PATCH v3 00/14] add lookup fib nodes in graph library
Thread-Index: AQHb04i7Ix4Z4BgzSUqcUDpEDr1rOLPvi1qAgAFdbgA=
Date: Tue, 3 Jun 2025 05:44:59 +0000
Message-ID: <BY1PR18MB6109E8651A0BC593F2246DC8DD6DA@BY1PR18MB6109.namprd18.prod.outlook.com>
References: <20250509064448.724019-1-adwivedi@marvell.com>
 <20250602063639.198550-1-adwivedi@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FCA9@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FCA9@smartserver.smartshare.dk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR18MB6109:EE_|PH0PR18MB4410:EE_
x-ms-office365-filtering-correlation-id: 37bc75f4-8153-455f-cc31-08dda261c747
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZVdjdDd3R2JpSXVxSTJhU3FoL0VkYVIvNThuUTdCS0Z6aStjVjE1V0paZkdk?=
 =?utf-8?B?Y1laWFZyR2pmOG8xTjRuaU9sVlk3V0wwaDZzb1Z4NkEwdHF2TFJOVHlBNmxw?=
 =?utf-8?B?bEUyazdxMkM2YTJTUlR6bGRLZ3FIanRmT0E1dERPbk95Yk9BR0Y1UTlsaXBZ?=
 =?utf-8?B?N2wvNC9wM3AwY0M5cTdVYzRXZnVkUnNZMWhnMzQ2UkJhYmxVdW5LWHlJSldM?=
 =?utf-8?B?ZStlTThlTGRwa3ZTUEQ0S01rbEh3VXVhdXE1SlRZWm0rTC9QUVg2N1F6SzNH?=
 =?utf-8?B?NVpCRXNVV2J6UkNlODlUeUhGZlBaaHRuNEt2YTRkTDdWSzE5WjJXVzlHV2pW?=
 =?utf-8?B?ZkhKN3drZ25kRlhHZjcrUnFoWVJVanNJcHg2c3hXdEVWSkNhSUxtdGRIdk5S?=
 =?utf-8?B?WGJwc2hHVExRTUpPZndzdDVVZks3bThPUXp1Uy9oWGlSK2Zrd0RCZ2pISGlq?=
 =?utf-8?B?K09QV2NCbDJlUTNmemtrTW5SZGNoRHFDN2dCbzZ6cytyU3h2d213azk5U1Ja?=
 =?utf-8?B?bCtERG5XVzRVV2J0WVY1VnBZTzh0ZkE0d2pqV1lhWWtZcU1kVDNTTGd4ZTJj?=
 =?utf-8?B?MmgwaE9zNCtqS0JIK2wzSVN1VHQxczBmNG1mODlIck03a2hBRkZyYUlkSVBF?=
 =?utf-8?B?MTI1ZVZDZ3VrN0tVMWFXbDhITDlLWDNRUnBKWkFIMVlFVThkaUJ4NzErNDJj?=
 =?utf-8?B?d1NqelBqK0xDem1BREJmOFdCZFNlamEyS05BQXU2MmJMSHpVdjE4OHFuaWFS?=
 =?utf-8?B?ZnRBUGFmME8ycWo3K05pcm8vSlRYU2tvd1ROakhtM0FTZHpmeHpKOWt5eWIr?=
 =?utf-8?B?UEExUTVyTHk0K1crSW1PVXcxbEZpUXNMVE5NUWtJTzhNNVpMTjVhbnpVOEU2?=
 =?utf-8?B?aU9LWXprS0tpc3Z0YzBPNm9qSmpkZVNqTllrRnJqQ1d3OHU5UU9wSnlFWXI0?=
 =?utf-8?B?ZURSTkVEZm5haC9SbWI5ZEVHVnoydmQrdG1EUFFPaTlPZERxZ1JGMWhKYVNz?=
 =?utf-8?B?Q2duaXduVXlteCtodTdaaXRENW9NMmd1UXNiMDdSN2dnRTZLTEd3STFYYUEx?=
 =?utf-8?B?bXhxWU45WlVHS0s5K0xSVUxMRmVPT1VvSE0vSFBjeUMzWUNXRkJUKzN4WTVy?=
 =?utf-8?B?S2VjUWVJYURKbW1PNGlJdEJhR09XM0FERXFqTGtqZzVpMXhOby95N0ZCS2xL?=
 =?utf-8?B?TW9NOUNiM0hiVkQ1VlhzL2FqUWZZM0hheTZ6cThGczFlT25wRmZZbkIvMG50?=
 =?utf-8?B?TDhlaTNuMDNFcEgvR1l0dktsS3ZTYXcwRWFrSVc0T1FRRHRtb0NPODQ0UFhN?=
 =?utf-8?B?Y2lsK2c1RC81REUzTWhlUG9GTHRBZjBwSmZRRmN6Qm03YmpzWTFwZDhNWE9h?=
 =?utf-8?B?dFRiNmZVSllOdUhhdTdJK0RoYnJhOTNqV01zcC9vYkI2emFVUXNhSFVDU09D?=
 =?utf-8?B?M05iT1hlZGNvUmhBaWRIR2Zsc3pCOU5aTkdoOUx3Y2tZTDlsL1hLTzUyUXdB?=
 =?utf-8?B?WmlpMmFFMzc0Zko2c1lMWjFQN2NDd3RBNzJsZ1dqQ1JITXVZUGZ4RjRsUWxw?=
 =?utf-8?B?M2k1ZmcxMWRPRmpWZ044OS9sb0FRKzlra0xNTWhTYUZKQkJnYnJxejkvVjZ0?=
 =?utf-8?B?dXZhUyttWU5meXVHR0pocWxhTVZSTEcyTTUyOWZ3Z1pxU0hPMmU4TWRBbkd1?=
 =?utf-8?B?Q0FWblRJT0VKQThJaWttNlBlUERudjFtKzFScWVNN1JvcFRsT1NpNjRwQ2Fm?=
 =?utf-8?B?dTl4MFBudGRvRHNGNkFJSXNsWmpienN5VjkrMHFqdG9LUzl5bjFqK1oxRkJk?=
 =?utf-8?B?L3I2dTdWMUpWa01IRm8wSEI0WVB3K0hqOUtZckpyWXBvZXVrTGk1YjdwckxO?=
 =?utf-8?B?KzlESk16cGoxN0NaWHBjNSszRjE1VWpzMkNtTTdNWllUNVBmcEVoVXdSTVVU?=
 =?utf-8?B?V0x6T0ZQZzM1cFFvSTdzcXhSSHlWdVZsR3BkYVVyQktnbUtvQ3dQZzhidmoz?=
 =?utf-8?Q?xpL+dSLv182JrFt3hBCAmtu/u07dUM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR18MB6109.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mk5UZlE2eUE5TVVzOGdtTE5pK3AvZlFDb0xtSXJrdVR2T2grUS9pdVltQ2hJ?=
 =?utf-8?B?NHA1YnJwSkRuS2VUbHo4M2VXR0NtdFdpWkdHbkV3dUJYUkhVeDRnT2d3THZp?=
 =?utf-8?B?ZFRpUVpoVitENkJ2dnNIWWxSWFFHSEM4ZjZvQWl6Ym1yV1JkNVluTDRYeEg0?=
 =?utf-8?B?UFp5RzZteTVncmpWL01BSXZzam5rbjBaclN4OXcyTnRDSngrSjVtSVdPRHV1?=
 =?utf-8?B?UnJXck5tSGcveFgyeHNNWVVYdzRRMFJoUy9KMnRPNVZTdE9Ia1ZIei9nMnBx?=
 =?utf-8?B?azlPYyt0REJyN1poMENqc01HTDRlNHpQNWdWd01XNXAyZUNSUE9GNEFzeXk1?=
 =?utf-8?B?SjVCejdBeERrc0QxMnJrZy9GS3orTzZLc2k5b0V0YTdNeVJBTmZWZUlIVkFD?=
 =?utf-8?B?RDdCRUVKakY3N0dRVWNFUUp3aG5SaWtpWmZ1Tnlwb0g4THB6M1JSMXNmdUN2?=
 =?utf-8?B?QVNsMXZJWm0zdWk1cmhhNzN5SUJYa3ZDeFBYLzZpYitJczhqZVZJZWRRNElD?=
 =?utf-8?B?V0dWTS9KazZXSGNqOXBRWGR5a0psMXJST05WMXBxSngrcW9QVk82dWNFNHlt?=
 =?utf-8?B?TUdxdnRZeG1FdlMyekxWa0h2RmU3aHlVNHEveDUrTnE2RkNkVlVjN2xUYmVD?=
 =?utf-8?B?UkJqZHZ4ei9GaW1YajhjWm5xZWZEeFhIcWVZdjQxc1V2OVhxSk9ydkpGdUpn?=
 =?utf-8?B?UlBTN3duZUtDM0Iyelo2VDBZdjNuZ1NZaHN2T0w1Q2g3RXlwaWp3OXJOa1pw?=
 =?utf-8?B?Z1Flb2N0TVkrMjMyNmttRElhQUZvN3doVlRTN2JnSHljcVFKN3N5Q29tTXl2?=
 =?utf-8?B?UkcvUCs3OVBWeGFvR2tjcGQ4aVpLcE1jMHZhOUxwSGNyVjlEWU5OaUFQRlBF?=
 =?utf-8?B?Uy8yTDl2dzZhamZZWFNLRzlIcG5MQTJrcnhmbVhmTGM4TER0dnM2Yzk5aDlL?=
 =?utf-8?B?cHBlcTVjNmdZelgzV2ZHMldyMnNpVklHR2tpWmxZdzBEcU1KMmR4TnRpOTd6?=
 =?utf-8?B?UVgxSmYwMGNzci9IQnFxMnVnTnY2ZlRzZGpRd29adFlKUVhnT2NzK1pUYWJm?=
 =?utf-8?B?NmxHcUsyZjhsWVhJKzNPYTJQVkxyOXNGaklKVE5PeGZtZzVJanVRWDRqcWpQ?=
 =?utf-8?B?QnpEYTA0akhXc3BSTFhQVmY0NmpNbE1ZbHUrRE9OdVZDR0hrdDBRWnUxTlJQ?=
 =?utf-8?B?aDRObk11N2pmQVRiYXg4ZWJ6VFA0bFVLeFVId3B6NW4zNzl4L1FBb0lsNjZJ?=
 =?utf-8?B?c0xKc3kxN3pVK1NwUXRhSVZJeEpDWGIvRjNWZ0ZDSGlNbXp3WFFXQkhobEdw?=
 =?utf-8?B?bExsMkNJQnpGb211VG9aRlRTTDA0bk1DZ09vYlFYWWRDVjdaNHJIR2hxMVA3?=
 =?utf-8?B?NHR1d0lpekdNYmk3c1hlSlNzaFVlNGdDKzhJdXVuZFc4VVhkc2tEV2I3S2pr?=
 =?utf-8?B?NUF2ektBM0JrNTdVS0YrR2ptYThTdWlVa0djcmVrWmJFNFd6UXlFOGpiSEo5?=
 =?utf-8?B?VUdEb0xicElTWndjbnVDU3VDU3IyNE41U0E3ckE3WE4yQVJNRmUxbkExMU9U?=
 =?utf-8?B?OWlQTGFkWG1pMlJkanc2ME8zNHFlR0tWeUZDR3RuMUl4ZDJUMzg5QXU0THk2?=
 =?utf-8?B?RjhVSmtoTUlUczAvNGpaOEhQdTJhZ2E1M1FubmNvUzhvdy8rcTRrbXVtdW80?=
 =?utf-8?B?UStDK28zWVd2b1lzT082QkMyMlRxdi9rWVJnWVF3ZVhQUGEvMWZreFVOSEFt?=
 =?utf-8?B?cnJuNW4vOUcxSS9zd05aWTFlZ1Y5a3BuTENJQnBJcWs1a0piaERWL0YwRDM0?=
 =?utf-8?B?N280eEpMSFl6SG9GanZTMVlLaGNZOTF4TGYyeXJWMkFuMU94WmhqVGVqekEw?=
 =?utf-8?B?RTM3Nkt6NktzYlFVclBRSHdSTEFpS1drcVFjUjNTaEV5WXhFMGQvNGRLYWZN?=
 =?utf-8?B?dm8rNnpkK1Y4Q1VQcElzYnFPSTdLSm9qN2o0S0M5VFRlY00vRTNKdjVDU003?=
 =?utf-8?B?bXZ1N1VrUEk3K1hnaWI4b2ZFanNCVkN4MFlnc0QxS0RGM0tZSGU5WC9qejhl?=
 =?utf-8?B?Z1pqN1UyWUtobkN0ZGtIMENYVHNwY1ZoTVh5THVZdVJLY2tmR3hDcG52OFJX?=
 =?utf-8?Q?RtFiShIXEBCoQxIVkU2ccvx9C?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR18MB6109.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bc75f4-8153-455f-cc31-08dda261c747
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 05:44:59.5172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3N17MR7olB6+NvUyFY3qMUPu9eboqcweJb9Uwzbk47OOhkvmUTGxBuYzPJAueTXFaobRZCXw1CmPXz2X2CpGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4410
X-Authority-Analysis: v=2.4 cv=N44pF39B c=1 sm=1 tr=0 ts=683e8bde cx=c_pps
 a=5blPGaBx5mfX2KlEFLyEIg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=qh8KlR-TL0y-nQBWfL0A:9
 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: D0mrWo8ZocikMhV7CbnNRG_qGhW-bG41
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDA0OCBTYWx0ZWRfX7u9GEbZTMawx
 q4a4eM2UHjPQWqjqYib+WEHkfqwsnuWWjCX/dcpKUt5Dvoflyw/41p3LvPxHND+rst63uh57z8O
 bWoBcs8SBAZayEre+hSEq8xcqA2NSBwrV4H6Fc6bwbE8WIHMfTZJg/PW3pLFQIBXypJpONeJWmI
 HQCR0nK8/keDuATZqGcuV2IRhvwgPsr7bxk2LqznSMVlP3l9nYJV/xU63BginR3Svt2R3jMxHPR
 oXSOQB16rHZQohtYw81skI98Jbp2ZA60OjwjyleAivvgflTktePwJD7oPS/m4k9+olc55OiSRf2
 mJey/ZVh6N7Nav+maFCvh0Ud5sIi8IJu2UvK+08FcHtnciBj5F6SzeNSeK8daHi6Kj0o2b3NINm
 Zm6Ey9yk0qV4E6L3Si8HraCvDgrogVwC6+MewdrQaJoh20PZVhLdbrQ+mS3aGxEPmK7ucFZK
X-Proofpoint-ORIG-GUID: D0mrWo8ZocikMhV7CbnNRG_qGhW-bG41
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
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

SGkgTW9ydGVuLA0KDQo+PiBGcm9tOiBBbmt1ciBEd2l2ZWRpIFttYWlsdG86YWR3aXZlZGlAbWFy
dmVsbC5jb21dDQo+PiBTZW50OiBNb25kYXksIDIgSnVuZSAyMDI1IDA4LjM2DQo+Pg0KPj4gVGhp
cyBwYXRjaCBzZXJpZXMgYWRkcyB0d28gaW5idWlsdCBub2RlcyBpcDRfbG9va3VwX2ZpYiBhbmQN
Cj4+IGlwNl9sb29rdXBfZmliIGluIGdyYXBoIGxpYnJhcnkuIFRoZXNlIG5vZGVzIHVzZXMgdGhl
IGV4aXN0aW5nDQo+PiBGb3J3YXJkaW5nIEluZm9ybWF0aW9uIEJhc2UgKEZJQikgbGlicmFyeSB0
byBjcmVhdGUgRklCLCB0byBkbyByb3V0ZQ0KPj4gYWRkaXRpb24gYW5kIHJvdXRlIGxvb2t1cC4N
Cj4+DQo+PiBUd28gbmV3IGNvbW1hbmRzIChmb3IgaXB2NCBhbmQgaXB2NikgZm9yIHByb3ZpZGlu
ZyB0aGUgbG9va3VwIG1vZGUgaXMNCj4+IGFkZGVkIGluIHRoZSBkcGRrLWdyYXBoIGFwcGxpY2F0
aW9uLiBmaWIgb3IgbHBtIGNhbiBiZSBnaXZlbiBhcyBsb29rdXANCj4+IG1vZGUuIElmIHRoZXNl
IG5ldyBsb29rdXAgbW9kZSBjb21tYW5kcyBhcmUgbm90IGdpdmVuLCB0aGUgZHBkay1ncmFwaA0K
Pj4gdXNlcyBscG0gKExvbmdlc3QgUHJlZml4IE1hdGNoKSBvciBscG02IGJ5IGRlZmF1bHQuDQo+
PiBJZiBmaWIgaXMgZ2l2ZW4gYXMgbG9va3VwIG1vZGUgdGhlbiB0aGUgaXA0X2xvb2t1cF9maWIg
b3INCj4+IGlwNl9sb29rdXBfZmliIG5vZGVzIGFyZSB1c2VkIGJ5IHRoZSBhcHBsaWNhdGlvbi4N
Cj4NCj5AQW5rdXIsIEBWbGFkaW1pciwgQEplcmluLA0KPg0KPkEgY291cGxlIG9mIGhpZ2ggbGV2
ZWwgcXVlc3Rpb25zLi4uDQo+DQo+MS4gVGhyZWFkIHNhZmV0eToNCj5JJ20gbm90IGZhbWlsaWFy
IHdpdGggdGhlIHRocmVhZCBzYWZldHkgbW9kZWxzIG9mIHRoZSBGSUIgYW5kIEdyYXBoIGxpYnJh
cmllcy4NCj5JcyB0aGUgRklCIGxpYnJhcnkgdGhyZWFkIHNhZmUsIHNvIG9uZSB0aHJlYWQgY2Fu
IGludm9rZSB0aGUgRklCIG1vZGlmeSBvcGVyYXRpb24NCj53aGlsZSBvdGhlciB0aHJlYWRzIGlu
dm9rZSB0aGUgRklCIGxvb2t1cCBvcGVyYXRpb24/DQoNClRoZSBGSUIgbGlicmFyeSBwcm92aWRl
cyBydGVfZmliX3JjdV9xc2JyX2FkZCBmdW5jdGlvbiwgd2hpY2ggcHJvdmlkZXMgdGhyZWFkIHNh
ZmV0eSBwZXIgRklCIHRhYmxlLg0KVGhlIGN1cnJlbnQgbG9va3VwIF9maWIgbm9kZSBkb2VzIG5v
dCBoYXZlIHJ0ZV9maWJfcmN1X3FzYnJfYWRkKCksIGFzIEkgZGlkIG5vdCBwbGFuIGZvciBpdC4g
QnV0LCBJIGNhbiBhZGQgdGhlIHJjdSBpbiByYzIgKGlmIHRoYXQgaXMgb2spLg0KDQpBbmt1cg0K
PklmIGl0IGlzbid0LCBob3cgZG9lcyB0aGUgR3JhcGggbGlicmFyeSBtYWtlIGl0cyB1c2Ugb2Yg
dGhlIEZJQiBsaWJyYXJ5IHRocmVhZCBzYWZlPw0KPg0KPjIuIFZSRiBzdXBwb3J0Og0KPlRoaXMg
bG9va3MgbGlrZSBhIGdsb2JhbCByb3V0ZSB0YWJsZSBmb3IgdGhlIGVudGlyZSBncmFwaC4NCj5T
aG91bGRuJ3QgdGhlcmUgYmUgYSByb3V0ZSB0YWJsZSBwZXIgRklCIG5vZGU/DQo+T3IgaG93IGFy
ZSBWUkZzIHN1cHBvcnRlZCBieSB0aGUgR3JhcGggbGlicmFyeT8NCj5PciBpcyB0aGVyZSBubyBy
ZXF1aXJlbWVudCB0byBzdXBwb3J0IFZSRnMgaW4gdGhlIEdyYXBoIGxpYnJhcnk/DQo+DQo+LU1v
cnRlbg0KDQo=
