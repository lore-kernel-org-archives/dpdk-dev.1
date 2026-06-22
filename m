Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A5DCDB471
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 08:19:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94C354029D;
	Mon, 22 Jun 2026 10:18:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B77AE4021F
 for <dev@dpdk.org>; Mon, 22 Jun 2026 10:18:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782116336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/S1hIoh4Or6+AbT2W7T9eJpwBrDVLuosVAyG5AzAHfU=;
 b=blCrrA7rGP0gw3ezrsPrL2G00sgI5ip+Waat/u63691HL0aVcu2lLmR2XxpatVoFk288lj
 +vqTRynsdQfV14nx5QFhmf9beU+AqImUfvu2PYai/TT7iLKn7LLdF3jIuT9OVPMEJKZP1I
 aQn5yYvqRZspTeQE4WjfdHuDQe5UbXg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-3ZdLViVTMGqe3BzUajnA9Q-1; Mon, 22 Jun 2026 04:18:55 -0400
X-MC-Unique: 3ZdLViVTMGqe3BzUajnA9Q-1
X-Mimecast-MFC-AGG-ID: 3ZdLViVTMGqe3BzUajnA9Q_1782116334
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-39987ae63b5so17022601fa.3
 for <dev@dpdk.org>; Mon, 22 Jun 2026 01:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782116334; x=1782721134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/S1hIoh4Or6+AbT2W7T9eJpwBrDVLuosVAyG5AzAHfU=;
 b=dmX7GqVlGmBCW+TNuOHsG9CnDAyEFefgdH7ksLpEJVBOXaZl/9QRWhyTK/Xe+YcsjU
 UCO835T5Vqa9V8mY9H4DTa8+LnzDSA6kaCgeMESWKxmTW+h8duNBhUpUOdO4KYpeNAMM
 LmpdenSgfAuMGCNnVrcOtgQdB5kaFp6pMMyQ8xi+f4bwd3zoYYcmYa6hi2tn+iR5h053
 Ws78AMcqgK1l6UD2mRP7LgmfVoUjSeYhpmWIgDv25wgy/qvS7Pe45oEz8gIFUh5f3dUF
 +6mwumnSLAGjt3CsOo4RULQTicr4qAWu3rnwy8uTevHBMNL+9hIxvK2rlmTA/KNpFi43
 mJvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/iyDuLu0SICCKBKfTD31aN6WhgwsulBqUjsIEk1pLQtW7h6xvVhmPIG3UNcRklQ/eNURA=@dpdk.org
X-Gm-Message-State: AOJu0Yw+Cosa6g4gaWBvMjVGxLiiQoY7X47H6o7w9Ffuo3HzZucVA2iN
 mVpESQ1KgAiiyV2c2C/gVDAYlafS4zW/HtazHpB/xXNIjp0qKZGeHKPOH3bvRXt1MplkWQIX8Px
 7oy20rAqs4uNWJ8U1YEOAj1FLZVPvm6nrnNSM6BqIlseVlGZYr7eMisy9e1TDQTu3gM0ZypknMU
 5XXm3LpnqkDM5dZ8dgzWk=
X-Gm-Gg: AfdE7clvTkbYUGFkpXr+EEvo5JGfUYRUdx/qdkB5Z/r9Q0OpvFlC7En1gNwsQSf+cb+
 LSiE1LBShSK1eVA566Gz+pHOO9A1Lmq5nvQrAcyT2Enh8ETkR9nFldPg+NOSoA+trtkKvxkgDud
 /UrgFlpzk//yVt3YaLZw7xG/pMM+83fV2cYJh9J8YqKFcLoyy9ssuhMlcuLQn18KYnNTQoVzDd9
 bN0B5p9acrg/KbJTr5oRqFOG1NgKwdkmCHnmBCidazWCLPTuH4pmMkvVHA=
X-Received: by 2002:a2e:a9a9:0:b0:399:b07e:daa7 with SMTP id
 38308e7fff4ca-399b07edc53mr11159441fa.24.1782116333682; 
 Mon, 22 Jun 2026 01:18:53 -0700 (PDT)
X-Received: by 2002:a2e:a9a9:0:b0:399:b07e:daa7 with SMTP id
 38308e7fff4ca-399b07edc53mr11159371fa.24.1782116333102; Mon, 22 Jun 2026
 01:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260617102834.2343356-1-lihuisong@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65917@smartserver.smartshare.dk>
 <20260618190339.2fc76616@phoenix.local>
 <15b95ab5-af2e-40d2-8ea8-a5d14a52dfc0@huawei.com>
In-Reply-To: <15b95ab5-af2e-40d2-8ea8-a5d14a52dfc0@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 22 Jun 2026 10:18:41 +0200
X-Gm-Features: AVVi8CdxqPkPMYmFn18aoNypnVNWXmBRvpHKhxk36PiU7VcG67tzGVJbzDizDZo
Message-ID: <CAJFAV8yNsZ_SLcG-ukzmDTQXRXDsGVtf-9szwSc6T2GM+fhE_Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] prefix lcore role enum values
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru, dev@dpdk.org, 
 zhanjie9@hisilicon.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EV7CtQvnRpPLmeNPT8SJesloNHGIGOl9hXOmEsG2OWw_1782116334
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

Hello all,

On Mon, 22 Jun 2026 at 03:23, lihuisong (C) <lihuisong@huawei.com> wrote:
> On 6/19/2026 10:03 AM, Stephen Hemminger wrote:
> > On Wed, 17 Jun 2026 13:48:37 +0200
> > Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
> >
> >>> From: Huisong Li [mailto:lihuisong@huawei.com]
> >>> Sent: Wednesday, 17 June 2026 12.28
> >>>
> >>> Add the RTE_LCORE_ prefix to the lcore role enum values in
> >>> rte_lcore_role_t
> >>> to follow DPDK naming conventions.
> >>>
> >>> - ROLE_RTE      -> RTE_LCORE_ROLE_RTE
> >>> - ROLE_OFF      -> RTE_LCORE_ROLE_OFF
> >>> - ROLE_SERVICE  -> RTE_LCORE_ROLE_SERVICE
> >>> - ROLE_NON_EAL  -> RTE_LCORE_ROLE_NON_EAL
> >>>
> >>> Old names are kept as macros aliasing to the new names to preserve
> >>> backward compatibility.
> >>>
> >> Series-Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> >>
> > The problem with this patch it causes build failures now with abi diff.
> >
> > Example build log...
> >
> >
> > 2 functions with some indirect sub-type change:
> >
> >
> >
> >
> >
> >   [C] 'function rte_lcore_role_t rte_eal_lcore_role(unsigned int)' at e=
al_common_lcore.c:74:1 has some indirect sub-type changes:
> >
> >   return type changed:
> >
> >   type size hasn't changed
> >
> >   4 enumerator deletions:
> >
> >   'rte_lcore_role_t::ROLE_RTE' value '0'
> >
> >   'rte_lcore_role_t::ROLE_OFF' value '1'
> >
> >   'rte_lcore_role_t::ROLE_SERVICE' value '2'
> >
> >   'rte_lcore_role_t::ROLE_NON_EAL' value '3'
> >
> >   4 enumerator insertions:
> >
> >   'rte_lcore_role_t::RTE_LCORE_ROLE_RTE' value '0'
> >
> >   'rte_lcore_role_t::RTE_LCORE_ROLE_OFF' value '1'
> >
> >   'rte_lcore_role_t::RTE_LCORE_ROLE_SERVICE' value '2'
> >
> >   'rte_lcore_role_t::RTE_LCORE_ROLE_NON_EAL' value '3'
> >
> >
> >
> >
> >
> >   [C] 'function int rte_lcore_has_role(unsigned int, rte_lcore_role_t)'=
 at eal_common_lcore.c:85:1 has some indirect sub-type changes:
> >
> >   parameter 2 of type 'enum rte_lcore_role_t' has sub-type changes:
> >
> >   enum type 'enum rte_lcore_role_t' changed at rte_lcore.h:33:1, as rep=
orted earlier
> >
> >
> >
> >
> >
> >
> >
> > Error: ABI issue reported for abidiff --suppr /home/runner/work/dpdk/dp=
dk/devtools/libabigail.abignore --no-added-syms --headers-dir1 reference/us=
r/local/include --headers-dir2 install/usr/local/include reference/usr/loca=
l/lib/librte_eal.so.26.1 install/usr/local/lib/librte_eal.so.26.2
> We just came back from the Dragon Boat Festival.
> I also received this ABI change warning. But I didn't have any good
> ideas yet.
> Thanks for helping to handle this.
> Sorry for the inconvenience.

There is nothing broken from a ABI pov.
This is a limitation in earlier versions of libabigail.
I can't reproduce with libabigail 2.9 (update in progress as I see
2.10 is available now).

I think it was solved in libabigail 2.8
(https://sourceware.org/git/?p=3Dlibabigail.git;a=3Dcommit;h=3D6f5f91564bdd=
).

If we want to go with the enum renaming before 26.11, bumping
libabigail to 2.10 in the CI is an option (latest upstream version,
and this is the version in f43 and f44).
I tried it in GHA:
https://github.com/david-marchand/dpdk/actions/runs/27937595115/job/8266295=
3500


--=20
David Marchand

