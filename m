Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A2A606A325
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VbPX20GH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EED73402D6;
	Thu, 19 Nov 2026 14:32:34 +0100 (CET)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by mails.dpdk.org (Postfix) with ESMTPS id 588B4400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 14:32:33 +0100 (CET)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-8b4fb5d96b3so15399657b3.1
 for <dev@dpdk.org>; Thu, 19 Nov 2026 05:32:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795095152; cv=none;
 d=google.com; s=arc-20260327;
 b=qDLZh+opNSmcw/NHn/gqbDC+9HR5C7gHM19sjJb7oo+lAE9QfbViuT+qLkLZfXetla
 9HSk9VXgzvgLnmeeL131TYiCLZjlN+Lp0DkrePhR2yf0qsGvDA6NJ97EBxG9q2SdVvXD
 dV11K0NHzFu8X5pcpFML3nmgLvP3XT5MmnjQIhepvDoBdq1RkL+WsnccQDUy/4U2csVl
 plVatFt1AZ/k3QU1kwocHc9SkDbdthINWAh4qRjSOIY2CfSteJyHqLYXRJjQcx98U2Jy
 y5c8laMnflqQaU82ew6txw/xw/tTpDJvkezJOHSAWLMGx8uvvrJKjvmymtbPj8xv1NK4
 EA7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bdSygNot4PuYZ/v+jfdGXuTmihFCc//0SNod42iuTbY=;
 fh=zPq5NlxYzE2mG0LocsQ6ReOOGhzvIn8hlVZhH3k0wKw=;
 b=CXN8FtX0yTJrV/zkNdl4RdZtTV2j/xs6uhJkx64w0jAlbFsXLcPx72qjNQgqK3c0MW
 xp2B3TUDs3PldfPRG1gCwHVmCqcHBczN3HLzqngeJMl0goK0iDqXVtI3MVWP8D2IYTMm
 PFfLvbWL8odmj9aK93Rdu8odoDR9U/uRwcaxYNBRDjZL0SnIl6g5qwEYdyLuzFj3Yu8B
 yFsj/QuzFdLaV+kt3yPLWAYWW2G/RMvvm5xVd9YDacX3dhGNmaXHSLy7nmR8V4EYPyFn
 pgFUKaL9hs70wWjBTnWEuR/vly5K7ybSeSPuNOaU25ExYF2KW8bjfnNfmgUvtBdOI71w
 m6LQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795095152; x=1795699952; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bdSygNot4PuYZ/v+jfdGXuTmihFCc//0SNod42iuTbY=;
 b=VbPX20GHUrJTB+Hmv2g5hfflCcD7cCDvs6KV4cnhKoId8s0nSPWHPF/mbhAzACuD0Y
 wxTpthsXFK1O01HlHiQHWgYgbVRCNu2OWitaNjtlgJJgtcS0sxUuQj2Un35ZK7keIsdA
 yhZiuRRDerl7MSd4DdQDp8lptsOIuDO/tCAeWzNOWnwk58uV3+AY6j/8CYVb5iT/ydFH
 Xpqd29Y0BFwnDXSA8xq7nqiBNEyWbOeSqKJDz910VcpfCIswGS79SCL7JnPCIlcnUya+
 3Z2nzOM0Ni2/XnpePJ8VaQ8xG802X+IbzjFtLpGq3lBocI3T9rRqJck+T3DyTwndqKin
 hBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795095152; x=1795699952;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bdSygNot4PuYZ/v+jfdGXuTmihFCc//0SNod42iuTbY=;
 b=GZ6UyarbJo6Ix5Y3eT+1RYFIWlzsFDCp0PttrTHBeHFE9Km2auxSox+lxx1KNASHMP
 OjCu002hKKrr8AovbmrLG/wj8szgVD5uwI7lS2g95grdxwQ+AlyiYV7HbVg7DcReYM8Q
 KdD7lY9jGg8N8eelSR44BNVbhbPO9nzqZ/+53fn2RGo2XUIc7YqfCZqmW9oR2gWvo613
 c3h69F0Y1NL3JVjLMOiLlRtqCZFMNq1QvLt5OtSj4KVP01z/qUpTFeWKl2rhxPBbNy3V
 QVEjvksqSmog8qEexdwjViHg+L5auqHvUgcdEJrRUmygeyxN2kmbwfrKKDBMlXDeEt8r
 R3BQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGdeEvFZ7waNc9jTEYGoSgecH8Nh5lU02x0sP8fsWjYYNE3ZbScG5Kqomdoc4fnLbBF5Oo=@dpdk.org
X-Gm-Message-State: APuU4Z/CuEBgtDNrk+xyweKXcVDzhIIn1q4eHnR1uNNdtuDJeFzBCRBD
 n9wZEefkwJ6Rr3pJRtm1qqQPjmZS9U8afY/zUI3v6iRL5zkkNF9EJgbOZlpwKGmm600BNzbtMcV
 QC0Cf1U4vTivQ5f9Auu/875mmw9ZKXeQ=
X-Gm-Gg: AZFdTZecCt4pucsHkAWX1OajW06JV/RhGxNRZwSQ+SW+JtIF9T27CPgXeoKNQOoeP+q
 0f9Cm3/awSPy0K7EmW+M1t3TpktYHw1q0N8D1XlRE7Crb5ib50Jt/wdnyCNW9u+YEKhgw2qOPKd
 hc50SHfeINqDR3Zt7fesEHihWdKXce+03VHSiAX8hTveTlUZU1owFfYDU2MAG+y3ujB/C7cmybw
 NSz1n2IH03O3dTDPnwZzWT+42QvdNq7llYP1dikyl3jZWG8n7OeZuXHsyzcEGfaJKahTKWKw2bt
 4GJGjzncn0h9JPteUPVTKxlTygcyFJob6DK9sbpBbXBMtc5lYIOxkzvgW+nNS3AxVkiJ11D4MMz
 bzkPz3C0fpTpvxCftzo7nbwGJdHnkvWhttyK9b0uSqm6ctdFevJbNzWc+SCaHHxJz/pjMS7k7Jx
 9cBH5c9t4vCc7PVKjTRJclKOKMuKRqDQ/rG+usMV+K0E87vBxSphy8BY6yCa9BwAa0BPvGNptU7
 A==
X-Received: by 2002:a05:690c:6811:b0:8a7:ef2a:ff9c with SMTP id
 00721157ae682-8b518d313b2mr4042377b3.2.1795095151939; Thu, 19 Nov 2026
 05:32:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117164646.236458-1-hkalra@marvell.com>
In-Reply-To: <20261117164646.236458-1-hkalra@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Thu, 19 Nov 2026 19:02:05 +0530
X-Gm-Features: Aa3M54pPUX1tzEO7PzR73VQJZXq_awP9qHFrwPQ0TY4DtXT8ouaLnYbcq4e-Qqs
Message-ID: <CALBAE1MLg43LDiMxNVjG2YRoAkB0jaqUAxM5mQRqRK6MMxy8rw@mail.gmail.com>
Subject: Re: [PATCH] common/cnxk: fix inline CPT IRQ double registration
To: Harman Kalra <hkalra@marvell.com>
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, 
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, 
 Mohit Kumar Parjapat <mprajapat@marvell.com>, dev@dpdk.org
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

On Tue, Nov 17, 2026 at 10:32=E2=80=AFPM Harman Kalra <hkalra@marvell.com> =
wrote:
>
> From: Mohit Kumar Parjapat <mprajapat@marvell.com>
>
> Defer inbound CPT LF IRQ setup to nix_inl_cpt_cq_inb_setup() when
> CQ is enabled so the same MSI-X vector is not registered twice.
>
> Fixes: 42a7770cd0c9 ("common/cnxk: use one interrupt handle per vector")
>
> Signed-off-by: Mohit Kumar Parjapat <mprajapat@marvell.com>

Applied to dpdk-next-net-mrvl/for-main. Thanks

> ---
>  drivers/common/cnxk/roc_nix_inl_dev.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/=
roc_nix_inl_dev.c
> index bfdeef2688..f0703f3154 100644
> --- a/drivers/common/cnxk/roc_nix_inl_dev.c
> +++ b/drivers/common/cnxk/roc_nix_inl_dev.c
> @@ -420,6 +420,18 @@ nix_inl_nix_ipsec_cfg(struct nix_inl_dev *inl_dev, b=
ool ena)
>         return rc;
>  }
>
> +/*
> + * With CPT CQ enabled, inbound LF IRQs are registered later by
> + * nix_inl_cpt_cq_inb_setup() with the CQ-aware done callback.
> + */
> +static bool
> +nix_inl_cpt_irq_defer(struct nix_inl_dev *inl_dev, int lf_id)
> +{
> +       return roc_feature_nix_has_cpt_cq_support() && inl_dev->cpt_cq_en=
a &&
> +              lf_id >=3D inl_dev->inb_cpt_lf_id &&
> +              lf_id < inl_dev->inb_cpt_lf_id + inl_dev->nb_inb_cptlfs;
> +}
> +
>  static int
>  nix_inl_cpt_setup(struct nix_inl_dev *inl_dev, bool inl_dev_sso)
>  {
> @@ -458,7 +470,7 @@ nix_inl_cpt_setup(struct nix_inl_dev *inl_dev, bool i=
nl_dev_sso)
>                 lf->msixoff =3D inl_dev->cpt_msixoff[i];
>                 lf->pci_dev =3D inl_dev->pci_dev;
>
> -               rc =3D cpt_lf_init(lf, false);
> +               rc =3D cpt_lf_init(lf, nix_inl_cpt_irq_defer(inl_dev, i))=
;
>                 if (rc) {
>                         plt_err("Failed to initialize CPT LF, rc=3D%d", r=
c);
>                         goto lf_free;
> @@ -485,7 +497,7 @@ nix_inl_cpt_setup(struct nix_inl_dev *inl_dev, bool i=
nl_dev_sso)
>  lf_fini:
>         for (i =3D 0; i < inl_dev->nb_cptlf; i++) {
>                 struct roc_cpt_lf *lf =3D &inl_dev->cpt_lf[i];
> -               cpt_lf_fini(lf, false);
> +               cpt_lf_fini(lf, nix_inl_cpt_irq_defer(inl_dev, i));
>         }
>  lf_free:
>         rc |=3D cpt_lfs_free(dev);
> --
> 2.43.0
>
