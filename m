Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54F8C982D8
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 13:24:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCD03432CC;
	Fri, 18 Sep 2026 15:24:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id C04AE4325A
 for <dev@dpdk.org>; Fri, 18 Sep 2026 15:24:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789737874; x=1821273874;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=9GOxVyAdrerd5UCPCiYmb++QWZnwwe6jl/MAgvQFLto=;
 b=jeCKBZ/avPlkRVsQl2MfxuB34AtVBTsEs/3OAjf5IDDjKXVbCe5n0EcR
 jYnBMz5M4JLNiEhnfBzdZOBmiawIA0M6NLbDT0bTLIXbJuSNm4sHgrHnN
 CEyW2pZDlhe8ZpTuX7OdusROI/Z9bWSPHuinvJyQsFdxDgmUsrquwr2BS
 JkiHJGx9HQI18vrdVNDKCWZu4T+pzFLabBz1UzOy7x/AGXuqZNljj17kR
 QzEEeJN7W2ponCQQ2qnlk/TqRqto/7EM12y+nzQBFu7FyAxuqDWR+67hD
 OUUtgEC+oa270G3EwWK18miUECPh/R3X6uEajRuYFeiV8vpvkVh1Bz+lE A==;
X-CSE-ConnectionGUID: KDntU57OQICbLvPuLPxhdA==
X-CSE-MsgGUID: Srv9V1s+SoKvLuWkIcDdXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="92752339"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="92752339"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:24:32 -0700
X-CSE-ConnectionGUID: 3jw+NGOKSgqJj8tGnElfDg==
X-CSE-MsgGUID: drN8Cx3cSr6ZiICpT/JSvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="270098705"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:24:32 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 06:24:32 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 06:24:32 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.15) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 06:24:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0SljwAiva0PlRlCsWvmZ+FFMkxxlf/vycq9Sqs4kPvQoLVgdJ1TFHD8vsSilRzS4aof+PVyEdgwi2xSbvhAXpHRvRpZfCnOrOWRMEnPK4VjtQnKxnK86Tq+dtYcbxu1tZyeFa+Wf70qmUmTX6qHNmq6x1D8PWifjl6yMd0j8SgdilcL/DC+WLsmxFt2hj4QTZuT0mezUItZSING3JDP2QNUuO1+nZQRk+8epwh52fce1p06rMYOrMpSrF48FEbgF1YTXcQtLmOhnhxtSOLZ/m+AF4np2XMvTm1YmaiEWBGYemmwNy7DH1rY7hUwUY6Bnydzc5Trf6gUYnyzSnVSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fLnC4Kjrx1gnHr2v+61+s/qmMtu7o93mydfzO1WoUE=;
 b=qZqh+urIfAnENXkEkEQwsHFmV0mJEEzEdfytEe4bL5G1KNOOiF552qFKjKYXDrQARCAGedl+lMqTEPahtFt7Uq9bRbMtzyJ13NTu9PJG6h3KKN8WW1xg8pBTqSC+1TkA6KLf35WX/cw8as1mtX3gJPVLaDisRrjFtc+GQdN6uil8rkxZApl0IUYm2Z6NNkz+XldWI1Zh5Wo70hArH/pWNBw+F1vvyDIuIVWKOsbPh11DP9F/Bg8yapKB3/zjx7aaRsqnScjdHx6aW1zBGVD9pACLKV39gJOaK13dJTJ6nGpwC8sgrtJd/FAbPS31G2+uA9+5XVZcd9hBmCKVVUMBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CYYPR11MB8306.namprd11.prod.outlook.com (2603:10b6:930:c6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 13:24:24 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 13:24:24 +0000
Date: Fri, 18 Sep 2026 14:24:19 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Omar Munchaev <omarmunchaev@gmail.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2] net/intel: use rte_validate_tx_offload function
 correctly for i40e/iavf/ice drivers
Message-ID: <aq07g82C7Ofmaxow@bricha3-mobl1.ger.corp.intel.com>
References: <20260916162927.2137856-1-omarmunchaev@gmail.com>
 <aq05Tvy9xSXjuQR1@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aq05Tvy9xSXjuQR1@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU2PR04CA0041.eurprd04.prod.outlook.com
 (2603:10a6:10:234::16) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CYYPR11MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c6ce7a-6438-40e8-ff57-08df1588282c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DXpJj4l2fwMpgfEYfDdK5kCdVDeegy1d8DV9wKWvkNCj4uMSYfcsQdy3smEcTf3E7VPj66A3TpHE99oqHfr9LusouAXDMAZyJAnCZFvkcektqBfGtcT4uyXdSbHjbPLb6jQguo9F2Bmus0ebgnHvnr46Ih2VPYO5qtm6TsWgRghc0yEHf07/Q977zJLQTXyxvzEMVGXzfDZXAHovI2Vbk0gWblfXVxpGLTGs0l0HFD1Ksj6ozKzbZ07/NiYaL+gMdLebpUep8zBhRkzvNguln2L3JjvnNr+7P0fsce9GRzHeyzBHRy2wGcQV9Z1JhAFhs3CZwLn6j8gz/aeSSsSdvdEmFVSxr05ssLMSUrHDD5mUOiRz4xirVNMenOWsXgaeZ29zkXQjEje0mSTzwMdn4nUNm+ndcGJolgunVkgWu2+HqYcvp37rIaHfuuZoeu45CQmXv61VSPmAplDQ+uNKV89CxCXeYgfF3xk7pEnZkHL/KIxp1IfAz9U32UMIfpiVHsAf1eBt/wqxFSASnit+Gw2n8WdrFBsfUmTC5XDAkyIfGDqX8zKX0RWshQNozbi1xItk6WoqLqZeQgSPDkk90CM5AdOvHnXUB3RdXd5eRbGn5SqNOBiFegPeO4/Cpxrvwo7Vus+7CKW/l0UxhGSxwOU9Y+cM+7obuLWvUfsQq+8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5QyrBC79eVJ6zQFop5fspwDNa6EHI1gyrPsxjuGuS0Dj77GkVozqWLHXIijt?=
 =?us-ascii?Q?kktUTagKrk1jgQotc+myG5oSCh6AFMM0qKGhOFNzkc5QZCvd8d3RlONNeuuU?=
 =?us-ascii?Q?IzUw9FGt1yrUu3dqA9eu8qq7i+7Wo36IXE8IRrXn6ds5w7FuRWVGMsIksmLB?=
 =?us-ascii?Q?x85K4PsvwO/iz7zzHxzEEDL14Z9/URVKT8bLQJE0zh4npKDABYqKNGDQ0dil?=
 =?us-ascii?Q?xMgSCXcgASLpDSuc3ULDnfRjKBSx5rQRGIx/3XQizRW59salEHx0gOhPd3bm?=
 =?us-ascii?Q?rY4nl2IKQcCRZYQT2/zCHrJ3nfiVtMUjaxjx06rxL2sQintdJpqIUV5z8+YB?=
 =?us-ascii?Q?nSiyWIm1mrUio7ewmVXOv2xRdi6LqerrdCHi75GPmx1b6C/Qwb8IBlpJYg5z?=
 =?us-ascii?Q?i4BegwpGZQlOXFt2WyAYE1ercGZAGDxJ9+yEk5+uqaSYLcBna64kzYH1vhoe?=
 =?us-ascii?Q?rtVgMAfDvTVNwEsXHRYbHmNHZV5lJtKj249Clx1enIcSUkyukEkUHbBotOi6?=
 =?us-ascii?Q?13KwK+vAHAe1cgGnroHtoVy51q7Lxb04mP6b43RzXJP3DK1iHHZID5+5iPDa?=
 =?us-ascii?Q?+JSqMmmyPaLLItWy63iPZZJwh3TAmi2NAtPx2jPabauEJXSswXIPWSBqyuJ8?=
 =?us-ascii?Q?2ewY7J3VZFVofQR8msubVlqeKYdkl7v5bgKdOMJSj4FrI7u9FrTcmS+NM4Nq?=
 =?us-ascii?Q?0lcFiHevwMTW1dfeTl1ZmvPGU9bL9iCL1aO6Qc0aw1gRFuxizOfLttEsgDam?=
 =?us-ascii?Q?+PgUBZehummJeRCbvXuNEcY+rlm3Lr5xi8KtwqdhzxfIbvLRSo0K1d5VojEi?=
 =?us-ascii?Q?nKxg37JHZohEflAt/8AaiKkFswdU5Djj9igeLt8b8jIU0WgGUMRs+2g/uRDg?=
 =?us-ascii?Q?ATUisbqpuTjJS4+pNJLOXSEbbYkQJWCtaYS+4TeHGjndH5ZHP5TDGryqpMWa?=
 =?us-ascii?Q?K7HAF9m9qGEG0d0jv0BqSIhSZegRbLyyK+VVE3HqyVgcPFkNdFsiv54UaZNM?=
 =?us-ascii?Q?BuS0G3m+GpdummyqOuKhG9GzTgPkmZvTHFvWUGYHwZFPGMgq0lIcN4jlwyQk?=
 =?us-ascii?Q?YvnWK6ixYixMgV50T7xkTIFBn1HwdIYFlHdNFMb+n/nZ2gM8uIQITC9a9dm7?=
 =?us-ascii?Q?6InXTZTOO6/WD4vq8Y5r2rhTrZLJzabEXMkOeWcIVANw3WM7pMX9D3G6Z0Cj?=
 =?us-ascii?Q?rw4L/oLrRcJilD3kLXINYdYvPpU+vtdnxhxP5gpxfsLstvQYZDDnyPStIII1?=
 =?us-ascii?Q?deg5W7g/rSdKa+jGZ/L0438BPMb5QAzrY733mX55uz4YyjNJ6n+mYWYKC5ip?=
 =?us-ascii?Q?K9FGa8F1LGeW8Q0qz7MjEnAwMVh2wz0wBWMtSUPSJhAFBCh4EzuAIHJKCQbE?=
 =?us-ascii?Q?errXDeUm2G7fFjuti02w60xGIizMVV4pOuGZfVGWpO8rLSWAG3MyanycrYxR?=
 =?us-ascii?Q?xR/TF+0mN628CViORGEZ4zJZOdULIavCN2K8JxcezptvfYlrB23KDOfrYg+e?=
 =?us-ascii?Q?TXw5P6hUttm5ccJEtPFf7Jrk95Yc3ezKtl3OtWs9H5Qldio/qguyWaExnVMM?=
 =?us-ascii?Q?kFHBeOk/aJXhiDP178142gHO7A65IkJhQ+RkPFo7/vPabUgvjWzDCwpp9Cs9?=
 =?us-ascii?Q?DuAxbLj7Enj4gSY4P06PRicTfoxGho3BWsHDy4GnJesXfbyU4pbgF+3Ne5u7?=
 =?us-ascii?Q?IVJ31SJ4pQlnyWV1e8g24hN1NXlrHY9wr8R8GeSF+ro70mInHAiaBvBAZbU/?=
 =?us-ascii?Q?jwEIgF9qFuvMjbKunaaEi96ATbL8TCc=3D?=
X-Exchange-RoutingPolicyChecked: V8p4OLVi6iooyKy3WKx/1isDf4MncB2e5MK1UTcPZhc5guBfDo5S8YES+lh4ehcxVe5Om0dKUTsQoiRVzEjHr/iWfIs5DwfpKp2BC+fhjTJWC/hbHIcg7ozVdDrS3Q+Nn7WBD/DxODAIJEZ8QTTfWinM3ETSEvGGQKjfzaj0LWHR9/OE3FlMSiQJcJW0FswjcpBH6AjDEN17+Aq9sRQtuH27SN/8eVih0EooTwkeQD4mPdXp1mLbInB+7p+nGRwib05b3Kz9Qq/7kNY/QeZJLKQe1tgpRzYZ5XyLnkDzfa7B0P61h5fmIFWJcOmK2CQUzGXiL2nzWqympsF3Xvrbtw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c6ce7a-6438-40e8-ff57-08df1588282c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:24:24.6272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DKPhr/+en5JSHZvNyp91/vusAdZzsJCEq4RF/VOkFbAurggDcRC4aLAKXXQ764hiIioSoRZ25dqYLRwchvJfHOt8byte+4rDOBY/1Ltm2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8306
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

On Fri, Sep 18, 2026 at 02:14:54PM +0100, Bruce Richardson wrote:
> On Wed, Sep 16, 2026 at 07:29:04PM +0300, Omar Munchaev wrote:
> > rte_validate_tx_offload() returns 0 on success.
> > The i40e, iavf and ice drivers treat any non-zero
> > return as an error and drop the packet, causing valid packets to be
> > dropped when Tx offload checking is enabled via EAL, e.g.:
> > 
> >     -a 81:00.0,mbuf_check=offload
> > 
> > Only reject the packet when the return value is not 0.
> > 
> > Signed-off-by: Omar Munchaev <omarmunchaev@gmail.com>
> > ---
> > v2:
> > - Fixed From/Signed-off-by email address mismatch
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Patch applied to dpdk-next-net-intel [with fixes lines to allow backport]

Thanks,
/Bruce
