Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C460DC369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 03:24:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 540BF400D6;
	Fri, 18 Apr 2025 05:24:50 +0200 (CEST)
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net
 [129.150.39.64]) by mails.dpdk.org (Postfix) with ESMTP id AA9B2400D5
 for <dev@dpdk.org>; Fri, 18 Apr 2025 05:24:48 +0200 (CEST)
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBnby_7xQFoBVY_Fw--.9082S2;
 Fri, 18 Apr 2025 11:24:43 +0800 (CST)
Received: from localhost.localdomain (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwAHWSj3xQFoGUcBAA--.133S3;
 Fri, 18 Apr 2025 11:24:40 +0800 (CST)
From: Wencheng Li <liwencheng@phytium.com.cn>
To: dev@dpdk.org
Subject: [PATCH v7 0/3] net/macb: updated net macb driver
Date: Fri, 18 Apr 2025 03:24:34 +0000
Message-Id: <1744946674-31765-1-git-send-email-liwencheng@phytium.com.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1744093147-313646-1-git-send-email-liwencheng@phytium.com.cn>
References: <1744093147-313646-1-git-send-email-liwencheng@phytium.com.cn>
X-CM-TRANSID: AQAAfwAHWSj3xQFoGUcBAA--.133S3
X-CM-SenderInfo: polzv0xfkh0wo6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=liwencheng
 @phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXry5JrWUtrWUCF15KryfWFg_yoWrXw1xpF
 4jyryavr4UJrW3t3ySva18ZFyru3WxGryrK343u3s3WF97Cry8JF4jkFWjyr93Ga1UA3W0
 vrn0vF13GFn8JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
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

v7:
- Use a legal name instead of an email alias.
- Do not use additional __rte_cold.
- Replace unsigned long with standard uint64_t.
- Describe the devargs used by the driver in the documentation.
- Update macb.ini.

v6:
- Fixed build failures across different OS.

v5:
- Putting __rte_unused after the declaration.
- Correct RX-bytes and TX-bytes statistics.
- Initialize the mbuf_initializer.
- Add driver based on 25.07.
- Fixed some code style issues.

v4:
- Fix tab errors in meson.build file.
- Use RTE_LOG_LINE instead of rte_log.
- Replace %l with %PRI*64.
- Replace rte_smp_[r/w]mb with rte_[r/w]mb.
- Do not use variadic arguments in macros.
- Do not use variable-length array pkts[nb_bufs].
- Use __rte_cache_aligned only for struct or union types alignment.
- Support hardware Rx/Tx checksum offload.
- Fixed some code style issues.
v3:
- Changed functions that always return 0 and whose return value
is unused to void type, improving code simplicity and readability.
- Fixed the implicit conversion issues in the
macb_usxgmii_pcs_check_for_link and
macb_usxgmii_pcs_check_for_link functions.
- Added the missing SPDX license tags.
- Added the missing mailmap entry.
- Updated the MAINTAINERS file to include the missing information.

v2:
- Split the driver into three logically independent patches,
rather than one large patch.
- Added conditional compilation to address the issue of
macb_rxtx_vec_neon.c failing to compile in certain modes.
- Fixed some code style issues.

v1:
- updated net macb driver.

*** BLURB HERE ***

Wencheng Li (3):
  net/macb: add new poll mode driver
  net/macb: add NEON vectorized Rx/Tx
  net/macb: add necessary docs and update related files

 .mailmap                               |    1 +
 MAINTAINERS                            |    6 +
 doc/guides/nics/features/macb.ini      |   19 +
 doc/guides/nics/index.rst              |    1 +
 doc/guides/nics/macb.rst               |  180 +++
 doc/guides/rel_notes/release_25_07.rst |    4 +
 drivers/net/macb/base/generic_phy.c    |  271 +++++
 drivers/net/macb/base/generic_phy.h    |  202 ++++
 drivers/net/macb/base/macb_common.c    |  670 ++++++++++++
 drivers/net/macb/base/macb_common.h    |  253 +++++
 drivers/net/macb/base/macb_errno.h     |   58 +
 drivers/net/macb/base/macb_hw.h        | 1138 +++++++++++++++++++
 drivers/net/macb/base/macb_type.h      |   23 +
 drivers/net/macb/base/macb_uio.c       |  351 ++++++
 drivers/net/macb/base/macb_uio.h       |   50 +
 drivers/net/macb/base/meson.build      |   25 +
 drivers/net/macb/macb_ethdev.c         | 1861 ++++++++++++++++++++++++++++++++
 drivers/net/macb/macb_ethdev.h         |   91 ++
 drivers/net/macb/macb_log.h            |   19 +
 drivers/net/macb/macb_rxtx.c           | 1394 ++++++++++++++++++++++++
 drivers/net/macb/macb_rxtx.h           |  325 ++++++
 drivers/net/macb/macb_rxtx_vec_neon.c  |  675 ++++++++++++
 drivers/net/macb/meson.build           |   22 +
 drivers/net/meson.build                |    1 +
 24 files changed, 7640 insertions(+)
 create mode 100644 doc/guides/nics/features/macb.ini
 create mode 100644 doc/guides/nics/macb.rst
 create mode 100644 drivers/net/macb/base/generic_phy.c
 create mode 100644 drivers/net/macb/base/generic_phy.h
 create mode 100644 drivers/net/macb/base/macb_common.c
 create mode 100644 drivers/net/macb/base/macb_common.h
 create mode 100644 drivers/net/macb/base/macb_errno.h
 create mode 100644 drivers/net/macb/base/macb_hw.h
 create mode 100644 drivers/net/macb/base/macb_type.h
 create mode 100644 drivers/net/macb/base/macb_uio.c
 create mode 100644 drivers/net/macb/base/macb_uio.h
 create mode 100644 drivers/net/macb/base/meson.build
 create mode 100644 drivers/net/macb/macb_ethdev.c
 create mode 100644 drivers/net/macb/macb_ethdev.h
 create mode 100644 drivers/net/macb/macb_log.h
 create mode 100644 drivers/net/macb/macb_rxtx.c
 create mode 100644 drivers/net/macb/macb_rxtx.h
 create mode 100644 drivers/net/macb/macb_rxtx_vec_neon.c
 create mode 100644 drivers/net/macb/meson.build

-- 
2.7.4

