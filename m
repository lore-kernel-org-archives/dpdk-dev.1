Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F6CC3ABDA
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 07:08:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BC3E4025D;
	Wed, 14 May 2025 09:08:31 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 045AA40041
 for <dev@dpdk.org>; Wed, 14 May 2025 09:08:29 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DNTOKh018052
 for <dev@dpdk.org>; Wed, 14 May 2025 00:08:29 -0700
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46mft50pjt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 14 May 2025 00:08:28 -0700 (PDT)
Received: from m0431383.ppops.net (m0431383.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54E77OoX002310
 for <dev@dpdk.org>; Wed, 14 May 2025 00:08:28 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46mft50pjs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 00:08:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sS3qZwmYlRJcgLiYZBysEKk/pJvjnJ4NJMkJ8ivulRLU2Xd7O6VBIw0OyvJrndg44g+KSH3AnOATw0kPfsZ24COdnMey9UYqfJE0rLUh7qKfBW9LTa1tU3v23n7F7VOLvN4kvqvh35e9LddIQQTwmUviX5Gbzl2LOVEqbA6v0cVI1mt1yj9kXscIemYYWnX5D6U3q97KRmIdVGiaTh2mGd/TT7O/gbCW0aoV3vb3OqKvLbN84lmx2iIsok3vw/55ljZPY4c9GNS5xrVftoGosdf19je193mAVHya9ZfNPhtM8/7GUIDVA/8Vs7DCVvpVNSE4l4pXb7d73o2rvA6Lhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEkmNyoIMMsbXitUOoE1ZfU51PoiR75xtEtbGD0KwEU=;
 b=fZFSaVvqezxIR+/O7Q9czLn3xfhvfdi1Jmbyyic3lMOWWxRX5a0wR/svA9uZw/T2o6xaPJvOuzt3Oi4WEyelJcVSlf7/Em5s8E3XaQO62k4jV0lqYmxGoUMkqzXDCXE6ZTuAhwKjReko5HiG9zbueBw35A4+guM9DHxnx2R40EZVyrI5wo99d+b8YAfAbuTnimmjTMBqjibOYikY3YQZOgf+YRkyvREVcDf/xvmf3Fc8c4ylfI74v+EVZeJS/LDFKEOf1UO7yue0DNvA43JHtYAiQnY6xT257/b4BU4QHDieWEkRZgrIEMN82b+yL8of2EFjIRvI19l3D99ONtBLEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEkmNyoIMMsbXitUOoE1ZfU51PoiR75xtEtbGD0KwEU=;
 b=Q9N7aiTQoq29oOa10tr+A3dPKSk4oIYdveckXnsyC9vEruaBISPJd1NKCooBnIej1FI5pWpcAXg9xBIKTQQZQVw/QxGpVbMYX0vFqodbmFgiHM6cQYhOjVEBbi7/VH5XRCKDaAGPVHMaVR02h6s2B5wxPR8PdDaq/qStdGCsVWs=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 IA2PR18MB5851.namprd18.prod.outlook.com (2603:10b6:208:4b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 14 May
 2025 07:08:26 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 07:08:26 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Hanxiao Li <li.hanxiao@zte.com.cn>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v2 3/9] crypto/zsda: add statistics
Thread-Topic: [EXTERNAL] [PATCH v2 3/9] crypto/zsda: add statistics
Thread-Index: AQHbjBhBflVAf+Yt/0ij8WhUkBLAL7PSJNMA
Date: Wed, 14 May 2025 07:08:26 +0000
Message-ID: <CO6PR18MB4484285C34CA3AC30D40545ED891A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250303031644.1041177-2-li.hanxiao@zte.com.cn>
 <20250303082751.1053432-1-li.hanxiao@zte.com.cn>
 <20250303082751.1053432-4-li.hanxiao@zte.com.cn>
In-Reply-To: <20250303082751.1053432-4-li.hanxiao@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|IA2PR18MB5851:EE_
x-ms-office365-filtering-correlation-id: 759fa3e1-ac44-4cfe-cb1f-08dd92b61f23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NDl2NEJDazg0SldwMmNVWFNRTGs0NVRHRVlsUmNXV3dteHFTcjVHT0MrOFJB?=
 =?utf-8?B?WWdRbTVtUXN6VVhJSDlSc2tWTGNNVnNPblIrakZ4aTZjSnJOVEJMd0poQ2Fp?=
 =?utf-8?B?SksrendkMnB2c3pydmFaeFNqT1ZRajRUalozWDF3aXN0NXpJRzNXdjNUQytH?=
 =?utf-8?B?UGtEVjNic1NDQ2QwNVBRWVpDNTBwTTBuSzBqTWJCMnpSZ1lBamFxSkJRcGNo?=
 =?utf-8?B?ZENiUTVSaUllb2NBTStFNXh5WXR5N2JRMFpCOGpFNUR4MjZjKytBbUdNdmRV?=
 =?utf-8?B?eGV6V1V2SFBCUVJxREJuN2RDTEtERDczUGhtN1M0NGlnMkV2elpMVjU2NnRT?=
 =?utf-8?B?NVhPbWJNWXRKOFRkNWh0cUJDT25qeFcwZW5DSyt1Q0t1bEtMYk1KUlROVE1Y?=
 =?utf-8?B?Sm4zSUJtWlRhVWpZMVFFOXhrUnVTQ0pBTUVVYjlEUXBQb2FpQjM4UndMT1Vw?=
 =?utf-8?B?WjVqaTZoSk9ZOVVuTDhENFBzRjRub1ZyZ3c5Yk5mTXFMY09BTURpQzZFSm1y?=
 =?utf-8?B?R1VHd3dwb3dmMzlhU082MmVrV0MzMUpObURROWYvaE5FcTFLVXo5cjNLS1lS?=
 =?utf-8?B?Q2dEa0d5WnlDcFlZYXVNRzVRY2pDcE8zWndkMU9iVU4wN0FaMDk5cXZnbUlC?=
 =?utf-8?B?bHQrazY2YURKTG5SdDRUY0RXaUYyWlZ4dklnTUZqMkZFckRmc201WWJ1ekk2?=
 =?utf-8?B?VzhTZ3ZoR3NnUVJBWFk4VnQ1K1A3UFp5YklkcXlIUUlhUTV1YmRta1E5dDg0?=
 =?utf-8?B?T0l4cUF4UUNvT2w2U0ZVTUlqQlpjc3RjbXVxaU5JcWQyY3k2TzhvZkkxNVhS?=
 =?utf-8?B?K0haNkpnVkNaQklvdEhYd0ZDTUJ1UVZrSU5QK2hPYVdQOEZYdXM3ekJPN1lW?=
 =?utf-8?B?UEx0WEtQYWZoTzZTaUJaTHhxZWtna3lmYzQzbnBtY3B5Ym1kQzlxaGVxZlR6?=
 =?utf-8?B?L0VtemlaVEJBcUF5SlRUb1FWUWVNVi9TR2xhd3h6Uy95UFI3dk05UVdGdENQ?=
 =?utf-8?B?NmdPVDFPZFZhT3kvVEVrY1A2emlZQ0M4WmFXNVhCWU9ZZUFHKys2TVFmVkox?=
 =?utf-8?B?YnIyb3lVc2RuSDlRMmpnelowOGhnRmJUSzVpN0RSbGFuNWZFMjU4U0cxTkdz?=
 =?utf-8?B?UWcyZlhNRFFuZnBlVEJMZjdZOTJFSHNZc0pIVnMyUVBteEEwU2FKZlYvTVVM?=
 =?utf-8?B?Q20vK1A0V1NUTEhYeDkwWXJWajc0bDB1elAxM1BFMGFSUVc3VUx4ZzFuK3Mr?=
 =?utf-8?B?dTRzL3drd0sxditzZmVRRFhwTWc3K2NxUjNlNUxEVGNhQVVPQThXcS9FRWFP?=
 =?utf-8?B?azBDM0FXbVkyM1RLMzBreWEybS9hWmZxd3NCU01rdUM5OWNZSDRhZlpNR2pF?=
 =?utf-8?B?VnExZTlQcEpLZmhQWmpHYWFwb2c0Y3UrYS81ZVBXaVdNNzRpWmlYekpyWXh2?=
 =?utf-8?B?N2Y2UzUzRGxjVk5QdlBSNHNIVEtxcVNRcmF4c253cmcyUksvbkVZdjhZYUxE?=
 =?utf-8?B?MGV3R3BqNUUvcENmbDZYMUJXUW5IdXBIdlNxNzlUUThEbnhEU0M0VVBJRlFK?=
 =?utf-8?B?NGN4UHVxUHc3M3BuV1pCMm1YTzh5ZGg5YlpOdEExTWJmN3dKdUs0TEd0MVRn?=
 =?utf-8?B?eG85WFpLTDRiODVCeWlsM2VKcHVTZ00rSFFpWWhvRDBsUXJUYktIQk1mZm8r?=
 =?utf-8?B?S1lBblM4VUNJRktUT0s0MzVoc3Y1bTZicXU5VGFiVUVOeHdkOGhyNmd4THl5?=
 =?utf-8?B?c28rcm1pajRVMGNVcnZYbnppU1dsZUJzNHEvQTUrZlVDc2lTSXlOVXBSdURp?=
 =?utf-8?B?Tlk2d2hRN1c5aU55Wko1aHEwT0lNSzRLWkk0ZVZ1MjlpTzBCS09BVkVKREF3?=
 =?utf-8?B?eTdYdC9aRmQ2cDVIVlFSK2IxSWVQeDFFZmNDemFWWitzOGIvbVY0V1cvN0Zk?=
 =?utf-8?B?bFZReVNzQ2M2ZFpSVVJYL0NQTEhXd1hGMytubzJ4SzVCTnc3UXV6Si9RVWpp?=
 =?utf-8?B?cHZqSWlkbGpnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHUrdWNlcmpSUndlOXdsNTNrVi9FU1NCSmRXUG9PTUVORTk2KzNEQ0dCb3NT?=
 =?utf-8?B?aGpkaDhTYkE2NWFWZk9ZdDJXcmFyYllKSWQycy9YVVNsU2FpU2R3RHk3ckVM?=
 =?utf-8?B?b1lkWmFiYTl2Uk1QR1dXTy9iRXdpWmIyZUdPd29DR3FuTVoweEJ0dm1UbnBK?=
 =?utf-8?B?VXRpV2VRNmFvSnVEaVU1SGU0R3B0TEZHZms0RjB4Sy9MUEs1dDRLWEdQUlB2?=
 =?utf-8?B?SWpXck95cUt6eGZuTXdLWTJpNG55dEx0Ry9scEtucm0yVE4ySjBrYkR3L0Rl?=
 =?utf-8?B?dS9sTHJIdWdPQTFXTzBSSWR1cTVzN1JCaFZOb1Q0SXJ2akFod1VDaEhIWUp0?=
 =?utf-8?B?MUsvUWxqY0RSSE5nOEpvTzN2d1h3UVFzdy9MRnMrVkpqdmpTRzJtR0wwSEw2?=
 =?utf-8?B?QkFNSGRDd1VFbUREOUtoSmo0bWFnS25ldGthdTBVcTBIcEs5R0JmTEx5bzU2?=
 =?utf-8?B?eHpGYmgwbitFRTZmK1B0Qk9McGdzSjAxR0E4bHZUdHJPYTVMN1hDaksxL2lT?=
 =?utf-8?B?MG1aU1ZWaEdzQUdHblBibW9ZN09UWTFXSG1KY25GZDBsYUR5TVNiY3JzRlZz?=
 =?utf-8?B?blBnc3J2ek1yWWl5STcrNmw2bkhGZ2RiakpYSEwxdGVVTWtBcGxwbmcrNHV4?=
 =?utf-8?B?L0ZmYWU0dmZPbmFBazR4L09hSXp1cGRoV3IyclhSYVQvUUtnNXA5L2dZTCsx?=
 =?utf-8?B?VCs5djlzQ1BmeE1oRCtWODFHRm85eG1sWS9XbDNBWEUwUTd6UEFwWk93L1dS?=
 =?utf-8?B?d0xJa2RJTmdPUVNCZ3ExbDVpQnlpeDJlQUdGeEtVL292Zk9EeXZucGtVUktH?=
 =?utf-8?B?VC94TWdsTXM0ZXp6ZDhScGVXejdxSHVWb1JRTFJjNTJDSkRiRG54dHJQWFgz?=
 =?utf-8?B?SnJvMSthTzZWamV0MjNVbUZJM2U4QWM3clN0VjZhT3BWV2FwUktCK0tMQXNj?=
 =?utf-8?B?NTJGYUJrQVlHbFVsU1ZjdTRXQTN4c2RrdG15YkViZEZXd3JaTndVYzVZY3VC?=
 =?utf-8?B?dmRnZVJBUzdnUEZOZ0UrTVhDWjZxOXlhblp1MDBMZHFPNXQ4YXpad2tVdVVT?=
 =?utf-8?B?cGV1UnI1S012MndsV3VOZlZlYVhXbnduQUdLVWhFUzhIcGlMazZEaVYzcm1E?=
 =?utf-8?B?cXZmN3grTUZMVG1JS0NkV1BhN1IxckY5YlBWaDVDRE9KSFg5aTA5OVdlUndI?=
 =?utf-8?B?Q3lLMUpoN05scGpRczcyemdxUkxiWTFNME1waEpYcnExWWFHdjlmK3Vxb0ZN?=
 =?utf-8?B?ZC9MQUdHajNQZ01Qb0MxeGJDNE9FNXdhd2t2dC91SHZiYUlJcFBXRjkzeVNZ?=
 =?utf-8?B?NXFPd29zQVZ4dmtOa0pwS3NvWGo3dFlFdlNnUVJUSGRzV1luWk9pOVB1c3hv?=
 =?utf-8?B?a3RXM3BSZmQ5c2xOODUvbnRzalBDenh3QXRteHdLWW5OT3hmd2FNOFhrZ24r?=
 =?utf-8?B?bWtCSWE2V29zQjVjZU9KWkQ0SS9Jekk4MEFBRXJOSmo3OUJ3R3dMTjZRUHhF?=
 =?utf-8?B?Mml4RG0zd2tueUhGM0x1SThiang4YUpFQ3dtUlNqa0Y1VlZxNnlkVmFiZ1hD?=
 =?utf-8?B?L3NldXRzcnpEaEtWa2xSM1h4SkNVRGxPRFloUjRwZ2hYZnhZbzAzRlhVeC90?=
 =?utf-8?B?Q3pVOU1Sc0MwaHJuL2N4R3U0SUVHT2diM0ZlalhRUDh4K1VXK0hBbEZ0ekZz?=
 =?utf-8?B?Wi9tS3hPTFIvd2MrKzdhUThwSi9YSzIwQUJZNkY0dENadlZtak03VWFjb282?=
 =?utf-8?B?MVNya1VmekoxY0dTQ3Y1VWVZNmdnMUFIV09Rb2RKdy9pajhBTXlFTVRNQTcr?=
 =?utf-8?B?cXJ3ZGJHSVEwM09EMUY3RFpoNVZ5V2todXZJcU9UUXhTcHRDUVVvTms0TmVD?=
 =?utf-8?B?UFRWS1RKNVBabDBXaEhEWWhNa1AvUUVXYSsvRDM1M0pPVHRjclJpUWg5QXRm?=
 =?utf-8?B?T09zWEloWlNCVWV3MGNMSTRzOEhkbERjZ1Zpa1RHNS9HM1dhRTNHdGVEUzNV?=
 =?utf-8?B?YVZLSkRqd21PNFQyeTdOZ09XZ28xanRENjMvelZ5T1d1ei9YSlFUNUpUSVR2?=
 =?utf-8?B?L1FDVzlBdCtpR1A1S1l5eHIxcTFFSWlPb2MvQzdEYmtYTGdOSFRHUWppRjU2?=
 =?utf-8?Q?/7go=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759fa3e1-ac44-4cfe-cb1f-08dd92b61f23
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 07:08:26.0412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QAfXOkucpeP5okcD4yvjH/Tz66OKc98YjwXoIszc83TwY3gzwtDNcoLaIXJU4495KHOaRHGtchHporEGtgH65w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR18MB5851
X-Proofpoint-ORIG-GUID: 5Ey4Ks4qZaUAw2bDcUbJ68lwcTU3lssm
X-Authority-Analysis: v=2.4 cv=VITdn8PX c=1 sm=1 tr=0 ts=6824416c cx=c_pps
 a=OGaRt8TyNAR4X2Yz4FfAAw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=1RTuLK3dAAAA:8 a=LHDs1sFFA3s3ASCSHhwA:9
 a=QEXdDO2ut3YA:10 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-GUID: XZqXXy1p2k6wYxiBxJ_ThXf8tV8ZVb8F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA2MSBTYWx0ZWRfXyEtgwPZQIzlB
 +6W/HRGa11y87nEX2LceJWivGEadjXHXp7SAeL0YNgJ76PDdoHSM49oXaZeE46pqpmeZfnlPYol
 0sSH/SXNrsikgBVzMp+w12kjvL9VecgJmG16mUS1v2pt+C4fmOCTVN3N6Ely42Jl7Eojz8RQEmT
 Y14l3+2aNafmRqgKDwr5yCi1lJI3mczYvDYky7Oz662hyqqzjHcSf7dr56Ver7s9puqvKCTmIJO
 XhCVCJK/qd8+Oxk8hv39kwcj2QyFRMo+81amBFrYuzxRtB8UoYUNU6bd8KAiBwIIDH2qTr1tSJt
 3oGHC3TiTBoWDeVttFMoOMJgP/CO1PJwzLaaDvukvSWBww4+0RkbWi/Jg6aOC2tPBflwYtp5pdM
 lDYQbzSlUvRH8BN8AlvBz9GMCtlfelOHE9WTFl6Sn1R69XsfHz37dPC5OEpjJyibxyNJn5rM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_02,2025-05-14_02,2025-02-21_01
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

PiBBZGQgY3J5cHRvIHN0YXRpc3RpY3Mgb3BlcmF0aW9ucyBmb3IgenNkYSBkZXZpY2VzLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogSGFueGlhbyBMaSA8bGkuaGFueGlhb0B6dGUuY29tLmNuPg0KPiAt
LS0NCj4gIGRyaXZlcnMvY3J5cHRvL3pzZGEvenNkYV9zeW1fcG1kLmMgfCAyMyArKysrKysrKysr
KysrKysrKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcnlwdG8venNkYS96c2RhX3N5
bV9wbWQuYw0KPiBiL2RyaXZlcnMvY3J5cHRvL3pzZGEvenNkYV9zeW1fcG1kLmMNCj4gaW5kZXgg
MjJjOGQ0ODJmYi4uMzFiYTU4MmI2OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jcnlwdG8venNk
YS96c2RhX3N5bV9wbWQuYw0KPiArKysgYi9kcml2ZXJzL2NyeXB0by96c2RhL3pzZGFfc3ltX3Bt
ZC5jDQo+IEBAIC05MCw2ICs5MCwyNSBAQCB6c2RhX3N5bV9kZXZfaW5mb19nZXQoc3RydWN0IHJ0
ZV9jcnlwdG9kZXYgKmRldiwNCj4gICAgICB9DQo+ICB9DQo+IA0KPiArc3RhdGljIHZvaWQNCj4g
K3pzZGFfc3ltX3N0YXRzX2dldChzdHJ1Y3QgcnRlX2NyeXB0b2RldiAqZGV2LCBzdHJ1Y3QgcnRl
X2NyeXB0b2Rldl9zdGF0cw0KPiAqc3RhdHMpDQo+ICt7DQo+ICsgICAgc3RydWN0IHpzZGFfcXBf
c3RhdCBjb21tID0gezB9Ow0KPiArDQo+ICsgICAgenNkYV9zdGF0c19nZXQoZGV2LT5kYXRhLT5x
dWV1ZV9wYWlycywgZGV2LT5kYXRhLT5uYl9xdWV1ZV9wYWlycywNCj4gKyAgICAgICAgICAgICAg
ICZjb21tKTsNCj4gKyAgICBzdGF0cy0+ZW5xdWV1ZWRfY291bnQgPSBjb21tLmVucXVldWVkX2Nv
dW50Ow0KPiArICAgIHN0YXRzLT5kZXF1ZXVlZF9jb3VudCA9IGNvbW0uZGVxdWV1ZWRfY291bnQ7
DQo+ICsgICAgc3RhdHMtPmVucXVldWVfZXJyX2NvdW50ID0gY29tbS5lbnF1ZXVlX2Vycl9jb3Vu
dDsNCj4gKyAgICBzdGF0cy0+ZGVxdWV1ZV9lcnJfY291bnQgPSBjb21tLmRlcXVldWVfZXJyX2Nv
dW50Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZA0KPiArenNkYV9zeW1fc3RhdHNfcmVzZXQo
c3RydWN0IHJ0ZV9jcnlwdG9kZXYgKmRldikNCj4gK3sNCj4gKyAgICB6c2RhX3N0YXRzX3Jlc2V0
KGRldi0+ZGF0YS0+cXVldWVfcGFpcnMsIGRldi0+ZGF0YS0+bmJfcXVldWVfcGFpcnMpOw0KPiAr
fQ0KPiArDQo+ICBzdGF0aWMgc3RydWN0IHJ0ZV9jcnlwdG9kZXZfb3BzIGNyeXB0b196c2RhX29w
cyA9IHsNCj4gDQo+ICAgICAgLmRldl9jb25maWd1cmUgPSB6c2RhX3N5bV9kZXZfY29uZmlnLA0K
PiBAQCAtOTgsOCArMTE3LDggQEAgc3RhdGljIHN0cnVjdCBydGVfY3J5cHRvZGV2X29wcyBjcnlw
dG9fenNkYV9vcHMgPSB7DQo+ICAgICAgLmRldl9jbG9zZSA9IHpzZGFfc3ltX2Rldl9jbG9zZSwN
Cj4gICAgICAuZGV2X2luZm9zX2dldCA9IHpzZGFfc3ltX2Rldl9pbmZvX2dldCwNCj4gDQo+IC0g
ICAgLnN0YXRzX2dldCA9IE5VTEwsDQo+IC0gICAgLnN0YXRzX3Jlc2V0ID0gTlVMTCwNCj4gKyAg
ICAuc3RhdHNfZ2V0ID0genNkYV9zeW1fc3RhdHNfZ2V0LA0KPiArICAgIC5zdGF0c19yZXNldCA9
IHpzZGFfc3ltX3N0YXRzX3Jlc2V0LA0KDQpTYW1lIGNvbW1lbnQgaGVyZSBhbHNvIGZvciAnc3lt
Jw0KDQo+ICAgICAgLnF1ZXVlX3BhaXJfc2V0dXAgPSBOVUxMLA0KPiAgICAgIC5xdWV1ZV9wYWly
X3JlbGVhc2UgPSBOVUxMLA0KPiANCj4gLS0NCj4gMi4yNy4wDQoNCg==
