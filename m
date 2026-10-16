Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DCACCF2E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 11:47:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A13E40A80;
	Mon, 19 Oct 2026 13:47:08 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id E444640291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 19:46:15 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-33fb4680717so292810eec.1
 for <dev@dpdk.org>; Fri, 16 Oct 2026 10:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792172775; x=1792777575; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J2GITz/yLJAan1FCQAoMl8BIbof4gh12ZcdAm/Kqka4=;
 b=C2HxagnZ8HmIVHP8ObvX8otE9AYPJypcH8n+/WUBYAhIPuK2sjIeiv1sXfKrZD0sIJ
 kGVRiPlB0jhaYFzkRAzYR5HXnL/BYN2G31qQKjmLsS5HkNKULWa4CU3UWAaz172elSok
 onq3+iq+JAoLSN9yk/tT0Xpkl9gF7O+SWFzj+Hzb8bfVU9Uh36f+a8Yc+kuqEtznj1dg
 gfkp7N3J3GEUXGaLBGjm9SKUW34rrXePeb08i0A4bJTtryxaUMrotnU0Tk+mj+wtu2OG
 dA5KsXXLU4tI9Oxl1Rsm+8EA185zwKdikLtgw1NNx6zbYq5H9Bgfp53TdB/7EUxJ576H
 QuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792172775; x=1792777575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J2GITz/yLJAan1FCQAoMl8BIbof4gh12ZcdAm/Kqka4=;
 b=BmtsSVSZ/OnP7g5RMdZvcTg6DApU6bfuN8ZvfaEnDUpFwz3geijkAT8pEIexvIKeDf
 s9qB6bOtRFMv8PyzS9a9S6/GLTDd6pojyj3UwMimSvU/JDg59DTJQ1YzdKKh+OPUNE/I
 nR1m8pV93SLtsFj6OLPIEzs/t/gvyrwKBjqFQd2QyvMPtsNwk1xM2w0uaVen0hkk0TD7
 Bp0HKzsIa+OdgBbA2mTtBk50tVpVldLoE/uMQEeuaqwJbCQ+bg1gEA20cn0vgEtzaW6H
 Vh8fcTrp9svBr8pxS7ayaFF0xL25SQ79KlecljHFkURtST4Ik5iRv+TW8PYJkpMV66YB
 nQbA==
X-Gm-Message-State: AFq9FYIZByRmIRbXbKbXNsaRmTbOmspH5mt2xsGzf2EP3VvvJIxwyDyQ
 S1659Y9o329WsoXy47iqlyMM5hDTsoP/YMA1MLpPQoD9yA2jC1cliynNZhssOA==
X-Gm-Gg: AYBFou2UftPXGkpJKoklgXPpGMpk8/JtHUeZotnUPZJnx8p6AnKdXrS8F1cmgInVCk/
 snjlxzB8WAFbL1KRqKE4b+FoRhi5a8ACFxCGOSm2qH7NHdzcNw5KKUztY11BDX/dQMrdDRmm9lZ
 61QQ+sIdieRMTBYiMGLPtBt3Rzn6dH7ZBu/+KAFvoPeg813gpT/sFI053yyTgjHubZ3m70aIliW
 DfTGAqi7KoPLJTtZatVBBEHk5o8vwjpBhVm5UnBKUnJIW4FUQb2wanFJzu4AGkAeflBSLtdC5aS
 CQ7E/bdTOH6oIB0ZNwe2uSrOlgojoZp7lZspBwV1uRV085k7d35rFcN7QVDtRQIhVGcKQG8f92B
 skq8dPIsDtuB+lc0AQDqF7XVh7bu4L7vRYWJ6s+3laHOkiVgxCrDYh08Cxa9wzsBQzF46Oe9LS4
 yDmk6LuMHovUZWxWIWlpRAmCjWhgQisCHK5QcWkr2WSxArjPSsmFZAVlFRo5OcShic9dvMb4iW
X-Received: by 2002:a05:7022:1201:b0:179:b953:a14e with SMTP id
 a92af1059eb24-18514b02ca6mr404107c88.45.1792172774397; 
 Fri, 16 Oct 2026 10:46:14 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18314ef8ed8sm7099936c88.3.2026.10.16.10.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 10:46:14 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: Joshua Washington <joshwash@google.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Ankit Garg <nktgrg@google.com>
Subject: [PATCH v4 07/10] net/gve: export Tx drop counters in xstats
Date: Fri, 16 Oct 2026 17:45:42 +0000
Message-ID: <743453a5b3f7b1c19ee0e9d6c8882d83870cb006.1792170902.git.tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792170902.git.tathagat.dpdk@gmail.com>
References: <cover.1792170902.git.tathagat.dpdk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Oct 2026 13:47:02 +0200
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

too_many_descs is counted but missing from the Tx xstats table, so it
cannot be read. Export it together with invalid_mbufs.

Fixes: f4a70b449bfa ("net/gve: add DQO Tx descriptor limit")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
 drivers/net/gve/gve_ethdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 3c8d1a76e4..1dfbe8f396 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -1042,6 +1042,8 @@ static const struct gve_xstats_name_offset tx_xstats_name_offset[] = {
 	{ "packets", TX_QUEUE_STATS_OFFSET(packets) },
 	{ "bytes",   TX_QUEUE_STATS_OFFSET(bytes) },
 	{ "errors",  TX_QUEUE_STATS_OFFSET(errors) },
+	{ "too_many_descs", TX_QUEUE_STATS_OFFSET(too_many_descs) },
+	{ "invalid_mbufs", TX_QUEUE_STATS_OFFSET(invalid_mbufs) },
 };
 
 static const struct gve_xstats_name_offset rx_xstats_name_offset[] = {
-- 
2.43.0

