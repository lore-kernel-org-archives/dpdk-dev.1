Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEF3CD5BAF
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 16:42:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F4014065B;
	Thu, 21 May 2026 18:42:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id F31ED400D5
 for <dev@dpdk.org>; Thu, 21 May 2026 18:42:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779381754; x=1810917754;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=yh8IoJFxo32zLHgg9PdpSM7SjU9cgqLBJi05i1Obo0w=;
 b=fkIIVJHE/WuwzZ4/Bq7wQfEXn4Hb90e7nahyk4vAy1rRWaVQ1b3MgI2r
 f5oAcgayd3oKKVlggKDSE/33pzYkD5lnA4KazYRXJw8dH3ou1YubAF2v3
 ZOtBXQOxPo1CHykHnLU4iIN3EITAcVmvndJ+wdAtq2bC8Dxvtd5RiwLO6
 HKEpkkdf/QLcSaDJCMVrMFfo+l2LbkePMrpq7/0gRK7VTcdDKaUnif8Kp
 rJgErNRLFDfJflzuNMjw6jlfjcEWqeKZKWuzMWxxEPWLw7kvmPx5r0e6n
 AjSCKNBQYcOArDWWSNTXqRBm2ilgt5rgsboDmnpdrL9tETiscCFxsGsYo A==;
X-CSE-ConnectionGUID: aZ0pZUoeTo+7MLNS5gOiIA==
X-CSE-MsgGUID: h2iESOiRQ6O/7madg9OfgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="79335772"
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; d="scan'208";a="79335772"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 09:42:33 -0700
X-CSE-ConnectionGUID: 0VoOSmv3Rd6Rm9VpT5Z28w==
X-CSE-MsgGUID: wJxCC2XrTJOchWraBSduQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; d="scan'208";a="264110173"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 09:42:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 09:42:32 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 09:42:32 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.13) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 09:42:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ry7XbSCf5mfqd+9KaDSSq6fer5cTIuP9enU7WXC6zPM1OcHsIVJE5PjwE/JRDS/GnEff+Ff1teXpJhX0QOPR1ylcQ8Q3cUJD8GH8uvNIYDcLC/vMaMBy+Iorb41dAiuhur0o9Luu7+FdJXebPoDprqsAWIdi3yRxaE+Uq4CSH8rHcSlCxY10wrhdCchBGFLKoOnnyQfvmCoIzZu6T5UrBXIcmoomIUnOSkU+pMwuaO0XEc1DhgN0sFJ5EL1zG8RE/ilOWXl1pBm7zHml5/0j8SzRHWn+rJPJVrOSEfZ455XYqPqrQ156lGE2iEVBXEIxA8tnHRx7QIMRPPSk+1OfGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRVgSdtvWYgJYVFxoBotSiY075hkdemyqmBsrZlOwZQ=;
 b=Nh9kiDzCx3/7CaQudOH/B4Hca3CCNkQaYmVHMjGYGvcSktqpJsf4J1UiHpYeUJ90UDTXDX80o8glwUQDGWusvBZs3/qcJ8l7QooyxmSh/3YRMKHUFQRKWNBJflg3J3Hwgr+Pdk9PzOHSVmPXv2a4/VB8H2ANHuY2VlmMWiO1LO3XUPPA6F+s7KVQyKRkvjfFwzManq61daYG5Jh+HCh/MVeE7FDTGELslPIXQ1DJ1XukUJT5437rx8d9ZEzHl9HofZ5OniFbhzpDCVDG3V8TwZukjxRnslZDu7lyvPKMBCv7hIgLQm8bCQMVBK1S2AMjmF5nSuPyw9SjfVqGDgZCng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW6PR11MB8411.namprd11.prod.outlook.com (2603:10b6:303:23c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 16:42:27 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 16:42:27 +0000
Date: Thu, 21 May 2026 17:42:22 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, Vitaly Lifshits <vitaly.lifshits@intel.com>
Subject: Re: [PATCH 05/10] net/e1000/base: clear DPG enable bit post MAC reset
Message-ID: <ag817ltWog3fy6Vh@bricha3-mobl1.ger.corp.intel.com>
References: <20260520125256.354336-1-ciara.loftus@intel.com>
 <20260520125256.354336-6-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520125256.354336-6-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0269.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW6PR11MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: 007503d1-779c-445b-37c4-08deb757f10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: K8N7b+bPcPQ1JELlpJiZBaq6fyDfsmyRS9p9ZUHPeCMKSmiV7/Vm6snmLkc0QTQYuVe/mJk8IDQcp0N8TcIOTWN9IlLBYAFbrN0pUfXKPZdPaPzOt337uh1rhxJDNH+WVBzitVD+OJwgWeDwkh+eiONE/Dbe6TjfgBX3HrV3Gw8uYSKFU12FJDF3115FRPiIuC34SSKSKn/o7FGOH1QGVE9MnniOLCuDzFxkC7lPC8gF+YrXqMxxaq/Gzy1ueLvh5UyDsAFtSszPMscoCu92MZwFGgaMOTKiqC3KOIjyzw7uPiy7KELQN+07+p7gfr2hVGQ8XOLGspjr6E77dmLGQ4Y6vH8vzzYByAz8+vtGBaO/gv/7opbRNBWxt4urd/1RSFed59Bx68+eQ+rx03qx5uzMYvfXbM4DDHcopI9qP8jyNT6ueSUcOTzJg1zaOwa3ndFWOeUxxsuxDbGRPbnpmFAz6c+RvtVGnxIfIZ1kDmloyJaNIWAaXNcdM/QFjZD+R39Jmoqnm+O9GYPWZ5/DZWVUW8eJAEq91Z/ilwa8HmSFHAk9KFWzt79lXyl3QX6C1WEL/DPkrHe1aGlNzHYKQNSbK1iIJPo7GND/qBDFCfOPg/Wu98CJqU1lLvDcs4f2BIPt6WblOW0noyoLPS6TbBc82e/wMIFPNZ/0LnVaCM8EcF90o2NqcNStl+FLbEeT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?12l4ykLLVlcsYfejVWIqxsDV40ADCSUFP2rtDZy5wgwwOHmR2gBpTT1g/Tq8?=
 =?us-ascii?Q?PM/k8XDa8xwilB1A62wCTWhLon78+ixuRQZa4m9fyzQ7CSbsZU8WCVMZPBkl?=
 =?us-ascii?Q?vy4md7wNTgM6ORGVIZwUQo4WLfrLWr8PTgC+AEeArnu8ppsf+N95e1T/x004?=
 =?us-ascii?Q?Qi9Ds955lg4bY+Hvg1R9WzIo+K1BoPaEQ69zLMA1EGKNiq7ssBgIVwuRQc9z?=
 =?us-ascii?Q?TkRDdMl46dRscl/vnh/2vucHb9LCMPkXPeUcP+Hl/5KhCYAK4gq3pWh+zAeh?=
 =?us-ascii?Q?IL9Ph3Re09rf8n64UnrqwrNCVYUkicSmNUR8EwbdVHkGnCU6pzpzDugISahb?=
 =?us-ascii?Q?ncn8e9hseJQxqZ7N7CKuDBgFFHTfNn5keCz4PG6HQZhWwOUMHEl4OZnb29TS?=
 =?us-ascii?Q?SQOrXMQT3oP92PY6MZ/S+W2NHjJSeZVagBqP5i6FgXARndKifoZENJtd/xEu?=
 =?us-ascii?Q?NQXWeiECt0+nKaGqhcG5RVXP0qfA/159/36w8+XHqMYXYxjMnvO1xC5UpMAS?=
 =?us-ascii?Q?wrF3qXiplmH5bhhej5LtrxPoHarELwVaNCWpW/B7CNtTruybg0MBpoWIK9fG?=
 =?us-ascii?Q?dX9iIFMOLVVPZfzZIM2mAew9YfSCvIcR9UkgiGgH7XR0lV/ciOWTwk19Sst2?=
 =?us-ascii?Q?v6/Zu62DBbvOzDSLUDJyPMC/2rWUD47V4TC25ZIxRUhaW+cp8hZRFveDyKAN?=
 =?us-ascii?Q?W6fZ6m6C+TtVH+d+OKiQukGu+9ORgRb32GwI/TPhzNXfTyGzoe8m8Tes2X8h?=
 =?us-ascii?Q?vS06L9svbEywMnr427b4UubbhDOJeRL3PAeZjJbNFAgq7JHZYyqU02wX3tkb?=
 =?us-ascii?Q?Pfyg+cK7pvbsS7V2qgxit4PLGCnT7uM4tWub1bxYSyLG3XOIEAS/ZXVF6KQa?=
 =?us-ascii?Q?PJoJtMeP/JghXsaJ6DH9Y8yA48UAJP1VE4zjfyu7btr5U+fUgi0Zbs70H24G?=
 =?us-ascii?Q?cklnO6OsTEAcr1M+194yl+AfXCESF0FdvhyJGh+H2NSq22V2rsR5J/F19B2m?=
 =?us-ascii?Q?2h0vllm7fbT1vUZs8c7zLMvC8uA4de/Zj39c9TNDGfhd2CNZ1RAQcZe4RI5t?=
 =?us-ascii?Q?cCCexUJ60g0e7zm7UQ3AYk9W6hj/dGECyBYEIBhhiLTTbeY8vJBf27WoRyCm?=
 =?us-ascii?Q?WD98Jr7rwx8pVFDONTUiV7SlwfBRdZh4l91bJ3yk14Zs4XLOwRQqAAtaRoz9?=
 =?us-ascii?Q?xlx2DppD3+H1pC/FfqhC2Ssbsz2idIBRvms/qCsLjZ+1LaubPXhKD6Hd9fmC?=
 =?us-ascii?Q?lM4nxC7mtwk9Kl9N/qSAfEcUbPQ5d9BihQThAj6IMv3oVANznbBID/x04FAq?=
 =?us-ascii?Q?U1HJYH+7vBuMqtzJINMYBdztXg592UFX5yP2L2M1lmHb8Jzn8GYf/GeUll3/?=
 =?us-ascii?Q?o07elV39f0ntEt0mu7/7gApyXoNOVVuqEtGAY9yfMTAZOcjLsrSfafssZXXo?=
 =?us-ascii?Q?PNd6DgSXesD4LguouUpxhIQQ8xugfPvTurHm5RovUH6uA7C8He4ZkLfVhKGs?=
 =?us-ascii?Q?SvGKe3YzEnIWMyIPuKU0qKZm3DKpUtCy+gbOppv9MgnIU794xUMYu7OaPKF8?=
 =?us-ascii?Q?dlU/L1TQ2m7zubZDpJAGPFFNdYwrETPh7+B6OIH4wvvlRSX7VqqbgPvhC1U5?=
 =?us-ascii?Q?C+m+cCRJaMdRpeUQTr1m8crbTBsJ0tioj2MZ0OyzCWmpxuCwprdtxuQiY7xc?=
 =?us-ascii?Q?MYjnxIRxNHkyc2GmUVkZe1Ah8lFQj9NjCnyhmdZol3LOWhUdr6Zy2t8PSGFq?=
 =?us-ascii?Q?K5x3ipEfHgjkprr25uqz2d/dV5h25S8=3D?=
X-Exchange-RoutingPolicyChecked: Hup3Z2QNvtB1xHTs1s8rCrOKN4DgEa+IY7ZmKMAdgkSrumdXYQoqiV3gVZi77y0ksw4Y4M90JCtDpiSRqq+pdHLusI6rtin04PA/m7/Ah0K+QuGmpIDUmyj8Ti43iFu39c9YifIC7F8vZk1oaZb9nzHhDvyfH9R9K1+uqT1uyoa6gZiNPOq0wrBOcIllrEoI7hHlQqq/saCrnVeo7QqwUWcUVrNHFydNBGQomd7006Ct1+VeufQVFXcMKx2uhpNXpwxHoBMvlxHfkI8iechMuwYt1yFiatvUN4ZZ2svEBT6wd9Jtj6vbRTqgudEcugVxvNmLMGeuMapVg1X+jDXY7w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 007503d1-779c-445b-37c4-08deb757f10a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 16:42:27.0327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQzph0cUWtBORhdA2s7cu6cs+5V+IN1qKpyE+OyR+U+EKBJ/FGVg36LVYjth2/4w++TR1cOckqNXoUE4h4/+dm835t6Zq5/28iZgJe76Mf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8411
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

On Wed, May 20, 2026 at 12:52:42PM +0000, Ciara Loftus wrote:
> From: Vitaly Lifshits <vitaly.lifshits@intel.com>
> 
> The GbE autonomous power gating feature was added to support G3 to S5
> flow. However, this changed the reset value of DPG_EN bit to 1, causing
> a possible autonomous transition to power gating state during D0. This
> might result in undefined errors such as: packet loss, packet corruption
> and Tx/Rx hangs. Therefore, clear DPG_EN bit after hardware reset flow.
> 
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---

Seems like a bug fix needing backport. Will add fixes tag and CC stable on
apply.

Fixes: 5a32a257f957 ("e1000: more NICs in base driver")

>  drivers/net/intel/e1000/base/e1000_defines.h | 1 +
>  drivers/net/intel/e1000/base/e1000_ich8lan.c | 7 +++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
> index eb93675823..6c710300a6 100644
> --- a/drivers/net/intel/e1000/base/e1000_defines.h
> +++ b/drivers/net/intel/e1000/base/e1000_defines.h
> @@ -36,6 +36,7 @@
>  
>  /* Extended Device Control */
>  #define E1000_CTRL_EXT_LPCD		0x00000004 /* LCD Power Cycle Done */
> +#define E1000_CTRL_EXT_DPG_EN		0x00000008 /* Dynamic Power Gating Enable */
>  #define E1000_CTRL_EXT_SDP4_DATA	0x00000010 /* SW Definable Pin 4 data */
>  #define E1000_CTRL_EXT_SDP6_DATA	0x00000040 /* SW Definable Pin 6 data */
>  #define E1000_CTRL_EXT_SDP3_DATA	0x00000080 /* SW Definable Pin 3 data */
> diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
> index 6190052368..96b9ad6a70 100644
> --- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
> +++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
> @@ -5107,6 +5107,13 @@ STATIC s32 e1000_reset_hw_ich8lan(struct e1000_hw *hw)
>  	reg |= E1000_KABGTXD_BGSQLBIAS;
>  	E1000_WRITE_REG(hw, E1000_KABGTXD, reg);
>  
> +	if (hw->mac.type >= e1000_pch_ptp) {
> +		DEBUGOUT("Clearing DPG EN bit post reset\n");
> +		reg = E1000_READ_REG(hw, E1000_CTRL_EXT);
> +		reg &= ~E1000_CTRL_EXT_DPG_EN;
> +		E1000_WRITE_REG(hw, E1000_CTRL_EXT, reg);
> +	}
> +
>  	return E1000_SUCCESS;
>  }
>  
> -- 
> 2.43.0
> 
