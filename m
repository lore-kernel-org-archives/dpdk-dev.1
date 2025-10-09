Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71219CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 15:55:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99F3D402A0;
	Thu,  9 Oct 2025 17:55:54 +0200 (CEST)
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42]) by mails.dpdk.org (Postfix) with ESMTP id 4EC5140267
 for <dev@dpdk.org>; Thu,  9 Oct 2025 17:55:53 +0200 (CEST)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-635fde9cd06so1188632d50.0
 for <dev@dpdk.org>; Thu, 09 Oct 2025 08:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1760025352; x=1760630152; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=OCdlVePtDJQPFDmsOkEmA4HMBl/llJXjsfA7kUmWG9MBgAW0r8ZSbXpmVcfFdgCSqx
 YFSkkkk178PFoR9dywzuGzk2Ux+OqnqS4ilJJbPmdgfZf+zGrcyXMOG9Pb7zGwWWBk0h
 DaIkRp+bIjspURa/f6tdI37dqyqrHDzRTtyYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760025352; x=1760630152;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=FguUoaL29qef8D7OWiYvdlvPWrdai984CF0/8BRKq1vyXfgbz6R5C+atGbe24pWjHx
 1CTfUCjY5/2CGNL4RcWqGbvCMn4/Yb/iQ9QE8go2Rp9HzgMQADSMirq7ndZ5+8d7QOWD
 wlku5KXANGG1bhzrr/72ZVEs6s2QYE7iBBX3knctEXuh174M9EmGCz+xVkerFnnCxJNN
 ZTyndOy0xGexg/VIMXjq6wsOyUOQA/1sLJp/etzsSPw9EoQV3CurZUIyKfVlZusXUMbQ
 BqkS3HTSjgYOE7jil5ycxEEha1fa3mJ2+DNO6L23F8nBjzE3AHOFu3vhTt0jQgfKJo2t
 FpOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNV0uy7UxjLQbRSP/hFdJxR5DJg32cfnYcxQr16eRCqVTOwzj5C3WaQdUkytrKfRImTRo=@dpdk.org
X-Gm-Message-State: AOJu0YyWjaM1o6xLoSQaHxbziWCT+zivXR3z8Trugclg5b17+sRguLnV
 t3YwJgAmTJV9r6FU4QjD4Hn5G9yInRPL/0zH1n0SNnAs/v714zWMVZmmDnC0ZdSu/acevHu5IlE
 EGu4QvEEYgQaZOrRezMznnstfcBw74HnIjY8f4cA1VA==
X-Gm-Gg: ASbGncs8zTwxvQJnJHIfT3lXM/92ifr4woNXZMxBaS6vAcBOjr++kPKbJ4pqw7wJpWK
 +dNMIpc9IWpw3zsVRlv9NPBhHaSmpTHODpj8J0L5fyjC8TPX75PQJlMeFcTN3qhY9Fh2W0qKN0C
 srjx+jtOH+Q6qVhG4IkCs6qbP8eEhK5qv8jYMapTtBVIM3zRylOCDXbL5MecectKKgVElz8ngNh
 HUwTM5tOh4O0XLZ6qzYnWogtuaEb85FWg0vrBsZj5fEFVpaTE+S4iSM
X-Google-Smtp-Source: AGHT+IGzjVcLIGA+mriDVJsattpKOxfZXVcSCzSNCcUUXRL9tCzHfBUm21UhTVHJ/n3Z2QZvPXUmzqpMTPtfD1zesoc=
X-Received: by 2002:a53:bd85:0:b0:604:3849:89a8 with SMTP id
 956f58d0204a3-63ccb8452e5mr5712369d50.16.1760025352603; Thu, 09 Oct 2025
 08:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20250929172734.218467-1-abailey@iol.unh.edu>
 <20250929172734.218467-3-abailey@iol.unh.edu>
In-Reply-To: <20250929172734.218467-3-abailey@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 9 Oct 2025 11:55:41 -0400
X-Gm-Features: AS18NWAwG84oD4hmykokmNDRYnQiMpZqYH6Aox07IAKRVJzW241M3pB07xbIFYw
Message-ID: <CABD7UXPNwrmasJGbMuodf5a+GQfGsVNy_g+qv5ksHpBAuV5mJA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] dts: add TX offload capabilities to NIC
 capabilities
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, ivan.malov@arknetworks.am, 
 probb@iol.unh.edu, Jeremy Spewock <jspewock@iol.unh.edu>
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
