Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503AFC83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 10:05:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2120C4021E;
	Wed, 16 Jul 2025 12:05:36 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by mails.dpdk.org (Postfix) with ESMTP id 053A64013F
 for <dev@dpdk.org>; Wed, 16 Jul 2025 12:05:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erAItrEpnDDKSc0VhqGH+aK49FPVbI/GZ3qB0oXn37fi3/W1if2lgAaIRV4yj2X/2PKxrY/PgGjKNX5V98exAi7/ouzdifHQknsIkoU8IghYEz+3LHvAEJAPdPwcw/7gW5haNlA4eEKSSb6YipyIgACWZgDBMIiD9bVUT5/ePhq3lBPcBNhLxPoeDi8uahSfaMwjA1kYl2bXretg94bbY9hHCsY3I25n8uY1ebfdr+uR3ALL77611mTGyNj2p8PeBUHLGp0pqjCnPgrKHphRzucH4EnS1vVSXABStGAS9Vv6DjkZoa083kxzZ5buUmwYcB0ykObld+A7ux67OE4zjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbjEKCeghiYwJBxE9kfrnT6qHkMIqiVvWFNXSk58UWg=;
 b=m2grzZOR2TnVcVzE2+KcgVEJXrWkABPjmyY2n7Q4UzMNlvXUdezjwVfP0QKfzn/bIqZm6pEejlIm4wwITlTuSRr7sMgAlXRL9pIGLVaqOVzh9N6e7W12XJ3OtT8RITwYU9JNK4Pr4mV9T1fkKw6Xq9Mzd2toxXmI7s9MA2nPm2Zq/dDpdaeP/myBa9w+vMrdESAKnm93ogRybL6PLT3J5jjQ+sBcgJ+vm9L2s+38GiJ2TRJbNCw83DMjKHB5ijUIZsJuG6ewkiwlVP+eyedvigGs/2pk+OE1FPB+gn1GDFy+h1nDTrMG8GH+j5OGJkTLRW7yxxCucS4ms42XkwldDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbjEKCeghiYwJBxE9kfrnT6qHkMIqiVvWFNXSk58UWg=;
 b=UKwFR3sPg3+gOMXi8k5RUkbQG39YkypcVt9rbtzYPU18PhE7kEYQPndcCDVgHTF8Q6HrfX9BWF7al/8tCS80tLqS3UhvaJ/KKbV30EdHbNbXORJU6XT/Iv9zMXMBu+1+JUL4pkuFOXTKiHwkKtxKCls5PsVMJJKc3SpP1Fbd8KE=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 16 Jul
 2025 10:05:30 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%5]) with mapi id 15.20.8835.027; Wed, 16 Jul 2025
 10:05:30 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Thomas Monjalon <thomas@monjalon.net>, dpdk-dev <dev@dpdk.org>
CC: "Song, Keesang" <Keesang.Song@amd.com>
Subject: RE: DPDK release candidate 25.07-rc3
Thread-Topic: DPDK release candidate 25.07-rc3
Thread-Index: AQHb8Rgy39dV3hxrMUa1JiYpp+zXvLQzQ5mAgAFIkvA=
Date: Wed, 16 Jul 2025 10:05:29 +0000
Message-ID: <PH7PR12MB8596207D1DBFF1D7A4DAE98D8256A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <9991491.lyo4hBLbkK@thomas>
 <086c9e27-466a-43b1-86e7-8dc4095512d0@linux.ibm.com>
In-Reply-To: <086c9e27-466a-43b1-86e7-8dc4095512d0@linux.ibm.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-16T09:51:19.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|MN2PR12MB4406:EE_
x-ms-office365-filtering-correlation-id: ae3a5114-9ac1-403e-093b-08ddc4504b8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dnozMUYyeG1id0YzNDgzanp3L3RueHRkSFAzTUp1M2tLWTdvVzdaMDdyd2p5?=
 =?utf-8?B?aWl0NjRLN1hLd0FVblhwSFNNNTJjQXBNMkdUVVJIYjNFdTVjWkRib3ZObHhZ?=
 =?utf-8?B?K210MWp4dkFpRzJzQ3h5NkIxMS9rTjRPTGlpQTI5NWZVa1VBcS9CQnRKbGor?=
 =?utf-8?B?S0NZN3Bzc2MwYzZrN2ZMcHhqWWJzTDFNUHZJQjJMZ21nUTFGUVhxeVJzT0FY?=
 =?utf-8?B?TW1RK3l2TS9jeGpDK1F3NFFtVlNkaENvOUwvM1RCUGFDeUV6UEFDS2hvSFlj?=
 =?utf-8?B?REprZkZPNnl5T1FVQk5oNkRzZXJNbVE4RWh3T2ozU2c5YWpWK1JrcGxrS1F3?=
 =?utf-8?B?SDJYTHo5emFJMHl4N2tGRTVOMXdHZnRmYjEzd1BZQWNOeVFyU3g1bjdQQ2FF?=
 =?utf-8?B?YnhtZVdpTGh3cDBuTDFOSldWN2k0Um4yZEVwTDZyb0l2ajl5NUVYQkxOS3VK?=
 =?utf-8?B?L3RnRXpUckt2K2pyZ2hGM3VoaEk0NHNNbVZnSXNTaG1Va1d0RDRJWEI1TFhH?=
 =?utf-8?B?ZFh2ZzhaYnpDNGZ6Uk5JNGtqcFM1V1N0QlhHcC8xK2RYZ3FpYjc3WWRGVDVT?=
 =?utf-8?B?OFJ5b1FVbWhkN05XL1B5TFZPeldWU1hDemIycW5rVW9BcHJVbzBrRndxU1dz?=
 =?utf-8?B?YnVIQmVPWWlOdTUybjExVlJOellnL0pWU0FpSjFEUDhtNXVxSVZ6bm1heStX?=
 =?utf-8?B?cFI3VHcyYUV1K3ZUMjl1TGt1cmtJdFZtQ0Q3blJYSlE5R2RaTm8rb0tpenY5?=
 =?utf-8?B?eml3bUJuNUl5ZlZYRENXeU8zazhldEI3YzdWQzRaSEJjdy81RHRxbkpwaEUz?=
 =?utf-8?B?SGZ3U0NpSEpJQ3pTdFhlV2tyUzRvU2xKdjNCdXhsUGhLTWh0bzhaSnpOdU9W?=
 =?utf-8?B?SE1KL3RVUVdNaUgzWWxNT2x2QllldVYvMHZBa2l6WTE0TnNhREJPazZ2WG9C?=
 =?utf-8?B?Vk1HbEtGaXdsNGl0TW0zUWRvSDFHNjBwc29sUS83Q2d1Q0FUNEJKWU1ZT0h4?=
 =?utf-8?B?ZmdZaVpHSXZaa25jKzhlRmpab21MVFgzcUpaclRlbzZERE1zbmJwSlQ4M1B3?=
 =?utf-8?B?UjFPMzFCZjVrWW9qU3d2VlIwM3hzS041Z2pGQXZMRmxvYmYyTExyZ1VJQWRq?=
 =?utf-8?B?eDlZdjBabkk1ekFtbFp5VnBNS3ZmQnRUVWp6QVhWYTVtNmZhd0VpeGM4eDla?=
 =?utf-8?B?ck8rQXJHaWNhcGdVbXl4NFBNTWhidmNaeE5Bc2ZSRkh3bytBOXdNK1pwTTQ1?=
 =?utf-8?B?NTJhNDh2OG5IeE1CL3UzNVNDY0ZTanFYMFpOR1QydUNhejNjbG9RemZjNHVi?=
 =?utf-8?B?THRMMTVoU3Z3MFgyeFlaQVBiQlloWWFLMVVIVFd3a3JmN1ZjUlFCMEJzaTlk?=
 =?utf-8?B?Q2FkSmVLa1ZPQzFxNTF4Z2lVdzIwWWdYMXB1MDEvb1ZDSHkvbVpwMnpCWlVu?=
 =?utf-8?B?OE5sK09lZTdRaFltc091eUE3UjZ0aERxNkpXNmJGaUtQMlkzMnVkeVlsMDNV?=
 =?utf-8?B?bUhHTFJSNEhwMkxMdG01amJRbVgxOCtDMytYN29jUmZsZmYzZG9MZnNqWk4v?=
 =?utf-8?B?Qjh1UTZBZStoSk51cmkvSnFuODkxYy9GL0tlMHN1eUloZXdrbGhZV29nM3hp?=
 =?utf-8?B?OU9vSnZHdW91a2JQOWptQkUwelhkVlVidlBWcnBSTndDZ1dMRVdRL1lzRURm?=
 =?utf-8?B?Q3dDYkh0TFI0Q0ZRNzh1YkYzZ1N3MGZOTFlpNzJZc1VmSXNGQzljT1RXYkMw?=
 =?utf-8?B?cW9FZCtudGVXb1hYNmc0RUFuc0dIOTlJVXJxc1JIK2VWTHVFaVBjOVNlVFlS?=
 =?utf-8?B?U2xiQkRkN29zOHpCdmUwaWJQWFRGVVU0Q0xkdld4ZUtYTVNxRFVEZGwvanBV?=
 =?utf-8?B?empxRlhEaHE4RkdvcW5QZE9NTGNIZ2JTbGZuUm9rYmF5bjY2djZDT1NVVXI3?=
 =?utf-8?B?WUZLZHJTNWNDR2FWRkdHdkpkS3EvSkxtU2VqM0xybjZ0WktBNjVvV1dwRE85?=
 =?utf-8?Q?WMrvIDsi50BGCozBz9PO8kmX+/TTiY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVEzb052Ukg0b0lPcDNLZ3JCeHN5N2JTSnZzTkVmdVFjYzJRVENqeGZQalFu?=
 =?utf-8?B?bHVhWFBLMTJRWDVRZ0FWWmlqSWlvOTY4UStFWWJVbVhNSEJJa1JVK2tIS3Y1?=
 =?utf-8?B?R0Vtb052NUVoS1RxMjdGUFd4azlmVTI4U3BpVWozeUZxRjZaVXNHVzBvRGZn?=
 =?utf-8?B?Rkwya2VNSnRLV29UR0JIYU1CU3ZlNWV0Q2ZVTFgzMXhOVFRuTm9aQjlxUis4?=
 =?utf-8?B?NUlLT0N4RDFOampwVzlwSmF2YldrYnRCMzhKYXFEMFBPTFlNZXp1dG1adTA3?=
 =?utf-8?B?c1FBUE5tZytYbFIxVHBtcDJUTWM0SWpYTm9OWmRzK1d3aGp2a243RXBYanRn?=
 =?utf-8?B?QTVHb2IraGZYYk5UcFc2WEdueFVIQ3FFdm1jVGY3SnpnZzhreHowTVZjZVBr?=
 =?utf-8?B?clZ6OEhTRXNsVnRxSkZhUDdFRUNmV1BDNnpWRmRvYjcweEFJai9MTWNQTWxD?=
 =?utf-8?B?bDdlMm15OWl3ZzdMN3FSNjZDeUgvaUh2MGhyY3ZHMG5qeUdJR05tTnVLWjdo?=
 =?utf-8?B?QXZ5ckU3bjN5dVd2SUJid1VuNS96NVYxUmY3c0dRUktpOEhSejhoMjl3Tko5?=
 =?utf-8?B?aElEbzM4b1lNL3E5VlpSUlNXOURkTWF0bDZPMzN6dDdWNWM4V3g5YStpVEdY?=
 =?utf-8?B?MjhyWG5EY3l4WmdLRWJLMVYrSXU1dEVwKytCb1FWWm9VNEU0MHo3QkJXRjU2?=
 =?utf-8?B?SG9XYkl5elMzSEZ0QW90REs5dWdDSE9uampndWkweWhWT3JoNytFTWRvVjND?=
 =?utf-8?B?K0NRZUczeGFXVHljN05yYk82YktHTk44Q2RoTHc1NXlBcUxDNXRsMjhCcEdo?=
 =?utf-8?B?M2FETEZzR1hRRjhOMld5QlpQZStiK0JKNGR2LzlKUFlQQkIrS1Z1OXZxVkU0?=
 =?utf-8?B?c1h6bkp0VnV6ZC9DSjFSVVFRZHlNU3czVS83U1c2Z1FDUDYxNElONzZGdWlW?=
 =?utf-8?B?a0RwbVN5cEtjemMwL1EramMwRmRvTG42UEg2TjR6YzY1R3BqR2FsczJUNzh3?=
 =?utf-8?B?S2dsejJOdDY4MXF3a21qZE9aTWVwUUlkRUxQbHNidk50WEd3c2VUNThGdnhW?=
 =?utf-8?B?U0J1VU8xbTM1cGdMTGFCUU1zK0o4czhKVS9aSzZwU1k5ZUo5VW9PdmN0ZHk5?=
 =?utf-8?B?dkxiQW1oamtaMUpjaHg1MnpNY0lNSzhCSjFid2N3UjZuajlsdFlrRlJGK1d5?=
 =?utf-8?B?TExZWU4xV0ZEZFhsaUVOTVdJZFJ0d3hjTGxmVXBCRm9LOFZma09sbkZnZUFW?=
 =?utf-8?B?SXF4Vytnek1nTXB5eFJvaXF4Uk8vOVhEMlFkVHpyOXdqWDB3NUhFbXNjWjVT?=
 =?utf-8?B?aDNqS1V3NWVLcXJzRFZTcDhndi9sMjdhd3huVExHMjhmYXFYUHVzWVB6YlJG?=
 =?utf-8?B?bFEvdDUxOEdOZDdXa1lyOGxKbG53OW9KY2xkL3U4cVRMQjZRZFpZOFUwQUJY?=
 =?utf-8?B?OVE1dnRleW84dHhDTjRzVm9tV1NsSnloTytUYzlZc1Nmd0s5Vi92TE8zRzBx?=
 =?utf-8?B?ZytpU1ZldnBIdWFBNTF0YVJXWkFiaVRtRmJiVTU5VEJaNzJQS2RYZmZkeXB4?=
 =?utf-8?B?U21mNWZrTU1sNVVRY3A1TnRHL3pTZlJwNUJ1bGVnKzR0WWpZOWMyRGdoUXdD?=
 =?utf-8?B?dERiY2VEMFl1YUg2aU95QXlyRGJiUHo0TU82dDRVSTVJSWVwU2hpZW5WK05x?=
 =?utf-8?B?amFrTVJ0dUlnYW9VL2ROczBWV3VpVnhaZkpNOUNMT0dwandybGsyNWVrUjdG?=
 =?utf-8?B?d216eDdFcjNrRHkvOFNDb3Q0YUoyLys5TWMzRmgvcWRsV29EVFV1dDRxV1FW?=
 =?utf-8?B?MERPbUsyMlRQNm4xVFJQOFZFWUJ0aU45OENvUTJPcVlacXpEWDkrcFBVN0Uw?=
 =?utf-8?B?Z0FJMUpGNjFRNjJMUGlSMlpkUG9yNGFabm0xellWRW1qVWxJZHpQUC9oNytM?=
 =?utf-8?B?eXBwMWo5MXJ0UlFpKy9UN1BoaXJIUWdCb00zWXFQbnEzUm13V0NGWXhuNTFo?=
 =?utf-8?B?ajAvSG93ZGU0VFhuWVltM3g4UUt0c0MydjU5OEt1UjNpeXo5UlZ4QUk4SDRm?=
 =?utf-8?B?USsyWU1WMnVmbHRLa2lWOWxMV2NtMjhNRjVISEtrdUtSYTJWWTNKQk96T0R4?=
 =?utf-8?Q?VYeJD5Ua/BVQj8vv2apj0kbFr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3a5114-9ac1-403e-093b-08ddc4504b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 10:05:30.0415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WhPjnsSgp7UcYSt6lfpB6dl1stC/NAbaOSB+azS9B6EitLKhrps4NS3bdhlKc7tZl6apQTWSyhiDqfuOmR2ueQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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
Cg0KSGkgVGhvbWFzLA0KDQpQbGVhc2UgZmluZCB0aGUgQU1EIEVQWUMgdGVzdGluZyByZXN1bHRz
IGZvciBib3RoIHJjLTEgYW5kIHJjLTIgc2hhcmVkIGJlbG93DQoNClJDLTE6DQoNCi0gdHVuaW5n
IGd1aWRlOiBodHRwczovL2RvYy5kcGRrLm9yZy9ndWlkZXMvbGludXhfZ3NnL2FtZF9wbGF0Zm9y
bS5odG1sDQotIE9TOiBVYnVudHUgMjQuMDQuMiwgNi44LjANCi0gR3J1YjogZGVmYXVsdF9odWdl
cGFnZXN6PTFHQiBpc29sY3B1cz03LTYzLDcxLTEyNyBwcm9jZXNzb3IubWF4X2NzdGF0ZT0wIG5v
aHpfZnVsbD03LTYzLDcxLTEyNyByY3Vfbm9jYnM9Ny02Myw3MS0xMjcgYW1kX2lvbW11PW9uIGh1
Z2VwYWdlc3o9MUdCIGh1Z2VwYWdlcz0xMiBpcnFhZmZpbml0eT0wLTYsNjQtNzANCi0gUHJvY2Vz
c29yOiBBTUQgRVBZQyA5MzM0IDMyLUNvcmUgUHJvY2Vzc29yLCAyLjdHSHogKGJvb3N0IG9mZikN
Ci0gTWVtb3J5OiA0ODAwTVQvcywgIDQgRElNTQ0KLSBDb21waWxlcjogZ2NjIDE0LjINCi0gTklD
OiBDUURBMiBJbnRlbCBFODEwLCBmaXJpbXdhcmU6IDMuMjAsIEREUDogY29tbXMgMS4zLjUzDQot
IEFwcGxpY2F0aW9uOiB0ZXN0cG1kLCBJQ0VfMTZCX0RFU0MsIEFWWDUxMiBTSU1EIEJpdCBXaWR0
aA0KLSBTY2VuYXJpb3M6IGlvLCBtYWMtc3dwLCA1dHN3cA0KLSBUWC1SWCBkZXNjcmlwdG9yOiAy
MDQ4DQotIHBhY2tldCBzaXplIDY0Qg0KDQpEaWZmOiBNUFBzIDI1LjA3LXJjMSB2cyAyNS4wMyBm
b3IgYnVyc3Qgc2l6ZSAzMiwgNjQsIDEyOCwgMjU2LCA1MTINCisrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogLSBJTzogLTAuMjMsIC0xLjAyLCAtMi44
MSwgLTMuNDQsIC0yLjExDQogLSBNQUMtU1dQOiAtNS4wOCwgLTIuNiwgLTMuMjgsIC0yLjA3LCAt
Mg0KIC0gNXRzd2FwOiAtMi4zOSwgLTEuNzMsIC0xLjk1LCAtMS45LCAtMS45DQoNClJDLTI6DQoN
Ci0gdHVuaW5nIGd1aWRlOiBodHRwczovL2RvYy5kcGRrLm9yZy9ndWlkZXMvbGludXhfZ3NnL2Ft
ZF9wbGF0Zm9ybS5odG1sDQotIE9TOiBVYnVudHUgMjQuMDQuMiwgNi44LjANCi0gR3J1YjogZGVm
YXVsdF9odWdlcGFnZXN6PTFHQiBpc29sY3B1cz03LTYzLDcxLTEyNyBwcm9jZXNzb3IubWF4X2Nz
dGF0ZT0wIG5vaHpfZnVsbD03LTYzLDcxLTEyNyByY3Vfbm9jYnM9Ny02Myw3MS0xMjcgYW1kX2lv
bW11PW9uIGh1Z2VwYWdlc3o9MUdCIGh1Z2VwYWdlcz0xMiBpcnFhZmZpbml0eT0wLTYsNjQtNzAN
Cg0KLSBQcm9jZXNzb3I6IGJvb3N0IG9mZg0KVHVyaW46IEFNRCBFUFlDIDk3NTUgMTI4LUNvcmUg
UHJvY2Vzc29yLCAyLjcgR0h6KEJvb3N0IG9mZikNCkdlbm9hOiBBTUQgRVBZQyA5NjU0IDk2LUNv
cmUgUHJvY2Vzc29yLCAyLjQgR0h6KEJvb3N0IG9mZg0KU2llbmE6IEFNRCBFUFlDIDg1MzRQIDY0
LUNvcmUgUHJvY2Vzc29yLDIuMyBHSHooQm9vc3Qgb2ZmKQ0KTWlsYW46IEFNRCBFUFlDIDc3MTMg
NjQtQ29yZSBQcm9jZXNzb3IsMi4wIEdIeihCb29zdCBvZmYpDQoNCi0gTWVtb3J5Og0KVHVyaW46
IDY0MDAgTVQvcw0KR2Vub2E6IDQ4MDAgTVQvcw0KU2llbmE6IDQ4MDAgTVQvcw0KTWlsYW46IDMy
MDAgTVQvcw0KDQotIENvbXBpbGVyOiBnY2MgMTQuMg0KLSBOSUM6IENRREEyIEludGVsIEU4MTAs
IGZpcmltd2FyZTogMy4yMCwgRERQOiBjb21tcyAxLjMuNTMNCi0gQXBwbGljYXRpb246IHRlc3Rw
bWQsIElDRV8xNkJfREVTQywgQVZYNTEyIFNJTUQgQml0IFdpZHRoDQotIFNjZW5hcmlvczogaW8s
IG1hYy1zd3AsIDV0c3dwDQotIFRYLVJYIGRlc2NyaXB0b3I6IDIwNDgNCi0gcGFja2V0IHNpemUg
NjRCDQoNCkRpZmY6IE1QUHMgMjUuMDctcmMyIHZzIDI1LjAzIGZvciBidXJzdCA2NA0KKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCkNhdGVnb3J5OiBUdXJpbjogU2llbmE6IEdlbm9h
OiBNaWxhbg0KIC0gVGVzdFBNRCBJTzogMC41JSwgLTMuNiUsIDMuNyUsIC00LjklDQogLSBMM0ZX
RDogMC4wJSwgLTcuNCUsIC00LjglLCAtNC4zJQ0KDQoNCkNyeXB0bytITUFDIFBlcmY6DQorKysr
KysrKysrKysrKysrDQoNCmkuIEFFUy1DQkMtMTI4L1NIQTEtSE1BQyAoR2JwcynigK8NCmlpLkFF
Uy1DQkMtMTI4L1NIQTItMjU2LUhNQUMgKEdicHMp4oCvDQppaWkuQUVTLUdDTS0xMjgNCml2LkFF
Uy1DVFItQ2lwaGVyaW5nLUF1dGhlbnRpY2F0aW9uDQp2LkFFUy1DVFItQXV0aGVudGljYXRpb24t
Q2lwaGVyaW5nDQp2aS5BRVMtQ1RSLUNpcGhlcmluZy1FbmNyeXB0aW9uDQp2aWkuQUVTLUNUUi1D
aXBoZXJpbmctRGVjcnlwdGlvbg0KDQpWYXJpYXRpb24gaW4gQ3ljbGVzL0J1ZmZlcjoNCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCkdlbm9hQWxnb3JpdGhtLCBCdWZmZXIg
U2l6ZSAsIGN5Y2xlcy9idWYgdmFyaWF0aW9uIGZvciAzMiBidXJzdCBmb3IgMUMxVCwgMUMyVCwg
OEMxNlQNCkFFUy0xMjgtQ0JDLVNIQTEsIDI1NkIsIGxlc3MgdGhhbiAtMS41JQ0KQUVTLTEyOC1D
QkMtU0hBMSwgNTEyQiwgbGVzcyB0aGFuIC0xLjElDQpBRVMtMTI4LUNCQy1TSEExLCAxMDI0Qiwg
bGVzcyB0aGFuIC0xLjUlDQoNClR1cmluIEFsZ29yaXRobSwgQnVmZmVyIFNpemUgLCBjeWNsZXMv
YnVmIHZhcmlhdGlvbiBmb3IgMzIgYnVyc3QgZm9yIDFDMVQsIDFDMlQsIDhDMTZUDQpBRVMtMTI4
LUNCQy1TSEExLCA1MTJCLCBsZXNzIHRoYW4gLTIlDQpBRVMtMTI4LUNCQy1TSEExLCA1MTJCLCBs
ZXNzIHRoYW4gLTIlDQpBRVMtMTI4LUNCQy1TSEExLCAxMDI0QiwgbGVzcyB0aGFuIC0yJQ0K
