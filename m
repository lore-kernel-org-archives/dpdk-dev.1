Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52B5CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 16:12:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E54940658;
	Tue, 19 May 2026 18:12:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id CFFC540296
 for <dev@dpdk.org>; Tue, 19 May 2026 18:12:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779207159; x=1810743159;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=YMSfJ2iqcYSHeDA5Y08yRLoRXP/0zBNWXzXTj+MP8oM=;
 b=j/ud3bQjnoW9xyGALbS5DKUd+dSEKkBcl2+H0MbyfhLqQ10sWyP6bW9D
 cTUexrqzPFZMSuW3CX/q1TzLp14VStgeFG4ML4lcZepPgqKMbu85/ne80
 cd1ENgaVjlXU5UEXWdJ6rAlg+ctM7vRkDgldf+KzYNsxcJUiSDKYj/SaN
 QC3oCpFAagtcWuoGJP/UmqQVe6j16Q3QDbWoN13lxryv4tkV3CAZjUllU
 L1cFc7Cb3I0Eq1L8PXBIOx1/qQZd9Vjh+qP96q59kBWfre92Tb5Fm+xQ3
 dcDSmT9ZTCWjj8EgCncpjiy66KQeV15Gs0uJuBEU70THwEPM31zfAPD4R Q==;
X-CSE-ConnectionGUID: R6D/0GFIT82qBI2KHDuVjA==
X-CSE-MsgGUID: M2H23YeHRL2FlQXtb09Ukw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80121368"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="80121368"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 09:12:37 -0700
X-CSE-ConnectionGUID: R0ptnziLRnKnmKgPMOJ8Jg==
X-CSE-MsgGUID: cwhYLifIQ4uBWmxHQfDTZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="244801513"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 09:12:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 09:12:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 09:12:37 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.29) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 09:12:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvHd7hUxzpvHU67Qs8Gkj76gTx8Laj6jIvTm8ZUcgXgeoxNu82q/As9jeByjnfORaYu2V7jgyD+nUujFTn0bXK5f58fU+81xRhNtckxZrvmJF2DGUCUsSE1ngJ01fzRIVgx9avxeFv38abyrLTEYzRXj4gq/+cnyO2YBd0y0gzBSCxrEoQkya2R0Q9kohTat1Q0XNxIrb0/tLvmzUodkdx2IamvXX+9TswO3E1m1QR1t/9KXp+geA/EWJk4NfKgtZumpc7hHk+jbpb/PvUMj+9nUEl06AOLL8ze4bhRZSF6+5QJ3FldUPIp3AVNaoK9TbFr1H+z9yWKZZeRT6wo1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDg4SxlruNOlgrZ6KgpAiUq026c5rWDMxIcjim6GUqs=;
 b=YJWN3XzCdyFPQpwlk0uEQHPs9rUnr47byVy0F00B/mnoRY3RuPZsSbsBiIDtNVomLlQEp0mCloTozUEeJLbvCbxclCO5lJ7Zv1PfJkp1xSwL8cWSf9AWIn7wFz4ePN4qPYfIJBq3+5eRtf6GG1BSWSTyLeBZ4V3sSZcaCGTlg+FBkLI6OA+Zp1Af452trfmMfghxWqlfeStp8mcJzbJFMBqs9ysMfLEtQYnnmUepFLNoFhl0kWdBMtj7jcrxreXjG1jqDzQnlwK9wFul26705MTYJGp4OdKTf406ofKG3AumChdZ7xrH4VyUEPoDguR5WqnaNkBLZYQKKKAdt5xhpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS4PPF2D9C959A2.namprd11.prod.outlook.com (2603:10b6:f:fc02::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 19 May
 2026 16:12:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 16:12:33 +0000
Date: Tue, 19 May 2026 17:12:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 <david.marchand@redhat.com>, <mb@smartsharesystems.com>
Subject: Re: [PATCH v1 1/1] net/iavf: fix large VF IRQ mapping
Message-ID: <agyL7MGOLfl-GdIr@bricha3-mobl1.ger.corp.intel.com>
References: <c50ef6c3d4ecaa7902d325d5e8a7fd4c92c8eeb6.1778076415.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c50ef6c3d4ecaa7902d325d5e8a7fd4c92c8eeb6.1778076415.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7PR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS4PPF2D9C959A2:EE_
X-MS-Office365-Filtering-Correlation-Id: e820508e-b159-4084-4c6f-08deb5c16ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 3HHZwU0KvImgPo9ySnU6Fb87x9zKfbFDt9LZdxMscafgoWq1S7FYuR2qjDkrRCnmz0ho/w4GxOcgwKdcm1q7nqcZazLj1jWFj648LYQ3EHF8lwy3u8yFiSTDSjHHcQ5GyKCUL9H5fLFNAIi1WIldEzEvIptZlNrxECIaIkeOWpsWyx7B4bDLlVd579Kfr6zrGHHoba7hURH8GwNP68gvgMixDJmxOcWWQSm5mIL7Z/YCZnHChXr1h/VPYFaaJAEc2VqYMOImdHBp3mGDA8ywHTR9f/tItO0ZzgZo/F9/It9EzWYs8b7IKQYSupSs6kQ8rsSpcDr6hrH6xUab+B7aOGUM9v8yKDdLKnhHG5URSH2L7Ggq7GsQ+iLVhaza9aIhX/TXq4QqqBsaXKBrLhGdeDoz9RzbIj73/EqDGZUsTmOf27rxxuagsURBCXgfd+n+vWyPMdEvvijF0ujDglDBN512AH15Ze94FGEAexpGk9YMq5TMS5U3PTYJy9zbBGvjlEqrTkgE/LvbEf2tWtCRrm1qYBbMPDnoJLKWNmpxBvw5mjywwZlpWtzFPCRnIbKf+ypKJDTGV/1f6TzzDYpf4cInDW7w65x1i0UrxKckKZw/CLudFlicYvz88tzhRX+3JQxRcGs+WLFm4ULgiXXzIPoeuV2JOqPt3K3G1g9M5y0Ra6KNGC+PYy6O5mbi4b9h
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VTS5ShnMMYJcwb7rrw9fOVx78PPZfrZuFxuClxPMrfkYGLhb+HaTyvoPE+Qv?=
 =?us-ascii?Q?tmZTJRrfrYTXeidsGL0gKzAqiF5mh0BQBnVoRc9DqH3B6eaW8AKMQzNucVnk?=
 =?us-ascii?Q?IVYoQ+9F2N5hVIa10FDZ+iX5/KVQJq5o2Ihb4fMO2A7Jb6cZ+zCrM343hqzi?=
 =?us-ascii?Q?YNIdc1P+UppdPrOCvVShpK4UFaCX4x/kMcgKkMqJ93ELa1QmGFo4MsFkluqS?=
 =?us-ascii?Q?PuQM/gVwT7BwDJHH0zpvGQ7SvaNWeSN7fb3LhTfeY+w+LERCR9sCEj4xasJB?=
 =?us-ascii?Q?cIfbLtNJI1U+obfBgGfsvDiGJwXaDOTfFNSDaX2PmrQ+pENOhoqTReNWFUuu?=
 =?us-ascii?Q?7LbAmKJLdMHhiTCZN9VY5AlOLmU8A+M6jhaN+pNB+mQTJbdrfujKzm8HHSbz?=
 =?us-ascii?Q?mBMIXdNaVocljBjTpAV7kwMjOzjSppeY2plDnIl/nAHKFV4YXTkA81Lu6Avz?=
 =?us-ascii?Q?TLUXbNfLNvo0qr1gLaUnpm6QHg6IdoEEMNjIbHx/S51K/i43ykJbWlbFRmjE?=
 =?us-ascii?Q?nl4cFt0BBV3SHUdhWer7qt4KMDzTOdYKCguCJ4kpdEAbuOlT8OcB9EDJ+VPi?=
 =?us-ascii?Q?vLakwz4QzTMOfYA8xqMfPFGnr3CgjXgLAZV33mdcDAtk9khxsRxhYk8RHzOJ?=
 =?us-ascii?Q?vFcYZbyC3xGOXvwVrvf8IGBPOIpAZGPTbMm+zSw1smjUJ6axdc1SGZqqqRV2?=
 =?us-ascii?Q?a1Q5WjrCmQ7yGE7l/rww96lqOJUa6YxL2fIca7ByhMZNlzDlzfLuM2u+iBSX?=
 =?us-ascii?Q?G4nPnWA6ZXEpzg4XG193yR2zmcgXKe2AAbMMDj6+5+y7fko9Ehyu7vDhDw6+?=
 =?us-ascii?Q?dZbK3mJ8Gj4nsWItSQNEIK+bE4qon2t8wqkuJhWQBp3qQXP72EXWi9KdGBg8?=
 =?us-ascii?Q?GegbSmAAVCUjfgehyj/tpwyOuPv8EGn2NkJTSZil7SQ7LaLSNQx44fXAUZXN?=
 =?us-ascii?Q?I5LyE+Tymizri4K/vTS/DSUscKx3pj322R7XHrHVVOYA0ME7li9sM0CDmQEe?=
 =?us-ascii?Q?AMJeM6gEEztWN55PxQUVthfy8zpvuQ0WClxlvugVAbFe5pYnupaCZ7GHzOH7?=
 =?us-ascii?Q?5gRcw3jdgaGAGPn76Kcms8q51B52T56lO9AYLOdNzfJcc5Ul5N4AtmYaftwb?=
 =?us-ascii?Q?M8FQvZ7TysnnJk+bvERqXntMGTZZeaLo4yk8fP7DoOK0J04uB3FJiZHYceE8?=
 =?us-ascii?Q?AIU2+iYT5wd2Ff6ZHqTRvW8roVvTI0RGS7rCtdHq73yja0funNRUHpMHSnBw?=
 =?us-ascii?Q?mBNQlVPWeSjrppVhPp2UB4BBgV6TEPXByRT4O/i6NCl2l7PLBTp7z1DFTcXx?=
 =?us-ascii?Q?83h1HTbd+htidBh6Bi2pwQinR7Vo9UobVPN+EHFsxXFKyr7fohEWlzNLFRph?=
 =?us-ascii?Q?K2akBFjr12Ns45342ukcsKfdlSWIRcj6Rxc/PwX2nPqlyQ3oo2HS6KTM3WDa?=
 =?us-ascii?Q?FEzh2OHF8BOYpVYBCFrcIUrgNhgaOWokBtLGeAnT1oqH/jqChwH769AWZ9oH?=
 =?us-ascii?Q?TRtfeJWUzxP17c8INTqDcrNlGg3icCpC0uOlQYGKo7x/P/DpTPtUmz5OijM+?=
 =?us-ascii?Q?X9QYcNtlZp2YdElIIp1UE9tbw7NmaMar79XKyvcg1VhVboGoZJRPFOwSXyiM?=
 =?us-ascii?Q?7lg+Sy0vDWNmuEMIW/j7/6iGuSH0o0plXS/ipyl7MNiFmNcXTmJsWevhA1N7?=
 =?us-ascii?Q?lL1ssgERx51VDyo5add6QlBo8lXg7VWwIWpKOTTCCN6BdVTzuKad5UNDEomC?=
 =?us-ascii?Q?zjUFyB/xILQRvhuJMHHGAb9KX/wveJ4=3D?=
X-Exchange-RoutingPolicyChecked: If483GbTyMf9xCbPWOpmmjWVs1SAVur2kyptt1II69EnFHmwhotXaXiFvcycOn1tzalovrc3Zlt7R+peBsnuD1Cn63FCXE055rmrUsNcmttkTLf7XvvQyZcmCZXUGFzzKRFV1frq41z3k+8JwRoGThDkAeU4RZTcPMtx8TMyrqou54D4PuiFCc+vnTNP75mZgnRyhtivyJNFqlz5vcP6gCxlUKSU4o87PzZ2eTTE4FZikc9ULo7WH22Pvlg/iqqpSheATbwQQ2daDzvuxw+t4/z3eqp5bhxUg8SkM75IzCnytLXslRGiqxbj+R7RMkdi42doPSbZwitpPpesREEb7Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: e820508e-b159-4084-4c6f-08deb5c16ee2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 16:12:33.0769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JW9tHzCDenb0YaDF0N/gcrN2MBsGrB6keDXzD7wlKr5ZyvUxUh7zroyMay+SW95R7QrORI8pd9QiG6h7aG4suh7zfbHExMBO24OYZ8+hUiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2D9C959A2
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

On Wed, May 06, 2026 at 03:07:03PM +0100, Anatoly Burakov wrote:
> The PF will check buffer size for being too big, and the chunk sizing code
> correctly calls that out. However, the size was actually still too big
> because `struct virtchnl_queue_vector_maps` already had one queue vector
> as part of its definition, so `chunk_sz` was too big by 1.
> 
> Fixes: 292d3b781ac4 ("net/iavf: replace unnecessary hugepage memory allocations")
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Although there is discussion on-list about this patch, none of it concerns
this patch being wrong in itself, but rather future cleanup work done.
Therefore, I'm considering this patch for merge to next-net-intel shortly.

/Bruce

>  drivers/net/intel/iavf/iavf_vchnl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
> index c2f340db81..dd09b0fa61 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -1528,7 +1528,7 @@ iavf_config_irq_map_lv_chunk(struct iavf_adapter *adapter,
>  
>  	/* for some reason PF side checks for buffer being too big, so adjust it down */
>  	buf_len = sizeof(struct virtchnl_queue_vector_maps) +
> -		  sizeof(struct virtchnl_queue_vector) * chunk_sz;
> +		  sizeof(struct virtchnl_queue_vector) * (chunk_sz - 1);
>  
>  	args.ops = VIRTCHNL_OP_MAP_QUEUE_VECTOR;
>  	args.in_args = (u8 *)map_info;
> -- 
> 2.47.3
> 
