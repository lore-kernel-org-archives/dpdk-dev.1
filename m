Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8159ECCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 01:22:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A53F402E6;
	Thu,  6 Nov 2025 02:22:06 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id C06E64013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 02:22:05 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-29555415c5fso5946785ad.1
 for <dev@dpdk.org>; Wed, 05 Nov 2025 17:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762392125;
 x=1762996925; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+ss8eNT4ryJruYJPJW3+u4PViQNtsRqj363QNtk8Gk=;
 b=Ja1FoZRaUY/VfAOsWsP0n/DwX22zZRiLw+CV2smovnG60gK03Oao8T1MUhybcvPNdd
 6KtXQoqQZBKp4CuM5wn9On4IuInqyFo1zU6DUsGgTx1XKiFMkrHsdzJMaDH7zu9kWVej
 JDlou/jYjbSz5FuWYz6UNcPrYf+mJ2On0IaguyRwVxJG5xdpbVXfKOLfULLYQ0tUV1S2
 Sd7AqL+v2qhl6tlG73ymRETpkfGXMI40LXVRCJ7r9Zo9Txv6KlKlWMCbk21CBsj/M96X
 +NXK+hokVtTya7fpCuQ66Jo2W8Oi0GooKZa/6l61pu/OBU1LObydYJVVGMPpbvY4U8bk
 f1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762392125; x=1762996925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p+ss8eNT4ryJruYJPJW3+u4PViQNtsRqj363QNtk8Gk=;
 b=i+yGFDEFIwhVN+Rad9Hd9K7cZ2Myqrzvom8PoB/AF9xyp/F+bKxI0wYRF9FlkznTep
 3ghfJG/F2DRvR3CAZ7gd/SqhD8UKrg4f1ZLAkX5tQZ7gdS4bfcAe+k8QzvdO6BL7rPNK
 lI89MBgOufwvjBJRhPdyX5mOSbXc8K7Xwbf40W3K4gkgQArzZY37u6wx3GkDMUQNL52Q
 qYIxNpsZQ22OxONiMfMVXoA5U/JHrxtx/awO1NVgm7RVF4Z0mJwNbyQ/nSi/vK7PiF0L
 KY2WILzqpS017XH6y2lLPr0VQ7RWH7Wkfc8r1ShMSEFN0iubk1UYHMS9m1N6ttrE2G4I
 AQNw==
X-Gm-Message-State: AOJu0Yy8vT2FB36y3YP50TTANt0/LkCckUe0XLfkJGeUMWFjLqIxKPlP
 Bil8GBAuSsVtMaXkPa53DSM69J/28GqO4FdDchAeHSR7T8VfcxhyruVydoBO5fgVD9oqS2jKwo3
 vDTYM
X-Gm-Gg: ASbGnctVzggQD0Gm0jl5ylUAikCj9mrks9/6sTeRhdH9qtVJFZ1aaHWjmbKHFsyOFug
 ItDbe5q4QXpWaIyirDxgxGZvGnVjPwyqV1P9F60hIh0viRAndinwTtGzVVZrXEbBAmgydlWX40q
 PQP/Z9QNbuXAGzbfx7TMqPDTaczs2PwoXqQzucoxsHL9PQK9Uutm/CWtWA3o8VoSfw9/yZ84kl/
 +wmgkXbIlqlwDHSbO8G1wzSSdSWmEg301WJ2Kd5QcAJRRSKzdMbEFKZVLDnFLECXp7Opn9jzkmK
 Ig6YuT/H9e45i1JsUjIw6tdWOBSASTujvognhSJiZ0XoYg3+Cn1cQnXvb8EdfcC7Bwq41+tSqKv
 1gRGtvkL22V1CnKVoJ93P2KDGyXwBG9avgWTbh7Wuf2gl/QEglmtm3yFBRWzVmPZa5Q0IXe4xIb
 O0ZJz+y0AYdl10QLxKKRHB6itP3zBnzb12keFuwmw=
X-Google-Smtp-Source: AGHT+IHKKHE+5KDnq7PB+ik4x2u2vtgSmaH0DbbzuLYg3CLjCw7ltr9Vfo/XNU1cWWm144m7XoVxkQ==
X-Received: by 2002:a17:902:ce90:b0:296:4e0c:8031 with SMTP id
 d9443c01a7336-2964e0c8139mr25409245ad.17.1762392124771; 
 Wed, 05 Nov 2025 17:22:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651ca4257sm8145385ad.95.2025.11.05.17.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 17:22:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v2] check-spdk: check that tag is on first line
Date: Wed,  5 Nov 2025 17:22:00 -0800
Message-ID: <20251106012200.921242-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105222827.904627-1-stephen@networkplumber.org>
References: <20251105222827.904627-1-stephen@networkplumber.org>
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

For C files the tag needs to be on the first line.

Change how -q flag works; if no errors then command is completely
silent.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/check-spdx-tag.sh | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/devtools/check-spdx-tag.sh b/devtools/check-spdx-tag.sh
index 984825026e..65f00f6e5e 100755
--- a/devtools/check-spdx-tag.sh
+++ b/devtools/check-spdx-tag.sh
@@ -6,6 +6,7 @@
 
 missing_spdx=0
 wrong_license=0
+errors=0
 warnings=0
 quiet=false
 verbose=false
@@ -29,15 +30,16 @@ check_spdx() {
     git grep -L SPDX-License-Identifier -- $no_license_list > $tmpfile
 
     missing_spdx=$(wc -l < $tmpfile)
+    errors=$((errors + missing_spdx))
     $quiet || cat $tmpfile
 }
 
 build_exceptions_list() {
     grep '.*|.*|.*|.*' license/exceptions.txt | grep -v 'TB Approval Date' |
     while IFS='|' read license tb_date gb_date pattern ; do
-        license=$(echo $license) # trim spaces
-        git grep -l "SPDX-License-Identifier:[[:space:]]*$license" $pattern |
-        sed -e 's/^/:^/'
+	license=$(echo $license) # trim spaces
+	git grep -l "SPDX-License-Identifier:[[:space:]]*$license" $pattern |
+	sed -e 's/^/:^/'
     done
 }
 
@@ -51,6 +53,7 @@ check_licenses() {
     xargs grep -L -E 'SPDX-License-Identifier:[[:space:]]*(\(?|.* OR )BSD-3-Clause' > $tmpfile
 
     wrong_license=$(wc -l < $tmpfile)
+    errors=$((errors + wrong_license))
     $quiet || cat $tmpfile
 }
 
@@ -63,7 +66,19 @@ check_boilerplate() {
     git grep -l Redistribution -- \
 	':^license/' ':^/devtools/check-spdx-tag.sh' > $tmpfile
 
-    warnings=$(wc -l <$tmpfile)
+    warnings=$(wc -l < $tmpfile)
+    $quiet || cat $tmpfile
+}
+
+check_firstline() {
+    if $verbose ; then
+	echo "Files with license text not on first line"
+	echo "-----------------------------------------"
+    fi
+    git grep -n SPDX-License-Identifier -- '*.[ch]' | awk -F: '$2 != 1 { print $1}' >$tmpfile
+
+    first_line=$(wc -l < $tmpfile)
+    warnings=$((warnings + first_line))
     $quiet || cat $tmpfile
 }
 
@@ -89,5 +104,10 @@ $verbose && echo
 check_boilerplate
 $verbose && echo
 
+check_firstline
+$verbose && echo
+
+$quiet && [ $errors = 0 ] && exit
+
 echo "total: $missing_spdx missing SPDX, $wrong_license license errors, $warnings warnings"
-exit $((missing_spdx + wrong_license))
+exit $errors
-- 
2.51.0

