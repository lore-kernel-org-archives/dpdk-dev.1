Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E774AC3601E
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 18:09:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C66940A6E;
	Thu, 10 Apr 2025 20:09:48 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11021113.outbound.protection.outlook.com
 [40.93.194.113]) by mails.dpdk.org (Postfix) with ESMTP id 6BA24406B7
 for <dev@dpdk.org>; Thu, 10 Apr 2025 20:09:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfgyCE77HSFqRhmRR5J1ilwJesfqj6jbA3QGtCpJJttWNgofrJkAbx/u/wR1UKSjSvI26BombZGBmFaHj5t0LDfUX5qfYuywOyW44aEQEeBaxRZZky1uGDsOVkR3T9tffhIv9911qSWg4mu0WJGFmDsjar7OBLq3kzOLfn+2bRXGj3MzbG7isd1u429YVmzcxgt3lvBZVpYMsgNPLkHQGzgV+Qaae9jwVzf/WJ1pH5z7rPjr9gmgNHzH1rpgSnsc7o1F+mLgkph/AiwHfcPecp8D1hHcdsG0xZYUOuwNyJB+I4aANmsbUfPlkqe+jpjyFXPw2xHv5oNrhSLyW6gBPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UCLjz3xomeCZH4feORXkeXynS4lLL0vsfBGs18kXB8=;
 b=X1ndjxDBzdE0f4Vjd6kQ9HtGnBzM2nH4EbvcLYeKi/WY0iexso4G3J3UXG1Mmq2ah5CscWvdRFY6NMvoPm+dVNlSYjQvEB1iZreG3JMYpDYafB/Acg+R90PwnJGQI1x+h2cjNP+wSQZcVeb33kr0k2whLkHA39wlP5iVgNBnDh4c7xAG8ITjMS5JHl/X0sNFmvN6oFquzEqqmzd4wWGOFdCnVB1ED520d+s4bcHlNIuPJta+O4FkiDdEekn2aO6luM/Djj3VX0qFJfhgOER07ZKJ/Foq28T/ZtT7Ns04+pUkZ6U7IcTV0SQeM1XX7tZ0yD47D4nSXXAVZzR1fqlHHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UCLjz3xomeCZH4feORXkeXynS4lLL0vsfBGs18kXB8=;
 b=ZG62w02FfIGwmAGrREkpn1Y3oVjeXYogiiJcBa1ScCMIDAcy3P56COZj7XZ7yzik524uEzD9GaTt4DC0JwHJCASdsbFpNKxZlfmmaIbuHNGe6X7SDN9knqlNEo7E/Z/Jp6dkXKU0udmVxm6Z76cROqB9jkrFOvPDsKLhSvrrjUc=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA1PR21MB4032.namprd21.prod.outlook.com (2603:10b6:806:38f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.3; Thu, 10 Apr
 2025 18:09:45 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%6]) with mapi id 15.20.8632.011; Thu, 10 Apr 2025
 18:09:45 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "longli@linuxonhyperv.com"
 <longli@linuxonhyperv.com>
CC: Wei Hu <weh@microsoft.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [Patch v3 6/6] bus/vmbus: set event for channel
 without monitoring support
Thread-Topic: [EXTERNAL] Re: [Patch v3 6/6] bus/vmbus: set event for channel
 without monitoring support
Thread-Index: AQHbpw41wZ6tLppZZU2QKZyIO8/F/rOdN6bA
Date: Thu, 10 Apr 2025 18:09:45 +0000
Message-ID: <SA6PR21MB42318E4CEA9E6897220F0736CEB72@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1743813338-28238-1-git-send-email-longli@linuxonhyperv.com>
 <1743813338-28238-7-git-send-email-longli@linuxonhyperv.com>
 <20250406090853.78499346@hermes.local>
In-Reply-To: <20250406090853.78499346@hermes.local>
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
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA1PR21MB4032:EE_
x-ms-office365-filtering-correlation-id: 7cd59203-c2d7-4106-62f1-08dd785adfa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?cjR8nMt46SnMjAdjUu1Tnzg0tYNq99hGOmPELKA4UW3HBeI+NwA/R190O1O7?=
 =?us-ascii?Q?dTRDmMY8ikPEdjdFvF5G/xODco1kumviwXDf+KgERMVXVT8cM19C7RpiKDqO?=
 =?us-ascii?Q?OWVG9tZ7ZXxo5PHypanL+/6rzdlJYIosSWo9w6sgok8UIrmeJZhoc3PL/BKZ?=
 =?us-ascii?Q?LEpp2yfzux+fsPV4h8Ti91+LwOLN8IE/ZSuhCOzSSXpPkPxwb/ViR+URWzgL?=
 =?us-ascii?Q?flwqVH8liCkA7jIz04WBgv8Q8Zfwfn8E8dSB3HwQGnVgqSLftud5GOgsEnIY?=
 =?us-ascii?Q?y+4M1pYXeY/9kyFHw8UGcFWgK7pDnIe6FUhq4LY9w/QJoMRoRxpQdQX5IicV?=
 =?us-ascii?Q?CZT3WMsG9RlOQ3xxx08mtW06fHD5VZ2EYqqqbNQ5lCUgpNKstLaoakQNIOOx?=
 =?us-ascii?Q?PAWoXc7OjWasEL07iB6vXHngIwZr1ek1VyrjKT6SgHiZSIXN+GYbskmM8wgN?=
 =?us-ascii?Q?g5KKHpreXdBaI2DHBKoiTmAMj7pvZY8Zkc44Pd3SwxS2sMHEZ1ENOnaoFloH?=
 =?us-ascii?Q?3Yi3z2/P9RDJOPHapndyt0QDbq/0+vROJSat8JqfKyZTaRGd8CTlrqiJur9S?=
 =?us-ascii?Q?Cw9TKVXjuMr27H/AMa+Nl3O1itrNRttAIRpDeQc0KXAr/rwwNcdRHw+vLXwC?=
 =?us-ascii?Q?z06Pe5msva5gm+EynTbkAfma0wHndKvLbFl/aTqYNJ8tIbrFJ5e/oPnrzGzg?=
 =?us-ascii?Q?8aQzD/piDxC5vD7laNpgZkHBRT7jss6lKnrBWEhOriyXrQf9z5bkbuOrh7fQ?=
 =?us-ascii?Q?ozIOMBn/AukZOB6AanZ0zpgqKXgcYe4NyGZ/Qaf7qv0aZBTQkrWC3IRIeKUW?=
 =?us-ascii?Q?6gf+aEXQkPddPeoBawpFR7vqAw4VSJtY1c0HrJIV5AmgBXK08X/NZH6DIAR0?=
 =?us-ascii?Q?R7fZiO02SPy5jjvjytOgo/Hs0agEvF009ynbvXBdIj/NYiraofeVv7iOYJEc?=
 =?us-ascii?Q?Wc/TqoeEgOJGuO91Bdae2YMMdOmPV5YTKLE58BpqXulBgAefRuytoq3BDr+7?=
 =?us-ascii?Q?70GRjJALRvdj36VtXSJ4oKeFS33RhPMGEF/9x1MUgIasiWZGYVDhsiERos7p?=
 =?us-ascii?Q?INWxF2YiEq2FXwkun+Qr9N//C2csU3D+uBYLsGDzCoai4FgC2b/pY6NKFHZJ?=
 =?us-ascii?Q?sobdRTwGcGIi+rvL7o7+op3VpAQOf17a8H4fkHBdtKAPonxwDdeSGTGwcZnh?=
 =?us-ascii?Q?xeB9x/5NbG2aezt5Q00Omjl1ZrIqSmEHmS7XMr24/b8vKQbXB1NrQcHNyPlu?=
 =?us-ascii?Q?jg97EUc5eJt/DVj+LXmcV0PiJEWeuJqHrfjPUfjlpCABZ2FF1KPFmbLNRzgB?=
 =?us-ascii?Q?BalHZnHYw8X3RkqtFGMFELCyiE0BvILOA+nQ22UVTxFdthVdw8UXp2Aozc40?=
 =?us-ascii?Q?10/cgOXrkrkJcmZoJ0py3KZyzMUV6ij40KIB42fXreMCjPUl4sUiyVeUWIbj?=
 =?us-ascii?Q?hDSEA2aXjfVFEGKfp5rOY5/lnoyeWNtG5AxeP8NoYOpNRRTNef1T9rkB1IMu?=
 =?us-ascii?Q?WnZc0FblqZr/0n4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR21MB4231.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A+2Loa6Afhi/PUnu6+hdurRiVLHG8XrXEUCf+zJx5K+e8PgpHs5xS/fp63DG?=
 =?us-ascii?Q?DSIqjHmr+1Ih+oi2cyjT7MtL/4ln/nMGCE5SEbDvO7rLy42+60OVJwO6KYe3?=
 =?us-ascii?Q?SlUYgVF1dTTnR00kGzuxYa7ltMdiruKmdOMAG+U8DJd3eYCVQxG19KAvjRj5?=
 =?us-ascii?Q?4QqX3dmRBWVuB+J2hC2TDooiony8xeGNbGBRKzHz1WMHN0dawSf1GC07mXvm?=
 =?us-ascii?Q?l2BDGigekNzEbtYS1TccahGQF8C8xnnJ9ilZYNGEG/Iu+ukpVpLSml/NZ+6F?=
 =?us-ascii?Q?zV96lgvRf9e5V3sZTnBvxQZuRIaPb7vP4bwO+tSDgu1hlw6/kdgH20qdvAPo?=
 =?us-ascii?Q?eOlxNms6efHEMd93DokvYHy+PhCqPX4YpAUkINV5RN4hdPX8b7mCnRQ4Qd2q?=
 =?us-ascii?Q?TFJj3CgBPWbipYCQD35dAVhoivPjeXICwda64q1UIvSNCUnb7wik8CAzzifc?=
 =?us-ascii?Q?7DP8gjhv5aSUwRHsS9kPlm6ILDrGFTXlgdfX8CGMgj5YOsFnNHSrhxCSQ+DH?=
 =?us-ascii?Q?MvNb4XsGMO2mcH4pSPZ127KJuzmPTCI+rUMGdJV7ZE+T7WbCJQ7AFAVpFfMx?=
 =?us-ascii?Q?xuTz9G68Et8Hj5eXsfjRMx/S585yWYeIdyyWC+OlCLZn3Ea85hN6LXeUYL8/?=
 =?us-ascii?Q?9nrDM1GLedYHZVEoo18TVgvrREf7k2TvxERCj3EeCOcLq9+sS8NB5Xdi87Gb?=
 =?us-ascii?Q?Q+eJx7d5qSuuAidza15g2wk0457vvcxz8ntkcQbganVBPzfDkJ1sfJ4QGQ82?=
 =?us-ascii?Q?jCKotWxmYvibvAIp3KdPMFsJnIvU64y72GcRF67tawRVsahWtYx/gbp/+1D4?=
 =?us-ascii?Q?b/yrLiNizHJCY66gfEtA21Fo5QF5OlyHR87SLzb4wQ77AK5ew7VGWViGcH7n?=
 =?us-ascii?Q?VjNVVU7lbFvquITPXBdf4MEm/6gdYwGSXDTsmOeUSbYFxsdgvmu0DWA6pzmj?=
 =?us-ascii?Q?E40wGkigU+orNe9l/Gfzj4T1QyzkJPn85R18drY2YK2ivlKDLHqR3Gs4ykU1?=
 =?us-ascii?Q?6lYq4ygCbSQrPC4TgREqyOfL9BqS5VbZQEzsXqlUgvyE6YVeZXCVEEZhbSkI?=
 =?us-ascii?Q?JDfKMrYqn3dazOoNAX/vrhg935pahR4HJ2DvviT/T5tB09v2co7JzBMOC62S?=
 =?us-ascii?Q?BSkNaZHuTmeNlDfBqsTZP4Rwv5D0LomaqYU7pY6od9HwQt6ZLSyGYgJX1qfx?=
 =?us-ascii?Q?TsO+qo/urMuWnD1/SxPUMdTS1sacVXwIp7jEecY6WasSMydbY/U5TH4LiODQ?=
 =?us-ascii?Q?jEcGYohUyFFXg+d8M5WXgxufHeBIMphQ1xazmx5jeXfWbpfHJl3PzANKcs4+?=
 =?us-ascii?Q?aTYntOEPlkXKQYTioxyFJJ9NMCie0HuL5rFiB+0Kjtd3jbeDsMAxf79QTLyx?=
 =?us-ascii?Q?5TovnV0tLz8T8WMR1qFY8yzonfC4HmdQr/Ldv8vdm4AmBGxXhCty21JXpUQ+?=
 =?us-ascii?Q?fk0CIeYaCdZKRaTh3akThS4R95pK5IE6Q63SQYFAJRLg+PqUVxi31Mwk1CTq?=
 =?us-ascii?Q?M2uemMHNCjcxkjbThi2e2Ina6XbEHV/QKGkIudqnv/cNzrDBxogW12ci99CM?=
 =?us-ascii?Q?zkTttg/jEf6f20EM0GIw+jhRBlADgtMaDv4t3Wfd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd59203-c2d7-4106-62f1-08dd785adfa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 18:09:45.0815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WUzZlU/rB2AVbBWg8YLCg8IZln2gr2UeiCzYG0Xo9QbzC60dOCvn1pei7+wQuiC1JXBKZnYh4akF4pg0ZOLJSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB4032
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

> Subject: [EXTERNAL] Re: [Patch v3 6/6] bus/vmbus: set event for channel w=
ithout
> monitoring support
>=20
> On Fri,  4 Apr 2025 17:35:38 -0700
> longli@linuxonhyperv.com wrote:
>=20
> > diff --git a/drivers/bus/vmbus/vmbus_channel.c
> > b/drivers/bus/vmbus/vmbus_channel.c
> > index bccef168d3..81e8096190 100644
> > --- a/drivers/bus/vmbus/vmbus_channel.c
> > +++ b/drivers/bus/vmbus/vmbus_channel.c
> > @@ -24,6 +24,19 @@ vmbus_sync_set_bit(volatile RTE_ATOMIC(uint32_t)
> *addr, uint32_t mask)
> >  	rte_atomic_fetch_or_explicit(addr, mask, rte_memory_order_seq_cst);
> > }
> >
> > +static inline void
> > +vmbus_send_interrupt(const struct rte_vmbus_device *dev, uint32_t
> > +relid) {
> > +	RTE_ATOMIC(uint32_t) *int_addr;
> > +	uint32_t int_mask;
> > +
> > +	int_addr =3D (RTE_ATOMIC(uint32_t)*) (dev->int_page + relid / 32);
> > +	int_mask =3D 1u << (relid % 32);
> > +	vmbus_sync_set_bit(int_addr, int_mask);
> > +
> > +	vmbus_uio_irq_control(dev, 1);
> > +}
> > +
>=20
> This part doesn't look right. RTE_ATOMIC() is just a macro to add the _At=
omic
> attribute.
>=20
> Can it be simplified like this?
>=20
>=20
> static inline void
> vmbus_sync_set_bit(RTE_ATOMIC(uint32_t *) addr, uint32_t mask) {
> 	rte_atomic_fetch_or_explicit(addr, mask, rte_memory_order_seq_cst); }
>=20
> static inline void
> vmbus_send_interrupt(const struct rte_vmbus_device *dev, uint32_t relid) =
{
> 	RTE_ATOMIC(uint32_t *) int_addr;
> 	uint32_t int_mask;
>=20
> 	int_addr =3D dev->int_page + relid / 32;
> 	int_mask =3D 1u << (relid % 32);
> 	vmbus_sync_set_bit(int_addr, int_mask);
>=20
> 	vmbus_uio_irq_control(dev, 1);
> }

Hi Stephen,

I need to go back to this version of the patch, as v5 doesn't compile succe=
ssfully under clang with the following error:

[459/3553] Compiling C object drivers/libtmp_rte_bus_vmbus.a.p/bus_vmbus
ccache gcc -Idrivers/libtmp_rte_bus_vmbus.a.p -Idrivers -I../drivers -Idriv=
ers/bus/vmbus -I../drivers/bus/vmbus -I../drivers/bus/vmbus/linux -Ilib/eal=
/common -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/include=
 -I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include -I=
lib/eal/x86/include -I../lib/eal/x86/include -I../kernel/linux -Ilib/eal -I=
../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metric=
s -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -fdiagnostics-color=
=3Dalways -pipe -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Werro=
r -std=3Dc11 -O2 -g -include rte_config.h -Wvla -Wcast-qual -Wdeprecated -W=
format -Wformat-nonliteral -Wformat-security -Wmissing-declarations -Wmissi=
ng-prototypes -Wnested-externs -Wold-style-definition -Wpointer-arith -Wsig=
n-compare -Wstrict-prototypes -Wundef -Wwrite-strings -Wno-packed-not-align=
ed -Wno-missing-field-initializers -D_GNU_SOURCE -fPIC -march=3Dcorei7 -mrt=
m -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation -Wno=
-address-of-packed-member -DRTE_LOG_DEFAULT_LOGTYPE=3Dbus.vmbus -MD -MQ dri=
vers/libtmp_rte_bus_vmbus.a.p/bus_vmbus_vmbus_channel.c.o -MF drivers/libtm=
p_rte_bus_vmbus.a.p/bus_vmbus_vmbus_channel.c.o.d -o drivers/libtmp_rte_bus=
_vmbus.a.p/bus_vmbus_vmbus_channel.c.o -c ../drivers/bus/vmbus/vmbus_channe=
l.c
../drivers/bus/vmbus/vmbus_channel.c: In function 'vmbus_set_monitor':
../drivers/bus/vmbus/vmbus_channel.c:51:22: error: assignment to 'uint32_t =
*' {aka 'unsigned int *'} from incompatible pointer type '_Atomic uint32_t =
*' {aka '_Atomic unsigned int *'} [-Werror=3Dincompatible-pointer-types]
   51 |         monitor_addr =3D &channel->monitor_page->trigs[trigger_inde=
x].pending;
      |                      ^
cc1: all warnings being treated as errors

I think it's okay to define those pointers as "RTE_ATOMIC(uint32_t) *". The=
 pointers themselves are not atomic, but data in the addresses they point t=
o are atomic.

Do you think it is okay to proceed with this patch?

Thanks,
Long
