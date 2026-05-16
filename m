Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BCFCD4F21
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 May 2026 12:54:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E3CD4042C;
	Sun, 17 May 2026 14:54:17 +0200 (CEST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com
 [209.85.208.178])
 by mails.dpdk.org (Postfix) with ESMTP id D3A7840281
 for <dev@dpdk.org>; Sat, 16 May 2026 13:08:32 +0200 (CEST)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-393c93a01abso8487661fa.1
 for <dev@dpdk.org>; Sat, 16 May 2026 04:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778929712; x=1779534512; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fA5bdu5O3LAXniePs6EdrsfPg8boZ/ZF7aqvBDZBydQ=;
 b=EZvOzPMjGulB0EdxoqjUZ6e7kVzTnsa0XXjZZp4PNnMayXqyxcPvaFVWdk2fv0mxOJ
 8GVDO6PyIppgfUlzlgwsj001pqCu3LrK1+ClsKjNxYbTM1sHUrzJo51skKdEh7jXGuii
 09G4XvAZa9iDqnL4uN8YImtiiC+O9zqNl9GdpR8LPJ7ecCyG54g4Pong3wMcJ0DyXA04
 KaacBNAB8VEgfoKqR2PyhW8BjmDFTW8trAYmfiL2bbhyAOsJkuyjc+OFjpKoPjr1/n6A
 gARgg4nzcYD9GlU0TLyi7lDpjqA+K5V8mN91VxwqxCasfSPceGW1+O8dOdO7h43tYsCd
 rzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778929712; x=1779534512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fA5bdu5O3LAXniePs6EdrsfPg8boZ/ZF7aqvBDZBydQ=;
 b=TY+VAZnmC9eALh6pzQZ1rFc96ARt6st7GmHVlvAtb9EyFOZoJSc4bcVjPsp/X+H3hg
 HfKA1Mt37VrZuY9PDHAayiMEOUdZzaCN3U9AX3p0+coC29/yrPisbDY6SUg/Iw8rZUdP
 yPghK0rcRPCAUmJfI5OT3cCA6iGSoYdTopVc2ZkvwmnSk88lKqtISeXwPoTV9dALSCP1
 Azqia97khJOIjQmkvcxjfA5UtjPX4EkL+D0hw/+nH41y/TfI2F4GIPMP9x860VUJLQtb
 yBnztK1StiflCvDkq2sHwroY+voVhxpy5VfenX4UGCKTy+Kmh7CENKsBNSuJHXC2nyIO
 o2Bw==
X-Gm-Message-State: AOJu0Yw8FiQNim9ZwDcsH3rjotKUANFv13J9VeCBimVksKg3sbyoLwLQ
 eSWTi7XpnO458HW/2Gbs25lsqiqT0oJpe7V4q2AySNhT9KDwCPPWKVJNq2WpgQ==
X-Gm-Gg: Acq92OHd0Jp/jC3BwCOWCvU4X2dOHVT7WlAkYc3rjli4yAzXMhlfggXNrM2KG3tgpDd
 IOqcrxcwCy13j6es05pvAaGSwIn9ZX50W6s7TcIu6ye+rQrgZPbVOrel8ZxZeX1/boZxxSx+zcJ
 Y/tRdcpyOC7GMqE8fmiqyH6+nvklPB7WySbe3XJ5T2n3jB/1D/0zVVCrvOwpNWCPL2bOhF+LTtq
 pBvJLVMxHKlEyMMwjyeSwBxb0QWfKGJ/ZFrtd5tl+OpwF7o97qH93qU3o8ae3BmqTX4DkIWF7Hq
 tjRd76eDJQPqlVXF7Zi8p6FExigRtI0/i9pt/dH+m3w74UPkMi6P1nMccyM/dO0ymuiZyE6SINX
 BOwN6baoAiGAc1p7n9dANba23MsJBtDIztr1U4TQJaGMlxVxp4USVYMcew2uDMaTQbszqMozFAa
 Q6N/tMoCYpEGEbhk6YohZanjy9IQuE4P+qbabI2SJA+8KSMYfPaSGxXDqMKMVf3A9hA7k=
X-Received: by 2002:a05:6512:1094:b0:5a4:175d:21a with SMTP id
 2adb3069b0e04-5aa0e600e20mr2245307e87.2.1778929711728; 
 Sat, 16 May 2026 04:08:31 -0700 (PDT)
Received: from Shofiq.home (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164bc518sm1954416e87.39.2026.05.16.04.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 04:08:30 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	stable@dpdk.org
Subject: [PATCH v2 1/2] bus/fslmc: fix ignored return value in fslmc_bus_unplug
Date: Sat, 16 May 2026 14:08:27 +0300
Message-ID: <20260516110828.35701-2-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260516110828.35701-1-shofiqtest@gmail.com>
References: <20260516110828.35701-1-shofiqtest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 17 May 2026 14:54:15 +0200
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

fslmc_bus_unplug() called drv->remove() and discarded the return value,
unconditionally clearing driver references and reporting success even
when the remove callback signalled failure.  As a result, callers had
no way to detect or react to removal errors.

Capture the return value and propagate it to the caller.  Only clear
the driver references and log successful unplug when the callback
returns zero.

Fixes: b5721f271cbf ("bus/fslmc: support DPNI hotplug")
Bugzilla ID: 1914
Cc: hemant.agrawal@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/bus/fslmc/fslmc_bus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index cf881b3eec..57bb61dc35 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -620,7 +620,9 @@ fslmc_bus_unplug(struct rte_device *rte_dev)
 	struct rte_dpaa2_driver *drv = dev->driver;
 
 	if (drv && drv->remove) {
-		drv->remove(dev);
+		int ret = drv->remove(dev);
+		if (ret != 0)
+			return ret;
 		dev->driver = NULL;
 		dev->device.driver = NULL;
 		DPAA2_BUS_INFO("%s Un-Plugged",  dev->device.name);
-- 
2.51.1

