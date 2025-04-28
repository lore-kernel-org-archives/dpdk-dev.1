Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221AFC36005
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 09:27:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 256EA4021F;
	Mon, 28 Apr 2025 11:27:39 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
 by mails.dpdk.org (Postfix) with ESMTP id 02BEF40156;
 Mon, 28 Apr 2025 11:27:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTKGBWqA7jxA+uBtgbiVdKzzgD2oMtb6x882zTcyTm/LmSTjqCUg4blYnphxkU3ADh+gs3LTXuPFUaA4LEYHROhrICwqE5M+BP+JvwYq/97F0adYgnkMkIaEgvE7bACeQPXR8RBi63xi2fVNhJU6Ob0anr7XdITm7b17D5yqcpRiaD4CI6QsntrkbtpCtDQxOhgVHwQfK+josw0YijVHLTbptn78qgAhvZEDR7ybXHsYHbp1GKWd+Su+VguhYQTLQ9RTrln69qlGXVkncusYKdot//1oPcX4/C7JW/VBk5u4r7HRofaJ7XtEp9ZPqn3O7M+EuBKdn7XakoLQWn7QXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNCiPKvact06t5oyuIxMmzwtvV6VjkAk2GJnSzPyGB4=;
 b=b8fo38SxU/9caH3/nHU2MzylGcin0BZgPZLHxu+mJwj09t36QUNYvngubMg9HypzZ59uwXeGOptnEK4Hl8SWqfUUPSLGQDc2b2aVZlnDVzyLI/r4rxrt5t378Em0ZJynmQpZlLQqqOPRfe9HWxE7RlCmSvdXn6/TeRxNL9y6/YCTMwFb1jo5v33cRLIYxF7AUlCnWx/6iYBshMFzs5jqN5ZWLsaZwe6hkmDgJZI176zYB5gUZxQh2cLbcFI4CEeGjn7C1GU/l3URWMvkt0w3sz9PHCYn/XxgYKHv6ECLw6k2KQKAeaNfdc/UfNphnLIyxr/BZXVcHDuYjzUI3uVDqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNCiPKvact06t5oyuIxMmzwtvV6VjkAk2GJnSzPyGB4=;
 b=EO26bAfQzcxrFogghfIi5tlB7U0SoZgx7WOFHQNgfDB4Pxo3I+h2QS+phsq6K+xv505CF+GLutZuFAJy3ABOIK5sH9qpm8KI8P5gs2TBYS7FPvR4m3/vVnB8vDbmTi5j9BXXyOSoGKmWO7oNVYMrE5eqEkrL4dIdFRYNTwXy2QoRytcXJZLEEhoyBdRGcTskllpcRwbbKurHYOiSAyaUrZJVDuP42zH5LW/lJm4ZuV6JDACPcbDKiN23OH7EP+t5H2KbVNT5ujLWj16Vt6z1JYiUBeHu/dErXN2Gz8Op2UTVaA2CIcdt9ccjYZXq/mMe0/1rbJHiSVgimqzjldYWGg==
Received: from CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 by SJ2PR12MB8873.namprd12.prod.outlook.com (2603:10b6:a03:53d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 09:27:32 +0000
Received: from CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42]) by CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 09:27:32 +0000
From: Xueming Li <xuemingl@nvidia.com>
To: Ali Alnubani <alialnu@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Abhishek Marathe
 <Abhishek.Marathe@microsoft.com>, David Christensen <drc@linux.vnet.ibm.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>,
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>, Raslan
 Darawsheh <rasland@nvidia.com>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>,
 "benjamin.walker@intel.com" <benjamin.walker@intel.com>,
 "qian.q.xu@intel.com" <qian.q.xu@intel.com>, "yuan.peng@intel.com"
 <yuan.peng@intel.com>, "zhaoyan.chen@intel.com" <zhaoyan.chen@intel.com>
Subject: Re: 23.11.4 patches review and test
Thread-Topic: 23.11.4 patches review and test
Thread-Index: AQHbsshe9/Ee4Q0AZUuPVFwM3IIB27OzORaAgAWgaBE=
Date: Mon, 28 Apr 2025 09:27:32 +0000
Message-ID: <CH3PR12MB8658570539F2DBB6934887C0A1812@CH3PR12MB8658.namprd12.prod.outlook.com>
References: <20250421141920.622156-1-xuemingl@nvidia.com>
 <cf8f3b95-d55d-4e1d-836c-910c06638a33@nvidia.com>
In-Reply-To: <cf8f3b95-d55d-4e1d-836c-910c06638a33@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8658:EE_|SJ2PR12MB8873:EE_
x-ms-office365-filtering-correlation-id: 2aead2a1-7769-44a8-8c50-08dd8636e74e
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|8096899003|13003099007|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?tRycLIy9m7mvsMrUW2VqOz22sWZS6LBBbUizDjwk8a3zujV0LWtd6HO9qyxc?=
 =?us-ascii?Q?tUo8K0gBx6LqoSi6iFTKUFdS7CcswVfJHbElB5Z8IZYQM8ecTpocemnW5f1n?=
 =?us-ascii?Q?Otudmq2aqbuvp4ayLMHUSccoqYE3tPsP0/PUsFCpvmTLBt/FqoSABZ3/10SZ?=
 =?us-ascii?Q?WVNSKe7yxNf64uGpx5T3u58/toEJ/wvt5uqFG8Pflz5dYZEBvwFQcsYYzv3h?=
 =?us-ascii?Q?SFmfOxYUTT1vwUM9Ylrdes7I9OQctO6Pmi+q8eEUrK5Yh2ZKDWxDPNB4Ikon?=
 =?us-ascii?Q?5xz7LMOJVBS6bNkpKaHpgMtETqZ6XAA6R/OFnsKdX0K2pK2Z5QQG5tR6vbcb?=
 =?us-ascii?Q?p4jGGHquNv3AF06qTAMV08Pl/7zOil4m5AOlyi1oVRmvrK+Opfw5ot5AaLo4?=
 =?us-ascii?Q?pwrECD/heUbyUfLvxEnJdaDeoWGNa0+JfE/TwrqPmQH8ulE19gVLwPqB9YPR?=
 =?us-ascii?Q?3I7/9QMti+TtdiA7zHD8CK7EqyFtTkfTPVmojlnvgLwRlI1V3HEK+xOX62W9?=
 =?us-ascii?Q?w93mzDCufCdfIgt1IKW/z8mRwigMa1R5t2HzgmGoPuvSPgvuINSPF2A/2oKA?=
 =?us-ascii?Q?INvfL/XP+33I7I2yglg7VbOw50VIQiBnKft4pqFF5RllivY9ncS/dMXaRFbh?=
 =?us-ascii?Q?/+4tyOT9+VUNfN+odELh504V4918uAhnHwnhmqCz8242DNZoAr5ya/+8EliY?=
 =?us-ascii?Q?Mj3bHJSKQrXPjJUN0MyzJMQPEjm4p4yD9JtsOH+yGaYhSj1gJmFfQmOxrIa1?=
 =?us-ascii?Q?/YURuesoI24hofyBlpbIFma2zZilUuh0DtlvjRuB94vcd4OGK09o5fT+u5AY?=
 =?us-ascii?Q?yXwkKha7paENdVqWGtmZypS+a+XIOTFiPMokpywlJ7AMb8AG3I9IuTSp/2I7?=
 =?us-ascii?Q?ObQhTE8OsnNvICySGxsKnTnSvS/++GCm6hY0mAQBT8vbD4iSm2jiHk/aPt4z?=
 =?us-ascii?Q?bWvAuAzJQV/zSBeYOPswvY//17N558k0kluGwL9tENPBkaneK5qynsRFkm2s?=
 =?us-ascii?Q?ShQccGB1Bl0ienvBkak1S6s72PPGbhCt+M5JZPB10WaHpwMJGDaaXgrCfncH?=
 =?us-ascii?Q?Z1mwEDL9dg40Bt+6QrFtaXwFvhh6dFpJCPv1XegKdS5invkc3LAbIapydlaU?=
 =?us-ascii?Q?JhvThveRKUXCTgNWsOzNQ3HzS8o/TM9bsJh1gGHb4uOPuMWxLWR6U+suRDVz?=
 =?us-ascii?Q?6Gc3YYAaoxsfGChUTtHilryfPNcXdJv26Hyl2zsP6BMTMj3OG5G2jJg2VQMg?=
 =?us-ascii?Q?C5tJtDWwLQ4VJjW0WSobZmN2CnLaXuwX2zxOqDZEb2+ZOPV2mEVfW+98IXap?=
 =?us-ascii?Q?5PvKNKQG88juhq9GmVf2hf3BH5l8MkTtPVnNYsREDUQwIw2QHqqSQhUYsKUf?=
 =?us-ascii?Q?TiA/rDnMuQX9rq6VozhaeNnq1zCx58hYp90fN5VRKi9YtMxFv372qQKj+ieV?=
 =?us-ascii?Q?RmN0Dc2KJrfiCq+iNKri9Thc5fOYSaT1n3eOYqSPQO0tE5Bzs/01QoIMdriR?=
 =?us-ascii?Q?5b8lbeelKtSYypk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8658.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(8096899003)(13003099007)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wmZTC9t6WFVeEYxAtQQpm0YBTqilFSlX6K3zwKc3ALcTvCdtA0PLt7r76lld?=
 =?us-ascii?Q?YM8GJEcIFeu943KwvSDpZHmyG4seZWHe89WE370jlMLg7zIbbpdru8mhRXET?=
 =?us-ascii?Q?v8VWQb4vRiPZ7jMEvCZQ95fUwKqYOE3q4fikYHjwd6htGjQrxoVoNECBZgzd?=
 =?us-ascii?Q?CaVBVUlwCpAXK6EEz9TjnMhb39IqpwgqNkINg8Een2e9vh4OHkn/nd+pyrDP?=
 =?us-ascii?Q?ndmWrptT30hTjUIeUgSK+Z4cooydAu3bhQjnXJlh6CCNWtyT5SXmN3wuL6og?=
 =?us-ascii?Q?miJUEzKFoYGjz7r8vLe3oLM7vEJsUlxeWzF/IZbe5u6Bv7Q2DKYnNPccCnqC?=
 =?us-ascii?Q?x0PUncQJDVVmaQqKIVqwAkl2WWUJe+3vHLcz9ZSW/nzkIA8oCD9R7ZSWCn4m?=
 =?us-ascii?Q?nho7noWBnAimcXwOF9aee+ebarjRAsQ16Y3ikpi5bP2uLY0S+QexUG8JPIpp?=
 =?us-ascii?Q?zjMva6PRlotD8LzvOo6aBI4lMHiU6xGpHg+p2zyitOAWiAvdp1Zn44fJZ0Ak?=
 =?us-ascii?Q?DTW1PzIBiU7Lek10D57hYxupTMBQF1TN2K/MlPnyGqpOmB0t28WABM2Vxxo1?=
 =?us-ascii?Q?ShkBYcET2+mjNfqbmaR5TpcCHObSM/MUHzBUCTfgmLD/RoAeg8ERgr8uugtO?=
 =?us-ascii?Q?tJ0dgx38uCJBr5Gs/m54JPp/qSlr+7unHd9ikwKUrIvuFyfbXN9Wjt10IzlQ?=
 =?us-ascii?Q?KNTv18wdSNy36QRleebc5mL1RfCTLpBi2Y5uIn8jjdT6rgGwVAaGA+MqpbIB?=
 =?us-ascii?Q?NprWBQX+H70dF3W6BYS5rgP3J5Ijg3rype2jEbcbr8HXAbKPbp9atAgtheJ/?=
 =?us-ascii?Q?i1gJ4XZLaBO8bjx9QjCnthukRFUsctrt9XDl3QRI+3NuKk5zx3DM42JO7fsa?=
 =?us-ascii?Q?/aZsgLkcJzTZvWCARJ8hi5oGNlbuXoru+oIkp1WGqBmPHhH9Pp4sMY1Qqm6E?=
 =?us-ascii?Q?fp+vfiJcavPAAg3aGLuKdLopRXq09dSH1hlzz3mZI5fWXUXnXF3fCikyYw2i?=
 =?us-ascii?Q?NQYzVVbuRNMNnDhRDDsKQN1yWbs15nGRQlyEkdSTPTtIhHT7r9+kIWfpSwOV?=
 =?us-ascii?Q?+Mq9Creifcqz/dU/gcnxocKzFT1Oq5bI4TsNbnvj2LWshI1puiaHnb0jlqMg?=
 =?us-ascii?Q?cMYBOanGD4U+SUdHgLDWvY15kqEreQthBzTSDx89VuWjcqTn9L0HHFAim9JU?=
 =?us-ascii?Q?I276FFqDnujqpjLeSlikEl37AOvEminNRhpLpYob45jC5CvbySrAuKKWF8wB?=
 =?us-ascii?Q?KSH2wSIFfvqaEzxgxDXzDaWFG+viEKZClp5sbbewGSDRpD3fIWE0QxZQEz81?=
 =?us-ascii?Q?lX4tPvmeFeKb70oe9U7ynQ+AbOc770Vs4JoGVihOh0F7khOB83Y+OWWK1T2M?=
 =?us-ascii?Q?2S7d0Szgsqj4CDR3kLiYOhabaSVx3Tt/f2l676xMW2ZWl/Dbd0+yIMAO9J6F?=
 =?us-ascii?Q?FOJiAnECwlkLcogTZr8z6Af+K8vKm2SPTqh99zYhu265yf5axLjyBu+PNQYJ?=
 =?us-ascii?Q?xu07fWGKAwXzmlPIdriAqSG4JxVIzK9+/5KwXeCqsGkF6uM8UWXXrmnWVUvq?=
 =?us-ascii?Q?hjq0zocGg0vDLjtnKwH7tvgnyRzvQUmex5nveyat?=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR12MB8658570539F2DBB6934887C0A1812CH3PR12MB8658namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8658.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aead2a1-7769-44a8-8c50-08dd8636e74e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 09:27:32.2588 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OJ7mTT8Y2AKoNl0AebV5TSdhoVGS0RaFTaspzY4FTvK8t9zmd5k4TT93MJSkFCIFrEceoQsNv+7VlXyrEjRGvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873
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

--_000_CH3PR12MB8658570539F2DBB6934887C0A1812CH3PR12MB8658namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Ali,

Thanks for your support, will collection into release notes.

Regarding the gcc 15 warnning, it's a small issue, I will fix it in the nex=
t release.

Best regards,
Xueming
________________________________
From: Ali Alnubani <alialnu@nvidia.com>
Sent: Friday, April 25, 2025 3:30 AM
To: Xueming Li <xuemingl@nvidia.com>; stable@dpdk.org <stable@dpdk.org>
Cc: dev@dpdk.org <dev@dpdk.org>; Abhishek Marathe <Abhishek.Marathe@microso=
ft.com>; David Christensen <drc@linux.vnet.ibm.com>; Hemant Agrawal <hemant=
.agrawal@nxp.com>; Ian Stokes <ian.stokes@intel.com>; Jerin Jacob <jerinj@m=
arvell.com>; John McNamara <john.mcnamara@intel.com>; Ju-Hyoung Lee <juhlee=
@microsoft.com>; Kevin Traynor <ktraynor@redhat.com>; Luca Boccassi <bluca@=
debian.org>; Pei Zhang <pezhang@redhat.com>; Raslan Darawsheh <rasland@nvid=
ia.com>; NBU-Contact-Thomas Monjalon (EXTERNAL) <thomas@monjalon.net>; Yang=
hang Liu <yanghliu@redhat.com>; benjamin.walker@intel.com <benjamin.walker@=
intel.com>; qian.q.xu@intel.com <qian.q.xu@intel.com>; yuan.peng@intel.com =
<yuan.peng@intel.com>; zhaoyan.chen@intel.com <zhaoyan.chen@intel.com>
Subject: Re: 23.11.4 patches review and test

On 4/21/25 5:19 PM, Xueming Li wrote:

> Hi all,
>
> Here is a list of patches targeted for stable release 23.11.4.
>
> The planned date for the final release is 25th April.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>      https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv23.11.4-rc4
>
> These patches are located at branch 23.11 of dpdk-stable repo:
>      https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Xueming Li <xuemingl@nvidia.com>
>
> ---

Hello,

We ran the following functional tests with Nvidia hardware on v23.11.4-rc4:
- Basic functionality:
   Send and receive multiple types of traffic.
- testpmd xstats counter test.
- testpmd timestamp test.
- Changing/checking link status through testpmd.
- rte_flow tests
(https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-offloads)
- RSS tests.
- VLAN filtering, stripping, and insertion tests.
- Checksum and TSO tests.
- ptype tests.
- link_status_interrupt example application tests.
- l3fwd-power example application tests.
- Multi-process example applications tests.
- Hardware LRO tests.
- Buffer Split tests.
- Tx scheduling tests.

Functional tests ran on:
- NIC: ConnectX-6 Dx / OS: Ubuntu 22.04 / Driver:
MLNX_OFED_LINUX-24.10-2.1.8.0 / Firmware: 22.43.2566
- DPU: BlueField-2 / DOCA SW version: 2.10.0 / Firmware: 24.44.1036

We saw functional test failures caused by environment changes, but
didn't find issues caused by changes in this release candidate.

Additionally, we ran build tests with multiple configurations on the
following OS/driver combinations:
- Ubuntu 22.04 with MLNX_OFED_LINUX-24.10-2.1.8.0.
- Ubuntu 24.04 with MLNX_OFED_LINUX-24.10-2.1.8.0.
- Ubuntu 22.04 with rdma-core master (324c42e).
- Ubuntu 24.04 with rdma-core v50.0.
- Fedora 41 with rdma-core v51.0.
- Fedora 43 (Rawhide) with rdma-core v56.0.
- OpenSUSE Leap 15.6 with rdma-core v49.1.
- Windows Server 2022 with Clang 16.0.6.

All build tests passed except for gcc 15.0.1 on Fedora 43, which failed
with:

lib/ethdev/rte_flow.h:886:36: error: initializer-string for array of
'unsigned char' is too long [-Werror=3Dunterminated-string-initialization]

Thanks,
Ali


--_000_CH3PR12MB8658570539F2DBB6934887C0A1812CH3PR12MB8658namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Ali,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks for your support, will collection into release notes.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regarding the gcc 15 warnning, it's a small issue, I will fix it in the nex=
t release.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Best regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Xueming</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Ali Alnubani &lt;alia=
lnu@nvidia.com&gt;<br>
<b>Sent:</b> Friday, April 25, 2025 3:30 AM<br>
<b>To:</b> Xueming Li &lt;xuemingl@nvidia.com&gt;; stable@dpdk.org &lt;stab=
le@dpdk.org&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Abhishek Marathe &lt;Abhishek=
.Marathe@microsoft.com&gt;; David Christensen &lt;drc@linux.vnet.ibm.com&gt=
;; Hemant Agrawal &lt;hemant.agrawal@nxp.com&gt;; Ian Stokes &lt;ian.stokes=
@intel.com&gt;; Jerin Jacob &lt;jerinj@marvell.com&gt;; John McNamara
 &lt;john.mcnamara@intel.com&gt;; Ju-Hyoung Lee &lt;juhlee@microsoft.com&gt=
;; Kevin Traynor &lt;ktraynor@redhat.com&gt;; Luca Boccassi &lt;bluca@debia=
n.org&gt;; Pei Zhang &lt;pezhang@redhat.com&gt;; Raslan Darawsheh &lt;rasla=
nd@nvidia.com&gt;; NBU-Contact-Thomas Monjalon (EXTERNAL) &lt;thomas@monjal=
on.net&gt;;
 Yanghang Liu &lt;yanghliu@redhat.com&gt;; benjamin.walker@intel.com &lt;be=
njamin.walker@intel.com&gt;; qian.q.xu@intel.com &lt;qian.q.xu@intel.com&gt=
;; yuan.peng@intel.com &lt;yuan.peng@intel.com&gt;; zhaoyan.chen@intel.com =
&lt;zhaoyan.chen@intel.com&gt;<br>
<b>Subject:</b> Re: 23.11.4 patches review and test</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 4/21/25 5:19 PM, Xueming Li wrote:<br>
<br>
&gt; Hi all,<br>
&gt;<br>
&gt; Here is a list of patches targeted for stable release 23.11.4.<br>
&gt;<br>
&gt; The planned date for the final release is 25th April.<br>
&gt;<br>
&gt; Please help with testing and validation of your use cases and report<b=
r>
&gt; any issues/results with reply-all to this mail. For the final release<=
br>
&gt; the fixes and reported validations will be added to the release notes.=
<br>
&gt;<br>
&gt; A release candidate tarball can be found at:<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://dpdk.org/browse/dpdk-=
stable/tag/?id=3Dv23.11.4-rc4">https://dpdk.org/browse/dpdk-stable/tag/?id=
=3Dv23.11.4-rc4</a><br>
&gt;<br>
&gt; These patches are located at branch 23.11 of dpdk-stable repo:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://dpdk.org/browse/dpdk-=
stable/">https://dpdk.org/browse/dpdk-stable/</a><br>
&gt;<br>
&gt; Thanks.<br>
&gt;<br>
&gt; Xueming Li &lt;xuemingl@nvidia.com&gt;<br>
&gt;<br>
&gt; ---<br>
<br>
Hello,<br>
<br>
We ran the following functional tests with Nvidia hardware on v23.11.4-rc4:=
<br>
- Basic functionality:<br>
&nbsp;&nbsp; Send and receive multiple types of traffic.<br>
- testpmd xstats counter test.<br>
- testpmd timestamp test.<br>
- Changing/checking link status through testpmd.<br>
- rte_flow tests <br>
(<a href=3D"https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-o=
ffloads">https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-offl=
oads</a>)<br>
- RSS tests.<br>
- VLAN filtering, stripping, and insertion tests.<br>
- Checksum and TSO tests.<br>
- ptype tests.<br>
- link_status_interrupt example application tests.<br>
- l3fwd-power example application tests.<br>
- Multi-process example applications tests.<br>
- Hardware LRO tests.<br>
- Buffer Split tests.<br>
- Tx scheduling tests.<br>
<br>
Functional tests ran on:<br>
- NIC: ConnectX-6 Dx / OS: Ubuntu 22.04 / Driver: <br>
MLNX_OFED_LINUX-24.10-2.1.8.0 / Firmware: 22.43.2566<br>
- DPU: BlueField-2 / DOCA SW version: 2.10.0 / Firmware: 24.44.1036<br>
<br>
We saw functional test failures caused by environment changes, but <br>
didn't find issues caused by changes in this release candidate.<br>
<br>
Additionally, we ran build tests with multiple configurations on the <br>
following OS/driver combinations:<br>
- Ubuntu 22.04 with MLNX_OFED_LINUX-24.10-2.1.8.0.<br>
- Ubuntu 24.04 with MLNX_OFED_LINUX-24.10-2.1.8.0.<br>
- Ubuntu 22.04 with rdma-core master (324c42e).<br>
- Ubuntu 24.04 with rdma-core v50.0.<br>
- Fedora 41 with rdma-core v51.0.<br>
- Fedora 43 (Rawhide) with rdma-core v56.0.<br>
- OpenSUSE Leap 15.6 with rdma-core v49.1.<br>
- Windows Server 2022 with Clang 16.0.6.<br>
<br>
All build tests passed except for gcc 15.0.1 on Fedora 43, which failed <br=
>
with:<br>
<br>
lib/ethdev/rte_flow.h:886:36: error: initializer-string for array of <br>
'unsigned char' is too long [-Werror=3Dunterminated-string-initialization]<=
br>
<br>
Thanks,<br>
Ali<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CH3PR12MB8658570539F2DBB6934887C0A1812CH3PR12MB8658namp_--
