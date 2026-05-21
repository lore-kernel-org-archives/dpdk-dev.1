Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA6ECD5BA6
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 04:20:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 251944060A;
	Thu, 21 May 2026 06:20:51 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 09EA74028D
 for <dev@dpdk.org>; Thu, 21 May 2026 06:20:47 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2f33ae12f97so4213685eec.1
 for <dev@dpdk.org>; Wed, 20 May 2026 21:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779337247;
 x=1779942047; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERBQqfhTGBwZME3c0IWG6PAo/6rvtEP+a7QxWKi/sVs=;
 b=sNloZQOh9KpNTU11SuKO6RG5CJWD+xDYuRTJRTwrD85e8fUyGY3AwRvqUYPqZDo5dJ
 tyIULllo5/xQ9QeY0e2Y6OEBJDRFhGaDEe7iMdO4W9TNUFbUxRk7NB96Na577rq6RJ8K
 VZrGtLSIp6Cxb2r8GlBqXOzpO4vemTxILclXcF3pVaLMTZEM8vZ8p32wX17KXytvQKYr
 Q+XkB8SXQk++AeSXvtIyIhe7yQNU4nG2SuCKFp59gMgzeQTPzjbhINMHN7c1CcHXKVgz
 bfI0cdW8XqsmtozN9dXXtUw3cuIQUwc9ok5ABQ6b/Qv5v2Gr7HG6MQiF22DdKjPWoLJ1
 z47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779337247; x=1779942047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ERBQqfhTGBwZME3c0IWG6PAo/6rvtEP+a7QxWKi/sVs=;
 b=e8HXwLrsGz7dwh3zjYqR4AJiGvUYrF59D35Sj/iXjGqBmF6I05hSjTAJRfztyf0Puc
 8N62Cls3kXBFRvfkhdQ1jjptSDNB0YjO6HxbgnYQuv2zYrOHDpf4O5AY9UPiulNd/fP9
 oRpaJ4mBS53SbhMBDSVDSn0CSDRWBnYrlr+mDg1xnmnennoizdqb357xHc7Ha7BMQHDA
 fF57Zb8ntcW7pjQQabB3ekcph8y+XebErEv59I/scKEkv25bIOKYIW4OqODi9uDgnzdr
 G9xyIDHG8EBohWc25F72Rb7orY/qQ+sKFAF7/64YILPeS5KygmNmNsjFpf6msYxiImBR
 lYHg==
X-Gm-Message-State: AOJu0YyOW7j458MDJqVanYz62i7Lre6fewScmLyHWesUcJWOTbx/h2w7
 ldo7SnFnOCuin8heIP+B+37WFDbkFscDXcJreSOA+9gwi2+esjqUc7DLBgPCdF3SV8I59AsNeh6
 wu4ot
X-Gm-Gg: Acq92OGpLqUOYwg5ywn0e7c4BDGrTSTbC9jqfe6GJTZNrLKhUG7oVRIWmQJp1LBSi83
 yIQeW+d2KRXHS4lo96qBOL0Ey76ywsRxYF1cYGY1NTw8gTOrKIwW7MmAy/MdMgj4Ikg/35ZMOOs
 93Z1pc3aDKF2AIJSgLqDFxaN8V8W3dKNX0KY5Giyzf/PMdQM20xKzZpHPZBBkQhidgAA3smxaGQ
 TC1CeOz0c0OMX+F+PAU/lAbh/Zg57sKLjsQUxflXSyBrClAoPVGuPxJmHPua9HKWXJ3W5OvzmfA
 YfMgxkT6d5/0GxWjMnU7qzaZ3FYbubkfe7DnaSESDCUetVGMuNe6Qx/wmeZVeYgE+zpxGHfnwxF
 rG8ZU9b1TgmI+/4Ha0KTnY28BsstE1hFLvAKJnU41YPk/KnL9rOfD/6xCJYoESIhR/TsdwbSH7A
 7nIZ2l9yCmtYAvLN8ONVo5GLHDVt8P0gsHJnYyy1pJxCTj3ZkEA7ZTR7Vxqup6bahGnKKr+Tmg
X-Received: by 2002:a05:7300:7fa4:b0:2ed:e16:6b4a with SMTP id
 5a478bee46e88-3042f9c438cmr819081eec.32.1779337246893; 
 Wed, 20 May 2026 21:20:46 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e686sm24347748eec.5.2026.05.20.21.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 21:20:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 1/7] doc: update versions in deprecation file
Date: Wed, 20 May 2026 21:17:01 -0700
Message-ID: <20260521042043.1590536-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521042043.1590536-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
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

This document was mentioned 23.11 release and needs update
for upcoming 26.11.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/deprecation.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 35c9b4e06c..346c517623 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -7,8 +7,8 @@ ABI and API Deprecation
 See the guidelines document for details of the :doc:`ABI policy
 <../contributing/abi_policy>`.
 
-With DPDK 23.11, there will be a new major ABI version: 24.
-This means that during the development of 23.11,
+With DPDK 26.11, there will be a new major ABI version: 27.
+This means that during the development of 26.11,
 new items may be added to structs or enums,
 even if those additions involve an ABI compatibility breakage.
 
-- 
2.53.0

