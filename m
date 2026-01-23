Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB139D625E5
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 06:59:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A7F0402C0;
	Fri, 23 Jan 2026 07:59:02 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
 by mails.dpdk.org (Postfix) with ESMTP id BFCB940299
 for <dev@dpdk.org>; Fri, 23 Jan 2026 07:58:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/Y9Lb3VTbEvcQXKYtGJii0ahGMpQPFUgWJJsAoQ35KfiYCx5HP0TKvEudbhibgGO8ApCeHULMoEqJOMdMOw+43Dl4/B8dDxIaEUqVwzwEDHK6E75QRmUfZNRlIy2nra98jXy5ir0rFGceqxC+mpDYtSUZEI2+XG+GWde9Bqlz4H+BgW3KaCKarqWKgXJqKBui14wqYYAk/tIdZ1LIf9IKuCemMAnhBM9F5ZQoG0zrkOiSYx216ImDzBnOexa5exHhWy1nwTdjgG/5ChyFM4NIS2bj02IF+f2126qQAwlhCKajGLMFiqh9+rbhb06jT5+gsPj9cDd99Nlh+Z3DRRyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=up7iseDTyO6sqsHYEwIYuQfVCKWH3O1MGL8zZOs5lzU=;
 b=XK/WXZXWIQglgPORiJX6mFoCUC9XKq2VEopznO3oymYJQR+U8rVH1cPLMrUdRmozblYzaORHnClA1esOrRT0i9aa/xz/8+/QOTufDhQyaZkdOroypsx5NvVzolIvahHbnMTMJPUYtsO3QOvS+eKV0QgXhOfTykkUBq4Paft7nd8x52xeMWppNgUFh1njvUMYq01Fb4Z6N+J0LPBsOmBCiAJWSSja7bljBeoiy8Bc+0sKWXHcpUBistHBjXTsI9cPiXa0NQVfQtBWECcOR1QSdL03FM5A+QKpbS4ynOkU0/f3lciZ5BLaEiJkA/H3Ka5FAsXEI+F10aWj5mB/+L2nug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=up7iseDTyO6sqsHYEwIYuQfVCKWH3O1MGL8zZOs5lzU=;
 b=YP5l3Oc9eVroAQuFHn19gjIVh9xia1sDBBOZ71mN77qo6E3rnsqtvE3xb479wc+TIMFhV0OsUN6VZdkhncNywEriO1RUYhL1LgCdLaGd6ow+iZ/3TnAxBIgT/fwvoyBkR9OSsOCB2IwX/sO4F1vQBoiUJLJoGKH53nY5sGlpM6E=
Received: from SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 06:58:55 +0000
Received: from SJ0PR12MB8615.namprd12.prod.outlook.com
 ([fe80::220:c7d1:9e75:8fa6]) by SJ0PR12MB8615.namprd12.prod.outlook.com
 ([fe80::220:c7d1:9e75:8fa6%4]) with mapi id 15.20.9542.009; Fri, 23 Jan 2026
 06:58:55 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: "wangliangxing@hygon.cn" <wangliangxing@hygon.cn>
CC: "dev@dpdk.org" <dev@dpdk.org>, Bruce Richardson
 <bruce.richardson@intel.com>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>, =?utf-8?B?TW9ydGVuIEJyw7hydXA=?=
 <mb@smartsharesystems.com>, Stephen Hemminger <stephen@networkplumber.org>,
 "P, Thiyagarajan" <Thiyagarajan.P@amd.com>, "Murali Krishna, Bala"
 <Bala.MuraliKrishna@amd.com>
Subject: RE: [PATCH v6] eal/x86: optimize memcpy of small sizes
Thread-Topic: [PATCH v6] eal/x86: optimize memcpy of small sizes
Thread-Index: AQHcg7uDLBHaOyG5bUy6tdTsisR14rVQvruAgAouhgCAAAgkMIAAAOaggAGXv9CAASlJcIABqr8w
Date: Fri, 23 Jan 2026 06:58:55 +0000
Message-ID: <SJ0PR12MB86159103FA41E00B9D4D92AE8294A@SJ0PR12MB8615.namprd12.prod.outlook.com>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20260112120337.277331-1-mb@smartsharesystems.com>
 <20260113151943.31c58217@phoenix.local>
 <PH7PR12MB8596A21E5892BABF88665C5B8289A@PH7PR12MB8596.namprd12.prod.outlook.com>
 <PH7PR12MB8596F1FE29BA757F8884E7A98289A@PH7PR12MB8596.namprd12.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65677@smartserver.smartshare.dk>
 <PH7PR12MB8596838852258FB94342042A8296A@PH7PR12MB8596.namprd12.prod.outlook.com>
 <PH7PR12MB85961D3A7388DF0C0445915A8297A@PH7PR12MB8596.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB85961D3A7388DF0C0445915A8297A@PH7PR12MB8596.namprd12.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
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
x-ms-traffictypediagnostic: SJ0PR12MB8615:EE_|DS7PR12MB5909:EE_
x-ms-office365-filtering-correlation-id: f6235ea3-6abb-4811-e33b-08de5a4ce005
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bDZ2RXQ1b24vb0dBZVdPbzVXZndOMWdBdENUT2NpSkRyQWg3d25lYnhKNFVl?=
 =?utf-8?B?dU1USUtxSVpBMWUwMCs5T1Y4VWU0cjMrMnQ4RFl6bmR2YXFuVkMvQmxGaUJK?=
 =?utf-8?B?NVI1M2s4WlM2T1piRTUvNityeUluWTZ5cEZIRHNSNjJKd01qd2hVYjk4MldT?=
 =?utf-8?B?NE1MYS90eXFpdzVLVkYrZDJ5MVBTODhaTHBvUEdBOWpCbERzbkp5MHI4Qjho?=
 =?utf-8?B?ajJydmNkS040ZXBYOTYrZkhOMUlGZmRkd3VtVXREVEtEZWpRYjJ0QXI0WWtk?=
 =?utf-8?B?TFR6am96NTMrNHFvRUM0N3NvU0F4M2dMWGRueGttTW5FK2Nqa05Ya2g2cEt0?=
 =?utf-8?B?d1ZPRWJVbWZPYnU2c0pOaTZocHd6NzFBd3YvQm1wbmNTRVdPQ0UwYm56SFUw?=
 =?utf-8?B?ZDh6bGpUWnA2Zy9iWHg4RWxJbCt5OUZZa1JHa1BwQU5UTVNOcCtZT1pVRUNK?=
 =?utf-8?B?L1NlcDVDYzFJNmxzZHFhNmZOODdDbTJqSHBmNzg4THpsSFIzVFhwY1JISFBE?=
 =?utf-8?B?R3JGcE4rVTBMY0lVc2EzRE9HM3c4dDBreFlrbXlxdXl1eXN6R1hjejVSbGIv?=
 =?utf-8?B?ZXRlMHg4S3lONFg3L1ZUN2JGb21Yc0FKSUQzanEyNmsyY0pMS3hNSmtwbm9k?=
 =?utf-8?B?T21GUDFDNW1VY3p0WWdMOGI1aFhmTDUwcFJPblYybFo1WEJMbVQ1aDYvTVpw?=
 =?utf-8?B?OUtlUmcwblNObEVSUTNvSHdQTU5WT2pEMDdUZWIyNTNuY1JXWXFoM3B4Z2JM?=
 =?utf-8?B?cFFrS29XSWhxbzNOb1VwZldvcjkzZlRySWs4T0FJVjdTZE1vL25wbm1jZitp?=
 =?utf-8?B?RHkwQlF5WWtzbFFCSFBqenVvb05MZ2ZFNHAvMnJZYVFTN3IzNmtLZzVUQVd5?=
 =?utf-8?B?WExjWGhyUmI2SWpiMkhnb3IyeXBBUVVtZ01FeVZnVDBxaVZsOUFnWFowVm5x?=
 =?utf-8?B?cDR6R09MZStGdTV4WG04bkh5bk02T3dlb2EwZkRzam5Da2FVYTJzeWRuVTdR?=
 =?utf-8?B?UVFIeVkxSDJSdE0zVGtDMWdRS3lwWG1kaDFjN09xYXRhZXRQaWFxd09JYk0r?=
 =?utf-8?B?b3JCcXZ2VXF2dXpSWHY2SlF5Z3Q4T1B1SGNyQzlpK2lxdjY4cG5RK2tPK1Fz?=
 =?utf-8?B?NllWSXdtZmV4S0VURVFFN1p0YWtJaEFOVE1FZXpKVDBMMldIM0YzUnVoKzNN?=
 =?utf-8?B?L2RoZlZ3bUdCbHVGZ2ZJNURZNTdKbVp6Z3ZiM21jOGp5b09yOEFMUTlHYkJq?=
 =?utf-8?B?OXpVUHVSa3EvSS82QmlGT2dudlpGaEdNRXZvUFJjbnphc3F6U1RVN2NvdUQ1?=
 =?utf-8?B?aERFSGpBcWtyMWZtZjRtc1dXU0JkQ1hoZzFZZDZReFFxbFcvOFdlWkU2Vkpt?=
 =?utf-8?B?RjZmVXptMGp2WDhPZHZ4TjhJVy9ZL2cwemhoait6NFNtSW5HMURNUzgyL3dD?=
 =?utf-8?B?U3IzcGVZMndnWFNxNGhORzBXM0hEdDEvREsrc3B6cDdRTXpkV0UwS0VFY2g5?=
 =?utf-8?B?Z25xVmgra0VYbm1KZnRCRWpXZW52Nmc2Z2t0emtOa2g1RVUzWmVwcERlbnRO?=
 =?utf-8?B?LzlCTmZKZGNVaVZOc3RzMEFLNUZmVWQ1dHl6NlRPbEtNQnQ0aStoT3pidVpI?=
 =?utf-8?B?U3BpUmNta1pGV2pac0NYU0xLSzNBczFncVF1WGZJc3VJUndqLzlIKy9acFlq?=
 =?utf-8?B?Wk5BSGdBNEJUdDEyQVJkV0tMN1EyT2FZQ0RmenNTOHJTMEE2MUt6MjhBUkdQ?=
 =?utf-8?B?WHhPMnlzazMweXRHNW9CMHJqaTNHV3ZiZloyRW5WdTZpQmdLKzR1SFFwelF2?=
 =?utf-8?B?amFhWlhoU2NLMlJ0Q1JwUlZ6cXJzM2gya1hPNFJ1Vkh4V281ZE11TGE0ZVBV?=
 =?utf-8?B?VzA3cG9yT0tqOTVqUi9tWTQ4VFM5ekxIR3pNeTZ0amVIdmNKWE84SnhQZDNh?=
 =?utf-8?B?Y0hCNFM2WTRPbWFHdFN5UXJCYTE1VTJDbXVOcUVNc1pCVkx0K1I5Z0l0RWRG?=
 =?utf-8?B?dlhwWjhCdDdRRWpFZDZLc1NucEkxallOc2tOQmZsUWczdERRSUdYUVFBQmxr?=
 =?utf-8?B?Z2NYWTZCWFdTaGxVMlE0M2R6dzdIeHh3NHJpdUtEUUVkOTI0akxVM0JETzVy?=
 =?utf-8?B?VjRhOXJGRzczMFlNSTFzaVUxS3RlNEdnQnNLcyswREFwblRkSnN3RFJhUllq?=
 =?utf-8?Q?6KM69AaVyL3VWA3uVgHFcgM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8615.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHVOSTltZnUzUTFSVXhoQitCVno0WkIzVmIxQW5FcDNuNWZCRzlVL1oxM2hh?=
 =?utf-8?B?N0Z4USt3aGhkN2h3N2Y3dzFFaDVRQWNHb2ZteDdqVWxVR1FLd1NDV2w3Yi9l?=
 =?utf-8?B?ZjVnd0RZK3BsNnVBQTkvYmdzUk5RcjIvSXRUWXBvNEZSN3Jia2gyRGYvQWRD?=
 =?utf-8?B?Ujd2RE1jWFdJeTlIc0hTSllkS21RbXJpd1hheU9iVXNCaXJxTGRyaGZ5ek92?=
 =?utf-8?B?cnlBRExtN21Pd1kyeFlXYzdBYU9WNmdaOHJrSFBsZnJYNzd1b0tEekxQNkVo?=
 =?utf-8?B?TVI1VHVnOWVWQWhEL0VWOGpFRUF6UllSeTJTcVBwS0c1WlJ3SGpBSkkyOFlM?=
 =?utf-8?B?dDNqZStRM2pRaXhMK051SHZ0R2tHdTRrb1RRVTcyaVZBNml5R09uQThKUzR4?=
 =?utf-8?B?eUtnajk0TTRxNGVPRk5RN1ptUlVSbm85N3JuMk01UWVocVRWRE5oSWY4djZk?=
 =?utf-8?B?QklncU1Uc3UwOVBVeFZSQWxxVlp3b01CbGxSTTZVV2QzMWRESDVCOVVkMGFm?=
 =?utf-8?B?SDF2QW4wWkthejNoYjk5eFhFeGlxVHJhbldWbEdBY01IVDNnWk1sUCtOUHlQ?=
 =?utf-8?B?OVB3Vjd5dWhOYWNzcGNQYXpiMUQ3bFhOS3ltUCs0R3FlZGlEbTE1VE10Vmxs?=
 =?utf-8?B?UU9PNDJGZjNBVXhDWVlUYVZDdmZPRlJ2NVBwQVI4cGJzK21DeklaaTg3djZH?=
 =?utf-8?B?UDd6Vk1IVFNTUmRVTDRCM25hbUUvQ1JBaU9oQmM1bExkNlI0RHN4Yy9Dd3FE?=
 =?utf-8?B?VmI5NkZHbmVRWHNGZ08yWDlLV05lS3JYSlFkbHFsZS9YR2dXSmEyREpRZysy?=
 =?utf-8?B?dEhEdURabkNHd3F6TElMejNTZlJYZTMvTiswSkpaK0VselVFZUlJYTZlN2l0?=
 =?utf-8?B?OFljbWt5bmE4NThqUC9tR1dxQVhuSWJ3UWsrREtqNGRMOXF2OExOVGRndC9l?=
 =?utf-8?B?bFR0U3JaLzE1ZjU3bm9PMjZ0Y0x4bjk5RGczL3NZZlZEWHV6QU9oRkJXSkdp?=
 =?utf-8?B?em9tNVdHMUdPK3lONnFsRW9mVHRLcEJUbXY3bVN3UEpTd0NqM1EwOGFSa20w?=
 =?utf-8?B?NXllREFTRWZ5NWFGYytRSzAzc2k3ckFORWpHNmpNSkd4UmFKclU0MFcxSXda?=
 =?utf-8?B?T1BkYmVScVQ2amhuSXptenNsS2pLa2QyWXQzMXpSS0JRT0tIRGpiVFBWaXNB?=
 =?utf-8?B?amYxenJST2ZRY28rUzJXQ1B6R0VRZUFpVDk1S2VnMWhxMXJQYUNxNGNXM3dF?=
 =?utf-8?B?RXVXcjdoUUpiVmZiWDA0Z0xYMWpFZHNGWUxIOHc1aTJKL1lIKzlGak95Ymk0?=
 =?utf-8?B?ZnFhRXQ4VHJZcklGbm9YK1AyaEFydzMwd0NMaWFIM2hmVEhKcTVSOCtFcW1k?=
 =?utf-8?B?ZDJYYU81WmgycjZJTkZFTUFwZEtWbWllNWZwNWVtR1luV3dkaWpaRWRFMXpY?=
 =?utf-8?B?T0dBMU5WekhPYmZmVDdqSjJabHRiZzBURFRiYkFucXdLUTVBTEY4d1FCL2tB?=
 =?utf-8?B?YVc0WGhrUkVlY0UzVUhONndkWEFna21ZZjgreEpiOXVCd3gvN3YxbVI4elhx?=
 =?utf-8?B?YkF3MmhUdnlua0hRaEVlYzVpYXZIRHQvc1AvTk94L0duWU12THMxRnZGbU44?=
 =?utf-8?B?MGhiYWxzSkxWWXpYVTd0Z0djVDdjSnMyYlA4cjczU2FDamNTQXlzS0l2UWNs?=
 =?utf-8?B?RmhUamFVaEFHTUZsYllPbG5Pd0lHSmt6eU1HUWswNXhuTTNkUGVtTC9LV2Jk?=
 =?utf-8?B?b1BPTEROaFVHOHBWQXBOQ0VuRDNIaDFIZ1JiamIzbHBVVWhlWFdPd0c4WXFp?=
 =?utf-8?B?T2RLK0ZDU2hiSXpaM2lsS3pGTkZXbGRaMGphVTdrUk9YVEhKYUJ6UVVPTFE5?=
 =?utf-8?B?SEc1UE5zblBDcVhKSFlrTlluLys1eXNZVFFtUkFMcXhlOW1vZTdUQWlJSVVD?=
 =?utf-8?B?dnkxaEhPc1FoZFNNV0EvTWg4cHlIalJaa1RGZFpEREtSRkVJR3AyMnNEY2N4?=
 =?utf-8?B?VVlXSnJVOW9iNGduTWxFNlhod1k1dXNxRldVVlgrOGZsWnh6N3BkdWNvV0JZ?=
 =?utf-8?B?dWNNSzZLVGdqSHBRY0ZsRytXSm0zMUVpczZhN1BUeTFyb0pyS2VMMVlBVGtz?=
 =?utf-8?B?RlQ4TUtscUNiaGI3SXJIRHludVVaRGd5cklqcWRIQ29XSkF5TC9LWThPZTVQ?=
 =?utf-8?B?NHgvVU1paDRKUkV6T0lPSmhwRk42YkJuSVB4V0N5Y2lvWWRBaDJXSnJJUGtt?=
 =?utf-8?B?TVdiT0VTakUyNVVWalNndU1zSVJEdVFWMFNCVXAwc0cweCtvWjVmeTV1N1Q5?=
 =?utf-8?Q?MfhlRjY3eIWFIiJTzX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6235ea3-6abb-4811-e33b-08de5a4ce005
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 06:58:55.5418 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4XBMuFWkgBRDWrEplPWnVy4yEuOEOgfqxT92NbsCfGfTzZHxMuCmT8rKH8ARLL3HybzmZsFr26ixoWRxj69vfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909
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

W1B1YmxpY10NCg0KSGkgV2FuZywNCg0KV2UgdXNlIGRwZGsgZG1hLXBlcmYgYXBwbGljYXRpb24g
Zm9yIHRlc3RpbmcgbWVtY3B5IHZpYSBjcHUuDQpQbGVhc2UgZmluZCB0aGUgaW5pIGNvbmZpZ3Vy
YXRpb24gc2hhcmVkIGJlbG93DQoNCmBgYA0KW0dMT0JBTF0NCmVhbF9hcmdzPS0taW4tbWVtb3J5
IC0tZmlsZS1wcmVmaXg9dGVzdCAtbCAzNCwzNQ0KY2FjaGVfZmx1c2g9MA0KdGVzdF9zZWNvbmRz
PTEwDQoNCltjYXNlMV0NCnR5cGU9Q1BVX01FTV9DT1BZDQptZW1fc2l6ZT0xMDANCmJ1Zl9zaXpl
PTEsMTcsMSxBREQNCnNyY19udW1hX25vZGU9MA0KZHN0X251bWFfbm9kZT0wDQpsY29yZT0zNQ0K
YGBgDQoNClBsZWFzZSBhZGFwdCBlYWxfYXJncyBhbmQgbGNvcmUgZm9yIG1hY2hpbmUgb24gd2hp
Y2ggeW91IGFyZSBydW5uaW5nLg0KQ29tbWFuZCB1c2VkIGlzIGBkcGRrLXZhbmlsbGEvYnVpbGQt
bm81MTIvYXBwL2RwZGstdGVzdC1kbWEtcGVyZiAtLWNvbmZpZyAuLi9jb25maWcuaW5pIC0tcmVz
dWx0IC90bXAvbWVtY3B5LmxvZ2ANCg0KQWZ0ZXIgcnVubmluZyB3ZSByZWJ1aWxkIGRwZGsgdG8g
dXNlIGF2eDUxMiBNRU1DUFkgdXNpbmcgYC1EUlRFX01FTUNQWV9BVlg1MTJgIGFuZCB0aGVuIHJl
cnVuIHRoZSBkbWEtcGVyZiBhZ2Fpbi4NCg0KUmVnYXJkcw0KVmlwaW4gVmFyZ2hlc2UNCg==
