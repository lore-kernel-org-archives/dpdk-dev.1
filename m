Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A79CE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 18:20:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2DFB402A0;
	Mon, 17 Nov 2025 19:20:09 +0100 (CET)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id 2F3FC4028B
 for <dev@dpdk.org>; Mon, 17 Nov 2025 19:20:08 +0100 (CET)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-7ba92341f83so444982b3a.0
 for <dev@dpdk.org>; Mon, 17 Nov 2025 10:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763403607;
 x=1764008407; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yw0XnLjIQoCioWFHgfCgkSXXouKZEaifFN9MdNja4J0=;
 b=r5gOQM1MBaLlQys5tvcilgVAOXU3oyG42Ta7Mit+6tqhXwyT2Y5/AbgPUBH2kbJXJ+
 9Xk+kbecCfeQSEJHnop/5Povv6NMQ41eshTHWdpUnJO9zo8TX8gY0r8oBrvHJgc+/Ukh
 7OVq2gQ81jkGVwd/wgAiN05Z/bgZiIx1QXuWDJDZRjzbeXQmsu4yA9X3KFpEbfhbRdRJ
 /sdZKT+rXnEZfTvcvQP4i2ssr2vyo4P0daLXjqZxcT4eooZu+N7G7Sw6rk/YP7ZupNyZ
 X1kLV10MkU0lVltw/qECusqqw44eHc1k7uZmHnFg7PQG/tAnJziLMz54+erVyN2Sw6r/
 Hfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763403607; x=1764008407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yw0XnLjIQoCioWFHgfCgkSXXouKZEaifFN9MdNja4J0=;
 b=XMjKb/Uijo+/AZoZ4s4E4mlncbxMuMjmKmfY0W+uiDXZ6oth2MYhA89X5aQnhFpYn1
 xIGQVwA6HpjTnop1sM5T+q+xeJQT4ZcoYeWwWt9VNx2yMmmsU/baWpk1e+i6eEuWWEAY
 +uNwe0/2WzlTH6HdO227SECQg1Ul4ZTfz3LQsHN/YQSYnNRsxhKM9ur5V528ZwJZA1kz
 pxVr22VwA3P5T+GmbhsI7siTgDLpX1XC/Z8zgnbVyu02lW3jbWKZo6XgEXZn59aC0Xa3
 pit7gvg3icL8LIvuq3ku0LTIZMxN6SWUb0gjyOvpGW1ukqiPCmT1molrsOerWT/mf4HD
 xGTA==
X-Gm-Message-State: AOJu0YwPnuo9UPlCj1L8RgI6iCg90aF9I3MCQeL1IcFco/K2qhgSakkM
 uR2wwmASw0it31tN1KI2uEFI6pVd90hlEz+X04zaiXNrL42YVT3qtA+saVLMLAjgXyM=
X-Gm-Gg: ASbGnctxH3sPHwiXvZkNa/fkkFrmxfUJuauFXL3mhpVsOyL8fls5MqcrPkdeh6PfEKj
 mBXz15CXsdud0D5+m/fVIJvnrZmcE6Y+hpASUo1wL37m5vZFU52l/Kv0nLGOp8OrcAJINo1FqwW
 YZvoOJ0CajoXYPJZu4SQmqbkwUusOSP/+FXOta7HTHfwAr/PhLFZmUCGmdeqnp/GPDCjkAGj32c
 iFdrpy5nL8StLBP1EOoyAjuLog0vDXNnN5+JwpGBF1KBGBdVT2g7KAaIsB6vC95/0dK9RVgx229
 DzEF2375EYs8/oRADlUO3K0QyDJysA3KCh81nmw/MAhBr7e1GVaivGYVpkDxyKozKuQHxt/klED
 IOSFm45bR2OcuNSkfHQbFRHWxjiws0r7NeorfyoxbOqStXXgTrkEzWMhZndArCaTjD/AmSNmiGi
 3ptCfNcE9X+12G3Abp6aJj5UBu0lJOQzgqo3et0MyLdAKdrKqvnc8brTY=
X-Google-Smtp-Source: AGHT+IH4/7VwL94/7NCqkNYPc5QAj0AwRTUKcNz0i+WpuOL/rZ5UwCe6PXIX3B3HnAcsZ+CDc2FoUw==
X-Received: by 2002:a05:7022:3a06:b0:11b:af12:b9f5 with SMTP id
 a92af1059eb24-11baf12bd97mr3188502c88.5.1763403607162; 
 Mon, 17 Nov 2025 10:20:07 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b060885eesm51684677c88.1.2025.11.17.10.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 10:20:06 -0800 (PST)
Date: Mon, 17 Nov 2025 10:20:04 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maayan Kashani <mkashani@nvidia.com>
Cc: <dev@dpdk.org>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Gregory Etelson <getelson@nvidia.com>
Subject: Re: [PATCH v2] app/testpmd: fix flex item link parsing
Message-ID: <20251117102004.713f1622@phoenix>
In-Reply-To: <20251116121437.159702-1-mkashani@nvidia.com>
References: <20251113201726.10597-1-mkashani@nvidia.com>
 <20251116121437.159702-1-mkashani@nvidia.com>
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

On Sun, 16 Nov 2025 14:14:37 +0200
Maayan Kashani <mkashani@nvidia.com> wrote:

> The flex_link_item_parse function was using FLEX_MAX_FLOW_PATTERN_LENGTH
> for all memcpy operations regardless of the actual flow item type. This
> could lead to copying incorrect amounts of data.
> 
> This patch adds a switch statement to determine the correct size based
> on the actual flow item type (IPv4, IPv6, UDP, TCP) and uses that size
> for the memcpy operations on spec, mask, and last fields.
> 
> Also adds validation to reject unsupported item types.
> 
> Fixes: 59f3a8acbcdb ("app/testpmd: add flex item commands")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>

Queued to next-net
