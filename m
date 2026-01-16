Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11ECEC982D0
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 15:35:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CD3A42DBD;
	Fri, 16 Jan 2026 16:35:32 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 5AC6D4026A
 for <dev@dpdk.org>; Fri, 16 Jan 2026 16:35:30 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-47ee4539adfso19067755e9.3
 for <dev@dpdk.org>; Fri, 16 Jan 2026 07:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=i2i-systems-com.20230601.gappssmtp.com; s=20230601; t=1768577729;
 x=1769182529; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lR3HziBJ4I2RXWuv1NVvwavRgY2khbndo9OgCQviGkE=;
 b=cr//Bfc/GuPo7JkTd8yn2cnA3rCPpaieS1clukSU7UmADGsLlcMGvOxLCdNZ26g5td
 E/hYt5ro41LxD9lyTul/vTRzv2rFL6hhoPjjzyWvaRZvDbx6aW6AAVVgmXGgBvdDuij7
 pyLH6VwdiQAo/bOOl6LNsKKvpNZgHhmavYsDtwudtbmHr8EtLUnJVdBGYRcqfekzuPeW
 W2X1aIow13k86DiLwsxSeTK/9TaNQ0Uirparx5Y0bYYels3VB4BqwRrQc8CBVI7ou00Y
 LqJboQ1HL8RTk1bzaIoSHipxy6j69FKG33zQy1p+aAjxSbhk2dG2/WoKMNadhn42OHbs
 BeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768577729; x=1769182529;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lR3HziBJ4I2RXWuv1NVvwavRgY2khbndo9OgCQviGkE=;
 b=rvIoW+CX7THJTv7wnwp0z7ZC2cgzGzKGp6Z+0nujIAL1Yj7Z+RPmPhxg/OZ4XCERIu
 Y2/QeKVA3ggOkrUYiQjiV9+vyl+LexmHvXSZP5NP6YprBgakaSA9ZzjZkbBVUUgRBSuK
 l1gUWXVp81nGmg7nrcN456+azpQnfbVLCNtJHUuuYiwe8vOTSSpkG0596Bxf74Dpzk21
 R6NfgbGd5jJHB2C87Oxo+Qns1g5KD5HXFAPFu2yxPbEjMcBtjZ4xecHjBvOccG6I/NkO
 E21g87Y7p0N3WCMgp5RuekXznCUwfCeBTyVnKYm/hAzRmRzm8DU3scZPZJ/Jkd0gm8hk
 p/fg==
X-Gm-Message-State: AOJu0YzneGoNgeXeyVJCK57yyAS8JMkwsDtzs9440rh1ZwyaXi1Gszyi
 HKELmGbUdWVJazJPnGf2E1ktVvnI9/8ma0hzdMlW6f1y5yXJqBWeqU59HvnzHKnT5uqkRvlyJ6q
 DzaIOTdzxTP3j9nONDS//Z3WfySxbmGG+5SIFEPmt1c7QicCQ9x4=
X-Gm-Gg: AY/fxX6doyOZ63EXJNSUvrfhwQgZxdMXoojRKUGstJNga9VMF/wM7pDEPGMeIyHHHvI
 Jsw2nrJXBZfkXCFALcQ3hL5fd/zHZDJMmC/0wVULycNJKeKbtjrQokYyV6XpNocvI73O46gOlRz
 DqJvwZZ4sYbapBtOwpTq0NWy8le6lXiBom7jbn0Qa0O9mCBGH9vIaF/K3dqJLQyBAGP4WBkeYgb
 t/qp4MZ24WlJAadfFLfGuooGthw2AXi2fqh5sLK5lcFgzETD/ZxWpxQTA3aUQDOGyQ+hWcPe1vm
 hl8taRDXecXAmXR857xkRStd51QbkvlTDlLUWNIVikRsyoj187rPLoqIvkJdw8hHU+pqBSntbRb
 kvfz+KP7qQxtgEKpHIlEZtwvMaZywMNMVYghfMubgpuUyf0LGodrISMdnlr/hceEevrrzO7RQjx
 7HO/dhxSA28BWY9lUmoOSia1UWBpVJdm9f
X-Received: by 2002:a05:600c:3495:b0:477:7975:30ea with SMTP id
 5b1f17b1804b1-4801e343a9fmr41662545e9.29.1768577729464; 
 Fri, 16 Jan 2026 07:35:29 -0800 (PST)
Received: from localhost.localdomain ([176.240.216.43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428acd0csm103538165e9.6.2026.01.16.07.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 07:35:29 -0800 (PST)
From: Kerem Aksu <kerem.aksu@i2i-systems.com>
To: dev@dpdk.org
Cc: Kerem Aksu <kerem.aksu@i2i-systems.com>
Subject: [PATCH v2] cmdline: update clear screen behavior
Date: Fri, 16 Jan 2026 18:35:13 +0300
Message-Id: <20260116153513.206247-1-kerem.aksu@i2i-systems.com>
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
 doc/guides/rel_notes/release_26_03.rst |  1 +
 lib/cmdline/cmdline_rdline.c           | 29 ++++++++++++++++++++------
 lib/cmdline/cmdline_vt100.h            |  1 +
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/=
release_26_03.rst
index 15dabee7a1..7a3df7fc84 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -84,6 +84,7 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
=20
+* cmdline: Updated ``rdline`` library to clear screen when fed with Contro=
l+L.
=20
 ABI Changes
 -----------
diff --git a/lib/cmdline/cmdline_rdline.c b/lib/cmdline/cmdline_rdline.c
index 3b8d435e98..ddca4d0a73 100644
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
+		rdline_puts(rdl, vt100_clear_screen);
+		rdline_puts(rdl, vt100_homecursor);
+	} else {
+		rdline_puts(rdl, vt100_home);
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
