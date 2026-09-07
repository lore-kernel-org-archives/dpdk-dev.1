Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D309EC79FA0
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 18:26:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4A3B40B91;
	Mon,  7 Sep 2026 20:26:16 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id 02E4C402E8
 for <dev@dpdk.org>; Mon,  7 Sep 2026 20:26:15 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-8525efa7274so2486267b3a.2
 for <dev@dpdk.org>; Mon, 07 Sep 2026 11:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788805574;
 x=1789410374; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hYf5Klg9ejdL8G9vG3euAbDtpXpMQRmj76MnxFPaMOc=;
 b=g0oYysr14nh+xNW7ALKthRponXPg8lWd1jSursJS055VfhK5y/ambZkmyO5e1URzlb
 vmrNLsTpdedekCRYlnbb2hDk1j9VVHidxuAh8P1DHIpUKBcEO7GPATSou3+Ou3UxSySl
 J7xlBgutBJMmps0RcEn6LD1p5Pi5gOqn44XO3KtDtwW1XWHlfOP1Gj26+Avw71ASSgZX
 8uqAD5o8J1uP9kBVYGXt9zcZ25eK1TqZgDiRJAoaJTaxb9a3OGbWiC4AlYaejqWSK2df
 IBLBt8HZUtnEpZ8JiVr00DgHk91QvjbYYARVEdTPiLEVt7XfrYMmOWsEcwYThqmb03gF
 lIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788805574; x=1789410374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hYf5Klg9ejdL8G9vG3euAbDtpXpMQRmj76MnxFPaMOc=;
 b=YuRWf4s1GZUQbZpx+HUXh031yaYQu8MlGktcL/NPGahqWdhpGcL1hxNxNAo6upUcm1
 5bCwVaE8AcCQ4hYUE+y4IM1Z/FVRfWGnFMmY8E3fMJFFKbOVeWu/PB4/h7YT6DxhcKwf
 TovQz1pUfpA2CGe8vg5hP6v1YPtM8TQ1dxTbFrS1t0kv786BmWefa/iL+N0VdOw4kbB+
 fGF6TvIek0kuL7JQQJ+PLfojrlwFpq5/EEGUsjXw/fdSOsKw7PIvC81/F1JynVqLfNLf
 mPWTtjEUM7/zlLtfF7OWa6eJUlTXoHT4nIKIbGSwKAqILCZMIq/n1okPtsDfyZWtuhDd
 LClg==
X-Gm-Message-State: AFuF++mtxHwdc3pt9IgOjlmEsm3cynapruGicMs3wBusU1EXBgkru/1q
 plDkY164SMO0fcnBGANY+7hxtmIZzrqABIwvvJJZXJLRLmJg32RXPxrUK3vHo2/d/1FySaofC1e
 q/R6b
X-Gm-Gg: AYBFou3iRpigeEP3NNEiZPc6BYAxooBvb/UMLMO64dsTZEVNmbq2e2LWSeNGHwKv5jl
 qRcdK3oY/BHIwwpYFpMhbZwW78SGDFr9VKBytMJFKCSV1KSSKRfeFzNj51vHxkkL7guOmNX0IPY
 Tj+Ts9BhExCWG3f/cZN2xwmeQpWO2MecWEDP6aiyf3vNHWvK0QNrEwng7PTje+M+QYws0T3FJ3f
 5HgmkT52XMgdieNqpWzEQvSOApYVOni2JAyyy+qNHFfBiJWlHRP8P5KF1EgglXw0TLwEvhHCm+/
 PoRj/Sk6nrmvgoe8rIecRqTU2MSEz9am5SGLgp8jdGtwYUgZamhSst8kz3/UkgZglQDFgEHNioG
 giRpcRbWfVnXRa0mkyBJL1gyt1Hw3WzywwbcBW7s9e4iUxjJp7Ry4WJbpRPkIWogQ8Ji8y9f5UL
 s3JCiPPafUUCO/zboSEe24nZdsqO5z0GIDqT86B9F23hNRFAqMJftZC2hup2LrlsP5mO9iywjhR
 IZa5BbHrCm9/QWACKK5kZoWQxGw5KPCRpSonw==
X-Received: by 2002:a05:6a00:1902:b0:864:782f:74c with SMTP id
 d2e1a72fcca58-864782f0c3dmr14205162b3a.5.1788805574045; 
 Mon, 07 Sep 2026 11:26:14 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86152f32447sm4553302b3a.38.2026.09.07.11.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 11:26:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Kiran Kumar K <kirankumark@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Aman Singh <aman.deep.singh@intel.com>,
 Gregory Etelson <getelson@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: [PATCH 1/3] app/testpmd: fix stack overflow parsing flex item link
Date: Mon,  7 Sep 2026 11:22:02 -0700
Message-ID: <20260907182317.570481-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907182317.570481-1-stephen@networkplumber.org>
References: <20260907182317.570481-1-stephen@networkplumber.org>
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

The item string in a flex item JSON configuration is formatted into a
256 byte stack buffer with sprintf().  A longer string overflows it:

  *** buffer overflow detected ***: terminated

Use snprintf() and reject the item if it does not fit.

Fixes: 59f3a8acbcdb ("app/testpmd: add flex item commands")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/cmd_flex_item.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/app/test-pmd/cmd_flex_item.c b/app/test-pmd/cmd_flex_item.c
index c0bbff7b45..e62afe3cb5 100644
--- a/app/test-pmd/cmd_flex_item.c
+++ b/app/test-pmd/cmd_flex_item.c
@@ -135,10 +135,13 @@ flex_link_item_parse(const char *src, struct rte_flow_item *item)
 	struct rte_flow_item *pattern;
 	struct rte_flow_action *actions;
 
-	sprintf(flow_rule,
-		"flow create 0 pattern %s / end actions drop / end", src);
-	src = flow_rule;
-	ret = flow_parse(src, (void *)data, sizeof(data),
+	ret = snprintf(flow_rule, sizeof(flow_rule),
+		       "flow create 0 pattern %s / end actions drop / end", src);
+	if (ret < 0 || ret >= (int)sizeof(flow_rule)) {
+		printf("Flex item link \"%s\" is too long\n", src);
+		return -ENOSPC;
+	}
+	ret = flow_parse(flow_rule, (void *)data, sizeof(data),
 			 &attr, &pattern, &actions);
 	if (ret)
 		return ret;
-- 
2.53.0

