Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907DCCE9D65
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 15:39:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AA5940B91;
	Tue,  6 Jan 2026 16:39:03 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 620AF40A79
 for <dev@dpdk.org>; Tue,  6 Jan 2026 16:39:00 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-47a8195e515so7912545e9.0
 for <dev@dpdk.org>; Tue, 06 Jan 2026 07:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1767713940; x=1768318740; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EEkxbGvJ1VRMFXDoGy+m5ei8smAtxqk6NTUQDr8dL8c=;
 b=G8K3oK245BcwhLjRbCC8UYA3F8LmMNDZUVCB9exvaCko8NNrZPmzsluDZcTLBXg06c
 fpzSFezthiV7O+e3Q10qFthCY2Tkxy+fyJzgwffX9ou5WYGRj4qjdi79ZqVlH/ZkIhXB
 HOrjS+zIiK58LwmPol7ASF5ZW4en+9rwibW28mdu/3rk1LqM5g5+EcZqbSWjGrRCkz82
 GocFXjyqX3CXRYA2cJVdFcWrFtD0A/Z9GzSU8KjDLTz3NJ7l+h2s8FZHgQSn3LuqnloU
 1zNjrWJ5jv46PNRCpDYC0OwTKJAqIsjmwBlWFeAPLo04AheCxoSoX8yPhXVT8PY9WkOw
 rSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767713940; x=1768318740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EEkxbGvJ1VRMFXDoGy+m5ei8smAtxqk6NTUQDr8dL8c=;
 b=VXJMOrG9nf3mE34cvyZBDP6r0kAxneY+x8LWldMzzweYdp6TZvW9TrJeIfWbZHdnr5
 QV2Hbgo4WiF49MgCLDkLzaZhjqnQ3dizH7VECs32/UkOceZUwCmSA/DZF4KYp5VB5iO+
 I2DgwOIzoKd6GCKY1N8mh5U7sDtrHctHmNJPcrpq+aPcDbx/Vv6OZeMwsY0ogmLmzE7z
 gULjWYThgwHFkyXKHC5SR5ToZxSnz2NFGFoS2uJIvh2X9BxiWU/jdjt2/jNhDSEqzgZk
 E/JEQnTLdwZGrNojhzPLjFJIryvzffO9d+qA/T3bc/ptHFXwlQp2dx0o6VbkJPlArpAn
 Fl9Q==
X-Gm-Message-State: AOJu0YylZcrlnpbMqWDmN6PymiOoB0vYbyKboS14C/YpWU4LiQO6HidA
 xOodsWwob/qW3U3qUdjqtOy4iwlhH9QcUCFESfIWk9joc65N7PYTy3fOegBDbI4fQj2WyxL7XzN
 2lOQ5
X-Gm-Gg: AY/fxX4gRD8Zm4tOf0q7o600LUdS0KuqlpKkCP11B5gDqr/37wvoAPbeKnigKtbUPc7
 yDzg5wTwWmJKcSAhc56yaosDkt2gm3Ya/sZonx2oZVgkOG4sDUNDGTflxe9Jvc3Q4l/CswfixJg
 6Uq4SNPBfVnym1zqo3JRzKxxaicLAlvQqj+QjddaKtd2jTQptpKfR/KG2olrodVgR0zp6trJaWe
 Ioq8u34ajP3UAZtLjmRXuAPUsWMs6giCjxXMaJdRiTC26k9CsmGXG8FxXiYXh6JZED0SQZwTmhE
 xJ0xjPSNB1Rq8jPJWck7rsOwhnrMroSvrjkZJTz/iis8O+2MgXenpi1mDXeay3XnJNr2K5IMPmX
 5WTrp1Zimx+AGj2n2uPDlGo0GJCM0D7P1e8P7OFi73JRw6uXiOdmJ99HEr3Vc47+vZs+r1b0niD
 IV1Ydrv7dV49RA5DWTvz1nuk6eRILHcjjcZEmYRtYzehErcQ==
X-Google-Smtp-Source: AGHT+IGs0fzLNCfxuHElqtTNVH3xoLPkW8tXdgRG5C4KDrNs7H77PlzrH6yXBKDGnYfqsoW5wAlI1A==
X-Received: by 2002:a05:600c:19cc:b0:47a:8088:439c with SMTP id
 5b1f17b1804b1-47d7f0a8788mr38661835e9.35.1767713939705; 
 Tue, 06 Jan 2026 07:38:59 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7fad882asm20975265e9.1.2026.01.06.07.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 07:38:59 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v2 5/7] doc: add flow parser library maintainers
Date: Tue,  6 Jan 2026 16:38:35 +0100
Message-ID: <20260106153838.398033-6-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260106153838.398033-1-sismis@dyna-nic.com>
References: <20260106153838.398033-1-sismis@dyna-nic.com>
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

Add maintainer entries for the new flow parser library.
Update .mailmap with new contributor email.

Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
---
 .mailmap    | 2 +-
 MAINTAINERS | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 2f089326ff..d838ffb4db 100644
--- a/.mailmap
+++ b/.mailmap
@@ -933,7 +933,7 @@ Luca Boccassi <luca.boccassi@microsoft.com> <lboccass@brocade.com>
 Luca Boccassi <luca.boccassi@microsoft.com> <luca.boccassi@intl.att.com>
 Luca Vizzarro <luca.vizzarro@arm.com>
 Luka Jankovic <luka.jankovic@ericsson.com>
-Lukas Sismis <sismis@cesnet.cz>
+Lukas Sismis <sismis@dyna-nic.com> <sismis@cesnet.cz>
 Lukasz Bartosik <lbartosik@marvell.com>
 Lukasz Cieplicki <lukaszx.cieplicki@intel.com>
 Lukasz Czapnik <lukasz.czapnik@intel.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index d7d8dbdb25..580a499f7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -447,6 +447,9 @@ T: git://dpdk.org/next/dpdk-next-net
 F: app/test-pmd/cmdline_flow.c
 F: doc/guides/prog_guide/ethdev/flow_offload.rst
 F: lib/ethdev/rte_flow*
+F: lib/flow_parser/
+F: app/test-pmd/flow_parser.c
+F: doc/guides/prog_guide/flow_parser_lib.rst
 
 Traffic Management API
 M: Cristian Dumitrescu <cristian.dumitrescu@intel.com>
-- 
2.43.7

