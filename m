Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31856C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 00:41:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A94D4021E;
	Tue, 30 Jun 2026 02:41:24 +0200 (CEST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42]) by mails.dpdk.org (Postfix) with ESMTP id B69F440150
 for <dev@dpdk.org>; Tue, 30 Jun 2026 02:41:22 +0200 (CEST)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5aeb17c2564so1363579e87.0
 for <dev@dpdk.org>; Mon, 29 Jun 2026 17:41:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782780082; cv=none;
 d=google.com; s=arc-20260327;
 b=AdKCcGEpUBLRFzjabFzMvyJpE9MwzyTle7DNef9jPiR/TOT3jKGKzoZTPCEppjdpOO
 rgK+L5s/ecI/1bXkAwke1MhDG56bsi/v/zHsh1VcbyMSpYpT98XC9478z0GabDFxdQz2
 SsTMLkKlPWaBPgXdwQS8smtOfwJ+tmVWtTbNLS9J8iXHuyln2+eNLupZFd0U7/Wxnm6+
 xbPdMEURp5sgsKQHcZWlJ6O2lXsnUzNngvMYk0iYqiUzllecYXh2cHdUvGQZLWro4CXx
 zkwXCodbz8ziaQO996AqtXnbsBhZQvluwMkKsyxI19/GpaQU3wCvEcMec1WjkI9f6m43
 7JpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=33czUK7UEZQtDkjT7XTscMWf6cckaHcaX5cnMKaw3gM=;
 fh=y5YF3X4QQc+YkrwAIqZfIe/cN7B80JlV8tOkHpWOk+c=;
 b=WgsUdbsBdzy5FOoIn+PlKIRiLap/WP8oeLWvFh1ydUKX2cyWU72OE1J0wqPCycC96b
 v/nzIHogEGXYHvm4Tyfz+8FliATtaujq5Q+ByC2BDbTHk28uYRR0y7ksZPyauK987wvn
 VjcjGuPLjk5sBTKUcpyKa0k7P8OZfy5GqqAyEyn0/wtTRrwii224tfB3gZjEr3VXGlwH
 jVJ82KXWfJZsRt7QalCjyspLEjaAOtGqq4fN7N9vo4EK/p7T3FWTJTb3cotWj7CHTPQN
 fhdOslzPWZtALqq9lDRsjSCOay/xLCzx9Uklxa0da5UcAhELl8r6YL6H1BKIep9TNGyf
 Li1A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782780082; x=1783384882; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33czUK7UEZQtDkjT7XTscMWf6cckaHcaX5cnMKaw3gM=;
 b=alH6uDqBXC4lZvv+CW8+K3Bx9Oy//YqoEuVF1xmEwu7BPs5qJIth5CfPo2zcrG4o9r
 ziywwYvX2Y4P6EB57RrISxWo5p0QFKTZ4OfBT7o73lR3+cHHWUpv2SuPzBfREp/0BB20
 xsbKljcqnbCU3sNalxQ3g4g+0ovsptyW7jP9ztv2cQQ5vzFhanZytvgASbyPFpY0d8yg
 2T3SGmrafqgNvQlMRr47LeRl76FLFJ1SJPyucz6t5py38fZRMBolhDMpsvkYKLtt7BE6
 mrJqmgvvY08SSfGYCOXMAKgGR8//0OdUuLJtX6ZM2l03icj0moxQOsjSg/TDSivExrXw
 q2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782780082; x=1783384882;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=33czUK7UEZQtDkjT7XTscMWf6cckaHcaX5cnMKaw3gM=;
 b=tQkF2pBphob7m2kjxNfL/qIuAzMoYXvmuCL/Jdk0D+uzjo+YzifuCx9bVDMjqWz3m+
 AhsZKjA6Olnez75hDt/6GZIpT4sUwyh4AGabfS1uYNS6LiHU0aDW2XE54/dMmmS8pPxC
 VPt2uUpgqAQC33G2Q0VUUNkxYFLe/Xr5n/J86VxS/IwTqyqOf3pGPvEXFeeqQKXr5A4v
 gNoCZuH3HWizu6uarnPP3TxWomxp6OrG+CXYzqWFtXtBFGKWAOMADkhs9LYBUSUDuuVV
 VTi38Whr6DskFfqvdaxZOL6r+YHZaQX7B/sTV5GR7cRHsnw0r0/LhhHYgm/68jJpKJ6K
 +FoA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqBA2DW3XJR5Ri5vVHR3cZPD/+Vp3KYhL6EF0269t/LTW699dd9nMLYLJKwp6l5RRLZQYM=@dpdk.org
X-Gm-Message-State: AOJu0Yw/bQIM749q04YJAFsy5Nebrk1Y3oqZj1CfropD1myCfT62N7Rr
 NgdK19vDxrHX+JfVgeHvHlaqBMxydtsWkkH8zc1zWFT20/w8xYTWzFwpCDQSz+P5pbwM+A+ZcP6
 AKrF3C0lQt3pYhwsEOkK0ZMU0rKqSxQgVyJecleWH
X-Gm-Gg: AfdE7cm5N7bHj9kn108vayAxtrvT/TI4NWYymqVzsVP1mXHHRV0OvmOERAJzfvlGBTV
 y/DYMwa4dnCU7+LSr0H1navydmiFvLHMiSHONY9y3DEzCuxEfE/fGe53uqoAOQJ44kNIPV4U3WA
 ayEpHxGu2qKoxcmQBKGe/3jCdyF1vaF090ZG3w6KGpIAeiB/GpkXoRzmONPun67aLsh7ndYLHi8
 s0M4ZgJJcSvvKkMyR0ttyIM4bEoEEJ/16izrq7j1d9Rl7Kg6/jO9JNkKcruf5cmaraujm7r17rJ
 EhEVyMtJVe2x1+ykGNl97tWYLA==
X-Received: by 2002:a05:6512:4605:b0:5ae:ba0a:5984 with SMTP id
 2adb3069b0e04-5aebdbd24eemr251923e87.53.1782780081574; Mon, 29 Jun 2026
 17:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260623215325.814776-1-blasko@google.com>
 <20260623150638.266d8574@phoenix.local>
 <CANULgnK9-P5dQtTPayiFD7PLor=1qV=7du-AtRuWGPd4F5SmAQ@mail.gmail.com>
 <20260629103804.3d4154bb@phoenix.local>
 <CALuQH+W4wPA5ygZ63pcQrCD-Uz_K1AsN9n+fzX+ESarmaHnmrA@mail.gmail.com>
 <20260629130330.2bd6a3cf@phoenix.local>
In-Reply-To: <20260629130330.2bd6a3cf@phoenix.local>
From: Joshua Washington <joshwash@google.com>
Date: Mon, 29 Jun 2026 17:41:08 -0700
X-Gm-Features: AVVi8Ccom3TACVhSrzXmH2IKbgmoH5TChpxBYt5Aaabhpu_aTBrmCwaNzVtInRE
Message-ID: <CALuQH+Uom+mie91cfh78dbW0MaUtyQFeXMSeTyBVb88vnO-kHA@mail.gmail.com>
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

On Mon, Jun 29, 2026 at 1:03=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Mon, 29 Jun 2026 12:10:27 -0700
> Joshua Washington <joshwash@google.com> wrote:
>
> > On Mon, Jun 29, 2026 at 10:38=E2=80=AFAM Stephen Hemminger
> > <stephen@networkplumber.org> wrote:
> > >
> > > On Sun, 28 Jun 2026 17:50:03 -0700
> > > Mark Blasko <blasko@google.com> wrote:
> > >
> > > > In AF_PACKET, the PMD reads the timestamp from socket ring headers
> > > > because the kernel stack processes the packet and allocates a socke=
t
> > > > buffer. Since the kernel stack and socket buffer allocation are byp=
assed
> > > > in AF_XDP, UMEM frames are given directly to the PMD, which
> > > > means the kernel never generates these socket headers. Also, it
> > > > looks like the TAP PMD doesn't support RX timestamps.
> > > >
> > > > Since the location of metadata in the UMEM headroom is determined
> > > > by the XDP program, the current driver implementation is coupled to
> > > > a specific XDP program layout. As an alternative, we could just
> > > > plumb the entire metadata headroom to the DPDK application and let
> > > > the application parse it based on whatever XDP program is in use.
> > > > That would couple the application and the XDP program, but would
> > > > at least decouple the driver and the XDP program.
> > >
> > >
> > > Sorry if I was not clear enough before.
> > > The DPDK PMD provides an abstraction to applications to avoid exposin=
g
> > > as many details as possible. Whenever possible a PMD should follow
> > > precedent and implement functions in a manner similar to other driver=
s.
> > >
> > > The method of expressing received timestamps was never well described
> > > in DPDK documentation. The convention is:
> > >   - A dynamic field in mbuf is used for the timestamp.
> > >   - All drivers using timestamp should register the same field
> > >     using rte_mbuf_dyn_rx_timestamp_register.
> > >   - The mbuf field is filled inside the rx_burst processing.
> > >   - The timestamp dynamic field is a 64 bit unsigned number rolling
> > >     clock value.
> > >   - A PMD providing timestamp, must also define a readclock ethdev de=
v ops
> > >     so that application can compute the number of ticks in timestamp =
per
> > >     time interval.
> > >   - A PMD providing timestamp must advertise that in offload flags.
> > >   - Timestamp should only be inserted if the Rx timestamp offload fla=
g
> > >     is set during configuration.
> >
> > These are all very good points for ensuring an airtight abstraction.
> > However, I'd like to note that neither of the kernel-bound PMD
> > interfaces (pcap, AF_PACKET) have support for the `read_clock` op. I
> > am not certain of the reason for this, but I suspect it's because
> > ethtool IOCTLs already cover that functionality. This patch's
> > implementation follows the other implementations pretty closely,
> > differing only in how the timestamp is extracted.
> >
> > >
> > > When I read this was a little confused about meta data in mbuf.
> > > Would have been clearer with a simple helper:
> > >
> > > static inline void
> > > af_xdp_rx_timestamp(struct rte_mbuf *m)
> > > {
> > >         const struct af_xdp_rx_metadata *meta
> > >                 =3D rte_pktmbuf_mtod_offset(m, struct af_xdp_rx_metad=
ata, -(int)sizeof(*meta));
> > >
> > >         *RTE_MBUF_DYNFIELD(m, timestamp_dynfield_offset, uint64_t *) =
=3D meta->rx_timestamp;
> > >         m->ol_flags |=3D timestamp_dynflag;
> > > }
> > >
> > > If you are going to do Rx timestamp then a simple readclock ethdev op
> > > is also needed to tell the application what the units are.
> > >
> > > But there are bigger issues with this patch:
> > > 1. The patch assumes metadata is always present in XDP receive but de=
vice
> > > used by XDP may not implement it. There is no capability checking.
> > > The DPDK PMD ends up advertising RTE_ETH_RX_OFFLOAD_TIMESTAMP
> > > unconditionally even if underling kernel device doesn't do it.
> >
> > The patch as submitted is incorrect; my apologies for that. I missed
> > it in review. The layout of XDP metadata is something which is
> > determined by the XDP program and consumed by an AF_XDP application
> > tailor-made for the XDP program. This means that the PMD itself would
> > not be able to process the RX timestamp from an XDP program on its
> > own; that functionality would have to be handled by the DPDK
> > application.
> >
> > >
> > > 2. The format of metadata is not a documented contract between kernel
> > > device implementing XDP and the DPDK.
> >
> > This is true. The contract lies between the XDP program and the AF_XDP
> > application, which can both be controlled by the DPDK application and
> > its invocation.
> >
> > >
> > > 3. The XDP documentation says you need to check for metadata
> > > in each frame.
> > >
> > > 4. There are no head bounds checks; must check that there is
> > > packet headroom is configured with enough space for metadata.
> > >
> > > I am sure AI will find several more things but need fixing
> > > before ready to merge.
> > >
> >
> > Unfortunately, I think that some amount of abstraction leakage is
> > unavoidable by the very nature of AF_XDP. What I propose is as
> > follows:
> >
> > Introduce a new PMD capability for processing XDP metadata. The mbuf
> > dyn_fields can store a pointer to the metadata and the size of the
> > metadata. The DPDK application processes the metadata as it sees fit.
> > As mentioned before, both the reader and the writer of the XDP
> > metadata are both controllable, and this would add the flexiblity for
> > one to use pre-existing DPDK mbuf infrastructure with minor
> > modifications to support this functionality, rather than introducing a
> > full rewrite using an AF_XDP application.
> >
> > Would this be acceptable?
>
> There needs to be an API that XDP PMD can call to check if underlying
> driver will add metadata; and another API to check that buffer has
> valid timestamp

I don't think the API to check if the driver has metadata support
exists, unfortunately. bpf_xdp_adjust_meta() is used to by XDP
programs to adjust the metadata pointer on a packet.

If xdp_md->data_meta > xdp_md->data then metadata isn't supported, and
the adjust call will fail. Otherwise, drivers have up to 256B of
metadata. What this means for the PMD is that it can read data_meta
and data pointers to decide if the metadata is valid on a per-packet
basis, and pass the metadata to the application when appropriate.

We were thinking to implement this via the vdev parameters passed in
as part of invoking the application. This solution would introduce
three new parameters:

1. `xdp_meta_valid_hint_offset` (byte offset of RX validity flag(s))
2. `xdp_meta_rx_ts_valid_mask` (mask to read if the RX timesamp is
valid. Mask covers a single byte.)
3. `xdp_meta_rx_ts_offset` (offset of RX timestamp in XDP metadata. RX
timestamp is assumed to be 8 bytes by kernel convention.)

modeled after xdp_metadata.h in the kernel. This solution would be
quite verbose, so I'm open to suggested improvements. If the valid
mask/hint offset are not passed in the invocation parameters, the
timestamp would be assumed valid if the metadata is valid and has
enough bytes available to feasibly read the timestamp value at the
intended offset.
