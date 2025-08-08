Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78810C87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 03:23:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63B5940270;
	Fri,  8 Aug 2025 05:23:41 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by mails.dpdk.org (Postfix) with ESMTP id E0BBE40150;
 Fri,  8 Aug 2025 05:23:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkwEkDrlQJbYGqdFHbiI+hau+t4pO46eBcJNAGwwyoSp1B0NO51Dr/HUDeH58JOPBs9GbocS3qvzrTMKkKlSxq9QjS9UqmlwpUKKJVO+D9efkzzl647/oPgNm/oNYI4bloS02ubBjFpNMlz38jXKkMWIJt4+Sr5B5dD8opJzqgtWnRfrOEyq786ne+MKzktFMQxPOjgbA5myCePtNTbphkqEq4JvqBZeobvIT8MjIfLLVv689O5zSLjN0AhlBW8mMIw8XYPwAIjUnPcTa2V/EMF64FmSJ+Y9UrS+QrssFMyqjks4pRpS/+OILVgf+/bwz90ktaZKfo151qGGxfbt0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1jMLd6dJwLOBJ+f3uCcb94TtUEccigFtxW1sGDkKHE=;
 b=eIKNTUGXa3oRtI9688xZNL2wjBXpyPM7GZXuLv9rClhj64hZCAW4WwuT2hMdWKWDFhvoSK/7O1n4y0fMoAuas0wFuz3XMOjfjDZO1a+mPgtM7EZ/JzfAaKpScNBsLAgus0YFqtj6VmSAJe3P8BmTcqI781R9QDmkHqCVolPbeW4az+MknQp1o4fJ6HxjC6BYFbcwtSGYcQxkzdJD+uu2RGjwg1PmDcdiUkpvMSD09M6MU8d1/PoXt5qLVJPT80cR8Xsi4pDzdIjmrr23c4jmRT6SMJVwpHHSMvL9Q09B6zyH/E4Zy6m3cuQVcpZi0+cwZT3UOGNkdgcZfl/Dl/hMWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1jMLd6dJwLOBJ+f3uCcb94TtUEccigFtxW1sGDkKHE=;
 b=vDe1zgxNBd0xpgOH/9Ojoo6cvRqaKluU/V1uDzlAOBVgYrPse223CRtSaAgh0PkzoPoD8HzP1xvlqRy7ISp1j8e/lx+pf+ZiowcROrxEH9b9u39ClvN1KOp+Od24uOIFKBLisK5p7au6WAPYkTilvgwIofdmhYSSsQmD7Da8Hpw=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by PH0PR12MB8005.namprd12.prod.outlook.com (2603:10b6:510:26c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 8 Aug
 2025 03:23:37 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%2]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 03:23:37 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "thomas@monjalon.net" <thomas@monjalon.net>, "Yigit, Ferruh"
 <Ferruh.Yigit@amd.com>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v7] app/testpmd: monitor state of primary process when
 using secondary
Thread-Topic: [PATCH v7] app/testpmd: monitor state of primary process when
 using secondary
Thread-Index: AQHcBTOmTMs4cZesWkSBbj/ohPqRp7RYGXxw
Date: Fri, 8 Aug 2025 03:23:37 +0000
Message-ID: <PH7PR12MB8596A4A5CCC22A6B1584AE14822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250729063919.3554143-3-14pwcse1224@uetpeshawar.edu.pk>
 <20250804113322.53650-1-14pwcse1224@uetpeshawar.edu.pk>
In-Reply-To: <20250804113322.53650-1-14pwcse1224@uetpeshawar.edu.pk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-08T03:10:08.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|PH0PR12MB8005:EE_
x-ms-office365-filtering-correlation-id: c52428fc-7b7a-48fb-769d-08ddd62af6b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?0/TFjoBSJcBBgQIsTZglg1YJL/+7w034XjPxZVkyHFEKOEWWQ53s1wkYo85v?=
 =?us-ascii?Q?2eEifB1zC8pJ55n/YyZU8e5XF3nWFy/UpsEz/sbUtAAFOcPo9xoavcDvkF4p?=
 =?us-ascii?Q?DBSPq4nHs0vH0d3UXTXB+JRFsO7y6EQ9+iOfd47wjbhO4UZ8n33mCMBoX72G?=
 =?us-ascii?Q?QW/X4tIG7+JpgT6u6VshO3K4lpHquFxoueLM7twrZ+RPz2Ttt8UpzW5+HdBd?=
 =?us-ascii?Q?MtRGRvLx+uVs8/gw+hfJ56Cxh1nnnyU0smZCsE8CAfPD52tqygQnYnuX3xRu?=
 =?us-ascii?Q?Mvw9xT7r3XPgbBreHVZhsxheilje4t0xeYu5ZG6njxTAdkiRTRubtZcgQcyg?=
 =?us-ascii?Q?VzW61/NKPdQP73R5zJ4Rxu8LRnzf1NvHU6L+2wkQLBSK3clkHD1XL/f5Y6oa?=
 =?us-ascii?Q?Q9TWV3udzz8Va96xYGopM7a0SulNkXhbTUAe9SPwJnC+xZ76Mvujgu5gxQqh?=
 =?us-ascii?Q?eaHp0rGZ9zJ9xBgdDhuQb5Y28/5I+LAohsqWZlmmJ6/HTiu6QO908+kFS6zX?=
 =?us-ascii?Q?KLUfZg6/G7muWpaF+2ol9C5gKh0WIpk6y55rC0KP88TtYI8LKWKgjU149ohy?=
 =?us-ascii?Q?uDelPvGZ0ayLSp8uLjqIsg9icaUVtW3/+5XmnO2LfoF+RJiVl4lQHw5O8jae?=
 =?us-ascii?Q?+EU5H2GNQZGTQBH41fCYFFMJAErP/9HROMfQzzny21AGqQKCN7/Q8KdUR0hk?=
 =?us-ascii?Q?nHFmgof+I/PwUI0J0stt4GQbQAzDYDrb5fS8mHZOy4huxoIDNIpQt+CAXN1Q?=
 =?us-ascii?Q?SOF/zaKzRlf0COwVYoWTZ1iDAtZoG3hrxe6AlKUrjiNvUuVQqco2ISsk2/ob?=
 =?us-ascii?Q?8u4Ys3s93LxRCGUmVSsT/YNdWEP9vz4Gvu5Edung2pQJKirYEk1a/axRqspb?=
 =?us-ascii?Q?mKiqQS8os7tXTPpoWB6Jh+G/yiTeE1/OnVpkVR8utAy7ZuqwVd406Ngn4ezq?=
 =?us-ascii?Q?cDz+x7qGUmYBR3kdyCLeX1eCJOHhwD8DeFTtlGLyn5sbGlLPRVTa9A/uTBLn?=
 =?us-ascii?Q?JH0MW9UWTWWoUYq3wyTEidvViAPw5Jd//QRIuSg2Q+GPCRYOTpwSvAq+KJzM?=
 =?us-ascii?Q?t2EcakH8pKOvulOfYsHothJ08RBNDbHGplKzXVhOzd1z8wqcSMLoUtyZ2RMw?=
 =?us-ascii?Q?tRCaXvx1AgKHrQTIsM+cp3NPYd/rB3EVkCTdEQXy/GLNO38APCCgdrhtEhlW?=
 =?us-ascii?Q?q0GzTHCdpVYVI/gA+r5e/shugT902ikZ98BSeK7KkzrTcbQp6u+038W7JalA?=
 =?us-ascii?Q?kDz/wYAbz28Pcd8yKWYZB/PEYpriziqYCSckqiwsNRu64FN0GL6f/ci0Jxq9?=
 =?us-ascii?Q?mVL0Dor72SPW/VeUso74vXXgQQhk8LzNZEZ4EzOkD1/BHZoQSHyp7IQatmIR?=
 =?us-ascii?Q?Ywl7Csi3Lgt6rB4PvspJGDeKSxvl9v3Xx6J+qLJh21SwUo4oSHMqUjW5vN4C?=
 =?us-ascii?Q?IsNLcKSAqbCveFtxsZbVxAVdzfWGB2ZlHrZf7eHsYaXn7T2Ux9RcmXdNjvIX?=
 =?us-ascii?Q?WGLvVmRaBk/jQEw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TecOPdWUiTCKc68muoiJxxW65xCS4TJRnj/xyvabJP1shexKflhjTG2gYlvP?=
 =?us-ascii?Q?n7IpvmsdCrEFoajOVFsvy88NnQfYTasGlVnlYS5ejusWg6WiqjtUjKuH7lgU?=
 =?us-ascii?Q?I/L+J0e31eU7X8TbtvZVb+wnSCJ0PIL4LJQVwL2y+AtJ0DJpY3zjEO/anGwS?=
 =?us-ascii?Q?xwP4SkviuW2c/ctuZ2zKf/b0q5S1v7+lI+LcKyN+j0klZRna6qIM8Pnc/PB5?=
 =?us-ascii?Q?3FVJkiLyBrvToOZGoBuC9Op/IxLRC0CO+RvwFEJULhfuGYoxp78uB03Rt1zs?=
 =?us-ascii?Q?WEPaTOZVkjui9aqT3GefUvadoiA3lsz4XVJQSPB97h7sr3Q2uhLU/BOUudil?=
 =?us-ascii?Q?XZSW3VnEQ5xaRp1CF33VYy0lpnzfR8xvBF5iuQuLHNS4SOiXdmAE9TgG/DnC?=
 =?us-ascii?Q?0JwJ01Zd9HSlrtopnKKrgS1lzLco59mkpKObYMbpU3qahNfJMzMFY0tmvsv3?=
 =?us-ascii?Q?suUp0OdkOqy51T6Mh1NTy2CIZJNe7/u4lE4iYL887WFfb7wGhnkB2ntgDPPg?=
 =?us-ascii?Q?3c7k09dLjwlY0laFvWetvQ36Cqq+GG/N4i1tZTg0HohtzCkRImijmYzARUo/?=
 =?us-ascii?Q?5cuq4A/MNTdk7/SUANSYW3AJcBH7GZdr46cjtrJrO9ti4LAuwPIqT0Ubxl29?=
 =?us-ascii?Q?ojXXnQVMen0yuolhkRDqC6XI9y0SpEi+wRQldEVkZXhdd3vtshRwekDwkpN+?=
 =?us-ascii?Q?sPHb/irzkN7nRNGClzi2BbuH+5Ln5GNtibARPPHi4AUQJXmE1unJXfyMaXy7?=
 =?us-ascii?Q?xTDLEValRJ7xZCmim8jppfnuo4nfIndN1uikdE4+oX5u4J7poE9FsNGEyLqW?=
 =?us-ascii?Q?VuPXiDvkuGXW/NZevh4LcxqzratUDrVsJZo6z+EIpd2dhD9OSbtLPb2fwGhq?=
 =?us-ascii?Q?4FIz3P+xwBxiGr8Cwpgjn5JVDnQDx+xdsPhsyPEmundsyJJ4Lho3t3N6p1fB?=
 =?us-ascii?Q?e6qHnOao438ihTYYfp6RrMQhuC69/R7IfP556IyQOXCKsH7xW8z5OKsl+MGu?=
 =?us-ascii?Q?cQfr8dQDNmgY++RPrxMV/8PJz4Ry5SuGf5bi/db9jnrnRFmwmouxbr0RUwrh?=
 =?us-ascii?Q?wxc9gO4qpWFZZ9u+W6Pz/jH4Q+wDO2HH2puQPgG1A09GNbltrkn31IAPb0Xv?=
 =?us-ascii?Q?CLHqLb+Jz/30LSt67wT4m+4R/KmC0W2W2MQGd3PGbY9bimEf/5o2AxGVqPKc?=
 =?us-ascii?Q?NZGuB+fgoSohs9XodKFGw+WaOY4hhjcc4rFXJpz5Bsz6ItqrNkBCYD8LQX8l?=
 =?us-ascii?Q?6L0Hu151ED4+MU0ue6B+Y+zlk31yZi9qCH8HyNrvx+RafCnB4If6FS4FzHYK?=
 =?us-ascii?Q?FbC9JlgDftdRLiPVDvJ8nB5dJ5TLnAR2lRu2jzDyChhRBJi4a6y20s06SQCP?=
 =?us-ascii?Q?TDnhewnNSt2p++NGzz0eAyDaq1JOP9gddTmix7u0RdwFwuXvkTy9FHYKwCYr?=
 =?us-ascii?Q?PicJpgaM27V5o8eoz7iEPQjVb4H9U9v99McK724XDbuP+6RQ47PCrbwHvKjD?=
 =?us-ascii?Q?hWm3vYsG0Rs1pd42dOkrTgui2W7EThQa6IXbr+eYUufpv+snYYCtfLCFCvbT?=
 =?us-ascii?Q?yBykcjb9lrhdxrCHvzc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52428fc-7b7a-48fb-769d-08ddd62af6b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 03:23:37.1920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WQziuhrv2WxzpLZ/Bj0CspAiHTE96B0VOcRaJTfkqhwgX/V03YDdpW+YdaFVKzqRKXxvufSCVa5XBPZ24hXfvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8005
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Khadem,

Thank you for sharing but few thoughts here

> -----Original Message-----
> From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> Sent: Monday, August 4, 2025 5:03 PM
> To: stephen@networkplumber.org; thomas@monjalon.net; Yigit, Ferruh
> <Ferruh.Yigit@amd.com>; andrew.rybchenko@oktetlabs.ru
> Cc: dev@dpdk.org; stable@dpdk.org; Khadem Ullah
> <14pwcse1224@uetpeshawar.edu.pk>
> Subject: [PATCH v7] app/testpmd: monitor state of primary process when us=
ing
> secondary
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> In secondary processes, accessing device after primary has exited will ca=
use
> crash.
>
> This patch adds a mechanism in testpmd to monitor the primary process fro=
m the
> secondary process.
> When primary process exits it forces secondary to exit avoiding issues fr=
om
> cleanup logic.
>
> Fixes: a550baf24af9 ('app/testpmd: support multi-process')
> Cc: stable@dpdk.org
>
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test-pmd/testpmd.c | 47
> +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
>
> diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c index
> bb88555328..b7affa6da9 100644
> --- a/app/test-pmd/testpmd.c
> +++ b/app/test-pmd/testpmd.c
> @@ -101,13 +101,15 @@
>  uint16_t verbose_level =3D 0; /**< Silent by default. */  int testpmd_lo=
gtype; /**< Log
> type for testpmd logs */
>
> +/* Maximum delay for exiting after primary process. */ #define
> +MONITOR_INTERVAL (500 * 1000)
> +
>  /* use main core for command line ? */
>  uint8_t interactive =3D 0;
>  uint8_t auto_start =3D 0;
>  uint8_t tx_first;
>  char cmdline_filename[PATH_MAX] =3D {0};
>  bool echo_cmdline_file;
> -
>  /*
>   * NUMA support configuration.
>   * When set, the NUMA support attempts to dispatch the allocation of the=
 @@ -
> 4332,6 +4334,38 @@ signal_handler(int signum __rte_unused)
>         prompt_exit();
>  }
>
> +#ifndef RTE_EXEC_ENV_WINDOWS
> +/* Alarm signal handler, used to check that primary process */ static
> +void monitor_primary(void *arg __rte_unused) {
> +       if (rte_eal_primary_proc_alive(NULL)) {
> +               rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL=
);
> +       } else {
> +               /*
> +                * If primary process exits, then all the device informat=
ion
> +                * is no longer valid. Calling any cleanup code is going =
to
> +                * run into use after free.
> +                */
> +               fprintf(stderr, "\nPrimary process is no longer active, e=
xiting...\n");
> +               exit(EXIT_FAILURE);

Indeed, the idea for monitoring and finding if primary is still alive.
When we exit, should not we need graceful exit? If yes, we can not simply u=
se `exit`, but need to use `eal_cleanup`.

Hence I request for rework with cleanup.

NACK: Vipin Varghese <Vipin.Varghese@amd.com>

> +       }
> +}
> +
> +/* Setup handler to check when primary exits. */ static int
> +enable_primary_monitor(void)
> +{
> +       return rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary,
> +NULL); }
> +
> +static void
> +disable_primary_monitor(void)
> +{
> +       rte_eal_alarm_cancel(monitor_primary, NULL); } #endif
> +
>  int
>  main(int argc, char** argv)
>  {
> @@ -4363,6 +4397,12 @@ main(int argc, char** argv)
>                 rte_exit(EXIT_FAILURE, "Cannot init EAL: %s\n",
>                          rte_strerror(rte_errno));
>
> +#ifndef RTE_EXEC_ENV_WINDOWS
> +       if (rte_eal_process_type() =3D=3D RTE_PROC_SECONDARY &&
> +           enable_primary_monitor() < 0)
> +               rte_exit(EXIT_FAILURE, "Cannot setup primary monitor");
> +#endif
> +
>         /* allocate port structures, and init them */
>         init_port();
>
> @@ -4556,6 +4596,11 @@ main(int argc, char** argv)
>                 }
>         }
>
> +#ifndef RTE_EXEC_ENV_WINDOWS
> +       if (rte_eal_process_type() =3D=3D RTE_PROC_SECONDARY)
> +               disable_primary_monitor(); #endif
> +
>         pmd_test_exit();
>
>  #ifdef RTE_LIB_PDUMP
> --
> 2.43.0

