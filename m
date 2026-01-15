Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C777D3CC9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 08:07:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BB8140A6F;
	Thu, 15 Jan 2026 09:07:00 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 573104003C
 for <dev@dpdk.org>; Thu, 15 Jan 2026 09:06:58 +0100 (CET)
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60F6Lo1N020708;
 Thu, 15 Jan 2026 03:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=s
 6TOjpLf4KJbFxkbjkiem3VPVHKFhbmufQMvj0r8xV8=; b=vX/3173yZqBm/wGW4
 B//RTFPB5Wlmn4dX4IAiH61+1gs65p4aBnIAuSQZbyzpg370Iq1iOjwoOeMyZF9A
 rAQnXnMRW8kKY7KtdbkBPC7GO3U8dB7/uOyBZt22dsgkIdJ6aUxT2k4VF43LwpBA
 mvfjA05v+vOcmwc6ZGpxIUKOhLVarc39W0B40hrnvcwZqGvGZppcu3RnOTYUP9Qj
 sE6IJP9Q2cP41+nUe4mb6oWnydufEvxAP/umyLlft11XZQQ57m5V/2Erl8u2pEmb
 zlhKWqb6e5B7vL3NAh20I7zGqnFGud2vUSf/xph6MOnT0dWjAsqtHjJq0p4//Y1e
 CC4ww==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4bkj74mwg7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Jan 2026 03:06:57 -0500 (EST)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60F5ohEj008886;
 Thu, 15 Jan 2026 03:06:56 -0500
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012038.outbound.protection.outlook.com
 [40.107.200.38])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4bptedsaj7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jan 2026 03:06:55 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTANyZFfAsy6xttbfFEKogFbuNCuh9OhqTwN8eyLMxcymHP+r+Gn3EqJLufUwZoQ33aKCNca0gl6Mb29zXUmEK2qzN4nK0ubjVauhwT1HPGvL7xv/YzdQIguW40ij9U6aV3RlWm2ndrABRjhBa4kGT0NNZduNVvShED9/c0gbSAUpFf2H4ZcwNHee65Ys1XECU0xdDLZfIBfy4e+bmCDLICCHdNerq++1AX3p4Kac2a/oVKcbtqjF+YizYYHrhT205BGu2AjVbEEiV7aeja1036cfQpz/RbAAVfJHhzJPLqLYaLmMtwhRlEt6oWtXFDRuD+gxjC8PTczCzO/t5K7ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6TOjpLf4KJbFxkbjkiem3VPVHKFhbmufQMvj0r8xV8=;
 b=Vhf4iYkRA+dyHnTrA0lR86e8uU2N4j2pXY9X/chM0WuKj7Wxs2KCaTaHRtwZn0lg1piA4vf/RrLLfVbfDUmYLu2vb8ECj75vVEw3EFcfxZxDGw5eVGNxt0osHNus+adB/ISoqU7+lHbErdbDm8J5yNy0XQn9mTc46bb8ytcaojrcWS+Gp54uRQlg1S2okq+59fdNKKlTGMvGSff2kPECLM4lykie4Dzou9hLccFoI1iJpj86U1ZUmnhTxfI86G8kUXDJQvKdemLcnNm1vJiB7BzpocQ1k/FrjXc9xVD4X7mBRjcbsKYHbqpSVhsSdGHlqJKM0huAnxbNPGQ5S3KKdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by IA1PR19MB7709.namprd19.prod.outlook.com (2603:10b6:208:3d8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 08:06:52 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 08:06:52 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "pravin.m.bathija.dev@gmail.com" <pravin.m.bathija.dev@gmail.com>
Subject: RE: [PATCH v5 4/4] vhost_user: Function defs for add/rem mem regions
Thread-Topic: [PATCH v5 4/4] vhost_user: Function defs for add/rem mem regions
Thread-Index: AQHcVJtQVTOuvjwlfU2rG2sxc6dmhLVFrAgAgA2WElA=
Date: Thu, 15 Jan 2026 08:06:52 +0000
Message-ID: <SJ0PR19MB4606CDEB37E0ED2E3D7D0D35F58CA@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <20251113124425.2913881-1-pravin.bathija@dell.com>
 <20251113124425.2913881-5-pravin.bathija@dell.com>
 <0b163dd2-a981-4927-921a-fe4861c2bc13@redhat.com>
In-Reply-To: <0b163dd2-a981-4927-921a-fe4861c2bc13@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-01-15T08:05:05.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|IA1PR19MB7709:EE_
x-ms-office365-filtering-correlation-id: 4b40fb93-8ed6-45f0-2392-08de540d0ac2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|786006|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-7?B?Tlk1Ky1KTkNLS1hpRVBBd1ZzejNBdUw4ekRoUWFHMzVYY1NmamdQdXpoeVVr?=
 =?utf-7?B?S29Gd1h5dU13ZUpDdEZBVSstajA5UzlqYndaWWplV01wN0xLSFE1Y3FyMFNk?=
 =?utf-7?B?bjNCS3IwNWg5NEVtc2dRdXFma1FLMXZ1Ky1pV0RiNistcmRKR3hCdGxwc2hH?=
 =?utf-7?B?VDVyNHY0a1pvLzNDcjhzcUIyMlhkZGYrLVc2MHU1aGJORW1Fd1NPSkp5OGdn?=
 =?utf-7?B?aGN2bkNDM2NndU1XVTlhcnE4YWZaM0JreEVTQ2xLbERnNUtzVS9xNW4xY0N2?=
 =?utf-7?B?MFVrYzBvQ0pXOXVnWXdOcHhGdjdRV2JDdzZNZHF0ZzRMcFZRcnJzb3pKeFMz?=
 =?utf-7?B?VFJ2QUgyYW14OTNsa2RSRTdUZjc4dVI0MDZvcXhRWE5UajVKNldQY3ltVmVs?=
 =?utf-7?B?NGQ1YnY3Y040RHFoLzZuZ3Nxb05yR2NvM1lZQkpkMWd6UXA3T0FDQzRpSlFO?=
 =?utf-7?B?M1dWa3hKY1JKUlBrQWtPU3BZNjh5cTFjYU1EQWdKckJ0SWN3aFNsU3NyOGR6?=
 =?utf-7?B?TistN3RuWkZ6QmMwell4YmtYNGxYOGVzS1RLYlpOZFozTWYrLUpDRXI3WUg0?=
 =?utf-7?B?S2R3NjVUS1RqUXpGZXlGUVJubE44b2lLZ3cwN2l5ay9FNjQ1cGJzRGVQazJQ?=
 =?utf-7?B?L1MzL2J0WGdrNG9ZaHVOTmZPODNEWlJYUDZiQjByZEJqUkNwajZZUm1UN0ZF?=
 =?utf-7?B?R2NNYUwwdzNXV0IwZUxSZktnT3hxdFJZbHFuV0cydjhNYzNBWG1xSWNnYVFU?=
 =?utf-7?B?Qno3V3BLR0doc0JxVGJiS3dMdUtuaTVRZFAxeENqSkV5RGtnQmpOUjVpRXg=?=
 =?utf-7?B?Ky1JKy1LKy1BcWZLZ2NQSERSa3BaVXFzdXV5aCstSUtEWHo3M1JOTGJxWUVW?=
 =?utf-7?B?SDgzNTZDRXpUckk2bnFmS3NDYkkzL3ZRelFSV3kzMzA5czlXaDY1V2RvSXl5?=
 =?utf-7?B?Y2VGbTl5a01BMUdZV1hkZ1UyRGNYbGVNeUsvNlRBMWFZKy05Vjd2cUFTVyst?=
 =?utf-7?B?Y2tOY0ZLYXVXMzh4Q0hGMXRMeUpoem55OVY4dWpocDBwaVVUNlF5Z04vSml6?=
 =?utf-7?B?ZWhCTVVHMm9TdVJGZ1RWa29XTlFmUFdlbldkRWJheE1Gc0lzWUZWekNCWWtp?=
 =?utf-7?B?WldoVnlaaWI4cXpvY1hScFR2cFJucXRUTk1JU2V4RzhDOUdWdDAxWFpQcVRu?=
 =?utf-7?B?b2hyRE9ZVzFHaXdsd2xBcTlyNlVLSXRkZEhsWENyZDhhL29kRGliU0V1dy80?=
 =?utf-7?B?Ky1zTGxpWlVRaVBPdTZzSjNldDZwOFF4VVFoaHB6UTJuUkMwTXBjdHFYTFRs?=
 =?utf-7?B?ejJWUkpBTWYrLURPMnVTbk5ta21EOHpWT1diZkFkNFhqejNWeS9vNXRYZUdB?=
 =?utf-7?B?TWpUVURmaU1hQXl5QVE5dng2Z2NyMjM4bVhSZ3p3VFo4TkNuY3Q2THhmY1lV?=
 =?utf-7?B?cDkxcHY3eE1OUm9VRnI5SU9FS1doZWZvSzdMUkc0ZzI3ZE5HZzc0bVhxcUVL?=
 =?utf-7?B?VnJZMTFLbTBzblc5TVJUMHJRbjVMdVdScmdkSWFxS2k1MHdKNVczRFU2U2lU?=
 =?utf-7?B?SjVCT3NQV0NJVmJJMGtPcnhTazhnck5VVXpWb3FraEp0aHErLUNJMFpBQi8x?=
 =?utf-7?B?SVBaVXE0bWtVbTVBKy1BMmRJUXFXNUxialdFblowODJMcTJUdDRlcjlzOTFM?=
 =?utf-7?B?L0lLOXBnR0ZySXFNaVdhaWwyM2IwSG1NZlM3UWR3M28zaSstMlc5bDNCM2hQ?=
 =?utf-7?B?YzhrTkRqalRJcmhpcGpXUkF3b3N2YzZHSFFkUmtHZ2NpUWlZZlJ4TWFvUGRp?=
 =?utf-7?B?MEFHVHdLcFE4cEVEMDVDVDJ0QXpMY1VEMWJUTGJkWWhEeXlZL1lXMDkxMTlB?=
 =?utf-7?B?dUxRZEN3SGRwSy9sU1ZDRlBoTHJBR2xHc0dNeENBY2xuNzZCU240WWVEU0Mx?=
 =?utf-7?B?NDVFUmc3M3Q0SFo2SnhGd2hLNEJkbjVybHZpRC83UVp6blRQOUl5REVEZDd5?=
 =?utf-7?B?WlpiNTE4cG54Y2hERk95bWxOYVI2S29KTFI1ZkRBRnUvaURzN1FIOEtqbGxq?=
 =?utf-7?B?cUlmaDA4ZE1yZHhrYTVpSW92Y1ZJWUo4clBoclhRZmZ0Z3FJRGJ5eUhhOUpP?=
 =?utf-7?B?OVhMWThYYkVDSGU4Wk5CNkwwcERFT2Q1RVFsQ2tZQnJiRElHVmUycUdFVmpR?=
 =?utf-7?B?Z08wT3hwemNYVG9qOHNidkRYOW81YjZPUTRQanFYczRXaUZLck9janhN?=
 =?utf-7?B?K0FEMC0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(786006)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?dW9DY2ZXWXFsa2MzVlFydVROZWRPblZxVzlybzBWejV5QndQd1RvdlRTOEVV?=
 =?utf-7?B?RmxwSWpqYWZFSnZadEdWWU16V25WOU9qYSstanB3Y2NGMWpiaFp6bzE1QTVY?=
 =?utf-7?B?bUhqa2M1Rm9zbEpjUloyQklRcjlOWVJkbWhEQjVyM1FRRjNzWmJ2WklZd1Fp?=
 =?utf-7?B?ODBrc2wrLXV4dVJGaGhkOGJZdmhqU2x2YlFYR29KM0d5ZjdkV1cxKy16VGJM?=
 =?utf-7?B?TVhZV3dqVm9QcXhyYm05ZFpFNjFQdWZMRXV6dUsvOEJ3bmtzV0xUbTVndG1E?=
 =?utf-7?B?NFJDL1c3THBmaTU4T1F2UkNKSVB6dUlRRjBhcmRzaVVQOWJQbFluTVlxelBU?=
 =?utf-7?B?UkNUOHAxa1lUVE9GWmdoRjNidEo3ZGZqZ2hLZ1BPOWNPQkxMYXZZSUFrUEo1?=
 =?utf-7?B?VjFTQ2RGTTFaN1hqR2tudTNpdjNCdjZwUFRUVC85VHpsdWd0Zy9FR0swUENa?=
 =?utf-7?B?N0lsa095SzN1SGUvWHlWS1lvWjlqWWFPdm1lQWw2SE5KRERaUVBZd2pya2x1?=
 =?utf-7?B?NXJlMDdWQmF5bWt3aXVXMzNza0tmVW50Q1d0UDNPRmgwYUs2dFFGKy1xbmRt?=
 =?utf-7?B?YUZhejFnTEF1WWVoajJ1b2R0ZTlCeXFNR2dRZmNnTktLVE42VXpMZ0M1OUZX?=
 =?utf-7?B?VkpWRkpNbHFFeWNZKy1JS3YvYzFPZWloeExJOHhOL2lKM0hJSHpyYVRhSm81?=
 =?utf-7?B?UWxiVjZPT05IZk4zR3pJVjh2d2NsL3lwMkFhd1RoZnFSMTAxdW90eEJwaTRr?=
 =?utf-7?B?U3NOMW1UaVRWcEZVT2oyaistQ3g3cmtpeWpPTkdOWGlhVWpPajJFTXhFZTJ5?=
 =?utf-7?B?S0ZibHgzRWhPM05VOUEyQ3pmZHRlYWxab1JjUFlOZHRJdWNvdVBobThjY1k3?=
 =?utf-7?B?UVM1L21kMXFOTm90SystYVh4aEhaR3Z3bUdGaGxoL0U0cTgwcWtXVVdtbnIv?=
 =?utf-7?B?amVNT0dpKy0vKy1SUzQ4L0gyaUVTWGZNRzJGanBhRjJnNWdrbjM0OU4rLWZz?=
 =?utf-7?B?Qk14aFF4WUhMYWg5V1J5akpDYistYk1MZWQyajA1ZTk3M0laY0ZwY05VVXg2?=
 =?utf-7?B?MVJXNnBBek5WQmxQU3A4a0k1ZFE1cHNzL2x3c0daaVZDRG5NQTk4b2VVLzRL?=
 =?utf-7?B?Nm9ZZHBZNEt0Q0ZjOGxBUkdoSTZIcHAzZ2VmRUh2V05Db0JwVDZlY0xYeGw5?=
 =?utf-7?B?NVR1QlIwd3Nqb0hSNEd4SDBjS2EzRU9rakF2d3pQdENsdXpCYXpDeWY2ZDEy?=
 =?utf-7?B?Vmh1QjdUMVh1ME12TzI3WTdCVXd2bFVMb3hEaWpydy9RZmV5Ky1wNHh1Qmty?=
 =?utf-7?B?cUJzVDdPR09vWTVzWGppQWJNZTJJRzQ4b2hKY2xucjVVR2FvQVhiUmhibXZy?=
 =?utf-7?B?YTMzUnNhdlp2MWFoSHFEbHU4RnpJamxwQ0JxV3p1clY2ZG5yZWxUNnpYdGtp?=
 =?utf-7?B?MjAzQ3FrMXlvb05QTWpkeUJ6TTZ1bWUzaFdaWGZTWXlaMDAxYVpRaDFYZWZC?=
 =?utf-7?B?RWFaZXkxZmJEL0NHNjVDNXkxc3djeTY4akhDMlBSNjIvbWt0aHhLOWtBZFFZ?=
 =?utf-7?B?Mkx2UEhibVFtUnBVamw1YkV0UU1kRkdKM2FZUkhtWHg4RHJ3RXlkUDYrLThQ?=
 =?utf-7?B?a0ZJSzVnZW1CWVZTS0RWTmpGa1c1TlQyOEJpQi9NSlF4V1lhY1VKR2NnSnJp?=
 =?utf-7?B?OHg0M3FiWGVwd2JkcDU5eklqZ3l2ZkNOc0NSRUhUc0JLTllsVlREWDJ2TmlY?=
 =?utf-7?B?eTlxMUZBcHF4VGd5blhjS045OHhsbG5zMmpSbGVIL0pPenZXMDh1bktaWDUv?=
 =?utf-7?B?WkpDY2VHU3E2S21vdExZTWllbystUFRmYm1yR2F4SXlseGtoTE5yNEpQMU5W?=
 =?utf-7?B?djZ1SEhpTUh6SWhWZWRzdWVUQ0hJc3ZBOXZoYWpNdW9TN3NUc1lnSXp0Yllx?=
 =?utf-7?B?NkZlUlZ5bUZ2S1FqeFJaTkpuYTZtbkdpUENKS24vanZnalpxSVhtbG1paHpm?=
 =?utf-7?B?NnVVZWlBbmFuTjAyRk9OSWRiblBudGJVWVNCb2NYRjRFOENqTGxDYXpsa1Yx?=
 =?utf-7?B?bXpIczZxSi9pSDhodnk5aTZQVDJVY2FoQ2ljQ1U3bnkzdkZOaHJjRkdDQW4w?=
 =?utf-7?B?Q2l3VFNPR05FV0R6OXhiTkpMcktwV1pBQnNDNFNkRXVHWUtiWDhoQlhYM1Nr?=
 =?utf-7?B?LystNlFwTHoySFdNcUhabk1PM2xMTm1rR1NFZFZjb1NFUjdmTnp0NXVtSlZO?=
 =?utf-7?B?c0pNM1FxQ3NmajN2djhVTGU2T0s5L3Z1VDR6Q1ZmTC9Rc2xQVHJRTWFSb2Fi?=
 =?utf-7?B?ajF6T3VVVEZHM29ocFZoaSstKy1IZ2w1WWNtc0N3V1BCcWlOa3hkUGhKamxw?=
 =?utf-7?B?bnNMZ21NTURQZ0tRK0FEMEFQUS0=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b40fb93-8ed6-45f0-2392-08de540d0ac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 08:06:52.4955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HnMOfuV7+nSoKKARCTjxFuuf+TGRjeGbNO27SywCkFDDLqczjpPlj5ewyHT5O0put5hyHn0xJrQms2mkY+flVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB7709
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_02,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601150054
X-Proofpoint-GUID: Id5f_514ehsVkrQt_m6_yRvqnNEdsz3T
X-Authority-Analysis: v=2.4 cv=W5g1lBWk c=1 sm=1 tr=0 ts=6968a021 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=iLNU1ar6AAAA:8 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8
 a=XlRjxQ70AAAA:8 a=LfxEVeEBAAAA:8 a=eSb-bNSJAAAA:8 a=QEEkIeqjAAAA:8
 a=yZ0TczAezmHc2_xKRTkA:9 a=avxi3fN6y70A:10 a=gbU3OgOOxF9bX48Letew:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=1uMOUU2w0DxzEe95gQqD:22 a=7k9nRlTqVbDGZ3p5_T00:22
 a=h7YW-pclpbZRD8svLbQ0:22 a=iapMWHAMLVzCBf0btcAb:22
X-Proofpoint-ORIG-GUID: Id5f_514ehsVkrQt_m6_yRvqnNEdsz3T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDA1NCBTYWx0ZWRfX5pWE2Ybaq2eY
 yhNJTfxugzMb+MAvSsU+cdL78O1h1tmADFHCqUDe+DRJ4iBcHBPSLsXtCvUUSR0N2S90sHmiioW
 KW9I+n7obFFS9GlCOw3EMVwkrzQASJ+Igoka72PX5bCb9BK8QdJsLnzNyR7rCGwjxLn64UK97di
 wWiGOTNkSj0UH1EDh6ETvzkQGtC2uBTIuzRk0Fk11Zq53HrEzVtfCWa2fajNRwZGsG95ZZqEVOY
 YZWaLK9oRtiJvi7IMgNPWC5NOtIt/Q0K+2svKIRihTXQjGNoOPYWonRvDWS63uIwWIMs3A9OGOS
 ITuL372mBD80Eytwa0KOSfSPJaX66vYo5PXw0OujJl3FZw4Z+bCjg8fSHkZnxGm7VvLNtjOSjCS
 jFscH+/DWY94ofueGdAJVvZfDVsfIY98Z0G63vRugL3J+P8qpQKK3P/SBj6rkUCT70/iBxkA69g
 oQTdr7fuqtogJmVU78A==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601150054
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

Responses inline.


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Maxime Coquelin +ADw-maxime.coquelin+AEA-redhat.com+AD4-
+AD4- Sent: Tuesday, January 6, 2026 8:37 AM
+AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4AOw- dev+AEA-=
dpdk.org
+AD4- Cc: pravin.m.bathija.dev+AEA-gmail.com
+AD4- Subject: Re: +AFs-PATCH v5 4/4+AF0- vhost+AF8-user: Function defs for=
 add/rem mem
+AD4- regions
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4-
+AD4-
+AD4- On 11/13/25 1:44 PM, Pravin M Bathija wrote:
+AD4- +AD4- These changes cover the function definition for add/remove memo=
ry
+AD4- +AD4- region calls which are invoked on receiving vhost user message =
from
+AD4- +AD4- vhost user front-end (e.g. Qemu). In our case, in addition to t=
esting
+AD4- +AD4- with qemu front-end, the testing has also been performed with l=
ibblkio
+AD4- +AD4- front-end and spdk/dpdk back-end. We did I/O using libblkio bas=
ed
+AD4- +AD4- device driver, to spdk based drives. There are also changes for
+AD4- +AD4- set+AF8-mem+AF8-table and new definition for get memory slots. =
Our changes
+AD4- +AD4- optimize the set memory table call to use common support functi=
ons.
+AD4- +AD4- Message get memory slots is how the vhost-user front-end querie=
s the
+AD4- +AD4- vhost-user back-end about the number of memory slots available =
to be
+AD4- +AD4- registered by the back-end. In addition support function to inv=
alidate
+AD4- +AD4- vring is also defined which is used in add/remove memory region=
 functions.
+AD4- +AD4-
+AD4- +AD4- Signed-off-by: Pravin M Bathija +ADw-pravin.bathija+AEA-dell.co=
m+AD4-
+AD4- +AD4- ---
+AD4- +AD4-   lib/vhost/vhost+AF8-user.c +AHw- 249 +-+-+-+-+-+-+-+-+-+-+-+-=
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+----
+AD4- ---
+AD4- +AD4-   1 file changed, 217 insertions(+-), 32 deletions(-)
+AD4- +AD4-
+AD4- +AD4- diff --git a/lib/vhost/vhost+AF8-user.c b/lib/vhost/vhost+AF8-u=
ser.c index
+AD4- +AD4- 7dc21fe42a..d9cf967ba2 100644
+AD4- +AD4- --- a/lib/vhost/vhost+AF8-user.c
+AD4- +AD4- +-+-+- b/lib/vhost/vhost+AF8-user.c
+AD4- +AD4- +AEAAQA- -71,6 +-71,9 +AEAAQA-
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
+AD4- +AD4- +-vhost+AF8-user+AF8-rem+AF8-mem+AF8-reg, false, true) +AFw-
+AD4- +AD4-   VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SET+AF8-LOG+=
AF8-BASE,
+AD4- vhost+AF8-user+AF8-set+AF8-log+AF8-base, true, true) +AFw-
+AD4- +AD4-   VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SET+AF8-LOG+=
AF8-FD,
+AD4- vhost+AF8-user+AF8-set+AF8-log+AF8-fd, true, true) +AFw-
+AD4- +AD4-   VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SET+AF8-VRIN=
G+AF8-NUM,
+AD4- +AD4- vhost+AF8-user+AF8-set+AF8-vring+AF8-num, false, true) +AFw- +A=
EAAQA- -1520,7 +-1523,6 +AEAAQA-
+AD4- vhost+AF8-user+AF8-set+AF8-mem+AF8-table(struct virtio+AF8-net +ACoAK=
g-pdev,
+AD4- +AD4-     struct virtio+AF8-net +ACo-dev +AD0- +ACo-pdev+ADs-
+AD4- +AD4-     struct VhostUserMemory +ACo-memory +AD0- +ACY-ctx-+AD4-msg.=
payload.memory+ADs-
+AD4- +AD4-     struct rte+AF8-vhost+AF8-mem+AF8-region +ACo-reg+ADs-
+AD4- +AD4- -   int numa+AF8-node +AD0- SOCKET+AF8-ID+AF8-ANY+ADs-
+AD4- +AD4-     uint64+AF8-t mmap+AF8-offset+ADs-
+AD4- +AD4-     uint32+AF8-t i+ADs-
+AD4- +AD4-     bool async+AF8-notify +AD0- false+ADs-
+AD4- +AD4- +AEAAQA- -1565,39 +-1567,13 +AEAAQA- vhost+AF8-user+AF8-set+AF8=
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
+AD4- +AD4-
+AD4- +AD4-     for (i +AD0- 0+ADs- i +ADw- memory-+AD4-nregions+ADs- i+-+-=
) +AHs-
+AD4- +AD4-             reg +AD0- +ACY-dev-+AD4-mem-+AD4-regions+AFs-i+AF0A=
Ow-
+AD4- +AD4- +AEAAQA- -1661,11 +-1637,182 +AEAAQA- vhost+AF8-user+AF8-set+AF=
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
+AD4- +AD4-
+AD4- +AD4- -free+AF8-guest+AF8-pages:
+AD4- +AD4- +-static int
+AD4- +AD4- +-vhost+AF8-user+AF8-get+AF8-max+AF8-mem+AF8-slots(struct virti=
o+AF8-net +ACoAKg-pdev +AF8AXw-rte+AF8-unused,
+AD4- +AD4- +-                   struct vhu+AF8-msg+AF8-context +ACo-ctx,
+AD4- +AD4- +-                   int main+AF8-fd +AF8AXw-rte+AF8-unused)
+AD4- +AD4- +-+AHs-
+AD4- +AD4- +-   uint32+AF8-t max+AF8-mem+AF8-slots +AD0- VHOST+AF8-MEMORY+=
AF8-MAX+AF8-NREGIONS+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   ctx-+AD4-msg.payload.u64 +AD0- (uint64+AF8-t)max+AF8-mem+A=
F8-slots+ADs-
+AD4- +AD4- +-   ctx-+AD4-msg.size +AD0- sizeof(ctx-+AD4-msg.payload.u64)+A=
Ds-
+AD4- +AD4- +-   ctx-+AD4-fd+AF8-num +AD0- 0+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-REPLY+ADs-
+AD4- +AD4- +-+AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-static void
+AD4- +AD4- +-dev+AF8-invalidate+AF8-vrings(struct virtio+AF8-net +ACo-dev)=
 +AHs-
+AD4- +AD4- +-   uint32+AF8-t i+ADs-
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
+AD4- VHOST+AF8-USER+AF8-ADD+AF8-MEM+AF8-REG)+ADs-
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
+AD4- +AD4- +-           +AH0-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-+AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-static int
+AD4- +AD4- +-vhost+AF8-user+AF8-add+AF8-mem+AF8-reg(struct virtio+AF8-net =
+ACoAKg-pdev,
+AD4- +AD4- +-                   struct vhu+AF8-msg+AF8-context +ACo-ctx,
+AD4- +AD4- +-                   int main+AF8-fd +AF8AXw-rte+AF8-unused)
+AD4- +AD4- +-+AHs-
+AD4- +AD4- +-   uint32+AF8-t i+ADs-
+AD4- +AD4- +-   struct virtio+AF8-net +ACo-dev +AD0- +ACo-pdev+ADs-
+AD4- +AD4- +-   struct VhostUserMemoryRegion +ACo-region +AD0-
+AD4- +AD4- +-+ACY-ctx-+AD4-msg.payload.memory+AF8-single.region+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   /+ACo- convert first region add to normal memory table set=
 +ACo-/
+AD4- +AD4- +-   if (dev-+AD4-mem +AD0APQ- NULL) +AHs-
+AD4- +AD4- +-           if (vhost+AF8-user+AF8-initialize+AF8-memory(pdev)=
 +ADw- 0)
+AD4- +AD4- +-                   goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   /+ACo- make sure new region will fit +ACo-/
+AD4- +AD4- +-   if (dev-+AD4-mem-+AD4-nregions +AD4APQ- VHOST+AF8-MEMORY+A=
F8-MAX+AF8-NREGIONS) +AHs-
+AD4- +AD4- +-           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR, +AC=
I-too many memory
+AD4- regions already (+ACU-u)+ACI-,
+AD4- +AD4- +-                                                             =
      dev-
+AD4- +AD4-mem-+AD4-nregions)+ADs-
+AD4- +AD4- +-           goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   /+ACo- make sure supplied memory fd present +ACo-/
+AD4- +AD4- +-   if (ctx-+AD4-fd+AF8-num +ACEAPQ- 1) +AHs-
+AD4- +AD4- +-           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR, +AC=
I-fd count makes no
+AD4- sense (+ACU-u)+ACI-, ctx-+AD4-fd+AF8-num)+ADs-
+AD4- +AD4- +-           goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   /+ACo- Make sure no overlap in guest virtual address space=
 +ACo-/
+AD4- +AD4- +-   if (dev-+AD4-mem +ACEAPQ- NULL +ACYAJg- dev-+AD4-mem-+AD4-=
nregions +AD4- 0) +AHs-
+AD4- +AD4- +-           for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMORY+AF8-M=
AX+AF8-NREGIONS+ADs- i+-+-) +AHs-
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
+AD4- +AD4- +-                   bool curent+AF8-region+AF8-guest+AF8-start=
+AF8-overlap +AD0-
+AD4-
+AD4- s/curent/current/
+AD4-
+AD4- +AD4- +-                           current+AF8-region+AF8-guest+AF8-s=
tart +AD4APQ-
+AD4- proposed+AF8-region+AF8-guest+AF8-start +ACYAJg-
+AD4- +AD4- +-                           current+AF8-region+AF8-guest+AF8-s=
tart +ADwAPQ-
+AD4- proposed+AF8-region+AF8-guest+AF8-end+ADs-
+AD4- +AD4- +-                   bool curent+AF8-region+AF8-guest+AF8-end+A=
F8-overlap +AD0-
+AD4- +AD4- +-                           current+AF8-region+AF8-guest+AF8-e=
nd +AD4APQ-
+AD4- proposed+AF8-region+AF8-guest+AF8-start +ACYAJg-
+AD4- +AD4- +-                           current+AF8-region+AF8-guest+AF8-e=
nd +ADwAPQ-
+AD4- proposed+AF8-region+AF8-guest+AF8-end+ADs-
+AD4-
+AD4- Ditto
+AD4-
+AD4- +AD4- +-                   bool proposed+AF8-region+AF8-guest+AF8-sta=
rt+AF8-overlap +AD0-
+AD4- +AD4- +-                           proposed+AF8-region+AF8-guest+AF8-=
start +AD4APQ-
+AD4- current+AF8-region+AF8-guest+AF8-start +ACYAJg-
+AD4- +AD4- +-                           proposed+AF8-region+AF8-guest+AF8-=
start +ADwAPQ-
+AD4- current+AF8-region+AF8-guest+AF8-end+ADs-
+AD4- +AD4- +-                   bool proposed+AF8-region+AF8-guest+AF8-end=
+AF8-overlap +AD0-
+AD4- +AD4- +-                           proposed+AF8-region+AF8-guest+AF8-=
end +AD4APQ-
+AD4- current+AF8-region+AF8-guest+AF8-start +ACYAJg-
+AD4- +AD4- +-                           proposed+AF8-region+AF8-guest+AF8-=
end +ADwAPQ-
+AD4- current+AF8-region+AF8-guest+AF8-end+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-                   overlap +AD0- curent+AF8-region+AF8-guest+=
AF8-start+AF8-overlap
+AD4- +AD4- +-                           +AHwAfA- curent+AF8-region+AF8-gue=
st+AF8-end+AF8-overlap
+AD4- +AD4- +-                           +AHwAfA- proposed+AF8-region+AF8-g=
uest+AF8-start+AF8-overlap
+AD4- +AD4- +-                           +AHwAfA- proposed+AF8-region+AF8-g=
uest+AF8-end+AF8-overlap+ADs-
+AD4-
+AD4- Couldn't all the above be simplified with something like below?
+AD4-
+AD4- overlap +AD0- +ACE-(proposed+AF8-region+AF8-guest+AF8-end +ADw- curre=
nt+AF8-region+AF8-guest+AF8-start +AHwAfA-
+AD4-                 proposed+AF8-region+AF8-guest+AF8-start +AD4- current=
+AF8-region+AF8-guest+AF8-end)+ADs-
+AD4-

You are correct, the above lines of code can be simplified to what you're p=
roposing. I will make the necessary changes, retest and resubmit the patch.

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
+AD4- +AD4- +-   /+ACo- find a new region and set it like memory table set =
does +ACo-/
+AD4- +AD4- +-   struct rte+AF8-vhost+AF8-mem+AF8-region +ACo-reg +AD0- NUL=
L+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMORY+AF8-MAX+AF8-N=
REGIONS+ADs- i+-+-) +AHs-
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
+AD4- +AD4- +-   if (vhost+AF8-user+AF8-mmap+AF8-region(dev, reg, region-+A=
D4-mmap+AF8-offset) +ADw- 0) +AHs-
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
+AD4- +AD4- +-           async+AF8-dma+AF8-map+AF8-region(dev, reg, true)+A=
Ds-
+AD4- +AD4- +-
+AD4- +AD4- +-   if (vhost+AF8-user+AF8-postcopy+AF8-register(dev, main+AF8=
-fd, ctx) +ADw- 0)
+AD4- +AD4- +-           goto free+AF8-mem+AF8-table+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   dev+AF8-invalidate+AF8-vrings(dev)+ADs-
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
+AD4- +AD4- +AEAAQA- -1673,6 +-1820,44 +AEAAQA- vhost+AF8-user+AF8-set+AF8-=
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
+AD4- +AD4- +-   uint32+AF8-t i+ADs-
+AD4- +AD4- +-   struct virtio+AF8-net +ACo-dev +AD0- +ACo-pdev+ADs-
+AD4-
+AD4- pdev is marked 'unused', it needs to be fixed.
+AD4-
+AD4- +AD4- +-   struct VhostUserMemoryRegion +ACo-region +AD0-
+AD4- +AD4- +-+ACY-ctx-+AD4-msg.payload.memory+AF8-single.region+ADs-
+AD4-
+AD4- Same for ctx.
+AD4-
+AD4- +AD4- +-
+AD4- +AD4- +-   if (dev-+AD4-mem +ACEAPQ- NULL +ACYAJg- dev-+AD4-mem-+AD4-=
nregions +AD4- 0) +AHs-
+AD4- +AD4- +-           for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMORY+AF8-M=
AX+AF8-NREGIONS+ADs- i+-+-) +AHs-
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
+AD4- +AD4- +-                           if (dev-+AD4-async+AF8-copy +ACYAJ=
g-
+AD4- rte+AF8-vfio+AF8-is+AF8-enabled(+ACI-vfio+ACI-))
+AD4- +AD4- +-                                   async+AF8-dma+AF8-map+AF8-=
region(dev,
+AD4- current+AF8-region, false)+ADs-
+AD4- +AD4- +-                           dev+AF8-invalidate+AF8-vrings(dev)=
+ADs-
+AD4- +AD4- +-                           free+AF8-mem+AF8-region(current+AF=
8-region)+ADs-
+AD4- +AD4- +-                           dev-+AD4-mem-+AD4-nregions--+ADs-
+AD4- +AD4- +-                           return RTE+AF8-VHOST+AF8-MSG+AF8-R=
ESULT+AF8-OK+ADs-
+AD4- +AD4- +-                   +AH0-
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

