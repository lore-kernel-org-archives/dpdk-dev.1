Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A147C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:16:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0E45410E6;
	Sun, 18 Jan 2026 20:14:15 +0100 (CET)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43]) by mails.dpdk.org (Postfix) with ESMTP id BFDE740E1B
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:12 +0100 (CET)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b87677a8abeso614969666b.1
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763652;
 x=1769368452; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yw0e42BdM7bdhgU3FNiJqMPK5L7XaauCnHpeIJDRYOQ=;
 b=gitXnF+HDBYcV1VJlG25etW2LHXuZD2xoYg9RF6xJdTBZi4GHfz1otvm76TxIBW9Wy
 J07FEVLhMDsH+Suh1/6SUng279F/GjWIZg7HqgJ39z9QX9k7FWy8Ahvy6JiHJqh+xbLl
 MsF6gXT7kpEKdOOkGdDEMaNyxbIxG6pJkw6yGMDJMpGrLeLpBwslqqjO/ztaR5jw0FDp
 YXAw4Xvx5ya9tb3ihazUwyGWj9UdR9G32/O1rH4sTsDZ0FshbaJyb36tXsCCp5EgAzZt
 OZovg/ta4Z/iz36cKxcTAqeo/TPRFNV5eaKzNa6knNkIYnGBgZoZgD8Zb7pS+5wz7x3x
 O2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763652; x=1769368452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yw0e42BdM7bdhgU3FNiJqMPK5L7XaauCnHpeIJDRYOQ=;
 b=XmtiIkCTWwlytz6hm6q6vrYpkffbRFa4S/V841e2Q9Kp7W3VcdzWItH1SfiVnotjrk
 a8UNyhEvW1tEzdaDuRgyApekRyso6hWpvELVclSwvUrsh4POpoiNZWzDHZsEHam/R4JB
 ER1d+3izPsfozNT7F9ihjVi2/hQM0CtrZwmD8kIbMqqjHK6c8+wbNqAHYvTIZ6c+hFEj
 1uC2hv8F5ups2nfHThntpx7R+wLC3JITlF1lGt5/UDahXf3vqLbxBXSrjWRw+lBqkeAr
 D2Fr2WxIyhFa26Pks8q82HrVyTLrxmSG8T+mfK7WeTnGULiumUSWe5kqBzBMhqJPwqzN
 jhbg==
X-Gm-Message-State: AOJu0YxQw4mxbT58t/iUotag7y3AOMHjIz0+xzwgBqsryFD/ZX2HRLtk
 EHEhP8gqdFX71RHoVx/ZDEhsBsujS6esSTaFrlu2m8aVi3p8U+2dAIw3v6fx+LvrSnZkm3tHAGs
 QB275
X-Gm-Gg: AY/fxX58nvWDXPX3RJzMQRDw2QTOMP4YuvPOb9FoJ3utG8gNZ6PwNJdjDTMgADZlZsh
 73cpVlz0hoMS/aQ3YPEqJeUH8w6YEAyAZQhFlsPbZVXQS9o24zBcvpnrlbQkhBl/gev2kQNVP+Y
 6t6ZtMtPE5H9+u2r2uS6gayLROZoQVkE1Pyi6yxG7PdLIA0HE8fK8TURHxODD/xt43NNAIfoMuJ
 Mj8dXjnS6s+bqsGT5xX5+uTDY1xD8r+x6rzfX83CHMKNuN3n4uoJbXXUPWlxjHGJmzS5HZDKzHe
 bQv/Lyq0wzAwUHypSwRH8qDpqAeyU1aC7c06rtJaZBE1BosKs7+oVo/BrUaGdK74eNe28R/xRAg
 anBExIPb6SbqLcXV/n+kfuvQTvFo+lu4ARz2oLQhnH0qHvFJHMQ/Iv5clPS0wGPY7Aj/o5+gOKf
 NoLYHxmy4miSZbriFiZSFSJ5T9tVs3dSnqwYSddOABMhyV1u1W9w==
X-Received: by 2002:a17:907:7b9a:b0:b87:115:a724 with SMTP id
 a640c23a62f3a-b879324398bmr791380566b.34.1768763652263; 
 Sun, 18 Jan 2026 11:14:12 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 28/54] doc: correct grammar in LPM guide
Date: Sun, 18 Jan 2026 11:10:31 -0800
Message-ID: <20260118191323.241013-29-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct "search process have finished" to "search process has finished".

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/lpm_lib.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/prog_guide/lpm_lib.rst b/doc/guides/prog_guide/lpm_lib.rst
index 316ac835a4..483173f5cd 100644
--- a/doc/guides/prog_guide/lpm_lib.rst
+++ b/doc/guides/prog_guide/lpm_lib.rst
@@ -82,7 +82,7 @@ An entry in tbl24 contains the following fields:
 The first field can either contain a number indicating the tbl8 in which the lookup process should continue
 or the next hop itself if the longest prefix match has already been found.
 The two flags are used to determine whether the entry is valid or not and
-whether the search process have finished or not respectively.
+whether the search process has finished or not respectively.
 The depth or length of the rule is the number of bits of the rule that is stored in a specific entry.
 
 An entry in a tbl8 contains the following fields:
-- 
2.51.0

