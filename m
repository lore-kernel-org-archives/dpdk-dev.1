Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6761606A321
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D0rMk2xW;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=lLriTT+5
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 151CD40682;
	Thu, 12 Nov 2026 14:28:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTPS id 1D0B7402A2
 for <dev@dpdk.org>; Thu, 12 Nov 2026 14:28:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794490109; x=1826026109;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sksAVZJV2IDzC6SCZjJVUKMzY7fN17fjJmt7ceDjUuk=;
 b=D0rMk2xWnhhfxh6uW+1b2To5mkDESnF6HlEN74IYv9I6MRs6ZJvlGP2q
 onSjtSpAb6vaOzI0k8knpj55zidt7W57B5Ms+iHaJZnGBJtyWuANeUWuw
 9LkR4vLnGkD33/HwtExjPz0Pwu4tqaXXho85yGbHlu1JyAeK+ZPs3h6hY
 quyRFFb34FR66Ym5jBnoh61+CblplWD6yVc66N76JELfVecnTcKuDoE5M
 m8e2kmsBa78lv4GCjQhnCKc3hU20niYGWLiEYQNc6m9oNpwykhuadgU6U
 kqKDiwtosxqvHyoa/NSQC6e/nvqAMTG8d34vM6YLRAqM4TKOy5jLBUFX9 A==;
X-CSE-ConnectionGUID: R3/gvk4fQ8Opiorcb9CCLQ==
X-CSE-MsgGUID: Fa85Gy34SmSpJgJt+jzFqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3304603"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3304603"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 05:28:27 -0800
X-CSE-ConnectionGUID: 1yTkXId2RcOjnmBHY08wCQ==
X-CSE-MsgGUID: PVJ/XsgPTa+re5hTzSFEfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; d="scan'208";a="10423591"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 05:28:26 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 05:28:25 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 05:28:25 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.18) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 05:28:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LiNMWCTyEZIZEH6WTF4kf2mQjxauL2t0IjaQ4B+SJ1py0cN/IiRjM8wludgkbHMcCk4SsmT9AsQOl1R+5j59mLh8EOS1gYw5md7XtaL9Hc4Zc5OV9F4ISThWAasSFrMTU0cV2MOYnTZl261eo6GgyY6414b92okj72QYwGSW8nVnbVFupGkgjqLAAJTvEqxYbGV56yL01igSstGn9GtpWGLV39ojx9Vjr0aYCBWquy+qSoSApBu61Lg1MRXhBTPsnzMi+4w1DCX3kwGTHFjuSTiom4kbK5D8T6+7papotVByN6ZLMY8eu1vSNhB8QckvTx8AaJlRONJ62ofwpb6UGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sksAVZJV2IDzC6SCZjJVUKMzY7fN17fjJmt7ceDjUuk=;
 b=eNxp5ukVhgWZ4IjKEk5RddDOPGqm73y1n2YsyTd4f7XY72FFYkwRSGxK3tS0e7fz8HdJfv3i+CGSGoY5Bt4rwR+x5PVmhp06TkMMrXnpDkw+VmYmryyHmdzx2YeMXm7h9l0TSvzmZUS6O5Vsy//REaQfjTQmK/VhvvI+K89kug6Dy40pyLnVmtcnQ0e1ea0HtOUvavvSZplHnQ+DlFM5A9fr8AXEfnQs9lmjD8XqvmbaZwk3WB+AToafvdu6Fjyh2QgfFjtE7uPFsu5NRnUoG5SFXqfz386WU0Z0eC7cIyV2DRaEy1nDP0rVjZSk38kUCYCVJAstc2VT9vwpA3uRYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sksAVZJV2IDzC6SCZjJVUKMzY7fN17fjJmt7ceDjUuk=;
 b=lLriTT+5CsgjoBDXsgrd2l9xEEsmnLrN3hIcCiWYF3KYjj/H+zLW9ePTRIcIR2SQqDZvr6khlEauKPUcx06wyg5qtVahh0C9URC1E5SSzbrXuJYrzW68knerj/XKKq98cOVgSyOj8uvXlcpyhV4fqQMqfIGQQEUwInL3u2RLtMI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 CY8PR11MB7136.namprd11.prod.outlook.com (2603:10b6:930:60::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.10; Thu, 12 Nov 2026 13:28:21 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%2]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 13:28:21 +0000
Message-ID: <47dfd5a4-afad-430c-b234-d00a5a9e2a85@intel.com>
Date: Thu, 12 Nov 2026 13:28:17 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto/ipsec_mb: remove unused ML-DSA helper
To: Thomas Monjalon <thomas@monjalon.net>, <dev@dpdk.org>
CC: Kai Ji <kai.ji@intel.com>
References: <20261112130510.945641-1-thomas@monjalon.net>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <20261112130510.945641-1-thomas@monjalon.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P195CA0012.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::22) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|CY8PR11MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bbca2d6-148b-4c45-9258-08df40c0d1f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|56012099006|261022075727099003|261021135927099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: V3Hq0FQjoCZAopNW3OCy37rA/amc9Staz+s+tP3OvMpLXI4wD0nwfbrCC5YzJPhoLaWY56IJDHqA8V7W7yk1LN/2+UQIlZFICzIFCH5iFHxxrADByL0wIIok0nIyD0c+JoEZqyNY8+0DZnLLz7rnoM021WYeoCMWUnJg0sVfgGU09lJVGn01B2Yb4oMqOBrSLH9HfYrKu+HpsCvMZzswh/OFtDphzS4rQokJQdnSX2mVuRXbHWWTX9si2VZvSmG6twUYX5QbXCZogh2GDCDtR9ZSQ85hQrSrqstQ+DjlYz/bqhysKoNIy8kjI5elPbG6vbA/TgNtQ/kZmdGI28pNVgjtosAyDfq3MjSvZEnKP7Mahl7Lk3S/UFLFeakY6e7NrEK/7bwGE5FRbupy4c8nEdhDJxrFbnTlZuYITqj7gtXrcOdSjr3+kqAiRoMJQrwTvvegrmHcvTM8Q/1JAPfGxBjxyaXzEljZWYrW/yZm+P8LoE75i8MiDu1YCM92TgsQ73KJgPaEQEPUacMo3jGmWXKPdJ1+4vm/X/ZC0lTcx3DnC/eNBKepvymwwbCGF1+OiTbZzWS/JsOIWpr1HY2woLBCKU9BaNWov3uhq6efQJuoNrD8Ofw3JuXlXWSr9NKaLPMHIzwqAPYB4fPM8LEF5hzGq7ZCCMiO7RZIqnhYtEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(261022075727099003)(261021135927099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3Vpalo3Q01Yb3F5c0IxRGhXZ0pkMUNLSzJWcnZZKzhNSjcrSjZlTVZ4K0Zi?=
 =?utf-8?B?V2lDdHZUL1c5c05YVmZSSWMvWG5OL0d4L213QWRnWW5SblNaKzBXZ0NOTm80?=
 =?utf-8?B?R1B1cEFMazVmdTI1eGl6cTFyVm9waFdyaVN3bGJKeGxPSGlUeVVpMXRmekNl?=
 =?utf-8?B?b3pYeHZxVDhrN0JrZ3hNNGdvZXZxbWxkeVRFR1I3YkFpQjFla0xzMmJNUEZt?=
 =?utf-8?B?REg2UzZQdHhaUUJ0VnVjYVJiMGpBZGRuZEM1RTJzelJqZUtIMWtkZUsyVmht?=
 =?utf-8?B?VnJVMFU1ZEx3Z2lmbVdjUEFRcDNYMGtzZVN4RHRuL2ZyZkdyTitVaFF6S2pi?=
 =?utf-8?B?NkRyekdGNUtsWFFpNWtCMXFXQ0orSXd6OW45TXVyRXJCTzJpcjh5akJweVgw?=
 =?utf-8?B?MVVnYStqUzFteTNqaWlnKzFoTjVTc2d6TnRpYTE1bFdXNGtjNjNOVUt4UjN3?=
 =?utf-8?B?UTZxakJGU1BGdjRGQkFOQmZlOXV6WFprYUk4SG9yM0JzanlVRTU4TzFkOW9a?=
 =?utf-8?B?K2ppOW9rZlNaSCtGT3dJbEpmSkVqUkZKTDdRUUZiejQ4NlhxeTc5bzdKTHJw?=
 =?utf-8?B?M0hRKzFLVkZrdjFpck01SW44RjV2bWVrYkFMclV1dGhtb0NSMGdoc21oQk1I?=
 =?utf-8?B?OWpUV1RuTG5WS1JNYlRsQlIrbjZZT01RU3JZTTdjTjNqNXJqdWwxbkdaWlcv?=
 =?utf-8?B?ay94bmMvYlJtWUdna0lDUEdFTGtaL0tDdlVCQ1kycWNJdlo3d01meFFNdWpS?=
 =?utf-8?B?SnNDQ3phdzhsNEU2RFVpWG80WE1iUStoRnVqUms0SWx2cnhnb20vSjYyem1v?=
 =?utf-8?B?RkdHRzZuM2pNWkRoNFJPNHV2QkRvU0VzVCthdGtaY0R3U2FXV2FhWmJvVG1W?=
 =?utf-8?B?YW42OXQ5MmNkdUFraUk0M3REK29mMy96VUZwbWc0ZXlQU1EyK3JleE9pTVY2?=
 =?utf-8?B?ampXL0tsS21iR1pZNFJ6VW1Zc2RhdHB0YzZYWnNUOE05bVJ4YTU4UG45VU1H?=
 =?utf-8?B?bkxPSXdnSktmb1RvK280UStIajY1WWgrYm9VQkZWMFpGVmx1bnJMMjVMam1a?=
 =?utf-8?B?Tll5QVpBc0xTL0JwUUJYSkd0OGVuZzRBUHZSenVaNTJWRXJNK2phNFM2Szhs?=
 =?utf-8?B?SFdRZG91OUEzaUhZM1c5OFUxYUw2UHVmNENGVlBBeDU4VTNzSGIzWi83RFlK?=
 =?utf-8?B?QkdxdVBLV0Z4YVVYeTAxQUFEWDlMTFB5ZlljRC9FVmxOUE1LSmVUa3lkUFQz?=
 =?utf-8?B?WndSSlBRVGdYUTdxL3RDbHJZdE5tUllRMkdOVlFHaWxFZDNLVWdtd3FDaEU1?=
 =?utf-8?B?Q2NSYk92UFkvZHM1STlNZXB0RVBMSEVhUklkMnBSYmlNUnhsalNidE1wTUVS?=
 =?utf-8?B?aFpFc3ExZk5oT09vVk1XQ1pDb2R5S0pXdEJWMi9IaTFsMDBTcTJyaTI2N1Zk?=
 =?utf-8?B?dUJJOEJHM0xJaXB3SmdUbDdMdlpZZHU4ZUc3UkwzN3ZZelh3dGI1K0dpWE5i?=
 =?utf-8?B?eExNMlVFanNmYkRFbmtGRkZQWldoRkdzMmJycDRGcFRLaUVSYVdhUkdqWUh5?=
 =?utf-8?B?UmFYdlNHSVpjN1dDQ0VjR3lMa3VzRms4V0Z4dmEzdW02ZG42bGljQWJrSU9U?=
 =?utf-8?B?bm1DMzZUc21CdSt2K0FyOTJqMUZKVHp5S1lvSUNFNTQzcTU3QVVvWm8wQUFp?=
 =?utf-8?B?UnJjYzhudUoxVDRLckxKYzlYVElDTXNZcXNiRjFIRDhzTmpHaHRMWXN2SnQ5?=
 =?utf-8?B?N0l1WVhoa09qTEhlMGhacVNhekxnbGVWVUNpNm1DY0tJbUdVa2dac2xHMG5q?=
 =?utf-8?B?RkVQNEFGREMvcGxYWXhKTGxiTUJiRWx1Q2xnSFhOdjhuMVE2S2tEQVVPWkIr?=
 =?utf-8?B?WWVmS080djRSZG5wejBoRExpM1owd2ZPb0ljN2FMN0RCZlgwdXJLckpYVFJS?=
 =?utf-8?B?cFVjNk1GYnBURFNoeDdrMzRzY2FJaGRYRlZxZlo5YytPTU8rU0RtQmJNZlpw?=
 =?utf-8?B?cWNDVWowQWg4K0t3MVhkM25GVWFBRUhaMDRFQ29BUWZCM0dLamY5ZTFJR21u?=
 =?utf-8?B?aDl1TmJEMG8wMkZEajhBdzNjSzE3dUUwRTFXS3JNYmZLdW40N1ptcmlEa3ZM?=
 =?utf-8?B?bUNoeXhLNElLZTQ5NGNHaU1WdXhwT2Q2R204enhXVHVSZVN5Q0l1L3M5aXVi?=
 =?utf-8?B?VDhnWEE2K0NYZFRTclhoYS9sV0JpUDlLSzY0OTQyYWY0T1hpNmlmOHprNk82?=
 =?utf-8?B?VlY3Q0xlSW9lcFFIM3N0Y0FkdFJIQjAyeXM0aTZ5R1ZITWxYcmloN2VybVg3?=
 =?utf-8?B?dmhqaGRqWjhiQVNnNUczV0Q4V0xLbWZmRDlLekNyNEVOeno5TEhaUT09?=
X-Exchange-RoutingPolicyChecked: NDfs/eew53aYfkcrkpMc9SQWY8W78eWp/7hl5o4/11PTgb1V3mY7CEy8h9YJ4nY49g5A2l1ZoPF8g58VsNxNkUxAIMF5wvPwvZWmVI27YfSui5eDAe8tDMV+b6TiQKTZVnUuxOcdsuSw4eoAj+qjrI5yZ8cbLGMOmoU+3G803h++LA1U9QGR0nwwKj+8pFOcI4az5emdkfvG1fBZdYne36oQaUFxTV9LzsgsXzs9Kn+8UzxawC5CQPZ9yrSCJJ4jS3rm0uAtB1McVkJTILpsmwFM750ye1OaSwDL5o4rzb5zxFLb84A/WMaW+MF/+UBfnRcZZJzoaDPpmEQQOQBh/w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbca2d6-148b-4c45-9258-08df40c0d1f5
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 13:28:21.2270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMss/lSXkHqelpBxjdIg0yCCkId5xnqybQdWNEeJzj51MxFM/sDSByPRcluzjOVrK4u9e2czaR7D/SiWGpE60w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7136
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 12-Nov-26 1:05 PM, Thomas Monjalon wrote:
> With IPsec MB 3.0 or newer,
> Clang reports aesni_mb_ml_dsa_sig_sz() as unused.
>
> Remove the helper, which has no callers.
>
> Fixes: 4ff2a4d23d84 ("crypto/ipsec_mb: support ML-KEM and ML-DSA")
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
