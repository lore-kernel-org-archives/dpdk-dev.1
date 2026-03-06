Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29E8F0182E
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 11:52:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFBF940A84;
	Fri,  6 Mar 2026 12:52:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 651D440278
 for <dev@dpdk.org>; Fri,  6 Mar 2026 12:52:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772797945; x=1804333945;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wJHH2kYTcnsuxot9Ag3W9i3uoJ+If1weVmnf9f3MITY=;
 b=EQGXYg2wSLbmWqANO0eG3U4Eb+BkmJW4qMy+TtzCG0TREVPWQkcuwVOA
 joIO+a2n4jvIIOvCl/6LQ7yJZLDCRHchSpwOs0SKLO5/WpPxtAhPFNXth
 cjwwDvhbIbK+iulARe0ogrnlJWqE7xqz/TnazqGDzrAI9UmdHEU4gpTW0
 5sQ+ttHPR/6YGzum1MHdDHP9uXj+GAyUugC8ckp6vIG3Ogrqz/jAemWzK
 vIIQMub9SnrPy2YWy5m3qtLvUWEiTfEJhHs76eCmTtmEywbv2MRJgq1Eo
 KlZCrh5dsxyEnn9sCxyoQqBXuTMy/eWmJdn2gd/RH8x1mHnfWBZux6l7j w==;
X-CSE-ConnectionGUID: xPZoUwK4QlCzf+9vF1LMVw==
X-CSE-MsgGUID: mS4b8HfFQQ6xIB7/J93Upg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="99374630"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="99374630"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 03:52:21 -0800
X-CSE-ConnectionGUID: +nqL0lT7S7+PWat4CUg/HQ==
X-CSE-MsgGUID: 8BQ/EdmvTlO/Iqcz5VannQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="218982434"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by orviesa008.jf.intel.com with ESMTP; 06 Mar 2026 03:52:20 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 0/3] iavf: LLDP ptype and AVX2 ctx paths
Date: Fri,  6 Mar 2026 11:52:11 +0000
Message-ID: <20260306115214.467033-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209152049.1640121-1-ciara.loftus@intel.com>
References: <20260209152049.1640121-1-ciara.loftus@intel.com>
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

This series adds another way to detect LLDP packets in the Tx paths
of the iavf PMD, which is based on the mbuf packet type field. This is
in addition to the existing method of using a dynamic field. The series
also adds new AVX2 context descriptor Tx paths that support LLDP. Finally,
a deprecation notice is added to the documentation to flag that the
dynamic mbuf field method of LLDP packet detection will be removed in a
future release.

v2:
* Support both dynfield and ptype to preserve ABI
* Add deprecation notice for dynfield approach

Ciara Loftus (3):
  net/iavf: support LLDP Tx based on mbuf ptype or dynfield
  net/iavf: add AVX2 context descriptor Tx paths
  doc: announce change to LLDP packet detection in iavf PMD

 doc/guides/nics/intel_vf.rst                |   6 +
 doc/guides/rel_notes/deprecation.rst        |   4 +
 doc/guides/rel_notes/release_26_03.rst      |   2 +
 drivers/net/intel/iavf/iavf.h               |   2 +
 drivers/net/intel/iavf/iavf_rxtx.c          |  18 +
 drivers/net/intel/iavf/iavf_rxtx.h          |   9 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c | 386 ++++++++++++++++++++
 7 files changed, 424 insertions(+), 3 deletions(-)

-- 
2.43.0

