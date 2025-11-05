Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466D1CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 19:03:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A871D40A8A;
	Wed,  5 Nov 2025 20:03:37 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 65BBD4060A
 for <dev@dpdk.org>; Wed,  5 Nov 2025 20:03:36 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2956d816c10so2458575ad.1
 for <dev@dpdk.org>; Wed, 05 Nov 2025 11:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762369415;
 x=1762974215; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lgbXzf70odsFhnQd8E77vHqghlYeC+zHitAGo8zOb80=;
 b=3UFRRyP4sG3Y0QLh7+NE3Q0ieJroY6ipSMbI/sp5mVm55CLLWTWd2ulN0j9FHu4waD
 chatvOa0GDN0CNvUap54xjZ9N9ylXDj3c0D7rDAW6gJdQ0aMGQJvOuoxVcADIqhUrwBb
 JaqKdiiTq0XUOrOdSBOlEz6EdTe3tnqj5AHrUxDcPUPhXxFIfnJgUpvcNMTLkqj60/EJ
 j1Fprpj/LpFIZY06/1ltMV7X/CDJ7kMBtWPLZ9KEqr3rl1w2E+JJGWHyeUKE3XXpsK18
 ddmp11qBAfd1vD+XbfjmBMvQaqr+lEI0x+8xgHiXCnOfmRWrOl8/zjOxYiQvRNtTehG9
 iLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762369415; x=1762974215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lgbXzf70odsFhnQd8E77vHqghlYeC+zHitAGo8zOb80=;
 b=KadYwTv/p+4g71sCKH1a+2WxqIRYcC+cRXIwn64XZJ2inOIO7WViCYCHsuN8reTsoO
 yX2wt5++UiduDHJqy2eCLNuifI4dKoCbB0CMDJphtWRN+xlfl+in6vTFVpSxUdMRbJ/t
 WkW2y4znQwx32ynoPLhIccnXs5IkX9geFM1kSabwAB+cwy6bf167m9Wlrp22P+pUxLMs
 nWS6Teemd+jtoVLQmKrrkSI4h6hrnKw191OgKOdM8YRBgWncgBSQPP2cBr4YQAWnvjm7
 GhUMYbhx8SWeiEa+la7vxvlqjMnKknK2UByUEdLDxX9oxAoTDxL+lTp+pSoc18e2EyTE
 +qqQ==
X-Gm-Message-State: AOJu0Yzr/2EvtSygyto1eXTgOkuRX2xwKAvMwj+HtkdP+5o2bQBIDrFr
 BnyJElrG2T/jDXmmHmM6X4L3q3Bayjsr4qAS/D5lxaO9h3UbS6ZUyQTCJOhru+u5AbA=
X-Gm-Gg: ASbGncsjpGqP6j0OI4JzZRHaleTj0ORpSY5MnpWTpMT/SxCbAgvRvpxQhsKTgJX5giY
 Y7zaV5fuSU6rgRW+ByC/0igbT5ysY7HQGEl+ksONZ0fJ0QJ4hYtEhyG8eoqASMFt60PdeN7Jv9Z
 SBPmnD0bvd9pc88O6JZ9LofEecJZ7pFlQy68cMEosQQoD4mmtLPU5Ej9I038eFVDyhHUmQL5dGA
 MqVT4fkXVO+GG8SB9rKfTIyNAZlfibInMvc9aghsPaqtYiad2PHHtdsQ2xu1WoMSXJZFlfmE0OY
 ro3g6Otq8Z8TcuIFHGuvkzd+OZodwdEp17Wyl0f8ztVxvjn0iYltoU1EYX+eJfxQKLwWg6qVpOK
 U2CeDg0f13bnIp3qOZ/LiGZxYGIE1baevYjt7TQ4eCYt31MOPSH1PiK2GEnzH6LTHlIxsFHGIgj
 QI1vrbOWTkF7okKiJSJMsGA/IIWBbKFGgsnw==
X-Google-Smtp-Source: AGHT+IEShM5ZIP3WK0hZuVRoi7j+Help8lkQoKTiejqNjbLil8z/j8fxm4uS39kOYwQNBiQNJuJ5hQ==
X-Received: by 2002:a17:902:ce84:b0:295:19e:487b with SMTP id
 d9443c01a7336-2962ad07945mr68097485ad.5.1762369415371; 
 Wed, 05 Nov 2025 11:03:35 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ba8ffe36ad7sm64014a12.22.2025.11.05.11.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 11:03:35 -0800 (PST)
Date: Wed, 5 Nov 2025 11:03:31 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, Chas Williams <3chas3@gmail.com>,
 "Min Hu (Connor)" <humin29@huawei.com>, Pawel Wodkowski
 <pawelwod@gmail.com>, Declan Doherty <declan.doherty@intel.com>
Subject: Re: [PATCH] net/bonding: fix MAC address propagation in 802.3ad mode
Message-ID: <20251105110331.1975b42a@phoenix>
In-Reply-To: <20251105180135.1181619-1-shperetz@nvidia.com>
References: <20251105180135.1181619-1-shperetz@nvidia.com>
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

On Wed, 5 Nov 2025 20:01:35 +0200
Shani Peretz <shperetz@nvidia.com> wrote:

> When changing the MAC address of a bonding device in 802.3ad mode,
> the new MAC was not propagated to the physical member NIC.
> This caused the physical NIC to drop all data packets sent to the
> new MAC address, resulting in connectivity loss.
> 
> It happens because the MAC update function only updated the
> LACP layer (actor.system) but not the physical NIC hardware MAC
> addresses.
> 
> This fix adds a call to rte_eth_dev_default_mac_addr_set() to update
> the hardware MAC on each member port.
> 
> Bugzilla ID: 1158
> Fixes: 46fb43683679 ("bond: add mode 4")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> ---

Queued to next-net.
Modified patch to put check on oneline since max line length in DPDK is 100.
