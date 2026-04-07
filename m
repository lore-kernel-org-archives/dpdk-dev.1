Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93B4FB5190
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 03:53:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C763C4066F;
	Tue,  7 Apr 2026 05:52:29 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 617C240662
 for <dev@dpdk.org>; Tue,  7 Apr 2026 05:52:25 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-1273349c56bso5687600c88.0
 for <dev@dpdk.org>; Mon, 06 Apr 2026 20:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775533944;
 x=1776138744; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xn83CQTRZuHPFZL+HWFFncHa3BWj3cxSI4VDJ4gJkBE=;
 b=ieSQEZrJYHAQ6QL+vGFC6ojesggEGWKwFDQQ8QhpkZmqO6NiHdWXYfMsbjJ4ggz0gb
 S6aB/zpoQTPHG7gXAYjPOtX1fR+nh2CpSmx8IVeSMpatktTfOoKsTEGlnbmWULwynHlK
 C1BBLGaLRu8pxuG7K6KMQYdMeryEkG7ePfJXtfum6gWl5hkfG+6EMioA1Lxzgo89GJtq
 fEAcVmAUg9g1ytbepKFPOAkTxuxioJDoYNiNJ1IhdUczAap2fFWtIHLteCLHEuceoslq
 CWzPRPQtXjU2Ju/bHqsBoI28CFbrvNNCGVokc0fyaJ9qEObJY0/BCt8lU/VjOi7pNQuu
 aG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775533944; x=1776138744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xn83CQTRZuHPFZL+HWFFncHa3BWj3cxSI4VDJ4gJkBE=;
 b=ZnMuiB6u9rKOraQj8vG4SmDoC2eccHK0CS64d0kjE9Vf9Rwy4iBTpJBLu+3Zx+gOYs
 pxe5ViC59orinCNSAk5CQYb4RYVUABCKn0GWEbUttpZa+Lsc37pOlcBgdxC9x6ADt0xB
 RWOA+5k+PK2VYMFfqqAC7xNKlPjsVwsJVbr7g/2Fq2iIQsWRqyGOzmiwEYfHmWqaFL60
 2sjtTjKQtVOpcyxOlU8AWniYn09oMXaF9NYOe1Xn/q8+8R4J4thS/3hk+BrT5bPIRUxY
 k9d+tB33XFK1KvHFPASBxWKGLvdUfgmwFmvoMZsAc+zNiEdfVa467UlX7yyPKMY3nKcU
 zJNA==
X-Gm-Message-State: AOJu0Yx5jpqH+6uS+5KKrCfCTacdyAKJ0nLB9RSS8L7hvxo2z/aWKlCg
 OgCE5S9wtbPYHSdr7OsD9jgxU/Fa450ALFdgohe6RuUtpDsqVnkOqPPoGfzmUGJ7ch6pypHnoDg
 8xLwg
X-Gm-Gg: AeBDiesCNhT376RRm1kNxXc64JEoM9QtC1jHrg1YcQgmuwiypXrBGIUI1laOY89Zyl4
 o6FdjmOefyVJoUt+Sy7pp2znP6dujoWtYnMxah9tyTIEiOjWi0r9HiGC++nj/Xy57HsHh6Zp2Xi
 O0UqbTb7+7YZV5FLIHdP8HZhAF4Sgn/yv5WtzB99RgNRLjp++9+bI+r5Ui/mpar8mo1+qhmn5Q8
 vvohSm5P39qcJE2H2Ks6Jq8Ic3vNcTXGW/+mqWTUvleY9DYF8+IGJAAC9MV0vs1fP4etZRhZc9x
 NSL4M3YjwsRzxfyoA3lWD3xQXl2BkBZzxrzbiOIxFcWuS2mqAvg1uk7yjqR88pZJJCAPSu7q0Y5
 RqBFe0en3FlUZ2NtVIfQzOctzlH3mQ/tXVYAjQQar4jy1/hKnyY87d4WhC3XLwGV2bF9+M7+bSx
 Imk/QU8k3rIyx5nwvn19pz/yb2jHdv8Atd
X-Received: by 2002:a05:7022:221c:b0:128:d29a:3d45 with SMTP id
 a92af1059eb24-12bfb7459ffmr7282849c88.22.1775533944404; 
 Mon, 06 Apr 2026 20:52:24 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede545e8sm12716093c88.11.2026.04.06.20.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:52:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH 13/23] examples/bbdev_app: enable shadow warnings
Date: Mon,  6 Apr 2026 20:49:39 -0700
Message-ID: <20260407035209.650419-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407035209.650419-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
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

No shadows here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/bbdev_app/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/examples/bbdev_app/meson.build b/examples/bbdev_app/meson.build
index 283a9551b3..ea588e8706 100644
--- a/examples/bbdev_app/meson.build
+++ b/examples/bbdev_app/meson.build
@@ -11,4 +11,3 @@ allow_experimental_apis = true
 sources = files(
         'main.c',
 )
-cflags += no_shadow_cflag
-- 
2.53.0

