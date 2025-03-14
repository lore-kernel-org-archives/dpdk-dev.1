Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301CAC282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 14:34:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08D4340289;
	Fri, 14 Mar 2025 15:34:02 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id A6DBD400D5
 for <dev@dpdk.org>; Fri, 14 Mar 2025 15:33:59 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id F1863203344A; Fri, 14 Mar 2025 07:33:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F1863203344A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741962838;
 bh=OvUAtQDMqcRLgU6RLTBQNJMJOucIrnRx6M6GYfaofB8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k1gJ54DwsAOSic9ca8fzOQWpdNuU2njcxItPmn+z7oOLr1obk4N0xHxf/2koAPI8O
 awmhaoZmAHV46PU+sfpWRty+sVn8FDdNDczhpAfxMVIN+nBL+HvQ86dJMbMqapA/+j
 iTqnVBMGjmDTbLyzovVe1DLdjo3Bgz+daSZF/CeM=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	mb@smartsharesystems.com
Subject: [PATCH v5 0/3] add portable version of __builtin_add_overflow
Date: Fri, 14 Mar 2025 07:33:37 -0700
Message-Id: <1741962820-27123-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
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

__builtin_add_overflow is gcc specific. There's a need for a portable
version that can also be used with other compilers.

v5:
- Combined patches 1 with 5 and 2 with 3.

v4:
- Added define in ice_osdep.h to use portable version of
  __builtin_add_overflow when using MSVC.
- Undid all changes from drivers/net/intel/ice/base/ice_nvm.c.

v3:
- Rebase on top of latest main.

Andre Muezerie (3):
  eal: add portable version of __builtin_add_overflow
  net/intel: use portable version of __builtin_add_overflow
  app/test: add tests for portable version of __builtin_add_overflow

 MAINTAINERS                            |   1 +
 app/test/meson.build                   |   1 +
 app/test/test_math.c                   | 170 +++++++++++++++++++++++++
 doc/api/doxy-api-index.md              |   1 +
 drivers/net/intel/ice/base/ice_osdep.h |   5 +
 lib/eal/include/meson.build            |   1 +
 lib/eal/include/rte_math.h             |  46 +++++++
 7 files changed, 225 insertions(+)
 create mode 100644 app/test/test_math.c
 create mode 100644 lib/eal/include/rte_math.h

--
2.48.1.vfs.0.1

