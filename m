Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65832C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 19:10:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7433A40150;
	Mon, 29 Jun 2026 21:10:43 +0200 (CEST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by mails.dpdk.org (Postfix) with ESMTP id 4AD9C400D5
 for <dev@dpdk.org>; Mon, 29 Jun 2026 21:10:42 +0200 (CEST)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-39b08a820a7so15293401fa.0
 for <dev@dpdk.org>; Mon, 29 Jun 2026 12:10:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782760241; cv=none;
 d=google.com; s=arc-20260327;
 b=XvNeou0KgRdhmCbWzpIQam72RqjFK1g5aIGjhG79gORhXkBUNsg8yj7vB3ZPlM7iJa
 8NXuSAL1eJ3W690btDDmeJc6MGBX1FtH3JzUAPqRuU1S76RyeYbo+z+KyncJsdsQ8QQg
 g9EzrAyQkW4gKCIb1Bob8et+p8DWECr6Rd9ws5HnEZtOj/mcDvSGyXdDc90cy54yhDWX
 PuwOko71hPVibxIzdMz5/U88ya5uxtrKKP+zko0EYtzC41i8+uJvibr/RFOSIPX/aIwM
 42cyqP4i/zJ1iKwAnMyh7maDvr3cIHnfyL2xuiWxJVdtEQA+Qh2+YqQUvFjHGn2c0S32
 rQmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rqdIPXLxhpcsQFAkTCQ9Id/jV28czC1UUFYLgomZSAI=;
 fh=Ufu+mhInET3GbQds4oIWWZcHZ97ZE8JoNy1IULCOPJc=;
 b=MXa0ogNzZcEzgUmtgJF5MNawv4k2lF1FNtn+YU/6EuY8b3Pgm8VvI7CHQPsNVvwyrN
 dG5exC0Yf66vDPSp3UDa6iwU/M/bSYac/sYWtZ+hHepJDKfgNUK5O0CcllZQSXS/W+WI
 qp+wqMkJItVfCfhpEvf3mGJIBl6hco6oUfiHWfQVT71N+qFeSy8xvmBsJkeqNs6VJDN/
 3D+QClO/qZysDrq9ndCjlVPap5OyklkUtYqxZEWzre8W4Vgy28RAVWZ6io3JpAfouDdi
 lmJ6nEBQhprklDvRc4inXdAI2N62O+KOT7XH0pW5HBHPPGbBWgGLl9RB1YdpcI1mXaEs
 tnYw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782760241; x=1783365041; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rqdIPXLxhpcsQFAkTCQ9Id/jV28czC1UUFYLgomZSAI=;
 b=oMMmj2YVCn6Ql1XKqluoshR5ILQLoC5C9GB6fKE5BOzWLgqGR7KCPBFNtwTHSS7KKb
 2CtJDnpc3roFHlgkwwwwgS2s7SZwkQLhD5KAWMEUyQz6eegNVVXTd1vrph0iY4ByuUHz
 6kA2sWJq5rg6SWW7Fmr4Vrg4A1P/fL2E+Imu9TuJLAUZvhJYlRoYwJJxN+vmMCL19G8B
 1WBWlCCQ9IExrig49Y8NtRXhWT0swfPOA5Ec7zvyy0yisGkP47xS+ztgUuvLHYmLiEyj
 3XsUc1HETiQz8kWYNSRSIJzHnnB+Edx1LQEw9ZTaDnwIgVVBjp1vA68AZ5nJZR+cwElE
 58EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782760241; x=1783365041;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rqdIPXLxhpcsQFAkTCQ9Id/jV28czC1UUFYLgomZSAI=;
 b=JYa2rBW3C9OeweTMBr65s7PyQP07soCnGkQunOnM+ijaZEEo/BDu5JZCEFiAX+8g7t
 Eyoim6gUyb9xw63JCkQCI8sD+i49aN2IxY9TDk1H3JYRCoy8yyhJvHX/KQaxuYpZSOz+
 yoGKCLiiSfReBhZJHim6NmBga3DVuby7jJwnBBYVlso9hMgWXFUG99bbRTlDCvJWajmD
 mwaFF81Wn1By88o2y7bvHh0jBH7nA8qb1Yzn+62m1WV1FAa6C6s6ABOABAD4Q8x2Rxxt
 kB4aIcuYNyL/1zWNpD/htvWmgX/n6SeRn5XYsveGU0FrMsY+7IaLwXRmKkdvY7rvXyuV
 jnVQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp0n+F9zTGYmmVQCEyiuffyuz+GbaHbEZbeMphhDbsiYaHOpu84Hw80U6AbYLUpzY6seRw=@dpdk.org
X-Gm-Message-State: AOJu0YwOz8OD0YjspaoceqweARlHxiD275JRc3KDVG2wFUqN1NlDtKTU
 69ttYmZfYhFffwh2UIsz8dFS5wyPSsTTlMNDlDQyXhU5fpXcK18chlIfqBZ1NgwhjEze7VxKjvu
 fxkj4q4PiP4rxWLxBug3IM9YvFZMK1rvYjjSLSqWa
X-Gm-Gg: AfdE7cm9i7Jaxs+d5E+26sIZRkvKNVAMKfSe5hA3jgfoe7xRGUzLMMdsVhtUPXmISzV
 VgTIWdPlofdhaA/aqJzZQ1QcXtFlo+fkthiRCIsS8JXMeMEMS5E1sbdHn9TuPbw+912RXqsU05n
 sAHAKwR9O6NYlB89q1sSfEuXWcr/TCoJ9RqL8Kaj0uCkYlW6duwaVQVB7V2dHLDBM+9UbtcKp5E
 /L4H8ppW/arGCYPD6n+SDFaZXMhImZmTkNJrdLI2JD8hs2bK0eBMiipOFaw627PZMmpoYDDk7Q3
 n5JfY8KtaaHdGUBPpbDofDHuOQ==
X-Received: by 2002:a2e:bb94:0:b0:39b:19e3:48e4 with SMTP id
 38308e7fff4ca-39b1d46e7a5mr1046041fa.9.1782760240809; Mon, 29 Jun 2026
 12:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260623215325.814776-1-blasko@google.com>
 <20260623150638.266d8574@phoenix.local>
 <CANULgnK9-P5dQtTPayiFD7PLor=1qV=7du-AtRuWGPd4F5SmAQ@mail.gmail.com>
 <20260629103804.3d4154bb@phoenix.local>
In-Reply-To: <20260629103804.3d4154bb@phoenix.local>
From: Joshua Washington <joshwash@google.com>
Date: Mon, 29 Jun 2026 12:10:27 -0700
X-Gm-Features: AVVi8CfpJ5muCvNJeUutEkh7uanwBVxnyiaIFkwX5_nc4HadCBgF4dDvhHjo1aw
Message-ID: <CALuQH+W4wPA5ygZ63pcQrCD-Uz_K1AsN9n+fzX+ESarmaHnmrA@mail.gmail.com>
Subject: Re: [PATCH] net/af_xdp: add Rx metadata and dynamic timestamping
 support
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Mark Blasko <blasko@google.com>, dev@dpdk.org,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 "Jasper Tran O'Leary" <jtranoleary@google.com>
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

On Mon, Jun 29, 2026 at 10:38=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Sun, 28 Jun 2026 17:50:03 -0700
> Mark Blasko <blasko@google.com> wrote:
>
> > In AF_PACKET, the PMD reads the timestamp from socket ring headers
> > because the kernel stack processes the packet and allocates a socket
> > buffer. Since the kernel stack and socket buffer allocation are bypasse=
d
> > in AF_XDP, UMEM frames are given directly to the PMD, which
> > means the kernel never generates these socket headers. Also, it
> > looks like the TAP PMD doesn't support RX timestamps.
> >
> > Since the location of metadata in the UMEM headroom is determined
> > by the XDP program, the current driver implementation is coupled to
> > a specific XDP program layout. As an alternative, we could just
> > plumb the entire metadata headroom to the DPDK application and let
> > the application parse it based on whatever XDP program is in use.
> > That would couple the application and the XDP program, but would
> > at least decouple the driver and the XDP program.
>
>
> Sorry if I was not clear enough before.
> The DPDK PMD provides an abstraction to applications to avoid exposing
> as many details as possible. Whenever possible a PMD should follow
> precedent and implement functions in a manner similar to other drivers.
>
> The method of expressing received timestamps was never well described
> in DPDK documentation. The convention is:
>   - A dynamic field in mbuf is used for the timestamp.
>   - All drivers using timestamp should register the same field
>     using rte_mbuf_dyn_rx_timestamp_register.
>   - The mbuf field is filled inside the rx_burst processing.
>   - The timestamp dynamic field is a 64 bit unsigned number rolling
>     clock value.
>   - A PMD providing timestamp, must also define a readclock ethdev dev op=
s
>     so that application can compute the number of ticks in timestamp per
>     time interval.
>   - A PMD providing timestamp must advertise that in offload flags.
>   - Timestamp should only be inserted if the Rx timestamp offload flag
>     is set during configuration.

These are all very good points for ensuring an airtight abstraction.
However, I'd like to note that neither of the kernel-bound PMD
interfaces (pcap, AF_PACKET) have support for the `read_clock` op. I
am not certain of the reason for this, but I suspect it's because
ethtool IOCTLs already cover that functionality. This patch's
implementation follows the other implementations pretty closely,
differing only in how the timestamp is extracted.

>
> When I read this was a little confused about meta data in mbuf.
> Would have been clearer with a simple helper:
>
> static inline void
> af_xdp_rx_timestamp(struct rte_mbuf *m)
> {
>         const struct af_xdp_rx_metadata *meta
>                 =3D rte_pktmbuf_mtod_offset(m, struct af_xdp_rx_metadata,=
 -(int)sizeof(*meta));
>
>         *RTE_MBUF_DYNFIELD(m, timestamp_dynfield_offset, uint64_t *) =3D =
meta->rx_timestamp;
>         m->ol_flags |=3D timestamp_dynflag;
> }
>
> If you are going to do Rx timestamp then a simple readclock ethdev op
> is also needed to tell the application what the units are.
>
> But there are bigger issues with this patch:
> 1. The patch assumes metadata is always present in XDP receive but device
> used by XDP may not implement it. There is no capability checking.
> The DPDK PMD ends up advertising RTE_ETH_RX_OFFLOAD_TIMESTAMP
> unconditionally even if underling kernel device doesn't do it.

The patch as submitted is incorrect; my apologies for that. I missed
it in review. The layout of XDP metadata is something which is
determined by the XDP program and consumed by an AF_XDP application
tailor-made for the XDP program. This means that the PMD itself would
not be able to process the RX timestamp from an XDP program on its
own; that functionality would have to be handled by the DPDK
application.

>
> 2. The format of metadata is not a documented contract between kernel
> device implementing XDP and the DPDK.

This is true. The contract lies between the XDP program and the AF_XDP
application, which can both be controlled by the DPDK application and
its invocation.

>
> 3. The XDP documentation says you need to check for metadata
> in each frame.
>
> 4. There are no head bounds checks; must check that there is
> packet headroom is configured with enough space for metadata.
>
> I am sure AI will find several more things but need fixing
> before ready to merge.
>

Unfortunately, I think that some amount of abstraction leakage is
unavoidable by the very nature of AF_XDP. What I propose is as
follows:

Introduce a new PMD capability for processing XDP metadata. The mbuf
dyn_fields can store a pointer to the metadata and the size of the
metadata. The DPDK application processes the metadata as it sees fit.
As mentioned before, both the reader and the writer of the XDP
metadata are both controllable, and this would add the flexiblity for
one to use pre-existing DPDK mbuf infrastructure with minor
modifications to support this functionality, rather than introducing a
full rewrite using an AF_XDP application.

Would this be acceptable?
