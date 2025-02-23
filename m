Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EDEC021B2
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Feb 2025 21:41:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C1B4402D7;
	Sun, 23 Feb 2025 22:41:29 +0100 (CET)
Received: from mail-ej1-f99.google.com (mail-ej1-f99.google.com
 [209.85.218.99]) by mails.dpdk.org (Postfix) with ESMTP id F1B3D402CF
 for <dev@dpdk.org>; Sun, 23 Feb 2025 22:41:27 +0100 (CET)
Received: by mail-ej1-f99.google.com with SMTP id
 a640c23a62f3a-aaec61d0f65so747162366b.1
 for <dev@dpdk.org>; Sun, 23 Feb 2025 13:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1740346887; x=1740951687; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T7n2VvlAsjXgdO9byqy2zNkVNwwTabBEip2/ySWiIRw=;
 b=OfJS8AYxPLkgNpdqiV9BLSdg5nshaY6kf90+6uengr0U4rUJMrsclflqk1ePyt33HY
 MJ3OJiRIMmENCcuAKQA/FZ/26/AOq4cYWH6DYUOLgIzXOWew8EPXbB+0N4N2GJeiZASE
 AGXbYp94e8yqKOejvIdERE8ZGB4avf4hHMBWSFotznsrabBwQom5iCGuRgN/GOe1Gv79
 LZTVspBdcj6GCj+Pii8lTjv5tR2M9EZJdabjYZmUq7nF79XbO7uDPfboV9eacafFyfyt
 9LW3JFEGi74+6wj2E5Yhnl7PtK4vG2QaRcCgIZbqpdjS9C2B/hwNDM9TdzC9ft1uePXb
 1DvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740346887; x=1740951687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T7n2VvlAsjXgdO9byqy2zNkVNwwTabBEip2/ySWiIRw=;
 b=xARkth1Tp4D3SS9RZjjF+dNYLLILE5S8uYCEvkkSvgr6cmfXUHqRvPyO9fhwyD9V66
 ciBW/XoxFLg1S/Vuj7ki/vOKgUhAzJoN0sWDS+AFkOWcht46k7VoJ4qful12YuMx2lHe
 HNBK7rmIkrVTcLpAy1elSbKIyu+AHTtUWmcI5N/5PznTfy/ywFI3pTx3SERNIWTxYkKw
 tir0n0Or3PZoraM30XyyRwVrvA24w20S9gkz6OYBQ6ATn8o7XpKebra7fCdcUwcLuUk5
 KR/s2fBYfqjvQ7aF6qwmfU1KNwcOIwUYg0SOP9ma03gQu2u8UiJgZX5D22pliRGf5LrU
 vj3A==
X-Gm-Message-State: AOJu0YwZfbY+xEHauxpqaM/ngxyGyszHpLvc0aZQKX3XwtebVTSnbQ6b
 PSirTtEi22DIQp1UiYJkW2EMP/vGABJgsAVWUDjzudw/Uoz/4Yq19fHgXNrLr2I95TrJjyB+XDE
 XLY0S4RbomOhKn6Px58suxWZYT31MbHqOHr5ih5/Z
X-Gm-Gg: ASbGnctW+sEaRnI783qvfH28S3PYAQ7lT/Kk06ftv1A1GO1lK8UclBMUIHuBgL2JIEo
 dtdhyMWcMeKtpkkgk92WqaCU26gp6LW1wOg3onkeFHpC/UNHb0+0niWuG7F1Rgr1ViaNExQ0XrG
 AfOhJgszqpe8QdxO/egebvM0UP1QwPa7MNj88Zgiboeb6TlKqaIFQdlQ0/ppCuPBWJEnJR24gvw
 fqHsVGBP/570Isz8591Q+3ijHrujpfBZ85Pikfrsg/TbeCzS+lmT0UUSx0CNVWCMV0N5jnG7g4P
 Jn0KdNomksZ3id8f/9YJfRJYDukNz6RrmRXyhYmpfD3sT7NEQp2v2vK8njY/
X-Google-Smtp-Source: AGHT+IHP/NT3YVfextEgJR7+aV7i7r5bTDv/Ok7o5Cr9GQlSmjs5EEtUgxRcasL5qFKfvUQksTE0qJYPOvPZ
X-Received: by 2002:a17:907:7f90:b0:abb:e958:2eb0 with SMTP id
 a640c23a62f3a-abc09c10e1amr1083689266b.39.1740346887388; 
 Sun, 23 Feb 2025 13:41:27 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 a640c23a62f3a-abb9719c826sm111222866b.231.2025.02.23.13.41.27; 
 Sun, 23 Feb 2025 13:41:27 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 2E3BF14EF5;
 Sun, 23 Feb 2025 22:41:27 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v2 0/1] warn if NULL is passed to rte_pcapng_close
Date: Sun, 23 Feb 2025 22:41:22 +0100
Message-Id: <20250223214123.447579-1-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250216160833.3216001-1-ariel.otilibili@6wind.com>
References: <20250216160833.3216001-1-ariel.otilibili@6wind.com>
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

Hello,

This patch addresses a warning found by static analysis; courtesy of Stephen Hemminger.

Thank you,
---
v2
* rather change documentation than work around the bug (Stephen Hemminger)
* changed cover letter and commit message

v1 (https://inbox.dpdk.org/dev/20250216160833.3216001-1-ariel.otilibili@6wind.com/)

Ariel Otilibili (1):
  pcapng: warn if NULL is passed to rte_pcapng_close

 .mailmap                | 2 +-
 lib/pcapng/rte_pcapng.c | 3 +++
 lib/pcapng/rte_pcapng.h | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.30.2

