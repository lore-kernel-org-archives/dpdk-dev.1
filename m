Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E374606A32E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=SuppBqu2
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B19BE4042F;
	Tue,  3 Nov 2026 15:04:30 +0100 (CET)
Received: from forward105d.mail.yandex.net (forward105d.mail.yandex.net
 [51.250.60.165])
 by mails.dpdk.org (Postfix) with ESMTPS id C1AD3402DE
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:04:29 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-95
 (mail-nwsmtp-smtp-production-main-95.yp-c.yandex.net)
 by forward105d.mail.yandex.net (postfix) with ESMTPS id AA271100046;
 Tue, 03 Nov 2026 17:04:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95 with ESMTPSA id
 D4MpavSgc8c0-QW0CuS0T; Tue, 03 Nov 2026 17:04:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1793714668; bh=ABotHrUkC/LdmwecdUt4BAUbzeCBkHAnqHlZ1VXJ03k=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=SuppBqu2aB4lRr3rm2gDoQfSEmn2zPASRp6IXC5KxWY4xLgg4HeD9v1Z0MaEcmNp2
 6mqp76opQ2uLWCXJxu/SF0/wEs8N9WwJuQoS3trnBOGwG6sSTgHV4Otbdssbc8xIuI
 vuAn0Eya+2F+w62JsuLO11KMAuYshCeyQd1JT75c=
Authentication-Results: mail-nwsmtp-smtp-production-main-95;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	stephen@networkplumber.org
Subject: [PATCH] devtools: ignore context lines in check-symbol-change.py
Date: Tue,  3 Nov 2026 16:04:11 +0200
Message-ID: <20261103140411.484629-1-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The export regexps match any first character, so a context line
starting with a space, like the export macro next to a removed
function, is recorded as a symbol removal.

It makes the script report a false positive, for example removing
an experimental function while rte_eth_dev_get_dcb_info() is kept
a few lines below prints:
    INFO: rte_eth_dev_get_dcb_info in lib/ethdev has been
    removed from stable ABI.

Match only added and removed diff lines, starting with + or -.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
 devtools/check-symbol-change.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/devtools/check-symbol-change.py b/devtools/check-symbol-change.py
index b1daa2934a..9b79b9be49 100755
--- a/devtools/check-symbol-change.py
+++ b/devtools/check-symbol-change.py
@@ -10,9 +10,9 @@
 new_file_regexp = re.compile(r"^(\-\-\-|\+\+\+) [ab]/")
 file_header_regexp = re.compile(r"^(\-\-\-|\+\+\+) [ab]/(lib|drivers)/([^/]+)/([^/]+)")
 # From eal_exports.h
-export_exp_sym_regexp = re.compile(r"^.RTE_EXPORT_EXPERIMENTAL_SYMBOL\(([^,]+),")
-export_int_sym_regexp = re.compile(r"^.RTE_EXPORT_INTERNAL_SYMBOL\(([^)]+)\)")
-export_sym_regexp = re.compile(r"^.RTE_EXPORT_SYMBOL\(([^)]+)\)")
+export_exp_sym_regexp = re.compile(r"^[+-]RTE_EXPORT_EXPERIMENTAL_SYMBOL\(([^,]+),")
+export_int_sym_regexp = re.compile(r"^[+-]RTE_EXPORT_INTERNAL_SYMBOL\(([^)]+)\)")
+export_sym_regexp = re.compile(r"^[+-]RTE_EXPORT_SYMBOL\(([^)]+)\)")
 
 parser = argparse.ArgumentParser(
     description=__doc__,
-- 
2.47.3

