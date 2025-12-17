Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A33D65C7C
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 16:57:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F52C402AC;
	Wed, 17 Dec 2025 17:57:42 +0100 (CET)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 01A5B4025A
 for <dev@dpdk.org>; Wed, 17 Dec 2025 17:57:40 +0100 (CET)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-8b220ddc189so782172385a.0
 for <dev@dpdk.org>; Wed, 17 Dec 2025 08:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1765990660; x=1766595460; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJ/oc0kMFxyyz83ffr0SgWefaLzcSbEvhq/j/zxFNb8=;
 b=SNmenE8EeKBJg1N1XmB0RIpfhAqnjxWV2sG6B77mhuSMEDtsGG5EppLHcJPijAafjn
 Roy3O+Jwa4zZ9SX4Nw/w01H/QgA+yZWBWqJiOif/0MDqblmc5i+wHQBmWXo5HX2VCWNV
 ksV9diI7YqUzrvg+IwvSaEQxxWcbqwWa8if7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765990660; x=1766595460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KJ/oc0kMFxyyz83ffr0SgWefaLzcSbEvhq/j/zxFNb8=;
 b=D/eeBetucVnkcek3rQsIwXfUIa80CSWIFxVvSFsfZWRZndKQy62SKM51RzUaYUzl2T
 qSfTkwWh9CEvua9rNAF62/A/6g93//uQ3by5pF0UjSZTbvJAAiqndcLjX+PEpk4VOgBA
 G6O3Hoq4O8nqZTKLtZt9rG+QNGCuvK1nFc4P8Eyuooam6frHB094JgapBZZyeK/1hQVy
 Q9ub/p66BM/ozb43fm9VnvvNEl3Qcqev0KFHZZF1t76xkAczVi51LkOT4LNRDSXYX2WY
 wK3XnIT7e3Jxjpoyx1HtHj6k3AOxjungptYJSrQB1KnTB5tWv86tD76WzTC/Y+/J6SrG
 yzzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0juyof6VYtw+AubJnj1a9b4TNvZVJJrd5JaMjgYjWpha5KLh4bxfu0teNBwVAccQ04l4=@dpdk.org
X-Gm-Message-State: AOJu0Ywy2jBMGuw2tlG3CSAxhGUEYRxCor4UtLHwbouwOPysFHXPbHtd
 dCyGNLrJ0Lejn7euJs8gNhJ5i+Bx+ngUZArXhAp4aPMf7tFCJYBZF2j8SAlI8CB70I4=
X-Gm-Gg: AY/fxX5+xMt0269MA4R+OraDuYZKA0gjM5mMRFx4c69Q5UCiYAsL6P/+vCmYHjHuN8L
 JmY8V5Bo9QBUHb8B5o4p3fpDLwdJCEu9pXj4S29HDDogToWx3Xs9UDyhFMqfP+mVRlcaXvPfdq3
 PCwwFFFb1by8HRvszF21NCEn2Hr6Fojqi/OpqXGod0/plo3vp5mdiA5be7PXFC7moccL3BpjM0j
 62d2M04OURxrHyA+KQvxW4uW/yUNaEtqLu6f3G+DhNt1RNZp0rjaCFU0t0s494Cqpu3wSg/X4jd
 gx72p0S3oQR2YJYeXWPyABQK4Y/3loNqybCN5TT5ZEEUEVnlhWY6lH08D62POzcxmclrkMbaxnH
 pfva6VUuUR1XT0YIRt25a6yNlt7M2blX5hzNSFCTpH5byMky70u8GaoKtZd89SMShMlqcAP9dCu
 EM23J55LPJMvnS8OZIbRqJFgs=
X-Google-Smtp-Source: AGHT+IEGYmrIYXebiL+NHlI+pyeXya43nLetTsVFBIukgHy/clZ6SMu/ezghrxEcu1nvhqoDh2Ex9g==
X-Received: by 2002:a05:6214:2e8f:b0:888:7f91:e276 with SMTP id
 6a1803df08f44-8887f91e805mr202706996d6.30.1765990660230; 
 Wed, 17 Dec 2025 08:57:40 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88993b4204asm99300326d6.7.2025.12.17.08.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 08:57:39 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: luca.vizzarro@iol.unh.edu, dmarx@iol.unh.edu, dev@dpdk.org,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v5 1/2] dts: make one link the default topology
Date: Wed, 17 Dec 2025 11:57:15 -0500
Message-ID: <20251217165716.705128-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121195511.322005-1-abailey@iol.unh.edu>
References: <20251121195511.322005-1-abailey@iol.unh.edu>
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
index 243759668f..801eb0c9a2 100644
--- a/dts/api/capabilities.py
+++ b/dts/api/capabilities.py
@@ -63,7 +63,7 @@ class LinkTopology(IntEnum):
     @classmethod
     def default(cls) -> "LinkTopology":
         """The default topology required by test cases if not specified otherwise."""
-        return cls.TWO_LINKS
+        return cls.ONE_LINK


 class NicCapability(IntEnum):
--
2.50.1

