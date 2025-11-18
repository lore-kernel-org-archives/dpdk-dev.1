Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87E9CED63B
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 12:43:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B69B440265;
	Tue, 18 Nov 2025 13:43:17 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010071.outbound.protection.outlook.com [52.101.56.71])
 by mails.dpdk.org (Postfix) with ESMTP id CC6B140150
 for <dev@dpdk.org>; Tue, 18 Nov 2025 13:43:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEpcIMQw9bpB+sko2trhkuSCfcC1xkGpVPmX2P0ZmfoalvCAZWxJ+oM83sO0a1FCZF59j5Vv6EGMw08EyfXzGkR/FIa4qrfvS6u6JmkERmTqmugIuAa4S/6gP74vRilsNYA46ZAYdyHkqDboz2eXzoKdl0QwtAsmECNgy5H6EwHDm7M2RXF2bUbqn/YbADhXi2pDI2KYxbVV5cgS9AsMLiQCy9kQG5A3MNLbBJ+5rAmRa8rbQgR2O4G/t+FksWgasiS0Cu5hV81KyxFS+DDG7y1IJukJwj5R2LjvXJ+b9h652GFwQtjzQXdSXhsbWyccx3z667z1bzLrOnF4KMWEjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfAybjkoGjn9Al+YxQqua7KhbvV/mvlysUjiJB6+K6Y=;
 b=kJVVQwD1VuxDkulArnN061wpfrR5l7YuxOa2tVf4XakvH0snCfGP+l3VCQ+EYe6mAGWngcaZ/OdzJKHGtuoNhAB7D2t1ZleCUM4X/AJzG95MZkfSMOGjpJertLYu/sUctsAdon+azEORrl+tUbwI6AjfgSr+/e4+UW6mb0SkcUq3F6bxxJBD0IFb4KpJv5irZOJIUlSk9b7DDsS9/w+RC60AY6Rc8r7H3nFW8Z+p3um4XPU/+vnA+IxvF2o751AvUgIJX1zVS9bYbxqm8AmM2IMYIdfzH7U3v5+gOnawnKOG108BFUHXPNBnDsjPxCtedy/yfwkfDS6/0hMVOI2a8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfAybjkoGjn9Al+YxQqua7KhbvV/mvlysUjiJB6+K6Y=;
 b=kEuNDO0Ds7MB2bjfkazQ5CoHV4Wy7bgVibGvJOVW0zd0/G2uHIaRK2IqyzQjCjh3tiLuxS/P4A6s6JEXVZuW6fQUmoxDHkZZF37h69rXEQWivhb7YbR2lldqEwhkDSuXD4fM71P3p4oJ+l+TNaCeSGSWRSnLXJQM//vrvCWHYMWgC+Pu6Z+jA8drS6fjemdu7NN1/7LJF4SbvieRp+2JkTN7BOZ4N6waZMkpTrl9DP0J6zd74S/dXZ7UTp3RKFoNLRuIyEqEm3WSw4DjbVhQQkunZpKgMw0nzRVVMpfk6FSquK5XTirGTiUmcDUl2pzIQM2M+VJLLMKOJ7a3FsGaPQ==
Received: from CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7)
 by SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 12:43:12 +0000
Received: from CYXPR12MB9279.namprd12.prod.outlook.com
 ([fe80::aa7d:edea:74dd:3301]) by CYXPR12MB9279.namprd12.prod.outlook.com
 ([fe80::aa7d:edea:74dd:3301%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 12:43:12 +0000
From: Wisam Jaddo <wisamm@nvidia.com>
To: Bing Zhao <bingz@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
CC: Ori Kam <orika@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
Subject: RE: [PATCH] test-flow-perf: support measuring 2nd round rate
Thread-Topic: [PATCH] test-flow-perf: support measuring 2nd round rate
Thread-Index: AQHcV5QaizmwsHbFGUWe8Eeid5Ynt7T4Ye4A
Date: Tue, 18 Nov 2025 12:43:12 +0000
Message-ID: <CYXPR12MB9279C98B3567E1DEA4E70A92A4D6A@CYXPR12MB9279.namprd12.prod.outlook.com>
References: <20251117073008.9344-1-bingz@nvidia.com>
In-Reply-To: <20251117073008.9344-1-bingz@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR12MB9279:EE_|SA3PR12MB8812:EE_
x-ms-office365-filtering-correlation-id: 2210ee92-1a7b-48b6-1a8f-08de26a00905
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?N05xYjEzd2l4WXR2dXV5eHd1SHFzUDF5aERBQ0U5QmFLNUp6ejZ6TDJqOWNL?=
 =?utf-8?B?NHJUMGlvQjlaMjUvUmFYdXIvRnVXeGFEajJZMmZuQTU0NlpyK1RDNnZwMXQ1?=
 =?utf-8?B?Q2FiQWZncGs3Z1RxQk4rbjdXYUcydnFOYWRhaFpKTVljSllyQ1BRSW5ldG40?=
 =?utf-8?B?V1Z1Z3VFMGg2Yi9laWlUblB1bHVwMGtjdDVvVko1U1ErSkRDRko1N3g4Ymlo?=
 =?utf-8?B?RHhmTUltYWxIMlowSExkV2dxKytXZGVPNDdwYVdiVFhKNDY2VytKWWQycGt6?=
 =?utf-8?B?RUY0L2RLU0w5RVAzb0c1S3NKK3dHOVNWeUhWRml5SlNXYVlDT1g0dVBONG9u?=
 =?utf-8?B?TjFHUTMrRVp1NDFhNFA5alNmRnVUOGdLcmNvODk3U1ZGMUY5VC8rSWFJR0M0?=
 =?utf-8?B?Ynl6d09Cc2kwalBnWEZvb0RtTmp4c2xEUEVtcFFFRkV2RFU1dCtIaGNPaElW?=
 =?utf-8?B?dENSK2pVNzBvOUI2T3NLVVNaYlhzZWFTMTVIc01sYXMralRmNjFjVnFQaDJL?=
 =?utf-8?B?WFdKNjBTREltbFE1ZU92QXNCWUtFZDVNM091NWFTVXhkUytBY21pdzJlZjdM?=
 =?utf-8?B?RnJaUC9ZZThzZFhLaXZEQlZscHdEK1JEeHR0T0pKMW9vVFNWT2lmKzhTZGJL?=
 =?utf-8?B?WVUvRCt2SWhSdkp2QUlsZTd2UWYzNXRkM250aFJHd3NQQ1p0elBCUUxwRzNz?=
 =?utf-8?B?cGlBUWJyRFlpbCt5dk1weEk3eXRYWVlqWGNwbHlESVRJNEIrRWlUeFVIdVMw?=
 =?utf-8?B?RG51cnZpdURHUDB3anhmZk16ejJ1ZXdKMmdZZll4NkxPU1N2Rlh0czJZLzg4?=
 =?utf-8?B?OEM4YUxiZFZ6SE1mem8xTlIzTXlRZXVoNTBxYWhmc2lSbmpsTUtFajdrWFh2?=
 =?utf-8?B?eGxPWlg3Vm5FbkRibS9zd2NwY3g5bS9iMm9nK3dkUElLQUsrU055VkRlWWYr?=
 =?utf-8?B?UzNvdUpxSitoOHpMT1RNbUJ4MDNKbVp1Q2dEb0FjVENWdDJlakNoZjJtck53?=
 =?utf-8?B?V0ZTajVYSHNJTGF5TG5ud0pZSjgzaXl3dTlibTAwNzNVOWgxYktxRUs4U3JW?=
 =?utf-8?B?LzFGU3grdEpVWUV5RU1FaTVrWk9LeXQ0WWo5Nk41c1BnK3c2cVJwYWhZbGhN?=
 =?utf-8?B?ekVnWWVMSXhRKytsd1RjVks3c2g5NEdTcm0yYnd1bDQzeURMYkdEdDkwYWta?=
 =?utf-8?B?MHA5WHIwaWxvd1A2b0tBWElBUTgwU0h0Wnk2dklTVG9CZDNrUnpBRGdDbDdF?=
 =?utf-8?B?bVhkQ0U4bW55ZkhWLzVEbERnS3BMcmZVK25qUDBuSHdkMzNKREZHSHIwYWF5?=
 =?utf-8?B?OGlHb2ZJS2ZXdUZSczZ6NjBLTkJNK3hyU2RIUWR3cjdmb1NLVmVLMzhHVUZQ?=
 =?utf-8?B?OHN2ZEJiS1AvUW03TC90azFxOXdPZXVCOTNGSUZBRUpxeG1iaUJyZEhKek9U?=
 =?utf-8?B?T1B5VHV1ZjlMcm5xdGNvNGMxN1p6cityaldLL0ZMYW9Qa2xpN2FLZXJ2OVo4?=
 =?utf-8?B?L2RqdUZKSGdIajFVT0dkQ0pCR0FtTnVMTFdKN29Kc29WUysvSngrbUlaTHND?=
 =?utf-8?B?RGtwSkVSOFJDcWl2dHRpSWhhLzNzelpqL0lnbmlOaGszZ2xoR0FNM3FrRGsy?=
 =?utf-8?B?YXFtVTFjc3ZLZm05Sjgxa2pveElQeG13dE9lNE04Y2duRHQ1TEwvM01qZWww?=
 =?utf-8?B?TmNMb2VhcnovUS9qekZmM2NjMGtDYTRnTk1GQW1xVUJRd1BpOUY3MVdBdzNr?=
 =?utf-8?B?eURIWVoyNC9LaFNLWkJ6TVhnVE90RWVkVEpUWW9hUkt5U1psNGVWaUptRVVy?=
 =?utf-8?B?bkY3eElwMWt5WGNaZU9vZm9NYkRaak1ETU43L3BkbDdmK3Y1SkNpeFVpVTV4?=
 =?utf-8?B?cllnR3U2bGJBT0F0OVUvV3FKNjBsbUlJL3dLek9ObkhhalJWMmZ0cDBSN2wx?=
 =?utf-8?B?bEFxRFljT3dRSVJnR0kxMzM3Q291dXplZUdhK3VmbnA0NWl5M1ZMYjRqZGN4?=
 =?utf-8?B?WVlvN1ozU2srdGpSV1ZkdkhwWVRJMmJleEpjeHA4dSt5T1Bnc1NhSndSeGht?=
 =?utf-8?Q?s/IAIP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9279.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWtCcllZMzFaaVVpV00xZmVOVHRDbnJiZTZEcS9LeEovUU1DTUtVZThZWngy?=
 =?utf-8?B?Y2l5UHJtQS9SSFFhbnZ1Ujd1aVRIOTd2c21HS01Hc045R3BqM0RUTG8vaFRr?=
 =?utf-8?B?TDdvTDNGYm1lc2loMEdLdHpyVlozZlI1ZC9pOXpzWXFkY21TZjIwaS9BQU1H?=
 =?utf-8?B?QmxsZnlUalNqK3ZjZHF5K011UWtBVFJLK0VHWG5IamROZGsraWZnQVkydjl4?=
 =?utf-8?B?RmJMd3FrbjFaeWZpVmN5WU5VYTh4L3p6aTQ0TWtodTJrWjZTeFVPT1UreDg0?=
 =?utf-8?B?WEphVi9lTDgwSnpWNGhzeHh0MHgrRk9yVXlHc1hOdDVHYjVWSlRtWjJOZktS?=
 =?utf-8?B?dFhYQVUyNnR4SVF6WUFmZ0l3TXBZaXR5bFd3cWUxWEtDNHJMaGh4UGFVM0N2?=
 =?utf-8?B?RVZIT2NyMkxOeWNtbjYvZXZjVS95N1FmZHk2TjgvT0xrZDFIWnE4WXhFT0pl?=
 =?utf-8?B?RytkbEtjam82VnppaDZMWWZUdUt2aDF1MlkvSHRxVDk1MzNJTWswU0tjZVA4?=
 =?utf-8?B?blBRTGtPaHZzcmFEbmErRTJJMnAyc091WjNteWZnRDBZcStkUUVLSU5qV1dr?=
 =?utf-8?B?ejlOYitSN2xEMDczVWhLeGNjcWNjbGxYbDRTdUd1WUNaVXJFbU0wL0Zud2Y4?=
 =?utf-8?B?bTIvWjdIdGVGWkFxbitJK2o0cERFSXF5UlJyMmxsa1dPblozb3NENDB0Vkl0?=
 =?utf-8?B?MTVjc0hEWVo2cEVLNUp4S1RiTmE0MEw0cUdQUVBQazhmTDBZcDZvN3dBVFMw?=
 =?utf-8?B?cHc2VDZKa2laUVZFQTVrWDZ2WnZnRmlLMXIwL2dvZUFFS1NRZDNWbGRUM0ha?=
 =?utf-8?B?ai8xbUcvV2JlWDkyUE8rQUF0TkhDZ3pUTzBqZUtraWtrQTIwMUUrRzgxWXFF?=
 =?utf-8?B?blJGbDlLZlBQeDZwTlN1Z214RDRmZk1YQnV0RnBhY1BZSytXZFZFZVl6ME94?=
 =?utf-8?B?MDMyc2lXd0pYNlo3VjhJVUdYNGlDTlhOMEJ3TEpUSTdmeXhFM0Y2dEhCUm5x?=
 =?utf-8?B?R0hJRmMwWis1dXY4VHB2SmJscGF6K0dZamZMWWZYelp6U0gzd2ZLTFM5dzBp?=
 =?utf-8?B?UjFuVzcwSVAxb05mcXdIUUdhTUFGMDRLTDY0YXI3dXFZdUY4Qkhrc0EwaEY2?=
 =?utf-8?B?RWY5M3R6Z2FKVVowV0xXUzluMTVTT3l4NUZBOVFiZEFKZVZFTWdNM0E1SDEy?=
 =?utf-8?B?WldaM3RGSjdaNEtFczZJN1JJV3Z4T3I0eUZmSXR1ck5MUXA1OHNSU2ZHdGM4?=
 =?utf-8?B?M1lSTFZBVHp6ODZ0OEMwM1VrLzN1Mk9JQUZrb0NCY2lmQUlKR1AwcVVpWnhp?=
 =?utf-8?B?blRCNHBnaUlsL1dDOXBSbUVteEZrUUUvWkhHQ2RFRGNPSFpNU0NkQ3NnS1pl?=
 =?utf-8?B?WlBXQ2grTTlXczhqcDArKzI3YjdscGFuVUZXODdBQXhmcDlMaUZxbm05RFBi?=
 =?utf-8?B?TlQ5dTJ0V2pZcHEybER2bDdqbjMwV3FYc3BzbjRKdkIweGJNcDlaRXFra1Zm?=
 =?utf-8?B?b3pVRUcrTVkyaFVISkVBNHlGQjI0ZkRFcUd3T2JtRk9SN2l6NHNGVXpZMkl0?=
 =?utf-8?B?bThHZ2lSbXVmY1hwdnVJek41QjlyOE5SeE1abE8xOE02UzNyMUxXNzFyMUJN?=
 =?utf-8?B?ZFVLdmszMkFXbHZnbGFsNDlDeWVzVVVpQmNncDFHYzFBdnhyc2d6TGVmLzRy?=
 =?utf-8?B?QW1CRURlN3M3WEZ5Vmp0QStHejRscTREOTJUQnBMbWF5eVY4eFVXTllaVXYw?=
 =?utf-8?B?ZlR0WVZ0Nm5iOEYrTC9aS2llQTlkeStJZXdQMWcwamE1M3VtZTFITWlIck4w?=
 =?utf-8?B?OXVMU2sxMm9hMVh6a0Q1dGdQcC83ZUJPWHJNbjNZWkVBWW43UUtHaHBUWFNL?=
 =?utf-8?B?V3EwdEJ5aXJ5eXEvUUNHdVV6Nnp0ZjFsTGxXQmZlRmhQSEFvQ1NwV1FwYjNa?=
 =?utf-8?B?bmZFU2RwRkYrekd3SFpPVWs2a3Jpbkx1N2RzZWM2T3ZKNkhGdUdTZmxPVno5?=
 =?utf-8?B?TW9MTlRQVDd4NUdzUlVjR0NYdTdrT3NtN09LeW5nQTN2NWtkcHNFczNudjl6?=
 =?utf-8?B?MEwxQXdWWGlHOHZBTkVCUmJQSGc1eFQzTnFkSWFoRHg5eGhwMmFES0dVVElx?=
 =?utf-8?Q?X9wljyEfLSudFsVzAPwSUhBBh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9279.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2210ee92-1a7b-48b6-1a8f-08de26a00905
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 12:43:12.0539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QmexyvqK5OC2kfj5rqwN6R+nKKWK2X0qqGzsEYtqDtF4TxGQSmRqakshSpRNCrAIth5R73vtDFKXjFX6PjsrNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmluZyBaaGFvIDxi
aW5nekBudmlkaWEuY29tPg0KPiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDE3LCAyMDI1IDk6MzAg
QU0NCj4gVG86IFNsYXZhIE92c2lpZW5rbyA8dmlhY2hlc2xhdm9AbnZpZGlhLmNvbT47IGRldkBk
cGRrLm9yZzsgUmFzbGFuDQo+IERhcmF3c2hlaCA8cmFzbGFuZEBudmlkaWEuY29tPjsgV2lzYW0g
SmFkZG8gPHdpc2FtbUBudmlkaWEuY29tPg0KPiBDYzogT3JpIEthbSA8b3Jpa2FAbnZpZGlhLmNv
bT47IERhcml1c3ogU29zbm93c2tpDQo+IDxkc29zbm93c2tpQG52aWRpYS5jb20+OyBTdWFubWlu
ZyBNb3UgPHN1YW5taW5nbUBudmlkaWEuY29tPjsNCj4gTWF0YW4gQXpyYWQgPG1hdGFuQG52aWRp
YS5jb20+OyBOQlUtQ29udGFjdC1UaG9tYXMgTW9uamFsb24NCj4gKEVYVEVSTkFMKSA8dGhvbWFz
QG1vbmphbG9uLm5ldD4NCj4gU3ViamVjdDogW1BBVENIXSB0ZXN0LWZsb3ctcGVyZjogc3VwcG9y
dCBtZWFzdXJpbmcgMm5kIHJvdW5kIHJhdGUNCj4gDQo+IEluIHNvbWUgZHJpdmVyLCB0aGUgZmxv
dyB0YWJsZSBtYXkgc3RhcnQgZnJvbSBhIHNtYWxsIHNpemUgYW5kIGluY3JlYXNlIGJhc2VkDQo+
IG9uIHRoZSBydWxlcyBudW1iZXIuIFRoZSB0YWJsZSByZXNpemUgbWF5IG5vdCByZWZsYWN0IHRo
ZSBhY3R1YWwgcnVsZXMgaW5zZXJ0aW9uDQo+IHJhdGUgZHVlIHRvIHRoZSBleHRyYSBvdmVyaGVh
ZC4NCj4gDQo+IEtlZXBpbmcgMSBydWxlIGluIHRoZSB0YWJsZSBhbmQgbWVhc3VyaW5nIHRoZSAy
bmQgaXRlcmF0aW9uIHdvdWxkIGJlIG1vcmUNCj4gYWNjdXJhdGUuDQoNCkknbSBvayB3aXRoIHRo
ZSBhcHByb2FjaCBvZiBlbmFibGluZyB0aGUgbWVhc3VyZW1lbnQgb2YgdGhlIHRhYmxlIHdhcm0g
dXAgZWZmZWN0IG92ZXIgdGhlIGluc2VydGlvbi9kZWxldGlvbiwNCmJ1dCBJIHRlbmQgdG8gYmVs
aWV2ZSB0aGF0IHdlIHNob3VsZCBoYXZlIGl0IGJ5IGl0ZXJhdGlvbnMgd2VyZSB1c2VyIGNhbiBz
ZXQgdGhlIG5lZWRlZCByb3VuZHMgaW5zdGVhZCBvZiBkZXBlbmRpbmcNCm9uIG9ubHkgMiByb3Vu
ZHMNCg0KQlJzLA0KV2lzYW0gSmFkZG8NCg==
