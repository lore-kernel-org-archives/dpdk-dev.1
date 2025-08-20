Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14C6CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 23:08:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9BBA40292;
	Thu, 21 Aug 2025 01:08:13 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11022115.outbound.protection.outlook.com [40.107.209.115])
 by mails.dpdk.org (Postfix) with ESMTP id 24BF04026C
 for <dev@dpdk.org>; Thu, 21 Aug 2025 01:08:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVRxdWzhPivrbjC6YhkuQP/0ByRboAMi8Yzp1jYVw5RKAZ9lKTdTVGOIot1OhWLyOr282dpVowkDLrfM8ZoOZ7B4LpBeUMTnxmuu3c1nH6sf0mC2aFeAJ9kszCK8gLeXx5lGf764Q/CUIfJCE0yMKbMw3QWSb+07FWDZUonvM9NdGMzHYnveKde3UADivsVJsInrhcjG7AsvxF9MHbQzod3XKzp6SriOd9ChrI+cI14KDjwfj+AJw5atg2PX5St0ADe0qDUpN71y8COEVu+CHLXnWKBSXVCbGs04HoXKe/ILxlzNhM2kcvt4GqkIGAeVzhR9Q+HW6IZ5Top7KxkGig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5IU+p1bueABciXuTA2Thr0k23yuwjEk2CytyeryT1k=;
 b=PrKqX5a5GfAnph29iBk6ncBHUF/2h/ktqDEvpsEDPmUAAvLaZiqh2ip+yG7YUB72dMhBObvzP3DebV0pGiTj0lKt645HkPtItcIGoSVqQOgMDhXpbwWQMfso0FLHbf3pU/upGshXHmT0XGqv5lk4vMoFVtZE8Y/eVYV9CW0kjtkFBzweFf5+35VbbyQVA/aAlcvXt/G5oF+lJXFxohFqIH8FxzxNDVmqOnmo+G/+3htpSHgEhhkFFSpsX8Fg1KtwDWLuI0a2hmWijiVGJhAxSNDbASmD3sf8yLLSvLSuuSC6HtN6yYYxddB1zuOWVMhsJQzTgssRdrzTA/xZEuyeaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5IU+p1bueABciXuTA2Thr0k23yuwjEk2CytyeryT1k=;
 b=hmLs9LcvaMb5HxCCwA8yZuCLXjarKBHUUHpijX4H9xoI0BTRLJe/JWBnz03BHhBkKb1Ps0cWqGc/Fd4z+URsNwRBw4qxxxmTKe8z12HUZJrQDrpudhi8Lzhr2nOXbpozioQ4t2YJnY68IDnT/FJPvxT9KFCNvTCHbjRS4ZucBKg=
Received: from IA4PR21MB4736.namprd21.prod.outlook.com (2603:10b6:208:550::9)
 by BL1PR21MB3352.namprd21.prod.outlook.com (2603:10b6:208:39c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Wed, 20 Aug
 2025 23:08:08 +0000
Received: from IA4PR21MB4736.namprd21.prod.outlook.com
 ([fe80::828:47a9:c901:15a0]) by IA4PR21MB4736.namprd21.prod.outlook.com
 ([fe80::828:47a9:c901:15a0%2]) with mapi id 15.20.9073.002; Wed, 20 Aug 2025
 23:08:08 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "longli@linuxonhyperv.com"
 <longli@linuxonhyperv.com>
CC: Wei Hu <weh@microsoft.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2] bus/vmbus: add device argument to
 configure if NUMA information on the device should be ignored
Thread-Topic: [EXTERNAL] Re: [PATCH v2] bus/vmbus: add device argument to
 configure if NUMA information on the device should be ignored
Thread-Index: AQHcEgudEnJ4zbu0e0K3jR/ncevf5rRsKDcA
Date: Wed, 20 Aug 2025 23:08:08 +0000
Message-ID: <IA4PR21MB4736D319A0D0D584997FE5D6CE33A@IA4PR21MB4736.namprd21.prod.outlook.com>
References: <1755563066-2592-1-git-send-email-longli@linuxonhyperv.com>
 <20250820124952.7cd930cb@hermes.local>
In-Reply-To: <20250820124952.7cd930cb@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3997f310-8c08-43be-a43d-84c302600ed3;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-08-20T22:59:59Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR21MB4736:EE_|BL1PR21MB3352:EE_
x-ms-office365-filtering-correlation-id: d03240cd-dea7-409f-6f81-08dde03e6d2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?DJthHme9O8sZY9kWF+UC7inkqrN5SQ2Zmte/2aRuY47j+PSRRNkACnjdpDnR?=
 =?us-ascii?Q?2pSMsYUgzoUyFXrO6J1AYaM3olpgduAIxwufcZeUniQSmIzbEpsfi6lfYt0J?=
 =?us-ascii?Q?GW25ib9XMFDxtILczxXckZfvYAM9vtQpHSWbllDicVLHoINxGleLvtkzH4OL?=
 =?us-ascii?Q?U0YqNIen16KPNHMDgk+kxn7R9K9CVcZMU9PLkLVtlx/MhWoILB32NcuDr24U?=
 =?us-ascii?Q?E9WE2G43LPqm97RJ81aAV1jXWfuN1KF9djA1aj4/w2vJq85zQiXmx+2UXmFA?=
 =?us-ascii?Q?svUxkPK5EZJs/VgZHCPFHgh7WHwT99xwPXm7DA3CLC+ph94YnwvZCclyJ7ab?=
 =?us-ascii?Q?j1R3wUq2PDLfxLx1pzYEZAAyOdJQtDF/bs63vhY+ZIqZRwUy/lZ4RAofRj46?=
 =?us-ascii?Q?zN5QWFMWareuj1vcQN1cgxWLBGwQQLIqHT3evcjsHVwbuNvDzizbiPw223Kk?=
 =?us-ascii?Q?YSzkHwEUiDA5mcRkVOrVpaw5q1q8rpxIEcvUiZVTT4eLMyGQ8Voab1oPbMuk?=
 =?us-ascii?Q?z3cvmhMxah7P+5BfQqGhCIVWIUjPMCJ0DMAKfyPoKYV5ByoaGkSupUeJJ8bm?=
 =?us-ascii?Q?K0w83pTskYFVNsdRFTKKl/KgvHO6BpgfgUEmJvA1eR3R/PSUG/vNCjdeC0XM?=
 =?us-ascii?Q?f2OZTgLD5vd9/wFcFqZa7BRVotQHa3tds5ASxXsPiavUyd05GFSQulCOGS6a?=
 =?us-ascii?Q?g7qk87T8VqnCmWOV45zjXZFYNl4s705eu6NEVGlu1B41a9+ujOT2h5MbFTGu?=
 =?us-ascii?Q?GgiS43+RIikntDOr+P6ctDAnPa/Zc3+MaPzBM8urqiiu6NqzhVyen5jjCnf+?=
 =?us-ascii?Q?/20QytQCDvjwnCbClBWd6BoaxVJwMNXOykuyGErQ7MbI7lnQHjUhu7MdGWhq?=
 =?us-ascii?Q?Wbx/CSFQxspE8LZFhkQOxKdNXO5S0Ix9Y8AAkiZAHf+izcaokjQok6AbArTA?=
 =?us-ascii?Q?l/aLVA64McKOxg3Hw/F2EepJ69GHM4XDkeIlB9FVidbcfcxqQHHLG0vwgNuY?=
 =?us-ascii?Q?Sneqw1MRC08BzU25Tyl5UDKLaMhfm2SIE1YGO2LH3BHF/agAnnq7gBZ2j5mD?=
 =?us-ascii?Q?Dh6NerU7OPGkqhggUp4xUZA1eSHf1dTxai9wuwWse4yR7eE8r0e6iZfxLNKe?=
 =?us-ascii?Q?G8w0CmfeS+eiuTp4rbddWhzUHv2Gt6j6kSogp0mNYA10zwt59S3lueF80Oju?=
 =?us-ascii?Q?SJ0vrn3yl9BAaGTMuuE6fHuI75FmBJpv9VW6+Vk70wCV4VjMe+d9+w4qdexV?=
 =?us-ascii?Q?Q0xsunRxmgwYRAEjjIesPdvWrOW8ZfoCQAtW3Q6QDW7bcGrJDCM+6ZPZ3i2N?=
 =?us-ascii?Q?rHIwGwKpyh/cwxye+Qgsks9U5dppTukH5bxsHPyGEKBisptfFSF+AC0i/PgX?=
 =?us-ascii?Q?u6pJy8X3YdDxceSJEUrMLnRrd+Zstq+zK9yIHd6nePyBnRS6Hm4SMwrDKgb3?=
 =?us-ascii?Q?hcadZxKITGfPtDHiLLG6CyicyKtlFHFXGcHLTQ/qI5EoFkLa1eU2a31CR0G+?=
 =?us-ascii?Q?mTal1neEU/6JUwc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR21MB4736.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RgwWbXutdaU0Bh4UpLUzwNFapvy0VxF9o+Bi/zelq0qLpvi9EkN3V+phy5MU?=
 =?us-ascii?Q?AR9n/GXR+/Dr2iQ1O6323PP7ACTiI4oC1AwSazljUKHjskrTws+rVauRRpOs?=
 =?us-ascii?Q?t11wBE0tRpmRRDD+UX6gWiW8DFe+htYHCWRM+1M5V+SQ07b1vOJs+/pYSl7f?=
 =?us-ascii?Q?SY7Z48nv8VzzRIOQb8deSY2nkOS9TBFwWoiRjJDvSCixchwY4UfQ2Jf68sQT?=
 =?us-ascii?Q?y7NvCJ1zNonfVPTcUnVI9r+XNGAzO0V5TWg4eyl+RE7cjcP/DCRkEziymPC9?=
 =?us-ascii?Q?5WAlAU4A51HB9dB5FTytDHCpxEquYzXv/CQy0ikNCqTVeee8mYcamlz79zIt?=
 =?us-ascii?Q?4GgzmNpr3GfuCRUihteAuZgplRjuU9DoHSJq1SeKQWgPrX6iQVen25DrZwSG?=
 =?us-ascii?Q?wjDPvrEgaeD+HCG/v2Qc5k7fqOv1MGhhbQ6BsRVldE7SrE2NPetLxhoVNqBm?=
 =?us-ascii?Q?qHly2/7GecjSXU2XXu1TPpqhLRlu+4jXaule9hrioaScD9wbkd9MYCUyZL1U?=
 =?us-ascii?Q?5Ohfpd1Rzs0qD93tJEg4tgzEfb9lPQy3wih5f1X+wVVFclBF2zLP4kmMwTJd?=
 =?us-ascii?Q?qW9N40nNzMaK2VlefG0R7ddSPAkehOcHQr24I28Ilju3SzcFepCq8IpRh8+s?=
 =?us-ascii?Q?HeQ5WIg/tApuuHncmBu+m+EyaW1A0TpP9679rmw8knWr7CUTgT3HgLGN2dWs?=
 =?us-ascii?Q?H6+H+CM2nRh3wl4THiRWc82kCkXix4O/BQfIpr8GgxKxxBwFyOUeT0hyl5wl?=
 =?us-ascii?Q?GBXcodB949Ev/v7iLAf/5/zsFOJUHjvNSuvxPyuPWJ/Y0RyBTIFULAo/kowH?=
 =?us-ascii?Q?tWNiqV9YcEQs/ht2uI3r/0cbvpiunlHvsCr5S5jKlRK8LOsCXX/laL2ocWtw?=
 =?us-ascii?Q?T6dkY0XquSOdqbAnLdqOKJRinq7gf8oN1jaZqIpPFFsjfw9U/f8KY9zrI/4v?=
 =?us-ascii?Q?3WPsD1fm2IUNu8SAkfkVLdEoMEKd/Jmu4gucV1XTlnQUg8tZ6GHycRn6gmB+?=
 =?us-ascii?Q?3yjzVmDYJCI23Suok8mvykmVb9xxkYz7eZAuT0TqZbsh7m106/+rom4VOcdz?=
 =?us-ascii?Q?jpjD4dLWNozDtmED9D1/fFrsu0z5yTYYARF+3S6Uqa9HyeVlrrVyJytEPaHj?=
 =?us-ascii?Q?2aXwpO/8rVMNJdp7NibbkuIfW/667xNDTRBh9a/fxeYChzVcIhe2MTd8zH4S?=
 =?us-ascii?Q?MvTIAbHeZlxm60jzDBXd14QHvWT9FAbXJPDpT7LNtvNVuPHSMluywZb68EBy?=
 =?us-ascii?Q?z2ueBudu+kH6v/JwbB1HSgK9gQyelcqiW0/laTNYAKTWBgwW7F6SQkAyq6Rr?=
 =?us-ascii?Q?o4CnMOOdDeGvtJNgQcVNOt2pGCdbNXR7cFgXXPoqLTcbOAo0oh6t0qkWnb7w?=
 =?us-ascii?Q?z1+2ggm0mNrOUDbANHSEu/Idc1Gt5JkBAhWneLk88lJRBi8vza+d0VIvlnqH?=
 =?us-ascii?Q?qirFw0glCtXZTc4KOfygEU37aH6c6iIAPJM+raWhZUT6FOosCo4ZtWqMbmS2?=
 =?us-ascii?Q?LJFS+ihXfMl1IPmrcwe1/4AXXNFOQcfut9ElrWemrXW9zbuiEwkykXExHkx7?=
 =?us-ascii?Q?BkNbU1Cpk3antibSIASJn7P5Uxk6KYYLu4+oxZ1/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR21MB4736.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03240cd-dea7-409f-6f81-08dde03e6d2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 23:08:08.0604 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a5d9jxJIYfUbloAQmjFh/sj+F8CKbw1QFCP7OwIIvXTfuUIqRiQEgdLVBqoQu4LHTSSdjTGm0FH27mByK9vrwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3352
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

> Subject: [EXTERNAL] Re: [PATCH v2] bus/vmbus: add device argument to
> configure if NUMA information on the device should be ignored
>=20
> On Mon, 18 Aug 2025 17:24:26 -0700
> longli@linuxonhyperv.com wrote:
>=20
> > From: Long Li <longli@microsoft.com>
> >
> > In most cases, netvsc is used with a VF device. The application
> > generally runs with better performance when all the device memory is
> > allocated on VF's NUMA node, as the VF device carries most of the data
> packets.
> >
> > But sometimes netvsc may run on a different NUMA node than that of the
> VF.
> > This patch adds a device argument "numa" to allow the application to
> > configure if this vmbus device (netvsc) should be NUMA aware. The
> > default behavior is NUMA aware. Setting "numa=3D0" specifies this vmbus
> > device is not NUMA aware.
> >
> > The device argument is parsed at the time of vmbus device probe to
> > ensure all the following memory allocations are done on the configured
> NUMA node.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
>=20
> Putting all the args in vmbus seems confusing, and not what I meant.
> Was more thing that ethdev and queues should be on same NUMA node.
>=20
> If NUMA is better why wouldn't it always be on?
> Since netvsc is really a virtual device not sure.
> I suspect 99% of users will be using with VF, that should be the default.

Sorry I misread your previous comment on handling this in VMBUS code. I'm s=
till a little confused.=20

Should I add a "numa_aware" device argument for netvsc, and have VMBUS code=
 to parse this argument before calling the device probe function of netvsc?

Maybe all the vmbus device should default to be not NUMA aware. But I don't=
 know if there are use cases using netvsc without VF and if NUMA makes a di=
fference in those situations.

It's difficult to decide the NUMA node for a VF in advance, since they can =
be hot added at any time after DPDK starts.
