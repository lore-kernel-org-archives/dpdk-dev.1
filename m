Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B74C5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 22:32:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5E3640264;
	Sat, 15 Aug 2026 00:32:08 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11021129.outbound.protection.outlook.com
 [40.93.194.129]) by mails.dpdk.org (Postfix) with ESMTP id 038B04014F
 for <dev@dpdk.org>; Sat, 15 Aug 2026 00:32:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ns4zHF/TI2x1fRpM+q1gzBLNlq2jDb4AazfNBixLQMFByi+sF/+5xY79W9GFELB29vDb98kRoBnugqBYrtlZqlloETfJGYbji0at+GxZ3ri0LiqaEyxy/g8SCviDbgxYO1DtSsLrsvUv2K6nWYVj060zhfZYIwBRCTirny34HijDWtkx65mD0IClSYUBm2GFtJ4MFLo2bSuW4uHdaQb5CSadSk+ScvWkNt2kn495mVyorWxW7z/SwmWIYeEs/IxbrpXV2DXoqp7dvFkB1d9tksw7wI5v5vWbR4vptHNaTBbPGdjhZBseJ0AuEXNRj9FEYkAXQkeEqVPUV8rWXEHIVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/mDSH09ba0gb5zPJQ8auPslzKh7sOOkMSKPJPXh3RI=;
 b=EpoHXWP5t3N9bP1Jo5yDwxet0irfGIIMjDzLlXNxw/KVcztpsxOIxCPA8dacqcZY1gyqc9ypKxd+6u939vOZGxCwZp3nMwP29XIpuuCPi92B5bUl+WOfgvAnsaNf7XQMds9hjHyRN131wrzCQRJba2pHnDOGFEDPLNSTEBuQUv212OpS1+ySwFe+o5QgTfohBXMTo3haLe76Ts6G1Wjhe1VJXRkMfrnXmidUy8lvqErSLpiv9nHkHnE+PrDxxvMQJh951pA+t7DDo3SlQ7VJkzFEz4FiAYZkTIIU5veJz80Ez1of2DTFsGChF2GOfy1rBxF9llXunxh/dLWaYm2Jlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/mDSH09ba0gb5zPJQ8auPslzKh7sOOkMSKPJPXh3RI=;
 b=YrWHJOcz35og6idRS6q5P590WRRa7bCNyVIHLojXjwyUHu3xNV+OMbKpwWEupQzvfJ57DwGjXt429eW8vs3ZxwXcCDMiJD3qywnomPfiysTpQ/Ps2ysjG413+rkZ5BJBIDrwI/9/HdLWenEoa2SGG5gX1Nff52OEnXG7HfbzKSw=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA3PR21MB5746.namprd21.prod.outlook.com (2603:10b6:806:497::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.1; Fri, 14 Aug
 2026 22:32:00 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Fri, 14 Aug 2026
 22:31:59 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Kishore Padmanabha <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Ciara Loftus <ciara.loftus@intel.com>, Maryam
 Tahhan <mtahhan@redhat.com>, Shepard Siegel <shepard.siegel@atomicrules.com>, 
 Ed Czeck <ed.czeck@atomicrules.com>, John Miller
 <john.miller@atomicrules.com>, Igor Russkikh <irusskikh@marvell.com>, Steven
 Webster <steven.webster@windriver.com>, Matt Peters
 <matt.peters@windriver.com>, Selwin Sebastian <selwin.sebastian@amd.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>, Shai Brandes
 <shaibran@amazon.com>, Evgeny Schemeilin <evgenys@amazon.com>, Amit Bernstein
 <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>, Xiaoyun Wang
 <cloud.wangxiaoyun@huawei.com>, Feifei Wang <wangfeifei40@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Andrew Boyer <andrew.boyer@amd.com>, Wei Hu
 <weh@microsoft.com>, Jakub Grajciar <jgrajcia@cisco.com>, Matan Azrad
 <matan@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Liron Himi
 <lironh@marvell.com>, Dimon Zhao <dimon.zhao@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>, Martin
 Spinler <spinler@cesnet.cz>, Chaoyong He <chaoyong.he@corigine.com>, Jiawen
 Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>,
 Christian Koue Muf <ckm@napatech.com>, Serhii Iliushyk
 <sil-plv@napatech.com>, Tetsuya Mukawa <mtetsuyah@gmail.com>, Vamsi Attunuru
 <vattunuru@marvell.com>, Devendra Singh Rawat <dsinghrawat@marvell.com>, Alok
 Prasad <palok@marvell.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Wenbo Cao <caowenbo@mucse.com>, Jie Liu <liujie5@linkdatatechnology.com>,
 Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>, Maxime
 Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>,
 Jochen Behrens <jochen.behrens@broadcom.com>, Renyong Wan
 <wanry@yunsilicon.com>, Na Na <nana@yunsilicon.com>, Rong Qian
 <qianr@yunsilicon.com>, Xiaoxiong Zhang <zhangxx@yunsilicon.com>, Dongwei Xu
 <xudw@yunsilicon.com>, Junlong Wang <wang.junlong1@zte.com.cn>, Ming Ran
 <ran.ming@zte.com.cn>, Thomas Monjalon <thomas@monjalon.net>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: RE: [EXTERNAL] [PATCH v4 15/16] ethdev: remove queue stats counter
 limit
Thread-Topic: [EXTERNAL] [PATCH v4 15/16] ethdev: remove queue stats counter
 limit
Thread-Index: AQHdLCp5CInDFXXcJ0WtGvS8YnF10raeIDYw
Date: Fri, 14 Aug 2026 22:31:59 +0000
Message-ID: <SA1PR21MB6683B447239E95B4544148B4CEDA2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260814194757.329424-1-stephen@networkplumber.org>
 <20260814194757.329424-16-stephen@networkplumber.org>
In-Reply-To: <20260814194757.329424-16-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8657fdb8-6a99-46e5-960a-7ea114be5761;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-14T22:28:46Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA3PR21MB5746:EE_
x-ms-office365-filtering-correlation-id: bfbcee50-78c8-4801-c03e-08defa53db19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|23010399003|22082099003|18002099003|56012099006|38070700021|11063799006|4143699003|7146999003|10067099003;
x-microsoft-antispam-message-info: 0YfUmtTZxAEilK38Ncah4KMnURkY/isB8ZugC0OVUoCS1BccXJcnoBVEE6yhHsG1ToSr4zL2Hzsp1QKHTc1fKhVd+8QAyLxt5lNO8hgxr4JEEB3uMPz+uG1stC66r3BE/berz5DI66hthPaQtRU9z1BQHE3XswQFhiRluksz+dG9e5Cxs1qFB7Ama7Wj1Y8Fmr4vQJlUiKytKIVp47wMldvoDtHCFl7k1cmjlgWF75ZaUNl/m1R2OwhfLQIuDpHqCReRlBahZHft7/P6CsULwQl7o0lBsVOs0XpKIfzlpJpa9/yNrV6zmIEdbr5qWtBGYeEpmA5fm2xXf/zbk140qYXfE/ft/jXAAlSuJwNuLBy1IwTdPH0Ecw5rsl8TSXGhTMGPaniQULKp3ZNog7DWQsSGg9RW10Fr3tOXNBM+HatnVSdWHHro4tfXD56QaphFJNifbygyx14nU2Gwu3cyUtqwbiBqIZ4qBmagipkHePFHaNiFQH2EGX8GzA3GXs1fIhky6Wdl/RSalCUtQySYDfr+Ut/LKwMbnVgmRH1HYLX+Jxow/vakXShevh2Y7Gk0Mfw9DnDyuJ/pY5efseiqTh+qgsSAjlmeoCVb71JX2nMBv0KA4PH6frA7WFWAARNve5Vy54imJOshKlMlQZLFAsPP5PybK1i42QNXjk6wImwqVYGcb3QFWccP6A5Yff85bsJCzyPKivLyp1i3XWmaEm0rn+W9g2cVl26QHjhnEfE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(38070700021)(11063799006)(4143699003)(7146999003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6I2vbFlP7VTqwwCzenC1lCqLJzDVBeL/FYaxECyhnt5POr+Rpyq2uWgRy0xr?=
 =?us-ascii?Q?IfBojlQnjD/yUIT2gwwCjQNmehNZpOmTJ090EYPDluOdcG5h88DwsQgSgLME?=
 =?us-ascii?Q?DQVIGa/D62k3usqOyLheAUguRu3ziQ3XEXC8yfUNQLwdcwaMfbtivd2CmNeM?=
 =?us-ascii?Q?R7ibsox11DGYKJw47UumBHR1HELu6Uf+Pyz9cRic3PlXn8/0V7ju9cZJRBXi?=
 =?us-ascii?Q?ptE0rs7c725v1v22tfwqshHHgXQW631aRv1Eejx++jOAwodBCTGexihUNmmd?=
 =?us-ascii?Q?h49xJ2JloAXncMltWuf1rpnFn4jbowjW8UD6cMshTFYSMqc34b0EAvJ5CXOX?=
 =?us-ascii?Q?q+HFCcL78G8oU+nT5GaA77K5st2x5I1yU3jl/bvxACloKoMZK8yzfum+gvfJ?=
 =?us-ascii?Q?3DHUjDmXStyrVvVVUuPLiyNVDvkSLC7l9zD7UJvtKKbVNvoCK+NL1SMq4IjN?=
 =?us-ascii?Q?DshBKGXe6r02Z0gyFC7rhtFtC2dMg44AqWnTAnq3gTYvFJMpmMUaRVEUnEnK?=
 =?us-ascii?Q?tTAmOn/8BML1brnLKrXQgYjz9fh3mCu3580u2tHRWiW/dB7ldGvfQtnegi0H?=
 =?us-ascii?Q?fmcvUtvKQzJtL2NwOQ/Lzoc3y01nUqyuK0TZ3nd/zrHkUwCLwTQxAvlQoqF6?=
 =?us-ascii?Q?4zIHDdRmu/haHf9C3hc6k1cLVHzJ3dx2xZwTXnmr5NHhU23w7enZ1+wKuSrn?=
 =?us-ascii?Q?AqIdVSZP0eiYqUQIia+pQGaqvBc/xTOmzfRDRZB4nSasIEQzxWKvTpvfKZmU?=
 =?us-ascii?Q?4kK2Km1F8RA5OZKqBGoRRNhV1wPTfJZcrXiL8NPTyKS4VyVKXzcvNSD9qnoS?=
 =?us-ascii?Q?QFTbnZjdDOOFK5YsQ8wNIBgi1KbxwCbms+t6wbNhU2qMLkJeoEHr0y65pYs+?=
 =?us-ascii?Q?WgPzIvJpGqV8oOyWON8njeySkPl+cJidAyOfySKy1mOXmuI9pyMvqMIiheWV?=
 =?us-ascii?Q?sMqxkJpfa9VRSvTq+nDxcjyBgPByUTucLatYmGzanVe71JP8U8XbocmwY5/s?=
 =?us-ascii?Q?5AWJQ1+5M7irv0zR+xcnUlL5M3/6kLrQVzq3LXjWsz/izCUag6QI7GutHH50?=
 =?us-ascii?Q?vM0CVoYFT1dYEhQp5vx8ygJIYO0aICFKjscbc3AGx2JIVWnA60B12vJlZ7WZ?=
 =?us-ascii?Q?Gvs7UTP0Chlq06jMexx2St72nC/64m4y/ZlL71kbxpE7irwYVmx1ipmqdZlM?=
 =?us-ascii?Q?63z0S9e2poC3r85tFGbAjjK/Wzo0VB6yjPQXPHF+KAZ1MvFeT7nXEsyGHTvC?=
 =?us-ascii?Q?OoKGid0K/AhY+HzGcM6nYwFwl3eoM3kLnavyjyVnov+HhxiYLKrRQEhYqC4D?=
 =?us-ascii?Q?N/sp6arqaQKQT/bLRK3nJ5sT+2EP+mKc8FFJxVpqPqkyQy0Gz9TBobkcOZO9?=
 =?us-ascii?Q?2f/XssxGioS43cW/NwSdqeOlNeqPEtchsvWtLcdupKW1gMZlb/97xcFmBROd?=
 =?us-ascii?Q?TlVY6o/d2QAOiePs9CBqRsfQ+Qmb4Z0ymROM0oBnkrQooo4qVfnrtp2gfPXE?=
 =?us-ascii?Q?L0UHSPRf8YbXzackv7hHrxll4OyCaywpr4cz1fXymV+9DLRLZ7kugnfVSqkl?=
 =?us-ascii?Q?vzPs8iAcyjcJOmsrIcDWBo+CHXS92U5UdH35EUP8PCIEWvBv65SGT3K5PORM?=
 =?us-ascii?Q?FHQxvzWAKG/9Ppc72zOiqO8SRNPpHtQ21QyvOt4pM8HAj4t8TD6qdA4aal7H?=
 =?us-ascii?Q?KZJcYYYkeYzy6o8YpAwqeNcFQgFj5Qqn/D1QEbLD6nu3v0tU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbcee50-78c8-4801-c03e-08defa53db19
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 22:31:59.7765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ezxDfNY6azoRydgznkKPayK3Ar1xbsV4Y/Al+/e6H2BCwaSoZvm56uib6P1fMdGuqTXvt9yu+ISxpytzUkfLlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5746
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

> Queue stats were passed back from drivers in arrays of
> RTE_ETHDEV_QUEUE_STAT_CNTRS entries, limiting reporting to the first 16
> queues unless DPDK was rebuilt with a larger value.
>=20
> Replace the arrays with one counter structure per queue, allocated by
> ethdev and sized to the number of queues configured on the port.
> Queue counts are already validated by rte_eth_dev_configure(), so no
> additional limit is needed.
>=20
> Drop the per-queue error counter. Only a few drivers filled it, and
> errors are still counted by the port level ierrors and oerrors.
>=20
> RTE_ETHDEV_QUEUE_STAT_CNTRS is unused now and removed. It was
> defined in
> ethdev_driver.h, only installed with the driver SDK, so the ABI is
> unaffected.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

For mana and netvsc:
Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  doc/guides/howto/debug_troubleshoot.rst       |  5 +-
>  doc/guides/nics/bnxt.rst                      |  4 +-
>  doc/guides/nics/features.rst                  |  5 +-
>  doc/guides/rel_notes/release_26_11.rst        |  4 ++
>  drivers/net/af_packet/rte_eth_af_packet.c     | 15 +++--
>  drivers/net/af_xdp/rte_eth_af_xdp.c           | 13 ++--
>  drivers/net/ark/ark_ethdev_rx.c               |  7 +-
>  drivers/net/ark/ark_ethdev_tx.c               |  6 +-
>  drivers/net/atlantic/atl_ethdev.c             | 13 ++--
>  drivers/net/atlantic/atl_rxtx.c               |  8 +--
>  drivers/net/atlantic/atl_types.h              | 15 +++--
>  drivers/net/avp/avp_ethdev.c                  | 13 ++--
>  drivers/net/axgbe/axgbe_ethdev.c              | 13 ++--
>  drivers/net/bnxt/bnxt_ethdev.c                |  5 --
>  drivers/net/bnxt/bnxt_reps.c                  |  9 ++-
>  drivers/net/bnxt/bnxt_stats.c                 | 40 ++++-------
>  drivers/net/cnxk/cnxk_rep_ops.c               |  8 +--
>  drivers/net/cnxk/cnxk_stats.c                 | 15 ++---
>  drivers/net/dpaa2/dpaa2_ethdev.c              | 17 ++---
>  drivers/net/ena/ena_ethdev.c                  | 21 ++----
>  drivers/net/hinic/hinic_pmd_ethdev.c          | 17 +++--
>  drivers/net/hinic3/hinic3_ethdev.c            | 13 ++--
>  drivers/net/intel/e1000/igc_ethdev.c          | 13 ++--
>  drivers/net/intel/fm10k/fm10k_ethdev.c        | 16 +++--
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c        | 14 ++--
>  drivers/net/ionic/ionic_lif.c                 | 24 +++----
>  drivers/net/mana/mana.c                       | 12 ++--
>  drivers/net/memif/rte_eth_memif.c             | 16 ++---
>  drivers/net/mlx4/mlx4_ethdev.c                | 14 ++--
>  drivers/net/mlx5/mlx5_rx.h                    |  3 +-
>  drivers/net/mlx5/mlx5_stats.c                 | 22 +++----
>  drivers/net/mvpp2/mrvl_ethdev.c               | 20 +++---
>  drivers/net/nbl/nbl_dev/nbl_dev.c             |  2 -
>  drivers/net/nbl/nbl_hw/nbl_txrx.c             | 12 ++--
>  drivers/net/netvsc/hn_ethdev.c                | 12 ++--
>  drivers/net/netvsc/hn_vf.c                    |  3 +-
>  drivers/net/nfb/nfb_stats.c                   | 12 ++--
>  drivers/net/nfp/flower/nfp_flower.c           |  8 +--
>  .../net/nfp/flower/nfp_flower_representor.c   | 32 ++++++---
>  .../net/nfp/flower/nfp_flower_representor.h   |  4 +-
>  drivers/net/nfp/nfp_ethdev.c                  | 13 ++++
>  drivers/net/nfp/nfp_ethdev_vf.c               | 13 ++++
>  drivers/net/nfp/nfp_net_common.c              | 36 ++++------
>  drivers/net/nfp/nfp_net_common.h              |  3 +-
>  drivers/net/ngbe/ngbe_ethdev.c                | 34 +++-------
>  drivers/net/ngbe/ngbe_ethdev.h                | 12 ----
>  drivers/net/ntnic/ntnic_ethdev.c              | 12 ++--
>  drivers/net/null/rte_eth_null.c               | 12 ++--
>  drivers/net/octeon_ep/otx_ep_ethdev.c         | 13 ++--
>  drivers/net/pcap/pcap_ethdev.c                | 14 ++--
>  drivers/net/qede/qede_ethdev.c                | 36 ++--------
>  drivers/net/ring/rte_eth_ring.c               | 10 ++-
>  drivers/net/rnp/rnp_ethdev.c                  | 12 ++--
>  drivers/net/sxe2/sxe2_cmd_chnl.c              | 20 +++---
>  drivers/net/tap/rte_eth_tap.c                 | 12 ++--
>  drivers/net/thunderx/nicvf_ethdev.c           | 24 +++----
>  drivers/net/txgbe/txgbe_ethdev.c              | 14 ++--
>  drivers/net/vhost/rte_eth_vhost.c             | 14 ++--
>  drivers/net/virtio/virtio_ethdev.c            | 12 ++--
>  drivers/net/vmxnet3/vmxnet3_ethdev.c          | 13 ++--
>  drivers/net/xsc/xsc_ethdev.c                  | 14 ++--
>  drivers/net/zxdh/zxdh_ethdev_ops.c            | 24 +++----
>  lib/ethdev/ethdev_driver.h                    | 27 ++++----
>  lib/ethdev/ethdev_private.c                   |  2 -
>  lib/ethdev/rte_ethdev.c                       | 66 ++++++++++---------
>  65 files changed, 445 insertions(+), 522 deletions(-)
>=20
> diff --git a/doc/guides/howto/debug_troubleshoot.rst
> b/doc/guides/howto/debug_troubleshoot.rst
> index c19aada6f8..969118fcfc 100644
> --- a/doc/guides/howto/debug_troubleshoot.rst
> +++ b/doc/guides/howto/debug_troubleshoot.rst
> @@ -120,8 +120,9 @@ RX-TX port and associated
> cores :numref:`dtg_rx_tx_drop`.
>     * Identify if there are multiple RX queue configured for port by
>       ``nb_rx_queues`` using ``rte_eth_dev_info_get``.
>=20
> -   * Using ``rte_eth_dev_stats`` fetch drops in q_errors, check if RX th=
read
> -     is configured to fetch packets from the port queue pair.
> +   * Using ``rte_eth_dev_stats`` fetch drops in ``ierrors`` and ``imisse=
d``,
> +     check if RX thread is configured to fetch packets from the port que=
ue
> +     pair.
>=20
>     * Using ``rte_eth_dev_stats`` shows drops in ``rx_nombuf``, check if =
RX
>       thread has enough cycles to consume the packets from the queue.
> diff --git a/doc/guides/nics/bnxt.rst b/doc/guides/nics/bnxt.rst
> index 45529a89ee..48b950876c 100644
> --- a/doc/guides/nics/bnxt.rst
> +++ b/doc/guides/nics/bnxt.rst
> @@ -588,9 +588,7 @@ Basic stats include:
>  * ierrors
>  * oerrors
>=20
> -By default, per-queue stats for 16 queues are supported. For more than 1=
6
> -queues, BNXT PMD should be compiled with
> ``RTE_ETHDEV_QUEUE_STAT_CNTRS``
> -set to the desired number of queues.
> +Per-queue stats are supported for all configured queues.
>=20
>  Extended Stats
>  ^^^^^^^^^^^^^^
> diff --git a/doc/guides/nics/features.rst b/doc/guides/nics/features.rst
> index d6852b063c..43eda7867d 100644
> --- a/doc/guides/nics/features.rst
> +++ b/doc/guides/nics/features.rst
> @@ -757,8 +757,9 @@ These apply to all drivers.
>  Stats per queue
>  ---------------
>=20
> -Supports per queue stats: q_ipackets, q_opackets, q_ibytes, q_obytes,
> q_errors.
> -Statistics only supplied for first ``RTE_ETHDEV_QUEUE_STAT_CNTRS`` (16)
> queues.
> +Supports per queue stats: q_ipackets, q_opackets, q_ibytes, q_obytes.
> +Statistics are supplied for all configured queues,
> +subject to any hardware counter limit of the device.
>  If driver does not support this feature the per queue stats will be zero=
.
>=20
>  * **[implements] eth_dev_ops**: ``stats_get``, ``stats_reset``.
> diff --git a/doc/guides/rel_notes/release_26_11.rst
> b/doc/guides/rel_notes/release_26_11.rst
> index d29d7591e9..ed271a81f6 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -82,6 +82,10 @@ Removed Items
>    ``rte_eth_dev_set_tx_queue_stats_mapping`` and
> ``rte_eth_dev_set_rx_queue_stats_mapping``
>    were deprecated and are now removed.
>=20
> +* ethdev: Removed the ``RTE_ETHDEV_QUEUE_STAT_CNTRS`` build time
> limit.
> +  Per-queue xstats are now reported for all queues, not just the first 1=
6.
> +  The ``rx_qN_errors`` xstat is removed, drops are still counted in ``ie=
rrors``.
> +
>=20
>  API Changes
>  -----------
> diff --git a/drivers/net/af_packet/rte_eth_af_packet.c
> b/drivers/net/af_packet/rte_eth_af_packet.c
> index b0ff22ea55..a97b826305 100644
> --- a/drivers/net/af_packet/rte_eth_af_packet.c
> +++ b/drivers/net/af_packet/rte_eth_af_packet.c
> @@ -515,12 +515,15 @@ eth_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats, struct eth_q
>  		tx_err_total +=3D internal->tx_queue[i].err_pkts;
>  		tx_bytes_total +=3D internal->tx_queue[i].tx_bytes;
>=20
> -		if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_ipackets[i] =3D internal->rx_queue[i].rx_pkts;
> -			qstats->q_ibytes[i] =3D internal->rx_queue[i].rx_bytes;
> -			qstats->q_opackets[i] =3D internal->tx_queue[i].tx_pkts;
> -			qstats->q_obytes[i] =3D internal->tx_queue[i].tx_bytes;
> -			qstats->q_errors[i] =3D internal->rx_queue[i].rx_nombuf;
> +		if (qstats !=3D NULL) {
> +			if (i < dev->data->nb_rx_queues) {
> +				qstats[i].q_ipackets =3D internal-
> >rx_queue[i].rx_pkts;
> +				qstats[i].q_ibytes =3D internal-
> >rx_queue[i].rx_bytes;
> +			}
> +			if (i < dev->data->nb_tx_queues) {
> +				qstats[i].q_opackets =3D internal-
> >tx_queue[i].tx_pkts;
> +				qstats[i].q_obytes =3D internal-
> >tx_queue[i].tx_bytes;
> +			}
>  		}
>  	}
>=20
> diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c
> b/drivers/net/af_xdp/rte_eth_af_xdp.c
> index 2cdb533276..be2f5760ae 100644
> --- a/drivers/net/af_xdp/rte_eth_af_xdp.c
> +++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
> @@ -910,12 +910,13 @@ eth_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  		rxq =3D &internals->rx_queues[i];
>  		txq =3D rxq->pair;
>=20
> -		if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_ipackets[i] =3D rxq->stats.rx_pkts;
> -			qstats->q_ibytes[i] =3D rxq->stats.rx_bytes;
> -			qstats->q_opackets[i] =3D txq->stats.tx_pkts;
> -			qstats->q_obytes[i] =3D txq->stats.tx_bytes;
> -			qstats->q_errors[i] =3D 0; /* Not used */
> +		if (qstats !=3D NULL) {
> +			qstats[i].q_ipackets =3D rxq->stats.rx_pkts;
> +			qstats[i].q_ibytes =3D rxq->stats.rx_bytes;
> +			if (i < dev->data->nb_tx_queues) {
> +				qstats[i].q_opackets =3D txq->stats.tx_pkts;
> +				qstats[i].q_obytes =3D txq->stats.tx_bytes;
> +			}
>  		}
>=20
>  		ipackets +=3D rxq->stats.rx_pkts;
> diff --git a/drivers/net/ark/ark_ethdev_rx.c b/drivers/net/ark/ark_ethdev=
_rx.c
> index 42f2db6610..adba943fa2 100644
> --- a/drivers/net/ark/ark_ethdev_rx.c
> +++ b/drivers/net/ark/ark_ethdev_rx.c
> @@ -592,10 +592,9 @@ ark_rx_queue_stats_get(void *vqueue, struct
> rte_eth_stats *stats,
>  	stats->ibytes +=3D ibytes;
>  	stats->imissed +=3D idropped;
>=20
> -	if (qstats && queue->queue_index <
> RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -		qstats->q_ipackets[queue->queue_index] =3D ipackets;
> -		qstats->q_ibytes[queue->queue_index] =3D ibytes;
> -		qstats->q_errors[queue->queue_index] =3D idropped;
> +	if (qstats !=3D NULL) {
> +		qstats[queue->queue_index].q_ipackets =3D ipackets;
> +		qstats[queue->queue_index].q_ibytes =3D ibytes;
>  	}
>  }
>=20
> diff --git a/drivers/net/ark/ark_ethdev_tx.c b/drivers/net/ark/ark_ethdev=
_tx.c
> index c9b5b005ca..0d6a94b919 100644
> --- a/drivers/net/ark/ark_ethdev_tx.c
> +++ b/drivers/net/ark/ark_ethdev_tx.c
> @@ -433,9 +433,9 @@ ark_tx_queue_stats_get(void *vqueue, struct
> rte_eth_stats *stats, struct eth_que
>  	stats->obytes +=3D bytes;
>  	stats->oerrors +=3D queue->tx_errors;
>=20
> -	if (qstats && queue->queue_index <
> RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -		qstats->q_opackets[queue->queue_index] =3D pkts;
> -		qstats->q_obytes[queue->queue_index] =3D bytes;
> +	if (qstats !=3D NULL) {
> +		qstats[queue->queue_index].q_opackets =3D pkts;
> +		qstats[queue->queue_index].q_obytes =3D bytes;
>  	}
>  }
>=20
> diff --git a/drivers/net/atlantic/atl_ethdev.c b/drivers/net/atlantic/atl=
_ethdev.c
> index 0b2033c084..24184bdb18 100644
> --- a/drivers/net/atlantic/atl_ethdev.c
> +++ b/drivers/net/atlantic/atl_ethdev.c
> @@ -954,12 +954,13 @@ atl_dev_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  	stats->rx_nombuf =3D swstats->rx_nombuf;
>=20
>  	if (qstats !=3D NULL) {
> -		for (i =3D 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS; i++) {
> -			qstats->q_ipackets[i] =3D swstats->q_ipackets[i];
> -			qstats->q_opackets[i] =3D swstats->q_opackets[i];
> -			qstats->q_ibytes[i] =3D swstats->q_ibytes[i];
> -			qstats->q_obytes[i] =3D swstats->q_obytes[i];
> -			qstats->q_errors[i] =3D swstats->q_errors[i];
> +		for (i =3D 0; i < dev->data->nb_rx_queues && i <
> AQ_HW_MAX_RX_QUEUES; i++) {
> +			qstats[i].q_ipackets =3D swstats->rxq[i].packets;
> +			qstats[i].q_ibytes =3D swstats->rxq[i].bytes;
> +		}
> +		for (i =3D 0; i < dev->data->nb_tx_queues && i <
> AQ_HW_MAX_TX_QUEUES; i++) {
> +			qstats[i].q_opackets =3D swstats->txq[i].packets;
> +			qstats[i].q_obytes =3D swstats->txq[i].bytes;
>  		}
>  	}
>  	return 0;
> diff --git a/drivers/net/atlantic/atl_rxtx.c b/drivers/net/atlantic/atl_r=
xtx.c
> index 7b7bf5abbc..8d02b92304 100644
> --- a/drivers/net/atlantic/atl_rxtx.c
> +++ b/drivers/net/atlantic/atl_rxtx.c
> @@ -1075,8 +1075,8 @@ atl_recv_pkts(void *rx_queue, struct rte_mbuf
> **rx_pkts, uint16_t nb_pkts)
>  		 * of returned packets.
>  		 */
>  		rx_pkts[nb_rx++] =3D rx_mbuf_first;
> -		adapter->sw_stats.q_ipackets[rxq->queue_id]++;
> -		adapter->sw_stats.q_ibytes[rxq->queue_id] +=3D
> +		adapter->sw_stats.rxq[rxq->queue_id].packets++;
> +		adapter->sw_stats.rxq[rxq->queue_id].bytes +=3D
>  			rx_mbuf_first->pkt_len;
>=20
>  		PMD_RX_LOG(DEBUG, "add mbuf segs=3D%d pkt_len=3D%d",
> @@ -1297,8 +1297,8 @@ atl_xmit_pkt(struct aq_hw_s *hw, struct
> atl_tx_queue *txq,
>=20
>  	txq->tx_free -=3D desc_count;
>=20
> -	adapter->sw_stats.q_opackets[txq->queue_id]++;
> -	adapter->sw_stats.q_obytes[txq->queue_id] +=3D pay_len;
> +	adapter->sw_stats.txq[txq->queue_id].packets++;
> +	adapter->sw_stats.txq[txq->queue_id].bytes +=3D pay_len;
>  }
>=20
>  uint16_t
> diff --git a/drivers/net/atlantic/atl_types.h b/drivers/net/atlantic/atl_=
types.h
> index dfd7016600..be9f3aacc1 100644
> --- a/drivers/net/atlantic/atl_types.h
> +++ b/drivers/net/atlantic/atl_types.h
> @@ -15,6 +15,8 @@
>  #include <rte_common.h>
>  #include <ethdev_driver.h>
>=20
> +#include "atl_common.h"
> +
>  typedef uint8_t		u8;
>  typedef int8_t		s8;
>  typedef uint16_t	u16;
> @@ -225,11 +227,14 @@ struct atl_sw_stats {
>  	u64 pcrc8ec;
>=20
>  	u64 rx_nombuf;
> -	u64 q_ipackets[RTE_ETHDEV_QUEUE_STAT_CNTRS];
> -	u64 q_opackets[RTE_ETHDEV_QUEUE_STAT_CNTRS];
> -	u64 q_ibytes[RTE_ETHDEV_QUEUE_STAT_CNTRS];
> -	u64 q_obytes[RTE_ETHDEV_QUEUE_STAT_CNTRS];
> -	u64 q_errors[RTE_ETHDEV_QUEUE_STAT_CNTRS];
> +	struct {
> +		u64 packets;
> +		u64 bytes;
> +	} rxq[AQ_HW_MAX_RX_QUEUES];
> +	struct {
> +		u64 packets;
> +		u64 bytes;
> +	} txq[AQ_HW_MAX_TX_QUEUES];
>  };
>=20
>  #endif
> diff --git a/drivers/net/avp/avp_ethdev.c b/drivers/net/avp/avp_ethdev.c
> index 8af6c45381..d536f764cf 100644
> --- a/drivers/net/avp/avp_ethdev.c
> +++ b/drivers/net/avp/avp_ethdev.c
> @@ -2256,10 +2256,9 @@ avp_dev_stats_get(struct rte_eth_dev *eth_dev,
> struct rte_eth_stats *stats,
>  			stats->ibytes +=3D rxq->bytes;
>  			stats->ierrors +=3D rxq->errors;
>=20
> -			if (qstats !=3D NULL && i <
> RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -				qstats->q_ipackets[i] +=3D rxq->packets;
> -				qstats->q_ibytes[i] +=3D rxq->bytes;
> -				qstats->q_errors[i] +=3D rxq->errors;
> +			if (qstats !=3D NULL && i < eth_dev->data-
> >nb_rx_queues) {
> +				qstats[i].q_ipackets +=3D rxq->packets;
> +				qstats[i].q_ibytes +=3D rxq->bytes;
>  			}
>  		}
>  	}
> @@ -2272,9 +2271,9 @@ avp_dev_stats_get(struct rte_eth_dev *eth_dev,
> struct rte_eth_stats *stats,
>  			stats->obytes +=3D txq->bytes;
>  			stats->oerrors +=3D txq->errors;
>=20
> -			if (qstats !=3D NULL && i <
> RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -				qstats->q_opackets[i] +=3D txq->packets;
> -				qstats->q_obytes[i] +=3D txq->bytes;
> +			if (qstats !=3D NULL && i < eth_dev->data-
> >nb_tx_queues) {
> +				qstats[i].q_opackets +=3D txq->packets;
> +				qstats[i].q_obytes +=3D txq->bytes;
>  			}
>  		}
>  	}
> diff --git a/drivers/net/axgbe/axgbe_ethdev.c
> b/drivers/net/axgbe/axgbe_ethdev.c
> index 61725d55ca..93e198ba95 100644
> --- a/drivers/net/axgbe/axgbe_ethdev.c
> +++ b/drivers/net/axgbe/axgbe_ethdev.c
> @@ -1156,10 +1156,9 @@ axgbe_dev_stats_get(struct rte_eth_dev *dev,
>  			stats->rx_nombuf +=3D rxq->rx_mbuf_alloc_failed;
>  			stats->ierrors +=3D rxq->errors;
>=20
> -			if (qstats !=3D NULL && i <
> RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -				qstats->q_ipackets[i] =3D rxq->pkts;
> -				qstats->q_ibytes[i] =3D rxq->bytes;
> -				qstats->q_errors[i] =3D rxq->errors + rxq-
> >rx_mbuf_alloc_failed;
> +			if (qstats !=3D NULL && i < dev->data->nb_rx_queues) {
> +				qstats[i].q_ipackets =3D rxq->pkts;
> +				qstats[i].q_ibytes =3D rxq->bytes;
>  			}
>  		} else {
>  			PMD_DRV_LOG_LINE(DEBUG, "Rx queue not setup for
> port %d",
> @@ -1174,9 +1173,9 @@ axgbe_dev_stats_get(struct rte_eth_dev *dev,
>  			stats->obytes +=3D txq->bytes;
>  			stats->oerrors +=3D txq->errors;
>=20
> -			if (qstats !=3D NULL && i <
> RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -				qstats->q_opackets[i] =3D txq->pkts;
> -				qstats->q_obytes[i] =3D txq->bytes;
> +			if (qstats !=3D NULL && i < dev->data->nb_tx_queues) {
> +				qstats[i].q_opackets =3D txq->pkts;
> +				qstats[i].q_obytes =3D txq->bytes;
>  			}
>  		} else {
>  			PMD_DRV_LOG_LINE(DEBUG, "Tx queue not setup for
> port %d",
> diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethde=
v.c
> index 8e8ead8f61..c6f566c214 100644
> --- a/drivers/net/bnxt/bnxt_ethdev.c
> +++ b/drivers/net/bnxt/bnxt_ethdev.c
> @@ -1843,11 +1843,6 @@ int bnxt_dev_start_op(struct rte_eth_dev
> *eth_dev)
>  	struct bnxt_tx_queue *txq;
>  	uint16_t queue_idx;
>=20
> -	if (bp->rx_cp_nr_rings > RTE_ETHDEV_QUEUE_STAT_CNTRS)
> -		PMD_DRV_LOG_LINE(ERR,
> -			    "RxQ cnt %d >
> RTE_ETHDEV_QUEUE_STAT_CNTRS %d",
> -			    bp->rx_cp_nr_rings,
> RTE_ETHDEV_QUEUE_STAT_CNTRS);
> -
>  	do {
>  		rc =3D bnxt_hwrm_if_change(bp, true);
>  		if (rc =3D=3D 0 || rc !=3D -EAGAIN)
> diff --git a/drivers/net/bnxt/bnxt_reps.c b/drivers/net/bnxt/bnxt_reps.c
> index e26a086f41..dd0f14d5c6 100644
> --- a/drivers/net/bnxt/bnxt_reps.c
> +++ b/drivers/net/bnxt/bnxt_reps.c
> @@ -909,11 +909,10 @@ int bnxt_rep_stats_get_op(struct rte_eth_dev
> *eth_dev,
>  		stats->imissed +=3D rep_bp->rx_drop_pkts[i];
>=20
>  		if (qstats) {
> -			qstats->q_ipackets[i] =3D rep_bp->rx_pkts[i];
> -			qstats->q_ibytes[i] =3D rep_bp->rx_bytes[i];
> -			qstats->q_opackets[i] =3D rep_bp->tx_pkts[i];
> -			qstats->q_obytes[i] =3D rep_bp->tx_bytes[i];
> -			qstats->q_errors[i] =3D rep_bp->rx_drop_pkts[i];
> +			qstats[i].q_ipackets =3D rep_bp->rx_pkts[i];
> +			qstats[i].q_ibytes =3D rep_bp->rx_bytes[i];
> +			qstats[i].q_opackets =3D rep_bp->tx_pkts[i];
> +			qstats[i].q_obytes =3D rep_bp->tx_bytes[i];
>  		}
>  	}
>=20
> diff --git a/drivers/net/bnxt/bnxt_stats.c b/drivers/net/bnxt/bnxt_stats.=
c
> index ba858710a5..37b33f0505 100644
> --- a/drivers/net/bnxt/bnxt_stats.c
> +++ b/drivers/net/bnxt/bnxt_stats.c
> @@ -576,18 +576,14 @@ static void bnxt_fill_rte_eth_stats_ext(struct
> rte_eth_stats *stats,
>  		uint64_t ibytes =3D ring_stats->rx_ucast_bytes +
>  				ring_stats->rx_mcast_bytes +
>  				ring_stats->rx_bcast_bytes;
> -		uint64_t ierrors =3D ring_stats->rx_discard_pkts +
> -				ring_stats->rx_error_pkts;
> -
>  		stats->ipackets +=3D ipackets;
>  		stats->ibytes +=3D ibytes;
>  		stats->imissed +=3D ring_stats->rx_discard_pkts;
>  		stats->ierrors +=3D ring_stats->rx_error_pkts;
>=20
>  		if (qstats) {
> -			qstats->q_ipackets[i] =3D ipackets;
> -			qstats->q_ibytes[i] =3D ibytes;
> -			qstats->q_errors[i] =3D ierrors;
> +			qstats[i].q_ipackets =3D ipackets;
> +			qstats[i].q_ibytes =3D ibytes;
>  		}
>  	} else {
>  		uint64_t opackets =3D ring_stats->tx_ucast_pkts +
> @@ -602,8 +598,8 @@ static void bnxt_fill_rte_eth_stats_ext(struct
> rte_eth_stats *stats,
>  		stats->oerrors +=3D ring_stats->tx_discard_pkts;
>=20
>  		if (qstats) {
> -			qstats->q_opackets[i] =3D opackets;
> -			qstats->q_obytes[i] =3D obytes;
> +			qstats[i].q_opackets =3D opackets;
> +			qstats[i].q_obytes =3D obytes;
>  		}
>  	}
>  }
> @@ -620,18 +616,14 @@ static void bnxt_fill_rte_eth_stats(struct
> rte_eth_stats *stats,
>  		uint64_t ibytes =3D ring_stats->rx_ucast_bytes +
>  				ring_stats->rx_mcast_bytes +
>  				ring_stats->rx_bcast_bytes;
> -		uint64_t ierrors =3D ring_stats->rx_discard_pkts +
> -				ring_stats->rx_error_pkts;
> -
>  		stats->ipackets +=3D ipackets;
>  		stats->ibytes +=3D ibytes;
>  		stats->imissed +=3D ring_stats->rx_discard_pkts;
>  		stats->ierrors +=3D ring_stats->rx_error_pkts;
>=20
>  		if (qstats) {
> -			qstats->q_ipackets[i] =3D ipackets;
> -			qstats->q_ibytes[i] =3D ibytes;
> -			qstats->q_errors[i] =3D ierrors;
> +			qstats[i].q_ipackets =3D ipackets;
> +			qstats[i].q_ibytes =3D ibytes;
>  		}
>  	} else {
>  		uint64_t opackets =3D ring_stats->tx_ucast_pkts +
> @@ -646,8 +638,8 @@ static void bnxt_fill_rte_eth_stats(struct rte_eth_st=
ats
> *stats,
>  		stats->oerrors +=3D ring_stats->tx_discard_pkts;
>=20
>  		if (qstats) {
> -			qstats->q_opackets[i] =3D opackets;
> -			qstats->q_obytes[i] =3D obytes;
> +			qstats[i].q_opackets =3D opackets;
> +			qstats[i].q_obytes =3D obytes;
>  		}
>  	}
>  }
> @@ -661,9 +653,7 @@ static int bnxt_stats_get_ext(struct rte_eth_dev
> *eth_dev,
>  	struct bnxt *bp =3D eth_dev->data->dev_private;
>  	unsigned int num_q_stats;
>=20
> -	num_q_stats =3D RTE_MIN(bp->rx_cp_nr_rings,
> -			      (unsigned int)RTE_ETHDEV_QUEUE_STAT_CNTRS);
> -
> +	num_q_stats =3D RTE_MIN(bp->rx_cp_nr_rings, eth_dev->data-
> >nb_rx_queues);
>  	for (i =3D 0; i < bp->rx_cp_nr_rings; i++) {
>  		struct bnxt_rx_queue *rxq =3D bp->rx_queues[i];
>  		struct bnxt_cp_ring_info *cpr =3D rxq->cp_ring;
> @@ -687,9 +677,7 @@ static int bnxt_stats_get_ext(struct rte_eth_dev
> *eth_dev,
>=20
> rte_memory_order_relaxed);
>  	}
>=20
> -	num_q_stats =3D RTE_MIN(bp->tx_cp_nr_rings,
> -			      (unsigned int)RTE_ETHDEV_QUEUE_STAT_CNTRS);
> -
> +	num_q_stats =3D RTE_MIN(bp->tx_cp_nr_rings, eth_dev->data-
> >nb_tx_queues);
>  	for (i =3D 0; i < bp->tx_cp_nr_rings; i++) {
>  		struct bnxt_tx_queue *txq =3D bp->tx_queues[i];
>  		struct bnxt_cp_ring_info *cpr =3D txq->cp_ring;
> @@ -728,9 +716,7 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
>  	if (BNXT_TPA_V2_P7(bp))
>  		return bnxt_stats_get_ext(eth_dev, bnxt_stats, qstats);
>=20
> -	num_q_stats =3D RTE_MIN(bp->rx_cp_nr_rings,
> -			      (unsigned int)RTE_ETHDEV_QUEUE_STAT_CNTRS);
> -
> +	num_q_stats =3D RTE_MIN(bp->rx_cp_nr_rings, eth_dev->data-
> >nb_rx_queues);
>  	for (i =3D 0; i < bp->rx_cp_nr_rings; i++) {
>  		struct bnxt_rx_queue *rxq =3D bp->rx_queues[i];
>  		struct bnxt_cp_ring_info *cpr =3D rxq->cp_ring;
> @@ -753,9 +739,7 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
>=20
> rte_memory_order_relaxed);
>  	}
>=20
> -	num_q_stats =3D RTE_MIN(bp->tx_cp_nr_rings,
> -			      (unsigned int)RTE_ETHDEV_QUEUE_STAT_CNTRS);
> -
> +	num_q_stats =3D RTE_MIN(bp->tx_cp_nr_rings, eth_dev->data-
> >nb_tx_queues);
>  	for (i =3D 0; i < bp->tx_cp_nr_rings; i++) {
>  		struct bnxt_tx_queue *txq =3D bp->tx_queues[i];
>  		struct bnxt_cp_ring_info *cpr =3D txq->cp_ring;
> diff --git a/drivers/net/cnxk/cnxk_rep_ops.c
> b/drivers/net/cnxk/cnxk_rep_ops.c
> index c481015592..4a9c027bf5 100644
> --- a/drivers/net/cnxk/cnxk_rep_ops.c
> +++ b/drivers/net/cnxk/cnxk_rep_ops.c
> @@ -614,10 +614,10 @@ cnxk_rep_stats_get(struct rte_eth_dev *ethdev,
> struct rte_eth_stats *stats,
>  	}
>=20
>  	if (qstats !=3D NULL) {
> -		qstats->q_ipackets[0] =3D vf_stats.ipackets;
> -		qstats->q_ibytes[0] =3D vf_stats.ibytes;
> -		qstats->q_opackets[0] =3D vf_stats.opackets;
> -		qstats->q_obytes[0] =3D vf_stats.obytes;
> +		qstats[0].q_ipackets =3D vf_stats.ipackets;
> +		qstats[0].q_ibytes =3D vf_stats.ibytes;
> +		qstats[0].q_opackets =3D vf_stats.opackets;
> +		qstats[0].q_obytes =3D vf_stats.obytes;
>  	}
>=20
>  	stats->ipackets =3D vf_stats.ipackets;
> diff --git a/drivers/net/cnxk/cnxk_stats.c b/drivers/net/cnxk/cnxk_stats.=
c
> index 469a18f93e..c15c8761c1 100644
> --- a/drivers/net/cnxk/cnxk_stats.c
> +++ b/drivers/net/cnxk/cnxk_stats.c
> @@ -39,28 +39,21 @@ cnxk_nix_stats_get(struct rte_eth_dev *eth_dev,
> struct rte_eth_stats *stats,
>  	for (i =3D 0; i < eth_dev->data->nb_tx_queues; i++) {
>  		struct roc_nix_stats_queue qstats_data;
>=20
> -		if (i >=3D RTE_ETHDEV_QUEUE_STAT_CNTRS)
> -			break;
> -
>  		rc =3D roc_nix_stats_queue_get(nix, i, 0, &qstats_data);
>  		if (rc)
>  			goto exit;
> -		qstats->q_opackets[i] =3D qstats_data.tx_pkts;
> -		qstats->q_obytes[i] =3D qstats_data.tx_octs;
> +		qstats[i].q_opackets =3D qstats_data.tx_pkts;
> +		qstats[i].q_obytes =3D qstats_data.tx_octs;
>  	}
>=20
>  	for (i =3D 0; i < eth_dev->data->nb_rx_queues; i++) {
>  		struct roc_nix_stats_queue qstats_data;
>=20
> -		if (i >=3D RTE_ETHDEV_QUEUE_STAT_CNTRS)
> -			break;
> -
>  		rc =3D roc_nix_stats_queue_get(nix, i, 1, &qstats_data);
>  		if (rc)
>  			goto exit;
> -		qstats->q_ipackets[i] =3D qstats_data.rx_pkts;
> -		qstats->q_ibytes[i] =3D qstats_data.rx_octs;
> -		qstats->q_errors[i] =3D qstats_data.rx_drop_pkts;
> +		qstats[i].q_ipackets =3D qstats_data.rx_pkts;
> +		qstats[i].q_ibytes =3D qstats_data.rx_octs;
>  	}
>  exit:
>  	return rc;
> diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c
> b/drivers/net/dpaa2/dpaa2_ethdev.c
> index f211357919..8ae4fd89c5 100644
> --- a/drivers/net/dpaa2/dpaa2_ethdev.c
> +++ b/drivers/net/dpaa2/dpaa2_ethdev.c
> @@ -2002,20 +2002,17 @@ dpaa2_dev_stats_get(struct rte_eth_dev *dev,
>  	stats->oerrors =3D value.page_2.egress_discarded_frames;
>  	stats->imissed =3D value.page_2.ingress_nobuffer_discards;
>=20
> -	/* Fill in per queue stats */
> +	/* Fill in per queue stats. Byte counting is not implemented. */
>  	if (qstats !=3D NULL) {
> -		for (i =3D 0; (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) &&
> -			(i < priv->nb_rx_queues || i < priv->nb_tx_queues);
> ++i) {
> +		for (i =3D 0; i < dev->data->nb_rx_queues; ++i) {
>  			dpaa2_rxq =3D priv->rx_vq[i];
> -			dpaa2_txq =3D priv->tx_vq[i];
>  			if (dpaa2_rxq)
> -				qstats->q_ipackets[i] =3D dpaa2_rxq->rx_pkts;
> +				qstats[i].q_ipackets =3D dpaa2_rxq->rx_pkts;
> +		}
> +		for (i =3D 0; i < dev->data->nb_tx_queues; ++i) {
> +			dpaa2_txq =3D priv->tx_vq[i];
>  			if (dpaa2_txq)
> -				qstats->q_opackets[i] =3D dpaa2_txq->tx_pkts;
> -
> -			/* Byte counting is not implemented */
> -			qstats->q_ibytes[i]   =3D 0;
> -			qstats->q_obytes[i]   =3D 0;
> +				qstats[i].q_opackets =3D dpaa2_txq->tx_pkts;
>  		}
>  	}
>=20
> diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
> index ad2ac6dbbf..ae48afcfdc 100644
> --- a/drivers/net/ena/ena_ethdev.c
> +++ b/drivers/net/ena/ena_ethdev.c
> @@ -1264,7 +1264,6 @@ static int ena_stats_get(struct rte_eth_dev *dev,
>  	struct ena_com_dev *ena_dev =3D &adapter->ena_dev;
>  	int rc;
>  	int i;
> -	int max_rings_stats;
>=20
>  	memset(&ena_stats, 0, sizeof(ena_stats));
>=20
> @@ -1295,26 +1294,18 @@ static int ena_stats_get(struct rte_eth_dev *dev,
>=20
>  	/* Queue statistics */
>  	if (qstats) {
> -		max_rings_stats =3D RTE_MIN(dev->data->nb_rx_queues,
> -			RTE_ETHDEV_QUEUE_STAT_CNTRS);
> -		for (i =3D 0; i < max_rings_stats; ++i) {
> +		for (i =3D 0; i < dev->data->nb_rx_queues; ++i) {
>  			struct ena_stats_rx *rx_stats =3D &adapter-
> >rx_ring[i].rx_stats;
>=20
> -			qstats->q_ibytes[i] =3D rx_stats->bytes;
> -			qstats->q_ipackets[i] =3D rx_stats->cnt;
> -			qstats->q_errors[i] =3D rx_stats->bad_desc_num +
> -				rx_stats->bad_req_id +
> -				rx_stats->bad_desc +
> -				rx_stats->unknown_error;
> +			qstats[i].q_ibytes =3D rx_stats->bytes;
> +			qstats[i].q_ipackets =3D rx_stats->cnt;
>  		}
>=20
> -		max_rings_stats =3D RTE_MIN(dev->data->nb_tx_queues,
> -			RTE_ETHDEV_QUEUE_STAT_CNTRS);
> -		for (i =3D 0; i < max_rings_stats; ++i) {
> +		for (i =3D 0; i < dev->data->nb_tx_queues; ++i) {
>  			struct ena_stats_tx *tx_stats =3D &adapter-
> >tx_ring[i].tx_stats;
>=20
> -			qstats->q_obytes[i] =3D tx_stats->bytes;
> -			qstats->q_opackets[i] =3D tx_stats->cnt;
> +			qstats[i].q_obytes =3D tx_stats->bytes;
> +			qstats[i].q_opackets =3D tx_stats->cnt;
>  		}
>  	}
>=20
> diff --git a/drivers/net/hinic/hinic_pmd_ethdev.c
> b/drivers/net/hinic/hinic_pmd_ethdev.c
> index 91a4348fb6..016d632e64 100644
> --- a/drivers/net/hinic/hinic_pmd_ethdev.c
> +++ b/drivers/net/hinic/hinic_pmd_ethdev.c
> @@ -1329,14 +1329,13 @@ hinic_dev_stats_get(struct rte_eth_dev *dev,
> struct rte_eth_stats *stats,
>=20
>  	/* rx queue stats */
>  	if (qstats) {
> -		q_num =3D (nic_dev->num_rq <
> RTE_ETHDEV_QUEUE_STAT_CNTRS) ?
> -				nic_dev->num_rq :
> RTE_ETHDEV_QUEUE_STAT_CNTRS;
> +		q_num =3D (nic_dev->num_rq < dev->data->nb_rx_queues) ?
> +				nic_dev->num_rq : dev->data->nb_rx_queues;
>  		for (i =3D 0; i < q_num; i++) {
>  			rxq =3D nic_dev->rxqs[i];
>  			hinic_rxq_get_stats(rxq, &rxq_stats);
> -			qstats->q_ipackets[i] =3D rxq_stats.packets;
> -			qstats->q_ibytes[i] =3D rxq_stats.bytes;
> -			qstats->q_errors[i] =3D rxq_stats.rx_discards;
> +			qstats[i].q_ipackets =3D rxq_stats.packets;
> +			qstats[i].q_ibytes =3D rxq_stats.bytes;
>=20
>  			stats->ierrors +=3D rxq_stats.errors;
>  			rx_discards_pmd +=3D rxq_stats.rx_discards;
> @@ -1344,13 +1343,13 @@ hinic_dev_stats_get(struct rte_eth_dev *dev,
> struct rte_eth_stats *stats,
>  		}
>=20
>  		/* tx queue stats */
> -		q_num =3D (nic_dev->num_sq <
> RTE_ETHDEV_QUEUE_STAT_CNTRS) ?
> -			nic_dev->num_sq :
> RTE_ETHDEV_QUEUE_STAT_CNTRS;
> +		q_num =3D (nic_dev->num_sq < dev->data->nb_tx_queues) ?
> +			nic_dev->num_sq : dev->data->nb_tx_queues;
>  		for (i =3D 0; i < q_num; i++) {
>  			txq =3D nic_dev->txqs[i];
>  			hinic_txq_get_stats(txq, &txq_stats);
> -			qstats->q_opackets[i] =3D txq_stats.packets;
> -			qstats->q_obytes[i] =3D txq_stats.bytes;
> +			qstats[i].q_opackets =3D txq_stats.packets;
> +			qstats[i].q_obytes =3D txq_stats.bytes;
>  			stats->oerrors +=3D (txq_stats.tx_busy +
> txq_stats.off_errs);
>  		}
>  	} else {
> diff --git a/drivers/net/hinic3/hinic3_ethdev.c
> b/drivers/net/hinic3/hinic3_ethdev.c
> index 361e52f7b9..eb5ddd9de6 100644
> --- a/drivers/net/hinic3/hinic3_ethdev.c
> +++ b/drivers/net/hinic3/hinic3_ethdev.c
> @@ -2763,10 +2763,9 @@ hinic3_dev_stats_get(struct rte_eth_dev *dev,
> struct rte_eth_stats *stats,
>  		rxq->rxq_stats.errors =3D rxq->rxq_stats.csum_errors +
>  					rxq->rxq_stats.other_errors;
>=20
> -		if (qstats && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_ipackets[i] =3D rxq->rxq_stats.packets;
> -			qstats->q_ibytes[i] =3D rxq->rxq_stats.bytes;
> -			qstats->q_errors[i] =3D rxq->rxq_stats.errors;
> +		if (qstats && i < dev->data->nb_rx_queues) {
> +			qstats[i].q_ipackets =3D rxq->rxq_stats.packets;
> +			qstats[i].q_ibytes =3D rxq->rxq_stats.bytes;
>  		}
>  		stats->ierrors +=3D rxq->rxq_stats.errors;
>  		rx_discards_pmd +=3D rxq->rxq_stats.dropped;
> @@ -2777,9 +2776,9 @@ hinic3_dev_stats_get(struct rte_eth_dev *dev,
> struct rte_eth_stats *stats,
>  	for (uint32_t i =3D 0; i < nic_dev->num_sqs; i++) {
>  		struct hinic3_txq *txq =3D nic_dev->txqs[i];
>  		stats->oerrors +=3D (txq->txq_stats.tx_busy + txq-
> >txq_stats.offload_errors);
> -		if (qstats && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_opackets[i] =3D txq->txq_stats.packets;
> -			qstats->q_obytes[i] =3D txq->txq_stats.bytes;
> +		if (qstats && i < dev->data->nb_tx_queues) {
> +			qstats[i].q_opackets =3D txq->txq_stats.packets;
> +			qstats[i].q_obytes =3D txq->txq_stats.bytes;
>  		}
>  	}
>=20
> diff --git a/drivers/net/intel/e1000/igc_ethdev.c
> b/drivers/net/intel/e1000/igc_ethdev.c
> index 943a479f9a..73dd5dd1a3 100644
> --- a/drivers/net/intel/e1000/igc_ethdev.c
> +++ b/drivers/net/intel/e1000/igc_ethdev.c
> @@ -2059,12 +2059,13 @@ eth_igc_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *rte_stats,
>=20
>  	/* Get per-queue statuses */
>  	if (qstats) {
> -		for (i =3D 0; i < RTE_MIN(IGC_QUEUE_PAIRS_NUM,
> RTE_ETHDEV_QUEUE_STAT_CNTRS); i++) {
> -			qstats->q_opackets[i] +=3D queue_stats->pqgptc[i];
> -			qstats->q_obytes[i] +=3D queue_stats->pqgotc[i];
> -			qstats->q_ipackets[i] +=3D queue_stats->pqgprc[i];
> -			qstats->q_ibytes[i] +=3D queue_stats->pqgorc[i];
> -			qstats->q_errors[i] +=3D queue_stats->rqdpc[i];
> +		for (i =3D 0; i < RTE_MIN(IGC_QUEUE_PAIRS_NUM, dev->data-
> >nb_rx_queues); i++) {
> +			qstats[i].q_ipackets +=3D queue_stats->pqgprc[i];
> +			qstats[i].q_ibytes +=3D queue_stats->pqgorc[i];
> +		}
> +		for (i =3D 0; i < RTE_MIN(IGC_QUEUE_PAIRS_NUM, dev->data-
> >nb_tx_queues); i++) {
> +			qstats[i].q_opackets +=3D queue_stats->pqgptc[i];
> +			qstats[i].q_obytes +=3D queue_stats->pqgotc[i];
>  		}
>  	}
>=20
> diff --git a/drivers/net/intel/fm10k/fm10k_ethdev.c
> b/drivers/net/intel/fm10k/fm10k_ethdev.c
> index ca438d2d02..3b2daba79e 100644
> --- a/drivers/net/intel/fm10k/fm10k_ethdev.c
> +++ b/drivers/net/intel/fm10k/fm10k_ethdev.c
> @@ -1328,14 +1328,16 @@ fm10k_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  	fm10k_update_hw_stats(hw, hw_stats);
>=20
>  	ipackets =3D opackets =3D ibytes =3D obytes =3D imissed =3D 0;
> -	for (i =3D 0; (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) &&
> -			(i < hw->mac.max_queues); ++i) {
> +	for (i =3D 0; i < hw->mac.max_queues; ++i) {
>  		if (qstats !=3D NULL) {
> -			qstats->q_ipackets[i] =3D hw_stats-
> >q[i].rx_packets.count;
> -			qstats->q_opackets[i] =3D hw_stats-
> >q[i].tx_packets.count;
> -			qstats->q_ibytes[i]   =3D hw_stats->q[i].rx_bytes.count;
> -			qstats->q_obytes[i]   =3D hw_stats->q[i].tx_bytes.count;
> -			qstats->q_errors[i]   =3D hw_stats->q[i].rx_drops.count;
> +			if (i < dev->data->nb_rx_queues) {
> +				qstats[i].q_ipackets =3D hw_stats-
> >q[i].rx_packets.count;
> +				qstats[i].q_ibytes   =3D hw_stats-
> >q[i].rx_bytes.count;
> +			}
> +			if (i < dev->data->nb_tx_queues) {
> +				qstats[i].q_opackets =3D hw_stats-
> >q[i].tx_packets.count;
> +				qstats[i].q_obytes   =3D hw_stats-
> >q[i].tx_bytes.count;
> +			}
>  		}
>  		ipackets +=3D hw_stats->q[i].rx_packets.count;
>  		opackets +=3D hw_stats->q[i].tx_packets.count;
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> index 5945dd047d..cbb7b4831c 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> @@ -3346,12 +3346,14 @@ ixgbe_dev_stats_get(struct rte_eth_dev *dev,
>=20
>  	if (qstats !=3D NULL) {
>  		for (i =3D 0; i < RTE_MIN_T(IXGBE_QUEUE_STAT_COUNTERS,
> -				RTE_ETHDEV_QUEUE_STAT_CNTRS, typeof(i));
> i++) {
> -			qstats->q_ipackets[i] =3D hw_stats->qprc[i];
> -			qstats->q_opackets[i] =3D hw_stats->qptc[i];
> -			qstats->q_ibytes[i] =3D hw_stats->qbrc[i];
> -			qstats->q_obytes[i] =3D hw_stats->qbtc[i];
> -			qstats->q_errors[i] =3D hw_stats->qprdc[i];
> +				dev->data->nb_rx_queues, typeof(i)); i++) {
> +			qstats[i].q_ipackets =3D hw_stats->qprc[i];
> +			qstats[i].q_ibytes =3D hw_stats->qbrc[i];
> +		}
> +		for (i =3D 0; i < RTE_MIN_T(IXGBE_QUEUE_STAT_COUNTERS,
> +				dev->data->nb_tx_queues, typeof(i)); i++) {
> +			qstats[i].q_opackets =3D hw_stats->qptc[i];
> +			qstats[i].q_obytes =3D hw_stats->qbtc[i];
>  		}
>  	}
>=20
> diff --git a/drivers/net/ionic/ionic_lif.c b/drivers/net/ionic/ionic_lif.=
c
> index b52c8cad88..2443c98881 100644
> --- a/drivers/net/ionic/ionic_lif.c
> +++ b/drivers/net/ionic/ionic_lif.c
> @@ -105,10 +105,15 @@ ionic_lif_get_abs_stats(const struct ionic_lif *lif=
,
> struct rte_eth_stats *stats
>  {
>  	struct ionic_lif_stats *ls =3D &lif->info->stats;
>  	uint32_t i;
> -	uint32_t num_rx_q_counters =3D RTE_MIN(lif->nrxqcqs, (uint32_t)
> -			RTE_ETHDEV_QUEUE_STAT_CNTRS);
> -	uint32_t num_tx_q_counters =3D RTE_MIN(lif->ntxqcqs, (uint32_t)
> -			RTE_ETHDEV_QUEUE_STAT_CNTRS);
> +	/*
> +	 * The queue stats array is indexed by queue id and sized by the
> +	 * queue counts passed to configure, which is not necessarily the
> +	 * number of queues the LIF has allocated.
> +	 */
> +	uint32_t num_rx_q_counters =3D RTE_MIN(lif->nrxqcqs,
> +			(uint32_t)lif->eth_dev->data->nb_rx_queues);
> +	uint32_t num_tx_q_counters =3D RTE_MIN(lif->ntxqcqs,
> +			(uint32_t)lif->eth_dev->data->nb_tx_queues);
>=20
>  	memset(stats, 0, sizeof(*stats));
>=20
> @@ -148,11 +153,8 @@ ionic_lif_get_abs_stats(const struct ionic_lif *lif,
> struct rte_eth_stats *stats
>  	if (qstats !=3D NULL) {
>  		for (i =3D 0; i < num_rx_q_counters; i++) {
>  			struct ionic_rx_stats *rx_stats =3D &lif->rxqcqs[i]->stats;
> -			qstats->q_ipackets[i] =3D rx_stats->packets;
> -			qstats->q_ibytes[i] =3D rx_stats->bytes;
> -			qstats->q_errors[i] =3D
> -				rx_stats->bad_cq_status +
> -				rx_stats->bad_len;
> +			qstats[i].q_ipackets =3D rx_stats->packets;
> +			qstats[i].q_ibytes =3D rx_stats->bytes;
>  		}
>  	}
>=20
> @@ -185,8 +187,8 @@ ionic_lif_get_abs_stats(const struct ionic_lif *lif, =
struct
> rte_eth_stats *stats
>  	if (qstats !=3D NULL) {
>  		for (i =3D 0; i < num_tx_q_counters; i++) {
>  			struct ionic_tx_stats *tx_stats =3D &lif->txqcqs[i]->stats;
> -			qstats->q_opackets[i] =3D tx_stats->packets;
> -			qstats->q_obytes[i] =3D tx_stats->bytes;
> +			qstats[i].q_opackets =3D tx_stats->packets;
> +			qstats[i].q_obytes =3D tx_stats->bytes;
>  		}
>  	}
>  }
> diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
> index 0b72f711a1..72c8501d3c 100644
> --- a/drivers/net/mana/mana.c
> +++ b/drivers/net/mana/mana.c
> @@ -779,9 +779,9 @@ mana_dev_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  		stats->obytes +=3D txq->stats.bytes;
>  		stats->oerrors +=3D txq->stats.errors;
>=20
> -		if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_opackets[i] =3D txq->stats.packets;
> -			qstats->q_obytes[i] =3D txq->stats.bytes;
> +		if (qstats !=3D NULL && i < dev->data->nb_tx_queues) {
> +			qstats[i].q_opackets =3D txq->stats.packets;
> +			qstats[i].q_obytes =3D txq->stats.bytes;
>  		}
>  	}
>=20
> @@ -798,9 +798,9 @@ mana_dev_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>=20
>  		/* There is no good way to get stats->imissed, not setting it */
>=20
> -		if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_ipackets[i] =3D rxq->stats.packets;
> -			qstats->q_ibytes[i] =3D rxq->stats.bytes;
> +		if (qstats !=3D NULL && i < dev->data->nb_rx_queues) {
> +			qstats[i].q_ipackets =3D rxq->stats.packets;
> +			qstats[i].q_ibytes =3D rxq->stats.bytes;
>  		}
>=20
>  		stats->rx_nombuf +=3D rxq->stats.nombuf;
> diff --git a/drivers/net/memif/rte_eth_memif.c
> b/drivers/net/memif/rte_eth_memif.c
> index 5d153c3a5a..1c8dc1d5ec 100644
> --- a/drivers/net/memif/rte_eth_memif.c
> +++ b/drivers/net/memif/rte_eth_memif.c
> @@ -1607,15 +1607,15 @@ memif_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>=20
>  	tmp =3D (pmd->role =3D=3D MEMIF_ROLE_CLIENT) ? pmd-
> >run.num_s2c_rings :
>  	    pmd->run.num_c2s_rings;
> -	nq =3D (tmp < RTE_ETHDEV_QUEUE_STAT_CNTRS) ? tmp :
> -	    RTE_ETHDEV_QUEUE_STAT_CNTRS;
> +	nq =3D (tmp < dev->data->nb_rx_queues) ? tmp :
> +	    dev->data->nb_rx_queues;
>=20
>  	/* RX stats */
>  	for (i =3D 0; i < nq; i++) {
>  		mq =3D dev->data->rx_queues[i];
>  		if (qstats !=3D NULL) {
> -			qstats->q_ipackets[i] =3D mq->n_pkts;
> -			qstats->q_ibytes[i] =3D mq->n_bytes;
> +			qstats[i].q_ipackets =3D mq->n_pkts;
> +			qstats[i].q_ibytes =3D mq->n_bytes;
>  		}
>  		stats->ipackets +=3D mq->n_pkts;
>  		stats->ibytes +=3D mq->n_bytes;
> @@ -1624,15 +1624,15 @@ memif_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>=20
>  	tmp =3D (pmd->role =3D=3D MEMIF_ROLE_CLIENT) ? pmd-
> >run.num_c2s_rings :
>  	    pmd->run.num_s2c_rings;
> -	nq =3D (tmp < RTE_ETHDEV_QUEUE_STAT_CNTRS) ? tmp :
> -	    RTE_ETHDEV_QUEUE_STAT_CNTRS;
> +	nq =3D (tmp < dev->data->nb_tx_queues) ? tmp :
> +	    dev->data->nb_tx_queues;
>=20
>  	/* TX stats */
>  	for (i =3D 0; i < nq; i++) {
>  		mq =3D dev->data->tx_queues[i];
>  		if (qstats !=3D NULL) {
> -			qstats->q_opackets[i] =3D mq->n_pkts;
> -			qstats->q_obytes[i] =3D mq->n_bytes;
> +			qstats[i].q_opackets =3D mq->n_pkts;
> +			qstats[i].q_obytes =3D mq->n_bytes;
>  		}
>  		stats->opackets +=3D mq->n_pkts;
>  		stats->obytes +=3D mq->n_bytes;
> diff --git a/drivers/net/mlx4/mlx4_ethdev.c b/drivers/net/mlx4/mlx4_ethde=
v.c
> index efc6ee4577..4ea79bf1eb 100644
> --- a/drivers/net/mlx4/mlx4_ethdev.c
> +++ b/drivers/net/mlx4/mlx4_ethdev.c
> @@ -717,11 +717,9 @@ mlx4_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  		if (rxq =3D=3D NULL)
>  			continue;
>  		idx =3D rxq->stats.idx;
> -		if (qstats !=3D NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS)
> {
> -			qstats->q_ipackets[idx] +=3D rxq->stats.ipackets;
> -			qstats->q_ibytes[idx] +=3D rxq->stats.ibytes;
> -			qstats->q_errors[idx] +=3D (rxq->stats.idropped +
> -					      rxq->stats.rx_nombuf);
> +		if (qstats !=3D NULL && idx < dev->data->nb_rx_queues) {
> +			qstats[idx].q_ipackets +=3D rxq->stats.ipackets;
> +			qstats[idx].q_ibytes +=3D rxq->stats.ibytes;
>  		}
>  		tmp.ipackets +=3D rxq->stats.ipackets;
>  		tmp.ibytes +=3D rxq->stats.ibytes;
> @@ -734,9 +732,9 @@ mlx4_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  		if (txq =3D=3D NULL)
>  			continue;
>  		idx =3D txq->stats.idx;
> -		if (qstats !=3D NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS)
> {
> -			qstats->q_opackets[idx] +=3D txq->stats.opackets;
> -			qstats->q_obytes[idx] +=3D txq->stats.obytes;
> +		if (qstats !=3D NULL && idx < dev->data->nb_tx_queues) {
> +			qstats[idx].q_opackets +=3D txq->stats.opackets;
> +			qstats[idx].q_obytes +=3D txq->stats.obytes;
>  		}
>  		tmp.opackets +=3D txq->stats.opackets;
>  		tmp.obytes +=3D txq->stats.obytes;
> diff --git a/drivers/net/mlx5/mlx5_rx.h b/drivers/net/mlx5/mlx5_rx.h
> index cd48ee37ef..0d1eee61b2 100644
> --- a/drivers/net/mlx5/mlx5_rx.h
> +++ b/drivers/net/mlx5/mlx5_rx.h
> @@ -53,9 +53,10 @@ struct mlx5_xstats_name_off {
>  	unsigned int offset;
>  };
>=20
> +/* Only used with offsetof() for the xstats names table. */
>  struct mlx5_rq_stats {
>  	/** Total number of hairpin queue packets received that are dropped.
> */
> -	uint64_t q_oobs[RTE_ETHDEV_QUEUE_STAT_CNTRS];
> +	uint64_t q_oobs;
>  };
>=20
>  /* Compressed CQE context. */
> diff --git a/drivers/net/mlx5/mlx5_stats.c b/drivers/net/mlx5/mlx5_stats.=
c
> index 5cd3e303cc..1fbd298c77 100644
> --- a/drivers/net/mlx5/mlx5_stats.c
> +++ b/drivers/net/mlx5/mlx5_stats.c
> @@ -44,7 +44,7 @@ static int
>  mlx5_rq_xstats_get(struct rte_eth_dev *dev,
>  					struct rte_eth_xstat *stats)
>  {
> -	uint16_t n_stats_rq =3D RTE_MIN(dev->data->nb_rx_queues,
> RTE_ETHDEV_QUEUE_STAT_CNTRS);
> +	uint16_t n_stats_rq =3D dev->data->nb_rx_queues;
>  	int cnt_used_entries =3D 0;
>=20
>  	for (unsigned int idx =3D 0; idx < n_stats_rq; idx++) {
> @@ -101,7 +101,7 @@ mlx5_rq_xstats_get_names(struct rte_eth_dev *dev
> __rte_unused,
>  	unsigned int i;
>  	int cnt_used_entries =3D 0;
>=20
> -	uint16_t n_stats_rq =3D RTE_MIN(dev->data->nb_rx_queues,
> RTE_ETHDEV_QUEUE_STAT_CNTRS);
> +	uint16_t n_stats_rq =3D dev->data->nb_rx_queues;
>=20
>  	for (i =3D 0; (i !=3D n_stats_rq); ++i) {
>  		rxq =3D mlx5_rxq_get(dev, i);
> @@ -227,17 +227,13 @@ mlx5_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  		if (rxq =3D=3D NULL)
>  			continue;
>  		idx =3D rxq->idx;
> -		if (qstats !=3D NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS)
> {
> +		if (qstats !=3D NULL && idx < dev->data->nb_rx_queues) {
>  #ifdef MLX5_PMD_SOFT_COUNTERS
> -			qstats->q_ipackets[idx] +=3D rxq->stats.ipackets -
> +			qstats[idx].q_ipackets +=3D rxq->stats.ipackets -
>  				rxq->stats_reset.ipackets;
> -			qstats->q_ibytes[idx] +=3D rxq->stats.ibytes -
> +			qstats[idx].q_ibytes +=3D rxq->stats.ibytes -
>  				rxq->stats_reset.ibytes;
>  #endif
> -			qstats->q_errors[idx] +=3D (rxq->stats.idropped +
> -					      rxq->stats.rx_nombuf) -
> -					      (rxq->stats_reset.idropped +
> -					      rxq->stats_reset.rx_nombuf);
>  		}
>  #ifdef MLX5_PMD_SOFT_COUNTERS
>  		tmp.ipackets +=3D rxq->stats.ipackets - rxq->stats_reset.ipackets;
> @@ -253,11 +249,11 @@ mlx5_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  		if (txq =3D=3D NULL)
>  			continue;
>  		idx =3D txq->idx;
> -		if (qstats !=3D NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS)
> {
> +		if (qstats !=3D NULL && idx < dev->data->nb_tx_queues) {
>  #ifdef MLX5_PMD_SOFT_COUNTERS
> -			qstats->q_opackets[idx] +=3D txq->stats.opackets -
> +			qstats[idx].q_opackets +=3D txq->stats.opackets -
>  						txq->stats_reset.opackets;
> -			qstats->q_obytes[idx] +=3D txq->stats.obytes -
> +			qstats[idx].q_obytes +=3D txq->stats.obytes -
>  						txq->stats_reset.obytes;
>  #endif
>  		}
> @@ -467,7 +463,7 @@ mlx5_xstats_get_names(struct rte_eth_dev *dev,
>  static struct mlx5_stat_counter_ctrl*
>  mlx5_rxq_get_counter_by_id(struct rte_eth_dev *dev, uint64_t id, uint64_=
t
> *rq_id)
>  {
> -	uint16_t n_stats_rq =3D RTE_MIN(dev->data->nb_rx_queues,
> RTE_ETHDEV_QUEUE_STAT_CNTRS);
> +	uint16_t n_stats_rq =3D dev->data->nb_rx_queues;
>=20
>  	for (int i =3D 0; (i !=3D n_stats_rq); i++) {
>  		struct mlx5_rxq_data *rxq_data =3D mlx5_rxq_data_get(dev, i);
> diff --git a/drivers/net/mvpp2/mrvl_ethdev.c
> b/drivers/net/mvpp2/mrvl_ethdev.c
> index bc947ff52e..d7ed504bee 100644
> --- a/drivers/net/mvpp2/mrvl_ethdev.c
> +++ b/drivers/net/mvpp2/mrvl_ethdev.c
> @@ -1505,10 +1505,10 @@ mrvl_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  			continue;
>=20
>  		idx =3D rxq->queue_id;
> -		if (unlikely(idx >=3D RTE_ETHDEV_QUEUE_STAT_CNTRS)) {
> +		if (unlikely(idx >=3D dev->data->nb_rx_queues)) {
>  			MRVL_LOG(ERR,
>  				"rx queue %d stats out of range (0 - %d)",
> -				idx, RTE_ETHDEV_QUEUE_STAT_CNTRS - 1);
> +				idx, dev->data->nb_rx_queues - 1);
>  			continue;
>  		}
>=20
> @@ -1523,12 +1523,8 @@ mrvl_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  		}
>=20
>  		if (qstats !=3D NULL) {
> -			qstats->q_ibytes[idx] =3D rxq->bytes_recv;
> -			qstats->q_ipackets[idx] =3D rx_stats.enq_desc - rxq-
> >drop_mac;
> -			qstats->q_errors[idx] =3D rx_stats.drop_early +
> -					       rx_stats.drop_fullq +
> -					       rx_stats.drop_bm +
> -					       rxq->drop_mac;
> +			qstats[idx].q_ibytes =3D rxq->bytes_recv;
> +			qstats[idx].q_ipackets =3D rx_stats.enq_desc - rxq-
> >drop_mac;
>  		}
>  		stats->ibytes +=3D rxq->bytes_recv;
>  		drop_mac +=3D rxq->drop_mac;
> @@ -1542,10 +1538,10 @@ mrvl_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  			continue;
>=20
>  		idx =3D txq->queue_id;
> -		if (unlikely(idx >=3D RTE_ETHDEV_QUEUE_STAT_CNTRS)) {
> +		if (unlikely(idx >=3D dev->data->nb_tx_queues)) {
>  			MRVL_LOG(ERR,
>  				"tx queue %d stats out of range (0 - %d)",
> -				idx, RTE_ETHDEV_QUEUE_STAT_CNTRS - 1);
> +				idx, dev->data->nb_tx_queues - 1);
>  			continue;
>  		}
>=20
> @@ -1558,8 +1554,8 @@ mrvl_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  		}
>=20
>  		if (qstats !=3D NULL) {
> -			qstats->q_opackets[idx] =3D tx_stats.deq_desc;
> -			qstats->q_obytes[idx] =3D txq->bytes_sent;
> +			qstats[idx].q_opackets =3D tx_stats.deq_desc;
> +			qstats[idx].q_obytes =3D txq->bytes_sent;
>  		}
>  		stats->obytes +=3D txq->bytes_sent;
>  	}
> diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c
> b/drivers/net/nbl/nbl_dev/nbl_dev.c
> index 3c0e98d687..320f26619f 100644
> --- a/drivers/net/nbl/nbl_dev/nbl_dev.c
> +++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
> @@ -534,8 +534,6 @@ int nbl_stats_get(struct rte_eth_dev *eth_dev, struct
> rte_eth_stats *rte_stats,
>  		goto update_hw_stats_fail;
>=20
>  	for (i =3D 0; i < eth_dev->data->nb_rx_queues; i++) {
> -		if (qstats && i < RTE_ETHDEV_QUEUE_STAT_CNTRS)
> -			qstats->q_errors[i] =3D net_dev-
> >hw_stats.total_uvn_stat_pkt_drop[i];
>  		rte_stats->imissed +=3D net_dev-
> >hw_stats.total_uvn_stat_pkt_drop[i];
>  	}
>=20
> diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.c
> b/drivers/net/nbl/nbl_hw/nbl_txrx.c
> index f29f0a6d5b..7beae85177 100644
> --- a/drivers/net/nbl/nbl_hw/nbl_txrx.c
> +++ b/drivers/net/nbl/nbl_hw/nbl_txrx.c
> @@ -795,10 +795,10 @@ static int nbl_res_txrx_get_stats(void *priv, struc=
t
> rte_eth_stats *rte_stats,
>  		rxq_stats_reset =3D &rxq->rxq_stats_reset;
>  		idx =3D rxq->queue_id;
>=20
> -		if (qstats && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_ipackets[idx] +=3D rxq_stats->rx_packets -
> +		if (qstats && idx < eth_dev->data->nb_rx_queues) {
> +			qstats[idx].q_ipackets +=3D rxq_stats->rx_packets -
>  							rxq_stats_reset-
> >rx_packets;
> -			qstats->q_ibytes[idx] +=3D rxq_stats->rx_bytes -
> rxq_stats_reset->rx_bytes;
> +			qstats[idx].q_ibytes +=3D rxq_stats->rx_bytes -
> rxq_stats_reset->rx_bytes;
>  		}
>  		rte_stats->ipackets +=3D rxq_stats->rx_packets - rxq_stats_reset-
> >rx_packets;
>  		rte_stats->ibytes +=3D rxq_stats->rx_bytes - rxq_stats_reset-
> >rx_bytes;
> @@ -814,10 +814,10 @@ static int nbl_res_txrx_get_stats(void *priv, struc=
t
> rte_eth_stats *rte_stats,
>  		txq_stats_reset =3D &txq->txq_stats_reset;
>  		idx =3D txq->queue_id;
>=20
> -		if (qstats && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_opackets[idx] +=3D txq_stats->tx_packets -
> +		if (qstats && idx < eth_dev->data->nb_tx_queues) {
> +			qstats[idx].q_opackets +=3D txq_stats->tx_packets -
>  							txq_stats_reset-
> >tx_packets;
> -			qstats->q_obytes[idx] +=3D txq_stats->tx_bytes -
> txq_stats_reset->tx_bytes;
> +			qstats[idx].q_obytes +=3D txq_stats->tx_bytes -
> txq_stats_reset->tx_bytes;
>  		}
>  		rte_stats->opackets +=3D txq_stats->tx_packets -
> txq_stats_reset->tx_packets;
>  		rte_stats->obytes +=3D txq_stats->tx_bytes - txq_stats_reset-
> >tx_bytes;
> diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethde=
v.c
> index 9a193e4a7a..e4fdf89873 100644
> --- a/drivers/net/netvsc/hn_ethdev.c
> +++ b/drivers/net/netvsc/hn_ethdev.c
> @@ -1122,9 +1122,9 @@ static int hn_dev_stats_get(struct rte_eth_dev *dev=
,
>  		stats->obytes +=3D txq->stats.bytes;
>  		stats->oerrors +=3D txq->stats.errors;
>=20
> -		if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_opackets[i] +=3D txq->stats.packets;
> -			qstats->q_obytes[i] +=3D txq->stats.bytes;
> +		if (qstats !=3D NULL) {
> +			qstats[i].q_opackets +=3D txq->stats.packets;
> +			qstats[i].q_obytes +=3D txq->stats.bytes;
>  		}
>  	}
>=20
> @@ -1139,9 +1139,9 @@ static int hn_dev_stats_get(struct rte_eth_dev *dev=
,
>  		stats->ierrors +=3D rxq->stats.errors;
>  		stats->imissed +=3D rxq->stats.ring_full;
>=20
> -		if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_ipackets[i] +=3D rxq->stats.packets;
> -			qstats->q_ibytes[i] +=3D rxq->stats.bytes;
> +		if (qstats !=3D NULL) {
> +			qstats[i].q_ipackets +=3D rxq->stats.packets;
> +			qstats[i].q_ibytes +=3D rxq->stats.bytes;
>  		}
>  	}
>=20
> diff --git a/drivers/net/netvsc/hn_vf.c b/drivers/net/netvsc/hn_vf.c
> index 27c46ce404..96e811278a 100644
> --- a/drivers/net/netvsc/hn_vf.c
> +++ b/drivers/net/netvsc/hn_vf.c
> @@ -927,7 +927,8 @@ int hn_vf_stats_get(struct rte_eth_dev *dev,
>  		 * rte_eth_stats_get API because we need to forward the
>  		 * per-queue stats (qstats) which the public API does not
>  		 * support.  The caller (eth_stats_qstats_get) has already
> -		 * zeroed stats and qstats before invoking this callback.
> +		 * zeroed stats, and qstats is zeroed by its allocation,
> +		 * before invoking this callback.
>  		 */
>  		if (vf_dev->dev_ops->stats_get !=3D NULL)
>  			ret =3D vf_dev->dev_ops->stats_get(vf_dev, stats,
> diff --git a/drivers/net/nfb/nfb_stats.c b/drivers/net/nfb/nfb_stats.c
> index f7a0189ffe..0b4bdc7d18 100644
> --- a/drivers/net/nfb/nfb_stats.c
> +++ b/drivers/net/nfb/nfb_stats.c
> @@ -25,9 +25,9 @@ nfb_eth_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  		if (rx_queue =3D=3D NULL)
>  			continue;
>=20
> -		if (qstats && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_ipackets[i] =3D rx_queue->rx_pkts;
> -			qstats->q_ibytes[i] =3D rx_queue->rx_bytes;
> +		if (qstats && i < dev->data->nb_rx_queues) {
> +			qstats[i].q_ipackets =3D rx_queue->rx_pkts;
> +			qstats[i].q_ibytes =3D rx_queue->rx_bytes;
>  		}
>  	}
>=20
> @@ -36,9 +36,9 @@ nfb_eth_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  		if (tx_queue =3D=3D NULL)
>  			continue;
>=20
> -		if (qstats && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_opackets[i] =3D tx_queue->tx_pkts;
> -			qstats->q_obytes[i] =3D tx_queue->tx_bytes;
> +		if (qstats && i < dev->data->nb_tx_queues) {
> +			qstats[i].q_opackets =3D tx_queue->tx_pkts;
> +			qstats[i].q_obytes =3D tx_queue->tx_bytes;
>  		}
>  	}
>=20
> diff --git a/drivers/net/nfp/flower/nfp_flower.c
> b/drivers/net/nfp/flower/nfp_flower.c
> index 4eeb9aee3b..14a8992376 100644
> --- a/drivers/net/nfp/flower/nfp_flower.c
> +++ b/drivers/net/nfp/flower/nfp_flower.c
> @@ -238,8 +238,8 @@ nfp_flower_multiple_pf_recv_pkts(void *rx_queue,
>  		for (i =3D 0; i < recv; i++)
>  			data_len +=3D rx_pkts[i]->data_len;
>=20
> -		repr->repr_qstats.q_ipackets[rxq->qidx] +=3D recv;
> -		repr->repr_qstats.q_ibytes[rxq->qidx] +=3D data_len;
> +		repr->repr_qstats[rxq->qidx].q_ipackets +=3D recv;
> +		repr->repr_qstats[rxq->qidx].q_ibytes +=3D data_len;
>  	}
>=20
>  	return recv;
> @@ -276,8 +276,8 @@ nfp_flower_multiple_pf_xmit_pkts(void *tx_queue,
>  		for (i =3D 0; i < sent; i++)
>  			data_len +=3D tx_pkts[i]->data_len;
>=20
> -		repr->repr_qstats.q_opackets[txq->qidx] +=3D sent;
> -		repr->repr_qstats.q_obytes[txq->qidx] +=3D data_len;
> +		repr->repr_qstats[txq->qidx].q_opackets +=3D sent;
> +		repr->repr_qstats[txq->qidx].q_obytes +=3D data_len;
>  	}
>=20
>  	return sent;
> diff --git a/drivers/net/nfp/flower/nfp_flower_representor.c
> b/drivers/net/nfp/flower/nfp_flower_representor.c
> index 9b984dbc8d..231a76980d 100644
> --- a/drivers/net/nfp/flower/nfp_flower_representor.c
> +++ b/drivers/net/nfp/flower/nfp_flower_representor.c
> @@ -324,15 +324,15 @@ nfp_flower_repr_stats_get(struct rte_eth_dev
> *ethdev,
>  	repr->repr_stats.ipackets =3D 0;
>  	repr->repr_stats.ibytes =3D 0;
>  	for (i =3D 0; i < ethdev->data->nb_rx_queues; i++) {
> -		repr->repr_stats.ipackets +=3D repr->repr_qstats.q_ipackets[i];
> -		repr->repr_stats.ibytes +=3D repr->repr_qstats.q_ibytes[i];
> +		repr->repr_stats.ipackets +=3D repr->repr_qstats[i].q_ipackets;
> +		repr->repr_stats.ibytes +=3D repr->repr_qstats[i].q_ibytes;
>  	}
>=20
>  	repr->repr_stats.opackets =3D 0;
>  	repr->repr_stats.obytes =3D 0;
>  	for (i =3D 0; i < ethdev->data->nb_tx_queues; i++) {
> -		repr->repr_stats.opackets +=3D repr->repr_qstats.q_opackets[i];
> -		repr->repr_stats.obytes +=3D repr->repr_qstats.q_obytes[i];
> +		repr->repr_stats.opackets +=3D repr->repr_qstats[i].q_opackets;
> +		repr->repr_stats.obytes +=3D repr->repr_qstats[i].q_obytes;
>  	}
>=20
>  	*stats =3D repr->repr_stats;
> @@ -347,7 +347,8 @@ nfp_flower_repr_stats_reset(struct rte_eth_dev
> *ethdev)
>=20
>  	repr =3D ethdev->data->dev_private;
>  	memset(&repr->repr_stats, 0, sizeof(struct rte_eth_stats));
> -	memset(&repr->repr_qstats, 0, sizeof(struct eth_queue_stats));
> +	memset(repr->repr_qstats, 0,
> +			sizeof(struct eth_queue_stats) * repr-
> >repr_nb_qstats);
>=20
>  	return 0;
>  }
> @@ -403,8 +404,8 @@ nfp_flower_repr_rx_burst(void *rx_queue,
>  		for (i =3D 0; i < total_dequeue; i++)
>  			data_len +=3D rx_pkts[i]->data_len;
>=20
> -		repr->repr_qstats.q_ipackets[rxq->qidx] +=3D total_dequeue;
> -		repr->repr_qstats.q_ibytes[rxq->qidx] +=3D data_len;
> +		repr->repr_qstats[rxq->qidx].q_ipackets +=3D total_dequeue;
> +		repr->repr_qstats[rxq->qidx].q_ibytes +=3D data_len;
>  	}
>=20
>  	return total_dequeue;
> @@ -451,8 +452,8 @@ nfp_flower_repr_tx_burst(void *tx_queue,
>  		for (i =3D 0; i < sent; i++)
>  			data_len +=3D tx_pkts[i]->data_len;
>=20
> -		repr->repr_qstats.q_opackets[txq->qidx] +=3D sent;
> -		repr->repr_qstats.q_obytes[txq->qidx] +=3D data_len;
> +		repr->repr_qstats[txq->qidx].q_opackets +=3D sent;
> +		repr->repr_qstats[txq->qidx].q_obytes +=3D data_len;
>  	}
>=20
>  	return sent;
> @@ -528,6 +529,7 @@ nfp_flower_repr_uninit(struct rte_eth_dev *eth_dev)
>=20
>  	repr =3D eth_dev->data->dev_private;
>  	nfp_flower_repr_base_uninit(repr);
> +	rte_free(repr->repr_qstats);
>  	rte_free(repr->ring);
>=20
>  	if (nfp_flower_repr_is_phy(repr)) {
> @@ -893,6 +895,17 @@ nfp_flower_repr_init(struct rte_eth_dev *eth_dev,
>  		return -ENOMEM;
>  	}
>=20
> +	repr->repr_nb_qstats =3D RTE_MAX(app_fw_flower->pf_hw-
> >max_rx_queues,
> +			app_fw_flower->pf_hw->max_tx_queues);
> +	repr->repr_qstats =3D rte_zmalloc_socket("nfp_repr_qstats",
> +			sizeof(struct eth_queue_stats) * repr-
> >repr_nb_qstats,
> +			RTE_CACHE_LINE_SIZE, numa_node);
> +	if (repr->repr_qstats =3D=3D NULL) {
> +		PMD_DRV_LOG(ERR, "Queue stats alloc failed for %s.",
> ring_name);
> +		rte_free(repr->ring);
> +		return -ENOMEM;
> +	}
> +
>  	eth_dev->dev_ops =3D &nfp_flower_repr_dev_ops;
>  	eth_dev->rx_pkt_burst =3D nfp_flower_repr_rx_burst;
>  	eth_dev->tx_pkt_burst =3D nfp_flower_repr_tx_burst;
> @@ -928,6 +941,7 @@ nfp_flower_repr_init(struct rte_eth_dev *eth_dev,
>  	return 0;
>=20
>  ring_cleanup:
> +	rte_free(repr->repr_qstats);
>  	rte_free(repr->ring);
>=20
>  	return ret;
> diff --git a/drivers/net/nfp/flower/nfp_flower_representor.h
> b/drivers/net/nfp/flower/nfp_flower_representor.h
> index 66714d9a51..74e09749f6 100644
> --- a/drivers/net/nfp/flower/nfp_flower_representor.h
> +++ b/drivers/net/nfp/flower/nfp_flower_representor.h
> @@ -22,7 +22,9 @@ struct nfp_flower_representor {
>  	struct rte_ring **ring;
>  	struct rte_eth_link link;
>  	struct rte_eth_stats repr_stats;
> -	struct eth_queue_stats repr_qstats;
> +	/** Per-queue counters, one entry per queue */
> +	struct eth_queue_stats *repr_qstats;
> +	uint16_t repr_nb_qstats;
>=20
>  	struct rte_eth_xstat *repr_xstats_base;
>  	uint8_t *mac_stats;
> diff --git a/drivers/net/nfp/nfp_ethdev.c b/drivers/net/nfp/nfp_ethdev.c
> index d2da18013c..2f7ce812e4 100644
> --- a/drivers/net/nfp/nfp_ethdev.c
> +++ b/drivers/net/nfp/nfp_ethdev.c
> @@ -663,6 +663,7 @@ nfp_net_uninit(struct rte_eth_dev *eth_dev)
>  	if ((net_hw->super.cap_ext & NFP_NET_CFG_CTRL_FLOW_STEER) !=3D 0)
>  		nfp_net_flow_priv_uninit(hw_priv->pf_dev, net_hw->idx);
>=20
> +	rte_free(net_hw->eth_qstats_base);
>  	rte_free(net_hw->eth_xstats_base);
>  	if ((net_hw->super.cap & NFP_NET_CFG_CTRL_TXRWB) !=3D 0)
>  		nfp_net_txrwb_free(eth_dev);
> @@ -1091,6 +1092,17 @@ nfp_net_init(struct rte_eth_dev *eth_dev,
>  		goto ipsec_exit;
>  	}
>=20
> +	net_hw->eth_qstats_base =3D rte_calloc("eth_queue_stats",
> +			RTE_MAX(net_hw->max_rx_queues, net_hw-
> >max_tx_queues),
> +			sizeof(struct eth_queue_stats), 0);
> +	if (net_hw->eth_qstats_base =3D=3D NULL) {
> +		PMD_INIT_LOG(ERR, "No memory for queue stats base values
> on device %s!",
> +				pci_dev->device.name);
> +		rte_free(net_hw->eth_xstats_base);
> +		err =3D -ENOMEM;
> +		goto ipsec_exit;
> +	}
> +
>  	/* Work out where in the BAR the queues start. */
>  	tx_base =3D nn_cfg_readl(hw, NFP_NET_CFG_START_TXQ);
>  	rx_base =3D nn_cfg_readl(hw, NFP_NET_CFG_START_RXQ);
> @@ -1183,6 +1195,7 @@ nfp_net_init(struct rte_eth_dev *eth_dev,
>  	if ((hw->cap & NFP_NET_CFG_CTRL_TXRWB) !=3D 0)
>  		nfp_net_txrwb_free(eth_dev);
>  xstats_free:
> +	rte_free(net_hw->eth_qstats_base);
>  	rte_free(net_hw->eth_xstats_base);
>  ipsec_exit:
>  	nfp_ipsec_uninit(eth_dev);
> diff --git a/drivers/net/nfp/nfp_ethdev_vf.c b/drivers/net/nfp/nfp_ethdev=
_vf.c
> index a86cc36592..d81a5052b9 100644
> --- a/drivers/net/nfp/nfp_ethdev_vf.c
> +++ b/drivers/net/nfp/nfp_ethdev_vf.c
> @@ -172,6 +172,7 @@ nfp_netvf_close(struct rte_eth_dev *dev)
>  	pci_dev =3D RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
>  	hw_priv =3D dev->process_private;
>=20
> +	rte_free(net_hw->eth_qstats_base);
>  	rte_free(net_hw->eth_xstats_base);
>  	rte_free(hw_priv);
>=20
> @@ -339,6 +340,17 @@ nfp_netvf_init(struct rte_eth_dev *eth_dev)
>  		goto hw_priv_free;
>  	}
>=20
> +	net_hw->eth_qstats_base =3D rte_calloc("eth_queue_stats",
> +			RTE_MAX(net_hw->max_rx_queues, net_hw-
> >max_tx_queues),
> +			sizeof(struct eth_queue_stats), 0);
> +	if (net_hw->eth_qstats_base =3D=3D NULL) {
> +		PMD_INIT_LOG(ERR, "No memory for queue stats base values
> on device %s!",
> +				pci_dev->device.name);
> +		rte_free(net_hw->eth_xstats_base);
> +		err =3D -ENOMEM;
> +		goto hw_priv_free;
> +	}
> +
>  	/* Work out where in the BAR the queues start. */
>  	start_q =3D nn_cfg_readl(hw, NFP_NET_CFG_START_TXQ);
>  	tx_bar_off =3D nfp_qcp_queue_offset(dev_info, start_q);
> @@ -406,6 +418,7 @@ nfp_netvf_init(struct rte_eth_dev *eth_dev)
>  	return 0;
>=20
>  free_xstats:
> +	rte_free(net_hw->eth_qstats_base);
>  	rte_free(net_hw->eth_xstats_base);
>  hw_priv_free:
>  	rte_free(hw_priv);
> diff --git a/drivers/net/nfp/nfp_net_common.c
> b/drivers/net/nfp/nfp_net_common.c
> index 2d36311cfe..afa0bc0faf 100644
> --- a/drivers/net/nfp/nfp_net_common.c
> +++ b/drivers/net/nfp/nfp_net_common.c
> @@ -919,35 +919,29 @@ nfp_net_stats_get(struct rte_eth_dev *dev,
>=20
>  	/* Reading per RX ring stats */
>  	for (i =3D 0; i < dev->data->nb_rx_queues; i++) {
> -		if (i =3D=3D RTE_ETHDEV_QUEUE_STAT_CNTRS)
> -			break;
> -
>  		uint64_t q_ipackets =3D nn_cfg_readq(&hw->super,
> NFP_NET_CFG_RXR_STATS(i));
> -		q_ipackets -=3D hw->eth_qstats_base.q_ipackets[i];
> +		q_ipackets -=3D hw->eth_qstats_base[i].q_ipackets;
>=20
>  		uint64_t q_ibytes =3D nn_cfg_readq(&hw->super,
> NFP_NET_CFG_RXR_STATS(i) + 0x8);
> -		q_ibytes -=3D hw->eth_qstats_base.q_ibytes[i];
> +		q_ibytes -=3D hw->eth_qstats_base[i].q_ibytes;
>=20
>  		if (qstats !=3D NULL) {
> -			qstats->q_ipackets[i] =3D q_ipackets;
> -			qstats->q_ibytes[i] =3D q_ibytes;
> +			qstats[i].q_ipackets =3D q_ipackets;
> +			qstats[i].q_ibytes =3D q_ibytes;
>  		}
>  	}
>=20
>  	/* Reading per TX ring stats */
>  	for (i =3D 0; i < dev->data->nb_tx_queues; i++) {
> -		if (i =3D=3D RTE_ETHDEV_QUEUE_STAT_CNTRS)
> -			break;
> -
>  		uint64_t q_opackets =3D nn_cfg_readq(&hw->super,
> NFP_NET_CFG_TXR_STATS(i));
> -		q_opackets -=3D hw->eth_qstats_base.q_opackets[i];
> +		q_opackets -=3D hw->eth_qstats_base[i].q_opackets;
>=20
>  		uint64_t q_obytes =3D nn_cfg_readq(&hw->super,
> NFP_NET_CFG_TXR_STATS(i) + 0x8);
> -		q_obytes -=3D hw->eth_qstats_base.q_obytes[i];
> +		q_obytes -=3D hw->eth_qstats_base[i].q_obytes;
>=20
>  		if (qstats !=3D NULL) {
> -			qstats->q_opackets[i] =3D q_opackets;
> -			qstats->q_obytes[i] =3D q_obytes;
> +			qstats[i].q_opackets =3D q_opackets;
> +			qstats[i].q_obytes =3D q_obytes;
>  		}
>  	}
>=20
> @@ -999,25 +993,19 @@ nfp_net_stats_reset(struct rte_eth_dev *dev)
>=20
>  	/* Reading per RX ring stats */
>  	for (i =3D 0; i < dev->data->nb_rx_queues; i++) {
> -		if (i =3D=3D RTE_ETHDEV_QUEUE_STAT_CNTRS)
> -			break;
> -
> -		hw->eth_qstats_base.q_ipackets[i] =3D
> +		hw->eth_qstats_base[i].q_ipackets =3D
>  				nn_cfg_readq(&hw->super,
> NFP_NET_CFG_RXR_STATS(i));
>=20
> -		hw->eth_qstats_base.q_ibytes[i] =3D
> +		hw->eth_qstats_base[i].q_ibytes =3D
>  				nn_cfg_readq(&hw->super,
> NFP_NET_CFG_RXR_STATS(i) + 0x8);
>  	}
>=20
>  	/* Reading per TX ring stats */
>  	for (i =3D 0; i < dev->data->nb_tx_queues; i++) {
> -		if (i =3D=3D RTE_ETHDEV_QUEUE_STAT_CNTRS)
> -			break;
> -
> -		hw->eth_qstats_base.q_opackets[i] =3D
> +		hw->eth_qstats_base[i].q_opackets =3D
>  				nn_cfg_readq(&hw->super,
> NFP_NET_CFG_TXR_STATS(i));
>=20
> -		hw->eth_qstats_base.q_obytes[i] =3D
> +		hw->eth_qstats_base[i].q_obytes =3D
>  				nn_cfg_readq(&hw->super,
> NFP_NET_CFG_TXR_STATS(i) + 0x8);
>  	}
>=20
> diff --git a/drivers/net/nfp/nfp_net_common.h
> b/drivers/net/nfp/nfp_net_common.h
> index 2bd2d54028..51082c6d29 100644
> --- a/drivers/net/nfp/nfp_net_common.h
> +++ b/drivers/net/nfp/nfp_net_common.h
> @@ -250,7 +250,8 @@ struct nfp_net_hw {
>=20
>  	/** Records starting point for counters */
>  	struct rte_eth_stats eth_stats_base;
> -	struct eth_queue_stats eth_qstats_base;
> +	/** Per-queue counters, one entry per queue */
> +	struct eth_queue_stats *eth_qstats_base;
>  	struct rte_eth_xstat *eth_xstats_base;
>=20
>  	struct nfp_cpp_area *ctrl_area;
> diff --git a/drivers/net/ngbe/ngbe_ethdev.c b/drivers/net/ngbe/ngbe_ethde=
v.c
> index 09bcd791ed..dc8e65ecc2 100644
> --- a/drivers/net/ngbe/ngbe_ethdev.c
> +++ b/drivers/net/ngbe/ngbe_ethdev.c
> @@ -1498,10 +1498,8 @@ ngbe_dev_stats_get(struct rte_eth_dev *dev,
> struct rte_eth_stats *stats,
>  {
>  	struct ngbe_hw *hw =3D ngbe_dev_hw(dev);
>  	struct ngbe_hw_stats *hw_stats =3D NGBE_DEV_STATS(dev);
> -	struct ngbe_stat_mappings *stat_mappings =3D
> -			NGBE_DEV_STAT_MAPPINGS(dev);
>  	struct ngbe_tx_queue *txq;
> -	uint32_t i, j;
> +	uint32_t i;
>=20
>  	ngbe_read_stats_registers(hw, hw_stats);
>=20
> @@ -1515,29 +1513,13 @@ ngbe_dev_stats_get(struct rte_eth_dev *dev,
> struct rte_eth_stats *stats,
>  	stats->obytes =3D hw_stats->tx_bytes;
>=20
>  	if (qstats !=3D NULL) {
> -		memset(&qstats->q_ipackets, 0, sizeof(qstats->q_ipackets));
> -		memset(&qstats->q_opackets, 0, sizeof(qstats->q_opackets));
> -		memset(&qstats->q_ibytes, 0, sizeof(qstats->q_ibytes));
> -		memset(&qstats->q_obytes, 0, sizeof(qstats->q_obytes));
> -		memset(&qstats->q_errors, 0, sizeof(qstats->q_errors));
> -		for (i =3D 0; i < NGBE_MAX_QP; i++) {
> -			uint32_t n =3D i / NB_QMAP_FIELDS_PER_QSM_REG;
> -			uint32_t offset =3D (i %
> NB_QMAP_FIELDS_PER_QSM_REG) * 8;
> -			uint32_t q_map;
> -
> -			q_map =3D (stat_mappings->rqsm[n] >> offset)
> -					&
> QMAP_FIELD_RESERVED_BITS_MASK;
> -			j =3D (q_map < RTE_ETHDEV_QUEUE_STAT_CNTRS
> -			     ? q_map : q_map %
> RTE_ETHDEV_QUEUE_STAT_CNTRS);
> -			qstats->q_ipackets[j] +=3D hw_stats-
> >qp[i].rx_qp_packets;
> -			qstats->q_ibytes[j] +=3D hw_stats->qp[i].rx_qp_bytes;
> -
> -			q_map =3D (stat_mappings->tqsm[n] >> offset)
> -					&
> QMAP_FIELD_RESERVED_BITS_MASK;
> -			j =3D (q_map < RTE_ETHDEV_QUEUE_STAT_CNTRS
> -			     ? q_map : q_map %
> RTE_ETHDEV_QUEUE_STAT_CNTRS);
> -			qstats->q_opackets[j] +=3D hw_stats-
> >qp[i].tx_qp_packets;
> -			qstats->q_obytes[j] +=3D hw_stats->qp[i].tx_qp_bytes;
> +		for (i =3D 0; i < NGBE_MAX_QP && i < dev->data->nb_rx_queues;
> i++) {
> +			qstats[i].q_ipackets +=3D hw_stats->qp[i].rx_qp_packets;
> +			qstats[i].q_ibytes +=3D hw_stats->qp[i].rx_qp_bytes;
> +		}
> +		for (i =3D 0; i < NGBE_MAX_QP && i < dev->data->nb_tx_queues;
> i++) {
> +			qstats[i].q_opackets +=3D hw_stats-
> >qp[i].tx_qp_packets;
> +			qstats[i].q_obytes +=3D hw_stats->qp[i].tx_qp_bytes;
>  		}
>  	}
>=20
> diff --git a/drivers/net/ngbe/ngbe_ethdev.h b/drivers/net/ngbe/ngbe_ethde=
v.h
> index 4f8dcff00e..12ee884ce1 100644
> --- a/drivers/net/ngbe/ngbe_ethdev.h
> +++ b/drivers/net/ngbe/ngbe_ethdev.h
> @@ -61,14 +61,6 @@ struct ngbe_interrupt {
>  	uint64_t mask_orig; /* save mask during delayed handler */
>  };
>=20
> -#define NGBE_NB_STAT_MAPPING  32
> -#define NB_QMAP_FIELDS_PER_QSM_REG 4
> -#define QMAP_FIELD_RESERVED_BITS_MASK 0x0f
> -struct ngbe_stat_mappings {
> -	uint32_t tqsm[NGBE_NB_STAT_MAPPING];
> -	uint32_t rqsm[NGBE_NB_STAT_MAPPING];
> -};
> -
>  struct ngbe_vfta {
>  	uint32_t vfta[NGBE_VFTA_SIZE];
>  };
> @@ -127,7 +119,6 @@ struct ngbe_adapter {
>  	struct ngbe_hw             hw;
>  	struct ngbe_hw_stats       stats;
>  	struct ngbe_interrupt      intr;
> -	struct ngbe_stat_mappings  stat_mappings;
>  	struct ngbe_vfta           shadow_vfta;
>  	struct ngbe_hwstrip        hwstrip;
>  	struct ngbe_vf_info        *vfdata;
> @@ -171,9 +162,6 @@ ngbe_dev_intr(struct rte_eth_dev *dev)
>  	return intr;
>  }
>=20
> -#define NGBE_DEV_STAT_MAPPINGS(dev) \
> -	(&((struct ngbe_adapter *)(dev)->data->dev_private)->stat_mappings)
> -
>  #define NGBE_DEV_VFTA(dev) \
>  	(&((struct ngbe_adapter *)(dev)->data->dev_private)->shadow_vfta)
>=20
> diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_e=
thdev.c
> index bee34d20d7..effaf7cade 100644
> --- a/drivers/net/ntnic/ntnic_ethdev.c
> +++ b/drivers/net/ntnic/ntnic_ethdev.c
> @@ -197,18 +197,18 @@ static int dpdk_stats_collect(struct pmd_internals
> *internals, struct rte_eth_st
>  	ntnic_filter_ops->poll_statistics(internals);
>=20
>  	for (i =3D 0; i < internals->nb_rx_queues; i++) {
> -		if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_ipackets[i] =3D internals->rxq_scg[i].rx_pkts;
> -			qstats->q_ibytes[i] =3D internals->rxq_scg[i].rx_bytes;
> +		if (qstats !=3D NULL) {
> +			qstats[i].q_ipackets =3D internals->rxq_scg[i].rx_pkts;
> +			qstats[i].q_ibytes =3D internals->rxq_scg[i].rx_bytes;
>  		}
>  		rx_total +=3D internals->rxq_scg[i].rx_pkts;
>  		rx_total_b +=3D internals->rxq_scg[i].rx_bytes;
>  	}
>=20
>  	for (i =3D 0; i < internals->nb_tx_queues; i++) {
> -		if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_opackets[i] =3D internals->txq_scg[i].tx_pkts;
> -			qstats->q_obytes[i] =3D internals->txq_scg[i].tx_bytes;
> +		if (qstats !=3D NULL) {
> +			qstats[i].q_opackets =3D internals->txq_scg[i].tx_pkts;
> +			qstats[i].q_obytes =3D internals->txq_scg[i].tx_bytes;
>  		}
>  		tx_total +=3D internals->txq_scg[i].tx_pkts;
>  		tx_total_b +=3D internals->txq_scg[i].tx_bytes;
> diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_n=
ull.c
> index 7fba3a661b..a469825cb6 100644
> --- a/drivers/net/null/rte_eth_null.c
> +++ b/drivers/net/null/rte_eth_null.c
> @@ -332,9 +332,9 @@ eth_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  		stats->ipackets +=3D pkts;
>  		stats->ibytes +=3D bytes;
>=20
> -		if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_ipackets[i] =3D pkts;
> -			qstats->q_ibytes[i] =3D bytes;
> +		if (qstats !=3D NULL && i < dev->data->nb_rx_queues) {
> +			qstats[i].q_ipackets =3D pkts;
> +			qstats[i].q_ibytes =3D bytes;
>  		}
>  	}
>=20
> @@ -348,9 +348,9 @@ eth_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  		stats->opackets +=3D pkts;
>  		stats->obytes +=3D bytes;
>=20
> -		if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_opackets[i] =3D pkts;
> -			qstats->q_obytes[i] =3D bytes;
> +		if (qstats !=3D NULL && i < dev->data->nb_tx_queues) {
> +			qstats[i].q_opackets =3D pkts;
> +			qstats[i].q_obytes =3D bytes;
>  		}
>  	}
>=20
> diff --git a/drivers/net/octeon_ep/otx_ep_ethdev.c
> b/drivers/net/octeon_ep/otx_ep_ethdev.c
> index 876d2f9d7d..85b3c09155 100644
> --- a/drivers/net/octeon_ep/otx_ep_ethdev.c
> +++ b/drivers/net/octeon_ep/otx_ep_ethdev.c
> @@ -626,9 +626,9 @@ otx_ep_dev_stats_get(struct rte_eth_dev *eth_dev,
>=20
>  	for (i =3D 0; i < otx_epvf->nb_tx_queues; i++) {
>  		ostats =3D &otx_epvf->instr_queue[i]->stats;
> -		if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_opackets[i] =3D ostats->tx_pkts;
> -			qstats->q_obytes[i] =3D ostats->tx_bytes;
> +		if (qstats !=3D NULL && i < eth_dev->data->nb_tx_queues) {
> +			qstats[i].q_opackets =3D ostats->tx_pkts;
> +			qstats[i].q_obytes =3D ostats->tx_bytes;
>  		}
>  		stats->opackets +=3D ostats->tx_pkts;
>  		stats->obytes +=3D ostats->tx_bytes;
> @@ -636,10 +636,9 @@ otx_ep_dev_stats_get(struct rte_eth_dev *eth_dev,
>  	}
>  	for (i =3D 0; i < otx_epvf->nb_rx_queues; i++) {
>  		istats =3D &otx_epvf->droq[i]->stats;
> -		if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_ipackets[i] =3D istats->pkts_received;
> -			qstats->q_ibytes[i] =3D istats->bytes_received;
> -			qstats->q_errors[i] =3D istats->rx_err;
> +		if (qstats !=3D NULL && i < eth_dev->data->nb_rx_queues) {
> +			qstats[i].q_ipackets =3D istats->pkts_received;
> +			qstats[i].q_ibytes =3D istats->bytes_received;
>  		}
>  		stats->ipackets +=3D istats->pkts_received;
>  		stats->ibytes +=3D istats->bytes_received;
> diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethde=
v.c
> index 08d3ab9e91..b1f3718c8a 100644
> --- a/drivers/net/pcap/pcap_ethdev.c
> +++ b/drivers/net/pcap/pcap_ethdev.c
> @@ -1075,11 +1075,10 @@ eth_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  	unsigned long tx_packets_err_total =3D 0;
>  	const struct pmd_internals *internal =3D dev->data->dev_private;
>=20
> -	for (i =3D 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
> -			i < dev->data->nb_rx_queues; i++) {
> +	for (i =3D 0; i < dev->data->nb_rx_queues; i++) {
>  		if (qstats !=3D NULL) {
> -			qstats->q_ipackets[i] =3D internal-
> >rx_queue[i].rx_stat.pkts;
> -			qstats->q_ibytes[i] =3D internal-
> >rx_queue[i].rx_stat.bytes;
> +			qstats[i].q_ipackets =3D internal-
> >rx_queue[i].rx_stat.pkts;
> +			qstats[i].q_ibytes =3D internal-
> >rx_queue[i].rx_stat.bytes;
>  		}
>  		rx_nombuf_total +=3D internal->rx_queue[i].rx_stat.rx_nombuf;
>  		rx_err_total +=3D internal->rx_queue[i].rx_stat.err_pkts;
> @@ -1088,11 +1087,10 @@ eth_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  		rx_missed_total +=3D queue_missed_stat_get(dev, i);
>  	}
>=20
> -	for (i =3D 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
> -			i < dev->data->nb_tx_queues; i++) {
> +	for (i =3D 0; i < dev->data->nb_tx_queues; i++) {
>  		if (qstats !=3D NULL) {
> -			qstats->q_opackets[i] =3D internal-
> >tx_queue[i].tx_stat.pkts;
> -			qstats->q_obytes[i] =3D internal-
> >tx_queue[i].tx_stat.bytes;
> +			qstats[i].q_opackets =3D internal-
> >tx_queue[i].tx_stat.pkts;
> +			qstats[i].q_obytes =3D internal-
> >tx_queue[i].tx_stat.bytes;
>  		}
>  		tx_packets_total +=3D internal->tx_queue[i].tx_stat.pkts;
>  		tx_bytes_total +=3D internal->tx_queue[i].tx_stat.bytes;
> diff --git a/drivers/net/qede/qede_ethdev.c b/drivers/net/qede/qede_ethde=
v.c
> index 4efc2dd349..b5bbcd6625 100644
> --- a/drivers/net/qede/qede_ethdev.c
> +++ b/drivers/net/qede/qede_ethdev.c
> @@ -397,10 +397,8 @@ static void qede_reset_queue_stats(struct qede_dev
> *qdev, bool xstats)
>=20
>  	DP_VERBOSE(edev, ECORE_MSG_DEBUG, "Clearing queue stats\n");
>=20
> -	rxq_stat_cntrs =3D RTE_MIN(QEDE_RSS_COUNT(dev),
> -			       RTE_ETHDEV_QUEUE_STAT_CNTRS);
> -	txq_stat_cntrs =3D RTE_MIN(QEDE_TSS_COUNT(dev),
> -			       RTE_ETHDEV_QUEUE_STAT_CNTRS);
> +	rxq_stat_cntrs =3D QEDE_RSS_COUNT(dev);
> +	txq_stat_cntrs =3D QEDE_TSS_COUNT(dev);
>=20
>  	for (qid =3D 0; qid < qdev->num_rx_queues; qid++) {
>  		OSAL_MEMSET(((char *)(qdev->fp_array[qid].rxq)) +
> @@ -1634,20 +1632,11 @@ qede_get_stats(struct rte_eth_dev *eth_dev,
> struct rte_eth_stats *eth_stats,
>  	eth_stats->oerrors =3D stats.common.tx_err_drop_pkts;
>=20
>  	/* Queue stats */
> -	rxq_stat_cntrs =3D RTE_MIN(QEDE_RSS_COUNT(eth_dev),
> -			       RTE_ETHDEV_QUEUE_STAT_CNTRS);
> -	txq_stat_cntrs =3D RTE_MIN(QEDE_TSS_COUNT(eth_dev),
> -			       RTE_ETHDEV_QUEUE_STAT_CNTRS);
> -	if (rxq_stat_cntrs !=3D (unsigned int)QEDE_RSS_COUNT(eth_dev) ||
> -	    txq_stat_cntrs !=3D (unsigned int)QEDE_TSS_COUNT(eth_dev))
> -		DP_VERBOSE(edev, ECORE_MSG_DEBUG,
> -		       "Not all the queue stats will be displayed. Set"
> -		       " RTE_ETHDEV_QUEUE_STAT_CNTRS config param"
> -		       " appropriately and retry.\n");
> +	rxq_stat_cntrs =3D QEDE_RSS_COUNT(eth_dev);
> +	txq_stat_cntrs =3D QEDE_TSS_COUNT(eth_dev);
>=20
>  	for (qid =3D 0; qid < eth_dev->data->nb_rx_queues; qid++) {
>  		uint64_t q_ipackets =3D 0;
> -		uint64_t q_errors =3D 0;
>=20
>  		for_each_hwfn(edev, hw_fn) {
>  			idx =3D qid * edev->num_hwfns + hw_fn;
> @@ -1657,21 +1646,10 @@ qede_get_stats(struct rte_eth_dev *eth_dev,
> struct rte_eth_stats *eth_stats,
>  					(((char *)(qdev->fp_array[idx].rxq)) +
>  					 offsetof(struct qede_rx_queue,
>  					 rcv_pkts));
> -			q_errors +=3D
> -				*(uint64_t *)
> -					(((char *)(qdev->fp_array[idx].rxq)) +
> -					 offsetof(struct qede_rx_queue,
> -					 rx_hw_errors)) +
> -				*(uint64_t *)
> -					(((char *)(qdev->fp_array[idx].rxq)) +
> -					 offsetof(struct qede_rx_queue,
> -					 rx_alloc_errors));
>  		}
>=20
> -		if (qstats !=3D NULL) {
> -			qstats->q_ipackets[i] =3D q_ipackets;
> -			qstats->q_errors[i] =3D q_errors;
> -		}
> +		if (qstats !=3D NULL)
> +			qstats[i].q_ipackets =3D q_ipackets;
>=20
>  		i++;
>  		if (i =3D=3D rxq_stat_cntrs)
> @@ -1693,7 +1671,7 @@ qede_get_stats(struct rte_eth_dev *eth_dev, struct
> rte_eth_stats *eth_stats,
>  		}
>=20
>  		if (qstats !=3D NULL)
> -			qstats->q_opackets[j] =3D q_opackets;
> +			qstats[j].q_opackets =3D q_opackets;
>=20
>  		j++;
>  		if (j =3D=3D txq_stat_cntrs)
> diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_r=
ing.c
> index b639544eab..2ba9b66b41 100644
> --- a/drivers/net/ring/rte_eth_ring.c
> +++ b/drivers/net/ring/rte_eth_ring.c
> @@ -203,17 +203,15 @@ eth_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  	unsigned long rx_total =3D 0, tx_total =3D 0;
>  	const struct pmd_internals *internal =3D dev->data->dev_private;
>=20
> -	for (i =3D 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
> -			i < dev->data->nb_rx_queues; i++) {
> +	for (i =3D 0; i < dev->data->nb_rx_queues; i++) {
>  		if (qstats !=3D NULL)
> -			qstats->q_ipackets[i] =3D internal-
> >rx_ring_queues[i].rx_pkts;
> +			qstats[i].q_ipackets =3D internal-
> >rx_ring_queues[i].rx_pkts;
>  		rx_total +=3D internal->rx_ring_queues[i].rx_pkts;
>  	}
>=20
> -	for (i =3D 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
> -			i < dev->data->nb_tx_queues; i++) {
> +	for (i =3D 0; i < dev->data->nb_tx_queues; i++) {
>  		if (qstats !=3D NULL)
> -			qstats->q_opackets[i] =3D internal-
> >tx_ring_queues[i].tx_pkts;
> +			qstats[i].q_opackets =3D internal-
> >tx_ring_queues[i].tx_pkts;
>  		tx_total +=3D internal->tx_ring_queues[i].tx_pkts;
>  	}
>=20
> diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
> index e48ad0e317..125134f8d4 100644
> --- a/drivers/net/rnp/rnp_ethdev.c
> +++ b/drivers/net/rnp/rnp_ethdev.c
> @@ -1252,9 +1252,9 @@ rnp_dev_stats_get(struct rte_eth_dev *dev,
>  			continue;
>  		stats->ipackets +=3D rxq->stats.ipackets;
>  		stats->ibytes +=3D rxq->stats.ibytes;
> -		if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_ipackets[i] =3D rxq->stats.ipackets;
> -			qstats->q_ibytes[i] =3D rxq->stats.ibytes;
> +		if (qstats !=3D NULL && i < dev->data->nb_rx_queues) {
> +			qstats[i].q_ipackets =3D rxq->stats.ipackets;
> +			qstats[i].q_ibytes =3D rxq->stats.ibytes;
>  		}
>  	}
>=20
> @@ -1266,9 +1266,9 @@ rnp_dev_stats_get(struct rte_eth_dev *dev,
>  		stats->opackets +=3D txq->stats.opackets;
>  		stats->obytes +=3D txq->stats.obytes;
>  		stats->oerrors +=3D txq->stats.errors;
> -		if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_opackets[i] =3D txq->stats.opackets;
> -			qstats->q_obytes[i] =3D txq->stats.obytes;
> +		if (qstats !=3D NULL && i < dev->data->nb_tx_queues) {
> +			qstats[i].q_opackets =3D txq->stats.opackets;
> +			qstats[i].q_obytes =3D txq->stats.obytes;
>  		}
>  	}
>  	stats->imissed =3D eth_stats->rx_trans_drop + eth_stats->rx_trunc_drop;
> diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c
> b/drivers/net/sxe2/sxe2_cmd_chnl.c
> index 050488301c..130e0fa11b 100644
> --- a/drivers/net/sxe2/sxe2_cmd_chnl.c
> +++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
> @@ -1577,15 +1577,11 @@ int32_t sxe2_drv_queue_info_get_update(struct
> sxe2_adapter *adapter, struct eth_
>  	struct sxe2_drv_cmd_params param =3D {0};
>  	struct sxe2_queue_map_info resp =3D {0};
>  	struct sxe2_common_device *cdev =3D adapter->cdev;
> +	struct rte_eth_dev_data *dev_data =3D adapter->dev_info.dev_data;
>  	uint8_t pool_idx;
>  	uint8_t index;
>  	int32_t ret;
>=20
> -	if (!(adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_Q_MAP)) {
> -		ret =3D 0;
> -		goto l_end;
> -	}
> -
>  	sxe2_drv_cmd_params_fill(adapter, &param,
> SXE2_DRV_CMD_TX_RX_MAP_GET,
>  				 NULL, 0,
>  				 &resp, sizeof(resp));
> @@ -1595,14 +1591,16 @@ int32_t sxe2_drv_queue_info_get_update(struct
> sxe2_adapter *adapter, struct eth_
>  		goto l_end;
>  	}
>=20
> -	for (pool_idx =3D 0; pool_idx < SXE2_RXQ_STATS_MAP_MAX_NUM;
> pool_idx++) {
> -		qstats->q_ipackets[pool_idx] =3D
> resp.rxq_stats_map_info[pool_idx].rxq_lan_in_pkt_cnt;
> -		qstats->q_ibytes[pool_idx] =3D
> resp.rxq_stats_map_info[pool_idx].rxq_lan_in_byte_cnt;
> +	for (pool_idx =3D 0; pool_idx < SXE2_RXQ_STATS_MAP_MAX_NUM &&
> +			pool_idx < dev_data->nb_rx_queues; pool_idx++) {
> +		qstats[pool_idx].q_ipackets =3D
> resp.rxq_stats_map_info[pool_idx].rxq_lan_in_pkt_cnt;
> +		qstats[pool_idx].q_ibytes =3D
> resp.rxq_stats_map_info[pool_idx].rxq_lan_in_byte_cnt;
>  	}
>=20
> -	for (index =3D 0; index < SXE2_TXQ_STATS_MAP_MAX_NUM; index++) {
> -		qstats->q_opackets[index] =3D
> resp.txq_stats_map_info[index].txq_lan_pkt_cnt;
> -		qstats->q_obytes[index] =3D
> resp.txq_stats_map_info[index].txq_lan_byte_cnt;
> +	for (index =3D 0; index < SXE2_TXQ_STATS_MAP_MAX_NUM &&
> +			index < dev_data->nb_tx_queues; index++) {
> +		qstats[index].q_opackets =3D
> resp.txq_stats_map_info[index].txq_lan_pkt_cnt;
> +		qstats[index].q_obytes =3D
> resp.txq_stats_map_info[index].txq_lan_byte_cnt;
>  	}
>=20
>  l_end:
> diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.=
c
> index b93452f168..3d381a47a9 100644
> --- a/drivers/net/tap/rte_eth_tap.c
> +++ b/drivers/net/tap/rte_eth_tap.c
> @@ -1004,9 +1004,9 @@ tap_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *tap_stats,
>=20
>  		if (rxq =3D=3D NULL)
>  			continue;
> -		if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_ipackets[i] =3D rxq->stats.packets;
> -			qstats->q_ibytes[i] =3D rxq->stats.bytes;
> +		if (qstats !=3D NULL && i < dev->data->nb_rx_queues) {
> +			qstats[i].q_ipackets =3D rxq->stats.packets;
> +			qstats[i].q_ibytes =3D rxq->stats.bytes;
>  		}
>  		rx_total +=3D rxq->stats.packets;
>  		rx_bytes_total +=3D rxq->stats.bytes;
> @@ -1019,9 +1019,9 @@ tap_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *tap_stats,
>=20
>  		if (txq =3D=3D NULL)
>  			continue;
> -		if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_opackets[i] =3D txq->stats.packets;
> -			qstats->q_obytes[i] =3D txq->stats.bytes;
> +		if (qstats !=3D NULL && i < dev->data->nb_tx_queues) {
> +			qstats[i].q_opackets =3D txq->stats.packets;
> +			qstats[i].q_obytes =3D txq->stats.bytes;
>  		}
>  		tx_total +=3D txq->stats.packets;
>  		tx_bytes_total +=3D txq->stats.bytes;
> diff --git a/drivers/net/thunderx/nicvf_ethdev.c
> b/drivers/net/thunderx/nicvf_ethdev.c
> index 6e34da7c3c..30d03f4db9 100644
> --- a/drivers/net/thunderx/nicvf_ethdev.c
> +++ b/drivers/net/thunderx/nicvf_ethdev.c
> @@ -306,13 +306,13 @@ nicvf_dev_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>=20
>  	/* Reading per RX ring stats */
>  	for (qidx =3D rx_start; qidx <=3D rx_end; qidx++) {
> -		if (qidx >=3D RTE_ETHDEV_QUEUE_STAT_CNTRS)
> +		if (qidx >=3D dev->data->nb_rx_queues)
>  			break;
>=20
>  		nicvf_hw_get_rx_qstats(nic, &rx_qstats, qidx);
>  		if (qstats !=3D NULL) {
> -			qstats->q_ibytes[qidx] =3D rx_qstats.q_rx_bytes;
> -			qstats->q_ipackets[qidx] =3D rx_qstats.q_rx_packets;
> +			qstats[qidx].q_ibytes =3D rx_qstats.q_rx_bytes;
> +			qstats[qidx].q_ipackets =3D rx_qstats.q_rx_packets;
>  		}
>  	}
>=20
> @@ -321,13 +321,13 @@ nicvf_dev_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>=20
>  	/* Reading per TX ring stats */
>  	for (qidx =3D tx_start; qidx <=3D tx_end; qidx++) {
> -		if (qidx >=3D RTE_ETHDEV_QUEUE_STAT_CNTRS)
> +		if (qidx >=3D dev->data->nb_tx_queues)
>  			break;
>=20
>  		nicvf_hw_get_tx_qstats(nic, &tx_qstats, qidx);
>  		if (qstats !=3D NULL) {
> -			qstats->q_obytes[qidx] =3D tx_qstats.q_tx_bytes;
> -			qstats->q_opackets[qidx] =3D tx_qstats.q_tx_packets;
> +			qstats[qidx].q_obytes =3D tx_qstats.q_tx_bytes;
> +			qstats[qidx].q_opackets =3D tx_qstats.q_tx_packets;
>  		}
>  	}
>=20
> @@ -342,14 +342,14 @@ nicvf_dev_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>=20
>  		/* Reading per RX ring stats */
>  		for (qidx =3D rx_start; qidx <=3D rx_end; qidx++) {
> -			if (qidx >=3D RTE_ETHDEV_QUEUE_STAT_CNTRS)
> +			if (qidx >=3D dev->data->nb_rx_queues)
>  				break;
>=20
>  			nicvf_hw_get_rx_qstats(snic, &rx_qstats,
>  					       qidx %
> MAX_RCV_QUEUES_PER_QS);
>  			if (qstats !=3D NULL) {
> -				qstats->q_ibytes[qidx] =3D rx_qstats.q_rx_bytes;
> -				qstats->q_ipackets[qidx] =3D
> rx_qstats.q_rx_packets;
> +				qstats[qidx].q_ibytes =3D rx_qstats.q_rx_bytes;
> +				qstats[qidx].q_ipackets =3D
> rx_qstats.q_rx_packets;
>  			}
>  		}
>=20
> @@ -357,14 +357,14 @@ nicvf_dev_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  		nicvf_tx_range(dev, snic, &tx_start, &tx_end);
>  		/* Reading per TX ring stats */
>  		for (qidx =3D tx_start; qidx <=3D tx_end; qidx++) {
> -			if (qidx >=3D RTE_ETHDEV_QUEUE_STAT_CNTRS)
> +			if (qidx >=3D dev->data->nb_tx_queues)
>  				break;
>=20
>  			nicvf_hw_get_tx_qstats(snic, &tx_qstats,
>  					       qidx %
> MAX_SND_QUEUES_PER_QS);
>  			if (qstats !=3D NULL) {
> -				qstats->q_obytes[qidx] =3D
> tx_qstats.q_tx_bytes;
> -				qstats->q_opackets[qidx] =3D
> tx_qstats.q_tx_packets;
> +				qstats[qidx].q_obytes =3D tx_qstats.q_tx_bytes;
> +				qstats[qidx].q_opackets =3D
> tx_qstats.q_tx_packets;
>  			}
>  		}
>  	}
> diff --git a/drivers/net/txgbe/txgbe_ethdev.c
> b/drivers/net/txgbe/txgbe_ethdev.c
> index 6349aca90f..5eae613d32 100644
> --- a/drivers/net/txgbe/txgbe_ethdev.c
> +++ b/drivers/net/txgbe/txgbe_ethdev.c
> @@ -2452,13 +2452,13 @@ txgbe_dev_stats_get(struct rte_eth_dev *dev,
> struct rte_eth_stats *stats,
>  	stats->obytes =3D hw_stats->tx_bytes;
>=20
>  	if (qstats !=3D NULL) {
> -		for (i =3D 0; i < TXGBE_MAX_QP; i++) {
> -			if (i >=3D RTE_ETHDEV_QUEUE_STAT_CNTRS)
> -				break;
> -			qstats->q_ipackets[i] +=3D hw_stats-
> >qp[i].rx_qp_packets;
> -			qstats->q_ibytes[i] +=3D hw_stats->qp[i].rx_qp_bytes;
> -			qstats->q_opackets[i] +=3D hw_stats-
> >qp[i].tx_qp_packets;
> -			qstats->q_obytes[i] +=3D hw_stats->qp[i].tx_qp_bytes;
> +		for (i =3D 0; i < TXGBE_MAX_QP && i < dev->data-
> >nb_rx_queues; i++) {
> +			qstats[i].q_ipackets +=3D hw_stats->qp[i].rx_qp_packets;
> +			qstats[i].q_ibytes +=3D hw_stats->qp[i].rx_qp_bytes;
> +		}
> +		for (i =3D 0; i < TXGBE_MAX_QP && i < dev->data-
> >nb_tx_queues; i++) {
> +			qstats[i].q_opackets +=3D hw_stats-
> >qp[i].tx_qp_packets;
> +			qstats[i].q_obytes +=3D hw_stats->qp[i].tx_qp_bytes;
>  		}
>  	}
>=20
> diff --git a/drivers/net/vhost/rte_eth_vhost.c
> b/drivers/net/vhost/rte_eth_vhost.c
> index 05940f2461..f2dfae7175 100644
> --- a/drivers/net/vhost/rte_eth_vhost.c
> +++ b/drivers/net/vhost/rte_eth_vhost.c
> @@ -1319,27 +1319,25 @@ eth_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  	unsigned long tx_total_errors =3D 0;
>  	struct vhost_queue *vq;
>=20
> -	for (i =3D 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
> -			i < dev->data->nb_rx_queues; i++) {
> +	for (i =3D 0; i < dev->data->nb_rx_queues; i++) {
>  		if (dev->data->rx_queues[i] =3D=3D NULL)
>  			continue;
>  		vq =3D dev->data->rx_queues[i];
>  		if (qstats !=3D NULL) {
> -			qstats->q_ipackets[i] =3D vq->stats.pkts;
> -			qstats->q_ibytes[i] =3D vq->stats.bytes;
> +			qstats[i].q_ipackets =3D vq->stats.pkts;
> +			qstats[i].q_ibytes =3D vq->stats.bytes;
>  		}
>  		rx_total +=3D vq->stats.pkts;
>  		rx_total_bytes +=3D vq->stats.bytes;
>  	}
>=20
> -	for (i =3D 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
> -			i < dev->data->nb_tx_queues; i++) {
> +	for (i =3D 0; i < dev->data->nb_tx_queues; i++) {
>  		if (dev->data->tx_queues[i] =3D=3D NULL)
>  			continue;
>  		vq =3D dev->data->tx_queues[i];
>  		if (qstats !=3D NULL) {
> -			qstats->q_opackets[i] =3D vq->stats.pkts;
> -			qstats->q_obytes[i] =3D vq->stats.bytes;
> +			qstats[i].q_opackets =3D vq->stats.pkts;
> +			qstats[i].q_obytes =3D vq->stats.bytes;
>  		}
>  		tx_total +=3D vq->stats.pkts;
>  		tx_total_bytes +=3D vq->stats.bytes;
> diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virt=
io_ethdev.c
> index 0b2574bd02..a6fe4f3023 100644
> --- a/drivers/net/virtio/virtio_ethdev.c
> +++ b/drivers/net/virtio/virtio_ethdev.c
> @@ -701,9 +701,9 @@ virtio_update_stats(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  		stats->opackets +=3D txvq->stats.packets;
>  		stats->obytes +=3D txvq->stats.bytes;
>=20
> -		if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_opackets[i] =3D txvq->stats.packets;
> -			qstats->q_obytes[i] =3D txvq->stats.bytes;
> +		if (qstats !=3D NULL && i < dev->data->nb_tx_queues) {
> +			qstats[i].q_opackets =3D txvq->stats.packets;
> +			qstats[i].q_obytes =3D txvq->stats.bytes;
>  		}
>  	}
>=20
> @@ -716,9 +716,9 @@ virtio_update_stats(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  		stats->ibytes +=3D rxvq->stats.bytes;
>  		stats->ierrors +=3D rxvq->stats.errors;
>=20
> -		if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_ipackets[i] =3D rxvq->stats.packets;
> -			qstats->q_ibytes[i] =3D rxvq->stats.bytes;
> +		if (qstats !=3D NULL && i < dev->data->nb_rx_queues) {
> +			qstats[i].q_ipackets =3D rxvq->stats.packets;
> +			qstats[i].q_ibytes =3D rxvq->stats.bytes;
>  		}
>  	}
>=20
> diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.c
> b/drivers/net/vmxnet3/vmxnet3_ethdev.c
> index b7cf217724..4a7c76cfef 100644
> --- a/drivers/net/vmxnet3/vmxnet3_ethdev.c
> +++ b/drivers/net/vmxnet3/vmxnet3_ethdev.c
> @@ -1504,9 +1504,9 @@ vmxnet3_dev_stats_get(struct rte_eth_dev *dev,
> struct rte_eth_stats *stats,
>  		stats->obytes +=3D bytes;
>  		stats->oerrors +=3D txStats.pktsTxError + txStats.pktsTxDiscard;
>=20
> -		if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_opackets[i] =3D packets;
> -			qstats->q_obytes[i] =3D bytes;
> +		if (qstats !=3D NULL && i < dev->data->nb_tx_queues) {
> +			qstats[i].q_opackets =3D packets;
> +			qstats[i].q_obytes =3D bytes;
>  		}
>  	}
>=20
> @@ -1526,10 +1526,9 @@ vmxnet3_dev_stats_get(struct rte_eth_dev *dev,
> struct rte_eth_stats *stats,
>  		stats->ierrors +=3D rxStats.pktsRxError;
>  		stats->imissed +=3D rxStats.pktsRxOutOfBuf;
>=20
> -		if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> -			qstats->q_ipackets[i] =3D packets;
> -			qstats->q_ibytes[i] =3D bytes;
> -			qstats->q_errors[i] =3D rxStats.pktsRxError;
> +		if (qstats !=3D NULL && i < dev->data->nb_rx_queues) {
> +			qstats[i].q_ipackets =3D packets;
> +			qstats[i].q_ibytes =3D bytes;
>  		}
>  	}
>=20
> diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
> index 505f973d66..5fbe68782e 100644
> --- a/drivers/net/xsc/xsc_ethdev.c
> +++ b/drivers/net/xsc/xsc_ethdev.c
> @@ -593,11 +593,9 @@ xsc_ethdev_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  			continue;
>=20
>  		idx =3D rxq->idx;
> -		if (qstats !=3D NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS)
> {
> -			qstats->q_ipackets[idx] +=3D rxq->stats.rx_pkts;
> -			qstats->q_ibytes[idx] +=3D rxq->stats.rx_bytes;
> -			qstats->q_errors[idx] +=3D rxq->stats.rx_errors +
> -						rxq->stats.rx_nombuf;
> +		if (qstats !=3D NULL && idx < dev->data->nb_rx_queues) {
> +			qstats[idx].q_ipackets +=3D rxq->stats.rx_pkts;
> +			qstats[idx].q_ibytes +=3D rxq->stats.rx_bytes;
>  		}
>  		stats->ipackets +=3D rxq->stats.rx_pkts;
>  		stats->ibytes +=3D rxq->stats.rx_bytes;
> @@ -611,9 +609,9 @@ xsc_ethdev_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>  			continue;
>=20
>  		idx =3D txq->idx;
> -		if (qstats !=3D NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS)
> {
> -			qstats->q_opackets[idx] +=3D txq->stats.tx_pkts;
> -			qstats->q_obytes[idx] +=3D txq->stats.tx_bytes;
> +		if (qstats !=3D NULL && idx < dev->data->nb_tx_queues) {
> +			qstats[idx].q_opackets +=3D txq->stats.tx_pkts;
> +			qstats[idx].q_obytes +=3D txq->stats.tx_bytes;
>  		}
>  		stats->opackets +=3D txq->stats.tx_pkts;
>  		stats->obytes +=3D txq->stats.tx_bytes;
> diff --git a/drivers/net/zxdh/zxdh_ethdev_ops.c
> b/drivers/net/zxdh/zxdh_ethdev_ops.c
> index 50247116d9..489ef76269 100644
> --- a/drivers/net/zxdh/zxdh_ethdev_ops.c
> +++ b/drivers/net/zxdh/zxdh_ethdev_ops.c
> @@ -1824,37 +1824,29 @@ zxdh_dev_stats_get(struct rte_eth_dev *dev,
> struct rte_eth_stats *stats,
>  	}
>=20
>  	stats->rx_nombuf =3D dev->data->rx_mbuf_alloc_failed;
> -	for (i =3D 0; (i < dev->data->nb_rx_queues) && (i <
> RTE_ETHDEV_QUEUE_STAT_CNTRS); i++) {
> +	for (i =3D 0; i < dev->data->nb_rx_queues; i++) {
>  		struct zxdh_virtnet_rx *rxvq =3D dev->data->rx_queues[i];
>=20
>  		if (rxvq =3D=3D NULL)
>  			continue;
>  		if (qstats !=3D NULL) {
> -			qstats->q_ipackets[i] =3D *(uint64_t *)(((char *)rxvq) +
> +			qstats[i].q_ipackets =3D *(uint64_t *)(((char *)rxvq) +
>  					zxdh_rxq_stat_strings[0].offset);
> -			qstats->q_ibytes[i] =3D *(uint64_t *)(((char *)rxvq) +
> +			qstats[i].q_ibytes =3D *(uint64_t *)(((char *)rxvq) +
>  					zxdh_rxq_stat_strings[1].offset);
> -			qstats->q_errors[i] =3D *(uint64_t *)(((char *)rxvq) +
> -					zxdh_rxq_stat_strings[2].offset);
> -			qstats->q_errors[i] +=3D *(uint64_t *)(((char *)rxvq) +
> -					zxdh_rxq_stat_strings[5].offset);
>  		}
>  	}
>=20
> -	for (i =3D 0; (i < dev->data->nb_tx_queues) && (i <
> RTE_ETHDEV_QUEUE_STAT_CNTRS); i++) {
> +	for (i =3D 0; i < dev->data->nb_tx_queues; i++) {
>  		struct zxdh_virtnet_tx *txvq =3D dev->data->tx_queues[i];
>=20
>  		if (txvq =3D=3D NULL)
>  			continue;
>  		if (qstats !=3D NULL) {
> -			qstats->q_opackets[i] =3D *(uint64_t *)(((char *)txvq) +
> +			qstats[i].q_opackets =3D *(uint64_t *)(((char *)txvq) +
>  					zxdh_txq_stat_strings[0].offset);
> -			qstats->q_obytes[i] =3D *(uint64_t *)(((char *)txvq) +
> +			qstats[i].q_obytes =3D *(uint64_t *)(((char *)txvq) +
>  					zxdh_txq_stat_strings[1].offset);
> -			qstats->q_errors[i] +=3D *(uint64_t *)(((char *)txvq) +
> -					zxdh_txq_stat_strings[2].offset);
> -			qstats->q_errors[i] +=3D *(uint64_t *)(((char *)txvq) +
> -					zxdh_txq_stat_strings[5].offset);
>  		}
>  	}
>  	return 0;
> @@ -2002,13 +1994,13 @@ int zxdh_dev_stats_reset(struct rte_eth_dev
> *dev)
>  	if (hw->is_pf)
>  		zxdh_hw_stats_reset(dev, ZXDH_MAC_STATS_RESET);
>  	zxdh_np_stats_reset(dev);
> -	for (i =3D 0; ((i < dev->data->nb_rx_queues) && (i <
> RTE_ETHDEV_QUEUE_STAT_CNTRS)); i++) {
> +	for (i =3D 0; (i < dev->data->nb_rx_queues); i++) {
>  		struct zxdh_virtnet_rx *rxvq =3D dev->data->rx_queues[i];
>  		if (rxvq =3D=3D NULL)
>  			continue;
>  		memset(&rxvq->stats, 0, sizeof(struct zxdh_virtnet_stats));
>  	}
> -	for (i =3D 0; ((i < dev->data->nb_tx_queues) && (i <
> RTE_ETHDEV_QUEUE_STAT_CNTRS)); i++) {
> +	for (i =3D 0; (i < dev->data->nb_tx_queues); i++) {
>  		struct zxdh_virtnet_tx *txvq =3D dev->data->tx_queues[i];
>  		if (txvq =3D=3D NULL)
>  			continue;
> diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
> index 0477579cc3..041ba6851e 100644
> --- a/lib/ethdev/ethdev_driver.h
> +++ b/lib/ethdev/ethdev_driver.h
> @@ -24,25 +24,16 @@
>  extern "C" {
>  #endif
>=20
> -#define RTE_ETHDEV_QUEUE_STAT_CNTRS 16 /* max 256 */
> -
>  /**
>   * @internal
> - * Structure used to pass queue stats back to ethdev
> - * for drivers which rely on ethdev to add the queue stats automatically=
 to
> xstats.
> + * Per-queue counters added to xstats by ethdev.
> + * The array is allocated and zeroed by ethdev, with one entry per queue=
.
>   */
>  struct eth_queue_stats {
> -	/* Queue stats are limited to max 256 queues. */
> -	/** Total number of queue Rx packets. */
> -	uint64_t q_ipackets[RTE_ETHDEV_QUEUE_STAT_CNTRS];
> -	/** Total number of queue Tx packets. */
> -	uint64_t q_opackets[RTE_ETHDEV_QUEUE_STAT_CNTRS];
> -	/** Total number of successfully received queue bytes. */
> -	uint64_t q_ibytes[RTE_ETHDEV_QUEUE_STAT_CNTRS];
> -	/** Total number of successfully transmitted queue bytes. */
> -	uint64_t q_obytes[RTE_ETHDEV_QUEUE_STAT_CNTRS];
> -	/** Total number of queue packets received that are dropped. */
> -	uint64_t q_errors[RTE_ETHDEV_QUEUE_STAT_CNTRS];
> +	uint64_t q_ipackets;	/**< Number of received packets. */
> +	uint64_t q_opackets;	/**< Number of transmitted packets. */
> +	uint64_t q_ibytes;	/**< Number of received bytes. */
> +	uint64_t q_obytes;	/**< Number of transmitted bytes. */
>  };
>=20
>  /**
> @@ -456,7 +447,11 @@ typedef int
> (*eth_speed_lanes_get_capability_t)(struct rte_eth_dev *dev,
>   * @param stats
>   *   The stats structure to be completed by the driver and returned to t=
he user.
>   * @param qstats
> - *   Any queue statistics to be returned.
> + *   Any queue statistics to be returned, indexed by queue id.
> + *   The array has RTE_MAX(nb_rx_queues, nb_tx_queues) entries and is
> + *   zeroed by ethdev before the driver is called. The driver must not
> + *   write past nb_rx_queues for the Rx fields, or past nb_tx_queues
> + *   for the Tx fields.
>   *   @note: This parameter can be NULL
>   */
>  typedef int (*eth_stats_get_t)(struct rte_eth_dev *dev,
> diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
> index 75ea3eedff..70cc6ae63c 100644
> --- a/lib/ethdev/ethdev_private.c
> +++ b/lib/ethdev/ethdev_private.c
> @@ -510,8 +510,6 @@ eth_stats_qstats_get(uint16_t port_id, struct
> rte_eth_stats *stats, struct eth_q
>  	}
>=20
>  	memset(stats, 0, sizeof(*stats));
> -	if (qstats !=3D NULL)
> -		memset(qstats, 0, sizeof(*qstats));
>=20
>  	if (dev->dev_ops->stats_get =3D=3D NULL)
>  		return -ENOTSUP;
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index d6915a6b08..253f6c0efa 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -75,7 +75,6 @@ static const struct rte_eth_xstats_name_off
> eth_dev_stats_strings[] =3D {
>  static const struct rte_eth_xstats_name_off eth_dev_rxq_stats_strings[] =
=3D {
>  	{"packets", offsetof(struct eth_queue_stats, q_ipackets)},
>  	{"bytes", offsetof(struct eth_queue_stats, q_ibytes)},
> -	{"errors", offsetof(struct eth_queue_stats, q_errors)},
>  };
>=20
>  #define RTE_NB_RXQ_STATS RTE_DIM(eth_dev_rxq_stats_strings)
> @@ -3387,8 +3386,8 @@ eth_dev_get_xstats_basic_count(struct rte_eth_dev
> *dev)
>  	uint16_t nb_rxqs, nb_txqs;
>  	int count;
>=20
> -	nb_rxqs =3D RTE_MIN(dev->data->nb_rx_queues,
> RTE_ETHDEV_QUEUE_STAT_CNTRS);
> -	nb_txqs =3D RTE_MIN(dev->data->nb_tx_queues,
> RTE_ETHDEV_QUEUE_STAT_CNTRS);
> +	nb_rxqs =3D dev->data->nb_rx_queues;
> +	nb_txqs =3D dev->data->nb_tx_queues;
>=20
>  	count =3D RTE_NB_STATS;
>  	if (dev->data->dev_flags & RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS) {
> @@ -3501,7 +3500,7 @@ eth_basic_stats_get_names(struct rte_eth_dev
> *dev,
>  	if ((dev->data->dev_flags & RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS)
> =3D=3D 0)
>  		return cnt_used_entries;
>=20
> -	num_q =3D RTE_MIN(dev->data->nb_rx_queues,
> RTE_ETHDEV_QUEUE_STAT_CNTRS);
> +	num_q =3D dev->data->nb_rx_queues;
>  	for (id_queue =3D 0; id_queue < num_q; id_queue++) {
>  		for (idx =3D 0; idx < RTE_NB_RXQ_STATS; idx++) {
>  			unsigned int cc;
> @@ -3518,7 +3517,7 @@ eth_basic_stats_get_names(struct rte_eth_dev
> *dev,
>  		}
>=20
>  	}
> -	num_q =3D RTE_MIN(dev->data->nb_tx_queues,
> RTE_ETHDEV_QUEUE_STAT_CNTRS);
> +	num_q =3D dev->data->nb_tx_queues;
>  	for (id_queue =3D 0; id_queue < num_q; id_queue++) {
>  		for (idx =3D 0; idx < RTE_NB_TXQ_STATS; idx++) {
>  			unsigned int cc;
> @@ -3708,54 +3707,61 @@ eth_basic_stats_get(uint16_t port_id, struct
> rte_eth_xstat *xstats)
>  {
>  	struct rte_eth_dev *dev;
>  	struct rte_eth_stats eth_stats;
> -	struct eth_queue_stats queue_stats;
> +	struct eth_queue_stats *queue_stats =3D NULL;
>  	unsigned int count =3D 0, i, q;
> -	uint64_t val, *stats_ptr;
> -	uint16_t nb_rxqs, nb_txqs;
> +	uint16_t nb_rxqs, nb_txqs, nb_q;
> +	uint64_t *stats_ptr;
>  	int ret;
>=20
> -	ret =3D eth_stats_qstats_get(port_id, &eth_stats, &queue_stats);
> -	if (ret < 0)
> -		return ret;
> -
>  	dev =3D &rte_eth_devices[port_id];
>=20
> -	nb_rxqs =3D RTE_MIN(dev->data->nb_rx_queues,
> RTE_ETHDEV_QUEUE_STAT_CNTRS);
> -	nb_txqs =3D RTE_MIN(dev->data->nb_tx_queues,
> RTE_ETHDEV_QUEUE_STAT_CNTRS);
> +	if (dev->data->dev_flags & RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS) {
> +		nb_rxqs =3D dev->data->nb_rx_queues;
> +		nb_txqs =3D dev->data->nb_tx_queues;
> +	} else {
> +		nb_rxqs =3D 0;
> +		nb_txqs =3D 0;
> +	}
> +
> +	nb_q =3D RTE_MAX(nb_rxqs, nb_txqs);
> +	if (nb_q > 0) {
> +		queue_stats =3D calloc(nb_q, sizeof(*queue_stats));
> +		if (queue_stats =3D=3D NULL)
> +			return -ENOMEM;
> +	}
> +
> +	ret =3D eth_stats_qstats_get(port_id, &eth_stats, queue_stats);
> +	if (ret < 0)
> +		goto out;
>=20
>  	/* global stats */
>  	for (i =3D 0; i < RTE_NB_STATS; i++) {
>  		stats_ptr =3D RTE_PTR_ADD(&eth_stats,
>  					eth_dev_stats_strings[i].offset);
> -		val =3D *stats_ptr;
> -		xstats[count++].value =3D val;
> +		xstats[count++].value =3D *stats_ptr;
>  	}
>=20
> -	if ((dev->data->dev_flags & RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS)
> =3D=3D 0)
> -		return count;
> -
>  	/* per-rxq stats */
>  	for (q =3D 0; q < nb_rxqs; q++) {
>  		for (i =3D 0; i < RTE_NB_RXQ_STATS; i++) {
> -			stats_ptr =3D RTE_PTR_ADD(&queue_stats,
> -					eth_dev_rxq_stats_strings[i].offset +
> -					q * sizeof(uint64_t));
> -			val =3D *stats_ptr;
> -			xstats[count++].value =3D val;
> +			stats_ptr =3D RTE_PTR_ADD(&queue_stats[q],
> +					eth_dev_rxq_stats_strings[i].offset);
> +			xstats[count++].value =3D *stats_ptr;
>  		}
>  	}
>=20
>  	/* per-txq stats */
>  	for (q =3D 0; q < nb_txqs; q++) {
>  		for (i =3D 0; i < RTE_NB_TXQ_STATS; i++) {
> -			stats_ptr =3D RTE_PTR_ADD(&queue_stats,
> -					eth_dev_txq_stats_strings[i].offset +
> -					q * sizeof(uint64_t));
> -			val =3D *stats_ptr;
> -			xstats[count++].value =3D val;
> +			stats_ptr =3D RTE_PTR_ADD(&queue_stats[q],
> +					eth_dev_txq_stats_strings[i].offset);
> +			xstats[count++].value =3D *stats_ptr;
>  		}
>  	}
> -	return count;
> +	ret =3D count;
> +out:
> +	free(queue_stats);
> +	return ret;
>  }
>=20
>  static int
> --
> 2.53.0

