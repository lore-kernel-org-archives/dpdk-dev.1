Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85602C3ABBC
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 13:27:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 795324025D;
	Fri,  9 May 2025 15:27:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 89F294025A
 for <dev@dpdk.org>; Fri,  9 May 2025 15:27:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746797246; x=1778333246;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=jO72VNgxE8qvSQQC2jnTs0MVfnQZgEZBO8XVIrb6BD0=;
 b=L0t0XFEWQoiLGmv+65pn5YIzaYMmwUViG5r0g1XSQMl60F8lYapStFZ7
 FrhXahVAW+iY09G0omfyS+4bVGFLuNt2V+3ouzUliKOLvMPrkraUn3/0R
 Viq02BV0CU7ogynx89M8t2zWNDDhx3OpTxq9/dbJM7CCKhnu6liaqXgrr
 DGLI7wAO5KUtDqcSQqwAjGgOORpBPNmlIyIK1zRb80adxepcwPkpgApd7
 4S3HrvoXXUVylpT7JqiwJOay+2mWCkusnwTYTjIU/EXVYpxenpM+taDhY
 tXoEmv3ixUITVTPEsU/mO81zWFmELggB2VBXtRdfC65rdK/akuZ/2U2zk A==;
X-CSE-ConnectionGUID: lEoeGkiXRUKS0fetlbLyog==
X-CSE-MsgGUID: td+CEvN6ScKZyVkWO+7MkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="66158584"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; d="scan'208";a="66158584"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 06:27:25 -0700
X-CSE-ConnectionGUID: qsspZIcfSEyl78Cr979UDw==
X-CSE-MsgGUID: b67jHu2RSgyB/RfBTg1pVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; d="scan'208";a="140675589"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 06:27:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 06:27:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 9 May 2025 06:27:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 9 May 2025 06:27:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1PSTupVchYnhZ4D893kPNEf6iWxfF/PUri+CmZXYUcJS6beHsT7AcAXwiqC8SVrjFvD3XGnK1+KMuXnHziXme4KgmimyDxQXwl3jZR08uMuFJGzaPAXfAsuEzvRasy6R6137dW6c4Ae0l4spkO/aHXJTvnMg2FMZxM4Y1B8Fqz9/i8eOPYWurCh4mnznZ0/XrdHc4/yQeGbHImkorHvRmrK70e47ueZwGBkBL4InKCiXEr+pwY/Yp6AGXh3WkQlWPKPLJzZZht3Ppr2dWEAq8vSxn5jlCJ4SFQfY7mm/x066OdpeOmbahv1dEkIf76RXwn/W+xx0p97Sz36J67YYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uddJqJZsm3SBO4GqeMVlklaghGkXmHqiNyMTPnLdfFI=;
 b=H/8pUqgi0DxjCf2caBVrdbaNyzIzwrqgv7do/oONFMikVmsNfsJnQk87enjV5keG0inu9EOrfK6OHT22LslWYJjkpA19mxK31zLYdWufeYkGpkBsybitX6iHAgNrn/gb0ve/QW7cxOCDOglO2jrRfAmvD7pEfhocf4e9R6BTaKFB55lf2GSaaHVdLIKiJ6WvB9rag648Vh5olcFiD6WTdlueNYWwQnSwm+eDiNCe3m9MfCoz4WGEBCn8t7M+LxFG9dRZupgHTLgyM84CccU4IqRU4q4u0WtJo1AO5NTD5DhZIDNbhimfLwd7/DSRIZxi0pbq2HVeMO/xOdy0+CoVNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CH3PR11MB7202.namprd11.prod.outlook.com (2603:10b6:610:142::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Fri, 9 May
 2025 13:27:23 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Fri, 9 May 2025
 13:27:22 +0000
Message-ID: <01120a7b-cca1-4af6-b196-382643094777@intel.com>
Date: Fri, 9 May 2025 15:27:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] cmdline: use C standard library as number parser
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: <dev@dpdk.org>
References: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
 <7bebd92be36f945c175382bb1e0482e55844c1d2.1746710154.git.anatoly.burakov@intel.com>
 <ebb1b821-0138-4f64-bdb0-d86b7eab48a8@intel.com>
 <53015359-0725-46a5-b186-aad90f01a81e@intel.com>
Content-Language: en-US
In-Reply-To: <53015359-0725-46a5-b186-aad90f01a81e@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB7PR05CA0014.eurprd05.prod.outlook.com
 (2603:10a6:10:36::27) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CH3PR11MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: c76efb5d-6b9a-405f-70b8-08dd8efd3b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnV0NThlUEU4L1RobzN1OHlpN1k3Wm00OVVjWDE2Y1hVcStIVGlIdnhub1NY?=
 =?utf-8?B?VEx1TGFwOHhONzY0M3pNQVZmOWs5Wk5jS0RsRVFKbldvVndxbXRYZEVpbmtL?=
 =?utf-8?B?NEh0SFJJTE1rT0hFS0c3VjFTM1p4bDRIdUNxcW9yYTFobG15dWJZbzhtdzFS?=
 =?utf-8?B?dE1rRkxNTGduSk9yeThmd2NqRS9CejExK05XUzVGbnFhdzQ4SWFDTUxPVmRp?=
 =?utf-8?B?WGc5L1k3VUU5Ym45MXF0VjRHazB0YUZGYVh1VzkzUlpKckRVcFVqUEVLOFI5?=
 =?utf-8?B?RjRsN2xWanJpaEZ0ckZldmNEREFKclNnN2o5MGxKL0tGTkFNM0VpbTY2cTEx?=
 =?utf-8?B?M0FyWVFjVi9OWXFMZUhBVlJnNTgvUEVLTkNQcjZ5clB3UFZRYkZJZVRxclF1?=
 =?utf-8?B?cGp5M1h6TVZkVGR0TmFJQ09Sck5MbU8xekJyYXc0UkVTeGUrWlEvY0RSNG1y?=
 =?utf-8?B?TlA3UW9nNzdjYzY1RzA1NGRBZUFwcnFYeVJURVFPeXNRZTdlR1NUL1lISnJF?=
 =?utf-8?B?S2RCL252WFVzQXhnbWlPS0FzMEZ6bFBaSXliM0hqL1IyRW12dUs5dEJxdDl2?=
 =?utf-8?B?R3NjbUQ2ZzVWSjFHelE4eURFcGVMVTBNZFhOZ0pMb0ZTbUd1UXk0ei9qcVJ6?=
 =?utf-8?B?bVNWeU0ycUJTSDlKOTNrYU51QnRnWEVXRFVZNTRiUXlqUWpOM3liN1g3Vjd2?=
 =?utf-8?B?M0tYRlNRQ1RpOFVYV3FhcENaQ2dyL1pZZURZS3BvN3BOeW9jUVRXMDVBRXFU?=
 =?utf-8?B?SGFaMVhrcHU3Z0Mrd0FZQy9tR2laWnRDcnVLd2J5N0FLaW95SmNFZldLQVhq?=
 =?utf-8?B?eHAyTnFiaXdzbHk0djhhdEZPRm5YMmFVTWdPZGloWG5ON3V5OWRlcTVHSzdC?=
 =?utf-8?B?cEN0ODZqSkFWWk9DVHZyeXJRUmM1dXJmbzhPY2xhemFUSTRPQ2tIV3RjS0Ny?=
 =?utf-8?B?aHN3dnF6dVhMOUQ0WEc0aXRSa3d2RVo3UzBIbjZRb2M1RHgyeXowenRmY1Zn?=
 =?utf-8?B?cmJodHh1MWp2RG1wMW1FTVRCTEpqUE5MTER1RmFNenc4dE5Yc0tUSGYzSm94?=
 =?utf-8?B?NEFwcy9SS1creUxqOW1mRnErQ3BleVlaT2tSRnd2MG5FMlRUY0ZvVDc4c0Jz?=
 =?utf-8?B?aEw3LzRaQzFsbGs3eTJHNFZ4SW1tYXJYQ2RlYlJhcjAzMGZuWkhGMUdNWnQx?=
 =?utf-8?B?TUgwWCtCVFlGcEhycTRicUtkOFRXd2lJaGIvZCtEaXJWRXpacGlxdEZkbjNX?=
 =?utf-8?B?eDZja1lEYjk0WXRMb1UxUFJJTnYvV1cxeTZpbEgvRVByQkRwdjFwOE5xSXlN?=
 =?utf-8?B?MXBQQyttdzRSZ2puQ281Y3huSGtTQ3VUVHI4NkZCWFBoSXpmV3JpdXFaTnZD?=
 =?utf-8?B?YVg4VjFvQVRyM3NhdVRPbmI4dS8xRko1Y1d0SE5XM01jRmtmWUwzSTBvYzN5?=
 =?utf-8?B?RFFwS3NuMWpTVjUvTCs5Kzdpb25MVTlrUnR1Wjdpd1NZYmRqRGJnRmJiSE83?=
 =?utf-8?B?MEdZNmdNMDVIcjRXbFFOQmI2Tzg2NmNCYzJ1M0VkN2xnWVZ1WkFWK3d0Z000?=
 =?utf-8?B?bzcvYXdSOEFHZ1YzOFRRdWYweGlrSkhYMHcrU0FCWG1Hd3oreUJVbU02algz?=
 =?utf-8?B?dUZKNlZ0RG50OTRXVTk3VHFNUVBLUjJIUGJDQzh3WHlwVGZNNmhJcTh5V2pu?=
 =?utf-8?B?MTQzNVhRck1TVnlsNkRuQ2o4YmhlS0JmaVd2UDRIaThIekpqamlzWkN5bUpT?=
 =?utf-8?B?d1BWc1A2a2YrMUJ3aytIRGtocGxiQlU1Tm5JYVN3eUJpT3U5Rnc4YVJYVGl6?=
 =?utf-8?Q?nuQZrkwEB/nCTiTy2ZPT+tvaVj2us7DsMHBH0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0FQSDhIeXJPL0hLdnVjRHBxVDAyb2ZFVWNDa0I3RlpUWXMvYTFLTnZudjBy?=
 =?utf-8?B?SFRCRGh1SERlNTNvb2hzY2Fva01JOUNJTURCSnQyRXpOZzVFZUhBWENiYUpN?=
 =?utf-8?B?U1ljVmFaYU9DdjBFZ1pnUFBkcGJ6OGJuQzlKZnZwa2p0TDM0NWxrQXZNWTB2?=
 =?utf-8?B?OTdjdzQvVWNtcGFJdmlselZ4VmxCc0lDeWxDOFR4M2RXNFNudzU5dmsrN0NI?=
 =?utf-8?B?TGVuWWVuRDd3TTVMTjVGZ3g5UWoxTmwrWnhKYjJKWjVyOU9KaUpFQXR0VnlQ?=
 =?utf-8?B?R3FpL3ZSSzFyNVNBN2JCSGFJbGtOVURKOFdJR1IzWTNBNTIxWnVxVFJLQ2FG?=
 =?utf-8?B?dVdrMSs1WWkxTll4UmhMcm5zVnhMTTFHeGpNeWNnNllnZVpNZUF3NTh0MU1h?=
 =?utf-8?B?L2hGdHJYVVpCbFdvWEEvK0l1Tyt3c2VJQ3cyUzBxOEgwcEkzM096MXJDcnZF?=
 =?utf-8?B?Vk50UE9waXA4dFh0SlZJWTVWY3lycThkd1djd0orbER2eUs2OTF5bFdzUlRV?=
 =?utf-8?B?UXhWMUZsNzh2RElRYTZwbzFIN0hEbFBObElZbm83Z3dtZi9RLzMrV011L1lq?=
 =?utf-8?B?SGwvZE4wZUVTTTBzSkE0ZkNWcFh0SUdtdWFDZ2dUSkZHZGpRbld0QkJTWTBL?=
 =?utf-8?B?UFlqVlM1cTlBTVRnSitycHg4QjhhOTIvQXMvK2lkUVBRRWQyYWJ3bWgzeFdP?=
 =?utf-8?B?dklCaDdIdGkrcE1XN0FYWFJhV3MxcDRqOGFVQUdCUlBmQ0pPQktCZXJnNUFL?=
 =?utf-8?B?Z0J1cFI3MG9FcjgwZWpQL3VuOXRERGpsUXIvOWxaODZLLzMzU25Ec20rY2ls?=
 =?utf-8?B?NXd2MHh6OVFYT2grVjNaWWVRNmV1dlFQZ3FvbEtTNmZyd3k5OTdFRFlnUWFC?=
 =?utf-8?B?RWRoWC8yenduSlRaTloxWUVoeWVna1JXRC8rWU5jOGUvb1NzdzRlRW9CMjYw?=
 =?utf-8?B?UkxmZzZEMkJMM1pUempNM0JUT1hsVnpNamExZjNNaFlxOXo5eXIxSktTcnZk?=
 =?utf-8?B?cURkTlVCb3JydW5KUjE2eENGbk5mcng2ZDgzMDRBSS9VSi9PMVJIUDlyS01Y?=
 =?utf-8?B?L3JDWEdTUWZoSEd1L0pQV29FWEtqM3ZUd3JZSS9hSTd5ZEQ5NHJTc2JValcr?=
 =?utf-8?B?cHVFaHFhbXEvUmVpcUQyNHk0RXJ2Ulgxc2Rod3hyWGUxN2hiKytGdkpBdUMw?=
 =?utf-8?B?VmNtOC8yNFZpaHlPN3piUjA2aVRQbm92emVaeW1WV2RQU0Z4TFU5UmRnMksy?=
 =?utf-8?B?Q3pCaWxpR3ZwK2RTWG95Y3BaZVJUMmVZcThCYzg5ZFJrRjNwY2JqU3NVcUE4?=
 =?utf-8?B?YURqTTZ6Q3h5eG9ySEtNb25qWnVmdjMwSktEUWF0T3AwWUl3UExhM2NScGVs?=
 =?utf-8?B?R2c5cHAyY1hyMmhoZ2JiYlVIVDNNL0dITE0xK1lPb2VPd1BHN1UxRmN0NUlh?=
 =?utf-8?B?NVBxWU8wdHJHVGI1QkFDcDJ3QVYrbnFOTnFaQU01S3M5b2hnb0d1eVVEQ2p4?=
 =?utf-8?B?NHZGQ3U4Qmphc0QvSm5UaTRRUWx1T1pNbEtTN0huK1hMcnNsSUZrYk1uVE1z?=
 =?utf-8?B?RDZUNWloQ0V1N0p5UjBEbWZiZktneldQSzZIdkEzUFprdllBWGlhQjBIRFI2?=
 =?utf-8?B?cUhiN1NybmtmUmFJUlhlYklDaittaVUxUFRONE9nc2thb2Nrck45Q2RDTTNC?=
 =?utf-8?B?dTM5a285UDRWWXlOL2ZSWk5xeVBrR2RqUVlWMFQzUWNkTWIvN2RsVzJZK2to?=
 =?utf-8?B?czVYbzg5UXhtR0dSaktzSlR0MzdYRmIzcXFWeUNpUlc3ekZVMUxMUGs3aGo3?=
 =?utf-8?B?VlNUQnVqK1JIako3RUR3b2ZhN2c5OWhwWlpHd0l4V1ZNcksxWEpFK3dHbXFn?=
 =?utf-8?B?b2xJN053YjcvR2NwanhKckowOTZaK1NVVHNlbFdxa2s1VWlmUEJ0cmJvOGFv?=
 =?utf-8?B?Y2taeFhWMmZ0UlQzTVV5cVRYc1lXb2oveVdhdFhDb3d2NWd5UmVtbVFxQTVR?=
 =?utf-8?B?WkU5eXNQZExrV2M1bm1kL3JQd3l3OFBCSWUxNnpmaUV4S0F5eTBBb0huN0Np?=
 =?utf-8?B?bnltTGcvQ0NuSGVseEFubzRZVUFHUExyVDQ2NDVlMm1VY1JaL3VjY01GRWRN?=
 =?utf-8?B?Z3FyajVxa1hSa3pkSXk3ZVZFMURMUzhLL2NBbVlDZjF2ZnBsYTZTb3dWTWhV?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c76efb5d-6b9a-405f-70b8-08dd8efd3b2c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 13:27:22.9180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvzKd2i9z5iCvG1AayZT2fJFMq/oiRhQXEliCLi9hu//BaPGneuQRuUenpdmwpio8RbpK9kyijW2pQCWfSAOBIocgaL562y2JpnhlvXOe08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7202
X-OriginatorOrg: intel.com
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

On 5/9/2025 3:08 PM, Burakov, Anatoly wrote:
> On 5/9/2025 3:02 PM, Burakov, Anatoly wrote:
>> On 5/8/2025 3:16 PM, Anatoly Burakov wrote:
>>> Remove custom number parser and use C standard library instead. In 
>>> order to
>>> keep compatibility with earlier versions of the parser, we have to take
>>> into account a couple of quirks:
>>>
>>> - We did not consider "negative" numbers to be valid for anything other
>>>    than base-10 numbers, whereas C standard library does. Adjust the 
>>> tests
>>>    to match the new behavior.
>>> - We did not consider numbers such as "+4" to be valid, whereas C
>>>    standard library does. Adjust the tests to match the new behavior.
>>> - C standard library's strtoull does not do range checks on negative
>>>    numbers, so we have to parse knowingly-negative numbers as signed.
>>> - C standard library does not support binary numbers, so we keep 
>>> around the
>>>    relevant parts of the custom parser in place to support binary 
>>> numbers.
>>>
>>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>>> ---
>>>
>>> Notes:
>>>      v7 -> v8:
>>>      - Added the commented-out out-of-bounds check back
>>>      - Replaced debug print messages to ensure they don't attempt to
>>>        index the num_help[] array (should fix compile errors)
>>>      v5 -> v6:
>>>      - Allowed more negative numbers (such as negative octals or hex)
>>>      - Updated unit tests to check new cases
>>>      - Small refactoring of code to reduce amount of noise
>>>      - More verbose debug output
>>>      v4 -> v5:
>>>      - Added this commit
>>
>> There is a unit test failure coming specifically from this commit, 
>> that only happens on ARM. Log:
>>
>> Error: parsing -0b0111010101 as INT16 succeeded!
>>
>> That is, when confronted with a negative binary string, it seems that 
>> strtoll will report success, whereas other platforms report failure. 
>> I'm confused, is libc strtoll different on ARM? I don't have an ARM 
>> platform available to test this so I don't know why this is happening.
>>
> 
> Correction: it seems that newer libc versions have added support for 
> binary formats. I'll therefore amend the tests to account for that.
> 

The specific announcement regarding binary formatted strings:

https://sourceware.org/pipermail/libc-alpha/2023-July/150524.html

Since our binary parser will be a fallback implementation starting from 
that version of libc, I think it would be easier to just add negative 
binary support to our custom parser than it would be to differentiate 
between different libc versions, and support negative binary formats 
regardless.

-- 
Thanks,
Anatoly
