Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18401CD98E4
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 21:34:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF13B4064A;
	Thu, 13 Nov 2025 22:34:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id E4F7F40151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 22:34:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763069658; x=1794605658;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:to:cc;
 bh=uz9xGshpWvJg7OeLvHWVdqEVZ3JoDjtQJVGydenRjnY=;
 b=F9QJREYXna+pFr+jbHB85n6hrWMuR6p1RH2gklAOOWkpLIdhsish652o
 rFv23wTKNL0kmYHzsxCmMiwUztUWytn09WFmq75YwHDuB5S4sCotJIbHV
 n2BvVG3BNk86D/glSxpEo27/o/mcW7+28ixHle8zIglytCJ8MM96PZvWt
 ESQx5NZH7SIzXTq1CcBL4OkuVl0iMBZFg+0qPrK/0qC5EGnGsakkj9DbO
 EvdmXEDvVOiBCPdfT8UdLX+PaN0diKEAdsQS6QPWQD8aCDoxVMXDSOF7v
 BAXtL2SMnktYoGgyWOlhvYCQR5XDocP4sL64NPAkGM5Jqx6eCHMVSghxA Q==;
X-CSE-ConnectionGUID: 2YKxT/60QVeEC0gvGtfgBA==
X-CSE-MsgGUID: VNCIlM2VTf+8r70pnJMX/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="69027489"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; d="scan'208";a="69027489"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 13:34:17 -0800
X-CSE-ConnectionGUID: doD25gImSAy7kjVuXSkEkA==
X-CSE-MsgGUID: kP7yu8f5SnqUnLbHCeGtwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; d="scan'208";a="194051457"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90])
 ([10.166.28.90])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 13:34:17 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 0/2] net/iavf: handle PF not enabling Rx timestamps
 properly
Date: Thu, 13 Nov 2025 13:33:43 -0800
Message-Id: <20251113-jk-dpdk-iavf-rx-timestamping-improvements-v1-0-3d9a0168087b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALhOFmkC/x3NwQrCMAyA4VcZORtYWqbiq4iHYrMZR7uSlDIYe
 3eLx+/y/wcYq7DBYzhAuYnJljvoMsD7E/LCKLEb3OgmIvL4XTGWuKKENqPuWCWx1ZCK5AUlFd0
 aJ87VMIzX6MjfJ38j6L2iPMv+fz1f5/kDzASLGnsAAAA=
X-Change-ID: 20251113-jk-dpdk-iavf-rx-timestamping-improvements-a06d21385371
To: dev@dpdk.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=2434;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=uz9xGshpWvJg7OeLvHWVdqEVZ3JoDjtQJVGydenRjnY=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhkwxv3PaiT9CeC9Zr5UUUPXblS+Yw7L+90w+b/HpjUlKA
 UHpi/U7SlkYxLgYZMUUWRQcQlZeN54QpvXGWQ5mDisTyBAGLk4BmAibOSPDlJsfNU14OU7O+BV9
 JPln1DmmlW5XN3K9OufydNUFmSqNWYwMn1tUj07dGR63dcHq/0WLjGpD7+vwJMw/oGTlfehC2b0
 tzAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
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

In certain cases, the PF for the iavf driver may support
VIRTCHNL_VF_CAP_PTP but will not enable Rx timestamps. If this occurs, the
iavf driver will attempt to continue anyways. When that happens, the
resulting timestamps will appear to function initially. Upon closer
inspection it becomes clear that the timestamps are invalid and bogus.

First, when reporting a timestamp, always check the validity bit instead of
blindly reporting it. This avoids extending an invalid (likely zero'd)
timestamp value from the Rx descriptor.

Second, don't enable the RTE_ETH_RX_OFFLOAD_TIMESTAMP capability if the PF
doesn't indicate we have support. This will prevent applications from
trying to timestamp when it is not properly enabled.

Typically, this should not happen, as the PFs which support
VIRTCHNL_VF_CAP_PTP should support Rx timestamping. However, we recently
discovered a flaw in some implementations of the
VIRTCHNL_OP_1588_PTP_GET_CAPS command. The layout of the capabilities
structure is incorrect, with the caps member placed at a different byte
offset than the expected structure layout. This is the case with the
upstream Linux ice PF driver.

This results in the PF rejecting the request for Rx timestamping, and
leaving timestamping disabled. A proper fix for this situation is
difficult. If we merely changed the structure layout in DPDK, then it would
stop being compatible with other host OSes and with other implementations
of the Linux ice PF. If we changed the layout upstream, it would break
compatibility with the upstream iAVF VF driver.

A proper fix to resolve this will take some time, as we will likely have to
introduce a new flag or ops capability across many drivers. In the mean
time, we should at least make sure the DPDK driver stops reporting bogus
timestamps in such a setup.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Jacob Keller (2):
      net/iavf: check if PF actually indicates Rx timestamps
      net/iavf: check Rx timestamp validity bit

 drivers/net/intel/iavf/iavf_rxtx.h   | 3 +++
 drivers/net/intel/iavf/iavf_ethdev.c | 3 ++-
 drivers/net/intel/iavf/iavf_rxtx.c   | 9 ++++++---
 3 files changed, 11 insertions(+), 4 deletions(-)
---
base-commit: be0112878b4fc3a1b918370ed2fe615c52039d77
change-id: 20251113-jk-dpdk-iavf-rx-timestamping-improvements-a06d21385371

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>

