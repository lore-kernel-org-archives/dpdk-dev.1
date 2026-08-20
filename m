Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A85BC5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:23:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC45040679;
	Thu, 20 Aug 2026 07:23:04 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id BBD1140678
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:23:03 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2caced6038eso6018395ad.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203383;
 x=1787808183; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yJ/jvZOvI0DzBB6o05Gueum3y/MpMNQlADjKoCk82dY=;
 b=XtZQ0oRky46U6xKJekseeZys0XNT4LI7MHhC4A+hMeGklq0cohskZ4us72Xm+ePw8C
 uBD/YZBrnPTv16GSAQWRFJ70WMokffuRbJpGLQsjPB0FQApgVSK2iDITGch7DqfPHXH/
 KEmPDAQo/dEd0P3rEUdBaf/TB5l1eqlYaWOWZVfxxCaeFAsrGWdI1LrovsFsoTxUnxY0
 XjZp+2anbG82RneyLQjiNPrAyvuD5QhRjM4rifR3UUxngmQJDK4xWZJVfRWcJan839G9
 rq29AaOAUt+SIFEHf2vGCYT7G9WuS8y/WE6J1gpMkhVZ4sUR36VqZw/CYRShc+4KBH+b
 UkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203383; x=1787808183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yJ/jvZOvI0DzBB6o05Gueum3y/MpMNQlADjKoCk82dY=;
 b=IPFyzU746vVl2vDq4p42PkK3nUij7EAiYNqRREfV3pGLfSU6ZEAj7hFnbuZUanIXSL
 LkBijadVIFSZo57Udzsmz+CClmpJpy9l7mFuJkaQ7WKsqhQrgNq+slAF8utMJY1YOFtr
 rshWuXd272jeVuwwx6q1xJ4p498SJMr5Wdhv9dAjDTvbpdQM3sf7kERVXRHDdrJT1Ff2
 fklBZqN511XfkEmzE4a8X+9PZrOgnAi0uyvbo9FRdzmQuxDOy7N4FmJzh1yCnQ6gm0HN
 CYktgTeWmZH8WJxqnKNNC8hQbsEcluR8ToD50UF5bz3ZPZjnU6HRj7qbCCzDPKcYpzWg
 K4dQ==
X-Gm-Message-State: AFuF++n1H6tKOkYFjKeeolY08/XfIIclWAGSs9jbei/oKtTlxgViQBqA
 Z1EDZZJGSP4HYdmkjuXiBTK7NC9soPZmOxTECofZrJ7nCSgssCJZ7sUbvzUwTR8mzgt30VnE5d4
 LGnJP
X-Gm-Gg: AR+sD13J4aSYsNdAzC5/ifvGqRi1VodMW1qlhcT8GvcvftyvuTulfNBa8wq/+iWSzTe
 tunGgI+5BIgXCiieYrer0cr/QKhXaUxtq2zZ2cFIu1hKvSkEq0hTMeeFfR95DryQ7CM7O8UlTKo
 Ch//Qd/nQLkgQK9h0CrMmR2zNIpXSLNR7uztVkerPtH8xLw6v7BNoILHTiv72nSh/jBQM0za7GD
 2vFlOodrmfZNmeLliKaGTZuwaSpUtencZZC7WEmD/XZ1vhD12rir7kHHuTlUFshLxrUtyhtP2nX
 fRBUo8bL4UJQ042F8n66+PjkE1pddvDogbFeymJ1mCR1Y1eTDBAoWMjND4swa73jjMa39Esgbig
 QUI4V1T9tDypRJgMY24dBljV452If/r2v0V7oVD95xQd8yUN25c2nd+MAioE3NWAnApe2ZCV19W
 tw8gJxZSO25E2aNrdI7yLUjoucy/1iSy9Hox1t1KQfvdIqyDLTM01hzBJ935O4qjFsn1SBIrnlp
 CnyfOFsW4kZfdnuslCRBjF+uLs=
X-Received: by 2002:a17:903:3b85:b0:2cc:ac15:ff4c with SMTP id
 d9443c01a7336-2d61a0da51fmr50977095ad.8.1787203382756; 
 Wed, 19 Aug 2026 22:23:02 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:23:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 01/61] devtools/cocci: add script to replace fixed size
 rte_memcpy
Date: Wed, 19 Aug 2026 22:11:51 -0700
Message-ID: <20260820052251.1453273-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

Rte_memcpy need not be used for the simple case of copying
a fix sized because it is not faster and will hide problems
from code analysis tools. Static and dynamic analyzers
special case memcpy() and can find issues that rte_memcpy()
will hide.

Note: many platforms use memcpy instead of rte_memcpy already.
The only reason rte_memcpy() was added in original DPDK was that
the older Gcc was doing slower on x86 than the special rte_memcpy()
when handling larger size copies.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/cocci/rte_memcpy_fixed.cocci | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 devtools/cocci/rte_memcpy_fixed.cocci

diff --git a/devtools/cocci/rte_memcpy_fixed.cocci b/devtools/cocci/rte_memcpy_fixed.cocci
new file mode 100644
index 0000000000..1f264711eb
--- /dev/null
+++ b/devtools/cocci/rte_memcpy_fixed.cocci
@@ -0,0 +1,15 @@
+//
+// rte_memcpy should not be used for simple fixed size structure
+// because compiler's are smart enough to inline these.
+//
+@@
+expression src, dst, E;
+constant size;
+@@
+(
+- rte_memcpy(dst, src, sizeof(E))
++ memcpy(dst, src, sizeof(E))
+|
+- rte_memcpy(dst, src, size)
++ memcpy(dst, src, size)
+)
-- 
2.53.0

