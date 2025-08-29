Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92424C8303F
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 09:11:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D777C40263;
	Fri, 29 Aug 2025 11:11:42 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id E576B4025A
 for <dev@dpdk.org>; Fri, 29 Aug 2025 11:11:41 +0200 (CEST)
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T83Xee023898;
 Fri, 29 Aug 2025 05:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=+
 NBTn5Ey+KX529JQM4JEeF7nX+df8z/MCZN+nhTdESQ=; b=C5UFU60Gv+10i/p7E
 uHDmB5Pxfo862GXbgSgBiy5xa47/otp/DfkrFfuUYFS0nFJ9AQ33YyY05SIiYw8y
 DIeKxd9IH/6TvZbFcp4cxb3tfV63DHbrLuk+gxvqVO9JgFzfLRZCDJMK6hl9t1Xa
 JSiWoHECdSbqF9iBAPYYRyySXTA4q9J6mVS+/eigB9Eoh/LEu//q+DJajbWqdQ/z
 9NxM/pjMAi14xc2bks/r5Vn5zLxTriDveOHUQ1rrVR+AX65KrBTcJTxSZTzbZHA0
 yDufxVp/aBfnO+esbOBFLSWAlZw6c51ndHjpQ+pzDpsd+00gkf9QzV+j5F2P0fXK
 Fqd+g==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 48q8vaumtj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Aug 2025 05:11:41 -0400 (EDT)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T849m1010704;
 Fri, 29 Aug 2025 05:11:40 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 48trs84acs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Aug 2025 05:11:40 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmsgQOd/ctjejx4cWp31+jqkPK09s58xesdt/0uYJWdCb5ZAE0ddv9tYTczj6Zdcxdg5uPb0hAovBzLg4iIZOnAtwzUd0zlnA21bPtR46UlVdZUjBGukDzqMUUBgAMnupZadVdEnIpNjt9N70ZfLB5CXYZ7XIyNNZEXZHSQzrQ50OoOYLkCHPMelAuo4Y23uyztFctjmzRE+DilplWiZlj6fjMhg7jNAP/5UNCzIWxn81iixQ6sD+KgyYgAo1ROtU7rBJMa3Vbb2Xodg9libbf7qqnP7VbUEsum4fX0Tp+C5pBk2R3b+LkpHEy1NHDNRVrPzS/rDGjfcHBakmdjhhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NBTn5Ey+KX529JQM4JEeF7nX+df8z/MCZN+nhTdESQ=;
 b=u88+JvBBhKa8PegA/X+AJQ7v2FOlJpQS/0Do+4vjHBA8Z3CjSMwb6lMqNWWA0HCzL2uMpmyVx1HPLcqXRFXHIQ3D0uvDwTM3NzDguBR5wvYrQ2BpUqAMOPv4dwhlijgD+tGTvFI+F246vSV5f8jfW4NO4QrIxNTrrxNTFcJ7iHISSzG+a9mQIgtGaayD9aXB8PfPILCCkhK4Kh79JSbqe48HFqA3ZBeeK/CLyk5gazSG1/jr+U7GfcDJX/VwjZzzR2DPSqmUqAoW5t6raVRYKSkzzMt56IaT/9LxKMQ9gFyqv2wbbLt5BDNkLUqNuW7eC6bU9OSmzk9iiddTM7dS5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by IA0PPF253CCDB1B.namprd19.prod.outlook.com
 (2603:10b6:20f:fc04::c95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 29 Aug
 2025 09:11:31 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.9031.023; Fri, 29 Aug 2025
 09:11:31 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>, David Marchand <david.marchand@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "pravin.m.bathija.dev@gmail.com"
 <pravin.m.bathija.dev@gmail.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: RE: [PATCH 0/3] vhost_user: configure memory slots
Thread-Topic: [PATCH 0/3] vhost_user: configure memory slots
Thread-Index: AQHcCzGgtkGye+sTHE2EwlyJqW9UY7Rp5H4AgAQgPWCAAFHO0IAEzWMAgAI4A7CABBa+UA==
Date: Fri, 29 Aug 2025 09:11:31 +0000
Message-ID: <SJ0PR19MB460649E8A3D39B224CFB4469F53AA@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <20250812023358.2400020-1-pravin.bathija@dell.com>
 <15537925.JCcGWNJJiE@thomas>
 <SJ0PR19MB4606D8D898219FE2296C7FB4F53DA@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <SJ0PR19MB46063FDCC149084AFBD7C4E1F53DA@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <8391ac53-0b5c-468c-ae38-341842f5c492@redhat.com>
 <SJ0PR19MB46063A880B831758A7455613F539A@SJ0PR19MB4606.namprd19.prod.outlook.com>
In-Reply-To: <SJ0PR19MB46063A880B831758A7455613F539A@SJ0PR19MB4606.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-08-26T18:42:23.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|IA0PPF253CCDB1B:EE_
x-ms-office365-filtering-correlation-id: 32f28ee2-b28f-4e92-2bf9-08dde6dc0b6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-7?B?WURBKy1adk9iVGF2b1lvTm5Qbm9sc2twWDZyY2hJSUs3WjcvRmpsTjVPTW9G?=
 =?utf-7?B?MTNTVVRWb2xWbWZJdVhpdkhPTDkwWjZMUEpsd3BjNDB0WGpsQlJENEJZblkz?=
 =?utf-7?B?b3ZHOGdsQ1lDWlBqVnFBU0tURS81QistbU1yMkg3Wlp4U2lHbmpZd2RsR2xE?=
 =?utf-7?B?WGRyVXRabzFCT0xCY3BQcW14Y05iWG5SUDBVaDVCMXdxMnZIM2NWUDlBa2R1?=
 =?utf-7?B?bHFJTSstYUlublBqOVZZV3lLdlpDajlROE9HWURyMGtxMVoxajdKcnlXQWRs?=
 =?utf-7?B?WVhQbXkvTUZ5di9uT21IOVFQbS80VkxCSUhxY1NMd1ZpNU9nUVBYSHRjazlv?=
 =?utf-7?B?bEVWeGd2RzZIQjF6bmkwdUdNZ293TWR3V1RKTXF6UFFDVk9KMHJSN0xwMDFH?=
 =?utf-7?B?V0VFL2JhVGFER2hGdkg4MEg2V2NZblg2T3UxSUFvTVRrUkppWjREcmdXak1s?=
 =?utf-7?B?aFU0bFBQOVJpMGlyWDlnUnR2UElBRHc0S2JTSlNqU1BuaEQzcWg2cGpzR1Ji?=
 =?utf-7?B?UWVBWFA1OCstWUZFQjFKYUU5bVo5QmYwU0dIbXJ3c1E4MnZzemM3VXUrLXla?=
 =?utf-7?B?ZjdwaTFUTEsvMEJiY3MyYkdRanVqTSstRGd0eHVRKy1oQVliZEtzQzc2MkZR?=
 =?utf-7?B?OFVhUGIybGJmQ3NrRHlzLystWDNlVWRGQ0FzbzZNWjA2enRUVTl3WjdzQnpY?=
 =?utf-7?B?VFJpUkFnTmwrLXFTenA1RnJYZ0JZeDlsZ0kzQ00ybmt4TlAvZDFsYUZxSTU5?=
 =?utf-7?B?cHlyT2l1Vk53Q2YrLUFpNDVwUmVBS0hCZXZDOE9VOXlpZEIxRG9JV1ZhZDJx?=
 =?utf-7?B?MTQyUzdmTXNhUW9RKy05SjZ0a2czYmRzMUxncENzVkc0dy9nUmZGaHF6NzQ1?=
 =?utf-7?B?YklyUDI4blF1THBweWtsa1pCTistMlB1cURQNXJPZ29kVklkd3BZYkJCUGda?=
 =?utf-7?B?L0sxcW14cWU4dHRqTU9uNHE3a01BZURCWDN4VmxsSFJJTURTMHBlQXFzbFU=?=
 =?utf-7?B?Ky13LzVKd1ROSnVUdjVwejR0bXNzWEN3Mzd3RzhzbVFBRjBnZ3loOUlMR2hR?=
 =?utf-7?B?aUUvL21xS2xUTFBtVlF3V3pJMG9YNkZBTklrQmszNXJNV2JMZGxEVFdFbndm?=
 =?utf-7?B?Y3B4aVJldnZXVDJBanFlMXdZZWNoZGcxQzE5eFVIUDd2R3BTZWljQWZVUTI5?=
 =?utf-7?B?dVZ2SFdmV0FvM0hhWjN1bFBNYlZ2QmN0eklEeTU1eWdOcnBrTEtpaHp6VEZQ?=
 =?utf-7?B?OGZuOVZVOEJuYzZwWXNveXU0NEx0NXFyKy1GQ1NQV1NIa2N4UVRrQU5JMWtL?=
 =?utf-7?B?R1BadHppbCstREFHcG9hOTl6bFlRS0FMY21FeG9GYkszdVhXU240WGd3SkYw?=
 =?utf-7?B?NXNlejN2UktLd0FLV045WkRzSDIxVUlYbmFpUTl2bkkyT3VjYWtwZ24yQ2RM?=
 =?utf-7?B?dlpGRmFhYmxkbVpVcHhmOXY1Sm91NTFzTmZyUjBNcnp6TVJXejdRa2tBKy1s?=
 =?utf-7?B?RXp6RFh0ZnVveWw1aEI4bzhubWxTRTB3U0ZCSURTMzNvT2JPNmJsZHpmQmJ3?=
 =?utf-7?B?Zmhoa1MwZTJkcDVJQistMEhQWW1JdXBkUDBjOVoxN2ZSdjdoNG1qejM1cjls?=
 =?utf-7?B?SUNSSmpZV08vbzhNSlJUUUk0c1Q5UlFoWkZxRUl0c2s3RFNaSGt2TkFtMzFp?=
 =?utf-7?B?TFdKdUZORnRKWUZjaHFtVWpzeHorLSstd2NTeXQvNjVDKy16bmFSdGFHUzYy?=
 =?utf-7?B?TzN1VzlETFZaSjRhMFlYQng1a0pseFlmbVJEMHhRczQ2YXBsWjFlZ1U1UnJX?=
 =?utf-7?B?ZjErLS9Wd0MvRGloTUl5UGVSSnhaRlJRVWpIRzhVU3kvZVVPekovRSstMUdC?=
 =?utf-7?B?VEV5ek92V3JjakZPSTRzOHg5Si9zejJTc0JPYlJpOEJUZlJkc2JXc2ZPbE9o?=
 =?utf-7?B?cVY1U1JudEpRVUhDN1hJcFRWZFdJUW45MC9NTFVtOGt0SUJSOTZ6RVJxQist?=
 =?utf-7?B?MFEvUnQrLXA2OERwSS9Yc2xyMDRsdWFnVjUyeGs2OVdXQStBRDBBUFEt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?akZVSnRQN3BYcVVWKy01YkRLWjRqajJzL0ozaGlHREFJaWJyWFVQUDV4L0tZ?=
 =?utf-7?B?eVo3SFJMYUo5MS8rLWxwQm9LMFJkaFdLWFlTN3VHMjZmT1hTRTRBWVAwdnk3?=
 =?utf-7?B?RDRIZVFuMXJpQ21YWUVZRzV6OE1QQlJpbzdDMWt4dkhMTVd3WXhGSGhFRXFr?=
 =?utf-7?B?aGtZWG02MkVjY1J1SG5yNDc4dEF0SmlNekF3MjlmQURrRTBRQTJrV1U3ZlpL?=
 =?utf-7?B?cFM3T0IxRU5lcXh0Ky1CRmdXb1huRlpmVHpjbDJzWE16VEp3b3k4b3d0VmpY?=
 =?utf-7?B?cnpsRlJGQndnMmtBQ3Jmd0tqLzllS0ROTTZxajFJOG1vdGRKRHo0aU9FSVVY?=
 =?utf-7?B?ZUxjdistbDBxRTBicVB3b01jYXNUSjhpT0RPeG5ZQVVOejl5aHRlaS9KSTF4?=
 =?utf-7?B?RTlWRG9QaDhkdGhyWk9lRlJoWW42clRsUjNwYlpETUVIdXhNSHN3SG5od3Aw?=
 =?utf-7?B?cVNrZUN4SFI0bVA0L2JCVERjYzcwL0RkL1YybGhNS3BVcTdvWngwaGR3dGlt?=
 =?utf-7?B?RGZNTXFPcTMxM0NPNDFMZENSbmVzMmRhUlpsMjRLQ2Y3RzBOQ0szM0ZIKy13?=
 =?utf-7?B?TjFPTVZEcWQrLTR4N0ZkN2VyNnBwNTBCWTZ1VFlzTXpURUpoM2YvdEdYTHNr?=
 =?utf-7?B?VVJRcEM4QW1SOWJwQU1vYTlIT2cwSGpGYUVxWmdSTEFkZG1BUHZHc2w4S1V2?=
 =?utf-7?B?dFJzcFRXZCstUDN0TUJaMWlmV0NMMjVVb2xKU1FPVUVDaVhpUkNiaTNRMzBE?=
 =?utf-7?B?eDloaVZGN0QyZ3FTVjViWFczVlF1SkxjdDVlM3FmaSstZUVGdDVNSXFxQ0hP?=
 =?utf-7?B?N1hvSW1FMlp4Vm1kYVUrLXhiSjJJbldLYlppczdmY1JjQXZ1QW1QUUpVUVRh?=
 =?utf-7?B?eVZvRUU1UUw2eExDTDMzbG9JdVVRVHRlRGtJamlmOU1TZFpTUXZ1STNKTlph?=
 =?utf-7?B?MkV2Vmc5c29vWTJncDVZT0FJKy10MVl1OUdoWE40LzNkQkVUb2M5b1VCSVRu?=
 =?utf-7?B?YkNPT0NEYU82Y09yYkdHSGtFSHJPdGRtUmxHTXR3VkQ0SDdWN2dFR1pYVEJp?=
 =?utf-7?B?OTBldkJ4WVhYNG00c01IYlZ2dUV3dGtvNlJ4eGFERHh2RGRIZ01EWWR4UDEx?=
 =?utf-7?B?N3BjRVM1azJPZnVPcXpnTUd4QUNzY05wdGdlc3RZS29CRHRmQ052b0RuVmdh?=
 =?utf-7?B?cHBuMk44NFRwN2tvcUxpbTU3aGtzQzkwdHpmVTVkZ3hyKy10S0JNcUNWOU1Y?=
 =?utf-7?B?N01veXN3YnVCTWdzWXNZZUtwQzF6VFRjb3dpQUNPWDNyeExsdjZoMDE5bXkw?=
 =?utf-7?B?YUxURkhLR3FDTE9Oc0lkNVZ3bEd0bGxZbG04WUhLS0IwYWQ5RnJnWXF5Ky01?=
 =?utf-7?B?Sk93NHVIc0tlamxCTzdtSW5LQ0FIS0NUeWF2SkF5by9HZWlCM1dieDkvbDZn?=
 =?utf-7?B?TG4rLUFHSU1NTm5RRU9kNUR5SHJyNGdLVXZNWjdzY3paY1pLRVNkc3Q0cDRW?=
 =?utf-7?B?VFZJb0RHMG9EUkUyYzlTS2RMTlhSTm1BNTlxYXI3Z05VeU40eFVHaUNVSlBW?=
 =?utf-7?B?ajJHQzR0QzVVV0VwSEE3VlNCMFc5M0RzREtQZzdNelFJQXFJMmpIWVRMTkpu?=
 =?utf-7?B?a0hIQnZFcnZlR3l4ekhhd09Hdm1pYkdQYTkzdnc3QjE0Ky1jTnZCOGY2NnZM?=
 =?utf-7?B?aUM3OTJaY0FXdnRvYzZCSHRBdGh4a2RlTHcrLVYzS25HWWFMNWtNOXR2bHVD?=
 =?utf-7?B?clBZT0pueVMzWTJMOUcvOE5wUlhPbTlZdUhsbE9hUFYvc0FSbXI3TDdXUnds?=
 =?utf-7?B?cVZTOW5oQWptTXVsNFpqU1ZtOGM2ZHptQUNsM0VDbTAyZFJacWlzNzE2T3l0?=
 =?utf-7?B?N253TllkRUc1WTVnV1JTVXRPdXJ2UGlwaXBZZDFxMm5nd2dpVWNqZnIxN05y?=
 =?utf-7?B?MistNTBGSjZWRUNYWFR3N2IwVWNsR0hFd3RWVkZiV2pNN3Ixa0VjWi92YjI4?=
 =?utf-7?B?VmJpRldqeXhQazRaZUpQd1R5RDRmeXpXblRqWW44eDFxanNmZjBPTGtPRmw2?=
 =?utf-7?B?WUwyKy1Xd09iTHE5OVFWeFRvUldMRTZQdTM3Snc4aFVZREJmWU85MDVFelVj?=
 =?utf-7?B?a0grLWZxVjJQdnVNQ3ptbWlNTUFQSGRiZkg3RHBzelYxYVdMZ2NTeGFEeg==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f28ee2-b28f-4e92-2bf9-08dde6dc0b6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 09:11:31.4611 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MU1336+uBy56oZL1Ozi3mfkksGGRSRIFHDwrMHSMlPBZYBkbcevArAwYUX0ZjgCIHLvI5AUUAkHtyzZVkfJkBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF253CCDB1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508280120
X-Proofpoint-ORIG-GUID: 5kTo1FX6GMJYUHq4A2xSBj0VycgTh4PH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDIwMiBTYWx0ZWRfX+87QtWyu+lpi
 64Zav9MuA7acHYqa+moayxIj22Js2xaaNSDPiQURa1DToZIL/j0jNnvVorXh7wqmKAdnOA4yiuG
 rx3l4FfaQFlbC9/KEvRkfPVneKzM3pDl8qJZS34EJ5DEzkwCqwP7e8ycbd9Nqqm2Zhf0jb8uHPg
 EqoPMdpJod5NqYO5LJHw4n9IkWq8pE6BrGglejKtCnHyxAVvagwqihpLHwDVmOraUXhfdM49rqf
 cm+GoQHSuxb2RBZB8Eoo2/1n9y2Ho18ZPnHRrmo8ZL0Jvw2P4IUwhUCoO3rDiKiPc33mppK9I0c
 ymXk6Ddz0UvY3NA192Mfkx4oKy8rt2BEsyx56cll1TZ/heSUBRyRfot8GMlBA8MPR8b9saCZn9M
 P7YjNVKI
X-Authority-Analysis: v=2.4 cv=bIEWIO+Z c=1 sm=1 tr=0 ts=68b16ecd cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8
 a=Ikd4Dj_1AAAA:8 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8 a=bt5KbKNvAAAA:8
 a=iLNU1ar6AAAA:8 a=XlRjxQ70AAAA:8 a=XFJw1KJJAAAA:8 a=BXszkKfDAAAA:8
 a=eSb-bNSJAAAA:8 a=QEEkIeqjAAAA:8 a=6-dRa9qSAAAA:8 a=LfxEVeEBAAAA:8
 a=ndg3YHZ3OsT65auhSfgA:9 a=avxi3fN6y70A:10 a=hlJyneSgMmFPbskH-t2w:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=a-zEBD5cKgE7DNtTSb7C:22 a=1uMOUU2w0DxzEe95gQqD:22
 a=DKZDSSD9H29Cdu8kcpdD:22 a=duu7wrcty9prphiCz_fF:22 a=h7YW-pclpbZRD8svLbQ0:22
 a=iapMWHAMLVzCBf0btcAb:22 a=NZk92sZ4hQKp_Sw8PGvT:22 a=7k9nRlTqVbDGZ3p5_T00:22
X-Proofpoint-GUID: 5kTo1FX6GMJYUHq4A2xSBj0VycgTh4PH
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508260202
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

Dear Maxime, Bruce, David, Chenbo,

Could you please help review the code ? The goal is to merge the changes be=
fore September 18 when the merge window closes for SPDK v25.09.

Regards,
Pravin


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Bathija, Pravin
+AD4- Sent: Tuesday, August 26, 2025 11:47 AM
+AD4- To: Maxime Coquelin +ADw-maxime.coquelin+AEA-redhat.com+AD4AOw- Bruce=
 Richardson
+AD4- +ADw-bruce.richardson+AEA-intel.com+AD4AOw- David Marchand
+AD4- +ADw-david.marchand+AEA-redhat.com+AD4AOw- Chenbo Xia +ADw-chenbox+AE=
A-nvidia.com+AD4-
+AD4- Cc: dev+AEA-dpdk.org+ADs- pravin.m.bathija.dev+AEA-gmail.com+ADs- Tho=
mas Monjalon
+AD4- +ADw-thomas+AEA-monjalon.net+AD4-
+AD4- Subject: RE: +AFs-PATCH 0/3+AF0- vhost+AF8-user: configure memory slo=
ts
+AD4-
+AD4- Answers inline.
+AD4-
+AD4- +AD4- -----Original Message-----
+AD4- +AD4- From: Maxime Coquelin +ADw-maxime.coquelin+AEA-redhat.com+AD4-
+AD4- +AD4- Sent: Monday, August 25, 2025 1:49 AM
+AD4- +AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4AOw- Br=
uce Richardson
+AD4- +AD4- +ADw-bruce.richardson+AEA-intel.com+AD4AOw- David Marchand
+AD4- +AD4- +ADw-david.marchand+AEA-redhat.com+AD4AOw- Chenbo Xia +ADw-chen=
box+AEA-nvidia.com+AD4-
+AD4- +AD4- Cc: dev+AEA-dpdk.org+ADs- pravin.m.bathija.dev+AEA-gmail.com+AD=
s- Thomas Monjalon
+AD4- +AD4- +ADw-thomas+AEA-monjalon.net+AD4-
+AD4- +AD4- Subject: Re: +AFs-PATCH 0/3+AF0- vhost+AF8-user: configure memo=
ry slots
+AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4- +AD4-
+AD4- +AD4- Hi,
+AD4- +AD4-
+AD4- +AD4- Please try to fix your email client so that we can follow the r=
eplies inlined.
+AD4-
+AD4- Thank you for the input. I have made the necessary adjustments. Pleas=
e let me
+AD4- know if there is anything missing.
+AD4-
+AD4- +AD4-
+AD4- +AD4- On 8/22/25 9:33 AM, Bathija, Pravin wrote:
+AD4- +AD4- +AD4- Dear Maxime, Bruce, David, Chenbo,
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- I would like to follow up on the status of the patches an=
d when we
+AD4- +AD4- +AD4- should
+AD4- +AD4- expect these to be merged into the mainline.
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- Please let me know if I can help answer any questions you=
 might have.
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- Regards,
+AD4- +AD4- +AD4- Pravin
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- Internal Use - Confidential
+AD4- +AD4- +AD4- -----Original Message-----
+AD4- +AD4- +AD4- From: Bathija, Pravin
+AD4- +AD4- +AD4- Sent: Thursday, August 21, 2025 7:48 PM
+AD4- +AD4- +AD4- To: Thomas Monjalon +ADw-thomas+AEA-monjalon.net+AD4-
+AD4- +AD4- +AD4- Cc: dev+AEA-dpdk.org+ADs- pravin.m.bathija.dev+AEA-gmail.=
com+ADs- Maxime Coquelin
+AD4- +AD4- +AD4- +ADw-maxime.coquelin+AEA-redhat.com+AD4AOw- Chenbo Xia +A=
Dw-chenbox+AEA-nvidia.com+AD4AOw-
+AD4- David
+AD4- +AD4- +AD4- Marchand +ADw-david.marchand+AEA-redhat.com+AD4AOw- Bruce=
 Richardson
+AD4- +AD4- +AD4- +ADw-bruce.richardson+AEA-intel.com+AD4-
+AD4- +AD4- +AD4- Subject: RE: +AFs-PATCH 0/3+AF0- vhost+AF8-user: configur=
e memory slots
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- Comments inline:
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- -----Original Message-----
+AD4- +AD4- +AD4- From: Thomas Monjalon +ADw-thomas+AEA-monjalon.net+AD4-
+AD4- +AD4- +AD4- Sent: Tuesday, August 19, 2025 4:36 AM
+AD4- +AD4- +AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4-
+AD4- +AD4- +AD4- Cc: dev+AEA-dpdk.org+ADs- pravin.m.bathija.dev+AEA-gmail.=
com+ADs- Maxime Coquelin
+AD4- +AD4- +AD4- +ADw-maxime.coquelin+AEA-redhat.com+AD4AOw- Chenbo Xia +A=
Dw-chenbox+AEA-nvidia.com+AD4AOw-
+AD4- David
+AD4- +AD4- +AD4- Marchand +ADw-david.marchand+AEA-redhat.com+AD4AOw- Bruce=
 Richardson
+AD4- +AD4- +AD4- +ADw-bruce.richardson+AEA-intel.com+AD4-
+AD4- +AD4- +AD4- Subject: Re: +AFs-PATCH 0/3+AF0- vhost+AF8-user: configur=
e memory slots
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- Comments inline
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- 12/08/2025 04:33, Pravin M Bathija:
+AD4- +AD4- +AD4APg- - add protocol feature support add and removal of memo=
ry
+AD4- +AD4- +AD4APg- regions/slots dynamically.
+AD4- +AD4- +AD4APg- - this patch set has been tested with multiple instanc=
es of fio
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- What is +ACI-fio+ACI-?
+AD4- +AD4- +AD4- Fio is an open-source tool to test I/O workloads on disks=
 and file systems.
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4APg- connected via libblkio to spdk target backed unix doma=
in socket.
+AD4- +AD4- +AD4APg- - please apply this this patch-set to dpdk mainline as=
 well as
+AD4- +AD4- +AD4APg- version 25.03.0.
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- As mentionned previously, we don't plan to maintain 25.03=
.
+AD4- +AD4- +AD4- I understand you need it for SPDK,
+AD4- +AD4- +AD4- but I think SPDK should rely only on LTS branches.
+AD4- +AD4- +AD4- Is there a specific reason why 25.03 is required in SPDK?
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- When we do sub-module init on spdk master, it uses dpdk v=
ersion
+AD4- +AD4- +AD4- 25.03 from
+AD4- +AD4- it's own sub-repo.
+AD4- +AD4- +AD4- Our changes for vhost have already been pushed to spdk ma=
ster. We
+AD4- +AD4- +AD4- have also pushed the same dpdk changes in the spdk sub-re=
po +ACI-dpdk+ACI-
+AD4- +AD4- +AD4- which is version 25.03. I was just ensuring that there is=
 uniformity
+AD4- +AD4- +AD4- in the 25.03
+AD4- +AD4- codebase, whether it is on the spdk sub-repo or 25.03 within dp=
dk repo.
+AD4- +AD4-
+AD4- +AD4- Ok, still, it would be better for SPDK to uses LTS as we have n=
o plans
+AD4- +AD4- to add extra stable branches.
+AD4- +AD4-
+AD4- +AD4- Also, your series may be considered as a feature and not a bug =
fix, so
+AD4- +AD4- even if
+AD4- +AD4- 25.03 would be a stable branch (which it is not), it would not =
be
+AD4- +AD4- backported against it.
+AD4-
+AD4- Understood. I would request that we merge my changes into DPDK mainli=
ne
+AD4- before September 18 when the merge window closes for SPDK v25.09.
+AD4-
+AD4- +AD4-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4APg- v2:
+AD4- +AD4- +AD4APg- - fixed warnings with e-mail address
+AD4- +AD4- +AD4APg- - fixed warnings with typos
+AD4- +AD4- +AD4APg- - there is a warning about +AF8AXw-rte+AF8-packed+AF8-=
begin not being in pair
+AD4- +AD4- +AD4APg- with +AF8AXw-rte+AF8-packed+AF8-end which on reading t=
he code turns out to be
+AD4- +AD4- +AD4APg- false. It is an anomaly of how git-format generates th=
e patch and
+AD4- +AD4- +AD4APg- how check-patch checks it.
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- When sending a v2, please use -v2 so it is reflected in t=
he email subject.
+AD4- +AD4- +AD4- I will remember this for next time. Thank you for pointin=
g that out.
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4APg- Pravin M Bathija (3):
+AD4- +AD4- +AD4APg-    mailmap: add user
+AD4- +AD4- +AD4APg-    vhost+AF8-user: configure memory slots
+AD4- +AD4- +AD4APg-    vhost+AF8-user: support for memory regions
+AD4- +AD4- +AD4APg-
+AD4- +AD4- +AD4APg-   .mailmap               +AHw-   1 +-
+AD4- +AD4- +AD4APg-   lib/vhost/rte+AF8-vhost.h  +AHw-   4 +-
+AD4- +AD4- +AD4APg-   lib/vhost/vhost+AF8-user.c +AHw- 325
+AD4- +AD4- +AD4APg- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-=
+-+-+-+-+-+-+-+-------
+AD4- +AD4- +AD4APg-   lib/vhost/vhost+AF8-user.h +AHw-  10 +-+-
+AD4- +AD4- +AD4APg-   4 files changed, 296 insertions(+-), 44 deletions(-)
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4-

