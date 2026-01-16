Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F13BC982C0
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 21:17:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC5C242EC1;
	Fri, 16 Jan 2026 22:17:12 +0100 (CET)
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68]) by mails.dpdk.org (Postfix) with ESMTP id DA4FB42EBA
 for <dev@dpdk.org>; Fri, 16 Jan 2026 22:17:11 +0100 (CET)
Received: by mail-ej1-f68.google.com with SMTP id
 a640c23a62f3a-b8712507269so360346266b.3
 for <dev@dpdk.org>; Fri, 16 Jan 2026 13:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768598231;
 x=1769203031; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QoI3sUNNsXl1XMifjszQgzOiCyNubxq+8hWexRGhlPs=;
 b=1sH/eGCJ76oJQYLd8ueMCQMCsaoIIMWUxCWo8lFfK5K4biPjV2/tLJGFusWprVsCAm
 0/RbCMbmoUzdFudTqn2xc8JcNdI+/9rw7dOIdimTE4womIApAbJ67Vh59KrrUtxD5Deo
 8byhxgnk+0j3n9epNOqdglwMMHba8QnAmn2TDN5PwKwME/+AWMuHxF2s22hKAQjfTEPy
 RMRseNraAaGHAz1J9OKqdEPFnt26hM70GO7qbhYeShlz+x1jRcwvK6Qx5dsDUbD1EMtN
 v4DcORPBxz9so/vV5GhoxHB/0ZX6h48LmhYD/j9liXpqLJfNzbDV06fh5kjJyV0YPYxh
 AqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768598231; x=1769203031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QoI3sUNNsXl1XMifjszQgzOiCyNubxq+8hWexRGhlPs=;
 b=WFqaD6bkgUF6afsFDJ/wZmW1VZmZ90T6v6HxYBaDG0+HLZHHQ/strUuSCG8HqAlWGW
 RCXS+z5MFijVmLn57ZugZGfiSAVtvWOo8+HcFHRp3T/Dr0W+UHzLYfEYd/7BtyFoRcdr
 08+LsZdlGGmOsuG2ZW1/pycn8wWoyv19OSjax1v6DZMYmN1mvXC0QwSeeuYe7JgDw2Nq
 vgvzvEkyK3lU3KjCBgw2XhV391gzjVckcl5TIXlhrGaCnHRExbfbaWQ7+egiZFLTSBKL
 Bq7EZP13lRvCJ5qW16Ewcm7fFF64OapK0n9FKrNU8v8payTTkVFipjjFGy57PzbTUsqr
 9fpA==
X-Gm-Message-State: AOJu0YwpW5fPXi4mGdKKgKCEPe5HLAJ/STroFEkR7eyGjSGp0eXsy+aX
 J5GV2OymrnspY6RImPenwIxE7mtTOwCXaVIu5ULSRbKJK9azabCC+DdtrLuxCUtv0OPPhPSG1U2
 sVkWPYTU=
X-Gm-Gg: AY/fxX5KA8GWBuX15vGvlLexoDxRlKLSbDD8ND+xUbDbFQHGxmgUKuqcxf/wZxyxaz6
 bUSC29PCquw4LrAOOUIMgHwD2+zscCMPPI7z4ddtFdnkMBcibXN5EKPAg0s63i/4GXz0/cNTZpR
 m1plMpBfpIHQ7lhu29ea34zLvfuAdbdS2WG6Kbru/W/JjTKZ3ZsgUa/NEjTDQwAcAKzS94XJf2c
 TXP2B1EGhpa/P4DFD7gRZZdmItfW19mfwGQ8fJuKp+bMNovPkdKGh2a7LqHR63lNUK9rftWtI6t
 P6c/hjaH34i1/3bzFPS+bfOI8q3jThnw5R5oImbzwCywo/J/HOurC6JEM+UrwK2KZEyilntKWXu
 6uoRDBOPT6/jwOf0HU5YwD+iQ97jNSOUZPBXGYcLL5F2JPBjOw1Fik/FhOlvltOpcsUoVQyG7aw
 TcjXoPMmNRPn7gzRDF4+SGcyVce5XhIW8+S1bLb14DJVutIyOySw==
X-Received: by 2002:a17:907:d1d:b0:b83:32b7:21b0 with SMTP id
 a640c23a62f3a-b8792d65c51mr390386066b.17.1768598231451; 
 Fri, 16 Jan 2026 13:17:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795168ca9sm336649066b.15.2026.01.16.13.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 13:17:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 08/11] doc: remove redundant text in documentation roadmap
Date: Fri, 16 Jan 2026 13:06:24 -0800
Message-ID: <20260116211649.104776-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116211649.104776-1-stephen@networkplumber.org>
References: <20260116211649.104776-1-stephen@networkplumber.org>
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

Remove redundant "(linux)" parenthetical that duplicates information
already conveyed by "Linux* application".

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/linux_gsg/doc_roadmap.include.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/linux_gsg/doc_roadmap.include.rst b/doc/guides/linux_gsg/doc_roadmap.include.rst
index 6686975f7b..5042c386c2 100644
--- a/doc/guides/linux_gsg/doc_roadmap.include.rst
+++ b/doc/guides/linux_gsg/doc_roadmap.include.rst
@@ -17,7 +17,7 @@ The following is a list of DPDK documents in the suggested reading order:
 *   :doc:`../prog_guide/index`: Describes:
 
     *   The software architecture and how to use it (through examples),
-        specifically in a Linux* application (linux) environment
+        specifically in a Linux* application environment
 
     *   The content of the DPDK, the build system (including the commands
         that can be used to build the development kit and an application)
-- 
2.51.0

