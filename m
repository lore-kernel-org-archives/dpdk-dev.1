Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24CAC982FE
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 20:18:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A423A42EA5;
	Fri, 16 Jan 2026 21:17:55 +0100 (CET)
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66]) by mails.dpdk.org (Postfix) with ESMTP id B8E5342EA0
 for <dev@dpdk.org>; Fri, 16 Jan 2026 21:17:51 +0100 (CET)
Received: by mail-ej1-f66.google.com with SMTP id
 a640c23a62f3a-b8719aeebc8so459222266b.3
 for <dev@dpdk.org>; Fri, 16 Jan 2026 12:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768594671;
 x=1769199471; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4CNhL0HurC6dvjc2hb1oRxQCOcv2n26+PiXolU8Fvew=;
 b=Fw948ZKKVo02/ny2IOZ4KsNO3Gg6ZgSOFs0UkZbiafaKeMNOVvPYXscfe5Ylv0iFNE
 7EhodXot64vfZKEBQ4lcd5b0z19gncE71Kg578RNLa+etltxBUYsJH+dSse9zrRlmT8B
 S+hCw+LZdIDUAAaBScVtCl44ecMlQbSQn3qBHhdoW6dpeQorrV3Xnbo9/7tlLa/Qc5Xj
 qKtUEaWahqr5QbE9VnS+a/9QWqoplPjWn5PQzkJniCg9dHZx/pRm5IQl1bpOSSIfpKD+
 LEMsy3RSRfYwwjMJ3yZ5tbLLZxw2jxxV5kZep6G02HLukT6cdWhWfxsLryx0nZY/c1Uz
 9dcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768594671; x=1769199471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4CNhL0HurC6dvjc2hb1oRxQCOcv2n26+PiXolU8Fvew=;
 b=QYCKLzWJj0S0S1kWwlLPIeaqtXlr7TO9zPSpH7LzbU80sM+ozsL4nuFs2qWkxTzKG3
 NtVpCQVzd3FyXWfCsVZZN0eUlAMaLN7ex/wAi0oETJAbW9AOYMc1ptwOGWk8WOJlNt8J
 upH8VP008CQ13ULF/c7D98/0otkL3XtPZBKj3J9O3d5x8PD9jnYB6h5RdgA/xVhli8H3
 Q9SLfwzAYVkAMAepW4t16NbJdx3pFPu7J0w5FsvZ3bG0vAhjQg7F+GewId1VCWOIXgar
 Xklb0uFWW59wlqGq9fKa10Sf7wEl3lwWU4ufDX4tjtptYFAktxHEaFFIu1W7eJlkU3g/
 ChNA==
X-Gm-Message-State: AOJu0YxSCK625CuPe5Mu8AXNfxy8IgsQ53o21qPG2NQv63GLmG0hqvtm
 jGZGTL0OmCFfGfeOKS18DWu3SjwlXU/FMhebJbuajrspLakzNY+/ZfJRIShXlAgIXG7CfyfQNvW
 j1yu5lxQ=
X-Gm-Gg: AY/fxX40IoMsLsxohxTIm/kiJ9284+wbug4Vjzgtmhv7w5v8Qz1kBtAoEYwmge8Br1T
 VKW8o8210cqLBv3qAJSH5ZPQsssl5vDa01mI5ReXqXoYP4NkBMDG0lE6r6wOVTao3nx4v1RjiNF
 AapVucZ8j7vm1W/s0VnU6gZPqE7hldBPOVpB9VOhKnsz3G9QNJAhgEK2IVlcP7olnS2RtDYUdK5
 5Av5NGdcsuw58DqbPeWBbAOFlH1JWEYKbRts/W0G5zXBhQMZHfbxQZJomO5sJenpkQdMU+rA3Xo
 yAQhW9GcVGXVKjoTlHjCnC1tMRxLb4QpQ6sxVJT5SGWVrxnvYl8cGJGqed3onK49cFCfF1O0WK5
 r/ifyQYwbuQPHQWTPh7vLp31I1agvLav+brEu40v7AnjFk4/CAEwY2jRTmAZY5GEj0KuCNhw7gA
 y5LmOgLpAdXy+ytXpeaOFBM4ylV/ckOHb2KaaCRik7Nd5x2UjEEQ==
X-Received: by 2002:a17:906:4790:b0:b87:c9a:58d2 with SMTP id
 a640c23a62f3a-b87930243c7mr375221366b.62.1768594670332; 
 Fri, 16 Jan 2026 12:17:50 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795169f10sm338631466b.26.2026.01.16.12.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 12:17:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 04/12] doc: improve documentation guidelines style
Date: Fri, 16 Jan 2026 12:14:22 -0800
Message-ID: <20260116201738.74578-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116201738.74578-1-stephen@networkplumber.org>
References: <20260114225555.127448-1-stephen@networkplumber.org>
 <20260116201738.74578-1-stephen@networkplumber.org>
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

Improve readability of the documentation guidelines
- Using active voice throughout
- Converting "should be" constructions to imperative mood
- Fixing minor grammar issues in Doxygen guidance

No technical content changes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/contributing/documentation.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/guides/contributing/documentation.rst b/doc/guides/contributing/documentation.rst
index 338254cf30..c6009cbc12 100644
--- a/doc/guides/contributing/documentation.rst
+++ b/doc/guides/contributing/documentation.rst
@@ -39,7 +39,7 @@ The main directories that contain files related to documentation are shown below
        |-- ...
 
 
-The API documentation is built from `Doxygen <http://www.doxygen.nl>`_ comments in the header files.
+Doxygen comments in header files generate the API documentation. These are built from `Doxygen <http://www.doxygen.nl>`_ comments in the header files.
 These files are mainly in the ``lib/*`` directories although some of the Poll Mode Drivers in ``drivers/net``
 are also documented with Doxygen.
 
@@ -84,7 +84,7 @@ added to by the developer.
   The API documentation explains how to use the public DPDK functions.
   The `API index page <https://doc.dpdk.org/api/>`_ shows the generated API documentation with related groups of functions.
 
-  The API documentation should be updated via Doxygen comments when new functions are added.
+  Update API documentation via Doxygen comments when adding new functions.
 
 * **Getting Started Guides**
 
@@ -606,7 +606,7 @@ The following are some guidelines for use of Doxygen in the DPDK API documentati
   It isn't necessary to explicitly name each file since the configuration matches all ``rte_*.h`` files in the directory.
 
 * Use proper capitalization and punctuation in the Doxygen comments since they will become sentences in the documentation.
-  This in particular applies to single line comments, which is the case the is most often forgotten.
+  This applies particularly to single-line comments, which developers most often forget.
 
 * Use ``@`` style Doxygen commands instead of ``\`` style commands.
 
-- 
2.51.0

