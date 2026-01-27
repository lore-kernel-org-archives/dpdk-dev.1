Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B72D2FEC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 17:21:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11C9240EA5;
	Tue, 27 Jan 2026 18:21:48 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 9278240E6E
 for <dev@dpdk.org>; Tue, 27 Jan 2026 18:21:42 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so46422595e9.0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 09:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769534502;
 x=1770139302; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=oki88B243qnbXDfn7OqGTBRURw5Su1xW1YgDfMbvsFDlfycHvDg5dF+vEzinh/7JUX
 E0p/M6jaKwWNsF0JWNHmjTGNKvGaat4cGbnuF2aV3A4N6WsiiHdkqMlTkrfapLTmhEds
 aQphsuqnPPtVNC1a8dGnJ9iThTKlOHR6Hy6BZuePfMRU1NMoKrIi8oZ6pjM/3oKBDLRh
 lLDfJi2s9h9i16OLwZSYG7AtXPQnamIO8NxH2M8uxllt4VtJi8uO0Qm66emb49AIHDFA
 2dYQ4uK3Cy8sQAINMrK5d/th+1NohOMgbONXM2IEQEzvF9uA387i+95t/I3PQR4v9w5G
 cubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769534502; x=1770139302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=MItAIz7btXC1EwqHkaxgPgmXrftF/ZDxpMGzyGwKh+8T0ey3sSwADs0nu4cCa/ik3F
 wwPK2rt9c6/kUU1/yrdDpLrqcRbfpx5gVZbBKleJgauIQ9855hzUrBFYMWMnuQkLqonn
 X+eomangPf80LwH/AD0Il6ihOtBjaM5lZ3Xt84M4IuELwUYC+jde0goy/09C2gA7723n
 BIv4scaAFnB/VqfIlJDHQpGsNgiKQF3jag5xEsxR+f3KrY8bQt2EXwb8cqqBqzJjV09Q
 4PNtuBTR6MRXL8aOpDa6WIdg6rUyRFHm39qMM78XO012j1AXmEhdWkJABSruVn3CgK2h
 ODKA==
X-Gm-Message-State: AOJu0YweI6mSfBzyYCPkvQIU3dN11Afi9NFtHC01N/yK1SWva0HErAGk
 3YLDqXk9WJ5CZF6vVI99XB1VoVtfVER5he2NI5WfW28XH0AZSqHMFr6KUHd4rZia0v8sktyEx3/
 RAaV2
X-Gm-Gg: AZuq6aKbTAu41yBlNYYOHNC7fGlhQvOuFD/wyXJisbttC7EPhPkFXHZMO9iaXaWgQES
 y0aQFCFp2WCkrXOxuM2kPCnlPA+9BJbXx7tnnLSSSjoaGSs0XSzS0ZWKT/ddt5P43+kABoaYxLO
 jcnViaCLMQSyUK7q41ACEDXIlHIAAOooEHaDJR9iw2ld3bBBvOUoxX4yX8MGvgt8Dxr12WGxMEZ
 fZrnXh3vuQlBR+mH7O2NSx3PpkUQaSJxBafxo05JXiw7hP0pleKJw1LMQJgbgrctt4gyCF41I8s
 Ux5jM/+w8pSJ6uFE1wjoH8DrQTC9ox8E5D69MswTrCvFErbjw23TAsr9U8tvIFWngebtORVAbts
 NpuQ6+mzQ2d6djP+kSW1omAkF7MYLFFoeMi4Z813g6KDbAOr4QYGRKLV5IAWhVisScm9XUXJdK4
 D6dQOTnb6fItMsmb+UiY5XmwkdWlLy0Ymb7s3mvX4kqYyGPmHpIQ==
X-Received: by 2002:a05:600c:34c4:b0:480:1c85:88bf with SMTP id
 5b1f17b1804b1-48069c86cedmr29521105e9.27.1769534502167; 
 Tue, 27 Jan 2026 09:21:42 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm4769395e9.12.2026.01.27.09.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 09:21:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 02/14] doc: update features for PCAP PMD
Date: Tue, 27 Jan 2026 09:18:43 -0800
Message-ID: <20260127172128.124473-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127172128.124473-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260127172128.124473-1-stephen@networkplumber.org>
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

The PCAP PMD supports more features that were not flagged
in the feature matrix.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/pcap.ini | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index 7fd22b190e..b0dac3cca7 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -4,8 +4,15 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Link status          = Y
+Queue start/stop     = Y
+Scattered Rx         = Y
+Timestamp offload    = Y
 Basic stats          = Y
+Stats per queue      = Y
 Multiprocess aware   = Y
+FreeBSD              = Y
+Linux                = Y
 ARMv7                = Y
 ARMv8                = Y
 Power8               = Y
-- 
2.51.0

