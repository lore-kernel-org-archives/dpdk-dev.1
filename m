Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B40AC021A9
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 16:24:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9ACD9400EF;
	Mon, 17 Feb 2025 17:24:17 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 10CA0400D6
 for <dev@dpdk.org>; Mon, 17 Feb 2025 17:24:16 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-220c8f38febso81543865ad.2
 for <dev@dpdk.org>; Mon, 17 Feb 2025 08:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739809455;
 x=1740414255; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KidctXc3XIjHZCbmt3h7FXxovWXeU3b3cNXmCFDz2Cw=;
 b=JycV8Ue8kHlVj3/iytFHrupnwuTBSreaPxQY8IxYDaHThIBdYp3oPkGFQrWmPaoukJ
 lfohpw45XLHOFQzSu+LeAqZyTKo4A3DfvyD5EYdej6sIx/h1DEFmf02iFGdiHYA9NWky
 Aqyy+4hFksB5w7PVlnlRiHZ0Afub5A8Zwr0HbPUrFYEfvoxWx6hvGzIlzJxelMRuLxFG
 5hweyCjiJ2PZ3dVIS3dB2yR20Ka/uXnFGmKYHwWcwdkSgv500mDZ9mx3vhVuG3K5BSNb
 Mi3g/w9cYS7qN6rfjaXN0l5dBrFTlntfpzX6i2rzo+fOG2pTspKkX9872mkhUkNvreND
 i1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739809455; x=1740414255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KidctXc3XIjHZCbmt3h7FXxovWXeU3b3cNXmCFDz2Cw=;
 b=CAOwzbwbqAhZghuIBNZjlW6pFTht6znfWgMQaJ9Kd9thM07PZtt7j5IlRqTAU3sV+H
 TeeSe4LJ601XrFGH0OrEfMUosrL/GClFcQCtS5lkVa/fffzJQ7U+ptGKcOBGCK4ReXxD
 cqExAAJvXBx/G6fanOD1WtnfUoJwf7/satRIa85qhi0nUEXzPtzaCkmUKLCNmG6IxP4k
 BOnjrxGqVZ3Gm4gYGxt4dJm+hkOVp8ZhZTWQ/s0hzPOHHimygjHhUir6mCh11XVHRvVr
 80mzAbRM36m/rdP7HzvGFEMJSw5SViYRL0vNjqRuCbTjPja5GPNqaR2U1TrEn+GANthj
 oNSA==
X-Gm-Message-State: AOJu0YzAbPEruMX7WXwnI+bJHYCxxtln1Kg7cSkjr79o4xJr2D+nh4Nv
 OScvUrBPSsS5PTQ+PYBsHIo6cHFGITZ8OAoxHpt1InJrJzNluATLu2bphctCLsE=
X-Gm-Gg: ASbGncv6qyd7swCFKOKPYzmmyM4V5gX2uhe86ZZlpmt6oW+3DuwF+Kz4nlUTB3k0TKw
 TiCQSqe3LgXdJsvVcYleb4Y6B+uMsfCF8NFTUWDwsD8R++fufNgy+Wj4NLjdc9SYIVUm+CfvL7d
 DFBEF10v9wGfqdESse3/3raqhzGPHHgD53YHFQ79AJLPs+qI8wk4Cn7/AnpuDOujNDkJt0cD2UX
 uKEcGlUF5/jUmjRqj71NuAKde4zXb+bogs1VD6FnB/pgQr6gkL/Awu0W12Y1ItTZARd3A/mfBJX
 pYq2cwXWMJTMr6agu61AcEosCeHu/o3d7+u6RXkwXNaUSZvz+IKFYSI/v6B5tYWsOE3h
X-Google-Smtp-Source: AGHT+IEJC7jm5IayhH+sfQ4ZEKBAi0FOuUUJAq20ed6auL8NgInWWD2v8halEuQSWJQ8kaht1aYCtQ==
X-Received: by 2002:a05:6a21:394b:b0:1e1:a6a6:848 with SMTP id
 adf61e73a8af0-1ee8cb8150amr19237189637.25.1739809455138; 
 Mon, 17 Feb 2025 08:24:15 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73251356d78sm6818805b3a.100.2025.02.17.08.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 08:24:14 -0800 (PST)
Date: Mon, 17 Feb 2025 08:24:12 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gregory Etelson <getelson@nvidia.com>
Cc: <dev@dpdk.org>, =?UTF-8?B?wqA=?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, <stable@dpdk.org>
Subject: Re: [PATCH] testpmd: support meter_mark init_color in indirect list
 configuration
Message-ID: <20250217082412.2a45a531@hermes.local>
In-Reply-To: <20250216140420.216805-1-getelson@nvidia.com>
References: <20250216140420.216805-1-getelson@nvidia.com>
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

On Sun, 16 Feb 2025 16:04:20 +0200
Gregory Etelson <getelson@nvidia.com> wrote:

> Flow actions parameters in indirect actions list are created as
> read-only and shared between all flows that reference that indirect
> list.
> 
> If a flow rule needs to apply rule specific actions list parameters it
> does it with the indirect actions list conf parameter.
> 
> The patch allows flow rule to set meter_mark init_color value when
> meter_mark action was created in indirect actions list.
> 
> Example:
> 
> # create indirect actions list with meter_mark flow action:
> testpmd> flow indirect_action 0 create action_id 10 ingress \  
>   list actions meter_mark mtr_profile 20 \
>   mtr_state 1 mtr_color_mode 1 / end
> 
> # create a flow specific meter_mark init_color configuration:
> testpmd> flow indirect_action 0 create action_id 11 flow_conf \  
>    actions meter_mark_conf mtr_update_init_color red / end
> 
> # queue a flow rule with indirect actions list
> # and flow specific configuration:
> testpmd> flow queue 0 create 0 template_table 1 pattern_template 0 \  
>    actions_template 0 postpone no pattern eth / ipv4 / udp / end \
>    actions indirect_list handle 10 conf 11 / \
>    jump group 10 / end
> 
> cc: stable@dpdk.org
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>

Patches that are cc to stable need a Fixes tag so that stable
maintainers know what to fix.

But this does not look like stable material since it adds new functionality.

Also, current upstream kernel checkpatch doesn't like # as comment

 $ ./devtools/checkpatches.sh 

### [PATCH] testpmd: support meter_mark init_color in indirect list configuration

WARNING:COMMIT_COMMENT_SYMBOL: Commit log lines starting with '#' are dropped by git as comments
#19: 
# create indirect actions list with meter_mark flow action:

WARNING:COMMIT_COMMENT_SYMBOL: Commit log lines starting with '#' are dropped by git as comments
#24: 
# create a flow specific meter_mark init_color configuration:

WARNING:COMMIT_COMMENT_SYMBOL: Commit log lines starting with '#' are dropped by git as comments
#28: 
# queue a flow rule with indirect actions list

WARNING:COMMIT_COMMENT_SYMBOL: Commit log lines starting with '#' are dropped by git as comments
#29: 
# and flow specific configuration:

WARNING:MISSING_FIXES_TAG: The commit message has 'stable@', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 5 warnings, 111 lines checked

