Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07F6CDB471
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 16:52:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADE6240A4B;
	Tue, 23 Jun 2026 18:52:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 71FE240677;
 Tue, 23 Jun 2026 18:52:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782233531; x=1813769531;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=18rWuEqVrwewCqZk42347WMp8ZQrw63Ljxm4aresZJE=;
 b=hRpEM3jrTF2W2Gf/ejP2aUBLoU/QxPYUQw44W6DNVc8HiBNP0HILPEZn
 Ujyir+XS4zpNQdk8yJoN3AWJbohLH0v4oFZKykYly14xqyxrkXMXIcqsY
 6NTViXADR9Vvqca1Kkm2pbvR/22beGCaK6b0Qa9eCEijP9ZCA0MFV5ebg
 z4H7klZjT7yTsjAZZ2HTIA4obYN+8+ynriqaslyfbc2jM6o+QaS0oYR6b
 bj5fhmgiAIt/SaMi5vW6AodLLdCCG9oTMi/2I49IN+4cvb/KvXG4NRU5r
 zOKCvL7IVmkHzmbre4eoLJ1suoiQa5ZrnHlfg4yu+hmVlPpLlzkfOnyCy A==;
X-CSE-ConnectionGUID: /3s1h961RpiLX+8/sYQIbg==
X-CSE-MsgGUID: 9Rxh79PgShWDIYMq4yE3Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100534647"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="100534647"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 09:52:10 -0700
X-CSE-ConnectionGUID: 6wm7Df0QT/qWNPF0AkONkA==
X-CSE-MsgGUID: n06CHvGxT/WhBRaP873jiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="253928329"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 23 Jun 2026 09:52:08 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH 08/17] net/cnxk: replace strncpy with strlcpy
Date: Tue, 23 Jun 2026 17:51:38 +0100
Message-ID: <20260623165150.765443-9-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623165150.765443-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Replace strncpy() with safer strlcpy() which always null-terminates.

Fixes: 804c585658ea ("net/cnxk: add representor control plane")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/cnxk/cnxk_eswitch.c | 4 ++--
 drivers/net/cnxk/cnxk_rep_msg.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_eswitch.c b/drivers/net/cnxk/cnxk_eswitch.c
index e45c7dfd07..50c3e54109 100644
--- a/drivers/net/cnxk/cnxk_eswitch.c
+++ b/drivers/net/cnxk/cnxk_eswitch.c
@@ -124,8 +124,8 @@ cnxk_eswitch_dev_remove(struct rte_pci_device *pci_dev)
 				}
 				sun.sun_family = AF_UNIX;
 				sunlen = sizeof(struct sockaddr_un);
-				strncpy(sun.sun_path, CNXK_ESWITCH_CTRL_MSG_SOCK_PATH,
-					sizeof(sun.sun_path) - 1);
+				strlcpy(sun.sun_path, CNXK_ESWITCH_CTRL_MSG_SOCK_PATH,
+					sizeof(sun.sun_path));
 
 				if (connect(sock_fd, (struct sockaddr *)&sun, sunlen) < 0) {
 					plt_err("Failed to connect socket: %s, err %d",
diff --git a/drivers/net/cnxk/cnxk_rep_msg.c b/drivers/net/cnxk/cnxk_rep_msg.c
index a222e2b5cd..7b92e7a5f7 100644
--- a/drivers/net/cnxk/cnxk_rep_msg.c
+++ b/drivers/net/cnxk/cnxk_rep_msg.c
@@ -138,7 +138,7 @@ open_socket_ctrl_channel(void)
 
 	memset(&un, 0, sizeof(struct sockaddr_un));
 	un.sun_family = AF_UNIX;
-	strncpy(un.sun_path, CNXK_ESWITCH_CTRL_MSG_SOCK_PATH, sizeof(un.sun_path) - 1);
+	strlcpy(un.sun_path, CNXK_ESWITCH_CTRL_MSG_SOCK_PATH, sizeof(un.sun_path));
 
 	if (bind(sock_fd, (struct sockaddr *)&un, sizeof(un)) < 0) {
 		plt_err("Failed to bind %s: %s", un.sun_path, strerror(errno));
-- 
2.53.0

