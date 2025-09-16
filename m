Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91611CAC592
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 17:44:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7994E402C9;
	Tue, 16 Sep 2025 19:44:46 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4B9E540288
 for <dev@dpdk.org>; Tue, 16 Sep 2025 19:44:45 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1094)
 id 618AB20154F5; Tue, 16 Sep 2025 10:44:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 618AB20154F5
From: mamcgove@microsoft.com
To: dev@dpdk.org
Cc: Matthew G McGovern <mamcgove@microsoft.com>
Subject: [PATCH 0/2] examples/symmetric_mp: log/ignore promiscuous fail
Date: Tue, 16 Sep 2025 10:44:08 -0700
Message-Id: <cover.1758043370.git.mamcgove@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747766224-31511-1-git-send-email-mamcgove@microsoft.com>
References: <1747766224-31511-1-git-send-email-mamcgove@microsoft.com>
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

From: Matthew G McGovern <mamcgove@microsoft.com>

Changes all examples/multi_process apps to warn and continue
after a failure to enable promiscuous mode.

This is to allow their use with hardware which does not allow
changes to this mode setting.

Matthew G McGovern (2):
  examples/symmetric-mp: ignore promisc enable failure
  examples/mp_server: warn on promisc enable failure
---

v2:
* wraps commits/messages to width 70
* adds second commit to apply warn/continue to other mp examples

 examples/multi_process/client_server_mp/mp_server/init.c | 4 +++-
 examples/multi_process/symmetric_mp/main.c               | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.34.1

