Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9984CC77B7F
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 13:34:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 767CC402B6;
	Tue, 24 Jun 2025 15:34:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id E4B894026B
 for <dev@dpdk.org>; Tue, 24 Jun 2025 15:34:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750772062; x=1782308062;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=SUIleT+PuoYDhBcHwqn4cStl6wg5ONWDRD9pO1o1INI=;
 b=d66D+NNpQ1jYddXlO7R0b4h6KYpw5X1ohCMSDeSyEVOR/w/tS0p+IJ4j
 VPloKB5e/ZyIySnjrObwrTgiTRWu1qxJuRr0WjR9cHxEG2z91LpHOE3Yp
 jL/UGBK2Y481vkF2V+6ET0duNRgAx7loO2zjjKCp0DuNtB1oygk/bSlBw
 OyOEopjLr+UKFo3JF5Z70oIIwDA6HlFD7gsmOtbKXVmDWZqve7wyI/Mkc
 0T5HlZ2r3cKC+gCBTcovbanzFEhrAzid9M9na/1DDh8xLGm1Ec22BqOwY
 /N+XAEDeFGsf9UaM/vRXD2YYKujg8GVPfUkQEkY/JcDdS0XIpo5UBKrOQ A==;
X-CSE-ConnectionGUID: 15mRqVXAR92ptFs7D/1/gQ==
X-CSE-MsgGUID: OCUi17OpSqiw9W/BlK6/fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53112026"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="53112026"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 06:34:20 -0700
X-CSE-ConnectionGUID: XkvxeLC/Rxeu9tNcPeqDBg==
X-CSE-MsgGUID: j+eWZXofSe+Ti0R5pXULbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="157410751"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa004.fm.intel.com with ESMTP; 24 Jun 2025 06:34:18 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/2] use core lists not masks in documentation
Date: Tue, 24 Jun 2025 14:34:06 +0100
Message-ID: <20250624133409.550372-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

For real-world use with dozens if not hundreds of cores, use of core
masks becomes unwieldy. Core lists are preferred so update the examples
and DPDK docs to refer to core lists over core masks i.e.

* use "-l" EAL option rather than "-c"
* use "-S" service core list option rather than "-s"

Bruce Richardson (2):
  doc/eal: add doc entry for service core list flag
  doc: use core lists rather than masks in guides

 doc/guides/bbdevs/acc100.rst                  |  2 +-
 doc/guides/bbdevs/fpga_5gnr_fec.rst           |  4 +-
 doc/guides/bbdevs/fpga_lte_fec.rst            |  2 +-
 doc/guides/bbdevs/vrb1.rst                    |  2 +-
 doc/guides/bbdevs/vrb2.rst                    |  2 +-
 doc/guides/cryptodevs/octeontx.rst            |  2 +-
 doc/guides/eventdevs/dlb2.rst                 |  6 +--
 doc/guides/faq/faq.rst                        |  8 ++--
 doc/guides/freebsd_gsg/build_sample_apps.rst  |  8 ++--
 doc/guides/howto/packet_capture_framework.rst |  2 +-
 doc/guides/linux_gsg/build_sample_apps.rst    | 10 ++---
 doc/guides/linux_gsg/eal_args.include.rst     |  5 +++
 doc/guides/mempool/cnxk.rst                   |  2 +-
 doc/guides/mempool/octeontx.rst               |  2 +-
 doc/guides/nics/cnxk.rst                      |  2 +-
 doc/guides/nics/cpfl.rst                      |  2 +-
 doc/guides/nics/dpaa.rst                      |  2 +-
 doc/guides/nics/dpaa2.rst                     |  4 +-
 doc/guides/nics/fail_safe.rst                 |  8 ++--
 doc/guides/nics/ice.rst                       |  4 +-
 doc/guides/nics/softnic.rst                   |  4 +-
 doc/guides/prog_guide/meson_ut.rst            |  2 +-
 doc/guides/prog_guide/multi_proc_support.rst  |  2 +-
 doc/guides/prog_guide/service_cores.rst       |  8 ++--
 doc/guides/sample_app_ug/bbdev_app.rst        |  6 +--
 doc/guides/sample_app_ug/ip_pipeline.rst      |  2 +-
 doc/guides/sample_app_ug/ipsec_secgw.rst      |  4 +-
 .../sample_app_ug/l2_forward_macsec.rst       |  4 +-
 doc/guides/sample_app_ug/l3_forward.rst       |  2 +-
 doc/guides/sample_app_ug/multi_process.rst    |  8 ++--
 doc/guides/sample_app_ug/ntb.rst              |  2 +-
 doc/guides/sample_app_ug/pipeline.rst         |  2 +-
 doc/guides/sample_app_ug/qos_scheduler.rst    |  2 +-
 doc/guides/sample_app_ug/test_pipeline.rst    |  2 +-
 doc/guides/sample_app_ug/vdpa.rst             |  2 +-
 doc/guides/tools/comp_perf.rst                |  5 +--
 doc/guides/tools/cryptoperf.rst               |  5 +--
 doc/guides/tools/graph.rst                    | 13 +++----
 doc/guides/tools/testbbdev.rst                |  2 +-
 doc/guides/tools/testeventdev.rst             | 39 +++++++++----------
 doc/guides/tools/testmldev.rst                | 27 +++++++------
 41 files changed, 110 insertions(+), 112 deletions(-)

--
2.48.1

