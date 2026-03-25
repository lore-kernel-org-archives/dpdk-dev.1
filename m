Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710C3103A9A0
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:40:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3262A40DFB;
	Wed, 25 Mar 2026 03:40:29 +0100 (CET)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id AC7E940DD3
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:40:25 +0100 (CET)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so7296224eec.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774406425;
 x=1775011225; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6oziFIePaGAtnlP6qcWP6qzC3ifZoFwAoS63sMQuE14=;
 b=dArlhhbmrPKiP+hpd4P5cKbdrbH/csCLYLm2FmZYkABQPvIHO5RfHpIunRYUvs0yD4
 n/z1oef6HPXeVLK1a/eveqSUQxG0dK56CoGKc8XgoHpZ1PmnqZpSfizF+q2CG9sG2Hoj
 eOIdmrV4X3OTfNrltcOhqhaXipyQJy/+go5FU1y4LltTo4iS8U5jAh7qFPuAhD+xkGEf
 /XFZ7mbl+dBn9hbndWeRtB0HZOQ2q22H3Uu6WezpRhpHM2A06HmvLsVSaTT7d9nK6LoZ
 cia0Kws3JTgNL4RAwTKAv788tlyilOBdhTkuwKAWhSjUUn1D+nKEP5Of4ay84b4LVYuC
 Yt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406425; x=1775011225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6oziFIePaGAtnlP6qcWP6qzC3ifZoFwAoS63sMQuE14=;
 b=Hcjx3KD4ayTK/j++Wgo45f2MC9othu1nhR7C7Y7IG6EXVOLwVsrAmPOh1sXhpXdfa6
 miAfTOlVnEDYJSAAaTj6RZPllJQ3aCPQ2Mqrysc7A20oFPUR4LE5QVbtTUmistTU4ilK
 MeH9tdjSxL0VH3LdOr+FjArqk2TlwK3T6XUboghJttUt9wYIwFTtufujefXF3N1EaBy7
 lWXU5x2+FwxPIbP9Eu4q0f8Yn3AwLyH8K6EbJeJ3rSUbQJmWf+lyhPfiwYfK3tdypevH
 wS7Say5w0l1hRlJk/NV+OhlQ8OuqaO9DN4B2XJ3OFWtzyVqUAAe0wq9U/UxD/12XOkmL
 Agvg==
X-Gm-Message-State: AOJu0Yzg4J3DfdPQ16DyPPT13vgFlViqghweBl7IlWN/MegFdaF3Oc5U
 WbOSRHFKk2vG4D0ZjU0E0KFUMSrDEOKEnKk1l9qSzHBPRrhIkTdHsSglqVb8Gc58mX1OpZI6+Qv
 br4Kp
X-Gm-Gg: ATEYQzzvNzlGo/0INVeOQkThjOB5YIaWx4q+9j67UizG1U7TT5e3BfpQerNVyRgyiiR
 AfwJaBu2oDVn8zw0n48n86fVYS5EExklj/r/93b0SIgm3xy3O97MYDRrSLaKXmHCNaA+Ug5u/ak
 88+AgF2pIRcyUlV8mpCijLtu0xswsZGPEJFgGItD6E6uFLWl/o+ZZPbvKDVCPA0bEPeqO/LpoRg
 wl5nosO2rkzdsLZmhs1TkN1G9NrXAIJN01UMB3VQW47g804kEwP404iZJ4pR+gbZvT4OzdnM3aB
 bcURH19azc98zH5eFjdrgUvvwfHB4UvNDtclHxDaDCB+1Zy4ODt5su/xUoD3iG0jEumQn883L1C
 JnbR0grYJB1FjXV+c/CjYVXEWBK9kpKnqIgnEg4ODUG/74va4BB9IVfZyoWoVPhYC9qXNn927At
 IynWqKSBCcMnpV5wr8MV+R3HqtynWF2GDzaNK/bvcJB8I=
X-Received: by 2002:a05:7300:e8a1:b0:2b8:26b8:3446 with SMTP id
 5a478bee46e88-2c15d294bd1mr706037eec.2.1774406424697; 
 Tue, 24 Mar 2026 19:40:24 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29b447sm17209452eec.16.2026.03.24.19.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:40:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v21 03/25] doc: update features for PCAP PMD
Date: Tue, 24 Mar 2026 19:37:34 -0700
Message-ID: <20260325024018.1275209-4-stephen@networkplumber.org>
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

The PCAP PMD supports more features that were not flagged
in the feature matrix.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/features/pcap.ini | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index 7fd22b190e..99ba3b8e1f 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -4,8 +4,15 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Link status          = Y
+Queue start/stop     = Y
+Timestamp offload    = P
 Basic stats          = Y
+Stats per queue      = Y
 Multiprocess aware   = Y
+FreeBSD              = Y
+Linux                = Y
+Windows              = Y
 ARMv7                = Y
 ARMv8                = Y
 Power8               = Y
-- 
2.53.0

