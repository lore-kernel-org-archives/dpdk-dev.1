Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAF9C5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 02:52:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBDBB4065A;
	Wed,  4 Jun 2025 04:52:58 +0200 (CEST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id 65211402DC
 for <dev@dpdk.org>; Wed,  4 Jun 2025 04:52:57 +0200 (CEST)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-6fad4a1dc33so47632386d6.1
 for <dev@dpdk.org>; Tue, 03 Jun 2025 19:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749005576;
 x=1749610376; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QogKJkFVFamcvNRAl0svMuzVoFxVnqoaJ0H/GkEQcuI=;
 b=XKG0UNsxP5UVQYXTWeGiZRzxqEGpn5f5elCGQ5VzDZhK6FTLOpKYuYgOLC8TUbMzvs
 8DMiCdb2ezDpB6NLwhpSWUVMlMtQJ2vJyMtc3kwscMrsDCcm3Zvskj4ejpWUK1y+grwz
 iJ638J2Vtq54VyZGdRfCjzpW6CFC/0vNiZ4TrDepB26mOhFPPizCTa0oyaCyzEao0T4I
 lLmETYZykXPXCj2a5fs1NwjnFhwgBXL4qrpZRWZkCjwROP0JwcTEit4PvB3MQQpqYZpa
 zvY+G4kDBPKn/HoDyOIPomK07+dXQDr7GWBS9DAWG//CW7sXUPSheLovk1C3+lcdbqRt
 GV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749005576; x=1749610376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QogKJkFVFamcvNRAl0svMuzVoFxVnqoaJ0H/GkEQcuI=;
 b=lIBubSqISSWBpM/t0UcyRPIQo6KXoKivNACNPzi+lw9fd0pJ71AHDrgM/ZWL/IibrL
 b3rxm5dhouB93tdB3HomDSD+nDdaPH76uijmaz9nOyzvSd9p0tYJ6Y//MqthjjT1FMm4
 RnDl3AC1T9jFe0Vb49V0eL6pnChSyMsyflF29iG0lAKzv+zGqzvUIgIrUH82BjI1gyr9
 CaVl6hm7VYBGOuiEBohmEhM3todMOC9JILs9U/rjeHmamRumkIdxFGoWR1fCj3sh2Wtu
 VqUDyilc190PhaonPS3adxuvQjWxhwqE9mRAw202RF8DOqv4tPpucXvaIFoF1Ab/UFNL
 hziw==
X-Gm-Message-State: AOJu0YxIzM4rOxGaMiDA3GlWyXg77aZayXJqdt6C0dUs5+kjZNkSHB9J
 eiZf4I0AYdQ5snYyGC9qiwLyBrmTjjNiuAv8Jh/04NEfkMmlM3YmpX4bSy1ggAg9Iwo=
X-Gm-Gg: ASbGncuRykVXU0liUulPtTRi10qWW1HTQkSN35MihTCEtKkS5D+0O2bjux5Hqzz6qHJ
 ClxUr657PDsZZ1nBMMuGL51nwzvqWIv0cAJ0NTyOD9NiGKoMSCSXj8aJhk9nxrDd1SJ3jPWb4OT
 RjftoVlNyCpaGMnP03692FDuXcSevqQD3Zkzcsfh2nNgAoTPS2wK2QaO09pBcMMMmcSfvBfcX2V
 JS2EyXCzKpKebHZYkbGgg5voNeX9nvgjdzFdM9zbQAVacqjjfY3lsTWYqBQ4dbSFqfwhpwu4yvw
 VooV8Os3zA8xEFisI/FOky+sRLrzYKBTerEzJrE2TY8G+Zi3lC79n9KLlf2111EbaBX1TeVkLq0
 6DgrTDsQUVtP0qk5iUESo37qHq+L+5gaaak425sg=
X-Google-Smtp-Source: AGHT+IGAl9MjsEDxsvJf7vRh6FqdCt8bsKf5Rm4I81LyQKebihMqF4ELvDi7YjVKtTqm5tRH/BXz3w==
X-Received: by 2002:ad4:5c88:0:b0:6fa:d976:197e with SMTP id
 6a1803df08f44-6faf7008d15mr17447556d6.33.1749005576621; 
 Tue, 03 Jun 2025 19:52:56 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fac6e1cc72sm91669806d6.116.2025.06.03.19.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 19:52:56 -0700 (PDT)
Date: Tue, 3 Jun 2025 19:52:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org
Subject: Re: [RFC 00/18] add hinic3 PMD driver
Message-ID: <20250603195254.63a2a054@hermes.local>
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


Need to fix the build failures, then will review it more.
