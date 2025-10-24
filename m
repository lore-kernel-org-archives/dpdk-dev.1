Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C727CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 22:46:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7654040151;
	Sat, 25 Oct 2025 00:46:18 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id D40444014F
 for <dev@dpdk.org>; Sat, 25 Oct 2025 00:46:16 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-782e93932ffso2133394b3a.3
 for <dev@dpdk.org>; Fri, 24 Oct 2025 15:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761345976;
 x=1761950776; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tvp3a1cgzoxCa1wScYmKxuyciFWVBxbCT+1QS+NYHbo=;
 b=bO3dF5BySkZZdkd5LR6XP52PMhN7WuW10/aVI+rC7oX5CThB9C+z2Ap3HzqKQ3k3uu
 POrHveKBC8fQ+IuWg4wjIctoktZR2tN6sBV5CL2e2eF6Q9uegs5PYq9U2dRqm1NJvsfD
 nekExJSZIpv5CgrxJ+I+tKL2ALdbQYO1tDmcgm17snOL6TWo/NqAuKY1Z6zf2lmmwIXa
 v+XXcDQNuP1ySVhO6J1fqoPmj+HB++KcDeMrovrn8Tt8ixHW5inLW7HstlWEVC0bmLZ4
 YPSP6cXy5+DuNfv9TdtPYOSP5ojo2GgHzu27h89fmKT0EEXrkTxsMfR5cunLk1GEZqF3
 pH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761345976; x=1761950776;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tvp3a1cgzoxCa1wScYmKxuyciFWVBxbCT+1QS+NYHbo=;
 b=dAfpYnwifpUT3M+yXqnEIZ5jSyE5KNsx48ujXb3kF8J3YmB82V64cI/TSRHxA1u6bE
 01kBScvINi5z90dYfWZS+wvoNY6Xamd+H7HZlDymd5/Jjd0V1mZLs9FSXBspE6Pzd7bO
 P5ytmJ6RXopBj7eQSaKrN9zO8huqr/QswdgPBtBbQwmJDL7N6uLjEjW1/0hN5MCNqMu2
 Rfxp9mQnyOUwWEOaFE07ke60sj4baGIDaDLdBiAStRClW3ubBHotidNsNYbemUoZe3Kq
 pT7A/PtjQT3RAp0a3fGIqrls7cpafi7bDHpGM2YDkJ6l/jNIa6N25hGXBT7IsRnLFtDd
 x83Q==
X-Gm-Message-State: AOJu0YwfkTYff/cWmhtqpnnYqk2DBKzczK+gZfC5UXPTaVJVwRXZjb8C
 JkNPH3Y/qqv84OIARp2rvmNvpcDzXkgMjNMsRpXIQTVN5CJYOZYpTm5MkMwiPj5O6nUjk+dcAQl
 FmM+W
X-Gm-Gg: ASbGncvByaC8Ie439dA03iXDxDs2++CML41YhVFDNeMHhNZYEg3BzqXbJl3DfrbvJva
 nkzGb8pTsQDhzSufIRqHJ9xf+6C1PzQoIQQmi3yNRyK6cr+gZ/QMqw1IWaS4Z8kpJUagcXpkroR
 gdn+lD2nXsQ3qQNB1fQ82w/9sbqn/A7bwX/sEcAXB+VmdjWP2sTyIzvdg2M2ifWcClZ6Z/N/kVd
 aJrxawr3VrMDpvAkye/rgEkGMS1phQjFXnaj3BzchKor2udjNfMtoIYDSnTkyP5+uoBYyVNcCoa
 ZVDvSyB22z9aQMpjAaVlaMxnMQS4TDym1GefwcBC1TbmFIofFobWT+JphTCGtEzVopNd1cosxoe
 a/L/IglfLS32KqnshPU/aVz6ssIUG4qidnsY+dCjBjIfkfpuJC7Dk3tM7+IkqmbnvrFBtAjUtlm
 dLb3oI9E3CHhNOuKMNc5fm/zQ7dc3dP1iugBss2kY=
X-Google-Smtp-Source: AGHT+IEj62NSUtaVzjRr7C1Conih8xF6zhksAaaELFOMnuDtC4FnTL+Nf12zQzhb0kZj8YW9h5n59g==
X-Received: by 2002:a05:6a20:a10d:b0:334:96ed:7a75 with SMTP id
 adf61e73a8af0-334a857d68fmr41996930637.24.1761345975888; 
 Fri, 24 Oct 2025 15:46:15 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b71268bfaa1sm281310a12.7.2025.10.24.15.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 15:46:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: mtahhan@redhat.com, ciara.loftus@intel.com,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] doc: update feature matrix for af_xdp
Date: Fri, 24 Oct 2025 15:46:12 -0700
Message-ID: <20251024224612.343720-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

The driver does provide stats so fill in the feature matrix.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/af_xdp.ini | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/guides/nics/features/af_xdp.ini b/doc/guides/nics/features/af_xdp.ini
index 8e7e075aaf..d2461dacfa 100644
--- a/doc/guides/nics/features/af_xdp.ini
+++ b/doc/guides/nics/features/af_xdp.ini
@@ -8,6 +8,7 @@ Link status          = Y
 Power mgmt address monitor = Y
 MTU update           = Y
 Promiscuous mode     = Y
+Basic stats          = Y
 Stats per queue      = Y
 Multiprocess aware   = Y
 x86-64               = Y
-- 
2.51.0

