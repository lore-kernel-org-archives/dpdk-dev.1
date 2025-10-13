Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC4ACCA476
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 12:25:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B803402A8;
	Mon, 13 Oct 2025 14:25:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 4893C4028C
 for <dev@dpdk.org>; Mon, 13 Oct 2025 14:25:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760358355; x=1791894355;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HebnolvZAMPALSomApbFET4iLXvzhwmJ0ZoHlEUjM5g=;
 b=TCDkL58KVabel5fMFdu4um8JAZz1uXTtcfQxSA/fJi8yYU8ybK+FYCL7
 r2P8xTbsfEnGX3qs7fa86SRdqJqtgf0fu9+wuAGupCAMM/SibvXcl3ca/
 2M+E5IW3Z+lJcnU2pLvoqTlDXMSONVrNHGbxV5F+GE1t+uiA2SnazTtwm
 zQE7iuhFXeRFHif7XRsWLV7WYetiUOpxwAh8Nm1ptIuv28NyKXYQ9c/tx
 thng9INwdxwoAGCiRCOI7KehCngSuEaHhqDlP4zuYfjB0l0m8e1bNoTVf
 1qoY7rJCbZh7pWR260F+7viJws4mQH8FJlOXPASsIKJVoqIc3hjlfD8Od g==;
X-CSE-ConnectionGUID: lZlk83oeRb2jXKYOcINr2A==
X-CSE-MsgGUID: IWTCo2INS4SAD8q9OsCfsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="85118893"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="85118893"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 05:23:28 -0700
X-CSE-ConnectionGUID: J1TcIDWqS96SsCJjm2diEQ==
X-CSE-MsgGUID: 9Jy7HNhbQVebxkuGhyrh6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="182022056"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 05:23:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 05:23:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 05:23:19 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 05:23:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8gvvN/KVtzWvzryn+xTCMROPr0Y0bOdkq8rAvegmuOrqY6FIW5473wTto37QzKGpcgOqQHmZxwufO7+z+Ay3rL50LseHcfrAtp5Ogy9ZUX87SZB/m/wqzS+TUC0dNv9UXYrt4PC60hobOmD4YRNkop9/CeJVg8YDjHFABTN7IAh43PJ34YJK7XAl5YuF31gwzrMF3V+lg+pwkIhs5yrPkZZR5CokXekyY8fAbOv62r6ICMYn2Kb7WVI2Epffsm08u4DZ0mrc3ISLKUnS2ZJWwzl/vN2nBp74kSHQ6j1+9xjvSSOarQuCwiMWbAfvKDd2teUCCtusy8hbMHqn6YwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIlewPOQ01OaU0JU9bKD2fsPN80odJBPTzHSYQYe8HU=;
 b=rZXCRrDWm73OfPnMv3jtTnTBd4GV7YOokKUdUTxk+YuAm/MPr91fkd7YFi5qvF1eyAVSeTvST49oXioxJumhnYpC/u3YKYsYl9hFbyhIC0W0m57yEoggrDlTfB9fv8tZHsml+iMtQ14cwtXz27kffa3+fdjxqee5pcHkFHv6TVC2oG7JqHdaF6oMvcObQabRTCqzuyDokcsVI+yTBwCbIBvnPJ3v6Yq9bhs0X8gTnXRzR4ixkBu7PHO0m8wSu6sVCkUpIeXj7lkoku/R4uxTFb4jPiv9IN2Pw11U2xz0zhuyZRS7tUHt9n5Tk46z8fPi7AJ4Jp64R/xgU+/vb6d+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA1PR11MB5897.namprd11.prod.outlook.com (2603:10b6:806:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Mon, 13 Oct
 2025 12:23:17 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 12:23:17 +0000
Message-ID: <e320c9ca-c166-42a7-a4d1-7ab1f41934ea@intel.com>
Date: Mon, 13 Oct 2025 14:23:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] eal/freebsd: Do not use prev_ms_idx for hole
 detection
To: Jake Freeland <jfree@FreeBSD.org>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <20250814213246.4141803-1-jfree@FreeBSD.org>
 <20250814213246.4141803-2-jfree@FreeBSD.org>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20250814213246.4141803-2-jfree@FreeBSD.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P250CA0011.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::16) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA1PR11MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb96619-6cd4-4395-a356-08de0a53497e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVJzbUZQQ0h5S3ljOGRzcHB6V0xFNXQxODJPOUJVRk5UbWRMQ2Z0RnN4QVpJ?=
 =?utf-8?B?dVBIeWpBdEhXTmI5MTNORlVFdktQUjFmQmZuZGFGTkpWKzFDdGlOK05uYlJ0?=
 =?utf-8?B?bXdZL3o1azR5dU0wNW04UE1hL3AwZSs3eUVWTVplTjAweUkvcFJPME5zMTV1?=
 =?utf-8?B?a2VhK1M2V0xFdWNCZTZYNTYxS0FiWjVRc1BTYkYxdzk0bVpYNzRxelgwc2Mz?=
 =?utf-8?B?YTV2eDZLaloydEZ0Rk9lcE96b2pNZi82SUIxeVg0SFBUbzNzenJIMU01c0R0?=
 =?utf-8?B?RUN3ZERlS3NKODlWZUxyWEtMQks3WjlNdUk3QndnUzNKY0NJbzB4cHFKV3FB?=
 =?utf-8?B?RkZqbHZNdkgrdU91WEt5OWYwbFRDd3hUc1ozWHpyL1FoNkdhQ3lldXB3SXZT?=
 =?utf-8?B?WHhqYzJvTFhxZWdSSHdjQlZQaWFMczVrTmJEbDU0ZC82RjNFTUJyYnF0TW1R?=
 =?utf-8?B?eDJoTy9hVGNsWUV3L1lNSFkyYlFZeG5oT1ZuU0paSHBhZHE3QWhVTkJOVzVl?=
 =?utf-8?B?MGprTjZLVnVNVS93VXVRbjI5MDJSemlTUGt6M2FNeWxONkxtblQ1aTdORHJp?=
 =?utf-8?B?dFZSbDhJTmFxNXdTK0JjWDRFZzArUGFlNUxHeGQzb09velJDWks3TEh0WDBY?=
 =?utf-8?B?Ri9ZcmlnRWhJVjBaNXBOSmpobjFtUUpKdWdjSkF0b3JjWFRiQjZ4eDJacHFX?=
 =?utf-8?B?VEorNTltV21CNm40QWdVWmNIbUlycWloRkY5Z2ROc0tJWnZCUTk4MUJjcXdE?=
 =?utf-8?B?eU9QWmZFYVhHZkpPUC9vWDRQeW9PbnlDcDVHaENPREwvTU1TZEtwaExtM3lC?=
 =?utf-8?B?Y3QzRmJMV3FCVEttdW56bCtPT2FnMXFXQTJtSWUwWmZCaHFsSyt4WXhtVkVC?=
 =?utf-8?B?djJJNlR3cENBcnJ5QmdZMHNGaU9LL0NvNlpEelVsQ1hUa0dHV2ZpQjhDd3R4?=
 =?utf-8?B?MDdkNGI5OFJlU1pvNDJZemVkTVpOZlNiRUkyeWF3TGFzZkZvb1dYb0xSc3hR?=
 =?utf-8?B?Z1d5cDVwdUZKNDFZc1Z0U01hMi9QVHEwUVBXNHZLZHNqNVlFTGczMjczUEZM?=
 =?utf-8?B?MmQ1cEZHbDZ1RnV5QUJnU2laN2Zvb0RGaElSMXRBSlRibXRZYk9aSklWNG5O?=
 =?utf-8?B?UmdDQThvRlZmbnlQMGYxdWEzek9TeWFrSlFmRXFwdDNyQUlzMGlFcUJYZzRL?=
 =?utf-8?B?c1hBRS9SVG1iR0NidW9JVG5LSlVYQTg1UVFjWVFyNFQ5VEtLL1NpYmxibThz?=
 =?utf-8?B?dmNuR2MxUDVaS01pMldnMkVycUNwMEs5VzdsT1hjV2V6UktDUmFyVjAvYzhp?=
 =?utf-8?B?by9KOHRHLzZYRVh6bHQxdzJ6R2pGZDVYUzFNbURITU5ON0F1RkU5R2dFNlcr?=
 =?utf-8?B?cFpBQklaTllsVXE5NFV2aERWVEUyRHA1bDltMGFJeWRIL29kazMvQ0FWS2lS?=
 =?utf-8?B?Z1pLRlpjeldxV3BMVmdvZVBNTXhUMFM1NTBmRjVCWWE2aDhqdE9vODlLblo2?=
 =?utf-8?B?YUtvNlk2aFN3TDNuazY1dDlZcWRXOTVmNWNDdUh3bndwR2I5NS80MTh1RWM0?=
 =?utf-8?B?MU9jYk00VWxxQVhxT0xQYkZZNURkSTMrZ1QzOXZDNGFhNXZGR2NLdGRKUE9h?=
 =?utf-8?B?OUFQRXdHSkNrRFc2Y3JCeVk0R2FJaWgxenJaZ2pDZ1FkTWUxS2hBMko5bjls?=
 =?utf-8?B?NW5xcUpIMWpnSkltcVVPeG9PMEFZQ1Z5ajR2akJDN3dhSzdvWXRqOGM4WG9R?=
 =?utf-8?B?REQvRm5SSTNvT3VYNHZ2cS9qZ2hlamFqL3pJUmUxMjgyb3crSVBDN1Q4VXVG?=
 =?utf-8?B?cW1jMVRhc0pESHZxTitZVVZQZmVLdHlHUkFldFdVY3pKUlpTTjhkaHY5Qyt2?=
 =?utf-8?B?ZzF5RUl5SjJFQm9mYzBwMEJ5Mi9UWURsd2dzclM1aEh5WmRXYzUwRFZsYVcw?=
 =?utf-8?Q?crGaNAv9ubVPe86/mqUlscMs9J1LA/re?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am1jTGZXSFAyVmlWYVE4V3loQjJuMzVNdEdjOWNRMjlFSTJHaVNMRm9XNG9D?=
 =?utf-8?B?SjIwWkE0dGFTQm1RdWJJanFvQW9CSEtyRlFPcnZ2VkovRE9tUS9vaVRnRGFz?=
 =?utf-8?B?VHRRdmo4UG9sSkg2cTRVNGx3T2dUMXUybnozSUNsS3FBeVpIemhacUVFSFlv?=
 =?utf-8?B?UXMyZ25KWkVGTGxSdjQzT0pvVnZsY1RkNmx0a2RRWUdNWHVtYXArN1h5d21M?=
 =?utf-8?B?a01hVTB6TGh3TnRwTmpNYWIyZmNQbWwyclhJMnhrQU1zbmpndmZGRkhZdXRU?=
 =?utf-8?B?TSsyN3hrbVM1V1BURUZXRHlsam0rTVVVYnhWSWFUWG05dDVWUVpDdlp3azU5?=
 =?utf-8?B?ZkpQMmw2cklHMDkramQxVEw5WVVzd1hUQ0V5aWlqUytWT05maEJvZ0xreEYw?=
 =?utf-8?B?bXZVNlozeHlUVlo4b0dNN1NKNnljRGxiVWo1dGRLMFJqeVBTMktYeW5jNlJo?=
 =?utf-8?B?REc5eU5uamhjZnppWmlRRjlvemZvMXZaVDNGQmt5Mm9EOVR0SHR3dWdZRVdx?=
 =?utf-8?B?TUV5Wi9ERVVmRXZTc2hBN0w4YjhleDZVTGk1ei84eFNFZ3R3cTNPWmNZMUQz?=
 =?utf-8?B?SFFUUWFCVTVNOUxTVTZmdkY1dEpSdkU5KzJiOWpJb1dPVURvWUVwRmRobjFa?=
 =?utf-8?B?RkVHdjFHazJ4bW9BOFlVZnlZeUFUWG5FcTllLysvbTdNeFhCay8rN0ZnSDY2?=
 =?utf-8?B?MFNvRkFrSy9KMWRtSEorYWk1aTlMb0NRbWQ4TDRXWmdXN0Y1U2YxYmFIbFp1?=
 =?utf-8?B?Mk9kK2VRbUxBa2t1TDJSUloxSituTHNnVkZERHVGaWFNWjBKUkw3elV1SjUr?=
 =?utf-8?B?eU52YTVGNDVHT2EyY1JJYmZqNE02M2hpNVpZaHJLWkViRlF2MnhUMmlTb0Rp?=
 =?utf-8?B?TjEwN1Qyb3FFSUwrcjNZSGNrNGUvM2NkS2JJMmEwUWpWajZ3MVVzdGxZbW5k?=
 =?utf-8?B?eDVKNFRGMkl4WDArTTFqNTViUk9DaXBpbzRraGhYL0Z2YnEzTytBaXQ3ZzJU?=
 =?utf-8?B?SStCZEkvZW4wWEx6RXBFbUtyeEdWMnZXQjRjWDluOUk2bEN5QnVqMlpJcWF3?=
 =?utf-8?B?UnVGd1dMWUw1Q0dSb0dkSkNDWUhXZG56OS9mQ0NlYVluR2RBRlpCK2lDOE5Y?=
 =?utf-8?B?Y3hjdVgxZCtKWTE3bmMvOWZNL1VraU1XYzc2Ryt4aHFkRjNkdWlNZmo1clVB?=
 =?utf-8?B?Qm9iamg5VkF2NWZoTzJkM3RRWmlnMFYvZ1hwQkx5RnhwNXFWZ2ZORzF0ZkhD?=
 =?utf-8?B?Q3hiTy96NW5YVXB1YzQyREYyUlhaTWR4bDBmS3E2bTVzcWdBREJSYzdwREdC?=
 =?utf-8?B?MUt4MVZ4VDFLUU1KZ1hsWWI0UGQweXBoUDhzVE43RmF0S25KamxUdlI2OWJp?=
 =?utf-8?B?QTNTdjBySHBhUjRxWkM3d2MyVWxWMmtOak9XMEZFZ0pBdnRnU2dTRHpJMmc2?=
 =?utf-8?B?QmR5WjVrLzNNMVB4WjE5L1pRVEhZYTRSU0E1SUZYWEt6SWE4aUpaTWNYYTA5?=
 =?utf-8?B?QStmUm5hVmR3M2xwRVl4RERZMmtMNVF1TEFFaFI2eVdYVmVRTTFEVVNEQ2hj?=
 =?utf-8?B?VnIzWWhBSmZ1K1o1ZGRwSnp5QXRlN0dTR0VjelJNVDlRUGpnRVdSUG41TWNX?=
 =?utf-8?B?cUFaWWJnN1ZZMFM5aXJuQjlmQmdmanMzWEpjRDFMME9aeTZsQjRtSXh1bWti?=
 =?utf-8?B?aHZBLzBWSGh0TzlEYnNXSjk5OFNhR2Y0cTMrQTB1OW85Wk9TVVNWZmpoQ0V2?=
 =?utf-8?B?dGNLbUMvQTJZeDlkeFJYL01HelcxS25NaGxIeTlUNkFlVlJEUEFIUEZLeGFp?=
 =?utf-8?B?dGg2VXhFK3VBa2pBeFZmY0d5RjN5YXA2R3RpN1NCYUV4SVN2VTQwWlRZZlpZ?=
 =?utf-8?B?S2RYdFNVSDB6Wm5SemgzSFJJZU5IaS9aSzNQMFVuaGFKMi9lR0FtRFA2YnN6?=
 =?utf-8?B?ZDVaYlRpT0FMelo2OXdLeDNrWWp1azBSNmRFMm84VHNVY0F4NStrU2FSUDBV?=
 =?utf-8?B?NWErVHUxQVhaSmNQMmdEVWRUcE9WSm9TTDkxTXF4VWYxTFM5dFZtNnlZOWk4?=
 =?utf-8?B?TmRtcGNlOXZnSWZFTFE1a1hNc0N3REhaSmJLTmlIWUdCMlg5VzlsWE1IbzZX?=
 =?utf-8?B?ZXAzTHJWSEdiK2k0Z3dMUXFIWXVaWDZMaU9RTnRhZjdtTGNhK2M0M1BXOVRx?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb96619-6cd4-4395-a356-08de0a53497e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 12:23:16.9711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIW0Fi2KMM7ZMjpyt7FxaCETOpYrLgqV0peujQ+L7LngajWJr4fn/dEyHZTWnsFfxA4icBR32/lriiP9ELSRpU6tN1gmvyga7+weY/i5lSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5897
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

On 8/14/2025 11:32 PM, Jake Freeland wrote:
> Use rte_fbarray_is_used() to check if the previous fbarray entry is
> already empty.
> 
> Using prev_ms_idx to do this is flawed in cases where we loop through
> multiple memseg lists. Each memseg list has its own count and length,
> so using a prev_ms_idx from one memseg list to check for used entries
> in another non-empty memseg list can lead to incorrect hole placement.
> 
> Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
> ---
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
