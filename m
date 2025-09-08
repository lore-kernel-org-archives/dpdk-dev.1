Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548D8CA1017
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 02:07:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C3D840264;
	Mon,  8 Sep 2025 04:07:29 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 3847C400EF
 for <dev@dpdk.org>; Mon,  8 Sep 2025 04:07:27 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2445824dc27so37505825ad.3
 for <dev@dpdk.org>; Sun, 07 Sep 2025 19:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1757297246; x=1757902046; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zmF+DpJRXrof+akZb/On8jLWyTxflwbAGcv7VL1o3R4=;
 b=UG/X1PbIxmmPuNx8Y0dEHYLmkGCvgH/KvXLug/yWxOb+n6VrpXSgUCm9S83ozn5lDc
 rbpO21gt/0T+Gwk7GcaQey10mnD2suiDwQDb0cFsC05LRJMzpB7tSfqRgIvZCe994cfX
 62/PcnqCKFZzsbfMilLAgZMj0ynG/hxBsmWUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757297246; x=1757902046;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zmF+DpJRXrof+akZb/On8jLWyTxflwbAGcv7VL1o3R4=;
 b=ZSPSXGt2QEIfCobZtVmYYK8nr7UfqeFhoJbWLCYJnVt2kqkQ77OAlLxLHm2Xbkx1pU
 qUcyqgZ0nNlz8/b/6B0ulTPDAuHjqbwBIRxUGBFdXsSpqUSMMKbTz4ZUCQL+U8CVkfhd
 quU5OzR8tKepxCJ6og484/Qe5qvgJ8Gw3ZOejbsxk3uw4bvpH/GyGcJC0XbFmQ0n/HJe
 OMFIdGx9Ekfz90iX/aEjJHj2KcNUNhQRbnVfLaK0AFZJMT8LDJdxW/jWM7rUAl3dlEaY
 s1DNRBeYd94JR8Ah2gSeEKgViFTGE7GbcOqGiTeK3zGG4vu93VKmFWPpAyMgLLkDXQdw
 A5Iw==
X-Gm-Message-State: AOJu0YwcxyL0JayoQlCFzN5UkD2/IOKF7LzTr5lfKLjPt5tw3lcQ+pQD
 5Njv6LzoiCSoWlkfmvnmZvJoStXaDtPI42QmyKp2qY/nDUSbv3N7ATrtH2zaXYdhggKcS7YE+08
 L+KvGFeHBV7PSY6C9Nb0cm+qpuOaAlPqE9Mnnqbes1A==
X-Gm-Gg: ASbGnctz8pgpV6oYp49v9IBAh3gaf2Tg/iHqOUbRJlxdsc6hbwqclEd30evBWikCXyT
 BzDEKe7KrusnsqShnFOqttjQQx5jA9mgPsehxPApkGGXUJzX3K3RfOVFDX5fKVs5Dz8P+lJpgpK
 zEDMuCcBxa1mbB2NymIdj6fvo38onH2t/qJ/ZuWuD1jEN59fDntLI8pfIL9WNSSu3NY7pw5Olz+
 2N3qOlDuiyMJYcVQeSOjny+q1p8ND3dIHr9sPMuoP5c
X-Google-Smtp-Source: AGHT+IFilcJa8+QwDOJWLu7VC5r7m+EwenTEJngIMi8aVkmHp/S5+gfaAQuhLPGEyj6FntVcXq6vSkZu953qIWtXNfI=
X-Received: by 2002:a17:903:2b04:b0:246:cc24:3934 with SMTP id
 d9443c01a7336-2516dbf1e5amr103092055ad.1.1757297246256; Sun, 07 Sep 2025
 19:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250725151503.87374-1-luca.vizzarro@arm.com>
 <20250904114653.199080-1-luca.vizzarro@arm.com>
 <20250904114653.199080-8-luca.vizzarro@arm.com>
In-Reply-To: <20250904114653.199080-8-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Sun, 7 Sep 2025 22:00:35 -0400
X-Gm-Features: Ac12FXy1BlG8GKVurh5nGuyGD6_KFxXpLbKGdmoxiHyhS-PVXswExCx07jEqXmo
Message-ID: <CAJvnSUB6Q_OJ61fg9ARkESY+Z_F169rRFL_NhkN-sX9Q6pE3qg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] dts: save received packets with artifacts
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="00000000000020d654063e40a6c1"
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

--00000000000020d654063e40a6c1
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--00000000000020d654063e40a6c1
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div>

--00000000000020d654063e40a6c1--
