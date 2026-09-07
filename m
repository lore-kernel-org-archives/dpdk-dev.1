Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2400C79F9E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 12:35:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 587C340663;
	Mon,  7 Sep 2026 14:35:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 4D0CB4027F;
 Mon,  7 Sep 2026 14:35:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788784547; x=1820320547;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=NQt4Ztn2TEP3nPjesghNuHYI9a4FbibWcKAVElSf4EA=;
 b=KwosyBylXDC4+ORXswlZWVULIV6ScNI+5J03DKpbWKgL4jAOJA16G8o1
 mHTf/qfN3xTq3+7CCTVBT8hOoCTtVgl/AnqxBlFyvo6ZYqwGpitfivZyQ
 MiisKJ+3kzJaoxDLSgX2DuRLpOculL/vE7qYayQIBbLS1L8xJkd1cerVc
 BCpxx7OLwvGinOwDQGMuCVN7iYpbXE4nJoAf8y1GWs6jSg7OuTJSL6Du6
 phH+QgG3Qx5f3LgGEGXIesh0RWYiX1YEevrKevXbeGCf9ecBS9QDAZkHn
 xzjndkJ95F+x8jcext08LiJyL/dnl2qUACrKHZQqMfs3VGoDVKSx2NfkM Q==;
X-CSE-ConnectionGUID: 78RbH/dsQRaFAJCwlk5Qog==
X-CSE-MsgGUID: +tKETABhTEKfoQ0owJD8kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="93005728"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="93005728"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 05:35:46 -0700
X-CSE-ConnectionGUID: H+M1cetFQ3eHWxQQCO4e3Q==
X-CSE-MsgGUID: jI8ifpL+QLevTzQWB2A6UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="268968015"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 05:35:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 05:35:45 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 05:35:45 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 05:35:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOg+lLTqx8jLQ0LWHNoM01C7vRahqOIipHT1vtE3tUw3RkA/FI0mPHNTTiwqFUtDMRP609zt1Ok3NqO7T4I4XfTrcCgbAvaSrhQnnkMQgOwPA4Xc8/SY/7wUyTksm3WnBDV6ykPk/l6WmVeu2/LhgXt25XtkE7b0saWk9O4Hv6T/CAkqdFRoLUWN3ODznGg3WhItgoTfBGhGNXNZ6MCCYbAB4huXQFqiEWgHUFY44Kqm0uBv9FAL++0nf9GNemnx83XU5uIJeRNqXEXBw9WhOGXhRlvxHxX0x1RqyeZSkB3eZ8LXhqO6aW7aZ9iOIZTWeOMcJWuV34mmtQl/DDahJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuC3yjbFfUzedXnsN0P5oJXGHPZUxgiie5mt8YnSjVg=;
 b=LA1OKsGY1reOZtMbv3VNl8KOImdNI447z27mrMD3PIEqeqnWkSc1sdhvBuGmwxicAXOD87a2d0Hq+s1G+cfNorI5Yihvf4F4wna56OZkDXyFQSaXNJdLrs3DYQ5k4VK2+9knSNhaTB4elsF2Iwu/ViJwoTxDKiS6NkcXYkDno3rxm4CK8tY+MPpLMCBIS+VsmnI3Ydv9NaaoslA7+9mXAhKVQq2wso/uTc7yoMApwTiqGHfBhnIc7MFtOrCfGYS9aRKc1Yol4JSh43Gy8cz22lTE5DMC0rcmJTlpyYEXSVAsE1gVHZlhs6lNlmLRdMaDIyEjOWYX9rtpZQILrhyuMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DM3PPF74831EF4B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f2e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 12:35:42 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 12:35:42 +0000
Date: Mon, 7 Sep 2026 13:35:37 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <hkalra@marvell.com>, <stable@dpdk.org>, Anatoly Burakov
 <anatoly.burakov@intel.com>
Subject: Re: [RFC v3 2/5] eal/freebsd: fix a FD leak in the alarm subsystem
Message-ID: <ap6vmUnxBGv9w9vS@bricha3-mobl1.ger.corp.intel.com>
References: <20260907121348.3049808-1-david.marchand@redhat.com>
 <20260907121348.3049808-3-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260907121348.3049808-3-david.marchand@redhat.com>
X-ClientProxiedBy: DB8PR06CA0049.eurprd06.prod.outlook.com
 (2603:10a6:10:120::23) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DM3PPF74831EF4B:EE_
X-MS-Office365-Filtering-Correlation-Id: 87036c0a-8923-4fd8-5111-08df0cdc87df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: TY2Sxr0l/Ml5BVTS9v74V0BvQN/K/lBlogNVbg0LkKgNPlTnFMTROQ0n5koQzzRwToq6SftY4rFTo3u5Nwlxael/Epn9auOoPSUFeo9HQaramHhKLFJvn+tYTGiUgKqTxS6kyB6hdOLlfUKx1gOtfAR22QebsPE+5bx22mlh5HEXYL2OiJqotnHRxka9wEFTGQ9yYS4GXTPTNaVpuOveI854rtb+XcJlsKf+ojwB/FGixocp+cqW/Er9ykY/EF+tbDdc2naX5Cb3C86DqkZW/jQH7XRO3nhHbxjtLL0RWVoBz85OHhS9dyp3UNmSDVGWa/CX8wHsxlNXhRuY9x/M7Jv1Saw9U16upOkTFe98n9zEWlKVohs3dYNufpatSL4s4YPXPYRU8EX3fIIHlct+nwQNQhNhQ26l6C9yad7eQEOqYaqSyjSYxLpHetyw6JFVuWHs54gJ3N2bwpXHCE/qqImTBMD18Ii2VR4r8K5Xs8cP1AgyqzJOuiDhJo5obk8N6T1Zf/3kk3B0p03dDxF0npfW2AUs6vTHJplqUa3zdGFxFMRkRFdDZFy5uTyQ5C9IMqAUMKnGHTrVcnz2E+74n/y9cop9V9KR/DVX/D9lXpds86QqRt+NSr7oyuNvrDHPmmri5pVOTW943sw51VX80f/GgmSEzt6uACTRn9U2c+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9s9PUhQYtFOKSYlmaYwEgmZ+ntERJuB+AWH9heojTgnn7VSOTFWTN8l9dVZ3?=
 =?us-ascii?Q?cNOH6mizJATtLAVjBB1SDNWYTvHIuCwHNTxA+Ccb6YXlNn+4i92jnrd02KNE?=
 =?us-ascii?Q?UGdUVViYyJpa3eYUsOqQ+9lHowWS3LeN2Pm+PBsK1DE/8YrzWzA45oxNznRc?=
 =?us-ascii?Q?9mQDSh/I6Wu35pKdeYVcxbDJmcroGz7HaoQYkNozFiN3eZddq965WYL/tc2T?=
 =?us-ascii?Q?u1RevbUIct+5teIPbSYvkUPK/QTGu8IvSrzsxVz1BtZltq+VsjBb8e78R7nK?=
 =?us-ascii?Q?GOam8z6gfQo20939VZpLsgHNyPiNdz4hGjbCs4M+4cG3rmyxEjMpZaSNHhmn?=
 =?us-ascii?Q?nBuko0hmnWBpPnlkBIWiK0HNt4WqvMrP1KPekVYlgXe/NOA9AOkCZZQ9Vw37?=
 =?us-ascii?Q?cRuwIJzpubOTM0TeC91ETs5sHJwJwEe/l4bPksi/qU8SsumNhwbZWbKuN58f?=
 =?us-ascii?Q?hTfyVjdzTBt5eDnva8C0tXz5xOAaT3/mVkyvmSVOJesemu8WnGHrGRJZbOvU?=
 =?us-ascii?Q?gNAqhVU75mwvepAQG/y8q7+N+EVO6kDaGrvCcuRP3cmoT+7dSP1Q0+wpZ2ha?=
 =?us-ascii?Q?JatO5g4SR1yRmvEhAUtLlhMkEjETQ7smCQh5dV5zF/LTdZuYOsbv2M8xu03M?=
 =?us-ascii?Q?EwLkY/v2q9RSMBFt+ZDXiqlTlOdj2Zhfx6q9iAy1NYDi0z+ItzLAWF7gERmx?=
 =?us-ascii?Q?4GQyj18ZtrE+LRhfqSeXZFbNDOWg0CljZmKnzdeMbNg3STGbtVxfV3hhRQIM?=
 =?us-ascii?Q?fOIPFhrXP9kiJuC96G5EMypdRwpho013vjRGx9p9q0uzpubFABONKXOJVnV+?=
 =?us-ascii?Q?BqDr5a6loIsEH5oYnxE4NicIOWxpb/aS2lrNx21ZrIrJepu9xwqbfN4PldLh?=
 =?us-ascii?Q?drM0lkx3A2Fn/IZgmQzPgVp6SLtmq/Kdq0K9m5T10FLnc823h8bKoMt41s5Q?=
 =?us-ascii?Q?bMO3gsTKZ0Tqs0ug1k0LSR6/K9B0/dnYViRJSu65omoFjuD62aOcscCPeFnI?=
 =?us-ascii?Q?s/8LdsSotj9mo3ky85PJgw5jbeoWgX3XVwSQZDHcrCP7Dt8I6LYt41gZtw66?=
 =?us-ascii?Q?IYNOm+xFACUX7A1K9mAkSMYffnxYADEkLMCat5skom9tvC22JS4Muok3120W?=
 =?us-ascii?Q?KyYAuKQuWIZMivfmcPE4amXaoew2tl34Wu4wUbvzvs7j0qlEgmczlDwrsOp8?=
 =?us-ascii?Q?7qn0aILEHU4NCipYlDT7DacNDmKlSygTluuj67rxtVF9hMmjp7f2P2pdR9he?=
 =?us-ascii?Q?8SRhFYgVnOGYf1gk+cINKBuTVnWSt0WawErE3clv0/nxPKi8BfMsOar36A26?=
 =?us-ascii?Q?gUcAlWnUzeksC+0ZqOli/Z3YBwhluiMNo6Wja7P5pkhtxhR3GlLGygDfaFo8?=
 =?us-ascii?Q?DkGuXpuyyuD+ztaOn5Ev6V012VVWrh4aMwX3IQVELKrAb4BPF/SjTA9pC5Oq?=
 =?us-ascii?Q?S5ajXSVbXq/Z4cZOqINuZ7/o4ltSc2IXDoYDsBNgtdCP2WlTDVTXR33OZ/2O?=
 =?us-ascii?Q?c4PYy7zGaRQiTDq4M6ErqUi35B2JlmffivBU7tBWolWhAqld7lvEFaT9q3YD?=
 =?us-ascii?Q?j7ikLqKAIqM/VQoUVQx4pLr3YWfhdUtc0mwjYEBWc8JwDv4AN6IHWo2Lfkoi?=
 =?us-ascii?Q?aCmeYAsTm9aZ28g8lNTTV56BOoToxkwQ2vObt72QPet7ZmqO6ogCvGFejYkg?=
 =?us-ascii?Q?jhEZz3/vbgCPuokOynYtPzW/S+r4XC0jcK/FyZGGXNPYBQFTZ6vB8yKVIMBD?=
 =?us-ascii?Q?ncbH0TYzZWa4nePsDdpRWKTAiz69bYk=3D?=
X-Exchange-RoutingPolicyChecked: RmXPG3pWiCL5/8WBrUme4AYZA9LYtjeGfipAF56WfKERs0oaaPgVcFYhHDF4pjcGy0OLx+ZFX2Uwx0xAb+S4Cze/lnNitb0RvglBOkp6qVlvq8lzeONZer73Ir3DID9Zyrs/Mg2P3zio3XBeXXidnzt8p/cPGA8ks/WgZd626xdGjPhlvf/NpIbQNBgQQXNEXXzIgd3Kewu4H9J5TidUQcjY65pEISNBDm+Vdjrej9IPm8aiBrMX5DtBYfRyCqBrp+LHrhVjf4/8K68bEJl1McSuk+k4oOV8d4sMfvuVJHwOWtVEFD/R279E+FRNP5rqqDp9i4wtJ9w5a2lnFhh7nA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 87036c0a-8923-4fd8-5111-08df0cdc87df
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 12:35:42.4462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BV8WeomXKkb3gZAEqw/vZYCyF15kUkj7HlWE5wmzEjQkOby5m4EFd5tgMTR0a2nJDKhPI+N45zPVcnHQRCfH7mLbSaJwfuJbpxZRhRN27yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF74831EF4B
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

On Mon, Sep 07, 2026 at 02:13:45PM +0200, David Marchand wrote:
> Caught by code review, while looking at rte_intr_instance_free() users.
> 
> Even if the FD is not used, it must still be closed when uninitialising
> the alarm subsystem.
> 
> Fixes: 26021a715067 ("eal/bsd: support alarm API")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>  lib/eal/freebsd/eal_alarm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/eal/freebsd/eal_alarm.c b/lib/eal/freebsd/eal_alarm.c
> index c03e281e67..2905841b5e 100644
> --- a/lib/eal/freebsd/eal_alarm.c
> +++ b/lib/eal/freebsd/eal_alarm.c
> @@ -54,6 +54,8 @@ rte_eal_alarm_cleanup(void)
>  	int ret = rte_intr_callback_unregister_sync(intr_handle,
>  			eal_alarm_callback, (void *)-1);
>  	if (ret >= 0) {
> +		close(rte_intr_fd_get(intr_handle));
> +		rte_intr_fd_set(intr_handle, -1);
>  		rte_intr_instance_free(intr_handle);
>  		intr_handle = NULL;
>  	}
> @@ -62,7 +64,7 @@ rte_eal_alarm_cleanup(void)
>  int
>  rte_eal_alarm_init(void)
>  {
> -	int fd;
> +	int fd = -1;
>  
>  	intr_handle = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
>  	if (intr_handle == NULL) {
> @@ -88,6 +90,8 @@ rte_eal_alarm_init(void)
>  
>  	return 0;
>  error:
> +	if (fd >= 0)
> +		close(fd);
>  	rte_intr_instance_free(intr_handle);
>  	return -1;
>  }
> -- 
> 2.54.0
> 
