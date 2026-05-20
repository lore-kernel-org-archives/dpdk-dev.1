Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5C0CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:22:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBE704065F;
	Wed, 20 May 2026 14:22:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 5E8104029D
 for <dev@dpdk.org>; Wed, 20 May 2026 14:22:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779279722; x=1810815722;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=okCNyTE3jgW+AtCmMi9Xzk07IVfL0sCmquNOnosgDe4=;
 b=Zuh5VUz2Gfop9fISDEUGeciCE/z9Q0dpJRigUdBYvLQdswOXi3NPIcvc
 ZKZ5eajTXPsuDK/JV7krnCqz0UuBhsrnC2V6mOoWRJ6thCihogKqI70kv
 VCHo6qaKVv/hCrZK7g9Yj4WxDiIDfBVSh5IuHON1t58Bm8uDDBtDNc/ZR
 y5DxaiNA7yt6s3cG5pAzDk+t/mC8oRk094JtHWt1X6uFQXFx2ZQ43/AqN
 D+bUUW+U68TQ8Y1dVOZjtNnr+hBUgsx9DoGzp472rmEZFRuHtx54qSIDo
 OHrZECuGVf3XCwoffgQ4vmEYu1g9xV9gsGTUxT15PJfqEYWjscL82PyTh A==;
X-CSE-ConnectionGUID: e+8W4rVCRoyLoW9S+Fxa2Q==
X-CSE-MsgGUID: 4AQzxYunQAuGZq1jN0amzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="97604119"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="97604119"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:22:02 -0700
X-CSE-ConnectionGUID: jKz2IpCvSY6pwHp5KkAbFA==
X-CSE-MsgGUID: WZASEMKUQDSDCx007mjkrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="270511568"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:22:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 05:22:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 05:22:01 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 05:22:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbZa1NJx+Kpnrwu0meqTljlR4sXww7ih4FEuw4w6CTdAMNMmLGzutcPbr6G7Th5nraYWlncUPBcYGGSiazWuaTSUriWng67i+pxhF98YEKuT3IaHNpOtTsjwwR/zUrIWnzPgCJviadLXMZD0yRT94djsV77DA3sb5dNcrosBsg2gxNvw9dQUYHpRXb6xei30WT3D01BplPT+8ctcxEi/PgaSIsWjoLh4LSkOcKIRbK26B5hdhkhGVnEe7gqnNOW92vTsTzyat7O4MMWizCtOXCG0wkgFWo2R7YvJjNfwqPK5ODykYGZizelgPcVyvB+nlaJMMlOR6jIhUUW5ZgioDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUqwVLNfdJHvw8vC31E9bwqx00xzCT4c+RnpFu5f5p0=;
 b=lhszkXi87MWh93IsQwuVGaSnf41bQnQKEOwsf8CNTcn7Fk+DI5wWE9xhoRDIa9laX5vWAuRyjCdCtqmac0CatyHIduovqYRBTMTLv3/A0vZK3BhGqj/Ww2/Pu4TlEoT/ZNjqLaq6iG0ZHdVvQInL5o46u4/7VVAAh8KBznb1pbzIBZZ70RMArWZvcgI1YqUNf8l5TvqwmWPGz64JTT3/k2IDIEmnxT+g5ezQy3NqKpS0GfKHrgZfENcM0nR0PvHnm6uPuwfec3HJpL9lQL711YxQ9rrp2X2x16IOxNZ31ImubpXxr1VjWiTxOD3+VTHsOUzzHEY0iJn0nuqCbJRDbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB7175.namprd11.prod.outlook.com (2603:10b6:208:419::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 12:21:58 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 12:21:58 +0000
Date: Wed, 20 May 2026 13:21:53 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH 3/6] net/idpf: fix mbuf initializer source in split queue
 AVX2 Rx
Message-ID: <ag2nYZb0d9CCY5C0@bricha3-mobl1.ger.corp.intel.com>
References: <20260511090935.2288837-1-shaiq.wani@intel.com>
 <20260511090935.2288837-4-shaiq.wani@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511090935.2288837-4-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZPR01CA0219.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: 6535054a-22a5-4d7d-b1c1-08deb66a630e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: dqbZ0z5odiVHsEz/j6CvtEoV2BwbF7YLmlyvidaZmOqF1fUxzWcsQm/sWjYXlwldIuJLnlGwpa97/MGBoP5vFcWNnupUWVkvsijmxcLKzDAVD+2O2nYoeRzoJOEL9+2Z5RYnfWYuYW3g5gnkmZP/Gs2oBwL1c2ezPYOO4Kj0q6zEuyKyeRyENhlAPBGYxCUbPd2WELh+n3XFQ1Z3HyYPC/t7bfEB+Uvx4ucK0pzTO9jwx3cvlhkr5MkQqwR0eUPRVEBc1C1LnCcOVI3NtOLUkPWMuemBN/zU3ZU9c6bh2Pa413RX0XXOU8lhGjgb3ibXpRwQiwJIYotIWFefjqV4er0ge2qk6otg9V4jZUgIyJd9OSYinpUfdbtOGhgvMF+8a5nzBtVh/9iOZZD2SCHvRlDWc5Zm0WahzNZ6wBOJeslbEAe8oT4BD+eetwMfwJr+jZqbsBYTynQNFC5T2KJTgqYUD1r4dTdnlEbjON9rjhjV6vJ9YAHrRJv8AQ6SD9D8MgF8uhhUQkqAR91kQr/vi26Ocau5RrXaEdVcL2NIAErjjp9FxDEjjcvHvvmS+bmmIRvojvUiVoyWte4kSFmYIRffAmaJTxQF/RZDRMHRAgV7dYKFFJ7OJs4RaLoABx9qEJaWZOm6TmbRyTQ4slmPMXqlNDjuJKRWDf/vXymxnWt2Qiajh6lbKd6vEH/eBqKF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1ZQMXB5ditic1p4R2NjcUdWL0wraGVjSDlWbG9xSEkzQURPaEZwUitvUCth?=
 =?utf-8?B?RzBoeU8yN29IOFQ0QVNHcFg4MkxxOFZhcG9samY4MTdpeXVqZjRKK0ZwbFZ1?=
 =?utf-8?B?aE1ua2p4U1pMZnlhaTZPbmhxVml6a2Q1LzIyWGJJT0RTZFVlNUhJWFlsY0lQ?=
 =?utf-8?B?bnpwTFdGSzhHL3hFZnJ0eUh2bzh1dGJueGV0SjdCbUFPZzVQaWo1VVBQK1kr?=
 =?utf-8?B?UUJIVGxRQmkyNXBQZnFkY0gwc3p0aG9acG5SdmxXMjI3WW1zeWRMcGxJOFdv?=
 =?utf-8?B?TnBxblRidUtqTElkYW1KQTNNMVNHVkU4NVNadndXNDAwcFp3WjRJbW5UWCtR?=
 =?utf-8?B?czFMRkN1cGcxUWordWtqWlo0K2FGTUFRTGRDUEhzVkhoOTBkSUlUL0RLVjhm?=
 =?utf-8?B?S1BYWStsVHluaHRqWkpqN3dIWWpLVlluQzNXZU4xRVpFQ2l4RmllT3JONWpM?=
 =?utf-8?B?SmRNTk1RaEpmVDAwUHcrcFk1d20yUDkwZnp0dHk5ZGNzSm8zWWVYbVo5N0ha?=
 =?utf-8?B?enptYXU5TW1MYllTend6U3hEYytHQzhkUlpWckhvYmtrOVNnQnd0WWZJRmM4?=
 =?utf-8?B?aUloSEx6dzRET2cvNDd2d0dIY29oWUlobmNodVpNT09QNTk5U0lnc0RkUHk1?=
 =?utf-8?B?MmtLQkNBZFlDVUE5ZEhFS2RuTGFzbU1waXBWTTNHWE1TOEJuemtTMEdORUpn?=
 =?utf-8?B?YWZaMWJMbDNCS1NsT0l1UTkvNjlOczhJbTdpNExiempSRUloclM0MHJjZVVW?=
 =?utf-8?B?OXdmYTRqYU9LdllRNWdYQUZPT2Y0aWtSWGVPdW9tb3pwd3NnbXlGdmxtaXBk?=
 =?utf-8?B?UVE3MWpXOUo5clpLbk9ISHMxS0oyUUZYSnBQSGJYcHVkMFBQYlljKzNGM1ZV?=
 =?utf-8?B?QU1WZkdVbWhPeVhwSVpLeWRSYmEzYjVYSTFyQTZRRmt0TGw2NUxIR0w5S245?=
 =?utf-8?B?RE5MekpHS3JkQytiNFQvSEl2STdVY2hYYkJWS3Mxay9VRGR5Mld4dk5KREtx?=
 =?utf-8?B?TjhyK3FvUlMzOWtPc0I4cHV2dlk0dHVKcWVMcS9EZG1VeldMN2xxZGlsdTJO?=
 =?utf-8?B?d1FQN1JDNkRIbDAzdk0wU0lzeHVqZE9nUGRJcTFLdmtTKysxU21TdzFLSW9m?=
 =?utf-8?B?RGkralh4VEFEb0tYMlJTbjkzL09mSk1yVHJZQlJzWjJUM3NPV0JnVXpFdkUv?=
 =?utf-8?B?L3dOSGpIRnN4R2Y2QUVObHBDT2hlWEEzNkpxNEh4NXFlVWlrK2dEdHo3ajA0?=
 =?utf-8?B?MzdpVk5ublV4MW9kQ1A3K0VVenE2YmRQdTRKa2JsaEFpOXVEYmFqVGY1ZENF?=
 =?utf-8?B?T0NRdE0rcWdGNE9qeWFieDUxSllBSy9yYXg3SUlkU3JoMkkzamhDM3hKcisx?=
 =?utf-8?B?dk5FT1IwRVhncm51cTNQRXdlOFZQZlJHSEplTUNlL2F6Q1hNUlgrYnJHTThD?=
 =?utf-8?B?dVhxZkEzZ1BvMGZLcWNzdng3WFozWXYySG5ZeG85L3NjTFRnOXdQNmNQTzNv?=
 =?utf-8?B?My9VRzlNdnJQcmNlZVZqcWNXSktsYWlMcEZ6T1Bha091NFBkTDdpR3Mvc2dJ?=
 =?utf-8?B?OVdrSk1QaHN4akozMUJ2QjZyNWVBMDRKclo1cmlvSWRGQzM5cFBmSVdjWXBz?=
 =?utf-8?B?OUg5QUhiNDBWVUhWcVp5UGhaU3U2dXNHclJTbWdJZEFOZ0NJcVZPajloS0Q1?=
 =?utf-8?B?V2ZNOUJVUXduckhOckhiRnNuVW9OdUlFK3R6MDlJWVJ0bnFSMHBwQ3NoSEZP?=
 =?utf-8?B?ZGlMdjNsdGZQLzFadGJOYjBoMzJFV0o2RG1jVlRwQ29qUWgwTk5EMXViT3Jz?=
 =?utf-8?B?SEw2L1hRcHFFRVQ3ZnFLdS9lUEQvUUFqQUFMT2tzYXVMQzdnZWY0U2pUcHhs?=
 =?utf-8?B?QTIrM0Q1MS9UQlc3eXA2dVYyU2tld2xSekdabkRlNVA0MGQ3aE1xWm5oaWJC?=
 =?utf-8?B?NjZxWWpjNGlwakpjb285MTFmOFEvVUZrc1dHMU1LeHJsUGlmNDluRUI1NEs4?=
 =?utf-8?B?OWZ4dWZDdmJZa3hTUXBEdGYwVWpmMU9hcnBEaU15MlNiMEw4b0NDTllucEVH?=
 =?utf-8?B?WFpWNk1zVWNuYWYyYTRLbUczb3VTaDZEbFZLWGlLMEFkOGdlM2J4ZWdBTFBB?=
 =?utf-8?B?dDdCejNPWTFOTHdEOWFRNUxyZFVTRVBQRlh2SHhpckJvUEloMjhPd1Mvc3o4?=
 =?utf-8?B?SS9TS21vMXRQM3hBSlROVzE5Wlk4SkhpZmNKZDJsMk4rK2lpZVdGWjdzWjVB?=
 =?utf-8?B?SU9UUjQ5TUluNTF5TDd4eGpxV1hyUXY2ZWlWWjJQR2pCaTF1cGk2RzM1S0xC?=
 =?utf-8?B?blBTZlpFbjFxZlZ3VnNhNTl1dFVjYTQvRVZmK1ZKeGtyNEhTRjRBaXVUUEVL?=
 =?utf-8?Q?sZOZtKflucF6Ruaw=3D?=
X-Exchange-RoutingPolicyChecked: ESn94pzABNC1E0DibijD5wVHgfVniWJ70gqq2KTpA8ZelGeRTMgarcId1hU6xw14Pap6gzJ8KepJQuDV41FiOrgj7xUzFJ62G3YS9bAcfjhVYMXG7goS298E9xkOWx8sj4mntF0inz9zBHnfPmVWxW20lJITPNiXBVYfgueSUM+/iQnR2eNYCfoYW1vH1gA+1Y59VGpFJ4kJbaOVDzF7fyMk64rY4YxZH0S8qY/l2NLPGFJbhto5mYPKkJud7iRIEJz+xvJVzFuvaBh7r/iJO544zJEvof19SUJcm8k2pkBtdiHKLZLHU4sj98hJh5FAtx8/lmeVhwa0235Qbl54pw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6535054a-22a5-4d7d-b1c1-08deb66a630e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 12:21:57.9941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apuLqjOnc84GXO0q1vEwJjno/FWeYlmw+WescdhAV2I456si1PMiVXqOc7gGws7tcVqoZA3DGaUvD6Vc7WnGyuX6BbSHdRZZsZSq5VG7wqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7175
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

On Mon, May 11, 2026 at 02:39:32PM +0530, Shaiq Wani wrote:
> In split queue mode the completion queue (rxq) does not own the mbuf
> pool — the buffer queue (bufq2) does.  The mbuf initializer encodes
> the mempool pointer, refcount and other per-pool mbuf metadata that
> is stamped into every received mbuf during rearm.
> 
> Using queue->mbuf initializer reads an uninitialised or zero value
> from the completion queue, corrupting every mbuf rearm.  Use
> queue->bufq2->mbuf initializer to get the correct value from the
> buffer queue that actually owns the mbufs.
> 
> Fixes: 1f065f9d75ff ("net/idpf: add AVX2 Rx path for split queue config")
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/idpf/idpf_common_rxtx_avx2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> index 28d4246134..d3a8e17778 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> @@ -491,7 +491,7 @@ idpf_dp_splitq_recv_pkts_avx2(void *rxq, struct rte_mbuf **rx_pkts, uint16_t nb_
>  	struct rte_mbuf **sw_ring = &queue->bufq2->sw_ring[queue->rx_tail];
>  	volatile union virtchnl2_rx_desc *rxdp =
>  		(volatile union virtchnl2_rx_desc *)queue->rx_ring + queue->rx_tail;
> -	const __m256i mbuf_init = _mm256_set_epi64x(0, 0, 0, queue->mbuf_initializer);
> +	const __m256i mbuf_init = _mm256_set_epi64x(0, 0, 0, queue->bufq2->mbuf_initializer);
>  	uint64_t head_gen;
>  	uint16_t received = 0;
>  	int i;
> -- 
> 2.34.1
> 
