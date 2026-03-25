Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0369A103A99F
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:40:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3362040DCD;
	Wed, 25 Mar 2026 03:40:25 +0100 (CET)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 97FAC4027A
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:40:23 +0100 (CET)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so7296202eec.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774406422;
 x=1775011222; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Vbp4u9gM9TWygNLGhiTUb6nULz7qpRw1eo/ENs94tw=;
 b=UXRzmnfbPp6TEyOANY072rtuunKOTzLYtm6D+lK23eZooEztZBvfjQcGPRrQRmxQf9
 1P9GhFqxC57oku6MpqU8QxLMe8tuvdLSGu5y1Vyxy2o1jDWa0N2f+XeQS97I1psD+lxt
 ezT58FtCcf+nIehb307lYIrD1LjIR9iNOv2wA7Jlg+5/p89vAZbgPV4oo6wBa9PAC7WS
 HMhngSTUqz+2poEEVZV67B11FffK6JaaRpkS5x3ih3IPaCBkL8IbfOExsBZto2iSTmi3
 ghPlkTt8ROBoqhdYJwYSHBuM+7343ZFHjGrXj1+9O1G2hdwIm5BUtP2DutWjOV2SifYf
 ooSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406422; x=1775011222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Vbp4u9gM9TWygNLGhiTUb6nULz7qpRw1eo/ENs94tw=;
 b=KgNvbdxfhmgEansDHp2vi56Ztyse+ALxu5iVF0hehlZ58VpJR/CrCJo2QHQiaj6SrJ
 ZhjrnN31AZMflIxTeScyXKH8EPdVZsAHLAWImUB1+IfMNhSWkM52nIaOTZ7GPdyMjcux
 X9DHgcIIWxGz+S+zPNzOMKFcEQH3qqntvLjcnso54bcPJ4cPhAmmblGNvEvgGace3Ehs
 UwHNJzWAn9PWaLvW6Hm3GrDgxidrDmVr5ifTZYLTG5C+JXCwgMDkgSrSTbJiU2C2++vq
 cxUOHB03iIS5XZtkGSN8M/9uY9z/vyS6vzOCINphGIbt9EUbL1E4hk3COxVQhKIB2d7Q
 c2qg==
X-Gm-Message-State: AOJu0Yw2wXizKPMf2ClGuy/OB79zaz72649iWgyjj/d1n35SBNHOiJTR
 IarKQLegA8LMBe2FY9jUwxz/63bY6qVaCdV36Qi7nwgJDwZ5Kk0sCKwzgxTZ6wds38pJKM4J7aM
 MdPsH
X-Gm-Gg: ATEYQzyHigkuATHYl3P1H725YUdXhde4mfVjgy3PeTg3YQdjVompjU6PhLis2cj2jX9
 m+OZZ9rMbUJ4O6ptK2at5glr5Jet8pNspu0FxeChP5ZLlq9fnWKN9x++Pgw2SleuQh96AQiJ6ue
 Y/yYsHNq+k0D+cFG2U7GdJhiA/BsNVibP3Gl20paFUFMIDWXbBYEcGnX8aR1IWjNowdcsentzvy
 JgdU+YiRS4litwnSqnKu0H8bTHVwOmCLCwANUa/VJmrPSO6rVLHRRsIT+6TPXw4QvFbNpnYcMXo
 8q/d6f96cwtmCbiaiD38GHnrbPWiE65A+whU9xFU7oR+8pqhRDhKpQYKaFNqlMXlTTgBsstkzXJ
 DeIbPcjzQjwgmH7U/sPRIH6SgiDwcu+zbf8XAMODH31t0jTYR5hjVhOfyzTIxLZ9MJVYse6bBc2
 ddgqzzZNL96MpyzMqSxC+zm+BJdvmZ3efhDUdlq0ZkOA0=
X-Received: by 2002:a05:7300:fb92:b0:2ba:6978:2b4 with SMTP id
 5a478bee46e88-2c15d3a2f62mr1070087eec.20.1774406422427; 
 Tue, 24 Mar 2026 19:40:22 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29b447sm17209452eec.16.2026.03.24.19.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:40:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v21 01/25] maintainers: update for pcap driver
Date: Tue, 24 Mar 2026 19:37:32 -0700
Message-ID: <20260325024018.1275209-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325024018.1275209-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260325024018.1275209-1-stephen@networkplumber.org>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f5539f851..580113a658 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1116,6 +1116,7 @@ F: doc/guides/nics/zxdh.rst
 F: doc/guides/nics/features/zxdh.ini
 
 PCAP PMD
+M: Stephen Hemminger <stephen@networkplumber.org>
 F: drivers/net/pcap/
 F: doc/guides/nics/pcap.rst
 F: doc/guides/nics/features/pcap.ini
-- 
2.53.0

