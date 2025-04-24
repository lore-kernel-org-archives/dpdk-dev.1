Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FD0C369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 18:40:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A3BE402AF;
	Thu, 24 Apr 2025 20:40:19 +0200 (CEST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by mails.dpdk.org (Postfix) with ESMTP id 026E5400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 20:40:17 +0200 (CEST)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-7040ac93c29so15859107b3.3
 for <dev@dpdk.org>; Thu, 24 Apr 2025 11:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745520017; x=1746124817; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7jdmPrbPAJGu7oyfmsnuoKicQmvNG32ySqwmMWIkk+s=;
 b=HhaLKNTFqAJyhPIxvaJ2dKBC8VAYqAte9oc6qy8PwjVI6cUoOfl6a35IPPKiOJSIzm
 hDtsdDTuAt5MbOqenfecdWVqQzmsdH6EHF5lkyytckLIcRqzfHJs4qXCxv6jtGLJztM+
 v/sJRJa+qVSqpoAuKU9WyWau88b05U0UAt7xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745520017; x=1746124817;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7jdmPrbPAJGu7oyfmsnuoKicQmvNG32ySqwmMWIkk+s=;
 b=edBdASdhxL0UaPhvCbxSuDwBmAs4xp9maEhfQ1/EZ+jb4FxZJJuEiG+JemcxAlrJUC
 fh4qC6C35GDnriXf3N/7F1xatG2SfY6167lQ/Ne0MBF3QV5POUzRWqmv/VrZYITIpFfW
 rDbfwuLfNFlsKn9aBnxyA6W+2og9CixmHO1kWbPFmLfI4vDK/odOwb3p7ETh2OcgRqn+
 2zgfeblWk88YitUvmtKSVZmjBHj6dOOLolpnmmCuwGbmg2WWq0Ly5C8KOJedm/wk37V4
 VPQvwpFXhLAZm9mLRXnIPrlkHCCvAAefavC5/px4qS0GQBWOYRAgqpEmCJ8Z/k5y49LJ
 e57g==
X-Gm-Message-State: AOJu0YzNkORCYH8aDaf875qdU7jQ4FNgKJUQApsgjiC/EukxNx6Cz2ML
 yCvDm5Pw5ph6iO4tbWFmPB1OjLB5gbsgDzK+zr3LguDnxggQrZof3aq0CE8ZOwEMgO5Q7XLcKlT
 c3eRfV8PTvsjigtH8fy+gJ4PPt+ZS3dBKrmkyNQ==
X-Gm-Gg: ASbGncsNeDB0wn61pV3q768F9+1RqYLp/YIo9roDUEDr6ECDV38GV4SOzc/HOP86Rgy
 L3eCtyLRbYh0SmsCizY/3669vRtmm7sTWrpq1TKCavMOBcnRnfRmsm7dRwpXCLB44jTEBO9KmDX
 0Q7c5H4iOc4PnDylwlVQxg5Rp/sMkfPEgSPgvInBp3UuS2DE6J7JWZ4XDU
X-Google-Smtp-Source: AGHT+IHnKDHFtuGx8Jc8Ee/++t0RL1m8d+OTFwiuOBIuEbcvnrqIT98/BVJlvUchVJ9Xdwt1ltiKXO6++5xLoutJtuo=
X-Received: by 2002:a05:690c:b14:b0:6fd:4072:2c5b with SMTP id
 00721157ae682-7084f0f1298mr13033687b3.24.1745520017330; Thu, 24 Apr 2025
 11:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-8-luca.vizzarro@arm.com>
In-Reply-To: <20250314131857.1298247-8-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 24 Apr 2025 14:40:06 -0400
X-Gm-Features: ATxdqUHLvtyAnmph9XKHKU2adGcBnMzTphKsR5jBh3Pe6BVyFa8uIVS5PRd6fj8
Message-ID: <CABD7UXOfKnT7ecQ28LfvBYw+rPdfJCwwOiEBQRRo_7aOdb_RdQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] dts: enable shell pooling
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

Hi Luca,

I've read through each patch and it looks good to me, but I did run
into some issues applying the series on my end. It seems like the
rebase messed something up with git, might need to do another version
with a new rebase.

Otherwise,

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
