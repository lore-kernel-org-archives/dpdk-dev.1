Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3805DECD6F6
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 22:21:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94C5640653;
	Wed, 11 Feb 2026 23:21:44 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id D97A840395
 for <dev@dpdk.org>; Wed, 11 Feb 2026 23:21:42 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-43638a3330dso3687835f8f.0
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770848502;
 x=1771453302; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LxM2HRjGamIffMHAjPjIF4Jwgs3HKhOV9JWmbdVBwOU=;
 b=O4XdN1yACPzXxYzfqlo6/yRXIIYyDbarQkO2Pnu3Bs3vs7yuHI6ZI7OUerHERM+g3X
 UvMuv2uYwrGGn5+6r+bBXT1n4qLsxQnNAyNJ+jk84FbLuLvjygMvHL2lccTmvUK2gztp
 HUm5NNgreFaddydINnY/pvTenfVFRME1g9CGM25CkH8z86p6I1p2Tv7L1S/cGurTs95x
 ip0gjdPk8L2WnzOh2qG9xpgAi2lw7g23CIijpkmngUts4+82/ce78ec9eIHAcL3RcaIi
 xzqVL5KsL/1I5WttmAHRDalMJ3sf3aUgIXjdCIBk3yxXgX+4/+OfOl9V2EL2WI1oshtu
 oV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770848502; x=1771453302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LxM2HRjGamIffMHAjPjIF4Jwgs3HKhOV9JWmbdVBwOU=;
 b=vncIEwKbDVEB0SuE2+OHsBYA5vaDZExMCNW9odW7dkH+beMg6xtHR8PJNkPWyipx/h
 AWULXlZ4jOJ5qQ610VKP5apHQPqv69R/I+i7Uh3OLpt2i/o7ewNj0LX6PXM+XcdGQc/I
 IoGmweQEwW/i/jZ4m4ZwQC0jARr+GuiIkyVgNTCmyvn9UGr9SYF+g7yqATQaVdTPGl3h
 k1tCjEeUGkrLfuZt6vcdM9nwDDi9x/VCdI75u6Vjg9p3fKlf9TOxlE7Nmg8uUzU7CtxJ
 5R6VdPYTvfCaC0G9CnzKg42zZmrGgorAWegcz9J5DAPdaceuhY2efxL1WNcIIkTl6jo4
 aRpA==
X-Gm-Message-State: AOJu0Ywpko4L1vxQsHU9G9eJcIQeKntyRrcIcsrl2fWAWK4fGQZuwESr
 4o7Vox/1P7MG0ehtz6ShyVrOd4ObmDvkRLPHdZMR4p9rHXKwwOQlhDcBecrS07wOOuDBOC0hmFT
 2LzRF
X-Gm-Gg: AZuq6aLzVhXrZgkBc0Zqjrjl/T5TCOCILQTAGKZ4CrM3DqXozSykWMbHIV+nrKk2bHT
 aDpxSixXFiArbBWLee8Fnc7u+evXtIN4woD5Mzw3sO9UF8nQXLPPAwvBz+zg34UDr6raPYUsCCO
 QVCZ9RXsYIE9hIldF8X+K0C5oSKdhlbda7kbDxX58BKkMLqJryaKfds440D7rljr3GN8tAbBqPX
 V3lE3fte7zmM1nct6TrMOA48bEtHrhpa0bcZ9xtsbJcVtUuwlbTjN3c2nrf+1T9uu4XBtsuWqBC
 b7rVatXpvsQn4zWuwE/9r1IT5MN1cdWEAnfp9X8wzHLu4/FNcj+4gDKAiJ1/1NMflixW+dFrwGY
 XhpnIkXbgyyskqfV+hQ5gLaOfqJBf3c876kU4ydoxR4v7XA/CnDaao4sWy2H0m5oFCMPjVjgsDD
 yCHNGRXYdJMq+/1E+t7pRhqV8O4y7Qy05pkefv7VGjZyY4+WjI5QDp2x4pD41Cew==
X-Received: by 2002:a05:6000:2c0f:b0:430:fa52:9ea9 with SMTP id
 ffacd0b85a97d-4378acd093emr1632895f8f.62.1770848502301; 
 Wed, 11 Feb 2026 14:21:42 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e0196bsm7877965f8f.23.2026.02.11.14.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 14:21:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v14 01/18] maintainers: update for pcap driver
Date: Wed, 11 Feb 2026 13:09:34 -0800
Message-ID: <20260211222130.338797-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211222130.338797-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260211222130.338797-1-stephen@networkplumber.org>
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

