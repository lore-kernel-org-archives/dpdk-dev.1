Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954EACD6E7D
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 14:51:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBF6E402D3;
	Fri,  5 Jun 2026 16:51:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 3A116402BA
 for <dev@dpdk.org>; Fri,  5 Jun 2026 16:51:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780671099; x=1812207099;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=dCFeqeCsZzSG4qt7hvFDYzXtY2hWLLIk7gRsLowHbfQ=;
 b=hIaRls7NXjfYjHStvOq4N8AvetmmnHBYnCVTnpoHzzKVehxC+ongQH4G
 XE2nLjNxC8fa/IwCzhG/2/F6PNKYxdtK3Nc8/4bQ1brfxDu3WOeh3bBue
 y5Ga58StneNPePonOjHFFATu3dOjYzGEXS53uNYr87vF9VFoTzV9aIGjE
 B0Z6AIiLXpXF635aqriUGXOBJv/CYHyaFkPPZN31cF44AGBiEs0HHPucf
 QP1i6NSQyFj71BzKQsuhidKWMycYrnQMuKIjH9oFsWxSjgjrD8F8meGRJ
 PyMmbaNvgyPb2LXepwsw5c+TPAnIOqq+QGXwoa8idS5UcO7kVAN6qSaey g==;
X-CSE-ConnectionGUID: n9HLapLqQYemKPiC9CFRAg==
X-CSE-MsgGUID: giSE4mCMQoOMX1GUoIovkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81565216"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="81565216"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 07:51:38 -0700
X-CSE-ConnectionGUID: AWNeti7kQ7i07mqnoPoFaA==
X-CSE-MsgGUID: 358CLN4rReWiSQSv+/UWEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="244720459"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 07:51:37 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 07:51:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 07:51:36 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 07:51:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQC+BfxrmqxfLv6/O1KIWX+XKXKAT30kLv3oLq3lWX+/TGM4OdsQxPGTi3jRYXfldNVhKa2/pgjiBtGgplFhZ0Am58HSNnhCKrizXSNn4f4CAPO25VzYkomFJxJdFK87JCMsUp7WEPMBurhKOobemQXalkUiTw9n9Buzbe0lxUmEkwK9Lq+u8M1Q1SSdCHl2/iXgA0hwERkYb8SLwYOrOrn6F8upVvQf6COEsAGJ4gLY7GvPRM2MkVzL/0NTF7/zyfJ7uqQmrM0Osiijonl5xA1kxT7tViVNV0QnE3lWdChVWu2yGavLseM92XTVooZTLg00fJ1jKJRunv0Oipl2SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSS+ocLS/pa/fzeRyOwJweRcrHFBmdTd1EPgUFa4nq0=;
 b=YHJau2mmuHuZicR93e9mz9BtiQmsf9mLXVslMF+4sCYLYvSXX/TrtfqvbSFeirxPwg1DFvyoRB3X1/vdyDetHpdBLjkJW3TKjqDOJw7rMEaB7Q7aSguuwisms1bE3BpPIWKI1eDXMtVXRxN28omI/zFehow4/sZ1bNV3Ox9kfL3wXnsQ0VZpnd2qKh4+7PAyMPN8lQI3sWLB678lCSprFrUkO/pk7LxsycCenSO+89svvq0Ebfxl2QLKbm6K3Fc/Lr89RtiHBH3ozI4KDb8xfe+ihKBxX7IWmiM2GTOZq4T6juOhxvr+V6CkKS0jO7zQSbHOVVD03cC36ANSdkQjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MW4PR11MB6886.namprd11.prod.outlook.com (2603:10b6:303:224::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 14:51:33 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 14:51:33 +0000
Message-ID: <25bf3911-e407-40aa-a0b6-3c51796f50f6@intel.com>
Date: Fri, 5 Jun 2026 16:51:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] net/ice: fix GTP-U failure due to wrong tunnel profile
To: Shaiq Wani <shaiq.wani@intel.com>, <dev@dpdk.org>,
 <bruce.richardson@intel.com>, <aman.deep.singh@intel.com>
References: <20260427023115.1225843-1-shaiq.wani@intel.com>
 <20260427023115.1225843-6-shaiq.wani@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260427023115.1225843-6-shaiq.wani@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::22) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|MW4PR11MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b75734-df14-454c-197d-08dec311ef34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: hC2/yq1+Iyk+1lW+ruMStvyEUAT6rCXHvGLAf72OJvfRTV9aDJkJOMNzsYUETX9TKZqiCr3E3wpHEpMBR90GG9SOL07/iyB8LdZVNVy7X+h2R6iMqFbuwT5MVd4+sFlDhd5dWtdijjDgbzj5X5JLJR57Vwn56R1eabkKpeBa9jm6zRJZnYfRRUuhVWoASUcL3YKyY7moE+nU6l6bqsAVHQjAnufEg0BF3N0Fzw1Brp81Q1tv8ViFbd0WHuICFUoBXsi4NzBxO0NxYVYgOmNpujMtM94CVQU5e0LOvl1GXZPZkCx5dytNke0BaDEY62dHM1ZXcvuPXl6ql1Yo0M1PfiyzLhNynsOVETbjup4SyRmaMH8eXt8FKJWfm2BE3KZrxJ8YW/dBhQEye072p5C+O5y+CyKYxmBhMcLrGEu2eF9uIBJnZgHy8i/fap/NbThRMsJ1AMMgYCzxLWxDxwE4OlYn7PeTsCtt3y8t45DeXOXSnTxwDOG3vUtku3Roojrkk6GpKjOGgnB+HqK5d4iS48TUJn+U5fhNpgzsNYBWCzh6iEO377vgsbnL4nK0hwo3HIMLoEVzjqFD/H+/Oj6EuU8KQC+eM7v5BpFmyWFRXizW1vs5zV4Nj0uzRqLygD1udvs7gPPI10EQb8cKtaNzNmZZ/zogSw6NXxV3T1y8zqDw2q2W3rfwDPPsWmSr2vs4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blBpaytQR1M0dkNQaUlUa2Z5d1ZRZWhBTHlJSkVvdlRIWVZJR2xsRUdDUGow?=
 =?utf-8?B?TXRuS0x0QTdzUEN0UGFMUXp6WlpWRi9hOEtIRnNldlJlbWlvdEpxa0UxbnlL?=
 =?utf-8?B?OC9CNk9Ob2JnbmNiWGk5eDZ2djQ3TzJabWdQMFZQTUlJRFUrVUdmaXYzRjhC?=
 =?utf-8?B?RlpGNUJRcXpSZmxVb21YMlNiT0t0ZGhNc1N2UlN4MUpJUDgwMXpudGN1bUtV?=
 =?utf-8?B?Tm5xLzQvOVhRbzAxNStwR285WGVPci9GcFZZMHdGZVVPR2FwL3BiQlNDdjZW?=
 =?utf-8?B?YzNZY28yWDdEYm9xRjhobDlISkY1WEJDZGlQeDl6a1NLVFYvU05ybEJleDcy?=
 =?utf-8?B?OC84ZTJUbjB2VEJzdDdRTHlzUkNIanZvRGZORjdOVnhQNUZEYlYweFRuMWo2?=
 =?utf-8?B?UGo0MnkwY25neEpNVGZkWjdSUU9xaE1WMUcyZDUzYmlPcG1yUnR5SjJYYmNl?=
 =?utf-8?B?ZVNxT25vVXlpaSs2RjBxcm5RSVpuWVlWbm9OcldJcW9ZYUUvMEZUTXJ1QVVt?=
 =?utf-8?B?S05WTnlOTVZpcFBCRlduWGlERWRqZDZCc21lUTJXK0kyQkRPNFdPTTJXUUto?=
 =?utf-8?B?R2ZSaC9vM09PSllUMVFMaEpPRmNVaXVSa1hSUXpYc1ZBRDc2amJEdXpSU2h3?=
 =?utf-8?B?NVovRW1MaVlZQzh6TUdkSWNad1Jtc3hpSSt2bDJqcjZONSt4bTJNRTdqN1d3?=
 =?utf-8?B?eloyMDlqQTdVbXBreExqR3FlZWZua0swb0lyRENmNzU1MkhObHdHK0lrVDU5?=
 =?utf-8?B?NDlCUzBvbVVldUl3Y3NnbVMyaWNvTmFsSitGN2V6WGVQY2J3a3AzMnI4cEdN?=
 =?utf-8?B?NVQ0VFRnQ2hhdDlwcGRuMGlGalBCRWNUVjlvTHc3M2FmdHJmWERIdUNqaXZ5?=
 =?utf-8?B?ejFqemRDTFRvUVkwSGo5dVQ0WGgxTVgwQkVVckpXQmpsZnE1UytUT2dpaCtt?=
 =?utf-8?B?UDdBNkVxWSthNUdMenV6dU9wa2ZOZWRQRnBNWmhKNVN5U1crdUVETU5HVGlh?=
 =?utf-8?B?OVZhdFFtZEtKUjZpWlh6TklsY0JHeC94VDhtSUtKdWJaMUNVdG53bTZOM3JQ?=
 =?utf-8?B?MHNtRGFONjlvTGxCT3NjL3lDanhXRTdYWndGeDUwOEFJenY1eXNOdjhwTXFy?=
 =?utf-8?B?Zm1FdHZNSVZ4SWw1M29oTTBqUnpaNEU3cDdhM1I3ZHp0a0Y1V2pubE95bWMw?=
 =?utf-8?B?OVJlNUI0Vmc4QTRUWm5Kdnd6RFYzSjdCdkFNby9TV3FBRXloV2pZMnloMVlZ?=
 =?utf-8?B?VXFpSFo4MDN0TDRDVUhMTHdkL2F4aXRLazNBQ21OVVdqZEFwQ0EvSHpFZmhW?=
 =?utf-8?B?Z0xZb2k4Wjl3ZGhlSDB4cnVUZTIzYmV5ZEtlRGp5T2ZlRXJ6TWZhQXRJSERI?=
 =?utf-8?B?TUllZ2JTVjB5ZWcvKzdoUXVGTUE0QStNSGwyTmxKdysxS1d0bTNVRXYwd1Zs?=
 =?utf-8?B?YXNGU3Q1a0U3WHNpVE8zSmtKeWZ5VG4weDNqdCtaSWVOWEpTek5pdHFKT1Rt?=
 =?utf-8?B?TTliVGZsS0ZIK0VyeFZ6QWY0MDQ5U0t4MFg5RnQ5K0JNRDcwajFvTVFncXF5?=
 =?utf-8?B?R1BCbjRPNDdwMkNjT0x5SkN0M1pJemtIS1J4RVJtUDFvUXg0L3FyZndwSENT?=
 =?utf-8?B?dTl6VTMwRVlTcllaQXdQOVA1clJBOXBiT3FRRkphMjNCYnZhS2xCSnBiZ0tK?=
 =?utf-8?B?Y3Uwb0xrLzVoQVJwelhiM3A5MkgxdkZSVytFVGkyYlN3bXJ5NFpqcW5ueHEv?=
 =?utf-8?B?bzZVT3o2L3RPbkhLeTYyWEVKU1puL1hxZlV3M2NrakRzTWxjdmhKelBxS2tN?=
 =?utf-8?B?bzJjM2x4d3d4b0k1b3U3M1JCRjlJT2dSMVhYdjNJaFVLT3lMTWtqdHIxVDdz?=
 =?utf-8?B?SFA4OEZSdlRkVUliK0h6bVBGZXBLbVVnUzhNSjYyZTdyZXVuTHZoSzdxL3E4?=
 =?utf-8?B?UTNlUURWcmxCcGxzajhBbHVOT3NFUFhUcmp6N3pFOTJmVWorcDZSM21FamVa?=
 =?utf-8?B?STFYOHJRR2dSQk0rWkhpd25YYlZmZWhjc0xFOW5GMFdyQ3Fyc2dqYy9mdHdM?=
 =?utf-8?B?ODJNSzl5bktrZG9zalFxbUJ1QS9kK1RkeFRlalBQZHpaMmJyVHFwZzF1MUQ4?=
 =?utf-8?B?RlBwQWMzTzdHcDZORnNXUlB6RjRZcDhlc211emxlV0prNkdiMHNMRTFkUm1z?=
 =?utf-8?B?M0d5cGhtanY1MzNDYUY3eGdOOXZTclR3V1k1SGJHWmxjMGV0VVM2YkhBY05x?=
 =?utf-8?B?aEhKWERrTnh6akJyRnVIVVBvMVlCRXlUbjZZVm15SlNsTWhsREhlV1NzdGVq?=
 =?utf-8?B?cWRIVnNlVHFBZEZLQ3ROd3IyZHZJTy83VjFFMlBNN2prQktORmNSaUREcjFU?=
 =?utf-8?Q?4YQBti7Qe0NEtzTU=3D?=
X-Exchange-RoutingPolicyChecked: dJ27Gvk4KPSAk4aHWqVthBw6Q3To3r1W93v4kw1+YJpa8Lpi4LMOrBRp9W2pQ0MLFQ1f6hil5+DqWUIrpEUHQBqsIavTR32uDQk6ymVlCcaIf2P9COsXT9rs+McpVptRw+uccdIFttJlMHEaVp6GBOqKuQYd+U91fpf44AUL3soLJ+2IdS2QqV0qsUVX5NdMbCz+W+AO049W+MxDvnPetN5Acrz6+doRuPEi2uqddbj++xvmKuAJMeTB3fsRgyFZLBI7olcEaKcG9S+HFOHjkWCVxwv+StM3yZ230Y6hPCnoC8ILdVr+kdEBQ1GieUEhWrWYb0POUMU20desN0k3UA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b75734-df14-454c-197d-08dec311ef34
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 14:51:33.1229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eR9rMho8HPtuvLXP3Fm07fONxIU0qnDXczbY3Ih1ljXhQaAe9xEltO6DARyNa1YyVfvCy1IGpzX1gkDm4sisAB8Ev85cQrXiYXTS4W4GVTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6886
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

On 4/27/2026 4:31 AM, Shaiq Wani wrote:
> Remove GTP-U tunnel types from ice_fdir_is_tunnel_profile().
> GTP-U uses a non-tunnel profile path and should not be marked
> as tunnel, which causes training packet generation to fail.
> 
> Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
