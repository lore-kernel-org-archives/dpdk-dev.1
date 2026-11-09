Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58B6606A321
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ev69DdBY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24B11406B6;
	Mon,  9 Nov 2026 20:32:44 +0100 (CET)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by mails.dpdk.org (Postfix) with ESMTPS id A690A4028F
 for <dev@dpdk.org>; Mon,  9 Nov 2026 20:32:42 +0100 (CET)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c434376dbebso231691866b.1
 for <dev@dpdk.org>; Mon, 09 Nov 2026 11:32:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794252762; cv=none;
 d=google.com; s=arc-20260327;
 b=eNp+lgl5hqZpkLKJoxA3j1yHfOf8kdcR5ZYqZ0SmkxQv1fg0m+ref9PQTEGrOM/VXD
 wt5nFgUE2qRFiX640x1NZPSpcUncf02TIYpwU5QYgGXCXX5ObMqC4p1hxbgNhOoHP9gh
 ++eXEIQ7LRwpBs6uGMmMwYNbbWsimkVgMQdudrpq9+lFFhZ2qPlf27b7fOQH/cTAPfcp
 QvXuR+zSxFlFK85Ixo2lQQBdKTcPyQM8xYsBnbdvGts++gIU/v7bdzJ11U7KfT3uXHLe
 QOgLPeTqq5pTfz6sza9h7O1OibuF4G7vxXdf9Ku+X2LS+y+WZQ+ae5Qd5So4foWJ2mgP
 Ku1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+61PLgrR4OS/hALbT3QTMj5VUXxTvp6b2Tj1/uYmQQg=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=NMj9HThIkevA/dtMN7Rj0bgtF3dZjI0HzwocLywaGw3Unf03CHhzt/Dl51M/nGvrhE
 QNHev6Zj2Vo4P9SmsXGdOPrnw7FYI0vF6oWjcuDeDUAd/a0V49hXJjM+ueK86siqu1zG
 O5lHXZ67XkpIHrrE0lS+ZaOUdYjiVXiz4+3KMpyBXs+ijan2uxgXZUW8UMWBk7bosuEA
 HqtuvSt8/C5DbsW1lHkNfmkmJbdVX6SgrV5geZhxTSJz30KRY0ymoWn7e5S5IQ+Npt6O
 PcFW7Tg3TUxDUZMlXH+1GC1W88G8ghtn+FTZaa/+ZvImIbDC8K1/d9aPpJ6lEIArrQDG
 KZ5Q==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794252762; x=1794857562; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+61PLgrR4OS/hALbT3QTMj5VUXxTvp6b2Tj1/uYmQQg=;
 b=ev69DdBYh7bi+ryyYasjd/e+53z/5mgcMAMCD+knbDFXawTQ2Lai2T2YZOW+pZ1Xaq
 aKV6vTtviEf4ht3E067aFKKid0xEsQc04gQTqJ0Zr5yYPIfqStVwe+r9PMyL6O3BqIen
 OrFbUKD6ceQ0mb+9QsLaAjMZ07B4uR1LjMoJKfPswG2mGPi3QhcSaiUqEbfApykT641o
 HTRSLO9pYra2Or1nqjuPwXLrJddL+N3NFIb2ThWW5k8VQ2RvKRBebMn0f7I4aUk2XAP1
 xtwI8QWTgz5E5r36Oic2E7ghW5dGMmhcGKzOdbia9fcghUZGBrqvMpFxG+fb+xGtlpVk
 Dnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794252762; x=1794857562;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+61PLgrR4OS/hALbT3QTMj5VUXxTvp6b2Tj1/uYmQQg=;
 b=X1Rz9wJu55OgeIKmZPIZpzcUEnZOfKITQTjwfhMrihxbK3aoa1jDTsys9RZXCR0sMa
 FOOzQTSCjNPVi/bANclu5hijJMriTviKMrZ9DroTCyq8ZRCBHstpiwvoz7DF4Uvf5CtJ
 cuEniwXCTOM2Dl56aibRMOP1CXMIP4JDUqsTqWUvKslnUvCVz/WHu1z2x8Mtz/WU6437
 luZBwgh4/DHn4iCpMcJrDOtyc3a2Jz5pyQKjVp1EQJwO9IkpQof8nnmMcqPaX0lKHcjA
 jnH4MhvLNU3OINeGXgTNEoG32yJZ6A8r4PD789iwVvE0FgnyrzStG5wY539Q1gxQm3B1
 N0Rw==
X-Gm-Message-State: APuU4Z9VS1XAUx60gjnDLqFbPE3hR6Up+oAVlRrbFQlEDbRQWcd+GWE7
 OwKv+CRdRvi2TbmsyNYSZixniKah94tLLVL0uAPPTfvpdFUHN4L2VAm0Vpq+9lpnQJ66lg9F646
 HXZineUTXmLBH+zYKITtXHjfaQEdPtsUJoklDvodP96sU4noQXafMgErq
X-Gm-Gg: AYBFou3ohf0fWU+fNxq+2RPOgilS/1LTZxXzEw4/LHMZKjwpY4Pre2247hvVbUOyDnh
 L1ZfD2IyALMhvDIfWRfd2LUtTYU4peMkY6VXhlnlUQCnoCq0iEpX7ZMPcIEclZ7z+m6kLyU1kvI
 P3RRSW5ES8+XvhwlFd5E27IrLxgBqnqVXfkmzKlT1k/EstINQ3G32I1BcsIcQV9EVP214VbPPTA
 JwyBb52Xkk1QoDikSlEKT9UIrSJkScoKu3zVPLyt41WhT4UIpfrjFdzlhLCvAEqH67ZPIU6XhP6
 em7CpYXR2yfbv4Nne2ounhjTvvbqd6+a3869CB3zvov7x6HypeG05FVgyPZAkPdWYw3l8d16xMQ
 MRWivZdIPWrdnk0uRZrhX+dYKPHAaoShJvdsgSaKunqAt6SouOWKI7tIILKm9TUa6k/Q=
X-Received: by 2002:a17:907:ea8c:b0:c2e:616b:6763 with SMTP id
 a640c23a62f3a-c504935a60cmr35365766b.3.1794252761478; Mon, 09 Nov 2026
 11:32:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030184304.508282-1-joshwash@google.com>
 <20261103181442.381856-1-joshwash@google.com>
 <20261109095750.7b0465ac@phoenix.local>
In-Reply-To: <20261109095750.7b0465ac@phoenix.local>
From: Joshua Washington <joshwash@google.com>
Date: Mon, 9 Nov 2026 11:32:30 -0800
X-Gm-Features: AclHuK_gmmJbC4-xe2bqIamkaNaFI7orSb4VoSAf8nohCcMt_Rjm-55vTcsYP1Y
Message-ID: <CALuQH+U9L-+K9sk3UtBw8=VU609h4jzStuoNEPHKjpuSs6QEwg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] net/gve: TSO descriptor count fixes for GVE DQO
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
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
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 9:57=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue,  3 Nov 2026 10:14:39 -0800
> Joshua Washington <joshwash@google.com> wrote:
>
> > https://inbox.dpdk.org/dev/20250707231812.1937260-7-joshwash@google.com=
/
> > introduced descriptor limit checks for TSO packets in DPDK.
> > Unfortunately, a couple of bugs have been found in the implementation.
> >
> > This patch series introduces fixes for those bugs and adds support for
> > the tx_pkt_prepare callback to reject potentially invalid packets befor=
e
> > they are dropped in the transmission path. Before a recently introduced
> > patch, the GVE behavior was to stop transmitting at the first invalid
> > packet, which would allow the application to do any necessary
> > linearization or packet modification before attempting to transmit
> > again. It turns out that that behavior is considered incorrect, so offe=
r
> > tx_pkt_prepare as an alternative.
> >
> > Changes in v3:
> > - Remove extraneous Fixes tags.
> > - Drop patch 2 allowing multi-segment HEADERS, since that conflicts wit=
h
> >   tx_pkt_prepare.
> >
> > Changes in v2:
> > - Rely on tx_pkt->nb_segs for descriptor limit calculation only as a
> >   precursor, falling back to the traditional gve_tx_pkt_nb_data_descs()
> >   if that optimization fails.
> > - Only call rte_net_intel_cksum_preapre on TSO packets that request
> >   checksum offloading. This enforces the additional requirement that
> >   headers are all in the same mbuf segment.
> > - Introduce new patch to validate minimum header length
> >
> > Joshua Washington (3):
> >   net/gve: fix TSO segment offset calculation
> >   net/gve: introduce Tx packet preparation for DQO format
> >   net/gve: validate minimum header length for TSO packets
> >
> >  drivers/net/gve/base/gve_desc_dqo.h |  1 +
> >  drivers/net/gve/gve_ethdev.h        |  3 +
> >  drivers/net/gve/gve_tx_dqo.c        | 86 +++++++++++++++++++++++++++--
> >  3 files changed, 85 insertions(+), 5 deletions(-)
>
> Ready for next-net but AI review found some dead code.
> Could you test that assumption and send new version.

Ah, I had confirmed that the code was dead, but was under the
impression that the patch would be merge as-is given that the issue is
mostly cosmetic, so I didn't send a new revision. I can send up a new
revision now.


>
> Review: [PATCH v3 0/3] net/gve: DQO TSO validation fixes
>
> Applied to next-net (339c992f25) with no conflicts. Each commit
> builds with -Dwerror=3Dtrue.
>
> v3 drops the multi-mbuf header patch and keeps the data_len >=3D
> headlen check. That resolves both v2 warnings.
>
>
> Patch 2/3: net/gve: introduce Tx packet preparation for DQO format
>
> Info: the csum test is dead code. GVE_TX_CKSUM_OFFLOAD_MASK_DQO
> includes RTE_MBUF_F_TX_TCP_SEG through GVE_TX_CKSUM_OFFLOAD_MASK,
> so "csum && tso" is just "tso". Simplify to:
>
>         if (tso) {
>                 err =3D rte_net_intel_cksum_prepare(tx_pkt);
>                 if (err !=3D 0) {
>                         rte_errno =3D -err;
>                         return i;
>                 }
>         }
>
> The commit message should then say that the pseudo-header is seeded
> for all TSO packets, not "for packets with checksum offloading
> enabled".
>
>
> Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
