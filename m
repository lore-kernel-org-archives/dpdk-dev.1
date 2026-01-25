Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1729E63CA4
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Jan 2026 19:23:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F36B402C3;
	Sun, 25 Jan 2026 20:23:20 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id E37B440297
 for <dev@dpdk.org>; Sun, 25 Jan 2026 20:23:15 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-47f3b7ef761so27613345e9.0
 for <dev@dpdk.org>; Sun, 25 Jan 2026 11:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769368995;
 x=1769973795; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=SCCCuuuKR4nxMEBKE4lKRk1CHh2lrfLlxK8nYuGz4+Q7O58KcLMt9PbPvLo9F1rvF0
 YT189rMby57wQOYolTuRAW6HLA6em6PX4TSthkh1HVO88Yi5VnoWWqbHNwLxz8ZasjV7
 awygkEjFh5Xnnps3eY9XBGqGmFWYQz8JBOYui+mUiqGzkxjlbTvNqQugqUqVwGqHqn0z
 UWrO4op8Ouc13CGx6IjXlXSxV26KPX99FKATlDO1tmO10C0+f6012H8RzyQYjxDalD03
 +4XVZJaXLBS39DIFVT+4pF9iQQSY66D/QG86f/SAcRHz6TLPAsK9jywUlxbd6zoCwGfQ
 o8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769368995; x=1769973795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=NDgt3PjZQqeco9Ga4NTgioVGgWFmnUZ85XnYza/bhE9JGCT3FbqIgaZjrpLwmZOYgy
 5gubNb3MPGXrbpav1RNgBBDEjSVl552cexuxXnHjaVj0AGf//ws+BcJ0Y5wb8PmgJ9Su
 Gws/90iwybYN1SPpDM4tpSXHnn2pEjvadhfIGapittQ4hJFkYtQ/a+0a3yUsaaA/89n3
 n5Zp1IazZ91JHkgmqFQiBU5JqeKiwFwiFYCxLSqIFwFPXlt0ymFYkMa6XvSLWu+d2Ik2
 cMnnc8QhzddVOJnPwv8clmaRmDL+m5I26WuqMJXcYZQDqx0GLgdc/lXlKSJa+ZJik5UB
 NNgg==
X-Gm-Message-State: AOJu0Yww/cqzKGDA1P1bIxH/gYIg+fomjapDxI7Q1QPrKkWNUE6VoRWv
 3lfcEbMwideT2ij2St/3tyYNYilfHrx0r/JJOx6K6gk2lpwPWYgIxo6Mmlhjb3VkhVmCwGBNH0i
 bH5F7
X-Gm-Gg: AZuq6aLg8u7KMMlFjs364V6D6tVJjpG4VbMlSb6WLLh2WOlcouigrEipaRVY2oGaVyd
 Ce0WC2UqhDPohIFoOUb5yDScns5UmI/5kp9iBOeaOflvziHE1YbwHLd11kRMKQCk3070HEoSh3h
 PWYy9ntWoHKjS39SBea0QUjCTwJdgjWsG8vK8q7vAdwH9n+dVhaJjgKoNtOo70bUbUq/lWLBgMf
 VqHVs+JdYuZl29NVBERoz9fSu2CFWzW4sGdukvXCi4jw1gx2d4CmVmHIAOmaflpBbLUnp4AcJnj
 q0jqj8twYow0vuBr56eHoKzeZLS/f45WyNYw00DpKWQ6qqpKyHYlUVVG3PX5FQm7kGB1LleKB7h
 n3PX1U7r6L6mYvr8OYzmfOAWiOafSCgZGANcRfCXAeQSFeIalFEFHcBXwdZ8PEcVzip5osa8V+n
 F7lajLFSOixk7JdXo8yFG9imcs9UT4JKPSpTg9Am3m3XjpyT6ptQ==
X-Received: by 2002:a05:600c:a08e:b0:477:73cc:82c2 with SMTP id
 5b1f17b1804b1-4805ce48c99mr39989925e9.9.1769368995212; 
 Sun, 25 Jan 2026 11:23:15 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b4d8sm22854362f8f.38.2026.01.25.11.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 11:23:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 02/13] doc: update features for PCAP PMD
Date: Sun, 25 Jan 2026 11:20:00 -0800
Message-ID: <20260125192248.497563-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125192248.497563-2-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260125192248.497563-2-stephen@networkplumber.org>
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

