Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A10ECD6D0
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 17:54:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79EBC4026A;
	Wed, 11 Feb 2026 18:54:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1798D400D7
 for <dev@dpdk.org>; Wed, 11 Feb 2026 18:54:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770832473; x=1802368473;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=8kpI9mh1xMNIfggwUb6J7kg/vzUHdNcGw4bVLFxM2Fk=;
 b=JLNOgjv0sNY7rY55kWMYmpTehNsWUO6t94RKfpKfzHKAebXr1JletwNb
 N44rdSrlSvhQfD1b3iOWsFudc4tczvlsJpwKznIDl6chAp9ANimfBb+zo
 QNHD9/gUMy6XoC3vCVyTz6/PKps7pzr5FSApOX6BMEp6z06fycqLQFobV
 3b4gOtdEOEleGWKkGafU359Y8G4shfl4tFEwZTy5dZVMw7s7ZuRqGE7LO
 3Qgs9fyhQeKpCaIZoLXNZLC7uSJHnqmokXWio6xoawNAPc4jAMcFBYRJD
 JAHf2YRgPVi3EKlOlMr43cEqWfZcnJs8333qlNUwjieZgQuSSqwpJud/e Q==;
X-CSE-ConnectionGUID: JyC4hTnFRXmrfOdvajXR4A==
X-CSE-MsgGUID: q9Yg1pCJRLK+E2mYfwWOow==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75613451"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="75613451"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 09:54:31 -0800
X-CSE-ConnectionGUID: tvktf/BBRjytThYgj3ko4w==
X-CSE-MsgGUID: AH2JGLSgSOa/qTWkBFvN/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="216840267"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 09:54:31 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 09:54:30 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 09:54:30 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.22) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 09:54:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLOSPTVzMUadRGDo32IBsllBLvBXa5wSOZO0yAKt9u0GFK/aR3BnJKx0/YTK1NGsz9uk9ulF0R3K7vr4bNV4v1ZrPqr5cedgUjfdTjUuOpg/PnrYkfy5eoA5JBrzAoSa0UB/sVFROvM43ll6hjbkNw+IevjnTH0+I0ASMHpzzNA8pIyulI8/LziniJfRtzePKFSdHB9CPjtKtqfAYSiMLwW0ywGqVAGuFHOpigiX7DbzcY1RGIsIlV2E0yExgE/DfSditk65+Y5GRlDUi3PhFNINwSdKuqFC+te2S6RQQwnlgOFX1kP02hO2bXZpuGfjTXLOdO+5CuPiTJBt2bvlmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pw+pBt53gXS874RySIsKnUupSBFg5PN0YZRv3AnW78g=;
 b=rMfltDZRbAk54ZhjZu6H5Qvwmvet566QJE3PP7/K8aM/I4xq4XfwNtAbaq6pBG9ncEjqCEx4AzXVt9pGoeWAZntsWalT+kxyNAJFmGUHBXre+CqVZnkllK3/7vMk6lgBk3xKyiI+Cql4Zdu7n1F8H2f+IRND9X2ec2pVomcXSMzuuzYq1GIuHRYUOWaUG9mQ1TTbiNnrEj58bNshn1+C6i1DY/s3gpsjE5XU+I6wjsaykpUmhmFWYxISukByqgoG+Kant+ear1mtRshanEuGaUf7Rr7KAKirxyLdaXLqFdBpGLi5bKohoZEy72OvU7uQFCb6EO0wPP0XIN3cZH6XQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by CH3PR11MB7762.namprd11.prod.outlook.com (2603:10b6:610:151::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 17:54:27 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Wed, 11 Feb 2026
 17:54:27 +0000
Message-ID: <5eec8b69-a9f6-43b4-9ec2-3884741f3354@intel.com>
Date: Wed, 11 Feb 2026 17:54:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/27] net/ixgbe: remove MAC type check macros
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <e9fa029039ae5da4f3ec3533a4d826210a6a1d2e.1770817884.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <e9fa029039ae5da4f3ec3533a4d826210a6a1d2e.1770817884.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0167.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::22) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|CH3PR11MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 122263b7-8909-4338-2e02-08de69969971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnUwZ043cldTcHhXeUd4NFhzaGRKaFk2ZG9CVWJzVHhHc044dDdrT3FtTThM?=
 =?utf-8?B?Y3AxV3psMCsxYXhNdVpmSFk2UEY3dUlEemcyY1dQem1rUTIzQlA0RlNMdG5T?=
 =?utf-8?B?ell6cHA5MUF1TzR6c2xwdDgwOFBIWFEzWGFGbUlISnpHTVRIcDRzODdMcE5I?=
 =?utf-8?B?UkNFWlp5Mk85NUc4WHlhNzU0OVh2ZXlMRmdZNk14YjBPdm5kNDEwNnNRendR?=
 =?utf-8?B?MDhCUVhmcXR0RVdLaEhuc1IvVjVvaE9FYmg1RmhGVHd1WkE1YzZ6QjA4UnNX?=
 =?utf-8?B?allnMUp1RElpbW1yZjltL2kvbC9yWC8xVkt4TUtNcG9kdUlTMU9PTVk1NytB?=
 =?utf-8?B?QU1tUU0xZEwvQi80NFBZMWpUZWgyZXRHUnIvSlhreXpoUjlGd2lYcFNHd1hO?=
 =?utf-8?B?d1FVblUyejB6QmlhV2VuSitrM3M4V2kveDB5eThmbFlhNTdGaDlUaDdsV3F3?=
 =?utf-8?B?ckIyZDJ5TWNNeFV3S3l2QWJIREZCaTA3R1ZLUmVWT1NKaTlsMmM0a2hQRnhI?=
 =?utf-8?B?SUQzbmxpYXFyWE1ldG41RzRuaDVYOG83T0RsZ0NLZFBjMFpMdTZ5a0NjOHRj?=
 =?utf-8?B?MVFycTFTdENUL1l2OGgrOVMwK2ZwN1MrRjJweUtFNFB6d3BDOEN1UFNGYjFy?=
 =?utf-8?B?OEJrMmt6S1dkTEFHK2E3MHFwenRXN3lzWTNYVjFOeEdXU0c2UHFpd0srbFNW?=
 =?utf-8?B?V0I1bFBJNCsvRmhXQWFHbnJncytDU0w1YW8vR2p1WEFuSkZFUHdsaEJpYzhz?=
 =?utf-8?B?ejJURUU3YlYvMDBaT0ZtK0pOc21VT0piTXZiaFRYbm1nMElhMlRVeUo1OEJM?=
 =?utf-8?B?ZDN2aXNSZ3gzQ1EzZ1dFK1dJc1phTTlmbnR6VmQzbUU0RTg2b1NLYU5SdmI0?=
 =?utf-8?B?eE5pR1dDL3hDak5HaTVveU5sQVBUbEdkM0Z2QkJITWZQN0ZPUVpTZDRpc2dU?=
 =?utf-8?B?QkMzaVRqMFBkSHBsNDFOZ1NsT2tUVjBhUURYQlpUZmtyMFd3NlJmS3hqTTAx?=
 =?utf-8?B?OEpGTDlrdFU0bFNSSGZiZkV3YmYyWnhGUnl2SkNyZ0pjL3ZzSnhKQWdNWUw1?=
 =?utf-8?B?WGJXbDJoZzZBMnpRbmJkbGY1a2hPNkdmZGowZnRZYkVxREFYTHdhblA4ODJw?=
 =?utf-8?B?eUdkczd5RWY1YTdacmxpay9jcTJtZXZOQ0h0dVBJQjdhM3Nwem5YdXZDdGxz?=
 =?utf-8?B?UWhYU3RYa1hacmd2aVRKN1JmWUJQSjZwd3QzajEwOFE5WG5kQmlXajBFTGIy?=
 =?utf-8?B?cXI0bHN6bGtYaTRlS3VDNFpEcUxTdTFHY2J4T3M3ZUEyMGtPRUdWc0JpOVNu?=
 =?utf-8?B?ZkkzOWZpajlmN3JuTXB5ZGkyYWJxa1RJRGlSMEFJYW1rd1NEVnNBbGN3KzNj?=
 =?utf-8?B?N3VYQURnWStUSVpzcWY1VEtvbUlYVmhYWTUxVUxzanIzVW4vSlZMWkljMjA5?=
 =?utf-8?B?WUZMRGZORmhXZHFFM2VBQUVZOEtyR25YQ0ZvaTk0T1paMHF2VHVlL1E0YkRM?=
 =?utf-8?B?d1VLcjRSUktXOUpaL2NMMGp2TEM3S0xHQjRHMS96TGc0Ym4yVVBJL2pQSmZ5?=
 =?utf-8?B?T3l5cDIxaW1XbVByRXZLQVkvWnlHSzlXeS9FTi9vbHl4eTVHc1dZUnZvNDBt?=
 =?utf-8?B?NGN4bW1OOUJYWEJsYzVTZVNuZzhFanJVMXVnRkZoRk8vRXIrZ0grZ3hsMnU3?=
 =?utf-8?B?OHJmSEIwSFNzNHljeFBvaVlHaDNIaVllKzR3VWZKWWh4aVlXQ2piR3VaVk1U?=
 =?utf-8?B?WEFaOXlJUStmNGxINUJLdnYrWFlOMzJYcGRRNi85TGg5dm43ZDFlcGxhSEJa?=
 =?utf-8?B?cS9PdHZGUkVkR1M1VUczSllxMkhwblp4Tml6MTJscENmSzdMZ3VXVEoyZ3RS?=
 =?utf-8?B?Z3A0VmY4RU1QdWNMM1RKNVhqWlBOZVBKZ1ErRFpRZ2gySUVwbTNvTHFmaUk0?=
 =?utf-8?B?bEZoYmNDdW1qVjZZaGJoWEhpZU9pb1YvZkxwQ2xOM0Nvd1RDKzhVZTJnU2k1?=
 =?utf-8?B?YXFNVUticG5JbFkzQzdzZktFYXFsTlh3eG5SN1BEbGFFVjN1dmRxSEIwQ2NQ?=
 =?utf-8?B?bmVnNnlFUFhoK2U0MFNUZHg3dDFwRGdWSjQ0TWdCcjdOaUxndkNjaTR4Miti?=
 =?utf-8?Q?Dmqc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1RxUGtxZ3JJM0FIdVpITDQrSGlDQ2xBSGU5ZzJveGVQcnltQzdSbXdtekdK?=
 =?utf-8?B?QXZPeE9CMVdRWXk4RzJXV3VJQVFCS2Y1Z2JWYlFERFBrYkRVdmFmVERXVjVT?=
 =?utf-8?B?SFQyTnFMc2U5VzRXQ25vZG84dk1GLzNCSTl3SUFsOE9RZHdhWVNibTNncHVI?=
 =?utf-8?B?ZzBkY2RzYUNCV2hqdmJjcjV4TnVkY0VvMHUrV0I2eGI5TmJUVmJjWmd5dDBn?=
 =?utf-8?B?eVJxV2NVcDBHL2hVK295S3Nia3pHOXhGbkF2cVU1ZkV2dVZ4ZmJOaUIwUFgy?=
 =?utf-8?B?RTRnR2F4R2ZEY1pMSzVrVXM4akE3cmY2cHdKVXlZWjN0NFhzbmVlcjlJWkJR?=
 =?utf-8?B?anJyN2NxcHpDeHJlbW1SYUdUN0tnNUxHRERyWU1SbUFYTUw3S3MyWjVZRWFZ?=
 =?utf-8?B?S2FMVGkrWlVabSt4aXVxbzk1ZWNjZ214TU83WW5KR2x5cU14bXl3RW5zamYx?=
 =?utf-8?B?alJHS0xtT3VRVWJ6NTJBSDFjNGpmcHhBZUlpOTJxNXd1anhsZVk4RG82Unlj?=
 =?utf-8?B?eWR4bERvWlVyRXlxU0psYlUxM3diMzVrWFFnQU1MUmxsWFBINDdMR2lRS1Vr?=
 =?utf-8?B?OVZiYlk5Q0RnRmZnMjlDQ3g2L1ZIS0JVR0JsRVVhRHhMaUkrWUFVUXpXTExj?=
 =?utf-8?B?b1lDL0ZkSjdtSUtrMmphbGNSYlk3T2RpTm9QWmJrbm1iTVJnRTQ1a0prcW5I?=
 =?utf-8?B?Vms3V0Q0SC80cER2UkkzblNKZEt6bVg4UzlOUDBwSzhOeTZhYTBaM0hiNFlp?=
 =?utf-8?B?SmNqaWpGazRrYnJGOVd0ZmVVdmNCUCtqSWFUaThZeEVXSDYxL1lDVnRKdzZV?=
 =?utf-8?B?RURVWkwya1JOY1JpRWJEVnljT21TOHBvTDZGeVNDYTV0dkt3Q1lab2Q0TVcz?=
 =?utf-8?B?bXdudjR1NEpZdS9EWjZNMWgvcks0RHFuYWxTbHBmemdISGZnSFZKK25sUHhP?=
 =?utf-8?B?VHI3YmhSUFo3M2p5SjB1ZUxYYzZYdW1Lb3R3blhidHVEemhub0xTRWpmNllk?=
 =?utf-8?B?OG9WUmI3TkZXaHh6KzJWVlhjeVpnU25ZbWlPeVFoTWw3OC9ML1B3b1NkQndm?=
 =?utf-8?B?S2VYODZQZCtkVkxkTm1iTFYxd3RGVmpBaGdwcjdiTGRHSVZsbUFHMlVpR1BS?=
 =?utf-8?B?ZE5xbGE2K3dMSGJ0Q21xY3ROZFZ5OGsvUHZwVEdyZTNpRXpWZ1NIek1VYUMw?=
 =?utf-8?B?ZHR0V0Ryc1dZZUJOV2N5UUN2TldIbHpnSDNld3ZrUTFlbTFEcjAwcHFhVnhv?=
 =?utf-8?B?bHpPd2ROWE5SYzJ1eEN5U1hlb1ZQaURkSG43OWx0aFR2M0RRUTRaQUxvTERC?=
 =?utf-8?B?bWErcnhDc095Smpnc1hHRXV0QnlIMW5wdWJxb3BNOVc4akF3d1M4VlBYNGg5?=
 =?utf-8?B?N01ZRWx2U0NUSHVDazRHUEN4N2FVY2U0MlZ5Q3JqQTR0LzBBMDBuQjRrTlZy?=
 =?utf-8?B?QmdQWmdvV2E4dnVhb3pybzd0eVNDaFdRUXBIQ2tzYmN3a2ZlOHZ0SnhEOW1B?=
 =?utf-8?B?RjIvRkozcCtMMVRvT2l6SzNzUHpuMHU0dUZkVzk0WEJNK0R5Mk5iMjRHNmNh?=
 =?utf-8?B?bDhVR1ZpQ0tGZGZhSzJmU2tkdjNhelBMbmFBWTNDYXdVK053WStuUUlyL1d5?=
 =?utf-8?B?QXlzSzJPalJiaEdiL3dTZHJOSjhQaExMa3ZObnhOcnZkTWVFajA4S2xuKzRJ?=
 =?utf-8?B?dXlmc0hheGxwd3g0WWZvV21ySDlJakxSR1g5N3V0cnRMWWY4OXM1d245LzRR?=
 =?utf-8?B?WFZLZWV1WU1KZEY5NGJidm04TWcxU0Zvdm9UamViZlNGQlY1cGh3U3JYeDZn?=
 =?utf-8?B?bG1mY3M2REJ1THpmbGdhNjlxNXBBK1JyMnFqSVJFNjdPZnNYSCt3WEgxT0Qr?=
 =?utf-8?B?VU9sYkFodFpEY1NMTHR1c2dRTzlZckY4OXNSTzlWbnBxVFBiNlc1dm9JRXdx?=
 =?utf-8?B?WUozdktCNko0MVJZVFBaT1AwVTBlMm9FbmpvTVBSdS9uTWhhOWdVRFAyUXZj?=
 =?utf-8?B?bkx3MWlEK2xSS0FneW51VUQzNHdCdFIvdVJ0eW1XSmdMZ0FMcDhLMXdPZlpK?=
 =?utf-8?B?RWxkWWZ4ek9ralkweE1CeFFlQ1I2OEFTZUszcUVucHIrNkNtR3hEWFFteFp4?=
 =?utf-8?B?eXZmZGlJNlpYSjM4TG44YTRFODVjdUVDU1kzanNjeUJka21NRm1Jem1rc2Y5?=
 =?utf-8?B?YW5qcW9DVTA3UUxwWWdLTXM1WVVkOWUvaVM4TDZ0NUh0YkxaSHJGSkRuTldN?=
 =?utf-8?B?RUpyVzFaaS95M3RyanRuWm11VzRHc2pLdWJjdjZUdU9aeVJBeW9HK2hmOEtD?=
 =?utf-8?B?V2laRFFhSW1lNno5dW5MVUYwYTdMdmVXY3JZYnpqTHpGMnRxamhhcXBhalU2?=
 =?utf-8?Q?5exYxS5xTzAydm/Y=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 122263b7-8909-4338-2e02-08de69969971
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 17:54:27.7257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1g4oi7uMLfKPLboj2YMjGmCrlHFuOYCtWZMiyF+G6Log6ux1cwMgVPuLzuoUaJM47NR6tNel5wvG4YbuS13RxmNOi/7s0mgx390DZ0lhYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7762
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 2/11/2026 1:52 PM, Anatoly Burakov wrote:
> The macros used were not informative and did not add any value beyond code
> golf, so remove them and make MAC type checks explicit.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/ixgbe/ixgbe_ethdev.h | 12 ------------
>   drivers/net/intel/ixgbe/ixgbe_flow.c   | 20 +++++++++++++++++---
>   2 files changed, 17 insertions(+), 15 deletions(-)
>
<snip>

-- 
Regards,
Vladimir

