Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981FEC61DB6
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 08:07:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB1D14014F;
	Tue, 25 Aug 2026 10:07:36 +0200 (CEST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by mails.dpdk.org (Postfix) with ESMTP id 5A5EE400D5
 for <dev@dpdk.org>; Tue, 25 Aug 2026 10:07:35 +0200 (CEST)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-855de2d0d4dso2481267b3.0
 for <dev@dpdk.org>; Tue, 25 Aug 2026 01:07:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787645255; cv=none;
 d=google.com; s=arc-20260327;
 b=ihu71f4wxw1qtBBiemZojKQvHAgDtjhsCkEMSO6WeNFxuh2RS2QGH1zyO8SehpUCvo
 RmA+G98AnieHsUP4BSkojcKD06uYvqDnE25Lh5lwxCbPh6fulv9PZfqM8P9Y6EsSG1dw
 W80iT0DbOl9ozf+Sr/EgDXq9WSqLa3QWjSOVgf+p8R3IrTJ7itNZeJ4zAqZgpv5IJ4if
 PuSrXTIYVW6j9ncTLSA6J88ey/MT4Ux46VLcnPX7mivjNCYxxeCzY5Eum5LyrRvQdiYE
 5VNKjcLNO0ycl9AbvOkhjO7pZzwfvBTNN/OeyL4tIpNi81oqY5U26hzuYZ1t+4Bz0mK9
 UnPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=Mb1M+CpbIAK/3LCnD7CiM+ykAMgDNYkE9KJWCWNA+yM=;
 fh=9ZT2eOi9U3FP9pJtTX5ym15ySzxhByyLbKLS7StDchY=;
 b=PnOUNCwuhrZ/s0TSVohHPbISNj0HMxU5/omwtr6ZH8oLH+WWNkGshlPcL8PRvJxPO6
 EbJV3FHv5thbu6PC6RvWLB+wSNv0pp6nSc8yXBTjrz/DUO4wVHD8VQ+FFQjitNBfjARV
 gYL30SYAC4IX1Gx1VZms20SwzTELRg8fKL+wr69M/10P28HqS5Qp6+TfLjbRpMqU5x2H
 KGIEUGjgWW8jrRiCjQSEVJTU5/WHJYPCj9L68QIAzMYZ0JwOHKBC3bbJku9PN5bc28f9
 hWFDCP7yUY/lVuYaq59ecsN+XKYNi46Od7fBHE3HjPjk3mFDOYb9dEvmYpo3iZB+MAEh
 icTw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787645255; x=1788250055;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mb1M+CpbIAK/3LCnD7CiM+ykAMgDNYkE9KJWCWNA+yM=;
 b=UwmG+phOR23GkOauTKqHl09tujUyAEazV5XwDwV29w2w+8YQsR8CvKMeCTfzwb3/hf
 omL9kPabvAZmJtPmQ+yYCzR01q2j3Oj1FnC0tTxaI20ffSHVRGz+JxowmbQxxqrZOlox
 dxVFUxzzGDK1jcnl9ySf5wVG1Z5DgRr/hm5jxTEOrApf+Fu0d73XOC6m8ex2CI9wdYDA
 f48RSJ7HU8AVYRwVfa5iq3/lj19A71DvOxz91PWxASFM7u6nCGc9TarBviDNdzoy0Bdl
 6GNw2/Pg1p30b4PlcAdAi5d4c1h8SrClmbmsz4qbmQtvfkefpR8LvxQXA9Om9LWJUjwu
 XMCw==
X-Gm-Message-State: AFuF++kM392mpeEye4i6Rvuak2A8ukBrjNoIb012BPTH1XNRw39gEcqT
 9gka3G+rVzfh1z5TJLat9UoaRGnxaLgRqXtCN0Ua+mLNhoznIYlVy+4z9ha0uzE9BRh1tgvnoAt
 Snxuf1GQ6SrIsXG+PmoFYMA6AZlSFP34=
X-Gm-Gg: AR+sD109a+ZCtzCZI9N+T+4k/tTF7+7JXtMCm8d+KjA9Ms+hqkzQDCoU/C6az30sUE0
 6Xezf/vHifOrr/CDI7nClgURzJ9pOc0aEY4b4a/1pFUhndxQ3qUVG3Ymjk5z3GYx5vxdtFpe3jw
 ApsuLBC1rAsvnFatBN7IKsaPPwb2PYeDbyN9X3Z2hyELWYgk8mmhMz7OXFY/ZHDFlSyzEwoy1OQ
 EAM6yM+Ktb4ieDWuqSfLZd4DZ3619uoivS4018T5mzR3oTeKZZJE5uP/wQEAUnTlit35DDJSSu6
 UlkX5L1uZhM59cr26p/79Bob9UhAaei+j7Ir2vyOcaEiQiRTBXGN0lAPh3BYOwdura1wxBaEkOM
 AWUw=
X-Received: by 2002:a05:690c:370a:b0:845:2054:2365 with SMTP id
 00721157ae682-85474e2bd4dmr20364217b3.14.1787645254683; Tue, 25 Aug 2026
 01:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260720080035.673782-1-maxime@leroys.fr>
In-Reply-To: <20260720080035.673782-1-maxime@leroys.fr>
From: Maxime Leroy <maxime@leroys.fr>
Date: Tue, 25 Aug 2026 10:07:23 +0200
X-Gm-Features: AcwNN1UKk1vqGYDH5D64Q7-QJBTAxJ7mIYlDGgzeN1SLNxoxSdOVVoiY_I3ExcI
Message-ID: <CAHHRULX+n4ujtrx-y3SwigiKcCOzaKvQTCamhkgdhAZ0qiF4zQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] examples/l3fwd-power: fix Rx interrupt mode for
 shared FD PMDs
To: anatoly.burakov@intel.com, sivaprasad.tummala@amd.com
Cc: dev <dev@dpdk.org>
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

Hi Anatoly, hi Sivaprasad,

On Mon, Jul 20, 2026 at 10:00=E2=80=AFAM Maxime Leroy <maxime@leroys.fr> wr=
ote:
>
> l3fwd-power's Rx interrupt (one-shot) mode was written around NICs whose
> interrupt fd is assigned per queue at setup, stays fixed and is
> level-triggered, as on MSI-X hardware. PMDs that do not fit that model
> never sleep on interrupts: they either fail to arm, watch an unbound fd,
> or miss the wake, and the 10 ms poll timeout hides all of it.
>
> dpaa2 is the motivating example: it delivers Rx interrupts through one
> QBMan portal per lcore, so the queues of a lcore share a single fd that
> is bound when the interrupt is enabled, not at queue setup; the
> notification is edge-triggered on an empty to non-empty transition; and
> arming a queue that already holds traffic returns -EAGAIN with the queue
> left unarmed.
>
> This series makes the interrupt and legacy loops handle those cases
> while leaving MSI-X NICs unchanged:
>
>   1/6 factor the duplicated arm/sleep/disarm block into a helper.
>   2/6 check the arm return: on -EAGAIN poll and retry, on any other
>       error drop interrupt mode for the lcore instead of sleeping on
>       unarmed queues.
>   3/6 register the fd in the epoll set after arming, not before, so a
>       fd bound at enable time is watched only once it exists.
>   4/6 accept -EEXIST when several queues share one fd.
>   5/6 recheck the queues before sleeping so a packet that arrived during
>       the arm window is not missed under edge-triggered interrupts.
>   6/6 block indefinitely instead of on a 10 ms timeout, and wake the
>       workers through an eventfd on exit, so a broken interrupt path no
>       longer hides behind periodic polling.
>
> Maxime Leroy (6):
>   examples/l3fwd-power: factor out Rx interrupt sleep path
>   examples/l3fwd-power: check Rx interrupt enable errors
>   examples/l3fwd-power: enable Rx interrupt before epoll add
>   examples/l3fwd-power: accept shared Rx interrupt FD
>   examples/l3fwd-power: recheck Rx queues before sleeping
>   examples/l3fwd-power: block until Rx interrupt or exit
>
>  examples/l3fwd-power/main.c | 184 +++++++++++++++++++++++++++++-------
>  1 file changed, 150 insertions(+), 34 deletions(-)
>
> --
> 2.43.0
>

Gentle ping on this series.

Thanks,

Maxime
