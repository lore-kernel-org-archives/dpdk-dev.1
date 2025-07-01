Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87257C83038
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 14:19:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7629402BC;
	Tue,  1 Jul 2025 16:19:20 +0200 (CEST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by mails.dpdk.org (Postfix) with ESMTP id F23FD402A5
 for <dev@dpdk.org>; Tue,  1 Jul 2025 16:19:18 +0200 (CEST)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-70e3c6b88dbso42702737b3.0
 for <dev@dpdk.org>; Tue, 01 Jul 2025 07:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751379558; x=1751984358; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=eXKGTTIXgy/WjsEHwv94jpV3forxSVzMw9WVPQOUIQT0mzm4E1Grb7sRSw66tGmBA3
 M1Nlc+RHLWIsp5Wn1F94BP3I98q90/Lzucum24S6wzYIHMtpDI73MDyYJ3zMKm2eJysz
 IF9dIqRXRkAuy03+mVqpesXuq2G8h/5fclQXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751379558; x=1751984358;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=h/inW6hlIL4n7YmOKqkT4AEu9fG+R/8zpBAisLXW7T5va4uW5yuEaKLmgHKexRJItm
 eWRmLFYlp8fL7N8FKlQowt1FMZ6ctAqkdYUrALUOrHRDKtuNQeumAIKoUuJefiXxF3q6
 Z6W4DcNtOBo+uCNXV6yBjNi1Qs80NURisr638JtNc0yHkkHBihAtwLTBxB08VSrHWrsT
 +sSlu+Ls/xBehLvh9dJHfpAMbJaPUE14hWUcDc9rxEFpP5sH/YQCKFByjjvcKY/y/ZAD
 KtMPTb3mRDWrb7mcYCQYkiElLrXWwfUsSLvJbKZOJo0ALrPUrPy+kANtIZqhjQdwQgSy
 soJQ==
X-Gm-Message-State: AOJu0Yzda2uNChFDELKxgfBzFQhRtw1lHtJ479ypFrdpdwJSWSG0MPd6
 dmyWjfs2+1s4JeroG3Z5Bw/b/e/B8zpZIabbKDELK2g2t9RZotak+DeRDFi2bz3vEo+Vvsiykhg
 g+ZMS3CKBgW29/lWVpIdX7l1z2oWdNr5Iy8Lw47k/hQ==
X-Gm-Gg: ASbGncuZ/uAOcteZdqsPGNScaMLnW1teprugqjl7GVx2VJ4XaayyX4AlunW5V3XI8b4
 Qy3OehvPdJRGEJF1dIlAH3jTfQ7RgYl0iM57HaDBftbS88QN1b8/gk38a7rwnYrdCIWAv/eZ2J1
 FR4l71Qt+6THGIfrlxCRnJeI5IOjIGIQI83cRyI3f04EdOEZDkWZ1BzOetvK9prSh467ykXuw+K
 lX+/dFUPy4jVMFh
X-Google-Smtp-Source: AGHT+IE2fN5Bo4IDFiySYyGFRhjNLyoWWMpPfAEz/UTgjAJdkYDt5ONaVZ7H0Wf9tuUbcloyZARQFak6rS6zr5qIUzs=
X-Received: by 2002:a05:690c:f8d:b0:70f:84c8:3134 with SMTP id
 00721157ae682-71517150706mr259310607b3.3.1751379558081; Tue, 01 Jul 2025
 07:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250627151241.335114-1-thomas.wilks@arm.com>
 <20250627151241.335114-2-thomas.wilks@arm.com>
In-Reply-To: <20250627151241.335114-2-thomas.wilks@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 1 Jul 2025 10:19:06 -0400
X-Gm-Features: Ac12FXzSACaYgTj6lYHvSjgp4p43EJVH433eAAt95JjCg9sbVVBPfyQdarYoD2M
Message-ID: <CABD7UXMRs6DSStwC3hJ8XacNU8cx=BvVPGY0K_iA9coqOU2H+A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dts: change test suite name property
To: Thomas Wilks <thomas.wilks@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>, Luca Vizzarro <luca.vizzarro@arm.com>
Content-Type: text/plain; charset="UTF-8"
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

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
