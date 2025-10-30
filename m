Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61622CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 17:37:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6417C4026F;
	Thu, 30 Oct 2025 18:37:38 +0100 (CET)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com
 [209.85.160.46]) by mails.dpdk.org (Postfix) with ESMTP id 5F9B140150
 for <dev@dpdk.org>; Thu, 30 Oct 2025 18:37:37 +0100 (CET)
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-3c97709a4fbso546892fac.0
 for <dev@dpdk.org>; Thu, 30 Oct 2025 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761845856;
 x=1762450656; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5N57LTuOoIpSWO+tnnuYwX6QGyLGNTkCDvPCKnGUoUA=;
 b=REfVV0CQMBUDqsSMoJK0I4r4hgC5sUSsoqPmNmWhLeuPygZPUxjrxB7WSmGEsdbuu1
 U5jW2+n0XtN00oCC4WCCXnm4BxrbYOplf8YhilfFaLDuNQByXbhyUdDKYecU9llAtoFY
 SAx4Y0YG7bvJX4cc9HBPNmE4f03jtFXMlgT2aMD2fyhNbmHpEMpOoMBzrThdD676wI7T
 EfyjeB7r+S/PSoxo53kgPP6lKncPQkG0PBvXDfwaPnSyvbbCtdGpQdC9JfnXtNN7IHdM
 7clKajzV4Ll3jD0o5yhAMJCYWIVz9piytVs4kE74LlM0YvsRz9aUElCppvN7fcy1BTfK
 FlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761845856; x=1762450656;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5N57LTuOoIpSWO+tnnuYwX6QGyLGNTkCDvPCKnGUoUA=;
 b=GHXtZvRC9GjSccO7DMXeVYqGxh03oo7C+6A0EDpL50gMsLg2oP0d2St1XxYCoCu0RX
 QOxW9bpCgs+WoqbE1m2YJuZ+3zzb7qggHWaRs3/hwlUzocTXoQbG1cEsZ7m66Uz4zmU9
 uq4Q4L0q+mIHpTcxpZZBQR/3RHb8Yq6TRfDIF1otJKHep7ufRD/Ki3YtQSoSMqHerF0/
 MIvI3tKM4GH9QBSVa+7N6c/iDjg7r++Ie41ESxk+jNt6OojNxf9TpBLf2OE9+DP8VkM4
 R/GyrqYOLyDu841v7by3KOtt/l10WasmVls1GAFM8aPP0vnqXk9Y2rLUjoXNA3xER5AJ
 bsyQ==
X-Gm-Message-State: AOJu0YxnnwUjXG45fLbPvQzQBSzcJc+/KjG5miGYhQn9Sv3Pa94iQmwD
 2oQmqjaYojnDH6yJj4CA35wFAg9GNEG6S5uwH4FRJTyAczRFuIL2ff99ZxUKCyeCyU5V/VGldso
 yoZ8G
X-Gm-Gg: ASbGncunhB8stX5m3r1nOg+HVjX3xVXspmdzF6DzU6IcIk8knxxg5hmO+dQEbd62ohe
 TxxLTwWUfYg9fmj51DyI44A6Ozg4txCmPdQXV5BuPHGALPwP0S/eKNn7jdRlns/rVTWuaIKjfD/
 uYJBf7Yb43kdbRiDioMx78NJIi49pobN2yYgjjELpE6Le+KUGAvpD+TQda0Yqg/UETCq2f09kQM
 e8pbMflp1QSfxC8TOtOjFeNypLUTnjt7nAShrog8NKm4shQnDmqreeuR7DFcsfmh7PZiq6dZ4Eb
 IiBo5VzEqC0pLXqj6EFZVWFLIiiWl7fG9PiPYwKlyZgWiDfs3+x8ezjPZtUa3mcZc4mJMW+w8D9
 4ju74sjR+axQn8ZubJJhMXGU0JuOcNjKuYIaBqn74wzMIbVIKZem8f4gXoJsbCZtWGNVp5+7Wdl
 7Xi63Ini2dJLe8HmhYEXw1wwXh+vd6kztxMQlfijKbcWtqTH0sjw==
X-Google-Smtp-Source: AGHT+IHXnvXCFYS2xo2Pax+07tz2dl5SjXaLh+oSTtRuDc4WCs+Dxt1L2Lnv/W5pnkieT2Mvv6k3OQ==
X-Received: by 2002:a05:6870:2493:b0:3d2:ed64:970c with SMTP id
 586e51a60fabf-3daca31645emr275550fac.3.1761845856306; 
 Thu, 30 Oct 2025 10:37:36 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3d1e20f1396sm6057278fac.3.2025.10.30.10.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 10:37:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/5] bpf enhancements
Date: Thu, 30 Oct 2025 10:34:08 -0700
Message-ID: <20251030173732.246435-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

This is a series of fixes and tests for BPF functionality.
The new tests for Tx and Rx filtering require the infrastructure
to build a bpf program (clang) and the tool to convert object
file to header (xxd). If missing the test will get skipped.

Stephen Hemminger (5):
  bpf: add allocation annotations to functions
  bpf: use rte_pktmbuf_free_bulk
  bpf: add a test for BPF ELF load
  bpf: add test for rx and tx filtering
  bpf: remove use of vla

 app/test/bpf/meson.build       |  53 ++++
 app/test/bpf/test_bpf_filter.c |  35 +++
 app/test/bpf/test_bpf_load.c   |  60 +++++
 app/test/meson.build           |   2 +
 app/test/test_bpf.c            | 426 +++++++++++++++++++++++++++++++++
 lib/bpf/bpf_pkt.c              |  84 ++++---
 lib/bpf/meson.build            |   2 -
 lib/bpf/rte_bpf.h              |  11 +-
 8 files changed, 632 insertions(+), 41 deletions(-)
 create mode 100644 app/test/bpf/meson.build
 create mode 100644 app/test/bpf/test_bpf_filter.c
 create mode 100644 app/test/bpf/test_bpf_load.c

-- 
2.51.0

