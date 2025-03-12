Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7140AC28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 23:43:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 050AB40E0C;
	Thu, 13 Mar 2025 00:43:18 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id D2D84402BB
 for <dev@dpdk.org>; Thu, 13 Mar 2025 00:43:16 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2ff80290e44so980017a91.0
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741822996;
 x=1742427796; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F/9DdgWd0/L3v8IE8w8XpNFsZm1Rbzt+n0B28QiAveo=;
 b=MNeqZxkRl10erQigSXPC9+pmK5DC92uNzPVlC4G3TDSM2dYtR36nf7JOl2at8JFtiL
 o10Ez5BUNCuh3H1ru4FPqwm7HAbt+0v5yEwSfd9Up4N1nKe6OFWiq13iFtqahRs4KPwT
 p96dBRRIakpLnsIgePrM/Ybipt2yA+H1N5muxuEmC7T8lpnxQoVJAltcPTw/VDS/mohs
 mTotPJto3cDEq1x/QCu+hIMhLzUZKG+364AVkaJAcjPHDvaIRPmTT+uMvp4vQ4ToMpZ0
 3NTt1J2FyY7QYsGOiqj6hEhyAmwjyy0BgzUNG4T3tXLuIqXjaUNyV0SQ/AGoxuYQVOjN
 QEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741822996; x=1742427796;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F/9DdgWd0/L3v8IE8w8XpNFsZm1Rbzt+n0B28QiAveo=;
 b=Sm6P6ueaMOAWIw8QpYm47hNtxbBFfwf0iFpVSa7i/GEWZ5Phr1W5kdkpR2FcEmbJOS
 OoP6sQ7XKrR04srlibKHO5GiFoXu1KRMiSrwul3IWtIqTbfCAtxLbuW86s9AwVBUshk/
 ZIkrqptQFBfky4jN02n62Rm7eIRhHQASxZ1jKF7BkKMDr/ngXMXFtGQzh/NOVRK2ViVO
 Nghogh7CVI2i+ua1a2zeG8UXemO4rIxXjEExCbt4TP9C0vUeOhbqN2z+Cx9Xg5QajVJY
 bnQXrb6BkX2cJt7RREvM+tIiM/zfVKPb3su6mKNPSbLiJmCxeaRScPuzoXR4gUU4fDtJ
 WxOw==
X-Gm-Message-State: AOJu0YyA++Kbtprk3i9wmogPhg41x2jGyDjXm+xNpYr1kdTggOWRJUWg
 bSkpSvT4skxqLKd1QAmDGzttxe9NxyzJzaGEl1lTPY8GWrtKqeXY6+11jH+EQNX0NUQ8rteXpjt
 Q
X-Gm-Gg: ASbGncug4YZggVXgbDwCZrDCsaAMci56XRF+p1daiS72Nu9jkqaVTicNLyoXnVvcg9Q
 H7yF2GVaMkM37a9HjIDXSaFtHa683+YrnrzoB6+kLZR8x/GODX4YBrXjucVldh7Bs4jo/S6kqw7
 G+e3nS/nYGroLJBEi/T9eNJ5Wcdh52aw5TXBRve0q/sL+4zINsrxkLPmJGHQjV9pnwOlgGzB6rO
 HiZPFPLMg6584fM9nc2RjH17m99D6gxfdzmmKYcL9kGDFY0+eCxmKOpfX2g4V6Dm69M+PHXCfmV
 zvt7hQfDEguRKgzPKeke/MioDDe6NykhMU9Hz1wDqku2ZTtjcse8Ygz4syhhWFeJBiF4vqk3neX
 hPcPQJbgAAKHsKcwOhAZf/A==
X-Google-Smtp-Source: AGHT+IFlZYIFWIjW2dr+gpnXzk6PQuh28p4pg6jqcwImaiCIzv/VY4bckYg7e1dOtrCGQTdbRqv8Uw==
X-Received: by 2002:a17:90b:3911:b0:2fe:b907:562f with SMTP id
 98e67ed59e1d1-2ff7ce94b2amr37800842a91.14.1741822995849; 
 Wed, 12 Mar 2025 16:43:15 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301182187d8sm2503850a91.10.2025.03.12.16.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 16:43:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH] net/tap: fix documentation about number of queues
Date: Wed, 12 Mar 2025 16:43:05 -0700
Message-ID: <20250312234305.229926-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

The limit of 8 queues when using a secondary process was removed,
but documentation was not changed.

Fixes: 6a2e47a3e26a ("net/tap: increase maximum allowable queues")
Cc: stable@dpdk.org
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/tap.rst | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/doc/guides/nics/tap.rst b/doc/guides/nics/tap.rst
index f01663c700..b37f899ec3 100644
--- a/doc/guides/nics/tap.rst
+++ b/doc/guides/nics/tap.rst
@@ -166,10 +166,8 @@ The port attached in a secondary process will give access to the
 statistics and the queues.
 Therefore it can be used for monitoring or Rx/Tx processing.
 
-The IPC synchronization of Rx/Tx queues is currently limited:
-
-  - Maximum 8 queues shared
-  - Synchronized on probing, but not on later port update
+The IPC synchronization of Rx/Tx queues is done when when
+port is probed.
 
 
 RSS specifics
-- 
2.47.2

