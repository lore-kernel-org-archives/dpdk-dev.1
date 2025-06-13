Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0D4C71136
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 19:00:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 068EF402C1;
	Fri, 13 Jun 2025 21:00:39 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id B5139402B6
 for <dev@dpdk.org>; Fri, 13 Jun 2025 21:00:37 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-311a6236effso2187808a91.2
 for <dev@dpdk.org>; Fri, 13 Jun 2025 12:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1749841237; x=1750446037; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ktiHUJqkqLHsO+FbqiIaDeo9ppwdH9e4tCmRMkDURPY=;
 b=Dcos22qs0UI+ch6cCWhuw/ZCm9i01BS837/ZtEM7p0Jtc7u91aXKn8aYtLx2shodgf
 aYE7/SoKOKdxOXMkSIN+jWZfV6oUazbZKX//uvJPmx7eClBZ5WL5a2qZEc9plL14sb81
 K8vlG4aMQCEh/gy4BSfzgdPVo5PReoryP2mh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749841237; x=1750446037;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ktiHUJqkqLHsO+FbqiIaDeo9ppwdH9e4tCmRMkDURPY=;
 b=OoX0QQYS4YT2F3fpVgB/ElHLzhqWebqqG2VWKng6p01wmHM3LX4YPFpuoXDnTJcODQ
 UpdNzC3zrKUN2qv9kbePcFM/DgQ0n/eLheOFOldXEtMcMJtQJHlbva+U+fC+Q+cU6NAs
 bxZwtjnSCAx7VunDV25a8MV7HsJU8LsjT3ocfElU/CaspC9l6XqrVyk+7yxHW1zlGb2M
 1MacBGDxhPbt3D37l3cwLhr5JjSdCnMZhc95N14DRULquCqNETfaD3RUqePWLTcbZ+4S
 rPIiUyieyS8uESXSBmimvm5UCrmR7zV0WIvEgkz5IOA2V6bnzS6ykIKk4f8zQwW3U27A
 /3vA==
X-Gm-Message-State: AOJu0YxJP0zXdmXK3uA8ECfxpA4gjErtgMXyCczom2fA+JW6eFXxXz9u
 cCIkea2pQfNxd19ljBpU3FYjUOCWTVCFp+6wtKsxoJzjQ3c0v6X8EPL+4f8Ly1vQNCt96VYcsNJ
 F1t5S77tI/EfvTeGvVKyKsTrznm0AAzSx5CiLKeOKhQ==
X-Gm-Gg: ASbGnctYipR8zDb2BVdLX/nZG7UlhzUz1J9gEfY663X5rS41spC2BhOWwZV/3XwAHqM
 UyebSUvH2tpqYRUiSlTBhTzXJynIUFt/aDT4cV73CCR8kPICOkT3i4JTtEPIyWT7zfdJUMKG7VM
 R4x1kVK3ptZqhwTcqIjxWq8LP9vQj2Dor8KA9RQckCHPgti73PYj5ct7oxJnBWG633Ntl60TGSn
 j1x
X-Google-Smtp-Source: AGHT+IEAwiCW0+jhiPwJWAtWT/trQLp9vnIn1WuxvP3vfbgoZOepcfYukMS5fN75m76fpvWsBBupLBmeu3fsiF2xe54=
X-Received: by 2002:a17:90b:1d50:b0:312:da0d:3d85 with SMTP id
 98e67ed59e1d1-313f1ca1042mr1065845a91.6.1749841236725; Fri, 13 Jun 2025
 12:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
 <1749737842-30538-1-git-send-email-andremue@linux.microsoft.com>
 <1749737842-30538-4-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1749737842-30538-4-git-send-email-andremue@linux.microsoft.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 13 Jun 2025 14:55:24 -0400
X-Gm-Features: AX0GCFuTj-J-lDKU0k7nNAelR5eV_fhkZd0HlNIMSK1QfhTXR-PRfqwMUoLiUIY
Message-ID: <CAJvnSUB29gmV3PuHgvos5HwuuyJDWBt-LgNQyQFs1NWJeHo7sA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drivers: enable drivers to be compiled with MSVC
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, Manit Mahajan <mmahajan@iol.unh.edu>
Content-Type: multipart/alternative; boundary="00000000000054261b063778a92b"
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

--00000000000054261b063778a92b
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-compile-amd64-testing

Just sending this recheck request to ensure that our reporting script is
fixed and that it reports a FAIL instead of a WARN. Once that's done, we'll
upgrade the meson version on the system and do another retest.

--00000000000054261b063778a92b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Recheck-request:=C2=A0iol-compile-amd64-testing<div><br></=
div><div>Just sending this recheck request to ensure that our reporting scr=
ipt is fixed and that it reports a FAIL instead of a WARN. Once that&#39;s =
done, we&#39;ll upgrade the meson version on the system and do another rete=
st.</div></div>

--00000000000054261b063778a92b--
