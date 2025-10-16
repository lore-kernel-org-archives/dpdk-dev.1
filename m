Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6034CCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 11:21:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3977A415D7;
	Thu, 16 Oct 2025 13:20:16 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id 9ACAC427DD
 for <dev@dpdk.org>; Thu, 16 Oct 2025 13:20:13 +0200 (CEST)
X-QQ-mid: esmtpsz17t1760613607t6c094ed2
X-QQ-Originating-IP: qGNvtOf/cGEvZLZJBH/TYvBQA26Im9JX44kzNVUEYdk=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.206.160.146])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 16 Oct 2025 19:20:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3508465889210038717
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v5 20/21] doc: update for txgbe guides
Date: Thu, 16 Oct 2025 19:17:34 +0800
Message-Id: <20251016111736.25372-21-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251016111736.25372-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20251016111736.25372-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MVocNrGTvdgh58RJPKRQIMyVTKahUOkmJ/pX3HNASDVECJS8wgbboLQ8
 2gOF22FZQVxZFp6MPJW1V3HHRKSEB5EjGmfPy4pFrK8fP7bIONlYN5Oh5HSSaszhooWjk56
 n0VACVyFZe/91p+25/YX9dPhUg24kNqEK7KoIYEh2WPduPdyRUcuJXpye+6+nOsxS/I90o3
 B3KMKHJLqcx0jXiIPv0G7UYP78yxrAO4nT2ZVjeytw9RcnL9uUs5BzLCEM1l0liWyuEvyqe
 59e4wI3zmPsiUVkV0FWPNfRVUMer1vp5A35oJJnOj+M2jEtnqkeBc0kmebgDmZjh+T7nbNH
 UQNIvNxa916iV+dxH+OIo+LT1yiQzMjDHHdbcjvCjPLP4+ulAZf7SGl66RoWHGPYZsi8Cy5
 a2cDbWFcc7ayYxUdtuyVfnJytOTPw/J2kvdKs1+ofuCv6RPtSdehrQhRlHAtetiZ7bFUNRG
 qzY0GDr/ikvKXOBr48WgfjSHDhTWIjzXhb9S9Uil5gz/X90OB59X4Bl/Lmier1qqEzHb2rq
 6ybWvp2YXOFS2wCvKSsoksbtEeyXQDYUSL27k/m6q575O+qJaNYaChQgs2gAy1HKSLSjtd+
 +6HuxfsIHSa/4pthIyMKgZy6vUjd+z5GGK0lF827XswsJ60nkR2llPjpRHO8XW2HnOiwCAn
 1+s7YZpCfWBGLl6ylZok383nB4LSTsl33K0pJDdPxtWaSLpNchCl7IVbtiAL+875zSGhCfN
 6AZygclpMReD1LPJPAfVaW92nzfzn87EEzcL1RkGkS3U6wrBoUVPw4ObK9Mbq8viuDA4w9f
 CdWQAb00giXK0j2gWSWvuLmXscAhoVjRz8gNka1tJP2aUdq/4HcjWIY5X2UNJwQq9IfteTZ
 PetTXmqIYeNGeOf1itsbr2dD0qzVur40XzSlYwMs84n3T1xkCAvgjVgSPwzvUBoMVIIbo2o
 CwszjGZfR2CXV/ouB4TdHHoAmNou9aHvM4vhyBHwljJZWeOE4p1jBxefk89NCrFVUDErjD+
 nYxGBvrO5RqRQyF+9PDet2Oor0dHIMQTLKvedBxo1/K5a/GW9Z1gJwHoOJCkbiIeV0paGPm
 551Jk24JgbA+wESDqQUy1+4JhmgcQMCmQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0
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

Add new types of Wangxun NICs(Amber-Lite NIC models) into txgbe
supported NICs list, and supplement usage instructions.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 doc/guides/nics/txgbe.rst | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/txgbe.rst b/doc/guides/nics/txgbe.rst
index 93fb592759..3c741689a7 100644
--- a/doc/guides/nics/txgbe.rst
+++ b/doc/guides/nics/txgbe.rst
@@ -4,8 +4,12 @@
 TXGBE Poll Mode Driver
 ======================
 
-The TXGBE PMD (librte_pmd_txgbe) provides poll mode driver support
-for Wangxun 10 Gigabit Ethernet NICs.
+Supported NICs
+--------------
+
+- Wangxun 10 Gigabit Ethernet NICs
+- Wangxun 25 Gigabit Ethernet NICs
+- Wangxun 40 Gigabit Ethernet NICs
 
 Features
 --------
@@ -30,6 +34,7 @@ Features
 - FW version
 - LRO
 - Generic flow API
+- Forward Error Correction (FEC) (only for 25G NICs)
 
 Prerequisites
 -------------
@@ -37,6 +42,9 @@ Prerequisites
 - Learning about Wangxun 10 Gigabit Ethernet NICs using
   `<https://www.net-swift.com/a/383.html>`_.
 
+- Learning about Wangxun 25 Gigabit Ethernet NICs using
+  `<https://www.net-swift.com/a/25GbE-tong-yong-lei-FF5025.html>`_.
+
 - Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
 
 Configuration
@@ -139,6 +147,25 @@ Please note that following ``devargs`` are only set for backplane NICs.
   PHY parameter used for user debugging. Setting other values to
   take effect requires setting the ``ffe_set``.
 
+Please note that following ``devargs`` are only set for Amber-Lite NICs.
+
+- ``tx_headwb`` (default **1**)
+
+  Use to enable the TX Head Write-Back mode. In this mode, the hardware
+  merges and writes back a group of TX descriptors together to reduce
+  memory access times, which helps improve performance.
+
+- ``tx_headwb_size`` (default **16**)
+
+  Tx head write-back length. It is recommended to use the default values.
+  Setting other values to take effect requires setting the ``tx_headwb``.
+
+- ``rx_desc_merge`` (default **1**)
+
+  Use to enable the RX descriptor merge mode. In this mode, the hardware
+  merges and writes back a group of RX descriptors together to reduce
+  memory access times, which helps improve performance.
+
 Driver compilation and testing
 ------------------------------
 
-- 
2.21.0.windows.1

