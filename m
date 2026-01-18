Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A82C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:18:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D41642E6D;
	Sun, 18 Jan 2026 20:14:44 +0100 (CET)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49]) by mails.dpdk.org (Postfix) with ESMTP id CA48642E5D
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:42 +0100 (CET)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b8712507269so511247666b.3
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763682;
 x=1769368482; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1KZbEW1oYgGyyRkaRyVI3KXYv1WERe5XvQTUaTpc18I=;
 b=ac1b54D6bSgDHuoTEBSWR3ZfWN4E8wDl4IPdPRsiHR11UlEAKkg4+8L/fLgVORafRe
 nyZVE/WK7tlLm8y7TAbW27WjqXoHjXNVsAUEeCwoCDGynLCYoNA9I9vzAqxh6kVe/3wg
 s2PzKsiqiDUEaIWdKEZBtX/vQEmKXQ9MQhc6oci0V7ANYiZHKHmvj+cEtqZawPFJz9uQ
 qtMuM6MHJX78zmoMcUtXQSjdTRRKno5OvyKv9Jcx0kHR61i0UL9iSKilkq2SPOBE3933
 y8arre1cC7eO+6QHxQ0JO3XPsQ3BMqGQa5SssABhMmqXz09GeyLV4DDxXKDRvy3C4fQR
 4nDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763682; x=1769368482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1KZbEW1oYgGyyRkaRyVI3KXYv1WERe5XvQTUaTpc18I=;
 b=D4yxerZ8xcwArYZ5rhk89DMByP3qa0KszgEoUCRDSyQiEmeE/wKoGIa4T8SI5LhjyJ
 CRd0JskE75w6ic6Bdw+wIQX3Xct5zu7PYeH1gXtyWsgvmSrg6QtppMnJwRKXIuW490v4
 h7IbcqaAUlQHpJdR3OF3dALUagiHhVaSze2NgKSQRwM8PepzdFiiIhfkzw9rd/MDOrOo
 y2j4/354x2dPMcKDi4omYuDnmqFKLbU2PKSSgNyhSBN0ZuGJQfKInb1fWtxsEgrbAdeJ
 wog+91dtfvwS9aO8GZ5VTBYr+tLgANnFC4w1AptUXSlx+BPhZS2Yp8zAkRmI36db37nA
 9i3w==
X-Gm-Message-State: AOJu0YwEuimtstFy5+ub/CAu7v5YR/THBLHY2KDJjkIfn0QKSa5hH59g
 9a9hI30xUIRsyA6OeYqf4lft/gEsb1L9PBSgR4E2asLjlJVs4jmgxC2zNPc+9VB7pyLGa42Oo1K
 tOJSQ
X-Gm-Gg: AY/fxX5jKFbtkaxBwYRJ6TP4olIeyAfwyWlGTuw6Rwby9AeJsttyxy0A0CEPIIJd0ml
 PJ28lytoi89yOOIbld2BGdaMqfZAH5ApkXhHInBJNi4aAmBVeMk1gg1ZehRSHsYGDGjpfVoKZK8
 BlQDSQ8KcuzYScSt9CL7zOoSO+XBmSQUsyr/BKoVL3OxWrxELGDmpKyf94KsDK5oB+15XWul/Hw
 d2tDO9oJ8qXUzA//PmZhjEbCG8XD5beRv7swwojxoDnzzKZbgKnoHXtHuVLvBxQzp9hCj0MxqO5
 a34pbkoDFkJhlASYA17sd1yarFqUhUR3p7EL0mTVrDh7uw2peSiwsMT6Mdw4hKHn6DsmMPyZMlw
 /VmnnvTr3vyhQFO1TTDidQAXqVw5ItarFNA+KbXTC1rNUYun1Ojvx15ajLIGSMq1D0B6nKTn+bR
 MpGk3KQocwo5Q7/6s45y99jAjhri5drxRZmDi71YpEF/WZo8iTQhlTye77KfvvCMd48NOGfF4=
X-Received: by 2002:a17:907:3cc4:b0:b87:2b1a:3c55 with SMTP id
 a640c23a62f3a-b8792fc438cmr859028466b.39.1768763682379; 
 Sun, 18 Jan 2026 11:14:42 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 48/54] doc: correct whitespace in RIB library guide
Date: Sun, 18 Jan 2026 11:10:51 -0800
Message-ID: <20260118191323.241013-49-stephen@networkplumber.org>
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

Remove extra space before "the" in API applicability note.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/rib_lib.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/prog_guide/rib_lib.rst b/doc/guides/prog_guide/rib_lib.rst
index 40b7de3f1d..e95d85b2d1 100644
--- a/doc/guides/prog_guide/rib_lib.rst
+++ b/doc/guides/prog_guide/rib_lib.rst
@@ -24,7 +24,7 @@ Next hop IDs are represented by ``uint64_t`` values.
 
    The API and implementation are very similar for IPv4 ``rte_rib`` API and IPv6 ``rte_rib6``
    API, therefore only the ``rte_rib`` API will be discussed here.
-   Everything within this document except for the size of the prefixes is applicable to  the
+   Everything within this document except for the size of the prefixes is applicable to the
    ``rte_rib6`` API.
 
 Internally RIB is represented as a binary tree as shown in :numref:`figure_rib_internals`:
-- 
2.51.0

