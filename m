Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9C7C3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 20:19:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3C0340671;
	Fri, 16 May 2025 22:19:07 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id CB4414065E
 for <dev@dpdk.org>; Fri, 16 May 2025 22:19:06 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-7cd34b6ba10so31665285a.1
 for <dev@dpdk.org>; Fri, 16 May 2025 13:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747426746; x=1748031546; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8vCtM3g8OTKKUWDWTMjx1/cRvL4oaeFSTk87hxB0exA=;
 b=ZoO780MALGwDRF6ZD8P4ESRc7cGoQhrBelGCL5oqXD8InvgtokVg6DkjABaEgHx03+
 X7HegYCMFEV0Lw/UYiVnoqfAWed4BOJGW/pXPQTy0+ZblkeESUdxQrnGj2iSD5B2VzNU
 jVkLexI1eN5F/lnTWtJqucN0fLiQ10mEJwORg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747426746; x=1748031546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8vCtM3g8OTKKUWDWTMjx1/cRvL4oaeFSTk87hxB0exA=;
 b=rn4j22AX5/YEHeiGHVgt9t1p0Glg16t1p62REyOHVbw3qrlmU7a+93Ejue+zPYZISl
 2SNSUBNhX3MJca5Bk74Mz0U8aDqV1xa/2YuUMtHBFodLY5vkwa96LuX0WnKucRPTWvgG
 bWCw/8qH4x1xz32VhmwK5dghZtAzL7Fg7G+DA896ayTjN5+j0n1WONI5peVjxPSeP0wC
 7ovhJ5UthBroT+PjZSEreJMTNRWUybtd+raXk2518ybEOh1dg3Ge6SOEJSZfJClVlk73
 9n//PJpdfPMQEbylnf/Aq+DuDaOf8cS13LuTCXzlcE8bc6mq36kSeLBap+uAR2hzgcm/
 86Dg==
X-Gm-Message-State: AOJu0YykbIbCjMvC+r+RgH14Fcm9ZZ8pCjDeLz2HoK/ZPvx6fCilVRqs
 HlAOldv2u85VxW5vTOz7BlGYDI8FmMWs8o5d5DHxNZ1RAcpmlgDhZ5Jnvt3AJIyN5QI=
X-Gm-Gg: ASbGncvJo6mLCwG+Zxg4O8K1zHHH67moc0UeYibZAU7nL7n7Yp9gftBZPPOstFTECwN
 4zENB/bNcgaY0kvmsWO38wUJ1jE5HmTD/8R2hZVp8ns5dpC245gULiQ5DwPDiJaIx42LTszh+Ce
 e29OY7Bd+XKi2VeKXQvkvnLAA8CUMJVQ95fzrwP8S+uPbxS9qHi4voWIKttOuDlINXa+Ub5s0cM
 NN4S5uBh+1TNH6sE/1XKw/kY2tzagXVgzskN1toyLbEgxJVzhn7GZ36ZYgBU5lSQHVIB8fDFFHd
 xpFldLXTXMr2GiWByi+1jkDVWhspwXSrncdMzigR7eG0k7WMbnyMKaFYid+HrGo=
X-Google-Smtp-Source: AGHT+IEc6Aadwr3y64JKWtcAhmmhKAz9LCw2rIjRGbV5OFoKGWzzA54GB39Ht1IOUqzlF4DVm3bq3g==
X-Received: by 2002:a05:620a:6602:b0:7c5:8f36:fbeb with SMTP id
 af79cd13be357-7cd467c4007mr283074385a.12.1747426746151; 
 Fri, 16 May 2025 13:19:06 -0700 (PDT)
Received: from localhost.unh.edu ([2606:4100:3880:1271:e2f8:4ec3:8bf3:864c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467d93d5sm159673685a.31.2025.05.16.13.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 13:19:05 -0700 (PDT)
From: Nicholas Pratte <npratte@iol.unh.edu>
To: stephen@networkplumber.org, dmarx@iol.unh.edu, luca.vizzarro@arm.com,
 paul.szczepanek@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, thomas@monjalon.net, thomas.wilks@arm.com,
 probb@iol.unh.edu
Cc: dev@dpdk.org,
	Nicholas Pratte <npratte@iol.unh.edu>
Subject: [RFC v2 4/6] dts: add extended timeout option to interactive shells.
Date: Fri, 16 May 2025 16:18:32 -0400
Message-ID: <20250516201834.626206-5-npratte@iol.unh.edu>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250516201834.626206-1-npratte@iol.unh.edu>
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250516201834.626206-1-npratte@iol.unh.edu>
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

stdin commands may require an explicit duration of time to
facilitate a total execution. Add an extra parameter to interactive
shells to handle these circumstances.

Bugzilla ID: 1697
Signed-off-by: Nicholas Pratte <npratte@iol.unh.edu>
---
 dts/framework/remote_session/interactive_shell.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/dts/framework/remote_session/interactive_shell.py b/dts/framework/remote_session/interactive_shell.py
index ba8489eafa..5331b8c7d1 100644
--- a/dts/framework/remote_session/interactive_shell.py
+++ b/dts/framework/remote_session/interactive_shell.py
@@ -177,7 +177,11 @@ def start_application(self, prompt: str | None = None) -> None:
         get_ctx().shell_pool.register_shell(self)
 
     def send_command(
-        self, command: str, prompt: str | None = None, skip_first_line: bool = False
+        self,
+        command: str,
+        prompt: str | None = None,
+        skip_first_line: bool = False,
+        added_timeout: int = 0,
     ) -> str:
         """Send `command` and get all output before the expected ending string.
 
@@ -195,6 +199,7 @@ def send_command(
             prompt: After sending the command, `send_command` will be expecting this string.
                 If :data:`None`, will use the class's default prompt.
             skip_first_line: Skip the first line when capturing the output.
+            added_timeout: additional duration for a given command, if needed.
 
         Returns:
             All output in the buffer before expected string.
@@ -213,6 +218,7 @@ def send_command(
         self._logger.info(f"Sending: '{command}'")
         if prompt is None:
             prompt = self._default_prompt
+        self._ssh_channel.settimeout(self._timeout + added_timeout)
         out: str = ""
         try:
             self._stdin.write(f"{command}{self._command_extra_chars}\n")
@@ -236,6 +242,7 @@ def send_command(
                 self._node.main_session.interactive_session.hostname
             ) from e
         finally:
+            self._ssh_channel.settimeout(self._timeout)
             self._logger.debug(f"Got output: {out}")
         return out
 
-- 
2.47.1

