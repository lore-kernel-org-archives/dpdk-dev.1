Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D2F606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gG0fUk11
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A04440151;
	Tue, 27 Oct 2026 14:18:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTPS id 09817400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 14:18:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793107083; x=1824643083;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Geyfupm2QwCJxzgpQw0ErltgiTww+WXBO59OcIwWA10=;
 b=gG0fUk11OJnvOYiwOJi2LQNgAqbiMYT17WaBra7zE5yEeU/9t52U79Vp
 xpsIardkq4yke7W01/Ut3JL4xoa7hokPQBRwQXR3jA7T7cmRnxb5hEExV
 Y14mw9usscdr76SKdAUYVKHuO+mki3YH0yIDXKYPFgjqVzww2dNRdfrrZ
 GgEhWPZr19MFIZBHT/p7oojcGpNnZhOZxGiJ31WJ357J40JMLtkS8UDPG
 gZmjtK/lH1z9s7pwNoYQ1ZyUKR5qzJrv/DNCe+pNy8/CooHB/DcAcIMFs
 NsNmXULrPTCzItfa6eY7yEd9iN4okje526LpSwRbb2LHzaflOWo7QWfZL w==;
X-CSE-ConnectionGUID: hnSP8lAXRimv00SR9bvuNw==
X-CSE-MsgGUID: 70BRjyOkQ2GOrl6MbfS4eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1709885"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1709885"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 06:18:01 -0700
X-CSE-ConnectionGUID: KH9/jOj5Td+dArnop1ZLlw==
X-CSE-MsgGUID: F9+T1+o3SeWw9JnjU5p07w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6385581"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 06:18:01 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 06:18:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 06:18:01 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 06:18:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyCqqz99jh0cA/6rxmLC4NMFj3ADLQiIPwzjSc6q8HIBRN3lXbTa0fwMpUDBNB9NlexJ+EpojHZ5JpI+hVdOYYyh7Luopz9cCZD9za6mBOzs1WU3C9oOZjCqIsxG2KLyqgTbyhBwB9uAgTlpgjxrCrOsBJN43LZRxS1No6JnINOQKo490Md2BIr0Wvo5e1YvHgiSUjt6Kq1hjgmJrK5e8x9+mag9aGRlMqtXj5bWv8l9XNXoZyOGKnhuoK5ILFOuKoietQrSRvg4my8ltGWFO+edk7FM6lA0dy6TMjfDYQT8rs49uyD9oIaCzyYMtWNy3WHOpwaIMF3+My4ZnIyB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gR608j8NN9m4X9V8umwOSoJWnZSjKFL0jc1afAIWLSw=;
 b=dg3ooTxL6O2cVziU0m4TznkTbEWxjnBiCc+GCuFRuAqjGdRlBrCrxafJqkK2YRIXAk5R4p/dYbbcBQGGddY05chN5D2/I3aw0Yc4fysh/xlTPQ0fvFgXuL0/NkMrut6nIAnofemNR5Lw1D5NzC9zIhG8HyR1nT4tnZB9B88KT6Nv/nakzI7hsinJudfHJA+19Jiv12Lw+v5l8MUJuHhCx5CyOAQoqdhzBaXsCYlJH1se5K1OnIPCwRgJwAsOunv6AHaz+qn6ZpAqkS1Ix2cBHeWKOPWlBnbNoxrH637d0nbcXWC0T7Skn7HFs6CqF0voA0LrTvEoWSszu3PLlWiAnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS3PR11MB9624.namprd11.prod.outlook.com (2603:10b6:8:38d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 13:17:53 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0546.016; Tue, 27 Oct 2026
 13:17:53 +0000
Date: Tue, 27 Oct 2026 13:17:48 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH 2/7] net/ice: fix memory leaks on port close
Message-ID: <auCkfGa0n1tNX995@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1793097896.git.anurag.mandal@intel.com>
 <31d88770b8572311aad3b1cfb4c1dfb7814e4b0d.1793097896.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31d88770b8572311aad3b1cfb4c1dfb7814e4b0d.1793097896.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DUZPR01CA0097.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::10) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS3PR11MB9624:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ab55cb-1ffb-4461-6909-08df342cb541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|261026140227099003|11063799006|4143699003|56012099006|261022113327099003|261021135927099003|261022105027099003|261009223027099003|261022075727099003|261021121427099003|10067099003|22082099003|18002099003|261026121527099003|6133799003;
X-Microsoft-Antispam-Message-Info: EXxuPCS7iOTBTn9rE98X4l3DM3+PuYaHG8xpPypYP6uDSKXd7sdoxgI+9pEqgnkQTDxjkn/i2o0nOO3RZZFDhI7bJUZekaaXIyaN87mnAGmJc6BGL+8BhKsVjPK9qaVwMcvCMl4YsJauZ50Se9Vu17aXHyscQaRjnci9BQNCg5Xcq+IVM2R3/FF/4wOwP9cKYNrMy+qsLG9B5jmkfH0poytyC2ywsHKmQfFRUXXYc45Ozp1AR1zSdy6hQ5Utfkn5lTkFI6GAYMLNh5YpeGGwlvl1piH9jXfz7BbVGtCDJgW63zF3rQzksIT0vlKxI96UV7F/kdx83dXnSCPmyJp1/OJ+Q1lICRS376n/6BvohNOdUB/Q3HwNbj540mxT4qGJnn9EeO1Rn/tH2iBVxYLNze4fNN8HrBSJITv3xwQPSp2Dkd7UfEygknB0Oo+8n3nvZaxXXlAGqIfinVX2UdKj9TNpCV4ZkialW5c7FDjWlSFKDP1NGnziDtx8a46uktp2XTQ/snIAyKOLPMH/HfLMbDLw+g9fmo2FItl8AI8w2zQ+QQHTSZDXNTtSM44EAZ/MgdbSJU+PmpohkybKpewCMvN7k5LiBWtFw404/FvNW+o1r0Y+Lc4+y5iUIjTtVO8Go/zPXdDyITX4ewXMQJoQ7ufUQzO1arF0OZ/Hljf+dKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261026140227099003)(11063799006)(4143699003)(56012099006)(261022113327099003)(261021135927099003)(261022105027099003)(261009223027099003)(261022075727099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(261026121527099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXFMbmNkemszbmVoTEFpNVZhUklpdHdhVVRjMUR0ZkVkcmZMcCtXU0Z0RnFu?=
 =?utf-8?B?YmNsNU5XZHhzY1FTMS9adHNWTUN1eXUxekdFdlFYbjcvZVYrNnRPQXJKTEdt?=
 =?utf-8?B?a3pPS1VZTlVPSFpGMlAxZGZ2ejFzL2dNVThMRGlmSE0rMmMrSkJTRSt6b0l2?=
 =?utf-8?B?WmZEZ0VWd0ZwcUluUkJzQWhzS1dyeXlwOGZ3N0huem8vQUtvRTlUZU5QTkVE?=
 =?utf-8?B?Uy9iVWxDUzRpSVdoT05UbHgxYzNoai9Zd1BIcXUwNUF1YStuUnhNdWpIZnVx?=
 =?utf-8?B?V0Y2TVVkUFZtYy9UQzh5blpObnpXWHhZcGtxblBSeGU0blE0NytRTkovMFNr?=
 =?utf-8?B?eW9mNFJvMEJ1RUtFZU9DNFJIbTM1dWZYSU9BL21IVEFkTG5EVEhsRTRlSnRY?=
 =?utf-8?B?YUtvNFRVaThOeE00ZWlHY3Z5K3FxMUc5WU8zUlFTazJnTXVBZWJEM3RhTU5t?=
 =?utf-8?B?cUhpZ1I4VlhFc0xVeVEwdlVaVjArQVhpem5DWVVXc3kvalUvcjY1K1R2bGsz?=
 =?utf-8?B?MmxUZVhLS0duRmVjc3lGSUY5TUpkeVVReTFnZmpuemdrSG5jQ3QxdXQ5QlBi?=
 =?utf-8?B?TlZnR081M3RLcTgva05RSUxOak5oV1JpKzk1cnJoWk1xM0ZUeDRMY3VoQWJN?=
 =?utf-8?B?YmpqaEJFcTE2S3FIZnM3RGhwQko0S25RWUw4aytMbVdsd3I5QTM2MFhlQ2o1?=
 =?utf-8?B?Zk5zRGF0ajdjdEZjZGFuVkZlZUNwVW9XeEtuM2picHR2aEM5MzB2elU0QXdt?=
 =?utf-8?B?Nnk3RUloYUhndW4zbW9nUjBYazJJRngxMXRxMng0VWw2MDluMVlhVVVRbXdo?=
 =?utf-8?B?bi9ZLzlPK3BTYjVkbG5yWUFGWXVOUUh3a2FMSXRyMDNpYkNKUGhEQ2RkVW4v?=
 =?utf-8?B?WWs0bCtiQ2twNTdoLzBSVnZjMnB2Z3VUWDNVbTRTU0oySkcwUGx4dHBqZ1Vo?=
 =?utf-8?B?eFlzTzJjLzB6SmFRRmQ5U0lEQlZNSXdLWW9IYXRLTk9URUNYaFBtQjBOVkZC?=
 =?utf-8?B?OXYweUZ5ZTJVaXdSZnlsR1lGdlJiUjhxRm44eDY1MkVZaFMrTFBZR0tzTTN5?=
 =?utf-8?B?NE1GNDFjSGJ1MStIQ01jdVNvUzdITWJPZmg0QzZzK1pOaHNmMlg1QmV4OWZW?=
 =?utf-8?B?d2k1WWN2WTJ2Z1NqNTcwV2FXRk1mTHdvSklIbFBxWEVVU2l5ajhvbVI3ckJT?=
 =?utf-8?B?OTcrMW9UbzcwcUtBd1Z1TnA5c0RRZW8rNFE5V0p4QlhNcVRveDhPdmxCQWI0?=
 =?utf-8?B?ZjhWS05DdWo2WkpuUDVvVWo2TklsMStwSHc1aEFWV0ZCTTZONjBxb21FaDhj?=
 =?utf-8?B?RlBVZDhtS2NhYXdXdkw3K0ZtcnlUWDlDSnI0Zm5FVDg3cnBjeTl5Q1F5Z2tK?=
 =?utf-8?B?OHdiWkcxTnhqazZHWDFQdWM2SHR5ZXExUG13eEJLRmoweCs0Q3E5M1cvVFp1?=
 =?utf-8?B?c3UxR2Q4S1Zac0RMU2U1cnQrT0ZYRnlINXdtbXc4U2JTRFdIQ2tsY0xiejhC?=
 =?utf-8?B?UmhDQ1VYd1BuWFJ0RUgydTk4M3lNcE1qS1MrQitIMU4xWGdYTmJFa0I2dFlp?=
 =?utf-8?B?bzY5ZjdyZXhQUm5pWHlONzJ1aFlYTEoxS3RsenNWTWQrc3Ryb01CbG9waG4y?=
 =?utf-8?B?VjdzTFVoa3FGcHIrNWZ6L2UrSXBWQlBSQXZzeE9haWNWbUVyamdmS2NDMm1t?=
 =?utf-8?B?RjVoVGdnd1VtNWNadENFcXB0LytuRmgzM2lmcFEwUjlJczJsUEU3WUJrcDNn?=
 =?utf-8?B?dXlsU0cyZ0srN0s3c2JyMklSNGMzeWtKWC9BNmc4djdiRGlDNlRQYlpHcGl4?=
 =?utf-8?B?ZlV0S0pnZ3lPeEU5SGx6SU4yK2orL2JhMW8xRThwTTFYTkhqbjRBVGwrclc3?=
 =?utf-8?B?ZC9vVUlaa3J4aXpKM24rcWFGajV3QnBzRmZrVnpici9VN25vZE9PN00rQlZs?=
 =?utf-8?B?QjVUV0VSWTF1dnpUam5pQ3V6RFZjTUtyT1ZiUWNtYko5TFlSUy9IMTEzZThC?=
 =?utf-8?B?VXdLQnpaTHliSWRFd002MDZYRlRqdzRIU01Qa2pPRWtSSjJ1UTNBcG0zN2ZH?=
 =?utf-8?B?a0ZNTUVXdzVlTXZtZnZlVnZBV3dNZUFwTktyUGhCTlFISVk2YlZwMVNuODBP?=
 =?utf-8?B?OUNWZzJ0RlhYWlJlLzNQbXpEdGR3ajFzODMzRXIxbDlFd3BsN0hoUjNobzlS?=
 =?utf-8?B?Mkp1OTA5Rm5zNmRYUWxINThVeVcrc1Blc0FJcU14VTRxamtEV2FwcG5LODZ1?=
 =?utf-8?B?L3JvK3lPRit3TjE0Q2Y4dWNwZ1d4WkhaRkUrSitCK2g5NmNUU0ZSdkMrM0Vt?=
 =?utf-8?B?cmw3eWs3TXIwekVvSWxVdm93blc5cW00a0NiOXE0UmFqVmR4QmJ4enovbFgz?=
 =?utf-8?Q?ElEFvGrVl/RASFNY=3D?=
X-Exchange-RoutingPolicyChecked: knlLajggWdfBxSEMRfXx27hpJ9x4Z4bRGvkBRAQ7HaxHWc4mpVnw0w1KrmFPeNU52kmEViQZk3nB/L/ReOaqfhLgrBIjbmceM1Ao66Vvzl53oCcgrRPUVEd4Agi2H5p2w7aKnEN4+T2ExCOGbI+2LX3ftFhmuN0gtH0T0NtJ9RBG0MyhaQ76JnttQAM7IE6wnUqU6U7Eo35ubm8XQhlYNuht2CEnxqhGcIT8AoYa6R7uyAv0aB0IalquoS9RErT9q4mQdDalmNiLitG3Rr1b3akI4Mwgr5SpeiYgevcjCJvclp2ZM3RMB24AvGrf/2wy9ni0lfSAaDecgQaaKM9KZw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ab55cb-1ffb-4461-6909-08df342cb541
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 13:17:53.6524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +h9ab4kQWY41bgewrRxVlpIZ91y9kZ6iIdc/OOyfuGBCeXgqucA9Be2tRzerprS+wu2vQ3pLYuZNRqX/L9oli3sfo1OSzKWfvpHh/2m/7+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9624
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 10:51:32AM +0000, Anurag Mandal wrote:
> ice_dev_close() tears down the hardware state rather than with
> ice_deinit_hw(), and never frees the switch filter management
> structures, the DDP package copy or any remaining VSI contexts.
> As ice_dev_reset() is a close followed by an init, they also
> leak on every port reset.
> 
> Free them on close.
> 
> Fixes: f9cf4f864150 ("net/ice: support device initialization")
> Fixes: 9c4f15901ada ("net/ice: free memory with matching allocator")
Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index dd3a4976ab..27f992aefa 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -3109,8 +3109,12 @@ ice_dev_close(struct rte_eth_dev *dev)
>  
>  	ice_res_pool_destroy(&pf->msix_pool);
>  	ice_release_vsi(pf->main_vsi);
> +	ice_cleanup_fltr_mgmt_struct(hw);
> +	hw->switch_info = NULL;
>  	ice_sched_cleanup_all(hw);
>  	ice_free_hw_tbls(hw);
> +	ice_free_seg(hw);
> +	ice_clear_all_vsi_ctx(hw);
>  	ice_free(hw, hw->port_info);
>  	hw->port_info = NULL;
>  	free((void *)(uintptr_t)ad->devargs.ddp_filename);
> -- 

AI review flagged a potential improvement:

“net/ice: fix memory leaks on port close”: some close-time resources remain
unreleased. This is a pre-existing gap, not introduced by these commits:
ice_dev_close() calls ice_sched_cleanup_all(), which does not free the
scheduler aggregation lists; the canonical ice_deinit_hw() also calls
ice_sched_clear_agg(). It likewise frees fd_ctr_base at ice_deinit_hw(),
while ice_init_hw() allocates that resource. Thus, close/reset can still
leave aggregation-list memory and the FD counter resource behind.
Confidence: 9/10.

Can you check if more work is needed here?

/Bruce
