Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F2ACA5FB1
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 07:32:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B72F6427A8;
	Wed, 30 Sep 2026 09:32:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B6E7441148
 for <dev@dpdk.org>; Wed, 30 Sep 2026 09:32:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790753556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U26e56h3zT1Q/qlySrVJ/pbP6ZkHxHFu6kKNWCIwano=;
 b=Dnr/No3pHZqdN9KPux0SeeGHOdGrZENgvNd6GZNMIvuZaJuOaP7lWPJvqGkbA02RU6V/ZU
 XsrvZUt8Rwtq0phM3cWsuFpHhIwbWKJBy4OfuxxbaoKcvxdkueiWLoJpH7DvwmBCbyAroW
 IFejQp76t7ZEUX5XVhbm/FnYQyTi/eI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-c7qQNo0TPia-G-1l2eaJyQ-1; Wed, 30 Sep 2026 03:32:34 -0400
X-MC-Unique: c7qQNo0TPia-G-1l2eaJyQ-1
X-Mimecast-MFC-AGG-ID: c7qQNo0TPia-G-1l2eaJyQ_1790753553
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3a77d27eb6cso755421fa.3
 for <dev@dpdk.org>; Wed, 30 Sep 2026 00:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790753553; x=1791358353;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U26e56h3zT1Q/qlySrVJ/pbP6ZkHxHFu6kKNWCIwano=;
 b=X8ZAQwlGj2IXp3EV1ghZH4CQmv8oaeDkFKheUI5RsHwOpj6dGKVM1gmHsyogDyCfeL
 YbQBUSd5wQ7whzIz18Oy1JFJ3BhvZJvw7NL/gjY+EkJm5M8OoEXLrMOfbwdt+1Bz1Pmm
 zCI1/BkqZ6S3icmT9vU2OAT0ZnTsPlrNFbiemSjL6AC+OTUyuGJRTIJ8K7PTQKUD9gXw
 Zk4xCu3EKEAtlJK+nGSbe4f0oRMbbsKaoRMskER6anCbBi5AP0doEsNdii0gFjiUTajG
 SUgAA98EZSi4lCoewy5BXNST74eBRxqsORvH6Ud8hA5QGBQVVXe/YemFVcJYdKjFx3OX
 sTrw==
X-Gm-Message-State: AFq9FYLzJ0AEHCMj0rVCx3RNmLXtDMZYm+MnAAitYFFxw0dKOMZzLqnU
 ibuR9z84kV5oOZ7+EQo3nQY83bGxf0jSj7usnIK/0jmCROzN1JcnHvoFbgH/ApjDuYmU+hDeFRY
 uOEQZyrRKnzSAIoWF7mR1nP3HamO4X9frKFfIjAfUcesR4JRXNPJ0YOYkrv655yz3vaoOpbrjRi
 JIKjm25V2GDusOTzoNa5g=
X-Gm-Gg: AYBFou3eTuIUXzZcDo6iYN7+SPd4fzXTXxoOWQdynyFHc2jXW4soDrG5Ml+PNoS2y5d
 eX3ibIMFTl2Usz6XrF7taKGO8M5tW3TwqbnVp1DE+uz9ndeVNBsMknaF+GwaRVlwMPTg6VzDd6o
 GhwJp//7/4Jadm9xgoXmxR5iAr3fV/nNYxlupzR8QwdLUZHRI+6KCdToeS+n70UjeAmdUWswnoY
 iPb2rKWHNEWDF5m4MsHMuQH4KPK20qN+V3V0YG/obgaLeA5
X-Received: by 2002:a05:651c:43cd:10b0:3a7:70a8:fcf4 with SMTP id
 38308e7fff4ca-3a77924394emr1299271fa.23.1790753552991; 
 Wed, 30 Sep 2026 00:32:32 -0700 (PDT)
X-Received: by 2002:a05:651c:43cd:10b0:3a7:70a8:fcf4 with SMTP id
 38308e7fff4ca-3a77924394emr1299181fa.23.1790753552466; Wed, 30 Sep 2026
 00:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260922094026.2636265-1-david.marchand@redhat.com>
 <20260929125000.4800e8a2@phoenix.local>
In-Reply-To: <20260929125000.4800e8a2@phoenix.local>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 30 Sep 2026 09:32:20 +0200
X-Gm-Features: AclHuK-GE_rQIaJzTYaM_I71hj845yiu0bpbYlmW6CgkBPlXjbmqjiXkaoiPlIM
Message-ID: <CAJFAV8w18N1em+Ua-zji555iD5izK7-ai9LugDmVZndEy9LsOw@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] Limit usage of internal API in tests
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, bruce.richardson@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ErEQNRQkzDuOfGq-vUk5aLeEj6ldWH9iAwNemhcRCZo_1790753553
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

On Tue, 29 Sept 2026 at 21:50, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue, 22 Sep 2026 11:40:16 +0200
> David Marchand <david.marchand@redhat.com> wrote:
>
> > We had a few bug reports related to internal (and experimental) symbols
> > issues during 26.07 development.
> > See for example https://bugs.dpdk.org/show_bug.cgi?id=3D1957 or more
> > recently https://bugs.dpdk.org/show_bug.cgi?id=3D1967.
> >
> > To catch such issues earlier in the CI, this series proposes to run
> > the unit tests through meson with the ABI reference unit test binary
> > against the current ABI libraries and drivers.
> >
> > For this to work, some unit tests must be skipped (since meson may
> > invoke the ABI reference code with tests that were unknown at the time)=
.
> >
> > A few unit tests were directly dereferencing internal structures and ar=
e
> > reworked so they use public APIs.
> >
> > Additionally, unit tests were allowed to use any internal API which has
> > hidden a few issues (like a public API backed by internal symbols in th=
e
> > hash library).
> > So disable the global ALLLOW_INTERNAL_API and move it to code explicitl=
y
> > requiring internal API, with the hope it will push us to have better AP=
I.
>
>
> I think this causing breakage with minsize build. It is not correct to us=
e
> __rte_internal on inline helper functions in header file. I checked and o=
nly
> thash has that anti-pattern.
>
>
> In file included from ../lib/hash/rte_thash_gfni.h:13,
>                  from ../lib/hash/rte_thash.h:23,
>                  from ../app/test/test_thash_perf.c:13:
> In function =E2=80=98rte_thash_gfni=E2=80=99,
>     inlined from =E2=80=98run_rss_calc=E2=80=99 at ../app/test/test_thash=
_perf.c:58:13:
> ../lib/hash/rte_thash_x86_gfni.h:181:27: error: call to =E2=80=98__rte_th=
ash_gfni=E2=80=99 declared with attribute error: Symbol is not public ABI
>   181 |         __m512i xor_acc =3D __rte_thash_gfni(m, tuple, NULL, len)=
;
>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function =E2=80=98rte_thash_gfni_bulk=E2=80=99,
>     inlined from =E2=80=98run_rss_calc_bulk=E2=80=99 at ../app/test/test_=
thash_perf.c:79:3,
>     inlined from =E2=80=98run_thash_test=E2=80=99 at ../app/test/test_tha=
sh_perf.c:122:13:
> ../lib/hash/rte_thash_x86_gfni.h:213:27: error: call to =E2=80=98__rte_th=
ash_gfni=E2=80=99 declared with attribute error: Symbol is not public ABI
>   213 |                 xor_acc =3D __rte_thash_gfni(mtrx, tuple[i], tupl=
e[i + 1], len);
>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
>

Indeed.

I had disabled minsize builds some time (well, months) ago and forgot
to re-enable them.
I'll send a fix soon.


--=20
David Marchand

