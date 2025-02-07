Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE2AC02196
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 09:14:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5ED7E427B8;
	Fri,  7 Feb 2025 10:14:23 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id AC690427B5
 for <dev@dpdk.org>; Fri,  7 Feb 2025 10:14:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738919661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a3iZA2Pgm8E81aAcrCMcTJdsiJaWN6bEjxqawiLgwcM=;
 b=KCcf2WXk2fn44IDu8affIB8SSKBYJPb6OEkVJaqvkhQbL3uXZS78UHoPAwpWhgAVMYmlQc
 z4fiCcvXAwS/rsXcV6QzBKNIitKN65EjBYPPr4UvU+deYLw7SBcPmfmOu9vGsixATPtwk6
 aa7yHAb71bCbk75u/rjWJ0cgz8Dv4Hw=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-mb4EH_i8Ny2BrIjdJbdW5g-1; Fri, 07 Feb 2025 04:14:19 -0500
X-MC-Unique: mb4EH_i8Ny2BrIjdJbdW5g-1
X-Mimecast-MFC-AGG-ID: mb4EH_i8Ny2BrIjdJbdW5g
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-6f2c7008c05so28772897b3.0
 for <dev@dpdk.org>; Fri, 07 Feb 2025 01:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738919659; x=1739524459;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a3iZA2Pgm8E81aAcrCMcTJdsiJaWN6bEjxqawiLgwcM=;
 b=RRevETdDsdhY67An8UrJzsPxbuI32ywyoRy/0GXg+yMlDq3JRO+ih8IKrYwfJSfh/M
 J4ZY0ND1d7G8RASHPfgw5h7EmoeKv+F94PIzN4dSghgj1ofCGW4o8O4AlYG5E1d5Cz1r
 wullXBSMCX3CR7R/aF12/vaBV/PrE7Wx+uywtB1jtAwlbzYK2w1LbJfJ3B9Uzi9RPrRI
 pshgeae4enLjqOGq7DFBzKu70SkQjsLGjS6LGSdnsdoVkQaNE5aDfYilOD2/mbhi2lBm
 WAc/Q2E4JTUCWRwMrM6PRnsMx7GWmJb2YCk0mq5sxNInvixmPWePGleSET+cbBMlSxrf
 D8xQ==
X-Gm-Message-State: AOJu0Yxhnwk1oConPm7O2Hn1TIsHpfU2wXoh2+iuc+uy+kyH+K/GQB4L
 MVXuQvIns6+WCSxfN62nfzzqasOL4QgIlkCUV4d3CzU9zGwxYnqtNAKdueWepWOBvyIIQJh8o1B
 pH5c4aviOucPlkg2YmPNv80HIKeVkTuX3wlEX+v5NVoclwJb+O3qRCtkT+QKp1BbgZRoq9uNhzH
 VY04h1eLXYx2O2klA=
X-Gm-Gg: ASbGncvsl+oVZcBr/aOz0Kst9rOTWj2lekgHdUuRW/K8pAxAA/TWuKnd9B01RIqXz38
 vOG6qlt79Py9+NTyiC2U6lG69sXVz6+BPPzJclUxBH282SZmcol20C98VRAohJRpc4nYL/KEvL/
 LTdIcBENFazdN3nMz3vU19
X-Received: by 2002:a05:690c:4986:b0:6f7:409c:f647 with SMTP id
 00721157ae682-6f9b28021a7mr22540347b3.3.1738919659284; 
 Fri, 07 Feb 2025 01:14:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeydN4fhdhXzZYhYs0KzNWSMy1l1AnRMEqrSXsRbLJh2IFk9b/VDsIBco4KL89nIgH0iUnOT7FB2Gsj1dOWL4=
X-Received: by 2002:a05:690c:4986:b0:6f7:409c:f647 with SMTP id
 00721157ae682-6f9b28021a7mr22540197b3.3.1738919658976; Fri, 07 Feb 2025
 01:14:18 -0800 (PST)
MIME-Version: 1.0
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250206204645.1564535-1-ariel.otilibili@6wind.com>
 <20250206204645.1564535-3-ariel.otilibili@6wind.com>
In-Reply-To: <20250206204645.1564535-3-ariel.otilibili@6wind.com>
From: Maryam Tahhan <mtahhan@redhat.com>
Date: Fri, 7 Feb 2025 07:09:18 +0000
X-Gm-Features: AWEUYZmAdO_pJpW3lYksfsmZzLALnnCulgi4_GC-ZZvuDbDeIk3xRJDGey0bxb4
Message-ID: <CAFdtZivFid2eN0j5=YDnA9DC5GZNAEJDq-RqmYt-Ns26iuDw3Q@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] net/af_xdp: Refactor af_xdp_tx_zc
To: Ariel Otilibili <ariel.otilibili@6wind.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 Thomas Monjalon <thomas@monjalon.net>, 
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>, 
 Ciara Loftus <ciara.loftus@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Hn9PWB2NFf5y1t_Ldi26S7nm1aU-f5Im8GW8nGCANrQ_1738919659
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000091079c062d89c847"
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

--00000000000091079c062d89c847
Content-Type: text/plain; charset="UTF-8"

>
> <snip>
>

@@ -559,51 +587,30 @@ af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs,
> uint16_t nb_pkts)
>                 mbuf = bufs[i];
>
>                 if (mbuf->pool == umem->mb_pool) {
> -                       if (!xsk_ring_prod__reserve(&txq->tx, 1, &idx_tx))
> {
> +                 if (!(desc = reserve_and_fill(txq, mbuf, umem, NULL))) {
>                                 kick_tx(txq, cq);
> -                               if (!xsk_ring_prod__reserve(&txq->tx, 1,
> -                                                           &idx_tx))
> +                               desc = reserve_and_fill(txq, mbuf, umem,
> NULL);
> +                               if (!desc)
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
> -                       struct rte_mbuf *local_mbuf =
> -                                       rte_pktmbuf_alloc(umem->mb_pool);
> -                       void *pkt;
> -
> -                       if (local_mbuf == NULL)
> +                       if (!(local_mbuf =
> rte_pktmbuf_alloc(umem->mb_pool)))
>                                 goto out;
>
> -                       if (!xsk_ring_prod__reserve(&txq->tx, 1, &idx_tx))
> {
> +                       desc = reserve_and_fill(txq, local_mbuf, umem,
> &pkt);
> +                       if (!desc) {
>                                 rte_pktmbuf_free(local_mbuf);
>                                 goto out;
>                         }
>
> -                       desc = xsk_ring_prod__tx_desc(&txq->tx, idx_tx);
> -                       desc->len = mbuf->pkt_len;
> -
> -                       addr = (uint64_t)local_mbuf -
> (uint64_t)umem->buffer -
> -                                       umem->mb_pool->header_size;
> -                       offset = rte_pktmbuf_mtod(local_mbuf, uint64_t) -
> -                                       (uint64_t)local_mbuf +
> -                                       umem->mb_pool->header_size;
> -                       pkt = xsk_umem__get_data(umem->buffer, addr +
> offset);
> -                       offset = offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT;
> -                       desc->addr = addr | offset;
> +                       desc->len = local_mbuf->pkt_len;
>

Sorry if my remarks were confusing, it was just missing from the previous
patch and it needs to be:
desc->len = mbuf->pkt_len;

We need to keep this the same as the original code. This is a scenario
where we need to copy the data from an mbuf that isn't in from the pool of
buffers allocated for the umem. So the desc->len needs to be set to that of
the (non umem) mbuf.

The other changes look good. Nearly there,

Thanks again

<snip>

--00000000000091079c062d89c847
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9ImF1dG8iPjxkaXY+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUgZ21haWxfcXVvdGVf
Y29udGFpbmVyIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4m
bHQ7c25pcCZndDs8YnI+PC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48
YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIGdtYWlsX3F1
b3RlX2NvbnRhaW5lciI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFl
eCI+DQpAQCAtNTU5LDUxICs1ODcsMzAgQEAgYWZfeGRwX3R4X3pjKHZvaWQgKnF1ZXVlLCBzdHJ1
Y3QgcnRlX21idWYgKipidWZzLCB1aW50MTZfdCBuYl9wa3RzKTxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIG1idWYgPSBidWZzW2ldOzxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGlmIChtYnVmLSZndDtwb29sID09IHVtZW0tJmd0O21iX3Bvb2wpIHs8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoIXhza19yaW5nX3Byb2RfX3Jlc2VydmUo
JmFtcDt0eHEtJmd0O3R4LCAxLCAmYW1wO2lkeF90eCkpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpZiAoIShkZXNjID0gcmVzZXJ2ZV9hbmRfZmlsbCh0eHEsIG1idWYsIHVtZW0s
IE5VTEwpKSkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGtpY2tfdHgodHhxLCBjcSk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKCF4c2tfcmluZ19wcm9kX19yZXNlcnZlKCZhbXA7dHhx
LSZndDt0eCwgMSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmYW1wO2lk
eF90eCkpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgZGVzYyA9IHJlc2VydmVfYW5kX2ZpbGwodHhxLCBtYnVmLCB1bWVtLCBOVUxMKTs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoIWRlc2Mp
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgZ290byBvdXQ7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgfTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRlc2MgPSB4c2tf
cmluZ19wcm9kX190eF9kZXNjKCZhbXA7dHhxLSZndDt0eCwgaWR4X3R4KTs8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZXNjLSZndDtsZW4gPSBtYnVmLSZndDtwa3Rf
bGVuOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGFkZHIgPSAodWlu
dDY0X3QpbWJ1ZiAtICh1aW50NjRfdCl1bWVtLSZndDtidWZmZXIgLTxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVtZW0tJmd0
O21iX3Bvb2wtJmd0O2hlYWRlcl9zaXplOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoG9mZnNldCA9IHJ0ZV9wa3RtYnVmX210b2QobWJ1ZiwgdWludDY0X3QpIC08YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAodWludDY0X3QpbWJ1ZiArPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdW1lbS0mZ3Q7bWJfcG9vbC0mZ3Q7aGVhZGVy
X3NpemU7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgb2Zmc2V0ID0g
b2Zmc2V0ICZsdDsmbHQ7IFhTS19VTkFMSUdORURfQlVGX09GRlNFVF9TSElGVDs8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZXNjLSZndDthZGRyID0gYWRkciB8IG9m
ZnNldDs8YnI+DQorPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdHhf
Ynl0ZXMgKz0gZGVzYy0mZ3Q7bGVuOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGNvdW50Kys7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfSBlbHNlIHs8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJ1Y3QgcnRlX21idWYgKmxv
Y2FsX21idWYgPTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9wa3RtYnVmX2FsbG9jKHVtZW0tJmd0O21iX3Bvb2wpOzxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHZvaWQgKnBrdDs8YnI+DQot
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGxvY2FsX21idWYg
PT0gTlVMTCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoIShs
b2NhbF9tYnVmID0gcnRlX3BrdG1idWZfYWxsb2ModW1lbS0mZ3Q7bWJfcG9vbCkpKTxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gb3V0Ozxi
cj4NCjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICgheHNrX3Jp
bmdfcHJvZF9fcmVzZXJ2ZSgmYW1wO3R4cS0mZ3Q7dHgsIDEsICZhbXA7aWR4X3R4KSkgezxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRlc2MgPSByZXNlcnZlX2FuZF9m
aWxsKHR4cSwgbG9jYWxfbWJ1ZiwgdW1lbSwgJmFtcDtwa3QpOzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICghZGVzYykgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJ0ZV9wa3RtYnVmX2ZyZWUobG9jYWxfbWJ1
Zik7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
Z290byBvdXQ7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4N
Cjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRlc2MgPSB4c2tfcmlu
Z19wcm9kX190eF9kZXNjKCZhbXA7dHhxLSZndDt0eCwgaWR4X3R4KTs8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZXNjLSZndDtsZW4gPSBtYnVmLSZndDtwa3RfbGVu
Ozxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBhZGRyID0g
KHVpbnQ2NF90KWxvY2FsX21idWYgLSAodWludDY0X3QpdW1lbS0mZ3Q7YnVmZmVyIC08YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqB1bWVtLSZndDttYl9wb29sLSZndDtoZWFkZXJfc2l6ZTs8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBvZmZzZXQgPSBydGVfcGt0bWJ1Zl9tdG9kKGxvY2FsX21idWYs
IHVpbnQ2NF90KSAtPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgKHVpbnQ2NF90KWxvY2FsX21idWYgKzxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVtZW0t
Jmd0O21iX3Bvb2wtJmd0O2hlYWRlcl9zaXplOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHBrdCA9IHhza191bWVtX19nZXRfZGF0YSh1bWVtLSZndDtidWZmZXIsIGFk
ZHIgKyBvZmZzZXQpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG9m
ZnNldCA9IG9mZnNldCAmbHQ7Jmx0OyBYU0tfVU5BTElHTkVEX0JVRl9PRkZTRVRfU0hJRlQ7PGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGVzYy0mZ3Q7YWRkciA9IGFk
ZHIgfCBvZmZzZXQ7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGVz
Yy0mZ3Q7bGVuID0gbG9jYWxfbWJ1Zi0mZ3Q7cGt0X2xlbjs8YnI+PC9ibG9ja3F1b3RlPjwvZGl2
PjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPlNvcnJ5IGlm
IG15IHJlbWFya3Mgd2VyZSBjb25mdXNpbmcsIGl0IHdhcyBqdXN0IG1pc3NpbmcgZnJvbSB0aGUg
cHJldmlvdXMgcGF0Y2ggYW5kIGl0IG5lZWRzIHRvIGJlOjwvZGl2PjxkaXYgZGlyPSJhdXRvIj5k
ZXNjLSZndDtsZW4gPSBtYnVmLSZndDtwa3RfbGVuOzwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+
PC9kaXY+PGRpdiBkaXI9ImF1dG8iPldlIG5lZWQgdG8ga2VlcCB0aGlzIHRoZSBzYW1lIGFzIHRo
ZSBvcmlnaW5hbCBjb2RlLiBUaGlzIGlzIGEgc2NlbmFyaW8gd2hlcmUgd2UgbmVlZCB0byBjb3B5
IHRoZSBkYXRhIGZyb20gYW4gbWJ1ZiB0aGF0IGlzbiYjMzk7dCBpbiBmcm9tIHRoZSBwb29sIG9m
IGJ1ZmZlcnMgYWxsb2NhdGVkIGZvciB0aGUgdW1lbS4gU28gdGhlIGRlc2MtJmd0O2xlbiBuZWVk
cyB0byBiZSBzZXQgdG8gdGhhdCBvZiB0aGUgKG5vbiB1bWVtKSBtYnVmLsKgPC9kaXY+PGRpdiBk
aXI9ImF1dG8iPjxicj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+VGhlIG90aGVyIGNoYW5nZXMgbG9v
ayBnb29kLiBOZWFybHkgdGhlcmUsPC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxicj48L2Rpdj48ZGl2
IGRpcj0iYXV0byI+VGhhbmtzIGFnYWluPC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxicj48L2Rpdj48
ZGl2IGRpcj0iYXV0byI+Jmx0O3NuaXAmZ3Q7PC9kaXY+PC9kaXY+DQo=
--00000000000091079c062d89c847--

