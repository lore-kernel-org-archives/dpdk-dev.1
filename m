Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B630606A329
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DZyVFPsZ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5712E400D7;
	Tue, 27 Oct 2026 12:33:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTPS id DEB7C400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 12:33:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793100799; x=1824636799;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=vzxj636nf0B/zivaA1J3Oda7kmQZt5YOWSxcL7liptc=;
 b=DZyVFPsZQev+avgCodPUSm6lyO3KbSpPOeLxrjQhsMsWCWjmjmooJzDP
 QTHzbndQMlzmZ6xbbSTx7DvSssy5lAWu2U5wIzB2Mb4090IkYW3FVU8Ki
 UbJUAQa0WM95n4t10wvt6Ar3ttZ+EKNK2NNguXpXVmffS+8ObJR0CsOaB
 n+tb9Ef683qi/LWPxx6pst8m586pfxe59S8pJ4sMyPVEVMwwHYFa2h9i2
 +tKpte9QjZM/qM/tV9EF8IWVq/WSyg3h0sPiZOOcJKBezX2MbJSL1WSCA
 YeTbRygFCwd5ifxePcybaBYTB3aNsc/1wPRcncJOHfYiN1gh6lT4RKgzL Q==;
X-CSE-ConnectionGUID: KnYGxGTfQMqdgAu+VvN/lg==
X-CSE-MsgGUID: dFb/e2YBRbaVNc5jgcU8rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1792201"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1792201"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 04:33:17 -0700
X-CSE-ConnectionGUID: Z/T38pcbRGC7ByfJ1SoSGQ==
X-CSE-MsgGUID: SJ8bPaTtT+iJl8tbk9F2iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4672272"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 04:33:17 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 04:33:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 04:33:16 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 04:33:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwBuydFIqMQPR0a28NsWUamaqcBxH+IWGpCCXNfErHx63+eSgBaKTj7WJ4iHD/YiSga/FBMQY5UdDpddko5X+JiAmVMRMAHajsf1hzknrBhG8fOP9m0k8xjafiduAKZglRJ0txxnBruLCXx5od37j2CriQQSuxfxOnW7+sJR79HqEi6gIarndX9yhbugGc6WzN4YtEhlBLLS9cAsLoZfBL01fYGDH6uBvlLcsYxxPH+Rxs8PAc/ffv2Pga5gt9dsm5WvN5qxMK13QsjiKlVoHHdbdnZ2cIqfazOrmGlXSkJaaBggmeEmTs9VpCnHoCJoZS2o7Rtg2U0z5uiF9qz98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiBrE8LdyC6JzDVnaF5rKEm39Jqtnz7JLj7c/OCc8IU=;
 b=ee/qjB37htr0QeVk/uGx3CmMaH/IfMVAGbvxvG1vbpCjGzQ+1rjF1WCXDhZxlpwVbqK1JqcTC9WjA/ns79QV1KqPMFi32mQMidDs5OAqSi88HAMfnalSdAj6ZsiGCfEbqpFKU4AVplt3hwImHYXluX9pNjrF1aWsYkRcOuulJlVtx8+42/XCzlkFJIeIRxqw8vnT79qG6MyB/5mujeQ7Gx5bmtny53+zvK7LYGlCsPeXS2tVawiDptRTzqx2XXuvlsVI9sxsXSExDjLhnphQNwx2yNfQ4Hnu9nVLA51xgrqaN9wXDN4txW9UlcjtneCq75QWthU/p+Og1egPFZ9Hwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by FT1PR11MB981990.namprd11.prod.outlook.com (2603:10b6:170:36::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 11:33:09 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0546.016; Tue, 27 Oct 2026
 11:33:09 +0000
Date: Tue, 27 Oct 2026 11:33:03 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andrey Mokrushin <a.mokrushin@ideco.ru>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>,
 <vladimir.medvedkin@intel.com>, <sdl.dpdk@linuxtesting.org>
Subject: Re: [PATCH] net/ixgbe: remove unreachable WFQ weight mode check
Message-ID: <auCL7yjzLo5I_fJh@bricha3-mobl1.ger.corp.intel.com>
References: <20261022130724.17371-1-a.mokrushin@ideco.ru>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261022130724.17371-1-a.mokrushin@ideco.ru>
X-ClientProxiedBy: DB9PR02CA0007.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::12) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|FT1PR11MB981990:EE_
X-MS-Office365-Filtering-Correlation-Id: 66253f18-3838-4edf-a015-08df341e1367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261026140227099003|11063799006|56012099006|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: L1J/cZjpGHMfxTDCsU9VlEBwR3Yt4JAUWtgT/pHPYObuxY86UnYiOpYDsm0hoThrH6T3OOj66kg3NIJ0Q2rGFbBqIaiXIz8HGadJZAa4voMsgOtpORYZ6ZPsCqrOF8Zee0tJdx11et6SGkCsaTUcAVyqfM/7TDR0Dda4X0Njeu0d8+IC/rZfF+PrjqFDN7uOes83tTdQuDouFTdSv+LBldB9WZ7HJd0EYGB6XHbZPS+PIr79jPySojBGjRHXZbstWlFPw8rumoJxpVEAAZ/0M4jtlENEjKOLpUGu5GXFJX0EDS7g7Vr46sBCWUboOjbi2/HShGD9etzCJKNSt18vvbv1e1Z99kfsW2D7DNPAiHlSu2nCFA2PJ8ovrAhUuUMhK7fuHW+keWoAcU1h/Blq7iwf9HncENzLmIOzZ/TkJgLdnI79pXMaPld9lXxQ4CTUoAWuj0cdNt/Qt/cETJdcrwm5H54Kk5qwnk6eATum5d1i6+RNPy5CyK43oIf/Dz44xqlQoqjjOJ0oztEF1GG64JzjfULBO4AIlr1U/r4zmPtK5QezHEcQovUhlnuJAtNQf8c8Uu2qDZOWwVTTqmaDKk1rHCfzZs+5lS3OkLZD7Pmg+QXuuNoZKvZ/+IPcC4YM0er/33WS9IGgGN19TAGL+yRiVuoNriE4mk+38q/ZKc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261026140227099003)(11063799006)(56012099006)(261022105027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uFexiI0m2sRMhAzR8DhkHql5c6HY3jqc5sHKuQkhKtrathBgTMPR67Ct1UtU?=
 =?us-ascii?Q?O6whqtxfOnWxAOFD3Mb62vkgTP8/QEnI4VW4Q5GjCd74uUZchExevmz70C92?=
 =?us-ascii?Q?eyBDx8emoeEy/TKBVZANBh3WQWiKtCSZ7xmKUWgOSwQXLSMZBqcBZMniG2GB?=
 =?us-ascii?Q?jkxH6nmE1BZjirmrGVsakYgPPg5kwFfXJfleaawKi1IT84iGOYN70EbmQiwR?=
 =?us-ascii?Q?vSazsVTrEXRI2v6TePpnqU82RgVv2gu6w4IQykHs86ZqGa+6kbjudD4Riry5?=
 =?us-ascii?Q?3PaJxuLpmtT5Us2Nx5jZwAcO7SiwPJgWcu5n8XaVXD4noIZewvrsOlj3lSEV?=
 =?us-ascii?Q?Qd7He4Ai1rIY8nn2uAZjgf7eKRGkHT1oB7yio+DCO54xwXRuGa0/Gm6rvlXL?=
 =?us-ascii?Q?6IBmQMFkscJg/idEpcSNKCmmIk/casSns/ae5WAjFiwTTf7O78F1HOr8nS4X?=
 =?us-ascii?Q?ixmyLk/Nv4hwVhoXUmx/6x5Yq3levJVN0+42a9ZpP8jOzlvbR7o5q2iE5rBP?=
 =?us-ascii?Q?1qQ5ruGd+6cUOu25c5vMdARxKlX2pLBuvJIWWKyFHIRs8pbboi6vTJ55peAi?=
 =?us-ascii?Q?BKzKyW/bYcMZkz6SbBZNAddtSgTJuDH12w4+p0ZuPbgguiCuo7QRJzf91raP?=
 =?us-ascii?Q?NCZho8+cRjRxDUz+rD5KG9/14p1C2JRvhoIpDfAWjcZdHN1toccOKhrvd4tP?=
 =?us-ascii?Q?Nk3lecfv/vRQP+ffSVZxff8KAHEPMIlUU26t9aob1vehMkX+Vd4qoWlROY19?=
 =?us-ascii?Q?adazPunQsjC/muwtUtMxf0QbUFctE5+tf2CNxeg5tHwCmDOYm01tMlhMgz/h?=
 =?us-ascii?Q?5eVgvnnO9Rqe9fDERghG4WNsF/LrZpD6PHfFC6E/C5RssEFz3dQs0mOAelAB?=
 =?us-ascii?Q?TmT980EA367hs5/J3C4xlfQmKCcp7SkrOdwCwyb0M/2nP0fx9nE78lZU3D3f?=
 =?us-ascii?Q?buocwJqeIoY4R64uCPFiYE6kNNT1lm6HV8RisjSQoMSIl7lAnBz25awvfYO8?=
 =?us-ascii?Q?1q1w24yhToFxGQWXNZW3G1jM+tKJfNuROg8LXH6YCCkuYadrYA0dfAnZITSV?=
 =?us-ascii?Q?jC3OV6deUKjnVeXNkm8h892pj5sPh/NfGtw8Gpmn5RY98WzY3ozMIOBzITg4?=
 =?us-ascii?Q?q7NoyGS1KH9wrG8JpQIBWTEW5D6qgVsSx4UisVOpSwpZXotgq9IfwPfKzUB4?=
 =?us-ascii?Q?0DsYo5FHzCYO5AO/vvEf4l6pfZQ/UDBiUGyBx3CtxBCaB6NL8zUShfF84ktF?=
 =?us-ascii?Q?cngmLdrvU8pIoVE6HteOc1ak5oxMVOvoUyenxmncUjVSgO0OWQQzCuBVwkaS?=
 =?us-ascii?Q?dDhzXIY6XXEo3v4kT/ax2KtzTv/2KXg8I1HVCcUSmXhz9uIoLr8TGLRA4nG3?=
 =?us-ascii?Q?ihlhWvQ1nQSS/3fDCsTG57BevdpwbtHoAwg8BW4UQgFEF5ebPFeg6NDUH+3K?=
 =?us-ascii?Q?2ri5r73O9qYoUa30H5j+eA92MSL/Ywpy41AhoWOZ78fdAv1pwNxJCZFt0Utr?=
 =?us-ascii?Q?rHcrQqrF8BDgKbfvoesgOEkJaEx/RqbZOm+eav0avTvnm9rL+I3mlTqoNVHK?=
 =?us-ascii?Q?Kg26TuxcANUzpVdnRBSv1UApVYLHFOi3jJSXhPrGckshoDnZRBm3k6EE31lS?=
 =?us-ascii?Q?ljivWhxLjYu8yQV7rpZ4RG861yFlmCtHIdWl+/dOfeKs9nIE16Tkf6N0Y3Va?=
 =?us-ascii?Q?hrJ9e0WbAyQP805KZNa2yFKAshDnRRvQvGbDH1R+ZdBacq6GGro2qxezSZYK?=
 =?us-ascii?Q?OuUFES94IQeemPMmdpqg7PKRTDZ3Yv8=3D?=
X-Exchange-RoutingPolicyChecked: fQ/uwUEO+p2QVej3CY4MwOGNKp8sAImVsNCcJZSe9myj4JfRttxWQ6r0d1s0q4KIC6EgNRH25HV59xlagKUmRwukbC50NRcbj6zMUlhpvdHgO24gLjio1QDNfQ6ok7P6HRSvFALKUHA0Rd+nMvfAzZjH9UBQaQhh33Gyg4he/mv+3+VUhLffsWnfNhSbBJ4Ii+Db9RCzu3bGdz5K2abvOzAlvmo2bpyJ/sII1+ZRGr92izce9Lr/MNeqgux1pujzeQhJezKwRvt755aeZiUd+Fd5msNKH+8gPtZVOrnJyZ/pNneO5uvFygX8/zm/hNG8CXPoKbEIfII74z4jcT+ReA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 66253f18-3838-4edf-a015-08df341e1367
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 11:33:09.1199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlGWoQ9PULDAyvhUFEit67ZlFv4qfPiVBTu/nhSSCqwn4es1ITrLz0zvkjneSIwGtWTxv+gZh89GlSFYsmZKCFMixGRRxLkjtstMNzKm7oc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR11MB981990
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 06:07:24PM +0500, Andrey Mokrushin wrote:
> In ixgbe_node_param_check(), a non-NULL nonleaf.wfq_weight_mode
> of a non-leaf node is already rejected with "WFQ not supported"
> before the n_sp_priorities check. The pointer is not modified
> afterwards, so the following else-if branch that checks it again
> ("WFP should be byte mode") can never be taken.
> 
> Remove the dead branch. No functional change.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Andrey Mokrushin <a.mokrushin@ideco.ru>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
/Bruce
