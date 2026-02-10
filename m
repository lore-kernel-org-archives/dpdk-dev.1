Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE31CE94623
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 00:02:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC52140613;
	Tue, 10 Feb 2026 01:02:10 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 86E3240609
 for <dev@dpdk.org>; Tue, 10 Feb 2026 01:02:09 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-48069a48629so46874265e9.0
 for <dev@dpdk.org>; Mon, 09 Feb 2026 16:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770681729;
 x=1771286529; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LxM2HRjGamIffMHAjPjIF4Jwgs3HKhOV9JWmbdVBwOU=;
 b=1NQ3vFOvObqpK1wk30h1AZMv3oQ4+CaDlHG9u39R8X3dnTLkvmyZMAt2RaA1dKtby2
 ORbKftuvnc91S4RS/L61YxuYUsh8/Nm/JYKLizPG+ljlTttCd2qIFiZdz5gV2hCYiqr7
 xU0SXKvLN4i/kQgQ2KqN9wx6SXxobChBml1x4VfxTCOYmxGSgKIxjLkb/aeixw2vQOjS
 7x+VNYPTZ5VxN9zrdi9fS9kVJmdDC8l8azQEdcpDCWeXLc8uqX41LSFDglsLFLkyfFRh
 9Eg7UJO2zZYcpbOEtYBxCJqzD1S+KqU2iNh3zu6P33BnkadiMd3g7Z/eest/xJ8WiEDX
 BUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770681729; x=1771286529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LxM2HRjGamIffMHAjPjIF4Jwgs3HKhOV9JWmbdVBwOU=;
 b=qStVequiROYByjeCLbH86X42iaWAp6bYaHfultvnVxCt9upj7y04sJV/3Mg2qaF6Qz
 HfCM1iBWYi3Odttn1EsWWnKi1xVEJkyFbJhuKGbRIvW0A6Xq7RmIet7suJ8sQ09jBDPc
 gZXWN6q/NcTwm5qRuPoaI3i8Xi9ZUkjCMBR4zP28oiJLAYzGfU379msWQ8l/acOCMKFn
 jores6HSMLjxBLrafVn9gfI4RtZAsyIlNx2NAZS7UwU58UVYchIog/6B2eaGFS0zeqQF
 YGnjo7QXKxqwK/NHHoo3lM/zLmTCIl4FyI9xYXT5nvJ8IGagejBNRa+seNhr3/Ve7xUG
 IPDw==
X-Gm-Message-State: AOJu0YwnkGMYDSDLzgd4d59ZMxkBkxMl/c0/Zh4RK9HpSVPIfICC12/O
 TCD6rI9wGTzUlGIcu++WWj4HvHUbDoniB3S6PK4g18iO9dEBPusO6Ln4g0D2IXXimTSCkCuJUYQ
 VZTna
X-Gm-Gg: AZuq6aJz9fmcANjKb3Rw4EiRiiNFReDP6X3ejGCn/reaNJYaHLqTQjWwFyuAZhgkGf2
 HdRcXD4HWNmgzwN1wWTxkc6nVIwQAq17xgsBsjYR7W3mb7iNugX0G0FNRKLFrvogzFsq+AdguSv
 LLGcsFulZfqAlGg0RREgzWSELmJBURdQNi6+uoq2YwbWiYl8WAourQxKTT5edHH0dMyvs+e0IWN
 4v95nNXkVVLHFdOF/f3xWDXb/jY1/iLtjVf2M2ci8FC6LC/0W+lbH3aP4skyGXJ5jZMufsAlgS4
 XnxPVl9wecQETouiwRTTRxuocSaf7y5YX2yYPrfWQdrGONPp8Zb113sxabvDUihUA2GAQ5ZwnNL
 T4mWZH5rZJSmyC7g5bvh1qCpaMqJtOnHGXe4czjDrjonQ3L7Fk4/sTHMS1JgKC9czolApMk+aH3
 IE9PgMgzrgtorzdlHYlATI1vmsjrse51DPkNduXPx+Zt1Z8JoITmIigYOmkMrhxw==
X-Received: by 2002:a05:600c:3b9f:b0:47d:6856:9bd9 with SMTP id
 5b1f17b1804b1-4835081ec28mr5702635e9.23.1770681728953; 
 Mon, 09 Feb 2026 16:02:08 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd211sm31529133f8f.13.2026.02.09.16.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 16:02:08 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v13 01/16] maintainers: update for pcap driver
Date: Mon,  9 Feb 2026 16:00:32 -0800
Message-ID: <20260210000201.295839-2-stephen@networkplumber.org>
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

Nominate myself to take care of this since already doing pcapng
and pdump code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5683b87e4a..28a3269568 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1118,6 +1118,7 @@ F: doc/guides/nics/zxdh.rst
 F: doc/guides/nics/features/zxdh.ini
 
 PCAP PMD
+M: Stephen Hemminger <stephen@networkplumber.org>
 F: drivers/net/pcap/
 F: doc/guides/nics/pcap_ring.rst
 F: doc/guides/nics/features/pcap.ini
-- 
2.51.0

