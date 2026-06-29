Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3943C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 00:50:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDD0D4021E;
	Mon, 29 Jun 2026 02:50:16 +0200 (CEST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45]) by mails.dpdk.org (Postfix) with ESMTP id C82E0400D7
 for <dev@dpdk.org>; Mon, 29 Jun 2026 02:50:15 +0200 (CEST)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c1226a0971bso338844266b.2
 for <dev@dpdk.org>; Sun, 28 Jun 2026 17:50:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782694215; cv=none;
 d=google.com; s=arc-20260327;
 b=RptHK59IM4QZ0ZIvz4X2mxif6foBKQ5qbDjoI/Z2Q6bC6ATYlc9jqMwmKLjDPOBbtI
 vzKFb8HGXg6gQzrvL+hSpZlQK5tOD3sk8+HxwR3NmsOLHGNTVYOF1DAjWZglV4QcF/RE
 sOz5UwOyL/phk1GlmhOywUrdtj8IfNjcSOFBzwIFx5RNHLbTenJgq2u8I56p/7IyZdiO
 YUGHvxtNkJNimlvIOP65n7yXsMZ0pQvpx6kHD4E1CJKk/buBctjzC5pgvNEc/G+a+4NA
 aQUACHzFP71oHb5v7RfqAI/qCb9SVudF/oh36vQnLUZuOJXsQZTTrk4B2MVKqQgNDok7
 XKXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ppolaauL9ltVLxKmp5g/G0OtTohe5g2AXtkR3Crkz70=;
 fh=HSijNpQ/6VqnayJFScKlg4GqFhBJb9b2mdSkal+NNpw=;
 b=TLg5kRkn/tFyz8pE98BeswMN+8KTJ5gU4WH7tB6XgGIrZzj1mP/YviDIj0QoUbmBrL
 qYP4tKvXVXhlnzl0alzBZqZ5pEx0LHLFCPy9XYMLCW3s6fzWqNjigCfDzjFFpiyaJl2I
 lLv2cynpv0Yoo/j9kBFueEb+I5S5Bd3gX9Lrkk6PeAFX0boLcb7jxzVP87rI5UTYPPEJ
 VYHjPUloNXL2h1H7jo4N4mSNvjLFyPW1I7hMS7VVl8nLf5c2C5kmoSpw6fsxLtOR++n6
 EwH2HPP5igw3sEmCNwJpyRsqJA7QUF3DzACMoLz9BqUiGo++jYU0nmifagUqwPciHzBM
 fJ8g==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782694215; x=1783299015; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ppolaauL9ltVLxKmp5g/G0OtTohe5g2AXtkR3Crkz70=;
 b=d/XclgezaaMEmSwsOq+/qhulx7N8R+Dt69D/5BwUWbVhmRvJalSGqfpAgN5xo4nQo6
 O2SdYa+RGMYQPbD7Q5eqrNoXdKRlKaunDOiON1K60hLCyFiajV5LcepDbg1C18t214YH
 FxOTqIj/X7B7WGTDwXKNXF1mN13kdmj1eEXymz99LGM25LUjfjtI9YdI1TJHwteLv1X4
 uizG34zY84HjgglI3XjK4NPEabViswS1r2L1GUGoXfjT9sbD6nD/C6kz0EfstPFHnOYn
 NiNaepXLYWbrcy/i6KwXMRYk0dsDGduWqcgcWN8g1ZsyoyuR/6KtunMmdIhq+fvh62ZQ
 +4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782694215; x=1783299015;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ppolaauL9ltVLxKmp5g/G0OtTohe5g2AXtkR3Crkz70=;
 b=Pvq1oc1SqCruCHqNXnFMtf0CY8AfnV9/I3rXSAZdchruCLNE5Q2+til3DKeU8oaivC
 2HT3tMjdhMCAErTEH1DbL0xFXd8qwcGZxwUgNUjVWX/hN/gZZdV5jrhHIV/C+Q0zqQUu
 HKW+3SH9X7CbFqqB3r6NuL4bLR5AUNdMv7a6jtJw1UpYrmpjVz+gBCC6KpNNXiINX37H
 x4dwz447KTHQ7HoC3p0P46yTjBDUJtkdrI8N/u0zPqjcpC8FWeJP8bSR49dHpZ87uImP
 WOZ7+bJF0gegJU6b+EHELNmyJEGsyaCM066Jlwi4kr7rXHKQgX96ByX4Xd2cnhUV1cl5
 c1Qw==
X-Gm-Message-State: AOJu0Yy81fAkd1D8loltzaHf/Quo+OcaTg5BSrWaFQnBTdvLmlhjNTQR
 IUAjDh70ZA8lWAwHMAZnmPDwp0+LXOFLiqcObWl9dVuDyndYTo2i0H6hSfMYV6R1vY5RR7cvsMk
 7TDMV/0ZhRXv5EkgxgcMJnZ7PxYOB9XpWzqbA7T5P
X-Gm-Gg: AfdE7cn1kU3mPsG4zu9aop9cwdm9S1UPHuHIIemp0Y0p3N+/LKfeVGHx4ZuvpKu3J0t
 NqFA4mZjzHIoUy9r1ABEH+g7KRN5D/hDIIvdeYpCpTuikJogKUWY9FoUteL1Br+bMX6jOJVOzlT
 A16wMZLI3BYIZn11dRwWuMbZifLLlfJyaG8nlgk2+G3h933VFROlQCA8n381txOv7B5qgrAucFN
 yU3EjqOOwt7yHFEqijEABX1CADgsg7g5bpCqkK+DT6xRacDVaqTNu5CzDcdDL6ig+1oD/ebLLkd
 Sz4hlv2dneRPokd7RtPj0sJHB/5PBHZN4PP27JOheNsD0hfG1zld6m+LH0o2QV61k9BYe8j67g=
 =
X-Received: by 2002:a17:907:c14:b0:c12:6121:e609 with SMTP id
 a640c23a62f3a-c126121e8e8mr112455966b.8.1782694214663; Sun, 28 Jun 2026
 17:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260623215325.814776-1-blasko@google.com>
 <20260623150638.266d8574@phoenix.local>
In-Reply-To: <20260623150638.266d8574@phoenix.local>
From: Mark Blasko <blasko@google.com>
Date: Sun, 28 Jun 2026 17:50:03 -0700
X-Gm-Features: AVVi8Cej5M57iemMrGBQjTq-OxyCtr8n4pj1n6AqitCEdc5VQ5tghguQsvCzEYY
Message-ID: <CANULgnK9-P5dQtTPayiFD7PLor=1qV=7du-AtRuWGPd4F5SmAQ@mail.gmail.com>
Subject: Re: [PATCH] net/af_xdp: add Rx metadata and dynamic timestamping
 support
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Ciara Loftus <ciara.loftus@intel.com>, 
 Maryam Tahhan <mtahhan@redhat.com>, Joshua Washington <joshwash@google.com>, 
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

In AF_PACKET, the PMD reads the timestamp from socket ring headers
because the kernel stack processes the packet and allocates a socket
buffer. Since the kernel stack and socket buffer allocation are bypassed
in AF_XDP, UMEM frames are given directly to the PMD, which
means the kernel never generates these socket headers. Also, it
looks like the TAP PMD doesn't support RX timestamps.

Since the location of metadata in the UMEM headroom is determined
by the XDP program, the current driver implementation is coupled to
a specific XDP program layout. As an alternative, we could just
plumb the entire metadata headroom to the DPDK application and let
the application parse it based on whatever XDP program is in use.
That would couple the application and the XDP program, but would
at least decouple the driver and the XDP program.

On Tue, Jun 23, 2026 at 3:06=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue, 23 Jun 2026 21:53:24 +0000
> Mark Blasko <blasko@google.com> wrote:
>
> > +             if (rxq->rx_timestamp_enabled &&
> > +                 timestamp_dynfield_offset >=3D 0) {
> > +                     struct af_xdp_rx_metadata *meta;
> > +
> > +                     meta =3D (struct af_xdp_rx_metadata *)
> > +                             ((char *)rte_pktmbuf_mtod(bufs[i], void *=
) -
> > +                              sizeof(struct af_xdp_rx_metadata));
> > +                     *RTE_MBUF_DYNFIELD(bufs[i],
> > +                                        timestamp_dynfield_offset,
> > +                                        uint64_t *) =3D meta->rx_times=
tamp;
> > +                     bufs[i]->ol_flags |=3D timestamp_dynflag;
> > +             }
> > +
>
> Why does XDP time stamp need to be different than how other drivers
> already do timestamps. See AF_PACKET and TAP device?
>
> Should not be driver specific here.
