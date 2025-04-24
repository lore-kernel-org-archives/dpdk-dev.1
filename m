Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25031C369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 18:29:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24F45400D7;
	Thu, 24 Apr 2025 20:29:47 +0200 (CEST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com
 [209.85.219.176])
 by mails.dpdk.org (Postfix) with ESMTP id E1BDA400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 20:29:45 +0200 (CEST)
Received: by mail-yb1-f176.google.com with SMTP id
 3f1490d57ef6-e461015fbd4so1273229276.2
 for <dev@dpdk.org>; Thu, 24 Apr 2025 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745519385; x=1746124185; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=Z2Z8Mu+5B4kOCyA9zbPp5JRqFCMfalPSjKatZ5aLqK+7FZw0a4zUnj6MSyLeaIsqPK
 nG+cWfESE9J1tz8Q9dE+GE6dSKSz/8kyfOgMPw/x6kFG5JaOBXJSiZOEPvBAKM1CbDt5
 R8E25Q4tFakhLODS+9HgFuVd9Lx+2lflsQKPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745519385; x=1746124185;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=eCtQ8aqM506qH0pKr/hDYSSgsblSvP/YzIo0FiQluTAFuYn9vjASZ0TXYuUl26X1qD
 RsyuiYkeRKPJEGbnj3BNkr15cznhoc3p1JwtxL0FccMF5PkT0P7pVfiUcRbwTCWh6QNH
 ivylJQa1rt/qNsjzKAcAfjh1fE3vOHNBuXLsBep071TqRHGu2hHPpM+1mRrIbP4mxaHD
 UffQPvloTGWc/XI3ap0cgIbLc0Q90X/Z4eMRhYhyy+FsKCrQQ+jYelEm+0dE1j00Zx9K
 nnh9+Pmvkqwf6u3U3wMA3xtJU1sfEyZSOoHuztTGZ9aPAz8UyQukjvu7EQfzHwIXQhUU
 GKDA==
X-Gm-Message-State: AOJu0YyNwraja2jcRx9RFMdeUvOeIA51ua53FIQQB7mBLBnmKgwhElAF
 f0ZNA/WYO0LDZCk4rKW3Fdhlz3awvSIwCSztAsp9rwacWWGNx+dWs9sS3eIzdkDUN1YfnIdW0MZ
 x24uI8678J0ioUBMZSnXp91Rwukof9mAPWqlbXg==
X-Gm-Gg: ASbGncuroHiVVkarhdun6sLLdyYh3Qv5ZOfduMJBcx7hX3txsTSl7dbnCn2dwwbXJ1L
 D9h25hEGiH7m/VPtsQPSYCFi9UF0PMgW1PxuvEUHU1lxZTR7OuqRI4WxC9ciBWzX6EpmuEwMsbb
 5XYelBm7rgxEkRQyBUzmy85+j7OL9y8+fUrm9thSzPxBy/qpal8xdnWYPY
X-Google-Smtp-Source: AGHT+IHh+mqPW+aYpe2aIs1yL5EDtbFMDAy1OU8pzSC2r0ZmNDE2X7NO/gTx5wKOpr7/sNIv7db2rSfpBh7F2RKI5cU=
X-Received: by 2002:a05:6902:1b85:b0:e6e:710:3427 with SMTP id
 3f1490d57ef6-e7312b158d4mr730434276.8.1745519385308; Thu, 24 Apr 2025
 11:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-6-luca.vizzarro@arm.com>
In-Reply-To: <20250314131857.1298247-6-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 24 Apr 2025 14:29:34 -0400
X-Gm-Features: ATxdqUEJJp_TpjD1ZhKedKxjjXv4vocNJRL8PIK6cCgjs0noGQCt4XPhjws67WQ
Message-ID: <CABD7UXP6EGYFDwY+ExjmttytUEmGd3fE7qJw3OUV92FF1bD4jw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] dts: make shells path dynamic
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>
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
