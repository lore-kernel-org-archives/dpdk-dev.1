Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CF5EB26ED
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 17:06:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C2A540689;
	Tue, 10 Feb 2026 18:06:19 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
 by mails.dpdk.org (Postfix) with ESMTP id 7251E4042F;
 Tue, 10 Feb 2026 18:06:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqQLqwlCxS0bqZtkqNhT7mQhiFX8fgKLEUS4Iy27U4y5J9eoYArpBCXf7X9peo16Vc8WiDs8nhjhTD8SuZ1ipL3T0HKhtopaHs0f5z5aHxyYRRfTl6YlxTXb1Ls0GliBxMBtgTtqeyYN7+kYH+6wfHjYrPiTZKQHRFdfNyxlAgqxX+gIILuOyQYumv7L3XxeqEiL5H0oU8vHOJAL4pEeGizvi05zBTePHwebHA+NxzwF9TnAWtfETcDAbmQBwzqlRThiZWAkfx9uTsdF3rq83QkEeAVkn+dJ+c6VQRSTkCW52xP5f0nfmKgr8xeVyI7AgSHzbxGJD63ER/89JWeEcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/pu16r19ixC7nFVWHjxIKnS2ioSBSKcviFRVdwrRik=;
 b=uOPUSHpkfGmgm2NWh7SP6dy3F2UJJRMq5r2hOaboPuWtNWGQYRghQd48r2wFO8+U5pp67Qkldcch2wT+ptMMUrns9NKzX3zCckziSNimK2GcskcVBDLVqsgnGSUd57I4VEnvzRwGS/ixSs1OcQ9JwxKd9lAen9d3Wrfmd18f2PSvCOS7OOaJZQsVFtLSj6UBzPViEFVYYITgE+TaDB0EFnw1Tc6YwuD4gPVy4++65ZiHBIvChOFhGvjLM31g56MPNJT/yxi8r4VHDhbrZQHFbEge7hmZ1SFhHJz7oDfbjdV7SOfTsxT+jytMcbXMYggSm0RxJa6C8hXJRVsn3saV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/pu16r19ixC7nFVWHjxIKnS2ioSBSKcviFRVdwrRik=;
 b=Nq6q3fbmv4qaF//mfp3sKXj0fMYk6BcpPvx8XxO6V0MB83wgYyyDUTGwKrGd/S9sKbZ3taUZ/MQv1AfCTKc1T44rUf3SRwzhhJJ4x/CcfXqXRRmG49ROaI9a5tMXxcQLZvKL6B/AD33Ua84AaLCSMM5NeCJmVnv2OTc0ZstuIKdbTsibN6Mkp3apeWYbxQ29jYrX5qn1BrTwR5b1fUoPnsSUAG2UaoTH+FnF1/V65f6ZjMduBHPrY8r/9Y1egODMBPUmbBrGlAiVp/YPU7sZaIu+NG1CihAxfc7v5CCs03gy+BKGNUM7KI8VNQNei2QQuZ+r5nBTXSDp+n1CJHIf5Q==
Received: from DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) by
 DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8; Tue, 10 Feb 2026 17:05:05 +0000
Received: from DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3]) by DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3%4]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 17:05:04 +0000
From: Slava Ovsiienko <viacheslavo@nvidia.com>
To: Kevin Traynor <ktraynor@redhat.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, "david.marchand@redhat.com"
 <david.marchand@redhat.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2 1/2] net/mlx5: check for no data read in devx interrupt
Thread-Topic: [PATCH v2 1/2] net/mlx5: check for no data read in devx interrupt
Thread-Index: AQHcl40HC8zIzsLD9Eu2R7IjVtLJa7V2wZSAgAVM1ICAAB30AA==
Date: Tue, 10 Feb 2026 17:05:04 +0000
Message-ID: <DM4PR12MB60872D62FD8A3616C69E7BFCDF62A@DM4PR12MB6087.namprd12.prod.outlook.com>
References: <20260128122055.192104-1-ktraynor@redhat.com>
 <20260206172054.273858-1-ktraynor@redhat.com>
 <20260206172054.273858-2-ktraynor@redhat.com>
 <20260206220939.5a90c67c@phoenix.local>
 <dd9faf73-b153-42b8-a42c-418bf22fe1f6@redhat.com>
In-Reply-To: <dd9faf73-b153-42b8-a42c-418bf22fe1f6@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6087:EE_|DS0PR12MB8786:EE_
x-ms-office365-filtering-correlation-id: ec49cd57-1c95-48ed-f6f3-08de68c6893a
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7142099003|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?cUw3MkNuUU1wMlo5NmxZajk3L2lLelliMWdBRFRBSjBwODNTVXpJKy9DSkRM?=
 =?utf-8?B?TVoyaXhLaElQbWV5MjRZTXVyZ2hzRmpTaEFIUElkc3FTRDRJaHNJUDZiN25m?=
 =?utf-8?B?UDhsZ0VVYjJNWlRHeVZ0em9NcWRzOG9GaVpvSEVjWFFNN1AwQmhPMnRVeGpL?=
 =?utf-8?B?UDNsN2RiT3NwN1dGeHlSMTBrdERJYzBURDNrWnl3RFNvaEZqUzgzMVk3RU5l?=
 =?utf-8?B?a0wrd04yRHZ4YXhzWTZvRk4yVjdUMDB0VTRCdk5nVG4yM3VEQS83ZVh3UG1p?=
 =?utf-8?B?MmRSZGMwcFhNV3gwTzJtK0U0a0laRm9NQnJMVjg2blFSc1dJSEp1a3FJbFIy?=
 =?utf-8?B?L1hscENyQSt1ejRvZ1ZnNU42WU93c1ROSWZobzY3ajBuZklqZVM0aVJRVFJj?=
 =?utf-8?B?bGxsSDJ5bWFaQUdGRmpyUjBlSXJsSmpWeWpRdVozdkVIZjVYU280V3pLQm9C?=
 =?utf-8?B?ZWhiMEZXRnlReUZyVllYTUUrMU9LVUxUVExIRU41SndJNldXbmlJdnNPYWdj?=
 =?utf-8?B?LzNKMlFneTRHSGlpdjRQZnRvZkYxYkhsZWNlaFZIZHk0bTZxYWU4T2FLZkov?=
 =?utf-8?B?RDhBQ29XTHcybDRacVR6eEd0cHU5MWc3RXB4aG96cDJmL096TGx4b3pWVXFz?=
 =?utf-8?B?T0VFZjdXSE1EMXdqaE9kdVJtQWZpbkdNYS9RL3p0K1RvRTk1NWJlMnFtZU9p?=
 =?utf-8?B?Rlc0bzN6WFVZZUhyN25vL09vRWVHMSs5bS9LU3RTVG55ZjFjQS9JTzZTRitk?=
 =?utf-8?B?NzJoU2NIbGFEZndTYXJIQjdIUUZTZHRyaldNTWdBLzB3YUE3Ty9RcERQellF?=
 =?utf-8?B?V1pFbTI5bE4rdFNCc3VzODlEZFBoZkQySGJOZzdvN3htQk96b1cxa01wZVRX?=
 =?utf-8?B?YUJYZnpUcmdLWGVxOUMxUUFYMGxrdWxFazFOZHBmWUFEMEJKQWQza1BFdi94?=
 =?utf-8?B?cE1zVENrTXQ3dXVoVkU4eW1WeTNBRUdTWlhnZncwL3htVi81NktEeXc5Ykc1?=
 =?utf-8?B?Mzk3a3lPOCtNQUYwbnR6RzJhN3VGS0ZuWXlvREFXMHNpd2tSUjY2NHpUa1dq?=
 =?utf-8?B?dUltM0hndnQ3Z3dMKzFOcnF6WDF3N1ZGTnYzWlFxbHVYYmJrS0hzUXc3NzNy?=
 =?utf-8?B?ZkdTRTZBQjhBTEd2UTB0RXhUUVZwWlNyakJ3anNUZUZFN25HRXBvR1BaN0tz?=
 =?utf-8?B?SVJUQ3FpMVkyMi9ZNTEyUjUvRVcwT1dxelRZbCtTMVNIditsUmJJMXNJemVU?=
 =?utf-8?B?alJzanM1cGIzWnhQOGxjbmFkaldrWFRnQUpuTmpvNGVzS01CYjBncDNKT2FN?=
 =?utf-8?B?dHZ3Z09VbGhNZUR6cGJBV3hPL0VwR1NNdURoeStRZEJJOXJHVGJadkFVRkNW?=
 =?utf-8?B?UXJjQ3piMUExcEhXZjFTSjY4Z1dFamk2WmZFdjhMTEljSks0MGltSGJVRW5w?=
 =?utf-8?B?NGpJRVRMRE9ueUpPQy9BM240eUR3SXlTTHQ2SnZpeWRmaEorSHgvTXB2Tm9x?=
 =?utf-8?B?RkkxQXRJMnh4a0toVSs3NVNFcVJZYVhTclhTSElLcWY2T3lTbXVUN2VwTUF5?=
 =?utf-8?B?MTd2VFRBYjIrdFB4andpN0tXZ2RxTU1wekpyMk1VSjU2ZEFSQVgxSGhRdVpq?=
 =?utf-8?B?SDJJSzlxTUU4VDFLSEdmbVFpOGRGTnRpcTFxa0tpa20zRjNDNnZCT2dRd1hF?=
 =?utf-8?B?dGorbTBNem8wS05ZRlppVmFoOUlxbWJUV2paYk1pNXdMK1lYRFpIc1BWV1g5?=
 =?utf-8?B?UTA0N2hJSTVVSlltcXhJUWhmeGRJWm9maTRWOFMxYXU2Z09za2c0ZENRMnk2?=
 =?utf-8?B?ejd4OGxPZzNsTDlJUm92RHNvOFcxZzFqbDBkdWgxWEErOHRkdDdiRmNRL1R0?=
 =?utf-8?B?bnRZaHBZVmI5Zjd6RFhobEtiY2FVaG00Q0NqQVBpeEg1Vzg0a2R5aENZeVFZ?=
 =?utf-8?B?aitJN2RxUEpjbkdBanNwR2NSK2twOUhrZkJucGJxYVR2UmhJMmgvNkpsYVdZ?=
 =?utf-8?B?RWRNaDZ0R0Vnb0dlYnBnRTZVUHQ1ZFRhdFVybCtJM3pralVPRS83cEZKeWQr?=
 =?utf-8?B?c01ZSkZMbWxWTmJYN096dzVUWTJyeUtxUmQ4VlUxbktmSG94d1pZZlBKMVlB?=
 =?utf-8?B?bG9UNGc2MEFUbmdJWTZ5QUxSNEVqNzlwc1FxVFUxWXZGR0ZBR0I4K0ttaEk5?=
 =?utf-8?Q?Bz7rObcqz/w94Ut1EaJMstg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6087.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7142099003)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djhPdCtzSVRUWENEL1Z6RXh5ZnI5VlA3VHVyVFBpOVlQOERhQ05EdHh2NURk?=
 =?utf-8?B?SHVyckpWbXpzQ3lLZ1BQdXNVRUZ4cy82WkFhSnNnOWRYdCtLQW1PclM0bnh3?=
 =?utf-8?B?QUxRRFJiQS9GaXBXV28xWEl2L1pjUUhzeHYwN0NGekkxbnZpUEx4dXlySEtE?=
 =?utf-8?B?d0xoQkw3eEt3a0VGanFCVEZ3UU11U1FvMTVKSCtWdmdGMFk3Q0RIK0tvTGhh?=
 =?utf-8?B?QnRxN3Fhc1JaWUVwbTJmWmFDMzZoQzZISDlaTHlKcU4xMDN0aFVwaXhoZSt1?=
 =?utf-8?B?RzR5dHJLKzN2aWtwamhMdW9TcEJSMGg3VTJreGFZUDFrSTNLT3hvdFhhcVJh?=
 =?utf-8?B?TWVER2tXYkNNN1h5Ry90OGZXYjFuNVVWdjdvUFZveEdyMzFsWnllWjBZb0lE?=
 =?utf-8?B?ZGloK0JHcG9QVE9Sb05CQmJkT0NvRk43ODBnVGxoNW9mSjhwWlNCblFXdU9q?=
 =?utf-8?B?bHNGWTFHdVI2blJtbzhxUzlpTCtjYklPbUwyK1JiSmxNVkg5WjJualZMQ0hv?=
 =?utf-8?B?azRJU3lXeFR6bFdSWm9lSVl0aVY3ZC9PMTVwa2tnQ0V3bXRaQ1Z5c2s0L0xi?=
 =?utf-8?B?YUtNWWs0Y3ZKaEdIZEVMTW5tcG5McDQvWGZhaExES1U3YjNhT2s2MEkzVm5W?=
 =?utf-8?B?dFZYczVNanlNUm5tOTZIeE5hRWU5anlqTWdaa2N2VDIvdFcrbEg1Nnk3bFVh?=
 =?utf-8?B?ODF5Z1BKTUVvSnFELzgrc2IzdWY5Rnh6MVJIYThqSGRnNEg4SVlFQmE5Y1Zo?=
 =?utf-8?B?VEl0RHR6NmxDL1l0SnRXb1VRUUx6ZmdJZlE2RGM0Q0xvOEd1THdOSFdnRmJ5?=
 =?utf-8?B?Ui82WjJEaUppcnlxTWMxSS9XN0NXS0lCajVQZHZVWW8rRk53YThKVmNDTGEv?=
 =?utf-8?B?QnJSOEVza0NHOURIdHRLeVF4dnk0UXdBWEFOTGYwaUJCaW1uVzFodUFWWUpp?=
 =?utf-8?B?WmhRZEhhM3hYdUtwN0NVOGFlYUFDTzc0N0pMNDMzZ3lWZWMrclZHYVAvMW1h?=
 =?utf-8?B?K2tIdmQ2MDBzM3RHS0Q2NFlvWlY1amJkdnNxK2xaV29xNVlLV2NHVnBmK1lC?=
 =?utf-8?B?M0NsMjdTMkNkSjhDdWI1TjNlaFRnSEg5clkrb3h3M1ZCUlFJTjM0azN3cVZT?=
 =?utf-8?B?NTV6SjhkZkNZMkxIVks4dHZXTkx5L1llamdpenhtVWlNTk93QjZUR1VCZzBl?=
 =?utf-8?B?b2l6M3A5bzRoWktUVVFLb3hHK3ZxRE1EV3dodGRvdUlBUnZKRGFTcW5lYVZU?=
 =?utf-8?B?ZGVIT09ZK1ZSNy9VZmhsenR6RG1LakdLRVErSkQwbC9DeEJZN0NXOElJQmxr?=
 =?utf-8?B?cURpOEhZRWFBeUR5QWw0RWh6WkZuaFhvdnJTVzUrckJ5dy96ekxYUkY0c3Vu?=
 =?utf-8?B?ZmRuN0ZwVnpJYlc4OWppOXZEVHkwSEozNlF1TEJIcDBCSktqSkVNZ3o2VWFR?=
 =?utf-8?B?dHlBNEJMM1Z2NUpoOWhTVVBPVlYramFSaDhGV0pjY1FzazlHWmUzTkhaUFp0?=
 =?utf-8?B?TVlQRDExaDdESlhCVFFrcUlPQWdzRnl4VThmUDNNY29aMkR5UUFHQ2d6dVF1?=
 =?utf-8?B?YU5vK0loVEVwbHh4Ykk1YWMvaEdsZlR4N0Zwc05VcUF2eFVMRUpPSHZwcG9a?=
 =?utf-8?B?b2VIZUFPOXo1Ui8zUHhhUkExZ0pCMERQbzF6UUV3R0FUVTJSNFBEam9NeEdD?=
 =?utf-8?B?a1l5STNNc2MzeDM2TVZZVm11MEZCckZSSnFEOXN5ZFlwdDkrbXNaeWVSRE5Y?=
 =?utf-8?B?OVBHY0x0MGhkQUM4OVhXTGdPY1JqRnhiWlQ1aDZOTWtRR3k5MW16cU5QNFNV?=
 =?utf-8?B?TVNYQ3RFR3ZsZWV1MUEzWXNmVVJVd1ZDMUhqWjRyc1hPUlkrWjBQeUJGS29r?=
 =?utf-8?B?QXlPN1gxSFQrZzcyRkpIZEdydjg3MnJFK05Jb2w0QngweGlzN0ZVUElYaXJl?=
 =?utf-8?B?eTUxK0ovTXBHWlVyQ2w4S2o2VlhDTzlOekZRYzBlTkFkcFAxOVVKdGhkZzlZ?=
 =?utf-8?B?ODVScDZxLzh2eGZhK2tBSG84SWpKMFpqNkVQSzcvazRwWXk2SnJCcnNINDBv?=
 =?utf-8?B?OXZvS1NqbjdiMUgya1pmbitVcHB6SlQ4TldxUDk3QmcwMmJMa2kzTkRDMFYr?=
 =?utf-8?B?c2l1V09kOStWc1BhbC9KZFRUQ3gza1FsNEVBSXN6RVRMUnFDL0taanl0cnRX?=
 =?utf-8?B?dW1aZHNsRE1lZ1FSVndqSXhtbzBxVGRWWVBqVy83WFBNN0tYQzVMQ0xnem1N?=
 =?utf-8?B?SGt6YVZQb1hHQmtzUUtTZXJTQXUxQ3lYNGhrNDhiUGs4TmczejRhdmpvWXJi?=
 =?utf-8?Q?CZwsEkKbELfggVAhSi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec49cd57-1c95-48ed-f6f3-08de68c6893a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 17:05:04.8154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QAURAEF8ZNeioS86QalgWCT+0R9VI7mAKKVPQ7lE4kemsXq6+Z+G77PS9vtiB0Ce8XJdvMpnVwF2JGsqDzd4sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786
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

SGksDQoNCkknbSBzb3JyeSwgSSBoYXZlIHNvbWUgY29uY2VybiBhYm91dCB0aGUgcGF0Y2guDQoN
CkhvdyBpdCB3b3JrcywgYXMgZmFyIGFzIEkgdW5kZXJzdGFuZDoNCg0KLSBEUERLIHNpbXVsYXRl
cyBpbnRlcnJ1cHRzIGluIHVzZXIgbW9kZSB3aXRoIGVwb2xsX3dhaXQoKQ0KLSBtbHg1IFBNRCBl
bWl0cyB0aGUgYXN5bmMgY291bnRlciBxdWVyeSBjb21tYW5kIHRvIHRoZSBOSUMgcGVyaW9kaWNh
bGx5IA0KLSB0aGVyZSBtaWdodCBiZSBtdWx0aXBsZSBhc3luYyBxdWVyeSBjb21tYW5kcyBpbiB0
aGUgZmxpZ2h0DQotIGtlcm5lbCBkcml2ZXJzIGhhbmRsZXMgdGhlIGFzeW5jIHF1ZXJ5IGNvbXBs
ZXRpb24gaW50ZXJydXB0cywgcHVzaGVzIHRoZSB0b2tlbiB0byB0aGUgaW50ZXJuYWwgY29tcGxl
dGlvbiBxdWV1ZSBhbmQgdW5ibG9ja3MgYXNzb2NpYXRlZCBmZA0KLSBlcG9sbF93YWl0KCkgc2Vl
cyB0aGlzIHVuYmxvY2tlZCBmZCBhbmQgbm90aWZpZXMgbWx4NSBQTUQgYWJvdXQNCi0gbWx4NSBQ
TUQgcmVhZHMgdGhlIGNvbXBsZXRpb24gdG9rZW4gZnJvbSB0aGUga2VybmVsIHF1ZXVlIHdpdGgg
ZGV2eF9nZXRfYXN5bmNfY21kX2NvbXAoKQ0KDQpUaGUgY29uY2VybiBzY2VuYXJpbywgbGV0J3Mg
YXNzdW1lOg0KDQotIHdlIGhhdmUgMiBhc3luYyBxdWVyeSBjb21tYW5kcyBpbiB0aGUgZmxpZ2h0
DQotIHRoZSBmaXJzdCBhc3luYyBxdWVyeSBjb21wbGV0ZXMsIGZkIGlzIHVuYmxvY2tlZCwgUE1E
IGlzIGludmlrZWQsIHRoZSBjb21wbGV0aW9uIGlzIHJlYWQgYnkgUE1EIGFuZCBpcyBiZWluZyBo
YW5kbGVkDQotIHRoZSBzZWNvbmQgYXN5bmMgcXVlcnkgY29tcGxldGVzLCBmZCBnZXRzIHVuYmxv
Y2tlZCwgdGhlIHNlY29uZCB0b2tlbiBpcyB3cml0dGVuIHRvIHRoZSBxdWV1ZQ0KLSB0aGUgUE1E
IGNvbXBsZXRlcyB0aGUgaGFuZGxpbmcgb2YgdGhlIGZpcnN0IGNvbXBsZXRpb24gYW5kIHJlYWRz
IHRoZSBxdWV1ZSBhZ2FpbiAod2l0aCBkZXZ4X2dldF9hc3luY19jbWRfY29tcCgpIGNhbGwgaW4g
dGhlIGxvb3ApDQotIGl0IHJlYWRzIHRoZSBzZWNvbmQgdG9rZW4gc3VjY2Vzc2Z1bGx5IGFuZCBo
YW5kbGVzDQotIHRoZW4sIG9uIHRoZSB0aGlyZCBjYWxsLCBkZXZ4X2dldF9hc3luY19jbWRfY29t
cCgpIHJldHVybnMgRUFHQUlOLCBpdCBtZWFucyBxdWV1ZSBpcyBlbXB0eQ0KLSBEUERLIGNhbGxz
IGVwb2xsX3dhaXQoKSBhZ2FpbiBhbmQgc2VlcyB1bmJsb2NrZWQgZmQNCi0gaXQgY2FsbCBtbHg1
IFBNRCwgYW5kIGl0IGNhbGxzIGRldnhfZ2V0X2FzeW5jX2NtZF9jb21wKCksIGJ1dCBxdWV1ZSBp
cyBlbXB0eSAoaGFuZGxlZCBpbiBwcmV2aW91cyBpbnRlcnJ1cHQgaGFuZGxpbmcpDQotIHdpdGgg
dGhlIHBhdGNoIHdlIHdyb25nbHkgcmVtb3ZlIHRoZSBoYW5kbGVyIA0KDQpJbiBteSBvcGluaW9u
LCB3ZSBzaG91bGQgaGFuZGxlIGZsYWdzIEVQT0xMRVJSIHwgRVBPTExIVVAgfCBFUE9MTFJESFUg
ZnJvbSB0aGUgZXBvbGxfd2FpdCgpX3JldHVybiBhbHNvIGZvcg0KUlRFX0lOVFJfSEFORExFX0VY
VCBhbmQgUlRFX0lOVFJfSEFORExFX0RFVl9FVkVOVCBpbnRlcnJ1cHQgdHlwZXMuDQoNCldpdGgg
YmVzdCByZWdhcmRzLA0KU2xhdmENCiANCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogS2V2aW4gVHJheW5vciA8a3RyYXlub3JAcmVkaGF0LmNvbT4NCj4gU2VudDog
VHVlc2RheSwgRmVicnVhcnkgMTAsIDIwMjYgNTowNiBQTQ0KPiBUbzogU3RlcGhlbiBIZW1taW5n
ZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiBDYzogZGV2QGRwZGsub3JnOyBOQlUt
Q29udGFjdC1UaG9tYXMgTW9uamFsb24gKEVYVEVSTkFMKQ0KPiA8dGhvbWFzQG1vbmphbG9uLm5l
dD47IGRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb207IERhcml1c3ogU29zbm93c2tpDQo+IDxkc29z
bm93c2tpQG52aWRpYS5jb20+OyBTbGF2YSBPdnNpaWVua28gPHZpYWNoZXNsYXZvQG52aWRpYS5j
b20+Ow0KPiBzdGFibGVAZHBkay5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzJdIG5l
dC9tbHg1OiBjaGVjayBmb3Igbm8gZGF0YSByZWFkIGluIGRldnggaW50ZXJydXB0DQo+IA0KPiBP
biAwNy8wMi8yMDI2IDA2OjA5LCBTdGVwaGVuIEhlbW1pbmdlciB3cm90ZToNCj4gPiBPbiBGcmks
ICA2IEZlYiAyMDI2IDE3OjIwOjUzICswMDAwDQo+ID4gS2V2aW4gVHJheW5vciA8a3RyYXlub3JA
cmVkaGF0LmNvbT4gd3JvdGU6DQo+ID4NCj4gPj4gQSBidXN5LWxvb3AgbWF5IG9jY3VyIHdoZW4g
dGhlcmUgYXJlIEVQT0xMRVJSLCBFUE9MTEhVUCBvcg0KPiBFUE9MTFJESFVQDQo+ID4+IGVwb2xs
IGV2ZW50cyBmb3IgdGhlIGRldnggaW50ZXJydXB0IGZkLg0KPiA+Pg0KPiA+PiBUaGlzIG1heSBo
YXBwZW4gaWYgdGhlIGludGVycnVwdCBmZCBpcyBkZWxldGVkLCBpZiB0aGUgZGV2aWNlIGlzDQo+
ID4+IHVuYm91bmQgZnJvbSBtbHg1X2NvcmUga2VybmVsIGRyaXZlciBvciBpZiB0aGUgZGV2aWNl
IGlzIHJlbW92ZWQgYnkNCj4gPj4gdGhlIG1seDUga2VybmVsIGRyaXZlciBhcyBwYXJ0IG9mIExB
RyBzZXR1cC4NCj4gPj4NCj4gPj4gV2hlbiB0aGF0IG9jY3VycywgdGhlcmUgaXMgbm8gZGF0YSB0
byBiZSByZWFkIGFuZCBpbiB0aGUgZGV2eA0KPiA+PiBpbnRlcnJ1cHQgaGFuZGxlciBhbiBFQUdB
SU4gaXMgcmV0dXJuZWQgb24gdGhlIGZpcnN0IGNhbGwgdG8NCj4gPj4gZGV2eF9nZXRfYXN5bmNf
Y21kX2NvbXAsIGJ1dCB0aGlzIGlzIG5vdCBjaGVja2VkLg0KPiA+Pg0KPiA+PiBBcyB0aGUgaW50
ZXJydXB0IGlzIG5vdCByZW1vdmVkIG9yIGNvbmRpdGlvbiByZXNldCwgaXQgY2F1c2VzIGFuDQo+
ID4+IGludGVycnVwdCBwcm9jZXNzaW5nIGJ1c3ktbG9vcCwgd2hpY2ggbGVhZHMgdG8gdGhlIGRw
ZGstaW50ciB0aHJlYWQNCj4gPj4gZ29pbmcgdG8gMTAwJSBDUFUuDQo+ID4+DQo+ID4+IGUuZy4N
Cj4gPj4gZXBvbGxfd2FpdA0KPiA+PiAgICAoNiwgW3tldmVudHM9RVBPTExJTnxFUE9MTFJESFVQ
LCBkYXRhPXt1MzI9MjgsIHU2ND0yOH19XSwgOCwgLTEpID0NCj4gPj4gMSByZWFkKDI4LCAweDdm
MWY1YzdmYzJmMCwgNDApDQo+ID4+ICAgID0gLTEgRUFHQUlOIChSZXNvdXJjZSB0ZW1wb3Jhcmls
eSB1bmF2YWlsYWJsZSkgZXBvbGxfd2FpdA0KPiA+PiAgICAoNiwgW3tldmVudHM9RVBPTExJTnxF
UE9MTFJESFVQLCBkYXRhPXt1MzI9MjgsIHU2ND0yOH19XSwgOCwgLTEpID0NCj4gPj4gMSByZWFk
KDI4LCAweDdmMWY1YzdmYzJmMCwgNDApDQo+ID4+ICAgID0gLTEgRUFHQUlOIChSZXNvdXJjZSB0
ZW1wb3JhcmlseSB1bmF2YWlsYWJsZSkNCj4gPj4NCj4gPj4gQWRkIGEgY2hlY2sgZm9yIGFuIEVB
R0FJTiByZXR1cm4gZnJvbSBkZXZ4X2dldF9hc3luY19jbWRfY29tcCBvbiB0aGUNCj4gPj4gZmly
c3QgcmVhZC4gSWYgdGhhdCBoYXBwZW5zLCB1bnJlZ2lzdGVyIHRoZSBjYWxsYmFjayB0byBwcmV2
ZW50IGxvb3BpbmcuDQo+ID4+DQo+ID4+IEJ1Z3ppbGxhIElEOiAxODczDQo+ID4+IEZpeGVzOiBm
MTVkYjY3ZGYwOWMgKCJuZXQvbWx4NTogYWNjZWxlcmF0ZSBEViBmbG93IGNvdW50ZXIgcXVlcnki
KQ0KPiA+PiBDYzogc3RhYmxlQGRwZGsub3JnDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEtl
dmluIFRyYXlub3IgPGt0cmF5bm9yQHJlZGhhdC5jb20+DQo+ID4NCj4gPiBBSSBzcG90dGVkIHRo
aXMsIEkgZGlkbid0Li4uDQo+ID4NCj4gPg0KPiA+IEVycm9yczoNCj4gPg0KPiA+ICAgICBMaW5l
IDEzOTogVW5uZWNlc3Nhcnkgc2VtaWNvbG9uIGFmdGVyIGNsb3NpbmcgYnJhY2UNCj4gPg0KPiA+
IGMNCj4gPg0KPiA+ICAgIH07DQo+ID4NCj4gPiBTaG91bGQgYmU6DQo+ID4gYw0KPiA+DQo+ID4g
ICAgfQ0KPiA+DQo+ID4gICAgIExpbmVzIDE0Mi0xNDY6IEJsb2NrIGNvbW1lbnQgdXNlcyBpbmNv
cnJlY3Qgc3R5bGUgQmxvY2sgY29tbWVudHMgaW4gQw0KPiBjb2RlIHNob3VsZCB1c2UgLyogYW5k
ICovIHN0eWxlLCBub3QgLyoqIHdoaWNoIGlzIHJlc2VydmVkIGZvciBkb2N1bWVudGF0aW9uDQo+
IGNvbW1lbnRzLg0KPiA+DQo+ID4gYw0KPiA+DQo+ID4gICAgLyoqDQo+ID4gICAgICogbm8gZGF0
YSBhbmQgRUFHQUlOIGluZGljYXRlIHRoZXJlIGlzIGFuIGVycm9yIG9yDQo+ID4gICAgICogZGlz
Y29ubmVjdCBzdGF0ZS4gVW5yZWdpc3RlciBjYWxsYmFjayB0byBwcmV2ZW50DQo+ID4gICAgICog
aW50ZXJydXB0IGJ1c3ktbG9vcGluZy4NCj4gPiAgICAgKi8NCj4gPg0KPiA+IFNob3VsZCBiZToN
Cj4gPiBjDQo+ID4NCj4gPiAgICAvKg0KPiA+ICAgICAqIG5vIGRhdGEgYW5kIEVBR0FJTiBpbmRp
Y2F0ZSB0aGVyZSBpcyBhbiBlcnJvciBvcg0KPiA+ICAgICAqIGRpc2Nvbm5lY3Qgc3RhdGUuIFVu
cmVnaXN0ZXIgY2FsbGJhY2sgdG8gcHJldmVudA0KPiA+ICAgICAqIGludGVycnVwdCBidXN5LWxv
b3BpbmcuDQo+ID4gICAgICovDQo+ID4NCj4gPiBXYXJuaW5nczoNCj4gPg0KPiA+ICAgICBMb2dp
YyBjbGFyaXR5OiBUaGUgdmFyaWFibGUgZGF0YV9yZWFkIGlzIHNldCB0byB0cnVlIGluc2lkZSB0
aGUgd2hpbGUgbG9vcCBidXQNCj4gbmV2ZXIgY2hlY2tlZCB3aGVuIGRhdGEgV0FTIHJlYWQuIENv
bnNpZGVyIGlmIGRhdGFfcmVhZCBpcyB0aGUgY2xlYXJlc3Qgd2F5IHRvDQo+IGV4cHJlc3MgdGhp
cyBjb25kaXRpb24uDQo+ID4NCj4gDQo+IEFjayBhYm92ZS4gVGhhbmtzLldpbGwgYmUgZml4ZWQg
aW4gdjMuDQoNCg==
