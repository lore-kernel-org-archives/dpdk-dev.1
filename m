Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AF9C4450D
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 11:48:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C22FD400EF;
	Wed, 21 Jan 2026 12:48:50 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010046.outbound.protection.outlook.com [52.101.85.46])
 by mails.dpdk.org (Postfix) with ESMTP id 52E11400D7
 for <dev@dpdk.org>; Wed, 21 Jan 2026 12:48:49 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xmy/EJW/yg35EL9pmSdS8ITeoRfWVJFcNQu+OR0k4YenVlX+qHNSS7b0O2FuRtx9ZZN40jEw/BUIYgmSUG1qvMTmaI6cuOzbSgRbnV+kQlHf+vqJRkey0ICKHXrixA0G8EtVu9A8dN/yxziJ8+y1Y91yvcdRkcelzZDuNCXtzfC0wLMxXTUekiPmQ9gY5Dm0R5Vdphd7n3Cz015HkV2IUElGOw/uxSyWGFkoU/T1smNLpqMOasnC75pR4rGYAoP7aOjbjJ4gXUUy/9Mws3eB/Cmtd+Y3EqHtLYBuz+z/Lfo9SiEDsj88RbrmqOgoIvwtDIVCZwhCcNum0AMUKuDJaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RymdgBTQuUdtwgbuKOWiSesmoyVRWi4S4Swgdm1ZZvU=;
 b=fGdB2d6V9/Q66tZJzhA/3ameONfJ1dqieItXFN+zzaqVlw/jL0msqmB+0AOutLCjf3Kso8X/pG2Iwozix0zTKCIgVa3zCRgDr/ukSaDf7bB2ygYq6lCa/Y4U8YRp8rXafQF5ib6ssHsoYBJTq6ZR5pfWdXpA61L/Zm6lN2zyijWExQDVRaGaOnfIzXPzPPJrDrn0UJKf+i15CYw1eQiU87t0BL18KzfYJ9lZximTN4yxdgm8l4VODncTJ/ibETTMfgr8arTOmNM3lLOm0XNQFraAgi0lv8lXeP0kSXfKlmxx6oTDVjTcGor2//0e2vp0HIJd233Bvcm3TOW1UXuPww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RymdgBTQuUdtwgbuKOWiSesmoyVRWi4S4Swgdm1ZZvU=;
 b=tN0bOZpEDUZ6VQcE+duJl05Zfr66zcs53RhZwGDXv0hsoqZL0WM1ndyKE5bds1fauRlI/9209AwibFL8JAwzX8odLKpDzMErz7BRzAq4tPZtngNJYQt0UlVExA5GpkZUI9a00e5b9f7U2uvsfZmIlk4X++9IhQPNihd7/EN/j+Q=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by IA1PR12MB6066.namprd12.prod.outlook.com (2603:10b6:208:3ee::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 11:48:46 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 11:48:46 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, Stephen
 Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Bruce Richardson
 <bruce.richardson@intel.com>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>
Subject: RE: [PATCH v6] eal/x86: optimize memcpy of small sizes
Thread-Topic: [PATCH v6] eal/x86: optimize memcpy of small sizes
Thread-Index: AQHcg7uDLBHaOyG5bUy6tdTsisR14rVQvruAgAouhgCAAAgkMIAAAOaggAGXv9A=
Date: Wed, 21 Jan 2026 11:48:46 +0000
Message-ID: <PH7PR12MB8596838852258FB94342042A8296A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20260112120337.277331-1-mb@smartsharesystems.com>
 <20260113151943.31c58217@phoenix.local>
 <PH7PR12MB8596A21E5892BABF88665C5B8289A@PH7PR12MB8596.namprd12.prod.outlook.com>
 <PH7PR12MB8596F1FE29BA757F8884E7A98289A@PH7PR12MB8596.namprd12.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65677@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65677@smartserver.smartshare.dk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-Mentions: mb@smartsharesystems.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-21T11:40:43.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|IA1PR12MB6066:EE_
x-ms-office365-filtering-correlation-id: 77f63142-be15-4c2e-bb42-08de58e308df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?elQveHFpVHV3eTVxL2RWazh3cUEwU2VVZ0FoNlRxNExuNUhpQi9WRzFndFRN?=
 =?utf-8?B?cWlOYndTbWhZejF4UU9LUWMwT2NLblFyWkNQenFqTnQ1SWpDZ3pLVHRXTkhG?=
 =?utf-8?B?aHduUjdWWXBiekphVGhVZUNXeGdvWDQ0dWdEYVU4ZTJSVTlEVVRNRVFYVmdo?=
 =?utf-8?B?UitYeVBIbjdsODRvNldydlN4aStocnpZQ1NWc3NwenFFemRWUWw3dHVMc2ox?=
 =?utf-8?B?S1l3bURxOVF6SzdKcnkxZnRGYy8vZHF3T1ZyUHkvZ1dOYkljVVhMSUl1OURK?=
 =?utf-8?B?T3l1UWpUek5jK1BPcFFPMnZTeko3MTVRdkNJb09leDh6d2hISFpZSTljTTBH?=
 =?utf-8?B?Q0xuaUhpRHRtbVNXdzFscGs3cktES3FGd1BUYU9aQ1NsSysrSnFSeWlTOXN3?=
 =?utf-8?B?ZDZoM0FlU2grNDNvME5PRTFXNFlYdS9CSlpLODNhUXNjUCtnYklzek1ucms0?=
 =?utf-8?B?UVI2ekNUdnlKWXVQQ2JhMDR0bHUzbDEvNVhXT1JTOTk1emVxalVYSlFJcGJz?=
 =?utf-8?B?RUk0TCtzaHREOUx3OGZ0RzZCVmUzYmxLSExpUUtpbDJneWFWVXR5ZWhNbjVD?=
 =?utf-8?B?RHB6WE51OW5JeU5PRmZCWEU0SDR1bU4rQzBVUUZUK1g0VkhmcUUyRWMvNVdY?=
 =?utf-8?B?enV5U1hHeHBqU0Q5K01iSFdTZWorUDJvQVVjUURqVzBkY2VPSDRlYllscEwz?=
 =?utf-8?B?MFlJUk5KcmR3cXBMb01CVi9DUzVGcGhtTHQ1Z05BL0NlWjE5aGI2N2hlZnFi?=
 =?utf-8?B?MTdSTm41K0NCejRZLytOdU5vU0pzSW5Ya2lsTEtDZ05zZW1jbEdYRFhTZ2ZX?=
 =?utf-8?B?SWlRM1YvMzZtdXNXSC9BZkJMU2ZjRXBoNXlvcDNqUVFWNU44cGNWeFFqbW45?=
 =?utf-8?B?RFhtNkxmMitZYmpseW1jUHFOM1lIRWpDNnI4OVhpVDRvYmU0eFY2T3VUc0ls?=
 =?utf-8?B?eEZ5bXVpM05jSW1ndVFqckZ6THpGMGd4YzlkY2RRUllqdUd3Y0dHakZUSVpk?=
 =?utf-8?B?cmUzK2ZHcFFjNWFEczI1c21Ed3gyYXFRTW5IUDRvOHpIWUg1VlNyVkpYQkhy?=
 =?utf-8?B?cDZCenVIaUN3Tk9QQXFZR0k2YkJwODlYdkdrbEpESXBwWThaRmIrQk9NRGQ2?=
 =?utf-8?B?TUljbEdpY01PRkRUclBKWGFJdFhVeVpZVS9kZkkvdFljMkNOOW9Rc0ovV0Q0?=
 =?utf-8?B?am9rT1lKU2wwQ0VBTnBEeFRBVzdWTkdEWkIwdGtScEtrZTlwemZaeFNQZDBN?=
 =?utf-8?B?d1IxeGJVa2pBbmtxakYzYzF6S3dmVkpaaloxSDlBemptK1RzaWltelR2VUg0?=
 =?utf-8?B?eHVubzBvMTdkWk5lc3ZCZmpCSFdjRWdhaXdWczhwNnNqSFNLbXlzTklXRWdK?=
 =?utf-8?B?bEQyYis0bXZ6RXdKNm5ZekNDWjlWaXlPaElkYjlnT2pNcTNuV01nTGJlTmZP?=
 =?utf-8?B?VXJra3JaTmpVRm1xWmNWeFZ3ZFpIQlptTlV2QzU1RlVZSk4vaVhuWVJRRUtJ?=
 =?utf-8?B?Z2dwdVZlU3dwWXFTdm1LZEFjc0tKV3BSVlNnVmluRWE2UEhpa25YMlZxKzh3?=
 =?utf-8?B?c2VXa2lMQkplSStSdHMxMmtqS21sRmt2VWVHWnpnejJzeHlORGlQcmhZS2E5?=
 =?utf-8?B?eHFNbjJGZXRmdElXTE5OZlo0em9pcXpSNnBXWUk4N1NLdkJ1d1hpMU03MkR5?=
 =?utf-8?B?R3htUjU5UTNkWGd1V21ZUkhuakR0NjBUVDVrSU1TRlBjR1ltRXpacTA4RTRx?=
 =?utf-8?B?amRiWE9qeWw2WWR3TVRtOHMwTWdIMHo0WnhaYUp6c3FGWnZ3UkVaVkkwWDI4?=
 =?utf-8?B?MjRtUk9MMGxrQkV2US9LWFp3eEJYRzJxdWZUUWR0eHBEUGZaNnJkNnkveFdX?=
 =?utf-8?B?UFY4WjJ0TkRnZjZuMVo5dDQ1THk1ZVpmVjJmN0kwcmUxWWp0UFpabzd5L1VP?=
 =?utf-8?B?V0FxNEVnc1pFKy9Ia3VSQ1lTeE5naEJ3dFhJaGdHeE9JWEtTWldtUmoycEJn?=
 =?utf-8?B?SnRIWjhCYW1qb1B6WHVDMXkzK2dlZWZIcnFMc0xSbzlqcGdVVWtKNFlqcVE0?=
 =?utf-8?B?Nko2amRQVm15UCtDNklHbHEyb0I4alJDQ0hvQS8xa1ByZjIyZFFMRmpQQjBI?=
 =?utf-8?B?T2dVaE1GZlVURlFBQ3NlRVpvQTlsTFJGVDJqcVo5SWZHS3dqbjVONnd1ZFN3?=
 =?utf-8?Q?akiUrxCkguVUWd4vN83KJns=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ukx0UDNvcXdhOGtXN3VidkhNSjJUSXFZbHBBM2lpbE0xV3A2UVpYUVhPOHZq?=
 =?utf-8?B?aTV6bFQxb0MxMWpYWENRK2FpRmFub2VKM3ZEQzg3MGs4M3VubXNhb2RQNEhm?=
 =?utf-8?B?TFFsamVTeWI2MDJLRXBWbnkvcEVkVnJ4VWtoZytzT3Z6aENOZm9FWnlsUkFT?=
 =?utf-8?B?dDR6STJZUDFrWGtoUHh4bzVjd0ZlemQ1dFVmY3JjbTJubk1hRHlWRm44NVhz?=
 =?utf-8?B?d3JhQUJuZ2RvKzFwdWJ2UTNzL3huTE0yOWJpZ3JwQ3ZaVDFOTjNndUVpM2do?=
 =?utf-8?B?NGUvTC9OSThhWEIyTyt2ZGd4bkZIMG01NE5QM09PWTRnblZ6eUduRkN0ditR?=
 =?utf-8?B?dXQvTDMzVDRZVzA3V3NSOVJlU1F5MEZhdTFjbWtwaEdxaXFtNkUzN1lxZnpr?=
 =?utf-8?B?TzVZR1lzK0lBanpQUU5US1lQQmY1QnRzVFRiSmNuWVpWZGg3SUZnTndTVXdU?=
 =?utf-8?B?dDUyWXZ5LytBNEFkeFZTbG9kTHZCMVJLMWRBUUkvVnBGYjFiQUNTakdzNDRr?=
 =?utf-8?B?eHVBTXQxc2dJOEFxbFBqSUZQb1VGZlBMSU9jb0lwRGJIMG91dng0Zy9JR1JW?=
 =?utf-8?B?K242YXVad0pzUTl0UFVqNjU1SVdKSHJRMHVRVzBzeTF6U3FxYzhYNm5LUGpy?=
 =?utf-8?B?UnRYN29UNmFlR1YvVHdUQVNMVWNZWmJnR0VmRUlkVHo3TlI5dEpsak9iTVpB?=
 =?utf-8?B?MUk4TGhYcFlIK3Q3NWphaktXWGZKdys1bnM2aHFzeEU2aTlDOWp1MWhVQWRt?=
 =?utf-8?B?dkZodlpNMWJ0Ujl1ZHdxRGFYSUZDWkx6eXkyc212cVNQWTgrakk4cW05R2Zr?=
 =?utf-8?B?ci9mZ1FmM0k4c3dnSUp6MmNOR0xaUzNiOXgvTWo5bVQ1QlVEbFZ4aHVhVlBV?=
 =?utf-8?B?RlluODdKRUpkZCtOMzJwcmFtb2t0Ti9nRnlqMEcrMGsvUmlCLzZZREdhR3pH?=
 =?utf-8?B?T3ZiVldOT3dqTWRIamRoRnZEZFFxWHFZN2lQOG8xajQ2NkxvOGpENGdEK3Yz?=
 =?utf-8?B?TURHak9EUVgzbXlFVXM2WnFGTk1LcWFqL1lMVnpmc2dObzg1Z2t3elhicmxI?=
 =?utf-8?B?cEFsdnAyTHIzYVkrcTByK0JCZFJ5ekdOM09ZY2tmV2dIeTR6Rzl2WHJ1bmxN?=
 =?utf-8?B?NThSQWgwZnd4WHB4c0pXc0VCZER1UmRNY2cwMGttcGxyV2Z2YmZ2a2o2K3dh?=
 =?utf-8?B?dkRVdEdLckhDZlBSbXRSZXRWOVBVaHNTWFgrWEdRNGNCd2pUQ3RVOGtxYStm?=
 =?utf-8?B?bVRFMDVqSzMyVzlCTElFOTd2L2dlZXZ4aThVODd4L05BMitZR255Y3RiM3hG?=
 =?utf-8?B?Zzk4YS9FM3ZTR2JXSGdheVhxb0prU0ZMSlhjdGZNVjhWZGFHS1hQclBqNG5C?=
 =?utf-8?B?MlRyWmYyZ21WZGdaTVNrTkM0V3BYZzJaWXcwYmVON2tpOEZVK2gzWDhYY0No?=
 =?utf-8?B?czhnUFBnak9pR28weko5YkJaVnNQQjZGYVlVTVM3VVVwMnBUUzlOSmVZS3pj?=
 =?utf-8?B?MmFSRTlvUWsxYU8rS2RMZnVJa3pLdGozb1diN1BCcWdrTzRIMjQ4T1k5SFNO?=
 =?utf-8?B?dEszN3NmYUZsRGNYdGt5cEFVc2xjTWNqQzRCQitWYmMwTjZsclBzYkZkd0t6?=
 =?utf-8?B?NG1VMDFlMkFTUkk4ZEY0bmxIWlpZMEM0Uys0ZGNMd29ndGJHM256eVZiVWF5?=
 =?utf-8?B?bS9RZUxBTytQRW5zM1JUR24wRU5Bc1ZqVzNQZ3dKd1FQQldNQmVKY3ZJZ3VH?=
 =?utf-8?B?MHJGMVNLOEMwM3Z3Y0UrQ29EN0dVdU1BYklzWktvNzNjRXVod2w0UzVaOURr?=
 =?utf-8?B?OU94V1VqQlhZc2paaG9KM3dEWTJkdkFEYkFiWkpybDgwRER3M3FlK2xsUnlk?=
 =?utf-8?B?SS9UWlZSM0JUYkVoWGZDcUxNdHdIU1hvNHI1SHJPQ0FnZkhPRVB4WXVvTEFp?=
 =?utf-8?B?R1VlWENzOEl6NlZqZ0J3ZVN3NjRySmRLWVBzRDNmVDd2amptcXY3cHJpZXlL?=
 =?utf-8?B?bEhEY2w0VUJmV3UvN0pUanpiRTdNbEhKc2hYZExKaVNxRFdPbk9UZ1l2bEV0?=
 =?utf-8?B?alFXUi9HVitYUktRSGNaOU84SDR2OVc5c3A4SXFHL0d4NlEwZWIrcjlZcEtV?=
 =?utf-8?B?ZWZRay9HZURGN3VNVlFSM0lYN0Eyc0NwM09WUk10MDRITVN0TDEzUXJ4QTVQ?=
 =?utf-8?B?RmowMVptNldNZGo3a3RkTi9HYUd6b2JBL0d1M2dtNHhKNU5IYTRlUXdYUFda?=
 =?utf-8?B?YjVYc2g3amdmQXpFdGhLSGJHZmQvcVZieU9Ibm5BZ3RQRXN4bzhTVExGc01w?=
 =?utf-8?Q?jVQDOqnzNkOhB4Jt2f?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f63142-be15-4c2e-bb42-08de58e308df
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 11:48:46.2457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5BrlY5tBnLoT3dNA/8E9a14TA4bb1RH9YFParVkE9IFJKVw8CWN5x8542MFIxxOKI6uz+Gqmw5Lq2b05WGVTGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6066
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

W1B1YmxpY10NCg0KSGkgQE1vcnRlbiBCcsO4cnVwLCBwbGVhc2UgZmluZCBvdXIgb2JzZXJ2YXRp
b24gcnVubmluZyB0ZXN0cG1kIHdpdGggbWVtaWYgaW4gemVyby1jb3B5IG1vZGUgZGlzYWJsZWQg
KHJ0ZV9tZW1jcHkgZW5hYmxlZCkuDQoNCjEuIERQREsgYmFzZWxpbmUgdmVyc2lvbjogMjUuMTEg
d2UgdGVzdGVkIHdpdGggdGVzdHBtZCBpbiBpbyAmIGZsb3dnZW4gbW9kZQ0KMi4gdXNpbmcgbm8g
Y2FyZ3MgZm9yIG1lbWNweSAocnRlbW92MzIpIGFuZCB3aXRoIHBhdGNoIDY0QiAmIDY1QiB3ZSBn
ZXQgYDE1LjVNcHBzYA0KMy4gdXNpbmcgY2FyZ3MgYCAtRFJURV9NRU1DUFlfQVZYNTEyYCBmb3Ig
bWVtY3B5IChydGVtb3Y2NCkgYW5kIHdpdGggcGF0Y2ggNjRCICYgNjVCIHdlIGdldCBgMTQuOE1w
cHNgDQoNCldlIHdpbGwgcnVuIHdpdGggZG1hLXBlcmYgYXBwbGljYXRpb24gZm9yIHBheWxvYWQg
c2l6ZXMgb2YgMSwyLDMsNCw1LC4uLmV0Yw0KDQpSZWdhcmRzDQpWaXBpbiBWYXJnaGVzZQ0K
