Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1388FCCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:34:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52A064026A;
	Tue, 11 Nov 2025 12:34:33 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id D05E040144
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:34:30 +0100 (CET)
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB5lglc031546;
 Tue, 11 Nov 2025 06:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=k
 zuhnu7ZQGHQO9/HPuiAEYbWdiE+zkqJKFikjFruMSM=; b=izrpovU2fSgchUmKc
 Z3JFSw1kBgTPZdjH9YqlnXrO7BttDN4VQ0JX8l5p0t09TNNvKF5OrAk9NZg/egqT
 mvkYDm2nYibkq71qxLSAJtJ48nbbhAgxtrVrgHcgR+QZIwpux885oAUZfBLDpPaR
 KB3sZA+qx3psTZq0kS6iATRxkuiu3cO2jzrPKpX22bvjWGIT0VW9iH0xnkAdPQcp
 LNNUnl0yDpPZOD0mxiIdKCspuPU13yaoUDHxQMcmNY8Oo+NjvJbapYzKC3L8ayFY
 lJP+DkLEW5eKq5ysl3FKDBwt+JWuYkrwQfnGIn7QReQDGVZC2gC1HughfFjjF0sG
 Fdo0A==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4aa2rpkxn8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Nov 2025 06:34:29 -0500 (EST)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABBJc3S020627;
 Tue, 11 Nov 2025 06:34:28 -0500
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012012.outbound.protection.outlook.com
 [40.93.195.12])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4aa1t49h9g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Nov 2025 06:34:28 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4ws/k918Q8Y5/GwxchYltZf+G0kTZKg59Vhx42bTIksaLit9gzDR8U7yE4Nq8DzFWhlxrAQjiMrj8Ck8/AfmgRMD6EOAXBzc5NzZwzEjb+adp/NMRnFoFKa0yCagA7roAW9lxrctJWPPRDGCgglNzyd/Igf3WBj5A4aAxqKjbiiAQQj9+c6+ElpOj/0GyuicQpPCmTX2LL7hyw7hU4bSrFPzabCu+XC1AarskjTzX2EZXVILj6LkXmz7u3CaOdr3ZJbW2lA13bKIWV1/SbXd1zjFm113BqXPVoMoRja8R2qLoYc/n55xe74LgCnPwCrAWpJSzyihUFt/O3Po2s9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzuhnu7ZQGHQO9/HPuiAEYbWdiE+zkqJKFikjFruMSM=;
 b=LAZceVr+RhJ6J6/iGFiobW80k/OQRk+GP99LmgSGqUisttmdaM22N83bluZVrKKPEi7k9hhEBBPKNSvmJqUSkZmqpwlS43KJwMtAgvrps3NfvuDP62TuDGw7Du9u/LtXUcUBG9eVfG9YB9ydUptI/Kawo1fOsLD7K+HYEkEm6TkkQtacUCNSRXb3YVVtYZbKniKT9d9RGCOulwTd+B2CTvViSHoqXdClFyTNB8tZF3K3psOLuVboGFbKNepbwyVxg9q24ePsSpA01ex9WQmRS0qnE6FjMT+c/9DcerTTvNZSiJQc9PaN064Tydhr/Oqec2gniofIv1d+gczp7xnvvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by BLAPR19MB4308.namprd19.prod.outlook.com (2603:10b6:208:27f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 11:34:25 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 11:34:25 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: fengchengwen <fengchengwen@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "pravin.m.bathija.dev@gmail.com" <pravin.m.bathija.dev@gmail.com>
Subject: RE: [PATCH v3 5/5] vhost_user: Increase number of memory regions
Thread-Topic: [PATCH v3 5/5] vhost_user: Increase number of memory regions
Thread-Index: AQHcTUK2IE85u2Mbw0+mzrCeCVtp8bTiKvSAgAs3/qA=
Date: Tue, 11 Nov 2025 11:34:25 +0000
Message-ID: <SJ0PR19MB46063C6E41E929271093CE1FF5CFA@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <20251104042142.2787631-1-pravin.bathija@dell.com>
 <20251104042142.2787631-6-pravin.bathija@dell.com>
 <d7af7a2d-939a-45b3-9353-2787ef1dd513@huawei.com>
In-Reply-To: <d7af7a2d-939a-45b3-9353-2787ef1dd513@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-11-11T11:31:33.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|BLAPR19MB4308:EE_
x-ms-office365-filtering-correlation-id: b03a1ae5-d55a-4ee5-c6b6-08de2116447c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-7?B?THJNd3U2amdwOTBQRlZzOXR2eDBzN0hOQkpBOWF6cDZJbTlIRXhwZmtYYnBX?=
 =?utf-7?B?TmtWQTFFVFlzc2JpZFQ0eHQ1b3ZTZGVSSERSd1hKdlpOeE5wVkhKUjdiYVJp?=
 =?utf-7?B?VFFUdHJwUzBMTDlsY3RXNFJ6QzRWVXdaSndYRUVhbFJUWnI5UGZWbmxCVDNS?=
 =?utf-7?B?SUJ1YlVlQWQxRXFuZDNVRGlxVnd3YkRNTkNEYXE3Yi9JdU9pRjUrLUpLZXJq?=
 =?utf-7?B?dHhKcjRDcVEvYmlKeWYxRmhXdFl4SzVwc25jQXBOSGtCT29DREFZeUpBZXpj?=
 =?utf-7?B?S0JlZlpPaVNRQmlyOUVnaWJFOEtUaktEaThLR0xCVnFMNWhEcDJ5ektxSk52?=
 =?utf-7?B?R1BFUlFSZVdqNGFCU2huWGowMVM1RWZVTW5FRi9ac2FseGZMTnpmV0Y1bGMz?=
 =?utf-7?B?c0dONEFRZUpDRUF3bHNSQistaHhjUnVHUVl2L0FKbDZpeHBRMVg4VENwL285?=
 =?utf-7?B?Q3ZHclQrLU1UckUyUlVPb0J4aHJMYzV2bU52aEVJNFI2c3hWOWxybXNUMG1k?=
 =?utf-7?B?QjY2V0M1WG5meEFxRnlQWmhiOElZRzUxR3pTYkdVaystNUpxRUtDb3dDRkhm?=
 =?utf-7?B?VTBjcWhMa1BPY2dYM3ZJUSstRDZtb3ZQYVRQTFltM3BMSjFTdWVNdkRmTEhu?=
 =?utf-7?B?UExsN2ZTREp2OTVuY2N1dnVKR3FNZDhHWGxVNlZUQ3h4RHdZY0E0bmZFQ3Jv?=
 =?utf-7?B?SWlGdzUySHFDVzV4MVYwKy1jemN2QUxDYWpicjl2bWlobWdKQ2E4Vkt0ZHNj?=
 =?utf-7?B?dWZyOXNiSWo5UnplcXpnQnhVa2FNQ0V1U1JpcS8vUGFvKy1URDVLeDhkcGw0?=
 =?utf-7?B?UjlRRXVDRlVsZUx3U1RTY2dVeDB3eVBQdDl0L09LR2VheG5vc1ZEdVN5cG02?=
 =?utf-7?B?TTUrLTlPMHhUb21rQXhiamFkT2lyRG9CSjBlWGdYU0x4amdwREJxVzVmSCst?=
 =?utf-7?B?VVJzb05KNkltYjNucy9IUFRyKy1rTlNOZVJqWEsrLWxGZWxRTlNRVnZVckZD?=
 =?utf-7?B?RzdCQ1VkUGVUMUlSTWxHKy1remxvdzgzVXhOajJqMEtiWGhVbDBNb0haaGd2?=
 =?utf-7?B?aldoblBlYXBYQmhUNzdyWWJ4a0Qva1Fhd2FnaWlWclArLVk4Ky1CcTJUdU1U?=
 =?utf-7?B?Rjc2Yzd5WlBlNUFpYXlralVEZlpyaEwvcGNlTHBzNlhXRnMvVk9RVXMzUEdN?=
 =?utf-7?B?N3NrZGdNTEF1MHp5MEViRDk1ejhjYWFQTlB5cTl0aTM1T3B6NndmckhjOGZK?=
 =?utf-7?B?SnlUV3BCRHp6U0xORk9SY0w1amY4YndWZTU2ajBIZFVETDhzbnBhUFk5WkUx?=
 =?utf-7?B?elBsVjJMSVFxOUs5MXhESHRtSEhLRmY0STFKSmYrLWhNSVNRSkJtM1JnODQ1?=
 =?utf-7?B?M2ZEKy1sR1FtbTVZdkxpWTdOWHFPY3BVQ3pKQ0NDVkJYY1RZYVl3d2F4ZGVs?=
 =?utf-7?B?dXFadHE5b0hHd0FXcWpBWFpnR3krLXNyc2dURjdUbTB1ZlE0VURtV1ZPRTFT?=
 =?utf-7?B?dzdEcXdIUktpTEdiM2hiVUNIYzJyTFlReDVPc2VEN3NKNVhVZE9WT1BRRHhs?=
 =?utf-7?B?T3BIQkw5aEhLVnR3UVVQVDJycUZ1VjFrTkd0MVE0TWZPejdocDBxRVRIM3Vs?=
 =?utf-7?B?Q0lVU2daRlRPcjZxLzhtZDZ4dUtJekFzNmM3UzJYd2piakZyeDNzelRjSXJI?=
 =?utf-7?B?NjNDWDJ3RlphcWd0ekZreTQxOVp2NDUyNE5vZHNrQzRmR3Q5MFRsblk5N1Vn?=
 =?utf-7?B?OGNTRnBOUDU2bHJkV08yT3pTc01SaFIveVY4ak5CYjUzMjdRWWdhTndzVUxC?=
 =?utf-7?B?eEpaWEM4YmoxZXI4cmZmWGVwQVdla0h5aUJKV1Vma0xBeDdZZjdvaDAycklh?=
 =?utf-7?B?MW0vUXVWREFTdi9BYTRnNVdjSkwzREZ0dWI1WmxLV3FHQ0lUb3dJZXJjeUVt?=
 =?utf-7?B?TlhHQ0FoaUtselFuVFNKS1Q0OWhBRU9oRVhwSG1wU3B4M1hmbmF2V1MxQ3kx?=
 =?utf-7?B?UEQ5bk5IaHhGV1g5cy9LMmJXZk9Ob2Rpb2p0Y1hacVlVVHhqdFp4M1BJSHVW?=
 =?utf-7?B?eFZabGsyWnJZeEZuL3lPb1p5aVhqTUc=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?YlVHQmF2c3FNTE8xN2o3d0ZmcS9lc2xKVWJhOHo1WG9FeklraXhOc3FNZWFX?=
 =?utf-7?B?eistQ0xrMUR3USstOTZDcWt4R0ZDVWE4ajNtTlFSSlZhUVVsVmZjandwTHc5?=
 =?utf-7?B?cjJaYVpLdXUyZ2NJcEh1dGxqb0pkWFI5NGt5Ni9qVkZzL3ZIM1I3MDlTSnhN?=
 =?utf-7?B?RTd3UnhqQk9CWjY3TzJVQjdoWFZxWVY0V2hON1B5L1Y4L0tNSFRpSmVJR3lJ?=
 =?utf-7?B?U3laeistdXBBV29UeENIeGxwM29KRExxR2IzaEtxMzNYR1gxUTNRYnVOSSst?=
 =?utf-7?B?ZnFZbUhPcGVKN0dMUDVhYXdHNWh0ZmUxY21MaUx5RXRwM2NOVzZXbEpia1RH?=
 =?utf-7?B?TE1KeWpJcnMyWkFndEkxMHdRU0M2cTlyZ0s5TUE1SzU2NC9tdkIyTC8ydWhm?=
 =?utf-7?B?dDh2Zy96N081dzlqdmFEWlk0bVdYTTJLY29qOVRtc3FxZVV4VFYvZVNIM0xK?=
 =?utf-7?B?aGU4cTBkMldTdzNJTWx0c3NGZVZFdUtnTVpWVistMEZ3N1JKS1d4ZVhBNHc4?=
 =?utf-7?B?cXdxdystL091QnNsMEFXRXZDOWFMNWQybjFET3RKbnVzRXpocG15VkJKRndH?=
 =?utf-7?B?RXBsZnZRMzZtcEl2bmF1THpiSzhTQjhHREdoOU5CNmt0cTR0SWJlZjVBclRV?=
 =?utf-7?B?WHRJNkl0c09kNW5jTlFUWW5nblBjdHNuT1RzL3VoKy04RlVTTlIybjZZS0ZV?=
 =?utf-7?B?eUxtKy1mMDJOSEhzUGhKbTRURXROUGpRMG44aTBNM1dEWlpyUWkrLS9DUUI3?=
 =?utf-7?B?U05LeU1VcHVrNkwyVHBTN0FnWnM4UFdodXJyNG1vaVEwTistTGlqMm1nNWE0?=
 =?utf-7?B?T2hUMWVqR1VJVUZoQkw1VTNqOHEybCstWW1ta0JGcUdzRjZNMUxIVk40STBu?=
 =?utf-7?B?aVI0Y3d2enp2Y2w5WkNoMm02aldqRE5ma1VvUGVXdDJ1QistOThlNlEzYTVB?=
 =?utf-7?B?UVVJOElMM1dYVTNtNTRQN3Vhem5uZ2dsZ0lycistTkpHUEdMWjB1czV2UzRp?=
 =?utf-7?B?ZDhPMzBZKy1Dd3ozSnZlcllMSzFRVzB4aFdoT2kvQnlqazF6dng1dU9pNWFE?=
 =?utf-7?B?U2dFYlVPV1pSdE9EUXRncjM3VksvejVsaGhFKy1IVnRDKy14NjYrLWxpNlVM?=
 =?utf-7?B?VWdGc0FWMnFFQ214ZVFEdXhqTmE5N1VSd3ZYbkZmMC9sKy1mZVVhS2hDS3Nm?=
 =?utf-7?B?a3VaSkJqVnA2SzRsZVhGQURRR2RBdHNxcHNEbG5Sa3l4dW5SckdxbnhQYm5r?=
 =?utf-7?B?UWpITE5ZSEY5Q0xRUTFNSjVuS0pQV0JJRG5kM0ZTOHFhN09yeXY5SWN4aEpP?=
 =?utf-7?B?UUFCRzJBVVlWcWJEd3Jka3I5RUNIazcwaGZaaFZIWHVkKy12QzJvUnZSOUEx?=
 =?utf-7?B?ckNvQWI1d2J1Ky10aTc2UUdxL1dVR0FqMzJkZElFV2VaclJsczhPUE5aNlBB?=
 =?utf-7?B?dWJEVUZNOUQ5N2szNjFsTnpsMmh1Q0o0ckg1QmIzRFJBR2RQNlJPOXBmd3BQ?=
 =?utf-7?B?Z3F1UE1ISXpic1RsNVdjYVNrbTBoUWNMWEl2cWpqc2VQcllwRWFlaEtXblJw?=
 =?utf-7?B?VzRZdlk2aWVNUUhsWW5zMlRNU2FGR3hmSW5sVzErLVB0WElxMGhkTUFrSTgy?=
 =?utf-7?B?OGV3WlJJcjB2RCstU2orLUZjS2xCbFQrLS8xa2lSZHRESVkrLWlRVTZMN1E0?=
 =?utf-7?B?L3Bmd1lkb1ZGSjd1VHNvaHQ2eEVUdFh1RlhNd1dFS3VxVXNCOXU4WXdKTWxt?=
 =?utf-7?B?TEhHTmVKU09mQnhRZGkyTE9GY3llTzhyQmFwUEMvUmZFRkFuclNwZGVjbzJI?=
 =?utf-7?B?dWNOeFJNMUtEUGtvZSstc2VEb2JWMkx1eUZvWDZnM0ZRMTFRc09GTENOdkNM?=
 =?utf-7?B?UXBkZEk5dG9ubHFMWDU5L2NGdmZuZkFGdGRNZWpjQU0vaklVbFBoMlFCcVJP?=
 =?utf-7?B?RXkweFhFOGxBSmwwNDVpQVRIbkx2QjFUY1Z6NmdMV3krLVk1YystRmhrcjR3?=
 =?utf-7?B?bHlZOFZUUFRNU1lIZ01LakQwQ2Z0ZUxiaWl4R2V2SWo5VGFlTFVEMTdBVjNC?=
 =?utf-7?B?MXVVRi9HajNXdUFvdUEzSDZIWGV6MTdwb1dGT3RpQmdRcktxVlV6MVJ4Umx1?=
 =?utf-7?B?R3NiVWd2d2dqUVBhTmpuS0VwNEFGWW5PN2NvTHZ4T0UyR2xndkRYV3BGWkdP?=
 =?utf-7?B?Q3QyM3YxblA=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03a1ae5-d55a-4ee5-c6b6-08de2116447c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 11:34:25.4628 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CESPvwYJTXaAv7j3dhU9xM7v/LSn8KYOjkqQO6y5cK25MD2r8Ai6yc2drmjhN9T0Y9S3/IKqwQgc/+3UEB2jLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4308
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080061
X-Proofpoint-ORIG-GUID: FQ31R_IoHvOg8qhTkEtF_Q30VffHckcJ
X-Proofpoint-GUID: FQ31R_IoHvOg8qhTkEtF_Q30VffHckcJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3MCBTYWx0ZWRfX7aDLgAZ/3nV0
 XUlDUtXf1A8UWKnBEfM+3T+T5ANkhZXWpie/+T9OEZdqvbj/oLN7/ccMvnLcDdJDZk+lxMthmEz
 ldgI6hjzguP8opU9F4+t8Es52/8TwlUCR71QIMTkd3icxFHu8mOwiI3qBWDo6MVwER9UiKQYiYh
 JzFO05Mub1szs3finzOUz9eHRcZaqLr2cLW8WwEaxpEt5p1xzIcge4HuqBTTYFuKva07Z/d6vCn
 6RgJcLRo86sAZObTIWEwUUaUDxwgs7yqG7Kej2KThSqN7juxPIGJrmUbIu49r8A+nFrDWm/LRV/
 EE8tVvcjOPxuj09QysMClEgEWyHBrrqB0E1Rf26MTcMGD84Y0P/Sym7nfVdR49CB5P4OtGLXSVT
 yKHSMD7vKJEGkZrjDvNpaEtJge2/BQ==
X-Authority-Analysis: v=2.4 cv=UqVu9uwB c=1 sm=1 tr=0 ts=69131f45 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=iLNU1ar6AAAA:8 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8
 a=ytFMdNZ7AAAA:8 a=LfxEVeEBAAAA:8 a=eSb-bNSJAAAA:8 a=QEEkIeqjAAAA:8
 a=SYWJ0oKCm70ap6QwyoEA:9 a=avxi3fN6y70A:10 a=hlJyneSgMmFPbskH-t2w:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=oxySFUAvEW1-6AXleBSr:22 a=7k9nRlTqVbDGZ3p5_T00:22
 a=h7YW-pclpbZRD8svLbQ0:22 a=iapMWHAMLVzCBf0btcAb:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080070
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
+AD4- Sent: Tuesday, November 4, 2025 12:12 AM
+AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4AOw- dev+AEA-=
dpdk.org
+AD4- Cc: pravin.m.bathija.dev+AEA-gmail.com
+AD4- Subject: Re: +AFs-PATCH v3 5/5+AF0- vhost+AF8-user: Increase number o=
f memory regions
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- On 11/4/2025 12:21 PM, Pravin M Bathija wrote:
+AD4- +AD4- In this patch the number of memory regions are increased from
+AD4- +AD4- 8 to 128. When a vhost-user front-end such as qemu or libblkio =
queries
+AD4- +AD4- the back-end such as dpdk with the message, get max number of m=
emory
+AD4- +AD4- slots, the back-end replies with this number 128 instead of the
+AD4- +AD4- previously defined 8. The back-end also allocates that many slo=
ts in
+AD4- +AD4- the memory table where regions are added/removed as requested b=
y the
+AD4- +AD4- vhost-user front-end. This also helps the vhost- user front-end=
 to
+AD4- +AD4- limit the number of memory regions when sending the set mem tab=
le
+AD4- +AD4- message ar adding memory regions.
+AD4- +AD4-
+AD4- +AD4- Signed-off-by: Pravin M Bathija +ADw-pravin.bathija+AEA-dell.co=
m+AD4-
+AD4- +AD4- ---
+AD4- +AD4-  lib/vhost/vhost+AF8-user.h +AHw- 2 +--
+AD4- +AD4-  1 file changed, 1 insertion(+-), 1 deletion(-)
+AD4- +AD4-
+AD4- +AD4- diff --git a/lib/vhost/vhost+AF8-user.h b/lib/vhost/vhost+AF8-u=
ser.h index
+AD4- +AD4- 5a0e747b58..c6ad5b76d6 100644
+AD4- +AD4- --- a/lib/vhost/vhost+AF8-user.h
+AD4- +AD4- +-+-+- b/lib/vhost/vhost+AF8-user.h
+AD4- +AD4- +AEAAQA- -11,7 +-11,7 +AEAAQA-
+AD4- +AD4-
+AD4- +AD4-  /+ACo- refer to hw/virtio/vhost-user.c +ACo-/
+AD4- +AD4-
+AD4- +AD4- -+ACM-define VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS 8
+AD4- +AD4- +-+ACM-define VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS 128
+AD4-
+AD4- The address translation may increase a lot if the real region is 128.
+AD4- Maybe we should add another patch to optimize it.

Could you please share more thoughts on this ?  Are you concerned about the=
 number of addresses and translation table bloat ? What optimization are yo=
u suggesting ?

+AD4-
+AD4- +AD4-
+AD4- +AD4-  +ACM-define VHOST+AF8-USER+AF8-NET+AF8-SUPPORTED+AF8-FEATURES =
+AFw-
+AD4- +AD4-     (VIRTIO+AF8-NET+AF8-SUPPORTED+AF8-FEATURES +AHw- +AFw-

