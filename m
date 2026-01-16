Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B5FC982D3
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 15:43:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C35042E45;
	Fri, 16 Jan 2026 16:43:29 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 6BC464026A
 for <dev@dpdk.org>; Fri, 16 Jan 2026 16:43:27 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-432d256c2e6so1753135f8f.3
 for <dev@dpdk.org>; Fri, 16 Jan 2026 07:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=i2i-systems-com.20230601.gappssmtp.com; s=20230601; t=1768578206;
 x=1769183006; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lR3HziBJ4I2RXWuv1NVvwavRgY2khbndo9OgCQviGkE=;
 b=JanBNxVAvwYrEVb0fNIcQDzZ5lBPzxwAig+oZmrYK6yUXauT5g+qXTC+7mCYPi95H4
 x7Lcbu2atGFL0Tqw28u4JSAmp7aS0x+186K78rCIpT5XTezUVlKgqtpCR9Bv8v4b7DdQ
 TS3DLNlaZzZUNM8q7jMOb2mYeSDK433//mAK7Gf5r65+I5Ur/lftXlZI/Dq5dHlrs9qI
 qdHTiorAKEIrHmnxfdv8fom+gWmhSHo1V1fWG5fm9J47d+3SCmjUC9eVAw+clPsKEzbS
 Sq1giwGewOzbgi4i19jTUju1WGw6J2ibajslGL9v28VoH3Bt0uX+z+LQqDjML9ZGC7MY
 Bf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768578206; x=1769183006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lR3HziBJ4I2RXWuv1NVvwavRgY2khbndo9OgCQviGkE=;
 b=M1NJComGQcqWsHr/oBwfFFUyYk7ulV3a/pPcspopKU+u1nyPjnR6rqIP9fp1emjXPx
 cQEMjQ+ns2nL1i8bLOykXsz6cXhbdQbYGqCBBNJRftJ5RVWKIjCXBBVYwLGhfYE+d01c
 ZeC0j6MwuP7e0gjuJGMWLgFhfMjG82A56fwtCPKTMHfMMsyonKRscQDAaECckMc7iW3f
 ywRYlGtfos9J08sG9TtzL9LTTiKACZqWecVqla/7jynbeC4daVWI/Ggmpn/GVoGK+dWT
 oXSvflTErUfrk6XKjr3fxLx7WiecWndNVQ2TEUQIA8m4cdFQoqqh0GdD4UhL9VOjsTl8
 e2og==
X-Gm-Message-State: AOJu0Yzt8sbRoLA95VjeNr9BYygiZWj90xn3HaiyTwYbO/uoyUpHKkzU
 RY8Bxdla2EUyxPy7YVXcCDl/mOOuqwS0gXCwTZAZF2/1CZeq/TOgGL50IfArnR8vWLZzmZYdmrb
 P4fgRyR3j90N0B/VYnAmH4EOD0UHH53eNGQbDIcrH+IaiFc0xd9I=
X-Gm-Gg: AY/fxX5Meizxmpx/6KtDBCQABGr++GjvI2dr8/vdSI25rioV7P84aVaBDojbklRP3kr
 fekrGIUMtSzmemTIT8zFxJhLjjSU8CUp2BZyDSpH7jkBIoJw8xaMGN6wa2Jedn3g4T3NeVbBAoe
 3RZGdUu/+2PuLvlN3MWi6jp+FrQG/s1P2tpvlkwRTyG6Bnvwp35tO0JxROPRNhXkBVbWpKDgG8S
 i594WXoDu8qY0p04UvNazm9NrW+YFqHYKB4UqB+cJ1jXWJ5XFoHbyNhuOW3Up0FNkTickoEEP8G
 z9vtj8lu4DwyhQRyenMce/byfj/FbBOmI2+Z8RcbfXvvIfA2KylOzd1Iw26lkgFB5QRbXXDFTXK
 U6cVLBPhhJDuksiZUzO782Zp0W7BjZPEDvYZYLirKn5wvzfSl549oe6cdNADrSHc/2dEMlGghUG
 BNAGF+tPcvU3qlSf0fwKJ9cO89zrAh+3p8
X-Received: by 2002:a05:6000:1ace:b0:42f:bad7:af76 with SMTP id
 ffacd0b85a97d-43569980a75mr4340974f8f.15.1768578206214; 
 Fri, 16 Jan 2026 07:43:26 -0800 (PST)
Received: from localhost.localdomain ([176.240.216.43])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e664sm5297842f8f.30.2026.01.16.07.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 07:43:25 -0800 (PST)
From: Kerem Aksu <kerem.aksu@i2i-systems.com>
To: dev@dpdk.org
Cc: Kerem Aksu <kerem.aksu@i2i-systems.com>
Subject: [PATCH v3] cmdline: update clear screen behavior
Date: Fri, 16 Jan 2026 18:42:56 +0300
Message-Id: <20260116154256.206571-1-kerem.aksu@i2i-systems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260105113529.65969-1-kerem.aksu@i2i-systems.com>
References: <20260105113529.65969-1-kerem.aksu@i2i-systems.com>
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
