Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA88CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 21:57:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C33AA4067D;
	Thu, 13 Nov 2025 22:57:26 +0100 (CET)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 5784340151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 22:57:26 +0100 (CET)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-8b1e54aefc5so119899085a.1
 for <dev@dpdk.org>; Thu, 13 Nov 2025 13:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1763071045; x=1763675845; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hra/gSyDi69Nxig+FplcQWSnmWJEhfkgUSm3oxlax5Y=;
 b=PUqhoD0r9dCc2xKjVQAB+YwxHoM0Xondk/16WnR99gLgbhxXD/U8Vkdi+dwka3iGrS
 0ei4XwLb4cqvzfO/i4yD2lzDEsgchKY9rLIXd5ljPt3eqJWDzKVUpUhQkch1kVsM/I3K
 IjKdgdBmjdZcbyzYhxP8rfc088if1BjGPxlc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763071045; x=1763675845;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hra/gSyDi69Nxig+FplcQWSnmWJEhfkgUSm3oxlax5Y=;
 b=sb5LLQPfX1sFnYWuuy+Y099zaZFc1/FAwegVQ3SdFvdbq1y8QPrv+ubXWSCT9ZwxLK
 7zPkx/xxCF8OaKsU+4GmgqhvMMLDSTd4F/AMgYJoiSJbIY12nTMrivkcQlrzMNraqOVc
 gPwT8rDYgn5GzYBoBTLC8RiQmTveK6nih9p+cBxJojLltFNH/2+D6Oty9GibeJOvyQp8
 tphluO4Bgm352sY+/o1lAf9z1c5oC1Hb6SfYw2nsQIYtlKgXiGjA4Bu4IWa9zCF0FSGf
 YPIMDnuAtAcrfmTcZ1Gw7Fw1FhosZtdTccTABhVhDioIKzofESnIiCc7krHTIFAlT3Y7
 FRAA==
X-Gm-Message-State: AOJu0YzWhbSnj+zIvoWR81/VwSZLZigzzmNACVRt/JUEdzR1mPqsVcEQ
 d83m0TtlMcnmE1vdLbpBUS4J5tGAGQDVK58XOaXxpSx92psE+p0jVbEvkxfY6f4wj+M=
X-Gm-Gg: ASbGncux0z1KK90Ios1FNJyiCko6UpP+Xwa0HRCmOYTy4nmmJvHzTXGR8SHM0ADvpMz
 kzERPqgElnbXucxzhkOaKUyDBMFLisKoAY4ZRDH3YNVqxG53SuGOAA52l9LGTW/CakZTS/OZKq2
 qMhhyYNqJ84AjHbjdapb5T54cPoB7zu6BMOFZOldoTaMw3arQKFEdG1FywI/utnfhNIaFk4aZu7
 /6djF+xOkWd99YQmkojKj7nQ1F7TpuuF6bmA/QjvZxIwkaaOXXfAZIxWuNubwSgLdQ3zK55VMFz
 hPs2NKbveyK/3rxIXDPCq6+EEKaoMiDtggkrXdovZD0djzLwMc8lynwITz8ApRJ2nqpHBucy79Q
 viy19Tc7gIBIEl+VxGcZWvwF5V3dOR7DdKampoF5phFMnZK2RcKXocWjqpU4J8J2jLJrQxOlY3D
 2hM6bhcUCRTkxXW5P1iCo=
X-Google-Smtp-Source: AGHT+IEdml/UHNT5tjG73wsUzX9f3483UIPPACC2iqvaZ8OxEf49pKNqUvFnHqlOJdOSpY8/eAIQWA==
X-Received: by 2002:a05:620a:1a26:b0:8a6:9a86:75f2 with SMTP id
 af79cd13be357-8b2c31a6288mr132140885a.46.1763071045507; 
 Thu, 13 Nov 2025 13:57:25 -0800 (PST)
Received: from patrick-laptop.iol.unh.edu
 ([2606:4100:3880:1271:8c70:5b9e:ecd3:14e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2aeeaf78bsm212135585a.15.2025.11.13.13.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 13:57:25 -0800 (PST)
From: Patrick Robb <probb@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, Paul.Szczepanek@arm.com, dmarx@iol.unh.edu,
 abailey@iol.unh.edu, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH] dts: mock pydantic for autodoc
Date: Thu, 13 Nov 2025 16:56:17 -0500
Message-ID: <20251113215617.183141-1-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
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

Mock the Pydantic import so that even when Pydantic
is available on the system, it is not loaded by
Sphinx, ensuring we perform the doc build without
Pydantic regardless of the environment.

Signed-off-by: Patrick Robb <probb@iol.unh.edu>
---
 doc/guides/conf.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/guides/conf.py b/doc/guides/conf.py
index 2c1aa81bbf..29d5cf019d 100644
--- a/doc/guides/conf.py
+++ b/doc/guides/conf.py
@@ -106,6 +106,9 @@
     # fabric.Connection (without) vs. fabric.connection.Connection (with)
     autodoc_mock_imports = importlib.import_module('check-dts-requirements').get_missing_imports()
 
+    # Always mock Pydantic to avoid autodoc introspecting its internals
+    autodoc_mock_imports = list(set(autodoc_mock_imports + ['pydantic', 'pydantic_core']))
+
 
 # ####### :numref: fallback ########
 # The following hook functions add some simple handling for the :numref:
-- 
2.49.0

