Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD37DC369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 18:23:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89A76400D7;
	Thu, 24 Apr 2025 20:23:03 +0200 (CEST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com
 [209.85.219.175])
 by mails.dpdk.org (Postfix) with ESMTP id 07E6C400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 20:23:02 +0200 (CEST)
Received: by mail-yb1-f175.google.com with SMTP id
 3f1490d57ef6-e6cea43bb31so1204578276.0
 for <dev@dpdk.org>; Thu, 24 Apr 2025 11:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745518981; x=1746123781; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=IeveqIsZ2gXdiLUFNp9iTW5n+0kZpieiEWksQsaCCF399jjRgFkbv2b0g7nxtyEI/5
 BJkbtv5yepAxyzr4WeGi1oh1Tph3Nw+z5M2HNiVAUdUY24ERAnzG0cCumZzTZ5VueGdV
 il5twNKD5hE4gBn22eVQwWsKRUHlSerJRR4xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745518981; x=1746123781;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=L3c2Vc31I/+au6/3Toj6bb7x7+ihB7QAAmNBF/w3tmWCEfDTntQrjcP24wDz28dkwj
 26LcQJr0HktjtJYnLjEXVzpkLIIW7hYDm1fmFfEg3YejCVbNsZRVMTdu+F3xVfcup3op
 WkAgta07Bvr2pTntaMr9zT4Y6I/jfeDXeOXhepyrgYQwtJYuRQygHWRHVQdtaa/llqku
 HOMIjGmNDLD/lExbeq9bVlyfFZ1EkAFLnYHolaEb+mgwp0VuyRhIEOWx13Wmjuk1Ea6U
 Cal/f43HNOgz03aVmDlu+aWQpDxAvhZnNRQyn5ZcMcAgWXgM38LGVSrpidyG9cIRIIKA
 PscA==
X-Gm-Message-State: AOJu0YyGob4m80rjXzz9vCXbqeKefVaCTCi878pkTAVBA/EnEhaZUajx
 OGNinK+twNzO9xVJtP5T3KS38dNexH+TNHJdrC5XIK9T7aUYvkNin9bbqymHM1bucfik1K3OqQ4
 RxGm9H9qZalYa2KwTWGjzk8FCG5fMi6n78VXsNw==
X-Gm-Gg: ASbGncuLl8+2+zcS87w8d8+l6M79nfLtosP6RoWTIyyWTyPNrkxXJYcAEStM5VqbN5g
 9wdYShCsLaRsi14PCcEAeAx9VfQZdDk8uXLMzmjczSeKVqtIAPALdZATAQOtWtzmpUqnRUX3iuy
 PUNom5uyN8Gr4Vut3E3ZZgca0WKThXtFm/VgACP1X/phPe3RZLfv0MX3eq
X-Google-Smtp-Source: AGHT+IElWTzgXxHzFqBAFj0Sp+kT6WQDtJiojjZw7WCLQQvaOeoBZt+/0B0/U1LdGOgKjORD6rYeCMZ8AjKskIXlVjU=
X-Received: by 2002:a05:6902:1b0f:b0:e73:11a5:bcb8 with SMTP id
 3f1490d57ef6-e7311a5cb8cmr1297061276.18.1745518981370; Thu, 24 Apr 2025
 11:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-5-luca.vizzarro@arm.com>
In-Reply-To: <20250314131857.1298247-5-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 24 Apr 2025 14:22:50 -0400
X-Gm-Features: ATxdqUG0HAGeLmAU6uWUM-xYXfSR21s6pImZCedksMc_GF1nO6o_ZANTArQzBV0
Message-ID: <CABD7UXM_BnBw3MCk4QQV8SamAVOv0W3yh6812aht45EymR70zw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] dts: revert back to a single InteractiveShell
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
