Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C50BCD4F3A
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 02:13:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DB6040670;
	Thu, 13 Nov 2025 03:13:12 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 45AE940151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 03:13:11 +0100 (CET)
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACJfkZH014060;
 Wed, 12 Nov 2025 21:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=l
 ikEDUvMg7XtkOwMlLco8pmJmSAl93bySfxLS9ocoRY=; b=tgNwY4lH3NLm4zqv/
 XaVwleVKNtVeFqB1QQme7ZNhPULy9VUZG4KFEK2rswEqty9oTOWKLPghtoVhMHfe
 H4j8rLdje5Rb/Mr9ijyzUX17ElS2AkqQ5PoQwxUg/boWVEM4or+lyhi36/ZWRfEe
 0VERtznli7NF2LBJ3KbBJ5L6x4H76721IbOvOLVCliXx5XYo3lDwq4wbFbhll7AK
 CK7Vdl61mzACzZ3OxnoHSdW+4tzlG4JrfO2eJdJ4MVrlqgUWMb/lbN4nQy6XUy7d
 9B+95Bdk02mSPYExHftMyrUSZxr2wojPc2Pbcf9jkRLlegLSF0u9NCDpr7hZcwNc
 Y/geQ==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4aa2k2y7q1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Nov 2025 21:13:10 -0500 (EST)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD21E95027807;
 Wed, 12 Nov 2025 21:13:10 -0500
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013071.outbound.protection.outlook.com
 [40.93.196.71])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4acxs86aqu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Nov 2025 21:13:09 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2tYMeTXhgrl5Z6EZe2k6vTf4m9V6OjEqdvCMNWkoaBLFVTGFUl3EVBVgd1AEpJCxMTgOibPekB6t3TseW/9WJg1P8pcBsMmF5YeUHMONq+lVgsavh4NhUxs//jSuMW230E+Aok9JVAPKIam4yxF88+ypGg+rS8IeitmhqYVkc8T5kNi1CfVZbRwiPO1eRza0sRYaod/4cqG5prAkcny2UPLOVW67V6H05Z1aGKna/wEaqQam8fzjrmJs2cX0XygUIYGSLNg9yHR8wNbpSsVYVDZp8Z5Ns/mXEvvMGPvMJBJZLwv35t4Zexo6hRe8v82OfQorlqdrg4ABpOOpPVswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=likEDUvMg7XtkOwMlLco8pmJmSAl93bySfxLS9ocoRY=;
 b=Y+Cy7NWr0yc8MjUkH7MEXFDtWgf/PLfgKRggReHUUShJrvVYSWHSuOxAQ/eMhtM65UmT9JBWNO769wvC9lS6n+9MZkTq1JRLdyzhTEndOBPf6lnnPyPdNdk/BwT9xfTvnUFlnjlMJPDH+r6qXiHzEzV+SG6kL9TQob23jWfYmVrpcO5jX/WvzIitDccFiOH17t9SI40El7Y6b8oHsPYAmj1nMs0JBXbqvLg9OVZua8XiBQ4tLAnJbsircLKWI0sL8S3rVuWj8GLUdmQVN/TTAZcgzKr+m499++MeNSuV6wR/c+Cu1NtJKYSp/WZlsjo1AfTbbjbxZRtrNCLz46lymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by SN7PR19MB6945.namprd19.prod.outlook.com (2603:10b6:806:2a1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 02:13:04 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 02:13:04 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: fengchengwen <fengchengwen@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "pravin.m.bathija.dev@gmail.com" <pravin.m.bathija.dev@gmail.com>
Subject: RE: [PATCH v3 5/5] vhost_user: Increase number of memory regions
Thread-Topic: [PATCH v3 5/5] vhost_user: Increase number of memory regions
Thread-Index: AQHcTUK2IE85u2Mbw0+mzrCeCVtp8bTiKvSAgAs3/qCAAOkoAIABnizQ
Date: Thu, 13 Nov 2025 02:13:03 +0000
Message-ID: <SJ0PR19MB4606F0D91D66F05CACF74626F5CDA@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <20251104042142.2787631-1-pravin.bathija@dell.com>
 <20251104042142.2787631-6-pravin.bathija@dell.com>
 <d7af7a2d-939a-45b3-9353-2787ef1dd513@huawei.com>
 <SJ0PR19MB46063C6E41E929271093CE1FF5CFA@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <9f38ffe8-bfd0-4af0-bf2f-f1239823c9cd@huawei.com>
In-Reply-To: <9f38ffe8-bfd0-4af0-bf2f-f1239823c9cd@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-11-13T02:08:27.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|SN7PR19MB6945:EE_
x-ms-office365-filtering-correlation-id: 22901b42-9689-4752-5632-08de225a2d9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-7?B?eWhyU1dMVVppb2F6TngyUm93dGluKy04NFh3NjN3c2grLVBPcFIrLTdsR3lj?=
 =?utf-7?B?OXpvSXc4NVZvbjBNVUJMeTdtUmdudVZ0RjRyUEk1TkFFTk1sYjBiNCstTktF?=
 =?utf-7?B?ZWtldHB0Ky1FQ2NsdEFGNmo2TU96Q25PSFRUUWZHTElwTDkwdEM4OGpTNWov?=
 =?utf-7?B?ck5yWmNFaSstTDkxY29WMVVpWXFlV1MrLWdmZ1NyRmE4NzRyUnlZZjY4YSst?=
 =?utf-7?B?bVdiWnRLNzUvczFjKy1NMHRYc2lmaGJKUFlORVQxcHY3L2FPZU5paTZvTi9M?=
 =?utf-7?B?Vy9EUkhNWTJsTGVheUVWQTVBSmVCZjgxNG0wbXNNQ0xaNjAxdi9uZWJPQUhh?=
 =?utf-7?B?SFhEYjRHN3hSODByRS8zaUx2djhERVdCWThjUnBhWHlTeVJhMmRNKy1OKy12?=
 =?utf-7?B?UUV5cU1LUFRZNDN5UExlSDBvMFBuU3VFQk91bkdBSC8wakdlaHRpTW9NVWlt?=
 =?utf-7?B?eEFLL3BYVS9LN1ZFUEpoSVE5S1l4YkdMaURhVlhUSHM0RU1uc3F0YnptcVdU?=
 =?utf-7?B?QkRaZ1FHNUlSLzlxQjdBVDRFZGR2MXpOSThmblRMZjZZUU1lRHJuaXpGR3pn?=
 =?utf-7?B?RTVURC9UU200OXYyLzVuSWpkYllmdWVWb2pnWXZXS2VIejlaMms2R0lFVVhx?=
 =?utf-7?B?YmtKa2N5NktBWEVLaGV2Znoxbkt4ZkNEVjF0QkRtUWRUVVlPS1BFdlhOM1FG?=
 =?utf-7?B?UEEwQ2NITS80MW5ZbS82c2daTFR4eHJ3aklzY1l0T3I3NENGcjRXUVdnZmRz?=
 =?utf-7?B?R2xvdHRkM0hVUUMzY0hZQWZjWEFnT080Ky0yWVJIKy1MTVVKS2ZIaU9DM0N2?=
 =?utf-7?B?dk5ZODVTYkt4RG9LNFA2aDloeDlmaHdtZlU4TDVXWlZiWTI4MjBQcVhqVGRV?=
 =?utf-7?B?MHcxTmNzWk8yQXc3TVVGV01TWnpYaGMrLXZOem1qNE4yLzV1V3JJanRaY2M4?=
 =?utf-7?B?bWxaYlFOaUJBSGxkdDV0OUhRODRpa0ZDM3pLS2VUNndISE5LRjhJcnFndDg=?=
 =?utf-7?B?Ky1rSlNPREZxeUZKd2RwYkVJR3NtNDRJMEFDSU5hTDN6T0VJQU9TVTluM3h6?=
 =?utf-7?B?OGpEUktnNEtzUktjVFBRM2tjdXpFSzMrLVhPN2JiTGMzMjRwZWVHU2hBSDdh?=
 =?utf-7?B?c2dMKy1CUWNOaGRBazhqY2E0aFBHUmI2a0hOaC9xSUJSQjhqTXdFOXN6NHFm?=
 =?utf-7?B?dzE1bGJlQThKaE5SSjVBRkRxcjh1T0tJKy1pZHFXNk5hUEpNMC9aUWd1NjU4?=
 =?utf-7?B?aFg2c25XR0hncEFVRVlia0JQQUlxTXI5SWZReHRycTFCNmVPT0lIR2p5QWR2?=
 =?utf-7?B?dVhPVGtnSXpYSGY4WlQvTjdVNVh5Y0tzMEljQ29VVm9HdDlaL3VRdzZoWjFN?=
 =?utf-7?B?akFyVVpDL1k3L3lXdXoyVlFFWlNQNXZIcGQ0NDVMbERvWmgxSU0yRmdhSkwv?=
 =?utf-7?B?cmdyZldTL0FTYkRZR0dIVmZZenlJR0VJM1hYYW4rLU9jSmM1b0FpbCstcmdu?=
 =?utf-7?B?UVZqZXFvT21Cd29CTkpGSHFRUk1RVTlhYjZtS1V3bHFOaFZVcEQxdWdkL1FC?=
 =?utf-7?B?YlVISk1pMk5Rc1JSQVgxRk82MlFmOE5rWFhjYVQweVZhOUIweHBvSlZwUDR2?=
 =?utf-7?B?NksyL2orLUEzdGhERy9STkhNNW9hMWZ0TWNTKy1IYnJsUkhDM0dLUTlnKy1Z?=
 =?utf-7?B?TmFrWWNSTGxtRGFIS2hoRGtMVVE2V2tSTEFTb1B5TVRHZ1JXVTgvQm01WkNo?=
 =?utf-7?B?MFhtTm5UeDQwUzNsdXZKNmsvWDJ4T3Bkbk5TVXVKUFE3WjgxRlEzcDJ6RWNI?=
 =?utf-7?B?MHlrbkJaVFpTbHVLc2hsVkxtZDlvRVJkb2t0UmNSN2pwRFA2N1VoSTFGeFpM?=
 =?utf-7?B?NC9aVnluOEpxbVBKM2VKVlVaZnJuZ0tNWWJJckI0bDl6VTc1RlFDVG1yYURm?=
 =?utf-7?B?MGRwKy1xcXJvKy15ZTlFNTlTRXIyT0NvbWdxWnFaNHNzTHEwNistY2hnUU1M?=
 =?utf-7?B?S20xcjBiem1tV1U0MzFTekxOWG9CQUVEeW1hZXQ1MVR3OHhzQURFT01DVkxB?=
 =?utf-7?B?MURIcWdnTUFOQ1JiYTJUQ2xQTHJDYnN2N0xXU3hDTTBp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?RVQyczNrUWFaMlFCMlMvT2FmbkNWNFN2QkpuT2Q4YnQvV21iaEhaVmNyZlJU?=
 =?utf-7?B?Z1p0aUVTaTFLQkgzaHZCOEFsZVRhT2g1bjBqM2ZmQ21sQndIeEt5WklDR3Iy?=
 =?utf-7?B?OUI5L1R2ZWNKd3VVYUl2aGJSUUdoa3NKKy1JMkhnOS9XM2NRT2EvU3NKeG9B?=
 =?utf-7?B?VEZYSU8yekxXWkgzcistVUdYZmw2TFZGQS9MdnFrR2pwKy12Ky0rLUx4WlU=?=
 =?utf-7?B?ZistU1Q1YTJaSEtlQS83eUhOSHpCa01uOFIxRGhyYTExb01nODRvN2cwTHFp?=
 =?utf-7?B?Z2ZBRVVJTmZVM3VPZEg0aW1taHlNVDFEODhsay8yMDVVTFNkN3ZqdlFtTnRa?=
 =?utf-7?B?SEVkNmwyVFBTL3UxY0tDVVFGdGozbkpqak5vKy1XaGJodjA5M1pNZkllU1hC?=
 =?utf-7?B?d3N6b0ZBOHhZQXRsWTYvUDVka3pJNUhBbm5jcGNIUkRUZnRNTTJJUjNhVW1q?=
 =?utf-7?B?VHpaWEE4U3FjeWsxcS9IWWZwc3lCcUlBVFhoKy11MVNnNjdNVHl4ZVJaVWtN?=
 =?utf-7?B?bmVvOGpsdlF1eldDU2RiU0FjOWJoeldZNHdJYkE0YUJ5VVVxWG1nWUtZVkI2?=
 =?utf-7?B?Ky0xQ0JIaHQ1ZTg4VHp2VFBOcFRvZTRobGhzY2FhVExIMVdTUDBjN3p0T1J4?=
 =?utf-7?B?aGpaenlpcnMrLU1hYnArLWwxL2cveUwzSHRhb2NqelNtSzVISkpjdDBiU1VM?=
 =?utf-7?B?THdpeVM1cGJlMURVM2grLTlFZUxVTE9vVXNrYVJZTG5rUEtPVm9UOTJmaERN?=
 =?utf-7?B?NlFJZFJvZElCM2NsN2dLeDZIbnhsZmZhV0VHUEIzTFUxYXlUdFZtazJ1VzVt?=
 =?utf-7?B?c0Y0YjhGbEphbjlQUE12YWhpemgrLTJHS1c0b2c4NWFMUzNFNnBoLy9ERk9j?=
 =?utf-7?B?VlFWcjMyS0NlSEFteGFxdzFzYXJjTHZHYjF4NW9yRTN4OFdHb1N5TmhzUzhh?=
 =?utf-7?B?Ky1VV2Rldk1IcFRWQ3p3Tnh3QmdwNUx3aUpjTVlMeUlVVjJCWjk5UHBZeGxP?=
 =?utf-7?B?bFk0SVZKdDJYZEdmNmk5blNhMUlWR3kzbDlZMy9XNHdDa3BHT3ltN2UrLVlL?=
 =?utf-7?B?VnBlMzY0cW9XNkRFS3QrLUpqTGhJYVdLSC9BYWlrNnI2VWt3Ky1OaDFWMmFo?=
 =?utf-7?B?cjd2Q3pVbFJ5T1VVbystQTNGOW1ReldISWhoaGtJSCstQU81dVRMVXd6RXdm?=
 =?utf-7?B?LzczVjJ6YnhIUTN1MWVWakgwdzhBYTZvb1ZFZ0s1cUJCRWtGOTY3TDZJalVP?=
 =?utf-7?B?ZklWNWR1ajJTYU5mSjRwRnpzWFhQQXpXc2V1bmZ1QzVFVVBSclNwdWxkRHgz?=
 =?utf-7?B?RjlGNFhxeXZpUFVsdGRwZUFVV3RiVGVIU3J2T0M0V3F1VWN5dWh1Z3h1ZTBx?=
 =?utf-7?B?QldhdTlLeU11WWNyc0lpaXdQWmxNZkxFTTlvUkx2ZS9TTDRLVFgvVUhHSWQ1?=
 =?utf-7?B?bzFZeE9QaDRCVk5HTWxEQTRaV1V3SkxvbzRTSERVM3NqMlJUWEZMcUNqQ0tk?=
 =?utf-7?B?R1hkdjJqOGgxM1YwTXY1aklBMEY3SUJFNWZLYnZTUGc2Y2dqczVxd2twZ2Z1?=
 =?utf-7?B?MWFFKy1CRGV5eWJBa2NUZFdJWFFLY2JCTnNHL295RU1YdlkvUTFKU044WGRt?=
 =?utf-7?B?bVRIRUEyZUpYa0JyR0NUWmFraTlrVkw4S1FZRk9OR1pGN3dzL21XTHpPU3J6?=
 =?utf-7?B?M3R4SHZjUG1lS1NYaEdudnZWU1VpQ1N0L2EvY1owdkJZR2s3Mmt4dE9HTjl5?=
 =?utf-7?B?V2pPajFQanQweWs1OVk3bjZ4YVM5WnN1eFZ1M042YjVuRXk3Z3pwT0trcFNP?=
 =?utf-7?B?QzdKbDBxZCstQ20xU2VkczdzWkR1Ukw5NkdsYkw4YUZNVHZyTVpxWG1wVFlx?=
 =?utf-7?B?R1BsTkEwY3ZDcHAvKy1WU3orLWV1aUduZDg0a2MwZHJYTncwMnJ2SlpaQXF5?=
 =?utf-7?B?M0l4OGhJbkxFemtRWkUvOVN6cFF4RkgrLVFTaklxWjVhSGQ5cHg1RmVWNDlU?=
 =?utf-7?B?OFY4d05xVnNxOTMzVm5pbUFxSmUzd05nQXcxUzBZWkpiOExid0RlUUJHbHpk?=
 =?utf-7?B?d2lvaW10eUN4WWxoS0V6U1FpcnZGY21OUDVRN1ZFUWQ3VUluenRiMDlTa2NK?=
 =?utf-7?B?cFNaYjNQM0JWZE42Q1pTcmVGNEl4NHQyRzR1bFVIU0pjbmpqS2lsVDVWeDdX?=
 =?utf-7?B?R205Sms=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22901b42-9689-4752-5632-08de225a2d9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 02:13:04.0101 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RyIDsNaG5fMwoUvuxRIBhYxO1Oxf0D6AM4A+YqZw8hCFgbbpqxEOPMwT0+XoYOCafsLjseoUfRsRGzW8qtNbyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB6945
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511120141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA2OSBTYWx0ZWRfXyCy9wY8JrV2n
 zZZOpud1HTQuYM84TJ+O9LCuG4jEYJzHIoImJ54LEaGWhxL+T4dyr/8AABh4W+RJhLsIrwDcSZ+
 3CcmfSv0F/1GGKPS5t6crBJEVjNGf9NW++dieRsLDB4WfzjJCSykNsoRVYKCxc/PRzBVW48OyiI
 yOV8HEzIaGcWvmtMvXWc+rAApfhwR0xioKSwMEL5p+1Cmcmz7pi5yJaShBwLCju7T8SQgXhqkN0
 +9KoGuFQbKABK4O5TDWDA8oI2MLeK9oi+f02X8UdMQB81O/siPHg4C4Zi8tonqEppNiNZEcsLGF
 tULkygHl3RSJNUHO2TZT0f6Xg6HxXTIeBXllVF4H9yF49ztvAePo9ro7FlZYAF0tvgTg7FmrnO2
 YiAyjYG8WGX6jdcmtdYQM/yeJtNEeQ==
X-Authority-Analysis: v=2.4 cv=Vbb6/Vp9 c=1 sm=1 tr=0 ts=69153eb6 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=iLNU1ar6AAAA:8 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8
 a=ytFMdNZ7AAAA:8 a=LfxEVeEBAAAA:8 a=eSb-bNSJAAAA:8 a=QEEkIeqjAAAA:8
 a=6_qfyzCTMWCZFAzIlIkA:9 a=avxi3fN6y70A:10 a=hlJyneSgMmFPbskH-t2w:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=oxySFUAvEW1-6AXleBSr:22 a=7k9nRlTqVbDGZ3p5_T00:22
 a=h7YW-pclpbZRD8svLbQ0:22 a=iapMWHAMLVzCBf0btcAb:22
X-Proofpoint-GUID: ilwaeitdhPrtpbjnGpTiYnt0Bzjgx7n8
X-Proofpoint-ORIG-GUID: ilwaeitdhPrtpbjnGpTiYnt0Bzjgx7n8
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080069
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

Answers inline


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: fengchengwen +ADw-fengchengwen+AEA-huawei.com+AD4-
+AD4- Sent: Tuesday, November 11, 2025 5:26 PM
+AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4AOw- dev+AEA-=
dpdk.org
+AD4- Cc: pravin.m.bathija.dev+AEA-gmail.com
+AD4- Subject: Re: +AFs-PATCH v3 5/5+AF0- vhost+AF8-user: Increase number o=
f memory regions
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- On 11/11/2025 7:34 PM, Bathija, Pravin wrote:
+AD4- +AD4- Responses inline.
+AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4- Internal Use - Confidential
+AD4- +AD4APg- -----Original Message-----
+AD4- +AD4APg- From: fengchengwen +ADw-fengchengwen+AEA-huawei.com+AD4-
+AD4- +AD4APg- Sent: Tuesday, November 4, 2025 12:12 AM
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
+AD4- +AD4APg- On 11/4/2025 12:21 PM, Pravin M Bathija wrote:
+AD4- +AD4APgA+- In this patch the number of memory regions are increased f=
rom
+AD4- +AD4APgA+- 8 to 128. When a vhost-user front-end such as qemu or libb=
lkio
+AD4- +AD4APgA+- queries the back-end such as dpdk with the message, get ma=
x number
+AD4- +AD4APgA+- of memory slots, the back-end replies with this number 128=
 instead
+AD4- +AD4APgA+- of the previously defined 8. The back-end also allocates t=
hat many
+AD4- +AD4APgA+- slots in the memory table where regions are added/removed =
as
+AD4- +AD4APgA+- requested by the vhost-user front-end. This also helps the=
 vhost-
+AD4- +AD4APgA+- user front-end to limit the number of memory regions when =
sending
+AD4- +AD4APgA+- the set mem table message ar adding memory regions.
+AD4- +AD4APgA+-
+AD4- +AD4APgA+- Signed-off-by: Pravin M Bathija +ADw-pravin.bathija+AEA-de=
ll.com+AD4-
+AD4- +AD4APgA+- ---
+AD4- +AD4APgA+-  lib/vhost/vhost+AF8-user.h +AHw- 2 +--
+AD4- +AD4APgA+-  1 file changed, 1 insertion(+-), 1 deletion(-)
+AD4- +AD4APgA+-
+AD4- +AD4APgA+- diff --git a/lib/vhost/vhost+AF8-user.h b/lib/vhost/vhost+=
AF8-user.h index
+AD4- +AD4APgA+- 5a0e747b58..c6ad5b76d6 100644
+AD4- +AD4APgA+- --- a/lib/vhost/vhost+AF8-user.h
+AD4- +AD4APgA+- +-+-+- b/lib/vhost/vhost+AF8-user.h
+AD4- +AD4APgA+- +AEAAQA- -11,7 +-11,7 +AEAAQA-
+AD4- +AD4APgA+-
+AD4- +AD4APgA+-  /+ACo- refer to hw/virtio/vhost-user.c +ACo-/
+AD4- +AD4APgA+-
+AD4- +AD4APgA+- -+ACM-define VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS 8
+AD4- +AD4APgA+- +-+ACM-define VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS 128
+AD4- +AD4APg-
+AD4- +AD4APg- The address translation may increase a lot if the real regio=
n is 128.
+AD4- +AD4APg- Maybe we should add another patch to optimize it.
+AD4- +AD4-
+AD4- +AD4- Could you please share more thoughts on this ?  Are you concern=
ed about
+AD4- the number of addresses and translation table bloat ? What optimizati=
on are
+AD4- you suggesting ?
+AD4-
+AD4- Because each memory region is independent and does not overlap, maybe=
 we
+AD4- could use binary search to optimize it.

From what I gather, both of your latest comments, for patches 4 and 5 are r=
elated to performance impact because of 128 memory regions. My thoughts on =
this are, I will work on an algorithm to optimize as you suggested. Meanwhi=
le we could approve patches 1-4. The rest of the implementation does not ne=
ed 128 memory regions. The existing 8 regions are fine. I put in this chang=
e as I felt it makes the system scale more and was also suggested by Maxime=
. I think patches 1-4 stand by themselves and have been thoroughly tested. =
Please let me know your thoughts on this.

+AD4-
+AD4- +AD4-
+AD4- +AD4APg-
+AD4- +AD4APgA+-
+AD4- +AD4APgA+-  +ACM-define VHOST+AF8-USER+AF8-NET+AF8-SUPPORTED+AF8-FEAT=
URES +AFw-
+AD4- +AD4APgA+-     (VIRTIO+AF8-NET+AF8-SUPPORTED+AF8-FEATURES +AHw- +AFw-
+AD4- +AD4-
+AD4- +AD4-

