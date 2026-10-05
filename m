Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18104CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 15:20:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A58A40A7D;
	Mon,  5 Oct 2026 17:20:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7AD3940695;
 Mon,  5 Oct 2026 17:20:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791213630; x=1822749630;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=lNUJ1fjs8ioygT961+ozIPV1k19U937GZtLLxRbhwE8=;
 b=D0cFVkLd/0DJYUrY32IhGUaDhP+c3iZ0bjav1k1x7LnP8+ZjAmtJn4A7
 9FTK/4um/VqfGTxiph1AypfbbUHqYgX/+g4RpCmH11QDw305Z9rBq4Jtd
 I1N/KdOC6Cs7oAWcVIiuwLKsSr1SmjigkwkJnKTn3/S3icirSN/CaFmaA
 O5qkXlzuTEMu2nCIaoprmJWkskKag/oFUpSxGX+3a/RshDeagClVC6btA
 ntPD4Yi6rDqRA5Q1k9UQZg2oJ98R2ukrSqDApiMijGZj1b8av6hD4Gflv
 pPP3HdNVdDvLz5IthcLEZsOLHbh1TDeVCqZeN6Qw14TL/+CibI64yQY5z Q==;
X-CSE-ConnectionGUID: ZFwAVW/9Qm+9oxpihvIqNg==
X-CSE-MsgGUID: 70eWeQMhRHWn7go/nrhddg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="103255388"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="103255388"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 08:20:29 -0700
X-CSE-ConnectionGUID: J0XB5XDvTL+SDbgk3muuWA==
X-CSE-MsgGUID: dbV4+nW5ToWA4EHhLIha+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="304795575"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 08:20:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 08:20:28 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 08:20:28 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.62)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 08:20:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCvxlz5UDsi54GV516ARM1UkyqGCUIghdSuXL+vxczeqVLeG3q3A0IrZaDL/WBdkBDHegRk1dr5SeFTjDRM++Ly5oBtzhusZf7a/Bin7OaBsitiKcmmmjR4MesVfCpsvs5axxtWAeXrGB6v+XvBuTKS/mCW6pRcyg2xzNNo1LMcdy43Ewr3AY8hO0WsQwW66KIQcCVYox77OfmJqMl8aSynlCBWboflXN9idYjZshW6lMTDTfMs3rODbwjOzMcmRkiR8q+wNe7LrlT8p+V6XWpzCAT4wqZmjUjmiupoAGZWvRMR1RHLVNjcZoFwDTOHr2d585DagBaCgGB0yXiyMWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjTaS7L37D2of2OQWJ3AS2zODHQtngzsKQZxsY0FuCY=;
 b=PoW5Q47yyTsmvKTYWmH6keEI5hG9jM6GFJsyYe2bAs5u6lZXYGW/h1ogtehjOgYdM7xpUfERwkfZoKaHmXc+ADsPhGskO8u+KZ9eRgwAqUwU4gXbOLquRqZ0aBTXFM2iaiZiRYBc4mLtugyuT9D1q+Kyzu4TKIs6eYCqq9GFM1AXQmWQRrDqqvovR/9YGmp8Zzmj9OuQTGMMw+ZYme55CNxgvNbkHJMbbVfQRHg+XFd/VPJjRSEYjc/4rlnQjmJ5yjecAChgi3yz+7Du/9d0GpMEu1dTXWGRlOYOm/opmj6BwxkRUd5xqaiNckTSg0GbWYxEXVuEgo8hOaSaEVEIKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by LV4PPF9BE730F55.namprd11.prod.outlook.com
 (2603:10b6:40f:fc02::22a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 15:20:19 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Mon, 5 Oct 2026
 15:20:19 +0000
Date: Mon, 5 Oct 2026 16:20:14 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: remove unreachable DCF scheduler branch
Message-ID: <asPALjjwfL70P0gj@bricha3-mobl1.ger.corp.intel.com>
References: <20260914100350.53842-1-naa@amicon.ru>
 <aqfX8267lXdvGhXd@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aqfX8267lXdvGhXd@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU7P189CA0001.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::27) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|LV4PPF9BE730F55:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d18f016-6a31-435c-6ee8-08df22f42a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dvXJ66RnZVdoKLK9KyFORWaCNwzRJ23RWpvjqculYLHWSXk6wRr4uNlbT3ckd2IkJIlsYbXM3eH7DykNDGwGnFXeW+8gFlig20IpeSnYG3KA1e0VO7uglyxu0Wd3Zqivhmzs0jRPg1ULLdc+nWGr0BldmmNlvt9w2NIGeIRe0mg/lXtQfzMmzqaEHh0eFaCoXCK//cpx8+3qy+L3f7UZvNNwrGk2MwCPaDNPjtt45KOEdFfc7CEE/7rb0G0FpGViriAbtgXTspBRR6DHCBp2Z9tvy7S1DoUWZT07ChrVUgsDJ2E89wLPpvv9ONFbYyz//sHvyFUACCTbo7/f2S0e1a1+gd8JwJMAThH8iUHKr/NO9bnklzZJxl2t16Rn8B3+LmLOHPhLhdy1zin6RpW0/Gy/QQ707DtvRaKXfJHn1k7W7M0A10mZJf4izbBgl2Eup195M82wBcuzMTDrMXN2XC16gBLSE+6537TFVYo5ZgMmRA8LS96dKv/e7IUNAUiWUsBwDCPppR/mH7+AHDKuMPj3kz+Q+UZ4AVLW+YuyalSZVJxpGfIWBn+P5hg5pqmT+fXqHeF7bK3K8j6xtCoL4pC7NXHVmu4dD7YLwjPZs6nLbS4kObQDtqvSggsWMtqIOqcUbal57FAIMNKmtb/K48l4fdH9HXo56mYmKdWe7Gw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KVeAUxyukgVR3sV8AZPLtY0usLjU5Hb/5+cxgD26hsrE6IyasqcbDSGvCbX1?=
 =?us-ascii?Q?VXHNtpo1p9ZrBpsgQGIp6CfuoAIil21n5W0+DRbT+Fcyq5yrLvdz3Nc0PNVn?=
 =?us-ascii?Q?TL/9iyS6wPc+TQ7d0xNZQuoPU7pBjIM74VrIMBKbbfHQGqGEkR9+bIrM+elY?=
 =?us-ascii?Q?fvpaDhXynCvQ3hkmRxWEPs37VOH3MvbLBoMoCfMjHst/g1Wxn3ZB/ndsmmwN?=
 =?us-ascii?Q?RbQhQTUhY6cTVlOm564GFIC43iSzeq6NuOetIv5TMlaR/gbOwHr3ox6Ge8t5?=
 =?us-ascii?Q?goj9lezzq41YDBHOzxDe22QP9hJmEheTBDCfpfDDiW4ByVAykWDA3slNOLQz?=
 =?us-ascii?Q?jijhxqNR4XxzaEQ5t1vBIGQlXCYf0Mog4fTIA/om3iPI+rSaDJnLDk4ynUl0?=
 =?us-ascii?Q?64/4Y56F+l33/kGIiNnV5OUzM8VD8BU4ttllDG1/MzRRK5KdbYmOqtRa7Zks?=
 =?us-ascii?Q?EKUN/CKb9yL5yeu5wg3EIAWOVpwcgxSPYZgOxFRJFvT4c+UUW5g9Lw8yJ46U?=
 =?us-ascii?Q?JV+pnN/epL65xsIWBlHRomPMe0fwX1GWQCaV5QJ1oqLMCXhajBlXEEZ6dij+?=
 =?us-ascii?Q?94alCe2ar6ktgsREZRNh8EkM8q8JCdyZO3wwPn8QL13Ot1O+/wpTVUH9svQX?=
 =?us-ascii?Q?Id6Ebupi7uCSPvnEh8MGtymyeHCzTzXXoeeJOMJfHwAg/R+9PvF/xW1TGoyN?=
 =?us-ascii?Q?1L8+2LW6b/OVbKtUFHLZUoz2PvXEtlqv5Ifq2qNvtAJDGheoppoqRo4UCEe7?=
 =?us-ascii?Q?WS6b0lm0rfOrH6lS9fDrStNh/O6m7K9j5ywypBL+sWsJqg3xiZdTXXySeDEB?=
 =?us-ascii?Q?NCTXxwMq52iwrfWGLlyTiM4w1WpXv+3DmtHF14Qig/MU5r/GMfvOPHK3Mp/p?=
 =?us-ascii?Q?dBvzHtjMRdgfIoAkIh4z6Tfm0042Kig5mbAiPKmuMTgHKMKkkTagjXsL/cyD?=
 =?us-ascii?Q?eXch3xzvjvtNE/Kky7/6ogSzsqCobAXAfN3bNKSeCDI2Uy8UQ4md/s7ulqgJ?=
 =?us-ascii?Q?SBKnHzZzAPKZ5jRAojeHEQ4GGUGauwWxxxRkSKNOKACSQLojPVqcK7vzr7f1?=
 =?us-ascii?Q?mLichjRB27KuLBv012i5qFwIdJxg5+VaBxlJBnIxODkrfaT0PAy2p55Dss32?=
 =?us-ascii?Q?OJzElLLBWKgTJSlUlzIsVUJDgCRWcke4imRxWD8ulSBKPxRs/XIj3Jwab4yn?=
 =?us-ascii?Q?n9ymBzc/MdcE1TCady4B7B0qIAw0FrymYSmpGDwEXd6vkhOEn+4M9etEGIOL?=
 =?us-ascii?Q?iKua/xEBEse5pqSeBKJDLQ36Y6AaiPBSENAuVbFiePuDY9vMiShMM06MwXP0?=
 =?us-ascii?Q?xvAL1Kd41D/eYnew8SG1HMTfFyKON5NcSNz9ZO+536FQW80SxdWFsiaTOTDd?=
 =?us-ascii?Q?DWJGUUqJImRhv9HHoeNERtlxKVBU0ntNmRZTpEnnVa07CyAWPYVj0zDWot3B?=
 =?us-ascii?Q?dL1ceNpn/etw+m9S7US3o01CO9DBJPftvxJUnpcRpZTufzpEMpFxeiQ2vkNb?=
 =?us-ascii?Q?a0hTqPBr/s9CpUc8s/CJpvVeM72d5O4cBVP8H4vD0Ob9XR8ocZ5xHs2tapzj?=
 =?us-ascii?Q?kBFTIkktPO8kAgX8Q/U1I8o0pHRg4c2FKRPxGpGnau8+MrPx4laoFuI+A8KG?=
 =?us-ascii?Q?Q7OCmQqSjHQy3wGGhoc+PvE/0d8GD0T44jQ2eWO3c5Q0X2b2ewRbHolQVcgC?=
 =?us-ascii?Q?L9qOBqLw3/fqd2dg5Xy1/Gldu/JKyk25W7gLRcuMJMVv3EVFmStvA3qEf4tP?=
 =?us-ascii?Q?tbSiujGEFzPtdomOH1VDE8TSjiaT7ZQ=3D?=
X-Exchange-RoutingPolicyChecked: u8LBRfHk6TwPoeO2iGiSLOGGmR2wEBTFOyAMX9E9ZY4vAtKxURkDeblKpMdjzK0yH+lZZgNrBWN5mYpFcB8WwvdkIX8RJabYRKLEE2GGrZNP8MH7aBE/6Ufg0SQJWSPLhLVWZNFp8AFp/EG3xy2IfAV43yt1ix4xileRhDgbtA6KYweKNE7r2lOl/GtqPTZNzRqLma724/QSoNcU5fsYgAV8BXL5nSq6r4LquOu6/MGWOL6Wopav2sfCutXHxz1DNYzHGYch012ar96o/GEX8+ICYBz8/16+721eZaOj9if0jbY6qDEGCWf0SR4PNKgIi27OjB0wG5NrxEezkd+NSg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d18f016-6a31-435c-6ee8-08df22f42a74
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:20:19.1127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0B1e90yg+2iVrgk+zv9YjQoIPJTkr3oLkRRiYgvTZ3xy42S/Q/T5Bhm6bbW1uM3URE5MlQ3BokU9uQEOpthhNbVkC/8xreYnbysH2ZYUCzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PPF9BE730F55
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

On Mon, Sep 14, 2026 at 12:18:11PM +0100, Bruce Richardson wrote:
> On Mon, Sep 14, 2026 at 01:03:50PM +0300, Artem Novikov wrote:
> > Non-leaf node validation rejects any non-NULL WFQ weight mode before
> > checking the SP priority count. Therefore the later else-if branch
> > cannot be reached, because wfq_weight_mode is guaranteed to be NULL at
> > that point.
> > 
> > Remove the dead branch to avoid keeping an impossible validation path in
> > the DCF scheduler parameter checks.
> > 
> > Fixes: 3a6bfc37eaf4 ("net/ice: support QoS config VF bandwidth in DCF")
> > Cc: stable@dpdk.org
> > Cc: ting.xu@intel.com
> > 
> > Signed-off-by: Artem Novikov <naa@amicon.ru>
> > ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
