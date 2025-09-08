Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2C0CAC582
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 20:08:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCA6F402D3;
	Mon,  8 Sep 2025 22:08:16 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 11D4E40264
 for <dev@dpdk.org>; Mon,  8 Sep 2025 22:08:15 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-45deccb2c1eso1781845e9.1
 for <dev@dpdk.org>; Mon, 08 Sep 2025 13:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757362094;
 x=1757966894; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=46SXlrEuzfvc5GxrIrtxmJ9yOO3faAZJs8Eis2uhsn8=;
 b=dMuJTRrcfmubdX7Q1S8OFkXRzZtS4resJyHlDJp7Qdm577edn10UBal4CXfggvCLgT
 8QA4vfYrfXt+TtV7V/RZn9i4Yg4tEYe5iNWWqo0TeE/rVv+f5gW+1Pm9rgEnxb7KqsQW
 cSQs6mYxD7ZAl1N0lrZSB7iWTiWvOQlLV/bIyG4TZDl6bKqI+Fu48BAkebBIqVh6vWPw
 5yO25wFmUqy8wVGZrhuWMmtJtLlhzi4NkMMfldu654rXh3hBHgnlxaFLqAMtx8pXk93D
 27Juw4ICUlQdVq4z+zoTFqIkGO8EX0aE/KZyfC0vO9mKrpRddyEdSz9v9PghJBhP+7tY
 ihWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757362094; x=1757966894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=46SXlrEuzfvc5GxrIrtxmJ9yOO3faAZJs8Eis2uhsn8=;
 b=JRCey5YxJQgAUCL4vQ1un7NewcckgAnDBTmoNZUhSRWu0ZypgsRj+Ka8hKLJ8qKmOB
 YbZvbe7UVvKWw9UTm7LgCc1rPWBckRE/2+sEcwkGtHa631lGqywhik5LFQpc2xJSmMX6
 SuNw3D66Od9wC0CmkLSXXl1by4+MlFlgbIwMcT58JjqPAPm7BBWET3+ofN1Zp07ofd8p
 O5ykaR8Jw7PhbDKBwYmtE0D/yp8FZ0cfFZ0EXW3AUabzhCWN069ZeBMNa3N87hsmnMIc
 0bsXa9sjM4AUcvT8BzrOTB9hWzYV2JbaGEDxAox8P/p1etyzwROz5yiNaYlXF/yQtQ2k
 HA4Q==
X-Gm-Message-State: AOJu0Yx0UHeP+kFgyKC9hYb/Pjrs7nMtqoHDsRYdTfC1UNkO6V5DFIHu
 mh+qgqHy0DzM0WSICzMpe28qvMEi1zXXPJAjQeA0Z+aOFK6JLawDPApbwS2Wz025WIy9y5OQ6hb
 N+RHr
X-Gm-Gg: ASbGncuVi9rCBS5nk84tdFZWMtCE+MkkvErwCCk1v3hj5b5ifETVoHJCMVqGiVQ/SUm
 xg3HXLRPYonzgOPEKidT5scdiLi1nohe++R7WoDgR4cPvy89Q5DmnjD2gfQpxYg0XA9KzEBckrs
 rAMa2+2mTeB31Sd5fO9VH7wFF93qOIeWtlSIFOATtxQW/r63pqnDYqNYtHKOiRQAZbPI64z1KAr
 9KOuDX/qUmwaX8hMUpk8g40OsKWr+CD/jyLnIRuZnvU2srnxNuXclQ/1lx3z0Ua0+5WSLirPKJK
 7SC6MTUSAF/WgwkNCkgvrO5hj8iJUgteFtXuMQ07SO9D87ayBR51HeLpU86o85Y9DdjEI/9YRBD
 IdmGsXPE4zcgnsuAPE+ilpKXcHiKKu8LKSFFR7hIUAl2FTdRYx18VDueD49JdjUeT3/qLFfPrif
 k=
X-Google-Smtp-Source: AGHT+IHOcYAkOXjRpZ22bLBUALMfpi2I32sKUzKd/SIBgw7iwqmpyQHcOi9J1TeXvgpC762zjMnnWg==
X-Received: by 2002:a05:600c:4513:b0:45b:9afe:ad48 with SMTP id
 5b1f17b1804b1-45dddec3661mr96364025e9.16.1757362094344; 
 Mon, 08 Sep 2025 13:08:14 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276d204asm43075986f8f.24.2025.09.08.13.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 13:08:14 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:08:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, ckm@napatech.com
Subject: Re: [PATCH v1 0/7] migrate threads to DPDK service framework
Message-ID: <20250908130809.2266b0d3@hermes.local>
In-Reply-To: <20250908110446.1071964-1-sil-plv@napatech.com>
References: <20250908110446.1071964-1-sil-plv@napatech.com>
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

On Mon,  8 Sep 2025 13:04:38 +0200
Serhii Iliushyk <sil-plv@napatech.com> wrote:

> This modification provides better resource (CPU) management for NTNIC PMD.
> 
> The following threads are migrated:
>         * FLM update thread
>         * Statistic thread
>         * Port event thread
>         * Adapter monitoring thread
> Additionally, a warning is added to inform users about the importance of
> dedicating lcores to the DPDK service framework when using the NTNIC PMD.
> The code is also cleaned up to use pthreads and rte_thread APIs.
> 
> After this patch series, an each application using NTNIC PMD should
> dedicate at least five(5) cores for DPDK service framework to ensure
> proper operation of the NTNIC PMD.

I was concerned with excessive control thread usage before, and this
seems to be worse not better.

There are conflicting use cases here:
  1. The original DPDK goal was to make effective use of multiple cores
     with no locking. Intel customers often had idle lcore's and some CPU's
     had lots of inactive lcores that could be used to get more work done.
     Dedicating some to service tasks etc was a natural outcome.

  2. DPDK applications (OVS, Grout, VPP) usually want to know about lcores
     at least in the documentation and examples. They don't cover the case
     of service lcores.

  3. Dedicated low core count smart NIC's using DPDK. In this case it
     makes sense to be frugal with lcores since the point of the smart NIC
     is to be able to run other control services. For example, the MS
     NIC had hard limit on the DPDK part (via cgroups) of only 4 + main
     lcores.

Granted NTNIC is likely only being used for a specific application on
a specific set of hardware.

The ideal would be to have better control event management in EAL.
Something like "libevent" style API. This would reduce control core
needs, and avoid any potential resource conflict overlap between control
threads.
