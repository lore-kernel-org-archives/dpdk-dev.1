Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B104BC44500
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 12:24:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FA904027A;
	Thu, 22 Jan 2026 13:24:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 42B624021F
 for <dev@dpdk.org>; Thu, 22 Jan 2026 13:24:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769084644; x=1800620644;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=E3PtdNJ7269uxKG2OXjJuebNywcUynaei+vkWVmib4A=;
 b=g8sqI88Mt3BOXlOic8m2juMj13mXGh5oQ3o0MkeRVYtzUmYq4s/m42q6
 6VJqy5mmDHSHN+80Fdzu+F5G08ObfDiBcGQObJrGLh97iAp825sh3048t
 IHH9eBWoVZsOKTD66wEfLptsw4w6gRD6QqgPM4bE35qtFGudcydjl/GEG
 UT/wryhbd/zM8x264sO2VglMJG+wB643srFhMbGy/ON7glfFG3yW0ZjyL
 hvdqksa8N6+ICPuTb/GKXu2z4SD8H8Ty/8oF0mGaDVz0JjIAyIQNvWoyC
 e751jj8/GaEVxRnlf4YMunatDyEdbuZ+h10/hKKKmPXOLSvMBCt1W9pN8 g==;
X-CSE-ConnectionGUID: r6YYEunnRByH6km231hFzw==
X-CSE-MsgGUID: udhxL40LTvSXFer07qMpXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81436221"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="81436221"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 04:24:02 -0800
X-CSE-ConnectionGUID: yij+DNptR4WF2ak+E5cRMQ==
X-CSE-MsgGUID: Vu+YQlV0TcmOqsxbB2fGTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="205971656"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 22 Jan 2026 04:24:02 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/3] manage net/null dependency for tests
Date: Thu, 22 Jan 2026 12:23:50 +0000
Message-ID: <20260122122354.1820368-1-bruce.richardson@intel.com>
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

A number of unit tests take advantage of net_null driver to use
as a dummy packet source. When this driver is disabled we then get
tests failures in fast-tests. Fix these by recording the dependency
appropriately or by skipping test sections if the dependency isn't
present. The final patch is an optional extra - it marks the null
driver down to always be built.

Bruce Richardson (3):
  test/bpf: skip some testing if null net driver not present
  test: fix missing dependency on null networking driver
  drivers: always enable the null net driver [RFC]

 app/test/meson.build | 4 ++--
 app/test/test_bpf.c  | 9 +++++++++
 drivers/meson.build  | 2 ++
 3 files changed, 13 insertions(+), 2 deletions(-)

--
2.51.0

