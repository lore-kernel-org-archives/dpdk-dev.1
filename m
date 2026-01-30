Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58540D73EAF
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 01:14:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F65A40608;
	Fri, 30 Jan 2026 02:13:57 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 339A3402E2
 for <dev@dpdk.org>; Fri, 30 Jan 2026 02:13:53 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-430f2ee2f00so974020f8f.3
 for <dev@dpdk.org>; Thu, 29 Jan 2026 17:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769735633;
 x=1770340433; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=eB5vmYs5I2zPWWtM8dc3eMthHWKte3b8ebvWHo/sOyHI9TA2RmTCf3u3ha/ePMnrI0
 Ce8Lk2I/xwLb/Fs5bEJx5POnNjWeYkFecITD4Zkqh5ubRfcjJjjyZGtZgLGXI3YcYKWb
 Y7rkzlQnP0kfvjjvUA04NaegKWtCa8f7oYRmE2XiCZ9rHwQSpiXyQKDxItsH8ewySAVd
 wsgqNymY+E6UFlQQ6vLrAh2nFBAWw2vsb6g3yXNVkEpUhidf/3nM9xmSt2dCQIJqetAN
 HaIwRt5hfC2hnnudo8sp1UyeeKYVXG7wfgefC7r6y2uzTFcO3vlLP8Eo2Tgmyx9nbA+F
 1HIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769735633; x=1770340433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=sQxxn9RHuIXuf5Eg9rSO8HTZ4WAQouzdcKiugAurQgoj+q2v5PMdRV+hKylJ2q9fa/
 y34QYTbkYbvOg2EMF1Kfg/0J9DzJRlmgDbLu0sqoXvHMht59aT4eIemNGgo7Af9+Tg6Z
 OviyP3Mj5jk2O8MZ1rSK5aaWeNTXIrY/b6VWGA4bPre9dihG4RW2RNxBhbnb0sK6Dklk
 8h9BP9Pv99LouKBWBz+WpjGs9EV9Ek/MZU6me7X2Wbxssjsw6ZirIg11//qAkqgiTNPF
 +45wDQabwFNrqT51FUwqKgCLxrFDtFrAM8Xn60f9Y1zdmt8DJttRMy3G4jE/PbXU53IG
 fSZg==
X-Gm-Message-State: AOJu0YzBaIXxBb7aGSDHrJ1gqEDwltLbHj2xC1zFCSkGDVlvLmiUD8Pw
 wvQabGhUThhjF751AutG/jxB63Pky/2Kbr/SL7mWbUY9SFcsPvjDFaAgwzAwT0N8a6ajoNmG3uP
 +qTVA
X-Gm-Gg: AZuq6aJNsgQNXvHD8clgNFgFJjIYcusVDL0C96FflbI6VdVFDFTNaaq+L7i9JEQgmxR
 THW23Qk7Huvrk0wTgS/UqpJA5uAphub0j2DmmWMrLUm3MPI+7VHfIdmmAjnZ00IhKMi1/KrgBgV
 nmOzYhh5tqqQ6D0x71xrPmxp+UeJ7m59taFTaAcpHA7hX84XzbADTBIxtw5jWNy+lK6e9cR3p4n
 9GEAxz75UrThpQ9+35iwlskbut2I3sYmXLXSE3bFXpgU73dzTQhXdBgftQU0nLDWe9FWc4Qng9m
 0hzXU8Hb0CCUYOXlwKbZTiwGe/OJLq88MEIfNb/SYOBO7Al0uqrRtfFBqj2SSeJiLr3Kxu9X2bs
 nU7SnVMiLSk5WYC5eot7lun1EkDQnmRLZNHhB0v1ppC0f12sFhdwCIHd6JRPchCZRuRhW2RkcjT
 UtscKGvsUpPxgQ5BA9zELOUZcb1YNAqsvruQ3v9cykxVb7sod5TQ==
X-Received: by 2002:a05:600c:3e1b:b0:480:32da:f33e with SMTP id
 5b1f17b1804b1-482db47ce18mr12509275e9.17.1769735632794; 
 Thu, 29 Jan 2026 17:13:52 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e1d0f9sm2934825e9.18.2026.01.29.17.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 17:13:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 02/19] doc: update features for PCAP PMD
Date: Thu, 29 Jan 2026 17:12:18 -0800
Message-ID: <20260130011344.204233-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130011344.204233-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130011344.204233-1-stephen@networkplumber.org>
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

