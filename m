Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B0FC531C9
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 15:20:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 194EE402EE;
	Fri, 24 Jul 2026 17:20:33 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id BB7D14028B
 for <dev@dpdk.org>; Fri, 24 Jul 2026 17:20:31 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-38e071ed6aeso432041a91.0
 for <dev@dpdk.org>; Fri, 24 Jul 2026 08:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784906431;
 x=1785511231; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hTU3n8NEI8LoB8QbMBeNjoQ2/d37NjnCJJn6bu4XnME=;
 b=bsbyk4pt3bPp9ROXUd7IWUTZVXGG3S6s4FWWYHZzhTjqe25CHFpMuChnv59rUG6PzM
 7r2QKgVNsLRDLjFKgA6Fi2r9ll7En9BqQj2T8yvDO3y1oX8HdUVW3sD2Xka/rwp1HFBd
 1ucaPoDHpSk3uMMiXsKAsaDv91CK3IWALrCBbE7xh0OyyVecuRtrFJShWq8Ci+0SB5Q0
 1APrsOCiTARqFpmpYHJcEyuA90nQVrSNvmpTIhiY11/4XBmHJYK1+CtI5k/GYB0rxaD1
 G9zraiTd4ym6Z0BJseR1oUxHYz49yuHGsxq46OHTo2ge+bR71HD5PH4KWmx6D9zrjwsR
 tMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784906431; x=1785511231;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hTU3n8NEI8LoB8QbMBeNjoQ2/d37NjnCJJn6bu4XnME=;
 b=gh1nWmlqx20Pv0m4EhEUT4bj0WvvecKLSy55CbRv3+Tnpl1/IGkZIfq63EBImxvSz8
 u1Xlw8hUvLAqfHE7tFJfD9q1LYPFOTR1GIxNV86pFrALMCLEKfdMApE6Zw9LxYRXPi9P
 36wrY4YCWtvtS+YstT/i3RTHin5qyB0kQbcagne6tGjR1zv/I1oF54MJGTZ8H0vMUn+k
 7vJ6nKP3DlrYYrksN+xsUOCcDpchwy6ISpnn1v+dtWm7n9wJTp8BD2M+Cjba5LjgSlyz
 kb1HBD/4hSLoMuz75GgUS/XHkK+XIBnxTXB8BXIvNe7uC5QJnRbETngiJ17zieedcvK/
 6U8g==
X-Gm-Message-State: AOJu0YyLK8rHEEOtkD3B/Md7LLeJ8kQLWt1DHipiprYiwWoYQ+yXlZaX
 sa8zd1z10r5CcnG6eQ5jyPKN7RzlIgaOS4+kGpONyxKKDYwtKBmsaTpjK8Cfz89yrM0=
X-Gm-Gg: AR+sD12OFUmWcc1FAs/PeLYy8qXwweTsk8YNO5sKBiMrMhYOEGKCJ3ojkyeHAsYQV2/
 9DuLFC8ILrVt8Kk55ZHsNRpiWgJir44pGKOOwlPO9FxIB0sVhv3o7nfGSAyKRzrNSHBcQ2Xg6tl
 xFNWhFOds0Y3wVTOhNqpOkBmJxx/OAPVI1lG/QaIyELscHF44J54COiDwCyyFi2pdoLLwobWEca
 8g8+aYe3+vLo1jhYZ3cu3TbI+H5kpTpWwFtkSPu3ccbWeWdDeCKexwmE/1PrjeEJCigKp0YBYtZ
 ahGsgVe1hSaAIxSleKwNdcQ0RIKEHn0620ffGFBriFfbo5kDB0LLWEGyazCjt4mFNXHDOvMHRvF
 4tcc+MTmfvsqH14U0ExQRymviLkfcNXr+IEnRolckKaxyQQC+Dq8f84TwwfgxMJprV7EP/It3lM
 jgda26SkWxrwgKNp7XDOFu/E4dDnjxXlbtjgBBcYZmvtE=
X-Received: by 2002:a17:90b:2881:b0:38e:2860:253f with SMTP id
 98e67ed59e1d1-38ec64bba97mr8051875a91.12.1784906430689; 
 Fri, 24 Jul 2026 08:20:30 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm45882521c88.2.2026.07.24.08.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 08:20:30 -0700 (PDT)
Date: Fri, 24 Jul 2026 08:20:26 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
Subject: Re: [PATCH v2 4/9] net/cnxk: remove queue stats mapping
Message-ID: <20260724082026.48f63347@phoenix.local>
In-Reply-To: <CAJFAV8x3t=CFs=q0uw=fhCncUMKQ82wmOpzsOz-LKEN4ez9r1w@mail.gmail.com>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260723202936.378793-1-stephen@networkplumber.org>
 <20260723202936.378793-5-stephen@networkplumber.org>
 <CAJFAV8x3t=CFs=q0uw=fhCncUMKQ82wmOpzsOz-LKEN4ez9r1w@mail.gmail.com>
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

On Fri, 24 Jul 2026 09:26:10 +0200
David Marchand <david.marchand@redhat.com> wrote:

> > +       for (i = 0; i < eth_dev->data->nb_rx_queues; i++) {
> > +               struct roc_nix_stats_queue qstats_data;
> > +
> > +               if (i >= RTE_ETHDEV_QUEUE_STAT_CNTRS)
> > +                       break;
> > +
> > +               rc = roc_nix_stats_queue_get(nix, i, 1, &qstats_data);
> > +               if (rc)
> > +                       goto exit;
> > +               qstats->q_ipackets[i] = qstats_data.rx_pkts;
> > +               qstats->q_ibytes[i] = qstats_data.rx_octs;
> > +               qstats->q_errors[i] += qstats_data.rx_drop_pkts;  
> 
> It was already there, but I find it suspicious that only Rx errors are
> handled like those are reset on read.

This was a somewhat automated conversion.
It looks like the rx error counter across all queues is populated
from hardware and rx_drop is counted in software per queue.
