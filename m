Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23459CD13D3
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 20:38:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 192A540274;
	Thu, 30 Apr 2026 22:38:41 +0200 (CEST)
Received: from mail.amicon.ru (unknown [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTP id D43A0400D6;
 Thu, 30 Apr 2026 19:01:38 +0200 (CEST)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1777568495; h=from:subject:to:date:message-id;
 bh=D0W5Qudi38jL6O6nCihauVK7Huee7hL1or3nAZv61Mk=;
 b=GNDSVWVi3BixP2h41b24IIqWckzKSHxbR8RxIXkK6GWqrulUrUTVypZeJNelS194SLY99JxquR3
 u5biMKxMEFhJu52ew82uWQUWBeSxfCaM7SMNDeNSDN5tewM+6HOHDdORO5ZtCA8IUv8V6/hR4IzSx
 eh9Pi/P/fv3B9rmvlRQwWsYgUVA9RVlIXkicFU63vgSBbbpO0l/IP5JUcJMqIqTiqsZHEs+2ux1ft
 3+I0Pq9cDelBaV6V5gCsmMfIj3bV6WZtbgAGZRWBfnNpzfBWazb+ObVvSXyrMdxXd2dpT9R2i6cOZ
 +RZuIChsbwDrsDqN0m/2BhJ2TClJBhicA/EA==
Received: from dish.amicon.lan (172.16.2.39) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Thu, 30 Apr
 2026 20:01:35 +0300
From: Daniil Iskhakov <dish@amicon.ru>
To: <dish@amicon.ru>
CC: <dev@dpdk.org>, <rrv@amicon.ru>, <sdl.dpdk@linuxtesting.org>,
 <stable@dpdk.org>
Subject: [PATCH v3] cmdline: prevent out-of-bounds read in completion buffer
Date: Thu, 30 Apr 2026 20:01:11 +0300
Message-ID: <20260430170111.1557768-1-dish@amicon.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427153430.1805689-1-dish@amicon.ru>
References: <20260427153430.1805689-1-dish@amicon.ru>
MIME-Version: 1.0
X-Originating-IP: [172.16.2.39]
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)
X-Mailman-Approved-At: Thu, 30 Apr 2026 22:38:39 +0200
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

Fix this by computing a bounded length for each completion choice before
printing it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Daniil Iskhakov <dish@amicon.ru>
---
v3:
- Reworked the choice-printing loop to use a bounded length.
- Fixed coding style issues in the diff.
- Rebased and regenerated the patch; v2 did not apply cleanly.

v2:
- Resent to dev@dpdk.org because v1 was accidentally sent only to
  maintainers.

Cc: sdl.dpdk@linuxtesting.org
Cc: rrv@amicon.ru
---
 lib/cmdline/cmdline_rdline.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/cmdline/cmdline_rdline.c b/lib/cmdline/cmdline_rdline.c
index 0a5a399b32..e1770f0a1d 100644
--- a/lib/cmdline/cmdline_rdline.c
+++ b/lib/cmdline/cmdline_rdline.c
@@ -444,8 +444,9 @@ rdline_char_in(struct rdline *rdl, char c)
 				/* choice */
 				rdline_puts(rdl, "\r\n");
 				while (ret) {
+					tmp_size = strnlen(tmp_buf, sizeof(tmp_buf));
 					rdl->write_char(rdl, ' ');
-					for (i=0 ; tmp_buf[i] ; i++)
+					for (i = 0; i < tmp_size; i++)
 						rdl->write_char(rdl, tmp_buf[i]);
 					rdline_puts(rdl, "\r\n");
 					ret = rdl->complete(rdl, rdl->left_buf,
-- 
2.43.0

