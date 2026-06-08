Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F51CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 17:09:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A03B9402DD;
	Mon,  8 Jun 2026 19:09:20 +0200 (CEST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id AE9FF4029D
 for <dev@dpdk.org>; Mon,  8 Jun 2026 19:09:19 +0200 (CEST)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-5176b9c476aso34330651cf.3
 for <dev@dpdk.org>; Mon, 08 Jun 2026 10:09:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780938559; cv=none;
 d=google.com; s=arc-20240605;
 b=eR9EWXTJ9RTHjFnUdWFe/6+XpTmqRGGM3XVywFr/HIXkDSt/q1QQ5fkyA/U02k/ngl
 HONPRaOrIvbQwVFq2Rfhu5qVz6azfhiM9JQy0IDmg0YtOAzN71yQ1idjkiI1prkP/9zT
 dayz26nLeLofEVKKUTsG0OFnnhoXTYGAgFUvKX13g89xt3HgIVyoWkqQRao7WoyJNBgC
 W+PjZdUXO13zyRM5RIq+qhSps2mkPYPxQfqKLZHDduVAsx4AB0YmPv8jtf9oqPr85mEk
 Z7lJTA+QQ7ZojFfB2nqaM5hvMNAHFyTZiS0f8o1s4EQ9hvt6cqZaGshIBIV8zBfmHmqT
 UkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xIWAEd2XNwYLH2z1UqOSpaAuup6KYhBHNgbJUi4A1cU=;
 fh=pM6NOeMZpTkEqGA6Oxt/EuysK2lM9VKfaP3GxyXFNOI=;
 b=DgsB+RrG+d2BZJeNXvqhtDsevyX3LPCxdLcsSNoTeG4bz9mfVNdi0smyTVwYpXlwEr
 OgIgvpruG9P5cYYPgZAeOkmzL1fzJZVfFiKuNIgQ21MwxEZKv0IhKA5dkSj8c4Jy6/rt
 ja4OOwI7phA15rkI8bnOzhbBK8KIYvNp+r47oyXCZX4+qu/F2Ice0SQo2R+4gX4fzJO7
 zZROpsMLEAtmmFr6+/ZDRjJAzlkXTDSvFQfyRiqXvZUPJQcAKGs/m8ChjrUImmU4CzLL
 J1siu2yZD5ez4DsSMBJ4rLewiqs5Jav4b1fMBX4zvPP8VCjD7/00AW8xvsnZVIqu93HQ
 rN2g==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780938559; x=1781543359; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xIWAEd2XNwYLH2z1UqOSpaAuup6KYhBHNgbJUi4A1cU=;
 b=dCnE86tfreYT4J7V8yOiniDqn75XgRD7JNt3Ffz5nZBDsIf1j3suYDfrSWI2DiLqSf
 IWv7KfHMAuTNxClyrynEsvqmFYBLgpk+fotJkIGJaeBvYrGwVgFvlwDK8Si65qgRA7Nz
 WV3QZU/BsDenixXVwCna0bzbMoVmyTnEAw9omoEpY0M5YL45TQwNbtwserLDd265z+Iw
 o1cOKI0UVlx2GCduMKaadd/UYejPNJGi0Bw9jiL4c8Rx6hZjp8bMmXdfXYr1QEiK20mV
 xw0NQ0+jZH+RtFw+KKYcFFNm28hefN2lnXOehT9biO6PHLzc8/U+PhAE5uJYJZK2Ilst
 gHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780938559; x=1781543359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xIWAEd2XNwYLH2z1UqOSpaAuup6KYhBHNgbJUi4A1cU=;
 b=Y6XkD7MPKllZPV2/CgEMu0zwdrNvOUN+puK8ol2rhNuS5DRcdBkO8VQwrAmIZBk3YC
 3YvucUrv3ElQlDURg4krayw2hqsK2kq6YSWRdV6NdTklRX/Kzs863Xrq/EOYJH8ca85S
 n92ggoyvuLgPE5svzRo1UmfU+SJ3f7yzhdIFB45fI0zw81DcfaNoR/X7d6DAJS53re/h
 1XQkwYDxTn2rKxlNZnzluozY64vBJWHCIfVMMDOeRwMEGGks5vVzVanC42UxBcqPVPSN
 9rk9B7DNKIv+hTjJbcKKomdU4atLHbSglXn3TDoEo9uX6/6q0pCX4SW1NQfy5tyiQy3n
 Tijw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9vzmUoapV512+PpkckNyhMf2dEuzvWxUaI0LZIRMmLiU7gg48YpNq7sLKMQJmyTCeS4Q8=@dpdk.org
X-Gm-Message-State: AOJu0YxPz88TO/r3Y9fWPEfuWuRwCrKcSemSDhWNLUI1AD5Nk8XbtWL1
 Xnba/K4DiZ+9ECsbIqTkmQNIyjhOnsrL60Gv2am5xpU5et8HtoKaZWPzKx9B0XcLRpyInarkg7T
 elM0GRHu220+oslpVUAcMPpMLFbC0a+0=
X-Gm-Gg: Acq92OHnT6Iu9BzcU9WpR9m7lQ2XrZW/8+ywq0XkTLqHWcWQcHAo9HpGqliCl7n5yo+
 cC/rTFdi+URF1d7i5W0i+jAvwVZDKvPzLzcnfItm/ouR6dPrsLkcdQ+aDs6DB3RNXmNitQPxs2b
 YBtipq48FmcVeR1otlUB24jP1yXXV0f7N8sY0alx39nq85ajkLiOtAkMJPWfYVl0QKjwtlF/wyr
 ONqqzLSDEudlgWodkr1kPdFyPqKnytA+3yf9AfyZ+RnUOPwb936ayG3r6a2k6kDpv5WLFY3OF93
 8M4gNAeDlJWDfA==
X-Received: by 2002:ac8:6193:0:b0:517:917d:e3e0 with SMTP id
 d75a77b69052e-51795b6de0dmr163318351cf.32.1780938558642; Mon, 08 Jun 2026
 10:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260326132142.565979-2-bruce.richardson@intel.com>
 <DM3PPF7D18F34A115BCA37E02527DC8C08B8E2D2@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF7D18F34A115BCA37E02527DC8C08B8E2D2@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 8 Jun 2026 22:38:51 +0530
X-Gm-Features: AVVi8CfGyAb4akEygajiS2A9mjT8T29rwr9_LwrFV2_D3N3g_EJb0yNpIgu_RUc
Message-ID: <CALBAE1P6GFNqQr-QwLi=PXNj2YCcS+XS0KZ=O8i-bNPUBV_1XA@mail.gmail.com>
Subject: Re: [PATCH] test/event_eth_rx_intr_adapter: support NICs with fewer
 int vectors
To: "Loftus, Ciara" <ciara.loftus@intel.com>
Cc: "Richardson, Bruce" <bruce.richardson@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Apr 22, 2026 at 4:06=E2=80=AFPM Loftus, Ciara <ciara.loftus@intel.c=
om> wrote:
>
> > Subject: [PATCH] test/event_eth_rx_intr_adapter: support NICs with fewe=
r int
> > vectors
> >
> > Some NICs may not be able to support interrupts on all queues that are
> > advertised, which will cause the test to fail if the queues supporting
> > interrupts are fewer than 64. We can work around this by retrying the
> > NIC configuration multiple times with fewer queues in case of failure.
> > This allows the test to pass with NICs using ixgbe driver, for example.
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
>
> LGTM.
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>


Applied to dpdk-next-eventdev/for-main. Thanks

>
> > ---
> >  app/test/test_event_eth_rx_adapter.c | 52 +++++++++++++++++-----------
> >  1 file changed, 32 insertions(+), 20 deletions(-)
> >
> > diff --git a/app/test/test_event_eth_rx_adapter.c
> > b/app/test/test_event_eth_rx_adapter.c
> > index ae428b3333..7b38935bec 100644
> > --- a/app/test/test_event_eth_rx_adapter.c
> > +++ b/app/test/test_event_eth_rx_adapter.c
> > @@ -60,6 +60,7 @@ port_init_common(uint16_t port, const struct
> > rte_eth_conf *port_conf,
> >  {
> >       const uint16_t rx_ring_size =3D 512, tx_ring_size =3D 512;
> >       int retval;
> > +     bool started =3D false;
> >       uint16_t q;
> >       struct rte_eth_dev_info dev_info;
> >
> > @@ -76,32 +77,43 @@ port_init_common(uint16_t port, const struct
> > rte_eth_conf *port_conf,
> >                                       MAX_NUM_RX_QUEUE);
> >       default_params.tx_rings =3D 1;
> >
> > -     /* Configure the Ethernet device. */
> > -     retval =3D rte_eth_dev_configure(port, default_params.rx_rings,
> > +     while (!started) {
> > +             /* Configure the Ethernet device. */
> > +             retval =3D rte_eth_dev_configure(port, default_params.rx_=
rings,
> >                               default_params.tx_rings, port_conf);
> > -     if (retval !=3D 0)
> > -             return retval;
> > -
> > -     for (q =3D 0; q < default_params.rx_rings; q++) {
> > -             retval =3D rte_eth_rx_queue_setup(port, q, rx_ring_size,
> > -                             rte_eth_dev_socket_id(port), NULL, mp);
> > -             if (retval < 0)
> > +             if (retval !=3D 0)
> >                       return retval;
> > -     }
> >
> > -     /* Allocate and set up 1 TX queue per Ethernet port. */
> > -     for (q =3D 0; q < default_params.tx_rings; q++) {
> > -             retval =3D rte_eth_tx_queue_setup(port, q, tx_ring_size,
> > -                             rte_eth_dev_socket_id(port), NULL);
> > -             if (retval < 0)
> > +             for (q =3D 0; q < default_params.rx_rings; q++) {
> > +                     retval =3D rte_eth_rx_queue_setup(port, q, rx_rin=
g_size,
> > +                                     rte_eth_dev_socket_id(port), NULL=
,
> > mp);
> > +                     if (retval < 0)
> > +                             return retval;
> > +             }
> > +
> > +             /* Allocate and set up 1 TX queue per Ethernet port. */
> > +             for (q =3D 0; q < default_params.tx_rings; q++) {
> > +                     retval =3D rte_eth_tx_queue_setup(port, q, tx_rin=
g_size,
> > +                                     rte_eth_dev_socket_id(port), NULL=
);
> > +                     if (retval < 0)
> > +                             return retval;
> > +             }
> > +
> > +             /* Start the Ethernet port. */
> > +             retval =3D rte_eth_dev_start(port);
> > +             if (retval < 0) {
> > +                     /* Some NICs may not support interrupts on all
> > reported queues.
> > +                      * Therefore try to reconfigure and start with fe=
wer
> > queues
> > +                      */
> > +                     if (default_params.rx_rings > 2) {
> > +                             default_params.rx_rings /=3D 2;
> > +                             continue;
> > +                     }
> >                       return retval;
> > +             }
> > +             started =3D true;
> >       }
> >
> > -     /* Start the Ethernet port. */
> > -     retval =3D rte_eth_dev_start(port);
> > -     if (retval < 0)
> > -             return retval;
> > -
> >       /* Display the port MAC address. */
> >       struct rte_ether_addr addr;
> >       retval =3D rte_eth_macaddr_get(port, &addr);
> > --
> > 2.51.0
>
