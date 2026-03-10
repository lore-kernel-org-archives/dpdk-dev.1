Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB79FCC9DE
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 08:31:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00E27402B8;
	Tue, 10 Mar 2026 09:31:24 +0100 (CET)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by mails.dpdk.org (Postfix) with ESMTP id CAE174014F
 for <dev@dpdk.org>; Tue, 10 Mar 2026 09:31:22 +0100 (CET)
Received: from localhost.localdomain (unknown [82.65.104.223])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 5D392780383;
 Tue, 10 Mar 2026 09:31:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1773131482;
 bh=y3xgFaux2FjD1LZShcklvXWAvOdk5C/F+3ZaEKQvmEo=;
 h=From:To:Cc:Subject:Date:From;
 b=f/SdEARi8PnIWMa44dazW6TJKyerxVugeU8OZkYvy9H5ppRak4xy+4aqygMlMh7Yt
 K/1ZNdlwAHePGdRB1rWORGISWp7EThnWardjm9Ve3+PNPoJWdaTT7XmmfEnlfP/KGi
 ZkbJa6af5CZFPEmSfZdUgQdbHIItQ90rG8v8nIYimFNLRNJbjSUcM8QKe2mR3cbZRh
 jZuuN9MDnH0zUNMHPUI2lz30WIFWPgliRqlxzL5p+OiH7C9F0DYyJR7vDDOV8X++On
 0hg/S/EH1ChhK3m/Br/6zh2nt2sDGe6LDK2vbjwG8SdgXvhMT9k42u7xG+M12+fSwm
 F4y9/jHEv1AdQ==
From: Vincent Jardin <vjardin@free.fr>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	Vincent Jardin <vjardin@free.fr>
Subject: [PATCH] mailmap: update Vincent Jardin email address
Date: Tue, 10 Mar 2026 09:31:17 +0100
Message-ID: <20260310083117.2746721-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
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

Update primary email to vjardin@free.fr and map the former
vincent.jardin@6wind.com address to it.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 .mailmap | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 6c4c977dde..a5d482d598 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1717,7 +1717,8 @@ Vikash Poddar <vikash.chandrax.poddar@intel.com>
 Vimal Chungath <vcchunga@amazon.com>
 Vinay Govindaiah <vigovind@amd.com>
 Vincent Guo <guopengfei160@163.com>
-Vincent Jardin <vincent.jardin@6wind.com>
+Vincent Jardin <vjardin@free.fr>
+Vincent Jardin <vjardin@free.fr> <vincent.jardin@6wind.com>
 Vincent Li <vincent.mc.li@gmail.com>
 Vincent S. Cojot <vcojot@redhat.com>
 Vinh Tran <vinh.t.tran10@gmail.com>
-- 
2.43.0

