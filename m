Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC6C606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 11:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=VVBkCKhM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83A2940294;
	Mon,  9 Nov 2026 12:25:25 +0100 (CET)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11022136.outbound.protection.outlook.com [40.107.75.136])
 by mails.dpdk.org (Postfix) with ESMTPS id 57D714026E
 for <dev@dpdk.org>; Mon,  9 Nov 2026 12:25:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8/ldRl+P3ZVSVYdKlaCrlKtFlvHxjXdD208Hcw7OWBYEs5S2Dl1sWLxVTUkQDL+HSH+noiVAv43SSMY8vhTtsT+2BdNTBRHonNdO323wPVEth7m1Y4FSYhTUVAIY2hsdFxlYI25Ppj4VXOr2cayA2koN7GUM76ORSanH56r84lZf4gE37C2XPqZ8o+GkKjX7u8Q9LpBHSr3G7f+2vXgDZpO8TwsCBgU/lL9xBn+tmwR8L/JH87k9hU69ISftvjL6Ge3ugvsDfLu90m9rEoOZZ88Tjyo/I+vYrYeQgS4XVVQL/renuOvqQbomthOrUBHnCcskrAopRdqDsYLQzuGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:MIME-Version; 
 bh=AukmMMJJsqy/D5WoLNYUFLl3zxmCopT8epwkiV74Zqc=;
 b=dFbo5IJJC6w2XoT1kXnk0tvatDk3XC/kVZqyFWseFRzendTz9bYPmT05rbmLl4KHwALfcweM0wZwFU9ua/Xp94FeuBNnmboxnpnY5YN9Cn1ytxVZttGbnpgQ2Q0Fdn42LU4YkSHIgch8Wruzmoo6I5kqH/VrzLb/7s0TDSCYbAtycWTm7n6gk7m6Ow6O5F6S503GTiyS+zBeMgnFL0s8QaoIhYKY0N+9H55XYD3vnIQFqYlhuON3PTDDuoAF0D7cyGMxoUyLjWPfjKgEctGbkJIOCV2EVxhB8F9GtAaV9lrSyoL2vin+cK69YigW9IbUpXFwEia3nVzxYe3li09Fuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AukmMMJJsqy/D5WoLNYUFLl3zxmCopT8epwkiV74Zqc=;
 b=VVBkCKhMH7AKrg1O9yf8YY7mPKjA5XvPdNZRMGJQxw43QYs6pOY3qexikX1/RmSup7+GLopCM+c0DFkZc2jA6FjXAdvsBnOndypfSKyvZI6wd3yeXAO2SuZOQPLhjSudons49jOiEi0wHngamOvaEwI28gnP10ewKvirkPJmBW8=
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM (2603:1096:101:340::5)
 by KUYP153MB1253.APCP153.PROD.OUTLOOK.COM with HTTP via P2P; Mon, 9 Nov 2026
 11:25:15 +0000
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e]) by SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e%6]) with mapi id 15.21.0639.000; Mon, 9 Nov 2026
 11:25:14 +0000
From: Wei Hu <weh@microsoft.com>
To: Orgad Shaneh <orgads@gmail.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Long Li <longli@kernel.org>, Stephen Hemminger
 <stephen@networkplumber.org>, Aditya Garg <gargaditya@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH 2/2] net/mana: fix Rx interrupt enable failing
 on lock contention
Thread-Topic: [EXTERNAL] [PATCH 2/2] net/mana: fix Rx interrupt enable failing
 on lock contention
Thread-Index: AQHdapjxe3YlKxbbeUyDnNYux+JxHLcloOYw
Date: Mon, 9 Nov 2026 11:25:14 +0000
Message-ID: <SE3P153MB18482F1674C5450AC402E0C5BB732@SE3P153MB1848.APCP153.PROD.OUTLOOK.COM>
References: <20261102070809.813033-1-orgads@gmail.com>
 <20261102070809.813033-2-orgads@gmail.com>
In-Reply-To: <20261102070809.813033-2-orgads@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cb6a020b-174b-4504-9ccc-f2f9fa6acad8;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-11-09T11:11:20Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-traffictypediagnostic: SE3P153MB1848:EE_|KUYP153MB1253:EE_
x-ms-publictraffictype: Email
client-request-id: 58c16075-f2df-4862-8536-03427eea8895
request-id: 80363363-26a4-4ecb-b6b2-08df3e542003
x-ms-office365-filtering-correlation-id: 80363363-26a4-4ecb-b6b2-08df3e542003
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|42112799006|38070700021|261009223027099003|4143699003|11063799006|261021121427099003|261021123027099003|261022105027099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261102123227099003|7146999003|10067099003|7053199004|22082099003|18002099003;
x-microsoft-antispam-message-info: vtWmxcO5YGv9GnglPDbzAEOU09o3KC9EiSZcmnC3Hpb+N4I7tIlbPjc7Bnrw4cMoIsqYTDzar4IziVUHa0QrFX8rELXO8hH556bQX6YveH+GShj5uL1CLWmzmdu9LAE85KAhj8QmQla3Ei/2VZwYxtbuwYnsbjkvm8UEG57u+x9nCXRans0AiMW/V/KRJ4NObSFbwu5xvMOSqDhvi5R1Dv0geKjcFEFC8OY5sNq5wcURGIqk6VYI7JtFQll1BH475BDcR7pBOFjKRKHBbyVczXDr/Z74pOkuQDUP1MeYXEXg8QagwIaBizWl5uknkJxtW8rKDENOVyB9z8Bl7FiAFLvvlbKU+7siWIp9pKWvKoG4Nck5ictbV6P+l3VHOLnzarldTQjLj3uwAQAvM1/QHBBtWehSPc/fISYQYwQooopI7qtdP7NpzUcdZnXIwZdrYkJochd9+8RtJdP7m13QFw42j45tBnY572APf8r7+83OUpMVsOodJusc5jEPltGIFgrAi8t/KfJ6l0N5Po6R3pAzE5CQeMxUQBAECOqDgtiHeNHVZYJCGnB6UeqJrvz8QDetCKKvCs3GHz/HL5JI9BOsHnHfGVXtgEpbs7GahQWi7xgvqSR9F/pmtgddxLGjpcKDff+VHCobLvzXHrZ/AENDt8RFICIkXHbgPcO+s7wIQ1Ng9+mlprXa1+eD0ScG5xglGZkte/gXZR39Pk3a3jewDLLTXnpKXczeAF/fK6o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(42112799006)(38070700021)(261009223027099003)(4143699003)(11063799006)(261021121427099003)(261021123027099003)(261022105027099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(7146999003)(10067099003)(7053199004)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8Wq6OJHJk+wmgFqmP/SW5bnNNEvmGPIAKYl5DcLeyzXn8OgctYktRiMCt0rW?=
 =?us-ascii?Q?tqutxgvfi9L/BvbVhscjXxYVVf6n2eM9agkMfsGHR6iikJQukh/sicYNmPt+?=
 =?us-ascii?Q?ik4F8qpjFBRt+tYtLRX9nJmeYDfkYbL8E6YQT1cIQD/NAdi442hLY9jiGxFb?=
 =?us-ascii?Q?WtFuv/UnKeNiLd35xOHFRDRtuZ6CrTpU4kLHKpsJpGYdht6i4M5gYuz7MOcV?=
 =?us-ascii?Q?XoO9qWm53lWtn5CIE6gCVS1toybHHM/LkUN0nd9sH0Fuwymzcra43hE36nMY?=
 =?us-ascii?Q?oh3wMn8oq8JnHFF4URQy+lk7/tmJHL1v2XbNbW71yg/5MnFgvWguqEzO8/ZC?=
 =?us-ascii?Q?jsZ2efVqlYlDJuO6NxmL9UPbJ0ylRL/OhTfRFXQaqWbFy0PF3mZ6clkkY3aw?=
 =?us-ascii?Q?RoUTo+XJ4X4UaCIt1ZpC8hSLBpi3LmlAH38hdVcscdQ6dci5vEGLm/ORtVOn?=
 =?us-ascii?Q?6wPNWjiUYFK3LvkX62cR8s9ag8rcBgmncYVzV2WZvRB+jqW5SKKjYYARIthN?=
 =?us-ascii?Q?SnzQUPNQBX26mmyAH5oJKgTElKUkXRHK/nBpfDT56+O4N7R4KMxODuuUgGWM?=
 =?us-ascii?Q?k+y1nVQBjN35dlLCT7DZ+2YmbDWcicdQdpAR2b3UDrPcm7YUOPo5v96wi6bL?=
 =?us-ascii?Q?C5veshF06jNnpcl8ecbY1Ix2TnzeZ5VVAbU7IVSR7XrThyiXnZ/H+cSSmwCq?=
 =?us-ascii?Q?arBtMKJwgdlOAJHH80xUSfxPu5mpOHjtZMe2sTrwZwIidGYQenVXAEa6j39Y?=
 =?us-ascii?Q?OPRifithnBA3W7/aY6S9BS8ucWb0RkoPP/ylMlE3f8kQzeJS/tBSwd2pePLl?=
 =?us-ascii?Q?y1IGQ9PXxUrK6jVEzuqFHEMlu+x6fLQLsP5oRyYTnbx2qy0gSy109uXhGNiw?=
 =?us-ascii?Q?Bs7VAD0LG/1xrlxxj5fGZm8Q16SPUmfsUK1xKKBxpQ0AKXKTlXpeJ+FXQq0B?=
 =?us-ascii?Q?T+2vIdDvHR4fSWmAwrjhgVGTmDU/cXH+xin/SggJnReLRTaNCx61PiRR71Gv?=
 =?us-ascii?Q?xS8WDIE0a+7+MPYhPNZrxqduF1T77xgFVzLhZpWJSfqhWmXsJcOti0mehSXk?=
 =?us-ascii?Q?hIT9Kp5Tu9A/AWwxNOsnZhy8eP97DHMNEaOr7Lq6msgWcP8OWyFUF5C7qre4?=
 =?us-ascii?Q?crg//1bXDRecNFc0ZrnVy5vhd7fa86loBGxDL+R9ZihE3wXElztx4uGdSou5?=
 =?us-ascii?Q?ji/zDWNNr9XcXW2gcsbnUdiSIahcsH2f92vMXlfRauxjvvzqY9YnjnjbqL/0?=
 =?us-ascii?Q?cN6jzKY/rKXKj9GWXTl0B5vRccZB6IYUqxG1/H9sGQyDU6OOAWPO+t61y4TF?=
 =?us-ascii?Q?QOznxDOmRbxdsDi81NIPAXus/ewRuP4PQc+YGgt4bOXXVXaIVzBw/8nHztn1?=
 =?us-ascii?Q?XTtQStG2SggYzxlDGwPKcy1xpWXfIQrmhWUzUfKb6MfMqZwEWkOLmDjKIjXF?=
 =?us-ascii?Q?z5vPUk/ZCuYK8uKEDYItVKtjfEs2VFM4G/U/R/wpkPzX8VFIpiopVpOjMgKA?=
 =?us-ascii?Q?aqjhwlFp0fLfZLXP5TcfPVzHIwVJgOFDzxvmzXtRv+bZPxPhUtccQYexTYlQ?=
 =?us-ascii?Q?aOz8M/8ju4GXRhwl81iJvRJieG37z/xVxdbWprfY8rKOaQ17s9sfektbad0E?=
 =?us-ascii?Q?zX8SKogyG30F00cFkzJeJR5HxZTcYz3AvDaZZqTY+ICRvtye1yxPWxqEHtFi?=
 =?us-ascii?Q?dKlRuwoGLhIAiAHYZy21q0svLRzTcLd1/FrpfNBU4TennQpe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 80363363-26a4-4ecb-b6b2-08df3e542003
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 11:25:14.4644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vfr8zw9YjGzdKi+dfvtTOMB6HaDDpSLIdlFyP8XHhMq5BgGw/jpMVg/tyaFCxTsyRD9Uj2aDAygDPqATRFGmvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYP153MB1253
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

+ Aditya
- stable@dpdk.org

Hi Orgad,

> -----Original Message-----
> From: Orgad Shaneh <orgads@gmail.com>
> Sent: Monday, November 2, 2026 3:08 PM
> To: dev@dpdk.org
> Cc: Wei Hu <weh@microsoft.com>; Long Li <longli@kernel.org>; Stephen
> Hemminger <stephen@networkplumber.org>; stable@dpdk.org
> Subject: [EXTERNAL] [PATCH 2/2] net/mana: fix Rx interrupt enable failing=
 on
> lock contention
>=20
> [You don't often get email from orgads@gmail.com. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> Rx interrupt enable and disable take the per-device reset_ops_lock with a
> trylock and return -EBUSY when it is held. Every Rx queue takes that lock=
 on
> each enable and disable, so with two or more queues on different lcores t=
he
> calls collide routinely. A failed enable leaves the CQ unarmed, and a thr=
ead that
> then sleeps in
> rte_epoll_wait() is not woken by the next packet; it sleeps until its tim=
eout
> with packets in the ring. A failed disable leaves the event unconsumed.
> Applications do not expect -EBUSY from these calls outside a reset, and l=
3fwd-
> power ignores the return value.
>=20
> Seen on Azure (MANA VF) with 2 queues and a 10 ms epoll timeout:
> about 550 lost wakeups per queue in one run, p99 latency 9.9 ms, and 22.7=
%
> packet loss at the higher rate tested. With one queue there was no loss.
>=20
> The section under the lock is a doorbell write or a non-blocking read of =
the
> completion channel, so wait for the lock instead.
> The device state check is kept, so the calls still return -EBUSY while a =
reset is in
> progress; a caller that arrives while the reset thread holds the lock wai=
ts for
> that step to finish first.
>=20
> Fixes: 077ca514d641 ("net/mana: support device reset")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---
> Builds on main (meson -Dwerror=3Dtrue, gcc 14, rdma-core 56).
> Tested on Azure D2s_v6 (MANA VF, Debian 13, kernel 7.2.11), main + 1/2
> with and without this patch, 2 Rx queues, 10 ms epoll timeout, no retry i=
n the
> application, one 12 s run per rate:
>=20
>   pps each way   without: loss / p99 / lost wakeups / -EBUSY   with
>   25k            0 %     /  8.3 ms /  300 /   913             0 % / 78 us=
 / 0 / 0
>   100k           0.047 % /  9.9 ms / 2232 /  7733             0 % / 88 us=
 / 0 / 0
>   200k           22.8 %  / 10.0 ms / 2472 / 10093             0 % / 87 us=
 / 0 / 0
>=20
> With the patch, 400k pps on 2 queues and 100k on 1 queue are also clean.
>=20
> An alternative that never blocks is to guard these two calls with the per=
-queue
> burst_state gate instead of the device mutex (the reset path already bloc=
ks
> and drains it before teardown). It is a larger change, and the dev_state =
check
> would still be needed after a failed reset, which clears burst_state. Hap=
py to
> switch if you prefer it.
>=20
>  drivers/net/mana/mana.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c index
> 0ea6d9a54a..a25c7590ef 100644
> --- a/drivers/net/mana/mana.c
> +++ b/drivers/net/mana/mana.c
> @@ -449,6 +449,24 @@ mana_reset_trylock(struct mana_priv *priv)
>         return 0;
>  }
>=20
> +/*
> + * Like mana_reset_trylock(), but wait for the lock. Used by Rx
> +interrupt
> + * enable/disable, which every queue calls on each sleep and wakeup:
> +they
> + * must not fail just because another queue holds the lock for a moment.
> + */
> +static int
> +mana_reset_lock(struct mana_priv *priv) {
> +       pthread_mutex_lock(&priv->reset_ops_lock);
> +
> +       if (rte_atomic_load_explicit(&priv->dev_state,
> +           rte_memory_order_acquire) !=3D MANA_DEV_ACTIVE) {
> +               pthread_mutex_unlock(&priv->reset_ops_lock);
> +               return -EBUSY;
> +       }
> +       return 0;
> +}
> +

App threads could get stuck as long as 15 seconds waiting for the lock when=
=20
the device is in reset. Is it better to add following?

static int
mana_reset_lock(struct mana_priv *priv)
{
+        if (rte_atomic_load_explicit(&priv->dev_state,
+                       rte_memory_order_relaxed) !=3D MANA_DEV_ACTIVE)
+                return -EBUSY;

        pthread_mutex_lock(&priv->reset_ops_lock);

        if (rte_atomic_load_explicit(&priv->dev_state,
                        rte_memory_order_acquire) !=3D MANA_DEV_ACTIVE) {
                pthread_mutex_unlock(&priv->reset_ops_lock);
                return -EBUSY;
        }
        return 0;
}

Thanks,
Wei
