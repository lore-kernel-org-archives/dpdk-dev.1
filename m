Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26452D5B866
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 18:37:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48E264029A;
	Mon, 15 Dec 2025 19:37:04 +0100 (CET)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53]) by mails.dpdk.org (Postfix) with ESMTP id 8E30F40151
 for <dev@dpdk.org>; Mon, 15 Dec 2025 19:37:02 +0100 (CET)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-88a26ce6619so23007616d6.3
 for <dev@dpdk.org>; Mon, 15 Dec 2025 10:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1765823822; x=1766428622; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PwK119CWOHHalU+PMhvGBoV0CUdr2hdks3YDS1E6njE=;
 b=K9UEKGngIZwXHAE/uW8ZJhP4HvKJ8HxfvIWyBZeIMvzP4/ExNr3mvSC/zquzhJLcVf
 mYwJMETbyx4qtKsIzIsrJruxewH58Rus5n21xhgX5ARPpAAuPBm0Rd2tJgx8IjG/ZzTv
 4b05T4UssUV75Vw+HETdr861HJUfBe3e0C/Ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765823822; x=1766428622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PwK119CWOHHalU+PMhvGBoV0CUdr2hdks3YDS1E6njE=;
 b=R54fEhLgGautgE2B4+rkJIbK1ThqcRG/8d8VPtWVn2StB8Zz5x+725PHkjlvxCAibM
 IoommCtdkybnbt7nNok4QekHJ8gwKdfcd5MTLgoyIhu9rfDkoqbTji2B9lHv6nsz8ZJp
 M394GtwXJbXtAXirIAVoz+z19SITY+8cwtP9hoxa1yUWm0PtFOlW3TqPyc+kgyHhbKsA
 481U1w1QcjcP0giL2Ufv0rofr3GbaeKYyrmfPRF8cEVZa5+OFNW3NLm+l9h9Rk8IFLaf
 rwtN4DB+DQNeMvuS2MFWoQoYMH422Zboc18c8m3bdEWtrfGaRmBsRK28sJrCrEtrz8Ew
 7p5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA9NkqsLrBL0VNooVUlTZoe0DTkrClO+UfM0Dx4KeMXJI0GyREpdbum1JMtiARRYPxT1I=@dpdk.org
X-Gm-Message-State: AOJu0YwJWBaC9KPohSrYBbp27QV00gLzkMMQAKnWi1jzmWbPXHv7c1g9
 AgUu8HUBh6vQY59plA5hf3KGfYpDPha4zU6yx1zhJgNTox62LmTc4sI7ur1TXp0HdcY=
X-Gm-Gg: AY/fxX4texBqdoQzMnqPGxJWWNhf+ljPt2XttnK5EfKdficC//GhGqmrZ/hJ8tLiU1K
 bF1SBQ0bMCpIuzXXT81sUDxIwY49qJQXmFsMAIrOn4ciPujeS19hLwXHhO1vwuNsCS+b0ttAlGL
 k7m/BMHDiQypgURw607VBS7wtgDj+PEo9LtNH4DJLZ+AZBHW30cuviuecC9MFHvNn7rCjM3LG+D
 F9JCvnbzK2LGWJF/8pSixtBJzXh4ujzZ2NTN6ES/HJW0YsHZUmcNgodsjDbs4ScZh15xeSeToRL
 0iQIjB7hYTum+T629PMJ4ufXWyYahbPMeMJ2XjIIEXROSLIJorXhjeOOs6QedW95PrIj1YtlrTz
 wgF4lJxtfh7nX5SJvHOqrnZ1L5XFaSDbdvJdpk5EzzF10dgzaR9BFFN8Mxn4TYK1/uyctW5KdcO
 5gYrkM6CXB/2HX0MLHAT/TcHG5QEsqVxeNxg==
X-Google-Smtp-Source: AGHT+IHwdyC7OYf/Ssy90xenGQfKvJEd423ZqLyVnTtPWkbyztI4NkWUGNjJ82LLEy3wGNxA7IUfzw==
X-Received: by 2002:a05:622a:190a:b0:4b6:299d:dfe4 with SMTP id
 d75a77b69052e-4f1d050546amr163446641cf.32.1765823821761; 
 Mon, 15 Dec 2025 10:37:01 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8899eb3a7c3sm58074476d6.35.2025.12.15.10.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 10:37:01 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: probb@iol.unh.edu, dmarx@iol.unh.edu, dev@dpdk.org,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2] dts: show missing NIC capabilities in DTS logs
Date: Mon, 15 Dec 2025 13:36:58 -0500
Message-ID: <20251215183658.674252-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251212210142.669766-1-abailey@iol.unh.edu>
References: <20251212210142.669766-1-abailey@iol.unh.edu>
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

When a test was skipped due to a missing NIC capability, the logs should
print the name of the missing capability. This has since changed to show
only the integer representation of the missing capability. This patch
restores the previous behavior of printing the name of the missing
capability to the user.

Bugzilla ID: 1803

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/api/capabilities.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/dts/api/capabilities.py b/dts/api/capabilities.py
index 243759668f..2d0cd65854 100644
--- a/dts/api/capabilities.py
+++ b/dts/api/capabilities.py
@@ -219,6 +219,10 @@ class NicCapability(IntEnum):
     PORT_TX_OFFLOAD_SEND_ON_TIMESTAMP = auto()
     QUEUE_TX_OFFLOAD_SEND_ON_TIMESTAMP = auto()
 
+    def __str__(self):
+        """Override the default string representation to return the name of the capability."""
+        return self.name
+
 
 def requires_link_topology(
     link_topology: LinkTopology,
-- 
2.50.1

