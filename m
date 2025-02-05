Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABD4C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:25:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5014740289;
	Wed,  5 Feb 2025 17:25:02 +0100 (CET)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id C2C2240289
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:25:00 +0100 (CET)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2f9d627b5fbso2758918a91.2
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738772700;
 x=1739377500; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7wOXF7igTsLGjZyBPEEbIlcgTqW4B1eKUWYBROZ8to=;
 b=DfSRUVmIjFUL9lV197G3iI76dusBoKH7/19Cqg55Q2IcezhfivMV09cbe4tjWwxuPd
 FgCZi3C9efLjc4KWaNi4CfHYN4g93HZSxvYdbYH3e0q+WKpwOduLgg5EFdznlHdLOgYi
 EAJo5M9SKQyX6A6qeppoouYmYxh5TtOo37nsS10RgPRO+Zn6hCdhGgfvNJfXDVH7dFcU
 EMJqys71IK1PAsjh3m0s0i3dhMUis7I9IkWQhN5KAyz/ygUBWZvNaVI9YRZPXVpEIgKd
 pKsgXGPAA1kC1HM3d+BI4yGd0L3phPjN5UYx4g90rX3Cx3lY6A+G2idi7l9RddsgPqG2
 kIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738772700; x=1739377500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q7wOXF7igTsLGjZyBPEEbIlcgTqW4B1eKUWYBROZ8to=;
 b=Ga4y0wsxcns9R58Dl3A9M4QgagwOTOD7QcmYtacua8E7ja/JyhTEknafOVtCP/vXNd
 yW0mGsTPYR/CwnfH9Twb9Ds2AKxmZeXFw/Fu/YzL7IdB7RqHn9aQQmrk2gnATY5xxkaP
 UDM1NEyC4h3TMTggF1y9Oh77MyN5gLRxpi0tEtdGHj2ynvsNhsMfOJySl0S5L5o0SCEE
 +nhtHywtBHfeA5Y+3hhLaVshnuvoD7rw9B4him5ic9y1bRxQrXBg+WESmYTXQUITrshm
 l/jI4c5SGV8ltBKP9ECP+MYtmHK6KvEzkYspg9h7hhlFPuFcrH8lhk1FK3sRtdVuTTxd
 8S2A==
X-Gm-Message-State: AOJu0YwAUbQGXkH3zkElLjQF+r+Ihebu362Fe26EMWVYddI40lehZtt9
 kG+iV3rAtIyH06qwnOYkhCsNROJzudOknw3Hq7XVVcBpGiMVC9h79bvzdIesAAdw24FaGOG+IAn
 u
X-Gm-Gg: ASbGncsecvOyu0fnrh0OSaoWmgnWHFyqllZ9X/8xSrnY42QyDRT05NXQMGnfz0zh0O4
 bzfvcFApOyxEvtAf+iN0fMAjPpfGGNyaMJQqepZw04X8Ls98hS9YFrT/cPn3OXCsf6yS8+Ku70P
 g3kQIz5aMiNxB1kNY/TwUGjEi+Hm7O7PtZ2RliF/+BkG+i6kPDKnuE6q6MvvPUaDKGUxvETmjS5
 aRqZj/MzfziwxJW4ZWCeMo6Xlrzo0CnL/W/Yga+iwf+astw9SAGuonqxysGcj20MzXF23pAY2ed
 VbqRKKw2ENUKJNBcVsnmtdk/NoqfJmvtrTc7Y8kImhgM/8ppmDncSFdtU1xZvmskgcM8
X-Google-Smtp-Source: AGHT+IEEFPwSpbQ26Ou1BhDk1Wr74oAOfTiy9I5uUNOJyYwrR0HZ0lpQjDQUHgHsYK0VLVCr5xvdCg==
X-Received: by 2002:a17:90b:52c7:b0:2f8:49ad:4079 with SMTP id
 98e67ed59e1d1-2f9e0753715mr4830982a91.6.1738772699876; 
 Wed, 05 Feb 2025 08:24:59 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9c314b64fsm2138965a91.1.2025.02.05.08.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:24:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 00/19] minor fixes from PVS studio bug list
Date: Wed,  5 Feb 2025 08:23:01 -0800
Message-ID: <20250205162448.161161-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20241115060738.313190-1-stephen@networkplumber.org>
References: <20241115060738.313190-1-stephen@networkplumber.org>
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

More bug fixes from PVS studio bug reports.
And one other fix to ptpclient.

Stephen Hemminger (19):
  common/cnxk: remove duplicate condition
  net/cpfl: avoid calling log (printf) with null
  raw/cnxk_gpio: fix file descriptor leak
  net/ntnic: remove dead code
  net/i40e: remove duplicate code
  eal: fix out of bounds access in devargs
  net/qede: fix missing debug string
  examples/ptpclient: replace rte_memcpy with assignment
  examples/ptpclient: fix self memcmp
  net/octeon_ep: remove duplicate code
  net/hinic: fix flow type bitmask overflow
  crypto/dpaa2_sec: fix bitmask truncation
  crypto/dpaa_sec: fix bitmask truncation
  event/dpaa: fix bitmask truncation
  net/dpaa: fix bitmask truncation
  net/dpaa2: fix bitmask truncation
  net/qede: don't use same loop variable twice
  examples/l3fwd: fix operator precedence bugs
  common/cnxk: fix null ptr check

v3 - rebase; Intel drivers moved

Stephen Hemminger (19):
  common/cnxk: remove duplicate condition
  net/cpfl: avoid calling log (printf) with null
  raw/cnxk_gpio: fix file descriptor leak
  net/ntnic: remove dead code
  net/i40e: remove duplicate code
  eal: fix out of bounds access in devargs
  net/qede: fix missing debug string
  examples/ptpclient: replace rte_memcpy with assignment
  examples/ptpclient: fix self memcmp
  net/octeon_ep: remove duplicate code
  net/hinic: fix flow type bitmask overflow
  crypto/dpaa2_sec: fix bitmask truncation
  crypto/dpaa_sec: fix bitmask truncation
  event/dpaa: fix bitmask truncation
  net/dpaa: fix bitmask truncation
  net/dpaa2: fix bitmask truncation
  net/qede: don't use same loop variable twice
  examples/l3fwd: fix operator precedence bugs
  common/cnxk: fix null ptr check

 drivers/common/cnxk/cnxk_security.c         | 16 ++++++++------
 drivers/common/cnxk/roc_bphy_cgx.c          | 12 +++++------
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c |  8 +++----
 drivers/crypto/dpaa_sec/dpaa_sec.c          |  7 +++---
 drivers/event/dpaa/dpaa_eventdev.c          | 10 ++++-----
 drivers/net/dpaa/dpaa_rxtx.c                |  7 +++---
 drivers/net/dpaa2/dpaa2_rxtx.c              |  6 +++---
 drivers/net/hinic/hinic_pmd_flow.c          | 14 ++++++------
 drivers/net/intel/cpfl/cpfl_ethdev.c        |  2 +-
 drivers/net/intel/i40e/i40e_fdir.c          | 10 ++++-----
 drivers/net/ntnic/ntnic_ethdev.c            |  8 -------
 drivers/net/octeon_ep/otx_ep_ethdev.c       |  9 ++------
 drivers/net/qede/base/ecore_dcbx.c          |  8 +++----
 drivers/net/qede/qede_debug.c               |  5 +++++
 drivers/raw/cnxk_gpio/cnxk_gpio_selftest.c  | 24 +++++++++++++--------
 examples/l3fwd-power/main.c                 |  4 ++--
 examples/l3fwd/main.c                       |  5 +++--
 examples/ptpclient/ptpclient.c              | 10 +++------
 lib/eal/common/eal_common_devargs.c         |  2 +-
 19 files changed, 81 insertions(+), 86 deletions(-)

-- 
2.47.2

