Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3719A606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ClMWjbeD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 995D840268;
	Fri, 23 Oct 2026 18:51:28 +0200 (CEST)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTP id 4374840265
 for <dev@dpdk.org>; Fri, 23 Oct 2026 18:51:27 +0200 (CEST)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-398a4dcf289so629269a91.2
 for <dev@dpdk.org>; Fri, 23 Oct 2026 09:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792774286; x=1793379086;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=q7NwcKZkai0YaJIB1XptyisZO89aB2K125MyYtlsCzI=;
 b=ZE0bs83KE1Y7iykL0PCTc1GVouIXf435IK1KoOuO3H1fThR86CA1QcqMUNaYxKO6A7
 JDXLuRU/cVFO9Gf4gEmQS+B10dnZr37Rq05vU0H3M+7JHzhyEJLlhl8Tk1vmnc1zZOKj
 6Pd0Swx7oG/XdDTn/XA5v3vdshikSDOijemOy6jsYp65+JIlnbc0daHaxktsz5X21pyP
 GhmhyFQHGbAoXZwSYQ4BLRyAD10YXgE2C4HoatY9VKqXG3xaLVp1SMSG6Auv2h9CoQwD
 qi88re/rkmMbMGlwF+GgPsmJsX9bdKc7+qwrpsy9DFRfWJs+GdqO2YqhK+pshDlPq3WX
 B2Ew==
X-Gm-Message-State: AFq9FYL6PslmJqbSfZgt9v2IRAv4A3iM859VPJYlbaRRvXx92mPij90a
 GO4YFfXYoASuqhtaj1XSqw3tkJl9I6x3m0r1EdwKBTMVBPgH0IYNYSGbruem7U+y54Seb9v0/VW
 vSyxIeYAyqpE7RhxriabEU0pTZYxzx859WNo6cE1OV4AQfYEtDkZL35XIWnwxAFS6i3z8/eeHjJ
 mAbK1eojG+kDW4WV9ERGsJnvjvVxB4Dp7qB8bg/vQLhNuIV+bl4PsXjLbkUs0uoHeDQNpX+ogds
 uFEwij+S6Nf
X-Gm-Gg: AYBFou1DPSmDm2UDeOjQXfMSMeXNRnNx7uiH3WtEgFi716ytGb3BWjfWfNK19wOOUMd
 Lsa423+pE/3Ixc/8SlrontZ7tO9N25lbd3W+rhv4deVloVxUxRf1cU9RgFIMsWP2/5UeTSL2j6+
 za4sxQb9ics1InSDQBslv2YCkQgFgLVc6C553czX+BDc1Q1kks07BDWyCr7IGO6YStgwh/x/cev
 WnOnE4A8KgmbaqjPW+Ybbw8GrqkFfZBxc/GLcNfM2g6gg8QkJrBE/3OG6zmh7qxhwMIe2TOu8eZ
 /wE8atZubHz9O4HXmNRU0d1H39ovMMHppt8rKeXBSLd5Mbg8HgGHJqpjJqcogEc+vrmTf/rCjtO
 NQMk/kB7VAcXuRaj8+Esevp8VssUK9X+/zAjGkjMtzk5m19VDduOvx075kUnpaD7dkZRJfcIh2m
 NQGSzNLjBvdb9AcjSwIT/x6TILWA3r0vyKMyyqzhbojzAW+dH+AIkx
X-Received: by 2002:a17:90b:39a3:b0:3a0:516d:9f88 with SMTP id
 98e67ed59e1d1-3adce62888bmr2264255a91.26.1792774286020; 
 Fri, 23 Oct 2026 09:51:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3adde20c410sm452336a91.3.2026.10.23.09.51.25
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Oct 2026 09:51:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-536720195ebso23439471cf.1
 for <dev@dpdk.org>; Fri, 23 Oct 2026 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1792774285; x=1793379085; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=q7NwcKZkai0YaJIB1XptyisZO89aB2K125MyYtlsCzI=;
 b=ClMWjbeDyjBpLMMyU9uvDLBcmMSr6W0j0Zy2sX4ZWWncsISnVze2Lu2ylPNqOqadGu
 Y7Q5E1VGNygfbptzTmLCz9tm4mQKkHVL+rxnoYKhMsst86t6ZwAwnfLx7llDczb2wumr
 Jv/i0PV8D+uyQwVw91rpCpPhnePBdSA1mb9Nk=
X-Received: by 2002:ac8:5f8a:0:b0:536:458d:525e with SMTP id
 d75a77b69052e-536c2872b16mr40697371cf.37.1792774284741; 
 Fri, 23 Oct 2026 09:51:24 -0700 (PDT)
X-Received: by 2002:ac8:5f8a:0:b0:536:458d:525e with SMTP id
 d75a77b69052e-536c2872b16mr40696821cf.37.1792774284152; 
 Fri, 23 Oct 2026 09:51:24 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c45228d8bsm5928056d6.21.2026.10.23.09.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 09:51:23 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com
Subject: [PATCH 0/7] net/bnxt: Tx coalescing,
 function error recovery and Rx fixes
Date: Fri, 23 Oct 2026 10:54:49 -0600
Message-ID: <20261023165457.1225312-1-mohammad-shuab.siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series is based on dpdk-next-net-brcm for-next-net.

Patch 1 enables Tx completion coalescing in hardware on P7 devices.
Patch 2 adds recovery from the function error state.
Patch 3 fixes an Rx stall caused by doorbell and vector Rx issues.
Patches 4-6 stop the AVX2 Rx burst functions from reading and writing
past the end of the completion ring and the caller's array.
Patch 7 fixes an Rx throughput drop on Thor2 with 256 byte packets.

Keegan Freyhof (4):
  net/bnxt: modify AVX2 v3 path to prevent OOB accesses
  net/bnxt: modify AVX2 v2 path to prevent OOB accesses
  net/bnxt: modify AVX2 CRX path to prevent OOB accesses
  net/bnxt: fix cache thrashing for vector Rx and Tx paths

Mohammad Shuab Siddique (2):
  net/bnxt: enable Tx completion coalescing in hardware
  net/bnxt: add recovery from function error

Shuanglin Wang (1):
  net/bnxt: fix Rx packet stall

 doc/guides/nics/bnxt.rst                |   27 +
 doc/guides/rel_notes/release_26_11.rst  |    6 +
 drivers/net/bnxt/bnxt.h                 |    4 +
 drivers/net/bnxt/bnxt_ethdev.c          |   55 +-
 drivers/net/bnxt/bnxt_func_error.c      |  228 ++++
 drivers/net/bnxt/bnxt_func_error.h      |   33 +
 drivers/net/bnxt/bnxt_hwrm.c            |  137 ++-
 drivers/net/bnxt/bnxt_hwrm.h            |    5 +-
 drivers/net/bnxt/bnxt_mpc.c             |    2 +-
 drivers/net/bnxt/bnxt_ring.c            |   12 +-
 drivers/net/bnxt/bnxt_ring.h            |   15 +-
 drivers/net/bnxt/bnxt_rxr.c             |   26 -
 drivers/net/bnxt/bnxt_rxr.h             |   30 +
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c   | 1320 ++++++++++++-----------
 drivers/net/bnxt/bnxt_rxtx_vec_common.h |  150 +++
 drivers/net/bnxt/bnxt_rxtx_vec_neon.c   |   16 +-
 drivers/net/bnxt/bnxt_rxtx_vec_sse.c    |   20 +-
 drivers/net/bnxt/bnxt_stats.c           |   21 +
 drivers/net/bnxt/bnxt_stats.h           |    2 +-
 drivers/net/bnxt/bnxt_txq.c             |    1 +
 drivers/net/bnxt/bnxt_txr.c             |    1 -
 drivers/net/bnxt/hsi_struct_def_dpdk.h  |  130 +++
 drivers/net/bnxt/meson.build            |    1 +
 23 files changed, 1569 insertions(+), 673 deletions(-)
 create mode 100644 drivers/net/bnxt/bnxt_func_error.c
 create mode 100644 drivers/net/bnxt/bnxt_func_error.h

-- 
2.47.3

