Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D8BCA0FED
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Sep 2025 06:59:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4075440150;
	Fri,  5 Sep 2025 08:59:34 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by mails.dpdk.org (Postfix) with ESMTP id F0106400D5;
 Fri,  5 Sep 2025 08:59:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLoBLbPE1mBBVToTNVUbKQbN5jv68ZeY1zB8+fGycUjiplXdBp/SVhtSFsPENphtR96Bp4oA8Ihsutp4Kuq/VMW3oHLNlIQEm2dYS6lXnRGoYQjr3asGgc7XZ7D6RmeXmirsASDcrjLBuoAbBN2a+Kkjaehv0qVbGv3s0OGckIe3bYUjJfwSMjK9KEFTyqZ0KSsRIJYUywVIVujUt+AC1z3SQu3pAF15IMdliEtLVS0cticInrOR+HJ+5DEdOTx2yxr8o3DXjiDZNq3ls+C1u7zHmSl3+MnrShokah+tb2QVrRsXdHFT2i2xJB7J5rsGkvNKa6G2jhpJTlVFfoKuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PPA/kzPyqyxej7dn05IHq5mAtQuuQPTjICBkFOUzuw=;
 b=E5O5Yrp5o7BPy00obCMhyfop1d7LYEbRM2k+oBRjTpdaCRMOCNh7PzUjoBiFg9QnVlLjswW4LY6brTABA2B+/Xe0dGySrK5enFXQc6Nkcz7UUjewoAE9JghH+0o3sb+Jz2UdD+HaaWklxlb2ccN/fHxHx6D2X0hDRXE97bMOBFxpsoUKY8XZ6UnuVW1H2Zts0TL7u25suXZyjy55naBJFK+rx1I+2idPPO8vv0uiyEXHfRgPu5H4mwTleuWDY6tRNH6+zRfhVxUY/0bdyj0NBKRBq5dX5sSfo/iXEWLi3JDcEOxzjGmIkIgMfAEympAZW75Vt+n+YIhpdxCEvx3y1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PPA/kzPyqyxej7dn05IHq5mAtQuuQPTjICBkFOUzuw=;
 b=GpCXiQxXBsnNVn0NvGcG90Q7zf+8SwDNQH4+QurYo4T64iOeElSwPaZc8CMpW0qE7jKVquxKzrgbymZuZ1LC/oWR0MMC6eUHAuGTehVazPy775js+a7gavs+Fb7OsRleAkWl+qhj7oSKIEttQoig5P18YyCxUlKcs2OeQSvwL4Q=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by PH0PR12MB8006.namprd12.prod.outlook.com (2603:10b6:510:28d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 5 Sep
 2025 06:59:27 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1%5]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 06:59:27 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Xueming Li <xuemingl@nvidia.com>, Ali Alnubani <alialnu@nvidia.com>,
 "stable@dpdk.org" <stable@dpdk.org>
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
Subject: RE: 23.11.5 patches review and test
Thread-Topic: 23.11.5 patches review and test
Thread-Index: AQHcCsYIpR+qvKprXUai9FjeZIkw+LRqJdEAgAaL4ICAE50ScA==
Date: Fri, 5 Sep 2025 06:59:27 +0000
Message-ID: <PH7PR12MB8596073D1B5FAD1A045BFF728203A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250811134220.45579-1-xuemingl@nvidia.com>
 <8a89c883-e287-4640-80f2-576f6e8a1e71@nvidia.com>
 <CH3PR12MB865848892AA41B5EA3E4228EA13CA@CH3PR12MB8658.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB865848892AA41B5EA3E4228EA13CA@CH3PR12MB8658.namprd12.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-05T06:56:07.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|PH0PR12MB8006:EE_
x-ms-office365-filtering-correlation-id: e821856a-87cf-4595-cf89-08ddec49c142
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|8096899003|13003099007|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?ofP9YH8L5hqOg3rDOkrgA3f2ymNTLAR6SdkZaBk+k8hYTHAZ/TmOYZC922yk?=
 =?us-ascii?Q?sep5dMommjmJZMzkEi639wDEk+ZN6wtiObxZUL4B6CpzSPGF9u7V8VYbmJmB?=
 =?us-ascii?Q?Ft/YhAxqUd8EdaK5aoaTmBiEdkRc1QLqLl6LjAteJCzN058t8hcI9OF8cxVo?=
 =?us-ascii?Q?lhPU93QzRQ7/3U/EyROWdfZecnrgORxfZqlHS4T8Gq12gHUfLmNZ8o/ikR8U?=
 =?us-ascii?Q?/Be6KLv2TV9hmct3sCFnk5mPVEi3Dohm0qddnkrVNFv6B3xhq7pgNHQMjUvR?=
 =?us-ascii?Q?9lhGViyxsUhrzs+3nC+acmj+FjiNZj9c/s0aTZiaEdezdFiwcr6F0T7nAUFl?=
 =?us-ascii?Q?0m6ljf8tyYVm0feyvnflM+jIIVD/OMmGRsU21hlzPh4hWbpxUrvqpUmFKZg8?=
 =?us-ascii?Q?DEsPxfSEh4tpLm9cxslvgyQsuIGbuim5mA5qSJ3WjlqSGSDtK8tU/BeT4Veu?=
 =?us-ascii?Q?GtIp/GcQ1hgvbfxnlzKUHLOKcDNquSrnmG/r5i21LU4fuxnG+nBckdHTSwJD?=
 =?us-ascii?Q?jPoboIn02zxpyTuqGycNJ0+oPkY1d6XbC1b59GNZN6vLsj3XHXM5yryhAxjw?=
 =?us-ascii?Q?EXwNzl7l9cZC0HV9nIuJ34uMip2eIn5rHV4mUUK34MKSYjaWNAyusVduV08n?=
 =?us-ascii?Q?ue5o1VsIixaqjwsu2kosqH40IrXttoihDtZ4tSsjFxOg3s/4a3N8kOTW7bak?=
 =?us-ascii?Q?6d4hlPL03555U/3glBaUlTPs+XpRXPMW1jZFxTc5u3QEMF7Ipa6EQQjMOqZ4?=
 =?us-ascii?Q?0e5aw+hM2Jmf+QzYDsdwWJtPNVK3U06XgteCurlboe5JzNrWuThMLBokADiZ?=
 =?us-ascii?Q?47iwO/5HEX6he1AATMTyE+tuL5w7beTDboqQtL9+0SH/ICUqta2hDg3w2wmB?=
 =?us-ascii?Q?q62FQDLjQ5w0VlCgHvZPiye5nwmm/ldR6SNn/7j0wtRw79Su/BSdh3LjUE3T?=
 =?us-ascii?Q?3lStwGbpYooH8RT0DgBP/jSOGk4xyaO6wFbll/QRvLsZSGsHYO9HVbA2YKRv?=
 =?us-ascii?Q?4zdMC1SDMwoOr1i10ZPREDY+MHPB5qszb7VO3JEVQCodXKj+S93JkkcfLYcd?=
 =?us-ascii?Q?PDIOFoFClpWyeoJMi45JjatJjyqHzpfP5UraMF0w/M4hi5OcEmTdNuMFnQaQ?=
 =?us-ascii?Q?bJHtdOxBHOuUaoG1D76ojTqm/5Y6hS9SjnedyjMeahXZ0XMI2nn6XoXEbXGV?=
 =?us-ascii?Q?hgPIiVi8ws1mZx4GldriD0VwzkcUG2y9nHmUdjbneIkHiRsVr8c0TfGYykOn?=
 =?us-ascii?Q?6PM/4Btb6yBUaYxj8z65eFCMHdk4xKlp0sx8HclTLgsBKfGALnl1C0OqyK7w?=
 =?us-ascii?Q?ZeV7xbLM+GEoLWYhwVrKKfp7hLkF0i/9lvCWVoaFGoJNxi52AJVEcVijPqUD?=
 =?us-ascii?Q?AyHfkOwW+y14xgTdpVGtjeAwucrAf6jxrCUfivwWhD8192z1l385kjbiVwB/?=
 =?us-ascii?Q?ahvyijJTFsk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(8096899003)(13003099007)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6O/j8KlyxRe4mjHF/MsTpfP82i++31stx7rhFmkCa2CLyuBoxscOEieC6RX8?=
 =?us-ascii?Q?3iTKweTqARMf+gv/bU6faWrHJeC51Wtn24/b28eeZ3DoQgXTh9b86izNHM6r?=
 =?us-ascii?Q?o8p9xg0K0C0WmIme7q0kO5Mq3cdf0D4w5KrfVSMjpHguB/OROCgoaq1LEOHE?=
 =?us-ascii?Q?CV79koVV1OZ74d2M4+BMeVFuh9sE6Uvo0XD4imsdvFqCDJqQPXqg8H8mp3hi?=
 =?us-ascii?Q?u9Jzg04Ixw/cL5wMJx2DnTR9Ii3vn7brvGUPLgX+G+8RmFds/gQqlvMN+h74?=
 =?us-ascii?Q?9fWIp/Wyx5SV7BUlREp6Bzv4gXSB/SLrReuAorbNlO+xGJVdnjCkir52D9vh?=
 =?us-ascii?Q?NmSQsENIopey1+eXxIut1e43/1opcRjufnSoU1mVCOwlr3BnTOGz+I+2dlMo?=
 =?us-ascii?Q?S31lyvx+deLRsH29+LYMpDzzE6LkpDGXMfhFmefuYKVaRSabzgyQ/8cHMiLW?=
 =?us-ascii?Q?HJGJAVEEazRgsKlHVSCOnIZdDZZDiKrEWNjWbd5ipNPkrm7BLJoxPwM7U/7G?=
 =?us-ascii?Q?079vSOv+frhm6EVozhb62MctdkfHaVQi5XxKSUR1fCYRx6dWiw9nRotdJM3w?=
 =?us-ascii?Q?pzZqrEZeAW3VrHfkqkapZILfoj2i+To3rN+c+H30lwKCNH1vaZORQ3L3tljX?=
 =?us-ascii?Q?GN7q3QR3lJJGu39bMBiV36O/8o8n+dWGMlLCAGpqjSlOUQeUrWwVM0wC1Z5V?=
 =?us-ascii?Q?hAkMC93aRXP9CGhxBc5BW6UGoJg9LqEojDIjlGxn2OqNAO/jB7ktBG/Xlh0I?=
 =?us-ascii?Q?wjJEzaLNCJ8dXpLJmejXwf59tif4qhZ0AeVwUay8bH20nxs2VakiwYOdd6Lq?=
 =?us-ascii?Q?ikMXLp17q8pdiBVZO1avJ3q4M1ZcdwcUcOCm2MB/TFe9fMkluaAXRCRVHUS6?=
 =?us-ascii?Q?d0U+YVKTFxnQKIt4yMMxQNhIbiMjL4c3xfVOyAE2qCzVCAeZjxwz/MYE3SfN?=
 =?us-ascii?Q?UQS0sAotLp7IEb0ocrEBS2LGfTiku6yyGisUuMvpA1MiB3+67q4qCTXvbSzr?=
 =?us-ascii?Q?mVe0hrEAXT89+kxfmRRIHtA2kZ1UbGwsD3Ll36G6mB9YZa5f6tWC9Zv1tikU?=
 =?us-ascii?Q?Fp9c64+RsqMRMzja0WHTqoxshd3RsycAYxqj8gtU4Az4WbVrBTIqAfMppA1R?=
 =?us-ascii?Q?0DO9PjVxrU2i8jDiDXrnwYa7xVws8N6gVTNewBP/BkfY1Ww4yggHwNYEA/r4?=
 =?us-ascii?Q?h+N0xUguXjlRS/lusedrVxgOytOorTNGRCLsUb9E2glwwbkblKiEh7SvTUCJ?=
 =?us-ascii?Q?NVSy8d7vAPr/HgIL9RXxIcmZ5NE+xJYFNTwuGSEXWbHjvniyQ1Hh8fR7IBWv?=
 =?us-ascii?Q?6/UzrKszGIfrPJL0O9sbgajAGTvFIyzJN3iIfSL+ynazj60CPb4hhu1+tqp1?=
 =?us-ascii?Q?s6VWiTJ9FvmOhVO5rPUeGHp4PypYBFyutUE7Paf6mN+0XtsSQAx4PcZePN5U?=
 =?us-ascii?Q?y+RSAW1yHQuWDqVIvOAnWIIdJVY/zlsqD8aesG3rm6LnL1SpAZ28O/LMD+WS?=
 =?us-ascii?Q?Xqgv0G18Wk2uOKWmRmnkfVIDsaQw+pAq9ZGPtySmKV4EAZwxRDhrg9aZjU/x?=
 =?us-ascii?Q?BVOx536xOfEVnhBkSz4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB8596073D1B5FAD1A045BFF728203APH7PR12MB8596namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e821856a-87cf-4595-cf89-08ddec49c142
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 06:59:27.5055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5jOQl1DWt2WssUUfrLt1CjKiy0/orMwE8BUpwbwXBBKzdp4jIgfMUy2X75MKR47Yyztu68qM8FqPpYQ2/f4YZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8006
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

--_000_PH7PR12MB8596073D1B5FAD1A045BFF728203APH7PR12MB8596namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Xueming Li,

From AMD side we executed dpdk-testpmdio & L3fwd-ACL mode on Mellanox CX-7 =
on AMD EPYC platform using


  1.  Gcc 14.2
  2.  Server
     *   Milan
     *   Genoa
     *   Siena
     *   Turin
  3.  Buffer sizes
     *   64
     *   128
     *   256
     *   512
     *   1024
     *   1518
  4.  DPDK comparison: 23.11.4 vs 23.1..5
  5.  Only deviation is found in 1Core 2Thread for 128B 5%

From: Xueming Li <xuemingl@nvidia.com>
Sent: Sunday, August 24, 2025 12:55 AM
To: Ali Alnubani <alialnu@nvidia.com>; stable@dpdk.org
Cc: dev@dpdk.org; Abhishek Marathe <Abhishek.Marathe@microsoft.com>; David =
Christensen <drc@linux.vnet.ibm.com>; Hemant Agrawal <hemant.agrawal@nxp.co=
m>; Ian Stokes <ian.stokes@intel.com>; Jerin Jacob <jerinj@marvell.com>; Jo=
hn McNamara <john.mcnamara@intel.com>; Ju-Hyoung Lee <juhlee@microsoft.com>=
; Kevin Traynor <ktraynor@redhat.com>; Luca Boccassi <bluca@debian.org>; Pe=
i Zhang <pezhang@redhat.com>; Raslan Darawsheh <rasland@nvidia.com>; NBU-Co=
ntact-Thomas Monjalon (EXTERNAL) <thomas@monjalon.net>; Yanghang Liu <yangh=
liu@redhat.com>; benjamin.walker@intel.com; qian.q.xu@intel.com; yuan.peng@=
intel.com; zhaoyan.chen@intel.com
Subject: Re: 23.11.5 patches review and test

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.

Hi Ali,

Thanks very much for your help!

________________________________
From: Ali Alnubani <alialnu@nvidia.com<mailto:alialnu@nvidia.com>>
Sent: Tuesday, August 19, 2025 11:26 PM
To: Xueming Li <xuemingl@nvidia.com<mailto:xuemingl@nvidia.com>>; stable@dp=
dk.org<mailto:stable@dpdk.org> <stable@dpdk.org<mailto:stable@dpdk.org>>
Cc: dev@dpdk.org<mailto:dev@dpdk.org> <dev@dpdk.org<mailto:dev@dpdk.org>>; =
Abhishek Marathe <Abhishek.Marathe@microsoft.com<mailto:Abhishek.Marathe@mi=
crosoft.com>>; David Christensen <drc@linux.vnet.ibm.com<mailto:drc@linux.v=
net.ibm.com>>; Hemant Agrawal <hemant.agrawal@nxp.com<mailto:hemant.agrawal=
@nxp.com>>; Ian Stokes <ian.stokes@intel.com<mailto:ian.stokes@intel.com>>;=
 Jerin Jacob <jerinj@marvell.com<mailto:jerinj@marvell.com>>; John McNamara=
 <john.mcnamara@intel.com<mailto:john.mcnamara@intel.com>>; Ju-Hyoung Lee <=
juhlee@microsoft.com<mailto:juhlee@microsoft.com>>; Kevin Traynor <ktraynor=
@redhat.com<mailto:ktraynor@redhat.com>>; Luca Boccassi <bluca@debian.org<m=
ailto:bluca@debian.org>>; Pei Zhang <pezhang@redhat.com<mailto:pezhang@redh=
at.com>>; Raslan Darawsheh <rasland@nvidia.com<mailto:rasland@nvidia.com>>;=
 NBU-Contact-Thomas Monjalon (EXTERNAL) <thomas@monjalon.net<mailto:thomas@=
monjalon.net>>; Yanghang Liu <yanghliu@redhat.com<mailto:yanghliu@redhat.co=
m>>; benjamin.walker@intel.com<mailto:benjamin.walker@intel.com> <benjamin.=
walker@intel.com<mailto:benjamin.walker@intel.com>>; qian.q.xu@intel.com<ma=
ilto:qian.q.xu@intel.com> <qian.q.xu@intel.com<mailto:qian.q.xu@intel.com>>=
; yuan.peng@intel.com<mailto:yuan.peng@intel.com> <yuan.peng@intel.com<mail=
to:yuan.peng@intel.com>>; zhaoyan.chen@intel.com<mailto:zhaoyan.chen@intel.=
com> <zhaoyan.chen@intel.com<mailto:zhaoyan.chen@intel.com>>
Subject: Re: 23.11.5 patches review and test

On 8/11/25 4:42 PM, Xueming Li wrote:

> Hi all,
>
> Here is a list of patches targeted for stable release 23.11.5.
>
> The planned date for the final release is 15th August.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>      https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv23.11.5-rc1
>
> These patches are located at branch 23.11 of dpdk-stable repo:
>      https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Xueming Li <xuemingl@nvidia.com<mailto:xuemingl@nvidia.com>>
>
> ---

Hello,

We ran the following functional tests with Nvidia hardware on v23.11.5-rc1:
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
MLNX_OFED_LINUX-23.10-5.1.4.0 / Firmware: 22.39.5050
- NIC: ConnectX-7 / OS: Ubuntu 22.04 / Driver:
MLNX_OFED_LINUX-23.10-5.1.4.0 / Firmware: 28.39.5050
- DPU: BlueField-2 / DOCA SW version: 2.5.4 / Firmware: 24.39.5050

Additionally, we ran build tests with multiple configurations on the
following OS/driver combinations (all passed):
- Debian 12 with MLNX_OFED_LINUX-24.10-3.2.5.0.
- Ubuntu 22.04 with MLNX_OFED_LINUX-24.10-3.2.5.0.
- Ubuntu 24.04 with MLNX_OFED_LINUX-24.10-3.2.5.0.
- Ubuntu 22.04 with rdma-core master (091ddb5).
- Ubuntu 24.04 with rdma-core v50.0.
- Fedora 42 with rdma-core v55.0.
- Fedora 43 (Rawhide) with rdma-core v58.0.
- OpenSUSE Leap 15.6 with rdma-core v49.1.
- Windows Server 2022 with Clang 18.1.8.

We don't see new issues caused by the changes in this release.

Thanks,
Ali

--_000_PH7PR12MB8596073D1B5FAD1A045BFF728203APH7PR12MB8596namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1884827397;
	mso-list-type:hybrid;
	mso-list-template-ids:1309684498 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Hi Xueming Li,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">From AMD side we executed dpdk-testpmdio &amp; L3fwd-=
ACL mode on Mellanox CX-7 on AMD EPYC platform using<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1"><span style=3D"font-size:11.0pt;font-family:&quot;Arial&quot;,sans-se=
rif">Gcc 14.2<o:p></o:p></span></li><li class=3D"MsoListParagraph" style=3D=
"margin-left:0in;mso-list:l0 level1 lfo1"><span style=3D"font-size:11.0pt;f=
ont-family:&quot;Arial&quot;,sans-serif">Server<o:p></o:p></span></li><ol s=
tyle=3D"margin-top:0in" start=3D"1" type=3D"a">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level2 =
lfo1"><span style=3D"font-size:11.0pt;font-family:&quot;Arial&quot;,sans-se=
rif">Milan<o:p></o:p></span></li><li class=3D"MsoListParagraph" style=3D"ma=
rgin-left:0in;mso-list:l0 level2 lfo1"><span style=3D"font-size:11.0pt;font=
-family:&quot;Arial&quot;,sans-serif">Genoa<o:p></o:p></span></li><li class=
=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level2 lfo1"><sp=
an style=3D"font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Sien=
a<o:p></o:p></span></li><li class=3D"MsoListParagraph" style=3D"margin-left=
:0in;mso-list:l0 level2 lfo1"><span style=3D"font-size:11.0pt;font-family:&=
quot;Arial&quot;,sans-serif">Turin<o:p></o:p></span></li></ol>
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1"><span style=3D"font-size:11.0pt;font-family:&quot;Arial&quot;,sans-se=
rif">Buffer sizes<o:p></o:p></span></li><ol style=3D"margin-top:0in" start=
=3D"1" type=3D"a">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level2 =
lfo1"><span style=3D"font-size:11.0pt;font-family:&quot;Arial&quot;,sans-se=
rif">64<o:p></o:p></span></li><li class=3D"MsoListParagraph" style=3D"margi=
n-left:0in;mso-list:l0 level2 lfo1"><span style=3D"font-size:11.0pt;font-fa=
mily:&quot;Arial&quot;,sans-serif">128<o:p></o:p></span></li><li class=3D"M=
soListParagraph" style=3D"margin-left:0in;mso-list:l0 level2 lfo1"><span st=
yle=3D"font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">256<o:p><=
/o:p></span></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;ms=
o-list:l0 level2 lfo1"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">512<o:p></o:p></span></li><li class=3D"MsoListParagra=
ph" style=3D"margin-left:0in;mso-list:l0 level2 lfo1"><span style=3D"font-s=
ize:11.0pt;font-family:&quot;Arial&quot;,sans-serif">1024<o:p></o:p></span>=
</li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 le=
vel2 lfo1"><span style=3D"font-size:11.0pt;font-family:&quot;Arial&quot;,sa=
ns-serif">1518<o:p></o:p></span></li></ol>
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1"><span style=3D"font-size:11.0pt;font-family:&quot;Arial&quot;,sans-se=
rif">DPDK comparison: 23.11.4 vs 23.1..5<o:p></o:p></span></li><li class=3D=
"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 lfo1"><span =
style=3D"font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Only de=
viation is found in 1Core 2Thread for 128B 5%<o:p></o:p></span></li></ol>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Xueming Li &lt;xuemingl@nvidia=
.com&gt;
<br>
<b>Sent:</b> Sunday, August 24, 2025 12:55 AM<br>
<b>To:</b> Ali Alnubani &lt;alialnu@nvidia.com&gt;; stable@dpdk.org<br>
<b>Cc:</b> dev@dpdk.org; Abhishek Marathe &lt;Abhishek.Marathe@microsoft.co=
m&gt;; David Christensen &lt;drc@linux.vnet.ibm.com&gt;; Hemant Agrawal &lt=
;hemant.agrawal@nxp.com&gt;; Ian Stokes &lt;ian.stokes@intel.com&gt;; Jerin=
 Jacob &lt;jerinj@marvell.com&gt;; John McNamara &lt;john.mcnamara@intel.co=
m&gt;;
 Ju-Hyoung Lee &lt;juhlee@microsoft.com&gt;; Kevin Traynor &lt;ktraynor@red=
hat.com&gt;; Luca Boccassi &lt;bluca@debian.org&gt;; Pei Zhang &lt;pezhang@=
redhat.com&gt;; Raslan Darawsheh &lt;rasland@nvidia.com&gt;; NBU-Contact-Th=
omas Monjalon (EXTERNAL) &lt;thomas@monjalon.net&gt;; Yanghang Liu &lt;yang=
hliu@redhat.com&gt;;
 benjamin.walker@intel.com; qian.q.xu@intel.com; yuan.peng@intel.com; zhaoy=
an.chen@intel.com<br>
<b>Subject:</b> Re: 23.11.5 patches review and test<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<table class=3D"MsoNormalTable" border=3D"0" cellspacing=3D"0" cellpadding=
=3D"0" align=3D"left" width=3D"100%" style=3D"width:100.0%">
<tbody>
<tr>
<td style=3D"background:#FFB900;padding:5.0pt 2.0pt 5.0pt 2.0pt"></td>
<td width=3D"100%" style=3D"width:100.0%;background:#FFF8E5;padding:5.0pt 4=
.0pt 5.0pt 12.0pt">
<div>
<p class=3D"MsoNormal" style=3D"mso-element:frame;mso-element-frame-hspace:=
2.25pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;mso-el=
ement-anchor-horizontal:column;mso-height-rule:exactly">
<b><span style=3D"color:#222222">Caution:</span></b><span style=3D"color:#2=
22222"> This message originated from an External Source. Use proper caution=
 when opening attachments, clicking links, or responding.
<o:p></o:p></span></p>
</div>
</td>
</tr>
</tbody>
</table>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Hi Ali,<o:p></o:p></span=
></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Thanks very much for you=
r help!<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Ali Al=
nubani &lt;<a href=3D"mailto:alialnu@nvidia.com">alialnu@nvidia.com</a>&gt;=
<br>
<b>Sent:</b> Tuesday, August 19, 2025 11:26 PM<br>
<b>To:</b> Xueming Li &lt;<a href=3D"mailto:xuemingl@nvidia.com">xuemingl@n=
vidia.com</a>&gt;;
<a href=3D"mailto:stable@dpdk.org">stable@dpdk.org</a> &lt;<a href=3D"mailt=
o:stable@dpdk.org">stable@dpdk.org</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:dev@dpdk.org">dev@dpdk.org</a> &lt;<a href=3D"=
mailto:dev@dpdk.org">dev@dpdk.org</a>&gt;; Abhishek Marathe &lt;<a href=3D"=
mailto:Abhishek.Marathe@microsoft.com">Abhishek.Marathe@microsoft.com</a>&g=
t;; David Christensen &lt;<a href=3D"mailto:drc@linux.vnet.ibm.com">drc@lin=
ux.vnet.ibm.com</a>&gt;;
 Hemant Agrawal &lt;<a href=3D"mailto:hemant.agrawal@nxp.com">hemant.agrawa=
l@nxp.com</a>&gt;; Ian Stokes &lt;<a href=3D"mailto:ian.stokes@intel.com">i=
an.stokes@intel.com</a>&gt;; Jerin Jacob &lt;<a href=3D"mailto:jerinj@marve=
ll.com">jerinj@marvell.com</a>&gt;; John McNamara &lt;<a href=3D"mailto:joh=
n.mcnamara@intel.com">john.mcnamara@intel.com</a>&gt;;
 Ju-Hyoung Lee &lt;<a href=3D"mailto:juhlee@microsoft.com">juhlee@microsoft=
.com</a>&gt;; Kevin Traynor &lt;<a href=3D"mailto:ktraynor@redhat.com">ktra=
ynor@redhat.com</a>&gt;; Luca Boccassi &lt;<a href=3D"mailto:bluca@debian.o=
rg">bluca@debian.org</a>&gt;; Pei Zhang &lt;<a href=3D"mailto:pezhang@redha=
t.com">pezhang@redhat.com</a>&gt;;
 Raslan Darawsheh &lt;<a href=3D"mailto:rasland@nvidia.com">rasland@nvidia.=
com</a>&gt;; NBU-Contact-Thomas Monjalon (EXTERNAL) &lt;<a href=3D"mailto:t=
homas@monjalon.net">thomas@monjalon.net</a>&gt;; Yanghang Liu &lt;<a href=
=3D"mailto:yanghliu@redhat.com">yanghliu@redhat.com</a>&gt;;
<a href=3D"mailto:benjamin.walker@intel.com">benjamin.walker@intel.com</a> =
&lt;<a href=3D"mailto:benjamin.walker@intel.com">benjamin.walker@intel.com<=
/a>&gt;;
<a href=3D"mailto:qian.q.xu@intel.com">qian.q.xu@intel.com</a> &lt;<a href=
=3D"mailto:qian.q.xu@intel.com">qian.q.xu@intel.com</a>&gt;;
<a href=3D"mailto:yuan.peng@intel.com">yuan.peng@intel.com</a> &lt;<a href=
=3D"mailto:yuan.peng@intel.com">yuan.peng@intel.com</a>&gt;;
<a href=3D"mailto:zhaoyan.chen@intel.com">zhaoyan.chen@intel.com</a> &lt;<a=
 href=3D"mailto:zhaoyan.chen@intel.com">zhaoyan.chen@intel.com</a>&gt;<br>
<b>Subject:</b> Re: 23.11.5 patches review and test</span> <o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">On 8/11/25 4:42 PM, Xueming Li wrote:<br>
<br>
&gt; Hi all,<br>
&gt;<br>
&gt; Here is a list of patches targeted for stable release 23.11.5.<br>
&gt;<br>
&gt; The planned date for the final release is 15th August.<br>
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
stable/tag/?id=3Dv23.11.5-rc1">https://dpdk.org/browse/dpdk-stable/tag/?id=
=3Dv23.11.5-rc1</a><br>
&gt;<br>
&gt; These patches are located at branch 23.11 of dpdk-stable repo:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://dpdk.org/browse/dpdk-=
stable/">https://dpdk.org/browse/dpdk-stable/</a><br>
&gt;<br>
&gt; Thanks.<br>
&gt;<br>
&gt; Xueming Li &lt;<a href=3D"mailto:xuemingl@nvidia.com">xuemingl@nvidia.=
com</a>&gt;<br>
&gt;<br>
&gt; ---<br>
<br>
Hello,<br>
<br>
We ran the following functional tests with Nvidia hardware on v23.11.5-rc1:=
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
MLNX_OFED_LINUX-23.10-5.1.4.0 / Firmware: 22.39.5050<br>
- NIC: ConnectX-7 / OS: Ubuntu 22.04 / Driver: <br>
MLNX_OFED_LINUX-23.10-5.1.4.0 / Firmware: 28.39.5050<br>
- DPU: BlueField-2 / DOCA SW version: 2.5.4 / Firmware: 24.39.5050<br>
<br>
Additionally, we ran build tests with multiple configurations on the <br>
following OS/driver combinations (all passed):<br>
- Debian 12 with MLNX_OFED_LINUX-24.10-3.2.5.0.<br>
- Ubuntu 22.04 with MLNX_OFED_LINUX-24.10-3.2.5.0.<br>
- Ubuntu 24.04 with MLNX_OFED_LINUX-24.10-3.2.5.0.<br>
- Ubuntu 22.04 with rdma-core master (091ddb5).<br>
- Ubuntu 24.04 with rdma-core v50.0.<br>
- Fedora 42 with rdma-core v55.0.<br>
- Fedora 43 (Rawhide) with rdma-core v58.0.<br>
- OpenSUSE Leap 15.6 with rdma-core v49.1.<br>
- Windows Server 2022 with Clang 18.1.8.<br>
<br>
We don't see new issues caused by the changes in this release.<br>
<br>
Thanks,<br>
Ali<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB8596073D1B5FAD1A045BFF728203APH7PR12MB8596namp_--
