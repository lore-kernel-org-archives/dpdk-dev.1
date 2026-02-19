Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BE7E9A055
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 17:52:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A1D140691;
	Thu, 19 Feb 2026 18:51:24 +0100 (CET)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47]) by mails.dpdk.org (Postfix) with ESMTP id 1AEC940678
 for <dev@dpdk.org>; Thu, 19 Feb 2026 18:51:21 +0100 (CET)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7d4cb7e10efso1085870a34.0
 for <dev@dpdk.org>; Thu, 19 Feb 2026 09:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771523480;
 x=1772128280; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Agtj7lBn+mXa3a4MNseBXNLXyr580RNslJo/f8sQayM=;
 b=0gUMDNXq8I3iWzCyikmq26B5sHhBwG0jTp6S541CKjHIH8W6FdN3cYLzh1vXyGerBk
 j5L2NcqSuOZ1tiQJctlo02C45nQB3Mt3d/l56mW/91cYs+stjrC/fAk8aYqvs/dr8cFw
 Z5Dbdx5Js9DVwa5TI87oNFWf9sYKb7t+ycAzFScQ862dQ2jhUGgHZTZ+PifYEPYH91G4
 1Am1yuCnvAFm6/qVPF1xr9rXF+DeyYalSDgE2sQsgvynl4idSQpUS/V09dPZ6Gxb12Yf
 oncdoH6Q4ItMYuWu6WbIjm7GAHExXoxTn2RSLgKpjuhvn9lerUAtq3ttFYilqtSiwzAv
 +WCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771523480; x=1772128280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Agtj7lBn+mXa3a4MNseBXNLXyr580RNslJo/f8sQayM=;
 b=L0I8jQ5MPO5xkH9wj8q0BzekD+AmMFtouNh0QM0JpgxrKO7PjxfIupLUPiVst7HiJ2
 xh3eUQWNKSmfsD0xKDJS+OIY1dvIXseoGjd0T8ABR+rQWCP0fSjrbSdEvMjW7QvrV5tb
 RuR08+okb6siHwYTI8x/EHQWR0Bhsvx9YiYzX36Zx4lpIE/oCH9lIIegh2zRpPIswmzj
 bmFOQokYfpMzVAllLuG4jnruQduwCqcpMrdD+gtRAZ/qBSuo6HemRshILULAIvvGPmVj
 rtJqGkq0fDMo02yA6QZiTHkNaEYsXcH9Y+N+trO57Y9j+xqU+yrB5KwwBp5RbUJ3Cp7A
 aNLA==
X-Gm-Message-State: AOJu0YyVR0BjlJJi9jVgMRhFcpPOznvVsVt5eld5VeuV/8vNGUcQOkjt
 KiVMhrFd8gsm9fhfrC1A19lDusD5FVK5mJMvAuLoumsPX8gFDwZryVIh6gy21EFb/YWQjaZVMqw
 L/NpI
X-Gm-Gg: AZuq6aIaqEL5pMG1WJolJLk9e5RYBm6XdDZ1pLyn7y8VDz6DVi0d6gHqWOBKBoqn5XO
 jVc9RhDClGPXBFVQQdWZhkTYQDz7Z/FRt1VhOpnzD27elFMXosEBruG4SGnFvp3WKowdvu/9ZhK
 AXbMleRDdwiyU6FwZ+f4nSO1sRDAuEr+2tz/izmYWiFFNWkVZdXXDvjngjB0EXW+a2lD/LrPa2Z
 iqkCUeqQWqXGkmRks70C8KQPuQh4fgmVL+C2x/FIl3t1y9+uH+LViqeYyMXUYt729YjZ8ohSa1a
 HS8lLw35PhRZRamTPFApq1oCJHNyHVC/35/MABhovEYxZ9ptjlQjj7So4BTRXvk8Gwp3BCMI2Sk
 aePsKQgLDwSAcW+K15D8TihCeWVVFsNxWsbjzHhVaqRyW0Y6rVSWEp7xlU0u5hd5EKLGLcgJncQ
 NMOV+JlJOnnDsgNm2kxv5CuQxzSKRlvuUrZEBiUjD/UE9SMtglocI580AxHHStww==
X-Received: by 2002:a05:6820:1607:b0:672:ef44:4f34 with SMTP id
 006d021491bc7-67858fea344mr9866345eaf.5.1771523480258; 
 Thu, 19 Feb 2026 09:51:20 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67985df6ffcsm10261701eaf.4.2026.02.19.09.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:51:19 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 6/6] MAINTAINERS: add section for AI review tools
Date: Thu, 19 Feb 2026 09:48:51 -0800
Message-ID: <20260219175110.287747-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260219175110.287747-1-stephen@networkplumber.org>
References: <20260213214107.234072-1-stephen@networkplumber.org>
 <20260219175110.287747-1-stephen@networkplumber.org>
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

Add maintainer entries for the AI-assisted code review tooling:
AGENTS.md, analyze-patch.py, compare-reviews.sh, and
review-doc.py.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b2f1ed2ba..48ceff9010 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -109,6 +109,14 @@ F: license/
 F: .editorconfig
 F: .mailmap
 
+AI review tools
+M: Stephen Hemminger <stephen@networkplumber.org>
+M: Aaron Conole <aconole@redhat.com>
+F: AGENTS.md
+F: devtools/analyze-patch.py
+F: devtools/compare-reviews.sh
+F: devtools/review-doc.py
+
 Linux kernel uAPI headers
 M: Maxime Coquelin <maxime.coquelin@redhat.com>
 F: devtools/linux-uapi.sh
-- 
2.51.0

