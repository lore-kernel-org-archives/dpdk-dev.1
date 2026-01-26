Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851F4D1951B
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 23:25:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DBB040BA3;
	Tue, 27 Jan 2026 00:24:55 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 3C2DD40B9D
 for <dev@dpdk.org>; Tue, 27 Jan 2026 00:24:53 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so13528815e9.0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 15:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769469893;
 x=1770074693; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Avhl9YgiSxxdK9mVnQKAOQQ+ilaSko/avISOyDtECRA=;
 b=XPqO/5NW1jwxILdANHPJn77fv+LSvWcuOaKPCqpwqVEObxpCUnpljxyR1jzrh/wVxp
 zNbvBu9/V5Z4bxqFd1snayjVFJg58POU3RPsTosQ5404TIKa0HPJ3nYeCVqdfbTEKQPa
 TfVdVGpI3mxPwQQlfWUWXPkBdJVpvIfcWD8NlghwKC6q41BKiYvDg22dm927fvPMuHPm
 WmaCoAgMj79y5e2iZTlgvChiyLGsF3e45IsvKU0yqH85HsHV0wQfp/lgiFWL0/0EY7HS
 Hf02ZwYe/VBFOMuWVT9Weo5Zsu3Fp3I2r9ys5lqwGqo01LdSamagPd/7t8x3fN65yR0A
 jXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769469893; x=1770074693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Avhl9YgiSxxdK9mVnQKAOQQ+ilaSko/avISOyDtECRA=;
 b=UUfduIrgJuOlM69zhQAIdp7NXVNAOPb1wSg48WGy9K0MAyRc/Twp0UzmQUofuHhHZ7
 pKyNvAgVcXkLtR65soOJfe+Sd2+BC6NNU6YcvQggoo13wAkwuxeUvhKLcEOd6oNlnH7I
 4TV9Jx/z5Ialerf4VzAtRbZrGMCMt5qy4konMfrf9hUtZhRMEVNHg4Lo6iJQV4nPh0it
 c8E6vLh8DhyXXxEwuafX1qUjFvUfBrOtQgPEATVji4pTnlS/h0LGr2fEqNOmLWPPesSN
 9abtB67k/YHT8rR7q9DBlGRg5atLmJvhOvfj6OIwyrYWx1MQwEfNvsA59fCFNT5Gwhnz
 VgtQ==
X-Gm-Message-State: AOJu0Yw6rpLztVRnKMOvKHoNCv1Pa3t/5naQMpzY91hJYk9gcM/kEAXr
 oVcRW/vwLRQCmGtJrQQawIBek5jdGnbPLEWBEVccYxrPH5XOSR9E8uU3OaVlZNla+RValmVtWGr
 5MI6M
X-Gm-Gg: AZuq6aLI27+hQuWceHopsdhHwpY3PyuxfrVjXDAodBMYgxyoAJiyW5vsUP36GMlhpTD
 9FNignTV4EBjXxmVo0k9y4h84nmZ13E7nrRzFoYrnXhy9SkHlZi16Bj2dEJ+e+k7YGgL/KB9iSb
 l1qiWgYQk6DIMFfNT2zEQ/SZlzEqPYNxI9aHZ34qEtpHJtJqKa2yQbWAVRQrRo6ZRcDQTNLzBc3
 1j0rW4rZBK0ZjG1k1NcUpyoCW701pHKpyc5Pd6afOb1gusXVSn4b7Z3z2Mpb5hyT1q3R6PjKrxz
 JdeByXpP/kJtxqS0kGJAOoOKE15/nY+rw77AmheicBzixdAx+QNoy9MEW9bXFQFlhT3n6wXQLke
 34j35Ec+rjmWSwJNbkcfE/F8Z/UMVnPMytnSJBNVUMIRkLpiCAmWUvGWkg7fJe+EBypSDwR1QSk
 DltjtDKL6TzjnLXmZk0Wpq84f2kgRRj+GiKI0urd8cAKrOfbos/g==
X-Received: by 2002:a05:600c:1e02:b0:480:4d37:e742 with SMTP id
 5b1f17b1804b1-4805ce3fa29mr94270445e9.10.1769469892815; 
 Mon, 26 Jan 2026 15:24:52 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24a6fsm33711846f8f.16.2026.01.26.15.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 15:24:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v12 09/17] eal: avoid format overflow when handling addresses
Date: Mon, 26 Jan 2026 15:22:17 -0800
Message-ID: <20260126232428.276534-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126232428.276534-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260126232428.276534-1-stephen@networkplumber.org>
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

The largest possible string in this code 0xFFFFFFFFFFFFFFFF
which will overflow with only 15 character buffer.
Increase to 20.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index c62edf5e55..dccf9406c5 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -1153,8 +1153,9 @@ rte_eal_memory_init(void)
 #define EAL_MEMSEG_INFO_REQ		"/eal/memseg_info"
 #define EAL_ELEMENT_LIST_REQ		"/eal/mem_element_list"
 #define EAL_ELEMENT_INFO_REQ		"/eal/mem_element_info"
-#define ADDR_STR			15
 
+/* Address string is "0x" prefix + 16 hex digits + null */
+#define ADDR_STR			20
 
 /* Telemetry callback handler to return heap stats for requested heap id. */
 static int
-- 
2.51.0

