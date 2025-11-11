Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B82CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:14:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FA7640650;
	Tue, 11 Nov 2025 12:14:51 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 1B5604065B
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:14:49 +0100 (CET)
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB6YimZ004654;
 Tue, 11 Nov 2025 06:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=g
 H/XMg9ob9sUunI+IiEXU8iEy6l0V2W3tcic6fSRBd0=; b=Mu6esT+JMKLC/TPnM
 yZePgOiyQ7CKHrr1SACIAYVpFagMk0xRrzkHBpDQ7x23REU8wKPWf7UollsKwJAx
 aTs7KBLDj+JCVj+kwIOLiOJRlID8+KYJZ/A+MwIVHdhaD86lCziCm1+zAFVEIUUU
 KOcg5KYVTlTEuWhJuXzTJVgEXyP2LuTLmP/HJ41k4FFv3PvivE4jXU4kg3aRObeg
 VZS2Wfy5VdLES/T79asCQ5FoOizrDZOZm+rBQGNxOjdxb8xCN+uEu0WL1z5THdWt
 oxaoPngoDOY4Q6a5GqsAuf/vNph1P+lmXZQo1fLDDdfxGU+KI1e8/ZQO+WyVPCgH
 BQrIQ==
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4aa1t7byj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Nov 2025 06:14:49 -0500 (EST)
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABAAQYN012004;
 Tue, 11 Nov 2025 06:14:48 -0500
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4abxvj3qn0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Nov 2025 06:14:47 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsZEQgftJ3axG6egT+1FfKraM2XuxLmnEbw5OmQWTDb3ubEYg5CGnaiw9stbVjdY+urJih8s0JaatWpy2j4UUS0XOgX55Gv3T9tWbek9e2PVw4tOnXdyDN8P5YYAJU+Ex8s6H1J0Srw9JeakrG1ghESinkQTk4Q0uFX5FkNiAjsD1LVHI+1XBf3t7oKlLzH7/lF4/jO1M7OktSqMNh62WS7lo/5ILfdOYKnicZDx5rmbu15oUiuhVY2R3mijQGs2JNzVpjaDEooOov7sQ+asqB/6d/UzhoulimP21SnVeCKWRZuuxOXnYKo3Liuu0639EeFWSgopHU1NjJTAz6uGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gH/XMg9ob9sUunI+IiEXU8iEy6l0V2W3tcic6fSRBd0=;
 b=h2XOUDQtsPSbfESKs4r0QLgpnxHy74kiZWhyYtPOVIdWsRMgVItVIiqLjBdMDj/RWgSmfXRJLUWvC58UHw4nmENW4BGlJFMN/NCTTe6VaQ9ZgkDLGn6ubQ5zCWVYM+JswYxEgNuxVgttcY6ObnbSG7WaFHIkRFD+yiofE+ERrRogZgLW9I9A/CcKD8luATXvZ+C3Kw4y7pM3gw4CSufzR9G+h11LvDZQ9fDvIu1NpVqVrryAA677CM29Fu7oO4LPTf42TG1//DklKg3yA4rROY7QvXdT3GVNmyxUQqV1H00q8oSgpk9QLwKeJiB5JV3kexRjGuSIPm2t47Kgb+O4IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by LV8PR19MB8548.namprd19.prod.outlook.com (2603:10b6:408:260::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Tue, 11 Nov
 2025 11:14:44 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 11:14:44 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: fengchengwen <fengchengwen@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "pravin.m.bathija.dev@gmail.com" <pravin.m.bathija.dev@gmail.com>
Subject: RE: [PATCH v3 1/5] vhost: add user to mailmap and define to vhost hdr
Thread-Topic: [PATCH v3 1/5] vhost: add user to mailmap and define to vhost hdr
Thread-Index: AQHcTUKiUDYRLaZ1/kSih3sao2hjyLTiGvgAgAtDAXA=
Date: Tue, 11 Nov 2025 11:14:44 +0000
Message-ID: <SJ0PR19MB460673D899237DEFC7861179F5CFA@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <20251104042142.2787631-1-pravin.bathija@dell.com>
 <20251104042142.2787631-2-pravin.bathija@dell.com>
 <ae3c917c-42f0-4764-836a-292cd89b7a53@huawei.com>
In-Reply-To: <ae3c917c-42f0-4764-836a-292cd89b7a53@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-11-11T11:13:46.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|LV8PR19MB8548:EE_
x-ms-office365-filtering-correlation-id: 996f1733-a70c-47ef-9c9b-08de21138483
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-7?B?SlVtZVJJaVg0SzNMaEZWKy1lYnRQem5xQnUzZTVxcEkvT3lpRno3dDR5L05E?=
 =?utf-7?B?T1E4bHBCY0VhZC9qZ2VtTGNKMFE4TlpjM0V5YUg5ak5udUtBTkt4Wkc1b3Jy?=
 =?utf-7?B?RTJmWUhQSDZteEJDTU03bkJXQldqZnRFSnNkTEp1Z1hML2U4dkNqcTBqU2V2?=
 =?utf-7?B?cXFsYXcwY3VDTmVKYnZEemp1WnFOQXk3MGs3aEhpNistVDVOeWVXenZ0WDdt?=
 =?utf-7?B?bkdDS01neGU3TVBlKy15V3Zzb0ZHeE5hZnFMTDJtVEo3TTl5RlpDMFovODE4?=
 =?utf-7?B?TkUycEorLSstLzA2YkRVQy8rLU4xdTFFWmNYZXdoMVV5UUdiWUpoNmlOb0M=?=
 =?utf-7?B?emMrLXh2R3FwM2xlamF5MDdCQlM3S1V4NkVkNDcycUhud2t6Ky1WMU5TWjcz?=
 =?utf-7?B?Q3ZsQWpmWjRQMU1taTdHbjdhVDF4Y3pLNDVZR1FxVHU0NVY0YUNVVUlwWTl1?=
 =?utf-7?B?aktwdzArLTIwMGxyWUdmSEtDTXJIaXNsMk9WZnpqUzc3U3BDNm9BUkxldVZ4?=
 =?utf-7?B?WTdXeWFMcTRWTmI0TzhKREdHWlJaTnZleURIQTRxTkJxY1ZGcEcrLVg4Q0xk?=
 =?utf-7?B?MnhxYWkvUjg5RGQ2UWhBS0pwZ3RIR3p0YW5OVjdKVmVhQmJEeHRhcW4rLUJZ?=
 =?utf-7?B?bmVBVThKTy9WM0VmSVdCbnF3eXpReFM4dGRaNHRVS3VuWm1iWC9rbjRqbWVh?=
 =?utf-7?B?WnlkMElUOUI4VXNkV2VUUDViMlVCQld5TDgwS1VmYnMwaUFsUklKNnkxZ0lx?=
 =?utf-7?B?UDBYcmtqSVdTenp2a2NGbzBxaVhpcTNBdGpPU0NkU0VGcFdVcVU5ZU54U1Uw?=
 =?utf-7?B?RDM4YTEyb2NFQmpXMUFuMk92V05kTUgxc0hON2N2bFRrQlhwZ2RUMnpNWHYz?=
 =?utf-7?B?elZJWTZ5ekRzZ0lqYzNVR1g0NDdoeSstbHFIeDRXQ3lqUHRKSUJZREFjenhu?=
 =?utf-7?B?TjVCZVZyKy0rLWgrLVpqbDV6RXJGM3JocURmMXB3RGZWZWJZejdXSENZZnhV?=
 =?utf-7?B?ZmowSGRWY09vYlRiLzA1djk5QXdTdk96cTVLU1E1TzJBVlBXVXZWQmxaWWJS?=
 =?utf-7?B?ZWZvMjVEZ1VvSXNCKy1EcGRxSDBkRDVycWZFVHcyOVBVUi9PRUkzRlNOMkVN?=
 =?utf-7?B?eHEvTmxZam15OWhGUjBzS3NvbDh2bjlHNHltaW9WYy80VmhUelRKcnpJQk16?=
 =?utf-7?B?VnVybDhxWmhhT05KQWZURTZDWXlhTWNsYk85c3Zob3JtZlNCNEZ4YW8rLU1l?=
 =?utf-7?B?SXB0VWo5cDJtMURqZldLTXNKMGw3NEVoL1dwNnZvTkpZMGtzUEJDNVVkMmEw?=
 =?utf-7?B?ZVFNekdTSy9aalExMzF4RUtLWXRxYTRyTndxOE1mMm1adFBGVVR2cUNFaU84?=
 =?utf-7?B?T2o0Ky1mNHYvNDY2VlpwNlpvTDhTclV6Q0MwdHNvbk4yc2d5M09Zem96dTBl?=
 =?utf-7?B?TSstd1U4Y1NVSWdXZDAxZFVQelp0WXpFNng3RmRUd0UxMmdFN2h1SHN6dHpJ?=
 =?utf-7?B?c3dyL2R0ZXpEcnBtNTJycFR6Zko0R3dpVlNsQnVySFNIN2tMa0t1NjV5YjVI?=
 =?utf-7?B?TWgxSWFlNURiTUdqb3JNMTBSZ1NFbEdxUXhVc3BXRk5OMi9GNG9IZjFrb25R?=
 =?utf-7?B?eDlKL1pWSjZKVG92RzFZaVlsZG9HSTR1dVIyM3hNWHE2b2IwVzBsTElBTUh0?=
 =?utf-7?B?RklJcUlVWTg2aG5lM0orLTZYNmIxbGxWQmFNeGhHVHM3T09tNmxKbzI0aXFD?=
 =?utf-7?B?aE9SbmM3ekxHendDNm1pcWlFa2I1dGtEeTdGbS9tdnRnb0JqQkwwRGJhbVlx?=
 =?utf-7?B?cTY0R1luOEc4aFZraUhYbWl0RDFxeUp2SlBqVC9jQVMwbmxFUFNaSXZxM3dz?=
 =?utf-7?B?N3VBWE1GKy16NTlvOTdSM3VEYlQzVXpBRmdqZDlUSDUwbjF4YWdDNGxQYkdv?=
 =?utf-7?B?Ylk3SUdUWUdxaVRZbWIwWUhnLzBuZDNEcEV0bk10cHBxWmhFTWZvdWgyVmtX?=
 =?utf-7?B?REZxNU1YaEg3dnJnam5MdUhodDkvcTJrZWF6MjJraHB6OTBtdWtET3N5RmpC?=
 =?utf-7?B?WWdsMTBxOUhTakIyY2VwbFZDMnEyVExXM09Vbg==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?cUlySUhtemxndVA0dzl3WGt3eEt1aysteUszR2Jqbkw4YjJrMzdjL21DbVc1?=
 =?utf-7?B?NjlEU0VIc2NMV1YrLXBObC96V3I3RFJnS0t4MDFRTmRHc1NzeVp6Q1JJbXBM?=
 =?utf-7?B?eFkwNlVXYlhCRFRJSmt2YXhzcUxxdmdFOE5PM1pVNTV3bFovcDZybGl2MnJ4?=
 =?utf-7?B?YkNaRDJ1SjM3ZlBlRDdJQkZWMGtFL3VLYWRVdTBSWnc0Zm81UWwvdGRUOVdq?=
 =?utf-7?B?MUQ3Sm1YSUtmMlhGcE5odWZTcFVYNkd1TWl0UndqVkNTUUU3N05TMk1CaFZH?=
 =?utf-7?B?Um9JZVVGQkZEcGV0R2Y0NmF5RnRYSWVSamdyMUJ3LzNWVTFEZ0tmd1dOYTNu?=
 =?utf-7?B?L2RUZEJsVWtoY0pEMkJHNTVoTzFVMFZqbk1GeW5iQm9pbnZzNVVLaDhlVEpu?=
 =?utf-7?B?ZWg5eWlDb1hHWWVCZU9ZeSstdG1wL2Z5Rkt5d1EvQk15OXZEazk0VGFncFpC?=
 =?utf-7?B?RGFMNlo2ZlU3d1ZaQ05jUzlIc3RKdkdXTGxaYlFKT0pXU00vNDkzdGtqVXQ4?=
 =?utf-7?B?YVBDUkRrMWNpak1MYk5SOVpYMDd4V1FhTU14UkIvWSstakJRYUNzdFVsbDFn?=
 =?utf-7?B?eWZISDZQSEk1MFMrLVFJVjRwN0tDTms2WU4yMHdoRTJmWHlnOVFwR3lLdWJi?=
 =?utf-7?B?a0RkR1piRFVVRUdmWDlNUm1IT1Z0SnFxRm1IRlFEYTFDZ01ZNWRnam5IcDdY?=
 =?utf-7?B?ZVg4ZGdJQW1PY0VEZ1ZEalhmay9UMzlyR2kwOWxiNDRsVWdMcElWSXNSckYx?=
 =?utf-7?B?Ykx5eHZQemUzZjluVTFvR1NLRy9NSWRxZDBFbHh4d2NyTnNyM1Nvb1RKUVFv?=
 =?utf-7?B?NWNPaGh6RjNRanMxUnZ5MEVXMzRnVG9iTGFpWmZlMmxKQnlMY2tZQlBCUWRC?=
 =?utf-7?B?MEV5c0ppRmE4ZTJ4aVlsWVVPcEdUR0pyQ2ZkTnRBRUFxQkR6Qnd5S3A0anJV?=
 =?utf-7?B?bWZWVVpFMFZUY3lTZzhFMHVZTVZNdU5mRUIrLW9ONGovYlR1SjgzR243NzZH?=
 =?utf-7?B?b2ppcFR3d0JtMUpuSm85T0FpNzRUR0s2Nmc2ZVhWWXFySTlmR2JES2dmOEI1?=
 =?utf-7?B?Y2xITGwyYnB0ek53dS8vLzF4ZTV3RXBYR3A1cERIVHBXcEZ3engzODRsSmdt?=
 =?utf-7?B?elNJazM3NEROTTBWTVluR0lNM1p2VG8yQmxLKy0wV2hUc3BWZGpoRnNqVmo2?=
 =?utf-7?B?SlZ4NkdQZW4zY2NlakkxNTIwMlF1dDRnMnhJaUtSTVZZcmRqVXVMY1ZYbS85?=
 =?utf-7?B?VGVoMHpPRnhmZkQ4OTVJQTNjWExzS2lTSW5INXlxTGJoNEc5M2N3MzRTMHQz?=
 =?utf-7?B?bk9JS3FlVFJqWlAxNENncnFXUlVLMExKVkphUllxNXNBWElIcG4zTUlaQjly?=
 =?utf-7?B?aDJ5d1dMbHoxd1lERUFZUmUyZHo0Mk00QzlzKy16R1huUG5xWVVTQ01XNm0=?=
 =?utf-7?B?dCstamNzVFZkMTgvMW5vbmNWbzRqV254aElNWm9NdHhROWJBeklqNEV0NnlM?=
 =?utf-7?B?MTgwSzhESlp0UlFMVFROM2t6THRiOTNPSldJS1AxR0ZDNDl5ZGFpd0pGblZq?=
 =?utf-7?B?c1g5dFpnOU1rbGJvVWxWODluR1QrLTczamhRMTliNVBKcXY3RXVGSXlrUlZZ?=
 =?utf-7?B?QUlNYkVZSXdTNGpqOVI3T0hjZklsdmJ3M05EU3ErLWV3NmxVeDMrLWUrLUYw?=
 =?utf-7?B?N21rQy9VRmVpS3ZINWEvZmh4eWlDRnhnMVF2ZUpxZEppZ1FqRC84cUR4M1Bq?=
 =?utf-7?B?dlhrZk1pRm8xNWNmYVVxV3pIelpmbTY3cU5iYlVrVDdJQTIyUGdIYk9DYXg1?=
 =?utf-7?B?TlVxTVVIOW9MM2g4VVdoKy1TKy10aXFzTVpGNFlRcystZFNRKy02Nk1SOW0y?=
 =?utf-7?B?S0prcFpsQ24vY3oyTnZmdUZJdSstaistTVVtUXZEMnljTmpoTSstNFdpUTNF?=
 =?utf-7?B?YmJjb05xYUMrLWtNb2hsYkdWaTNYd2pndVRXZHRmc3dvc0dMUDltNHpFZnRa?=
 =?utf-7?B?c2IvSm1CWGtZaVlFTEtyQUorLXA0T01DSWJFTnZpQnF4L2JVby9WejAxb20z?=
 =?utf-7?B?NmRDVTJvSFVESUVnL3ExSmRzZHM3c0IvSnRVUmNOR0ZkR3NrY3R0MzBrVm04?=
 =?utf-7?B?c0IyKy1idW9yUFdtNTNuNmt0ZDl3L3NDUDVRTTNmWHFTWFEydistbHVNU3Bx?=
 =?utf-7?B?eHQ3YS8=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996f1733-a70c-47ef-9c9b-08de21138483
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 11:14:44.4471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kp5oJrs0wFxhPK7gGR7E1C5nj/lKwly8L+9P1u8wZirkF80ObKZ/IYKX74cvN22Un3DMWo1Z2w3tiGJXlm0P/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511110038
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA2MiBTYWx0ZWRfXwO6emh6P6xTK
 dpqHnVC1cOgIAQxlBBjnQ3+N3OycXC+3iiY+64qLkox22/RCQFNxdx1m02MpDHGHbjY49He4Vnx
 pBGWVpLOn5rcFb5WXV5gqFzCVQ2XdYXAx9Rq4nKuIfc4cAJskIEG55SgaXudxRA/rtzmxy4jiK4
 hqVIxGV1N++S5Lzlg8DuL6xicwYy9LwD2amBfTzP++WMZT1gkeTZKPL31kwhebWvJXijy7kX7lM
 5F/vjXehvTMHtILnofkr33rMFaNDo/ZMMklNXUyYfvKf208Wf4vf3xHy5UkhUz5iJCDn4vwMBdO
 +g5aSXx4qoHSndRW2lN8DAg2dtQGnwBR+ynAeYv0jN1M40ynJACHeEkdXS3kXbJqkbDAWRJ2cUP
 iUf26EAt4yf0laQt3ZcYGxcMYGZ4Dg==
X-Proofpoint-GUID: zbjCIr-GboTLmtOY1U-jCVd4hccC9bfm
X-Proofpoint-ORIG-GUID: zbjCIr-GboTLmtOY1U-jCVd4hccC9bfm
X-Authority-Analysis: v=2.4 cv=SLxPlevH c=1 sm=1 tr=0 ts=69131aa9 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=iLNU1ar6AAAA:8 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8
 a=ytFMdNZ7AAAA:8 a=LfxEVeEBAAAA:8 a=eSb-bNSJAAAA:8 a=QEEkIeqjAAAA:8
 a=b3c82L26c6wRHg9XxjUA:9 a=avxi3fN6y70A:10 a=hlJyneSgMmFPbskH-t2w:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=oxySFUAvEW1-6AXleBSr:22 a=7k9nRlTqVbDGZ3p5_T00:22
 a=h7YW-pclpbZRD8svLbQ0:22 a=iapMWHAMLVzCBf0btcAb:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015 impostorscore=0 adultscore=0
 phishscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080062
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

Responses inline.


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: fengchengwen +ADw-fengchengwen+AEA-huawei.com+AD4-
+AD4- Sent: Monday, November 3, 2025 11:15 PM
+AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4AOw- dev+AEA-=
dpdk.org
+AD4- Cc: pravin.m.bathija.dev+AEA-gmail.com
+AD4- Subject: Re: +AFs-PATCH v3 1/5+AF0- vhost: add user to mailmap and de=
fine to vhost hdr
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- Please fix a typo below
+AD4- Acked-by: Chengwen Feng +ADw-fengchengwen+AEA-huawei.com+AD4-
+AD4-
+AD4- On 11/4/2025 12:21 PM, Pravin M Bathija wrote:
+AD4- +AD4- - add user to mailmap fle
+AD4- +AD4- - define a bit-field called
+AD4- VHOST+AF8-USER+AF8-PROTOCOL+AF8-F+AF8-CONFIGURE+AF8-MEM+AF8-SLOTS
+AD4- +AD4- that depicts if the fature/capability to add/remove memory regi=
ons is
+AD4-
+AD4- fature -+AD4- feature
Made the change as suggested in latest patch v4.
+AD4-
+AD4- +AD4- supported. This is a part of the overall support for add/remove=
 memory
+AD4- +AD4- region feature in this patchset.
+AD4- +AD4-
+AD4- +AD4- Signed-off-by: Pravin M Bathija +ADw-pravin.bathija+AEA-dell.co=
m+AD4-

