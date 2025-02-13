Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E3DC021A0
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 22:18:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07EC2402B9;
	Thu, 13 Feb 2025 23:18:32 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id E013040279
 for <dev@dpdk.org>; Thu, 13 Feb 2025 23:18:30 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2fbf5c2f72dso2300916a91.1
 for <dev@dpdk.org>; Thu, 13 Feb 2025 14:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739485110;
 x=1740089910; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PwbPAYaQDaY6eyfb3DfMi7Frq4tEeq7+B7UnYVKaLC4=;
 b=MAJ8adfRSox4tqR3YANlGndZMSRDuxYacpxyAneqfZ9bt+26pT2NyBen+eXiu6ZMAj
 bamWXpN/2qoX0NdVMPz/4wjUAzdrQsyK2AGA/zX0nskn6/ngnigtD4rHJFX/vytDp47e
 xe7dQzQn5zF5bsTLVdRFEPRfRmLTZ9bN5rmVqNNh3If/hxrRhDavgudcH5GSlLGt/inr
 mnXRIjqpEtR8+Hfrik61DO0LYb/Av9x3bb0S+rbtAevg+TxWpxvCTmmb1CYY4ZhPJcoj
 DGLJfCRC0oTwHXnFqg5ey7E7zRtrPY2z3q2qIi7xJc2nfTen2gI1BFwLqtom9fsfgt9E
 CCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739485110; x=1740089910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PwbPAYaQDaY6eyfb3DfMi7Frq4tEeq7+B7UnYVKaLC4=;
 b=nsejKUAqqYb1ojxHvR+L/rulpbOfsHq9t9KIKgx0AEQuFQEL/DaAajOHU3RuibC4FH
 7TzDPnCCM7FTOOaBdHmZ/z03eJTO/Jwft4s5D+BiM93JaZGd6DRmaZ4qi1ahvRf4FMMs
 SWwom6O2g/IQe+LyEmB7K3t3CI8rxHBvrtssCoVFz0IKlf2VnBTIeSWFj5VUA4qEmJNX
 gBLRyAQVdd9SPaR/grjda/G2wE0m0CyCkh8RjUDa3WYSNd/aHbLSrr/Ie0GjFAb4hgrl
 B371+Lwasw5j6D23XMBLYgOBEpeioAk+3LAkIb+Ara1oPk1XaAU3oWaZPGTRfVStOv6v
 V1GA==
X-Gm-Message-State: AOJu0YxM0PghvYAdvxVOqPcSywnOZ39CDAqrAUNZAIc49lm9Yz8GPIky
 uypSvkvFR4BtMDR4sIRmLvPJDq/l1tn2iZSOqKqAX7BHCqTPCRdWoA7D4a2aixo2fjHDEyIxKqH
 s
X-Gm-Gg: ASbGncvIQu7hFw/78lpfPdYv7w+PMwhKzX877v8v1M7KF1gd/Rl08mt3p2zysHh6E2q
 VhVYyJ1IaGu1BuNEbA+87GNpeIr78nddQdETnWQadStF2naPzK0Myts9gJFmbLJhsYPrkvaelIm
 Gde6+FXEejLiKNc5lruazlfJJ70XlIpRQabBLow1Hb4pfVdtLh+7jzS93Bl2QN+IXerI1Htsw2K
 G7mbzxUfaa0l+RyY5siUG4ZpvBSlKItlXb/iR2b/tI7ITgluX4LlDkMVF2Muf6DJgFVthaEigyI
 AyXppMsGALp1RuhZDuUcqiockIbUZEKY7NZpqh8k1rVaMyr+n3uNNT/i51LheOR3Y6Qi
X-Google-Smtp-Source: AGHT+IHpJbwXqVuwRsGYeRupTHlBTcZgv/TQ7lVt4C5/JDGZZAvCFWOlvp5JuSopP9Yvsq/E1V/cLg==
X-Received: by 2002:a17:90b:2748:b0:2ee:dd9b:e402 with SMTP id
 98e67ed59e1d1-2fbf5bf351cmr17034769a91.12.1739485110004; 
 Thu, 13 Feb 2025 14:18:30 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad726bsm1706826a91.28.2025.02.13.14.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 14:18:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 00/11] secure zeroing of memory
Date: Thu, 13 Feb 2025 14:16:13 -0800
Message-ID: <20250213221819.1856769-1-stephen@networkplumber.org>
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

v6 - rename rte_memset_sensative to rte_memzero_explicit to more
     closely match kernel usage.
     use rte_free_sensistive in crypto/qat driver

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

 app/test/test_cmdline_cirbuf.c                |  2 -
 devtools/cocci/memset_free.cocci              |  9 ++++
 drivers/bus/uacce/uacce.c                     |  1 -
 drivers/compress/octeontx/otx_zip.c           |  1 -
 drivers/compress/octeontx/otx_zip_pmd.c       |  2 -
 drivers/crypto/qat/qat_asym.c                 |  5 +--
 drivers/crypto/qat/qat_sym_session.c          | 43 ++++++++++---------
 drivers/net/ntnic/nthw/core/nthw_hif.c        |  5 +--
 drivers/net/ntnic/nthw/core/nthw_iic.c        |  5 +--
 drivers/net/ntnic/nthw/core/nthw_pcie3.c      |  5 +--
 drivers/net/ntnic/nthw/core/nthw_rpf.c        |  5 +--
 drivers/net/ntnic/nthw/core/nthw_sdc.c        |  5 +--
 drivers/net/ntnic/nthw/core/nthw_si5340.c     |  5 +--
 .../ntnic/nthw/flow_filter/flow_nthw_cat.c    |  5 +--
 .../ntnic/nthw/flow_filter/flow_nthw_csu.c    |  5 +--
 .../ntnic/nthw/flow_filter/flow_nthw_flm.c    |  5 +--
 .../ntnic/nthw/flow_filter/flow_nthw_hfu.c    |  5 +--
 .../ntnic/nthw/flow_filter/flow_nthw_hsh.c    |  5 +--
 .../ntnic/nthw/flow_filter/flow_nthw_info.c   |  5 +--
 .../net/ntnic/nthw/flow_filter/flow_nthw_km.c |  5 +--
 .../ntnic/nthw/flow_filter/flow_nthw_pdb.c    |  5 +--
 .../ntnic/nthw/flow_filter/flow_nthw_qsl.c    |  5 +--
 .../ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c |  5 +--
 .../ntnic/nthw/flow_filter/flow_nthw_slc_lr.c |  5 +--
 .../ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c |  1 -
 .../ntnic/nthw/flow_filter/flow_nthw_tx_ins.c |  5 +--
 .../ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c |  5 +--
 .../net/ntnic/nthw/model/nthw_fpga_model.c    |  1 -
 drivers/net/ntnic/nthw/nthw_rac.c             |  4 +-
 lib/eal/common/rte_malloc.c                   | 30 ++++++++++---
 lib/eal/include/rte_malloc.h                  | 20 +++++++++
 lib/eal/include/rte_string_fns.h              | 24 +++++++++++
 lib/eal/version.map                           |  3 ++
 33 files changed, 125 insertions(+), 116 deletions(-)
 create mode 100644 devtools/cocci/memset_free.cocci

-- 
2.47.2

