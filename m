Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC9DC021A0
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 15:36:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3310742DCA;
	Wed, 12 Feb 2025 16:34:40 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2FF9C42D72
 for <dev@dpdk.org>; Wed, 12 Feb 2025 16:34:38 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-21f6a47d617so79447915ad.2
 for <dev@dpdk.org>; Wed, 12 Feb 2025 07:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739374477;
 x=1739979277; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EruzyRjiXGbDI8DRTxomWekY8R48+uDxLAU2Q7fA91s=;
 b=BvZgc0z9QEIu0Ixw+8floCwmCM7VM5vCTBqFSyis5Acgg54CO7yADFWXoKjdjFZH2l
 v6N7uQy4qTrZi4bayUNfnbMEWlRGVJz8scrNOPbBYeewGVHE6yyhr0bdgXT4mzj8O1Ml
 fip8AJwo3i7+UrSt4AgQNBDL0guhaQCIFYEnRH+zAi5n17KITgDLkpoRPsYJGvkteP7E
 Y2pZ3crWt9mn0T7hYbVdQ/AfCyprEkOpg0X5wV9hUs9Z4+GLkVTUBZl9Q2XkVRxU/unQ
 kMi57ht+HmsBCB9tykBBMGjt8RvuBoC9+wIhCB4hnYPzggFOMkuMRscx6gOPwiDFGIny
 WKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739374477; x=1739979277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EruzyRjiXGbDI8DRTxomWekY8R48+uDxLAU2Q7fA91s=;
 b=mgWQP3NCs+L7JrnDQZEUDp2+sP3WsBzsYtLX4qA9cxXSI+xtvt+j+awFh3dUjmep4p
 6aFmsaYT3BVOFKzoMc7f0Y13GnVZefr1fAAjTMhGIbguxHC+fY+1RZLkZJ9X5p4N62ue
 LudoeLwvz2rIjO4C3o+OxnzCMbnA5BbFnYNC5oNk8f6Yqc4irVCfqJdvCuUlarEhJYIB
 6Fdw/3V5TTXcoZqjPxfALWTRG53XgR8H8jX4r3DvJknrcu2Tv1XVUN+Z/nf8z8r0do2C
 2+0KpXZBjX+tzm1SK/1nIfva3ncBgqdqgmFZTCNds/TC90DQ/BxPmtSpqM5kRbfDxDDG
 X/dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuIDr6RbBJecea9iWrzjSayMP1mED7/+MQ4binYmSxP9O0oBXO3YCiCJJpM+zmFl0oajw=@dpdk.org
X-Gm-Message-State: AOJu0YzY4YrQisNxVZ5fEjx1V1m+AycgaIVfRwowORRHNNP5MOX4/jQb
 aqX+sQvf+0OcClYAueIImoLVk8ujLW9ZGpOlFLGpPXklQpg3XP5DAfcyhNaVsdqlgosK3h8g9kI
 X
X-Gm-Gg: ASbGncurD1QJlY4jlmPA7F1xPMUxIDx8UDonGttSbRpjYatoVdTQzpeSOS0uyEyCye7
 GTJtmRIK2dgQUo60f/MV2/MQTVFz3wjr5XxsmRZ39jPLylZfvaowCiRvw4qcjM3iPJbxvFHmg7s
 5910ynY5Vj0BUYtUM9p4wK5UIVGJP/W6EjG/NnlPXDA0hqaEW95EvWf2/2JNkAHNpzwxfKB/gPp
 VdqtV/MnMmZYOFFU60ovUYpMZf4wkQ+pW3TJ8C9ZaxJShOyKZR2TyqWlGp1B3gL1unG2sVjN8VD
 T9ksp9LmSV9hReLjXdg9Lq4sJ/Yl55MGzMVRcxWbmGqkg+Arh9pK7i/NeJ2ZzHwmGfDp
X-Google-Smtp-Source: AGHT+IEIo1R+5xxDNhCxLiwvmihwm7ThzwTQEuY2aP6EqSsstw1NqsOokue5ga95XKAKzfSgyzABfw==
X-Received: by 2002:a05:6a21:700b:b0:1ee:1af5:86a9 with SMTP id
 adf61e73a8af0-1ee5c790e07mr6777598637.22.1739374475773; 
 Wed, 12 Feb 2025 07:34:35 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad54a8a56b2sm6366785a12.76.2025.02.12.07.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 07:34:35 -0800 (PST)
Date: Wed, 12 Feb 2025 07:34:32 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "11" <caowenbo@mucse.com>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>, <ferruh.yigit@amd.com>,
 <andrew.rybchenko@oktetlabs.ru>, <yaojun@mucse.com>
Subject: Re: [PATCH v9 04/28] net/rnp: support mailbox basic operate
Message-ID: <20250212073432.3c2782ea@hermes.local>
In-Reply-To: <87250201494D281A+001701db7cf9$6b2242f0$4166c8d0$@mucse.com>
References: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>
 <1739263818-59770-5-git-send-email-caowenbo@mucse.com>
 <20250211072406.59f15101@hermes.local>
 <87250201494D281A+001701db7cf9$6b2242f0$4166c8d0$@mucse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 12 Feb 2025 10:54:20 +0800
"11" <caowenbo@mucse.com> wrote:

> Hi Stephen,
> 
> This flag add will ignore some warning error ?
> > +error_cflags = ['-Wno-unused-value',
> > +        '-Wno-unused-but-set-variable',
> > +        '-Wno-unused-parameter',
> > +        ]  
> 
> Regards Wenbo


Yes, but can't they be fixed instead.
