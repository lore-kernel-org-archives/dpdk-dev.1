Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A69CD342F
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 11:07:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15F5840272;
	Tue,  5 May 2026 13:07:59 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 8CEA84026C
 for <dev@dpdk.org>; Tue,  5 May 2026 13:07:57 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A9EC28FA;
 Tue,  5 May 2026 04:07:51 -0700 (PDT)
Received: from cesw-grace-nv-1s-n2-01.lab.cambridge.arm.com
 (cesw-grace-nv-1s-n2-01.lab.cambridge.arm.com [10.7.10.64])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 23FB13F836;
 Tue,  5 May 2026 04:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777979276; bh=K0e+4Bbk5O4pJgV/S7svNoobAp7CIBmrztqDzwkJ5eU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=r98G9/InoIGibc80CDFomSLXyoxvuyTWMziPrC8b/2zxaRSry2BFHpB4Z3ftCGVng
 kc8D1BGzkfS+bDNiSnoSWlu+YbZLlSpW5u/WJK3LMhERWqQG27kKfAu3KsvkG4LVt8
 C70SzCfFRrvHxM4utAdKVaKeKt5NWgvvI2TG1TkU=
From: Jay Wang <jay.wang2@arm.com>
To: 
Cc: dev@dpdk.org,
	nd@arm.com,
	Jay Wang <jay.wang2@arm.com>
Subject: [PATCH v3 0/3] net/iavf: add NEON support for Rx/Tx paths
Date: Tue,  5 May 2026 11:07:41 +0000
Message-ID: <20260505110745.206312-1-jay.wang2@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420103042.2836732-1-jay.wang2@arm.com>
References: <20260420103042.2836732-1-jay.wang2@arm.com>
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

- Add the scattered Rx burst function for 32B legacy descriptor
- Add the NEON-optimised Tx burst function
- Add the NEON-optimised Rx burst functions for flexible descriptor

Single-core benchmark result on a Grace server with an Intel E810:

| buffer sz (B) | prev (MPPS) | optimised (MPPS) | uplift |
| ------------- | ----------- | ---------------- | ------ |
| 64            | 62.241      | 86.010           | 38.2%  |
| 128           | 60.813      | 81.453           | 33.9%  |
| 256           | 23.730      | 24.633           | 3.8%   |
| 512           | 10.268      | 10.380           | 1.1%   |
| 1024          | 4.588       | 4.628            | 0.9%   |
| 1518          | 4.601       | 4.669            | 1.5%   |


---
v3:
- Optimised the branch prediction in counting packets by changing
  unlikely() to likely()
- Added the single-core performance data from Grace + E810 done by
  Andrew

v2:
- Fixed the AArch32 cross-building issue on AArch64 by restricting the
  call of iavf_rxq_vec_setup to AArch64 only


Jay Wang (3):
  net/iavf: add Rx scattered function for 32B desc
  net/iavf: add NEON-optimised Tx burst function
  net/iavf: add NEON support for Rx flex desc

 drivers/net/intel/iavf/iavf.h               |   4 +
 drivers/net/intel/iavf/iavf_rxtx.c          |  54 +-
 drivers/net/intel/iavf/iavf_rxtx.h          |   2 -
 drivers/net/intel/iavf/iavf_rxtx_vec_neon.c | 753 +++++++++++++++++++-
 drivers/net/intel/iavf/meson.build          |   2 +-
 5 files changed, 797 insertions(+), 18 deletions(-)

-- 
2.43.0

