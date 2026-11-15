Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A494606A31E
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Nov 2026 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pbBAb8mz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A7534025A;
	Sun, 15 Nov 2026 19:58:11 +0100 (CET)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 1E9E3400EF
 for <dev@dpdk.org>; Sun, 15 Nov 2026 19:58:09 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2e9d7791b00so28036195ad.0
 for <dev@dpdk.org>; Sun, 15 Nov 2026 10:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794769087;
 x=1795373887; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fHsDi1Kfp2nI0EXM/+1Nk2gOZVuGrgJdDnlBTnWyyis=;
 b=pbBAb8mzNTpN/njwb4zC5FWpP0oSzzi8EV0V83K6B8o/uIqO0HXaBc8zzKLELmyNr1
 ssb/9aw9rjPu7KBIg2sESHCLaZ7qo4wO6GGE+bqtzau8W7xW4Ba5eZf7yj9JHw3mHnj6
 r9yjEj6PyqCfVpeSa0YpAekxfChyq3FR0mxIF9V/T9aBEuCsK7/Ly8FpZeTwsVqirNfB
 /s7zJ2cGM8xi29ky9F4Z1G3KcMXnxQCJhZ6pK2MOnHjy4ol8gXg/V96MXXnqzORxEbzj
 XpDi51tu/Y7xSR1eOT1uvBTnzeJr0LDtrbvsVFjlgKAsqiWYhFJWoYN+IC7heqP9sTMc
 vN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794769087; x=1795373887;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fHsDi1Kfp2nI0EXM/+1Nk2gOZVuGrgJdDnlBTnWyyis=;
 b=JrsWF8Mck90VtGA5O77UtBj3i2jiP+D9HdRnXneNEH+wdxbtht45GT6pw8GDPggp8j
 jip1iuUAw+/dDbaaf58l4Oq+QfpnQd3qsxte/RqiKl343HGfrRr/mS8M7yhfRSTMPxoC
 TOw1utgdc70rtaoJD9rWytNmYxHYeaxvkOi0stQ8oY7hN8BEUH1CPnsYO5G6v6xxGhRe
 UwKT+3VDlaztb6ac06o+qe8KAHYUSQAuVMpRABPafDXDMRD7PcM4iLOrpvjJA1jpayWj
 O74rUOJoIL7HTfkpbPqDKMYQj5CeiWkTWpZefd8Yvgv4L/0kfUO7D0BzRnMoFbiYp0vU
 A8dg==
X-Gm-Message-State: APuU4Z8iqAY5HhLaftvIhFg+swgb987buiEM1vfnmXz0kkDRYTerXmuK
 c2zWmMuTynBaGxzCK7JqEPyU6tJGQTnIxehF6zD/VzU7IXrHDlPoNiYnvRVBzjlBN/awGaOHJ2l
 ldfDQccY=
X-Gm-Gg: AYBFou2J3QVfBU2crWIATOP+gYmVBY0El82BSa8gLyD5oiwKi+HtTsYIcFU/kghXGPP
 EGETUtcXO4actMbIvkmN1fu4GRLUSoD1Mm6f3oiCHDMAqGe24DG4S8g8G35aydOOO1RJxvSrXaA
 mvE6QOAemmX5OUQPDvZwHXiwRHUw7MWVootk4epU9Gdup36QHu3KWTnblW7MMA1NvgcbjXUthj+
 tHIdNg+hFSKZKw3uR/H81xDdRsBzoy5asV864YfSXAUSL6CD0X2koUYjijmhIbwH5FkEJ2rvnAO
 kTZhHV+gGKxHpL5tBLZaFEbCdc8x4JhCbzSXnXCnuF8JQmgGNvKw3USgfyg6BnT4VwhDc+zILYA
 tkiJJaMaauNCCOH3IuymWFUiAptRchZZNckZiXt346kPbII1S2PqCVgURmRFTRmcLTiqrp9fTy5
 lAe0tTN/PwPW8JuPoyMLucfjx5nALhKFBLbrNHdw2xEQ7ED2GtTT5mrpsYMQClLlMozhDf/ExZd
 jpdle7VbKjT50HrVbf0JCc7ozcRPo6RgqJgOb/GCa8SNxphxhEgDcHZyrxfaTnJDi5mD6RXefoZ
 bLEVRLmP6RuKSof3RxHCdbmlOmkqiQsH7krHHSJfUMDjIa09M2QuCpow1Zr46IMUi8VvIsc=
X-Received: by 2002:a17:902:f611:b0:2e9:8794:8ce7 with SMTP id
 d9443c01a7336-2ee0dd1768dmr75037265ad.43.1794769087427; 
 Sun, 15 Nov 2026 10:58:07 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0f75b472sm28831795ad.19.2026.11.15.10.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 10:58:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com, Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH] eal: ignore errors from sendmsg on cleanup
Date: Sun, 15 Nov 2026 10:58:03 -0800
Message-ID: <20261115185803.347504-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Silence a warning from Coverity.
The call to rte_mp_sendmsg here is best effort during cleanup,
no need to add additional error checking.

Coverity ID: 507471

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index b70e9189a4..3e1af1325b 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -717,7 +717,7 @@ rte_mp_channel_cleanup(void)
 		memcpy(&msg.param, &req, sizeof(req));
 		msg.len_param = sizeof(req);
 
-		rte_mp_sendmsg(&msg);
+		(void)rte_mp_sendmsg(&msg);
 	} else {
 		rte_mp_action_unregister(EAL_MP);
 	}
-- 
2.53.0

