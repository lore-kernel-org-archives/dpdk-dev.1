Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3AEECD6EE
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 22:21:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3BCD40616;
	Wed, 11 Feb 2026 23:21:46 +0100 (CET)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id 7FD324064E
 for <dev@dpdk.org>; Wed, 11 Feb 2026 23:21:44 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4359228b7c6so3821796f8f.2
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770848504;
 x=1771453304; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=hpKlze0ShNzR+07NPzzMN7jhMsL10E1CZoQCIo0kVi+p/zs8a/NMNCL7o4/d0N0VU+
 ZJN/qBYUcTRzQPB9c5iAdtYNOW3qxizqYO/CidCCmR0wOyaKnz/6Ruqvouu8CJ9q3e3w
 QBkrvgzjokkki5Nz+Vf12kylOE2oMUhG2DCrwRSB85rhwZuCPYJoTWojYT89LESncIJR
 /XO1Si8ndRWmxS8wzKQFJAw3FRg986MmH4o689GMULHSz6mXweq+7m+fNXA069KYuMEs
 2+Ooy9r0O4QekWlRDnQ2CUEqiCC4VP9IyHroQzI0JdS/255aajO1bYIeLcRRbeBOD7dn
 y8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770848504; x=1771453304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=LDDMjjz2HFlEcMwnMEwSERutB1C9usTMqD1leL6+T1l72y01VhxDWuIktibiASwpt6
 aJm2OXWejWPZgdKpuL3oA+HFMrHDpoRUhdVYYL0sb/ZMejWt9QCF531fvUBs2pB5Stm9
 qXuNFesecnZ91pZvRICCoXfD7FmLRRiQfTAqL+yg0CvkP6ddedYYyDWzwqXH1qPpU7j8
 uOUYVM2tM70bEpKGZRKaEDUuaui85Ni5tU3CQmD+aTPevr1+ZMGB6+PfTg1thzZEs86w
 B+Cxavn3+u6+SUdjuBPEmtLNrUq1iSqEhbsDYHE6rD6Z7FUMwwxY8Sl81bLjCI/fh7GO
 O7nA==
X-Gm-Message-State: AOJu0Yxn4qD2eF1eHynh9lkO+zqvOOG88Qc0u0QQilYKzxL/KFU6Kf5G
 r2DNWeku93xV7/a0B9ZFiJUiNjc4M/3+DPyL2Ag5hVNqy6dj74DWGXcuq6wT9jR7xyyJ+xk6bTf
 rcCO2
X-Gm-Gg: AZuq6aJ1vhs7m7XpacQ4wyM35GuT2SYAhiCWYARrp2HEI4CLpEm9P+aDi8F4BZ0gBvD
 rdOF/+85BeHetcMtnPQ2D4Y1f7R/o1mxAn8Q1c9RSyb6vG+actpwb5D23oxh5AdclvJNU6YGZQj
 Jb9Ia6talVB4/0tQJd4E9Y+FUQj1U4uvrBUUaVjwN66WugqQ+xoxMcnvDGxnzFOz9Vc3vwdvvvS
 HmjIFvPDk0j01FoPYvd7c7SxwHB0toWBleJoFJ/r1Wenjh/i4P1Ad4dJnQuEtETWpzzHmQE3LOG
 C8XTxC3mgVweVoQZt62j7hK3kMtz0O2purWqisY3KV3FkyRHMkYe0q+cPTuc4O8CDvx/Yfa9hMy
 G1eC1eMfknstV0sJaqhYQDMLSMC5R8xZFIyylca16iQeAg4F+o05pm9mJx4wKnFMgdpTR9O9bUs
 p4g+JNFJPhJK3HUu1gwg0vX/CqHOaz1JfgGejZ9WJFF4FyoXNzzRdgePFtE1RJdg==
X-Received: by 2002:a05:6000:2887:b0:435:975a:131c with SMTP id
 ffacd0b85a97d-4378ad46189mr1302078f8f.36.1770848504066; 
 Wed, 11 Feb 2026 14:21:44 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e0196bsm7877965f8f.23.2026.02.11.14.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 14:21:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v14 02/18] doc: update features for PCAP PMD
Date: Wed, 11 Feb 2026 13:09:35 -0800
Message-ID: <20260211222130.338797-3-stephen@networkplumber.org>
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

