Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1F7C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 08:43:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D354940281;
	Mon, 21 Jul 2025 10:43:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E151E4021E
 for <dev@dpdk.org>; Mon, 21 Jul 2025 10:43:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753087401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YEWgHfdvl+b9gPYPlfa74wR/kS5Wcnuda+6fGCXGJdk=;
 b=VdNwaMi4azHFQrGKfDnx5mIjhYFNgywF+24D5/Wh4H1Z9nZ+8wx6qQgQoee2LG3mlpvYkr
 i23vRvxU45gMk86juxynb56B2vBbRiJ6caAaPJY2ZTkhMm1vZsY9c/wuRLQDMKJHCJVb+J
 SjWpDGOyRDmMIdO++zH57yREdVkSei8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-MrK8oqIWPGGsr24mOg60PQ-1; Mon, 21 Jul 2025 04:43:19 -0400
X-MC-Unique: MrK8oqIWPGGsr24mOg60PQ-1
X-Mimecast-MFC-AGG-ID: MrK8oqIWPGGsr24mOg60PQ_1753087398
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-32cd003e8abso17327511fa.3
 for <dev@dpdk.org>; Mon, 21 Jul 2025 01:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753087398; x=1753692198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YEWgHfdvl+b9gPYPlfa74wR/kS5Wcnuda+6fGCXGJdk=;
 b=pbuszmd3n9Eemyre4qDRxtdfBlDmN8eYR59crFZDkwSLDS/YrIIFptIoPz1LS02tkY
 wXE3PcCAMeNtxffeN8vmuF469pKGDD5VM/RMS7VKf0ShAZ9JeFA4yZ5pzpz9g1BOZV+w
 jxjOSBpue0azHMGHGv4KXJ2PQk7KvlNevOmLxd3eClQs53ua6coWBXFppELcM2wDaH24
 ZNld3JNmLRzraLw6IC/yrOV9etzsHHT4O/zRZC18CRh0deiRUB4UGnW/W6GhNYAqCLhd
 4BASAPkoM3hZemDDzk6HqZxqTReWkgT9Drn5PdsiQa/3nude7zY5MyNFehfsBbt4CUnA
 qcSA==
X-Gm-Message-State: AOJu0YwBMec2F1JRru1K+aGdlFTqMMiZXTNmfjokuNDD4P7M6kVmT72c
 97S8LBOrbJpB58zsjLhV7LngNKRdgru3n0jg6m++4sEbdMcLFDnMt814JXOhFqVWS9Yfv52GMjs
 cEDOnosmNM9Xr529R88otRnWBvkNZNT0wR/meLxGYzmifXHECnnWQtK7Lg6l/FhagGdHC3FFWkF
 4KF4qKYyf0Ig71hORyZS0=
X-Gm-Gg: ASbGnctMe19KVwaZFjkE5qcM2zy0U0bzzEDm9SuJNNxpzzxuS34GoA2TVmQUebepvxM
 T7X8ecXQxk6rqY96XDPMo7o+fy1974hkpiV613vwIZG72Y6re/BgjlahZAfr+gm/ppCXmvAkA4m
 Cq4ilhplxXe73b4VmYwx6yRRo=
X-Received: by 2002:a2e:a7c1:0:b0:32c:ef7a:ccf9 with SMTP id
 38308e7fff4ca-330a7c4d83amr31109181fa.32.1753087398088; 
 Mon, 21 Jul 2025 01:43:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx84iwHmVHIRGJTxo7Qww/UHy9xKkIHpfkxc49H8bjcsJ76JB3J5jjjHEJK3nrNlizT2njRLALnD8UxN2JLFI=
X-Received: by 2002:a2e:a7c1:0:b0:32c:ef7a:ccf9 with SMTP id
 38308e7fff4ca-330a7c4d83amr31109051fa.32.1753087397593; Mon, 21 Jul 2025
 01:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250718143356.1578988-1-bruce.richardson@intel.com>
 <20250718143356.1578988-4-bruce.richardson@intel.com>
In-Reply-To: <20250718143356.1578988-4-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 21 Jul 2025 10:43:05 +0200
X-Gm-Features: Ac12FXxvOMyB_nAsg3a_pdHrgKpKKoMGMV5Ur_5laBYokF3kNfwUvRsqZvOerhA
Message-ID: <CAJFAV8ym3Xe5XdZGdj-ztqedZ94Y=-r9Ur+AgrcE7Lgm8OgM-A@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] argparse: allow user-override of help printing
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tZzNeJDqSSu9Ny7XyjM_TgW5iHH2vBnosXoqCtU0CJc_1753087398
X-Mimecast-Originator: redhat.com
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

On Fri, Jul 18, 2025 at 4:34=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
> diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
> index d3b32c6357..e7b9bf573d 100644
> --- a/lib/argparse/rte_argparse.c
> +++ b/lib/argparse/rte_argparse.c
> @@ -821,7 +821,10 @@ rte_argparse_parse(const struct rte_argparse *obj, i=
nt argc, char **argv)
>                 goto error;
>
>         if (show_help) {
> -               rte_argparse_print_help(stdout, obj);
> +               if (obj->print_help !=3D NULL)
> +                       obj->print_help(obj);

Should we pass a stream to the callback?



> +               else
> +                       rte_argparse_print_help(stdout, obj);
>                 exit(0);
>         }
>


--=20
David Marchand

