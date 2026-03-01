Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB5DFD0049
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Mar 2026 02:09:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 981A540ED9;
	Sun,  1 Mar 2026 03:08:00 +0100 (CET)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id CF27340E4C
 for <dev@dpdk.org>; Sun,  1 Mar 2026 03:07:55 +0100 (CET)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8cb3dfb3461so334395085a.3
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772330875;
 x=1772935675; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7IkUl/0NLxrFpIz53KeZT2r+t1cZtUzoYXS3/PCXg6I=;
 b=1hKsONlg7+mvhOvV+dd14tyrsCRaRp8Ogi5Ph/tUFJnNZZP6A+M+94p8FLY2sZw5F9
 iW661iZMij6tTeF/MDJIY3Lh+XI5rdQoRRJVYB8yVbtuQSyKBFtY2CCp0k5PJQVxxMkZ
 BH7g62oNeR60R+62fqbVvJt2QP1+1Pw+VgDNYYbsDw0FWW7DKr9mIM3VbruiIPZMweIf
 t8r8hIoCNgRmvgmBwGTAJvrX5vD6j5//iCT5BcI5X3USb0Y4cfBhChD/8SKwR/6PTGqB
 YuGg7F1siqP7KVcirNinXBs4beT6+wBwBi8T1cFXqE0LIQ3NacWDzWS2IbW+b+PjaPqN
 JnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772330875; x=1772935675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7IkUl/0NLxrFpIz53KeZT2r+t1cZtUzoYXS3/PCXg6I=;
 b=XiLfsdzYFZ+5KVSFDBN8B3wbIoTjpjK6rP7fl+yDoNA2n2qTl389d2hbKHtI8AejFT
 M78TFetwdUNpHA6NuntnW2mbYGagUUo7TUwB3nS89mD7xPEOyUCCAKCL2peChVFVUnkb
 Kb6vUCll4+Gqj03sT9EtcjhaRKTgJK+jTd2JVj3YeDS77xoA4awomcG/tINWEf0HoicR
 7/SwrGVPjMYpGNYIpwATGEtbCIx/Ml0i9embpmgCepwjrwmbUBf/TIaQd4pgStbk/APk
 ZWpDoq95XNrdZ0WYgg7IpDXgaaY57lNIoXPVMvrW83rWVqJa59JmjFThsadDRzE34qG3
 WfAw==
X-Gm-Message-State: AOJu0YzwUmOmv+xCb2fYPfYRFy3lYtndtjoDz3ONRO6ifS10eSKC5zuW
 5KHzC+SVHAd/cp6pUMFtOExj/3TdojpEZzBuv4Bhmx7lqM/tYK0EGDebLAsvQXSbYDCesmq4Get
 tCzoR
X-Gm-Gg: ATEYQzw+luyJfkxZQeALJGt27fSdeMnisTwzIlday2kbYeasTzBFU4DQ8v98+D4HHUO
 4f5lArbmrxYlymv7m+W7ycl4jTdUIHiv3FUrI9CrQ8UpKDiEY/5uzB0dfnLeb1AlfHL8L6UcuHp
 O2yoQ9oAX7uQAN9qopzmNY9zwTpG9Hd6DdqPz/YZNUBVbon069vkP4JzFBE6vj78bEQCHzfVeXC
 +5TPEkOlIAaEp7ZwX3/OpOU/jGY/N6lQfFV1OgFc3v/pgqPs8cZrw8p/Y+a7GucsXITWjKmDMUB
 yM0E3KY7AN5zrTLLPupos+yaJLmcBsNOQpVY26xzWd3WVM3Z+Q/Lx2QHOC0+XVlXfDKDpWwNmGu
 XV0fqptcS5TAFWLVhQA21DOKDtJwC6Mlj1K2vNX5dF/snqXfA46mVdLdvIf84nXcm0r2bVg1IoT
 TlW3axKgePnqL3ud+uud4NXnt1T0qXgZwqjp21UObiUcKwkIiC8z8ixP3v++ZmvjMMYKRvAHn0
X-Received: by 2002:a05:620a:1992:b0:8cb:49e8:d465 with SMTP id
 af79cd13be357-8cbc8d71067mr1087674885a.1.1772330875201; 
 Sat, 28 Feb 2026 18:07:55 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf736bffsm802292985a.50.2026.02.28.18.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 18:07:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v18 19/23] eal/windows: add wrapper for access function
Date: Sat, 28 Feb 2026 18:05:52 -0800
Message-ID: <20260301020726.852401-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260301020726.852401-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260301020726.852401-1-stephen@networkplumber.org>
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

Like other Posix functions in unistd.h add wrapper
using the Windows equivalent.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/windows/include/rte_os_shim.h | 1 +
 lib/eal/windows/include/unistd.h      | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/lib/eal/windows/include/rte_os_shim.h b/lib/eal/windows/include/rte_os_shim.h
index f16b2230c8..44664a5062 100644
--- a/lib/eal/windows/include/rte_os_shim.h
+++ b/lib/eal/windows/include/rte_os_shim.h
@@ -33,6 +33,7 @@
 #define unlink(path) _unlink(path)
 #define fileno(f) _fileno(f)
 #define isatty(fd) _isatty(fd)
+#define access(path, mode) _access(path, mode)
 
 #define IPVERSION	4
 
diff --git a/lib/eal/windows/include/unistd.h b/lib/eal/windows/include/unistd.h
index 78150c6480..f95888f4e1 100644
--- a/lib/eal/windows/include/unistd.h
+++ b/lib/eal/windows/include/unistd.h
@@ -23,4 +23,11 @@
 #define STDERR_FILENO _fileno(stderr)
 #endif
 
+/* Mode values for the _access() function.  */
+#ifndef F_OK
+#define	F_OK		0	/* test for existence of file */
+#define	W_OK		0x02	/* test for write permission */
+#define	R_OK		0x04	/* test for read permission */
+#endif
+
 #endif /* _UNISTD_H_ */
-- 
2.51.0

