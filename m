Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C21606A322
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XxzqTGnD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8510F4026E;
	Mon,  9 Nov 2026 15:15:39 +0100 (CET)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by mails.dpdk.org (Postfix) with ESMTPS id 73D824025A
 for <dev@dpdk.org>; Mon,  9 Nov 2026 15:15:37 +0100 (CET)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-8b300713befso6323667b3.1
 for <dev@dpdk.org>; Mon, 09 Nov 2026 06:15:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794233736; cv=none;
 d=google.com; s=arc-20260327;
 b=kAPC2uHv8Y1Watkokwxwz8Xwaot88wDDJFrjnDH2QHd7Kr7KDloE53fEoHU+4OKX7j
 CVz+v490Hgu8S0mHCRCgw6TU1JongD8GR2uib3YQ0X/f+OspRJBYR92CyV3AZOBcy35c
 D0gX18M0iNAmTQgVm72JVLhgtzpPcuzMleWe0uK2eq8Mg2/AczWJXHz43E+PRKAIP7eQ
 y//wbxRad70KSbb6QbQlCSlPNyv0o3sW3sqFEy6qw+N47eel3iXs1mcXeT4auPM2S/MF
 5xjnB4pq9kb3CEn+nXJ2Z+pFBhgp2oauQfbTzSpvYZrM7f9kuB2/NYe2X6qtM9uTzEpq
 OxCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yOyRZjNOAwJYnyaD+N0AMwWPRWTQXiW9T2zs//nAUi8=;
 fh=H2JmReDWbs6nSOBFm0L8vgBZ73MRnb61PIpZGjSMkTI=;
 b=gqVZ2nT/QsXJnpH5CBI3dS0hMZLbgMlG2P/s7FqJpLFYz7he1XbnbLILQZQUslHGHp
 bqAxbDwRDeG6kHGhGAEyi2S7G5nC3/PU54V/wkYfnUlhkIFsNm/pERCEO9LogJ6FvVJX
 qAfHrHdLM27aldvc7Jhzng1N0Lts8b8Ggekf+DHHxAPvGmw25+sjfzKLb4/2q2naCH1U
 /C/IJfiTyvgji+7Tzvpm/JVeL/duer+gLqObc3UB7LhEmay0ITQVvnwufmVJsAr9ULI+
 JddckDiBTPplmkNNP5pURH16Bw3EdgAfKDku/LouS9rnGJfC31hcDlpJnYnKzdkPK2Ef
 JDGw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794233736; x=1794838536; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yOyRZjNOAwJYnyaD+N0AMwWPRWTQXiW9T2zs//nAUi8=;
 b=XxzqTGnDqDiZ9VjTNrf6E0JfsHBGp7GpccY2IQ48tcVH/xscVNeaUDdKP/FsS0dV9i
 8jENm5TUw0KVDNboCbfPl5PRBbu9dIG7nOX1qMxDAluvSFFcsO8RAbhXxBjKPofnocv1
 EVvFdezNqvgylp9CZbU0frUhqMo1ECnNRffLxpuSZmkBkfK6EwIerANwkBX0OBMTdpKV
 i15fRGiBcfezn3xPSdjNqu39IlcDW+w+YW8pQgjQcGZyPC3s3WxpavjRStv6deXBK88o
 6ECYGss5oXpt4ff+bC/JaBcoy3hTh08BJePIeT19kj1v5vF0PTVlldyPs0CZ3+wYEnui
 2Hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794233736; x=1794838536;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yOyRZjNOAwJYnyaD+N0AMwWPRWTQXiW9T2zs//nAUi8=;
 b=aCgdQnXgGpifY1zREKX39oedZ+oI3SQbIMs1jCjEQQpdByAEbl4cob6+9vfrHn/cPE
 +5Wm6aOqoXhRhaLJwA5CjJalY3dimE5oFHxRtsiiv6SexyMkaz6GS4J7rdNg4R2TTlXL
 1sOFTkcXRyBk1EuaZ1P2e/gXuub6gVNNMCxkOw5616XraOX1DcTzR8mnr+dZmeM0crjB
 orfHhnm9kMN2937Sd6qyIeIsHPpgSF4FvaEkvpL0ahXLaeFKlEB7M7r4mg6vU61LDZ1r
 xR0v8jFduU8zmw1k2Ip+a1wnDcBOsRpzQtuRx0vZ41GhpStxuBiEQbrPNq9wVqTDSUBE
 GrfQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHvvfPj1UvoZ5qWGXNh13FaJ/HcDuW2qYJboCa61R/j3+ILUHX5Jp+WnNGNhJ/FTfEtKdc=@dpdk.org
X-Gm-Message-State: APuU4Z9K+v9ZL7kjN3ve+OXDvxicTZqsCVY1lVAbvDqAwUQYv5ZmMUAR
 GpQEKl0NtUosCAHciS29F2PMEPJgN49znVRxjsjJ1DmDkvMpBRwQXK4m5r0fYipfVTPitBaI6aW
 xG+Lfp9qx3aH8htTCuQWyxQ3K9UqPpIM=
X-Gm-Gg: AYBFou0HX9+b/KhS9U4i7GxjlgaVC/3lAPPSjXHHKjziOl+yIe/tC3sVFXyo/kYHIgQ
 Goe8yiz3DdW8EDF/1DTwO32jGfEvib/V6Kc05ZI1U005yLVa7eBShd+tjC2fbkUbAKRRNgV3RmH
 yWPpgG5jXSkp1+YrJ6dK1KWH/DxZEdINEaQ1PjTLPfZ0x4ch8KFNU64fkKHEDcK4vwBUMlFfBe5
 OVHpzhSyejpC8HIj24FZv7SFRfJK0OMoek4ES3mUpmYrSCj5FuyZ1gkQ3DTRDpBbOUjOmI8eE9p
 WePrlruPrYdNB90dK1NVwTtBAoPPRq5eFS4dsDziDXUrFEIgnfWMRbhPVPdnncx8k9W35x3fG7h
 FfAjsCMOe5yXpSXOb3AlvjM3lmOjaCKtUS8LvF8R50cSs6YHiVyyOq8rudR/TdgplsNXsFyj7gt
 GZM7fu5NBDfpIiwnekMeSyV3q374u+O9sy/Vtr8cRlAQ2gbhLiTxBPyF6AjiFlcu9lD9KZCn9FO
 A==
X-Received: by 2002:a05:690c:dc4:b0:8a8:7e5a:dc2f with SMTP id
 00721157ae682-8b36c9c1baamr25376747b3.12.1794233736221; Mon, 09 Nov 2026
 06:15:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261107051139.37923-1-pbhagavatula@marvell.com>
In-Reply-To: <20261107051139.37923-1-pbhagavatula@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 9 Nov 2026 19:45:09 +0530
X-Gm-Features: AclHuK-QxbOcM20lWUOra0EUmOyowPQYo7LzAqHQNSLk5YRrTDN6W4yf35m1Q9I
Message-ID: <CALBAE1NhORNXiS=MH66eXbMRKcqQbpC+GO8OMug50rYGNk-u+A@mail.gmail.com>
Subject: Re: [PATCH] event/cnxk: fix new-event burst enqueue with LMTST
To: pbhagavatula@marvell.com
Cc: jerinj@marvell.com, Shijith Thotton <sthotton@marvell.com>, dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 7, 2026 at 10:48=E2=80=AFAM <pbhagavatula@marvell.com> wrote:
>
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
>
> Add an I/O write barrier after LMTST submissions in the new-event
> helper so the stores are ordered before the next iteration.
>
> Enqueue small bursts, below one LMT line of entries, event by event
> instead of using the LMTST path.
>
> Fixes: c3320d21b475 ("event/cnxk: use LMTST for enqueue new burst")
> Fixes: b08b193bceab ("event/cnxk: add CN20K SSO enqueue fast path")
>
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>


Applied to dpdk-next-eventdev/for-main. Thanks

> ---
>  drivers/event/cnxk/cn10k_worker.c | 9 +++++++++
>  drivers/event/cnxk/cn20k_worker.c | 9 +++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/event/cnxk/cn10k_worker.c b/drivers/event/cnxk/cn10k=
_worker.c
> index f33c3a561a88..a8ddbc5d8bfb 100644
> --- a/drivers/event/cnxk/cn10k_worker.c
> +++ b/drivers/event/cnxk/cn10k_worker.c
> @@ -350,6 +350,8 @@ cn10k_sso_hws_new_event_lmtst(struct cn10k_sso_hws *w=
s, uint8_t queue_id,
>                 roc_lmt_submit_steorl(wdata[1], pa[1]);
>         }
>
> +       rte_io_wmb();
> +
>         left -=3D (sz0 + sz1);
>         if (left)
>                 goto again;
> @@ -395,6 +397,13 @@ cn10k_sso_hws_enq_new_burst(void *port, const struct=
 rte_event ev[],
>         uint8_t queue_id;
>         int32_t space;
>
> +       if (nb_events < BIT(ROC_SSO_AW_PER_LMT_LINE_LOG2)) {
> +               for (idx =3D 0; idx < nb_events; idx++)
> +                       if (!cn10k_sso_hws_new_event(ws, &ev[idx]))
> +                               break;
> +               return idx;
> +       }
> +
>         /* Do a common back-pressure check and return */
>         space =3D sso_read_xaq_space(ws) - ws->xae_waes;
>         if (space <=3D 0)
> diff --git a/drivers/event/cnxk/cn20k_worker.c b/drivers/event/cnxk/cn20k=
_worker.c
> index 8c1df3dbafc1..c15e3cd46ae7 100644
> --- a/drivers/event/cnxk/cn20k_worker.c
> +++ b/drivers/event/cnxk/cn20k_worker.c
> @@ -308,6 +308,8 @@ cn20k_sso_hws_new_event_lmtst(struct cn20k_sso_hws *w=
s, uint8_t queue_id,
>                 roc_lmt_submit_steorl(wdata[1], pa[1]);
>         }
>
> +       rte_io_wmb();
> +
>         left -=3D (sz0 + sz1);
>         if (left)
>                 goto again;
> @@ -350,6 +352,13 @@ cn20k_sso_hws_enq_new_burst(void *port, const struct=
 rte_event ev[], uint16_t nb
>         uint8_t queue_id;
>         int32_t space;
>
> +       if (nb_events < BIT(ROC_SSO_AW_PER_LMT_LINE_LOG2)) {
> +               for (idx =3D 0; idx < nb_events; idx++)
> +                       if (!cn20k_sso_hws_new_event(ws, &ev[idx]))
> +                               break;
> +               return idx;
> +       }
> +
>         /* Do a common back-pressure check and return */
>         space =3D sso_read_xaq_space(ws) - ws->xae_waes;
>         if (space <=3D 0)
> --
> 2.50.1 (Apple Git-155)
>
