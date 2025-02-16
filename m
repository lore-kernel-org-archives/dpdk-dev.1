Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A3CC02198
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 17:01:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63DDF40156;
	Sun, 16 Feb 2025 18:01:22 +0100 (CET)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id EF70840150
 for <dev@dpdk.org>; Sun, 16 Feb 2025 18:01:20 +0100 (CET)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-219f8263ae0so62631365ad.0
 for <dev@dpdk.org>; Sun, 16 Feb 2025 09:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739725280;
 x=1740330080; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vmN3o7iH912keCUKIIVcEyOIxZVpAQ40QSO2LduDMEQ=;
 b=iLv90Ly3/Gax/qHwNHtSSnMiiCMOfNhlhkJDB8TZxHjs+92s+lTVcGYT7FyI6DlIUb
 hVujJ4iUVaovpFJMgCnM0XzhYIGB6IjM5X8k3DKLGVDVUON01SdwJe4Cl6yvESlaIt2v
 /PaVlDecnKN4yBp8PXqdR/4Zlg4ZGq2+L4rg/6mg7RpcW1QwFNDhCjZoQPMhCpbg5A7w
 04NqGJqszWHpHXwVZdvtP6hn8J8BUkEl3EssBOnKdQFAlPfV8mqPc+BWOtY+LMMHBycR
 ztKnKUlw+KTXHo/ZtEfvj8I15Pdl+F1S8GQdrVVr+/ocECimOev1Uu9Ul3knohCdxD03
 ZBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739725280; x=1740330080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vmN3o7iH912keCUKIIVcEyOIxZVpAQ40QSO2LduDMEQ=;
 b=PaXIHFxhnRh9d23oT5kkGkg7r1ATQMRh31hooehIeLnOa1VtBnnasmEs0ud4Irxzlg
 wip572K1MNZ4Tn687sHYVwnKM7zFI9uZbEGU+XdD6FCiu8711SERQsMsEdvIj7MiG3Rc
 EDI3k41itP5nFlbnpU4Vh7nudg9VP6iRfMOs2xEGPaj2WxYuvpyIEsFBIz1ibZZAKr2u
 HS5PEf6H2P9TQ2xojZ8UpsXsZqYMcpHV9ryMpxX1rAlUkjoAwNJhzIht1OcGXHpkl9A2
 DeaOLsOKH5xChEjeHnrD2gNt1XalokePgsxTqHKydWqFL1a3U7v8RU8c5KSLxSJlv+EB
 evdA==
X-Gm-Message-State: AOJu0Yx+OQvxtJj2vBe21SPJYr5iusBBw0yDk8q1sqicp6xUMLXle57E
 i1bzcllheu+2v8SbWJDpKa5AVW3vfU3ilEO3fXltTO8RkT8LCVNjtqYT56YLmv0ikFEUc6eDXBL
 Z
X-Gm-Gg: ASbGncvu6ziAp4r5NAXX4seHGbfSyigCLT8219iYx2g6cjAweBgzdSFRE5FBKh5i9jx
 c9byPF3afxZnO/GxrR1VF618WQk21sX8kw7aDrdAMp9iZFuVckgq0RD+jx+Pl45WGU9Yw7jfSY/
 nfiDdWSMxpHQ+F1PgjQntmW6wTjjZnNkm2jqd2PyVe3fWozTR9a5fhxrdz9yhWZvEMyUwyQW1FO
 4syyMHbZMTUCf3ndXu2wxZBjXqTpY+DwU+UVeumnSuKq85XWo4dezzDR2Em5hKpeeqsQ15HIDV+
 CpivgzkGTqZygB+gLbREJMLHLgh7UJG7Ipu4PDMw/+oCoLKOTzG2odrakLEXana3PbVg
X-Google-Smtp-Source: AGHT+IHMT653wpMDho8mfD5mvFZBB9vc5MwQMjDihT4HkD/d5ZbG9yBTwBGuyhXKf/rZIlE2vJVV/g==
X-Received: by 2002:a17:902:f612:b0:21f:9c7:2d2e with SMTP id
 d9443c01a7336-221040bdb68mr117168635ad.40.1739725280147; 
 Sun, 16 Feb 2025 09:01:20 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2211eafd20dsm11196805ad.182.2025.02.16.09.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 09:01:19 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 00/17] fix memset warnings reported by PVS studio
Date: Sun, 16 Feb 2025 08:52:59 -0800
Message-ID: <20250216170110.7230-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20241114011129.451243-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series handles memset related bugs identified by PVS Studio.
This tool will correctly flag places where memset could be deleted.
See: https://pvs-studio.com/en/docs/warnings/v597/

Compilers are free to optimize away memset called before free.
This is handled in other libraries and OS's by the use of special
versions of zeroing and free.

There are three types of anti-patterns:
   1. trying to clear a key or sensitive data
   2. being overly paranoid and always calling memset that can be removed.
   3. unnecessary arrays (cut and paste?) that can be removed.

v8 - annotate the unit test so that it passes with ASAN
   - fix test for cmdline_cirbuf
   - additional memset fix in QAT

Stephen Hemminger (17):
  eal: introduce new secure memory zero
  app/test: use unit test runner for string tests
  app/test: add test for rte_memzero_explicit
  app/test: remove unused variable
  eal: add new secure free function
  app/test: use unit test runner for malloc tests
  app/test: add test for rte_free_sensitive
  common/cnxk: remove unused variable
  crypto/qat: force zero of keys
  crypto/qat: fix size calculation for memset
  crypto/qat: use secure free for keys
  bus/uacce: remove memset before free
  compress/octeontx: remove unnecessary memset
  test: remove unneeded memset
  net/ntnic: check result of malloc
  net/ntnic: remove unnecessary memset
  devtools/cocci: add script to find problematic memset

 app/test/test_cmdline_cirbuf.c                |   4 -
 app/test/test_malloc.c                        | 194 ++++++++++--------
 app/test/test_string_fns.c                    |  74 ++++++-
 devtools/cocci/memset_free.cocci              |   9 +
 drivers/bus/uacce/uacce.c                     |   1 -
 drivers/common/cnxk/roc_npc_utils.c           |   4 -
 drivers/compress/octeontx/otx_zip.c           |   1 -
 drivers/compress/octeontx/otx_zip_pmd.c       |   2 -
 drivers/crypto/qat/qat_asym.c                 |   5 +-
 drivers/crypto/qat/qat_sym_session.c          |  51 ++---
 drivers/net/ntnic/nthw/core/nthw_hif.c        |   5 +-
 drivers/net/ntnic/nthw/core/nthw_iic.c        |   5 +-
 drivers/net/ntnic/nthw/core/nthw_pcie3.c      |   5 +-
 drivers/net/ntnic/nthw/core/nthw_rpf.c        |   5 +-
 drivers/net/ntnic/nthw/core/nthw_sdc.c        |   5 +-
 drivers/net/ntnic/nthw/core/nthw_si5340.c     |   5 +-
 .../ntnic/nthw/flow_filter/flow_nthw_cat.c    |   5 +-
 .../ntnic/nthw/flow_filter/flow_nthw_csu.c    |   5 +-
 .../ntnic/nthw/flow_filter/flow_nthw_flm.c    |   5 +-
 .../ntnic/nthw/flow_filter/flow_nthw_hfu.c    |   5 +-
 .../ntnic/nthw/flow_filter/flow_nthw_hsh.c    |   5 +-
 .../ntnic/nthw/flow_filter/flow_nthw_info.c   |   5 +-
 .../net/ntnic/nthw/flow_filter/flow_nthw_km.c |   5 +-
 .../ntnic/nthw/flow_filter/flow_nthw_pdb.c    |   5 +-
 .../ntnic/nthw/flow_filter/flow_nthw_qsl.c    |   5 +-
 .../ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c |   5 +-
 .../ntnic/nthw/flow_filter/flow_nthw_slc_lr.c |   5 +-
 .../ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c |   1 -
 .../ntnic/nthw/flow_filter/flow_nthw_tx_ins.c |   5 +-
 .../ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c |   5 +-
 .../net/ntnic/nthw/model/nthw_fpga_model.c    |   1 -
 drivers/net/ntnic/nthw/nthw_rac.c             |   4 +-
 lib/eal/common/eal_common_string_fns.c        |  14 ++
 lib/eal/common/rte_malloc.c                   |  30 ++-
 lib/eal/include/rte_malloc.h                  |  23 +++
 lib/eal/include/rte_string_fns.h              |  18 ++
 lib/eal/version.map                           |   4 +
 37 files changed, 318 insertions(+), 217 deletions(-)
 create mode 100644 devtools/cocci/memset_free.cocci

-- 
2.47.2

