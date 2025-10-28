Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBA8CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 08:30:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7118E402C9;
	Tue, 28 Oct 2025 09:30:41 +0100 (CET)
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net
 (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
 by mails.dpdk.org (Postfix) with ESMTP id 3E4A24021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 09:30:39 +0100 (CET)
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCHj5sufwBpcqtdAQ--.126S2;
 Tue, 28 Oct 2025 16:30:38 +0800 (CST)
Received: from localhost.localdomain (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCnC+kqfwBpSfZzAA--.54051S3;
 Tue, 28 Oct 2025 16:30:34 +0800 (CST)
From: Wencheng Li <liwencheng@phytium.com.cn>
To: dev@dpdk.org
Subject: [PATCH v11 0/3] net/macb: updated net macb driver
Date: Tue, 28 Oct 2025 08:30:24 +0000
Message-Id: <1761640224-80468-1-git-send-email-liwencheng@phytium.com.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1755664327-9362-1-git-send-email-liwencheng@phytium.com.cn>
References: <1755664327-9362-1-git-send-email-liwencheng@phytium.com.cn>
X-CM-TRANSID: AQAAfwCnC+kqfwBpSfZzAA--.54051S3
X-CM-SenderInfo: polzv0xfkh0wo6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=liwencheng
 @phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxJw4fuF1xuFy3GFWrCr13CFg_yoWrKryrpF
 4jkryYvrWUJrW3t39avF48ZFyru3WxGrWrK343u3sxWF97Cry8JF1jkF4jyr93JayUAa10
 vrs0vF13GFn8Ja7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

v11:
- Improve the error-handling path to ensure allocated
resources are properly freed on initialization failure.
- Remove unnecessary Linux header files.
- Remove unnecessary __rte_cold annotations.
- Fixed some code style issues.

v10:
- Removed unused spinlock from base/macb_common.h.
- Renamed symbols to avoid name conflicts.
- Remove unnecessary pragmas
- Fixed some code style issues.

v9:
- Added RTE_PMD_REGISTER_KMOD_DEP macro to
 declare dependency on macb_uio kernel module.
- The source link for the macb_uio module
 can be found in macb.rst.

v8:
- Delete log level reset code.
- Delete code that links to external phy library.
- Update document macb.rst.
- Add usage instructions for the macb_uio module.
- Update the explanation of testpmd parameters.

v7:
- Use a legal name instead of an email alias.
- Do not use additional __rte_cold.
- Replace unsigned long with standard uint64_t.

* Describe the devargs used by the driver in the documentation.
* Update macb.ini.

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

Wencheng Li (3):
  net/macb: add new poll mode driver
  net/macb: add NEON vectorized Rx/Tx
  net/macb: add necessary docs and update related files

 .mailmap                               |    1 +
 MAINTAINERS                            |    6 +
 doc/guides/nics/features/macb.ini      |   19 +
 doc/guides/nics/index.rst              |    1 +
 doc/guides/nics/macb.rst               |  181 ++++
 doc/guides/rel_notes/release_25_11.rst |    5 +
 drivers/net/macb/base/generic_phy.c    |  271 +++++
 drivers/net/macb/base/generic_phy.h    |  195 ++++
 drivers/net/macb/base/macb_common.c    |  650 ++++++++++++
 drivers/net/macb/base/macb_common.h    |  248 +++++
 drivers/net/macb/base/macb_errno.h     |   58 ++
 drivers/net/macb/base/macb_hw.h        | 1138 ++++++++++++++++++++
 drivers/net/macb/base/macb_type.h      |   23 +
 drivers/net/macb/base/macb_uio.c       |  351 +++++++
 drivers/net/macb/base/macb_uio.h       |   50 +
 drivers/net/macb/base/meson.build      |   25 +
 drivers/net/macb/macb_ethdev.c         | 1768 ++++++++++++++++++++++++++++++++
 drivers/net/macb/macb_ethdev.h         |   75 ++
 drivers/net/macb/macb_log.h            |   19 +
 drivers/net/macb/macb_rxtx.c           | 1385 +++++++++++++++++++++++++
 drivers/net/macb/macb_rxtx.h           |  325 ++++++
 drivers/net/macb/macb_rxtx_vec_neon.c  |  674 ++++++++++++
 drivers/net/macb/meson.build           |   22 +
 drivers/net/meson.build                |    1 +
 24 files changed, 7491 insertions(+)
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

