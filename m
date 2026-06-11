Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD821CD98CE
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 16:47:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E115E4334F;
	Thu, 11 Jun 2026 18:47:05 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id E4C094334F
 for <dev@dpdk.org>; Thu, 11 Jun 2026 18:47:03 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-304f590dd91so139264eec.0
 for <dev@dpdk.org>; Thu, 11 Jun 2026 09:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781196423;
 x=1781801223; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=88iwG+xw8QKNPOyGJXmTlRzaRyGqeAI0rdSsJqemf4c=;
 b=b4h1toOY5N1/ZJeVLLVyXNynA3YUFk9zVe1BYZD1wC2BsfFSmVY8BP7Af+RZJ8OpGz
 5ll/F6c08ocOvEg33LfVwwpE9JRzjAPhN/d6aJdrIC8/Mr9MrtMd8sVnmx7vVULHQTAh
 pcX3DeDpdOFTNXdoqXrzXCirFT8QlY3/8YUNNznnLnPwFiyFkBeVMUSFnHtUOkhVr0H1
 yaBudxA1Gq9dlf107XLmfpDB8IXIicVQSCJQUKIBbiZOWK2kPnesjb2OP9cQ18d6T18J
 AbVoxwJ0uVlIelcZy73kzufXtFOs6xmmER+PBn5rHZM3Jyu7X83xqkN4Nz61G8nn8GaD
 ACnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781196423; x=1781801223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=88iwG+xw8QKNPOyGJXmTlRzaRyGqeAI0rdSsJqemf4c=;
 b=Q4n8mAZZNMKiUzI3o20a/ERJw67T3yzPhWlJyhL3wToArejEpErl5k3op3TMPFTz6J
 zTgPTZybe01VKGkeMhbbIGWq+e/6yQhE0UditkK3fx4xfuduI3iV20JsXiI1qdaEhq7I
 XaMR/iIgL7B7reZsf30d+4Vudkk4DTqa1GN3xKlnNx5MZPa9E5U0iKKtce/9lQb0wmCx
 75d1i78gH630dudFunH6u4Mj6zgK9I+za+RyIsBnliRGvxcb4vBmBVpbuXza81i7Q5iv
 9v93BW5Sb7JQHMvrL/dFiN89fVCs/93QPbRahPw/B1FLBw9zkJi/uSwtk1Afp+Og6g5A
 731Q==
X-Gm-Message-State: AOJu0YxzRDJ6M0o7hDk9bSMwicq3cRTfTCAkSHjvYaiULEPxOkpto4Xw
 n70SCNKRyanmRvwfwo4yYmpqdVtQgKyDhrd+NPJThW3ms0OAtJG5ro9Ex4MWJCbigR8=
X-Gm-Gg: Acq92OED+J/1pC0dTc8/X4fEwm7+quAaD4JkZ5RnxA8xBV61r22vGBkvMOgHsbIIRXg
 8CqCXLsNeHChqpfyNZKzKUHdmDHx+VEg6qYr1ArjVqZKDz/+dh4fH4nnYbti3LbTsH4egJaNoEa
 9ENrmy1v4ATdLKKqQgIHCrU0p1JCa7j/BWygppQMmYO1+FvQLp4LC0mpfFPQvj3oshipUHP2jbd
 KAK1oxN3YQTMgSdW7XXckL4lbpolVI7dOZmgAVJj1IXD2Ir6qT5dBxk6cIh+g3XXM+5BGqQw5lT
 wK+DrIOne1WWkIiRzIBkCqpSXFNK04MKRvSyvo8I6l9dDbYfKdWYmy5iMQV0czQisv6euSvwW1a
 mPRqFDFiPNySe9BeiCM3SmX8NoY5uLrTlswUuxNcCBMhyxOnbLmhDXZwGC4T6dy8wSxJ9W4/1JT
 WMsXi3vfoaCYrFrUo/bje9YPTftdK6i4EEo8DVsyjcS2T9rFveqDmtKiRiP4xE250L
X-Received: by 2002:a05:7300:7fac:b0:304:bce9:25fa with SMTP id
 5a478bee46e88-30804607632mr2957279eec.4.1781196422453; 
 Thu, 11 Jun 2026 09:47:02 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806c2f0acsm3491611eec.1.2026.06.11.09.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 09:47:01 -0700 (PDT)
Date: Thu, 11 Jun 2026 09:46:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Howard Wang <howard_wang@realsil.com.cn>
Cc: <dev@dpdk.org>, <pro_nic_dpdk@realtek.com>
Subject: Re: [PATCH v1 0/6] net/r8169: hardware updates, optimizations, and
 a bug fix
Message-ID: <20260611094657.4299136a@phoenix.local>
In-Reply-To: <20260611083521.20669-1-howard_wang@realsil.com.cn>
References: <20260611083521.20669-1-howard_wang@realsil.com.cn>
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

On Thu, 11 Jun 2026 16:28:27 +0800
Howard Wang <howard_wang@realsil.com.cn> wrote:

> This patch series primarily focuses on updating hardware configurations, 
> optimizing the datapath, and refining device behaviors for the net/r8169 PMD. 
> Additionally, it includes one bug fix for a segmentation fault encountered 
> during initialization.
> 
> Summary of the series:
> 
>   - Patch 1: Updates RX CRC drop behavior for RTL8125BP and later MAC versions
>     to align with device shutdown sequences and prevent cross-driver states.
>   - Patch 2: Optimizes the Tx datapath performance by removing redundant branch
>     checks for malformed packets, replacing them with RTE_ASSERT.
>   - Patch 3: Enhances RTL8125+ flow control by utilizing a new formula for 
>     nearfull and nearempty thresholds.
>   - Patch 4: Removes RTL9151 CSI (DBI) channel support, as firmware handling 
>     latency makes it no longer suitable for the driver.
>   - Patch 5: Updates PHY and MAC MCU configurations for RTL9151A and RTL8125BP.
>   - Patch 6: Fixes a segmentation fault during RTL8168 initialization by 
>     restricting RTL8125-specific RSS/VMQ configurations to the correct hardware.
> 
> Howard Wang (6):
>   net/r8169: disable RX CRC drop for RTL8125BP and later
>   net/r8169: optimize Tx datapath by removing redundant packet checks
>   net/r8169: improve RTL8125+ flow control
>   net/r8169: remove RTL9151 CSI (DBI) channel support
>   net/r8169: update hardware configurations for 8125
>   net/r8169: fix segmentation fault during RTL8168 initialization
> 
>  drivers/net/r8169/base/rtl8125bp_mcu.c | 15 ++--
>  drivers/net/r8169/base/rtl9151a.c      |  8 +++
>  drivers/net/r8169/base/rtl9151a_mcu.c  | 14 +++-
>  drivers/net/r8169/r8169_compat.h       |  1 +
>  drivers/net/r8169/r8169_hw.c           | 98 ++++++++++++++++++++++++--
>  drivers/net/r8169/r8169_hw.h           |  2 +-
>  drivers/net/r8169/r8169_rxtx.c         | 32 ++++-----
>  7 files changed, 137 insertions(+), 33 deletions(-)
> 

Looks good, the CI AI review complaints are noise and will ignore those.
Applied to next-net

