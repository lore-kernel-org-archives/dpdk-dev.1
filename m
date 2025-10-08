Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5F9CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 09:23:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DEC0402A0;
	Wed,  8 Oct 2025 11:23:13 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 0DB1A40297
 for <dev@dpdk.org>; Wed,  8 Oct 2025 11:23:10 +0200 (CEST)
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5985Sfkh002427;
 Wed, 8 Oct 2025 05:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=B
 KRSJJOp65f5pZj3Sqqjs11PQdESibroLX2U8rlMx2c=; b=NOxuU08k1ywDjcXtl
 i8265Mu0F/SjrwRIRPljdAPYWxm1y3cHICGHfAhubLLfDQDu/6lnXPsiKs8cNjJu
 ZcADKytIEFJhKPH6W1fwHI6Us8xw0KkOBgfx5A5evI63G3eQ2h9OMyRE9uAZaZaV
 sBqIy0jnSuvbLqSxb7zD83Yy86duPUBjKRKTuPS8hv/hW2azd2hswXI7EOLC2FWV
 PCwc2W/rGQC8ha4aDghyCgAqFVU67BJSwurUOEwNzWiwi+1ThPhOh+Yc/oDcTeZm
 OD9DFyW5+DTUjJ+aVhCVQK78VUVCmk0OYzUr3sQVBuL8F9+/lgTSu3TY6OphFf5A
 FnlTw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 49jykjgvbh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Oct 2025 05:23:10 -0400 (EDT)
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5986Xs1m018647;
 Wed, 8 Oct 2025 05:23:09 -0400
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011009.outbound.protection.outlook.com
 [40.93.194.9])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 49nj35jcaf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Oct 2025 05:23:09 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUCK3OvLJtNekFBnOtjEhGjWrBQd+nlM/FemimncxndxTlS/pdAl03QS0hKnK3SqZ01Nuejv1gdEdAPyi69Td4CAiylaZ/R+w0ZCZM9dWFLy2++4Y5Ole61gUU15nfB/aS36YkDXIp0Xmsx4XqwPa9xX4baoOVfWiZrjbmA88ao+izrN0PxlIRLsjdEEoscBmkM+7rLujme0ye4Ki0rt/Wawu65QbHO6IM1O+GCuj0BXIXuQyOkCi7iVyoZXBnj2poUGAB7l3FSuimn8X4j6xOKoz0uTQUHafovFEE556Y2OEZPTbyYr33lwrnjf9snDnGCxpFS+d9eLcz4UAoSxjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKRSJJOp65f5pZj3Sqqjs11PQdESibroLX2U8rlMx2c=;
 b=BPRfJGUYcpDQGgOTu1VY+vyXbjq6Uc6B/KXCr2Eg9LqPre6qQcg5oxVoJdThsQW1HuVEKRpYLO1i1eoLcvdskY7nvHPLl5tqvC5ofRh8KlNGCEOjMTtl4/7D+wDkb0MVRWHN0a5PJ/Rm3xhpvIxO/t4Jb1Ij4Fo+QDcpTusS7ueKs2HMznDro/YkqCpUX2ACSO1qDcwtVaEmud+GIbPqNzHniLeQdV0NPkYeoDG68ymB2ZYKEtpvmNS2orUrEBLGQsMy2YUKb4TaF4LNNQsk7Nr9FhYeCgy5oZ7g49UBNsh/0njbRgZs6iN86Np62qav8uKv8roGyRKMu3b1WG8njg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by DS4PPF788F856A3.namprd19.prod.outlook.com (2603:10b6:f:fc00::a29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.17; Wed, 8 Oct
 2025 09:23:04 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 09:23:04 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "pravin.m.bathija.dev@gmail.com" <pravin.m.bathija.dev@gmail.com>
Subject: RE: [PATCH 3/3] vhost_user: support for memory regions
Thread-Topic: [PATCH 3/3] vhost_user: support for memory regions
Thread-Index: AQHcCzGr95dGM6iNwUqD63m0rosAn7R5omgAgD6s15A=
Date: Wed, 8 Oct 2025 09:23:04 +0000
Message-ID: <SJ0PR19MB460611E3275BDC5703AD7731F5E1A@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <20250812023358.2400020-1-pravin.bathija@dell.com>
 <20250812023358.2400020-4-pravin.bathija@dell.com>
 <e0ce893c-89a4-417f-88f5-46c60c6f9ded@redhat.com>
In-Reply-To: <e0ce893c-89a4-417f-88f5-46c60c6f9ded@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-10-08T09:06:22.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|DS4PPF788F856A3:EE_
x-ms-office365-filtering-correlation-id: 73463d7c-2133-4089-41b8-08de064c4923
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-7?B?S1dhQkV3Ky0rLWF2RXhHMnJpTm43Ky1vTkNIQkloV2RIYWJibThKV0dQMEJr?=
 =?utf-7?B?ZS9nM3VSemJpVU5yNHo1U3VNc285a1ZVQVoyU2NRODJHZW1mYjRVV1o3MEpM?=
 =?utf-7?B?RWxoampTc0tjWUtsWSstcEJWYzZ1THFBQ0tyN3RkeWhrR3BWcFp2TUtrUUtm?=
 =?utf-7?B?WTlxYkRNWGpGNWZnZ0JQaXJsWEVuVXR5aERaNSsteXNycUdFd3dpa0NuL1Zr?=
 =?utf-7?B?VFRPZEpiQkNwMmZrY2hOZjhMcGZpOVdqYlN1T2lCb2VpNlIrLXBEZHU1QUMv?=
 =?utf-7?B?dmJLdXA2cXlKOTkrLTVQa3RDM2JCdkZ0WDRaTEhzNXNXckRRR2ZpeEpheUZl?=
 =?utf-7?B?SDBoWGtMdnd3VXVQWkp1NGltWDNIOTRVd00vcGl4OFYxTjJLZCstYzVYbzZX?=
 =?utf-7?B?NnIzZHlrUUR3YlZlZ2tqQ3VWVHZJMjBuM2pTVGZIR2p6S1dSc2xaWnVTTVpt?=
 =?utf-7?B?YTBmMkt1aktwVTFUVzhlTEhRODNOaFk0enNIYlRuT0k3VkJxbVE5WlpMZFFX?=
 =?utf-7?B?RTNlcnB1NW90SG1MQ3VkRDFIT2Z5R1VXOGROYm1DRWlOOHVtQ01GaHA4SGgx?=
 =?utf-7?B?L2NtUDNDMndzbDNKOHpEa09tSTllNTgwdm1ZdVJudlVMbnBabkNSN09mTXBE?=
 =?utf-7?B?SC91aUV2V2I2TkJUaFB0am9mTHdHNjBCSUx2VU1aL3JBZDAyUlFSbXVzYlk3?=
 =?utf-7?B?SHZFaGxkZ0xiKy1mcnM5OXlkVW9qSHpSbUVZOGdYSU5ObG9rZzltNmNKYno4?=
 =?utf-7?B?QVJHeW1wbWtYSTErLWRONlJCNFQyN2c1eExFVjBaYmZoUTlvdUo2aEtjbU9Q?=
 =?utf-7?B?dmg1Nlg5SEVmV21meXJiaFFsa2xWaVdkRUgzYmo4Ky1PWU9rTTZUb2ErLXUv?=
 =?utf-7?B?OWFNaTBkcVFrazU4cTRlNk1QMThUb2lZKy1Ma29PUFB3YWJZaExEWnM2ZnFs?=
 =?utf-7?B?VEF3c1VXY2JBVHp3MVJ4RGNoellPcGNkM2pEaEZpT3RCVjRKRDFkd3ZqSHZJ?=
 =?utf-7?B?THFveHM4dE1qQ2YwY2prNUMyVkhzdERRSWducnRHVkQ4VjJIRWtSS1Y4Ym9u?=
 =?utf-7?B?REJLV0ZHVTVOc0FtMnRXS3paMTRtY014NnB6SWx3T0dNeERjVXZFdlphY1FR?=
 =?utf-7?B?dVhpWnNWVzNHb2QvSHZzT3NjVVlhSFhBT2IxY0ZwMER1SldSSGYrLTZ1Yzlm?=
 =?utf-7?B?UXJTU1cvR0pBTUJQSDJWbTFIcjVxTzY1V0JsSHFBNHdEME82SUp3V3dUNGZR?=
 =?utf-7?B?VUpNVXo4Mmpkc3NnVmpibDJCYnUrLXJmcERJMEFkckpNdHp1Ynh0TnJXMUQ5?=
 =?utf-7?B?cDFiMmIrLVpxd09yRTY4Y1U0aFBDRjVUNWZ5dWRTakRhb2d3NTFJbmdJU2tm?=
 =?utf-7?B?WDM3Zjc3UG5xMUR0U3RORVFGam1qM0lGSGJlL1Y3cmhhQ0wzOVRtU1lmTTJx?=
 =?utf-7?B?Q0tXTmlJRVk1MU9tcjVKWjNyT0g1TGk1bmtXSXF6L2N6eExsUnIvdnYxb1NL?=
 =?utf-7?B?em5lMTlDV0MwMDk1bDIzQ1E2eWswMHZaQXdMbll1TWFzalZ2RmdYTFdLdUha?=
 =?utf-7?B?OVVnczRPUTVKT0RGL0JuMERNWWFrZ2crLUZQcnVuTU9LaXpFSGYzbER4T2ho?=
 =?utf-7?B?aUo3Ky1YZ25VemZhNVFoV3ZWVVV0VDFKV2xPYUtWMWtQcEtTd0laQXlGaUxi?=
 =?utf-7?B?aUthNTBFR2lTYkVZZkZ5WlZjMXBwcDcxYXF4OWYwY0FIYnRaMkk0TGFHV3Bq?=
 =?utf-7?B?TlVwYWdiKy1RUWFrUGtuaklRNGhyWjFlQ21leGpxKy11MUNWMjVjSDZwTWRX?=
 =?utf-7?B?UlRNOTRyRFdLVW5ZMlM0b1AvSkxlT0JBUFRrVktMSUJKZTZiRGVuRFVLN0VY?=
 =?utf-7?B?Uk9rRUJLWlBnbFBJWWtBdWRIcFExc29GWHRhaDMxMFhRbHA5Y0lLSEdDNnlq?=
 =?utf-7?B?VTVMSzVKVFowZVVpM0ZhaGZMc1o1VVQrLURzalB1c3htODhnVGNZeUNSWXJG?=
 =?utf-7?B?WnRlOXNhQVhYL1FlcFBzVmpObzNkdXYyZWFhOE9ScXlJT1dCNHpzS2k4ZS9N?=
 =?utf-7?B?OUd2QzVaZ0cwcVFldystcUlXTzM4U0JWZm5wRw==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?dmZVVkVPeDA0c1F5ZXZNekFiOHpHUVI3QVRLVHRVV2lWbkJ4eUU0cGpjVFF4?=
 =?utf-7?B?RmEwZERKNm04ZTQ3Qi8wZEhQYzEzcGFvOEt0elpIR3JJdTBYdXpxeXFrdE5P?=
 =?utf-7?B?VG9GWDVKVDh5L1MyY0Q3SENqVUpJMjhNTXhTUFZZaU5lRG82bXJwYkFyV1Fs?=
 =?utf-7?B?S3VzKy12SWozTlhNMEFWbTVvT1NQYWFPMSstQXFmRktDeU4zUlJEeXZtNFNQ?=
 =?utf-7?B?c3l4TjFJWW5Ldk1sZkVKbm5lbmxIL0lqa0xEZHh3amRjTVVtYzFZaWVyT0Q3?=
 =?utf-7?B?M3JsRnZOMHRWY2JrZTg1Zld6cmJNdzE4L1RCcUgyRG9hYTFFTGlCcVZ2SUhQ?=
 =?utf-7?B?SWRXeVZ5NWhuWGc5empmT2xLcWF4VnM4RWxBaUJsYVEzY1BmcWFESHlsTXN2?=
 =?utf-7?B?b2oxNWtKZDl3WHFKMXVSYnpBLzJLQWxCOVYzZSstdXVtN0l0NDFIbUFiSWly?=
 =?utf-7?B?R1owbGthei91WjNENmVoNkU1NmNSSndGazludDg3b2ljeFJITjRZMWJZU2Jz?=
 =?utf-7?B?WkZONGlKSFdKbDBEaWJUYXFEd0MrLTd1MkU4VGorLTYzc3QrLVlhSEQ4NTd2?=
 =?utf-7?B?eERYY2FrbENzdFQzMzNldTd2RmFpNWVnL0RQRjR6cjNERlZNTjM0dGU2Z2JZ?=
 =?utf-7?B?eHdWWG1kVlNsM0lTUmp2MWZUNFJtbzhUd0M1eCstbHU1TTJPVmhlWlJ4Ti9h?=
 =?utf-7?B?RDcrLTl0NG5aUHpnNGNmTWxZNTlGaVJEcjVmTEZjZThhMTZiU1dldVNRaUx2?=
 =?utf-7?B?WG43eTZzaXlBNVpLcSstVENhNURESHpRQWY5eEJIZ1FLYVYzMjJVT2IxZ042?=
 =?utf-7?B?aVhFekJUeEFZWSstM3IyOGJ1SEd4Mm04WUJqdXFSMEhlOExsNXBuV29oc3ht?=
 =?utf-7?B?c2N5blhIRGJyb1lRd0dvRHpTRk8yNGJYc0x0T2ppam51S2ZUQzJTcElHM3c4?=
 =?utf-7?B?emVNR1dybG5XdllvcmZnR1ZHR1R0bDVJOTNNdFlZYTlHMEJMbmlHNWxoWUVP?=
 =?utf-7?B?T0tWRDJ6UmlHY0drZXJ2dGs4UmdQQXpOeklWRzRFTGlFdzl2M0pXNSstSHR5?=
 =?utf-7?B?dHh2MUVCbTVRN2FzNjR5REdyenNiRnVpc094NUFpd3RUbUZPLzVCaUJ3MzFI?=
 =?utf-7?B?TXhuQW1NODFKd1IrLVo2Y25YYUtzTFVGeUQ0QmNQUFAzWWhPaWFIdWFRZUVv?=
 =?utf-7?B?aThveU9kOUU3c21maFdPb1Q2TnBla2tCWWVUUzZiRWZranc3RCstM2dLYlRl?=
 =?utf-7?B?YzlQL3l5aXVOeWsrLTdhRUI1T0dVQTJOWXA1cDN0cW0xZ2dJdEpDdFNhM3Q=?=
 =?utf-7?B?Ky13VHdycGo4VUNnMjlhbG5GL054ZmlaRGFYdFlURmdpRFcrLUVGWnp2d05k?=
 =?utf-7?B?RWwrLUgwekxKa0pZWE16NW1lelkrLS9CeEhrVlYxNlY1M2JQQk1yeWtnRHgv?=
 =?utf-7?B?NXVNWGVlSSstc1IrLVU5UmlRS2dsdmR2akI4WkJhSi9NWkdISjhXQmNiT1NG?=
 =?utf-7?B?amFhUWxLcklCQkpwOWIyQUx2T1NXVkcxamxmKy1NQ0JFckdqVFNtQUxJM2Y5?=
 =?utf-7?B?S0R0ZVQ3OEtvMTRLM0xyQzFiaGR4S0VxaU9Xb3B1dlMyRlpva2pScENCWWNo?=
 =?utf-7?B?aFB6RkRyRENHcUJoWmF5N285Tk51U3RMcUxLUHE4N1BIdVlONWdtNGU5enBt?=
 =?utf-7?B?dGZTKy1pWWdGRVJ3NTdBb2dCd0VNblR2OUJoSEUwL2xFbUxzUTdrR0swSDU2?=
 =?utf-7?B?Z2RZeU1HKy1WWWlKQ01oMTFJSVEzUistaE9BbystSHdRdVlUTlRCbVp0cDhs?=
 =?utf-7?B?dW9zTDZBQWZ1aXl4TGl0eXNRRlN6QkRQVUtHZU4zYWtwVW55aUVYMjYwNmlY?=
 =?utf-7?B?MVVHZWErLWRNKy13cXBYenlBbTJBTy80MXJDVHJNSWl4V29RektRQXhCQ3hO?=
 =?utf-7?B?YlI3TU9NZDlLeG42OHVxdFIzdWxTU0xubWtSQWRPOGh4UDdKS2ljSFh5UkJZ?=
 =?utf-7?B?Y28rLVZYa2JJR1NoZzZzbmlTOVNqdlg0cXVLYVkzQWRxam9nTXlINlpQZkZ6?=
 =?utf-7?B?SUxQb0cxMXVlY25MNGx4ckJRck1lbkwweTdnbmpaMTFDRDJqclNqck1tTUM2?=
 =?utf-7?B?TU5Fd3dsSUR5eUhJaDJhSm8rLWZnTjlDamhxV2gyd0l4c1plVnZ0Rzd6cUEy?=
 =?utf-7?B?c3NpbUJUNG1nMA==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73463d7c-2133-4089-41b8-08de064c4923
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 09:23:04.7230 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vM1VIyDljdYJAtmvDn7wKP9Nyl5labTkDAsiAiRytc6zCnplLM+ypkBsHmDNqOnkP7m7ALAGnMQAAiy2d5EGhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF788F856A3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510080036
X-Authority-Analysis: v=2.4 cv=LacxKzfi c=1 sm=1 tr=0 ts=68e62d7e cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=x6icFKpwvdMA:10 a=20KFwNOVAAAA:8 a=iLNU1ar6AAAA:8
 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8 a=XlRjxQ70AAAA:8 a=LfxEVeEBAAAA:8
 a=eSb-bNSJAAAA:8 a=QEEkIeqjAAAA:8 a=oaZbdQ4R3UHVMw9MeQcA:9 a=avxi3fN6y70A:10
 a=gbU3OgOOxF9bX48Letew:22 a=YjdVzJdQTyZRADMV7wFX:22 a=1uMOUU2w0DxzEe95gQqD:22
 a=7k9nRlTqVbDGZ3p5_T00:22 a=h7YW-pclpbZRD8svLbQ0:22 a=iapMWHAMLVzCBf0btcAb:22
X-Proofpoint-GUID: XSmKZFFr4b7fpafu6Z2QRyjJ1Sh-eMGu
X-Proofpoint-ORIG-GUID: XSmKZFFr4b7fpafu6Z2QRyjJ1Sh-eMGu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDA2NiBTYWx0ZWRfXxW3ZQpB7mKUM
 OVtI3XT6BLp/kH1unSHbBs5QCi8ja0bCx4nDDkz/wRL5QAUI46F85SWDXIiI0AtSy8xHS+E4jH2
 5kPc6UT3cn65041H2BzwavQus+9bdAV6JK25+rXKh/TmDQmDAWcFK2qF3Fw/kd5BgbryX+utx2C
 4BQagSO6+QFjZ/x+qG7WHpD4TIGCuVyXlQ3xJVGAthRbEre74xmWEA0SKyn7ZZCP8s6ikJa8wxZ
 xtlP9XIkZ5Zg1YkA7C5J9Z6uimWb/brTRiCF6PU+FCeq2rB/KqiRx57LFSQhOmuiEQa8iBcaupL
 68XhmtlVBx8hlLrs6zirh+GnLgh1oXzqZ64OfQ2x4qqM9AQb3E4825xnnlGxiHaSzTbunIXt24Z
 5fubz5K4Rlar5rq9pyupyLnnx+y/bg==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040066
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

Dear Maxime,

I have made the changes as you suggested and also have some queries inline =
as per your comments.


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Maxime Coquelin +ADw-maxime.coquelin+AEA-redhat.com+AD4-
+AD4- Sent: Friday, August 29, 2025 5:00 AM
+AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4AOw- dev+AEA-=
dpdk.org
+AD4- Cc: pravin.m.bathija.dev+AEA-gmail.com
+AD4- Subject: Re: +AFs-PATCH 3/3+AF0- vhost+AF8-user: support for memory r=
egions
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- The title is not consistent with other commits in this library.
+AD4-
+AD4- On 8/12/25 4:33 AM, Pravin M Bathija wrote:
+AD4- +AD4- - modify data structures and add functions to support
+AD4- +AD4-    add and remove memory regions/slots
+AD4- +AD4- - define VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS +ACY- modify fun=
ction
+AD4- +AD4-    vhost+AF8-user+AF8-set+AF8-mem+AF8-table accordingly
+AD4- +AD4- - dynamically add new memory slots via vhost+AF8-user+AF8-add+A=
F8-mem+AF8-reg
+AD4- +AD4- - remove unused memory slots via vhost+AF8-user+AF8-rem+AF8-mem=
+AF8-reg
+AD4- +AD4- - define data structure VhostUserSingleMemReg for single
+AD4- +AD4-    memory region
+AD4- +AD4- - modify data structures VhostUserRequest +ACY- VhostUserMsg
+AD4- +AD4-
+AD4-
+AD4- Please write full sentences, explaining the purpose of this change an=
d not just
+AD4- listing the changes themselves.
Done the best I can in the new patch-set I just submitted.

+AD4-
+AD4- +AD4- Signed-off-by: Pravin M Bathija +ADw-pravin.bathija+AEA-dell.co=
m+AD4-
+AD4- +AD4- ---
+AD4- +AD4-   lib/vhost/vhost+AF8-user.c +AHw- 325 +-+-+-+-+-+-+-+-+-+-+-+-=
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+----
+AD4- ---
+AD4- +AD4-   lib/vhost/vhost+AF8-user.h +AHw-  10 +-+-
+AD4- +AD4-   2 files changed, 291 insertions(+-), 44 deletions(-)
+AD4- +AD4-
+AD4- +AD4- diff --git a/lib/vhost/vhost+AF8-user.c b/lib/vhost/vhost+AF8-u=
ser.c index
+AD4- +AD4- b73dec6a22..6367f54b97 100644
+AD4- +AD4- --- a/lib/vhost/vhost+AF8-user.c
+AD4- +AD4- +-+-+- b/lib/vhost/vhost+AF8-user.c
+AD4- +AD4- +AEAAQA- -74,6 +-74,9 +AEAAQA-
+AD4- VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SET+AF8-FEATURES,
+AD4- vhost+AF8-user+AF8-set+AF8-features, false, t
+AD4- +AD4-   VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SET+AF8-OWNE=
R,
+AD4- vhost+AF8-user+AF8-set+AF8-owner, false, true) +AFw-
+AD4- +AD4-   VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-RESET+AF8-OW=
NER,
+AD4- vhost+AF8-user+AF8-reset+AF8-owner, false, false) +AFw-
+AD4- +AD4-   VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SET+AF8-MEM+=
AF8-TABLE,
+AD4- +AD4- vhost+AF8-user+AF8-set+AF8-mem+AF8-table, true, true) +AFw-
+AD4- +AD4- +-VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-GET+AF8-MAX+=
AF8-MEM+AF8-SLOTS,
+AD4- +AD4- +-vhost+AF8-user+AF8-get+AF8-max+AF8-mem+AF8-slots, false, fals=
e) +AFw-
+AD4- +AD4- +-VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-ADD+AF8-MEM+=
AF8-REG,
+AD4- vhost+AF8-user+AF8-add+AF8-mem+AF8-reg,
+AD4- +AD4- +-true, true) +AFw- VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USE=
R+AF8-REM+AF8-MEM+AF8-REG,
+AD4- +AD4- +-vhost+AF8-user+AF8-rem+AF8-mem+AF8-reg, true, true) +AFw-
+AD4-
+AD4- Shouldn't it be:
+AD4- VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-REM+AF8-MEM+AF8-REG,
+AD4- vhost+AF8-user+AF8-rem+AF8-mem+AF8-reg, false, true)
+AD4-
+AD4- And if not, aren't you not leaking FDs in vhost+AF8-user+AF8-rem+AF8-=
mem+AF8-reg?
+AD4-
Good catch. I have made the suggested change in the new patch-set.

+AD4- +AD4-   VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SET+AF8-LOG+=
AF8-BASE,
+AD4- vhost+AF8-user+AF8-set+AF8-log+AF8-base, true, true) +AFw-
+AD4- +AD4-   VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SET+AF8-LOG+=
AF8-FD,
+AD4- vhost+AF8-user+AF8-set+AF8-log+AF8-fd, true, true) +AFw-
+AD4- +AD4-   VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SET+AF8-VRIN=
G+AF8-NUM,
+AD4- +AD4- vhost+AF8-user+AF8-set+AF8-vring+AF8-num, false, true) +AFw- +A=
EAAQA- -228,7 +-231,17 +AEAAQA-
+AD4- async+AF8-dma+AF8-map(struct virtio+AF8-net +ACo-dev, bool do+AF8-map=
)
+AD4- +AD4-   +AH0-
+AD4- +AD4-
+AD4- +AD4-   static void
+AD4- +AD4- -free+AF8-mem+AF8-region(struct virtio+AF8-net +ACo-dev)
+AD4- +AD4- +-free+AF8-mem+AF8-region(struct rte+AF8-vhost+AF8-mem+AF8-regi=
on +ACo-reg) +AHs-
+AD4- +AD4- +-   if (reg +ACEAPQ- NULL +ACYAJg- reg-+AD4-host+AF8-user+AF8-=
addr) +AHs-
+AD4- +AD4- +-           munmap(reg-+AD4-mmap+AF8-addr, reg-+AD4-mmap+AF8-s=
ize)+ADs-
+AD4- +AD4- +-           close(reg-+AD4-fd)+ADs-
+AD4- +AD4- +-           memset(reg, 0, sizeof(struct rte+AF8-vhost+AF8-mem=
+AF8-region))+ADs-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-+AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-static void
+AD4- +AD4- +-free+AF8-all+AF8-mem+AF8-regions(struct virtio+AF8-net +ACo-d=
ev)
+AD4- +AD4-   +AHs-
+AD4- +AD4-     uint32+AF8-t i+ADs-
+AD4- +AD4-     struct rte+AF8-vhost+AF8-mem+AF8-region +ACo-reg+ADs-
+AD4- +AD4- +AEAAQA- -239,12 +-252,10 +AEAAQA- free+AF8-mem+AF8-region(stru=
ct virtio+AF8-net +ACo-dev)
+AD4- +AD4-     if (dev-+AD4-async+AF8-copy +ACYAJg- rte+AF8-vfio+AF8-is+AF=
8-enabled(+ACI-vfio+ACI-))
+AD4- +AD4-             async+AF8-dma+AF8-map(dev, false)+ADs-
+AD4- +AD4-
+AD4- +AD4- -   for (i +AD0- 0+ADs- i +ADw- dev-+AD4-mem-+AD4-nregions+ADs-=
 i+-+-) +AHs-
+AD4- +AD4- +-   for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMORY+AF8-MAX+AF8-N=
REGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4-             reg +AD0- +ACY-dev-+AD4-mem-+AD4-regions+AFs-i+AF0A=
Ow-
+AD4- +AD4- -           if (reg-+AD4-host+AF8-user+AF8-addr) +AHs-
+AD4- +AD4- -                   munmap(reg-+AD4-mmap+AF8-addr, reg-+AD4-mma=
p+AF8-size)+ADs-
+AD4- +AD4- -                   close(reg-+AD4-fd)+ADs-
+AD4- +AD4- -           +AH0-
+AD4- +AD4- +-           if (reg-+AD4-mmap+AF8-addr)
+AD4- +AD4- +-                   free+AF8-mem+AF8-region(reg)+ADs-
+AD4-
+AD4- Please split this patch in multiple ones.
+AD4- Do the refactorings in dedicated patches.

I have split the original patch into multiple patches.

+AD4-
+AD4- +AD4-     +AH0-
+AD4- +AD4-   +AH0-
+AD4- +AD4-
+AD4- +AD4- +AEAAQA- -258,7 +-269,7 +AEAAQA- vhost+AF8-backend+AF8-cleanup(=
struct virtio+AF8-net +ACo-dev)
+AD4- +AD4-             vdpa+AF8-dev-+AD4-ops-+AD4-dev+AF8-cleanup(dev-+AD4=
-vid)+ADs-
+AD4- +AD4-
+AD4- +AD4-     if (dev-+AD4-mem) +AHs-
+AD4- +AD4- -           free+AF8-mem+AF8-region(dev)+ADs-
+AD4- +AD4- +-           free+AF8-all+AF8-mem+AF8-regions(dev)+ADs-
+AD4- +AD4-             rte+AF8-free(dev-+AD4-mem)+ADs-
+AD4- +AD4-             dev-+AD4-mem +AD0- NULL+ADs-
+AD4- +AD4-     +AH0-
+AD4- +AD4- +AEAAQA- -707,7 +-718,7 +AEAAQA- numa+AF8-realloc(struct virtio=
+AF8-net +ACoAKg-pdev, struct
+AD4- vhost+AF8-virtqueue +ACoAKg-pvq)
+AD4- +AD4-     vhost+AF8-devices+AFs-dev-+AD4-vid+AF0- +AD0- dev+ADs-
+AD4- +AD4-
+AD4- +AD4-     mem+AF8-size +AD0- sizeof(struct rte+AF8-vhost+AF8-memory) =
+-
+AD4- +AD4- -           sizeof(struct rte+AF8-vhost+AF8-mem+AF8-region) +AC=
o- dev-+AD4-mem-+AD4-nregions+ADs-
+AD4- +AD4- +-           sizeof(struct rte+AF8-vhost+AF8-mem+AF8-region) +A=
Co-
+AD4- VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS+ADs-
+AD4- +AD4-     mem +AD0- rte+AF8-realloc+AF8-socket(dev-+AD4-mem, mem+AF8-=
size, 0, node)+ADs-
+AD4- +AD4-     if (+ACE-mem) +AHs-
+AD4- +AD4-             VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR, +AEA=
AQA- -811,8 +-822,10
+AD4- +AEAAQA-
+AD4- +AD4- hua+AF8-to+AF8-alignment(struct rte+AF8-vhost+AF8-memory +ACo-m=
em, void +ACo-ptr)
+AD4- +AD4-     uint32+AF8-t i+ADs-
+AD4- +AD4-     uintptr+AF8-t hua +AD0- (uintptr+AF8-t)ptr+ADs-
+AD4- +AD4-
+AD4- +AD4- -   for (i +AD0- 0+ADs- i +ADw- mem-+AD4-nregions+ADs- i+-+-) +=
AHs-
+AD4- +AD4- +-   for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMORY+AF8-MAX+AF8-N=
REGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4-             r +AD0- +ACY-mem-+AD4-regions+AFs-i+AF0AOw-
+AD4- +AD4- +-           if (r-+AD4-host+AF8-user+AF8-addr +AD0APQ- 0)
+AD4- +AD4- +-                   continue+ADs-
+AD4- +AD4-             if (hua +AD4APQ- r-+AD4-host+AF8-user+AF8-addr +ACY=
AJg-
+AD4- +AD4-                     hua +ADw- r-+AD4-host+AF8-user+AF8-addr +- =
r-+AD4-size) +AHs-
+AD4- +AD4-                     return get+AF8-blk+AF8-size(r-+AD4-fd)+ADs-
+AD4- +AD4- +AEAAQA- -1250,9 +-1263,13 +AEAAQA- vhost+AF8-user+AF8-postcopy=
+AF8-register(struct virtio+AF8-net
+AD4- +ACo-dev, int main+AF8-fd,
+AD4- +AD4-      +ACo- retrieve the region offset when handling userfaults.
+AD4- +AD4-      +ACo-/
+AD4- +AD4-     memory +AD0- +ACY-ctx-+AD4-msg.payload.memory+ADs-
+AD4- +AD4- -   for (i +AD0- 0+ADs- i +ADw- memory-+AD4-nregions+ADs- i+-+-=
) +AHs-
+AD4- +AD4- +-   for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMORY+AF8-MAX+AF8-N=
REGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4- +-           int reg+AF8-msg+AF8-index +AD0- 0+ADs-
+AD4- +AD4-             reg +AD0- +ACY-dev-+AD4-mem-+AD4-regions+AFs-i+AF0A=
Ow-
+AD4- +AD4- -           memory-+AD4-regions+AFs-i+AF0-.userspace+AF8-addr +=
AD0- reg-+AD4-host+AF8-user+AF8-addr+ADs-
+AD4- +AD4- +-           if (reg-+AD4-host+AF8-user+AF8-addr +AD0APQ- 0)
+AD4- +AD4- +-                   continue+ADs-
+AD4- +AD4- +-           memory-+AD4-regions+AFs-reg+AF8-msg+AF8-index+AF0-=
.userspace+AF8-addr +AD0- reg-
+AD4- +AD4-host+AF8-user+AF8-addr+ADs-
+AD4- +AD4- +-           reg+AF8-msg+AF8-index+-+-+ADs-
+AD4- +AD4-     +AH0-
+AD4- +AD4-
+AD4- +AD4-     /+ACo- Send the addresses back to qemu +ACo-/ +AEAAQA- -127=
9,8 +-1296,10 +AEAAQA-
+AD4- +AD4- vhost+AF8-user+AF8-postcopy+AF8-register(struct virtio+AF8-net =
+ACo-dev, int main+AF8-fd,
+AD4- +AD4-     +AH0-
+AD4- +AD4-
+AD4- +AD4-     /+ACo- Now userfault register and we can use the memory +AC=
o-/
+AD4- +AD4- -   for (i +AD0- 0+ADs- i +ADw- memory-+AD4-nregions+ADs- i+-+-=
) +AHs-
+AD4- +AD4- +-   for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMORY+AF8-MAX+AF8-N=
REGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4-             reg +AD0- +ACY-dev-+AD4-mem-+AD4-regions+AFs-i+AF0A=
Ow-
+AD4- +AD4- +-           if (reg-+AD4-host+AF8-user+AF8-addr +AD0APQ- 0)
+AD4- +AD4- +-                   continue+ADs-
+AD4- +AD4-             if (vhost+AF8-user+AF8-postcopy+AF8-region+AF8-regi=
ster(dev, reg) +ADw- 0)
+AD4- +AD4-                     return -1+ADs-
+AD4- +AD4-     +AH0-
+AD4- +AD4- +AEAAQA- -1385,6 +-1404,46 +AEAAQA- vhost+AF8-user+AF8-mmap+AF8=
-region(struct virtio+AF8-net +ACo-dev,
+AD4- +AD4-     return 0+ADs-
+AD4- +AD4-   +AH0-
+AD4- +AD4-
+AD4- +AD4- +-static int
+AD4- +AD4- +-vhost+AF8-user+AF8-initialize+AF8-memory(struct virtio+AF8-ne=
t +ACoAKg-pdev) +AHs-
+AD4- +AD4- +-   struct virtio+AF8-net +ACo-dev +AD0- +ACo-pdev+ADs-
+AD4- +AD4- +-   int numa+AF8-node +AD0- SOCKET+AF8-ID+AF8-ANY+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   /+ACo-
+AD4- +AD4- +-    +ACo- If VQ 0 has already been allocated, try to allocate=
 on the same
+AD4- +AD4- +-    +ACo- NUMA node. It can be reallocated later in numa+AF8-=
realloc().
+AD4- +AD4- +-    +ACo-/
+AD4- +AD4- +-   if (dev-+AD4-nr+AF8-vring +AD4- 0)
+AD4- +AD4- +-           numa+AF8-node +AD0- dev-+AD4-virtqueue+AFs-0+AF0--=
+AD4-numa+AF8-node+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   dev-+AD4-nr+AF8-guest+AF8-pages +AD0- 0+ADs-
+AD4- +AD4- +-   if (dev-+AD4-guest+AF8-pages +AD0APQ- NULL) +AHs-
+AD4- +AD4- +-           dev-+AD4-max+AF8-guest+AF8-pages +AD0- 8+ADs-
+AD4- +AD4- +-           dev-+AD4-guest+AF8-pages +AD0- rte+AF8-zmalloc+AF8=
-socket(NULL,
+AD4- +AD4- +-                                   dev-+AD4-max+AF8-guest+AF8=
-pages +ACo-
+AD4- +AD4- +-                                   sizeof(struct guest+AF8-pa=
ge),
+AD4- +AD4- +-                                   RTE+AF8-CACHE+AF8-LINE+AF8=
-SIZE,
+AD4- +AD4- +-                                   numa+AF8-node)+ADs-
+AD4- +AD4- +-           if (dev-+AD4-guest+AF8-pages +AD0APQ- NULL) +AHs-
+AD4- +AD4- +-                   VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, =
ERR,
+AD4- +AD4- +-                           +ACI-failed to allocate memory for=
 dev-
+AD4- +AD4-guest+AF8-pages+ACI-)+ADs-
+AD4- +AD4- +-                   return -1+ADs-
+AD4- +AD4- +-           +AH0-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   dev-+AD4-mem +AD0- rte+AF8-zmalloc+AF8-socket(+ACI-vhost-m=
em-table+ACI-, sizeof(struct
+AD4- rte+AF8-vhost+AF8-memory) +-
+AD4- +AD4- +-           sizeof(struct rte+AF8-vhost+AF8-mem+AF8-region) +A=
Co-
+AD4- VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS, 0, numa+AF8-node)+ADs-
+AD4- +AD4- +-   if (dev-+AD4-mem +AD0APQ- NULL) +AHs-
+AD4- +AD4- +-           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR, +AC=
I-failed to allocate
+AD4- memory for dev-+AD4-mem+ACI-)+ADs-
+AD4- +AD4- +-           rte+AF8-free(dev-+AD4-guest+AF8-pages)+ADs-
+AD4- +AD4- +-           dev-+AD4-guest+AF8-pages +AD0- NULL+ADs-
+AD4- +AD4- +-           return -1+ADs-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   return 0+ADs-
+AD4- +AD4- +-+AH0-
+AD4- +AD4- +-
+AD4- +AD4-   static int
+AD4- +AD4-   vhost+AF8-user+AF8-set+AF8-mem+AF8-table(struct virtio+AF8-ne=
t +ACoAKg-pdev,
+AD4- +AD4-                     struct vhu+AF8-msg+AF8-context +ACo-ctx,
+AD4- +AD4- +AEAAQA- -1393,7 +-1452,6 +AEAAQA- vhost+AF8-user+AF8-set+AF8-m=
em+AF8-table(struct virtio+AF8-net
+AD4- +ACoAKg-pdev,
+AD4- +AD4-     struct virtio+AF8-net +ACo-dev +AD0- +ACo-pdev+ADs-
+AD4- +AD4-     struct VhostUserMemory +ACo-memory +AD0- +ACY-ctx-+AD4-msg.=
payload.memory+ADs-
+AD4- +AD4-     struct rte+AF8-vhost+AF8-mem+AF8-region +ACo-reg+ADs-
+AD4- +AD4- -   int numa+AF8-node +AD0- SOCKET+AF8-ID+AF8-ANY+ADs-
+AD4- +AD4-     uint64+AF8-t mmap+AF8-offset+ADs-
+AD4- +AD4-     uint32+AF8-t i+ADs-
+AD4- +AD4-     bool async+AF8-notify +AD0- false+ADs-
+AD4- +AD4- +AEAAQA- -1438,39 +-1496,13 +AEAAQA- vhost+AF8-user+AF8-set+AF8=
-mem+AF8-table(struct virtio+AF8-net
+AD4- +ACoAKg-pdev,
+AD4- +AD4-             if (dev-+AD4-features +ACY- (1ULL +ADwAPA- VIRTIO+A=
F8-F+AF8-IOMMU+AF8-PLATFORM))
+AD4- +AD4-                     vhost+AF8-user+AF8-iotlb+AF8-flush+AF8-all(=
dev)+ADs-
+AD4- +AD4-
+AD4- +AD4- -           free+AF8-mem+AF8-region(dev)+ADs-
+AD4- +AD4- +-           free+AF8-all+AF8-mem+AF8-regions(dev)+ADs-
+AD4- +AD4-             rte+AF8-free(dev-+AD4-mem)+ADs-
+AD4- +AD4-             dev-+AD4-mem +AD0- NULL+ADs-
+AD4- +AD4-     +AH0-
+AD4- +AD4-
+AD4- +AD4- -   /+ACo-
+AD4- +AD4- -    +ACo- If VQ 0 has already been allocated, try to allocate =
on the same
+AD4- +AD4- -    +ACo- NUMA node. It can be reallocated later in numa+AF8-r=
ealloc().
+AD4- +AD4- -    +ACo-/
+AD4- +AD4- -   if (dev-+AD4-nr+AF8-vring +AD4- 0)
+AD4- +AD4- -           numa+AF8-node +AD0- dev-+AD4-virtqueue+AFs-0+AF0--+=
AD4-numa+AF8-node+ADs-
+AD4- +AD4- -
+AD4- +AD4- -   dev-+AD4-nr+AF8-guest+AF8-pages +AD0- 0+ADs-
+AD4- +AD4- -   if (dev-+AD4-guest+AF8-pages +AD0APQ- NULL) +AHs-
+AD4- +AD4- -           dev-+AD4-max+AF8-guest+AF8-pages +AD0- 8+ADs-
+AD4- +AD4- -           dev-+AD4-guest+AF8-pages +AD0- rte+AF8-zmalloc+AF8-=
socket(NULL,
+AD4- +AD4- -                                   dev-+AD4-max+AF8-guest+AF8-=
pages +ACo-
+AD4- +AD4- -                                   sizeof(struct guest+AF8-pag=
e),
+AD4- +AD4- -                                   RTE+AF8-CACHE+AF8-LINE+AF8-=
SIZE,
+AD4- +AD4- -                                   numa+AF8-node)+ADs-
+AD4- +AD4- -           if (dev-+AD4-guest+AF8-pages +AD0APQ- NULL) +AHs-
+AD4- +AD4- -                   VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, E=
RR,
+AD4- +AD4- -                           +ACI-failed to allocate memory for =
dev-
+AD4- +AD4-guest+AF8-pages+ACI-)+ADs-
+AD4- +AD4- -                   goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- -           +AH0-
+AD4- +AD4- -   +AH0-
+AD4- +AD4- -
+AD4- +AD4- -   dev-+AD4-mem +AD0- rte+AF8-zmalloc+AF8-socket(+ACI-vhost-me=
m-table+ACI-, sizeof(struct
+AD4- rte+AF8-vhost+AF8-memory) +-
+AD4- +AD4- -           sizeof(struct rte+AF8-vhost+AF8-mem+AF8-region) +AC=
o- memory-+AD4-nregions, 0,
+AD4- numa+AF8-node)+ADs-
+AD4- +AD4- -   if (dev-+AD4-mem +AD0APQ- NULL) +AHs-
+AD4- +AD4- -           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR, +ACI=
-failed to allocate
+AD4- memory for dev-+AD4-mem+ACI-)+ADs-
+AD4- +AD4- -           goto free+AF8-guest+AF8-pages+ADs-
+AD4- +AD4- -   +AH0-
+AD4- +AD4- +-   if (vhost+AF8-user+AF8-initialize+AF8-memory(pdev) +ADw- 0=
)
+AD4- +AD4- +-           goto close+AF8-msg+AF8-fds+ADs-
+AD4-
+AD4- This part should be refactored into a dedicated preliminary patch.
The original patch has been divided into multiple patches.
+AD4-
+AD4- +AD4-
+AD4- +AD4-     for (i +AD0- 0+ADs- i +ADw- memory-+AD4-nregions+ADs- i+-+-=
) +AHs-
+AD4- +AD4-             reg +AD0- +ACY-dev-+AD4-mem-+AD4-regions+AFs-i+AF0A=
Ow-
+AD4- +AD4- +AEAAQA- -1534,11 +-1566,182 +AEAAQA- vhost+AF8-user+AF8-set+AF=
8-mem+AF8-table(struct virtio+AF8-net
+AD4- +ACoAKg-pdev,
+AD4- +AD4-     return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-OK+ADs-
+AD4- +AD4-
+AD4- +AD4-   free+AF8-mem+AF8-table:
+AD4- +AD4- -   free+AF8-mem+AF8-region(dev)+ADs-
+AD4- +AD4- +-   free+AF8-all+AF8-mem+AF8-regions(dev)+ADs-
+AD4- +AD4-     rte+AF8-free(dev-+AD4-mem)+ADs-
+AD4- +AD4-     dev-+AD4-mem +AD0- NULL+ADs-
+AD4- +AD4- +-   rte+AF8-free(dev-+AD4-guest+AF8-pages)+ADs-
+AD4- +AD4- +-   dev-+AD4-guest+AF8-pages +AD0- NULL+ADs-
+AD4- +AD4- +-close+AF8-msg+AF8-fds:
+AD4- +AD4- +-   close+AF8-msg+AF8-fds(ctx)+ADs-
+AD4- +AD4- +-   return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-ERR+ADs-
+AD4- +AD4- +-+AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-
+AD4- +AD4- +-static int
+AD4- +AD4- +-vhost+AF8-user+AF8-get+AF8-max+AF8-mem+AF8-slots(struct virti=
o+AF8-net +ACoAKg-pdev +AF8AXw-rte+AF8-unused,
+AD4- +AD4- +-                   struct vhu+AF8-msg+AF8-context +ACo-ctx,
+AD4- +AD4- +-                   int main+AF8-fd +AF8AXw-rte+AF8-unused)
+AD4- +AD4- +-+AHs-
+AD4- +AD4- +-   uint32+AF8-t max+AF8-mem+AF8-slots +AD0- VHOST+AF8-MEMORY+=
AF8-MAX+AF8-NREGIONS+ADs-
+AD4-
+AD4- This VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS value was hardcoded when o=
nly
+AD4- VHOST+AF8-USER+AF8-SET+AF8-MEM+AF8-TABLE was introduced.
+AD4-
+AD4- With this new features, my understanding is that we can get rid off t=
his limit,
+AD4- right?
+AD4-
+AD4- The good news is increasing it should not break the DPDK ABI.
+AD4-
+AD4- Would it make sense to increase it?
I have increased the VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS to 128 and teste=
d with qemu, talking to vhost testpmd and adding/removing 128 memory region=
s.

+AD4- +AD4- +-
+AD4- +AD4- +-   ctx-+AD4-msg.payload.u64 +AD0- (uint64+AF8-t)max+AF8-mem+A=
F8-slots+ADs-
+AD4- +AD4- +-   ctx-+AD4-msg.size +AD0- sizeof(ctx-+AD4-msg.payload.u64)+A=
Ds-
+AD4- +AD4- +-   ctx-+AD4-fd+AF8-num +AD0- 0+ADs-
+AD4- +AD4-
+AD4- +AD4- -free+AF8-guest+AF8-pages:
+AD4- +AD4- +-   return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-REPLY+ADs-
+AD4- +AD4- +-+AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-static int
+AD4- +AD4- +-vhost+AF8-user+AF8-add+AF8-mem+AF8-reg(struct virtio+AF8-net =
+ACoAKg-pdev,
+AD4- +AD4- +-                   struct vhu+AF8-msg+AF8-context +ACo-ctx,
+AD4- +AD4- +-                   int main+AF8-fd +AF8AXw-rte+AF8-unused)
+AD4- +AD4- +-+AHs-
+AD4- +AD4- +-   struct virtio+AF8-net +ACo-dev +AD0- +ACo-pdev+ADs-
+AD4- +AD4- +-   struct VhostUserMemoryRegion +ACo-region +AD0- +ACY-ctx-
+AD4- +AD4-msg.payload.memory+AF8-single.region+ADs-
+AD4- +AD4- +-   uint32+AF8-t i+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   /+ACo- make sure new region will fit +ACo-/
+AD4- +AD4- +-   if (dev-+AD4-mem +ACEAPQ- NULL +ACYAJg- dev-+AD4-mem-+AD4-=
nregions +AD4APQ-
+AD4- VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS) +AHs-
+AD4- +AD4- +-           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR,
+AD4- +AD4- +-                   +ACI-too many memory regions already (+ACU=
-u)+ACI-,
+AD4- +AD4- +-                   dev-+AD4-mem-+AD4-nregions)+ADs-
+AD4- +AD4- +-           goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   /+ACo- make sure supplied memory fd present +ACo-/
+AD4- +AD4- +-   if (ctx-+AD4-fd+AF8-num +ACEAPQ- 1) +AHs-
+AD4- +AD4- +-           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR,
+AD4- +AD4- +-                   +ACI-fd count makes no sense (+ACU-u)+ACI-=
,
+AD4- +AD4- +-                   ctx-+AD4-fd+AF8-num)+ADs-
+AD4- +AD4- +-           goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +-   +AH0-
+AD4-
+AD4- There is a lack of support for vDPA devices.
+AD4- My understanding here is that the vDPA device does not get the new ta=
ble
+AD4- entry.
+AD4-
+AD4- In set+AF8-mem+AF8-table, we call its close callback, but that might =
be a bit too much
+AD4- for simple memory hotplug. we might need another mechanism.
Could you please suggest the other mechanism ?

+AD4-
+AD4- +AD4- +-
+AD4- +AD4- +-   /+ACo- Make sure no overlap in guest virtual address space=
 +ACo-/
+AD4- +AD4- +-   if (dev-+AD4-mem +ACEAPQ- NULL +ACYAJg- dev-+AD4-mem-+AD4-=
nregions +AD4- 0) +AHs-
+AD4- +AD4- +-           for (uint32+AF8-t i +AD0- 0+ADs- i +ADw- VHOST+AF8=
-MEMORY+AF8-MAX+AF8-NREGIONS+ADs- i+-+-)
+AD4- +AHs-
+AD4- +AD4- +-                   struct rte+AF8-vhost+AF8-mem+AF8-region +A=
Co-current+AF8-region +AD0-
+AD4- +AD4- +-+ACY-dev-+AD4-mem-+AD4-regions+AFs-i+AF0AOw-
+AD4- +AD4- +-
+AD4- +AD4- +-                   if (current+AF8-region-+AD4-mmap+AF8-size =
+AD0APQ- 0)
+AD4- +AD4- +-                           continue+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-                   uint64+AF8-t current+AF8-region+AF8-guest+=
AF8-start +AD0- current+AF8-region-
+AD4- +AD4-guest+AF8-user+AF8-addr+ADs-
+AD4- +AD4- +-                   uint64+AF8-t current+AF8-region+AF8-guest+=
AF8-end +AD0-
+AD4- current+AF8-region+AF8-guest+AF8-start
+AD4- +AD4- +-                                                           +-
+AD4- current+AF8-region-+AD4-mmap+AF8-size - 1+ADs-
+AD4-
+AD4- Shouldn't it use size instead of mmap+AF8-size to check for overlaps?
+AD4-
+AD4- +AD4- +-                   uint64+AF8-t proposed+AF8-region+AF8-guest=
+AF8-start +AD0- region-
+AD4- +AD4-userspace+AF8-addr+ADs-
+AD4- +AD4- +-                   uint64+AF8-t proposed+AF8-region+AF8-guest=
+AF8-end +AD0-
+AD4- proposed+AF8-region+AF8-guest+AF8-start
+AD4- +AD4- +-                                                           +-=
 region-
+AD4- +AD4-memory+AF8-size - 1+ADs-
+AD4- +AD4- +-                   bool overlap +AD0- false+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-                   bool current+AF8-region+AF8-guest+AF8-star=
t+AF8-overlap +AD0-
+AD4- +AD4- +-                           current+AF8-region+AF8-guest+AF8-s=
tart +AD4APQ-
+AD4- proposed+AF8-region+AF8-guest+AF8-start
+AD4- +AD4- +-                           +ACYAJg- current+AF8-region+AF8-gu=
est+AF8-start +ADwAPQ-
+AD4- proposed+AF8-region+AF8-guest+AF8-end+ADs-
+AD4- +AD4- +-                   bool current+AF8-region+AF8-guest+AF8-end+=
AF8-overlap +AD0-
+AD4- +AD4- +-                           current+AF8-region+AF8-guest+AF8-e=
nd +AD4APQ-
+AD4- proposed+AF8-region+AF8-guest+AF8-start
+AD4- +AD4- +-                           +ACYAJg- current+AF8-region+AF8-gu=
est+AF8-end +ADwAPQ-
+AD4- proposed+AF8-region+AF8-guest+AF8-end+ADs-
+AD4- +AD4- +-                   bool proposed+AF8-region+AF8-guest+AF8-sta=
rt+AF8-overlap +AD0-
+AD4- +AD4- +-                           proposed+AF8-region+AF8-guest+AF8-=
start +AD4APQ-
+AD4- current+AF8-region+AF8-guest+AF8-start
+AD4- +AD4- +-                           +ACYAJg- proposed+AF8-region+AF8-g=
uest+AF8-start +ADwAPQ-
+AD4- current+AF8-region+AF8-guest+AF8-end+ADs-
+AD4- +AD4- +-                   bool proposed+AF8-region+AF8-guest+AF8-end=
+AF8-overlap +AD0-
+AD4- +AD4- +-                           proposed+AF8-region+AF8-guest+AF8-=
end +AD4APQ-
+AD4- current+AF8-region+AF8-guest+AF8-start
+AD4- +AD4- +-                           +ACYAJg- proposed+AF8-region+AF8-g=
uest+AF8-end +ADwAPQ-
+AD4- current+AF8-region+AF8-guest+AF8-end+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-                   overlap +AD0- current+AF8-region+AF8-guest=
+AF8-start+AF8-overlap
+AD4- +AD4- +-                           +AHwAfA- current+AF8-region+AF8-gu=
est+AF8-end+AF8-overlap
+AD4- +AD4- +-                           +AHwAfA- proposed+AF8-region+AF8-g=
uest+AF8-start+AF8-overlap
+AD4- +AD4- +-                           +AHwAfA- proposed+AF8-region+AF8-g=
uest+AF8-end+AF8-overlap+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-                   if (overlap) +AHs-
+AD4- +AD4- +-                           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-=
ifname, ERR,
+AD4- +AD4- +-                                   +ACI-requested memory regi=
on overlaps
+AD4- with another region+ACI-)+ADs-
+AD4- +AD4- +-                           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-=
ifname, ERR,
+AD4- +AD4- +-                                   +ACIAXA-tRequested region =
address:0x+ACUAIg-
+AD4- PRIx64,
+AD4- +AD4- +-                                   region-+AD4-userspace+AF8-=
addr)+ADs-
+AD4- +AD4- +-                           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-=
ifname, ERR,
+AD4- +AD4- +-                                   +ACIAXA-tRequested region =
size:0x+ACUAIg- PRIx64,
+AD4- +AD4- +-                                   region-+AD4-memory+AF8-siz=
e)+ADs-
+AD4- +AD4- +-                           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-=
ifname, ERR,
+AD4- +AD4- +-                                   +ACIAXA-tOverlapping regio=
n address:0x+ACUAIg-
+AD4- PRIx64,
+AD4- +AD4- +-                                   current+AF8-region-+AD4-gu=
est+AF8-user+AF8-addr)+ADs-
+AD4- +AD4- +-                           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-=
ifname, ERR,
+AD4- +AD4- +-                                   +ACIAXA-tOverlapping regio=
n size:0x+ACUAIg-
+AD4- PRIx64,
+AD4- +AD4- +-                                   current+AF8-region-+AD4-mm=
ap+AF8-size)+ADs-
+AD4- +AD4- +-                           goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +-                   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-           +AH0-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   /+ACo- convert first region add to normal memory table set=
 +ACo-/
+AD4- +AD4- +-   if (dev-+AD4-mem +AD0APQ- NULL) +AHs-
+AD4- +AD4- +-           if (vhost+AF8-user+AF8-initialize+AF8-memory(pdev)=
 +ADw- 0)
+AD4- +AD4- +-                   goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   /+ACo- find a new region and set it like memory table set =
does +ACo-/
+AD4- +AD4- +-   struct rte+AF8-vhost+AF8-mem+AF8-region +ACo-reg +AD0- NUL=
L+ADs-
+AD4- +AD4- +-   uint64+AF8-t mmap+AF8-offset+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   for (uint32+AF8-t i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMORY+=
AF8-MAX+AF8-NREGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4- +-           if (dev-+AD4-mem-+AD4-regions+AFs-i+AF0-.guest+AF8=
-user+AF8-addr +AD0APQ- 0) +AHs-
+AD4- +AD4- +-                   reg +AD0- +ACY-dev-+AD4-mem-+AD4-regions+A=
Fs-i+AF0AOw-
+AD4- +AD4- +-                   break+ADs-
+AD4- +AD4- +-           +AH0-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-   if (reg +AD0APQ- NULL) +AHs-
+AD4- +AD4- +-           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR, +AC=
I-no free memory
+AD4- region+ACI-)+ADs-
+AD4- +AD4- +-           goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   reg-+AD4-guest+AF8-phys+AF8-addr +AD0- region-+AD4-guest+A=
F8-phys+AF8-addr+ADs-
+AD4- +AD4- +-   reg-+AD4-guest+AF8-user+AF8-addr +AD0- region-+AD4-userspa=
ce+AF8-addr+ADs-
+AD4- +AD4- +-   reg-+AD4-size            +AD0- region-+AD4-memory+AF8-size=
+ADs-
+AD4- +AD4- +-   reg-+AD4-fd              +AD0- ctx-+AD4-fds+AFs-0+AF0AOw-
+AD4- +AD4- +-
+AD4- +AD4- +-   mmap+AF8-offset +AD0- region-+AD4-mmap+AF8-offset+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   if (vhost+AF8-user+AF8-mmap+AF8-region(dev, reg, mmap+AF8-=
offset) +ADw- 0) +AHs-
+AD4- +AD4- +-           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR, +AC=
I-failed to mmap
+AD4- region+ACI-)+ADs-
+AD4- +AD4- +-           goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   dev-+AD4-mem-+AD4-nregions+-+-+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   if (dev-+AD4-async+AF8-copy +ACYAJg- rte+AF8-vfio+AF8-is+A=
F8-enabled(+ACI-vfio+ACI-))
+AD4- +AD4- +-           async+AF8-dma+AF8-map(dev, true)+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   if (vhost+AF8-user+AF8-postcopy+AF8-register(dev, main+AF8=
-fd, ctx) +ADw- 0)
+AD4- +AD4- +-           goto free+AF8-mem+AF8-table+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   for (i +AD0- 0+ADs- i +ADw- dev-+AD4-nr+AF8-vring+ADs- i+-=
+-) +AHs-
+AD4- +AD4- +-           struct vhost+AF8-virtqueue +ACo-vq +AD0- dev-+AD4-=
virtqueue+AFs-i+AF0AOw-
+AD4- +AD4- +-
+AD4- +AD4- +-           if (+ACE-vq)
+AD4- +AD4- +-                   continue+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-           if (vq-+AD4-desc +AHwAfA- vq-+AD4-avail +AHwAfA- v=
q-+AD4-used) +AHs-
+AD4- +AD4- +-                   /+ACo- vhost+AF8-user+AF8-lock+AF8-all+AF8=
-queue+AF8-pairs locked all qps +ACo-/
+AD4- +AD4- +-                   VHOST+AF8-USER+AF8-ASSERT+AF8-LOCK(dev, vq=
,
+AD4- VHOST+AF8-USER+AF8-SET+AF8-MEM+AF8-TABLE)+ADs-
+AD4-
+AD4- VHOST+AF8-USER+AF8-ASSERT+AF8-LOCK(dev, vq, VHOST+AF8-USER+AF8-ADD+AF=
8-MEM+AF8-REG)+ADs- ?
+AD4-
+AD4- +AD4- +-
+AD4- +AD4- +-                   /+ACo-
+AD4- +AD4- +-                    +ACo- If the memory table got updated, th=
e ring addresses
+AD4- +AD4- +-                    +ACo- need to be translated again as virt=
ual addresses have
+AD4- +AD4- +-                    +ACo- changed.
+AD4- +AD4- +-                    +ACo-/
+AD4- +AD4- +-                   vring+AF8-invalidate(dev, vq)+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-                   translate+AF8-ring+AF8-addresses(+ACY-dev,=
 +ACY-vq)+ADs-
+AD4- +AD4- +-                   +ACo-pdev +AD0- dev+ADs-
+AD4- +AD4- +-           +AH0-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   dump+AF8-guest+AF8-pages(dev)+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-OK+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-free+AF8-mem+AF8-table:
+AD4- +AD4- +-   free+AF8-all+AF8-mem+AF8-regions(dev)+ADs-
+AD4- +AD4- +-   rte+AF8-free(dev-+AD4-mem)+ADs-
+AD4- +AD4- +-   dev-+AD4-mem +AD0- NULL+ADs-
+AD4- +AD4-     rte+AF8-free(dev-+AD4-guest+AF8-pages)+ADs-
+AD4- +AD4-     dev-+AD4-guest+AF8-pages +AD0- NULL+ADs-
+AD4- +AD4-   close+AF8-msg+AF8-fds:
+AD4- +AD4- +AEAAQA- -1546,6 +-1749,40 +AEAAQA- vhost+AF8-user+AF8-set+AF8-=
mem+AF8-table(struct virtio+AF8-net
+AD4- +ACoAKg-pdev,
+AD4- +AD4-     return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-ERR+ADs-
+AD4- +AD4-   +AH0-
+AD4- +AD4-
+AD4- +AD4- +-static int
+AD4- +AD4- +-vhost+AF8-user+AF8-rem+AF8-mem+AF8-reg(struct virtio+AF8-net =
+ACoAKg-pdev +AF8AXw-rte+AF8-unused,
+AD4- +AD4- +-                   struct vhu+AF8-msg+AF8-context +ACo-ctx +A=
F8AXw-rte+AF8-unused,
+AD4- +AD4- +-                   int main+AF8-fd +AF8AXw-rte+AF8-unused)
+AD4- +AD4- +-+AHs-
+AD4- +AD4- +-   struct virtio+AF8-net +ACo-dev +AD0- +ACo-pdev+ADs-
+AD4- +AD4- +-   struct VhostUserMemoryRegion +ACo-region +AD0-
+AD4- +AD4- +-+ACY-ctx-+AD4-msg.payload.memory+AF8-single.region+ADs-
+AD4- +AD4- +-
+AD4-
+AD4- It lacks support for vDPA devices.
+AD4- In set+AF8-mem+AF8-table, we call the vDPA close cb to ensure it is n=
ot actively
+AD4- accessing memoring being unmapped.
+AD4-
+AD4- We need something similar here, otherwise the vDPA device is not awar=
e of the
+AD4- memory being unplugged.

I have incorporated this change in the latest patch-set.

+AD4-
+AD4- +AD4- +-   if (dev-+AD4-mem +ACEAPQ- NULL +ACYAJg- dev-+AD4-mem-+AD4-=
nregions +AD4- 0) +AHs-
+AD4- +AD4- +-           for (uint32+AF8-t i +AD0- 0+ADs- i +ADw- VHOST+AF8=
-MEMORY+AF8-MAX+AF8-NREGIONS+ADs- i+-+-)
+AD4- +AHs-
+AD4- +AD4- +-                   struct rte+AF8-vhost+AF8-mem+AF8-region +A=
Co-current+AF8-region +AD0-
+AD4- +AD4- +-+ACY-dev-+AD4-mem-+AD4-regions+AFs-i+AF0AOw-
+AD4- +AD4- +-
+AD4- +AD4- +-                   if (current+AF8-region-+AD4-guest+AF8-user=
+AF8-addr +AD0APQ- 0)
+AD4- +AD4- +-                           continue+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-                   /+ACo-
+AD4- +AD4- +-                    +ACo- According to the vhost-user specifi=
cation:
+AD4- +AD4- +-                    +ACo- The memory region to be removed is =
identified by
+AD4- its guest address,
+AD4- +AD4- +-                    +ACo- user address and size. The mmap off=
set is ignored.
+AD4- +AD4- +-                    +ACo-/
+AD4- +AD4- +-                   if (region-+AD4-userspace+AF8-addr +AD0APQ=
- current+AF8-region-
+AD4- +AD4-guest+AF8-user+AF8-addr
+AD4- +AD4- +-                           +ACYAJg- region-+AD4-guest+AF8-phy=
s+AF8-addr +AD0APQ-
+AD4- current+AF8-region-+AD4-guest+AF8-phys+AF8-addr
+AD4- +AD4- +-                           +ACYAJg- region-+AD4-memory+AF8-si=
ze +AD0APQ- current+AF8-region-
+AD4- +AD4-size) +AHs-
+AD4- +AD4- +-                           free+AF8-mem+AF8-region(current+AF=
8-region)+ADs-
+AD4- +AD4- +-                           dev-+AD4-mem-+AD4-nregions--+ADs-
+AD4- +AD4- +-                           return RTE+AF8-VHOST+AF8-MSG+AF8-R=
ESULT+AF8-OK+ADs-
+AD4- +AD4- +-                   +AH0-
+AD4-
+AD4- There is a lack of IOTLB entries invalidation here, as IOTLB entries =
in the cache
+AD4- could point to memory being unmapped in this function.
+AD4-
+AD4- Same comment for vring invalidation, as the vring adresses are not re=
-
+AD4- translated at each burst.
I will incorporate in the next version.
+AD4-
+AD4- +AD4- +-           +AH0-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR, +ACI-failed=
 to find region+ACI-)+ADs-
+AD4- +AD4- +-   return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-ERR+ADs-
+AD4- +AD4- +-+AH0-
+AD4- +AD4- +-
+AD4- +AD4-   static bool
+AD4- +AD4-   vq+AF8-is+AF8-ready(struct virtio+AF8-net +ACo-dev, struct vh=
ost+AF8-virtqueue +ACo-vq)
+AD4- +AD4-   +AHs-
+AD4- +AD4- diff --git a/lib/vhost/vhost+AF8-user.h b/lib/vhost/vhost+AF8-u=
ser.h index
+AD4- +AD4- ef486545ba..5a0e747b58 100644
+AD4- +AD4- --- a/lib/vhost/vhost+AF8-user.h
+AD4- +AD4- +-+-+- b/lib/vhost/vhost+AF8-user.h
+AD4- +AD4- +AEAAQA- -32,6 +-32,7 +AEAAQA-
+AD4- +AD4-                                      (1ULL +ADwAPA-
+AD4- VHOST+AF8-USER+AF8-PROTOCOL+AF8-F+AF8-BACKEND+AF8-SEND+AF8-FD) +AHw- =
+AFw-
+AD4- +AD4-                                      (1ULL +ADwAPA-
+AD4- VHOST+AF8-USER+AF8-PROTOCOL+AF8-F+AF8-HOST+AF8-NOTIFIER) +AHw- +AFw-
+AD4- +AD4-                                      (1ULL +ADwAPA-
+AD4- VHOST+AF8-USER+AF8-PROTOCOL+AF8-F+AF8-PAGEFAULT) +AHw- +AFw-
+AD4- +AD4- +-                                    (1ULL +ADwAPA-
+AD4- VHOST+AF8-USER+AF8-PROTOCOL+AF8-F+AF8-CONFIGURE+AF8-MEM+AF8-SLOTS) +A=
Hw- +AFw-
+AD4- +AD4-                                      (1ULL +ADwAPA-
+AD4- VHOST+AF8-USER+AF8-PROTOCOL+AF8-F+AF8-STATUS))
+AD4- +AD4-
+AD4- +AD4-   typedef enum VhostUserRequest +AHs-
+AD4- +AD4- +AEAAQA- -67,6 +-68,9 +AEAAQA- typedef enum VhostUserRequest +A=
Hs-
+AD4- +AD4-     VHOST+AF8-USER+AF8-POSTCOPY+AF8-END +AD0- 30,
+AD4- +AD4-     VHOST+AF8-USER+AF8-GET+AF8-INFLIGHT+AF8-FD +AD0- 31,
+AD4- +AD4-     VHOST+AF8-USER+AF8-SET+AF8-INFLIGHT+AF8-FD +AD0- 32,
+AD4- +AD4- +-   VHOST+AF8-USER+AF8-GET+AF8-MAX+AF8-MEM+AF8-SLOTS +AD0- 36,
+AD4- +AD4- +-   VHOST+AF8-USER+AF8-ADD+AF8-MEM+AF8-REG +AD0- 37,
+AD4- +AD4- +-   VHOST+AF8-USER+AF8-REM+AF8-MEM+AF8-REG +AD0- 38,
+AD4- +AD4-     VHOST+AF8-USER+AF8-SET+AF8-STATUS +AD0- 39,
+AD4- +AD4-     VHOST+AF8-USER+AF8-GET+AF8-STATUS +AD0- 40,
+AD4- +AD4-   +AH0- VhostUserRequest+ADs-
+AD4- +AD4- +AEAAQA- -91,6 +-95,11 +AEAAQA- typedef struct VhostUserMemory =
+AHs-
+AD4- +AD4-     VhostUserMemoryRegion
+AD4- regions+AFs-VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS+AF0AOw-
+AD4- +AD4-   +AH0- VhostUserMemory+ADs-
+AD4- +AD4-
+AD4- +AD4- +-typedef struct VhostUserSingleMemReg +AHs-
+AD4- +AD4- +-   uint64+AF8-t padding+ADs-
+AD4- +AD4- +-   VhostUserMemoryRegion region+ADs-
+AD4- +AD4- +-+AH0- VhostUserSingleMemReg+ADs-
+AD4- +AD4- +-
+AD4- +AD4-   typedef struct VhostUserLog +AHs-
+AD4- +AD4-     uint64+AF8-t mmap+AF8-size+ADs-
+AD4- +AD4-     uint64+AF8-t mmap+AF8-offset+ADs-
+AD4- +AD4- +AEAAQA- -186,6 +-195,7 +AEAAQA- typedef struct +AF8AXw-rte+AF8=
-packed+AF8-begin VhostUserMsg +AHs-
+AD4- +AD4-             struct vhost+AF8-vring+AF8-state state+ADs-
+AD4- +AD4-             struct vhost+AF8-vring+AF8-addr addr+ADs-
+AD4- +AD4-             VhostUserMemory memory+ADs-
+AD4- +AD4- +-           VhostUserSingleMemReg memory+AF8-single+ADs-
+AD4- +AD4-             VhostUserLog    log+ADs-
+AD4- +AD4-             struct vhost+AF8-iotlb+AF8-msg iotlb+ADs-
+AD4- +AD4-             VhostUserCryptoSessionParam crypto+AF8-session+ADs-

