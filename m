Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A887FC79F82
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 21:11:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F73E40E20;
	Fri,  4 Sep 2026 23:11:04 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id 9ED35427E6
 for <dev@dpdk.org>; Fri,  4 Sep 2026 23:11:03 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-9390a2c8909so110932985a.0
 for <dev@dpdk.org>; Fri, 04 Sep 2026 14:11:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788556263; cv=none;
 d=google.com; s=arc-20260327;
 b=exHQvwFk2rmFxL36UttuiAZrTQdAVLGUyRaO/BTN5sYMDhx9mui9hso5QThObogvMs
 c7kFgX8HBX54O4SwR8+ppCzCdLOuNSbUeV+Aoh2YX11494N/YRT6f1dcn4JiXC2Y6fJ+
 mbQvZjaXMJK8SxKkx7Fz1mfxZTY71e9uB2lwNdqb8nYYSlAyJMJ6fqLp1Ajz14EOmcgI
 dg8iLT0XgsOFOMhU/1zWLM4Ow9vQWzN3AfGmpeLm/YLnjfUw/jhgWvJRR6bJ9TJ5xx9U
 MxnTLxD7ToH1Ui2MMf5lhMUHvRleoxtLjtnkmNJpwev0jwVz3C1A5pfEKNVbm9Jy96en
 U+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=wosGPaFt2zJh2V9ujcxp3W622nF7OXW4ilLZtFgCccE=;
 fh=BuZmWSZeR8C6Et/viMfsaL8ypq55scjtiMUenJeX5Wc=;
 b=i7nTTahBQBuh9t6xRystrXJu57xJiz220cuAbDf5gO0glCF+8LexxcskdZ3Z+Fi1M1
 sD+Wa67jztdcVIVa6B8qQl9qPqEAuKLQmuQ3PIVnPz9pRwMvB2Plq3uFAVfM7bgLDgS2
 iElSCxmopFv46jBLiEVJvJBzP3wG6/pxRiH0PYzwl5IYWwLQ+9EGQ3D96wKknYioOszm
 82PWp5BbF4XudlGITPH/z1Ca9O8OnLxbefklUYB/8I3YAI3GrrMuJ00oXV2yrocbiESO
 hMnAWTw7aLDCHKgXR8y0Lcko5jpTRS8Dbjdxgng00A0EVlKmYfqMlHBK+RzF3VT3GqQc
 yPHQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788556263; x=1789161063;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wosGPaFt2zJh2V9ujcxp3W622nF7OXW4ilLZtFgCccE=;
 b=YsKKRL3lntFYrKnsXHk3MMkMGwi1kYHvHLkmO49x+6GdCki6CBNd0qJD3TAYny0hvl
 /dnp9yiGQpR5PIahLOiNmYotDUfgOB4joHLbFfSsG2q9WeZWFNE+bj/aaMU62HhnYcdl
 nHNgRnG+mCsVmk38XGpbQQGuZ+V1zCzRxb0d27/8JNIiQDdUjDVUUnd4aIF0QLLtM2FO
 eU8IyGadmt5detWIRFNZOUMjHGBn8cGTAipsZTQEMA2nF8t0NPwFNws5KlXUb7ziMqp+
 93rjBIhPraJ7W0aMkPxb/IqK3eUjJTOtfAmBtBPuT4Md8YDI51itbG9ENDcFDZRyyA7Y
 TUiw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlc4YnI8BslAKDC39vzF3qOu1yyPy5gLqCOQ4kOvVqqw909fe/TqhCZHrzbCUKespCL4I=@dpdk.org
X-Gm-Message-State: AFuF++lU9QyEdXwlkvyTZe5C3w359VPaIX3QERdcdFmSLlwqj5Slc7bR
 lRhWw/UX5DG7LpSr+X+YjpSqF+FrUm8Briudf7IZOKobe9QYAC8g046Te/RhDQ+9KQyop1dn4tu
 DrsA0B6pkhR40oGwBXSE1w3Eab87wT98=
X-Gm-Gg: AYBFou0zAIK69csO3yuVZ6RpstyEJV/ouIFXb/d0RXjM4jE6nzqnipWHyWuMT9EiQDN
 XKjm/GvXJu7xDEBRAjGjeKMlmzDhnLQv1bPlHFVMz5f0j72s3kRPAAbqAy+ky+9qrHVTbGuO//B
 A8vj4el5PMdlblKhqPrwv8YL+Xs4PPzmJzKAyYS+ii4i1Y0AE4NuMSex+JmWJH6X1nLSMADjtHl
 PnZbV12ZkgvLZy1NmuciGdrHcLRWzPd5LRz6QSs7xQzsFJs+Xt9agv0s78tPnpZFo+QkcVafutQ
 LTauzx+n9icdoHZZca+YO/7wm9fmFJ8xp4vgmYOJju/cGV5NrH7IRyJjCVnd6LRSxSMIMcpPCBv
 Xhq5Q5yD1MtB/KEKGRVAMKCX1fHofUytqYQ==
X-Received: by 2002:a05:620a:269b:b0:92e:745c:6c5a with SMTP id
 af79cd13be357-93980379a1amr872988485a.14.1788556262768; Fri, 04 Sep 2026
 14:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260720080035.673782-1-maxime@leroys.fr>
 <CAJFAV8xMCEhq4dzNjme_vkN3q0Xp81Psh7t0-uW2xmM8Qpk2tA@mail.gmail.com>
In-Reply-To: <CAJFAV8xMCEhq4dzNjme_vkN3q0Xp81Psh7t0-uW2xmM8Qpk2tA@mail.gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Fri, 4 Sep 2026 23:10:51 +0200
X-Gm-Features: AcwNN1VABp2R46MUikehdEWJYZySbWy1ihgwf0eBCHgK9mNd81tSvwsJCMzwXf0
Message-ID: <CAHHRULUFxQmg1qqmxk_0-vYbASfDBJVik0dnuyhCkM+H0gr5Mg@mail.gmail.com>
Subject: Re: [PATCH 0/6] examples/l3fwd-power: fix Rx interrupt mode for
 shared FD PMDs
To: David Marchand <david.marchand@redhat.com>
Cc: anatoly.burakov@intel.com, sivaprasad.tummala@amd.com, dev@dpdk.org, 
 "Mcnamara, John" <john.mcnamara@intel.com>
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

On Fri, Sep 4, 2026 at 11:30=E2=80=AFAM David Marchand
<david.marchand@redhat.com> wrote:
>
> On Mon, 20 Jul 2026 at 10:01, Maxime Leroy <maxime@leroys.fr> wrote:
> >
> > l3fwd-power's Rx interrupt (one-shot) mode was written around NICs whos=
e
> > interrupt fd is assigned per queue at setup, stays fixed and is
> > level-triggered, as on MSI-X hardware. PMDs that do not fit that model
> > never sleep on interrupts: they either fail to arm, watch an unbound fd=
,
> > or miss the wake, and the 10 ms poll timeout hides all of it.
> >
> > dpaa2 is the motivating example: it delivers Rx interrupts through one
> > QBMan portal per lcore, so the queues of a lcore share a single fd that
> > is bound when the interrupt is enabled, not at queue setup; the
> > notification is edge-triggered on an empty to non-empty transition; and
> > arming a queue that already holds traffic returns -EAGAIN with the queu=
e
> > left unarmed.
> >
> > This series makes the interrupt and legacy loops handle those cases
> > while leaving MSI-X NICs unchanged:
> >
> >   1/6 factor the duplicated arm/sleep/disarm block into a helper.
> >   2/6 check the arm return: on -EAGAIN poll and retry, on any other
> >       error drop interrupt mode for the lcore instead of sleeping on
> >       unarmed queues.
> >   3/6 register the fd in the epoll set after arming, not before, so a
> >       fd bound at enable time is watched only once it exists.
> >   4/6 accept -EEXIST when several queues share one fd.
> >   5/6 recheck the queues before sleeping so a packet that arrived durin=
g
> >       the arm window is not missed under edge-triggered interrupts.
> >   6/6 block indefinitely instead of on a 10 ms timeout, and wake the
> >       workers through an eventfd on exit, so a broken interrupt path no
> >       longer hides behind periodic polling.
> >
> > Maxime Leroy (6):
> >   examples/l3fwd-power: factor out Rx interrupt sleep path
> >   examples/l3fwd-power: check Rx interrupt enable errors
> >   examples/l3fwd-power: enable Rx interrupt before epoll add
> >   examples/l3fwd-power: accept shared Rx interrupt FD
> >   examples/l3fwd-power: recheck Rx queues before sleeping
> >   examples/l3fwd-power: block until Rx interrupt or exit
> >
> >  examples/l3fwd-power/main.c | 184 +++++++++++++++++++++++++++++-------
> >  1 file changed, 150 insertions(+), 34 deletions(-)
>
> I had a quick look.
> I am not a fan of changing applications because drivers behave
> differently, but I think most of those changes are acceptable.

What differs here is not driver behaviour, it is where the interrupt fd
comes from.

On MSI-X NICs there is one fd per Rx queue, created at queue setup, and it
never changes. l3fwd-power is built on that: it adds every queue fd to its
epoll set once, before the loop, then only arms and sleeps.

On dpaa2 the interrupt arrives on the QBMan portal of the lcore, and a
portal has a single fd. So the fd belongs to the lcore, not to the queue,
and which fd a queue uses is decided when a lcore arms it, because that is
when the driver learns which lcore polls that queue.

3/6 and 4/6 are exactly these two consequences:

  - before the first arm, the queue has no fd yet, so the epoll
    registration has to happen after the arm, not before;
  - all the queues of one lcore share that single fd, so registering the
    second one returns -EEXIST, which the application treats as an error.

The ethdev API never promised one fd per queue, the application assumed it,
and no driver can fix that from its side since the epoll set belongs to the
application.

Where a driver can help, dpaa2 already does: it returns -EAGAIN when the
queue could not be armed, instead of pretending it was. That only works if
the caller checks, and today turn_on_off_intr() ignores the return value an=
d
sleeps anyway. That is 2/6.

>
> I sent one comment on the implementation of patch 3.

I will fix it in V2 thanks.

> Patch 5 is a concern to me, as I don't think it solves anything, just
> make the issue harder to reproduce maybe?

Patch 5 answered in its own thread.

>
> Anatoly, Sivaprasad, please review.
>
>
> --
> David Marchand
>

--
Maxime Leroy
