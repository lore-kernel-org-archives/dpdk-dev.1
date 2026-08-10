Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0003C5AC82
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Aug 2026 06:15:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73AC740DD8;
	Mon, 10 Aug 2026 08:15:16 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 239CC40DD6
 for <dev@dpdk.org>; Mon, 10 Aug 2026 08:15:15 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-39266382df6so1530270a91.3
 for <dev@dpdk.org>; Sun, 09 Aug 2026 23:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786342514; x=1786947314; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EgM+Jba2cYWSJ37tzfszfjiwL8XTMAnFJRTfUtKbU4k=;
 b=cB1MnFN9Ze3OJTTXJ5EcAdLx7b09W90F81dUnOV6U6x/qtx4gFJP4FVsitrBNrfYGf
 e0OG03bxz+wFBL1uCwUNGV9Q+SerUElXHuxcdACzNhz4iksqZnWZoarJ4koMILSkh7R3
 wjmwf3sZzXm32dfMosW+G+qiE3DA7GDWylck4RNfqpWAb31uJrhBKUZWTXKp4h3kW6mL
 W6y68bE6L0zdXiAM2JBgU6p0lMdpzsVcHzHnGD2oQpza3FmSHx+bxEsdQad8bS5zbbI/
 +9draz4GBvLLeLpCBENTNxaOs3BxPs6qfSt2L7TJnnxjlNpy3r1tIJVSIOjbHtJy+fMd
 DnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786342514; x=1786947314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EgM+Jba2cYWSJ37tzfszfjiwL8XTMAnFJRTfUtKbU4k=;
 b=NnmClPlIngbLRLfPYuXKQOOE0FsSEtdj4eVr1P+g2wHreh9jAsAMS7BJ3YEO9dxCXn
 D71bSJ8en4vqTAwC0I1jwFryg/GpUlopUQXn+c7iM15D+8RRFmoueFl6ktr/0YMBmTgY
 4MFK997wqTuoCRay+NUJxmvn8kzUnUOUhXqqA+m/txJT+HLZ5iF2Cjtzq8+rD4grojC0
 97ISKIIOctY8PLAmVZ/f/GM1i487ZX6dFtRKgt7hx7AzAxvT8PWaWNo3Oknnce744ttO
 iIHvr00LyRnIcz1UPYZ0bZqZSpJQcNyGDwsz9A9RcrM/zHeOXtw3s9G/oDG+sN3B8qgR
 X6zA==
X-Gm-Message-State: AOJu0Yw3vHWeZtFRrY5IW5WVdbZO1uTBV+eOmDMKu4zGey4iOlehiyUG
 E1xdu22GJSqO1eDLbYz5ubmzDOXcsXirvAZAT61XEyOi0kDVsruiSdN4nAVdt4iB
X-Gm-Gg: AR+sD11y8cOYH3y80vXdDh/wXyifupI5ePVdnuhc3uHQ+3VWaiMeBX8LdRZCA/WHN2Z
 xltiVjiCuNAKfQa6Y26fqiK8GTYsvUa3AQSS0m+o+UfCudoYkzhiOka62DbNNZpNPKllcPmeOwe
 0/nUksgysoNj2GNCNWUFMrKcBeUHntk1AH1bpMjmNdCtemvxAfsr0qfoXC1ls+6Hy0wsEX5PlxS
 YWEFId3gf6nd7sJxWYdm21sHJug9f9rAqVNOrhrNiXqWvmR66HM17S36LQd4dzcYNpbfTqyfVFK
 DhbLwB+Lrs/EIwnEsTlX4NtRX+uVA33+0Fcb59sLG+eLGsQCdd0bubJJu5+HVhcKyfTGBg6+SK2
 sLlGar5oLAmBn2YI/yFSafDYEl3niwu58fi0NUxeqaQyWVHynkWACaMlm6nMA9iyk1FYbmwcktV
 7ekkJvIhwKJlb92hFU/IR1UDgU4PLRDYaoPobBYY298AwmQqck/91SjfQAEMml7f7x2H1k588bS
 40aYfAF3V0=
X-Received: by 2002:a17:90b:4a8b:b0:37f:fb1d:63fa with SMTP id
 98e67ed59e1d1-3903c5d317fmr34417941a91.15.1786342513978; 
 Sun, 09 Aug 2026 23:15:13 -0700 (PDT)
Received: from dev-template-2404.. ([192.19.252.250])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1410199bfd8sm32261032c88.2.2026.08.09.23.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 23:15:13 -0700 (PDT)
From: Samar Yadav <samaryadav5@gmail.com>
To: dev@dpdk.org
Cc: chenbox@nvidia.com, maxime.coquelin@redhat.com, david.marchand@redhat.com,
 stephen@networkplumber.org, tiwei.bie@intel.com
Subject: Re: [PATCH v3] net/virtio-user: fix eventfd sharing in secondary
 process
Date: Mon, 10 Aug 2026 06:14:56 +0000
Message-ID: <20260810061456.2309560-1-samaryadav5@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729110657.1027950-1-samaryadav5@gmail.com>
References: <20260729110657.1027950-1-samaryadav5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi all,

Widening the Cc a bit, this has been open since June 24 with no
review comments on v2 or v3, and I haven't seen activity from Maxime
or Chenbo on the list in the last while, so looping in David in case
he has bandwidth to take a look or redirect it to someone who does.

Quick recap: the patch fixes a real bug (secondary virtio_user
processes can't kick the vhost backend at all), both of Stephen's v1
review comments were addressed in v2, and v3 cleaned up a few style
items from CI feedback. All CI checks are green aside from an
automated review warning I've verified against the code and don't
believe is blocking.

Happy to rebase, resend, or address anything else needed.

Thanks,
Samar Yadav
