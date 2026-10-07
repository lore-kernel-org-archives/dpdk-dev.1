Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3801CA6002
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 16:17:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F54840268;
	Wed,  7 Oct 2026 18:17:42 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 9B2C040265
 for <dev@dpdk.org>; Wed,  7 Oct 2026 18:17:41 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3a4b9732d5aso1955970a91.3
 for <dev@dpdk.org>; Wed, 07 Oct 2026 09:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791389860;
 x=1791994660; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Vz4FYHktuA6Fdd+h6a3fiOocLojIqsspKeBi7yRUM/k=;
 b=l2UODZQTDTkc0ID9iEglpVYUXFTnXvj5JhwK39SpSrdb8HzD1j54mGdiFZqJSZHSCC
 19IGhLAfHDvqMRo6LRhW1cT6hZJDZk1COtI62ic1hP4QHNPKfslTvwaAt1XQ+nFKiO/j
 0jZnt6GZAKBZNofz07V1yMQmwjw0tnxBinUNKTZPB1vCs3ousnUgXTkVOeEjaxl3Iite
 my+qvIc3Z5fVwUs8ZWj6sDrjnfVH0rHgsKmGlzRJW0fukRFdl7ohN34YHBU9waeZrr6a
 HbNPK/e2vgH4ANC3iW4uKfqk2AdR376uj7C2xp5XS4u4R2BylhU7Trkb0EQGGxzfCpvG
 PXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791389860; x=1791994660;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vz4FYHktuA6Fdd+h6a3fiOocLojIqsspKeBi7yRUM/k=;
 b=xwhH/I2bwsbR02/kSgi9GNGA/79SbLSE8bNxie84PIOVYZP2nxPifwn7v7pwDzD8HH
 nxgtoHiHrxBSMEe7Dmq+ogcRqSdEkOfhTdAfeKVjkNYo5Wr5XhZA2TAl1PXauAcgGarx
 JP7lvt1Z5vmoQcFqTpajWXo1nJ9rRwHFbKtIjjDwa+wrOs2V0V53ZPGkoUFsT1ZqPerz
 P0XNF/6gtr6KUotvgCQgAoTNEXHVselRCrnOja9l4a9/6aA4WG3J4dCe9NknkofgpDN2
 YdkBGLoXaHfamdW2uThIFZ1OpOu/mpvpGX2Xuhsb2G4vmafyPpikLb09dStRQE5r3K9W
 Dl7Q==
X-Gm-Message-State: AFq9FYLNWmvaMnejivzJamxbB0V0Y7wfBJKmiNk4Zua6HX9WlRoyUND+
 zLX7iAggWr/eZd+EOpebra3ECm6vWAq1MFi2aAV28FwRcYSw7dTm1dZ8vgQtM72l03WHcIxfVd4
 qfQsE71E=
X-Gm-Gg: AYBFou0+sMf5u7O7csmAwjjuLz7fO591G4R0GT64EpzqZWTl+8DEnhJyHx9oc423/DN
 GCGnlNfMlduF7jJMmrsWEZuUat1GNMO0jWTNrUgCypXGZXdKJ/6vAz/s0mQfXhIropB1kK4cEQz
 B2tfh96PrMOr3zf/Bkp4XWNSGeOlVJs7XTauRAvrhd0Gx0BtHqTUyvQu/CZ3YBQbKAx5VRdByff
 cKmXQU37xWFNVMUManfUsWQDSKGXxWTErQMQr1lxWYAtX/0pgUhU3hUhhwG3ZqjtjnvU+HdZSXP
 K6PwKfh/USiibpo2cQZMqFr2lVUjDAj05s85Ae1UjTa+LmksxdN95r0937eA6rvt5QsUIg14Mn1
 ulBNCTfGSmC/x1bLf8F6W4ZU6xP43HNkWP5/EzhuS9uInGkwlv623SAmMy/fKxbIcvNPJKMfSMl
 fnetxikxbcB6Ih2Wnb2L8H+FLVoL+zyuqBIEHrAQ+PvMxlxgx0gQOBsta4+5KYJ4FacK5SPnFjB
 pvkwRWCdcW+k/7SM4LbKr4BecXQ665eY3b3Vg==
X-Received: by 2002:a17:90b:4fc1:b0:3a0:a781:2c39 with SMTP id
 98e67ed59e1d1-3a89f649e0fmr2560686a91.7.1791389860305; 
 Wed, 07 Oct 2026 09:17:40 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a9ff5b3b06sm132762a91.15.2026.10.07.09.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 09:17:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] doc: announce removal of legacy telemetry
Date: Wed,  7 Oct 2026 09:17:37 -0700
Message-ID: <20261007161737.2351221-1-stephen@networkplumber.org>
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

DPDK has carried two telemetry socket interfaces since 20.05: the
original legacy socket and the v2 socket that superseded it.

The legacy socket was kept only to support dpdk-telemetry-client.py,
which is its sole consumer. Everything it reports is available over the
v2 socket.

Announce removal of the legacy socket and the client script.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/deprecation.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 56a67c372e..fba852020d 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -138,3 +138,7 @@ Deprecation Notices
 * bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
   ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
   Those API functions are used internally by DPDK core and netvsc PMD.
+
+* telemetry: The legacy telemetry socket and the ``dpdk-telemetry-client.py``
+  script are deprecated and will be removed in a future release.
+  Use the ``dpdk-telemetry.py`` script instead.
-- 
2.53.0

