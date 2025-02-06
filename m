Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E764C02192
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 01:09:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B38084065F;
	Thu,  6 Feb 2025 02:09:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 84802402A0
 for <dev@dpdk.org>; Thu,  6 Feb 2025 02:09:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738804173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GTb4EldSo55UnOfrjJNfh5VchR8AJHu0kd7ftaoRq9U=;
 b=aKdcHH1ZFiTZQh7nHPVjCWQSxXLW+fugQsy4DhOCD0G8++7fxAExW7BD/mJitYM7lu0dJ7
 VNsWz6q71I3NAPMdoP1ZmUpzcpZyUi/x2ZQcONz/8asvd0UAOyPqixXqRb7OcQl2BPHu/q
 jBqlC0ncZjilInlUUnnjOaWj7uWoS3s=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-T32n6-KhNiyU2vcy1fD9kA-1; Wed, 05 Feb 2025 20:09:31 -0500
X-MC-Unique: T32n6-KhNiyU2vcy1fD9kA-1
X-Mimecast-MFC-AGG-ID: T32n6-KhNiyU2vcy1fD9kA
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6f2c7008c05so8845217b3.0
 for <dev@dpdk.org>; Wed, 05 Feb 2025 17:09:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738804171; x=1739408971;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8XVXoZOemSoRqi2F7pMyhF0vWhA37ERMDBQtpEGmmYc=;
 b=h1U09JNZ5YFHZqCP7n2veqUV+ggykrN2YFeBUs2OJ/HBmzr4u9vf0d6ewRAeaL7lzG
 3mwlNvb7Jz4yRkHynTqecz061JBPkF7+YHlqeUM3/2n+WURDQJ6vmYxXTJ2twwF9v5RK
 kpwwxiKHb/xFKnZxtwicUVtiOq4J0s2hBA4VNusqkQPmQ0Ay+rGhF1Qontsy/6SFzTbx
 iIZIYxn42GlzOQZ03Dm7vUg5lSQX4DgJdsMisvk2m0HF6nu+TzSrJaNlMs7Nrad3BnOe
 ytyYWW0AWECHF/JWD5lSccFV72B8+00hyp4es/WX9ISHHHvPtN+d+CILT57Mqtdt4At2
 mw1w==
X-Gm-Message-State: AOJu0YxICmbiSC6/UNLl2A4BeWUuLBdnCN6mf/5ATVisuk+KaU7T5+JR
 aTXIX0GSSogoGioeB+q8aYDYOqSDpnNdKiJoM2PUEpVYSk/o2Njj0ZBgaih8SgovRhowojEojHx
 Evyyj/u4b6N6ZsG4vkHLrvNdlR6CIctFcFhQ4GFdFJXLKLSKTExHOriHdb9tVaNE7lrpjPNWyv2
 mALntC1eH5STm0He0=
X-Gm-Gg: ASbGncu10emK336ZZXSHlSyBF7KgC+9kxfPPVzwJ0qWojRIHACjZzOY4o6+XzlJ/8en
 k4sMMEd+iGQtMyCUkMwgdbdldU/8UV3jls0jvCytvW4lqEL5wMnosWf1pc1GqRaEu73tj2cECcW
 v9k6vQwiPj0ak6KWUdQ8ij
X-Received: by 2002:a05:690c:4713:b0:6f9:9cd3:7f97 with SMTP id
 00721157ae682-6f99cd389f2mr5307027b3.13.1738804170872; 
 Wed, 05 Feb 2025 17:09:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHM4D3sWN00XznlBE18eW/cDktynF6keg+7Zeez4rSXUeGudhHZxKRYHs+6ktHb79T6CiOGplO8w0KO5Um9xO8=
X-Received: by 2002:a05:690c:4713:b0:6f9:9cd3:7f97 with SMTP id
 00721157ae682-6f99cd389f2mr5306877b3.13.1738804170572; Wed, 05 Feb 2025
 17:09:30 -0800 (PST)
MIME-Version: 1.0
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250201100300.2194018-1-ariel.otilibili@6wind.com>
 <20250201100300.2194018-3-ariel.otilibili@6wind.com>
In-Reply-To: <20250201100300.2194018-3-ariel.otilibili@6wind.com>
From: Maryam Tahhan <mtahhan@redhat.com>
Date: Thu, 6 Feb 2025 01:09:18 +0000
X-Gm-Features: AWEUYZlu4TWdEMh_rCxXJDk3qNwgPUV7aZiX18zbKwCWdHLdkSpRw-U3zDI7cCc
Message-ID: <CAFdtZiu9t6tzw=cZgN+B22DiC7eYbMx7hxmBzVbx9Mfz3XwMVQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] net/af_xdp: Refactor af_xdp_tx_zc
To: Ariel Otilibili <ariel.otilibili@6wind.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 Thomas Monjalon <thomas@monjalon.net>, 
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>, 
 Ciara Loftus <ciara.loftus@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VSdqntGIdUrLdVWJOMADwIkzQbhlMrZX19vNEL9ip8Y_1738804171
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000ebf013062d6ee426"
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

--000000000000ebf013062d6ee426
Content-Type: text/plain; charset="UTF-8"

On Sat 1 Feb 2025, 10:03 Ariel Otilibili, <ariel.otilibili@6wind.com> wrote:

> Both legs of the loop share the same logic: the common parts are about
> reserving and filling both address and length into the description.
>
> This is moved into reserve_and_fill().
>
> Bugzilla ID: 1440
> Suggested-by: Maryam Tahhan <mtahhan@redhat.com>
> Signed-off-by: Ariel Otilibili <ariel.otilibili@6wind.com>
> ---
>  drivers/net/af_xdp/rte_eth_af_xdp.c | 62 ++++++++++++++++-------------
>  1 file changed, 34 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c
> b/drivers/net/af_xdp/rte_eth_af_xdp.c
> index 092bcb73aa0a..840a12dbf508 100644
> --- a/drivers/net/af_xdp/rte_eth_af_xdp.c
> +++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
> @@ -536,6 +536,31 @@ kick_tx(struct pkt_tx_queue *txq, struct
> xsk_ring_cons *cq)
>                 }
>  }
>
> +static inline struct xdp_desc *
> +reserve_and_fill(struct pkt_tx_queue *txq, struct rte_mbuf *mbuf,
> +                struct xsk_umem_info *umem)
> +{
> +       struct xdp_desc *desc = NULL;
> +       uint32_t *idx_tx = NULL;
> +       uint64_t addr, offset;
> +
> +       if (!xsk_ring_prod__reserve(&txq->tx, 1, idx_tx))
> +               goto out;
> +
> +       desc = xsk_ring_prod__tx_desc(&txq->tx, *idx_tx);
> +       desc->len = mbuf->pkt_len;
> +
> +       addr = (uint64_t)mbuf - (uint64_t)umem->buffer
> +               - umem->mb_pool->header_size;
> +       offset = rte_pktmbuf_mtod(mbuf, uint64_t) - (uint64_t)mbuf
> +               + umem->mb_pool->header_size;
> +       offset = offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT;
> +       desc->addr = addr | offset;
> +
> +out:
> +       return desc;
> +}
> +
>  #if defined(XDP_UMEM_UNALIGNED_CHUNK_FLAG)
>  static uint16_t
>  af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
> @@ -545,10 +570,8 @@ af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs,
> uint16_t nb_pkts)
>         struct rte_mbuf *mbuf;
>         unsigned long tx_bytes = 0;
>         int i;
> -       uint32_t idx_tx;
>         uint16_t count = 0;
>         struct xdp_desc *desc;
> -       uint64_t addr, offset;
>         struct xsk_ring_cons *cq = &txq->pair->cq;
>         uint32_t free_thresh = cq->size >> 1;
>
> @@ -559,21 +582,12 @@ af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs,
> uint16_t nb_pkts)
>                 mbuf = bufs[i];
>
>                 if (mbuf->pool == umem->mb_pool) {
> -                       if (!xsk_ring_prod__reserve(&txq->tx, 1, &idx_tx))
> {
> +                       if (!(desc = reserve_and_fill(txq, mbuf, umem))) {
>                                 kick_tx(txq, cq);
> -                               if (!xsk_ring_prod__reserve(&txq->tx, 1,
> -                                                           &idx_tx))
> +                               if (!(desc = reserve_and_fill(txq, mbuf,
> umem)))
>                                         goto out;
>                         }
> -                       desc = xsk_ring_prod__tx_desc(&txq->tx, idx_tx);
> -                       desc->len = mbuf->pkt_len;
> -                       addr = (uint64_t)mbuf - (uint64_t)umem->buffer -
> -                                       umem->mb_pool->header_size;
> -                       offset = rte_pktmbuf_mtod(mbuf, uint64_t) -
> -                                       (uint64_t)mbuf +
> -                                       umem->mb_pool->header_size;
> -                       offset = offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT;
> -                       desc->addr = addr | offset;
> +
>                         tx_bytes += desc->len;
>                         count++;
>                 } else {
> @@ -584,26 +598,18 @@ af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs,
> uint16_t nb_pkts)
>                         if (local_mbuf == NULL)
>                                 goto out;
>
> -                       if (!xsk_ring_prod__reserve(&txq->tx, 1, &idx_tx))
> {
> +                       if (!(desc = reserve_and_fill(txq, local_mbuf,
> umem))) {
>                                 rte_pktmbuf_free(local_mbuf);
>                                 goto out;
>                         }
>
> -                       desc = xsk_ring_prod__tx_desc(&txq->tx, idx_tx);
> -                       desc->len = mbuf->pkt_len;
> -
>

So I think i spotted one issue, you might need override desc->len after the
call to the reserve_and_fill function so as it's not taken supposed to be
from local_mbuf here.

-                       addr = (uint64_t)local_mbuf -
> (uint64_t)umem->buffer -
> -                                       umem->mb_pool->header_size;
> -                       offset = rte_pktmbuf_mtod(local_mbuf, uint64_t) -
> -                                       (uint64_t)local_mbuf +
> -                                       umem->mb_pool->header_size;
> -                       pkt = xsk_umem__get_data(umem->buffer, addr +
> offset);
> -                       offset = offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT;
> -                       desc->addr = addr | offset;
> +                       pkt = xsk_umem__get_data(umem->buffer,
> +                                                (desc->addr & ~0xFFF)
> +                                                + (desc->addr & 0xFFF));
>

Would prefer to move this pkt assignment to reserve_and_fill()
What if we passed a void **ppkt to reserve_and_fill()  then kept the
original logic just wrapped in a NULL check?

 if (ppkt) {
      *ppkt = xsk_umem__get_data(umem->buffer, addr + offset);
    }


Before the offset and desc->addr
    offset = offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT;
    desc->addr = addr | offset;

WDYT?

                        rte_memcpy(pkt, rte_pktmbuf_mtod(mbuf, void *),
> -                                       desc->len);
> -                       tx_bytes += desc->len;
> +                                  desc->len);
>                         rte_pktmbuf_free(mbuf);
> +                       tx_bytes += desc->len;
>                         count++;
>                 }
>         }
> --
> 2.30.2
>
>

--000000000000ebf013062d6ee426
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9ImF1dG8iPjxkaXY+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSBnbWFp
bF9xdW90ZV9jb250YWluZXIiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBT
YXQgMSBGZWIgMjAyNSwgMTA6MDMgQXJpZWwgT3RpbGliaWxpLCAmbHQ7PGEgaHJlZj0ibWFpbHRv
OmFyaWVsLm90aWxpYmlsaUA2d2luZC5jb20iPmFyaWVsLm90aWxpYmlsaUA2d2luZC5jb208L2E+
Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHls
ZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1s
ZWZ0OjFleCI+Qm90aCBsZWdzIG9mIHRoZSBsb29wIHNoYXJlIHRoZSBzYW1lIGxvZ2ljOiB0aGUg
Y29tbW9uIHBhcnRzIGFyZSBhYm91dDxicj4NCnJlc2VydmluZyBhbmQgZmlsbGluZyBib3RoIGFk
ZHJlc3MgYW5kIGxlbmd0aCBpbnRvIHRoZSBkZXNjcmlwdGlvbi48YnI+DQo8YnI+DQpUaGlzIGlz
IG1vdmVkIGludG8gcmVzZXJ2ZV9hbmRfZmlsbCgpLjxicj4NCjxicj4NCkJ1Z3ppbGxhIElEOiAx
NDQwPGJyPg0KU3VnZ2VzdGVkLWJ5OiBNYXJ5YW0gVGFoaGFuICZsdDs8YSBocmVmPSJtYWlsdG86
bXRhaGhhbkByZWRoYXQuY29tIiB0YXJnZXQ9Il9ibGFuayIgcmVsPSJub3JlZmVycmVyIj5tdGFo
aGFuQHJlZGhhdC5jb208L2E+Jmd0Ozxicj4NClNpZ25lZC1vZmYtYnk6IEFyaWVsIE90aWxpYmls
aSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFyaWVsLm90aWxpYmlsaUA2d2luZC5jb20iIHRhcmdldD0i
X2JsYW5rIiByZWw9Im5vcmVmZXJyZXIiPmFyaWVsLm90aWxpYmlsaUA2d2luZC5jb208L2E+Jmd0
Ozxicj4NCi0tLTxicj4NCsKgZHJpdmVycy9uZXQvYWZfeGRwL3J0ZV9ldGhfYWZfeGRwLmMgfCA2
MiArKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLTxicj4NCsKgMSBmaWxlIGNoYW5nZWQsIDM0
IGluc2VydGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKTxicj4NCjxicj4NCmRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC9hZl94ZHAvcnRlX2V0aF9hZl94ZHAuYyBiL2RyaXZlcnMvbmV0L2FmX3hkcC9y
dGVfZXRoX2FmX3hkcC5jPGJyPg0KaW5kZXggMDkyYmNiNzNhYTBhLi44NDBhMTJkYmY1MDggMTAw
NjQ0PGJyPg0KLS0tIGEvZHJpdmVycy9uZXQvYWZfeGRwL3J0ZV9ldGhfYWZfeGRwLmM8YnI+DQor
KysgYi9kcml2ZXJzL25ldC9hZl94ZHAvcnRlX2V0aF9hZl94ZHAuYzxicj4NCkBAIC01MzYsNiAr
NTM2LDMxIEBAIGtpY2tfdHgoc3RydWN0IHBrdF90eF9xdWV1ZSAqdHhxLCBzdHJ1Y3QgeHNrX3Jp
bmdfY29ucyAqY3EpPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4NCsKgfTxicj4N
Cjxicj4NCitzdGF0aWMgaW5saW5lIHN0cnVjdCB4ZHBfZGVzYyAqPGJyPg0KK3Jlc2VydmVfYW5k
X2ZpbGwoc3RydWN0IHBrdF90eF9xdWV1ZSAqdHhxLCBzdHJ1Y3QgcnRlX21idWYgKm1idWYsPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cnVjdCB4c2tfdW1lbV9pbmZvICp1bWVtKTxi
cj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IHhkcF9kZXNjICpkZXNjID0gTlVMTDs8YnI+
DQorwqAgwqAgwqAgwqB1aW50MzJfdCAqaWR4X3R4ID0gTlVMTDs8YnI+DQorwqAgwqAgwqAgwqB1
aW50NjRfdCBhZGRyLCBvZmZzZXQ7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGlmICgheHNrX3Jp
bmdfcHJvZF9fcmVzZXJ2ZSgmYW1wO3R4cS0mZ3Q7dHgsIDEsIGlkeF90eCkpPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgZ290byBvdXQ7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGRlc2Mg
PSB4c2tfcmluZ19wcm9kX190eF9kZXNjKCZhbXA7dHhxLSZndDt0eCwgKmlkeF90eCk7PGJyPg0K
K8KgIMKgIMKgIMKgZGVzYy0mZ3Q7bGVuID0gbWJ1Zi0mZ3Q7cGt0X2xlbjs8YnI+DQorPGJyPg0K
K8KgIMKgIMKgIMKgYWRkciA9ICh1aW50NjRfdCltYnVmIC0gKHVpbnQ2NF90KXVtZW0tJmd0O2J1
ZmZlcjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC0gdW1lbS0mZ3Q7bWJfcG9vbC0mZ3Q7
aGVhZGVyX3NpemU7PGJyPg0KK8KgIMKgIMKgIMKgb2Zmc2V0ID0gcnRlX3BrdG1idWZfbXRvZCht
YnVmLCB1aW50NjRfdCkgLSAodWludDY0X3QpbWJ1Zjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCsgdW1lbS0mZ3Q7bWJfcG9vbC0mZ3Q7aGVhZGVyX3NpemU7PGJyPg0KK8KgIMKgIMKgIMKg
b2Zmc2V0ID0gb2Zmc2V0ICZsdDsmbHQ7IFhTS19VTkFMSUdORURfQlVGX09GRlNFVF9TSElGVDs8
YnI+DQorwqAgwqAgwqAgwqBkZXNjLSZndDthZGRyID0gYWRkciB8IG9mZnNldDs8YnI+DQorPGJy
Pg0KK291dDo8YnI+DQorwqAgwqAgwqAgwqByZXR1cm4gZGVzYzs8YnI+DQorfTxicj4NCis8YnI+
DQrCoCNpZiBkZWZpbmVkKFhEUF9VTUVNX1VOQUxJR05FRF9DSFVOS19GTEFHKTxicj4NCsKgc3Rh
dGljIHVpbnQxNl90PGJyPg0KwqBhZl94ZHBfdHhfemModm9pZCAqcXVldWUsIHN0cnVjdCBydGVf
bWJ1ZiAqKmJ1ZnMsIHVpbnQxNl90IG5iX3BrdHMpPGJyPg0KQEAgLTU0NSwxMCArNTcwLDggQEAg
YWZfeGRwX3R4X3pjKHZvaWQgKnF1ZXVlLCBzdHJ1Y3QgcnRlX21idWYgKipidWZzLCB1aW50MTZf
dCBuYl9wa3RzKTxicj4NCsKgIMKgIMKgIMKgIHN0cnVjdCBydGVfbWJ1ZiAqbWJ1Zjs8YnI+DQrC
oCDCoCDCoCDCoCB1bnNpZ25lZCBsb25nIHR4X2J5dGVzID0gMDs8YnI+DQrCoCDCoCDCoCDCoCBp
bnQgaTs8YnI+DQotwqAgwqAgwqAgwqB1aW50MzJfdCBpZHhfdHg7PGJyPg0KwqAgwqAgwqAgwqAg
dWludDE2X3QgY291bnQgPSAwOzxicj4NCsKgIMKgIMKgIMKgIHN0cnVjdCB4ZHBfZGVzYyAqZGVz
Yzs8YnI+DQotwqAgwqAgwqAgwqB1aW50NjRfdCBhZGRyLCBvZmZzZXQ7PGJyPg0KwqAgwqAgwqAg
wqAgc3RydWN0IHhza19yaW5nX2NvbnMgKmNxID0gJmFtcDt0eHEtJmd0O3BhaXItJmd0O2NxOzxi
cj4NCsKgIMKgIMKgIMKgIHVpbnQzMl90IGZyZWVfdGhyZXNoID0gY3EtJmd0O3NpemUgJmd0OyZn
dDsgMTs8YnI+DQo8YnI+DQpAQCAtNTU5LDIxICs1ODIsMTIgQEAgYWZfeGRwX3R4X3pjKHZvaWQg
KnF1ZXVlLCBzdHJ1Y3QgcnRlX21idWYgKipidWZzLCB1aW50MTZfdCBuYl9wa3RzKTxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIG1idWYgPSBidWZzW2ldOzxicj4NCjxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGlmIChtYnVmLSZndDtwb29sID09IHVtZW0tJmd0O21iX3Bvb2wpIHs8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoIXhza19yaW5nX3By
b2RfX3Jlc2VydmUoJmFtcDt0eHEtJmd0O3R4LCAxLCAmYW1wO2lkeF90eCkpIHs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoIShkZXNjID0gcmVzZXJ2ZV9hbmRf
ZmlsbCh0eHEsIG1idWYsIHVtZW0pKSkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGtpY2tfdHgodHhxLCBjcSk7PGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKCF4c2tfcmluZ19wcm9kX19y
ZXNlcnZlKCZhbXA7dHhxLSZndDt0eCwgMSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAmYW1wO2lkeF90eCkpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgaWYgKCEoZGVzYyA9IHJlc2VydmVfYW5kX2ZpbGwodHhxLCBtYnVm
LCB1bWVtKSkpPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgZ290byBvdXQ7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgfTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRl
c2MgPSB4c2tfcmluZ19wcm9kX190eF9kZXNjKCZhbXA7dHhxLSZndDt0eCwgaWR4X3R4KTs8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZXNjLSZndDtsZW4gPSBtYnVm
LSZndDtwa3RfbGVuOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGFk
ZHIgPSAodWludDY0X3QpbWJ1ZiAtICh1aW50NjRfdCl1bWVtLSZndDtidWZmZXIgLTxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHVtZW0tJmd0O21iX3Bvb2wtJmd0O2hlYWRlcl9zaXplOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoG9mZnNldCA9IHJ0ZV9wa3RtYnVmX210b2QobWJ1ZiwgdWludDY0
X3QpIC08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAodWludDY0X3QpbWJ1ZiArPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdW1lbS0mZ3Q7bWJfcG9vbC0m
Z3Q7aGVhZGVyX3NpemU7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
b2Zmc2V0ID0gb2Zmc2V0ICZsdDsmbHQ7IFhTS19VTkFMSUdORURfQlVGX09GRlNFVF9TSElGVDs8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZXNjLSZndDthZGRyID0g
YWRkciB8IG9mZnNldDs8YnI+DQorPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgdHhfYnl0ZXMgKz0gZGVzYy0mZ3Q7bGVuOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGNvdW50Kys7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfSBl
bHNlIHs8YnI+DQpAQCAtNTg0LDI2ICs1OTgsMTggQEAgYWZfeGRwX3R4X3pjKHZvaWQgKnF1ZXVl
LCBzdHJ1Y3QgcnRlX21idWYgKipidWZzLCB1aW50MTZfdCBuYl9wa3RzKTxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChsb2NhbF9tYnVmID09IE5VTEwpPGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290byBvdXQ7
PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKCF4c2tf
cmluZ19wcm9kX19yZXNlcnZlKCZhbXA7dHhxLSZndDt0eCwgMSwgJmFtcDtpZHhfdHgpKSB7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKCEoZGVzYyA9IHJlc2Vy
dmVfYW5kX2ZpbGwodHhxLCBsb2NhbF9tYnVmLCB1bWVtKSkpIHs8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBydGVfcGt0bWJ1Zl9mcmVlKGxvY2Fs
X21idWYpOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGdvdG8gb3V0Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08
YnI+DQo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZXNjID0geHNr
X3JpbmdfcHJvZF9fdHhfZGVzYygmYW1wO3R4cS0mZ3Q7dHgsIGlkeF90eCk7PGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGVzYy0mZ3Q7bGVuID0gbWJ1Zi0mZ3Q7cGt0
X2xlbjs8YnI+DQotPGJyPjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+
PGJyPjwvZGl2PjxkaXYgZGlyPSJhdXRvIj5TbyBJIHRoaW5rIGkgc3BvdHRlZCBvbmUgaXNzdWUs
IHlvdSBtaWdodCBuZWVkIG92ZXJyaWRlIGRlc2MtJmd0O2xlbiBhZnRlciB0aGUgY2FsbCB0byB0
aGUgcmVzZXJ2ZV9hbmRfZmlsbCBmdW5jdGlvbiBzbyBhcyBpdCYjMzk7cyBub3QgdGFrZW4gc3Vw
cG9zZWQgdG8gYmUgZnJvbSBsb2NhbF9tYnVmIGhlcmUuPC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxi
cj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUgZ21haWxfcXVv
dGVfY29udGFpbmVyIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4
Ij4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGFkZHIgPSAodWludDY0X3Qp
bG9jYWxfbWJ1ZiAtICh1aW50NjRfdCl1bWVtLSZndDtidWZmZXIgLTxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVtZW0tJmd0
O21iX3Bvb2wtJmd0O2hlYWRlcl9zaXplOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoG9mZnNldCA9IHJ0ZV9wa3RtYnVmX210b2QobG9jYWxfbWJ1ZiwgdWludDY0X3Qp
IC08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAodWludDY0X3QpbG9jYWxfbWJ1ZiArPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdW1lbS0mZ3Q7bWJfcG9v
bC0mZ3Q7aGVhZGVyX3NpemU7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgcGt0ID0geHNrX3VtZW1fX2dldF9kYXRhKHVtZW0tJmd0O2J1ZmZlciwgYWRkciArIG9mZnNl
dCk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgb2Zmc2V0ID0gb2Zm
c2V0ICZsdDsmbHQ7IFhTS19VTkFMSUdORURfQlVGX09GRlNFVF9TSElGVDs8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZXNjLSZndDthZGRyID0gYWRkciB8IG9mZnNl
dDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwa3QgPSB4c2tfdW1l
bV9fZ2V0X2RhdGEodW1lbS0mZ3Q7YnVmZmVyLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAoZGVzYy0m
Z3Q7YWRkciAmYW1wOyB+MHhGRkYpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICsgKGRlc2MtJmd0O2Fk
ZHIgJmFtcDsgMHhGRkYpKTs8YnI+PC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2PjxkaXYgZGlyPSJh
dXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPldvdWxkIHByZWZlciB0byBtb3ZlIHRoaXMg
cGt0IGFzc2lnbm1lbnQgdG8gcmVzZXJ2ZV9hbmRfZmlsbCgpPC9kaXY+PGRpdiBkaXI9ImF1dG8i
PldoYXQgaWYgd2UgcGFzc2VkIGEgdm9pZCAqKnBwa3QgdG8gcmVzZXJ2ZV9hbmRfZmlsbCgpwqAg
dGhlbiBrZXB0IHRoZSBvcmlnaW5hbCBsb2dpYyBqdXN0IHdyYXBwZWQgaW4gYSBOVUxMIGNoZWNr
PzwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxkaXYgZGly
PSJhdXRvIj7CoGlmIChwcGt0KSB7PC9kaXY+PGRpdiBkaXI9ImF1dG8iPsKgIMKgIMKgICpwcGt0
ID0geHNrX3VtZW1fX2dldF9kYXRhKHVtZW0tJmd0O2J1ZmZlciwgYWRkciArIG9mZnNldCk7PC9k
aXY+PGRpdiBkaXI9ImF1dG8iPsKgIMKgIH08L2Rpdj48ZGl2IGRpcj0iYXV0byI+PGJyPjwvZGl2
PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPkJlZm9yZSB0aGUgb2Zm
c2V0IGFuZCBkZXNjLSZndDthZGRywqA8L2Rpdj48ZGl2IGRpcj0iYXV0byI+wqAgwqAgb2Zmc2V0
ID0gb2Zmc2V0ICZsdDsmbHQ7IFhTS19VTkFMSUdORURfQlVGX09GRlNFVF9TSElGVDs8L2Rpdj48
ZGl2IGRpcj0iYXV0byI+wqAgwqAgZGVzYy0mZ3Q7YWRkciA9IGFkZHIgfCBvZmZzZXQ7PC9kaXY+
PGRpdiBkaXI9ImF1dG8iPjxicj48L2Rpdj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+V0RZVD/CoDwv
ZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxkaXYgY2xhc3M9
ImdtYWlsX3F1b3RlIGdtYWlsX3F1b3RlX2NvbnRhaW5lciI+PGJsb2NrcXVvdGUgY2xhc3M9Imdt
YWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mg
c29saWQ7cGFkZGluZy1sZWZ0OjFleCI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBydGVfbWVtY3B5KHBrdCwgcnRlX3BrdG1idWZfbXRvZChtYnVmLCB2b2lkICopLDxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGRlc2MtJmd0O2xlbik7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgdHhfYnl0ZXMgKz0gZGVzYy0mZ3Q7bGVuOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkZXNjLSZndDtsZW4pOzxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJ0ZV9wa3RtYnVmX2ZyZWUobWJ1Zik7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdHhfYnl0ZXMgKz0gZGVzYy0mZ3Q7
bGVuOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNvdW50Kys7PGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4NCsKgIMKgIMKgIMKgIH08YnI+DQotLSA8
YnI+DQoyLjMwLjI8YnI+DQo8YnI+DQo8L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+PC9kaXY+DQo=

--000000000000ebf013062d6ee426--

