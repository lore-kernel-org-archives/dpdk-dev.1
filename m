Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9111ACFC29F
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 19:55:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A55D40280;
	Fri, 21 Nov 2025 20:55:39 +0100 (CET)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 08EDA40269
 for <dev@dpdk.org>; Fri, 21 Nov 2025 20:55:38 +0100 (CET)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-8b28f983333so236062985a.3
 for <dev@dpdk.org>; Fri, 21 Nov 2025 11:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1763754937; x=1764359737; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NTRSEgxKIhe4xNd3vokii8jXjNhL59csHgNQFgMh6tk=;
 b=aD5Fqan1qzatxfvzKiqodQPPny3vMU60pmPZZUyluO6nFun/RcrU2goyblFLYopRT6
 O7yPZ/ugB4UN2B2yHBJ42FfnrTLRDXC30RokdYDF9woEaywXuL7mICUkUb+Ab4gkiAvX
 QflYWX4NENeL0GKS74rR5PVTVC3pkkL9X3c10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763754937; x=1764359737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NTRSEgxKIhe4xNd3vokii8jXjNhL59csHgNQFgMh6tk=;
 b=SBEMTZ3QZsg7+VvK8aCQAto+y/nlrv7LXU7R+MVbqeAcAaRvkYgD4HCjuwwPUSIAxB
 89f5VJ6zkYan1Fc1Y3f7PgtV4ZVidGFZpuD3Xqxeg45S77nJoNtm1T7Cuy0oGD8GaUEr
 PGNN0F5UlJ5hjkwMCWm2umEadJ0YDxIo5r26nsa70XTJjU7M4yr19phiMEaoVh0v6KIS
 c3jh+kqo9pKIRyz1bO/ShixdqCiq4Jt3iHF6u//ujo7xnvvOyOGU6X4Xg13horNTuhLu
 W1leWB3dLXxW3cnzCyfkPczdMEEyyTDn8gAjdOJFI0M2kESh0lWqzogEy5jkz9TagARO
 GhJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlySypqA8LBIIXBINL71Tw0NpRvWDICOBqesZN29lQrIS444zZ/uupH5p9F4CdD8o2Wh0=@dpdk.org
X-Gm-Message-State: AOJu0YyMNM2U5GydZGQONhSM2LnMikx+o9p0qZcro5ZEDtOfIwgKdBZz
 WRtp39DmOcGLchNOVDGYH5TRWAO4JPrUCbentM5xiLIuGbjamLWXSBRNTk0JuEJGlzk=
X-Gm-Gg: ASbGncsLiuleZ4+RZErqfZNTWcoz4q0rHqTi0+7y00jt/m10SjJ2LOyiqvMkkVEGjuc
 DznqihQl7iSwNpZllcnVzTzO1Hs0LA3wRblInugMdiN4kN44J9Q4AplLWlklFs1msT7iCnKZpmx
 zP0ckPrA2Lyg0ww6Me2V/BlB5mMxRQs0msEHBc0lIpLw8ycQY1M0P0Rk+HkHyiPsRWXypNjjjeG
 tYu+awLgAwn9rQUTTrNYr7b2JhLpaxuBPGpPx+y3Uj8EAqGs7th/nTCFAP8OQM2lONcQiVP916T
 TEgVrLcKjwk93FuI/SLjm0UF7UwDTKJydSvOME5zAsX1rg3y1DQ8+G2+hKYV4LzMUA9eep9vNe7
 Sk5sFP+wavyGHxFxDuMFc1fLKrRgRkF20Sw9sX1m85glAD/Xqia6VJ8kNzL7GffI9DK4O9BDlOr
 EUC8pM7m13guMxEI1u+m9vdG0=
X-Google-Smtp-Source: AGHT+IHsj69fkp007HeqsHiq+TUPstXsJLn5jK4XGiErthqYFIGJFAkRABBAXMLDLQSHVsfw0VqHNg==
X-Received: by 2002:a05:620a:4104:b0:8a3:cd9e:e40e with SMTP id
 af79cd13be357-8b33d4984b6mr399165485a.86.1763754937203; 
 Fri, 21 Nov 2025 11:55:37 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b3294336e4sm427471685a.21.2025.11.21.11.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 11:55:36 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v4 1/2] dts: make one link the default topology
Date: Fri, 21 Nov 2025 14:55:10 -0500
Message-ID: <20251121195511.322005-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723135021.218084-1-dmarx@iol.unh.edu>
References: <20250723135021.218084-1-dmarx@iol.unh.edu>
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

Currently the default topology for test suites when not specified
is two link. However, the majority of the DPDK functions tested
in DTS can be tested with a single link. It is more intuitive for
a testsuite or testcase lacking a topology decorator to default
to the more basic requirement of 1 link, and force tests which
really do require two link to include decorators explicitly
saying so.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/api/capabilities.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/api/capabilities.py b/dts/api/capabilities.py
index 243759668f..eafbd38afa 100644
--- a/dts/api/capabilities.py
+++ b/dts/api/capabilities.py
@@ -63,7 +63,7 @@ class LinkTopology(IntEnum):
     @classmethod
     def default(cls) -> "LinkTopology":
         """The default topology required by test cases if not specified otherwise."""
-        return cls.TWO_LINKS
+        return cls.NO_LINK
 
 
 class NicCapability(IntEnum):
-- 
2.50.1

