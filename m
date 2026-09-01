Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58830C61DD3
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:32:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D85240B99;
	Tue,  1 Sep 2026 22:32:29 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id A895040682
 for <dev@dpdk.org>; Tue,  1 Sep 2026 22:32:27 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-8568e3ed034so254186b3a.0
 for <dev@dpdk.org>; Tue, 01 Sep 2026 13:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788294746;
 x=1788899546; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZZjf8iXkxA9Dee6QAd7lRN2g3jpsfEA3i1G2+s0FCcs=;
 b=bv3ZbT9NgQUE5kTDj6ntf+Da5BShP5vqJsotdSdtq+atyiaIoZcvPI3Hi6ktsN5nx2
 pdtjjiBzzoVSSSapsoZwE4/dZq9JVV4uhPgcqtzjUeX1pcZ8allPaq0mDGYf5BieX2J0
 ilCBlp/gahqQ2p1TClZPHMO0GLXzeyV/9w4qGcERlFRmGulInhLX72JNf7ecIUMUJ55p
 4LCdfLvayb1NtHV0MEZxqRxvJNnpytVSXUABMBeFb2thVUm6HGOpFSGz+6ZNitumKo/+
 WrfA2+LcPkbb1FH/zJPpUZsO/aqRs7nliKaYQXVlk52DqyX7lJ5/LzFKoAHZdfzbgyot
 wEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294746; x=1788899546;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZZjf8iXkxA9Dee6QAd7lRN2g3jpsfEA3i1G2+s0FCcs=;
 b=Aj+aXui229ivfqcfGuuW5UqSLLBdDCZLg9UswWgIpYFsEhKMlsSFT83TC7kB0Denxc
 I72PNbRb21COyFyNooW3gpMMdy+GbWLOyhcFHOFcQQj1y0qXfk5tEiCaxTCC0T4gjGiX
 2IlSMiK8ymxtFJdMgmGOsAsgx1e5pSTrsSiBPkRRCUqOyZlDVaHSHxfeYFiabXxBYSCE
 4ysy3CiJTykhKx36gCyOJ8lec0+jqZe88Wynzeoi5xSk137NgsKJMnlltvZ/e/cBgb7x
 vBguDb1n519213O25ZLN7MSTMrr85OXUR6S8ePthdrB5ubr6aklzN1UQ7s3UH9fmpsqS
 rZMw==
X-Gm-Message-State: AFuF++m0l6eR5KJ5g6ths7AB4djOB2wM60d4nObDEpOZWQMt8tDNCLnf
 Q1Dm99EmyQ//Ng7CtywhDt6Pp7s+TeDSPEuaY2OXOJ4FJZwiYLfn6i/JXrk/FfJhzGICgjHrCaz
 NvmFm
X-Gm-Gg: AR+sD11LcUtHbsYZDPn8owgN8qZvCUKdiMLmt9oLt3wrNgmPOzxm/aYtN2PZ/u1cGgg
 BXNMqE9tmWJcdNyqV9hM6/L0TFsSvGAfvMmGufEynQ6V/z3F9z+aAxIS1bQNLkiElAXX/YjPNtA
 AXN1o7ntv3l0V35PcD2GxcDHnq+ls7SBa8Sgml/JSuYLuccNk4YRVfOA30+VFYyWObi236Rq/BH
 tDgCd6kW4muko8TTvY4SeP/MVpth1/t0efraBRC/A4wCkHOS+bCwOIUaorx/or/lZUP908kavGr
 Qp9GhUy7kOgulwRWLRCF/Ir97G/meGB1nwMHVC6WXmInOqat6dtOkUul7ZcqSVjPyQSpi0OajDz
 AB3xvP9KsVfCizBMfzmPCEf4KlOdEYlgnwBdeKWv2XIJsMBrmhfewLSJJ/DHvafYGtG1s3xUPze
 +QDv3L5yoiJ2RK+zrjZdRvH2Ohp8V9cUgOop/3zpUbxoxkk6z4DqWn9E4YMnGFRnKxbuUKQHqA4
 6U7ZCWSjgu/qjfbW5MoXhr4HwQ=
X-Received: by 2002:a05:6a00:408c:b0:848:2c5e:305e with SMTP id
 d2e1a72fcca58-85ed25e249dmr657939b3a.6.1788294745694; 
 Tue, 01 Sep 2026 13:32:25 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc0bffbc1sm323980b3a.48.2026.09.01.13.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:32:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 00/22] ethdev: convert experimental symbols etc
Date: Tue,  1 Sep 2026 13:22:59 -0700
Message-ID: <20260901203217.1485915-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The DPDK policy is that experimental status should be short term
with the expectation that it will be removed after one or two releases.
A large part of the ethdev API has been left marked experimental long past that point.
Several API's have stayed experimental as far back as 17.11.
This series promotes 119 ethdev symbols introduced in 24.11 or earlier.
It also cleans up comments  warnings on structures and inline functions.

The trace point symbols are left experimental on purpose;
trace infrastructure is intended to stay unstable.

Stephen Hemminger (22):
  ethdev: promote meter API to stable
  ethdev: promote module EEPROM API to stable
  ethdev: promote rte_flow_conv to stable
  ethdev: promote hairpin API to stable
  ethdev: promote read clock and flow dump to stable
  ethdev: promote FEC API to stable
  ethdev: promote link speed helpers to stable
  ethdev: promote flow tunnel offload API to stable
  ethdev: promote aged flow query to stable
  ethdev: promote indirect action API to stable
  ethdev: promote asynchronous flow API to stable
  ethdev: promote flex item API to stable
  ethdev: promote remaining aged flow helpers to stable
  ethdev: promote congestion management API to stable
  ethdev: promote IP reassembly offload API to stable
  ethdev: promote per-queue priority flow control to stable
  ethdev: promote device info and dump helpers to stable
  ethdev: promote speed lanes API to stable
  ethdev: promote queue helpers and aggregated ports to stable
  ethdev: promote remaining aged symbols to stable
  ethdev: promote fast path inline helpers to stable
  ethdev: promote experimental structures to stable

 doc/guides/rel_notes/release_26_11.rst |  67 +++++
 lib/ethdev/rte_ethdev.c                |  84 +++---
 lib/ethdev/rte_ethdev.h                | 228 ---------------
 lib/ethdev/rte_ethdev_cman.c           |   8 +-
 lib/ethdev/rte_flow.c                  | 102 +++----
 lib/ethdev/rte_flow.h                  | 370 +------------------------
 lib/ethdev/rte_mtr.c                   |  42 +--
 lib/ethdev/rte_mtr.h                   |  24 --
 lib/ethdev/rte_tm.c                    |   2 +-
 lib/ethdev/rte_tm.h                    |   1 -
 10 files changed, 189 insertions(+), 739 deletions(-)

-- 
2.53.0

