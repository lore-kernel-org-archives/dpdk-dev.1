Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61E5C19F32
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Mar 2025 18:37:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF60D40041;
	Sun,  2 Mar 2025 19:37:49 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B60B24003C
 for <dev@dpdk.org>; Sun,  2 Mar 2025 19:37:47 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522IH6Qo013168;
 Sun, 2 Mar 2025 10:37:46 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 454kvegnva-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 02 Mar 2025 10:37:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylhR6rI/pml4RVB4uUutDoq+FOmpd0aKPtxQe7S/SJ5rJPRlxrzglwAA9jIvCvc3F/pi2mFdwgAzHxoKq8qY/bD6X+gd+barOScE2S3+5jnBHWif87t7hvCOWWjBOS/G/wnIywZdFwPa2gGkAfONx/k05IvrnYpEpd48/BRY1688ot0OJ/rw8j9Brn8QoHr/I097H0gBEiO1+XyGH3IelgXuLZXN8MqbZN1HguOgTl2s5xTyODs45n8Ar8BWkH+qbsFu5egGyYtHY75ETXUv83psNw8S3awZBpg+IP7/0fe5cl3ZArHw8imuzMQor8ZF3c1GgBcYYiWeMUQgAbNmHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgFYXIgGBzWSul7R0wvRYbjSJlh9xW53Tlr+CeNqHb4=;
 b=S+VRprvNm/+tdhVYYwhJ2kGeGMB53C+G21CHnlz85xkEArBAgMb/fBGz2FFksxKhhJ6Y2VMUWw//wSp6ZtWp8T0RIw2HsF4OtuJ7KhK/m2MGQUoLl9eyYV8aBWFZ1SK/fGNUaafsf2O6zFkA7uLJ5w7WUcDwI790U/xUTqRDe81amw6mC+6ngIEuT386H56qLHCgTofy39eg8LgSDXxMc5VKvDO9aRJalE+l07uS+btKbU3fM+MaA4R8GQIZhAwwcWgUCW0XmHgxmSZF2rIEaiAbIxmFSBZNC27imVgXk9HpfpZsVVg+ncZSkY5NkjoS+1sflgkBHraI9QfTO8wt+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgFYXIgGBzWSul7R0wvRYbjSJlh9xW53Tlr+CeNqHb4=;
 b=sznyhQ4V0S+OH4zCS56Up8WoDUSrER64dpo31PfY0epBvWSomDp+LoekFeWRKzWFo+ezfgTjdudifCaLJ/Pr80khKD1QjpZeBy08yO6H63A5oQGKTFzbQ5lbcM3KcN4cwfi1PuQH/iYI1Alq4+JS1xhgMak705rWWbQeyVzj2uw=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SJ0PR18MB4496.namprd18.prod.outlook.com (2603:10b6:a03:3ad::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.26; Sun, 2 Mar 2025 18:37:44 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 18:37:43 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>, =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?=
 <mattias.ronnblom@ericsson.com>, "dev@dpdk.org" <dev@dpdk.org>, Fan Zhang
 <fanzhang.oss@gmail.com>
CC: "hofors@lysator.liu.se" <hofors@lysator.liu.se>, David Marchand
 <david.marchand@redhat.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: RE: [EXTERNAL] [PATCH] cryptodev: allow use of global variables from
 C++
Thread-Topic: [EXTERNAL] [PATCH] cryptodev: allow use of global variables from
 C++
Thread-Index: AQHbUjW/WvGgHHNB1U2CtGMgq1dumrMMwY4wgFPeHRA=
Date: Sun, 2 Mar 2025 18:37:43 +0000
Message-ID: <CO6PR18MB44844D176B4FF094210B4C53D8CE2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20241219163523.164992-1-mattias.ronnblom@ericsson.com>
 <CO6PR18MB448445B1358C95D3556FAD2BD8122@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB448445B1358C95D3556FAD2BD8122@CO6PR18MB4484.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SJ0PR18MB4496:EE_
x-ms-office365-filtering-correlation-id: 6b7c253d-a1b1-4e09-e90f-08dd59b95228
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b1UyaVhYVHN5MFpiRXd4RXFEYTJWWjE1SE5sTWlwdEkwd0dyOHJkTHNMd0VR?=
 =?utf-8?B?R2dJZ0lrdkpQcjJCcFZyZDlVc2ZtTXhJdDFleHg1NDFkNllGeFlsejR3b3d5?=
 =?utf-8?B?OU5tclgwelRob3prVTNENnh2Q3ZLSG1BZWN1QlNKeTgxUmlCU1VKVW51L0pw?=
 =?utf-8?B?L01sTlB4UWV4K0hjTjBRb21QaS9CQWRMK3hZWXRkN3FZcXl5QWt4bUxwOWJz?=
 =?utf-8?B?TDRxSDdKZ25NVSs3c3dORVJEQ01ZRHBzNklyTnJ1amIydllySk9GVFMyM0pp?=
 =?utf-8?B?QXE2VXluYkcybkJnbUgxUDhnK0U0UDdwUE5PZnR2Zlo0RVl6TGwrMHE0eVE5?=
 =?utf-8?B?N3BTTVBjS1NldWsweXBBVEtiLytwaHBpMTZ3cXYwQmprcXpDRzByOGtLS21h?=
 =?utf-8?B?bldpTjdEVmQycVJ0U1FCOFRqQndsaTdpUWRuMjRzS0laQzl2Z0RFWC85NjFU?=
 =?utf-8?B?WjYwZFd4alJubzIzY0lIUzAwcCtMMlNKeXh1NGM3VWhHRTFQMUVwZ2dFZ2RM?=
 =?utf-8?B?ekpkZjA0VzVDYVZNZjNDbVVpRUpOUUdTNVBOdUtZU2hzb3R4cU02Tk9Id041?=
 =?utf-8?B?MGdkZzF2R3lKVXp5eEVzWFdabEJ4amdCSTFQemFpV05rczRzVmliVUx5em9q?=
 =?utf-8?B?eXB3cXliVU1Eakc2bjdNL2NRRWk2ajhkTXhuMUdhRE1GTTJDVmhUd0VjNWJm?=
 =?utf-8?B?Yit0U1NKNmhLQ0J4VGRFN0g0UUlpbzlEMFFYREhVWFM4d0lrVll3N1hOUUlX?=
 =?utf-8?B?bjV2aFIySTZvNnEzbnBFemtHb2JpcG1FZEk5WDR0RDV1ZGg1UjVqN1Jkb21y?=
 =?utf-8?B?ekRUV3JZUmJMTCtHLy9WRjhXRHVKaGNYanYwcFhZMURhY1luQzd4TGhHUita?=
 =?utf-8?B?OTN3RURFeGxhbjF4VzJOTnBFZE1vbFlvZVA4OU1KbmREc093M2t0cE1XOG0x?=
 =?utf-8?B?NHNmVlh5VVFNbzdkVnNrRGI3TFJaYkttWUFKeUg1QjJ5TkxFNEhCRXBINUVk?=
 =?utf-8?B?VVIyUkVlV0NSQXR4TFpSb2YvRituQ0RJSVNHL1EzazR3a3g2SDN1SXBacllZ?=
 =?utf-8?B?WVdnekFCbjRDSDhLVXp2SDVxUnYya2FkWUxJVE9nRmNZK3JOSDUxUzBjSC9M?=
 =?utf-8?B?TlMrZkNVY3c3WUc3Tk0wcUFvRDh3NGg3NVIzdW1jcHlObTh1aGtBejRTUkha?=
 =?utf-8?B?L3hGY25MZ3gwVUorblVjZmtzMVExYzR6dGxLT1h5cWpSYno3RlNkSkJ2SldC?=
 =?utf-8?B?U0pPeU9nYVVsZEkvMUdHQ09MdTdEMTNwbFA1eFUxZndCb3FmaER4d3J4M3FJ?=
 =?utf-8?B?MDcrT0JxVUZDalJTSDVlREE1WjFZc2tmNzFyajQ1d3lCTGZoVlBRM2h6NjNl?=
 =?utf-8?B?VGZIRUhUdkxRNHRmZXdJOWFzYXNvbk1ldWFjejdMazFzaXNXcnVoUjVyS0lp?=
 =?utf-8?B?ZVNQT05VL0pFTVppWnRsaFl1eXljYU9tSjQrNlZrNVZ0V1B3VGpsTUFZaHlO?=
 =?utf-8?B?aHEvbWZBd3U1UlBsczd3YmNCT2ZJYnJqZ1dRVThxWEhTaUxQRms3RmdKZzlu?=
 =?utf-8?B?akR5M3kyMDgxVWhIUU1tdjljQUFXeHMxbU5WeWxobDJpcjlhcDVmcFNMS052?=
 =?utf-8?B?ajcyVTJBQXJKNGs1RjhtVTdKSXA3V25xejJuc0NsUUlZS2NVcmloYmlDRHlD?=
 =?utf-8?B?K3JXVEU1WHN6T1p4TDIzeE1IV1VuRGdWckFYVWFlZ2pXcDZKaHA1c3hxam56?=
 =?utf-8?B?THBKdHRqMld6S3ZCaXNXdjV2Z0lJaHNiSGNjM0VFN2NPU1VvM25jYkw4LzdC?=
 =?utf-8?B?QnNNRGVueHlhN0Z3dVlDelRPRVZvQTFDOEVOZkNFTmtCd0xzdmtqY3FXa0Za?=
 =?utf-8?B?MXVWUDVlYXNIOUdMTnRTUnplVVFyTHB1VEEvQk1LYzc1aG41WWJ4MjFqZXo5?=
 =?utf-8?Q?jPq77GzTHnXIPlaEL/n8+gj+wEqJWqw8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L05FZDRGMXZsT1lwelYzTlNnWmNQUUhYK3NHZzV2T3ZINllsaXJDeDNoS2NR?=
 =?utf-8?B?b083dGEzWFNabDBVU3E4a21jUDJib21jWGxUOEp1Tk5kcVk2NHFpRlNyZmxJ?=
 =?utf-8?B?OTNEQzFQQUkzNGJKOU04cWx4YlM3enpPK2x3MEJnSm5yL1JBbmJ2cEVhdDZC?=
 =?utf-8?B?dzNXY3Y3ZTRLSUpxZW13SnhmUDl6QmJncUY4eXZzTUV4b0lIUTQ0d3J0a1JW?=
 =?utf-8?B?am92dXpXVUpnUmdZYmVuMGhORGRsY1JqV3VacmZwWTQrcW8rU1NFZjVZSEpn?=
 =?utf-8?B?ZXJvRkQ0QnN4OE91YnVVWnFIQ2VWcjlydittK2ppR1lybDFlTDlTMWtOdzA0?=
 =?utf-8?B?RzBKWWo1RFpzaFVjUkkxV0tSbC9INE44dWxqaFdRM0lVY3dBc2ZabWlXU2tt?=
 =?utf-8?B?SXRQNEpXNWU5Skl2aDg4aFNwOTdMdW1Hc0dvMmhtbUVHblVINEVaS1FSZlJ3?=
 =?utf-8?B?WU9FbG9id2YxeEtzUm85L1ZDbDVmOTlPSjcrWm5vT0tGbGZvTGN2M2VZWHpC?=
 =?utf-8?B?UlQ4bVV1KzZ5UE11N3VkVURTRXkzZ1Zwak80ZG9vSjVkbmMwdFhvN2tucFkr?=
 =?utf-8?B?VDJ6cjRoZzNTWmFIQ2V5MzY4bzlmK0czZEtJTXNHNUpuYWE0aUZsSWliNHdI?=
 =?utf-8?B?K0tWYVdtQVNkVFBiZkk3TmpOeHN5bldsVU5wS3lMN2lpRDN3L1pQUWlXYkxa?=
 =?utf-8?B?RWhnOXBvUWF1bTZ3SWlpUFhTWXVZeXYvUEhVcWJwYkM2alBzRU1VdlY2MFpN?=
 =?utf-8?B?WkdLUEJlUEIyS25zK2pUdzIrNVRkRHY4cU5XTEFOQXJITVZ4WlJpNjVhK2NQ?=
 =?utf-8?B?RWVhR2s5cExWc2VQNXVhQ0pPKzBBblphc0NLKytsakY0YThjZUVYNG45b0wz?=
 =?utf-8?B?WVM4YXNLQTJZRS9ZYk9xNVd5WDQ1YUhPVitTUUFuajg2QzhoYmVsSW40dXli?=
 =?utf-8?B?QjRGbUNaRndzcXlsTExNWXc3NnkwUStqbS9oZldYRXBZbVF2U2IvYWV2d2dD?=
 =?utf-8?B?QVo5TW1QVXpsRWRTNjlQSHRnNFdmVGFRWXp3QnluM1I1aEFrbkx3Q1Q4THls?=
 =?utf-8?B?QXI2T29uQjFqdlBCODBSTkdDdTJuSTBTMW9QcnFVQ0xiSUxLR1N1VzhwYmxo?=
 =?utf-8?B?UW1Ec3c4S1lCRXkxVEY1RGFvcXdIQVhKT1VqcitQZ3laeXp5SC9za0tjN3Nz?=
 =?utf-8?B?STVCOVhLVE5IUjdZa1dkVkc1Rkg0R2lTL2lYMjZFTGp3RnBtRjc5cVFlOUcr?=
 =?utf-8?B?SWl1ZWljWFZiZnNaV2VrVCtlYlErUHVqQ2JBOS8vWTE0bmk3c0p5elVEWWlw?=
 =?utf-8?B?bE1uN1lFVDRhdk9mcHdQd2wvZ0FDOVZNN0xrSE1tNFlJc0Ivaml2bXNKQ01p?=
 =?utf-8?B?Q2UyRVA3bmV0bU4waVIxZEttY2dvaEI4QUNqOGxWZFY1VERUekdNSjUzb1pp?=
 =?utf-8?B?cWFDbVhVSFJlMXdWUEFwTVA0alJERTlHM3lYWHg5K1JGSS9uSjBjK1hZeW5l?=
 =?utf-8?B?WnVua25keWE2aThxMkIvcDBITVI5czk4cEYwbkt2UmE3ZHFXUG9hV3BuUmRj?=
 =?utf-8?B?QkZpQWJSMm5QOVBvUytXR1NFSTNIK1VTYVNmRjdEaTh3ZEZ3WXlqcVZ1VVh3?=
 =?utf-8?B?NElVQjAvbUczN2NianBoVHE5RUxDQXhWc29CV1cyTmJtQWFaZkh0T2JIamxk?=
 =?utf-8?B?cVlaN3hrOUVzWE9XYmZ0TUZHRmZDNHVBMTY2UWFtQmdRZTMvdW9Pc2xGQlg0?=
 =?utf-8?B?UmV5RHo5TGpHNEdhTVNxN1JxMUg4dkdSc1BUNEhpZGJsRzZ6Y3RkTEU2WS9D?=
 =?utf-8?B?STZ0Q1NKaGk2aWxiUjZlMi83NW9lQjNsLzBBNXhQZ1M0emVWQTV5UWVPbzUz?=
 =?utf-8?B?MFVpeUVkWlJwTE8rZ3Z6QlVNL2M5VjcxMCtpMXEyYWNFWXBKOXdhNEtsYUdz?=
 =?utf-8?B?QTVLTWFPVzkzODVUYzlpMkxlQWYyc1c2alJOSjlDMHJqR1JtNHdBWUhXYjBw?=
 =?utf-8?B?L3prVjN0RHF3Nk1QbXJ5TTErbEFhWUxWdE9jMzVLaUQvVTVJcC9aRUNMc1RZ?=
 =?utf-8?B?aUFPOENWVUcxKzgvQSs0QWxUQ25IVWN5dXNzQkdZVVR0NmNGb1hqUE5wRWpR?=
 =?utf-8?Q?Z9xbWzU3Vw58bGF75ez/JbylZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7c253d-a1b1-4e09-e90f-08dd59b95228
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2025 18:37:43.8502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nY/2IB1pKepNhuGqmJwqL9EX8BX/G0FlXZergx5JzQz1NEJACfE4raF0+25sKGeJrZyGHDjBgT0z2hPpsngL+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4496
X-Proofpoint-GUID: nG0KQmgAnX32MK1OcGdtOuLClDuqpXwi
X-Authority-Analysis: v=2.4 cv=O73DvA9W c=1 sm=1 tr=0 ts=67c4a57a cx=c_pps
 a=di3315gfm3qlniCp1Rh91A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=miE8BliPBBtOm77D:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=20KFwNOVAAAA:8
 a=0FD05c-RAAAA:8 a=pn9NDFP74hWx1VWahpIA:9 a=QEXdDO2ut3YA:10
 a=l1rpMCqCXRGZwUSuRcM3:22
X-Proofpoint-ORIG-GUID: nG0KQmgAnX32MK1OcGdtOuLClDuqpXwi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-02_06,2025-02-28_01,2024-11-22_01
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

SGkgTWF0dGlhcywNCg0KQ2FuIHlvdSB1cGRhdGUgdGhpcyBwYXRjaD8NCg0KPiA+IEF2b2lkIEMr
KyBuYW1lIG1hbmdsaW5nIG9mIHRoZSB0d28gZ2xvYmFsIHZhcmlhYmxlcyBiZWluZyBleHBvcnRl
ZA0KPiA+IGZyb20gPHJ0ZV9jcnlwdG9fYXN5bS5oPi4NCj4gPg0KPiA+IFN1Z2dlc3RlZC1ieTog
RGF2aWQgTWFyY2hhbmQgPGRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogTWF0dGlhcyBSw7ZubmJsb20gPG1hdHRpYXMucm9ubmJsb21AZXJpY3Nzb24uY29tPg0K
PiA+IC0tLQ0KPiA+ICBsaWIvY3J5cHRvZGV2L3J0ZV9jcnlwdG9fYXN5bS5oIHwgOCArKysrKysr
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvbGliL2NyeXB0b2Rldi9ydGVfY3J5cHRvX2FzeW0uaA0KPiBiL2xpYi9jcnlwdG9kZXYv
cnRlX2NyeXB0b19hc3ltLmgNCj4gPiBpbmRleCBhZWI0NmU2ODhlLi45Nzg3YjcxMGU3IDEwMDY0
NA0KPiA+IC0tLSBhL2xpYi9jcnlwdG9kZXYvcnRlX2NyeXB0b19hc3ltLmgNCj4gPiArKysgYi9s
aWIvY3J5cHRvZGV2L3J0ZV9jcnlwdG9fYXN5bS5oDQo+ID4gQEAgLTI1LDYgKzI1LDEwIEBADQo+
ID4NCj4gPiAgc3RydWN0IHJ0ZV9jcnlwdG9kZXZfYXN5bV9zZXNzaW9uOw0KPiA+DQo+ID4gKyNp
ZmRlZiBfX2NwbHVzcGx1cw0KPiA+ICtleHRlcm4gIkMiIHsNCj4gPiArI2VuZGlmDQo+ID4gKw0K
PiA+ICAvKiogYXN5bSBrZXkgZXhjaGFuZ2Ugb3BlcmF0aW9uIHR5cGUgbmFtZSBzdHJpbmdzICov
DQo+ID4gIGV4dGVybiBjb25zdCBjaGFyICoNCj4gPiAgcnRlX2NyeXB0b19hc3ltX2tlX3N0cmlu
Z3NbXTsNCj4gPiBAQCAtMzMsNiArMzcsMTAgQEAgcnRlX2NyeXB0b19hc3ltX2tlX3N0cmluZ3Nb
XTsNCj4gPiAgZXh0ZXJuIGNvbnN0IGNoYXIgKg0KPiA+ICBydGVfY3J5cHRvX2FzeW1fb3Bfc3Ry
aW5nc1tdOw0KPiA+DQo+ID4gKyNpZmRlZiBfX2NwbHVzcGx1cw0KPiA+ICt9DQo+ID4gKyNlbmRp
Zg0KPiA+ICsNCj4gPiAgI2RlZmluZSBSVEVfQ1JZUFRPX0FTWU1fRkxBR19QVUJfS0VZX05PX1BB
RERJTkcNCj4gPiAJUlRFX0JJVDMyKDApDQo+IA0KPiBJdCBzZWVtcyBvbmx5IHRoZXNlIHR3byB2
YXJpYWJsZXMgYXJlIGNhdXNpbmcgcHJvYmxlbSwNCj4gYnV0IHNob3VsZG4ndCBpdCBiZSBiZXR0
ZXIgdG8gaGF2ZSB0aGlzIGNoYW5nZSBmb3IgdGhlIGNvbXBsZXRlIGZpbGUNCj4gbGlrZSBydGVf
Y3J5cHRvX3N5bS5oLg0KPiBUaGlzIHdpbGwgYXZvaWQgaXNzdWVzIHdpdGggYW55IGZ1dHVyZSBh
ZGRpdGlvbnMuDQo=
