Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9315CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 15:58:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B215140615;
	Tue, 23 Sep 2025 17:58:02 +0200 (CEST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id 1A065402CB
 for <dev@dpdk.org>; Tue, 23 Sep 2025 17:58:00 +0200 (CEST)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-7960d69f14bso31443186d6.2
 for <dev@dpdk.org>; Tue, 23 Sep 2025 08:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758643080;
 x=1759247880; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G0uAeiGw/ShN+6tgvtWm7gJwkNslHmQBFVJq6JyXeZI=;
 b=HqhEm+cTnioaAlZJCn4cQZOxoBZ3TP0huJp2JQu5BR9NmrqNsn6mzyxo4zrNl79sM9
 Zw3no0AX3GwYE5QcgzbuW+EBhcvs7rrjP/prLDUS8/7rwFm3U2AHjCCHr95ZEShb2h0J
 LQyHRBF4e7MMT0T2YewZEcu4YzMjQi3QX3IrAonnCzcAeKj1A18ZzWLUGGUzPvm4EGV5
 Z5hYdLJXF+0QQEzgEqzTgTdmVa1l8dROw6qCZwchlOLt980o7y0f2zvwhutl1d8GFAEL
 IefsaohgcRKbbK1ps/q3yDQBksN1ZRlCqVA01uIZC55Ww6QUJQjrCve5kDvd8KR6VBQN
 E4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758643080; x=1759247880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G0uAeiGw/ShN+6tgvtWm7gJwkNslHmQBFVJq6JyXeZI=;
 b=xAJjPbfRks18x14mIonn3hRzYh0JRteToIGGoaOT7YYQif0xlnmQYtuuTIPTNUnreg
 yjnZk3ChCwrgMWFaPrbtd0lly3Rr16gvLUQkYRKJG1yektkOGGfBgM2zmAuf26pHTDu0
 tW9vUkpv+fKaukAFTx37ihzOkqf/1r0NDVnTvqe7QR6dvInNiDZllnVc4Y9EwYFwt6NK
 RmnvqwsrxIliH1zPPrTQE7s8CG04VMVYD28lzcKW5udwwBRE8eJ6ArQorYYxC0SZK3rs
 jmEVhyeZnZRDRx8eFCdd6Ykytf9RjzV7ewPvwOMGnb/CfjBw0GihgPCENj3Oe/Ix6ln7
 rqzA==
X-Gm-Message-State: AOJu0YzzJ/nY+MWfg/xLkWyL/wNG1KW8r4WNjmZjYaKS4uBmIZa449cB
 w4GRJfQ/vavB1+cAVOIe2Oa9jTmu2CHfez3jGi3EAeUfYJIiG148w4WFDyZVJ+fMgBw=
X-Gm-Gg: ASbGncvx4oFaMvVOVWCm0y3BizeHJaXGSJNUU8uiysEEds1c477BUcdiK3QFNM8h7PH
 90cBVz9KvAx2+Fn887LTdxaPOcF93a2g7hcUiW+UWbvqDPXeO0WUpwY+8gjcAbDbh7/b3C2sEwZ
 PJ3qPawqcEW4p9nT9cfsmeqMtce+HGXksbTVMXXBNJysnBubmaGIsvFPtbuVyRo8ZrBb7Z+zfL5
 83Lf+dgGpfp6hbAMK9YhH90mY7eHrr10EEuyhIp+Q4mOZqHgr3tUyD1RfI62+S9IM2vGin7AoJN
 3M3eshORSMgseFRMufQ7fo4tHdBtCQCNDRvvScSdHoJ5jH0ADxqq1d4lY6TCbSX/XrwXR/c2c45
 7P3F1srh/v90HxEyvQLNmjsrN3EwLNlHpte7vUdxTq0I4OCfbf0s0xyO959s+kdarpVFR2TdLa4
 Y=
X-Google-Smtp-Source: AGHT+IEqsWIN00DJoF5S7gSkL0X1mevzCiCwKojgN3n3gafZDtkZi1d4/ytH8Yt5tdk9vckvcMYQ4A==
X-Received: by 2002:ad4:5c86:0:b0:79c:1b67:2cbf with SMTP id
 6a1803df08f44-7e7154564a5mr32543316d6.61.1758643080138; 
 Tue, 23 Sep 2025 08:58:00 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7e0ddd8ae94sm22963926d6.38.2025.09.23.08.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 08:57:59 -0700 (PDT)
Date: Tue, 23 Sep 2025 08:57:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, gongfan1@huawei.com
Subject: Re: [V12 00/18] add-hinic3-PMD-driver
Message-ID: <20250923085756.3daef787@hermes.local>
In-Reply-To: <20250919112433.17926-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250919112433.17926-1-wff_light@vip.163.com>
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

On Fri, 19 Sep 2025 19:24:04 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> The hinic3 PMD (**librte_net_hinic3**) provides poll mode driver support
> for 25Gbps/100Gbps/200Gbps Huawei SPx series Network Adapters.
> 
> V12:
> -modify get_bit function
> -remove define but not used macro
> -modify time_before macro
> 
> v11:
> -reorder code to avoid forward declarations
> -remove unused casts
> -use assignment instead of memcpy
> -change some LOG level to DEBUG level
> -remove unused function
> -remove unused check in mtu_set/dev_config/valn_filter_set
> -defer start/stop
> -use strlpy instead snprintf 
> -remove unnecessary line breaks, fit on line
> 
> v10:
> -add prefix to some functions
> -use memcpy instead of rte_memcpy for simple fixed copies
> -modify LOG messege format
> -modify meson.build files
> -remove unused check in queue_start/stop/intr
> -remove unused function 
> -remove function that stubbed out
> -modify some api log level
> -remove features unsuppurted
> -modify some casts
> -change xstats_cal_num return type
> -modify stats get function 
>  
> v9:
> -resolve type conflict issue
> 
> v8:
> -resolve CI compile error
> -modify mbox section
> 
> v7:
> -remove unused-functions
> 
> v6:
> -modify based on community comments
> -remove mml files
> 
> v5:
> -fix build err
> 
> v4: 
> -solve patch application conflict issue 
>  
> v3:
> -fix checkpatchs errors issue
> 
> v2:
> -modify CI compile errors
> 
> v1:
> -modify community comments and compile issues
> -remove the compilation flags in the meson build
> -remove (void) cur_link_machine_state
> -remove '*** BLURE HERE ***' in cover letter
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
>   net/hinic3: add futions for initialization
>   net/hinic3: add device initialization
>   net/hinic3: add RSS promiscuous ops
> 
> Yi Chen (9):
>   doc: add hinic3 driver
>   net/hinic3: add hardware interfaces of BAR operation
>   net/hinic3: add eq mechanism
>   net/hinic3: add mgmt module function code
>   net/hinic3: add module about hardware operation
>   net/hinic3: add a NIC business configuration module
>   net/hinic3: add a mailbox communication module
>   net/hinic3: add flow control and FDIR module
>   drivers/net: add hinic3 PMD build and doc files
> 
>  .mailmap                                   |    4 +-
>  MAINTAINERS                                |    6 +
>  doc/guides/nics/features/hinic3.ini        |   60 +
>  doc/guides/nics/hinic3.rst                 |   47 +
>  doc/guides/nics/index.rst                  |    1 +
>  doc/guides/rel_notes/release_25_11.rst     |    4 +
>  drivers/net/hinic3/base/hinic3_cmd.h       |  135 +
>  drivers/net/hinic3/base/hinic3_cmdq.c      |  962 ++++++
>  drivers/net/hinic3/base/hinic3_cmdq.h      |  222 ++
>  drivers/net/hinic3/base/hinic3_compat.h    |  133 +
>  drivers/net/hinic3/base/hinic3_csr.h       |  104 +
>  drivers/net/hinic3/base/hinic3_eqs.c       |  700 ++++
>  drivers/net/hinic3/base/hinic3_eqs.h       |   92 +
>  drivers/net/hinic3/base/hinic3_hw_cfg.c    |  190 ++
>  drivers/net/hinic3/base/hinic3_hw_cfg.h    |  110 +
>  drivers/net/hinic3/base/hinic3_hw_comm.c   |  442 +++
>  drivers/net/hinic3/base/hinic3_hw_comm.h   |  365 ++
>  drivers/net/hinic3/base/hinic3_hwdev.c     |  549 +++
>  drivers/net/hinic3/base/hinic3_hwdev.h     |  166 +
>  drivers/net/hinic3/base/hinic3_hwif.c      |  739 ++++
>  drivers/net/hinic3/base/hinic3_hwif.h      |  145 +
>  drivers/net/hinic3/base/hinic3_mbox.c      | 1189 +++++++
>  drivers/net/hinic3/base/hinic3_mbox.h      |  181 +
>  drivers/net/hinic3/base/hinic3_mgmt.c      |  340 ++
>  drivers/net/hinic3/base/hinic3_mgmt.h      |  102 +
>  drivers/net/hinic3/base/hinic3_nic_cfg.c   | 1785 ++++++++++
>  drivers/net/hinic3/base/hinic3_nic_cfg.h   | 1517 +++++++++
>  drivers/net/hinic3/base/hinic3_nic_event.c |  400 +++
>  drivers/net/hinic3/base/hinic3_nic_event.h |   38 +
>  drivers/net/hinic3/base/hinic3_wq.c        |  139 +
>  drivers/net/hinic3/base/hinic3_wq.h        |  109 +
>  drivers/net/hinic3/base/meson.build        |   16 +
>  drivers/net/hinic3/hinic3_ethdev.c         | 3565 ++++++++++++++++++++
>  drivers/net/hinic3/hinic3_ethdev.h         |  164 +
>  drivers/net/hinic3/hinic3_fdir.c           | 1364 ++++++++
>  drivers/net/hinic3/hinic3_fdir.h           |  398 +++
>  drivers/net/hinic3/hinic3_flow.c           | 1476 ++++++++
>  drivers/net/hinic3/hinic3_flow.h           |  196 ++
>  drivers/net/hinic3/hinic3_nic_io.c         |  802 +++++
>  drivers/net/hinic3/hinic3_nic_io.h         |  171 +
>  drivers/net/hinic3/hinic3_rx.c             | 1057 ++++++
>  drivers/net/hinic3/hinic3_rx.h             |  354 ++
>  drivers/net/hinic3/hinic3_tx.c             | 1025 ++++++
>  drivers/net/hinic3/hinic3_tx.h             |  314 ++
>  drivers/net/hinic3/meson.build             |   30 +
>  drivers/net/meson.build                    |    1 +
>  46 files changed, 21908 insertions(+), 1 deletion(-)
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
> 

Queued to next-net. Thank you for following up on all the review
