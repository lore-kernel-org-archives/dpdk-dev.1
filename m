Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D177EEA84E
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 17:03:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87B8B4064F;
	Fri, 13 Feb 2026 18:03:44 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 187B3402E7
 for <dev@dpdk.org>; Fri, 13 Feb 2026 18:03:42 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4833115090dso10381015e9.3
 for <dev@dpdk.org>; Fri, 13 Feb 2026 09:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771002222;
 x=1771607022; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=uQKLHcKqgFQTga3i/9essllFZ5Eq04YgaMOaUPqkYPzM/lHFzH54xOOQim4dQbjDi1
 kV44gDXvv9cmyX4jll9MK/dKllyCDuYOKxFAJfo6j/W1U/8Dsbdo+3p3fsDHNIsj6zcx
 U/xTQvWtV5bkChTScoJ/eh1ERtw+7eRIxZRitKLCl/5iLaPkh5aZHEc9awxY9qLrq9G+
 KVZ3vbQuBYvysy9GYPIPAJ5Omj7N5oeBMxe89jrJ1WmWPOLlGSrTwbTzVypsRw5mPrdy
 CwwqLLwM6DhbTYVxCc3WN3EsvQEusOq23rEPyErsv8Wi4cFwG6PCHVow8Ix/gJd+d6ok
 ciXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771002222; x=1771607022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=gztD5bXkIOt9ay8gylhBOV5t9hk/+I+TTAmy6ZudK3gx5+qIj+FeSvBF0IKqPdaXoM
 jUgp2O2YO5tY1gnJ06GN9PfJUFGomjpAcwFpzyDn0fi5B+N/rdSl55i29575KhhTx53S
 W0srt2vmbu7Bq0eSJ357IsEMlL5VuO+kBxqSx/5bCpLEM/+ifU6MNoCg7Wzj8rxPoQzQ
 Rbheqh8kuAIU3Iy+uRPnIPtdUpQQB0YmdjTwqN8EyANAtqVGgJsa2uMXJL/YDuPzr9F5
 E8yv3IcOO+Hm27FU6o1NjZXRWtpCZ4Suf+X1wtF+AW6LmePH/eWT+/drh4AqU7SGbnrO
 GDxQ==
X-Gm-Message-State: AOJu0Yyatpan3aQRSK+IxTFkpVIsi+lO37n2n9jGfVREW+N33rJwasbL
 bXtTNHKba3VMFBRdVkgOEmtvt7Vr98yS1v1k2sJXtt3yVYH2NNT0Vw+EIURrcv0uvaXupLQkgkQ
 jbKSB
X-Gm-Gg: AZuq6aJW3jYVn1EJPs2y30Nu+6J/d53vBRVN9Xr+7NC5CPKNHLRENPoU1yZAk91s/7D
 bshJC1o9ZgLgSv7kjhGIi50wNokpbvTMs/UePRHqo+/ZR39et46rOo7QBBdyyliy/8bwWXukzsJ
 LaSI5Aua9jxhqkgGT2k1Dh8jDf3PFb+PZuPNxO0OkA33RLliuHR4E4bMI6WeN54YVDQNUtHNFFt
 EggDGrXfQLCuacuB1C97GVuI0g2xHe6Nbfbh5yyjToto9nMF162dtUbWBQ2RFQylIMOa/5UXslX
 dR5DQsQD6W/N7PHnAOUXGwC+IjMvQc9AX6r+wc9gYb7OBOF6z//Tr8Plz6seHNCXaPTif2ozUwU
 YPUe1gqSuBMmgpBCxGjbSl/EXDQPCwWWTcP6ufW6dEwmO+F2ktkkYtqTYmQliCgBeJSonrRCs+e
 5Il3HWV5VYqDM3872AhOyIPjnJBbYL+BnZXg9Jt/K5M8MsvJF9C0REtireidzZ5Q==
X-Received: by 2002:a05:600c:198e:b0:480:20f1:7aa6 with SMTP id
 5b1f17b1804b1-48373a5d54fmr44854385e9.21.1771002221640; 
 Fri, 13 Feb 2026 09:03:41 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483740be167sm40963035e9.15.2026.02.13.09.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 09:03:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v15 02/18] doc: update features for PCAP PMD
Date: Fri, 13 Feb 2026 09:01:25 -0800
Message-ID: <20260213170333.40089-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213170333.40089-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260213170333.40089-1-stephen@networkplumber.org>
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

