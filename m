Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C97CD6E5D
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 02:32:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79D5D402DD;
	Wed,  3 Jun 2026 04:32:13 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id ABDDB402D3
 for <dev@dpdk.org>; Wed,  3 Jun 2026 04:32:11 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-304e6c6464dso2124416eec.1
 for <dev@dpdk.org>; Tue, 02 Jun 2026 19:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780453931;
 x=1781058731; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2QPultiq0CAB9zru9vejO59cElG9gWUqVTsy4bccby0=;
 b=SKS6Vq0Iypv0h8XQ+uP/qjuNsddnR56NOUHsLfpJw2/bN20NW51m7T4V8oe9cS/GKR
 QaYl5n4lX/Cbeq1zTWzPpE9Ibk2agoClA451kYhCR551UPqBSva7pjacBS+7pO/c0dcu
 ZCxz3GH8Z1rqLXT6y61kDaWsFEgreaLM3CQiWikbqQlkzYUBC0GrFyKEP9w0CL+JhLyH
 /L/Xl4ow2XLh+rSp/o5bJ7CCIzq1zrat2B6ai9eaL3W4O9ar42IwRHdO/aHcZ4zBwJFc
 JyGPwTBcNRuGwqfVx+1XXLRIjSTdcjVo8xXXUhc/0ojD5AvVOeHWqRp5FdVPtSj5cOB2
 VIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780453931; x=1781058731;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2QPultiq0CAB9zru9vejO59cElG9gWUqVTsy4bccby0=;
 b=EcQdBe5+NEtTzfAuUAJ6L6badPzlGP8vC1leHnMzd78OgDll5jDnGH8gQg3c/VAcR3
 +PgXGPUdbY723anmCxgIxR1RouZVX7PpkAvFBs/xtgROmY5saGmJlibt7lLxHwMA9y14
 xdGPPvV0kQNYEjpF+pvqFtgOase21kPAGZU84iZysoLgFEp7Ig8ctX+xu7UiVeTMYzf2
 fRZIEWvIxEqR5+BgFyVZzkGhQPb7eN9vvqKsmkzQXEKJt4c/9MCIcQ6mw2r7sJYQVy6j
 vRjJbbA8r7ifJc/E3eBwPoqWM16s0GxxwEwcMjnwsZYsD1tvo0e4n+conzRE30ZVlOwk
 iFtQ==
X-Gm-Message-State: AOJu0YwetmLzXgc3A8ae3IjVGSnWVEs9T2RZ+x+u5rbRBUNqMKfnJ5Zr
 tP+eeGnPcxsauFj82uDxgLzyFG+eEnSFGocnUCH5ZZrJPF70qv/abD+em4LwgNtrWdD4nUis97g
 NCXAd
X-Gm-Gg: Acq92OG0vTxcP2RpIKPGD+IiiSEL8zwBnQ+l5kHeTJIxPgoRvqflmC/w06seXJgSqMJ
 18mANq+PzYK8fBHSwaCLGUfbb5PI3HLvsXMxSrnOCbO0wS72bpAjXaB+0m5Gsa0cGJfcJMJ9NBv
 EDEcPFJ1+8vbPSdpNeQitADhKnRAX9byTDyNIjzAKwVoaFrb2QKkyhTFegDroFDv5NvKEZHof+y
 xT9IHt56U1vk+fAitzFoDRC9uNtWcVePIRYiVskVLPpz2g5hCUOv7vbgXDGlGme/YwPiDrV2hw4
 d74n4dYi/Ltkd77OzVtlFN+85x0MKYP21c/mCeBKJQldB8aUQyDFsWOAPeWRN5QIC8yJxkiNnEm
 96FD+MDZOmha+oq+oAemZCGP+Um/qH88bpLnD0+mf2DQUQQHx3OLnfYkZaX3V8mSldiKSBSAno2
 GkXcqOXd+VQO7pwsrbBcVtMKaIYOkR0FAAMAV23RYzWjLv31xkWoMX02pN7XuQy3s+3TbCkKdx
X-Received: by 2002:a05:7300:ca8:b0:304:dfae:68a with SMTP id
 5a478bee46e88-3074fbd4663mr761219eec.28.1780453930596; 
 Tue, 02 Jun 2026 19:32:10 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85e10sm1182482eec.7.2026.06.02.19.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 19:32:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] doc: add deprecation notice about upcoming change to ethdev
 API
Date: Tue,  2 Jun 2026 19:32:07 -0700
Message-ID: <20260603023207.31974-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Inform users that rte_eth_dev_get_name_by_port() will add a size
parameter in next release.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/deprecation.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 17f90a6352..d390a1640a 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -158,3 +158,7 @@ Deprecation Notices
 * net/iavf: The dynamic mbuf field used to detect LLDP packets on the
   transmit path in the iavf PMD will be removed in a future release.
   After removal, only packet type-based detection will be supported.
+
+* ethdev: Starting in 26.11, the function ``rte_eth_dev_get_name_by_port()``
+  will take a size parameter as well as the string buffer.
+  This will detect and prevent accidental overwriting of caller provided buffer.
-- 
2.53.0

