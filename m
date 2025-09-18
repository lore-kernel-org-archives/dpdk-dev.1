Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D53CAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 16:45:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E18240676;
	Thu, 18 Sep 2025 18:45:10 +0200 (CEST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45]) by mails.dpdk.org (Postfix) with ESMTP id 028DE402D1
 for <dev@dpdk.org>; Thu, 18 Sep 2025 18:45:08 +0200 (CEST)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-62fa8d732daso1520327a12.3
 for <dev@dpdk.org>; Thu, 18 Sep 2025 09:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758213907;
 x=1758818707; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+3eG+t2iuVBcMEHJIgQP7hahauD3ys/79lHgODg0glQ=;
 b=W6Cb98NqAg73YhCzxQHGJc1qX064uXkXXVK+KHP1FWfVtVh8FjlrRgwYVNyXUTp+Ns
 fJ1KMCN/nkrx03H4PFzHqkp7NDWF2N98vxfw+sKtA5+GHIbAgr0ApgWOKji++9403YTn
 4JVzDmTFo2V3YWQWBSePjzHP520dja90WMIrfk88NPJVS3/BDYMcD9QSjbYH7RzSxz/y
 ScfeU2LS2tHa+PwVjJfvinuyCQ9wJSejvZzuS/LDAgRtQ76HnMagQ57nY6lazz4Am6Fd
 wqTNXiNr4RYj+5NO4kFb+NJgtutH+d6v2DN4YrxeXRfTFhJsSnooy/4XKC9arf90UmMn
 PKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758213907; x=1758818707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+3eG+t2iuVBcMEHJIgQP7hahauD3ys/79lHgODg0glQ=;
 b=VC5zuWaze04orQ2diAPM47IejGqFYpRjbg9g0W5h4U2Mx0Xfj5z44xIiWpCl7WWF8K
 o5S9rHIpuP3hn8n5m4afFWeQHgpbtcRrMRLtkTqXz/I26To0SXefp9eqTbdwvws7Z6Sb
 cPYAJ9nzNGZQiCvSzUBi1Mrnp5OKlL3av4Rw7b6PfM2FmFBj74F1r2URxqWIldfv2eX+
 f5uuk9OyC6uOzvYiVVVzRUtNy1OFYLcq9XkqUutmJY7GsXoboRcGU5fbifJlcVRsNG4X
 ZmIFQQx3BM/c/OXv+0qEbe6fgHmVvF4XSUZRNYjhbwxTT3lbFMmS8elie9H2/vSvfAF5
 Tp1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGABVUtOUULo0gKK1Ha4PopPSFLWcNRPBbyM5WpDkYJytWULqTwwCe9JonvQQOzgncYUk=@dpdk.org
X-Gm-Message-State: AOJu0YxKpLeBuLBB+mdOqpzfXcDz62VpfM21/+YBnuMCODpPchuMEwkr
 4YjoSx5mHsveZgq47mCsF+t5hPcHR76t4ym3HWEyuLy78xA2gBBsInCHZJkBLcu3oSY=
X-Gm-Gg: ASbGncvm1An+gYmHipH1zhUW93rryfgPJmWdUwJ45ajdIJT8HOsO61IkOXV+vg1gYZ7
 gXsQ56oAxAeC2g0a5DvBqe0AFzKaFSLJnGuPeggBIip3ical5JZGwikL2elcqNygP9qNp3+qAl/
 lmeaAak98CXGIPVe1jpifKWBNqTe66Vq1OFGJ7pcTHuyordly4wCOLiPOQJOreUzbAVG/Vd3d97
 A8u1WdXthvGb0rE7u6VICeLXKmrR//uL3GQ0QN9eUMjbf/zVOIcZHrQyBWcVZqbn3GEsrSqWBIV
 bXkXYcXWTjRFIxRL2vm2RD2we8PvePIZNfhwE08M3lm54ALnS5CrmCBg3ABhrDuOeWDWyOHJqvq
 /nOlCarjjYdRbZvIkBZJ/EkIIQ5l8Pe+luR8UYteawTdaMKYAKJJNsJntr0oSLFuOCPJ9/nRSHt
 tO/sEwcKMAyJQLHYlNHg==
X-Google-Smtp-Source: AGHT+IERev0jbnQPpfvP//+XY+iaT0hsC43DH+5roO1qpo4uKCvtbJzV6b+rMjl6MpvNkP2m1ZAdtQ==
X-Received: by 2002:a05:6402:1ecb:b0:62f:897e:f10c with SMTP id
 4fb4d7f45d1cf-62f897ef2f1mr6208534a12.35.1758213907406; 
 Thu, 18 Sep 2025 09:45:07 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-62fa5f2766fsm1702862a12.35.2025.09.18.09.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 09:45:07 -0700 (PDT)
Date: Thu, 18 Sep 2025 09:45:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: Aman Singh <aman.deep.singh@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Ferruh Yigit <ferruh.yigit@amd.com>, Lijun Ou
 <oulijun@huawei.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v5] app/testpmd: stop secondary process fwd_lcores
 during primary teardown
Message-ID: <20250918094501.4212b0bd@hermes.local>
In-Reply-To: <20250918064703.528973-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250917113601.521308-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250918064703.528973-1-14pwcse1224@uetpeshawar.edu.pk>
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

On Wed, 17 Sep 2025 23:47:03 -0700
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> When the secondary process testpmd application running any fwd_engine
> and after that primary has exited will cause a crash.
> 
> This patch forces secondary process forwarding lcores
> in fwd_engine to stop before the primary process exits.
> 
> Fixes: a550baf24af90f ("app/testpmd: support multi-process")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Queued to next-net
