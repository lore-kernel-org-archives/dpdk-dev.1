Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503DFC61DFD
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 09:42:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F3F140E24;
	Wed,  2 Sep 2026 11:42:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id C387E402F0;
 Wed,  2 Sep 2026 11:42:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788342174; x=1819878174;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+nARm32XOcMtvRDliP55fngH14P2r1Ri10OFUnaXy7c=;
 b=m5dlfkxSCQWeV8pWZvDucp+MJhlc1D9Z51vZWI/JpS/x60xt6+3z+oo6
 JeYqcV2hramdl0Tdad781VOL4aA24BtLvcw1TAdKkBMBF9pFfKLL4msJi
 sEGmdq46YnPuyfTUX486jUCaqAxbJfHVileJNOu4aupDE1F5nWSiTywAt
 LI5u6s9Cm9UiBuKycNr8plEMU4+EmbPvmcvp52ZkGA/TLbKNSyBlceqAC
 4kyzhFsh0ydOxqzRnB6x97CxkQQf3+afOJ/QKmiJt5H60jRnyv/Zq8Ak4
 oufoZWRCwadUQX7BYZ2CXZCpnbO4bS1wz8whjJl6VieGes9F7nC6x6yPO g==;
X-CSE-ConnectionGUID: xt2JYRJOQbeyc8nuWnsL/A==
X-CSE-MsgGUID: 0LKqQQ7JRk2B+TpEgpkZ3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="111563667"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="111563667"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 02:42:53 -0700
X-CSE-ConnectionGUID: RYCAeX0rQimc7BJh0f5DUg==
X-CSE-MsgGUID: J0EOgQtYQZG0gwudqsKtgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="268820087"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 02:42:52 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 02:42:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 02:42:52 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.56) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 02:42:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0JgAtex13u0ZYsjxGMH1sE1vaYQqGyJ15eqLn/6YNP4XWoB9aaXwJzoAcRs8YY0QhG6YcOZV3Azkl2BNccEajylMvbI52fqNBqrBA1dhxSoyJQcjCo9cUEb6D+kOqAWHEEu9dOUGjcUSFZyOje3EIJcmXvJgh1muYyUbIU0+FOqatLvjidtRHS+HhaySunjfrQrh2T5/iUcaCEa1mp4EhWvTHsIeqtf/oZEf4W8Skrd3c1B4A8I8baGV5bqBi+R5K97DNLNKLpYCk6t/VmuiuM20HDoj/oWiS8d3dW6yq8TVJPOMC+3oslrDKFfST7JAAQ/GbsyJUec3YK/Gme+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYcRi7NlK7lE9vfJHE6CDN9maYoebfReB3WWEMQDWNI=;
 b=GEr9FsBAXuuJclh18RtfsrrHwGy9pF3YMJRu4iVFJGcE4CRTwYxJjDG9jlf824MoLJPZ6l6At9GIoCcMUtBp4gUDKMWX+1D7UvB9x0H3y+oGGXFhcUZzcyiexSryg0gT5TujAdx1BvssGd2zLkBa8T3U7kmemC9NY41HLqyXc45NK0VXXnyU67KROeigNkjU1lDCF4yZAcq1/4SEJ461KefYgwfNV+KvsOHaW500NgcP9VR2qeImUCHH+7jCXpTYvkMir3W94Trdw35FtbB39z+hejn2Q6eub/3c+Xi7x6jmMyEJwGOtJVB6Lh42CGEN+MeNuhyE7VKLP3ZL8Sjmbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by MN2PR11MB4632.namprd11.prod.outlook.com (2603:10b6:208:24f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:42:50 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 09:42:50 +0000
Date: Wed, 2 Sep 2026 10:42:46 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <jerinj@marvell.com>
CC: Rajesh Kumar <rajesh3.kumar@intel.com>, <dev@dpdk.org>,
 <thomas@monjalon.net>, <david.marchand@redhat.com>, <stable@dpdk.org>
Subject: Re: [dpdk-dev] [PATCH v1] examples/ptp_tap_relay_sw: fix build
 inclusion
Message-ID: <apfvlnSMoRdIgR71@bricha3-mobl1.ger.corp.intel.com>
References: <20260902082523.206083-1-jerinj@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260902082523.206083-1-jerinj@marvell.com>
X-ClientProxiedBy: DUZPR01CA0330.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::26) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|MN2PR11MB4632:EE_
X-MS-Office365-Filtering-Correlation-Id: e0afd775-dc67-4a0b-0907-08df08d68dac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wf07wjX4q7c0n1V1R9xAGvPBbgCkbb5vmtf92Tzf4ihBJ/3WdOPOf7/jT1cjOdIJivZ81TfMN+bjXuvlf/Gnx+yqDtxAMEeUrHYBoRBWdnxeID7u60PtGH9EZjhAWKecl7nVLM2DOJFKYa1EirBrUueTi4A2CBS7QJ5xjRS/WqL2VFveO2HVNR8bOq9OQ8i/+7nnx9h73X8AMWUxOO6CGkOPS4emUgf/QnUBssBRV4pL5ni3oyX0wPpLOYMpgtj1Cr05IYLt7e3rFDgeD32TIQL4kl7Rnaft49J9tVarEI6aoazptthL+Vv3jB+piz099VlGGsiqx8l7gmJBXX+8UZnQrHmgauKllzGOVk1UisSHDI/lh0SansR6Zo80jFQaNsTlTFgXqzZ/FSifF3iuPbR5sPFq//v03WGTjkUL53VIm4vJpDyotmYC5nmY9SUizg1gqPTaisfRK720VQ6qNiZLXZ5iGHdB1mDuJX97R9ioT9oqWSKjXlcseJjczaxzM/XVN5VSwp60f9IPlcJYclJJ1vP7Gig6Cp1SxdKCUYa5R/0NWcrsOwpcuHlmxfLsa2oCfmGxZJT0l2CpMhYsNRizESuUxGO8SDYCQEfkcKkY1bDJm+Oo8msVvrIGPXqO09yKWcqsJclfz7T88W9bReej+F87qyAzVX+GLG+CaEY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UpVq2Tsh4RF/7pY+DT//OhWEEttONEtiUuPmLfD8AkNmJHZFwqcZwa35kTJF?=
 =?us-ascii?Q?LE0gVcFWF0k/mOh5I4mAgx7AORgPJ/HJgbhKxR3EAsha29jeJvQO86oiRge9?=
 =?us-ascii?Q?ho0eVQ8te602rzN7O+cvwsYluu+WoFwgKASBlg1OS4Kw1p2JuX92Yic5Xywx?=
 =?us-ascii?Q?zS3EOcZi1ulmAOgfU7ngwWAnfUIR0KReUnhkDvnqM4mMKcxgA7SuIvfxmiai?=
 =?us-ascii?Q?yXLnpPAyPU50EsStkZz/vktLHBOy1GSu+7afNC4IX3ugKU9rooBGryBUQemu?=
 =?us-ascii?Q?uEzoF8El+x1sQJgW+hUgsun+B9QycvDhXYW/2hu900tDidBhGLSkcn4/eaJ9?=
 =?us-ascii?Q?QyZcXtV/kL3UG72StrCxBEZ5zvDWzCtQNgbTSe3lHHbUwEpsrkYT4fo+6j5A?=
 =?us-ascii?Q?G0ipvcH8XdMNYfBC2tQ5LAOengrgI1Q30HnphEp61VnubMG8ydeYSrOatkmr?=
 =?us-ascii?Q?aUMH4DTzTGv0hrCsqKUo0W3kDicI4MN2keapVG9JVeHTVmErmft8Ge8XgRW2?=
 =?us-ascii?Q?KCyUDkCKL5z5t7vEcocLOTyZxWMDcbZACyclj66KtzJmEnUY2wiQ1Eoybm0s?=
 =?us-ascii?Q?npVvLOX8q3csdpy5kTuGu+Npu9vejJCLrGEEY9h5g8e7sO4mxEw/VK4FLdeA?=
 =?us-ascii?Q?yQSWnc/AnA/r9tffrIP54DXPzbZJyiQkKzeN+w92/CQxVbjkRnjAX91gmcZ3?=
 =?us-ascii?Q?eny0TGIUkxPUGdwwVj9VGFzrewcQzlkj8Hxq65I9VxffjFQNnp0wk5g4oNRY?=
 =?us-ascii?Q?VoNzB44q8NgXU42C1dNPu+KTnyVOy1q+eKJ+1nQ+W/KaoNaz8iW5/Eemq4x7?=
 =?us-ascii?Q?/NPRZLthEeLL/Sju2Pf+jeHlQax/qFW1JwoMYQrl7MhJMay0X0P0ZRC+rDKR?=
 =?us-ascii?Q?2NSsP31GkWgVJJ7jFtKazrKBsKUjdgmwcwE6YUBbR5/M0UZPpWpXHRx9qc0q?=
 =?us-ascii?Q?eXq2+h8oWtITpMRBnwJ02bnMe3VRiO56wVWqelBf8sIFf832gi4NdF9FjDE2?=
 =?us-ascii?Q?+OsCJ3mHDFvy8DQA8Q/tjaD8Sovk7qYf8AcznfIBT6eJ/yq27WB/mO7jOyZi?=
 =?us-ascii?Q?uW9hA80QIHj7irZSx3CCQGgv+0XXqq65ZicAWQ0PyX4KmrChjDfuV1FlWusE?=
 =?us-ascii?Q?tcuuXMV7N77T+z6+4o+8qDo57Rj3PE4r1TyFnyQAvEuk+fzwKNTypDQMCgHE?=
 =?us-ascii?Q?FnLmSuu0IIPkxA0hx6I/0GiOZ+OJpdk4iEaZQTguKm0wQpYyd4dRtkALizRz?=
 =?us-ascii?Q?ESfZlPdeU+SRa61MCGjDXB4UIRLG5jJRI12axckTPeBR0CgmGyvwq23ApKoN?=
 =?us-ascii?Q?HH8JkuHDs3tHgTHWWcH71aM69MMbah+3g+81S/ddflgfH1oyxfDGHm5zUmGU?=
 =?us-ascii?Q?3GMaHICssWJLe6dVvmLermEgesbQaQw+ryuX2cAiCMXNSlhYN7j3cEQjdn6q?=
 =?us-ascii?Q?32Kas3QuZVIGGcyYd/AHf3i/55WopSZY7WfA3RGPtsd+31X+nInfi0cvC5Sb?=
 =?us-ascii?Q?kU0Cw8a5AI7p1VDMDBWeSSFf9kr79T5LBqPOWvsLL1/XjnROWBf1lkjbFxBo?=
 =?us-ascii?Q?MDIDIJYzE0OWPKTGAuIBWqi+JyCQ5igj0e4dF2jLtpHaQc62rAhGq/XT4kvZ?=
 =?us-ascii?Q?xMRptxOS12MO8KaMDRB/4Zp852FHyGgwtMdI7NNtEHCPkJAWesTnuchjm3u/?=
 =?us-ascii?Q?PCWT0O33Ysm2mu9SZpuprv206EsUuLhd2GE8kmJmvjGtTXsM4i+oNraTGqKj?=
 =?us-ascii?Q?tb5hxL6ulEm7EcYYS3KcnkZPA27Aa4E=3D?=
X-Exchange-RoutingPolicyChecked: akQ3UbuiKaqOJdRwhYyQP/f+QwWhplelOGVoYM2DEp81/5Jy3hYBmqVHEzuKzGmCvh2exuhti3URdeeoqdiJo9GbhZhvgYmb9lGK4y62rSedLSNEjo9KSGvoxeEvqh8zqQFSzAc9Sl+HD1klh0nc5AjvPAClUia+gUNrNDKXRlVVfX0hbTmI7nefnC1g0DtUzeB4S+FcutVG6B5B0RGhFIjW1lNTpvBNlqlMKK5kcy+mF9xP9HOcL/D67B8QYg6rb6QK7XO95rKlz9A7NOifoO154Xq6uwvXMJ5q/0e10cxgrMdmW2hjrCDxBj7YsnC4ca/t+A0KK5BgO2X/+zg2Xw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e0afd775-dc67-4a0b-0907-08df08d68dac
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:42:50.3977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fu2SZ/kohFbkxZ9bC+MMlHiQPIJ+U3X/Dmd2RYBb4Bf21JHiqGm4Idr1AZOpV5gTkekwogpN6CFmWQmK2VfoDgjPLE8d8/cEZ21RSyX7pys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4632
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

On Wed, Sep 02, 2026 at 01:55:23PM +0530, jerinj@marvell.com wrote:
> From: Jerin Jacob <jerinj@marvell.com>
> 
> The ptp_tap_relay_sw example was not building because
> examples/meson.build was not updated to wire up this directory.
> 
> Fixes: bec00deaa8fb ("examples/ptp_tap_relay_sw: add PTP transparent clock relay")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Jerin Jacob <jerinj@marvell.com>
> ---
>  examples/meson.build | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/examples/meson.build b/examples/meson.build
> index 25d9c88457..ab82cf5fbd 100644
> --- a/examples/meson.build
> +++ b/examples/meson.build
> @@ -43,6 +43,7 @@ all_examples = [
>          'packet_ordering',
>          'pipeline',
>          'ptpclient',
> +        'ptp_tap_relay_sw',
>          'qos_meter',
>          'qos_sched',
>          'rxtx_callbacks',

Minor nit, the ptp_tap_relay_sw line should be before ptpclient rather than
after, as word breaks or underscores count before "a" alphabetically,
rather than being skipped.

Otherwise:
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> -- 
> 2.54.0
> 
