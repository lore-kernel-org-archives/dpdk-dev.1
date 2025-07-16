Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA29C83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 20:16:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A67EA40649;
	Wed, 16 Jul 2025 22:16:22 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 80BCB400D6
 for <dev@dpdk.org>; Wed, 16 Jul 2025 22:16:21 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-742c3d06de3so412907b3a.0
 for <dev@dpdk.org>; Wed, 16 Jul 2025 13:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752696981;
 x=1753301781; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lXzlB8fBw/sQqTFMdQMMgj8vLF9UxlRALhTaDQa9mQY=;
 b=sZN7OGXOOZBLRqdOOW6uUM9EOLekeQZvosjgyvDWO6xP5cyZNxuli1lJf8x/LJkAOk
 iOO6m2hcSIip8R337bUczHcU1RutmXptwzavE+MJiiqzPAm5K3TWLd587dqP7VbuQRyQ
 iayTXJqweKhS9tKdM99SXguCDNJXThaDhbfgqW1HaRaFifc6b6xaDDo8RILbqfwFnbm9
 +htYaB4weEiReCYVwNxFaTR1lFSJt0taQsa1xmuP0OQWlbPmEJ9QHY3xnKGzzosK2LM6
 T8iJaTiQjZn0AzEt9KavXKu/0EE2n6IAaBwxMYmdxL/jHZ7HxmEuFagx5i5CVKZMWJ+B
 Dmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752696981; x=1753301781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lXzlB8fBw/sQqTFMdQMMgj8vLF9UxlRALhTaDQa9mQY=;
 b=sKeLBwlChGQvCgTcqQmFER8YT5avVP9GlKt5vln1i92nfZZpC2a5+t5+D0/hxGmoWw
 iDdx+Ak7gLqARgIUpeaydzCzfbo7eoaiHLej4eSdicY+Q6H3ZRy9E/I31r4fqkoFS64S
 Q2vyK+PZE/H6W/nHLbvQAQPpu7mlDV/fPgqKrkyWtEbEiwdk9ghqNvnUDLi/+1BrO0Od
 w3KvktYkFitA+xLpmRBtQB0zNuvln9CgWP3kIDam0WasX//oh358zbAjLFVj6G6CalZq
 Am2JZnK1hXPMjMRMX61JYaZ712OUOTJrXA69tLwRH1Q61QujVvS8aQ4zBTiYhSbrzbKs
 UHIw==
X-Gm-Message-State: AOJu0Yz2YIlcBYBLkrUTuHgV/swzoQIjCNfvwgAkO3ZAbOirhCdYCFWV
 /N5eI2BOimjG36SbL7xjN4HYUY3IZ1+7tNvJ/Q+b0nauuFDrrbhCJEYatsCzwkcxqfw=
X-Gm-Gg: ASbGncuM1m2WlNtG2Nio8hB/VB8+Fqzy0ivUVzWAB4P5tC+rloQQabFP9Aec0EjknAY
 dxHuAlnFdA5Zfijhre2XCivBR5GTtEyjZwmhKuwOjtRGhuzW5xmmLmziDfleatmpoTDyzaqgJPF
 UGF/VkSKRexNiYvOAbKNqnVIC29snx/tVPniENiOLWuGpGYQUB/TvDL5cNLwBiMIBpgSaD7JdHw
 N8rBCtLE1TgVuJ7hAkKFr6CRJ5vn5Ezs5tJZOKS80bxoSTeqqcC/Ouok03RnPHjVRJJ9TFcoC8C
 VKTNlx2AUUrESg/dqaGfkyMwUl28JMU1BCtVZcKes2lzgUi8tCCrbGIzFW+46kHWY3ulwaL8SH6
 hXCzea8M/K4/U/Y/uKU4ddEdumEr+iH3e6soNjhiimZnm8hVFP/yf81dupY4xLT1u9snFt3OmY/
 7LS2dPihQFLA==
X-Google-Smtp-Source: AGHT+IE1m50CJIrqSEvtFx8/jvHswWZZgIryw7UqRs4HVBMbMZdBtEULH0Zlej6pQaFmcDSIfzV0wA==
X-Received: by 2002:a05:6a00:a8a:b0:748:e1e4:71d9 with SMTP id
 d2e1a72fcca58-75724e7a7f9mr4542355b3a.22.1752696980569; 
 Wed, 16 Jul 2025 13:16:20 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3bbe579b0esm14231805a12.22.2025.07.16.13.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 13:16:20 -0700 (PDT)
Date: Wed, 16 Jul 2025 10:44:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 13/14] net/sxe: add virtual function
Message-ID: <20250716104436.592e3d18@hermes.local>
In-Reply-To: <20250716082930.83026-13-liujie5@linkdatatechnology.com>
References: <20250715034152.7020-14-liujie5@linkdatatechnology.com>
 <20250716082930.83026-1-liujie5@linkdatatechnology.com>
 <20250716082930.83026-13-liujie5@linkdatatechnology.com>
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

On Wed, 16 Jul 2025 04:29:29 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> Add virtual function.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---
>  drivers/net/sxe/base/sxe_queue_common.c |    4 +
>  drivers/net/sxe/base/sxevf_hw.c         |  951 +++++++++++++++
>  drivers/net/sxe/base/sxevf_hw.h         |  349 ++++++
>  drivers/net/sxe/base/sxevf_regs.h       |  119 ++
>  drivers/net/sxe/meson.build             |   37 +-
>  drivers/net/sxe/pf/rte_pmd_sxe.h        |    4 +-
>  drivers/net/sxe/pf/sxe.h                |    5 +-
>  drivers/net/sxe/pf/sxe_filter.c         |  177 +++
>  drivers/net/sxe/pf/sxe_filter.h         |   15 +
>  drivers/net/sxe/pf/sxe_main.c           |    2 +
>  drivers/net/sxe/pf/sxe_phy.h            |    1 +
>  drivers/net/sxe/pf/sxe_stats.c          |    9 +-
>  drivers/net/sxe/pf/sxe_vf.c             | 1427 +++++++++++++++++++++++
>  drivers/net/sxe/pf/sxe_vf.h             |  219 ++++
>  drivers/net/sxe/sxe_testpmd.c           |  130 +++
>  drivers/net/sxe/vf/sxevf.h              |   43 +
>  drivers/net/sxe/vf/sxevf_ethdev.c       |  768 ++++++++++++
>  drivers/net/sxe/vf/sxevf_ethdev.h       |   16 +
>  drivers/net/sxe/vf/sxevf_filter.c       |  493 ++++++++
>  drivers/net/sxe/vf/sxevf_filter.h       |   70 ++
>  drivers/net/sxe/vf/sxevf_irq.c          |  434 +++++++
>  drivers/net/sxe/vf/sxevf_irq.h          |   35 +
>  drivers/net/sxe/vf/sxevf_main.c         |   83 ++
>  drivers/net/sxe/vf/sxevf_msg.c          |  624 ++++++++++
>  drivers/net/sxe/vf/sxevf_msg.h          |  201 ++++
>  drivers/net/sxe/vf/sxevf_offload.c      |   31 +
>  drivers/net/sxe/vf/sxevf_offload.h      |   16 +
>  drivers/net/sxe/vf/sxevf_queue.c        |  210 ++++
>  drivers/net/sxe/vf/sxevf_queue.h        |   70 ++
>  drivers/net/sxe/vf/sxevf_rx.c           |  163 +++
>  drivers/net/sxe/vf/sxevf_rx.h           |   18 +
>  drivers/net/sxe/vf/sxevf_stats.c        |  162 +++
>  drivers/net/sxe/vf/sxevf_stats.h        |   31 +
>  drivers/net/sxe/vf/sxevf_tx.c           |   46 +
>  drivers/net/sxe/vf/sxevf_tx.h           |   14 +
>  35 files changed, 6958 insertions(+), 19 deletions(-)
>  create mode 100644 drivers/net/sxe/base/sxevf_hw.c
>  create mode 100644 drivers/net/sxe/base/sxevf_hw.h
>  create mode 100644 drivers/net/sxe/base/sxevf_regs.h
>  create mode 100644 drivers/net/sxe/pf/sxe_vf.c
>  create mode 100644 drivers/net/sxe/pf/sxe_vf.h
>  create mode 100644 drivers/net/sxe/vf/sxevf.h
>  create mode 100644 drivers/net/sxe/vf/sxevf_ethdev.c
>  create mode 100644 drivers/net/sxe/vf/sxevf_ethdev.h
>  create mode 100644 drivers/net/sxe/vf/sxevf_filter.c
>  create mode 100644 drivers/net/sxe/vf/sxevf_filter.h
>  create mode 100644 drivers/net/sxe/vf/sxevf_irq.c
>  create mode 100644 drivers/net/sxe/vf/sxevf_irq.h
>  create mode 100644 drivers/net/sxe/vf/sxevf_main.c
>  create mode 100644 drivers/net/sxe/vf/sxevf_msg.c
>  create mode 100644 drivers/net/sxe/vf/sxevf_msg.h
>  create mode 100644 drivers/net/sxe/vf/sxevf_offload.c
>  create mode 100644 drivers/net/sxe/vf/sxevf_offload.h
>  create mode 100644 drivers/net/sxe/vf/sxevf_queue.c
>  create mode 100644 drivers/net/sxe/vf/sxevf_queue.h
>  create mode 100644 drivers/net/sxe/vf/sxevf_rx.c
>  create mode 100644 drivers/net/sxe/vf/sxevf_rx.h
>  create mode 100644 drivers/net/sxe/vf/sxevf_stats.c
>  create mode 100644 drivers/net/sxe/vf/sxevf_stats.h
>  create mode 100644 drivers/net/sxe/vf/sxevf_tx.c
>  create mode 100644 drivers/net/sxe/vf/sxevf_tx.h

Git complains when doing test merge

Applying: net/sxe: add virtual function
/home/shemminger/DPDK/main/.git/worktrees/sxe/rebase-apply/patch:3778: new blank line at EOF.
+


