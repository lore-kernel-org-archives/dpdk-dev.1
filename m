Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E4EFD531B
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 09:23:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C07F04068E;
	Fri, 27 Feb 2026 10:23:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 52D304067C
 for <dev@dpdk.org>; Fri, 27 Feb 2026 10:23:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772184225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xtp1AYAR8bPq+/f5kjMXNEIDRQOlnCRCzFgTjzclSDQ=;
 b=VtnD5vd0zTsdGHXIDRbNnaOckHtJP7hueYlEyie+6/dGL+BQkgWNbsQ3FQKJyi/DJHPuSf
 r5cLeU2lwF6niO55BnYKdSdl3VSca6GYGSaDOouriV1fE72+4nPzoHc610wiDM1wGGlfOS
 oXoNuUy+TGwtQO2jT3V0l/sVaPKX0xI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-8XzJm_2HOf6WDYqU4C1XMQ-1; Fri, 27 Feb 2026 04:23:43 -0500
X-MC-Unique: 8XzJm_2HOf6WDYqU4C1XMQ-1
X-Mimecast-MFC-AGG-ID: 8XzJm_2HOf6WDYqU4C1XMQ_1772184222
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-38704a51eddso15518361fa.1
 for <dev@dpdk.org>; Fri, 27 Feb 2026 01:23:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772184222; x=1772789022;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xtp1AYAR8bPq+/f5kjMXNEIDRQOlnCRCzFgTjzclSDQ=;
 b=kUibvlT30+Lhm014ds+jng15EveoxAq5Ux5RuALu6MIqsGsbw3iM7LfWdHsNXA8svg
 pKl+G5Z8vyngEXpMszgi74DqaebDmAtPJxN1kNiiiZTJVadzNn8I8tC1ZJTuzB9mo4Q8
 i6bxKuW5+uCtDSMTmNl/JN0yBhMKldm7/eSev2eaiBQXWR9HIIV3n2NQo2iUnYJcKteR
 btAnC8rxJ7uiHXrgVuc6805WGFRMiU2j7Gtf9hlvnT5LNsTgH1japlQFh1XhRBVu3lhh
 sbcKVqe1YF7I0eE9ZHUnsmVB6zkWBNDxBKgj8WqLjQ284MrA8xEquGncewNmXDw/1pXC
 b3Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSGI/HrZKfV2QlGBIUYRlYP00E+hQ4TW1n5/viCEokApMtZ+5zzJCyGNvB+Qrjikguc5s=@dpdk.org
X-Gm-Message-State: AOJu0YxSGfj13ftfzn97k93Mic7LdGmgs5juB1vl/Va/gos25HSiqquN
 kVQ/aJpI9SJoouYZSQv23T5cSDPiS5Tbho8YX76PfweL4vegCWBKeqVlSw9MN1r8uvmgsfk3M2H
 B/kVf7IuIrJys+PoBfYDpz0uszB18tOFK7zGH0Vu1qJBAu+23npD14nInFOH8GcSFuarOyCCJHV
 I6bu0/wfpuAcpmdzFYvJs=
X-Gm-Gg: ATEYQzxpPnA/LN2Me4nz16Oo9ER/WDzk1yq0sC68eGvf6fpbE1/O+VRl0PMGom0sZzf
 iwa4pKvtk9XYmsSituQNxcPbo0upbJy/D1CZ+6TMJYLUMqtI/gs9ET6Ug8f5BnQv+qu7FaVLcUs
 DSDDOU+JbXvBWUBoGOC9Boa4JwKP2POIeYtZCh8ViPwYUstBqtIdMT19HSBBiwt5zmA8YNv8ZRc
 05Etf9ORn5RtW1igz93dPDtm2s6v2d9uja8tGoGBIdBQDOe3nISIc1eaXTFLHzSM9eXPw==
X-Received: by 2002:a2e:b907:0:b0:389:e2e8:4f4c with SMTP id
 38308e7fff4ca-389f1e3756fmr18443891fa.21.1772184222137; 
 Fri, 27 Feb 2026 01:23:42 -0800 (PST)
X-Received: by 2002:a2e:b907:0:b0:389:e2e8:4f4c with SMTP id
 38308e7fff4ca-389f1e3756fmr18443731fa.21.1772184221660; Fri, 27 Feb 2026
 01:23:41 -0800 (PST)
MIME-Version: 1.0
References: <20260218160453.142311-1-maxime@leroys.fr>
 <20260226143341.282188-12-maxime@leroys.fr>
 <20260226112154.7b2c51d0@phoenix.local>
In-Reply-To: <20260226112154.7b2c51d0@phoenix.local>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 27 Feb 2026 10:23:30 +0100
X-Gm-Features: AaiRm53_udQ5f5BbcNyoTQom8fGC0CMuw8XUNwHF4S6w04HTq5QzLqeBDQsV6Zw
Message-ID: <CAJFAV8z0L-KLsNq6JCgaWsEmEaWUqH1rcH_rHcwWVkVisUAMfA@mail.gmail.com>
Subject: Re: [PATCH v2 11/17] net/dpaa2: fix software taildrop buffer access
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maxime Leroy <maxime@leroys.fr>, dev@dpdk.org, hemant.agrawal@nxp.com,
 stable@dpdk.org, =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l7WYtQaO_9opdRwmWcgkenWrWFzGC7dDyux-8v2mMzE_1772184222
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 26 Feb 2026 at 20:22, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Thu, 26 Feb 2026 15:33:35 +0100
> Maxime Leroy <maxime@leroys.fr> wrote:
>
> > The sw_td path in dpaa2_dev_tx() reads from the wrong position in the
> > bufs array. When the goto fires, bufs has already been advanced past
> > the num_tx successfully sent packets. The first loop then reads num_tx
> > more entries starting from bufs, going past the end of the input array.
> > Additionally, the buf_to_free segments for already-enqueued packets
> > are never freed, leaking memory.
> >
> > Replace the buggy sw_td code with the same pattern used in
> > dpaa2_dev_tx_ordered(): free buf_to_free segments first, then use
> > rte_pktmbuf_free_bulk() to drop remaining unsent packets.
> >
> > Not tested, found by code review.
> >
> > Cc: stable@dpdk.org
> > Fixes: c3ffe74d85be ("net/dpaa2: support software taildrop")
> >
> > Reported-by: Stephen Hemminger <stephen@networkplumber.org>
> > Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> > ---
> >  drivers/net/dpaa2/dpaa2_rxtx.c | 18 ++++++------------
> >  1 file changed, 6 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
> > index 689e5e7ee7..8275ba9780 100644
> > --- a/drivers/net/dpaa2/dpaa2_rxtx.c
> > +++ b/drivers/net/dpaa2/dpaa2_rxtx.c
> > @@ -1517,21 +1517,15 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
> >
> >       return num_tx;
> >  sw_td:
> > -     loop = 0;
> > -     while (loop < num_tx) {
> > -             if (unlikely(RTE_MBUF_HAS_EXTBUF(*bufs)))
> > -                     rte_pktmbuf_free(*bufs);
> > -             bufs++;
> > -             loop++;
> > +     for (loop = 0; loop < free_count; loop++) {
> > +             if (buf_to_free[loop].pkt_id < num_tx)
> > +                     rte_pktmbuf_free_seg(buf_to_free[loop].seg);
> >       }
> >
> >       /* free the pending buffers */
> > -     while (nb_pkts) {
> > -             rte_pktmbuf_free(*bufs);
> > -             bufs++;
> > -             nb_pkts--;
> > -             num_tx++;
> > -     }
> > +     rte_pktmbuf_free_bulk(bufs, nb_pkts);
>
> It is unsafe to use free_bulk on transmit path because packets in
> burst might come from different pools. An example would be a router
> forwarding from two incoming NIC's to one outgoing NIC.

Is it?

IIUC, this helper was added specifically to handle mbufs from multiple mempools.

static void
__rte_pktmbuf_free_seg_via_array(struct rte_mbuf *m,
        struct rte_mbuf ** const pending, unsigned int * const
nb_pending,
        const unsigned int pending_sz)
{
        m = rte_pktmbuf_prefree_seg(m);
        if (likely(m != NULL)) {
                if (*nb_pending == pending_sz ||
                    (*nb_pending > 0 && m->pool != pending[0]->pool))
{
                        rte_mempool_put_bulk(pending[0]->pool,
                                        (void **)pending,
*nb_pending);
                        *nb_pending = 0;
                }

                pending[(*nb_pending)++] = m;
        }
}

void rte_pktmbuf_free_bulk(struct rte_mbuf **mbufs, unsigned int
count)
        for (idx = 0; idx < count; idx++) {
                m = mbufs[idx];
                do {
                        m_next = m->next;
                        __rte_pktmbuf_free_seg_via_array(m,
                                        pending, &nb_pending,
                                        RTE_PKTMBUF_FREE_PENDING_SZ);
                        m = m_next;
                } while (m != NULL);
}


-- 
David Marchand

