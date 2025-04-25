Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6A2C369D1
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 03:35:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63ECF400D7;
	Fri, 25 Apr 2025 05:35:37 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id C1B99400D5
 for <dev@dpdk.org>; Fri, 25 Apr 2025 05:35:36 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-af548cb1f83so1756074a12.3
 for <dev@dpdk.org>; Thu, 24 Apr 2025 20:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745552136; x=1746156936; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hupMS5/7E7NWFRI7zg18yifgHmTqBw+m7KS6QYK+FD4=;
 b=RB2vCJkW5yOQsumqKnK2GX4gwqjx5+sAnMQ9I3yxXjY7Td3nsNQOA3qMr35yidQq3u
 QquCPz4TavmPI6q122RNUqcW2cihd6JbVPiTjiqCCDo+9Z4ZpCV9VqUqamFg7nUVzVfA
 29Gj7ffJUEVbwqTGWpXM8zXCgwD3sGkFmu73k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745552136; x=1746156936;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hupMS5/7E7NWFRI7zg18yifgHmTqBw+m7KS6QYK+FD4=;
 b=Hrm6RxZ/xWjrzVmCBigOjVz4NPjY/IqwQjWYLbE4djM8ID/5l1VBwojOLBrb/tX0v4
 OGxsGIpbn3jy/F8D6qglBAEtdFy/jGhQtO7I4ZWBpsQXilBZEA9ySHjGR7DqTdPAVoaS
 oLnZYHFiWjmCbVYaYwZ9uxv8zDt5sFUipmENc2xnyQB/9iRvlh/T3jouJGeRlm2thkMb
 c8HiOV3ytHlZBW1IOhOPbpYx6bLXMP3WOueiMDq6YlDVrqH+qe3YW5GYT9RBFL0ZmttV
 XCMhleoAHbAZMAlzZx4viYkPdZWwtemg/KJo2P4oQkAWIGcdWr+ajNfbK62duvgxnDCO
 mJHg==
X-Gm-Message-State: AOJu0Yz+od5PfH0cFeOz2oc2ys4OjE7sdBYrozH2Rt6k1fUPvg4fEODN
 B3tvgTSy5pVnVBCQ76eob7tPj7py1zO070PG+lquudEqQC+COqfWdYNP2TF4evgRMUbZ80hMA1e
 w2qUXEVpDyqAoBii9LZEZbYAuF/HeCNt4wTXQXg==
X-Gm-Gg: ASbGncs78JeDQsSBfIvbW7daQflBx3USpXT1NJnblQS3mmm5z6ZqZA4SsIEmAV4aOEw
 CTNU1dNDOgRYaMsjoCX7PV/X4NRDY3fM8am3MYtfKaLs+z24qI2bteRZLvKDkVnbKdWx3QmZPvt
 2Jy0TFCX16C6X6cXy680ANwAUtVlCCCJx8oFytEw==
X-Google-Smtp-Source: AGHT+IGaqlf+KslOw5rjdc4U374yzNrtllM6E3il+b9hZd5FGwo+C1bpD3D3QuUg1XZX6afhYJqwT0RDp0ZvAnCPGqo=
X-Received: by 2002:a17:90b:5249:b0:2ee:df70:1ff3 with SMTP id
 98e67ed59e1d1-309f7c73d03mr1653529a91.0.1745552135936; Thu, 24 Apr 2025
 20:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-6-luca.vizzarro@arm.com>
In-Reply-To: <20250314131857.1298247-6-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 24 Apr 2025 23:31:13 -0400
X-Gm-Features: ATxdqUE_BNLuHPujCTGgPw8T4RY6J752ueb2sL-XpbXrJxyVXrSgnbXiITkHS2I
Message-ID: <CAJvnSUB_veoJ5ai0EUpXpQuvzR9e6B7=K-nO5A+iS2+Byp5dLQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] dts: make shells path dynamic
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="000000000000fff0220633920613"
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

--000000000000fff0220633920613
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000fff0220633920613
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr">Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div></div>

--000000000000fff0220633920613--
