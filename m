Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4A0C55174
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Aug 2026 13:50:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26C4240A7A;
	Sat,  8 Aug 2026 15:50:39 +0200 (CEST)
Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
 by mails.dpdk.org (Postfix) with ESMTP id B4BCD406B4
 for <dev@dpdk.org>; Sat,  8 Aug 2026 15:50:37 +0200 (CEST)
Received: by mail-pz2-f1.google.com with SMTP id
 41be03b00d2f7-c9fe62e0da3so156817a12.1
 for <dev@dpdk.org>; Sat, 08 Aug 2026 06:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786197037; x=1786801837; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UfB1pG0wb+zgzqgPy5VNOn9nBmF3Ksfoa81pRisCfOw=;
 b=f7XTdbEKdpUfZZfgBdIjR7JA+im4X66aTe34AzoHk31b0yh+XVlDmZajdNxf+UrPJb
 XYhqAaUHPowSq/zqmSBLGn4Z94S768/EN38Nex5F9T421cDxbFcx0HnQb/Q7SHYcIlsk
 YW2kXJMNerpbZSv/vdsbPvhT5ff5t7X1ME/rZh5nnDgepKTtKuDx+sSoPv7yhStlDRrH
 6xkDNBIEuGSaJGcMe1lil9JXi1IHOB7XGnjkDcPuRLFUJYG8dSX6UUCB9qWwdV0Fmy5c
 RErNMxh8170FYfs/dALJJOhzwOrBXtd9PM9wxRd4Y4qUxu5I4DyjGQ2dwN3i64zJs/Sp
 uQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786197037; x=1786801837;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UfB1pG0wb+zgzqgPy5VNOn9nBmF3Ksfoa81pRisCfOw=;
 b=X6tawyeY/6iVR1fPNadHxDZeSGHaCgrTRFl/SCME5pW91zGDzMkzmwqeob0T/SME4v
 13QoGuchf9PigzgNg5aHL6XkUPV19mhSWit7ko1glox+h/NAj++iKJQdrEmbpDt4URYK
 uUiKo2dAHU3K205ydhpNc5y9/u6RZnUTFhY8+pTOM3RjXV3DWWv1ewk5Dy1g58nRKngz
 JWJV2Zh6IYfP8fmmF4RsFKGU1nEtSwZ2tVukkoXapzLjSgx5VAyMk69mQbyCX1HTalmN
 6GfzHBU4abKUy3geStkHQ5Y+/KIb0NZd0NW9/uNR4VuJ/DiKEX3HBw3Wk6++ayQoZ1ao
 0N3g==
X-Gm-Message-State: AOJu0YzdUsbPUe+wjd2kXcodJB6zDfmajxjOkvYjD+gklYZrq/FFHzXf
 qkPYELYqqFMXKBuTKfkD8doFGHlBZHQtXPzbZwv//sNjxZryTyEXkIJNFi2gRd5pm6bJ5+XV8XZ
 fHQ==
X-Gm-Gg: AR+sD11gnwiSYqLKN7x79TBjS+BHEHs7QTXj/Onz9X8toh+Fg+gbBsDWSxhd2q8Trdp
 ekcwPmC86wgQfC6MqN+/WzT/nUgACapR46g8hOxC+7VngzH19t80IF/zbTlB2BlKggG/CzLGiyd
 Dg/OcofqWC35CXm5sy466h2LAZuJHH/8H6IAKfrpgSae7u7hoslQ+Np386bwl0u0/Iz/Ki6VUPQ
 vZBO9g1xI+SeXgo294TwaKCIqyrPNw7jpfD8eso/Vh3vFNyE1zbdrXLFoUW+YKu4hejSjE5vqrA
 45p60Leiae9CD+ZyZgSRf0kTZJq8Dv2ch5+DSDrm44DXb5J7hcybiQ50iNNu1iZT50bBL9wY7Np
 ccQ1SM4pC8OEh/TH2hpjqPexXttITx4Vonx+qO3nhLzuPX3L4m6t2Optqh9+jiL3TUqJgaDt9Rw
 oV+BosVYPKYZvVhpAwYqg9ymGrJxplCetoAvFJTA544EgJWb//S7fW72l1MtHoJmDls4a9enOOu
 A==
X-Received: by 2002:a05:6a00:32c7:b0:846:7507:4e07 with SMTP id
 d2e1a72fcca58-84f2e134696mr37156163b3a.39.1786197036563; 
 Sat, 08 Aug 2026 06:50:36 -0700 (PDT)
Received: from LAPTOP-H6E44CS6.localdomain ([223.104.44.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f5a589592sm2160265b3a.51.2026.08.08.06.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 06:50:36 -0700 (PDT)
From: Yang Xiaoliang <xiaoliangyang69@gmail.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net
Subject: [PATCH] doc: fix typo in ipsec_secgw sample app guide
Date: Sat,  8 Aug 2026 21:50:31 +0800
Message-ID: <20260808135031.18134-1-xiaoliangyang69@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Fix "depeneds" typo, should be "depends".

Signed-off-by: Yang Xiaoliang <xiaoliangyang69@gmail.com>
---
 doc/guides/sample_app_ug/ipsec_secgw.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/sample_app_ug/ipsec_secgw.rst b/doc/guides/sample_app_ug/ipsec_secgw.rst
index 7c31c96b7c..b40a15eb4f 100644
--- a/doc/guides/sample_app_ug/ipsec_secgw.rst
+++ b/doc/guides/sample_app_ug/ipsec_secgw.rst
@@ -260,7 +260,7 @@ Where:
      via Rx queue setup.
 
 *   ``--vector-pool-sz``: Number of buffers in vector pool.
-    By default, vector pool size depeneds on packet pool size
+    By default, vector pool size depends on packet pool size
     and size of each vector.
 
 *   ``--desc-nb NUMBER_OF_DESC``: Number of descriptors per queue pair.
-- 
2.43.0

