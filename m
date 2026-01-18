Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0918EC9830C
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:13:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74E5040270;
	Sun, 18 Jan 2026 20:13:30 +0100 (CET)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47]) by mails.dpdk.org (Postfix) with ESMTP id 4C6CE4026D
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:13:29 +0100 (CET)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-b872de50c91so561468566b.2
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763609;
 x=1769368409; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XIye+jP6kESdh7AECLRFfBIZi/Nftf8wCJ5qhLZ2lfI=;
 b=nmSpxlSsmtsZNp/F6BqsOj8H4fcZasbYPyQpvFTtf91tbUnWu1cD9rfn44fKbRPb8G
 90a0GyzJJc1NIjhcJ+3Aw0xxnu1K8oR4el3M0MNmt4zwI360zfB9xZ+cbE2kP9E1X1L/
 cq3DoeCI2YKk1FgME2LqRuqTQAWtEdoVlBboL/BfuA39c5wI7+poy3c7V1kZw0dXHA4g
 UcN093Xje3TSPo/m9ygBOmyedtZ/42kstieEpYD9gqVNQWGhTz+7IcJftRajt5TtvtNi
 4a9JJlWtBJLrD9YBTPr1giXOMRCH/2eBAzpMOhpUFvNNeEdQ0QOt9DiCTZeQOWqsHJIx
 kuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763609; x=1769368409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XIye+jP6kESdh7AECLRFfBIZi/Nftf8wCJ5qhLZ2lfI=;
 b=XdmYN/7C3WE99sftrqD5EFlDub7kxwoD5BmVOMdUI0m5W4YoffwJHiupe1NPnxxWAD
 XBjsOqk9HeTCOIqLJ/V0t4Un+nZd9WMf58h/5vvsfffas7YzG6gtECYkMwc81xUB653a
 MMtPPKxQO6eJ1JUAbfRw3XWAYt8Hc+4kSM4+u6o6WShota3F29mMFPFPzGszve0DG9uT
 8CrbpK/OUUqSGdGarDJgCYuO/2gCFMFi3uxx0QBjqY31mRevyCGbMVpsyiyaM2aOzuMH
 DG7ux46lwhBQl8o8CXyfycF7zNdxwvoEKhCykNlqy6DnC8OGMSMWIy3397IdBXltt/Vg
 RxRA==
X-Gm-Message-State: AOJu0Yyn5T0oQvRI/+ctbKV3FFXWITnkk7jFvZlqBcPqjkPACkhZ6ul1
 OvSAdTPMYjBL7d6+gm8N/kbGeCXqjjfS9G42sPfb1edutAsMoESHiMC6f3t9WWu0+ZTe1rb4PqO
 M1bGt
X-Gm-Gg: AY/fxX7DniforDEPI3k2zEvDY/716h3lG3D/+f4fUed8A6SpHkwFWfDRGUqE6RcmWoA
 dtTfjutXGJPeM0eeopSOXpbYCJ3t0RaWrbNDnrQVZ8HabMYqSRfITIQNqdNM7Vw3ekV9pfzYU1x
 KZcIGOmM5GR+GQU/ko86bBAjVDFYv688mPJ9ZY47JvzCd979B5zLKjxecK0uEP7N/UoC5bL8C4q
 T6ckbSVmnLk47N+L0f7IS/sb6NSgMM5hb+/nGCNHFKI6u1PnNu3CqSyQPru2tYjPIyvOHaCBSxs
 RA2BZgzSFOaW3KMaFYPGHzKeIgHT8IyC1igF/HbNdla4p12QiUYNejFAXj7LPbedhGnO/idzP5U
 VkILmIy6Ay9OV9PGowsP40H9Kw1b2GZipSmcPuxL0BLI9dj24QG+kEJHzhTNi8HHOsSj5I15JSV
 HByLKeghUZKS/IgyiFh91KJjLishLoy2O/c1t72P8oygmfkcNGBw==
X-Received: by 2002:a17:907:1ca5:b0:b7a:2ba7:197e with SMTP id
 a640c23a62f3a-b8792e235a3mr785100766b.29.1768763608563; 
 Sun, 18 Jan 2026 11:13:28 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:13:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 00/54] doc: programmers guide corrections
Date: Sun, 18 Jan 2026 11:10:03 -0800
Message-ID: <20260118191323.241013-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20240513155911.31872-1-nandinipersad361@gmail.com>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
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

This is a revision of earlier corrections to the programmers guide.
At this point, it is a collaborative work of myself (Stephen), the
technical writer (Nandini) and AI (Claude).

This patch series contains 54 patches that improves the
quality and clarity of DPDK programmer guide documentation. The changes
address grammar errors, typos, awkward phrasing, and consistency issues
across multiple documentation files.

The improvements include:

* Grammar corrections (subject-verb agreement, verb tenses, article usage)
* Typo fixes (field names, function names, general spelling)
* Clarity improvements (rephrasing awkward or unclear sentences)
* Consistency improvements (terminology, formatting)
* Minor whitespace and formatting corrections

Files affected include documentation for:
- argparse library
- service cores
- vhost library
- toeplitz hash
- writing efficient code
- Various other programmer guides

Stephen Hemminger (54):
  doc: correct grammar and typos in argparse library guide
  doc: correct grammar in service cores guide
  doc: correct grammar and errors in trace library guide
  doc: correct typos in log library guide
  doc: correct errors in command-line library guide
  doc: correct errors in trace library guide
  doc: correct errors in stack library guide
  doc: correct errors in RCU library guide
  doc: correct grammar and formatting in ASan guide
  doc: correct grammar and typos in bbdev guide
  doc: correct grammar and formatting in bpf lib guide
  doc: correct grammar and typos in meson build guide
  doc: correct grammar and typos in cryptodev guide
  doc: correct grammar and formatting in compressdev guide
  doc: correct grammar in dmadev guide
  doc: correct grammar in efd guide
  doc: correct grammar in EAL guide
  doc: correct double space in FIB guide
  doc: correct grammar in GRO guide
  doc: correct grammar in GSO guide
  doc: correct typos and grammar in graph guide
  doc: correct grammar in hash guide
  doc: correct grammar and typos in IP fragment guide
  doc: correct double spaces in IPsec guide
  doc: correct grammar in lcore variables guide
  doc: correct typo in link bonding guide
  doc: correct grammar in LTO guide
  doc: correct grammar in LPM guide
  doc: correct grammar and typo in LPM6 guide
  doc: correct grammar in introduction
  doc: correct grammar in mbuf library guide
  doc: correct grammar in membership library guide
  doc: correct errors in mempool library guide
  doc: correct style in meson unit tests guide
  doc: correct errors in metrics library guide
  doc: correct grammar in mldev library guide
  doc: correct grammar in multi-process guide
  doc: correct grammar in overview
  doc: correct grammar in ACL library guide
  doc: correct typos in packet distributor guide
  doc: correct grammar in packet framework guide
  doc: correct grammar in PDCP library guide
  doc: correct grammar in pdump library guide
  doc: correct typos in power management guide
  doc: correct grammar in profiling guide
  doc: correct errors in regexdev guide
  doc: correct grammar in reorder library guide
  doc: correct whitespace in RIB library guide
  doc: correct incomplete sentence in ring library guide
  doc: correct grammar in security library guide
  doc: correct hyphenation in thread safety guide
  doc: correct errors in toeplitz hash library guide
  doc: correct errors in vhost library guide
  doc: correct whitespace in efficient code guide

 doc/guides/prog_guide/argparse_lib.rst        |  24 +--
 doc/guides/prog_guide/asan.rst                |  14 +-
 doc/guides/prog_guide/bbdev.rst               |   6 +-
 doc/guides/prog_guide/bpf_lib.rst             |  46 +++++-
 doc/guides/prog_guide/build-sdk-meson.rst     |  10 +-
 doc/guides/prog_guide/cmdline.rst             |  42 ++---
 doc/guides/prog_guide/compressdev.rst         |  10 +-
 doc/guides/prog_guide/cryptodev_lib.rst       |  21 +--
 doc/guides/prog_guide/dmadev.rst              |   6 +-
 doc/guides/prog_guide/efd_lib.rst             |   8 +-
 .../prog_guide/env_abstraction_layer.rst      |   4 +-
 doc/guides/prog_guide/fib_lib.rst             |   2 +-
 .../generic_receive_offload_lib.rst           |  20 +--
 .../generic_segmentation_offload_lib.rst      |   2 +-
 doc/guides/prog_guide/graph_lib.rst           |  16 +-
 doc/guides/prog_guide/hash_lib.rst            |   4 +-
 doc/guides/prog_guide/intro.rst               |   4 +-
 .../prog_guide/ip_fragment_reassembly_lib.rst |  12 +-
 doc/guides/prog_guide/ipsec_lib.rst           |   4 +-
 doc/guides/prog_guide/lcore_var.rst           |   2 +-
 .../link_bonding_poll_mode_drv_lib.rst        |   2 +-
 doc/guides/prog_guide/log_lib.rst             |  32 ++--
 doc/guides/prog_guide/lpm6_lib.rst            |   4 +-
 doc/guides/prog_guide/lpm_lib.rst             |   2 +-
 doc/guides/prog_guide/lto.rst                 |   2 +-
 doc/guides/prog_guide/mbuf_lib.rst            |  26 ++--
 doc/guides/prog_guide/member_lib.rst          |  26 ++--
 doc/guides/prog_guide/mempool_lib.rst         |   8 +-
 doc/guides/prog_guide/meson_ut.rst            |  12 +-
 doc/guides/prog_guide/metrics_lib.rst         |  26 ++--
 doc/guides/prog_guide/mldev.rst               |  20 +--
 doc/guides/prog_guide/multi_proc_support.rst  |  28 ++--
 doc/guides/prog_guide/overview.rst            |  10 +-
 .../prog_guide/packet_classif_access_ctrl.rst |  10 +-
 doc/guides/prog_guide/packet_distrib_lib.rst  |   6 +-
 doc/guides/prog_guide/packet_framework.rst    |   6 +-
 doc/guides/prog_guide/pdcp_lib.rst            |  24 +--
 doc/guides/prog_guide/pdump_lib.rst           |   6 +-
 doc/guides/prog_guide/power_man.rst           |   8 +-
 doc/guides/prog_guide/profile_app.rst         |   2 +-
 doc/guides/prog_guide/rcu_lib.rst             | 143 +++++++++++-------
 doc/guides/prog_guide/regexdev.rst            |  24 +--
 doc/guides/prog_guide/reorder_lib.rst         |   4 +-
 doc/guides/prog_guide/rib_lib.rst             |   2 +-
 doc/guides/prog_guide/ring_lib.rst            |   2 +-
 doc/guides/prog_guide/rte_security.rst        |   4 +-
 doc/guides/prog_guide/service_cores.rst       |  30 ++--
 doc/guides/prog_guide/stack_lib.rst           |  32 ++--
 doc/guides/prog_guide/thread_safety.rst       |   2 +-
 doc/guides/prog_guide/toeplitz_hash_lib.rst   |   4 +-
 doc/guides/prog_guide/trace_lib.rst           | 118 +++++++--------
 doc/guides/prog_guide/vhost_lib.rst           |  22 +--
 .../prog_guide/writing_efficient_code.rst     |   2 +-
 53 files changed, 488 insertions(+), 418 deletions(-)

-- 
2.51.0

