Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199D5C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 02:24:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6791400D7;
	Fri, 25 Apr 2025 04:24:43 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id 72B28400D5
 for <dev@dpdk.org>; Fri, 25 Apr 2025 04:24:42 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-af579e46b5dso1196646a12.3
 for <dev@dpdk.org>; Thu, 24 Apr 2025 19:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745547881; x=1746152681; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K0C3n/0Cw1xltBcl5pjp9JbHxYD+eBr+Xyk4K+3RjsQ=;
 b=Y/nBN/+qN9nt0Tnf4i9zi7/2+nbfaHlsDOyIM5JwxKlsJUHlTI2z2mCnn4eSA6yC0J
 D2G1JFIYOTur/MhzGdlDj1yZ+WiZOiaNsC4nwubKRrSyVlax75hAAm5KuYmRwTNm70Cb
 w9Lp5fY46BkrrL++B+nMW9rnEraWnQgnRr+eQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745547881; x=1746152681;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K0C3n/0Cw1xltBcl5pjp9JbHxYD+eBr+Xyk4K+3RjsQ=;
 b=muEuVQfWKcVZbiceL9mYIUowPvlgpd6xWJXT85bvmQ+yj7J/xUyQ2prRVIRlpeMTM9
 Bm1ea3PGaB+yYsbIcyzGhy9d9brSwx6j81ue7FuvcoBfaGZ7Bkasahh9HMwNCq1hJ7iK
 IO/d5KBV8Wp1wdbGangOLkML04F2ZWyZ98+JQKL7GwEoqG42pZb3EZEGq1vQo52sBZI3
 LlfVa0o9612XrHdCHDyBxsrL4gGaL86UM88HNOmekKfC/rbgOMjDbhJcFy7YXy7r7E06
 pBdoSsAY5Nrd5UBlCDmRCFGxCRhrroXPkMBQIDPyh6RmordAfUPysDEyE0iLm54Iz1rt
 Pf5g==
X-Gm-Message-State: AOJu0YzEha9jyRD7o+jB9GHqsErran39gN37rmTjFA1SgyW34AxyIxSI
 ltjf1kEJAZCGCbjRJpzDJlBLSYva4rCDZGnrYgAFVdLcIa0q/0ded4xU29wJ0natVHAaHOJVIs2
 80kJywzMDzeAOf0v+3YZ+pK6bLOk2t3OiFoyn2A==
X-Gm-Gg: ASbGncsVop79ovqYJhbmvUQ6kGG2oeWbk9PdXUQcQiSwDcoW03pspq02WD+dj6dvcur
 JGJiZ5y1mbVBeBs9AilmGhggFHYlOSVGQ5IT3yfF9wbtZBOedxEit+ZIkJv5OVxzyJhRoB6ZNeY
 E5L+mjsCjFH3/MPHZ8PVNeIz2OxVTQo8T+hZoavQ==
X-Google-Smtp-Source: AGHT+IGKh95wvpL126d0Tl98Y/oJz9Irrs+cWoMrpI99Cwy01S4JHSIg/MexnccmZVuzBQhTusG9IDIKmQz6g4GxwOo=
X-Received: by 2002:a17:90b:5111:b0:2ee:741c:e9f4 with SMTP id
 98e67ed59e1d1-309f7dd8748mr1212638a91.11.1745547880998; Thu, 24 Apr 2025
 19:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-2-luca.vizzarro@arm.com>
In-Reply-To: <20250314131857.1298247-2-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 24 Apr 2025 22:20:18 -0400
X-Gm-Features: ATxdqUEM6KJpd5pYogJ8tC6FIfN6MXZMOJHQ1DTkKgJfz1dT8R0CXK3Eo1222ik
Message-ID: <CAJvnSUDnGs7UFoSXuDMO6-M6iL849MeNPncPPFND_z4=8XFLFA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] dts: escape single quotes
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="00000000000062c17206339109c1"
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

--00000000000062c17206339109c1
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--00000000000062c17206339109c1
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div>

--00000000000062c17206339109c1--
