Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6A1606B5C4
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vtGfEDGx
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 415F7427D3;
	Fri, 13 Nov 2026 17:05:53 +0100 (CET)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTPS id 51A4340268
 for <dev@dpdk.org>; Fri, 13 Nov 2026 15:14:14 +0100 (CET)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-53397554beaso18173941cf.3
 for <dev@dpdk.org>; Fri, 13 Nov 2026 06:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794579253; x=1795184053; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Rpabl3qwnBu7SEqutbTGCllEFQ8Fr8zyrnHO1wPi1/k=;
 b=vtGfEDGxk3t9+3BVxUA01AaZGoqrGo+f0+g4wMsIHrDZJa3fNdZ3HN6u6ibK0efbgZ
 pbLpMmuiSLoQ8AkRSj56oeFDWjL1arpq2gEFXEAJvwYE/aah2wKSGCdJ+saMAIQEHPIz
 IC67BabJid+knwsF8QswcHQCWSAsSBdA9tSxq8O7elKrsBULEwE18KNY3Dmbo3W3TPiV
 4hBihfGXyOmchqCtGxUMg3b6fhrzX2cGOa/fQ0pPdF8vmm3UJjCjReLMkE51cc5G6zan
 BrvgYcD67AgzNHv7M7aE2qHt4buobVp0cmRhOrgWAKG7jcADyL0n1hhSr+4q4CRay3uk
 wSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794579253; x=1795184053;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rpabl3qwnBu7SEqutbTGCllEFQ8Fr8zyrnHO1wPi1/k=;
 b=QJscC1fuES3XKsEqv/K7WjDX36CaaCD/N/68iqET7RKk86AKXLz5+QjVmGQq3YNqBJ
 nuZG9wqbMpf+28Pq9hteZg07kwoiAz8wX78PPS9yLvZ8qUdQ7xa9Nz6W//UvF3t3ZrjI
 JRdtBbUAbHwWEOwc3uRkr12EUInzAkvNDI3CkubZ5/LdHFGWOJt9TD2oOetC0p85rtav
 7WcvI8wXzABhro4DNZxt8M5vv2V4Fz3TrMsTfaPBApQsXo3IDrHziYQkuhHcJ2Ok3EIm
 0v8QiVF7PTTabffKIDL2SXtGXIKnAGyGZxJuGEDxzdWJ0lyeSL8WYT74Dmj/yFaB/tz8
 zqHg==
X-Gm-Message-State: APuU4Z+J1HqdMW11iUYFzkWQxDSfsXdhaWrTmXgIbC0d/fSjRyH5AQeW
 k5Lm1U8lDWFHLx8/DsbtGnTDxYjzLsGgtpTE3kTta+VDLFW/Kr3wlMUj
X-Gm-Gg: AYBFou0TGb11VW91BUghsXUqZlsV5KEgPIUMl5Dqvwwy86h6wmwCEjHrv8cWp8AX9hR
 Gbs6+hRb971dOuyHn5GEVY95iNXB3Tv/WMXiPsvcndzUQgmi1CfYI2WbaASy8b5rifLGh70OJrI
 D/Q8oSpJZT7sXYh0E6n6DU8yFixH4WoyYl32JgGR0pT/sjz3RUkPXW6Ufr12p5lGdlfRrgABJzP
 7sjUbHIN6GWs9yzJXfWfcl4Wz3xakFEw0gNOwxArQ7ksA3Q8m25MNDTiq+Jz9V+IHT96zDJpYYJ
 uhfg5HVl2Mv9E7EDYRYT0FGmUAvZdiikqloGU9QG1Ihh7E/8QBGgcXI6yH3UC1AYWVBfHhc6Zj1
 u4oA6jPjD8hMQ0mCVbvB03+j2dH3rfXKB79rv2dVsI71leS7yzONjDD10leoHrcah1LyiZE49YD
 lfb2SrbFnNAuQsQT1EL0GjbQQE38U3l6P4bLLf9p8Pk6QEZBnlSVWimP+Iov8fIHcACvyTsz3w7
 00rBjF0ZSTyhQPbkvHk8mjNtc1h/HXCIBFvYPk5TJUWqFitTh/uzH7tabW6Hxco9UMwPW13dun1
 CbBiOjCoue6iZZ7mqcjEQEsCx1OMtJ+zsQYv1bT/eXC6Wujmod9TbLZzg31Lb2HNpfpu0A==
X-Received: by 2002:ac8:5991:0:b0:532:cacd:e420 with SMTP id
 d75a77b69052e-55ac3363706mr42720531cf.6.1794579253166; 
 Fri, 13 Nov 2026 06:14:13 -0800 (PST)
Received: from localhost.localdomain ([85.172.76.155])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55bd520d5a3sm3557091cf.0.2026.11.13.06.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 06:14:12 -0800 (PST)
From: Bulatov Mark <ms.bulatov7@gmail.com>
To: Jack Bond-Preston <jack.bond-preston@foss.arm.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, Alexey Simakov <bigalex934@gmail.com>,
 Mark Bulatov <ms.bulatov7@gmail.com>
Subject: [PATCH] bitops: fix integer overflow in align64pow2
Date: Fri, 13 Nov 2026 17:13:07 +0300
Message-Id: <20261113141307.4727-1-ms.bulatov7@gmail.com>
X-Mailer: git-send-email 2.39.5
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Nov 2026 17:05:48 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If the function rte_combine64ms1b() returns the maximum possible uint64_t
value, it will result in an overflow.

To avoid this, add a check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 7253e3d2a5 ("bitops: move bit count functions")
Cc: stable@dpdk.org

Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
Signed-off-by: Mark Bulatov <ms.bulatov7@gmail.com>
---
 lib/eal/include/rte_bitops.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/eal/include/rte_bitops.h b/lib/eal/include/rte_bitops.h
index 45255b68aa..d2ed0c3c61 100644
--- a/lib/eal/include/rte_bitops.h
+++ b/lib/eal/include/rte_bitops.h
@@ -1307,6 +1307,9 @@ rte_align64pow2(uint64_t v)
 	v--;
 	v = rte_combine64ms1b(v);
 
+	if (v == UINT64_MAX)
+		v--;
+
 	return v + 1;
 }
 
-- 
2.39.5

