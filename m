Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B780C9830C
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:16:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CF994279C;
	Sun, 18 Jan 2026 20:14:09 +0100 (CET)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46]) by mails.dpdk.org (Postfix) with ESMTP id 13E634275A
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:08 +0100 (CET)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-653780e9eb3so5282568a12.1
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763648;
 x=1769368448; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vVLMaNm5J53Yt806so8EkQSveTG/x4NlA/bG+ISRSpo=;
 b=XSGfRXAmm8sCEnT23fWlRo9TZzj58e9klY96WJ9U1zQIw/xg7F34DvVhMoBzqcBWHo
 D7RrqAI2NkR68eqt3LHWcL7UlzHV9JVEkzfYOyx9QflMkmNRJK5OtSRBXVyLV0gW++tM
 nu+1PzhtJ1GdyQAqcHHuX61Tl8qwl2YfsE6ivJXNZ2vo+svcLcXFcbJKhTvYd27kvhjM
 242rmTN2+6fJsn6W/TUuKre2qSvMzxtww8rXF+WnTDsPsyW/bSPzWSHu3aF+DFloWW0B
 r0WE/Az2ibOuswxAcnilzCvZd1RB2HNCzjl5QVoMvOlrD1+F5Jsk2/p8XRw3DtEDMBLf
 VXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763648; x=1769368448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vVLMaNm5J53Yt806so8EkQSveTG/x4NlA/bG+ISRSpo=;
 b=HG5XOO7RSfneTVLRF2iL5NgAz3oZtjN3xwUxSBUZEk1Omod9qPTwlfVtpEm+R/cOCl
 CXo7vQPIrVf3BznNWWzkkszLGLSDf3SWxk03+faCzJ0ihsPCuEq0xO3RZ+TeFL2YRPOx
 1Cjlot5nFwjrCLTkrcjQJi9Mofl+/+8sdwiHnRPzixAUv4xD4wPv512C8cfi+jVdwXRI
 XTad/A6gAD60V0WQSz349owR5puSWupOUjISpRycFjlbdfJX35pshpi++1xnxMmgYx8n
 Uvx2g1iLIMsDoKjDBwcycfCjcJRIWCb1Xcc6uaxnAUeAu1Qm21z0J9ADIRhlH4y4p/6z
 4tWA==
X-Gm-Message-State: AOJu0YwxuvEhbLDIJRNIo4nYnb6UpUfyz3fsdLaX+M/XWfeTRhYoCTkM
 QHmaNX8wKne/lf6KLVdRyQ7pKAG2Ortb7a/0lmzF0OxPloYhP6H9YRozCw24WSLRy1no/Bh5Eo1
 abuqt
X-Gm-Gg: AY/fxX4C1I9ybi45Jj5mnuGtwWyO9bGXvN6BuaRqoFOl0T3tnwYaTNODNoK6/Wrkv+Z
 +YO+c0cnYfk0bEIsHoSyNqNrmLvbJgHDhhLHmiihwv8VgqzhBrIZs0QoLq4xuHUl6Hs05H7TvBf
 TPxil/vfqGFmFTa65sU72s3WZi73vywICr7XkcUY/dVrTh9fOwgzLy1/3/WZumHpVfOZI3zJk+0
 LoVZExR1tpPDkrI/eTqYX5A3ziwU/bxy0RLtkBXNwvU6IxpgNUgm8JwMTCiEyu4xi3HXL2ZPxh2
 aW9byoso1AMO5KWL1lAb3MhjFakU70qaiCe4iHBrZQZlYT8GWqunFJ5/LuZOCOrJ3V9Wf91RGyX
 TQl3jw/pD083NR5Olv5aiY6gveTnLNVKbd94KCXz1yqrXO7lYPP3F7f9PV6Lf8qKrbadMreiCUo
 +Wfz3Dhe0cb0GZ2wmvFDxz3gKfOvAGFPpHsmAal25MPw8WB9CcIbOTDPy+QyEd
X-Received: by 2002:a17:907:72c4:b0:b84:2b70:98ec with SMTP id
 a640c23a62f3a-b879302460dmr801399566b.42.1768763647652; 
 Sun, 18 Jan 2026 11:14:07 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 25/54] doc: correct grammar in lcore variables guide
Date: Sun, 18 Jan 2026 11:10:28 -0800
Message-ID: <20260118191323.241013-26-stephen@networkplumber.org>
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

Correct "Non-owner accesses results in" to "Non-owner accesses result in".

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/lcore_var.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/prog_guide/lcore_var.rst b/doc/guides/prog_guide/lcore_var.rst
index 3d9384bc33..2605dcf0d7 100644
--- a/doc/guides/prog_guide/lcore_var.rst
+++ b/doc/guides/prog_guide/lcore_var.rst
@@ -75,7 +75,7 @@ but it should only be *frequently* read from or written to by the *owner*.
 A thread is considered the owner of a particular lcore variable value instance
 if it has the lcore id associated with that instance.
 
-Non-owner accesses results in *false sharing*.
+Non-owner accesses result in *false sharing*.
 As long as non-owner accesses are rare,
 they will have only a very slight effect on performance.
 This property of lcore variables memory organization is intentional.
-- 
2.51.0

