Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2008BCDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 14:46:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EF1940150;
	Mon, 22 Jun 2026 16:46:28 +0200 (CEST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41]) by mails.dpdk.org (Postfix) with ESMTP id 212E340144
 for <dev@dpdk.org>; Mon, 22 Jun 2026 16:46:26 +0200 (CEST)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-696bf0e7c9cso1105164a12.1
 for <dev@dpdk.org>; Mon, 22 Jun 2026 07:46:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782139585; cv=none;
 d=google.com; s=arc-20240605;
 b=Mtk2JxWSRTdIAVmHkh0B5yuJUmh8pRaA17SClea25PlPcw+Gdb4R1OfljJCecyNxbp
 xwMN5Kr5pU6kYF5Lb77DwMQql1caT6cuzV8ZcERTGFa0XJQNC09F9sUp5n1X4m8eBn+u
 Ah/j2mRAQx3/tCanoXWoTuUmbJroWx3Od/O9EB4StZJjBGdhiecXnNtTIrnsBjBF0vat
 l2waLQ6mJ4uSAUMqJL87dyjB06BgecYm6kWXmSBRmFjeX+hLftb19BLhpKf/SzizmAue
 S+SfXcPkRr/+UOvbsTOla/MsxfEH+3Q6tkilz+sok8I3tTSO9rZIvRjqbxXzgFuIeUKX
 hS6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NkDDNXtNx5QT1+649JjkJy047g9DbMUEJL0pG46vwKU=;
 fh=Eu2Lpgy2L18dTAZD7cWRW/ZEK2yU8zRT3rkC873nSXQ=;
 b=UgXBZIylZzIhjFIucUgw2MeWl1ahf7JnYtW5U7SVae/OnSAxFW9x/wh1mYm5124QuM
 7KXZjxfjU1QjVchHnO+3M8SbMYyIVpxiQpRYznivfJDTBd+RJWnl2ssWbBPcafU+AKFC
 nPJO//ZABYSpzUV0F/x92ICN4ZA9QNPASmKozBi9zl+qFVw3hjbLnq3YoXutY69sWdXQ
 dcvPRIsryWjUahEdFG0/r2IzQZUaFbIigjYF44wsm1BNM5xsNB1GxoopYYsh8vt4otU3
 XN+y6ropL8gH0zKBLk2Wg27AUZ1q8q+5FPw3rnLCkyvJ+RKSaXxrxdEbHjOCe/wy9Ato
 tzGg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782139585; x=1782744385; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NkDDNXtNx5QT1+649JjkJy047g9DbMUEJL0pG46vwKU=;
 b=O7YfIpndALv3Jg1E0qXPesi5rcRKzgB2xmDHLqNDT4gje4fjee3TafIOegYKuCg/VH
 tO0jhDppmCYHINxXUlPkINVtOXqf5rDbAJ7QVX0YHWerDXJVcpkl7cS+7+h8mACQW/8i
 d7FUmiFeildRTG4Uc21XUSqYbRVBEDnlvW1S93O7z7WH7SkJX7+VsK8bjt5q612DZiic
 aWfMAEDjUMrdTOs9V6hoNRV/TSDszp5VhUDnRglsFuGy1QudRXkyxsahLR/+hZ+oF12I
 acrR/Hjfn7FYfGWO4vfPUuqVzAeXFVGAXgVskBNG9QK9lVjHM1h0hubhAwOFQWuwvB7G
 lNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782139585; x=1782744385;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NkDDNXtNx5QT1+649JjkJy047g9DbMUEJL0pG46vwKU=;
 b=OEzAsvd9i/g1wnhXK3Z9oWVbb0Ir29ar2yZ2sTJa4clixx30gzDs1IRTIQMdZ7JJlZ
 OnGa1NLTSYy4Bm3Z3ZKumTbiblEm38jYuSFms6EQmUmPgB+iKv3kpACIKZMZJuskwzDv
 jOWUVd3d0kTULCq4MII+68MqqvdKHxaSjB+UwRfoqD7jgnyNGpErxfVm2ze7eY/w20mD
 DnLyXX4ut0MQn8b8es0/CwtMP051Fa/fqgn02RD/Qw12/nUxcxEyArtwce7Ulzu8NunW
 cmZsmgt+n71dr10T0hKBhmxzAlkLrFRZHFsXK9pxyMc+H6qrh6aGwVB32UMDLAZOoN7L
 GhXw==
X-Gm-Message-State: AOJu0Yxo/UGvWpNAv2pt880AgBkMPWlrd4Pg4WHcmkQ31V13xBACFnYJ
 ljbDN04lU/Z78rrHAHHVyYyOUJxea++XXyl2UBy/oUQjycg1CUjhaact/b0uAKt/mxqvlrdtmBq
 MTzEP4ySldTpDUTd6UiSz3Ei4nJSD+So=
X-Gm-Gg: AfdE7ckQPSSbWhzi4FHvJjGoXAKztgo5alYjPQzhM8EYzf9uqbznyhP5F58RWI4Qqq8
 idUJdsZg5WRe/pHZWdHMRiUfaHm+XgtzT67d4qK/R8uEeJb4dUZjCwQK/FP2JyZWA9Xf84xQ4IO
 k3IwkYm7cNZUnJXjK69r+hRmYitg6F0C1H36RA84bQfZ9sH+xit1qvtmmu9mDt8Dcj5vIAsAEVD
 J/VE7h4e9BMF4exYfV48ra8QTQkci49aEcT4zvnkI0VcXMMir8HSlpPtjk40F/SRNsC59+N+7jN
 eU1PjC79eG+a0MP6+HgdlE9q1EOtia+qP/hj4t5HCw==
X-Received: by 2002:a05:6402:3548:b0:670:d548:62a1 with SMTP id
 4fb4d7f45d1cf-6973b0ccebdmr6640168a12.3.1782139585418; Mon, 22 Jun 2026
 07:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260620023134.42877-1-stephen@networkplumber.org>
 <20260620023134.42877-12-stephen@networkplumber.org>
In-Reply-To: <20260620023134.42877-12-stephen@networkplumber.org>
From: saeed bishara <saeed.bishara.os@gmail.com>
Date: Mon, 22 Jun 2026 17:46:14 +0300
X-Gm-Features: AVVi8CeokEtvdHIE0a46aKakAcb276wcSSjzNol_5EdYUF4d3lHcMBJ3nsXxOnE
Message-ID: <CAHfVqdVVG-W+PFZdimqwhrUrUZFSeCNodSu-VU7sscMpaiOVeA@mail.gmail.com>
Subject: Re: [PATCH v5 11/24] drivers: replace rte_atomic16 with stdatomic
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Sachin Saxena <sachin.saxena@nxp.com>
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

On Sat, Jun 20, 2026 at 5:41=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:

> @@ -84,7 +84,7 @@ dpaa2_create_dpbp_device(int vdev_fd __rte_unused,
>         }
>
>         dpbp_node->dpbp_id =3D dpbp_id;
> -       rte_atomic16_init(&dpbp_node->in_use);
> +       dpbp_node->in_use =3D 0;
The previous code implies an ordering barrier, so it guarantees that
dpbp_node->dpbp_id is visible before in_use, while the new code
doesn't. isn't the a problem?
>
>         TAILQ_INSERT_TAIL(&dpbp_dev_list, dpbp_node, next);
>
> @@ -103,7 +103,10 @@ struct dpaa2_dpbp_dev *dpaa2_alloc_dpbp_dev(void)
>
>         /* Get DPBP dev handle from list using index */
>         TAILQ_FOREACH(dpbp_dev, &dpbp_dev_list, next) {
> -               if (dpbp_dev && rte_atomic16_test_and_set(&dpbp_dev->in_u=
se))
> +               uint16_t expected =3D 0;
> +               if (rte_atomic_compare_exchange_strong_explicit(
> +                           &dpbp_dev->in_use, &expected, 1,
> +                           rte_memory_order_acquire, rte_memory_order_re=
laxed))

aren't rte_atomic_flag_test_and_set_explicit/rte_atomic_flag_clear_explicit
a better candidates instead of
rte_atomic_compare_exchange_strong_explicit/rte_atomic_store_explicit
?
