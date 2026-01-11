Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08ABD2502E
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Jan 2026 16:06:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3181D40667;
	Sun, 11 Jan 2026 17:06:41 +0100 (CET)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id 239F74065B
 for <dev@dpdk.org>; Sun, 11 Jan 2026 17:06:40 +0100 (CET)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-4f4a88e75a5so55600981cf.0
 for <dev@dpdk.org>; Sun, 11 Jan 2026 08:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768147599; x=1768752399; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HztIkd3sqOJocgSdhV4MJOI3rL1Ay0k8/q15iB6FdSM=;
 b=nDhOSd+txb4g0I4X/Hw9IT3ORz0nnTQfPXq+7M22amsaWbACvb+0cp01fvlFBjfPdq
 jqEtcvHKrhp4Bal1myDIjtOstBVcRziJJRQuK4O5BeCdp4Wz0dzvhBB5Hc1q9RzI66vo
 CjgWu02tSoXNJ/g3Y57+MjH4BZXodzufbgQJF/LTX+EUzPl/0vH4LoJ2osenL7IbAwT9
 dn946FrSComwdxua39ZmDvfkXDnRrb3uJ4YBA5IFaX4vLuLlsy7HLGjxA9qpBBC2rzMR
 43Skf2tGYbXFt7WO6dTRCVtCBAaUB4mnMTxwKJg3Yh/WqQSJS84XhkUv/OYdjQhnYrYh
 Zz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768147599; x=1768752399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HztIkd3sqOJocgSdhV4MJOI3rL1Ay0k8/q15iB6FdSM=;
 b=sanWC2XE6llrFek+RWBE36LZd2YbdFuEtsUbn3TyYuZft2FRuQC5Xr8AscYTfAQNWJ
 4cU3gfFAawn8zpSon9qV83OtIIzs4BMrOCxEJjkxoswnwFDEQbQKnE+rINlpinmGps1O
 jNl93VEBdxMxxSmTWtl/z907mnekW0U26YCr0M9uX0Qupo19+vecyEvc5iklOu8MdtiY
 aCWyE0zh39GkvZanYc7f1kX4HgHuctyTFFadYQ8I/jsJbGzAgKKmUOOTB+cA9gk3ODsX
 xpbXj6YouWmXPvWeLRM07rUtLp/CIXpj65UB6GSEfIOc9747fP0wz41s8YM3lSmiZyIc
 4NiQ==
X-Gm-Message-State: AOJu0YyDYF5/tiUpCgRpNiuS1mn3nsxusikIbUJX6sCa6j2ZfGA1djKn
 syzf7sgOVkKjl7f1ZfZ8d8Ofvg6TUdNXy9UUJirdHWjwOwE6VE/+bu+AiLZvhQ==
X-Gm-Gg: AY/fxX6v4dfRskLy+TG0yD1rPBD/EdgPSrNp9646cp0ROy1sHvXmk3lCSZqZ8ecJfF1
 8B6S92HwGf2wC+teMl/l3xp9zBCmdsxhzRDjWyBqE767Pmk4UU1OHMbMPIcHQ78oXPx9lLEHNNi
 eDzrWbfxIn3LS7os/2uxvP2sxCvZ9t8LJo4yY4Ud2KLufeuIyg8QMi5+ukS2k/3INxIjYNZ+tVW
 /iBB/vugHipgUTjjlWaPb2FIXEpvydnQVHMyQSDqNk/CMFEeFkhtw8+OawnwqPZipoi2WvZhAaI
 i6xkGmNckjwsAVuv1yPxNuPGHiPIcS3VId9T1NIu87DEmzF7cEZ2e4SKYWdkv0oQFEkS8g9CzQf
 xs76xgx147LnU83ZZy3acPgADcQfl2X0je+qia3onubMsA0dDEay/IBlc8ajc8UFFToZuodQG3r
 8JpnkLM2QMtsptQ6HcTOaJP95IBzdhubdbXu7Hsl7x54WZigY3sqmWpVc45FwY
X-Google-Smtp-Source: AGHT+IEuhX/WIFsMHTVLVCbJaDOuOg97OihnJz+uKQbdupT1vNZQGU6DR/XSuqCyFK3fb9t/TWhNIA==
X-Received: by 2002:a05:622a:4247:b0:4ee:1b99:e112 with SMTP id
 d75a77b69052e-4ffb48b3d49mr212045521cf.34.1768147599257; 
 Sun, 11 Jan 2026 08:06:39 -0800 (PST)
Received: from st57p01nt-relayp02.apple.com
 ([2600:1000:b19c:b9d9:b0a4:2ee1:3986:5e9d])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ffa8d3d34fsm106575561cf.4.2026.01.11.08.06.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jan 2026 08:06:39 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v4 2/2] mailmap: add Scott Mitchell
Date: Sun, 11 Jan 2026 11:06:26 -0500
Message-Id: <20260111160626.2103-3-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260111160626.2103-1-scott.k.mitch1@gmail.com>
References: <20260111160626.2103-1-scott.k.mitch1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Scott Mitchell <scott.k.mitch1@gmail.com>

Add email mapping for consistent git attribution.

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 2f089326ff..a0987fc3c7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1437,6 +1437,7 @@ Saurabh Singhal <saurabhs@arista.com>
 Savinay Dharmappa <savinay.dharmappa@intel.com>
 Scott Branden <scott.branden@broadcom.com>
 Scott Daniels <daniels@research.att.com>
+Scott Mitchell <scott.k.mitch1@gmail.com> <scott_mitchell@apple.com>
 Scott W Taylor <scott.w.taylor@intel.com>
 Scott Wasson <scott_wasson@affirmednetworks.com>
 Seán Harte <seanbh@gmail.com>
-- 
2.39.5 (Apple Git-154)

