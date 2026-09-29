Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D876CA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 12:44:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19B6C411F3;
	Tue, 29 Sep 2026 14:44:58 +0200 (CEST)
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net
 [178.154.239.84])
 by mails.dpdk.org (Postfix) with ESMTP id 9A2E94113D
 for <dev@dpdk.org>; Tue, 29 Sep 2026 14:44:56 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:2e00:0:640:496c:0])
 by forward101a.mail.yandex.net (postfix) with ESMTPS id B62CC81575
 for <dev@dpdk.org>; Tue, 29 Sep 2026 15:44:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id dihNDx2dWeA0-APuwvPlF; 
 Tue, 29 Sep 2026 15:44:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790685895; bh=SE5JUsvepnOeY4WWUtUiOuLRk9Su082YRDMHcepCGjg=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=BWZBwK+QHIFJvIVGDezU/LvDnVf4uGI1PtEjKP+0fmtu1fagLIVA9M69FaIltqlNZ
 Orlw1mU7JSHjcJ7ZP0kz0Q6GUlR5syzMTbj/6Kr5Rx4Q9ytmSIGS7CXp4F8GgK3039
 1J6qXCgaEZ6Qq7jvAs7dDkKbkuG2PIvJ0T8sZ1Ug=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: konstantin.v.ananyev@yandex.ru
To: dev@dpdk.org
Cc: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Subject: [PATCH] mailmap: remove obsolete email addresses
Date: Tue, 29 Sep 2026 13:44:37 +0100
Message-ID: <20260929124437.87637-1-konstantin.v.ananyev@yandex.ru>
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

From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>

Remove email addresses that are either already obsolete,
or will become obsolete in the nearest future.

Signed-off-by: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
---
 .mailmap | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 2e348c3bce..e069cac61a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -894,8 +894,7 @@ Kishore Padmanabha <kishore.padmanabha@broadcom.com>
 Klaus Degner <kd@allegro-packets.com>
 Kobi Kenzi <kobikenzi@gmail.com>
 Kommula Shiva Shankar <kshankar@marvell.com>
-Konstantin Ananyev <konstantin.ananyev@huawei.com> <konstantin.v.ananyev@yandex.ru>
-Konstantin Ananyev <konstantin.ananyev@huawei.com> <konstantin.ananyev@intel.com>
+Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
 Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
 Krishna Murthy <krishna.j.murthy@intel.com>
 Krzysztof Galazka <krzysztof.galazka@intel.com>
-- 
2.43.0

