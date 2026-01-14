Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45757D3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:28:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B2A340E17;
	Wed, 14 Jan 2026 23:28:27 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 6559C4003C
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:28:26 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47f3b7ef761so1743735e9.0
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429706;
 x=1769034506; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TtqEPJje2uzGy2EYhCbkOcoo3gNKX1unEZI17jUfuww=;
 b=ax/TJNuvKCItARCEm99Bick6Gn2Dxr43lv5rnkiJR4fY+g7N7jei0WHJA1j6wHmys9
 I5u1yQG9bCyZFE49dnphgxCXn+2AanCUn1NrHXmrahMITXV5nwZoaEsCrN8oQfBQGEYw
 LAfe6AZ/dnPFw1jST2Fdi3iIW9Hp1mhmXyFITxydlN8s5yR8phgAOreMvl9hIXMD6N9q
 V9DFw0CrM1r/zzm/vtN1kqKUGQL+WVi89hsOuLGMB7AuJF0+PcuRbMkAyBQCygsWudXs
 ixqgv9M4OQvGGVk7/TWV093fBxsHC7O137nR4kv9tBhoEvUliIgDLVw9AvNNyZ1Mo7pv
 zncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429706; x=1769034506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TtqEPJje2uzGy2EYhCbkOcoo3gNKX1unEZI17jUfuww=;
 b=XSpwUJWcYMsboZM+HEC1jE2e2O1SsT174aTsxktWq80zbV5yUNH5GMbef5XrQ2aY39
 /dHGlanumJYx27cHZ8vg2dAGKJo7ShgN3ipJthY6XCBv6t+8Gw4K8J5Ei5RQMh20KZtL
 lhRJxX25jNUda9HNSc21SqEVCnAJhGV94PCkRsvDeQTydhQtmkKYdE+l1bViMFTddzR4
 p/FuQKk60VvoV3OCV8NXA9lpcoo5pN0nruD6/MoYOBZ2sCoBTMWfskQZZMid4fAG+1k8
 DsAL8WcgD31qSIYsM1Y6FImxd8ivFUKp0FOOcOcv0myapP6rc7ctOfBPgXPwE2VDv8+2
 +piQ==
X-Gm-Message-State: AOJu0YxCyeQtUqiPksu0IzHNd1cPvuqzEwtjvPAiN/A45NuMf1cd76a4
 5U7tsT1MZSGnSLB5XEqEP3VA3iMTGjL63SQWZEg4qKAb4vXF/3h+a+Uxb2y2wwiOtwBkORA1ZjX
 I/5ok
X-Gm-Gg: AY/fxX6+EhPfXmLiXrqgfLpuZMra4EziFd7al8vTpujB4+On8hgGLmNiQJ9xQ9s2ZwL
 ULaT9xKBLFIWwVU1Axs76WwmVYf9EgddAlgaWD4h7bJfv1/SX7tZVuivgWVs90HPxl/rF+qOidX
 VCY2cUHk3zkMEQR1ccnq/mnzovBSUtw2GSXzZFO9nKAPTfQF+ixRsFiatNHuL0drKHtlQYZAuLu
 WaA0FsnoipA4BWX1NR3S/P7Ld2dQkPP6WQFjUz4A2efZN6Fa6vCb2F9PWwxGvYxdPKIOx3i1XG8
 eaZVtOH2HQmYjiDVxZSOZzTIjr78nVvMFronin3wlbHx5RlIhM/uEAnMN7VcHa1hmsWw5hd0073
 23TigRVoBtGh3CeF4+wBjaLdZLqAfY7m8MOq+4mW0gfjaFiw898/BjTbvNp4wN+mZrxPTitGc6c
 XPmJZAQ3fa/Q92vMH8ovZVUbg8dN2qNvRkKEXQvUs3+VKgP0OprQ==
X-Received: by 2002:a05:600c:a08c:b0:47d:5dae:73b1 with SMTP id
 5b1f17b1804b1-47ee33544d8mr42622375e9.23.1768429705978; 
 Wed, 14 Jan 2026 14:28:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af653632sm1757198f8f.11.2026.01.14.14.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:28:25 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 00/11] doc: programmers guide corrections
Date: Wed, 14 Jan 2026 14:26:52 -0800
Message-ID: <20260114222821.87920-1-stephen@networkplumber.org>
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

Found while reviewing the DPDK programmer's guide documentation.

v4 - incorporate additional earlier changes to ethdev doc.

Stephen Hemminger (11):
  doc: correct grammar and punctuation errors in ethdev guide
  doc: correct grammar and typos in argparse library guide
  doc: correct grammar and typos in design guide
  doc: correct errors in Linux system requirements guide
  doc: correct grammar in service cores guide
  doc: correct grammar and errors in trace library guide
  doc: correct typos in log library guide
  doc: correct errors in command-line library guide
  doc: correct errors in trace library guide
  doc: correct errors in stack library guide
  doc: correct errors in RCU library guide

 doc/guides/contributing/design.rst      |  71 +--
 doc/guides/linux_gsg/sys_reqs.rst       |  14 +-
 doc/guides/prog_guide/argparse_lib.rst  |  24 +-
 doc/guides/prog_guide/cmdline.rst       |  42 +-
 doc/guides/prog_guide/ethdev/ethdev.rst | 557 ++++++++++++------------
 doc/guides/prog_guide/log_lib.rst       |  32 +-
 doc/guides/prog_guide/rcu_lib.rst       | 143 +++---
 doc/guides/prog_guide/service_cores.rst |  30 +-
 doc/guides/prog_guide/stack_lib.rst     |  32 +-
 doc/guides/prog_guide/trace_lib.rst     | 118 ++---
 10 files changed, 548 insertions(+), 515 deletions(-)

-- 
2.51.0

