Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7702C83F04
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 14:55:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9DFF402A0;
	Wed,  2 Jul 2025 16:55:44 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 34BD340285
 for <dev@dpdk.org>; Wed,  2 Jul 2025 16:55:43 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-6fabe9446a0so62647626d6.2
 for <dev@dpdk.org>; Wed, 02 Jul 2025 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751468142;
 x=1752072942; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VnaUJGODfHkk2LsMSPOTDvJLCTGMPf4pr4tYEUt/1LE=;
 b=Ao5nxbUBAE3xSuvpZTfnbKI4zLPEUmNit1G2igZ3Fm/Yo6FFIw2rq/eDAN1sZTV05o
 RQIEVDfLS+DNpwNqO5hBsJNct3gXGd4lTWjlBnfxlgXZt7DCMQuH08W3YsV6x/tDeJ54
 OCENjSwVaWgMOHGXA5zBMzoUycqQRStBmRybJjc+qLZJZ8b0o1YUyfd7xZ1nKpOcvgb9
 p3x0szJIfNs8r0QApSd4LD7by3o7SxQ9GawumvtGLSxu4mGVvoSPLyM7fiihYtpyFEx2
 qvIuyoFOEiyvGtremzNQ8QYULXBq5oW9o9n1o5FDwYXLIPFNGJYQyWrNd+ZXjzOjMt9h
 xiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751468142; x=1752072942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VnaUJGODfHkk2LsMSPOTDvJLCTGMPf4pr4tYEUt/1LE=;
 b=F1WUEayJpwESnRumuu/W3i/ZrbwyYU7UeGO7g8bj8Vo/EmyNpyxv0/8dgdgiYDaKVb
 DGXqhj+I7nQgSPIq3Itk2DUOWmEqqu3iYBbxIuabUyLoSEz2Ctc92N8S/IZXFJcWj2wS
 5UjhTQFbefl1QyyJFry8pqPe5TiaWBqDv4S27PGqxRgWXLv+YkQRsTdkjY0bC9gMxADO
 S05HzZsvyV7hMbOubsp1S7Ui6yJMqdnv/e5K3TZQGxgY0+tG6HUbEd+Bgg9bL0mBBLB5
 p+GRhyDa/V2SqaPzRCS+8JyNw0wTlX2zsfrpiOObIyhx6DCrx9vqbNq8GegpIFxX/1VP
 HwuA==
X-Gm-Message-State: AOJu0YzAnR6EMo/oafpwIQId3/AuinF1JRXeONhVF9tIj4OvQQ3wq4F3
 4SrPKdqWbvhir0wOdY34klwFsLaxjXUcSYvYoxG/Dyk2vjMGQcHOVXMkly3Ugc5wSM98YMHqktk
 mT2dw
X-Gm-Gg: ASbGncvK37GewWYOtOISfyviK3nhMJwc/V6FebIdi9FqaUGVhhWVrdOjawxhSdN/FTK
 aPXZX9RSZ0KuyDidUBppefXPbioRlkdbvAxmwDG706uGgfCP8pRYnvxxHtvy6V0uUS7ogKvU8BI
 DhL2297mUifmCwq+tGyALI11UFwN2EMDLmXLSsZj60gTIsHAlXexu3tEPWWLYIbO+jSon++l0O7
 jLRLbZsDTf5OrmzGdXmhCjBZ9GdYCxNk4l+In9zkviaEPtb1tVLXXGZnPpkM2+rqXa9sRCLdOOu
 Pf4Lv9KVSN+QVhXNvapVadLWk3xGLdfzku6Tuw7D6+BOKl0OBbdvs+NzZBYvNBpuIfaFXz0YQq4
 o63zYmkXErD09abuv4ZsPcy27OSEQWwNs/JwRY/k=
X-Google-Smtp-Source: AGHT+IEo79pkqw9CYOdUDJatBKMobZb47RkzJ9LPjLJAIyyO2oLxdal+A7JlRsgy3ovt1V7TmdyrmQ==
X-Received: by 2002:a05:6214:260b:b0:6fd:5dc9:6029 with SMTP id
 6a1803df08f44-702b1b9d739mr40380876d6.43.1751468142071; 
 Wed, 02 Jul 2025 07:55:42 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd772fa9c9sm101235336d6.82.2025.07.02.07.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 07:55:41 -0700 (PDT)
Date: Wed, 2 Jul 2025 07:55:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Yi Chen <chenyi221@huawei.com>
Subject: Re: [V5 00/18] add hinic3 pmd driver
Message-ID: <20250702075537.4c497901@hermes.local>
In-Reply-To: <20250702020953.599-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250702020953.599-1-wff_light@vip.163.com>
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

On Wed,  2 Jul 2025 10:09:23 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> From: Yi Chen <chenyi221@huawei.com>
> 
> The hinic3 PMD (**librte_net_hinic3**) provides poll mode driver support
> for 25Gbps/100Gbps/200Gbps Huawei SPx series Network Adapters.
> 
> v5:
> - solve hinic3.ini unknown feature issue
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
>  doc/guides/nics/features/hinic3.ini        |   61 +
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
>  57 files changed, 25926 insertions(+), 1 deletion(-)
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

Given the release roadmap, any new drivers need to be for 25.11 release now.
Marked as deferred for review after this release.
