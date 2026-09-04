Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C73C79F82
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 20:25:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A39F427E6;
	Fri,  4 Sep 2026 22:25:32 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id 2A832427D1
 for <dev@dpdk.org>; Fri,  4 Sep 2026 22:25:31 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-936dfd009d1so281858385a.1
 for <dev@dpdk.org>; Fri, 04 Sep 2026 13:25:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788553530; cv=none;
 d=google.com; s=arc-20260327;
 b=D8DwGKhiXRB4NU7bfMQfcb0u3HeVBYZywBuS1H9uzxZc2fkZ770t9q4Gs4Ulc4xvgH
 p97E0s3viHWyMu6s+egEOcGiCD8sx9yfvhSspwb1uhcWRSX3lR0LRg6SXZ+xZy11Kz58
 lB/s69ZckruhQboGDUYs5g7OVg3WP1SV8lF1zS8AcB/B57/EjxKfVjqORqL2/jCjWyeq
 v/5tINVR2ZKCF8NZE48R09PmM6pNOAMIjxw9qB5xV7uZGgPd2Gb/qkgsoW/efn7pacP+
 RupCvYIGAOsYD7etojXofULJVRosLtEkfJtz94TNwmOer7yLmpohsHmUU5h7cA2WIs0N
 uRpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=MM8V0kXXmFgH22dHrL4vqAqs05YaX0YXcIGvFZ+/lYY=;
 fh=2/mVVrv9UWQ545ODtwg1dwXKPORY8CW0WT7GiFJVLDU=;
 b=k9M70SN5yvRJQUgtlBbRv0K1+AsBNDPq0+WXrm2UdSmNcMrCf6sqAVQSRL3h5ey6e2
 Rl5OHDzRqUgyFQUvy1ywZ4w5XG/7hhbRJZE918QlHmP2qJYt8fR+Zw0x0Basn3ZsHGjk
 ZdDiwP7ZsfmFgLmM7+6Nqez/ndE7ed1SQqb1XhdTYA2wF0UKAFK9G2zY0X009io3QZma
 Jn4D4oaWcSfeSBshT6P5VJ5DTaKYOrGnkGzYIwFvHzuQkb+r3DDHTYhz1JUSBwCxuwZp
 agA49viG6mqgY+bSA5jrzpEhxwJHSiaTFbfAXJ1o0dLPYZPf6W164G6LPl3YKV0rOlUZ
 RLcg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788553530; x=1789158330;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MM8V0kXXmFgH22dHrL4vqAqs05YaX0YXcIGvFZ+/lYY=;
 b=P4pbPTa+d2A5g0sGcQ3dsi0P3okpIlRm2jyyO6q9FV3g71TXcBrykzY02NCAY1EwLF
 mSvYP62r6ByMhU/dmpHhsQJnYGkgw8Q7PkEwFeat0rDjdr6NI3ud1tkhpTUN5ATpT5rp
 CpLbdM6z87czwz71hVtIJrH9amnOQ415vt/Z1D/IZwSAmvjhSdwtf5pTpAL0k8d7nUSC
 dM5yWB4Hn9rEj/SAhHxum0xYm39Pv0eV2l2rsGDYOMT1azzf+TTeibkf+Sn9uOknt1sp
 dKzaeSK/ZIcnVjvRwGgR7qqlvlJU6FU9oJIILf7CtaXu+BgLtbJucfBZBqWHLVajhJpE
 I2Kw==
X-Gm-Message-State: AFuF++loUPMpa8f6mKd7BBRZgX9wS7elEWSoZCfWT/kjdUhko4zv+jbJ
 haJjP/MBvGaloRuEhNmX3hrPCahUtRQeWQwl9G6Yt2SMV2szagCky6jge9Z6jApgyCVxkRvoZzh
 V/xaVmnuwVRpTHy2gVo7B3ID1U5FWQGE=
X-Gm-Gg: AYBFou35tgU8vmBKRj8R7hErLv59l9yj2CKcBE/dkzZCjJwNHKRdt2Sw08tH1hO4/gb
 jH7oszyK7X0byF/Lxpoiq/2zv01SV8A24EgeUlbhFvBtoZxrqW3R5RRZnRUaHX969dLOHShJo/8
 3NURia7Ak8M74mE2ArNFYoRYUyqu1CTzP+rEonK4cHJ2A5tqENERFyGJJXM2EuXqjomAV6ig2YF
 wo0h6OlhcgoByfvRwNTR8ToVNKXBnk+jKgz/86hgExXITKzp7X8ReDJl+bwvybwisg6M7frN3KR
 Wddmnho4t0PWrluCZAyUBvEJ2er092FzyA2R0ja8YAPbRxvdztkhVqEpmGiO4vTyNvEVyH4WVI5
 4FelDoRCQUubjAM4Yyi7Bj4TiEtuH1oWibA==
X-Received: by 2002:a05:620a:1999:b0:92e:e467:7f93 with SMTP id
 af79cd13be357-939815c0d17mr546050685a.14.1788553530293; Fri, 04 Sep 2026
 13:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260720080035.673782-1-maxime@leroys.fr>
 <20260720080035.673782-6-maxime@leroys.fr>
 <CAJFAV8yvvtysXvHcZm3+BC3Rvhn3+8QHyWAkA9j6mxGrpZ+0JA@mail.gmail.com>
In-Reply-To: <CAJFAV8yvvtysXvHcZm3+BC3Rvhn3+8QHyWAkA9j6mxGrpZ+0JA@mail.gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Fri, 4 Sep 2026 22:25:18 +0200
X-Gm-Features: AcwNN1WljMFEW2xf62SpypQGV7d8ZvWhQcC0kVQmojSKVthogPsjFv3EjbI13NQ
Message-ID: <CAHHRULXhG307rzW-UacTkru7G7k4W798BX63-wzjoZ6CBM2yKA@mail.gmail.com>
Subject: Re: [PATCH 5/6] examples/l3fwd-power: recheck Rx queues before
 sleeping
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, anatoly.burakov@intel.com, sivaprasad.tummala@amd.com
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

Hi David,

On Fri, Sep 4, 2026 at 11:20=E2=80=AFAM David Marchand
<david.marchand@redhat.com> wrote:
>
> On Mon, 20 Jul 2026 at 10:01, Maxime Leroy <maxime@leroys.fr> wrote:
> >
> > After arming the Rx interrupts rx_interrupt_wait() sleeps in
> > rte_epoll_wait(). A packet that arrived between the last poll and the a=
rm
> > can be missed on PMDs whose interrupt is edge-triggered on an empty to
> > non-empty transition, such as dpaa2: arming a queue that is already
> > non-empty raises no notification, so the lcore sleeps until the next
> > packet.
> >
> > Before sleeping, check whether any queue already holds traffic and, if
> > so, skip the wait and go back to polling. NICs with level-triggered
> > interrupts are unaffected: a pending packet keeps the interrupt asserte=
d,
> > so rte_epoll_wait() would return immediately anyway.
> >
> > Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> > ---
> >  examples/l3fwd-power/main.c | 27 ++++++++++++++++++++++++++-
> >  1 file changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
> > index fa64e28e5c..c423b0dba5 100644
> > --- a/examples/l3fwd-power/main.c
> > +++ b/examples/l3fwd-power/main.c
> > @@ -949,6 +949,26 @@ static int event_register(struct lcore_conf *qconf=
)
> >         return 0;
> >  }
> >
> > +static bool
> > +rx_queue_pending(struct lcore_conf *qconf)
> > +{
> > +       struct lcore_rx_queue *rx_queue;
> > +       uint16_t queue_id;
> > +       uint16_t port_id;
> > +       int i;
> > +
> > +       for (i =3D 0; i < qconf->n_rx_queue; ++i) {
> > +               rx_queue =3D &(qconf->rx_queue_list[i]);
> > +               port_id =3D rx_queue->port_id;
> > +               queue_id =3D rx_queue->queue_id;
> > +
> > +               if (rte_eth_rx_queue_count(port_id, queue_id) > 0)
> > +                       return true;
> > +       }
> > +
> > +       return false;
> > +}
> > +
> >  static int
> >  rx_interrupt_wait(struct lcore_conf *qconf, int *intr_registered)
> >  {
> > @@ -968,7 +988,12 @@ rx_interrupt_wait(struct lcore_conf *qconf, int *i=
ntr_registered)
> >                 *intr_registered =3D 1;
> >         }
> >
> > -       sleep_until_rx_interrupt(qconf->n_rx_queue, rte_lcore_id());
> > +       /*
> > +        * A packet that arrived during the arm window raises no new wa=
keup on
> > +        * edge-triggered PMDs, so skip the sleep if a queue already ha=
s traffic.
> > +        */
> > +       if (!rx_queue_pending(qconf))
> > +               sleep_until_rx_interrupt(qconf->n_rx_queue, rte_lcore_i=
d());
> >         rx_intr_disable_all(qconf);
> >         return 0;
> >  }
>
> I don't see how this solves the race.
> There is stil a window between checking the queue count and sleeping.

The check runs after the arm, not before:

        rx_intr_enable_all(qconf);              /* arm */
        if (!rx_queue_pending(qconf))           /* check */
                sleep_until_rx_interrupt();     /* sleep */

A packet arriving in the window you point at arrives with the interrupt
armed: the event is raised and latched in the event fd, so rte_epoll_wait()
returns immediately. Only a packet that arrived before the arm can be lost,
and that is what the check catches.

>
> Looks like a bug that should be solved in the driver.

This is not a dpaa2 workaround. The loop currently sleeps with a 10 ms
timeout, so a missed wakeup costs one poll round; patch 6/6 makes the wait
blocking, and from then on it is a permanent stall. This patch is what make=
s
that safe.

rte_ethdev.h does not define whether rx_queue_intr_enable() must raise when
the queue is already non-empty, and PMDs differ: mlx5 arms the CQ for the
next completion (mlx5_arm_cq(), the model whose documentation tells you to
re-poll after arming), ice sets GLINT_DYN_CTL_CLEARPBA_M while re-enabling,
and virtio just clears VRING_AVAIL_F_NO_INTERRUPT so the backend notifies
only on the next used buffer. I have only tested dpaa2, so correct me on th=
e
first two if the hardware does re-raise.

Fixing this in drivers means defining that contract in the API first and
auditing every PMD that implements rx_queue_intr_enable.

>
>
> --
> David Marchand
>

--
Maxime Leroy
