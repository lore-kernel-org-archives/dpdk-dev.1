Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F43E8306E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 09:48:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4769402BE;
	Tue,  3 Feb 2026 10:48:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 50803402BE
 for <dev@dpdk.org>; Tue,  3 Feb 2026 10:48:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770112121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AnSmN/cH2PIVKjX57L6uNdtWiIbTUwz9dywDqrtCTJc=;
 b=gpW6+iNPkaxeDsyu4B/mk9Y2/3Px4pMoVoKyEGchwNxI7ICCMnavo+pOE9JQ6tbk4CGO69
 89W5+QU3nJVowT/E4qhAJBCIHCEtJoOjnKdQ7FqfTN0bgrknKSo80rAhaKDtG2aejMUNI+
 FAWGO8O+KTbaiuGh7Gb9P0N2MpaSiyo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-XaKpgQmuMN-RIEziTPzQBQ-1; Tue, 03 Feb 2026 04:48:39 -0500
X-MC-Unique: XaKpgQmuMN-RIEziTPzQBQ-1
X-Mimecast-MFC-AGG-ID: XaKpgQmuMN-RIEziTPzQBQ_1770112118
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-382f49594c5so32175181fa.0
 for <dev@dpdk.org>; Tue, 03 Feb 2026 01:48:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770112118; x=1770716918;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AnSmN/cH2PIVKjX57L6uNdtWiIbTUwz9dywDqrtCTJc=;
 b=o0L5jflEwqjX1zNNk2ECzPYevh9+t6fJ/NjRaOuzR1rtK/Rk5htMEJiC78s3ny+0oV
 BjJmFVA6NEgU/AzKYarLpf58r6fm0qo9g/pIMobVfV9shH/7PnP8Gu4dFvMOobP7NzpS
 b2yHboAD5o8EZPwGppet7bp7X5tSXVC6WFMqUqPgXwPTOheWaNIXYtW1+0ZfzgzXanHi
 JTZfoWs6+1Q1VLjQE+lg/d7if/22pV3SbVdv+sxJwxiVfmPCtLZ/a2Xj9TPsPfUnO2P4
 f2e6WpIZakZIv+GEFI1CO0mpO3URnlifHVxlPXxE5F5BGtSd8zaD6qt3trj5G/mitsQX
 OwiQ==
X-Gm-Message-State: AOJu0YyRcau7s755BXE4xdqT/nComTv3EkycbWzSfPjNXd/NFWOK8OQq
 g4+UualkrzwZK+Z18sJdMzEqvSnvqeEjsEik6xgBks4vVkqn+AfRjiWskIgLNSHABjQskr1MADO
 o/qUwjF5pIV1jQWVhmSLwzU1Diso7Q1fL23rNs3cFTezkiNtkWqsAie6HrCz1iSaP9sy2ZOImfd
 UOXoHUDRoJI3im1/pQT6U=
X-Gm-Gg: AZuq6aKvklCQU7InSej/T09fUhiFXN60LFAuu6VlgbV1dE8cH0Jd7AYLvdJ3efPpVO1
 xWTNYjDw1LBAvlkEG1ILTS+R8ViMsHnmTBer990GtfyXEONkq5G8Ev2LQZGuSnq2xbG9+NQZ+h+
 6XzFr505toZSNPzvW3zQtzMJm/JEJbvCJ1T4WjmQ+WYAav4rnqALGpvUFEJETitEL9/Suw9VPvY
 ZIL1+jZwMP2soPWoD+ps8zpfSWShkOQY7ZnqLwmmE15t5/vHJdRgH68dw==
X-Received: by 2002:a05:651c:19a5:b0:37b:a640:765e with SMTP id
 38308e7fff4ca-386464f8618mr60924071fa.11.1770112117928; 
 Tue, 03 Feb 2026 01:48:37 -0800 (PST)
X-Received: by 2002:a05:651c:19a5:b0:37b:a640:765e with SMTP id
 38308e7fff4ca-386464f8618mr60923991fa.11.1770112117512; Tue, 03 Feb 2026
 01:48:37 -0800 (PST)
MIME-Version: 1.0
References: <20260127052900.68045-1-scott.k.mitch1@gmail.com>
 <20260202052442.92192-1-scott.k.mitch1@gmail.com>
 <20260202052442.92192-2-scott.k.mitch1@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F656E5@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F656E5@smartserver.smartshare.dk>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 3 Feb 2026 10:48:25 +0100
X-Gm-Features: AZwV_QgttBLV0jPspvGdoXKzgmW_qOcJZ0jr5_MIeyHEpcHk3zRE2LKeo5MYoA8
Message-ID: <CAJFAV8xLCFJ0ZD=71YLPOjd7-sVJkZtxGRsDVMMqwpSg181jRQ@mail.gmail.com>
Subject: Re: [PATCH v17 1/2] eal: remove alloc_size from rte_lcore_var_alloc
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org, =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 stephen@networkplumber.org, bruce.richardson@intel.com, 
 mattias.ronnblom@ericsson.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MDeQFO4D6KPkFVcQ852UYo4P5T_zUu2xsqp5grk0JBk_1770112118
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

On Tue, 3 Feb 2026 at 09:24, Morten Br=C3=B8rup <mb@smartsharesystems.com> =
wrote:
>
> > From: Scott Mitchell <scott.k.mitch1@gmail.com>
> >
> > The __rte_alloc_size(1) attribute on rte_lcore_var_alloc() is
> > semantically incorrect and causes false positives with FORTIFY_SOURCE
> > runtime checks.
> >
> > The attribute tells the compiler that the function returns a pointer
> > to 'size' bytes of usable memory. However, rte_lcore_var_alloc()
> > actually returns a handle to a per-lcore variable scheme. The
> > allocator internally allocates 'size' bytes per lcore
> > (size * RTE_MAX_LCORE total), partitioned into per-lcore sections.
> > The handle points to lcore 0's copy, and accessed via
> > RTE_LCORE_VAR_LCORE(lcore_id, handle) which computes:
> > handle + (lcore_id * RTE_MAX_LCORE_VAR). Access is expected
> > beyond 'size' bytes beyond the returned pointer when 'lcore_id !=3D 0'
> > but FORTIFY_SOURCE may terminate the program due to out of bounds
> > access.
> >
> > This can be observed on CI with gcc 13.3.0 in lcore_var_autotest with
> > '*** buffer overflow detected ***: terminated' if pointer provenance
> > is preserved (e.g. if offsets avoid casting to uintptr_t).
> >
> > Fixes: 5bce9bed67ad ("eal: add static per-lcore memory allocation
> > facility")
> > Cc: mattias.ronnblom@ericsson.com
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
>
> This patch could be separated from the RTE_PTR_ADD/SUB series.

I agree.
There were comments on patch 2, so I took this patch directly.

> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
>
> NB: Please keep this ACK for any new versions of this patch if the essenc=
e of the patch doesn't change.

Yes please, I restored acks from Mattias and Stephen.

Applied, thanks.


--=20
David Marchand

