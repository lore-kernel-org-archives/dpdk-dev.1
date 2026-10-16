Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB45CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 18:33:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4213A40291;
	Fri, 16 Oct 2026 20:33:19 +0200 (CEST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42]) by mails.dpdk.org (Postfix) with ESMTP id 232184026C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 20:33:18 +0200 (CEST)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6ae14eecc64so194833a12.1
 for <dev@dpdk.org>; Fri, 16 Oct 2026 11:33:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792175598; cv=none;
 d=google.com; s=arc-20260327;
 b=EOlsG7g2Th1UHvwn9jm4NcuBi5Sx0E97jFQXefAtUeCzzmsq4lEa8SkyyUc/bL+XO9
 7qSW7iuYYXYXGRx5CdFtsVbSm57O8OTK6uBpGMnnRJhd3t1miJSWHpAJrlbV+ATmmwHG
 L1C4VJ0uLaduzawzhW24vBytP981554Ku8NcXm11EYbX9J+CuXUUNV20YAiVnFeNEohc
 gRYaQusmlKIJ6SZ9dsyQQMY77+/S38DsJ6HxUUVLf65sMhOkhZ+Md83+6840GezyVv7a
 ErcKsI+gIg9Kn/2qoA210d/UMAQbOLhJ/sffmDyR+gYpLH5su5vbKBsazsfkYHWWAL4K
 CJkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YnvLIeF42QatfihAxQ7bf54W7PLxRWg+JahYLphs/4o=;
 fh=vORWBWpPiOMEAwQ4TXFX3ahBFQQ38jIhY0mpNDlQfUw=;
 b=UVJgqpivnMHKwl03n4N7rjyYn6qrSOAq6j7zBoWVgOe7V7dzfS1C3R5pVQyTkplJKs
 ScbbvptV0Zt+M5svph3mZqd522+kHnKRt4mqmtNhGHdF0+BfKWPkD1rBQE1eLJq3lACx
 H125I72FRUa/5x3SNyVCbEi76BB9RVndHWTUlegRjX5XVSdgc1AW8mK8fVi5WW8xgyZS
 jQl2yzmObD0a44cQe0zRhOGluHcwLl+4rtTzhu7hwGf2nRzCzcEYvvn4sDoaM9wVSFO+
 Gd5+pPksmGA6jYpUSryJ2szohF4s0TDT0kpYMdaYQDUMXmnyyXkduHIS+WnSgcFDPvn7
 IiPg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792175598; x=1792780398; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YnvLIeF42QatfihAxQ7bf54W7PLxRWg+JahYLphs/4o=;
 b=UkG4Bl+8MoUcHDHzJ6O4zKvuw6G85NJgrvbfBmHELPMtTx+Yt5ifpnwEjw4swE3ViP
 Wq49ugP3wYvqs2XkFURzfALr3pRj49V/DNMBBSJqQlmlNcMvBQ5bBjh/dhDeLM2lNAlw
 X13TfxHOnWhZlnnay7P+G6wSonrJT0sgH59PkRm3dLDK8gZdHrAwtTg6ThsYk7Dw5LoD
 HnHR5QxDpCqozvrHlxA+CkDjQiG2WoljH2zmBZdX38Tz2j//uQq8gqdqkx5KVXoFs/AE
 /VkCtngEjpZnZio9UK+avSBO3qovEnENV2m6A0q04Xi/3Jj0XbBKVSNDicJu3nAeVc+u
 zjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792175598; x=1792780398;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YnvLIeF42QatfihAxQ7bf54W7PLxRWg+JahYLphs/4o=;
 b=Rjq82FrDVrEeu6DmZB5/Mv18000P8NgttwXChPX+0ERsVMe7e9kTsv5l3V7kOELeSi
 nGcq+Le7f2M2uAy4bQF2u3krkAtkxKkJyfuALFJUXcprHUmYituXcYQMDqpdY4v4xbTV
 qIO0LIx77D5gjm6WGtHKzE+K1onA55Zor1DV19LvMeC0O/CbWkVEvjwMgoBdVrF2V/RX
 NeLCKwQ0h1hVaaXVPB2duS1deFbCaxGFFRLJzxzTYdlCSnsvjGWGayWSbBSTeyzvsjJd
 LpyHmuc1o1T0dyKrTdvFavoTBiIGaStoglPkG7FqCxixOZCqZlps5uMennYLTfr170dk
 zu6g==
X-Gm-Message-State: AFq9FYJao+6JAjqQxFoV2eZwn+GClGcEpcXi292avfTAiF+6+uKKuHhu
 6xgdty/9nYaiT9Narm8C0vNC7nFTfyxu+PwKMfKm7aw+NIiAybdGIkfxqoEC1aH3GOyJfoEDM9A
 G36AsxoSjbYtTtA7EUsy1gaOGiDEbsIZpGwHH0PwN
X-Gm-Gg: AYBFou0FSiv+xCQVx+hAdLkPLsXG1bTcUfIqKzq8tBlbgBrH6PdXTD5+no4e8kAV9jQ
 V8e0oeEu+yT8rC+a7HWRzXXXeUwkuOjSRH4WPndQ9PoZhm5nFWivvG7vUqeK/iPcWu/PRHgfYUu
 hkOJGxZlmZ85qzOHrIUORrBb9znKpt+jUeqOW6ISgvDxvwm8wHF265lCz7y0eig20oSXK/M6mPB
 hjaXwzHLt4JEPswwI5hrghZf/54COH7SXK6dbWXeTiuvWwU4Bw+2wUXEbGGJbDpvOPxfVsxq7Fq
 hq8U11jzxVr6wVZ5suol6fe1fOjLF1mLZXPU/eolVXbJs7fD4lo2R3f8
X-Received: by 2002:a17:907:3fa0:b0:c3f:2b28:713d with SMTP id
 a640c23a62f3a-c419dc367ddmr51664766b.19.1792175597072; Fri, 16 Oct 2026
 11:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1792170902.git.tathagat.dpdk@gmail.com>
 <974e46780a800b596c6e747e0716afc579d58433.1792170902.git.tathagat.dpdk@gmail.com>
In-Reply-To: <974e46780a800b596c6e747e0716afc579d58433.1792170902.git.tathagat.dpdk@gmail.com>
From: Joshua Washington <joshwash@google.com>
Date: Fri, 16 Oct 2026 11:33:05 -0700
X-Gm-Features: AclHuK8VUYqZaVA81kwkdaK_vvofhyuWE3mZy9MJGsX3xAsvpjKps4jeL6VFk-g
Message-ID: <CALuQH+XPnK4frF_MU5z7uhp-WKo6iZiaxKYc95qQh+ZAxRVJzg@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] net/gve: enforce DQO TSO header and length limits
To: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 stable@dpdk.org, 
 Rushil Gupta <rushilg@google.com>, Varun Lakkur Ambaji Rao <varun.la@gmail.com>,
 Ankit Garg <nktgrg@google.com>
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

On Fri, Oct 16, 2026 at 10:46=E2=80=AFAM Tathagat Priyadarshi
<tathagat.dpdk@gmail.com> wrote:
>
> TSO packets are not checked against the device limits before use.
> The device requires an MSS of 88 to 9728 bytes and a payload of at
> most 262143 bytes, as noted in the Linux driver. A packet outside
> these limits triggers malicious driver detection, which drops it and
> disables the datapath, stalling all queues.
>
> The missing checks also break the driver itself: a tso_segsz of 0
> divides by zero in gve_tx_validate_descs(), headers longer than 255
> bytes are truncated by the 8-bit header_len field, and headers not
> contained in the first segment give gve_tx_validate_descs() a
> negative first segment length.
>
> Drop TSO packets that violate these limits and count them as
> invalid_pkts.
>
> Fixes: 403c671a46b6 ("net/gve: support TSO in DQO RDA")
> Fixes: be8f0eb81f98 ("net/gve: fix DQO TSO descriptor limit")
> Cc: stable@dpdk.org
>
> Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Acked-by: Joshua Washington <joshwash@google.com>
> ---
>  drivers/net/gve/base/gve_desc_dqo.h |  1 +
>  drivers/net/gve/gve_tx_dqo.c        | 14 +++++++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/gve/base/gve_desc_dqo.h b/drivers/net/gve/base/g=
ve_desc_dqo.h
> index d50d88765e..53e394f01c 100644
> --- a/drivers/net/gve/base/gve_desc_dqo.h
> +++ b/drivers/net/gve/base/gve_desc_dqo.h
> @@ -14,6 +14,7 @@
>  #define GVE_TX_MIN_TSO_MSS_DQO 88
>  #define GVE_TX_MIN_PKT_SIZE_DQO 17
>  #define GVE_TX_MAX_PKT_SIZE_DQO 9728
> +#define GVE_TX_MAX_TSO_LEN_DQO ((256 * 1024) - 1)
>
>  /* Basic TX descriptor (DTYPE 0x0C) */
>  struct gve_tx_pkt_desc_dqo {
> diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
> index f686a8c110..52fcdb285a 100644
> --- a/drivers/net/gve/gve_tx_dqo.c
> +++ b/drivers/net/gve/gve_tx_dqo.c
> @@ -127,11 +127,23 @@ gve_tx_clean_descs_dqo(struct gve_tx_queue *txq, ui=
nt16_t nb_descs) {
>  static inline bool
>  gve_tx_validate_pkt(const struct rte_mbuf *tx_pkt, bool is_tso)
>  {
> +       uint32_t headlen;
> +
>         if (!is_tso)
>                 return tx_pkt->pkt_len >=3D GVE_TX_MIN_PKT_SIZE_DQO &&
>                        tx_pkt->pkt_len <=3D GVE_TX_MAX_PKT_SIZE_DQO;
>
> -       return true;
> +       /* Headers must be present, fit the context descriptor, and be
> +        * contained in the first segment; the payload must not be empty.
> +        */
> +       headlen =3D tx_pkt->l2_len + tx_pkt->l3_len + tx_pkt->l4_len;
> +       if (tx_pkt->l4_len =3D=3D 0 || headlen > GVE_TX_MAX_HDR_SIZE_DQO =
||
> +           tx_pkt->data_len < headlen || tx_pkt->pkt_len <=3D headlen)
> +               return false;
> +
> +       return tx_pkt->pkt_len - headlen <=3D GVE_TX_MAX_TSO_LEN_DQO &&
> +              tx_pkt->tso_segsz >=3D GVE_TX_MIN_TSO_MSS_DQO &&
> +              tx_pkt->tso_segsz <=3D GVE_TX_MAX_PKT_SIZE_DQO;
>  }
>
>  /* Max descriptors a single packet may use. A larger packet can never pa=
ss
> --
> 2.43.0
>
