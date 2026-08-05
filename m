Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685F1C55838
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 01:23:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DCA640689;
	Wed,  5 Aug 2026 03:23:52 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11022122.outbound.protection.outlook.com [40.107.209.122])
 by mails.dpdk.org (Postfix) with ESMTP id D0E554003C;
 Wed,  5 Aug 2026 03:23:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySnMuy/m3Vf5nvv5R5/wn+8Uf5IId3ExbxwXGDgCeIL6szeX0qgl8XSW73NGgUXqBx5AxcY6g9DsGSlM40hT6UWYFAXeVJCixAXi+N8CDSuB2o/P4Gp7lWzeoSeK/APS7tVT/2Ns2ueNvvtpnasCM4JHL6qEW8n3nlHIMsPVuQ3dFLdfRIByvms03ehVjgWXkYpHZ7JE2fu5xWrbffzxgABPAmIA/7HqR/CfHmIzloFz5ITlnR7ZylXZow62Di6JBMVeq71I2B0gt3lDTmISOOch33ke2IjNq6+fwOKQ1RtQePhbZXFZS5cWQsMSeV9famVeeZozHC87Q+rFJWipBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DR6r1fRPm009TUapYb4FsTQuRxLIRtmYN/sD5A4Mau8=;
 b=XDz6AGENVQ/WCGz/ZrsdVv+Jhj/AXZXtxnSjrZJI91QS3NxPEgq+MHmtBDPT+JiumcVHm10S/1RvSb39um6TUKS9xfXdtCJ1MHWlDcdQkaxg2KREekWkVegSNy4lnSaGnSmz+7ZgyJLS1Ifr2C/Ozo4vJZyzmZ9Pc564hvU/7JeavIXbovAjQCKy2rKTXO0gr7/FmSuxwzMHBtAB9TjjuPIkw6t/bCSOZH8IsyXXh0jB0KOwYg8UrvdiVRC+kx7/VkMAq5AcplmUYPcFkVtcud1tt9/ioJz2I0IKyTXGWVQt9BCk/fKZd2TTLCOVnKToxdcrzFm5nspNWNnG2YdMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR6r1fRPm009TUapYb4FsTQuRxLIRtmYN/sD5A4Mau8=;
 b=GlJG7oYyMrVbVO2UmZCZx14/xa4MN39Z68gm9As4OR/zfMEKhlgdMRAl7O13lcyaAlMW87cC6brVwl+Gb48Jl+Px+VzrLEWOyQvfCVkgea7cbljUaGIHILFF+vbpUitybtlmV+ykO94ay/EoLRoUCMG1dAAR+XkAnYKTgE3V8aU=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA3PR21MB5816.namprd21.prod.outlook.com (2603:10b6:806:493::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.4; Wed, 5 Aug 2026
 01:23:47 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.001; Wed, 5 Aug 2026
 01:23:47 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Wei Hu <weh@microsoft.com>
Subject: RE: [EXTERNAL] [RFC 04/32] bus/vmbus: fix missing acquire on receive
 ring index
Thread-Topic: [EXTERNAL] [RFC 04/32] bus/vmbus: fix missing acquire on receive
 ring index
Thread-Index: AQHdH4O2QT7EKA5tDk+GKjrHTh685baOsv8A
Date: Wed, 5 Aug 2026 01:23:47 +0000
Message-ID: <SA1PR21MB66834FD0C995B6519017FB34CED32@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260729175715.165120-5-stephen@networkplumber.org>
In-Reply-To: <20260729175715.165120-5-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d4bc3972-f722-492b-a0b2-8256e2b92717;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-05T01:23:25Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA3PR21MB5816:EE_
x-ms-office365-filtering-correlation-id: 04f63c6b-1c01-423d-3b9e-08def29032e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|4143699003|11063799006|56012099006|7146999003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: otbh+R+1wSK2fKKtpNlaMyDGNSHBHsffUG8fY4sX6Dlk2A2BhH144JhHC4fea/H6VS06neS51GsN4BTU2EdFb4K0iLl5OS66/95881JB0MPAPcud+K/8jZ0ZgYyqSHGqabb9SxNbINWiIXXyIBc8YWNvr1ZMhNRUIn84TnkPyVYRTLerdtx+aCtzlgYT6LjRuvRQR5OIkTozitIOQ9AVdG9xsfRx4R4A9VI1h0dPyKM2XoWOhfGNFTR9xlh/h48ArQrKkkXVMgbS54ddYSQ0kwga/1f7u7ecNYOOhJn0ezfNJrlZJIMXUoPOaPwXQYqbbNHFOqVxLt/o/inTqHWCF9qZz0MfX2UNkgHoZVp/qu/H+46TdIMAuyiuFIk8ILe1LrLkSlTOVW/zVxBtX2pP5o8HamwNutqhJuLNHYvEyjSq0By5dOT0V9fCWsnbqNxBAkvNxxgtuIsg+z7dnk4aTUo3w40zSr05plXcwIxbFkJJOWaJ2YcoFXhqmBpcegk7ysU2WkjRXsdBRn5pLC+gRVXCnbPiiRQLgWc+7OtHw7e2EGL8TmGpK6RljfiRLkmlHS67mrmpGf7X05RGq/dNHhMm7KExyALNuNShX+t0GgBbjIIC8D/vkeB8iyGbqr22+MLIeHqHmNVNeUQ+xIlPZ9J2pSutKEgQZmc0A0x9zjp+sZXrGp7pfNnJjjk4t9KhFyEXxxqa4iI5oRv1k9vgQA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(7146999003)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eWGGzSsOH7WDI3zKvK0z8lD8hXH6YZ3U1QkZBjXrWK01oxC9sdWk+WjjbMrj?=
 =?us-ascii?Q?gBKO8cMFbssBMRIHWfzCSmwiI+js0gqHE3SzHA259lOUl3rVnAZaOeXKS1Pn?=
 =?us-ascii?Q?rQsZktVykBtxPtTJc8LQ8WUB5CWnNwQgvMYbno3hjd5pR/rrZI4v7GV6+wK6?=
 =?us-ascii?Q?8mo6RfPOFCWKwLln0Si/KWgARiPsJDxhcMOkhOqM/TaWAS/R3YhPyXCSSL7f?=
 =?us-ascii?Q?SqKe2UXPdzzqG5Xpn1xM/R6qmR3fTrw23WnAsJ7IGTJnl0SZcEGYYllMpRbr?=
 =?us-ascii?Q?euB39fIuLoJo4ubrx/yDVGfGvWhXgeDJ//JjDHl2H1T6YyL6ja/pb8SG1yCw?=
 =?us-ascii?Q?ScWPW0TqKvZ0YmBoHQDVbER/JTD0V7tZ0YIg9KucUt6BLO8u5tl9PWrDdqli?=
 =?us-ascii?Q?Czu4IBTnfv694RvbSfdcKpdj15rAfVqOkdrxDebu9i0xzliEoublZAI9i+lX?=
 =?us-ascii?Q?rvh7KVuymVolr0tA0O894Msoooql9PY6KvzNNtlVT7qR9V2Tnqk3A6Sg8X6M?=
 =?us-ascii?Q?o6p3l3thjNuC7rg49dGmSqCA79KyVP8I9tV8ftIQW3wyZux+isUX+tNYMzE/?=
 =?us-ascii?Q?zXE7bxfprI5E+06gM/OBfXhhhsxS4XV4jxKz9J0+Tzg5WITmnx03j2rzuCkq?=
 =?us-ascii?Q?nKQF7MePY+MMfg5JpcVAvBt880oo0V5fZuNxxt/7Af74Q24A/yQ9JiPfq7AT?=
 =?us-ascii?Q?C3brydXgmZ8BEavPJmDAO//mEPoOgYrmv+i/I4ImTsq52Ts806BwSrDSeiNN?=
 =?us-ascii?Q?fE0KdeuNjQHiF/o6V8Ulqi1P8+9ycXY7Ks8pT8jVFrP3Tvo4cvxai+mKhWdg?=
 =?us-ascii?Q?uRmt7/HKL5ozYuhgQzPEQOs9qu926oIu5ku9dG9hMmrSpbYh1PMnCZJYdv4/?=
 =?us-ascii?Q?qPRPTskm8IBScb/vbltXkmlKIsHBtcrnbnA2i5AnaTPZ7hfH2ZopH7tL97aI?=
 =?us-ascii?Q?EjjJT1FRUFGp2IiTgrFZZGVjgcPpb6SKbwS0pbv3Xx+HsuT/pJjctMywWgkO?=
 =?us-ascii?Q?vHvHIiQQkBPOO0Bnj4HxVbXF1sLqJSODY13r7wxRmkUh9aiL9a2f7b5A4NbN?=
 =?us-ascii?Q?JlcrInb+/JQvwJzj4oi6hBP64mZh9rIbFvLGAgWUm3u5e9Jd2cgaPPq41bon?=
 =?us-ascii?Q?s8E26dHqmpkRKIhgKrm6DXAqSvknImQKa8HviVHYLF7yJTYrJSnkMiZHHWM2?=
 =?us-ascii?Q?L5CDNEMhFxLWSfJhsOWDM155ieUJnZMxwMQu5Y5WmB0ttngDSzEb8To0oIVh?=
 =?us-ascii?Q?hADs0Elmh6yf0doTwP3gnxaeTLHzy7/hoMJkfvTAQi+F6y6oPuxhKrlvB8nE?=
 =?us-ascii?Q?ZC67WF2rTOJCJv+v6Rov/IRMkZ/p6CRZbmkCEDNeyAW+qBvYFGBZVaNDUI2v?=
 =?us-ascii?Q?EDFXmqA0gwtGPX2JZVkfxjgrwbAvt0FBrRQW5nVd5eOGULx9UkTAbm6D6pmR?=
 =?us-ascii?Q?REb7TteKIxKIkPFlnKoouv7NcfhsSUp+Jn89DUDJ95aYx/TFPzlqX7FHto2k?=
 =?us-ascii?Q?vvOiM4O8duTi/Dr7dbZWJMDDuyU+3njc4s8vd9HeyUd6Yh06NyQXMpuUCH5F?=
 =?us-ascii?Q?qyVUW8PXO+LPhvVc4NLmwGgQKCBaExKYJCQIyDkKnjXcNau5+0QZe+ecOHxQ?=
 =?us-ascii?Q?XyHZSEpjKQx4PpTDgznDH9nGv3Rlh4vb3KZyal2senEqUuasZxMbTPdvqPOe?=
 =?us-ascii?Q?/iZaKQz2N9w0/9nflTnfXDmccjbrKvZteg3iKwaKiautHZvb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f63c6b-1c01-423d-3b9e-08def29032e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 01:23:47.5804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfnJJtcYQ/N967xEnZerI9rD3o9xYVoelOP4zZ81h6XjMOTVTF4dcx/jdWeFztvyjuYunAh3Eqbamg5+y2b5yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5816
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

> The receive path checks available data by reading the write index and the=
n
> copies ring data. The link between the two is only the comparison, a cont=
rol
> dependency, which does not order load against load on a weakly ordered
> architecture: packet data can be read before the host has finished writin=
g it.
> Load the write index with acquire, pairing with the host's release store.=
 This is
> the equivalent of virt_rmb() in the Linux hv_pkt_iter code. No change in
> generated code on x86.
>=20
> Fixes: 831dba47bd36 ("bus/vmbus: add Hyper-V virtual bus support")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
>  drivers/bus/vmbus/private.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/bus/vmbus/private.h b/drivers/bus/vmbus/private.h in=
dex
> 6efac86b77..aca5b534f9 100644
> --- a/drivers/bus/vmbus/private.h
> +++ b/drivers/bus/vmbus/private.h
> @@ -12,6 +12,7 @@
>  #include <bus_driver.h>
>  #include <bus_vmbus_driver.h>
>  #include <rte_log.h>
> +#include <rte_stdatomic.h>
>  #include <rte_eal_paging.h>
>  #include <rte_vmbus_reg.h>
>=20
> @@ -130,7 +131,16 @@ vmbus_br_availwrite(const struct vmbus_br *br,
> uint32_t windex)  static inline uint32_t  vmbus_br_availread(const struct
> vmbus_br *br)  {
> -	return br->dsize - vmbus_br_availwrite(br, br->vbr->windex);
> +	uint32_t windex;
> +
> +	/* Pairs with the host's release store of the write index;
> +	 * ring data must not be read before the index.
> +	 */
> +	windex =3D rte_atomic_load_explicit(
> +		(volatile uint32_t __rte_atomic *)&br->vbr->windex,
> +		rte_memory_order_acquire);
> +
> +	return br->dsize - vmbus_br_availwrite(br, windex);
>  }
>=20
>  int vmbus_txbr_write(struct vmbus_br *tbr, const struct iovec iov[], int=
 iovlen,
> --
> 2.53.0

