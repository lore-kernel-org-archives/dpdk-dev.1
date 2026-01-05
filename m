Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AB2C2A09D
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 11:36:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4D974026F;
	Mon,  5 Jan 2026 12:36:16 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 139CC40267
 for <dev@dpdk.org>; Mon,  5 Jan 2026 12:36:15 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so141124815e9.1
 for <dev@dpdk.org>; Mon, 05 Jan 2026 03:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=i2i-systems-com.20230601.gappssmtp.com; s=20230601; t=1767612974;
 x=1768217774; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Cpg9igtbzc//s6Gti4lmpPWEZvxmRj6NRehAX75MGtc=;
 b=bZ6ullKgDvJrhNYeqB4rtu54YWzIOqQOKKFix2GJLr+SrzebuXtTd5djlkOr6kq2dn
 1A5B+m9+Yl0j4ljzxCDUjvHknPPcUgwHjUI7WbwyHGgwI54atRXIaaJPG/lO97ElJ7y/
 ERnJURaDItpFvz5ZLU6ReuNkHMY0zsrJvPCynxmLE3WC4w71OIcQpMykj/R3mb7OgUcQ
 mDSpMSBPTW3dy7JNT8I2jNydpMlJ7ejIYYB8P/eL8EXY/A0Q4sV+xU1qhapzb8KqrFid
 L/8YEFfX0Y0h0F5zizr5W//QCxoHvBqDUXzGF2cOT41BdGD24xxXhAiTARA+cXbNo+cI
 Nu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767612974; x=1768217774;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cpg9igtbzc//s6Gti4lmpPWEZvxmRj6NRehAX75MGtc=;
 b=NSqeI+PjL0p3UecXQKrII53JotJpCBvfQTjK3fBtduUr/EJ6ud8B6e9lIT/KSdF7iL
 P73w5tA68v5fRbLDnSkiNwgDdKzjCiVVyB9QY1WSwyfrEbJvQwj09H8Od2UfRQMoVwTB
 CNN5/vzVH7XkREYyGq8toySKqavafDhGr9mRMPVHS4dlNpmzQTB+VVsOl6S3+4qMkX2u
 F3QW2uaXdDYSinBz0fqE3wK3+5kP0Siko1Ynw/3GkL7tNVwnugDeooHvoINr/hEw5i8H
 YckBhdyUmNI/zJKQAtA7s2W5ELxXBTaViRgTuw3Ue92u0zT3eLEQNwOVhEnURFD/LgWD
 1hyw==
X-Gm-Message-State: AOJu0YyFT1VRYfqSlFrEGkGxvU4SFMXhlnz+x+SNdEEb2KKHEpvya4RA
 uDPPupLE+g36FFMNwXlMQXn3sk5PZDqb0mcEzD+UoNzjFNCyF96IWJ6WBvzjqG/CegsFkdVryoH
 jN69Wpd7v1T6EVLT3nQsXDqUdP9/RZUJlFVEnvFdr5G3Pr0Qf
X-Gm-Gg: AY/fxX5hBp02n+k2ipV5b4/rjN1h5fJMtEsCsBG3p/ZXhbZ+EKe+FSodSJ0B4IGDhAo
 zhAkpSr6HX/LwHW+VFbGFi9mLc6i0mTaZSJj+cddTt3IIrZa1KbkVeKBjIYlXkKLNmB9+Pj0XEk
 ca4Fn6OxxqodfpGEcBACdqBe7tYwAgPAZBpIt1DCR/V1NFb4sJEAXoWFFBTuvCiT8uYDngqBqwO
 l2Kt8suxLzLrnVAD7FNHeekKEHN64L/m34yGQsqAmHUVkqOH91QemWvGXcgwTyM9Rg3NT7Y8iqn
 jJkSva6QqnT8n0Vx93UHHlAPi2SrR2Ic1r4L77FLb28s4eCUR9tnVrc9lZGpS/TkuMGte2Y9Omc
 MiD8U03iuNew5dK7ZB+gS0Zr7zPZmXxQbKf+lQCj/qZSOb5QboB1ndubEuStHdwSc4+Zbs3O/mH
 mtnAWfOrhsvSk2YGhNzzCIC1BFJfXLkqKq
X-Google-Smtp-Source: AGHT+IGgKcD4F0tCxH1zObva7CoVWwapZUzdgk55MJ5k4XHfBs14wLcg2QleSq1JfxpHTq6BxLSMeA==
X-Received: by 2002:a05:600c:4f4a:b0:477:58:7cf4 with SMTP id
 5b1f17b1804b1-47d1953b79dmr695163895e9.4.1767612974149; 
 Mon, 05 Jan 2026 03:36:14 -0800 (PST)
Received: from localhost.localdomain ([176.240.217.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6d145162sm153638805e9.4.2026.01.05.03.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 03:36:13 -0800 (PST)
From: Kerem Aksu <kerem.aksu@i2i-systems.com>
To: dev@dpdk.org
Cc: Kerem Aksu <kerem.aksu@i2i-systems.com>
Subject: [PATCH] cmdline: update clear screen behavior
Date: Mon,  5 Jan 2026 14:35:29 +0300
Message-Id: <20260105113529.65969-1-kerem.aksu@i2i-systems.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-9"
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

Control+L should clear screen and redisplay prompt at the top
line. DPDK rdline library will not change anything on the screen when
fed with Control+L.  When prompt is lost after too many text written
to the terminal, users will press Control+L to clear screen and put
the prompt to the top line. This is expected behavior in bash(1) or
applications that are using readline(3). Updated to behave as users
expected.

Signed-off-by: Kerem Aksu <kerem.aksu@i2i-systems.com>
---
 lib/cmdline/cmdline_rdline.c | 29 +++++++++++++++++++++++------
 lib/cmdline/cmdline_vt100.h  |  1 +
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/lib/cmdline/cmdline_rdline.c b/lib/cmdline/cmdline_rdline.c
index 3b8d435e98..95f519f123 100644
--- a/lib/cmdline/cmdline_rdline.c
+++ b/lib/cmdline/cmdline_rdline.c
@@ -182,9 +182,8 @@ display_right_buffer(struct rdline *rdl, int force)
 				  CIRBUF_GET_LEN(&rdl->right));
 }
=20
-RTE_EXPORT_SYMBOL(rdline_redisplay)
-void
-rdline_redisplay(struct rdline *rdl)
+static void
+rdline_reprint(struct rdline *rdl, int clear_screen)
 {
 	unsigned int i;
 	char tmp;
@@ -192,7 +191,12 @@ rdline_redisplay(struct rdline *rdl)
 	if (!rdl)
 		return;
=20
-	rdline_puts(rdl, vt100_home);
+	if (clear_screen) {
+		rdline_puts(rdl,  vt100_clear_screen);
+		rdline_puts(rdl,  vt100_homecursor);
+	} else {
+		rdline_puts(rdl,  vt100_home);
+	}
 	for (i=3D0 ; i<rdl->prompt_size ; i++)
 		rdl->write_char(rdl, rdl->prompt[i]);
 	CIRBUF_FOREACH(&rdl->left, i, tmp) {
@@ -201,6 +205,19 @@ rdline_redisplay(struct rdline *rdl)
 	display_right_buffer(rdl, 1);
 }
=20
+RTE_EXPORT_SYMBOL(rdline_redisplay)
+void
+rdline_redisplay(struct rdline *rdl)
+{
+	rdline_reprint(rdl, 0);
+}
+
+static void
+rdline_clear_screen(struct rdline *rdl)
+{
+	rdline_reprint(rdl, 1);
+}
+
 RTE_EXPORT_SYMBOL(rdline_char_in)
 int
 rdline_char_in(struct rdline *rdl, char c)
@@ -382,9 +399,9 @@ rdline_char_in(struct rdline *rdl, char c)
 			rdline_newline(rdl, rdl->prompt);
 			break;
=20
-		/* redisplay (helps when prompt is lost in other output) */
+		/* clear screen (helps when prompt is lost in other output) */
 		case CMDLINE_KEY_CTRL_L:
-			rdline_redisplay(rdl);
+			rdline_clear_screen(rdl);
 			break;
=20
 		/* autocomplete */
diff --git a/lib/cmdline/cmdline_vt100.h b/lib/cmdline/cmdline_vt100.h
index be9ae8e1c9..5f11ebdb74 100644
--- a/lib/cmdline/cmdline_vt100.h
+++ b/lib/cmdline/cmdline_vt100.h
@@ -38,6 +38,7 @@ extern "C" {
 #endif
 #define vt100_word_left    "\033\142"
 #define vt100_word_right   "\033\146"
+#define vt100_homecursor   "\033[H"
=20
 /* Result of parsing : it must be synchronized with
  * cmdline_vt100_commands[] in vt100.c */
--=20
2.34.1


--=20
Yasal Uyar=FD:=A0*Bu elektronik posta bu linki kullanarak ula=FEabilece=F0i=
niz=20
ko=FEullara tabidir:**=A0**https://i2i-systems.com/email-disclaimer/=20
<http://i2i-systems.com/about-us/email-disclaimer/>*
