Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CB0CFD364
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 07:24:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A31F40661;
	Tue, 25 Nov 2025 08:24:03 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id A606C402E8
 for <dev@dpdk.org>; Tue, 25 Nov 2025 08:24:00 +0100 (CET)
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP1t5qq014234;
 Tue, 25 Nov 2025 02:23:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=z
 dVg8Qf5knL4fBvDO0Gp1AvfFCqTGm8BGlNmqeovJhs=; b=iLundHg6g0BcV3IjC
 lKYHtSnArpNs47mz0/34KqJTAJFrgpS7rBaEbZFveGAIzO5dzWQcl/lwt7IkTH6v
 0mcHnVuEjLaAayHPkkL6BGP7OQEzIopfC0DYkxg+ZZ9qXuglO5oLvXa9sBnom8w1
 xu+/O8V8ybR0An7Jkj22nINDHxrm/aaZJMEVl051khLkaSEDR3fDTjB1CBziQrT6
 b9O9Lc/6UrqrvCPtRpUfkbuJl+iqWvJYteTC8k+xo78KQtkBjvJfqsdMPR1UI/bG
 1/qhzo6pIUN1nK/01NTkeP8DdWwz8oScchzZCnI/Jk/QTU7vN9/FTCDRd3hO8+gH
 CgTrA==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4ak9cnu384-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Nov 2025 02:23:59 -0500 (EST)
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP6BKfO014664;
 Tue, 25 Nov 2025 02:23:59 -0500
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4ak89wey62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Nov 2025 02:23:59 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSc9Yry3j8XPdUB+l54isyehGcMAk5rxEvEhgnhADsx3KZNqI8OtbGADLqr5xoUCMXxXO3S2mXHOsyBE+ZoA/rm8B3L35t2uH699Go3KWOBApUEwWitHNIq1GeECcKFhoj7YvACe8tFA6p52eE08/UQlBsM03zfUtkhXqio4D61fDXdEieHpCDFFuHiSjmAxS6GH8cXw4CCnYvHrmpF06/v6qvdEeTWWP/sXpCxQGSJYh2OlMXNoWnhdjSrwqdJUfivOYZ6ShlRS+Gez2DIXgx0fyMbDRCVhvoc1ApiolUZd8/T6rk3ILW28CpMOXZ+QLdatmLH3XhlAcizbDzTANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdVg8Qf5knL4fBvDO0Gp1AvfFCqTGm8BGlNmqeovJhs=;
 b=nxCQ1vIuzTCOJIjvgwDSnrmjcPcbMBnKlsTYLuRVaB35FE4xcfifdRrRL9kS0s6EZM6MvmvMwCKQ2kFZ1VPbw/D5gGFZfr3bVnyPhhdz1C9N6ZGkMuOCcsUSaJLXUHXbjOZ3yk0OecghE9B6e0VJGRupQtBXKG2yhcI4+nDxM61wGdVKoCYJrvO0U2Aa5UPTN0CJamDUuLTG6czSCkgMfLxzkUFN6d66gd3LsYBzL/LHemuAyT8bDL6UlggLzVVfDYXtneQW3SeikH07jWiivL2DKHc88HXRlvqnuaJHJuULpTuS8Ir7lANtnxWb5Xodo7gBrmGIey8egvbGyljUGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by SA1PR19MB5571.namprd19.prod.outlook.com (2603:10b6:806:237::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 25 Nov
 2025 07:23:52 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 07:23:52 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: fengchengwen <fengchengwen@huawei.com>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: FW: |Smoke |FAILURE| pw(158765-158768) sid(36689)
 job(PER_PATCH_BUILD17274-20251113210704) [v5,4/4] vhost_user: Function defs
 for add/rem mem regions
Thread-Topic: |Smoke |FAILURE| pw(158765-158768) sid(36689)
 job(PER_PATCH_BUILD17274-20251113210704) [v5,4/4] vhost_user: Function defs
 for add/rem mem regions
Thread-Index: AQHcVMW3flDa9V4i3EeDFkBR+lHgGbUDDkBg
Date: Tue, 25 Nov 2025 07:23:52 +0000
Message-ID: <SJ0PR19MB4606FAC1A477B65FC4AF1CEBF5D1A@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <553996$6i5mrh@smtpauth.intel.com>
In-Reply-To: <553996$6i5mrh@smtpauth.intel.com>
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
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|SA1PR19MB5571:EE_
x-ms-office365-filtering-correlation-id: eaf177bd-ed64-4d58-702e-08de2bf395da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-7?B?TzRVRTVJblZHaGFVSWR2aWFqcDBTNXRwKy12VWVzdTBKQ0cvYTVIMXJnaXRy?=
 =?utf-7?B?anZPbHc5WmdkWFdSYS9ZV2kvdTZLOHRiZFZCVU9aZlN6emZXUXE2UEhTbDF6?=
 =?utf-7?B?ZzJ6T2RZSEh2d0hjVllMcW14bWM4djFha05XbTNheFRSR2tGNUozbkN6RUxT?=
 =?utf-7?B?RWs4VWhqQ1A1RlRnMkorLXU3bnMzNTFpRVc5bXJCcWM2VU5CakdkUlNnUUll?=
 =?utf-7?B?YkE5WVhMV3BmalEzR0FuNzJXU0g2dnBnZkhKdzFpbUpObGpHeE9FcS9DZzJa?=
 =?utf-7?B?SjVFa3VrYistOUJvNHJpelMvbG9XRmRZaVJETTRLTFpRbHdQZGhRR2FCTFZV?=
 =?utf-7?B?Snh2QzZOUEtxNW9ReHNZalVrVFVUTzFPQUYzN2tPeXF1ZXZrT3hzeTd5Q2E=?=
 =?utf-7?B?Ky0wakFxcEtIOWIza21GTTl1WHRrUlh4UU55WllCSjJXc290dmZpT0VIVFk2?=
 =?utf-7?B?WGl0NDJIVkZjQkxPNWRqT3kxcGhRSy9qVistVDlHeE0xdENyYXlaWGwvUHBp?=
 =?utf-7?B?Um5ZODZCQ3J6aHJGNU9zNE5iUk9ORFkrLThxd0xtSW9vNWJIOC82Tllhd09t?=
 =?utf-7?B?bHlCTXBWblFlU21YNCstdTlZSmptd2NielZKTWtzNXhtZGFxMDVtdllEQWJZ?=
 =?utf-7?B?dDczeUZWclZNbEphd1BrNWt6bUhJdG9HYXFHdzFTSGlCdEIvcXlTYVRvTlVG?=
 =?utf-7?B?UmhSdGEweVVwTjJjY0FIQWZqMmhVREZCQ1NGVlBNYzk0VWV2UkFWemllbGc3?=
 =?utf-7?B?ZTBvUm5DN2daOGo0UGgvT3Y5MmFZTkt5b0pmM3phaGhyQlQ5Ky1BU2QxczRU?=
 =?utf-7?B?Y21vZ2ZxZFNkQTNPRGcrLWhqY0h5eWxOT1hmVmxJRDdldXpoMkprU092bThJ?=
 =?utf-7?B?MDJpQTdCZ0t0dFZxL0NwNDRKM3d4OFRoUXBmaThsT0pPR2NqTGVGbk51aDI2?=
 =?utf-7?B?WnpZUEFuKy1YWlVJeVpvai9uRVVrWmtsbU5iQWg1czdOd3d1ZjF2aTJFR2ZP?=
 =?utf-7?B?UDBCcExyem1HWFgrLUdlcDF4NVNaemtFbHBaMWJhTHpkWGpFMENNSnpEUjRK?=
 =?utf-7?B?dHpYZEVXL21TVjBvRSstbXF3VEF6Z1QzRlVHWVo4N3hibk4rLWNITnNyVFA1?=
 =?utf-7?B?TW9vcEZlSk45VzV3TFB2aWt0SXZYQjhwai9ZSHdSeWxabC9Pd0liS05pRTZo?=
 =?utf-7?B?SjcyZjdVZ2xYZzVoMTEwTXlPM21UckYvWjZRZU1TL2hRZ0hUQURaR0dQZm5T?=
 =?utf-7?B?Ujcyb3BQMG5HMGZXd0FpYkdGZzFaQ0MxdmlXNXlLU2tjeURHM01LYXc2NFF2?=
 =?utf-7?B?Mm1XSFBIQmd0N25BY0dtNThaS0poMEZGRWpDZE5VRFRTemk3ZGhJelRUSGhL?=
 =?utf-7?B?RHZrU1doZm1HaVgxQmppKy1MelVIVU1PYWdGR1ZyZVZBVGs3VkVOcXNEVGVT?=
 =?utf-7?B?S2ltT1pQYmdXTUVNWXRqMFpXVlRNemRMdk9iSm9aUFBiNHUwa2xLUWJPekdW?=
 =?utf-7?B?TTd6Q3IzanZyODNwKy1Mamx5T2puRzNlSUtBTEpQUDB4Y2NhWHdXWWtZWTF6?=
 =?utf-7?B?Mk1ld1czWXhXRlNXM2lTbm5MWHIwZDF3QjJRVWZTTTdReVdtc1Nvejl0cmFZ?=
 =?utf-7?B?UGh3UVJxWk0xUTZVRVIybm9qR1A4NU13bHNmdHQ4ZlY3RCstWktIbGpEdjlX?=
 =?utf-7?B?WUVhV0hUd2hNN3NYVTBXbzF2Y21CUk5EVHZyQWx6ZmlRREt6c1VkazMrLXpx?=
 =?utf-7?B?NFMrLVFvR1FSUDlWRFFVWFZZR3RXcXh5YlI1RXBhMzJGMjNqWjI0bWZIVVB2?=
 =?utf-7?B?MjVmTFNRdEZOYXYrLUxxVmQvTW8wY3ZwQUVZZDdSN2xNT2M3VEg2R3N0bkl6?=
 =?utf-7?B?RzM3dmZwOU9CcGtzSkdqNldXVGVnWXhOTzQ5UWRIOHI1NVVVM3NZc0FMKy1j?=
 =?utf-7?B?aDlZcm9RVnMyZGYxVk9oTTlPNHlxQUI3S1BLQlM4U0ozbkE5aUNjaTQ1U05H?=
 =?utf-7?B?dE91cVE0SVhoeWNlTFk1YnRwclRrNVA2Q21oVVN4amovWFZHQ2piZHFDNW9L?=
 =?utf-7?B?RHRzNmhZZ3N1dUJWaklvZnlMclhSTVZDLzVwbU5Wb1dza0JyZjF5UFd5QnR0?=
 =?utf-7?B?bEF6ZytBRDBBUFEt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?WmRJSndjbzV0YWVUOHZ5bFBSbm1kdk5BRlpGY1JNNndLSTE2dVlGSFU2N29r?=
 =?utf-7?B?Q2VQa05hUnNxWENIdlZYdistZjY4LzU1dTNmTU5vV1JQa1RNNkdrYkpxRDF2?=
 =?utf-7?B?dTZRQ0gzU2puZDAvNUNLNzdkdE9vcm9RWUdkSTlKL3h2N1M1NmluYUNnWmd1?=
 =?utf-7?B?MGdnZHBobWhUZllPd09XbENyVlRCMGNUNDl2TEVlMkUrLWFVYmJxRW9yMGtB?=
 =?utf-7?B?b1I3UHEyWkV5RG9KcXlPcGNlRkljQnlxbVBhMFdMUDFRQ2huajIwenJsMXJW?=
 =?utf-7?B?UFRjU1BrWkNwZFBTQ2VrQmVzaHpGNkdjcnk0SUhKVjV0cnBUWGE1TG0zQVJv?=
 =?utf-7?B?LzVwVXI0TW9rM0V1VC9oWVJtM2ZJS2NvRmFMZkNFMWxFY2hGNm9UL3ZJLzd1?=
 =?utf-7?B?UVJxbWZ3Y2VvOGwvU1RlYjgwV3RoRUcrLVRwdGU2MU9iQWNvWCstVldCZ2ZU?=
 =?utf-7?B?OTU0RGJrcTFTeGJWWnFhelpHdWFMcUtuOHVMZElEbGxjMTZCelJFenRUR0pN?=
 =?utf-7?B?VmY0aFZ4Ky1hTTdaaHhIaUFWaGUxMlJ4NWVEUXpMVm43OXhheDNBVE1zVktY?=
 =?utf-7?B?a20rLUtYNkhBUlhjMzd6TTZrS3lnckdFN2E5SW9tMWhaMEFpR296VXdEM3Zk?=
 =?utf-7?B?WUFjWUd2THRlQ21oWFJBYjZQcDlNSGFMY0FEc2x2WjlQU1BUYkhTWEU2dkhE?=
 =?utf-7?B?MjlCWGFveEVIS0VvZjhXME9SaktCL3NNcmJCL0VnaGN0OFBKcXI2WXNyZ3hj?=
 =?utf-7?B?WXBKMm5xOFN6R2t3TUMwaHl6dldqc2ZZOFVNQlVUUzJKZ212RlBZbllrdGNG?=
 =?utf-7?B?M2o1TTB1ZklhdUl0QVNQNWRtakJBb2JxcThPM0NCb3pUZHZTVkxqSGxhNDhQ?=
 =?utf-7?B?UW5GUDkwVENoQlBTNFdvT2RCOVlPQUZkMmQ2c2ZXOXVoV29LcEw5dThZaEFa?=
 =?utf-7?B?bVlsR1lhS2dyUWtwbistWkprRlFFQlhCOUxFQWVscUFUU1Y0Ky01Y0I5dmhI?=
 =?utf-7?B?SE1RZHNkcjRNT2RiYW1raHdCNGcvVHhtNDl2MVAzUnozZjMyR2g2UEJFSzVP?=
 =?utf-7?B?VW1Gb1RYeFhkMXJJQks0SXJyNm1ia2Y2eHZTaHFsR0lzZ2FoczE3ekNUNist?=
 =?utf-7?B?NFNyZndoQkJhYlFQRVJGMUFCNm0rLXdpRjB0L3hiZnBObXBTenRIdXg5WnNY?=
 =?utf-7?B?YmxIRFY0azlLeHBXLzk4R3dkNndnKy1KZE00OHhqU0wxcXNyUkF4M3RhQ3Ja?=
 =?utf-7?B?U3JzeEFaMUxGai8zUDI3TDdHOXBwNWttSG5DMUhhdGY3TG5TZUZYNXVGenRU?=
 =?utf-7?B?bU1rYmNNN08xMUROeDBEUXh6Qzh3MnZxKy12ZkZzdXQ5STRsc3BSTjhhaTdI?=
 =?utf-7?B?OTNPVUZ1RSstREFYYmd3Z1poaEZFTkc2MWtXenptTXhYTmFibWtGSGpRMms5?=
 =?utf-7?B?cUw1aFNjaHp1T0dDV2ZPenRGZWpaV0VxQld6TUd4aHdaZ1pKTHVxZ0daNVZY?=
 =?utf-7?B?Uk5iemZXVDl2bHpoY2F5SHV5RVhkWm9LLzFWY0xWWi9Qd0xoWG5meUFzTWw0?=
 =?utf-7?B?aFJCQm5jWS91aldqcmdTM3RRTkdZUklRbjhsWjdoZ3JUM050d0ZiUk5IQW9Q?=
 =?utf-7?B?czI1cHMwSDBEN3R2V2F5YU1jZk9XQzducm1IL29pekdDUko2bWhlY1ppalc5?=
 =?utf-7?B?THc2VXpOU2U3M29HVXhTTXBFd242cGdiQ0lQRHZxNXBTMUcvbGRXaW0valNy?=
 =?utf-7?B?NWt5MUh6aG1tYTQ2amdFeG1adlpqNXNFOThSRS9ENUNxOTQ1NWJuOEFIVkZv?=
 =?utf-7?B?UjNtV3U5T2lIOFFqbFZIa3didURrZVhqcDlYZ29pSDVsSFlNWDZYdFppL2Zl?=
 =?utf-7?B?RElGcm5haDNOMGlPbHRBTEZKQ0xFVU5ENmJYVGc1Z2F0QzM0NFEvWk1OSWJB?=
 =?utf-7?B?QjBXc3VvdWRPVkJKMFpCamNOa3pjNWNaaG1zNzJrQ3VPcmwxV21WZzEveE12?=
 =?utf-7?B?YVI5TC91TU5aMjZGdE40cmkzMUpvTFN0eEVWWHR2NzFXekpYcUd1WURIYkZX?=
 =?utf-7?B?QTVqVUdBQ0ptUistUWxwU2tjRHM3ZTZ1Ky1UQXlDMHVzOXBMS2RNbmpEc0RH?=
 =?utf-7?B?M25vcVJraHJhWTI3SHVTazVHMGNqdGROdlhaTTFmaDRLZmdIRnBBbA==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf177bd-ed64-4d58-702e-08de2bf395da
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 07:23:52.4129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c4JEUVLoS3ODnXfWzxSV6SoBkC5nwfWj+vhAhoi4zepu6qGpc2QMrUOWTkNIFQz8h6C4eMoWTjSdK2s7Ae+sCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB5571
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220053
X-Proofpoint-ORIG-GUID: Wj3z8IDRQVuZYaqX7ChVDa3sEFfL83OB
X-Proofpoint-GUID: Wj3z8IDRQVuZYaqX7ChVDa3sEFfL83OB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDA2MyBTYWx0ZWRfX7xLCMXkgnYpL
 9SoYsRNeyQrQcQuMNwJkuS5JGIINFbogMDEzdKaqCivfD40cUft1D5VUvMG1blEaGpzYN46jkhe
 3gnwlyD9PFn9JxoPCrnndQq4TuLif7GN9iT4rOR04jK3VfP3okdu8sqijG23EGwBj1Qf5LsIoxD
 MnU3HxzGs9ER+SPZQ8s2PoyGqaYKTgoeBgnQ4mEE7LP/wpaG/y3chYXn0v741J4irIxVMhNhCev
 dSfpgUa3mFqsLeJxNJBFDJ4Ztb/iNtPbdWQAWAPrIeL2tihcqsnNEe5SYYndCQV7cMZVSi/xhQf
 ro3wiiTgXxlRH4pDnqzbsn0wDg//0UK9W9sQFu8tPYPwJ6s+TAoMEvDt5NMN06DyeNNm7kn1LXV
 XmGTJ56oEn509MLhlufMxog0aOySMw==
X-Authority-Analysis: v=2.4 cv=ZNraWH7b c=1 sm=1 tr=0 ts=6925598f cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=WHA7p3QWcFAA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8rWy6zfcAAAA:8 a=uherdBYGAAAA:8 a=QyXUC8HyAAAA:8 a=iLNU1ar6AAAA:8
 a=XFJw1KJJAAAA:8 a=eSb-bNSJAAAA:8 a=LfxEVeEBAAAA:8 a=eJd5l47vncWl_EXZqaoA:9
 a=avxi3fN6y70A:10 a=aV_cevuMhtcA:10 a=gbU3OgOOxF9bX48Letew:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=DKZDSSD9H29Cdu8kcpdD:22 a=h7YW-pclpbZRD8svLbQ0:22
 a=7k9nRlTqVbDGZ3p5_T00:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 impostorscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015
 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220063
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

Dear Fengcheng, Maxime,

When I look at the test results below, I see that one of the tests +ACI-tes=
t+AF8-checksum+AF8-offload+AF8-with+AF8-vlan+ACI- failed. However, when I n=
avigate to the actual test results page - that same test shows passed. Coul=
d you please share your thoughts on this ?

https://mails.dpdk.org/archives/test-report/2025-November/931175.html

Also, any thoughts on when my code will be merged to mainline ?

Regards,
Pravin



Internal Use - Confidential
-----Original Message-----
From: sys+AF8-stv+AEA-intel.com +ADw-sys+AF8-stv+AEA-intel.com+AD4-
Sent: Thursday, November 13, 2025 9:48 AM
To: test-report+AEA-dpdk.org+ADs- Bathija, Pravin +ADw-Pravin.Bathija+AEA-d=
ell.com+AD4-
Cc: daxuex.gao+AEA-intel.com
Subject: +AHw-Smoke +AHw-FAILURE+AHw- pw(158765-158768) sid(36689) job(PER+=
AF8-PATCH+AF8-BUILD17274-20251113210704) +AFs-v5,4/4+AF0- vhost+AF8-user: F=
unction defs for add/rem mem regions


+AFs-EXTERNAL EMAIL+AF0-


Test-Label: intel-Functional
Test-Status: FAILURE
https://urldefense.com/v3/+AF8AXw-http://dpdk.org/patch/158768+AF8AXwA7ACEA=
IQ-LpKI+ACE-jCHbWxKxAWgIg6OQEvPP3-yCEWdKOlDUFrlDl-Njivh4rgNkJqRj9YFVVY9hRHo=
crV4lnvkjjvMMC85WVA+ACQ- +AFs-dpdk+AFs-.+AF0-org+AF0-

+AF8-Functional issues+AF8-

Submitter: Pravin M Bathija +ADw-pravin.bathija+AEA-dell.com+AD4-
Date: 2025-11-13 12:44:22
Branch : dpdk-next-virtio
CommitID: 6b37c26a95

Smoke-Testing Summary : 31 Case Done, 30 Successful, 1 Failures


OS : Ubuntu 24.04.3 LTS
Kernel : 6.8.0-71-generic
GCC : 13.3.0-6ubuntu2+AH4-24.04
NIC : Ethernet Controller XL710 for 40GbE QSFP+-
Target : x86+AF8-64-native-linuxapp-gcc

        Test result details:
        +------------------+-----------------------------------------------=
-----+--------+-
        +AHw- suite           +AHw- case                                   =
           +AHw- status+AHw-
        +------------------+-----------------------------------------------=
-----+--------+-
        +AHw- checksum+AF8-offload+AHw- test+AF8-do+AF8-not+AF8-insert+AF8-=
checksum+AF8-on+AF8-the+AF8-transmit+AF8-packet+AHw- passed+AHw-
        +AHw- checksum+AF8-offload+AHw- test+AF8-hardware+AF8-checksum+AF8-=
check+AF8-ip+AF8-rx                +AHw- passed+AHw-
        +AHw- checksum+AF8-offload+AHw- test+AF8-hardware+AF8-checksum+AF8-=
check+AF8-ip+AF8-tx                +AHw- passed+AHw-
        +AHw- checksum+AF8-offload+AHw- test+AF8-hardware+AF8-checksum+AF8-=
check+AF8-l4+AF8-rx                +AHw- passed+AHw-
        +AHw- checksum+AF8-offload+AHw- test+AF8-insert+AF8-checksum+AF8-on=
+AF8-the+AF8-transmit+AF8-packet       +AHw- passed+AHw-
        +AHw- checksum+AF8-offload+AHw- test+AF8-rx+AF8-checksum+AF8-valid+=
AF8-flags                      +AHw- passed+AHw-
        +AHw- checksum+AF8-offload+AHw- test+AF8-checksum+AF8-offload+AF8-w=
ith+AF8-vlan                   +AHw- FAILED+AHw-
        +AHw- checksum+AF8-offload+AHw- test+AF8-hardware+AF8-checksum+AF8-=
check+AF8-l4+AF8-tx                +AHw- n/a   +AHw-
        +AHw- dual+AF8-vlan       +AHw- test+AF8-dual+AF8-vlan+AF8-priority=
+AF8-rxtx                      +AHw- passed+AHw-
        +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-filter+AF8-config=
                           +AHw- passed+AHw-
        +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-filter+AF8-table =
                           +AHw- passed+AHw-
        +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-insert+AF8-config=
                           +AHw- passed+AHw-
        +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-random+AF8-test  =
                           +AHw- passed+AHw-
        +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-strip+AF8-config =
                           +AHw- passed+AHw-
        +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-synthetic+AF8-tes=
t                          +AHw- passed+AHw-
        +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-tpid+AF8-config  =
                           +AHw- passed+AHw-
        +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-stripq+AF8-config=
                           +AHw- n/a   +AHw-
        +AHw- jumboframes     +AHw- test+AF8-jumboframes+AF8-bigger+AF8-jum=
bo                     +AHw- passed+AHw-
        +AHw- jumboframes     +AHw- test+AF8-jumboframes+AF8-jumbo+AF8-jumb=
o                      +AHw- passed+AHw-
        +AHw- jumboframes     +AHw- test+AF8-jumboframes+AF8-jumbo+AF8-noju=
mbo                    +AHw- passed+AHw-
        +AHw- jumboframes     +AHw- test+AF8-jumboframes+AF8-normal+AF8-jum=
bo                     +AHw- passed+AHw-
        +AHw- jumboframes     +AHw- test+AF8-jumboframes+AF8-normal+AF8-noj=
umbo                   +AHw- passed+AHw-
        +AHw- rxtx+AF8-offload    +AHw- test+AF8-rxoffload+AF8-port+AF8-all=
                           +AHw- passed+AHw-
        +AHw- rxtx+AF8-offload    +AHw- test+AF8-rxoffload+AF8-port+AF8-cmd=
line                       +AHw- passed+AHw-
        +AHw- rxtx+AF8-offload    +AHw- test+AF8-txoffload+AF8-port        =
                       +AHw- passed+AHw-
        +AHw- rxtx+AF8-offload    +AHw- test+AF8-txoffload+AF8-port+AF8-all=
                           +AHw- passed+AHw-
        +AHw- rxtx+AF8-offload    +AHw- test+AF8-txoffload+AF8-port+AF8-che=
cksum                      +AHw- passed+AHw-
        +AHw- rxtx+AF8-offload    +AHw- test+AF8-txoffload+AF8-port+AF8-cmd=
line                       +AHw- passed+AHw-
        +AHw- rxtx+AF8-offload    +AHw- test+AF8-txoffload+AF8-port+AF8-mul=
ti+AF8-segs                    +AHw- passed+AHw-
        +AHw- rxtx+AF8-offload    +AHw- test+AF8-txoffload+AF8-queue       =
                       +AHw- passed+AHw-
        +AHw- rxtx+AF8-offload    +AHw- test+AF8-rxoffload+AF8-queue       =
                       +AHw- n/a   +AHw-
        +------------------+-----------------------------------------------=
-----+--------+-


DPDK STV team
