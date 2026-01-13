Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F769D2F32D
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 19:25:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0B6E402ED;
	Tue, 13 Jan 2026 20:25:40 +0100 (CET)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51]) by mails.dpdk.org (Postfix) with ESMTP id DD9F4402D6
 for <dev@dpdk.org>; Tue, 13 Jan 2026 20:25:38 +0100 (CET)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b8718187eb6so370638666b.2
 for <dev@dpdk.org>; Tue, 13 Jan 2026 11:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768332338;
 x=1768937138; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u57LCF6gNL4H81w9AAJqyOS7XfOlwxvNtXdCoUMOqn0=;
 b=UFaQfHwtlKa792w8Bw4xA02b5sgqXfwXZPqvK4uWEwAXP/3rdBL4va66kmcY0hb/nb
 5rDbOOIOgFVIofl19t+EHr376YB13nsO1YyXfyOt8BShXFnovvdkNfVFSYNFCfc+NQfx
 Z4UBmLr4rF2CZSvmvJeSkks5v4YUqWvUcmu9mljOmKWQ9Y+HQHgCfIdqN+/GGvTgLcXS
 thbevW+zpBCb7H0gOGTBAm2WlX5pK3JEMDMKV3vrCy6wCmcEgLUdvJudMwryF6oj1e8x
 H85BQWHZRimMTOx1RMYGVCYdbyVKU614OyvZyg8lZ5p83pN4dEzQVuDmss5uElAb/hlZ
 0a6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768332338; x=1768937138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u57LCF6gNL4H81w9AAJqyOS7XfOlwxvNtXdCoUMOqn0=;
 b=sZo/KABp2YOehmmxL/cpDVJ+HsRc3UyqF5Ki7dKyqOXRTghN5oBQvzmInKeX/ePb+o
 MAGOHyESz6ItNLM5g7IVVXEDoG8/3XKHRlPIRLrh6XUf98vaaIhrxaAu8/kc7WjPVM/x
 3A/nmho3nXOhD6b8GIle8siq4WA8SI5Kq3Euumsg4QmVN/BIKtY5DcSGZAWweLSK9m0T
 k4+EihN9oHQHAAw8z0bi/zp74OptmEUKuUFMUNtwdt8A/W9u536G2CIh5mvO/5TJZwCA
 5/bpFsKJLUlWR785IkgW1UCl5jmj0SoCgX8VAwLbxDnUd3Ko7J5DjKTuffwvwfSPZnbF
 KlbQ==
X-Gm-Message-State: AOJu0YxAFZgQUnmtwRH+grNLr8PmMCxPnW5BYzC3QC4xGZksE3mAgnZd
 zo86t2DRPNVthCv92NHZIB82/S/nTOx3KFE1+Y4MGYA5dniD89jA0W29YVdMv6doUKF72vyTy3L
 5mcS8
X-Gm-Gg: AY/fxX7Ol5TvnEdGOqNYEXJ28XI/xu8x0czvhWMdYGaUwkTiYkVY+TY2i2mX+LDoZXD
 cGnGMb8kH7npiMPWXAZjqeIhdUk04R4/7S5BmJKpZWr0nfm+t6V3rTAeNgvOg8U8In/2V+iWJ4J
 EfDDXHzev42pgi+KUaWFIaip5xhf2jN9qBn0/xNy7lVCQuRPmrn4SiBl1t5quTa0A9frE5i03PA
 TrcOxOuZ0ArcrJR3VT3UxFqgGrhg3rFAH8EdKURTRTE4DZOkWQdiQm8i8QlZJqV32oHHPUw8vH1
 6rJq3/j5ygv1K1EuDyeYbvrtn9lnNZE6SX49DNIDa2uvRTDhkXm5SvC6sD+uJQN/imvrFtoqGL9
 fC6wRCnYhDfMzAu4rHjs92BzhoLPoar2v5kkm+wdj5Ak7Pg6sYLfRdJb7ZHukrHYaj4XXBjR18p
 jHYe8T4xGerOn4U+hQ/9e0AeqY2ybtbU+9lCxPQPkFmJ7p39pZuA==
X-Received: by 2002:a17:907:d11:b0:b80:3738:2f11 with SMTP id
 a640c23a62f3a-b8760fe0630mr17382066b.13.1768332338305; 
 Tue, 13 Jan 2026 11:25:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b22c3absm20945603a12.0.2026.01.13.11.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 11:25:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 1/9] doc: update features for PCAP PMD
Date: Tue, 13 Jan 2026 11:23:33 -0800
Message-ID: <20260113192530.116470-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113192530.116470-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260113192530.116470-1-stephen@networkplumber.org>
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
index 7fd22b190e..060b2f4df5 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -4,8 +4,15 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Link status          = Y
+Queue start/stop     = Y
+Scattered Rx         = Y
+Rx Timestamp         = Y
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

