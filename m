Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F65CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 18:48:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1367A402B1;
	Wed, 20 Aug 2025 20:48:52 +0200 (CEST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 266B740292
 for <dev@dpdk.org>; Wed, 20 Aug 2025 20:48:51 +0200 (CEST)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-3c43399ea42so161893f8f.1
 for <dev@dpdk.org>; Wed, 20 Aug 2025 11:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755715731;
 x=1756320531; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BVVCRwbysS4WKAG9KSFAM3X3OorkibPNAii7LAX43gA=;
 b=2E/ROzD5NBJYV1bxnzRBfoAAODgAgjeRKoguiVQevBBTM6c3ENnqy6GLcBsz1djiMr
 MjdZjhODgdiGBRFaKJfM5dybOAWx2Rul6lIpAvSiYgmGJsBAye1nZao1jpls8Srg/ZhV
 P8u/GJUV7PKcsuWvqFiDumzUgoXsyPWYr8G99CT2CVkMFLORcCQ1DeTrbDxS9zcb8k9/
 IJqUJydIeimiiSyaVcrt/K+omUzndJ1e7ODNBBGMiCqRzN/5dvfJsZVXRqRHE2EguCz7
 kGjSnAPApPm4qazpa5Z/A/ZSUcBC/zoVfWo6mRTT+rxhluWSZtB2N3vKB1ekBjiftQ7P
 GHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755715731; x=1756320531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BVVCRwbysS4WKAG9KSFAM3X3OorkibPNAii7LAX43gA=;
 b=bZEbUg0HfCQEGuaZR1+9ouidFokm+acdI5pkfJtHTXAE61nJLUcXYK6nzpk20fG/xb
 3jjoAYwlYNE7r24SMLxXEsEPu5v0iIOk31N7C7KLCb3ifMrK5QZPY5rXFQrXYQLx+xjl
 6PiVFwpsBVKNUwAR6oT9ByMzzj7ah/wZguGTQ39nEgUTMlJx923RLAmFItQLnm3VEpL+
 5gNfsYRtza/Yu/fRHdL3gb2+pmVlX5Mz4n4GOp1Mbbls7JO3SyUHUAzXXBrVT20TUD/x
 vXEcmIp5DhLtmOyJKvSTkOaBMpM5FMsPb0jlN1RH1xQTQQyZ3d+hR+ejKWpulwDiIWcX
 yy2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx55cW4+wXrqyVzsmkLT9isZtopUF/66hmYAfz0HKXHqFv/csAhrlHDi+bQ/idO5I7rZE=@dpdk.org
X-Gm-Message-State: AOJu0YwSf3QtQAynd+nP5aMMk4ln/5vSaFxgVhnWKnv4CiMnPqv88dfc
 /ae0J1GA7htILya5ZXKTmdTmaLPvRcCUSGjU5W2+kSTRlWgiosL89Qen+JgAHTP0Exs=
X-Gm-Gg: ASbGncsWdxVpOxkl4TkdLxN6o6a5SrzXrNVaRvN1yqqO/g5Klo5r+nYTBErba+dYqtP
 pv+L3gbTOSvRJny9HTWy3XXYaTs1kHB+EDcePlEdg2YwFFa4N6v9EV4if0j9IU/l989X/JR4obJ
 fGQxKd3C3G1zCPaDz4gb/mzK0JGZRVFPt9LsX5HO48WzKTJPu8hWnh2n7EkktsqNHhOpH+c9rcc
 vI1Ml0STffd1kJ70oOXT0tXu2LojvzUp7wgDaHi9ZP8Q3lt7KjpITpbJQOAo2PKByUmnr8iBIxI
 RDbqrpO6U3koeZFOWNG4lFa2TaPjHFC1WyvkDPM/1OdXLw7hgxIsam4q3y2+thlD2803lwyUh5Q
 eTtKq6hn3FjJszNHjiFXrQxz8pSYl6Yl8Spvt/hNiBm4Ip+20TwgvbHQ1NU+kqKAJk7uIf6Yr5D
 k=
X-Google-Smtp-Source: AGHT+IEjUAvTa0tuUesk37FOGV3fBAtOPnoFpoNqV9WF1+WRLoEsCLMri3FNScmMm7BXgdIJC/VFbQ==
X-Received: by 2002:a05:6000:2001:b0:3b9:16fb:bfe2 with SMTP id
 ffacd0b85a97d-3c32c819fb7mr2894984f8f.18.1755715730594; 
 Wed, 20 Aug 2025 11:48:50 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b47c4bd0asm42985395e9.14.2025.08.20.11.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 11:48:50 -0700 (PDT)
Date: Wed, 20 Aug 2025 11:48:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: Aman Singh <aman.deep.singh@intel.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] app/testpmd: add contrack CT state inspect commands
Message-ID: <20250820114845.5c18bb6b@hermes.local>
In-Reply-To: <20250815111514.3866449-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250814085831.3511020-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250815111514.3866449-1-14pwcse1224@uetpeshawar.edu.pk>
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

On Fri, 15 Aug 2025 07:15:14 -0400
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> Add command in testpmd user guide to inspect conntract CT states.
> 
> The conntract possible CT states
> are SYN_RECV, ESTABLISHED, FIN_WAIT, CLOSE_WAIT, LAST_ACK and
> TIME_WAIT.
> 
> Fixes: 4d07cbefe3ba0 ("app/testpmd: add commands for conntrack")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> ---

Queued to next-net after fixing spelling in commit message.
