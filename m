Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D62ECD6FC
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 00:23:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77BC940655;
	Thu, 12 Feb 2026 01:23:56 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id EC12B40616
 for <dev@dpdk.org>; Thu, 12 Feb 2026 01:23:54 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so30460725e9.2
 for <dev@dpdk.org>; Wed, 11 Feb 2026 16:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770855834;
 x=1771460634; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9YEQ2DYuQdWYwik9djSVg+M2yiTS1ZT0+4cqmtOl6NI=;
 b=q6ea8xffqQQy8Zc/sxNZZU0mXuO9qs2xz7INaYBbqE35ghP52IxjmDPF3lNegcmSHO
 96rFEDl6hulagfJN5roFoBqZOvqO07rQYmS/0mZoAnXaHoye70a3bLlm0dx6nXQ0jeKK
 hIiTxpzOaO9Q4laGPeD97qUKCoN+ORuGMz8CmbUTTr6v59mSw8gKDG32PgHblMbwcGbY
 z63ywt3sH7nhgZVGtXz/jdbUZV5eHu4zy3yUW3JfqTzpZoiigwlb4/u1T8W2ijWjZ/ZV
 HUIcmrjOZm5kE2FYRzixPcTEFuPyoODb6pNOyaXPqcajCIe/JI8cJ5PTG2F1zQzzOy2G
 tidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770855834; x=1771460634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9YEQ2DYuQdWYwik9djSVg+M2yiTS1ZT0+4cqmtOl6NI=;
 b=vzQfsGOU1MmiSgRtEItI/ci8JQejBDSTWmAGtFSgp++5ZJdsCqdrPZ+F96hjChuuo8
 WA1dNPo30NEswSuKfrfTMD3QjaU6ITV1fckJxV2OUlyIO41wxgU9f/y9DpiQNm7/FC+G
 9JDt5HupgBzzJrJurfws03qqEPm7PTEcDJ5fubO2juU8ci1VEYv/53T8ckVpMIs+MqFf
 LNFnttSp14rqFysCQIgJGt+Bt5M18qrZwNiZD1vM8EvDrS45hGKEYhOh9DKfGPVvFPrs
 zSVIferEuNvOZAQy7ocqT6GkdZS2w/PZQ4s6Dw7Y8m2kVSnX/JOEBoa9b/zJXZt3UBB/
 pQcw==
X-Gm-Message-State: AOJu0YxGEuj5aML3nkQBFooKSqJdEVhiPnImY8WEUma2PEDUe0djAqu8
 OQ4mhJO3ULeJ5Q3tZX9mKNc/uMAs77BiS4hXSCiDBmr4XPcGjoNOTJVkSDiBrFHL1QvGV8jh7z7
 ogCGT
X-Gm-Gg: AZuq6aJuK9xi6HBhtM+OJqED9vNkW1OJCv9f72McWkszQwsrfJyTvLgt7uBisWCAdfg
 SEJF0cxdDqf/Qcc+zTph9tberOzHyWsSa0AOuCtvoPmxLhAfoSXNQBd8IU1wK/fvmCAmeC7+BAZ
 oSfuTorkgRxlUGt8s4qZJs8KAGtsGLCSV4jm5WCkrT2HYUlwoV8n7ih1PsY2LWIkqxEKdMp4HKO
 UZ1+gLp1KkplU6+ons2xhwMTDGvaiX0Je/uaqHZ+OjZtnRFqZ+nuQva3oITEjYFw0MWPtmSJO1G
 79thOpyEZHyM+fSjI0jbLnQi/fB/iyxfzrMXF2f3DWIw8Na2q1h9Od6jiXxsYXds+1zyEs2vUF7
 wDiWvU4tI7eNbOYLtrAbyl4QRPU/lrxTBS+6k/yFLn+LJINKrn3YTdaZpvafdarNpdmRhZ8C5ld
 27JBzhBr4cgP0LJQF+n21rcNgdIiMQTTlF5wGLEniiNpP0XuWN5wDz4JlG/V1oEyTlS1bqm+j/K
 ag=
X-Received: by 2002:a05:600c:310a:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-4836716ac08mr4522715e9.30.1770855834441; 
 Wed, 11 Feb 2026 16:23:54 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d989165sm98309365e9.2.2026.02.11.16.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 16:23:54 -0800 (PST)
Date: Wed, 11 Feb 2026 13:42:35 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Howard Wang <howard_wang@realsil.com.cn>
Cc: <dev@dpdk.org>, <pro_nic_dpdk@realtek.com>
Subject: Re: [PATCH v2 01/12] net/r8169: fix NULL pointer dereference in
 rtl8168fp_ops
Message-ID: <20260211134235.258f347c@phoenix.local>
In-Reply-To: <20260210055511.62382-2-howard_wang@realsil.com.cn>
References: <20260210055511.62382-1-howard_wang@realsil.com.cn>
 <20260210055511.62382-2-howard_wang@realsil.com.cn>
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

On Tue, 10 Feb 2026 13:55:00 +0800
Howard Wang <howard_wang@realsil.com.cn> wrote:

> Fixes: d9ee71b5f1bc ("net/r8169: support RTL8168 series")
> 
> Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
> ---

That is much to short a message for a critical fix.
How about this (AI generated) message. Can I add that during
merge?

Subject: [PATCH v2 01/12] net/r8169: fix crash in RTL8168FP init

The rtl8168fp_ops structure was missing the hw_phy_mcu_config
function pointer, causing a NULL pointer dereference during
device initialization when the driver attempts to configure
the PHY microcontroller.

Add hw_phy_mcu_config_8168fp() as a no-op function since the
RTL8168FP does not require PHY MCU configuration. This matches
the pattern used by other chip variants that don't need PHY
MCU updates.

Fixes: d9ee71b5f1bc ("net/r8169: support RTL8168 series")

