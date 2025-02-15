Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA4FC021A0
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Feb 2025 19:05:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34584400EF;
	Sat, 15 Feb 2025 20:05:57 +0100 (CET)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id C813540041
 for <dev@dpdk.org>; Sat, 15 Feb 2025 20:05:55 +0100 (CET)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2fbfe16cc39so5872231a91.3
 for <dev@dpdk.org>; Sat, 15 Feb 2025 11:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739646355;
 x=1740251155; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+caQmEKCCy5/Ex0LidBwgbZjBnCRAxvMrKSo8LNZvQ=;
 b=vAMUXmWNUD9QTzPcrDjLMIfnXR/4XQWqL5wessSGxpHq6efxYGFk7OmWn5BvAE/kzA
 s5y5vJfuzFkWjjo5JYnpah1pu+tBkkNbfDb7RYBbv4DgLKwOyAZHs7+wWD0kAqfHPF6X
 BURO4w41bsmo9Obd6btPNVVh0wgjrsvMv4pAHRZmMiH2ZAgrodheArxvtzD7yTlvkBM5
 XxJGAfrL7W0h+M0x7Fr6lbZxmMoaPnWZXqcBw5R/2ujb4fMEcSkS1ayuznuM6hu0PpiH
 s7utKe/JaI+nlPE800rmoZe735EBiZ4nxXRgvWQhGk9HWSIMuFLqdOmXz8VfQ0IMhG+m
 VRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739646355; x=1740251155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+caQmEKCCy5/Ex0LidBwgbZjBnCRAxvMrKSo8LNZvQ=;
 b=PbH/PetG6rTadozq1kKG/rmnM7Ok4onpSiS4rRTsrD3Z2iCiKaUdTSpS6ze+PVn7FL
 B8RMh5jNAV9z1Q8JJjtnWC4/sPz30yMHR0uqw9gUJLvyChPpaRhlYxGIRaBAL5WodJqX
 6kewe2dLAujDIj6dObeE1n8N3+WkffNAfD5q7zNyk8A/KYT6R408mhDFpgZRTHC0yK6v
 sJN0CTHybEtYOt+R8dR8NSGbS3xV8rd1OAsQZ4s5K93S1YmlnHxNS883jZ2iuohmPuC2
 pRgjewfQMJeDa//aBlQf2SZp00MQyVvmneXglCZe8MKJjA070gg/w/68wZWOiJNCzhNh
 3MCw==
X-Gm-Message-State: AOJu0Yw8Y9XbIOb6EDpbF0osTarHUCRpb/16fNIFiAY6DUXiEy/FnNJv
 x2Gh+B8AcNE2VDA1wlj7jhVSeW5zFwmasMwAQjE1Q0jVe9e5pR+uaQiFrwcYh5WW7cDGMPb9pTd
 9
X-Gm-Gg: ASbGncvMA0lVoaSO79TjPxsSwepujreuEZ/ih2759kMV+T4Dk+3nM0Dz1AfiRR2v0Sx
 a1+ROZh8nhNWIwip2OaIvab4l9Xa/5PFDkgI0YkqmH97Cn2bvqOWRKqNfvH9npu2S7MFJCRmU1B
 D0aAqmYQ6Oud83Njjb8HmgbsB4f8JZ4QVXWBvvW8XrlrQD5XLS5mnlv7n5nr6sNxtQY/kYcBWLg
 f3y7032HR3rwdBiImvAIrCfP8iEEcDivlY+OYGTGvg2BTxo+gfZr6I+mecY2bkhNfikWZeothrG
 DDsDEtwWbK/LdpJfBq1RMR0sq4a5MyeiE6yEDam0GuvX9JbA1oYVTLgr/iWufTbLK13P
X-Google-Smtp-Source: AGHT+IEUQrNSr+xlZr7g51629MxsApujxADbUZbix3oCIU5Z1CWsJRGFHEwYqRBldJsee5oIbk2zlg==
X-Received: by 2002:a05:6a00:3d42:b0:730:8d0c:1066 with SMTP id
 d2e1a72fcca58-73261911238mr7454426b3a.24.1739646354815; 
 Sat, 15 Feb 2025 11:05:54 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324254685csm5080179b3a.4.2025.02.15.11.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 11:05:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 00/16] Introduce secure memory zero functions
Date: Sat, 15 Feb 2025 11:04:28 -0800
Message-ID: <20250215190544.988310-1-stephen@networkplumber.org>
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

This series handles memset related bugs indentified by PVS Studio.
The root cause is that Gcc and other compilers are free to
optimize away memset called before free. This is handled in
other libraries and OS's by the use of special versions of zeroing
and free.

v7 - use bzero_explicit
   - add standalone tests

Stephen Hemminger (16):
  eal: introduce new secure memory zero
  app/test: use unit test runner for string tests
  app/test: add test for rte_memzero_explicit
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

 app/test/test_cmdline_cirbuf.c                |   2 -
 app/test/test_malloc.c                        | 183 ++++++++++--------
 app/test/test_string_fns.c                    |  74 ++++++-
 devtools/cocci/memset_free.cocci              |   9 +
 drivers/bus/uacce/uacce.c                     |   1 -
 drivers/common/cnxk/roc_npc_utils.c           |   4 -
 drivers/compress/octeontx/otx_zip.c           |   1 -
 drivers/compress/octeontx/otx_zip_pmd.c       |   2 -
 drivers/crypto/qat/qat_asym.c                 |   5 +-
 drivers/crypto/qat/qat_sym_session.c          |  43 ++--
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
 lib/eal/common/eal_common_string_fns.c        |  15 ++
 lib/eal/common/rte_malloc.c                   |  30 ++-
 lib/eal/include/rte_malloc.h                  |  23 +++
 lib/eal/include/rte_string_fns.h              |  19 ++
 lib/eal/version.map                           |   4 +
 37 files changed, 304 insertions(+), 212 deletions(-)
 create mode 100644 devtools/cocci/memset_free.cocci

-- 
2.47.2

