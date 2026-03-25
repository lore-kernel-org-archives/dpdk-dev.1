Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B338A103A99F
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:44:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE60E40DCD;
	Wed, 25 Mar 2026 03:44:17 +0100 (CET)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id AEDE6402AA
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:44:16 +0100 (CET)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2c0c482e069so3817441eec.0
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774406656;
 x=1775011456; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iJQ228XfustK4fUj3fz5K5O3t20UctgJUNGkS+2AUcU=;
 b=T8FrfQ8FGbC3wypDSpiu2pVsFMlJqdZx++bI3pVv8aoJARErHJOJ0EOho5SStrFcWA
 Gx3+LSgHj3QqtBBaX4m4bYpuf4GpgOuuuf+t6b0s5tlPf3iB01DWxtn2R+7TTJltUFvI
 BMJNbSHTvWAhD27qRbx35Tfh13qVkJdbxFpjW/kx56wfcvCawHnFaPXUNLKRQvNdDaNL
 5tbfgKfvQK3D3liAE/2m+kR9Bbsz3kOLBSAMbtcSZ2SsBx1MKbRVgkcGEU4EV+ZGh3VE
 SKYEa6aUUD8DGCijVQPP61j3PB3WA/F18iMlXLVUOmwcT3g3yttG/ed59HInzqFoFicF
 ihLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406656; x=1775011456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iJQ228XfustK4fUj3fz5K5O3t20UctgJUNGkS+2AUcU=;
 b=NVAfE1VJJsYU3vWI4bdflpHqYsqn0fbvOqJjXeJhOnC878ObbC5icoam1addGIodUW
 1krOEAc+1zsUp2GM5h8xm3DMGCs9blqG+FdkRj02BkL9hoS7M/SYCJl/hkO1nHgHin91
 ejaCsGi35EXib1IiHX/NZZEjkeOcp17VCOpz2Gy0Kcyyms1KdBLFTLz/G9KKbDLl0jB0
 D2xS3oKkuf9XT77HvxfmJOzBp2zXs/wXAvuUoGz/QH/x1LbGyg8aQMw1KaOctBmvwfnE
 9TjIBluGqL6Eqaa8XrDn+kLI6i9msmgyCZwcpWnnZmsciQn4c7pkLYJUTg9c42co5t5i
 yaSg==
X-Gm-Message-State: AOJu0YyUTV03L+jCpQ5DXQA/0uYXQvTsdgve7LbhyhnZszRZis+Q8dFw
 01/ipVhJkYexFwMhT00JvPO0/8dKQWK3f9OLSyKimvf2ILwrGMFB4Yy6s35K6hfdOKk=
X-Gm-Gg: ATEYQzybAz0rYKX7DXd01szCEi+5gvuuaKHY5DBivS2ndHuzRzqNnixoH8OxrS+myZq
 OO55dJZ/Ohuv0EXZyh+mVa6owZcSU631gZj4xxLIipsJ/JuvH2ObYeQBXBRAe4pvP26oHYEQuMV
 JKVTmWzS75cEU1mA/bV97re5YJTHPWc1rPCkYl4GXR8A3BecU4TmGzWvYjn6jjXC2ACGUM3GOyo
 LobaRrXCf60LwZB6RtbV9fFOmD71cwTn950c67dkeKFPzB7l2gLqJXpJQiTcxzTTbPJXQoyWib0
 tzI+cU3KCDgrjI+dqhPXJyeJ6v6EJleF+2GfeMYOVzW9pRJL6OgLwvGIJq4U4L386xkmtSLQuBI
 lgS3gtSei7pTvpwiP78zAjbWIkJiCuPK5S0TMg5AWR1VgfHl7mCTScW/arRWLi3h8PPMvsXh4fr
 JMxORNGfafY4C0BlT7RxgnLgIke9gZzeqjuO4=
X-Received: by 2002:a05:7301:4e0c:b0:2b8:26b8:3426 with SMTP id
 5a478bee46e88-2c15d2b5434mr664534eec.13.1774406655609; 
 Tue, 24 Mar 2026 19:44:15 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b2e6c30sm16292353eec.25.2026.03.24.19.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:44:15 -0700 (PDT)
Date: Tue, 24 Mar 2026 19:44:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@microsoft.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com
Subject: Re: [PATCH 2/2] eal: add meson options for hotplug MP message
 buffer sizes
Message-ID: <20260324193500.5c67857d@phoenix.local>
In-Reply-To: <20260325014506.1866374-2-longli@microsoft.com>
References: <20260325014506.1866374-1-longli@microsoft.com>
 <20260325014506.1866374-2-longli@microsoft.com>
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

On Tue, 24 Mar 2026 18:45:06 -0700
Long Li <longli@microsoft.com> wrote:

> Add meson build options to allow increasing the multi-process hotplug
> message buffer limits at build time for deployments with many NICs:
> - 'dev_mp_devargs_max_len' (default 128): max device args length
> - 'mp_max_param_len' (default 256): max MP IPC message param length
> 
> Example: meson setup build -Ddev_mp_devargs_max_len=256 -Dmp_max_param_len=512
> 
> Guard the existing #defines with #ifndef so the meson-generated values
> from rte_build_config.h take precedence when overridden.
> 
> Add a static_assert to ensure eal_dev_mp_req fits within the MP message
> param buffer, catching misconfiguration at compile time.
> 
> Note: all primary and secondary processes must be built with the same
> values, as these sizes affect shared IPC message struct layouts.
> 
> Signed-off-by: Long Li <longli@microsoft.com>



The whole mp API needs some work on sizing.
Ideally the message would be variable size and not include all the
file descriptors if not needed.

Even better it should be TLV encoded instead of fixed structure.
But doing this probably has to wait until 26.11.
