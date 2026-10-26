Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12500606A320
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=MqhIoH3T
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D65A94025A;
	Mon, 26 Oct 2026 20:09:21 +0100 (CET)
Received: from mail-oo1-f100.google.com (mail-oo1-f100.google.com
 [209.85.161.100])
 by mails.dpdk.org (Postfix) with ESMTPS id 76BDB40041
 for <dev@dpdk.org>; Mon, 26 Oct 2026 20:09:20 +0100 (CET)
Received: by mail-oo1-f100.google.com with SMTP id
 006d021491bc7-6e560e00a86so2360835eaf.1
 for <dev@dpdk.org>; Mon, 26 Oct 2026 12:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793041759; x=1793646559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D9yv36QPqlHa+hpYVjBRXK7dB5ORWk8NoP/AkzvJvdM=;
 b=ouEckSmGWUDNcqrPBCcz44nJkuqZDGcZwLvVA8rSXWl3h3QH1edDmC/qAvpIn1jdHR
 j4jRjkdH9eiznsiFTF91TqcgWcPccRv86b5JPag3bSOWLZCBmnGVlzrs9f/q4A/46U/Q
 FMNkkltexYOVVyt148ysDbqK9j1Tcv1RVkcfG2MfgIcLhYnzbSuBzYRsBcnxDbISAGoK
 0xGhbk9PmYdYC8mXs8O0vhA5Yp/u+k4H1VOSc2N2nR+0snTsToFlkR3UjbS04wCwBE6K
 kWzwuV6/KRCMEZ56XSuHHmKSy5zEWWcwULo6BsKbid0vT+IM4TNRW9rfe3jJcbthHOjh
 vwxg==
X-Gm-Message-State: AFq9FYJp5574dip5Wauu/7ntYxThdu0/Te2o8oVf3kJhwR2aUh5wQado
 kyd9sKtYkwLrDM6wh8busr7QyLy5OH3kB4pES3xlNwRSD6TaA0JdArrBWasuCZB8wINH9s6qNQR
 a2/16LfCb/Ix7h8Yn6Y/G1H/Vw9QVMVekqAGtRTE7s3FrkCqlgkVDfNkqghctCKV8IyPjXC54HE
 5L4kgdd51vN12CaWaL21hJUETkzJ6MDUbB+iIy86VILzB9ewaoYjYFhxpYZln21jZrDlFQEIgAp
 EgoFixVLvPe
X-Gm-Gg: AYBFou1aGves8HhZvrF/WEnkf+KhFEXXNDSB/bcwrNBFvoBA5gd8aSp2iFdXCDmChHA
 5KrwGq0/Y7TvxrC0WfR19mC9oDIrpFcpB63gfqaP05NgpsUfFPxly/G9Ae+UaC2oidV13Q1KKt7
 bhFB3eMDREE0oToMqPXRrVQaJR5Gk5pvebVLLbDlbC9NsszEax9kFLNnBWcWDxjJ3m5uxD5Qwtj
 zUnw2G7QuG8uXGmxsI6cChyK1wqujERafrwjavITkto8oz53xsz9vEKM/CdUHG6B0mCdxBX7jO8
 AaiuQN2C5dLdco4BENj6n05slGcl5SXFgLpRh2/QDiX8uS50MuolFEmbK06ogccbv9ATyDM8yOO
 Pe7zdTI6vWsbJMs4oq1Nj8Ud7SQdIvbpx/iLIPYpHFGkU9/foRh048ADvz6zhzbFxUdEMOa1Xps
 VAnlb2riHYmKoNF4xFRLq8V/PfzD9iu6zO4U2VWhUNCe0on/fTBA==
X-Received: by 2002:a05:6820:a298:20b0:708:c01c:13f3 with SMTP id
 006d021491bc7-70ba0e8fe3dmr2894749eaf.63.1793041759060; 
 Mon, 26 Oct 2026 12:09:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 46e09a7af769-850fb077cd4sm83888a34.13.2026.10.26.12.09.18
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Oct 2026 12:09:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0d568830so9130645eec.1
 for <dev@dpdk.org>; Mon, 26 Oct 2026 12:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793041757; x=1793646557; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D9yv36QPqlHa+hpYVjBRXK7dB5ORWk8NoP/AkzvJvdM=;
 b=MqhIoH3T29rdVFvK0euKEZyYu8oww6pTScuGbrWq8bJCdU1Fu6zihm+ut54wqQJlPI
 +g0G0LN27mdh3X9UIKBSKqq02l7qmJ2AYpsbShgCYUdXlxko3TBy8bUtjPgXeMMKBgI4
 0Mp0NzFrF0aWb6cO6Y9RhL1am0ZKaqVO4oJtI=
X-Received: by 2002:a05:7301:3d10:b0:35d:ea6f:b85e with SMTP id
 5a478bee46e88-369e8358affmr16841082eec.1.1793041756836; 
 Mon, 26 Oct 2026 12:09:16 -0700 (PDT)
X-Received: by 2002:a05:7301:3d10:b0:35d:ea6f:b85e with SMTP id
 5a478bee46e88-369e8358affmr16841031eec.1.1793041755933; 
 Mon, 26 Oct 2026 12:09:15 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8db7b23sm37103906eec.19.2026.10.26.12.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:09:15 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 0/7] net/bnxt: Tx coalescing,
 function error recovery and Rx fixes
Date: Mon, 26 Oct 2026 13:12:44 -0600
Message-ID: <20261026191251.1274062-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023165457.1225312-1-mohammad-shuab.siddique@broadcom.com>
References: <20261023165457.1225312-1-mohammad-shuab.siddique@broadcom.com>
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

From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

This series is based on dpdk-next-net-brcm for-next-net.

Patch 1 enables Tx completion coalescing in hardware on P7 devices.
Patch 2 adds recovery from the function error state.
Patch 3 fixes an Rx stall caused by doorbell and vector Rx issues.
Patches 4-6 stop the AVX2 Rx burst functions from reading and writing
past the end of the completion ring and the caller's array.
Patch 7 fixes an Rx throughput drop on Thor2 with 256 byte packets.

v2:
* Patch 3: declare the Rx burst size variable as uint16_t instead of
  uint32_t in the vector Rx burst functions. It holds a value clamped
  to uint16_t, matching the rest of the driver.
* Patch 5: remove a duplicated comment line.
* Patches 5 and 6 are adjusted to match the type change in patch 3;
  the resulting code is unchanged.
* No other changes.

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
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c   | 1319 ++++++++++++-----------
 drivers/net/bnxt/bnxt_rxtx_vec_common.h |  150 +++
 drivers/net/bnxt/bnxt_rxtx_vec_neon.c   |   16 +-
 drivers/net/bnxt/bnxt_rxtx_vec_sse.c    |   20 +-
 drivers/net/bnxt/bnxt_stats.c           |   21 +
 drivers/net/bnxt/bnxt_stats.h           |    2 +-
 drivers/net/bnxt/bnxt_txq.c             |    1 +
 drivers/net/bnxt/bnxt_txr.c             |    1 -
 drivers/net/bnxt/hsi_struct_def_dpdk.h  |  130 +++
 drivers/net/bnxt/meson.build            |    1 +
 23 files changed, 1568 insertions(+), 673 deletions(-)
 create mode 100644 drivers/net/bnxt/bnxt_func_error.c
 create mode 100644 drivers/net/bnxt/bnxt_func_error.h

