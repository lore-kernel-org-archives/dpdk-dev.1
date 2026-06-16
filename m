Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EDFCD98CF
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 09:23:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE0414060C;
	Tue, 16 Jun 2026 11:23:47 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 55D4540298
 for <dev@dpdk.org>; Tue, 16 Jun 2026 11:23:46 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-91578122305so683451185a.0
 for <dev@dpdk.org>; Tue, 16 Jun 2026 02:23:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781601825; cv=none;
 d=google.com; s=arc-20240605;
 b=fh9/Q9lsEIFn+WwiHSm7kAclqPepsZWLY3DeyKSONuSWHt4urAmT/6QKBSk9EhiFLg
 IXdCz28WK5Da0SoBB7DZDVCnpb0gqvjbXurBuNKk/I8FRXJH42ZuxGhVSFugbTHN7+cM
 6rX14vHHMYUE6bVs/hMuNm/qwEK2JoQtiWmqJPQvDWN/JlI4mOPqfz2AfEvY3LfUWnCx
 i9oNXTqNIr54DuMtFeR4MCYCNdRKg+efbbikOAJPc+sFnUyA4e9MIJ/Ir/8t6fQzsGjX
 hwSmtoU0tUESk3XdTY+i6b5aoB6DrY+Z50VLbLshTTknFwXvj2iTUw/YPAvur8q2PBqN
 shoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=BOP3EUWppGR+dNsNj/qCKQOtErFuv3pCptOsx0OXUfM=;
 fh=cTUF6VomRlH8T8v2G+L2FiDzCgc7BFeb8CDgajFhbBM=;
 b=BLCjyjb2EV+zpysbpErZhWVQpeF7Z+XEvyNgSg1PWIcMnrQlaL6DLsw5gZOnEKUvcf
 D9/m/kNTb2dCyYH2VG//ExfE9Ym/ohgFiU0U2OcMiv20zC71ovNwPQtGORzLBQerB5fO
 fcdcols6jtyihHUM8Al+T6q3WOk9/jdYi5RK5LSNYjVZyEe4vdunczHhZMbpI8eaqWgL
 q4zhrgvjni+KgFZcLRdotZL2sHE5kUOg3HyHodEhU1e4aIXpTHnVAg4TQgh24L2RZkJW
 tgckZI1BizNolMQ2H6HGMe14K7QfL1Smv2YVr60WRMc9xRhMj1YeSciOtGcCtbevEbD2
 c0PQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781601825; x=1782206625;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BOP3EUWppGR+dNsNj/qCKQOtErFuv3pCptOsx0OXUfM=;
 b=mS5fYb/mOr2JqKvrJtVmLRLsvnX2mDfYuRlB44KTnqAWs1UOetUHEbPR8DI5JEJIhc
 pCVNapbnvXAHvfyYBim6oCCZzN6jOk+aOiKn0VV0qRHLjQFImag+E4qvCkU2sY2CL/fh
 A5JyrxbBG+RO3DiLQ1+mMB0onAUifiCte4LGBCv4BKnRclaAwtp1+Ld8OD+7jgq7Rljg
 F9rDXO/FVTEQSYI03bbSdHgGZtY7uW0Bb+TAnQQR7/gojBruoWhxjva1eAlvHEiQheQS
 ojjuMYCd2pSF9QLBjTsAuHhIAyuT0FBxmgkH23a64J4TMNXZrcL0FV7gAjF3wluInFDM
 FR2g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+tF4oVv09VmMmis3ZZdXGh+hsIDuGBZmCwlkgcS3F6G4cSnCDJDUlntCxCMVlh3YRCIi0=@dpdk.org
X-Gm-Message-State: AOJu0YzXO/WeJs4mi9e1f7b4+imx9mSJqFx2K7KLxZT4JrpA3ICTHi1o
 +rHUbtDgOzhv8MbchZbORxicEdSBcr6GxvkLK3twwF9uAdDR5dDpMxjbxNM+jIMAzVN/nmydHBC
 DeHVNn8i0XkexpcEzJ89vtQt49ip+Dl0=
X-Gm-Gg: Acq92OFeENmx5sSlBmKCxiTmYoaqfoH4RHMM9OAqOkTyHw+fMM1DAtMwBaU0mWiLDrC
 ndux6BCmTok59jbmSdKGkD70NghY0kI+E9VCcUTtE+22DCi6fSxAqBEYvrTME/x2iCuzVs+93D7
 fwz4XvMxQTfV2NuTUjxkwlnCNdj8BKSY/5e+BcBuWraHM6yL0dbRV515/upQmzqm/LdGEQFCaRA
 N2kQ0LtsBuzKQCtKMP2o/0aZeO7Sn3DUEG93a/p+QcAyGmCyRo3+AM32xG2day3Q6ckhkj2YUAT
 9UaR
X-Received: by 2002:a05:620a:1724:b0:914:9bed:9443 with SMTP id
 af79cd13be357-917f03a471cmr2201103985a.25.1781601825557; Tue, 16 Jun 2026
 02:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260611154926.392670-1-maxime@leroys.fr>
 <20260611154926.392670-9-maxime@leroys.fr>
 <CAJFAV8xTgkgdSzX980qW3zT+gqcDkrQyDV48SMzGh5qSCkz=7Q@mail.gmail.com>
In-Reply-To: <CAJFAV8xTgkgdSzX980qW3zT+gqcDkrQyDV48SMzGh5qSCkz=7Q@mail.gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Tue, 16 Jun 2026 11:23:34 +0200
X-Gm-Features: AVVi8CcBasR8YvM3dE24jgLsA1zzdk2IRyti-ucMOA_lXig77dM7uMQBr7hWDUw
Message-ID: <CAHHRULXCs5yrQn_rQt_iPY3gBgoEx7K+vvdVOT_4dGk6E9_2NQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] ethdev: keep fast-path ops valid after port stop
To: David Marchand <david.marchand@redhat.com>
Cc: hemant.agrawal@nxp.com, sachin.saxena@nxp.com, dev@dpdk.org, 
 stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Sunil Kumar Kori <skori@marvell.com>
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

On Mon, Jun 15, 2026 at 11:26=E2=80=AFAM David Marchand
<david.marchand@redhat.com> wrote:
>
> On Thu, 11 Jun 2026 at 17:51, Maxime Leroy <maxime@leroys.fr> wrote:
> >
> > eth_dev_fp_ops_reset() restores a port's fast-path ops on stop/release
> > via a compound literal, so every field it omits is zeroed to NULL. It
> > sets only rx_pkt_burst/tx_pkt_burst (and the rxq/txq data), leaving
> > rx_queue_count, tx_queue_count, rx/tx_descriptor_status, tx_pkt_prepare
> > and the recycle callbacks NULL.
> >
> > In non-debug builds these ops are reached through an unguarded indirect
> > call (the NULL check exists only under RTE_ETHDEV_DEBUG_RX/TX). So a
> > thread calling e.g. rte_eth_rx_queue_count() on a port being stopped
> > dereferences NULL and crashes, while the same race on rte_eth_rx_burst(=
)
> > is harmless because the burst ops are reset to dummies. A poll-mode
> > worker re-checking rx_queue_count before arming the Rx interrupt and
> > sleeping hits exactly this.
> >
> > Reset these ops to the same dummies eth_dev_set_dummy_fops() installs,
> > so a stopped port behaves like a freshly allocated one: every fast-path
> > op is a safe no-op, none is NULL.
> >
> > Fixes: 066f3d9cc21c ("ethdev: remove callback checks from fast path")
> > Cc: stable@dpdk.org
> > Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> > ---
> >  lib/ethdev/ethdev_private.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
> > index 72a0723846..75ea3eedff 100644
> > --- a/lib/ethdev/ethdev_private.c
> > +++ b/lib/ethdev/ethdev_private.c
> > @@ -263,6 +263,13 @@ eth_dev_fp_ops_reset(struct rte_eth_fp_ops *fpo)
> >         *fpo =3D (struct rte_eth_fp_ops) {
> >                 .rx_pkt_burst =3D dummy_eth_rx_burst,
> >                 .tx_pkt_burst =3D dummy_eth_tx_burst,
> > +               .tx_pkt_prepare =3D rte_eth_tx_pkt_prepare_dummy,
> > +               .rx_queue_count =3D rte_eth_queue_count_dummy,
> > +               .tx_queue_count =3D rte_eth_queue_count_dummy,
> > +               .rx_descriptor_status =3D rte_eth_descriptor_status_dum=
my,
> > +               .tx_descriptor_status =3D rte_eth_descriptor_status_dum=
my,
> > +               .recycle_tx_mbufs_reuse =3D rte_eth_recycle_tx_mbufs_re=
use_dummy,
> > +               .recycle_rx_descriptors_refill =3D rte_eth_recycle_rx_d=
escriptors_refill_dummy,
> >                 .rxq =3D {
> >                         .data =3D (void **)&dummy_queues_array[port_id]=
,
> >                         .clbk =3D dummy_data,
>
> Could we replace eth_dev_set_dummy_fops() with a call to
> eth_dev_fp_ops_reset() in rte_eth_dev_allocate?
> I don't like keeping two separate helpers.
>
>
> --
> David Marchand
>

Hi David,

Thanks for the review.

Avoiding the duplication is a good idea, but I could not find a clean
way to do it: eth_dev_set_dummy_fops() and eth_dev_fp_ops_reset()
cannot be unified without making things worse.

- They write two different structures. eth_dev_set_dummy_fops() sets
struct rte_eth_dev (the source ops); rte_eth_dev_allocate() fills
eth_dev->*, and eth_dev_fp_ops_setup() then copies eth_dev->* into the
per-port struct rte_eth_fp_ops. eth_dev_fp_ops_reset() writes that
fast-path table entry directly. So calling fp_ops_reset() from
rte_eth_dev_allocate() would populate the wrong structure.

- The burst dummies are intentionally different. set_dummy_fops() uses
the silent rte_eth_pkt_burst_dummy (a freshly allocated,
not-yet-started port is benign), while fp_ops_reset() uses
dummy_eth_rx_burst/dummy_eth_tx_burst, which log an error and dump the
stack because hitting the data path on a stopped port is a misuse
worth flagging.

- fp_ops_reset() also wires fpo->rxq/txq to the
dummy_queues_array/dummy_data used by the fast-path table, with no
equivalent on rte_eth_dev.

The only shared part is the non-burst dummy assignments, but factoring
those across the two different struct types would require a token
macro, and I don't have a clean solution for it. So for now I have
kept the two helpers as they are. Suggestions welcome.

Thanks,
Maxime
