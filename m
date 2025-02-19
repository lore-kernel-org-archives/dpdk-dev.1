Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E93C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 13:26:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB33340E6E;
	Wed, 19 Feb 2025 14:26:21 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by mails.dpdk.org (Postfix) with ESMTP id 7144F40E39
 for <dev@dpdk.org>; Wed, 19 Feb 2025 14:26:20 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qANc/PcYtjQp3wuineC1QK61Gr365cfEJVMSG+dkW/2JkpHeioU2J4FI0QaNz0/Ztn/Vzb0fmvaEYuGG7ql7eTnwJ3Kq+EE+s10bmM3e9ax6YI6Sn5x+Y8tnrP3Qc0dPDRjPdolgdqqp6G1zm9g4czvKcDvqgnSpXeNgJqC+D1YowX39fDeM3Fa0dq2hb87LMDyNnYySjREBAOdG8CBVDSrSSP1wyHEDGdLfXlOdX4vThfUlTRnKEJ0J9f24IIpiyb8s30CK5N5UOO6ApGH2GWYDcyKsM9bFnaBJQQGeeA3chy2WOpL4T9V9Sf0WRwbdgoXYz5V7Q3lyfw0MzWvqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IX+vVQ+s7LihFE3kYco7HE4nN2eo0SOsoIRCHr5aFS0=;
 b=Gwl6ffdR79+JXW/+OZ+zOQ8F9WFc+FAJIURqismR5meIIjoQrcRpRRWpCDeoA+olx1/XuUgYPDoaM4Y489ZDELbRwjg+igef6z4lqozDeB+cWT3qd5Y29JTdh7pnp+UxY1ft/Q2Kk/kaBFjdbZMlkcE8IMoVu4ELBTU7xxz4P6ZeB3WlJkrVD1xOqVXbiegY8ahULcF+bP5+cCCUOQvEQYma+dqHOZjCL4+Ko1jC24h7FuL4pt1+rFD2tRC+RpoO6zTP8/On3UqkZfkCW+bZ6bdRolcKzIiKk5WQtTbUaR+mHW3De9aSWlK+7B1CrLIC86+sfxmnU+c7i6lfWCznng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IX+vVQ+s7LihFE3kYco7HE4nN2eo0SOsoIRCHr5aFS0=;
 b=q+T9ErktUQYgbSYYYLf+N6cc6u8NUKKJ6aAt2ug5weWiZi152HkoAT+6KUPKLk28yKuzZA9D5wXhqIXwXZAS1zUkJDxNaHbn03LCyH1+PxtZxQhF0duRppMNcord2UCdrfOlWS7HRwiGFqB4wRTZ8nG63w+CW7Lx4zWG0Z2eW6qnUFpu/g88/5h1P/Dtu7QqvjavDw9yKq9WN3qf9JG63k1Atw9B3BDm32y5NUe7ZDu9JWWXv/6WuVjL8dweall18JCBrSp6SPXKpMs0jNY58xcgOXfbMmJIhT5c4JpuCGBF3rDtW5cfIafSORLLl5AcqBleyExe9bBPC2FMA34eJA==
Received: from SA1PR12MB9491.namprd12.prod.outlook.com (2603:10b6:806:458::21)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 13:26:17 +0000
Received: from SA1PR12MB9491.namprd12.prod.outlook.com
 ([fe80::83e7:75dc:5128:784]) by SA1PR12MB9491.namprd12.prod.outlook.com
 ([fe80::83e7:75dc:5128:784%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 13:26:17 +0000
From: Shani Peretz <shperetz@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Parav Pandit <parav@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
 <nikhil.agarwal@amd.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin
 Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@intel.com>, Chenbo Xia
 <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>, Chengwen
 Feng <fengchengwen@huawei.com>, "NBU-Contact-longli (EXTERNAL)"
 <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Tyler Retzlaff <roretzla@linux.microsoft.com>, Jan
 Blunck <jblunck@infradead.org>
Subject: RE: [PATCH v5 2/4] lib: fix comparison between devices
Thread-Topic: [PATCH v5 2/4] lib: fix comparison between devices
Thread-Index: AQHbeCtgNErhgmnuC0S4207xiEp3XbNCaf4AgAABpgCAAALvAIAMRGmg
Date: Wed, 19 Feb 2025 13:26:17 +0000
Message-ID: <SA1PR12MB94913776F11F95E0C8C1B462BFC52@SA1PR12MB9491.namprd12.prod.outlook.com>
References: <20250129085416.226718-1-shperetz@nvidia.com>
 <20250206000838.23428-1-shperetz@nvidia.com>
 <20250206000838.23428-3-shperetz@nvidia.com>
 <20250211094832.0b164537@hermes.local>
 <Z6uO0mlaIYFekKGZ@bricha3-mobl1.ger.corp.intel.com>
 <20250211100456.084338aa@hermes.local>
In-Reply-To: <20250211100456.084338aa@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB9491:EE_|BY5PR12MB4100:EE_
x-ms-office365-filtering-correlation-id: b781ed5d-22e5-44c0-44a3-08dd50e8fd97
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?aWI3NG5Qejk1RDhDRHBVWVdoUW5TRld3K3p3cDQyaXhHUUNBR2xGYnRWeG1S?=
 =?utf-8?B?RXBQb3hoaDJRQ2R3UzdvZEpkaXdUMWU0OGt3UnR6YjVlZktKbTR2NERRS0lT?=
 =?utf-8?B?Um9sSGxSb1IzV3BSSXJJbldPdmVWY3pRczJ6dEVvWEU0cjRSRW55SHdkZHlU?=
 =?utf-8?B?cTJTc05MR2ZTK3BhOUp6SUF6YzRCWVpSczdmZHR3cGt4a09GWVhYVS85bUpz?=
 =?utf-8?B?Ukx0RGF1ZTRnQnM5cXB3bGNpWHpRUzFoa0ZEUklxY0c5NmlFNktoTHRQMFZn?=
 =?utf-8?B?WWNqK204NHVESkNGU3lYczRRUm1pTUNod3J5eThWL3VjQW5XanZNV0Q1T0I1?=
 =?utf-8?B?T0ZSZG1FN2xsUVpxaHd4QkMzS2w0anVQYVJldy9kRC9KbjU1WnhkQWc4UTVh?=
 =?utf-8?B?TlFxeFc2S0JIK3lJNXNFb2ZqS24zc1ZYM1VMUnVlTEFhcU9COFoxVFdKWXhs?=
 =?utf-8?B?OGIwMm5FeGhUZWpVRFgrdnlERkpBQ3BwcHVOMXBmaE5yMTRpdjFBVmxhYVZ2?=
 =?utf-8?B?MkhHdHdIazI2akhoVXlPa1Jzcmp4Skp1aGVRMEFnb1F4UXk0VThic25kQ25E?=
 =?utf-8?B?SnhRUnJSU054RWg4c3NCVXcwNkMzYXp0TGVsRTJISzB5YVgvdnZ4Ymx2M0ZL?=
 =?utf-8?B?SjhNeXBMVUVyVTNpL3VFLytuL25telpUMGhJSkdEbVBkbjhkcHd3Mzltb1hZ?=
 =?utf-8?B?dEd0SzROeVZ4ZklSZ2ZMTU5qWDJRbjZmYkJ1WklvM3ZJRE9TdXd2U1NJaGVD?=
 =?utf-8?B?VmZVR3E1cXNnczBQcFlNb3ZzdHZGUlNJbVU3NXk0Y293dmRTb2lqUk4wVjdj?=
 =?utf-8?B?YysrZTNXZXlQOUt5SWI2YXVUcXdCdGdYeVluVC8vTzRWRDFJNDBKMDNVUW1H?=
 =?utf-8?B?SnAyL2Z4eFdYQWd2MzFmM3RTSmM0UFZ2cnlMOXNkNUs5dnJOY3BVZXdvV1N1?=
 =?utf-8?B?UVAxN2o4QjRIREtJTzhqU3lBRGUxQzlkQWp6b1U1SnM0MWRnZGgyTGFqRHBz?=
 =?utf-8?B?eXpIMlB0bHRlQXZRL0QzbFF0ZnZ2S1F3WEpVREpaVkNBVFFuaGtJTlRBaWxG?=
 =?utf-8?B?eDNXd1laRmEwY2k0UlpGcVdIYXQ0YXJWZEFwaDhYQ3AwbEtTV0U1T1pZU1JG?=
 =?utf-8?B?dno0MGNObVFNQ1FNeUZuSzBaeDhTckVERFJBVVRlSDloOURFaDY0bVBQNUhr?=
 =?utf-8?B?Z3ZiLzNGU0JBcitweHM2S1ovR0QyL2Z2ZmdYRTVsTFhHQ2tvVDMwcmlxRjJx?=
 =?utf-8?B?a1M3cElpODBBMzcyRE9sLzNLOE9RS3NZQ2poZG1YTHVtSXpGOUxkckhUSkh3?=
 =?utf-8?B?RXB5S1ZqVklRUUYrZnlPU2x4YUxVcit6NDFmaXNOWTAyREtBMVdIT1k3d3Zs?=
 =?utf-8?B?TVA4V3F5cEJaajBnZUx3cTRFKzF3eXdwZlk1L3pIYTEvSjVOVCtlOTJLMGdQ?=
 =?utf-8?B?aXNDUGpHcUdVYnh3eWRUQUNncXNuNFJHRHczZCtublQrMk9EMmFGbmV2UGw0?=
 =?utf-8?B?T1FkRFQ4VzF4cUpHODVaNWVVWEhtVmc3SzU5SlQ0ekszWm1MZm1FWWc1Sk9Z?=
 =?utf-8?B?RzRyNVIyMmhXUW96SXdaazVxelVNQytpS2c0cXcvdGlVVHZZeE5xb1FOaThE?=
 =?utf-8?B?c1hhVCtqN1NDRkV5K01VOFF5MTBtemRYZ2wyMnErVlBVYmxLN01EZG1lSEZo?=
 =?utf-8?B?K21iYXloMi93RFpqMXpsV0F0NWxnTFpGRi9pL21OMEl1K0FwUHNvUXhRSE9h?=
 =?utf-8?B?V2NPa2xZRlV0K1o4b1Q5dER5MFF1cGhmcmh1VytFT2NIYVVJSVBlN2YrWFcv?=
 =?utf-8?B?YVNGNmlvN1ZDUlppbUFGZ0dKc0twTFRXSmhZVzA2U2lDTHhtdnVuYmZVMFFw?=
 =?utf-8?B?Zm5uZURjdS9pdDlaQWJnRjhzcDVWbGxITEtRL0JlWVppYlQzay9hR0ViNXY0?=
 =?utf-8?Q?2lJTKoIeGc8hUdhvcZlgNe2CZ4DD7ovi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB9491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUx5SlZ4dXRkVGFWNnF3bklXdFRWT2hVQTdNNzB4YUtsbVdjb0FpU2hRdjZ5?=
 =?utf-8?B?U1kvemVzZTdva3lLcXJFQXkwc1loZ0pYTC9iSVQwSnlyOWZjQ2NnbEErSkVI?=
 =?utf-8?B?NGdXc3NaY3NydlpDOEJwWng2L3VqUmt0cUNoVHpsbktpQnM0UzY0cGZiN1Zx?=
 =?utf-8?B?ZVFGUXE4eFJMMVN1enRrQ0s2M092R1g1anRyalhUdHdWMUhrSzNMOFdWYWJL?=
 =?utf-8?B?cHZPVUM3a1BzL1hzS0xaU3ZtYW1PbnQ3NTZncFJrdzd0LzZ6SUhoa2RJa0R6?=
 =?utf-8?B?dlBveWtEdm9LbjJkWU55cUVmem9Wc3RpZjJQZmpDSnI2SzExbEdjQUFqVllP?=
 =?utf-8?B?ckkvZFdycS9BZ09wNC9GcG5UN3BzSzQ1N2xjcTUxQTVDZXhFZllvNWlaYkk5?=
 =?utf-8?B?cDdTS2N5ejhyMmR2akJQbmRvWlhpcDAzck1qQzA0Y21iYWNHaDcwUXNLVE9F?=
 =?utf-8?B?VlZ3cXVGYVpwOE0xRzZwWUEwYWZmbHpVeUNIUTdFdTQvZmRuck1XTlpkT3dk?=
 =?utf-8?B?clJIbXk4VFNUU2NFWE5UeHpuZ05ER3A3NkY3VzJ0a1ZSdUdnbEF1VmVleDdF?=
 =?utf-8?B?K1hzenRLWGt3VVNsNXF1SzVBL2JFcFpQVDl6SkFUMHYxSDV0ZnNmTWVjNW5C?=
 =?utf-8?B?aXBqcHJTZ1h3c0k3ZnhNS3pFOWwvUGcrVnZ3UUVhVFlQKzZVWEtKTXc1V3hS?=
 =?utf-8?B?dGZGMTB2bmRhRTJRM2NQbElmOVh1ZkV3VGUraGdGVU5Yd0FTUmNtNDlCYkRl?=
 =?utf-8?B?UHdFdlc1QUt3R0ZFTFVwb3FhNFExSmczWmdNZDVPK0JuditZVWEwbW9XZll1?=
 =?utf-8?B?cVBpejFUL0FEMUxhS2hGNzU5SkdFakQ2VndxdVB1RmJuZTdmRXI3OUg4N2E4?=
 =?utf-8?B?Kzk5MmV6V3JmVWZFWW9ONGE3Z2xFUERabWE3RUNTZXpKeGwxVmdLaXg5dktV?=
 =?utf-8?B?RDFra2VYSXcyY25IRWV6OEViRzI3b0ZMSjIwZi9WbjhDY3ZBcEoyN1VKZmhx?=
 =?utf-8?B?QU14TXhuVTZmTUVWdW13NThmbnRrSno0Z1Y4Q1hOR1VGVG9RU3I4TWpDKzhq?=
 =?utf-8?B?STgwMVNGUlYwL2JzVXJTSHBLV0x4THNEbFB4QXRnbk9YbDdRVlRPVlB3WHZo?=
 =?utf-8?B?UnRCUm1PMGZnZTE2NEY3em51U1RSSFBTSGw3NjdXQTE3WGdhYUxNU09RTGxK?=
 =?utf-8?B?VmJoSkV5NTlMb01udVJkOHZFODV6TXJyN1FWdTM4bE4yRW1VeUIxOVhGRjRY?=
 =?utf-8?B?K25uSTcvZmRiaFlTcWM2QTNkZTh3L253SER6NzRKNTZkWHY1SFZUZUpBL0pY?=
 =?utf-8?B?bmlTYXFLa3NaOTlmdUNKS3FaSWxUTzNtbEtYWXdDc2FJbjIvUzduOHl6TVE2?=
 =?utf-8?B?dUJoSHpmYVlrZUw3bUpsajJiOE5scGx0YmM3STdrMWVnYnpCR3hXTlhzcldG?=
 =?utf-8?B?YTRzTHltYnZQbHN0SFNKc0hZOXJYQk9BRkFSaWFKbFRkTFFFMC9EdXNCcFI2?=
 =?utf-8?B?NkcwbXE5bWVDcVkyMmo3cmdzSC9jeEFtRW9jcm1DTGFhMUh5RzlpWnkwZGQw?=
 =?utf-8?B?TlV6WE5YMy91Qmh5ZlVSSlhMZysraGJ4ZmZVVDZtM3dGcDd2Y2tJMmdYWXU1?=
 =?utf-8?B?K01ZR0M0NEVFM3VvU3NHZVZlQktOaUcrdkFuUHlzRHdna1poUWxzb0JRYklI?=
 =?utf-8?B?bFJBKzNuNkpoeG1sNlh5SERNT3Jqc01pUGp1eVVHWXhQbWhOblI2OVhLbytw?=
 =?utf-8?B?Q05XMWcya2Z2VS9iclRtS3IrMzBnZlcvaW1nZGNzOE1ZUlp5d0UxY2RJdFNW?=
 =?utf-8?B?MmhJQXZ6VlJKYVNkejdIcVc0QmpXMnNWbmhxQWtobzlUNUx4dWtldDN2QmUr?=
 =?utf-8?B?Q0l3ZjJHS3hGY292VWo1Q0FlUEl1emdpaEltK1VBUFVCR2ZvNThmNDVTZFNE?=
 =?utf-8?B?NjQrekJ1amg0UVJKY3JtQmxwUHZoRkJtaWRJdnNqZXUwNUFiZ25EWlFhY3J5?=
 =?utf-8?B?YVBUOUdBMjE2OGlJaUlLMGtrc0dQUXFjZUhvZkVCa0JRTjFTa2pmcEF3bEhX?=
 =?utf-8?B?emhjWi9rVHpVRGZmWmM3b1ZGNlBCcS9HZ0lnYjVpYmJyQVNMU2NZbloyTnpl?=
 =?utf-8?Q?MrMmXNGtck9D552Q4dqLck7Uu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB9491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b781ed5d-22e5-44c0-44a3-08dd50e8fd97
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 13:26:17.3599 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2I6TbKPLhkoPCi5M9+EZPJOwjr/g9ml84Cb0uZn2mJqsI/WZJOnGXhoXpE4ZQFURXosA1Z6mJGUHDvihWCS3Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100
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

SGV5LA0KU29ycnkgZm9yIG15IGxhdGUgcmVzcG9uc2UsIEkgc2VudCBhIGZpeCAodjcpOg0KaHR0
cHM6Ly9wYXRjaGVzLmRwZGsub3JnL3Byb2plY3QvZHBkay9wYXRjaC8yMDI1MDIxMjE2MzgzNi4x
Nzg5NzYtMi1zaHBlcmV0ekBudmlkaWEuY29tLw0KDQpJIGFkZGVkIGFub3RoZXIgcGFyYW1ldGVy
IHRvIHRoZSBwYXJzZSBmdW5jdGlvbiAtIHRoZSBzaXplIG9mIHRoZSBtZW1vcnkgcG9pbnRlZCBi
eSBhZGRyLiANCnNvIHRoZSBmdW5jdGlvbiBzaWduYXR1cmUgbm93IGlzOg0KaW50IFhYWF9wYXJz
ZShjb25zdCBjaGFyICpuYW1lLCB2b2lkICphZGRyLCBpbnQgYWRkcl9zaXplLCBpbnQgKm91dF9z
aXplKQ0KU28gSSBub3cgdXNlIGl0IGluIHJ0ZV9zdHJzY3B5Lg0KDQpJbiBhZGRpdGlvbiwgc2hv
dWxkIEkgcmVwbGFjZSB0aGUgY2FsbCB0byBydGVfc3Ryc2NweSB3aXRoIHN0cmxjcHk/DQoNCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciA8
c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIDExIEZlYnJ1YXJ5
IDIwMjUgMjA6MDUNCj4gVG86IEJydWNlIFJpY2hhcmRzb24gPGJydWNlLnJpY2hhcmRzb25AaW50
ZWwuY29tPg0KPiBDYzogU2hhbmkgUGVyZXR6IDxzaHBlcmV0ekBudmlkaWEuY29tPjsgZGV2QGRw
ZGsub3JnOyBQYXJhdiBQYW5kaXQNCj4gPHBhcmF2QG52aWRpYS5jb20+OyBYdWVtaW5nIExpIDx4
dWVtaW5nbEBudmlkaWEuY29tPjsgTmlwdW4gR3VwdGENCj4gPG5pcHVuLmd1cHRhQGFtZC5jb20+
OyBOaWtoaWwgQWdhcndhbCA8bmlraGlsLmFnYXJ3YWxAYW1kLmNvbT47IEhlbWFudA0KPiBBZ3Jh
d2FsIDxoZW1hbnQuYWdyYXdhbEBueHAuY29tPjsgU2FjaGluIFNheGVuYQ0KPiA8c2FjaGluLnNh
eGVuYUBueHAuY29tPjsgUm9zZW4gWHUgPHJvc2VuLnh1QGludGVsLmNvbT47IENoZW5ibyBYaWEN
Cj4gPGNoZW5ib3hAbnZpZGlhLmNvbT47IFRvbWFzeiBEdXN6eW5za2kgPHRkdXN6eW5za2lAbWFy
dmVsbC5jb20+Ow0KPiBDaGVuZ3dlbiBGZW5nIDxmZW5nY2hlbmd3ZW5AaHVhd2VpLmNvbT47IE5C
VS1Db250YWN0LWxvbmdsaQ0KPiAoRVhURVJOQUwpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT47IFdl
aSBIdSA8d2VoQG1pY3Jvc29mdC5jb20+OyBLZXZpbg0KPiBMYWF0eiA8a2V2aW4ubGFhdHpAaW50
ZWwuY29tPjsgVHlsZXIgUmV0emxhZmYgPHJvcmV0emxhQGxpbnV4Lm1pY3Jvc29mdC5jb20+Ow0K
PiBKYW4gQmx1bmNrIDxqYmx1bmNrQGluZnJhZGVhZC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjUgMi80XSBsaWI6IGZpeCBjb21wYXJpc29uIGJldHdlZW4gZGV2aWNlcw0KPiANCj4gRXh0
ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4g
DQo+IA0KPiBPbiBUdWUsIDExIEZlYiAyMDI1IDE3OjU0OjI2ICswMDAwDQo+IEJydWNlIFJpY2hh
cmRzb24gPGJydWNlLnJpY2hhcmRzb25AaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+ID4gT24gVHVl
LCBGZWIgMTEsIDIwMjUgYXQgMDk6NDg6MzJBTSAtMDgwMCwgU3RlcGhlbiBIZW1taW5nZXIgd3Jv
dGU6DQo+ID4gPiBPbiBUaHUsIDYgRmViIDIwMjUgMDI6MDg6MzYgKzAyMDANCj4gPiA+IFNoYW5p
IFBlcmV0eiA8c2hwZXJldHpAbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gPiAgc3Rh
dGljIGludA0KPiA+ID4gPiAtY2R4X3BhcnNlKGNvbnN0IGNoYXIgKm5hbWUsIHZvaWQgKmFkZHIp
DQo+ID4gPiA+ICtjZHhfcGFyc2UoY29uc3QgY2hhciAqbmFtZSwgdm9pZCAqYWRkciwgaW50ICpz
aXplKQ0KPiA+ID4gPiAgew0KPiA+ID4gPiAtIGNvbnN0IGNoYXIgKipvdXQgPSBhZGRyOw0KPiA+
ID4gPiAgIGludCByZXQ7DQo+ID4gPiA+DQo+ID4gPiA+ICAgcmV0ID0gc3RybmNtcChuYW1lLCBD
RFhfREVWX1BSRUZJWCwgc3RybGVuKENEWF9ERVZfUFJFRklYKSk7DQo+ID4gPiA+DQo+ID4gPiA+
IC0gaWYgKHJldCA9PSAwICYmIGFkZHIpDQo+ID4gPiA+IC0gICAgICAgICAqb3V0ID0gbmFtZTsN
Cj4gPiA+ID4gKyBpZiAocmV0ICE9IDApDQo+ID4gPiA+ICsgICAgICAgICByZXR1cm4gcmV0Ow0K
PiA+ID4gPiArDQo+ID4gPiA+ICsgaWYgKHNpemUgIT0gTlVMTCkNCj4gPiA+ID4gKyAgICAgICAg
ICpzaXplID0gc3RybGVuKG5hbWUpICsgMTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArIGlmIChhZGRy
ICE9IE5VTEwpDQo+ID4gPiA+ICsgICAgICAgICBydGVfc3Ryc2NweShhZGRyLCBuYW1lLCBzdHJs
ZW4obmFtZSkgKyAxKTsNCj4gPiA+DQo+ID4gPiBXaHkgdXNlIHJ0ZV9zdHJzY3B5KCkgaGVyZT8N
Cj4gPiA+DQo+ID4gPiBUaGUgaW50ZW50aW9uIG9mIHN0cnNjcHkoKSBpcyB0byBoYW5kbGUgY2Fz
ZSB3aGVyZSB0aGUgcmVzdWx0aW5nDQo+ID4gPiBidWZmZXIgaXMgbGltaXRlZCBpbiBzaXplLiBC
eSB1c2luZyB0aGUgaW5wdXQgc3RyaW5nIGxlbmd0aCB5b3UNCj4gPiA+IGFyZW4ndCByZWFsbHkg
ZG9pbmcgYW55dGhpbmcgZGlmZmVyZW50IHRoYW4gc3RyY3B5KCkuIFN0aWxsIHVuc2FmZSBpZiBv
dXRwdXQNCj4gKGFkZHIpIGlzIG5vdCBiaWcgZW5vdWdoLg0KPiA+DQo+ID4gQW5kIHVzaW5nIHN0
cmxjcHkgaXMgcHJvYmFibHkgZmluZSB0b28sIHdpdGhvdXQgaGF2aW5nIHRvIHVzZQ0KPiA+IGRw
ZGstc3BlY2lmaWMgc3RyaW5nIGZ1bmN0aW9ucy4NCj4gPg0KPiA+IC9CcnVjZQ0KPiANCj4gVGhl
IGlzc3VlIGlzIHRoYXQgYW55IGxlbmd0aCBhcmd1bWVudCBuZWVkcyB0byBjb21lIGZyb20gY2Fs
bGVyIGJhc2VkIG9uIHRoZQ0KPiBzaXplIG9mIHRoZSB0YXJnZXQgYnVmZmVyLiBOb3QgZnJvbSBs
ZW5ndGggb2Ygc291cmNlIHN0cmluZy4NCj4gDQo+IElmIHlvdSB3YW50IHRvIG1ha2UgcGFyc2Ug
Y29kZSBzdHJpbmcgc2FmZSwgdGhlbiBlaXRoZXIgc2l6ZSBuZWVkcyB0byBiZSBhbHdheXMNCj4g
cHJlc2VudCBhbmQgaW4vb3V0IHBhcmFtZXRlciBvciBuZWVkIHRvIGhhdmUgYSBzcmNfc2l6ZSBh
bmQgcmVzdWx0aW5nIHNpemUgYXMNCj4gc2VwYXJhdGUgcGFyYW1zLg0KDQo=
