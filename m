Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E45AC44508
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 17:05:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B767742DBB;
	Wed, 21 Jan 2026 18:05:47 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 33B3442DA3
 for <dev@dpdk.org>; Wed, 21 Jan 2026 18:05:47 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47ee3da7447so647585e9.0
 for <dev@dpdk.org>; Wed, 21 Jan 2026 09:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769015147;
 x=1769619947; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nHIF+sHNimGAR0GtiVgWmtKcCXXbySkc06VQorkKvn8=;
 b=h9y0TuzIcVW7jtfjy951KbpUt3rFNNM38d0wCUT4W2n4OmpsTqhTeUi3HqEqXAAw8h
 LOzynI9CGg6qJHEp/FsdamanFxvwdmh+B+9TzjLddBNu7lFT7Cz6dEd9nUswIOVgRtVb
 ey5hnGNx2f+DID2WBZ/mc+GI7Nleo1os2T3etntx0PeyStyXLrY13Y2fJ831yMvi/W5+
 yqrVPGbyeAsoGVKTjFzblkRlEQHl2L4nLe7mGmG+6P5hTI39gWEFxsXEQOKFEuCCaIzd
 JXhWAC0tNOnFNye5uXsx/f0g/o32X9pus/NvmOQfb/1Rm+sN2Mn1jzKiGFZnR0vM9u14
 bcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769015147; x=1769619947;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nHIF+sHNimGAR0GtiVgWmtKcCXXbySkc06VQorkKvn8=;
 b=lmEVjMQS4rsI03ltsJiA5rDxmuwnyKUxhjrJMX33DBYLhSS3IUnh6P69gDAdNkqD0L
 vqpDrgNrm3jsVNFovO+iitB1hJVDKHJG0figoAhQeRUPI4PwA4apUqSWzvnI9I7bqGnC
 hy5VpnXOeaMNxvc+eCyV5uof8vCiE4l2MiMAiT6jEE68v6YfQ2/rw5k81pcyW5n+2Ixo
 Ig2yWP02KcT1llul+N7yT7ebJ8lLeewXd6qacg5lez1DDYpEtq0bO6jKQ68PmrYf8vj7
 fnwFe3J2dPgT/zJDWXjaubo/izMTZBI8pLpWJvimVTNCqQOpCsSw2ZFepoQSmAEPpfJc
 D8Pw==
X-Gm-Message-State: AOJu0Yy2ceMo8ZkmLZxDeX5OK4Q/Z0UjqJ+w79roo91geEGk7NvVlnEw
 qkJoiStaAzmKo550T4uqrMZNz9QgR84/H4KjomlB5Nbk2ZU/1Tt4akJu0zuVD6XkvOwh3qBJ+aQ
 ck+Mw
X-Gm-Gg: AZuq6aJilHlfLHiHlCX8EoHlJ7sirYmc3dXI2ajmxObFHsUhj5Uvx/R4Uoo7R7MK8ld
 CFXzpYPJLTCE+iJWM3qzaeoJZHR4svqEfGRy1hC0e7lnc2MNmiCai7+51JnSwNP/cmTxMyE0RUm
 moOV6o1vgrDNRm8Pdikc6xdEThnaqG1HVljBeDW5rAVwuk6RvsNVw0MI41xhXwSxWcRHFqwneAS
 7HScnKt6wiujcoKxbx4W4l4ofd6hprCSitfbtzdxOMf0Y4KD3VZW2FCbs6JZEaEHyOBLMe3SnF6
 vCv4swFn0qtVk7a0QKidi9WOVXkT4wXDe8MXFbOkQIPD+0Aa8+LMql8fT31Vm/sKVPM9QnfmIQA
 qH8IynzIoGcutDj31+xrACHvVc8xWc7rg8atld3WzIB3mdcBsMWraA2+r3A1fQJVvUJIT4cV8V1
 HM03+EMsyuz/Ktx4+44FQQr8UXASUroUDTIz6PNybwkiGzwHZfMw==
X-Received: by 2002:a05:600c:6990:b0:47e:c562:a41f with SMTP id
 5b1f17b1804b1-4801e334361mr245061205e9.18.1769015146574; 
 Wed, 21 Jan 2026 09:05:46 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48042c1e381sm25653555e9.11.2026.01.21.09.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 09:05:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/4] examples: memcpy cleanups
Date: Wed, 21 Jan 2026 09:04:53 -0800
Message-ID: <20260121170540.785735-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Looking at examples and noticed stuff around use
of rte_memcpy. Probably mostly copy/pasted.

Stephen Hemminger (4):
  examples/vhost: replace memcpy with assignment
  examples/vmdq: replace memcpy with structure assignment
  examples/vmdq_dcb: replace memcpy with assignment
  examples: remove unnecessary include

 examples/bond/main.c                            |  1 -
 examples/ip_fragmentation/main.c                |  1 -
 examples/ip_reassembly/main.c                   |  1 -
 examples/ipv4_multicast/main.c                  |  1 -
 examples/l2fwd-cat/cat.c                        |  1 -
 examples/l2fwd-event/l2fwd_common.h             |  1 -
 examples/l2fwd-jobstats/main.c                  |  1 -
 examples/l2fwd-keepalive/main.c                 |  1 -
 examples/l2fwd-macsec/main.c                    |  1 -
 examples/l2fwd/main.c                           |  1 -
 examples/l3fwd-power/main.c                     |  1 -
 examples/l3fwd/main.c                           |  1 -
 examples/link_status_interrupt/main.c           |  1 -
 .../client_server_mp/mp_server/init.c           |  1 -
 .../client_server_mp/mp_server/main.c           |  1 -
 examples/multi_process/symmetric_mp/main.c      |  1 -
 examples/qos_sched/app_thread.c                 |  1 -
 examples/qos_sched/main.c                       |  1 -
 examples/server_node_efd/efd_server/init.c      |  1 -
 examples/server_node_efd/efd_server/main.c      |  1 -
 examples/vhost/main.c                           |  5 ++---
 examples/vmdq/main.c                            |  7 +++----
 examples/vmdq_dcb/main.c                        | 17 +++++++----------
 23 files changed, 12 insertions(+), 37 deletions(-)

-- 
2.51.0

