Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79AAFD45F6
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 22:20:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7995740279;
	Wed, 25 Feb 2026 23:20:09 +0100 (CET)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id 062F2400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 23:20:08 +0100 (CET)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8cb49f63238so8067785a.0
 for <dev@dpdk.org>; Wed, 25 Feb 2026 14:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772058008;
 x=1772662808; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oPZLB+fQ3JSjtiIgnPQTT8HwXKIyEHwzuDBCiwvOrvE=;
 b=JgRKdXJfB0YE/pAGPTfWGFCoiQtwGDtU94XJoLhhLyXcoVs8Rnb2gnilTFdvBekmjw
 Ke3aK9ygKJDQfOiYXtHibc4pmaY4iG3eLXCUQwuwZj/O9SBva4xthwujNqULJ71zdGjj
 pjpaffxyBcjE1W629t9bxEsLBbw1PjNOc9UKB/Ng/GPFEh56sfl4zPUP+zwEy9OJH8Yr
 Zv6cWXgvkXa7/xq0/WFRC5tTKWFBKt0+3xuU7w5nKY8a92eB/DtruKg2VNTW3U6T7X6L
 6aLozvZ8ziLFKinxVCx/pz0tdM5s64ft1zZVdnjYuu/Z9yuPFqxZcWhITQ3AaZSSYCWH
 qKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772058008; x=1772662808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oPZLB+fQ3JSjtiIgnPQTT8HwXKIyEHwzuDBCiwvOrvE=;
 b=uo7MR1MC/H2RmJBbPfX88MAWUAvT0XvDoBaIBZcyH4lXZG3SUTVKocJ8OYDQaY4rNo
 0BPPTOy1yHzuxS/sevuqKKZ9HpyqKHU8cXs8Gc0hP7RmsiL1KMqRZJeUVBHI7Yk4RjNM
 rUxzUX3KojDt+h837o5BAGoVOzsA54OFrD4yRlmQCK1WwVzx/hWu5t6V7Ma9BTIVtzKc
 DRkQfk6E+0cZjIDt+X1YbFu2VjRrGXEMsWvpJf9/u4VnuyGffBHEEAAbtf4vNKWtxujn
 0J6YfTXyVBrKgAkyx+UHveOoI0FW6BaICLV/wAu2TPpZn1zo1PxhrHZ25MuQkW7Bm9QV
 mmZA==
X-Gm-Message-State: AOJu0YwFE9TB0wZjTz+rfuO6OevHbnYDXLgbbEyBgtNQ23ZfH42zZEUd
 QtFg9Xh4ESeof9PAiG7QQeKUaO9nmqFEPrEHepRj0gecON2gyTpfx76g+Xw7B2klWUE=
X-Gm-Gg: ATEYQzwx+Ac/6qvHLDVFvuZ02m5rAPEm3s9VGBRn927xD0FlGZ8nyNaskICJI3p2Zxe
 DDZhU1IIGe90jEwj8+myhPifVAlFLMNDbrCKSu02VDvE0T5GKz6rgEnwuwAIXluUj3IzVPSWlqT
 pLpfc3gEVr9xb6EYyY4cjvfpBtpIQCIuRcyQVJn8gw7QFuw3Vc2ZlpjEapvVqEGQ/OmnNcc2UWl
 hQ0TQWXiqq7SRQsfKtpybwJ+2jSyPuXdAMJ4TmrgPp+BtAEDSsv9UmuedeS+6GeqA431U0tx45e
 r+dhhj3bZTNDAwiXwxuOrs+/HmMuyhFB8p2O46fC1LQMLRhaq1dmq0+bD31qw6yQf4HJSNmN6Hr
 saVfzwXi1RJprY/5aemo4xnLW6zjJsT9et2shEJ1rDaVYIIUA7XG32IkUgOnNKnOD38zC12XQSY
 ZFBTdoQa40nC0Fxd9q4JmvWUPAiE7uZAs8Q557N1E6WmvdFXYoGVQyYCf6PYPwjUZ+
X-Received: by 2002:a05:620a:7019:b0:8c6:aeff:4002 with SMTP id
 af79cd13be357-8cb8caa12d2mr2279076785a.81.1772058007924; 
 Wed, 25 Feb 2026 14:20:07 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899c7374e07sm1903316d6.33.2026.02.25.14.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 14:20:07 -0800 (PST)
Date: Wed, 25 Feb 2026 14:20:04 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
Subject: Re: [EXTERNAL] [RFC] net/cnxk: only build if platform is specified
Message-ID: <20260225142004.07954fd2@phoenix.local>
In-Reply-To: <PH0PR18MB40860D76EA53C8DC495E81CFDE75A@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20260224203709.27696-1-stephen@networkplumber.org>
 <PH0PR18MB4086434B58662DA7BF5F5F00DE75A@PH0PR18MB4086.namprd18.prod.outlook.com>
 <20260225094338.5f0641a5@phoenix.local>
 <PH0PR18MB40860D76EA53C8DC495E81CFDE75A@PH0PR18MB4086.namprd18.prod.outlook.com>
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

On Wed, 25 Feb 2026 19:30:45 +0000
Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com> wrote:

> >>
> >>  
> >
> >
> >Good idea, but fails miserably.  
> 
> My bad, here is the full fix, verified on our arm64 machine with 
> meson setup build -Dplatform=generic


Ok but other than getting more build coverage, is there any point in
building this code on a generic platform?
