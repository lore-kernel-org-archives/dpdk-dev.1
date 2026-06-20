Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B809DCD98E4
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 16:40:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65BDD4025A;
	Sat, 20 Jun 2026 18:40:07 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id ECCCB40151
 for <dev@dpdk.org>; Sat, 20 Jun 2026 18:40:05 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-30bd7f4fdffso2802478eec.1
 for <dev@dpdk.org>; Sat, 20 Jun 2026 09:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781973604;
 x=1782578404; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JLxu0RcFakE/WQLWRRt9hhbXShf60u/Pm2Mc74Pqo60=;
 b=DD4IM8d0Nzx2cqMeXd5J34qMbUdTNQ7buy2iCELsxXOfGGKX2va3YwsjCcHHGqzyjT
 UTDdrlp2lxp747h0bDIZfgfnT1OfjeKxWNkj7Plj6yLy5PXKIm7rVya4b4GBQ1JmnL0K
 n5JN+SYJhCYH5wJajMzQRRp2gMUdYuiCEvXGW/p76zuFQHqlyeYU5ZpXl9mkpwmswU96
 1UNXNlZOWRzboxU1rU51kajb1I8jGdpIQJjWwUZRu5U+ScBn1VostYpYSiOya9J/XmOp
 T1DXVO8T9FbkMj5TwDxew1au5D2loJlqGMTVt0m4GWbIgqvEPPXPpgC/GKailfngcMle
 S95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781973604; x=1782578404;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JLxu0RcFakE/WQLWRRt9hhbXShf60u/Pm2Mc74Pqo60=;
 b=EkwINdjXahMQS8Afqi5ra7ut6DzuzEv2NXw77DcbtxSxYitfBnJAQagitOa++PJfWm
 B9xSCwYf23vywTgRkqFXswhVSQa9PFIUX67+3BM2NBpv2zkvcvNPacieEscLGumFiOwv
 Qu67lZOWRi4w6T7I/hVFPIjijgXvZ6A3Pz0GYWXVLbOL1rjwvb6aqZu4n42U63E3OmO8
 b4+S0TZiJQxv/VtbVwKSdgdDiKb2hoIG680BUuU/dkwcxjJjij+19HzsPS8CHhLdlVsm
 8sLFYbyPGeWefW3kB42n8QyLQqbGZetEKXc5vYfVUKqY9EV8VbXPsIpCFEKE6AlrMl2i
 D8iA==
X-Gm-Message-State: AOJu0YyHl7Tih6RdX2Vr2ps9pfjwt3jEwhFXfHFJuLde5o1wCyeMhGOm
 Gqo6X+i0IbcUgixZISgyKB1E3/1TrJR1gm+ONZiuTHAfb62aH6jc/dICwwzJnIIh6cbOJsnK/NO
 CJin3
X-Gm-Gg: AfdE7cmJIy+OYPWXcaYNfTyPAC73570r95JrZJbDfEtokg6FgvS0BEzUrRZF54ZJut/
 UMJ4radVfQ2iB9mC9hdmLvonnEoPTseyAzSOZBeiVITjXEbmQlUvJPV+RB7FUsJCCq6axYxXnr1
 v0O2yg6FyPhz9fM2g69m5FtwDHY8G476+AegQNtTh1+0ZCMaWK38QF99wa5QU8WRag+3XlCjxlS
 jThDLp3trKzgxrHQ4UbtWkaxCgmuv2sSb7aW/VcExIwK1jsclz+bIk7/m1uQq/i1GFtk6HEd2l6
 BIISy0q11ui9bTuOvZ8V9VTTYkzq4OU4psKYnQcannDyYNdE3XsxSs0huyqfFZXQdGq5FKNagPt
 zkR/vCSM3YkN09L6rZzcdA4V8ppRWc9Spz3Sfr8/nx2zu6PDfDlfcNNH85iITbBkb1edA8WbZyh
 EoxVVotOxOP6H3z5DEZE6qo6nCRYQH/QG3pqQX0mzDvISeZxUyT20=
X-Received: by 2002:a05:7301:618c:10b0:30c:2d3d:7838 with SMTP id
 5a478bee46e88-30c2d3d99c1mr744364eec.31.1781973604506; 
 Sat, 20 Jun 2026 09:40:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba5c25csm4393102eec.8.2026.06.20.09.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 09:40:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: shaibran@amazon.com, evgenys@amazon.com, amitbern@amazon.com,
 atrwajee@amazon.com, Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] MAINTAINERS: update for ena
Date: Sat, 20 Jun 2026 09:40:01 -0700
Message-ID: <20260620164001.129129-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Email to Ron Beider <rbeider@amazon.com> bounced.
I assume he is no longer available and other listed maintainers
for ena driver will be enough.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a68a19b32..700f607db0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -691,7 +691,6 @@ F: doc/guides/nics/features/af_xdp.ini
 Amazon ENA
 M: Shai Brandes <shaibran@amazon.com>
 M: Evgeny Schemeilin <evgenys@amazon.com>
-M: Ron Beider <rbeider@amazon.com>
 M: Amit Bernstein <amitbern@amazon.com>
 M: Wajeeh Atrash <atrwajee@amazon.com>
 F: drivers/net/ena/
-- 
2.53.0

