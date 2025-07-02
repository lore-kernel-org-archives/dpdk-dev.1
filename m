Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D555C83038
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 05:27:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A70E940668;
	Wed,  2 Jul 2025 07:27:50 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 2E2A940684
 for <dev@dpdk.org>; Wed,  2 Jul 2025 07:27:49 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7d2107eb668so1069536285a.1
 for <dev@dpdk.org>; Tue, 01 Jul 2025 22:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751434068; x=1752038868; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NMUOimFqymH5VM3xVfAslIXSuynEvUP9iPOZ8wWlUP4=;
 b=B/sbowrLrNrWvZFzAheRaTdhUVhR67qEM/cSX2FwJdsa7QIwOptDrD4pav/kZrf66s
 0vMoJ1r9VpHJCG7CQMf7oiP4Mf3wFnjxZLYt429E0bbnro4eTx4/BwtovxK8LlPl8Mzq
 B11aL8OKODeJugzvWNcV/Y/WntWOqKwki3xYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751434068; x=1752038868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NMUOimFqymH5VM3xVfAslIXSuynEvUP9iPOZ8wWlUP4=;
 b=NFI71U0xjf1GSqrmymE7w+n3p+aCNWBsAqOEk/xqqHJuwxo4qUgCkVQf8amXaSr7lA
 coYIHSVreyj6joYcK1DmjwcRFRM5F6bcZJUtE4D2wk12ulBIQ0Z9uUVQzCx+7eulPfuh
 R+DFu1WzuQ/2LW4nAvgGY7OWjjldH7a3o9vNT1gahNa4sVW2qNp8Yvj375YPw+ROLZNz
 bYfhdzSEYG05tVk1EwuJbGi2MufP4PISMJSsUivFH5p32+6X9yNsn/QoZNud9gr4+cqG
 dLE0S+1vfD8cOUltgmVthE6ewNNts/9BgpjbEXw2rPVGJwUe3gfUlj7k6jio/pwWeFG3
 hBBg==
X-Gm-Message-State: AOJu0YyXXs3hBQn/+XwyLp2IsB/CuQV9y6Ms5Gdwic6FfTX5Jc8bXKlu
 VVIBqg7NW159t18Vi45nMkmNmdUz3k91716v5BHClvPLhQDSB9cyYnVEuSHvv2/8ojs=
X-Gm-Gg: ASbGncu6dfXRyD96CGDW7CAtu21w9ua5Ed+Ji7h6oeVvndPV5he60wO00lYOnDTjZDA
 tSHRg8xqd/5q6xu4G2aUWzJLchknA4soLium09sY99q8Un5ZrZHBGZRvg9e19IfQJFpPqDr86N+
 Vv2ao6Vm15BB/h2qp57gT9PMuRczEds0So4DkscVcqPiT4dGdYSAnV5SkxpacdJK4zB5/zIx8RK
 KbkWNXsVDqRjFVM1nJtfQ5QC9CRK45TY3vvlIay0bDHuSN9OvLxDCGdmIWkoPplya66Fz1nFEqy
 oQnYpiUD6h4Grxzu6B7EdzReblWsM5cqdUnLd4ly1Lwomr1uRbVFebWq73rhuTZs
X-Google-Smtp-Source: AGHT+IFghiDCt6dJHxouQOuUBo7Wr6MgMRFCxgumgWIxqGZrmUbF4cgwtLQ8u3btmQhAu7pM9kWWog==
X-Received: by 2002:a05:620a:414a:b0:7c3:c9f4:522 with SMTP id
 af79cd13be357-7d5c468ee08mr210785285a.14.1751434068424; 
 Tue, 01 Jul 2025 22:27:48 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1257::10e7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d45c0fe6dfsm469274185a.58.2025.07.01.22.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 22:27:48 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Paul.Szczepanek@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, nprattedev@gmail.com,
 mmahajan@iol.unh.edu, abailey@iol.unh.edu, Luca.Vizzarro@arm.com,
 thomas.wilks@arm.com, Nicholas Pratte <npratte@iol.unh.edu>,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v3 3/5] dts: add timeout override option to interactive shells
Date: Wed,  2 Jul 2025 01:21:52 -0400
Message-ID: <20250702052154.381690-3-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702052154.381690-1-probb@iol.unh.edu>
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250702052154.381690-1-probb@iol.unh.edu>
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

From: Nicholas Pratte <npratte@iol.unh.edu>

Add an extra parameter to the interactive shell send command
to handle function to allow for a 1 time override of the send
command timeout.

Bugzilla ID: 1697
Signed-off-by: Nicholas Pratte <npratte@iol.unh.edu>
Signed-off-by: Patrick Robb <probb@iol.unh.edu>
Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
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
2.49.0

