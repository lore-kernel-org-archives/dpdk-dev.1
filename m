Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7378ECCD190
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:38:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDF7F40687;
	Wed, 15 Oct 2025 09:38:36 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012007.outbound.protection.outlook.com
 [40.93.195.7]) by mails.dpdk.org (Postfix) with ESMTP id 7C811402C3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:38:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqeQx16NncRmKyhda2OLlSnXdkTuX7V8HC4OeqTuVgaGf8MPUcIVXkUU5ecE52lS/ZSq4TP9R4vt1FUS1ck5Xl6OIy59WO4IGyaSMO0EOfkOurkMKnSzDbTqluLG9h5BF28q2LQPHlQEotDfoh1XujGzYU9sjR2RDROOWoaL2gCCdatXCWPExPhD9RDVZeBzKHb+9kNytcXdZschavstZzHaicJkbCfNb0fZ89Xf4BiruOm2JWnG8PWxcjqS25wPOGd8NZd/WoJhGbGanapo/ehQwKoMhMkEIyFjf6y1OtQI0sbPafyA/EK1eeSn3fPTWSfBVkqzQpd4eYPrQ/K3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEVxOHI42CLRxGZruY6EHPHZ+bYEoCXLcLDSYe1AhoM=;
 b=Y1nk5S04CL6jt2Od45UfTo1/zseegTRuk8zPD0S478EhCpHBEiw2tTXQ29c33fShyxt3RoCVGFOKyM6/DZHi4ry7mYsmGFJUgUnOPIDzQECQuh8LUL0Y+CX3TuwC8t75ZxhXBER+1m894gV1hGAU+AyT5Qlko+U7wVzpb9RQATcZEa7REhzfGS/DEcawyDZBr+M04Q7LrifXFUX9klU3L/mnY8GmRhmb3vyGjps8eN2CMmrUdrsgjmaMmbRuNSL6+C/vHH+KnZm4/6QPy1Xw00tUDhjgMP3nlCMG/QjcsH/wDDXLeowWulngaHg82OO4VVjvIcMnuZxhniJU8eE9YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEVxOHI42CLRxGZruY6EHPHZ+bYEoCXLcLDSYe1AhoM=;
 b=IPnCFuSQVV4BAFNGk83EUGbiP/qrR576L4lxa1ap8tlP1sDSARhNIz/wkCMlZRkDpoOWY8W882G9pf7MzheQEP1JyQpNQSR8w/3KrmfepJGI0aK1NdH6K9rTh3VrR3gdQ9L75ulrzst82tZJ5lRQb+A4fopTK9tE6p9Fhr8w+Pc=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 07:38:32 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1%5]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 07:38:32 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH 2/2] mailmap: sort mailmap
Thread-Topic: [PATCH 2/2] mailmap: sort mailmap
Thread-Index: AQHcCHCftF1pOQDiNECaekgjC6rkjbTDO6+g
Date: Wed, 15 Oct 2025 07:38:32 +0000
Message-ID: <PH7PR12MB8596E4E3C090C148BA8A528582E8A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250808142721.408998-1-bruce.richardson@intel.com>
 <20250808142721.408998-3-bruce.richardson@intel.com>
In-Reply-To: <20250808142721.408998-3-bruce.richardson@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-15T07:38:23.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|DM6PR12MB4315:EE_
x-ms-office365-filtering-correlation-id: 854726d5-6e12-4f4c-4899-08de0bbdd7a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dVNlVStINFNxSmwwQjI1NGdZT0ZPd005cHdTYm1pdnhnRStGZGROUXJ6Rm5I?=
 =?utf-8?B?OFBaT1lhS1NBOVRGZllFeTBSZFdTUlVtOUZPYWV1YUJwM1MwZEtqY3pzU2t1?=
 =?utf-8?B?VE1mU1dPTHlsY1I1TTVRdnU0Yk1hbWVEakpNYmdqRTBjL1E0Z25IYzRVRWNB?=
 =?utf-8?B?Y2NNVFhOdnlKamVCUTJjSjNzYTVyL0RoYzBwSHIwRUtjSDNDK2I5MS82bjNo?=
 =?utf-8?B?UW5uYXJoUkVxSFRhY1VkRHVuaGJMN3VzTlpBNVlhb3FXZE5rNjZWNmhwNzJn?=
 =?utf-8?B?d2RCd1VCZzJyRTEzeEhLQ3ZtY0Jqd0xsdUc3S2MySUphcVNmTFV0Vyt3a3lF?=
 =?utf-8?B?UU1FdEFEYk4zc1ZWdHAvVjh2RFBYZzYzTUkxL3hLM3UxZXNSbjVlV2VlMmYy?=
 =?utf-8?B?OENxN2l1dGlBdGRNVFdybVpueElnMzFJRVY3TkRNYTczRUNVeEZzTlZJMW1v?=
 =?utf-8?B?WWNiVGpTaGdUaVRsa0lRRFNsVWNoOGdBbkUrRzVrYlpORUJobm5XZXdoWFJ1?=
 =?utf-8?B?WWpoR0xVWU9FRHljTEJtUVR6ck9zQlVJY0FHaUl0MEw3RHZGOUdVSk4rdlUr?=
 =?utf-8?B?dEFUQXV2ZTRnYnhwMEpNc3VBbzR0dHNDQ2pqNEZvWVBTbTBnbXlxT29VZ21B?=
 =?utf-8?B?OGNXOVRLK1JLZERWa0dCVGo1U2xBTE1IODVUclp3Z2xKZUUxdXg0STZwbml5?=
 =?utf-8?B?TUZSUTlaUFEyenViZEtBMUJHSHZMU3k3RCtOZ3RDVEdVMWh5WkFPNU04YmEx?=
 =?utf-8?B?RS92RzNkdm5SS1ZkamhOejVscUdMeEIvSW5LZ0pIcGIzd0FXZnp3YkMyb3JN?=
 =?utf-8?B?N1NzSThvbTJvWkJlRVZ6K3pYa1hNTXVybmtlSjhET2s3LzR1aGlMUkZicTZs?=
 =?utf-8?B?bFZxRTVFRnV6bCtXUGJGdUt0c0RSYlVHNitPRVh4YlRyWjJvcHFaUklJZnd1?=
 =?utf-8?B?Mm90SERkUzdLaUo0cmtQQUlVTTJwUUlmdmFyME5kNGt1N3BaUGZxbnYwcDFO?=
 =?utf-8?B?eUw3Nzlrd1NiZXFCVy9qemhYaVlCMXZLaVJQL1k0T2hMSWFTN2tGb01uWk9M?=
 =?utf-8?B?bEx6L1BxYjB0RUphMVFlcE9kcnNLQ2tMelRMdGQvTzhnWTAyL2hLTWtrUGwx?=
 =?utf-8?B?TW14QzQ0WENwRmI4dSsycElyK0xsQUpoQ3JLZEJMY2IzUXNQcFFXK2RjcjNY?=
 =?utf-8?B?TnhIS1dDZFR6cW9oRlN3Y0drS2hodWtmRC9EU0VXSDVoK2lCRktKUmpqRmZj?=
 =?utf-8?B?enNsM1FwY1d6cUMrTmZOdWZzakV5SDNxV3BEL2IwcVFtYzRqRXJyNUhmc1JW?=
 =?utf-8?B?ejdZd3hEQVRVeEFGeUFlcHpFSGo2L1BmbEFpTGt0UFc5dWVycG40b0ZLYXBI?=
 =?utf-8?B?UVRzZWVzdDV3WWFpb1MxeFN4K01yakl2TUZkTjdmaDNnakJQazF5UUgzMGFC?=
 =?utf-8?B?UHR2dDRUTyt3Q0gxcmJ5NS9naVNMTzJISXlyS2dNT1k0RkhsY0NoZzdSYmVj?=
 =?utf-8?B?V29VZ3FVYmZRVjdIQjhPTXhmVityRkJHVlNLbmNQY2xJUnB3eHYrVmdEUGo1?=
 =?utf-8?B?MVI5TG85TExKU0NPOUpvd2JVaW84NmRNZlltRVU4cXN1SlhhTmFZbUxOOCtq?=
 =?utf-8?B?MWlNamxVRndTU3VOUG13R21BWENHcHRJZFRhTmRxL045R09Sck5qazVpTytY?=
 =?utf-8?B?SVNzWEI4ZXVLcVNpOWVwNHAyeXRnTnR4bXBVWUxDZUFyUkhlUmtJNlBDbzVT?=
 =?utf-8?B?NkJhQWd1Wmc1SUVQbEhnTk9qZEdWcVd1N3QxVjVvMVp1YjcrRVBYL0N2RFRX?=
 =?utf-8?B?UnFDMUtURk9wMXZXUUdpcDR5dXJweFFWOGJLalFqNUFCaWIrdGVQdlNiMWtE?=
 =?utf-8?B?K2xaVU05YWg0ZU5vV1U0Kyt3T1JtcU43UFRZUzArZi92VXVhcUR0SGJqbG5U?=
 =?utf-8?B?Zk5lV245eG5nVGlaV2VmSGlKditHMVp1QjJzUkNDTHVNUzVrekZFME1XT0d3?=
 =?utf-8?B?eVpaeDRpU3JVdEZreGFERXprREpMQjA3UVNzbHZwS3V2cWI1anN2Q1BYWkd2?=
 =?utf-8?Q?f6fvFC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RG02N3kzZVlRS1dudUZ3NmdlMjJLTmp0RVpJcjYrWkMvZGVSeVJ3cGhiYy9m?=
 =?utf-8?B?WGgycWV6dU9pOUZlT0t5dGp1UUFhQUZuVlNxbkNncllJUENNL2FSYloyMkky?=
 =?utf-8?B?NG5SM0Q4Ymc4YUlxT3kvWVAya3dnZzY1Tnh0eFRIS1gwT2hkdThXUHVQbHFF?=
 =?utf-8?B?OXBaUWJXcUVEK3dYZkxBZWdPUjNXeE82UjFVejk1MktqcU03dkFUaTZHNHlu?=
 =?utf-8?B?V1pVVTNjK1N1MWJCdmQ1WnpHTkY5d1FsUnMvSzRUdng3d1BrMW1hdjh1R3dn?=
 =?utf-8?B?OHNieXA1cWRJL3kwTjBHMVB1UUh3OXJ2ak9CMVEwSWJnemRVVzlZcnowbmlo?=
 =?utf-8?B?MFJnS3ZtVHY2RW90VTR6OW1iVC9rcW4yRU43YVEvVkFsWC80bzhFME5jaVVZ?=
 =?utf-8?B?dVgyQ092V2ZVcE5wNFZlZ2F2TzZTZWR6ek1TaEdnNFdrVytuT3QzdHROM0ZS?=
 =?utf-8?B?NE5GMEFpMFRrMWlWUjdxMHN5djVyd2M1eVVFRlo1VXhiL3pueW5Ybm1vRUZT?=
 =?utf-8?B?TG83aW5QckZZZzI1bkNDUEtWVU9nNTZ0QkkrTkd2YWpZOW80QWcrdDJnY2gv?=
 =?utf-8?B?ZWJ2MitzTG91aXNwaGZhcHp1RE1rRitET2ZScm1zMHFzK3hFeUZYeU9mM0FY?=
 =?utf-8?B?SWFqWWtIb3pGK3UrR082UjF5b29YdGk3ak1RbmJua20wZUNLWmFVbEwvK3lz?=
 =?utf-8?B?WlZVMWRqdzdJUVFZV0kyMHhpQnpjRVpWS09rY1V1OXE2WFdLdmRTU0dtRFBO?=
 =?utf-8?B?NVhXd1MrUmt3R2I1UGg4OENhRUM4VGVlRk9oR2FQMWRzVUU5QTdWUUdjVEp1?=
 =?utf-8?B?SER3T3lUb3RaZHdvQnJsOU5qYUNBdWRnQnVrRmdoZ3RaaEdZRlVKK0VYQjV5?=
 =?utf-8?B?M1lhdVJzZG9oOHlRZWI2N2NXM2VNVWpKQm9JZ3pNNjZRVWk5S1hYLzR0R3lk?=
 =?utf-8?B?YllQMjF3cmJTRlhlT2prbzZMUGRYaUUzdmpJM1h6d2xYaHRGaGUvWnR6Q242?=
 =?utf-8?B?WXVrQzVJcHhTbE1TaW93dVpaUTVpb0xMVnNkQTlYcUMrSGkzSXYyYzFYNEZD?=
 =?utf-8?B?QW1IQWJydGhJN0V3VnhjUWs4R0lnTnhoeTc3Mm85UW5xTnRsN01IM0hIVlhk?=
 =?utf-8?B?aXlSVkoybC9aZ1RaM3VKb3U0NWc2QUc3b1NHVEJCWGErc2E0cXVPaVFLUkor?=
 =?utf-8?B?SXpaV0FCY29YR2pDdjEzTGpVZm5zdW5sUzYycDlGR0FHRnlLWmhhcTdZcG5M?=
 =?utf-8?B?OXk3VUlMQ01BQzN4MkpBZDRRL2JmTGdrQ1AzYWhMaHFOYnBTN2VQQlp0V2w5?=
 =?utf-8?B?djE5SE9RZ1ZSekRJVmoxTWpjZkJYUzdvNEQvL2VmS3l2WGRhaEFUY2ovUTlk?=
 =?utf-8?B?YXQxaHhPdlRZQWdqMWNwTlUvUGFpMmh3NG1OQ0VGbU1PeW5ZYmxrTXQ0MlUz?=
 =?utf-8?B?bWNVemUyU1JaR0tDWG0zSEh1WUFLK09Ya29uK2JZR1hiUVE2L3RrazNXSGVz?=
 =?utf-8?B?VExpbGtybk5DcnFXNzFBaDRVb1ZsbzAwbWU0ck1RZEIybE5DcnkreWxXcXJN?=
 =?utf-8?B?ZFpJSjBDc3Z4TGpESWN1Y2VUcEpJUHVQUiszTTB2VXpXNXZicW5ZeU9DWUg5?=
 =?utf-8?B?ODBtMUxobHZGajZpVVJuVE5HUUFjWkxSVTdxUWlCNUlTbHB6RzN1am16Yita?=
 =?utf-8?B?ZUV0Wk14cGY3NnhQWjdNMG8yVDh2dW5icXU4d0FoMmtoTzZkTGc1N0dqZDdr?=
 =?utf-8?B?QlhhRkpkOEZHMXVpaVBtWG9qSUF5d3l6SHlGR0VMVE9RdDNHV1F5MS9SQ1Qv?=
 =?utf-8?B?RHJSdWExWDRucDR1c0RINUhJSFIrOHp6UGNWYmZRWURSQmlocTZzSlBuWEF4?=
 =?utf-8?B?MzVOYk1ZaWJFUGpmSzdNUjJCVVNsT2g4MXU2dEo0Z0d6TVJCQnQ1aEZaVnZu?=
 =?utf-8?B?QWxWL2htK0JmeVBodDF1bkVlMXVmZ0tDRW9ibUdmVnJYbGZXK1kwaEdWN0hM?=
 =?utf-8?B?M0ZzOWMwM2tYdy9hSzZBY1FsL1RON0FjRDBHQXVsTkZQMEloZFJmSVM5NFYz?=
 =?utf-8?B?dnVoNFkwSXlhUXNCc1VYL1E2UG5Jamp1MjdIUm5MUHBXa2JpaUdvVityS1NK?=
 =?utf-8?Q?cgjISsxw27HwaT7WjIxr2UycW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854726d5-6e12-4f4c-4899-08de0bbdd7a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 07:38:32.7142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U26KxaEFoRZNaJUlBJJBsgr+y7DYLFGufCn9IzL6ibO4LHJjkJrc8Ht50e8XVcVV+xTaLrNniKLGqsllHLN3oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315
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

W1B1YmxpY10NCg0KKzEgZm9yIHRoZSBjaGFuZ2UNCg0KPiArVmlwaW4gUGFkbWFtIFJhbWVzaCA8
dmlwaW5wQHZtd2FyZS5jb20+DQo+ICBWaXBpbiBWYXJnaGVzZSA8dmlwaW4udmFyZ2hlc2VAYW1k
LmNvbT4gPHZpcGluLnZhcmdoZXNlQGludGVsLmNvbT4NCg0KU2hvdWxkIHdlIHVwZGF0ZSwgYCBW
aXBpbiBWYXJnaGVzZSA8dmlwaW4udmFyZ2hlc2VAYW1kLmNvbT4gPHZpcGluLnZhcmdoZXNlQGlu
dGVsLmNvbT5gIHRvIGAgVmlwaW4gVmFyZ2hlc2UgPHZpcGluLnZhcmdoZXNlQGFtZC5jb20+YA0K
DQo=
