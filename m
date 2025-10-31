Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68302CCFA02
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 19:14:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 594CB402D8;
	Fri, 31 Oct 2025 20:14:26 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id AD1F440150
 for <dev@dpdk.org>; Fri, 31 Oct 2025 20:14:24 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2953ad5517dso8229395ad.0
 for <dev@dpdk.org>; Fri, 31 Oct 2025 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761938063; x=1762542863; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Uy1uB4vMmRpyaCKK2neylXFb9gMaUkYnYWNSokugM/c=;
 b=I8bko5krlVfimqUJaKScAhj2dZzBm9jfdsymJgvYXZxl6f0NzqAEivlyFSxy4QXzXJ
 bYgqEsB2AVfR26/PVa8ZtW6rGaeW2crQpY0FJUxgy+dkuQjcBDJLJj1mqLEjRtBZlTfV
 9XHwTE42GTlrsBSFxnzVzrjfWXHtR5GB64cjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761938063; x=1762542863;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uy1uB4vMmRpyaCKK2neylXFb9gMaUkYnYWNSokugM/c=;
 b=HlS0oIzy/C15CvHzRI5xEdqoyGudcuEJtmiXbp32FLqvUMTqtwZd8gSKph6J0KfNUO
 GjfGoAZlnUTj6OmVuJNf8RwRlh8fzXCqXI2PeTAbtNssSiKw08NTaFtJUELyhHNKYkJ6
 Egmb/UfkBZWQsqQ14k7FSsS2TilDa/k+hkLcge5DdRJbmWIj6MWmUNrLKdMX+RCPzObX
 dEZRbIYeEVG5i25ykvnFAke0hvrMsxl3peUIzB5k2MBNSd/TLfxwJXCPdhpFj914EFCf
 s8mtSl4uIGccMDDXm7iTCbRSho+31tiljBnhx/xZ30Fu+tUcT0IgPO0Af1NYjQTt2Yho
 OJWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbiRbXt43L/BPc4qUmW/WWUoaEoPK+zIdzQ+oEw4iokbSTQV+tcHMWdP2C943HPaHX1CI=@dpdk.org
X-Gm-Message-State: AOJu0YzazCj5bAlHhG+sFVtj/br0SjKLrlFRHgDlz22HfV9FnurpZNY6
 p5oHt18wR+EzWfGRytL8dOzD7fvoI1PZ6YtQYF05g7k7H2q74hUiB+IECGCD0l8cHtJWTup9vpR
 AC3lanX8uCwxRSu+sWJWUXUnYU5Y7Rib4UeAvvaVZFA==
X-Gm-Gg: ASbGncsIx0bIr1oKBmmc3G/6n2xnzvgHswt1A38Oo0BryqaJms/FYBua+gmBxDjUnp4
 DmanLG8IdHBfo0C9caXczrCPLHIHHRVOaX/6ZDbEu9ZtvYiXGZ6LVZeJ1AP2c74ZeMU0qFzHMML
 1IPXI2XgS2QvYVXLwahCRgA6jIn+VhlbTVgv2z96dHYBOYCRW3vDB7kmBM2j2uX7Aeo5v0RmGK3
 nx9rNtAoE0vnGXGWfMu+VI+Kd1Lhg/BZhO06dTO+IqrncvQ5waAqjJ8G994RDR5FH1kIRarSPeO
 fYWkapDhxw==
X-Google-Smtp-Source: AGHT+IEZb/D8ASm/Lj6fSpXOAg9MXgbNmJUwCGc9/PKTnsQ/V9FO2eCD/HhNy0QA0S2yB+/ZUVsPyoRlWWPcA3VilZE=
X-Received: by 2002:a17:902:ce83:b0:295:2cb6:f4a2 with SMTP id
 d9443c01a7336-2952cb6f633mr34225685ad.55.1761938063522; Fri, 31 Oct 2025
 12:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20251024184724.1698235-1-svaze@qti.qualcomm.com>
In-Reply-To: <20251024184724.1698235-1-svaze@qti.qualcomm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 31 Oct 2025 15:13:21 -0400
X-Gm-Features: AWmQ_bm7-AdyUzruH0L69oekxdJzYgfv92DIk9U9u0VJljfa9N3kpbLSRdizre4
Message-ID: <CAJvnSUD56+ZqM_wLxTw9Q=fGubJxXyC-VRz+tvs6NrF4cyrLOQ@mail.gmail.com>
Subject: Re: [PATCH] compressdev: fix coverity issue
To: Sameer Vaze <svaze@qti.qualcomm.com>
Cc: Sunila Sahu <ssahu@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>, 
 Ashish Gupta <ashishg@marvell.com>, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000648f0c0642792c27"
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

--000000000000648f0c0642792c27
Content-Type: text/plain; charset="UTF-8"

Recheck-request: github-robot

--000000000000648f0c0642792c27
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Recheck-request:=C2=A0github-robot</div>

--000000000000648f0c0642792c27--
