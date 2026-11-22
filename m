Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C95B606A320
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Nov 2026 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.a=rsa-sha256 header.s=feishu2403070942 header.b=HWYEfZdy
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11A25402DC;
	Sun, 22 Nov 2026 15:22:53 +0100 (CET)
Received: from lf-1-18.ptr.blmpb.com (lf-1-18.ptr.blmpb.com [103.149.242.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 09D99402B9
 for <dev@dpdk.org>; Sun, 22 Nov 2026 15:22:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1795357363; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=sP1sSeaYiZ4T3GUIHqWJVJbNUPwoZZCgXCRDxNmBa+c=;
 b=HWYEfZdyo8y9tUHP24U8yFSaw5sX5UHX8qRu1gZd436nF4xa1cqWMQFXe9SnSI+se+crzz
 ku13H29VTcQa5MpEicD1rllvOagawuK7Cf1ahczBRfE5BATEScai7R7XzaXJECtYZecW8+
 dEWmKitkbEwiNSegDsXNZJQ6UKGeGThO1xl68teKW30L/jCL4xd87WfGQCYhS6wfaqjlKJ
 0kTzX5ZNLX1fopnqplkoGerClja6PaNtAYAUg2oWikDUiBjRoXQaEaFSUgbUMLkAHXVIou
 uOSrEmTY+OLY/om++hH7NQu4q7nD7MCK9+kKjSu2XEvx6IKFRT/sRAyfBprc6Q==
Cc: "Stephen Hemminger" <stephen@networkplumber.org>, <nana@yunsilicon.com>, 
 <qianr@yunsilicon.com>, <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
X-Lms-Return-Path: <lba+26b02fab1+ea766c+dpdk.org+wanry@yunsilicon.com>
Subject: [PATCH v5 0/4] net/xsc: fix issues reported by GCC analyzer
Date: Sun, 22 Nov 2026 22:22:36 +0800
Received: from [192.168.0.85] ([114.92.245.110]) by smtp.feishu.cn with ESMTPS;
 Sun, 22 Nov 2026 22:22:40 +0800
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: <dev@dpdk.org>
Message-Id: <1795357356.312312@yunsilicon.com>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v5:
- split the second patch in two, one fix per commit, as suggested by Thomas
- no code change, the resulting tree is the same as v4

v4:
- free the jumbo buffer only when the last representor stops the device, it
  is shared by every port and their Rx queues still point at it

v3:
- free the jumbo buffer in xsc_dev_close(), the device removal path does not
  go through xsc_dev_uninit()
- drop the redundant parentheses reported by checkpatch, no functional
  change

v2:
- address the AI review of v1: allocate the jumbo buffer once per device,
  fail the queue setup when there is no IOVA, and free it on device close
- fix the leak in xsc_dev_init() and the unchecked rte_malloc_socket()
- rename the jumbo buffer fields, they held the opposite of what their
  names say

Renyong Wan (4):
  net/xsc: fix jumbo buffer allocation and leak
  net/xsc: fix leak on device init failure
  net/xsc: check Tx queue allocation result
  net/xsc: rename jumbo buffer fields

 drivers/net/xsc/xsc_dev.c    | 17 ++++++++++--
 drivers/net/xsc/xsc_dev.h    |  4 +--
 drivers/net/xsc/xsc_ethdev.c |  6 ++++
 drivers/net/xsc/xsc_rx.c     | 53 ++++++++++++++++++++----------------
 4 files changed, 51 insertions(+), 29 deletions(-)
