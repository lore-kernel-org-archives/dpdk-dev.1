Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2978DC021B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 19:44:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFB68402EB;
	Tue,  4 Mar 2025 20:44:51 +0100 (CET)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by mails.dpdk.org (Postfix) with ESMTP id 54611402DF
 for <dev@dpdk.org>; Tue,  4 Mar 2025 20:44:50 +0100 (CET)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-6fd3b31c860so29810477b3.0
 for <dev@dpdk.org>; Tue, 04 Mar 2025 11:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741117489; x=1741722289; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=AQHy9DEjOuFU1Qmp3XOwdncUnGLfyKbElqVAqg8hqR+hpPxwctm6XyC0Po51JuYSBv
 K7lQ8OYadiEZ9VOtvoBT7Ok+Ao7Jac0/zrthk8H9OmpZqmvqql9iPObGTHwg81nsdI4/
 Dp++4VWwu+3L4cuBMRN5R+tGsS0jOjMnYROpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741117489; x=1741722289;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=Ts0KWNbQZ0QejH63IlfB6FdTxwQJOHb65G4pSpC1qHzVcmbG6IfOrwu9RTsw3l36vH
 oq+bUIN4+avIlypLR7e4IHhqudgMSacqIVYNFmK3OZJbqE+KibL/k9j+hR+c2jPj6h6Z
 3cz5xtx8x+plV54uLEzNrAxErS0RpsjXTJ47mMeseMyozt8MEQXLt5sEhRSbnKpIKOpI
 cloyUZ3Lib5M9V/ZcMSbnZINNTOKjSupbK13qZ05gdQTKLIOe/ECQUdlnP4lvvNTposD
 tfQ+CjeOXOMWacwRoEC4z6+KschitZXk6L5niu37WzbxG1h2Nb9e6Ww64D4nfmGKIsat
 Cq6g==
X-Gm-Message-State: AOJu0YzaIHEBvzFEpJqCw0QEbQ6S2t+isM5yFPuai21UJMwDyg0zXEH2
 YV9bLY9hwBTUoRmKeRkuegfTQm0CGN+mQipccqPjvPR7kuvwUV5yGVbK2agO/DSLYh01iIqcP6M
 6OMQq3Y8FOV/gPWzT9j7XEOMr7R98sj7y9vz7MQ==
X-Gm-Gg: ASbGncv9saEX3P2PL0Pff7vUjcbdpheX05isJZw5leU/DyHaf/UaSXV0zVbzQSgtQBR
 pFhHDLqnD+zu5dCWhPHStittzZDgpjmakU2re7KS+Lpt6EcSVkEQOS8Y9ji3cwQBnAR70PgXrOB
 EFC2z9o85VVYpaVk8tcF11IYW93dVfpO5P/G9s7z7UEZm6kU/YYFkYZJ/Dg/h3
X-Google-Smtp-Source: AGHT+IH3SXdNhAIRo5IYJdR22zEAiX6ZW261M+uLapxyDwK/ndyFMyevMsM51IWMYqdYV9n7eJIrAPZzHYI7PJSukcQ=
X-Received: by 2002:a05:690c:6aca:b0:6fb:b37f:2072 with SMTP id
 00721157ae682-6fda2fa1241mr9082457b3.22.1741117489660; Tue, 04 Mar 2025
 11:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20241108134532.130681-1-luca.vizzarro@arm.com>
 <20250303145709.126126-1-Luca.Vizzarro@arm.com>
 <20250303145709.126126-2-Luca.Vizzarro@arm.com>
In-Reply-To: <20250303145709.126126-2-Luca.Vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 4 Mar 2025 14:44:38 -0500
X-Gm-Features: AQ5f1JqLG1HNrUkyFrcfa7eev5XP5Ig76jjTyddGkAJBqSZAwpiSqJzDtLnWm8I
Message-ID: <CABD7UXP=_SR+CsJ-PNzEG4F8xPOzs7+WRWsLiv7Fmme1wSEGBA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] dts: add tests package to API docs
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
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
