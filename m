Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FD5D2CE0B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 02:29:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C60E4025F;
	Fri,  5 Dec 2025 03:29:54 +0100 (CET)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51]) by mails.dpdk.org (Postfix) with ESMTP id F0F2C40156
 for <dev@dpdk.org>; Fri,  5 Dec 2025 03:29:52 +0100 (CET)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-88244d1559eso28964016d6.0
 for <dev@dpdk.org>; Thu, 04 Dec 2025 18:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764901792;
 x=1765506592; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4gsqn4zAoucsNVwQeuGzXNcjaDv+RFliNRJNILuPM4g=;
 b=XPuuXSP97qivGW02G1J8+/rz+a5P+Yq5dIMoi3WkLgZdNpS6TzLMvcim/3nCknUlea
 UilepTIkm0FBxObyS0Y/xRY17SRj1XHgBHEDBCc3K6FMCBHWCNvexQT2cm9oaF8AUf/d
 J9wENjeDk/YaolpxY2qRhpLfSMJiFfXE/JrOTGRs9KpPHT+CSNNSGX56lS78ScQHnjk+
 mPJh1tebjNrjV0Se+Yy/Nh4coOMIVTtnXskvG6iuKct6ORvUy33KOFcOsOc21hWu2ukD
 pjN9qJqf5Nnad55ffa0ELks0X2YEziPA5IvaJqMoR6Pls+Ql0eRZj6Ym4UIwIz5kZozr
 P2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764901792; x=1765506592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4gsqn4zAoucsNVwQeuGzXNcjaDv+RFliNRJNILuPM4g=;
 b=lMDZFM7CgtMsHd7Y2ma9pcZv07CJqQx2ggVzquNEyA3sMlvTeyyr0WiaZZrzmJsaKS
 g+HewW7RO/4m/o6iRNhjS8dPrvFAQ402s1My4WvNXuj7QJP33Ll7nYp8b7LxMAuewUym
 HrxOPL125j2U/cW0OnNEtWjM53TyQe/cQLgIJKMcYRIxgMrBwBJMJXEM/tZfmI/ylUCU
 2OtlPRrzgydEaZFzDgs5JKburgmRWQZ9eXP6VmYCATE5Q+ryZL2Nhq0L3LzQNpsDJXA7
 kT2PQQ+40NO4OIv5nDbxNbYfkL9bCTGkjl6mUBpOKVPZkq14ggHEaUIkHAy2dsi/vuSy
 t/Kg==
X-Gm-Message-State: AOJu0Yy3j1bZ+vmoYzo1/C6+1SEcsf0CnGUm+CBtIp+cZpGZm2fpnusJ
 Wy5xUJTKe5zorzD89YriNv6SXPs8hxqrSCYfnONVtHWfPSI+ZXLdUIcl+VyY9//jRUxh1ElXQGO
 VWQN3
X-Gm-Gg: ASbGncuHgmyzZO8YeZtoSx1l9iN3x4DWwQau+1EWQFwBBKBYQQtATY3OsTn4Y5s5SQI
 HcAPLXNSX5ko1GDWMJx7CQeUKU2YW0zd1EoeQnoKMT7O8SG43dDm7FckWDWL1WdUmI6ib/4fJ9o
 lGaAxm3XbQqeOFnBmjXqJPh0NQ77FSZQsAdwmMrBkOS1usXHx1v34vF4iH6kQsJ98p08ezKgWAf
 E/1EEIaPJPoqj1ud3iEUK0o45US7fJZbm7AE+b4Jk1mb4uMgfS2HG+ACXoNn6ZR4uQWOgz5+JT5
 TBxDSjWQ12zS2fCPYTwWF3el5IdZK3gDYrxIgrk4CnM+tydZN6X1d8L50DSPo8yaZEnrB85Rxbk
 w5PYEOCQ3HgDd18C15PfRUT2ggiZ4ZzF6UStHRatcMIynUn/pPRzze2c4H71POyd5e5EL9W2qw2
 1wTu1L24/ASobjfeUyCpfGBJjyZYMngyWWp6Pal6aGpVc8VDjyKimS4Qsh543E
X-Google-Smtp-Source: AGHT+IHLCVlaGphPgjmrZiLQJAssAhTD+jlz/kHgcWTXle9Otxj3SEulurX2xvUdglmXFkgNXqXUbw==
X-Received: by 2002:a05:622a:8d14:b0:4f0:31bd:2aaa with SMTP id
 d75a77b69052e-4f031bd2c65mr18511181cf.4.1764901792098; 
 Thu, 04 Dec 2025 18:29:52 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f02b7bd0b4sm15655861cf.22.2025.12.04.18.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 18:29:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC v2 00/14] lib: check for string overflow
Date: Thu,  4 Dec 2025 18:28:09 -0800
Message-ID: <20251205022948.327743-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251202172626.283094-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
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

First draft of changes to fix format overflow issues in EAL and
related libraries. This does introduce more restrictions on
file prefix and some parameters because of more checking
for overflow.

Stephen Hemminger (14):
  eal: use C library to parse filesystem table
  test: avoid long hash names
  lpm: restrict name size
  hash: avoid possible ring name overflow
  graph: avoid overflowing comment buffer
  eal: warn if thread name is truncated
  eal: avoid format overflow when handling addresses
  ethdev: avoid possible overflow in xstat names
  vhost: check for overflow in xstat name
  efd: avoid overflowing ring name
  eal: add check for sysfs path overflow
  eal: limit maximum runtime directory and socket paths
  eal: check for hugefile path overflow
  lib: enable format overflow warnings

 app/test/test_hash.c               | 29 +++++++----
 lib/eal/common/eal_common_config.c |  6 ++-
 lib/eal/common/eal_common_memory.c |  2 +-
 lib/eal/common/eal_common_proc.c   | 83 +++++++++++++++++++-----------
 lib/eal/common/eal_filesystem.h    | 16 ++++--
 lib/eal/linux/eal.c                |  6 ++-
 lib/eal/linux/eal_hugepage_info.c  | 64 +++++++++--------------
 lib/eal/linux/eal_memalloc.c       | 11 +++-
 lib/eal/linux/eal_memory.c         |  9 +++-
 lib/efd/rte_efd.c                  | 15 +++++-
 lib/ethdev/rte_ethdev.c            | 28 +++++++---
 lib/graph/graph_pcap.c             |  9 ++--
 lib/hash/rte_cuckoo_hash.c         | 21 +++++---
 lib/hash/rte_hash.h                |  6 ++-
 lib/lpm/rte_lpm.h                  |  2 +-
 lib/meson.build                    |  4 --
 lib/vhost/vhost.c                  | 14 +++--
 17 files changed, 202 insertions(+), 123 deletions(-)

-- 
2.51.0

