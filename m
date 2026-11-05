Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799C6606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lM3IrHAy
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 763E0427A7;
	Thu,  5 Nov 2026 17:53:18 +0100 (CET)
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com
 [74.125.224.43])
 by mails.dpdk.org (Postfix) with ESMTPS id 71CE540E01
 for <dev@dpdk.org>; Thu,  5 Nov 2026 17:53:17 +0100 (CET)
Received: by mail-yx1-f43.google.com with SMTP id
 956f58d0204a3-67c11318ad1so242610d50.1
 for <dev@dpdk.org>; Thu, 05 Nov 2026 08:53:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793897596; cv=none;
 d=google.com; s=arc-20260327;
 b=Oemt9WAvmkD4swvYWf+Fa3PdOGuA3n6en020HOxPFwRDUSrdbp6d9Gt+IZhcd8l/CG
 Lfxq/Q4j3qdhIm6DcTbVaGJlgWpBT/nqQoY/Pg3LqzasBG8vfwNBRTqyQXznQI9/6ZyJ
 G5r13jR0ixctbUxtJn9qub1aRzTvGwPchZzSDU0vDVasnp+FcP2zejV7eaUGzosdW6RX
 nDQ0TVnHoa+dLgkvlkt3pjApvPfGcPg7LO++t9HQGdWvHaYCw/P0V+nELEMh9Qu5brSF
 QxnAtk+M2wL+usWQn8NJ6ZBPYOg4q/1GObUmCJOdLqc5BiJ97x09BWUDqAIG5aC/noAh
 6lzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Vs+PCM+FDVHLtgP67mdHrQOXUJP5yekIN431jx81d5s=;
 fh=nwIfjKpjHSIrQL/7OdILFiourEcRcYW47IhQIICD5sE=;
 b=VgfOfEeCZWgxQdhXO5VilTbJpFTZaA4YhcgjJP6g0tv8FUBjZkQ+BZU90Deh42ufA4
 1CZaCtTNVKyS3E30Y4sAEvIyTk/sfzMBhspxYSd1xySueydUbN86DwoW4w/QyRhEBCt9
 kjkPYRoFwSgUlvezSWHLS5EaOGoo7R0v+6Tuxd6DfVmb8G2CePnBUa3JJI8YWMkKMaUD
 hIKzPYCstqzvSKJtNhsLnWU5M91p7d8KuCDgTahxZ/V40vETlT2bhTVZ8vq+D9bFF3VZ
 DGTs9W/Dqgx7m95MBm4I/e4/7F8rYGtwIHLQLBpKsPK0P4cUApSdPsSq5yHyWy3ZJFI0
 7iJQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793897596; x=1794502396; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vs+PCM+FDVHLtgP67mdHrQOXUJP5yekIN431jx81d5s=;
 b=lM3IrHAydGjWJDPYKFwC+VQWMhE55MQ//qZqs5jVafQLZSAfUpYAzDOL5S65RfpYJu
 XW+nhllT3qP/E2QcEHaASG+S6b+78mt40w66McB0N6Ny9+oc3r8HfM6G9G4jWvjxP2SK
 m5mYBksgvWOn31FmLGKGzmU27D6hEdAze32RqHJML+6Q2WvrgI0x9zagI2vYMzE6YOqv
 bsnzEOZNtHBYWUgZokK5PZR+wuHL5hTFxKBEQbQTpamSg4Q/81Z1iVUVBr0zmT7o5Dag
 O33ADKEyXAAwmwCxbeXl9wpuT9QMKLRwFozuwKfkUBdJfCuK4ovNtGQ2cKf4UKedO+Qj
 vkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793897596; x=1794502396;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vs+PCM+FDVHLtgP67mdHrQOXUJP5yekIN431jx81d5s=;
 b=ZzNYlxR/D9dJvlDV9kH5dHAcmWcd7w8xlw0jUZeF5NS6mN4vpw4OOl9ZXCQcKVw8C0
 KLVe/txih/qTJlTdcQ5JnGYWc/BCzy0iUim3Dcf0Oh9lGCFwIkhT4sB7z9tIOmV4aLSy
 SP6MSGgh7b0bIXMBaf97LzNxEotsFc6cJ6PEeAceAjef0sWIVIGxbropHsm9D+CCRwl1
 sLb37v922SusrG01Q0dKzAjrlnn+gWLsY1nCJyl48nu4sqMROrlAtIaRaFdjwfouactN
 /V66zMUnFDLVQb0x4uYwL6mESsSZq5s8iQrFd+lqrfad19jz8SLxf8WWAPqumQYl+1DV
 R+EQ==
X-Gm-Message-State: APuU4Z+jYm7mwKvOt33wuCWWgg6gLiy0k4r/8u4EGR683oiahQAJjdh8
 7xdCOrqnNYERD1vx2+/JugkdPowQVvW97FQRQ0NlbEcbQ0SJ/bgrTnnFpSsIuuwW1KM+X6ujutE
 PphBQNQeC60MAzfffV9tWDl71vlcK/CE=
X-Gm-Gg: AYBFou1WikW/Ktr55zP124EGVLbBgkbaFB8o6Pwd7a37GqIpRafN//1p40mKkUILXD/
 3JGmuQv4H/wuplsVcUnBROETfAYXW+Yu3T7o4nskk9r+BThq22/Dq8wfpAM29h9E5toBRJlyGzR
 H8NrNvaNt+jh5MHAjOlYd2DtwnhZgfhIKXtij0qR88tjt13OcyDiR/e8Q9mSAJ3qdo7ZZvjfo7q
 8G1D0qfjnyxYPG6CMc9zCjfEfhyaI+EffIMj4yjlkxs+lQBEVQmKiAp0NgEWlFiCxEs1dgtsvGB
 9Pfo2rJCtuVJkDWUvV91tI60FV+i1LG4UvJ4J9GbyBIjYA5QpiWosTfvB2QsoFULCFcdh5CMvlk
 BVSwChNC83mb7gh1n104rTbuMWQXrEtBqwU4VH394YjoNjOW7PpQXzpRopOnKzLSZeKwVYPdK/q
 T/c+Il04i5gINOjyoyfeHSn2DNVr9rd5MuJQ1kxn01mSBpJg+tLlzkrH7dxUlRk78OgspotIeGp
 MEd8sa7ViZVIEw/Nw8B1RY=
X-Received: by 2002:a05:690e:4008:b0:67b:e431:4ad with SMTP id
 956f58d0204a3-67be431183amr4543562d50.91.1793897596137; Thu, 05 Nov 2026
 08:53:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102122154.2611710-1-ajp@marvell.com>
 <20261102122154.2611710-5-ajp@marvell.com>
In-Reply-To: <20261102122154.2611710-5-ajp@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Thu, 5 Nov 2026 22:22:49 +0530
X-Gm-Features: AclHuK_ui7edDXdxnuLxE6Gpn-XsiB-uUrlmlG5NBc88UhYNHHqTXR48-AALqKk
Message-ID: <CALBAE1OqRhap5UE+PMdDriZH3abTx14-YN8_ahTvYNQ=btMFCQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] common/cnxk: fix OOB write in rep count copy
To: Aarnav JP <ajp@marvell.com>
Cc: dev@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 jerinj@marvell.com, rbhansali@marvell.com, stable@dpdk.org
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

On Mon, Nov 2, 2026 at 5:53=E2=80=AFPM Aarnav JP <ajp@marvell.com> wrote:
>
> roc_nix_max_rep_count() copied rsp->rep_cnt entries from the get_rep_cnt
> mailbox response into the fixed 64-entry roc_nix->rep_pfvf_map[] without
> validating the AF-supplied count. rep_cnt is a uint16_t, so a malformed
> or malicious AF response could overrun the array (and read past the
> response's 64-entry map), corrupting adjacent driver state.
>
> Reject responses with rep_cnt greater than MAX_PFVF_REP before copying.
>
> Fixes: 162c77c18838 ("common/cnxk: add support for representors")
> Cc: stable@dpdk.org
>
> Signed-off-by: Aarnav JP <ajp@marvell.com>


Series applied to dpdk-next-net-mrvl/for-main. Thanks

> ---
>  drivers/common/cnxk/roc_nix.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/common/cnxk/roc_nix.c b/drivers/common/cnxk/roc_nix.=
c
> index 8e3903051d..ae6a918682 100644
> --- a/drivers/common/cnxk/roc_nix.c
> +++ b/drivers/common/cnxk/roc_nix.c
> @@ -589,6 +589,12 @@ roc_nix_max_rep_count(struct roc_nix *roc_nix)
>         if (rc)
>                 goto exit;
>
> +       if (rsp->rep_cnt > MAX_PFVF_REP) {
> +               plt_err("Invalid rep_cnt %u in get_rep_cnt rsp", rsp->rep=
_cnt);
> +               rc =3D -EIO;
> +               goto exit;
> +       }
> +
>         roc_nix->rep_cnt =3D rsp->rep_cnt;
>         for (i =3D 0; i < rsp->rep_cnt; i++)
>                 roc_nix->rep_pfvf_map[i] =3D rsp->rep_pfvf_map[i];
> --
> 2.43.0
>
