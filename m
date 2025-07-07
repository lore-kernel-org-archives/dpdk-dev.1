Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEDAC8303C
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 04:14:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB637402CE;
	Mon,  7 Jul 2025 06:14:33 +0200 (CEST)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by mails.dpdk.org (Postfix) with ESMTP id A12B24025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 06:14:32 +0200 (CEST)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-40b1f402deaso1699319b6e.3
 for <dev@dpdk.org>; Sun, 06 Jul 2025 21:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751861672; x=1752466472; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vitexihQ3rAsUuIpjrZoyYxmsGvRhhkCYOij3AwH328=;
 b=nYawZ7Hwk9wqOMttJAuxbClaLId7PZcuR2YFcZVPeDAzg5SNAxCxOFD4YcdEriJaYF
 hRfN6DF6eUyFvkjYcIrhXn0OJaWg8O4RLw30H7RM6UWGLiWT2yCVQ+nFX8GrrTKpy93Y
 AKS7QOI0CXyzeSG9y6xw3OS/1n5lAIc2rqzFZK8sNS54L3JpWY1VKcnjuyjBVHcJqMYU
 94tn/JxUFWsgY50fk9YT5OdXplBEBSQoM4Rq0NxhVDUD73xh1VxPmTqcdGt62v57Rcje
 ACEl+q+hnMBfRAY3Am3X6iIqVFp8NNvo6Tn4ag2rsDeBy3YCP/cZtKRvUUT8310a/2ke
 rUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751861672; x=1752466472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vitexihQ3rAsUuIpjrZoyYxmsGvRhhkCYOij3AwH328=;
 b=lshUkYaZdr9xul/tWqhMxPKOcP9vzkWq5TrkiNuPBCaEHgR9+mVmPC4TjF3yeZzi1Z
 PSIIdgxdjebbbpwvNEUiy99O/eFu/+QQ2XCAynIWW7k9stCJDffVIZAqxFTXPqKAVx1I
 L3ragiwHk5AGqIDmqpuwO8rWeQBu6fgS4lLjwpeSXWt90zN/GN/mihGZtbOp7/+pUKrB
 Wc4rAt7pDemzTzyX7Q8Ov6wZShfHr29cIc4NuV1E5U03J2r/oOOjlDW5McaXtVZcRhSQ
 r6dF9wT30sbfnoRgLsFqoxKvCKQAoOGBw6KpvqkWtG+57CSjYk3GRBGQ4y2if08gtqun
 xIsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDojHMylasBMPbtIuEuLhpayZz7xloQHDzIMyRromATCSEv1EZMMhav2BhDHAMFps24K8=@dpdk.org
X-Gm-Message-State: AOJu0Yx/tvneZhUhCxT9YTd+KV/YdVdjKo7H4UZdQYgFzFDrwbjKGsvT
 A2s4psiqqoB85VHs5yG4hYicsPuIUfpZvJdhvI+IzkK7HrOSEqoFFs4Lwk2d0giV/HhkQPyGOfi
 CXbJfR5RPV0DW7vrk9MCI/SWWAkiCi2I=
X-Gm-Gg: ASbGncsvO0w/QkzSbaZ8HoAFXnjeJwFjLV0o2FcOI0hZHfyS0fCYQYN8Ek8/fGVL2LK
 D+9nSdxQXJgLd8tTxJYmd0W1BLBh1LPFyZ7klMijinWXe+pEZH0OdsU4N2x5Oe4y/xL/13AZveO
 YO54G0bp9Hqxm1L0Ya3kqiUdrYPmrTamvlYCL+AKzz7bM=
X-Google-Smtp-Source: AGHT+IEwhcTf14rjTr96XBdpToczv3rHKhy5SRJnksmr3SaCXgU2+JSqhPAUWVhciqCo16RtIrbRw3+cZI2DnLToP6g=
X-Received: by 2002:a05:6808:3007:b0:403:50e7:83e1 with SMTP id
 5614622812f47-40d2ad814d0mr5324898b6e.11.1751861671699; Sun, 06 Jul 2025
 21:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250609072347.1748785-1-hengqi.chen@gmail.com>
 <IA0PR11MB8336E80904EA2B2AC1041C45FE42A@IA0PR11MB8336.namprd11.prod.outlook.com>
 <7be991f8-a7d7-48c7-af5b-dad4aaacb486@redhat.com>
In-Reply-To: <7be991f8-a7d7-48c7-af5b-dad4aaacb486@redhat.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Mon, 7 Jul 2025 12:14:20 +0800
X-Gm-Features: Ac12FXx5cHMe78z1MXDeAi5n8ZGXZTwsPL4Dgvlw5qUZCBe8PHqm24loIurp7pA
Message-ID: <CAEyhmHQ+5apT0wtTr5WGPJ1R58MyOt+1m2HYx1-KpDACoW+zpg@mail.gmail.com>
Subject: Re: [PATCH] net/virtio: Fix check of threshold for Tx freeing
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: "Jiang, YuX" <yux.jiang@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>, 
 Baoyuan Li <updoing@sina.com>, Chenbo Xia <chenbox@nvidia.com>
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

Hi Maxime and other maintainers,

On Fri, Jul 4, 2025 at 7:57=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> Hi Yu, Hengqi,
>
> First, thanks Yu for testing and reporting the performance degradation,
> this is much appreciated!
>
> On 7/4/25 1:29 PM, Jiang, YuX wrote:
> > Hi Hengqi,
> >
> > Can you help to check the ticket: https://bugs.dpdk.org/show_bug.cgi?id=
=3D1747? The perf drop is caused by your patch. Thanks so much.
>
> The options I see are:
> 1. Revert the patch for v25.07, fix it and resubmit for v25.11.
> 2. Fix it on time for v25.07-rc3
> 3. Keep the patch in v25.07 and try to fix it in v25.11.
>
> As I will be OoO starting this evening, I would be in favor of option 1.
> What do you think?
>

I am OK with both option 1 and 3.
Please handle it according to the DPDK community rules.

Thanks,
Hengqi

> Thanks,
> Maxime
>
> > Best regards,
> > Yu Jiang
> >
> >> -----Original Message-----
> >> From: Hengqi Chen <hengqi.chen@gmail.com>
> >> Sent: Monday, June 9, 2025 3:24 PM
> >> To: dev@dpdk.org
> >> Cc: Hengqi Chen <hengqi.chen@gmail.com>; Baoyuan Li
> >> <updoing@sina.com>; Maxime Coquelin <maxime.coquelin@redhat.com>;
> >> Chenbo Xia <chenbox@nvidia.com>
> >> Subject: [PATCH] net/virtio: Fix check of threshold for Tx freeing
> >>
> >> Like most dirvers, make the fast path of virtio_xmit_cleanup() behave =
as
> >> described by the comments of rte_eth_txconf::tx_free_thresh ([0]):
> >>      Start freeing Tx buffers if there are
> >>      less free descriptors than this value.
> >>
> >> The rationale behind this change is that:
> >>    * vq->vq_nentries is set during device probe with the queue size sp=
ecified
> >>      by vhost backend, this value does not reflect the real nb_tx_desc
> >>    * the real available tx desc is set to vq->vq_free_cnt via the nb_t=
x_desc
> >>      param of rte_eth_tx_queue_setup() API
> >>    * so `nb_used > vq->vq_nentries - vq->vq_free_thresh` could never b=
e true
> >>      if say nb_tx_desc=3D2048, vq->vq_nentries=3D4096, vq->vq_free_thr=
esh=3D32,
> >>      see bug report 1716 ([1]) for details.
> >>
> >> Bugzilla ID: 1716
> >>
> >>    [0]: https://github.com/DPDK/dpdk/commit/72514b5d5543
> >>    [1]: https://bugs.dpdk.org/show_bug.cgi?id=3D1716
> >>
> >> Signed-off-by: Baoyuan Li <updoing@sina.com>
> >> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> >> ---
> >>   drivers/net/virtio/virtio_rxtx.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/virtio/virtio_rxtx.c b/drivers/net/virtio/vir=
tio_rxtx.c
> >> index edecd2011f..ab97f03d7d 100644
> >> --- a/drivers/net/virtio/virtio_rxtx.c
> >> +++ b/drivers/net/virtio/virtio_rxtx.c
> >> @@ -1873,7 +1873,7 @@ virtio_xmit_pkts(void *tx_queue, struct rte_mbuf
> >> **tx_pkts, uint16_t nb_pkts)
> >>
> >>      nb_used =3D virtqueue_nused(vq);
> >>
> >> -    if (likely(nb_used > vq->vq_nentries - vq->vq_free_thresh))
> >> +    if (likely(vq->vq_free_cnt < vq->vq_free_thresh))
> >>              virtio_xmit_cleanup(vq, nb_used);
> >>
> >>      for (nb_tx =3D 0; nb_tx < nb_pkts; nb_tx++) {
> >> --
> >> 2.43.5
> >
>
