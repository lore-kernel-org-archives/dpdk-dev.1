Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E4DC83F03
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 15:36:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 520004065D;
	Thu,  3 Jul 2025 17:36:03 +0200 (CEST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by mails.dpdk.org (Postfix) with ESMTP id CB0AE4065B
 for <dev@dpdk.org>; Thu,  3 Jul 2025 17:36:01 +0200 (CEST)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-710bbd7a9e2so59314747b3.0
 for <dev@dpdk.org>; Thu, 03 Jul 2025 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751556961; x=1752161761; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=dDOBjCPJq3WDPZS/Ur/LnxcDK2txvXraqfthSe8vj0yaUablDov5TK/MQKAnQI/Sqs
 ohM19zY9NwZvGXD4w8aPJvcYINmAHpmYUb1SRstL8BPmaBkGUFVgSvlikUzyxq1RF/Rs
 yO66UFnjr+BP3rozEr9x6ZAbxwWJeCcnGJUf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751556961; x=1752161761;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=s5sFq9BGIFsdsbjtenG4cntbRM13Vg6YovMKAPZFk6CvRRgpuhHWLjme/6G8MWRjOp
 usRDjFTgvDE7BIlP2vy+s9D4NVIWgYFYtRSVadWF0lQFyU7YiAX/laZ8RAkuJQSpH0hD
 D5fQu2QXfZivCs/EmeSRWUGzMt6p5+FFTL0DdnigghTqxRdX2lSf0psI9p2dXdyfhPyG
 6A/Pl8w3nCVbP0AblWgivMtZ5VPKKcwkQhL2rPIjXfkp7aD7/UOYXeXP4qZXiSIR/L0u
 W34knh/+8pPRhAFctXxjuDQjsiEbVSbD2GSKUOuDjvFetyrGDwnGM+8hrsO127j8UAma
 4oZQ==
X-Gm-Message-State: AOJu0Yxs4C2D8xVWk3UfPlaao2r8t0C1iNC4btvP+s+M7MoaT0ijW+b2
 REbjsjaxgfOOr6oIXLFyWJ5RpDkexaZhESOEz6dkLXrOYP0BmLEdumQpqoSdOypooeFEWyePBo6
 CMEjbMFiPh0oyXNhMt0ZgKWURxe/KfwDchtBEnPfMogT4ttzWduAn
X-Gm-Gg: ASbGncuz6rUJ6+RSxWVXtuYmPZLksnUOLbYTJ8e3UfPbXTt0JVToNMdqR0ipM9QdYih
 v+9nw00/rZiOx3soedJUcot4YRrs2/pFRFXHoxB/3ZcOwPenjOOMGWaMknfik6hdK+M4MGi9Gs2
 c9kuL+RF0zlM+L63cAKigqYp2ZvoFBQgZMQDD1tomXdV3cutvzniMtmIRkoLTz+JGYhlfGkChra
 H44jw==
X-Google-Smtp-Source: AGHT+IGbbV0hndiWSKjpO8VpK3xTfsOiztLwLUt+7vrBd21gOsYzBV7ouSTQb5ZgyWMpWGSshh4ey+YcX4osbNAE8g8=
X-Received: by 2002:a05:690c:6d05:b0:709:1b68:9f5c with SMTP id
 00721157ae682-7164d2fcd9dmr107404467b3.16.1751556961210; Thu, 03 Jul 2025
 08:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250702164204.607685-1-luca.vizzarro@arm.com>
 <20250702164204.607685-3-luca.vizzarro@arm.com>
In-Reply-To: <20250702164204.607685-3-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 3 Jul 2025 11:35:50 -0400
X-Gm-Features: Ac12FXyKMAn6s4GS3IpT87baQUcXCoW4a9mQNGPhp0V-FTciRth5F6LVUpLL3HE
Message-ID: <CABD7UXN-UP0wJ4JCiz13tcr171NGwR4=1Ypox6pnMKo8+w74TA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dts: add generic blocking app class
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
