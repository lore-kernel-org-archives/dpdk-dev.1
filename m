Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FB3C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:42:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7803B402B2;
	Thu, 20 Feb 2025 17:42:03 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3550340292
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:42:02 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-220ecbdb4c2so30361615ad.3
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740069721;
 x=1740674521; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nfNJkNM7iImK5UCA37o4nRhDpzQOVcUV2yAE/5EzjkM=;
 b=zczT9TmRU0PjbenFYVbWqgDRFYzHJEiZb0J+yvXEny5rOGDlKCfM8blOUodCSwNTj1
 /i7m45WOAvy+c3Ejv97FGbJU0Pbq6oYulXzzUhleaGhZ1l0KZQORpHLxdfr5UIDZQNcs
 ZYL7O0LD26T/Twz6adMWPmE64EOITE2DB6wYOaTUpp3IkqfrRVCLgwvsfmTHb+Go4ub/
 P+6YXtcVSScSa0XEoOvSPyOAO2Fph3GkLx1+FVTbAty0zSSSuLqA0kuZlKO0OV0r/T0I
 9YrTs7N4xm1TVJKwFtUNel5YXx61s8kkyv7XYByakwnH6soEZf2bVu1+kSJUu9dEEIr3
 DT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740069721; x=1740674521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nfNJkNM7iImK5UCA37o4nRhDpzQOVcUV2yAE/5EzjkM=;
 b=Usw78ztxglcqLacDsOPYC9z4R7LjQ1ng8KxJHgA8yd0E9KwhAVcgEDP2UShxPL/trE
 JXfcFU/sqVB1x6W47wxp59qinhPAsuqpI0cc5q0RI0iLLdDvPtPQQ9HU7PqL+M0RSWD5
 TaSFAlx8qFoTHEvjjqg7ZjyXMlK/CsUwt2J6ZLDw+dhVe8n70qEPtrIfCOV6qE3DIspL
 cXJ6VV94oSayRL5Y92daljck0PRR2wjVJqqitn6YeIUWsS8KhzyovuHYMerfnUbYnWLK
 zKAJD+m/rnh5zFfxJxxctnZcd8kl81o25WDQUwZyf+Iq2Upec2NifvlphFMDMsmbzAt3
 PfAQ==
X-Gm-Message-State: AOJu0YwJY1ZdP23OohQ0g5mJge16s9ZrByUcEyUrfZo4q5VNPE0BFyrp
 hzeT/0T3SSCGp/uUDooQhq3FGYkWFY2Cevdhc0cymJB+BVDBbRSZEKOYq9JS334TpPbn2KHX5vx
 C
X-Gm-Gg: ASbGncs0Qz2mcLz4+bqLllbfzUQqyPgj5lfjmg5TAeT/pjRLxMsiGJZRXuNQw3fiH70
 uTxmRxXRkj8nuxzd0iFDNWKpiha0ogR2M328rMvVFZRcFDI03yTqo3gzTORtxJbIG7/eT2SpG53
 SDAaiMOEtiFRnIcs8Yr+xPr2YfDX43ttXyoXiMraX54nBGDZBsySxuDP/DpTk/c4DNuNaeTrpJb
 PweXZKnjmm0VmwEQ2h3v6wcitbb5SdMhbKKdBECwbv/TI3cSrCMSyHzIbuCpEIgrS053tYtxIFQ
 v5gv2EX3vdiMk490QjGaA3MZYkDOBmzL66HNo+rIXno7ZfFf4EN3K28prK30A4uQzeD9
X-Google-Smtp-Source: AGHT+IFBJ+g6TkR9k+83NEAagd2/nurIOq+W2wh9J88TL1K9o7YoD0+Zr0DQfdzSR3PsszvXSY2f3g==
X-Received: by 2002:a17:903:22cd:b0:21f:49f2:e33f with SMTP id
 d9443c01a7336-221040389ddmr325049265ad.21.1740069720903; 
 Thu, 20 Feb 2025 08:42:00 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5348e68sm123798305ad.28.2025.02.20.08.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:42:00 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 00/15] fix insecure use of memset bugs
Date: Thu, 20 Feb 2025 08:27:06 -0800
Message-ID: <20250220164151.9606-1-stephen@networkplumber.org>
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

There is an issue where calls to bzero (memset(), etc) can be
eliminated due to an optimizing compiler eliminating the call to
bzero() (or memset(), etc) because the arguments to the call are not
subsequently used by the function. The compiler can interpret this as
"no side effects", and eliminate the call.

The origin source of issue to being brought to light with a
security focus' is here: http://cwe.mitre.org/data/definitions/14.html

The issue was discovered in DPDK while looking at PVS Studio
blog about bugs:

https://pvs-studio.com/en/blog/posts/cpp/1183/

In DPDK there are three types of anti-patterns:
   1. trying to clear a key or sensitive data but using memset
   2. being overly paranoid and always calling memset
   3. unnecessary arrays (cut and paste?) that are memset


v9 - drop the standalone test for explicit zero
     because testing that code is not optimized away requires some non-portable
     hacks using altstack and/or glibc setcontext hooks. Not worth the hassle
     doing this and maintaining, just trust that libc works as expected.

Stephen Hemminger (15):
  eal: introduce new secure memory zero
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
 36 files changed, 251 insertions(+), 210 deletions(-)
 create mode 100644 devtools/cocci/memset_free.cocci

-- 
2.47.2

