Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB95C982FA
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 12:14:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 671B040262;
	Wed, 23 Sep 2026 14:14:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
 by mails.dpdk.org (Postfix) with ESMTP id E25644021E
 for <dev@dpdk.org>; Wed, 23 Sep 2026 14:14:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790165672; x=1821701672;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KRoth7CxfteWU07ApYKM27dleck1qxp8NJTdOpYewPU=;
 b=AvWHyjYIchLr5YxR1m322MynoZlVx9PHNVxDwFnByOyTNdh9iO8lH+fq
 1w5AHt7Tldor4Qcv3NjiAGLJhRE6C5LDJKeWO3bDVdbx8iUw4MfUrIYHu
 E3+/KGkkhKCTNeAFZEe2JlqvgidXmHMZsldlyM2sWiauVpBiMHmRVL/BL
 Wp0Mhb02qxLRIebPoYzzRBw3iWC/kIxDCBcdSedNaWA3OAk78SAMjUrLd
 onHpzpan2rRzF7tLjr9X7FuHjmw5KfI4lVtnPFrn+ow/6LrkjQSIw4aB1
 Pg3lAHgpx1XQvnB9iWtvLz5QqfjZMRP0Bn6sl6+sSu6ZwRTdbQIUK291V Q==;
X-CSE-ConnectionGUID: qmT2cDk3SvaPBmuQ+ieWLg==
X-CSE-MsgGUID: RB4l33BlQsiIoiNgo9QrFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="1358690"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="1358690"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 05:14:24 -0700
X-CSE-ConnectionGUID: UOC01wVYQRSb/E7L3hS9yQ==
X-CSE-MsgGUID: FCUwYdUNSZCRu/RWg5L17A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4671320"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 05:14:24 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 05:14:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 05:14:22 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.20) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 05:14:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEv+oQI0S82D01pAhKMoMg1dpyCc7BejTWaS0piLVHj1pYdZat3mPHqEojueobBAWJs0lca1koYmnnRuA7TB3JncqqRfBasKrjcZXK+XBv3q+nflOyRfAovsjP+aNIQb8OvRJHCj4jB3w2W9/3DH0YoSD/F7xUXUvlKTbYn/kTeJAgleMN2812FhAKjMlkc0YEOvZ/ny2eGZik5Ipjae7VM31AxTdSisx+oD+m7dxxP0tKDjRO9i2OLvUWCWol7wBlbaMeSX/+yx9MCsSBhlj++KAyD9t6rTh+PIPFvmVtsR/1TwQBUqwdh3t5D61KjXgkautwdfwyIqUqWD1n8dww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAg8VHbxcI3UurIh+j5nqCMeEw8a52nOtlgR6nmXfzY=;
 b=hz6ErO+R6Ygz0fLFGDakWJh0bivZ7hNZ0B+lWMe8Y94SRt32FK1NPYLJfNDR8xPJmwaCAx2BOt6LLhPnJ94AADo8LwuCs9WnKYoLWU6xW0MQGfx4fkZ2NvHfqQ4Q/z/kmbWF9WXUbu7SW5ZS8M4I0mVSX6JD4CI7Hq4fH0lKBnt7oBEdlH/IUBdV7IIADECU9fMUb6svAwpTO1nmt3wS/Cz5HWps7q3I/iXZwCF+xrevbleAPBcLk65KxGqvmW0uP0kUVC53jV06gGz93nvQ7n8P3+itfO/vUxmS44xqSjKby7PkV55yu1029AhsKYEydcsaniDBlQJ9nqD31HNUWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MN0PR11MB6110.namprd11.prod.outlook.com (2603:10b6:208:3ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 12:14:19 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 12:14:18 +0000
Message-ID: <c8008d76-e2e0-4e45-8cd0-992ca738242c@intel.com>
Date: Wed, 23 Sep 2026 14:14:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] net/iavf: accept up to 32k unicast MAC addresses
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <ciara.loftus@intel.com>, <rjarry@redhat.com>, <cfontain@redhat.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260914081725.1097704-1-david.marchand@redhat.com>
 <20260914081725.1097704-4-david.marchand@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260914081725.1097704-4-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0198.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::23) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|MN0PR11MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc5205c-920b-46e0-ad7a-08df196c3169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XVZTTPtOEcHnmqggGqtJhkYbs/F/vjSfdS616NA9sZJIgKzKG1Yk1xRQVWCQNrAL6R7C4B5Hg+OWqA7ZQNhN24BTxqcshQ+BVzGw2HA7cJPBbm4jnnJD5pbpbJU1/KzDFl38XYQtbIkLv7hcx+2/dyZbcBW0O3tKnsL347k+/QAaQ6APcoDPMaxMIIOegNajM7u9dgk35LJd4AFFo77Xk/62w0JqdO+8fFL+eqXN2CFxz2EQyU1FfuyNIKdLeXCjACfwYI1A6jpV0ijToHZh71vFWI6JtKz7tYTA8Nu+8urDyM8gH1pA+0ypu0j3ihsT049yUypGqDxTl4kqYpoe4l8JCI9g5GJGm4+D/xGjR2XHSH4LyPnyqv7KbBVamGG3LT+qf/sM+oTXDm38gkQGGeh2eubBmQyrpfPZmIrisxgmyo6Uijjpps2ppdTb02PEgjcEJ+at2WtQUb1oyLQgl1zXgB461pG70m90i1DMly/g/LaJFNsTmPb9W98kAGron8v4Q+63tu8Uebs+MQ0WCRKk7tB+c69lzKJwxJQlrMZVpR8Zs6OeaWMCcKRG65Dq1O02lOtpembI1LQEtCEc7UCa2eMD/KyWsKMLVUrV1UNJgksNs6jGGrM9hqLaVgstxL0KJjZaxJLcDXH1oJlEefa7Y7vORXB+cugOTe/26hI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXIvRnZ1ZTloUG9KUXhlamQycHJZMUNpQllEWVNGTlY4STJhTkJCN3k5Nkk0?=
 =?utf-8?B?WFNFSHFXWkdYV0F1bGFXczF2R0tZSTl0K0ZLVlhhUGlUQ05XelBpTk0vWE43?=
 =?utf-8?B?eDkvdXd1di9hcG12TXlZOXNEZjRCR0RRVHRzMFRtdDBxUWNWL2tiRUhZVmdE?=
 =?utf-8?B?V3Q0YzBrWW9PRk4rRDRUZjBBSFFKNmhHdVBIY2V2NkZwb1FZaVlUZkFaZGZN?=
 =?utf-8?B?eVNOUzNlQlFnTnJyQ3RTREVDcFE2TVFHeGZyYTM3NnZ0eUZtRitEY0pkZEp6?=
 =?utf-8?B?dkVIaVNpR3BtNWpDUERoOFVMMnMzdTFoSjN6WjN3Qmk2OTRIVU83dFg2VUNV?=
 =?utf-8?B?dklITUYxcXlsTkdRenhleG9kZ1V2R1MwNld0MEdMWTlHekNldDRGMHZkMUdG?=
 =?utf-8?B?VFFhdzdGcW5WR3Z3RzZ3Y2lPM3pCR24zNkNWUjFoY0ZjUUdLVWJKdE5lNmlo?=
 =?utf-8?B?VnB0bzA3STg2RjYvLzJHSGJyOXV2OHVJbU92SVc3aW53aDRkb2xQbTlXRFJX?=
 =?utf-8?B?RjQ4UGs4bFhTeGxub21xaWtuYlVkYm55d0VyVzVIU1JZRGR4NkdVa2lzeVpR?=
 =?utf-8?B?M0lmQldja0UvZWJVM2FiK0ZwSlNUQkdYUi9Dd1RRUk1peU5lSVBwcm1zOG1r?=
 =?utf-8?B?ZEVyVDNwdVg1Y05TV3JzMEs0ZnVSNnZ6cFZHQ3JGZGYrUTRDYnVsQlJrY1I3?=
 =?utf-8?B?WVdGUERWK2Vzb1RIaFBzZEw3VnlUSUdjVGRSZVRxMWhWSkw5U2FRMWNZTGM0?=
 =?utf-8?B?M3krYnRvcEhRNmpHd3IrN3FPT1VlaFI4elBtVkw0NFQ5SVdScUtwTERhL21W?=
 =?utf-8?B?VHc1V2d4SlRub1g5K2krci85bStacnFNZmhVdGhXdjJNNWw3UkhQMlBkbmQy?=
 =?utf-8?B?a055UVVTdk5JTVcxOHZjc0lPSUJybEZjdFRQRjJxV0FQcnBMUlpwRVAzZlBz?=
 =?utf-8?B?eXYwOVVtWSs5eWRicjg1K0Ezako0d1ZpQlV2MFc4cWNzMk9oUmdFWGJBcGR4?=
 =?utf-8?B?a0pndWNBdk9BQVk2M3VuWURjOWNKUGxQWmZ5U2NHU3ZUTTNyUnpSSjY3czdZ?=
 =?utf-8?B?MlVVa0hHdldtY1ZkLzBDck40RDhaZUk0L2dnN09BUjNVMzIrQUFjL21FSUZr?=
 =?utf-8?B?MmdzeW0zVGxSNXZldXlYcW5SbE9vNEUxMGlXby9Nb01TY3Y1ajBTOVcwK2Z2?=
 =?utf-8?B?VHMzR0duc282eEFvNFJYejRKR09YMFAwdEk4ck5NcHZSKzR2NEFTUW5HMDMx?=
 =?utf-8?B?VlM2RUJvdGcxQ2I1anJleG9kWjlkbFhIMmE3bzZvZ0FVempud3R6QjlQajVi?=
 =?utf-8?B?dXlUc0dlejlGVnZkSFpPNWREeGRONGpRS3RlSEc1a0RpZ1NDQ0M0WWZ1cWM5?=
 =?utf-8?B?MXdYdDFWblFDaTNMaXdVQ0xMRzlUTEl2ZHdzU0tBOElleTVzdTErYWdxOU9o?=
 =?utf-8?B?V0JXN3Q2ZS82bXdMVTgyNVJHeFVaT2o3WVQxNHRNZlhVRTRpa25OdVBqZ3Ir?=
 =?utf-8?B?MDZXTFVOcHNkYzZqVlNRSk5PZldYOExHR0hSeFE5bXYvVGMzYUUyTzJpMWpp?=
 =?utf-8?B?UExNSG9MMUNqQWU2MFB2TjBiTEJaemdxSFlmOExCKzFCMExHamt5UHRtVEts?=
 =?utf-8?B?WlVleHR2S09ycTFhV2oxemZQN0F5T1A2T0p2cDI2c1lvbG5uVUNUS2plK1A2?=
 =?utf-8?B?YklMYzZWYXVodXlDZmp4N3NPVUMvRmpHNlFKVkdmNytZZXZPSmlXRjF0N1FP?=
 =?utf-8?B?TTJxOFJZem9TTy9xeHoraWFqcEtFS1kxcXNrUEIrY2hlWFlndXRMMUxqK2Fx?=
 =?utf-8?B?U0c5UERUdTlzYkFRTUJKZjRBK0pOVU5lOWpwQVpQV2lMWlRrNjI2WlcrV2g0?=
 =?utf-8?B?VFAzdCtOaytxUi8vTzdyS3VhdGthRjB0ckJwZWtCSjBPdlNyczJtbmQvbXUv?=
 =?utf-8?B?cmtpM3pLbEhTK1dsWGZrdmMrTWZyejUxK3RkQTNOY2xoRTNFM3NnYzA1N1g3?=
 =?utf-8?B?VzZrY3NvUHJzTWdSOWZReVFJZDMxTjRvS3VPWkxkM2taS1h3Y2djV0R1NVVz?=
 =?utf-8?B?TkZyZElIN25Kbllkb0g2TkwxRW9vcm1YaGNUWHdPYzVGTFRBQXAxZHNLRW1p?=
 =?utf-8?B?dmg4dm94OGJPbW5hdFRBdTJ6U3RENk5TT21uUkJLczBpcUp2a2ozQkdPRjE0?=
 =?utf-8?B?TmdwTXNianMvVG1pMEl2TFN6OG1uckhRY2h6WWROSGZqSWUrZDhYWTlwNFIv?=
 =?utf-8?B?ZWZFVnEyY2dURDRocE5zMXZZOUlpZDlrK2NPVHpSRmwrUkIvK2xKM25qVWFh?=
 =?utf-8?B?bDZRTHNrTU1xSi9YU0FhUjBhR29IRkF6Ni9tdS9UQVpKWUs2M2lWNzJ6YW0r?=
 =?utf-8?Q?uVnG8OJJtEsJhezs=3D?=
X-Exchange-RoutingPolicyChecked: y8wvR3b6r+jOYkQVlFl7Wa4JWzV3fqaSmRNJGBnCTk7CKrm0yvC1nRK2v7wMTPFBGa9T2Yg2nKTNvwwhoa0L3g9FcskwB7ivCc8p42lNsrXiY4GVOnZHMEo18cA/H4efFH549bXVZwSJpelsGLN92Ip0HO0nX9S/ZKKv5+PCVaR0NeIkBs0vo3p9zKEEfm8ksq7Yhd/WkkWTCIkeHmeNmmiziJJbLM6l6LtR/n+nrAXy1WTb7Ha33fshndPu07xHZ/D+dX9N5d/jPDTMPVMQ9E0XtQD240Ga0T8nvW9CusZ03qr1hSPUXfU0aAlX5M/h8jhvaKL/OpEId8FTBOlsow==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc5205c-920b-46e0-ad7a-08df196c3169
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 12:14:18.8679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKwpV2kIRAX7NkZ7b/QWjLHPp4UfpT3kWEch3ZfIYTtbctcNn/6FhrdhwE8bptewyiddd+nGtg54P8qI0ULl2aNopA7/oSehE834SZP+bwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6110
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

On 9/14/2026 10:17 AM, David Marchand wrote:
> E810 hardware provides 32k switch lookups.
> Thanks to this, it is possible to allow a lot more secondary mac
> addresses than what is possible today.
> 
> In practice, the maximum number of macs available per port may be lower
> and depends on usage by other (trusted?) VFs on the same PF.
> There is no way to figure out this limit but to try adding a mac address
> and get an error from the PF driver.
> 
> Mailbox exchanges are limited to IAVF_AQ_BUF_SZ, segment messages
> accordingly.
> 
> Since unicast and multicast addresses arrays are sized with two
> different constants, prefer RTE_DIM() whenever possible.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since v6:
> - reused helper added in previous commit,
> - used RTE_DIM() instead of macro constants,
> 
> Changes since v5:
> - separated from series that went in next-net,
> - rebased,
> 
> Changes since v4:
> - rebased,
> 
> Changes since v2:
> - added an entry in release notes,
> - removed unneeded temp variable,
> 
> Changes since v1:
> - fixed buffer overflow on mailbox messages during port restart/VF reset,
> 
> ---

<snip>

>   
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
> index decfae3182..418a7e897e 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -1712,8 +1712,8 @@ iavf_send_eth_addr_list(struct iavf_adapter *adapter, const char *caller,
>   void
>   iavf_add_del_secondary_mac_addr(struct iavf_adapter *adapter, bool add)
>   {
> +	uint8_t cmd_buffer[IAVF_ETH_ADDR_CMD_SIZE(IAVF_ETH_ADDR_PER_REQ)] = {0};
>   	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
> -	uint8_t cmd_buffer[IAVF_ETH_ADDR_CMD_SIZE(RTE_DIM(vf->mac_addrs))] = {0};
>   	struct virtchnl_ether_addr_list *list;
>   
>   	list = (struct virtchnl_ether_addr_list *)cmd_buffer;
> @@ -1730,6 +1730,12 @@ iavf_add_del_secondary_mac_addr(struct iavf_adapter *adapter, bool add)
>   			memcpy(vc_addr->addr, addr->addr_bytes, sizeof(addr->addr_bytes));
>   			vc_addr->type = VIRTCHNL_ETHER_ADDR_EXTRA;
>   		}
> +
> +		if (list->num_elements == IAVF_ETH_ADDR_PER_REQ) {
> +			if (iavf_send_eth_addr_list(adapter, __func__, list, add))
> +				return;
> +			list->num_elements = 0;
> +		}
>   	}

Nitpick over my previous comment, but I really don't understand why 
resetting a list in the middle of a loop is 1) not a nested loop, 
cognitively speaking, and 2) more clear than just having every inner 
loop start at 0 and end at ETH_ADDR_PER_REQ while having an outer loop 
go from zero until RTE_DIM(vf->mac_addrs) which is what ends up 
happening when this problem is modeled anyway. This to me reads like an 
attempt at avoiding having a nested loop by breaking the loop up in the 
middle, all for the sake of not having nested loops.

However, it works and not worth a respin, so

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
