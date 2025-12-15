Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11E5D41D74
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 08:29:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B52774026F;
	Mon, 15 Dec 2025 09:29:08 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id DD80C40151
 for <dev@dpdk.org>; Mon, 15 Dec 2025 09:29:03 +0100 (CET)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BELn3R6028942;
 Mon, 15 Dec 2025 03:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=p
 riMtVVZ6uGflKGkSb8pXZzTFgHhU5uWMhu5jWJYsEA=; b=Ns394aa0/1hEJYjYM
 Kuo1pIbgwk0xWv7QhXEJukuGQYI4fQmxCTnDoJOmmYRkSFJYJaM0OmluXYCvoZmN
 dRsJe9+v3c39aORdHx7Z9+Z8CppPOrZtWmoinCB6sJyRRjf6cJkAXKuBkRWKvv3Q
 o8hWnlGxScTOwkyT3X5tz4Lr06tNIPL+oouWcs/GYl2Y8hwyYVu8aAOZh9KZW20t
 YIFsQ+xnpkugRno4+8hKnzKxCBTXWJMpvWk0Y3YDT83nwk2hEK2eENn/fGVOpFIK
 T2BqeRG1EkBZp7s4+k0+mZvw54Ut99HvmfeJrS9MM6gXSAAYWt0MvE7/WSpn26bQ
 vlPHw==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4b1461579k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 03:29:02 -0500 (EST)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF8PMWs028846;
 Mon, 15 Dec 2025 03:29:01 -0500
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4b1433gcrb-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Dec 2025 03:29:01 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xm/a2wxFonVVck5OngcIhF6B6hsKY/+woCrssWfIvuGzP/+37JeWER3EbvQQkh73BAvzxynfVRMWVaPr/G9ExRYwZfFT5dhBgHktT51S03lX8JkyVbZ3RZ/QN8QgiSIhQ3kwBWbyRDEq/eYTTBZafi/cCOEaNQMdmKes6ve/x6/TqAita1+QrhtMhPuylUlLsryJQfBcoapw60Yy/qezPiRtgbD0llm92icWIriRP/TSkvBlfFkO17F7Ue9+73L6Gf6Vf+gu6OWWoVdcrFHPuwRwhS+ZZJhEMzCbB6JP5jH6bP9VjkkQSSPm/yfwnH65qR+8RKRIHCPR/7DmNvcQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=priMtVVZ6uGflKGkSb8pXZzTFgHhU5uWMhu5jWJYsEA=;
 b=U37C8kdNpRkVIn97wIfUT0pM0WTTM2XoLJTFRwfjF4eEYBI4dkQgMoUvU++epW3XAHGaNCTlfgJQbTPNA0yifokdY7dNCvmAXmhxZR8M48kq1LnBtQYrAdcl289+3Z4iJ71sRgQ5U2gQhU93XQt65qWha6fX6cslwjM/prdEuDEoKesxDf5BoXAK6GhoUucdXUNHKPPGJprQj3HCMjCi+90F1Waze40xnub211cFrBTVEzlxyO5F1ROnDxfN0xYVaMdrTz53WlR/xFMi0Ubqq66esr05yzpfLUZ6ZrSAIGRtRydKIrLyYOflo/KZGfWA8SVVhw6v4hYY3lBZnRQjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by EA3PR19MB9692.namprd19.prod.outlook.com (2603:10b6:303:2b7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 08:28:56 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 08:28:55 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: fengchengwen <fengchengwen@huawei.com>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: |Smoke |FAILURE| pw(158765-158768) sid(36689)
 job(PER_PATCH_BUILD17274-20251113210704) [v5,4/4] vhost_user: Function defs
 for add/rem mem regions
Thread-Topic: |Smoke |FAILURE| pw(158765-158768) sid(36689)
 job(PER_PATCH_BUILD17274-20251113210704) [v5,4/4] vhost_user: Function defs
 for add/rem mem regions
Thread-Index: AQHcVMW3flDa9V4i3EeDFkBR+lHgGbUDDkBggBYeGfCACWMxgA==
Date: Mon, 15 Dec 2025 08:28:55 +0000
Message-ID: <SJ0PR19MB46060E3FBC2D4E7B0FD4BCCFF5ADA@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <553996$6i5mrh@smtpauth.intel.com>
 <SJ0PR19MB4606FAC1A477B65FC4AF1CEBF5D1A@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <SJ0PR19MB46061E7A91AEF354663CD827F5A3A@SJ0PR19MB4606.namprd19.prod.outlook.com>
In-Reply-To: <SJ0PR19MB46061E7A91AEF354663CD827F5A3A@SJ0PR19MB4606.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-11-25T07:19:54.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|EA3PR19MB9692:EE_
x-ms-office365-filtering-correlation-id: 150c4a87-99e6-4d15-6f6c-08de3bb3fc9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-7?B?bWpBM21wVXhtdlBKclFOUnhiTmc5eW5yZU1ja2ptOWRiWldTaTRjSndPcGpy?=
 =?utf-7?B?SUhEU1FNbGRJc3B4Ky1hSExiZEVVKy1nREgyNVEyVktHdndtbUQzeVoxbzRl?=
 =?utf-7?B?eDcvbmhIQ0dVajc1SEl1ODNhQWdiQVdyVWp2R0ZnUm80YXdxZDJtVFo0eWJT?=
 =?utf-7?B?b084ODJGMHB6SVltTjZaT3RycWtQR0kxUkg5YUtOMkhENTN5ajlCMkhEOVJC?=
 =?utf-7?B?cVZWVmZXTVQwU2dZSzhLdXVWbTFRMnRlWjJPTFFsKy1obElIT1I0VEVhMXBR?=
 =?utf-7?B?Q3ZpRystdHVrOENtVzB0elRiVDdiQWdKZ2VNZ2xHSnF6VFBsZE1iemlMWXVn?=
 =?utf-7?B?aURwRnVJZmxGblYrLURLYVhUQmFnTE85dXArLTAyd2RFZGpHdHpubEY3Tkls?=
 =?utf-7?B?NHlZMDVEUG1sdkZrKy1NNzJhV2VJZFp3Y3dVQXJYRjFqZFdIZmxhQ0VKcmhJ?=
 =?utf-7?B?T1RzMXM1STFuSmY1enNDaDg0ZUZtRjFmeFQ0NUwycDV5QUR4NURTY3lIOGtj?=
 =?utf-7?B?NmtheFJPZHdDZ0R6ME1yUnFBKy1yQ1krLUMxaDVrTXZ1SjI0UGVLLzZCKy1i?=
 =?utf-7?B?NC9mODRVOElya2thVnQ4U2VJYmpUYmhEaHdkTXNvMUJLSG5QU0hNZS9iRzVl?=
 =?utf-7?B?VmcyUDhIUVZLcUVHUkR5bk44bVlBckFpNER0ZHZISEJ2cGlOQUdCcVFoYXVG?=
 =?utf-7?B?TG00UlRMVlh0S3V2QVFRVGNLZzI2dUdtV2xXcG1LaGxpVGFWNmtGWXVwODBu?=
 =?utf-7?B?NUhxSmM2Skp3dlN4MzZwTEExaDU4dDNwdGFRbW9ucmlBalJxZ21ic2ZJdGEz?=
 =?utf-7?B?ZzAxZjRMTkFKL1dDb1RvT0w4R29uTURMMFFUL0lIMmpNZVdkOTZ4eUpqS0xQ?=
 =?utf-7?B?dGZCTjB2SEswZEhlQk45ZlhZaEdRMG9qQzVNWlZ3Y29SZW16MVJHMistTTl6?=
 =?utf-7?B?TmZqWUlvalZwL1E1Rmp5VndSUy82eFpHdUlyZHFJU0RxeFVkNzRUbXhwNmVF?=
 =?utf-7?B?VTBweWRnVGhZT1Q2c21xN25vVDBZSHZWeWZqOXVqV1V5YUlpV212djFpMGVK?=
 =?utf-7?B?VE5CUnh6T2VTWkh4YXBoRCstMUxCUXgvTjNRMUF6Wm9uR1FSazBsRXhkMHN1?=
 =?utf-7?B?OUtIYVJvVUN0T1g0OFpTQnFkMXBLUS85S2E0V29wRk9ycG9LOUFIa1ZCWGhv?=
 =?utf-7?B?cnhJL0Jxd3NNSU9IdWd1ZHczaDhVTSstakNkQ2NaVDQyb1JRSVJ1RUJhTllB?=
 =?utf-7?B?bWpHTTc1NWZXWE5nT0NTM2ZyM1oxSW41bmFKODQ4dVZPQ0pXRHJvamxOaDNL?=
 =?utf-7?B?QkNNbjhsY0VRc3EzVlpBVjVxdExzRmh6aEphalUyODZQcE5OTE5qWnlLRjhW?=
 =?utf-7?B?MHJ4UWZuNUJhVUY3SklMcjdsenB4UXNpNE9OcjNzU1ZUZzlnQjQrLTRKUWZX?=
 =?utf-7?B?czJsMk5zUkRNSmttcFNDekVJMFdwZU9LeWJpQmpJejhJcm81Y2NDNDlNTHZQ?=
 =?utf-7?B?dSstUkFpenpKVEJsU2RFYmV0NWJkZFNPN3dSdFFZcm0wZUU4L2NyWXVsNm5G?=
 =?utf-7?B?N0Z0Qk1kZ2UzYnZ2b3hKQ0hVZElaRGx5bDYrLThDUTNoaUVkMWoxL2xUVWhQ?=
 =?utf-7?B?Yk9FaUQxNSstaGNWM2hPc2FuVWtnZlRmd0Zqc0plbHZCQm94TlZ3Ymt2Tmh6?=
 =?utf-7?B?RHNKY0VFczNPOU9hZSsteHBzMXRtY1ZWTUlPaDJwZ01FVDFteVJwQktnWHM3?=
 =?utf-7?B?U2RjTmFmY3ZFTHNucUtMdVBEc2pkQWU0ejdIS3J5bS9OTkFNZWd2Y3FkeHA4?=
 =?utf-7?B?SUc5bGxNTGhjZW9qdDNURUhNQmc4cWlTRWJnNUtwMk5tYURPVTdtdGNpSmRQ?=
 =?utf-7?B?NU0xRmxwdERWalpyUTVCYjNmVnRqRzZDaVZWbzlNQjdONXhROUI5dXJaTlRR?=
 =?utf-7?B?cU5SUlh2STNXNU5pTTlLeGgybXUyUHJFV2RuSk1kTGxXYlZMVjVZcnUwTVQ5?=
 =?utf-7?B?a1g4akxwOEd5czFmaVFTZXNCMHFKNnRpYjZCMU8zY0U0b3dndERRKy1mQkJh?=
 =?utf-7?B?ZSstVUxybXd2cEtPSmd2Z3hVemZtUXUya1BiSUF2bmE4d2xyenhCbHo0TDZF?=
 =?utf-7?B?VlJBK0FEMEFQUS0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?WEVhV0ZQOHpIVjhWU1VHWDROdWZ2dGNGRVgwWEZxc1I2OG81ZjFEb2F4cUNr?=
 =?utf-7?B?M1NkdzEyUkdDYzJUQystKy13aWY0d1M2TDFqZlY4aWhlL2lTR1pHVDlFb1RQ?=
 =?utf-7?B?MW1yT3dxWXVmS3RZajVVS1k3MHRMOWkzeWNFTGxMOU10N2EybUFXZm9NcTNQ?=
 =?utf-7?B?VlVwZkxtVCstSmR0ZS9DTHBvemdYY3pic2RlanNxUHN2V2lwcHdvWXJkZXZa?=
 =?utf-7?B?S0dwR1lablpyQnYvNFRSTmZwdEpPM0poVzF6N1JJOTJjQ0pvakRrdUl0OGxY?=
 =?utf-7?B?TEhqL0pRaCstRmlWaVY5SFBIZ3dOUUk1bk0xazFHNlBWQmVodzhtVk01bHdv?=
 =?utf-7?B?RjQzemdiaSstajY4TFNBcnp2ckZUNU1kUWt3NFY2Ky1DZTJsR0orLWpCaVU=?=
 =?utf-7?B?NSstL3g4ZU5KNGs3cVBlRHlLQ2c4YlN2ZERnMExiR1pTaFVxeVJ0SUpyR1h5?=
 =?utf-7?B?SHZsSXFvUnd5ZjZuUUZqNHczVkM3QWYwbm9SOXRSYUtReTZBWUZLWlBoWnE1?=
 =?utf-7?B?S0IycSstQkJTR3dtUjlIM2s5VlE3cGNQVHB0YUVqSzg0YzNuejNHV0lHVkdC?=
 =?utf-7?B?ZU9iQTcyQlFtenV2MTB3bWQ0ajNsTXFSZFdFaFlLdFI3WnFDUm1mQmlNUTV3?=
 =?utf-7?B?eUk0R2FWYkgyVDRKVXEzRVJWc2hUL0lrc3JFM0RCZFlDQUJsQ0Q4dkxwdjF1?=
 =?utf-7?B?R1JtUWZPVVVKamwyM2tuekFNSWFNY25WMVdibmRXUk02djlIaXlPUmpQZENR?=
 =?utf-7?B?ZUFoYkpBZGRiaXY3VkJWKy1jOFlQdTJCQU0zQWZTTGpBSEd5MmwrLXVQUTF5?=
 =?utf-7?B?R0taclNreEh6Vlo3UEI0cXEwSXpjeGp4WFl3YWJ0TWx5eWg2dy9qVndRRmZz?=
 =?utf-7?B?c3BqODFBZ1ZIejByWllYZExmUlRkOTNydmxOMzF0SHRiM1VxN3ZJVk1ua1My?=
 =?utf-7?B?MTdzRC9vZ25PdGFnWVdzai9YWjI0aElqdFNHUnRvYTk1WGp0bElMelNaN1Nh?=
 =?utf-7?B?WUVkb05CL1pnKy1zQWN5S0g3UEZPaFNtUVhyenNTTWZBZVp0UFFrSEUyV2Ex?=
 =?utf-7?B?RXAyRmh0Sk1Ha0hXQ3ExUEtSKy0wSm5CYVVLajRPNHdITnFQWTF3RDhTc1k5?=
 =?utf-7?B?Um9NTlphSVhvWWlQc2U4blRESkhVdkhPR05kRGtvM3lSek9aaUZJalFYdmJm?=
 =?utf-7?B?TUZGWVJQN0FxVklVWUg5cWxNZEx5MnNpRjcrLVU4QXhaNUxJcFJ0TkpNbjEw?=
 =?utf-7?B?bHF4bzJTN0dQdTVhazltRi81bFpsMlhFV0hNcVhTN0FId0p1TFFUR3FHUEdP?=
 =?utf-7?B?REMwL2lkUTF3c2l2RzJhd0E3em9KNVVvV0dwNDRydVdZN1QwSmxKTjRJeVM2?=
 =?utf-7?B?MURLWXFIQ1Avak16QjRjOFBWc0dZQzhCVzBiUkwrLWV1NmlTVlVFQzRuaU05?=
 =?utf-7?B?YkhrQndTSEFhOFg2b0FWaHJtVHpaOGQzcSstZGsrLTJZTG9HQlpCYm9PY1Y0?=
 =?utf-7?B?cDN4WG9aQmFhWk83cFFyaWRhTystYXVxcmhSZ0lXekRrSVV5T3k0Mi80SWF6?=
 =?utf-7?B?aUVtSFNYMnBpdFI4dWwwR1gwSXhhRDEwSGtLUjJ3Q3hzbnJETnY0ZEZKdGdZ?=
 =?utf-7?B?VVRMYUJ4bURyOUpjS0IySFhUZ3dVZCstZ0N0Ums0ZGtLNUp5blU5MFU4Qjlj?=
 =?utf-7?B?ZDBlTW1OYUNubmZPM3VVc1FLTzhwdFdZTTJENUFlZ3F4aGp1U3UwcG56SHRk?=
 =?utf-7?B?aU14VHlqZHIxYXR4cXF5Wm80WDlSY0pRbTF5NUZ3eWJmZ0RMU3NHY0l0VFhM?=
 =?utf-7?B?RDlSSE8zaSstOUpQejJUWm1USzFOdFp2YWNEWjI1OWU4Slh2dndpaERGL01S?=
 =?utf-7?B?T2JlTUlQeWhmNDZCeVh0OWNORzRDOTI4SUd6dWhmblRITistUFpwNC9oR0dz?=
 =?utf-7?B?VTVURTJVODFtakdvdDRUTTNBT1gxRTByL3dFN2lXdjlpdGpYNWhUTERhaXNl?=
 =?utf-7?B?SENEblNaRUtnUWl0UWx6QVVmSTZMKy1NVDB0dTFaT3FQdFV3OTQyVEpqL3ds?=
 =?utf-7?B?R2pVaDBsVnlQRGxkQnowWjQvUXYrLW1GSC83TEcyUm83WmNDVlAxdmxveEVt?=
 =?utf-7?B?OUxEVW5HNVpPVzlseDY4S2RaUmdkKy1MZ2pPdXRjVGtiRXMzMTV4WkIzdUl2?=
 =?utf-7?B?U1d2LzY=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150c4a87-99e6-4d15-6f6c-08de3bb3fc9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 08:28:55.5892 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hqFm9yRoI9NPuo/xyLmk4FOwCxqVHBXwN2TGFiRK+VDvMhGd+wADZnk9i9jMe9ApCPAlUF90WNhS7qhAqMEFyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR19MB9692
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_01,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130064
X-Proofpoint-ORIG-GUID: z6pU1-c438y8kTsfhM9eXEjAcIn7fF80
X-Authority-Analysis: v=2.4 cv=XOE9iAhE c=1 sm=1 tr=0 ts=693fc6ce cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=bWxv08ZMR_wA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8rWy6zfcAAAA:8 a=uherdBYGAAAA:8 a=i0EeH86SAAAA:8 a=20KFwNOVAAAA:8
 a=QyXUC8HyAAAA:8 a=iLNU1ar6AAAA:8 a=ytFMdNZ7AAAA:8 a=XlRjxQ70AAAA:8
 a=eSb-bNSJAAAA:8 a=XFJw1KJJAAAA:8 a=LfxEVeEBAAAA:8 a=IB1y63kjAiZajKuIG0oA:9
 a=avxi3fN6y70A:10 a=aV_cevuMhtcA:10 a=hlJyneSgMmFPbskH-t2w:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=oxySFUAvEW1-6AXleBSr:22 a=1uMOUU2w0DxzEe95gQqD:22
 a=h7YW-pclpbZRD8svLbQ0:22 a=DKZDSSD9H29Cdu8kcpdD:22 a=7k9nRlTqVbDGZ3p5_T00:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDA2NSBTYWx0ZWRfXxbSxHxG3xACr
 PO4KAzs8CLdJPM7D81WmMV8MQ/WCX8/eImar+Tv/rGjaTmj7NdBCqcejVjqOH1Tuejwty01obw5
 VF0PBj3RWm/EqvTVxAyx91Jmz19Zl3yWr3d/IGnSMddvzZyK1EDsiPF4D4E1hr5MjL5O1+u7QAL
 JcDyKwOstj/bTN37R3HMMTBG9MfyDgAnNP4dVcaI9yNO2D/MQmfGIfVmgFGRzGpZnP3Nut6zgzr
 d0/Dx7sp0WcmwFm3NuALWhPraxNQBT6uRhKqBIEdieO982Fk6GcTOhzhgyfgS4x86PcQIxTOsdU
 iLisDkup9/Cgd2jd4YL9jETMyFKZjoZf5CvI7CAmmi/M5Su88IA060OP/RZ9qlGwPZn/Pte/he1
 M1Oz9P4aBaa16YpsfQGzzo3cTd39JQ==
X-Proofpoint-GUID: z6pU1-c438y8kTsfhM9eXEjAcIn7fF80
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130065
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

Hello again Fengcheng, Maxime,

Any thoughts on when my changes will be merged into dpdk mainline ? Some of=
 the SPDK test suites we plan to merge are dependent on this change. Please=
 provide your input at your earliest convenience.

Regards,
Pravin


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Bathija, Pravin
+AD4- Sent: Tuesday, December 9, 2025 1:06 AM
+AD4- To: 'fengchengwen' +ADw-fengchengwen+AEA-huawei.com+AD4AOw- 'Maxime C=
oquelin'
+AD4- +ADw-maxime.coquelin+AEA-redhat.com+AD4AOw- 'dev+AEA-dpdk.org' +ADw-d=
ev+AEA-dpdk.org+AD4-
+AD4- Subject: RE: +AHw-Smoke +AHw-FAILURE+AHw- pw(158765-158768) sid(36689=
)
+AD4- job(PER+AF8-PATCH+AF8-BUILD17274-20251113210704) +AFs-v5,4/4+AF0- vho=
st+AF8-user: Function
+AD4- defs for add/rem mem regions
+AD4-
+AD4- Dear Fencheng, Maxime,
+AD4-
+AD4- Gentle reminder to check-in when my changes will be merged ?
+AD4-
+AD4- Thanks,
+AD4- Pravin
+AD4-
+AD4- +AD4- -----Original Message-----
+AD4- +AD4- From: Bathija, Pravin
+AD4- +AD4- Sent: Monday, November 24, 2025 11:24 PM
+AD4- +AD4- To: fengchengwen +ADw-fengchengwen+AEA-huawei.com+AD4AOw- Maxim=
e Coquelin
+AD4- +AD4- +ADw-maxime.coquelin+AEA-redhat.com+AD4AOw- dev+AEA-dpdk.org
+AD4- +AD4- Subject: FW: +AHw-Smoke +AHw-FAILURE+AHw- pw(158765-158768) sid=
(36689)
+AD4- +AD4- job(PER+AF8-PATCH+AF8-BUILD17274-20251113210704) +AFs-v5,4/4+AF=
0- vhost+AF8-user:
+AD4- Function
+AD4- +AD4- defs for add/rem mem regions
+AD4- +AD4-
+AD4- +AD4- Dear Fengcheng, Maxime,
+AD4- +AD4-
+AD4- +AD4- When I look at the test results below, I see that one of the te=
sts
+AD4- +AD4- +ACI-test+AF8-checksum+AF8-offload+AF8-with+AF8-vlan+ACI- faile=
d. However, when I navigate to
+AD4- +AD4- the actual test results page - that same test shows passed. Cou=
ld you
+AD4- +AD4- please share your thoughts on this ?
+AD4- +AD4-
+AD4- +AD4- https://mails.dpdk.org/archives/test-report/2025-November/93117=
5.html
+AD4- +AD4-
+AD4- +AD4- Also, any thoughts on when my code will be merged to mainline ?
+AD4- +AD4-
+AD4- +AD4- Regards,
+AD4- +AD4- Pravin
+AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4- -----Original Message-----
+AD4- +AD4- From: sys+AF8-stv+AEA-intel.com +ADw-sys+AF8-stv+AEA-intel.com+=
AD4-
+AD4- +AD4- Sent: Thursday, November 13, 2025 9:48 AM
+AD4- +AD4- To: test-report+AEA-dpdk.org+ADs- Bathija, Pravin +ADw-Pravin.B=
athija+AEA-dell.com+AD4-
+AD4- +AD4- Cc: daxuex.gao+AEA-intel.com
+AD4- +AD4- Subject: +AHw-Smoke +AHw-FAILURE+AHw- pw(158765-158768) sid(366=
89)
+AD4- +AD4- job(PER+AF8-PATCH+AF8-BUILD17274-20251113210704) +AFs-v5,4/4+AF=
0- vhost+AF8-user:
+AD4- Function
+AD4- +AD4- defs for add/rem mem regions
+AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4- Test-Label: intel-Functional
+AD4- +AD4- Test-Status: FAILURE
+AD4- +AD4- https://urldefense.com/v3/+AF8AXw-http://dpdk.org/patch/158768+=
AF8AXwA7ACEAIQ-LpKI+ACE-jCHb
+AD4- +AD4- Wx
+AD4- +AD4- KxAWgIg6OQEvPP3-yCEWdKOlDUFrlDl-
+AD4- +AD4- Njivh4rgNkJqRj9YFVVY9hRHocrV4lnvkjjvMMC85WVA+ACQ- +AFs-dpdk+AFs=
-.+AF0-org+AF0-
+AD4- +AD4-
+AD4- +AD4- +AF8-Functional issues+AF8-
+AD4- +AD4-
+AD4- +AD4- Submitter: Pravin M Bathija +ADw-pravin.bathija+AEA-dell.com+AD=
4-
+AD4- +AD4- Date: 2025-11-13 12:44:22
+AD4- +AD4- Branch : dpdk-next-virtio
+AD4- +AD4- CommitID: 6b37c26a95
+AD4- +AD4-
+AD4- +AD4- Smoke-Testing Summary : 31 Case Done, 30 Successful, 1 Failures
+AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4- OS : Ubuntu 24.04.3 LTS
+AD4- +AD4- Kernel : 6.8.0-71-generic
+AD4- +AD4- GCC : 13.3.0-6ubuntu2+AH4-24.04
+AD4- +AD4- NIC : Ethernet Controller XL710 for 40GbE QSFP+- Target :
+AD4- +AD4- x86+AF8-64-native-linuxapp-gcc
+AD4- +AD4-
+AD4- +AD4-     Test result details:
+AD4- +AD4-     +------------------+---------------------------------------=
-------------+--------+-
+AD4- +AD4-     +AHw- suite           +AHw- case                           =
                   +AHw- status+AHw-
+AD4- +AD4-     +------------------+---------------------------------------=
-------------+--------+-
+AD4- +AD4-     +AHw- checksum+AF8-offload+AHw-
+AD4- +AD4- test+AF8-do+AF8-not+AF8-insert+AF8-checksum+AF8-on+AF8-the+AF8-=
transmit+AF8-packet+AHw- passed+AHw-
+AD4- +AD4-     +AHw- checksum+AF8-offload+AHw- test+AF8-hardware+AF8-check=
sum+AF8-check+AF8-ip+AF8-rx                +AHw-
+AD4- +AD4- passed+AHw-
+AD4- +AD4-     +AHw- checksum+AF8-offload+AHw- test+AF8-hardware+AF8-check=
sum+AF8-check+AF8-ip+AF8-tx                +AHw-
+AD4- +AD4- passed+AHw-
+AD4- +AD4-     +AHw- checksum+AF8-offload+AHw- test+AF8-hardware+AF8-check=
sum+AF8-check+AF8-l4+AF8-rx                +AHw-
+AD4- +AD4- passed+AHw-
+AD4- +AD4-     +AHw- checksum+AF8-offload+AHw- test+AF8-insert+AF8-checksu=
m+AF8-on+AF8-the+AF8-transmit+AF8-packet
+AD4- +AD4- +AHw- passed+AHw-
+AD4- +AD4-     +AHw- checksum+AF8-offload+AHw- test+AF8-rx+AF8-checksum+AF=
8-valid+AF8-flags                      +AHw-
+AD4- +AD4- passed+AHw-
+AD4- +AD4-     +AHw- checksum+AF8-offload+AHw- test+AF8-checksum+AF8-offlo=
ad+AF8-with+AF8-vlan                   +AHw-
+AD4- +AD4- FAILED+AHw-
+AD4- +AD4-     +AHw- checksum+AF8-offload+AHw- test+AF8-hardware+AF8-check=
sum+AF8-check+AF8-l4+AF8-tx                +AHw-
+AD4- +AD4- n/a   +AHw-
+AD4- +AD4-     +AHw- dual+AF8-vlan       +AHw- test+AF8-dual+AF8-vlan+AF8-=
priority+AF8-rxtx                      +AHw- passed+AHw-
+AD4- +AD4-     +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-filter+AF=
8-config                           +AHw- passed+AHw-
+AD4- +AD4-     +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-filter+AF=
8-table                            +AHw- passed+AHw-
+AD4- +AD4-     +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-insert+AF=
8-config                           +AHw- passed+AHw-
+AD4- +AD4-     +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-random+AF=
8-test                             +AHw- passed+AHw-
+AD4- +AD4-     +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-strip+AF8=
-config                            +AHw- passed+AHw-
+AD4- +AD4-     +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-synthetic=
+AF8-test                          +AHw- passed+AHw-
+AD4- +AD4-     +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-tpid+AF8-=
config                             +AHw- passed+AHw-
+AD4- +AD4-     +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-stripq+AF=
8-config                           +AHw- n/a   +AHw-
+AD4- +AD4-     +AHw- jumboframes     +AHw- test+AF8-jumboframes+AF8-bigger=
+AF8-jumbo                     +AHw-
+AD4- +AD4- passed+AHw-
+AD4- +AD4-     +AHw- jumboframes     +AHw- test+AF8-jumboframes+AF8-jumbo+=
AF8-jumbo                      +AHw-
+AD4- +AD4- passed+AHw-
+AD4- +AD4-     +AHw- jumboframes     +AHw- test+AF8-jumboframes+AF8-jumbo+=
AF8-nojumbo                    +AHw-
+AD4- +AD4- passed+AHw-
+AD4- +AD4-     +AHw- jumboframes     +AHw- test+AF8-jumboframes+AF8-normal=
+AF8-jumbo                     +AHw-
+AD4- +AD4- passed+AHw-
+AD4- +AD4-     +AHw- jumboframes     +AHw- test+AF8-jumboframes+AF8-normal=
+AF8-nojumbo                   +AHw-
+AD4- +AD4- passed+AHw-
+AD4- +AD4-     +AHw- rxtx+AF8-offload    +AHw- test+AF8-rxoffload+AF8-port=
+AF8-all                           +AHw- passed+AHw-
+AD4- +AD4-     +AHw- rxtx+AF8-offload    +AHw- test+AF8-rxoffload+AF8-port=
+AF8-cmdline                       +AHw- passed+AHw-
+AD4- +AD4-     +AHw- rxtx+AF8-offload    +AHw- test+AF8-txoffload+AF8-port=
                               +AHw- passed+AHw-
+AD4- +AD4-     +AHw- rxtx+AF8-offload    +AHw- test+AF8-txoffload+AF8-port=
+AF8-all                           +AHw- passed+AHw-
+AD4- +AD4-     +AHw- rxtx+AF8-offload    +AHw- test+AF8-txoffload+AF8-port=
+AF8-checksum                      +AHw- passed+AHw-
+AD4- +AD4-     +AHw- rxtx+AF8-offload    +AHw- test+AF8-txoffload+AF8-port=
+AF8-cmdline                       +AHw- passed+AHw-
+AD4- +AD4-     +AHw- rxtx+AF8-offload    +AHw- test+AF8-txoffload+AF8-port=
+AF8-multi+AF8-segs                    +AHw- passed+AHw-
+AD4- +AD4-     +AHw- rxtx+AF8-offload    +AHw- test+AF8-txoffload+AF8-queu=
e                              +AHw- passed+AHw-
+AD4- +AD4-     +AHw- rxtx+AF8-offload    +AHw- test+AF8-rxoffload+AF8-queu=
e                              +AHw- n/a   +AHw-
+AD4- +AD4-
+AD4- +AD4- +------------------+-------------------------------------------=
---------
+AD4- +AD4- +--------+-
+AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4- DPDK STV team
