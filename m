Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D005EC55164
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jul 2026 16:32:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0571D402BB;
	Thu, 30 Jul 2026 18:32:19 +0200 (CEST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by mails.dpdk.org (Postfix) with ESMTP id 1B2CD40276
 for <dev@dpdk.org>; Thu, 30 Jul 2026 18:32:17 +0200 (CEST)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-39c83acb86eso261311fa.1
 for <dev@dpdk.org>; Thu, 30 Jul 2026 09:32:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785429136; cv=none;
 d=google.com; s=arc-20260327;
 b=F9L3FVt1ucWxVjjBjC2k4Tuy/Xy5KVf7n1eVNKXm8xzfv/tDLH8txGVV5DbNnoS7sX
 lQ/KkOxlhInZzh4jZte4TX1z1DFlvGeBgU51/V/9uF3wyx2EBywRn/cYw2jBc4bejcna
 1KIb6Tpa9y0hAKYhKP3iA6XHkoA61l70UC6EuX+yIlvzDMqRD5Q5ev1tbhX0bBFfu9A2
 5YrSK/Rswx+Ltd7/YXkXA5ESHfo4der3X7qJ9lE/QIGFter5CU0/QoucLAseRGCs4b/T
 144j9pMP3gX9gz3LTfpgHT6Y7nG6lNJSLA4KnaEY9Bhk/TbFyEVYfNMQWyXfxyY/bcW7
 5izw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ErXDWGEh1vtgz6c5tfwAm1L1sVRSok/cS2FDWehGgQk=;
 fh=z1K73h+yJ7HQRrUY+A9JfBaOk1E4zbg0PkouGWGfh+o=;
 b=ZoqoSplAYkU90p82Delckm90j4zOkhAJ3It0ZvcIPd76K31p75eRrKYhGReMhIAHl+
 w/BKPRDWfYkSlk+QTW6n0fJGtidzKUJ3+LB/lXBLvxHs6iqG/X4wY2m3XIg//+h1lKcM
 q2ORb03yGFCmtXvV6WsYw3u1EVPuBYxzGndom1xK+DT/8JH0QJqE4xaELh4NfuJNlMdB
 oDS3HN+8LmJY8lxEglWYEf7uHI62XKpQw9VFwvzDfGX9BP8EjndcTGDJ87Qd0/i/2LzK
 z+FYIc1fFv9VXJI6Ha6t9TIXDpxM7fmVQBurmNwvBnLuagEcSO89jy7rUNpLdZdwbZC1
 Vjhw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785429136; x=1786033936; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ErXDWGEh1vtgz6c5tfwAm1L1sVRSok/cS2FDWehGgQk=;
 b=CbSropeLRI4f+eLw6XhGCFpd41CLI+GIsd4WwkVVSWlBqRMFbCvfkFpfoP5KWa4gYo
 MFE0sdhu8DmwWcDwArnzpoZylINxVNc8c6X8d5gz5OUPJYLi/2nw1nVV+zjAQCmwjmAf
 OVUYYm9oVInA0SKF0/2xFhxzr8M6zwdbiFqP8hvTcvNnzBYZs52IkVLuy+QD5OuyF/61
 YQW6r5arzbmaYMdhulxDC3mdkoBHXKn1OLH0IoN8nVwp1klrqH584oa3mJ+djAstLB0N
 qi7HNS78TWpvjnEo0/X0+/3jrcEmNeShGBGmuz1KqmV94+1Sg9DwRa5zps0OXNh1HDu7
 qgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785429136; x=1786033936;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ErXDWGEh1vtgz6c5tfwAm1L1sVRSok/cS2FDWehGgQk=;
 b=MKI9dKb0pxRK3mtTmZbTJXKBpGtddT9oQjAIULZfQhb7r5VGfWk1uH7/qe5Kp7xqOT
 G9qOAO7kvNJfGzo6fPI9FBMxip4DhNG7+tEjQZfZ3l1HK1Xas62G9ucwn0ACqMVwjm/7
 8A8MxCBgN0MTz6k8DN9lysx+ycIE3g5swfUHL0dtJ1XgLRuihKp1KkFHVX9RVYJrGxpo
 /KSaO9OVvZlCtpoCAHojxxE3PKtzS6kqHXbZFdA+JWZ63JTfCglqU8qdNn/0fz04RBHF
 C3EZYmnWi2zCRofNKUvMn4Z26qozDJymcYIYiEkpdfzEr3CUC9g+9FtBmNwS68ZfhDXl
 6rsA==
X-Gm-Message-State: AOJu0Ywl9DLyfcmujoUbIO1n0U2c8sWozp3cmYu4+x5NO2+azOFwCRGq
 FMuJ2G7oKt0VW+DtJogyifbt5ALKw7UjGIeahGakgDlFdTXSA6lSnezfKifudAEawBXqZd0LKlo
 R3l9RDEdU2soUD/VJWqhK2yz5k+Jy/EPhbsbRyd2b
X-Gm-Gg: AR+sD11rPa3ThtQhCVR9VeMU6dgnnUP6pJFtp6nQnwRd+CdHdpeq3p+3+wPGPkC6KRB
 EWshY8GKuZXvbdVm7AMSjRR8TBgkLVvxNuK66jbpFQPFSm4//nHC7En6E9/rxTHgfzUZTOqAw3m
 DN7OPwAdXRmqFK2P7PS6Uh5Ygz3+HBa12kW5QYekobt9b5R90Q/8x3gD9SOhhYGy10do61ARopX
 LYHdlMuzUeSkl/pVxmhzrhKvMJcAxuHAYyhz2t/L2Mi0l4lLeU8rpiPzXMztFwGgjOd2kySop3f
 ws36oEjOuh/E5tBl+3ha0YEHZdReRz5IGbi+ByD9Y9Gw9A==
X-Received: by 2002:a2e:a88a:0:b0:39f:6885:ddcc with SMTP id
 38308e7fff4ca-39f6d19e83emr6468911fa.24.1785429135704; Thu, 30 Jul 2026
 09:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260728141229.93878-1-stephen@networkplumber.org>
 <20260728141229.93878-3-stephen@networkplumber.org>
In-Reply-To: <20260728141229.93878-3-stephen@networkplumber.org>
From: Joshua Washington <joshwash@google.com>
Date: Thu, 30 Jul 2026 09:32:03 -0700
X-Gm-Features: AUfX_mwv3cUsw097Ca1EJxX0z20UqUVT2ZOOR3jpHxKiSssg9CyFtKNp2bb5fgA
Message-ID: <CALuQH+WpRLpWeQyT939DY5Hc9iZbWX1KxZ-_ZftBqZZqo3FnCw@mail.gmail.com>
Subject: Re: [PATCH 2/3] net/gve: remove unnecessary check for NULL
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Jeroen de Borst <jeroendb@google.com>
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

On Tue, Jul 28, 2026 at 7:12=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Checking for NULL before calling rte_free is unnecessary.
> Found by cocci/nullfree.cocci script.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Joshua Washington <joshwash@google.com>
> ---
>  drivers/net/gve/gve_rx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/gve/gve_rx.c b/drivers/net/gve/gve_rx.c
> index 567b82d020..932293ddad 100644
> --- a/drivers/net/gve/gve_rx.c
> +++ b/drivers/net/gve/gve_rx.c
> @@ -205,8 +205,9 @@ gve_rx_burst(void *rx_queue, struct rte_mbuf **rx_pkt=
s, uint16_t nb_pkts)
>                 if (gve_rx(rxq, rxd, rx_id)) {
>                         if (!ctx->drop_pkt)
>                                 rx_pkts[nb_rx++] =3D ctx->mbuf_head;
> -                       else if (ctx->mbuf_head !=3D NULL)
> +                       else {
>                                 rte_pktmbuf_free(ctx->mbuf_head);
> +                       }
>                         rxq->nb_avail +=3D ctx->total_frags;
>                         gve_rx_ctx_clear(ctx);
>                 }
> --
> 2.53.0
>
