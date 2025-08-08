Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934F8C87FD2
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 10:59:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97725402AB;
	Fri,  8 Aug 2025 12:59:40 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by mails.dpdk.org (Postfix) with ESMTP id C1FAD4028B
 for <dev@dpdk.org>; Fri,  8 Aug 2025 12:59:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D79sOlramoDOIMIQpxyWyhzjgJAYZ/V1gwDY8b+phln0v/pk2iQzbYMWtDbKD3PW/aS3/bj5DUcizgrZwdTD/SE6LJ06IKHz8cY+ldcgDQAHGnuT9ZVNLhZ8JnBVgP8MZGovAtna56Qu1NdCmW0CwD46HmV+FdUlJS7hHWc7nlY/gBV1gQPZ1hugyyjTNT8pmemkc0MRSWQO+/xGNXIkyhuxQPnu4dF5+jDHYe4+TL08831D1Iceqj+ldKV599C27s30//tN+PvPlvrPVC7BLBZ115e7hZEjibY1EL1IxRbNAb8/rxxd5/9pW24FigFnqzYrBwliRjVmfmgMqfQ4Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHtuHbTWtq+hSUFQkB0pDr4FYQzoN8SB7BazMLmuRrw=;
 b=LneZU+YdBXisdKzzrbXBFYP3QYYeo8kU1spvw+T34KYFfOpPRSpKf/BXoodtwVqgAo/JzQe8hpmznUCNW6O8kdO17xXgIRlAqdRq/RyKdipeHNmfgMBSPCNuwRSsbppiFLuK1jrF+aUsesXSiAtKLuGpeoA08E9dmLY2uSG+AXmdUVi2sdEm1/F6T5xPRFdY8yHgeG3rIMoUEKKLIh6q4VD08FYmjW/eEyONqX2MrjLGKkLI8LryfrYeM3a7WywN1RXgqbcelYtAvZBLsQ5cHQXTBDkhdCY1IbvOQt4CYq9ekNZR4d+ItjTbJC7XiPfFx8VhCMMvinadzm815iIXaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHtuHbTWtq+hSUFQkB0pDr4FYQzoN8SB7BazMLmuRrw=;
 b=c9Zko0jt1Ge8tJsQDsadU7GcUtTbdwAGGmnKI3UiQE1qoil5RFlZ/kHdVJbYzNnRO56Z66XjUJ2ic+1hoYKRPWfatTws0krIa/CO6ZLKxVt1/kDMUNZQ9FdtGYoBiIGR0mEK/kOJrWhh4oPx/NZ4rYzn4lkx5FhzpbUu/ioe7sw=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 10:59:36 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%2]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 10:59:36 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "thomas@monjalon.net" <thomas@monjalon.net>, "Yigit, Ferruh"
 <Ferruh.Yigit@amd.com>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v7] app/testpmd: monitor state of primary process when
 using secondary
Thread-Topic: [PATCH v7] app/testpmd: monitor state of primary process when
 using secondary
Thread-Index: AQHcBTOmTMs4cZesWkSBbj/ohPqRp7RYGXxwgAArOwCAAFY/MA==
Date: Fri, 8 Aug 2025 10:59:35 +0000
Message-ID: <PH7PR12MB85968E4B05D92C12C963F1E2822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <PH7PR12MB8596A4A5CCC22A6B1584AE14822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <20250808054452.1350869-1-14pwcse1224@uetpeshawar.edu.pk>
In-Reply-To: <20250808054452.1350869-1-14pwcse1224@uetpeshawar.edu.pk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-08T10:59:10.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|CH3PR12MB8657:EE_
x-ms-office365-filtering-correlation-id: 8240f356-e31a-46cc-32fd-08ddd66aa9c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?NNgCE8eSwkV6c9O+psdYYJ0uAG4iQo2Hz3A3Qyb930W5t+RBADl6WK73gOMl?=
 =?us-ascii?Q?6fDiytfMFA7O6anJV0XeK/fSqifqofUdP+h6AaMpIR4ymf9zxTka0S92iedb?=
 =?us-ascii?Q?0qG05ZCuprMFUMnfBqOaNo+LtTizLJjzzSKqmDp4SKK6T8QEKGNsBfINGRL0?=
 =?us-ascii?Q?VWxZMQ8w2bXnWcPMXNdlyJNQSo2zdpGiF5VQ1AkRBs0ccZqgzZCwz0sEqXUA?=
 =?us-ascii?Q?iWjRKMAqyWUbfOppQeJNbUjkyg1NffF/+En0jCm7rNbNKUiNmOPymgcmtQRz?=
 =?us-ascii?Q?9JogQanJsNJF2HZmIJHoLg/E8uGpflS3TRECJGmYrQqRkGp8XfmfP7NitiJZ?=
 =?us-ascii?Q?NAHQgGOMNYIdvK/8nZkRiru08GxLqEhVNQs7FoDSnGCI2qcWt+ljKnzh09mW?=
 =?us-ascii?Q?ZAi2K+Ma9QL0WDtDKDzzp7pCPPe9LlWrjDwxuZyLDz7ibLEAKsh76LR8DN4v?=
 =?us-ascii?Q?gEtIf6wHN7t8Sb3B6HF00fahnxTpkxTsaOEh06oGbYuT6tuhpb5jHucp28Md?=
 =?us-ascii?Q?InKceN0nV3OCICeW2fKMEb9bOMrCaSFgq6r2PZao8x7GJq3GaAYA4pNyUCXR?=
 =?us-ascii?Q?ACQoHDYKbxDpJVRY2i1PmrOeNseh+Mm0I0VPX+MrQqdiZAliOL7Pj62oc0XS?=
 =?us-ascii?Q?/oFU0sVOrct39DgH2x6gSF66DPndhkgMRd/Eg7Fp0kIlvqeH2Dv3sij9ZMWY?=
 =?us-ascii?Q?+UjZZ4mWWq0SewKZ1loJzIRX4nGJ3H6+0+MNYcW2UJfs4fvQqYB7SMhYXXHU?=
 =?us-ascii?Q?TsBWiyo6y3r1qHHyflZsRTXAyCrMr4VLznEV7La7i6pGksNhOQX4DJDoqh8+?=
 =?us-ascii?Q?POhwu5s3eHqbJW2WjRLFcV3S8PO6VuGtq0RFfhOL9IKEdg+ImcDu73WbmpLd?=
 =?us-ascii?Q?oCTGC73MJqWuT0rsqgSBOezDVJ7yF4noBSdlXV99fjwXb+YojLfE+6J/XGDv?=
 =?us-ascii?Q?ckrHDVFhKpnfLhUmL4Nf5TZD2+mNi/dnQFaRzX90rzn1tt/B8VuFlvlOQe7b?=
 =?us-ascii?Q?gMPajRUBvXa9wnoVR20oCVMyRIaCBtpReVSaDBn+zY/WSvEeHxEbguY5dSRS?=
 =?us-ascii?Q?wRFhMrMbyVWIVj9ikh1NJ/TGYn1Ekzg72p5Ojmw6WmlN+GjC+hZXUA8YU1Y8?=
 =?us-ascii?Q?9amWq0RpRynocfg93SEJGcJ7HoHAoJjO+SdLDbcM2AVj9hTgHvvT9QMmOpro?=
 =?us-ascii?Q?OuykeJo2OmVC6nr5rPlk6GPQZN2N9uG/RYVbeUpQFbzBrbRGJL+S1w0xAHR/?=
 =?us-ascii?Q?xrKHUl2NZFMmVSy300G2wRnsKhsVHo2l01vqIkq1DLGZR9D5+Ao1og8m1eLk?=
 =?us-ascii?Q?wUXZUhP90iIG2eL7DCmysCt6ZwTXSuel/DG+uwrPN+j70fEEXL+rAOmCRzbr?=
 =?us-ascii?Q?RMat2+/i+YD/2UGlezS1GW1mKhnas/iVHacCJRSec60iChH0jtNRVg00b62o?=
 =?us-ascii?Q?02ok/Y23OB2zjoIyqRcw2ubWms68yyOKaEJlMF5ooe3vBRGPrJNTSV9dMrhv?=
 =?us-ascii?Q?1Hm0x/ozb4K+Ftk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eWLY/bNg5EdEu3rio9Ov8/sY0NQ0tGylEfY2qlilr2vxDWPiqoc7szVZG32j?=
 =?us-ascii?Q?Qno6vg/mdG2gGH10I/Zcvot+PkQwaMmYogEKrWyvLf7E61UDM4WCWyBibrFh?=
 =?us-ascii?Q?UbYGTjNIQQg3F/KlIzHUoE52hhMs0Gv7s9vgEZO3MUTjbJUkWdi6oDDW/1fc?=
 =?us-ascii?Q?XFn06tPx7qHRQI0TGwsADg/V5U0Kv/1u6QxAdsJJzINAhxlp87M2oloWhbR2?=
 =?us-ascii?Q?F3nJ7yfyc4NmkQP5VyNacdjeg96SPPGSCUMEaBDrx1kiVko745yJ71Gkysrg?=
 =?us-ascii?Q?tmp9vQ8MOpkdCv9i6Ygm/dI2CNpt8l1lBqDcjvzjfaAGxOlcx+xPRJVAtGKa?=
 =?us-ascii?Q?rlB+D1InC1Hh3HeeC8Aeyt0kr13E6F3MFvZEyERNRWU+fwo+rdIAmtmvDJMW?=
 =?us-ascii?Q?L2VRRFF0VY/hB4ECcvRb+tOZZi+Wst4DNzMMCS5j+HX06kob3Itfqrf3r/fn?=
 =?us-ascii?Q?dnCKG1MmLar79VUEL6e5G6vHh08I9MJwiAIZxmnEDLweThy4aiGBKMUpGwUh?=
 =?us-ascii?Q?pZ+BkiQEFv8CSXF0sqKBYJbtYKT0TC8Ebd819W5nAZfgJKTnVkP2hW83Nk2z?=
 =?us-ascii?Q?D44b3xK4qEgX+WdeSvmZJIFfvmMX3LxVYeEGjrzuirbxkBIXnJJTKGDXLk7Y?=
 =?us-ascii?Q?TRU5HsNIMDvbFUw+l2s6KnN3J6s7VBgkxneempzsjEVjBmOh0L/f0/PkfhuS?=
 =?us-ascii?Q?+qqV0kA5T89yZhkovYmiPk8h6c/X/UYOOqYYVonVxy+D+DFZy+sJuUOaGRHl?=
 =?us-ascii?Q?Uh3b+6qaZwNL7cK17a+zy0Y16eD1wFiVo+NxqP9WWvUT6YvizsWqlfEkEQ3j?=
 =?us-ascii?Q?3amzI92gRtepEec5VxdPtCXnvnr+YJDutR+AvTE+2q0fSciQSGe8pZXM2Dzn?=
 =?us-ascii?Q?E9owqYhpedYH9cAPFD4HBa+HiIbIN2HrlHCJp6qLOQa9q2VvF0gP1P6Ooy9w?=
 =?us-ascii?Q?SmBRHuqRo5eQkkEGU+KFmhZD6HM+Mu5uD/rK3zp46B+fXveYriFLDUsZtwVf?=
 =?us-ascii?Q?of/B5p/kmx7RIrdpNXwgb1xQtzxlMl93CGJaf3NgFACZPLuBtyAXDIYhxt1T?=
 =?us-ascii?Q?Hqtpk4GJ7iGTiOfvBo76gCm2/TAcdOCvIfqbluYdC/uRQ0eS/zPxGaz5i/wd?=
 =?us-ascii?Q?4A43YyZ6O5zqVpQwqx37XAZbT9lO2JUVB1d40xeSiWzV3siUGFsSnh/NYrrY?=
 =?us-ascii?Q?V2aTzxC5vuSS9LO/Qh71JOniNleqn/aoMV7ASgwl/XhdS31wOJD8DLFsX9Dn?=
 =?us-ascii?Q?QJvnunhD6T3qbf/YkGPbyNYmw7ToRmMdYVeb1qjKvEIkE77cZ27sj0bAj2A2?=
 =?us-ascii?Q?0KhwOt5dKwhBTq5lqZ1s6UQfBASg86Cbvoi57VQxSzjxN47g30weWiJ208MR?=
 =?us-ascii?Q?mMrNOQ4nUxkk23QnwbsA/dHf2z2k+gEeFINaSvfrELMF+pKuGWktkwNA7RqE?=
 =?us-ascii?Q?Y6UkuwP9lX52eNSuJ0bqOSya7UpUAcQi3fK8CVzCPS1953dJFZUTWoNKe+2P?=
 =?us-ascii?Q?o4P4hOQ/VRHW6a9tqGe4Wzq+4NDJnx2WJrkJacPFV+VgwxOjpNz3kI4o6wUU?=
 =?us-ascii?Q?tEM77FticIEwtLCd1gwekCAnXrw17Uu4NmR/v50i?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8240f356-e31a-46cc-32fd-08ddd66aa9c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 10:59:35.8984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zf91OgsVORXCjT/6v1AgdRPioCz8XkH+Ly5YQ2oihUInSVCCzn4+8KtDD5YLhZXtNzYyzHUsd2dIS4YoBDhj0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8657
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

[Public]

Hi Khadem,

Snipped

>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> Hi Vipin Varghese,
> Thank you for your feedback!
>
> Yes we need graceful exit, directly calling eal_cleanup from secondary wa=
s not
> working, we can do the following workaround to use `eal_cleanup`.
>
> diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c index
> b7affa6da9..5ef6008a3c 100644
> --- a/app/test-pmd/testpmd.c
> +++ b/app/test-pmd/testpmd.c
> @@ -4347,7 +4347,12 @@ monitor_primary(void *arg __rte_unused)
>                  * is no longer valid. Calling any cleanup code is going =
to
>                  * run into use after free.
>                  */
> +               int ret;
>                 fprintf(stderr, "\nPrimary process is no longer active, e=
xiting...\n");
> +               ret =3D rte_eal_cleanup();
> +               if (ret !=3D 0)
> +               rte_exit(EXIT_FAILURE,
> +                        "EAL cleanup failed: %s\n", strerror(-ret));
>                 exit(EXIT_FAILURE);
>         }
>  }
> diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c index 52efb8626b..=
087a4b1137
> 100644
> --- a/lib/eal/linux/eal.c
> +++ b/lib/eal/linux/eal.c
> @@ -1333,9 +1333,12 @@ rte_eal_cleanup(void)  #ifdef VFIO_PRESENT
>         vfio_mp_sync_cleanup();
>  #endif
> -       rte_mp_channel_cleanup();
> +       if (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY) {
> +               rte_mp_channel_cleanup();
> +               rte_eal_alarm_cleanup();
> +       }
> +
>         eal_bus_cleanup();
> -       rte_eal_alarm_cleanup();
>         rte_trace_save();
>         eal_trace_fini();
>         eal_mp_dev_hotplug_cleanup();
>
> If Stephen and others are agree, I can supersede this patch with the newe=
r ones
> containing cleanup changes.

In the email follow up earlier, there is mention from your end as soon as p=
rimary is down secondary goes segment fault.
As far I recollect testing for multiprocess using dpdk 22.11 and 23.03 the =
behavior were different.

1. Primary can exit or segfault.
2. Secondary can still continue to use mbuf and pmd calls without fail.

But if you are seeing there difference in behviour, can you please let us k=
now which version onwards it changed.

With respect to synchronization, when dpdk library-based application is sta=
rted there is also a MP thread that were created.
Are you sharing that this is no longer functional?

Note: I am trying to understand the behavior observed at your end.


>
> Thank you,
> Best Regards,
> Khadem
