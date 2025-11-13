Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5273CD6E4E
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 12:47:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4249240DF6;
	Thu, 13 Nov 2025 13:47:07 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 428AB40BA0
 for <dev@dpdk.org>; Thu, 13 Nov 2025 13:47:05 +0100 (CET)
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD7LUIp030062;
 Thu, 13 Nov 2025 07:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=A
 sHO9K6odNhhR3rZ4l0WxroWo2QYKn9Enu+2icMun5M=; b=JYalpCq5/l2/PPpEW
 pCLz9Ypq8n87HcDAzJaoq17F6PVc0En8rhkqpdM45A1WOQxlGHbAXNHfA100pui9
 C1ShJifui9uOn+AdPbV86WLTsXgH4bH6iYKZoD8fwvENnQktZlYtjkUkEbdrC8Ha
 30wrfqgQOC003n9SXtDhVmcYCZvIISEaE/4r6y0mEI+ziBrJ+0a2tWklLZaY06ey
 b6Ea1E320gt1a7CKcJn5RmIGstPYAjyMIExdumdiMBW/tpjvskPdsOYKfAid3M20
 4/xPCV0awy38ni2alM4lpkpGHGen3ypM3wX9uaAP+4Ie6VHEjZyJuFfBRNffxHIb
 DXwew==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4aa1wdj6ef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Nov 2025 07:47:04 -0500 (EST)
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD94biF015497;
 Thu, 13 Nov 2025 07:47:03 -0500
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013060.outbound.protection.outlook.com
 [40.93.201.60])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4ad6k56pc4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Nov 2025 07:47:03 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRQT5qqpdIkfkFfB2FhELfQx+Ik7mrcUB7l5ZmrrrEKkRXeFY4fVNfFQlqLb/AhALtbyHnq00eZd2Ch3uKOHUDADjhsd0SlZ270i5DyEA5FOJ4wm2eFfrEaVBBQqsO/bJEQKHGlYzjifSGXAgEND+cdpjGJ9sFDNEoUL402Lr2AnoDChasqnw/7F+QJp3nn8PlMhxrxIJenScJI5krnUC2rE7TZPz1QPUZS93N+WzIVYDLjabbqkPlJElKtPhecTfTf1BTPZYJxc9ZS2YvBZIvxZIy08pgngjFSDYGc4izjOCABSgQEetjnBJA5L6bj930aDEa6FLatin/4z6QcDuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsHO9K6odNhhR3rZ4l0WxroWo2QYKn9Enu+2icMun5M=;
 b=Gm0PyW0XlDPtvuXecW66P56HjcqcoJq40/YJc7M/0o1NKAaNQr6KIzgKDf+gOgRsWhFdF6r49oJstrBde9o8le/daSkHDhhmVjqTQ3bJ/Hul6k2jBN0XukrKUxNvf1KrZXOGHuekgkYs5mWYDRlgLNeMi+VHTsK97ZsdvPLBbkLWKCC3zx8TvenKOWB6SEl1DHZzF7WmwWiGP0mR1SBaMAe2XWv00fzyIHZcefY1Y+7M2T8Y+cF1/rtKlO7pQmoy+5MULmp+nKDe1C4ML34LC9HDEk9Zj8BtZxK6RUQ7i+ivsPNX3knPxxuw2X3OrVqzaJTZuLEdmCerxgaDUApKzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by DS7PR19MB4471.namprd19.prod.outlook.com (2603:10b6:5:2c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 12:47:00 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 12:47:00 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: fengchengwen <fengchengwen@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "pravin.m.bathija.dev@gmail.com" <pravin.m.bathija.dev@gmail.com>
Subject: RE: [PATCH v3 5/5] vhost_user: Increase number of memory regions
Thread-Topic: [PATCH v3 5/5] vhost_user: Increase number of memory regions
Thread-Index: AQHcTUK2IE85u2Mbw0+mzrCeCVtp8bTiKvSAgAs3/qCAAOkoAIABnizQgABX/QCAAFnnIA==
Date: Thu, 13 Nov 2025 12:47:00 +0000
Message-ID: <SJ0PR19MB4606657996C9B331FFD0DAF1F5CDA@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <20251104042142.2787631-1-pravin.bathija@dell.com>
 <20251104042142.2787631-6-pravin.bathija@dell.com>
 <d7af7a2d-939a-45b3-9353-2787ef1dd513@huawei.com>
 <SJ0PR19MB46063C6E41E929271093CE1FF5CFA@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <9f38ffe8-bfd0-4af0-bf2f-f1239823c9cd@huawei.com>
 <SJ0PR19MB4606F0D91D66F05CACF74626F5CDA@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <a99915bd-31c5-4224-a427-55d4f758bb4b@huawei.com>
In-Reply-To: <a99915bd-31c5-4224-a427-55d4f758bb4b@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-11-13T12:45:08.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|DS7PR19MB4471:EE_
x-ms-office365-filtering-correlation-id: bd2d5a54-6b3d-471d-346b-08de22b2bce9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-7?B?L2tjVWtPZmlCM0JHTE94ZVJNckpmYzh1Ylp5d1F5blpmd21FeUFLbUZDRDZv?=
 =?utf-7?B?WVdEN1QzdjJTd09RRXNFbEJMR2g4bEJsNnBHL2UxR2dJTGk0YUxiZHN1bXp5?=
 =?utf-7?B?UE9rbklZQ3lRbVJrWVBMYnU5cUtXZ1ZOYkV4aWFEWm5xaDRVdlJ2TTg3WEZs?=
 =?utf-7?B?T1NsbjZqRFRoTmd4UGdXRFdsekF1ZGcrLTNwTkQrLVE3MjM0cm1zbk9FN3ZY?=
 =?utf-7?B?cVk2SktZWWtLYlpwa3l2TGNDcXlycWtzRDljRTVKV2RnM0RianNhRklhWmRM?=
 =?utf-7?B?Z0dJVFJVUXR6U2o5cnFBRGhuUFhyeDY2dzlGU21rZystenU0NEw3ZTRZcFAy?=
 =?utf-7?B?Z3Uyenp0aVI3aS9xd3ExcXQ1ZnRlWEVjci9sOExPRGNQR3BaYTNieTlSaXlK?=
 =?utf-7?B?dGt3WmxuNk95OE43emZxbXkySVZFZUxaNnRSVXc1T0JmWS9adzh6UVBrTHNS?=
 =?utf-7?B?cjhwQVlQUGRBNWxTQmp6VzZNWlFJV3crLWlsckUrLWpHdlB1dWVLOThaN2U=?=
 =?utf-7?B?dkErLVUrLVB5M0tRNVlCaFJ2Wmp0Uk53dmY3OWFhSWdTL0hEdy9QMFpsL2lQ?=
 =?utf-7?B?bEZlMDFlcFVRby80STJDa21YaEhTWnZUN1pUbXlTZGM1UWxqTm82Q0VQM0pP?=
 =?utf-7?B?TUpWTzFkVFJDSUZOc0NadHg2WnlOSzBGdDNLc2xLNWxDOUxpd25LY2tWMkFh?=
 =?utf-7?B?b2RSaEhTKy1saVUwb2k5V0l2MkVMTVJZeGFybnJoRlRQRlVGSUlXWmhYcUJD?=
 =?utf-7?B?RTVQc1l3NFVtV0I3Q0RZdHgxMzRjWjZzY3AvZG9Zb3dEKy1sSkcrLWVCWUNU?=
 =?utf-7?B?Qkp4ZXJtSGxwWkVlcW9TaFRhUnZGendtR0NXaEhObDJDVUxWWXJkcXBwQ0dP?=
 =?utf-7?B?NUhGMXhVYWlJelNTUGRoMER0c2d3WkNGQlJuczgrLTJUdDBIQWZqNGdVZEli?=
 =?utf-7?B?VTVwc29FZThwT1RhUkhMc3ZFRistMEhvbVBoc3lNMGVFbHNWS0NPR25tVGhH?=
 =?utf-7?B?dTlqdlYxRW5aNzROSUpkWGd4VXRpN2ZJM011MFlZM2dyOVdKODM4NGZiY2Rv?=
 =?utf-7?B?bDJIOTdhSzBKRDNLN0cxS1hGWExhMmQxcEpiODUvODhUTXI4TUtxVzRFdkRI?=
 =?utf-7?B?cUdTMDNzNDMxOUp1bE1PZzZNSG42cWxadXlsUElPQUZJdHArLWVnUXlNU1JF?=
 =?utf-7?B?VHZSOUlYL2J6eWNXSTIxL0JISXNaTElWQVpOYkc2TXROKy1La050WFJ1ZUpr?=
 =?utf-7?B?aklFQ3k0cjkzL0hXMzBseEV4R0E4ZnFPYUVUa1UrLUhTcHo4S2draE9TNUt2?=
 =?utf-7?B?dHMrLXJIUkFFZUxKNTNSTzJpNUVkejUyRG1xanBSOGxzWW1Kc3JjT1BvTm9C?=
 =?utf-7?B?aE5iTjlUQkkvWnc1RVhyZ3BEaFFsdmw2SEdGazhYNVpaSzNlTG5oM3padFN2?=
 =?utf-7?B?Rml5eDlMSmZTZkNoenJUMystcHdhNWlIcXY4RGF1OE1QWDZYc3pHM1dYZXJh?=
 =?utf-7?B?eUZheWc5U2xUb3BFT3lFMDVQZG1YL2JXKy0wS05aNjVkemR0cFo3bUNvZW9O?=
 =?utf-7?B?Wm5Ba3pUeHRQMzVaTXVsZ3N6WFIzNystMXluSzJvcUh2ekxGTDl2NFp5T3NJ?=
 =?utf-7?B?RWZxMDZ6RmRvRHYyMFlXZEp3T04wKy1CSVY2NDFJRUhwZ2R0dklRR2p2TGp5?=
 =?utf-7?B?WlJaOVQxc0dWZHpUcVFnUk0vUDkzdTdQTHRZcldDSGYyYzJ2bmJES2pRUnls?=
 =?utf-7?B?bWExR3pMKy0xajh4UDhiMmtScEdEWHJjV2VyN0EyMjEzTGdQWW51emkyWFRE?=
 =?utf-7?B?NDlBUWJhY1loTzRDa1haU3RqZEVTQ1N2cVROS2syaDY1dGhUUllkTmFObXk=?=
 =?utf-7?B?Ky1ycHpJbmF6Y1l4aGhZbHFDeTlMVkRhSEpUOS9kTXhMUTJFV040RWkvUS8y?=
 =?utf-7?B?dndLd25sNEUrLURtT2x2b3BEU0FGMGFob2VoQ203UUFXZEdBOEh4QWkzNEFl?=
 =?utf-7?B?M0RpQWpsZGNEVEhVUFlYTzVVRE9WR3IrLUdxZGFkZWZ0ZTNiYTY0UG9UWjNk?=
 =?utf-7?B?a3JaQzdjZXV4QXQxYjZnbXVZT05vNkxocWxVV3VqZkY=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?QWZPSVRRTWxXaysteHdHby9NbG56eHZYYnBjelFUZjFQekFEKy0xTkY1Ky1v?=
 =?utf-7?B?MFRtc0FTMHhLd2d4WFFSRml4eUdDWDdRUHYvKy1ka3J6QVQwb2wxOVljbWFH?=
 =?utf-7?B?a251RDg1STkxeEdxOW56cjlzdFZLMVpuWkV1VmxsdGlOTldnNDUzcEFlU1Na?=
 =?utf-7?B?Ky0xcUg1UVBDZ2VmT05QMWlkNEFCczRQQ3IybistQjJLRkVUSkNJR1JBSTRR?=
 =?utf-7?B?U0pkaGxaSDl6VEkrLWgwbWo3N0orLWlybzBtdkNQaktOUCstTHFocDF3RGc4?=
 =?utf-7?B?VU54b0ZvTTFrYUlTKy1HRmdTbmFodXpYbVRqSzZJcFBCMWxlZy9zOTFiVHc=?=
 =?utf-7?B?TystWUVWcUt1TkRPS0U0alo0bU9GYklJRjBmemxkdWU5b09teldRWTA0cnU4?=
 =?utf-7?B?alVHMFN5dU9rVXV3aW03WTNQaG9DbDFycm9URmRXQXh5Wkxrb0dVQWQ3ZXRj?=
 =?utf-7?B?M0RWUHMxNHBzQ0NzNCstYUt6bEpBdHFocUZicXNTZ211SnRTQXFQRmZoQnFH?=
 =?utf-7?B?Q0NMREpJbHNvc21MTlpkM0RCZXJDSFROUlcxS0l1VmV5VUlMdHJ4QThmQTQw?=
 =?utf-7?B?TmVoU1FGckNPWHNxcjcwMnM4cVcrLVhJODAyVlhWaUNJNU1IWE52Ky1pZzVH?=
 =?utf-7?B?RmlZUUZ5S1MxQWR4bFIxWkw5N3Y1OWdHYXNPb3ZzZjBuYU9DQzZFUW5vSDgw?=
 =?utf-7?B?MlYwKy1LUmhnelZSVy93R05lekhTUmNlTEk0empUTzZ0Y0dvc2cvdWg0TGNU?=
 =?utf-7?B?T3l2TmI1U2orLWtNRW9KbndQY0U5aVhOOTZUSmhiakNxVGZTcGtjV1pZMG1B?=
 =?utf-7?B?WjY1Q3lNR2NFZThKR01JZzAxak8zbmZtV0lTdFNZd0gzOVdzaTBnQzBiWVhZ?=
 =?utf-7?B?NFF5YnphTi9BS09uR0Z6MUZjL0I5TTE1d3ByRVJld2p1dFlsejRHL05Ub3pQ?=
 =?utf-7?B?ZkE3MWo5MER4S3hxRFRrL0xIMjJjbTM2SFBaWk8yMUNxVFJUdUV5TXAxRlI=?=
 =?utf-7?B?Ky1ZZkE5NXFONWg2OFUyV0FVMjRyQ0Rvckh3eFVrUjZmZnE3Rmh6VistQmhJ?=
 =?utf-7?B?TWxhNnZHTGxTTm96eDlKaSstN1hPVmF2TjRmTjhIS2daTTNBSlFJRWVWR0pp?=
 =?utf-7?B?OEdSM0VDdU9ML2VOTTNZMistNHVIWmEwYk1iRFRoWDlwZkdkZjQzVjFQdHNB?=
 =?utf-7?B?c0U5T2FVR3FyUUdUdWZTNS9QZzQ2U3laVFNXRThBTllwTHg2NGdZUmpmT080?=
 =?utf-7?B?YUFpa0ZnKy1CUDQzRngycUF6Wk5JMmNjb21jclZSYWVzRzFlZWlOWkQvV0Vn?=
 =?utf-7?B?c2Jud3ZzM1dFWWpmM0NYQTZ0WWFTcHNtbkdnaXhseHFlclB1Zzg1bVluL29z?=
 =?utf-7?B?VHE0cUdrNTVQTE53N3hkMTVuWkZYY2cxVFovVXM4bUV6MTllNG5ZeWVaaUx0?=
 =?utf-7?B?VllLSDBhYmY4MldUSEFFRXV1WnpNYVlNVkpMUUJOaFlqTmNrRDVnNkZxRm40?=
 =?utf-7?B?aFpwcWkwL2U4U1lFV1dmdHJpMFNRUzY1cVhDTWRZYk5lOENCUTFXZVJ4eUJE?=
 =?utf-7?B?NVM2YTBVZGVxN0g5cUpJQWlNQXNXRU45RFBWdlU3RXhkTk5tSHZtVDMzZUFa?=
 =?utf-7?B?SE5TM0J4cUZjb09sZ2oxSXZCSTE3NThEVU5MKy1PVk5SbUhwVFE3MEQvVjl3?=
 =?utf-7?B?UEtHQTNnSWVDTnY4dWplQUErLWdzbnR3ajBOSFRPU2Rjb0N4ZENiN2pzZ3h4?=
 =?utf-7?B?R0xnN2xJL2lBTXlOVXNNODJsaU43N1l0ZFR2Ym9sU2lsaEhGTnd2cTlqcVZw?=
 =?utf-7?B?WWkxdGdvbDllbEhoTTR0YnpDTFRLbU5QRTV4V2lYekQ5SWtpd25tRmdtMWdL?=
 =?utf-7?B?azlORXFzSlg4bWpCbnJHSmM0aDI3b0FQWXRjWmErLUlxNE9BMUtkaW9wemI=?=
 =?utf-7?B?Ky14WEtCcEVoMzV2RnhxTGtQL0VhZGFqaUxYWTlhWEt2c1lOVURYSlB4MTRH?=
 =?utf-7?B?UW91cnoyTHhiQjJsR3JFTjVkNGdCUDZsY1B3YlhjY05EU1NBVURJa21qUnd0?=
 =?utf-7?B?emI2d3hCei9ZNEl2RU9BMUZIS05VL0ZHcUNpVUgvQXNFTzdoM21yQmdkNkZQ?=
 =?utf-7?B?QUhRYjFlcFhSVm1hV2xBOE1KcVJlczEzM0ozRE5CY3ZqNXkrLWN0UE85Sm5U?=
 =?utf-7?B?R0UxeG4rLUpjbw==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2d5a54-6b3d-471d-346b-08de22b2bce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 12:47:00.1944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T770RvTAwbKZbpWOthkEH2adlh73ZbIMpHQDH9J6ltOhRmrhD2vHWnSb8B3O8qWuCkqHJOgdFyY6zI+/+XUYAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4471
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511130015
X-Authority-Analysis: v=2.4 cv=Xvf3+FF9 c=1 sm=1 tr=0 ts=6915d348 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=iLNU1ar6AAAA:8 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8
 a=ytFMdNZ7AAAA:8 a=LfxEVeEBAAAA:8 a=eSb-bNSJAAAA:8 a=QEEkIeqjAAAA:8
 a=yb8YxVxcQ5zwd4HfTYIA:9 a=avxi3fN6y70A:10 a=hlJyneSgMmFPbskH-t2w:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=oxySFUAvEW1-6AXleBSr:22 a=7k9nRlTqVbDGZ3p5_T00:22
 a=h7YW-pclpbZRD8svLbQ0:22 a=iapMWHAMLVzCBf0btcAb:22
X-Proofpoint-GUID: qlyxyv9u6xzoIrJSuagL7r1g3zBRUdhp
X-Proofpoint-ORIG-GUID: qlyxyv9u6xzoIrJSuagL7r1g3zBRUdhp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA2MyBTYWx0ZWRfXxxrHccplNGIy
 BCNxUHfRC9yOtZ3hOl3VwJaY8eAj+RQ5aTSwePEc8FGN/FNcB5JHGUS26b6x6J6XkKsHqc43K/A
 XNYQg88soDJtTii5rYNSmPTjRUONvQ8m40V/BNi7zvklVKsChA2TuEFSzS7ixpycQ/wCiOhd9ay
 eRlW5Ew0Y3Gk9tUXCWSnDJB6dG37dbXujGFmX2n5SXyyFjZZ+/ndguPTkDF23QpAUNTxm+5t57L
 kCo8RHYGPTb1OcDQD35thY0SkyFJUY0RTsfxgufXXrnq66uAXMAPc/aVRJbp3+j/gNP2kQahMFh
 B3jkVK6mGU/ZSEctmLQqpiDyjLesc6GAXwNqAfK2CCb6LAAVy3X6Tb4w3CE1077C+gfu7hXhXdK
 gHQ7aR2e50rW5yxsiHY1aPgXJLtmBQ==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080063
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
+AD4- Sent: Wednesday, November 12, 2025 11:23 PM
+AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4AOw- dev+AEA-=
dpdk.org
+AD4- Cc: pravin.m.bathija.dev+AEA-gmail.com
+AD4- Subject: Re: +AFs-PATCH v3 5/5+AF0- vhost+AF8-user: Increase number o=
f memory regions
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- On 11/13/2025 10:13 AM, Bathija, Pravin wrote:
+AD4- +AD4- Answers inline
+AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4- Internal Use - Confidential
+AD4- +AD4APg- -----Original Message-----
+AD4- +AD4APg- From: fengchengwen +ADw-fengchengwen+AEA-huawei.com+AD4-
+AD4- +AD4APg- Sent: Tuesday, November 11, 2025 5:26 PM
+AD4- +AD4APg- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4AOw-=
 dev+AEA-dpdk.org
+AD4- +AD4APg- Cc: pravin.m.bathija.dev+AEA-gmail.com
+AD4- +AD4APg- Subject: Re: +AFs-PATCH v3 5/5+AF0- vhost+AF8-user: Increase=
 number of memory
+AD4- +AD4APg- regions
+AD4- +AD4APg-
+AD4- +AD4APg-
+AD4- +AD4APg- +AFs-EXTERNAL EMAIL+AF0-
+AD4- +AD4APg-
+AD4- +AD4APg- On 11/11/2025 7:34 PM, Bathija, Pravin wrote:
+AD4- +AD4APgA+- Responses inline.
+AD4- +AD4APgA+-
+AD4- +AD4APgA+-
+AD4- +AD4APgA+- Internal Use - Confidential
+AD4- +AD4APgA+AD4- -----Original Message-----
+AD4- +AD4APgA+AD4- From: fengchengwen +ADw-fengchengwen+AEA-huawei.com+AD4=
-
+AD4- +AD4APgA+AD4- Sent: Tuesday, November 4, 2025 12:12 AM
+AD4- +AD4APgA+AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD=
4AOw- dev+AEA-dpdk.org
+AD4- +AD4APgA+AD4- Cc: pravin.m.bathija.dev+AEA-gmail.com
+AD4- +AD4APgA+AD4- Subject: Re: +AFs-PATCH v3 5/5+AF0- vhost+AF8-user: Inc=
rease number of memory
+AD4- +AD4APgA+AD4- regions
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4- On 11/4/2025 12:21 PM, Pravin M Bathija wrote:
+AD4- +AD4APgA+AD4APg- In this patch the number of memory regions are incre=
ased from
+AD4- +AD4APgA+AD4APg- 8 to 128. When a vhost-user front-end such as qemu o=
r libblkio
+AD4- +AD4APgA+AD4APg- queries the back-end such as dpdk with the message, =
get max number
+AD4- +AD4APgA+AD4APg- of memory slots, the back-end replies with this numb=
er 128 instead
+AD4- +AD4APgA+AD4APg- of the previously defined 8. The back-end also alloc=
ates that many
+AD4- +AD4APgA+AD4APg- slots in the memory table where regions are added/re=
moved as
+AD4- +AD4APgA+AD4APg- requested by the vhost-user front-end. This also hel=
ps the vhost-
+AD4- +AD4APgA+AD4APg- user front-end to limit the number of memory regions=
 when sending
+AD4- +AD4APgA+AD4APg- the set mem table message ar adding memory regions.
+AD4- +AD4APgA+AD4APg-
+AD4- +AD4APgA+AD4APg- Signed-off-by: Pravin M Bathija +ADw-pravin.bathija+=
AEA-dell.com+AD4-
+AD4- +AD4APgA+AD4APg- ---
+AD4- +AD4APgA+AD4APg-  lib/vhost/vhost+AF8-user.h +AHw- 2 +--
+AD4- +AD4APgA+AD4APg-  1 file changed, 1 insertion(+-), 1 deletion(-)
+AD4- +AD4APgA+AD4APg-
+AD4- +AD4APgA+AD4APg- diff --git a/lib/vhost/vhost+AF8-user.h b/lib/vhost/=
vhost+AF8-user.h index
+AD4- +AD4APgA+AD4APg- 5a0e747b58..c6ad5b76d6 100644
+AD4- +AD4APgA+AD4APg- --- a/lib/vhost/vhost+AF8-user.h
+AD4- +AD4APgA+AD4APg- +-+-+- b/lib/vhost/vhost+AF8-user.h
+AD4- +AD4APgA+AD4APg- +AEAAQA- -11,7 +-11,7 +AEAAQA-
+AD4- +AD4APgA+AD4APg-
+AD4- +AD4APgA+AD4APg-  /+ACo- refer to hw/virtio/vhost-user.c +ACo-/
+AD4- +AD4APgA+AD4APg-
+AD4- +AD4APgA+AD4APg- -+ACM-define VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS 8
+AD4- +AD4APgA+AD4APg- +-+ACM-define VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS =
128
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4- The address translation may increase a lot if the real =
region is 128.
+AD4- +AD4APgA+AD4- Maybe we should add another patch to optimize it.
+AD4- +AD4APgA+-
+AD4- +AD4APgA+- Could you please share more thoughts on this ?  Are you co=
ncerned
+AD4- +AD4APgA+- about
+AD4- +AD4APg- the number of addresses and translation table bloat ? What
+AD4- +AD4APg- optimization are you suggesting ?
+AD4- +AD4APg-
+AD4- +AD4APg- Because each memory region is independent and does not overl=
ap, maybe
+AD4- +AD4APg- we could use binary search to optimize it.
+AD4- +AD4-
+AD4- +AD4- From what I gather, both of your latest comments, for patches 4=
 and 5 are
+AD4- related to performance impact because of 128 memory regions. My thoug=
hts
+AD4- on this are, I will work on an algorithm to optimize as you suggested=
.
+AD4- Meanwhile we could approve patches 1-4. The rest of the implementatio=
n does
+AD4- not need 128 memory regions. The existing 8 regions are fine. I put i=
n this
+AD4- change as I felt it makes the system scale more and was also suggeste=
d by
+AD4- Maxime. I think patches 1-4 stand by themselves and have been thoroug=
hly
+AD4- tested. Please let me know your thoughts on this.
+AD4-
+AD4- I am OK for this.

Thank you for the quick response. I have just submitted v5 of the patchset =
where I removed the patch which increases the memory regions to 128. Please=
 Ack and help merge to mainline.

+AD4-
+AD4- +AD4-
+AD4- +AD4APg-
+AD4- +AD4APgA+-
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4APg-
+AD4- +AD4APgA+AD4APg-  +ACM-define VHOST+AF8-USER+AF8-NET+AF8-SUPPORTED+AF=
8-FEATURES +AFw-
+AD4- +AD4APgA+AD4APg-     (VIRTIO+AF8-NET+AF8-SUPPORTED+AF8-FEATURES +AHw-=
 +AFw-
+AD4- +AD4APgA+-
+AD4- +AD4APgA+-
+AD4- +AD4-
+AD4- +AD4-

