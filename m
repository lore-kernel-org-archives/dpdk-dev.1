Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DCF606A320
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Nov 2026 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.a=rsa-sha256 header.s=feishu2403070942 header.b=hUXIbMet
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEB4E4060C;
	Sun, 22 Nov 2026 15:22:56 +0100 (CET)
Received: from lf-2-37.ptr.blmpb.com (lf-2-37.ptr.blmpb.com [101.36.218.37])
 by mails.dpdk.org (Postfix) with ESMTPS id 7416D402B9
 for <dev@dpdk.org>; Sun, 22 Nov 2026 15:22:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1795357367; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=JnGi7RSqFYAU/TwyPV4yTP6sqe3W/WtXqoCrkdtPyx4=;
 b=hUXIbMetk9gnL758xoKF7LymRiffMZSuvPM+Ot02B8vNtYSYFZRpauiUL14ZrzhYiLiot3
 8x5/9xxy+YoTXBj4Sq+E5ezYJ4mkV8vSbHeiUPw3x9V8ghe63zMd0dGKquNlao+s72D8Q9
 WvmngRvTX1HeJ19MF/3QWK2wTLiTensNkqt6cL83W4tHdJaXzEW9f4jsE3/JJnF231WOo1
 +QX0MEQv8fT6Ab+YCDTfBHqYO9vzSIfd1oD/s7ukFYZ2Xop//Hrr2z377KJ8bNKWegg60d
 gwtQJyrsrktBJK87aE8u7o3OQ9b0UYPcw9Ii6NLloc220ufmOfLaemCa0I7yFA==
From: "Renyong Wan" <wanry@yunsilicon.com>
Subject: [PATCH v5 2/4] net/xsc: fix leak on device init failure
Message-Id: <1795357356.655948@yunsilicon.com>
To: <dev@dpdk.org>
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.0.85] ([114.92.245.110]) by smtp.feishu.cn with ESMTPS;
 Sun, 22 Nov 2026 22:22:45 +0800
In-Reply-To: <1795357356.312312@yunsilicon.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Cc: "Stephen Hemminger" <stephen@networkplumber.org>, <nana@yunsilicon.com>, 
 <qianr@yunsilicon.com>, <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>, 
 <stable@dpdk.org>
X-Lms-Return-Path: <lba+26b02fab5+dfe1d0+dpdk.org+wanry@yunsilicon.com>
References: <1795357356.312312@yunsilicon.com>
Date: Sun, 22 Nov 2026 22:22:36 +0800
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

xsc_dev_init() leaks the structure when the dev_ops lookup fails. Free
it there: xsc_dev_uninit() cannot be used, as xsc_dev_close()
dereferences xdev->dev_ops.

Fixes: fb7d4f7ae39a ("net/xsc: add device initialization")
Cc: stable@dpdk.org
Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/xsc/xsc_dev.c b/drivers/net/xsc/xsc_dev.c
index 953409a9..f048efd7 100644
--- a/drivers/net/xsc/xsc_dev.c
+++ b/drivers/net/xsc/xsc_dev.c
@@ -375,6 +375,7 @@ xsc_dev_init(struct rte_pci_device *pci_dev, struct xsc_dev **xdev)
 	d->dev_ops = xsc_dev_ops_get(pci_dev->kdrv);
 	if (d->dev_ops == NULL) {
 		PMD_DRV_LOG(ERR, "Could not get dev_ops, kdrv=%d", pci_dev->kdrv);
+		rte_free(d);
 		return -ENODEV;
 	}
