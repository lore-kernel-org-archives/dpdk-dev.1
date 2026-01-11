Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A4AD2502F
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Jan 2026 15:18:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98867402E1;
	Sun, 11 Jan 2026 16:18:07 +0100 (CET)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id A096D4042F
 for <dev@dpdk.org>; Sun, 11 Jan 2026 16:18:05 +0100 (CET)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-88a2b99d8c5so50114976d6.1
 for <dev@dpdk.org>; Sun, 11 Jan 2026 07:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768144685; x=1768749485; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HztIkd3sqOJocgSdhV4MJOI3rL1Ay0k8/q15iB6FdSM=;
 b=MbvWVAwxUHUgKarbu5uM9G5XAbo4mLerDneqjD8BXH5Ni/tqJTzFfmFE0Ev7+4JBCW
 ogNV+1vFJ6uGL40ROkTTALeyHCEHuRjTzZSUhHB8gdq8WJDyuz/7gU1QBw2NzG3IzGtG
 I6HnF4ZymvkI5qUU4mQ92fKWN/JxLxwogx+6l5CB4oIX2CFilxzrzPdMDGdUFjpEf+n0
 Px1tFCNZ1zB7uZzg8IN+mwdla4qjtOr4cEFYLZUjRymQwOXJYwEmCF3bNPIjlQTtDM4N
 ST6ador2MsZSztw+iz4p1q3G5FNPQ+IdA2KlZrOgFjS3APPloXNSCt9DN26F8iEKrFBG
 PfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768144685; x=1768749485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HztIkd3sqOJocgSdhV4MJOI3rL1Ay0k8/q15iB6FdSM=;
 b=Y1ebkQeRnBAUZv9iEPK6vWqhNgKcvfQ5ybuFYCGCKIy/m5O8IFcJJcpF4tgrESBa3G
 QaU9NM5zCh9l3EX4b357Kfd2CUociQUi81ls9YVRJelhPWSsqpAF5ryhb4+MbxbCAaQN
 ym8wakuwfpbSuwuPtPv2/46OMAOsvmbMtD+G1L8LHwqNYkDueT2S036r7KpweZUG2lXD
 d6pvgZTzG3I69Y4nVlsl0hSvuYXxfoJpkKmTGGybgQ7LgdS1XnifhBj+NYgOjl8LCtiB
 eyAAcC8fEA9dt9cIpIuDJo7UK320TmpPPseRYwCws4OfIy3eH/Y8K7zImLscIS/GuRYL
 Ln0Q==
X-Gm-Message-State: AOJu0YyWVWWofWmDv2+Q+kIR+U/hyPeLMCtZIG+v79sCNAcYdjmUw6gN
 GuU9t6vMClN+cp7VkN9KmXAVypyTCm1DkyaBKlV0ZcyhhjVEy41YtMQm5FeL/Q==
X-Gm-Gg: AY/fxX57ipGVZHyVMwMkEI1IPQylchvW4EAuu/sBKJ7BTI49wgoEEZlH6EzkJALaprd
 G5Cusf/7JIxfXllcpaL2LZctGIFYUgJrQmx1f91TFm9YI4WOXHyfOgSfkM4XRMbL9yd5qaHYYsy
 8Oea+HJQ59hNiRhw341ZsJgMxIqp4bOOr1IiUI9hJZtKhShXrGQofBvYWTudQhNCqUxXbTtUE5R
 alInW9Io7bvGx3zXQgcNrcHpUEacQYprbWR1Z11jOkavT0H93kV33VlMCCjmQBZGORrjrDV3Mzb
 QrsvuX59aIPkDIk3SR0AQpO3MAYlaES8FG7zeJcrYQfF+EQ2MuyhTf9n5wnimCqU88NsYIWWlVA
 VEuQt0dTArgkGgNTZq2ghox7zmdoBh5Vlu8joR/Nk0H3BZI5D8pP2GJaa2WTXcxHgXqTBH44L9/
 p+3RtI3pROOux8DvO5EvJClYgR6cp0lv1urZ8ci9CU9WitEw+0yyXW1Oc3hmW3qcsKQg==
X-Google-Smtp-Source: AGHT+IH9Ug+tXWFOf2UeGqgcD1NgDEb2UZTvURkYWo2hu09zwSpfrLr1j/I0gCcoivgCgT1Cq4ZIJw==
X-Received: by 2002:a05:6214:2c0a:b0:88a:38c0:538f with SMTP id
 6a1803df08f44-890842dd443mr214519426d6.61.1768144684858; 
 Sun, 11 Jan 2026 07:18:04 -0800 (PST)
Received: from st47p01nt-relayp01.apple.com
 ([2600:1000:b19c:b9d9:b0a4:2ee1:3986:5e9d])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-890772346e2sm125909716d6.33.2026.01.11.07.18.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jan 2026 07:18:04 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v2 2/2] mailmap: add Scott Mitchell
Date: Sun, 11 Jan 2026 10:17:58 -0500
Message-Id: <20260111151758.89015-3-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260111151758.89015-1-scott.k.mitch1@gmail.com>
References: <20260111151758.89015-1-scott.k.mitch1@gmail.com>
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

