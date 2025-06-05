Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98042C5B543
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 03:06:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF309402E9;
	Thu,  5 Jun 2025 05:06:36 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
 by mails.dpdk.org (Postfix) with ESMTP id 069AA4028E;
 Thu,  5 Jun 2025 05:06:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWsnVlSCfbBMPiLpStS/uTUjbCdOxvdIuKPPFVuLZ/6KLvjrOFLNjyTI7vtAn03qP77oTXYMv4bZNInvwaj3z4JHKqgAQPXhRqQ6Zur1Xw8xRO1JLBW9Agao+g4rJ6cXGExo9pQuFaD76zl/gDv244HYXKHHE82upnc2nwTrZDXQBZ9dpE5dgfKED5mcEzs7E/C1lLtw1WIxiYDcfnsTxoWXoIlH5/Il0KtK7VZEFS5yDr3Uehi/BUKfhvA1qWr7qk6YfvLMnjXOpF6KBW6TLJtr04/BnRQNVd67t4jNGtsiptRjEoDy2Th42ZR/5XHWWKLYY86sqY99rK4qy77IGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eggip7aCsqpVPXD7FW1hx+KHMw8pAn7F08X55DuYZKM=;
 b=knNxrwg12n8Ztpr+QAyFT4h2tOmQ1ZydsYj2/kwWcCu3JzicHMCm2xgkXnURB/Pz2mCcmTemljYKyEKmmrUW+DObmH8PDh89lllTNc5z14FSBx2Udc6uODlFXXQS742FtpPdbyiEH3Ie4z2fAk4qtzCOnajp7fluLFYI9kv0puUMZhj6QlUnCnwAE3OKJ8ikPzo54vtx368qsQLpB4alBlNYZT8hx+1LlLoATAbNaWallhW8phUeWyAZ8Hkufl1RcYfGugSQqGHBnazjVJFUEyEvL7UwlnopiKs1RI6n4lDzPFy3n9/fmbt4a3TalZ/bvpV9vMYRlNanTbL8j71Bfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eggip7aCsqpVPXD7FW1hx+KHMw8pAn7F08X55DuYZKM=;
 b=CYcq+Kv8Cxv2CXVioc+QJ8o0pUtWlIDJ5Darrsrst00sthzLIUxyw/j/+QfQ3riy+Y/TIrk4Xc5oFbrjeJKmat491h97vf1eRaeRwx9btefr8VTWE8dNwXzbn5KxsqtfnJSVRHWf54h3bw5Mm7zOU4iajC27nsTSERm7p7GLuuk0ar3XmVv4tSbqVm62Blh5apLRL9ch5dd9TSIMt8UXA6q2KiFeTEaTDJh6qKcSAjqDdh4Gi0AUWJa2gT4qcYB6T5V2o2HuBZ/aQmeaGP0qsp+5jYxRWyUU0HPaSmnpGEHO2r/UGbn9wBXfMG3CyJZBHNCSQbiAiZJawLJblBuX9w==
Received: from PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.34; Thu, 5 Jun 2025 03:06:32 +0000
Received: from PH7PR12MB6905.namprd12.prod.outlook.com
 ([fe80::33b4:19c2:2281:b662]) by PH7PR12MB6905.namprd12.prod.outlook.com
 ([fe80::33b4:19c2:2281:b662%3]) with mapi id 15.20.8769.031; Thu, 5 Jun 2025
 03:06:32 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Slava Ovsiienko <viacheslavo@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Raslan Darawsheh <rasland@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2] net/mlx5: fix hypervisor detection in VLAN workaround
Thread-Topic: [PATCH v2] net/mlx5: fix hypervisor detection in VLAN workaround
Thread-Index: AQHbR+rmXoe+lXFG10mmx3kbEoqAhbP0/Zxg
Date: Thu, 5 Jun 2025 03:06:32 +0000
Message-ID: <PH7PR12MB6905E224F086AFEB211336A6D06FA@PH7PR12MB6905.namprd12.prod.outlook.com>
References: <20241203162200.2543986-1-viacheslavo@nvidia.com>
 <20241206142605.2582139-1-viacheslavo@nvidia.com>
In-Reply-To: <20241206142605.2582139-1-viacheslavo@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6905:EE_|DS0PR12MB8296:EE_
x-ms-office365-filtering-correlation-id: 11e9889b-c732-4d8f-deec-08dda3ddf94b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?H7Bx7UUBS5dIvbHzuYV7ksw/KXXXg2ixLFbJ0fK/N4dwGH85RRvI5VyM9wpp?=
 =?us-ascii?Q?Lfj8xReHo6OXBPcDf28t6LoxcoKMk3JXZPaJcM8iOmGxLXi927mns0nsNr2H?=
 =?us-ascii?Q?BLrQaD+yJAXM9RbW9Cn31y/u5CtUgs3ZSJlJgStPQDV/1Azb6WMBhzr54lBs?=
 =?us-ascii?Q?JxwY1ZiWi6IsTcVyI9XNOi2b3CH5dTeytOgqahTIq3bo+yhonUskF4OSepPS?=
 =?us-ascii?Q?79mghsG/YLAwi15LC5C8lUOy/9JeZVIxRIX56pDKQiYJQQCCa6+kWn7Y6EAw?=
 =?us-ascii?Q?lbrePFYFpGLSJ1s8x1O6LjiBhINX7wrvBSn3RVaP3DxjtVz92bC59wy4ANvy?=
 =?us-ascii?Q?eai+n1P3BfRYcl+ccP4/0wcn11W7rAEGIJLzMJTPItPX1B9lVgYuRnGjeIfw?=
 =?us-ascii?Q?fNiDaQEmdMZvbzpyxCa11/CTn2hj8mPRf8l0Oi+kaIphLAOAAmbrCoCMY9I/?=
 =?us-ascii?Q?ORFtNGcdkwVFQYAag0rqwR7KUDt2NkUEqLuOaw1eBk7X3F0vca7xOY9mOYEi?=
 =?us-ascii?Q?msmwcuNB1xLM8HgTv6zINGvj7pSjEkqvA6NpQcqkdEKujqBGdkEwDGLvvxC1?=
 =?us-ascii?Q?4YOkVGK9X5GnKPAxcll60KXsatYraZWJDqfTwGT0Rif9241Juj+SA80zS3d4?=
 =?us-ascii?Q?gdonRT+EDC2ORWkdjVw+mN0RTovWqhkbD57+GBExzTu6w3pZCAL3zTSwBZYY?=
 =?us-ascii?Q?i1bXn60XW4xaY6dFpjvlvMIMK62GD2DpTBrSD02eyFNgnxnmyvfjby5a1Cdn?=
 =?us-ascii?Q?cTTj0g4rEdi8SOb7Fj/lysObi/fpAMOpArW4wLreFYrklY+mMvwdHGLq3FfK?=
 =?us-ascii?Q?Ivvqm4leBBg/B3VB+IZPCLfnCaXmOG801igrR7FY+TEluexXDt5+sU/Doroq?=
 =?us-ascii?Q?tPNLxnwDNMQ5QOGZJtEYWNac9WWn1eSIbcIp5gXavGHjCBQo1G9cImtVvfZQ?=
 =?us-ascii?Q?q0+VLI8doik88l1L27wQUN3TVtiP4Mc6qGmLafPAUT+JGK1rP2Dp8zpjJFBX?=
 =?us-ascii?Q?seiq/nKi5voT59Q2FBW/Lo03+HS/VOMm73R1AYFTqO51fzzQhuJft/2bQaH2?=
 =?us-ascii?Q?TmjMysMDUQppzVFy/6Ii92ZXtGQSDmOVyo09O2gJE9qG/w5682kCn3V3H7sy?=
 =?us-ascii?Q?yTa/dzUyAM20euhZSgPoIvavR3AY+OPZTCr8Gtap6p4pPVaAQToTFN0XaqwV?=
 =?us-ascii?Q?6baXqxfe/qgzSH/OV2nECEP+I+7g1ozphMcVoFJkctzSxQY+adhZnBPw8IE/?=
 =?us-ascii?Q?iIWULf2lcj1hqZNSm/y3dfnWR5OYg1V2ULpR2vkpBOl1oy4UZB8+f6GkoSlt?=
 =?us-ascii?Q?8Uigbpzq4gwXTABBdHbZYyKDd76bQOib9QnOdXV6GT+YAu/TQHYqs6VZx8p2?=
 =?us-ascii?Q?ikfHO2BYbNXcVSskoDr6mbl7k3faGhlJWo8tUSdhka33DLyd8iAqh6z0StHL?=
 =?us-ascii?Q?3hgV6LiIeGiynyBhOaMXbWooOQsZg6AywILsqBJWI896U3M0tgNNGKvvTuM9?=
 =?us-ascii?Q?62pknUukGGJVbwo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6905.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IQi0KNwpTNGWihJuFKsgGzbcWTTtIYhLAiEmVM8j7mZjrFmsNCeL3YFwBPVT?=
 =?us-ascii?Q?kWvIXiaWE70yY2BAHQcxn5+pqf6BnGJiVgkJAh7Oed3TkGWF/kBzakrKuZir?=
 =?us-ascii?Q?Pz91I0TE7ZGaU/ycAfj6l9j/cFKNg1A462AtqB4xjJMivkZD0zsYW0FEYuV8?=
 =?us-ascii?Q?bHjqK9pkoFGzcZx7x/39Mt3hjJZSmTFMwNe+LJhgDZPvmltYdnj+x8oRXj7v?=
 =?us-ascii?Q?gwtKt56f5r3qYR44nIE2N7/jk/cuU8WYCoR6HtMNi2wGY1hZIYEU3PQiAEAl?=
 =?us-ascii?Q?j1yizK+vQ2JFyGqtcBQapPUzS4m3NZZYO/jtuPlxwLg70NEJWATK6K4OASwl?=
 =?us-ascii?Q?whog6Vw3MyceHvQ8pEs6P4uuuKKelCVGo6pXYPUMtre5AvZF6xQ8vykyeeFM?=
 =?us-ascii?Q?m2yhOa0xt2OsiimN6RjyhMPn6ejk+MvQp/aOdYvJGESEE5iIpOkiiw+e9XYG?=
 =?us-ascii?Q?TTBFfFjm17bVdLF/1qZxTtOcPW+Vk/EQ73xHPc8vZ8r4j5i8j/tfWcasxHKA?=
 =?us-ascii?Q?iQfDGEduhEv9WPeETqGBBKo+55jr5DoL57xjtZEINALyHgoILMirvv5Ugu8t?=
 =?us-ascii?Q?QrFHjhuWtbwFqS6k+QBSVMSTiLHSGSl35ru2HCiu24Irjc94oOOU+4YJt8UI?=
 =?us-ascii?Q?J1JEKR9IeVUjVAW1KjinDTSWwLUZDUmihFk7zFlnb8bJk89PTiMhpHcq3VCT?=
 =?us-ascii?Q?OAOr2jsATLcFEY1R6PD7vO/7MqgtB8Z7uNKjxCfWv35ID0lXyXc3OFPInykL?=
 =?us-ascii?Q?Em9AfJCEThcI1prkvOfRILlJTM9niE+KbfGtrpO49VZ9T7FcBx+zaJ4GCDMJ?=
 =?us-ascii?Q?43CPgmGOCFSevg50K5V2BNl4q4EVMoNPkzp/jPb4NTVVYul6mKRaJ1utoigW?=
 =?us-ascii?Q?ncuiAh2K4HwpwmysyFshMOOzNThDFtSMRcK5ctlsHBDQebxRbpxtkwJSrFEV?=
 =?us-ascii?Q?6IigfrJY/r7CMkt8anor/aCtVYepuZL50VDszl5HmLWAEfLZAA+eCynralUi?=
 =?us-ascii?Q?f6qUH+kpbGgUF0QmgemqskThscG0cawdkTJeAWA1osHguTsttfaDqP5KIkp+?=
 =?us-ascii?Q?aGD3rj2WArCydGWalzw5F8VCBgxZOFgrHxOwEIqxN+7lw7AcZSZImQwo4pXG?=
 =?us-ascii?Q?yV6jV9ucJCXUZYUoSCAFXcy4Xq4+xxruYx/Zp1LbrrKmsP6iasJ3j87hFr/x?=
 =?us-ascii?Q?+ttuxczdixqakGiHHDNG01bcPY813nIWNEMeV4xxeCqtNmpzywDLYS5lv8oF?=
 =?us-ascii?Q?4DPNJA/JO8x86wtvnw+92yUz23A5d+IDoUTzKNGvss6N2AVE6XxUE7WbT7/3?=
 =?us-ascii?Q?gnRJyXZqQDs652M5melMfxHwIIG/vO6BcKkcnpFmGOT1en8g2xhzrt6R/rqx?=
 =?us-ascii?Q?1PUUPa7OkL5EExMDEu4Q+mkpcxs1ORKXYGMGPeiO+P/wvTipx5+3TV+1lubf?=
 =?us-ascii?Q?9hSAd3neDYoGADzdvu7X0plVcpSLAa5bEj0PT5o2QswvIc+IZxFNMfdhECxd?=
 =?us-ascii?Q?n+yZIoELLY3KdFS5y1k51+eBEAzV3tptV4DUvv/F/Y07NZUG/h2gZs+Q3ZzJ?=
 =?us-ascii?Q?qdy93o0QbtUTmOJ5ZVA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6905.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e9889b-c732-4d8f-deec-08dda3ddf94b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 03:06:32.1698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OCOa7Mc5eQ/eC7HYa6crbZ8I4C78ls/THQBg2l7GCko4g4H94d/ZDj19Uprh3Vu3sYNaXg6S/4eubaMyv5AVCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296
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

Hi,

Since it is only a WA and no need to consider all archs or CPU types, LGTM =
so far.

> -----Original Message-----
> From: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
> Sent: Friday, December 6, 2024 10:26 PM
> To: dev@dpdk.org
> Cc: Raslan Darawsheh <rasland@nvidia.com>; Matan Azrad <matan@nvidia.com>=
;
> Suanming Mou <suanmingm@nvidia.com>; stable@dpdk.org
> Subject: [PATCH v2] net/mlx5: fix hypervisor detection in VLAN workaround
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> The mlx5 PMD provides a specific workaround for the VMware ESXi
> hypervisor, enabling on-demand routing configuration to virtual machines.
> This workaround activates when the device type is a Virtual Function and
> either an ESXi hypervisor is detected or the hypervisor type is unknown.
>=20
> For non-x86 architectures the function rte_hypervisor_get() consistently
> returns an unknown type, which triggers the workaround automatically
> without any actual needs. If there are VLAN support requirements, this ca=
n
> lead to failures in inserting default control flows.
>=20
> Do not trigger the workaround for unknown hypervisor type in non-x86
> environments.
>=20
> Fixes: dfedf3e3f9d2 ("net/mlx5: add workaround for VLAN in virtual
> machine")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
>=20
> --
> v2: updated cooments to remove "white list"
> ---
>  drivers/net/mlx5/linux/mlx5_vlan_os.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/mlx5/linux/mlx5_vlan_os.c
> b/drivers/net/mlx5/linux/mlx5_vlan_os.c
> index 81611a8d3f..353484de3f 100644
> --- a/drivers/net/mlx5/linux/mlx5_vlan_os.c
> +++ b/drivers/net/mlx5/linux/mlx5_vlan_os.c
> @@ -112,16 +112,16 @@ mlx5_vlan_vmwa_init(struct rte_eth_dev *dev,
> uint32_t ifindex)
>         /* Check whether there is desired virtual environment */
>         hv_type =3D rte_hypervisor_get();
>         switch (hv_type) {
> +#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_X86_64)
> +       /* Always misdetected on ARM archs, let's ignore this */
>         case RTE_HYPERVISOR_UNKNOWN:
> +#endif
>         case RTE_HYPERVISOR_VMWARE:
> -               /*
> -                * The "white list" of configurations
> -                * to engage the workaround.
> -                */
> +               /* The list of configurations to engage the workaround.
> + */
>                 break;
>         default:
>                 /*
> -                * The configuration is not found in the "white list".
> +                * The configuration is not found in the list.
>                  * We should not engage the VLAN workaround.
>                  */
>                 return NULL;
> --
> 2.34.1

Acked-by: Bing Zhao <bingz@nvidia.com>

