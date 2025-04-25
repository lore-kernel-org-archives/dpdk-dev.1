Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586B7C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 03:11:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3370B400D7;
	Fri, 25 Apr 2025 05:11:17 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2ED89400D5
 for <dev@dpdk.org>; Fri, 25 Apr 2025 05:11:16 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-22401f4d35aso21690885ad.2
 for <dev@dpdk.org>; Thu, 24 Apr 2025 20:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745550675; x=1746155475; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KLLdmBKhep9gHA+GntDGhMO05q6U5uWSGLkSvnzpedw=;
 b=I1athTlYE8omoC+n0oms62pRgJubrjn2gdbvFUFeV5LzwQaxb/fuz53Al10mL/1v3V
 mHBrfnG2+67S8IHH83C5rtAt5FZYJrMNOvqDh+VOJ8AMhP3gGdeqNal2HK1txjPpvqyN
 Nl/BdiGenoufGFQR01dXTNfKTHEa/Tn8/DggI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745550675; x=1746155475;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KLLdmBKhep9gHA+GntDGhMO05q6U5uWSGLkSvnzpedw=;
 b=oZgtllvAIwwoLcyHMGXdbCesqB9IwXWGgSAK5Tnz858sdm4g85L6sxASYVLnZUxPwb
 ZbSnNEQE5uPypgmqk3g3uTABJg/8PuCqAi1dwH+7p/Un5dphhJeoZay9+yESgsmaCaMm
 eEg4Aswt98gmP2d76w20b7FTHp/SeenhF8xnqLRBQj3PHGuxD7tgLtxYKmZsumo7Pv+e
 mNWV1vxkRJ9L7br6z9/fKL0ZfJCG/W10Rh2rR1Oe+t5RT71qQgBGslFl5LChFI/dhl0l
 IZF4KXwndiX4ZFlYwtOOgut7dcdud5qIrK4VeLy2w4a2xLYKD/Fas/qUwsMqGXySl2I1
 8tbA==
X-Gm-Message-State: AOJu0YwAudbhKiUpSjhw7ynxoLlnmuQ3sT/6fnjX6loBf3Wx9V+J+TNf
 Zw2hmLjAgZrEj3r47yhnsFOzTLgqGzDniXyE9G7WowNX569GhFbx1zXYWfYXz/UOvoqHRXpakEn
 D99xRdvJ2rLX5CGQs0voOC3dgJN4E6P5HnBnnaQ==
X-Gm-Gg: ASbGncu/RJBOSWgBQemefxJJsISFKhLib13AJDfF7++7gY6YFEmQi6RVYR4qbZH/xFz
 EE3PM28g0Fviu3fSwLXT688+lfPv5MwAP7aw+eA6TT91Zgzev/ZlMa+scsjjwbj16Kff8o4YAu5
 HP5NcgQBNc3fqkXNcLpmb53ed+vwennZO+N8AZ2cTCuOA+3t/4
X-Google-Smtp-Source: AGHT+IErkQOUIiRtfxvbvtRe9/FQHe6YK4Iv8ZWmkN2jAZEKzm+7FZFagLDNCxBol6Otg+HDwDNfxdzt4k6Re0kJV6o=
X-Received: by 2002:a17:902:db0f:b0:223:3396:15e8 with SMTP id
 d9443c01a7336-22dbf5eb293mr12134425ad.22.1745550675195; Thu, 24 Apr 2025
 20:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-4-luca.vizzarro@arm.com>
In-Reply-To: <20250314131857.1298247-4-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 24 Apr 2025 23:06:52 -0400
X-Gm-Features: ATxdqUEJIlDvb7nRKpDrD_GBjyt7s0rLmfrMW4YWpy78MYoFDq1vnsVarvjY3as
Message-ID: <CAJvnSUAy1JWVe+vg2RsV98GffUiGjLgvrfy14kRLURb6_xz7LA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] dts: add shells pool
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="000000000000eecf77063391af52"
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

--000000000000eecf77063391af52
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

>
>

--000000000000eecf77063391af52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Reviewed-by: Patrick Robb &lt;<a href=3D"=
mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div><div class=3D"gmai=
l_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><br>
</blockquote></div></div>

--000000000000eecf77063391af52--
