Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3257CC5CFCF
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 02:35:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E00544013F;
	Fri, 14 Aug 2026 04:35:24 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 46104400D5
 for <dev@dpdk.org>; Fri, 14 Aug 2026 04:35:23 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-84e84a6c4bfso475733b3a.1
 for <dev@dpdk.org>; Thu, 13 Aug 2026 19:35:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786674922; cv=none;
 d=google.com; s=arc-20260327;
 b=PTZudcPSj7E/e3GJKmN1pgTT5VGPHLoebPEMM/eCorhLrko5rQkQxq9/tIl4cLHIEk
 A7LI3Cj1mflAChLQMgv/XYkiOsYpG6TlVMSBnWuXD3lsZpM8yWtHbcT2qhg9mRm9YFuz
 v/MRt2VQ7ghrbc09gaseCDgsUV+9fAeOyo6WM5KAvPNwXiL+wmYOPLZxEMMJepmLSpws
 i7BHpozRJ4rmQnlolw2Q9jyjQB+CkORxaQrMQUuDOlJxIiT5XOzMbvDEsMb7JaRKXW6e
 QtEBWmbJhxi1PDDMpXxHaGFZZ4XcQsk9X3AD6o0wVCdOTtPkPt7+SGZxbeqc3y7W1Xd0
 XlGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bEQXcNo9CUMdPTcBSrn7X2eWvuwWmoSB4uIlwDb/OzU=;
 fh=yT+JBp1b3HLlpCKg4F9Fks0VNI1PmU4Oczw6HxCvx6Y=;
 b=iTeoOrruyrhzUNRD+83Jjyuk2h6WgGf2XVd1MlbERyc5u1rWrVNd4wJ16gHKrNqYwK
 L52JxbIDmw4h6FlxULKbNBNFz23gN+1ehVfXEmmd0bkVZmQgis53/2WlL8B25fhjXzt5
 dTlsiQdk05wm9xl9pTGa1XejH1rTHl9kzaSclGMfnSh+ztt64aOkBMJaTBq02Mc0a8n6
 hSNNi8F3qKjBlrk+hEVWBNRRZVlHR28zbNfOuNp/P+nuV1ba8O+/dUYo+rESLYgcySAx
 2l5GI/dBpOAxuL2Xm0MDbeULtrveX1afO7NddRJg9j5A8TM9tj4wMktfmA0f5RbU4EPA
 vQ0A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786674922; x=1787279722; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bEQXcNo9CUMdPTcBSrn7X2eWvuwWmoSB4uIlwDb/OzU=;
 b=eNuzopb9EG3Kjrxj/H+gHlCNpeIexmzdb1LVIkLMVOEyX/YQIdeZ4qhA/jw2GjW50s
 iF1dIXiFkMeazuuOlVKl80PFoAnUpZYueHyPdwlbn2wxVOo7MMsMelQgbVPtiXvFV4fQ
 IvXZVjaW2v7/R0oUPsxpsOrJZpQjLm7wrvLCVLrN2oUJkaJSgWRe9EhPuPj2aXvYE5kY
 5F1He+ipzE5+1jCwaT/hH2bKMpx7TOzs5mLK5URXDUOjA6CfrGWM2hEpz0O/vVWRL5Lk
 ThzBWyn+enhy1cUMei0v3lmCN9Gyqu1RH/pWClW7ybxEmQpMCdUVPw46uxEH7psIMJZt
 ScxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786674922; x=1787279722;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bEQXcNo9CUMdPTcBSrn7X2eWvuwWmoSB4uIlwDb/OzU=;
 b=eMCIPvuDOtTtkpTWSCnZZzAiT37EuW20fY43o7dOLidJeGS9Ysp1eei6D6h4zaknTG
 1jaBRUEkgNPdV0EzxzKpcxuVvfZ2L5mETUmeMxKQRnRtLtui/xX5Ws1NEZHlKM+aaUjO
 F50McsjhjmCgvQybR/rz9E1nAOEfnZ4Y6Vg5JnxHLTXCDUHfwvKV+/3vqqsd18nCb5wG
 XsLV/HV44+iEJiVw8rAFtlPAuW0sUqSDnN6RcilRj81XHAej0fPEOKjr56nsQf8tKcSw
 Wn3NXzNwuDlvrymi6Kd17Uv78zDXotVG5neM49hFwsdlprFtbaiHWVgbn/rK9LRW3SdD
 HiYA==
X-Gm-Message-State: AOJu0Yzdp+nmzPNp+s+s8cq0nBYOn/4Ylq9qzX8p1w4zzqkUhMNfy/wD
 iI/J5dtNg4BDjVoshyHbpGjc3LDRHJwdU6XbXwDujIsYIWGwT17MzDKKiHDl8m6kbwSn2Ukg7v5
 BwevSppVfPwuglFeoSSIO7G1LWrLbEPg=
X-Gm-Gg: AR+sD11eD3QPXaefUGlYiSeW9rBGFbtqXvHrHQlrxtM319jdGBwlzVtFmrIPZ3+UeAD
 L0dqkjtx2AVarDJn+rPrPm3z/po2LwT6lKzaBE7N/qjODVvlGEyY6fT1rPyyUkWdvIUIpnk9RVv
 QxU/8OyNL1M+oQ4Jsx0CZHMMFZX95w+9WKW62WQKMllHA0wBoq9xr03E9pEwReXkggPQlQxWsvG
 +cq1ntrnZo6Fg7jrMp6PJNdLBxsAHzttcTMjVX2nXNB+s6hWWhcwioKS2u0RRFuqTkJxVC6ti2u
 OE7DlkNQHa4ZCPOtJI7jAAA8wGqxf4CfwsW2RmNaRuXL
X-Received: by 2002:a05:6a00:a241:b0:84b:9a69:156d with SMTP id
 d2e1a72fcca58-84fdc455fe6mr2477235b3a.0.1786674922086; Thu, 13 Aug 2026
 19:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260726170258.8791-1-wpan3636@gmail.com>
In-Reply-To: <20260726170258.8791-1-wpan3636@gmail.com>
From: Weijun Pan <wpan3636@gmail.com>
Date: Thu, 13 Aug 2026 21:35:11 -0500
X-Gm-Features: AUfX_mxFZI2eNuKLyDr8_E_1M4m7WZ3LqF5P1XNRGS77ltkTN_1S-v4fEUEvFu0
Message-ID: <CAMEmXszu52qpoNLkmOo7ycYG278j6uQt_wvfqK8iNYDkSWW2nQ@mail.gmail.com>
Subject: Re: [PATCH] net/vhost: preserve Tx ownership on VLAN failure
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Jan Blunck <jblunck@infradead.org>
Cc: dev@dpdk.org, stable@dpdk.org
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

Recheck-request: iol-unit-arm64-testing

On Sun, Jul 26, 2026 at 12:03=E2=80=AFPM Weijun Pan <wpan3636@gmail.com> wr=
ote:
>
> The Tx path compacts the input mbuf array after software VLAN
> insertion fails. Later packets are moved into the failed packet's
> slot while the failed mbuf is freed.
>
> The returned count then no longer identifies a prefix of the original
> burst. An application freeing the unsent suffix can therefore free
> duplicate or stale mbuf pointers.
>
> Stop preprocessing at the first VLAN insertion failure and leave the
> failed mbuf and the remaining suffix owned by the caller. Count only
> packets prepared for vhost enqueue but not accepted as missed.
>
> Bugzilla ID: 1884
> Fixes: f63d356ee993 ("net/vhost: insert/strip VLAN header in software")
> Cc: stable@dpdk.org
>
> Signed-off-by: Weijun Pan <wpan3636@gmail.com>
> ---
> Cc: Jan Blunck <jblunck@infradead.org>
>
> Tested:
> - Full x86_64 debug build with AddressSanitizer.
> - Two-process net_vhost and virtio-user data-path test.
> - Forced VLAN insertion failure on packet 1 by removing its headroom.
> - rte_eth_tx_burst() returned 1 and preserved the unsent suffix.
> - testpmd received 1 packet with no RX errors or missed packets.
>
>  drivers/net/vhost/rte_eth_vhost.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_et=
h_vhost.c
> index 05940f2461..9a85f1e26d 100644
> --- a/drivers/net/vhost/rte_eth_vhost.c
> +++ b/drivers/net/vhost/rte_eth_vhost.c
> @@ -474,19 +474,17 @@ eth_vhost_tx(void *q, struct rte_mbuf **bufs, uint1=
6_t nb_bufs)
>                 /* Do VLAN tag insertion */
>                 if (m->ol_flags & RTE_MBUF_F_TX_VLAN) {
>                         int error =3D rte_vlan_insert(&m);
> -                       if (unlikely(error)) {
> -                               rte_pktmbuf_free(m);
> -                               continue;
> -                       }
> +
> +                       if (unlikely(error))
> +                               break;
>                 }
>
>                 if (r->internal->tx_sw_csum)
>                         vhost_dev_tx_sw_csum(m);
>
> -
> -               bufs[nb_send] =3D m;
> -               ++nb_send;
> +               bufs[i] =3D m;
>         }
> +       nb_send =3D i;
>
>         /* Enqueue packets to guest RX queue */
>         while (nb_send) {
> @@ -506,7 +504,7 @@ eth_vhost_tx(void *q, struct rte_mbuf **bufs, uint16_=
t nb_bufs)
>         for (i =3D 0; likely(i < nb_tx); i++)
>                 nb_bytes +=3D bufs[i]->pkt_len;
>
> -       nb_missed =3D nb_bufs - nb_tx;
> +       nb_missed =3D nb_send;
>
>         r->stats.pkts +=3D nb_tx;
>         r->stats.bytes +=3D nb_bytes;
> --
> 2.34.1
>
