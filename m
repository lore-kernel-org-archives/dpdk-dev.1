Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17116CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 16:34:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 581F440267;
	Mon, 18 Aug 2025 18:34:23 +0200 (CEST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 34C1340262
 for <dev@dpdk.org>; Mon, 18 Aug 2025 18:34:22 +0200 (CEST)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-45a1b0cd668so22736405e9.3
 for <dev@dpdk.org>; Mon, 18 Aug 2025 09:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755534861;
 x=1756139661; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=3h+/83059fh6GFa+2S7MTkM6Gf63lyg5GLV2NJra99o=;
 b=U/pZ8xQIOr+sR1T/wFy2l0HriPfQGIhDTsAeqcyjzT46B4AEA5O0RRUNtTfF2S1f9e
 3ibfzKniakj9/mvQzIS0fHxR90hbEHss+PVhlvqgUsxAVaokaJMjnYnlsz+7EMqws96m
 d/FPpBQuiwXfXqk3T3paemuWapfwiCFRDrnEY821loYY2QSJMs+r7/2ELYH6+krdKzz/
 AwIqsYjFhxB341TwaGiKNWp4WWaj4A/l07k+5Kkg4D3R7Xxv3xTLdwUsMI0uQjxsG/Fg
 ZFXZ0ezWfLlGSyAAJbidKqnDlffVTkJ77MaBAP1x/UPWltMxKvlrEzuD0QePfNe5Yy8C
 S4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755534861; x=1756139661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3h+/83059fh6GFa+2S7MTkM6Gf63lyg5GLV2NJra99o=;
 b=gbX0ReWTalmPLODUIrjFiRvTKUu3Yv/eS1xoWXgtSXkMokAUEbfbDRKgLb9FWoAof9
 n0yr69g06OapS3dsSEt+lp0lptLsBtx5ljMA/h3SvteqU0is6aGljO0XfJN0/I5O0SaB
 JreXnTXMGs2L0tEiGpt+TNgnVWfmhZLsM76xnKndvUFb2hdc66KmeQqCDTGqwlz04/N0
 lZrDyvzugCSDRqhcN4Yul5xYa0NIeO/TFreWjzOqiFSWQrdJth3LvC51FckF6wcjwwmo
 +UfI3pIhdrlIIk2RlWcDSh/MSMKmqNUfYyCNbGqtlUj2Zh/5vkt5z1vnWcoOGAkUVaZY
 MqnA==
X-Gm-Message-State: AOJu0Yyq0EF9OalEeTkk8FbDkOsKo86qd9zF2M6WWlYzQzQ8Ag6hY3cF
 YbW9OPClN7YTfN0JfQh/rUJj9DADFNbm8HUQuBv9dVrWPgx6TeeWgxvSxicKIaABNt9i+88dc3I
 1UjNB
X-Gm-Gg: ASbGncvmyXu8w4jXNnW6SqygyCiSxgcXFs8MraGuA1AQ8UieA4BHHjwkGQmdcwKn9jp
 7gqN1ZnVtUFUd9Bdv6aBYHqU3lcTQbJ3zlvippzJR+ERa0a8Ur/x3ZhVXVUdm7s9/kDV4k8y5s9
 +yxQqeDhvuBaYyIu/CSW7L+9rjCugYE2omxffhAWAK2JrAgdiUjR7MWHP5i/nv/X6r9keuFXt+Q
 LiPUs4aWw58nOcVoRzKy9YwNeCtdytrS12Pa9zo1bKFHRIEnM1HM2CuCZ4/2exrdheoupkc2VaR
 3nwDMwdFUc8l/HTLk/WjFXQqxXBuCL6xls+v/UQJ49ujrlNfP6x7w8PcLIehLe0dBu477KOPYoN
 2HFcmk89MNW/RK5XWL4J5+2Ac/lpongibZy0lFAz6bcmM7Yo82hO1dp4OlgXNIGoQbPWQsQ1v5G
 I=
X-Google-Smtp-Source: AGHT+IEofAJmDKu1WITn8oMIqUtjv85sw6QgqjWm143dYFuHiZO2SdyaE9l+lKwwb6bD6r5Ki8wdDw==
X-Received: by 2002:a05:600c:b90:b0:439:86fb:7340 with SMTP id
 5b1f17b1804b1-45a21877960mr118424855e9.30.1755534861147; 
 Mon, 18 Aug 2025 09:34:21 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879f5fsm167407f8f.4.2025.08.18.09.34.20
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 09:34:20 -0700 (PDT)
Date: Mon, 18 Aug 2025 09:34:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH v3 0/9] introduce common FOREACH_SAFE macros
Message-ID: <20250818093416.057aad97@hermes.local>
In-Reply-To: <20250312231715.222149-1-stephen@networkplumber.org>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250312231715.222149-1-stephen@networkplumber.org>
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

On Wed, 12 Mar 2025 16:15:29 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> This series adds common macros for safe iteration over lists.
> It is a subset copy of the macros from FreeBSD that are
> missing from the Linux header sys/queue.h
> 
> Chose this over several other options:
>   - let each driver define their own as needed.
>     One Intel driver got it wrong, others will as well.
>   - rename all the queue macros to RTE_XXX variants.
>     Seems like useless renaming and confusion.
>   - Several distros have libbsd package with the correct macros.
>     But adding yet another dependency to DPDK would be annoying
>     for something this basic.
> 
> There are more macros in FreeBSD header that could be useful,
> but we can add those later as needed here.
> 
> v3 - add a few more open coded loops that can use a macro
> 
> Stephen Hemminger (9):
>   eal: add queue macro extensions from FreeBSD
>   net/qede: fix use after free
>   bus/fslmc: fix use after free
>   net/bnxt: fix use after free
>   net/iavf: replace local version of TAILQ_FOREACH_SAFE
>   vhost: replace open coded TAILQ_FOREACH_SAFE
>   raw/ifpga: use EAL version of TAILQ_FOREACH_SAFE
>   net/i40e: replace open coded version of LIST_FOREACH_SAFE
>   net/ice: replace open coded version of LIST_FOREACH_SAFE
> 
>  drivers/bus/fslmc/portal/dpaa2_hw_dpio.c |   5 +-
>  drivers/net/bnxt/bnxt_filter.c           |   8 +-
>  drivers/net/intel/i40e/i40e_ethdev.c     |   9 +-
>  drivers/net/intel/iavf/iavf_vchnl.c      |   8 +-
>  drivers/net/intel/ice/ice_ethdev.c       |   9 +-
>  drivers/net/qede/qede_ethdev.h           |   3 +-
>  drivers/net/qede/qede_filter.c           |  13 +-
>  drivers/raw/ifpga/base/ifpga_enumerate.c |   4 +-
>  drivers/raw/ifpga/base/opae_osdep.h      |   1 +
>  lib/eal/include/meson.build              |   3 +-
>  lib/eal/include/rte_queue.h              | 174 +++++++++++++++++++++++

Revisiting this and wondering about naming...
The file rte_queue.h is not really DPDK (ie not related to runtime environment).
Thinking of calling it bsd_queue.h as a comprimise
