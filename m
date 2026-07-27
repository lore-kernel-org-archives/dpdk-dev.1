Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BBEC54F51
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 10:49:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E62340679;
	Wed, 29 Jul 2026 12:49:23 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 6BF75400EF
 for <dev@dpdk.org>; Mon, 27 Jul 2026 23:12:18 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4954a2e73a9so16915195e9.3
 for <dev@dpdk.org>; Mon, 27 Jul 2026 14:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785186738; x=1785791538; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=a1K5EGQatlX8QwsGRDzZczglESqbInhSG/nq1sx0rpc=;
 b=NBAA1UopfcvWXqXSaAUjEZ/iykEBkwxSqzM96ARas+zfzzaSdYCyPlWe3DO77+Axy6
 TLDoNDyYNrda8QOvaQJGndhWydbpjq6hJGwHeayUg0abPCu7vTz1pTXJ67Fn92QusvJr
 +pXahHAVqY2L30IuKq0JKU8fDFkF9Pv+1WbA9O+eRp23vXK7TZtRrpfFLpVqVNErB64U
 2KueCXlrw/rNE6IdDEqtGDwj7UrAbDA/U8U3Dgf2lrJrRQW24i3zfD3MbdqWGdf3omhU
 gx1+ZNyGAWirwhBmztThOMAsZQhE72KmuWEkGr3+W45uEVeOpDX8WQKIEC/fmlcll8oB
 Jpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785186738; x=1785791538;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a1K5EGQatlX8QwsGRDzZczglESqbInhSG/nq1sx0rpc=;
 b=B5wNTeLpbA/dNkOLn86UkdmgU1Ft6kbtyIG+ymtPSrZU18RbcsbL1CZMpHoGUYX2NX
 I7k/X1kH02pWp/VAUr+3342mfxHQCksevtRpxlA6k0daG9nx7xOopyKAua7vsLGGszPL
 M89PLhHY973zxs3Gv+127n/Z9gPesnmM39wGRrJ9slDjl4/Nn+9io8ovd0Y7jUAUQE2J
 Bv3ZhGGoeJcm9v7aiKG3mSDhJyH5uTVp94pn9ZOChkuMQ2pXj1YHVEyAM9V28a10vF/p
 BHoR63CsMV5uwV7QEhCTv+BTd5Gpr3YHHS9y1EuCUByvDu4/Xk4SrIRApXQ5bpDbrD1g
 Q1IA==
X-Gm-Message-State: AOJu0YwMm0vLhtPCuhHseV/suvgjne2mw1GR/xCO+ZUzaU3IJlGsMZrt
 IHy3diERN7HG+FIyBQHbYcc3O9KdvQyGkHxkheYulPScaQzuF8wGSVZw
X-Gm-Gg: AR+sD109MpgdMK0LHn6x55bgaJiPptyRCOWEpts+spauMNWHyEro02TG/J/PjzBd2g/
 RMQqj6AN5J29tmrliLBGXItHilulkDLQPUgQG5P/o188fVjWJX/K3z/hiT06IXBfEpwXCUEi6FA
 y3n/OmZcFQVShfxZ4fCy/Hwo/dtAcFz4Ce6GUgxA8gSB7m7zUW6IkLsXxLJIQELJIISC2ZG/J22
 ZUUlkQn4iC2nbBpxi+TMCArF9mn0hyEVYTYU0LlJcUTHKP4B+yvdSy7qcWhbKVy+3hqXTSgTioV
 ANDnvEz+fy6BKOlpJCcsQYejTJdPVlCCjw+L3dUDMgl8Tg1QqxQGnPtxtf/AWcbQbnjL6E82KkW
 RpgIFkjZeE9dIgHwH+DF2X1o8fFxM5G5nBhJaX0dAXIKkH4ge/3O3qyjZK42rCO/KJxtZBg2bZZ
 UAgP2HLawwzaLEX/Aeh/NsNGAn7wtQRSTlHVqqB3LLhzR/V2QWDw==
X-Received: by 2002:a05:600c:35d5:b0:496:bbce:fc with SMTP id
 5b1f17b1804b1-496c4f8ddb8mr7474565e9.12.1785186737702; 
 Mon, 27 Jul 2026 14:12:17 -0700 (PDT)
Received: from localhost.localdomain (89-139-14-107.bb.netvision.net.il.
 [89.139.14.107]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c44af22dsm18795225e9.1.2026.07.27.14.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 14:12:16 -0700 (PDT)
From: Kobi Kenzi <kobikenzi@gmail.com>
To: Thomas Monjalon <thomas@monjalon.net>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>
Cc: dev@dpdk.org,
	Kobi Kenzi <kobikenzi@gmail.com>,
	stable@dpdk.org
Subject: [PATCH] doc: fix typo in CNXK guide
Date: Tue, 28 Jul 2026 00:10:03 +0300
Message-ID: <20260727211003.22590-1-kobikenzi@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 Jul 2026 12:49:19 +0200
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

Correct a spelling error in the transmit completion handler documentation.

Fixes: dd9446991212 ("net/cnxk: add transmit completion handler")
Cc: stable@dpdk.org
Signed-off-by: Kobi Kenzi <kobikenzi@gmail.com>
---
 .mailmap                 | 1 +
 doc/guides/nics/cnxk.rst | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index fcb3d1bb3f..f44296a218 100644
--- a/.mailmap
+++ b/.mailmap
@@ -887,6 +887,7 @@ Kiran Vedere <kiranv@nvidia.com>
 Kirill Rybalchenko <kirill.rybalchenko@intel.com>
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
 Klaus Degner <kd@allegro-packets.com>
+Kobi Kenzi <kobikenzi@gmail.com>
 Kommula Shiva Shankar <kshankar@marvell.com>
 Konstantin Ananyev <konstantin.ananyev@huawei.com> <konstantin.v.ananyev@yandex.ru>
 Konstantin Ananyev <konstantin.ananyev@huawei.com> <konstantin.ananyev@intel.com>
diff --git a/doc/guides/nics/cnxk.rst b/doc/guides/nics/cnxk.rst
index cb7a86e8fc..56ad9dc7cf 100644
--- a/doc/guides/nics/cnxk.rst
+++ b/doc/guides/nics/cnxk.rst
@@ -409,7 +409,7 @@ Runtime Config Options
    When transmit completion handler is enabled,
    the PMD invokes the callback handler provided by the application
    for every packet which has external buf attached to mbuf
-   and frees main mbuf, external buffer is provided to applicatoin.
+   and frees main mbuf, external buffer is provided to application.
    Once external buffer is handed over to application,
    it is application responsibility either to free or reuse external buffer
    using ``tx_compl_ena`` devargs parameter.
-- 
2.43.0

