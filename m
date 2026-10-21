Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098B3606A319
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 05:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xq3FWzU8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3B3E4027C;
	Wed, 21 Oct 2026 07:12:45 +0200 (CEST)
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com
 [74.125.224.45]) by mails.dpdk.org (Postfix) with ESMTP id 0A90940041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 07:12:45 +0200 (CEST)
Received: by mail-yx1-f45.google.com with SMTP id
 956f58d0204a3-67583c777abso364385d50.1
 for <dev@dpdk.org>; Tue, 20 Oct 2026 22:12:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792559564; cv=none;
 d=google.com; s=arc-20260327;
 b=ovfBv9SKE4P8P4HO5pwM2DHV1Xeh5xkfE19DLKOSK+1UtLxLQPgJIP0b7Y4mZg5aK/
 5W9gcjDTJ0hOwuFCaAxMzQGCGvhZJUaAWuFFPthvtKcUGh/gG7AAcjtjTP0LtcYrFhNq
 V6goCGDDqEXgBEExkyjE/OmAcsajjJbwPJ5xrhcXkU9t8s8TYPH14bxTFirnnteu9Deq
 543i4eOwOpW5RP6YBGxjUUgwtr6fX5CAox9Vt6t8REVZEHg/sHf53KLaqSS4BMMaMVoa
 HJgzcL63nguNIGsNGBDadUhrzb4tE1bskpI25/fWRZ2Ew8Pg7gDKn/0Pw6BIr0MaCbOI
 Xv3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CplRGWC9pdd8LeXOt3etnHtynvRoPqd2jMKXMNNt/6I=;
 fh=XTF9obmy/Aza4zs7Gw9tcTmBhnKnq3eqlA+5WKQTrf8=;
 b=cO+tZ99OhZsH3hb7Tj8zbxCroGecrrQvazEQAUFVjEOQ8/4U1y97uDVGcka0y8Rs1C
 Yot8xjyAtMPTaNjatWQ/5e8wXvnxhALkUsulNz2U/R8SmkrHSN+moavVee1KkHDF9jAq
 1XABbZvlpyKC2t67C1w7B29LPeZutuvHycvv5v1PEELrgHMKjqm3R/PiA0zncCDM1jx8
 IKeGgG9pNgvDfUIf62hWXO3ObiKo15cfTycNTFZRSH+4zd0siOkJstHQT+8Hl3K1SjYt
 xPtvg/+8EzyJgIBlRMcHt9z0bWqdxbzZUXVi5efrrqBWYW5hRg/z0+60utUBARjOcIJi
 e9wQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792559564; x=1793164364; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CplRGWC9pdd8LeXOt3etnHtynvRoPqd2jMKXMNNt/6I=;
 b=Xq3FWzU8oTtujGj0k62YZaETjGkD6FdDdPknPEZ7oQlwjCJtbCjSTlRqCpDR8iBBt5
 eOYkLTLoA2+fngOFKY6PzF4+yMIWTWIa/FEspniEbQRUJySuRzXoyxk0G96ajZRWpuhn
 Tp+22Za3QeaICike+DOs7dyvWiJRjyv7m18kuzU7waJImUrPlQS5h9xTh/SB6fd1ygaA
 TViDvXPAdM4KeuBPIirn66OCliU1VEEUOCrONiQqm52GDIkd01Qi4c/wlEvQzYIyGP+f
 4c6qbmJN2e/4/5HffpRA36oCsW5LHwf8GNifO3FcchYxnTipfSsbEGeVbvPTjrhDIhGG
 UIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792559564; x=1793164364;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CplRGWC9pdd8LeXOt3etnHtynvRoPqd2jMKXMNNt/6I=;
 b=EpL7ACjQg95dMw0hsIHwcsrjhHlBxgWeHl+j8ibx7dgYvom4cAp+h/TiOZIBlia4Pg
 eUTYcSzkgDf+MAobmrrIOkd1roD2kGliYIJTg62lNzTfN3EzdF0QFwQeQFV6Dd/rqXWU
 3+G6k1O1ANXBxZjlrNINQXaOTMIn5rooh7yz+bd+FiX0+euEHrxhwku7Zvsk596Tsrxk
 dMD/unQBhj0aewj1grA2MUYNp8iY1RYoet7DIEkPSTMPk7RlzKkenZW9BRwssEmzTMmr
 O1QQRSboZbsNDVPG7fJRE4rlt4V/5t3f/mH1nIqTRhfzYLOfAl9J26HiN9UoDwijZlTk
 7YJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkng4AMR4ulYNTHsoKAsOUC1LRZa1mQIUWncw1imjeBiVZr7DN7bEvVoyvV8zBWre6RHU=@dpdk.org
X-Gm-Message-State: AFq9FYLhwLZAA6jebQxeRieCmtCxt1PAnqqr47xxjtQ51M0OA0sMyFmB
 1qh5Xq90Aaf5XiYcWf9sUu/bjJ8cOg7mbWhzjyp7uaLl6DtYXmLD+orTTLTGsglSoWBEfHxzH0p
 BV2kV144R63/YVPx1VT2GLkIcXQhDP74=
X-Gm-Gg: AYBFou0NRr9jQfXfJJvPgMit4C1GQisq4jzSBbkErZ87iBEHi7jkp91hdjWOoBLGRSc
 60bswAy4ZmWvfxcGWQxpbaYLK8MpTv2k5ZynkPiulwJwxFavdPdDv1Blgob/AAIjiB60BTI/sd1
 SL2G0i7x70fP2Xm+r2N/xz8uwfsbcHyH91k2NKfBnq959262zypOUqTI9P0TxzklUj7rjOG8l+6
 rVeH4BUlv1nFc16fbFnJSXi5g+ng6OPyYMfe6VuG6i5+IPrISVcafIjOa6gm+mOWmnXBaiFa7dy
 rHvsCEvkHU0fZoZWJ/9RmlSmkj9A7xmXHgOekuOPd49AwqDhpgkrC7fokbK2/UVhp0NH8FJfTRE
 JK7jmPQgc69ctYRLA7QcNDzQkkzz9hauR2rmfS2g8bmBX/CPO7krvJwgvjfXvofPFGrziU3K4A/
 HLnlxaReiu+NHM9Lemo47Dm5Pr2cXsemd3V1OtlwDb/YhyDsd5JC3ZmzJflU9RChqGpMgh8Zcnr
 g==
X-Received: by 2002:a05:690e:4890:20b0:679:a5fc:2f35 with SMTP id
 956f58d0204a3-679fbf7f6femr1059178d50.19.1792559564151; Tue, 20 Oct 2026
 22:12:44 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261016095132.73347-1-pbhagavatula@marvell.com>
In-Reply-To: <20261016095132.73347-1-pbhagavatula@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Wed, 21 Oct 2026 10:42:17 +0530
X-Gm-Features: AclHuK_hvB5j11SO6_RxH-X03tRMqS8AEJOCPE7AcplHpUGtvucsS1XQYRlsRQ0
Message-ID: <CALBAE1MojrhUcTX-C8s8ph2VxGEmP6xgd6WrgsLr5bwcFspyPA@mail.gmail.com>
Subject: Re: [PATCH] event/cnxk: fix TIM HWWQE handling and chunk alignment
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 16, 2026 at 3:21=E2=80=AFPM <pbhagavatula@marvell.com> wrote:
>
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
>
> Use a single predicate for HWWQE enable, fast-path selection and chunk
> pool sizing so a TIM_HWWQE_VER_0 device is not run with HWWQE paths
> without being configured. Fix the burst response mapping in
> cnxk_tim_add_entry_tmo_hwwqe() to match the single timer path.
>
> With tim_disable_npa, the generic ring ops only align objects to
> RTE_MEMPOOL_ALIGN, which does not give the 256B alignment CN20K needs.
> Populate the pool from a 256B aligned memzone with the trailer padded
> so the object stride is a multiple of 256B, and keep the chunk slot
> count within CNXK_TIM_MAX_CHUNK_SLOTS after rounding up.
>
> Fixes: 19861e9eac8d ("event/cnxk: align CN20K TIM chunk buffers")
>
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>



Applied to dpdk-next-eventdev/for-main. Thanks
