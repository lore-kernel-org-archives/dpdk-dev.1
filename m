Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2347BCA0FF0
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 13:48:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7285040263;
	Fri, 29 Aug 2025 15:48:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id CDE184025A
 for <dev@dpdk.org>; Fri, 29 Aug 2025 15:48:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756475324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WWAV0n9wG1qyxQOfigHkvPiCrTQGmH7ZiU9z6O6taR4=;
 b=QWub3BRgQnGhXJyqXGC7A1TrkktWJKzzBD7aYnZJVcwldhgzpZQLfBSyIkEsdVUl6Gqur6
 71dOGJFiQiW7htXvo9WAG/U2SMB8uxfubeuNKiVrx/VubhctOj2+sL29ytPbCuHHLcqKny
 BC+/AZTv7iqb0/F9HPf6la8ob5kJlTo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-ngYdhT7kMjC0-RzvxBEp9A-1; Fri, 29 Aug 2025 09:48:42 -0400
X-MC-Unique: ngYdhT7kMjC0-RzvxBEp9A-1
X-Mimecast-MFC-AGG-ID: ngYdhT7kMjC0-RzvxBEp9A_1756475320
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-336a6070642so9062841fa.0
 for <dev@dpdk.org>; Fri, 29 Aug 2025 06:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756475320; x=1757080120;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WWAV0n9wG1qyxQOfigHkvPiCrTQGmH7ZiU9z6O6taR4=;
 b=Wz9GkQMo6wGt5iijXptko4P0byrYFqiGknhMFvjEOr4GHdbqHeTRbK2XDb60KSliTZ
 ngYdxKPytjmq+2xxP5iKzlMZXtLrNeGabFtf30yZsLUklSfv3Z5+bofvS/S7tNd9kB1t
 M0YJj8ISIQRnxj5/m5PTfjZkK/guq53DVsWu4q7FB+SQsaZh7oQHlu5iXaODWJL7XUxN
 jvkF+aNebBwYzH05Jj6vmiS22sXHsaOoqYBPM9Oc/UO8GEnoMbZ8nVio/gW6Kh+rLg85
 //NAMdXSoKjhMUcp/cwgQzpQpW61YfhCcUaMyYZxRo1vHVP29OHM/fjqu/pKpjRbUdvM
 ATGw==
X-Gm-Message-State: AOJu0Yz9aXGtB3TmgKoHsZ+PRr0hU7mlCNegBbLB6AAfm4Mr+bDOEIqj
 0koSloya7E1CZkT/Xdrn9JLfEUA8YdvMb2NxNVa1pPN8cJwsCsA+Z8HLYrI8DmWJjT0Gd5fOXis
 jXs3U7BIo1gyMBjzZjRJ/J6Zn3BeMeVAw4RFgyYP8J8dbcBbC5ApHZ+7ekgFP7D+IYuAh2ZjofR
 yQNIw5gRxiKr0xF95QaSE=
X-Gm-Gg: ASbGncvwX8B6BYa6mEFioFCd95AQodqpqp4x84Qi32c5K9c3EZs78vhOYK3vgTdNcLe
 nB8qq0UUunkYbbwcbVJYB+k+IU4CViK9afZ8NZRCy5Pq2SCj0JGBZP8jcpjbzqSQG9+U00CKoqV
 y5l5QhShKq2demIKrvRWix/gM=
X-Received: by 2002:a05:6512:4615:b0:55f:542f:1f62 with SMTP id
 2adb3069b0e04-55f542f2145mr2651242e87.19.1756475320346; 
 Fri, 29 Aug 2025 06:48:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+4gdZ+24HETTlyF1kmWEenpKm9dD3ANcgvzbZnBrUcZp5yF2LDLImATo9+yhkUncbYVQtgEVSgcXhjUJ+hvw=
X-Received: by 2002:a05:6512:4615:b0:55f:542f:1f62 with SMTP id
 2adb3069b0e04-55f542f2145mr2651235e87.19.1756475319914; Fri, 29 Aug 2025
 06:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250630132904.1704901-1-bruce.richardson@intel.com>
 <20250728151908.338534-1-bruce.richardson@intel.com>
In-Reply-To: <20250728151908.338534-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 29 Aug 2025 15:48:28 +0200
X-Gm-Features: Ac12FXw7qw_YbJvNh12hSwqT4fkq1doY-hL-CpryEvFLRuhZthMAB98_ZMJSqhQ
Message-ID: <CAJFAV8xLcbFM+d4yj5Ygm+HQeEB6=h+orjgCQVRLUHd+Px7O-w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] remove fallbacks for old Linux versions
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iCC-vinpzKbta2xSXZCo3uIL3p3eiVFc0skSgEv3zwg_1756475320
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

On Mon, 28 Jul 2025 at 17:19, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> We no longer support versions of linux before 4.19[1], therefore
> all supported linux versions support F_ADD_SEALS (Linux 3.17+) and
> MFD_HUGETLB (Linux 4.14+), so no need to have #ifdefs and fallbacks to
> support systems which do not support those features.
>
> [1] https://doc.dpdk.org/guides/linux_gsg/sys_reqs.html#system-software
>
> v2: rebase and resubmit on 25.11-rc0 baseline
>
> Bruce Richardson (3):
>   eal/linux: remove fallbacks for old Linux versions
>   vhost: : remove fallbacks for old Linux versions
>   memif: : remove fallbacks for old Linux versions
>
>  drivers/net/memif/rte_eth_memif.h |  41 -------
>  lib/eal/linux/eal_memalloc.c      | 174 +++++-------------------------
>  lib/eal/linux/eal_memory.c        |   7 --
>  lib/vhost/vhost_user.c            |   7 --
>  4 files changed, 24 insertions(+), 205 deletions(-)

Series applied, thanks Bruce.


-- 
David Marchand

