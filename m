Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D467EDA694
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 16:24:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAF7B410EE;
	Tue,  3 Mar 2026 17:24:54 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9CCAB410EE
 for <dev@dpdk.org>; Tue,  3 Mar 2026 17:24:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772555092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qD6NDHYZWmwWWxytr82YAGbBc5DBMiQZmg/iTo95uiU=;
 b=fGF+b7DbNUR/FUBS3Rd85E3r0zPmNiQ2rCr/PdAGmiU/DBaNK9r9jtfi1tC3wBgMeMrtq6
 KeH2pNTue2XT93NhDb/Gde2AdOsBQPX95v4OOjLXxC/dsYhDNNAUiCAvvli4Q1e54Kz4/g
 k0pIfWtC87tCpwO5Jmdz0KnMsuTeMfs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-H7Bz2JGiOfCfX1F1YzukhA-1; Tue, 03 Mar 2026 11:24:50 -0500
X-MC-Unique: H7Bz2JGiOfCfX1F1YzukhA-1
X-Mimecast-MFC-AGG-ID: H7Bz2JGiOfCfX1F1YzukhA_1772555089
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3871bd94811so57126231fa.2
 for <dev@dpdk.org>; Tue, 03 Mar 2026 08:24:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772555089; x=1773159889;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qD6NDHYZWmwWWxytr82YAGbBc5DBMiQZmg/iTo95uiU=;
 b=F/wdjNULMr+C6awBAcnfZt/oaBeQI/iGSCLOY9D+M/fBSdSyLz5AZo9zKk/VUUCHll
 pGRhN0OldPrAx9pbQLLwsvl9peqwEfkfi04Uj0pc7FCrkXK65GvhZ7esUZ/sSrqe++ej
 xMk5fpm0ev4jJpvDQ6KEVfBgT6lX183Xnta94X5wZgXpKGkGg1vpYRjbEUc1MNfUImRu
 LGYoRPyyYQMSoC9uNyQjFbrii/6gAbplk6Om9cXQJYWNSZdTmtup30NlDteDi72yWyZS
 7+RqC6mw1qGraEmEfuKkPKWlpLzzVjhwMMOluyOJvbM9fdjS9KBbIhLIHTEwA/bulVfL
 MQ8w==
X-Gm-Message-State: AOJu0Yy1XjQsPqArXl///5k5Ho2utBdF977rBvmMXl22cgGKAbLPmbpV
 QyheDfeQG7q4KOM58NtEhDDw3e6BRJlaFZgiRJ2WWJh+QyMfsd+Y0qGlUAgNvj70KIwbKKAp25u
 UQ939oszKcSWDKP10osLuTUAdgJMlPr8B3/CKWoPXv43QzIQ0dG8GhL3JcFfdV5wC+Tp807ZM1B
 3vGIO4oR5c1b23KErcEfU=
X-Gm-Gg: ATEYQzwhRxMJbJULQDPjJlpmGFid5GjgpA0XyXz3/4QBhkq9Y7frP942iYD2yHxARgR
 fOxMKlpwjEZ680art02K3u8MNlAD6ZNHPJOCSVcdN/8uHNao3nfGjSygNjD4cKpqDkGa8It0XmS
 caTHnE+tsiVJmFdtKpzk9Qm+7u2QOqSHgx5gYSsQePYR9HQ96Iuk8Ggl+2uo052B9HuCRLgfqU1
 XlXcqD2OFBS1D89nWaTSFND3tKUuV89OooT1MLhk7fx6IN0N4iIYPrFjku4yTkbm1IUBA==
X-Received: by 2002:a05:651c:388:b0:386:46ac:835c with SMTP id
 38308e7fff4ca-389ff118c10mr84962201fa.14.1772555089098; 
 Tue, 03 Mar 2026 08:24:49 -0800 (PST)
X-Received: by 2002:a05:651c:388:b0:386:46ac:835c with SMTP id
 38308e7fff4ca-389ff118c10mr84961721fa.14.1772555087596; Tue, 03 Mar 2026
 08:24:47 -0800 (PST)
MIME-Version: 1.0
References: <20260120195418.466318-1-stephen@networkplumber.org>
 <20260205175750.653353-1-stephen@networkplumber.org>
In-Reply-To: <20260205175750.653353-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 3 Mar 2026 17:24:35 +0100
X-Gm-Features: AaiRm530jhpZFJC01OY3QWTNU5LSdEQ7WzzORFCGFzKPlJDV7u_2ZVOvskoApSI
Message-ID: <CAJFAV8weONf1KGR=zgYeFNnB=ZWM1pg1+YR+pT8bPZ5QcKCERQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Fix LTO compilation warnings
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Tejasree Kondoj <ktejasree@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x-i1hyFJMVx-xTnQOYz1KJNjcDyxsSznXRiJZQUUMWY_1772555089
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 5 Feb 2026 at 18:58, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> This series fixes compilation warnings and one buffer overflow bug
> exposed when building DPDK with Link Time Optimization (LTO) enabled.
>
> v6:
>   - net/mlx5: use __rte_assume() instead of runtime bounds check
>     per Dariusz Sosnowski's review, avoiding any overhead on the
>     flow creation fast path
>
> Stephen Hemminger (6):
>   common/cnxk: replace variable length state array
>   common/cnxk: replace variable length array
>   common/cnxk: re-enable vla warnings
>   common/cnxk: fix buffer overflow in SA setup
>   ring: use inline instead of always inline in soring
>   net/mlx5: fix LTO stringop-overflow warning
>
>  drivers/common/cnxk/meson.build      |  1 -
>  drivers/common/cnxk/roc_aes.c        |  3 ++-
>  drivers/common/cnxk/roc_nix_inl.c    |  2 +-
>  drivers/common/cnxk/roc_platform.c   |  4 ++--
>  drivers/net/mlx5/hws/mlx5dr_action.c | 11 +++++++++++
>  lib/ring/soring.c                    |  4 ++--
>  6 files changed, 18 insertions(+), 7 deletions(-)

Series applied, thanks.


-- 
David Marchand

