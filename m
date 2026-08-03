Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79680C55184
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:54:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BBA240B9C;
	Mon,  3 Aug 2026 18:53:31 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 2B80B40A6E
 for <dev@dpdk.org>; Mon,  3 Aug 2026 18:53:24 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2caed617615so48735525ad.3
 for <dev@dpdk.org>; Mon, 03 Aug 2026 09:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785776003;
 x=1786380803; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lapvp/IodBZRVG3QgR46Yu+3jZQ1Mm2TKg938FLk6VM=;
 b=b9WWsqjaB9hRPYVA2vKCiIE/2StbLQuKhN2Sgm94ISHHSukm+uqUnvFgmAZ+SJpl4F
 k7+KJLkxw+CkYy1YZ5nvv0bc6eVukWomyEFWrH/zkj13wmHfLRxPOwoT79MkkjTzZI4i
 ivxsHrxiHI81Z/XkB4F5+tUB+nj6PzCLgVFEpFQ9qJ+x+rtz3TNdNQWrEITRyggJwxw0
 RXPn+pVHuGOGUdjuPPWJVCMyKoZzMXye1TVGA/7cLEgwRLpr/AATpgnzWPT9mmfoh1vl
 ie9Ql/hFWaK4vFl+d5BLsn529/rdGne6Bq/BQmVjEtNnywecM6KL3iGyJJskDDNVzd04
 U6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785776003; x=1786380803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lapvp/IodBZRVG3QgR46Yu+3jZQ1Mm2TKg938FLk6VM=;
 b=QmxCvLAENfeuC6RVN27UDn+rM2SlShhKuprSawXXysSWUCf+pKswYKAKZrtOgmKOo/
 j6IrZit5T31yxwMHdvCrhKPCKWxNdubNFHzbRpyv1V510OrHdt4lMy+SYLeQhMVnpfJ0
 x0RAtZ7WlNAD7ninjx/IuUU3WaB3dHOeaQwMblf3iyMA6WOhasQhYStH08R298He5GoU
 o49GR2Da3e35uBdUklO12v4Wi71FpYOCtMlrLyD4fMtHI6VllgpRfze0smuUdnz0BLfm
 r+iYvxwRSVyg+vPnteQZizQqcnJbFB9bf+MZM2FYjKxerT3VfpCYCM/XvT9A54vqL6Ob
 C1Zw==
X-Gm-Message-State: AOJu0Yz0KTemrdDxxamz+0Aj3c9TuTghSGnwOSGwn3PiXDsiAnDJpR35
 E+o2nVVnggJQ2lyiu7ZPY0GnG0bO+LY+11auRTy0TzfRhzHQgR+fz4Cg8j4jI2kE6hoEfJRkB/n
 e38cQ
X-Gm-Gg: AR+sD11W1L65AUmGPqw3LdUL9yn4nzRIaESFOh2IuiLXdrOYwQdvwhWuOOU2QyQieav
 KblPmDGsiLj+jAU/t2YxQO81yOqARyDCtgNrB8IHw3k5nSASWZxRwlTqO8jzum0Jyb0Ma8lZzEG
 eA4ma47qmibF4dwpi93LPEEcOTYiQaY3nVhoQx9+fMYwB0LR2+DsKrCM/ssCa78dqcN1T7+2obq
 Lp6H64hDHDF0iUzoPybe6lQzgSzXfsvWz+YBcrEmtlOqBlCp/H6RXCiTr1XG8dWQz0tvRLzD4se
 L8gXaauBUQs4RQ8qK+gDWHTrqF21EwGZKVs9Io0sL8CBpQAe+8aya5BY8go3q28sLOhgOS6bdSi
 xBTUxsUOo2mZlEBvqcWgvvE4p7QjYhsMRPZdpQ0EFVeg6JoA/78EwwRXGHMNtJ7n9+oCJ7bdyOg
 6eSdDhNJNSmJf4bqUEcey/zOUpne7PJzfG0oLFQ5VNj2xT01WasreOPL2bAeZxleHqb3UcA5sjd
 CM0kzncFDwsfQMOiffbhl0FcDE=
X-Received: by 2002:a05:6300:6705:b0:3c3:c687:a3b9 with SMTP id
 adf61e73a8af0-3c92a8588a3mr11358912637.48.1785776003342; 
 Mon, 03 Aug 2026 09:53:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e5b0sm37711635eec.1.2026.08.03.09.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:53:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Akhil Goyal <gakhil@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH v2 16/22] examples: include network headers
Date: Mon,  3 Aug 2026 09:52:02 -0700
Message-ID: <20260803165304.289869-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803165304.289869-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
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

Don't depend on network protocol headers getting indirectly
included via rte_ethdev.h.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/l2fwd-macsec/main.c | 2 ++
 examples/l3fwd-graph/main.c  | 1 +
 examples/l3fwd/l3fwd.h       | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/examples/l2fwd-macsec/main.c b/examples/l2fwd-macsec/main.c
index 059f8a2170..e07769bd57 100644
--- a/examples/l2fwd-macsec/main.c
+++ b/examples/l2fwd-macsec/main.c
@@ -33,9 +33,11 @@
 #include <rte_debug.h>
 #include <rte_ether.h>
 #include <rte_ethdev.h>
+#include <rte_flow.h>
 #include <rte_mempool.h>
 #include <rte_mbuf.h>
 #include <rte_security.h>
+#include <rte_macsec.h>
 #include <rte_string_fns.h>
 
 static volatile bool force_quit;
diff --git a/examples/l3fwd-graph/main.c b/examples/l3fwd-graph/main.c
index 5f89286dce..79dee4d103 100644
--- a/examples/l3fwd-graph/main.c
+++ b/examples/l3fwd-graph/main.c
@@ -36,6 +36,7 @@
 #include <rte_per_lcore.h>
 #include <rte_string_fns.h>
 #include <rte_vect.h>
+#include <rte_ip.h>
 
 #include <cmdline_parse.h>
 #include <cmdline_parse_etheraddr.h>
diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h
index 349fc37c79..db7b746f59 100644
--- a/examples/l3fwd/l3fwd.h
+++ b/examples/l3fwd/l3fwd.h
@@ -8,6 +8,8 @@
 #include <rte_ethdev.h>
 #include <rte_vect.h>
 #include <rte_acl.h>
+#include <rte_ip.h>
+
 
 #define DO_RFC_1812_CHECKS
 
-- 
2.53.0

