Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE90C44508
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 00:55:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3EBD427E6;
	Thu, 22 Jan 2026 01:54:33 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 3E74840E28
 for <dev@dpdk.org>; Thu, 22 Jan 2026 01:54:32 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa9so242695f8f.1
 for <dev@dpdk.org>; Wed, 21 Jan 2026 16:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769043272;
 x=1769648072; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ATjpIgm3TcyOIHskshB+3NEP+Z24+H+qrUUy6k4E8s=;
 b=DNy2TyET4Zzoeoiuen1QsTUbu7d7W3qT1/VNUEwLSEdl/WeNhkaZ28clg4c2zhDDSU
 m66LkMbq+GYw8y+P+CXhdO0K4QAwuuMgYcazkbM+vbZaj8DCej6zjHUuVTIjURKer3V4
 eXo3jkrHE525yCkq7OGc10QPCbgOeVkAUeSJ8US6JQUqOT5EgrB5U6k3qLoDs5j8jdbr
 ehYVtdRxXunzJAOSY8xp7O4GCHtFazQ6JHcoJ/YnPyTT3MGACMxpy7vZ9PNDDksJ6uKw
 hV5QsMmkJ7xdkRyU1fLtEXlX9UNvTYOWfyJ5NZprY9XoVN3ayPHKjdek2ZvoHdUPq0fj
 IM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769043272; x=1769648072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5ATjpIgm3TcyOIHskshB+3NEP+Z24+H+qrUUy6k4E8s=;
 b=UmbfHZBeawMPHwKdz4Q8jH58TAf+17zKNgaoogRM5VUqhwq0i4z8ped3oF7x/VxrUC
 /0+IZdVuWdnvMu+WmxVdDx8rc7JG4wnVMaUQPoPY6XsSzoiLuyBGnFUI/ofW1/rDGFac
 Rau5A2HDkwfqTpjh/aDb/aeg6tdi5i6XIJeIS3gmACPKnny6z7rDO4kn3VL9uMjvY7Fe
 WKy5Rfkur36u2/kNAOAQw6yHMH1pH37EUSURtnRUV+j0egWIFXKH1eY3zIu1fGkW1qiZ
 FoFhrIrOkO5IE1jxsxPpbkRksWJBsKih+QPuZ3iETPKOWNpC4OL3JwESu3oKnct6lMl8
 /P+g==
X-Gm-Message-State: AOJu0YyXs1v5Aof9XN37EwmnlWVbosJQ+/Ipy5eJJ7ZQ+LdsJQSj30Ho
 WGRirADr6lbDOh4b3lA8SmuQNNy/UMri9nvqBrUrQvlxz+3P/uw14xFr20Q3Mwwr6MWv8DnTV0B
 U56mv
X-Gm-Gg: AZuq6aIZmACTyNLhLpeDpCrv6ptFXE/h4RUhiPBkA0XnJyuGUUb2QZRiIuKnKS1AIUM
 M9OhDZ0XgNDnFUEOwgLOeEIW75PCfSSBGmxKU2MHgoeQcmI35R+G8/OB8OoWzYbWaY/0DnooKYf
 GfnX7Hx/mdQiAO6KpFd++SPZBeQimcvYdu6opeU7MgOEZQHicUDqgS7JpXQUi8icknZyUX/JqBS
 5RjpmPVUmvUGbTnXenNsdR+7gC2rkZqqEfhRg7VWDKPXZ/LzBVfrHDqcQkH6plqIsR42JpTtq9A
 44WYY3isBEGMs8hoJLVRbuFmzvBfDh+vDG0f7f+2qWlTNofFei0zQEgfZQYpVoLu+ntW123mVlJ
 q3ZclKKwoEurTS2xl22x47I0E6S5Gee21G35xwN7W2dWqd+bVubjNsC1PJZEcRO0BCn/5eLT0SJ
 fiOssC5Du48fv348475PphUJY/R8LN6zKlfi1F0g53CK0mWppB2A==
X-Received: by 2002:a05:6000:2281:b0:431:32f:3159 with SMTP id
 ffacd0b85a97d-4356a024930mr26420997f8f.7.1769043271852; 
 Wed, 21 Jan 2026 16:54:31 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e6dasm41695104f8f.32.2026.01.21.16.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 16:54:31 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v3 13/14] test/vdev: skip test if no null PMD
Date: Wed, 21 Jan 2026 16:50:29 -0800
Message-ID: <20260122005356.1168221-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122005356.1168221-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260122005356.1168221-1-stephen@networkplumber.org>
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

The vdev test depends on the null PMD for testing.
Skip building the test if that is disabled.

Fixes: 50823f30f0c8 ("test: build using per-file dependencies")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/meson.build b/app/test/meson.build
index d03e5f7339..ccddf1af8e 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -209,7 +209,7 @@ source_file_deps = {
     'test_trace.c': [],
     'test_trace_perf.c': [],
     'test_trace_register.c': [],
-    'test_vdev.c': ['kvargs', 'bus_vdev'],
+    'test_vdev.c': ['net_null', 'kvargs', 'bus_vdev'],
     'test_version.c': [],
 }
 
-- 
2.51.0

