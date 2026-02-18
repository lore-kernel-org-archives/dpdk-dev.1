Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D729EE9A03B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 10:32:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 063C3402C5;
	Wed, 18 Feb 2026 11:32:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id F2FF4402A3
 for <dev@dpdk.org>; Wed, 18 Feb 2026 11:32:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771410746; x=1802946746;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MRkFXr4GsMU4tDrtD2Sam2PgdDQE4UDjZFBbuPu3oW0=;
 b=jhhynkAOhqiPZSMcPvnaoUYlwcyaLYx0S0RG6EfGcFM4mTEr07WtBTKr
 Us9GkMfP2FNEQvvdejl60PDQfk97aDArEDNOLj8toejDbV6kCiqO732/i
 rjMuC3qZEnmogITYUqd/cdbgzoEo9QqWCaYoV97P6VxbQ3RmaQyBScnhY
 mKDXV9uEhzCCJFbgvIudtBLxyI2vAU1G36D9e+hf9HCcWQyhXNcGF9Wfn
 dja8wDZkSIfNOyIqKYKwIEJYNCTZfo00TaUUqcHjldHyIAy+XmlkqyOKB
 06yYdMS+JKoUCEcCCq+bvuWskfT547iUaC00SfLb4asxdtYU6BPFps0Fv g==;
X-CSE-ConnectionGUID: BCz8SsBVTDidSaCwYv3OdA==
X-CSE-MsgGUID: QjZWE7F0Qr2COqWUWLZLYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="72387672"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="72387672"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:32:25 -0800
X-CSE-ConnectionGUID: 4cXqxofiQ+e7ANQC41hmBw==
X-CSE-MsgGUID: jIny2EB/TB24N6YKTz9WKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="212827117"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:32:24 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:32:24 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 02:32:24 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.59) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:32:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lv7b4eRRFNUuB2/TTlJIXl8uWL4/EazzjGtGhE3D248q/oVfC8+XGs3xIEP5QJrxVv1Aa0iH4eLdLlw3dTdftiYgAGc0Hp86+LUOCaY9QkUJqvznBjIJvuB4x62EfwABnhCLtvUisoB5fliul7aTzpGpEn0+SOXNVbsbUX9FEN0NavvdqDEphFnC28IGRrNmhK/fJLFD3JCm6/sZ2O4IIu6A3G6TjPKXiyAHj/qPHcOVSIApfuusF+ZXTAO7lRCAGLvwe81wCBHLiGRHyVAHI0C5U5FA848GcSCWH5u3XHqi0uG8zht43P+WlL0Zz90BJYiQYigqZj0GSsc8fskFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeZjgpA+VRf2xYo4eDKL+QGwWNahhdTQw8XPWQEvwnU=;
 b=UZZRh/3pUOTe05el5RZufVhF8Q3AxYm5BY6s4shhVaCvPTvr+FtQk+fdpVSp8Dfiyvd1Yp8nWBcv1tBYzGr3sZNpUWdH5qYRqNjaRMSV7UN/a3xcKJ7xKr2FlA55hkcOO5ocO9ZnlIyzygDc2xXb3SOaY3L5A0ZppA3SJLhbFd2LYZWqRkwBF2Jh4iviJktdVjZF2v4EcOkZ4xatxaG4u6PkVW9E1Qgx5X5abTMbLJRxXpFfjKu0G00n+kzEOL6hNyx/SBcAeGFjC9oDlZUgE1xqchcjYuSrKWGdmUwz8xvuBVH6uVJXejHo0sPQP+CFxfgUXdcX5GeMAz4dDB5Axw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CO1PR11MB5108.namprd11.prod.outlook.com (2603:10b6:303:92::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.14; Wed, 18 Feb 2026 10:32:22 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 10:32:22 +0000
Message-ID: <a1162ec5-6fbe-448e-b5b3-0dca1ec40c94@intel.com>
Date: Wed, 18 Feb 2026 11:32:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/27] net/iavf: decouple hash uninit from parser uninit
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <3b7b2c7a8f5e1e83650e5e64262b15273735dbf4.1770978324.git.anatoly.burakov@intel.com>
 <aZNSdQEtmn-6yDHo@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aZNSdQEtmn-6yDHo@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0200.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::7) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CO1PR11MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: 611319ac-2af6-4aff-57eb-08de6ed90037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlVFN0RzcnRIZEwvMzZCZzNRMlRJaTJQTEd2V0JKSDUyeElhL1FlM29Ca3VW?=
 =?utf-8?B?dWk2by9vUDV0UWg2MXFlRS9tS3NFNktSTXQxOHpIS1ZGNWJmQklaUkJuWThq?=
 =?utf-8?B?NWtJRDlxendkTUhkTkdGL0lXY2RQODE2QTJndmRYejk1UE1Xd0VrQk45V3NL?=
 =?utf-8?B?ZWlpYXB2WDhxK0VGUlVPMjkvRHFSTzMyOFZnRmwxY1ErMWVlZTBFQnJHSUcx?=
 =?utf-8?B?Zy9sTWJkYzF1UGIyeHV2WHpGLzgwNVhEUGl6TUZuOWozcC9TZEp4aGhlYjVO?=
 =?utf-8?B?Y3hRQVhwQTltVmZxenpkdjNuUjZKUnVrL0o2a0dNVnZiL3VCZXJMcWF3NjVN?=
 =?utf-8?B?VkJ6aDhWS3NONXdNM2dNRmRwaWJOL0pqYzZKUS85SmJja1hZT2NPWU9BcDlo?=
 =?utf-8?B?NElKZW96ZGJuYzJkVlFtdkFwb1hXUk1GeFVibWpycmt5NWZzOE1hS2RTU25V?=
 =?utf-8?B?N1pFbkRUckkxM29talZnQldDS3YvcVdhb1VrZXN4VTE0OHBpeGF1RnlaNzlV?=
 =?utf-8?B?emNZczlkT29sbkZ5QitzNDhMUld5Z3FrOTh6Z0tPY0NKNy9YV2xKWnNrTVk5?=
 =?utf-8?B?eVFVU3YzUTZhTGU0c0E5OUxraFRpbEZQMU4yKzE2RStSSm1vNDJXMGZBUGRU?=
 =?utf-8?B?T3dsdC96OWIrb1kzNVQ5dkdoZHNZRFFUQm15S1BHSUgybS8rK05sYmJXZEFo?=
 =?utf-8?B?WWtWQVJFSEFYOWoxeGxxNndsL1hEMzZJTDhkN1ZsWXNDcnBkaUxKT09teGt1?=
 =?utf-8?B?K1hUREE3VzZtNWVjcVl4RTB5UWVqN1NRakdEaG1vWS9aQnNkQU5iOWNPZ0V4?=
 =?utf-8?B?TGFieGwxNmxaT2phZitUY0ZNZWtyNmE2MmF4QUlYNlpIVWlXa1BJTzl3TDNu?=
 =?utf-8?B?OGIxOXlsTFQyWTU0Mm55U0xCVlZOaGtRNEMzRWRHMHduNVEvalZNUUJlSzZD?=
 =?utf-8?B?Z0ZrRmtOdEpPU09TbFZIVldnbTRuaXVyMXJGakVqbHNVcnh1TnNhNXBZZ0cr?=
 =?utf-8?B?T01oSDgxMUluQXlaTGlQT0dRUGR0b0tvTDFIY1h2emd5Y0RUTDlXQVA1a2JC?=
 =?utf-8?B?Sm5pUWdCK3dQdWlCZ0xIUTlmbm9PWGpzblFhZnhIbVk3U1p0YWFmWTVJaTNu?=
 =?utf-8?B?K01XWmZESkM3a2cxYUJNUW1tdDQ5bm1Td0kzcmpiZE9wUVlmNXFvc01IT3pC?=
 =?utf-8?B?TUVuMjF2QWdnZUpOTWgzYTVUemd4QVYrM1I1L1NpbnhIc3dRNmhTcEs3Y3FP?=
 =?utf-8?B?YU5yZVFsQTVJeUZFYzArengvZmUzZE5sV29TYklXNjgzRmoySE53VjF6QUpq?=
 =?utf-8?B?Ynh6WFdxNXRrb2ZJSDlVMnJML1dmME5kYTltcWtuQVVUd0RFQjhQYUQ3Nlk4?=
 =?utf-8?B?MzRlMHZ5RVhsNkJkWjFWUEhYY3NRRG14QjRhRHVONDFlcURWd1FLY2tKZ2pp?=
 =?utf-8?B?NXcxbjl0UDduTXdVOTNOZGFQTU9yUEFGTVJ0QW5DYUFvWVlMMzlvT0htblhL?=
 =?utf-8?B?SlRlcEpUT0lRZDN2MGRRV1dIYUxzYXdZWXZPWVd5ZXFCY0RLbURnaVpjbzkr?=
 =?utf-8?B?c0ExaDlVQVRscnVJYU02QTRJZEVZeUZhd1BDUVNvMWluYTlWWnpSTXFXYitH?=
 =?utf-8?B?TFlHMXlKb1RmUU96bFNMU1VtSHo2UTkzV2RuUmlkSE9zWnM1Q3kxaWllTFlD?=
 =?utf-8?B?RTFIcU91cXBTcVpTZElqdzB4WFkzMUFGZ3E2MTFERlJhUmUrWnVFVFN5a1dK?=
 =?utf-8?B?ekFWN0hJb3B5MEE2bVVLd3JxWVFHWmJsZU9lQXNYN0Erb3R0RnRTRXhvclFB?=
 =?utf-8?B?TURzZE5ISkFYRGJrZjVEK2xyRWZma09LLy9ZM3lIMHdySFQrL0s0UHlUUU9u?=
 =?utf-8?B?TnJNNmFxcEpIMGZEeGxOT3RrY1ZKSFE4UWtFbDd4YUNLU2M4akxyU1RNV0Na?=
 =?utf-8?B?MFp1SWd2V3d2TlBySU1pTG1UY3NaTzhYZWJRRzFxTGVYNHVLNERXNit3b0tP?=
 =?utf-8?B?bTE3L1JBbDhldnNneTdtZ2JKcVhXLytuS29VbGxjUGhmbW8rUW1mU05IKzl4?=
 =?utf-8?B?MlVMY2IvbWF4aXR0cy9PcUFpSUtEOW5OYWxxeXkzOWQxVUVIYytVQm5xU2VZ?=
 =?utf-8?Q?lumY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTNHR0hWL1kxbUZHY1Bzc1ZYNlhpQ1pKTUtaRnZBWnNvU3FVTk1CKzJCQzVI?=
 =?utf-8?B?ZEEyMWQ1eGdZNnhmMUpIUmVMK3hiRlg0REU4ZVczclcrS0hoUElYcnJ1WCsx?=
 =?utf-8?B?NU9nRWN1bXFOeTUwUmpnRlhaUkdIRURIejQ1M1YvZHg4ZkEweTFqNmtrdVlV?=
 =?utf-8?B?Uk5iN3FjNjBVSnE2a2d1bDhUL3FhdVYvbmhHRVl4T1N2S3MxNmFMVkdHbmtx?=
 =?utf-8?B?LzdDMFVNQmU0b1B2bWgwNHVITzU5d0xGR2hsSmhYNjNxQmdlNzNteTFYenNQ?=
 =?utf-8?B?a1hzd3N2R2VQM3lWbVlGTlNjbXYzdmhtSGtNeGxrN3BET2cxNUs0V2JoYU8v?=
 =?utf-8?B?S2ovQXd5aStLWEZha1VERDNORC9ycnRDN2ZDSWVVdHpQdTNicVZzRlRWMnlq?=
 =?utf-8?B?VGhldGdoOHc4L2UzdjlJdWtrZnhWU3VTcDI0dWh3VlZjdmNYQ2ZEdkRvU1p2?=
 =?utf-8?B?eEVGMkxRQlRUek96M05yTUhtak5zN2JkWW9GdUM2dVkzQ0E1ejV3OVgyNkpi?=
 =?utf-8?B?bnd5OVltekhuQWdkZ3BJSXFFM29WMlBYb05QbHh5ZDM2TmpNTWxaNENTQmxY?=
 =?utf-8?B?RDhkMGt4T2dpaU04L1hIdTZXVE9IZU8xazA0Tk1DS0pWalFlTDRxUFczWjd6?=
 =?utf-8?B?VTRCUWZIVkZ0VnA4dSswUHNJb3dBeTNERmE1MERPejNxUCtHRWR6MVVqK0o0?=
 =?utf-8?B?OGlKeEZ4Y1BaZUYzbkhweExndmxTMFEvY2FHSFFHWTBncStkZFpkMCtDZ2pq?=
 =?utf-8?B?T3pjVXVWcWw0UVlMZGs5RmJ6bUs3cXYyTGw4ZnNSNWl6bU1MQlFXb0hkYUtQ?=
 =?utf-8?B?cTVaU2oxeEYzclF2THQ5N2lPaW9EUnFuZzRsRFFsWk9TbitnU09PVmR2S24r?=
 =?utf-8?B?Q0FFc3VNeWlHNGo5MTRBNDh5bWtqaHE1MGxXdkZ4R3hPQ21zRjJBVjR2bkZr?=
 =?utf-8?B?b3p5aTN4WEtxL05TVXFQbVdxZzA0RHVwOHU5OEYrdDZSNHFlN1M5YzJ1R1RH?=
 =?utf-8?B?Q3lWSi9hMi8vRWpJUzVlS0k0U1B4WnJYNXAvT1JvZ3JkUnhPZjlBSjRBd201?=
 =?utf-8?B?cVBOc3RZdDUzZ2JVWEVXUVJ1Mk1oZnFxTzdMemFtS1FkZ24yK0JuTTlyWVJ4?=
 =?utf-8?B?dVJtbGRGQ05hbmpTZUdpM0NGcjFucEV1cFRVRFZDU280OXNOWEJxbzljSW13?=
 =?utf-8?B?dXRwNkJWTVdDaUdmK0lWeU5GVHh0d0p3V0h0YjB1Y3REbEptZjIzZS9mQ3F6?=
 =?utf-8?B?ZFNCVjNQUTdQTGZXZTAzbXJHNHN3Sjg2M3JQSElNTXdER3RVYjR5QmpLVWV6?=
 =?utf-8?B?TldpOGxra2FaMTRJMDkvTUNOMndOMklEVHc3bFR4NSs5eTVwU1BaUUZsa2tl?=
 =?utf-8?B?dUVOM2dyN0prS3pNS0djbVo1U1dqS1owUEdiY01xVThOeU1pem0zNzNoNWlq?=
 =?utf-8?B?Y0hBWVhFVno5MGFCWWdnbnRVNmRCMlpFSVRyL051SjlXby9DUkl6UVNYZysy?=
 =?utf-8?B?a3NLMlNpbVY0QjZUNjRITnNFVTc1d005NExUcWQvQ0xDbCt0aFdSaEhDK29P?=
 =?utf-8?B?eXVKbGZjNUFrajYrNEJNWWpzV1RYL21SalMzZ3l2amJFUVdNWnNxd3VGcXhG?=
 =?utf-8?B?TTZnMlYvNnphNkdqMkNVaDUwOWF5ZThhU0lZVzFTYlorOG9OY3NyQ01GaGhV?=
 =?utf-8?B?MEFoSXlONUMrVWZpczdVRXZWQ3pjYmVtaGE4cWdGZHp5RWRMVi9DZWZ5YkFU?=
 =?utf-8?B?R0Q4OUN5NHMxMlFXRnR6YlY5ZnFNVGc3S0lIOFptdVNtK1BBOUUxL0dLcXJE?=
 =?utf-8?B?MHoxREMvU2IwbDZmelVNQnE4SmxMM0hqUk5iZE9vWTVBdjJTbzJJQnBYNmVT?=
 =?utf-8?B?clVWWDk0dkVJVHA0L0hBNWVCcDgrOUtaOEd4VXBQdTZXaS9xTGZ0UnBWbXBM?=
 =?utf-8?B?QXMwQkFnMzlBZEVvSGtJSkwvMmx0Z0E3aTdGU00ySTA1elpNZENwc0kvOTJi?=
 =?utf-8?B?MCttT3pUNFB6WFdvaWRsL25OSkR0VEVvREthUzEyZ1FCOU1PUEFNemRua1lr?=
 =?utf-8?B?eE5zbFBDZkRGaVZtb0lMZklLNmRNTFNieHRuYUhOU1RxUjFteUdXY0lrc0to?=
 =?utf-8?B?NDRaMGZpbFV5U3hUc3M1bjFmRDhwMUdZa2RvZktMRThRc1lscU0xQm9RYmwx?=
 =?utf-8?B?dVhqbmFubkhIdEcyQUR5WjBxMXl0WnMzWXZQM2ZIUWtXSFlRM1dEbS9xY2VS?=
 =?utf-8?B?Tlp0czQyaUw2Y3UyMlpvR2R3ckV6N043ZE9vbm02NmhZNEsxeVA4MlZMMlJL?=
 =?utf-8?B?a1JWVzNBTWhrcnZOSy9EeEJmYWpLZzJSTmJyMHdCc3VlL1dNclFtdWxFOVFL?=
 =?utf-8?Q?VaYMKkb6a7LeFReI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 611319ac-2af6-4aff-57eb-08de6ed90037
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 10:32:22.5792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OaoJLRjlnztQSSSCPl1qRfypslF/M5WMrkLayvK7TO/MZw2RItG3g1TqBD42gllmUj1JyqK2YhizypURDqSHgxGMDtBmKyDwF+TdJxiGI1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5108
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

On 2/16/2026 6:23 PM, Bruce Richardson wrote:
> On Fri, Feb 13, 2026 at 10:26:29AM +0000, Anatoly Burakov wrote:
>> Currently, parser deinitialization will trigger removal of current RSS
>> configuration. This should not be done as part of parser deinitialization,
>> but should rather be a separate step in dev close flow.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>   drivers/net/intel/iavf/iavf_ethdev.c |  4 ++++
>>   drivers/net/intel/iavf/iavf_hash.c   | 13 +++++++++----
>>   drivers/net/intel/iavf/iavf_hash.h   | 13 +++++++++++++
>>   3 files changed, 26 insertions(+), 4 deletions(-)
>>   create mode 100644 drivers/net/intel/iavf/iavf_hash.h
>>
>> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
>> index 802e095174..70eb7e7ec5 100644
>> --- a/drivers/net/intel/iavf/iavf_ethdev.c
>> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
>> @@ -35,6 +35,7 @@
>>   #include "iavf_generic_flow.h"
>>   #include "rte_pmd_iavf.h"
>>   #include "iavf_ipsec_crypto.h"
>> +#include "iavf_hash.h"
>>   
>>   /* devargs */
>>   #define IAVF_PROTO_XTR_ARG         "proto_xtr"
>> @@ -2972,6 +2973,9 @@ iavf_dev_close(struct rte_eth_dev *dev)
>>   	/* free iAVF security device context all related resources */
>>   	iavf_security_ctx_destroy(adapter);
>>   
>> +	/* remove RSS configuration */
>> +	iavf_hash_uninit(adapter);
>> +
>>   	iavf_flow_flush(dev, NULL);
>>   	iavf_flow_uninit(adapter);
>>   
>> diff --git a/drivers/net/intel/iavf/iavf_hash.c b/drivers/net/intel/iavf/iavf_hash.c
>> index a40fed7542..d864998402 100644
>> --- a/drivers/net/intel/iavf/iavf_hash.c
>> +++ b/drivers/net/intel/iavf/iavf_hash.c
>> @@ -22,6 +22,7 @@
>>   #include "iavf_log.h"
>>   #include "iavf.h"
>>   #include "iavf_generic_flow.h"
>> +#include "iavf_hash.h"
>>   
>>   #define IAVF_PHINT_NONE				0
>>   #define IAVF_PHINT_GTPU				BIT_ULL(0)
>> @@ -77,7 +78,7 @@ static int
>>   iavf_hash_destroy(struct iavf_adapter *ad, struct rte_flow *flow,
>>   		  struct rte_flow_error *error);
>>   static void
>> -iavf_hash_uninit(struct iavf_adapter *ad);
>> +iavf_hash_uninit_parser(struct iavf_adapter *ad);
>>   static void
>>   iavf_hash_free(struct rte_flow *flow);
>>   static int
>> @@ -680,7 +681,7 @@ static struct iavf_flow_engine iavf_hash_engine = {
>>   	.init = iavf_hash_init,
>>   	.create = iavf_hash_create,
>>   	.destroy = iavf_hash_destroy,
>> -	.uninit = iavf_hash_uninit,
>> +	.uninit = iavf_hash_uninit_parser,
>>   	.free = iavf_hash_free,
>>   	.type = IAVF_FLOW_ENGINE_HASH,
>>   };
>> @@ -1641,6 +1642,12 @@ iavf_hash_destroy(__rte_unused struct iavf_adapter *ad,
>>   }
>>   
>>   static void
>> +iavf_hash_uninit_parser(struct iavf_adapter *ad)
>> +{
>> +	iavf_unregister_parser(&iavf_hash_parser, ad);
>> +}
>> +
>> +void
>>   iavf_hash_uninit(struct iavf_adapter *ad)
>>   {
>>   	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(ad);
>> @@ -1658,8 +1665,6 @@ iavf_hash_uninit(struct iavf_adapter *ad)
>>   	rss_conf = &ad->dev_data->dev_conf.rx_adv_conf.rss_conf;
>>   	if (iavf_rss_hash_set(ad, rss_conf->rss_hf, false))
>>   		PMD_DRV_LOG(ERR, "fail to delete default RSS");
>> -
>> -	iavf_unregister_parser(&iavf_hash_parser, ad);
>>   }
>>   
>>   static void
>> diff --git a/drivers/net/intel/iavf/iavf_hash.h b/drivers/net/intel/iavf/iavf_hash.h
>> new file mode 100644
>> index 0000000000..2348f32673
>> --- /dev/null
>> +++ b/drivers/net/intel/iavf/iavf_hash.h
>> @@ -0,0 +1,13 @@
>> +/* SPDX-License-Identifier: BSD-3-Clause
>> + * Copyright(c) 2025 Intel Corporation
>> + */
>> +
>> +#ifndef _IAVF_HASH_H_
>> +#define _IAVF_HASH_H_
>> +
>> +#include "iavf.h"
>> +
>> +void
>> +iavf_hash_uninit(struct iavf_adapter *ad);
>> +
>> +#endif /* _IAVF_HASH_H_ */
>> -- 
> 
> While its primarily a matter of taste, do we really need to create a new
> header for this? For a single function prototype can it not just go in
> iavf.h directly itself?
> 
> Either way:
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 

This code is not touched further down the line so yes, I can move it to 
iavf.h no problem.

-- 
Thanks,
Anatoly
