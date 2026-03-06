Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75314F01835
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 13:31:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2EA442791;
	Fri,  6 Mar 2026 14:30:57 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 194E542790
 for <dev@dpdk.org>; Fri,  6 Mar 2026 14:30:57 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4836d4c26d3so73136845e9.2
 for <dev@dpdk.org>; Fri, 06 Mar 2026 05:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772803857; x=1773408657; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZTtwVioK0vfv0TXObAuh4xeoepqtX41E074SpvnJemQ=;
 b=MOcbstMHTx+oOBSsO5Klxnfk77YYVNXgfWz58acW/2Uos1kADKzfkl+W6cK1nyNiL/
 b5R955Is+4VyJeZZCYZw+xxyYjl7ABz+85UqNfzDqkTL0o2MuOcRr4d0s/d4w5yavui5
 jB8ect5GLxcfZSJHeJ/11ruDpGzQcq1lIyXK+cS6+hdZw+YuU0c8OS+m7FR+QU5B5pUF
 lGYI0L58Lkna+m3Z/0sk7eqPWNTGQvGK2zAYzaBKi0+UhlW2PnqX4mylku+ktJzcSYAK
 pFlt3ZCUe/T+u/4kD5nfKFuJ6yPG0Jgz+tMp+J0SuAUn8faPjrEdDhjZceN79WQRq1w5
 39ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772803857; x=1773408657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZTtwVioK0vfv0TXObAuh4xeoepqtX41E074SpvnJemQ=;
 b=nK19zYE/2E8REXQ6HYwwVN4XOF/e17L6fcyUmyriDp/inrLilb46+HQPXwYfj+hZ0G
 ZGQqLXYEROmqCPRld5NhecbUq8iA3lP6u10+aIR5QXVsGzXnsgt72u9XQyE4sXFZ6KZf
 nbid6IGKP7FpWb43V3tUcLpkGLNTqRykvVJBfTewGKXBt1TOsX9Sujmn3GUOV3MnTdvs
 V7NDYeNU+uR3qky966XqD3lSBK4Tw+JrN1m1UCUm/HwvInXJH+CJw2fGES2YSef+omi8
 sxxQBlwW3zbbqJQPPrIzCvfFFEYgOLPBb0XQcuIRucPbAx/05kTiA3jWsPnzrMp0JZ1b
 U0dA==
X-Gm-Message-State: AOJu0Yx3E50FPftZ6jVVZKzneLuyxNH8arZ/rY3luXs+oMQdnEVXkD0h
 CDnLsy4EUACt1tMFq0HHPx+whxZR8d9yZ0oUf/8vfIWaq2+JU9HQV+LqxZ0hQwXy
X-Gm-Gg: ATEYQzxlENF4N+YVb5yu+s5c41fchsc6OxQ7sKZn5iDRNIjolZD6Yz3kWtQJe0jjBBD
 5vITtYu/iR/mlDvIN+HdjnVbFOX5az8WH0k/hU9jvIDu+RIjoc8EUrT8tUK98TDY0zIyXJ/keNf
 mjKULArtY1oC8+i2e0fOFAclllSuqakQxJGUy9SAv05TqKShddo8r6B15jo7L59IK5iK2EniBl5
 4kGhWBLv4MelDbE9y2xc+9FMkPJfxC2MLzxa8M2dUSyCI43jMN6U6kJaSUGP2trgCyX/Dwl7ynZ
 iI7QXCET8o+DtlmNf4ICN8ocaVFaisgSuEU6ouG2FZZIrPaelk28gOHLTbWCZN61zqHaEO878lL
 iF2305yNQpokBYCjzNU5fxsYYQvlUB6BfsyDu7Xd9Ylbq+wXrSDa28lJ8R9ZcHQQkiQl0A+ayo5
 FUuxXYQI8cfZbcOcDpBDsT/iKSYN4=
X-Received: by 2002:a05:600c:3acf:b0:483:6f37:1b33 with SMTP id
 5b1f17b1804b1-48526978d48mr35797745e9.30.1772803856602; 
 Fri, 06 Mar 2026 05:30:56 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fae02a8sm179175255e9.5.2026.03.06.05.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 05:30:56 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v3 06/17] bus/fslmc: fix devargs not propagated on hotplug
Date: Fri,  6 Mar 2026 14:30:24 +0100
Message-ID: <20260306133035.179709-7-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226143341.282188-1-maxime@leroys.fr>
References: <20260226143341.282188-1-maxime@leroys.fr>
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

When a device is hotplugged via rte_dev_probe(), the EAL adds the
devargs to its global list before calling the bus scan and then probe.
However, when the fslmc bus is rescanned, it returns early without
refreshing devargs on existing devices.

As a result, PMD-specific devargs (e.g. drv_no_taildrop) passed
through rte_dev_probe() are silently ignored by the driver.

Refresh devargs from the EAL list on all existing devices when rescan
is triggered, before returning early.

Fixes: b5721f271cbf ("bus/fslmc: support DPNI hotplug")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/bus/fslmc/fslmc_bus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index abdb0ad50d..d058441a3f 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -322,7 +322,11 @@ rte_fslmc_scan(void)
 	char *group_name;
 
 	if (process_once) {
+		struct rte_dpaa2_device *dev;
+
 		DPAA2_BUS_DEBUG("Fslmc bus already scanned. Not rescanning");
+		TAILQ_FOREACH(dev, &rte_fslmc_bus.device_list, next)
+			dev->device.devargs = fslmc_devargs_lookup(dev);
 		return 0;
 	}
 	process_once = 1;
-- 
2.43.0

