Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD17AE83820
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 18:14:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDA0540430;
	Mon, 16 Feb 2026 19:14:17 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id D1B3240648
 for <dev@dpdk.org>; Mon, 16 Feb 2026 19:14:14 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43767807cf3so2582983f8f.1
 for <dev@dpdk.org>; Mon, 16 Feb 2026 10:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771265654;
 x=1771870454; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=WNDDiURWbENHTFbiZox42BGPt+HPRvy9FZUm4DlHu4tfQ00e1RzqC7glKun2aT1NEe
 jJvj8CJNeSMpcYMPgvCsrFeXFker18TH9LuhmQ371gbi2xgzQ4HXc7ot8gZL9SIb3jl2
 X2/2/MKtUaaKZ4HERdAWP7HQHpGCUpDYzBNgq/ywxmYIO7Jj/vjEr8QfQr1dT58cSVlV
 Iq0o7jVNbCMmPHh+ClAkEvYRkWNrJxynqMUdVPYLzfCTYIymG7/u/AVX3kJ2PoyXMx/J
 82cUEL5cugygDmRE30UbvCgBhczogf0crkmAUDyyPJ3gsUJrZJBT1fUALAmue1w1MsRS
 /7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771265654; x=1771870454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=WJKqyN/I3yeBaNMHQS5tJ6FJC3ExkBebvpS2fnPrgRhp8RhzCLViiVtLaXPE/Hisuf
 ODV1vm+wlS70PKN3G+tlDtmE+bglOopVBvrjqPwD3G/tcpjPX2Ayb3ufoKCcwVZRel/6
 Ypb6T2rS7PS60pnVtpXtw32PkCQw1aeT4i9QFFNFsV9ElP0XZ++L4YC4oZt9hPzdkC0u
 NQD8BEOStwJ7PMfk8G7YHh9l+6EizpMuaDc4EgvklX26FX29Wy4fUTsUzdoWXHUfSHiA
 7YJn6xZhfkRYQpxX94f8iH3ORzzh+xR7UXpVFKdTmOncw3fXSHKPQmw8QKNe2eYulDVQ
 y/mQ==
X-Gm-Message-State: AOJu0Yx07n7nJ3hIt8SxFHaHkdHFLCjuDZtJZvOkbIikYqUQ2+9dmEG6
 vNJvXzfVgV1rnrjt6poimXD7r3oCy1GggIGTffHM/QmqUcdI8GJzHr/mVcB0k/fqZfkvWKhqW57
 hxIgvhi4=
X-Gm-Gg: AZuq6aIQMDzEQTAyhEYw0a2qpUGOQ3AAogYYNBHkhePuxBu+KUxEFd/fQpsv4ZNjwcP
 Z3m38KsUrNMvKKIkr0iI2r1DpgInekYPSX0hhdHHtd5oPswFpyFiKQgi0wGAgRUSB3V/+mkGU4H
 8qVFU8MJ1M0IvpTaTW4sN4uWsbHWwIvijCQdO+ApgwbJJPOYq8yKNQ+TxGYadYpI6tqcvzN+fjR
 RgPyEesifGgnV8MQr1j1v1Eyf8G4sC9UTgEiAwMjFxTXZxuqRbH81m6RO0mY+7WaCr+d9V8BgAz
 JU8yEl/qc7KWVSxgjcMixJdYc6SZtKq6R7/M0HP9+pf3Wvdiiis0tqubvIKT4QySNdcUWKlYDcl
 nHa6VlbER1OjYKebvF+xOJ87jQAuizIhK2a+dkz7JP1F9NWCaYamMMUOfd3U+ZKOvJG1yG/Pu6e
 SNJjV0AA4DXqCYT1uKHlM9GJsCQvuh6WN3BrS8nYFzSJqB80opOvpexpywa2yKFxG6LaYTZJvL
X-Received: by 2002:a5d:5d05:0:b0:436:14fa:a3f3 with SMTP id
 ffacd0b85a97d-4379db3796fmr15686502f8f.21.1771265654430; 
 Mon, 16 Feb 2026 10:14:14 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acffcesm26064725f8f.37.2026.02.16.10.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 10:14:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v16 02/21] doc: update features for PCAP PMD
Date: Mon, 16 Feb 2026 10:11:57 -0800
Message-ID: <20260216181407.428877-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216181407.428877-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260216181407.428877-1-stephen@networkplumber.org>
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

