Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A60BD1950F
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 18:08:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47A2F402E8;
	Mon, 26 Jan 2026 19:08:20 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 7DCA4402DB
 for <dev@dpdk.org>; Mon, 26 Jan 2026 19:08:15 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-42fed090e5fso2931948f8f.1
 for <dev@dpdk.org>; Mon, 26 Jan 2026 10:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769450895;
 x=1770055695; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=QQqOZc7Jvwy277fiqOPZytFdbkI38s4DcsUL7XDJ41u2KJAO4OBClaSgXrQ9/CJPpi
 5Q9E5IgkGY2RUvH44By0PmCYwDvccioPEvBHqjBkzeeRpWeNLSuxCPjQozsDOHZIfgd8
 Pks0j6A2mvo2YKVxK975o6xvv2Ox4j65d2hTAOJlZs613SSbdWe1lurTD+ArF0CX9Ag9
 XvpJhZ3lt6a02jgdFM4ptH3KLopG5aepGNCWg9oulbaDLrfohbvNDsRfSDnEqwSqVEqe
 1TEsFtotMn1gbxt4Aq2iC9lQuhV6G+Ysu4sh1j7ZhJaJPtrewAPI10VlHc+0QGItvtR2
 aNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769450895; x=1770055695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=m3Kvj6zg/0clYy/ZH+JVs6MVT9bHGJb8GLgne29uzJvT4kKBeiy3oVFE4isXOr5uFh
 vlRfrfqA87FPB1UnmLFmDeu/7fTHu+xISd9y5UZHRLAY8g+C37o73FgXYSY0P18XMX8S
 JO/2WWjU4KKxeqUDZmKAA/F8BtMR3Gcwkq7GaxB+Z6zoWk1qRRBndIIefk9Qs/z8DQIj
 /InrJYiWncUGFxyOyldAtOYGd0EblDpoIoCxsaju21y9q7FKWsV8C9lKM1Uqu+YOGqbH
 xUDn77LH2g5IqBXejab4vlxylVwq12zg5/b5tkQl9kAZZcPxHQsxMfWjf0qA+wRT0HO3
 nyEQ==
X-Gm-Message-State: AOJu0YyQaGOuLA2pB5XjBxfPGTMgUke2+cJ4wWOcoIB6riE8h58iLrLR
 LdeWk+Q07QXd8y4a/YifgEQNwylOHaW6l4VrSVV4JaDVQ4ZhxDLcAHMTGWIueeTn/XYX9ZzI7rf
 cuHEB
X-Gm-Gg: AZuq6aID/WNVcLzzUQrmN2JjRaXrPyPgRIg1oueku2ihmTAuwae6msfucmb4sa/tsGm
 6v0Q48UE+fAxvMVhiSK/Y4htZ/SrS30FwRmO/WiSBT+bA9vpeEeCPAbls8REK7emSjtuOxeI/eC
 3ox37KfQYkYr0Vs83Al1/H3mM1ttzxg+qX8DSX8A+IVwCU0xNXoj/DmFNRH6G69R4s1GEhZ6kwG
 vUPaFoBO4gOfshZLsOjlT3zwGb5YJqytFL17g5JkRd+3rnx4fdk4uXUFW2xqH6cQnMY7x/xa0Pw
 M7+MiPlbdDvNe0w+vLZgOTLnnA9dqTbfIcUQlk9XzlK/OCktYDPDyAqmyr5t5sk6rVbdjvyoboK
 3AeA3J0/+mImbEK15iICyM3vlJnbculsYrVLI+hH2yZSs4Am4Idu4knp88i7EpUPGyWvO+z4/NE
 UtrmmUGiiJgk8pKwW9zXegdlwGYwQbK8PJ3of0hytBg6CmklSSUQ==
X-Received: by 2002:a5d:64e8:0:b0:435:95dc:b8ca with SMTP id
 ffacd0b85a97d-435ca1addbcmr8770639f8f.40.1769450895153; 
 Mon, 26 Jan 2026 10:08:15 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02c91sm31845864f8f.9.2026.01.26.10.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 10:08:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 02/13] doc: update features for PCAP PMD
Date: Mon, 26 Jan 2026 10:06:39 -0800
Message-ID: <20260126180807.100891-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126180807.100891-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260126180807.100891-1-stephen@networkplumber.org>
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

