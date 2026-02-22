Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CE0C636A0
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 17:34:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A60C40A80;
	Sun, 22 Feb 2026 18:32:58 +0100 (CET)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com
 [209.85.160.52]) by mails.dpdk.org (Postfix) with ESMTP id CF2A14067B
 for <dev@dpdk.org>; Sun, 22 Feb 2026 18:32:44 +0100 (CET)
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-40f1a1f77a6so2258220fac.2
 for <dev@dpdk.org>; Sun, 22 Feb 2026 09:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771781564;
 x=1772386364; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYgz5JtzUR1RR1s3Jg81Qy0Br1lL3kQsp+gTvD3OGDQ=;
 b=mFQOpWeZXI0N4y6s+orhQeSI9jH4jttOwa6kOpU9NtNNdoE0J6Yv5IIphIDuz80pbS
 hb4FH5KXFLf/SlE86jzdKLxVIicUGHYiS1ZYzcWv4lu402yc6h/uCGXoZG2DWLeBSznD
 Gt1snU+kAqWqEhRTCgGHQBXY7d+90GGNjK4kMBxIgsD/yZwq2fTRTeGG2T4hOxUJbm47
 uiyk2doxK9nlJ6UwtOO5lPfr0rq6LDRu5vAUM25sMX0Ovq4iJzb9nyao7BCzkMTWSjnk
 eCtopGEQXvxdLUyyx9McKaM3Atth1ZX08+skKGMTTOhO+LtFaNHb8RnjK+YXgnX6R01u
 Xfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771781564; x=1772386364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bYgz5JtzUR1RR1s3Jg81Qy0Br1lL3kQsp+gTvD3OGDQ=;
 b=tO6jTCvC0dcrnWqfSckyDuWtDnTaF74yfczw+/Pym5n9P4e/aGjXbdnQAY+itfut/S
 rYAth1zHJ3ONk5IXXUIArPNOrEYgDJZBuGgREmQFecN+IUBPSmivq52KeS2nQVPbnAYk
 W2z5vvhflcwieqPGoDdQ/zPiwxBjOqvziNkIkaVCPi0dxuvmrwcDIXiRhqcL7enxZZNR
 F5fpz+UgTrEXyXkT5Cq4R2maE7w0nRHUW1L/y7gGOb/15f8icOSDBz48vR5z97ThEhJL
 +HDE7BmAT9RFIvQfwnKiK3NEscCRuhzDNef8aQ+UBL6GjJgXDU8ArHa3bRSHNvg+UIDz
 eItA==
X-Gm-Message-State: AOJu0YyY8F+ydnKdXDIDSzl5yhiZv9GqnQKx30Ai+mBvLacN4zNctlOf
 UXBVpWCEljd/hXaS1ULxj3CPr5bSUhbNKBWSwi+M9/lS0iXKUrGibyJL6tJxdwRazDQWUXSbG/3
 gLWzH
X-Gm-Gg: AZuq6aLm+3WdtVn7ThPgg7d7CP74hchGd2tIy722UizTvG3wDDEa2J+egcw/RwtRuWa
 w5vIx/v4v4sralNaiZUKeGQ+N/7qAADI+wVDbbk21IbEZkYkwnCUsjQLMAmxINVDQGKY0Vs7Buo
 E9layQOCxgbRe1hxVcnUh4wWVd8suEbRG7wn/ADOYaMgQPUznFYTHE3t6jyJ3+0zyFEd6QHUwCp
 oP9pbzlEV75m+dmmbq/9tKbqxAC/9hnfPYNjVvyqVr6PajCHzsTzSfJ8dfuqHkSwPnnvCDEBSTa
 obfvg0AoDtRL67l54ti7VAxfwEzRsqojjGQG2q3PlEpVIrK8E/l1KS8asSYxLEv0vmXiVqAOtH5
 rwHO6xgcjI2Z3jZh7GXuUwd4x/7F/c2kwG13IXyCg94u4m/BId2owozoZGa193wFN6nzhFeEvQ9
 zpxqQ+L3u9ifNgpaeoY9EnQz2Oyug5WeXKSe+ouLrDI5ApUdLjQ9S0WFW4qnwzqA==
X-Received: by 2002:a05:6870:a2ca:b0:404:2e20:818b with SMTP id
 586e51a60fabf-4157ac8099dmr3644115fac.23.1771781564186; 
 Sun, 22 Feb 2026 09:32:44 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157d2d7922sm5608972fac.12.2026.02.22.09.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 09:32:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 14/19] net/tap: remove VLA in flow item validation
Date: Sun, 22 Feb 2026 09:30:49 -0800
Message-ID: <20260222173225.522754-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260222173225.522754-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260222173225.522754-1-stephen@networkplumber.org>
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

Replace variable length arrays in tap_flow_item_validate() with
fixed size buffers. The size parameter comes from flow item struct
sizes which are all small (largest is rte_flow_item_ipv6 at ~44
bytes).

Define TAP_FLOW_ITEM_MAX_SIZE (128) as the upper bound with a
safety check to reject unexpected sizes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/tap_flow.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tap/tap_flow.c b/drivers/net/tap/tap_flow.c
index da1e70019a..e33c6f8e2d 100644
--- a/drivers/net/tap/tap_flow.c
+++ b/drivers/net/tap/tap_flow.c
@@ -706,6 +706,13 @@ tap_flow_create_tcp(const struct rte_flow_item *item, struct convert_data *info)
  * @return
  *   0 on success.
  */
+/*
+ * Maximum size of a flow item in bytes.
+ * Must be larger than all supported rte_flow_item_* structures
+ * (currently the largest is rte_flow_item_ipv6 at ~44 bytes).
+ */
+#define TAP_FLOW_ITEM_MAX_SIZE 128
+
 static int
 tap_flow_item_validate(const struct rte_flow_item *item,
 		       unsigned int size,
@@ -754,11 +761,13 @@ tap_flow_item_validate(const struct rte_flow_item *item,
 	 * TC does not support range so anything else is invalid.
 	 */
 	if (item->spec && item->last) {
-		uint8_t spec[size];
-		uint8_t last[size];
+		uint8_t spec[TAP_FLOW_ITEM_MAX_SIZE];
+		uint8_t last[TAP_FLOW_ITEM_MAX_SIZE];
 		const uint8_t *apply = default_mask;
 		unsigned int i;
 
+		if (size > TAP_FLOW_ITEM_MAX_SIZE)
+			return -1;
 		if (item->mask)
 			apply = item->mask;
 		for (i = 0; i < size; ++i) {
-- 
2.51.0

