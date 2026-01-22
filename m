Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7ACC44508
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 00:54:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7D2040DDA;
	Thu, 22 Jan 2026 01:54:22 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 62E9D40DDC
 for <dev@dpdk.org>; Thu, 22 Jan 2026 01:54:21 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-432d2c7a8b9so310568f8f.2
 for <dev@dpdk.org>; Wed, 21 Jan 2026 16:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769043261;
 x=1769648061; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A0C0PUoICdF2ytsLyWg/pUGlwI2LM+IYHwU1tNSHxo4=;
 b=fCVhRyOe7cglE4D8k+vxNpSB2dFFoMIGQ+y3/0Mok6T3NpXyA9wjghvt+AYppBJ2HF
 TWe10JTBsvb7CtWb9FJjDtfHlQMdP5H2eizwER9EB46UPb/ABqD/QL6C87zz074pusHk
 /41pS08g9XJA/gsmzHuD/1I36JHADd+Gg2JTSa69NxGIGTAiWH9EoaKZ/yCxEbCg9Qwd
 8oEzUhS6+VHMbRJG22+m/o+eIZVV4sBoQakFEnzwQAziI2TDa44h9GcBpkNxQtDdrP1S
 POsd3A6XkWWeVyg0FjR++DhEGUpycHalGuMSHRzRiJjFFiWUDnVlmnvI2WxkXZ8J1ntC
 8huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769043261; x=1769648061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A0C0PUoICdF2ytsLyWg/pUGlwI2LM+IYHwU1tNSHxo4=;
 b=gNle0V9TryQH5plD5zKLHOi0OTg7F6N0cjKpNr4kEcPpSdxxTjeBRxcmTrNtuS3wvU
 1e/O83TRjnQpP8T8ze8vu/GEsoPTWZydtKN1KNKFmKH+5uV9MY1YQ2iLMiN6CP1xZYhT
 0ONXWahXpDGM/JN5TS8myw1aZdiWctotro6NUEilLXFHhtKDElsHRdIF/3FpQqAYZK7W
 a2mcSvzhOSFShprjSCZpOijgUzCXUfKJtkcyjz4fruessBDS+tfr8VlD7aZgOVbYku/M
 UG3OdEuy5Eyv121uEHWSalxhlnhs1ByqTkIVC/97wT6CrNbbTPuwet0ATYJArUylD8kK
 o7vQ==
X-Gm-Message-State: AOJu0Yx6PsUqyVZwLudd8n4Z4fPVsMV3C31GuSdHx4RKSBmhBNDSA98E
 GOAPfmrCz4RqUMGq5o9F1eQ8k/lxcR1c1siPlSRtfmA0VJWLDMeB9hHM0GB80E66e80coVvm1G4
 6s5X/
X-Gm-Gg: AZuq6aKrkmDDzd3cN/rLdAo6vb/nLCS06bpjsCzv16ufzsz8fWdmyQ2i79KN5tgIeS1
 StBT2VQFEamqoA7QW2rqBx74JTaMItOrixW0a1oz6qtfvbNdbtjt0Ap4C/xbdTLDP22eBappWUc
 0DwhtiSMSMZ6XNinRqeYDLfRQqIT56NjPI0nTD50I4JtK875tCemcIa0eWqcqoDlXsNuAV1i3u0
 frkXmNHWtnPIYSE+RwJMRC8CsMydAW/7DdEesjmeaUm0LWiMQHcE1+Mc+f20aiDIQ0dfc7EqkxR
 r6CIQSDOO2nI/k0Y+IWMQX0mwE+CjXytJTZWLEh/Xy1rLEEmGEMR8KNYPjYmatr2RfdOe8EEjb3
 0XtP/Fp8OmfpfgO0diyhYSVmS4C4ZcxPSOaq7ozsNHCJmPYkSOqDTbrReStziAtaKfqhdLdKOdj
 zTUFC+AuE7ky9PN2tpOqMD7G2f29sI5k58JE3dg2/DY95TZaI7Bw==
X-Received: by 2002:a05:6000:2383:b0:435:a194:72a with SMTP id
 ffacd0b85a97d-435a1940e52mr5553886f8f.3.1769043260921; 
 Wed, 21 Jan 2026 16:54:20 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e6dasm41695104f8f.32.2026.01.21.16.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 16:54:20 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v3 08/14] test/bpf: skip ELF test if null PMD disabled
Date: Wed, 21 Jan 2026 16:50:24 -0800
Message-ID: <20260122005356.1168221-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122005356.1168221-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260122005356.1168221-1-stephen@networkplumber.org>
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

If null PMD is disabled, the test to load filter can not work
because it uses that. Change to skip the test if setup fails.

Fixes: 81038845c90b ("test/bpf: add Rx and Tx filtering")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_bpf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 0e969f9f13..8bf783c00c 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -3441,7 +3441,11 @@ static int null_vdev_setup(const char *name, uint16_t *port, struct rte_mempool
 
 	/* Make a null device */
 	ret = rte_vdev_init(name, NULL);
-	TEST_ASSERT(ret == 0, "rte_vdev_init(%s) failed: %d", name, ret);
+	if (ret != 0) {
+		printf("rte_vdev_init(%s) failed: %d:%s\n",
+		       name, ret, strerror(-ret));
+		return -ENOTSUP;
+	}
 
 	ret = rte_eth_dev_get_port_by_name(name, port);
 	TEST_ASSERT(ret == 0, "failed to get port id for %s: %d", name, ret);
-- 
2.51.0

