Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76050CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 17:13:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76E9240276;
	Mon, 25 May 2026 19:13:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id A1B0E40144
 for <dev@dpdk.org>; Mon, 25 May 2026 19:13:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779729226; x=1811265226;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=X4ItPUSBwpxUsQEH4z5MIv4sX2zyDMWv6sFzOLVadU0=;
 b=SOQkPuH/OBuTjIDHcqpMSPs3t7EtPy6dg4mCjerwTgDfc8YZMUAvK+i0
 C12eXmY1VmDhL/17KxxsDWozQmtUS/8SYybs/C8pMQI8McZ/zO3h25O5h
 gvOEmYXefAKATIn/jvbpaDiBrCM6/+XaWK0BYrniSnI/2G+hAwsEVdxxG
 bIvWtxbpyUK2FiysTtyKHEkwMseI/1Qv3ITifdqUV9pFV5xXpyGHwWIsg
 TyWepppuFh3e8hehbEF7ixaUSRwK5HE6VIUbvKrx/45bSirLaKuivjkOb
 oBtb1CnI1fmH6HBluG4w5Fs6eG+v8sA4Vh40PIdgeSuFEotSw6bVeARrL A==;
X-CSE-ConnectionGUID: KOJ1OoXtR++9h2xokkSIyw==
X-CSE-MsgGUID: ULl6DwfDTA2uaiCybDRz6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80607452"
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; d="scan'208";a="80607452"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 10:13:45 -0700
X-CSE-ConnectionGUID: 3PR4F93kRfqpBG5mTgoIzg==
X-CSE-MsgGUID: /tGOMwcNT1agvY8Q1rSEyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; d="scan'208";a="241506535"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa008.jf.intel.com with ESMTP; 25 May 2026 10:13:45 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/2] implement missing APIs on FreeBSD
Date: Mon, 25 May 2026 18:13:38 +0100
Message-ID: <20260525171340.1701509-1-bruce.richardson@intel.com>
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

The APIs for converting a virtual address to an IOVA or a physical
address were implemented only as stubs on FreeBSD, but unfortunately
they are used by drivers such as "igc", part of e1000, causing the
drivers to fail on BSD. A workaround would be to change the use of these
functions with the rte_malloc equivalents (e.g. rte_malloc_virt2iova) -
which do work on FreeBSD - but a better solution is just to replace the
stubs with proper implementations in FreeBSD-specific EAL flags.

Bruce Richardson (2):
  eal/freebsd: fix memseg addresses in IOVA_AS_VA mode
  eal/freebsd: implement virtual to IOVA translation fn

 app/test/test_memory.c       | 67 ++++++++++++++++++++++++++++++++++++
 lib/eal/freebsd/eal_memory.c | 27 +++++++++++----
 2 files changed, 88 insertions(+), 6 deletions(-)

--
2.53.0

