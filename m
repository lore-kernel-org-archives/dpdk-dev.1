Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4D2CD8C89
	for <dpdk-dev@archiver.kernel.org>; Sun,  7 Jun 2026 18:15:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D634402AD;
	Sun,  7 Jun 2026 20:15:45 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id B757C40278
 for <dev@dpdk.org>; Sun,  7 Jun 2026 20:15:43 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-3074adb8fcaso5296381eec.0
 for <dev@dpdk.org>; Sun, 07 Jun 2026 11:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780856143;
 x=1781460943; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SyDJgXtweoge33xxWONtu2pkAIGJyWSCh/PSHkA7KAc=;
 b=B3CRW0EqP7p3i4bd/F8x/uc7XUgYRbORWMezN/OH1bPZtPjmQczGRteOUKZ1Ya8865
 bv/OqUx2aa+CAz9Cy+Xkl4Ujo+UoJbhkfEeNZNonZQvVUwp7rOqHqKBZJ6ChGjzOEKV6
 sbUlFZFzgyVcekh1GQigK9Dth/M/iX8aB5HF4Mx9ivbGm5IiWTuFmgQe/Vys4VCbtgXl
 O9mBe2AN6NW7hkosMhKBlhtW4AMoGOAGHU9sriBVjdGCk5HiR0x1AMmHno0CoL8n7oPk
 BlWPJURHTVtFwrcdOJOj3ZyfY8DggWSB1gw9a+yCwHPmdiIUrVso9N+uVQn2pASquLeQ
 XuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780856143; x=1781460943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SyDJgXtweoge33xxWONtu2pkAIGJyWSCh/PSHkA7KAc=;
 b=BBTvlSI6VugyZlIUKiARv5/3do04wCKJ4aCl25wv2w3RrEQggQaTsCEtpfj9jxt3Jj
 7/E/YnusigL6aHIYIUE3hb2cdsOacrUvpQ/U7rcRdjeBmh/K46H2VgyarDQbIAXGMw5Z
 5UwFPjDLxvldshsGjp3TtK6Uii3eGaMapXsYsbH9ldEhaQd518LiscHz9cXMiWE5tuDT
 ee3gLjMq0ZhjtNOPYuXC445kKGZ2wRXhq4kQArx89/tzQYe1bkNchclV5GdGIQf0Z+p4
 C7lSZWSMHELlQcC2H4G9txOOGf8sOZ9GSD1VbKtOerByKI1me2xCMQTfasjHj6mBmpTg
 0B9A==
X-Gm-Message-State: AOJu0Yyw+f2u1pAbcKrjkRxfNGkB+2nD/YqwJWOiXp561jmshLj2MWoL
 fXyNIa0PDleamE6u/JI0RHqyUqgDPTK8LZEhl+wMHg1kqkSt9re40olvfGx+TTv+9AqfoEJ5Kf3
 CO3rb
X-Gm-Gg: Acq92OHnhGfnMfuJKFE25kglAL/+g3KrmWXAcceBW8+gR7ZQjkex8W0vH2RntrRrCdu
 5MjL96AnCWKMr1dQcSnJmcYM9MqJxurFxZF9UIu4fZ+lg8xU+mKcIiUvi/MYUgdRKU8ExRk5qDP
 RZnABff6JWGn39lPMN1Gzul/ojWMqqBPlNuKvzif+p+vuaxSS7JdGW9XddJgxFtgoX5HiPhmUGK
 jbWGQBbr9CeGl6ZL73Zz8Ymd1elMBFdH1o42xHEVstV4yfmbDCdMN/YOpShaaViOZD/j6/GKMiJ
 XXMqBos0hTc4LrOEye5jq4DKDz+057v9/1lKGVk5UD9ozOSqH8IvIgPJdYuU+zC97+8a6upqymr
 P2A7AM8XvlgmDpUL5AyOay7360I8F4jazr02TCK6Ma5cSUTOjHjQh08SOn8fpfWAnyhlUriyGNY
 4oIiVNUSXrmDLpAS0Q80qyKnBrsHsyn2/zX6rTq9l75hom4mlo7mIe57brPADxpGi0V7eJfnvOY
 rM=
X-Received: by 2002:a05:7300:7314:b0:304:641b:12fd with SMTP id
 5a478bee46e88-3077b22b54cmr7605858eec.27.1780856142438; 
 Sun, 07 Jun 2026 11:15:42 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df3b234sm18687244eec.23.2026.06.07.11.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 11:15:42 -0700 (PDT)
Date: Sun, 7 Jun 2026 11:15:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 00/10] selective Rx
Message-ID: <20260607111540.0d9835a5@phoenix.local>
In-Reply-To: <20260605233456.3017423-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260605233456.3017423-1-thomas@monjalon.net>
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

On Sat,  6 Jun 2026 01:33:40 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> This is a new feature in ethdev with tests and mlx5 implementation.
> Selective Rx allows to receive partial data,
> saving some hardware bandwidth.
> 
> v2: rework after Gregory
> v3: fix bugs found with AI by Stephen
> v4: fix packet type in DTS test
> v5: fix mlx5 Rx to handle discarding first segment
> v6: fix reindent patch
> v7: fix mlx5 CQE error handling + outdated mcqe + redundant assignment
> v8: use --mbuf-size 0 in testpmd instead of changing --rxoffs behaviour
> v9: fix testpmd and DTS
> 
> Gregory Etelson (4):
>   ethdev: introduce selective Rx
>   app/testpmd: support selective Rx
>   common/mlx5: add null MR functions
>   net/mlx5: support selective Rx
> 
> Thomas Monjalon (6):
>   app/testpmd: print Rx split capabilities
>   net/mlx5: fix Rx split segment counter type
>   common/mlx5: remove callbacks for MR registration
>   dts: fix topology capability comparison
>   dts: use specific types for Rx/Tx offloads
>   dts: add selective Rx tests
> 
>  app/test-pmd/cmdline.c                        |   2 +-
>  app/test-pmd/config.c                         |  17 ++
>  app/test-pmd/parameters.c                     |   5 +-
>  app/test-pmd/testpmd.c                        |  48 +--
>  app/test-pmd/testpmd.h                        |  16 +
>  devtools/libabigail.abignore                  |   7 +
>  doc/guides/nics/features.rst                  |  14 +
>  doc/guides/nics/features/default.ini          |   1 +
>  doc/guides/nics/features/mlx5.ini             |   1 +
>  doc/guides/nics/mlx5.rst                      |  86 ++++--
>  doc/guides/rel_notes/release_26_07.rst        |  11 +
>  doc/guides/testpmd_app_ug/run_app.rst         |  16 +
>  doc/guides/testpmd_app_ug/testpmd_funcs.rst   |   3 +-
>  drivers/common/mlx5/linux/mlx5_common_verbs.c |  53 ++--
>  drivers/common/mlx5/mlx5_common.c             |   6 +-
>  drivers/common/mlx5/mlx5_common_mr.c          |  37 +--
>  drivers/common/mlx5/mlx5_common_mr.h          |  29 +-
>  drivers/common/mlx5/windows/mlx5_common_os.c  |  31 +-
>  drivers/compress/mlx5/mlx5_compress.c         |   4 +-
>  drivers/crypto/mlx5/mlx5_crypto.h             |   2 -
>  drivers/crypto/mlx5/mlx5_crypto_gcm.c         |   6 +-
>  drivers/net/mlx5/mlx5.c                       |   7 +
>  drivers/net/mlx5/mlx5.h                       |   4 +-
>  drivers/net/mlx5/mlx5_ethdev.c                |  25 ++
>  drivers/net/mlx5/mlx5_flow_aso.c              |  21 +-
>  drivers/net/mlx5/mlx5_flow_hw.c               |  11 +-
>  drivers/net/mlx5/mlx5_flow_quota.c            |   6 +-
>  drivers/net/mlx5/mlx5_hws_cnt.c               |  19 +-
>  drivers/net/mlx5/mlx5_rx.c                    | 187 +++++++-----
>  drivers/net/mlx5/mlx5_rx.h                    |   5 +-
>  drivers/net/mlx5/mlx5_rxq.c                   |  95 ++++--
>  drivers/net/mlx5/mlx5_trigger.c               |  64 +++-
>  dts/api/capabilities.py                       |   2 +
>  dts/api/testpmd/__init__.py                   |  17 ++
>  dts/api/testpmd/config.py                     |  11 +-
>  dts/api/testpmd/types.py                      |   6 +
>  dts/framework/params/__init__.py              |  14 +
>  dts/framework/params/types.py                 |   5 +-
>  dts/framework/testbed_model/capability.py     |  10 +-
>  dts/tests/TestSuite_rx_split.py               | 277 ++++++++++++++++++
>  lib/ethdev/rte_ethdev.c                       |  24 +-
>  lib/ethdev/rte_ethdev.h                       |  17 +-
>  42 files changed, 921 insertions(+), 301 deletions(-)
>  create mode 100644 dts/tests/TestSuite_rx_split.py
> 

Applied to net-next
