Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA3AD73EAA
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 01:13:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 391CA402E7;
	Fri, 30 Jan 2026 02:13:56 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 2C5F5402C6
 for <dev@dpdk.org>; Fri, 30 Jan 2026 02:13:52 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4806dffc64cso11948825e9.1
 for <dev@dpdk.org>; Thu, 29 Jan 2026 17:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769735632;
 x=1770340432; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LxM2HRjGamIffMHAjPjIF4Jwgs3HKhOV9JWmbdVBwOU=;
 b=ElUkEFvPo5SlMeELVBmXainay3Jyt8TkIGphgsQ1IF8YRJ3MXq1EWz0ULJjqjLYdtf
 JdJhb8OJFl1aBRirYJcLEmjIh9xHkgMwhs3wPZR63RKlJi8MB4CuQ0IIVmXYuhyRiHxj
 ZAnLIqQeBrBY4scE2ZXeNOExIMZmPYwJMj0RzcEA8819R/Q0yYZKVxPEmdnm6DusAlfc
 xjhrrWdNm4Eyr2YH91uYsNt/EgJmBWqB6BjJ2AUC6zDhUwz/GoUSh7k9Lzs0bK/hGir/
 JOq9T/U0FF+ZMh/wgK/lzrG1y4Yxd3RYjqGONu/e21E+DDcf4P5YqyyrkMB0XLgtO6Mq
 iyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769735632; x=1770340432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LxM2HRjGamIffMHAjPjIF4Jwgs3HKhOV9JWmbdVBwOU=;
 b=aSUgehKHobRfKTzMB0X/03WuTATsgmfrsV/zjR9c7ofcBGrz3MINcf4V5Ho+OGRfXP
 WuBIsniVeBv7umrmSBdiFaNHq6sBvcDBj36abahBQJm2M6uCCAgXqIKLkjjJg23wKAJA
 mV2JqSW3Hpy4uDJV5G40n811JobIUbo/WmSIN1iE4bQWXbfhs8khZf88LulLOYbXzEpy
 WW5R36XfckN7laDFlrLYq6v1h38UnkyzQmvtei8Y7ker9o5G/S++2aGg4v7xotnngBB9
 36OP/syRZnSeUK46QO88nprwRIPWKzWrsGIcvcNOj5qp9SKbK423EHdjWKBvIB2pt8tZ
 9nIQ==
X-Gm-Message-State: AOJu0Yyly+uPPyVSPaAM5rokn7lt2vTnFMuXt5SUdJaeKvKJXCyeD/94
 ivAeQEpqVtkTPtcuaGTpOMBMEOPQ9SVtj59IQ/BoaniHVeH5DiPUU66x4avVmzAhA26ys6LIXcf
 b2dow
X-Gm-Gg: AZuq6aJgqTtVF9j62Vt1xqnBJVFLdt45GatvYxZxE6MG63DgVIREN9w3PwQS9sHLvgc
 a6BnLxSmbU1O9DPOBiSYkAxxNQeYUwe/TF5OQI57tX7Jokuj2Kmlg/OStBPxVMnIvTafS7hvH05
 jI5cLq6bCBfBP5L5w4VKtqS3pjqx4hLHchn+SHORk9y7NveyFD61rcbJv2ijMGHD5Pw4+cyrD9A
 QxMYcBS1RG5Va0/kI1PO3wHRu0YHZXLvO9sWIGjKNDMFuCi6FLkwthktMSnxZE5C8fHN+DyKDf5
 8uxu4cGlcJGLjwde/fk+swFYS61KmFDkxECbEDYKIExyWrRAnXLr6kIxYDewU4RPUA4f9DAV8yA
 GtVuh2oUuzsTDiOmBTnAtHgpUOwAGAXGGJ2IcQH5ZCWgjTXgtPol0gV81bK9/RgVCwPcH8GXmLu
 fFC739tRy6Ly+1vZMLyVKMEDe65s5uuJv8v69zNxT8ymgdB1XNfQ==
X-Received: by 2002:a05:600c:3f0f:b0:480:4d39:84b3 with SMTP id
 5b1f17b1804b1-482db45639cmr12459425e9.6.1769735631237; 
 Thu, 29 Jan 2026 17:13:51 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e1d0f9sm2934825e9.18.2026.01.29.17.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 17:13:50 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v10 01/19] maintainers: update for pcap driver
Date: Thu, 29 Jan 2026 17:12:17 -0800
Message-ID: <20260130011344.204233-2-stephen@networkplumber.org>
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

