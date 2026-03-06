Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80863FCC04F
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 17:48:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EFD64066B;
	Fri,  6 Mar 2026 18:48:16 +0100 (CET)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id D04F540262
 for <dev@dpdk.org>; Fri,  6 Mar 2026 18:48:15 +0100 (CET)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-8c9f6b78ca4so1235354485a.0
 for <dev@dpdk.org>; Fri, 06 Mar 2026 09:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772819295;
 x=1773424095; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w9u0lucU3PcJeoB21padhUTn1arMqP1lat7gZsoSdbc=;
 b=KiTVf+Y1h+2sjR6pjmnypvN9NDXJUT4soo33dCb27CFC7lb8VMignHHTXzdstmJjmM
 754CvrUUrsigjGeujciSRpIxZKiWQfShekmqCoecc20bro4MB2mIlrjL9vXw37SM0JpN
 XOCugtZg6rNnmGB87+gXRPtItowqdebIC5P8+xKY2RY2RTooQX2VpMZf/QwznC0r/csm
 awfVqr0PkfRJtf4q+yFkfttNE5kzhlzEXTGYf2s0mUAlaT9TJo8yYzqnthstQ+dSZexd
 RPaVxWevQcVVnekA+Tt8SrmwW/7ouUt7E2qUPZR8xb1673Ln8vktR0Mgq9hDojJwVa4E
 pq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772819295; x=1773424095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w9u0lucU3PcJeoB21padhUTn1arMqP1lat7gZsoSdbc=;
 b=KBZ37Dy9XYiSb3Gc4jC/RN2t678LhWCqvHD/ywousbpzv1PgrIIHZW7d5cXStLHQuy
 GBirVtppUSM2/I9T00e/1wv6UIOkd3wBJ4LRShqhLRb+MxIy3t1pigysmV0f7BeLmSYm
 QYXHyV1zHgQOd/5MYuSU1Qi414qw+kZJ9wzvBcRWwxP/4CqE4yw4lSWAJkxihsdwBxoC
 1Tsc/4RRWBxQzFhwQIXBFZh3O8PnnG7ajYXLLdGHvDeHtEk9DfIDQrwTa8nTq9WoeWSP
 NKGtMO8OIvO1d4nACezhEOR7GCg6ZKv8lQLoh2uEahxx17+GAixtolXYFeJsc65MDfLw
 aKhw==
X-Gm-Message-State: AOJu0YxmMa6bjiaK2vrsjLDd5nVFSpiNX5wDbQHj/eFFrFXeM2tGWOBy
 GSSN8WrkIUchNTt9Pr9DFGrtbWRb3jGVK8aGHRGwm+BsCyfk/gRC7hHsx7CbNlY9vH8=
X-Gm-Gg: ATEYQzyLRkRyjY5Uec82Eh7rthp5jZXCaJgXqDDyWN/DxVTGPbP962u3AzdeKG0IO5Q
 qwiD9jO8aoCO01VIn5MlhHoln0EFVMS/zR6M/jJxIoTPCQq+5qkEQsgx/PUSNiXRishPp1hRz7U
 Uyim2vfi9fUq9RKTGcmP3j22FTzrYXflc7o5P857nuE4wS6sTcPJJdBLbBYzTUhA2l+aW9/D+AV
 yemKLcb3NHjkB5vPL5brK/cMM/Ix3IfNXy1BX0LJpvkBne2F7raSw4i5FoM3B7cYkpBBL0NYC+f
 pG0JVW1LtD1l4WVajvU2s6qN7Ss4r4TjIuQKOQ9+j49wD/poNw7UZoRf2uWsY/BX0FxpUvlPruE
 afWgcIAjXGsC0hlAPQEJU6GMqYTG0D3MJ8DvXUiWrqxgrK64faaDqUcy51yYeoOQw4fS868a0cj
 q6hqdvdqGpcNaZPRbSdN1lVmWLm0Twpe+U9SmQ16qfySFMkf5R2HB82aiaIK5JdKFm
X-Received: by 2002:a05:620a:1707:b0:8cb:4b1f:8155 with SMTP id
 af79cd13be357-8cd6d4fe2b1mr364484985a.58.1772819294937; 
 Fri, 06 Mar 2026 09:48:14 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f53bbbesm146555185a.25.2026.03.06.09.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 09:48:14 -0800 (PST)
Date: Fri, 6 Mar 2026 09:48:11 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com, david.marchand@redhat.com
Subject: Re: [PATCH v3 17/17] net/dpaa2: add devargs alternative for data
 stashing getenv
Message-ID: <20260306094811.0d7d3e66@phoenix.local>
In-Reply-To: <20260306133035.179709-18-maxime@leroys.fr>
References: <20260226143341.282188-1-maxime@leroys.fr>
 <20260306133035.179709-18-maxime@leroys.fr>
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

On Fri,  6 Mar 2026 14:30:35 +0100
Maxime Leroy <maxime@leroys.fr> wrote:

> The DPAA2_DATA_STASHING_OFF environment variable is used by customers
> to dynamically disable data stashing without rebuilding their
> application. Add a devargs option "drv_no_data_stashing" as an
> alternative, consistent with the existing devargs pattern (drv_loopback,
> drv_no_prefetch, drv_no_taildrop), while keeping the getenv for
> backward compatibility.
> 
> Move the check from dpaa2_dev_rx_queue_setup() to dpaa2_dev_init(),
> consistent with how other driver flags are handled.
> 
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>

FYI use of environment variables in drivers should have been more
strongly discouraged. In future will add that to automated review to
add adding environment variables as a warning.
