Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62E3C83F26
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 21:38:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C20740698;
	Mon, 28 Jul 2025 23:38:27 +0200 (CEST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id 362B44066F
 for <dev@dpdk.org>; Mon, 28 Jul 2025 23:38:26 +0200 (CEST)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-707365f4d47so3888596d6.1
 for <dev@dpdk.org>; Mon, 28 Jul 2025 14:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1753738705; x=1754343505; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wSy+xIOXGF6n9s3M8JfMO3m2tBKk0kEll7PYqljAoJo=;
 b=YGIJ8kvUNikGu0Ym+FnA70vSRIkjYe/8FMruepopewuf3CsiNLWcZtrODkS/hQdBHb
 SFpO2MoeKwKaVwpUwKaMSB1o/lM1ihc1Z9m/6yp76SxLJzS5/RrZzC5KoBjyOFctJdEV
 56l3/yuongsQeuuJONdmyu1aLHFK4VquMO43I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753738705; x=1754343505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wSy+xIOXGF6n9s3M8JfMO3m2tBKk0kEll7PYqljAoJo=;
 b=FL5CvI3j7u/E07ziZsa9UtxheTUOv22xfk+HTpeNu+Pm3gWsH/UBtI+0Sn0tIGXfhy
 9wNFiMNDbiJpd3kdkzeegtDm9OISCjKm/7gKXR6am0GHcfux0pd0HsFb8qwWEE1fMq23
 WHR/uoiXSDlzuxIImO2yUne+Eo1SW6M/OogqKpKtIQBzJ5rVkZz+jgzK4VutU6j48+sZ
 4Upsve+R0mnQGqeBK0qaBkRl/Bb/byfk2l5yZ9gMIS+k37MUPIkYnVBzAg0UM7i871aX
 nfsaxntyASl1Y3WI3EtiKaRjPfHVsdlIiWmnFfpRGFg6dHicK7vt4bowi0aOkjvjcevt
 YJog==
X-Gm-Message-State: AOJu0Yy/ePb6WHJLTlFSZySxqQQtKbyEycz9LIlbf7tcz3GZZKYjdcUW
 TNhxM/EVIBxv1xS0wGM0OR0XqZWGS+/5kd1uX8Fg9lwl9YlV43FkmQiw/AHXyF3ibFI=
X-Gm-Gg: ASbGncsMTY5YDMb4gdG+ycQhO04f1foGOk78Hn4Uvze2Bk7WNEYpluWIrcwCN1koVSd
 Sd2Tn9pM8hl/sDvnCM3epENUKukprHyLwFdPbPETRLAIX04/YEsrxj4kq0o2xwZZLKJBspbsNgO
 6s70nkgRk9fQNOG6loSdo9FxRjqQQjwyXTmi9f/SxGqFLZq/qQAj61INg8QDYrUM8Kq1wVEX9sC
 81e+PgXEfQ4xnAnVoer1XYRJeDApPR/zIGa2QzYxouailk/L6fEauKPjfHVID5LGQcdGQ3aWGZS
 4dGj10bC2mzGhnudnarM6cFI2zEU2HCCKpzPMYaZp6+dLd1vGFE2IVColh0/sPaV4yxwsBapgf6
 gPShaTU1O18U5BUR7j/lBeYc=
X-Google-Smtp-Source: AGHT+IEiePN5JB8pRvBXhqzXBoLwE+ezkdo9MGg9LGEqEPtUBTrSYzud8G1WNDL5ZU9Kv+yoPdCpBg==
X-Received: by 2002:a05:6214:f65:b0:707:3c3c:39ed with SMTP id
 6a1803df08f44-707571149acmr18370986d6.0.1753738705401; 
 Mon, 28 Jul 2025 14:38:25 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::221])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7073b81606csm25325816d6.54.2025.07.28.14.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 14:38:24 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Luca.Vizzarro@arm.com
Cc: dev@dpdk.org, Patrick Robb <probb@iol.unh.edu>,
 Luca Vizzarro <luca.vizzarro@arm.com>
Subject: [PATCH v2] dts: call hugepages configure at node setup
Date: Mon, 28 Jul 2025 17:32:09 -0400
Message-ID: <20250728213209.1834486-1-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250725200553.1262542-1-probb@iol.unh.edu>
References: <20250725200553.1262542-1-probb@iol.unh.edu>
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

The node class contains a configure hugepages method to be called
on the DTS nodes if the user has specified a hugepages config value
in their nodes configurations. However, the commit referenced below
removed the code path to this function, making it unreachable. If
the user has configured hugepages already via kernel parameters
this is harmless, but if they haven't, this bug will cause the DTS
execution to fail. This patch adds a call to the hugepages
configuration method at node setup.

Fixes: d77a4a27bd24 ("dts: remove node distinction")

Signed-off-by: Patrick Robb <probb@iol.unh.edu>
Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
---
 dts/framework/testbed_model/node.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dts/framework/testbed_model/node.py b/dts/framework/testbed_model/node.py
index e6737cd173..7c5a35e0dd 100644
--- a/dts/framework/testbed_model/node.py
+++ b/dts/framework/testbed_model/node.py
@@ -76,6 +76,7 @@ def __init__(self, node_config: NodeConfiguration):
         self._logger = get_dts_logger(self.name)
         self.main_session = create_session(self.config, self.name, self._logger)
         self.arch = Architecture(self.main_session.get_arch_info())
+        self._setup_hugepages()
         self._logger.info(f"Connected to node: {self.name}")
         self._get_remote_cpus()
         self._other_sessions = []
-- 
2.49.0

