Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BECC61DEB
	for <dpdk-dev@archiver.kernel.org>; Sun, 30 Aug 2026 20:27:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E320740671;
	Sun, 30 Aug 2026 22:27:19 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 993D640671
 for <dev@dpdk.org>; Sun, 30 Aug 2026 22:27:18 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-38e041ea211so2693538a91.0
 for <dev@dpdk.org>; Sun, 30 Aug 2026 13:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788121638;
 x=1788726438; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AfvxMNN5FeVU2Z9yolvqCsqnSBCiZSLEIwc1+NVZF1Y=;
 b=aIAZihs5pXWI7Rd9MgxZBWACzbUG3ajz8POJq7VyLAMT5H0240rEAUjslWx8Dzt9ty
 LIdx2aMVQlgq3KGJNgWlKLXkDzaKXkqnjEm/o9T0bPIpFUKgd2jGo2yfx3twkf0tSn1d
 jm+q5iTNkg8d2MWg4IcHG9Tz+CFRjf72m+2L/Bxrq0/z5hhnjH5BMC2Htzhet46QFJK4
 t5dhdnkasQXp9vsPaVmxvkL1pXp93GLU+mBZsl8GYj7LZQG7zHLQ5WqVKcJt2AUkW5VQ
 w/Mn1gLNvfIzrsSA3cp2CpqPbMO/nD10MfjZ7dhvgfxUzS6AR0e4wElTQWIZkI+8C4E2
 giVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788121638; x=1788726438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AfvxMNN5FeVU2Z9yolvqCsqnSBCiZSLEIwc1+NVZF1Y=;
 b=n/szyGgo6lz3uTybEIT8EdF9pI2uu9D+jjjdGOSsRC5fygqPV3tJi7lX1UYf8QoKY8
 M9b3LhxRFWl6OrLSqpnskABlJMPpCui0YLveQUpmhhr6+IF4NJDVFAg2YkNAxAXU/YNW
 h67AH61d2kiudazPspTY9rFt4eOeH+zuUsWQdcL7F/U1YAM9JDk1TT0CB9bf6nzUopqH
 6lk+3U69SJ8QSPZU67QwDe5UtzFt8N8d1vd1tlD6w8V02FE0v3qe9rmVrYhPH4UwRcox
 7IndVESszkUdNzioDTfTYMHZ92hKewi5xQLTNHYLbn8YiM/Rt6S5pRa5/EF9FDWE4qz8
 cQ0g==
X-Gm-Message-State: AFuF++mimU/2vfvNO9K3l8xh3ICU/gypMW+DU/PeMn/UynXptKitoVnn
 QowWxu/DVf0yDXMVOisRnSY2I8bUKusbELWcXwGsPj6rDisDG7b79U3YXS1+2w4cFXV/oQWKPbQ
 zPmRN
X-Gm-Gg: AYBFou1s70WEOBtoZ/Uc5S1zH6VhFYWsjY64NXOQRvwHTN4YTKztWxbtggkTcPyjE9G
 4qLA6Rxan284U4lFMcQvigStsDu3rBbbGSwjkVbbKnX6WsG1ON92vLrXvYjeN8ILXWRnehYotjh
 AK09REfzFwKF4x+CtS07uoBzntbpOAFEadSpVtCv+Xm5vjwwJaRcVeitMjuhUx3zj7ek2OuUVf3
 Ri50iP/uAdmld7wCVfzESssQkG2JsDm4YwLsQkusb29DZpUbfstTFoiQQv0+IFnq0yJlRh9jXlr
 puQd2aImKvueHnTurj5+znJlrR4PXoszu0SLao81/XwxYNny1IuQA69UKlTeDEqJK8hS+eiY89n
 I/u9HHqL15lIIvp5E8z+dNkpuhspmVZna+gGy9qiXU2JvuidRQxiDi2I99HhQFxt/lgd0L8i8n3
 Li7J5j/Pb/5uJlECs4l6DZ8ejshix2wXj374RTEjVGcR1o/vsOmX0bPIOj8bZ/FTPXCHEBc/EuA
 stExZGqN5CYlqEtZ6lUgUgURcxhJ9KI0U9huA==
X-Received: by 2002:a17:90b:164b:b0:37f:fdc8:71b4 with SMTP id
 98e67ed59e1d1-396d0e27d7amr32631881a91.2.1788121637583; 
 Sun, 30 Aug 2026 13:27:17 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd5c34sm17683165a91.8.2026.08.30.13.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 13:27:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 8/8] doc: add bonding features matrix
Date: Sun, 30 Aug 2026 13:23:50 -0700
Message-ID: <20260830202636.760014-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830202636.760014-1-stephen@networkplumber.org>
References: <20260708174204.72574-1-wpan3636@gmail.com>
 <20260830202636.760014-1-stephen@networkplumber.org>
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

Bonding was the only in-tree net PMD without an entry in
doc/guides/nics/features, so it did not appear in the driver
overview table.

Add bonding.ini covering the features the driver implements
itself. Offloads that are only intersected from the members are
left unset, since those describe the members rather than the
bonding device.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/bonding.ini | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 doc/guides/nics/features/bonding.ini

diff --git a/doc/guides/nics/features/bonding.ini b/doc/guides/nics/features/bonding.ini
new file mode 100644
index 0000000000..79bd47d3f2
--- /dev/null
+++ b/doc/guides/nics/features/bonding.ini
@@ -0,0 +1,28 @@
+;
+; Supported features of the 'bonding' network poll mode driver.
+;
+; Refer to default.ini for the full list of available PMD features.
+;
+[Features]
+Speed capabilities   = Y
+Link speed configuration = Y
+Link status          = Y
+Link status event    = Y
+Fast mbuf free       = Y
+MTU update           = Y
+Promiscuous mode     = Y
+Allmulticast mode    = Y
+Unicast MAC filter   = Y
+RSS hash             = Y
+RSS key update       = Y
+RSS reta update      = Y
+VLAN filter          = Y
+Basic stats          = Y
+Extended stats       = Y
+FreeBSD              = Y
+Linux                = Y
+ARMv8                = Y
+Power8               = Y
+x86-32               = Y
+x86-64               = Y
+Usage doc            = Y
-- 
2.53.0

