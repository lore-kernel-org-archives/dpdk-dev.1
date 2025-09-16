Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6C8CAC598
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 10:09:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABB8B402B1;
	Tue, 16 Sep 2025 12:09:06 +0200 (CEST)
Received: from lf-1-18.ptr.blmpb.com (lf-1-18.ptr.blmpb.com [103.149.242.18])
 by mails.dpdk.org (Postfix) with ESMTP id 7EF24402B1
 for <dev@dpdk.org>; Tue, 16 Sep 2025 12:09:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1758017339; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ocFvk05uwsV3f5Dqit4heIvYJedDsaJwteqcNnFAePw=;
 b=bAyQGiK3w/TlzdybAAMUJbcbaRjcpdFp3oQ2B5voV0gDqL2yu/8wHUqg6UyH/j/8hJ10ZI
 u8YvcDkkcLNfQ4mtDekJaXMAc/JQsx4qmbh6LkuXmNwnjYI1Tdk04OcV/rNnlACVqbXcT0
 3PgtyyZsNN/DU9ZuO6hbFup3p+JaGryx9fhZ/8c1OJefNbaQlqi6tVfb79kssXimXDihzR
 U27QfjAhSlzeLGPavuil69N6L6o+z70rtGr5QyZ5ODlWE81EdinMrkydDUPj3bqfe/Pj5W
 1m4L++o9iqDFpx2lyB6cSG0djCyL5SthMUIvComxxD5rvsM6g0AOeLwtXE2lwA==
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
Message-Id: <20250916100850.226649-1-wanry@yunsilicon.com>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
X-Lms-Return-Path: <lba+268c93739+a9425f+dpdk.org+wanry@yunsilicon.com>
Mime-Version: 1.0
To: <dev@dpdk.org>
Subject: [PATCH 0/2] net/xsc: PMD improvements
Date: Tue, 16 Sep 2025 18:08:56 +0800
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Tue, 16 Sep 2025 18:08:56 +0800
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.25.1
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

This series introduces interrupt and BAR handling improvements
to the Yunsilicon xsc PMD.
 

Renyong Wan (2):
  net/xsc: improve interrupt uninstall
  net/xsc: support compressed PCI BAR

 drivers/net/xsc/xsc_dev.c       | 20 ++++++++++++++++++++
 drivers/net/xsc/xsc_dev.h       |  9 +++++++++
 drivers/net/xsc/xsc_rx.c        | 14 ++++++--------
 drivers/net/xsc/xsc_vfio.c      | 26 ++++++++------------------
 drivers/net/xsc/xsc_vfio_mbox.c |  6 +++---
 5 files changed, 46 insertions(+), 29 deletions(-)

-- 
2.25.1
