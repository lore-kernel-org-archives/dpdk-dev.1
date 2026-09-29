Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA54CCA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 07:08:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE87940EE4;
	Tue, 29 Sep 2026 09:08:16 +0200 (CEST)
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net
 [178.154.239.81])
 by mails.dpdk.org (Postfix) with ESMTP id 7809B40A84
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:08:11 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:290e:0:640:f317:0])
 by forward501a.mail.yandex.net (postfix) with ESMTPS id 48A77828AD;
 Tue, 29 Sep 2026 10:08:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id a7cWxixi4iE0-5mpATnIu; 
 Tue, 29 Sep 2026 10:08:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790665690; bh=dZ21s1QxsWz9eQ5WDSHvxFiTeyj3dzpq+Vk6urHlNsQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=jZKvEzR3Uuzk8GszPlFXtLJf0CBbCuleGsYhM+AkZo296p2CUrilhEYpGBoRKVQ8c
 x9JFCt9qjXHSvfcEQWTRe7WSTbvPeSEli9fbZKaZA136c0BcIUs+pra6FQ32CF23O2
 KPy6JEithW/njRJMglnn6hObrfDrZNJR9jrFE5OQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 4/6] ethdev: avoid unaligned access in SFF-8472 decoder
Date: Tue, 29 Sep 2026 09:07:32 +0200
Message-ID: <20260929070734.1106134-5-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929070734.1106134-1-roma55592@yandex.ru>
References: <20260927112041.775972-1-roma55592@yandex.ru>
 <20260929070734.1106134-1-roma55592@yandex.ru>
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

The external calibration coefficients of the RX power are big-endian
floats in page A2h. They are read by casting the byte buffer
to a 32-bit pointer, which is an unaligned access if the buffer
is not 4-byte aligned.

The telemetry command always decodes a buffer from calloc(),
but an application may pass any buffer once the decoders are exposed.

Read the value with memcpy() and convert it with rte_be_to_cpu_32().

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
v3: new patch

 lib/ethdev/sff_8472.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/ethdev/sff_8472.c b/lib/ethdev/sff_8472.c
index f58eba9d2d..cdb6ef1f7e 100644
--- a/lib/ethdev/sff_8472.c
+++ b/lib/ethdev/sff_8472.c
@@ -4,6 +4,9 @@
  */
 
 #include <stdio.h>
+#include <string.h>
+
+#include <rte_byteorder.h>
 
 #include "sff_common.h"
 
@@ -126,7 +129,7 @@ static struct sff_8472_aw_flags {
 
 /* RXPWR(x) are IEEE-754 floating point numbers in big-endian format */
 #define A2_OFFSET_TO_RXPWRx(offset) \
-	(befloattoh((const uint32_t *)(data + SFF_A2_BASE + (offset))))
+	(befloattoh(data + SFF_A2_BASE + (offset)))
 
 /*
  * 2-byte internal temperature conversions:
@@ -169,14 +172,17 @@ static void sff_8472_dom_parse(const uint8_t *data, struct sff_diags *sd)
 }
 
 /* Converts to a float from a big-endian 4-byte source buffer. */
-static float befloattoh(const uint32_t *source)
+static float befloattoh(const uint8_t *source)
 {
 	union {
 		uint32_t src;
 		float dst;
 	} converter;
+	rte_be32_t be;
 
-	converter.src = ntohl(*source);
+	/* the source may be unaligned */
+	memcpy(&be, source, sizeof(be));
+	converter.src = rte_be_to_cpu_32(be);
 	return converter.dst;
 }
 
-- 
2.47.3

