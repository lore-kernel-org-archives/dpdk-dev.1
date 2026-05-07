Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD481CD3436
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 02:40:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC2924025A;
	Thu,  7 May 2026 04:40:24 +0200 (CEST)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com
 [209.85.161.47]) by mails.dpdk.org (Postfix) with ESMTP id 15C03400D7
 for <dev@dpdk.org>; Thu,  7 May 2026 04:40:23 +0200 (CEST)
Received: by mail-oo1-f47.google.com with SMTP id
 006d021491bc7-66ee7b9af94so138714eaf.0
 for <dev@dpdk.org>; Wed, 06 May 2026 19:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778121623;
 x=1778726423; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/8iYElXkfc8E8zefodL6sMODLVVqgIFR4Q12GGYa2CQ=;
 b=mAmH7UvXoYhz2sDGX94KUoliosqlwjxqdQuq6gVUBRsL75C/NyVMCK7qVeyq6gizj2
 HszgsdcDRtt1q2hTGJdDPXB5hmJJnfgDOKYQu1YcTlRjHoaD0gPq7lWZccFaI3u5DtWd
 UeeCvKlbVEVkf17JAwO1Q45x5KDPcdheF7n19ArGBTJ6otVZEKGgPSmfRT2pkevyuOaX
 Ujg9WVIQnTt1xvM+ITyuzWdR3MkkdfVTperM22DL2QBxouHohbAUyhxay50sRcdScfy+
 S9f6oX36EwUuxHqA6+3vkrtavUQAkVNGFqFL7nog9sbOuN1GLWhtjyedHp4jAJ1m1W91
 1wXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778121623; x=1778726423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/8iYElXkfc8E8zefodL6sMODLVVqgIFR4Q12GGYa2CQ=;
 b=LyNmZ7G9RH6gzxiEK8rq5TBOFVWDEEISo3wCLhXg24CFG+oAHCIHQFC3MF0oeFXuZX
 H6YCU78d9S0N/DaySiy/w5uW+Ddl/BTbMmR2si0hLvi4IawgXItHJZ4bTHBki1Jze7Cz
 BBhtRaUjcm0JeQ9sMtCI6nnS9o8+UaPxsqoREMwVUFfxErbysg+b1br29QeoDIuRT6W7
 lUj275lv+pmGI/1Zk3xA60Nd1ni0iaEAQ5JUeTcyQWeWPbmZEkPIreKHSw9yKZ5qCpOD
 2vHUCLYXyyopXTy1tHRLTegeKVZu8qMnVmCI6ApK/n8qMZpG7ECkpZ6K0wRBCK0lL5xA
 aeTQ==
X-Gm-Message-State: AOJu0Yz4/W0tYDmb1cPwZ7oSLrNxDkKb4ki+1G4ExoIOhAlanuXavaVQ
 +OVNiopBkok6Ot+HDC2xG9waftYV+Am6+BinnuZRnNjzIrftqqLtur9k9X3tmOPntcU=
X-Gm-Gg: AeBDievcUMa3bYbCAWP6pH6XwnWzgKv0z710I+yRqUZUvlIK4mUo+b/cqBnFqm27Yo+
 oiekgoDfqt6D67qUAgcRhBRtrgH25sLpswmc54HBalJjJ4mUByebbmWxzJ4LwekcZLgo6DAfj8d
 NHrjotmWlMGC9t6mneRYTQJX7/0rLGleeVqkgxZs7ltwxa2M6uMPcYIOoGqWJu03LtNh/H60iq9
 EHmaY29yb4vkKvKlIs8i60Oh6aEqUCkabsea0ikbbA0cb/bits7KQA4KOhafNlL+SNhkITaXnBQ
 jPsvhfsnn8DNz+Xn+1VSNg1iKCfy90/xQfQ2cULZhuwIy5g+xfCL3Y1jeiVc78hTMxu8UkrvA2C
 c/UFvSlafkcT79F7XIKtE+rcMYGRvC6zs4V6YDI0QC4ztAFTiJ/5CiZ5ItG6757DtI4tsMLNeTs
 4QVGJ6QMStqwFuaUcwWIhYFH6MutYawx1DWHXjotwza8CQKw==
X-Received: by 2002:a05:6820:8c3:b0:694:9f11:c21e with SMTP id
 006d021491bc7-69998cbf38amr3329015eaf.22.1778121623259; 
 Wed, 06 May 2026 19:40:23 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69689440f5asm10761084eaf.1.2026.05.06.19.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:40:22 -0700 (PDT)
Date: Wed, 6 May 2026 19:40:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v11 0/9] Add Linkdata sxe2 driver
Message-ID: <20260506194020.21a2c091@phoenix.local>
In-Reply-To: <20260507014454.1370039-1-liujie5@linkdatatechnology.com>
References: <20260506113557.1151250-11-liujie5@linkdatatechnology.com>
 <20260507014454.1370039-1-liujie5@linkdatatechnology.com>
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

On Thu,  7 May 2026 09:44:40 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> V11:
>  - Addressed AI comments

Not better. v11 is byte-for-byte identical to v10 except:

The vector Rx/Tx patch (10/10) was dropped, so it's now a 9-patch series.
One trailing blank line was removed from the data-path patch (now 9/9).
