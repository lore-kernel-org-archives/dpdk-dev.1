Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ECCC88E50
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 12:45:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E1A242D2E;
	Fri, 11 Sep 2026 14:45:03 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 050BE4028B
 for <dev@dpdk.org>; Fri, 11 Sep 2026 14:45:02 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=RyDiyPNM+yM74N9Im8ZdOF3LO8wJKb5HzDC4zy9UuGw=;
 b=vbeJiDaYEsqNKO0bCLu3aK40zhDc6PkJ4YSSIi8J/VWR+OCVgmFXUWWqDW1YeT7+sUuqhRJ4R
 sWOonYGA2ohnh7CTEkutVFSMl/X3GPn9cLMnzp18tqXfkQKdNf5m06XkT8fzd0e7PSAjH95RYEV
 j45E9npNuIttSY9ILDOcelY=
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hhDkk0r8HzJ46Bf
 for <dev@dpdk.org>; Fri, 11 Sep 2026 20:44:14 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 5A23F40570
 for <dev@dpdk.org>; Fri, 11 Sep 2026 20:45:00 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 14:45:00 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: 
CC: <dev@dpdk.org>
Subject: [PATCH v2 0/2] bpf_def.h cleanups
Date: Fri, 11 Sep 2026 13:44:11 +0100
Message-ID: <20260911124414.63321-1-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805094642.52433-1-marat.khalili@huawei.com>
References: <20260805094642.52433-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500002.china.huawei.com (7.182.19.148) To
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

The goal of this patch set is to solve the following problems:
* `bpf_def.h` fails to follow the DPDK naming rules for public headers
  in the name of the file or names of the symbols it defines;
* its symbols may clash with those in Linux headers but at the
  same time are not interchangable with them;
* small differences in opcode names relative to Linux are confusing.

v2:
* Following the AI suggestion renamed `RTE_EBPF_FUNC_MAX_ARGS` to
  `RTE_BPF_FUNC_MAX_ARGS`.
* Rebased on fresh main hoping to overcome the unrelated CI issues.
* Catiously re-posting without the RFC label.

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
 lib/bpf/bpf_validate.h           |    6 +-
 lib/bpf/bpf_validate_debug.c     |    6 +-
 lib/bpf/meson.build              |    1 -
 lib/bpf/rte_bpf.h                |   35 +-
 lib/bpf/rte_bpf_validate_debug.h |    8 +-
 17 files changed, 1623 insertions(+), 1627 deletions(-)

-- 
2.43.0

