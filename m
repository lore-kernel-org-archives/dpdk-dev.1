Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD3ACA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 21:41:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1402A427DB;
	Wed,  7 Oct 2026 23:41:28 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 9DC07427A9
 for <dev@dpdk.org>; Wed,  7 Oct 2026 23:41:26 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2e2e0f3dd40so30110305ad.3
 for <dev@dpdk.org>; Wed, 07 Oct 2026 14:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791409286;
 x=1792014086; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UClZpqC2oMBl/CGVyUeaI/7PYQI+hmALWFZZ0UfHGeY=;
 b=Z+FNauOI7V94TNcDLU2jEuuosqTmJFHSTn7vGJ7ISFRFu37UXgxy1GUP3vv+dyM74F
 9jMZbCeRl3gBTpR3uuxoJxtmEeg2WXU8NU3qhF3r4s/17XxJgsYSQG6MYd2czKijsiw0
 MfIC8xi5JCeq5Ug5k785UhCINgdl+AQ4xh9x08IdymJmiwf0AZz4pT9ya/QuQNSHoGVZ
 Yak8wzCR9nEmFqiWDHbapH2+61GNfQ/Wey1BP104uoWPaiDlxvV8zAambFgnm5ZJDv9o
 hj+7aMcKA2aWcKYA8NbXD2ggU43fMfWejYuxhATKWu+8ilG2707bqACD12nKeywfVALx
 ARmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791409286; x=1792014086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UClZpqC2oMBl/CGVyUeaI/7PYQI+hmALWFZZ0UfHGeY=;
 b=hNPMXAS/WmZckre5FTHgPJqoHZnJki2lVYQJtd0gwtiaA1D/+2JYmSg4PFfojy/waC
 k2jwMbYbV/yTGU56OHIs/htU8x5pj1bOUCxToL5rlY4S6ZzOU+z3IBkpwbRMVbGm567k
 WI80AEJQsog/OqGKTG5n2w3Etk4CJvGAKZ60wueckui0uob5h28speIJHoUXEvHXU5i0
 A/obl0qCaef3re+bkWekSw9Z+Q20Hxv527G08fXHzUcsd827KyaWukncMWb4BL1gIASN
 okGZ4gh7ZIwQbFkwizbL9/tzfzRySckF4MY7Ag/v5E78K1NCScYD3yASuEHVAo9sDdJ2
 Gpmw==
X-Gm-Message-State: AFq9FYKNPhsS1Vtjhilsr5NCfZE7t0OyzzVUH8lW/x2HE2CwVJT72Urv
 UKDmKFnqrG1EqOWioCS8GCn7zn2uDMPYWcvWgvU7GAJo+pBY5Lz0FjQb6abSPqZ23jgeRI+tHIs
 imw3/uXw=
X-Gm-Gg: AYBFou1cuG98AnaqyYoxiaf/x7oTsZdVUPtGthHRtSU6KHzNmNcI4oKQgJnMadvmeVd
 O5P/hORLUVNHcquXtfBNwV3MYt7AjJVkwfEDalRjxJ+FSpxo885mCwLgOZQ6/YcZdaWiEmzHxDd
 WyhMIB6W8uhyXAyxi11XJXT4D1pcbUolFtSWLfYJ7bYuUiu3M0ivnJfTZyTy8HtaT6xyP2jMFsP
 1Z75eVac3OLXdX7qjYE8dPN8VYC6VvNLEZQgM9KmtZB4AJRzZdjcWHjvg7VFm4mX49lvA0tnpi8
 cNp5X5W0m7wN0nP86H6WzbAIx1I3rrcDIp37wh+0APrEJppKL/ilJsPONk8/RyveArbehMmYP5M
 m+0thm4LGfaHYAYeAudV5DNNB3fJX3qQHe77ZRKuajXtfptXAV96c+kq5Gfh8LsZfEXLAvsPPAs
 9RE3yrd8IwKnF5OSZcSJ1ourT2enx4lbfZMQ2pOoqE4Dp4c7f8w9MgHZ/fjD6Px2xWjjcSgZiAt
 u89ScKTEcWkEfz7s4yiFWpcUoZ+3PES0IkD3Es=
X-Received: by 2002:a17:903:3c6e:b0:2dd:b52d:e83e with SMTP id
 d9443c01a7336-2e6003b5efbmr31594455ad.19.1791409285742; 
 Wed, 07 Oct 2026 14:41:25 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60484ca89sm16573335ad.57.2026.10.07.14.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:41:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 06/20] cmdline: promote bool token ops to stable
Date: Wed,  7 Oct 2026 14:39:36 -0700
Message-ID: <20261007214115.3092715-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007214115.3092715-1-stephen@networkplumber.org>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
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

The cmdline_token_bool_ops structure was added in 25.03 and has not
changed. It was the only experimental symbol left in the cmdline
library, where the other 69 exports are already stable.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 2 ++
 lib/cmdline/cmdline_parse_bool.c       | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 62e7df5728..3ad6ba2d81 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -221,6 +221,8 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* cmdline: Promoted ``cmdline_token_bool_ops`` from experimental to stable.
+
 * eal: Improved pointer arithmetic macros.
 
   * ``RTE_PTR_ADD``, ``RTE_PTR_SUB``, ``RTE_PTR_ALIGN``, ``RTE_PTR_ALIGN_CEIL``,
diff --git a/lib/cmdline/cmdline_parse_bool.c b/lib/cmdline/cmdline_parse_bool.c
index d5d5499531..ef41d2bc17 100644
--- a/lib/cmdline/cmdline_parse_bool.c
+++ b/lib/cmdline/cmdline_parse_bool.c
@@ -18,7 +18,7 @@ cmdline_get_help_bool(cmdline_parse_token_hdr_t *tk, char *dstbuf,
 		unsigned int size);
 
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(cmdline_token_bool_ops, 25.03)
+RTE_EXPORT_SYMBOL(cmdline_token_bool_ops)
 struct cmdline_token_ops cmdline_token_bool_ops = {
 	.parse = cmdline_parse_bool,
 	.complete_get_nb = NULL,
-- 
2.53.0

