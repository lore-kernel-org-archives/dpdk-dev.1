Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B63CD342F
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 16:39:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33ED340150;
	Fri,  8 May 2026 18:39:39 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 800834013F
 for <dev@dpdk.org>; Fri,  8 May 2026 18:39:37 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2f3c623322bso3664778eec.0
 for <dev@dpdk.org>; Fri, 08 May 2026 09:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778258376;
 x=1778863176; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=xKoIeGgUEFer1E+Jk+tpnXpnnbC63ipiujATg/7pGdk=;
 b=AksbMxQWUPJHujXDmD/mcGiWHtXcQkF/kCJjGTJ9k+1LvfiGy76ejenk9Lht2HRwtE
 3+jGXieNYAHUSLNZG6s00UzpWfJ0+YJ1Nxci7LaSiSE9fXu1WqdKC1DiU0gdLGA1cMKU
 ZcUlV4JPVzpwAI+7r9dliZ3o7SI4aOcOCwOoDIBX9x1P9utL27KksYd5dLGvsb41oJsy
 FjD6m20HeI91x1aGRuPr5cxKh2dMJNkD8kc0omepDOOh/MC+XWD1WosbdbVEjmwpoFiy
 v5Vf3vjQovwE4ZZhes5qFAC4Eo9Jedanuhvy+11PfrfL++PBGY+Kq0dF97MFIPxGwxO6
 G1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778258376; x=1778863176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xKoIeGgUEFer1E+Jk+tpnXpnnbC63ipiujATg/7pGdk=;
 b=RtkHlGC+KzbhDQnxLESRCkQ2cCttlwz0MBE5ogUUxqJ8awgpjSVJ/JhYwUtXlbsad+
 mcUSe6nFisTLgVGsjbUT0V5Zn+qJ8PIU5ZEoGq49YuLAR2QDfI/WKp7IgvkRLC3buIHe
 zEaZ7lXVRLgHMaqwZLYO0maBvTpwa2CMv+yMethBBMXCyrQl2gqWjJgK7Z5sPYPsHgzy
 KxEBKWGakZ6f9UOAZO274OJLRyA1qqqocihoCWqMPh7GSiPniE2BEzkmQ7zczGSS8MZu
 Bs+f9pCRxK5QmLw235b6Mhr8lAZ2VVzodJlOoKffmpHla5e0Nu91NhgHGLHmyOeksEcB
 Mw5w==
X-Gm-Message-State: AOJu0Yy+dcJT5MBUcCtiAmmVlNCl9O4NF2qE8FWdrKFXlRhiqdqVkmMt
 tp54wyz6+6g1AxBQizryWzvSWkM6CpO5dV4hsC7nJy6jY/FRQ1MFd/DR5AorRMaGlFCWLgCIRUS
 tuPpX
X-Gm-Gg: Acq92OEJL/WLpSEZI9zZNiw9uWwMsebGUCrF/P3qD9ulyAWLwO9GbDQsERlGIbJMNYj
 VmN77VbbOSGbhb/7tBsCZGEXY8aeWXemvUtywlia6Trfj7HsLHR7NRSehM7fOJJxTZgEEzIxJpU
 3l9EupwPaRr7gRUcZCp4aUdKVt/WYdn8P7KiHEBNSM6yJiNwBMacDmP7oadHWQD8r3PZvNyiTNU
 idEzmwVMZ4qS2C0udyBFKmkIiKQI7S3N1x0BQ6Kqlz7qAqI6QSXV7gC8FDmFEdtX+A5m8acaJtx
 NjHxBM9fUGb6U9HEQQNsQ4WUrlGbgI/CXCgUxapvWB3BZc6h7KsbfnwNRtwaG0CllRmUZsDo3wz
 YXLWYCoI0FhcXx3fdD+glHYA2B71Tjgn2zx2vsbe0yixQdR4BUXo1rhs3mJBu/v3DuG69/5h9Nf
 Pv8AdKoPK6NzadwlpSLBc7hEt3WwtSW7pZ/TRzQxBap2ncyQ==
X-Received: by 2002:a05:7301:3d1a:b0:2d4:532e:7e45 with SMTP id
 5a478bee46e88-2f54cf5dd7fmr6067189eec.23.1778258376082; 
 Fri, 08 May 2026 09:39:36 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f88924af95sm2829293eec.30.2026.05.08.09.39.35
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 09:39:35 -0700 (PDT)
Date: Fri, 8 May 2026 09:39:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH v2 0/6] fix process shared pthread mutexes
Message-ID: <20260508093932.7147e8dc@phoenix.local>
In-Reply-To: <20260414144246.110681-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
 <20260414144246.110681-1-stephen@networkplumber.org>
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

On Tue, 14 Apr 2026 07:39:52 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Several drivers and the ethdev layer initialize pthread mutexes
> in shared memory with default (process-private) attributes.
> This is undefined behavior when secondary processes use them.
> 
> This series adds PTHREAD_PROCESS_SHARED to all affected mutexes.
> All are on control paths (firmware mailbox, hotplug, flow ops,
> PHY negotiation) where sleeping is acceptable.
> 
> See POSIX spec:
> https://pubs.opengroup.org/onlinepubs/009696899/functions/pthread_mutexattr_getpshared.html
> 
> Bugzilla ID: 662
> 
> v2 - fix build on Windows which does not need this.
> 
> Stephen Hemminger (6):
>   ethdev: fix flow_ops_mutex for multi-process
>   net/failsafe: fix hotplug_mutex for multi-process
>   net/atlantic: fix mbox_mutex for multi-process
>   net/axgbe: fix mutexes for multi-process
>   net/bnxt: fix mutexes for multi-process
>   net/hinic: fix mutexes for multi-process
> 
>  drivers/net/atlantic/atl_ethdev.c      | 14 +++++++++++++-
>  drivers/net/axgbe/axgbe_ethdev.c       | 19 +++++++++++++++----
>  drivers/net/bnxt/bnxt_ethdev.c         | 11 ++++++-----
>  drivers/net/bnxt/bnxt_txq.c            |  3 ++-
>  drivers/net/bnxt/bnxt_util.c           | 13 +++++++++++++
>  drivers/net/bnxt/bnxt_util.h           |  2 ++
>  drivers/net/bnxt/tf_ulp/bnxt_ulp.c     |  2 +-
>  drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c  |  2 +-
>  drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c |  2 +-
>  drivers/net/failsafe/failsafe.c        | 15 ++++++++++++---
>  drivers/net/hinic/base/hinic_compat.h  | 13 ++++++++++++-
>  lib/ethdev/ethdev_driver.c             | 22 +++++++++++++++++++++-
>  12 files changed, 99 insertions(+), 19 deletions(-)
> 

Applied to next-net with helper.
