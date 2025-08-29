Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E79C8303F
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 08:25:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4118F40651;
	Fri, 29 Aug 2025 10:24:58 +0200 (CEST)
Received: from lf-1-14.ptr.blmpb.com (lf-1-14.ptr.blmpb.com [103.149.242.14])
 by mails.dpdk.org (Postfix) with ESMTP id 8AA48402ED
 for <dev@dpdk.org>; Fri, 29 Aug 2025 10:24:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1756455885; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=cosBqUZzSqmkGDLqStp1+5AapS0hxhJYm49wWpRZjeg=;
 b=Og5SFgEdvV2CfUSWtyLyFq56B3FhELzrdMwAAobMohuomoORnMtK9XLVF3BEtwCpo/YN4b
 QqBJoHKBe3mU6NOIfgvBz6atXGrDYh3XcMMBnHi/tRFOe0dExfYLZtewUr95ElubPgOEIo
 Ti4i05k+cy5kbmpVFiRgGWyCct1J7Ga0RHlKRcKd0Rv5oi2JWRSJwh2ffA9EIPcv360iUB
 KbOxV2hZfwW644Veyhd+6tSsUU0zd4ktQNxo7ZIF0KnO1Wi1ict6PAO4BtNRfQkFJccoNB
 6SqCAUCMvOGqRtKW+GuwxteKeOIpN6EN66Z9YY/qZfOttc2rINymOoNvX9prDQ==
Date: Fri, 29 Aug 2025 16:24:42 +0800
Message-Id: <20250829082406.24369-1-wanry@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Fri, 29 Aug 2025 16:24:42 +0800
To: <dev@dpdk.org>
From: "Renyong Wan" <wanry@yunsilicon.com>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
Subject: [PATCH 00/14] net/xsc: PMD updates
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.25.1
X-Lms-Return-Path: <lba+268b163cb+2467cd+dpdk.org+wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
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

This series introduces multiple updates to the Yunsilicon xsc PMD,
including new feature support, optimizations, bug fixes.
Highlights include:

* Firmware version query support
* TSO and FEC support
* EEPROM dump and promiscuous mode
* Link status and event support
* Optimizations for RSS, QP/CQ allocation, and Rx path
* Fix for Coverity-reported issue


Renyong Wan (14):
  net/xsc: add FW version get support
  net/xsc: add TSO support
  net/xsc: support module EEPROM dump
  net/xsc: support promiscuous mode
  net/xsc: add link status support
  net/xsc: add link status event support
  net/xsc: add FEC get and set support
  net/xsc: optimize RSS queue creation
  net/xsc: optimize QP and CQ memory allocation
  net/xsc: optimize Rx path
  net/xsc: optimize stop and close
  net/xsc: support per port for multi-process
  net/xsc: fix uninitialized value
  net/xsc: update release notes for xsc PMD

 doc/guides/nics/features/xsc.ini       |   7 +
 doc/guides/rel_notes/release_25_11.rst |  13 +
 drivers/net/xsc/xsc_cmd.h              | 186 +++++++++++-
 drivers/net/xsc/xsc_defs.h             |   5 +
 drivers/net/xsc/xsc_dev.c              | 361 ++++++++++++++++++++--
 drivers/net/xsc/xsc_dev.h              | 116 ++++++-
 drivers/net/xsc/xsc_ethdev.c           | 334 +++++++++++++++++----
 drivers/net/xsc/xsc_ethdev.h           |   4 -
 drivers/net/xsc/xsc_np.c               |  89 ++++--
 drivers/net/xsc/xsc_np.h               |  34 ++-
 drivers/net/xsc/xsc_rx.c               | 248 +++++++++++----
 drivers/net/xsc/xsc_rx.h               |   1 +
 drivers/net/xsc/xsc_rxtx.h             |   3 +
 drivers/net/xsc/xsc_tx.c               |  14 +-
 drivers/net/xsc/xsc_tx.h               |   3 +-
 drivers/net/xsc/xsc_vfio.c             | 399 ++++++++++++++++++++++++-
 16 files changed, 1605 insertions(+), 212 deletions(-)

-- 
2.25.1
