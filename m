Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26574E7FDF8
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 23:13:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2AAC40648;
	Tue,  3 Feb 2026 00:12:54 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id E11D9402EF
 for <dev@dpdk.org>; Tue,  3 Feb 2026 00:12:53 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-42fbc305552so4638599f8f.0
 for <dev@dpdk.org>; Mon, 02 Feb 2026 15:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770073973;
 x=1770678773; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LxM2HRjGamIffMHAjPjIF4Jwgs3HKhOV9JWmbdVBwOU=;
 b=BDAq4HOXr7q/QGsFQOKh+FP5uSVNcUuuMeX4Qma0LOXI8Z2EoeN5BdVjNDQgLjoLzr
 Y0/sF6/paG2JMZtIEYJWfCFUJ3TuNHPw3WnThYNypgo3adGq1tf+9ySg522vYl2yR+l8
 1qmcWAGw9NAH6/HD2WGmU45rUqQXeUnnKU9MId2x4vh3aIt8nZYGJKP3/ggYF/+XlbvJ
 Fmks5u+QgUk6r4gmuNEAHWbuQUbmjlsjGMAmlFfCWo6PIv2GaxQUsSFOACeHIiC3Srqk
 59Tp5HrJdseYH2vswtULLmgUQz+kaNfWDJ46zEzeNuDcMsvwbxUpglOaszexNPXSp57T
 u6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770073973; x=1770678773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LxM2HRjGamIffMHAjPjIF4Jwgs3HKhOV9JWmbdVBwOU=;
 b=iRsp7JgN/dOBsgL2VjNp3l+LlerodFsGz+RqklgFUdhG36UxtNqEMJzHZQQWMyB2qi
 viv4JmQccpdmh0SebXN+OZXpSqxmvI1TVf9kGnWMVtsJkyAvMjKhvNcuQOxNLu9rfTid
 rCQ98CXrKVG8ieXBMpJRkJVPcTiFcBdFUs8pLnnggxJ0jPYvbfE9CW4sXdNCTd+Xo2/M
 vMwcA1Iy+dywMoguEBQtGKOF9+/qB6sJMUTfe0wRk6Q8QG9hwSuuqQ5sJpO6BVQwjLF7
 oBWmRnpIcaXnaMunSRPltYt5Eufd8IuxhpDNusAUB3EdRa8wr3lFHCLUBKqdJau2jheE
 VWRw==
X-Gm-Message-State: AOJu0YzHnscL/LcmAnvdaYjAPtZnPH5xJUzXNjAA8KhBVUYhONW4a2KL
 fXGi4w6WUh+Wo+lUZW9XZbvQwqCFziiDqW7EZQpzq9ePro8x5hoeuuH4hN0HbZ5L7TwK8/QFhtu
 bDp9+
X-Gm-Gg: AZuq6aJuK5PRWDEJgwBlZFL4Y97dpEFBhN2I/9ZOf70aC7sKwKwMdV2WkjJSJsGm5dK
 YIqdnCBMDzs6wx7MwiVsD7jwpQM3DFiHpH5ciXlFxw1LmDkckG7BTendmroQi53SjPwUJOi6GFK
 MUwFMeH1N6LOAlscYlxg4wCSrx8mIkxvWErSmeVgGIavl73NCNnwzPGXHLsuMjoaKzrZX1yne/s
 6rIO6yM6R90tQ2c7EGNUTACYkCdbiqxuyI9Hi5KjQZomJw7TrkobOafSma/e0tUDmacs7cbm+nZ
 n6j/Xq3eHhU+rLaXoChpNQcNaNJAoW/aBKzHVy7pkZFKjTp3Uy7mJlR4ZELUyxhdMx/lJcjqzIa
 0+3d/c4mPCH93TiNiEUT5N0Ptbu1RX/J4UUMOerc8m0LnPEz3Jhc6VCeAVL9qO7ASHuJeaPIvT1
 xnHeABi290egsjPzFtMoeEUGrElc13VqTk2u5f8VMYN8g+pEGU5A==
X-Received: by 2002:a5d:5e01:0:b0:435:ae97:b31 with SMTP id
 ffacd0b85a97d-435f3a6a8cemr16918021f8f.2.1770073973471; 
 Mon, 02 Feb 2026 15:12:53 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm45799474f8f.8.2026.02.02.15.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 15:12:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v12 01/19] maintainers: update for pcap driver
Date: Mon,  2 Feb 2026 15:09:04 -0800
Message-ID: <20260202231245.216433-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202231245.216433-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260202231245.216433-1-stephen@networkplumber.org>
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

