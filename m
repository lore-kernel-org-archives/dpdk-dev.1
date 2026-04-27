Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8856EFF8875
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 09:58:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83F1D40664;
	Wed, 29 Apr 2026 11:58:22 +0200 (CEST)
Received: from mail.amicon.ru (unknown [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTP id 2C55B402BC;
 Mon, 27 Apr 2026 17:37:37 +0200 (CEST)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1777304256; h=from:subject:to:date:message-id;
 bh=4AekriRMVMkv7Di7Fxz/IN/dyP+pPoS889THVixyat8=;
 b=VgLijv6lWzCEpzBTgGNXQr31668R+Viah/+gOvf284L2bp1m6EFr3IP8mQ9o488PWfDiMBk+fy6
 gxQrpKOlF46CjLsgRtqKnw61cWKuogDjrMqW3ifDhNnGGnxII8K5eg7ZiacvBie99ljfP58/ClgRw
 jf6Y45wwPhb9j+TJ6c4tjVfC8JNqvtQmCc0WmJ7jIZhiZFGQB0NjDmMw5GabfcF6san9Z/BgdTIZB
 v2nmz8s89TriAWGYWSgAA9L88rpyrrYy5W3WgsDWOcTOopp2OO/ho90jLSv0M0H8k9L8vQqQXxtYq
 FrBfoXgPH2T6ZAcq2UBMcgAK1vDfP46DE7DA==
Received: from dish.amicon.lan (172.16.2.39) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 27 Apr
 2026 18:37:36 +0300
From: Daniil Iskhakov <dish@amicon.ru>
To: <dev@dpdk.org>
CC: Daniil Iskhakov <dish@amicon.ru>, <stable@dpdk.org>,
 <sdl.dpdk@linuxtesting.org>, <rrv@amicon.ru>
Subject: [PATCH v2] cmdline: prevent out-of-bounds read in completion buffer
Date: Mon, 27 Apr 2026 18:34:30 +0300
Message-ID: <20260427153430.1805689-1-dish@amicon.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Originating-IP: [172.16.2.39]
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)
X-Mailman-Approved-At: Wed, 29 Apr 2026 11:58:18 +0200
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

tmp_buf is populated by the completion callback and is not guaranteed
to be NUL-terminated.

The code already accounts for this when computing tmp_size with
strnlen(tmp_buf, sizeof(tmp_buf)). However, another loop in the same
path still walks tmp_buf until a NUL byte is found, without checking
the buffer limit.

If the callback writes a full-sized non-NUL-terminated string, the loop
may read past the end of tmp_buf.

Fix this by bounding the iteration with sizeof(tmp_buf).

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Daniil Iskhakov <dish@amicon.ru>
---
v2:
- Resent to dev@dpdk.org because v1 was accidentally sent only to
maintainers.

Cc: sdl.dpdk@linuxtesting.org
Cc: rrv@amicon.ru
---
 lib/cmdline/cmdline_rdline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/cmdline/cmdline_rdline.c b/lib/cmdline/cmdline_rdline.c
index ee070f0af3..bc91dc6002 100644
--- a/lib/cmdline/cmdline_rdline.c
+++ b/lib/cmdline/cmdline_rdline.c
@@ -445,7 +445,7 @@ rdline_char_in(struct rdline *rdl, char c)
 				rdline_puts(rdl, "\r\n");
 				while (ret) {
 					rdl->write_char(rdl, ' ');
-					for (i=0 ; i < sizeof(tmp_buf) && tmp_buf[i]; i++)
+					for (i = 0 ; i < tmp_buf[i]; i++)
 						rdl->write_char(rdl, tmp_buf[i]);
 					rdline_puts(rdl, "\r\n");
 					ret = rdl->complete(rdl, rdl->left_buf,
-- 
2.43.0

