Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20491C55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 03:24:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF07840262;
	Fri, 31 Jul 2026 05:24:53 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id CD3E340151
 for <dev@dpdk.org>; Fri, 31 Jul 2026 05:24:52 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3811f512167so520443a91.3
 for <dev@dpdk.org>; Thu, 30 Jul 2026 20:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785468292;
 x=1786073092; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yk6Tr8vokOEd+WLFHd2dB/nRCsX4mNS1BMPpII8tkt0=;
 b=kt3lYUuKFJuXnOSGwWx9KGsSr+LNdLBIIq6HG15hR8DYL5t6w1mgKRs0opanbB/zYj
 LKgK+BX0ZtAtLmlAr/bO1IU5R5cTdRXTaOrZ3qMNasQrEMSIJtRnEyu1kRKGa5tnltpd
 CHN+h5s0TYJRwWhee04rVGeR44Wa3VpP9UXhJ4yJCu/0qGS5dIdoeeNkIX7Xyup0PIWO
 5P4GmJ65shcF5Gn/naor0m/aQGOs2jB5PpgJzxiTBjHb+VqvgncQBUm/09blGspnbnYy
 nMojgD8vbO7FNRHCfdLNyy+VePRz3SZed5HdRFkeqAXDLE8qUr/O4wBx2HHD0ohcAwBh
 R8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785468292; x=1786073092;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yk6Tr8vokOEd+WLFHd2dB/nRCsX4mNS1BMPpII8tkt0=;
 b=izv/Ug6TDFaeHzsYIGRyqZwdDqVe/gTbbew8bYu7BeegZ4jH455GbwQxaOY6pjaFw2
 HfuBmLYW2lpqWMrbvTmaEfyKO76/XC6l1RXUZ2H3dylcxhiPbOMsbYfUMGp0Yd4Uw1bo
 sTsYAU+90Hkyg8rIiBdvys898mOzwsHd2QfmrcnU5BqmFTzHulA/iwiCpwd+gcDYTaA+
 fJnPOTMMZaiSaPf6WXwnkgoT9+0ee6boLKsWV3rMIR0J0XZ8GbTRiJOaxoeZ9PkQAb1x
 yFFuUd9hSsVXlUn50b4UFiWa1mdHCPBn8L+EgJKDO86fwIe66IPD/msPX+QlIP2OuLC8
 mpyg==
X-Gm-Message-State: AOJu0Yypl40kZw5l0aPgiPkVq7Eafu9CYG8t6IbUl29PeVOHst+cw6m9
 umaY19WIwsygGUpnxqq54ILxOeuGf2xKH9lEVamXF7gH0bmo4EW4d4DKDtkUlZUGt9Q=
X-Gm-Gg: AR+sD12Az2piMK0ZttLnJLtIJPJ29Dk6SqG13DQ5U2Ned6Kx2mc7WshxSRSVJFwWdQc
 oRR4hqzEpPuzDSJb7aje0FelT4MCgGFrUwPSLW1v3HxKXelZxvyefaty8Zuq7psD8QumEXBykKJ
 33uT0+v/bxr0TJiKkbx25tLBfKI05d+q3nB3l5qTuvckiJRXGHNNn1hi/f4sVtcjAtkKX/KxrM5
 Vqr/KMFnE+ekJM26kTsMY4SwNdijdKWPYd3eETVw3Cu2dIoG4yaJOpZEFrO+EVtLV7oyt6T3qxP
 yLc+LixnONNkNc+1IZO9k07UOIjY4t515nNHBs1FIt94yfGesb37zrxCDoqJON/rPT7ZUGyypCf
 iDyr8darSSiTdjDjPcdIJkES4+wyi2EdOeebt+Bu8XAe5NCEXuJoci0SyF4oL/31PxB1Urniq/N
 s8p2ykcFvEUKQkEC3lyDWkZzvJx6lryt8LuuT5y3R7bIy1MsVn5FBQhDzox0DQ4W3naf0fc/uWo
 ssS2pnqx6fEoOnj6FB+LFC/CR2CCg==
X-Received: by 2002:a17:90b:3e8a:b0:38e:69ae:7190 with SMTP id
 98e67ed59e1d1-38fb13515a3mr411447a91.26.1785468291511; 
 Thu, 30 Jul 2026 20:24:51 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fa754f3edsm627058c88.11.2026.07.30.20.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 20:24:51 -0700 (PDT)
Date: Thu, 30 Jul 2026 20:24:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: saeed bishara <saeed.bishara.os@gmail.com>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>
Subject: Re: [PATCH v5 11/24] drivers: replace rte_atomic16 with stdatomic
Message-ID: <20260730202446.46804175@phoenix.local>
In-Reply-To: <CAHfVqdVVG-W+PFZdimqwhrUrUZFSeCNodSu-VU7sscMpaiOVeA@mail.gmail.com>
References: <20260620023134.42877-1-stephen@networkplumber.org>
 <20260620023134.42877-12-stephen@networkplumber.org>
 <CAHfVqdVVG-W+PFZdimqwhrUrUZFSeCNodSu-VU7sscMpaiOVeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Mon, 22 Jun 2026 17:46:14 +0300
saeed bishara <saeed.bishara.os@gmail.com> wrote:

> On Sat, Jun 20, 2026 at 5:41=E2=80=AFAM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
>=20
> > @@ -84,7 +84,7 @@ dpaa2_create_dpbp_device(int vdev_fd __rte_unused,
> >         }
> >
> >         dpbp_node->dpbp_id =3D dpbp_id;
> > -       rte_atomic16_init(&dpbp_node->in_use);
> > +       dpbp_node->in_use =3D 0; =20
> The previous code implies an ordering barrier, so it guarantees that
> dpbp_node->dpbp_id is visible before in_use, while the new code
> doesn't. isn't the a problem?

That is incorrect assumption to make here.
Atomic init is not a barrier at all, it is just an assignment:

static inline void
rte_atomic16_init(rte_atomic16_t *v)
{
	v->cnt =3D 0;
}

> >
> >         TAILQ_INSERT_TAIL(&dpbp_dev_list, dpbp_node, next);
> >
> > @@ -103,7 +103,10 @@ struct dpaa2_dpbp_dev *dpaa2_alloc_dpbp_dev(void)
> >
> >         /* Get DPBP dev handle from list using index */
> >         TAILQ_FOREACH(dpbp_dev, &dpbp_dev_list, next) {
> > -               if (dpbp_dev && rte_atomic16_test_and_set(&dpbp_dev->in=
_use))
> > +               uint16_t expected =3D 0;
> > +               if (rte_atomic_compare_exchange_strong_explicit(
> > +                           &dpbp_dev->in_use, &expected, 1,
> > +                           rte_memory_order_acquire, rte_memory_order_=
relaxed)) =20
>=20
> aren't rte_atomic_flag_test_and_set_explicit/rte_atomic_flag_clear_explic=
it
> a better candidates instead of
> rte_atomic_compare_exchange_strong_explicit/rte_atomic_store_explicit

Atomic flags are not used in DPDK for a number of reasons.
 - limited operations only test and set, no load
 - lots of variation in between stdatomic and compilers
 - no improvement in code generation

Instead DPDK has chosen to just use RTE_ATOMIC(bool)



More wordy AI response:

On Mon, 22 Jun 2026 17:46:14 +0300
saeed bishara <saeed.bishara.os@gmail.com> wrote:

> > -       rte_atomic16_init(&dpbp_node->in_use);
> > +       dpbp_node->in_use =3D 0;
> The previous code implies an ordering barrier, so it guarantees that
> dpbp_node->dpbp_id is visible before in_use, while the new code
> doesn't. isn't the a problem?

rte_atomic16_init() is a plain store:

	static inline void
	rte_atomic16_init(rte_atomic16_t *v)
	{
		v->cnt =3D 0;
	}

Same for rte_atomic16_clear(). Only test_and_set() and dec() implied a
barrier, via __sync_*. So no ordering is dropped.

Neither version has a barrier between these stores and
TAILQ_INSERT_TAIL(), and the list is not atomic either, so a reader
concurrent with device creation would be unsafe regardless. Devices are
created during bus probe.

The point does apply in reverse though: with the field declared
RTE_ATOMIC(uint16_t), a plain assignment is a seq_cst store when built
with enable_stdatomic=3Dtrue, and a plain store otherwise. v7 uses
rte_atomic_store_explicit(..., rte_memory_order_relaxed) so both builds
behave the same.

> aren't rte_atomic_flag_test_and_set_explicit/rte_atomic_flag_clear_explic=
it
> a better candidates instead of
> rte_atomic_compare_exchange_strong_explicit/rte_atomic_store_explicit ?

Semantically yes, but there is no portable type for the struct member.
In rte_stdatomic.h those map to C11 atomic_flag with enable_stdatomic=3Dtrue
and to __atomic_test_and_set()/__atomic_clear() (bool or char) otherwise.
atomic_flag also has no load operation and no initializer other than
ATOMIC_FLAG_INIT. That is why rte_atomic_flag_* has no users in the tree.

If an rte_atomic_flag type covering both backends is added, these sites
are good candidates to convert.
