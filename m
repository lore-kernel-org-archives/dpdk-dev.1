Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69750606A335
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=N1nDqAPs
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB9B740268;
	Fri, 23 Oct 2026 17:41:23 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 3659640265
 for <dev@dpdk.org>; Fri, 23 Oct 2026 17:41:22 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2ea1e7fad99so5042755ad.1
 for <dev@dpdk.org>; Fri, 23 Oct 2026 08:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792770081;
 x=1793374881; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eSPoppLxZpsa/xth6NtZh0qIUyt7sogm2MX95GLXohA=;
 b=N1nDqAPsq7EmwP2J6yvrwjnaTDzryS9QOBF2mRIJ/Z0bLQyaDGfTG4Sq4QNWOfrzsg
 LfvKlvCkcdU+L+nLiOdOZLUFylbkuY4vaRUT8GKON2k7P8KKacLHvUA7GsN5+xteTAiQ
 xO1zYRwigXQXypg77U15YL1qXwRefn2zyEyB4ldawnIj3p6yfzYpWQR9qsXOGtHV5JtS
 dA7g2uU/wSO93xcAYsQdQYlYEr5ayHkkMDpcwfCJZivXGtS5hB0prINqQanfDMg0aTwj
 TjWlKYpXs4rSKtAElMAL+jHlAc3tFFjjKYfJfw9W3thY1AtCpyyFdxbsy7YXgy2yTzjk
 Kb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792770081; x=1793374881;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eSPoppLxZpsa/xth6NtZh0qIUyt7sogm2MX95GLXohA=;
 b=mRuaQfAIv/IPYhlv8gU0uBf/rOhZZeFZ4bCd9li92ioU75uao3Wdoonp7VVR0Ua1yN
 19MIyylhRyGOofY2IyP5yWE5O2/GYxVDL5fhmC2Oe/2GpL3F+BZWa31sMK9G7LRIFx4B
 MZq0/ABOe2x/8KnXUgdLd+JqpwZnxyu7Bk6gjYM7tLPv4RkJG6XYJKNtmOHlcfdzwr63
 i/nDC/D5iIvtY4dk8t1ZCr2TD1T09h//pqniCmbv5j2Q+ZFxnduEryluzKDRR/qFpprk
 2D+Esx0yCeaSNgH2px+z6xZFFukb4FqPTP9TmW0EZLKMrXMzWle0e91Oseo+2MxgWKLs
 QavQ==
X-Gm-Message-State: AFq9FYIPxmIuPyGYOP8f6Ko1scwSgb0HHPOLPKzCh8C0o34lNUIDsCHP
 UvIPDS92dlpmIQKFcftYNONthSqqgWDX8eYWPaVFPJ6l3cp67Yb4de+CsR/wXoKvZ7bcZ4jZzGf
 H41ZoP1I=
X-Gm-Gg: AYBFou3xpoplp401Z0afbzIJaFaeABPDLpiFR8BTRAtW0f+eNRttyTUoRV6KR/tHRiA
 kNKgVhrMLkcDuRDIVLbfM/WUGG57WxKNJI0dFIOGC5HIiASd172SrqJmXF8Pxm3ya20chfQUqqv
 bfWz2r2FGM+aSFCBqONdB+eNLNVzkxG5Sb7WVW6E21LWUn+9T8Fk4XnOgw8QaFodkL4uHAVsfv+
 UJTCmvr/3i11YoHejdimhnjPK4AihkCHsAuy19PHcmgZHLYpsnGEd9IabDeDoMDA8GXSBT5ezYX
 /1I7pmgJki08rfrkwXK2XLKcFqifL5x7T5yfdl3QXWEQOM5LfJjiIamPlkbo99K080Wd3hh4Xwb
 Nzn3nhkASRzKSOMo2yPVWMGTcSOpbPmGeSoOVSLUdXe0fnsqBe09Cjd9VVHHRb3FueNQ7FE+SlX
 C+F773cFUuDiy5ZGk4mwLAOTeyUrucq1acJfkntGmQ3898vLa6cqinNZ5y+lmEXaFGBvM3ADbj+
 tinlv2qZACvHXd6s/PKjZZ5jPM3JNjRNWe9Dz+2UqSySQShZcLoEBAtbno1rnob4lYFITTFFEoX
 juLF8AZWuHAL5rXTOMQ=
X-Received: by 2002:a17:903:3247:b0:2dd:ad73:5b68 with SMTP id
 d9443c01a7336-2ea7cfa1b58mr24286515ad.24.1792770080893; 
 Fri, 23 Oct 2026 08:41:20 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea9467750esm2157505ad.6.2026.10.23.08.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:41:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH] eventdev/vector: fix adapter slot search
Date: Fri, 23 Oct 2026 08:40:34 -0700
Message-ID: <20261023154117.253645-1-stephen@networkplumber.org>
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

Building with clang and enabling option to find unreachable code
found this bug.

The loop looking for a free adapter slot returned EEXIST as soon
as it found a used slot, so only one adapter could be created per
event queue.

Keep searching; the existing check after the loop reports when
all slots are in use.

Fixes: e12c3754da7a ("eventdev/vector: introduce event vector adapter")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/qede/base/ecore_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/qede/base/ecore_dev.c b/drivers/net/qede/base/ecore_dev.c
index e895dee405..6e76ac9c2f 100644
--- a/drivers/net/qede/base/ecore_dev.c
+++ b/drivers/net/qede/base/ecore_dev.c
@@ -1544,7 +1544,7 @@ static u32 ecore_hw_bar_size(struct ecore_hwfn *p_hwfn,
 	if (ECORE_IS_CMT(p_hwfn->p_dev)) {
 		DP_INFO(p_hwfn,
 			"BAR size not configured. Assuming BAR size of 256kB for GRC and 512kB for DB\n");
-		val = BAR_ID_0 ? 256 * 1024 : 512 * 1024;
+		val = bar_id == BAR_ID_0 ? 256 * 1024 : 512 * 1024;
 	} else {
 		DP_INFO(p_hwfn,
 			"BAR size not configured. Assuming BAR size of 512kB for GRC and 512kB for DB\n");
-- 
2.53.0

