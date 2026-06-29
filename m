Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA15C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 20:03:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A5D640150;
	Mon, 29 Jun 2026 22:03:36 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id B6A5D400D5
 for <dev@dpdk.org>; Mon, 29 Jun 2026 22:03:34 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-139b914bab6so5090590c88.1
 for <dev@dpdk.org>; Mon, 29 Jun 2026 13:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782763414;
 x=1783368214; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b+HrPqQuyZye8l+l0MYTPA5OJ+zxkTAW0YoWaeqEmtQ=;
 b=uTyVqUe/q1Vs/pDlkXShsDPl+OURHDGFlFT8dU8tFBPuTUBaLZRKqeQRHrYDx08Gc0
 PaSJ8tLXj0nb75qYhB3Gn5lt2ag3U6OYYI3wBaIoviAc6W45KM18uWD0kr1F6iQmEh6j
 hluiL8CXvJ6+NU8+RAITc0y9t5elEHhBw7jL/R4LUC3UrFYWuK5mUDSR/AgGOtSrMt9+
 Lq5KTmBxcKs5qgH2E6cgUzHuaZbbG2Cmr6Q5f/ZHbNyZiM+15aplaE/K81mZsqjOZffT
 mvjI2xfo7V96J9WKu28VyM5rxNzGNwmbUncnGhpLE7FOT4zapYeCSkS9cPdS/94A6lwl
 BTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782763414; x=1783368214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b+HrPqQuyZye8l+l0MYTPA5OJ+zxkTAW0YoWaeqEmtQ=;
 b=LftU3I9a2v68mr3KJINuMsnVcHHXwG2EkStI3JqVA/nmjseA7cpexo3gIIwaelbGFp
 FjpQL5JNEcOJc7OrRIXGpFvDiJMlysOUdhw7pdYxj8y6GUMDKQLDyLOmhWz1nX9jrQuf
 Cba77rHFY4sV8sZdm+48PSP2HjUbv+NdpShfP7+ji/q6YlTSVqDGPK8czbFQhKDS9ltz
 /fW6+ZfVndcBvI4Cb0ipLVoD0+urJQNVGGHjIqQ3OogJNE0ekL8v3gt4gBus+MssOSYh
 mZur6KDFgpiUPSkksxWitBxblD6GgWk5zC62TAP58L7uFmvWeFYLoZpwWuTCjGdJ34TB
 BQ8w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ks0DNIpvxYgjbOHzcci75qYTlP/saUlAFDktlWLMh4LEAEqxrFMKnJXCfYR8vYkcbq7g=@dpdk.org
X-Gm-Message-State: AOJu0Yy8iEtXjRsmoCpPpSwHAlKKi4sW+Wkx54EVvjGHbhYTCM8S9ljV
 w2lkILggLTpYnKJ30F5PUN+I1XYVp8a7DfBbeJ2CX2lyj19swK9kcn2xQd5Yde5JJoQ=
X-Gm-Gg: AfdE7ck2GY2K+/87lCjNWoJqIQ0tRd3oIdp6c8ckhBTamZYQzJVsxRHf2OaPyly2251
 szK9kbW3NhwqWMAe5rIHs5Jh6pzWP9P31aXupje+D+IHIYATEr2SUNdSSVR5hdg1IcXvpet5v6t
 14uXscdjbd0M22t1y8s1kEail2/Lafepg0otjS0nZm/wB6pI1gkG50FJwHOcODoFUMRT/W5Dtp3
 5UEMhEHA3NJq4Oneoa4IfyrTh81U7kXlOGIiBcOvp1pHyzFYVcMCTmIXMDGXp3YcjNi253A2bwE
 g9HgwIN8zgUOmcpzmH3iaYA8tnhbuWLzvdPULGMcn07yw5SMbAflIQzD/SyMuRb/bydJ1jGcpM/
 Yff878FIvllan/Txx5SzoeItE9WV+iPLdQB/fgLfOxfxUvJVszLqQAGMWRlHnuHaN10GiNleQjV
 hVnh5D851Lf3bReZ7bkFZxxTzoLAIP3jYky/hE9O6L0dtdW47Qdmqy6w==
X-Received: by 2002:a05:7022:688e:b0:128:cf80:deea with SMTP id
 a92af1059eb24-13b2a13f5ebmr542256c88.1.1782763413483; 
 Mon, 29 Jun 2026 13:03:33 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm710586c88.7.2026.06.29.13.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 13:03:32 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:03:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Joshua Washington <joshwash@google.com>
Cc: Mark Blasko <blasko@google.com>, dev@dpdk.org, Ciara Loftus
 <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>, "Jasper Tran
 O'Leary" <jtranoleary@google.com>
Subject: Re: [PATCH] net/af_xdp: add Rx metadata and dynamic timestamping
 support
Message-ID: <20260629130330.2bd6a3cf@phoenix.local>
In-Reply-To: <CALuQH+W4wPA5ygZ63pcQrCD-Uz_K1AsN9n+fzX+ESarmaHnmrA@mail.gmail.com>
References: <20260623215325.814776-1-blasko@google.com>
 <20260623150638.266d8574@phoenix.local>
 <CANULgnK9-P5dQtTPayiFD7PLor=1qV=7du-AtRuWGPd4F5SmAQ@mail.gmail.com>
 <20260629103804.3d4154bb@phoenix.local>
 <CALuQH+W4wPA5ygZ63pcQrCD-Uz_K1AsN9n+fzX+ESarmaHnmrA@mail.gmail.com>
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

On Mon, 29 Jun 2026 12:10:27 -0700
Joshua Washington <joshwash@google.com> wrote:

> On Mon, Jun 29, 2026 at 10:38=E2=80=AFAM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Sun, 28 Jun 2026 17:50:03 -0700
> > Mark Blasko <blasko@google.com> wrote:
> > =20
> > > In AF_PACKET, the PMD reads the timestamp from socket ring headers
> > > because the kernel stack processes the packet and allocates a socket
> > > buffer. Since the kernel stack and socket buffer allocation are bypas=
sed
> > > in AF_XDP, UMEM frames are given directly to the PMD, which
> > > means the kernel never generates these socket headers. Also, it
> > > looks like the TAP PMD doesn't support RX timestamps.
> > >
> > > Since the location of metadata in the UMEM headroom is determined
> > > by the XDP program, the current driver implementation is coupled to
> > > a specific XDP program layout. As an alternative, we could just
> > > plumb the entire metadata headroom to the DPDK application and let
> > > the application parse it based on whatever XDP program is in use.
> > > That would couple the application and the XDP program, but would
> > > at least decouple the driver and the XDP program. =20
> >
> >
> > Sorry if I was not clear enough before.
> > The DPDK PMD provides an abstraction to applications to avoid exposing
> > as many details as possible. Whenever possible a PMD should follow
> > precedent and implement functions in a manner similar to other drivers.
> >
> > The method of expressing received timestamps was never well described
> > in DPDK documentation. The convention is:
> >   - A dynamic field in mbuf is used for the timestamp.
> >   - All drivers using timestamp should register the same field
> >     using rte_mbuf_dyn_rx_timestamp_register.
> >   - The mbuf field is filled inside the rx_burst processing.
> >   - The timestamp dynamic field is a 64 bit unsigned number rolling
> >     clock value.
> >   - A PMD providing timestamp, must also define a readclock ethdev dev =
ops
> >     so that application can compute the number of ticks in timestamp per
> >     time interval.
> >   - A PMD providing timestamp must advertise that in offload flags.
> >   - Timestamp should only be inserted if the Rx timestamp offload flag
> >     is set during configuration. =20
>=20
> These are all very good points for ensuring an airtight abstraction.
> However, I'd like to note that neither of the kernel-bound PMD
> interfaces (pcap, AF_PACKET) have support for the `read_clock` op. I
> am not certain of the reason for this, but I suspect it's because
> ethtool IOCTLs already cover that functionality. This patch's
> implementation follows the other implementations pretty closely,
> differing only in how the timestamp is extracted.
>=20
> >
> > When I read this was a little confused about meta data in mbuf.
> > Would have been clearer with a simple helper:
> >
> > static inline void
> > af_xdp_rx_timestamp(struct rte_mbuf *m)
> > {
> >         const struct af_xdp_rx_metadata *meta
> >                 =3D rte_pktmbuf_mtod_offset(m, struct af_xdp_rx_metadat=
a, -(int)sizeof(*meta));
> >
> >         *RTE_MBUF_DYNFIELD(m, timestamp_dynfield_offset, uint64_t *) =
=3D meta->rx_timestamp;
> >         m->ol_flags |=3D timestamp_dynflag;
> > }
> >
> > If you are going to do Rx timestamp then a simple readclock ethdev op
> > is also needed to tell the application what the units are.
> >
> > But there are bigger issues with this patch:
> > 1. The patch assumes metadata is always present in XDP receive but devi=
ce
> > used by XDP may not implement it. There is no capability checking.
> > The DPDK PMD ends up advertising RTE_ETH_RX_OFFLOAD_TIMESTAMP
> > unconditionally even if underling kernel device doesn't do it. =20
>=20
> The patch as submitted is incorrect; my apologies for that. I missed
> it in review. The layout of XDP metadata is something which is
> determined by the XDP program and consumed by an AF_XDP application
> tailor-made for the XDP program. This means that the PMD itself would
> not be able to process the RX timestamp from an XDP program on its
> own; that functionality would have to be handled by the DPDK
> application.
>=20
> >
> > 2. The format of metadata is not a documented contract between kernel
> > device implementing XDP and the DPDK. =20
>=20
> This is true. The contract lies between the XDP program and the AF_XDP
> application, which can both be controlled by the DPDK application and
> its invocation.
>=20
> >
> > 3. The XDP documentation says you need to check for metadata
> > in each frame.
> >
> > 4. There are no head bounds checks; must check that there is
> > packet headroom is configured with enough space for metadata.
> >
> > I am sure AI will find several more things but need fixing
> > before ready to merge.
> > =20
>=20
> Unfortunately, I think that some amount of abstraction leakage is
> unavoidable by the very nature of AF_XDP. What I propose is as
> follows:
>=20
> Introduce a new PMD capability for processing XDP metadata. The mbuf
> dyn_fields can store a pointer to the metadata and the size of the
> metadata. The DPDK application processes the metadata as it sees fit.
> As mentioned before, both the reader and the writer of the XDP
> metadata are both controllable, and this would add the flexiblity for
> one to use pre-existing DPDK mbuf infrastructure with minor
> modifications to support this functionality, rather than introducing a
> full rewrite using an AF_XDP application.
>=20
> Would this be acceptable?

There needs to be an API that XDP PMD can call to check if underlying
driver will add metadata; and another API to check that buffer has
valid timestamp
