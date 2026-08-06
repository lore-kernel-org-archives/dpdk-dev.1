Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFADC56208
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:16:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA3C54064A;
	Thu,  6 Aug 2026 19:16:47 +0200 (CEST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id EF38840685
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:16:45 +0200 (CEST)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-8ef1dc934d1so9288066d6.0
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786036605; x=1786641405; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6FfqFTPcYXtNwMsYWjnb3soghPPIhVwY2tmN9U0R3N0=;
 b=UA6eO8j8IsU7hiv+orcMAd7COJGMzxbcLs9Qzi46795aQ7yTCgHYxhZp3dtiMYrIMq
 2Zelzj27i1v2YAd8/ttZs3+rBg52XDENzSSxdk32uS0+VsSD0UDyvguhHPlBa1Os/bzE
 tkuFnh4KwcY2/2sQXmbJKtFbJ2rUsSI8hZFFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786036605; x=1786641405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6FfqFTPcYXtNwMsYWjnb3soghPPIhVwY2tmN9U0R3N0=;
 b=GCExl6+FhnRImvXytGQ1oRW0poE83sAXDhBW+KzqrwA20dYaNErzvwWReSpJukZGzZ
 yGMHdXxZr2LLsHihj4BCpXMl09y/EoXxNRfRpDiFnu/9YkXb4zjzi7P5H34dK/C+XjIz
 rnpbHOv2Ie8JRpWJtGLHUCfxLHfefec5AqDjgduas0jQL3gVPypPmphRiDYkxEgHmU3u
 ggwnYyFVf1JEulwndsiJMPWIukdWPz0R/CuU2YSggHsmIQXSHfQ1kypx4/5t304+vptG
 lyZcyS15uC2nCACm4Ma3WNyzv18iKbL/rm0MSd30CpNYB39MV5R3HttBoLJQC8qpMjVa
 E4cg==
X-Gm-Message-State: AOJu0YzF6IcpX3AvdJZ2BU5inudDArjYsFMXgOZqvfnbJU4huYgIMWyz
 mLrbIIbSCZoE/XbNvzXH7/l896pVm14LVQkV8h8KqeYN7FXPVAmSXxNcvDQHzG1/sdTFQd5qmiM
 WNGKWiPesL1a0h1b15clJqc4q9ft+F8hYgYWeLxJo2NYylmN7/Li69mJogTGHTxwm2eSkwV8tzm
 2JORUXIJrwnS0FhZ+LEPtnp9N1A+o=
X-Gm-Gg: AR+sD12ljmvacThyDZe66nO2uRpHJxStAr5JOOlizc7IS780rd6IE/akiu5Ma+KEnCK
 d7B3zFxb3eFqchEM7mZM2rkSng2rfsw62hhFzURfvL0JgoE4A5/qUZt7tCjCU2h4IpgTKtNS/+j
 crZkJpyNqbGIrBxY+p3UgeT3s3GiQAAucIVK2g6hulygz+K4bUifjzTlA0W28uUQhc6UKqjxGQ+
 /SzL/ccmy5zZ3S/8GSpAYv/PMj/TWwDZUvbDzuWwsNAc9JBS29/SELD7cD1/IvbluAojEZ241c1
 7cdR1QWlQWiX0NXVaecAMKZXXPOHQnA7GE1XzducTxViOMSJ0lQcnaPwHrNN4/ozKXCmQvTkMS3
 cWxmNAuG5EawXMvuGBgg8k1fJNqsoZ2q+fLgEyinDNHgzPUAuU2h60SeJG1JNBf7Wc6dhjT3ZPt
 8Ny6R/uI11Ert5ZjGLJ3OBaVZ+7Pm9aMoDXXLT61FMqUGrFLnOnMCX41Yt6fi2XuaCY6ycjJxFE
 Qzo0K593GXcetynqt4Vn0cmI6ZlUYPEA9qrn/2p
X-Received: by 2002:a05:6214:21e4:b0:8e9:51b7:2d49 with SMTP id
 6a1803df08f44-9088f7b8dc2mr88313216d6.2.1786036605291; 
 Thu, 06 Aug 2026 10:16:45 -0700 (PDT)
Received: from syn-2603-7083-bff0-a0d0-0000-0000-0000-1a64.res6.spectrum.com
 ([2606:4100:3880:1257::1039]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9087ffb8f76sm59934006d6.11.2026.08.06.10.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:16:44 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v6 2/7] version: 26.07.0
Date: Thu,  6 Aug 2026 13:16:31 -0400
Message-ID: <20260806171636.656181-3-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806171636.656181-1-abailey@iol.unh.edu>
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260806171636.656181-1-abailey@iol.unh.edu>
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

From: Thomas Monjalon <thomas@monjalon.net>

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 VERSION | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/VERSION b/VERSION
index 1fe6dfa9bd..403cc28f7a 100644
--- a/VERSION
+++ b/VERSION
@@ -1 +1 @@
-26.07.0-rc4
+26.07.0
-- 
2.55.0

