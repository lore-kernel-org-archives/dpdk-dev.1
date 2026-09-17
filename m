Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FC4C88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 19:56:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC351402D3;
	Thu, 17 Sep 2026 21:56:57 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id D1B4B402AC
 for <dev@dpdk.org>; Thu, 17 Sep 2026 21:56:56 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 d9443c01a7336-2db18fe459dso109225ad.3
 for <dev@dpdk.org>; Thu, 17 Sep 2026 12:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789675015;
 x=1790279815; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l58B5zZISP2FE/eZQ5FuJhYnJTBYHm9L+WkKQyrlI7w=;
 b=siz1wMr4cS7Ir2n/JKGnPExMomyp14mDfWbZXZQkhmbN4RCOY4QyBdiEmKqtQ11YLO
 LgGOYkwIq0UTFrNybLTu+MPbK/5uu+5g7LrEY9jEwcJdCtaatlSxRI3ukyxA7CKlNQzV
 vkPmb0Hu/2TSK1a2+Hjiko5K1OmgaNUy4EMdg66wnCF53b2M9b8z1S1kL7MmlBSAEhiY
 yvmpweUhCetdZqX9wue542MBnltykiWMu1m78mrIj2QacqksV7X8GH2nwBNtksTIYGxZ
 +wNNbrYx3J77QtUrgIe2YSe4Ok4bpc52KP+NzY+orlyUiZGMsJ7wER3LbVjY8yUL4rGl
 L/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675015; x=1790279815;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l58B5zZISP2FE/eZQ5FuJhYnJTBYHm9L+WkKQyrlI7w=;
 b=tmnvZ5ykTWBgs1p9PsCyvj5QFp8RMJloISP9GV5zfynd0NODkfsNEkRhwyfPe7GLpj
 llVtX5cJAy7p2GklJlNm+OwM4IHGJgfK8/ITjFvtgHmPXU3vV+WlpKgwDHIxKSrewrsV
 lqduJWALAmIHExldUTukHBcq/Ci0eQdQqkaA5ab2P+fUJXSbr80mIrPxIK1dF6WHivDh
 pnMbC3Yfp5LYz92pDuk6yRTriAW/Zbe1gCgOoHfMrP8fe+i1tf3P/w0IQk0b/m3OurM0
 6wcLaS0lwwAEsvbzPlzvOknx8YGRp8NddkCigXrnsirTWkONxf03SUPyK9RxLS87mYjW
 y2kg==
X-Gm-Message-State: AFuF++nZBqW2q8tY670f7kEW3ZNqmWSirVh+qmXL2lOliv5YDY1TqSmy
 uzDBmXEGvvc+5rlMOsN4C4Zi7x/P4tDEFuof8Oqp6r5rH2MhhS+s7ILvnEmtXsnbQhg=
X-Gm-Gg: AYBFou27Jau0CdgbsCBhhrznH9MF4iCbGMy4+gQoV4KybJTfEu4XR3y/0yaAx+hhHqP
 cPVD6fcAzdOaxHLpCog4O6BuESjs8Lb82k0yGm669usQ4BWLEySF3Zm4dcnsgOoqHdpxId2f5Xo
 hh/mB+J/FStlXQ0e5ylrGLcJOL0mmuFuOFOXdgaf1VxCr8cc0Ic1N/lpAAhf6VZMxgnyCHRPru5
 wohAUa99ocbiZLvc7C6omyelgwCAHAWWp7xKVNEryB598aoLbpuaSCew+Om+5fXzx06Np1piqVY
 K6kSYovzYgvJq1dgiWPMsKG3cEOzFVh3zuO9slDa37jRLko6Dv3EPwp6lSC0PYaF4jnF0XZ7MOU
 0VPSYp1Qua6gNdQ+TGedBo6IJfEOrv102RfQCaQRYdXoSiogrdj6jXS8MCj66qUBQY0agymEy3c
 9uGMzp84uNlcz2WOGXt0LV+EPGF0HEKgHwBhJTkIrMp53kcNbsxNgOcznsxaAP6EQ0CGUl87kOC
 PGs3xcJOCyxtwaZGOrxdHDkB0r2niGUQ7e42oX2
X-Received: by 2002:a17:90b:1d48:b0:39d:ec42:df69 with SMTP id
 98e67ed59e1d1-39e54f9da82mr392481a91.20.1789675015492; 
 Thu, 17 Sep 2026 12:56:55 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e35e532e4sm6619577a91.10.2026.09.17.12.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 12:56:55 -0700 (PDT)
Date: Thu, 17 Sep 2026 12:56:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: saeed bishara <saeed.bishara.os@gmail.com>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>
Subject: Re: [PATCH v5 11/24] drivers: replace rte_atomic16 with stdatomic
Message-ID: <20260917125653.532c04f1@phoenix.local>
In-Reply-To: <CAHfVqdVVG-W+PFZdimqwhrUrUZFSeCNodSu-VU7sscMpaiOVeA@mail.gmail.com>
References: <20260620023134.42877-1-stephen@networkplumber.org>
 <20260620023134.42877-12-stephen@networkplumber.org>
 <CAHfVqdVVG-W+PFZdimqwhrUrUZFSeCNodSu-VU7sscMpaiOVeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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


 > >         dpbp_node->dpbp_id = dpbp_id;
> > -       rte_atomic16_init(&dpbp_node->in_use);
> > +       dpbp_node->in_use = 0;
>
> The previous code implies an ordering barrier, so it guarantees that
> dpbp_node->dpbp_id is visible before in_use, while the new code
> doesn't. isn't the a problem?

No barrier is lost, because there was never one there.

rte_atomic16_init() was a plain non-atomic store:

    static inline void
    rte_atomic16_init(rte_atomic16_t *v)
    {
            v->cnt = 0;
    }

That is the generic definition in lib/eal/include/generic/rte_atomic.h,
and no architecture overrides it -- x86, ppc, arm and the rest only
override rte_atomic16_test_and_set(), never _init() or _clear(). So the
old code ordered nothing with respect to the dpbp_id store either.

> aren't rte_atomic_flag_test_and_set_explicit/rte_atomic_flag_clear_explicit
> a better candidates instead of
> rte_atomic_compare_exchange_strong_explicit/rte_atomic_store_explicit ?

There are currently no users of rte_atomic_flag_* anywhere in the tree, and that is not an accident.
atomic_flag exists mainly so C11 could guarantee that at least one atomic type is always lock-free
on all architectures.  But for DPDK it is a bad fit.
On every architecture DPDK targets, plain integer atomics are
already lock-free, so the guarantee buys nothing, and the missing
operations are a real cost -- you cannot even read the flag without
modifying it. It is a standards compromise that saw very little use
anywhere, in DPDK or outside it.

I would recommend deprecating and removing those macros as well.
