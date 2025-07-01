Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0401C83038
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 13:54:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4A2F40658;
	Tue,  1 Jul 2025 15:54:04 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0787A402A5
 for <dev@dpdk.org>; Tue,  1 Jul 2025 15:54:02 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-748da522e79so2042213b3a.1
 for <dev@dpdk.org>; Tue, 01 Jul 2025 06:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751378042;
 x=1751982842; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s/vjggI28BTahj4CPZe7mDDVQ6jK6gVbVyubIDsin48=;
 b=k6Hbsmt0wjupUujS0UuP3vB5QkNrow0TYugeWE2CrUKFu/pnOTnA/iFs2sjUJMg9eZ
 /LJlEBXGNbJXhAgRqEpk3nOtRxx+4oDXNWFZWqHWirFI4Ty9grUe1KOT36PU44Rm95qS
 ITRmS+2v74MOIrKx1S72ZmfqDkyKBYyBLJPiIDunvxsxzQ2KyY1SaIj+/j3vTbHKkwMR
 A40OwzPZ4o2nk29cRUgH3OWSfIP9ee5SRVnQFooLYP0LNvUEgbn/ncQv5yzLF678ocOv
 VZxShpBQPrzZBljgETrVfaewAsfd8Hlcm08iundDePqOdZbHiXtLnGGn5omZiQGYkNqn
 3IrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751378042; x=1751982842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s/vjggI28BTahj4CPZe7mDDVQ6jK6gVbVyubIDsin48=;
 b=GB5yiaGXu7wEaVG5i/K6WghzDTydKC/46Flu5hgPvcD975RFcAl2R6SJ8z0CYDI4qL
 YygtI9XrY+zaFhncsbr/7pWHQQTGYMlf0Os4cDO0SKYsOaAQrLer78B6pHYXGUiYEwJB
 rjGn7/VYhZyOpFg+cXYJ5du0XTY2cqpk+kWswpfiyHzVQHyeHlnfVsVlzkH2RXBVwW4A
 oPOGpkCx9rkeGD0IRN4Avg9o8QYfzEQlC27HRThMPPyQP5OsvOabopxu7sJkAgZcvcAP
 hmx3AqlwIS9L3GGQqdx65d/e3AD1Zmi21eJohvQtbKW7c+YyahbwKi/hzoGuNVFigypB
 wJ+A==
X-Gm-Message-State: AOJu0YxNub2zE1FJvZZdnypHDFL+4MN59g4kqATU2BOfyBwTULyFo19m
 CLI/hCW4+CwLL+vyY+mDkpRa28KX9gFHIk8nEVLOZWwoiI3Ahygqx/0hwlnGdDBfQtA=
X-Gm-Gg: ASbGncvffhlGR2L+D6PIhW4DQ5xNRWSHtAU3dsuMf/MUT1fVc9YphCsu5sq7ffPKcUr
 6it5qFi9C2IvJy8LPEvFSnYuIHpzQk3PQRc6eUqRfQbbJxILKee37fyJVOSVLs1BiqowZv8NACA
 qYHtAQaJ1K9VwHy5lF/HPzVC1HDJh4HTz+jj2KbqkCNlv6ZQJLFNqhN3C0CdzATnGmDVKEa04hI
 q+SC4dbzCsvoVuwJsOqHMI+oKhBvtrr11dTsDSsEHDmPUVVItQHpU7VnVYkUfu7lw5aIjXiuYBO
 DoyXQynBfEg1ZPQApEsTY/si2ElwFYBTI+NYp/IhYJBVtJOIo99cZA0QpeF07jmuU1Kqu3Yc9lA
 st298QZGbQ5DWtX2N151Z7fMmNL1DpbipNOp5H/0=
X-Google-Smtp-Source: AGHT+IEx/Utu1UpyHv052z5iy7hrCUeiKQjD8YQWcjepuCVY2JaB+i6LH11QXg+SaeG3mmdlWWlhPA==
X-Received: by 2002:a05:6a20:2594:b0:217:4f95:6a51 with SMTP id
 adf61e73a8af0-220a16e44bdmr28746871637.29.1751378041994; 
 Tue, 01 Jul 2025 06:54:01 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af541d2bfsm12208755b3a.60.2025.07.01.06.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 06:54:01 -0700 (PDT)
Date: Tue, 1 Jul 2025 06:53:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Yi Chen <chenyi221@huawei.com>
Subject: Re: [V4 00/18] add hinic3 pmd driver
Message-ID: <20250701065359.015226f2@hermes.local>
In-Reply-To: <20250701014223.2440-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250701014223.2440-1-wff_light@vip.163.com>
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

On Tue,  1 Jul 2025 09:41:51 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> From: Yi Chen <chenyi221@huawei.com>
> 
> The hinic3 PMD (**librte_net_hinic3**) provides poll mode driver support
> for 25Gbps/100Gbps/200Gbps Huawei SPx series Network Adapters.
> 
> V4:
> - solve patch application conflict issue
> 
> V3:
> - Fix checkpatchs error issue
> 
> v2:
> - modify CI compile errors
> 
> V1:
> - modify community comments and compile issues
> - remove the compilation flags in the meson build
> - remove (void) cast
> - remove "BLURE HERE ***" in cover letter
> 
> RFC:
> - add hinic3 pmd driver code, modify the driver code to adapt to Huawei SPx series network cards.
> 
> Feifei Wang (2):
>   net/hinic3: add dev ops
>   net/hinic3: add Rx/Tx functions
> 
> Xin Wang (7):
>   net/hinic3: add basic header files
>   net/hinic3: add support for cmdq mechanism
>   net/hinic3: add NIC event module
>   net/hinic3: add context and work queue support
>   net/hinic3: add device initialization
>   net/hinic3: add MML and EEPROM access feature
>   net/hinic3: add RSS promiscuous ops
> 
> Yi Chen (9):
>   add some basic files to describe the hinic3 driver.
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
>  doc/guides/nics/features/hinic3.ini        |   62 +
>  doc/guides/nics/hinic3.rst                 |   51 +
>  doc/guides/nics/index.rst                  |    1 +
>  doc/guides/rel_notes/release_25_07.rst     |    4 +
>  drivers/net/hinic3/base/hinic3_cmd.h       |  231 ++
>  drivers/net/hinic3/base/hinic3_cmdq.c      |  978 +++++
>  drivers/net/hinic3/base/hinic3_cmdq.h      |  230 ++
>  drivers/net/hinic3/base/hinic3_compat.h    |  266 ++
>  drivers/net/hinic3/base/hinic3_csr.h       |  108 +
>  drivers/net/hinic3/base/hinic3_eqs.c       |  721 ++++
>  drivers/net/hinic3/base/hinic3_eqs.h       |   98 +
>  drivers/net/hinic3/base/hinic3_hw_cfg.c    |  240 ++
>  drivers/net/hinic3/base/hinic3_hw_cfg.h    |  121 +
>  drivers/net/hinic3/base/hinic3_hw_comm.c   |  452 +++
>  drivers/net/hinic3/base/hinic3_hw_comm.h   |  366 ++
>  drivers/net/hinic3/base/hinic3_hwdev.c     |  573 +++
>  drivers/net/hinic3/base/hinic3_hwdev.h     |  177 +
>  drivers/net/hinic3/base/hinic3_hwif.c      |  779 ++++
>  drivers/net/hinic3/base/hinic3_hwif.h      |  142 +
>  drivers/net/hinic3/base/hinic3_mbox.c      | 1399 +++++++
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
>  drivers/net/hinic3/hinic3_flow.h           |   42 +
>  drivers/net/hinic3/hinic3_nic_io.c         |  828 +++++
>  drivers/net/hinic3/hinic3_nic_io.h         |  169 +
>  drivers/net/hinic3/hinic3_rx.c             | 1099 ++++++
>  drivers/net/hinic3/hinic3_rx.h             |  356 ++
>  drivers/net/hinic3/hinic3_tx.c             | 1028 ++++++
>  drivers/net/hinic3/hinic3_tx.h             |  315 ++
>  drivers/net/hinic3/meson.build             |   33 +
>  drivers/net/hinic3/mml/hinic3_dbg.c        |  171 +
>  drivers/net/hinic3/mml/hinic3_dbg.h        |  160 +
>  drivers/net/hinic3/mml/hinic3_mml_cmd.c    |  375 ++
>  drivers/net/hinic3/mml/hinic3_mml_cmd.h    |  131 +
>  drivers/net/hinic3/mml/hinic3_mml_ioctl.c  |  215 ++
>  drivers/net/hinic3/mml/hinic3_mml_lib.c    |  136 +
>  drivers/net/hinic3/mml/hinic3_mml_lib.h    |  276 ++
>  drivers/net/hinic3/mml/hinic3_mml_main.c   |  167 +
>  drivers/net/hinic3/mml/hinic3_mml_queue.c  |  745 ++++
>  drivers/net/hinic3/mml/hinic3_mml_queue.h  |  256 ++
>  drivers/net/hinic3/mml/meson.build         |   45 +
>  drivers/net/meson.build                    |    1 +
>  57 files changed, 25927 insertions(+), 1 deletion(-)
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

Looks good, but too close to 25.07 release date for this release.
Review deferred to the start of 25.11 cycle.
