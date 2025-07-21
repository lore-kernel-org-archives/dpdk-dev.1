Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E61AC83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 14:50:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A270840650;
	Mon, 21 Jul 2025 16:50:35 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id C152D402E2
 for <dev@dpdk.org>; Mon, 21 Jul 2025 16:50:33 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7dfc604107eso420271385a.2
 for <dev@dpdk.org>; Mon, 21 Jul 2025 07:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753109433;
 x=1753714233; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Uvcw54HajX5fs8mTa990lMHX4ZX3JKsGkEsp5noczU=;
 b=tYymVMyrOsG9YvMAmRbG6EMMzInK08ZA8u8IANepA0ooajaz/ToBCX9nri6SEzp9v3
 E5VS/vAOsEXQngs6buy8mop/8jfTBZwfCCk1mABmiYSUjyZu/oLTGoLgS9bMCttlfHz4
 EhBWvnfBCeuSFCym4kZYRExzXwJUJ9Bk40kf2EiNxqS0tE8UQtE+xda7gAucxwCsNmgC
 Tvk2WYI5GJTX2N4ahSg/GOxaYgx1Pjpam8PYTv/S53sR0luGxJs4/Sybn1iA38o8hjix
 3rvNEfTV5aAeW9u2DHEDLLIsuBkXiPk4Vr1FTfSkWqzF9ZpjcV6WFLODjMFdz3SIiECC
 2UTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753109433; x=1753714233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Uvcw54HajX5fs8mTa990lMHX4ZX3JKsGkEsp5noczU=;
 b=OdoFpn+NRw8zDtyHPV2PuzhOOgj7NCJ1co3JSzZe4UvkH/51+ZDcbhqoJHlrId6wDZ
 9TWM9LgD9hblS43p9uQ05f4atgSJKkzIbTWeSSRQGRowKi/zKKTykaHZ8Fle/JcQplMu
 WLTPwyreYcgCWbx4JBcHRhCousKOyem4RCUlDVJ6x7S/cdVbAM1OKUVgtKqNIU33SsEL
 IkXYo/Pi5RO2UYREIRtfoWYgrZYiwf1NR/87hArNynAzDdsD9/He79mz2OozXulOATJh
 G8l8+I5jqJmR8Zjnby7UwbJsQWvrSjMOvtMNFS2MK6DFaJsiOI/R6nk8BreqyA8uKudN
 fbKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq/672SbbYhO9M/XhfhKEWQvTeFa4gl5iG4y3/WmiGABHroREMSvgnERJWedK2LuvKLn8=@dpdk.org
X-Gm-Message-State: AOJu0YyoMyGJn+TInyWUNKwpJy++pExo35u/CoVz+aR4bYBu462fUQI+
 eSrJkZhYWiNXb8xIGIJd0Np1hwV3g4Eeb0/0E0/wphcizpkKFnHPXZ170LEeEATkTek=
X-Gm-Gg: ASbGncuJWkaYxgOtp6/hH+xZBKo06iNxH1simkGIo23Uakzyw/U67N6CUzM8KekpWbV
 UlecRZiYAblPC8HVXdgRBBeIlDL8Ez76eA6WiXLgZn7K/b3K9eM+lIQh0F05Qs5cWeVK+eNjVQR
 nyjqmWugTJMLizbwhdCPgSJuxXj+usRtLHM1cMyZf6CgI+sYTOjZMI75dCrUuw2SKN7VDKYtUej
 UJDOZkF+fFD8+pt5wm60sHkl6qUPVIZUpE1i68gCpbUBTdHTdbTTHyJg15KrkvdYe/xkA2rff3M
 jkHwVsWoPPEnmfOHHu5mCtYNZV5RrX0jUXeMoSBF3YJac1ON5VPbObgq+AbH5+hXgixXiJ0GGBS
 zwSSLj8cDg8jt8BEk26bt0jP8YwY8oh0die1HlSVMgIJTN323Xohz7vPUD0+S3Voq9Re2UEjqd3
 A=
X-Google-Smtp-Source: AGHT+IFG19zs/g4PmsUktmtRYWLzm/Bc+axOLeNLgfHs7/A+276PKx4ku2IOCepO43d2xTz+PKrFCQ==
X-Received: by 2002:a05:620a:1a90:b0:7e1:7e4d:a5a3 with SMTP id
 af79cd13be357-7e34358a296mr2911387985a.24.1753109432782; 
 Mon, 21 Jul 2025 07:50:32 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356ca0fb9sm419249085a.99.2025.07.21.07.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 07:50:32 -0700 (PDT)
Date: Mon, 21 Jul 2025 07:50:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>, Thomas Monjalon
 <thomas@monjalon.net>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 <dev@dpdk.org>, <rasland@nvidia.com>, <stable@dpdk.org>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix crash when secondary queries dev info
 after primary exits
Message-ID: <20250721075028.77fddec0@hermes.local>
In-Reply-To: <20250721105819.2ci66fl7bzikwb22@ds-vm-debian.local>
References: <20250721073851.963141-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250721105819.2ci66fl7bzikwb22@ds-vm-debian.local>
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

On Mon, 21 Jul 2025 12:58:19 +0200
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> I don't think it's an issue on PMD level, but rather on
> ethdev/multi-process handling level.
> 
> When primary process closes the port, ethdev library zeroes and frees
> device data shared between processes.
> ethdev port data (rte_eth_dev) on secondary is not updated so it now points to
> invalid data. rte_eth_dev_info_get() is not the only API call affected.
> 
> If the primary process closes the port before exiting
> (like testpmd does) and it exits before the secondary,
> the any driver call seems invalid because of that use-after-free behavior.
> 
> @Thomas, @Andrew - Do you happen to know if doing anything on ethdev ports
> in secondary process after primary has gracefully exited is supported?


No this is not supported.
A properly written secondary process monitors to see when primary exits.
There are many other parts of DPDK that assume primary is always available.
