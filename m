Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366E7E94625
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 00:02:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1E7D40656;
	Tue, 10 Feb 2026 01:02:13 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 9BF7940656
 for <dev@dpdk.org>; Tue, 10 Feb 2026 01:02:11 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-482f2599980so3225765e9.0
 for <dev@dpdk.org>; Mon, 09 Feb 2026 16:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770681731;
 x=1771286531; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=zdgamTxiPOQhilGEr98dMNdFHUao0UGHD0RFaPllzPOaWS+DIc1eUS9qBiYbM4cYuX
 z1qj2kqB1OdTOb86oXwWpN5bTVv+IaEOJI5gKzRRY+6XmDDIiYcqc5gE2oOnXkG5m9CN
 RZjFHdiZXokdYps2n4sIsUCD395tzMzX+f12S5KrvfZp1s/t8iZMGhAOFCBZODwIskKD
 ZCuUMd12afSd0SJ9zcUb5AzeYfZ55aItdST8zSwv2KumAlD7pOTX70aD99nSvnIKmT5G
 A3KinUHDYtpraSkVOdKUNRrrSVWM5qks4nsNINKc6mT+j/63m9SpCfLr7PChRqBVy9W6
 VG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770681731; x=1771286531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=j2sIbMRAro4ebwxTcLUWaDp/qIsc1zGnNsdE7CHLS/c+XACC/+wxhCL8/lFOUhJeZ3
 aY3/PQoK5FE8d5vhdAh8hcqhZrY6qGeB9EytV0xwhwTYSChuWbLlNcdFSGZD6VTVhs2q
 ZVdqMZGhcIZ7MO+v5De52cOnFHHe1E/Ep39NkmOWMlOcHAiXZv/aa3jmRhKzqIOTUnzF
 UOYDWikN2Y3j3rcJbWggBWkgNg2Y84d++9o6MEIYbS4q+StI1aKEgjsW73repxPKaz/P
 lZmaNMOb/bLJzf9CibcE77G00AzDX+50C+jR7V8bSMS0IaaSOkBhmsP/j5EhUzZwb8/m
 2LXw==
X-Gm-Message-State: AOJu0YyKZEc/Nr870mi/w4Q01bS+N5NPzb5ARYQBdsa7LkaPzuk1DeYM
 ULq3xTK9e5QaY/tYnay1sjhgCiIgM4d5EKJXMLtJyQW3JViwvexaKQ+UbS2RlUK4ebFeoJn+sAV
 06B5u
X-Gm-Gg: AZuq6aIj9kj5UZa9NvyTISLxvRehCsQkVmGw29kmXeFfAN2YzaRUskE0O0yQr+OIW0v
 m1S/BO4q4M+wPoGRYuYu7Jn7vKxdZLK7rfVulJv6ZDecNCCuvJsDcSrhohPzHXFKkJOMAvLuLN6
 w3fEuSv/H8qb9pMUyBqRD2GcsxUEqpPKpxFSxCD+8Hk/3x/7UeyjLhuoJWgnOMeHFNrDSUsF28j
 yjC7YBYW4ffCU0eKarMYlwciOO+WE5PuozzrGqylcfri88vnZqVAGOTbseBMFL2z8oBZm/678V5
 uX20DWJ9b3cIOz3G7Ub/5zp4K7U+lDtY5QXOcs3pVQKz7dgXF/dgYyH5Kt9oSdYbEmlunBW6mnp
 0A3/uV/HrpEFO/ORjpQ1qATNHnfQK2QlRdN1KjYesDKGQM+88xi9nZTbBMUFJi3h2sLO9djJJl2
 i2olD7JmokeSdMfa0Axhi5bWKg3mJTOeIx4yu+UcFtcsEbUt5FueE71VcubTuOSw==
X-Received: by 2002:a05:600c:19c7:b0:482:eec4:74c with SMTP id
 5b1f17b1804b1-4832021c5cemr164288285e9.22.1770681731188; 
 Mon, 09 Feb 2026 16:02:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd211sm31529133f8f.13.2026.02.09.16.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 16:02:10 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v13 02/16] doc: update features for PCAP PMD
Date: Mon,  9 Feb 2026 16:00:33 -0800
Message-ID: <20260210000201.295839-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260210000201.295839-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260210000201.295839-1-stephen@networkplumber.org>
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

