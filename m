Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F7BC369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 18:32:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6045D402E2;
	Fri, 18 Apr 2025 20:32:41 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id CA627402D3
 for <dev@dpdk.org>; Fri, 18 Apr 2025 20:32:39 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-73bf5aa95e7so2117670b3a.1
 for <dev@dpdk.org>; Fri, 18 Apr 2025 11:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745001159;
 x=1745605959; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y878S6c1Ge6PGUtxrXTELuffgXHmgyKONDQn9kLCW+4=;
 b=CylPig5vReBDTGf30BuwM5YsCKKOynFVK8emGKodL7dYMmIBKiQYILYwBbzUUterjv
 /RbcXsJev8mymm35gZCCRgRCJMvsGiNeZ30wKl0YScoJ1igPKt3X0GYsYrrl0Xreg/1D
 LEp3V8GkFBcNgk555DovUNuxp//I3MJTTzD3u4QhaWAmJS5NfqvY5kSeBinj1tQzC04/
 TB13ZAF574hOcXswmNG+DUWCc7gVlH84Fw23+MVhAF1iI54vChaC0qt0cAaoqD588KFl
 EIpghu8cN001/RFBMfGdQALigW3Iaqq/U3u4+1nTetFi6DmeBeBIk+MzFYkjCdLI0+2a
 FPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745001159; x=1745605959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y878S6c1Ge6PGUtxrXTELuffgXHmgyKONDQn9kLCW+4=;
 b=oKP+e1vqAetceJnE5AaG6XWnoR9uc1ia4QCNgK1v0yOEis6mjZ1i9JwMtVJK0IBazt
 7YWe9+RRoo94yS1xKy+gLn4/E0a7LoZAazxSzgTKlnSOQSd82ODMm7wEGThku1EhElwl
 +LOrYsF1IhpRZEmcLAHHKlKZKTB4NYiA6A+MIGjF9VYvEDtuT28uEMpKcqfP/BzXtQlW
 Md6Yy3HnQncfjsGUrIhSN7gz3Mki+AuBgUcZNF8cItJhYwddfFpfJb9LjeqV6ZHyNkBw
 X76WTQWXy7GGKI4mLePvr4r7+Z6wr10y0l7hZDaEiErNQKm0w5Whq3KlLyqrLMkxGgd+
 iEfQ==
X-Gm-Message-State: AOJu0YxQjPbKPXr3X/EOxWwjfw+bc2ay7KKMEjIkq1u1IzuIFhpHUmAs
 W4FeE4R5vrOBVXxroGr9Rv5tAjujbty+28GepZGyG5PQ5phTx39RNhp/kEq/bxA=
X-Gm-Gg: ASbGncv0muAvmYH2ztLkAjup5OtzVsKciCqvVIsOvk+sQW9bHaQeas6XNrr0Q8LrKpO
 n5yg1Wmwhtu6xu5vojufxVJ/+BlT5UQf4SkSZiTIX5EFX4Eqrn4j7mGXYrHlPGpe7TLIcFY9gQ5
 5gBBrXIwwTMwkcVMU52agCkoC1EodnTX+dgbMbrp7HXJormEH3J0KSXFaQ6nAntpStzVSS6arB1
 fNAkdLag5PTQMMNsJRn0TcFRzPCq4oR+avDhO/UecpqYPpRFLz9be+UFgd6RQFI5fVvq8U5zSY/
 uTlzfL2GkTVzYpHt0RxLxTCav3hk8ANOIv8UD25lze0j8FxF9itcd/sz7VeLJh2d7QOp7S2UfqZ
 jKGHjBm8GC9NR7vLZ
X-Google-Smtp-Source: AGHT+IFXgzVFxwGhyF7Bqi8DWiB8WYjvA5UEzgoT6lB+hZ8Y+YDP8WfArxaXrQFUg+R0hz8gDpNQHg==
X-Received: by 2002:a05:6a21:2d07:b0:1f5:77ed:40b9 with SMTP id
 adf61e73a8af0-203cbd488b0mr6522337637.40.1745001158863; 
 Fri, 18 Apr 2025 11:32:38 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db13cb3b5sm1676440a12.38.2025.04.18.11.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 11:32:38 -0700 (PDT)
Date: Fri, 18 Apr 2025 11:32:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org
Subject: Re: [RFC 00/18] add hinic3 PMD driver
Message-ID: <20250418113217.43dcd6f1@hermes.local>
In-Reply-To: <20250418090621.9638-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
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

On Fri, 18 Apr 2025 17:05:46 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> *** BLURB HERE ***
> The hinic3 PMD (**librte_net_hinic3**) provides poll mode driver support
> for 25Gbps/100Gbps/200Gbps Huawei SPx series Network Adapters.
> 
> Feifei Wang (3):
>   net/hinic3: add intro doc for hinic3
>   net/hinic3: add dev ops
>   net/hinic3: add Rx/Tx functions
> 
> Xin Wang (7):
>   net/hinic3: add basic header files
>   net/hinic3: add support for cmdq mechanism
>   net/hinic3: add NIC event module
>   net/hinic3: add context and work queue support
>   net/hinic3: add device initailization
>   net/hinic3: add MML and EEPROM access feature
>   net/hinic3: add RSS promiscuous ops
> 
> Yi Chen (8):
>   net/hinic3: add hardware interfaces of BAR operation
>   net/hinic3: add eq mechanism function code
>   net/hinic3: add mgmt module function code
>   net/hinic3: add module about hardware operation
>   net/hinic3: add a NIC business configuration module
>   net/hinic3: add a mailbox communication module
>   net/hinic3: add FDIR flow control module
>   drivers/net: add hinic3 PMD build and doc files
> 
>  .mailmap                                   |    4 +-
>  MAINTAINERS                                |    6 +
>  doc/guides/nics/features/hinic3.ini        |    9 +
>  doc/guides/nics/hinic3.rst                 |   52 +
>  doc/guides/nics/index.rst                  |    1 +
>  doc/guides/rel_notes/release_25_07.rst     |   32 +-
>  drivers/net/hinic3/base/hinic3_cmd.h       |  231 ++
>  drivers/net/hinic3/base/hinic3_cmdq.c      |  975 +++++
>  drivers/net/hinic3/base/hinic3_cmdq.h      |  230 ++
>  drivers/net/hinic3/base/hinic3_compat.h    |  266 ++
>  drivers/net/hinic3/base/hinic3_csr.h       |  108 +
>  drivers/net/hinic3/base/hinic3_eqs.c       |  719 ++++
>  drivers/net/hinic3/base/hinic3_eqs.h       |   98 +
>  drivers/net/hinic3/base/hinic3_hw_cfg.c    |  240 ++
>  drivers/net/hinic3/base/hinic3_hw_cfg.h    |  121 +
>  drivers/net/hinic3/base/hinic3_hw_comm.c   |  452 +++
>  drivers/net/hinic3/base/hinic3_hw_comm.h   |  366 ++
>  drivers/net/hinic3/base/hinic3_hwdev.c     |  573 +++
>  drivers/net/hinic3/base/hinic3_hwdev.h     |  177 +
>  drivers/net/hinic3/base/hinic3_hwif.c      |  779 ++++
>  drivers/net/hinic3/base/hinic3_hwif.h      |  142 +
>  drivers/net/hinic3/base/hinic3_mbox.c      | 1392 +++++++
>  drivers/net/hinic3/base/hinic3_mbox.h      |  199 +
>  drivers/net/hinic3/base/hinic3_mgmt.c      |  392 ++
>  drivers/net/hinic3/base/hinic3_mgmt.h      |  121 +
>  drivers/net/hinic3/base/hinic3_nic_cfg.c   | 1828 +++++++++
>  drivers/net/hinic3/base/hinic3_nic_cfg.h   | 1527 ++++++++
>  drivers/net/hinic3/base/hinic3_nic_event.c |  433 +++
>  drivers/net/hinic3/base/hinic3_nic_event.h |   39 +
>  drivers/net/hinic3/base/hinic3_wq.c        |  148 +
>  drivers/net/hinic3/base/hinic3_wq.h        |  109 +
>  drivers/net/hinic3/base/meson.build        |   50 +
>  drivers/net/hinic3/hinic3_ethdev.c         | 3866 ++++++++++++++++++++
>  drivers/net/hinic3/hinic3_ethdev.h         |  167 +
>  drivers/net/hinic3/hinic3_fdir.c           | 1394 +++++++
>  drivers/net/hinic3/hinic3_fdir.h           |  398 ++
>  drivers/net/hinic3/hinic3_flow.c           | 1700 +++++++++
>  drivers/net/hinic3/hinic3_flow.h           |   80 +
>  drivers/net/hinic3/hinic3_nic_io.c         |  827 +++++
>  drivers/net/hinic3/hinic3_nic_io.h         |  169 +
>  drivers/net/hinic3/hinic3_rx.c             | 1096 ++++++
>  drivers/net/hinic3/hinic3_rx.h             |  356 ++
>  drivers/net/hinic3/hinic3_tx.c             | 1028 ++++++
>  drivers/net/hinic3/hinic3_tx.h             |  315 ++
>  drivers/net/hinic3/meson.build             |   44 +
>  drivers/net/hinic3/mml/hinic3_dbg.c        |  171 +
>  drivers/net/hinic3/mml/hinic3_dbg.h        |  160 +
>  drivers/net/hinic3/mml/hinic3_mml_cmd.c    |  375 ++
>  drivers/net/hinic3/mml/hinic3_mml_cmd.h    |  131 +
>  drivers/net/hinic3/mml/hinic3_mml_ioctl.c  |  215 ++
>  drivers/net/hinic3/mml/hinic3_mml_lib.c    |  136 +
>  drivers/net/hinic3/mml/hinic3_mml_lib.h    |  275 ++
>  drivers/net/hinic3/mml/hinic3_mml_main.c   |  167 +
>  drivers/net/hinic3/mml/hinic3_mml_queue.c  |  749 ++++
>  drivers/net/hinic3/mml/hinic3_mml_queue.h  |  256 ++
>  drivers/net/hinic3/mml/meson.build         |   62 +
>  drivers/net/meson.build                    |    1 +
>  57 files changed, 25926 insertions(+), 31 deletions(-)
>  create mode 100644 doc/guides/nics/features/hinic3.ini
>  create mode 100644 doc/guides/nics/hinic3.rst
>  create mode 100644 drivers/net/hinic3/base/hinic3_cmd.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_cmdq.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_cmdq.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_compat.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_csr.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_eqs.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_eqs.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_hw_cfg.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_hw_cfg.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_hw_comm.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_hw_comm.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_hwdev.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_hwdev.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_hwif.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_hwif.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_mbox.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_mbox.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_mgmt.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_mgmt.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_nic_cfg.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_nic_cfg.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_nic_event.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_nic_event.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_wq.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_wq.h
>  create mode 100644 drivers/net/hinic3/base/meson.build
>  create mode 100644 drivers/net/hinic3/hinic3_ethdev.c
>  create mode 100644 drivers/net/hinic3/hinic3_ethdev.h
>  create mode 100644 drivers/net/hinic3/hinic3_fdir.c
>  create mode 100644 drivers/net/hinic3/hinic3_fdir.h
>  create mode 100644 drivers/net/hinic3/hinic3_flow.c
>  create mode 100644 drivers/net/hinic3/hinic3_flow.h
>  create mode 100644 drivers/net/hinic3/hinic3_nic_io.c
>  create mode 100644 drivers/net/hinic3/hinic3_nic_io.h
>  create mode 100644 drivers/net/hinic3/hinic3_rx.c
>  create mode 100644 drivers/net/hinic3/hinic3_rx.h
>  create mode 100644 drivers/net/hinic3/hinic3_tx.c
>  create mode 100644 drivers/net/hinic3/hinic3_tx.h
>  create mode 100644 drivers/net/hinic3/meson.build
>  create mode 100644 drivers/net/hinic3/mml/hinic3_dbg.c
>  create mode 100644 drivers/net/hinic3/mml/hinic3_dbg.h
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_cmd.c
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_cmd.h
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_ioctl.c
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_lib.c
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_lib.h
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_main.c
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_queue.c
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_queue.h
>  create mode 100644 drivers/net/hinic3/mml/meson.build
> 


Fix the build an other little things, and resubmit.
There is lots more here, don't expect it to be merged for several more revisions.
