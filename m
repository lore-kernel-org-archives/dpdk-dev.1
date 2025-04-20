Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC424C369C2
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Apr 2025 08:57:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6DE140156;
	Sun, 20 Apr 2025 10:57:28 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by mails.dpdk.org (Postfix) with ESMTP id CBF5440151
 for <dev@dpdk.org>; Sun, 20 Apr 2025 10:57:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZhwYpnU9cFn7CA9i0lvr8FTjcU1iLdZgT065p/t385Yicj1l9zm5mdII+3/cIifMSTAZM1iXDy47A8X+357vO7bFAcPTd4I1f2ghNRR/QFKIr3lkZoxpZdnuQR8zLzqKj8S7nUH7qf1qc54mFEPME92w/mqIS2h9NYiVVNANkRT5Tyj4x3XpTOJjsB7YMatgfEPMSMJ0NDF4L5uoBTl3AxTqVPHjV7VrLhgqa1jxLigKHKGBiWWTcHjyrJs9Al68jLU3eDH9owsXdvabBNN2x3jGbAVL1poYLn7vNbLvKY5HaZfjgIlu/mpgmOeEwsjlQWUxOQ/tDed1iVX/7+lJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A36nFHrFFAEyYhoECujjKEJF4l8CptTC5FsrCJcB9sw=;
 b=MvIjkkJneyibNKojjyAYJQY4QkDIEW/3k2vAw4Bir324wL49BMmfxr7Wf2k91L3h9VedBNUqHNWIJi4ynrCPnb/wCHYiEuZfsOGUsIO2jN72y8pnJMYhnksjkrG+ZtHnrvGLw1gXwfQz5rjrDMexAx4ieF8XEJw+rarjXjwsx14UJBTjAgXO/c33kaknuoUrBgYN6cXPwC6nM/hiJ8Yd3dImTXNhANQ8gvrNPp+3XFdjeKbCjj+PZY5K4Uo7TqKZYa3Jf7aAl+BxLHW0dzNdlr0wzF8MZPSU2YrA+aEupP4ganEj0txJtvDU37yQ2ryh4SVKIMew0MGOuW8WnVmZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A36nFHrFFAEyYhoECujjKEJF4l8CptTC5FsrCJcB9sw=;
 b=K/KAyAIV52VHHbEwhqd3lpi4bCK/2RDlSSCPmRrIV+BOmOBJhFnNNpIjnc1/OZRBd1oTssCD/mpJp9WnGcFBAf+YB9FMX+tj0uiB5r5OhTrzEshgfKPEBY0YSj0dWTfK+N9t54U08M0vIwQNdcowtP2CgfvWmYO3KWvqaQQUuMwSkZLofYVZIdUIMnYibXw6C+MSLJSmI7ugKH6ub3XRt2IfczIOTePqRssnGJWfncvBCOn/aDblKQwEQwJf7eaf/KFESv4l8woY2FIea/CLQbcrf9NMygdQl7rGbVr1d7EvTo824tT3kJKNEW0O8XfhdeJAebM/CaUItQFWNPachg==
Received: from IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22)
 by LV8PR12MB9334.namprd12.prod.outlook.com (2603:10b6:408:20b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Sun, 20 Apr
 2025 08:57:24 +0000
Received: from IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de]) by IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de%6]) with mapi id 15.20.8655.025; Sun, 20 Apr 2025
 08:57:24 +0000
From: Gregory Etelson <getelson@nvidia.com>
To: "Van Haaren, Harry" <harry.van.haaren@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "owen.hilyard@unh.edu" <owen.hilyard@unh.edu>
Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Thread-Topic: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Thread-Index: AQHbr6r1ijGnPC1ap0e+6CWAdV93u7OoNgYAgAEX6wCAAvBHrA==
Date: Sun, 20 Apr 2025 08:57:24 +0000
Message-ID: <IA1PR12MB63308A2F69036E3ACCC605D0A5B92@IA1PR12MB6330.namprd12.prod.outlook.com>
References: <20250417151039.186448-1-harry.van.haaren@intel.com>
 <9c4a970a-576c-7b0b-7685-791c4dd2689d@nvidia.com>
 <PH8PR11MB6803458E6348B4D167C47C91D7BF2@PH8PR11MB6803.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB6803458E6348B4D167C47C91D7BF2@PH8PR11MB6803.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6330:EE_|LV8PR12MB9334:EE_
x-ms-office365-filtering-correlation-id: a29c05e5-9e86-4143-ce40-08dd7fe95e50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|13003099007|7053199007|8096899003|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?9iSCfpV0Wnxgvhbv02ev/HTZapSgdte8+v986mFlyIp7YSZUO16YiSslapZR?=
 =?us-ascii?Q?FXINYSSFiS3OW3qjCYyZqf/dE4iQ2yrfS+nr8mtkd3/d07BYvPOJ2KLoIfKo?=
 =?us-ascii?Q?+wU5yuXi+m6xoqXjTvOMLOj6EZIM/NYIZ7s9cIiL30JFttRP7JcqBol2Rkb0?=
 =?us-ascii?Q?YtI7IJN7ZraGnQdqNzoNk7tir67uE3rZZGp1yQug1oclpIHZxxmBZNWaBdoy?=
 =?us-ascii?Q?RPT/Y0lLQA3oUp4KMTkNaOlg0IMkBnkRgGRLACuM1elHYsQb060b3HPq75bx?=
 =?us-ascii?Q?xN41cRkQYLzO6lxYwV4uYhEI44YUjs1R6TQq5jNG88GICZJST8Lc2qRMVm0Q?=
 =?us-ascii?Q?AWp/YMwHQIRz+rFGvVkVGTDmyAKL/CAC68qK+YQ5cM4wdF47f7inUF+I/ZCR?=
 =?us-ascii?Q?Q1WRObdSdlX88T06AqiaKSgML1Co57KPWS6r/r3wDherpt3I7FtzYgmmc2mc?=
 =?us-ascii?Q?ozv1xnnCZ6errF7l2HsfNuQu5Az5D5xzX9Fjptpw1mmkM90CiUyOyzrySXte?=
 =?us-ascii?Q?iycvm6Jv7E4NCSmTp6GErjfBtWM8uSwzG3wAs7hmVq7zwq0OG2fYMIQBzqaI?=
 =?us-ascii?Q?nqBoqGZFt9Yyi5qCqsEVZWisPo6Bj8dIDYWBt2602tYm5sDmV3/UrcsjHOfA?=
 =?us-ascii?Q?N38hsF99gF20R4GrWJAm4wyPPX/HsJrWoxKfKXsypg7iIYZv4QjSYOIUhBgy?=
 =?us-ascii?Q?E9S8I7CbOGTXEtp0vMIQkfOwhEB2ej+T3+lTo4O/fLPvWTusV5Zg0Pc2b4Ul?=
 =?us-ascii?Q?zCTlx7uV5NajN4K4OfatmrX97HElKfh6Mon0T2hcoe/MNSwTNLsjxB2pluzm?=
 =?us-ascii?Q?9d9N7KmoekdQ6uNiyiIaFWOb0wzE4vJvbpj6NuPX/9RcUOVOWJOwFoymmD1d?=
 =?us-ascii?Q?rsp5DbWy2NeDORYQvVMoAld4g4K45KHjI28kyB8dWEqwwGCu/FwfIabyIRK5?=
 =?us-ascii?Q?Y+Tl4jKW0azslUa3Q1ll1Zk7D+zndp1DWyWabSatam2dCuqT6fFu2GfJ7CVo?=
 =?us-ascii?Q?C434D5AiMOw46IcTSSoAfmDaT2FcLBQeL69pAPevju+XG3P7hzBvpmZL0nC8?=
 =?us-ascii?Q?z+4VEujxYZyEyLMIp+Wg8zP31kHEhzGnuXoi3aAurJD0iRLlukfouBfxaFTN?=
 =?us-ascii?Q?PYTxqnUkndKiINNJjNa4cKwWEvXCq+ar4USr6zFcqEgVJ/hOfhcfWAE5dhXf?=
 =?us-ascii?Q?UCicp1SbvLKuYdix9jTKYGph2V5RCTu7ieUgbq6btld0YCTY0Q69uySHQxaX?=
 =?us-ascii?Q?F+PfQqerK02l8RTTPu0c5t36/LeeNyyngRX032hNzlwwBDkyGVeFazuMAgNk?=
 =?us-ascii?Q?rQzm77w4YTlMSTkSHibn3ly3eLDvHOvOCisloA6sID9FHBe99xbGAsA1avCM?=
 =?us-ascii?Q?Dv2R560h/iqtxAktb4EpUtuU3mYh127z+J8/2xCafXu7CTIZ+HTeBTp023wP?=
 =?us-ascii?Q?cPbgznbr8fWyFdolesAa6R/oG2cYdq1exVqMxWaKk+ZxApQIaFPyNJiFSvGN?=
 =?us-ascii?Q?FyOpTeYVWSK5m2c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6330.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CWzM6vErwBKKi0N38UfyT1r9Pqss8IZnGKvvQUsLxqB0hWGgqvH1JXCNYbSp?=
 =?us-ascii?Q?f6HEUjqSrtnQeky503YBsYTIR5No3vzYfYR3lP2IPzuZiSyZQX+sQwmSOnEU?=
 =?us-ascii?Q?AFFdvAXo7qdd+8UZPxE/tQm7cRoOf91h7VCPwBVKojg5FlhB3DLlMswaMg2X?=
 =?us-ascii?Q?fct+bP02u6qbXdcKoB8ziPJTssYCu5LdqWcSo3jFzb7owMjnf+ejTYswJEQ+?=
 =?us-ascii?Q?pqyBV5keQdbY7xsM2XwPSAm0NfA8aNhKFgPNWDbhsMd9/MG41cqGj6NKwxQl?=
 =?us-ascii?Q?OKCV3hhVHweRW9Ra7eaJ9Zb/Mg3nbjZPtrshfPB4tPVaTQMSMU9XHIuljCOq?=
 =?us-ascii?Q?Xu/ahhWydWOujRHiIvYiQEQcgDvIhLx+m1XRaTVAZuOWJ98RhYcFKPDkPsaz?=
 =?us-ascii?Q?PdSHAfrNEt1Mkw4YxOtoRZAM16lAQYiyOOMT0mjxmLBXwzo4nm8hhDLT8JaP?=
 =?us-ascii?Q?c67ewXjkENRj/3D+YytqzXLK0rsw16XfBnTQkrj9yiCYQhWLvuUQApTsmLNn?=
 =?us-ascii?Q?3H5hq5yuk+AqBH9yRgEt/ryU68BGxqVILk0pwuBOLoTRcEBNcmG2p6yphZDm?=
 =?us-ascii?Q?TGkOJPh5LcJ1+iHoTaOZi+d8yOo4hwFhxQLiI39mWP6zxAFS7jM3iZlD+/4I?=
 =?us-ascii?Q?rrQKN5XuHrHdBy4PyQKh8h+vbhN3fVcEz9xInsskad/mMGqVjAcAm/YbIGhe?=
 =?us-ascii?Q?BEGtn9auqPT1S4TBIDi4t6AjTR7oII99YWOSXVDdUBLrfZ3ms8Cp69uKEkFI?=
 =?us-ascii?Q?/9doOe1ZFlfVwwy0QKna4VuWvCXnPvMs+OEzkHX+DSeGKPFMPFuOW5ABH07a?=
 =?us-ascii?Q?mCJyi7JrYVDxCtEdpsYn9BCHBgDyaIQmgYRECUueohWzs0+LUKZF1mBpfcNg?=
 =?us-ascii?Q?dsvEp9BSPSpy3HTtVeIZIv/OOxco7i1MzoPqoZ50CUgbP2GgxhRyiim/dk3q?=
 =?us-ascii?Q?TQpGgZLeMngFg96Zp5zSU/oIvJv+wrYjH9zytfc+jHVaDxeAzULwBKi/5Ft/?=
 =?us-ascii?Q?n/nFVcG+WdWg5coBiUVGvre4uZ4qDRCqw+jzr62XqOZi+HMmDF1PJSRO1bV5?=
 =?us-ascii?Q?q5qSfA/bZ8BqZmk0Ore80L4yh/Wkvvya6FEcezL5Md9u0TjwSb79sME1iOec?=
 =?us-ascii?Q?Jtrb6fUzV78xBCbJ21V1KidhO6FRumbNOzd74yFWxZcdIPG9cQ+Cjx/IOfJq?=
 =?us-ascii?Q?PKMkeoUgeZFWJ8491QVOsV1rxJIGYiZbLoLPBlr7UCTEI/URg2bsGsavHlNw?=
 =?us-ascii?Q?qNO+3hv/EqOPSlP4Vx5PjEPl1KaSO923eKnbe7onCNG+tE/I71yhqMQY4uyb?=
 =?us-ascii?Q?gWkzjTM8RTW1OqFhe+abp2c67yDuthvrKrv7d7oPU2L0az3ZVKVHciQvPJn9?=
 =?us-ascii?Q?mEvNcVftBSPMJjaV6jV11/Y/Ef7jYfq1VuhKn5zwa0JUcF9YpeWV1lzlSLRE?=
 =?us-ascii?Q?9CunOTu5XL0owWLVMBwEbMCE5v8efpIVAAoqUA0c0NVM35H7+tZ9fBLZxgT+?=
 =?us-ascii?Q?fz95lstrznjG7YU3cyZvB2PXW1F1cuZQB5juOIDcgSx2VstNFwxs4d8jlPe1?=
 =?us-ascii?Q?/BKuycm/wMEySfjfYspa11/UrcnT0DG5JBIKSGZk?=
Content-Type: multipart/alternative;
 boundary="_000_IA1PR12MB63308A2F69036E3ACCC605D0A5B92IA1PR12MB6330namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29c05e5-9e86-4143-ce40-08dd7fe95e50
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2025 08:57:24.2585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L8qYipYluJTX9P752+xJE1Xs27e+rFZxsdxVlaZ38feR00W4FvYtjOsHsz2T320ek1H+l6JaeJ+Mc39SIzTcfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9334
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

--_000_IA1PR12MB63308A2F69036E3ACCC605D0A5B92IA1PR12MB6330namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Harry,

I implemented a working echo server with your API.
The code is here: https://github.com/getelson-at-mellanox/rdpdk/tree/safe-q

Several changes:

  *
DPDK configuration is split to 3 mandatory steps:
     *
port configuration in
Port::configure(&mut self, rxq_num: u16, txq_num: u16) -> Result<(), String=
>
     *
Rx queues configuration in
Port::config_rxqs(&mut self, desc_num: u16, mempool: DpdkMempool) -> Result=
<(), String>
     *
Tx queues configuration in
Port::config_txqs(&mut self, desc_num: u16) -> Result<(), String>
  *
In the IO thread, I renamed the `enable_polling()` to `activate()` for Rx/T=
x symmetry.
  *
I renamed `port` and `q` struct members to `port_id`, `queue_id`

Build steps:


  1.
Apply https://github.com/getelson-at-mellanox/rdpdk/blob/safe-q/dpdk-patche=
s/0001-rust-export-missing-port-objects.patch to DPDK source.
  2.
Install DPDK
  3.
Set PKG_CONFIG_PATH to DPDK installation

Activation:

# cargo run --example echo -- -a <port PCI address>

Regards,
Gregory




________________________________
From: Van Haaren, Harry <harry.van.haaren@intel.com>
Sent: Friday, April 18, 2025 14:40
To: Gregory Etelson <getelson@nvidia.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Richardson, Bruce <bruce.richardson@intel.=
com>; owen.hilyard@unh.edu <owen.hilyard@unh.edu>
Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq

External email: Use caution opening links or attachments


> From: Etelson, Gregory
> Sent: Thursday, April 17, 2025 7:58 PM
> To: Van Haaren, Harry
> Cc: dev@dpdk.org; getelson@nvidia.com; Richardson, Bruce; owen.hilyard@un=
h.edu
> Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
>
> Hello Harry,
>
> Thank you for sharing the API.
> Please check out my comments below.

Thanks for reading & discussion!

<snip>

> > +
> > +            pub fn start(&mut self) -> (Vec<RxqHandle>, Vec<TxqHandle>=
) {
> > +                // call rte_eth_dev_start() here, then give ownership =
of Rxq/Txq to app
>
> After a call to Port::start, Rx and Tx queues are detached from it's port=
.
> With that model how rte_eth_dev_stop() and subsequent rte_eth_dev_start()
> DPDK calls can be implemented ?

Correct, the RxqHandle and TxqHandle don't have a "back reference" to the p=
ort.
There are a number of ways to ensure eth_dev_stop() cannot be called withou=
t the
Rxq/Txqs being "returned" to the Port instance first.

Eg: Use an Arc<T>. The port instance "owns" the Arc<T>, which means it is g=
oing to keep
   the Arc alive. Now give each Rxq/Txq a clone of this Arc. When the Drop =
impl of the
   Rxq/Txq runs, it will decrement the Arc. So just letting the Rxq/Txq go =
out of scope
   will be enough to have the Port understand that handle is now gone.

   The port itself can use Arc::into_inner function[1], which returns Optio=
n<T>. If the
   Some(T) is returned, then all instances of RxqHandle/TxqHandle have been=
 dropped,
   meaning it is safe to eth_dev_stop(), as it is impossible to poll RXQs i=
f there's no Rxq :)
   [1] https://doc.rust-lang.org/std/sync/struct.Arc.html#method.into_inner

// Pseudo-code here:
Dpdk::Eth::Port::stop(&mut self) -> Result<(), Error> {
    let handles_dropped =3D self.handle_arc.into_inner(); // returns "T" if=
 its the only reference to the Arc
    if handles_dropped.is_none() {
        return Err("an Rxq or Txq handle remains alive, cannot safely stop =
this port");
    }
}

There's probably a few others, but that's "idiomatic Rust" solution.
We'd have to pass the Arc from the RxqHandle into the Rxq instance itself t=
oo,
but that's fine.

<snip>

> > +fn main() {
> > +    let mut dpdk =3D dpdk::Eal::init().expect("dpdk must init ok");
> > +    let rx_mempool =3D dpdk::Mempool::new(4096);
> > +
> > +    let mut ports =3D dpdk.take_eth_ports().expect("take eth ports ok"=
);
>
> Eal::take_eth_ports() resets EAL ports.

I don't think it "resets" here. The "take eth ports" removes the Port insta=
nces from
the dpdk::Eal struct, but there's no "reset" behaviour.

> A call to rte_dev_probe() will ether fail, because Eal::eth_ports is None
> or create another port-0, depending on implementation.

I don't see how or why rte_dev_probe() would be called. The idea is not to =
allow Rust
apps call DPDK C APIs "when they want". The safe Rust API provides the requ=
ired abstraction.
So its not possible to have another call to rte_dev_probe(), after the 1st =
time under eal_init().

Similar topic: Hotplug. I have experience with designing C APIs around hotp=
lug
use-cases (Music/DJ software, from before my DPDK/networking days!). I thin=
k DPDK has
an interesting "push hotplug" approach (aka, App makes a function call to "=
request" the device).
Then on successful return, we can call rte_eth_dev_get_port_by_name() to ge=
t the u16 port_id,
and build the Port instance from that. Outline API:

enum EalHotplugDev {
    EthDev(Dpdk::Eth::Port), // enums can have contents in Rust :)
    CryptoDev(Dpdk::Crypto),
    // Etc
}

Eal::hotplug_add(bus: String, dev: String, args: String) -> Result<EalHotpl=
ugDev, Error> {
    // TODO: call rte_eal_hotplug_add()
    // TODO: identify how to know if its an Eth, Crypto, Dma, or other dev =
type?
    match (dev_type) {
        "eth" =3D> {
            let port_id =3D rte_eth_dev_get_port_by_name(dev);
            EalHotplugDev::EthDev( Dpdk::Eth::Port::new(port_id) )
        }
    }
}

Applications could then do:
  let Ok(dev) =3D eal.hotplug_add("pci", "02:00.0", "dev_option=3Dtrue") el=
se {
      // failed to hotplug, log error?
      return;
  }
  match (dev) {
      EthDev =3D> {
          // handle the dev here, e.g. configure & spawn thread to poll Rxq=
 like before.
      }
  }

I like having an outline of difficult to "bolt on" features (hotplug is typ=
ically hard to add later..)
but I recommend we focus on getting core APIs and such running before more =
detail/time/implementation here.


Regards, -Harry

--_000_IA1PR12MB63308A2F69036E3ACCC605D0A5B92IA1PR12MB6330namp_
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
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hello Harry,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I implemented a working echo server with your API.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
The code is here: <a href=3D"https://github.com/getelson-at-mellanox/rdpdk/=
tree/safe-q" id=3D"LPlnk" class=3D"OWAAutoLink">
https://github.com/getelson-at-mellanox/rdpdk/tree/safe-q</a><br>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Several changes:</div>
<ul data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:false,&quot;u=
norderedStyleType&quot;:1}" style=3D"margin-top: 0px; margin-bottom: 0px; l=
ist-style-type: disc;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div class=3D"elementToProof">DPDK configuration is split to 3 mandatory st=
eps:</div>
</li><ul data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:true}" s=
tyle=3D"margin-top: 0px; margin-bottom: 0px; list-style-type: circle;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div class=3D"elementToProof">port configuration in&nbsp;<br>
Port::configure(&amp;mut self, rxq_num: u16, txq_num: u16) -&gt; Result&lt;=
(), String&gt;</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div class=3D"elementToProof">Rx queues configuration in&nbsp;<br>
Port::config_rxqs(&amp;mut self, desc_num: u16, mempool: DpdkMempool) -&gt;=
 Result&lt;(), String&gt;</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div class=3D"elementToProof">Tx queues configuration in<br>
Port::config_txqs(&amp;mut self, desc_num: u16) -&gt; Result&lt;(), String&=
gt;</div>
</li></ul>
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div class=3D"elementToProof">In the IO thread, I renamed the `enable_polli=
ng()` to `activate()` for Rx/Tx symmetry.</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div class=3D"elementToProof">I renamed `port` and `q` struct members to `p=
ort_id`, `queue_id`&nbsp;</div>
</li></ul>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Build steps:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<ol start=3D"1" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:f=
alse,&quot;orderedStyleType&quot;:1}" style=3D"margin-top: 0px; margin-bott=
om: 0px; list-style-type: decimal;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div class=3D"elementToProof">Apply <a href=3D"https://github.com/getelson-=
at-mellanox/rdpdk/blob/safe-q/dpdk-patches/0001-rust-export-missing-port-ob=
jects.patch" id=3D"LPlnk">
https://github.com/getelson-at-mellanox/rdpdk/blob/safe-q/dpdk-patches/0001=
-rust-export-missing-port-objects.patch</a>&nbsp;to DPDK source.</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div class=3D"elementToProof">Install DPDK&nbsp;</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div class=3D"elementToProof">Set PKG_CONFIG_PATH to DPDK installation</div=
>
</li></ol>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Activation:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
# cargo run --example echo -- -a &lt;port PCI address&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Gregory</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Van Haaren, Harry &lt=
;harry.van.haaren@intel.com&gt;<br>
<b>Sent:</b> Friday, April 18, 2025 14:40<br>
<b>To:</b> Gregory Etelson &lt;getelson@nvidia.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Richardson, Bruce &lt;bruce.r=
ichardson@intel.com&gt;; owen.hilyard@unh.edu &lt;owen.hilyard@unh.edu&gt;<=
br>
<b>Subject:</b> Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth an=
d Rxq</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">External email: Use caution opening links or attac=
hments<br>
<br>
<br>
&gt; From: Etelson, Gregory<br>
&gt; Sent: Thursday, April 17, 2025 7:58 PM<br>
&gt; To: Van Haaren, Harry<br>
&gt; Cc: dev@dpdk.org; getelson@nvidia.com; Richardson, Bruce; owen.hilyard=
@unh.edu<br>
&gt; Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and =
Rxq<br>
&gt;<br>
&gt; Hello Harry,<br>
&gt;<br>
&gt; Thank you for sharing the API.<br>
&gt; Please check out my comments below.<br>
<br>
Thanks for reading &amp; discussion!<br>
<br>
&lt;snip&gt;<br>
<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; pub fn start(&amp;mut self) -&gt; (Vec&lt;RxqHandle&gt;, Vec&lt;TxqHandl=
e&gt;) {<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; // call rte_eth_dev_start() here, then give owne=
rship of Rxq/Txq to app<br>
&gt;<br>
&gt; After a call to Port::start, Rx and Tx queues are detached from it's p=
ort.<br>
&gt; With that model how rte_eth_dev_stop() and subsequent rte_eth_dev_star=
t()<br>
&gt; DPDK calls can be implemented ?<br>
<br>
Correct, the RxqHandle and TxqHandle don't have a &quot;back reference&quot=
; to the port.<br>
There are a number of ways to ensure eth_dev_stop() cannot be called withou=
t the<br>
Rxq/Txqs being &quot;returned&quot; to the Port instance first.<br>
<br>
Eg: Use an Arc&lt;T&gt;. The port instance &quot;owns&quot; the Arc&lt;T&gt=
;, which means it is going to keep<br>
&nbsp;&nbsp; the Arc alive. Now give each Rxq/Txq a clone of this Arc. When=
 the Drop impl of the<br>
&nbsp;&nbsp; Rxq/Txq runs, it will decrement the Arc. So just letting the R=
xq/Txq go out of scope<br>
&nbsp;&nbsp; will be enough to have the Port understand that handle is now =
gone.<br>
<br>
&nbsp;&nbsp; The port itself can use Arc::into_inner function[1], which ret=
urns Option&lt;T&gt;. If the<br>
&nbsp;&nbsp; Some(T) is returned, then all instances of RxqHandle/TxqHandle=
 have been dropped,<br>
&nbsp;&nbsp; meaning it is safe to eth_dev_stop(), as it is impossible to p=
oll RXQs if there's no Rxq :)<br>
&nbsp;&nbsp; [1] <a href=3D"https://doc.rust-lang.org/std/sync/struct.Arc.h=
tml#method.into_inner">
https://doc.rust-lang.org/std/sync/struct.Arc.html#method.into_inner</a><br=
>
<br>
// Pseudo-code here:<br>
Dpdk::Eth::Port::stop(&amp;mut self) -&gt; Result&lt;(), Error&gt; {<br>
&nbsp;&nbsp;&nbsp; let handles_dropped =3D self.handle_arc.into_inner(); //=
 returns &quot;T&quot; if its the only reference to the Arc<br>
&nbsp;&nbsp;&nbsp; if handles_dropped.is_none() {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return Err(&quot;an Rxq or Txq h=
andle remains alive, cannot safely stop this port&quot;);<br>
&nbsp;&nbsp;&nbsp; }<br>
}<br>
<br>
There's probably a few others, but that's &quot;idiomatic Rust&quot; soluti=
on.<br>
We'd have to pass the Arc from the RxqHandle into the Rxq instance itself t=
oo,<br>
but that's fine.<br>
<br>
&lt;snip&gt;<br>
<br>
&gt; &gt; +fn main() {<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; let mut dpdk =3D dpdk::Eal::init().expect(&qu=
ot;dpdk must init ok&quot;);<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; let rx_mempool =3D dpdk::Mempool::new(4096);<=
br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; let mut ports =3D dpdk.take_eth_ports().expec=
t(&quot;take eth ports ok&quot;);<br>
&gt;<br>
&gt; Eal::take_eth_ports() resets EAL ports.<br>
<br>
I don't think it &quot;resets&quot; here. The &quot;take eth ports&quot; re=
moves the Port instances from<br>
the dpdk::Eal struct, but there's no &quot;reset&quot; behaviour.<br>
<br>
&gt; A call to rte_dev_probe() will ether fail, because Eal::eth_ports is N=
one<br>
&gt; or create another port-0, depending on implementation.<br>
<br>
I don't see how or why rte_dev_probe() would be called. The idea is not to =
allow Rust<br>
apps call DPDK C APIs &quot;when they want&quot;. The safe Rust API provide=
s the required abstraction.<br>
So its not possible to have another call to rte_dev_probe(), after the 1st =
time under eal_init().<br>
<br>
Similar topic: Hotplug. I have experience with designing C APIs around hotp=
lug<br>
use-cases (Music/DJ software, from before my DPDK/networking days!). I thin=
k DPDK has<br>
an interesting &quot;push hotplug&quot; approach (aka, App makes a function=
 call to &quot;request&quot; the device).<br>
Then on successful return, we can call rte_eth_dev_get_port_by_name() to ge=
t the u16 port_id,<br>
and build the Port instance from that. Outline API:<br>
<br>
enum EalHotplugDev {<br>
&nbsp;&nbsp;&nbsp; EthDev(Dpdk::Eth::Port), // enums can have contents in R=
ust :)<br>
&nbsp;&nbsp;&nbsp; CryptoDev(Dpdk::Crypto),<br>
&nbsp;&nbsp;&nbsp; // Etc<br>
}<br>
<br>
Eal::hotplug_add(bus: String, dev: String, args: String) -&gt; Result&lt;Ea=
lHotplugDev, Error&gt; {<br>
&nbsp;&nbsp;&nbsp; // TODO: call rte_eal_hotplug_add()<br>
&nbsp;&nbsp;&nbsp; // TODO: identify how to know if its an Eth, Crypto, Dma=
, or other dev type?<br>
&nbsp;&nbsp;&nbsp; match (dev_type) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;eth&quot; =3D&gt; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; let port=
_id =3D rte_eth_dev_get_port_by_name(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EalHotpl=
ugDev::EthDev( Dpdk::Eth::Port::new(port_id) )<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; }<br>
}<br>
<br>
Applications could then do:<br>
&nbsp; let Ok(dev) =3D eal.hotplug_add(&quot;pci&quot;, &quot;02:00.0&quot;=
, &quot;dev_option=3Dtrue&quot;) else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // failed to hotplug, log error?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp; }<br>
&nbsp; match (dev) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EthDev =3D&gt; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // handle the dev he=
re, e.g. configure &amp; spawn thread to poll Rxq like before.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp; }<br>
<br>
I like having an outline of difficult to &quot;bolt on&quot; features (hotp=
lug is typically hard to add later..)<br>
but I recommend we focus on getting core APIs and such running before more =
detail/time/implementation here.<br>
<br>
<br>
Regards, -Harry<br>
</div>
</span></font></div>
</body>
</html>

--_000_IA1PR12MB63308A2F69036E3ACCC605D0A5B92IA1PR12MB6330namp_--
