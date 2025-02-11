Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44218C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 17:37:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44D6F4067A;
	Tue, 11 Feb 2025 18:37:34 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id C1B1F40662
 for <dev@dpdk.org>; Tue, 11 Feb 2025 18:37:32 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2f9b91dff71so9019959a91.2
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739295452;
 x=1739900252; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b69v1z3OherMP4nXpe8s339bbwaUc+RkxBpdTr7pwDU=;
 b=1SaPEj8e0fBSweVdK0cMXQZkBKRoRMm1sufo0U42Z+P/cADwfnjX/3Ywj6DnAH3hm9
 PkuyBDdQsLstjZnvBYhTSH823PEZv1mejLrE6ryiW7T4To4qbCl/0Xgbwihhv62plJux
 zZDM09OgIM7yCIInpG7Jt64XBkkZ3tbPhP8MHlkntjHMksulJpAIBULnuxMOm5HSGMEQ
 OVASzN4WvvhtvxTrP1+fjWRkHvXK5V5/A7d2S/EEhZo+qpibIdvxrXGA5rb2zCEzMwCL
 ajYRqfcfO2+fEd2nvhpaxb4GDWwyk++aNzCF72n3GiW7PW95ULAMmVpnK7gn9DibMRYr
 ldbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739295452; x=1739900252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b69v1z3OherMP4nXpe8s339bbwaUc+RkxBpdTr7pwDU=;
 b=FGIHZ62cRTLFa9hqB9kUJC1D9o0XVNPciaOkJwEqHBhzne08aF0453o1DOKrR0YJJI
 Q9C6I08QaIepRnP44758wm31522XuHvjM1jiXkHTHGAQimuJRGqUrR4pEySNS13B0jn/
 Y2xeA1jgGbCBbSRNXElTiNSrD5Fze2Yy0Q8mENwZJfE2Eq7lXihKm124FOwJ8wwptPVy
 a6LN3O41p3a0OMHOR1EBPLHDVzr+Kua8ZLkFodCXndz0NZVp90D8QuOUBsQA0xhN9QLR
 D14HwMDsaDQWlG0H+/77hSrwn4NcBcFBiZ4kpljwWmSg4s4drnd4Dy1pai4VJVgnDQUI
 sccw==
X-Gm-Message-State: AOJu0YzHKhg28prRbzn6LIEn8xoF5kqgPGAY+Zx6WYS2owGTgG/q6P7h
 PLdHqE0tFR6nFUvvuWjPgRN4bHAhfvKSNWC6ppk0iszRYG7BtU/6WkEpxlf9i19taDm/DKWsIAZ
 C
X-Gm-Gg: ASbGncs2rh9Y1T66fO7Rv0kkyTf14wOwo8zo+fYrW+StjCcJmeLXkmn8DlVPqnwlhGw
 bbl7cFQvsRC1l4sW4zvRj01LWqxtkiXGaHn5WYLqaPwcBNmWNAYBfwRQ2Ur3oLiItcBc+oAVs+Q
 2qonypfhmV9fURsa/wwv1D4jquKlAVycwHDXyiAba4hudaoWkvQx2pKlOVaVckBM+sV8no4NkYK
 sF3oE0QXrTLjNkMbgB5lqNlorScUdbR5t/VaVoRXToyKLpNV9GsJrc8q5f018/XyOtpYntn77Bs
 bSzh5K9tRQh7X2jFboUhhtSBC1ghPCYMo4CCIgRJq+MQnhnebvCgBII3/OWDyi1l/WGI
X-Google-Smtp-Source: AGHT+IH4pV5LGVLWI63YCne0Lej3+BawYeyHmlpv5JHCaEbzuPjxuFCmDiLoe6IEXD4o5f2molZsmw==
X-Received: by 2002:a17:90b:370f:b0:2ee:863e:9ffc with SMTP id
 98e67ed59e1d1-2fa24178aeamr24623066a91.21.1739295451595; 
 Tue, 11 Feb 2025 09:37:31 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa4656bd27sm7131811a91.42.2025.02.11.09.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 09:37:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 00/11] memset security fixes
Date: Tue, 11 Feb 2025 09:35:20 -0800
Message-ID: <20250211173720.1188517-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20241114011129.451243-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
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

This series handles memset related bugs indentified by PVS Studio.
The root cause is that Gcc and other compilers are free to
optimize away memset called before free.

Most of the places memset was being used like this were bogus;
probably some developer debug habit, and can be safely removed.

v6 - add stable to the ntnic bug fix
   - drop elimination of void cast in ntnic - unrelated change
   - rebase

Stephen Hemminger (11):
  eal: introduce new secure memory fill
  eal: add new secure free function
  crypto/qat: force zero of keys
  crypto/qat: fix size calculation for memset
  crypto/qat: use secure memset
  bus/uacce: remove memset before free
  compress/octeontx: remove unnecessary memset
  test: remove unneeded memset
  net/ntnic: check result of malloc
  net/ntnic: remove unnecessary memset
  devtools/cocci: add script to find problematic memset

 app/test/test_cmdline_cirbuf.c                |  2 --
 devtools/cocci/memset_free.cocci              | 20 +++++++++++++
 drivers/bus/uacce/uacce.c                     |  1 -
 drivers/compress/octeontx/otx_zip.c           |  1 -
 drivers/compress/octeontx/otx_zip_pmd.c       |  2 --
 drivers/crypto/qat/qat_asym.c                 |  5 +---
 drivers/crypto/qat/qat_sym_session.c          | 27 +++++++++--------
 drivers/net/ntnic/nthw/core/nthw_hif.c        |  5 +---
 drivers/net/ntnic/nthw/core/nthw_iic.c        |  5 +---
 drivers/net/ntnic/nthw/core/nthw_pcie3.c      |  5 +---
 drivers/net/ntnic/nthw/core/nthw_rpf.c        |  5 +---
 drivers/net/ntnic/nthw/core/nthw_sdc.c        |  5 +---
 drivers/net/ntnic/nthw/core/nthw_si5340.c     |  5 +---
 .../ntnic/nthw/flow_filter/flow_nthw_cat.c    |  5 +---
 .../ntnic/nthw/flow_filter/flow_nthw_csu.c    |  5 +---
 .../ntnic/nthw/flow_filter/flow_nthw_flm.c    |  5 +---
 .../ntnic/nthw/flow_filter/flow_nthw_hfu.c    |  5 +---
 .../ntnic/nthw/flow_filter/flow_nthw_hsh.c    |  5 +---
 .../ntnic/nthw/flow_filter/flow_nthw_info.c   |  5 +---
 .../net/ntnic/nthw/flow_filter/flow_nthw_km.c |  5 +---
 .../ntnic/nthw/flow_filter/flow_nthw_pdb.c    |  5 +---
 .../ntnic/nthw/flow_filter/flow_nthw_qsl.c    |  5 +---
 .../ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c |  5 +---
 .../ntnic/nthw/flow_filter/flow_nthw_slc_lr.c |  5 +---
 .../ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c |  1 -
 .../ntnic/nthw/flow_filter/flow_nthw_tx_ins.c |  5 +---
 .../ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c |  5 +---
 .../net/ntnic/nthw/model/nthw_fpga_model.c    |  1 -
 drivers/net/ntnic/nthw/nthw_rac.c             |  4 ++-
 lib/eal/common/rte_malloc.c                   | 30 +++++++++++++++----
 lib/eal/include/rte_malloc.h                  | 18 +++++++++++
 lib/eal/include/rte_string_fns.h              | 27 +++++++++++++++++
 lib/eal/version.map                           |  3 ++
 33 files changed, 129 insertions(+), 108 deletions(-)
 create mode 100644 devtools/cocci/memset_free.cocci

-- 
2.47.2

