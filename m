Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC51D46634
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 23:01:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 006B4427BE;
	Fri, 16 Jan 2026 00:01:35 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id E5D1D4014F
 for <dev@dpdk.org>; Fri, 16 Jan 2026 00:01:32 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4801d98cf39so3788325e9.1
 for <dev@dpdk.org>; Thu, 15 Jan 2026 15:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1768518092; x=1769122892; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ze9ageluBUa5LL0gOdxGYjPxZevTRcErGk/hvG4DLbw=;
 b=aCfTtSBI+Xa6fo48N8CBpyLNAIAuUu9ePMYe0dZSN9vBjUxe2iQWLilpJ+N+WQHvgb
 FdtnKr0XGKlEqrb7TLz0kdOjACzb9G9nQlvrcPYQ3UH2ZCEcBFQU2ix+UViFWWRuqW00
 BP/fMjm3YntMxtcXrB8Iv1zX0COLoNAv954v/YenPKXPxjqMtk/sQ+TAWo6/9sddLgA0
 lWX034cGQbiB2rGBUgq8S7MtaLzHWh3sM5KzGzlRTTV2G6PEmYFjSeOImGiwntXRpMa8
 HDyb9CgOKmfT+ZtSQ9xsCXY4Kb3G8QFIw54O/O5LHZVpxSX6Mkr2Hs9GRXQS8FcgLEOq
 dPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768518092; x=1769122892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ze9ageluBUa5LL0gOdxGYjPxZevTRcErGk/hvG4DLbw=;
 b=Ll/F87Ab7TNFE8lWOfKucVhzTHdkWwq2ySs8Gn3rr2xCGqZN8r4ckRSMyyIeCW/tLm
 xW6DKYlpo8Ltpxp5TJXcUs4nGumetUA0KoDOjAInqRf6F7rqMORf9PnLF03rrZO0kd57
 41YKDIBGARmEGgFMhGBXquEfiMBXT3vYzebVriR+W5bM3dx9m35jRT8GrnNESH+rK61a
 uW+6BNb5PL3vhkFbNmBP52/I0JH33ejUSBCamDINYax3GCIUbrrFechQW+mVXLnMOkqk
 HdRgd6NaJnxnqn5o1z7cgQYjAZhfCyStuC0QaPdC9scb8DcKwO0eREe+8sSUQe8U+6AH
 eOlQ==
X-Gm-Message-State: AOJu0YyZimxPJjop4zVWCRU5m/fCRaDC9CPf7xUCqaQizI8a0InSFwxc
 M0drCQu63pTY/Y9TBUgxsYhvGudRLBYbbBDfNCvZUJmbd/TZ500WmtDE97Ej7uizLg/fRZj/0v3
 WXJ+3
X-Gm-Gg: AY/fxX6vpMDab/7smxV0QzYb8gck7QtHWS91sLIdjXu3OdBZNPmhL3Z8QgzvBJF8guv
 C3L3q9kPFkXccqnYK+zyMiyb6qZDff3z8sqENWpR1H7vwoj4YUM/VAbuNuowqKl0/0/U6Abd9EK
 rpIYrSs9vcd99mqWfopG4/mxLch7pdk2z0M+gdSlgkVs0U24ZDN6w9E9Ln7PLN9jzcvqJbK5TTL
 aldwGS1xE+2n+24BzVOgNo994uPwnGZK8GAY7c4Fg2dviEoOopR+ARL90bX0piILc6XA8VfzqQ7
 8N+dk7o6tJl90l5yd2mfAC+k0DKNPdxNWoFgEAc/nD2W3nI+L7dFFYJuJdbLP9cnO6a/7ptOoSp
 YK5vILS+WZgf+JyYV+ck182U97GVLMHwqOXrT9XnJ2cEgQ0ExRWXH6vS2em8xdRAEB0rqUfYkwF
 7BGF7T9XgaGs4VaIIldAhzokTgLlAeX9o/Xd4es0uRNv2lGwrZSsU=
X-Received: by 2002:a05:6000:2307:b0:432:5c43:5f with SMTP id
 ffacd0b85a97d-4356a053ea4mr1121608f8f.40.1768518092299; 
 Thu, 15 Jan 2026 15:01:32 -0800 (PST)
Received: from dpdk-test3.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921dedsm1572918f8f.9.2026.01.15.15.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 15:01:31 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v3 1/7] cmdline: include stddef.h for offsetof
Date: Fri, 16 Jan 2026 00:01:07 +0100
Message-ID: <4fc0de427d2cb295353260fc9c7e09603e1ad638.1768518003.git.sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1768518003.git.sismis@dyna-nic.com>
References: <cover.1768518003.git.sismis@dyna-nic.com>
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

Include <stddef.h> at the top of cmdline_parse.h before the
fallback offsetof macro definition. This prevents macro
redefinition warnings when building with MSVC which uses /WX
(warnings as errors).

The standard header provides offsetof on all platforms, and
including it first ensures the fallback is only used when truly
needed.

Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
---
 lib/cmdline/cmdline_parse.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/cmdline/cmdline_parse.h b/lib/cmdline/cmdline_parse.h
index d9a7d86256..c4131e4af5 100644
--- a/lib/cmdline/cmdline_parse.h
+++ b/lib/cmdline/cmdline_parse.h
@@ -7,6 +7,8 @@
 #ifndef _CMDLINE_PARSE_H_
 #define _CMDLINE_PARSE_H_
 
+#include <stddef.h>
+
 #ifdef __cplusplus
 extern "C" {
 #endif
-- 
2.43.7

