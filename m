Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2B5F8E49B
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 01:21:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D389640278;
	Fri, 17 Apr 2026 03:21:42 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
 by mails.dpdk.org (Postfix) with ESMTP id 21DC34003C
 for <dev@dpdk.org>; Fri, 17 Apr 2026 03:21:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zj8SLoIlTdObjVP64Wd/JPmPMBKXak99oLsdRAi7J/ewUaqozCkGJvSOeUsM8qWmAffXsYe1S1PvHXszLLDay5rf4lkPpXo7wN4veGgpR3Tdhvnh0X9iP4KbNDMwNhajMF773hXrJ0Iqx7S3Hvl+AAfgY1rHxZ5FFH5hpDeT/EzDlRgjmItuUUUFb6eo0IuZBFEX06E37roXTXUjG7sF/kfkSeipHO1+cNBDdrsSS6yoNTODxmDUuPFyIx2ZltsQ7b7J3SGLxuDhHS2/2pQ9iqePsbpsN0HxN+rIJ6GiB7i8OSZUHFYKgfoApP/yiVWiDwLJ9AGyovmIjkDV3MPrSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTeKHZnWa7G9BtlY7EsRBpOqdbwAVbn68hxV33BEWMU=;
 b=aYGGKj/N8l1nfj1kwWX2CTkL0Agjc6YJMZMM8DQrGov+SVLKXXhpCltq6MTnSfJbK1Z+unUgwX/xvJk/ETCkpAvhuupazZGL0oYu1/EaqSHPGWUhjiVCUILEY/hiIoOSTglynHWrIo9tw75J6jQ8jYZ29jcygWOklhCqpKb4+Cte2MIjXYXovantu4wplkw33tiR/q53EdIa8Ygqa4sDhbQpUyVOBPvPXt3ffE3wMXoR0YWEIvVsQs34E7nccNMvZfhSTl6HG5qtrrmW1TLx/XncNcKmgwitGzmjBl1ee+4M5iFhcBuaA7Yp4Abj1a6rRGrQwEjuMCxKw5KxEJONsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTeKHZnWa7G9BtlY7EsRBpOqdbwAVbn68hxV33BEWMU=;
 b=J9CLkin5/+eOF4xrUiTVWTb4vEKGxUZ/O5Hm+qKNBTrQHRmy6SwJnkbe99qfcrj9F4Ym27XcVeQSWAEYnH8mhqNR/CiuZbUZP+cG1BjCdCehSxEG3/Wt2F+26RuddeD6PtefbpmCdmkfIxCMj437bd6yQqq6d5wioWg6bNCpoZo=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by CH8PR12MB9767.namprd12.prod.outlook.com (2603:10b6:610:275::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 01:21:36 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 01:21:35 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "Tummala, Sivaprasad" <Sivaprasad.Tummala@amd.com>,
 "giveback4fun@gmail.com" <giveback4fun@gmail.com>
CC: "konstantin.ananyev@huawei.com" <konstantin.ananyev@huawei.com>,
 "wathsala.vithanage@arm.com" <wathsala.vithanage@arm.com>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "viktorin@cesnet.cz" <viktorin@cesnet.cz>, "mb@smartsharesystems.com"
 <mb@smartsharesystems.com>
Subject: RE: [PATCH v5 v5 2/3] app: add topology aware test case
Thread-Topic: [PATCH v5 v5 2/3] app: add topology aware test case
Thread-Index: AQHczEan2CVlJsJLuUK0NGxNpAvD+bXhSnKwgABjhRCAAMo6AA==
Date: Fri, 17 Apr 2026 01:21:35 +0000
Message-ID: <PH7PR12MB859698AFEFF656FD908A729882202@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20241105102849.1947-1-vipin.varghese@amd.com>
 <20260414193850.1696-1-vipin.varghese@amd.com>
 <20260414193850.1696-3-vipin.varghese@amd.com>
 <PH7PR12MB85969978BB6EB2C2E9034A8E82232@PH7PR12MB8596.namprd12.prod.outlook.com>
 <PH7PR12MB859644299B4823DD03A125DD82232@PH7PR12MB8596.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB859644299B4823DD03A125DD82232@PH7PR12MB8596.namprd12.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-16T13:16:49.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|CH8PR12MB9767:EE_
x-ms-office365-filtering-correlation-id: 83690594-6f90-410a-18d7-08de9c1faa97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: +/h2+lNtPE/1jyQETKH2oxa6c7xUR1zTRoR/JV7+wQkqOqWXTUsGRuElzjHi4jbCyNmq1iaQ8dsxFBCUb8L9uqWyMy/UipDa3mZYkuMEJHdsZmZgLLVjWyDcPDsEG3BtPUPqB7ksMKOmwab5Oyz3kHUPHpMWQKw8jN2TIOSzPElSxzQ4jgRGdcW+uJvzQh1ET/MU7NIm341OveKzHQM4QtlQTb+9iJAdIeKQplvj13pMmOJSu3VPekGutOCQO30asKXqmWagnxrdqrttKlerii7S39thMBiThbrddg3jhaONK6K9jKaMZ+3urCboMGaPU3ybfLZ7WW1OMjeuWGnxRMxZAo0Gp/QX0f5ngFQgnUGHAEYVJ+tPZU/PQZdGecH+unMbcH8zz4NRolSMQIOLF9sc/s/0LuwajIggP0l0GfFYKOL5qQpEb6xRGQsL6BwjB0RnKBdwO8vtPdnd3rhXB+maiPGi+7fHLFe50Gq0d4gFnfceWuMb+oS5JKhGUc253qLBEyaA9yCJ1K5vRlQvq18oi0P1l58UQzKwfpEKS3HuKG3FBCZNpwKFj461Mfp5yG0v5O4ujmtbBlrSI3zmvHFU+TIljo1ocBpvT4k3GQy5wpcJiRajO6L1Omt3O3muOUWa0hsufsisoCyKZSDAW8MCD4GrSAC5hUieFEJjhWtpZ3T3ladEZzXkMSAVoUo2M3dGv32FmNifTO+DepYnM9RItsiVnwQZbKdMWcHNRzJeg6RarMpKUN1rWWd4G0gqtT7WHMN5EOzBnG9+dgibjLC5XrhTxOcxVxHQCpkafSI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hs/30XfBH+iq3xPsGHZYS9ZbdJtPepWgM6/fhRABRtypnA+r8DWDAuTPd7AS?=
 =?us-ascii?Q?AoiStase7ct0Z5uk/WFWv0yddn1Vo/Ax8weMZtLzTKmYSHc9QQf8D13WvVgZ?=
 =?us-ascii?Q?O8xHwPlk/3CsVGaF0naBEcb7HSSSYSXlZVFQVZFu+Dr99ES+3QrBNqF++eQ4?=
 =?us-ascii?Q?pakLGL2cSZyhi1wM54a2VZ3dbrL7v6QXyqbZCRzPL//Nm0XsG5+RUgHWgZM9?=
 =?us-ascii?Q?aG4idLsTkGLohsPIGAU1CzaTPsuFezKpMGUIzTt6PH8t+8i7xmb/IZ3SYXZg?=
 =?us-ascii?Q?cQ2G6WheEXj1bwFjjLYPUdKHnj4sq7pq4pJ1kf7lObBoVpoLcZtS37g0Ur50?=
 =?us-ascii?Q?J0Zkg74/67LbY2WAmYNb8eXGUbW9/conmXj0N0mfdF7+1hMScDJhJy5UeC0F?=
 =?us-ascii?Q?lzyW2Mkw6x46SuVrsG8ds4tluF0WPGeMkbGq3t1eC9/A9b8XqzVoeBUy1bpb?=
 =?us-ascii?Q?fqd9lBo9d3YS9MF6Sge0sZ5yfKDVd5HCpCbWP7wTsMdpLzycYNsnNufCz9n6?=
 =?us-ascii?Q?kPVKUj0KXKNg1FAIXH9aLT28UPW/Z3kx1pqEPbkgwolmplrS2XrNyJHyPeJQ?=
 =?us-ascii?Q?RlTaKl3rxW6Tyz9XzHwfzM/t7gONRZ2DT77uB77hXFqT8yPc+c/J9HS7UjK/?=
 =?us-ascii?Q?U5yv+9iiLz56gF/qKkX5CqqBkRSnkEFKFeT5CAGYUlTJgMy1Fkz5S8qK5XqX?=
 =?us-ascii?Q?gq7bno1qJ5EsnFWcafZW5sBjrWz6BA/vepjTX3c/mdjGSn+uhha18BbZGi0/?=
 =?us-ascii?Q?08lWfEGqM+Rwk01y/xT9KMCXrL/b2EFCShW50bzLXbxRQpIghymcNTnCAOU+?=
 =?us-ascii?Q?ykOg2rbnQYXfrVd2Vs2wHCiI+Y5BX7w0WZ3n0UWbF4kM/HqF32uNEn6HuR60?=
 =?us-ascii?Q?98MCU6S6JK/6oRLte+q2ngWuMil0pu1aLVENaGtGIXVN9vrUYXMXfL/L5ZQX?=
 =?us-ascii?Q?vQYQ5nRzyORKBzEH6/vzURbM3GpgswTr1dFXgQDUVUPrEz3n6F2RjNasadD8?=
 =?us-ascii?Q?272YFGdYRBxwCb59Zy4fe5LcPiEIsxy6tXHb9v+lKnZj9a3cPqGznebi9Zh+?=
 =?us-ascii?Q?9QWBKfqHz3qem4rZBUkq1KoSt/M35gPyAsFZHilwpb7Qf+Kl8YkPCyyQAd0p?=
 =?us-ascii?Q?RGVbE1nBeA7MRnWMg/pofCG4Z/rBtgMmtap4bwJtG6K399Uvu4VMwtDiKCK0?=
 =?us-ascii?Q?4YONcj9koDe/sIp+kcgYab0MLNOCAnXFITp9B8HgAsoqkCd5ksL5Z887JzK9?=
 =?us-ascii?Q?ZxCsQlnbsppbP+yMU5MzCyMSyDQGBsMO//17fbgZ+zql2XqXiiR1nfackpIY?=
 =?us-ascii?Q?HGHRpnkmvcCbU/eC12l8inXKfYDavj42qsJV8r+cn2zb2Om9KaL6PiiEkkEW?=
 =?us-ascii?Q?xchbHO0Yjeg4Zn8r+9H88yDdG0zNHTvTDul4hLMpxEEexC7RbpDCDtFaVMb2?=
 =?us-ascii?Q?YiYMDQrcabutrb2TwZBL50PJdGDgZuCNG7yIeZb/jt6iRxleMHZNz/bpp6p+?=
 =?us-ascii?Q?iFhvV/dulr+DW21h1qLR6s2I9rSs3lkeudvh0aTks3GPP4HWTnWP9b83FhHA?=
 =?us-ascii?Q?qmV/7Pu/wd/F0L2XHHmXVio6tophrrBBzSbsrtmRwnE0bpYjKuzniDu//mRn?=
 =?us-ascii?Q?Obb1IXTPMsvrctfj7GMFUEBMjey2F7tqMjD5+6FRC0EKdiATm3krJlJrgJDU?=
 =?us-ascii?Q?SKJgsBBo/iB2mqZ/T98xGXwWxYOVyDyPwDtwGzd/Pu0MqhRl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83690594-6f90-410a-18d7-08de9c1faa97
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 01:21:35.3062 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XK3Wj/W3dnKKgrtOoTEIpl14jfIBBaGbsD0f/mkOPLaduoNpTkonRf+ZvtqPZmAq3EziQ/D2JNs5Tcnvg8V38A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9767
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

Sudhhendra and myself were able to connect over Slack. Adding his email add=
ress to the loop of reply
.

Sudhendra please check the reply posted below
> -----Original Message-----
> From: Varghese, Vipin <Vipin.Varghese@amd.com>
> Sent: Thursday, April 16, 2026 6:50 PM
> To: dev@dpdk.org; Tummala, Sivaprasad <Sivaprasad.Tummala@amd.com>
> Cc: konstantin.ananyev@huawei.com; wathsala.vithanage@arm.com;
> bruce.richardson@intel.com; viktorin@cesnet.cz; mb@smartsharesystems.com
> Subject: RE: [PATCH v5 v5 2/3] app: add topology aware test case
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> [Public]
>
> <snipped>
> >
> > Unable to find `Sudheendra Sampath` in dpdk mailing list and Slack.
> > Can you please connect with me email address or slack.
>
> Hi Sudheendra,
>
> Thank you for the suggestion and welcome to dpdk review too.
>
> My initial code design were
>
> ```
> #ifdef RTE_LIBHWLOC_PROBE
> +static int
> +get_same_domains(struct lcore_pair *lcp, uint32_t domain_sel) {
> +       if (rte_topo_get_domain_count(domain_sel) =3D=3D 0)
> +               return 1;
> +
> +       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
> +       unsigned int domain =3D 0;
> +
> +       RTE_TOPO_FOREACH_DOMAIN(domain, domain_sel) {
> +               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
> +                       break;
> +
> +               if (rte_topo_get_lcore_count_from_domain(domain_sel, doma=
in) < 2)
> +                       continue;
> +
> +               id1 =3D rte_topo_get_nth_lcore_from_domain(domain, 0, 0, =
domain_sel);
> +               id2 =3D rte_topo_get_nth_lcore_from_domain(domain, 1, 0, =
domain_sel);
> +       }
> +
> +       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
> +               return 2;
> +
> +       if (id1 =3D=3D id2)
> +               return 3;
> +
> +       lcp->c1 =3D id1;
> +       lcp->c2 =3D id2;
> +
> +       return 0;
> +}
> +
> +static int
> +get_two_domains(struct lcore_pair *lcp, uint32_t domain_sel) {
> +       if (rte_topo_get_domain_count(domain_sel) < 2)
> +               return 1;
> +
> +       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
> +       unsigned int domain =3D 0;
> +
> +       RTE_TOPO_FOREACH_DOMAIN(domain, domain_sel) {
> +               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
> +                       break;
> +
> +               if (rte_topo_get_lcore_count_from_domain(domain_sel, doma=
in) =3D=3D 0)
> +                       continue;
> +
> +               if (id1 =3D=3D RTE_MAX_LCORE) {
> +                       id1 =3D rte_topo_get_nth_lcore_from_domain(domain=
,
> +                               0, 0, domain_sel);
> +                       continue;
> +               }
> +               if (id2 =3D=3D RTE_MAX_LCORE) {
> +                       id2 =3D rte_topo_get_nth_lcore_from_domain(domain=
,
> +                               0, 0, domain_sel);
> +                       continue;
> +               }
> +       }
> +
> +       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
> +               return 2;
> +
> +       if (id1 =3D=3D id2)
> +               return 3;
> +
> +       lcp->c1 =3D id1;
> +       lcp->c2 =3D id2;
> +
> +       return 0;
> +}
> +#endif
> +
>  /* Get cycle counts for dequeuing from an empty ring. Should be 2 or 3 c=
ycles */
> static void  test_empty_dequeue(struct rte_ring *r, const int esize, @@ -=
488,6
> +574,33 @@ test_ring_perf_esize_run_on_two_cores(
>                 if (run_on_core_pair(&cores, param1, param2) < 0)
>                         return -1;
>         }
> +#ifdef RTE_LIBHWLOC_PROBE
> +       if (rte_lcore_count() > 2) {
> +               for (uint32_t d =3D 0; d < RTE_DIM(domain_types); d++) {
> +                       if (get_same_domains(&cores, domain_types[d]) =3D=
=3D 0) {
> +                               printf("\n### Testing using same %s domai=
n nodes ###\n",
> +                                       (domain_types[d] =3D=3D RTE_TOPO_=
DOMAIN_NUMA) ?
> "NUMA" :
> +                                       (domain_types[d] =3D=3D RTE_TOPO_=
DOMAIN_L4) ? "L4" :
> +                                       (domain_types[d] =3D=3D RTE_TOPO_=
DOMAIN_L3) ? "L3" :
> +                                       (domain_types[d] =3D=3D RTE_TOPO_=
DOMAIN_L2) ? "L2" :
> +                                       (domain_types[d] =3D=3D RTE_TOPO_=
DOMAIN_L1) ? "L1" :
> NULL);
> +                               if (run_on_core_pair(&cores, param1, para=
m2) < 0)
> +                                       return -1;
> +                       }
> +
> +                       if (get_two_domains(&cores, domain_types[d]) =3D=
=3D 0) {
> +                               printf("\n### Testing using two %s domain=
 nodes ###\n",
> +                                       (domain_types[d] =3D=3D RTE_TOPO_=
DOMAIN_NUMA) ?
> "NUMA" :
> +                                       (domain_types[d] =3D=3D RTE_TOPO_=
DOMAIN_L4) ? "L4" :
> +                                       (domain_types[d] =3D=3D RTE_TOPO_=
DOMAIN_L3) ? "L3" :
> +                                       (domain_types[d] =3D=3D RTE_TOPO_=
DOMAIN_L2) ? "L2" :
> +                                       (domain_types[d] =3D=3D RTE_TOPO_=
DOMAIN_L1) ? "L1" :
> NULL);
> +                               if (run_on_core_pair(&cores, param1, para=
m2) < 0)
> +                                       return -1;
> +                       }
> +               }
> +       }
> +#endif
>         return 0;
>  }
>
> ```
>
> Since it breaks the current function test format, I went ahead with curre=
nt approach.
> I will re-introduce the domain iterator design in v6 for you. Please try =
it out and let me
> know.
>
> Regards
> Vipin Varghese
