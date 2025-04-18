Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBE1C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 10:35:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 178414042F;
	Fri, 18 Apr 2025 12:34:56 +0200 (CEST)
Received: from lf-1-20.ptr.blmpb.com (lf-1-20.ptr.blmpb.com [103.149.242.20])
 by mails.dpdk.org (Postfix) with ESMTP id D1F1E402E2
 for <dev@dpdk.org>; Fri, 18 Apr 2025 12:34:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1744972483; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=qaEBfkw14Me296rZv/lNDMKC0LFDU+XDKlSPLoz9AGc=;
 b=Ch87F6jfBz7W+tHh53ZM0k3KCfwzyKHNkZhX3yeKyXQZP1H9h7QfFG+cnhqC00L11YovMM
 e2DJFqF6SZtS2+1QOifuQoIuCMmbTS+pmFDGtBuTamsEbjQqkUzVYxGpExjYZqbmC2KnF3
 bC1E3rJElePAtJlVsmfScWUvpc3/rcEwGVc3u7dx01vuL6ebvlxgHrMvhXePfmihR/1ELm
 Wv+JmMy6+78QG3XKO0ku55g7vncGqVWqod+s8KieaNuxD1hn7TXA2TVP9/zJCOI5M72tlq
 5SjBTRCjzzKSwuz07D+at1PaqDuIuhhHI3id11TXd3PfbTd59+n6nATS9K0jnA==
Date: Fri, 18 Apr 2025 18:34:41 +0800
Mime-Version: 1.0
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
To: <dev@dpdk.org>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Fri, 18 Apr 2025 18:34:41 +0800
X-Lms-Return-Path: <lba+268022ac1+73d275+dpdk.org+wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.25.1
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
Subject: [PATCH 0/2]  Optimize the code to void resource leaks
Message-Id: <20250418103434.2489377-1-wanry@yunsilicon.com>
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

This patchset focuses on optimizing the code to avoid resource leaks.

Renyong Wan (2):
  net/xsc: fix resource leaks
  net/xsc: optimize release path

 drivers/net/xsc/xsc_dev.c    |  5 ++++-
 drivers/net/xsc/xsc_ethdev.c | 12 ++++++++++--
 drivers/net/xsc/xsc_np.c     |  1 +
 drivers/net/xsc/xsc_rx.c     | 14 ++++++++++----
 drivers/net/xsc/xsc_vfio.c   |  1 +
 5 files changed, 26 insertions(+), 7 deletions(-)

-- 
2.25.1
