Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACAAC5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 06:07:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AA5E4028E;
	Tue,  3 Jun 2025 08:07:54 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by mails.dpdk.org (Postfix) with ESMTP id 1E0E94025A
 for <dev@dpdk.org>; Tue,  3 Jun 2025 08:07:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgK/fYy8cGMvLaChEgmjk3BaEwzE6Klzh2n1fQyuLLRQ8zpzylonPPBgeMzFKRgplopS27xVYpitKtqWKZSLzNJlEBWp6fagltmlmrgL2MtmqXh8pm5G1Dv0zXemAYHZgwNeveviOrUlIk3eChKbEUYnSJjbV8Hr3WXj3hKn3l06FeJIXVVLU3uDRPcXCS62kuuT4KINikyCCSkCWywZsxBfc5jrR2jWujYOvbcj+h7L93+NCCd04qhSmQ1PWirhpHXU4jji9yY4oqlLC7qw3RyYJLlKHJP+tSonj9OLj9uJ8HyIIsZRE2r+Qq80jMhfx4AJ5JV7UFsLP0THTvDqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+hpFFmPyg5Xt7E885pc7s71wD1DMDLrrnwsfCwNv4A=;
 b=BndeVc6jIz8SDy1sL8GEqBF/ao0odouDYBK236ygRxx+VVImvb+URgjEM0NxRwfzpCLXTdlXr6Ng9jiVcrgrI06QKx8ptFUaz1RBwaUH/0Mv29CVrhUXMqzv/vL7uOyaA0Dc5t0fTTAuGZvXWXGtow6KK0DLgy1MMeevvbicKfagmRNL4hWTLFQiPC9p/3JhOwyvg7GUNyoFbgyEpawtLZbgAFII8fLp5FnLedY4hkN+/kHoq9aIDN5JLWCy2iPGWgDUK3xbNXiH4IFyeca9GU75WnMXkp7IS9N4SaZiDBuPabBg9lW4ZOtzQy45XO4kMFXn14n1O25ZFtD8U0GECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+hpFFmPyg5Xt7E885pc7s71wD1DMDLrrnwsfCwNv4A=;
 b=aE9MLO5XOmnQI7HmOpKJuOQVQOGN0u6IcuB8V5JGpNH9UZkmJgpZGSC+TaztrV1CcAWdQkIed3ddtAi3xgbRA5hR5J4IxJscbXmLdh0zXlQ49k9U0alas3DwlR31kqIS+AnTlf2cNRUGvHqlYXrXbBr0YBvnW+eNGOX8iNDo/u8=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 06:07:50 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%5]) with mapi id 15.20.8769.022; Tue, 3 Jun 2025
 06:07:50 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>,
 =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
CC: dev <dev@dpdk.org>
Subject: RE: rte_lcore_has_role() return value
Thread-Topic: rte_lcore_has_role() return value
Thread-Index: AdvIpLZJaWj+3Hu4QLKxOy27D7eK3AAIZ8owAAB9vyAC4Vs18A==
Date: Tue, 3 Jun 2025 06:07:50 +0000
Message-ID: <PH7PR12MB859673BB32BC7B05B6ACD55E826DA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FC69@smartserver.smartshare.dk>
 <PH0PR18MB40869A3A3B6E5F0C4D7F02CFDE9CA@PH0PR18MB4086.namprd18.prod.outlook.com>
 <PH0PR18MB40867CA69B24733163400ADCDE9CA@PH0PR18MB4086.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB40867CA69B24733163400ADCDE9CA@PH0PR18MB4086.namprd18.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-Mentions: mb@smartsharesystems.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=5f543461-bedb-4bad-8d42-f4a95e8ffd84;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-03T06:07:12Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|DM4PR12MB6278:EE_
x-ms-office365-filtering-correlation-id: edce440e-04d2-43b7-e3cc-08dda264f881
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eU1DdW5WcEhnbGJWZFA3SlVqdU1OZHo4YjdXMUlkS0tIQlNQU0xVOEw5MGtK?=
 =?utf-8?B?VXZCaXIvZDUzcEpGT1RFd1pNQmVIeUhaZXJONTA5alUrMHpnMk1Uams3VUdO?=
 =?utf-8?B?UVJuZVNXWWpwakxyNU00T0lDaEhrYXJVVk54ZzRnREVDWWVsYWxDZERZYndQ?=
 =?utf-8?B?U3o5aW90UDR0bXphZFByazk0S1FhYi9DWFpUcDFlK0hkbmVoZzBTbVptZ01r?=
 =?utf-8?B?b2hxcmI0K1NhTGJjd3dhWTFWY09oSUhMenBtamRiM1J6Q2NzTXVpdXgvSjIr?=
 =?utf-8?B?VkMydE5wTkRjTDUvaUVmcGwrRFRpRDNDeE0rcENNOW14RDRIb2xZalBoUnF0?=
 =?utf-8?B?c1p3WXJSRG8yZU4yU3JhVmN3QU05TFIyeGJBL2dxdmxCQTZsbTBia1Bjdms4?=
 =?utf-8?B?SEZsajBWYVVPbytOU25ZaEpDVUlqYjBOellGWUxoVGZSb0FTYXVmb3NXNGtL?=
 =?utf-8?B?VG1lZHg4cm8wQ0NkblRsVmFPMTU1L0FzdUZ0UTFSNjlJa2txQlo4UlpBVE5G?=
 =?utf-8?B?UVcxN25zMEx3SVN1Q21wSTN5aW1ncVlTSFJqYUdreWVtdFFmMWFldmNqTHQ5?=
 =?utf-8?B?VUFMQVFja0o4TkFHUjFQd0pyR0JqNkdKV2N4UFZ4K1ljRGtsZEh3NXk4aTNq?=
 =?utf-8?B?NVN2czA4b0Y0QVFrODNRQVFycHlWYmM3SndaVGF1cnZYMXE5VkZRTTVNSllm?=
 =?utf-8?B?NW9qRkJNTXNVYTd2K004UFIwTHZBekQzWlhZWnJGZ0ZwQkFVMHlubzNENmZh?=
 =?utf-8?B?TU9PY0poTk1XaVppSnJYWGQ1YUZoQVNiamVPOWRmbi9Ia1dhZE5xR1N3eXpv?=
 =?utf-8?B?MkxyM0R1OURkR2tSNXh1SUt1c25heXE1QUlxYk9sdExSZ21CRU52ektwbXdU?=
 =?utf-8?B?MFMzdklGNzhTL2EwSmpBbnhucFJ5NkdSZ3hsbFQvSnkrc2lSb2ZSS3JKMDBT?=
 =?utf-8?B?aXd6VWFJaGVKVVMyemhtdUJEaGVNVDJ3VjROa28rTEVzQUg1aEQzY0tlcUgx?=
 =?utf-8?B?TElIYUhkTVQ5RElXT0tWK01OUXB2ekxadzBLOHhtQkY0blh3VUNEL3Y4RmNU?=
 =?utf-8?B?di9KY09OTnhhQ0NNcjF0ME5MdEJjZ01LbG5VZzBWb1F6VVlHQVZJSC9NUkZo?=
 =?utf-8?B?cFNnL3ZOZ3hITno4cFltaVVwMTJEeXpWMExnWXVSdlNSMXpBSUZiUjB6bXNE?=
 =?utf-8?B?VHlaa29GZHRzaUUzZEhxa0VqRCtXOVIxYWpLY2lpMzRka1J0aDVrS0tEaXNK?=
 =?utf-8?B?anpSMzF5RjVPN0d0cTNtTkZEcmVQa0YrRmtZcVVoR1NXaDRZcmc0eWVaQjZJ?=
 =?utf-8?B?dnBSYjRNU0pFeFJjQmNoTjFFcVBVbHFKaktTdGxLZDNtSzN6TzF2cDFDaGNy?=
 =?utf-8?B?VnhHMVp6TE5rOG9RVEZlaDNCMDA0eGxiamFJRVFzbVBydXRDQS84Q3lMWWZN?=
 =?utf-8?B?enR0eEdDQkQvejNmNG5ZanBncDRmU3RLMHdEV2pRL3F6QUEzSWxFbGRqSFo5?=
 =?utf-8?B?N3B0d1QrQTByOEdwTE9JR0dLcldqbmRodGUvUHpyaFh3MmN6clNYVzB2eWJJ?=
 =?utf-8?B?ZnAxY3o1MCtzUnZwaDlzNGpRR3BhbHZyUFFrbDVmZUh6RFhHcmYxbnRZa1dB?=
 =?utf-8?B?aHFnNUUyZDRKNkVSb0hGQ3dHc3ZlcDRTR2lzZksyelZCM3Jlakcva1JpYTkv?=
 =?utf-8?B?Nk8yem96TW5JYlVxN3VnMkVjSndmVURMdUl0MURZWkcvQWI2TzJJRTBEUjMw?=
 =?utf-8?B?WFBJMGg5dzJJbkZTR3N5MlV3eW45VTRQeE1RVkovb0lIYkpEN1ZtbTZiOTZK?=
 =?utf-8?B?K0ZUSFZBUDhydytXNlVQRmJtQkY3VkNaUWg2dWJ5ZjJ3dEJHK2gvT3ZpUVZ5?=
 =?utf-8?B?dCtkcmdrd0U1Ung4SldheDU0YzVOVWpFdDI4MTJ2N1BkTXN3Wi9TWTFnZnhB?=
 =?utf-8?B?OHZkZXh4VkVqV1FRZ0tFS3FCUmM5UTRlQ0hidGl5T0ZyWUI4R09Veis0Vmts?=
 =?utf-8?Q?j/V5Yh8GEZpx8rR9wg2vm8rWp903fg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTd3NTdYQUtQYW5NNUcvenZ4bCtKY2NSYWs0YkV4WDlvaUpENTlIYnFEZ3dX?=
 =?utf-8?B?U2oxR3M5N2Z2U3VpMDNMc0kyOHU3bXYzVEhOTDhQZnVZcjJMby9wK2lhbnZw?=
 =?utf-8?B?ZXhVcXdmTFdIa2JlNm1mbDJ1Qy9CelF5d1VLNWRiWWIrY01wUkUrMVdkUVln?=
 =?utf-8?B?c2UvRlJNWHU0TkUvNEVORmxDSkRDYUd2OGZkWmMyY05NMm0zUk10Ykw1U2Zz?=
 =?utf-8?B?aXYvaVJTOStwbHdKRWdsM2xqWjBQZ2ExQTdNVjFWWFhuN0VzUlpKajI1TWE5?=
 =?utf-8?B?SzBPVG80L09PdktDRHc2ZjFEYnJlN3QzcHJOT1VlWkJibkM3bmthWkdCVXd6?=
 =?utf-8?B?elEwaWJiclNJelQvQVFBZUllSVgrU3Fna3JxcGVVdmY0K0tzeWpQamRhTUt2?=
 =?utf-8?B?SXcvSDBtRU00U21tRWlqQTNZR0NwTmVPSGo0d0pSeURKOUdidnEwdW5pQ0N4?=
 =?utf-8?B?NGo4Wkw5anNLNW5GZEhqaTNLQitEVEMxbGkyNEpjVDNhd3NhR3pCWXpvMVV2?=
 =?utf-8?B?eVhTSUtiZGIxdGNIYUdJOFl3aWRXTWhQT2cxMkdiTEcwc3VnRDdVaWR2R0xI?=
 =?utf-8?B?L3BrelNLejYwSEdjSndDWjhEalZwNzVOU3krQm1xRjFHK3hJbisxRFdJNlVK?=
 =?utf-8?B?dE5JK25rems4QXIvMnIvSjhsNmdOeFdQRkNlUmJad25xVDRxMG1LRUg2REwx?=
 =?utf-8?B?UDNQeCtvNzgyTDRhOWNpR3NZcDRjblNyVm1yNUNEL2diWW95QndnemJjSXNN?=
 =?utf-8?B?M3JOcnpnU0NvYVVFVENUVjZUUmR1MlBtN3htZSt0T1drVHFaeU92QXdTV0th?=
 =?utf-8?B?ejFiT2wrenNqZUN5S0FnRnlmNWRTb3RINGdvcVpmWHhINnVZelIzMzRyK01p?=
 =?utf-8?B?eGxZK3pyNDRjWXM0NzR6Nno1YytheHhQbnRCMTQvNW1ZN2VBZ2dLNXc2TFF2?=
 =?utf-8?B?elJHaHZPQzdabm1CKzl0UTB0WWFBZTlxRld5dU1tNjdOSE5jV3psSEtmaGtG?=
 =?utf-8?B?cnM0OXlUZk9nY2Q0YUlOdHlRQVhhVHpNVDlTYWZ5ZVdyUjNLb285a0JFaVh2?=
 =?utf-8?B?WXQ2N21uKzltYmorSTFDSm5ISXpXY3MraUN1UnFBcGhiU2Vweis0WnRRRmhj?=
 =?utf-8?B?aktBc2NIT1NwaHMxcWYzdzBuTGNLYm1ieXpOMFVyZmhZYi9SaWtYZy9DV0Js?=
 =?utf-8?B?T1Q1Y2hBUHBnMmJRZUZPZ2QyakxwUVVQYjhEY2o0bmYzb1BPUXVYdFVwRkl2?=
 =?utf-8?B?QVpmbENRVVphNXhHY1Y4WnIweW5iTWYrQTd1SzJuRktZYlBNTG5IOUxpMGQx?=
 =?utf-8?B?TDhtNzh1cUVJYitnR3VPaXkxdTU4WkhUN1NXMlV2V3ErVS8wdWovM1dTTUpk?=
 =?utf-8?B?MVRJb2w0RFlNcDlLWVNPTzlUNVNqNlVScHl0blFPK0RIOGdOcmdLekJDL3Zn?=
 =?utf-8?B?Z3dNMXFkRUlXdHV2OG1NU2NVelozUHBZSWhQRTNFSUVWUy8yQitmUDB0MDlV?=
 =?utf-8?B?dTd6VzdQS0lXdDNoMlc2UFNFbDFhM3NLekZPVnVJQ05mZTdobXpSdS9QQjMy?=
 =?utf-8?B?QmVMQ2ZRRExMVzVTWlViZmVwdDkzOElIRmZjcTdzemVBdVh4TjlHVERucWJi?=
 =?utf-8?B?ZndpdXJ4WkNhZ1ZNT3FwdVBDWW1yaFZqQ3l0cGpnYzZGci9SMEFBbzcyUXY2?=
 =?utf-8?B?N2MzcDhhS0l1enV1aW5Jc3RENGtxeDdDR1VxTzRrZXdPVHYvd0hROE9TV1dr?=
 =?utf-8?B?ZkxYVXdPRWFDZW0wZHJxWUd4c1JPZEwwSHVaZlVYSTNXZ2s0eGc4SUFpYWcr?=
 =?utf-8?B?cWJuT3daTmxUN3lQZWpCSDJjazc3QWtGaURoMUZES05WN01GRi91eXFLVUMv?=
 =?utf-8?B?T1hyMnJDa1l1N01mYjNqR0h2cThzMXlQZmh4QXI0NnlhT2FYQzk4enZGbFhI?=
 =?utf-8?B?VnZDODJBRW5XTFlqcVpIZ1hHTDlObWg3ek5id1RCaGtENy9BSzQ5RVdIbVls?=
 =?utf-8?B?S0U2ZkVydVJ3VTVZYVJZNnZ6WFNuUE9icnVNYnU4YVVjOFYzRDd2OWsydjBF?=
 =?utf-8?B?ZUFWc2dmYzVibnJiZnVJQVFsSXJaV1QvdlF1UGV2OWpWa1BCNWZuaG9Qblkz?=
 =?utf-8?Q?muNY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edce440e-04d2-43b7-e3cc-08dda264f881
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 06:07:50.5743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6suSB3Y9NKjkwA8GBQw9QOLiX8hNwlKGYHFj7t0UF0FEz9mMCGRv5ZB0vhn39ZFmskcuGOkBZGarIRVd0mm46Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6278
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

W1B1YmxpY10NCg0KSGkgQE1vcnRlbiBCcsO4cnVwDQoNCldvdWxkIHlvdSBuZWVkIG1lIHRvIGNo
ZWNrIHRoaXMgdW5kZXIgYHJ0ZV90b3BvbG9neWAgcGNvbWluZyBwYXRjaGVzPw0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhdmFuIE5pa2hpbGVzaCBCaGFnYXZhdHVs
YSA8cGJoYWdhdmF0dWxhQG1hcnZlbGwuY29tPg0KPiBTZW50OiBNb25kYXksIE1heSAxOSwgMjAy
NSA3OjQ2IFBNDQo+IFRvOiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29t
Pg0KPiBDYzogZGV2IDxkZXZAZHBkay5vcmc+DQo+IFN1YmplY3Q6IFJFOiBydGVfbGNvcmVfaGFz
X3JvbGUoKSByZXR1cm4gdmFsdWUNCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0
ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9w
ZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0K
PiBNeSBiYWQsIEkgZ290IGl0IGNvbmZ1c2VkIHdpdGggbGNvcmUgdG9wb2xvZ3kgcGF0Y2hlcy4N
Cj4NCj4gSSB3aWxsIGxvb2sgaW50byB0aGlzLg0KPg0KPiBUaGFua3MsDQo+IFBhdmFuLg0KPg0K
PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogUGF2YW4gTmlraGlsZXNo
IEJoYWdhdmF0dWxhDQo+ID4gU2VudDogTW9uZGF5LCBNYXkgMTksIDIwMjUgNzozMiBQTQ0KPiA+
IFRvOiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPjsgVmFyZ2hlc2Us
IFZpcGluDQo+ID4gPHZpcGluLnZhcmdoZXNlQGFtZC5jb20+DQo+ID4gQ2M6IGRldiA8ZGV2QGRw
ZGsub3JnPg0KPiA+IFN1YmplY3Q6IFJFOiBydGVfbGNvcmVfaGFzX3JvbGUoKSByZXR1cm4gdmFs
dWUNCj4gPg0KPiA+IEhpIE1vcnRlbiwNCj4gPg0KPiA+IExvb2tzIGxpa2UgdGhpcyBpcyBtZWFu
dCBmb3IgVmlwaW4uDQo+ID4NCj4gPiArVmlwaW4NCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBQYXZh
bi4NCj4gPg0KPiA+ID4gUGF2YW4sDQo+ID4gPg0KPiA+ID4gVGhlIHJ0ZV9sY29yZV9oYXNfcm9s
ZSgpIGRvY3VtZW50YXRpb24gc2F5cyBpdCByZXR1cm5zIGJvb2wuDQo+ID4gPg0KPiA+ID4gSXRz
IGltcGxlbWVudGF0aW9uIHJldHVybnMgYSB0cnVlIHZhbHVlICgtMSkgaWYgZ2l2ZW4gYQ0KPiA+
ID4gbm9uLWNvbXBsaWFudA0KPiA+IGxjb3JlX2lkLA0KPiA+ID4gZS5nLiBMQ09SRV9JRF9BTlku
DQo+ID4gPg0KPiA+ID4gSSB0aGluayBpdCBzaG91bGQgYmVoYXZlIGxpa2UgcnRlX2xjb3JlX2lz
X2VuYWJsZWQoKSwgaS5lLiByZXR1cm4NCj4gPiA+IGZhbHNlIGlmIGdpdmVuIGEgbm9uLWNvbXBs
aWFudCBsY29yZV9pZCwgZS5nLiBMQ09SRV9JRF9BTlkuDQo+ID4gPg0KPiA+ID4gVXNlIGNhc2U6
DQo+ID4gPiBBIGNvbnRyb2wgdGhyZWFkIGluIGFuIGFwcGxpY2F0aW9uIG1pZ2h0IG9yIG1pZ2h0
IG5vdCByZWdpc3Rlcg0KPiA+ID4gaXRzZWxmLCBhbmQgdGhlIHJlZ2lzdHJhdGlvbiBtaWdodCBu
b3Qgc3VjY2VlZC4NCj4gPiA+DQo+ID4gPiBBdCBleGl0IG9mIHRoaXMgY29udHJvbCB0aHJlYWQs
IGl0IHNob3VsZCB1bnJlZ2lzdGVyIGl0c2VsZiBpZiByZWdpc3RlcmVkLg0KPiA+ID4NCj4gPiA+
IEZpeGluZyBydGVfbGNvcmVfaGFzX3JvbGUoKSBhcyBzdWdnZXN0ZWQgd291bGQgc2ltcGxpZnkg
dGhlDQo+ID4gPiBhcHBsaWNhdGlvbiBmcm9tDQo+ID4gPiB0aGlzOg0KPiA+ID4NCj4gPiA+ICAg
ICBpZiAocnRlX2xjb3JlX2lkKCkgIT0gTENPUkVfSURfQU5ZICYmDQo+ID4gPiAgICAgICAgICAg
ICAgICAgICAgIHJ0ZV9lYWxfbGNvcmVfcm9sZShydGVfbGNvcmVfaWQoKSkgPT0gUk9MRV9OT05f
RUFMKQ0KPiA+ID4gICAgICAgICAgICAgcnRlX3RocmVhZF91bnJlZ2lzdGVyKCk7DQo+ID4gPg0K
PiA+ID4gVG8gdGhpczoNCj4gPiA+DQo+ID4gPiAgICAgaWYgKHJ0ZV9sY29yZV9oYXNfcm9sZShy
dGVfbGNvcmVfaWQoKSwgUk9MRV9OT05fRUFMKSkNCj4gPiA+ICAgICAgICAgICAgIHJ0ZV90aHJl
YWRfdW5yZWdpc3RlcigpOw0KPiA+ID4NCj4gPiA+IC1Nb3J0ZW4NCg0K
