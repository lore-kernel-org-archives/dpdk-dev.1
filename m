Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CDCC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 May 2025 14:15:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 068A640654;
	Mon, 19 May 2025 16:15:49 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0678D402C4
 for <dev@dpdk.org>; Mon, 19 May 2025 16:15:46 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J5bgxH021625;
 Mon, 19 May 2025 07:15:45 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46qxnpry22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 May 2025 07:15:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bp1AXLCOBmu1Nn4Ok+iNWlYc7aY8s9g91q/xIGXKlfBTmWg/mU0Z3vVSQjj1GAIXb5Ww30YTBV/fE79dK0scUNqw8F4vLX7CpFZGWyqxLEvYvH/il91sZ+UkwiSTfRc0d+n9WbDwD1DkXwTAjWCLK1u3dmjhl37PjOuZhYyrD2LKFsUq/gCH1zd4psHiBOgka8DOJu7EJ8WQ2lYbVgAGTXhhxITRQx7vgpWwA/ORuqiIaVyBUjh+b+VCeW5M5FBkPvO1REv8kTh5Vzr3Eh35vLtQFGlr+b1EvmIwGwQowmv18h80eVlBFoy3jitXncmt5jss6HE3uxScqZ4BdUKswA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6UYbI0hsRqCkOR/3aa/mwd7wGORHI9JP84bGgLpCRE=;
 b=dx8HBi2AtwOeJjXilqnSdBNZ6CUC6mZHcD7AhfcJPR+cfJ8bMh3mB4gWPxh2iZDZP+CIC4v9jMAl2G6/k/M9VbRPx7c+QRKfduLIUuBmlp+aGoUGGk5KvvYasktKuignAU4DJJdsHndRK0iQ8e+7FU80qgqpTnxkRBElSjfPVQGn8IllcurpbaLqxT247Np6Pme1CYNTa0r2xk2XBpmCp4HjcVjT7wW6x5nMVux0ABMDlm50QXanDOSQKGhomzlPVQXWyjfMyHz5vgui3V2+CaVV0Mz9YotW99mpql9c7pPEnLHbPU7/M8aNmMe2oxK3UcS7Vewlu5qPDRvPSWSFnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6UYbI0hsRqCkOR/3aa/mwd7wGORHI9JP84bGgLpCRE=;
 b=DX3BxQ8prtPzjn1EQ6yBZsK1/QDH7/mhTu7vXyP6valSyVN9knlhksm0gbHHCYuE14DCQKOb/0IqHTJRggZgNwfNVYGuKGLqnuyKKw9HgWAfKpvgdwZfzUpnM6nZtElCHakCiANnTCf0O8v3BWQHt+4r+wssmYEcm0CBq28Dqvo=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 PH7PR18MB5281.namprd18.prod.outlook.com (2603:10b6:510:240::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 19 May
 2025 14:15:41 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 14:15:41 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
CC: dev <dev@dpdk.org>
Subject: RE: rte_lcore_has_role() return value
Thread-Topic: rte_lcore_has_role() return value
Thread-Index: AdvIpLZJaWj+3Hu4QLKxOy27D7eK3AAIZ8owAAB9vyA=
Date: Mon, 19 May 2025 14:15:40 +0000
Message-ID: <PH0PR18MB40867CA69B24733163400ADCDE9CA@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FC69@smartserver.smartshare.dk>
 <PH0PR18MB40869A3A3B6E5F0C4D7F02CFDE9CA@PH0PR18MB4086.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB40869A3A3B6E5F0C4D7F02CFDE9CA@PH0PR18MB4086.namprd18.prod.outlook.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|PH7PR18MB5281:EE_
x-ms-office365-filtering-correlation-id: 5435e97f-cb8b-43d6-8c37-08dd96dfa2d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TTJUTDlWMGYrOEh2KzJ0NnF3aTZUTVZwN2p2K1hENWpFTDdSVWU5WUNMVkhr?=
 =?utf-8?B?cjN1ZjFaVm1iR21aeEtHSWltRCtWV1NHckVzc1dDZmRKS212S1VWQlRtVnNO?=
 =?utf-8?B?MVFaRXhvVVllNmFXVVB6MXVDNkZsR1ZyQnZvSzBRUGxQcE9QbkJyN3J3TTdD?=
 =?utf-8?B?OE03RHViQ0k0MlVUUEJzOWE4YjlGYkhYZ2MvZ0szb3RQaGs4TENRdmtZY0Vk?=
 =?utf-8?B?c2hKRDRwWXFOSFhqc0E3Nnd5OFFWa0F4R08zcDlJNUdhbnlMWlNWWENtYUc2?=
 =?utf-8?B?Y3cvUVVKNndFMjB6ZVQzSCtBUlRxL3gyS3NCMVhNSDMxVWQ4SElxQTcrdlV0?=
 =?utf-8?B?KzY0YUJIK3d1dVI5a1VKcTZVTUo4SHQvalZtaDVNZ1JuTzg2OGZYYmR3UmlX?=
 =?utf-8?B?dSt1LzdobytQcVRsUW11TUFSQWdObTB3cGVYYkZwTmRRVUhlR3Q2bUdWZWZu?=
 =?utf-8?B?elJSMUs0NzUxOHFyeEpSMDQwSytHdGsxZzMzVDRvL2VPL2NDeWdReWhZbkx4?=
 =?utf-8?B?RVZpOEFjcllJQU41RDBOenB1U2VaUUZqTVFTQ3lWME1EdndnZ3BnMDRCUFVE?=
 =?utf-8?B?d1hWSmdjR1Y5QnpUSU9GYkxNbWhyTmNEUll6WS9HelhuTEZZWC9qdnpaMmFz?=
 =?utf-8?B?U3ZtdEZlUUcrdFQrTmYwMThMcTJ6dWdaRmlCRHduNExiRjZXUU5yVWhmcXNX?=
 =?utf-8?B?WXgwMWtNNiszOVJLRDRYZDZrUFM5UEVkQWpvVy90ZE1xZWY5OTNiNFhHZGZB?=
 =?utf-8?B?dmJseWRJbmtOYzZ6YXlkVmNhcDhxK2hTL2NPakRVSmxYcE1mczRuVjl4aVpL?=
 =?utf-8?B?c2pzWm1GK0wzZTd5ck41d2xHZnlUWEpOdUQvYjhmTGxaNjJLMVJidUNQY2hG?=
 =?utf-8?B?djBHTzNpdi9kUG40N1cxRUN6SzFnSW1VYmRKRzI1TENJbkpkczRGQjZEZE9o?=
 =?utf-8?B?TUYzMGxuUWdkNmhmamVlaEh0R0pFZXh3SXdxVkh0b1ZXbTlJWWxFUUlMVVFK?=
 =?utf-8?B?OGtlTW9lZkUrOENORlZjaGFJc3I1SkViNHVQMWFRWGg3VkxGWXRON2x6WHo0?=
 =?utf-8?B?UzJOdDRGWW8wVXBjRmlFblJtbm5Gb3BNUjd2QzgrY29vdmpSYlRQUERqY09Y?=
 =?utf-8?B?enJjbUhrVzVGR0RkWTNKNWx4S1ZQZjZCWlU0UWRRRHNLcjRRYXFFaFpvdjVL?=
 =?utf-8?B?eGNNdXUwb3ZzOW9OZTdwTTJxcUZEaG01d1dmbEFvVTAxNlB3aWhWWldReW9V?=
 =?utf-8?B?djdRZTJJZ3ZYRWlma3dnekxDSWR3ajBRV0JoWHRGR3F5MENFRmQ4MFJweU0y?=
 =?utf-8?B?Y05sTUZaNDMyVVZiWW1qN3pBZmp2bmw5TkoxUHZHLzEvcVlKZ0pnRjdSSmRU?=
 =?utf-8?B?UWdlUXNGMzFPYWJMOVhkTkR5YXZxSmNkLzhmaGwrTmp4YXZVOFdUblRCU28v?=
 =?utf-8?B?anVpUGRJQUQyRHZ6Rjh0YkQwVHp3cCsrK0lYcEZzT1RLbXpKUit1Q3JGek90?=
 =?utf-8?B?L25UNnNnb3dIdG9ua0QwTHlZVEZvRVFoUEdoakcyS3crWEtrcHdJSHRVZkIy?=
 =?utf-8?B?bTErRmhIMGtiR3dKNWFKYzUzMWpTOVk0Tk5DK2FsYWhWeTFsWFo5bmM3eVJT?=
 =?utf-8?B?bWhFaTZhVlhKYU9GVUdHMXF3MnR1T281eVNqeVh4bUxqck4rOWdteWJ5RXBU?=
 =?utf-8?B?Qllaa3JKMVRXVnVaNGZTTUU4VmxvYnc2Z0hraFhLSHQ1bnNvZi9ISVZVNzVH?=
 =?utf-8?B?aCtybVgzUHJwcUFHNURGRFVNQ3Blb2ZFWmVuWStNc0I1V25JbjV3cEN5bUZU?=
 =?utf-8?B?YnJJa3A4cHRkMlNLVzhTZXppWmxuQTBIZnZkdTY1MDR4MEJMNFlRRjN3ZGhJ?=
 =?utf-8?B?ZVBFMFE4UGQ1L3lVblplL3NzQVgrY0dMc2xHSjBScnlLZUJNT1B5VUtDRGZZ?=
 =?utf-8?B?L3J5UEJJMCszYTc0SHloUnVlWm5wTFgwMDJZb3dZbVdYSW90d2pWV3VOUFVk?=
 =?utf-8?B?Q05QRGtONkx3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1hBVVNTUlRjVGNkNk5rT2QzQnJMOXUvL2wremRmaGFyYU9ZNHNRRDAzY25i?=
 =?utf-8?B?SW96ZXFFSXpiRFBMdFpJWDBNVkRsRCsycWo4N09OcHVsNG1vc2k0MEExMHFQ?=
 =?utf-8?B?QXdCTjl3d2Rka1RUK0hNUDZOdlg3akZ0MmZxWDBqYW41N2ZzZDRoekdWb3M4?=
 =?utf-8?B?TXVMbmEybnd3Q0k0M3RidXBHMEgvb3NIOEova1dZaTQ0aTBHdFdETWt4ZDBM?=
 =?utf-8?B?VDY4eFNUTnZkOWhHdkhybWtHSmR3RnhURm1zNWVzeS9wcWE4U3FleTNFL2Fk?=
 =?utf-8?B?ZGpaOENvSFdQMGVJVG1hY2ZlUituOUppODN4Y3huYjBVT0dwTTFNMCt2Q2wx?=
 =?utf-8?B?a01rYlo2bWRCT1VLWmFFVEo0cUhoV0dCMVg4NlNhbnpSM1IxRVRZUmpnWWdW?=
 =?utf-8?B?SzRFN09TTlZEaE5Sc25lM29STC9MVEpQaDlkSG9hOWwxb1lYczBBTkF4VG1K?=
 =?utf-8?B?bjN2TUsza3BqcmQvZmVud0laYkE0ZVFydzJVZlFZMnZRUTJTaVZicVZNZTla?=
 =?utf-8?B?WFFNZkRFOWFMYWhFRVZIRFFFUGQ1d21vMkhzUTk1L0h0SXRINi9iN0dZOTd0?=
 =?utf-8?B?c1JvdUZoWXRrNUtWMWIzN0ZBWkdlbUd3LzVkY2dxc0FXeDJOLzRSODVXY01Z?=
 =?utf-8?B?VXA1YWh2c212LzFoMVppN0pGZmd4R1UzT09PeHR4R0k0RURKWE9SRWYrekFN?=
 =?utf-8?B?U0doVW5Ldm1hQkl3dit2ZzlYcHVqZjJEaWdjTHlodFZ2eDllRnBLOXF2alhn?=
 =?utf-8?B?L2RiY1BQbHc5TUdWcDZISjF5czVSamY2V1A3b3FKY2pQWDFtdTA0eG1DODlU?=
 =?utf-8?B?Ymt3UUhNcVZkV2JRRUc3WVA2SlJXUXkxcGh1b253dHlVOWFVMXdJdVgxRDlV?=
 =?utf-8?B?VUsyS0xTTjduM2lLalllQnllb0I1K0trRE9tWERvRks0dEErY1M3MStZZC82?=
 =?utf-8?B?SHYrVTZIUDB4UUgwMzllVVZObzFJSEtsbDAxQ2wxMHNLL0N6MXpieTR0b1VB?=
 =?utf-8?B?cVNsZWJ1RU5GdHh2a0E4M3RxaEdCdHpKQWVlKzREcXZROFFQTlVHRHgyNUs2?=
 =?utf-8?B?eW1talZST29DQTlPMWlDVjFYbEtaemtQa3J1N1djeXUwR2hyV1R0amNGTE9I?=
 =?utf-8?B?SEVmUnRTcmZIVEo4QkZMcVNZUGZKS1NyUnEwYm9VWVNNcTdJQ09jSTRLUFFT?=
 =?utf-8?B?aGtNVTB5bzhTZmdjU1hwZnVURG1nOTBWcWROUlZUSzRXT2JSRVlDWXA3ejkw?=
 =?utf-8?B?YytKenVuVEtnV1p6OFAweUR1UC9uRzhkZFFQcThNcE9aT3Q1U3BYMHJSTW5l?=
 =?utf-8?B?WTVQZDBNc1FmOVdVWUJkZmR2OC9NVlZDMzJ1bU5uMU4xei9TV0wvNnQ3eXpE?=
 =?utf-8?B?TDUzbHlRZldXaExBeldUcWdaaUQrdDZ0cWpLckdWSStqY2pCWDRUdG5OeEF2?=
 =?utf-8?B?cGJkQzFseXdST0VVakxla3VLSWo1bk1tSW5GcTkyQzM3V1JZT245aUthWEhI?=
 =?utf-8?B?NG9MbDNXSWhjSFMvL2o5K3NOek0zbEhuRTdPNW9jTXdKY0RkeUdNRk9wSjIy?=
 =?utf-8?B?a3ZxMVR5Z2J6Y1ZXSjRTQ0NYWUFHV3pNOEFDYXV1RkpVdlR5Ry9kY0U3aTFW?=
 =?utf-8?B?WjVHbUlqNUJUUHRvYkhndy9WVDFRenhvZGFmZVBVWklOeUJsSWFSZFlPdUY0?=
 =?utf-8?B?OHpyMGxmZWVrOE5TeWx4czdjdmtIRWZtazZKeDBRWTV6ek0xL0t4MitDcUVN?=
 =?utf-8?B?UUtIMVEyUW1WMjRQZmc0N3hwNjlLcEVBZnlkcTFjU2o0c29oNmV1a1ZYOGpI?=
 =?utf-8?B?Y2J4VjV3WmZwSVN5UkM0V3ZmWWJ5OXJlR0tIYkZNenBZOUhmZWJIMnJzNTQv?=
 =?utf-8?B?ZTdPem84WUNJbnJXeUdVeFNKaUVRczAzVzZMNU91T3cvV2lzZ2FkWjQ1empM?=
 =?utf-8?B?ZTVhM2xVbjF0QnFleVhBTnBqQjFzUmlEOG9vUDRMT2U1Q3FiUHhIYWgyN2lH?=
 =?utf-8?B?Mis2M3dFVnB4TnRic2NoNFRFZEZ4Q0QvcTF3UldEbU9IWXZzczM0SFZYb2Js?=
 =?utf-8?B?blgwZGxpYlZTNkQ0K1BpcVdiZldoVk1xVDVDalh0aFB1VjZvV2VHR3FLRGNX?=
 =?utf-8?B?ZlV1Q2Z0RGtXTjhUTjM1cmROT1YwVUJZTjFJeEVVc3puVXVQZG0zVUFpWW1D?=
 =?utf-8?Q?OaM2vOn3eP5XSkL42b6YmjYWiemy1AjUsSUqPwI3K26v?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5435e97f-cb8b-43d6-8c37-08dd96dfa2d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 14:15:40.9630 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Tsou8w0rVo0Los0S5Jqo4nQtM/oZNz06Gb9KdsUJH1etwWVEYx3+YGCpetIl2NF8TK4CoKAJlub7DMPdBMWBvIT7NOPpMOsiaQ4IWikMkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5281
X-Proofpoint-ORIG-GUID: C6nGNX81tndZoEbJBgxn8PF9gBk_nXka
X-Proofpoint-GUID: C6nGNX81tndZoEbJBgxn8PF9gBk_nXka
X-Authority-Analysis: v=2.4 cv=Z7fsHGRA c=1 sm=1 tr=0 ts=682b3d11 cx=c_pps
 a=NZTPE88KBhpz0z3fOSYQ1w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=n02bokGJAAAA:8 a=zd2uoN0lAAAA:8
 a=8rWy6zfcAAAA:8 a=Hn37ijfwIl6n-ooPqKUA:9 a=QEXdDO2ut3YA:10
 a=rszdq1ld3peujIA30KyE:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEzMiBTYWx0ZWRfX05wO/VPgg+fL
 ahyj62hDILD8/kj7/L5TeBVJ7ndJANJlKnlmkNvNEJsD/evJpyUr76/uplmLKhqP2k2BM2Ua9MI
 t0EXbb4LezHG7P3cdjVxjM0l4OL9/UWhlaJ2U+G6ScFeKSQqw0JY2dCe6gGCQwJEkgTMbSsh/nb
 Y4x0E38A4hzwcTsIkytlKFf/3bVb1I6vZtKUkl+kBreg5D2+me4JW9dXIYo2etJovfPPM7H5hr2
 /MJH6v7IbDTqJ199o/hnV6Mr5NbBx7tTEA0BjPGlJdi0kwRJYTzD4s+rQ47CSuFp93L+9/ZiDa1
 B/A5F3GUnErHuE7oirANQ38bXgMWKWgmBMDvmlnIioO8aWZthcbLlseH/b+/u+d7Vg3jBwJrgsS
 Kh1wZJHaJ2J61Ttf7qGKL+nHb1TLtLMhfyqY/CWle69F/W9h//hnAFSwolzw1DNYvnG7SmL1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
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

TXkgYmFkLCBJIGdvdCBpdCBjb25mdXNlZCB3aXRoIGxjb3JlIHRvcG9sb2d5IHBhdGNoZXMuDQoN
Ckkgd2lsbCBsb29rIGludG8gdGhpcy4NCg0KVGhhbmtzLA0KUGF2YW4uDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2YW4gTmlraGlsZXNoIEJoYWdhdmF0dWxhDQo+
IFNlbnQ6IE1vbmRheSwgTWF5IDE5LCAyMDI1IDc6MzIgUE0NCj4gVG86IE1vcnRlbiBCcsO4cnVw
IDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+OyBWYXJnaGVzZSwgVmlwaW4NCj4gPHZpcGluLnZh
cmdoZXNlQGFtZC5jb20+DQo+IENjOiBkZXYgPGRldkBkcGRrLm9yZz4NCj4gU3ViamVjdDogUkU6
IHJ0ZV9sY29yZV9oYXNfcm9sZSgpIHJldHVybiB2YWx1ZQ0KPiANCj4gSGkgTW9ydGVuLA0KPiAN
Cj4gTG9va3MgbGlrZSB0aGlzIGlzIG1lYW50IGZvciBWaXBpbi4NCj4gDQo+ICtWaXBpbg0KPiAN
Cj4gVGhhbmtzLA0KPiBQYXZhbi4NCj4gDQo+ID4gUGF2YW4sDQo+ID4NCj4gPiBUaGUgcnRlX2xj
b3JlX2hhc19yb2xlKCkgZG9jdW1lbnRhdGlvbiBzYXlzIGl0IHJldHVybnMgYm9vbC4NCj4gPg0K
PiA+IEl0cyBpbXBsZW1lbnRhdGlvbiByZXR1cm5zIGEgdHJ1ZSB2YWx1ZSAoLTEpIGlmIGdpdmVu
IGEgbm9uLWNvbXBsaWFudA0KPiBsY29yZV9pZCwNCj4gPiBlLmcuIExDT1JFX0lEX0FOWS4NCj4g
Pg0KPiA+IEkgdGhpbmsgaXQgc2hvdWxkIGJlaGF2ZSBsaWtlIHJ0ZV9sY29yZV9pc19lbmFibGVk
KCksIGkuZS4gcmV0dXJuIGZhbHNlIGlmIGdpdmVuIGENCj4gPiBub24tY29tcGxpYW50IGxjb3Jl
X2lkLCBlLmcuIExDT1JFX0lEX0FOWS4NCj4gPg0KPiA+IFVzZSBjYXNlOg0KPiA+IEEgY29udHJv
bCB0aHJlYWQgaW4gYW4gYXBwbGljYXRpb24gbWlnaHQgb3IgbWlnaHQgbm90IHJlZ2lzdGVyIGl0
c2VsZiwgYW5kIHRoZQ0KPiA+IHJlZ2lzdHJhdGlvbiBtaWdodCBub3Qgc3VjY2VlZC4NCj4gPg0K
PiA+IEF0IGV4aXQgb2YgdGhpcyBjb250cm9sIHRocmVhZCwgaXQgc2hvdWxkIHVucmVnaXN0ZXIg
aXRzZWxmIGlmIHJlZ2lzdGVyZWQuDQo+ID4NCj4gPiBGaXhpbmcgcnRlX2xjb3JlX2hhc19yb2xl
KCkgYXMgc3VnZ2VzdGVkIHdvdWxkIHNpbXBsaWZ5IHRoZSBhcHBsaWNhdGlvbiBmcm9tDQo+ID4g
dGhpczoNCj4gPg0KPiA+IAlpZiAocnRlX2xjb3JlX2lkKCkgIT0gTENPUkVfSURfQU5ZICYmDQo+
ID4gCQkJcnRlX2VhbF9sY29yZV9yb2xlKHJ0ZV9sY29yZV9pZCgpKSA9PSBST0xFX05PTl9FQUwp
DQo+ID4gCQlydGVfdGhyZWFkX3VucmVnaXN0ZXIoKTsNCj4gPg0KPiA+IFRvIHRoaXM6DQo+ID4N
Cj4gPiAJaWYgKHJ0ZV9sY29yZV9oYXNfcm9sZShydGVfbGNvcmVfaWQoKSwgUk9MRV9OT05fRUFM
KSkNCj4gPiAJCXJ0ZV90aHJlYWRfdW5yZWdpc3RlcigpOw0KPiA+DQo+ID4gLU1vcnRlbg0KDQo=
