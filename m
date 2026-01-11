Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4C4D2502D
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Jan 2026 16:01:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BCAA40611;
	Sun, 11 Jan 2026 17:01:43 +0100 (CET)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176])
 by mails.dpdk.org (Postfix) with ESMTP id C93134028F
 for <dev@dpdk.org>; Sun, 11 Jan 2026 17:01:41 +0100 (CET)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-563610de035so2202629e0c.0
 for <dev@dpdk.org>; Sun, 11 Jan 2026 08:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768147301; x=1768752101; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HztIkd3sqOJocgSdhV4MJOI3rL1Ay0k8/q15iB6FdSM=;
 b=FWqAUdscPyxYNUavHxbJxaH6aj82idWYeff9tS1qh/bXBJgvDVMw+SDs2eWkt0VPym
 ckXTFjvS5NsLoXL4H1PnY0JpzZAMD4vtrgGEUa/Kh1rk6moFTpMsSAlYa0eyPOtdIwSc
 HV3CGAYPnHmp4aumq6Jqy1m2cO8g9tnBszHgEvGhNBDjZdYIiet+jGxZCv04sEsyG8A+
 JL2vIu4GeeNC67ITIjcrTQnUqljWwe7chX1nJ7Hvo1KCdgkEs/tWYR9nCWXzW7kC8OY9
 sPLGDbbDYfUeD/YUT5NlhyhnsGnbRbJ1EzmTUn8C7Ei4Vt7ehkbF3BFu1HHMKasPpFe1
 rpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768147301; x=1768752101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HztIkd3sqOJocgSdhV4MJOI3rL1Ay0k8/q15iB6FdSM=;
 b=sfoaBLizWOLAU1wqCJRnui7wnBRjIgWsAroUeDTCpxZ+vRggaK8euj0j2m5cISwwq0
 shLFMQSt3rTDe8kqbLCtu30YA422RuXtzqMXZRqBTGhmGJpQh2y4ykTqc0wpv008BJCs
 J7kZU62gR7dgUL5NxYondPSQ46Tnjd6X29QgkUx/80hI8VTuRyAO30Irt8eSFVFZCCOd
 6/K5zJfIDEgBxCFs6df1a17ndtbs3u6oWSIKPvfEp9UxIOrIzX0HIukIW2SxdqQtlydP
 ETXoqSs/GhEsyXV1ppqzf5OpYoxXciD7rtqShtIoPrujxK4IiykiLdEtVGccyBTJicmJ
 ZOyQ==
X-Gm-Message-State: AOJu0YxCdknqWxpURbD0bcQmTwDvwzdrl733KJkN8912r87hcKiqfidM
 M2G1Ubhtl/iItpeJ84daq/ZrdE0Z4oKMint75dira9CMgwXCM4s90ZqH9d84sA==
X-Gm-Gg: AY/fxX4wqHU7BM8Pdf8HodV/wEF7oYVi1LiBU+VHzBnWK68BFsX8ONSi/kAWCT1kACE
 41YWjgQi/7w0iUL4p4IhniW40wJ4qDhkV0z2+h7pkTNFM2wPt6t2tYK25DS7fxYLSxcDXIQwT2n
 LEG8NIKdbDCjPUk6iW/uygLdLYsQDVHspBxUrw4x9rJJrdQrj9gfHogTYRaqcSOpO5JOLTjAmjj
 UkxhF4W3czJ/km7QymirbGvU9ikKpcCznn/Eotr5i708kwvDOzVEZedRxVm859ohkGp0g0RcP0G
 qzte6sdu1NuEfv8EO8IfBnZCx/hxX0/6HsfnCB6zhX7hDjgTD+lxOUTvgnRSvutfonk+RpWxvpF
 EIvENJZNWdeZz2o1LFPRFhsdhJ6NrY8ANqLqHe6QikvbUM8uABU6YnAqjn9fcYXDrM2oHit9Q9h
 KLRZxJRpmOaNyyPd0qoTndst4ramWV4KuHjNUnqsKy6g67dMYEpEL8r4Km0zOY
X-Google-Smtp-Source: AGHT+IFbUHuQu7ZKvwn/TDJFOR3yJ7LZ/TPdHmPv4o0AF9veqMEBQomYUTfG+aJl80+0pWJulJmZLA==
X-Received: by 2002:a05:6102:c89:b0:5ef:ab71:cbcd with SMTP id
 ada2fe7eead31-5efab71d1d4mr2251493137.7.1768147300956; 
 Sun, 11 Jan 2026 08:01:40 -0800 (PST)
Received: from st57p01nt-relayp04.apple.com
 ([2600:1000:b19c:b9d9:b0a4:2ee1:3986:5e9d])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-890772681desm120304066d6.51.2026.01.11.08.01.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jan 2026 08:01:40 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v3 v3 2/2] mailmap: add Scott Mitchell
Date: Sun, 11 Jan 2026 11:00:59 -0500
Message-Id: <20260111160059.293-3-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260111160059.293-1-scott.k.mitch1@gmail.com>
References: <20260111160059.293-1-scott.k.mitch1@gmail.com>
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

