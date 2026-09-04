Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CA5C624DE
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 16:25:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C55A440297;
	Fri,  4 Sep 2026 18:25:03 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id C25524021F
 for <dev@dpdk.org>; Fri,  4 Sep 2026 18:25:02 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8556ec44e9aso1174130b3a.3
 for <dev@dpdk.org>; Fri, 04 Sep 2026 09:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788539102;
 x=1789143902; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jr2A8v8GIiJGKaaWFMPKJdZ6Q3dcFwS3Rggf4X3KPM0=;
 b=P2JmWke3eo+tA7pZbumnVJa9Sbqa2HfQ6Rm3ZohseGQNKA8roLLn54bu0/HPWKjA90
 3H0gGoFPc7ncKI0cZB6RAKKSMHhYzUzNPQm3u9ude++rmIYRNHcTB5tPqOHXJaSn5MAN
 bHjznjKDebuQJvmWF7lkCAHU4Cs0si4AXqG8VdZNA52aktZs/o6B739LHSWVJHvboX+M
 IZENVF6VWShU3TYqU1VKJJqVy4+dB8fN6tnm3Dq4p4dtrgk5MlPH5FIQ3FaJXIGzq/H0
 mLWKASHSsMa6AD4lK+02K27nWkQ6wK9B3AHsOw+AzAOsnJXJeukY22nT7X0jbxOyvwYW
 zTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788539102; x=1789143902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jr2A8v8GIiJGKaaWFMPKJdZ6Q3dcFwS3Rggf4X3KPM0=;
 b=lSL4hj+nut/gPJft6UgOyKfVmV4TnNryNqji7W/vIA2aOzyJzKRC5x5wxfvVbxlAq7
 PD/SV/1hDX7xoAXMB1Qu06PUvsusPGGwaqix6iHVIVmdtf9+2i6NiN3v1IYV1t5Aek6v
 s0CufD9xd4ej0KtWMLmMxRfvniex0P5Axyeh/de3sOUujzTpPyDGGJsXAEJRAm7zPuZ9
 7/njN79mjs0hGh5K+70nwN7f4Dn/h0CvQDNiEErB2vy4M+cueb68t0i5AkvETZ4GW2Fo
 iW5tRs21X4vqPoFwXXl24B0rgb+JH4pFiwIXnlnee84Th/d55Eh0Ybu2yoXXTfdod/HU
 fNww==
X-Gm-Message-State: AFuF++l6yZ4rrECJEWUljwOWLJTIYNz/3aWTlsVvf4Wz84GuHK2zW/yH
 R0OmWdDX5BUutBwdC97Np1tCbLDx7/ESlsBrtw9199ywO4WtWvotyD2cQzv43Ne0lLWQKyVBER9
 bMfEd
X-Gm-Gg: AYBFou2+I8Gx6PYNqPCYHwgln0w+jF4DaWVDFu8Nm8dbmVSHnJWPhqO54XDdGF0XI+f
 zOtKTA1ba6yNDyaS/C1VenXvG0hi4oXUNAjSILyPdq2LJzT2uiHZo5IYp71pOMriQ1NUx+rT5iN
 OeoHl036nV/NrW5E/96wZqfl2989/u7ccfZKBGMDOzVzeyIkryEbaNIHUj/NZgPEDGWOwVMHZt7
 hpSNmcrGvC+QArP0xgGZMKt9U02ExO/C8XaClAwlvv76++AE69PwW/yOwvV/3721lBpicXHIjPs
 iHiGIIvzZuZkIUOuBi+Keyfc38PC7CoLGmqlxd/8IbsD1ELrgbfFinVmDGnRIj52bdS7Cwh35mZ
 i3w999SI7rPmLGSmfQbElP3r13O0cFvoFPixMUXJxY33gipKJhfT7gYamI0NPbaySAdtRsaWsac
 oxHwuStm7THW7HPuv1cCXF8osw9r+fnEW4Yov+q4G92GPhf2LDiUI1VQvuO6SdJFVGgCnXDYEFD
 eyTDJBd9PWuuuc6dsGbww3NmSk=
X-Received: by 2002:a05:6a00:1915:b0:85c:c8db:8e4b with SMTP id
 d2e1a72fcca58-8616878592emr10127542b3a.6.1788539101683; 
 Fri, 04 Sep 2026 09:25:01 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8615203e041sm1405772b3a.17.2026.09.04.09.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 09:25:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/2] Improve AI review feedback
Date: Fri,  4 Sep 2026 09:23:06 -0700
Message-ID: <20260904162454.218213-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260829171822.305500-1-stephen@networkplumber.org>
References: <20260829171822.305500-1-stephen@networkplumber.org>
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

Existing AI review used by CI generates lots of false
positives from lack of confidence and poor parsing.

This still doesn't make up for the missing tooling, where running
AI review locally or in GUI gives better results. But these
changes should reduce the bogus warnings.

Stephen Hemminger (2):
  AGENTS: reduce false positives
  devtools/ai/review-patch: reduce spurious warnings

 AGENTS.md                   | 278 +++++++++++++++++++++++++++++++-----
 devtools/ai/review-patch.py | 232 ++++++++++++++++++++++++------
 2 files changed, 425 insertions(+), 85 deletions(-)

-- 
2.53.0

