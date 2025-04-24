Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4976DC369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 18:15:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C35AC400D7;
	Thu, 24 Apr 2025 20:15:55 +0200 (CEST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by mails.dpdk.org (Postfix) with ESMTP id 6411B400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 20:15:54 +0200 (CEST)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-70427fb838cso12737257b3.2
 for <dev@dpdk.org>; Thu, 24 Apr 2025 11:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745518553; x=1746123353; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=AalpWleZZ/oSXGZZB1SPXkSVSKZREvR6BJ7BgB+3bqlvQZ0agCKmrsj7FaVVPPzg04
 m/2sa+MM4oVM4K89ApOYMOCGfzYgEW6PGXkQa0kS/M1vYJZmf2DDtjievuZ6/PxVgKQX
 L0at+ecehzEN/Pexq1TBOiCYFk2iPQgZLUAoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745518553; x=1746123353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=sFS1wJVV59V9hYY8EJbEkqpKmGz5VI3CqE1eSwmLND505XTEUV6m8d9/PUL6B4okfh
 G3NGOYUMLevfNbmxD1qfpXOcLpongForoOrbw/ELbkHE1V6xb/JOaTu5yp0c57rjefOf
 nnmyMPjnFyilCnb+cdVvUnKjxAu2FnkwUtHQ9oMiuL2K/ptsvP3TVgBfEYwRdf+WTN2g
 Hs+NTugLBIPWye1No4qVPElVDykXFlvRpt1R5CHCr8C5SwdaNVm850Pu26pnVCCK8prv
 PRbYb4O0S3nDfIAc8En5Xw1yWTE1pqU2PCGAbjsJvAUZIZE1eUnVPavzX4lTXbiXrTGq
 3+rw==
X-Gm-Message-State: AOJu0YyUXIYYMReRQYPHp9uc+hAJLIjYE6NmdaatNXKkUxYnt+Rzn1R9
 /gyztyt2L9IZQvy3nJbHSUUrZhOhxRkufDCF1Xh1O4w28qVHKiu4y9hu26B7d36UwFln5KjCy/s
 YNk/ATjHyYCXeAZFMqn6QDq7LdQhyKPQZwS71iw==
X-Gm-Gg: ASbGncuXbDJeVXxMplqU+8W5Jw7O6zDDVcohodmK0gEiMzY/Vv682yOa/2a7suxpBGe
 5q3E/yUytuzbEz6+NjrO087G7C234gOzhPuBp2e8MPPwoYin8kisEg0HXTAOw4E/7Zaf4HT2O2r
 Bhrk+gKmCgtXcHefbkaznT0FFYF0WPqjkwSRf8dQ1lQwa5PaMSbcJUt/Ml
X-Google-Smtp-Source: AGHT+IG5RZ4h4/YE/j5Y3jwNqNcDwPXss0DVAuyz2J/ceaLDWr2zuKJ2BEk/Xx9a5u1jZWxH6QjI+o0ico6jcdXXMp0=
X-Received: by 2002:a05:690c:4d49:b0:6f9:b0a6:6a15 with SMTP id
 00721157ae682-7083ed7e290mr52159677b3.38.1745518553666; Thu, 24 Apr 2025
 11:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-4-luca.vizzarro@arm.com>
In-Reply-To: <20250314131857.1298247-4-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 24 Apr 2025 14:15:41 -0400
X-Gm-Features: ATxdqUH3o8wiU7wgZaMQ-rQKwaoQ1QXPLFENsdraJfnxaOqQftQjTYfMQDoQJIY
Message-ID: <CABD7UXN6fQ=rxtamPBODT9ZObSfNckkdQVVJKxYmAQB9nuU8LQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] dts: add shells pool
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
