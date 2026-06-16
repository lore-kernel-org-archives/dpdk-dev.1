Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD094CD98CF
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 09:33:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C8534060C;
	Tue, 16 Jun 2026 11:33:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 91DC94060C
 for <dev@dpdk.org>; Tue, 16 Jun 2026 11:33:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781602410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xR5K7OpCBu5x7k68IgGihIiQ/B50Ccl4ekHzFSuKvRk=;
 b=YOKdlbyzETrVQSsKzu+1CB4n9b4mM4FqtEU+LlbgSAvk0pg00Y6Lg2fcUK8l8XGx0ej7Fi
 Uuk4Bn5hkv7SRLnA+NZWuLfhChX8+zNmpyPmO+W9fMMo83W7rzFk/o9aDFk6tow1+n/e4Z
 FrvLFLYshFDYMQA7d5KO05XG4chnqYI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-Ijc9K34EPgeg3NahTqDIiQ-1; Tue, 16 Jun 2026 05:33:26 -0400
X-MC-Unique: Ijc9K34EPgeg3NahTqDIiQ-1
X-Mimecast-MFC-AGG-ID: Ijc9K34EPgeg3NahTqDIiQ_1781602405
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-396775c26f6so19879581fa.3
 for <dev@dpdk.org>; Tue, 16 Jun 2026 02:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781602405; x=1782207205;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xR5K7OpCBu5x7k68IgGihIiQ/B50Ccl4ekHzFSuKvRk=;
 b=VO2k5JM1OBtsQnXWWDJtJMRFZX8Hw8V8GxrT4TBbeZzvY1ZSyaFTm+0IS4eQh13FBN
 MrNH/Ywhe5IyLcIvHd6tWyxomqQ4aCip9/THcNVRdAWvMyeUMGA2+wwINZ8hJNU4hUSj
 xlmHNH/HXP91YZoaYLw+IJh84q/0VJbG3jD6qQ0v2VDQ2oBF6CtubcfFfj1XOcR9eH5U
 JkAJ2xvra20WNsgilEDNZhxAJIxG/sigl6dThOgJ0wVxKXFbK4lZmE7LygSKK0wsZCI3
 GYNIPsvZ9M6MWJN8tLxIWUlrkTuZQSflRwYEW1k2tf6IGg4bgYCiiA4sVxCecS/gQAki
 +J5g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/oBGXBQqUsIS5otYr9XUMCPQEjmJqqyFqUh9bGFeVwvJDuyz1dt0YTJLyb7dSQnyBh9bY=@dpdk.org
X-Gm-Message-State: AOJu0YygTUj82lNp59/rNMTsffWB0o43aPvLxAEv1EBNzwUn4e1HGp4s
 jQgho9HKQ7s8obS2QWjo/7lB/qi2MFpoYp0NuVUlLtBsT36d1b5umZNjY7T/7LNn3Qf2rO+wH3T
 uKLyQjSdRu4DaJf1gHjzcPs9ft2kaMWSiEIPyK+EyXnVkUHklMPb03Uj49l6q2gBZ6HP6MWfMyd
 1f40ulGfIu7HijW3FHCKA=
X-Gm-Gg: Acq92OFVV3Yrpn0LzZGykfwYDT2t5qHL039TWn4fuMmyW6/q8HCSK5P7FUhJC8hUqk7
 F0xqpgC2M5pUblSu/yIxsNMM0K6N1QnsUoqwRHxM3aGBVx/NV4Sp4Gta42as8+0UMSB7uiyovJD
 LIrQH33d9fW37c2us8zdZ6viynbZX1eCRD8VTTHfDaWf7jCqHQR+gE1xV2mOV89akQbg40jJqwS
 k7BA0LbQdkbZcO2yDlLW/zrcfi33BgT5BJkchUeXDhzx7jWgaf7rE9iQNqRjty0vs0F0A==
X-Received: by 2002:a2e:a681:0:b0:393:d562:d51b with SMTP id
 38308e7fff4ca-3995c7bbde9mr6608471fa.9.1781602405080; 
 Tue, 16 Jun 2026 02:33:25 -0700 (PDT)
X-Received: by 2002:a2e:a681:0:b0:393:d562:d51b with SMTP id
 38308e7fff4ca-3995c7bbde9mr6608341fa.9.1781602404512; Tue, 16 Jun 2026
 02:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260611154926.392670-1-maxime@leroys.fr>
 <20260611154926.392670-9-maxime@leroys.fr>
 <CAJFAV8xTgkgdSzX980qW3zT+gqcDkrQyDV48SMzGh5qSCkz=7Q@mail.gmail.com>
 <CAHHRULXCs5yrQn_rQt_iPY3gBgoEx7K+vvdVOT_4dGk6E9_2NQ@mail.gmail.com>
In-Reply-To: <CAHHRULXCs5yrQn_rQt_iPY3gBgoEx7K+vvdVOT_4dGk6E9_2NQ@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 16 Jun 2026 11:33:11 +0200
X-Gm-Features: AVVi8CelmX9QgKfniz3zjDOlOGmG9DLDtSPPiMadBR5XopjvusRllq13PTCZZhk
Message-ID: <CAJFAV8xzdfmykx2qcCjeywJdCPeEiJ5BE4KPLdWTXZVq44ptBg@mail.gmail.com>
Subject: Re: [PATCH 8/9] ethdev: keep fast-path ops valid after port stop
To: Maxime Leroy <maxime@leroys.fr>
Cc: hemant.agrawal@nxp.com, sachin.saxena@nxp.com, dev@dpdk.org, 
 stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Sunil Kumar Kori <skori@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kqNrAtoa9b9P2gurXA_bMSie5bHj3vfZ0L5Qt7YtIoY_1781602405
X-Mimecast-Originator: redhat.com
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

On Tue, 16 Jun 2026 at 11:23, Maxime Leroy <maxime@leroys.fr> wrote:
> On Mon, Jun 15, 2026 at 11:26=E2=80=AFAM David Marchand
> <david.marchand@redhat.com> wrote:
> >
> > On Thu, 11 Jun 2026 at 17:51, Maxime Leroy <maxime@leroys.fr> wrote:
> > >
> > > eth_dev_fp_ops_reset() restores a port's fast-path ops on stop/releas=
e
> > > via a compound literal, so every field it omits is zeroed to NULL. It
> > > sets only rx_pkt_burst/tx_pkt_burst (and the rxq/txq data), leaving
> > > rx_queue_count, tx_queue_count, rx/tx_descriptor_status, tx_pkt_prepa=
re
> > > and the recycle callbacks NULL.
> > >
> > > In non-debug builds these ops are reached through an unguarded indire=
ct
> > > call (the NULL check exists only under RTE_ETHDEV_DEBUG_RX/TX). So a
> > > thread calling e.g. rte_eth_rx_queue_count() on a port being stopped
> > > dereferences NULL and crashes, while the same race on rte_eth_rx_burs=
t()
> > > is harmless because the burst ops are reset to dummies. A poll-mode
> > > worker re-checking rx_queue_count before arming the Rx interrupt and
> > > sleeping hits exactly this.
> > >
> > > Reset these ops to the same dummies eth_dev_set_dummy_fops() installs=
,
> > > so a stopped port behaves like a freshly allocated one: every fast-pa=
th
> > > op is a safe no-op, none is NULL.
> > >
> > > Fixes: 066f3d9cc21c ("ethdev: remove callback checks from fast path")
> > > Cc: stable@dpdk.org
> > > Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> > > ---
> > >  lib/ethdev/ethdev_private.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.=
c
> > > index 72a0723846..75ea3eedff 100644
> > > --- a/lib/ethdev/ethdev_private.c
> > > +++ b/lib/ethdev/ethdev_private.c
> > > @@ -263,6 +263,13 @@ eth_dev_fp_ops_reset(struct rte_eth_fp_ops *fpo)
> > >         *fpo =3D (struct rte_eth_fp_ops) {
> > >                 .rx_pkt_burst =3D dummy_eth_rx_burst,
> > >                 .tx_pkt_burst =3D dummy_eth_tx_burst,
> > > +               .tx_pkt_prepare =3D rte_eth_tx_pkt_prepare_dummy,
> > > +               .rx_queue_count =3D rte_eth_queue_count_dummy,
> > > +               .tx_queue_count =3D rte_eth_queue_count_dummy,
> > > +               .rx_descriptor_status =3D rte_eth_descriptor_status_d=
ummy,
> > > +               .tx_descriptor_status =3D rte_eth_descriptor_status_d=
ummy,
> > > +               .recycle_tx_mbufs_reuse =3D rte_eth_recycle_tx_mbufs_=
reuse_dummy,
> > > +               .recycle_rx_descriptors_refill =3D rte_eth_recycle_rx=
_descriptors_refill_dummy,
> > >                 .rxq =3D {
> > >                         .data =3D (void **)&dummy_queues_array[port_i=
d],
> > >                         .clbk =3D dummy_data,
> >
> > Could we replace eth_dev_set_dummy_fops() with a call to
> > eth_dev_fp_ops_reset() in rte_eth_dev_allocate?
> > I don't like keeping two separate helpers.
>
> Thanks for the review.
>
> Avoiding the duplication is a good idea, but I could not find a clean
> way to do it: eth_dev_set_dummy_fops() and eth_dev_fp_ops_reset()
> cannot be unified without making things worse.
>
> - They write two different structures. eth_dev_set_dummy_fops() sets
> struct rte_eth_dev (the source ops); rte_eth_dev_allocate() fills
> eth_dev->*, and eth_dev_fp_ops_setup() then copies eth_dev->* into the
> per-port struct rte_eth_fp_ops. eth_dev_fp_ops_reset() writes that
> fast-path table entry directly. So calling fp_ops_reset() from
> rte_eth_dev_allocate() would populate the wrong structure.
>
> - The burst dummies are intentionally different. set_dummy_fops() uses
> the silent rte_eth_pkt_burst_dummy (a freshly allocated,
> not-yet-started port is benign), while fp_ops_reset() uses
> dummy_eth_rx_burst/dummy_eth_tx_burst, which log an error and dump the
> stack because hitting the data path on a stopped port is a misuse
> worth flagging.
>
> - fp_ops_reset() also wires fpo->rxq/txq to the
> dummy_queues_array/dummy_data used by the fast-path table, with no
> equivalent on rte_eth_dev.
>
> The only shared part is the non-burst dummy assignments, but factoring
> those across the two different struct types would require a token
> macro, and I don't have a clean solution for it. So for now I have
> kept the two helpers as they are. Suggestions welcome.

Ok, I had missed the separate structs.

Let's keep it simple, and avoid adding macros.
Can you add a comment that those helpers should be kept in sync?


--=20
David Marchand

