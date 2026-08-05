Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C603FC55822
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 09:47:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A54040144;
	Wed,  5 Aug 2026 11:47:03 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id A37F54003C
 for <dev@dpdk.org>; Wed,  5 Aug 2026 11:47:02 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Yrp4aLTBCqvhP6Zh1ZRPT8svNF3qFIz/Roq8hCkOtfQ=;
 b=uGH9Nn1DqG4w4+ghl6wFceUCxLyecpFX3dmYemHsrISvvxshQ/L9mLBQVn63vaoi+EkHd8LpB
 A9TkNH2UDtGctthPwWI6YD+kvs5vLCALA6bUmaJneK+q671ASDOSy2j6bdQCZKN2H6MdTkK0L0m
 bkT/SPAhPlSChSu///mtUXw=
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hFQXT1mW2zJ46Yd;
 Wed,  5 Aug 2026 17:46:17 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 13A4B40575;
 Wed,  5 Aug 2026 17:47:02 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Aug 2026 11:47:01 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: 
CC: <dev@dpdk.org>, <stephen@networkplumber.org>, <thomas@monjalon.net>
Subject: [RFC 0/2] bpf_def.h cleanups
Date: Wed, 5 Aug 2026 10:46:40 +0100
Message-ID: <20260805094642.52433-1-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500001.china.huawei.com (7.182.19.243) To
 frapema500003.china.huawei.com (7.182.19.114)
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

This patch set contains two patches, first of which is a prerequisite
for the second but can also be considered and applied independently.

Marat Khalili (2):
  bpf: make bpf_def.h private
  bpf: rename macros to match Linux kernel

 app/test/test_bpf.c              | 1685 +++++++++++++++---------------
 app/test/test_bpf_validate.c     |  268 ++---
 lib/bpf/bpf_convert.c            |   78 +-
 lib/bpf/bpf_def.h                |   91 +-
 lib/bpf/bpf_dump.c               |   45 +-
 lib/bpf/bpf_exec.c               |  156 +--
 lib/bpf/bpf_impl.h               |    5 +-
 lib/bpf/bpf_jit_arm64.c          |  218 ++--
 lib/bpf/bpf_jit_x86.c            |  312 +++---
 lib/bpf/bpf_load.c               |    2 +-
 lib/bpf/bpf_load_elf.c           |   24 +-
 lib/bpf/bpf_validate.c           |  310 +++---
 lib/bpf/bpf_validate.h           |    4 +-
 lib/bpf/bpf_validate_debug.c     |    6 +-
 lib/bpf/meson.build              |    2 +-
 lib/bpf/rte_bpf.h                |   35 +-
 lib/bpf/rte_bpf_validate_debug.h |    8 +-
 17 files changed, 1623 insertions(+), 1626 deletions(-)

-- 
2.43.0

