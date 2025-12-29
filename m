Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF20EE92FDA
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 20:49:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2562A40662;
	Mon, 29 Dec 2025 21:48:47 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 92DF140662
 for <dev@dpdk.org>; Mon, 29 Dec 2025 21:48:45 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-477632d9326so58279695e9.1
 for <dev@dpdk.org>; Mon, 29 Dec 2025 12:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767041325;
 x=1767646125; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxsF3XY0l0IbGwp44EoJybmMHW80EKZOrZApeykoPeU=;
 b=hOSrN5J5EReF7Q2eVXaaUXago5teJIjYEG/0bCcJSg91q5v2yW/3v4k0ZtXQtaaf0F
 Jn/UPnc0itjgcb2eqC8cOllMVaHnCgl61jx8mQwU4Kgb/mogATAh8eDmf5MkYvWxxx5W
 mL+Z0uqmjy/rSNkbumNeEbxqlD0i+px3a71wld3wEIPf477n+FdD91a6HgAdP1Pb1khf
 /axuf3N7K2vUh2S5EkdIooB4ScnFYl9+f75qQleXDiA5wq/B9xOK+Rc7K0TGtbkVPNTE
 PW5X4Pl4RovDXCuMBd6GtlJxlcNA71e4B3f7j4A8X2HvRkzplcAOlYDdJDb8uuaA6Nwa
 YEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767041325; x=1767646125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FxsF3XY0l0IbGwp44EoJybmMHW80EKZOrZApeykoPeU=;
 b=qJRdudyLb1gNCWyxKNJNIS0yZBV1SFzvfV8GRvoYE+0zv5N42eXEcBfq9+5CEO5Kh6
 kozMSn0gU2T9idTbxzPsa20TqCfsAoIPBPovocahyJiCnVEdPMfsFDtCZ+iPqTTWx72b
 oxMVqyaA98gBS9O2YApNaDGxAbJi2Hsg3DD1BygHrgkqm92NSg5opS3UUrl7MOZ3ZQTT
 h0f4Fy+Gagu2GTpnO48xSkNNWt09LIKRXRXtWB9qaSp3irlfTlo/SjjV087OlaznN7d2
 RzJNcCslT3/lOwFo6HWqWRJFJmI2DO8dSmdr0RTh0WR5NYKB4+6uB6095Hju99RYpx1+
 cn0A==
X-Gm-Message-State: AOJu0YxMJFvOdnGZFr4jo2rYmSWVnpX1aooGO7EfEG+CC9wVjT/gjKcO
 6x2FfXhFMBORqAzW4bHDVs/0C0BQRUWwVHVsuVudEkspJ3mKYLIGOCZEbSGb2e4k4HQdTbC4PgB
 J9OGndso=
X-Gm-Gg: AY/fxX6CoIdKylcblaA+yG3EG9dc6jd33w0qem/jrevCHhdri/oydx5r3OFOZlwCMFf
 OfV485dvGK4bS1w8NGmylUooj+06QWnABjixMlRPEkch2prD/wIIGyaXjfKmpW9g9FtegVGsz0M
 Rq0nMqOFuM0lagVPZW3wbDeLHnfjZY0uIz7gdCre+f/+PME919VgbdobHSgokNM0b/Dbp9Oif6i
 ZC7lqVh+Z1X3dxizDCXHig46iOmCVVirq4qVczI+grG7Hy0qKY3Jo/csbFUwczkL4XKvuZHGePU
 Z34mfr+H4OnCbA9Winb7uqzb0IMi+2p3Y1KvwSppYDs+CfCp7wjs0W8NFXJ17lvbqiWriLuL/lZ
 zOk+4AEbQFBQY5EeJbugdsQQtTeLvVkQFrc6KaXY2zTE9205oIuFI08rWGeJHmNW3F9g/tItail
 zbkXx9d12LWkr+tsKUluS/fgS19czAMYgtFHvdBKw3mry5YYz4aA==
X-Google-Smtp-Source: AGHT+IFR5op7MsS0cdqjJ/mOtCGgSw+u7p9/7Qr7YI39BCYm4jzsb/YtI3U8PCMiWBWHU0o8vhwifw==
X-Received: by 2002:a05:6000:248a:b0:431:8f8:7f31 with SMTP id
 ffacd0b85a97d-4324e7021cdmr37922369f8f.56.1767041325134; 
 Mon, 29 Dec 2025 12:48:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2c4fsm64676298f8f.42.2025.12.29.12.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 12:48:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 10/18] eal: add check for sysfs path overflow
Date: Mon, 29 Dec 2025 11:38:08 -0800
Message-ID: <20251229204818.61231-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229204818.61231-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251229204818.61231-1-stephen@networkplumber.org>
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

Shouldn't happen but in theory sysfs socket could overflow.
Add a check for it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/linux/eal_hugepage_info.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index 7161b1a2fb..fe3351259e 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -150,8 +150,12 @@ get_num_hugepages_on_node(const char *subdir, unsigned int socket, size_t sz)
 		return 0;
 	}
 
-	snprintf(path, sizeof(path), "%s/%s/%s",
+	if (snprintf(path, sizeof(path), "%s/%s/%s", socketpath, subdir, nr_hp_file) >= PATH_MAX) {
+		EAL_LOG(NOTICE, "Socket path %s/%s/%s is truncated",
 			socketpath, subdir, nr_hp_file);
+		return 0;
+	}
+
 	if (eal_parse_sysfs_value(path, &num_pages) < 0)
 		return 0;
 
-- 
2.51.0

