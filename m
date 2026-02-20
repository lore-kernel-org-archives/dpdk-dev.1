Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C37DC53209
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:05:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E87340697;
	Fri, 20 Feb 2026 06:04:30 +0100 (CET)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 7C4FA40663
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:04:24 +0100 (CET)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-8cb4acdacb2so216823885a.3
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771563864;
 x=1772168664; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/omJoVtSBuPtIyWBO+npMl3uPvGP9xe48jZLhu4cU/8=;
 b=JJhiLxrA0ua8Tc7iBS/lfBrVb/KAC+D/MDLT+LXi+GmdJOXNTm0mIKETELSgCq3uSz
 BGdy15u0yMvI7RcIsy7spIhptvWMunPgjwe/8pcGBYjAG98dMyWKE79OtbC7GAoAdqzi
 GTry0YzPe88sj9P5eBJ9bOQJr0i5cFqMfC7leIDF84JjKe0l+ijvn4OFuAs9kwBX64qV
 w7OwS8WFSI3Ljw/47b2C1oFAri9GaXIiiA2S14iMFrC0xvCbZnf+7rMJlvlgBWsfHfxy
 5vJpZvg7kz4WvnVBrnxLqHneT4kN06cZQylIwNieIV14bWF0s2I9uerUgTMqVSlvlFCz
 kQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771563864; x=1772168664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/omJoVtSBuPtIyWBO+npMl3uPvGP9xe48jZLhu4cU/8=;
 b=Ujggyz+ZONrdAIit/iUNLcwAYKUajmqXdPWWNuoDj6iaD2lfoeLZqPjU+UV9nLgCg0
 CdGE92aqC5ZR0ZuFYKuQj5lStqtjqdjccGjOa50QqAgAIQguDjCgbaV9Y06hanshw+nm
 x1shGLoY1kXEoO9K8FY+It3LSSctL6r7WUP0ITbBfMbipR8JA+S8oVYYi+RloLRQ/N0G
 x7yJX5X/iRxXGts/LNUFNF/dpXu5Wo/L516rPl16YffnMKd13t9456M1GV4r6jynCEoG
 R0rqAJFEG7eTuCAXOgjGGI50lVHOFos9G0mLjsgfSoYs/62rfwhvUg1pg9GrFfBBdyct
 OnMw==
X-Gm-Message-State: AOJu0Yzl6I5E+5c3I0MZdfpG4U9BelgIlHILhMTYO7REP6rgu/4Ue0hv
 09ZLN/16dO+CLxBgujdxCXhgBe6vIqRRi83G58/huUcmoz4fP221WOQa/ewA34KJxHZdrQ+ATW6
 2TKjR
X-Gm-Gg: AZuq6aJ6ukkrZl2ItlcutxlzZs/0UamlhKGn6vXuMnXV1I8SmsW0MJEwce/FkcUkBLC
 +zbe2lpIvr+3feWN3f1RmTJxUoJ3ad9XKb4xEaHNqBV66uBe1XPWZTA1SEhjJKGyaip4ey34+82
 xuYeIu1f98vzP5IVe5UOYksW9XmYO/npFnFh/ttQpAC+TYxzfoW4G3gak6eOSaG1kZrbyYg2MrV
 3WrAhbf5ZfszfxXCtj44RPJ2vkilxnBjlAz2mWaq4CWNLxWdkOucR7HYTydJO/FfoDCM/Nj6Cp4
 RMHQFngsFuP8Rqk7gTTPSlJb7JQbDyOUb/VpFcUp5wFrXnKpGTEKqAtioSoikDEfx8R/OPbsyEB
 M/C5gYGKXRK5bKDOO/hQIaFerzisaF9AhuN+hUeQrU01kBh1PJpMNQfAN8KqTFVD+K1ovh0zziM
 yF5x8AmJIdWf5sdgnPvByl4kEtAlxghlrtkaXmDPnP1UPoYOa1gtpxke5q+ayNBQ==
X-Received: by 2002:a05:620a:269b:b0:8cb:4128:ec45 with SMTP id
 af79cd13be357-8cb4c006cb9mr2533564785a.66.1771563863837; 
 Thu, 19 Feb 2026 21:04:23 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb2b0f38dbsm2289278685a.21.2026.02.19.21.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:04:23 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v3 10/10] net/tap: free remote flow when implicit rule already
 exists
Date: Thu, 19 Feb 2026 21:02:12 -0800
Message-ID: <20260220050409.1571022-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220050409.1571022-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260220050409.1571022-1-stephen@networkplumber.org>
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

When tap_flow_implicit_create() gets EEXIST from the kernel, the
allocated remote_flow is never freed. Add rte_free() on that path.

Bugzilla ID: 1880
Fixes: 2ef1c0da894a ("net/tap: fix isolation mode toggling")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/tap_flow.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tap/tap_flow.c b/drivers/net/tap/tap_flow.c
index 427faf75d5..da1e70019a 100644
--- a/drivers/net/tap/tap_flow.c
+++ b/drivers/net/tap/tap_flow.c
@@ -1625,8 +1625,10 @@ int tap_flow_implicit_create(struct pmd_internals *pmd,
 	err = tap_nl_recv_ack(pmd->nlsk_fd);
 	if (err < 0) {
 		/* Silently ignore re-entering existing rule */
-		if (errno == EEXIST)
+		if (errno == EEXIST) {
+			rte_free(remote_flow);
 			goto success;
+		}
 		TAP_LOG(ERR,
 			"Kernel refused TC filter rule creation (%d): %s",
 			errno, strerror(errno));
-- 
2.51.0

