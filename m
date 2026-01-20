Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F326D2629F
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 23:08:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37D85402BD;
	Wed, 21 Jan 2026 00:08:16 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 1F0A640278
 for <dev@dpdk.org>; Wed, 21 Jan 2026 00:08:15 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-432d2c96215so4746282f8f.3
 for <dev@dpdk.org>; Tue, 20 Jan 2026 15:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1768950495; x=1769555295; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vOAE17uy2AuWmV7xBQsZhaYUZvrAJMrrFaqPiKOLXsk=;
 b=QMm6fUBjtVuTE+ecGGD6m3ZmcddS2IecUNWfCNqC98R0u6bZx2FiY95D23yIRC6s+w
 yEIaxvMge01D+DpnovusVrK/i4HowiMrxslATY7++vgT+YFADHVjkBxyqW+hihbGaBgg
 T086LG8DPUqVtrG61n09eVsP6hsaKU7NWUWdG/4mlNKqt9uobhqJRpRFEqmCvSDRm0np
 n/qYOYUTWH40Go/2ZxDhhu67D45doWxL6c/Cj/qJwY1iQm8j0sB8TPondpnaMvsaav25
 nIhuJXp6j6cOfjQYS7i5Pw0qSyovayHZRGyRYVn27DJUlL48tyHT+adLJAUOrEVfrFc2
 329A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768950495; x=1769555295;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vOAE17uy2AuWmV7xBQsZhaYUZvrAJMrrFaqPiKOLXsk=;
 b=eFGRoJNL7YMTTjYTzuY/8N1rp9S/QUfax4z13scjkwSmoeXo3j+UFLQDRjVCYhOKY/
 vx/Y3oym7NdmcwZVZge8mZ0jsh6IR1f/SbG1hJuS+z7W1A3biTUlBwjU4a0k2CynsO14
 OqVGILXVYScHNCnlR8sFfQTzAvrOnpxeCD7IZh86hLb3LzR+j/e/Tfv7YsVasWsdDuBF
 b1Xf5z54jiTROIZYMjCMZNBzHm8IZBbif6YSBiP+l9/SLIs9fvIpUmYqRYh1SJ9i/apv
 la+eeVYL2EmIzT662TKnM8OW24h17bd1i8QFib7UlNTuOq2bmw+hwpmeQ/QQhIL4LZ0H
 kVNQ==
X-Gm-Message-State: AOJu0YyN33prfKdP/y/aq/Jb9WrQq8M3gyONYfdX/+RKT612n+/JaPMo
 NXBrwr37D+syO9RyAFjqkCmhHnKqWSBebyOrXKPE58cT3uZAkKDFiH5aoOZf6s15fGDGpkHwEsR
 lhGo1
X-Gm-Gg: AZuq6aLSUb9xXdyaCNSjmOPltyx8aTJ4GmKVJf9ZuXh30Rech6dZYNtT8hQtkRd07rs
 sFb5c/YxqoMl+oli4wuWgi6kK9yY1OX5xt/gUXVcuYgw2JPvB7rnjva+qQIH/Bk8Ebgud5Yfwq7
 D1H7QFtuSIkRQRcjyjI+ctcsrCTQKHoyH7qetknJCAQDDpn7RNc5KtMbBYyzVbKnyXUnETooau6
 9+2KwROs1edipSq5bEjF1bYdTToOMuo3RGAxrq358Zkzs27Rv7NiXjIcW6MzQm3UHb7mKdZt6Sx
 dGiLF4Zngzict9RwP2lWKvA5uJsMnmCNkG3keRSsuikuZYL3xwCcJ2FMYTJpjxG5AfA7WGd/LMf
 WS2EfnasMtDIES3/d3B/qVST9WU9JwMF5AE9yLJmOvWKW6BoWrGzX0M+oWMivrM34W8ZYFc/iW7
 nsXXvBHVDvqxnbP0nt8LFgksaYmcHRpHAij5z8VhJ4U4EtNg==
X-Received: by 2002:a5d:584d:0:b0:432:84f9:8bea with SMTP id
 ffacd0b85a97d-43569bcf38emr22755989f8f.51.1768950494557; 
 Tue, 20 Jan 2026 15:08:14 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569926ffcsm31267125f8f.18.2026.01.20.15.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 15:08:13 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dts@dpdk.org
Cc: dev@dpdk.org, dmarx@iol.unh.edu, abailey@iol.unh.edu,
 Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v1 0/1] dts: fix invalid f-string syntax
Date: Wed, 21 Jan 2026 00:08:05 +0100
Message-ID: <20260120230806.192421-1-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
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

Extracted from https://www.mail-archive.com/dev@dpdk.org/msg326745.html
to hopefully help move things faster.

Lukas Sismis (1):
  dts: fix invalid f-string syntax in testpmd API

 dts/api/testpmd/__init__.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.43.7

