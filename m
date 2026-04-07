Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA52FF5106
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:18:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E3F540A6F;
	Tue,  7 Apr 2026 17:18:19 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3A7824065C
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:18:18 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-c76e702e01aso1018250a12.3
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775575097;
 x=1776179897; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWQhc8jVkipjeT1npLBJUThOmnS30FqL4Z3TvxE7VlA=;
 b=MvMirFKJRzOstnunBLpmxiudl7GpsK8+HXcxpE9OZpqd6emF4CPcV/6SuXGZZhatya
 1+PnesnI40JdCmIAPk9mFeL4LrqVoRBdumaQ9trM86OzLto/CVW91Hsa9QdW7VpUzCpd
 5hofscx5Uh+n2CtTrs+pEguMl+NkiVmBlPIWm3ZiGAumm+c8JmuzOiTLXGPZj1gV/JQW
 45XWCgJ+g8eUPGS5BmYnLn9qQXeafAYk11cQJ0wSpxjVJrcz0BAchyz7iR0OHDV9JuKL
 7wFeeHAy7ciRMrTc4YO+XQ3PecCPzVOSSSeffm3Z8t45QkUW/BuOFm7rgtCq7O2xfl5V
 tQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575097; x=1776179897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wWQhc8jVkipjeT1npLBJUThOmnS30FqL4Z3TvxE7VlA=;
 b=cM2vQ+jT7AZf0K/zbV1l1Ri4xYAfsvSxkdInoNhasUxcrwOChtmP+Tld1YeQPdkb3Z
 JV6V9P155xsZH/o0cKZ8UfYuwDRDmEfg0uartQ1xLUO+F1LnKOEMYd3tK7+/rB9oURgB
 mzCC+H+oPw1juiLEYQNM6cLXdUw5uP6axVeFsb0vmQ1aDHn6X/VejuITX5Or6TLpxsGx
 J1y4+s1CowfeOlR5RljTlJZTR44kdvNkJmTM3jMY3zg96Sccs8OKpRe5ZrNF3x6dDTEv
 WchfmKrClpfE3fNg8hVH8Llom/+0jyoKfgbwwahxk0nGFq8KcKO4e/F2VMeTZLuciYbK
 sHgw==
X-Gm-Message-State: AOJu0YyhlojaA767wTyJsRhYS4MLI1aHo0wZ2Ulec0Xz7iPkiufSxB4y
 bAWaocv3lL/ltYewJDWXk+zgTQhrGomCUkDebEaeWzdvfOLGeXcCw8XFTLm0WA4ZniEdddX2f/t
 JlHiJ
X-Gm-Gg: AeBDievyQWVAOoYJTUKXcMK6U5YRvyaMBwPQaZphesA2N8Bb6jNCQ+f8zEx/fFcqt3d
 qmGAmVwUDGetDACcZH6Gl1OCY4KKGOUTGkXhsWbi850fHLonEd22K2NY6fed+ezfzq7A2kVGy8M
 dYEOwzNlC+dXwOPQath1teeuE6J1fZ+o6gMDyeuEaqiIWmVMbVNOjW+3tDIYpY5flwa+CtFFWr3
 VCPtNOXqQv2dw5lWutVTvjqf+5Wp4Dvg4dQGRZEsxZAacVPzT+nOeDQ5vxxaZetX/IilkrBd5Kl
 QkdzswqKKL+43qovRtQLwkrKo+g0YgGZo9WBsrLKmdEMyyCPMks6P1xeWusxDbTZflY1ze5wWHA
 BSbhqoYUmh+ww1skbfM4LZZxynLF4Rzg49qEfIZEagrq0hSc4dEwBzTTH5/Cf7wBszvge/FfwHo
 BQq+Z1moSIeigAtmk1D/1KGn00loPc3Cux
X-Received: by 2002:a05:6a20:6a28:b0:39b:d937:8020 with SMTP id
 adf61e73a8af0-39f2f2f6eaemr16747023637.42.1775575097372; 
 Tue, 07 Apr 2026 08:18:17 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm15842933a12.3.2026.04.07.08.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:18:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 11/23] examples/multi_process: resolve shadowed variable
 warnings
Date: Tue,  7 Apr 2026 08:16:07 -0700
Message-ID: <20260407151732.272195-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407151732.272195-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
 <20260407151732.272195-1-stephen@networkplumber.org>
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

The string passed to parsing function number of clients
shadowed global declaration. Also avoid similar problem in
parsing portmask.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 .../multi_process/client_server_mp/mp_server/args.c  | 12 ++++++------
 .../client_server_mp/mp_server/meson.build           |  1 -
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/examples/multi_process/client_server_mp/mp_server/args.c b/examples/multi_process/client_server_mp/mp_server/args.c
index 3c2ca266b0..60dbb3c626 100644
--- a/examples/multi_process/client_server_mp/mp_server/args.c
+++ b/examples/multi_process/client_server_mp/mp_server/args.c
@@ -42,18 +42,18 @@ usage(void)
  * array variable
  */
 static int
-parse_portmask(const char *portmask)
+parse_portmask(const char *str)
 {
 	char *end = NULL;
 	unsigned long long pm;
 	uint16_t id;
 
-	if (portmask == NULL || *portmask == '\0')
+	if (str == NULL || *str == '\0')
 		return -1;
 
 	/* convert parameter to a number and verify */
 	errno = 0;
-	pm = strtoull(portmask, &end, 16);
+	pm = strtoull(str, &end, 16);
 	if (errno != 0 || end == NULL || *end != '\0')
 		return -1;
 
@@ -80,15 +80,15 @@ parse_portmask(const char *portmask)
  * and convert to a number to store in the num_clients variable
  */
 static int
-parse_num_clients(const char *clients)
+parse_num_clients(const char *str)
 {
 	char *end = NULL;
 	unsigned long temp;
 
-	if (clients == NULL || *clients == '\0')
+	if (str == NULL || *str == '\0')
 		return -1;
 
-	temp = strtoul(clients, &end, 10);
+	temp = strtoul(str, &end, 10);
 	if (end == NULL || *end != '\0' || temp == 0)
 		return -1;
 
diff --git a/examples/multi_process/client_server_mp/mp_server/meson.build b/examples/multi_process/client_server_mp/mp_server/meson.build
index a31eea764e..9e585e80b9 100644
--- a/examples/multi_process/client_server_mp/mp_server/meson.build
+++ b/examples/multi_process/client_server_mp/mp_server/meson.build
@@ -14,4 +14,3 @@ sources = files(
         'init.c',
         'main.c',
 )
-cflags += no_shadow_cflag
-- 
2.53.0

