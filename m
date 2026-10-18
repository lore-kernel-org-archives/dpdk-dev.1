Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A808DCCF2D6
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 11:47:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A758A40B99;
	Mon, 19 Oct 2026 13:47:11 +0200 (CEST)
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49]) by mails.dpdk.org (Postfix) with ESMTP id 98C4E402E5
 for <dev@dpdk.org>; Sun, 18 Oct 2026 09:54:15 +0200 (CEST)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-679a2b540f3so1066714d50.2
 for <dev@dpdk.org>; Sun, 18 Oct 2026 00:54:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792310055; cv=none;
 d=google.com; s=arc-20260327;
 b=fWGHrZi/0C3tHJVYUrbcTQiaR2sZD3K5Sy8IVpb+Xq6FLBjYz0yxIA1xjaocQP2ysH
 X27WZGfFtkFbBHYjp4pCvlL7BFisbBYXTwFflBrkiOQnD4YehnUe7dVuzaMQI313hAF4
 r+C965fFlZqihF2S9C201CnpxDNWl2HW7tTj9e0gMxw3bPwkCRFH5rR37bZB1EMkYbGU
 I7ApfJR3qoEQS5pODmUkQcBEotxpvB1nUHkxPX1wQ85Xph3FCBrDQFEbPnB9vjk5cMOy
 PM0oe8tXr50PXTvxfl7tNiI/hs3X9ZWZ/cEgHjCHv5/e26Ll4ItaZbqDJ6eZz0/i2oOB
 riqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eUsM5pXVZRduXPjcLLSPdj54HppxlbyGmaKefyMYxqg=;
 fh=3EfnXR95Cmc6T0jOexbH6qke+TMrFA4KwpuScv1nipc=;
 b=Q/N+/tTOxnHo8G2z+ghYvF7YN4PcjCFWi17bZbAuKHz1u8DYwhYu/cYw1uHFBxEqQK
 Z6j0TlewQeXUrQL/xsQQxKQr47TorWCwM2o2beygXyQdwTffQ8+NuGYInOEsaj+2gkA2
 Ki3cu7AhwR3MFy7usAjLoLNHazdATGAbLs9swZ5oGtgXVLwv3V1io1i7SzBlDTWsAZ3g
 7UgWojFck7QHioOenZPZ8qAFlq1EQ7i1HZ8L25Fdhll/7yFXBl/7EZxpYkhlVZ29bRi1
 trXgZO7RHU7YY7SkUPbIAgWYBvQpXDfYkY7P1jYi6qAncgM/XusJh4fdCwmUiN2QX4Ly
 rsTQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792310055; x=1792914855; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eUsM5pXVZRduXPjcLLSPdj54HppxlbyGmaKefyMYxqg=;
 b=bw3ROdPr8DEaIzF8RG0vc92qPnhwFUww9DQTx4ozE88TVbro6VU6uPbGxTWlAGIPoN
 WIVL8YS1xuqtDwK5xjLJhoJmxDavdGCXR4eN91L/I65+dKWV4Ij8jfxoRoYOYjjvxwA1
 aPdsQlh6qUhvbsehmcMPvvhN6hr5V2rg2WVkZdYbo4kjujmOj5Tloi/pKIqFetlIOdii
 WGx6g+s8wIEuE6Dq36jHcYjp+JbmYpnyIdybqhuYt6LRQwNTBVctuy+9ZKFsKUoIXAy/
 Qm7vyZ3iac4rCUhg+gk5wLdo3U1YvnQ41mjSKlKebY56Wllu7EoKaLasqvU00y2Jr3oI
 o72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792310055; x=1792914855;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eUsM5pXVZRduXPjcLLSPdj54HppxlbyGmaKefyMYxqg=;
 b=eIJMRis1KAccZ0nF0AoUkFhgi6YYOI3wjcdJ5i621Y/sczrYVSlhdOKy+ugGsaDrJ6
 QIF8TIS6LyPabePu2Y0XODqe2okg9S71qTCmpODAKTPMq1ZdGfPpSnydPD3I2Q3YIx43
 aXnNvGJhE2/Rkj5wmy4nodLiraKBtJ0VsQHrFaCiXzOULlRGH5jAExtM4370Fl5pfj+B
 XrNftdTdDqjnmJhn0gY7nHwkGWtGX93yJUCBnBEzHR6gC4moMf90+XgiZGFl8twqtfJV
 Kgt5ck+M4YJCdSxvSEBUj2qfxhHD5TnjiG4Um+0lKPA6LyPQEiS+560HSJ5Z8JkJss/L
 iKrQ==
X-Gm-Message-State: AFq9FYIv5lHqZSkdoahNv65PJlyNfT9vLKsNtOZkmav7xIbyy+rMBxbT
 rVkI7I7pWaPKZBrsdKscTpjzsKQNvagpf2n61qVzOoYYFUS2TWHjAl7rPYo9DwBLAIrV/6LUedg
 UtwDd040/aRdq9xoELU5tIzlrrhmljy4=
X-Gm-Gg: AYBFou1fEGJ7OXNCyCn2FNp+K+AEzDK47RKtcwGizqirkFTDcTGwLlLAQtZpXKrBGAn
 OzCISuWsdNPzXJjCmJBpFzttpatRI3us98spAJgBLoo2U3ZfYvdPgw2i446rdO38/F4SnBfDkjh
 pLc44SRzq09cT6RQhGjTE0wjLz/QdHFNnge1nyazyrvov18JfC8PnF5vHNvQeiTMjQHVE4ewPBb
 AlaFrxQkyclk5kTIImXU0vQzzpWRocYqkKuyjElA3MrD/EDXxFH2JctxJLmzZNSYiOElljKFQb/
 7x38M9H2fHxmT3NzBJ6tGy1rJaZKL0wGYq2Sigi6VfMePLsZKXVQjys+hvPWYoM2wq7E+tfthH2
 mxbvMee5Zv9HwBg==
X-Received: by 2002:a05:690e:134e:b0:679:ab13:5526 with SMTP id
 956f58d0204a3-679ca8989a0mr1232090d50.75.1792310054698; Sun, 18 Oct 2026
 00:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1792170902.git.tathagat.dpdk@gmail.com>
 <af059fd5b4297695fc4f2fc84236f7d71a71a630.1792170902.git.tathagat.dpdk@gmail.com>
 <CALuQH+WpkTCK6jSgYc0RrdSmV_3MUJ0W8=mrn9wpgQGJRRongw@mail.gmail.com>
In-Reply-To: <CALuQH+WpkTCK6jSgYc0RrdSmV_3MUJ0W8=mrn9wpgQGJRRongw@mail.gmail.com>
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Date: Sun, 18 Oct 2026 13:24:03 +0530
X-Gm-Features: AclHuK-Xi7XMlLARqcFJTOQDqBo9M0sl1YqbQ-HuRuvyTqD8XyHvK2oVXXOsJNo
Message-ID: <CA++LmPX3NA0=qOs=p7m8=4Zxq-=gLdgMJA=EKJy=SxNKysqfwQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] net/gve: enforce DQO Tx packet length limits
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 stable@dpdk.org, 
 Jeroen de Borst <jeroendb@google.com>, Rushil Gupta <rushilg@google.com>, 
 Junfeng Guo <junfengg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 19 Oct 2026 13:47:02 +0200
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

On Fri, Oct 16, 2026 at 11:52=E2=80=AFPM Joshua Washington <joshwash@google=
.com> wrote:
>
> On Fri, Oct 16, 2026 at 10:46=E2=80=AFAM Tathagat Priyadarshi
> <tathagat.dpdk@gmail.com> wrote:
> >
> > The device requires non-TSO packets to be 17 to 9728 bytes long, as
> > noted in the Linux driver, but packets of any length are posted. The
> > device treats an out-of-range packet as coming from a malicious
> > driver: it drops the packet and disables the datapath, stalling all
> > queues.
> >
> > Drop such packets in the driver and count them in a new invalid_pkts
> > counter.
> >
> > Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
> Acked-by: Joshua Washington <joshwash@google.com>
> > ---
> >  drivers/net/gve/base/gve_desc_dqo.h |  2 ++
> >  drivers/net/gve/gve_ethdev.c        |  1 +
> >  drivers/net/gve/gve_ethdev.h        |  1 +
> >  drivers/net/gve/gve_tx_dqo.c        | 17 +++++++++++++++++
> >  4 files changed, 21 insertions(+)
> >
> > diff --git a/drivers/net/gve/base/gve_desc_dqo.h b/drivers/net/gve/base=
/gve_desc_dqo.h
> > index c1534959c2..d50d88765e 100644
> > --- a/drivers/net/gve/base/gve_desc_dqo.h
> > +++ b/drivers/net/gve/base/gve_desc_dqo.h
> > @@ -12,6 +12,8 @@
> >
> >  #define GVE_TX_MAX_HDR_SIZE_DQO 255
> >  #define GVE_TX_MIN_TSO_MSS_DQO 88
> > +#define GVE_TX_MIN_PKT_SIZE_DQO 17
> > +#define GVE_TX_MAX_PKT_SIZE_DQO 9728
> >
> >  /* Basic TX descriptor (DTYPE 0x0C) */
> >  struct gve_tx_pkt_desc_dqo {
> > diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.=
c
> > index 1dfbe8f396..53b0a0ec63 100644
> > --- a/drivers/net/gve/gve_ethdev.c
> > +++ b/drivers/net/gve/gve_ethdev.c
> > @@ -1044,6 +1044,7 @@ static const struct gve_xstats_name_offset tx_xst=
ats_name_offset[] =3D {
> >         { "errors",  TX_QUEUE_STATS_OFFSET(errors) },
> >         { "too_many_descs", TX_QUEUE_STATS_OFFSET(too_many_descs) },
> >         { "invalid_mbufs", TX_QUEUE_STATS_OFFSET(invalid_mbufs) },
> > +       { "invalid_pkts", TX_QUEUE_STATS_OFFSET(invalid_pkts) },
> >  };
> >
> >  static const struct gve_xstats_name_offset rx_xstats_name_offset[] =3D=
 {
> > diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.=
h
> > index 66cb31dadb..be744d955b 100644
> > --- a/drivers/net/gve/gve_ethdev.h
> > +++ b/drivers/net/gve/gve_ethdev.h
> > @@ -115,6 +115,7 @@ struct gve_tx_stats {
> >         uint64_t errors;
> >         uint64_t too_many_descs;
> >         uint64_t invalid_mbufs;
> > +       uint64_t invalid_pkts;
> >  };
> >
> >  struct gve_rx_stats {
> > diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.=
c
> > index 46a03d482d..f686a8c110 100644
> > --- a/drivers/net/gve/gve_tx_dqo.c
> > +++ b/drivers/net/gve/gve_tx_dqo.c
> > @@ -123,6 +123,17 @@ gve_tx_clean_descs_dqo(struct gve_tx_queue *txq, u=
int16_t nb_descs) {
> >                 gve_tx_clean_dqo(txq);
> >  }
> >
> > +/* Validate packet lengths against the device limits. */
> > +static inline bool
> > +gve_tx_validate_pkt(const struct rte_mbuf *tx_pkt, bool is_tso)
>
> Minor nit (not worth blocking over, but maybe can be done as the
> patches are being merged): can this be renamed to
> gve_tx_validate_pkt_len? This is one step of many in the packet
> validation pipeline.

Thanks for the review, Joshua. Agreed on renaming to gve_tx_validate_pkt_le=
n.
This change impacts patches 9/10 and 10/10. I am happy to submit a v5
series if preferred,
or the maintainer can rename it upon applying.

>
> > +{
> > +       if (!is_tso)
> > +               return tx_pkt->pkt_len >=3D GVE_TX_MIN_PKT_SIZE_DQO &&
> > +                      tx_pkt->pkt_len <=3D GVE_TX_MAX_PKT_SIZE_DQO;
> > +
> > +       return true;
> > +}
> > +
> >  /* Max descriptors a single packet may use. A larger packet can never =
pass
> >   * gve_can_tx(): one slot is always reserved, the cacheline overlap ma=
rgin
> >   * must stay free, and up to GVE_TX_MIN_RE_INTERVAL - 1 descriptors po=
sted
> > @@ -306,6 +317,12 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf *=
*tx_pkts, uint16_t nb_pkts)
> >                 tso =3D !!(ol_flags & RTE_MBUF_F_TX_TCP_SEG);
> >                 csum =3D !!(ol_flags & GVE_TX_CKSUM_OFFLOAD_MASK_DQO);
> >
> > +               if (!gve_tx_validate_pkt(tx_pkt, tso)) {
> > +                       txq->stats.invalid_pkts++;
> > +                       rte_pktmbuf_free(tx_pkt);
> > +                       continue;
> > +               }
> > +
> >                 nb_descs =3D gve_tx_pkt_nb_data_descs(tx_pkt);
> >                 nb_descs +=3D tso;
> >
> > --
> > 2.43.0
> >
