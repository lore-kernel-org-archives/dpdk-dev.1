Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4869C19F32
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 03:04:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B444402F0;
	Thu,  6 Mar 2025 04:04:29 +0100 (CET)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id F1EE6402A0
 for <dev@dpdk.org>; Thu,  6 Mar 2025 04:04:27 +0100 (CET)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2fea8d8c322so459308a91.2
 for <dev@dpdk.org>; Wed, 05 Mar 2025 19:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741230267; x=1741835067; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fW+0csRfcUxBDGiuHXhB8EQ+B6W1C2Mo1RGl78eYIp8=;
 b=QYljIdamp5mRCI8uCDU2k39Iqedf//VrFhmwMdT96UVjjFwaZDOI8puUXwW3mVOcXF
 AbcRi0QlsiTo7mDWbvYlAjPDJP8i8yHrUtwAhQgkEmzbz/4sxYiYXfeY8cI71nVbCDsc
 9TCqzGAxnKcWVau6ltODDanJq5xVblw4F3DGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741230267; x=1741835067;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fW+0csRfcUxBDGiuHXhB8EQ+B6W1C2Mo1RGl78eYIp8=;
 b=EYtSnFchRkhwzj/iLGfrZOBVcU1ThbJ8yABTmOhT53++aEeeaLkt9eNSvazzev1LYI
 OjHwosgijA86c17HX4uXOKIlfjOnMZOvpu5aWQP38SDCCgO4YMXQdwmwOuwuwDOw50nl
 2xzXIry0HO3Yex3gCYjD/tNDhvWKo/585VDd9PI3i0K/NGt9HydAr59Po8kDAbhhPmvZ
 157iutdEfX6C8verGdUaHrEoGk8TqN871xvmX1eu0Cqr4ZZ5nV1/WZX8KW7Ndcxovpel
 eYiLa+Dj5zVEhmKVBgk7mXa4Q0oLS4kJaRpxKZeEr3dILrSMnfFAKR33JIMNuWKWMVqG
 Z1Yg==
X-Gm-Message-State: AOJu0Yy8+2BRaTr/L0BpRra3GmiqJrodLsQaMYDRusOn1+bxSatjERbT
 TLcn3ev1l7ff7PFf9JxMVIFmk8m6GOaU2gCn3dC/SZQTJR3GKBaLwfTBgRRugLgzgE6YJzcTktr
 lldbdSn8otxxnDwoj2BsbFciTPE/yD8G9ty0u2WU4mhbdkKwJ6wP2Nw==
X-Gm-Gg: ASbGncsGbeOrMdNxNYbBF+xDwAU0H8MOEoUmTkOPqT7IHb1Ba2LNt8FNbX4gPndT7KP
 Vqtrin4dbY8izdNFkxF+jUe9A3XhBPx9qHISzt9NiHIZ2qSzYNmh390QSpLvgWQUHb3dBnSPRCu
 8WpQIx4uX+pxGEs013OUna/S/AMFwPY+UYAKZe8Jp9/A==
X-Google-Smtp-Source: AGHT+IEzNozzgdV93h143m0J121QcNeCyXNYZT31eGA/hb1VR8/Boeyq0foPtf2HFrrhOeUjPZFaMwrCPxTMnRStI5g=
X-Received: by 2002:a17:90b:134f:b0:2f6:f32e:90ac with SMTP id
 98e67ed59e1d1-2ff497a9d0bmr9586454a91.11.1741230267181; Wed, 05 Mar 2025
 19:04:27 -0800 (PST)
MIME-Version: 1.0
References: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
 <1741190802-19486-1-git-send-email-andremue@linux.microsoft.com>
 <1741190802-19486-3-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1741190802-19486-3-git-send-email-andremue@linux.microsoft.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 5 Mar 2025 22:00:50 -0500
X-Gm-Features: AQ5f1Jqxrq0VnbC4ZfLSSY_h9H63Z_5-MJrdIMHYpI_tX6kF12cFVfgbyePsOiU
Message-ID: <CAJvnSUCPZGNWCA6JAYBL78U7sMPo8FnFYbZ1toaSktsncU0jdg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drivers/net: remove use of non-standard array
 range initialization
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000008c4ba8062fa3c3ee"
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

--0000000000008c4ba8062fa3c3ee
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Performance

There was an infra failure with the Arm Grace server about 12 hours ago
which caused this failure - sending a retest request.

--0000000000008c4ba8062fa3c3ee
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>Recheck-request: iol-intel-Performance<br><br></div>There was an infra failure with the Arm Grace server about 12 hours ago which caused this failure - sending a retest request.</div>

--0000000000008c4ba8062fa3c3ee--
