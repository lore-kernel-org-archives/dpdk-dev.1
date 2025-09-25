Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A181CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 12:34:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B81A940698;
	Thu, 25 Sep 2025 14:34:35 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 38C4940698
 for <dev@dpdk.org>; Thu, 25 Sep 2025 14:34:34 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1qJR3009534;
 Thu, 25 Sep 2025 05:34:33 -0700
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022116.outbound.protection.outlook.com [40.107.209.116])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49cv679a64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 05:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ffg2i14CMX6WNTBZ2e4bizvxsa64A8AbQdmxBtKQRpdpdTUtsPdR99Vr9iifOM42+m8ylkQu3aoGU9Y9TW7F3iIPLBdK64gbfRnlWyeHWQlVNUJUab6qLqIhthFXo1XdLFEYSwZnNlER8N3ljc05ueYl7pNEUEwDt5eKGsJOmwAj0GJcIhFyzJnsxPEQ6Y0c3sIXjvXLA8zTWVtaoGf19bR95AvNW0WYH2Z1rx7q/v0E5sRBzS/lJDqSWX0aI6QVvyilXCjl3xnXz4aFwYQsQ20Xcw5aGI8+pvgZ7+PW6ECyPJGBdf2AhAzZXP5rdKK545xSGG4Hxcou/malGpFB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzN711LyqR9pY1mW8Q2hlUKU/o2MtybsWzCUUZq1zXI=;
 b=Yrj3Rz4NhJ//5lH5PJHHzz+mIILdINdMwhZAszwVcmAEF2HOgMbA68M54Olb2MOuWYEf1g2K5X5VJy+0l5VpdbpzIGxKH7GOUnq9jMo8xoel/nXLAaCvDDI7k9FMtpnC+IG0gBs+aFdDfgOy0K9oiREzZArRLcdE5yCqmuQC5PW9y2qON/GTh1K2Bu9CHz6Lr2f5bVryigXkEeZfCs2/M+o7LyphHo08JlorrwXWz5HoLHYRseuaww3pO92G08akoZZQ+TqBZIO27r4Bd5PfYTr0Eu15u09eB2uw98YARk+RhUZ36UIAtcLL7ixZj57Cv3Uyq/PnyIDE3XjCFJ9BYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzN711LyqR9pY1mW8Q2hlUKU/o2MtybsWzCUUZq1zXI=;
 b=d7qGJu9G44XfRwwhe9SaMBNi4aaUM6l6d3DrUbcxGsQTBZm4ZP/o//jAJ++V71f2TJemo2S9+ORYtDfqOKZJjjzNE+eApNyhWq7dpsFe7AuHGX+a//qT4vXPGbFZPE5dXDLtdGaagO9JT9TGO0dDCDseQmh2weoo79kuTKiHA5s=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SA0PR18MB5256.namprd18.prod.outlook.com (2603:10b6:806:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Thu, 25 Sep
 2025 12:34:26 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 12:34:26 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "bruce.richardson@intel.com" <bruce.richardson@intel.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, Nicolas Chautru
 <nicolas.chautru@intel.com>, Thomas Monjalon <thomas@monjalon.net>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ori Kam <orika@nvidia.com>, Anoob
 Joseph <anoobj@marvell.com>
Subject: RE: [EXTERNAL] [PATCH v4 2/7] drivers: drop export of driver headers
Thread-Topic: [EXTERNAL] [PATCH v4 2/7] drivers: drop export of driver headers
Thread-Index: AQHcLhhyC6qCBUU030iiREx8H8RV+7Sj1SJQ
Date: Thu, 25 Sep 2025 12:34:25 +0000
Message-ID: <CO6PR18MB44843928B9A44E66A5BFEA90D81FA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250925123150.3063298-1-david.marchand@redhat.com>
 <20250925123150.3063298-3-david.marchand@redhat.com>
In-Reply-To: <20250925123150.3063298-3-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SA0PR18MB5256:EE_
x-ms-office365-filtering-correlation-id: 229ea4b2-77f9-43ac-7870-08ddfc2fdd20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZHBUWGllKzZ3a2xPS3U2V0RwbDNxNVRlMUlsQWh2RHVDNWZYU09IQU9Odnpn?=
 =?utf-8?B?dUpPcktaZlBnZXdZbWJFSkhlZW9WdHJLdmljKy9SejdpM3dwb2lPa2NqNzBI?=
 =?utf-8?B?R2dkeHdjRDUvaXRyVUF0SGQvSU85RlErZlFDRzVFdEcwK0c1QTVqa0xlQXZI?=
 =?utf-8?B?dUY1ekhBQ1dDZFgrc2VMRDZmeUd6SjYySVF3ZW84UUpsT1JsQ1h5VHdXd1Ur?=
 =?utf-8?B?aU5IWEJwWjkzTXh6T1ZXOHprL0RCWlAxSE1vOGpvVlhmUS9VU2wwcUxJTHFs?=
 =?utf-8?B?REMvNzNvb1dUc2tuNDAxc1FtSWczUEk0WkFMd04yT2FESnpJNnVid1RGUmNv?=
 =?utf-8?B?Wmx4TXlDY0VsaVNGak1kYkVSeEhBUzY5VHlGQi96c1lQd0FLNTVENkNoa29V?=
 =?utf-8?B?czJiVm9uZzlycmg3OG5kR2FubURoeWlLL3MrVWFwMGY3Z3NoN2lDR2wwK1ps?=
 =?utf-8?B?NHgzTDMzSXlKamFZbFVVVmRUNjc0WXorS21XcjE2Z0JOajdINnRCWGRidGFi?=
 =?utf-8?B?bzByeVR6VWlITURCTjlLZG5XTm9wVkpDWllVOENZQktOQUI0TVVHYXNjYzNh?=
 =?utf-8?B?akxxdEVSMVpZM0trQldyZGd6Ry84bSt6VFhQcDJyV240cnlsNWpZclRuSWlI?=
 =?utf-8?B?YnlZNS9OVCt3em1vMVBYY0F3U1ExVEVuZjAvQ2o3QUtuYUV4eEpVaXFzakps?=
 =?utf-8?B?NDROejVUSVNMbmpvb0FpYUQzMGh3TjV5MjN1Yy9XWW9mMlZoUitidkpFTnNj?=
 =?utf-8?B?SitKUkN4UFVveHRRNjNLYkQ1ZXVwUnhsaGF0cmRTQ0o3UUpBREw5ZStNWVRZ?=
 =?utf-8?B?aFpRUEtpc3ZVaExuTkwxNi9tS3M2U0tnaW9maVhFZUpWQ25mdVQ3VThkK2ZQ?=
 =?utf-8?B?TlRzbTRsbk1lbVNMTnUvc0hqNC9OR21WL3FYTTRKZGh5VWVtSm9pOFN1UzE2?=
 =?utf-8?B?K1QvY1M4WXNQc1dUSCs0MlZUTVVZOVRHRkMyVDF1ZWMwWVJnU0s5WjJqYjhI?=
 =?utf-8?B?MDdacyt4akpNTGZjTFA3aWxQNjVzdmJveDNUUW5jblJNM3NDZVE3Y2tCanZO?=
 =?utf-8?B?eU9xNWdzSm5GS2c5cTZGaFJnVFh6cDYvZ3F4Z2toSDlWQi9rYVdoVk9WUW56?=
 =?utf-8?B?WGgvVW1PNlFVQklMT2RRTzRSYWtnS3phdGJQQTFNSCtOSVlKWkc1WU1hNW1I?=
 =?utf-8?B?T3FvR2wzU2xGc1JqejR1Wkx2OHNldUZPTDFDb05TcmExTytQK2d3Y3plTEY0?=
 =?utf-8?B?T2RoRkphWGx4aTF3djhMR2V5Si9RZThib2tRaWlRbUlsU0cvU3FuaSsxMTRZ?=
 =?utf-8?B?K0xKeHhHSTA5anM3WFZWd2tkVFZIdFJldmtwUVRuZkxZNnlwQUdqdWdXOWVQ?=
 =?utf-8?B?RjcrVWFQYlE3c0N3MGt6N0Z3NkluZnJWWExmNVlZMUs2d2VFamxQeFlQNk0w?=
 =?utf-8?B?NzRKdWR3K25Xdk1ZNHdYRGo0aXRkSG82NVVMeFNuTE5MWis1ZjB5UmNnamlK?=
 =?utf-8?B?RGp4QllFWE93dFh0eEJ1K2puZWNBOTJ5aVBEdlB0ck44R0lxMy9aQmE5UFha?=
 =?utf-8?B?TDV2MlhRTHdmcXgvQTAweW1MdWp2SHYvZm1nRkMzWWxDb1dDLzZOVjNBRzlq?=
 =?utf-8?B?dExNVHdNMERUZisvSGFwbUxsNjRvcmw4YjdHcVNqUmdlUTRYZ0xtcFR3VkMy?=
 =?utf-8?B?Y05HRTYxWC9TWG1Md082aVR5OHVLUlh6ZFNzcG1oT3hEekZPQThDdDg3a3VF?=
 =?utf-8?B?aXRSdzZQbEJmS3d3ZjkrVHEvYlNRUEdHSmhSWFdUQ2E1UXJqekRmbitwNGJZ?=
 =?utf-8?B?V1dqZjNrcFNBVi9NcXUrVzc3WHpsOUtrTUpHMy9TbktRRUI3cEpuM3VoZW1z?=
 =?utf-8?B?MnZLQ2lmaU1LT2hQbTB2R2pEZ3FYT0FYbnZZemxjMzVKRVRQcDloN24xVVNE?=
 =?utf-8?B?TnhQVHp3MWJIT3hjeEhVaTMzMHRXcFgyNGZHUDd5UFVTYmdhU3AxT0U0RFFs?=
 =?utf-8?Q?GIuu7988ez2Bhb+lLmENHnE7H5xZIo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzZqRFkrdkRJUi9ZUU1DbnZweE5mYlJzTllMdHFMZDJnK1NmWnYxK0lpYkhP?=
 =?utf-8?B?WXZQdEpMcU9kc1lOQnFWWVJBcW5OdHlhN2FDaXhWb0t4VU4vYUtEZ0JCU2Fi?=
 =?utf-8?B?RytESTNZeUhMQnBJVFJGNVF6VTRuQVFzL0hRdGYvOUhGbE54a1QrYjBZWjZ2?=
 =?utf-8?B?T3pqRHZMMExCWVVCaTlweHM2dDdjNDFEbnBVeHJyQ2xjbHQza093KzhJTG9m?=
 =?utf-8?B?ZmV0ek04U2F0ZXdic1RSTDZwR1BxYWtSMGJXNnVnVEdXbHQ0MjNJZjUyQTlx?=
 =?utf-8?B?Z0RKQU4zQUw4QVA3WXZzc0tYN1ljOW5UWXI3K0NaNys2QmVwWVptT04vSHp0?=
 =?utf-8?B?NWVCaGdzcERJbFJoSG1rNkYrcXBzQ20rSTJ1VXNOU0hncXhlNGdXbEMzZkhm?=
 =?utf-8?B?U0UrNEN6NzJBSDFlc1RSTHJhUjhVOWtJWm5qa0FHbldJN0IyN2dPUTVyMXJi?=
 =?utf-8?B?WEhqMEUxYUREWWhuT3lCTHlFemNSVjVlbk96ZjRBWWxaOEZGRUl5U2p3MFFj?=
 =?utf-8?B?MWRjbDlYNkJMc1FYVDBhZWdkcm0yQlN3M1Y1VDNHTGFLc3pPczQzUWwyUTZT?=
 =?utf-8?B?V3ZaaE4yR3BSR0dCQ2dxa3ZiZTNzK0pqR2xqcFVzaEd0N2VhK3JXUU9qWElo?=
 =?utf-8?B?MXd4OGlkT2ZYWHViQzBrRFdKQVdnaWNzcWRzdFRjSkZGVlltQVRGUWdTRW1i?=
 =?utf-8?B?TEVTOW1vaFpFV1NiUU5lenpKZDZQL3VCMnhRRUdkNHBDcWlKVTBCVUlXMFp3?=
 =?utf-8?B?WFRhYkpNcllISzhiMDR0dXhnN01sVDBlT2JpdGtQOC9ML1AraGJqR1oySDZB?=
 =?utf-8?B?SUxTdmxpZm1sdzNaNXN6ZDdTWUpZeEFtVzdtdnlTR3VleE80UTNKVGJkalU1?=
 =?utf-8?B?UXRENlNQbUw3anVZSFY4Y1VuSzVGb0IvMFR6MGJ0cHlmSDcwT29KdHByaGpK?=
 =?utf-8?B?aHRZb0g2U1JnbkpqZVBIYlF2bXoybG93ajc1ZkxnVFp2RFp6NU1ULzlUTGRt?=
 =?utf-8?B?TkVTeEVLUUFiK1NabldZL2h0Q0lvTU8vY2wvZEVnWER1amtuZHluVlVQb0tI?=
 =?utf-8?B?bkVla0Q2WWtNWWpNQy81OHg4bFZ2SDgzQTkrMWJURFRoNHMwaXpZUllnSHhz?=
 =?utf-8?B?dVlSTFk4Vm83Q0p0cmRuVnhqa3dQSGx3cTNwWlo0MkFzQ1g3NXY5Wnh4RlJN?=
 =?utf-8?B?TkpDendEUlFqWE5OV2xhWlRkZW9lc1VWUlRjQnpIU1pHUHdldlM1SGlqM1hx?=
 =?utf-8?B?Yi9oTDBlbjRFRUxUUDZnbjlvTTZ2ajh4TmsvNUNVazdTWllxM2o5QWxua09W?=
 =?utf-8?B?L3lFYnlCdUtNRTUreG5kWUpzYkR6S1BXQWhEMER1MVYrY0NaRkxTMm5teDBG?=
 =?utf-8?B?VmNjR0xMMEhvQmViR0o4NDlLK2YzTnZWS2Zld3NtaG9uV2owR3NNblhLOUwv?=
 =?utf-8?B?bk1Ub3M5MXVPRXpRYTF0YTV1ZmxKd2lTckZQL0NSNENsTDV2aGV4NGg3dHlh?=
 =?utf-8?B?dEZ0cFZNSkl1N2xlQnY5NC9IdG5KK0V0VWp6U2xPZTRlaEhhaDhBT2JNdWI1?=
 =?utf-8?B?QW4vWmpiL3VLYnc2bTYvL2g1aGhLaSs0TXJhUXM3S2pLMUVUUEl3Sk5GMWsz?=
 =?utf-8?B?V3o4bkpyaWZ0bEtDNXN1dkZQWTJ3OTl5ZVNZT1E1RGRnTSt2Tnk2RXFKTnhE?=
 =?utf-8?B?VEI3K29EcDcwOWE0dVRaM3NVM2M0Vkd0WFhCZDM3ejZDL2xJcVpUKzkwN3lR?=
 =?utf-8?B?U3N0aXhnYytGSHVhOEhkWTZLUU5hMkgxRkhrMms4NjFaMTFpN0w1OU9UZWdq?=
 =?utf-8?B?OVdYQ0JTckphcnJFc3pHa3dtWXFyZFduRVFKLy90YXR6WjVJNTBCUXUyWE5H?=
 =?utf-8?B?SE00c2RudHUwekJUQU9GWFlPdUxIRDZNcFlvOU4vMEs0dVFwLzZ6ZGY5Z3k1?=
 =?utf-8?B?RWVSbzRTNmdOZmIxeHFpSEEvQzRYY29LY1YvcUFJWm1RdVBwS2RFVnhyZEYv?=
 =?utf-8?B?bFR2L3FTMUZPZTd0Mi90Zm94TEZvL1c1NWtGckEvNTQvVnJ2MytNT2VCcWVQ?=
 =?utf-8?B?bDN3TzVzR013NnZTRW5kZTRxVEVacEx3TDdkUHNVWVVobEJsOXUyMGdOVS9J?=
 =?utf-8?Q?vtMmVU1CSvxI1rhHpT4uEXpNP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229ea4b2-77f9-43ac-7870-08ddfc2fdd20
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 12:34:25.9612 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TxTqGTz/esx1Sf+qVVmvpY45OX+KhzFg3ex69hW6YGA4GAl6M0XFdGS86WM5e7QCoAO6t6eWIDzCMmCRVcuz6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB5256
X-Authority-Analysis: v=2.4 cv=Vef3PEp9 c=1 sm=1 tr=0 ts=68d536d9 cx=c_pps
 a=vxZwcVCzN9PDTeYEjO2tJQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10
 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=pK7X0mNQAAAA:8 a=M5GUcnROAAAA:8
 a=f0YEJ-T3bFA0EO034B4A:9 a=QEXdDO2ut3YA:10 a=5HA-qpC1VU4iIGLgRoNS:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Bpxe0X8lK_uJvpUlm6KSFItQsnx1kSLU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDAxMiBTYWx0ZWRfX5M1pns4QMlyu
 YrcWsFnX7f1E3Rtj9YY4UA94nVFC3QbRn7S/JuJqIldYvF1+r0twmVajvLYYjzcsmQ9m6UgyAAF
 Cm3uBxz8aTwB0FEGkZ+zfIx96MpEWwM7HGUOz2LExOxR8N1IToEzlYHdLHR7NtbiXyv2b74lwrI
 Mb70gS/pbP6ac53KbYeAJUGLeQ+pa0tiyYnl+CZuVASDwerefJvP8qnUWmrcFOIfOObQGpJ6zPA
 eHjJ5YIH4BJziEUJWxUzCdqDwLLt4HTji9ox1rZuG0pMzvKAwcY6NbZnci7kvZakaA8PIpzY4gv
 aDYqgnWF0sCXC3gu14xuixcrtNaPZ/lViYFYwnKguQksSrc3BcH8E/2YGcTooYGgL6SC82CNyaq
 H/2kor6N
X-Proofpoint-ORIG-GUID: Bpxe0X8lK_uJvpUlm6KSFItQsnx1kSLU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
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

PiBNYW55IGNsYXNzZXMgYXJlIGV4cG9zaW5nIGRyaXZlciBvbmx5IGhlYWRlcnMgYXMgcHVibGlj
IGhlYWRlcnMuDQo+IE1vdmUgdGhlbSB0byB0aGUgZHJpdmVyX3Nka19oZWFkZXJzIGxpc3QuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBNYXJjaGFuZCA8ZGF2aWQubWFyY2hhbmRAcmVkaGF0
LmNvbT4NCj4gQWNrZWQtYnk6IEJydWNlIFJpY2hhcmRzb24gPGJydWNlLnJpY2hhcmRzb25AaW50
ZWwuY29tPg0KPiBBY2tlZC1ieTogQW5kcmV3IFJ5YmNoZW5rbyA8YW5kcmV3LnJ5YmNoZW5rb0Bv
a3RldGxhYnMucnU+DQo+IC0tLQ0KPiBDaGFuZ2VzIHNpbmNlIHYyOg0KPiAtIHJlYmFzZWQsDQo+
IA0KQWNrZWQtYnk6IEFraGlsIEdveWFsIDxnYWtoaWxAbWFydmVsbC5jb20+DQo=
