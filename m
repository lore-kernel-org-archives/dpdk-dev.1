Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9ADC021B2
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 03:59:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EA2742DB0;
	Sat, 22 Feb 2025 04:58:10 +0100 (CET)
Received: from lf-2-40.ptr.blmpb.com (lf-2-40.ptr.blmpb.com [101.36.218.40])
 by mails.dpdk.org (Postfix) with ESMTP id 142B742D89
 for <dev@dpdk.org>; Sat, 22 Feb 2025 04:58:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740196682; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=p2bhbCzDHGDGosgh3bIVzxleBQVeiQOoJhCc1YK/gHc=;
 b=PE1WV79AeJ5MiOzdhwDRhGVYHXaFxX630UrcNZlJQidgWCzG+Q8yhGkChxe413wVN6m8Pt
 bdvJKIXYaSrRkxSDwGtlEG6XcvFKeLEHZVE8iAWweIIQWQL8Rm2nt4BUxS6YSJlNbLFzrO
 Ut3TDF68CSD8Wg8TVvopo55M8lYzL9IA1OH1thLvMkQHDrnVx0ly4UNRroM0JlqSZjft8R
 vL+bFd8KlgifM+/Zgbx/1HGziCoKfn5Plzn73lUYVn8NQhOd+WgfUyIf3u5wJiPJ/dxokb
 4geCjIS/Vh09v7oqBYP72n4z4peHtekW0NfOD5y22kNlEdak/u495BCcTW+ryA==
Subject: [PATCH 00/12] net/xsc: Resolve issues from PVS and Coverity Scan
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1
To: <dev@dpdk.org>
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
X-Lms-Return-Path: <lba+267b94b48+a7f453+dpdk.org+wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
From: "Renyong Wan" <wanry@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Sat, 22 Feb 2025 11:57:59 +0800
Date: Sat, 22 Feb 2025 11:57:59 +0800
Message-Id: <20250222035732.2290067-1-wanry@yunsilicon.com>
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

This patch series resolves several issues reported by PVS and Coverity Scan,
which were earlier forwarded to us by Stephen Hemminger.

---
Renyong Wan (12):
  net/xsc: avoid integer overflow
  net/xsc: remove useless call
  net/xsc: address incorrect format warnings
  net/xsc: remove always-true if expressions
  net/xsc: avoid variable is assigned but not used
  net/xsc: check possible null pointer dereference
  net/xsc: avoid potential null pointer before used
  net/xsc: remove always-true part of if expression
  net/xsc: avoid assign the same value to a variable
  net/xsc: avoid initialize by same function
  net/xsc: optimize memcmp returns not 0 check
  net/xsc: avoid pointer cast to unrelated class

 drivers/net/xsc/xsc_dev.c       |  2 +-
 drivers/net/xsc/xsc_ethdev.c    | 35 ++++++++----
 drivers/net/xsc/xsc_np.c        | 17 +++---
 drivers/net/xsc/xsc_rx.c        | 31 ++++++-----
 drivers/net/xsc/xsc_tx.c        |  7 +--
 drivers/net/xsc/xsc_vfio.c      | 97 ++++++++++++++++++++-------------
 drivers/net/xsc/xsc_vfio_mbox.c |  2 +-
 7 files changed, 111 insertions(+), 80 deletions(-)

-- 
2.25.1
