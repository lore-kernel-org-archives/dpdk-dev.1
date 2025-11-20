Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87221CF6497
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 01:26:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 791D440267;
	Thu, 20 Nov 2025 02:26:35 +0100 (CET)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023126.outbound.protection.outlook.com [52.101.127.126])
 by mails.dpdk.org (Postfix) with ESMTP id 0B06D40262
 for <dev@dpdk.org>; Thu, 20 Nov 2025 02:26:33 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AiDBOjF5Wn3nO/5hURxAaRNOlJ/KkSQhO6N0/DTklFqPi3ppc+CdS6ejpmq6Wrv39UhljlJQcTDMJSjJdTFdp8ChK3x0Pgad9ODGw7ida6nZh/SI4AdvzbsMgJiP/WW4PdJbyI9AVj4X8dq75+47JLZlnQaRI6gVYI+PwaGBSmJht38KVFjFh9/rjrnj+i75ARR8x/r7/HquYKu1Zlr640O9TtaXJa2LtIaCu6LQs0QN9lCfLVod1iaANUiSA/Ee4qqSitm/WYvCUl9nkOfcBLFf+NSYg1lCut+PWHJT7B55MxX+FuUlutB5H7okWT81x29Qv20D+09xMRIdot3gTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNYEedSX2Zg9/DdtNfdI4N25XRlilSlWCjfKoxmLUd8=;
 b=En/tkK8eXBlCgv55YqS3sxm9NnT9yq9wE7q7lNXmFpIeCdPcm/X06+jG2a6M+L+Gqbt1A6ejf8pYmR7olKFmiDqx7umYRAX+eHuRKcYltf/dM0LkFe77etSwvWeVEJOA5Ifg7uQlri0CHhJAaQqHNYraMI3mOsZsagkuJia/i2M2Dpsf09rtdO/Hqb6QVzMC2cRfvw7ziP16HHl5mrCTINyvui60jJ5cNudeFY8jqep1UXGQCLIgcuq4nEhPQ+XBMiMoi0kt9BGsTvITXdvsPgv2mTp8eacUrhTPDMLkitMXx0mPVbZNvNw+oVvCu4UFMcITKADvZmjZMrXd8jfu9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNYEedSX2Zg9/DdtNfdI4N25XRlilSlWCjfKoxmLUd8=;
 b=nWnynl4E5KhnBye5b7ZAONW+T9whB1CDqCk7eyAo6psfiYH/pdz2a3YuLMcGXjoglQDdyeRe8velVUAie1f+dSpuEjC62gsThuwfg+O/vM7H08chBoZZhBjF1C201Oscqevzr+V45oLmB7RfJLVrhPzEP+NLAe0d1Gu4xswIi7Yfz3SEEIAuMygPc6IiL9AdYfJ50Qs80DIEue/l99Z4XktHHaCGR0O4vuowogpsj5wjBSbNXgpaz1qZd4H1VgBkzxubN+5SotSuRLWJJLH2PbQJzcrfh4l9Yt7RJfIRIyA3H1gQXQDUUEZHN1E1rU7snqTA1CRB39QHw22xrqxvsA==
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14) by SEZPR06MB5958.apcprd06.prod.outlook.com
 (2603:1096:101:e5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 01:26:30 +0000
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb]) by KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb%7]) with mapi id 15.20.9320.013; Thu, 20 Nov 2025
 01:26:30 +0000
From: Sunyang Wu <sunyang.wu@jaguarmicro.com>
To: Akhil Goyal <gakhil@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: replay: [EXTERNAL] [PATCH v2] examples/ipsec-secgw: add support for
 SM4-CBC cipher and SM3-HMAC auth
Thread-Topic: replay: [EXTERNAL] [PATCH v2] examples/ipsec-secgw: add support
 for SM4-CBC cipher and SM3-HMAC auth
Thread-Index: AdxZu+lWJrxO6e80T/GODq5olWLPAA==
Date: Thu, 20 Nov 2025 01:26:30 +0000
Message-ID: <KL1PR0601MB5567E83EF75B49C68A58766E90D4A@KL1PR0601MB5567.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB5567:EE_|SEZPR06MB5958:EE_
x-ms-office365-filtering-correlation-id: 89e52293-3c03-46d0-c064-08de27d3d535
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?gb2312?B?aVlBY1lPR1hjU1VYcmFXazFpdVREbFFOdmlUQUVJU3YrRldUUitUenRkYURO?=
 =?gb2312?B?NU5icnplVkRpYi9McXQyU2pIY0gyQjh3TmsxaW4xTzJneXNFaW5Mb3IwQ1BV?=
 =?gb2312?B?N3Rzem5mMDJWQXZQN3d6MHQ0R0tVQnpsTWlXOTF1dXR6SSt2S2U1VTZ2MHB6?=
 =?gb2312?B?bFE5aFd0aEFMczdQdmp6czRJOHBnTGFWcFc5bk91b1ZvTVdTZXNYWlYrbEhT?=
 =?gb2312?B?b3BlRkpSaVcyMTluZko5TVM2bzVaL0lsQTJnMUlDTFF1NzFxd1djbmtUUjlQ?=
 =?gb2312?B?djN0TFdFTFZ6eVpSOG00cThmbWwzRVhBSEZrWnlONzFpN0dUd1pWVjZkelpk?=
 =?gb2312?B?Z2xmeE5lNlgrVVBNNElNbnMzbGkwVlh5aXJOTWVyK2orUWtXbnhWNXdtKzFZ?=
 =?gb2312?B?Wk9QMzZuWGRnUlF4ajc4cUVpaU1MeHZTeGRkWWJyeW1XM3VybWNNNERac0R1?=
 =?gb2312?B?WDFVRGZoaEhxcWJVL0V4ZnRUWGNUTVhxSlV1WVhNT2ZiNklrem1xbmZ2Ukk5?=
 =?gb2312?B?aU1La0l0aEJvR3pkY1ZZWlBTTXpwalRrbnhodW8rVWJzUUtGam1Gd1Q3UjVs?=
 =?gb2312?B?NU42YjFuVEJ0eWU2Q0JiWk92eGlyUFZJa3R5QjNNdzJOeGVwTUdlYVNKTzRh?=
 =?gb2312?B?RWhCWU5MdkZqYWk5RjNHMC9ybnl6N0ZUbWNnOVJXYU5nZXRMdVVUK1NzN29Q?=
 =?gb2312?B?QnMyUTFlQkJsNWl3TFowOXVJK1dFL3VBeEluMkR1UG9pMUc5eUNyaDlERFph?=
 =?gb2312?B?RjlYQnYvYmJJSXFtSFUxVEZnOXY4RDFUZE9XUGFUc0tnQjVjYUd2L09Pb1Iz?=
 =?gb2312?B?eW9yRUZ4Q1hDTGh1YjB5QlNUWlhQWWZJVzFEYUI0dTZ5UHZ2Q0Y5ZUJWTVhy?=
 =?gb2312?B?eFNnS1NKc29QVlpVaU9BdFNrSmJrQmVEL1dyOUZ2TTFvYjBYR0JKcllMelpQ?=
 =?gb2312?B?OVlZeXdXTEwwcUdWRW9OQXVOTXdQdXJUYlZ5ejBucS93QkVmYkdDWVdmV3dM?=
 =?gb2312?B?M2pMbmZWWnRuVDBRV1dpMXJzeHJJeFUvZm5OL011THV6dnc3SHF3VlZCK3Rn?=
 =?gb2312?B?S2x5L1dzazhtM081YVM1djdHQjNHbFdvQWdnOEY4T1IyQ0Z5TWN6MjNGVXNH?=
 =?gb2312?B?eGNxOSs2WG5FU00xamJKbmp4WWFOaUxuZ1NGNTFqbjU1VkFQMlJSMSt1OGt2?=
 =?gb2312?B?YVhsamJySk9WZ0p2WXNTd0VvcDBQOXJCN3Nqd3BGTkd3d05wcVNoZFFCWUlS?=
 =?gb2312?B?Vkt5VDRvcWtPSUFxUHc4dThoaFFCWjRYL0hSZHE2QjJnYVp5d1BIQmhoZjNm?=
 =?gb2312?B?QW9QQkU4YnRLU29PZ1prVXVoRkw3cFB6S3NHamdXUENoRGNKMm5VTmJsaXR0?=
 =?gb2312?B?SGhOQ1hTUHZVaUNNREp1RFpiQ2xzVlJMT0drcXluc0pHMWRGbXJPMEdpd1c1?=
 =?gb2312?B?cXBlTXordjhONFZET3ZKWk5UNXA1YVBGTGZUWEhlZVhGNFZJNk1oNHpLZUVD?=
 =?gb2312?B?SGJLVmN4dTZPRGhXaC9qYnZ6ejI0d1V1Z0J2QlZ5L3hEZ0QvQW9mOUtRaTQv?=
 =?gb2312?B?N3p6a1A2cWNBSGgyU1BRWmNaMXMvcjE2YVc3MFlZTDIzUUdZYURzdDJJWXYw?=
 =?gb2312?B?NHdNUmRxN1JQYlpWREUzeHBwT1F1Sy9YZHc1d1I2eTJaSG5UMlhva3VPKzJC?=
 =?gb2312?B?bkZzNDRZRWRua1Z2RkdsNFpPbXc2dm1qaFVkSWNqYXY4WWJvZG5jc21jZHQz?=
 =?gb2312?B?NGhSZURrZkNhclVWbWdXYkxXaVpKUWNNT3p3Y241U2E2R0R1V29VMk9pRStT?=
 =?gb2312?B?ZXNUMitXemRTMVR5clZKSWZHNHJLQ2FRYzd1K1BWblhEczQ4RjRaVG4yVmp1?=
 =?gb2312?B?TmtwTTdRSmRTU0J1YnhndCtKMmJ2VXJMSTRLaWlzWWErZ2pIR3BuQVpnSFNY?=
 =?gb2312?B?Rk9CUWU1UVhZeStNcUJsd2ViczdacDU2MzVQdFlYTUFjcjZQU1p4YjkwOEN2?=
 =?gb2312?B?VzJObVhTVGpIdHh5VHZYQTl3VHBoTWRaL2lnMkN5YTJKRWc2YVRySzQ3UGF3?=
 =?gb2312?Q?dBtCk0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB5567.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cmRhUi9VVG5mNTd6RDVIV2RaVjljNjRoVTVwNjhlSU42UlROU3JLSHAzcEJB?=
 =?gb2312?B?RUtkMWF3RnNvR2ZFRW1qQUQ4em51akRrVUNiYTcwZVZvOHFSYWFQTVVDWFJB?=
 =?gb2312?B?RjVLU2VJSklSMDNtWTZrQURrY2JSUUlRQ3E1T3IzNzJrMFRUZHdDa2dOYkNF?=
 =?gb2312?B?dkVCaW41dGVXVFJWVGVCdUZySS9KWE93enpNaTE4ak0wTzhtaWJKT3NGUkxp?=
 =?gb2312?B?RWFYcXBzTSt3NzNqdXg5QnVMenFSclFPM1FtZkpyQkZpYVllQXdCOTF5d2xw?=
 =?gb2312?B?bDJpSTJNRU54QjltZmpYeTFuQUErdWZUTkZjY0hjVkl0S3h5QyswbFhOdERk?=
 =?gb2312?B?UmpnRmxwNzJ6YWY1Ukl1ZlV2cVV6MWxEVmtZd1lXaG02WkUvSFozN3lkaGpV?=
 =?gb2312?B?OVpVUEVQV3B0b1cwNHBKRGY2ZERFSWxJTXRUZzlId1VZME9MbGpXb3JmY0VS?=
 =?gb2312?B?MC9ZRm9hcER6ZDZ4T3FzVHFua1VtTjhWa252ZlcwaUNZNVdKUFpUeHVKUDhC?=
 =?gb2312?B?WXdmQURGZ1FSNHhaaklhNnNiWUJlRkRRTDVlL2RiWGRJOVR4NXl6Y2s0em41?=
 =?gb2312?B?TDB0V3crMEVkQUhPMm5pQ1JYYXBDZFpPS3pzOWF0dTl1VndrZDhsbmFaTGFQ?=
 =?gb2312?B?SUcrSjdZTXhLMmxPMlg2M3dHUTk4a2dsVlBYdDRjOFFxN3ZmU1daSitLZnFF?=
 =?gb2312?B?R2l6bWtzYmJKUnNYb2VXR1FFU0lMU1BNN1BMUmFtSVZrOVFFU0hPTkRhT2pP?=
 =?gb2312?B?Uk5qbzFoVjZSUlE4OG1ZS1FTVWk5eGt6TE42N2J1d3JtM3FweFhoUG9UVjZm?=
 =?gb2312?B?c0NlQk9lNXNiVW5UQm85MGR3OG8yQjdGS2NVQklvYjJRNzcvcEF0NW5ZVGRv?=
 =?gb2312?B?V2krdFJZOXlDU2gxK1UrRUM4eTI1enowRFJ1SGwzTDIyZ1hQS3QzVFIwR3JJ?=
 =?gb2312?B?ck9zZ0hSY0QvU2I1QmJpRDd3M3ZKRXczQTlFZGgzekpUYmh0VW8vakZSd2dE?=
 =?gb2312?B?ZjFaWXJoNkVJcDR3ZXAwSElnL2lwb3NmSFJ0N2xZK1VYOHdhTzNCZ2IybUE3?=
 =?gb2312?B?S0tzRmhPSjR0d0sxUTViVW1JNWJ3UVNVT1VUeVVGeUZsejRvZDNHQ2hpeW45?=
 =?gb2312?B?R0U5a1hwa1hSMkpSLzRoQ0lZTlc2UnNNMHlwSDdneWp3TnFCZ25PWlBaS29u?=
 =?gb2312?B?Umxhb1dFTG1GME9mWEx0L3FCR2paU3hRb1pkdzVSeTh1WWVKODdBUmlQeElR?=
 =?gb2312?B?SlZtVlhDU1pxREZ3YVlvWGlGS1ExNVFFY0xqWFc5YlZxZGo1T2Jwa3dmdXZ6?=
 =?gb2312?B?RDlsb2t2ODJKS251NGlVSEVHOWFKc2xKMVdaNjZJWE5tQ1hXb1lpOFlLdTly?=
 =?gb2312?B?d2h4RHlkR3hGVk5UOHNkYVN1WmZudUhod0dXaDhIUXpuaE9NWC9QODE5a0lJ?=
 =?gb2312?B?WFFBanY0QUVkeUtEMFZvME9xZ3FUVmxRR1c2ZEpvcVhuNENWcXNWOHVzZUtM?=
 =?gb2312?B?TXg5UmxmWVJTMHhtcTAxZG9LMHZLcCtUOVNCNFIwRHRId0o3dng3aERuZi82?=
 =?gb2312?B?cERQWlA2Y3BGMlo3VytxdFRqc2w5eXF0bFFCdTJlYk5na2pmK25YL3JRYnAy?=
 =?gb2312?B?RVNhaXJmUGFpUGEzWUcxbkgxM0JvZ0Zid3NNWGpUT1lpS2U1c1ZtcGxVL0pI?=
 =?gb2312?B?b1lXVGNIQ2drSEZLYU9iVS9uMUVQSGlHamFIRzVLdnVLVTFKYkFLbFRqK1My?=
 =?gb2312?B?U2pzbkhWOUl1UnlHOG9aTDBmc0M4amxrSWNxWjlpOU5SWGFGUXdacmo2Y2cr?=
 =?gb2312?B?dGttUFRPMWJONld4NVdUZ2ZVb1FHSUZCaVBKK1RCWjhtTWdncGI4amU5MlVx?=
 =?gb2312?B?QVdrUGRBU01keVZQYVhOeHZ1WTRrMkRkUUV4d3lweUpxU2daQjRmNGo1aTB1?=
 =?gb2312?B?bHhMM3JyQUQ5T1l4WXYxaEJ6VWVuMWFlcDFuNjRuRE9ndU1nUXdFWm8xaXZT?=
 =?gb2312?B?MWhJTnBscVg3dkxoRXN1MHBtR3l6Z1pEL3NPaTJjQnBZTkhWMXZWRDhEdDFL?=
 =?gb2312?B?N29HVWE2RVgzcm82M3ZIZDlDbWk5Z2VqWEFYeWhMZytDdTdDekpXUVJWZGJU?=
 =?gb2312?Q?p+QOjf4chBAGfXklLqJaeM0mM?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e52293-3c03-46d0-c064-08de27d3d535
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 01:26:30.1711 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VUfhMwT7MfkcVPzKaThcWJzV1M66li0FKza3zdpsSxV2Cnpe6AAWWEq4YhHuf0QAJ1ENTJPRV50SvnHhgnYSpLBO9ovEcuqmVao0eY5Yb7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5958
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

SGkgQWtoaWwsDQoNClRoYW5rIHlvdSBmb3IgeW91ciBxdWVzdGlvbiBhYm91dCBQTUQgc3VwcG9y
dCBmb3IgdGhlIFNNNC1DQkMgYW5kIFNNMy1ITUFDIGNvbWJpbmF0aW9uLg0KVGhlIFNNNC1DQkMg
KyBTTTMtSE1BQyBhbGdvcml0aG0gY29tYmluYXRpb24gaXMgc3VwcG9ydGVkIGJ5IHRoZSBmb2xs
b3dpbmcgUE1EcyBpbiBEUERLOg0KMS4gUUFUIFBNRCAoSW50ZWwgUXVpY2tBc3Npc3QgVGVjaG5v
bG9neSkNCiAgIEhhcmR3YXJlIGFjY2VsZXJhdGVkIGNyeXB0byBvcGVyYXRpb25zDQogICBGdWxs
IHN1cHBvcnQgZm9yIGJvdGggU000LUNCQyBhbmQgU00zLUhNQUMNCiAgIFJlY29tbWVuZGVkIGZv
ciBwcm9kdWN0aW9uIGVudmlyb25tZW50cyB3aXRoIFFBVCBoYXJkd2FyZQ0KMi4gQUVTTkktTUIg
UE1EIChJbnRlbCBNdWx0aS1CdWZmZXIgQ3J5cHRvKQ0KICAgQ1BVLWJhc2VkIGltcGxlbWVudGF0
aW9uIHVzaW5nIEludGVsIEFFUy1OSSBpbnN0cnVjdGlvbnMNCiAgIFN1cHBvcnRzIGJvdGggU000
LUNCQyBhbmQgU00zLUhNQUMgYWxnb3JpdGhtcw0KICAgU3VpdGFibGUgZm9yIEludGVsIENQVXMg
d2l0aG91dCBkZWRpY2F0ZWQgY3J5cHRvIGhhcmR3YXJlDQozLiBDTjEwSy9DTjIwSyBQTUQgKE1h
cnZlbGwgT2N0ZW9uKQ0KICAgSGFyZHdhcmUgYWNjZWxlcmF0ZWQgc3VwcG9ydCBmb3IgQ2hpbmVz
ZSBjcnlwdG8gYWxnb3JpdGhtcw0KICAgRnVsbCBTTTQtQ0JDIGFuZCBTTTMtSE1BQyBzdXBwb3J0
DQpUaGUgcGF0Y2ggaW1wbGVtZW50YXRpb24gaW4gZXhhbXBsZXMvaXBzZWMtc2VjZ3cgYWRkcyB0
aGUgYWxnb3JpdGhtIGRlZmluaXRpb25zIGFuZCBwYXJzaW5nIHN1cHBvcnQsIG1ha2luZyBpdCBj
b21wYXRpYmxlIHdpdGggYW55IFBNRCB0aGF0IHN1cHBvcnRzIHRoZXNlIGFsZ29yaXRobXMuIFVz
ZXJzIGNhbiBjaG9vc2UgdG8gdXNlIHRoZSBhcHByb3ByaWF0ZSBQTUQgYmFzZWQgb24gdGhlaXIg
aGFyZHdhcmUgYXZhaWxhYmlsaXR5Og0KICAgIEZvciBRQVQ6IC0tdmRldiBjcnlwdG9fcWF0DQog
ICAgRm9yIEFFU05JLU1COiAtLXZkZXYgY3J5cHRvX2Flc25pX21iIChkZWZhdWx0IG9uIEludGVs
IENQVXMpDQogICAgRm9yIENOMTBLOiBQbGF0Zm9ybS1zcGVjaWZpYyBkcml2ZXINCkV4YW1wbGUg
Y29uZmlndXJhdGlvbiB3aXRoIFFBVCBQTUQ6DQouL2J1aWxkL2V4YW1wbGVzL2lwc2VjLXNlY2d3
IC1sIDAtMyAtbiA0IC0tdmRldiBjcnlwdG9fcWF0IC0tIC1wIDB4MyAtdSAweDEgLS1jb25maWc9
IigwLDAscWF0X2RldmljZTApIiAtZiBlcDAuY2ZnDQoNClNBIGNvbmZpZ3VyYXRpb24gZXhhbXBs
ZToNCnNhIG91dCAzMCBjaXBoZXJfYWxnbyBzbTQtY2JjIGNpcGhlcl9rZXkgMDE6MjM6NDU6Njc6
ODk6YWI6Y2Q6ZWY6ZmU6ZGM6YmE6OTg6NzY6NTQ6MzI6MTAgYXV0aF9hbGdvIHNtMy1obWFjIGF1
dGhfa2V5IDAxOjIzOjQ1OjY3Ojg5OmFiOmNkOmVmOmZlOmRjOmJhOjk4Ojc2OjU0OjMyOjEwOjEx
OjIyOjMzOjQ0IG1vZGUgaXB2NC10dW5uZWwgc3JjIDE3Mi4xNi4xLjUgZHN0IDE3Mi4xNi4yLjUN
Cg0KVGhlIGltcGxlbWVudGF0aW9uIGZvbGxvd3MgdGhlIHNhbWUgcGF0dGVybiBhcyBleGlzdGlu
ZyBhbGdvcml0aG1zIGFuZCBpbnRlZ3JhdGVzIHNlYW1sZXNzbHkgd2l0aCB0aGUgY3VycmVudCBJ
UHNlYyBmcmFtZXdvcmsuDQoNCkJlc3QgcmVnYXJkcywNClN1bnlhbmcgV3UNCg0KLS0tLS3Tyrz+
1K28/i0tLS0tDQq3orz+yMs6IEFraGlsIEdveWFsIDxnYWtoaWxAbWFydmVsbC5jb20+IA0Kt6LL
zcqxvOQ6IDIwMjXE6jEx1MIxOcjVIDE3OjI2DQrK1bz+yMs6IFN1bnlhbmcgV3UgPHN1bnlhbmcu
d3VAamFndWFybWljcm8uY29tPjsgZGV2QGRwZGsub3JnDQrW98ziOiBSRTogW0VYVEVSTkFMXSBb
UEFUQ0ggdjJdIGV4YW1wbGVzL2lwc2VjLXNlY2d3OiBhZGQgc3VwcG9ydCBmb3IgU000LUNCQyBj
aXBoZXIgYW5kIFNNMy1ITUFDIGF1dGgNCg0KRXh0ZXJuYWwgTWFpbDogVGhpcyBlbWFpbCBvcmln
aW5hdGVkIGZyb20gT1VUU0lERSBvZiB0aGUgb3JnYW5pemF0aW9uIQ0KRG8gbm90IGNsaWNrIGxp
bmtzLCBvcGVuIGF0dGFjaG1lbnRzIG9yIHByb3ZpZGUgQU5ZIGluZm9ybWF0aW9uIHVubGVzcyB5
b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCg0K
DQo+IFRoaXMgcGF0Y2ggYWRkcyBzdXBwb3J0IGZvciBDaGluZXNlIGNyeXB0b2dyYXBoaWMgYWxn
b3JpdGhtcyBpbiB0aGUgDQo+IElQc2VjIHNlY3VyaXR5IGdhdGV3YXkgZXhhbXBsZSBhcHBsaWNh
dGlvbjoNCj4NCj4gMSBBZGQgU000LUNCQyBjaXBoZXIgYWxnb3JpdGhtIHN1cHBvcnQgd2l0aCAx
Ni1ieXRlIElWIGFuZCBrZXk7DQo+IDIgQWRkIFNNMy1ITUFDIGF1dGhlbnRpY2F0aW9uIGFsZ29y
aXRobSBzdXBwb3J0IHdpdGggMjAtYnl0ZSBrZXk7DQo+IDMgVXBkYXRlIFNBIGNvbmZpZ3VyYXRp
b24gcGFyc2luZyB0byByZWNvZ25pemUgInNtNC1jYmMiIGFuZCAic20zLWhtYWMiDQo+IGtleXdv
cmRzOw0KPiA0IEltcGxlbWVudCBwcm9wZXIgSVYgaGFuZGxpbmcgYW5kIGF1dGhlbnRpY2F0aW9u
IG9mZnNldC9sZW5ndGggDQo+IGNvbmZpZ3VyYXRpb24uDQo+DQo+IFRoZXNlIGFkZGl0aW9ucyBl
bmFibGUgdGhlIElQc2VjIHNlY3VyaXR5IGdhdGV3YXkgdG8gdXNlIENoaW5lc2UgDQo+IG5hdGlv
bmFsIGNyeXB0b2dyYXBoaWMgc3RhbmRhcmRzIGZvciBzZWN1cmUgY29tbXVuaWNhdGlvbnMuDQo+
DQo+IFNpZ25lZC1vZmYtYnk6IFN1bnlhbmcgV3UgPHN1bnlhbmcud3VAamFndWFybWljcm8uY29t
Pg0KDQpXaGljaCBQTUQgaXMgdXNlZCB0byBzdXBwb3J0IHRoaXMgY29tYmluYXRpb24gZm9yIElQ
c2VjPw0KDQoNCg==
