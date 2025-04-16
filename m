Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D76AC369C9
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 20:59:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F0D44025A;
	Wed, 16 Apr 2025 22:59:47 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11021085.outbound.protection.outlook.com [52.101.57.85])
 by mails.dpdk.org (Postfix) with ESMTP id 17184400D5
 for <dev@dpdk.org>; Wed, 16 Apr 2025 22:59:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEv2hy7oENvwk6uEXHrimXQgqI4Fy16F6OAq4Sam1kglxr/lz/kvAA6FMZs35jh0Jl89ANKUZLvK5ea3aOYCOjwTN6r7lXUbsEUJwuevaez1eW0ljwBGDnqIkUmi4NFvjCwTeO/o0HZHJDfGTK74kb0wezuiu5c1676T+owfONClc75fiChGL3YeujvdRoJCbMZ0Vh5itjqcjstHOVNE7JtZfNrmdU5jpssPbIhrt3v5yyLoqC6dqBdSVQ0+IzalVRucMz98vg4tkRHCWyk+sgZfFM+Htq78pUTQAwdT6hw9Ip6xD5GATsqqN645NNdDHg4UdoW/lvCZ8tDEbmFouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnxUDLiv6w3JXQAuzJUMn3gVjeoD45a3akK/QWCf2QM=;
 b=Myq3UfOEU7cfT4RwKNK3NVsbzpYjtG/AwmPDG4KIrPyxIb2CP1aRuqpeqiOB86RdI8MjTBSogzRD2LsxUwtwvoS5xYdKARsn7Q51phsiW1XCgO4tq42cXnalmZvtjlOx8X4jHlh1F1EeQK65V83LXmhz+zeVWCEreKsjlIdLRy3QnrvvZbrcE5GErt7+pzTAm3GfhLZ33iHBCCT3gSNGMms22xZHEJ+m2nyBqat38Pumf4NxoLPkxoJFAcxcQrBC96WTFQdA7aaYo2/eygF8tt71yqnhJ5mKuWOreqnpOPkLyfWdPa2HZmiUe5cnyTrlGLH3RqGFhr5v2rwBjF0FlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnxUDLiv6w3JXQAuzJUMn3gVjeoD45a3akK/QWCf2QM=;
 b=CZjxiBhR0/h0ge3AnCsLt5Qel1srMeCWQJ8vdODvxLdngdYFkRk9GVMW2la6siGxvBntcIMZrkI5giFmqLAXvAa940Xuah5tGcdpV9OL0xziUYUdV67JklA0l0yLAe6PMf0R3/Qacj79hl8vmji6iRMv5MhCrKrFlTmoCLNeTMc=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SN7PR21MB3937.namprd21.prod.outlook.com (2603:10b6:806:2e9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.14; Wed, 16 Apr
 2025 20:59:42 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%6]) with mapi id 15.20.8655.012; Wed, 16 Apr 2025
 20:59:42 +0000
From: Long Li <longli@microsoft.com>
To: Long Li <longli@microsoft.com>, Stephen Hemminger
 <stephen@networkplumber.org>, "longli@linuxonhyperv.com"
 <longli@linuxonhyperv.com>
CC: Wei Hu <weh@microsoft.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [Patch v3 6/6] bus/vmbus: set event for channel
 without monitoring support
Thread-Topic: [EXTERNAL] Re: [Patch v3 6/6] bus/vmbus: set event for channel
 without monitoring support
Thread-Index: AQHbpw41wZ6tLppZZU2QKZyIO8/F/rOdN6bAgAme7AA=
Date: Wed, 16 Apr 2025 20:59:42 +0000
Message-ID: <SA6PR21MB423130576DFB4646E300CD7DCEBD2@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1743813338-28238-1-git-send-email-longli@linuxonhyperv.com>
 <1743813338-28238-7-git-send-email-longli@linuxonhyperv.com>
 <20250406090853.78499346@hermes.local>
 <SA6PR21MB42318E4CEA9E6897220F0736CEB72@SA6PR21MB4231.namprd21.prod.outlook.com>
In-Reply-To: <SA6PR21MB42318E4CEA9E6897220F0736CEB72@SA6PR21MB4231.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8be7ef7e-382b-4cfc-91ba-f5e320a7bbbe;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-10T18:03:36Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SN7PR21MB3937:EE_
x-ms-office365-filtering-correlation-id: de0e11c5-86d2-453e-d9e2-08dd7d299c60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?d9ay4R9sujKBLIt1PhQAbQmPjisUtAyyK4B20pHCKSO6t+IImNSBizxZTY+b?=
 =?us-ascii?Q?/O/tC6+iV/wqgc0XSVQ5vsKDgaRw/9WO3NmISci+hF/F+8dmNE00aHd90K1V?=
 =?us-ascii?Q?RHbZ3v/1fbCllC5mo1700TbrHs67AGnkd1FO1DYzoUVxdwVbtZxPBgwNoQ6G?=
 =?us-ascii?Q?k5vvTV6oCg0lNvfH9Y0dhXxNttzluYi10+VVtrx6tibq+tRgt73RzscjPjPF?=
 =?us-ascii?Q?drengF8NOX4Dpf4yE7WxQD85demz+yd4mJ048J2v1gSJSOgRfBkebmqA3VkH?=
 =?us-ascii?Q?N7UYk2m8xBQw07KvtIKiZM4B0w0hlVDt9yJnPrAyhcR2vbWGJ6YH87dT7mtY?=
 =?us-ascii?Q?8cTtIEdj3YCtHVHoIcB4fzsmeOBCbfG5H0/1Qy2xHDhgmWf0QNYXUbB4GEAG?=
 =?us-ascii?Q?h4xC1KnIP8jh5+5Clv1yKUvHC21KQnKMWvaISW/nLO/dMVxtuSZeaJbjwXd3?=
 =?us-ascii?Q?GdiMsxmBkZZiODwvvfDXTFC+MK3W1w4SNNw2Wr4LupjKp8oqt2W3+hZdHxVN?=
 =?us-ascii?Q?B/pxYTGCi8jah2X79HifmC411bzvWZrCjpWXJA5kXWienx56RQbjQO5jzuJz?=
 =?us-ascii?Q?d+kLlGSJBicLWyIdS5PZKTOo7L+BD/po/1BpfzjSKYLtqJU7NNB/fICpl8oq?=
 =?us-ascii?Q?P1BLhXxMPoKtxKsEAdpJBuD6q0N6suKnlyW2s9syPlBjYAyTeFOalP69mwDk?=
 =?us-ascii?Q?ntV1r+BR3I0ffv//sIJhXOB3TO7wyYeTnSqHeg4wQj6/XL2Js7pLItPyIhwJ?=
 =?us-ascii?Q?hxWfu8bL3lRZQ2JzYWgxCz/MEcjPN483VUaW6E9N939/56svcWeJ1ylycTNG?=
 =?us-ascii?Q?jUNMqs0xtYlJg+DG4YbWC9PQ2wVRvg7iQ2p/nZyjW1q9T0Ly7hkP1U/ONPuN?=
 =?us-ascii?Q?nlTHqJMdF5PL4gpfgIHJ2H/SaY2R92EOjr2loG1fZHOrZ/0tCMU7mpSQzyUV?=
 =?us-ascii?Q?1uYj1PTW9Vpi7imXk3jjKhVaFliRufCrMNBJLiZ0hbpkmSP9/BKiD9iA9R6r?=
 =?us-ascii?Q?HPveN6DeVHUXq1DhCtVKXEqi4w8YzDS2swOGqM/rOOwPB9bDDrDzzAWSnbvt?=
 =?us-ascii?Q?CHw6HAyjU/dA7GYs1QuY1ogESse2TCoI7yg9wxig2KDutsi5Y1iwQIH599Dk?=
 =?us-ascii?Q?DkQZv+eV3SD896pbwutCZxuizKmVCYBeTr3HZg5tI3kPBibc0thpP6Divk7v?=
 =?us-ascii?Q?khX8PMwxwfgkCu+MB7Z6UXwll5h3ns/0mgQh4hIqXn5hiTfKqzZRb5GNFp6t?=
 =?us-ascii?Q?3OR2j4Robn2QCbGTIyCYA9bh2qbrwos3iDaanVpUzkTb2Dn8/a+SGccH9AvQ?=
 =?us-ascii?Q?3FeHLVy61+tGx87YzbpxLGODnHM7zcyetpmfW4m/9ljieCR8GnkkkTMD6YZE?=
 =?us-ascii?Q?8hb//Iaj2PIVzvvaO7pPKUUgfCgfJfoMq69hRBR0JbKzBKVzTTuzGs7Su7zT?=
 =?us-ascii?Q?ttn07DJyHz9ov+7hrSNmdhr59CU4sCT3jLiCPYy5bsK9AeKDGgdOSAaUemHr?=
 =?us-ascii?Q?fq6iB7kyXEDZaOg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR21MB4231.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BoktT7k7rq+LsIo+98AXGSDX3TwMa3k5N+/1wzMktlUSj/mNmKs3oxiZD3eA?=
 =?us-ascii?Q?u2BPSQa9WDUdF3MuJ4CisO/JZ2GcA1I4Zx3ioN8l5POfrG7/RoN57fhZCtTW?=
 =?us-ascii?Q?Lr/vquAxKIV/heFUP2faDsSG8zDLy9UlruIwj0l0XyK50udgookiLklIVamx?=
 =?us-ascii?Q?jGJ4Gft/PkAqWcFRequ/YgF+/+juGcWAnW9tgZXl2boLb4oWK5duOPyP+ISY?=
 =?us-ascii?Q?C+yCygQe03mPXEdnkeR3BsNVczEFYs08/QMPSob+xSCRv0lo4GO1PSgV/MTd?=
 =?us-ascii?Q?1xVClu9W5VTcqfAY5nRRQ0m3WXGzyvoncjCaSw5HAtz+eFFZXgRg6Ab9AhH6?=
 =?us-ascii?Q?ZmdTb2axwpBYHXJbNQMkRMBRD3AjAYgofYNG1Fz20a79WPGfMeABJX7Djp0k?=
 =?us-ascii?Q?YOMGHE4I/MbxNOdKqRh6+FOxckSAVEe8oeSBx27tNGGZNosbd2Go5htHtDao?=
 =?us-ascii?Q?eOzQMuU8cWnJ4fp5RvNM5H7dopPNkce2tVZCaWpCigowLb/K4M43U+7/M/rm?=
 =?us-ascii?Q?3DJmJH7Xb/t+8XwsZ3GN1WPKZnzfSfkyLMcJ7APBrTCCTTPHyCVivkKUlbWX?=
 =?us-ascii?Q?8VW1gMmay+cFlsDkOMMUOnECkWvI3pUSecLvwa4JuNfwWvPWfupLZoL1Ra0o?=
 =?us-ascii?Q?bT683w6Yn6b4POcRelnF8rhgYtP/8HfgJZU+DyR7I2Fyvymhwl+MFv1PwsOe?=
 =?us-ascii?Q?mBtFUUu5HHNG12xrGDK9Ckf/vsL5ZnD/kZrSwy1OvTjse9X+FIGdTzcJX6i3?=
 =?us-ascii?Q?RBe4LCOxm4uQNZc6ERLn5QMc7RA2nlmlvWIesVJthys9+ne8BfXbkQieVJhL?=
 =?us-ascii?Q?FS+E+HYOEW3/tvt/amBaapD8KvwppbKxDgyYzS+N5Omr4wnbhmDV9XRHOSth?=
 =?us-ascii?Q?xAnpunheHZI93gnJF4GlrRXBErop95Hq40hUsfpO+3/OpLjdIGIthkQ22wNW?=
 =?us-ascii?Q?uwL5eTBn55VI+vVX2iV1mDq0Yt24VHdHA2QWA8xCXlWdevZnsHhorf2Ssw+Y?=
 =?us-ascii?Q?WowU0xIIkOTqD0IEDXZ5opc/VtLvoACHYVyaV5dmy4JRUikirl+tjEL/ypkO?=
 =?us-ascii?Q?yNiSoOFXbez8U9T5Tf16ixJcNSn2RsDe4xQKi2z8pigiRjaZPBLoZJE97Yjg?=
 =?us-ascii?Q?jrElIejO3Wd3ToffzPkmIrQ9dDP1Zx0G33zbdJ8d/gAhxrftIcVjtMcMh41L?=
 =?us-ascii?Q?RM8Lgj0j2Eea9cG7E5j8lx5uhB2Q1Vu7DQSK8GLu5fgVXRky8ScEw5zk8Yku?=
 =?us-ascii?Q?IsYlAdQ+XGG8H81ItvrShwaU1Odg8ENVnfJEd9e521HhEJoU+AeRjC1YE/Fs?=
 =?us-ascii?Q?Bhsd8+IjZfhRL5ExiOmcsyqbM8wPkTgEwrz/OeeEWW9yPlh5ILdxI+yaeqkD?=
 =?us-ascii?Q?gb77lscRFtxvNm8RFCL4ZAz2hYjQEzIGO+M9X3Ph8wm1SsYQlILA4h2Ki0h6?=
 =?us-ascii?Q?2p6msxIY0HHRT6jxfEHjIzEBoqP2aClZetqlj4ri1XTmI5KYwlXyVRb2vpU3?=
 =?us-ascii?Q?2xTzfKVeyt2ajw2fjJl7B6iwyA2y64rGLPmvHhqHszqg5MpgtAD4BRw9lt9E?=
 =?us-ascii?Q?DGbCyf7wLgNmhniAlPs+r5gyUFVYUPPezr/cC3uG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0e11c5-86d2-453e-d9e2-08dd7d299c60
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 20:59:42.6742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eitIxRVroByIZBbCfQa+ZzWWbDJto7dPxeV7+O/m4PSkZtPjmJh7V4rqr5opP4FFN2WnSUTBV1v1VfLZABaTgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR21MB3937
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

> Subject: RE: [EXTERNAL] Re: [Patch v3 6/6] bus/vmbus: set event for chann=
el
> without monitoring support
>=20
> > Subject: [EXTERNAL] Re: [Patch v3 6/6] bus/vmbus: set event for
> > channel without monitoring support
> >
> > On Fri,  4 Apr 2025 17:35:38 -0700
> > longli@linuxonhyperv.com wrote:
> >
> > > diff --git a/drivers/bus/vmbus/vmbus_channel.c
> > > b/drivers/bus/vmbus/vmbus_channel.c
> > > index bccef168d3..81e8096190 100644
> > > --- a/drivers/bus/vmbus/vmbus_channel.c
> > > +++ b/drivers/bus/vmbus/vmbus_channel.c
> > > @@ -24,6 +24,19 @@ vmbus_sync_set_bit(volatile RTE_ATOMIC(uint32_t)
> > *addr, uint32_t mask)
> > >  	rte_atomic_fetch_or_explicit(addr, mask,
> > > rte_memory_order_seq_cst); }
> > >
> > > +static inline void
> > > +vmbus_send_interrupt(const struct rte_vmbus_device *dev, uint32_t
> > > +relid) {
> > > +	RTE_ATOMIC(uint32_t) *int_addr;
> > > +	uint32_t int_mask;
> > > +
> > > +	int_addr =3D (RTE_ATOMIC(uint32_t)*) (dev->int_page + relid / 32);
> > > +	int_mask =3D 1u << (relid % 32);
> > > +	vmbus_sync_set_bit(int_addr, int_mask);
> > > +
> > > +	vmbus_uio_irq_control(dev, 1);
> > > +}
> > > +
> >
> > This part doesn't look right. RTE_ATOMIC() is just a macro to add the
> > _Atomic attribute.
> >
> > Can it be simplified like this?
> >
> >
> > static inline void
> > vmbus_sync_set_bit(RTE_ATOMIC(uint32_t *) addr, uint32_t mask) {
> > 	rte_atomic_fetch_or_explicit(addr, mask, rte_memory_order_seq_cst); }
> >
> > static inline void
> > vmbus_send_interrupt(const struct rte_vmbus_device *dev, uint32_t relid=
) {
> > 	RTE_ATOMIC(uint32_t *) int_addr;
> > 	uint32_t int_mask;
> >
> > 	int_addr =3D dev->int_page + relid / 32;
> > 	int_mask =3D 1u << (relid % 32);
> > 	vmbus_sync_set_bit(int_addr, int_mask);
> >
> > 	vmbus_uio_irq_control(dev, 1);
> > }
>=20
> Hi Stephen,
>=20
> I need to go back to this version of the patch, as v5 doesn't compile suc=
cessfully
> under clang with the following error:
>=20
> [459/3553] Compiling C object drivers/libtmp_rte_bus_vmbus.a.p/bus_vmbus
> ccache gcc -Idrivers/libtmp_rte_bus_vmbus.a.p -Idrivers -I../drivers -
> Idrivers/bus/vmbus -I../drivers/bus/vmbus -I../drivers/bus/vmbus/linux -
> Ilib/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/e=
al/include -
> I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include -
> Ilib/eal/x86/include -I../lib/eal/x86/include -I../kernel/linux -Ilib/eal=
 -I../lib/eal -
> Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I../lib=
/metrics -
> Ilib/telemetry -I../lib/telemetry -fdiagnostics-color=3Dalways -pipe -
> D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Werror -std=3Dc11 -O=
2 -g -
> include rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wformat-
> nonliteral -Wformat-security -Wmissing-declarations -Wmissing-prototypes =
-
> Wnested-externs -Wold-style-definition -Wpointer-arith -Wsign-compare -
> Wstrict-prototypes -Wundef -Wwrite-strings -Wno-packed-not-aligned -Wno-
> missing-field-initializers -D_GNU_SOURCE -fPIC -march=3Dcorei7 -mrtm -
> DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation
> -Wno-address-of-packed-member -DRTE_LOG_DEFAULT_LOGTYPE=3Dbus.vmbus -
> MD -MQ drivers/libtmp_rte_bus_vmbus.a.p/bus_vmbus_vmbus_channel.c.o -MF
> drivers/libtmp_rte_bus_vmbus.a.p/bus_vmbus_vmbus_channel.c.o.d -o
> drivers/libtmp_rte_bus_vmbus.a.p/bus_vmbus_vmbus_channel.c.o -
> c ../drivers/bus/vmbus/vmbus_channel.c
> ../drivers/bus/vmbus/vmbus_channel.c: In function 'vmbus_set_monitor':
> ../drivers/bus/vmbus/vmbus_channel.c:51:22: error: assignment to 'uint32_=
t *'
> {aka 'unsigned int *'} from incompatible pointer type '_Atomic uint32_t *=
' {aka
> '_Atomic unsigned int *'} [-Werror=3Dincompatible-pointer-types]
>    51 |         monitor_addr =3D &channel->monitor_page-
> >trigs[trigger_index].pending;
>       |                      ^
> cc1: all warnings being treated as errors
>=20
> I think it's okay to define those pointers as "RTE_ATOMIC(uint32_t) *". T=
he
> pointers themselves are not atomic, but data in the addresses they point =
to are
> atomic.
>=20
> Do you think it is okay to proceed with this patch?
>=20
> Thanks,
> Long

I sent out v6 reverting the patch to this version. This compiles okay with =
clang and stdatomic flags.

Thanks,
Long
